Return-Path: <linux-arch+bounces-7966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4F8998635
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 14:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E16281F91
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C71C68B0;
	Thu, 10 Oct 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="RaZF/M9K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bz+lxIGw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout45.security-mail.net (smtpout45.security-mail.net [85.31.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99FB1C57A3
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563840; cv=fail; b=VYYBF3DFK7kvM22M0fykKKZfBIbLu14E4JvAmxktdFDu0j9gtqobBRewazfHMCDNWsLEVmc78ewdD/NZHwo0xXJm4CVhnkYodjTWNcZh2GPHe7js4gQGeQ+BfoIbRp+2e3rqcOm2q+B0/jpioZzBofeAm9jMKPz5YnybBPrKFfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563840; c=relaxed/simple;
	bh=AuP0TNfT+jqmdi51Lqy26dN3CMKXQ1HavhEmloVdNkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUY1sZzFJ46daVgu5YEpf5yvTb3C5FXwH1+n/WhnK6EFFrm3fU3PJ0nvUKFNwCO1y6FxEed6xrg8nwpFGrwhl4Po4pXcuj3CNpy2w6BaJvD+Va37sTgQBbkvv3horjHmRJhPwZv3+fzrmlfuSShcnKsMr+TwvlfRX/v+b17nixw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=RaZF/M9K; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bz+lxIGw reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id 25B1A511929
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 14:36:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728563808;
	bh=AuP0TNfT+jqmdi51Lqy26dN3CMKXQ1HavhEmloVdNkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RaZF/M9KynJsx1dOC/G7i+scHB3gGE6sdAm4AtX8Cwaxk4KL7jLwFZ1kLuwgudvwY
	 /G/0oGw+3gXwqvJzxeoQdBYokVfhI2VM8MwZqHERd/IQxs31Eh8uM96qJEDRlBJVxx
	 PIu2V+kp+qetNNavhBACodxGg1HyMNNBCyesZLfM=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id D743151134D; Thu, 10 Oct 2024 14:36:47 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx301.security-mail.net (Postfix) with ESMTPS id
 2DEA851179F; Thu, 10 Oct 2024 14:36:47 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PATP264MB4966.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 12:36:46 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 12:36:46 +0000
