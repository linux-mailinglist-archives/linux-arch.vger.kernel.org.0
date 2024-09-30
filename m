Return-Path: <linux-arch+bounces-7495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2D198A514
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9011C21A40
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10078190496;
	Mon, 30 Sep 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="VfSUMFYc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="V8e9Xb3+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFA18FDBA
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703005; cv=fail; b=bA3w/GJVQ+SSkcpi8SHmQlLvD2YiIR3+XoGcMhkQgfpZpFZ43os5naKCQnyNoiaBXIUd2pnoxAhYayJhzG8XtTB48B7IL5VSA6qSGxVS/DBY4iILvkqVLl9FBJKeJ+nhECOb+lOD9t0O8JDCCkvp84pu0R/VJLpTsPW7W+cqAeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703005; c=relaxed/simple;
	bh=jdA1hycZoIy4YF+lR6j599o7ULAe7rOtGIR3dZbaeeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ft5N1d4qGI4jOIEcUtZeEJNQDdzCMXxMhg13iDhrN2+IYQiw5ZOHUi22haRe9LZXsVjHsRG6+kKzknvh28HErskG7Le/ugbMhCA1otNbldY1C1CA9+1Px648uSNoAVji81I+iSzgvSYIjYzIAKVOOkVaYyRkmWrndxndnCPVzj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=VfSUMFYc; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=V8e9Xb3+ reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 90B3A2E83B3
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702747;
	bh=jdA1hycZoIy4YF+lR6j599o7ULAe7rOtGIR3dZbaeeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VfSUMFYcTCNlCfBCsLZOtCWcsmAqAn9LPMy4zRY+CZE+wUKTSs7afeaGHt1p5w0x0
	 qqG2w8JEGX/IfCwY+W4auspxITjU075xxOkTVtLibO01UmqIrBjoZN5+H6cO5LFWRi
	 voIlwD8ZaGOaGzxFn88yTkfvpuXzEYV6VDnekEVQ=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 5213E2E826C; Mon, 30 Sep 2024 15:25:47 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx302.security-mail.net (Postfix) with ESMTPS id
 A526C2E8267; Mon, 30 Sep 2024 15:25:46 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:45 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:45 +0000
X-Secumail-id: <12ebd.66faa6da.a3674.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODcV+c6gf1UMxAyHXXsOHMct7d4rgNMHD9Ddb9AHUqLH7DSuYwDRbC/y2dY99E0xnh0VoCAxdSgq+0z6AwHtRcYjQFTJOsRYC+77DbyT6zp8ERU24Y9+IakZ4tU7mOGUoyExDGnv/UC2eYC9JQ1oVTzZvCsGxHHpBEuIxAvmrH6Gv5d6+4MEQV7UNcryKhjRv2UKiM5RPVoNkQFxyzpJavwbz3kC3M1SmKrTSG6j6DxSw2Pvxm8AY/6E4RKEWGI/LhPfQ4qXe9KHfKSoXZa1ZpYmD9YQHW1Xaeo/nn3EPeWaR6RQxYiOXC7VfY/e+Y6zGtTd45DKcJIvjHZtovHRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxD8NkkXvogQ5Ls3XB6A9/HCTo8OvofJqcrtB2soP4o=;
 b=viWXwiSTpJZjzcL77DrJxm3Dd9YUc6Ck4uj1nKn1hkBEr0dSU9KKLB/IGudO43sDyr6eTBWNr9QpsLKQR+uB+1SMFu1A1qqWJSS/zUiG1sNujlYanW52eYBAkAsKvOkDZEpEmfBcPfly/NymjjlSLPpalhkiXTMzwHjg27Q7v3XgSifuIsIo4nzgsImRZfmCgjy2EmphT5lIWPDthQixOIcvLwNzYU9hc3cQh33S/SuZcmX6O7vJQsBbfYVX3/ZJhwG6lQoVe5rmKg+LtSB3cbzmb8VxgPHyUNDJfnduLHrMtuwdWdRtpzZYRLFewPIxpFcxrHmVnzsAC1JmXub+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxD8NkkXvogQ5Ls3XB6A9/HCTo8OvofJqcrtB2soP4o=;
 b=V8e9Xb3+vIGNUYazHIcWMHFgr3FTbqhWLycymM+oq/Pqfpfrxktcl36b/XvvPrOSkbpH1tBNkIcRoblWY6LTJ0UV8EwWU7HVA538VeMMOt/VUHfegmlC8DOuZmP3nMsc4KCnzoUDTrEFd3Cy6P2k4tcsSQMaMacT2rhTmybbaft9ZmpZBoFWi5Lxa/W++E4O1lM9oIa84xQZ4ODEMjtu+71+OVXiP4XRahB+Ftzq43NxhsimCs6CDK/PE76rQ7pLI8cWPiIPThRjRNJeoSde6OR8aSmGl7mma3dSzsLGdviB1XgIf+QyozfduV/GqmesSSKWLQA9qU1QggDPYu2o+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v7 04/10] loongarch: Use generic IO memcpy/memset
