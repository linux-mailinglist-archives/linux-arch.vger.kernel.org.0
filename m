Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532D223538A
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 19:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHARAy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Aug 2020 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgHARAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Aug 2020 13:00:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6743C06174A;
        Sat,  1 Aug 2020 10:00:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so31780280qka.3;
        Sat, 01 Aug 2020 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mJ6hTZT24AWhGEqcPC20wN8kBdsxrLI/peNCFh80II0=;
        b=nUZWj8j7d2X5T3sH7PVKVcJ/tJMEQcJ4psgs1gcLJol13d1RvdpJ4+3wBuHldXvZBk
         SjZOvjpj18wRh7IwgoW/w72o85g6VIRQqsdhKjeIodtrCeem5YngLBL+85bAezTuvvQ9
         gEA47e7rp1XiVJR6GxAXnZ2zwYbpQ+pT01pVgaUCkcAdJldxGCrlhU5wzfAzTNrVtyoU
         4P/Sa+lAMZnq3EELOqy7A33g+g3Vfw0ZCcJ8dsIqesEfsByzZ6GVh9zuW/kiQbWuhoYR
         vFRgJxZpHOWpv2hrariGEk0FnyOTVNVtkFKl2PLFAHHG4yf9tW71qTdizyL74bOdX69I
         0Ttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mJ6hTZT24AWhGEqcPC20wN8kBdsxrLI/peNCFh80II0=;
        b=VM39u3hJ9qDcsincVg70EDwD/D8+B/9JietPzOHR+dlqoI0BdVl5fIS5PAqahIRxxm
         C0v4H/ZDrqcPVZXNy7t7uV+ue24NSPNtd9vnAAIrGjxt3X+WhfWjY2rbjyc2NVMKvDGy
         QFyQVg1QbZdaFcWJ14EySTREDTFZkEkTDmdUT947wrzpCONYoGPNt9FTe/YN04xLSP8S
         06oQpN14oVwwXQkIevmq2s9kTcsdtLy/NvZOo/10CIemg31JsV+wMvHp4UQN7oZT1EqR
         wdstypXGTKefNJVRoFb5rafQLA5t319mAa/BVu49yhKBdW35TKDBqTisuBz+P4aHFtyB
         Ag4w==
X-Gm-Message-State: AOAM530qy3R5c3DEZNoFJP1Wt2ziLYJFYH+v0riqKzjtVnfrKRR9paAw
        ZGxZUNFmsUxa0CU/x7ybR/o=
X-Google-Smtp-Source: ABdhPJzCKZ2YWRRKt7EbAjYlMwe4HoJyEC/wkWrDWjL843q2i/oFkciOE/2KezdZ9h6RIJbu6Yv/dQ==
X-Received: by 2002:a37:aa56:: with SMTP id t83mr9283794qke.150.1596301252633;
        Sat, 01 Aug 2020 10:00:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m26sm14886142qtc.83.2020.08.01.10.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 10:00:51 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 1 Aug 2020 13:00:49 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 32/36] x86/boot/compressed: Reorganize zero-size
 section asserts
Message-ID: <20200801170049.GA3249534@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
 <20200801014755.GA2700342@rani.riverdale.lan>
 <202007312233.1BA0E2EFC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007312233.1BA0E2EFC@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 31, 2020 at 10:35:14PM -0700, Kees Cook wrote:
> On Fri, Jul 31, 2020 at 09:47:55PM -0400, Arvind Sankar wrote:
> > On Fri, Jul 31, 2020 at 04:08:16PM -0700, Kees Cook wrote:
> > > For readability, move the zero-sized sections to the end after DISCARDS
> > > and mark them NOLOAD for good measure.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
> > >  1 file changed, 25 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > index 3c2ee9a5bf43..42dea70a5091 100644
> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > @@ -42,18 +42,16 @@ SECTIONS
> > >  		*(.rodata.*)
> > >  		_erodata = . ;
> > >  	}
> > > -	.rel.dyn : {
> > > -		*(.rel.*)
> > > -	}
> > > -	.rela.dyn : {
> > > -		*(.rela.*)
> > > -	}
> > > -	.got : {
> > > -		*(.got)
> > > -	}
> > >  	.got.plt : {
> > >  		*(.got.plt)
> > >  	}
> > > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > > +#ifdef CONFIG_X86_64
> > > +	       SIZEOF(.got.plt) == 0x18,
> > > +#else
> > > +	       SIZEOF(.got.plt) == 0xc,
> > > +#endif
> > > +	       "Unexpected GOT/PLT entries detected!")
> > >  
> > >  	.data :	{
> > >  		_data = . ;
> > > @@ -85,13 +83,23 @@ SECTIONS
> > >  	ELF_DETAILS
> > >  
> > >  	DISCARDS
> > > -}
> > >  
> > > -ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > > -#ifdef CONFIG_X86_64
> > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > > -#else
> > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > > -#endif
> > > +	/*
> > > +	 * Sections that should stay zero sized, which is safer to
> > > +	 * explicitly check instead of blindly discarding.
> > > +	 */
> > > +	.got (NOLOAD) : {
> > > +		*(.got)
> > > +	}
> > > +	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > >  
> > > -ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> > > +	/* ld.lld does not like .rel* sections being made "NOLOAD". */
> > > +	.rel.dyn : {
> > > +		*(.rel.*)
> > > +	}
> > > +	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> > > +	.rela.dyn : {
> > > +		*(.rela.*)
> > > +	}
> > > +	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> > > +}
> > > -- 
> > > 2.25.1
> > > 
> > 
> > There's no point in marking zero-size sections NOLOAD -- if the ASSERT's
> > passed, they won't be present in the file at all anyway.
> 
> I did not find that universally true. I found some sections be written
> out with a 0 size. Some I could remove from disk with NOLOAD, others did
> not like that so much.

Neither LLD nor BFD is creating 0-sized .got or .rel sections in my
builds. In any case, if they're 0-sized, NOLOAD shouldn't affect
anything: it doesn't remove them from disk, it stops them being loaded
into memory, which is a nop if it was 0-sized.

> 
> > The only section for which there might be a point is .got.plt, which is
> > non-empty on 32-bit, and only if it is first moved to the end. That
> > saves a few bytes.
> 
> What do you mean about "only if it is first moved to the end"? Would it
> be zero-sized if it was closer to .text?
> 
> -- 
> Kees Cook

Sorry, my sentence is confusingly worded: it's always non-empty on
x86-32. I meant, move .got.plt to the end (after _end), add (INFO) to
it, and it might save a few bytes, or not, depending on alignment
padding. If it's left in the middle, it still pushes the addresses of
the remaining sections out, so it doesn't save anything.

I'd tested that out the last time we talked about this, but left it out
of my series as Fangrui was negative about the idea.

I tested with NOLOAD instead of INFO, and at least ld.bfd actually
errors out if .got.plt is marked NOLOAD, no matter where it's located.

	  LDS     arch/x86/boot/compressed/vmlinux.lds
	  LD      arch/x86/boot/compressed/vmlinux
	ld: final link failed: section has no contents

Side note: I also discovered something peculiar with the gcc/lld combo.
On x86-64, it turns out that this still generates a .got.plt section,
which was unexpected as _GLOBAL_OFFSET_TABLE_ shouldn't be referenced on
64-bit. It turns out that when gcc (or even clang) generates an
out-of-line call to memcpy from a __builtin_memcpy call, it doesn't
declare the memcpy as hidden even with Ard's hidden.h, or even if memcpy
was explicitly declared with hidden visibility. It uses memcpy@PLT
instead of memcpy, and this generates a reference to
_GLOBAL_OFFSET_TABLE_ in the .o file.  The linker later converts this to
a direct call to the function, but LLD leaves .got.plt in the
executable, while BFD strips it out.

It also turns out that clang's integrated assembler, unlike gas, does
not generate a reference to _GLOBAL_OFFSET_TABLE for a foo@PLT call. And
because we redefine KBUILD_CFLAGS in boot/compressed Makefile, we lose
the -no-integrated-as option, and clang is using its integrated
assembler when building the compressed kernel.
