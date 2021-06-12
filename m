Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5D3A510D
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 23:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFLVuE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 17:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLVuD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Jun 2021 17:50:03 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2333C061574;
        Sat, 12 Jun 2021 14:47:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p13so7489562pfw.0;
        Sat, 12 Jun 2021 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93BDk6ii6Pzm95rLYvyCEAhPCJypbard9KLuegJmtkA=;
        b=tdOajCxOaB1QVuqnE5e2BJncjyoNLaur2vmkKimf73qd0dGIu0pNcmGci50BlaN6JS
         Q604+FNuaj/LxqmBBI57CQt0pFAnGt4OToX+VMhO9IoxDzyVfAbcGwRR4TmsYs5/R7jm
         7ek8fAgWHq1w9+5fmrzvBKv0hmUoyFyetZ/cllmSuymPanj0WKNgHZ6sDqw3+1c64r2t
         MQbAg6Pm8YETs+L4ETcqD+G57R1+xbEnOYVehOWFNnuDWQEOHJ+sx+ZUJ+xKQ43Q3Zr4
         CGZDfjU1YIfYP1d+NBPDLZJSUCtmLmWUqeZQuJl3pOxE7/+gjWIZmEZU1eHd6wiXqkSl
         8z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93BDk6ii6Pzm95rLYvyCEAhPCJypbard9KLuegJmtkA=;
        b=M8hUh2jR0pH+P1s5A09yuGCe7QctNSVuoLmTKzNcz2jDfNgHoCdhYCgRz2qfMEm7cl
         M3vdd2uhxTVBhZ+tVVKYC8+fF71qAEb4tpLx5tNRv6nyHC4dg0EYks/6CbdJx1LvBTG5
         eojd1vLU5dhgfdYMlsow0cVX+GFsXN/fhsojXlvvjBvVbFya1MYDaj1eMF0h38bXyWwY
         sgJ2P8He+HJgtH9kJAkh+d8Z7RVfe3jBWku1KRJz1sqscF7pABRNGJ2RH3ZRa5q3hTfG
         CdQq5TwLiNjg/qL4RM50LFS99WByLv63eW5bDuiw1Apz2Y6XKJGLdC6UbOF9xpN/riIa
         jW6w==
X-Gm-Message-State: AOAM533i4OW22MjNm316tKTxKnRVaRC3KyNyCzD3wiemBAx6M974WfMg
        nXkVmjAvxVXnn4x0ZDts2rWpeGWLb5m2RExYJiA=
X-Google-Smtp-Source: ABdhPJwEUrc8Jgbcf8aITJR5mWDcB4sziIvoDhteE1kfD9qINugQ1zcYbFRHNih3Yvhl8ag/iqVI9Bc0MrSMFVJg9jI=
X-Received: by 2002:a63:4145:: with SMTP id o66mr10139317pga.4.1623534467337;
 Sat, 12 Jun 2021 14:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210612123639.329047-1-yury.norov@gmail.com> <20210612123639.329047-8-yury.norov@gmail.com>
In-Reply-To: <20210612123639.329047-8-yury.norov@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Jun 2021 00:47:31 +0300
Message-ID: <CAHp75VerU1NJMweWCR7MsE9hiMFZyJP8m751OFKmGrJ1gVhMWw@mail.gmail.com>
Subject: Re: [PATCH 7/8] all: replace find_next{,_zero}_bit with
 find_first{,_zero}_bit where appropriate
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 12, 2021 at 3:39 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> find_first{,_zero}_bit is a more effective analogue of 'next' version if
> start == 0. This patch replaces 'next' with 'first' where things look
> trivial.

Depending on the maintainers (but I think there will be at least few
in this case) they would like to have this be split on a per-driver
basis.
I counted 17 patches. I would split.

Since many of them are independent you may send without Cc'ing all
non-relevant people in each case.

>  arch/powerpc/platforms/pasemi/dma_lib.c |  4 ++--
>  arch/s390/kvm/kvm-s390.c                |  2 +-
>  drivers/block/rnbd/rnbd-clt.c           |  2 +-
>  drivers/dma/ti/edma.c                   |  2 +-
>  drivers/iio/adc/ad7124.c                |  2 +-
>  drivers/infiniband/hw/irdma/hw.c        | 16 ++++++++--------
>  drivers/media/cec/core/cec-core.c       |  2 +-
>  drivers/media/mc/mc-devnode.c           |  2 +-
>  drivers/pci/controller/dwc/pci-dra7xx.c |  2 +-
>  drivers/scsi/lpfc/lpfc_sli.c            | 10 +++++-----
>  drivers/soc/ti/k3-ringacc.c             |  4 ++--
>  drivers/tty/n_tty.c                     |  2 +-
>  drivers/virt/acrn/ioreq.c               |  3 +--
>  fs/f2fs/segment.c                       |  8 ++++----
>  fs/ocfs2/cluster/heartbeat.c            |  2 +-
>  fs/ocfs2/dlm/dlmdomain.c                |  4 ++--
>  fs/ocfs2/dlm/dlmmaster.c                | 18 +++++++++---------
>  fs/ocfs2/dlm/dlmrecovery.c              |  2 +-
>  fs/ocfs2/dlm/dlmthread.c                |  2 +-
>  lib/genalloc.c                          |  2 +-
>  net/ncsi/ncsi-manage.c                  |  4 ++--
>  21 files changed, 47 insertions(+), 48 deletions(-)


-- 
With Best Regards,
Andy Shevchenko
