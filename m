Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5127E6DB177
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 19:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDGRS7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjDGRSz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 13:18:55 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF4440FB;
        Fri,  7 Apr 2023 10:18:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso22363632oti.8;
        Fri, 07 Apr 2023 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680887925; x=1683479925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLteJQ8c+SN8oNJjCjxoIRPKFzLnI8skpOxBYxbnER4=;
        b=LVmzZcc4ItOFp3vZDq/gdzosshgwAr0ww023QcO3qkGDF6IeynqiyGwg7ts2NY5tox
         76VACvntsuvoCYA4nLD8by+CStm6RuBjW9vjyeaipcoX5Qv3EtCuqDjOikiI9rCRWrdo
         RMRNxSiMqqOvWvP/gpCwBRYGwWTWpNi+pwfXJyp1vS3GEWf2sRRLz9cuyTz4VDlisEkN
         0xz74QfUwmwtKygBH3eMGPDk8oyZzw3loY59ChPX51cOQZu4hGwNbK+q8RPisSSuR0Gb
         nrBOyqnKTMjmDFH2Q10OkRiUQ/ezc/iFG31UbVxY03eMy5rIWqlfDH+GztnizOEporb/
         BX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887925; x=1683479925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLteJQ8c+SN8oNJjCjxoIRPKFzLnI8skpOxBYxbnER4=;
        b=5WlC5F7qlR+atCK/RqYS4nx3DpUQSeNfHSUEFhOxdjawFDRYpQEolN6M1CaywnyDgh
         einqw9qLa/dpp6AvxRg3XPXgeDjYxfWyqdF66nrE0nT/PfC4pHFnBJjaJzu1GskF8Eeu
         zhvIxVZ+6ovhVEKDO2WXdh45yqYWyTZIp5u3jcFjh9I1nNcP98zI7/FCwYRurbVvZ620
         fzjSO/JO4xi+l3rP17EitJ7E6Isr9kzaDm41QkEuHSYy2x4F2ZuwNhmxS9sTheh4G7kh
         UrsmjUY8rgpQ6bzEg0fLmJIqA6cciokKSm1uuQSFSnyy03ZvNxmj/npGtqQlWR1Dfiqg
         KSCA==
X-Gm-Message-State: AAQBX9eoOb/HTni+9DZN7gVCVAP2+M9bN1HlaJLGvbBSlRIV4DpHezu3
        Uow36F5YCBpTi3hy4ko+CiLO5cgrXBb2kU4=
X-Google-Smtp-Source: AKy350Y/gKRvyuVHJithHouBOyeSoXFbnST168BAY2wAAOZ4E/7+p+xV2fEEc9gqgJuQo5C4vVAiQw==
X-Received: by 2002:a05:6830:13d8:b0:6a1:373d:b0a6 with SMTP id e24-20020a05683013d800b006a1373db0a6mr1212595otq.23.1680887925115;
        Fri, 07 Apr 2023 10:18:45 -0700 (PDT)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id l9-20020a9d7349000000b006a2ddc13c46sm1816730otk.78.2023.04.07.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:18:44 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, catalin.marinas@arm.com,
        arnd@arndb.de, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v16 1/4] syscall_user_dispatch: helper function to operate on given task
Date:   Fri,  7 Apr 2023 13:18:31 -0400
Message-Id: <20230407171834.3558-2-gregory.price@memverge.com>
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

