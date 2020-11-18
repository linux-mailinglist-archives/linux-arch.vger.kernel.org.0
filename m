Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F119F2B8767
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKRWIO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgKRWII (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:08:08 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4C1C0613D4
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:08:08 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id bn4so2519106qvb.9
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Nlv9TtNsD8fyGZu3R87XXmbB0Bi+xxOBLxznH5wjST8=;
        b=WyirgobuLaISXur5OETz3eZnFCLE1kF2NBpqHWeIkDujjqI4PTHmgyyXAb1sNUuHVN
         Megmr6usGQTpCjvxunY6g475SVXL5PIUg4xn4wNAXU/O3G5axjtfvi1UZNaKLuLRYzl+
         H7vQeuVy+SxuGDx4D44bti70PiBfA/Fc3fj5gR5ZBA0IAjFSuTDfAo6x8m+qBTUa+FN4
         nVGzOamtnPS4n9xOnes8ikNN+95nJ8r8jDlDMPEu/u6I87rrC0kQZtn7FOesX7zgskpv
         7cU1bdPWutzDBqXdefcq61dRpBvIzgZAnfJAtbylX8NSGb4UV73Xo8c5A2fqUr0JVzRi
         d1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Nlv9TtNsD8fyGZu3R87XXmbB0Bi+xxOBLxznH5wjST8=;
        b=naRU4QPYIhAo7k3ANoS2P3UfhLCqkJJlIMFoSNaw0MZfplgzaV6avm7bUjKxZM9Q6X
         btiJ7CKtF5vEH6xzIP1t96iXhcYJNLGd3bsTJuCUGwCLjVKCoCTe/0CvNiRBWeTFr1KA
         XGleyO5xMiiFWlZxgfMhU6TnTl1JxR27Z2e5a/SZsI+/hA4IWnV76e9gVIWNOavL7wZB
         sQx/2t29UbiFFf+eTbeCqBz6Q3RdFUbsVmoiSuim5LrTpPTDx0jXFa/vSFhf7sT149U3
         1WJairRf+d+bzYAGqvjS/z18mJYQ7wzlNMkCoPxAshMbRVpNn5myxYjUxQDRfb3iaO4o
         gX/Q==
X-Gm-Message-State: AOAM532mUQ1TwL+hc8tINrZWCCU1bQuNGkNfEv6woykc20wOs2rpn8XQ
        6gbbeVHd3pZYVg6jDfMq9SpNXVLjfi67j4VhnQo=
X-Google-Smtp-Source: ABdhPJzn6vg0M5iTYPWjSWDRpSi/wGi1RShBZ+9f1oY4yzr2uEIppawRZrpye0kyCUINDWBYJ3z6tcMBnMS/ieVkr8o=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b65b:: with SMTP id
 q27mr6722891qvf.8.1605737287989; Wed, 18 Nov 2020 14:08:07 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:29 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 15/17] KVM: arm64: disable LTO for the nVHE directory
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
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
index ddde15fe85f2..4ceed7682287 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -51,9 +51,9 @@ $(obj)/kvm_nvhe.o: $(obj)/kvm_nvhe.tmp.o FORCE
 quiet_cmd_hypcopy = HYPCOPY $@
       cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
-# Remove ftrace and Shadow Call Stack CFLAGS.
+# Remove ftrace, LTO, and Shadow Call Stack CFLAGS.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
-KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_LTO) $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 
 # KVM nVHE code is run at a different exception code with a different map, so
 # compiler instrumentation that inserts callbacks or checks into the code may
-- 
2.29.2.299.gdc1121823c-goog

