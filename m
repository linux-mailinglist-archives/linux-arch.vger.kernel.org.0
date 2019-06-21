Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BA4EA75
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 16:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFUOUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 10:20:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39489 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUOUd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2019 10:20:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id i125so4518548qkd.6;
        Fri, 21 Jun 2019 07:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86Rms5nqRiV6IeH+qjixPzoUGmZuw2YR9fMahci1Mdk=;
        b=fwRELvTAs+c9ke3nijUMNSb4DP0u4Q30iUGCJ29fIsR7AnlS2BW2c8CfupzpIASiiw
         uwJafIYWY4gR6TncEfarpi9yOQctri1t42X/J8h6amggUngUfoV8urf8AkxQU7rfXI0H
         9SudSNYP/30bHxQ7vaIVwrUeRSy7ZmTcK084caACF/bblcoJXieVN2bxTJjVRhe/c6KM
         LHVmHx/vjRqwLWQ73HToSe0dOmEElChDSDVHw2CnUKTrzAVNActYsi+R02fnUZCnTSNI
         so29wIrhIjG432AF+cdGpQvme6DbIgNB5CXWkpGvak+N//A9RWebayEL8ls4Q+UNY36G
         ZzlA==
X-Gm-Message-State: APjAAAVI2Sd7r2KzIAV8krHnSjFQ+WTox1qZDMFqMF0iuQhbqjWsFet0
        s1r7qq5Xyw4gQx041zM6sxFrvgvK1jjDqszwK+o=
X-Google-Smtp-Source: APXvYqyqwjrhMseoqPbT7Hw4nVdhmcH/NXpQC9gPuVbWnpECa7+VTtvjMcLYD5bkOoIfs0VngajGRxZZxXjZdcnFkQg=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr68806622qkm.3.1561126832500;
 Fri, 21 Jun 2019 07:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190604160944.4058-1-christian@brauner.io> <20190604160944.4058-2-christian@brauner.io>
 <20190620184451.GA28543@roeck-us.net> <20190620221003.ciuov5fzqxrcaykp@brauner.io>
 <CAK8P3a2iV7=HkHBVL_puvCQN0DmdKEnVs2aG9MQV_8Q58JSfTA@mail.gmail.com> <20190621111839.v5yqlws6iw7mx4aa@brauner.io>
In-Reply-To: <20190621111839.v5yqlws6iw7mx4aa@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 16:20:15 +0200
Message-ID: <CAK8P3a0T1=eg5ONbMFhHi=vmk1K5uogZ+5=wpsXvjVDzn6vS=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 1:18 PM Christian Brauner <christian@brauner.io> wrote:
> On Fri, Jun 21, 2019 at 11:37:50AM +0200, Arnd Bergmann wrote:
> >
> > I never really liked having __ARCH_WANT_SYS_CLONE here
> > because it was the only one that a new architecture needed to
> > set: all the other __ARCH_WANT_* are for system calls that
> > are already superseded by newer ones, so a new architecture
> > would start out with an empty list.
> >
> > Since __ARCH_WANT_SYS_CLONE3 replaces
> > __ARCH_WANT_SYS_CLONE for new architectures, how about
> > leaving __ARCH_WANT_SYS_CLONE untouched but instead
>
> __ARCH_WANT_SYS_CLONE is left untouched. :)
>
> > coming up with the reverse for clone3 and mark the architectures
> > that specifically don't want it (if any)?
>
> Afaict, your suggestion is more or less the same thing what is done
> here. So I'm not sure it buys us anything apart from future
> architectures not needing to set __ARCH_WANT_SYS_CLONE3.
>
> I expect the macro above to be only here temporarily until all arches
> have caught up and we're sure that they don't require assembly stubs
> (cf. [1]). A decision I'd leave to the maintainers (since even for
> nios2 we were kind of on the fence what exactly the sys_clone stub was
> supposed to do).
>
> But I'm happy to take a patch from you if it's equally or more simple
> than this one right here.
>
> In any case, linux-next should be fine on all arches with this fixup
> now.

I've looked at bit more closely at the nios2 implementation, and I
believe this is purely an artifact of this file being copied over
from m68k, which also has an odd definition. The glibc side
of nios2 clone() is also odd in other ways, but that appears
to be unrelated to the kernel ABI.

I think the best option here would be to not have any special
cases and just hook up clone3() the same way on all
architectures, with no #ifdef at all. If it turns out to not work
on a particular architecture later, they can still disable the
syscall then.

      Arnd
