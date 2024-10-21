Return-Path: <linux-arch+bounces-8346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9BC9A6A71
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA119281736
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90F71F8EFD;
	Mon, 21 Oct 2024 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="bDTdP4Zn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="OwNwMtRC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout34.security-mail.net (smtpout34.security-mail.net [85.31.212.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4C91EF94D
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517707; cv=fail; b=eMNcrPk0c7NAm8LTjtJIPGsxTd4z6FAZsbL/wdFRJmQKUJjOiLmJJyVVJAlHxVp8JRhbx1vzi5Ovv/l3zh8NokbfZSjARtVKjkz9jE42vF173wc65dxZ4x5WIRXuTo07jOfkZtSc+aIz0fkqoSfOd2lUZYWF6jRYFVcyCPwmLcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517707; c=relaxed/simple;
	bh=uICJ8KJLfrjysdrGIsRkiSWaussGKWwSuhXsz9g1G+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6bbNsY1ZZJNsprtyl3cgETAUCCoxPzhkO/H2NjpNRHdIb48xP65eUgQZVpxT0y6gcfP2G0w+CfIzi8fnF6BloYqBF6d0iZEX8ovFFUUu4mrxicjg7WFIl1y+AxhTZrAdMYnwn+AqYocxdNhOon0/jU105mNaG2idP1Z122KcjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=bDTdP4Zn; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=OwNwMtRC reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx304.security-mail.net (Postfix) with ESMTP id E9AD32A3AD0
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 15:33:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1729517588;
	bh=uICJ8KJLfrjysdrGIsRkiSWaussGKWwSuhXsz9g1G+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDTdP4Zn7uDz8h9jCbZkZ0jPy7ya+AycQUHPxA7nCsyRp34sLFg4DMFirF4jtpsyK
	 LzWViO3z7IXzo7o9ao5pQftCpWO1IVq/iLjWP8xhFUf+8/6zE6c3IOinQBLsMIzZCB
	 YD6Qsc6nWDnLc57k4UtdwwgCnJxKxo5D/yGnECU0=
Received: from fx304 (localhost [127.0.0.1]) by fx304.security-mail.net
 (Postfix) with ESMTP id B4E092A4530; Mon, 21 Oct 2024 15:33:07 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012055.outbound.protection.outlook.com
 [40.93.76.55]) by fx304.security-mail.net (Postfix) with ESMTPS id
 24E5D2A4528; Mon, 21 Oct 2024 15:33:07 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2339.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 13:33:06 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%3]) with mapi id 15.20.8069.027; Mon, 21 Oct
 2024 13:33:06 +0000
