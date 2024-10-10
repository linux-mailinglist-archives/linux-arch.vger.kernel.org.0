Return-Path: <linux-arch+bounces-7968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089999863B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AEDE282404
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52B1C57BA;
	Thu, 10 Oct 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="gI5MTzme";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="B1pLhETm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6981C57AD
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563872; cv=fail; b=n+rTlrRaR5oiTa8JkQGzzAIZ9DXuVW/vghXcQRCmVNIAOz7xob9CzPqX36LkhfBZFAreqBCmWq2SAqlg6ZWa3NoNtZ3qt+lt051SqjsGxF1gFzEYkxnRpMaodsHTk40nuN7vQMroHIYV9F4K9Roaj/7W5g5v3oWpHmRbLyvXVtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563872; c=relaxed/simple;
	bh=Wh24u107cI7PD08KmHzABZsw+yf/A0fEJI8uXE8dCmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObYX1H5zkjgBEXI9GyXx59C+i6OOXLbedbJ7UGIhI6WU9rNbmjXO3sKiJ3W1kvm/rvvhNK0uD8nneNnlNvlwTjebBh6g2Y3Y/w9QZp9Soywm5v0HD87Ekvc588iiEtOy6jGYUNX2S+Xe898FoP6/GLSD8Jp7qBj+JfsM+JhqOS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=gI5MTzme; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=B1pLhETm reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id D2798349ADF
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 14:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728563811;
	bh=Wh24u107cI7PD08KmHzABZsw+yf/A0fEJI8uXE8dCmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gI5MTzmeaBSYdmrmgP94DIO/shHi4FF8YNKwbYb5QHeWgcUDnN30jZ3xjTEWs2QPF
	 /MT5keuoN7CvucY9TIucK/2oxk7Mloj22434eMlYR14l4lvq9xOEcLzb502UVwjzu1
	 A9pO8qeTDyzg6Knqu8d5kvVkyWTOhBsaH1EuufRU=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 4EDF734990A; Thu, 10 Oct
 2024 14:36:51 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012054.outbound.protection.outlook.com
 [40.93.76.54]) by fx409.security-mail.net (Postfix) with ESMTPS id
 72DD53495B7; Thu, 10 Oct 2024 14:36:50 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PASP264MB4625.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:435::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 12:36:49 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 12:36:49 +0000
