Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB232346A45
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 21:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhCWUko (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhCWUkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 16:40:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D3C0613E0
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l83so3779367ybf.22
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qAbADIQAzXUoq/ElYpa9rjjQHxphEP8wPywcql//gEU=;
        b=T9lYeG1vNkvikIi777MRSbbTtj3IaPeu7RN7uXeSPXvS4b9+WLGfOdasWEAHo+i17u
         3080AmXMs2xVaLte8P7ahk8JJEdHsGELqvOLIoahy4V4PMsoqaf2aZV65W6Qbg5iWS+h
         b6ti/m6+OZ84hMZziyoN5GFocxb13Za6OwHGFrBaUy1iO+H9JEiP0tyCwkF3p/KzGz5a
         KI2Lj51XAl8PJy62wWStBc6KSEOp8id1hQ564UGK3S0iIjj4kUsIubPJjw5De4OUhc9s
         huAxEcZhyUcc7CzcBmMkKd6YmZw4qc0E+2UxOVGGUsXyQLc3FPDMC5xWzijn66SgJ0Xs
         vHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qAbADIQAzXUoq/ElYpa9rjjQHxphEP8wPywcql//gEU=;
        b=Z269qYnit1OuBqKgARwRQScADegjdGFrarjVmjuvLgVj+cHjuycvWyDcJjhhvsZdWM
         hpdsCD/ymUep0Yn0d/hSVkX6rAX7Wauu7NREZkxCE7Dsy/xM20LYT/tlG3CSD5V6C3G7
         o9LjxVVvbU8Bemiv/+hE8lgq6ECXWSFlY0PldX7iqul85tybvpGt+ljEt4ZwjFsRC7Uy
         ioZ2nPC9AXkYi50rGueaajvNLUoxyW0Vt+rQdWJVyY+AK1ONO7R59wMYobBax8I46b4i
         VFv2tgK/GvxFuo9c/h4TKTdjy62VRt7kzCHbPBt2GRrVxngHuvDBo1eZ7wJFbW9J/xsh
         X2Pg==
X-Gm-Message-State: AOAM531/ydMjzJsHFfafnjI3BC3eEBNu1CldBKYxt+AEx7K6T9DUyAXg
        tDG7WlJyZBDwB/rz4qwV8Yxt4KMZSUN+2mvuNLA=
X-Google-Smtp-Source: ABdhPJwmStks0YRxHTnj25YBiyDAjN/ixvNa9lapKnlHKARYrFssO9o0nOXAMkPoRpi0g6QTRn8BhWyhoUBcjcDwMF8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:3493:: with SMTP id
 b141mr100244yba.342.1616532016542; Tue, 23 Mar 2021 13:40:16 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:44 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 15/17] arm64: add __nocfi to __apply_alternatives
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

__apply_alternatives makes indirect calls to functions whose address
is taken in assembly code using the alternative_cb macro. With
non-canonical CFI, the compiler won't replace these function
references with the jump table addresses, which trips CFI. Disable CFI
checking in the function to work around the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 1184c44ea2c7..abc84636af07 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,8 +133,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region,  bool is_module,
-				 unsigned long *feature_mask)
+static void __nocfi __apply_alternatives(void *alt_region,  bool is_module,
+					 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-- 
2.31.0.291.g576ba9dcdaf-goog

