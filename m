Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F749325B3B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Feb 2021 02:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhBZBXm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 20:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhBZBX2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Feb 2021 20:23:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4D1064F45;
        Fri, 26 Feb 2021 01:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614302551;
        bh=HKX2d7C6FRZHn9ETku+sUdTRgdroLQqoA0etpo+dwBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U2sO2J6JF1MUgIXAcq1Lz72GXALx0CQ7HznOPsGNzc8F/fcyG1vlioVlozXnUMr/Q
         6YIpfndzcyK7FYdLUoo2oxvjN2wARU6j7vTDskczmnHvuRNZi9uwV1o8KNFF3m4DT/
         blrXpgU16LTWFbQzHeGDVnE2HOl+P9dbMywYJkFWcfB24346o6KJDUQjfgtLveXd6I
         98f4oMeBFoFXtHz6v0tDon1WP9E0T25B4Ym02TanpmTdhVMnalCJCfimXbRgybheEw
         UeApeuE0O+UGmjPzdJDGSjOjOP4Ib5z6TGEjMmggDkTVL2iDRxdjP2KTDNYqwi8Q/U
         TG5ovIb5a0PFg==
Received: by mail-il1-f178.google.com with SMTP id h18so6688146ils.2;
        Thu, 25 Feb 2021 17:22:30 -0800 (PST)
X-Gm-Message-State: AOAM531oDQpNzZyGqMf0DMpedTEAD825HDrOC0s2uQdphMTiAygavgVr
        iSPMMwemldPIpsKvqcb2+6oehZCFqFuWrYyfm3s=
X-Google-Smtp-Source: ABdhPJzmjvZUK1uhuLLRpihzIDVcjVsCrrMQL6doJSqMkdQAKO9NRuDr+okow6Wiq/33s5CdTZSi6Z85sME0Iqpvygw=
X-Received: by 2002:a92:6907:: with SMTP id e7mr435462ilc.134.1614302550029;
 Thu, 25 Feb 2021 17:22:30 -0800 (PST)
MIME-Version: 1.0
References: <20210225135700.1381396-1-yury.norov@gmail.com> <20210225135700.1381396-3-yury.norov@gmail.com>
In-Reply-To: <20210225135700.1381396-3-yury.norov@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 26 Feb 2021 09:22:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Xt+1c_gCOpudzizurEbVXYonf_wWg9sTaCKWcONEL-Q@mail.gmail.com>
Message-ID: <CAAhV-H5Xt+1c_gCOpudzizurEbVXYonf_wWg9sTaCKWcONEL-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: enable GENERIC_FIND_FIRST_BIT
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Yury,

On Thu, Feb 25, 2021 at 9:59 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> From: Alexander Lobakin <alobakin@pm.me>
>
> MIPS doesn't have architecture-optimized bitsearching functions,
> like find_{first,next}_bit() etc.
Emm, I think MIPS can use clo/clz to optimize bitsearching functions.

Huacai

> It's absolutely harmless to enable GENERIC_FIND_FIRST_BIT as this
> functionality is not new at all and well-tested. It provides more
> optimized code and saves some .text memory (32 R2):
>
> add/remove: 4/1 grow/shrink: 1/53 up/down: 216/-372 (-156)
>
> Users of for_each_set_bit() like hotpath gic_handle_shared_int()
> will also benefit from this.
>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index d89efba3d8a4..164bdd715d4b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -26,6 +26,7 @@ config MIPS
>         select GENERIC_ATOMIC64 if !64BIT
>         select GENERIC_CMOS_UPDATE
>         select GENERIC_CPU_AUTOPROBE
> +       select GENERIC_FIND_FIRST_BIT
>         select GENERIC_GETTIMEOFDAY
>         select GENERIC_IOMAP
>         select GENERIC_IRQ_PROBE
> --
> 2.25.1
>
