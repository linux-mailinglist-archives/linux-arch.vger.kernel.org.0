Return-Path: <linux-arch+bounces-7494-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8998A503
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B71F1C2180B
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E84C193067;
	Mon, 30 Sep 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ZYt8PzKK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="ga0pnWQH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout143.security-mail.net (smtpout143.security-mail.net [85.31.212.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C991922E6
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702766; cv=fail; b=jpWWV/YCKFCOm9y4kGVtKMmNT9BIHQd9ru6XqQORjyeUzVQTLUCfEw02MVBnljWFYZgV9lPb63hjaTdOonSGUntwGbtWOtOnJXLR2vQOueR3eQCQOPrPdada5FP6lu8Q1GDG+q8qVB7nqBmt2LRPoONswRh4HNt4/oF0+HuoCWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702766; c=relaxed/simple;
	bh=ukrwx050JaaBxljqyEKdw4xqINChf7K1z0RA2Mktalo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZ94miX1kBzR/VUhNXnSfNSNxNFfKYniBbPannSOqMXU8W1EEXXrNpgdMe/DhNy4GJDb4b2YyVuB8fM/iSlRkpS5tk5FXC2J77GaXj6YZkbp0DslIJHaOOXza7vulGHdQ0eiXFbJ6nvdRom0kc1ErBNfr/9eBSx9G9WTwoNxUpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=ZYt8PzKK; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=ga0pnWQH reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx403.security-mail.net (Postfix) with ESMTP id 8F77182ED98
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702753;
	bh=ukrwx050JaaBxljqyEKdw4xqINChf7K1z0RA2Mktalo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZYt8PzKKDQG4zoF3wv5V7zONwCCTO5d3sPGbIP2K+cTzzqH7p2ICojyzqgIKU7wOb
	 TRsbXIiy/QTIBt8MMNOrvKnijyH3i8MN+bK4Tcv8+pwxHPqXu1bYqkQdPJEe+Cv6HL
	 3itQdTCPuD5+1Wnf3kILYC5TkSZCUOsF6P6ttZUo=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id 1801F82E028; Mon, 30 Sep 2024 15:25:53 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012055.outbound.protection.outlook.com
 [40.93.76.55]) by fx403.security-mail.net (Postfix) with ESMTPS id
 AA03882E7A8; Mon, 30 Sep 2024 15:25:51 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:50 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:50 +0000
