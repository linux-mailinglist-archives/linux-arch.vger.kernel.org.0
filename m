Return-Path: <linux-arch+bounces-8648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCDB9B320E
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADADA281D3B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 13:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BECA5A;
	Mon, 28 Oct 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bAI/YYvc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="uhPUd2qv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665F1DD9A8
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123105; cv=fail; b=FY7AuTbmvcPURei5F/mX/iklqp7oEQAvbbMtg/H6wiBCIykyhyhtp4vA2HwmtFujz8Fn5NbzKAxO9feOLkcjUepomkti2IJROEitDhQ7yodjSDiO1ph+0HVD3hUbuFL2tZ8MmDnXD1ooHkaNp6fQ/8YmiVjQmSXhZoIL6V20PF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123105; c=relaxed/simple;
	bh=DAlY/W0SR0JbreV39vvdd5E2RX1bIbQuhYHV/vgmvMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4WBCAtQWDFNllfJMRZDtt9OwZH0uh0bYklnFqyITB7J+bz2jCY0CdT1UpzqgtcgQX0mE2VceDqZt2x5XCh8tvbX5No9zFgdh1ynOIODJoUhCaeYsTuNbo09+mO8bQ3iWwxm/Q2tbBtUqR7+RXGyv8JxfEhIkqgvZ+NTI1fbTgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bAI/YYvc; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=uhPUd2qv reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 6CA9A34943F
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 14:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1730122966;
	bh=DAlY/W0SR0JbreV39vvdd5E2RX1bIbQuhYHV/vgmvMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bAI/YYvcE31CVejtfU0eNKx6QhkPy86U60w82hRVLjTKSF4f69fm1mfQep59sw2eQ
	 EKil4niRA86XTp38iPPAYptZEmnpcfIaVxDI3XtHOVGRJtggyBHWsQiPgVnhFcdKTu
	 1huYvyXX71eXbQmRL1QXaldyfUHchAZ5bVbc4jDM=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id E3B1E349356; Mon, 28 Oct
 2024 14:42:45 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011027.outbound.protection.outlook.com
 [40.93.76.27]) by fx409.security-mail.net (Postfix) with ESMTPS id
 EF7B0349341; Mon, 28 Oct 2024 14:42:44 +0100 (CET)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB2501.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 13:42:43 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8093.024; Mon, 28 Oct
 2024 13:42:43 +0000
