Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153105F52DA
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJEKsc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJEKsa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 06:48:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286426492;
        Wed,  5 Oct 2022 03:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt451qEQ8idnuP9N21nNlasWLqrAU64mMgltya9UmRo8MtIZyL2fXQLqXIWxY4V6kUZ/IpVavqd0uNBqtWM6Yy7yZF16Z5sPVKylUk5ZyEUX3+LTdS8O76OpRMa2hVV7Qz9xbmIQe+JelHK/zwAi/9x5jfPZw6am3SFy8jnMZ12/0RjwWhh5SaEg01IYBBFRuNDi+P9GLrD7wNNr0xjc07/2dOedfs96FM4i3pnVcwRoGylJvqzPz4O/Iz2mCvXJCJuC6wl158EV6Fnkp4s38EizVkM9mwnFpXXYpX56kWn2RIMNb5OuBiuPZv4AKUH35omDrZQ2ODjFKANKTU4JzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJBPwexMSz65qpShAUDCZzpz97te/1aeuMRvQBgNVf4=;
 b=aON50kfN0sVr0HqGeK41a/dnHuZr58ItDBKOwJBLRbIs4YPUvCK1jKm0q/LwE8eX5dN/tk8R2eMBE/NjFEUSH1r0tGb9FjXEAOugT/UpC9MjheIGpzSiuOIHlwkhH85uvl+9qnq++2UxEdDUKONNj+L9TKgDT942DZzaSoMdEnsNOgAqywzUjPCllhbmty8HatI3VjUAP7cqjq7MBIq8L/1HdcsQ9ITN93fyw+88CT3k4989kWzyWdpaeuCXWARCgJv2p7b/Iv0c16ILy2dcKIVmdrlh3I3oZDuFnQGu5YKSrhcetO3D6+bAgi51ENtsLrk3bHkWxZ8+qY04BL9rRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJBPwexMSz65qpShAUDCZzpz97te/1aeuMRvQBgNVf4=;
 b=q4HKR1k41II6HMZZskOGmj7q3RJ0MSJ6KMSLHMQ0YPd82IUKdxHihPVfOTbdqxMFcRjtLezmp0bl+loPZZ7RKvlKfwy3kA/A/AIxNQBN75XX7QRZBtmN8kNSBidP9PdDYDr/0G4d/4Kjnuq7E7VxodnMJzBDXfKxFoTkZf03aoiskuLhrMkbdlPWl2nJYMt8UCSs+CgY/Kx9U97TidDB1Ulbel6B1zKCYXij3NABqVFrJEA+n1b3rv3OP3sNv/Fgw7oYBUgLh7i9D0vkZ6DdDmQLgUGmltGhOyfoI9nX+Hi8Kpdeq5D3dCG9eGEHKI1y83i7qLZDn4ne/fujEfhxWA==
Received: from MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::21)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.15; Wed, 5 Oct 2022 10:48:26 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::7a) by MW4P221CA0016.outlook.office365.com
 (2603:10b6:303:8b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32 via Frontend
 Transport; Wed, 5 Oct 2022 10:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Wed, 5 Oct 2022 10:48:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 03:48:12 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 03:48:10 -0700
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
Subject: [PATCH v2] locking/memory-barriers.txt: Improve documentation for writel() example
Date:   Wed, 5 Oct 2022 13:47:49 +0300
Message-ID: <20221005104749.157444-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT009:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e6e44f-440c-4d2a-b8f8-08daa6bf21f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4cHgTMoQrhp9UvuGc8qTC0kYAxFFCLDP+Et59XdFs6s0Ie/vrSiFdnbTotcSskin/0qt7eQMXl3m0CPbiRLRICmsa6ftcvTxkMQB0nqifqE/XUoPrGd4ULmNLk1f5i9VBOgzG1DF6A4t1TJtLfKimJVX1BNw5POpCCCce5COxTJ7Yi9KNwXIA605gmnJiF64vxPwkCULsvaIrRlw6LAmAZqYaYwfVetDw2HhA5S9N/oVAfulTbsHwHcGUpupQ0IcgUE1Fj1FGvxmqE1WXcRr4pqiw+oqqvBKtLgD1cR/aq+oFDVAf1FOU9wH1ZaHpTD9yPlHUjBbSKtKTv52dqKObn9YNTXwuOwHJ3axMKf4/uj1q3GxgACkMwzGlKIvm1OI/qO7/dWoc5Ws6UOsGYj+p2ySOKHEWsumoJ4aCiAwbG0+GuYxPKkZZzeMug+0Sl6TVjV0gGevHIXHC10iWCp4FxoporN+05Z10P53YAMxQWufWfX5ohrKVZkQzMUWyNN3nRsjjIMeCpesJnGo3U+9ju8zla5sFPnfZtWk0whNm7A2qyUM59g3BpGAPlmd3BBIGLgvjC5vBDcrU+Rf/XW0881/1h6MME4zjjA23e/AH3+Bhk8/ucTjyJuMrcN9PRmcZDKIcqmECmYCQ0o9ISQ+xvMer17ErxSFdCphZuaqTMGDjLWu2VhwFm7ug8l+ur0ULefJ9G0b7oMqqpkMyuBpc9dUpv6Vz3ju9aOI8rgkZyDsaZCwbt235ajIdjCGsmvdDs7tuiNyiHD4YQ44oTmQ9byViZsKMkV+mAgnV0tmBdQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(1076003)(107886003)(186003)(36756003)(4326008)(356005)(40460700003)(82740400003)(86362001)(110136005)(316002)(921005)(82310400005)(36860700001)(40480700001)(26005)(7416002)(7636003)(336012)(2616005)(70586007)(426003)(41300700001)(16526019)(6666004)(47076005)(8936002)(70206006)(8676002)(478600001)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 10:48:26.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e6e44f-440c-4d2a-b8f8-08daa6bf21f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The cited commit describes that when using writel(), explcit wmb()
is not needed. wmb() is an expensive barrier. writel() uses the needed
platform specific barrier instead of expensive wmb().

Hence update the example to be more accurate that matches the current
implementation.

commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v1->v2:
- Further improved description of writel() example
- changed commit subject from 'usage' to 'example'
v0->v1:
- Corrected to mention I/O barrier instead of dma_wmb().
- removed numbered references in commit log
- corrected typo 'explcit' to 'explicit' in commit log
---
 Documentation/memory-barriers.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 832b5d36e279..49e1433db407 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1927,10 +1927,12 @@ There are some more advanced barrier functions:
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
      can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
-     to guarantee that the cache coherent memory writes have completed before
-     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
-     this guarantee and must not be used here.
+     a dma_wmb().  Note that, when using writel(), a prior barrier is not
+     needed to guarantee that the cache coherent memory writes have completed
+     before writing to the MMIO region.  The cheaper writel_relaxed() does not
+     provide this guarantee and must not be used here. Hence, writeX() is always
+     preferred which inserts needed platform specific barrier before writing to
+     the specified MMIO region.
 
      See the subsection "Kernel I/O barrier effects" for more information on
      relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
-- 
2.26.2

