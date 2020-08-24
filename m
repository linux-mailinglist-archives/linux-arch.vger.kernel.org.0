Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD8D2503F8
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgHXQy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:54:56 -0400
Received: from mail-dm6nam12on2120.outbound.protection.outlook.com ([40.107.243.120]:2560
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbgHXQr5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGausWlDjfzJ9gSEUfARqZJB/jzt88J0ZD593O/C4AAHZPenD2gXj+XACQl+2mbYEN/CS3nc2H9G2mgNJknLkNZMrUiD4xk1P96jsMDCouIENCvRKtAZXiIaEpsexxaP3VSl38HePeVOnWVzAo3Ct+J1Pby+o1rn+LiR9oOwYjWK/I5Mk1QTLNuoPPyYR56znAn1Pcp4UWpGBduYXx/rQX4RFkuhuY1c0o7YdYiJzz/ilUWc34PzkcxXGmWz9PVNp4JysB4XbhPAWu4CDJC3Z97GA/uyFfBg+4NBIxEWkaFA5B8HUap0lMcIT+fN7dctecnlDoR/QAGUjFbRDKmDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmze2nQ8/9ls2Gk++w5LIsR6HXsVIrPclx6MxH20zjI=;
 b=FVAu1HB2mssyuBpe1/5/SLzmseuV2+QgU61LqJ7RdUKTbNJMaocmPy6QUGvB1jQOQ+Vqb7aGiMEPnp6/ULQLjeXGcvwz0J+HVd9K9Sk9Ry9fqY1jMBkejHCGZDHOiRUhRqKJqPrh6a6rjaPEqT2tygMiGjMMR06m8SxICQQ0kR1OQHopq2wH9Rp0Bs/TnknDmRlwfziT+NWuIsYERrkPyZSihuLGPr/mVtuqhOQmjMvrwbqfy4RHMxzP9po6WyclvZc55cofgcgf+4449ZxxUMdFk36h4DaGM2NlSC7LC0m4qoCf82s6I9rX3cw2tWEyDmofNkUk+6+OP32zwsYKOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmze2nQ8/9ls2Gk++w5LIsR6HXsVIrPclx6MxH20zjI=;
 b=J+JnWmINPxscUailRBwumUc7VCnGl1GLVobPyVT1gRrWtiJOHaLA/KRpJVQgyvk5bV/SnBHBvl2MfVp2MWTmeHGusZTvz/m4B9SOSzZ57P/5+Plv6O9943RGX830u+q3Bduq/zB8C/NC1Zic+0CJ2ZfDzYdm7A1bCxMJst211QM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:47:43 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:47:43 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 01/10] arm/arm64: smccc-1.1: Add vendor specific owner definition
Date:   Mon, 24 Aug 2020 09:46:14 -0700
Message-Id: <1598287583-71762-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:41 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edd52061-fa6b-4240-9739-08d8484d6bba
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB0753B20C50C32625883F711CD7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6qM1XyiJpzV2ne3wnFQM3qq3AmwBu58Cw0okP1MIPwmPpReSo8GvNSpThZYiokHqprs4GqCpcYLK1Os9xehwLgqjakgfP+9f8wUcPqkAXWliH7uDlB662Vlq/HMq/s4IQEfi/xzpS0Z3aWYc6kb8040KFp/j8GGrKX9w5PEy5mTXYZ5IqzudHTYmzqs41DnEi/rAF+p2zSB3ChdBL06vOupWacL8ipFELP/ei1cWy4PUtNlajnrroKPyGwD1o/ppcsufEWdF2xyLcGX1SACPPC47NPX4lMC+gUXuVxPRnjpEM22TY4iu39bgH/XBxu0trWMXu4I6vQo42K/ElhDjPTpzQq9MKRCIr0l5Ti/4axtQ1xDbq5Ozw09DpiSI6Da
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(4744005)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0M+U9om80NEr7GgteThBukqRDQd/gYsYCpUmNEbLXIJZysjqj2E6fxRwwovUTwtyzgpS91InrVPXBp2N3+/Y6XSnWYVCyN+EhdrkX0Fad5kHA01TyyVSFN92TCtm5r+yrMS7U/GKCXOJqQh6ZbvUzssca/VvBKKE9o0ovQUz2lwxhOVOXeYuvR29JueYPT4Dm3011VXf0u+TlFwcs8vqI+Z5T+bTtx0zFsobYO5C+eFfj07EZlmibJEKFhWVkqm07WhHrUQX2gftGp25+eS71U8LIQiavktozdpTWXGAimp3K5dGFZ9TrM5FaHvtah9NCPKmdYsxiH9H1KlIZ1hAHaNDa6bFgPICTD/79PC+t4dle8H55J/9FB2xeOe6xKEK8buAfg0yW52imGJBDFnUrZGe0r5rq+boaCkqEbM6du2NgH+SevmPI/K6GOkVZ9EkzWcA8sv+o8XV0VByFgwUXWKD7nWzMJUhzwaFEtCsp1ShNcFng1pMQxAC9zkmXbAAB/qN5DuupJIUIQ/V9yl3MO6kE7Dl8To0bvgvb8z8bQwAGKXNqZGdBCLQzW4tiZUA98lUI5ZXgmJtc7bRPvczDnN7zXeOt8iYjEIFEMHXq5BgZgE6Aq+R9RKQJ6P4pA/e79SIjGBqhrGTrfgjab25Dg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd52061-fa6b-4240-9739-08d8484d6bba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:43.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ti1rOcY+s9USJxw2aiCD0DWUW+qvMNHUqeK0jevpF6Jf3K9dYGAPcwfT0+LT0LgdJEZfvNm70nfiQtiMPm+CPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
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
index 15c706f..ee286f5 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -49,6 +49,7 @@
 #define ARM_SMCCC_OWNER_OEM		3
 #define ARM_SMCCC_OWNER_STANDARD	4
 #define ARM_SMCCC_OWNER_STANDARD_HYP	5
+#define ARM_SMCCC_OWNER_VENDOR_HYP	6
 #define ARM_SMCCC_OWNER_TRUSTED_APP	48
 #define ARM_SMCCC_OWNER_TRUSTED_APP_END	49
 #define ARM_SMCCC_OWNER_TRUSTED_OS	50
-- 
1.8.3.1

