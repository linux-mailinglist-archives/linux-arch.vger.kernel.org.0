Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E502A350957
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhCaV2V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhCaV1z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:55 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB260C06174A
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:54 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a11so1944757qtd.4
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qAbADIQAzXUoq/ElYpa9rjjQHxphEP8wPywcql//gEU=;
        b=BIwBbz27li9nhzZOJpPItRxIEwjbJxKUY6UbYU5CqvzA6WV2OyusxpPuP2GbqEKsF4
         wPUN1Q4or2K+m1thBQd2qBYnnhno/+HEhUjZP6mN++bKuXujnCF7ElDczhg5KqD0DiHQ
         hAtx85mO6qIZNWn2hkAtwUeoT/7iOQYyLpsYMn5GkmPZR/+IClF4QAklOY48jwFmIUYr
         aQsEWMT4TYApAtAL/gjYcoyIEfUpYswWr1684dszxQxu7VwcvcTCnnc8GPEf+Ef5ZYIf
         aeqjPvWk/ub/50LBqjLxSVw1zYmdKi8DPaVfSVN+0mUmPWgG8aIRBCTvTk4SH2B+EppC
         /dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qAbADIQAzXUoq/ElYpa9rjjQHxphEP8wPywcql//gEU=;
        b=quZEoQ8frgv5grgXrJHogEw0XPE+CxpXwashkjWp5xnmIOacc9ig+lD5L+Edj6Pa3B
         0iOtL5V1s23lt3WQdQcUUpqWUr+Wzi5TP3Xfs6w8eUdJz913PP1RSk59BlW9wJVakR2k
         nT6OF/eel6mkdAIQ71wQL4ZCEYmX8CUM3oMYSuPvy+MifRCFNLOH2hV7zLZVaN4JmAMZ
         sfBxaKVntM/qWc2uCN1dL0xJSpzwjhmqPG9REAEDTyElT+Rv7mF/+Bi23ZifbG82at2R
         fEvKPhc6b4sUCLF6XCvJtt++r3Ly+fvpp8940e/cWeAOd1FxCQga/pP7hsFtZTto83rt
         TO+g==
X-Gm-Message-State: AOAM531flCoe2BUapD2jqFp5mmJ4SNPR/Ho3x2ahMNTrItMaYq5x0cT1
        lmU3LuvATGXoK23csSGZ/zFRNvbffqVZhzkuwzA=
X-Google-Smtp-Source: ABdhPJwBmNvm14+TDBMdxtVUmeFtuXceFyrO8XCaMzs+ImrOy+72TpNn3ja8CYb7Rf87hbMIOM4aIfmuWPGKh8vvqRQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5614:: with SMTP id
 ca20mr4929242qvb.37.1617226074055; Wed, 31 Mar 2021 14:27:54 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:19 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 15/17] arm64: add __nocfi to __apply_alternatives
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
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
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

