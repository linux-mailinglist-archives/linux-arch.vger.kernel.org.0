Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3430F3A0AA0
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 05:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhFIDa1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 23:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhFIDa0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 23:30:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07D5461351;
        Wed,  9 Jun 2021 03:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623209313;
        bh=sVOvpgkj/HcQEC0DEM+Ytv8Acia96LYlFJs0iR7sVE0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Prreyzpb+3DlgrClJOr+3H3PX/coyUs5SEPJorPwPemvOan9aHP6vrbIqHWn3XYUH
         tooelE1e5K3whyhpOMytDg7IODDI4Dpwi92LT0ugkIfLQkSSmL1dwwEtUESd7WSv1V
         AuBFoRFO9NLSV+zam3AKBJC0Ses7L63TzeW/u0AZQqxTOb6lR5QJAvwvjB7BspZM1F
         V61tbf4lTiXl+veTtVpLMA+vYyhubEfhj+YK8JncnWYxCH0B5VXLyMOzQb9QQIxgVe
         M+6uCo1WvWGHSc7ZDJgFh4739nC9+6Co8EgnHe6H07ySNIzJHfPLNxcrQrYk+RTbeI
         XB5vuu+1cmxUg==
Received: by mail-lf1-f51.google.com with SMTP id p7so1535753lfg.4;
        Tue, 08 Jun 2021 20:28:32 -0700 (PDT)
X-Gm-Message-State: AOAM5337YhH/V2mz/a8o8IkWJcZ3/P+A6pOTANo5HmgjLFONQDpsHWXv
        I2BOrynFneRuVf2eu3PUMPJIKE+gWs/NxYRyO1w=
X-Google-Smtp-Source: ABdhPJwDVqYkObA62qLG+4TPhlT9SBuEvINu2sgJQXwLM5FUZrBppwPRTfk/CWhxukVGHyzD6LNcvNuNg8kJtWeuhAg=
X-Received: by 2002:ac2:4c0e:: with SMTP id t14mr17968325lfq.555.1623209311215;
 Tue, 08 Jun 2021 20:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com> <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
In-Reply-To: <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Jun 2021 11:28:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ5271AP8aw42yvfOg0LjtnmPD8j_Uza6NH2nHxVz_QgQ@mail.gmail.com>
Message-ID: <CAJF2gTQ5271AP8aw42yvfOg0LjtnmPD8j_Uza6NH2nHxVz_QgQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Christoph Hellwig <hch@lst.de>,
        Drew Fustini <drew@beagleboard.org>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Benjamin Koch <snowball@c3pb.de>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Wei Fu <tekkamanninja@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 7, 2021 at 2:14 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-05-20 04:45, Guo Ren =CE=AD=CE=B3=CF=81=CE=
=B1=CF=88=CE=B5:
> > On Wed, May 19, 2021 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote:
> >>
> >> On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote:
> >> > This patch series looks like it might be useful for the StarFive JH7=
100
> >> > [1] [2] too as it has peripherals on a non-coherent interconnect. GM=
AC,
> >> > USB and SDIO require that the L2 cache must be manually flushed afte=
r
> >> > DMA operations if the data is intended to be shared with U74 cores [=
2].
> >>
> >> Not too much, given that the SiFive lineage CPUs have an uncached
> >> window, that is a totally different way to allocate uncached memory.
> > It's a very big MIPS smell. What's the attribute of the uncached
> > window? (uncached + strong-order/ uncached + weak, most vendors still
> > use AXI interconnect, how to deal with a bufferable attribute?) In
> > fact, customers' drivers use different ways to deal with DMA memory in
> > non-coherent SOC. Most riscv SOC vendors are from ARM, so giving them
> > the same way in DMA memory is a smart choice. So using PTE attributes
> > is more suitable.
> >
> > See:
> > https://github.com/riscv/virtual-memory/blob/main/specs/611-virtual-mem=
ory-diff.pdf
> > 4.4.1
> > The draft supports custom attribute bits in PTE.
> >
>
> Not only it doesn't support custom attributes on PTEs:
>
> "Bits63=E2=80=9354 are reserved for future standard use and must be zeroe=
d by
> software for forward compatibility."
>
> It also goes further to say that:
>
> "if any of these bits are set, a page-fault exception is raised"
Agree, when our processor's mmu works in compatible mmu, we must keep
"Bits63=E2=80=9354 bit" zero in Linux.
So, I think this is the first version of the PTE format.

If the "PBMT" extension proposal is approved, it will cause the second
version of the PTE format.

Maybe in the future, we'll get more versions of the PTE formats.

So, seems Linux must support multi versions of PTE formats with one
Image, right?

Okay, we could stop arguing with the D1 PTE format. And talk about how
to let Linux support multi versions of PTE formats that come from the
future RISC-V privilege spec.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
