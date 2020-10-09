Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076D8288E57
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389830AbgJIQPZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389839AbgJIQOy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:14:54 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789EAC0613E3
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:14:25 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b5so6642122plk.2
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JHNK5VWD3ddVakk1msJzGMuIHjr7wcpFWGy1F5g4J2Y=;
        b=M0h0mH4wlOZcaJsIi5sQEuaiXKV7B0eKEoaPKg3kbfXsWnZ9dgEuFhvr4GvOUISD/R
         eAtFXUMTPEOVHW+XOblcQS/ISTtHpag/wILGcioqEck1N+9WCscWL7vFacbN6GUuar+k
         4PnFjNWO2auD2wONFsEZeyA0wE6HkoReMLefaUGdvzHpzi2jFdR2nk7TLMGHQ6IGcOSj
         3cIInTMXmsjJLQw59hUKMC6ilpXp3px/V6+ZuAnx5tBy0UDfBXrEN1SKQjcZ2XbWb2iB
         va5v3rnvQOCmgyUdtx7z8zjGiV0r6NCEuQQzlxkUNcl+QUN74zldCyfQQhUYvV8F8BwK
         NdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JHNK5VWD3ddVakk1msJzGMuIHjr7wcpFWGy1F5g4J2Y=;
        b=FQ5GM6pDjEiUN8R+RTb0h5EU1mlGwjkcP89HMbxVXKxAXCBtkhycSvv4e7D6PqzgLX
         zksu2DM4qFKgh9IvVY/jzjW/nYDx6VhStc+ajUe5+NlQ69hSTTCmH9cpowZSejye3um8
         tMWZZdr2Wmm7iH/exPCQukP8fLNaqg9w/XReFDbrWKEJXykKgrRlW+gwUyMsz9YLgPdz
         xtvTZWergucIr4MZXK5096s4geK5YJ0jsHqMkXQVz9YZ4ZLlWXpS5FjmnNqQCfXHSqIP
         IqU3n9ufKN4XdnA/buTqycxCwI3NE9Kf6mcf21x4t5KgIK6zrMZuPSqOv7QfVlDX+uBY
         6QuQ==
X-Gm-Message-State: AOAM531PWuuiw/mJUXkMu97k0ojyEwhwmlC+/PC8cjnwoFFC1QbT3ofd
        s4Gv0UWJIgML4+z/cw6SgkUUkjTw+ehm02vpF2U=
X-Google-Smtp-Source: ABdhPJyNU5RpFXb6oDaPa5kfxyMLH3rqIIuf9in4Eo1ivOzj/QSIy554fzdbu1UoaF9jnvjswSLNZfW1sHDa3cxCuBM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a62:7a53:0:b029:152:5482:8935 with
 SMTP id v80-20020a627a530000b029015254828935mr13281502pfc.31.1602260064759;
 Fri, 09 Oct 2020 09:14:24 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:31 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-23-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 22/29] arm64: vdso: disable LTO
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

Disable LTO for the vDSO by filtering out CC_FLAGS_LTO, as there's no
point in using link-time optimization for the small about of C code.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index e836e300440f..aa47070a3ccf 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -30,7 +30,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv	\
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
+				$(CC_FLAGS_LTO)
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
-- 
2.28.0.1011.ga647a8990f-goog

