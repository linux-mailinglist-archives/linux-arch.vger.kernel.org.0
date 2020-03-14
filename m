Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB223185722
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 02:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCOBcN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Mar 2020 21:32:13 -0400
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:18974
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727401AbgCOBbx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN8Ehu4TOAFLkoX6fUVUNF8K2d3matrnLwfO4PeoXtb2ulwiCFNvDh1qXSW1Oh1VIdXdGq6xW4pjoGTs5rmFkEmpNrN/ZCUH2zOTu6Z2k9Lin1lPIsRUI0P+kZvbSG/G41jflfekJITc+LtXyCtGeP8vslIfS6U+nkD7jYpqy5+S8fJLbv/y3UICRRMGx0vfT/n+ruSfhGF+WSbpyFYSoCe3ZAVqpBauuK9q9cKY4FLGdUcLX3OCdk90jrZCAkMhJaOpqU+tA8PKqo9dmrbrrTPKTjmHsymqXG+7e3V53lLlNiOfJRmPzXw0uk45W7LDca/rLY+JH16WbOexSuSiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2V69NKeaHto3g1dhRW/YvOGh1RIGqgL7YLwR1BORBM=;
 b=nXjVWcu+vyTuntoWdADYZpFPrVEjfLoMc1eUKrII1yYwxhVFDVISdvf0WZoMltEjVfEMlSjvOPIg60Wor9iUp/xbmRNGqJjBhUWgNJmrSJcOzjx4cHXiv/0TwZmEneU9tQJipxKtalZZEQpCNGULJ1PGYGIemvpcttZtieRagk+PJxIlc1Z7/sfqFveIeXD0cpXu5EIoXr6Xikhn6QXpCh34J+O3U31KJntblzZKoVAfV9tKVWLNXSmIrCU5JvkHvFChvC7I4u20mGyghn6L/wX2IS/C6DauXgqkwsY1oBZIq4+pWSzDfi/Zs+DjscwKib0H9ePCZZM12wvh26A8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2V69NKeaHto3g1dhRW/YvOGh1RIGqgL7YLwR1BORBM=;
 b=Xq7cxraSh/D5JHZe7aYoPO0iNxPIfiK/eE+TOsqL6lz5TB7kmb0RSISiG66REZsrRw8q8dM7DN70yeSOkzUDLPBPp+jZE6dV4Tp0pSFLn/PZlMwOFcIAZzacWEy+PmL6Wua0dWU2UWYaFfIe2e5kumDue7BWL7Swto2LVsNo0BA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com (2603:10b6:805:a::18)
 by SN6PR2101MB1632.namprd21.prod.outlook.com (2603:10b6:805:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.4; Sat, 14 Mar
 2020 15:36:07 +0000
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3]) by SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3%9]) with mapi id 15.20.2835.008; Sat, 14 Mar 2020
 15:36:07 +0000
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
Subject: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions for Hyper-V size pages
Date:   Sat, 14 Mar 2020 08:35:13 -0700
Message-Id: <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To SN6PR2101MB0927.namprd21.prod.outlook.com
 (2603:10b6:805:a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkkerneltest.corp.microsoft.com (131.107.159.247) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Sat, 14 Mar 2020 15:36:05 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.247]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86ef4915-8e75-4bbf-dcdb-08d7c82d6999
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1632:|SN6PR2101MB1632:|SN6PR2101MB1632:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR2101MB16328E4EB44CFFD346077C4DD7FB0@SN6PR2101MB1632.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 034215E98F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(10290500003)(478600001)(2906002)(6486002)(36756003)(8936002)(66946007)(26005)(86362001)(2616005)(16526019)(186003)(956004)(66556008)(6636002)(66476007)(4326008)(7416002)(316002)(81166006)(8676002)(81156014)(52116002)(7696005)(6666004)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1632;H:SN6PR2101MB0927.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJTg6sD5zPlTVyE446APU6nwIRyZQF9KoJPCDN60PmHqCjj6OdxpIHhoerG0bvkItNUfMkn3SoT6JR0D8L2BmLNwHJetq7E+lMjPXk62wPHdrOtkogyuNenslbOOTb5Js5GHh9yb0AtTMPTeVPcTlOPQOWFJQZxY1EsjgPWrHlJIf+FBC0GfeOlD0jPBWZhfksa6hnutnRFChWpBRr2cROosu5o/vx9dHbysW2V6z8ooUbIbOo7RzHuEquew0xe0E/9l4AY2+S1+a73yaEY/hlNMEbM7V7blN99c4QLLRD4cnFCmCucvin0ufBUEh8prlUP78KKgqE+oh14j61JLegQVW6m1I5P92BL6qcHSDYiNZQFVLbvmSv2WfF5pYTL41PNWnJfAODDXF/S+tlIeHACvsOT+32fiTtDsYRSQenNzjUQBVA3TFtjMdhuxzIag9rj0yc9qjDUo9gJwndR4+UOPzhWqaQxA+Cfmv6IKVtwodj344zCa+QK8ZSaRlD1U
X-MS-Exchange-AntiSpam-MessageData: CKq4bdrQuYVxw3um1J8bYVSNJ7VkvkENgp/rfN/B0ufJArfh4aYIy1U5To3A06RM5f/lFR2xqsgZgOd/sVkVn+g3xUGLRFrg1V7tzY5thAHV/pfQBjasaA1Wl5gKFNYWKN4ZfwGSJjDeMccV/aQzNg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ef4915-8e75-4bbf-dcdb-08d7c82d6999
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 15:36:06.8578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C0DXU9F/QfEdL2v8CKLs1UHzUYhWNqkJtrpzXgun5cAi4L32noayJ6xW3V78QOt/jxsAiIZ9/SvuW6+UazfJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1632
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
 arch/arm64/hyperv/hv_core.c    | 34 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 272c348..4aa6b8f 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -17,12 +17,46 @@
 #include <linux/slab.h>
 #include <linux/hyperv.h>
 #include <linux/arm-smccc.h>
+#include <linux/string.h>
 #include <asm-generic/bug.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
 
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
+	return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
+
+void *hv_alloc_hyperv_zeroed_page(void)
+{
+	return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	kfree((void *)addr);
+}
+EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
+
+
+/*
  * hv_do_hypercall- Invoke the specified hypercall
  */
 u64 hv_do_hypercall(u64 control, void *input, void *output)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index b3f1082..1a7c4c5 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -99,6 +99,11 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
 
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

