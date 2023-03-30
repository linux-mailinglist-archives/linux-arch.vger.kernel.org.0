Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045216D10C0
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjC3VWJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 17:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjC3VWF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 17:22:05 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABACFE1A0;
        Thu, 30 Mar 2023 14:21:57 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cu4so15179275qvb.3;
        Thu, 30 Mar 2023 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680211317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG+Iy1MaoacZM8Qd8wPjhJaybRZBo3by253KPOnH+qo=;
        b=NtiY7fM6rTs6Krop7ncc4JmZVBbxJjCPAbLPKAQ+y8qMumn7zPEeX7UAeD68kgWIFT
         w7/V/ybxQo5SlLpelR8DRxCLaeDwQxtDinlifDsCcuP+StTR2bLc+Pxic8tDQV7XpQMU
         a56jBGJ70Xxqb4eYpGv13ha5TaDOWZYnBnWx4mpK2LIxHfbdBR32sqsU8xStz7rj1l7g
         oUIL4PObOVyfiYYz8SLiJJ7JVUX6PgZVjDw2qybDIjD+NJ/JI0tRpY9dcM56hcBBe1nB
         AWRQqeexhh/EUKBLUXyCqydZbyPWwoguiWX5r2WstJzhuLJuZW5hy8Mb+XWzNoOg9/sD
         wBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sG+Iy1MaoacZM8Qd8wPjhJaybRZBo3by253KPOnH+qo=;
        b=YOm6APCGhKo0dls+OctymwN2DTvdwv1RHJYwcVYiEOJaQwFMZmjmGvbcxPj+7iZBHC
         ELwEVavOY25DTM6pkr6Bqzl+QTq7lnYIaUfNbel2+HZT4I0Koc7OtG3J4enxp2mwDX/J
         PTMy6qooLM1YL9rwpLYalCeF5ByrZikKrKWQWt0+FTAG3DDD8tIbDtI8f003EhlhnJbF
         l/R5NfzRMSZj6JehkqhLIgsOnJehp3o7CDfojM4kO/3aFu/nMVxX/ofICp/kaoI8UmWA
         s/2rv7kXU9abbS+UyfsBb+ZuZPOR8auRSVnYqfeK0gLmm4x29GMGkI2zW7/OjzJTF2Jl
         Izqw==
X-Gm-Message-State: AAQBX9e2umzq+9fGICGfIEoeM1ZF627s/uS4cqSUwDSIw7bUy3lSt3Jd
        fWIDD9N4prAr1CSD/7fDBiEilN/7fhp9PVU=
X-Google-Smtp-Source: AKy350bcM8BtdOfb0fvnABNxpF10oV64XEWQJwwziYlYZUwLSNXYEpgHfkeFElq0yGlOqqyk3spnZw==
X-Received: by 2002:a05:6214:487:b0:5dd:af47:eb06 with SMTP id pt7-20020a056214048700b005ddaf47eb06mr46610717qvb.12.1680211316739;
        Thu, 30 Mar 2023 14:21:56 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id mx5-20020a0562142e0500b005dd8b9345desm110761qvb.118.2023.03.30.14.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:21:56 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v15 3/4] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
Date:   Thu, 30 Mar 2023 17:21:24 -0400
Message-Id: <20230330212121.1688-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230330212121.1688-1-gregory.price@memverge.com>
References: <20230330212121.1688-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement ptrace getter/setter interface for syscall user dispatch.

These prctl settings are presently write-only, making it impossible to
implement transparent checkpoint/restore via software like CRIU.

'on_dispatch' field is not exposed because it is a kernel-internal
only field that cannot be 'true' when returning to userland.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 .../admin-guide/syscall-user-dispatch.rst     |  4 ++
 include/linux/syscall_user_dispatch.h         | 18 ++++++++
 include/uapi/linux/ptrace.h                   | 29 +++++++++++++
 kernel/entry/syscall_user_dispatch.c          | 42 +++++++++++++++++++
 kernel/ptrace.c                               |  9 ++++
 5 files changed, 102 insertions(+)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index 60314953c728..f7648c08297e 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -73,6 +73,10 @@ thread-wide, without the need to invoke the kernel directly.  selector
 can be set to SYSCALL_DISPATCH_FILTER_ALLOW or SYSCALL_DISPATCH_FILTER_BLOCK.
 Any other value should terminate the program with a SIGSYS.
 
