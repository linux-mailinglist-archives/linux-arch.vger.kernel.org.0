Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66F61026A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 22:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbiJ0UKq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 16:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiJ0UKe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 16:10:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2D142D62;
        Thu, 27 Oct 2022 13:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkNo53cNx53/NH1ojk/ULjH0JzTwoHjOBEHetptwv816B8yWuHdYMYIxnj8NcimrSEqW12tazyHpibf42hb72d8iJhfwdATj2vbpclQRDv/NVBq04dhSvSbBDTM/aIyA8/I8rHxaFJyo9NYCjAzNqrUu+8BISEWP+oHwT86ddND8H98ajap30RESrXsQaS/LRiU8bNOc+41m+AziMFAqP2rdNFC4olWsTdYlzApcWZpN3UemwUSPQPSGPCn1aWQtlzt94Z0tVps8uhpaoyux1ZWtni1oE4EHcgok0cgpkhJzKXZOQzEi0z/MeBijKf2XOhSEQsl/uNC0GKWOw9kC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErTieuUf1a0AEbviSnyTQ+5hjQZl4lJn32HDoS8V7tk=;
 b=QKJxsGhGtunVgI9z+CQJ6LiTyqso0mRSITg36GWRdARu2eQJaVMavb0QbdxUZW/SYeAzbLTNj3bE7Rk90nme+qvPRjO1+i/mgJA5ORzd4j9sRLLy+ZIxVCXD08PXsZEVm4l7+IdJUOfKpl8dFdcxtOD01krPfdR/6QZxtMNWxpqcSumFRrlKwt5CjqPjZ3zftxSvXF6EseNafed3M9YDQymFWNgs4enykJaZejKhKOfdi8xBV9VVa9lPMA+l7WES34vBWp983XLPlNZ+DXF1IINsgoiz3c+hQccSkq6FgfGNi7WuAbLjP1bpObM1Lnwex6q2YzGe0SuM7qmkNgl9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErTieuUf1a0AEbviSnyTQ+5hjQZl4lJn32HDoS8V7tk=;
 b=k2JgVgmwj7cpun5Ua1qE1gOPuKQJCzosCJ7xH1XMx55pAI9hzB1m1XrBnhS3zeEbylH4TabdpAwdPGriuw7QdfErMq5Kb5S6CGSIFJnbFrJQk0eVFdJiBmGIDi2KqpWYfZ9GEa2IKGGhuHgKc7B6XYFc7NytgMclRQCI09DI+P53Romc3Xb7lIrT7Twh119RmhOC8RVIfyIUJKiuY/T+Dhb9a7TmTclomXp/iEwxY40P8OW+QAKOnw/h234MQCValwShsUNKaWphH2LGuZPELuqIj+zjcpmNv3QCyxso4Jecsz03fF7r/MoK/9I1vkC5df3OqeSicvj4rO56+IazjA==
