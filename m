Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE053A6BC6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhFNQar (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 12:30:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234671AbhFNQao (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 12:30:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9970661159;
        Mon, 14 Jun 2021 16:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623688121;
        bh=QuC0LPIEqeWDHCOkT2QGTkfSNaoCYgvhRIgurH/K7cU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GDTMEM6yiElC5EiyXI3i5gIF36gt5e1ndXybFuN2yPPN4OLMd5j0STcFhM5l0JyFj
         LS41pFBMXKABI7CJPlEf37oFUfqhdfCOUW4w5YouPcQYkFpn4dBIYwPnGrQW5yWl0c
         X0rLx+kqO/wzPCG68MEQOyUAbR9n24kyJy3YE1QvmSUlFQMVmXbI7LO3nX/s6tI1sF
         SutoCNgF/y1CKu9q8Y2HVC21EkFREOscbzrhXseysHHQGhY/MWHHdb0t0mZgw5JlbR
         0yX72M/cU93jKwgB+/R9wMyJSdgAZRtFToJ53mMYI3hb5XkTUOvKwjvhRDsDsv6Gad
         UQV32aKADutcQ==
Received: by mail-lf1-f48.google.com with SMTP id p7so22108285lfg.4;
        Mon, 14 Jun 2021 09:28:41 -0700 (PDT)
X-Gm-Message-State: AOAM533E5EcCmSLh8L1wEpx2SreliR1s9ZXwgKawp5Q3RQRBxdvozC51
        Jt+tDh4EGKnV7Dka5Y4wAoGtoUqI/w1O3HJMYUY=
X-Google-Smtp-Source: ABdhPJxzeTa4/PiD5gCCDYqdxYkyzOIVBvy0RvjMV8prCb5Cw8b/0l0fXUuPdkd9faq3+17/mxMh9Sw5wNk+ROQT/nU=
X-Received: by 2002:a05:6512:3f02:: with SMTP id y2mr12850956lfa.355.1623688119927;
 Mon, 14 Jun 2021 09:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
 <1622970249-50770-13-git-send-email-guoren@kernel.org> <20210607072434.3g3bqxdlpxjirg6k@gilmour>
 <CAJF2gTStppyEoLD-ZToeHYdnzNoFhH2+3Lhd76=M8OFKS=Syow@mail.gmail.com> <20210614153341.z2nkx6sazaahhjfd@gilmour>
In-Reply-To: <20210614153341.z2nkx6sazaahhjfd@gilmour>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 15 Jun 2021 00:28:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTfMAGbHv3PN_0BmA1pRqU1UvZny4mKg14AtWKjAm8=vw@mail.gmail.com>
Message-ID: <CAJF2gTTfMAGbHv3PN_0BmA1pRqU1UvZny4mKg14AtWKjAm8=vw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1
 NeZha board
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Drew Fustini <drew@beagleboard.org>, liush@allwinnertech.com,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        wefu@redhat.com, linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 14, 2021 at 11:33 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Mon, Jun 07, 2021 at 04:07:37PM +0800, Guo Ren wrote:
> > On Mon, Jun 7, 2021 at 3:24 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > > +             reset: reset-sample {
> > > > +                     compatible = "thead,reset-sample";
> > > > +                     plic-delegate = <0x0 0x101ffffc>;
> > > > +             };
> > >
> > > This compatible is not documented anywhere?
> >
> > It used by opensbi (riscv runtime firmware), not in Linux. But I think
> > we should keep it.
>
> This should have a documentation still.

Could we detail the above in [1]?

1: https://github.com/riscv/opensbi/blob/master/docs/platform/thead-c9xx.md

>
> Maxime



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
