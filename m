Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5296C8B39
	for <lists+linux-arch@lfdr.de>; Sat, 25 Mar 2023 07:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCYGGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Mar 2023 02:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCYGGK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2023 02:06:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A3F13DCF;
        Fri, 24 Mar 2023 23:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E22F608D6;
        Sat, 25 Mar 2023 06:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEA0C4339B;
        Sat, 25 Mar 2023 06:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679724368;
        bh=BCxAEBlwGFkw9Mfm0eOS9Vy5xcNAozgVMijfd4lHFIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iDyRwqHCF4uNBHnbWjh/OboD/2fIRpjNxWc3poq+1yMxR024Bci4DRGVfrIQbLwzE
         Xv1It2Ap3PqE+1jy5IGubvRffIQk+EPJOGr9X/Trl8Wu8VNagHtmQRbQhKa4tIfSpr
         2LKID0c3BzyJXdKtGBJBWfZY2moB1C3XD85cAYBhihfxUn1IjTOO65gZ6+l+cE9u2V
         7Dak+KMQhuWqP98Cw9hrOR86jXXu4NYQfpoBw12MiqZWAYI1nzB5W176DG7q6e32uk
         dc72S6SJ0UQtg2Z7oYwvjheGOBCeo591C5MoAshSJhNRPiST/6SV74NygxZbMme9qv
         hRQsf0DX061LQ==
Received: by mail-ot1-f41.google.com with SMTP id m20-20020a9d6094000000b0069caf591747so2008373otj.2;
        Fri, 24 Mar 2023 23:06:07 -0700 (PDT)
X-Gm-Message-State: AO0yUKVMDPwxFrqB3pwEtLczBNPbhtjxWY9PQSUVgysM4Oq3ZLeQN/8/
        AXPYqDJ3RGTfes81P07nBBbY/TAl7NpPr05Wjok=
X-Google-Smtp-Source: AK7set9LmUQYlR75y9+C4467lM8C4MZE69jAqqZd1f6f8o0izmcvjQUQobEmbcB8vfheeNSKtObx91JmtQdNSvNf/FA=
X-Received: by 2002:a9d:349:0:b0:69a:7f40:3fb9 with SMTP id
 67-20020a9d0349000000b0069a7f403fb9mr4764963otv.3.1679724367175; Fri, 24 Mar
 2023 23:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221012233500.156764-1-masahiroy@kernel.org> <ZBovCrMXJk7NPISp@aurel32.net>
 <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
 <ZBzAp457rrO52FPy@aurel32.net> <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
In-Reply-To: <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Mar 2023 15:05:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdsWMP2jud4niOkrR5+a2jG-Vfo0XEa63bh3L3W6_t0Q@mail.gmail.com>
Message-ID: <CAK7LNASdsWMP2jud4niOkrR5+a2jG-Vfo0XEa63bh3L3W6_t0Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: remove special treatment for the link order of head.o
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 8:33=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> (cc BTF list and maintainer)
>
> On Thu, 23 Mar 2023 at 22:12, Aurelien Jarno <aurelien@aurel32.net> wrote=
:
> >
> > Hi,
> >
> > On 2023-03-22 15:51, Ard Biesheuvel wrote:
> > > On Tue, 21 Mar 2023 at 23:26, Aurelien Jarno <aurelien@aurel32.net> w=
rote:
> > > >
> > > > Hi,
> > > >
> > > > On 2022-10-13 08:35, Masahiro Yamada wrote:
> > > > > In the previous discussion (see the Link tag), Ard pointed out th=
at
> > > > > arm/arm64/kernel/head.o does not need any special treatment - the=
 only
