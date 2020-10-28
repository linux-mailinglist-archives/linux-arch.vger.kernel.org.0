Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E02F29E245
	for <lists+linux-arch@lfdr.de>; Thu, 29 Oct 2020 03:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgJ2CMI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Oct 2020 22:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgJ1Vgb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Oct 2020 17:36:31 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3287C0613CF;
        Wed, 28 Oct 2020 14:36:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j18so558159pfa.0;
        Wed, 28 Oct 2020 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w1z4WmWcLWyyqsDJon/u9K8bQjOmOpYyTbSE3GXlbcE=;
        b=KmnzLyn6+i47a2oCXFfbgt2Tl8Pl3YHx/z1ecMXZptZN4+33a97ws0FeT7y7jVKJOV
         JkZrCjLxHhLLjhAObO34l1ZOruX9V27jywR7gnnYUyENTcDmOFnHqs17aihRwsZCin92
         WBmDtijEWJEifi1t8tBx8Ox4uhm/3p+ZrnbKqjs8eVcrZROtMAjXBdYVV6OqpxKaebr5
         4yf+pklO5ndbVUsQwkvo9hqWmfV+pkzJ2HnHyHDOE6Yb5rjoe8pYoM7FK97ileQiaS6t
         zQnbU14uXJfXVT2cqwSXYdHjFcUQRZc7SanlIjeBTz9uOTVyv0kREmVrfrxVtq6a0nrP
         e4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w1z4WmWcLWyyqsDJon/u9K8bQjOmOpYyTbSE3GXlbcE=;
        b=jZ1+G0s5fDIHAM1T4xx6AzuzqNQR+DbQOulcwZonrhBx+wwBDGiV8g3pCXi2ksWOOj
         jOiTqkHTC/ktKDPETJJ0tz1jGNWa5hOZPmNnq2mlEtRL/cv3FyFMwAcYMkZyLUGqejxH
         54ab2fDe+y2RTasa4GZ3wRE49G80ciNLseJ985fzxesyvSeVhF7NZURNe+l9x9VwKKYI
         E/U0EB9h3oO58es2tisCMgo/Z3gqZPRD1doSYEfGY59E91XVOOMk2OZmvlNSU5KeTU5B
         HlHaUVrUFSeIQa1BhpT1GCnyCb42ditzkAO3DsVK7BIIJMIY8gHZpKyufaA4kClab+D6
         3K8g==
X-Gm-Message-State: AOAM53358mIZqQTHA3g1YMbaeP1rUWVLXRKPxkGE7lyx20rMGaZMmMwN
        5EvXE7VjNaOVirTaMc8U4zk=
X-Google-Smtp-Source: ABdhPJzc8SV3mCeTDsHSaTgxv1uPpdKkvU4mR2f4hj7joD1tL0pet8MnLxwK4NjP52rxZMSdgkeKnw==
X-Received: by 2002:a17:90b:1043:: with SMTP id gq3mr873181pjb.213.1603920990427;
        Wed, 28 Oct 2020 14:36:30 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::4:1c8])
        by smtp.gmail.com with ESMTPSA id 189sm511557pfw.215.2020.10.28.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:36:29 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:36:14 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Message-ID: <20201028213614.kqk7atvk6fcjely4@ast-mbp.dhcp.thefacebook.com>
References: <20200821194310.3089815-14-keescook@chromium.org>
 <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
 <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
 <CAKwvOdkE=ViGOhvoBRcV=9anjowC_vb4Vtefp9010+sC4c_+Sw@mail.gmail.com>
 <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 09:15:17PM +0100, Ard Biesheuvel wrote:
> On Tue, 27 Oct 2020 at 21:12, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 12:25 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > >
> > > Hi Nick,
> > >
> > > CC Josh
> > >
> > > On Mon, Oct 26, 2020 at 6:49 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > > On Mon, Oct 26, 2020 at 10:44 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Mon, Oct 26, 2020 at 6:39 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > On Mon, 26 Oct 2020 at 17:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Mon, Oct 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > On Mon, Oct 26, 2020 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > > I.e. including the ".eh_frame" warning. I have tried bisecting that
> > > > > > > > > warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
> > > > > > > > > commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
> > > > > > > > > placement"), which is another red herring.
> > > > > > > >
> > > > > > > > kernel/bpf/core.o is the only file containing an eh_frame section,
> > > > > > > > causing the warning.
> > > >
> > > > When I see .eh_frame, I think -fno-asynchronous-unwind-tables is
> > > > missing from someone's KBUILD_CFLAGS.
> > > > But I don't see anything curious in kernel/bpf/Makefile, unless
> > > > cc-disable-warning is somehow broken.
> > >
> > > I tracked it down to kernel/bpf/core.c:___bpf_prog_run() being tagged
> > > with __no_fgcse aka __attribute__((optimize("-fno-gcse"))).
> > >
> > > Even if the function is trivially empty ("return 0;"), a ".eh_frame" section
> > > is generated.  Removing the __no_fgcse tag fixes that.
> >
> > That's weird.  I feel pretty strongly that unless we're working around
> > a well understood compiler bug with a comment that links to a
> > submitted bug report, turning off rando compiler optimizations is a
> > terrible hack for which one must proceed straight to jail; do not pass
> > go; do not collect $200.  But maybe I'd feel differently for this case
> > given the context of the change that added it.  (Ard mentions
> > retpolines+orc+objtool; can someone share the relevant SHA if you have
> > it handy so I don't have to go digging?)
> 
> commit 3193c0836f203a91bef96d88c64cccf0be090d9c
> Author: Josh Poimboeuf <jpoimboe@redhat.com>
> Date:   Wed Jul 17 20:36:45 2019 -0500
> 
>     bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
> 
> has
> 
> Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")

That commit is broken.
I had this patch in my queue:
-#define __no_fgcse __attribute__((optimize("-fno-gcse")))
+#define __no_fgcse __attribute__((optimize("-fno-gcse,-fno-omit-frame-pointer")))

Sounds like you want to add -fno-asynchronous-unwind-tables to the above list?

> and mentions objtool and CONFIG_RETPOLINE.
> 
> >  (I feel the same about there
> > being an empty asm(); statement in the definition of asm_volatile_goto
> > for compiler-gcc.h).  Might be time to "fix the compiler."
> >
> > (It sounds like Arvind is both in agreement with my sentiment, and has
> > the root cause).
> >
> 
> I agree that the __no_fgcse hack is terrible. Does Clang support the
> following pragmas?
> 
> #pragma GCC push_options
> #pragma GCC optimize ("-fno-gcse")
> #pragma GCC pop_options

That will work too, but optimize("-fno...,-fno..,-fno..") is imo cleaner.
