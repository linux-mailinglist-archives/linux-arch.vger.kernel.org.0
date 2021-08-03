Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D8E3DF358
	for <lists+linux-arch@lfdr.de>; Tue,  3 Aug 2021 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhHCQzY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Aug 2021 12:55:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49856 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbhHCQzV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Aug 2021 12:55:21 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9AF62208AB1C;
        Tue,  3 Aug 2021 09:55:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AF62208AB1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628009710;
        bh=HaZnRch7qGYi+vNB3ZsL/DxMMvFWSWo7WErtYkFspsA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AqQiLw3VaKWqCUN/H+n8qq2pZUS23BFriOKYNXAuSb5jhXpYWj7G7LgFeojqxQf6x
         mqZCNPddKk6DpRikD/4RZs93ChrmcXeQayXWgMqEASjuhGNmzU8GgwYgn3LeG4aDPP
         RTktki0FfxbM66o0jXqUM/6/BCX7CCWClgzilF/c=
Received: by mail-pj1-f48.google.com with SMTP id k4-20020a17090a5144b02901731c776526so4697267pjm.4;
        Tue, 03 Aug 2021 09:55:10 -0700 (PDT)
X-Gm-Message-State: AOAM530lBTF+WHfndLqJmgsZKbRogdnFwPDhgN6UJPhM+NtGCE/Vjyt3
        cdAhxa+LLE+qgrPYFAjDxgk/lFCtyKw4D0rovOI=
X-Google-Smtp-Source: ABdhPJyHModUoYFzGPnywl2pyBQ07SohodjnVZXvcoB4fJpsM/A9bOGcvvOjahQitRFqSsVmmvwQ8KmF3rNa1iPU0F0=
X-Received: by 2002:a17:90a:ad85:: with SMTP id s5mr23048097pjq.187.1628009710193;
 Tue, 03 Aug 2021 09:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210719114314.132364-1-mcroce@linux.microsoft.com>
In-Reply-To: <20210719114314.132364-1-mcroce@linux.microsoft.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 3 Aug 2021 18:54:34 +0200
X-Gmail-Original-Message-ID: <CAFnufp1QpMc87+-hwPa887iQQGCjjkGNanVSKOUsE-0ti82jrA@mail.gmail.com>
Message-ID: <CAFnufp1QpMc87+-hwPa887iQQGCjjkGNanVSKOUsE-0ti82jrA@mail.gmail.com>
Subject: Re: [PATCH] riscv: use the generic string routines
To:     linux-riscv <linux-riscv@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
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

On Mon, Jul 19, 2021 at 1:44 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> Use the generic routines which handle alignment properly.
>
> These are the performances measured on a BeagleV machine for a
> 32 mbyte buffer:
>
> memcpy:
> original aligned:        75 Mb/s
> original unaligned:      75 Mb/s
> new aligned:            114 Mb/s
> new unaligned:          107 Mb/s
>
> memset:
> original aligned:       140 Mb/s
> original unaligned:     140 Mb/s
> new aligned:            241 Mb/s
> new unaligned:          241 Mb/s
>
> TCP throughput with iperf3 gives a similar improvement as well.
>
> This is the binary size increase according to bloat-o-meter:
>
> add/remove: 0/0 grow/shrink: 4/2 up/down: 432/-36 (396)
> Function                                     old     new   delta
> memcpy                                        36     324    +288
> memset                                        32     148    +116
> strlcpy                                      116     132     +16
> strscpy_pad                                   84      96     +12
> strlcat                                      176     164     -12
> memmove                                       76      52     -24
> Total: Before=1225371, After=1225767, chg +0.03%
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Hi,

can someone have a look at this change and share opinions?

Regards,
-- 
per aspera ad upstream
