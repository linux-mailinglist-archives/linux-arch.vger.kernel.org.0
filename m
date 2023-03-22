Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784286C4E92
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCVOxz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 10:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCVOxk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 10:53:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DC7A5C2;
        Wed, 22 Mar 2023 07:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14328B81D12;
        Wed, 22 Mar 2023 14:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79CCC433EF;
        Wed, 22 Mar 2023 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496725;
        bh=Anc3h/ob8bGNXsYwROqEqoe0uiyD6BcePglSRs5RQmw=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=nbCI+ZVflki5cD04n7kS3qOmEgfaTEZcYYUnejFnPqhp8X4dv4lTlmVqRiUEwFMZC
         OgToC9onrhDZJJh7cB9TiQvSiUlcxRjyIEZ/Ys8jzCkmHMMEf6yJ4mtHOV/e2J3qad
         lL2MvLwk7d9HG6erqoDiBUcUHU1acRS3amW3lKFHuF32Msq4kq1eyC1OkYXHylDaCP
         KFzltMLV3ThpucUcQvHIDd4znWDRWZlXLvBy7TTuzsu6MERTztNXeVKLadIOWBPaEt
         Oz2hPPdwhT+WKG4acdI+bxPbhkWH2rw8dZic6Qxe2rONhAbowtnfzacoui520xBWpa
         4j8bsEAOzYI3A==
Received: by mail-lj1-f179.google.com with SMTP id e11so10597600lji.8;
        Wed, 22 Mar 2023 07:52:05 -0700 (PDT)
X-Gm-Message-State: AO0yUKUc1fqUy3Q9ydwwEFc0kGbHjaS9nXvktI3vTUeEShmSasi26inq
        ADsd4BLK8JT59B22OoPNfEmWr7xkFcvAXEyfYs0=
X-Google-Smtp-Source: AK7set97dkgt+LAR/pDeF0mhD2Ie4KDLa5HL0PqhcYNv+mZ40ijtxUuamxsLb4P/y4qgDR2i4cXuLoW8ZTdOpoDxnHU=
X-Received: by 2002:a2e:9d4d:0:b0:29e:7cae:fc19 with SMTP id
 y13-20020a2e9d4d000000b0029e7caefc19mr2052920ljj.2.1679496723712; Wed, 22 Mar
 2023 07:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221012233500.156764-1-masahiroy@kernel.org> <ZBovCrMXJk7NPISp@aurel32.net>
In-Reply-To: <ZBovCrMXJk7NPISp@aurel32.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 22 Mar 2023 15:51:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
Message-ID: <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
Subject: Re: [PATCH] arm64: remove special treatment for the link order of head.o
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 21 Mar 2023 at 23:26, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi,
>
> On 2022-10-13 08:35, Masahiro Yamada wrote:
> > In the previous discussion (see the Link tag), Ard pointed out that
> > arm/arm64/kernel/head.o does not need any special treatment - the only
> > piece that must appear right at the start of the binary image is the
> > image header which is emitted into .head.text.
> >
> > The linker script does the right thing to do. The build system does
> > not need to manipulate the link order of head.o.
> >
> > Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com/
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/head-object-list.txt | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> > index b16326a92c45..f226e45e3b7b 100644
> > --- a/scripts/head-object-list.txt
> > +++ b/scripts/head-object-list.txt
> > @@ -15,7 +15,6 @@ arch/alpha/kernel/head.o
> >  arch/arc/kernel/head.o
> >  arch/arm/kernel/head-nommu.o
> >  arch/arm/kernel/head.o
> > -arch/arm64/kernel/head.o
> >  arch/csky/kernel/head.o
> >  arch/hexagon/kernel/head.o
> >  arch/ia64/kernel/head.o
>
> This patch causes a significant increase of the arch/arm64/boot/Image
> size. For instance the generic arm64 Debian kernel went from 31 to 39 MB
> after this patch has been applied to the 6.1 stable tree.
>
> In turn this causes issues with some bootloaders, for instance U-Boot on
> a Raspberry Pi limits the kernel size to 36 MB.
>

I cannot reproduce this with mainline

With the patch

$ size vmlinux
   text    data     bss     dec     hex filename
24567309 14752630 621680 39941619 26175f3 vmlinux

With the patch reverted

$ size vmlinux
   text    data     bss     dec     hex filename
24567309 14752694 621680 39941683 2617633 vmlinux

It would help to compare the resulting vmlinux ELF images from both
builds to see where the extra space is being allocated
