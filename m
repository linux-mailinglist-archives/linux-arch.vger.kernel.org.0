Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A988D3E12AE
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbhHEKbz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Aug 2021 06:31:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47730 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbhHEKbx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Aug 2021 06:31:53 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8FAB920B36ED;
        Thu,  5 Aug 2021 03:31:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FAB920B36ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628159499;
        bh=ePlKPhwRIbIIFc+MuT827+okoKvGxizkUBUP/w4ErsE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pjAa4Q58vbxnUikwyYqOtoHBFxksV2ox51gdNK8v6ZdmyeLfBka8OCjfdWkiu/oQR
         8Io+iu0nNtKxyKl2Jn9y+eBlz9MQWvgCaFoqtiQcluqUgeqL1GkwiDN+LfVHszd+np
         EA0N1IBvlOvftaEGDTq/I2JWJJ+4umT2At7V+VHc=
Received: by mail-pj1-f46.google.com with SMTP id l19so7669616pjz.0;
        Thu, 05 Aug 2021 03:31:39 -0700 (PDT)
X-Gm-Message-State: AOAM531YqyRCmOidWnKiMz3RXQMB2X9PlCofjzHNSLBQ7VcYRrPbtViB
        ooyqRNyUMoxdffXmugKa2rTjm9F8qBllXgbVQZk=
X-Google-Smtp-Source: ABdhPJxdohcSXq2Fna33fIGUiEu6kUIdxZ6/UhzFU8Koaz6JrTkw4lOh1yVNgX/OfIBQqhE040kGEhxRvLm7q8DNB0E=
X-Received: by 2002:aa7:80d1:0:b029:399:ce3a:d617 with SMTP id
 a17-20020aa780d10000b0290399ce3ad617mr4286293pfn.16.1628159499106; Thu, 05
 Aug 2021 03:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFnufp1QpMc87+-hwPa887iQQGCjjkGNanVSKOUsE-0ti82jrA@mail.gmail.com>
 <mhng-7b8d3a12-e223-4b69-a35a-617b0d7ac8f7@palmerdabbelt-glaptop>
In-Reply-To: <mhng-7b8d3a12-e223-4b69-a35a-617b0d7ac8f7@palmerdabbelt-glaptop>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 5 Aug 2021 12:31:04 +0200
X-Gmail-Original-Message-ID: <CAFnufp0eVejrDJoGE900D2U5-9qi-srVEmPOc9zHC5mSH4DgLg@mail.gmail.com>
Message-ID: <CAFnufp0eVejrDJoGE900D2U5-9qi-srVEmPOc9zHC5mSH4DgLg@mail.gmail.com>
Subject: Re: [PATCH] riscv: use the generic string routines
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 4, 2021 at 10:40 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 03 Aug 2021 09:54:34 PDT (-0700), mcroce@linux.microsoft.com wrote:
> > On Mon, Jul 19, 2021 at 1:44 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
> >>
> >> From: Matteo Croce <mcroce@microsoft.com>
> >>
> >> Use the generic routines which handle alignment properly.
> >>
> >> These are the performances measured on a BeagleV machine for a
> >> 32 mbyte buffer:
> >>
> >> memcpy:
> >> original aligned:        75 Mb/s
> >> original unaligned:      75 Mb/s
> >> new aligned:            114 Mb/s
> >> new unaligned:          107 Mb/s
> >>
> >> memset:
> >> original aligned:       140 Mb/s
> >> original unaligned:     140 Mb/s
> >> new aligned:            241 Mb/s
> >> new unaligned:          241 Mb/s
> >>
> >> TCP throughput with iperf3 gives a similar improvement as well.
> >>
> >> This is the binary size increase according to bloat-o-meter:
> >>
> >> add/remove: 0/0 grow/shrink: 4/2 up/down: 432/-36 (396)
> >> Function                                     old     new   delta
> >> memcpy                                        36     324    +288
> >> memset                                        32     148    +116
> >> strlcpy                                      116     132     +16
> >> strscpy_pad                                   84      96     +12
> >> strlcat                                      176     164     -12
> >> memmove                                       76      52     -24
> >> Total: Before=1225371, After=1225767, chg +0.03%
> >>
> >> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> >> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> >> ---
> >
> > Hi,
> >
> > can someone have a look at this change and share opinions?
>
> This LGTM.  How are the generic string routines landing?  I'm happy to
> take this into my for-next, but IIUC we need the optimized generic
> versions first so we don't have a performance regression falling back to
> the trivial ones for a bit.  Is there a shared tag I can pull in?

Hi,

I see them only in linux-next by now.

-- 
per aspera ad upstream
