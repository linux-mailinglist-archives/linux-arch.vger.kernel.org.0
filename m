Return-Path: <linux-arch+bounces-8344-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4789A6A6D
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74FBB259F2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73721F80CF;
	Mon, 21 Oct 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="hvoGeB6H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="KOkrBftH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2901E8851
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517630; cv=fail; b=OqBIjrCMXAEfTKhh5U6v05OYVBZGdc12XouT02zC2Ok+Wi4HezLiKf6Pe0duMJT8N6yOqwwS6MuReu3y4SRjTCe8iTsX6vva9c6NBObLpFAVkOIdb/6/sRz+HEaKzGO+02KhbKkJgw/U/54yIsYL8/6Tr4krWqArTH7/Gf5exww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517630; c=relaxed/simple;
	bh=9MrRi+HIu1RpyTjzo4eMu1vZlTPkh23XxFp3JMnYzCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvXf4oWDyuhQJOf2lskmNvsuubmY4SVxNFl/wfYNe/Kdvro0ilH6kAYB6joot5MA6wJQj/O/jZTRFgM8TNER64qEM9y+JkfZhA0tZOs0/HzHuGavnBdSmLL5n8mM7WDH5LuXa1i8Vr+Uwi9w7FE5NiRXBEsMPiE+S+ucw0wB+nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=hvoGeB6H; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=KOkrBftH reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 8F71130F15F
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 15:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1729517591;
	bh=9MrRi+HIu1RpyTjzo4eMu1vZlTPkh23XxFp3JMnYzCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hvoGeB6Hc+iKZlAiL9tZQ7LI2rn1tHT4yeqWS48dvmMQrP6R1NErXZ8t18wDl5qQW
	 279WcO4kLFmi416cF+0FnzTaRNnjmNZ5DuonXLw4w+j+h9G74xkOSVLx6ecBWw789y
	 R9M0eJYW4X2Iwcn1F9F2LITyDKLd32MFITCn4X2g=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id EEE4230F08A; Mon, 21 Oct
 2024 15:33:10 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012054.outbound.protection.outlook.com
 [40.93.76.54]) by fx305.security-mail.net (Postfix) with ESMTPS id
 03C3530EDE2; Mon, 21 Oct 2024 15:33:10 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2339.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 13:33:09 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8069.027; Mon, 21 Oct
 2024 13:33:08 +0000
