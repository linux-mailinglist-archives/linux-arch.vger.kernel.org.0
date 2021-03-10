Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF70B33471C
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 19:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCJSsm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 13:48:42 -0500
Received: from mail-mw2nam12on2091.outbound.protection.outlook.com ([40.107.244.91]:23392
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231858AbhCJSsf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 13:48:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rjt0U/xcXOgwf8nx2d8xIw8s0NsVAVE6CPF5wXiLe8zV18gdq9ZBs9zTRQDUYQpYrZ++5hzr4TmewRrtc6BGruwFDHzqFn1ge3THuLWkMeGJ7gEfCeEGc0SKhqmjx/CEzQxNS0bTW44WDXOeVYAzkJB6htrKNyeUCdhZaoZy25y6S61YlvJs+kL1AvaXojmuCqmyKkC1Bi51iQrr7UCY8jfcgYHkWpuQl3QJ45g8FCDkUNoxtPJpH009xyDoQDIyX5R5LJJ/BSJwj2X/bieOOaPz8Ix0RoNeVw3IPlqnVcYI5pD3N/zVAIsx1QAk9wibJYlD6ztyBFB/9epATucG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d9vDTyLo4ryvFtCkTH+ibCJf3gvgwyuqnpt2Y4TG0I=;
 b=QG8njU86YE2gPbiCkzOLpXHfXOxgJv2oz93/Qnk3PXoRL0/3In0+saXsUn+Fl01fcUp7dernw435/RsL2/U7IN+uHta1ygRDN+l2UaI9IU3b5z59d49CXBIktlpM3akvJ0yo4iFa6tWqJrB0ncYiddM7ZHgBqsrpCa6mFO5nwZDfds7RwmPFAtFfWn7/A71jxBSgvo0FQpmxS8TLDpNIYe0vmerxyzcSjJ7nJeyyJLASoS+/eVbJwK10MHcMUhYIaRF5uaprGqzHZUUetv+yWMOpH7Tf896tjAZc/u4dsz0PHozo9T1ksHB7ozNf/6dVFiCWKryOjcaftvfdwgaHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/d9vDTyLo4ryvFtCkTH+ibCJf3gvgwyuqnpt2Y4TG0I=;
 b=GPbIiVKWYuF7wwg7I/L+bIYe3hNj3IK3zPrXjy9eipoLE8PJF56Fhx5/WYlamCskDUXyfyCMRr1kE16Ez3TYhD6YJYP6XwJ6PdAf7fqiaWtNEU/iy5zNdDT6Zd3PXmSEOU282NYI6iKR1XqZ21nWfb6R0Bo1CVOxzo+ZH2f5D3k=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14; Wed, 10 Mar
 2021 18:48:33 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3955.009; Wed, 10 Mar 2021
 18:48:33 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        arnd@arndb.de, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 1/1] asm-generic/hyperv: Add missing function prototypes per -W1 warnings
