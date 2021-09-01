Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35FB3FE630
	for <lists+linux-arch@lfdr.de>; Thu,  2 Sep 2021 02:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242506AbhIAXi7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 19:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbhIAXi6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Sep 2021 19:38:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE65BC0613D9
        for <linux-arch@vger.kernel.org>; Wed,  1 Sep 2021 16:38:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 7so170495pfl.10
        for <linux-arch@vger.kernel.org>; Wed, 01 Sep 2021 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ETte6Kips/PnFBmTfas2bMsUhjtMM1DpuPy9sky4cQ=;
        b=ZfscQN12kDgZwo+XD7Qpk9FvFCIEXtWXWcFlQXOJkK9ymiVGmdr0/mK6ZXA99ZlcR7
         4Nm1lKZ9Ci8k7YmchHIEm/DpVqRzi4aMjyIGBbF+gKldq2J6jxKFjw6RLFMJT8SSr7ed
         NKJzK+KGcbo8jGV1nCXwuYNW8hL40TfxTGykA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ETte6Kips/PnFBmTfas2bMsUhjtMM1DpuPy9sky4cQ=;
        b=jZqcWxyMUyCbF7WTagiUVHBxq0j6kqmsKLYs7FAAgHbrLe+cyslP2vP2nQv3Mzdoc8
         PeH1xHsykKJk0McPkHei34Bwu2zoz2uLAAiXIJe1vYJ9o5XMk151RqnFPxexL2ey4pqr
         FZ0sczjveA26mMWkg7kOP4Mv06PYOyRGnwUL9Qt6OX+FgItaakbuL7uX6nnPJdwjmA98
         TtDmZBbWdqmM8IFWzXLd82XjJh4QRr9+iBvxXhqaw8Pr+Qlgc5P594qfF+/0Kq092enB
         Pi4H8Oe54aRVBS/oqD+PH/pXIcskbcxGL+ik/bRkN0nQCmroqLyswRxntn7b/adJFpWo
         UEpg==
X-Gm-Message-State: AOAM531UvC5SJSM9II6C7uistOJm6d9KXV3d0aYbPeaAYFid+MnrFtP4
        S2769RN9/yPl72s/zmap/Kp9AA==
X-Google-Smtp-Source: ABdhPJyN38M4N8zPEc61Vz5vmqSEEQHThxwqCs/CcogxO5RCf7KsxkJklw+m1kaajPYi4UBOv7wwsA==
X-Received: by 2002:a05:6a00:884:b0:3ef:69c7:1264 with SMTP id q4-20020a056a00088400b003ef69c71264mr367454pfj.4.1630539480468;
        Wed, 01 Sep 2021 16:38:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l18sm84388pff.24.2021.09.01.16.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:37:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/4] vmlinux.lds.h: Use regular *RODATA and *RO_AFTER_INIT_DATA suffixes
Date:   Wed,  1 Sep 2021 16:37:54 -0700
Message-Id: <20210901233757.2571878-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901233757.2571878-1-keescook@chromium.org>
References: <20210901233757.2571878-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; h=from:subject; bh=jMRkqsYUYC0NP4Qv/R9OaLTgGjgQkzcbh3jh0B2PzXU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhMA7ULYltKgeAZ9HyjGCFBRAl7qioF9vacYWKi8nP va25hKaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTAO1AAKCRCJcvTf3G3AJvx/EA CeLXm7a58c122qvl0iZ2rUEVA0aPmh3IH0vAedkHUyG1wZC8ikNmZ9iYbgcQ9qxAABqeDTtRz0bBIk /C8YFJhRiWQObwvTjdaG959SgQb/tXfZQbeD+KPnyIVgoOnNj7rYEn6z8nFFnKw5T1/QdTgGn+CdsZ eQByYvVNXsoYuiGjGDVE1ZbTxeB+pdZe71ihgfhWVx2H8Ej+tPFwEM08nVropvk+HtU2TGe4xIvldA EG4zsL5iJ3jl9f3FU1fchY5RbsVUjGVupbPMBvlp0xN1QMDQU7Hv0kL8seGtOB7E4Of+/I01x0Fqbi /TTxZdLUb0Xqgwt8GGeXkhudNJKk0nIefhKAHUUF+uTxlFBght1Y7K5IhA+oFF5orJKrguQ5723F10 bhroz4zu2doCOOT/wrBdcraGxAfJLwg3ptdaRmGrJ33Hj4x7p/GKYt3F1bHtsJCYwKBZz4++nFrfpa RBLpCq1aegsmh5Z5p3qo6YRN0TQu+Nt5Q1ij5dFttLl2cytkOERXBzQ/xAXDhOKPjYMhRf+FEFcf+d Sx77tcwEKoMfbOruo0jx6hEHOavKZ2kdNIiG7noiStDka6V1WAu81G03XEX6DpCQB85qHUFtdgpEjO bvmY78GolJ2QA0RYL8b/xjUKNadvB3LBuiZz4HB1105G1ikJBWFlihNoj5wg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rename the various section macros that live in RODATA and
RO_AFTER_INIT_DATA. Just being called "DATA" implies they are expected
to be writable.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/kernel/vmlinux.lds.S    |  2 +-
 include/asm-generic/vmlinux.lds.h | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 63bdb9e1bfc1..93bc74c2a71b 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -64,7 +64,7 @@ SECTIONS
 	__start_ro_after_init = .;
 	.data..ro_after_init : {
 		 *(.data..ro_after_init)
-		JUMP_TABLE_DATA
+		JUMP_TABLE_RO_AFTER_INIT_DATA
 	} :data
 	EXCEPTION_TABLE(16)
 	. = ALIGN(PAGE_SIZE);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 62669b36a772..70c74fdf9c9b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -128,7 +128,7 @@
  * used to determine the order of the priority of each sched class in
  * relation to each other.
  */
-#define SCHED_DATA				\
+#define SCHED_RODATA				\
 	STRUCT_ALIGN();				\
 	__begin_sched_classes = .;		\
 	*(__idle_sched_class)			\
@@ -396,13 +396,13 @@
 	. = __start_init_task + THREAD_SIZE;				\
 	__end_init_task = .;
 
-#define JUMP_TABLE_DATA							\
+#define JUMP_TABLE_RO_AFTER_INIT_DATA					\
 	. = ALIGN(8);							\
 	__start___jump_table = .;					\
 	KEEP(*(__jump_table))						\
 	__stop___jump_table = .;
 
-#define STATIC_CALL_DATA						\
+#define STATIC_CALL_RO_AFTER_INIT_DATA					\
 	. = ALIGN(8);							\
 	__start_static_call_sites = .;					\
 	KEEP(*(.static_call_sites))					\
@@ -420,8 +420,8 @@
 	. = ALIGN(8);							\
 	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
-	JUMP_TABLE_DATA							\
-	STATIC_CALL_DATA						\
+	JUMP_TABLE_RO_AFTER_INIT_DATA					\
+	STATIC_CALL_RO_AFTER_INIT_DATA					\
 	__end_ro_after_init = .;
 #endif
 
@@ -433,7 +433,7 @@
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
-		SCHED_DATA						\
+		SCHED_RODATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
 		__start___tracepoints_ptrs = .;				\
-- 
2.30.2

