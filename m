Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A056424E152
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgHUTzL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgHUTyF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:54:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60DC0617A0
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m34so1473254pgl.11
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PeNFh808sp94203AedRRDxtBogHXBjPfBsBbm9/bM3w=;
        b=KCpWIGu2/MoubKQjEEdpSZyLun4iQCojW3eL8PjI2Ey8IgO2OcGgVhrFyHJn60Oux1
         fAkef240dPlqqfWatRfeUzI0UXYkuVBgt7cQxaJhM6IEUsH+zU6+dsXGqqDYhsj3l+/E
         d+7ZofSbpYqxDUrDxEuyZZyHy5U/1ElZSYieo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PeNFh808sp94203AedRRDxtBogHXBjPfBsBbm9/bM3w=;
        b=R7FiwVOF7QjRlqBRj9BW87+1Q8h5CtPZegBX/BeQXSSPQt0IUqEpyaf9gG88vfKoQV
         PF7ULE0ea1ziF/tj0GT5U+5pMEplPx8eyFusiXyRKYN1L1uTvR0DTJMHQlsAryE9d/19
         bQBcn4MfJG0VWcGXhOKCs0X/MYFuJU/PsvJE8JY3I0eImNLKwupzMPtOAHDGjP+yzJX2
         Sua54pBFLFVymqBBsY4tt4erMXUaMWjGk50pChmBCoO2h8NXSzix5TL1Nsmg1Wfx3jCX
         BMdZAzxg45surGfAspHo/sZ8BTBHtsN+UMzlfNKcczizC2r/mYBCPU9x3We4lq/1ZNY1
         9XIg==
X-Gm-Message-State: AOAM533cEN/7mf/Ej7AWzcvSzbCEchS0roQByCMcXYvPVXqhWs9piEO3
        6edUkodz6k3rS+EagwD/I9bmQg==
X-Google-Smtp-Source: ABdhPJz2gpH4NA/nopyFe5T4J16P06sAq6mOjn6oaCK64m6qXX90A5MjjPsdZ/Av2ZQInlq5xfJc5g==
X-Received: by 2002:aa7:8bd2:: with SMTP id s18mr3553849pfd.284.1598039642687;
        Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x11sm2748233pgl.65.2020.08.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:53:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 22/29] x86/asm: Avoid generating unused kprobe sections
Date:   Fri, 21 Aug 2020 12:43:03 -0700
Message-Id: <20200821194310.3089815-23-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When !CONFIG_KPROBES, do not generate kprobe sections. This makes
sure there are no unexpected sections encountered by the linker scripts.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/asm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 5c15f95b1ba7..4712206c4325 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -138,11 +138,15 @@
 # define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
 
-# define _ASM_NOKPROBE(entry)					\
+# ifdef CONFIG_KPROBES
+#  define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
 	_ASM_ALIGN ;						\
 	_ASM_PTR (entry);					\
 	.popsection
+# else
+#  define _ASM_NOKPROBE(entry)
+# endif
 
 #else /* ! __ASSEMBLY__ */
 # define _EXPAND_EXTABLE_HANDLE(x) #x
-- 
2.25.1

