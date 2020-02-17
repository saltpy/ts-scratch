import { sampleFunction } from "../src";

describe("This is a simple test", () => {
    it("should echo input twice", () => {
        expect(sampleFunction("hello")).toBe("hellohello");
    });
});
