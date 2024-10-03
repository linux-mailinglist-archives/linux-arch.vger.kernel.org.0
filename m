Return-Path: <linux-arch+bounces-7677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBBA98F8C9
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 23:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A747F283BCA
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322CB1B85EA;
	Thu,  3 Oct 2024 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ZmvY9/Rg";
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZmYT8ULw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcamWM0V"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073611AD41F;
	Thu,  3 Oct 2024 21:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990317; cv=none; b=IYFWq+ey5TH3M2h4OfnHFlyn4hgvem9PqjGtC7zLhLiIbeIzTB+rkla7YftMQMLtPtc8cbJ52YrLo07GDUkLPMGyAJ0jItdO3+ky/OW12wsxKH4mbXzkyuzHDEtvM410N4KIbJUH4tFkmkoCkveZf7MOywijUBFQMsR0yCRk/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990317; c=relaxed/simple;
	bh=63tqb7jhbmMTqFgrye9w6beVOBgdli82xZXEtbLJ2BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6ymyZ+MSJnBkSP0Om8N918iPLW0/CyVXnwvtHCL8K5eNhMUHUE0cYSlaY5MlMmxaqke5/mxArYC9blsYKLvj0ncIojFi3rOCl+gH4pHJyOYJjMXaDidxU2Dt0PGYtBYPiL6pXb+jD81uDSlsClwcQ0moV6WGGLHXl1Jt3+XOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=ZmvY9/Rg; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZmYT8ULw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gcamWM0V; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA6191140195;
	Thu,  3 Oct 2024 17:18:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 17:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=2016-12.pbsmtp; t=1727990313;
	 x=1728076713; bh=gMZ287qsu4KPyQpfjhcSwVOet5c3sEaQsgFoRc8y1bA=; b=
	ZmvY9/Rge0mxNtiz/sSMhv0tD01DTYfhxhfuxkOtVGqO+0t1tCmOa0YYBiP8CZhc
	hGSQ1HOa23hy0R9e86YaDUPFk3zUAEakwww94oIIuYypK/yERBaVSuDKLZA7GwNY
	QhM/g2NBm3LmUZ8ZQ+Z9nAfj0MWFWzTEm0QzabLc9Uc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1727990313; x=
	1728076713; bh=gMZ287qsu4KPyQpfjhcSwVOet5c3sEaQsgFoRc8y1bA=; b=Z
	mYT8ULwss2c+A/pjkBrZD6fCVeZrwYYMJwcc5Wr3B8GOT3FxuzB4iXHp9JmCwgwJ
	lZFTUDucWHYAuP0shgbetZ2TLjH66N6lBwGqg4HwGrH2i8fhPYBwM3aXuYkuw0Ya
	IelH03O3UC5hD7XhEVpaw7XZWctgSGp1wgeiqBfVst3M4N4bARaSSMNvMQSI8kpw
	H6A7e4Fd847HrqAFB6FKFHMO50aSlzJ2PQMFPZSq5PgFHpLtbKYMNMANMda+9zFp
	fa5swZuUn5lAyKcqgiiJIx4KTatl3yall9Ew9HF/LwETiXukCFvf89j1O5c5vOfG
	WYr9bm0k0enmQPsgpzYqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727990313; x=
	1728076713; bh=gMZ287qsu4KPyQpfjhcSwVOet5c3sEaQsgFoRc8y1bA=; b=g
	camWM0Vzi9BRleGJKPImBbKSdBgC+3BrhGWlGMO8epC3K7c60myvx0MDDVWB5zK/
	N7LzgszvH7+hnFqw7+zUxCmShb8VBCYqWtu1LrIDPWyVlrA1tcivuDArRSfrKVsd
	LP2XilRLpo7x2STxYBHhX/KguW83uMsmKBzpx3SvQPYmq54PtS/3thZzEg2gN1SB
	HcJ4qVsoWUPTLfCGC2IlsYC0+/hAOegXMjk55YQPBXQb6962By6OijjhTBcuwyJ6
	Xc+hB7V79aSAd9wzdn9P6gkQxclHyvrNouw1c+HnpnBIEW0k5taX8T/ZGAw8soFC
	k2xvUamAmO0r+OdraJ3VQ==
