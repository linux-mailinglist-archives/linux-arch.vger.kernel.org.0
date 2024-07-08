Return-Path: <linux-arch+bounces-5311-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E24929A88
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 03:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5691F211AD
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jul 2024 01:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898FAD2C;
	Mon,  8 Jul 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PTzdWbTB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="i2vIPkS8"
X-Original-To: linux-arch@vger.kernel.org
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543C6116;
	Mon,  8 Jul 2024 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720402080; cv=none; b=SiKzts5MCmfgYlwbTM15pw/DYgDuJSVm9qMK/MaioerPaDOX0WA6/h5YZT2SuaWW+Rz3bFiOwRPvO2/C+aev1pq6kgnc+n7sSrLWze2dloBBnj6uDGlkQbui5RrdVHrRkKmghFZa+3at0aloMAwMLiO1fRvHLfPAo/MahfUfMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720402080; c=relaxed/simple;
	bh=DQ1QAacvuwMrmpkxxbOR3zurnYTNDoQ2zsyiFBbAL1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2YMZrGaWIrRIgG4BlXPnFjXsyqchtOxWo7fz1j9jtIGefkUTr6WueUsFylDdBOq+kqyZdz7Ff5imXSnllSljhQN+1Cue3/BrB2ik6boc3TxEDB15Wkk7Ad1JkTN/CuglORmXX7tCPdC84ekU5GLxvF1X/gcUXHk9ePAULVMzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PTzdWbTB; dkim=fail (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=i2vIPkS8 reason="signature verification failed"; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EBF8C305D9;
	Sun,  7 Jul 2024 21:27:57 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=DQ1QAacvuwMrmpkxxbOR3zurn
	YTNDoQ2zsyiFBbAL1g=; b=PTzdWbTBjXmYXeo+yjfiQMLkyltWAb2PXkO4P9NRi
	IJ3SInEjJyhbdV2uxKGrGtt3O4CeEg8kzEiY0mQA/60KjdOU9L3KMOucBflw6Qqn
	kQeNeslEhl2EhuAyaDdp4Q+054ch4DJTZuClxinNBnUzUxCKsJ6bT3B6uwmOBWH1
	7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E3918305D8;
	Sun,  7 Jul 2024 21:27:57 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=2016-12.pbsmtp; bh=9vregTxqV1G6NmQ0sYraOAMwCNG3P0fo7gosidspjcs=; b=i2vIPkS8st3uYyw7KT4nQTxm23roJDy4OKbtfctwQchKnaKzu6CpYJTMmDeLo66T/vked6GKHtRhUX33wd+O+6nB3SPnKJHWzJ9n+gZvCV9kU44XbQOmFKFsqa6mFxGJZQm5xGW67gh5Z00mhWwanKQc7figWu8GirvcC4rDQoM=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8F57305D6;
	Sun,  7 Jul 2024 21:27:53 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu.lan (OpenWrt.lan [192.168.1.1])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 75F29D3BCFE;
	Sun,  7 Jul 2024 21:27:51 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Nicolas Pitre <npitre@baylibre.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] lib/math/test_div64: add some edge cases relevant to __div64_const32()
Date: Sun,  7 Jul 2024 21:27:14 -0400
Message-ID: <20240708012749.2098373-2-nico@fluxnic.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708012749.2098373-1-nico@fluxnic.net>
References: <20240708012749.2098373-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 4C491FB8-3CC9-11EF-BD15-C38742FD603B-78420484!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

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
@@ -26,6 +26,9 @@ static const u64 test_div64_dividends[] =3D {
 	0x0072db27380dd689,
 	0x0842f488162e2284,
 	0xf66745411d8ab063,
+	0xfffffffffffffffb,
+	0xfffffffffffffffc,
+	0xffffffffffffffff,
 };
 #define SIZE_DIV64_DIVIDENDS ARRAY_SIZE(test_div64_dividends)
=20
@@ -37,7 +40,10 @@ static const u64 test_div64_dividends[] =3D {
 #define TEST_DIV64_DIVISOR_5 0x0008a880
 #define TEST_DIV64_DIVISOR_6 0x003fd3ae
 #define TEST_DIV64_DIVISOR_7 0x0b658fac
-#define TEST_DIV64_DIVISOR_8 0xdc08b349
+#define TEST_DIV64_DIVISOR_8 0x80000001
+#define TEST_DIV64_DIVISOR_9 0xdc08b349
+#define TEST_DIV64_DIVISOR_A 0xfffffffe
+#define TEST_DIV64_DIVISOR_B 0xffffffff
=20
 static const u32 test_div64_divisors[] =3D {
 	TEST_DIV64_DIVISOR_0,
@@ -49,13 +55,16 @@ static const u32 test_div64_divisors[] =3D {
 	TEST_DIV64_DIVISOR_6,
 	TEST_DIV64_DIVISOR_7,
 	TEST_DIV64_DIVISOR_8,
+	TEST_DIV64_DIVISOR_9,
+	TEST_DIV64_DIVISOR_A,
+	TEST_DIV64_DIVISOR_B,
 };
 #define SIZE_DIV64_DIVISORS ARRAY_SIZE(test_div64_divisors)
=20
 static const struct {
 	u64 quotient;
 	u32 remainder;
-} test_div64_results[SIZE_DIV64_DIVISORS][SIZE_DIV64_DIVIDENDS] =3D {
+} test_div64_results[SIZE_DIV64_DIVIDENDS][SIZE_DIV64_DIVISORS] =3D {
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
=20
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
 		for (j =3D 0; j < SIZE_DIV64_DIVISORS; j++) {
 			if (!test_div64_one(dividend, test_div64_divisors[j],
 					    i, j))
--=20
2.45.2


