Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D809D3C41C4
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 05:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhGLD3E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Jul 2021 23:29:04 -0400
Received: from mail-mw2nam12on2112.outbound.protection.outlook.com ([40.107.244.112]:5176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232893AbhGLD3B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Jul 2021 23:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StNtfC+OtBdhKse9MOs+CgMzDdhZZoesmHNxsiH6/MlyleaAwH7FMzxpTZMXBvuQzYW0co18tohf5vhNDWkzy4ZQn7WomC1/w92ZOw6maKr1IHLkD1LlwX0wdM8ZtUerxZ/Jyc7hZaQXDlizmb7UD/Gir1ZT/NSi6D8b2WE8lEdALj1X3D3OZr7cSwpMLu7wx96lgxxNb0HH1KHASkvEodnr+NBLcvvbOEuLBStJUKL5y8QTfdvc/gZbkGpuJDpyvTsoddHXtmqJl02+SnItrSTymE0oMvXik4fDD/s3u45IbO+52ZADK39g8USKcrDbj0bHTSqp/qlocAcuIZrPpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhRD26byiXrsmxJscsWwIu6igBclhPie3Bd/U4vqDkA=;
 b=Q7C88+/LKfBBepu7Lh7q0FixY85VZ6qAt1Xrr58vBE6LPEc+2vQcIle478bFU7hmb4Hfe5sy3D1igQq6t5xl+rEHkTU6B1PtLJ30XFkvbUA8U/6yP181eYvV+V45mHZK0D6Vr1+/wRZfBTZki/zP9YLvUFbMGY2yBpfBHUnjfmvQy46kSusMLxjJymgkutEMxwpp7LVK0VqI2bWMTbI+An+kB1BsiwsTKJ1sJs3CoIQYZVKV3WEefsRxdGL5lbg+PTUfOa/LCv7g5yYHo9PguWfnjU4wUk1wif5RR+GxeSy4cl+pR+hwg12vJhbAXnOldVRSZiaVH8meXoryTOtp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhRD26byiXrsmxJscsWwIu6igBclhPie3Bd/U4vqDkA=;
 b=YkqLI6jv5ksMUEYcBDdip4XuNEVmAziHe+vUCQcMRtjPtwJGig6xZ2Sh02lHZTR/Wod+J+rZTRMuWFrHsm8MI5G5K4f7zwZWAuuitnBH6pFiNu03AfEh3iwFlrgdhmuSoE9YR0huVPtdjz+SAgYnR1YF0I8q/IxsLtWKrAaSKGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1402.namprd21.prod.outlook.com (2603:10b6:5:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.8; Mon, 12 Jul
 2021 03:26:12 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%7]) with mapi id 15.20.4352.007; Mon, 12 Jul 2021
 03:26:12 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH 0/3] Additional refactoring of Hyper-V arch specific code
