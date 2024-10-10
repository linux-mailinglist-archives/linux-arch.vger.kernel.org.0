Return-Path: <linux-arch+bounces-7969-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A36998648
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8772E1F21D2D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210DD1C0DFB;
	Thu, 10 Oct 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Es4H6MqN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Pq6Gr/Cr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE2C1C57AF
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564007; cv=fail; b=PSVHN1b2XNqkk5Au8i7xl7jI700fGap3J/E/SHt8uY1OFSA12NoyRYeR+DZfigojnCfPn5YIfugra2lr8w8aPEGuAsKPQX1RqDanTXMcToxwBY6eDy7fGZb2+RHBCt4KcUenP5T0dFcdwZmpl1fkQuLTtHy6pPlfudAcXfbcfk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564007; c=relaxed/simple;
	bh=RlQzT0U7eOx8U5TfAfIuFQsaaIHteJk0XXQbWyLB7W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2Cxe6U0NyuOA1GYEc/D5U39hzyY5bDL9RovNvZpMfX/5Pqh/qSpiRnBImYPf8eEB5ZQp0wD4+Tk4zMYljDSi42bho3ggwgO1pJu8vdI9wCEjqN1nU3SQOwRQINjZJJoHU7Xv9/wLatyHo4fHztM0oFRqOA07I8/M5fYnB7u0Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Es4H6MqN; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Pq6Gr/Cr reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 6CFC63495B1
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 14:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728563810;
	bh=RlQzT0U7eOx8U5TfAfIuFQsaaIHteJk0XXQbWyLB7W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Es4H6MqNxQc5UAs/5/2V80UKUPaziMge6iiYnlRI30pbdaIgmKxrcTkMMqDIznI4J
	 pVgfzapIKYFK4yuk5RoiIlHhVVio7NVHqdC7gHN+YdpqMbfea1+Wj+VvYOYRryIiTy
	 PN+hgMr2B/mSdzqfpttLzsbm9iPN7doekvDL3VTc=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 0F71334948B; Thu, 10 Oct
 2024 14:36:50 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012048.outbound.protection.outlook.com
 [40.93.76.48]) by fx409.security-mail.net (Postfix) with ESMTPS id
 24C1134934C; Thu, 10 Oct 2024 14:36:49 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PASP264MB4625.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:435::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 12:36:47 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 12:36:47 +0000
