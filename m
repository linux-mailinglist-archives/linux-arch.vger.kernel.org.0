Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9DF3523D8
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 01:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhDAXdU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 19:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbhDAXdB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 19:33:01 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D70AC0611A3
        for <linux-arch@vger.kernel.org>; Thu,  1 Apr 2021 16:32:40 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id g18so4789029qki.15
        for <linux-arch@vger.kernel.org>; Thu, 01 Apr 2021 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ihXC2HiiYMKXSpC6M6Il6sHAA7ZrY8nJsA58n/MMk7w=;
        b=SUsTTUFBC5XLjQ0kmj8Tomq7Zqx0Hb4Il6WGzaLjEgbPEKek7Gt1me/9rrPDrJbPoB
         6L1gXdtEKIn2CaQiuuMwYHqPbPbF0YPAF8fn25t4Ahhl3F8CvP41+aSphFCMmkLjRpWg
         7K0837iEZV3dQwTL7t1gAd8fykHHRmRjN8S97mvJc83fQtkRf21ag0uG3eFsXsOk3Yd6
         WfTbU1jI8iYmDAR8EzY9A7Wn1NsSCmROqZbh/lmvjzPYFoMpIzncArJGl0L9vTKNaQM6
         MRiorZyAUvBbvRmKtGbgcwRV5/XjpHI7Xi/pEgwuUr7VNluRrDSo9BSLVCZJvGbuWltR
         ITtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ihXC2HiiYMKXSpC6M6Il6sHAA7ZrY8nJsA58n/MMk7w=;
        b=dpksStGUMgRayYswOUoWvlYRn6PhViBvEa0tvaoya9CeSjW+8deg1SfdhPfzeC+/EY
         W8bkF0aFesShyv2ZNhNhnTQLCX1hL6fqbm9K6BG+uVTSfKOJZkniMo/OYZv5H1MpLQTg
         eh8x2ykxwdZfGdPQ9DyP/rrfO2849Wwi8ZwR2xVfmZ6dGp45snJ1xudRzWaDqFE4JMT7
         uqpqCjYiA5AV7Arlt3Y8du+Ati4zpySthW3Rf4YWMItRrjScd+8ZDqEJXQ5bON1QyLT7
         WuApOY+lW+AVa+LvvA4Q3/jUovZQioWXAca79FbGBuWqy/LQenRVYS2wH4IdLMyMTj8g
         HOdA==
X-Gm-Message-State: AOAM530Z7J9EIFfp8dopdfCTDR4TwvSKoEk1h2g0m1fOATaXpQlt+Bn0
        lNMIf1ghgl74t38XDg/m3di4N0Kd719MLo4TSCU=
X-Google-Smtp-Source: ABdhPJxErjZybX6soSrTYGg1pcOu5YtycPfse7AYAmfc2HvtvvwrXxUQhki/vENl6RaYOLy3XisKMpVir5YUwgpINiw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:c345:: with SMTP id
 j5mr10638318qvi.52.1617319959483; Thu, 01 Apr 2021 16:32:39 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:08 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 10/18] lkdtm: use function_nocfi
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To ensure we take the actual address of a function in kernel text,
use function_nocfi. Otherwise, with CONFIG_CFI_CLANG, the compiler
replaces the address with a pointer to the CFI jump table, which is
actually in the module when compiled with CONFIG_LKDTM=m.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 109e8d4302c1..15d220ef35a5 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, vm_mmap,
+	if (copy_to_user((void __user *)user_addr, function_nocfi(vm_mmap),
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
-- 
2.31.0.208.g409f899ff0-goog