X-ME-Sender: <xms:KQr_ZlzuXdp3w_PiQWWaoIV_pT5lx8jDsVF6tj0DHOtejo1OEcqu4A>
    <xme:KQr_ZlRB6yos6GzcmmDNkLf06kyvFFubGT_0oFnpREObNXCMFaQ3_gUoVRrGy2S17
    _ekMq0hs1t3mmju9d8>
X-ME-Received: <xmr:KQr_ZvWgrKv48bNBFbWkrVQcqAIYrHMZyO9NvKLm6FV5GPK7WRKTSNiuZKeJxQnSVtt7m6FUHwPNeVyfqP7cIeryTUZj3nqK1fGuTeSHzozOSSzmvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudeitdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:KQr_ZngS3E0fKXECEZ4Mmwyk_RpLucRyQSrUanNDe0Fdyw2BOSU10A>
    <xmx:KQr_ZnBxLzLY7LejpF8_xvXkZ0gtxnSbMKvT2S5sVshQfWuEngNmLQ>
    <xmx:KQr_ZgKJRDK_dkhEaf6ZyH8lo15J-AxacqHlPoUYYJkNP-eRetaEDA>
    <xmx:KQr_ZmCzu3bEI-1HKnw8cWmT3clpO-LQyqQwMy2Sb45VKgqZZd-SJA>
    <xmx:KQr_Zp2i01qTrB2qdlChtkwZ_D3oBY9hpIWJBD7G2WqLLsOV9eu81KQO>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 17:18:33 -0400 (EDT)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 8B720E3CD83;
	Thu,  3 Oct 2024 17:18:32 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] lib/math/test_div64: add some edge cases relevant to __div64_const32()
Date: Thu,  3 Oct 2024 17:16:13 -0400
Message-ID: <20241003211829.2750436-2-nico@fluxnic.net>
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

Be sure to test the extreme cases with and without bias.

Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
---
 lib/math/test_div64.c | 85 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 2 deletions(-)

diff --git a/lib/math/test_div64.c b/lib/math/test_div64.c
index c15edd688d..3cd699b654 100644
--- a/lib/math/test_div64.c
+++ b/lib/math/test_div64.c
@@ -26,6 +26,9 @@ static const u64 test_div64_dividends[] = {
 	0x0072db27380dd689,
 	0x0842f488162e2284,
 	0xf66745411d8ab063,
+	0xfffffffffffffffb,
+	0xfffffffffffffffc,
+	0xffffffffffffffff,
 };
 #define SIZE_DIV64_DIVIDENDS ARRAY_SIZE(test_div64_dividends)
 