X-Secumail-id: <10612.67165813.23051.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG8lQkaTl9BFftfNkXkOtqvHZEMhyUfN10o10RkEpwEMvehp0pTwzaXgfXIJy8BMTLDRDT1TLekc691ADk0pNElvaA8mNWuK/kTlkn6xXKLLWNheAYP9HNhNFEspW29VSDWzfKLaNGAPSpDZIMpWRljrwnunehNcsWUZYY1x4iOaw5dQzWfaeF3PVQk3zYBoszGG9UKege6kNt2ed/1Ty5WqMsHu9cQAXjb84xHf1gKAMYCpWag/4AuPBzA6HExtgRM9CXQ3G2y0PFkf32pjipczl4fj0LQhg5uaHzbrORK/lT+ypCdtxp7I1QVdj6U5SDK4uXaiyqO+lETJ3dRiRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssq82j9Qbkmg1cRToienkjgOiLGK2G6nnz6q05Vjq1k=;
 b=LszJjhX2obncatXYEPqhSzhJb03MgimIfgkVrQVCHyWCS7NuWDPjtpB+ioYfVrR931G8tYnv8/AdyhB0eSqfnX4f3yUtUmTsqeYkff8Cr9HTyUhSPoCvcwJXeonjw5Tc/WmglP72sl81qQ3j9QAYJR5vKW9lsW10Jdjvf9sYh0ZlzTQ0N/a1D02ZBoyGj1EhM2DkIJICAOgQbfv/hKkS8iqo6vb2FiGheTmh5qrtzSPzmpVgDQAQETdG10wz4UuEDFbI5M2F8hzQ6IM3szsLO/oK33AEAdSuoHT/6YBoZi48dwjjDdrjN0AWhaA3cz1kIx8MqLegCol+wBu28Om4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssq82j9Qbkmg1cRToienkjgOiLGK2G6nnz6q05Vjq1k=;
 b=OwNwMtRCqmAc5i3L8GL1tB3wuttljJvSz1P9Bc/IQsA9W1u/MX3yqZQwCWXtZVWQain9owl5iNTvF4Nf/JSMJ990qgJFFmYztJ76kbKxdgWqbIwFhqffnwSITzZM1uA3K7ascd+2BLHWQ8/a620Q+Ood8TeAYQvf+7jNc89TJyRuFNE8iKLNkvOaMhM7HjnqjJJID/fgmlFx9pj1e9qo7rGyUJ8QHjVjpwCFOTSjsTxTYTW7rbBNuLjJsjqoW6eKgP5DjdPE4xPSvjh2G7/BRW4S1pC24/18nBS74EP+zrPYCgVEJLXaV9KO4Q9hAu+8F22c5qFB/DNZmwp9yQ4XPA==
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
Subject: [PATCH v10 1/4] Replace fallback for IO memcpy and IO memset
Date: Mon, 21 Oct 2024 15:31:51 +0200
Message-ID: <20241021133154.516847-2-jvetter@kalrayinc.com>
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
X-MS-Office365-Filtering-Correlation-Id: ddda53a6-32b7-44c0-261b-08dcf1d4e517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 98hQq+5lkcCAg/EK51k5jG1vryOKtBAkUUflHalRWCEIZ1TvkH/1+mo/SQ3IlqrW1EMWY64Qz5+jqGG36YJIlgrEo2biE3gCvncOVWHZoALb6ASZrNDpRqJS9xS3k4Fw/tTsMhBXgyI1sQ8kbz0CCzdd4QfZrwx4t2x9L6x0KDhF1mpYqtmflKqyGq6FRME3cIY3vZiUx8Rw+qMTLjEKx2yN4Sbdvd5SU53E/6E7vJkbZ3qMV+Ab3KEoDbZUK7G76g1nxQrZn5lAUJKI8wCIlJEWol6V2Y5xLo9SHDyU6fhIhUYgoWzm7j+4qQYsf+vwhBZweT5UTcq6u6LIYXG4PbH1AZVy7GoSUGq6F7JhlmN65yJkEowEDtb3uM1HTxxbOXmeKUOOIUG+CLVn96ex3fZYGoxkRdfk6g7vBQ5Bkfsps/XdizL3Hogs2D+pro6joZD+tg6cbGq8WtgoPupx78wqjjZLmDbaS6Wm1y0XOEOi6qSGb/InSmTRDB1Dxm4QBkH5HIe2azj4KOYago+p4PYDZBifvVaXx6QGwUjBiECbGfigDuUsU30o4oyV3SJ3yybMYFtv/iGIrSIYyT+rwjVgxf1H5VIh9CAir0kp/ZSGKAV0X/Wmq65esw8K725VuQZxRuypc28c+EddKCC8CVVdfZ/wQ46LP/Vp9IByR/B/F22hIOkZO87d+O+xzOpxHfwr3AorQtJsvASp9DDQGa2M+4rvUzQTuBaAfjZeM7TYS7/p4X4SggD6TLLJoZ6x9sVJGiPGQMPrXAHOVCBPiqipbMatjERV7HRmbO0nRn/p8Fn4wuWCPLWdxPAfEyiJhdLBZm9BIwlpa/GS4aRsXQNDsclNeBDRDPxREwJbWVAYGb7LxMwoIQv8/59MJlnupMu5GEk4YTYaeLC8I4+Z2io43XpgWj4VJ00pNZCvmuKRPlkZY/UNTlyNo32DlJ+PaE5
 JbKCncZegGWm8lDycwbnfC/5TObH30IOV7HW2IAujbh7QQggwTLJ2qkmXLarrsTB4NzjwePb7zd+m3wNFmJTx0NO3yk2qxxQaHVq6cwhY1lSfMp7ODFv+36jU74RmcH2qauVyg0vlNI4efHUF6QCaQ0xUVqiqaAqCv32FnIsop2n/ACFZSI7K4b+B17mxbczHBP6YTNgh24bypgqmJdfH4iJAvqePd/nPGdsU7l57HZVFT8aNbwTFa6usoImJtbVx8ymfQ53UIYnVOg8dKg0qxPQlEMJEez/fFSsE/IeH9rv6KiSrAupyEknxAAJQgT2sw1iwcrxvDNziMl3fOEs3gbtao49u38XLS5YfUvIzci/cpS6UFwTwQ26+ztUkkSHhC847nZiRC9Wpv43yJiv5M3MIynsrpQ7TG9JnX0ReKVlWvN5DRJ7pmDEKfphb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3ubZV3yvhvw9wEueJwvx2rvWza3xDYpADHyqSkXK371JOYWP9oGN6VVYJuda9B38VAjvoPGyBUqcGTzzl6fY9gZ7Xl6GWE5qGKq0oxodViUjDeeHUmUgYltC8nPEsx4PWs4fpw41IHN0My/xDVjlpoU8bEbCqyfJVlA0NHIDS0micMef1eeYM1G5hd35HwRNSDROODshfeIAyoD7VBepB3jUtZ8pn/DRaB1cauLRurl3LASNdDWIpy1UGyLvei/8dEGF/IySipsdrHfG4eZTg/qMvs1bvCWCPkQgFIaW3rNPa/20Nlu1Zq4wkrdKSUq5qc6noIFUEWt3wPVSvKHIvwf92fr4Bu4dZaZjfrTuUJ/6teCFUEYpz3ZB2HdZGz6upSD1xnrWsP/zN8y6xSdYiqlNaymdPjlV+y/OkC8jdZQqOTvn6eUO27N0uIZVMbHPgUaSbaWV65qyvV3SzyiLrKLh/YsP+yEl6QhpQRyFzkBLnEGutrJar60H0+xyieCE2VBBqdV5/eBEzMX1tPz5X53/KVfotbOHv7vYsjrY8tVfyp/fX5jglobUb1fctAuOx69Hi09lur+ctnYdWVRTBlxCviLhWLBoeBUfcYvOYDwfPdS3dA5ulTgiZId/wiWXdD/DOycrbBpgibUdNKs0Equ+iZWokeqVbkPclXYhdCiZN2+AQtFeHk5L6r/EwoqFVDTEPbu4mmGEVJ1g/fDR1QxE4odCHYjZe51Rmc5gujB2m/O8adq2K/9ot9VYpf5tCACVFB9vJS2isIiPNLI35n4V/BM8Q8ke2O0mZKkF67vSEz6DrjiC9Ew08pwVNJegumOKc+RjkX15kVLumcMU8+J2vQqR1gbbriPeiQ9oWSyVZPgYPzWMcxMYKHaUb57UayKpXZD5mpqt7Jxg2lEW8BkR1apm+mCFkTqEWy8z+8jkBMdXewJOqZlPZ2/RlLIu
 5D0AVRKTc77cAu6q7+Bq8AGbRmRSFqzFz7D0WSMh7mNOomHYNGw3J9F6pWr1v6BlF28bftc2oGuHhfFZQEnWBccrR0izbYIbjQEjk8ocCu83ey3Nnzokdvw03/K51VH84f00fNktN/JtnpzuU77PPOX+1jWJUZ421UN+cvS4GWInDjj13PsSqPxf78WphSX4XGVoeGN8uR2mijSzlZCSW2PPm4JiAb4qxGE+pizhOkjFDarKT/N5lkLQMkqUzGuXRXBxOpWxc+r/BO+xlrOoinee94g3560bqZdLwFTCsqRhmAP3x+BEUF0YK+BPaafmHcXpfTWe3+og4bkmytH9JFh8m5ZcoOBVQchoL/xJNbjlNVjJg4BaA1qpF7I+VfeMgUFOzC07p9uKc9ROw4zshJlkAf13JAkKWKRgpnXs5VXf4hQ0IP+l2dtFctlytiyL7vmQPaNwUesJ6kIxAXh56O+8P73kdl3WGXv4MmVtzb6uA4OZmkfvAFCjC+teLyvTWQ2jPU8ProvdLKAu1g7Lm//vD9w4K2gm/voggdZxef+GR8ITSzxBuRapFPF0j/U73ujeW5sGqVDRW7i6I46O6Mfx5V8yHJdOF1baIqbXHHRmDPsWFVWnHAtVW5unyPHQ
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda53a6-32b7-44c0-261b-08dcf1d4e517
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:33:05.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kIwMtCS1VKi8eonl3y2a3vllahimyXhuL5sXFvpWtOeJvdK/EkQQUaUiK9GUHKlpTlzrPvtYQtZJFmPbRfA2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2339
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

