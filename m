Return-Path: <linux-arch+bounces-7498-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D978A98A551
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712661F244A9
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDE2157A5C;
	Mon, 30 Sep 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Wsn0oHTk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="atf4DKl+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CFC190471
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703038; cv=fail; b=QlxAXsGtAkLV1aQkW8aOgHEmHChb8/NdiES2JZFXjK+YrrX1ZkgDWXZY9a3/6uxixoP6hiWfirtOm3JTXvhA2K915JxDi9idN7mZbuK9NNCy6A7VSNUEMV0MfF4Zjzqe5qik6lNahg2v7uwA7YRwYhJ6xRYTaNx2gI32TGebnt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703038; c=relaxed/simple;
	bh=8t68wB5pix5hrTaDx679fbJxbV55ESDr4v01ot6a1wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBTi06ZnSDf2WX0X5+JCTegL89g2omsWo/puLOnUGLyYs7c3/A3sWEPcGOUXS0An37dqzFPOqfltarVZDwI2z7qTP+N8ZN0SbMTgPFDTiz5kDr1qBAJwdmN/M4ccQmmCXtRirOy72bliQyYir70MfhNk8jZO9sPUlAGHXTfLMBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Wsn0oHTk; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=atf4DKl+ reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 96D3C336115
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702746;
	bh=8t68wB5pix5hrTaDx679fbJxbV55ESDr4v01ot6a1wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wsn0oHTkTJ2xdEnnGby7pT3ctjd8Zr/r+eNakoFsjM/VgqKVvSGw3hnx22CmDjREE
	 1LiOvUOKg0KK68vOHDFwdF3RegKmPXJ2O2IO/vkcut7jyDmpZo2dFxDvxmvBQc1lzm
	 AmMkhAoQWaSe47+RnYAqaUMt7nBXap4Yb5mUVCho=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 9BA6533606D; Mon, 30 Sep
 2024 15:25:45 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011027.outbound.protection.outlook.com
 [40.93.76.27]) by fx405.security-mail.net (Postfix) with ESMTPS id
 36650336040; Mon, 30 Sep 2024 15:25:44 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:43 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:42 +0000
