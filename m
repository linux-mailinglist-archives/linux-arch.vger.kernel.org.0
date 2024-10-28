Return-Path: <linux-arch+bounces-8647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBA19B3204
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFF2282F04
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5119C1DC04B;
	Mon, 28 Oct 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Q2Gh5pwq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="g8l0aSxo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA871DDC13
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 13:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123033; cv=fail; b=HD/VzxpkUevAP7VFhO+kpu2dOo4aKWXcE6GEaP/ubFXgKGAEmc65yx68vdlS8aGBXSw0iWBwk1e/B56oNTLQ0DCtzxZmD0b7uf7Iw6wEV+2uYwfi8DI8UxF6J0KD34S4fTcLa7u/ufTAFvX66lfwAZPc2vwSvvyO0mqF8JpyVks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123033; c=relaxed/simple;
	bh=SK40+kQmmYe34MUXIQFA+C1X8leWHhF6rdjFQ/RSa14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZXRQz9oEkQ0PUMnq0eUFjb7HmmpeZ0Qx1YL/dITRabwbiTxxeMU3JDM6ZGtbSrAGYbNqzCPuCdETBdHy5Zq2KKz1k906zJDrKVJFi2fwBRtGn14bzLoF6YYovhioMTkoos2tNkAd4PeXNvXeusGuXa5gTjAAAHS822vO+y+EzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Q2Gh5pwq; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=g8l0aSxo reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 4722530F2FA
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 14:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1730122967;
	bh=SK40+kQmmYe34MUXIQFA+C1X8leWHhF6rdjFQ/RSa14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q2Gh5pwqBmk3qWEtGleAFpdQXAOaajbVHvYeh5gEbLZJyQ7lI+Ls/LDxdiyifB6RA
	 pej1m6VD5DwVKwrDZp9fyRdtVNp2kP3OE+W5UVY6+PUt8piWdEMxFcAr5hlSIBnPte
	 3/dWMRK0TY173qjGoI0Ep7KXPqlFjJ2R3ITuD6XU=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id 8D61E30F2CE; Mon, 28 Oct
 2024 14:42:46 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012055.outbound.protection.outlook.com
 [40.93.76.55]) by fx305.security-mail.net (Postfix) with ESMTPS id
 8C78130F097; Mon, 28 Oct 2024 14:42:44 +0100 (CET)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2397.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 13:42:42 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8093.024; Mon, 28 Oct
 2024 13:42:42 +0000
