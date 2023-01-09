Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA4B66269E
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjAINMo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 08:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjAINMM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 08:12:12 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B335323;
        Mon,  9 Jan 2023 05:12:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfyMco7ufPfHQ6h8VKqI+SBeXmH44pLnek9dJO+ZRWlVtdXuMfjcy1+ltvzZX3UihYEyha9h/0v5g161XknqLwY0P/ZvnhbRNL2/bQfT7qgISro47bQTAYCCsbMHq48Y5JlTAsEs1Y6LtUpuOZw+g9f4zUQeoPAlRaiH0k/VMCHWwRGrLYTAveuK/JHMQBFt3Wc04Pzd5L4HBVhu2XlUkm9W/0eICC4j+hfibjj2KZSW0PNHf2BFrWp2v8UIJ+fa63iluUQkw5XYsyWaqynQNRsQGAGiObpZ4koyxai0ZJIhXb5buEqDOKZDnS2ewF4FqN/ewFAFjJ0yCOkPsNNk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsmK1XOQRRUJqPdMUYL84c+DpllXPsEMLjtEDxLIl3c=;
 b=exlh35RKM3DEobQtqWoW2sPmmnpt4iYpz7ov6mdQFejb0t3ljHNZmCZKB5aQzW2hh7MCKV5sx8oiZtRZ6kZp+lHyKd3xFcW0WyWEYvOgVKbNNFdjyDYwKqP0PYmQRFJmwiikMAfuXyQNaPPo9gok5GmEnLBwVRfjhmI7m58My2ekQbB3oxPu867FJH5y8q5UCbVA2Ypmdf5y24vnRUajP1dluCh3zCL5nSmxcQKK3lexqztl+5/OB2npwO8r79P6+BAw01tkGqB64o73QeHZX0Er+ZhNGI4BvxWdBggq5zkSjUEo9Yr44zKLR8YuzueNholjCDXlW9X1b50t4nvV8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsmK1XOQRRUJqPdMUYL84c+DpllXPsEMLjtEDxLIl3c=;
 b=jQ62VcPwnHuJQaBXeqOLJSgi1tGRRyoa4hTFIgueg88d10CgsfO2HkDQNcKiGa9CiMcvq+eWHzgNytGq0nMSN+Q6/CRQYvzG9x+cAUe5Y/Wouel0ZxMhnNxmFyN8dM4Ka6FQS5vX9kjr5cZ3xnY8a8s6nbGP0albYmwzy4Tprh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 13:12:06 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::3cfb:3ae7:1686:a68b%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 13:12:06 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] asm-generic/io.h: suppress endianness warnings for relaxed accessors