X-Secumail-id: <3815.66faa6d8.33b91.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1uTR3xHZOnwn4p0iK7r0eDWhO5sjr8qVlRt2Ehg5RIbhcZ5TQ2kHbMoz1v9CI++ZXOLh/mgzGkjNZjQyNYVGHEoThHHF+gbt2sU4Ef9GlUNS1mEvGbSEFFFGFOIEUsbi/j+SXg1m8mca6RQaNxOS/pMsyH89ra9doKuLXqQ/gTlBTDBmdvi5CzztwEQUYIv4tAqLzQ6LqxmBYj8nW0eBkZ9owBrFjDSBSW0G5SmuohF9v4bQcfUL4O40DwgvieIJGsoVTCKuB/JVbpZoj27TNv7uCkB7ak9ubp2lhps6dO6QDI8YJeShEy+9NqXKhgayPYd/6oJp+ST1lEf/xRN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xckbnZGbjgNKnz2mTviBweWMb8Bo4FCviJuD9JIdd88=;
 b=zH4O3IY4DKML9MoQEUrNuBh8TI26Q54c9Cs0F+po7pP1vJ8wGGP059Irn9po/Ads2d6CEQfT7aiQZRnTGoDuF26UxStyVpf9iolMZySjVWqDI+ynzojh8jGm65/XT/yNdzFKa4UKhgPcXz3E4iOUC/BMBeX2AZ1rbg1UcS9pT6VSYcPXidQ43ebt1Ez/i0xTYCkyOtsz79d4gUqjkTDi7lO5PoTFIYAD6onlZ3t7W0+hXAIao1lQ7UWW2x1mKrUBr72yS93K/93Z7L0JwOIaF7HuTr/dncTQ3jOb1cPVaY3EALHfDx+FPFJnBljc4CqIa7VXCTNhatCaXhWULU2JIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xckbnZGbjgNKnz2mTviBweWMb8Bo4FCviJuD9JIdd88=;
 b=atf4DKl+zB/DKvV8gEykvge3e21IbSY+jqR6yYvz52U2tPpwUxZn3nNxaXcxoV2+O0oXkbhnQTdDREJj6FeM1g4gI7+FK0TPNr4SBjElu9JkZxWD3zEjndOw9CWPOJR+j5qJfa2X6sxZwkJK8JiyJuMpC0hSkZW2FpsdZx2WqSo7bFArHhMi3EW+QTpSosRAPI9OhW0oUkrnKN8pHxB04EbyH9IdMBTr9mIuGimSEBsqfGV/+pS8cKSjxFiuQg1C48PUorb5jt5V7cRUXiOPbumkl/cKstTVETO4I8UM5Plrseh1Ij7mF4WPMnstDIdlCURmQBNYXPep02u6jvTtDw==
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
Subject: [PATCH v7 02/10] arm64: Use generic IO memcpy/memset
Date: Mon, 30 Sep 2024 15:23:13 +0200
Message-ID: <20240930132321.2785718-3-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: b427a81f-6514-47a5-1120-08dce1536256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Uie1pJpXAnk7doJh9iq4vKo6GZ8eOFj/1OMDZwOlLOsSE/Q7f8SC7+t1At0c9pvYQ33A3Zm1lFxdH1niXMb8YK9fwkCKQJUHV3SRXagIbN+W7qhx6JtEAA7EQ5Dvw3LDV6fMR+9QKsCUKDVUATkGcT6a7Vm/fZfr4ZvtuA5PKWalUqJbjTP3RcnmfvSdNl2dpRXJDletfRSAhRqIQucvalEB6/E5BGyrMbNLiqTLmNg7J/jattH/bgsNFN09yB5a4OIMdT5I9Y5bloEPMOEIUaW8pgoxP/4DpU6UXKSZy1O1a0NI6Bp3SMi4cqUWB5HZok99RwnsjxfVHx2OqEVrJgZmTZML+DRyX1ismuB3SZJ23cYCc6oWEJ9O4FRW2cg5gfZQDvodscMpq+b4ANin0WACgh0rZuPtDY1fHjPXXRBjUGmUu97U9am2O+yxbypl5uiivvn7oAsVMq04K33rO3pFIjT7NZty023J2CcWws9MFflxtUUaXof0LMqQ+OEb3LUmsR8CFyB1Z42YSu71bm8f/I3fV5aGdCZpCwrObPs+oDy+5gff4pLBPh+pD+huGmO+nm6mxkb5fem1z3GbEpokr7E0qXRACFj/UbGKLCV/DtIy7gXPBMI0WJh1z7jxOS2C3SqTCd+gfo6Z/5r1VGSqVRTkVZ/X6KyMtx6wU6PK5xCkzUhQisp6CqMlvoIO3uwIYGyiSiXPGfqjFoQTXg9SH7pKNpxEar222fN1UQ1npzpNdaslkCrARWYwkrzCYUKstaBvS03aG9sWBRj5s20ZCWNoPcAYnRFLVnGkvXHDyVIGIW1qUcEG5mZ/IJUmQhDgX7Z7Q9mWr9HUhT05uYxZgYOg1ILyNtiyfKIwns5lb0PYQpIcfGK3zH8+PP045p4LE/FqAZBOupxVYAQgDFhAM+WXpuhkhcU290cdhPmuO2MR5c/bnfPTRPjkf9O4aN7
 Qqc8ThGqeRl+Pw7YHAtnH/SvSpkGBjgVSEQv7E17Lq695w7m5dH6H85Yv+KIkijdrh3s7GGp6EOHAOodkLz6BAwd73jHsRyCNSQHM7IlUWmNbvurtMt8iFE6l8+emA/DIRbL6g+twMH4twJe5YelWwKnF6ne5/Di95qGUX2tUFDoDU9o3iR/eTXVdzAgoX3mDdv/188cUXjBWtFK3N78oafQDUMzNhtfl2PafkuvoWPaG34et+Rvzno0+SrafWMckHGjzI19+Uwz3XFtiQ+gIxeZYPj1/vnOD5W/LCj/zM78Y+Yd/SSbZZBo5gnJ3hfNBm//MEyjSs5NZJKhWXVvEAS2ghvX3ItTiN81WAJ7Gkl5G/DzaE/wTCxpj4apWZDLuizw3b0Un3k2VQI28o0moDFH3CqId6ewHq6DQeXqKdhimbxcGGhtG2K9/nBumZ0gmNS10yqxSQfXe6mW4mSJhZriQgYY6CKEFSJIKmsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GfmFQIB1UN7Zz5TWOXncDUHGne8B+BDFrmmGgnbP8X8dAuszZ3UMTBDyU/tachge4vssRLM0qN+pFjpDmyKYc39w+dqh7GlxlA69uoQfzpoEOdvTDQ1t0+v3XIFrLnhvbThIWq/z9mO8c8TU/naT9y27VNfYWNh71a2UPp4mJVT1tHWxWriqE/jJGs5/gIKQDWphphntp3rpQnKBmO2gH52wopC5Is+ERqP/byQ3GqK1NoSkSRS6Nw/dYlSq7qgjDjrwjOaXzqBBFu6BwrSgqFhaoV5rMw7kyI7P4qCbqdNQuYUWIw95M/EAXtvz6PFikf/Slq6HU2ch6R1pkasOgWK9LKWyyyh8uGM//94FJMgzW8hu3Uj9wFjP9EzUNI44NXA++nOuFRGJdmrE0L7WtnIxrg24fNHngd/lSaWQl6ZVJ0tdh08dV7NHd11C7f726mf31+h9pCHjrLA7goNcoSyvOqTNdH8tkrV76R2Kpqkrxb87zBBnopiBjgDYSXPbKRJjJgV3w5iNpVd+N4mvU+n+RbgOVWhcrE/Fe48+TSZBAy8dS1zAn7NnIJnvuHD2Rv+2DyJy3us3GI2rLlaN0LMov5IyfDw6lIj296K2U/AcKWVBiVFPZ3gj9RaxcxYp/xMWFuwZaa9g/Csotv1ly9zppsT+fghgSY+xP8hQ+xA705qCIrcAgJwXZkpT7yR+5egf1qPWdu5eu245728SGO6Rl+jBCTM4DwLaN3I9d27bqJiKLYe0ifKL21FX8IKChUPR9ryY7f9lTeLq4prDI1phJDTHG0DHzqfd9Bxn8YpKB+J55WcPBhw52jCHduN5zX/24rWRn0eRw3CatXRyDwsUNGilGgdWKWTpFnrxvcKs8WUnPaPEpTABwjbWEkdhD0fFIH0i11NmxUWGtgfINqSWNLsIsLJCz1LjMg2dX7WjOp3aB8+AsYF5WL61lFlb
 BTtNvwcdxW0WQsSoquhqsG9vEcjjkq6VWTFXiIzmAgZnt9Lvv+AxyvTG3Gl5CmjKtaP0anl83K2I6XrIDb6lW7GzEKaxuBBuk1gn96yBIRqJd1FIFZyGUGOOtTzo3mHZvN2qtVRfeS1InKIyHDL44+8HzbFM3OriJIAwYy9s1NClZHkmt+UT50G5BH9BeKgGctz7Y6wGwpCE0ULBdm+uDCjD5XK/5OaO57hTKB0jbhoaCHXr0QUjF0+Yz1dyq5zdcQpVoqmBXXYmNLzXD3vcKDKQssv+QkoFeY4REAywEhnzf6qs2bo2WZkB+B210/z5xoV3/zNHWgtvUEs2UX41CoiOjB9ks3BdJsdVOFVa16HENOsJQVekQUvW0PfWqsXL8v9p8dR/iMj/V26eamY06W7UzkBzQNDsVGIov/CkRNE0KtxpmDiekLaL0LA6sXXPRn4Dmz8x8KJXdf9omf97gQOlaXdLUjb+Rw0txngLGOpADsTvmHFOPfy5r7mW0yBCjXDc0Vg6xtigzige+6ATRzXdFTsfFxmcBU5rmlnJZvwF2zpdWibvyWR19vFrgae40BKrwol3JQ1gcVUZ/6j5HlenIDPh26he77/zQgIx72wl+8YMKMz8JLj2/ktqjShzTJzQLzjcCLzpf4CH6Zo65Q==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b427a81f-6514-47a5-1120-08dce1536256
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:42.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6hbGexs7AhX8kfSjEUuKwHT/rmVxLnuydG/plg2fyFDWN+NPHG9berIekx9ROE5+atVM0rvuHpp0BeGfL/c2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2707
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the
arm64 processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- No changes
---
 arch/arm64/include/asm/io.h | 11 -----
 arch/arm64/kernel/io.c      | 87 -------------------------------------
 2 files changed, 98 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 41fd90895dfc..9a5d4387e694 100644
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






