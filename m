Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB320434A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgFVWGd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 18:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbgFVWGd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:06:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E0C061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:06:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a127so9028828pfa.12
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NZrrNoLnR5tCsJjwkOg87lF2Y56Tb3KMrg75SysWUh0=;
        b=UIzUj+ug47F49Sp5vy/xR5WhNyTvMNN8hgmawE2K2svYVAvNR0eQkRlHf/Lm0FZZ/X
         7StKvXgVAWbI70D4t9TSVT46cI8wFgWe18KjZIUU2gbeYlypeQsSuhPwI5EvJGBXCknL
         /Sjqg8ACv3WsHhLOyyN1tYm7FtO7k1lZ7q32rJdr8zHbaa4KTHMBuv2T1BhpwNtUagCo
         l8awFGTwHbMp5iHCVsrWdKZ6GOvVD5DtxBa7R/FXwcFNEinFzoIb9d5pNE8nG9vruzlQ
         ZaHn86AGS9putBcaNX0ZgGsgbwCZlbN6Wefc6qbtKgCp3IYJF+C29+n//2QRwmI9FUmO
         aMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZrrNoLnR5tCsJjwkOg87lF2Y56Tb3KMrg75SysWUh0=;
        b=RWySxS16rT0eY/qLkAM7l/177X8lcmun21LrTkeKjhUb3Dx5wNU+tOSOL+gtbc21c0
         IkAzFk+XL2UooNWmImhotJjZ7eO5KBAC7ZkrRiVXajyaYxvimp9e3wH718EG6AaFmJMm
         /Bp7zqHaWdNLlhiDqbGUo1peHd6JkDB3H+fAHC3kiKI5GeJOEFRasWp+OYdMOFvHxMbJ
         /akJ/z7N4y6PQI8ZJ4mzIwuq2iW6mvgq54G35XQTaZBx1wXKsCd4IPJPFniqXr/0nES8
         BGPVjUfGFrFkGk3jIL/w7v/H2foWTxTL8KBHMSBxYW6oZ2EUFpUdfXyK31+DsM9d3qoC
         +vZQ==
X-Gm-Message-State: AOAM530yMmgJXXxwP/sOZZiXHvbIr1sg38DXYmsApEZYpZCZDyP4PNYK
        oISFsb/vnMBPT22iGVtEAEaQ7g==
X-Google-Smtp-Source: ABdhPJyNkaobMn6YLoXR3doV+X4hJSzTo2xEgfFEsiR9ry8ddLYa0F9ofhKFdLKf1wkYt7vFqeoUEA==
X-Received: by 2002:a63:1d4d:: with SMTP id d13mr6212600pgm.28.1592863592255;
        Mon, 22 Jun 2020 15:06:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id g65sm14702797pfb.61.2020.06.22.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:06:31 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:06:28 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <20200622220628.t5fklwmbtqoird5f@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622205341.2987797-4-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>We don't want to depend on the linker's orphan section placement
>heuristics as these can vary between linkers, and may change between
>versions. All sections need to be explicitly named in the linker
>script.
>
>Add the common debugging sections. Discard the unused note, rel, plt,
>dyn, and hash sections that are not needed in the compressed vmlinux.
>Disable .eh_frame generation in the linker and enable orphan section
>warnings.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> arch/x86/boot/compressed/Makefile      |  3 ++-
> arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
> 2 files changed, 13 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>index 7619742f91c9..646720a05f89 100644
>--- a/arch/x86/boot/compressed/Makefile
>+++ b/arch/x86/boot/compressed/Makefile
>@@ -48,6 +48,7 @@ GCOV_PROFILE := n
> UBSAN_SANITIZE :=n
>
> KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
> # Compressed kernel should be built as PIE since it may be loaded at any
> # address by the bootloader.
> ifeq ($(CONFIG_X86_32),y)
>@@ -59,7 +60,7 @@ else
> KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
> endif
>-LDFLAGS_vmlinux := -T
>+LDFLAGS_vmlinux := --orphan-handling=warn -T
>
> hostprogs	:= mkpiggy
> HOST_EXTRACFLAGS += -I$(srctree)/tools/include
>diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>index 8f1025d1f681..6fe3ecdfd685 100644
>--- a/arch/x86/boot/compressed/vmlinux.lds.S
>+++ b/arch/x86/boot/compressed/vmlinux.lds.S
>@@ -75,5 +75,16 @@ SECTIONS
> 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> 	_end = .;
>
>+	STABS_DEBUG
>+	DWARF_DEBUG
>+
> 	DISCARDS
>+	/DISCARD/ : {
>+		*(.note.*)
>+		*(.rela.*) *(.rela_*)
>+		*(.rel.*) *(.rel_*)
>+		*(.plt) *(.plt.*)
>+		*(.dyn*)
>+		*(.hash) *(.gnu.hash)
>+	}
> }
>-- 
>2.25.1

LLD may report warnings for 3 synthetic sections if they are orphans:

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

Are they described?
