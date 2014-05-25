define(['angular'], function(ng) {
  describe('angular 컨텍스트', function() {
    it("버전 확인", function() {
      expect(ng.version).toBeDefined();
      expect(ng.version.full).toEqual("1.3.0-beta.10");
    });
  });
});