X-Secumail-id: <125b6.671f94d4.899d0.2>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+RW0ezMThZ0S9oCV6hxhsJqsD8AZjXzHQJXQEaiV694HfaFqOBGh0CD6Pv+EOWokX2FTR/ORzkrQ9wZ9YJCvPZHO6tGnPIoW/ieRMXUtqrN8wA5Bskb43PvmUxhLngA66YQjS4wqESe7wVrqSqH5X4rftMAWMFOJ+Q3klu3clfdcQXnM968CZm0J1W4zOvN7H4VAVK+Qr3Mp3Yecl3aMOd1t/Eo0vjtOGNn3Rz1mY394qfUvjBuROMaCcK3XKd/cdOAmZkhHKA2VtnK9JjjrvKzRaT/GInnp1ri8gAdVOhwqSraqHjp8+2PJXfGEtMTAu5gl0u4VaqEwj8aSF3Z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0QkuTHZTyP/OL+vuMUAVq++z1k090MBBOJMEXDdFz2c=;
 b=Wc7GhSD6lQFjGU+SuIEJyI/rdZq3NDyi1PB0ZF0f8BDtxcElOJnvLtp1vRntzwFDlI1s903pVGbXgR8imSMldJEE+mjmMtmK5Jpz8VI15Chb8kT+gDTy/jCu9Pb4GASso9PWxsZB1SyYlamzkIG63cykEG44SZc34ISSazflE98iajQwBl1J6EbLM22UEYQ6+kPw1bEAlsZwXaCbjHhlLrST9fcKqDBm20A4vu/2aPvvdBgP3l03K2Ox3g2kO6/UD1dcSeV59inY+lebTXpnMomikdzrOsAEXd/6Z42f9jnk1gk9D1Kce2LQTrNMq6vYsZDDOG5wOanmp7t3bXaP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0QkuTHZTyP/OL+vuMUAVq++z1k090MBBOJMEXDdFz2c=;
 b=g8l0aSxoTPojjY4Xa0iPWvblOwUxpKqEm6Yvog0ttHoohT261Q1ImG7kdNo2d8TYjeuOa/Hw4sk00N1C1mufYExNcG5yCa4jeGfQfHfEQwiPOqbuOtpHm75bXzDUQXft9NiVJ3Gept9IqUNGj6K0aHQ3jI80gvye3zJajkG4hLnA7Tb023rf4KGJy5KKVjm5kcmpuOGNwmvO3PtNk5vGeZiZ2UKHWvDmsh7zW7mVoPswfP3c5MgLTrbOpzgqNclT8rbBRi7LInBPYHzRb6frb1Z5A48QN78xI0UQia7C80WYPSmKjUZX+3mEiOy2LGP1euaBHn0a8fs+Dhuzu1Vanw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Takashi Iwai <tiwai@suse.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 David Laight <David.Laight@aculab.com>, Johannes Berg
 <johannes@sipsolutions.net>, Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-arch@vger.kernel.org, Yann Sionneau <ysionneau@kalrayinc.com>, Julian
 Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v11 2/4] arm64: Use new fallback IO memcpy/memset
