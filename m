Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C5E3C4152
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 04:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhGLCxS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Jul 2021 22:53:18 -0400
Received: from mail-bn8nam11on2123.outbound.protection.outlook.com ([40.107.236.123]:26240
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229660AbhGLCxR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Jul 2021 22:53:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdgJRfdAvmA4o18W2z3K85D3BJ2g+39zaLJ7nU9pHIfsLVzFjKghiaKW88E5em5MTmdn0ds7W/jZWsA6O023F62YlFvERxytuGAIrfaB38Kn2BUx1ygDfkiqruHLxtdnfa96j/uFrFqH637RO8VuFw6Jgxtd1wodXTzDU3GMsTIzd7z9N6mAZ5AhK549vpC0hr2ooRL/Ew0zyf7JlGsK6SafDDhIsyCn6XED0DC+JUIpQ3WKjDkJKA+Oyw3II7ntGs5BzkXhgfSBVwLMFcJz92iqKjCWg6uhqqgIFQfsbN2LGk6mbVn+viHqbry2HhtmwQ7Dm77rNUfr9BcRMoIXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z4EEWGADGI6dYfRjmYx9uPSd8g4NDr4E3gBaXv2Bx8=;
 b=SCGS6n+TXzhU3HrhQf6NDMZnJyzKHIxPUv4fOXUycgRip504PHvZfx6Br4uIl+b9e2BqobYsoDvtaQvmnaC9GitZR+x2gVjDls/A6Zt5F62dWAfBYa55Ym1+AvZoQ+HjmIV0UabTvhyV8qMmeavIXr3+lUWKBynv8KmtElhgFBvto7rllOCcmYQtqSggP09NaZ3bcbfdcdKMKJRN+kYC9deagSjBuIW+5dmyxTsiIFcUH/l10tqkbf2l3tlLtF2gVOom5V2PiF+A+UXvOKb9wL4mnzgz5Gd1q1SqQvw/Ar4/0ujIBi9if606FrISYWDmocxK0X6/RXhAOLn8kRf7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2z4EEWGADGI6dYfRjmYx9uPSd8g4NDr4E3gBaXv2Bx8=;
 b=iwfe0Y3IXYvpsHSo0UZJOUXPo+2J+WGfTxQGB3B8ejvA7BoaBSe03eOHHyq4Nc18R+7FZLYSICSktAb8S5ZMu2606WxS3WpEDzSsQlctc7O/mnIai7ZzcRVigDkNRKlgQX1S+XdLM2HPZIcg34t9L/Ln7W8/EAA/5yuURkp9iFg=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1209.namprd21.prod.outlook.com (2603:10b6:5:166::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.12; Mon, 12 Jul
 2021 02:50:27 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%7]) with mapi id 15.20.4352.007; Mon, 12 Jul 2021
 02:50:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/1] asm-generic/hyperv: Add missing #include of nmi.h
