Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAD06C8D8A
	for <lists+linux-arch@lfdr.de>; Sat, 25 Mar 2023 12:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCYLmq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Mar 2023 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYLmq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2023 07:42:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A661540C9;
        Sat, 25 Mar 2023 04:42:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FE6760C3A;
        Sat, 25 Mar 2023 11:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA59C433D2;
        Sat, 25 Mar 2023 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679744563;
        bh=rnV8vhzu4re24iNDIq/2qMh6krx9j4K6r/K6LBYSd1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cU2SNM7Ob/fuo4CkAlaLBPTzSx/Q9Vdi32vE494pPOBjP0GQ5wgMtgDUbUN4k6smP
         14bixCzG77Grf19trudyFENlyYdPkz73nu3C3IvnAL2n1k6p99dkFICVJe7G6zjdmi
         ojSbVJUK2Vv9I7FcHb+9m5rF5SEMFbjX6UGLQXXu6EPWPelyi5dLC7ZGzs1rW+vbvo
         rfxVZ5O5uHHCqO8FREzOQjaRlrMnELi4va1U9ml27cUTQ5mXZqF16gWmW0P8JmPJ9Z
         UKs7787/i9/Xf9DMlXxQllkZtuAcahwiBxp+wW19bHo5/C1EfONzXinsrUGlOdqHwA
         brb+qB5SxUY0w==
Received: by mail-oi1-f175.google.com with SMTP id f17so3104196oiw.10;
        Sat, 25 Mar 2023 04:42:43 -0700 (PDT)
X-Gm-Message-State: AO0yUKWg8HJ1R3PHa6PoSlcUiihmz+xIHme+ilB0dS6o9bScnhkA3s6/
        nlfmpC6kLsL9c8ojSq0Ys4cfj4jKhpbLZmLsQmU=
X-Google-Smtp-Source: AK7set+GftPqKl51eP0hVJ8JeyHT8kMXKRZgx44rAso/ik0kS61bItFbwtMDQt8lpj14WMSyp80hI2PxKbQdflBSX14=
X-Received: by 2002:a05:6808:284:b0:384:33df:4dfc with SMTP id
 z4-20020a056808028400b0038433df4dfcmr1534567oic.11.1679744562739; Sat, 25 Mar
 2023 04:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20221012233500.156764-1-masahiroy@kernel.org> <ZBovCrMXJk7NPISp@aurel32.net>
 <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
 <ZBzAp457rrO52FPy@aurel32.net> <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
 <CAK7LNASdsWMP2jud4niOkrR5+a2jG-Vfo0XEa63bh3L3W6_t0Q@mail.gmail.com>
In-Reply-To: <CAK7LNASdsWMP2jud4niOkrR5+a2jG-Vfo0XEa63bh3L3W6_t0Q@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 25 Mar 2023 20:42:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUbyDV-kMi3fuihUdfnhtzHnk9wosQ0w-fuamDcT2ZBg@mail.gmail.com>
Message-ID: <CAK7LNASUbyDV-kMi3fuihUdfnhtzHnk9wosQ0w-fuamDcT2ZBg@mail.gmail.com>
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

On Sat, Mar 25, 2023 at 3:05=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Mar 24, 2023 at 8:33=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > (cc BTF list and maintainer)
> >
> > On Thu, 23 Mar 2023 at 22:12, Aurelien Jarno <aurelien@aurel32.net> wro=
te:
> > >
> > > Hi,
> > >
> > > On 2023-03-22 15:51, Ard Biesheuvel wrote:
> > > > On Tue, 21 Mar 2023 at 23:26, Aurelien Jarno <aurelien@aurel32.net>=
 wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On 2022-10-13 08:35, Masahiro Yamada wrote:
