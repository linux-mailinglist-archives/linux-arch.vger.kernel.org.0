Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5463BE33F
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 08:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhGGGrF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jul 2021 02:47:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53965 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGGrF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jul 2021 02:47:05 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mow4E-1lPFe21DN0-00qVG2 for <linux-arch@vger.kernel.org>; Wed, 07 Jul 2021
 08:44:24 +0200
Received: by mail-wr1-f53.google.com with SMTP id a8so1711075wrp.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 23:44:24 -0700 (PDT)
X-Gm-Message-State: AOAM533Ipz1VowMCUvbRFMNgl+qzVTXwpZAtOmGKNnm2pIlZ+ykqItRn
        ngGZsJdgTjGYRd9T3v7dxoOhPT3f8F94ayDN36k=
X-Google-Smtp-Source: ABdhPJziaOEDBjSnlpm9jtRPdmahYidfxHKNfabscPT3Wh+wTb53vIevAvAYKMaNdn68HU06ZGkq0KQdeBLnimJLrEc=
X-Received: by 2002:a5d:448c:: with SMTP id j12mr27183975wrq.105.1625640264014;
 Tue, 06 Jul 2021 23:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-10-chenhuacai@loongson.cn> <CAK8P3a0n+HcPhevh4ifNMmsv+MUtGn1wky-HWZpyNT1GVSq4+Q@mail.gmail.com>
 <CAAhV-H6q8Cz0bGBZo6dUESwk1wfa75TL6YH+YS1kQe9UzHB=Tg@mail.gmail.com>
In-Reply-To: <CAAhV-H6q8Cz0bGBZo6dUESwk1wfa75TL6YH+YS1kQe9UzHB=Tg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Jul 2021 08:44:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3E2a1PQ5+pD3sDs4vbQiwx3Z9vAQOG7akd645B86AYHg@mail.gmail.com>
Message-ID: <CAK8P3a3E2a1PQ5+pD3sDs4vbQiwx3Z9vAQOG7akd645B86AYHg@mail.gmail.com>
Subject: Re: [PATCH 09/19] LoongArch: Add system call support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TXCroJW4O4lRzfxX9H1bJjyel6SNZ0itdwEDMedjX4/dIQBD3t5
 jQF/Ks3H2nfvqOU96sMnTv6KJLmZIOjYpsNuf/Y4IxkZL99+YdTUaY61l6KA1TEOk916wbA
 f7I7qeqhCh5MzxmTnR85bUBAGmbGtnWoArD9spljw2IkAH0yuRLS2ZwoPfS/+FBTwSSLwws
 VqkQMrFGqO3XCRRrs7Gsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U9VFO0rMdy8=:myPu/fRGhx5CFwgwI41Sor
 MU4cJD8MYJITl13LB3S363dHvSQ/CbDZoOTKeNKyr3Cojstd5mx785zTe92dU8vmindyn5zwV
 RIKRjRQoQxYXT/y3zOrOIKwCOj/jGQJIj9p884J4CZAWMePiWBAj+Gj8OlMLfbHCBreqYj2kS
 HfWSu+ntErb1/p97FDwnqUev3QPwNAEYZmEvLbIVlTUmjDBTZ6ULv/uRWIMFUg8uhNMROWsvD
 n1iTAlbDhs6CmK0Duip1obSRtF5uRlX6ntOUX6pwZvwI/gnpUQGGTsX6qaOSS9vhaBTQew9qL
 0DgsWs+Ja91qfoyDowJXBedS2t1kEYQpXNo78pfUDcNjxzeQrrVO14niuyqWtnUPnRHzWMmQ4
 KIr2eRXeMKpeNsVGL8WDzaet8G0eGA3Op26OvD+rnz9WGRSHX/xLZQv6G5s3ybmrzMQyl2HmQ
 KsnEwgh+M0KoO8E+zsEFw2yR9lP86w1MWG7UtZLJxN8ycVK9BsvS4GJdG/vHXMEmAes2BWVlc
 L6KwDGbLoRUaCaGujZcqxwoKtqAkjelaKZoaggEBfkb2MzAPGzJ1Nfm984AdtLAXWhGZiaStp
 pMl6WjJ2Rz7m5hDKcRa+//3J3j4etkvujD+mLxHpkbaUA9bpBr3WxRrRh0/HAoXoy72zOa7G9
 qLZ6iX/CA5593+afRm+4Bvm6/0Mk8tsq9bdj7T+iQFjMGcPPM3AkUFH3kysaOUVh/UruIIRFh
 TA4ZVCFnWvh4WafqtkSbnNLn0S3M/BdN6noUwybG0ASpzDAeJW1bQyNE+6eEEr6roscC9rGW4
 OADrhK+rNtkmwMyGfKFFFGmnXCGJKjEISlplRUex994odCiQuw/nDUpOZdBz1P7DVSGVLL0
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 7, 2021 at 6:24 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
> > > new file mode 100644
> > > index 000000000000..6c194d740ed0
> > > --- /dev/null
> > > +++ b/arch/loongarch/include/uapi/asm/unistd.h
> > > @@ -0,0 +1,7 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +#define __ARCH_WANT_NEW_STAT
> >
> > Why do you need newstat? I think now that we have statx and the libc
> > emulation code on top of it, there is probably no need to support both
> > on the kernel side.
> >
> > > +#define __ARCH_WANT_SYS_CLONE
> > > +#define __ARCH_WANT_SYS_CLONE3
> >
> > Similarly, if you have clone3, you should not need clone.
> >
> > > +#define __ARCH_WANT_SET_GET_RLIMIT
> >
> > And here for prlimit64
>
> Is newstat()/clone()/setrlimit() completely unacceptable in a new
> arch? If not, I want to keep it here for compatibility, because there
> are some existing distros.

I'd say they should go. None of these are normally called directly by
applications, so if you just update the C library to redirect the user
level interfaces to the new system calls, I expect no major problems
here as long as you update libc along with the kernel in the existing
distros.
Any application using seccomp to allow only the old system calls
may need a small update, but it would need that anyway to work
with future libc implementations.

Generally speaking there should be no expectation that the
system call interface is stable until the port is upstream. Note that
you will face a similar problem with the libc port, which may also
change its interface from what you are using internally.

       Arnd
