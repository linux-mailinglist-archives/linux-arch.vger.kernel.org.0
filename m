Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB0E2125A2
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgGBOIm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 10:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbgGBOIl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:08:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97998C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:08:41 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so13522976pgk.4
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmaMOyI4gVFLhkvZqmlbu3s7en5DC1VB33ig6KFywwM=;
        b=TOKMySl/M3uj9spWbSQtCzFyFN9luVKCupJB6TSsZ86JwtmH7UMBw8WHlZwgfAsCi+
         NgRoRwKqVKBnGWKSpDDFlmaNDHYeW77Y9oWBXPzrsRSzoxqj5nwo+tps039WQ43cYXZT
         IdbVntkZexSxLIFDrbbUwV4Ze17oQDMsGar09LttdaJkEm3+t79HFzYchTczFC8ZNegK
         YqWFENReq69Ofmu2Sz2SvuhVkKbCvEdrRyQBP+IVfvdtZoSGvoBnLCVh0vluLImz2sbI
         5mGEHkpqn1k53ngqv/QiSMAeXiVQPUdKlsxJnCAmyKRfpT0SgDCPpp23SLxc4tHfbFo8
         ZBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmaMOyI4gVFLhkvZqmlbu3s7en5DC1VB33ig6KFywwM=;
        b=WUzCkpaVo01YlwB3BmutqnNydFxczygISxFfMb6ZOVPie65adUIy0Q1yPZ289eFFVf
         tSrwpHURB/HGz+h+K2AItB+qnRzYxOwR1bVVMAzSRhWbs5Nd81XbujNDSjadP1ItiaY/
         kZcCLn/8TeZUno/oCS2tKM1pxFlHh1i+lJ+JpZBX2W1NMDJH0CTAFu+CHup+T31N1czR
         5N7WY9+h24AuNYE8Lwq/nO6KvGNBtsqXHVGATJVFe9O3ogCQcYxdRuD/IHz2g/chxUaA
         tUkNhF+o6R2lFFIaRAQ3ayTxWZPFgbfqFgLhhDfce2KjJMvkT+m77abrY7gjNTZjrXav
         niaA==
X-Gm-Message-State: AOAM531/g31Bxars8X2c+ZkDlrgdQTYXKeYHhNCLhwYnzn8NgdYcAGUo
        FCNcH3Ft/V1ld2rG6eM8hv8=
X-Google-Smtp-Source: ABdhPJzlVgYXgph7rRiCP7qA5lW9hIyQ+spVWF51Lbi4fWlj0gD+8CyahX5l5SnTU4qgwr9MD+X7BQ==
X-Received: by 2002:a63:2c4:: with SMTP id 187mr24948972pgc.367.1593698921008;
        Thu, 02 Jul 2020 07:08:41 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id g140sm8947237pfb.48.2020.07.02.07.08.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 07:08:40 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id AF165202D31D1E; Thu,  2 Jul 2020 23:08:38 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 07/21] um: extend arch_switch_to for alternate SUBARCH
Date:   Thu,  2 Jul 2020 23:07:01 +0900
Message-Id: <fa68d878ff34be60075693cd19ad2bec63dec788.1593697069.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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
index cbe33af2a880..e5238a42ea17 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -81,7 +81,7 @@ static inline void set_current(struct task_struct *task)
 		{ external_pid(), task });
 }
 
-extern void arch_switch_to(struct task_struct *to);
+extern void arch_switch_to(struct task_struct *from, struct task_struct *to);
 
 void *__switch_to(struct task_struct *from, struct task_struct *to)
 {
@@ -89,7 +89,7 @@ void *__switch_to(struct task_struct *from, struct task_struct *to)
 	set_current(to);
 
 	switch_threads(&from->thread.switch_buf, &to->thread.switch_buf);
-	arch_switch_to(current);
+	arch_switch_to(from, to);
 
 	return current->thread.prev_sched;
 }
@@ -146,7 +146,7 @@ void fork_handler(void)
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