X-Secumail-id: <29f9.671f94d4.ed67d.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Auvk38GiqFwzJ3XA0Bc8dzmUms5HKvEjOHo+CLLfP6TxsHZHqHDU6yN76Y2cdBmq9YbfpyGSzMLude1Pmc51EmD+WG2yT/gI4B9EvszQiXuIdtMScVv4ao4XP21QInMG7DTdgQWL0anaVEf0BO+UHS+1bonegmjmjBKsp7uuKlkxBvKTsll+8w7I1ZAdxH1K9kekO8F2AlpQBuMlQQgjCjUMEpMOzgxB+bWJNMeaGFj0Fv6s7ctm6WSveRqk38K88Q2CiQ9hKvy6JjozFcXmaNQNpsn4j/kwXDBXlthhwyZhs1PqWcleoPK7br2/ybbpSsGew1ayejjiNfN7p55eDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll/XrPYEIa+g1LCKrdbkGFprUGZCjgJBJ63zA1e1LYs=;
 b=HROAMhvMa+9qzYN2wsLLhokaM76iQNYGGMnIOz1lStrUk2QecxtP1rqXfBRLX0u3zLJ+YEGl08wynyj7F2AbQBkkhLKEASD1FcH6FZn1VKSbMLkIFXebZqOZKkwccLNWW6uG/r7OajPQcCAWUq4oA8Zj2qC0vUVSXdpl2T/Z+zK3+8j3086V17+c37S7seKTLS+QRWrmzZa5Iyk4hxL6DO+756X8ZLUJuhD+QreP8jizsXIZWxom4JSQgzkd+P9FQ7YeQJE03LYyp94jsNrUUo4r8vLAMVfHFKAt2SQK25E17FnvjtkF/Mpp6y6D0c9ypCukEfMFXwtSjGMwrQqDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll/XrPYEIa+g1LCKrdbkGFprUGZCjgJBJ63zA1e1LYs=;
 b=uhPUd2qveiCHvgXGyLFPxh5zvJbIiKUFDSsqlulRRmxSjWiWWt5v3wyx1c80fExRGXytZXBm3skswzwspwV32X4NyR3ySqV4h55AqmkCwwxf8F0J9Z2gBliW1ySTTGAXBbTnUqo1/x1TCy6+PRed/Ccxh7e1GHEvimelZ4mSK8HMkJpvI0PIC6f5+ApGqlVtMzpcZiHPwYP83EcbIzxERTFAJZ98vFK5ukwrflsh4JCo0+XCEnT7giZGhICbUYEs7g7zWddRPpbqotWCsOqChwLhE4xZxCUI6g1nz5y9+DtoEPkqjI6snoeCSyCK07w1qT9JjIOVC6Cc0H8XpdrziA==
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
Subject: [PATCH v11 3/4] csky: Use new fallback IO memcpy/memset
Date: Mon, 28 Oct 2024 14:42:26 +0100
Message-ID: <20241028134227.4020894-4-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028134227.4020894-1-jvetter@kalrayinc.com>
References: <20241028134227.4020894-1-jvetter@kalrayinc.com>
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
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PR0P264MB2501:EE_
X-MS-Office365-Filtering-Correlation-Id: 7136e8da-423e-4efb-e87b-08dcf7566641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: YqAYi/xfriCNof6Pgk1Qp34QB3GUnuMyWZzt6vGFp2BEc8ppPVfyPSaTZhgeViKxxG0NnrKhL7V7F+ItLPrKpc++sStj0keV2QqGzsJI8+AQvBL3Xkcm1XGE/pfudtBUtnArFeQfCaxXYCBSk9toOHEhmULK7dm8XVRBmkKLzkILcWp9pk2jltoZ0FEfN49hWMKo3AM20t1QsBQGYWoxl17gJloKbazmJzYEnHDF84hyVfewN1k2n2UlzXvbXiofDWtKe37tA5OxUJFQgQLMny3EnloFgxdrEDJ5AzOJc3blL08/PgWGfp4tq3nGc2uU0NJNdLiKNf/4CEt44YRo1v+Lacd4SFUqkNYhh8FabDCHhhd4Kuj6W/uiyZjbvxarpCFKTalo37LD8zYpRtRnwbQGVidldm/ykqxaetxb0S6o74PhE0e9fWuFAeJJ7hQ8U0HECJ9vf05v8FG7qHThG8u0/rJqpJK/RuoRuoCLAZIGkj00EMmkAA3hvBPEQkkH6/IB2Cja2rnFxBvljJAWlTt2KjvSeUcwxyw3lX5ypjzS99X2MWrC7IwBSARBqBuvY1yE9XN6SulMQ2/QICQ4TyM2wxLKJLnsvA6b3pqUjnI7Birb4t90bhgX+D9MvTNE3dFMGpvChr9bC11lxmMrIhPng3izdDA3NTXPh71nsfVwU9I6fRhdm0dSvfBv3gzfbfoy1k/cnvQeaCYK/Ck0LeIih6YR8H03cH2wT6aIWw05IS0JxPjGL9EkSaBAwq+DZr4H8q3qg7ZhGqK43VhmTIfWKXQEdjva8pDmqTDO8gXUaJywRnqfElIVql4c+fRUBr0XVq8FAkR/gyUm/A3zkk/ZifqiuVxdfJ8RiLXgLeDnFoUqSq80auSftNOqWQJiO7UZK737UodZEHSbCW4qAN7/9E2DNvlESNNMaGBgoC56FK4xd89rDvDzPyeXBlvNN4/
 GqoTeJRjGmR0NmJ4olDH4MxhIUqe3cn2ro3xdqKSKxJfC56bhQZ+9N+gSl6tiGer9OwxnPn3/rANZvI7XqgIAeMIQfdE94HV3UgGCNElt53tN/odRfghYU/Vm/NQ+oo29lPgXKi+HNVJB8hrMYlr5wpYLGfU1PFT9zNokycdnoj1fIgx0E040cc0RJJkZT45sACTi6GaUxdEYpguqTjIYxXy8ujdIovGzwN9RirsIw3Iey2vulYQBX/cUiygIlqMazlKjkLTCKl5Mie8SUULGrp342AQcdgA6CsZch08mW/iqZ8+5IiBdVHpXvFlIolHeUJzP3ZXbGjd/mUN6VTzMqDIftP0keAr/wWSiPtXkvaAEOjaeEWTHLiK5mdS4envrCir7zQfkEfdaRk/XTHhPoAGca/DqAQ8/0NbxIZ1SxnoS/jvjE6porg2jkx6m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UHbtMaexDFLDOwrsWB9lKVUvPaZQRscHnmHPCOWaFtqkCX3c8LV+4WjSWKw5HxMLnOw0GOGQimm8gwj0Gl/1vXYEFP5ZSKNiOgY8QUiuNpQ4/YYUUXw3WI1t8LtK0w8KT59FiczfyqkeBJ1o36Butb2MxXaRv4tsY2DiLWjeS9r86NRHCpXmJHJ+B41OeIn+VUJfWXGv3HRbvS0lDX9/Ofh6ZlvBGgtgKjeI8ZZJl70MUeaTvKYnDGhbd/MdxMzSzYpTrj4yKhK4j15W4TyPRTuWnT8LFDAku+wxN5u7C/KS18BBsAutsbv6ZB8Robbnu+xmqDVxubRrC2u6iRhDx3TlCtpwePzxaSKh6Kyj5Io8hiwCYncoNSpuSTiZtR+SuDxX4BkmRVTCsumkYecqYVSKzW1bj/5BUO9/UDLNZY/ENqy7hm9g5+oAEy6boIiLyFgA5r9WApzSnt+N/ruxfsrEcMqWCJhUoOCyoC4tRgdb2gvl0sJLQjKV3YejRu1JcY3XL3LmUmJOSpMSVHomxOwShSzkgwh7sBecgoxmajXHO8eEMPG35h9/4hUAXSc29iWgFkpplG15jz2zKSkT9UozLavX1eMuGSA+TGPV0znbnfH8pq9SKXMVt5vTlSqlKpE50tRDoFFHZLsZxz9V2OTxeb6L+tbNhkqVSUjoujTm3YD71VGYLOWZNU3VLKVlqRP4wVDaPdayAR5XJI7qYd3i+N4o9q6qETXK45IMcZTgbJkuWRmVQigCj+CouVVXEmLrEXCBpdeduAJs8NupsycJtvJdbvB5POZ731h2KE4m21n+F711EILvt6aeUFGEmcGyHCuifpX/kKS2HliUg5RHNGdxVn7FDl8AzjUq9dl61yOr9yZ9+EwWNXkZ9Ffz9A1Dmmt/fWLGmTMd5iWLlS/Oqb7A0BKM/4EAqGA4cbj0lB3IJdNr7zVGS32V29Eb
 hbnPa+v3VTefvUG5b2EuHnfX8pe6+RodbYoNbGvG/B/YG5dKJPnq7koKGBy5peikOAyOL+KjFFB85VXZhJFrDl4QuC5TLK8uVa8dShwu7VoFekpt2Www+rps0bFmMD0YFsCl0filSaokyv+kAxtKUwfhtRJkw3qGX0qs6xKxstbX7ADx4TkKTWs+W59Mxu79ZN8fu6U9yHAJgQLo/X1/pY4Hdb4ETDEinsDKlqi7DDHK4a6QqeHKVreAzCM6O0OCONRVBjSq8ceB4hmFXXJs7ahOZTHPlpzTq1ZS0vA57T31BJDAWnYONmQXEoCpzDn6cUWJ/yC0F9jzkYDGzp6M2jtk6efKm1KnrlM5jUe5hP0hLB+l82IJ+6hDe0CTo8AwjKXe/lQUauAqya/qrdlJrSOSGuT/VQ50Y96AYlEyugi4gUoL9SAZxYm9mv++1wr3uFKVZeUOR2cgyGkppTUTTnL2e6Hxd3f3PTSjlmllgwRDy8640lOlwi/A6H5ezWdl1eMzhJVqzDN8kGvWt1ZG/rRiq+BIXav16879iMt88eIQcEtx5sl63mWcV+8KiK45SkTA0MHy6vCWyZ0IPTz8baxGVClqbfDsKi+uryVRMGLXFErxqYVLp8hDFu05N4Ez
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7136e8da-423e-4efb-e87b-08dcf7566641
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:42:43.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cXJBWS1ZqH9LuCPNVmjoPzAYfLlepisYmz4SzbaFPmYOBN8F9Sg9/LuPmN50W5p1RWvpMcerHhGPo7BGSQllnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2501
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the new fallback memcpy_{from,to}io and memset_io functions from
lib/iomem_copy.c on the csky processor architecture.

Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v11:
- Updated commit message
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






