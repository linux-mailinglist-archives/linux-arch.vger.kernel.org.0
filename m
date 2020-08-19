Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F0249ADA
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHSKrl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Aug 2020 06:47:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54001 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgHSKrh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Aug 2020 06:47:37 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k8Ld0-0006IE-I5; Wed, 19 Aug 2020 10:47:34 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kars de Jong <jongk@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-doc@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hewllig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 08/11] kprobes: switch to kernel_clone()
Date:   Wed, 19 Aug 2020 12:46:52 +0200
Message-Id: <20200819104655.436656-9-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819104655.436656-1-christian.brauner@ubuntu.com>
References: <20200819104655.436656-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The old _do_fork() helper is removed in favor of the new kernel_clone() helper.
The latter adheres to naming conventions for kernel internal syscall helpers.

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 samples/kprobes/kprobe_example.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index 240f2435ce6f..a02f53836ee1 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -2,13 +2,13 @@
 /*
  * NOTE: This example is works on x86 and powerpc.
  * Here's a sample kernel module showing the use of kprobes to dump a
- * stack trace and selected registers when _do_fork() is called.
+ * stack trace and selected registers when kernel_clone() is called.
  *
  * For more information on theory of operation of kprobes, see
  * Documentation/staging/kprobes.rst
  *
  * You will see the trace data in /var/log/messages and on the console
- * whenever _do_fork() is invoked to create a new process.
+ * whenever kernel_clone() is invoked to create a new process.
  */
 
 #include <linux/kernel.h>
@@ -16,7 +16,7 @@
 #include <linux/kprobes.h>
 
 #define MAX_SYMBOL_LEN	64
-static char symbol[MAX_SYMBOL_LEN] = "_do_fork";
+static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
 module_param_string(symbol, symbol, sizeof(symbol), 0644);
 
 /* For each probe you need to allocate a kprobe structure */
-- 
2.28.0

