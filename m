Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4DA27DAE0
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgI2VsG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgI2Vqu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:46:50 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E8AC0613D1
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:50 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q131so3659476qke.22
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wzTjCzGg3xaEC7ll/kCd4uRGsOqMFFvk2QDCKEKZJPs=;
        b=ZTQa+nx+ie2V6Hl+EgZ3b9a4nWf6aHDxI2ozXvg7twHaKP6+FN6wo15J3NYUHL6MZy
         J4Dd+alK6yoV9vbFjsbkRKSroxIwAfTac5LcIIobI37oTx5CMMXDG5PaPNUMt11LwL8e
         qaWpUR1BPcieUI39Ur38/bJEEGCMg2IEQV7e2ugbrGtg++DfsB4wweV1KXsP1t+8DXDm
         JeGZ4Z7BrxXuG2djrCReKQukEvOz+cyKSm1LRUENFyizVwreuzCNtUFRYYSNx4ge/Lh7
         V+phKEE5IsRMyJIFN5ljmvpZV5Qkvt76Ais9ZtPypytr0PvQL98a/0aQ5/yCoymbWkrC
         MGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wzTjCzGg3xaEC7ll/kCd4uRGsOqMFFvk2QDCKEKZJPs=;
        b=iQX4ztZ5pNK+a4HfW92rPQsIxNe5OPOjlMLvh/m0ZZypSs/t+4fP+/wjL/Enb/V5m2
         LeYXAAjCwXcQ7mMiFKJLcI5KuyB/i7H3ZqJLK4zuLuWymjna+wAUVVbseP0vYPqQZpYD
         BZksnGJ50UxI08R78B8Gb9usSmJXDghD2sFlFH5C4codwHBgy8DBrykNETLILCJmumji
         cNrN9P5IQnhRyIyORxC2Oi/zTTa7xYCen5kYfgbxSM4t7PesJ3bjMOGyFu2BLgbfGepc
         VF50rw5BIsSM3lKWj2/zBN4j0hg6KCf5sal+ss4UxEE/0mmvC9soSChbKqESxpQhBs3a
         A9DQ==
X-Gm-Message-State: AOAM5301krF28cJUh+hI6YvUbFDtnlwF1dLJdCUMm/7IkvE8igFiixZc
        awBj5DuE2Hz5vJPGQx667QUGl2f/S2niosvKdqg=
X-Google-Smtp-Source: ABdhPJz2ypRSC9mllfNnIhgyfpZXn6C3IOzuDT16CdCuKPyuF6U9OOcO8z3rZ0bOQ0QtPSPEFo5uPG0gQq+yj7Gtb6I=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:58e3:: with SMTP id
 di3mr6759116qvb.54.1601416009709; Tue, 29 Sep 2020 14:46:49 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:10 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 08/29] x86, build: use objtool mcount
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Select HAVE_OBJTOOL_MCOUNT if STACK_VALIDATION is selected to use
objtool to generate __mcount_loc sections for dynamic ftrace with
Clang and gcc <5 (later versions of gcc use -mrecord-mcount).

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..6de2e5c0bdba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -163,6 +163,7 @@ config X86
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
 	select HAVE_C_RECORDMCOUNT
+	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
-- 
2.28.0.709.gb0816b6eb0-goog

