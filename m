Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772DF3A14BA
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhFIMpv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 08:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhFIMpv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 08:45:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC74E613BC;
        Wed,  9 Jun 2021 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623242636;
        bh=10QiHmdISEb61jB5RWmOiBIlcBu20xh90lnX4V4t658=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=np63E2gLpqH2koO1sA8ouLSSpC5l15+gBFl6+tWS96shPTdNepYNSn9cDSH/uvA9y
         iqwMawHznNJuDnZBDAJygJJxFKosRf8hQetp6ufT8EQ+TG9Hx3zQQDkFk/TS14Jlp/
         w1t5fxf4TWd+lKiXS2DrJfiMqguIKgFwYNf+Me7oO9nDLwkoj+kUkc5eE3BQ49kDKi
         EYy7NqMcB5S56mhY1v2FB9T512g+Bx2i/aPIMTOtai05lTAYvjzGjsXRGOHqrlVgFr
         1Imj5zRfZv12UODH98O9MTB/PYHwhgqUM/2FR9hAafvLcjKbGOEVSAIV73rjJ8IcZy
         u85/1m9Ee5UAA==
Received: by mail-lj1-f172.google.com with SMTP id s22so11050291ljg.5;
        Wed, 09 Jun 2021 05:43:56 -0700 (PDT)
X-Gm-Message-State: AOAM531XBC2Q4Jq1hYTwkUPZUOPhnLmaUIxnNECzoMfXU+ype/ky4HG8
        1gq2BTZXIijNudk36SdtmdjIsW33XxHBNZ1+70k=
X-Google-Smtp-Source: ABdhPJwaURGU3O5Ijy4ZAJhrS1dz1Pr8wQ0Y85BdkXWeynG0YUhR28g4jNQRqhR4QWRMjatsBLaORSkBBJxkyOyBss8=
X-Received: by 2002:a2e:900f:: with SMTP id h15mr20711283ljg.285.1623242634796;
 Wed, 09 Jun 2021 05:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
 <20210519064435.GA3076809@x1> <20210519065352.GA31590@lst.de>
 <CAJF2gTR4FXRbp7oky-ypdVJba6btFHpp-+dPyJStRaQX_-5rzg@mail.gmail.com>
 <29733b0931d9dd6a2f0b6919067c7efe@mailhost.ics.forth.gr> <CAJF2gTQ5271AP8aw42yvfOg0LjtnmPD8j_Uza6NH2nHxVz_QgQ@mail.gmail.com>
 <78f544f739120f5b541238a1d5f6e23b@mailhost.ics.forth.gr>
In-Reply-To: <78f544f739120f5b541238a1d5f6e23b@mailhost.ics.forth.gr>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Jun 2021 20:43:43 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSko9yu_Hqgu3vOzjS=uPKC8jaLdgkAXx1BW2k26uuJRg@mail.gmail.com>
Message-ID: <CAJF2gTSko9yu_Hqgu3vOzjS=uPKC8jaLdgkAXx1BW2k26uuJRg@mail.gmail.com>
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

On Wed, Jun 9, 2021 at 5:45 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-06-09 06:28, Guo Ren =CE=AD=CE=B3=CF=81=CE=
=B1=CF=88=CE=B5:
> > On Mon, Jun 7, 2021 at 2:14 AM Nick Kossifidis <mick@ics.forth.gr>
> > wrote:
> >>
> >> =CE=A3=CF=84=CE=B9=CF=82 2021-05-20 04:45, Guo Ren =CE=AD=CE=B3=CF=81=
=CE=B1=CF=88=CE=B5:
> >> > On Wed, May 19, 2021 at 2:53 PM Christoph Hellwig <hch@lst.de> wrote=
:
> >> >>
> >> >> On Tue, May 18, 2021 at 11:44:35PM -0700, Drew Fustini wrote:
> >> >> > This patch series looks like it might be useful for the StarFive =
JH7100
> >> >> > [1] [2] too as it has peripherals on a non-coherent interconnect.=
 GMAC,
> >> >> > USB and SDIO require that the L2 cache must be manually flushed a=
fter
> >> >> > DMA operations if the data is intended to be shared with U74 core=
s [2].
> >> >>
> >> >> Not too much, given that the SiFive lineage CPUs have an uncached
> >> >> window, that is a totally different way to allocate uncached memory=
.
> >> > It's a very big MIPS smell. What's the attribute of the uncached
> >> > window? (uncached + strong-order/ uncached + weak, most vendors stil=
l
> >> > use AXI interconnect, how to deal with a bufferable attribute?) In
> >> > fact, customers' drivers use different ways to deal with DMA memory =
in
> >> > non-coherent SOC. Most riscv SOC vendors are from ARM, so giving the=
m
> >> > the same way in DMA memory is a smart choice. So using PTE attribute=
s
> >> > is more suitable.
> >> >
> >> > See:
> >> > https://github.com/riscv/virtual-memory/blob/main/specs/611-virtual-=
memory-diff.pdf
> >> > 4.4.1
> >> > The draft supports custom attribute bits in PTE.
> >> >
> >>
> >> Not only it doesn't support custom attributes on PTEs:
> >>
> >> "Bits63=E2=80=9354 are reserved for future standard use and must be ze=
roed by
> >> software for forward compatibility."
> >>
> >> It also goes further to say that:
> >>
> >> "if any of these bits are set, a page-fault exception is raised"
> > Agree, when our processor's mmu works in compatible mmu, we must keep
> > "Bits63=E2=80=9354 bit" zero in Linux.
> > So, I think this is the first version of the PTE format.
> >
> > If the "PBMT" extension proposal is approved, it will cause the second
> > version of the PTE format.
> >
> > Maybe in the future, we'll get more versions of the PTE formats.
> >
> > So, seems Linux must support multi versions of PTE formats with one
> > Image, right?
> >
> > Okay, we could stop arguing with the D1 PTE format. And talk about how
> > to let Linux support multi versions of PTE formats that come from the
> > future RISC-V privilege spec.
>
> The RISC-V ISA specs are meant to be backwards compatible, so newer PTE
> versions should work on older devices (note that the spec says that
> software must set those bits to zero for "forward compatibility" and are
> "reserved for future use" so current implementations must ignore them).
> Obviously the proposed "if any of these bits are set, a page-fault
> exception is raised" will break backwards compatibility which is why we
> need to ask for it to be removed from the draft.
>
> As an example the PBMT proposal uses bits 62:61 that on older hw should
> be ignored ("reserved for future use"), if Linux uses those bits we
> won't need a different code path for supporting older hw/older PTE
> versions, we'll just set them and older hw will ignore them. Because of
> the guarantee that ISA specs maintain backwards compatibility, the
> functionality of bits 62:61 is guaranteed to remain backwards
> compatible.
the spec says that software must set those bits to zero for "forward
compatibility". So how older hw ignore them?
If an older hw follow the current spec requires software to set those
bits to zero, how we put any PBMT bits without different Linux PTE
formats?

>
> In other words we don't need any special handling of multiple PTE
> formats, we just need to support the latest Priv. Spec and the Spec
> itself will guarantee backwards compatibility.
Nak, totally no Logically self-consistent.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
