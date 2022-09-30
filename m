Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC45F028D
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 04:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiI3CE1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 22:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiI3CEZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 22:04:25 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975B2058B3;
        Thu, 29 Sep 2022 19:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kETGe6/9nCcMfXYXWoxQIPj7casaDmbGa5v5RmYDfy34p2PieX5LB5qIPByGb4HwwY4fitQejuQcUM2nx22YrPEGtfVdi1BRkI8A9Xolhv5p9vqMEcTjVZCZl9J4FHDesHZb4/3wSPYghglBV8siDERTTRwkYntTW/Dz6Xqkn5MnlQ+rJHGCbuaygyEpFRr/FrCJwPfacb/zKMP7clOXWPQ58a8hPWxu4zGy2LCnGL8TjL09oWUSE475anOT7NIfdNg/5TzKXuKxsrabDQjT3bi0d2UEwTn5O5av4BZk9IVUqmO11SBQIO7BJVZUaSDxQUn2XgFhUGJ+XSzhrrReGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LduVG1TKBccMDfICu5iUOv3yPldimGM86U0153GDXQ=;
 b=QZERWgElfqcBDstbUXzVNBep9RaxX0Q84kbK6Kf7oX92dISh2SFMMeFB0rGaWB/27HDHj+ayfE7ZWuaCalRJaQE158UHF20WOfyejZocnb0L9+etHxEgYeYRsBE5FzteKehaIU+fN2KLIhfIM8AKyoNuGzUgLPmbK2so6db78ycngEuUCt06VfdAiHrsiQwnIjigTqxG/txhbnOJnnUBgWIbKOGGM11mHMYtHughb17Vism8QnVwkcG24v829N27i0cR2wKC2ujoUCdQs0L5PjwGngM46EX+UQuAWMWSjZckCgvtHJJN4eUivbEo71wUwD93Q5ZjRfNfuKqT0MZW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LduVG1TKBccMDfICu5iUOv3yPldimGM86U0153GDXQ=;
 b=U2mvPg+ATfRZK1OXdkdZg/1el9THCwc0aMnlHN9jZ+B+TDTp7leoohrgoSVGda6vNyFBlw9F2pazcP1SpDu9esxDjBo9JDFVD8xTpdbroAbjq6NcSV21ok8u7K3SqAjD2GS8hvOUIUaSVB5hTQWWd2otrTYsOAAzT8SkbHnZk5jXy6Io7UaTPKqHaziCVhj2jbFJvYEmvtOMYSuJVIFYpsSYaIWlibI8/9Na+c9Lof1HOosIeQBc7dJgNTL8vVjH7yQK2pmnLW7JwP6iN9yHqsbMJNgoBkQy2LYqCaVkwrd9lt+beFhNgOaHM7l4zBLbuwk+pgqNoChK7BzKa6d+XQ==
Received: from BN9PR03CA0561.namprd03.prod.outlook.com (2603:10b6:408:138::26)
 by IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Fri, 30 Sep
 2022 02:04:22 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::24) by BN9PR03CA0561.outlook.office365.com
 (2603:10b6:408:138::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20 via Frontend
 Transport; Fri, 30 Sep 2022 02:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 02:04:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 29 Sep
 2022 19:04:11 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 29 Sep 2022 19:04:09 -0700
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
Subject: [PATCH v1] locking/memory-barriers.txt: Improve documentation for writel() usage
Date:   Fri, 30 Sep 2022 05:03:55 +0300
Message-ID: <20220930020355.98534-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7d846b-62ef-4b8e-fb69-08daa288179c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q349KS0N3okZYKW5d4KfgYhS7inCXAvM7SemMlVUaK1UYSwFvR8kZJIhJXh3nZdE9ZVsV9oVVqABeYYFwFamwPLO0jej5cNbST+cmT551lZ5SxxzrgVSm5z6u3T8TVlpn76jPrAD8Hj4gJxWOEzOaiJwy8fcjkkP/iTfAPYutGj3eDdlHXQPihv1U5BaTAW40yNZD3wG12m3HJzsPW7EyEKy22AuvCNsqLr12eT0n6CGS6Gu+//5e1KnqF6a/cZXcKQLpNUaOHTAELROkk0N4a0ijkmREVLH+FdtA9cYcK5ATHfOuZiUM4CSeI90VNCW2L72KwiRKzUNg8N6qiYBpUO4AiqTfV8LMAWfLAGUhv2UzZyQ8GWs+1nMoKmtW19Q/dIyNcD0Qqxws3PVvee3KDsAvLBirM/ZM5LIlDS6fGbs0TXygb93osQ28Db+9qXlDRuf1ahInEF+2P4A5z55+bGCIjR0C5t/q+SEY9QLRxiLa6fzhsjhFRR8KRHhXgLByfO10Qih6qSwZEtvHnzLol0VKJnmTn3gLnNzb2UBhunmT8KT+M3UltV68xdbxog5eZpm1Wd64GTtbGkiBAocjZZIvxbRypF7EaQoCNwaGOMb/2qYxwt3xOhO9wa/OMMKcvWJsvhrBsguTv91Bh3FF5ODv+EwQ2faKnOxEJ65yjQMkvM2wJeey7Du+5QeoS4USk448jApabpGN0Zn2gYhRj0/HG1h0PjmeP4+YkljEGvlu2G7T35fOAVZA6kJaiJozK+8XSbdtFp7n+GKuvwKzTjZ6GTvGBh2xAajxw14nDE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(316002)(82740400003)(7636003)(36860700001)(86362001)(36756003)(921005)(356005)(1076003)(7416002)(16526019)(336012)(6666004)(186003)(82310400005)(2906002)(5660300002)(41300700001)(2616005)(47076005)(478600001)(426003)(40460700003)(26005)(40480700001)(107886003)(70206006)(8676002)(4326008)(8936002)(110136005)(83380400001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 02:04:21.9731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7d846b-62ef-4b8e-fb69-08daa288179c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
I/O barrier instead of expensive wmb().

Hence update the example to be more accurate that matches the current
implementation.

commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v0->v1:
- Corrected to mention I/O barrier instead of dma_wmb().
- removed numbered references in commit log
- corrected typo 'explcit' to 'explicit' in commit log
---
 Documentation/memory-barriers.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 832b5d36e279..2d77a7411e52 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1927,10 +1927,11 @@ There are some more advanced barrier functions:
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
      can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
-     to guarantee that the cache coherent memory writes have completed before
-     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
-     this guarantee and must not be used here.
+     a dma_wmb().  Note that, when using writel(), a prior I/O barrier is not
+     needed to guarantee that the cache coherent memory writes have completed
+     before writing to the MMIO region.  The cheaper writel_relaxed() does not
+     provide this guarantee and must not be used here. Hence, writeX() is always
+     preferred.
 
      See the subsection "Kernel I/O barrier effects" for more information on
      relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
-- 
2.26.2

