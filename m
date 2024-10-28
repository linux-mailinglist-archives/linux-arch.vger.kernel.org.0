Return-Path: <linux-arch+bounces-8644-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056C9B31EC
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331D51C21AAD
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515F81DBB13;
	Mon, 28 Oct 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="g0VIDn4a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="G+vMkf/T"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181EA194080
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122974; cv=fail; b=FaxGDv3m0r6wAn+rZo40Tl2HLBT10OVDiMgjnIOeYktXyOAf8Ptt7psKDTi/rQQNZ6x5ik0xe/JdMuDnxcOSI8MnW6+12rtnb98KYpBpS8wDlR1mzn6HzWCg3MzSUjx1CnCI7gfcuNsEDiIoZQ5kzfTVluEB3kL7WKrnZlrwhkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122974; c=relaxed/simple;
	bh=CcLke0tT2HtBF7YkQtdJCT+zh7eYODGYrKXhBNdHxxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dwlz0nBWyVl55rUsZUVILvj1Ej9E5FbWfFdvbYnV8OMC7u/8qpRPCy5kUcQbccmJ68ejOZ01FegaV4uYYLs16JuYbOvQ0/BkAS5GljhbHViqR4O4IsPMwiALZddMKlvDotbnoDDKq5Td3ThQOlULFHuYMjE2zdYUouqQgHSVBQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=g0VIDn4a; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=G+vMkf/T reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 3986C30F03D
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 14:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1730122964;
	bh=CcLke0tT2HtBF7YkQtdJCT+zh7eYODGYrKXhBNdHxxI=;
	h=From:To:Cc:Subject:Date;
	b=g0VIDn4aT+ZZ0fWe3GBZOxvtbiUO569KY+EH/iTKNdNIvaKiQTJaEGVnNGrWLIKg3
	 sk9dZF8GlDb0gDBgr6jSK1PEHtAX1bbGygtMXXyNxQYBbmjJ+hHrCg0WMZw3hr90Dd
	 LYu3UyzTvcgK3IYZCtTnIYBtE9ubAN+Ma8VMyz4M=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id EB87B30EFAF; Mon, 28 Oct
 2024 14:42:43 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012055.outbound.protection.outlook.com
 [40.93.76.55]) by fx305.security-mail.net (Postfix) with ESMTPS id
 0EB8A30F05C; Mon, 28 Oct 2024 14:42:43 +0100 (CET)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2397.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Mon, 28 Oct
 2024 13:42:41 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8093.024; Mon, 28 Oct
 2024 13:42:40 +0000
