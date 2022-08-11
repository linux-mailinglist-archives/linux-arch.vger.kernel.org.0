Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5558F7A7
	for <lists+linux-arch@lfdr.de>; Thu, 11 Aug 2022 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiHKGbt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Aug 2022 02:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiHKGbs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2022 02:31:48 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B5A89925;
        Wed, 10 Aug 2022 23:31:45 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B6JuQA026048;
        Wed, 10 Aug 2022 23:31:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=CHOBb/f//UarSijUkTV65HE94X9eKFKlTtg/gaKA6TY=;
 b=PMfHFjW6d2dqKvUfS1uq+P4Dcpv4meVdRXLGKDLxPykmjf1p5/LR6JMSXhEQSFG6jsAS
 Qx110r1b6d7r2WE2hYgatWetRSBYOkMB+8pVi/0Aoyo/lAqir6zff/I+0fRj6nnOYpLh
 eRgkDmwYV0OMk1/hAKi9eu1nXLzX9hUr7ZKcohikLc5YewCTXVEPLunAVfvqlMLgPF5y
 UPc8mYVyndR4ZARLrT/d+cp/iIG7R8EGZpZumVEEO+ClZlnc12n0DdDXznDsnmjuILHQ
 z4Db3LPiOwiPO+gZ/e9F3ShsS36Kzhc0GE7wX1IjezDuHeSsw3NcAMNr5yK0ONA4YcoE rQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hvqf285bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 23:31:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mssjJ9LwSBA38G0sevEelIWEUavsdL6+FOXo7Q7TTGfo9xp+6JeP5UDoPlPzQ/37N/zRDHYOGhX1XTHxh+LoDFhrY2Zkz49jtR4W44qSQ+v7xjiX1znWZgejIPYCMfG6LEiU+WrHIQCfAbYn0xkD9bZ7DAr1S6P0XyTBki92OmW2X2VRT6Sy3eCSleZebIHuqoklcU5qF5E/zzcH/CdLFljZrotDY/uBHjMOyTzNe0TFaYDWEhKll4Lhk9EAxmMrXonY6IEPKDMVOa1/FhLz+VkrDDppJcvhAuvNblVTqOYIf1fhn2yikoBnhUy2E4cLg3fq26wCS783dnm8Z2pisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHOBb/f//UarSijUkTV65HE94X9eKFKlTtg/gaKA6TY=;
 b=fB4SWfFEPk8OiYtV19Gnd/499X7yNaZJk6WT4mrgvNX0a+8OXdDgvIejC3SJnIFruGqI75gKFd61wTX1szKoFEu7JvWuceqB8LqSAB8uFzhWeVAPqpaPMNbqH5JKvQrqg/w4Upt7bj/qepQfu7dPAmi1wxj7TYzx3f2DP1ColAGKbljygk+E/BODbv7WTfRADJ5Kj+DFBG3yC8RwOT4Cb5N24Bimpd0WPyckhu4ttQsE/N1gXw8AyYs+y+2unbpxiKLF2pHQyXHYca9sYIonOqmcWKaTqKoPdkqodPG+YfMkCwWPCZwVR0BGfLRgZuKKPMwBXDjqdSzepozIYcbk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
 by BN6PR11MB4081.namprd11.prod.outlook.com (2603:10b6:405:78::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 06:31:32 +0000
Received: from SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131]) by SJ0PR11MB5630.namprd11.prod.outlook.com
 ([fe80::4057:7eb4:511b:e131%9]) with mapi id 15.20.5525.011; Thu, 11 Aug 2022
 06:31:32 +0000
