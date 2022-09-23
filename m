Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508D15E79D8
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIWLnO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 07:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIWLnN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 07:43:13 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44B71E9502;
        Fri, 23 Sep 2022 04:43:12 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 0A00B1E80D97;
        Fri, 23 Sep 2022 19:39:36 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0Jz4Zr8rHdcv; Fri, 23 Sep 2022 19:39:33 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id BDBB11E80D94;
        Fri, 23 Sep 2022 19:39:31 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH v3] hyperv: simplify and rename generate_guest_id
Date:   Fri, 23 Sep 2022 19:42:59 +0800
Message-Id: <20220923114259.2945-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The generate_guest_id function is more suitable for use after the
following modifications.
1. Modify the type of the guest_id variable to u64, which is compatible
with the caller.
2. Remove all parameters from the function, and write the parameter
(LINUX_VERSION_CODE) passed in by the actual call into the function
implementation.
3. Rename the function to make it clearly a Hyper-V related function,
and modify it to hv_generate_guest_id.

Signed-off-by: Li kunyu <kunyu@nfschina.com>

--------
 v2: Fix generate_guest_id to hv_generate_guest_id.
 v3: Fix [PATCH v2] asm-generic: Remove the ... to [PATCH v3] hyperv: simp
     lify ... and remove extra spaces 
---
 arch/arm64/hyperv/mshyperv.c   |  2 +-
 arch/x86/hyperv/hv_init.c      |  2 +-
 include/asm-generic/mshyperv.h | 12 +++++-------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index bbbe351e9045..3863fd226e0e 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -38,7 +38,7 @@ static int __init hyperv_init(void)
 		return 0;
 
 	/* Setup the guest ID */
-	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
+	guest_id = hv_generate_guest_id();
 	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
 
 	/* Get the features and hints from Hyper-V */
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3de6d8b53367..93770791b858 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -426,7 +426,7 @@ void __init hyperv_init(void)
 	 * 1. Register the guest ID
 	 * 2. Enable the hypercall and register the hypercall page
 	 */
-	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
+	guest_id = hv_generate_guest_id();
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
 	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c05d2ce9b6cd..7f4a23cee56f 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -25,6 +25,7 @@
 #include <linux/nmi.h>
 #include <asm/ptrace.h>
 #include <asm/hyperv-tlfs.h>
+#include <linux/version.h>
 
 struct ms_hyperv_info {
 	u32 features;
@@ -105,15 +106,12 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 }
 
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
-static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
-				       __u64 d_info2)
+static inline u64 hv_generate_guest_id(void)
 {
-	__u64 guest_id = 0;
+	u64 guest_id;
 
-	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
-	guest_id |= (d_info1 << 48);
-	guest_id |= (kernel_version << 16);
-	guest_id |= d_info2;
+	guest_id = (((u64)HV_LINUX_VENDOR_ID) << 48);
+	guest_id |= (((u64)LINUX_VERSION_CODE) << 16);
 
 	return guest_id;
 }
-- 
2.18.2