Date:   Mon,  9 Jan 2023 15:11:53 +0200
Message-Id: <20230109131153.991322-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109131153.991322-1-vladimir.oltean@nxp.com>
References: <20230109131153.991322-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::7) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|PA4PR04MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: dc38df14-1bf0-4fce-ea83-08daf2431b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25a9XaN9MBHPo1VQUGfBMVRAnRu2zw3qyYLnjMGmK2eNlCJoWlTLH+eBCyadDTKhX8Q5NqmhG41rZ6wiGuwqxg3AWHGpUG2Vrt5F3GOPbFVlAC3pH6IOOR5a84IRhRuNQq/XDzIOBFjcXG3k7WY+2ww0+sov0Ic0pReG4kT49a96CJ73e93AcpA9Ndar6UpvQfIMyoc8czFb3Mkao2YOJGswu1mCS8HKXvEPvtB2ptM9uR9CJy99gpTmykHtTL9Q02ByYrCS0vgpdcbrzVu8rstBWsySmRX+qCjJz+ciZRWI6rj6TxUDVpCTjuptOcusUFUw56RUegj+PhtvTTbyzUwNQKwzOXVMyX6kCDil+3WMn4snocRzE7MlY9InH2ZjTx9eZpzCXdAYHbWm+Go+C+KAOxKohO6R5fRQ9fDfO/xK0GopAHEAXk/CuTGTEfxOhSe8PAjtAgU3QimVJwiZfEM/TwC1JB62Mx21dM1ap9mEjRE5HDvSZK9yQwSxP/WyKNd6HL1dmHhXLU4MRYDHxc1l9glnJw35kCP5l7NJrV3OR1JvHnh4brQJoqusg7i3FNfkbA4Km6RnP34LPGgWrR5pcCWf4/cb0JTMQT3LpgmLgWhZV+1NNonKd9E6FPK2hxWz2SvrYQ5b98p/N86SPiiFXXdc/VNUUQ2gIMkHyVO41fE4lGZ88Apjh61tRkSlx4Khk9kDjq6dkCOQctiM4d06MZm5V2GnRbibo9EZyRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(2906002)(44832011)(83380400001)(1076003)(2616005)(66476007)(66556008)(52116002)(5660300002)(66946007)(6666004)(26005)(186003)(36756003)(8936002)(6506007)(6512007)(478600001)(38100700002)(38350700002)(8676002)(41300700001)(6486002)(86362001)(6916009)(4326008)(316002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2K+Ws1NHVvOkDDSLHtftVf36RYco5FuIj9wNkv77uTst1kI3UDwMYD+feYQ?=
 =?us-ascii?Q?qwzIDtpSxo9Z7xE1aPQT/uFRZomE1va6p4qh/GRF8wfac2PuA78uz6f6yBFZ?=
 =?us-ascii?Q?cUatQQRzJSRAX6HRllcUa2hHu8JSx2Cv84OYPlLaNMbRDNqARG2p6wlCYP3r?=
 =?us-ascii?Q?ka7rEufKUSgXrN8qLQF4lUIiykHb5He348/ipeLEI+vBYjKHNYPriiLq1rdE?=
 =?us-ascii?Q?yhvaPivK7zYmDHepG9Ns2IIHQrLYwuONu4VMLVggmKRZ2dzyy4eakWR904Vz?=
 =?us-ascii?Q?MVD9z61sdIcjycdEOqf4eT1hinhObI5s93daIxphmjZnRqHCBooNtO3Rghhn?=
 =?us-ascii?Q?og39NLrtgH4UXeoJeuC5p0XOlgYTRkGotT7dRKC+l5jB+DnuOfkFhDsp/OSi?=
 =?us-ascii?Q?cTWDr0eJn3rBlu3dTyC3fvcT40hq8anencZRWQmp2ioO9LiYrXiT6eNETOo7?=
 =?us-ascii?Q?i3AV9L3cV3Vl7y7s6epOsLpcUysMFxbbbGnKmub4DGCPdgyQl7CXGHXthZ78?=
 =?us-ascii?Q?5npX/5e/7zffsLioqV/fFlPLidA2dPV+6GdEgDsepzu+GrC+MGNPwfNvHwpT?=
 =?us-ascii?Q?bjjnRQBKoTZ2c9vDolG80Xu8bluTmePgNIRxZWDiGM7Kg1DHYoQqhwJtBh2i?=
 =?us-ascii?Q?JT2TBJ5gKgvpchThmhTCv16WSI+psqJFsMhliKcDa9G/7qqJCJJPqsvxeQLH?=
 =?us-ascii?Q?zr6RqSKttJIYE7+eVqCqqlgo2YQyfdvzvSoZn8RvnFVD45Rp2ndEN3B3mUo2?=
 =?us-ascii?Q?tBNdPXetS3wR2YKuqkpXyQLHbwH1R7g1q4rvr869tsQ7sA3oPCIKQI841/JD?=
 =?us-ascii?Q?QHGWInXZHw68ESPo2coR/wlmlfS9CHyBHr9+3i4Xrk//ZiCcOLi0vkQskf5q?=
 =?us-ascii?Q?3S5iq13dugLMb9/svSikBl1FShvzWXXwX4orz0Va13v6/5RkjfiX9eLj60JF?=
 =?us-ascii?Q?LTUmcy4cFnHLOwIl0AdpmjjGCD7m4YmRab0YONwAAXbgGC4CLErkmETJYqO4?=
 =?us-ascii?Q?M8ELY0LmpeDeNBMjd6kCFM4dLZ74q08ZlhYl/FDe81P5qzEXZ2KfhpdSMNLd?=
 =?us-ascii?Q?CnHzZdtb/4f/uw8WHdv7uPM2foeKzHfttag06kGck4WqcaMViCRrrG30MSmD?=
 =?us-ascii?Q?UX05eQk55uPuX5GxlhP/IovnhJ7L1LkqYo/RmkGDilGbLcc9ykEoSZ3g+QDH?=
 =?us-ascii?Q?hoCGULqUUdU95vfnQzkXTW4LmpQ7WCLvCnUM4yXqna5rKYnaHF7oC04ocGPY?=
 =?us-ascii?Q?gfDcVezG7e6HXFOrIMkKsKTS8ZBt4lCNi6qnGTTzShZwfQtMk9CBC9EFX2eW?=
 =?us-ascii?Q?Y/lEGVbUlW4T14EAKtcowcCj/s5aN/9dkdRoa46kqESHpdLkMJaWbIsQLVYa?=
 =?us-ascii?Q?qO9vgxnZr68PsP4nlDkF7bkzBkbOlnb0cx8qjEbDdoQkDCGrBV6T0xEMKIOt?=
 =?us-ascii?Q?JxdOJvM9zlLTLoY9n2JamaAicd3TyUqUs2g1Bvuvat/1iIyVkT96K+uUpbze?=
 =?us-ascii?Q?0Z0Qtj+OpACFGgkMZZQzmIpPZ9H+5XIsKFp/1yZgtw14RXKPT8xZt590PT9A?=
 =?us-ascii?Q?4CZ3UB/PSbCTAmNNM7euZ/fBa2McbWpTMWRbdkJVlGh4rTfNkCIloFr4LahR?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc38df14-1bf0-4fce-ea83-08daf2431b94
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:12:06.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyWa4TPji7gO4rbEagJBCJ8ebbLuCbXYvHsN2JjTiR7DNjD1tTAa5Xq1x4Zhoqszpf+Pzmc+Tmrm2RNoXRJl2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Copy the forced type casts from the normal MMIO accessors to suppress
the sparse warnings that point out __raw_readl() returns a native endian
word (just like readl()).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/asm-generic/io.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d78c3056c98f..587e7e9b9a37 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -319,7 +319,7 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
 	u16 val;
 
 	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
-	val = __le16_to_cpu(__raw_readw(addr));
+	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
@@ -332,7 +332,7 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 	u32 val;
 
 	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
-	val = __le32_to_cpu(__raw_readl(addr));
+	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
@@ -345,7 +345,7 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 	u64 val;
 
 	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
-	val = __le64_to_cpu(__raw_readq(addr));
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
 	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
@@ -366,7 +366,7 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
 	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
-	__raw_writew(cpu_to_le16(value), addr);
+	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
@@ -376,7 +376,7 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
 	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
-	__raw_writel(__cpu_to_le32(value), addr);
+	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
@@ -386,7 +386,7 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 {
 	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
-	__raw_writeq(__cpu_to_le64(value), addr);
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
 	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
-- 
2.34.1

