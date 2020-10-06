Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C9928498D
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgJFJpT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFJpS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:45:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205DC061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:45:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id az3so1290223pjb.4
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaZaINJO8RTX0sihp8PXPyj8BsV/dJ4sIfFZwNQgCoc=;
        b=iDutgVKU+RuELbHJdKB+mUNqu0z+InLUy04Ug5vpk0bRvHNrV2/1OS7w3cYJcj6bOc
         N01rNJVdXI1u2YVqdiDVpO0Gg5On8sWtoVbJajhp8l/D6zlasxzdTJbnCZvU75IKD0Y6
         7mpJDE1EiD7dlesuHdOJkdT6mf+aCbkCuZBthZuF907gVI/XpKLFMa6Y+ONkZ1SskQRc
         S4jQfLooCybF4Amzfrtfl/4xKniAkfdKrSlAnF4MCiDWh7WEjESfRtaAp8rAjXKQnE+O
         F/tDn7qMgWJsSNKWZno24ge97QDEmTVUiYtG7/XDda5RYI9yTXa+jX4v/lA0/CN1bZse
         KW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaZaINJO8RTX0sihp8PXPyj8BsV/dJ4sIfFZwNQgCoc=;
        b=RKBHxwGRhUxKXPTSu04Q6vyvruuBrdI9aIgTxKmgKyboX+EXKlLh4TYMiV8jPNjraO
         E2H586dpCy/nonZmUxNf3lLo7aP8RWIf9jfK98DYPIHrO6gcLVN4gOFnfXlcbPRM5uFv
         AJpPY04YFzjGcEqDvy+yy1oe+Pai6nhHNJTV7lkaBOr6N9TfiC9ziH1k9hwrliVe7JiV
         qMxO3jaYkmGJ0tEp2TLdlkd8d4uif7wAYScdcMMJFVkOr756FuHxYlYzx+HtB4hzaVzf
         erraDnoBrOtZQ/bd5yy/7gqdUFXZBlBmWNUXEGnYrudBWL7O/xHmSV5YgD+ELkO8/qoQ
         2+WA==
X-Gm-Message-State: AOAM532TaeMNspw0sFoLqWGmlhmuOT6NVU4tJZmQA7CHiXEFA0YJvUon
        6nRqXOhrfipO0WJtbaefFug=
X-Google-Smtp-Source: ABdhPJxnkUNK0fLV4EjnHB2bvG0A+iHU3juyWOxK9gWkhPhdSj+qlYSQXSQBdM23OjyUI3PWca92vA==
X-Received: by 2002:a17:90a:ba8d:: with SMTP id t13mr3451578pjr.38.1601977516759;
        Tue, 06 Oct 2020 02:45:16 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id e11sm2919216pfl.58.2020.10.06.02.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:45:16 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id EF1B620390F4AC; Tue,  6 Oct 2020 18:45:10 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 07/21] um: extend arch_switch_to for alternate SUBARCH
Date:   Tue,  6 Oct 2020 18:44:16 +0900
Message-Id: <d4a65be8d05d945885f53bc168fd85f08e72adf1.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This commit introduces additional argument of previous task when
context switch happens.  New SUBARCH can use the new information to
switch tasks in a subarch-specific manner.

The patch is particularly required by nommu mode implemented as a
SUBARCH of UML.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/kernel/process.c  | 6 +++---
 arch/x86/um/ptrace_32.c   | 2 +-
 arch/x86/um/syscalls_64.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 26b5e243d3fc..87a8cfa228ca 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -80,7 +80,7 @@ static inline void set_current(struct task_struct *task)
 		{ external_pid(), task });
 }
 
-extern void arch_switch_to(struct task_struct *to);
+extern void arch_switch_to(struct task_struct *from, struct task_struct *to);
 
 void *__switch_to(struct task_struct *from, struct task_struct *to)
 {
@@ -88,7 +88,7 @@ void *__switch_to(struct task_struct *from, struct task_struct *to)
 	set_current(to);
 
 	switch_threads(&from->thread.switch_buf, &to->thread.switch_buf);
-	arch_switch_to(current);
+	arch_switch_to(from, to);
 
 	return current->thread.prev_sched;
 }
@@ -145,7 +145,7 @@ void fork_handler(void)
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

