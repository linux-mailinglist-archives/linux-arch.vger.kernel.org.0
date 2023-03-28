Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921F96CC864
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 18:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjC1Qsi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 12:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjC1Qsg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 12:48:36 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28041FF0A;
        Tue, 28 Mar 2023 09:48:31 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id jl13so9568397qvb.10;
        Tue, 28 Mar 2023 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680022110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MSgvZ1AdLZ5rN/msTlixixv7yFUHo9a9aYlwCpOQS0=;
        b=TFKDfu7AyDaoxVx/TELNi6ZfXH6j8XDMudGBOlXDuPp09A7ZwB4KOReGpIjx9jFhfc
         9697j7pSP4Gp1liYW1GubTTB2qxOOcAaGiSin4VbUNR3ehGch6pHoHglhvJ7LxcMvRQH
         sOH6rYZV4D7G5jIafNF7uF7WbvfdqcX84juPsMiWLvUPeKTCmUSBrKf7RQTdEN29Zgjn
         6xy6ZQWyXRDkmNQNv1h6jcI95jgO5haWDRJjU/SvCCzs2NGmDgL21exqFk/tMaRKH96m
         8mGWD6UGJp4NGCH5MwJFjc5z0nWsDV5O+vi91RH8z4af3kKA8vKJ57R04k1G6D8DRxzP
         nCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MSgvZ1AdLZ5rN/msTlixixv7yFUHo9a9aYlwCpOQS0=;
        b=2nm4IYT2PbdoVztLDg7x1d8KJcLL8A+fT/NjuUFl/k4hM49AOkC5VB1tltmvZD59nC
         EH50abuCw9fDy7gx67Nmy/Lca9ybi378Vo6Kih98Hy1wIa3a3H84AJ1tXA5fP2EJ5qZr
         wTb/FVNVDCE4nMuQlerca/y7TppSvO7bC2Db0Z/VseGtuDlTwVKo8+/kWlltgaGfJbyE
         nUfLalCLFqgBcm6yr4vhdEvYrWsJeJB3CDUbuKE4V5KGW3oaxtDIvYu/nI9MzIhltuQ2
         /UXO+sXWnDG0c0mEs0r9aQE2l+wZncG3I/zWi/Wi8ZLHAPcZIVjp7dx1o3i4LYrhb68w
         4cyQ==
X-Gm-Message-State: AAQBX9ekAJKE34Gx5hwZEgdfSsQbs+PXsbXt3v5Cl1Wpixl92JRctft2
        o3ugBc4v35m4abXlgOLb+RjjdDXgzq1p2qY=
X-Google-Smtp-Source: AKy350ZGeODt/q6XLF5itOlCrARX4xZmTMjMA6fX1++UdyVE7kfImZTOyUL8rUNz4nVj5s9x5lVCNw==
X-Received: by 2002:a05:6214:f67:b0:5aa:d98a:8ace with SMTP id iy7-20020a0562140f6700b005aad98a8acemr30602846qvb.19.1680022109939;
        Tue, 28 Mar 2023 09:48:29 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id qh16-20020a0562144c1000b005dd8b93457bsm3938206qvb.19.2023.03.28.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:48:29 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        catalin.marinas@arm.com, arnd@arndb.de, will@kernel.org,
        mark.rutland@arm.com, tongtiangen@huawei.com, robin.murphy@arm.com,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v14 1/4] asm-generic,arm64: create task variant of access_ok
Date:   Tue, 28 Mar 2023 12:48:08 -0400
Message-Id: <20230328164811.2451-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230328164811.2451-1-gregory.price@memverge.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
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

On arm64, access_ok makes adjustments to pointers based on whether
memory tagging is enabled for a task (ARM MTE). When leveraging ptrace,
it's possible for a task to enable/disable various kernel features (such
as syscall user dispatch) which require user points as arguments.

To enable Task A to set these features via ptrace with Task B's
pointers, a task variant of access_ok is required for architectures with
features such as memory tagging.

If the architecture does not implement task_access_ok, the operation
reduces to access_ok and the task argument is discarded.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 arch/arm64/include/asm/uaccess.h | 13 +++++++++++--
 include/asm-generic/access_ok.h  | 10 ++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5c7b2f9d5913..1a51a54f264f 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -35,7 +35,9 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
  * This is equivalent to the following test:
  * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
  */
-static inline int access_ok(const void __user *addr, unsigned long size)
+static inline int task_access_ok(struct task_struct *task,
+				 const void __user *addr,
+				 unsigned long size)
 {
 	/*
 	 * Asynchronous I/O running in a kernel thread does not have the
@@ -43,11 +45,18 @@ static inline int access_ok(const void __user *addr, unsigned long size)
 	 * the user address before checking.
 	 */
 	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
-	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
+	    (task->flags & PF_KTHREAD || test_ti_thread_flag(task, TIF_TAGGED_ADDR)))
 		addr = untagged_addr(addr);
 
 	return likely(__access_ok(addr, size));
 }
+
+static inline int access_ok(const void __user *addr, unsigned long size)
+{
+	return task_access_ok(current, addr, size);
+}
+
+#define task_access_ok task_access_ok
 #define access_ok access_ok
 
 #include <asm-generic/access_ok.h>
diff --git a/include/asm-generic/access_ok.h b/include/asm-generic/access_ok.h
index 2866ae61b1cd..31465773c40a 100644
--- a/include/asm-generic/access_ok.h
+++ b/include/asm-generic/access_ok.h
@@ -45,4 +45,14 @@ static inline int __access_ok(const void __user *ptr, unsigned long size)
 #define access_ok(addr, size) likely(__access_ok(addr, size))
 #endif
 
+/*
+ * Some architectures may have special features (such as ARM MTE)
+ * that require handling if access_ok is called on a pointer from one
+ * task in the context of another.  On most architectures this operation
+ * is equivalent to simply __access_ok.
+ */
+#ifndef task_access_ok
+#define task_access_ok(task, addr, size) likely(__access_ok(addr, size))
+#endif
+
 #endif
-- 
2.39.1

