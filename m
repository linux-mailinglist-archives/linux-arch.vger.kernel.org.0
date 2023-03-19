Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB046BFE97
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjCSAYW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCSAXj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:23:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CA92BF3D;
        Sat, 18 Mar 2023 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185269; x=1710721269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NaxDC9okCEIT/JhArq/4DzJUEPU99GVMAiUn52jAzaM=;
  b=n+xtZv9ijWl9sxFAiGzgZzlg+GeMkUJniEZcIGXQeg0unjSsN3h4L8Za
   bYd7x3mlDgqSTRuwJvtHPXRV/f7d04PdQk20aisfdUFGS/3YJwEQP1RIW
   C4wptPybetyfipW4rGQz4OWgG1tZ6CQC8OM8QsVswTEKKb5Jzz9BCXZ5c
   AMCvRXL7zXfxfKKHj7uQin3P0omKs03k9t/nKr9HNwCetAzGHZQ3z7jM0
   GQj2vNKSMsEzG0Z+3Z9AHYIAS+KiXQOAEjE9xd3tqDMHSfWNdHJegVShg
   ynGW4LZnKAAAImAaaPjK8uUcjXoz0EAwGbsFq/+W+q0ZROdPPkGPiJ529
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491625"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491625"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749673030"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749673030"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:59 -0700
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v8 40/40] x86/shstk: Add ARCH_SHSTK_STATUS
Date:   Sat, 18 Mar 2023 17:15:35 -0700
Message-Id: <20230319001535.23210-41-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
References: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

CRIU and GDB need to get the current shadow stack and WRSS enablement
status. This information is already available via /proc/pid/status, but
this is inconvenient for CRIU because it involves parsing the text output
in an area of the code where this is difficult. Provide a status
arch_prctl(), ARCH_SHSTK_STATUS for retrieving the status. Have arg2 be a
userspace address, and make the new arch_prctl simply copy the features
out to userspace.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v5:
 - Fix typo in commit log

v4:
 - New patch
---
 Documentation/x86/shstk.rst       | 6 ++++++
 arch/x86/include/asm/shstk.h      | 2 +-
 arch/x86/include/uapi/asm/prctl.h | 1 +
 arch/x86/kernel/process_64.c      | 1 +
 arch/x86/kernel/shstk.c           | 8 +++++++-
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/shstk.rst b/Documentation/x86/shstk.rst
index f3553cc8c758..60260e809baf 100644
--- a/Documentation/x86/shstk.rst
+++ b/Documentation/x86/shstk.rst
@@ -79,6 +79,11 @@ arch_prctl(ARCH_SHSTK_UNLOCK, unsigned long features)
     Unlock features. 'features' is a mask of all features to unlock. All
     bits set are processed, unset bits are ignored. Only works via ptrace.
 
+arch_prctl(ARCH_SHSTK_STATUS, unsigned long addr)
+    Copy the currently enabled features to the address passed in addr. The
+    features are described using the bits passed into the others in
+    'features'.
+
 The return values are as follows. On success, return 0. On error, errno can
 be::
 
@@ -86,6 +91,7 @@ be::
         -ENOTSUPP if the feature is not supported by the hardware or
          kernel.
         -EINVAL arguments (non existing feature, etc)
+        -EFAULT if could not copy information back to userspace
 
 The feature's bits supported are::
 
diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index ecb23a8ca47d..42fee8959df7 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -14,7 +14,7 @@ struct thread_shstk {
 	u64	size;
 };
 
-long shstk_prctl(struct task_struct *task, int option, unsigned long features);
+long shstk_prctl(struct task_struct *task, int option, unsigned long arg2);
 void reset_thread_features(void);
 unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 				       unsigned long stack_size);
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 200efbbe5809..1b85bc876c2d 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -26,6 +26,7 @@
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
 #define ARCH_SHSTK_UNLOCK		0x5004
+#define ARCH_SHSTK_STATUS		0x5005
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 69d4ccaef56f..31241930b60c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -836,6 +836,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_SHSTK_DISABLE:
 	case ARCH_SHSTK_LOCK:
 	case ARCH_SHSTK_UNLOCK:
+	case ARCH_SHSTK_STATUS:
 		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index ad336ab55ace..1f767c509ee9 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -452,8 +452,14 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
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