X-Secumail-id: <67e9.6707ca61.2144f.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UNNmWG69ESnumb+Vz2aQuVodEj8uoDPvklp85Nba1ooy7V38kMwA9f4pcyGCziPgx/VsMWdwrRrf3gGrGQudrl0j9yOZafHgENROOAiN2an8r0BwU70gkjopSCoVtxRO2/ZgIzUzuK00u8yaf/MsVKbEH8nCxxEIUTfdOkCpWese78MHPXOQmIJ8EAk1YHdzRPb//y8CnssgdA3TBA+xU9ekFW6fb/nQP+Ylu+vgRJqcsCvfNU/Gb3nL/tmG+yFvIRDKfaJEeLOSqQgaK+eioYApofk5v5KY48XPtCGiiGhFtI2OExuQGJgzz3nYkAC1rXItEdsHbvfMDUZ9nWvc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8JUSEWpLlyNo7vsdafD4VUsr+z3yFf3OS1Tc7P2A+E=;
 b=eyPPYfNakN3Vz+7nJkCNMl8+Kav87qUf+0trXex8A9qduV4KK0amwpE9Th0HHKwQbavAzVtC0tJdz0KvVb5EdS2YGBwpPVoaRGRwHp2lETwiDWT7dswMxC7mUN/pBfdmgIjIRGXku3wrh4/9hKPGahHfv9PsIM28h3HD+rsca6kxbLxKpijtkjx7HVcs2M8HkTv46xgPu/W9W6ZIhlrwVKcJToAWWWgv5kiTRllowLV/5Pe7uwvWsVWydZ5VWcR3XVQBMDGVljLpo8PUoh8+6iohrnmUu1jYIBHKkWdK67U4tdDIfqKWJXCDXbYhdpkuNYbxQ3tLNLaqw0O0ns3sgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8JUSEWpLlyNo7vsdafD4VUsr+z3yFf3OS1Tc7P2A+E=;
 b=Pq6Gr/CrE6hVbjkNRSlEefuu/G1iBUMBjiWEH+n4A68YgYqe/h0tkd/g30aCUVJr33k/4Un61NMqnVvz2VyrIkpeu4dAUAswyiDXcQbjNbIXGUSCtQCoTgfuF+CIQh18TMu3W6BkWz/L8BdjJr5bdojqFoXHiBHptkUz8gmwd0o0ivSVj4M6MVmrViuPDntFjy/B+cVe05XmLzC3LjDifjV8CDYIoH17nPTTC7HVkRhFny2dufaHMnfN19+6wf64TjdD8212BrOgtuJDOjd4LC7pBi2KpBXTleiQQi626dqL2/MBmR5YIrs/SuD7k647D03JWfj4dYYTK2zl5ute2A==
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
Subject: [PATCH v9 2/4] arm64: Use generic IO memcpy/memset
Date: Thu, 10 Oct 2024 14:36:25 +0200
Message-ID: <20241010123627.695191-3-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8572b2b-2852-493a-cdc4-08dce92834c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Aa+wed1RaGX7XuYYpYFsx4Ws3z0UeLGlaBfA1862e+hmZupL9twxd/jJcW3JH6mAsFfGIAb9gjnP5rApu1TMaQ+NN+hL+lQkAcV527qvI4Uu9t1QpqLjS1FaG3jnXRY05hflhy2Kqi+poTYuCGOkn2t1QUiK77CATt6YkfQhoVjwQXaZGq2c4uuv1n+7BWYON1fEy0A/oETZnOX/Oh8PXH8+/Q6KYW5xX/2g4ducE1SsPJjc7lP6bf/Pe3uIOv6D/z6dKQ2EXHZ1MsDIp0QaP1a5n+4br3nfPUfEOisc5feJzP9mfF9SbRwQIxid3vTQcvWeXUHZ+vhVm9XmQHrPc8ihPTifU6VbHw7SshG1cNAA/y2GJsh238OTlloPV46Mjts0ibFHfW59sDug1a+YotJf4rVjYohY0n3slf4MAAQYiFpqnmM+kpZCUNbAiHrJLJjIsK9U4QFL08AWbHPj6KaxMAfOOQI84UQAAZCEo0B7lTpnZ/69wCautalWGY9w7yfND+RHCn5VahlyXRHHYeW7jT2Q+mxkN9olOlVqsuQLijZrg35OBZAo+GoHWGDk+AwJgRYkA1halIx/q/Kr/w7eyYFbVTfAufNcfi5f9wKyj8+6QIL994z2R0RyzU/Zf7onGzay3qx4Kw2W+qVz9Lrq2YrIrRp8uMkcf/lyJE7Lydglf+MAqYjORu9dabtej20tK0+3gsSiRvnDtNKLDBZvRNaC9KPl095FqVWEVhaRt+5X6WUFIAVy2XH6quCNx4mhEyR7AFpivZdQj3H5rXve3SRDv+bVlTny4KmZsh3XKer6iGYV64OeoRr8pIJyInWvQEbFkcO8MSOmMZzNGzuGmh65XlmK6T27z1JVRfXHJnSZx8T5LzOir3COS/URCRki4kaWkq790B/27cgJHVDkKtcE9sL9osQx+eZZ8BYF4SFWHilHjWDFDqGibe6gXf9
 mnD4jysarutMTuP4tQubwXyLvNYBJgR+K2F43S9iJRXoC9bOf0CLDAauQLh8i1DfjUlinl3Am6xEgtT+iXhJl9DhH9zXlO2jWAvq/UnvrMCLXE1gtAGww7XlxG4BV6SVverMQvULUJjp4anng2JNhAy80J3tSwrU2lIO5ybey9sRLKp4w0/cJO5kmhvXwBjPD+PwSmATQ9dhhvcwBK4zX2rFQgT+RGhVBWdmEwDIqN1EkUtTICgAUR1aNTa1kzYSRCJhpX69B519Opx8ZVrJzl3cvmHuj8KokUojOZ9lXuC8aVQTIkPmLAAISTboeufIm9Gw+tBTJzB7N9gtWic64AaB/qhRPWIhQ8aAFEL14athxhB5PjNKW92ZwhNgorGPpykRwWMsbiRscqaeXcIhZ71AyDImtVM1/U1tlH2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g1XQJ+Zx1LMlgdGppaYvO/Iz+YyWukYroG/8QUL3Cnibe8gTcuxiAQ7wC1iB+8IZkid+5YC3nzSJd3l82jeBbY3YTDv7sfzeqAn++cvMIt9cRc+VT6pMcQ7mogRosfnipIcHP2g/epqxTF8FIA7A83jBAkGa5S1jTr/cvDmMdDpW5UxMygUbvVttvsuWBWm5rRoiJDJE2at9GHUpZGgi0VMp54cLuMQWzH2P0IBkJ2PgVG8QZG6aLK/Df8e9htEimXFIaZmwIpHQv2+rB3wd2QccwGedtZNEEd/vwhOXqDwjzWQ9MHkS5NeGvJpIL2Qk7qa+OQjTLu8gngoppafMyKBeMdJRpn2uC4e1KtUyBtzbUAq4UNfE0YveZmXaazc1OtSRJeyU++/iqGm8FJYHXinF0bB4IL9qQPCqoiMqkaSHFWX8N4WdmfYL7Tx/YgXfxX/46EhSblOzE73irUoQRBtUGcy1o6pVbH2RAGxOxIeCscVNrwQn6KzDgVGiMsvdGu5qYoFMeHivC+EtR2xddWNK6WXd8uvLuMY7/J+vL5GtGsgg1Klg6jyS4kGMme7LMILsJXbddhraPL96m3uNxfOsvWDV1qvZLshsfTihZrkEcQcwqbj9Wg8VXmquaDZS+BgshbpTU9kxVG/kVkZaNyFiWDUNJq2F03ExwQXbm6bwZYCr8d4QEtl9RsUPseazcRO3ZdOh2AIkFKRl5mgHFZS4vyPD8auPwWfIKX998z0k0fCY5evSBYwIOdwEJTQ5zBcmBt6ps/wIyceQFot9mfQuXF9zKx+1eAC28sQ1DEzssIfQ8jMUIvPg/SmY2/Bf7wAcc8wiXw6f+PapN2RkjkUaIrlZb95vlFEsqnyUpbEX4YZeQR+sQfWpKwdN7yBo9V4IaxhVPoUzGMLuVFV68ABE5dY/zDiKcR+fQoKkxXJ3DJ4Rr5g6C9hsqTomeTK+
 Hyp3Ff57FhURNQQpbscaXD2lo6iRvlpLxZuuBXy2dyInX2b0wkxe9xg9fT9tul0vPyJQx+i7gBy0P9sj5zArsupD/j42pp5KK1UTHf3YkKktpp8IO1K1cMxVG+yeLPWU4so0TKnnXd1Bko6T3MBrs+6YmPxZJfKEIbGTsJeyulMk71NEqaqOvBHagTkgWQoFzD0vy0YGrZhfwb/f2vovDiq6x9iUDd9ClL8d2UZwiDFKrquLv5lgqAdKzaBX+Zgq0vl6EwYZ/4ULvljNUaoDrqGycwtzF4Vfy9gako1JGSyhUXpGwWmUP7JU2MTBf5INPemFdZUbRDgjV8sO7qotRRPGrySAoVCeNSOFR7ZHQpYRYdgBDOk9cOyPMMTwGpZffH28S8L9IcLeQ0R1MIOBHVB0a3oQPhbwaFKhmKcRljOF0WmSUtWd3yFPdh8cd/WwelI5EoktwMV5pe1ol6lk/YYAefyEGTYdHpy3qcjIB5W/Vm/P8EAHW2QmuTlA9+2VRnaGJdH+NHAnBkg235k7oR6Jwd2s+cgxp0h97uvdTtgDkgsVD8kVCx9PuGIZq46pkpXrvk98NfpB6hFX43wTEj4otQN+zuGzj0ONrUPCGPSFjQ/uh1WIA0Tmahwx6bqF
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8572b2b-2852-493a-cdc4-08dce92834c1
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:36:47.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HouI/ZIyNHV8LGYe/ikO1xTBn0v2oMm2l8D7FKJvMjVZwT3xs+vLA7/ZhHwOSgcDiwZIMdVc5tgMx2YyY8jHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB4625
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the
arm64 processor architecture.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v9:
- No changes
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