X-Secumail-id: <11e55.66faa6df.a6f63.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAP1yuQ9vv2xWPKcYdMI8HRoFWkYBeSqJvE7bQikRrsbsj1zqhi8LDAuM3asa5wigqMxpI+x/s7d1jUwZTt5MdgpQDxLhZnAdL6z4pF9zAtRP0QvSLtvHuBZ3bfYe3uuElaNbZSoeGFyGxvb1hLnnhhywq/YYVeoAEslF+gLTn3LG/QFljrtu6Z8kzlraCsnNvt9FW+na7tArgk63gqZuLsVMPo9Rlt+8yC4ZxATWhcBwhy/zKS8AC7GriDg9/AD+bR06IXE8SHbRrv0+B5SsYOafdCcnTaG7QFltZp1D3ByO8/Oc+dKvIUn6gmqbAG6+7kuBjeYO3H5o3PfCvgLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybPULQIYrjoQbFWt1yfoeRQ/AkjC6WMZM0WN86tt03Y=;
 b=Hqc2+wEGCY4kuKbAiNdZrtSe2/gF7OeVejH6ZH/upaWCRSpD0JNi00sFt+d9LcjrHX6VLNBsy9GSQHp3h9hqKi6UfFqZmXFaf2oZcA5A9uo0x8PJ1kpjZ+Z7Q3+AsV3UiddtSwVJro+mxzCDy1YA7zY5/iBD8pe4nndL6agYOujItVpAG79jX0ssUilTPjmySyT5GSDHaBfAWTr8S16WEa1cC7kAJZDXFP4QxASUt2p/rGZqxlKI9OxjLBfZiA9aUXX20cyJjAHek8R25DSzCugz3+Al9Hpa+vkUMJJEmP769SbIxBbXF5bIfOT78qBRubvGQ57pwgB2JQsnDL9caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybPULQIYrjoQbFWt1yfoeRQ/AkjC6WMZM0WN86tt03Y=;
 b=ga0pnWQHh8O1FSgj1iv8X0xAV2DltGzraxhGlFr6OXbQNii2+a5/T8/T74gBPA5gVaDgoCHd9GOZKUgikNmUQ88Kn5WN9FAXuyD+zS4RGM+7lEQl00JTMTyA34lfQ0QD48uYIt2PoXGjlEw6UnUGeFHetJ2xcWbmJoFKKr2IrI4OAp6+jx+tULNYWEJ7c8aj0DzXtvaxqavpYCvREDfjeWeR8Vg/O1VuX7F7IIO404A6aICSL5A9kKJk2S2bvPuxyE/nRKj9m1QMeKt5zk4i2UDwL+Z2157hxB9mv2LslqCpT/TAvGBX2p/k2X9zlC4vuER2vSoS2CnyHSYeAWZRJQ==
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
Subject: [PATCH v7 08/10] sh: Align prototypes of IO memcpy/memset
Date: Mon, 30 Sep 2024 15:23:19 +0200
Message-ID: <20240930132321.2785718-9-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: b5e74cc1-c729-4e72-0eee-08dce15366b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: J0epSVprmncrN8eGjo9lOMg0weLOmFA2sXLH4FBuS9O5ybkLqO0fG0sghug2Q6cL94OalqqanAkTJ9a+c64O3C2l2JGLpdLBwe6DyfZ3hdreoIub2JbJSht9rrzhNKkuVYp26Kl3tsLeiTtDw+wWqIlgPuntkp6ziQzNkk+2G6dq58l8KC4JY9Xc/0ScC+eaGXvzqk69XFXcV1+Th5DP2oF1hw17gLC3VmWUkKiwPSq0+fk3+P+r2XmIN6yFs7rxk/t6uXXUwUNzyyDZT1y/C9AO3tpIjFW/XiI2wm+DQfdfypzJW+QR8SjFBD/PQRggPBRXOfrZitN2Pyii8KDgZPvVJUK3GZHCY7Rne3eJy2iqqrSobmNAn/sR2ihIeuf5GYOPq9eyCyA+uW2SmSiurk9sCIfzq6gMLr1SK9K+Fq5s8Ir2QXcxNLly5WwyHpHHRKt53EwcYt48ZmmvszZwrbCQRlI5Rh0LSzrEeXEE2sLxOgcKQBqafD7zZfvH1ZBmTul6PgDvsbvCGSK3Hh8K39xLTh8yabXU/ZnIxW1LZb8/EipbBZR9Wvwv/0HMsbut8dk2LbQe5ebJcAraYRSeeSIPCJEGX8Bgi9IVAAmTLy0J/h+2X0CSpYDkqjABSB8LSNvQvlfakztJxusOwtpUqokwTgtSCXuuiQ45zMEv8H0+OGbmUxPSHgC1Ds2BpilmllXSpdGCrqQBV0SYG8QDhibo5r/Gu6EYYqiKxah9IxRp3QFV9mDxlbBY7j6SgWSJijGvQ+ZK48ZdxjaKMmoIYMsxvSA1+1ZPJX2u3BGfFBbDpAuKt5XaJJfm3BuRMFwlNA0Cl5Oa+SRmYG0HrvAEByQ4AAlgAZ/HkPfDWO4tfJYfm2Q7Ua1/bDEVoT59t6KrFodp57exdXn6cuzkEudfmmq4fq5tqxTaeqHKaTV+4bx9DgJiC5sPAGdb1OuFsF1957J
 yKpLGPcnn4C2Ko7qwWBKK4NEBTDvVUsRA6N9MclHtdH07nNgsBzwe8r6fL3zEfszeQech/1/EX5zGZfb6RbmyfcgaZeoj0Nn5lJdyx2S7qotJeFoWbiIj+Yg06kSllQpLMsQiUkJScHHCeOM5Ex8Jr3EXHQ8z/scz3BpbYR8ODqOwa8mlmlSIVM2/6qJd+9IwZ6V5GJW/0aZpBN5AKQ2ImGnf4vGV6+PAgIWXFAGhBbxrFFejIRDl2jTNdP7Ld1+YnKqpUQlp6cZyqsdh3/KmjRepiyybxI/UPfACzuLEHE+QmRkVDk+lPPOyoL1OYZU1CANj3qbo5acgbXdxyOy9LrEHIskSbZycjvg9tj1UcStzxbllDVuA08Th1Kt69z5R/M7bwoGaFJ03QlwpQEshvMD+Xn3ZrusSQjeXGt3bEl7q2eg1r+33Ku7krIh3xu0JwUh2gwZPse39DT0K8lwNSWCQ/5xqf9Bl4trK/XM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MwGhWFRE9O/vIfjIyQFotPeosfk5DUZQvYCs/VDlAxZl1etMwck9Ev1RbvccSo/XUIU1hNQ3GW9nbwDOBmgBeQpp657E/6koxKrOfN8OrVVeODonhHeRE90cGd0DBc21oWtglSvHxAlri7kQv5D7kUDIN2LXll6r7wpVc1AAyQtX3t2SZjQWHbDsIVJAj2ifdlSZpiAvQ4epj+14oHaMELXLtqzoO8WXw7Nr8p2idgWAfvE3BPLEWux1JSMnkhsjuXICgbUgWq7cMfpGykk4mT0vEeTZ1H8SRRNWUowPL3otJoMzCu8DLE0y3hL6+6jdk6mgL273cUSf1muMtkwWk2Fl6uc3RGOKMjYmfY/sm5/sEdTRpXN7zstsJU4gfyN370B8pd0+XMnVyO1jxRr4MFcWii6KQGedqLnVDQXxzxzLWPm+pL5Ohzw+eif2uHWO5Ml3+QT8qpmyXVEl+/6X9izskQNXQw4LPi/ztzo57p/P4pBP4q25BiWXq0kiFKwJjwIku2QST3/OGfaktXYjQrNtb4ZZU/QCeD9H8EV6uJVWrPETP8MwflTr2E+rvDkFk5nSxQ8VYaKu5PhOcFJdVEBF58ELGKjfBuQiOyrbac365g4RzU3esUBGtfGOAl5T86BdC6i6pl8xJdkWBlGLgB46YcVCqeyYDGT8nBImSUpOExf7IVyBLylqQJAVcLauUN+fFYvZ7xYTIYXuqUVL2VByAknbA1XWxFqRKdQTrah8UJwV7aP76n/x/DSLgtqVhl/h+ZzIESTvOZMIgK9dqFbds6TG94T0Lf66eum/vaHq3b/qNeFR4Ssgu7OJwYf6snwUWtfYJPmF+a+Nf93aOdlIg8PRdVu1uQswa8zjdp6VyKtcYbI7NbErvbgpcd3w2erdQ8A24kW3KwAatKkaOJZnvWIWlG2bliiaSkJsVBvL/z9RaPGMhDns55C7R0Ce
 3iX9yrPf0gRYRndF81p5B3LSfyBkp0knli7AYFgltG66AsEO04VswBORjmCpqYY3wDMlGjAcOykG0BsatmzCnjFgHsh9ny5gGrKNcSvH3aqXSFWZSKS4xydFdAY/m+AcuRgNzjPNBGj7pNMG/o0dt2deLIgpSfSXlPQSSb5mM7LL9yvtepU6NCliPguWodywfo2puh73Zj6EJFlvcGC5KooTCS6kBqcfAspb0qhGKBUwyg8EgyIjuyF8Yv6cG3iRkOBewDXBpzcCPFzM1u99bgCTd9PaCuAqbQ2jtJCwZdY/HgmEbeS3xVHKEh20NofT5klKVWe9XwmgoYDWbn04l1uKz9oP8YYV181cMUYPELOai3WzyIhbmlNO5b/xGTlNScvQDnfH59MPMG2ejUAM1xGNHRKfXhtf32WSGSRYD/1vfHHmpOQvruesTR20G3J0AGLAqURDXqsYauWV7++aevGE9qLV1xzlBUWCFTXcL/gvJxzP/oGbG7uNd9yUMI7hQC512iESC8wxi0037iZkja+XIDQ4poQQLHrIZqxmRmC8XXkcAziGD/c/TRuNGONoBGMU6YOptvGEcmEAtBI0CWKUNUxhpDam3BXKGJSfEKASjOgKkE8LuLQGwJ14DDHDN3yXDoiQKbzB1dImVScSdg==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e74cc1-c729-4e72-0eee-08dce15366b4
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:50.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqcxWgAUcQ+NbIbyJ4JbEzU8D+bL1JDnTwQjJQdEwevT0lf3ArGUADGdmg389paQFZV4zIdZZ9ugSd1Hs56PuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2707
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Align the prototypes of the memcpy_{from,to}io and memset_io functions
with the new ones from iomap_copy.c and remove function declarations,
because they are now declared in asm-generic/io.h.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v7:
- New patch
---
 arch/sh/include/asm/io.h | 3 ---
 arch/sh/kernel/io.c      | 6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf5eab840d57..e5c780eb22d4 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -272,9 +272,6 @@ __BUILD_IOPORT_STRING(q, u64)
 #define memset_io memset_io
 #define memcpy_fromio memcpy_fromio
 #define memcpy_toio memcpy_toio
