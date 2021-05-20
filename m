Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54AEE389B14
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 03:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhETCAi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 22:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhETCAi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 22:00:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F56D6135A;
        Thu, 20 May 2021 01:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621475957;
        bh=JdmBtI/nybX20LTYzwdeu3sRM7FFnENPxyFNjn3PhTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aQy9ccJsdFmRayoAiTGj43uqjruUasRMW3XaC7Y51U6ChraF+gd4VnB5Mm47kDzoF
         YtOxGgjcaqZept35IaUQW0QVaeAhwRn2ILFnGyv9rjSwh+marLBoRCyIbJ/p6xFnft
         V2MQ4C4f2aWrFpBp6vD41RmLBy5yWatN4r39rw8hffgO+MRPVrijETmZN5SYhNHtC6
         ZJtWFpbhBZRS9NwBEwEiN3/i/Yw67Xq4F7h1bfNd9n9SMfgpmkqUqZG/X5yLoUNN5J
         KR0y8HJp7SkFTsys/rn8aSejDiLFMkfizOeXOFWduU2BGIsxKMnNxfTzGVg9KmA8yw
         9magqsOUmrp8A==
Received: by mail-lf1-f52.google.com with SMTP id c10so1011332lfm.0;
        Wed, 19 May 2021 18:59:17 -0700 (PDT)
X-Gm-Message-State: AOAM5327WOAGgXW9GikDB3bFvnTUqsKYQwwWogk7vUYBfA80XEZj7B6q
        dX8cnR+Y35UQmd72YvGd6ze4QwhGKq+Ih2eYZMA=
X-Google-Smtp-Source: ABdhPJx4Yk2C9GqxDVxay2oozMIz1ibiukYQwG5GLFDi0mjK8VBRld1CDnMtfMIba/K4AMweT0lkvN1tYYTAfnwELo4=
X-Received: by 2002:ac2:5493:: with SMTP id t19mr1678843lfk.346.1621475955570;
 Wed, 19 May 2021 18:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
 <20210519052048.GA24853@lst.de> <CAJF2gTR5838=Uwc5P6Xs=G7vk80k0yqWcSsNe0OFcwc9sDBBHg@mail.gmail.com>
 <20210519060617.GA28397@lst.de> <20210519065431.GB3076809@x1>
 <CAAhSdy3C1owsbY_9gkxkhWfCXnL_noow7F4t=5+j7q+AJO3pZQ@mail.gmail.com> <CAJF2gTQKqce_6cmGQnfLOX8uXvOUWUR-pQT4yOMioMcFAPfBjQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQKqce_6cmGQnfLOX8uXvOUWUR-pQT4yOMioMcFAPfBjQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 May 2021 09:59:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR2gWETwiszV0n4otjHxu0hGXDp1TT9n=8hX8UHVZY3tw@mail.gmail.com>
Message-ID: <CAJF2gTR2gWETwiszV0n4otjHxu0hGXDp1TT9n=8hX8UHVZY3tw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
To:     Anup Patel <anup@brainfault.org>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>, wefu@redhat.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 20, 2021 at 9:47 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, May 19, 2021 at 3:15 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Wed, May 19, 2021 at 12:24 PM Drew Fustini <drew@beagleboard.org> wrote:
> > >
> > > On Wed, May 19, 2021 at 08:06:17AM +0200, Christoph Hellwig wrote:
> > > > On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
> > > > > Since the existing RISC-V ISA cannot solve this problem, it is better
> > > > > to provide some configuration for the SOC vendor to customize.
> > > >
> > > > We've been talking about this problem for close to five years.  So no,
> > > > if you don't manage to get the feature into the ISA it can't be
> > > > supported.
> > >
> > > Isn't it a good goal for Linux to support the capabilities present in
> > > the SoC that a currently being fab'd?
> > >
> > > I believe the CMO group only started last year [1] so the RV64GC SoCs
> > > that are going into mass production this year would not have had the
> > > opporuntiy of utilizing any RISC-V ISA extension for handling cache
> > > management.
> >
> > The current Linux RISC-V policy is to only accept patches for frozen or
> > ratified ISA specs.
> > (Refer, Documentation/riscv/patch-acceptance.rst)
> >
> > This means even if emulate CMO instructions in OpenSBI, the Linux
I think it's CBO now.
https://github.com/riscv/riscv-CMOs/blob/master/discussion-files/RISC_V_range_CMOs_bad_v1.00.pdf

> > patches won't be taken by Palmer because CMO specification is
> > still in draft stage.
> How do you think about
> sbi_ecall(SBI_EXT_DMA, SBI_DMA_SYNC, start, size, dir, 0, 0, 0);
> ? thx
CBO insn trap is okay for me ;-)

> >
> > Also, we all know how much time it takes for RISCV international
> > to freeze some spec. Judging by that we are looking at another
> > 3-4 years at minimum.
> >
> > Regards,
> > Anup
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