> > > > > > In the previous discussion (see the Link tag), Ard pointed out =
that
> > > > > > arm/arm64/kernel/head.o does not need any special treatment - t=
he only
> > > > > > piece that must appear right at the start of the binary image i=
s the
> > > > > > image header which is emitted into .head.text.
> > > > > >
> > > > > > The linker script does the right thing to do. The build system =
does
> > > > > > not need to manipulate the link order of head.o.
> > > > > >
> > > > > > Link: https://lore.kernel.org/lkml/CAMj1kXH77Ja8bSsq2Qj8Ck9iSZK=
w=3D1F8Uy-uAWGVDm4-CG=3DEuA@mail.gmail.com/
> > > > > > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > > ---
> > > > > >
> > > > > >  scripts/head-object-list.txt | 1 -
> > > > > >  1 file changed, 1 deletion(-)
> > > > > >
> > > > > > diff --git a/scripts/head-object-list.txt b/scripts/head-object=
-list.txt
> > > > > > index b16326a92c45..f226e45e3b7b 100644
> > > > > > --- a/scripts/head-object-list.txt
> > > > > > +++ b/scripts/head-object-list.txt
> > > > > > @@ -15,7 +15,6 @@ arch/alpha/kernel/head.o
> > > > > >  arch/arc/kernel/head.o
> > > > > >  arch/arm/kernel/head-nommu.o
> > > > > >  arch/arm/kernel/head.o
> > > > > > -arch/arm64/kernel/head.o
> > > > > >  arch/csky/kernel/head.o
> > > > > >  arch/hexagon/kernel/head.o
> > > > > >  arch/ia64/kernel/head.o
> > > > >
> > > > > This patch causes a significant increase of the arch/arm64/boot/I=
mage
> > > > > size. For instance the generic arm64 Debian kernel went from 31 t=
o 39 MB
> > > > > after this patch has been applied to the 6.1 stable tree.
> > > > >
> > > > > In turn this causes issues with some bootloaders, for instance U-=
Boot on
> > > > > a Raspberry Pi limits the kernel size to 36 MB.
> > > > >
> > > >
> > > > I cannot reproduce this with mainline
> > > >
> > > > With the patch
> > > >
> > > > $ size vmlinux
> > > >    text    data     bss     dec     hex filename
> > > > 24567309 14752630 621680 39941619 26175f3 vmlinux
> > > >
> > > > With the patch reverted
> > > >
> > > > $ size vmlinux
> > > >    text    data     bss     dec     hex filename
> > > > 24567309 14752694 621680 39941683 2617633 vmlinux
> > >
> > > I have tried with the current mainline, this is what I get, using GCC=
 12.2.0