Date: Mon, 28 Oct 2024 14:42:25 +0100
Message-ID: <20241028134227.4020894-3-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028134227.4020894-1-jvetter@kalrayinc.com>
References: <20241028134227.4020894-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0037.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::26) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PAZP264MB2397:EE_
X-MS-Office365-Filtering-Correlation-Id: 97681da1-0ec8-4773-16b6-08dcf75665ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: M7NdEqZdvzUNRZZSJDcDDXMgG98bsYNdONhWHvabSMTAEf4AIU77FPnePDL47S88ql6OhQwonOLOnUyFzEhkiAi7jSTWdoWVbzJsuyeBjX1mXXzGQsvSB0a43KDKYKvfwhDchymG2isehCZ/uI8PpcgsL+JmyVRF/EOrX7X25PAplZnmiwNVZyLLzsUMev9we4ISQX3QOzV1W1E2YZ+cGjLylio0Lkq6AbaqUVrMmbtelIPyYck5MJAW1oYUkEJvCsp7pfsSCdGTx+SzNOX2PfVe4i1AOH2LMDF+Dg79njZa0dUdTF+UQ03Z63FU50JFTkzQrinjVIy5Epx9w60P1wLY3ai84OqFg9FDQJCq5xgEtCAdDtiG6GDNOIG+P8OEwUvQZ/9IHsSTdPWiS1gIgt2DDttAk5n0HTBs66LwVcz18k6iL0hrusiyJOwvnGSx6PVXEh4gA3pu8YSVGHPCo7tSy8UEoO1fznvo0SUkpWAuYD4o/OkoLz6piLpvOFlysfnfOye0AvBUubkNe2R9saYyngl1jnsmkAc7fj7/YnnlwVLreNa29htjTBciPweXyTMJMLr6Qjbxj6y6/Lu9FTKLJN9Mf+toppT0QpCqYOnUMjj5n8gx9itqpUsoBumHGqj1g7V3h+zFLGdc9TgWsnWHF92sZ8uAW0B2Phx+9CHjCTKnxUmpA/ixyDsNnxtN8YdyjX4q5ZCcX9ZKzU5ScBNEnPViU54jr9sfvj0D8K83vTXs/cBER79yACYBM2aURKu7G8oTl0gpDsiz+yGp8Qps4HOSelKcO0Z9fGoE89Ts/e218+2yGcWRwFGf/PLnSsYGwP4J1TmUo++BG5R8zZ86Ks80IYOjGq0Pj/R5Ur/hvFE3F4/x2DZ/4rQGUk0wvV0eo7eVmDMXvhZORUtiUbJB5uYnBkudF/xvCehqUKOvciKug8B9ojouRU9qQlma4Gv
 4l/UbLdR78AZ7clNIDWjPQR9Syou8sdPIHMjnfgoT9HdGsHTZ/pEkHAX64K4BO7VFD0iIwRgSzxW8b6CETc1e0CF2eUKy9H0dHj5NPSmiiMFqZAXV589JhTi1MtldkflI4I4ndzsw710iK6MJ53JYSZd87BMOsOFjkEIO6gu6qvEKSq0RvIYMr/v5yUTJROwGavWg4yLv1KE0HjKR7Gjk0BzxN97dQ8qpv08KtrrTn3wi0miqM6yQ+Na20QVzPyZcPsuyfO4rRGsiU3sZtph600gN3UMFVOon9kf3+UGgGYUN6G1AJmLs86c5dN5lXn8O1Z4x0RP6sw8cgnfsrEb+S/6tScJxYtuXNhnyFKs1nS9KxC3axu2ueNVVArWFbIXKNOG3R8yvBQPKHOSIUBEvcb7PiOkHwNbwVpgkTSq9xSCOyw1PxCJULPwhboMr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TGyYVr2+y9tW75auuQKk9nOKRo0KZ9zcabxPt37mlS27vcIz+Vr/K6zb3jxD/35kvmcnv0aqFpM3aikD0s8Zk8vBxGnGoeiGd7LnbZMGdAGsP5AIDMBtUT6gUafSJSPuNtkuc1JKokEObQj/NmnsmY7vJESSikeSZdzqoJoFJyHKy2UytWPMweixsllPDfwna5wqcTROmJOo/sLeITRGfb3/LjpbRK9TuJqlNRy0x60lE+KiF8VXIwlE5bp9qw/3whaI5/dNd5TrS0VavMTmC3LT/m1mQRKMbbyUI66NhBCfYetVSwZkI+OJ6vgYWpQhXuqBMMHTjVvD5NTMabau+jhw+9Hi4crPSLNPyRwEk16c4Ij0StU3h6RLqdowjS/kmoKwCcyfj1a7Vyp1+gtiipPU8OuPqDRtfjR03OrEAA00sh/iNX16AWdjmSanZpEv3JBOWHX+uzTWkFAyxzIWqqLLDoPIXpT3l+C0dTiVJnn+LUNpOfUclpMDUQePRgwVvJpmZQeFzVmmipqpcrHCHKTrifqlLtnpxiAdJG6LANarhV4BSKQ4ag82MdADuY+0SAXuw/odXjROS3yzumx4X2lfOWRTk0ibXbH+Ul0cGgw+kfkT8DcgWZ0fgZ8+tdQXPAm0yc/jvwHMIXJqorIePqi/dOt0otUsunIrMIlmqxctiLSh3A12ZN9csVgLUX0d167ZqQkbix3PJ2b84Nrd0r8YJ5rFaqGWpSnZ7Je07qDIGxKxYE+EZFWXyQZoi/qu85289/Y/ls1wk8Lh/wnVuKNLLU4v/tFnoynpC2LXSa08+7VwhN2af5Qpzi+aozefgf6sekBVpaN0np3IPJwPe3w9lWJNA8vhF0D1eeAZ/ARMqEAR/fm040+9qIYqL4DVpi/aQqoBEBz7HDv8VAO2J85NzM48c/TtLB/wxlWamiDKSR8rliYQKW+thK4KUe2c
 5bx+50YaIcCAHcHAINuixs27y3Pii9txnK3UZqJdNRBWYgc27lFweTq7wxNPzVCMCKdEb4wZsOCLHcgWBC5gsDbPIzqEHNTtld679+podVhHx2Qw+CyFfx55wkf1ozhKx0G4qaXMMZ8uNA2kNrE2bv6EmonxjZ4VpzWGRa1LoKacOWM2GiIrzGEgzN2gN3FSiA3Nyu+97Qomx91onZkGNYg+JIHTaoeyA44mVNtyx39nrj5b8SCdvXEdIv3rddr0hQPgU9YyGck6VSC3BMS+kRvS36JOF3AKZb4cpLqtx2HJYSNspBR11GadTpTUga3bn5SdUCgEYlSUWpRSlfiSlaaxRQHUEyHshFBa8p+X4QwFgf7xIfJECuPGFsimPKlvgtiHPTwLoUWe2OhUJg0vR700vdT4JLJlbQ/PG7Jeo4QozNF4BocFQgDO9P0iraysIEDB1k6FpMKHzliCNUcA6tBdgNWMcEAlY+iNPp54fHFELjZAD+HfdQJsdgNxuFLvP/EuByzAG3/M9uolEt8kFymk75Yu2+icPxULlw1YxsuSKBDkmoh9LH9Uf/MDfTa7vN3DMaldmsCKvRPHvJYvatFgiwg+9uFILUdywGnbuZXubzg+Jf2nrLLo1ojLTBV1
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97681da1-0ec8-4773-16b6-08dcf75665ba
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:42:42.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J+QfXw4XLffdYJ5GDuCOogtEVjMevR9UIG9Tp0b+5fdVQcletKsrVWb1350bcof5RTllVRJecFfoFLtMG2c/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2397
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the new fallback memcpy_{from,to}io and memset_io functions from
lib/iomem_copy.c on the arm64 processor architecture.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v11:
- Updated commit message
---
 arch/arm64/include/asm/io.h | 11 -----
 arch/arm64/kernel/io.c      | 87 -------------------------------------
 2 files changed, 98 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 1ada23a6ec19..463067bffdfd 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -128,17 +128,6 @@ static __always_inline u64 __raw_readq(const volatile void __iomem *addr)
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 
-/*
- * String version of I/O memory access operations.
- */
-extern void __memcpy_fromio(void *, const volatile void __iomem *, size_t);
-extern void __memcpy_toio(volatile void __iomem *, const void *, size_t);
-extern void __memset_io(volatile void __iomem *, int, size_t);
-
-#define memset_io(c,v,l)	__memset_io((c),(v),(l))
-#define memcpy_fromio(a,c,l)	__memcpy_fromio((a),(c),(l))
-#define memcpy_toio(c,a,l)	__memcpy_toio((c),(a),(l))
-
 /*
  * The ARM64 iowrite implementation is intended to support drivers that want to
  * use write combining. For instance PCI drivers using write combining with a 64
diff --git a/arch/arm64/kernel/io.c b/arch/arm64/kernel/io.c
index ef48089fbfe1..fe86ada23c7d 100644
--- a/arch/arm64/kernel/io.c
+++ b/arch/arm64/kernel/io.c
@@ -9,34 +9,6 @@
 #include <linux/types.h>
 #include <linux/io.h>
 
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		*(u64 *)to = __raw_readq(from);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_fromio);
-
 /*
  * This generates a memcpy that works on a from/to address which is aligned to
  * bits. Count is in terms of the number of bits sized quantities to copy. It
@@ -78,62 +50,3 @@ void __iowrite32_copy_full(void __iomem *to, const void *from, size_t count)
 	dgh();
 }
 EXPORT_SYMBOL(__iowrite32_copy_full);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(*(u64 *)from, to);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- */
-void __memset_io(volatile void __iomem *dst, int c, size_t count)
-{
-	u64 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-	qc |= qc << 32;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(qc, dst);
-		dst += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memset_io);
-- 
2.34.1