Date: Mon, 30 Sep 2024 15:23:15 +0200
Message-ID: <20240930132321.2785718-5-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930132321.2785718-1-jvetter@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0048.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::23) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2707:EE_
X-MS-Office365-Filtering-Correlation-Id: d6770974-a6a5-4c43-8d75-08dce15363d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: /gbD9UZ8GtxkNyMSX1qH1DDgiupwGtARnZppBO1j+vZqwNb5yXxHNO4JWbkSihIwRnfxsa8TNApkG2met0ieZVS2NmE5XKkUcSvFqhhqo5aKYYxteUlq8TUHi5NAj82L46lSQPwQ2tZoFj2WekPTyZAPnVRKdc4TVXzYmi4g2g9gbss8iUWLGO7IVggh8Sz31hltXnnJ6Yvp5qWFAt4mge9qWahUujQQsKfBm+eN3ikW1snbKBQ3aFCpuyiyjRqo8/BqPNo64MY6EDWEC+Dbusxi2SJqBztMwBJYzcD/yuSsku5sNlMLzDM0yZHWhDoy3wpGYIWtwn06OqZazYjcPKPlYfJsRHXVDV1KOK1KIP7Jh4ZAchFbI9Va67b4BZMKAtZ5W1z09tbbg1fbYFIGAN2cwJ2O8rbhqTFAwHSTNSCMyw1HVnNTohbcZjR2tfqnlxciCT+So3FhaSkzAzYiRbD9QWcBWadiTcUHAZKNhM90QIeWhd83YOfbdxP1otaBIT8TmX89x9nL66R/qfLCWUcT0mn/1xZOux6x2XCrEMzYPVaSeQxVUIiPA6+DNfFQ3GaKoSgcmIcL7h+ALsv8Ki2T1xOQhZZbQ30ZUPzeowMmYImC9Xnc02gPPfgiLgSg10CFyYEGZBcgPfRK+7Tvne7Z8dBKXCbyNUcycC6aEStOVcgwfYkXCIhcy5KpjkO1K2mYJapboHWFBHj+nZCHU+Pnk3dsBTH1IpZkAk9B3++pstgX0tZl+cCYhpycgSQsmpxghbxjCJvPOhqqY0eR3NUdCAiB2tuo9D7z06VK/ocviy0A96Q2TroY8XquHqjUW7gQFrNWP6S1iK9qS7KaKsWYBGQ29MIutz2G5bd1Uj6+ITZii4s2gvDyD7Cf9uzHXLz2lrOu4CvbaFeXcdd2is362FpPf5DIo3xz0E/hd68W1Q4NqXS8ilu+w4+/0ngvi8D
 v2vV1Cq6hZwl8Y4TbbS0gUx4jUwrvgk/W8ciH+oFYQHz88g3B1sfhVRzI/9HJcc2BNYlDNvOuTV61v4/LbzUdGVGG7Hia81KSNvSHqT2eko22kIIDrJjTN5nBaTgeu2mvz+SXonw6WdjwSDq/JL5dCYN1qXv0PJ5/AkEiJL1R7v5tyoT4F57bLD43H7TD/TxJHlIcAhHCdAkZ0CWIh+EqwtV86kNyIDn03q7oqkUu4LUVd6jjhFokTvaL29B+HTazznTOovUepljozzwUuD55PZJid/GZSOnMCC+uaB7Nj54ba1+1irahCKxXSCqhhntPYSwDM+739w4vpb6sV5/X/4TjOlIQzuBth5BXLZRaJvAkeHEZW2jpZvV4ZCY/Cqt7s2bAqOZ6VOyp3s0NnkSUvxKKwtaqkKK+mfZ/pykUprm5rVdvRGFYLoElzpWOZjx9wivDFg9eeA44nxg00qHFWCRZeGB32i5CsCRklg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gn2gAr9L+cSNBFG3tZ7deuIpbSmuMx8DfxcQib+t31/pTksPD/X4Rz5coYHhT4WkoHPw6vdZwYXee4V4buEU252RNdfizmjEU851j06yjHqYiZG2jkyRxvE0NP6OV/aCKsZbWspAnIQshYJExRz8xxmUciwT6kdJZPa2H/4BUAfcM/+jnBtKOIiy+2Ll5i3/+nmXiNNJWmiIXWJuICh3mrhPnk45KWZtYxiYt0lqg8guMKkhvXSbcAe4r28kzdtP4dMOf/wgKKXJHdEP+gWMEF527hgWKlAsmpjdEWABHQ2GW9vPJgLpPU0xbtlUX8vpy8YVJXz6vHaGF4N/WYnymUN5dTA0ag8AuPHuLr32OJFyrnYI0teOZRyMehQ22HF3Onjgse+YwPYzosol8ga9QSHo72JqUY+JaRwsttyfYSbxXF2wYFmsGNqCiVN/H35fwyB9Ot0yQaN6IbgKPqElO04mNIKqdA/jR0fhf5KJAZcVmgWEBQtDX4wAZQuNl4RxNhF5eQMEbKWR7SwEHLJGDo+WAEqId/Kk4K5zvzrlPfskKJVZ+ydD0L178jMiU9f8c7cj4ojqVuU+ZbI9Ukw//HUxL1AqMWVG8UqVuT5ydK81KZFFBydbMeZa7CdGes5zvOpyabg7/riOU+ZUFAgfeVO0AgK2So1gmZG1QPNW2E6gTDr0YDwHZ1+3JyPBkpB0ysMfDRmjnEX4r/hvtajbN5yAnbP8JIESPjuqA5y6DelHvGUs3/Awl6kdOiskn+47OCFL/X+decmGrz9y2/wxIlXLR0EPvxYYh5Dt4GemuqaM+YtkRJY0HHDoMEzekeJY/JgBS7Koc6PENqbFY4mXBjRxUGuGfDl5oEgVXENSnRbvcahYLiChHpmM1uRHZM6d7gKw/8innbECAHOTUB4WNiZH7srmXnTI6EKUL685QrzBVRK3H64iqBTIiTZyDWRL
 PeBXZhpFuWD4705FEa7KWvrVgXvTnUbmNftdrtN1jvwaQt76eja25IyRO1Deat0svCb60VHnLX9RSYv0mkQCvQjQw7UPwmB65fsrRvELebMnF6tEgtqJllRaHmPOvatY6YMWnfjf0iWA68zGmZwJ9cvMIzVLPBROHNSz4evPcADudzVYK3GS3G1w6pmcc15X7eBEnhudYK2u39gCAzRszy80HSVYQ9L+0f8l1ZerR2ANNIGoO4HFdXJN+JtGljDoHsnaBblVRCq/g7UzYMT6ZJLsw7NgWTM0treuvGE+HQssfFQyvSn5XN2+1/s1ajGRHk6aDIFrb5cQEHiocgYyTXLpcnh7K11M6DRitjcbkBpxSRvUzNRBIcOBegcMgRsHrKRy4ZNbb3tDg1KruIHEyWRUlc0qdwnYHMEbl/MvUNd8hxOna6lH15Ayu31RZPj2eJ9ggf48WDhSuvYsV0a0bd/ZNU97hzdusQm1QBkHp61kyGVR49mQhRtiIRtW3Q50CBLZ9yhsIW8cQWdRzC/C3Oraa5d8thvjej6FFJupVPJXefAPoHb/X27/juzUWdjR1qPv5fcZyDubHc4TORwJ0XOM8Cqv4JAMnpc9v5hYP/mHGGpotLtt0jXIv6joRELoci646HeoOMXdtFHI94bycw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6770974-a6a5-4c43-8d75-08dce15363d5
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:45.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNR47V+v1+VI1r/FyI90eqX8yBM2jnhS8NQUN7G4Uw7saTzW7Rl9U7sjhSXDt6Rj/4sD7SbBq2mPPVcAa2XH9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2707
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the
loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- No changes
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