X-Secumail-id: <feee.6707ca5f.2cc36.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbQpDwx612gpwb9kMehjLO6MOHV0IivBnkVcJOW4qKWD2Zz6XkPSCb1QRWGy6gkjjUX5rFant5AYlxhgdyW7/7CYOafzOnGoWCi9I/1sPz1LQ7c+37gg71RXr4IFDvYwjY/g3E4ZtQj29x+3hRMsMi0qJR5ks5lFyS/3hyJhkYYI3mZBrDDbHUKrJ0bx3upM+SyVbUzP1VbhOd4ohcZLtK8VB+HqNFqzPfjU7gVa/XLgyfmELBPMGTOgPFMg6SQQwx/2r2IwdFigK7Nky1oV551n9LGYevPEcGGEJ/N4NJO6PJHVOKJS6/d8bH63IjBvkPFj26r5YdnwtU05+SG0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wxc+ptfJhfeW9nmniYCoOFng4kDVENPOF8QNimbyUxw=;
 b=xBF9QSQLD9t9xjCk+Q3vA+QQql9k08RBrixMLGP/+lxJJ9mzBH2hvy7Tp6EiIc2kjV5r9VuEfrDmevkwcJa36DSP2DpUMIbpbICrS+pRRI2H//YW5HggDDg7B0ZNBMPvJG71qxZPDo3o/mHbycVi5L/bRAox87N7bCWFhZjrhybZRIats1TKZNkiIbq/WUnWVNXyRpnM/1dOtID0mocMDsXmhWd4OIqjF23d5tCvWscHzVyvIbam0veVZKD3iZuY5xz1yhh0vPHrv5rZCw0FgerLzh+W1UOyY6HWthlazZKlUDQurE24Wjmk4NOXz4lcDglzuNCkeLC8YSExFdBsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxc+ptfJhfeW9nmniYCoOFng4kDVENPOF8QNimbyUxw=;
 b=bz+lxIGwxPNQcnh3wItZU+GaElDzBfozbabRpAULxG2QTXc7SlgkbPj79F3J3fs1fT8l4l0E6kBKdKiGdBU/aCxPQm0lt39omdIYgrmrioSQmdUzMx67NoOg+hqJu3KosauAbmoLOfaw3PKACCIAyX6UHbgiBqJZVBfkwu5UEw5UYteiYY4KE6j42sOEcK3j5bMcgwmMpjCnluY7gSdqK/Ixk6C1a/JSj5rdKTJSvlL90JMdib7DBBzXZuzkhV4FmLGKKakJrnF+ceHVuj6u1mAvGDW1jqGC45PUKxUxKxAThcruyh7tY2V3zJTiUNvXVTYuiVYQu9OWdMdaWY2gVA==
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
Subject: [PATCH v9 1/4] Consolidate IO memcpy/memset into iomem_copy.c
Date: Thu, 10 Oct 2024 14:36:24 +0200
Message-ID: <20241010123627.695191-2-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010123627.695191-1-jvetter@kalrayinc.com>
References: <20241010123627.695191-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0020.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::9) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PATP264MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: 098d4ad0-e5bd-4416-3a98-08dce92833a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: tZeMErcidABGkuJj6X455BnS1ZXBGHC8fuYRsXjk68R2lCIF/iVdW/ieGXV1pNUBNOISa3v2KyAcNP0EFznh7Loqz2qm9OmtiKS09NwwvZkbvA4HV62Iq44RYPbUKd8+3vHaRpFHBDZy2jSE5K1BFGBD8Zcsbs63r2tW9EUfBWnQb/WsXs/AgmY9nxzPQSixWbSAjNFy38JWy24Kkng0kDZfgsJUXWdeXHsZdAoXIElVwRYvqp9Qity+kqjfa3twUnRP1XVHlGe27qW07y/ett+/2YawnVr0DFTrIr99CK5Z3/qVpmNf86HREYTNinDtupH1in6Wt3Wwsfdel1BWx7EG18p3W/YjAsxTTgRLrKRB4Vne+QMESewcSb4B0EuTvuMUmTBZ0rPDKngaO+U+eXuETAUSZ9NmL7DZHgFg5bRA2JwQrm5QbHd+eo7iL1eSLyq7NLjmSha9GPdyhQ13DmuJT8R1/bQbP3WEQGbCL5iLitZ8BmWXhlt2XqfGSQ4EOJoqgq3oZDNPs1pKBnKmWMpSI2onmyOEjLK8oCJ2np+Pwze4kh7brHgZpp0i8DR4EtVXYPejssSkoe6SpPwIK7wSnTIK9naDsYiHwiLRZnt4xvz3q/ldPSOFmSqsCfgYycVsY7P8yweYql/LAQdXef1NukEezGcRev+74eOdFtX0gtziTtMZum1HIBu+SDja6NDvSBSb3fknFFI12LL0wjOVXiL+76lo8+hHyMmqoid7Auc4kclTEzlYIxXijLjXvQg+IbADv/1S2Z/IytK3PxtYezhfT2cR7U++RJ9SXl+l+cA7+hjSxp5eEiHfR13yraupqvxolD5TqwQ+kUgVMCbWcT0vNIR6VgzRzQDRZeGAHfQBtMnYwyKlVzH2I5akeo0gUM4+rRFDl35VNJBpceGO92g5hrwheikq4hCMUs9wBhAO+A36si1dCU6wI4G6DWY
 XigLloGvVXz12qbQOePj6pz9ZEpoG6wZQaiq0Z5FJBzvo3jKP9kxRMxfq1qXClwykGBVsmBTLG6E32St4VWmfshIVSRUfTedBhB9qLBuYxkQVmYSzRbY4hCvC0eyNTP4MlMVgslJ4yW4zx33PwCm1bKJ+py7bNZ181+aGK+RHCySzVLGxF0fsvJelkNawgk6zNguX7RiWsCcaiiRV+ZjXS9VaFKOCgcmcvVjR9KSjZHhitEJxq7Ak21gOg3nxhGuglTPON4wpQq2KDNmoXLa+0cRo3mnthhmKj2cwmBexho/WH1cThOID94NBk06sIdsEmJ/zhpTHt2l+NEePneNQft89Kisr3HL09Ka7lSMQGaLEt5hMBi9G2ajBDRoDXGZMpEeveqGf8FYTYnT1zU5wbCOJq8XCqdfGaoxw+6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NDncZTcC5l6gyzgBuQWZSmU0f2xf+Cbf5NMJoVppzbcR8gCK/dp4SkQFL7BpaY8aKW3JBChypwO2BDji1T+6g7EGCNccBIRbNNYTddamYDaUpwi7Yw/+x8jsDZOPev9QlMMyHbCP5IxWZyoc3B4B2XX8eW9zgZiIeYU0p8mxHO/W+7EZtJtyjLtaohZ7q2TjBlO6kLH9319QvWj36rLMBuDZtsL9F4+u4xUrmqhsZ0/swPxdSNW1Jua9hWc4P1E3Fp98bmldLaCB8D6NxmdeWTse+Xg18pXphbyif3so7bPQIkyuKg21ZV9fWw2L5Iv+uxUvEwE4+ULlItcY9si/choDDNKQlJiBjGuduCj0PzbuD6mgmE4Zlo+FvDpZij/h31OHGM+E5pytJ9xFYmBUtLT6iWG0tieN9x7uoKQevFrkQJxkSN2Nv1PAwfU5uJaLBbdKNibSFw5xmoypylSzwybpEiDqjnFEuKoyzkraZTfgPgOdI1Dc89/DZKTCuaeX/KlCRs6Hmart+/LKR0AY/uf+gDuV6J5UJKN3qW11QEtyXSXnDqnzvXCv/Vrd8qoGSukcAyZNqeQ7mWT05zT1XNCTNwWd+KB53OEcsiImGmDP6EW6utLtzLFCPtC+m3agPBlvAK+Y78zzZVgJBSD50WzexZhvBjOpB+e9Ge9ozZ8FS6OIpDApSBfCD3sSLRS+e6Z7GZfHBy6DL35WxgAZuVYZO42rH7mMDut1H08Oq/xeAUg7M3AfHHMO5A0dEbfiC6iLi5ctYU2bPRT4j9Lm6fFZYmaVe/LVydJhj3zfJkGNtaqNbSY3865FKadk8YDtdkwcXVorNwX81XEBRRDA4Sy0KI5bfvkrL1TgkrAzeKxzHWz/q56EM2B8AEUGqZiHk0VoBl5J44HTjwktlJqQYCaccOINIwkvl9FGeTmFP3SlOjFYoTQU1VlGy+FDoAjE
 XYXC3IGj7iMri6bt9MD121ycE5hwx0l6XOG5GQKmrynluc59FTTPJJ8Ns9BjiKDkW7e4pSn3AbyKcoY3BZFExMIfMdL7rIwbAOxkJZQ7KOtfWZPiGFNr9v6k9Y/fyuL3yHcCaehbN7Qdf6+RAJ+RvO7pMSFhNepO2UXm9Gewq7GC4uZnBJT1KAEvs74hD6+wTEks38U4TDNlizsIyMSyBOE99icJlwlk8IHNdGZA+rLeYEOEim/6B9aPlR5XdYsFc8P3tOCQzqG3QInY459s2LfJy5BQvKHEpdBae1nDtt9FsN4elIsqystDqm6r2RQ1FPIaZ70gjxxbU8FC8qWyDaQ6pLwElxs3NZ2/NfCJLVPYknTugik0jwVjg+bO/paslJBkvh+tk21sj6XfMAEMsnMyjfUTnpRvDrhYnJfGMdjgUO7gLslfSt/oVL/y/zCxjG/GK18pb9sdIzHuUdXFsOIGyG4SceA9R6sIyUOoBMTiJnuwU+j5lcGPamUwJHhSuFAxvWNjmud5NZkRoVMpUELVKnQ4l/9T3B5xEdS4UqnmE8dMjN4pha9q7Hp8W88wit2E451XB0lmSF0PE+hPi2j7YDAXJTVPfKyXZKzNFD8vEpx/ZB+uiG33ZHkCsdZv
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 098d4ad0-e5bd-4416-3a98-08dce92833a7
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:36:46.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnTkvGgCRuVIGesU+iQ0ieLQw5uBWJFWFLMgDhTfoI3AxZ0jH8CHSCuYyZaFzEU5YJDkP9JCE7+AL8DaggnbEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4966
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Various architectures have almost the same implementations for
memcpy_{to,from}io and memset_io functions. So, consolidate them
into a common lib/iomem_copy.c.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v9:
- Moved all functions to iomem_copy.c
- Build the new iomem_copy.c unconditionally
- Guard prototypes in asm-generic/io.h with ifdefs
---
 include/asm-generic/io.h |  62 +++---------------
 lib/Makefile             |   2 +-
 lib/iomem_copy.c         | 134 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+), 53 deletions(-)
 create mode 100644 lib/iomem_copy.c

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..4ab47ef7095f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -102,6 +102,16 @@ static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __i
 
 #endif /* CONFIG_TRACE_MMIO_ACCESS */
 
