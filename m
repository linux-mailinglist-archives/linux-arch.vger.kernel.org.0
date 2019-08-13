Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E468C2C3
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfHMVEN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:04:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:18661 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbfHMVDo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:03:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="194276005"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2019 14:03:42 -0700
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
Subject: [PATCH v8 13/14] x86: Discard .note.gnu.property sections
Date:   Tue, 13 Aug 2019 13:53:58 -0700
Message-Id: <20190813205359.12196-14-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205359.12196-1-yu-cheng.yu@intel.com>
References: <20190813205359.12196-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

With the command-line option, -mx86-used-note=yes, the x86 assembler
in binutils 2.32 and above generates a program property note in a note
section, .note.gnu.property, to encode used x86 ISAs and features.
To exclude .note.gnu.property sections from NOTE segment in x86 kernel
linker script:

PHDRS {
 text PT_LOAD FLAGS(5);
 data PT_LOAD FLAGS(6);
 percpu PT_LOAD FLAGS(6);
 init PT_LOAD FLAGS(7);
 note PT_NOTE FLAGS(0);
}
SECTIONS
{
...
 .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
e.*)) __stop_notes = .; } :text :note
...
}

this patch discards .note.gnu.property sections in kernel linker script
by adding

 /DISCARD/ : {
  *(.note.gnu.property)
 }

before .notes sections.  Since .exit.text and .exit.data sections are
discarded at runtime, it undefines EXIT_TEXT and EXIT_DATA to exclude
.exit.text and .exit.data sections from default discarded sections.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/vmlinux.lds.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index e2feacf921a0..5ef137493a85 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -146,6 +146,10 @@ SECTIONS
 		_etext = .;
 	} :text = 0x9090
 
+	/* .note.gnu.property sections should be discarded */
+	/DISCARD/ : {
+		*(.note.gnu.property)
+	}
 	NOTES :text :note
 
 	EXCEPTION_TABLE(16) :text = 0x9090
@@ -415,6 +419,12 @@ SECTIONS
 	STABS_DEBUG
 	DWARF_DEBUG
 
+	/* Sections to be discarded.  EXIT_TEXT and EXIT_DATA discard at
+	 * runtime, not link time. */
+#undef EXIT_TEXT
+#define EXIT_TEXT
+#undef EXIT_DATA
+#define EXIT_DATA
 	DISCARDS
 	/DISCARD/ : {
 		*(.eh_frame)
-- 
2.17.1

