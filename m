Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CF7B00F1
	for <lists+linux-arch@lfdr.de>; Wed, 27 Sep 2023 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjI0Jue (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Sep 2023 05:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjI0Jue (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Sep 2023 05:50:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1121AE;
        Wed, 27 Sep 2023 02:50:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIPQ/7x0jHokAt0F1xeeAEzyBqiGQLFAwnonjSlAFA76eVhOAj+uWssArci5hjiIjh8Tz5WShW1fjJ0p+8nretNIUYA7E+tDYS4HnIOEDUxiPHYauKbjdkFiOHhP8VDx9EhDTJk22BDBSNdNAOGQXT/1cUd5fKQgHho2NlqWmil1+eBIfH2QfnMRCBNW8tYzi8Z7aqcy+fkn8E98KaNmNcrKaJs86SZ5+QUOyiGx2SAFdYXoeGPAKf318wWASOaxL1SDO1vg0WCU/0Mz4uqH3XMQDibRgEQb3TRke1yzxXefHkmd3ek1NX3iSr7pUOAW5Uowyd6aHx8Vzc9IDRsnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a9/12WgCgZMTWXMzVNEZXcO1CrVBtcJsx8yF/T3UpA=;
 b=lP7Q13zdqcL2IWTl+TsO8C8goutCR5vHL94zO29xy/UOowJDO7GJqr5ZEIer5A+Uea+FeeDgzSN1SwuPPf4FBN6wmIv65Z6HqvG4Wb+h4qiJUeGEKeljmPJY6eZb5P4NO5Cd9TjyvyVHLUP/9BCfVz2xBpcNPlXx/uMwUIF4ibI0lkAKslyKgxgx6FMZ80HZoaNLIP1Q5+51SFuSS733l0sbpFGyM5RlkV/TrNMMl4LYhOe1jcH9XAq5REoymWPaQDrQ9Z2oMcNUpKFr3GAiVcZvhg8OVuDVfcXq9gzx60fAtOTd0AP2lrutUZSsVPQTREioHTm0UjTOcl5hvi3ULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a9/12WgCgZMTWXMzVNEZXcO1CrVBtcJsx8yF/T3UpA=;
 b=UQdLHMmanbNFLFmggey3pyKi0+B+MUIjhFr8FM9N8hgoVKsIdRFbTT3qwjSGkzihoM1alHsSn+oIx4VoIURpI+LaHoaRmpVv1jw46RAS0BHZKfzMpmHR6oULiNrjWlFSoXWsT3R5TL3+DRg2mfcQhcauRA8gfE3eVHDyuNmaU+JmTWAc0Z7Fzx1U08XeA2gWCuWfy6mYh2QL5y8aeZR1zxdfTe0qLL7TK4snKqDDJBugyEQxbZX8oL0BrJzko5tsgtTCwPhNeM/VUQgLHPrMQR/K67OJPUP4/UvYHt+2Icb181A0MAuwM+S8B+kFRFVYtXDjksPx/srd7DW1T7pP9g==
Received: from MW4PR04CA0218.namprd04.prod.outlook.com (2603:10b6:303:87::13)
 by BL3PR08MB7300.namprd08.prod.outlook.com (2603:10b6:208:353::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.31; Wed, 27 Sep
 2023 09:50:26 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::6d) by MW4PR04CA0218.outlook.office365.com
 (2603:10b6:303:87::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 09:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:50:25 +0000
Received: from BOW17EX19B.micron.com (137.201.21.219) by
 BOW36EX1902.micron.com (137.201.85.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Wed, 27 Sep 2023 03:50:23 -0600
Received: from VENKATARAVI-LAP.micron.com (10.70.32.235) by
 RestrictedRelay17EX19B.micron.com (137.201.21.219) with Microsoft SMTP Server
 id 15.2.1258.12 via Frontend Transport; Wed, 27 Sep 2023 03:50:17 -0600
From:   Ravi Jonnalagadda <ravis.opensrc@micron.com>
To:     <linux-mm@vger.kernel.org>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dietmar.eggemann@arm.com>, <vincent.guittot@linaro.org>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <gregory.price@memverge.com>,
        <ying.huang@intel.com>, <jgroves@micron.com>,
        <ravis.opensrc@micron.com>, <sthanneeru@micron.com>,
        <emirakhur@micron.com>, <vtanna@micron.com>
Subject: [RFC PATCH 0/2] mm: mempolicy: Multi-tier interleaving
Date:   Wed, 27 Sep 2023 15:20:00 +0530
Message-ID: <20230927095002.10245-1-ravis.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|BL3PR08MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4514ed98-6195-47e8-228f-08dbbf3f2cad
X-EXT-ByPass: 1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jkJACQMgCBEtHMNXUL+bWBnflAhl+ptNnYlsuQ+uaZ264LHa2n4vVWf9X8iozlL9rFaU6BQhdQnomcYYcNniP3wCWQB7Xvap6zTovfbbvp9Ul5wTF0R1Ts98ErRMKLlYobZNerADpBouhvVWtbmy2mQ4DlD4bbJlle8NxzvL1QTpTHLWTulWiVqtd6rfe+I8gx5uczUY7ZSipfzaLnyYIGS2E9iJ5R2GpbpiFnED4qZHhuNEPl6WndH89xNjIYugPGYc37hA0OMofCAeH6InpqNeYD6DQB9YfdZIjlUd/WnW8m32aXeEM53NMV6ZHYhN6cRCuCeb7LtQVzIfB5XXLauNnNg9iIr9jDyMpGNK2q/cA7e95klk+z3ryol1dEUtZ2iErQnsPfp30Dab9ZM5k2MkqDwRRb1b2aM5dkfp7xyOr/em26rqUlaXI5YmRbaJKQRTkH8j0ZGIJNRq2n35g5GanyzGEZ4BBwW/rrRNZ2kz1P0/SKYDEle5FacOHCuGJD3ENxxNE7w/UkUfKgucXwB5Oz83A99Z4yzw47RxqcaumQqq8Oc/nvqOYspRCwXZlHrgVGDWrayHnhJPplUKSu1QGaukKWi5nHfhN8sr7l5LaMApXPGdcnBObVYiF1PXmgLNZ9U+JIAqGPdMyZAgCNb10k98a1fXmeSRAcBYvs68x68M5dYkwvnGv0Q/H4uapI0EKhJYd/A0gLPcOyOsH+QSFLb8mTGgyBpQAvfyLbU=
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(426003)(6666004)(7696005)(70586007)(40460700003)(5660300002)(36756003)(107886003)(7636003)(2616005)(41300700001)(26005)(336012)(1076003)(356005)(478600001)(70206006)(54906003)(316002)(110136005)(86362001)(82740400003)(7416002)(966005)(2906002)(83380400001)(47076005)(4326008)(8936002)(8676002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:50:25.5352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4514ed98-6195-47e8-228f-08dbbf3f2cad
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR08MB7300
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ravi Shankar <ravis.opensrc@micron.com>

Hello,

The current interleave policy operates by interleaving page requests
among nodes defined in the memory policy. To accommodate the
introduction of memory tiers for various memory types (e.g., DDR, CXL,
HBM, PMEM, etc.), a mechanism is needed for interleaving page requests
across these memory types or tiers.

This can be achieved by implementing an interleaving method that
considers the tier weights.
The tier weight will determine the proportion of nodes to select from
those specified in the memory policy.
A tier weight can be assigned to each memory type within the system.

Hasan Al Maruf had put forth a proposal for interleaving between two
tiers, namely the top tier and the low tier. However, this patch was
not adopted due to constraints on the number of available tiers.

https://lore.kernel.org/linux-mm/YqD0%2FtzFwXvJ1gK6@cmpxchg.org/T/

New proposed changes:

1. Introducea sysfs entry to allow setting the interleave weight for each
memory tier.
2. Each tier with a default weight of 1, indicating a standard 1:1
proportion.
3. Distribute the weight of that tier in a uniform manner across all nodes.
4. Modifications to the existing interleaving algorithm to support the
implementation of multi-tier interleaving based on tier-weights.

This is inline with Huang, Ying's presentation in lpc22, 16th slide in
https://lpc.events/event/16/contributions/1209/attachments/1042/1995/\
Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf

Observed a significant increase (165%) in bandwidth utilization
with the newly proposed multi-tier interleaving compared to the
traditional 1:1 interleaving approach between DDR and CXL tier nodes,
where 85% of the bandwidth is allocated to DDR tier and 15% to CXL
tier with MLC -w2 option.

Usage Example:

1. Set weights for DDR (tier4) and CXL(teir22) tiers.
echo 85 > /sys/devices/virtual/memory_tiering/memory_tier4/interleave_weight
echo 15 > /sys/devices/virtual/memory_tiering/memory_tier22/interleave_weight

2. Interleave between DRR(tier4, node-0) and CXL (tier22, node-1) using numactl
numactl -i0,1 mlc --loaded_latency W2

Srinivasulu Thanneeru (2):
  memory tier: Introduce sysfs for tier interleave weights.
  mm: mempolicy: Interleave policy for tiered memory nodes

 include/linux/memory-tiers.h |  27 ++++++++-
 include/linux/sched.h        |   2 +
 mm/memory-tiers.c            |  67 +++++++++++++++-------
 mm/mempolicy.c               | 107 +++++++++++++++++++++++++++++++++--
 4 files changed, 174 insertions(+), 29 deletions(-)

-- 
2.39.3

