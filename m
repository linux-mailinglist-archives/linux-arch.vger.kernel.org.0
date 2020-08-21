Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F0E24E10A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHUTp6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 15:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgHUToj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 15:44:39 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E96C0617BE
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 128so1474157pgd.5
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2020 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XUX2/F199MEO0A5MxoqXk+lRBktQIKiWBEBF3o8wM8g=;
        b=j1sa53Ser9mup3Pv1fHYCK7qkFQ8JkWE5b9bJ2WYsLFPuFUJI+77KvzI8C6EnJ19+U
         HOx5t7CYCG20lCrUcZggNSgWvsVF0d2eqTd4pLYBAA6zYjF6GRTQ4yiYD74vhBk3D1th
         23E2s7EIY6h+0C6fBfpGXayEHW+B0c00eaZ9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUX2/F199MEO0A5MxoqXk+lRBktQIKiWBEBF3o8wM8g=;
        b=ING79RcMtGY/v8cBvv1h/VI93NLW8kP0/Q/tNsA9b7FOis6AjHkW2FffjzVeNJbxmY
         WZc8C/siXdzVBbUJhEb8KrbIczQ+oIMDVnfUf6Qmk+bCZdx71jHHqWLhxEAQdwkFd5oz
         Sf1+GSNm98o3xrR5CG/UVYdGb6RK4vRXun1HOhldFkkVHCoHbPEE4hnmTy5KkqCoCoAB
         TdAHCyLvH+o2E+WeeCNjNdgheX7C+3vaXgt8gnwLwuOoloB/0WZCVXaWVFDzxqzN4qUc
         U324eaxK6dmlldDTc0wBpVbYHk/moUhWCXNaO3IXPk3uVHofzx5j7ZR5agDARWBVFFa5
         bxRg==
X-Gm-Message-State: AOAM532GCrlx5tlb+6R1rhogENucu2AxIvnRXGbRsv6syRU/h2uuI8Sy
        Wi+O0aUdTNJtyhiFmvbZm1abLA==
X-Google-Smtp-Source: ABdhPJxMWaonUSXNP/PpdB0d3pPrg3ZHtK9FuUs2ySecf3qKVDwynmOApOgUDdedWpVyLheXGVlFJw==
X-Received: by 2002:a65:679a:: with SMTP id e26mr3467507pgr.167.1598039067977;
        Fri, 21 Aug 2020 12:44:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p20sm2611002pjz.49.2020.08.21.12.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v6 10/29] arm64/build: Remove .eh_frame* sections due to unwind tables
Date:   Fri, 21 Aug 2020 12:42:51 -0700
Message-Id: <20200821194310.3089815-11-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Avoid .eh_frame* section generation by making sure both CFLAGS and AFLAGS
contain -fno-asychronous-unwind-tables and -fno-unwind-tables.

With all sources of .eh_frame now removed from the build, drop this
DISCARD so we can be alerted in the future if it returns unexpectedly
once orphan section warnings have been enabled.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile             | 5 ++++-
 arch/arm64/kernel/vmlinux.lds.S | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 55bc8546d9c7..6de7f551b821 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -47,13 +47,16 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only	\
 		   $(compat_vdso) $(cc_has_k_constraint)
-KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+# Avoid generating .eh_frame* sections.
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
 stack_protector_prepare: prepare0
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 13fc2ec46aae..c2b8426bf4bd 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -94,7 +94,6 @@ SECTIONS
 		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
-		*(.eh_frame)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
-- 
2.25.1

