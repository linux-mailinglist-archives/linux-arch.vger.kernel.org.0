Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD29B562
	for <lists+linux-arch@lfdr.de>; Fri, 23 Aug 2019 19:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389269AbfHWRY2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Aug 2019 13:24:28 -0400
Received: from foss.arm.com ([217.140.110.172]:37596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388090AbfHWRY1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 13:24:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6C1337;
        Fri, 23 Aug 2019 10:24:27 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 053C03F246;
        Fri, 23 Aug 2019 10:24:25 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC PATCH v2 1/2] ELF: UAPI and Kconfig additions for ELF program properties
Date:   Fri, 23 Aug 2019 18:23:39 +0100
Message-Id: <1566581020-9953-2-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Pull the basic ELF definitions from Yu-Cheng Yu's series.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

This patch should be merged with the next patch.

I kept it seprate for now to document where this code came from.

Changes since RFC v1:

 * Move struct gnu_property to <linux/elf.h>.  There's currently no
   consensus about exactly what this should look like in the public
   headers, so keep in private to the kernel for now.  Binutils etc.
   are using their own definitions anyway.
---
 fs/Kconfig.binfmt        | 3 +++
 include/linux/elf.h      | 8 ++++++++
 include/uapi/linux/elf.h | 1 +
 3 files changed, 12 insertions(+)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f5..d2cfe07 100644
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
index e3649b3..4485499 100644
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
+  __u32 pr_type;
+  __u32 pr_datasz;
+};
+
 #endif /* _LINUX_ELF_H */
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 34c02e4..c377314 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -36,6 +36,7 @@ typedef __s64	Elf64_Sxword;
 #define PT_LOPROC  0x70000000
 #define PT_HIPROC  0x7fffffff
 #define PT_GNU_EH_FRAME		0x6474e550
+#define PT_GNU_PROPERTY		0x6474e553
 
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
 
-- 
2.1.4

