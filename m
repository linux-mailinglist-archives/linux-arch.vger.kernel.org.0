Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE505F00A2
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiI2Wgu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiI2WgB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:36:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FBF1B0536;
        Thu, 29 Sep 2022 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490721; x=1696026721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TiT3uy8CkFT3vSQU1URwMBZV8RmBfXFHioOJIpTN2Lc=;
  b=Q1QpxQMQoduH/U42n759pEJfsKOFdKsD9tj9VNfuPMnOXy5TDQ+UiBlW
   uFGth9dMfElK7K0USg+9S2J8d5yJRqtiRtb3lYxF5RUs93R3MURe2oyG+
   RlF2x/Ct5N0sNZawjlNRciFMYBEra6EG4cDbXpVhv9wm5t4dPO8zx4FZz
   QSI88S+eWgrUPcDCMuWpejK30EZ+/nSIoDZDzSLhjS247bWa+kfhnOIm3
   hPQftkDsGLREdBkS5COOi60u5308RrU4WkFUjdhiqQK9YOviZbMxyrDBD
   w4/YsanMe8YpFUP2LeouOG42wOCNZMX1fnR5PZmVzA9vdvB5szvZRHQcY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182119"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182119"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016345"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016345"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:47 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v2 30/39] x86: Expose thread features status in /proc/$PID/arch_status
Date:   Thu, 29 Sep 2022 15:29:27 -0700
Message-Id: <20220929222936.14584-31-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Applications and loaders can have logic to decide whether to enable CET.
They usually don't report whether CET has been enabled or not, so there
is no way to verify whether an application actually is protected by CET
features.

Add two lines in /proc/$PID/arch_status to report enabled and locked
features.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[Switched to CET, added to commit log]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - New patch

 arch/x86/kernel/Makefile     |  2 ++
 arch/x86/kernel/fpu/xstate.c | 47 ---------------------------
 arch/x86/kernel/proc.c       | 63 ++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 47 deletions(-)
 create mode 100644 arch/x86/kernel/proc.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8950d1f71226..b87b8a0a3749 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -141,6 +141,8 @@ obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
 obj-$(CONFIG_X86_SHADOW_STACK)		+= shstk.o
 
+obj-$(CONFIG_PROC_FS)			+= proc.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 5e6a4867fd05..9258fc1169cc 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -10,8 +10,6 @@
 #include <linux/mman.h>
 #include <linux/nospec.h>
 #include <linux/pkeys.h>
-#include <linux/seq_file.h>
-#include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 
 #include <asm/fpu/api.h>
@@ -1746,48 +1744,3 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
 		return -EINVAL;
 	}
 }
-
-#ifdef CONFIG_PROC_PID_ARCH_STATUS
-/*
- * Report the amount of time elapsed in millisecond since last AVX512
- * use in the task.
- */
-static void avx512_status(struct seq_file *m, struct task_struct *task)
-{
-	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
-	long delta;
-
-	if (!timestamp) {
-		/*
-		 * Report -1 if no AVX512 usage
-		 */
-		delta = -1;
-	} else {
-		delta = (long)(jiffies - timestamp);
-		/*
-		 * Cap to LONG_MAX if time difference > LONG_MAX
-		 */
-		if (delta < 0)
-			delta = LONG_MAX;
-		delta = jiffies_to_msecs(delta);
-	}
-
-	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
-	seq_putc(m, '\n');
-}
-
-/*
- * Report architecture specific information
- */
-int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
-			struct pid *pid, struct task_struct *task)
-{
-	/*
-	 * Report AVX512 state if the processor and build option supported.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
-		avx512_status(m, task);
-
-	return 0;
-}
-#endif /* CONFIG_PROC_PID_ARCH_STATUS */
diff --git a/arch/x86/kernel/proc.c b/arch/x86/kernel/proc.c
new file mode 100644
index 000000000000..fa9cbe13c298
--- /dev/null
+++ b/arch/x86/kernel/proc.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include <uapi/asm/prctl.h>
+
+/*
+ * Report the amount of time elapsed in millisecond since last AVX512
+ * use in the task.
+ */
+static void avx512_status(struct seq_file *m, struct task_struct *task)
+{
+	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
+	long delta;
+
+	if (!timestamp) {
+		/*
+		 * Report -1 if no AVX512 usage
+		 */
+		delta = -1;
+	} else {
+		delta = (long)(jiffies - timestamp);
+		/*
+		 * Cap to LONG_MAX if time difference > LONG_MAX
+		 */
+		if (delta < 0)
+			delta = LONG_MAX;
+		delta = jiffies_to_msecs(delta);
+	}
+
+	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
+	seq_putc(m, '\n');
+}
+
+static void dump_features(struct seq_file *m, unsigned long features)
+{
+	if (features & CET_SHSTK)
+		seq_puts(m, "shstk ");
+	if (features & CET_WRSS)
+		seq_puts(m, "wrss ");
+}
+
+/*
+ * Report architecture specific information
+ */
+int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
+			struct pid *pid, struct task_struct *task)
+{
+	/*
+	 * Report AVX512 state if the processor and build option supported.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
+		avx512_status(m, task);
+
+	seq_puts(m, "Thread_features:\t");
+	dump_features(m, task->thread.features);
+	seq_putc(m, '\n');
+
+	seq_puts(m, "Thread_features_locked:\t");
+	dump_features(m, task->thread.features_locked);
+	seq_putc(m, '\n');
+
+	return 0;
+}
-- 
2.17.1

