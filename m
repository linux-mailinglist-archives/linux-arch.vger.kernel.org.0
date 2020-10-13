Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920EE28C614
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgJMAdX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgJMAdB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:33:01 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF29C0613E1
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j16so12561728pgi.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s6lKkOY6jDvHdKU5rddxnOybuTgb4UG6S62YgATiqsw=;
        b=CfMw3Lf2RqxuH1gK/LplrUVdrli+0+CHSSkm8IVXoxiERluD9UBxqoVgGLYbB0zcGH
         fcd+f/qjElRp1j6Jdey9Bh7NDBDe4hB9i6yurpQFinDV80y/ezy2gjJtTugW6x9+TxXB
         lOD7ufXL8OAxIH+6uzRqxS9SQox8gQ5U7CudTH1hC4sfe/ktNYfAhjsreZIIFTMjFG1C
         RQt8+AhPqYKsAgf3F+x4HsSqm87l4hiDBx+TxXtL+Ap2+aCO42F+hEV40MZGJK2CkBo8
         P4FhwGbSHoh+MmiJ53pkyum1T4qHIVaGpa4LSlzx+7mtM5okXCbjhUku3Y3pd0VFE6Pn
         ksJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s6lKkOY6jDvHdKU5rddxnOybuTgb4UG6S62YgATiqsw=;
        b=CDOn1RfvBxDEPQHt7GX/VUfnYWyaX+NBDhGOYnTpufbeCAb5iK1sirV0X0Ka+Kn70s
         qw1Uh4QoLFDjbQY5sAUocyFG80Zz4zdNeKBBbMDBt2WCs1aezcjZ4XeaMWPGKOv4D30A
         1mCYaceQvCFHYW75C3Sj+8Tld0v5Kou60d4MF4s6o8Odc7MffLUYKoVXiuu9EDF6qzbc
         8U7gDYY4xXkl0zxaNQR4q2DyB77hGpSRgzw3VNDP0G95m0Pqc1/ikRg7TyTFygTiDCIg
         aTHQjtkceEuf1b1A/lEhV/4jnwPVIwlY2/QY6FTxXSSLpE9f8ymMGNytHf2evtWBf0cB
         jRxQ==
X-Gm-Message-State: AOAM533uXKidAgdN0Gese4FIik6jRXXAZK4n3rYYVralYR3qMekqFlQf
        XXLghv1RMx1NAtTfGDSN6Uw/ADfcFeoluflTbMg=
X-Google-Smtp-Source: ABdhPJyFxyU35wX46NP9k8EgBAnMCUQ4LjUrf9Ha6HBecKs6BME4DjIGIM9k+HTmfXPW/UAyVK3X9uWCjK1Lv7DEg7U=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:aa7:8492:0:b029:155:79b1:437a with
 SMTP id u18-20020aa784920000b029015579b1437amr18970192pfn.26.1602549155518;
 Mon, 12 Oct 2020 17:32:35 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:52 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-15-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 14/25] kbuild: lto: remove duplicate dependencies from .mod files
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

With LTO, llvm-nm prints out symbols for each archive member
separately, which results in a lot of duplicate dependencies in the
.mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
consists of several compilation units, the output can exceed the
default xargs command size limit and split the dependency list to
multiple lines, which results in used symbols getting trimmed.

This change removes duplicate dependencies, which will reduce the
probability of this happening and makes .mod files smaller and
easier to read.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ab0ddf4884fd..96d6c9e18901 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -266,7 +266,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
 else
 cmd_undef_syms = echo
 endif
-- 
2.28.0.1011.ga647a8990f-goog

