Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7695B93C9
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 07:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIOFBp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 01:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIOFBn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 01:01:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9D5F7EA;
        Wed, 14 Sep 2022 22:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avr9mcCotpYKCCoRndtSwLsDspky4i9DWdhTI9TjSQDFSdR1ugTl/C12ZCe9lTuIWTbRGSw35gJfAo5zmNEUG1RSmqDyspdwMr8XIvDARPEhZHgnZxwnqRQURGOAAix+q3yk4oimtOJYLUPHHe5JVgKf2vnKXNO4BXZZM/oLz5tek3fLml43WYtVQeDxVq2SomSVaaiLajkq2Lf5AEFo+sx8b/TPPhrmrOfOltnL1IuIUqVUa1uSSsEMUvUO5ycX0NBoVi1iJ2Wb2VKmH/2iZqVCI8CMjd6DQYmuagJR7F6QfPXCU+5Nj0vGE2JzA+Wh2JNHs7SuBN7E0caNwOjCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/t+1lNqyvSfFCQudZZI4cEXQiiDadzd5V5OUqc+25k=;
 b=oe28S5W1pRrQtZg7XTmJtEcv8fYeXaFUd2tFWEYXdZVzT9QzaDt2xMSUDsusiBZGmXqamsAFL5dkEA2Fnr55Wfg/R6MDYftiomIIAr3eaGOdet9Al7zpQkSFQmBf76ktDBO2VD9pazFY1WQFcUlSjfh8NCOyFlAOedXLYN0u8Ai6uxhti4o0NX7fvLdW21icWiQk2X7uPlh7YdyR/qx9iov8tFFU26uWER6NgOwem5Y0SoqISP8u6aQNn6gYFbPdldHmz4SA6OWfoyPQEXYCEykHsYfEp9ouZBd4gmh563hlHXMFRnFoY7OxulCIbaB5Ak9i6gbVqEwY6cu+ZXJ77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=rowland.harvard.edu
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/t+1lNqyvSfFCQudZZI4cEXQiiDadzd5V5OUqc+25k=;
 b=I27GrAA4xemul4qgn4Tx8T45NDx3ToM1aCBU8mQJkyRnhHbNmWxh8RAEQOyys+tSoS+RRdZfLpUmr1457ibDlnMz9KzsY8h9JqCkXoi4ffmvt2Vk175QVjdkrh5NP7LE8KzAjweslM1UvWviGKt5iNhhtXB9gup5Edg4uDcpYbARD0mmxGk37wMLG4Bfh61lbHxePbPpYlFwv5Nb36YmnG0T4QgclSd7b0G1aU9xJavdGlxpHv5Lk+/YvbNpn3+1C6xq3VzkeP2953+pI2+eXcLdDy5o1/ezIrticcH+xgz6b9d6JXpjw05af1Vb4SuFjNImzJKY7smzsaLNXCUB8A==
Received: from MW4PR03CA0329.namprd03.prod.outlook.com (2603:10b6:303:dd::34)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 05:01:40 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::2a) by MW4PR03CA0329.outlook.office365.com
 (2603:10b6:303:dd::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 05:01:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12 via Frontend Transport; Thu, 15 Sep 2022 05:01:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 14 Sep
 2022 22:01:24 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 14 Sep 2022 22:01:22 -0700
From:   Parav Pandit <parav@nvidia.com>
To:     <stern@rowland.harvard.edu>, <parri.andrea@gmail.com>,
        <will@kernel.org>, <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>, <j.alglave@ucl.ac.uk>,
        <luc.maranget@inria.fr>, <paulmck@kernel.org>, <akiyks@gmail.com>,
        <dlustig@nvidia.com>, <joel@joelfernandes.org>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     Parav Pandit <parav@nvidia.com>
Subject: [PATCH] locking/memory-barriers.txt: Improve documentation for writel() usage
Date:   Thu, 15 Sep 2022 08:01:06 +0300
Message-ID: <20220915050106.650813-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0d2443-77a3-4eab-1e4e-08da96d75f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfXq/eAEIJepg4Yy3nSeCxRLJGWZpdOXgfXfjPHLO11nGwFaIrUTXFXw1cY7mlvnoNset68a9RPEv6swA/FGJ/99PFshhkonCtQdBja8vNrWMXbU69OldUDNNxYUMX1ktp3To6e/Pce/iosDI/lPsNErDj1tF/mdr7cSa2O198eiPfKeWqVaIrS/lOjXMrmZ3fJTej/3U+lpmu2eO037W/quVS7ACsBJ+KPGtZj7EVaRDZRyB/81ek+CaCgBx+IZ5ZemqNOSxPsp6cV0f0tclT6LQM00WHwZxcEjOJPUAh0jLvDOd7Y0r8jW2Emz8iNOCAE4LBlbcjSjm5+QHT2/AObSd+cgByn5zw0CUv6hb/xO7kLfb7zbRa4mBmMwzu3Z1HPMrBRD/B9pCT1PuCfELcfbbIOX5pNJSI9rAFMIiggA7CxuPW6o5oyE30L/K+vvkrHTlk3iqd4zAjKY6Iw9EsDXXCAm6uFu2mlI6TW9uWlEbb9/edCcW6/HQv8g2azvmpiVr7+3o+5OCbqINJVHSqtdYF037mrmxiXET4MzwvLHxHUX0kPDB12/CqhKEzYyTVQzgJYkM66xzt5xq0X6gILgB+G7YjtqAlGVe1jJ4cxqYqdorPNUt0/AS1hVcplOowRo5LI98LVhMJE7uYIPKDkqm2VatHB6gVC/cGU6fiBJUfCIl1YYEtBc8hlNelYs8jMackgl+aZYsS8MeLU6WFHBcYVZvmxVCpjUhVtBsP8UUXSgTSHushaJKEP2+CU1hKLZC5TgGgEinB3blNdB6+UTRzAGfjphUjtAlSzt4Uo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(47076005)(2616005)(41300700001)(26005)(186003)(40460700003)(7416002)(36756003)(16526019)(82740400003)(70206006)(336012)(7636003)(83380400001)(86362001)(36860700001)(8676002)(4326008)(426003)(107886003)(2906002)(82310400005)(6666004)(316002)(110136005)(70586007)(40480700001)(478600001)(921005)(5660300002)(1076003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 05:01:38.4507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0d2443-77a3-4eab-1e4e-08da96d75f32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The cited commit [1] describes that when using writel(), explcit wmb()
is not needed. However, it should have said that dma_wmb() is not
needed.

Hence update the example to be more accurate that matches the current
implementation and document section of dma_wmb()/dma_rmb().

[1] commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 Documentation/memory-barriers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 832b5d36e279..cc3a15ac53b3 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1927,10 +1927,10 @@ There are some more advanced barrier functions:
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
      can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
-     to guarantee that the cache coherent memory writes have completed before
-     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
-     this guarantee and must not be used here.
+     a dma_wmb().  Note that, when using writel(), a prior dma_wmb() is not
+     needed to guarantee that the cache coherent memory writes have completed
+     before writing to the MMIO region.  The cheaper writel_relaxed() does not
+     provide this guarantee and must not be used here.
 
      See the subsection "Kernel I/O barrier effects" for more information on
      relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
-- 
2.26.2

