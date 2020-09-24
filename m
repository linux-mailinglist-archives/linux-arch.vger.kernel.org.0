Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5F276A57
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 09:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIXHOq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 03:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIXHOp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Sep 2020 03:14:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F73C0613CE
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md22so3879244pjb.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 00:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaZaINJO8RTX0sihp8PXPyj8BsV/dJ4sIfFZwNQgCoc=;
        b=C41INqRQL9wXKNEMfa2Cq9gnH6tyU2aaAcWC397Yxc+X4rbSPPDuT66/6sfi0KWWiT
         AV3W/hiYgfEi7XEvgRLQHFGN+ClX5VSYAGb+czXbF0QvJFcUcEy8uC8efnlgsJxn6QwE
         wExB+u9FVWDObRSI8l6Yn6/IWedlC0TTpsCC/yHTLrr9ayV5jt/FiPRL0YbuzkF3zp/9
         z7A1A/C+OQeVCNntpiqOrcndO4LluVX7E/gAthh1z6+i8ZgFHrCTPYuJ7cHctzeIz1Kl
         maTHGbAbHeMgLeIg1DQRmAwQU1GCGzRdTqETNRbZMscyGlhpQ3VWu8JlIzBcZVG4nsij
         Hlqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaZaINJO8RTX0sihp8PXPyj8BsV/dJ4sIfFZwNQgCoc=;
        b=ilYK7AhSI9iQDwH0WFJcQLpJ/RZitC6CWP/VDgBQmxLiYQG7p4XehkAJbPQ9LgK3cw
         pivhXwTynaLUvHJvD4W3Km2MSaYHzGltP+B/WVv/eX3MQUyhFgQrlQrrMrnlNE/l4TIO
         9+8SjnpttATwMrNPYLvhysctPuD/h5w69KYqZH5tFHDNemz/bjU9/OaEmfRGIqNQJBG1
         rLls1jWyULmL1E+EEA50YNIfzN27kQfThx1dPTOJxsgUD8JAqnTIubsZ6OQjqAyh1/rr
         jaagjYkuhWlQKPu/EDjbZ1Rf/0ZIqE19sO8SnLdw1bRWGNSRi3ERsMN2FCuTLg72/0yb
         tNhQ==
X-Gm-Message-State: AOAM533CnOBpIuzdBF4UuCbd4r+f1XlAfSAFCbX3VeBr9AnVlzCihzQ9
        kOpfk7z/AFJphjgyFlP6xeY=
X-Google-Smtp-Source: ABdhPJzq28mbtDOOoVJ8ZaXyYQry4wEm+ND0PGC2ggHIOU4euhMPSKxxXqQqIPUN5c589bjLvrdp5A==
X-Received: by 2002:a17:902:ba8c:b029:d1:e5e7:be6a with SMTP id k12-20020a170902ba8cb02900d1e5e7be6amr3375156pls.68.1600931685359;
        Thu, 24 Sep 2020 00:14:45 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id v8sm1950402pgg.58.2020.09.24.00.14.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Sep 2020 00:14:44 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id 0CC762037C2080; Thu, 24 Sep 2020 16:14:43 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v6 07/21] um: extend arch_switch_to for alternate SUBARCH
Date:   Thu, 24 Sep 2020 16:12:47 +0900
Message-Id: <4a3090dbb622a5892739573441bbc12a1a849330.1600922528.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1600922528.git.thehajime@gmail.com>
References: <cover.1600922528.git.thehajime@gmail.com>
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

