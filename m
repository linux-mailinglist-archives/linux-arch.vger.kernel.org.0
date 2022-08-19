Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1409259970D
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347495AbiHSIMh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347520AbiHSIM1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:12:27 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F92CE0947;
        Fri, 19 Aug 2022 01:12:23 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J81R3w032256;
        Fri, 19 Aug 2022 08:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=GzlxUwlsHAuvzE/c5csI2DGwgf3xC3y+wvayafrJCn0=;
 b=Cs6LdLXkPNT8jeRfSXWHKifq+r5PqFKXJWSWQhhX6c5Dei6Ib92+KgPn/kYQjZdKfN4K
 kxHV0CTM6UZg9xXxwObUX1eaS5aOAViN7nzopzHmaOsu60DnrOHeBfAFEByhnaF4YoBC
 xVMcPhjwby5vlfZaLHZnqhI2Tqc6A8+oxY6v7iZ3xQNn17aJdnbNUVB1Cep6V8FbuB+6
 P0rejgWSeQXAiSA384MuytkjAp5bMT3tKVBQ87qwszFKwnlCQgKUMhrmtfgvOKLG0+OG
 fsJ9olT+jrcpcrdNz8hRScPHw4hrol3+N65e/sXhc6w0TZF6INVM64mKGx5Hw1yej+nd 2g== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hx2x8n5xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 08:12:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5sQtZ+qDiBtJHM/3bBhNuH+TgMgIshw+U0TgzpMRvIVeik/y7qYUuoyCPa08grgXn4zmIBBm145i4x+exD3H3r1xE21/dfKSxoDPbUhJ0KMa/Oj9xDukVQxr5l0cudGRUnA7KNoNZN6GaQoLxJMJHRN55yx1QQZKW0e9pOQIVAsW4fBqEKCa7C296vFg2+WThaOeBQ6k6X/PVkwwP97WnoXfM/1OdYQ4cXkJzoL0x9JfMZA/P3RJbsz5ngExBaiqh+BgJO9OD7YKBNrz8CwllKo95RTx1SFfIZa7RQrnWUq/OvvHnqPKBwxC95rgsIUCl9d5U9WWrAmwTqpu6wlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzlxUwlsHAuvzE/c5csI2DGwgf3xC3y+wvayafrJCn0=;
 b=XRv8+aLJy80Yyh5i2nlZJhtBlTma9HI0UmBzqRceHQKo6ZE0m4PO4zuZTjRn4ttxqeFE8ijkYRL/6dIC9Lhte0ynuip9XFBpCaQOAAtrHaJ5EA5o9vaOS7ELO7p6/ayvuiz43vRJ7c5Oq7OaDOCIGkpMtGjvu5JZdVk2hhzmNTa+fpNAsSDWo5FcjZLD2DyUdPpl36E62SU8SONlA70C/p24ayb4fGihEKIBJdOWy/q8wfABo0w0JZ9PQwAkBD8Ip+ptdVHtZgnd0OI2ElzML6P9tapI9EZIkN5m0o5Yoz0cb7UOeEtRi84hDphGlHn89vnPP++9jf6/IkgIzKtn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by MN2PR11MB4318.namprd11.prod.outlook.com (2603:10b6:208:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 08:12:04 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131%9]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 08:12:04 +0000
