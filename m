Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7902022E7F2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 10:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgG0Ilt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 04:41:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44333 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0Ilt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 04:41:49 -0400
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MgNlH-1kR3ae0Egx-00htln; Mon, 27 Jul 2020 10:41:47 +0200
Received: by mail-qv1-f49.google.com with SMTP id di5so7035416qvb.11;
        Mon, 27 Jul 2020 01:41:46 -0700 (PDT)
X-Gm-Message-State: AOAM530yS4+RaonJrbla95HZiwRrIyxT4V4282Enlt2KgZHCsM1W7ILs
        AHOulQCiVbpZKpWoRzGM6CRS3PNXPI4rW+ni3/0=
X-Google-Smtp-Source: ABdhPJyFy7iTz1AbZ0fR7sKfDU51z6IeCONSD5JbC+rvcHhVLzEoSaPB8khjv+HojCYyEyIzph23AGS99NUwimzjZoE=
X-Received: by 2002:a0c:cc01:: with SMTP id r1mr709301qvk.4.1595839305851;
 Mon, 27 Jul 2020 01:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200726031154.1012044-1-shorne@gmail.com> <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
 <20200726125325.GC80756@lianli.shorne-pla.net> <CAK8P3a0-wPsVi-fXPW4Dghn30cumrzvLujp7usio50EHmCHM=g@mail.gmail.com>
 <a55f21a7-aff9-09a9-2fcd-c9ef76728116@huawei.com>
