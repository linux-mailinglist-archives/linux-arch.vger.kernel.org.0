Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81C86D10BB
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 23:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjC3VVt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3VVs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 17:21:48 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE29DEB61;
        Thu, 30 Mar 2023 14:21:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m16so15064614qvi.12;
        Thu, 30 Mar 2023 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680211305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLteJQ8c+SN8oNJjCjxoIRPKFzLnI8skpOxBYxbnER4=;
        b=iykmzulIMbse0iCb3oP8M4I/k54cZgd34u2hhDsdW2/bHFIPIukaDmopN8U07+Q0iY
         N3Cu42LC+E10+Etfpht1AeFG/lsgrl2llBs5fCQOTn4M0nDnNj8OH7F9RZGArwq6Ffx6
         wz+AqODSEQyod9lMrwR6EEXysh+NAETu/KXdPurGS+2Cv6ALsO5YrXHUwXJlrIUk8n2v
         r+CoYCOYOtcL/y0QEV6iHW/v1XkqO9gyjaMDiOLCWwnLINKSLvry+5abktd1VLCv+eAW
         b8bsejZm0R58OqQkNFa+Ve21cvqQeDFt7pS6Bo7Ae0yc2CoIOhcdHcoFk4ASugCAQ8Iu
         kg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680211305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLteJQ8c+SN8oNJjCjxoIRPKFzLnI8skpOxBYxbnER4=;
        b=EAfPdlERkoDOOvLs/Bo2icgymcuTqazagW5K1TkKBbLC/VT5Z8ZPF8GHa1BENUTENF
         st8oky81nMHvtnE+Vb2uUXTnVWMaJtzURxP8b4Ib1Wfzao8wULPVpSVDIq3lK/3Y8fku
         SPZ5qn7ORHIySM3/Kj6m6A24tUy9Ihvz64NfA1crWpWVk6d4ClEH4tWEe7fqw13JRM0H
         mxhJfJm6pBfK6EZnyvfp0weoL8H++UMFT96UkfkFQz88cdujq2v5Ve2Ub9C399NR5gZy
         1UfPokWPg15K2nY+hx5pwi7gLmZQVq4QONSN7ddGzYklCt1ftQHymSOH+RUlYNEde8md
         sVIA==
X-Gm-Message-State: AAQBX9dP/c3yzYzw0p7IloyDYN8XrimIoQ2VjmhkljOCq58NT8RGzGFW
        CwMIKzn7Z5zpVW8ITZll0cyYW2+TdK1Txfo=
X-Google-Smtp-Source: AKy350ZMYbgB5+tgHz0t5J99fzh1BMLaSZyr25TRFug0K29eoeNMmLUTohX4F2opjapF7lg2x9SZCw==
X-Received: by 2002:a05:6214:509b:b0:5df:4d41:954d with SMTP id kk27-20020a056214509b00b005df4d41954dmr12791662qvb.3.1680211305691;
        Thu, 30 Mar 2023 14:21:45 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id mx5-20020a0562142e0500b005dd8b9345desm110761qvb.118.2023.03.30.14.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 14:21:45 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v15 1/4] syscall_user_dispatch: helper function to operate on given task
Date:   Thu, 30 Mar 2023 17:21:20 -0400
Message-Id: <20230330212121.1688-2-gregory.price@memverge.com>
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

Preparatory patch ahead of set/get interfaces which will allow a
ptrace to get/set the syscall user dispatch configuration of a task.

This will simplify the set interface and consolidates error paths.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/entry/syscall_user_dispatch.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..22396b234854 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -68,8 +68,9 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	return true;
 }
 
-int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
-			      unsigned long len, char __user *selector)
+static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
+					  unsigned long offset, unsigned long len,
+					  char __user *selector)
 {
 	switch (mode) {
 	case PR_SYS_DISPATCH_OFF:
@@ -94,15 +95,21 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 		return -EINVAL;
 	}
 
-	current->syscall_dispatch.selector = selector;
-	current->syscall_dispatch.offset = offset;
-	current->syscall_dispatch.len = len;
-	current->syscall_dispatch.on_dispatch = false;
+	task->syscall_dispatch.selector = selector;
+	task->syscall_dispatch.offset = offset;
+	task->syscall_dispatch.len = len;
+	task->syscall_dispatch.on_dispatch = false;
 
 	if (mode == PR_SYS_DISPATCH_ON)
-		set_syscall_work(SYSCALL_USER_DISPATCH);
+		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 	else
-		clear_syscall_work(SYSCALL_USER_DISPATCH);
+		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 
 	return 0;
 }
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector)
+{
+	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
+}
-- 
2.39.1

