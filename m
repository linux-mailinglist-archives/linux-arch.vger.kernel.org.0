Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E7F358C63
	for <lists+linux-arch@lfdr.de>; Thu,  8 Apr 2021 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhDHS3q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 14:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhDHS3Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 14:29:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0041C061788
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 11:29:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v6so2857615ybk.9
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T2ovzaB0NMgTSr/OQHoRsOuIMdugM8hNdn5wpYAlfF8=;
        b=b/XnAFSzIGeFZL5t4c3a08ji5ExjHKdf/SwND+STd8nJjKG2hFi8IK6+LIkx2BL1C9
         wA58dA9Twv0RudfR+z0WKHeJHzBjE5MCPeNpBMSpRhTqgwMv1lMdb5OMvQvJs03AJdqF
         cvNhS4rRrIm5NEuMJcbOn0Qic4skZtQ7ODdDOjE+31zXh7wKiynNzNVauckEuvoTxUxC
         kDIa3FfiN8wZ72m0SiVMTOm77/X5XsJn517NuQnl/oz5AyexntdTHwnjiUme+uS7gPSa
         RYYiKdwwNKXeM2PUjRJWR//28taSyDm0VOQQzPOC2K3Pq3M24yOOt7lwowsUBlWOxQbw
         tw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T2ovzaB0NMgTSr/OQHoRsOuIMdugM8hNdn5wpYAlfF8=;
        b=edOuFOVdSjcAlJUo+V3OelTeWfr6tSKgBU5nQlJv0+fVZPFvd6NkiSMwhg1ofig/tI
         nQu9603Gj8M0Zx3lmscxW9sdEGEaGPhfR/oQxDhuEToOjF8o3yzvTUPpdtigh3GZSsVP
         jAgk/CoRiiPugELDrOjmrztm5pjDaHw0+sAt5HMEL4qmLgr2N6SQikD6ix9JagE6s2z6
         rLf+t0Q0yTkFWVq8jWDDuOHOV71R8ni/KMP2VwjvHuC+I9YSZjXGLY7ctkuwmf0IonQt
         rqSApfZeA8mpYE8GzRLCulXtZDEPbLBbEPsdaeShVAXkCLasleE4nF8Hmy8wKSYiJd44
         7diw==
X-Gm-Message-State: AOAM530CjgeDNPokyiRVR9hUmxiZjrDvKBWzrixH5uj6UAj8wyR6EPZ+
        x55ANIPRsBSIclgtkVIJ4gjV6TkWThKHSPtxOCI=
X-Google-Smtp-Source: ABdhPJy28p/s1E3yXdiEmOPhfW5oMkIPebIbR+7sk7/VA4kOnWJlonwcxFpLfp3KgtW+U+9qgib7kFL/mIu5lYyr5IA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a25:fc05:: with SMTP id
 v5mr2410558ybd.192.1617906540963; Thu, 08 Apr 2021 11:29:00 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:33 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 08/18] bpf: disable CFI in dispatcher functions
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

BPF dispatcher functions are patched at runtime to perform direct
instead of indirect calls. Disable CFI for the dispatcher functions to
avoid conflicts.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3625f019767d..2f46f98479e1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -650,7 +650,7 @@ struct bpf_dispatcher {
 	struct bpf_ksym ksym;
 };
 
-static __always_inline unsigned int bpf_dispatcher_nop_func(
+static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
 	unsigned int (*bpf_func)(const void *,
@@ -678,7 +678,7 @@ void bpf_trampoline_put(struct bpf_trampoline *tr);
 }
 
 #define DEFINE_BPF_DISPATCHER(name)					\
-	noinline unsigned int bpf_dispatcher_##name##_func(		\
+	noinline __nocfi unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
 		unsigned int (*bpf_func)(const void *,			\
-- 
2.31.1.295.g9ea45b61b8-goog

