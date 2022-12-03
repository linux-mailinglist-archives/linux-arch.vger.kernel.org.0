Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8535B6412A0
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiLCAnU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiLCAmD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:42:03 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299851042E0;
        Fri,  2 Dec 2022 16:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027908; x=1701563908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9Rgq6Is1ft2SHhT8Knmc6hxAfAY7NUj7tCn2AnWmhHU=;
  b=JLznq60wRLmOAHjqC+rkZsCOl7pFbD2wpjlzi9HyaQHHk/0UJhUMJSXh
   96jhzCFrokGQJxiP9kg+E6JbcRDKwJOizY6Jetv5tL5pYQ4Sdd9Wouw84
   hdvq2xzmb3ya8x+vd0PlzwoWhodqhdDSA6epCLxMMqow5ujDt1uzXeisy
   sSdCZNAUDr5z7ck1cHlvksd1oB69AebpTJxCWnMXIZArPqu/p+zCCJdbZ
   oRabDTvIrhDFU/6Y30qAvBJBvOh9UBQxVhkTmsZMCNi10iAEJ1Hbp9haz
   mDAvCfwqMNojKgsWSdY9ssqWj+XfMlzoDD1/vakepWxjllmo+sJS0bOrr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711482"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479999"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479999"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:38 -0800
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
Subject: [PATCH v4 32/39] x86: Expose thread features in /proc/$PID/status
Date:   Fri,  2 Dec 2022 16:35:59 -0800
Message-Id: <20221203003606.6838-33-rick.p.edgecombe@intel.com>
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

Applications and loaders can have logic to decide whether to enable
shadow stack. They usually don't report whether shadow stack has been
enabled or not, so there is no way to verify whether an application
actually is protected by shadow stack.

Add two lines in /proc/$PID/status to report enabled and locked features.

Since, this involves referring to arch specific defines in asm/prctl.h,
implement an arch breakout to emit the feature lines.

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
index d2a94eafe9a3..96ee17d68b4c 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -433,6 +433,11 @@ static inline void task_untag_mask(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(mm));
 }
 
+__weak void arch_proc_pid_thread_features(struct seq_file *m,
+					  struct task_struct *task)
+{
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -457,6 +462,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	arch_proc_pid_thread_features(m, task);
 	return 0;
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 81d6e4ec2294..5a8b21c0a587 100644
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

