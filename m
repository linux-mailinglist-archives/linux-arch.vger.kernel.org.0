Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622536CC868
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjC1QtD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 12:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjC1Qs5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 12:48:57 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91628FF12;
        Tue, 28 Mar 2023 09:48:42 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id 59so9546383qva.11;
        Tue, 28 Mar 2023 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680022121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVa9X4+U46dv8ddg80vzrci4Qva7OylZ3ISRVVgdS3k=;
        b=kT91V+MSEdKHysqveIPZRaQOd/MtGEAafkphfYEEsdGfSg/DZRxh5/YVgmMRzHaElT
         WlzqttN8rKgj9GcaTOUmd44y4UGZQ1HDVy3c6zQP0FPamEyBCrXyThbieirJ1eLj6XDV
         cL26XEf6ngnb+2mPx4CMZHJodZ6cuapP0Kw4+uaasgJ9Cj7gli1U5NHUMzVTC9xfKioA
         XzLQS5JXx5S8vo7ikCWbr5z3eL1RDy2cO3ukSKQEDvds8tGHDZEAuve/2D2n8UhZTmRU
         j/3DTqKmln6nJqL2Yq4/V0Dbb+z/rKQxrENXNpg06krHnBsVtaXD7TsXfludlbMYIUoj
         C+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVa9X4+U46dv8ddg80vzrci4Qva7OylZ3ISRVVgdS3k=;
        b=hX2IdZVIzVnRb2iKoBVUDxqA6fDe4lF8pNdzU2MwTRAUrbYe9gBZf5X3mJKaBclTlV
         htGf281keGWU50wi7oANxZrL10iOidgtcVdCx6pf/2KKquVfQF/9v929+guyPaHnN8A3
         7Jw+WH2XZYAqVuepnGyr4xA9rkodgvuA50W5+8hoQWpTgdAf20jefyiBBvSdgRFcgU40
         BJimZJS1jWv14ZjPdTMWMU/SU4cWvO0FbjSSD+H/e4yjo9UMhuo1e7pOh/d6fbb0eaDe
         +EBRgybRoVsPWlssIRQ6ReRgZbTkjszdZ2AXHf84zfPfP5qehwUBo+ffqVYCDg8mIrjZ
         2gYg==
X-Gm-Message-State: AAQBX9edf4d+s5f0KgiIlkkEIVL4YmIzNJUWY859N/sYYLbvVOyRF7u6
        mChEm56158cNXfUCMr1pDKMnRLMz/ryK93A=
X-Google-Smtp-Source: AKy350b29oHMXdwrn0l648ob4vUwtqt1hthIT/j/AB8gBF9oPb+kMXLeaxt+i4m6e8o37u+9RymQsA==
X-Received: by 2002:a05:6214:1d2f:b0:5cc:4776:5ac0 with SMTP id f15-20020a0562141d2f00b005cc47765ac0mr30560609qvd.19.1680022121352;
        Tue, 28 Mar 2023 09:48:41 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id qh16-20020a0562144c1000b005dd8b93457bsm3938206qvb.19.2023.03.28.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:48:41 -0700 (PDT)
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
Subject: [PATCH v14 2/4] syscall_user_dispatch: helper function to operate on given task
Date:   Tue, 28 Mar 2023 12:48:10 -0400
Message-Id: <20230328164811.2451-3-gregory.price@memverge.com>
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

Preparatory patch ahead of set/get interfaces which will allow a
ptrace to get/set the syscall user dispatch configuration of a task.

This will simplify the set interface and consolidates error paths.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/entry/syscall_user_dispatch.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..a0624c3cda75 100644
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
@@ -86,7 +87,7 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 		if (offset && offset + len <= offset)
 			return -EINVAL;
 
-		if (selector && !access_ok(selector, sizeof(*selector)))
+		if (selector && !task_access_ok(task, selector, sizeof(*selector)))
 			return -EFAULT;
 
 		break;
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

