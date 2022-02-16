Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDCB4B937D
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiBPWDU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 17:03:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBPWDS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 17:03:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B7136869;
        Wed, 16 Feb 2022 14:03:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2896DB81EE6;
        Wed, 16 Feb 2022 22:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A0CC340E8;
        Wed, 16 Feb 2022 22:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645048982;
        bh=ay/5589FenTcDxawo4c9r5D5w/FgYtE3zMvoHKiKBw4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mp2N4j25K83NMCfLyY4s4Fvr/02r2is80WsbciAWUvDE4/m4hXq9EgLORcancLhbT
         umY9FHnexAjN//UsA7q/C9fckLYXF0oQ8KHvfjTR59rKGClK+gPz3WGNFPqYUuSPAl
         tKqmRElhXMvcu84IyYLNk1Jx9OrqFY1VeIjfZrMgYnNZnH7Q43IubRg0WPfzhGBBBX
         /OdSxH8IZ7Kz0nHhQxDWelZPRHLPHQFw8aTJU8Fd/gQNcc2Tz29BgNtd0/VTT0Eadn
         af5BPEGJl881/LlmZF1PoTMkEDGEvxPy+W0AvrAYWFrqce134uQiJLaLzOGaZJOGGy
         d7XYuXjZgGD6w==
Received: by mail-wr1-f47.google.com with SMTP id o24so5675140wro.3;
        Wed, 16 Feb 2022 14:03:02 -0800 (PST)
X-Gm-Message-State: AOAM531iRFG/S6RMolu6glgbZgQ34WWjreN+sPxTsBsT3SlMlPs/xg8W
        0B2qsbUQ0jDCWxZfe2Kq4IwiFj1ajZ1vsFML+mY=
X-Google-Smtp-Source: ABdhPJyk0zQXj5EZ1uP9z1YUTizioO4kJ6rvneTTyuZji8J8rGr64s8uMSDVOcQeT3f3UOdAxVtCGFpnKRwe/RHh9ys=
X-Received: by 2002:adf:cf0c:0:b0:1e6:22fe:4580 with SMTP id
 o12-20020adfcf0c000000b001e622fe4580mr53483wrj.12.1645048981311; Wed, 16 Feb
 2022 14:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-19-arnd@kernel.org>
 <Yg1F/VT4vRX4aHEt@ravnborg.org>
In-Reply-To: <Yg1F/VT4vRX4aHEt@ravnborg.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 16 Feb 2022 23:02:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2gx2w=RDECNbrO4Zu3ZUTfz2UrLbNSz+ieCgMEFiK3TA@mail.gmail.com>
Message-ID: <CAK8P3a2gx2w=RDECNbrO4Zu3ZUTfz2UrLbNSz+ieCgMEFiK3TA@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 16, 2022 at 7:44 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Arnd,
>
> Fix spelling in $subject...

done

> sparc/Kconfig b/arch/sparc/Kconfig
> > index 9f6f9bce5292..9276f321b3e3 100644
> > --- a/arch/sparc/Kconfig
> > +++ b/arch/sparc/Kconfig
> > @@ -46,7 +46,6 @@ config SPARC
> >       select LOCKDEP_SMALL if LOCKDEP
> >       select NEED_DMA_MAP_STATE
> >       select NEED_SG_DMA_LENGTH
> > -     select SET_FS
> >       select TRACE_IRQFLAGS_SUPPORT
> >
> >  config SPARC32
> > @@ -101,6 +100,7 @@ config SPARC64
> >       select HAVE_SETUP_PER_CPU_AREA
> >       select NEED_PER_CPU_EMBED_FIRST_CHUNK
> >       select NEED_PER_CPU_PAGE_FIRST_CHUNK
> > +     select SET_FS
> This looks wrong - looks like some merge went wrong here.

Fixed now.

>
> Other than the above the sparc32 changes looks fine, and with the Kconf
> stuff fixed:
> Acked-by: Sam Ravnborg <sam@ravnborg.org> # for sparc32 changes

Thanks!

      Arnd