X-Secumail-id: <125b6.671f94d3.d318.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbtDq8h6NaOB5mvwSQKEeOjgDd3lCKFtz93XobnVECUhJzzO/GQK0uyDVONqsBpYvICYuhnZeCSvekX/N2pTbxmcbKERgHMM+uiR8eRZ+JIIQAwVR2fWxEQ9+AhzwCsUjL1mu6pzGupnP9AN7UYNAZXPMDxNyaiHIHHsnyRjvCvIa3/Cw2rcKvO4jRUcgiAV8z7MKAnOeo9PF55yJdbpVK5yDGgyQIa9SxxT9kOd8ap4tmns9RonPTq3VgeXRM3MAgUXG9v85wFRugexMykL6YtVToHTRg/wX9HCo8+7owFC8bGeGb0CAt+30QXuIuPaOJhBePt61/L+kLkKg0nbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fw3p9LUCUHelUQwBQU3KBm9n+Jh3/wxgYmp7yA4meIk=;
 b=EIg1zXyLpgMNZBk+gH0mCRXSrR7P/vANOfPRxTsfBroX4eaCvnHb63rb5ElTRrd6RbAqENR/M3kB4ije3FwqO42CuDheLMK4kkU4utg0fq2p6Z2f4/+sVTiyg9GFuEZBrlYxIK7hK5bmBepuCJUUq3m1yy2DY5YeOBOWOShKctWaJ7qgn94mNdOytX+AXoo2i493bWXaqBD/ghIPqx/3g8f2VQOL3x+GIm9ocG3pr2x0wSsA8fu4CRt8T1RWDo2JJapFLEMQsG2eLQx4o6RSQpD2VFZzJBCDK3BqYCFtcfSslASi0ahRS/GX9oiNYuudT5tUGKop0QuULXvj62mosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw3p9LUCUHelUQwBQU3KBm9n+Jh3/wxgYmp7yA4meIk=;
 b=G+vMkf/TPzqQHH8dOLFrqt2bRlQRnWM008Ey9Pdwt/9MFBrd8hxtJg5ZFAAuZ9YiN4FFOCFvZ+xfGb3X3Dr+1qoTCl3StGj5lOCaJkCRLRHvziPaguttlV9h6fPcLdtM2yNIxRjrctVlZ826slY8DjHMm8XHcRH25LFC2nXezddgU/Qf4o63VFhJNwV+1PgNj9unDh5/HnxZsdf6wCdGXgjGMN7nqo150tNTHDgExs6jUu9m4AWctk6hfZaEf7Qzu4CpKh95zoJtRuqbnNFGvr5jHh7RSttD+GVagAuJwd6vwUWyCK+LItnZqRxT+VX0hqk/1G25O2U18qel2z4U+A==
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
Subject: [PATCH v11 0/4] Replace fallback for IO memcpy and IO memset
Date: Mon, 28 Oct 2024 14:42:23 +0100
Message-ID: <20241028134227.4020894-1-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 7439274a-e466-44f9-b867-08dcf7566486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 0AqTOaw4s6pAgL+enS+V5ymJ3f5J7zskAHhshrEa1eJFA7Hvh7hOapnM/pUjjqQb4k5tNRYvAxFH+luhniDHgh8WHz4kymhZCLZ5K/I771cRuOu7mgoOEeKsvBbhQO2fhpxizH+xaXA+52svr/gy5LXaSkdMWfRIMVIYllDgkFPVEOo9hVfNfCSS38FyUaPLeXBLrbxu1OkOqXWXv8o2am2ZF6c4WyheE8NJFdMRJ6KJZLecLwc4jLW9gm7r+r77BR2SlPSKhfxndk0hjJRttEJG3WwDhrKLi3PYfcdLtPWI+SoUL10cr6IbnUqKRkATG0PV4Wuy7qwktffvRFzGNGLj/hj+sn+jlHsXOIAgwZR4M+tYx+udd6dvKQM3PpybXxuYB1ymbEnMv5GHiTU8Fd6+NxAL/lo3+caBBfcQgdSnoMVnkPXtiZ0sEn8z6I80ro7n1fcptVuyOGVYqIk9TRRYQOEn8L99sM2OeyFIk4/WV+nXIxxwYftE5N34MkJCCAkAfpBJS3qD3KR7i1npQRcBAnEc5D/Wa2RL7HPA7C5kQaLmKHZUspQdocobKEoiN0P0Ut5V8XLO6ivOQspcWtD2i8rUBBboIaX+YbQ9JBR49NAtDw4ZT5+erxKVthOoz9WO7t2qs5RpbyRBCgPHPRTsnSQFcAOs4xrhsh29+B7gzDiYQUQZXbaWxuEbVKnQpjdhFjNka/3ebPKtAStSEQx7IE5oLjVyVK6fTeLoOgzCbur8hE7GfRjAzbM8q+1abp3KnQhZ+KwLhscfbUk00ceY3qGDf+aTe+ukbIxwd9AaPu7I+xmaILAeLmJ2lXksdgk8DW7aQrODCZhD181p6lmCnJxjrEnpEFDBPRexj0lggKkL5UrC2EsAyB9OzcghtWAd2hMSz7Pj8gmPBZRh33JfJPMCegc79AzjZWTbkOuePTnRbvcnmnPGjVd4GwKk+EE
 BaUqUXBtEdEpHmFErs/FnmY/vEkbesTSM6L9I91pdd9Jiq6lBGO89ZFjF2SzYUMbQpOB+sfcx6hoh6df5ZjHU76QLFut1JM5qJXzX99lnOSU8DF9BoROtmgiENuI0eLjIHejisAVutm1ixz1Uz+dWlFjLaOjuOlXkWIipLd1CjY9zH/fQACgmjgERc3Aiu27E5dsXq9DY/ehAsIiB5v2iBb7Uj508LdF9sAHboi1G9Pp5v4qGGvU7fnhKhGfJYpsgBD8/KxNqt0HD9f8oetTFpZfaP/KK84graXlpKtRGNUeNLXXZf3gz0CPGqClGt6tg600216yKsUUeVSVc7V2+8xBX1chgaGp8Odbtp/5UrxHut/TGy4xGPlDg5BcrprZw/g5ZMnbilQQ+zbueEglmDQNVB+vIi744uu6fD2Vq0RoYVnI4OHjd0JlNWTv9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NW8Qpz7wb5Nlm30YZCYAudjsGwf4aDj95bvySORVyLW11NjpP1cTSAPTWnTqRRyVJY49HJUJJycq/LAncLuvAqeLWLOPjX9fG+OXS7LJs3lyIG/+VCCjotmdrcIk9mLjf/TSXB2vLEW1kJNVHQ1h/4zfGixMuFSW8SXptoV/3tSv88OLs8qkDhnNzY3HhTYyU5XUC5T6KDaOxcrlVqWW9FC2cHtRHILV6tzTzSjwwkNmx8KTFn482Aj9NTiM8U6W1mi6EmE0XoRDgpuL4/I+c1NkLWzcEj2wn9kq1Sa9HkSjn20CFQyzB9Y9brjjlPAcoN3L18v8wadwOew7FD6rHdyS1dPdutxO4kxk3Be42y8qAZLnDlQlcEncY5EDVFjO+DX0F6BjxL9swlN/9p3fPXNqZDYvRw2dFOdDzkBXef1QG9EOxPbCdxCYzTepMOE05mxAPhI/noM73ExnB4j1hYCHV683gEtXs+nabfG2nTFgGZ2nH0U2XnloFV12jc2hJFTdTJEb5gr1UuNS5v6Xpb6CcqOVwQG56Rl7PDuhwBLk/Q6e01RiyuYP06Fw+KxuHTQaupI46ySnsACWh0zx0ZwwmHXazBKPOBbY6sEtove58vCmsnbYsB3A0fg1FkGO8rXA5rPzBD3fUM4s8sNTaw/GrtafapEzDGfBbb3BSOwLHBXMcRKrR98Jf0lhbYU5oVVTYV7FwxaYNECqQPPeh5LrTwElCeCdFbtnwW2UaFVHplMTBiHMyjaCiSqzOUe0IwBifDXlSaMoCEJI1oJnebRo7JJJDKsoelwgGGMYBAEy0lrtc/QJG2FINKQ+563sNMHnhWc5iJ0xyI6IhGFwnn4B4xqXntgbk3J5Gt4lFdiO4cR7xo0VSm3+A2aBIK1psK8Ffqsmc3oSoSoTz6nO/H/V16G6A7ZJ7gSoJur5qSQcUmf7Qt6N1nTZMk3WZfGs
 Uk8htIYg6TH3VhdHo2lAg1Z6gysI4S9g88KnAp3Bu5AG9K7uS5vaqX3+tpDmwtQTEFiXzw58iImX+jLS6jfozUWZPUl23EbxOkCmMReyaP3UAbIFpcwP4om2Ap/AKn9Bq6+eLgkkSYDOd2v4pOq4+n2ARY0D6ymijOgISOblGhMqbtjdP64dl10Dhyvfx/3btnObbiMaFsQY3C6r2FgybYKNl0ydGemr6GUOVQ7+VbFv815TS2NEz5jgg6IS2a8DXozi+XpWpCM3syP/pBZkWIIwv7gwL1K4OHR/rMrdy0CfnveQbpY8ziBM8G+wQU8emdQ/iZxY6f0RbengZKU1ZXFwiqZL4Eodk5e3TxrBp7J2ekh3b+onC7fpxkR0gGqsNtmbYqBvjcYyTqe+Ezh65QvsfoUu2mgUZ9rMeuQx9cb0S0MrNvBVV2qZT/5/nL+W+x2ER0VBFj53hlZZ9gJfw7+CiBb2cLytdEjT0DltixEliq4V0WbkJXnK/Q/aCm8yb37FR1PfnipIUoZDTUS6sW7OkaRKVGD5xrN66SN9hPEcSXIM9WvKKN2sutJqH7yUIvQGhM2VcPa2o+JWcLXdecNm+NIbIa1DNvsdFgLBt6jkSvJb/MddvpzTkZ6+komd
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7439274a-e466-44f9-b867-08dcf7566486
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:42:40.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpfUDCGcufyjd7SsW6MvcX+izGlRfeUxgG6mU5PU0EYfybA69iF2Dbh7WjXeqEm8RgDiju45jivz9smMx7sRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2397
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Thank you Arnd for your feedback and no problem. I should have asked
before, to clarify what you meant. I have now addressed what you
proposed. I have kept the iomem_copy.c and only made the minimal changes
to asm-generic/io.h and kept them in place just modifiying the content.
Not sure though about the commit message of patch 1. Let me know if I
should rephrase it.

Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v11:
- Restored iomem_copy.c
- Updated asm-generic/io.h to just contain the changes suggested by Arnd