X-Secumail-id: <dd05.67165816.2e7.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLdEx5zBIhxlI+ciim1NNGxybSUKLysqvQjYipcO+OmTK/11aMnsy6uLn6Y8CDoN7W7P+E2/1WXLqMjqZ8MmC5VI2AH4qVgnnITK8/OhwUVRsKqr2l3ThUVrCJmER3spIejU+9UtNZAwde1WIKn+Qc9EsJPMqr1eqOxYb2niMHZ8M7F+5G1/S+jhkwhC4SI2flVfmkTJH5iWAnrfPtQc87qvfPoyHjBGEyygfV5eoLh8vgn8pTODGQplQgToT1G/pcXmSUXft1ogXJa4v6AZKZ69WFTaqWikqkgsPzFlfZA5yONqTKm4W+ltMKPr2sN+6FtFdGIZwP7mjcDi7NePJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7Njht9EXOov+4QFI7riJf17Y/k/EfOjTSncmbNefbI=;
 b=VMwz6aa/o2MWdEbFajwCZm2E1eK37MdV+VXagon2jr6vZV8v0osyUjyqj1iIt5jYEgBwrt/VpemGlnNuZWNlMS7CYTwQ5NqabMz9KYdLAg+crafEEPB9lhj3zU+av/qL0gjAV0+RjwPZBp2B/VHT3GC+RphT0VGPBDJzNafBf+JLddfGRQ++dDQJFbSFztBKOzQm+u9U2PN4vDE1AUL8BaNoxTvsao03J0/cXJQOPajepYFnGUY0pFArC611naNlZ8W5BwmtlX+Y0N+ESBvTAJe3i5XO2aVdiDgTo3ftdQHIeYkiW+oT+3iEnLvXIR2j4m/TEDL54iIJ0J3A8xYHwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7Njht9EXOov+4QFI7riJf17Y/k/EfOjTSncmbNefbI=;
 b=KOkrBftHFJwHxQC0cQ8cUg4/L+QnxCF2uK0nmNmMojq/UzWJA2X8+BpG7P7k/cp5V4btjgDgV3hKctnyUGrJYoLO6n1iECVHFDMxfmlCvLGg+X2G1MIYBe7/NyqCd+6am+lnXwMc2TQAp6YtbNC3hEnyJmbT8mo31ONBJCelEiB9ump9qAkCf//CXh603LMuwA0xV+jXxTtbNCfh+8wK76XJnwpD/rGZpVLz8+mBBJxas6rSDQz0a7vlH4l96NdAhna26dKBrtPQpSBAm17i2X8OVdLCI//R4Zk5je2PDTKPCucEp1QHBWaYRY2tbVeB37idXjJii/CfiDQbtYtJig==
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
Subject: [PATCH v10 4/4] loongarch: Use new fallback IO memcpy/memset
Date: Mon, 21 Oct 2024 15:31:54 +0200
Message-ID: <20241021133154.516847-5-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021133154.516847-1-jvetter@kalrayinc.com>
References: <20241021133154.516847-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::20) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2339:EE_
X-MS-Office365-Filtering-Correlation-Id: ca301b52-955c-426c-e4aa-08dcf1d4e6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: JWJ4gjrindRvyprbjFVJokFDqjHe6mWgnjeWGpq/7TVdzZk/oVE82SnZTtDU36mT4Csi96eA4cih2HvQV6q8qPp+3a1H6hSTgkGb7rMLVr2mWJH1TT2Dx41bWccClK3ZzBPLkcBBRKoczuPaNd4rsiwjnmZGWySBbG7EoRd1Xc6Cn8wPjqIFsTZuSkTfykqv37UWyZzUZthXDeZvw2qOEfKOMo+x+SoNi8Alm1uStrjPi3x6hP3T69Ph8EmuITsabxdnsRi6l7AAKKDfcqtNKNUzECZ4NalZXfEpn60bfyt54UXhO1OeyJAhr4K8W2yk2o+ZM/IG4uHfGF3xA+tK1TH1kX+B62wZYxRw0TaL5f0LPyXpnLYauEtasfH6WitkGrhLm3TJbMVJZTmEVHLm9zt+VuQgdArHA/n+S8uk2HJOUUFkP+BfBvrZ9hbuq4GUA68ZLa7a2cNoH0NeAWr92Fjpj3V4iG6gOpCOIiA3kBfD6FDLvfSaKc7WqP+HygCMvV1RXdVHPV1n//iHyEilEEAfaSF9rHxFu8mVEtDHMcpFU7WnzgS98JCZmAgr8hMqIg6dQdk6P+92gxgzoRqnsWRUs/H2cU6UzWR6dSD3rAVdKjUlcHxCZ9VyUTkjTrfVbFdGDQe0Cw9hrX8f6XkOZtwsu10N7kxMRwMRGn4+yw8SKYtp0vz8pB9us8LYWr1q3GUIyeNEwVqne9XIuxk5A/pS2TYLRv7ODcAF7xlgp1SntfNwqFyHL0ANwm8IBA3H0xM31tf5c7s6E5knHXTS+NgYbuigZ5GTVtIbEbumVlynQsfhKygeWP7BdAKE3rSpBSa8ig7EM6i3OIDBdGtBOs0CPEKoxlmojcoOT30iMNfMWmI004zjEPT5zvKxV3nLRclaqb5XatMjQ32uNkknFpDan9aQxf5uM45/YfJuh/8OUntEu4HjQhleSTlJnX8k3h2
 lsu2QJLBK08FEkWnWh/EvKX6quIW/PcCbZmffz922RYiM9WeBoG7UHhGOSFZzbrFyIOIT0l2e5iJpAK1RHgEwRCxf0EF+9MOy65buY6C5+Vxh+ZcPz7VRQxjEDf0jX3xS0rp0HZj8KOUnAqirkPftYtv8tkZeojWXaY2Gb/tJTbuLmjGGiaQUhDyXYgGYLRhLh3h6Zl7X87w/bewdolagW/E2kCY8W/lFSJMzxPivQvSBy92uHTEbsMBvqRs+a/R88ntnj8u2CGenue73iSVrkTlhU698Y8OAa1I7IlRgb01CLHkYT+YEoQq9Vpr93CQLn8twsabBDWOLXhz05T5omQHLQd/E0VAsgGQ5x8BPgYvLQnOmJOTljt9ChkH575pCOlGea2dzVKxO/D+BKnomURIaEvGkEvRlDTEmnqRvTxRKuRwqmm4bc2oqCWa0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q7pAdVamevcwDP24bVE0E5CcpsZi9WrlU866JQwuRhfQxVc33Ta0eZWVmjCKPmVrgIoqke1sOF/ZByybLquG3xNaDc1APaV7Dg4o4+BU3EyWJ5TvdMAZfgkVNPdCXB0T1qvSkwpJP0tSDcv+C9DcyWbdja2gZRlAVLF49etqeYj3zfGSWJXnS2r+sEyKeQ8aumuOaPA3+qvL+g5off1UpxzAjWaSo56Z/L7/eZw1c4eAUTYob14/YBNai7vHo0HHVyT6a2vShBAjpDkHCMlPrfl6UfbSGvuG4lyRT0fQyt67vLV6TD7xUYGfBgf4x9jIf2JtIzeQTRhDBziNSHjM4bQgf+sUThjtgTHZcPhfFQkE691UppcB0OEqek1nZ4vNx0kiO5kutpgEDZK37e0g9HdQ+HnkJacQY4X+cbwB53WrR2h/WLQsZXFevFSGbTJpXty1mMziGYROS8eR42Y9PNLVEB6HJ+IUNzm7kRyeGaCzS0sF+yrL075QV15SAcM1DVYVO+ZZ2T4EjZ+gyk2PjPldUayWhUA7PeHF3zY6gWzZ5om88Be0bLxngPgxrNWJCAiJrAfIZeHPQQWMUobJd79WImzGdvOW+/7qjXZQP3W6t/wyHamG02X/RFzd0itYvyVk006P5vkS6OmsbUgXmzumRkxo339Co4EuSj9LLgbO4uag1/LRVTWfLfkjuRYWA2JiI9crjF5z8Ok50Lky7kz84dRF2IES7ADwzDtBrvrGSbb4KYpOo9KzTtI6TrXs9D8c/Nts5jnKeiuyYdqyWGpwvssVN5e6bMYC4EDjihZm2uY2ke0krPsO4nZh7cvWYKGRjSSc4uvfD/E9Rbr/Z3n2x1b3lqpTRAgH3HwtwwJieKL/98i13eofRM5X373zD1MQ6s+wfrtWzbsmFC4sRuaX53WWButgnlt0thqgY5pTCb/riCkj/hDj4iauEiGM
 mXytdLrulW5/ErKlfMWu1CwI0SICKqUN+wut6RKdo0zOIqfYKfggedacSt6v84qm/NmcQr1J2ic/bVvDuv3wNbOFiy1xDjps5j/DdMxgDJZCrJGva7oY7o/8ruG9bUeyFx5Gcy3dRZNgTX49jxdlUR3ovi4jwHFGOUoc/0BonAva46TaRlYMjh7kjJO9p6vif23TLOnN1JL+i9thJgJWofavpVTt2mCmDGASeCdTkINUtXtLYPZTP6TbwI9pRRB/4wJCYAqz5U/XofJ6xBvXVXeP+BSi1oYOL7RFIj3f8UHmoRpbfV/Ls2R4ULm4nO/EAC7NLitcyACTCqZzBp+cz9Dx5YrVJNzczJnl52YFHHyozMxGSFvKiw4CJxokL44iRsf4kmiOAEN45CxLHvnbpMtVwkYDTAORg9qRouKFImg8W4XjhxxLofl0E+QJeh6K6yG1y7s6nPRLzw6SJfdYxSiFvbnZ80R/cf/AlRcb42Emo+mUjfwHJhupllbmogNCobC4kYaxaB24Xf3SI0m+Q+windOj/coAxRzk15JWf7bjKHcg33PfygEO5aINBUu+WBZaYK7c3Pm4cVfh0qgQc4XYzAbwgEsI8AmHk9oTQwYoPjeIA3xgn0XR2HCwWOcv
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca301b52-955c-426c-e4aa-08dcf1d4e6d6
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:33:08.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFeQpEgGJTN1Wm29wkZeK2LrbBrwHTqjxfA+Amsltq1itEq2kvT1tHf6MAe+STmIChc0kCrgLbHTVYbwj2UNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2339
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the new fallback memcpy_{from,to}io and memset_io functions from
asm-generic/io.h on the loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v10:
- Slightly updated commit message to clarify that on loongarch we now
  use the fallback from asm-generic/io.h
