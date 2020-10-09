Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146A2288E55
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbgJIQPX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389863AbgJIQPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:15:08 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903DC0613BD
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:14:34 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j5so7121504pff.6
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hXDRuVDCt6QcdhcOoOZPfzkgSyHjAxTz3vM4hOZGaOg=;
        b=Of/McM9MKCVt3xMTzgE2jLFxrK6HLM9gHntYJNTcjy9ApZaKHz0NdjwbrXXqJ0KeXL
         QILhcYMJykX0DmdfDMEtd1i9+jSTop+Teol7A0HSxWBP/JcipzZjeYHbk2YDLsmk1NQ5
         G2UUcHyxFMpvulEN8vXHpV9R6Nt0Bh4/MBsRvGu0XRXB7N2md6vLGW5FRJ7LZH5lBvgB
         pDYYRrNjX76WD2872VTFDZDZcdeeeYnq5VF5RlcVhEUVYIDLvVOw1Myce0txxTVpNib1
         ITGnOYce1pEF2cgi2zX7oPIqItMYk/+MigcROat7aHTJYH0uDLF+ZV1tegP02Tx/IS94
         4skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hXDRuVDCt6QcdhcOoOZPfzkgSyHjAxTz3vM4hOZGaOg=;
        b=umglxriairaaNkGcsw8WhJZCv9sHm9wvikTHVwmJb5AUhpJ/Ip5lpEVnA3TWyeokQq
         xrXDWbuVkyhMr1EWIAfI4P0hCWgLiuo54XCgvaDavQNPm7cyS+9C0nq6bqz9iXr0gvUV
         EppvU0n9Np1HiR2jKBuYkCV0jMnI+biibBLSrtYng528vBuQJTHYVqk/rQvIzBWIfuBR
         6tMP7w4AY8PvqNekQei2DFR6qI8tDeb1lX2VGVhfVJWFs2yZwPeDWSnt0yQOM0B2XH8g
         9tGuHCLGu+GJ9Rh9knwzdSj7jGl+qzc74G04tH+GuRNNlREnN3fjL2dAvlm+n1hpMQ1k
         bLsg==
X-Gm-Message-State: AOAM532wiOt0H36EgeMWhImqS7K0OzZehXzLnCHuJVLe8xU7QjJFVux4
        NjZWMXqQTfeS6A4skQK08FvRczmov0rmClDjUSc=
X-Google-Smtp-Source: ABdhPJyBk60af/C9C5g9kK9znnQdELrD7eCQBW2IcTXEuF7Dn8nzTsEw+V/y+nNCQlumSGoUUFgDmGGBfFH5vdLVxvs=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a62:c701:0:b029:142:2501:39e4 with
 SMTP id w1-20020a62c7010000b0290142250139e4mr13194002pfg.51.1602260074046;
 Fri, 09 Oct 2020 09:14:34 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:36 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-28-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 27/29] x86, vdso: disable LTO only for vDSO
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

Disable LTO for the vDSO. Note that while we could use Clang's LTO
for the 64-bit vDSO, it won't add noticeable benefit for the small
amount of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index ecc27018ae13..9b742f21d2db 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -90,7 +90,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -148,6 +148,7 @@ KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
-- 
2.28.0.1011.ga647a8990f-goog

