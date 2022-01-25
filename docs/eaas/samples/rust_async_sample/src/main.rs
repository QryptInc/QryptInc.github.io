use error_chain::error_chain;
use serde::Deserialize;

#[derive(Deserialize)]
struct EaasResponse {
    random: Vec<String>,
    size: i32,
}

error_chain! {
    foreign_links {
        Io(std::io::Error);
        HttpRequest(reqwest::Error);
    }
}

#[tokio::main]
async fn main() -> Result<()> {
    let client = reqwest::Client::new();
    let res = client.get("https://api-eus.qrypt.com/api/v1/quantum-entropy?size=1")
    .header("Authorization", "Bearer PLACE_JWT_HERE")
    .send()
    .await?;
    println!("Status: {}", res.status());
    println!("Headers:\n{:#?}", res.headers());

    let response = res.json::<EaasResponse>().await?;
    println!("{}", response.size);
    // array of random
    println!("{:#?}", response.random);
    Ok(())
}