Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474AC3B59C5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 09:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhF1HeO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 03:34:14 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:47006 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhF1HeO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 03:34:14 -0400
Received: by mail-ua1-f50.google.com with SMTP id x37so2142551uac.13;
        Mon, 28 Jun 2021 00:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YwIJEG/rO0Ceg2ym/ezfAo5dwUkYJUNngLzGb8y4q34=;
        b=TZrn3J1nkgSsIYp5BrAGZ13uiO0UnOBvRiq+ZhmD4NL0iaCRChNO0J6o7/2CnOavc+
         v/mqysX6dt4Bs6YPv/+Ynr6cNjTRpk3nAl53kqvAapksERUHxu39hWe5ziMjhR/C7TCN
         IesIG8Kr9NJDyNTW5H6nAAZex2+8vVg8MEx3aAK48Ge5kmQjm49AHmcnJ2DRQurx/qnH
         1H0oaAKd6PVCa0AxNds/+fLE04Odc5dW9+DJ81mbZgxFZnW0v4njRxOK80nDO/nvYXH7
         pnyoVacC0Vv3MElWT1ZT07cKUt597hRmqj2O/sqSq1WXRjP619/wErhwJoaN1+6T4PdY
         oKNw==
X-Gm-Message-State: AOAM530bEsSV1GATZlyak6MoGXtn5T6RW4LUTpuBt0lHHzyL8Ge2XPaX
        XWtUL6mwjVfrpzviT/Au87lNly8OyDWA5etEY2M=
X-Google-Smtp-Source: ABdhPJzYCFkqI6XO8XkluCeuBx9LnwBi5juJUkv7ROdktEW/OX3bMPqqTtRpjrN4il7UKs8a0PGwlEAC4EpisNoB+x4=
X-Received: by 2002:ab0:647:: with SMTP id f65mr19209348uaf.4.1624865507461;
 Mon, 28 Jun 2021 00:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133> <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133> <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133> <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk> <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
In-Reply-To: <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 09:31:36 +0200
Message-ID: <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Refactoring exit
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

On Mon, Jun 28, 2021 at 1:00 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 28/06/21 10:13 am, Al Viro wrote:
> > On Thu, Jun 24, 2021 at 10:45:23PM +0000, Al Viro wrote:
> >
> >> 13) there's bdflush(1, whatever), which is equivalent to exit(0).
> >> IMO it's long past the time to simply remove the sucker.
> > Incidentally, calling that from ptraced process on alpha leads to
> > the same headache for tracer.  _If_ we leave it around, this is
> > another candidate for "hit yourself with that special signal" -
> > both alpha and m68k have that syscall, and IMO adding an asm
> > wrapper for that one is over the top.
> >
> > Said that, we really ought to bury that thing:
> >
> > commit 2f268ee88abb33968501a44368db55c63adaad40
> > Author: Andrew Morton <akpm@digeo.com>
> > Date:   Sat Dec 14 03:16:29 2002 -0800
> >
> >      [PATCH] deprecate use of bdflush()
> >
> >      Patch from Robert Love <rml@tech9.net>
> >
> >      We can never get rid of it if we do not deprecate it - so do so and
> >      print a stern warning to those who still run bdflush daemons.
> >
> > Deprecated for 18.5 years by now - I seriously suspect that we have
> > some contributors younger than that...
>
> Haven't found that warning in over 7 years' worth of console logs, and
> I'm a good candidate for running the oldest userland in existence for m68k.
>
> Time to let it go.

The warning is printed when using filesys-ELF-2.0.x-1400K-2.gz,
which is a very old ramdisk from right after the m68k a.out to ELF
transition:

    warning: process `update' used the obsolete bdflush system call
    Fix your initscripts?

I still boot it, once in a while.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
