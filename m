Return-Path: <linux-arch+bounces-8342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518629A6A62
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A691C2295F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FE1E0DD6;
	Mon, 21 Oct 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="MFRSR8P0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="rmGxICws"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39121E3DF7
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517603; cv=fail; b=NqeEGbd9yvBXzSXSoCaWI4uYRe7tjNpEa8tZw8ZFMNfkncu7T0NKrqpFasZpmTN1rnI5BmtEDzhIE1ysUl+eoLmglundN6lA232Gbme29roAWyXCuK6LSmxMcZtTbV6z4q8eLNfe+PrOFivh19xwmOdxkxUr5UGgZtCDNbJO4n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517603; c=relaxed/simple;
	bh=rWJitnMus/PcMNtJrIku8s/XDC0T/AmzlDyeGJ3xs4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNDQTjobVLjIh/x6pBe4WgAxoQlUyYeVAHoQywCJ9dyxl9rwxMPtsTcsOeGsVmCmAXb23vVNknebyqW+miIxy1tZupVfEqiCDZtsd4wSLiklJyKUzhDRTyBzNhKII7doevsyOCXXwJAgdzMLjn7K3tXROBaFEWn9aRKpek7yGOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=MFRSR8P0; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=rmGxICws reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 10DFD30EFB8
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 15:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1729517590;
	bh=rWJitnMus/PcMNtJrIku8s/XDC0T/AmzlDyeGJ3xs4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MFRSR8P0yKzPopQ8LsA64SbgGQ+Zdbc9sTwQgFNUDXk4BaWkWxISJbIhZzU4bH9mq
	 2Vugiak3MGLxxAv7cTv3jBohQZ4BChmjnJuva5I5Y3yiyLtsDMn/rgC0km//wC3o6N
	 uCZopOzh8/m061soxppXadaaI/knD1E5GKEErhSs=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id AF31330ED42; Mon, 21 Oct
 2024 15:33:09 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012050.outbound.protection.outlook.com
 [40.93.76.50]) by fx305.security-mail.net (Postfix) with ESMTPS id
 0F14B30ED27; Mon, 21 Oct 2024 15:33:09 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2339.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 13:33:08 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8069.027; Mon, 21 Oct
 2024 13:33:08 +0000
