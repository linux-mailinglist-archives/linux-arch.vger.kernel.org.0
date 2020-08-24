Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F202503D6
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgHXQwH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:52:07 -0400
Received: from mail-dm6nam12on2104.outbound.protection.outlook.com ([40.107.243.104]:1074
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728848AbgHXQsm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:48:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WApy1dXTtbRFJVTg0PKD+APQCw295emjOQ99J2SdlmlL+KmzZpTtMiZHDjm3bFtMGPvKRB04hrAjy7SBlABDa9K4bv+DvSaCgIIuVZmX82R7Ge7mIKuET5dVmuDPBWY4XdHa7Sd7X4W3zFtKwCFB3Eh7/LYK+Uo0wdl+PBmC9WBpFhCmiE0PmOgiYbl1BJ0bcZIl6ChaL+NGG3wjmPhjedD/qjQkkZy8Br8EUAMyMvpDUp8e/g9nh3CIqgntf33WPb43dIPg1t8VlgDAcf9Tkj8O2sNQwwyMoeHaNjWoCmlGlNWsKBcpRKdkv20oyAfbQoKm6p1pdiNoift7mwKJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h90iRs2LNed01ztjCMOd97VyD/Aapry8OrQ+KqoQZhw=;
 b=jHfSVzQa6cStXXqNzi6oDOidexrNLDH8Goge4z7UBoJsXLcw0jjJxNevFhrdFSSg4X96TDGT1Tf/jYCHDli7yp4gkHDQMbdIPJ1KjagWRRgvEDog0hFtQUJJPAFjEohh+IXE5xD+BKYNPGedjG2yTJwWj1ZQgZ82wJKEPziMoyPRUFwcuEtdM0rHxoXwY8de/Hi3YEF8Jx6io37kBelov/3PW44bwxjBwOLbddVkk6zlJyvDHU/P7oCl48PLi8ucv7kPNuZHsrV/kvfE9KfDlZUF2qDDa+Qm73I/HNUsqfXdQiMCNRM+QCV9dVv/XQqXu9o9ysBPsSO4aIUYB1nfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h90iRs2LNed01ztjCMOd97VyD/Aapry8OrQ+KqoQZhw=;
 b=Crej1C1g+f6+rcJy/W/WdqFLKdiZWE0jGNvKctAiksBjRz4MliBM5uvJ1nUa3kF3naA6FBTgevlulrGwbjjkNuU8zl6A405BZFCZNnZNgBTsGsnLvI9Fe/+kAsrJFaKd0IhLBu2gjFTTDO/8AQNBg23e2/S8G0lVlaeZFmrlaRk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:47:48 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:47:48 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 04/10] arm64: hyperv: Add memory alloc/free functions for Hyper-V size pages
Date:   Mon, 24 Aug 2020 09:46:17 -0700
Message-Id: <1598287583-71762-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:47 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ffa684e-4fd2-4676-1901-08d8484d6f14
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB07537518E0C3F610F1CF67E1D7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXac9jyTZg9XHgzTC+Ls8xLP/V9eUrl7yqI/53PFWuNgOqJw27gtnh6frOuxOueq2Az4v0xj7CJfLK744+kQwyUkPVq3yHxRgQl6uQqq/c1bEBaXVDyQG60b7tY3rfbPqkykjyV1MnMFGKO1jiISI5nyA8Q0djZAjM79XfBOJ7y8K2A7PX+rB4KfMMlqakFoPAMO9L3hdLOxhhyy/FXqI3IuSnWE4xFd7u+bjSsbT/cVkhvvEWX12pO0mIyht9BxJ+He3XPrMCx2uxefoWPFYEOj6V17GX56FeLS5HgYbrraNDZG8LbMH+7GdAUq+o6+UbVt9zzDCfUAZuSD+OH+hF3oZYE3666qlS/0pNMyCmoB5OUhLT6lpWbQ0oSpBe9o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zZd8Q1zNASL8UTDW3/iQ+qv7P9P8HzW1+mzfW8JKblJtAKPc46qGHd30ABZq5adVNeO9fhG1CdKLQJcMV9uTcFQroPABqxfFpWOD/1W9neNqrIbZUQ85jLHYytCLzMO9G+wX57hAPWgIFENsQkGe9wml+wRrrbMkzoUu/uOmYwFWtFJc3ScYlcE6DkiQCxt24Va+MeIsZ8udxOGEevbLZiboqi3Cd3EnwYrtin6iAy49baf3qJgb9bJcHNMHxZ3IntyHJU2rVPIjSgMefOUDmBfdM/7qU0a6d707ymcXckBRSttg6bKdDQKztA4iwFERLF9bDBtnTrjb/m55qcgL/qEicw/ZWjdXipOOxohuvS+B9iDMc3Qf/Jho0KOmO572n8ggVLVPKKoTpfQz+pgnqMUVUKtbFrY2EeyukI1LtujcqEr/XfMbRNM0N3M6BX8mfmqufaxOZpqwAGNFuBcd/GzoKU41TcOUPpn+lKSA5CIhPuBxSBYCAEMwYNZj6t72SSxe7q5ipnhWOlcDWRxDx47nkyHmy+lXgHAttxF7P20YV5lBVaDvOJHECdxeiyHhUZ7HRHtVUKgd5rDgboCqstQPCxgkzv+vuzwlIOMkssFoxa/COB2PuqBiH8mV+ySWqy/M/mMiquHKfM2l/u/LWw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffa684e-4fd2-4676-1901-08d8484d6f14
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:48.7434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajUFDDZHRXatKiOSPQdQ9+ZNfTGLLw5Qqp2+qWXtgEoZ4/YofhMrDGRPrcLfaa0tgkgEWQNaz0BAkZ6r3r/E3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add ARM64-specific code to allocate memory with HV_HYP_PAGE_SIZE
size and alignment. These are for use when pages need to be shared
with Hyper-V. Separate functions are needed as the page size used
by Hyper-V may not be the same as the guest page size.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/hv_core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  5 +++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 9b35011..14e41b7 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -24,6 +24,49 @@
 
 
 /*
+ * Functions for allocating and freeing memory with size and
+ * alignment HV_HYP_PAGE_SIZE. These functions are needed because
+ * the guest page size may not be the same as the Hyper-V page
+ * size. We depend upon kmalloc() aligning power-of-two size
+ * allocations to the allocation size boundary, so that the
+ * allocated memory appears to Hyper-V as a page of the size
+ * it expects.
+ *
+ * These functions are used by arm64 specific code as well as
+ * arch independent Hyper-V drivers.
+ */
+
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
+
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL);
+	else
+		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
+
+void *hv_alloc_hyperv_zeroed_page(void)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	else
+		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		free_page(addr);
+	else
+		kfree((void *)addr);
+}
+EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
+
+
+/*
  * hv_do_hypercall- Invoke the specified hypercall
  */
 u64 hv_do_hypercall(u64 control, void *input, void *output)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c577996..d345a59 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -101,6 +101,11 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 
 extern int vmbus_interrupt;
 
+void *hv_alloc_hyperv_page(void);
+void *hv_alloc_hyperv_zeroed_page(void);
+void hv_free_hyperv_page(unsigned long addr);
+
+
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
  * Hypervisor's notion of virtual processor ID is different from
-- 
1.8.3.1

