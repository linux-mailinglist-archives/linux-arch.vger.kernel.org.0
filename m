Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746F869BCF8
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjBRVWh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjBRVVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:21:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855291ABFA;
        Sat, 18 Feb 2023 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676755141; x=1708291141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rLqhRE2d5TzXO0jkrIimoFvYNyWSmS33HBbaA6qKIFg=;
  b=ldeR68weXIcb+J89Eq2jW5P7X2+SGIfjb32yverMoC48smSUv8D09qtK
   5e8asO42UHfkSGP26LtgdXEEp49HQwpXWTEdrIK90sLF7n4PIq+4HW1Xa
   4fGPx2ObWr/YpXNB9E/9S1NcjkJg/PfgRd3o7+r7ue7fz7SDBpm3bcF3O
   TxNnaNLFijoB8pL27ccttV5Uxuj27CdD8HMywqqU88RzvEPs2zlnH25Gz
   OCS2RO55i2hIbUzCE8v8ZZeGfMf0CWzXjtRmu34Bj/7ZLZ+KFj98XM1rc
   fEeuv2VmS1GhtUsi3KgduqWy1ObkQHlU27jNOcHtcv5wbOdPvsXDyYoE8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427849"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427849"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241739"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241739"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:24 -0800
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
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v6 35/41] x86: Expose thread features in /proc/$PID/status
Date:   Sat, 18 Feb 2023 13:14:27 -0800
Message-Id: <20230218211433.26859-36-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Applications and loaders can have logic to decide whether to enable
shadow stack. They usually don't report whether shadow stack has been
enabled or not, so there is no way to verify whether an application
actually is protected by shadow stack.

Add two lines in /proc/$PID/status to report enabled and locked features.

Since, this involves referring to arch specific defines in asm/prctl.h,
implement an arch breakout to emit the feature lines.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[Switched to CET, added to commit log]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v4:
 - Remove "CET" references

v3:
 - Move to /proc/pid/status (Kees)

v2:
 - New patch
---
 arch/x86/kernel/cpu/proc.c | 23 +++++++++++++++++++++++
 fs/proc/array.c            |  6 ++++++
 include/linux/proc_fs.h    |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index 099b6f0d96bd..31c0e68f6227 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -4,6 +4,8 @@
 #include <linux/string.h>
 #include <linux/seq_file.h>
 #include <linux/cpufreq.h>
+#include <asm/prctl.h>
+#include <linux/proc_fs.h>
 
 #include "cpu.h"
 
@@ -175,3 +177,24 @@ const struct seq_operations cpuinfo_op = {
 	.stop	= c_stop,
 	.show	= show_cpuinfo,
 };
+
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+static void dump_x86_features(struct seq_file *m, unsigned long features)
+{
+	if (features & ARCH_SHSTK_SHSTK)
+		seq_puts(m, "shstk ");
+	if (features & ARCH_SHSTK_WRSS)
+		seq_puts(m, "wrss ");
+}
+
+void arch_proc_pid_thread_features(struct seq_file *m, struct task_struct *task)
+{
+	seq_puts(m, "x86_Thread_features:\t");
+	dump_x86_features(m, task->thread.features);
+	seq_putc(m, '\n');
+
+	seq_puts(m, "x86_Thread_features_locked:\t");
+	dump_x86_features(m, task->thread.features_locked);
+	seq_putc(m, '\n');
+}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49283b8103c7..7ac43ecda1c2 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -428,6 +428,11 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+__weak void arch_proc_pid_thread_features(struct seq_file *m,
+					  struct task_struct *task)
+{
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -451,6 +456,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	arch_proc_pid_thread_features(m, task);
 	return 0;
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0260f5ea98fe..80ff8e533cbd 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -158,6 +158,8 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task);
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
 
+void arch_proc_pid_thread_features(struct seq_file *m, struct task_struct *task);
+
 #else /* CONFIG_PROC_FS */
 
 static inline void proc_root_init(void)
-- 
2.17.1