X-Secumail-id: <b986.67165815.c3e7.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc9QX+31wE0T1TB3nHXVkzQqarNmD1ULc6H5Lnti47pAb0CgJWfhQqDBJ34LKleEZXGBlxJDCc/3ksq/va1qF2xsSaCNuplGgT72PHS+e7Cp+hCpfdxca969mkKBFbJGjyom7Gxh9Gko4KhkLSKflV56XsWm3+eej4avbAEWWF8qVNJUlcWeA3d4qel2h+yLSeA+FbhFqJtHpPCDq7o2KLu8t8HhV01+uaA+xxIRZbLGGyBVC9VyAb+L7e6pNdnX2+eI6SR9UM88s+MXHduDKqBhroFVoEJ4IfSKmwm93zW/4RxlfmT5qlD2BXrh5XniFopHy2mfPvi98egVDdq5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyh6O614b/8IkSe3xXMOvUBqzvmThFjUZ7QxLC46PX0=;
 b=HDIt7DI3IfOk8EuzLPFnuSPETtyO2O3tsN0uJArjQ4U24nBAjI39aKgf3nF/lOyFwW3wxWyOF0UqaobTPKNPJjQfAmo1ePBxUq8scACFeb1l99xyFLUG2oFdM4xF9nUstqH6zaUfZnSwuv6PCfIxCpC6HjEMD/63wnv1syxAcvBckNV4hizzAcrbcVS2toZgn/UN4Nywg9DL7vHXIy/t+8oKk2DHBU/XFK+s5+H2j5/BZzeJcbm3K/Hb2yBP0g7mGi48TnYx5odmzd/dmI2LY2OHxqe2r+5eh78HIMQMVT8HrgLouPaeHpkIhMocle1GHuc8zssgxT+Lyu9pvn6O0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyh6O614b/8IkSe3xXMOvUBqzvmThFjUZ7QxLC46PX0=;
 b=rmGxICwszCUq4zWSwspsPAuwB6rPhweDe1iLbFZgn9ycdPZjTcAjZRP+1XXPlf9S/po0BsZGeVr7h2qR6qEcJ17tfoXl0nRYIy6o5HKLiY2RXWChdpbT1MgT5v682xplNlt6hqQlOuXdJ1/VxsvMYjb+2uhzZ1gduIbjS0uDS4VlDBlRi3XDOeEPtO8jLyHkMxNS81C9I29CdofP4QI1ZZ4GF2fLg4rHrF3cedC55dqD6nb1Hvbz0C+z99KwDdm2auWuY8mWQQiFGKS9MDCJ0+tSo4gce03IAz5Ge54/maynCPCJfY+9C5m8sMaPtgA7lJWoOofYWlXMWdnVHfwB6w==
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
Subject: [PATCH v10 3/4] csky: Use new fallback IO memcpy/memset
Date: Mon, 21 Oct 2024 15:31:53 +0200
Message-ID: <20241021133154.516847-4-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: e534fd21-48f0-4c24-3243-08dcf1d4e643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: T2ZL6eMCe/CVAf5qmUjAJXLDo3vFwC+eSoYWgZSnkqD91akiGQL5cPLNjie49TJPYKYzK5vDn7SRXxG+6aAgrxYEj51XYgKDgPOYj573Yr0MpJ71xrjkXlg2FGLXksl2ysZTM/VRwa8gC8buWLofKXNBf+0qx5w7WzdGat3GGiuqBgwqF5dHvA6WdIVXrguqPrzWlxEuVarWfgnk/B2pu+Se0d/tvRMSqmfUqbF4KtTiSJ8OKgBi0LtNi1Z4AIKkj/oNzU3aZomOojhDqE+odbphUdmKQSfiZIXry2ley82plwVMEjXwKzIagcJfJOWF/2UlLB6JXDtIRCvu8zhaIm3eT+O3vsO8+RijS3ZB54WeDl/ydqv7TTQU9T3oJ/6WfCPesj2udmkYKvZUhe8+lC/sFzRh1wlq2i2qm/l2iDvag7aRmbSJl/dIUMFmVxUrV4rPmZ1DbEGI9CYB32/cgSCGtwR3nSyDfh5SQNneoJmC9i+AW7hSepPQwxfoqetQj9GOhY6UKwDAzOYftwVGXjKzAytZZ1rKhhkbrkdGfeK82rgq655TV9Ka4yB4lIrEXczYvS4Z+YR61R6sh7WoMYE/44mz8UiEt0U/O+fxOetUkAssU0GTRMVWdQ+ilM3uvL/AW+McirUFSRAGgEIk8Gaip3d7opuTa/q8gcXY2cPhbNFBFYR9v53FZtgkHyExGT2Q5daHhmnTrKlc5oyS7Amzpze+w+/+zzYXhGEGwIuG9AbcHbeB2UFO9beWFqBCIJbrVdsk393fs96klyKynyXIigvyAr2trKc7NxeHZFHnRKwFA+HbbxHgAV6aZVlqvBlazRlocCwx1ea1Wxtu6RkENPm9iDghxOIj3G/7VN2d57h0euNcJSKed2rXhUJo0tyAOyi8KmBCNyod2peNsfFmpHkBxw0GDVC0xFaAMTZAtCB9biGalTEpDsgXBz/0ryz
 p2cRYopPFmrODtxtMzUprhk2k1VbIUatlTJkTgwLLsZ3EwbIIkVaG5UCqLk7YI37lZQkMxNIeV+U2PjPR8PRvjPDqmjiIpyK6wyzJ5AX4si/Q4VzTOwkD6Pgxc52XAVQJGm0+Y1t1vbtKlFdZSyDa5n17ChSt2wUreUGWlhc65Ae1jErWhy+WqO9kZYgcl3xaJPlsBHjT5ZgdJliDvFqERw6JoBAuJaqIhTnK3FDKYlNeCw9uKMq9ylf0FUMrO5x2eylPdoRAh3Q+g5csWlRw1cf3cZsfwvQmF8AibnVgN/j9My33Qf1z8GRpPLz/qf618IPg63QH23blDH3C5a9DFko2D5Izb/9QZ2qASPeqC+ksKJ0Gq8xS8EY++JxJ+k9OA9Chh9omxyai90CLXki5VL8z1rHyjGXYmzdD//XNjZkzyi7USrTwe1RHB1lF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WMGD2dne5ziNP4UGyiS9Z0nwIH1njwtIRPauGN2C8DuJcgO6ajUap6rrEc1hKbVZovwQzBIuQ7EfIJ3We905hL1PTcBJ9C3t0uF/nAdJ352d2bL02fUD4+WOVAyIFh/PU596LmSVTeQq4L9pQxa5E6MSGZ8phH5G0+SbuXfAAwAuz5JJ81FuhpbAYzEVvCI2fgW8SsBpEx+QZFqG1utMHNvgqa2NUV3NVJWaD+Bv8PY3Ie4G5eJnJ2DnyUYFOfNMS/YsR6CCbe0gjgrWfUbcNeDp0fQvkP2FbqxS6pJyxeJcmLPUfnu373R1woMiTOboTQaXpOE8ckyrMGUotntifvNDlSr49zOWa0W9w9jcRI9ly5ikJO6+9lfBsps4cEsWRk2z6yQnA6UlEptoiRAZIqdqm7+9K0p55jirEfPLJ7TxG9pWS5o7DsBdcJ2ZZuWiJzIyfQORVFrqPhjqSXBeo5ctxsqomSdjmdzHei0qk7pqHCChw0S5mwD1ZXgPUbbOT28CPFYvHWlovIQ5PPSXeeABNOn9wiaslLiaiJ5Wvz7XLEEgr7VfhPMZSYjvBIk8jSxbyHUk7gnmeCcU4sUPsmllmZF5s95Y3Jlp030AmkU9D9YPJ+VTCwKr2Tma5fLq1Ssep5eA3rAnwIVuItcfKm98yNZSMLZodgUQg3KASy3Ut2pGqmDpL+YUvUsOxzJaKILePdasgA3SPe+aQhpHLW6EXWtlRjhbDjzDKZxmQlI9os2Yy6reeiC9GAzySlwTF1tREHfjezMm+s4EbX2ArvRsvNE4rrSA9nqtuC4LR3O5XixYP/FAf2tTQSagsjeeVPjr/hCgavc1Nra+JTCWbVx+P0bbxt61mKkLJg4RfZ1qFcHxnhPPxyMQ1ay2qT0XUn6MiluLkIuZGSs5pTgsq68qXrKRXSP0pDTdBwFtTtuSiHOGmCPge9n6q5/03N5l
 np4wudHEfllb4KmRlqPHzEL5zFjy+D9gv9TZfVkv1V3pPz2wrHulAjG+63tqsPwuaGA67FWo818OP4yUMHww/BIVyxoRREeOA0IEqwF84hr13OzqHidVWuuktjS7/hp6U+i7qvqsZE1LSrnMzy+D7WWfBi2kyCKuT2LjQwJMYDLyYZCTRMKEUMjQivqINpbkEkm4JuCJ5c/bwrpfE6T2FJqJWLJ5F54pl3jZf229JP4wYl72LOQgbZ9bPHNxrK1vNRq5yFv+9i+5frtwhH3SZARk46/d/FSAM40O+h9mYj8c6heBK04Z8XV4++UEHxz7yeTUhc0SAFqeSlX6co0man3bshKo/Zvigzioz3kkdqOGNw3Z5PaGJNNCHJqLbCIqq/XryK2wBJWCWZfBC9qm/HJZ/5a1yN1vH1/gHUsgEQ8ZDQJO/LbLUdl6w+n+01HkSwRXvoipwzHt8eHBntSeX9fG7J0cft+gqcKcMrSJqdAQJzvOJLpvH1ycuRLIlCAM5CeQPeywe7vEOmqaPb7SDW4YeBq89NVccdWFmd+r0Ghd5cII29gySRUiBwnrD8VM+s0mi2Vz0Ta3lHxfM20IduS7Ecu0lHE903I88X52zxjt+yKKgB4uYnEJ5PHUbeVh
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e534fd21-48f0-4c24-3243-08dcf1d4e643
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:33:07.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QH1PP+A6oSJI72aC/BhZiypWVMTDk2EYnt0Kpzh8W3e2hcmpngqMnfvwon7znGzACj9mOWPILQJoHHUbfyJ8AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2339
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the new fallback memcpy_{from,to}io and memset_io functions from
asm-generic/io.h on the csky processor architecture.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v10:
- Slightly updated commit message to clarify that on csky we now use
  the fallback from asm-generic/io.h
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






