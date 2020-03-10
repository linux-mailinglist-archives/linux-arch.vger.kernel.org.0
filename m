Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC2517EE0E
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 02:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCJBkm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 21:40:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46673 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgCJBkm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2020 21:40:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id 111so7302635oth.13;
        Mon, 09 Mar 2020 18:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rJK9U08Zj+HB08iS4A3NIowl4Auq1x6GFauaG9Dpfhk=;
        b=MI3LsZw7vyE6zL2uUE5LNkRK6WONYZlKKzhm0UBGoazAzjL5rgnpIak9QpxbIdTEu3
         xprwESHPBO8RKvGFDltAcR3+uL19Mz9JYzO5Sb3zXVDZMm8kzgUM8eAgWhHajSe8kG/4
         soH9S/H5s2OkD/6rz3g3rjkLzvvGE2znJLj7gZeMbcWzk5CRht9yLYlG7xgYGWetING2
         641vh+q8gpYOZ38KEASNyzZ9SJugm/1QlgZkz17eF+AOFUPfZwI1lOS+Mhc4WuFlMcSJ
         Z4NsaM0Uv+8Ft4og3yBFYgOBclYQbt2aXLLwu7isUwxC5Zz5aS6XyRg2eaPTDjpBqSIN
         ePYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rJK9U08Zj+HB08iS4A3NIowl4Auq1x6GFauaG9Dpfhk=;
        b=V5zyHqWA5NXtuirzqIJ+p/GQzKGW0E8mm3wswkQoG26wW8/3O3uRvd5VgyQEdx2Y3M
         YaHDPMr6Y9/aYSqtlVBvtKu3b/b5Qhd5NO6u660V8Wr8649cDcjr7eds7ytFG/Soxwe4
         mlZXcs/Mntes5IaNFedHiSInzmnBuPY1tnyCHxlfourry+lrwYsGOeyiLhC46lbGnBwz
         gqLJMuPNYRE4GH0pS+epQ+hkg6OoyPJq5+gpVQnhEFvYPzoJXZM5LtxHH1ya/Wbt+Mx/
         KDGGthGPeIl49572FonxwY5RTxnMZAMAsXVaP5QQo/Z2k/I7RkJTP7MuW4r5iSaJ9n05
         pXgA==
X-Gm-Message-State: ANhLgQ2Jqdqq9YsDkgJTKNRqNfJYH0YNMMifjWJ5mCrdQnBVwpBOau+b
        IPwqHs7OiHQWnhCvmbDzwNY=
X-Google-Smtp-Source: ADFU+vtI8p9Wnmx7w1A1sqX5hE4kdrervhf+WzPWCjCVoJywvvUUUffkcME7Ef2y7dQnPQxGY6M8Dg==
X-Received: by 2002:a9d:4d8f:: with SMTP id u15mr15193747otk.261.1583804441415;
        Mon, 09 Mar 2020 18:40:41 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k21sm2096097otn.58.2020.03.09.18.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 18:40:40 -0700 (PDT)
Date:   Mon, 9 Mar 2020 18:40:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 20/20] arm64: vdso32: Enable Clang Compilation
Message-ID: <20200310014039.GA12211@ubuntu-m2-xlarge-x86>
References: <20200306133242.26279-1-vincenzo.frascino@arm.com>
 <20200306133242.26279-21-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306133242.26279-21-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 06, 2020 at 01:32:42PM +0000, Vincenzo Frascino wrote:
> Enable Clang Compilation for the vdso32 library.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/kernel/vdso32/Makefile | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 04df57b43cb1..650cfc5757eb 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -10,7 +10,18 @@ include $(srctree)/lib/vdso/Makefile
>  
>  # Same as cc-*option, but using CC_COMPAT instead of CC
>  ifeq ($(CONFIG_CC_IS_CLANG), y)
> -CC_COMPAT ?= $(CC)
> +COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
> +COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
> +
> +CLANG_CC_COMPAT := $(CC)
> +CLANG_CC_COMPAT += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
> +CLANG_CC_COMPAT += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
> +CLANG_CC_COMPAT += -no-integrated-as -Qunused-arguments
> +ifneq ($(COMPAT_GCC_TOOLCHAIN),)
> +CLANG_CC_COMPAT += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
> +endif
> +
> +CC_COMPAT ?= $(CLANG_CC_COMPAT)
>  else
>  CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
>  endif
> -- 
> 2.25.1
> 
If CC_COMPAT is ever specified on the command line as clang (maybe by
some unsuspecting user), we'd loose all of the above flags. Maybe it
would be better to build a set of COMPAT_CLANG_FLAGS and append them to
CC_COMPAT, maybe like below?

Regardless, the current approach works in my testing with clang 9.0.1
and master (clang 11.0.0). This patch specifically is:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build

==================================================================================

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 650cfc5757eb..df5145fab287 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -13,15 +13,16 @@ ifeq ($(CONFIG_CC_IS_CLANG), y)
 COMPAT_GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE_COMPAT)elfedit))
 COMPAT_GCC_TOOLCHAIN := $(realpath $(COMPAT_GCC_TOOLCHAIN_DIR)/..)
 
-CLANG_CC_COMPAT := $(CC)
-CLANG_CC_COMPAT += --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
-CLANG_CC_COMPAT += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
-CLANG_CC_COMPAT += -no-integrated-as -Qunused-arguments
+COMPAT_CLANG_FLAGS := --target=$(notdir $(CROSS_COMPILE_COMPAT:%-=%))
+COMPAT_CLANG_FLAGS += --prefix=$(COMPAT_GCC_TOOLCHAIN_DIR)
+COMPAT_CLANG_FLAGS += -no-integrated-as -Qunused-arguments
 ifneq ($(COMPAT_GCC_TOOLCHAIN),)
-CLANG_CC_COMPAT += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
+COMPAT_CLANG_FLAGS += --gcc-toolchain=$(COMPAT_GCC_TOOLCHAIN)
 endif
 
-CC_COMPAT ?= $(CLANG_CC_COMPAT)
+CC_COMPAT ?= $(CC)
+CC_COMPAT += $(COMPAT_CLANG_FLAGS)
+
 else
 CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
 endif
