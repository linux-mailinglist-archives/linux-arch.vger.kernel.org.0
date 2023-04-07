Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301286DB17D
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjDGRTB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDGRS4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 13:18:56 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068A4ED0;
        Fri,  7 Apr 2023 10:18:52 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-18412684c50so2166950fac.5;
        Fri, 07 Apr 2023 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680887932; x=1683479932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ci1K0OGiVqlrbjf6n+dt/e4BXEFqQkMZBWMsE/R76w=;
        b=RfnvkIgh4g0IwnKtSDMP8iexJYGY+Ke9FjJoeBQpiOmMoIqC3Hryed+uV4nzHnTU9/
         xrkB8FAuWLmgqTaey4MHxbIO/eHEJoGT1+BvgObcF2C3RykWIWfoFp+DCzCnz2Z/FeES
         EHSjZQ/BJfG88JskzGIdAY75g6dnEDdAHxHmEsbpQwLNhT5oxbHTS1R8mWarbdsdwJPT
         nhFIQb/gjRqAcSOxvWxcnFhwuQihKBXx4w57EVqdCTeWd+nk5ca2oU2Uy8pUbO9U6i6Z
         +mNzmqnzZ6PEzTCEI1l8HlQQ5H106EEHfRaLH4/VwG3jnhf1RL8kcXXObyqsc3ZzaHy4
         B9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887932; x=1683479932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ci1K0OGiVqlrbjf6n+dt/e4BXEFqQkMZBWMsE/R76w=;
        b=tryvQZt0Vp4QH/Q9dkIXRgEv9tgOV+LhPJYm3bmPSBRe6PCnpAd7npEDlNJwAiTRYL
         Mfcx7bpYz+4sZgIcpA4M0B0HoUa0ecXLWsSD7fzAPeoolY/xb34BxO2Aiez64KFscEyo
         82M6fViQtpNa+IEKvGI2DrMg9gXqd9v80TEfT0D6popyaMKjyENHvQMkqzGyrsQHWjjT
         z71wsvufv+CZmWWn/tqKQz+lWEAwnPx0ZlJZdJUstxU+tE5jOqz+bMNzNnr8I43/2zjq
         oLYYsoA7tpvuudVnQCRHRzx68RzjwKwtz9wSw9ZRtnr0xp8NyqQzyyJVU4U6O0/M5suK
         dvJQ==
X-Gm-Message-State: AAQBX9ewj99+kPgBUyDNZnqDSjsDZBi1Rd4Z0bqYjhmqMO1NPt0lc3zV
        W5LHvfu5QMIwFMJlHffVZ5Wx1yLlr9gXs3A=
X-Google-Smtp-Source: AKy350bObB0l+Qh6SdSADGp0fPGwtHdjk3zbGi0WJnsqEAKVYV+X8FOv8TKQxwcclwTj2zfryUhiAA==
X-Received: by 2002:a05:6870:55a0:b0:17f:f2e0:2e14 with SMTP id n32-20020a05687055a000b0017ff2e02e14mr2006391oao.16.1680887931843;
        Fri, 07 Apr 2023 10:18:51 -0700 (PDT)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d7349000000b006a2ddc13c46sm1816730otk.78.2023.04.07.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:18:51 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v16 3/4] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
Date:   Fri,  7 Apr 2023 13:18:33 -0400
Message-Id: <20230407171834.3558-4-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230407171834.3558-1-gregory.price@memverge.com>
References: <20230407171834.3558-1-gregory.price@memverge.com>
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
index 424f24350f8b..3af4e73b62b4 100644
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
@@ -120,3 +121,44 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
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

