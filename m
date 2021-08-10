Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39DF3E592B
	for <lists+linux-arch@lfdr.de>; Tue, 10 Aug 2021 13:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhHJLeb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Aug 2021 07:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhHJLeb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Aug 2021 07:34:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40E386101E;
        Tue, 10 Aug 2021 11:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628595249;
        bh=U4Zld7mAu6v7/9xMDyWvpT/NNYAWTiUJU4He5dD/eL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lJZtsLaj7jaRkxeJSZpFbApjAOcERUr6k3R9FD36dUPQtws4z6KYPDzXzDfxVdwp+
         I4Rx380OJYH4+KsXFBVtVm/uNG5+BdcR8Ahwh6jgjxh0K/tABjGp27T2Hg8JZBXE66
         8vBTJdpdvoQehoE9FCEvW0W8q/WWprPCty3ERtdmGnbv+mapiDKrWvnX8QiMmTnYa2
         eYoAva5zQNUQpGzDJ8+QTXuMJ98dyx8tkIJ3Dt2Fuj9PHNrLQFBRSE/kIXBj0GOi3Z
         1go5tRWI2r6aELq/bjZcQ5B37g3vK98ee8qExwrQ3Eb4Nk0uOW3E9PugjHiPxx5cBQ
         drvvS5gCGI1tg==
Received: by mail-wr1-f54.google.com with SMTP id i4so8337645wru.0;
        Tue, 10 Aug 2021 04:34:09 -0700 (PDT)
X-Gm-Message-State: AOAM5305gi1q9rTqsanlIG5ZRWYeUAyZc58HNcj3DqN4dPj1uy6WfPms
        1x7VI5hCJVipRmNQey0KM6Dgbqvl+ToDS2hZJIs=
X-Google-Smtp-Source: ABdhPJyjNp84V0PWdniYskkVm3tgBt8qm+LU5nYRyMlh1QdiRB65+ZJ6dm/n9ev4DK0S0p/m2pg884gI41cWjwdHPfc=
X-Received: by 2002:adf:a309:: with SMTP id c9mr12971585wrb.99.1628595247894;
 Tue, 10 Aug 2021 04:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com> <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com> <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com> <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
 <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com>
In-Reply-To: <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 10 Aug 2021 13:33:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
Message-ID: <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     John Garry <john.garry@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 10, 2021 at 11:19 AM John Garry <john.garry@huawei.com> wrote:
> On 04/08/2021 09:52, Arnd Bergmann wrote:
>
> This seems a reasonable approach. Do you have a plan for this work? Or
> still waiting for the green light?

I'm rather busy with other work at the moment, so no particular plans
for any time soon.

> I have noticed the kernel test robot reporting the following to me,
> which seems to be the same issue which was addressed in this series
> originally:
>
> config: s390-randconfig-r032-20210802 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project
> 4f71f59bf3d9914188a11d0c41bedbb339d36ff5)
> ...
> All errors (new ones prefixed by >>):
>
>     In file included from drivers/block/null_blk/main.c:12:
>     In file included from drivers/block/null_blk/null_blk.h:8:
>     In file included from include/linux/blkdev.h:25:
>     In file included from include/linux/scatterlist.h:9:
>     In file included from arch/s390/include/asm/io.h:75:
>     include/asm-generic/io.h:464:31: warning: performing pointer
> arithmetic on a null pointer has undefined behavior
> [-Wnull-pointer-arithmetic]
>             val = __raw_readb(PCI_IOBASE + addr);
>
> So I imagine lots of people are seeing these.

Right, this is the original problem that Niklas was trying to solve.

If Niklas has time to get this fixed, I can probably find a way to work
with him on finishing up my proposed patch with the changes you
suggested.

       Arnd
