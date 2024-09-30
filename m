Return-Path: <linux-arch+bounces-7488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC098A4E9
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE61C214A9
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C89E18F2D4;
	Mon, 30 Sep 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="huQWrVbQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="T1nwbpXm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout145.security-mail.net (smtpout145.security-mail.net [85.31.212.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D850190485
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.145
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727702757; cv=fail; b=mWE+RSIuQlz7E/WUnWGAR5s09rU7lTy9Kso7EuHuYI9DUDUcJBx2mEDuV9HTKm3PR5Ewsv/LL8FYXITcF2iQQQuZS0drBj2YQQMEBbkbiY4H3vKo2+EHBLo9FLtyhII88/sQRh3baAYgyP1WC0A59JkIrzVJy5I9/962O7ct2q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727702757; c=relaxed/simple;
	bh=rTcxmRgHIimI4IYs2GDChJ6Qe2SSX8VZ4x+fNAFBbLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxKkrmTcU4k9jxQPKwTmOaRElAWSRHOXaEKRWeFxU2YiK4jemDqI2R/HvuJw0p3wxtfk/bRHJ4FNV96FfrHJauNT2GEmFhTkkp46saIt1qR+k76X8rbEwrTFI9UTqj7T5rVwgGHqFq7b9c3TuOrQH8sy9k683Q1arw80vc4N+to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=huQWrVbQ; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=T1nwbpXm reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx405.security-mail.net [127.0.0.1])
	by fx405.security-mail.net (Postfix) with ESMTP id 67865336283
	for <linux-arch@vger.kernel.org>; Mon, 30 Sep 2024 15:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727702750;
	bh=rTcxmRgHIimI4IYs2GDChJ6Qe2SSX8VZ4x+fNAFBbLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=huQWrVbQd+y9vhqNOrN9grIqfqj8Fu4jYiqtCzRsRPn0RElAaz6AYDsGV1/hTm9EG
	 tjI0jkeDIkxgn10fhlHFwzQ+NhN2HohhI1VPWT2FKodVMdr3afaVhB9eIe0VRQKRIG
	 lXx73rSK54taE0Pf2+GT/4TlZUetC1jRqwvtq75M=
Received: from fx405 (fx405.security-mail.net [127.0.0.1]) by
 fx405.security-mail.net (Postfix) with ESMTP id 0FB71336221; Mon, 30 Sep
 2024 15:25:50 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx405.security-mail.net (Postfix) with ESMTPS id
 0F53E33623A; Mon, 30 Sep 2024 15:25:49 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2707.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:25:48 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8005.024; Mon, 30 Sep
 2024 13:25:47 +0000
X-Secumail-id: <11e5.66faa6dd.ad42.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZTeDRA5CRBeUhC0DPW36nBEnzqBK8lJTTtA+YOQmEVQCynSzyALQku0w22Sq75zGvW9kRiuWZQVyR4+kSf73dZG6XA3Nh+z332wTdeJ11VRRfI6UkcyjJ+HWnTyDeCY52z2vkBYjMbmybdP76Tboi7cf2fmS1YL/PpfhxVAKNS/1g5SKRRBMtENuAciz6H1MuXWPIq4TiJmLIrpCF0BFnnEPtr+JrKQE8LYrsuHKBuCmkKBfDQGtptkkLWPF3vj9EX+LgUyPFdycFMOY/SOvNrHxEiEWsiduHeil2w1SWTtWOfS7Y4nSNdXFcqCCNgch5JJLePE78zN6FPgM3lRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=182f77hJEr1vVlROCaYRUTGTI/ca4SN1O3ZdW2za5KE=;
 b=rSs9+I4U/n5MjZRy3b/goaO0PnhJ0GNNymrAd4xwtw+0gCGFFSaowDsu7x+TTqCR+EDL9h55QniasjTMy5VE7eN4b7hX3/SGXX+QO3rNYm0xrj2q26YYhhsdJhuFYI8xF1npgHDgiiOwEdXh8qhFYAoPpmc0OIToiRpJHxhCSNzJiy/HG7Tri6GwgAlWO9uPEEhs+ouSu6uOZeSz+xFYoJKLH8G5or4pdpNSbbca+GcABUvCLdap8N03olrRBsDl465zT9CrsKiEAuSUoZOYQRbpZLo/V9GZszTd9PYyrjMVVyo1bI8giYRBCGtR4ce1d/Wq1nxzm3eFth91x6EVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=182f77hJEr1vVlROCaYRUTGTI/ca4SN1O3ZdW2za5KE=;
 b=T1nwbpXm+j2C1PCrC4FTeIAxHyjtSUKLccq8dst9cPJLiKpN7urBDBEyFnOLh5pcCrsxHRamVoQ4qwu2mzU19Wj/rZcxJpQPijOZx2Y+eCTMp3BNh/BY+FeM+Nv5tL6FPMuKK/3n71TT5YhCcqDkUrVfoVLMB8Oj25P8go7i2Fuvas15WFEaMM7qpdebznrK0gcHjJCpzjnJSAqGeOQ1Eve7jHWR/FNuo3YwldtFKvtodkkRUAiMoqBHWUWVRiN0ptMTS9V0UdhyUWlRlNAl7UzWAOqRiut3p03k8qMBeIaIJuAuwC9n9m1iNVkULJu8HthlGRdz2B0ozVqlzQ0vxA==
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
Subject: [PATCH v7 06/10] alpha: Align prototypes of IO memcpy/memset
Date: Mon, 30 Sep 2024 15:23:17 +0200
Message-ID: <20240930132321.2785718-7-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 09e94272-bb4f-4aef-97d1-08dce153654d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: bTXEyEOAHxlPZ7G6NAjsEKXc8Mptr0R0Yy+GLqDvoaL62twumC6duXQXAks1K3zdcnZHM/txGcj3kMoDc8mPz33CSkeF/OXwnSGdTyJD0HUSdJQMizh56xMiXp3mdTGiqk7MsviB38DXn2Jl7juvl5rf6U3cMZTTw4U6mjBoog0fV5uQHKbS2aBQU411SCxE1eHImwwe1uyyb2/wQw7i5Q+JisfNsRG3yUOu4oth55OOQVP6/wFPcZKB7ePtTy6m4Mp5Z2rzEHCHFEnSfjfaxCWfF2KC+WUasOhT9dQIXtzqIYa5WD5wzHScMj49NnKW8ZfLVQjDeUXRIad5uEy8p9NzaYdiqWdHGsRV8jnoZHk4PJ8ni3eIcKHdhyXPZ7v+lZxHFS41XE2tBqSzqjkPZHYuKle8mpp/CJBiwIcBpYDiH+NmNqZEUfF7p4zm5I9h/Zn9ZutA77sj6KqHojBTw7l9wfPZ9fgDO3Oo9dIB0TKRcFuFdqWmEoPydc4oGdFnK/VI3XAJx3r1MzEjbTR0ajfcUWFckPKlFHBt2v1sm82mAh+/HCK6bOqs8VAcqhqPIXF5sdB/d7JUQQmlNzsgRdU6zcb/3byhgFxVxvjtPSdXzpeswG6AB/0bbibtYDu/6vd5U5j78xTSr+K5Gw35XHkRkz0EPJLPtdBkcPs7h/avRLnUkvKWDECRC9zRJMVlKHUo20hoU3F9bUXOdOS/PEYTJlNF2kSJdgMDK8omoRmOxwG3W2JXtEbmr4wei4yM41OtSzz486s+xzIP/kXMVY56u9KmqfO4XCdIajeUGJziSk6SEQapqb0FgfjrPFZM6Ifx9OIOk7IFRQIHj94AXYrU24Bs7DOrrC0zsXKkAh0K5vHgJR8SxppRCl3F0EtHvp9PoHRm/KrLLYYH7ZTpV6Iy/CO/gORlQ9MiPVbn79eZmGadaoxTv3M6KPkiVWRk+hv
 4XuCDCYRal/6f5qXAuAC1H31Nbv3kO58rJrUD++02ZlO1OtExMgPzeQiyLcH212aeppPluzSV1LCG1+qA/PH7vtmjLoKg0WNESDqA9ljkS4lTYsIgqviZCJ3Ec8OzSjYrO4Se2v4sRcImBnv6JbC69PxkmjJY8P4N3AZtFt2vXqs7gxOlOkKa2il7UUgKfjeDPn+b6pYzKydqTU3SekyV3e2YEbBCb+5ie4N6iaQ/rvawy95R34ZUlv+wLRc3Jc0bhZVmFw+KHy6b4RKwgvUwP4v/8sciFwAmVodKDEpCzdkohdTeoeYHKBKTB8cUEQ3s0YRDliXlpM8mDVWClsEEhy4kOuDEDTrQ/KilrPv2fsPRAuBZZbwbj5tTdakhwMJ6KU3X5pSGz+Hd/9jPAzf2czriqhpg7a9JexXLZRieVVL4V28jJHk4YW7DIRVIRB29O67R2wV7UCAkzZhyZ28hBOMmQwBPDLhdhpnTbzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fcKvxz1x6ZpcgDHNkBluidi8mMjqxNUg4K7P2KVlSiFq+tqdDWbU3uhee2W1v5XTZaDzsUJCi3BNC9sSJYnyBeIqBftXfZDRAq91Z9ktJLI/gaXqo+RuBmMiuoiGgL2AYlrw9ae7eEHqVMuK7DzdqV31jz6MfQpeM4Y/M/knB5KYyzutXHtx6srysrJmzbhWnvhwbtSoVu/FxC4q4kcWAGYlbuLG5k5ZLLI1URz9s+Xx6rKg28CDK0QbzVqHJqOI/e+jhNztzU3urOnao1JwJUtAJrZAzrchb2Avp8hGXCafrar1wRNQ3g3IpuiUCS1ElQMfdVZwxljY1z4lUG/MAoSwmtcwsce8kIgtjoRgTmZ9kwxg+ly+MqZyQF6KKo27hiX/xpjJq92fcqqYNA69XQJAZ5a9e/KJ/NlN88I0qxZdV2lpeLXRF7/6fV6IshM2Z1is7pN5rDbIS8Ng6Gwd3E2G0bzIXD1bVsY6w1VkBDfHTjrhDxxZKIQGDHiJwBjFYRUTL/KStcpuG9r1Ai3drQGv6XnFlDKX13KSsPKPxYBysyQegbFG1Zkd7jTbd4Wyy+MmECQqWjmjW3+80hlBwZveYrcryck0XYD8JJFDLvf8YICm+PF54h8+esgeqh5Reaa0DW9pYEQelr73MfKYBUXCn8enz9SIF2WcCfNCHONPFzICLwUO0rXSXAZe8CclWyjY0ysMCJjlke6kzyTEKF1GgXihFzralc1jh/TLHdIH7tmj9sRRNoqecdi7C0Jkigfkj/T4u8c0pEqy204gxVduNFdRWt+rnVFpZF5e8Rt/eW5gyeAbiKIiNySH2P1VtcDgPmLD1UWYUMfOk+d157JMymDhAvd7fQssSJVrnSlhiVPnkN9dUQTBWb80tIfpmfsSAh0FhpqpNgKXWa8K7lkGiupr5QXqrN8niIUz46PJub3cHeeUEXzrdBtoPC2Q
 CwwcNK817zBgMQVKVHzYmjjn3yVJaIju1zWtrD/QwSXS4BQ31s2A9D954A7XF/qIeCykAEEbe2b4Ica9SkhRxlPbUMS8D8MDD+DKNv+Ekq5drXhb6XHY4inWibuff0BYgQxsKzKiTpVwkofjhWuTitVwop9YMc9rm9rHSU2oDgLh/9bmMioiJmJ8KB3XEmPyxNCRGgje0fYN22/xKfxANnLhhBECosBdFLmmk4cBGR4lVCr7NU6uZK5u37KITScv3e2PjS4D8lYW/tuL4vZzCeadSTlHqKERh3p5Qy1Yek3+WcGTUmT+X9OiNOuD2aiNB98vx8q50NBp4ZdJ4QaHYutKvCSiv3+UgSwKB/1txl5wBcmEeIri48MD6IdbqBYqHlB9t79MtUHxjRmPud3Pj4Kza4z3f6x9Y5CUrxJumI7BKzQHrpiIZXwrrOA+hONE6Afpt5WRpXvYsz0/DQgb790/uibEr7f5ub5My6Jom4+gl0lYVPpbhVx+BbKs/bJaK1uB8TcBa1O3DziKWS6H5l67XCHLR7Cpfoar/TSrKvMLKUQvFDGRhMbCdsy86ytKQK/ShFUUYZGlYUF38eqddBo4//zgU7qHikhX7BTncfBfJE1qb6vI/Vtj0tYndNBEedyssoH7JSIR0e55w6CZtw==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e94272-bb4f-4aef-97d1-08dce153654d
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:25:47.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEbBAASyShSYc1xZEqB9IcAzcuHqcnnbve2XaQGzkhBqcjSssFfB0ZWFHmBW8myDuP+GsQzkMw34bvAZ8olmOg==
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
 arch/alpha/include/asm/io.h | 6 ++----
 arch/alpha/kernel/io.c      | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index b191d87f89c4..db3a9f41447e 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -591,13 +591,11 @@ extern inline u64 readq_relaxed(const volatile void __iomem *addr)
 /*
  * String version of IO memory access ops:
  */
-extern void memcpy_fromio(void *, const volatile void __iomem *, long);
-extern void memcpy_toio(volatile void __iomem *, const void *, long);
 extern void _memset_c_io(volatile void __iomem *, unsigned long, long);
 
-static inline void memset_io(volatile void __iomem *addr, u8 c, long len)
+static inline void memset_io(volatile void __iomem *dst, int c, size_t count)
 {
-	_memset_c_io(addr, 0x0101010101010101UL * c, len);
+	_memset_c_io(dst, 0x0101010101010101UL * c, count);
 }
 
 #define __HAVE_ARCH_MEMSETW_IO
diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
index c28035d6d1e6..69c06f1b158d 100644
--- a/arch/alpha/kernel/io.c
+++ b/arch/alpha/kernel/io.c
@@ -481,7 +481,7 @@ EXPORT_SYMBOL(outsl);
  * Copy data from IO memory space to "real" memory space.
  * This needs to be optimized.
  */
-void memcpy_fromio(void *to, const volatile void __iomem *from, long count)
+void memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
 {
 	/* Optimize co-aligned transfers.  Everything else gets handled
 	   a byte at a time. */
@@ -535,7 +535,7 @@ EXPORT_SYMBOL(memcpy_fromio);
  * Copy data from "real" memory space to IO memory space.
  * This needs to be optimized.
  */
-void memcpy_toio(volatile void __iomem *to, const void *from, long count)
+void memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
 {
 	/* Optimize co-aligned transfers.  Everything else gets handled
 	   a byte at a time. */
-- 
2.34.1






