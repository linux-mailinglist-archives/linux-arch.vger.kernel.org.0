Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34845467BD3
	for <lists+linux-arch@lfdr.de>; Fri,  3 Dec 2021 17:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382212AbhLCQzJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Dec 2021 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382228AbhLCQzF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2021 11:55:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0CC061751;
        Fri,  3 Dec 2021 08:51:41 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x131so3413112pfc.12;
        Fri, 03 Dec 2021 08:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwi5v9qtUWNkWjS5o3WH11GAvDMXz6rWxjTjENaT30s=;
        b=LZeUpNxTPd0EXcLHcrWRi/2ayZQyrQjvM+/qr0rP8vFQqb4dFzLJtXIAS8fhWqfz9f
         u1oWDEobPzQQtl4sAxYhAzVcUlTaSIdS/RN3TsMo2tPjWsg6/O5irwdrxi/yr89yu50E
         6zskiZouyvljrobD5PWLduCSy0zTsly404ZX7IJBw2DNkxnYqZeUyRBRrsWpTcMd+ZOe
         u1/GkzbymXp1qYCuYPt3RFusJEn7GGYcymFLp6jRYiwZj4ZIHFEnMEUeMVwsO29ud72z
         rJ/Dqy8ky6YIag0E1te+Aq274vMY7wxxiQdKiWqUxQ3ikCW0Z7IXRKTPyUha8nqjTSIW
         8OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwi5v9qtUWNkWjS5o3WH11GAvDMXz6rWxjTjENaT30s=;
        b=gzbjgFArWs1Qxj1waaoepUjE2bz2mfzgwQS6rhQNdBCnqSdpm0L1BcV1ekefod3QFe
         zDmo7KRfLzebPTpOGKU6J5+OVsj8GvGnE6dd5E9DNaIAXTOkN3Rt3lI9YDTcNhoc8eEr
         oFRdsEUy1NvY2uQd/HgsJCS6fbYmi5KUPDA2dmkm/Bt83b8v84tVp6tCUgwXzOD5Wf2u
         2Zvy9cKJHTlxVf00+ZMYfgxq6NWfypTNfKSLP9QYUxZ6GTG7opDVB4F7cix+drVYe3zn
         RUh438/1mE9/1CupBKFt8iA+jfp9kUk+B7lE/Cs6sDUPh8lQrHaJaUf6U0Z7+Wx713fU
         grEQ==
X-Gm-Message-State: AOAM533bO6UQAOHPsujvF3g1/o8CT6x00IE1C1dlG6setguDhW2OH/2T
        B+c3Qk2l6rd9fX0fjL7Aic9fzYCcSqabKCwxI38=
X-Google-Smtp-Source: ABdhPJzpOHOaaZjZjKrJWMwkfziEkarJeedQt9d36XOYqS8Ki8b+NdSRElS4KnL2lchHl3m6MaWEIlKOo0gdxOnjdrc=
X-Received: by 2002:a63:4f42:: with SMTP id p2mr5374964pgl.381.1638550300680;
 Fri, 03 Dec 2021 08:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20211202223214.72888-1-alexandr.lobakin@intel.com>
 <20211202223214.72888-6-alexandr.lobakin@intel.com> <Yanm6tJ2obi1aKv6@hirez.programming.kicks-ass.net>
 <20211203141051.82467-1-alexandr.lobakin@intel.com> <20211203163424.GK16608@worktop.programming.kicks-ass.net>
In-Reply-To: <20211203163424.GK16608@worktop.programming.kicks-ass.net>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 3 Dec 2021 08:51:04 -0800
Message-ID: <CAMe9rOrVnb3oVRn5igjwimBbE6QH-v0tuHk-kjRz7osbJMQd1w@mail.gmail.com>
Subject: Re: [PATCH v8 05/14] x86: conditionally place regular ASM functions
 into separate sections
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        linux-hardening@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        live-patching@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 3, 2021 at 8:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Dec 03, 2021 at 03:10:51PM +0100, Alexander Lobakin wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Fri, 3 Dec 2021 10:44:10 +0100
> >
> > > On Thu, Dec 02, 2021 at 11:32:05PM +0100, Alexander Lobakin wrote:
> > > > Use the newly introduces macros to create unique separate sections
> > > > for (almost) every "regular" ASM function (i.e. for those which
> > > > aren't explicitly put into a specific one).
> > > > There should be no leftovers as input .text will be size-asserted
> > > > in the LD script generated for FG-KASLR.
> > >
> > > *groan*...
> > >
> > > Please, can't we do something like:
> > >
> > > #define SYM_PUSH_SECTION(name)      \
> > > .if section == .text                \
> > > .push_section .text.##name  \
> > > .else                               \
> > > .push_section .text         \
> > > .endif
> > >
> > > #define SYM_POP_SECTION()   \
> > > .pop_section
> > >
> > > and wrap that inside the existing SYM_FUNC_START*() SYM_FUNC_END()
> > > macros.
> >
> > Ah I see. I asked about this in my previous mail and you replied
> > already (: Cool stuff, I'll use it, it simplifies things a lot.
>
> Note, I've no idea if it works. GAS and me aren't really on speaking
> terms. It would be my luck for that to be totally impossible, hjl?

What exactly do you want assembler to do?

-- 
H.J.
