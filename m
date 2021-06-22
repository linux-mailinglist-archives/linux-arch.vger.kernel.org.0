Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E3D3AFB23
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 04:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFVCmR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 22:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhFVCmQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Jun 2021 22:42:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 75D256120D;
        Tue, 22 Jun 2021 02:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624329601;
        bh=5kf0xaAD8wEWnNmPDX+5RNxnyxXPsxVMT9o9aiq6skU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lqghe0x9BT/w83E/LU5mo8iJbvWbgZSuit/45gevMKYaIXtSWZ/1z705+A6bQhEat
         xkRQR7HUE+7CN9KvPBB5ZRcLu0WKesOuEzP6rMYjiOhi75FPbsEr8ifB01W3Kl3ds8
         IoWvtCJWa53gIyaKDG2O/khrACMUdSdqKUkpO8hs9jyWLONtQOthac+izHLq9/xv06
         bbmYkvKYulcBjof7L3wsOP5jGrKXxxZcan7gtoQhE1tiKFN30BOXeJ4Ab/Rc4NE203
         Q12rNELllrKm2QvYbMREzw9b9dMPFLhN7TMRnnVKjukGiTC00VfjY/4QO7IrPsLBof
         aVLTH9f3CoqLQ==
Received: by mail-lj1-f173.google.com with SMTP id a16so6435183ljq.3;
        Mon, 21 Jun 2021 19:40:01 -0700 (PDT)
X-Gm-Message-State: AOAM533ZjHLPI+LWRhpMavZy3NgYfvLU9yHGFnq9NpzQVjM8AiFEZcDf
        kcV+3iJWmm89+SL9CUW8fzGYVFOL/NqXBgI9EmU=
X-Google-Smtp-Source: ABdhPJwaE7X7V/NNZnXsKtAApRFD8er7mpM4NwDHR/R5llESxNtdnmOSlhREOJVKaZQVuejMRimHvOVhRlhXEKVItoM=
X-Received: by 2002:a05:651c:211d:: with SMTP id a29mr1068278ljq.115.1624329599798;
 Mon, 21 Jun 2021 19:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210617152754.17960-1-mcroce@linux.microsoft.com> <e968312557f147af1e5efb341eeef0ad@mailhost.ics.forth.gr>
In-Reply-To: <e968312557f147af1e5efb341eeef0ad@mailhost.ics.forth.gr>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 22 Jun 2021 10:39:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTipWCvwu0p7CdPqr2krfHvviQxqdNPCy9VHBUXvh6FyQ@mail.gmail.com>
Message-ID: <CAJF2gTTipWCvwu0p7CdPqr2krfHvviQxqdNPCy9VHBUXvh6FyQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] riscv: optimized mem* functions
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 22, 2021 at 9:09 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Hello Matteo,
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-06-17 18:27, Matteo Croce =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Replace the assembly mem{cpy,move,set} with C equivalent.
> >
> > Try to access RAM with the largest bit width possible, but without
> > doing unaligned accesses.
> >
> > Tested on a BeagleV Starlight with a SiFive U74 core, where the
> > improvement is noticeable.
> >
>
> There are already generic C implementations for memcpy/memmove/memset at
> https://elixir.bootlin.com/linux/v5.13-rc7/source/lib/string.c#L871 but
> are doing one byte at a time, I suggest you update them to do
> word-by-word copy instead of introducing yet another memcpy/memmove C
> implementation on arch/riscv/.
Yes, I've tried to copy the Glibc version into arch/csky/abiv1, and
Arnd suggested putting them into generic.
ref: https://lore.kernel.org/linux-arch/20190629053641.3iBfk9-I_D29cDp9yJnI=
dIg7oMtHNZlDmhLQPTumhEc@z/#t

>
>
>



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