+Additionally, a task's syscall user dispatch configuration can be peeked
+and poked via the PTRACE_(GET|SET)_SYSCALL_USER_DISPATCH_CONFIG ptrace
+requests. This is useful for checkpoint/restart software.
+
 Security Notes
 --------------
 
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index a0ae443fb7df..641ca8880995 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -22,6 +22,12 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 #define clear_syscall_work_syscall_user_dispatch(tsk) \
 	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
 
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+				     void __user *data);
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+				     void __user *data);
+
 #else
 struct syscall_user_dispatch {};
 
@@ -35,6 +41,18 @@ static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *
 {
 }
 
+static inline int syscall_user_dispatch_get_config(struct task_struct *task,
+						   unsigned long size, void __user *data)
+{
+	return -EINVAL;
+}
+
+static inline int syscall_user_dispatch_set_config(struct task_struct *task,
+						   unsigned long size, void __user *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_GENERIC_ENTRY */
 
 #endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..1e77b02344c3 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,35 @@ struct ptrace_rseq_configuration {
 	__u32 pad;
 };
 
+#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
+#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
+
+/*
+ * struct ptrace_sud_config - Per-task configuration for SUD
+ * @mode:	One of PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF
+ * @selector:	Tracee's user virtual address of SUD selector
+ * @offset:	SUD exclusion area (virtual address)
+ * @len:	Length of SUD exclusion area
+ *
+ * Used to get/set the syscall user dispatch configuration for tracee.
+ * process.  Selector is optional (may be NULL), and if invalid will produce
+ * a SIGSEGV in the tracee upon first access.
+ *
+ * If mode is PR_SYS_DISPATCH_ON, syscall dispatch will be enabled. If
+ * PR_SYS_DISPATCH_OFF, syscall dispatch will be disabled and all other
+ * parameters must be 0.  The value in *selector (if not null), also determines
+ * whether syscall dispatch will occur.
+ *
+ * The SUD Exclusion area described by offset/len is the virtual address space
+ * from which syscalls will not produce a user dispatch.
+ */
+struct ptrace_sud_config {
+	__u64 mode;
+	__u64 selector;
+	__u64 offset;
+	__u64 len;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 16086226b41c..f0aa25e34622 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sched.h>
 #include <linux/prctl.h>
+#include <linux/ptrace.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/uaccess.h>
 #include <linux/signal.h>
@@ -124,3 +125,44 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 {
 	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
 }
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+				     void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+	struct ptrace_sud_config cfg;
+
+	if (size != sizeof(cfg))
+		return -EINVAL;
+
+	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
+		cfg.mode = PR_SYS_DISPATCH_ON;
+	else
+		cfg.mode = PR_SYS_DISPATCH_OFF;
+
+	cfg.offset = sd->offset;
+	cfg.len = sd->len;
+	cfg.selector = (__u64)(uintptr_t)sd->selector;
+
+	if (copy_to_user(data, &cfg, sizeof(cfg)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+				     void __user *data)
+{
+	int rc;
+	struct ptrace_sud_config cfg;
+
+	if (size != sizeof(cfg))
+		return -EINVAL;
+
+	if (copy_from_user(&cfg, data, sizeof(cfg)))
+		return -EFAULT;
+
+	rc = task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset, cfg.len,
+					    (char __user *)(uintptr_t)cfg.selector);
+	return rc;
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..d99376532b56 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1259,6 +1260,14 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 #endif
 
+	case PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_set_config(child, addr, datavp);
+		break;
+
+	case PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_get_config(child, addr, datavp);
+		break;
+
 	default:
 		break;
 	}
-- 
2.39.1

