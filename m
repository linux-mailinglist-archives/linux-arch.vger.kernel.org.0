Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F3338297
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 01:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhCLAtq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 19:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhCLAt1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 19:49:27 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A98C061763
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:27 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id j2so11438675qtv.10
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CeeN3xK5WAqMYQUfCf/QpaYnEzhU3e+FKSYu/FFXY8U=;
        b=YnzwiV3Orw5sKBr6YMDFmOYncBsKWDPtb68ypzRHMVK3VthGHiIWe4l2U/YxjypRBN
         wsdCMJQ8zMQ4WArlh/izxsQg9B1HPq7k4+zQzGqy/xvNVcvrOCu/A8nWO7g/+YjeuX2h
         jGDQ6MfChdyYhzfQCswFV9W0HW6D3ltx+MimGyrgUD1x+t+Bx9gPsDldUro2PNx4V8IN
         W7Zh/Yi/mTibl7LPNJ8pYn5eEyxkejmEbIYlhqwbmdNSdCR37OXx0M/R0WNI7f5943RF
         Jxme+nNTOcM7RlsIuIDWP8FV2CKIsNqPYMxSMUacQp9r5XEU2NLvZY8ysWVBhk0rMnGD
         iC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CeeN3xK5WAqMYQUfCf/QpaYnEzhU3e+FKSYu/FFXY8U=;
        b=oHSMSVrD00JO5QZ+DuWuy3CTAqXzJc9w8lug/090w1gD4cZsQG1za+3fwo41TUZ740
         P/ueQ6uCt4q5VPVh4wvMZfdK5I1eqHsLu4QOo6EkTjuTshvzCyRpAlCF+CZz1p+H8ISJ
         nNRm+riBi9cjCrmyT+4665yVwBfqpeKQF96Gf2ZEIsd3PuWfGVQw6PyHxg2REvndpHmI
         Up1NplSC2fTMVmokmPseJVirzWXNRSinUgO9uvpvGGdAz0PJUUXUDbdt1YLffl5g2XQs
         mTLujb3g3qvyeBkR/fAdeuKkKLNDX21LtqYyVwm+2jCXlAQwP8IUwKhqTxuDZ4KFJ50a
         WRUg==
X-Gm-Message-State: AOAM532vOHVZaIRy+EjKNuD06UpAeKr3axyzQnJ0ajDtNzA/6bQi7Qhy
        qS4jiodFzlJcXGb2ZpBSbx0H20dww7JRo8sRj5Y=
X-Google-Smtp-Source: ABdhPJwjquHhXc1azJY3wJx2N7E06CHn55yFR9L2LbefYUmXDDh/IrCaqT99xH2KOyCrVwPGAoCRUF+Cuh4wGPAPnqw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1144:: with SMTP id
 b4mr10460988qvt.12.1615510166369; Thu, 11 Mar 2021 16:49:26 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:05 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 03/17] mm: add generic __va_function and __pa_function macros
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function addresses
in instrumented C code with jump table addresses. This means that
__pa_symbol(function) returns the physical address of the jump table
entry instead of the actual function, which may not work as the jump
table code will immediately jump to a virtual address that may not be
mapped.

To avoid this address space confusion, this change adds generic
definitions for __va_function and __pa_function, which architectures
that support CFI can override. The typical implementation of the
__va_function macro would use inline assembly to take the function
address, which avoids compiler instrumentation.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 77e64e3eac80..1262c4c0242c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -116,6 +116,14 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
 
+#ifndef __va_function
+#define __va_function(x) (x)
+#endif
+
+#ifndef __pa_function
+#define __pa_function(x) __pa_symbol(__va_function(x))
+#endif
+
 #ifndef page_to_virt
 #define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
 #endif
-- 
2.31.0.rc2.261.g7f71774620-goog

