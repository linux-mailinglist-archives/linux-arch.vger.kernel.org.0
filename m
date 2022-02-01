Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606AA4A5DC2
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 14:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbiBAN4a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 08:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiBAN4a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 08:56:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38859C061714;
        Tue,  1 Feb 2022 05:56:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA127615A4;
        Tue,  1 Feb 2022 13:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3740BC340F1;
        Tue,  1 Feb 2022 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643723789;
        bh=LR7K+KdhE8ua4Hf11bODf1Ipe6bgjP3NN3+/HtimckQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nULUMuvXkvrb2wx3h/E78ZWoev9tF1+n30y0uhd+VeL4suK4h/7PaBEhJdpbFimhZ
         eHq0ecvW4j9hpvDyoZLt082QO0YUiD4dzL5ypbtytbtJmn7imennsvXbabeHBBV/vB
         3HyaukGCDLsTs1HAwDF19bw+hwSBPkKz7r7PU1bCJuZxl9sFSOqZpTujWPyNpJr7z4
         SFGJYyGAlUcLKGJpL5WZ8M8ewKFW2/+hdSvUvDhleXoVNOU8+wdKNUvmjZ2EJo/7jc
         bNeohXIAvk6tn7PJhPBZ216d3Y87XjTjr7gYe/BUWcPiFfGHoxZ/8lWDlggv7ZX8Fr
         9cFvpFMp+gkng==
Received: by mail-vs1-f44.google.com with SMTP id b2so16136939vso.9;
        Tue, 01 Feb 2022 05:56:29 -0800 (PST)
X-Gm-Message-State: AOAM5320OuW4erpetgXY7I38Qp4zTYSVAbhpt+sR2xYAgcyg4qU+ClLG
        McfiarT8+gsCVQBnD02mClp+zngJ/0zFGlwRFkw=
X-Google-Smtp-Source: ABdhPJySe8D0nEEAYvBRzFy6LwfvSeR3L3Y/oGIyxpX/nRoUeaoc3ecWWnv60QtmaYC3C4Lb9VuYZme6+tyqFZXZr7A=
X-Received: by 2002:a67:f94e:: with SMTP id u14mr10667024vsq.2.1643723788142;
 Tue, 01 Feb 2022 05:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-17-guoren@kernel.org>
 <YffVZZg9GNcjgVdm@infradead.org> <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
 <20220201074457.GC29119@lst.de> <CAJF2gTTc=zwD__zXwYbO8vmup5evWJtzyiAF9Pm-UVHLJRc5hQ@mail.gmail.com>
 <CAK8P3a2C7nDGQvopYzi1fe_LWyosp8t9dcBsduYK5k_s_OrCaA@mail.gmail.com>
 <CAJF2gTTgTzvGfa3nGzVo4C=fe+ZCGBWp=VhTMRt1vF1O1bnS5g@mail.gmail.com> <CAK8P3a3u8zo+MOOpDXaX8PY2ukN3J2VHnV8uDXQwc=0WgV6qFw@mail.gmail.com>
In-Reply-To: <CAK8P3a3u8zo+MOOpDXaX8PY2ukN3J2VHnV8uDXQwc=0WgV6qFw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Feb 2022 21:56:17 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTtCboaEdC1MXkONUr1Nc6BcM4xM5tdE9t6_PiSdiGHLg@mail.gmail.com>
Message-ID: <CAJF2gTTtCboaEdC1MXkONUr1Nc6BcM4xM5tdE9t6_PiSdiGHLg@mail.gmail.com>
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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

On Tue, Feb 1, 2022 at 7:48 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 1, 2022 at 11:26 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > Hi Arnd & Christoph,
> >
> > The UXL field controls the value of XLEN for U-mode, termed UXLEN,
> > which may differ from the
> > value of XLEN for S-mode, termed SXLEN. The encoding of UXL is the
> > same as that of the MXL
> > field of misa, shown in Table 3.1.
> >
> > Here is the patch. (We needn't exception helper, because we are in
> > S-mode and UXL wouldn't affect.)
>
> Looks good to me, just a few details that could be improved
>
> > -#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
> > +#ifdef CONFIG_COMPAT
> > +#define compat_elf_check_arch compat_elf_check_arch
> > +extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
> > +#endif
>
> No need for the #ifdef
Okay

> > +}
>
> > +void compat_mode_detect(void)
>
> __init
Okay

>
> > +{
> > + unsigned long tmp = csr_read(CSR_STATUS);
> > + csr_write(CSR_STATUS, (tmp & ~SR_UXL) | SR_UXL_32);
> > +
> > + if ((csr_read(CSR_STATUS) & SR_UXL) != SR_UXL_32) {
> > + csr_write(CSR_STATUS, tmp);
> > + return;
> > + }
> > +
> > + csr_write(CSR_STATUS, tmp);
> > + compat_mode_support = true;
> > +
> > + pr_info("riscv: compat: 32bit U-mode applications support\n");
> > +}
>
> I think an entry in /proc/cpuinfo would be more helpful than the pr_info at
> boot time. Maybe a follow-up patch though, as there is no obvious place
> to put it. On other architectures, you typically have a set of space
> separated feature names, but riscv has a single string that describes
> the ISA, and this feature is technically the support for a second ISA.
Yes, it should be another patch after discussion.

>
>          Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
