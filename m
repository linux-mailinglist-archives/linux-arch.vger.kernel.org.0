Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA31537B5
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 19:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgBESV0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 13:21:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:20934 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbgBESUc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Feb 2020 13:20:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 10:20:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="279447831"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Feb 2020 10:20:29 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [RFC PATCH v9 20/27] ELF: UAPI and Kconfig additions for ELF program properties
Date:   Wed,  5 Feb 2020 10:19:28 -0800
Message-Id: <20200205181935.3712-21-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce basic ELF definitions relating to the NT_GNU_PROPERTY_TYPE_0
note.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 fs/Kconfig.binfmt        | 3 +++
 include/linux/elf.h      | 8 ++++++++
 include/uapi/linux/elf.h | 1 +
 3 files changed, 12 insertions(+)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f577ba1..d2cfe0729a73 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -36,6 +36,9 @@ config COMPAT_BINFMT_ELF
 config ARCH_BINFMT_ELF_STATE
 	bool
 
+config ARCH_USE_GNU_PROPERTY
+	bool
+
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y if !BINFMT_ELF
diff --git a/include/linux/elf.h b/include/linux/elf.h
index e3649b3e970e..459cddcceaac 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_ELF_H
 #define _LINUX_ELF_H
 
+#include <linux/types.h>
 #include <asm/elf.h>
 #include <uapi/linux/elf.h>
 
@@ -56,4 +57,11 @@ static inline int elf_coredump_extra_notes_write(struct coredump_params *cprm) {
 extern int elf_coredump_extra_notes_size(void);
 extern int elf_coredump_extra_notes_write(struct coredump_params *cprm);
 #endif
+
+/* NT_GNU_PROPERTY_TYPE_0 header */
+struct gnu_property {
+	u32 pr_type;
+	u32 pr_datasz;
+};
+
 #endif /* _LINUX_ELF_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 34c02e4290fe..c37731407074 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -36,6 +36,7 @@ typedef __s64	Elf64_Sxword;
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
+#define PT_GNU_PROPERTY		0x6474e553
 
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
 
-- 
2.21.0

