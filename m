Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172233B68F8
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 21:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhF1TUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 15:20:19 -0400
Received: from mail-vk1-f182.google.com ([209.85.221.182]:41516 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbhF1TUS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 15:20:18 -0400
Received: by mail-vk1-f182.google.com with SMTP id s72so4207047vkb.8;
        Mon, 28 Jun 2021 12:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1kgfbZhYJkXzzmr7bNgLSoqZcGM1rWxHnjonqp3p6M4=;
        b=hpoCwrunIKs2bKQHGSzC7jX9ZsCbaYBwPjoG6WFNUuenXSMJlEB44C33Vr2kloinhU
         jwLKLSEUFwsZDIBMTSY4ssmDkyDVR6+QW3InxSKshfRpdwIgNfjeA5mNOKRnm//qRJnP
         OAccC8muQcXnXNp4Qd/CDh5ATJuglknFE2tBOhhl5CadVoqM/bn1yaLigX84mmIMB8fH
         Dv+3THBUIyPYkW0WJ3r//eebypTuPNf02S/50Wo5CbDnDgKyNJiOEZX8e2kIdQ7QAFpf
         keuzUTt4/3o9IOes07vj+EiTZWnWNLt+H5qetDRcWlPdpyf57psvcFGWdSU4KHXlL+RF
         fXmA==
X-Gm-Message-State: AOAM530ndj5H96a7GpsCI5mBV2ewbBEZCUDtRQupZMXX/sqPorNcdQM5
        QjX//heG7SuOiXUPmswcQKZbiUrXTjMpTlp5O0w=
X-Google-Smtp-Source: ABdhPJzs8zbnJjOLDbjAx1eFBIkt9LTfmLSpKI8oTfbuVusOL0Bm2d6UnYO3XmABdwIa/jNXr5Siyc6+oD1nv2X1nUA=
X-Received: by 2002:a1f:ac45:: with SMTP id v66mr18581239vke.1.1624907871922;
 Mon, 28 Jun 2021 12:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133> <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133> <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133> <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk> <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
 <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com> <7ad6c3a9-b983-46a5-fc95-f961b636d3fe@gmail.com>
In-Reply-To: <7ad6c3a9-b983-46a5-fc95-f961b636d3fe@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 21:17:33 +0200
Message-ID: <CAMuHMdUi5Ri=GmWzS8hb7dkfPyAE=HpQHg6OsKSLDse_364E=g@mail.gmail.com>
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

On Mon, Jun 28, 2021 at 7:14 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.2021 um 19:31 schrieb Geert Uytterhoeven:
> >> Haven't found that warning in over 7 years' worth of console logs, and
> >> I'm a good candidate for running the oldest userland in existence for m68k.
> >>
> >> Time to let it go.
> >
> > The warning is printed when using filesys-ELF-2.0.x-1400K-2.gz,
> > which is a very old ramdisk from right after the m68k a.out to ELF
> > transition:
> >
> >     warning: process `update' used the obsolete bdflush system call
> >     Fix your initscripts?
> >
> > I still boot it, once in a while.
>
> OK; you take the cake. That ramdisk came to mind when I thought about
> where I'd last seen bdflush, but I've not used it in ages (not sure 14
> MB are enough for that).

Of course it will work on your 14 MiB machine!  It fits on a floppy, _after_
decompression.  It was used by people to install Linux on the hard disks
of their beefy m68k machines, after they had set up the family Christmas
tree, in December 1996.

I also have a slightly larger one, built from OpenWRT when I did my first
experiments on that.  Unlike filesys-ELF-2.0.x-1400K-2.gz, it does open
a shell on the serial console, so it is more useful to me.

> The question then is - will bdflush fail gracefully, or spin retrying
> the syscall?

Will add to my todo list...
BTW, you can boot this ramdisk on ARAnyM, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
