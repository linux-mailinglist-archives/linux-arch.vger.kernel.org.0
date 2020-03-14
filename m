Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A029185700
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 02:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCOBbk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Mar 2020 21:31:40 -0400
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com ([40.107.94.97]:13053
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727320AbgCOBbj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ch1KfLqAGOu/pIdmuD08W6n6ANb6CZwrE4IL3YBMs2s//eKcK/Oruxr747wFvHXvic3jmLKtyNu9YXDJN4I6dn9htF7KSfqPl0gvPHHWKO53xpia+roBLbTzgmuWq+7/XSVHJdSghgOFko+QesX70RjB+MsQk6dpK1p/HUcpXQDAgT6jULfFDqToiaOU7ST6D2TRWYynPg6JkW0+f8eGLWRZX8q4+xvyZvXXUur70z5byE4nOlc0V9iWBoSgCllNVQPjjgWsfiyq50PacZ4YIj9b2+gvUlevbgyUsMxezYxHr9zzRpWUDGd8vdKQG+fpfw5xizfJktSc9ez5LHNVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PV712g3ms28H2QFj0D+vWdL+gvp+JVKNUthg+fNuV4=;
 b=Ce+b48i/FmDby3pP9lV4vSK0FVcitNhWRmsV2U7cv6Ir2KmCIZc5qvXxnfgkgxOjaDyXaJO5c8T21nOSOC0TAM/NAEBG4B8GXq/bwEkInj6pwCp3Z9BX/bAZKgBoe+8xD1U514uccEB7PCxThp/3AjgOQhpeNZMVF/LrPsQetZJDyJO+D10frtilfpLTcKuETyLiyUZmntCIfD+faguCj3IyBBBDQnawaIC/vP3+PICDD3e69Yoo+IJZEJFmaQ0ErSj7qkMRASts/DcNionF1oUzXYo6y7EqYfQh7SO6KKJya743/S+5BgTTeRIr0ut/FkL/t3nnlz8OeQMbh817pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PV712g3ms28H2QFj0D+vWdL+gvp+JVKNUthg+fNuV4=;
 b=UUIacZrLAouOhySM2YNnfqUXVZT5ln+4MGb/SEGBV3Pg6H7WIpkCUN+tlVx5El2FOUz8GjrZFFOjhMstYiZ5GmG8/iHDCFzRz1nyrsPSjnd+KiZm1QhkjbgvkyckVIHcB4E+ZpedlTSeyXK+EsMwwDMzqjklrZV0wBL9pvTSKac=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com (2603:10b6:805:a::18)
 by SN6PR2101MB1632.namprd21.prod.outlook.com (2603:10b6:805:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.4; Sat, 14 Mar
 2020 15:36:04 +0000
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3]) by SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3%9]) with mapi id 15.20.2835.008; Sat, 14 Mar 2020
 15:36:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v6 02/10] arm/arm64: smccc-1.1: Add vendor specific owner definition
Date:   Sat, 14 Mar 2020 08:35:11 -0700
Message-Id: <1584200119-18594-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To SN6PR2101MB0927.namprd21.prod.outlook.com
 (2603:10b6:805:a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkkerneltest.corp.microsoft.com (131.107.159.247) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Sat, 14 Mar 2020 15:36:02 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.247]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a134102-4fd6-4387-1abb-08d7c82d67d3
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1632:|SN6PR2101MB1632:|SN6PR2101MB1632:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR2101MB16326D7E357D07CD5FE99651D7FB0@SN6PR2101MB1632.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 034215E98F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(10290500003)(478600001)(2906002)(6486002)(36756003)(8936002)(66946007)(26005)(86362001)(2616005)(16526019)(186003)(956004)(66556008)(6636002)(66476007)(4326008)(7416002)(316002)(81166006)(8676002)(81156014)(52116002)(7696005)(6666004)(5660300002)(4744005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1632;H:SN6PR2101MB0927.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0Kh8yFy3reWaUxLQCaMYY2ktWMPKpRky5Rlm5BsEF1biqj8PpWSBK2TLn+hPBLTfMde0w7IyW0W9Ty8UVLvs+kNqWdAsTMsCh5yGLFYYcC5TqQfa2ExI+x1PBG0zqTdx96dhbZOPUOQ91+42BgE7MMzurgXjl00PG7Oj4U4/GtKOYjGgjiJMV2p1Kj51C1C6nDmP6BHLPNpG7uwBVPpYgRxIsYT97+H+vrfOt9xDZ8oJXLIThZ0XJRVCyiHpvK2D8j4at5NcOvym7Um0SUDmFB/N87cezrI+yovBcovVfO+pF0bqe17f5GtOnbaeyjBvSpQOK5ls82W12s2fxrooibtmpr/PoILwvVzBs6Xb4nJxXEGw33xpN1G5Eh5A8GDEeJ+VquepkNginoEieEm57cDs0SailplvLhpMBHeXsu9hwXB1VCk5FVAXDmVjsNCJBwtRnKgBs4Mc+5Olnq2HqHWEgyF0RPnjHY0R2ym2h1crxck5433O5M+EDirQ0sj
X-MS-Exchange-AntiSpam-MessageData: ci0tGJWaCSEryytksHgXytNUSd2e+/ZIuZIJY2k6vbgADmeuXnH5jxHsgRDgXKgkNuNxy0SRbl9dvWb6pmDZevMEqaGucEQDvxYjjEaS3No4Lnq+VnVaN6MDxA4gGrzeOaS2Cu0whF1jjxP6jODECw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a134102-4fd6-4387-1abb-08d7c82d67d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 15:36:03.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBiuNiMTlIE2xu4JI+QkBi0HgPBOa5+EfYGpGXY/WIbWuROln+X0LuwLwO+N6s2ym/PHkeddSFJFOd1HfBuTMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1632
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In the SMCCC v1.1 spec, the Owning Entity Number in the Function
Identifier may have a value of 6 for a vendor specific hypervisor
service call. Add this #define.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 include/linux/arm-smccc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 59494df..8229203 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -46,6 +46,7 @@
 #define ARM_SMCCC_OWNER_OEM		3
 #define ARM_SMCCC_OWNER_STANDARD	4
 #define ARM_SMCCC_OWNER_STANDARD_HYP	5
+#define ARM_SMCCC_OWNER_VENDOR_HYP	6
 #define ARM_SMCCC_OWNER_TRUSTED_APP	48
 #define ARM_SMCCC_OWNER_TRUSTED_APP_END	49
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
-- 
1.8.3.1