-void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
-void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
-void memset_io(volatile void __iomem *, int, unsigned long);
 
 /* Quad-word real-mode I/O, don't ask.. */
 unsigned long long peek_real_address_q(unsigned long long addr);
diff --git a/arch/sh/kernel/io.c b/arch/sh/kernel/io.c
index da22f3b32d30..588771cf9b7e 100644
--- a/arch/sh/kernel/io.c
+++ b/arch/sh/kernel/io.c
@@ -13,7 +13,7 @@
 /*
  * Copy data from IO memory space to "real" memory space.
  */
-void memcpy_fromio(void *to, const volatile void __iomem *from, unsigned long count)
+void memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 {
 	/*
 	 * Would it be worthwhile doing byte and long transfers first
@@ -76,7 +76,7 @@ EXPORT_SYMBOL(memcpy_fromio);
 /*
  * Copy data from "real" memory space to IO memory space.
  */
-void memcpy_toio(volatile void __iomem *to, const void *from, unsigned long count)
+void memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
 {
 	if ((((u32)to | (u32)from) & 0x3) == 0) {
 		for ( ; count > 3; count -= 4) {
@@ -100,7 +100,7 @@ EXPORT_SYMBOL(memcpy_toio);
  * "memset" on IO memory space.
  * This needs to be optimized.
  */
-void memset_io(volatile void __iomem *dst, int c, unsigned long count)
+void memset_io(volatile void __iomem *dst, int c, size_t count)
 {
         while (count) {
                 count--;
-- 
2.34.1