X-Secumail-id: <510f.6707ca62.6cfd0.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCZVfS/UwN0Cd+AJuu8a3nWWli/ZV6HRjK8l8eCQO8+vNw2p3W2vxt3GLbpapaPR4KYDr0UZyUm0CGm9134NnMhg5tUPPBg8l0eZmKGYsh009TS0H6RUu9xfGWUvScIlY5Pf83zqwtBcn4xKU9lahqTgGuTPrCL67r+L0aqS0x11coG8CghrzcuISv9Hfxg/PtolIVt97PCd1TJhCUOtEjfhgBBDLYJXAGvoKPS9selLfuZXb81lDus2j1bsuyiH8KL5UPcZc3jyyiM8v1VU9oy3pMAjfNlxooe/t7GiULU3ZqXmGthvNpBIJYiZR8KBW1lyJ3cmitBmD5z7V6PmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyagxVLOGfirvc9f6tu4WyEJve+5URvX1q0tll4fckI=;
 b=ZfbWtLj8b+enF0KT8Qw+Y5q6+VUqq+m/8Hf39UfQePkrHRPit7X8BfKKLTf2D0UEAmXh8Qt3K3UM6HjmNXC/frTlApNb1zcEwFGR9t/Zyns0++xrq0UYkbj1XnOC/fyqKgkhtk5is3yvLevQy6zVgQrKkQ6KJL/67fFk2BiNiECRUtcIMCTuetD70DYDajqbhA4uO+4zhYtZeJauPy/OKTvAbbvhl9fHBj9Nezxae0xpva+Fsyp8duajErsdqrRjv6/0ygl3HxXgbyDd5sf+HxPyoiqzWC28mTLvMs8ZFhH7tFV7OWiXRPCMoFb33foBfbuuTPAbpViFdrkqDxgqgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyagxVLOGfirvc9f6tu4WyEJve+5URvX1q0tll4fckI=;
 b=B1pLhETmFkOqJtArgL7b6s1fji/fMncwG81LBVtM0RqOiXv5uXJM8w4IHir4eIepKhTeiqQxogSeh87DrMpiLe2B6dTL9kQwuPtsaQebT6jlyyIVC7V4TlL0sWHARzsPDgun1puVYqkKhCsWOOwUbYSbtNesXb/zmLnkiW6p13+4zv217O52oWcGVwsyVFP4GKIb1CF6aE5fwJs/2MMwfmgxRJ+4dB4MKuHq7iGjW4Zq6L8vTt50hRSUlhtJ8dVr6j1ZtBEsIPKAen96gP+6ZT6cBTB3zbs7r4a0Bw9wFpBtzyoz1AMD1LwccpjT3xpVyc7XbhbYeMJRqy8+KnQMsQ==
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
Subject: [PATCH v9 3/4] csky: Use generic IO memcpy/memset
Date: Thu, 10 Oct 2024 14:36:26 +0200
Message-ID: <20241010123627.695191-4-jvetter@kalrayinc.com>
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
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PASP264MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1ec6fa-3031-4968-7d08-08dce92835f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: YLpcjJ5Y/Go3GiPoerWhgty4x6Y8G35Nt8bZsUtb3R/qJdztyV6zS15rrPGJzYsk/rJOmaIXOK/7cFxvTy9mHO1lciZXTwLwEnSxwvgJTkUcdhqy+we7wIw7gH28wzV58zWQGClyB6aQ4tqalMXBOUAMMeJJpI9mMGr8NpDPmP/4yoZujMdHrE4hmww6J24k4eLedWxguJTlAn62glN7v72rnKWXIQmM16L1ijQaEmwGJgjVxlgqrlK5CHb3hFa0x23HnvT9bA99XcogCdnWAJawEMNYuVUKWv2DPHlcsMYrKDMSFi4+2g2ve3z+ubRrhUqFYDHBX2ycvjUcCPvl6IGkI4rp16FUFtVyjeE9j/3AE335HhjG3mNnHOZF3VeWDN0SFl7jruOGggibYF2i6WlKbniUVUc8Hcm7vaBCI9mmL8v2VTvoE+8IWDwV/OPhdvX2Q4N3b11NpROD6aTpQp7PU/iZwmNHNEf2j7e/SuyGxKOZkejynip5tDXATB35eKS/xYwTb7z4v21g0ASOcmwWmycfBv3Ro/OCj7wCpRKgojKOGUE8ba65alWVATV1SDatR/cQ5DGlnv5G/OM9M+oTSG0GGdy/mKbdsxU7qyZoqDfu1hBzKPOIIHSqhxpZUtrzOqr/uw+nAcRh9g8voP44o0fYIibNUhGosX86fdKD3K3Mpn6j37CFjIjNa2Oo8akn2LlVXUasWdYHttC8f1M2hwbZe9xNt69CiRVadEfiBMNRuA2dBY5Qb348ZYzfQ98ZuNcYx0XZ73AmdvnOrsIuS4GXBV1ZfngmQlJ9UkONCvvr8PP7HE1xUEh4lye2efNGnCXiYXVK5bCjHy0itbjoqdsDjlfFnjlvhqzAMAR8NyZgQDfro/Q8+HxoBxJXcC0lt1rF8MzKx63z8IufNEWBwkshvkGTHsk8aUvxnhWJUgRu9qtzl3z5cCUWJ3iviU4
 D9ImkNZi60ggQqb+04qk3jJOfYRz2Kwvdcz0HQg8Am3J35K9+GF9dlDBFLdrVpiVmeRvcKy6FustzQv4Rhmvo+HAKlzPgdPMG+WrhtUDjgisrBzQkFbTrFX9Zb+TyPLh9SmmJ6f3BCCHdPBEzizfLOMtNvRcltgIn7GJ5Fg/KyDfY8FBxX91V5E6lEPWj4Emk3GS/Bcoh6JQ1/KkxIPXC7kfnkqm0CuzhjcfSwqLWSEc9tQdoOBTKZnwZLA7BTDbTbq6j6ecp59uQ7J7gIG7BVziA/54W3PUP4qwHN8tgVEppKxSnkMSKoQO1tUlnWmlO/rZc/nhNNf3xiKlk52HGG0kem4GhCes0VvDx47DAeU9OpQ6HK2ydYaLX22a4oQzbaDzyrh042hxcRu/Dk3Yq8qtibxEKNZEb6Z8YgXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S0kGIV68FcXXf92K8csP19zflWXcd5Lc/k9Z0OUQg+cO5Sy/NGVgma5LHNX0PPPtuTpOBhvoIF/EH1Rv5RxJ248nhFFPlXfBV6ldiTpRR3YRmyLT8PZ8LD0BKRTH8N83itQQQ8tt9xDxqZdMPKWXzzl6hy8srmN7IZyZwK6RiJfbczihMSOLcouQznr3NiQud93pFiYLsNsuNPzi43C3pNjfU7es/z9A4HdSCakEbMndrftDAwTHJrNUbINjjtZaaXN+fKOgp0b1hXwHMwB6yGmeio572XW1YeF1fmPq6aZFTBfqmBz9o2spYiJkJSWs5LcewdimqNVfnG0TwrqSy0/ChSk44QGYMOAjUPvhXNK5L+Qkq47oEqVeegON80QMm8FHTYtVku9j5o7rsnSgan2Md0dkzV+M0ad/98wZeF+BzQVrRDR+b2Ni6moBGGUdgsC1O3Tu4CWxAQEaja6uQK9hMGTR68jFbTIsqb5evMOw3dpCMlUFuCLpilS/1YG5Jw2pY1m/McHwl9SAN7Bk4Sg8yZrLk+qfGF4iZmEkU7XB1rJcrtFXvODNqGwZf9lbG8mk782rD+BTnkc+BCozkCxlFYspB8Au2bfItTvBqhoGDfmbAtzjqsDouuc6L84cKnzy1cJqIi6m0DqDucTHucnRGgNNiiFjRj3+qnde/8ge+cWr2uAP3ytnbrJad8Mck6fAo4hialgTQa0eZlwha9ILlCDRQIYmdeY2aX5XNmxoeZtAWHdO2JCwCYUo03lVtBIPK1XLgM67fq+rRmD++ZbL785K8ZgbXnFrkewLcmrNZkvlZRlHDYA4AJA+XosNS4aGvOz3YhNURw1SU3Sfi6qUf3N8m1/pqSbIM8GMMUkrN3d+/t46os7qjljc5o7nfr07cUIaKbZzLMsTSWCFnPEx58+tgXlkwrLaOPUDEcfz6STcrGsRAhX7bcp97Qtb
 8120ckUG+tf6D747WNb/Xjk1a4lC8/b67YAt+vlq9bdkjngSbN+vynJMQJAlUQA+aF1GRU5NC0lWdNcpMgYDRJ33FN1rqHFXp9fzTZ9gVxiPOEa4boSoeZDZLdgYOrY+SaMHOSw+VPDAnx511eBZRdylE0pTfNM2Md86OF99jJ8k8hq3Cwq81M071WPeTsK9qQv5Dk8joQwrN8uEeOUtIViX5U3uz6XgGOMSR5s+9XEMswBqCwE0zhr/VfGhd6rrzObqvUVDJ9XeRciZbuv82FNrSvuM8I1KaVjqGZw54GN40aIjdRtWi+Uxl3JugJS8EP5OxHEWU6oH5bTaaXrGFVwQbS1IQFinsvcyCHtiUXf6FH7jd6e7745s/ZgCXTd67wUI8OXkbS5yzT96aFr+/niQ6C9WnJuyPl6qOfZTOICk3SktAxHUmm+kaQVgwuN/4a7trd5WDjnEUa8ysrIek+fhd2Gf5bopKArHFWWUPxjBxeb6Rhpyp1h8SdpVuTjHbZbPK30LDqyH69e5NraHnnnRtGiKoJJ7sRwEqXnyLXdxKy5B1plra1HL+lC26RZ6zU03Zy+3vWq/Aesr8Gtm/HWYi5BYtwWmOFfxScuyzXcPwjtlDIRcydT5waI57akH
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1ec6fa-3031-4968-7d08-08dce92835f7
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:36:49.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO3vuqIxgWTqYXzmPMyg4ezlVvbGsmSzM85a2bDhn2ozCZbGMXWLm9TQiAg/xCdzKuAbkLpj8GLsLakXSV426g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4625
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the csky
processor architecture.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v9:
- No changes
---
 arch/csky/include/asm/io.h | 11 -----
 arch/csky/kernel/Makefile  |  2 +-
 arch/csky/kernel/io.c      | 91 --------------------------------------
 3 files changed, 1 insertion(+), 103 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index 4725bb977b0f..ed53f0b47388 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -31,17 +31,6 @@
 #define writel(v,c)		({ wmb(); writel_relaxed((v),(c)); mb(); })
 #endif
 