From:   quanyang.wang@windriver.com
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <treding@nvidia.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH] asm-generic: sections: refactor memory_intersects
Date:   Fri, 19 Aug 2022 16:11:45 +0800
Message-Id: <20220819081145.948016-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0164.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::8) To SJ0PR11MB5630.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28504438-c29f-420f-daac-08da81ba7ff9
X-MS-TrafficTypeDiagnostic: MN2PR11MB4318:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m000Rir95KyUbaUcUUUzWDd70/qhB1Hj7NsL8ZdogZmWcfXZJZFHXACxjYlrjzEL2pt7lUOLW2BStwgYYUP259TIF82CnsnfDEPiz0qpBTVOr7cdD4v1pCiUXkff9GrnHS28jCTsBUB4ea/2p3yFZJ+VPjcagHld9SCpuVJahdXlBVcYSPsK3vcPuvW3XpaOKDgiuyl49tD33YmKKIEaAyXc70sIO/OfBAuix0jhXwAv+CJ4Iu2UvPIUYzh9DyBn6KZa4fZ6Bclf8a9u+7cgbXaFu5JHyBZpnKTaEuNYKHuqGFbv1wzn9O0X8lu6cITt+HNyBG/Y2N95AYbpxWB4xF5tylXfiDjsLg2UcVBrjoPyMxIzo9FhD1IUnoFWF+083SpOnI+YlmO72CXDuTmVZwnMccjZ8p346lsM+9HJq276/DHGesmBwmyky5UpUPukAjBEeRQPMVdy3fhA3Xroy1eRAxwubKXEmlgo+67nngQf2MM3Kkn2QhvNltBfhZbuWrAw06zYZ5LX3w2cN273rTGetmMcU8xCKJTlX0iBf5hdxHhuI84PQsTHZuzyHwB9tEcRXrpTGK1MQvnPPSqGeBfNk5TFMVImlji7ycc3xJXnb5TRO1VExdqfZ5v3XaEyKVeS6ayITMoZgp3ynV7YBFLMslkv3+r3h/W6x11/bUADyzACBL72n3wZueLXckoTP48YB3DQWEbJbq4uBGaQssCDsGqZ019cp5pNoF1B2crcJDdrn/lwVch+Xz36volbYx1taV1dIG12DuPPTtvStfMXRbDgzmPIcsurE3f//Gc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39850400004)(396003)(346002)(376002)(2906002)(6666004)(107886003)(6506007)(52116002)(5660300002)(110136005)(1076003)(186003)(2616005)(66556008)(66476007)(4326008)(36756003)(86362001)(66946007)(26005)(6512007)(9686003)(8676002)(83380400001)(6486002)(41300700001)(8936002)(45080400002)(478600001)(316002)(38100700002)(38350700002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fPmDmwoFcS2XYSl1z57tvaeDC3jK189DGQOIVBRKIuA4bqvr3C8YkvUqEZol?=
 =?us-ascii?Q?B947zjCS3KnwgdfPKCm3Q8hIxaUToPM1KzcOTJk4h+CqUk8CXsWiHLscgR6A?=
 =?us-ascii?Q?uk2uylQmxEga++SbfdMB8c+qZNT0qwhNAUarHLrW1C1XxjeSbhbwWfcT81Za?=
 =?us-ascii?Q?ADQRQArQ+k2U2yDW13zh1whPN7N8P1niPtTA4j1HiTo79Os2OBPFSOEUGvAt?=
 =?us-ascii?Q?Exv0gANprKWhsPVwHLu+H4R6bpvjSTqSBkPhJjYSoXbJr06xu3CSjDgUp6p8?=
 =?us-ascii?Q?D75ScNzxVdVPEHZOs59AFlnCp260aCxSodVH73Gqviqtjto8iLV0uz0WDy+V?=
 =?us-ascii?Q?hp7gW3YQdWy04vw/dPXSNlGQ2nhJHQEmOoxa7WUyujL09jDLil4CYjPhEPj9?=
 =?us-ascii?Q?0ftS789DTAWn4mQGSY2bDz9WgT/4KKB12Raj0PQbKfJ2Z5Utbed7z8BkxFl+?=
 =?us-ascii?Q?/CZZJrH3V/GFWXj1/cYAucdKbAea7vhVtdcLGjaSMFzr54CE1BK7klEuV2yp?=
 =?us-ascii?Q?Gi6mDHeAJEFq4qLVMcpB96H8beCqIeR0nDXwKfrWAYpRIghSrTL+/uOHqep+?=
 =?us-ascii?Q?jRVimJBSOb+lL+MEATjGZYMHx20DCLdq8NmS/5Lk7fP8fRbiUIncKyNxyNw8?=
 =?us-ascii?Q?f2qwenCC0kx3Am6bvFh5QXdDh6M6WxrUQ/IE8ldMQxFHX4iOaZ8XtqLXBZaW?=
 =?us-ascii?Q?0luH48mqtYv4mZSMsuzDfq0Z13GkZck24uXURdHYhYuVShIF2uV+urvzrzpb?=
 =?us-ascii?Q?8/VFn1iM7UptCV0abGLeNtdJU4pIhqVdpYyEm+xzWZy4UadJk0ReDCFVGkSp?=
 =?us-ascii?Q?QJPyn8QdcJzHRczOzRkGJ6Er2bMHySIsQLz/I8Vul2GQfVb9LEagvnOMzdws?=
 =?us-ascii?Q?jZflBj7xTlTgfGI9dNDWJzdtCD2hE9VP6MSxISG1tMJ1izvRMhBIjJTJu/2x?=
 =?us-ascii?Q?r/T2OtynZ9E5P2CnTmAkujstqCU8ddJhVmC/CoF0c5XhC3yIvaS6bsCFe3N1?=
 =?us-ascii?Q?+/KHtBNsEMerUX09QVlOcYVT5vbWjUbjmIMnE6fw0UQ0PAReDu2IFMcowvEK?=
 =?us-ascii?Q?/CSgWrnC4jtYxP2+k/5CU34uMLSCi/2qgj7UQXHL2NE5q4gO8VwMaGl0JIHK?=
 =?us-ascii?Q?eJrOZ1q0obCCqQn+a1MfpltK1QyF4/iWgsX8f659+IEuIeyuiI2w1FN1tF5h?=
 =?us-ascii?Q?jRLydHbKIdcZ1vfVP3BFGszFjyLLEgh+09Pt/g0JlwjphaP5fK4MsWHnC56/?=
 =?us-ascii?Q?zCxqpphZL+xj5GRZkMcuAuJsw0s/1qMC9vxLs6TcG4owM6I7jrT2ULHx/PJW?=
 =?us-ascii?Q?iiykh8x4Y8SiYy8ApxxF7ia+tg1yjLafC/9HWsPFiWNHA9wuw2ON/L2HXizO?=
 =?us-ascii?Q?F0oKCBZ+qrIqa3iuxJ4/xyjGyNBgCZA9PpJxZGHf7xaAY+tQaDIQk41ff+Z9?=
 =?us-ascii?Q?t/icb6Di7CdztyJlrnh/UM8ZhSPkNEIPfJDKpF8jhzkQ0Ips1wmQ4kpw8VMd?=
 =?us-ascii?Q?ryN0FzK+sphQFJ5VJhymv08LiVFr+033fQq4SPOIDGDxu4IkIMNtTOUW0Kf0?=
 =?us-ascii?Q?KumA+i+HbM5COH+D5zxjstuImqi6yiQP6f3PdOb9fiDw3BTd05ikU9+1Vugy?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28504438-c29f-420f-daac-08da81ba7ff9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 08:12:04.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3+euS5tY+pB6VxWY4iLMT/4uHQmpx0sWVQ5DvPoiw18/F2Y5QqjlZv6dE2TgKmOqx8sSr+jfQHOVM2evEYfdBUes16+8tUqniVmG94zAxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4318