Changes for v10:
- Removed libs/iomem_copy.c again
- Replaced the three functions in asm-generic/io.h directly
- Updated description for the first patch to clarify the matter
- Slightly updated description in patches 2 to 4

Changes for v9:
- Moved functions into a new file iomem_copy.c which is built
  unconditionally
- Guard prototypes with '#ifndef memcpy_fromio', etc.
- Dropped patches 5 to 14 for now. I will send some of the changes in
  separate patches or patchsets to the appropriate mailinglists
- Added proper reviewed-by and acked-by to arm64 and csky patches

Changes for v8:
- Dropped the arch/um patch that adds dummy implementations for IO
  memcpy functions
- Added 3 new patches that fix the dependency problem for UM (added
  dependencies on HAS_IOMEM || INDIRECT_IOMEM)
- Added new patch for s390 to internally call the zpci_memcpy functions
  and not the generic ones from libs/iomap_copy.c
- Addressed reviewer comments and replaced 2 or 3 shifts by
  'qc *= ~0UL / 0xff;'
- Addressed reviewer comments on pasrisc (masking the int value)
- Addressed reviewer comments on alpha (masking the int value)

Changes for v7:
- Added dummy implementations for memcpy_{to,from}io and memset_io on um
  architecture so drivers that use these functions build for um