Date:   Sun, 11 Jul 2021 19:50:04 -0700
Message-Id: <1626058204-2106-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MWHPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:300:4b::12) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MWHPR02CA0002.namprd02.prod.outlook.com (2603:10b6:300:4b::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Mon, 12 Jul 2021 02:50:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cc52c5e-74c3-4b9f-a5ec-08d944dfcd9e
X-MS-TrafficTypeDiagnostic: DM6PR21MB1209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB1209F87BC1E6B0DED5CD1642D7159@DM6PR21MB1209.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TA35/gq8ZQ38n+4LNGkPubiQgUwd0tw8W0PoO4ZOjXbKCRbqMWyNKAWEq66wu2xjxeq4tVhLwxftMDIIDB6VsAjoBmONUmon/w1ByVCwqE6Z2phJdRWdFAqDwTO5KFaiOqHmf3yD9IkijrslKvJRt6k9NhelsUjQDkauxojKWx31+GaMy4PDT4/pMhxNQTIwqomlvBGcg4kC3jacOB4ayt6YQwWjfPvkmgfbrMvqIt64a9MfQTbxQYVYgaIIGUye6vuEqKPvPc/MptHKZutnv70EVySE8meTpIkUN+pQxyxSGpu/KdPr1JN2AN9+GLMBfv8brk71wsICwAhA1X0QGnnnixBRM9NE4FfXw21N0B1tKPvco46gw+VtS9aRqrI7xymKqn/Rq1UPx/JK8FqAh0g329rq3ObRo8/oVO0qmBDMWff71uDwskEuMOQ6MjaUx8I5jcM+84jH/QoBBrRWjmq7o5uJzQp6TDD8Dyykt2OlyMoYpvh/tf+BxIrN+z3537rxO8ZwC0T7o3BOhDJ9sS9B8CiQZ173OtpbUTByaFsRBOlo1voTZ8FRjs7RyZXR5gnmJ/BzyE5+DWR+r6rBuw+MfsBSPB8JwUpm2JV95hL2xKptmAFFufMl/99uxlRcNQCULWrnum4294DUZQ4dfTVdZsGBG0JW6m15OS0noa6kjcvkq+db98CsmKwC6Y0himWJ1IedSa9NCsroOYaklSHFx0bCd1yPdD1m51SjhKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(478600001)(2616005)(2906002)(10290500003)(38350700002)(6486002)(6666004)(8936002)(66556008)(5660300002)(66476007)(66946007)(956004)(316002)(7696005)(186003)(82960400001)(86362001)(4744005)(26005)(38100700002)(82950400001)(52116002)(8676002)(107886003)(36756003)(4326008)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Fe22hKIUiNAuQfdrCr2QxHni+3DDqEcf2HhpwT8Od/5r1pm2wVrSUbfKP1i?=
 =?us-ascii?Q?NPlL+NsKRnXrGABstuBt1aR62c1Uhq/UdO7LHxKItHvVPP5oIf9mYCqHe/1k?=
 =?us-ascii?Q?Y8m6hXAzvrifUkeDYuo01r3AlNHx9gRZEsttbo07V01gsI8epHfjbtMlCDRm?=
 =?us-ascii?Q?ptsX9fj72KKfXDe5jVhZjllQngOJVJtveShN1PgmjcYQIrXUn+bfrDO/B7Ci?=
 =?us-ascii?Q?9TNSZ10gjlZlwB6ev7mgXm4xm3Y3PfcwiZROB1NELNEY4Goo9QsvDRioJeqI?=
 =?us-ascii?Q?0l1TYHlJHsjfyS2wx4fqbeRw0551ZV3X3yaV+ycGSrL/0VHkwAz50nmHpg8P?=
 =?us-ascii?Q?xQpESNTuFu0+OjY+LY6/X7ViFvH/JDbpXW/pZc5hyqM+huCXT9bxNCs24w+n?=
 =?us-ascii?Q?dGC2dkytnyWTOnbMyRKC3POl3k1JfChEI7/+I1ChWKQqCeArKGYoMEHTGtvC?=
 =?us-ascii?Q?2IsMSFRm2uUEZxFZ1/9Vnk8jqTquW75TrT0NG9AcP5msb2X8kWbDbOX9SQAP?=
 =?us-ascii?Q?td8kKplAw9cGTC7xbcObrpwXZUis6ftCH640dnMFMjuIIv3ZB7WLCMD34iFs?=
 =?us-ascii?Q?/ndrx/IK1X90uZCxu6R8XzrYqGfGpKeTnefTia57qGRaaHTu45BAXFIdG3JS?=
 =?us-ascii?Q?qJRb18gcVdX4T0LDN/EMWM2RQBgH9A5syBb5s4aDy6fqCU5kL3KiHie31Np4?=
 =?us-ascii?Q?5HHAzTtzuEMqGSaSustZZRCzv9ZqxQ4tyOQFwEMT6Pof4M2RtAWnADGdQhVI?=
 =?us-ascii?Q?mMD+8furpJi4Vi77zYVEA00i9bwQs2uHKiceZ2wh5uSNDVn1Q3JMEdH38+do?=
 =?us-ascii?Q?/QB6VEUwvxwv71TvMtOff5oxFOLoleH+q4EIw3paaBqhgdtRgv9Mbt3dT9w6?=
 =?us-ascii?Q?2Gd2jfQllv2iHUEZ4sQd4Y35kgyv+B+GE38gSLZgPKB7I1yTmcw8/R4JJ8Ew?=
 =?us-ascii?Q?a1xSWl3QZka15/WIXup7PZo5frKq8lGQRH7hgb8N6vY/DHK+wUp9jVMqiN/R?=
 =?us-ascii?Q?5We2bkj5U6bB61MaCJeJacYqwto66/EntM4o+nc/z1Mz9gwzKNOtKbi+V4Xe?=
 =?us-ascii?Q?my7F15AJXkgXAnbz8TVLjIpntPtlwQ3wCC6t3tDVPRDwzTrpJiX2OER9xwUZ?=
 =?us-ascii?Q?xUeMErspiM6ZNH0JB5QHcn5thmmOtfUw1wntEMgs88VyUUaRboQnhbrKrAWg?=
 =?us-ascii?Q?xA7mzD9TAVRt5Z9W3hkWvtaTV9ZZu33eCBVhVy3YzmoR31AdQxM6SqAjK5PC?=
 =?us-ascii?Q?FGAp/sBxaAfK5+RegkJ6sRW391GWPvcp16K6BjedaXop4qMN7vuGnBBBYZaj?=
 =?us-ascii?Q?z33b0rip969T5v34V/xhU7uJ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc52c5e-74c3-4b9f-a5ec-08d944dfcd9e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 02:50:26.9609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wx0SlDENkhN7bKE34wmFFYCtMs+Y0RHe0mlzJ7FwgM9qQiTMhRPe/yiV/1B/0SpY0pJmyfytlfYcC6OvVQmvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1209
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The recent move of hv_do_rep_hypercall() to this file adds
a reference to touch_nmi_watchdog(). Its function definition
is included indirectly when compiled on x86, but not when
compiled on ARM64. So add the explicit #include.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 include/asm-generic/mshyperv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 2a187fe..60cdff3 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -22,6 +22,7 @@
 #include <linux/atomic.h>
 #include <linux/bitops.h>
 #include <linux/cpumask.h>
+#include <linux/nmi.h>
 #include <asm/ptrace.h>
 #include <asm/hyperv-tlfs.h>
 
-- 
1.8.3.1

