Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276F82D7E8A
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 19:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406231AbgLKSsm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 13:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390039AbgLKSsO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 13:48:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF4AC0611CC
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e68so2372736yba.7
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6mEKvNeY3wq0rs7jAFLZaZQm6yt6Fm86WJ405HnCM0w=;
        b=F3+ZlsJ4J/cRnUap6emR8N4b+Xouboife2S7UkAulyFopMjE2taVk9b7ehRGq4lP6n
         TWsU42g66xrNtUHSwJP7KHpC9+dzh6DjSzVNB4ihF3HNbGrWLATePQMHxzMsDj13lrQP
         azC/S2KiPkBzTIoYgS+nAssox204PVtPACYv3/zBjhusnbk5UjStmi3SxWetk5Rg2kzv
         z8nqf6A2Nm0mG//A4/l4+LYdtA+F++wU6dqyimvIcOKEyC4WJMPShNvMtY4e0/LfP4ix
         QdZ5G0gBeKAaM4Af5u8Kd8vvAtx6eHRH3G4aF6b+OJSo0XA9zUkdzMJPMR2eih4tOekj
         Yqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6mEKvNeY3wq0rs7jAFLZaZQm6yt6Fm86WJ405HnCM0w=;
        b=KtPns5f6cZEtJX0FbNuoTqmsFfIRqin56J+B/waWqSmd4GsnmbQgXELqo8/phgGl73
         mCxIQpkNZAbXWvbEtjoIhKpAHhfcYox61OGYj6uOrYuO31WGEa08n7ra2Ttnq/9mQYPq
         2cjFvbjuf9jLR0qMWKoUpx7ri8sIfWl1bojzSYCEj0i4EuQKcgjmUQPZbCRNvjDHMgCz
         eT/Tijw51K/W0AL6tLy+TrhDMoPvnN97h00AAxUaKTav5lvYVigagi3giiIkugaCynsN
         E1qBcWfcTBBorax0/6cVvqkBqNG5r4COMfhX+oYgStEP2E4IrVxyNatu3PzM3S52djY8
         SNQw==
X-Gm-Message-State: AOAM533W+hSN9dZR/9oZejvbnFYXZ73REud/CzvxgG9CrvNxQ2e8mjSd
        gfukmhz0RJPwaZzB+wrxumwcwWMJpyECnoMNjp8=
X-Google-Smtp-Source: ABdhPJztdLpOmb8z2bOpx13eLpmFbg1IRTYkNtur403j5lUtJlMBrXobhq6mew9nU+bYggfLn4Aj28+KN30Fe9rq1PM=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:7d04:: with SMTP id
 y4mr20471824ybc.110.1607712403064; Fri, 11 Dec 2020 10:46:43 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:21 -0800
In-Reply-To: <20201211184633.3213045-1-samitolvanen@google.com>
Message-Id: <20201211184633.3213045-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 04/16] kbuild: lto: limit inlining
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

This change limits function inlining across translation unit boundaries
in order to reduce the binary size with LTO. The -import-instr-limit
flag defines a size limit, as the number of LLVM IR instructions, for
importing functions from other TUs, defaulting to 100.

Based on testing with arm64 defconfig, we found that a limit of 5 is a
reasonable compromise between performance and binary size, reducing the
size of a stripped vmlinux by 11%.

Suggested-by: George Burgess IV <gbiv@google.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index a07e3909e5d0..84c60f38ee3e 100644
--- a/Makefile
+++ b/Makefile
@@ -901,6 +901,9 @@ else
 CC_FLAGS_LTO	+= -flto
 endif
 CC_FLAGS_LTO	+= -fvisibility=hidden
+
+# Limit inlining across translation units to reduce binary size
+KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
 endif
 
 ifdef CONFIG_LTO
-- 
2.29.2.576.ga3fc446d84-goog