- Replaced all accesses and checks by long type
- Added function prototypes as extern to asm-generic/io.h
- Removed '__' from the 3 new function names
- Some archs implement their own version of these IO functions with
  slightly different prototypes. So, I added 3 new patches to align
  prototypes with new ones in iomap_copy.c + io.h

Changes for v6:
- Added include of linux/align.h to fix build on arm arch
- Replaced compile-time check by ifdef for the CONFIG_64BIT otherwise we
  get a warning for the 'qc << 32' for archs with 32bit int types
- Suffixed arch commits by arch name

Changes for v5:
- Added functions to iomap_copy.c as proposed by Arndt
- Removed again the new io_copy.c and related objects
- Removed GENERIC_IO_COPY symbol and instead rely on the existing
  HAS_IOMEM symbol
- Added prototypes of __memcpy_{to,from}io and __memset_io functions to
  asm-generic/io.h

Changes for v4:
- Replaced memcpy/memset in asm-generic/io.h by the new
  __memcpy_{to,from}io and __memset_io, so individual architectures can
  use it instead of using their own implementation.

Changes for v3:
- Replaced again 'if(IS_ENABLED(CONFIG_64BIT))' by '#ifdef CONFIG_64BIT'
  because on 32bit architectures (e.g., csky), __raw_{read,write}q are
  not defined. So, it leads to compilation errors

Changes for v2:
- Renamed io.c -> io_copy.c
- Updated flag to 'GENERIC_IO_COPY'
- Replaced pointer dereferences by 'put_unaligned()'/'get_unaligned()'
- Replaced '#ifdef CONFIG_64BIT' by 'if(IS_ENABLED(CONFIG_64BIT))'
- Removed '__raw_{read,write}_native' and replaced by
  'if(IS_ENABLED(CONFIG_64BIT))' -> '__raw_write{l,q}'
---
Julian Vetter (4):
  New implementation for IO memcpy and IO memset
  arm64: Use new fallback IO memcpy/memset
  csky: Use new fallback IO memcpy/memset
  loongarch: Use new fallback IO memcpy/memset

 arch/arm64/include/asm/io.h     |  11 ---
 arch/arm64/kernel/io.c          |  87 --------------------
 arch/csky/include/asm/io.h      |  11 ---
 arch/csky/kernel/Makefile       |   2 +-
 arch/csky/kernel/io.c           |  91 ---------------------
 arch/loongarch/include/asm/io.h |  10 ---
 arch/loongarch/kernel/Makefile  |   2 +-
 arch/loongarch/kernel/io.c      |  94 ----------------------
 include/asm-generic/io.h        |  22 +-----
 lib/Makefile                    |   2 +-
 lib/iomem_copy.c                | 136 ++++++++++++++++++++++++++++++++
 11 files changed, 142 insertions(+), 326 deletions(-)
 delete mode 100644 arch/csky/kernel/io.c
 delete mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 lib/iomem_copy.c

-- 
2.34.1