> > > and binutils 2.40:
> > >
> > >    text    data     bss     dec     hex filename
> > > 32531655        8192996  621968 41346619        276e63b vmlinux.orig
> > > 25170610        8192996  621968 33985574        2069426 vmlinux.rever=
t
> > >
> > > > It would help to compare the resulting vmlinux ELF images from both
> > > > builds to see where the extra space is being allocated
> > >
> > > At a first glance, it seems the extra space is allocated in the BTF
> > > section. I have uploaded the resulting files as well as the config fi=
le
> > > I used there:
> > > https://temp.aurel32.net/linux-arm64-size-head.o.tar.gz
> > >
> >
> > Indeed. So we go from
> >
> >   [15] .BTF              PROGBITS         ffff8000091d1ff4  011e1ff4
> >        00000000005093d6  0000000000000000   A       0     0     1
> >
> > to
> >
> >   [15] .BTF              PROGBITS         ffff8000091d1ff4  011e1ff4
> >        0000000000c0e5eb  0000000000000000   A       0     0     1
> >
> > i.e, from 5 MiB to 12+ MiB of BTF metadata.
> >
> > To me, it is not clear at all how one would be related to the other,
> > so it will leave it to the Kbuild and BTF experts to chew on this one.
>
>
>
> Strange.
>
> I used the .config file Aurelien provided, but
> I still cannot reproduce this issue.
>
>
> The vmlinux size is small
> as-is in the current mainline.
>
>
>
> [mainline]
>
>
> masahiro@zoe:~/ref/linux(master)$ git log --oneline -1
> 65aca32efdcb (HEAD -> master, origin/master, origin/HEAD) Merge tag
> 'mm-hotfixes-stable-2023-03-24-17-09' of
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-size  vmlinux
>    text    data     bss     dec     hex filename
> 24561282 8186912 622032 33370226 1fd3072 vmlinux
> masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-readelf -S
> vmlinux | grep -A1 BTF
>   [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
>        000000000048209c  0000000000000000   A       0     0     1
>   [16] .BTF_ids          PROGBITS         ffff8000096427a4  016527a4
>        0000000000000a1c  0000000000000000   A       0     0     1
>
>
>
>
> [mainline + revert 994b7ac]
>
> masahiro@zoe:~/ref/linux2(testing)$ git log --oneline -2
> 856c80dd789c (HEAD -> testing) Revert "arm64: remove special treatment
> for the link order of head.o"
> 65aca32efdcb (origin/master, origin/HEAD, master) Merge tag
> 'mm-hotfixes-stable-2023-03-24-17-09' of
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-size  vmlinux
>    text    data     bss     dec     hex filename
> 24561329 8186912 622032 33370273 1fd30a1 vmlinux
> masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-readelf -S
> vmlinux | grep -A1 BTF
>   [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
>        00000000004820cb  0000000000000000   A       0     0     1
>   [16] .BTF_ids          PROGBITS         ffff8000096427d4  016527d4
>        0000000000000a1c  0000000000000000   A       0     0     1
>
>
>
> I still do not know what affects reproducibility.
> (compiler version, pahole version, etc. ?)
>
>
>
>
> Aurelien used GCC 12 + binutils 2.40, but
> my toolchain is a bit older.
>
>
>
> FWIW, I tested this on Ubuntu 22.04LTS.
>
> masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
> Copyright (C) 2021 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>
> masahiro@zoe:~/ref/linux(master)$ pahole --version
> v1.22
>
> masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-as --version
> GNU assembler (GNU Binutils for Ubuntu) 2.38
> Copyright (C) 2022 Free Software Foundation, Inc.
> This program is free software; you may redistribute it under the terms of
> the GNU General Public License version 3 or later.
> This program has absolutely no warranty.
> This assembler was configured for a target of `aarch64-linux-gnu'.





I did the same things in Deiban sid
in order to use newer versions of tools.



Yup, I saw a huge increase in the .BTF section,
and observed the difference w/wo 994b7ac.

masahiro@3e9802d667e3:~/ref/linux2$ aarch64-linux-gnu-readelf -S
vmlinux | grep -A1 BTF
  [15] .BTF              PROGBITS         ffff8000091d26c4  011e26c4
       000000000093e626  0000000000000000   A       0     0     1
  [16] .BTF_ids          PROGBITS         ffff800009b10cec  01b20cec
       0000000000000a1c  0000000000000000   A       0     0     1


I guess some tool might be affecting this.
Even with 994b7ac reverted, the .BTF section
is much bigger.


At the same time, I saw a ton of warnings
while building BTF.


masahiro@3e9802d667e3:~/ref/linux2$ cat /etc/os-release
PRETTY_NAME=3D"Debian GNU/Linux bookworm/sid"
NAME=3D"Debian GNU/Linux"
VERSION_CODENAME=3Dbookworm
ID=3Ddebian
HOME_URL=3D"https://www.debian.org/"
SUPPORT_URL=3D"https://www.debian.org/support"
BUG_REPORT_URL=3D"https://bugs.debian.org/"



  LD      vmlinux
  BTFIDS  vmlinux
WARN: multiple IDs found for 'task_struct': 177, 16690 - using 177
WARN: multiple IDs found for 'file': 517, 16712 - using 517
WARN: multiple IDs found for 'vm_area_struct': 524, 16714 - using 524
WARN: multiple IDs found for 'inode': 586, 16773 - using 586
WARN: multiple IDs found for 'path': 618, 16802 - using 618
WARN: multiple IDs found for 'task_struct': 177, 17267 - using 177
WARN: multiple IDs found for 'file': 517, 17312 - using 517
WARN: multiple IDs found for 'vm_area_struct': 524, 17315 - using 524
WARN: multiple IDs found for 'seq_file': 1029, 17376 - using 1029
WARN: multiple IDs found for 'inode': 586, 17494 - using 586
WARN: multiple IDs found for 'path': 618, 17523 - using 618
WARN: multiple IDs found for 'cgroup': 704, 17532 - using 704
WARN: multiple IDs found for 'task_struct': 177, 18652 - using 177
WARN: multiple IDs found for 'file': 517, 18704 - using 517
WARN: multiple IDs found for 'vm_area_struct': 524, 18707 - using 524
WARN: multiple IDs found for 'seq_file': 1029, 18781 - using 1029
WARN: multiple IDs found for 'inode': 586, 18911 - using 586
WARN: multiple IDs found for 'path': 618, 18940 - using 618
WARN: multiple IDs found for 'cgroup': 704, 18949 - using 704
WARN: multiple IDs found for 'task_struct': 177, 20514 - using 177
WARN: multiple IDs found for 'file': 517, 20515 - using 517
WARN: multiple IDs found for 'vm_area_struct': 524, 20541 - using 524
WARN: multiple IDs found for 'inode': 586, 20595 - using 586
WARN: multiple IDs found for 'path': 618, 20624 - using 618
WARN: multiple IDs found for 'cgroup': 704, 20639 - using 704
WARN: multiple IDs found for 'seq_file': 1029, 20801 - using 1029
   ...




I am not sure whether these warnings are related to
the current issue or not.


I did not look into it any further.
I may not be seeing a sane build result.


--=20
Best Regards
Masahiro Yamada
