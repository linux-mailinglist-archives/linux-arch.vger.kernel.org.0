Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0BF27066B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRUPo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgIRUPm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:15:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A552C0613D4
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d15so6783283ybk.0
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=oXJMXy02LqTQDpBkn8PPtjYwJPq4evUojZhZLMc3uvo=;
        b=REd95VnFXwmD3ND7Lapf6wTEKHlyfaSDlXa6A5g8OMe6rD7mXFuEioeTzTVuP+wKYy
         krseyNRuMtJa9ctfWr2TjaEjNcbStkBCBOxYrTttidotv9Qbdv5f70T8rfirifUlhiGO
         fbpwKXewIVSjSWcELClY8rHyvPgkF2XdC/QZF4KVfiVKi0xCd18r7fnei+hqOeW0nZel
         JhxqIwpbgtSIJrJ5e9QQl5CT7x9s7Yh2DeXazsVf3ebafU4M8/COaXTHkTmNbs2X65vv
         uvYLZii0pQgCywSqGr9bhM6Jz3cwSDm+sYfUU2OyMAh4+XaJbe4V1f+DGOyRxBJY+8Ct
         N4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oXJMXy02LqTQDpBkn8PPtjYwJPq4evUojZhZLMc3uvo=;
        b=hgbW3/rLcPKrfHn7RSZmHjQ7OiHVYbVQn/mnuQm48ctwrxEURk4tp03Tg6ZKqFCLgk
         KNM1rLEnlAChcpT7T0AbtWnRhgJMrt/NoSufIDdl6zNSj4oUskmrtQi8e8fsu1OoiG9g
         54GtY5txZLdBcbHC1dLkKUU5vVKs0XdOT9LpjtfovzSmLmKU8cIYM1n7XqcoUAevJwJP
         pLaIQhMP6y2aejEi307pYwfGo8IGb2TcALs1omDvGo+LB5gYAG3hxZ0l7PJGft0nUsWs
         8MIsGTO9gdg7tgPnRHt/r5q+RyCfppNso+gOlCCxeZBhQutfQhGV53V1SUNgOsP/YZbq
         Y2iw==
X-Gm-Message-State: AOAM530aWjHV4f6YS8IR6lvj4+f0EQOMm9SHEVdvRdjYTLY3C5LRArW5
        d/6ahWpH7+7Qm72ySQf/whSiDN4R7lemcDlqVvM=
X-Google-Smtp-Source: ABdhPJxMyDngZuNnNx1wL9/fMd7ntfJVtVGTW6/hjVnBGEbXwyy4OggBNEJrH2U3qB1vnImsc26NsteebpxVgOTzfOI=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:14c4:: with SMTP id
 187mr54928163ybu.449.1600460141424; Fri, 18 Sep 2020 13:15:41 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:32 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-27-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 26/30] KVM: arm64: disable LTO for the nVHE directory
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

We use objcopy to manipulate ELF binaries for the nVHE code,
which fails with LTO as the compiler produces LLVM bitcode
instead. Disable LTO for this code to allow objcopy to be used.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index aef76487edc2..c903c8f31280 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -45,9 +45,9 @@ quiet_cmd_hypcopy = HYPCOPY $@
 		   --rename-section=.text=.hyp.text			\
 		   $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
+# Remove ftrace, LTO, and Shadow Call Stack CFLAGS.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_LTO) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.28.0.681.g6f77f65b4e-goog