+#ifndef memcpy_fromio
+void memcpy_fromio(void *to, const volatile void __iomem *from, size_t count);
+#endif
+#ifndef memcpy_toio
+void memcpy_toio(volatile void __iomem *to, const void *from, size_t count);
+#endif
+#ifndef memset_io
+void memset_io(volatile void __iomem *dst, int c, size_t count);
+#endif
+
 /*
  * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
  *
@@ -1150,58 +1160,6 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 }
 #endif
 
-#ifndef memset_io
-#define memset_io memset_io
-/**
- * memset_io	Set a range of I/O memory to a constant value
- * @addr:	The beginning of the I/O-memory range to set
- * @val:	The value to set the memory to
- * @count:	The number of bytes to set
- *
- * Set a range of I/O memory to a given value.
- */
-static inline void memset_io(volatile void __iomem *addr, int value,
-			     size_t size)
-{
-	memset(__io_virt(addr), value, size);
-}
-#endif
-
-#ifndef memcpy_fromio
-#define memcpy_fromio memcpy_fromio
-/**
- * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
- * @count:		The number of bytes to copy
- *
- * Copy a block of data from I/O memory.
- */
-static inline void memcpy_fromio(void *buffer,
-				 const volatile void __iomem *addr,
-				 size_t size)
-{
-	memcpy(buffer, __io_virt(addr), size);
-}
-#endif
-
-#ifndef memcpy_toio
-#define memcpy_toio memcpy_toio
-/**
- * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
- *
- * Copy a block of data to I/O memory.
- */
-static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
-			       size_t size)
-{
-	memcpy(__io_virt(addr), buffer, size);
-}
-#endif
-
 extern int devmem_is_allowed(unsigned long pfn);
 
 #endif /* __KERNEL__ */
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..db4717538fad 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -35,7 +35,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o union_find.o
+	 buildid.o objpool.o union_find.o iomem_copy.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/iomem_copy.c b/lib/iomem_copy.c
new file mode 100644
index 000000000000..4de710c2a9f0
--- /dev/null
+++ b/lib/iomem_copy.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Kalray, Inc.  All Rights Reserved.
+ */
+
+#include <linux/align.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#ifndef memcpy_fromio
+/**
+ * memcpy_fromio	Copy a block of data from I/O memory
+ * @to:			The (RAM) destination for the copy
+ * @from:		The (I/O memory) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * Copy a block of data from I/O memory.
+ */
+void memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((long)from, sizeof(long))) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		long val = __raw_readq(from);
+#else
+		long val = __raw_readl(from);
+#endif
+		put_unaligned(val, (long *)to);
+
+
+		from += sizeof(long);
+		to += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memcpy_fromio);
+#endif
+
+#ifndef memcpy_toio
+/**
+ * memcpy_toio		Copy a block of data into I/O memory
+ * @to:			The (I/O memory) destination for the copy
+ * @from:		The (RAM) source for the data
+ * @count:		The number of bytes to copy
+ *
+ * Copy a block of data to I/O memory.
+ */
+void memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((long)to, sizeof(long))) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+		long val = get_unaligned((long *)from);
+#ifdef CONFIG_64BIT
+		__raw_writeq(val, to);
+#else
+		__raw_writel(val, to);
+#endif
+
+		from += sizeof(long);
+		to += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memcpy_toio);
+#endif
+
+#ifndef memset_io
+/**
+ * memset_io		Set a range of I/O memory to a constant value
+ * @dst:		The beginning of the I/O-memory range to set
+ * @c:			The value to set the memory to
+ * @count:		The number of bytes to set
+ *
+ * Set a range of I/O memory to a given value.
+ */
+void memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	long qc = (u8)c;
+
+	qc *= ~0UL / 0xff;
+
+	while (count && !IS_ALIGNED((long)dst, sizeof(long))) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		__raw_writeq(qc, dst);
+#else
+		__raw_writel(qc, dst);
+#endif
+
+		dst += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(memset_io);
+#endif
-- 
2.34.1