-/*
- * String version of I/O memory access operations.
- */
-extern void __memcpy_fromio(void *, const volatile void __iomem *, size_t);
-extern void __memcpy_toio(volatile void __iomem *, const void *, size_t);
-extern void __memset_io(volatile void __iomem *, int, size_t);
-
-#define memset_io(c,v,l)        __memset_io((c),(v),(l))
-#define memcpy_fromio(a,c,l)    __memcpy_fromio((a),(c),(l))
-#define memcpy_toio(c,a,l)      __memcpy_toio((c),(a),(l))
-
 /*
  * I/O memory mapping functions.
  */
diff --git a/arch/csky/kernel/Makefile b/arch/csky/kernel/Makefile
index 8a868316b912..de1c3472e8f0 100644
--- a/arch/csky/kernel/Makefile
+++ b/arch/csky/kernel/Makefile
@@ -2,7 +2,7 @@
 extra-y := vmlinux.lds
 
 obj-y += head.o entry.o atomic.o signal.o traps.o irq.o time.o vdso.o vdso/
-obj-y += power.o syscall.o syscall_table.o setup.o io.o
+obj-y += power.o syscall.o syscall_table.o setup.o
 obj-y += process.o cpu-probe.o ptrace.o stacktrace.o
 obj-y += probes/
 
diff --git a/arch/csky/kernel/io.c b/arch/csky/kernel/io.c
deleted file mode 100644
index 5883f13fa2b1..000000000000
--- a/arch/csky/kernel/io.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 4)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 4) {
-		*(u32 *)to = __raw_readl(from);
-		from += 4;
-		to += 4;
-		count -= 4;
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
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)to, 4)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 4) {
-		__raw_writel(*(u32 *)from, to);
-		from += 4;
-		to += 4;
-		count -= 4;
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
-	u32 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 4)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 4) {
-		__raw_writel(qc, dst);
-		dst += 4;
-		count -= 4;
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