Date:   Sun, 11 Jul 2021 20:25:13 -0700
Message-Id: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.16) by MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Mon, 12 Jul 2021 03:26:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 848e63a0-b228-4720-5443-08d944e4cc0c
X-MS-TrafficTypeDiagnostic: DM6PR21MB1402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB1402C45F2184685B1EE937A1D7159@DM6PR21MB1402.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/wspHztl1Pw3Zb1vIO+IiY/RlF9R9dBKC9YJZKx2nIDqgdgPUtkhSmWfFPY+xa+kMaD+3vhHBXc9jfGJxngnFCs0CnOJgy2oMft7o8hyCljd7IwtsNFKVZFE9vhIQn2SIexGKhlTZzeVSYtFXzV+SxdNG6MeknXQ6Fg9zQDiHiUAr9YojjNeLM5fvAZodBRUArGezTId+h9VvdoMnsny1tMD/SgG5MOwVXXNfGP96IkQu2tig1tS+xxTmpPqEG9sl0Y168X32ay/wVx+AXwy2HMTsUuoKKmP8jlsHLRWgGGEJsUrsRa0gkBQaIwfT5LSeS2KuzOQc/nwM65aSMMjaVuEVWcTaxvEks5YjE3LIAQH3VnBAfAVvpORLC8HFPBBusziDXg1PTEzPkD2W9sKQoqhDhZdOUKlYVYWdd9fqMGMoI0AEFronxGMzAZ59zZjsYzSIYm2DPWfRRSvsr+6aa3J0kDOzzkiMk95hl8kDXsJvi4PPnE67lJlcyGMwQTxIUWGEaQqBKd61K2UoBLXkhOb2lmqo/xRY2NaO3G29yD9BkZK1E8pfX8sGrKX1fthgpkzagPuElyVKiej59PJ9dcbP01XRX69U77pMa5bDVH0zWMfch//qTFzh2Y4ZREUwCZ+2mI53SAkruJaSSGDdbzZJjFCD/7jqHHe+sW1CWIujzx9mIC3XSLO66xpabxDP6OjjwtuZOaQC+lSmi8QuVx5DXh/o245fh27r3QIHc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(956004)(8936002)(7696005)(66946007)(2616005)(316002)(186003)(38100700002)(26005)(36756003)(38350700002)(83380400001)(478600001)(52116002)(8676002)(86362001)(7416002)(6486002)(66556008)(4326008)(82960400001)(82950400001)(921005)(5660300002)(66476007)(2906002)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7aLMdUN4QHAqgGEnJ36s7j/nYvge/6kBDf0wYMHGqKER+er+5lTEX85aTh7K?=
 =?us-ascii?Q?CxFURm/iEkbwtEEJVKvEvViv+i5509NOUnfpFZgyWsz+TxxSxr4lE0OtqglV?=
 =?us-ascii?Q?xpvR9DEz5RxzzEMAVZFtMZd0o33x6dzrdsGkq6y72lk673847he2A+eXRKAx?=
 =?us-ascii?Q?b/gVukjyHDap7Ewh3+NsuHBpP5cB2d6v4f58r/tclf2gqr1DhqxpDPLT7+w9?=
 =?us-ascii?Q?sDgqohD1sA88FJlCNo8bOsvkz4UnazLx9QxKWphc6JJmBdGiCgLCQ8N3xY8n?=
 =?us-ascii?Q?uKIgTE8yANFQ52X1bNka59mmZZmwr7rkIgiFuwQpqBWx0K8LOV3QzZo1m/Ym?=
 =?us-ascii?Q?+5BS8HaA3FBNvaQ5NYQniYF4QtIrDxXrYZQaTI7xVaK+q25OX8qiOeZuCyyW?=
 =?us-ascii?Q?9R8oyH30uaoT6u42ui7NN61eXTahtJBMDEidOURVfXyt37DT1robZCYCRsA1?=
 =?us-ascii?Q?QwwDFMZAe0fEccJPg/aHzuBNA+Tkb3iCUCUWlR0ZdNJFFda/XzZmIFGYQc4N?=
 =?us-ascii?Q?Lf/4+FVhTMLzan9hp7dAHnitZcwOGX1YujESb/YCbxTCruMx070ZY3SM0xCM?=
 =?us-ascii?Q?zxVBuhYBsEQZAinbca24lSkoKuE3FOjNNjRwniGtOyFqtrINaQvJaz+2oQLY?=
 =?us-ascii?Q?1/k8g4M3JrKQlfBeusYl/cOusro/6iDl2GxwQcA2GwSP1xhX6WQNFX0/HM2d?=
 =?us-ascii?Q?tKIZ/QX3tCN1r7bVMoZiLEZ03LU/xxkbu0/bJnTo9guzdZyuFEJZ9JU/7UPg?=
 =?us-ascii?Q?3QboVe/BftufNV4hwZ/Np4aJgd1POFGamwubAC9F+jG6Szcp2BPOYB7hU863?=
 =?us-ascii?Q?x/piW1jDadJBsFEqt+xoqdigEBqJZ0/gxMUef5O56hPqP7yBywikUcgXo1E/?=
 =?us-ascii?Q?WOm5PQIIqxL0effL2bJAE0g0i92J6xGXOqvyxVbZdcRDpRQ0iTsygoaOdDow?=
 =?us-ascii?Q?wtWxHNkiXbg4aVo1StxOBv5moQ2u3OpxPFxgHcASexfDtuCBkc3J9MdkKTHm?=
 =?us-ascii?Q?q/h/YMX4DRxGo0sH/F/lDhajesh00xD1aOylfi9Uw7pBZz8YSzBWYcx5oZhr?=
 =?us-ascii?Q?lrmQMXspKB0br49Y7Bm0FVZZLv2HO/uHM7FZ9y4hdHoqFbTWK5hETpshvi85?=
 =?us-ascii?Q?FmMa2wlrHoPF+2b4sMduTn2dIXAL80rcEOmL70HiDHmjs/+UaS/raoxd+ESt?=
 =?us-ascii?Q?0626QkirrCGWcBPtWvR0S4UCUclU8dNQ50nzwPy2QaV5RCLq9KjtkoEey98a?=
 =?us-ascii?Q?g7CJZNa+EiBxvAPTDNR/9vFg+r9aVDYCqUgtnbcL5hVKhIEjAaYsK2LSZ0Ob?=
 =?us-ascii?Q?HF0iXqEPOj0Vuz3U7eOgsYZU?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848e63a0-b228-4720-5443-08d944e4cc0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 03:26:11.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BuldUT/WG8ERdF83aDRWB641ofTerM2cIMLP9lSgFO+ruX+TY+1HEJE/sw3OKgcKkLO4W6Ax3kqqYK6S0xfHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1402
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch set moves additional Hyper-V code under arch/x86 into
arch-neutral hv_common.c where it can be shared by x86 and
and ARM64 implementations.  The move reduces the overall lines
of code across both architectures, and removes code under
arch/ that isn't really architecture-specific.

The code is moved into hv_common.c because it must be
built-in to the kernel image, and not be part of a module.

No functional changes are intended.
Michael Kelley (3):
  Drivers: hv: Make portions of Hyper-V init code be arch neutral
  Drivers: hv: Add arch independent default functions for some Hyper-V
    handlers
  Drivers: hv: Move Hyper-V misc functionality to arch-neutral code

 arch/x86/hyperv/hv_init.c       | 101 +++-----------------
 arch/x86/include/asm/mshyperv.h |   4 -
 arch/x86/kernel/cpu/mshyperv.c  |  24 -----
 drivers/hv/hv_common.c          | 198 ++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  10 ++
 5 files changed, 219 insertions(+), 118 deletions(-)

-- 
1.8.3.1

