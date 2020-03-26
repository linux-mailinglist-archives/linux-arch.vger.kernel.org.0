Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA807194771
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 20:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCZTaX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Mar 2020 15:30:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:19991 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgCZTaX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Mar 2020 15:30:23 -0400
IronPort-SDR: sUc/iKSiymdV9bfydQeVhfT2l0G5VTsLVxIXV7mRam5ujQzCRf7z/7ueDuXXTT9mMf/+eCXyiq
 FrOTLTbNp/YA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 12:30:22 -0700
IronPort-SDR: 8rrb5ZG8GM/QeYTy+WeAaTd8GHFstpsu9eGcxNXh1ozzceB1NWR/ckwOcIY3lbqIg5U1/c0bxf
 soLf5O8JbCXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="282612076"
Received: from scymds01.sc.intel.com ([10.148.94.138])
  by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2020 12:30:22 -0700
Received: from gnu-skx-1.sc.intel.com (gnu-skx-1.sc.intel.com [172.25.70.205])
        by scymds01.sc.intel.com
        with ESMTP id 02QJUMiZ017330;
        Thu, 26 Mar 2020 12:30:22 -0700
Received: from gnu-skx-1.sc.intel.com (localhost [IPv6:::1])
        by gnu-skx-1.sc.intel.com (Postfix) with ESMTP id E3DB02C006A;
        Thu, 26 Mar 2020 12:30:21 -0700 (PDT)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 1/2] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Date:   Thu, 26 Mar 2020 12:30:20 -0700
Message-Id: <20200326193021.255002-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In x86 kernel, .exit.text and .exit.data sections are discarded at
runtime, not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
and define it in x86 kernel linker script to keep them.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S     |  1 +
 include/asm-generic/vmlinux.lds.h | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e3296aa028fe..7206e1ac23dd 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif
 
+#define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE
 #define RO_EXCEPTION_TABLE_ALIGN	16
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..6b943fb8c5fd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -894,10 +894,16 @@
  * section definitions so that such archs put those in earlier section
  * definitions.
  */
+#ifdef RUNTIME_DISCARD_EXIT
+#define EXIT_DISCARDS
+#else
+#define EXIT_DISCARDS							\
+	EXIT_TEXT							\
+	EXIT_DATA
+#endif
 #define DISCARDS							\
 	/DISCARD/ : {							\
-	EXIT_TEXT							\
-	EXIT_DATA							\
+	EXIT_DISCARDS							\
 	EXIT_CALL							\
 	*(.discard)							\
 	*(.discard.*)							\
-- 
2.25.1

