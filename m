Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD03275BF
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhCABRB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:17:01 -0500
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:15737
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230386AbhCABQ4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Feb 2021 20:16:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h29xwBtjeIgltc75pqVQ4aCTeh6c8IdjEESGojKnbX6/Tbg90Er8Aelt6TxftS25wjmsK4bchFSH3dHujKHUWEpZghNjt0hxsfiLIYGS+144VeAnWT5OjlnBrgpBVy5mO7t+EBtmPfh6/xdxwyhjhzPQAk987SSCEtBHA7UNaUTPOG6G48beYuDvyI1yXz8QeHArxxlIx3p4cW8W90eZ21JVK6IlwQOhGcjNfAvaoyTZ8d1D5/tfl3Mtq8rFFX8N3H7gUrF9MR6pxqAq+TnOg2V/HB727ph27tyIm5/RlCJSbGbUfu9vRXtiXGH0nzj39v4iIj0KjyPQNq9wmCCGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3suxiQNBmLzDK95gAevTg151BuVaUgANYqf6MAMq6E=;
 b=Td7ovL/kzVJgDsqbWJRhdzyag8YlxXUu5G4UJA/rY1m2LgqY0nmc9YdJwaqNkIeBRmmOrvzwAh1sxdZtZrwYHr4UQCxpHBno4+fx1zhrsXhxZMs2ipMzL3EhFC/f28jwDywCWC6lJd3xjTkGfJ3jlyrMC9PSPhvke8AHeVBperWJzfkmDKVJhshR2fUWZaxf5ZS4+jhq59ZLK8dpCVjY4w27Agapw50lEqSnictSEFxPXRB+ArxVacNYoS0giWk7sTKLx0gIxYtNPjlPraj5S3hU/bx+UYMH8NV7Qvzr35HqfUT/HpW7bXBXQvkid3W6t2Rgz67def9M6//Pgasl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3suxiQNBmLzDK95gAevTg151BuVaUgANYqf6MAMq6E=;
 b=NEPcXUne5NhYhxUaTRpASuC3URZBgSLfGSakHP5jNJzyt+OStT5Y3uyZq3JN6zGkn1/vtAgZsOKkUOELcj3y9M8HwZxTWxqi9R3feqKw6tprkab4Ry/kPzxfM3H2CdK5y071+GGjmi7hcaEllfh3O47CbY3qi9Npfufd6Qqtapk=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:01 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 01/10] Drivers: hv: vmbus: Move Hyper-V page allocator to arch neutral code
Date:   Sun, 28 Feb 2021 17:15:23 -0800
Message-Id: <1614561332-2523-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.144]
X-ClientProxiedBy: MWHPR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:300:ae::18) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bff63c1f-3217-49a9-9fa2-08d8dc4f93d9
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB09817A3D5E7B2A3E1FBE0F7AD79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vZbWrk2Cj3GUZ0jwZkPJ8PivueXpZMjNB3bpZYVGDpwFOeD3Vh1KjUuJdbi6wqNlUT/cYdLZjFGJRHdTNk+E+80bte/vlatehrj7Qubt5YjmkHCH3xzaQTmkHTv9qJZk7TPntw6fBx9czwZFsLgUum+gnvXkIGZ4zF7PiBAFQzQSGyLshzlmuBTUMILBubi3nBe55Pc12kLtspv8fOmx5JRn3oWwtZ6WJ36gL6PrfGePeSe/h7bvmdF9I9QLFYCVqAEkDJYPni/OtcbfRIfgBhz+ykQghuUavTS40Q15x1LCmGc+XC4jH703VPKTC8WcAx/lCti7LdEBF133Kb/wO21ihLNHQzPq7YJ8NF//uLXySvQSctJ7iqXDa2PNnmqGIio1dJmuJf9V5h6Au20wHT+Ml17dFwZLhu6K6zP0BpflZFm+a2P92B+T1ZTgcBVJhU3uktmgCJqlKzJ2j9bhxagpsFNPYeBP0JKMEpJXLJTIj5NJagrpzxE+elkMexaLvr6foG6tzxCVJ1+lGZzbvCgoVgzwcl5Kwp1wQv08s7YrKz5aC0o/+DH7dlccldE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?awf1UZM5vLSksJr8Z2S8tLgCWJ+pq0ofM2r53QC3WYdp5L2B8lUB5Mm2DbET?=
 =?us-ascii?Q?fMdJoEpHP0tbCfoTu7TQ3tIPJ44qquSWNlrZFh5A6v/TSnWfauiROdnjpaux?=
 =?us-ascii?Q?UXpBLnuamTKu+U4puFQ1GwCjq2kHY+ZA97oXe3ufNP0+zIhY/siGyZlvM8zZ?=
 =?us-ascii?Q?SlPS7wVSfh3ozA+5QXo5JtPB96uqAawaVPYGOsQuQU6JZq7E2DY6+LCarC4z?=
 =?us-ascii?Q?qU/5eVFmujzUcblspntLJkZRJX658MfyDHJAltawViyHtUoaMRHI/mhmj0gO?=
 =?us-ascii?Q?9mtNqFJ5p+dKvEvLP/2DIPqJuBbuCF4BSK8uQ6U9savxgcewZK6D0AP4kOSZ?=
 =?us-ascii?Q?ZyOygmIDnFNckPh4NGYs7LaBjAiWinYvXOziMHEawTWhuwX8Psx8rG8fnpqg?=
 =?us-ascii?Q?HFmPl5kvc7IUZM8G4ZK9k61nIVtCJIdUe19mg88ByFx+4V0O5mKWhkeefdNo?=
 =?us-ascii?Q?BaGbm94j+qqv5NoIaA6AJVKDw9Qj+XSkDeng8Zh8Wr4jesB4OlvkocgCC2lN?=
 =?us-ascii?Q?ekM0myto5oyJdXXuf0QE8P+KcetBIYrLN9z0BFQ6oE8sEuLU/+t3XutHBkmV?=
 =?us-ascii?Q?t/YsbnsfJNqdCe+JP4O3YgSLLjvGAGLCm+5iyvLjCHZSsJPFspQY/1iWxYS3?=
 =?us-ascii?Q?A7Pb9k0o18VxJzWJPxtrnWyyV3HaAGlwqrGhmLzTASmy8CCqBSNlxq8igVCE?=
 =?us-ascii?Q?/4A2p5utl/NMyyhfyccPBtG+MmWs8Y+Low9gXaSrCl7l6RfvjRwzX0BTfySt?=
 =?us-ascii?Q?UHpPMFHpB9RFpUL3HfgvS6oFM01GxhSnaO/Fk4PoKYss5mGl118JLEhBv8dV?=
 =?us-ascii?Q?nUkLiV0muFsCH0d2xYWcMbhJ1YaZUXjtJbXaNsbaGkwEWFM3f7w9330P70bd?=
 =?us-ascii?Q?u8Pg/LjMsbzMga+81K4pn7/aOVUx9T3s+hKrCAN5PiPRVEAxAUWGWo9YtTgP?=
 =?us-ascii?Q?4LWJSh9venJK3jL+ItldcdedUEVtP5Hck2pD6Cd0kqvlwlN5sqaNzJWN9TbR?=
 =?us-ascii?Q?ZoyOFhori51JtlGBExrh9qDV04ojHC13J49R8KYJF+DRkkLo97MyPexsVI39?=
 =?us-ascii?Q?nZVNpwmKH6e1ykC0/zGrSzUTudScGCwHPEt78uxwCPQpFOC88s7P6F6X1JIs?=
 =?us-ascii?Q?FabqFd1VCXypLPFCJqywV8M738e4SVMAkt2/xm7/s1vyLDNivlaWpHRbPh04?=
 =?us-ascii?Q?p7YFIZLNySztf3gdVA7OvsjwV4E4OsjiDYMq4kFXJfny/zZ762fQy8HNxTT3?=
 =?us-ascii?Q?6QbbzkKDPnoiiinApjKKkvOfSkamAG/zFh+rmtx2Dny0m6vmuJHbcI1ii4Zs?=
 =?us-ascii?Q?K6GK33gf9kddFBg+Db6mMfEd?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff63c1f-3217-49a9-9fa2-08d8dc4f93d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:01.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKGz4CEertX6EbWVadx/i3qmRVU9OjL3yWi+dZLgKKlRszCdSvLGR3kE4Xtn0zUnKqFQdZDEST2wjQ/VKAnggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Hyper-V page allocator functions are implemented in an architecture