The fallback for IO memcpy and IO memset in asm-generic/io.h simply call
memcpy and memset. This might lead to alignment problems or faults on
architectures that do not define their own version and fall back to
these defaults.
This patch replaces the memcpy and memset. The new versions use
read{l,q} accessor functions, align accesses to machine word size, and
resort to byte accesses when the target memory is not machine word
aligned. So, architectures that were using the old fallback functions
(e.g., arc, mips, riscv, etc.) now have more resilient versions that
take IO memory constrains into account. Moreover, architectures with
similar implementations can use this new fallback versions as well, not
needing to implement their own.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
Changes for v10:
- Removed iomem_copy.c again
- Updated implementations directly in asm-generic/io.h
- Updated commit message to reflect the changes made in the patch
---
 include/asm-generic/io.h | 116 ++++++++++++++++++++++++++++++++-------
 1 file changed, 96 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 80de699bf6af..00cbf8587586 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -7,10 +7,12 @@
 #ifndef __ASM_GENERIC_IO_H
 #define __ASM_GENERIC_IO_H
 
+#include <linux/align.h>
 #include <asm/page.h> /* I/O is all done through memory accesses */
 #include <linux/string.h> /* for memset() and memcpy() */
 #include <linux/sizes.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/instruction_pointer.h>
 
 #ifdef CONFIG_GENERIC_IOMAP
