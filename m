Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705F32591EA
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgIAOyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 10:54:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgIALs1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 07:48:27 -0400
Date:   Tue, 01 Sep 2020 11:48:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pUta5Zk4FfoDx/NGPIBXT5qYhHCXO0PxXNn6+h/JFg=;
        b=NhtVVS7iynWFb+nPXvI/P9XVnUKRnH1SZA+UFbA6fs2TjAuTnphLpRyl3I0/GX9NsY8pVr
        5FqW0bh96K4hASmqf/k1PL7HVPw8YmtZk7wAvNW/k6IhPuxuSk+8dtAzCupkpmfauJbZbS
        rTg+bY5IRqI/MqYAA0gtQZJ+gg3QDCAwRDT7xjcr7WobqDC5H7SIKHHbzZuOwREc4W4naf
        XnoQioAJNDWCrN7+aBW89aXcpYy51QBbxdbSf1SeRGTm5+CfXX6acD6M6Rg1vOSdaRXBxB
        2A0ew7MD1vF5Szfcb6njqGnG7nwr89IvTDjgHn68tpwDzZFxkIWR9q3nfDFFFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960881;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4pUta5Zk4FfoDx/NGPIBXT5qYhHCXO0PxXNn6+h/JFg=;
        b=IXxC7ghcoXOMkFsdiVCLXuv302cyIZ84U2uCR/fMI4ssPXTwPX7MTp3aLkHB4PK8kgWarx
        uxdASpMgK3ApyPCg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Marco Elver <elver@google.com>, linux-arch@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-4-keescook@chromium.org>
References: <20200821194310.3089815-4-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896088072.20229.9345391960421718006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     d812db78288d76d1e8c6df3a840c41a8875f6468
Gitweb:        https://git.kernel.org/tip/d812db78288d76d1e8c6df3a840c41a8875f6468
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:44 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:35 +02:00

vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections

KASAN (-fsanitize=kernel-address) and KCSAN (-fsanitize=thread)
produce unwanted[1] .eh_frame and .init_array.* sections. Add them to
COMMON_DISCARDS, except with CONFIG_CONSTRUCTORS, which wants to keep
.init_array.* sections.

[1] https://bugs.llvm.org/show_bug.cgi?id=46478

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Marco Elver <elver@google.com>
Cc: linux-arch@vger.kernel.org
Link: https://lore.kernel.org/r/20200821194310.3089815-4-keescook@chromium.org
---
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f1f02a2..6b89a03 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -954,7 +954,27 @@
 	EXIT_DATA
 #endif
 
+/*
+ * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
+ * unwanted sections (.eh_frame and .init_array.*), but
+ * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
+ * https://bugs.llvm.org/show_bug.cgi?id=46478
+ */
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
+# ifdef CONFIG_CONSTRUCTORS
+#  define SANITIZER_DISCARDS						\
+	*(.eh_frame)
+# else
+#  define SANITIZER_DISCARDS						\
+	*(.init_array) *(.init_array.*)					\
+	*(.eh_frame)
+# endif
+#else
+# define SANITIZER_DISCARDS
+#endif
+
 #define COMMON_DISCARDS							\
+	SANITIZER_DISCARDS						\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