In-Reply-To: <a55f21a7-aff9-09a9-2fcd-c9ef76728116@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 10:41:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a37s8ct5moydwwVO+C5TLfW+GU6VS-+zuAQfZzs2czXaw@mail.gmail.com>
Message-ID: <CAK8P3a37s8ct5moydwwVO+C5TLfW+GU6VS-+zuAQfZzs2czXaw@mail.gmail.com>
Subject: Re: [PATCH] io: Fix return type of _inb and _inl
To:     John Garry <john.garry@huawei.com>
Cc:     Stafford Horne <shorne@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gzg4p9Vgjp+46iDBHEFnConwigWrr+5uZFAlW//h7+Z9pmupd4h
 LQy9RHqT1BM3PygvxEJAfygQ9Iq56S/lXffJxD8EbY4pBHLohnIqxAVATfI+AKZm81lP5fr
 w7lm32PtZSq5LYtiGPSPVt0tcS7avhyjG/jDrrY0FdO7kzksply7HS2JlNXeDep7gX63puk
 OGdEEa2tLUUDnp3Sbpn0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yD8d1g1NW7g=:SehQg26NrsPZDVWSpyInSx
 Pw6nBb9dAfbt0G0+MJt7ZC18+XwDjHQUkz6zYakN73u72EVaRmJqJ/K/D1VN1+ETP+Wlg4PVU
 GGA2LqoxTNK3gox/nnkj0qzxRJK9fvhIrN4lnDDtV8m/T6DB5/myRIZKt2Bj7IT7Bj/IsK2Ks
 oTma2KROK5iopV4zQKvj7sOeFmIV4loR/3YgZqRVIPqJzup82+h0tKlioU7AfsrrhnVjH9N0H
 j+o94VMsn8GL5PKKFmCI/Uas9YRyujH159wxdEjj1L4Mp8MUUMRA3ch46X9Og0JZF/Ov3JSAT
 MayaHwXCGz6BUbysk3YFix33p3ASBzBgPt7QzfZffdlIQrbsVn2Rla5waDfrRu4oPzYOlwBdd
 qawDoziVEqk8uS7p6Ww/SCbDSWJ4Djei43UuOtOkSGLpZtc2qqs6zTj8djQDM3KqDCAinui+i
 TZokX613Hnbrp2+Mi7hD9l6/GkHHD9U7ZKqvF3plMG9mN2st2k9hE6rm+bcL1RxIqnFlaB6ey
 oGPunheLjNveZMpZo44y0KlxUix/3wkTbo/UaLgioKdqBp9HlxEWpAy/vYe/oHFeLXshsR/GE
 fdwZ8jQC4VyAdk+6ammoAcrZ9Rc62bx4RtIY39nvA/r3QM4Fx1kzCuEJgjbsAjY27FhwMgNF8
 YWRHi284XTPUrxUO/D3UYeX/rFUKsxBtO3CskaRx4cnPlq65A/BC8VT009rrylA6v2zk7dZI3
 PVO8CVV2k5B/VpZ6eYNgO7zhXvMXFvXlqjrF8ashU1DVgbWetCuddXqjgL1854lJbLT0HBoKR
 +rJX9wcqz3jxZxEiWr4pM+7kqWJHmFfGwkUOsvLTock/C04dBb82Vs0pY6B114y5Y7D+lXygM
 yXyU18UAOo5UQxJddeD2hbnSuZ2q0FFzBTRAmyLGiuXY0ggw/LPlARY2kwrKjGv61e3ZJ+GUN
 gYy1Hs3Dg5zNNLc3r6ulz3gmFjVgmNqpgGL/Gp63twJAs39svx9Ob
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 27, 2020 at 10:30 AM John Garry <john.garry@huawei.com> wrote:
> On 27/07/2020 09:04, Arnd Bergmann wrote:> On Sun, Jul 26, 2020 at 2:53
> PM Stafford Horne <shorne@gmail.com> wrote:
> >>
> >> On Sun, Jul 26, 2020 at 12:00:37PM +0300, Andy Shevchenko wrote:
> >>> On Sun, Jul 26, 2020 at 6:14 AM Stafford Horne <shorne@gmail.com> wrote:
> >>>>
> >>>> The return type of functions _inb, _inw and _inl are all u16 which looks
> >>>> wrong.  This patch makes them u8, u16 and u32 respectively.
> >>>>
> >>>> The original commit text for these does not indicate that these should
> >>>> be all forced to u16.
> >>>
> >>> Is it in alight with all architectures? that support this interface natively?
> >>>
> >>> (Return value is arch-dependent AFAIU, so it might actually return
> >>> 16-bit for byte read, but I agree that this is weird for 32-bit value.
> >>> I think you have elaborate more in the commit message)
> >>
> >> Well, this is the generic io code,  at least these api's appear to not be different
> >> for each architecture.  The output read by the architecture dependant code i.e.
> >> __raw_readb() below is getting is placed into a u8.  So I think the output of
> >> the function will be u8.
> >>
> >> static inline u8 _inb(unsigned long addr)
> >> {
> >>          u8 val;
> >>
> >>          __io_pbr();
> >>          val = __raw_readb(PCI_IOBASE + addr);
> >>          __io_par(val);
> >>          return val;
> >> }
> >>
> >> I can expand the commit text, but I would like to get some comments from the
> >> original author to confirm if this is an issue.
> >
> > I think your original version is fine, this was clearly just a typo and I've
> > applied your fix now and will forward it to Linus in the next few days,
> > giving John the chance to add his Ack or further comments.
> >
> > Thanks a lot for spotting it and sending a fix.
>
> Thanks Arnd.
>
> Yeah, these looks like copy+paste errors on my part:
>
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks!

>
> I'll give this patch a spin, but not expecting any differences (since
> original seems ok).
>
> Note that kbuild robot also reported this:
> https://lore.kernel.org/lkml/202007140549.J7X9BVPT%25lkp@intel.com/
>
> Extract:
>
> include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in
> argument 1 (different base types) @@     expected unsigned int
> [usertype] value @@     got restricted __le32 [usertype] @@
>     include/asm-generic/io.h:521:22: sparse:     expected unsigned int
> [usertype] value
>     include/asm-generic/io.h:521:22: sparse:     got restricted __le32
> [usertype]
>
> But they look like issues which were in the existing code.

Yes, this driver code (atm/ambassador.c) seems to have been broken that
way since it was merged in 1999.

      Arnd
