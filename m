Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABE6C722D
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 22:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCWVMu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 17:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCWVMt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 17:12:49 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460DF2597B;
        Thu, 23 Mar 2023 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=EWwVIz5hLvBmT6Tz5cl4jST1aXNmll6pvQLb1c2drjk=; b=CLNJ7YLSLaPjyJTvgUAwcXTSmH
        8gwTOo7bDshYvYEvTb92eayZOBGcWwgu/k6cDJauBDofvMB2BjFh6+KJ6NaLs042xBqiuT0pxaLgb
        v4pjf/Ilr0m0SpPFr7dTqyZFr3FbhelSHsHJ2Zy07THiN40wFBoPvfVUtmNuId33M0NN3d3vSI9wl
        /KbslUVNgGQRdcf01DO0WxM/Uzo+t02XjB2KNAOPUIxP3qUr+gc3cPm++57DK3bTddS0UUzn4vKj6
        S1DK2IAblz+eElWSSC/7KYdAw6rAYUAwr6HGMNhqdynQPDH8T4qE5Zldwa01UZKs/GJlpTxTC2jhZ
        fyUNs6Tg==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1pfSEB-003QpI-Kh; Thu, 23 Mar 2023 22:12:07 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1pfSEB-00EeXf-0F;
        Thu, 23 Mar 2023 22:12:07 +0100
Date:   Thu, 23 Mar 2023 22:12:07 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove special treatment for the link order of
 head.o
Message-ID: <ZBzAp457rrO52FPy@aurel32.net>
Mail-Followup-To: Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
References: <20221012233500.156764-1-masahiroy@kernel.org>
 <ZBovCrMXJk7NPISp@aurel32.net>
 <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 2023-03-22 15:51, Ard Biesheuvel wrote:
> On Tue, 21 Mar 2023 at 23:26, Aurelien Jarno <aurelien@aurel32.net> wrote:
> >
> > Hi,
> >
> > On 2022-10-13 08:35, Masahiro Yamada wrote:
> > > In the previous discussion (see the Link tag), Ard pointed out that
> > > arm/arm64/kernel/head.o does not need any special treatment - the only
> > > piece that must appear right at the start of the binary image is the
> > > image header which is emitted into .head.text.
> > >
> > > The linker script does the right thing to do. The build system does
> > > not need to manipulate the link order of head.o.
> > >
> > > Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com/
> > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/head-object-list.txt | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> > > index b16326a92c45..f226e45e3b7b 100644
> > > --- a/scripts/head-object-list.txt
> > > +++ b/scripts/head-object-list.txt
> > > @@ -15,7 +15,6 @@ arch/alpha/kernel/head.o
> > >  arch/arc/kernel/head.o
> > >  arch/arm/kernel/head-nommu.o
> > >  arch/arm/kernel/head.o
> > > -arch/arm64/kernel/head.o
> > >  arch/csky/kernel/head.o
> > >  arch/hexagon/kernel/head.o
> > >  arch/ia64/kernel/head.o
> >
> > This patch causes a significant increase of the arch/arm64/boot/Image
> > size. For instance the generic arm64 Debian kernel went from 31 to 39 MB
> > after this patch has been applied to the 6.1 stable tree.
> >
> > In turn this causes issues with some bootloaders, for instance U-Boot on
> > a Raspberry Pi limits the kernel size to 36 MB.
> >
> 
> I cannot reproduce this with mainline
> 
> With the patch
> 
> $ size vmlinux
>    text    data     bss     dec     hex filename
> 24567309 14752630 621680 39941619 26175f3 vmlinux
> 
> With the patch reverted
> 
> $ size vmlinux
>    text    data     bss     dec     hex filename
> 24567309 14752694 621680 39941683 2617633 vmlinux

I have tried with the current mainline, this is what I get, using GCC 12.2.0
and binutils 2.40:

   text    data     bss     dec     hex filename
32531655        8192996  621968 41346619        276e63b vmlinux.orig
25170610        8192996  621968 33985574        2069426 vmlinux.revert

> It would help to compare the resulting vmlinux ELF images from both
> builds to see where the extra space is being allocated

At a first glance, it seems the extra space is allocated in the BTF
section. I have uploaded the resulting files as well as the config file
I used there:
https://temp.aurel32.net/linux-arm64-size-head.o.tar.gz

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
