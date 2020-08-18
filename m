Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8C248D4D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgHRRg7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 13:36:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52416 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgHRRe3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 13:34:29 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k85VC-0003E9-CE; Tue, 18 Aug 2020 17:34:26 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hewllig <hch@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org
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
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 04/11] m68k: switch to kernel_clone()
Date:   Tue, 18 Aug 2020 19:34:04 +0200
Message-Id: <20200818173411.404104-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818173411.404104-1-christian.brauner@ubuntu.com>
References: <20200818173411.404104-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The old _do_fork() helper is removed in favor of the new kernel_clone() helper.
The latter adheres to naming conventions for kernel internal syscall helpers.

Cc: Kars de Jong <jongk@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/m68k/kernel/process.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 6492a2c54dbc..08359a6e058f 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -107,10 +107,10 @@ void flush_thread(void)
  * on top of pt_regs, which means that sys_clone() arguments would be
  * buried.  We could, of course, copy them, but it's too costly for no
  * good reason - generic clone() would have to copy them *again* for
- * _do_fork() anyway.  So in this case it's actually better to pass pt_regs *
- * and extract arguments for _do_fork() from there.  Eventually we might
- * go for calling _do_fork() directly from the wrapper, but only after we
- * are finished with _do_fork() prototype conversion.
+ * kernel_clone() anyway.  So in this case it's actually better to pass pt_regs *
+ * and extract arguments for kernel_clone() from there.  Eventually we might
+ * go for calling kernel_clone() directly from the wrapper, but only after we
+ * are finished with kernel_clone() prototype conversion.
  */
 asmlinkage int m68k_clone(struct pt_regs *regs)
 {
@@ -125,7 +125,7 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
 		.tls		= regs->d5,
 	};
 
-	return _do_fork(&args);
+	return kernel_clone(&args);
 }
 
 /*
-- 
2.28.0

