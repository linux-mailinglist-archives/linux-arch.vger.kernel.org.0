Return-Path: <linux-arch+bounces-8645-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F119B31F1
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65752281D6D
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2121DD0C6;
	Mon, 28 Oct 2024 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="lxPtU3tW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="SzqoJRZ8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout147.security-mail.net (smtpout147.security-mail.net [85.31.212.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737C1DB92A
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.147
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122990; cv=fail; b=OMrG0qYKi4nq6gthLTSqw+geQZqhvdH25WnxuaF8WmOZHc0ixHMz9FFcQWJ/YX1bxUREJ6OM3opNhh3sYdh/rMs6I48ycQ5XS+kyYSDAU+4EdCjN5my1Rtu1GY7Gho73eF6NlbwrjpdAUBCiB8ceylDinBM9yDeoX0l0jhivH3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122990; c=relaxed/simple;
	bh=m0azjeo/8KU0vuUAJ6AKNpDqaVPSOPebAlZ1yv5scS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXjO/NwbornM42frTAsNcO1TBtsIkBCxRqPAUFvj0heRsIhOmL50y/BpHJhTVIOxTJTJPRmuZH397ZYJRKnRLy6t2rjDIQ0d8Usznqx1uHxG2c2Xtpzd/3b1m6T7z4Md2aOrxa1v0mW0XfLwJuYla+hBGzG3xCx3kv1yjE/LNCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=lxPtU3tW; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=SzqoJRZ8 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id 2107034967B
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 14:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1730122967;
	bh=m0azjeo/8KU0vuUAJ6AKNpDqaVPSOPebAlZ1yv5scS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lxPtU3tWtumM8/E72mMfnZdR3DDkKck5107kZ1iqPYS60mdSUAkBJ4wfRqu9PSuVp
	 mV50xgk1Y8zrfiOrKmW1V7sAukkuclWduaSd2HUzK1DenvZKivXGu3OH0f5BrVnmx5
	 yBfRYcfAzSVjgDxCVzCFZTrrS5GCvn0oj53imT6w=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id A743A3495CD; Mon, 28 Oct
 2024 14:42:46 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011026.outbound.protection.outlook.com
 [40.93.76.26]) by fx409.security-mail.net (Postfix) with ESMTPS id
 6B170349327; Mon, 28 Oct 2024 14:42:45 +0100 (CET)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PR0P264MB2501.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 13:42:44 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8093.024; Mon, 28 Oct
 2024 13:42:44 +0000
X-Secumail-id: <595b.671f94d5.68d36.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SEi359zrQruasKJkrgY7KSKLFT0Rf4GlcwV9D8nWVFWmFT2Z9hzKz9FzC1glq4N8pqFtS5xyza5USdZ9cfxgvQ2be48yK3tD2aReq4UyjorGXv0ra7/r+yutcdDxRn+u+HXOLGj5bwyWCMDtRKMvn+pBEYEfGCHT2baIbXx2q5XjqBh+J4kAt01l6cNX0SgC7pHyN276oW0j53pIGjA51WyWaGWUUS3ZUjwTGemRjpkcTXlSmWB6Ib65UTLuiQb8edIv2AkdZT0l7LCN9lKdQ8fcuECGuGSn8aiJeXpw5Hvm0BwrgjJBlUX6kTuEp5FqYJu9aH+gP9lbyGlltDoR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBcDu6dHhg+2Fgb+AH3mw+r0VmIQkJLJqZoCso/e4P0=;
 b=OpepThZLYo+ggDJhX1c2M24AdVwNwBGCR1MmIZ1h1WXAIfKjocflwQbEOBvsb9rPeGRKitq35PfKcs58HRHUadI22Ys29bDhEgDiAS8qZbMPdyIIArbrOaTC5ydimftFGDiuMhwK8AOAlrreh+6WSJ0FPW16oiKcSKqQGMY87/O8+qMnziMI1GdDYN7R6r7DGkeqrC7E+L6O+aTXTmLdEJLftPpLs2bX+DZGdTB1NaWprj4MtEuX1WX7k5wKnE1cDYL245yXCUp0rK8MrDUaCEjwXU00Of3HvZ58hYnPLxC19ZiEeh/whScekv6Fi95VlUFZE5JSuV26L51J7rGpIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBcDu6dHhg+2Fgb+AH3mw+r0VmIQkJLJqZoCso/e4P0=;
 b=SzqoJRZ87PDrjDBeEEnKKEYfbvA4rxE7KO13af4/s+hdOLLbQ0CiwrGDDZ3hTb6ENz9yING0W9cdwMNNALHeg5XPB/+GTKwJO+QuSlD0VQ+LAq5QqWfm3759vO51JoDiJrCXC2ZbDUb+pEKE4tjrswNvD/g9+SkAfmsGWvso3FRZRlTRH2dt/V5SkEe+ZKGGEpjvk0jGWGS/7ult/e3XshcdW1n+0P5MR76NzELKT3MgPB5n8v7lo4pcIIO1LSeMvy+PaCpjBQE08s/hwBB8w3AQLB8EYEiGk+fHclmPk8RVMgc63xPSu28Ix0X7pS1q+Ot4iszRFCOMqRwfhNtj7Q==
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
Subject: [PATCH v11 4/4] loongarch: Use new fallback IO memcpy/memset
Date: Mon, 28 Oct 2024 14:42:27 +0100
Message-ID: <20241028134227.4020894-5-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93997dc3-f208-483a-31e7-08dcf75666cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: uHSPCSo+4BIdOAxWji2T21UQYEXfIFkiJol9FtF5Tzn04CsrMFmIJLgF7pLuqZCgpnYD+FDxmpfQXFDQGzSqepvE0hswFAetgMxLa6EzhypVjkmJ2rbShj5Ta6v8z8HWP91sfhgYBCMpG0uHzU7bZLYBqp9GQV+MGTHbVuaSrKKjJLtcjBGFW80u3zjRXBUGai6GygrbalTOhfP/W00rNbrWjJ7etycXxgR52ijqbuemEz6Pnp0schVJJhZ1tCh4Gp3Ab/XfXJHDRFEew7KZlSMN+FXTcn+rH6NMS+m0iy4zHGvd5mMDLYohho/ykrA9UKxDJr85FxhQ8c5krxa8OrbEWSM8CBcE6X/Q3S7xxbvvJGgHQWQpABq3QpO7JItt1ssCSdQud+9saGTiDcNWuniJZ2T4TXCMTh91miTONSIdvaXXmYckbE3Xl6b4L4iOo4k5d8kZqNTlBGysk6kdaq7pk6LCJmSy6ZnlntbV/uaftL3vxlFFYz2YcPjY9X4KnOuflRzeedE0HdVhl7SOnl+XhYR0erqW4YVb2veesvqHi0VdaCXOEJ7UZwaCy0hGHvvgJ+dEoO457I2IwBXEt/KMO7C1L76nWRUp+oYci2uC8BWbS6WJcrbw4RFE9VITFkEQgCe+va4eRlOt/C1xu50HupC/yJBm0tUtOPlCJ/67PDwLTb0snJh6g9gCw5nCBB/NYb4KvjRcULi1nqJpBhj4/q2+x9nsqYw7FHSi9kqPXa+4Z31NA7Pc7/NR301MWiliO8OFKbaeEBP/RPlyHQuyZCuyjLB5R5kck/9yepSp0zJHI++HUuKHaRDtHb6H7ongj7V06lvw9UDafcOFPI27sJDaF1jx2XrXb+DihVypX+2T7O+XV2ytG44g5E6hWSwxE682DgZHUrAEGN+0sz4DDX6gchXq9tHt7OXS6Kij9035MN48CrIgml0EByNR+ue
 d8sYThuGg3ibRIMJRxB1CyY40GL7K5O3tifAfouTSrhaCl6Gy9MFrddsE/fQkGZLD5NqGft3gSXqpN5CvdaQC725zr6jidfGr9qKCUJYRO1IzIEpJ3IvpphB8G//kcPd0rGu9L25/7Nfb+6ZjB8Osb1WoAZspC2eS0cNLVyn3OfiUdLQuIebUR1Pxf1lshgCGfsW6xm3kMvks/ecNIibAGmpXq8tnG0pwyyS32B+GGM74w1SDWmMoj199QLQGUWDmZ9fOwGnOsZTahLz/ADiFg1YIfP+hBU/xO+/Fi7nFamY2CSiJLCLCG+zN4frjxcDfiKiuLk/IFAnqkAoJWG1szbf1Z2UkMdgVX+3Wod76yFXpH+6FEaSzpCBLP6RD2Ynxc+ID5eTKtQ4zfg6aROl0Nhm94x/ssWb2AhVe+L39YlLU5gZHd6eWcZBntiMX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /2nYbW+JbaBdnH3o7yYz3vYU8Qe2Prn8rjQPFxatD7+wE7xHi+DHkYxe7U/07HiNRZMttTGINp1CYd7cvMX+fG1djZrpVg/2fnjkCFQNnt3bp7pheC5y29rK1xNRgP7t8Ah0CKuQ2NPQMPT0hGQkCz1/bcdhOVFf/3o3BVjsH7kxjN0dSig01Kdi+ISMl8BwJRQdPQsh56OL2bv/qOYrbqLAgzCItwF5nN+2SOsf39xPrGDf5ugLqQxwTbC4nKVmRnFE3RNGTqOt+WTl7chWhRfjSmobt8nldclNTZrTr0mh8ED8W21AwFtvv/njzpJ0X+A70XAHqRJ60tXVwmJSNckz4sSnfMWrXrF/AzVaeuSLPyM9sJ0DFxBRKL0I54yoHpPxh9/NUZdZAO5SLEEzTHXoKpEKnNnnT2ESZTYY7CfXXYd0NSUGPR7gE2HZmv3b90HfrO2t8pgj/zzInRkbQmqYYCiFj2ElCNS+3tN8XEH91qteeZ2Zrl0cdXOx4n89iTb76KUL3iYd3LsWZJU3we0/rzoSi370zuOUVtBEg5jr8loelqoVYoCT0X+HE0BC9zYBGJnRsDTtrbhtd1lvsIA4HlUOdgWTcIEm3cP3D2ocqQXRCiSt48S0c/91uSo0mo2i1hoN5Ynt25RwExPPOQ+oBUfacoFPAzrBiX5j3CykLo2YYDavX2g2YuI4r+eaAJ6rdaJbSNFlobPwxTdF6HoTcWxdB/VLwYenBukDyFvyQ2SjNPmwVkiF0l2FfEkPAVRnMozC6j7pGTGg4Yzy0O4h5r5nP8nkXDv7gm9K4Wfw/VUIOyCOLOxWOtM+kZd+5U8jQlKAFll98QpeUjypJ0BpRmFi9zTtW0JMoZ1En5bp6/tzsCgJxODDLR7w5CGh1ckexgsCjftlNz6uxNUe+wh4/QFy5FPvz/OvrO8Pn+tBBqWUomE0I2Dg+CyKYoeE
 7DHK6dEgy7m+vAZroLk84CVJUclhyVPg6wOgsj+Au4V7c/qWVrFCaSE8+HZHloffcChJ5cyp5t+4EoZexx9b8ySk3L1inRAMQbSb8vGIgSMJ2YYkm9FcxU3Bo3Huv12jeP9hBmlbq8Lh4NacKIP8wXdjyjiItiLtpc2B7VDQpKNaTDT6C/mTOkQi2ZyCpuhzLFydbj3m0gJ+SaO2IZNRYWB1dPoxxTk2zhfW7Pid9P27n4ttKqFwTHG8HqivHdlql5+1adGUrNe6OAB2JKDX3VRlRbyj082dH/Of1mAVsNZtyoaTWfcLjBm4FhydstlJCU5E2sPgvt7Bp87DCO5VnrPkohhx74RWcFrNvgJaJOy5xmOWQsnSYKwJfQDoq5eQ60Ay0UGIJRoFeKWS9KUSWtuC7qdyidc3vHZAxd/mceZcV5btSLE6mGma7n/As0JtLQbwGcCekjorGOeIepUR60zAUUYQQi9bDmyID4ggtd9bOwIPkl7B2YCiPCsukrf1S/vBqDBcsVvucTeGAMpBygnySE+aM0vp236HoAgHDxg8FK7v9mTEhAVGFzVndCthn6TJXjijmKcAA1u40+FTNqVsGLaPnXOfsoxq23Uv3e/CIS8i7UEcNhd6Fco/vkCL
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93997dc3-f208-483a-31e7-08dcf75666cb
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 13:42:44.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46g7coWWlZlY9ti1tFWxSfuXGRz/qlnDufUiVLGbk4PZ7Fn02ByRAMbvTIYdoIO7EfHbpUIaf/70M2SUR2mdsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2501
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the new fallback memcpy_{from,to}io and memset_io functions from
lib/iomem_copy.c on the loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v11:
- Updated commit message
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






