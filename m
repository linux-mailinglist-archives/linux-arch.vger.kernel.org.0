Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1618225CAA9
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgICUeR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgICUdK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:33:10 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6622C061A18
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:31:50 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r22so2942058qtc.9
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=z1oE9Ahlo6q+kOr1oYLTleDll+XTtOFOU5n4tP72oXo=;
        b=dhsXYaepDU3UMSsdIoiJQCPA2falNwv2qZU1/VdJQ1hXkiAnSpUZqf+Rk3qRL2tZAA
         RATqeMGpf2kMmoAJHONhUjAMV6PegNyYkc3QJaAVEVEcLCjBrBqX09ABdO5+mQ95+DDw
         f25F2G9jXfYk/9EQ2j5jmaiLccx+nM/z6pbas3dlrRF8URH6MyCoC/KP1gno65LWfHKJ
         Q6D2TJQFYwBZAepJLd9Yd28lqGFx1HWGm1ZuFChTdMhn1NuMfjTAvQ+mpiiVULLpvd2L
         Y9xqDVxLlVJb9OyiDxJrlsR9W0TKzMvmJcMqoguuNEejgNuP+L5/S3K+uSCWznAoXPfA
         ElDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=z1oE9Ahlo6q+kOr1oYLTleDll+XTtOFOU5n4tP72oXo=;
        b=T2Ri8BE4udGNbrrH/T0tRA3LpsSCMx+f8CYITPH8FuMBGVd3kmRDQoZeqjUyg1U6Hi
         IZEqj/fbF2VRkcy3f0RkIehLf8XqZJjFbxTwuMNzb2GmI6GCUqseNtmsXwNaFlfo43oM
         B03+MSmGjnHiPmwO7TcA16nn2Qglw/8fqF0z36hixvErjKtvNcTjKhqQA608LAAmm5Fg
         cwhB1+IAzWZvJusSunOhgzKHOPgdqrh1vZh3TP2zsk/r6mChfv2qIsuGETFI6Qtmb6mZ
         U0GdaKrg6Q5n5C3AnBOuOPwVTE7CbR6/l+KlwK1ra2zjAR5SFBVLdQ2VO/t3rRk5UJ28
         JgTA==
X-Gm-Message-State: AOAM530JrZnDLI6yQGmc1ioORdjsIcbm1NhqYoXVEhtjY07v4eIVfzEj
        qTiegDC4Wm9aTitbxxyWrRjDpqQRQW8ZHvNy4a8=
X-Google-Smtp-Source: ABdhPJyEGMuftj1qYs6R/OZbYPrPPMiyM+BRAtuMsdOJHhZ0hVrBwsv0OgWjQWUGye1drGkS4UUiW2tD7l2OoeX093w=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:d803:: with SMTP id
 h3mr3575787qvj.0.1599165109962; Thu, 03 Sep 2020 13:31:49 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:51 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-27-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 26/28] x86, vdso: disable LTO only for vDSO
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
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Remove the undefined DISABLE_LTO flag from the vDSO, and filter out
CC_FLAGS_LTO flags instead where needed. Note that while we could use
Clang's LTO for the 64-bit vDSO, it won't add noticeable benefit for
the small amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/entry/vdso/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 215376d975a2..9b742f21d2db 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -9,8 +9,6 @@ ARCH_REL_TYPE_ABS := R_X86_64_JUMP_SLOT|R_X86_64_GLOB_DAT|R_X86_64_RELATIVE|
 ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
 include $(srctree)/lib/vdso/Makefile
 
-KBUILD_CFLAGS += $(DISABLE_LTO)
-
 # Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
@@ -92,7 +90,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -150,6 +148,7 @@ KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.28.0.402.g5ffc5be6b7-goog