From:   quanyang.wang@windriver.com
To:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] asm/sections: fix the determination of the end of the memory region
Date:   Thu, 11 Aug 2022 14:31:05 +0800
Message-Id: <20220811063105.2553381-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To SJ0PR11MB5630.namprd11.prod.outlook.com (2603:10b6:a03:3bb::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ca21a82-0fc0-44de-b870-08da7b6321b7
X-MS-TrafficTypeDiagnostic: BN6PR11MB4081:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLAiLUmCuGvErrIlNs4b+rrD+08Hhf7hcEBZH2zCxjLzBlD9vXx1hLivg3oF3X/JYOKEdWTLbwvgh1GoNq30CcNRTGYj/KUAjHFmYyps5Fn2go3ohrf5GA6BM7KGXQD51BYfh3ikQqoEhykJ7H5jdrrXue1dsdow1UK/zsmSK/++sOzWmFmmCN9v3nHf/EOe8oVEewz2KT1hMbKH2ezY/mU8kTj//WsWhQLHGO6p+R2czRtEg4jbk99xSt4djot7VNjTucTbSqZojjglUwEE5RWmIJ41ariCTM8tV0jJYuCxD5NCddkA5jEIsqCLAXEPcbpuCTLWWRtJsKo53Y+ILGVqA5FHXeDouxgL5BbpLHkysJeHAuOjexex3DURWL+CPp5Xl5frPQ5tZIdFpa23H/9EfwwpJAFm5qQnAo4XyiRC/ejMXlEMVHAVx9hjZ0NpClLn4SAeYShfPJDc4dPfdKFoA4E9IqfKSFT7cdpTr3wTkU5eBzeHKFA1hkdDxcWhv4pwg0n1q6mIwlmpGY2ecFXToQJ2moOHCuMYExiQtB/zLgda3zyM3XcCMFKJ0aCkfa66MnJADN1nTQprFwupVlnTZ6Pg1O1iouyLFFdBJJo5sM7hby5i5Iohuqm8SAW0LjhqwwTJEcDDUnwc+w8WWyVRl3pvPr/5IdQ+wNLsMJt4BpaRuyKzEyY7udHcSPQG+wfQkQT74qMPauqU7mYHkIehgVMRFp5hFpX695vHOHH9s40HXzemYyut0mtel06epqhjQglWkQmsaObbSQZ9Qz++yO7Z2gB8WhkQJJsGzsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5630.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(39850400004)(376002)(396003)(86362001)(478600001)(83380400001)(45080400002)(5660300002)(1076003)(36756003)(186003)(6486002)(2616005)(107886003)(8936002)(110136005)(41300700001)(316002)(38100700002)(9686003)(6512007)(6666004)(8676002)(66476007)(66556008)(66946007)(2906002)(38350700002)(4326008)(52116002)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TxYu7UqTJRp48beZlwTT/RwGhCp1fWq70JeXBedDVEshcWZVg2C4jyef6lng?=
 =?us-ascii?Q?C3WYZCR6Yn5agzsixo+t+5FbyAlTMVjebiwIuqdRRP5bDCmjOGHFNAy//osU?=
 =?us-ascii?Q?G8+sNWc/NPfWAL03yFjQkA+sqZXlOtZotb6c+KCTyWmYlTawrGYt5YV6P8hV?=
 =?us-ascii?Q?my3eYpTdmU3I5PxQy3YU24G/62MqaTXD8WDRuJ7bZW1XJ5jXrUukx7h/etEG?=
 =?us-ascii?Q?OT9uuyRsXhGLp3ohjM1SSGDUcwMG/5OXsnz6H6fXGFx9C7BnCtjqOd+APiD8?=
 =?us-ascii?Q?IdvW4dkLOjzShORQHGk/s1CvVcfv7UFpIzJ76Ao+D8BvIiHpxf8PdL7X3QTx?=
 =?us-ascii?Q?ufe6MP8ds+jkphLb8QxxzCaqq0TrhV7Q0yu2uJMlBHKJhZyj0E5JL4TPQeE5?=
 =?us-ascii?Q?DK6unq1RqxWFdh5wIN+96NU9AGgUeIOEGRf1g9mdGwddYmOTHirhvbnAxZDH?=
 =?us-ascii?Q?wEsd3DPi1aIMBYfw1oQNWxF2qyo63VKGXu9uJ95Ua2apM8VSb7+LO6QaiES/?=
 =?us-ascii?Q?QF+IDlgRQNIPUZKC2JPcGIgU9+VZZ3UHzyRLCxeAuv2ww0sEdu9zsE5Tv49F?=
 =?us-ascii?Q?FMe5q2ifKvE67ua46SpZNyCoh/kM9H3gBHxAC0WCjjpwH7+Hv+ZMrNYi38Z/?=
 =?us-ascii?Q?U+06mjJJYRn2+OglRINJ3gZ7MCIeuAIhSO1ZYdcNj3fRyqoxzpCm3CQQnrCe?=
 =?us-ascii?Q?LpjUdrtLBlDFF1PBfDfAYOTl4uAezZfdTUmwk5Aj+zD19KW0298w+l9Nuwtw?=
 =?us-ascii?Q?kNpcakj5PYxitrE6/pkF5iEvyE9Yqfb0s1hMN6JbR9PktbQD6RdsP6Eb1Zbh?=
 =?us-ascii?Q?4TO2ZVPmGCUYo42EcZcn4t3ZmCLi0LL0IkUxj0pdAim1MTDt7p57yPoJVdcQ?=
 =?us-ascii?Q?71zewmTFXBUFqHvkbIVe9GjFZmWk1LRc+IfW1am/6JpNW7gcV/5iC/AZ880E?=
 =?us-ascii?Q?5Y2N7vYkiV5+ADv1+7iD6ojRdAFfRJnJuZnUGQZL44j+el/Y9ArC0vp22nym?=
 =?us-ascii?Q?MqiIqG6kkYyuWFfReImJAhyMJXmq/0Wcm/4yeGHqaIkrRpl/bJPWFHbIIpBn?=
 =?us-ascii?Q?XfDAWfBTFxlWtNs1DrNDV5Da7uN4xymyspT+AMqKPVIsLfSBvHKDKB3R+Iic?=
 =?us-ascii?Q?FyPDM8aGo0VwDk3xN8SeF24GEqdYUUsJ+aWr9dFLVjRjBm5xj+lVH0Oc9Ab/?=
 =?us-ascii?Q?Nb0e1m4Orj0xRZcFqwINWgN/VoSRcQrrUrFwiyFq7FgLgqw96YscWtYC9D4q?=
 =?us-ascii?Q?NpRsYyJFDCsBCzqM9pih2Qj1uqMePo6t6ngNZEXNZrlc3G95EvhjVMAqZr8U?=
 =?us-ascii?Q?OqO1h61yhA9r3d2JfP8nNIZmRNLl4XuqUK0GmHkMWOMZ+uJIsJ0x7LyiUF2h?=
 =?us-ascii?Q?hUY+APnbO6+yz7N5NY6xLdpyAPJ32yftdkeH+2lMqKDGZ7PRsYB5/PXLUp2R?=
 =?us-ascii?Q?eMKcgE1GHDwRDi50dyFBL/tL1UNtKm6UzxhpE+lUwym+j8+e5UPW6m5cOgTC?=
 =?us-ascii?Q?7a1uOKSXaB0vu5g+B3jAe0xEz3aYflm30z14wu1Q7W58kgIMHahR24rbDPCH?=
 =?us-ascii?Q?yFlvQknj5GEhAmPPl4MFAaWRJeCtAurh8GkuyeeZuK15u9ZNHkY+D6oPLh9L?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca21a82-0fc0-44de-b870-08da7b6321b7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5630.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 06:31:32.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGGA5Cg0xnb+xddlZGTPKJJHlQIQF9tvHSE+wkK6Ul3Dzquqg+KfHKBI8zawxQUym7RYJ9BMIuZjhBzQI8hzBYJGxKXrKuGybhJschFb9UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4081
X-Proofpoint-GUID: Ja7_U1XlGXvVyoJmyf2jzg049hvJaqMi
X-Proofpoint-ORIG-GUID: Ja7_U1XlGXvVyoJmyf2jzg049hvJaqMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_03,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=864 mlxscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110017
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

If using "vend >= begin" to judge if two memory regions intersects, vend
should be the end of the memory region, so it should be "virt + size -1"
instead of "virt + size".
The wrong determination of the end triggers the misreporting as below when
the dma debug function "check_for_illegal_area" calls memory_intersects to
check if the dma region intersects with stext region.

Calltrace (stext is at 0x80100000):
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

Fixes: 979559362516 ("asm/sections: add helpers to check for section data")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 include/asm-generic/sections.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d0f7bdd2fdf2..f7171b4f5bfd 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -108,7 +108,7 @@ static inline bool memory_contains(void *begin, void *end, void *virt,
 static inline bool memory_intersects(void *begin, void *end, void *virt,
 				     size_t size)
 {
-	void *vend = virt + size;
+	void *vend = virt + size - 1;
 
 	return (virt >= begin && virt < end) || (vend >= begin && vend < end);
 }
-- 
2.36.1

