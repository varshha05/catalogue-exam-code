function lagrangeInterpolation(xValues, yValues, xToEvaluate) {
    let total = 0;
    let k = xValues.length;

    for (let i = 0; i < k; i++) {
        let xi = xValues[i];
        let yi = yValues[i];
        let term = yi;
        for (let j = 0; j < k; j++) {
            if (i !== j) {
                let xj = xValues[j];
                term *= (xToEvaluate - xj) / (xi - xj);
            }
        }
        total += term;
    }

    return total;
}

function findConstantTerm(jsonInput) {
    let data = JSON.parse(jsonInput);
   
    let n = data.keys.n;
    let k = data.keys.k;
   
    let xValues = [];
    let yValues = [];

    for (let key in data) {
        if (key !== "keys") {
            let x = parseInt(key);
            let base = parseInt(data[key]["base"]);
            let y = parseInt(data[key]["value"], base);
            xValues.push(x);
            yValues.push(y);
        }
    }

    let c = lagrangeInterpolation(xValues, yValues, 0);
   
    return Math.round(c);
}

// Sample input
let jsonInput = `{
    "keys": {
        "n": 4,
        "k": 3
    },
    "1": {
        "base": "10",
        "value": "4"
    },
    "2": {
        "base": "2",
        "value": "111"
    },
    "3": {
        "base": "10",
        "value": "12"
    },
    "6": {
        "base": "4",
        "value": "213"
    }
}`;

let constantTerm = findConstantTerm(jsonInput);
console.log("The constant term c is:", constantTerm);