Date:   Wed, 10 Mar 2021 10:47:49 -0800
Message-Id: <1615402069-39462-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [167.220.2.16]
X-ClientProxiedBy: MWHPR11CA0035.namprd11.prod.outlook.com
 (2603:10b6:300:115::21) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (167.220.2.16) by MWHPR11CA0035.namprd11.prod.outlook.com (2603:10b6:300:115::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 18:48:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d764e30-7095-4e34-edbd-08d8e3f51af0
X-MS-TrafficTypeDiagnostic: DM6PR21MB1481:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB148189AB0FBAAB83A2A64A8AD7919@DM6PR21MB1481.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXSyz2UhBq6vAzY4i+yLOJdwt9NbGkN4wc655jsmE8SQRp9o1eAaZtY/HbiKtEGD4KWiE0fhRVr8F4BI/jDACEZxqNebuhar1cQ7NilaVy0Ud3ee2F+Am9gguxmBRRdrCwhI/AP27+T29F4/FKLqCh/10LpviSa9SKxK7tnxDOZbErkidajVfpCenkQdzrt0c3dS/NAJvMU2BmuQeqayMDT+CkPdDwsOEMMREBtlV3fT3WNo02dgLGIgyuwZPUPwspBrJW6e7bxvJPckUTxFIr/6c/dDio6B3WyHxdORyblokLv5QO5/D3W3CvdJhmYUcPOTFTJBYDlDNYLi6HliNhBqsB5TnT5mPpDtB+2v4VogEIvoZgpDqJIl005LpfvIG5I6Cbn1M7rS0naxnk7hH1nnhOj4M4XKkc8TZAJgBJPyD6vgSX+Q5LxgY0tm5pjikc1UN8dpWvT4odMfj7CQKw5tfWDkf6WZs1KUGvd7Ya7PMeSMOfvTR2C4RW2EKFp4ZJOYUD2abBkPQ2oUla2mLR6Yo7+ZJ3Sqt4phi/bAXF/YQrFMPlh0mSaoNcX2IBA0HV/h2bu9Z69bp6tPD12bP6EUNACdGPyGRxOTJmOIpCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(2906002)(186003)(83380400001)(8936002)(82950400001)(82960400001)(16526019)(4744005)(2616005)(66946007)(5660300002)(66556008)(6486002)(66476007)(86362001)(7696005)(52116002)(956004)(6666004)(26005)(8676002)(316002)(10290500003)(36756003)(478600001)(4326008)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qPpZr8H3eFFLeWhTwDpzphiSfjkUfmOAP1Qv8sq/9g19glMmzp+LVjyKwlIP?=
 =?us-ascii?Q?4543QbSS5BiPyNbnUempeFGY2h9o+n1i71qam85vQMPH15GKGGFPkHGl2qpo?=
 =?us-ascii?Q?jeV1jp2L5e2rIW2TYA29/OzGAqjBPz5BbSkxxnDeE5DMHahZG01K7vROw/9G?=
 =?us-ascii?Q?vLpnx+mI42I6SlgYNGIN/H7gJ4gS80WhXCV/v+k48jYbPYIEZHicMTx6rXbV?=
 =?us-ascii?Q?GUjOARstTC5+MOS1mPfpSrDqFs/flkbp4AhyZ75z/FssLbQqJHsdASCUPF6P?=
 =?us-ascii?Q?bI5hAZ1vQTiAeQkSv2XT+/htWv/Ypqba28rWgEK5RVMIqhS/VNxUY80ytfaO?=
 =?us-ascii?Q?mvJd+L3VgZCBHBOVhqzLq8L24Hhyzh3eYEfgCIleelMplfk0w1nG69Qo8p85?=
 =?us-ascii?Q?py2dfWicxLNQNyIvBR/LbuThDKl0EBj+ZAfjSqSIMeeDsBplVuneqqlStSss?=
 =?us-ascii?Q?vmY3pgIPDlDJWen1qrVs3i5c0t+vse+bdXx91tVOl1tPCwQn5FiSV2Fr5T+G?=
 =?us-ascii?Q?WNhhHldEHvAFcvzYtZ76hNYBs+xXYCPpRTy3IGHGUCfDPN7ZQrBYsxYHLJ6L?=
 =?us-ascii?Q?FKkFU37W40GbxfhOUrRreJkeaDEnHBqUxq3ffW2zjXG11ktKM3CjTHxJGzuJ?=
 =?us-ascii?Q?OIp2lYTsB1umtqcn95Zs9P3Xdb4q8i2Tijq7TKBpWTy++s4CkPNSa3GrukPc?=
 =?us-ascii?Q?iE9CqkaxUjuc7zNN8mHHx9jaDn7XyReoZKFMoPEvAgjq4B9YpE29ZVxwn89E?=
 =?us-ascii?Q?PYxWQ/SEYw7I0JJ4zaoasEESJ7ATTUjpkI4kF8L94pUjHqeYpF7NJ3zn5XrK?=
 =?us-ascii?Q?X2CjP651Y89vyMB3aBc0EjVk39v1K7GojcmpeyaH0iGsmbpa3G1bbV7m82aj?=
 =?us-ascii?Q?UIFTm4o1a1S7KI5MDdcVow3iInX/RrDUM15W7o4w0E+WTfOiI3PSu5zQ38lf?=
 =?us-ascii?Q?2rOu8nCU95YjS58NFeVb4N6wiQT/D0KvXZwKxrGaYjU9Pdo0uwT+WJMIm/ou?=
 =?us-ascii?Q?2fP2hmgKQ2+hZt5HJItEQ8zrOITvdswNcRmWzY7CCYRFlyExWNUuIr4tL11/?=
 =?us-ascii?Q?eeeTXtMYq4W1VoNcLPHErSWk4rWZnAxvKQMTsGs4uLKrXfci6o862uju3BVy?=
 =?us-ascii?Q?t8a1G8n8+URZWK1s9yd1+11/n/V0em0OPDzKeUQwa7JHMDKaC0Nhr5bKjmvK?=
 =?us-ascii?Q?gE399MBuCcyc2m+/DJnfV1eoIe2zxkeKIjT5lxf/FwwBAuVLNEa66b9oNq+c?=
 =?us-ascii?Q?E1uNC7SGQcklYpSlB7SCsldogiPhDEf3hF+/rAkwMSM4XzEklO/mXv7OkJ74?=
 =?us-ascii?Q?V4I3N7LoD2BsG7SPcXGP+JNl?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d764e30-7095-4e34-edbd-08d8e3f51af0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 18:48:33.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYJAH/vx6rJ+CwG6t2ZkQub7cN/5r/3nNJnajXPrLUuUEpHaaYoLdAWjEy5OIgS0T4wk+ar72pzGbMftAvuUUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1481
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add two function prototypes for -W1 warnings generated by the
kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 include/asm-generic/mshyperv.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 69e7fe0..2d1b6cd 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -94,6 +94,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 
 void hv_setup_vmbus_handler(void (*handler)(void));
 void hv_remove_vmbus_handler(void);
+void hv_setup_stimer0_handler(void (*handler)(void));
+void hv_remove_stimer0_handler(void);
 
 void hv_setup_kexec_handler(void (*handler)(void));
 void hv_remove_kexec_handler(void);
-- 
1.8.3.1

