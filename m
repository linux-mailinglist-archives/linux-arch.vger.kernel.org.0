Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554173D7533
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhG0MlC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 08:41:02 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:49773 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhG0MlB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 08:41:01 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEVqu-1lsLh82sh8-00G3HU for <linux-arch@vger.kernel.org>; Tue, 27 Jul
 2021 14:41:00 +0200
Received: by mail-wm1-f47.google.com with SMTP id f18-20020a05600c4e92b0290253c32620e7so1538058wmq.5
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 05:41:00 -0700 (PDT)
X-Gm-Message-State: AOAM533DlSm91o9bfEtXS2+0Op22VDFgeO2i1ayVY+tlBYvPwDyhZZIs
        UKPPJQ2pfiFFVRcqvDtb2hFbQv7ADQEUCm4KO7U=
X-Google-Smtp-Source: ABdhPJxjLVaNmEQ0pKcxjvgnTW/jbiHS+3L6UqQ7k/dyts5UEQMygNj882FKWX1h5IZ0/3manUVVSxFsCvAZOlkJP/Q=
X-Received: by 2002:a7b:c385:: with SMTP id s5mr21409175wmj.43.1627389660367;
 Tue, 27 Jul 2021 05:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-6-chenhuacai@loongson.cn> <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
 <CAAhV-H4HrcfmLmgxB765CyU72FGsAx1kEzV+yjfgKUO+9KiCNw@mail.gmail.com>
In-Reply-To: <CAAhV-H4HrcfmLmgxB765CyU72FGsAx1kEzV+yjfgKUO+9KiCNw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Jul 2021 14:40:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3WdXOrsg6wYShr9KU7PFn2mUHz4dwOTNhYtw53WiwT1A@mail.gmail.com>
Message-ID: <CAK8P3a3WdXOrsg6wYShr9KU7PFn2mUHz4dwOTNhYtw53WiwT1A@mail.gmail.com>
Subject: Re: [PATCH 05/19] LoongArch: Add boot and setup routines
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:R/MggaPuRdzI6JvAR5hkjRfQ4BhDCSS/LRxwYOFRhZ7GZxAaVuD
 85gUPLBT7wxjeIMjIogAPAdJ6oa3BPRcXopcYsHFMzUWnV6QfAbX5RTAUf7hI3QgaUpNuRn
 5ePzkHcsp/j/PkZKKUNY6frjdjZI4WpnzcTZw4GOOaLCzsZ1no7qgzAlViRErskbLYd7TZK
 6+mHg7WKcOanazkEaKGBA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:X+5Hlu+SUtE=:LLJNTgkgAesFQUvFqgnEx1
 ryBsurAMsbbOnQuMhciCPySMwzPmub+pcNKRDJY0KDcSyvBFBBWBhlhMNjbeCTYHxteSX4J8M
 CDI3B1vnBlcIoIQm9hpZd95DjAUTUftVBbe2biDS7Md3Dpjo9XMxiGcF5B1luFwLQfaqc6AhC
 hCZTL2fQd8KBucmGGtdN0v5NoTK2MjPauwjgPPguenYJ/n316ZsXXOjZcK/1ErmxHRcKkOVw1
 KKMbursZXPi+n+IReGT1vBgUd0n2RoSzDP0Cbub6gHd1kII5thtSmafrTvTU2hFpKfJQMwL+e
 kmxKt6eFTN78rYotwvoJ+ETYURiZzi7P2HnIokpOU6MuoKhBsmAfuIpGX8Iped1KV++8vdSqh
 yT5WW2KvJSXiCGoVB+RqIIYEvfLxb9c3q+vOqIPjnY6w9zSY435D37kgr5vx2FAGxlEdesHPT
 BYskZJ0U2U3+98ltl4d2WpXY/kR+MJ5ILzC4aAfRFCakUkoXQhAhRhb5h4Qld9IrFHSnD9lax
 ol5f2WEY7VQ9d3XNySxMQYEQtMzvD4q3vJS8wx6IUlDYzynIcLabTwinFsCz3duYyjo5gOI0f
 3M/d6tKXJBJjlqtJCsh4gdTvxuNpLX+r0grTnMTlxzowlQtghWn5pdrPvxMiaj8Vr9QLLtJSf
 RxGBsQe7QwMFbxaUNw5lHzFGEljfyr9H3K9pAw49+5JhI0U94RwGjoOEnUFmLwVt1R7Ri7s2e
 vOoO0wtwLM8EGgtCVfNgC+xHtvVFoYjnTw4WZ9PH8pukx8MmyisZLJk11rCHrlzAddT4X+gH2
 6MgMS2TDLA182+aJBROHISJvJ/151Voxcy/ZhU3vajS1JqAIbnp0kikGu4lBRjcSBKNu4qd
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 1:53 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 6:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > > +
> > > +#ifdef CONFIG_64BIT
> > > +       /* Guess if the sign extension was forgotten by bootloader */
> > > +       if (start < CAC_BASE)
> > > +               start = (int)start;
> > > +#endif
> > > +       initrd_start = start;
> > > +       initrd_end += start;
> > > +       return 0;
> > > +}
> > > +early_param("rd_start", rd_start_early);
> > > +
> > > +static int __init rd_size_early(char *p)
> > > +{
> > > +       initrd_end += memparse(p, &p);
> > > +       return 0;
> > > +}
> > > +early_param("rd_size", rd_size_early);
> >
> > The early parameters should not be used for this, I'm fairly sure the UEFI
> > boot protocol already has ways to communicate all necessary information.
> We use grub to boot the Linux kernel. We found X86 uses private data
> structures (seems not UEFI-specific) to pass initrd information from
> grub to kernel. Some archs use fdt, and other archs use cmdline with
> "initrd=start,size" (init/do_mounts_initrd.c). So, I think use cmdline
> is not unacceptable, but we do can remove the the rd_start/rd_size
> parsing code here

(adding Ard Biesheuvel to Cc for clarification)

As far as I understand it, this should be using the kernel's UEFI stub
as documented in Documentation/admin-guide/efi-stub.rst

This lets you load the initrd from within the kernel and pass the
address using the architecture specific boot information.

Maybe I misunderstood and you already do it like this?

       Arnd