> > > > > piece that must appear right at the start of the binary image is =
the
> > > > > image header which is emitted into .head.text.
> > > > >
> > > > > The linker script does the right thing to do. The build system do=
es
> > > > > not need to manipulate the link order of head.o.
> > > > >
> > > > > Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZKw=
=3D1F8Uy-uAWGVDm4-CG=3DEuA@mail.gmail.com/
> > > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >
> > > > >  scripts/head-object-list.txt | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >
> > > > > diff --git a/scripts/head-object-list.txt b/scripts/head-object-l=
ist.txt
> > > > > index b16326a92c45..f226e45e3b7b 100644
> > > > > --- a/scripts/head-object-list.txt
> > > > > +++ b/scripts/head-object-list.txt
> > > > > @@ -15,7 +15,6 @@ arch/alpha/kernel/head.o
> > > > >  arch/arc/kernel/head.o
> > > > >  arch/arm/kernel/head-nommu.o
> > > > >  arch/arm/kernel/head.o
> > > > > -arch/arm64/kernel/head.o
> > > > >  arch/csky/kernel/head.o
> > > > >  arch/hexagon/kernel/head.o
> > > > >  arch/ia64/kernel/head.o
> > > >
> > > > This patch causes a significant increase of the arch/arm64/boot/Ima=
ge
> > > > size. For instance the generic arm64 Debian kernel went from 31 to =
39 MB
> > > > after this patch has been applied to the 6.1 stable tree.
> > > >
> > > > In turn this causes issues with some bootloaders, for instance U-Bo=
ot on
> > > > a Raspberry Pi limits the kernel size to 36 MB.
> > > >
> > >
> > > I cannot reproduce this with mainline
> > >
> > > With the patch
> > >
> > > $ size vmlinux
> > >    text    data     bss     dec     hex filename
> > > 24567309 14752630 621680 39941619 26175f3 vmlinux
> > >
> > > With the patch reverted
> > >
> > > $ size vmlinux
> > >    text    data     bss     dec     hex filename
> > > 24567309 14752694 621680 39941683 2617633 vmlinux
> >
> > I have tried with the current mainline, this is what I get, using GCC 1=
2.2.0
> > and binutils 2.40:
> >
> >    text    data     bss     dec     hex filename
> > 32531655        8192996  621968 41346619        276e63b vmlinux.orig
> > 25170610        8192996  621968 33985574        2069426 vmlinux.revert
> >
> > > It would help to compare the resulting vmlinux ELF images from both
> > > builds to see where the extra space is being allocated
> >
> > At a first glance, it seems the extra space is allocated in the BTF
> > section. I have uploaded the resulting files as well as the config file
> > I used there:
> > https://temp.aurel32.net/linux-arm64-size-head.o.tar.gz
> >
>
> Indeed. So we go from
>
>   [15] .BTF              PROGBITS         ffff8000091d1ff4  011e1ff4
>        00000000005093d6  0000000000000000   A       0     0     1
>
> to
>
>   [15] .BTF              PROGBITS         ffff8000091d1ff4  011e1ff4
>        0000000000c0e5eb  0000000000000000   A       0     0     1
>
> i.e, from 5 MiB to 12+ MiB of BTF metadata.
>
> To me, it is not clear at all how one would be related to the other,
> so it will leave it to the Kbuild and BTF experts to chew on this one.



Strange.

I used the .config file Aurelien provided, but
I still cannot reproduce this issue.


The vmlinux size is small
as-is in the current mainline.



[mainline]


masahiro@zoe:~/ref/linux(master)$ git log --oneline -1
65aca32efdcb (HEAD -> master, origin/master, origin/HEAD) Merge tag
'mm-hotfixes-stable-2023-03-24-17-09' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-size  vmlinux
   text    data     bss     dec     hex filename
24561282 8186912 622032 33370226 1fd3072 vmlinux
masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-readelf -S
vmlinux | grep -A1 BTF
  [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
       000000000048209c  0000000000000000   A       0     0     1
  [16] .BTF_ids          PROGBITS         ffff8000096427a4  016527a4
       0000000000000a1c  0000000000000000   A       0     0     1




[mainline + revert 994b7ac]

masahiro@zoe:~/ref/linux2(testing)$ git log --oneline -2
856c80dd789c (HEAD -> testing) Revert "arm64: remove special treatment
for the link order of head.o"
65aca32efdcb (origin/master, origin/HEAD, master) Merge tag
'mm-hotfixes-stable-2023-03-24-17-09' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-size  vmlinux
   text    data     bss     dec     hex filename
24561329 8186912 622032 33370273 1fd30a1 vmlinux
masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-readelf -S
vmlinux | grep -A1 BTF
  [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
       00000000004820cb  0000000000000000   A       0     0     1
  [16] .BTF_ids          PROGBITS         ffff8000096427d4  016527d4
       0000000000000a1c  0000000000000000   A       0     0     1



I still do not know what affects reproducibility.
(compiler version, pahole version, etc. ?)




Aurelien used GCC 12 + binutils 2.40, but
my toolchain is a bit older.



FWIW, I tested this on Ubuntu 22.04LTS.

masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-gcc --version
aarch64-linux-gnu-gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

masahiro@zoe:~/ref/linux(master)$ pahole --version
v1.22

masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-as --version
GNU assembler (GNU Binutils for Ubuntu) 2.38
Copyright (C) 2022 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License version 3 or later.
This program has absolutely no warranty.
This assembler was configured for a target of `aarch64-linux-gnu'.






--
Best Regards
Masahiro Yamada
