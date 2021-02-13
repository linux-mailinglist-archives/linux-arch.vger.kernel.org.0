Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B09431A9EA
	for <lists+linux-arch@lfdr.de>; Sat, 13 Feb 2021 05:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhBMEwi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Feb 2021 23:52:38 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:47950 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhBMEwh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Feb 2021 23:52:37 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 11D4pUOw003083;
        Sat, 13 Feb 2021 13:51:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 11D4pUOw003083
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1613191891;
        bh=F5rAstRKVcnldUmASCxQnLhZwn4DufsgGL1w1X7AFfs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kkpUarNaB20eqpe1Sati0y360f5NaP05pmUMhRh2z74rUlAuBzGGPvGts0tMiGDxH
         qSp0FSF7x8GRxyH/WXBxFwabMNDJ6My79VbqdiyN5H7D+WCZEyGu74TZEBinkxrYG4
         z5svoDqoJchN/M1jPULH3ICaSlvMECqrBsf5aE7VRPUL09VxgiAIETRsP1CNNxAjM/
         JANmGUdPes12FIU6EhRCp4HV2xwFsyHqdSSL/XO0hlnJ6BSpJhy7pSi8uJb5JTtcye
         9JrZXJHr66fMiSsGZ3uSZPpowjzlZ+XBRFvoMhX0KXVjS5D2jSrx4jUoVVzfogRk8i
         KLabM4lfvq3FA==
X-Nifty-SrcIP: [209.85.215.174]
Received: by mail-pg1-f174.google.com with SMTP id o7so983003pgl.1;
        Fri, 12 Feb 2021 20:51:30 -0800 (PST)
X-Gm-Message-State: AOAM5339SzKTYHgSelGwai2DFq+51MpHUEN8Gcngc96FW2+U+CecZB9b
        bT9+yGEZxzPHAE46aPSetKDIrREfreNdmyKkY8I=
X-Google-Smtp-Source: ABdhPJxGK4piQo3raOfwhCR5hiwrOV0Bk+CO0QLPlsRqODDRAi7vh2nqSvYj3IqqOVwWAQ7JCcfvQ/q/fdUES0IZVz0=
X-Received: by 2002:a63:575e:: with SMTP id h30mr6167948pgm.7.1613191889994;
 Fri, 12 Feb 2021 20:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20210128005110.2613902-1-masahiroy@kernel.org>
 <20210128005110.2613902-3-masahiroy@kernel.org> <41f7ad59-6ee7-db95-0e56-861c61e8318f@digikod.net>
 <b47407f4-6c4c-1db3-f1ad-c569de315790@digikod.net>
In-Reply-To: <b47407f4-6c4c-1db3-f1ad-c569de315790@digikod.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 13 Feb 2021 13:50:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_xG6EAKf8o8wdBD5GBZzajW1P78GfwYgCZ3gO7xCqvg@mail.gmail.com>
Message-ID: <CAK7LNAS_xG6EAKf8o8wdBD5GBZzajW1P78GfwYgCZ3gO7xCqvg@mail.gmail.com>
Subject: Re: [PATCH 02/27] x86/syscalls: fix -Wmissing-prototypes warnings
 from COND_SYSCALL()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 13, 2021 at 12:12 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
> Could you please push this patch to Linus? Thanks.
>
> On 04/02/2021 15:16, Micka=C3=ABl Sala=C3=BCn wrote:
> >
> > On 28/01/2021 01:50, Masahiro Yamada wrote:
> >> Building kernel/sys_ni.c with W=3D1 omits tons of -Wmissing-prototypes
> >> warnings.
> >>
> >> $ make W=3D1 kernel/sys_ni.o
> >>   [ snip ]
> >>   CC      kernel/sys_ni.o
> >> In file included from kernel/sys_ni.c:10:
> >> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous p=
rototype for '__x64_sys_io_setup' [-Wmissing-prototypes]
> >>    83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) =
\
> >>       |              ^~
> >> ./arch/x86/include/asm/syscall_wrapper.h:100:2: note: in expansion of =
macro '__COND_SYSCALL'
> >>   100 |  __COND_SYSCALL(x64, sys_##name)
> >>       |  ^~~~~~~~~~~~~~
> >> ./arch/x86/include/asm/syscall_wrapper.h:256:2: note: in expansion of =
macro '__X64_COND_SYSCALL'
> >>   256 |  __X64_COND_SYSCALL(name)     \
> >>       |  ^~~~~~~~~~~~~~~~~~
> >> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
> >>    39 | COND_SYSCALL(io_setup);
> >>       | ^~~~~~~~~~~~
> >> ./arch/x86/include/asm/syscall_wrapper.h:83:14: warning: no previous p=
rototype for '__ia32_sys_io_setup' [-Wmissing-prototypes]
> >>    83 |  __weak long __##abi##_##name(const struct pt_regs *__unused) =
\
> >>       |              ^~
> >> ./arch/x86/include/asm/syscall_wrapper.h:120:2: note: in expansion of =
macro '__COND_SYSCALL'
> >>   120 |  __COND_SYSCALL(ia32, sys_##name)
> >>       |  ^~~~~~~~~~~~~~
> >> ./arch/x86/include/asm/syscall_wrapper.h:257:2: note: in expansion of =
macro '__IA32_COND_SYSCALL'
> >>   257 |  __IA32_COND_SYSCALL(name)
> >>       |  ^~~~~~~~~~~~~~~~~~~
> >> kernel/sys_ni.c:39:1: note: in expansion of macro 'COND_SYSCALL'
> >>    39 | COND_SYSCALL(io_setup);
> >>       | ^~~~~~~~~~~~
> >>   ...
> >>
> >> __SYS_STUB0() and __SYS_STUBx() defined a few lines above have forward
> >> declarations. Let's do likewise for __COND_SYSCALL() to fix the
> >> warnings.
> >>
> >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Tested-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >
> > Thanks to this patch we avoid multiple emails from Intel's bot when
> > adding new syscalls. :)


Thanks for the reminder.
I will fix the typo "omits" -> "emits"
and send v2 just in case.



> >
> >
> >> ---
> >>
> >>  arch/x86/include/asm/syscall_wrapper.h | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include=
/asm/syscall_wrapper.h
> >> index a84333adeef2..80c08c7d5e72 100644
> >> --- a/arch/x86/include/asm/syscall_wrapper.h
> >> +++ b/arch/x86/include/asm/syscall_wrapper.h
> >> @@ -80,6 +80,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_re=
gs *regs);
> >>      }
> >>
> >>  #define __COND_SYSCALL(abi, name)                                   \
> >> +    __weak long __##abi##_##name(const struct pt_regs *__unused);   \
> >>      __weak long __##abi##_##name(const struct pt_regs *__unused)    \
> >>      {                                                               \
> >>              return sys_ni_syscall();                                \
> >>



--=20
Best Regards
Masahiro Yamada
