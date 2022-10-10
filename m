Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF45F9C7A
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 12:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiJJKOD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiJJKOB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 06:14:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D1F40545;
        Mon, 10 Oct 2022 03:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyVd0FyJLy/qwjQwdrio0XMLoWHUlJG6unp5Il7TG2wAJ3QFRL7EGjR+fCCgWlU1Hbli03GhpIx74X5uNtjUpA2nBpJcXcIx8W29vqKrtErYIznvJGFaJTzkga/hOcCcNh1SvH974M2AN6h+BhtybjGGRWCoDPkhM2egQG7qrpLaqdLFUkc4x1hs0SbFcgGNvNlaUdJPyaLOUHGWWEJ93WoSAckdFqJH9iJ2sjWiGpzENlglwwE7Gp9aUt4pocB9930qGikQTptpwScolzhQCpCNAfzXCOiYFs4lrSYWSyv8UnvluR1Tp1F+yt6NItHxDVLozhA5Zid0yWHgaWmkdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cfw/kanuJFjErKmiBGqrYlFeRvHr5l6UCSW1OVoyOzU=;
 b=TH1V6s4IEoaCKwfsW/5Wkh2mG9rmgY1ZMJEm0qj4Boh8tpxTsz3G41pieGEFLIYetkPlLtbJBv9Yad99kAACRTLvIyvJYIOc5xCQ7kttcvZ39IM+k8oi0xBhxlvVmawmFuNIS+WbcqbTi33/PANWRRa1sW8JqVw6FWR1te3fSZLPgVP4rpO2vh0HbpuEOTZCwtaHHTyT32GATN4ZdUL1neFGUmLjwlnWQAaWz+z9l66iEuvGm+Jelwci8Y3Qgnk+3VJjA/dqBdWP1Yn46KDC6ncCq/424gokIn0lGkDoPZjfeW+nIaOYPctsXUKe8wvbw/JOpYho7/CIaaH63XW5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cfw/kanuJFjErKmiBGqrYlFeRvHr5l6UCSW1OVoyOzU=;
 b=fm7xOhdmyIO+SgtbZTaVXfrSmMr8EQidcKdkhUmULDhQeIYyK5F9vvzxKpJNL/cHod4m+PrjVi0lUsI6ABjDVFNw8b9jxIEw3EkmMpRR67BhBhKPdRGEM9BFnQky3AylVTv8Nt2MWjLeAxk38SIVUXRDnITPrFvqKhX370cbch/bms4VlHLGFYH8NpYiYM/h9staYe5mPnMjGMHMHsqw23sN1FwYP3zfSH53aZLm3LgFH+SxycwOyncaHMeSqsf4lObQhKrt2eus68NWdtZavZtt6Uct3pAVQiq81HsCIym1vZ72lASAPiYlmPXkBjKMZhAw/vJOggsnMAGSNpdwXw==
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 10:13:59 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8::4) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Mon, 10 Oct 2022 10:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 10:13:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 03:13:45 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 10 Oct 2022 03:13:43 -0700
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
Subject: [PATCH v4] locking/memory-barriers.txt: Improve documentation for writel() example
Date:   Mon, 10 Oct 2022 13:13:31 +0300
Message-ID: <20221010101331.29942-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ed858b-343e-4b62-c30d-08daaaa825d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTwzPecCBjG202eu06DrcACGV2+N+UTk4dURy+gglGqYGJIsRk5j/hGW51jLTsngEHC3YoSWm1CD8Ii7Bk86B7N6VeufkzeDyvF9Pow/9oB5WBnjWdgLrFgbUykGuem7WeQu1FRX1Vi7PD4XeCnEM+5BXqDrowLLhn7iYmmIe4uBwAKS0W5MKZ09h8pinnXBV3Z1ivj3gfvUv+Jkq5/H/QidRdmdDvLFL9xB+XBceXgPpA140GkIG6TSHTeNVK8J1XSPSDuBzAZ5/ohlmdoryJq/JmGFXNl9HffK2puCOpZLqsW7zajQLo++zIw0nM5n0LWZnd9mjIMTZJXY01/kg/ShxISa7IIPtpqNIF7firOkqeJiAMlb/lYtR+wOQ5DqL5B4leKNX8sLR2v17lHXS04YC1hjcNx5UbCST2Xoyqw87RjzJ1ShXbIARL1GATRUf0mw8UHnXWK6vp4yGckXPBV/QitJSpME+ujjbANsSB1+rPuiMalMrT35p6kzDi++w98JI4zuh0pON2lXneZl2MLImLG/gWOCq/FR1w5OK6ABIvQPplCTbsDt///C/1DXmzrfD2Wth3ydz9/YZIRiE7NaEHfHFCHT3FmtlriDMG58KwMuOxemmsxhihwV7eHRCs9H2RgAbrNS8MQuc5e7O4S29KIDT5gvFgit48rWP5IgGcbiudKSyUFEVIyMXzMV5/q0tneKZGUetxUG/7s1GJPsr/7prMTX9uWNzEnvKpdPsANAuJ1LQsJ8Hfq/RGaucA9GKsXJcisPKt6mNZNdBl3JnO3G8RR0W1z5KYpA4kY=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(110136005)(86362001)(82740400003)(7416002)(5660300002)(36860700001)(47076005)(426003)(1076003)(16526019)(336012)(186003)(921005)(7636003)(2616005)(356005)(83380400001)(8936002)(26005)(107886003)(40460700003)(478600001)(6666004)(8676002)(70586007)(70206006)(316002)(82310400005)(2906002)(41300700001)(4326008)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 10:13:59.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ed858b-343e-4b62-c30d-08daaaa825d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
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
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 832b5d36e279..4d24d39f5e42 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1927,7 +1927,7 @@ There are some more advanced barrier functions:
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
      can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
+     a dma_wmb().  Note that, when using writel(), a prior barrier is not needed
      to guarantee that the cache coherent memory writes have completed before
      writing to the MMIO region.  The cheaper writel_relaxed() does not provide
      this guarantee and must not be used here.
-- 
2.26.2