---
 arch/loongarch/include/asm/io.h | 10 ----
 arch/loongarch/kernel/Makefile  |  2 +-
 arch/loongarch/kernel/io.c      | 94 ---------------------------------
 3 files changed, 1 insertion(+), 105 deletions(-)
 delete mode 100644 arch/loongarch/kernel/io.c

diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 5e95a60df180..e77a56eaf906 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -62,16 +62,6 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
 
 #define mmiowb() wmb()
 
-/*
- * String version of I/O memory access operations.
- */
-extern void __memset_io(volatile void __iomem *dst, int c, size_t count);
-extern void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count);
-extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count);
-#define memset_io(c, v, l)     __memset_io((c), (v), (l))
-#define memcpy_fromio(a, c, l) __memcpy_fromio((a), (c), (l))
-#define memcpy_toio(c, a, l)   __memcpy_toio((c), (a), (l))
-
 #define __io_aw() mmiowb()
 
 #ifdef CONFIG_KFENCE
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c9bfeda89e40..9497968ee158 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -8,7 +8,7 @@ OBJECT_FILES_NON_STANDARD_head.o := y
 extra-y		:= vmlinux.lds
 
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
-		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
+		   traps.o irq.o idle.o process.o dma.o mem.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
 		   alternative.o unwind.o
 
diff --git a/arch/loongarch/kernel/io.c b/arch/loongarch/kernel/io.c
deleted file mode 100644
index cb85bda5a6ad..000000000000
--- a/arch/loongarch/kernel/io.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
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






