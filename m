Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B71EA15DB9
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2019 08:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEGGtq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 May 2019 02:49:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37879 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfEGGtp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 May 2019 02:49:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so231509qkk.4;
        Mon, 06 May 2019 23:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pa7Box1aR7yFtR1LX1WDnV3kRpU7SqZCsbjs49Q3I5I=;
        b=MbpgTNQuafLtAS2Dly735CRfwi2rTUQf2u2v4oGvQgQgSYIdnRpg7VCLomPpMzIscG
         QaTnC9SQ9ku6gzFOzq1s9XrRaJmYor/1LFKrkhizBLNXIXufH7ZYafVfUTi/hxmPPuHk
         B/SkK/YRJGmYzfaQ1xghtxinwaerdxpRKizUfkuezccasVKNLUKgHxlEEtCQzs7jj3xl
         zQkJPXfNNvA3TqInSISCOxmMnYUjkdAFYUZlvI0ouvwsL+dfg4OFY2WIgIiVzRvRisWc
         5DS8N2wLUkGet8qbU+i0bfGDKHxX5peC2gXK9w9E6zQg9z2uNJlAWgMxSlSz/L/CQjSl
         IVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pa7Box1aR7yFtR1LX1WDnV3kRpU7SqZCsbjs49Q3I5I=;
        b=dgpuLZ7Sxs70cd6gfm8S4JBhVsVHVCaxSQnsxQQbHLpj6sAyMOkbFdtkrrSh363qfE
         SqKVi9BdHAPY+jdqIYwfM+6MAdjZz00uLaaCpylF3GpKSEGAiHaxTGM4nO4YMYIMMZYX
         DDcYvhLJIfAbKwcnPFP0IcuDMGIAdy6UmHchuR1nEZapUUk8AfNsiB/gP1OcVGO+6a9/
         I2we6KVblntwp0ZXsHsiiuv96qRZqTiGYXhYmzsvr7rT+WMMzUY6zTAXX0d5UHNHoGvz
         66dGNXxIT7n127CaN7edP7HtnYQtnLd1o1+WPrDJgEPehN0fkOdA2jCddlpVeHvdIfSQ
         24kw==
X-Gm-Message-State: APjAAAVM93RuASodQymRZFilQ/dHOFT8eFhzpoCfqwDwp4+Gx8hCbR2o
        qpJxz6jk056gefIIni33AnTcemXyaltduTXD2HI=
X-Google-Smtp-Source: APXvYqzuoQEtPiGnZXwYeWTvh/tWnA2kNb3EmE2Gn3p8SIpj/ShNUcDydJeqXgxDTOHN1axGtXmE2eyXjqUTKs09l0U=
X-Received: by 2002:a05:620a:1012:: with SMTP id z18mr1671111qkj.205.1557211784520;
 Mon, 06 May 2019 23:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com> <1556810922-20248-10-git-send-email-rppt@linux.ibm.com>
In-Reply-To: <1556810922-20248-10-git-send-email-rppt@linux.ibm.com>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 7 May 2019 14:49:08 +0800
Message-ID: <CAEbi=3d=HN0NagdZRu7qYE1KCWGnnGGwyhWKPp31XbzT7JunBQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] nds32: switch to generic version of pte allocation
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>, x86@kernel.org,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        nios2-dev@lists.rocketboards.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

Mike Rapoport <rppt@linux.ibm.com> =E6=96=BC 2019=E5=B9=B45=E6=9C=882=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:30=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The nds32 implementation of pte_alloc_one_kernel() differs from the gener=
ic
> in the use of __GFP_RETRY_MAYFAIL flag, which is removed after the
> conversion.
>
> The nds32 version of pte_alloc_one() missed the call to pgtable_page_ctor=
()
> and also used __GFP_RETRY_MAYFAIL. Switching it to use generic
> __pte_alloc_one() for the PTE page allocation ensures that page table
> constructor is run and the user page tables are allocated with
> __GFP_ACCOUNT.
>
> The conversion to the generic version of pte_free_kernel() removes the NU=
LL
> check for pte.
>
> The pte_free() version on nds32 is identical to the generic one and can b=
e
> simply dropped.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/nds32/include/asm/pgalloc.h | 31 ++++---------------------------
>  1 file changed, 4 insertions(+), 27 deletions(-)

Thanks for your patch.
I'm assuming this is going in along with the rest of the patches, so I'm no=
t
going to add it to my tree.

Acked-by: Greentime Hu <greentime@andestech.com>
