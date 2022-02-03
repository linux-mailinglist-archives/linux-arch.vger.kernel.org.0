Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111DD4A7E0E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 03:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiBCCoP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Feb 2022 21:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiBCCoP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Feb 2022 21:44:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D64C061714;
        Wed,  2 Feb 2022 18:44:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C649B8330A;
        Thu,  3 Feb 2022 02:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C42C340F6;
        Thu,  3 Feb 2022 02:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643856252;
        bh=V51eVJiRBfBtAiPpggOpCZR3uh94Yz/dWJnManIUqRA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IfifaL/YvkQeOydK0cgYgy7MaOnD1ofDN9TZ9U0AAgJgX5vkoOM/UCN+eqFDFX8e0
         SIROG24sqmSXhudRlXA3k1jWkp77oSEpy958cVODa3+sWBKJFg5/KfQgGGdSVjxxIs
         tBS1ttU+VD/lfGZc6laeZXX3nMQbkvJraFwXMBoSDxQnFXqyuk7KNTCbNzoNPaUxXu
         obu4PEKMkaRLF0VBJAceVG1kvUSawTvpCDv+XjctdvSnwyZA7NM+d+opMx9qUChsMA
         QIiebpV47EWTVL21TA8YNmrdIhNU6Tt7q6oAVfTnyRCqH7wGOKGMQC/DtV00pJqZ7Z
         uKgAZRx6fuHVA==
Received: by mail-ua1-f50.google.com with SMTP id c36so2662895uae.13;
        Wed, 02 Feb 2022 18:44:12 -0800 (PST)
X-Gm-Message-State: AOAM530dWv5SezYpodmaWPAG61rIo/wPi4mSgGXb9lJmfM4pQkN5nm73
        CuR79aC0qdVj+NkLKFBif1wZQiqTkPcUAvLObO4=
X-Google-Smtp-Source: ABdhPJwcymlbtGZh6tQbwNbq4eIqK1FMhWR2Ntg5Vpt7lVSBlW8sS85pNzZxGeDyQITxXLpJvbICejijlor03wlRbBs=
X-Received: by 2002:ab0:2092:: with SMTP id r18mr12760634uak.66.1643856251122;
 Wed, 02 Feb 2022 18:44:11 -0800 (PST)
MIME-Version: 1.0
References: <20220201150545.1512822-1-guoren@kernel.org> <20220201150545.1512822-16-guoren@kernel.org>
 <20220202075159.GB18398@lst.de>
In-Reply-To: <20220202075159.GB18398@lst.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 3 Feb 2022 10:44:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTxzFo1kdkCDH=2RKkQ1gEzOnUCjxotcsjrqivG4qg-Dw@mail.gmail.com>
Message-ID: <CAJF2gTTxzFo1kdkCDH=2RKkQ1gEzOnUCjxotcsjrqivG4qg-Dw@mail.gmail.com>
Subject: Re: [PATCH V5 15/21] riscv: compat: Add hw capability check for elf
To:     Christoph Hellwig <hch@lst.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 2, 2022 at 3:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 01, 2022 at 11:05:39PM +0800, guoren@kernel.org wrote:
> > +bool compat_elf_check_arch(Elf32_Ehdr *hdr)
> > +{
> > +     if (compat_mode_support && (hdr->e_machine == EM_RISCV))
> > +             return true;
> > +     else
> > +             return false;
> > +}
>
> This can be simplified to:
>
>         return compat_mode_support && hdr->e_machine == EM_RISCV;
Good point.

>
> I'd also rename compat_mode_support to compat_mode_supported
Okay

>
> > +
> > +static int compat_mode_detect(void)
> > +{
> > +     unsigned long tmp = csr_read(CSR_STATUS);
> > +
> > +     csr_write(CSR_STATUS, (tmp & ~SR_UXL) | SR_UXL_32);
> > +
> > +     if ((csr_read(CSR_STATUS) & SR_UXL) != SR_UXL_32) {
> > +             pr_info("riscv: 32bit compat mode detect failed\n");
> > +             compat_mode_support = false;
> > +     } else {
> > +             compat_mode_support = true;
> > +             pr_info("riscv: 32bit compat mode detected\n");
> > +     }
>
> I don't think we need these printks here.
Okay

>
> Also this could be simplified to:
>
>         compat_mode_supported = (csr_read(CSR_STATUS) & SR_UXL) == SR_UXL_32;
Okay



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
