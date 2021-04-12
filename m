Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A733935C4AF
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhDLLI1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 07:08:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbhDLLI0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 07:08:26 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N01hu-1limhd0Cm6-00x2Y9; Mon, 12 Apr 2021 13:08:07 +0200
Received: by mail-wr1-f49.google.com with SMTP id r7so486967wrm.1;
        Mon, 12 Apr 2021 04:08:06 -0700 (PDT)
X-Gm-Message-State: AOAM530kQU+SWLQJpCrwmQQGgxSEIZ08QcB5wNowZYUuxUaX+CWCebhI
        B2RgDHQEDlW8EH8hzCSYBGL+bJKjHyFaHW+ksT8=
X-Google-Smtp-Source: ABdhPJwatGj4Mvozhf6aCxkSShLwRvZgtq4mQWAmILFQGmr0irnCJbJ+CA5m1DFQ3FmRiRFXCX+SPYIdhUIUiDPM7gw=
X-Received: by 2002:a5d:6dc4:: with SMTP id d4mr1862692wrz.105.1618225686459;
 Mon, 12 Apr 2021 04:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210412085545.2595431-1-hch@lst.de> <CAK8P3a38qgkjkh4+fDKp4TufL+2_W-quZBFK9pJFf7wXP=84xQ@mail.gmail.com>
 <16c471554aa5424fbe2f6a4fd60bd662@AcuMS.aculab.com>
In-Reply-To: <16c471554aa5424fbe2f6a4fd60bd662@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Apr 2021 13:07:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0MpbF=Zp8MtqaPYrLeLorh1TfVVtTPZ-ubxBy93CSOVA@mail.gmail.com>
Message-ID: <CAK8P3a0MpbF=Zp8MtqaPYrLeLorh1TfVVtTPZ-ubxBy93CSOVA@mail.gmail.com>
Subject: Re: consolidate the flock uapi definitions
To:     David Laight <David.Laight@aculab.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Helge Deller <deller@gmx.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aMjINWTCNsywgUKJHr5XLQHjAWqLnW10OtrvhDt4Sjy4ramW0iZ
 YAHBpKd6ESZiIkKxmpuR7HnYx3TxbJR41IscVjRIveQLtxtCXWSa6pHw5sNKN5hcpvU3xVG
 4P0DpiJcgAQaQJQH0Ugq21h2zqSBi1T8xu2zLftyuZXjq6CMtnPSxlsgDDpTeqt053PO6vv
 H236ZR3IDZI98em3VdDPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:APH3gvIsclk=:tX2NAsnJ6r1Mnr2TqMqExk
 c3MFahvIPwnxJfnehjGIFIYfEiWv0VyDosIyoYcHCrhneSsleyzgCza47EJTcKjC94LkNqh2g
 1wT8QXMgatA9YyEUVj4ieUHu7JHaCfjh4EFZprftIeXKrARLb1B+hw/sbZkHimGkd25c1ypbP
 ZwEAHALENJ91zTJI9NwUU64QtJ8RcC6Bx1beXAFImONDQp+vIQAxCdK5411Pa8ZOVxQVRwQDP
 ynn+bxJAn3oLAZjvpMmhhYYEisWiy+OpPYO5SMXNejFse1w1DTt5BJkEA81M+zotZ19MpWByl
 Ocmcqw/pzT28Q1N1ElHc5k/hLGiFrH4D+PVzdqsWTH6PDmqP/yPkleZiA1kXwOWMDGXsCyWFQ
 puzYgzv+fh7ndcDQiou3olVrb65xNaQNvGRsvV2OIr4ytmnX/v86mYvxgo7QbdeMxcPLd3hcM
 bjGOP0LWH6l305bcdMmRwecMkK0BDNrYO09k1FdqD0yyaq5w7eFGEsFUnXpPmzF3EL6HroANX
 y0yR4gGxzVopN/nxvPZK/EMMRh9JUZU4AbTsPL+Vn+dWj/2yBoxn5aE55YdUIf4DaT5OA23xg
 YAyxsnINSuk+odt3au8C2xn4dtRTzvIbG4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 12, 2021 at 12:22 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Arnd Bergmann
> > Sent: 12 April 2021 11:04
> >
> > On Mon, Apr 12, 2021 at 10:55 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Hi all,
> > >
> > > currently we deal with the slight differents in the various architecture
> > > variants of the flock and flock64 stuctures in a very cruft way.  This
> > > series switches to just use small arch hooks and define the rest in
> > > asm-generic and linux/compat.h instead.
> >
> > Nice cleanup. I can merge it through the asm-generic tree if you like,
> > though it's a little late just ahead of the merge window.
> >
> > I would not want to change the compat_loff_t definition to compat_s64
> > to avoid the padding at this time, though that might be a useful cleanup
> > for a future cycle.
>
> Is x86 the only architecture that has 32bit and 64bit variants where
> the 32bit variant aligns 64bit items on 32bit boundaries?

Yes.

> ISTM that fixing compat_loff_t shouldn't have any fallout.

That is my assumption as well, but I still wouldn't take the
risk one week before the merge window.

       Arnd
