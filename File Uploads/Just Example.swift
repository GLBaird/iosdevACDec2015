

//  talk to registration end point
Just.post(
    "http://justiceleauge.org/member/register",
    data: ["username": "bob", "password":"bob"],
    files: ["profile_photo": .URL(fileURLWithPath:"flash.jpeg", nil)]
    ) { (r)
        if (r.ok) { /* success! */ }
}