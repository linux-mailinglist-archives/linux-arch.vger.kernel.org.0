Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1032A2353BC
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 19:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgHARM3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Aug 2020 13:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgHARM3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Aug 2020 13:12:29 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5460C06174A;
        Sat,  1 Aug 2020 10:12:28 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id c9so1876482qvu.5;
        Sat, 01 Aug 2020 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2o6GVTZCy3XlmzBSwd7fA26VADSjJEkCYNl3YQKOr2M=;
        b=Ldn6PBxD4m7lMPymQjipKfl27zylKQuiR2k8wfxVSrmlQ5jpqIVVImGSZWjlPgIbGC
         hDJ7BkFuGFrS7733Sa79QeGiqV0qQCemUiXRE/QiwWnLbm5EQ82dmxs/kG3UyfU7E7n8
         nL536EWJMI21gMA9GAQJpy1F9/6iR1lsI9mBQIIRfbo6g7chxN3cmdc3uVhPEga7RQ4V
         TEliR1I27x7f40QWq2Ktg3mUvoW/3WDyyvpBb63myjZ0gnPKNIW0MqE9glVDJBy3Bgqw
         In5hjK+9C4XkaeRowWu/SdcdFCcOWgZbXvoQRkQSw2xxEZumWAOjTxrQxGG+33eaNoFE
         aj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2o6GVTZCy3XlmzBSwd7fA26VADSjJEkCYNl3YQKOr2M=;
        b=Dlxkj4gwDa3VAZVNrv9hw1JojMt5+vpiOLB+vkYEQBPdwM9S5jDV2rIGne+HuUAQOU
         7BlQ/YkXTwh/eVktZHaijfYequ8PWQge+Kk4a/24lKyW5IAq/lQuS8ylOiK2n+Ui4wQp
         7EnrtXgTPfBhCPqZq4DlY58FS7qjlMRiBU9pKOHU5K6UULrmMwWLV6LUuwFR2mdNugu0
         in8ILi+AU9zuXaELgilZFz8+sIOVlpLFCJDMxymC+A9W+q3wMsQiKZZM+z5nsyfuitK8
         RSx21XmrDqODOHGNAu12ZpUO/S/t/hhT+CqFkLlOROoPeREm/4TrqdHi/nHqPrieo+FD
         7UVA==
X-Gm-Message-State: AOAM532WSU+s03VmHGTa7xM8vcen43CLZOlnvD59LN4QYCPK5lKZeCdM
        VXIHBrZ/aXx6iBtB9kUSxKA=
X-Google-Smtp-Source: ABdhPJyvisrUtCH+yT5SZkhMZ5hRzUqOeeL+iqxCLSrjVaYvR2aM1RnsJVQsxy3ZgehzESYLcwGpwg==
X-Received: by 2002:a0c:ffc6:: with SMTP id h6mr9551061qvv.251.1596301947711;
        Sat, 01 Aug 2020 10:12:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i19sm12760874qkk.68.2020.08.01.10.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 10:12:27 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 1 Aug 2020 13:12:25 -0400
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
Message-ID: <20200801171225.GB3249534@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-33-keescook@chromium.org>
 <20200801014755.GA2700342@rani.riverdale.lan>
 <20200801025325.GA2800311@rani.riverdale.lan>
 <202007312235.4A48157938@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202007312235.4A48157938@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 31, 2020 at 10:36:00PM -0700, Kees Cook wrote:
> On Fri, Jul 31, 2020 at 10:53:25PM -0400, Arvind Sankar wrote:
> > On Fri, Jul 31, 2020 at 09:47:55PM -0400, Arvind Sankar wrote:
> > > On Fri, Jul 31, 2020 at 04:08:16PM -0700, Kees Cook wrote:
> > > > For readability, move the zero-sized sections to the end after DISCARDS
> > > > and mark them NOLOAD for good measure.
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  arch/x86/boot/compressed/vmlinux.lds.S | 42 +++++++++++++++-----------
> > > >  1 file changed, 25 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > index 3c2ee9a5bf43..42dea70a5091 100644
> > > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > > @@ -42,18 +42,16 @@ SECTIONS
> > > >  		*(.rodata.*)
> > > >  		_erodata = . ;
> > > >  	}
> > > > -	.rel.dyn : {
> > > > -		*(.rel.*)
> > > > -	}
> > > > -	.rela.dyn : {
> > > > -		*(.rela.*)
> > > > -	}
> > > > -	.got : {
> > > > -		*(.got)
> > > > -	}
> > > >  	.got.plt : {
> > > >  		*(.got.plt)
> > > >  	}
> > > > +	ASSERT(SIZEOF(.got.plt) == 0 ||
> > > > +#ifdef CONFIG_X86_64
> > > > +	       SIZEOF(.got.plt) == 0x18,
> > > > +#else
> > > > +	       SIZEOF(.got.plt) == 0xc,
> > > > +#endif
> > > > +	       "Unexpected GOT/PLT entries detected!")
> > > >  
> > > >  	.data :	{
> > > >  		_data = . ;
> > > > @@ -85,13 +83,23 @@ SECTIONS
> > > >  	ELF_DETAILS
> > > >  
> > > >  	DISCARDS
> > > > -}
> > > >  
> > > > -ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > > > -#ifdef CONFIG_X86_64
> > > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> > > > -#else
> > > > -ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> > > > -#endif
> > > > +	/*
> > > > +	 * Sections that should stay zero sized, which is safer to
> > > > +	 * explicitly check instead of blindly discarding.
> > > > +	 */
> > > > +	.got (NOLOAD) : {
> > > > +		*(.got)
> > > > +	}
> > > > +	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> > > >  
> > > > -ASSERT(SIZEOF(.rel.dyn) == 0 && SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations detected!")
> > > > +	/* ld.lld does not like .rel* sections being made "NOLOAD". */
> > > > +	.rel.dyn : {
> > > > +		*(.rel.*)
> > > > +	}
> > > > +	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> > > > +	.rela.dyn : {
> > > > +		*(.rela.*)
> > > > +	}
> > > > +	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> > > > +}
> > > > -- 
> > > > 2.25.1
> > > > 
> > > 
> > > There's no point in marking zero-size sections NOLOAD -- if the ASSERT's
> > > passed, they won't be present in the file at all anyway.
> > > 
> > > The only section for which there might be a point is .got.plt, which is
> > > non-empty on 32-bit, and only if it is first moved to the end. That
> > > saves a few bytes.
> > 
> > Btw, you should move .got.plt also to the end anyway for readability,
> > it's unused even if non-empty. And with the ASSERT being placed
> > immediately after it, it's even more distracting from the actual section
> > layout.
> 
> ld.bfd (if I'm remembering correctly) was extraordinarily upset about it
> being at the end. I will retest and report back.
> 
> -- 
> Kees Cook

Actually, moving it to the end also requires marking it INFO or
stripping it out when creating the bzImage. Otherwise we get back to
that old problem of materializing .bss/.pgtable in the bzImage.
