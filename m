Return-Path: <linux-arch+bounces-7965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0899998632
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 14:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975D32821FD
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785511C6882;
	Thu, 10 Oct 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="XhW9y0Em";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="KnOZS2Oh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFE1C57B0
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563825; cv=fail; b=sFCtQZhGfhc+OdWoGZR4XwdQB/9Q7kLHHTSnNGQIDvOrwr2VIyuPzh6Ygojcs0vn9ZJ1MJ341r7qwptnPQSYsdLHijXTVSbDMGNJd7HONkCuJC1bFRra2EIDpozj4waDOyaJBy83mmBSor+FxILbYIdfe01Fxu+BrOUZhFuQCpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563825; c=relaxed/simple;
	bh=6M6Ssw57cTrYNqTXF8pkA1XmN2bzEuoQgDGkQuiHZSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIjkCHNnouY8cTaS9YTrxHqgipq2SmyS07OVDwwK+W0gUHPMhaB2YrpRnkVS9I2bE16ZaHe/51Mm2cATlPdV4GqZCl/ugxzC46qA5A7+C98yRtgJnNXR59LEufFBBxnryKUhkAgn7QqcTAA64/+1IVS2LjLVbRAfkSRTHo73QNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=XhW9y0Em; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=KnOZS2Oh reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id CAEC549024B
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 14:36:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728563812;
	bh=6M6Ssw57cTrYNqTXF8pkA1XmN2bzEuoQgDGkQuiHZSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XhW9y0EmQbU3gTkJCzvaLsT6LE9cEk2VEgXkMZ1WvIrDXK86m83T+YgU+sXysCf6U
	 Gabpnf31lYq3TK1Xb7x4gIzsum98LW5hICPLYhfCyJux9JgNDm5uwudF7cpOfxEuwU
	 DRobW2uumft+Y60aFclMGURjoCeylCIwKm+NIS5c=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 88B8149082A; Thu, 10 Oct 2024 14:36:52 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011029.outbound.protection.outlook.com
 [40.93.76.29]) by fx302.security-mail.net (Postfix) with ESMTPS id
 E6EEF4902CB; Thu, 10 Oct 2024 14:36:51 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PATP264MB4966.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 12:36:50 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8048.013; Thu, 10 Oct
 2024 12:36:50 +0000
