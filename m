Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474BD177C1F
	for <lists+linux-arch@lfdr.de>; Tue,  3 Mar 2020 17:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgCCQk1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Mar 2020 11:40:27 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:49155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgCCQk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Mar 2020 11:40:26 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MPK73-1ikEFR28x3-00PhDC; Tue, 03 Mar 2020 17:40:24 +0100
Received: by mail-qv1-f45.google.com with SMTP id m2so1935808qvu.13;
        Tue, 03 Mar 2020 08:40:24 -0800 (PST)
X-Gm-Message-State: ANhLgQ1L6n6KTzYlwVfLNgKCjVJHL8XwnhYBkuNc7C4zu1XEyOaL/+6O
        GWDD7sGXQ/tEQOuknSGuS/ikSCH6eaXKvIfcC6g=
X-Google-Smtp-Source: ADFU+vvYQ6QVCbbYeP2nxaqh43OevpTsL0y0S8ngiP8jykUds6UhfBGQ9l/IAMS619c4WMkVGB7+nyot4prtq/wbHaI=
X-Received: by 2002:ad4:52eb:: with SMTP id p11mr4409475qvu.211.1583253623303;
 Tue, 03 Mar 2020 08:40:23 -0800 (PST)
MIME-Version: 1.0
References: <2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com>
 <c1489f55-369d-2cff-ff36-b10fb5d3ee79@kernel.org> <8207cd51-5b94-2f15-de9f-d85c9c385bca@huawei.com>
 <6115fa56-a471-1e9f-edbb-e643fa4e7e11@kernel.org> <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
In-Reply-To: <7c955142-1fcb-d99e-69e4-1e0d3d9eb8c3@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Mar 2020 17:40:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
Message-ID: <CAK8P3a0f9hnKGd6GJ8qFZSu+J-n4fY23TCGxQkmgJaxbpre50Q@mail.gmail.com>
Subject: Re: About commit "io: change inX() to have their own IO barrier overrides"
To:     John Garry <john.garry@huawei.com>
Cc:     Sinan Kaya <okaya@kernel.org>, "xuwei (O)" <xuwei5@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z+rfw91k0yBXGTxYmAF27L5RO5bYvndcnQl3QvY0qa+11t82c4A
 aEftFnFNtRQh7ti1uBrC2QXBvw46MOG31rfeZH/4dufxdRTjgk+5mTT6DTQFNiphCnyyveD
 WNBsduF9+WTmKcC6ir6cS/c7m5qa8jYjrtEl21R2hMeRGyJMsH0TxqVP6rdDkIIUwvatKwy
 2Xs/4w+TQRMhegSS7xxiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/fuQ74ZvKq4=:aFiybEA3opYHOBEE2ncNhm
 CpDErlSZtA+YzXQYABOulD1y3Tk5DxEucO7h2S4xIYgDKz7dYetZXBlJ7lKnBI4BtncYYvPM0
 l/6wLoAvASoIaOtuot7zCuMXgXx3ujRlH1F3xgHTnDknhcoqiZRtD4ix9zhavRtrt2ncaMhI+
 529LlkNNH7n8A838GZs9lDg8ZNPCMomT7teyTlNdDIHGMecZ+1elA+0vnnbxkFAjZ5bpVS5Oq
 9wAZ4q+iM356354HPanvzYoBYI8GNFVMCbhAFlRBrJIDT2u2l8HDOn3/eH/eRRn27H0e+/7l4
 JmFlWHF/oA9RbbN4zexON8lPLrRGJ2wZhmkVgN5pP3Cwj2VukMYne12WstAm8lKrMN3oWF5/8
 gF1DiGcxgPxyhPaigKqXpqCxpWepp1LaMezQLj8xmtUMUW/c5uQB9xOrMiSyoJJ5Uj3c2/tR9
 fBK4k+rZBSG5i7g3X3R6KTPPsLWc3idwY9KYGkdnUEiObbPXda4HTMZffa48yQVzB2Hyn6MJM
 5VLoCDqmfx+FFbHCzciyc78sjsXuMeW8y8AhVvxFGHfppGUpu8AeoGXpFf6P6xZ3gzvCPIGoo
 kbsxIHBrWYrEYLXgjC+V/STYT/+Q9NdT+NSImQGokYdqgH8D6AApq5D/9t7Mmj8mthiArCwmC
 tpsh9wQlykwS401GQNDx+ospuyx4Wi7yyqgu3cyv4V0kORKb0uTG2WfJWLJ+gMcOIIFcNCokB
 3i3pQUrIIAhdbHzvd3VORDexCXcZdP8po1IMYQiEk0R2HizupOkS4Wyy7ZJODGsp61A5mTNQ1
 p+pk90z1Xbn8r2VpxS04S+1z/k/Nyp8q1h8gcvjqN4I3CqaNJw=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 3, 2020 at 2:18 PM John Garry <john.garry@huawei.com> wrote:
>
> + linux-arch
>
> For background, see
> https://lore.kernel.org/lkml/2e80d7bc-32a0-cc40-00a9-8a383a1966c2@huawei.com/
>
> >>
> >> So today only ARM64 uses it for this relevant code, above. But maybe
> >> others in future will want to use it - any arch without native IO port
> >> access is a candidate.
> >
> > I'm looking at Arnd here for help.
> >
> >>
> >>>
> >>> As long as the expectations are set, I see no reason why it shouldn't
> >>> but, I'll let Arnd comment on it too.
> >>
> >> ok, so it looks reasonable consider replicating your change for ***, above.
>
> To be clear, I would make this change in lib/logic_pio.c since
> __io_pbr() can be overridden per-arch:
>
>   #define BUILD_LOGIC_IO(bw, type)
>   type logic_in##bw(unsigned long addr)
>   {
>        type ret = (type)~0;
>        if (addr < MMIO_UPPER_LIMIT) {
> -          ret = read##bw(PCI_IOBASE + addr);
> +          __io_pbr();
> +          ret = __raw_read##bw(PCI_IOBASE + addr);
> +          __io_pbr();

__io_par();

>        } else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {
>            struct logic_pio_hwaddr *entry = find_io_range(addr);
>
> ...
>
> (forgetting leX_to_cpu for the moment)

Yes, I suppose this is required to get consistent behavior on arm64,
which overrides __io_par() but not __io_ar(), with the current code
the barrier after read is weaker when LOGIC_PIO is enabled than it
is otherwise.

For other architectures, I suppose we would need another indirection
level, as those can also override the default inb() itself to do something
other than readb(PCI_IOBASE + addr), and that is not handled
here either. We can do that if we need LOGIC_PIO on a second
architecture.

       Arnd
