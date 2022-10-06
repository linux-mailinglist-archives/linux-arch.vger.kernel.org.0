Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED405F5FBC
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 05:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJFDp3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJFDp1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 23:45:27 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F043DBEB;
        Wed,  5 Oct 2022 20:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRTnJMiXUVYXZV7TuuqxMP0pHJMPTurie2yUhaR8mHh8ObmKbM+vDc+wSabz3Wr2KaD9uzFHgdGTSAIcm0GVfpaitRRDWLSWRMqgkd0ueRDP1xVf9/D9b1GEYpO47yyt2s49bdQPAQ20o89Sk3nd4Hf3DjuZ7VL8Nl3w3tfBsP4r+TcN8GV0c5qZKXwRMUzYtTb3EJ4qWGkG1hdZ3idfS11rKXp0Y/wZ+8z3/eCzs4xTVM3RcH62zsdHpbLfS2I/Iu5lD1LWVS4r8D4R67/Vn6XdbSUFIfHpZ8MuAHlY5b9ctCSV+w9bGdbpVa2XfFACQd/WB/TwQrugyTE4A77VfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/XRDlmYqaqGjwNuOhUP0NoAa9fXQ1QRK3+jfW/X5z8=;
 b=Qo0Ej5MyNSSPHGfd3XkfdOAXGZI5tfXyQx05vn+JFnYQxlArAupOu3wYvxGD5Z4WyroLLEHGcLCZXRDHtjJStX6lXDksSKYafxWvdh79wLFcUYb4ffv9EmR00CxNyFFvI4AHEZwynBcK5SbwS/GZC6gztHFznIBFhNIZ2IkbaCMlSmmG6LiGPxfsPH1muhjZYa8dm5KWSp3wdl5K1EcK48RaGMkusPVRxqF//61YTIKeh2TeSz/A+osMmseXkSPE4L5B3eBqpwSQw/hLKARgBG+ICgcyLu8auIVUe2vjLWSS0QHVQulfWX0E8wLfT7nbJGmuMfZPqKv0Ts2E+JK5vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/XRDlmYqaqGjwNuOhUP0NoAa9fXQ1QRK3+jfW/X5z8=;
 b=N/akIxYRPFexCNdP56jg6b44GZ6as5vzDhuNWLgQ/sVFxdiyTNgb3jY2Xisn+uzUhuJb8Ej/zt0nGDUthrGj7kS/9hp0JrnCejljlxdWQ40L9eRJL0UBD4WoFeJhpRxvQxtIHBAupu6aq+xrghbz1XdIHnOaORjfBNOjmHn6bJARUMkeWn/lyARsBLds+NT0QWOde8X1DH30saufeg5m3sHoQlaDfOxghGnyMgDH5QrQ2VeSfwHi+sPopDg1BK3Lguoc/L4QiVlYMPubD/eeDD7bjVz318FGHKmM6TlSr1OiXi4dcpi5Wb8giDXaPd0MkxeDa1/h4zKZTze9m4fVTw==
Received: from DM6PR03CA0049.namprd03.prod.outlook.com (2603:10b6:5:100::26)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 03:45:19 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::fd) by DM6PR03CA0049.outlook.office365.com
 (2603:10b6:5:100::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Thu, 6 Oct 2022 03:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 03:45:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 5 Oct 2022
 20:45:13 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 5 Oct 2022 20:45:11 -0700
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
Subject: [PATCH v3] locking/memory-barriers.txt: Improve documentation for writel() example
Date:   Thu, 6 Oct 2022 06:44:57 +0300
Message-ID: <20221006034457.165878-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: ef49ca1e-704a-4acd-91dd-08daa74d3089
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOySnkwP5DFCUTV+JPNveEz4rHEsWVSbL1aWrrn8swQUiEfzBEWPpLtRE1bEOJMyVGXSRBjCFGHcvytMkn3eDT5g3ExwogQYQM+YqRf7PVoooj33+3oc0PcjqGx2nuWWCAaP1HhgcIzC1abi/yFt0KhfE2g+8LaAPKnen4XOZUiDnWXNFaDaGfp6xxbNRk7+3RBevUAHRORYbXU7jHCLWXHHa8qLxkrzPpmWoofa9W/exe638HH8e+uvS3W79lQUny1fWoqJgDLWq+lZTTEKA6iX2ZtcuM27Enf89yxhK7aGAiYhM51z+mRHaqVUZ9HEU3tELeC6YXRePxze1VruK+KCt3q2jVtBBRCH47S2RB3ngaRx+pMxBMCJVi0t8k3+9mEfqs7ImdygeYrM7aZjMmnkhc88f8r5ppB8dUqKJa/agqvsB+41JBF4LsUUYQLxeO1+m42vyRxZ/AefnNk42f/jefZZCdA/F1YijwcRTm5s4tPOua2f99JkMNcG3iYKWS4/Jm7xYDi2olz/AYLj6ufcejh2hYUXAvOvaaMN6PEsG8b3zkYv1oHe5Wu/9kqS5Mhba08M+rzGgl5MF13dotr3jZC8/kHqxHTCvzM0ARuYKwefM4rLM5pJexjGNYMUGIQbFHVbhUAbfxuJ7RG5s263ab3Vatir116NsxZj8W84v4erttDfk5We1XhdAj5MglCv8MGQm3hrjRMtpW+RBxDXe5Gw3HzxMI/ey6E1rHIwFjjjuyyva35hDaWVjLpftx6XTzUCh6Mroq4jC5q4PX6BCgEbLRCLDzi+voloHtA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(41300700001)(7416002)(36756003)(26005)(478600001)(82740400003)(6666004)(107886003)(40480700001)(82310400005)(8936002)(5660300002)(40460700003)(336012)(86362001)(426003)(921005)(356005)(47076005)(1076003)(186003)(2616005)(16526019)(36860700001)(83380400001)(7636003)(316002)(110136005)(70206006)(4326008)(8676002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 03:45:19.3270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef49ca1e-704a-4acd-91dd-08daa74d3089
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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
 Documentation/memory-barriers.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 832b5d36e279..8952fd86c6e6 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1927,10 +1927,11 @@ There are some more advanced barrier functions:
      before we read the data from the descriptor, and the dma_wmb() allows
      us to guarantee the data is written to the descriptor before the device
      can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
-     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
+     a dma_wmb().  Note that, when using writel(), a prior barrier is not needed
      to guarantee that the cache coherent memory writes have completed before
      writing to the MMIO region.  The cheaper writel_relaxed() does not provide
-     this guarantee and must not be used here.
+     this guarantee and must not be used here. Hence, writeX() is always
+     preferred.
 
      See the subsection "Kernel I/O barrier effects" for more information on
      relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
-- 
2.26.2