X-Secumail-id: <4b67.6707ca63.e5c98.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RL7/vOA6jfIXhej3+kykWj5AoUBE5isKBz4tE1XZuQielpGRNA4KdyZWe0PysR19F2OwkJw+FwPVe27PSAPJo4XvCfG9ruOWDQkDSg3Y9L9QcIk3u2vX1oMuBbiPPw07qwTevx79ObZxY8m9eojpaWc0q4PyP0owpPm39RdEjh/PZibhNkFHT6QFS6G7sPt3qiBYorYza6mooI34hHiYlq9qrjl1lcY25P38Y3cNu8go2wIrffjq4ZOY2DOp2vcx+z7Dzv6Wbtb9kdAUznhEY8OorTTp9rVkZblFaZX0NxUXTkpMEUS1HLmGkXSxjgny3NaVZIK/rps4P5UtrMpu6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8aTlq7JIBqwkllqsnMQNf2DhLRDwt+iHfycOWuWHpw=;
 b=ByPXwvZzPDlYufzsJX8PRTnNjaXODHr+BQBJ6iqXA0ZEryBbzu9Swe0tYuR++yO7voxttetbNm3cImLQRz1N0J2u1Amg10Bd2vgd9Popa74MFwhpHrvIeA16FpzVCBNMfZZNx4ZjCft6jCv4/Iig+WrzpGJkQR+WZghNZvIxLmmzIJXW1+T71PzRY2hPkiMOAumrvmiQk/qzjkXBNibGz5bYhs9T3DWBDjy3VTsppIwNHldc06PiV+jkupm07OsKPu6zwjEyFCMbjDJckFdcfFr9ODT6iavTv5XhuDDykXaDoYGRn3GJdnv9O2ErwDHj1flk2KImHyt8Nw1Ms/qnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8aTlq7JIBqwkllqsnMQNf2DhLRDwt+iHfycOWuWHpw=;
 b=KnOZS2Oh6TnEf1igco4EQ2Gz7xVUjmS+xgIIsUwDCqwHAv1aXSq3s8bH3ryqI6XvLLjIZXtx421TKSUoy/WR9YAP+6zlHv2kIDF+KHwMsP9FpVLqd/FQK8WPTbEn4WZ6ry6Itav9YJiCWeOULCiMqOcMF2sLiPOllI8uDZT46NNUxlSKSg1DNNXPuRtI35BGytiYwCtVWpwAfIv9zVKqw1kebyS3AFXkHi2MHdTVIB4J0h9fMj9qWwvKAJv3r0PXFAbXEFoXm8D6GAVqefea6l1pJNIayqH/gmNO75wnCXLxdd6wCjZAGWvwsNV54oqwxtgcjyxQiFkUoEiAGUwBuw==
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
Subject: [PATCH v9 4/4] loongarch: Use generic IO memcpy/memset
Date: Thu, 10 Oct 2024 14:36:27 +0200
Message-ID: <20241010123627.695191-5-jvetter@kalrayinc.com>
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
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PATP264MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b90d6c8-d7b7-4c87-9434-08dce92836b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: msefDPJvc9IUBXwTsW4u9kSh/x99lfgz+/12/YreLsxPMvvOTwXyGPIh4nZw2t1ih6wiR8exIbOujeGGqTZ9WE5U3tdmGMZiDn7XJtW8x7bsy/wITIhtoLP3lB49qblwQRTLhTbBlQ8vqTwvOc3MTWTy8nd16/A1vO8BGpAtXuo/k1ohPbtSr8Ealr/YjB0fgFC3rmlNwWOtaXr7zUujsnV0t0CzbXzeD6Z1kpKUc049iVCfFw7uDSMKUWBMa9TfA0B1drN+Li5TAeZEulAY57UcuKTJjembqIU1hUo423t/XY3g30r4BksCV6ZRU4Lb39+p6naI/dTIFlcP+ONLwLjLidaQtsDZ+PFdj/pEExZGcFA3FW8BAW2XmfpHVMn61jiAyhaIGyQ8VBynbE000y3k+r1dLDcnbwlu0apWoyWeQPOYWhNtNzKYgdQUZ0RkWDk/MWKzX4hKwCGFq6bg1tGAcCHLxDByLj+T2WgLKaXD5OGys/0eSxF7khteTKqwJrnGkvImOcgOmQDJIZQyHQAoMzu5C0A6QGcrvoFbEIQ3Blzv6snV1+4DHjCYXGKgXMBQ1Oj+rDHI9HTKQcTLTWX0h1Xix44MFm6CjD5cDPI1QVRjN/7h2m5UjLQvjxH7qMJKKnI5ufxTXHukdFu4sZFHV4NAL8kvgmXUBatF6kJVFZA6pgixYSgwDnyNeOCqp3TrbUclzvVxGBWf6LiXh7SHVacPz+907DN9sPibFYG/KEMWh5S0igeiHyDEnWbKE8quKOi/pFohGFiGLfR3cjGWjbFX5GBIqATZ/oNHPcZ6MrwmCj+hCEr/rSoWeUjiHdG7WrNpd7WXJ8wE6/1AKHh2wl8bqVfSyhe9dLONTHrw6NKNtY7OU0hkRyT/NrUDu+ZQO9PKyInGyTczh4Th1YdQdw7S9kDDkImwCe88ws74rQEUrPBrVXkjIBLrWTMHwWi
 zn2r3My2oSKdLS7ABe3eyHGmWOd0J6WmWhhVQ1l3BWW0510mYLm9jVMKXG+6BNz8ONp4hPWB54qmQcckigC9zThzzAOO3i9fbTxfE5RzEaXmDDGinAOKXwkdVZi3QtLzIzh4RGpCPBi3RIHgjE12fNxUilYba+rfbeAT9nlaydEsoUBzZzx6MQkECqRdkxEATyoLFgziAGmSoeneV7pLsNZ3JhqqIaduxHpGgkDAr0hpj+kPrfhTX9aQl1eBcs57jb7M7eDYKx7zGWABFTNVG/Y2bqbCPhH1eTA/jaMY+6YO3fD9KmUWlxEDPdKU+NT+LFzh4KM/VnRryywKWqDvyHvHDOk57ngel/xO3UYEbq82wGsz2mOPcpiqR2EQNs8K62/KXIvpgy8Wnz/plsgX2muKf0QL4NY6cUn9WeQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: paw9uiWNyiE7R8rbO39fnzHRJ/sG3Haw1W/oOEIo222V+HFy1Rv8dNWkqZvXVllsYmewgLxtyDXdTlL8bwPgZf1f5piUn4iEdzPuTQPdIzuZRN2iLZiWvHaTK/pLwyppqkJ/bYr61ZrjruiADsb8yBj9lYRwBn1IlbtjMXQ7ud5dMzngVAEDSuw7RPSCk3AwcFNBhlA82hqiz/kug7dwf43WbTKnKEwDNRzpv1ioezlC43MRoVTZXGAgKxZ5b6wtq6cfy6+Op0PqoGLucdD+aVkK9TZ1BhFzMdXtzDIsM6VIpGT5gxDRqX/s+2qz1k3RFci6N6n3irOid4ch8oyEU/LYjqvPMBzkIxEQ0GER1j89JvbiMCZ10CCxfpoA2d5P9qTJqb07rWM0IWD5zSJuCF6o29NCZNHaaQQ0WXkpDF3XTRpA9Naj/azCUo3TXIyBC7vEdsF4dwWo6opEUuGy8ZbaqolmJJ5AWTFWJEqIewUPPEB44uf7zhX0Co8cN8Lv4VA5e9C+crJZFwql+8t66/sso07s9TwvfRQ4O9OawHohATveQxqLxBKeQTnrIbbMs/w3YV6NrPKgA0gff9nJ3181lMmsyuplpuBzdAThss+Lr3E4zhjVHb7LZRWznxp3w6/4JZhAiZVynpkqJqv4QtKCDD4jKlsdeq8zCY/4eIR1mMnGMIs6U2BDmvhp3BrbblBF85d81DvMUeCyxNPyI3rPeA4OHGAFEBmqhbtNCWnA/jTUYHQ/xKsUiddfB6sczQAiLVz7EY31VIMtp4pSwNhnFx5EcJ1HkLleKWOqBkuLrhw8q62QzJxDYeGnpvrWgC8CWp9kGd8SnZaKM6VXDMbQ/tkNEHfjj6J+ykcax3xrgNDuOB12rZqUG6GsHcloxhik+WknIBSkoz8KD/LnmTXhiqaOlzEo52bPfFhKM4fZU9ZumXopl6BZdtbtDsKV
 w4m8VrHU1RcZTrgQnruep3hPz/YVmR/nbzK5btKQ7YdsRyJlSeJRiGculBYDLX/+iVSsbGchDe1O7BHLuUBDrtgK9ZbNZJrCmrUjMQNSgTxmodFoyCY0jtYb604TReWTWRvz5+y6BGSu5IS1vH28FXgtJy92wqjqRom3aTRI4Jq89vG1nsppkl3iT/Bk7row7EyaDnMrCtaNCJ/THMhtxagtAuIlpWyojIKByEa4B1vTiKBBdEJxji7TsXwr9OvjPyYQU3FSTy3B8ZEJ1RUbv+6JKDaF2Qo0+M7kiHjbqN0DAvDoK035yj4lnVuT7EUbAED2NStUI9eZfGp2QRbDSUsPZSD5K/BWOllX6UXeDiHYT3ZyNFRJkN6BbdqpBqZ+N1UVKQg50BjMKp2XOXCEVFnBC1Z2Emc2ocNV1Q5VpMEzF8+x1jl+Qp7ZkE+ELnqRNeIq1c2qKH9KiQ6YufJYL+dOYmTaElj5X/5ZSfyBtSCTx/LXzYXQjl0k5sabUGKzce4eNB8NXJTnlIH+tqD6zfZYFdWQmZF7NMBOEdZqScIMpPxUdlHXH17sxJ0Jm/Fdar0pybeCGd1vVcfhHEGZBDU6oPXUczxT0XMzIcbuTXKgim56G60UQ0RzdBk9bN0r
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b90d6c8-d7b7-4c87-9434-08dce92836b0
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:36:50.8311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jfnUV25QxTF7Z8VEjO/9NdeLoSsEtnJHm6Mq7dY8+cNS5e5GDj/aZrbfJQlbn7Tx9khGMyjyVbfPDH0oDP65vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB4966
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic memcpy_{from,to}io and memset_io functions on the
loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v9:
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






