Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A686412B5
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiLCAn6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiLCAmJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:42:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E4FB88D;
        Fri,  2 Dec 2022 16:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027918; x=1701563918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IEms/ukaJcEhqIOw9O3rDng3eVx/Cw+mUObHcCDOvMo=;
  b=VmQJtG/wplIYftv8Ytm+ntwscUXvPWhieTMLJyZCffG6GL3nu9bSQ4Jo
   3vxLsJnGI5GailneJC/yTjN9tZDrBWZZ+vOUx86a9pFROW4Mi+Z1pTzlK
   tX7VXFa6watwdEDg81CLlG8TpFOdxYPPqJlU3iTHP0CFX8frGYH3ebKow
   Vn5JEHJSLUx1uX/pbcZB8nC2zRqTWu7+gb+vgkw+ZRnWf25y2sOSmKh7p
   AzJgZE0NXzYk2OFO2i3H8eymO3auO3LUXKLP38EbLUsempZrYecGsF8hY
   biUSfCpvAWJ1aIyhiGviwry0BQha6zfZcX39vDqAcJRVsdYA7YP6d9M0p
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711706"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711706"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787480082"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787480082"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:55 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v4 39/39] x86/shstk: Add ARCH_SHSTK_STATUS
Date:   Fri,  2 Dec 2022 16:36:06 -0800
Message-Id: <20221203003606.6838-40-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CRIU and GDB need to get the current shadow stack and WRSS enablement
status. This information is already available via /proc/pid/status, but
this is incovienent for CRIU because it involves parsing the text output
in an area of the code where this is difficult. Provide a status
arch_prctl(), ARCH_SHSTK_STATUS for retrieving the status. Have arg2 be a
userspace address, and make the new arch_prctl simply copy the features
out to userspace.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Requested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v4:
 - New patch

 Documentation/x86/shstk.rst       | 6 ++++++
 arch/x86/include/asm/shstk.h      | 4 ++--
 arch/x86/include/uapi/asm/prctl.h | 1 +
 arch/x86/kernel/process_64.c      | 1 +
 arch/x86/kernel/shstk.c           | 8 +++++++-
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/shstk.rst b/Documentation/x86/shstk.rst
index 0d7d1ccfff06..b3eb87046c27 100644
--- a/Documentation/x86/shstk.rst
+++ b/Documentation/x86/shstk.rst
@@ -77,6 +77,11 @@ arch_prctl(ARCH_SHSTK_UNLOCK, unsigned long features)
     Unlock features. 'features' is a mask of all features to unlock. All
     bits set are processed, unset bits are ignored. Only works via ptrace.
 
+arch_prctl(ARCH_SHSTK_STATUS, unsigned long addr)
+    Copy the currently enabled features to the address passed in addr. The
+    features are described using the bits passed into the others in
+    'features'.
+
 The return values are as following:
     On success, return 0. On error, errno can be::
 
@@ -84,6 +89,7 @@ The return values are as following:
         -EOPNOTSUPP if the feature is not supported by the hardware or
          disabled by kernel parameter.
         -EINVAL arguments (non existing feature, etc)
+        -EFAULT if could not copy information back to userspace
 
 The feature's bits supported are::
 
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index c82f22fd5e6d..23bfb63c597d 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -15,7 +15,7 @@ struct thread_shstk {
 	u64	size;
 };
 
-long shstk_prctl(struct task_struct *task, int option, unsigned long features);
+long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
 void reset_thread_features(void);
 int shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 			     unsigned long stack_size,
@@ -31,7 +31,7 @@ static inline bool shstk_enabled(void)
 }
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
-			     unsigned long features) { return -EINVAL; }
+			     unsigned long arg2) { return -EINVAL; }
 static inline void reset_thread_features(void) {}
 static inline int shstk_alloc_thread_stack(struct task_struct *p,
 					   unsigned long clone_flags,
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 0c95688cf58e..abe3fe6db6d2 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -31,6 +31,7 @@
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
 #define ARCH_SHSTK_UNLOCK		0x5004
+#define ARCH_SHSTK_STATUS		0x5005
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 2be6e01fb144..5dcf5426241b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -922,6 +922,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_SHSTK_DISABLE:
 	case ARCH_SHSTK_LOCK:
 	case ARCH_SHSTK_UNLOCK:
+	case ARCH_SHSTK_STATUS:
 		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 95579f7bace3..05f8dcc19dbc 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -448,8 +448,14 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
 	return alloc_shstk(addr, aligned_size, size, set_tok);
 }
 
-long shstk_prctl(struct task_struct *task, int option, unsigned long features)
+long shstk_prctl(struct task_struct *task, int option, unsigned long arg2)
 {
+	unsigned long features = arg2;
+
+	if (option == ARCH_SHSTK_STATUS) {
+		return put_user(task->thread.features, (unsigned long __user *)arg2);
+	}
+
 	if (option == ARCH_SHSTK_LOCK) {
 		task->thread.features_locked |= features;
 		return 0;
-- 
2.17.1