X-Proofpoint-ORIG-GUID: hHjhWDhSPKvGp1G9XOXcVfHPER4MRuVw
X-Proofpoint-GUID: hHjhWDhSPKvGp1G9XOXcVfHPER4MRuVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208190033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

There are two problems with the current code of memory_intersects:

First, it doesn't check whether the region (begin, end) falls inside
the region (virt, vend), that is (virt < begin && vend > end).

The second problem is if vend is equal to begin, it will return true
but this is wrong since vend (virt + size) is not the last address of
the memory region but (virt + size -1) is. The wrong determination will
trigger the misreporting when the function check_for_illegal_area calls
memory_intersects to check if the dma region intersects with stext region.

The misreporting is as below (stext is at 0x80100000):
 WARNING: CPU: 0 PID: 77 at kernel/dma/debug.c:1073 check_for_illegal_area+0x130/0x168
 DMA-API: chipidea-usb2 e0002000.usb: device driver maps memory from kernel text or rodata [addr=800f0000] [len=65536]
 Modules linked in:
 CPU: 1 PID: 77 Comm: usb-storage Not tainted 5.19.0-yocto-standard #5
 Hardware name: Xilinx Zynq Platform
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x58/0x70
  dump_stack_lvl from __warn+0xb0/0x198
  __warn from warn_slowpath_fmt+0x80/0xb4
  warn_slowpath_fmt from check_for_illegal_area+0x130/0x168
  check_for_illegal_area from debug_dma_map_sg+0x94/0x368
  debug_dma_map_sg from __dma_map_sg_attrs+0x114/0x128
  __dma_map_sg_attrs from dma_map_sg_attrs+0x18/0x24
  dma_map_sg_attrs from usb_hcd_map_urb_for_dma+0x250/0x3b4
  usb_hcd_map_urb_for_dma from usb_hcd_submit_urb+0x194/0x214
  usb_hcd_submit_urb from usb_sg_wait+0xa4/0x118
  usb_sg_wait from usb_stor_bulk_transfer_sglist+0xa0/0xec
  usb_stor_bulk_transfer_sglist from usb_stor_bulk_srb+0x38/0x70
  usb_stor_bulk_srb from usb_stor_Bulk_transport+0x150/0x360
  usb_stor_Bulk_transport from usb_stor_invoke_transport+0x38/0x440
  usb_stor_invoke_transport from usb_stor_control_thread+0x1e0/0x238
  usb_stor_control_thread from kthread+0xf8/0x104
  kthread from ret_from_fork+0x14/0x2c

Refactor memory_intersects to fix the two problems above.

Fixes: 979559362516 ("asm/sections: add helpers to check for section data")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
V1 ---> V2:
Add the consideration of the condition that one falls inside another
which is noticed by Ard. 
---
 include/asm-generic/sections.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d0f7bdd2fdf23..c51b3e7925cdf 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -110,7 +110,10 @@ static inline bool memory_intersects(void *begin, void *end, void *virt,
 {
 	void *vend = virt + size;
 
-	return (virt >= begin && virt < end) || (vend >= begin && vend < end);
+	if (virt < end && vend > begin)
+		return true;
+
+	return false;
 }
 
 /**
-- 
2.36.1