neutral way.  Move them into the architecture neutral VMbus module so
a separate implementation for ARM64 is not needed.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/hyperv/hv_init.c       | 22 ----------------------
 arch/x86/include/asm/mshyperv.h |  5 -----
 drivers/hv/hv.c                 | 36 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  4 ++++
 4 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b81047d..4bdb344 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -54,28 +54,6 @@
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
-void *hv_alloc_hyperv_page(void)
-{
-	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
-
-	return (void *)__get_free_page(GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
-
-void *hv_alloc_hyperv_zeroed_page(void)
-{
-        BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
-
-        return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
-
-void hv_free_hyperv_page(unsigned long addr)
-{
-	free_page(addr);
-}
-EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
-
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ccf60a8..ef6e968 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -233,9 +233,6 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-void *hv_alloc_hyperv_page(void);
-void *hv_alloc_hyperv_zeroed_page(void);
-void hv_free_hyperv_page(unsigned long addr);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
@@ -272,8 +269,6 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
-static inline void *hv_alloc_hyperv_page(void) { return NULL; }
-static inline void hv_free_hyperv_page(unsigned long addr) {}
 static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
 static inline void clear_hv_tscchange_cb(void) {}
 static inline void hyperv_stop_tsc_emulation(void) {};
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index f202ac7..cca8d5e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -37,6 +37,42 @@ int hv_init(void)
 }
 
 /*
+ * Functions for allocating and freeing memory with size and
+ * alignment HV_HYP_PAGE_SIZE. These functions are needed because
+ * the guest page size may not be the same as the Hyper-V page
+ * size. We depend upon kmalloc() aligning power-of-two size
+ * allocations to the allocation size boundary, so that the
+ * allocated memory appears to Hyper-V as a page of the size
+ * it expects.
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
+
+void *hv_alloc_hyperv_zeroed_page(void)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	else
+		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		free_page(addr);
+	else
+		kfree((void *)addr);
+}
+
+/*
  * hv_post_message - Post a message using the hypervisor message IPC.
  *
  * This involves a hypercall.
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dff58a3..694b5bc 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -117,6 +117,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 /* Sentinel value for an uninitialized entry in hv_vp_index array */
 #define VP_INVAL	U32_MAX
 
+void *hv_alloc_hyperv_page(void);
+void *hv_alloc_hyperv_zeroed_page(void);
+void hv_free_hyperv_page(unsigned long addr);
+
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
  * @cpu_number: CPU number in Linux terms
-- 
1.8.3.1

