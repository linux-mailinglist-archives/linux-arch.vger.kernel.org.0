Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9103B6A16
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 23:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhF1VVJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 17:21:09 -0400
Received: from mail-vk1-f175.google.com ([209.85.221.175]:34459 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbhF1VVD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 17:21:03 -0400
Received: by mail-vk1-f175.google.com with SMTP id n131so4282310vke.1;
        Mon, 28 Jun 2021 14:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YAPeZCiuZX0F/GKB9DHzWgF67b8W80bULssMkRJhBdU=;
        b=fxcAshYCRPc99lPxZBXPRVLRefbFiWZPU2EA664OrK17tjcyJJRnqjn9ZpP/KXkjth
         Hv3Z84Ro/B5PxsyVM6GVm9bxMwv5M5wckVLYotKZbwv33lY2QxhF3oZTVB+a0HJjBlTx
         mm+dv2BdyI8CtMJbdkvdD2gxHU8bR//Ad+rL5tEc6YAcreHfPnkzTcAzH5Myod0xV809
         SDUP6DsGza7wASStMKBdt6xTtHi+17yI4bHcRkQv9+R6Tv9sIgRkH2OLAnhWiqPC1RwF
         I8qCVVZPNXbIDUx1EIJGgpx8VDpwArECdDZ99xARTxMltG6tRrVkXjvFKtL6OEWi240A
         SJeQ==
X-Gm-Message-State: AOAM530WTcjnkB0c5h/1xDjJTrUQ3QGijk4gSXYVGT1+d3+YjZ1SqGHa
        X+GM/UfNfDNpvzNh+KrKhqezVvN5qL+RIjfdUIw=
X-Google-Smtp-Source: ABdhPJz02C8/Rqz1MLP5OMvzVz4lWfCJWP2GqRlYIlNT7pCBifFG/TCv8TYML8eH38S4XLZXJKY6x0w/FrLjgKnSEck=
X-Received: by 2002:a05:6122:b72:: with SMTP id h18mr16635065vkf.1.1624915116084;
 Mon, 28 Jun 2021 14:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk> <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133> <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133> <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133> <875yy3850g.fsf_-_@disp2133> <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
 <YNj4DItToR8FphxC@zeniv-ca.linux.org.uk> <6e283d24-7121-ae7c-d5ad-558f85858a09@gmail.com>
 <CAMuHMdXSU6_98NbC1UWTT_kmwxD=6Ha5LJxFAtbSuD=y78nASg@mail.gmail.com>
 <7ad6c3a9-b983-46a5-fc95-f961b636d3fe@gmail.com> <CAMuHMdUi5Ri=GmWzS8hb7dkfPyAE=HpQHg6OsKSLDse_364E=g@mail.gmail.com>
 <dbb4ca2d-a857-84f0-f167-5ad4e06aa52b@gmail.com>
In-Reply-To: <dbb4ca2d-a857-84f0-f167-5ad4e06aa52b@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Jun 2021 23:18:24 +0200
Message-ID: <CAMuHMdVKdZNBU-cTUY0zotA5DmtQ=dxH+iFY0_GX=4DzqpycZQ@mail.gmail.com>
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

On Mon, Jun 28, 2021 at 10:13 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 29/06/21 7:17 am, Geert Uytterhoeven wrote:
> >>> The warning is printed when using filesys-ELF-2.0.x-1400K-2.gz,
> >>> which is a very old ramdisk from right after the m68k a.out to ELF
> >>> transition:
> >>>
> >>>      warning: process `update' used the obsolete bdflush system call
> >>>      Fix your initscripts?
> >>>
> >>> I still boot it, once in a while.
> >> OK; you take the cake. That ramdisk came to mind when I thought about
> >> where I'd last seen bdflush, but I've not used it in ages (not sure 14
> >> MB are enough for that).
> > Of course it will work on your 14 MiB machine!  It fits on a floppy, _after_
> > decompression.  It was used by people to install Linux on the hard disks
> > of their beefy m68k machines, after they had set up the family Christmas
> > tree, in December 1996.
>
> Been there, done that. Wrote the HOWTO for ext2 filesystem byte-swapping.

I knew I could revive your memory ;-)

> > I also have a slightly larger one, built from OpenWRT when I did my first
> > experiments on that.  Unlike filesys-ELF-2.0.x-1400K-2.gz, it does open
> > a shell on the serial console, so it is more useful to me.
> >
> >> The question then is - will bdflush fail gracefully, or spin retrying
> >> the syscall?
> > Will add to my todo list...
> > BTW, you can boot this ramdisk on ARAnyM, too.
>
> True. I can't find that ramdisk image anywhere - if you can point me to
> some archive, I'll give that a try.

http://ftp.mac.linux-m68k.org/pub/linux-mac68k/initrd/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
