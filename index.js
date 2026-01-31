import express from "express";

const app = express();
const PORT = process.env.PORT ?? 8080;

app.get("/", (req, res) => {
  return res.json({
    msg: "Hello Server is Running, with CICD pipline if it is working",
  });
});

app.listen(PORT, () => {
  console.log(`Server is Running at ${PORT}`);
});
