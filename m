Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7529CA2D
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 21:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372899AbgJ0UaG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 16:30:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45226 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372894AbgJ0UaG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 16:30:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id 188so2519368qkk.12;
        Tue, 27 Oct 2020 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pTfXLkUKJcoocwAw1MeELq2/Ah/3yvNDEolWgsyMElU=;
        b=Q5lrtyimNp/GH2HLr2f3gpGZrDsx/FjkIOPDACzMb7NDXOrHRTwhXxdtZrqtPZsBot
         /Xhsg1G0rVa9a0DxOI0bUj8yoO58aJMkrp0jdfgERpTOeEPZ3ynhtbFpKknRzAlk29zz
         axsL6lCyqJyuBV1f4Ica4nNXe649p79NNDqXeUVms8qszp69b4wzdNGMkW8oiEyo8df2
         fxBzmwHQsAU+YXmLPT5yLOhwZbNp32k2aKJ6RR9TtT884JNrzjvQ12ea8NYXyGiMBk/F
         ZJtAX086HFmdxJfDNiCMEp3Tr1Onqo8PDfpBAZtOO249DxwcObr7CjJkSxXdIBKY+Lsg
         iB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pTfXLkUKJcoocwAw1MeELq2/Ah/3yvNDEolWgsyMElU=;
        b=DO82RT2mwZ35wNqyISziQicyvHpJgxxfWzMMB56gG6V1DbsaikoInqtYUb0isdsLC8
         B9/Bquzyd7zX48jFfMAeCuQs4knQuLRvKCoueIQPHJ/oNebwvk78UEH1GjuoYIN/GaTu
         N/mxXKaBCrwEbni/H339Ds0cKFH+0nbSg2dbbR58Ec72dYMbRYlEZ0O2LgAS51hf6PQM
         5MqGQcs3/c5N7mJSeSD7Fz9MFtMf/aaezj3xhvV9jCI/hCuGrn2N96hUPH2zPfuJO3YD
         L1zNvpToS7CURdrVPAWPZg4RJdrLXjr/97e+QxWV56C1PGN9P5KVzora2GPm3b0DgK6Q
         X8Kw==
X-Gm-Message-State: AOAM530GcKw+id0CtlnhD5UI1u+9u4wT1o6G/IjHjY0HRpMxXZmfYlZ7
        PHQbF7lqQ+96zSE6DR7ejsU=
X-Google-Smtp-Source: ABdhPJyVdWnZxrvjlPKa1Zli67mpvt40pZAWRVvGroOz15avhiMyv9GHvjgyCXpsLh1G9Ug6AlLQHA==
X-Received: by 2002:a37:4f92:: with SMTP id d140mr3840320qkb.402.1603830603983;
        Tue, 27 Oct 2020 13:30:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b23sm1454393qkh.68.2020.10.27.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:30:03 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 27 Oct 2020 16:30:01 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <20201027203001.GA1833548@rani.riverdale.lan>
References: <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
 <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
 <CAKwvOdkE=ViGOhvoBRcV=9anjowC_vb4Vtefp9010+sC4c_+Sw@mail.gmail.com>
 <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
 <CAKwvOd=8YO3Vm0DuaWpDigMiwni+fVdrpagZtsROGziinjLvig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=8YO3Vm0DuaWpDigMiwni+fVdrpagZtsROGziinjLvig@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 01:17:55PM -0700, Nick Desaulniers wrote:
> On Tue, Oct 27, 2020 at 1:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 27 Oct 2020 at 21:12, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Oct 27, 2020 at 12:25 PM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > >
> > > > Hi Nick,
> > > >
> > > > CC Josh
> > > >
> > > > On Mon, Oct 26, 2020 at 6:49 PM Nick Desaulniers
> > > > <ndesaulniers@google.com> wrote:
> > > > > On Mon, Oct 26, 2020 at 10:44 AM Geert Uytterhoeven
> > > > > <geert@linux-m68k.org> wrote:
> > > > > > On Mon, Oct 26, 2020 at 6:39 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > > On Mon, 26 Oct 2020 at 17:01, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > On Mon, Oct 26, 2020 at 2:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > > On Mon, Oct 26, 2020 at 1:29 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > > > I.e. including the ".eh_frame" warning. I have tried bisecting that
> > > > > > > > > > warning (i.e. with be2881824ae9eb92 reverted), but that leads me to
> > > > > > > > > > commit b3e5d80d0c48c0cc ("arm64/build: Warn on orphan section
> > > > > > > > > > placement"), which is another red herring.
> > > > > > > > >
> > > > > > > > > kernel/bpf/core.o is the only file containing an eh_frame section,
> > > > > > > > > causing the warning.
> > > > >
> > > > > When I see .eh_frame, I think -fno-asynchronous-unwind-tables is
> > > > > missing from someone's KBUILD_CFLAGS.
> > > > > But I don't see anything curious in kernel/bpf/Makefile, unless
> > > > > cc-disable-warning is somehow broken.
> > > >
> > > > I tracked it down to kernel/bpf/core.c:___bpf_prog_run() being tagged
> > > > with __no_fgcse aka __attribute__((optimize("-fno-gcse"))).
> > > >
> > > > Even if the function is trivially empty ("return 0;"), a ".eh_frame" section
> > > > is generated.  Removing the __no_fgcse tag fixes that.
> > >
> > > That's weird.  I feel pretty strongly that unless we're working around
> > > a well understood compiler bug with a comment that links to a
> > > submitted bug report, turning off rando compiler optimizations is a
> > > terrible hack for which one must proceed straight to jail; do not pass
> > > go; do not collect $200.  But maybe I'd feel differently for this case
> > > given the context of the change that added it.  (Ard mentions
> > > retpolines+orc+objtool; can someone share the relevant SHA if you have
> > > it handy so I don't have to go digging?)
> >
> > commit 3193c0836f203a91bef96d88c64cccf0be090d9c
> > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> > Date:   Wed Jul 17 20:36:45 2019 -0500
> >
> >     bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
> >
> > has
> >
> > Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")
> >
> > and mentions objtool and CONFIG_RETPOLINE.
> >
> > >  (I feel the same about there
> > > being an empty asm(); statement in the definition of asm_volatile_goto
> > > for compiler-gcc.h).  Might be time to "fix the compiler."
> > >
> > > (It sounds like Arvind is both in agreement with my sentiment, and has
> > > the root cause).
> > >
> >
> > I agree that the __no_fgcse hack is terrible. Does Clang support the
> > following pragmas?
> >
> > #pragma GCC push_options
> > #pragma GCC optimize ("-fno-gcse")
> > #pragma GCC pop_options
> >
> > ?
> 
> Put it in godbolt.org.  Pretty sure it's `#pragma clang` though.
> `#pragma GCC` might be supported in clang or silently ignored, but
> IIRC pragmas were a bit of a compat nightmare.  I think Arnd wrote
> some macros to set pragmas based on toolchain.  (Uses _Pragma, for
> pragmas in macros, IIRC).
> 
> -- 
> Thanks,
> ~Nick Desaulniers

https://gcc.gnu.org/onlinedocs/gcc/Function-Specific-Option-Pragmas.html#Function-Specific-Option-Pragmas

#pragma GCC optimize is equivalent to the function attribute, so does
that actually help?

Btw, the bug mentioned in asm_volatile_goto seems like its been fixed in
4.9, so the hack could be dropped now?
