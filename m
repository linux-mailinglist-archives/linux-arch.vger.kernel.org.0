Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA95ED510
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 08:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiI1Gm3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 02:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiI1Glx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 02:41:53 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C11610D672;
        Tue, 27 Sep 2022 23:41:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id BE5401E80D40;
        Wed, 28 Sep 2022 14:36:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JIKw-suG0KCg; Wed, 28 Sep 2022 14:36:45 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E88A81E80D33;
        Wed, 28 Sep 2022 14:36:39 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH v6] hyperv: simplify and rename generate_guest_id
Date:   Wed, 28 Sep 2022 14:40:46 +0800
Message-Id: <20220928064046.3545-1-kunyu@nfschina.com>
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
1. The return value of the function is modified to u64.
2. Remove the d_info1 and d_info2 parameters from the function, keep the
u64 type kernel_version parameter.
3. Rename the function to make it clearly a Hyper-V related function,
and modify it to hv_generate_guest_id.

Signed-off-by: Li kunyu <kunyu@nfschina.com>

--------
 v2: Fix generate_guest_id to hv_generate_guest_id.
 v3: Fix [PATCH v2] asm-generic: Remove the ... to [PATCH v3] hyperv: simp
     lify ... and remove extra spaces
 v4: Remove #include <linux/version.h> in the calling file, and add #inclu
     de <linux/version.h> in the function implementation file
 v5: <linux/version.h> is changed to the definition position before v4, an
     d the LINUX_VERSION_CODE macro is passed in the function call
 v6: Modify the patch description information to the changed information a
     fter discussion
---
 arch/arm64/hyperv/mshyperv.c   | 2 +-
 arch/x86/hyperv/hv_init.c      | 2 +-
 include/asm-generic/mshyperv.h | 9 +++------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index bbbe351e9045..a406454578f0 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -38,7 +38,7 @@ static int __init hyperv_init(void)
 		return 0;
 
 	/* Setup the guest ID */
-	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
+	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
 
 	/* Get the features and hints from Hyper-V */
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3de6d8b53367..032d85ac33fa 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -426,7 +426,7 @@ void __init hyperv_init(void)
 	 * 1. Register the guest ID
 	 * 2. Enable the hypercall and register the hypercall page
 	 */
-	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
+	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
 	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c05d2ce9b6cd..bfb9eb9d7215 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -105,15 +105,12 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 }
 
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
-static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_version,
-				       __u64 d_info2)
+static inline u64 hv_generate_guest_id(u64 kernel_version)
 {
-	__u64 guest_id = 0;
+	u64 guest_id;
 
-	guest_id = (((__u64)HV_LINUX_VENDOR_ID) << 48);
-	guest_id |= (d_info1 << 48);
+	guest_id = (((u64)HV_LINUX_VENDOR_ID) << 48);
 	guest_id |= (kernel_version << 16);
-	guest_id |= d_info2;
 
 	return guest_id;
 }
-- 
2.18.2

