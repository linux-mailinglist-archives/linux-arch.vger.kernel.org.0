Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F792043B6
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 00:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgFVWfm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 18:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730826AbgFVWfm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 18:35:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D36C061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:35:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 35so8230572ple.0
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sSqm/4br/2XZ3zIDDWcwJQR4tM1nEgZwvHmLUOL6fDw=;
        b=gkbzBoXV4Pk/cNmx+qHZYboipX5IVfDpxc8N0j4sWU9Ludf+OeYYmtJSZCcAGy8rZg
         aLbU2nyoFvW8UdDGDNRtfLZmmmi4FZwyhj7kombdQ0MHdVzYE8eod+AIGnBwYk9LHuPk
         iWFxpYVFP2202q93vjwPazU6UlNrjNokyuUxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sSqm/4br/2XZ3zIDDWcwJQR4tM1nEgZwvHmLUOL6fDw=;
        b=j2iytp/Iue94kWTHhAW/PmvgR152qzdIUN69a86xKP20YAxd/0FVmHftZznkAiNjZy
         iH+MrcW075Fj0BXnm+LD/jF2MbGkJ6Ha3MwIATg1mTKpzlO2riOdLXRNgXwunmYsm37X
         x30hR256o9yLPjP8fmTHiXfmhNna6l942eEaBnPWnMgkh054uq0cqesjM/5vb8vmMQ8u
         S6P0TEgeIauuKg3KfqBwLF9Gz86BoBRIkhCgEWTPSGLzbJodMkP5egX2jJOlKDsouxoz
         1hyz9Q7BArjBgYPKNVirqLEqj+2ufo4UHPtiBZ6jnxEZ8clpq/RH+NyjUTAPZSG53kCM
         OsOg==
X-Gm-Message-State: AOAM531xalv2xlRFpy5fYHS6MQGvTkkVkHqEFi4mktFtZ9meK9LsmbVC
        Le2P8znJmTENF6wq06DFLvUdxw==
X-Google-Smtp-Source: ABdhPJwfvvR6CY3UBJbGsQJ0ahPvjlO1N9U+ecKxneds6TnG8ZkzU5PH6UA/Txrico1+ry4kLnIw1w==
X-Received: by 2002:a17:902:bb81:: with SMTP id m1mr759742pls.134.1592865341616;
        Mon, 22 Jun 2020 15:35:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n7sm458148pjq.22.2020.06.22.15.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:35:40 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:35:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <202006221534.D22F51D37@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
 <20200622220628.t5fklwmbtqoird5f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622220628.t5fklwmbtqoird5f@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 03:06:28PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly named in the linker
> > script.
> > 
> > Add the common debugging sections. Discard the unused note, rel, plt,
> > dyn, and hash sections that are not needed in the compressed vmlinux.
> > Disable .eh_frame generation in the linker and enable orphan section
> > warnings.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > arch/x86/boot/compressed/Makefile      |  3 ++-
> > arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
> > 2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 7619742f91c9..646720a05f89 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -48,6 +48,7 @@ GCOV_PROFILE := n
> > UBSAN_SANITIZE :=n
> > 
> > KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> > +KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
> > # Compressed kernel should be built as PIE since it may be loaded at any
> > # address by the bootloader.
> > ifeq ($(CONFIG_X86_32),y)
> > @@ -59,7 +60,7 @@ else
> > KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> > 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
> > endif
> > -LDFLAGS_vmlinux := -T
> > +LDFLAGS_vmlinux := --orphan-handling=warn -T
> > 
> > hostprogs	:= mkpiggy
> > HOST_EXTRACFLAGS += -I$(srctree)/tools/include
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index 8f1025d1f681..6fe3ecdfd685 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -75,5 +75,16 @@ SECTIONS
> > 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> > 	_end = .;
> > 
> > +	STABS_DEBUG
> > +	DWARF_DEBUG
> > +
> > 	DISCARDS
> > +	/DISCARD/ : {
> > +		*(.note.*)
> > +		*(.rela.*) *(.rela_*)
> > +		*(.rel.*) *(.rel_*)
> > +		*(.plt) *(.plt.*)
> > +		*(.dyn*)
> > +		*(.hash) *(.gnu.hash)
> > +	}
> > }
> > -- 
> > 2.25.1
> 
> LLD may report warnings for 3 synthetic sections if they are orphans:
> 
> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> 
> Are they described?

Ah, hm. I see gcc is just silent about these. It looks like both regular
and debug kernels end up with those sections for both GCC and Clang. How
would you expect them to be described?

-- 
Kees Cook
