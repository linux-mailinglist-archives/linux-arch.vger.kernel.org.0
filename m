Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30776185723
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 02:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCOBbu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Mar 2020 21:31:50 -0400
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:18974
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbgCOBbt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCOAkCZvPx7tA5Uv/xAPpwvM7zvGGEYQt2QWaC6HntweiquaF0exLtv/ZbCu+b9YLID2KNBoQrKy1JHHIaXFtEm0zElQWDHOsECQCYLLiQshvdYAdTwLG3+iTWisO4i7fK/Xio3CinlW3HsKbIg5rPkBlSc3WNZoG0UVu2K5aUNpWMzGZaRmzhJAMRISv9MTOErqFB0LAeySTK9judqBmqNwSLBfXA9CY+HcQwsaPtI9FqM72iuQyvspULxKzNBA8Clpfs8FClef8u5aU1Gu8yA1Ti/mVioWhXAPWK7u5aiTy2SNvLK+guHMoJxgzhGv9/6wuhf4YQEKKBNGvmZrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEGJ2pGVOoA/475BwOAc1zBZDs85myo5tbrBv9fk6gs=;
 b=KQki/ICY5T7Yo7w3BjTvCBhxq7Mase1EzNfg9d5iy2bEgpa2BXO4TAnalh3jOvbXnQ2CD9DBnk1C0whpS+Cwa4kNODN1AkAlZ/ND92iTLU+z0Gower/Ozv3FmqbC8lunNRSLm1jykYDQcBvcqqtua/QgikcMsevd0lnm/JScvpd5QeYtYSkgMsURcK/Chwfpj50cbXYTIf4emwrmm9CbI7Hm64eaTm6FjHTaYOynC577GUTYLAMeqCFTtNoXMO++amkTRXAUobawK4UMDceuNP9KeMxhKGDNRI4jxsYebklB6VViAM1ne6fCecrv03UCXPr62RtOJEshdjlUoNOI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEGJ2pGVOoA/475BwOAc1zBZDs85myo5tbrBv9fk6gs=;
 b=OFtconn8tvxTC//+CKBLiEWqGqhRmljXERNtTSt4uo32x115srrKJrI3bP9gryJ8Ne1CUAwC0gFkOWyKMQklHFV+wEDoUtrydbOW3WjjDNIestCstVUl/6bHOnE+8DIbDEYGEhp8upsmCNHcxE2nybfCY+cjxehRjt7B2gsce/E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com (2603:10b6:805:a::18)
 by SN6PR2101MB1632.namprd21.prod.outlook.com (2603:10b6:805:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.4; Sat, 14 Mar
 2020 15:36:14 +0000
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3]) by SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3%9]) with mapi id 15.20.2835.008; Sat, 14 Mar 2020
 15:36:14 +0000
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
Subject: [PATCH v6 09/10] arm64: efi: Export screen_info
Date:   Sat, 14 Mar 2020 08:35:18 -0700
Message-Id: <1584200119-18594-10-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To SN6PR2101MB0927.namprd21.prod.outlook.com
 (2603:10b6:805:a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkkerneltest.corp.microsoft.com (131.107.159.247) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Sat, 14 Mar 2020 15:36:12 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.247]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa18a8ac-fb5b-45a4-0360-08d7c82d6e08
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1632:|SN6PR2101MB1632:|SN6PR2101MB1632:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR2101MB1632D8BED20203D17C2B48C6D7FB0@SN6PR2101MB1632.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 034215E98F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(10290500003)(478600001)(2906002)(6486002)(36756003)(8936002)(66946007)(26005)(86362001)(2616005)(16526019)(186003)(956004)(66556008)(6636002)(66476007)(4326008)(7416002)(316002)(81166006)(8676002)(81156014)(52116002)(7696005)(5660300002)(4744005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1632;H:SN6PR2101MB0927.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbdB0tH8tKMiUThQwYWGKZOxRnzTq127KlSzAswxDBC95h1k5YnSKKp9yRxZiximTAfmMkOh7m6o4CFYMXv7cFcDvQEy0H4yc3FXtstTKmn4LOnAzS/P+0LbITjzynrRY1oBm2/rS5n1z1KYeX88ETeZqSRTUdijmhtziWoiyqoqNMakPx1701tzyVYGMivPnTJrs7xGkVNGUrfug2pO0ZXrGZPOj8wm4u8p95hg8AX4lbE1cuO6XwrickuRkceHyfE+nqdJr+VTGE0ftBmak4Nk63dKdfImTzOJ9N9BYjwB0sY+/IYgBl4chXTgdfAlO5k8CejpvAjNd3WPIt3gQ35fTvsj/RV0aKGUhBdDlEIUvY2xkJZM+PHs4rrljn7AXqQBz+dQlUmf24YAtZiToM3Fw3uq+p2Obu/y8OpCcnVfI2Mv/qEbcIqMUOPhgBxJ3O+X9vviWLV0REcElQTvtrJomWcuPE0IQ+7BO3IosUmpCE2ZWI3t4/aBbnS+PtoJ
X-MS-Exchange-AntiSpam-MessageData: uj/Hisrwvd9nKQv9zZzTKBbJdCFbA+a/Xi8IMlDGwTR/33vJy0BTxVRgXf2jB1T5M2p3nGvS01NabtHqA2C6tmBIFjrfsv7YLpU7yqiQVuXUpgpwo4LF7lvlJxm9MEQCUk5Bcw/CKKCw+TDEoTvOvA==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa18a8ac-fb5b-45a4-0360-08d7c82d6e08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 15:36:14.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE5H610I12vVHMne5ENm75qulXv5rQnTdmxZsYsCEtGs7uDNtrXkXw6eksn5HAj3HlNQkc5jp3NoTU+AmOuEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1632
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Hyper-V frame buffer driver may be built as a module, and
it needs access to screen_info. So export screen_info.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/kernel/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index d0cf596..8ff557a 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -55,6 +55,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 
 /* we will fill this structure from the stub, so don't put it in .bss */
 struct screen_info screen_info __section(.data);
+EXPORT_SYMBOL(screen_info);
 
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
-- 
1.8.3.1