@@ -37,7 +40,10 @@ static const u64 test_div64_dividends[] = {
 #define TEST_DIV64_DIVISOR_5 0x0008a880
 #define TEST_DIV64_DIVISOR_6 0x003fd3ae
 #define TEST_DIV64_DIVISOR_7 0x0b658fac
-#define TEST_DIV64_DIVISOR_8 0xdc08b349
+#define TEST_DIV64_DIVISOR_8 0x80000001
+#define TEST_DIV64_DIVISOR_9 0xdc08b349
+#define TEST_DIV64_DIVISOR_A 0xfffffffe
+#define TEST_DIV64_DIVISOR_B 0xffffffff
 
 static const u32 test_div64_divisors[] = {
 	TEST_DIV64_DIVISOR_0,
@@ -49,13 +55,16 @@ static const u32 test_div64_divisors[] = {
 	TEST_DIV64_DIVISOR_6,
 	TEST_DIV64_DIVISOR_7,
 	TEST_DIV64_DIVISOR_8,
+	TEST_DIV64_DIVISOR_9,
+	TEST_DIV64_DIVISOR_A,
+	TEST_DIV64_DIVISOR_B,
 };
 #define SIZE_DIV64_DIVISORS ARRAY_SIZE(test_div64_divisors)
 
 static const struct {
 	u64 quotient;
 	u32 remainder;
-} test_div64_results[SIZE_DIV64_DIVISORS][SIZE_DIV64_DIVIDENDS] = {
+} test_div64_results[SIZE_DIV64_DIVIDENDS][SIZE_DIV64_DIVISORS] = {
 	{
 		{ 0x0000000013045e47, 0x00000001 },
 		{ 0x000000000161596c, 0x00000030 },
@@ -65,6 +74,9 @@ static const struct {
 		{ 0x00000000000013c4, 0x0004ce80 },
 		{ 0x00000000000002ae, 0x001e143c },
 		{ 0x000000000000000f, 0x0033e56c },
+		{ 0x0000000000000001, 0x2b27507f },
+		{ 0x0000000000000000, 0xab275080 },
+		{ 0x0000000000000000, 0xab275080 },
 		{ 0x0000000000000000, 0xab275080 },
 	}, {
 		{ 0x00000001c45c02d1, 0x00000000 },
@@ -75,7 +87,10 @@ static const struct {
 		{ 0x000000000001d637, 0x0004e5d9 },
 		{ 0x0000000000003fc9, 0x000713bb },
 		{ 0x0000000000000165, 0x029abe7d },
+		{ 0x000000000000001f, 0x673c193a },
 		{ 0x0000000000000012, 0x6e9f7e37 },
+		{ 0x000000000000000f, 0xe73c1977 },
+		{ 0x000000000000000f, 0xe73c1968 },
 	}, {
 		{ 0x000000197a3a0cf7, 0x00000002 },
 		{ 0x00000001d9632e5c, 0x00000021 },
@@ -85,7 +100,10 @@ static const struct {
 		{ 0x00000000001a7bb3, 0x00072331 },
 		{ 0x00000000000397ad, 0x0002c61b },
 		{ 0x000000000000141e, 0x06ea2e89 },
+		{ 0x00000000000001ca, 0x4c0a72e7 },
 		{ 0x000000000000010a, 0xab002ad7 },
+		{ 0x00000000000000e5, 0x4c0a767b },
+		{ 0x00000000000000e5, 0x4c0a7596 },
 	}, {
 		{ 0x0000017949e37538, 0x00000001 },
 		{ 0x0000001b62441f37, 0x00000055 },
@@ -95,7 +113,10 @@ static const struct {
 		{ 0x0000000001882ec6, 0x0005cbf9 },
 		{ 0x000000000035333b, 0x0017abdf },
 		{ 0x00000000000129f1, 0x0ab4520d },
+		{ 0x0000000000001a87, 0x18ff0472 },
 		{ 0x0000000000000f6e, 0x8ac0ce9b },
+		{ 0x0000000000000d43, 0x98ff397f },
+		{ 0x0000000000000d43, 0x98ff2c3c },
 	}, {
 		{ 0x000011f321a74e49, 0x00000006 },
 		{ 0x0000014d8481d211, 0x0000005b },
@@ -105,7 +126,10 @@ static const struct {
 		{ 0x0000000012a88828, 0x00036c97 },
 		{ 0x000000000287f16f, 0x002c2a25 },
 		{ 0x00000000000e2cc7, 0x02d581e3 },
+		{ 0x0000000000014318, 0x2ee07d7f },
 		{ 0x000000000000bbf4, 0x1ba08c03 },
+		{ 0x000000000000a18c, 0x2ee303af },
+		{ 0x000000000000a18c, 0x2ee26223 },
 	}, {
 		{ 0x0000d8db8f72935d, 0x00000005 },
 		{ 0x00000fbd5aed7a2e, 0x00000002 },
@@ -115,7 +139,10 @@ static const struct {
 		{ 0x00000000e16b20fa, 0x0002a14a },
 		{ 0x000000001e940d22, 0x00353b2e },
 		{ 0x0000000000ab40ac, 0x06fba6ba },
+		{ 0x00000000000f3f70, 0x0af7eeda },
 		{ 0x000000000008debd, 0x72d98365 },
+		{ 0x0000000000079fb8, 0x0b166dba },
+		{ 0x0000000000079fb8, 0x0b0ece02 },
 	}, {
 		{ 0x000cc3045b8fc281, 0x00000000 },
 		{ 0x0000ed1f48b5c9fc, 0x00000079 },
@@ -125,7 +152,10 @@ static const struct {
 		{ 0x0000000d43fce827, 0x00082b09 },
 		{ 0x00000001ccaba11a, 0x0037e8dd },
 		{ 0x000000000a13f729, 0x0566dffd },
+		{ 0x0000000000e5b64e, 0x3728203b },
 		{ 0x000000000085a14b, 0x23d36726 },
+		{ 0x000000000072db27, 0x38f38cd7 },
+		{ 0x000000000072db27, 0x3880b1b0 },
 	}, {
 		{ 0x00eafeb9c993592b, 0x00000001 },
 		{ 0x00110e5befa9a991, 0x00000048 },
@@ -135,7 +165,10 @@ static const struct {
 		{ 0x000000f4459740fc, 0x00084484 },
 		{ 0x0000002122c47bf9, 0x002ca446 },
 		{ 0x00000000b9936290, 0x004979c4 },
+		{ 0x000000001085e910, 0x05a83974 },
 		{ 0x00000000099ca89d, 0x9db446bf },
+		{ 0x000000000842f488, 0x26b40b94 },
+		{ 0x000000000842f488, 0x1e71170c },
 	}, {
 		{ 0x1b60cece589da1d2, 0x00000001 },
 		{ 0x01fcb42be1453f5b, 0x0000004f },
@@ -145,7 +178,49 @@ static const struct {
 		{ 0x00001c757dfab350, 0x00048863 },
 		{ 0x000003dc4979c652, 0x00224ea7 },
 		{ 0x000000159edc3144, 0x06409ab3 },
+		{ 0x00000001ecce8a7e, 0x30bc25e5 },
 		{ 0x000000011eadfee3, 0xa99c48a8 },
+		{ 0x00000000f6674543, 0x0a593ae9 },
+		{ 0x00000000f6674542, 0x13f1f5a5 },
+	}, {
+		{ 0x1c71c71c71c71c71, 0x00000002 },
+		{ 0x0210842108421084, 0x0000000b },
+		{ 0x007f01fc07f01fc0, 0x000000fb },
+		{ 0x00014245eabf1f9a, 0x0000a63d },
+		{ 0x0000ffffffffffff, 0x0000fffb },
+		{ 0x00001d913cecc509, 0x0007937b },
+		{ 0x00000402c70c678f, 0x0005bfc9 },
+		{ 0x00000016766cb70b, 0x045edf97 },
+		{ 0x00000001fffffffb, 0x80000000 },
+		{ 0x0000000129d84b3a, 0xa2e8fe71 },
+		{ 0x0000000100000001, 0xfffffffd },
+		{ 0x0000000100000000, 0xfffffffb },
+	}, {
+		{ 0x1c71c71c71c71c71, 0x00000003 },
+		{ 0x0210842108421084, 0x0000000c },
+		{ 0x007f01fc07f01fc0, 0x000000fc },
+		{ 0x00014245eabf1f9a, 0x0000a63e },
+		{ 0x0000ffffffffffff, 0x0000fffc },
+		{ 0x00001d913cecc509, 0x0007937c },
+		{ 0x00000402c70c678f, 0x0005bfca },
+		{ 0x00000016766cb70b, 0x045edf98 },
+		{ 0x00000001fffffffc, 0x00000000 },
+		{ 0x0000000129d84b3a, 0xa2e8fe72 },
+		{ 0x0000000100000002, 0x00000000 },
+		{ 0x0000000100000000, 0xfffffffc },
+	}, {
+		{ 0x1c71c71c71c71c71, 0x00000006 },
+		{ 0x0210842108421084, 0x0000000f },
+		{ 0x007f01fc07f01fc0, 0x000000ff },
+		{ 0x00014245eabf1f9a, 0x0000a641 },
+		{ 0x0000ffffffffffff, 0x0000ffff },
+		{ 0x00001d913cecc509, 0x0007937f },
+		{ 0x00000402c70c678f, 0x0005bfcd },
+		{ 0x00000016766cb70b, 0x045edf9b },
+		{ 0x00000001fffffffc, 0x00000003 },
+		{ 0x0000000129d84b3a, 0xa2e8fe75 },
+		{ 0x0000000100000002, 0x00000003 },
+		{ 0x0000000100000001, 0x00000000 },
 	},
 };
 
@@ -208,6 +283,12 @@ static bool __init test_div64(void)
 			return false;
 		if (!test_div64_one(dividend, TEST_DIV64_DIVISOR_8, i, 8))
 			return false;
+		if (!test_div64_one(dividend, TEST_DIV64_DIVISOR_9, i, 9))
+			return false;
+		if (!test_div64_one(dividend, TEST_DIV64_DIVISOR_A, i, 10))
+			return false;
+		if (!test_div64_one(dividend, TEST_DIV64_DIVISOR_B, i, 11))
+			return false;
 		for (j = 0; j < SIZE_DIV64_DIVISORS; j++) {
 			if (!test_div64_one(dividend, test_div64_divisors[j],
 					    i, j))
-- 
2.46.1


