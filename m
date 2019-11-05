Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73AEEEF932
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 10:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfKEJ2o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 04:28:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40639 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388099AbfKEJ2M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 04:28:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRv7e-0007Ts-AX; Tue, 05 Nov 2019 10:27:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A8A441C04C9;
        Tue,  5 Nov 2019 10:27:31 +0100 (CET)
Date:   Tue, 05 Nov 2019 09:27:31 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] vmlinux.lds.h: Allow EXCEPTION_TABLE to live in RO_DATA
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "x86-ml" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191029211351.13243-15-keescook@chromium.org>
References: <20191029211351.13243-15-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <157294605141.29376.16810559476409135725.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     b8c2f776164c8f74ac31c5e370ca3f029be0aa19
Gitweb:        https://git.kernel.org/tip/b8c2f776164c8f74ac31c5e370ca3f029be0aa19
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 29 Oct 2019 14:13:36 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Nov 2019 15:59:01 +01:00

vmlinux.lds.h: Allow EXCEPTION_TABLE to live in RO_DATA

Many architectures have an EXCEPTION_TABLE that needs to be only
readable. As such, it should live in RO_DATA. Create a macro to identify
this case for the architectures that can move EXCEPTION_TABLE into
RO_DATA.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: x86-ml <x86@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: https://lkml.kernel.org/r/20191029211351.13243-15-keescook@chromium.org
---
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 356078e..9867d8e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -69,6 +69,17 @@
 #define NOTES_HEADERS_RESTORE
 #endif
 
+/*
+ * Some architectures have non-executable read-only exception tables.
+ * They can be added to the RO_DATA segment by specifying their desired
+ * alignment.
+ */
+#ifdef RO_EXCEPTION_TABLE_ALIGN
+#define RO_EXCEPTION_TABLE	EXCEPTION_TABLE(RO_EXCEPTION_TABLE_ALIGN)
+#else
+#define RO_EXCEPTION_TABLE
+#endif
+
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
@@ -513,6 +524,7 @@
 		__stop___modver = .;					\
 	}								\
 									\
+	RO_EXCEPTION_TABLE						\
 	NOTES								\
 									\
 	. = ALIGN((align));						\