@@ -1154,16 +1156,40 @@ static inline void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
 #define memset_io memset_io
 /**
  * memset_io	Set a range of I/O memory to a constant value
- * @addr:	The beginning of the I/O-memory range to set
- * @val:	The value to set the memory to
+ * @dst:	The beginning of the I/O-memory range to set
+ * @c:		The value to set the memory to
  * @count:	The number of bytes to set
  *
  * Set a range of I/O memory to a given value.
  */
-static inline void memset_io(volatile void __iomem *addr, int value,
-			     size_t size)
+static inline void memset_io(volatile void __iomem *dst, int c, size_t count)
 {
-	memset(__io_virt(addr), value, size);
+	long qc = (u8)c;
+
+	qc *= ~0UL / 0xff;
+
+	while (count && !IS_ALIGNED((long)dst, sizeof(long))) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		__raw_writeq(qc, dst);
+#else
+		__raw_writel(qc, dst);
+#endif
+
+		dst += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
 }
 #endif
 
@@ -1171,34 +1197,84 @@ static inline void memset_io(volatile void __iomem *addr, int value,
 #define memcpy_fromio memcpy_fromio
 /**
  * memcpy_fromio	Copy a block of data from I/O memory
- * @dst:		The (RAM) destination for the copy
- * @src:		The (I/O memory) source for the data
+ * @to:			The (RAM) destination for the copy
+ * @from:		The (I/O memory) source for the data
  * @count:		The number of bytes to copy
  *
  * Copy a block of data from I/O memory.
  */
-static inline void memcpy_fromio(void *buffer,
-				 const volatile void __iomem *addr,
-				 size_t size)
-{
-	memcpy(buffer, __io_virt(addr), size);
+static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
+				 size_t count)
+{
+	while (count && !IS_ALIGNED((long)from, sizeof(long))) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+#ifdef CONFIG_64BIT
+		long val = __raw_readq(from);
+#else
+		long val = __raw_readl(from);
+#endif
+		put_unaligned(val, (long *)to);
+
+
+		from += sizeof(long);
+		to += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
 }
 #endif
 
 #ifndef memcpy_toio
 #define memcpy_toio memcpy_toio
 /**
- * memcpy_toio		Copy a block of data into I/O memory
- * @dst:		The (I/O memory) destination for the copy
- * @src:		The (RAM) source for the data
- * @count:		The number of bytes to copy
+ * memcpy_toio	Copy a block of data into I/O memory
+ * @to:		The (I/O memory) destination for the copy
+ * @from:	The (RAM) source for the data
+ * @count:	The number of bytes to copy
  *
  * Copy a block of data to I/O memory.
  */
-static inline void memcpy_toio(volatile void __iomem *addr, const void *buffer,
-			       size_t size)
-{
-	memcpy(__io_virt(addr), buffer, size);
+static inline void memcpy_toio(volatile void __iomem *to, const void *from,
+			       size_t count)
+{
+	while (count && !IS_ALIGNED((long)to, sizeof(long))) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= sizeof(long)) {
+		long val = get_unaligned((long *)from);
+#ifdef CONFIG_64BIT
+		__raw_writeq(val, to);
+#else
+		__raw_writel(val, to);
+#endif
+
+		from += sizeof(long);
+		to += sizeof(long);
+		count -= sizeof(long);
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
 }
 #endif
 
-- 
2.34.1






