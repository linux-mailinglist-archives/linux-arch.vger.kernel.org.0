Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8337E33
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfFFUQD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:16:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:47825 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbfFFUPj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:15:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 13:15:38 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2019 13:15:37 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 23/27] x86/cet/shstk: ELF header parsing of Shadow Stack
Date:   Thu,  6 Jun 2019 13:06:42 -0700
Message-Id: <20190606200646.3951-24-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606200646.3951-1-yu-cheng.yu@intel.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Look in .note.gnu.property of an ELF file and check if Shadow Stack needs
to be enabled for the task.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/Kconfig             |  1 +
 arch/x86/kernel/process_64.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1664918c2c1c..df8b57de75b2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1928,6 +1928,7 @@ config X86_INTEL_SHADOW_STACK_USER
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select X86_INTEL_CET
 	select ARCH_HAS_SHSTK
+	select ARCH_USE_GNU_PROPERTY
 	---help---
 	  Shadow stack provides hardware protection against program stack
 	  corruption.  Only when all the following are true will an application
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 250e4c4ac6d9..c51df5b4e116 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -828,3 +828,27 @@ unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
+
+#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
+int arch_setup_property(void *ehdr, void *phdr, struct file *f, bool inter)
+{
+	int r;
+	uint32_t property;
+
+	r = get_gnu_property(ehdr, phdr, f, GNU_PROPERTY_X86_FEATURE_1_AND,
+			     &property);
+
+	memset(&current->thread.cet, 0, sizeof(struct cet_status));
+
+	if (r)
+		return r;
+
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		if (property & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
+			r = cet_setup_shstk();
+		if (r < 0)
+			return r;
+	}
+	return r;
+}
+#endif
-- 
2.17.1

