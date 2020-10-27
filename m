Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD129CB33
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 22:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373894AbgJ0VYb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 17:24:31 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41644 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373905AbgJ0VYa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 17:24:30 -0400
Received: by mail-qv1-f66.google.com with SMTP id t20so1412587qvv.8;
        Tue, 27 Oct 2020 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0FLU/FMaC6xi93uyz3KYGgImr83ejyr3rVqberCTz8k=;
        b=dkXJ1GSVCppJUvQ/xtB3Ft8YI5E+amj3w3waz1qiU4Iwmi3Un5u5X1EsbK8nrBVjCG
         DXRbZKY3fe8uoLLaVaGQZ/VPoii7x29thiNnwCgT2qMQlqmb+qNYYjipWqa4w20OtaJR
         NwzC7YBVkN+33aDL6UKL1IxEGtiapGrVob2EoEKsh+ZeZaUwmtfT/UaWrfq+jv4Hv/F2
         Z9H7jlVEfZ1vO66FLijNvpd3hCnIC1h4B7azC4n55P8ye+4CmTtCWo0b+KnV1tddxrWu
         zEhmTwJgPn9ZJcAfiL5WZCFK2guhgtLiB/hqZu1Lh4qYFC299/1Wf6T/8XUUTe8Q641B
         Dpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0FLU/FMaC6xi93uyz3KYGgImr83ejyr3rVqberCTz8k=;
        b=JZC1edWxi5VB9JowdcHjMAaqE7X6ABYcSckv0LKV1RuH6kQz2fJDBKNN3Vka9G2zWg
         u5T8IhKCYOLSQjrqRIgTbS6amBPReOFmcly3NbloiUBppFv8Oy0AUgZhS8cH60Fz6h7v
         pB7uyUc+yZtSJqWPL4fSzPQWoY+3R6rEHFmGN0ROqPoUrA1aT7gzN9f+R1cVFhiT+gfh
         KeMWRSh4Ylo6cwE2mIOT1ay5SKDKyhqXJCUUy61JSXsfVVYuktzCAvxkYGFIbh02KHtp
         fBBp1esSykYZVFBxYcaKPBWSLIfSY6IYDkOBzEzlbg0nSTr6d7o5Di7H9bGektfPGppi
         Q5lA==
X-Gm-Message-State: AOAM531EcMo1xvI2Zx5pwV95E/v1lky8+BV6CueF64vxmNxws6C36XsV
        2zum/paFVQ5UuJ3rFGdKhJ0=
X-Google-Smtp-Source: ABdhPJyvtxq6sDU8cIVFymxwnGa/RkhzpwtR6o+hMYO+xeaMR4GjxoFwm7weQnHQ58IIwTZYeOMu5Q==
X-Received: by 2002:a0c:8246:: with SMTP id h64mr4822578qva.54.1603833869124;
        Tue, 27 Oct 2020 14:24:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p136sm1640544qke.25.2020.10.27.14.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 14:24:28 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 27 Oct 2020 17:24:25 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel-toolchains@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
Message-ID: <20201027212425.GD1833548@rani.riverdale.lan>
References: <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
 <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
 <CAKwvOdkE=ViGOhvoBRcV=9anjowC_vb4Vtefp9010+sC4c_+Sw@mail.gmail.com>
 <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
 <CAKwvOd=8YO3Vm0DuaWpDigMiwni+fVdrpagZtsROGziinjLvig@mail.gmail.com>
 <20201027203001.GA1833548@rani.riverdale.lan>
 <CAKwvOdmrjeLpS8H_uf_cfbOYFvE-ZhOdJQ14o4VoNF8ugARA0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmrjeLpS8H_uf_cfbOYFvE-ZhOdJQ14o4VoNF8ugARA0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 01:40:43PM -0700, Nick Desaulniers wrote:
> On Tue, Oct 27, 2020 at 1:30 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Oct 27, 2020 at 01:17:55PM -0700, Nick Desaulniers wrote:
> > > > >  (I feel the same about there
> > > > > being an empty asm(); statement in the definition of asm_volatile_goto
> > > > > for compiler-gcc.h).  Might be time to "fix the compiler."
> > > > >
> > > > > (It sounds like Arvind is both in agreement with my sentiment, and has
> > > > > the root cause).
> > > > >
> > Btw, the bug mentioned in asm_volatile_goto seems like its been fixed in
> > 4.9, so the hack could be dropped now?
> 
> https://lore.kernel.org/lkml/20180907222109.163802-1-ndesaulniers@google.com/
> 
> For the life of me I can't find Linus' response.  Maybe he shot it
> down in the PR, but I can't find it...Miguel do you recall?  I could
> paraphrase, but might be better to not rely on my memory.
> -- 
> Thanks,
> ~Nick Desaulniers

You couldn't find it in July either :)
https://lkml.org/lkml/2020/7/10/1026

Possibly he didn't like the version check? That should be unnecessary now.