Received: from DM6PR01CA0024.prod.exchangelabs.com (2603:10b6:5:296::29) by
 SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.21; Thu, 27 Oct 2022 20:10:30 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::f8) by DM6PR01CA0024.outlook.office365.com
 (2603:10b6:5:296::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14 via Frontend
 Transport; Thu, 27 Oct 2022 20:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 20:10:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 27 Oct
 2022 13:10:16 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 27 Oct 2022 13:10:14 -0700
From:   Parav Pandit <parav@nvidia.com>
To:     <bagasdotme@gmail.com>, <arnd@arndb.de>,
        <stern@rowland.harvard.edu>, <parri.andrea@gmail.com>,
        <will@kernel.org>, <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <paulmck@kernel.org>, <akiyks@gmail.com>,
        <dlustig@nvidia.com>, <joel@joelfernandes.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     Parav Pandit <parav@nvidia.com>
Subject: [PATCH v5] locking/memory-barriers.txt: Improve documentation for writel() example
Date:   Thu, 27 Oct 2022 23:10:00 +0300
Message-ID: <20221027201000.219731-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 54587a02-9220-46d4-850f-08dab8574bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9TRyBNX28FaMHuoH8BdDoV/r5mMwyo3OCDfzgozqHoO+2V3zmGxHshFdrwPiCOUmYqWWNIp2D2Mh2lywkhMIIwiDlUirj6D7dbeFs565IUXXC58PJ+3IbPFpsmi+JCaoNArk5RLWdgw7S4BTSde3mHg/Ja684EUYAtPabfgEsLMs/HBlMmx/Y3ItfeOm52247dBp/KojuSABqG9/JxRLt9m100ij34+c6B8sib7X6dptSGjix7WpFWTm9oYu517fuG1Jxw8k2LSd8gj9qONmLpOSUPQiIwof/+J5FDSEnfbecwpCvqUMccaJgRJaTxIKL0gDve8u+kb3qZ7FhzzWTKj1QB2X/NIEXKZ4rh54FaxFwrc4st2yO8oTIEDUnhwGdIn0kYMDWfZFIu0UDje/hrr03USHlLmpf/szMphjHaoy/FUVcx6sD6ABGYTchFVcHs3cZZyamU0mpfE7KVPmdh7E2zI3lGZHA45FqbP5pHOV5Qt9P5NkbpcEFRa9ThCjo5r4Mg1rYlBkBNIFLzvOLcgs1zNhokvDRS20gln3vvq1Co4tyKWvmGbEuY5f072LtAczca0IUvhSrvqCDvj097K8oQChLEofk7Gmo/0RF4jbf4e/JJ7Uk4T39wa65v1jnLZcyEKrMJnyay8+x/HVi0p+mSuIMdgbrBoFIvASMghJ2wXpARtbRgdj8jOWjrhDuyVtp6MAOLGXhs6HUM2kbUJBiRQh0vLQy5yvVUZOI2rug4j7zIV0jEDjCziDY78B8757nLOQoBtWfjyu7UIrh7pk90OyUU5DhdOCf5+GUo=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(1076003)(8676002)(921005)(4326008)(70206006)(40480700001)(83380400001)(16526019)(7636003)(2906002)(2616005)(336012)(47076005)(36756003)(82310400005)(41300700001)(26005)(70586007)(186003)(8936002)(7416002)(5660300002)(478600001)(426003)(356005)(86362001)(316002)(6666004)(110136005)(36860700001)(107886003)(40460700003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 20:10:30.1486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54587a02-9220-46d4-850f-08dab8574bff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The cited commit describes that when using writel(), explicit wmb()
is not needed. wmb() is an expensive barrier. writel() uses the needed
platform specific barrier instead of wmb().

writeX() section of "KERNEL I/O BARRIER EFFECTS" already describes
ordering of I/O accessors with MMIO writes.

Hence add the comment for pseudo code of writel() and remove confusing
text around writel() and wmb().

commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v4->v5:
- Used suggested documentation update from Will
- Added comment to the writel() pseudo code example
- updated commit log for newer changes
v3->v4:
- further trimmed the documentation for redundant description
v2->v3:
- removed redundant description for writeX()
- updated text for alignment and smaller change lines
- updated commit log with blank line before signed-off-by line
v1->v2:
- Further improved description of writel() example
- changed commit subject from 'usage' to 'example'
v0->v1:
- Corrected to mention I/O barrier instead of dma_wmb().
- removed numbered references in commit log
- corrected typo 'explcit' to 'explicit' in commit log
---
 Documentation/memory-barriers.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 06f80e3785c5..e698093bade1 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1910,7 +1910,8 @@ There are some more advanced barrier functions:
 
      These are for use with consistent memory to guarantee the ordering
      of writes or reads of shared memory accessible to both the CPU and a
-     DMA capable device.
+     DMA capable device. See Documentation/core-api/dma-api.rst file for more
+     information about consistent memory.
 
      For example, consider a device driver that shares memory with a device
      and uses a descriptor status value to indicate if the descriptor belongs
@@ -1931,22 +1932,21 @@ There are some more advanced barrier functions:
 		/* assign ownership */
 		desc->status = DEVICE_OWN;
 
-		/* notify device of new descriptors */
+		/* Make descriptor status visible to the device followed by
+		 * notify device of new descriptor
+		 */
 		writel(DESC_NOTIFY, doorbell);
 	}
 
-     The dma_rmb() allows us guarantee the device has released ownership
+     The dma_rmb() allows us to guarantee that the device has released ownership
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
      can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
-     to guarantee that the cache coherent memory writes have completed before
-     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
-     this guarantee and must not be used here.
-
-     See the subsection "Kernel I/O barrier effects" for more information on
-     relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
-     more information on consistent memory.
+     a dma_wmb().
+
+     Note that the dma_*() barriers do not provide any ordering guarantees for
+     accesses to MMIO regions.  See the later "KERNEL I/O BARRIER EFFECTS"
+     subsection for more information about I/O accessors and MMIO ordering.
 
  (*) pmem_wmb();
 
-- 
2.26.2

