Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF446C7D3C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 12:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCXLeA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 07:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXLd7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 07:33:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D306B1C7FB;
        Fri, 24 Mar 2023 04:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83EE2B8239C;
        Fri, 24 Mar 2023 11:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F2BC4339B;
        Fri, 24 Mar 2023 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679657634;
        bh=gN1rw7P5nD0EPnar+Hih8wRjO2zp+3Y1UdQYfZsCqBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oKBFZiTSugNI6NXoGDFM/eBf78cVT9COzfU+bK3uSgOS53e3/8uY8Lu7lDAbjrduk
         f+o8I4IP6BYkZGnxLmFm4qVfvm7dJSJkandF8nEHZh/DaIWiYRlpfG6z0ULmtwPtIg
         nDHS6FGdnDYwICHFy4dxqwAXliGTH64w++/LYtza0OHzdJky1GlEg3mil1o4aW6rbz
         Si9H/Df8j+pf7qs8sOV622rw/SqwGlYi73awC5Nv4oZBD90kbgTPSq3JXLOam8tfXA
         kH7kbVtZ3aljmfG69UC5diNO8GcTecvllVT+g4KIePYuMC3aOG6ac2SfijvN6YPeoE
         ncSzwNoANakxg==
Received: by mail-lf1-f44.google.com with SMTP id br6so1810469lfb.11;
        Fri, 24 Mar 2023 04:33:54 -0700 (PDT)
X-Gm-Message-State: AAQBX9dTve0JONSYQmUyJyR56PQSmIso5wytq8LDFdP8iNPZ96Yw35Qh
        s3AdWz0odaJVclBtzsyALS+Q8HQVkfStO+11k8c=
X-Google-Smtp-Source: AKy350b8q3+lUeJ9w5ZT9GW50L8qAY6bqdL3UY0CHDzs4u9bAT5b8qVWBbNxvRz6Pby8JiJnvjS/qp42bIAdEGY9RWU=
X-Received: by 2002:ac2:4a89:0:b0:4ea:12f7:a725 with SMTP id
 l9-20020ac24a89000000b004ea12f7a725mr650882lfp.4.1679657632209; Fri, 24 Mar
 2023 04:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221012233500.156764-1-masahiroy@kernel.org> <ZBovCrMXJk7NPISp@aurel32.net>
 <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com> <ZBzAp457rrO52FPy@aurel32.net>
In-Reply-To: <ZBzAp457rrO52FPy@aurel32.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Mar 2023 12:33:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
Message-ID: <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
Subject: Re: [PATCH] arm64: remove special treatment for the link order of head.o
To:     Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(cc BTF list and maintainer)

On Thu, 23 Mar 2023 at 22:12, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi,
>
> On 2023-03-22 15:51, Ard Biesheuvel wrote:
> > On Tue, 21 Mar 2023 at 23:26, Aurelien Jarno <aurelien@aurel32.net> wrote:
> > >
> > > Hi,
> > >
> > > On 2022-10-13 08:35, Masahiro Yamada wrote:
> > > > In the previous discussion (see the Link tag), Ard pointed out that
> > > > arm/arm64/kernel/head.o does not need any special treatment - the only
> > > > piece that must appear right at the start of the binary image is the
> > > > image header which is emitted into .head.text.
> > > >
> > > > The linker script does the right thing to do. The build system does
> > > > not need to manipulate the link order of head.o.
> > > >
> > > > Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=1F8Uy-uAWGVDm4-CG=EuA@mail.gmail.com/
> > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > > >
> > > >  scripts/head-object-list.txt | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> > > > index b16326a92c45..f226e45e3b7b 100644
> > > > --- a/scripts/head-object-list.txt
> > > > +++ b/scripts/head-object-list.txt
> > > > @@ -15,7 +15,6 @@ arch/alpha/kernel/head.o
> > > >  arch/arc/kernel/head.o
> > > >  arch/arm/kernel/head-nommu.o
> > > >  arch/arm/kernel/head.o
> > > > -arch/arm64/kernel/head.o
> > > >  arch/csky/kernel/head.o
> > > >  arch/hexagon/kernel/head.o
> > > >  arch/ia64/kernel/head.o
> > >
> > > This patch causes a significant increase of the arch/arm64/boot/Image
> > > size. For instance the generic arm64 Debian kernel went from 31 to 39 MB
> > > after this patch has been applied to the 6.1 stable tree.
> > >
> > > In turn this causes issues with some bootloaders, for instance U-Boot on
> > > a Raspberry Pi limits the kernel size to 36 MB.
> > >
> >
> > I cannot reproduce this with mainline
> >
> > With the patch
> >
> > $ size vmlinux
> >    text    data     bss     dec     hex filename
> > 24567309 14752630 621680 39941619 26175f3 vmlinux
> >
> > With the patch reverted
> >
> > $ size vmlinux
> >    text    data     bss     dec     hex filename
> > 24567309 14752694 621680 39941683 2617633 vmlinux
>
> I have tried with the current mainline, this is what I get, using GCC 12.2.0
> and binutils 2.40:
>
>    text    data     bss     dec     hex filename
> 32531655        8192996  621968 41346619        276e63b vmlinux.orig
> 25170610        8192996  621968 33985574        2069426 vmlinux.revert
>
> > It would help to compare the resulting vmlinux ELF images from both
> > builds to see where the extra space is being allocated
>
> At a first glance, it seems the extra space is allocated in the BTF
> section. I have uploaded the resulting files as well as the config file
> I used there:
> https://temp.aurel32.net/linux-arm64-size-head.o.tar.gz
>

Indeed. So we go from

  [15] .BTF              PROGBITS         ffff8000091d1ff4  011e1ff4
       00000000005093d6  0000000000000000   A       0     0     1

to

  [15] .BTF              PROGBITS         ffff8000091d1ff4  011e1ff4
       0000000000c0e5eb  0000000000000000   A       0     0     1

i.e, from 5 MiB to 12+ MiB of BTF metadata.

To me, it is not clear at all how one would be related to the other,
so it will leave it to the Kbuild and BTF experts to chew on this one.
