Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1914027AE13
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI1MnD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 08:43:03 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1MnD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Sep 2020 08:43:03 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MnpP8-1klUoI26e2-00pOWB; Mon, 28 Sep 2020 14:43:00 +0200
Received: by mail-qk1-f179.google.com with SMTP id g72so740888qke.8;
        Mon, 28 Sep 2020 05:43:00 -0700 (PDT)
X-Gm-Message-State: AOAM533KsGcTCEjepB62goD1p5t2/fewDpwm/EM9CbURR2xH4kU9ifwf
        9B2HELMRoiDvqnQ+T2pCk3JEauID4k/1Nw6C+ww=
X-Google-Smtp-Source: ABdhPJwGqDO65ntGAdjq302JT9kz4grqzX1nUBEs13e10HB5wJSnUc85Ohe6MBKd5+4G8v6JAaqmSAOcRa0VKiSI31w=
X-Received: by 2002:a37:5d8:: with SMTP id 207mr1246723qkf.352.1601296979151;
 Mon, 28 Sep 2020 05:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-5-arnd@arndb.de>
 <CACRpkdYkL2=gkBvbHO514rnppLdHgsXwi0==6Ovq43kSZqEvUQ@mail.gmail.com>
In-Reply-To: <CACRpkdYkL2=gkBvbHO514rnppLdHgsXwi0==6Ovq43kSZqEvUQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 28 Sep 2020 14:42:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0BZ-zdk+RB5ODcVs2z-Y6xmLCp57uzivUGWRcoeH2fQQ@mail.gmail.com>
Message-ID: <CAK8P3a0BZ-zdk+RB5ODcVs2z-Y6xmLCp57uzivUGWRcoeH2fQQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] ARM: syscall: always store thread_info->syscall
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CJWFLrA3SKB1padlpM+y7ShF7lXMlbKZdm1TjFDfHOwwpX2/X1l
 4DwGU7nUfV3s+3R6aPkb+Fw3M18j5TvRh6/vUFDC+BVlmc2vrDKia7qgCM4qINevW2uL+YM
 IdppK2EJsIq+JZRI95ZlejNdSIk43nSq+6vf9413uDGaZnKaCULXxJZPd1vrYEEou9TV64f
 b5K+bFXBKO0KCPHgDuhVQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gQsWUr9tEh8=:cKF/3Zynrx5p7FwCSuooU0
 FblKNcfyrL/tN4oej/9hFEGfqBr26hak8Jkl5u5Jaaufa758G4/DD3fM3DjlhN5QcZqRRKVtp
 iIFJ3LnJOoBgNp1PqfEupIuLyZn81y4W7ANyEnzS0phTIYa6YT1dL/3I5qMYZKkGfHZuvicrY
 MaZvcoDzw44RTY1B+BCNId4VEQVtyM+wPWwY0iCncm27V6yqiJ1JEsYoRvKl5rQLykM4ZimnV
 6mi4GdvbB1aIvguwJV9OYj9C+inag7gxiASRcMe+Bo40rMIBw9rGCFMOJ58C5dwWVBHWj5biR
 VtHqQXj8nbDeZt0pwsZfa2znTo7GYiA5DEHnRNSXdda7KmEpKwKu59wIYYu16+ihAsXyzY1MM
 kTQeGQcTF103MGDNNGbdYAZd059P16DT25so0at+PoWRKlS40gi4t5IJOAJN5CiLgCPA3+4cX
 5SL+MWYqrmjMIm3UhIVdO0Ecf0fa0kr0unLZuxq5N5piTVgX8SiIFPD4H0NtuHFLRTFuwdxEY
 D9bUPSxk/fFv85L1zrZqJyMb3dP7w2p6mdwFO3J5EuK1jXohAc329H6BaeeEIoQasI4Lt9UwB
 KwRBzF5sNuopi59nEMNVo7Qmav0OCMjEhMlUXgtN26ivxkduU6N5zY5XqKe9HBy43xXXk7oV9
 WMy7SaC7Fwe3s/TwkhXTH17awXpXiturbsY7z9NRT6lj3t8ozf1Uwz0M3OGyRh+ApItSa6oek
 IYcu/5sb1a3en+QmMp6Wj9krqWycrQ62ASG91W396zSv3ISRFI92Y0PwPBcZc7AI/36cRcBb0
 Q3ySynKhSXh8xEtyJXQpgjaUZGj9YXzgjbZvXuV5M6Dk8pjENarLR8+yZPjk12tXVTjHp4+
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 28, 2020 at 11:41 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Arnd,
>
> help me out here because I feel vaguely stupid...
>
> On Mon, Sep 7, 2020 at 5:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> >  {
> > +       if (IS_ENABLED(CONFIG_OABI_COMPAT))
> > +               return task_thread_info(task)->syscall & ~__NR_OABI_SYSCALL_BASE;
>
> Where __NR_OABI_SYSCALL_BASE is
> #define __NR_OABI_SYSCALL_BASE       0x900000
>
> So you will end up with sycall number & FF6FFFFF
> masking off bits 20 and 23.

Right. I fixed a bug in here since I sent this, the correct version also
needs to mask away the __NR_OABI_SYSCALL_BASE for a native
oabi kernel, not just for an eabi kernel with oabi-compat mode.

> I suppose this is based on this:
>
> >         bics    r10, r10, #0xff000000
> > +       str     r10, [tsk, #TI_SYSCALL]
>
> OK we mask off bits 24-31 before we store this.
>
> >         bic     scno, scno, #0xff000000         @ mask off SWI op-code
> > +       str     scno, [tsk, #TI_SYSCALL]
>
> And here too.
>
> >         eor     scno, scno, #__NR_SYSCALL_BASE  @ check OS number
>
> And then happens that which will ... I don't know really.
> Exclusive or with 0x9000000 is not immediately intuitive
> evident to me, I suppose it is for everyone else... :/

This is how the SWI/SVC immediate argument gets turned into
a system call number that is used as an offset into the sys_call_table.

OABI syscalls are called with '__NR_OABI_SYSCALL_BASE | scno'
in the immediate argument of the instruction, so using an
'eor ... , #__NR_SYSCALL_BASE' means that any valid
argument afterwards is a number between zero and
__NR_syscalls, and any invalid argument is a number outside
of that range

EABI syscalls are just 'SVC 0' with the syscall number in register 7
and no offset.

See also
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3f2829a31573e3e502b874c8d69a765f7a778793

> I need some idea how this numberspace is managed in order to
> understand the code so I can review it, I guess it all makes perfect
> sense but I need some background here.

I also had never understood this part before, and I'm still not
sure where the 0x900000 actually comes from, though my best
guess is that this was intended as a an OS specific number space,
with '9' being assigned to Linux (similar to the way Itanium and
MIPS do with their respective offsets). By the time EABI got added,
this was apparently no longer considered helpful.

        Arnd
