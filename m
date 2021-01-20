Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F42FC95B
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 04:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbhATDpn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jan 2021 22:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731660AbhATC3K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jan 2021 21:29:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27274C061794
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y205so7737828pfc.5
        for <linux-arch@vger.kernel.org>; Tue, 19 Jan 2021 18:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=prXDB+EbV8q2Y85dMh8P3ofjmXhPHc+qmPznftftxuY=;
        b=nWHCimPwRRk1g8YY8EJiJNSK1p4LaeUl25KQQzj64bhbH0wU0JqoQ8o/sZfykLabfw
         g7KtPX+Wpeum+RJ+7BRmiGp9U9hBJFKfFArY+w2JH+tw8/1LGQKLjmJxvGZG20YVlwVA
         bV8yacFl8j8OlmD4uEB37sbBDRLP2aZ9ls1+l2UmjhNxORJyER+ObP2Uh0pWC4w1Edk7
         NXQG0vSegfsMReCcB0zLX6AUA2S1gi58hp7BATB9MHm98nBGiNQEeCo+GXv+Gb+U2KBt
         WXmEflcFE9TRzVuM28YYcXFdgylS3BOdLpU0Ye/OkkUMFB/S3/Vit+Ljv39WA/oSjQJB
         w+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=prXDB+EbV8q2Y85dMh8P3ofjmXhPHc+qmPznftftxuY=;
        b=Qm5usAqVqy3LVIuZcfQdBPj8GXgFIYK3IVnOW8Vp9vaGHDPbFkiCdq8eNBNiiRuDCE
         1zaECOkhXxbGaMlmPmzKQOTBiGEdo1ljCYS38bO9Eito1+Kqn8yjO8LJdkz2lN79mgxJ
         1O2RItWq7sFd2i+pTrl5Ge6udrbw0aEDCZtNNkjFeM55+H4YQPYdBJERuHXim793jDPH
         wgTAxae6SExI7qhDWnlQCueQHESZ3h8Eu0KoagkF6Vi+wp78o43cWOqh8QdAAmtAHuSs
         c9CUASRSUzBwySMUAbzXElCYyrb/UcOWGuwY4aSurK43Hj3WiEhgRHBAufz/F/S2WrFY
         jBuA==
X-Gm-Message-State: AOAM533+4ypImG4WWZWvlVZg68SLVnXK9vn3WW6me+2pN7PgQJf0Gu5/
        /5tYQUPqfKiBi+ciq21g0fPbd3jAOWa9PLS6Mj8=
X-Google-Smtp-Source: ABdhPJxy+cM7kBVWxAA+ugnqMqouBGPHOzFVZ61aXsd955+JBz5RACu/gIdlNIhpWriyZT9ZZBYY3g==
X-Received: by 2002:a63:f960:: with SMTP id q32mr7226073pgk.3.1611109697559;
        Tue, 19 Jan 2021 18:28:17 -0800 (PST)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id np7sm267895pjb.10.2021.01.19.18.28.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jan 2021 18:28:17 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id 0706A20442D303; Wed, 20 Jan 2021 11:28:15 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     thehajime@gmail.com, tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v8 05/20] um: extend arch_switch_to for alternate SUBARCH
Date:   Wed, 20 Jan 2021 11:27:10 +0900
Message-Id: <89ce5467e30e16eb89f80173b473908d9e8151f3.1611103406.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit introduces additional argument of previous task when
context switch happens.  New SUBARCH can use the new information to
switch tasks in a subarch-specific manner.

The patch is particularly required by library mode, implemented as a
SUBARCH of UML.  Having access to the previous thread will be required
in the library mode for it to implement thread switching correctly.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/kernel/process.c  | 6 +++---
 arch/x86/um/ptrace_32.c   | 2 +-
 arch/x86/um/syscalls_64.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 2a986ece5478..9b0a36f64339 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -83,7 +83,7 @@ static inline void set_current(struct task_struct *task)
 		{ external_pid(), task });
 }
 
-extern void arch_switch_to(struct task_struct *to);
+extern void arch_switch_to(struct task_struct *from, struct task_struct *to);
 
 void *__switch_to(struct task_struct *from, struct task_struct *to)
 {
@@ -91,7 +91,7 @@ void *__switch_to(struct task_struct *from, struct task_struct *to)
 	set_current(to);
 
 	switch_threads(&from->thread.switch_buf, &to->thread.switch_buf);
-	arch_switch_to(current);
+	arch_switch_to(from, to);
 
 	return current->thread.prev_sched;
 }
@@ -149,7 +149,7 @@ void fork_handler(void)
 	 * arch_switch_to isn't needed. We could want to apply this to
 	 * improve performance. -bb
 	 */
-	arch_switch_to(current);
+	arch_switch_to(NULL, current);
 
 	current->thread.prev_sched = NULL;
 
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 2497bac56066..0f184710d4ca 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -11,7 +11,7 @@
 
 extern int arch_switch_tls(struct task_struct *to);
 
-void arch_switch_to(struct task_struct *to)
+void arch_switch_to(struct task_struct *from, struct task_struct *to)
 {
 	int err = arch_switch_tls(to);
 	if (!err)
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 58f51667e2e4..2ef9474d2bd2 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -80,7 +80,7 @@ SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 	return arch_prctl(current, option, (unsigned long __user *) arg2);
 }
 
-void arch_switch_to(struct task_struct *to)
+void arch_switch_to(struct task_struct *from, struct task_struct *to)
 {
 	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
 		return;
-- 
2.21.0 (Apple Git-122.2)

