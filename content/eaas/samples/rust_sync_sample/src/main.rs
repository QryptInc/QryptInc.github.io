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

fn main() -> Result<()> {
    let client = reqwest::blocking::Client::new();
    let res = client.get("https://api-eus.qrypt.com/api/v1/quantum-entropy?size=1")
    .header("Authorization", "Bearer PLACE_JWT_HERE")
    .send()
    .unwrap();

    let response_json: EaasResponse = res.json()?;
    println!("{}", response_json.size);
    // array of random
    println!("{:?}", response_json.random);

    Ok(())
}
