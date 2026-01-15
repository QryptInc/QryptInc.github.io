+++
menuTitle = "FAQs"
title = "Frequently Asked Questions"
date = 2021-10-07T14:05:15-04:00
weight = 80
disableToc = "true"
+++

**What should I do with my access token?**

Your access token is the mechanism by which your account will be charged for entropy data, and as such, it should be treated as secure and secret information (much as you would treat a password).

---

**I lost or forgot to save my access token. How can I retrieve it?**

To increase security, Qrypt only displays access tokens when they are first generated. If you have lost your token, you can contact Qrypt sales support at support@qrypt.com.

---

**What happens if my access token expires?**

After an access token expires, any quantum entropy service requests using that token will return an error code of 401. After an access token expires, any key generation SDK calls using that token will thow a CannotDownload exception. You will need to generate a new token and use it for future quantum entropy requests or key generation SDK calls.

---

**What happens if I have exceeded my monthly entropy quota?**

Once the monthly entropy quota has been reached, quantum entropy service requests will return an error code of 403. Once the monthly entropy quota has been reached, key generation SDK calls will thow a CannotDownload exception. Please contact Qrypt sales support at support@qrypt.com.

---

**I need more entropy bytes per month than my current quota provides.**

To increase your quota of entropy bytes you can generate per month, contact Qrypt sales support at support@qrypt.com.

---

**When does my entropy quota reset?**

Your quota is reset monthly on the day of the month on which you opened the account.

---

**How is quantum entropy different from rand, urand, grand, and other pseudorandom number generators?**

The generation of random and pseudorandom numbers is too large a topic to be covered thoroughly here, but the concepts are quite simple. There exist quantum behaviors that are completely random and unpredictable according to the laws of physics. By using a device called a homodyne laser interferometer—which can detect such quantum behaviors—Qrypt can generate and provide sequences of truly random data.

---

**How can I delete my Qrypt account?**

We do not currently support online cancellation of accounts. Please contact Qrypt Sales Support at support@qrypt.com to delete your account.

---
