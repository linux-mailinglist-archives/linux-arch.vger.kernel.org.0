Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931AF207D66
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406590AbgFXUeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406582AbgFXUdd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:33 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E6BC061797
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 94so2105732qtb.21
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A7cPf0bNRtzZYfE1vc1rDopHSIr0k7cT2ZUm+OLZjv0=;
        b=QdroIDfhWPMl7iB8nPdG8F9r+Jm4224Qh0WRTBS1efFhFRpvTdOpw1Wqlz8qn+FYQH
         CFYve9pYyAVcIOznwtpq4QOlb+uiIUyfq16PYsXpTvWntxsZXcxPZ5lIUBkOt4NXo1Sm
         PFaSdzav1KtGvpCE5Ob7mVSvukaW8AVYgaIRlUr52jjyj1zFJ6R084rNzCDR/va5Iujh
         UoakKiURAbGW8xR0S2+Nw0cEeLy4uPMRYJtFclzKSks+5zyjfrBf44Qy3NgDTq9URhoR
         JWQuukFmtbdz9DrqDBlQZj0VkdPwnrqlxkdn89XzL10tIPUOY5/Zz6v6QbMuu+nDt0wT
         e8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A7cPf0bNRtzZYfE1vc1rDopHSIr0k7cT2ZUm+OLZjv0=;
        b=Q6vKdKnixwv0z5Zy/eDHpMTYwZVC7zi1gh69gClQVcpK+fFvRLOv/wGm4jAHGcWMQ1
         TCwiZyVTbAzWL4ZlLXdpbQUUqvHQxhh7hlYZXhAJNKr12q32tx6eG6I154br4wG5jC8M
         vQudgJQ0HUHYUN0txc83EzOOFMcbNcBPiKXRZi8jL5RkTLlccQlps/CSXtdvEnt8/fGr
         nH7ng9hkuk2OZxkbSyl8NJGaa2M8X9MHdGucTdtIw7MCZqpjNShTJ7AFKinii09aEReu
         N968w+DKuIEWXlFekMi8cwwnNDa2JMi28GB0ieXkNyuSQBw8UoDK7sEuDDUIY39fhfjm
         tudA==
X-Gm-Message-State: AOAM530rroujh/wbtknbT5rPDxLvqJvxfVboBt53gGRb53jaXW/ZeByC
        1CM2FfgGdRPYoYHWnoZWM6R0LSDMPzohZx+/sm8=
X-Google-Smtp-Source: ABdhPJzex3csdM9Cm9Zm5kqXnJN1Q6l9vC80id+c8eDzSpyHr7eNMt7lOs0z0JRAKDBh+QA/j3WYj56ZTQDnUtqmFPY=
X-Received: by 2002:a0c:fcca:: with SMTP id i10mr21455652qvq.150.1593030812853;
 Wed, 24 Jun 2020 13:33:32 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:57 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 19/22] x86, vdso: disable LTO only for vDSO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
CC_FLAGS_LTO flags instead where needed.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/entry/vdso/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 04e65f0698f6..67f60662830a 100644
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
 KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.27.0.212.ge8ba1cc988-goog

