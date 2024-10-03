Return-Path: <linux-arch+bounces-7678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A1F98F8CC
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 23:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495F91C216BE
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F551BFDFC;
	Thu,  3 Oct 2024 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="O9d7h89m";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cc8JiuAY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RAHeGt1K"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AAD1ABEA7;
	Thu,  3 Oct 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990318; cv=none; b=gdKIb9rPKCqXfclqLKGG9zzJ4v0qj1cc0L5ad2q+KXJwBQlT4qacJmXOz0qYReXG1zOXkuCSa2sZeqiOXRuBSufoFDvxotJlw1wlgZSqp+bfmfyr3iK1lSFlXJqoLqvhRcGNoUZWLcev2vZ6JTd0RixU2MVZUeg63KHopuSAI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990318; c=relaxed/simple;
	bh=HhmzzIqFovKlT/CUw9uX4DeNUzVDqpAizbPZxvENWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS0xWc/1c2emIIyS51VQM8XNNaMAFvmqSJo7rhkGXilXtct+qWXMOfe100VaaOYdgtn6z7To3+jnsyHSM0zhvPJgc991XZR4w/o45A/JmXijS3IMlJqqPzUfSIicdCeIbg0bhobJLI637+qLiZ4saPppBl3EuCiKZyeGBpvzTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=O9d7h89m; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cc8JiuAY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RAHeGt1K; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E5FA81380279;
	Thu,  3 Oct 2024 17:18:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 03 Oct 2024 17:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1727990313;
	 x=1728076713; bh=Ur4Aq+YlwAdsvGXOFs0gXLqiXWQpdrRi9S7N/offUuw=; b=
	O9d7h89mdBNEfquo1iYvfcdEagaJPy2do/3oiEEpV2HFU2KOS0I5wQ8VD9OfqIWO
	D8pfY1BQTdnNiEwtRDJo870i+Y4AjTVvAe5GIw3S7MWOALhcyx8qDqwUoFeBnWfY
	/77VKB/wIDsgm7/Ks2xEhkKMhn9PAhVrxkrzPNhIttE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727990313; x=
	1728076713; bh=Ur4Aq+YlwAdsvGXOFs0gXLqiXWQpdrRi9S7N/offUuw=; b=C
	c8JiuAY7sQXlBlxRCVuNbbeB//ArzLmUvLhkusO59HlnZag7F2ZtlvGGm93Si3Cm
	LLEeMFtoalTCR1An/OCkp3oDyACSz3PJtrRjAXTXSn5d2gFJH/PHBj/W0ExTWZot
	JM5f0dKVYJ/yPN/3d0LsYoJklJ+JhXHlQnYl/DDUsOfQhr0KEdA0yThEqJBR5x/Y
	uEgYCNyXSPymjr/JqIBONXnqvtc9MYkhs56jryehzWTWJx/LhbyORQM9v30siusB
	uUIFBMfG/J+dp/MiStWK3umytfzeduuazPVFAU30DNt5nl9FXPg8uWtTHHI5lpVZ
	vGc78bxMPn9OYqjF60+VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727990313; x=
	1728076713; bh=Ur4Aq+YlwAdsvGXOFs0gXLqiXWQpdrRi9S7N/offUuw=; b=R
	AHeGt1Kzag/ehSV1y10yC7bmQqlIhcV037RMH8EglGm2yRwZc71eR6VIJj+KL2kR
	mnhn+rGsqirkJnnjSAPulb9DFRuAMzjLtq8WFcz+P4HioOKs7M2DkYjp1N6Gv3fz
	wxg4RYBAH/xcOspdJZHl3w72quBlwN4TgHQxJEIGUY3mjcY5XxEYYt3zM6w4Hqaw
	Yz9NqU4WticB4j/m6mjbChsjZuFptSUBfaZgfdjdHQmNXsLb7WSYxWXdZfROo/cb
	Nv6S+h6vrqkJ3NGE7tUbJ4ZAgINHvJK0/uglNLepKHUIkdrUs6/VtrmiFTkITbqm
	0oN4f4b0RmTkVUa+CXARQ==
X-ME-Sender: <xms:KQr_Zg0Up_YfxX0wc56MDohikybNFr008s6Xmr2yFc1jidju3xycrA>
    <xme:KQr_ZrFTGStx27ovJTAnl7V5ZqqM4oK8h4ypgihYMQRPqHN6-QPbBUPwZqsHkucHn
    2GhE8g934w-rCZ_k3U>
X-ME-Received: <xmr:KQr_Zo4Ahrf1DZQi0V-DKTAIEzoBFNgfZXdIe9WPbtNg5m2M_AthgswaajXMN6PT-5no450hea6Ay29uZ4eM47Mj1vg9F5bm5X4mNX6jq1Ns5OyfYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefpihgtohhlrghsucfrihhtrhgvuceonhhitghosehflhhugihnihgtrd
    hnvghtqeenucggtffrrghtthgvrhhnpedtjeeuieeiheeiueffuddvffelheekleegkedu
    keeffffhudffudegvdetiefhteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghrtghpthht
    ohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrghrmhhlih
    hnuhigrdhorhhgrdhukhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghp
    thhtohepnhhpihhtrhgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KQr_Zp08WXROgj3onR2umbhNUfpI1zkyaPBSPxS81QsE0x9ob7KtIA>
    <xmx:KQr_ZjGhc_lyS0ThHfgB3sslqfP75zjXH76VYGOLAv_cNbMBs2smWw>
    <xmx:KQr_Zi9EILHEkNI-sckWNYwXdH5h1-GE2ZsdnSWoagFuqrW63mCpeg>
    <xmx:KQr_ZonT8HdTDckUUdKNGqBNuNQPaTopli2gNwuthmoHu9-bF-43iw>
    <xmx:KQr_Zo6W5Y_BF25Aiorm9agFB50-kq26_XAsWiCLecATVipBIKiU_4TB>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:18:33 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id B2601E3CD85;
	Thu,  3 Oct 2024 17:18:32 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] ARM: div64: improve __arch_xprod_64()
Date: Thu,  3 Oct 2024 17:16:15 -0400
Message-ID: <20241003211829.2750436-4-nico@fluxnic.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003211829.2750436-1-nico@fluxnic.net>
References: <20241003211829.2750436-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolas Pitre <npitre@baylibre.com>

Let's use the same criteria for overflow handling necessity as the
generic code.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 arch/arm/include/asm/div64.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 4b69cf8504..562d5376ae 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -56,6 +56,8 @@ static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 {
 	unsigned long long res;
 	register unsigned int tmp asm("ip") = 0;
+	bool no_ovf = __builtin_constant_p(m) &&
+		      ((m >> 32) + (m & 0xffffffff) < 0x100000000);
 
 	if (!bias) {
 		asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"
@@ -63,7 +65,7 @@ static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 			: "=&r" (res)
 			: "r" (m), "r" (n)
 			: "cc");
-	} else if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
+	} else if (no_ovf) {
 		res = m;
 		asm (	"umlal	%Q0, %R0, %Q1, %Q2\n\t"
 			"mov	%Q0, #0"
@@ -80,7 +82,7 @@ static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
 			: "cc");
 	}
 
-	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
+	if (no_ovf) {
 		asm (	"umlal	%R0, %Q0, %R1, %Q2\n\t"
 			"umlal	%R0, %Q0, %Q1, %R2\n\t"
 			"mov	%R0, #0\n\t"
-- 
2.46.1


