Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0DF2D7ECF
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 19:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390228AbgLKSth (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 13:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394216AbgLKSsO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 13:48:14 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05051C0619D4
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:48 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id g24so7086297pgh.14
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=D6dzW9Nv9PxzQobvhFlQDWUjMujzTJKPO9b+q7PtBxA=;
        b=j80QiI4Ul6UgEkfC+jupmsvTxkEELd8wbgUjUZ6N8GZBz3X4UojppIFANKFCwEcr0b
         hjg7atDwt+r6dl376cixss8x61cmNs3p6kdE0NH0HxFb1RFB4vQfxhmnXPW46RXzb3jX
         w/C2Yv2wPOS6QjdjcS5NeKPbqbdp8shMph/o4hHfNZ5sJb5N3Ar0+qPkmusVLmg+5im/
         FXu/NZwu9TMocoPetDYE2QWKb90ZDlr4lbZ3N2VjoMkHvJaSPTfqO5DKNCfYjLKaMtOp
         PjFKT07Sh00XUoerVDLql1CWKexmWjEKEMlFf7a6DuR4Wtg99akEQhhQl7HctgCVr2eD
         quKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D6dzW9Nv9PxzQobvhFlQDWUjMujzTJKPO9b+q7PtBxA=;
        b=qI4YPOBvKY1mUe9uP8JJkiU+0S1X9+f3tSOL4jYnFVQgfulYtWTBy9XZfHrLnMnZ/S
         0k4wZvX0jl0MXVw20vLTGYN+cIFsvEPNV/QaW2EfQtkeLtRnSKmbxdJju12Ck6y5Y/Px
         gY9zwPYmwPsRbZvDMOuluIwz2lJBHnWBlWEiyXkWJ1qBoXy20PQfjB1OkpiYpaJjcfGB
         SU5iwgPAixCmS+4F08njZbdhDTuxuSMBAs/il7jQo5DXV1Ju6SqEtwn9xJysZHrSQOSb
         6dO85Pp98zl4G/CxcQSKjwvK+wC96xxbhca1jM8fpYdpvbsm0VACnd+MzmTwVdW1WHrU
         pZVg==
X-Gm-Message-State: AOAM532E/JreS4oWg8F7eG2JBY8CsinnG+ZM3Q+5bXWqhRe5gQPsxUwW
        9dO2co7zMx5vB37toLF8IVPZM/521U57yZu3sEs=
X-Google-Smtp-Source: ABdhPJzTxDOAZu/cl6nSaAjpW3k/LNI+wnG91vRp8xhL+7QirY0I3Vi1skb6ONtaVKsVxERXnDfxMhqkc0oDgftg5yE=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:bb8c:b029:d9:261:5809 with
 SMTP id m12-20020a170902bb8cb02900d902615809mr3908181pls.29.1607712407508;
 Fri, 11 Dec 2020 10:46:47 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:23 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 06/16] kbuild: lto: add a default list of used symbols
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

With CONFIG_LTO_CLANG, LLVM bitcode has not yet been compiled into a
binary when the .mod files are generated, which means they don't yet
contain references to certain symbols that will be present in the final
binaries. This includes intrinsic functions, such as memcpy, memmove,
and memset [1], and stack protector symbols [2]. This change adds a
default symbol list to use with CONFIG_TRIM_UNUSED_KSYMS when Clang's
LTO is used.

[1] https://llvm.org/docs/LangRef.html#standard-c-c-library-intrinsics
[2] https://llvm.org/docs/LangRef.html#llvm-stackprotector-intrinsic

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 init/Kconfig                | 1 +
 scripts/lto-used-symbollist | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 scripts/lto-used-symbollist

diff --git a/init/Kconfig b/init/Kconfig
index 0872a5a2e759..e88c919c1bf1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2297,6 +2297,7 @@ config TRIM_UNUSED_KSYMS
 config UNUSED_KSYMS_WHITELIST
 	string "Whitelist of symbols to keep in ksymtab"
 	depends on TRIM_UNUSED_KSYMS
+	default "scripts/lto-used-symbollist" if LTO_CLANG
 	help
 	  By default, all unused exported symbols will be un-exported from the
 	  build when TRIM_UNUSED_KSYMS is selected.
diff --git a/scripts/lto-used-symbollist b/scripts/lto-used-symbollist
new file mode 100644
index 000000000000..38e7bb9ebaae
--- /dev/null
+++ b/scripts/lto-used-symbollist
@@ -0,0 +1,5 @@
+memcpy
+memmove
+memset
+__stack_chk_fail
+__stack_chk_guard
-- 
2.29.2.576.ga3fc446d84-goog

