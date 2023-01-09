Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C7662699
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 14:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjAINMP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 08:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbjAINMK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 08:12:10 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2071.outbound.protection.outlook.com [40.107.247.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E6CD6;
        Mon,  9 Jan 2023 05:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB3JzWCxlgloFNNyH7L6wLiOOcKzQliFshKW46nz8XNl375p20j1W4JDR7OfbnZxbWKRwROgrmbAuXe/IoSyfyDcszbLO+wtZ53v8/6VLiIpEzbWiOTxfhrkFgtIzLYo6fI17ifX73wccpeVJy3TlA+EH4zeutECtMgbUXb46OTPFPiHGM9ZiK7CdHiZXFQrUBC1eT7KTaj3q7Os3/2eR50MpYq796Mrd86AqrpOuwKZFqniE2wyzPJ88LkW/9sgMnflYt2xScgsvznw3JS/J0C0zg+sRWYWNLHUhZp/sVj5yDS+/nFrpNeonEu7KcoFzEB5pMN/rvrfFlq8EDLxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR56DzMllJI/Ux2S7RnEyg77ZM1RzFADhxp+m8xrjRs=;
 b=VQpiO7Qmgl1ZIZhBNqHThAFsuoJF8CmZ5XgHwiE9/ABdn2WANfsTK9CVouv6y2d5p2CZjPHN3IEphin3B1gGhpaJhh/aa5Z9CmJFPa7qcKOSHmXXgd4NBGLID5R7P9H2fw8bDCHgZiGRrImfoJn+nJQvdDBECF/WHXWb8QPPDaxBx/ROaCd7f+k/XzAQ4MA76RI7KlmkxbaQM/wJcJRLenPZn4SAv15V3wm08fceSEif/4t/Lp5ggrxmrHGBz0jng4aXuVnZrq1l3EkDloBf7NaAS604D7Ltp3sazUS9RoUu3GCisYDuXNlPOgQQ4DltmfNg6gWeQjdSIVQnC/jsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR56DzMllJI/Ux2S7RnEyg77ZM1RzFADhxp+m8xrjRs=;
 b=CNSBuyz+6J9hceThh1VEDi0g4GloKQ+TuF0bCEubOUQPwHx6D81N0wfiNX2hSee0k8bN9cmeY0ugjZDRsbUjHsWuaZ9KCfm3B/a5bHpc66ZZNyPa3Nb578I7NILDnS+SIC6RBNE1OWjdyCEzeU8tzk+XrMxVGKt2OUQrmQrI2ck=
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
Subject: [PATCH 1/2] asm-generic/io.h: suppress endianness warnings for readq() and writeq()
Date:   Mon,  9 Jan 2023 15:11:52 +0200
Message-Id: <20230109131153.991322-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::7) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|PA4PR04MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 80113943-9b70-4108-674b-08daf2431b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UciY55pYLLfqx9A4YHAvvbJcr0XHWYwOkZQ+1xuyg2rH/xcz9wkNK2SR4VUm8L63vGOlpQDu4XJF7SfobBpUGXfuoQzANq4k0gfqK/OxI76EDRfcdIkYgp64cHhrlrkurSDETWCwCBn00R5gwO49cMwZUpaqTaxXOC5yDxvhz6alx14UzIhsrpG7r3jMgho0ggtjROkF/u4uIf5TCmIsiHyfXKad+GBdXTdtTWNPIuOj1ipnDXroOZaeqQHEN5ZIz+QcrdwaqHLuOQH3hbrSHXC2VKVhNJUjYMH9Tr7AXPxnDKdWkeVNzhb3PxuyH0GtwUCvD7ztmEHYy/nQ/+CyhVtaVhHzJNV7f5IKB4+EaE6UyPGEBNOnryoRqeDEeNYlWzA9QVsc2yTTYVqHYEiaNmWBTXp4SIsBlhE3mXjybXxiGIN0gGlVik/T7tlfG/Lsubt61k4mADiclAXKcRaYI1LfGUADChXEn3gHo6DP8AL9RJ2n5FjRt1wvQqpQbg5h2/mi3KJIB3yLd5UUmXsh/kBbLwScaR2EXjyPGDlUfohRLC6VQ3DwCuXeSQc30MCKsFaeYsQMxOEDrHiVsD0VZHAZXREPxXeOKBZPGLHwm80fux83Gd0CYgwoblqgufFRAd3S4zUMRz3A95NGkP1qW0ZRqC0LoWFsmPaARaN1J+JPZZM5JHPSBbNesVOnhBSRAxFvoxPeZ6xg1jZhtkb3IWoy38UBQf7nRbJ0sJ23cM58ekbdWJYsZlDrCQWJt8OY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199015)(2906002)(44832011)(83380400001)(1076003)(2616005)(66476007)(66556008)(52116002)(5660300002)(66946007)(6666004)(26005)(186003)(36756003)(8936002)(6506007)(6512007)(478600001)(38100700002)(38350700002)(8676002)(41300700001)(6486002)(86362001)(966005)(6916009)(4326008)(316002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nFjY3OwJvPfJcOVsRF4utLy7g1nPE6jbSGyF8FsR/ksbbINJw7D/AKMVmwbq?=
 =?us-ascii?Q?q/yBGZs/PRGLkPtWtVmqjci4Qpz4kQl7zkfutvFRYggEdHXoWRGDeqv1U2XE?=
 =?us-ascii?Q?Ld9TuRHIBGIKOpti5p0tfvZgsLcXB9OcLq3Qce/H5jC7Dl0w9GCmOPEPug6r?=
 =?us-ascii?Q?xmxdbCEvQ9lH3tLa1GCd8NwDeESg/RiBoFo1pWXf3ctb+/mu6DaOPQbySi4C?=
 =?us-ascii?Q?9oj1iTHAG54utjqcVmqmlz1Db2a1iI0vjBjLlf80ghDTSsSaMC6BNRVIonzh?=
 =?us-ascii?Q?nKlxWHeqJoUgvJPL20u3+u/jxA/XKkVtWdblBmcKK+FKNVTDAtTsVny7XssC?=
 =?us-ascii?Q?daTiW9Hp0iSJJHY9s8l9W9Q2l6jbM0zSW7uiw1OevHLY0fTobTv8pxh1w9Dv?=
 =?us-ascii?Q?OuaDr2akLcr1dq9o3OjHCUdfE4efRv3kz5o3jD4VSuYHjSIoJjckTWSP11o4?=
 =?us-ascii?Q?xaWD0xhylBHBFIEyt4PRDdIvHZzd+Cw5XTaTMZ0l7RGcIZZjB76GZIgWWt9V?=
 =?us-ascii?Q?sEin3IrNN26joJOO9qhDJoI5o/5BB8W5/lDLKMcDVu8Va29uyhmCdNebx0Rr?=
 =?us-ascii?Q?Jq/CGQyLkUAj32XnjgOItW5aW/LkYYmUkc0nCVNPHBIAgq+mfYpIXWsVQSsX?=
 =?us-ascii?Q?C6pkcoVyV4iHS6iNuOqek7Tt0+nHXFbYPFWo1AkrdQTQdIwZ9fIuPf6kiyvI?=
 =?us-ascii?Q?eijQyTfR1/Ewkz6JYVoDXGFy4XX1YkIHgTxGgXZulgBKElPFAOSzumo2qShT?=
 =?us-ascii?Q?u93uOvVpCUofUVDFt4n6gBn9wZ3XWCBuZBjnm6sJiKG2iYtpxnFvklfMy3Ds?=
 =?us-ascii?Q?vf98smDD9aBfJmgR9SbE3EEwySuuUdy+L3NFwposRbIOC2PIMR9iYaFi3C3J?=
 =?us-ascii?Q?TLmY4hFAlHZrn7RNLa/2hkVi05sgbN2g3N65lGUcebFSAUxHWr+Xrk3gamxL?=
 =?us-ascii?Q?mQCuDdNFwtjgvr+rQNp8Fu/d8Z6kFXC3pYdvCz8nTvqKeuzYc25kOQQgzUmO?=
 =?us-ascii?Q?oA3Pj+BsgFEVaf9dp1V+QHBfPME8wm9FNmSoMKq8lDI6DflziJp9qB4fR/1U?=
 =?us-ascii?Q?upmvSxeBUuV0U/HO94+pwHhrV8GMVDt0sMb9pMbocd20drlyKkEqoGrNJIko?=
 =?us-ascii?Q?Flp7Va0ifRVnybMUyZzmDT2slZKdoj3sduM4zLeymGwneMy1oD5dWekH8JZM?=
 =?us-ascii?Q?/WnFVLMNa75S2CW/+tvQU4/gs+HG5dmL8c95LUyR1ZwQzrN9ynU3IZhelO/0?=
 =?us-ascii?Q?zU6WxLEePvPkr0C+7s6Ytw7V1n+Ab3CTMSzVJmAIJdCXE3bxSKK3lOimV2ct?=
 =?us-ascii?Q?oaIhKYlKV/RCEhO8uUTJusqYMbyZpRWouKg29SJjtI9at9XtrjZ8/ePRAw9F?=
 =?us-ascii?Q?+bP/hB0evBXNVYVIaNuKZ1t3V1Z6y5j9xUNUezUEAfM/k9w+eK7eyusT6SQQ?=
 =?us-ascii?Q?yoSvR4V9y6ekh9RghzR7TBMUR3JyCobFaA5MKKb3oxJSNNV0CnV8zxKzFpI6?=
 =?us-ascii?Q?Tz+7UINi8jXye7iKOEFZvOwIcVlMb/Znr/1oI842NqF11D7hUDls7sHDkPhE?=
 =?us-ascii?Q?f7v8NzwaV8ubDSfB9x2xvrzmaJJKxELCp52vzigCXHaiii0bIOfIfXhC0SAV?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80113943-9b70-4108-674b-08daf2431b2e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:12:06.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4h+lLeacRMSeURrOk/0mcr3mm17st8Bg0d480aA5tKTkSSzHkAwgY7LHxhjr8rcFGfcSXWwK0Kv+H4HHw8QZA==
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

Commit c1d55d50139b ("asm-generic/io.h: Fix sparse warnings on
big-endian architectures") missed fixing the 64-bit accessors.

Arnd explains in the attached link why the casts are necessary, even if
__raw_readq() and __raw_writeq() do not take endian-specific types.

Link: https://lore.kernel.org/lkml/9105d6fc-880b-4734-857d-e3d30b87ccf6@app.fastmail.com/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/asm-generic/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 4c44a29b5e8e..d78c3056c98f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -236,7 +236,7 @@ static inline u64 readq(const volatile void __iomem *addr)
 
 	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
 	__io_br();
-	val = __le64_to_cpu(__raw_readq(addr));
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
 	__io_ar(val);
 	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
@@ -287,7 +287,7 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 {
 	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 	__io_bw();
-	__raw_writeq(__cpu_to_le64(value), addr);
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
 	__io_aw();
 	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
-- 
2.34.1

