Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16D43AAB
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfFMPWz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:22:55 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:52512 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbfFMMdq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jun 2019 08:33:46 -0400
Received: by mail-qk1-f201.google.com with SMTP id v80so16478242qkb.19
        for <linux-arch@vger.kernel.org>; Thu, 13 Jun 2019 05:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qVLSMyZ68L0nEVi2BC3Nmk92s+29uFb8AJSu612sAz8=;
        b=mEcFMq6vRtXHwc1RP8jEWhkPHuu5ffLbfkkwDtzHIdY7zu0q/3RmQYU0C2M8YItYdj
         KrS3JrVCHUTkTVGPeJFR3558Lkzo9m+Hrt2To2Xh6dHj3rWEZdwlvfU/XobkdBa1qM1u
         bVUHZhGsEe6EyqwGvBRK3DpuxCKwwz93lpLFVVpqqWoWS+f1yFbvvDsQRLHdlHjEllmi
         4c2+iEnMXwijfbpWUfTWtDfGTh2c6bTbPu6mYc3Z5FvYeAnfq5fhqA1ZXRpV9QGoquIe
         UXI/Y+mYi5zKHzhAfqrF1QBTPytuai5yqmiNP4Ah1jeWXWL6tgCc55WQHEp4ZqPnjVex
         sh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qVLSMyZ68L0nEVi2BC3Nmk92s+29uFb8AJSu612sAz8=;
        b=hNWh9UcggySYgElwD1mk2tLSkBv+01UCfx/iq2irBQJQWqEmStNB/4nw0SQYhFKSuE
         VwA90YNXE4nGWEXfjXuzlpg72x2Ovv59FwY4SzYIf6sStZwpgVL38MP+xK/QjzTdb/Qo
         2dmEYLwJs/EvEuHG+xNXhR5VgB/CaO44He3npg0l+2BJccNyMhOvdq2wY3r/Uht0C6PE
         I0mhfUdzrfQatlqbmSJMuPtSkqCgjkzGKFu2nIyYSZ9iGj26OHi1RBJmlOiYPSisBR/t
         esU2tEpTpiHOjuryDJKu88QQnxAqKGUc9Bkjl04crRMdHkFwkJQx+rlxbmRqr9O5ykcF
         bRbA==
X-Gm-Message-State: APjAAAXNwIVa/h60/OA1sFKThL/N/P610wWgNjwNz2nsvPvVKMeZ2dWT
        qvwt96k+H8HecZ6VCKq63o0pEq7YYA==
X-Google-Smtp-Source: APXvYqylI3cPASu223/GCT4ATKtpCP1kOJBYXot+bE63+WxXg2nIKWWXGD9ArdLXxrnm26iomhlz5BaC7Q==
X-Received: by 2002:a05:6214:1249:: with SMTP id q9mr3260843qvv.154.1560429225061;
 Thu, 13 Jun 2019 05:33:45 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:30:27 +0200
In-Reply-To: <20190613123028.179447-1-elver@google.com>
Message-Id: <20190613123028.179447-3-elver@google.com>
Mime-Version: 1.0
References: <20190613123028.179447-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v4 2/3] x86: Use static_cpu_has in uaccess region to avoid instrumentation
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        hpa@zytor.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch is a pre-requisite for enabling KASAN bitops instrumentation;
using static_cpu_has instead of boot_cpu_has avoids instrumentation of
test_bit inside the uaccess region. With instrumentation, the KASAN
check would otherwise be flagged by objtool.

For consistency, kernel/signal.c was changed to mirror this change,
however, is never instrumented with KASAN (currently unsupported under
x86 32bit).

Signed-off-by: Marco Elver <elver@google.com>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
Changes in v3:
* Use static_cpu_has instead of moving boot_cpu_has outside uaccess
  region.

Changes in v2:
* Replaces patch: 'tools/objtool: add kasan_check_* to uaccess
  whitelist'
---
 arch/x86/ia32/ia32_signal.c | 2 +-
 arch/x86/kernel/signal.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 629d1ee05599..1cee10091b9f 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -358,7 +358,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
 
 		/* Create the ucontext.  */
-		if (boot_cpu_has(X86_FEATURE_XSAVE))
+		if (static_cpu_has(X86_FEATURE_XSAVE))
 			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
 		else
 			put_user_ex(0, &frame->uc.uc_flags);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 364813cea647..52eb1d551aed 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 		put_user_ex(&frame->uc, &frame->puc);
 
 		/* Create the ucontext.  */
-		if (boot_cpu_has(X86_FEATURE_XSAVE))
+		if (static_cpu_has(X86_FEATURE_XSAVE))
 			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
 		else
 			put_user_ex(0, &frame->uc.uc_flags);
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

