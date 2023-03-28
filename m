Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA576CBC8D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 12:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjC1Kde (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 06:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1Kdd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 06:33:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F466184;
        Tue, 28 Mar 2023 03:33:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so47501559edb.11;
        Tue, 28 Mar 2023 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679999611;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIQtKmY6yWS8CDXvo4BZswBARmIubt6ewMMSD2EbBJg=;
        b=o4qT9SLghP4XbsHKw9QxW2+RPXLZrIgtQgby5gUwPo/7cOw/RNnLSvEY0bU2OeFUTu
         ojRw+U4yltSYLTyibFiWX8Xby2z2WnzJz2tS56S7IY5c/BhlGj8M/HX63wOhrSkOPbLo
         f1V3e9JjUvv77z2hsH2MHZVU3ztkIh0DkoZ07zjQ9VNOwoQet7VJmTG5eezvsK5DZvzN
         nk8RS7WEHuFmGXseieuMoizjue2HDbHr8jrE3L6jggeZexP4h1/KQ2W8TQcf+FV148ZH
         gr5xQrLDAjpeoQERSU+c9UxinojfuawU/jH+zHDCi1aF9TdJrkbvkZjXo+jTHm3HxleH
         0/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679999611;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIQtKmY6yWS8CDXvo4BZswBARmIubt6ewMMSD2EbBJg=;
        b=LZlHeUMxOiWkq2pH2hAPxQE5SXw8GWJ0SU4LF7z9WvSyZqxt+IZHqfwdTsWQKkj2Vg
         o+Zo28WIgxtnFcm4nYnpsxvacQcez1JfxY9KjPLNtiNT2AxVGj81KFkN3wDt00kUJ+9Q
         +nIoWtId8qPtEsI8muaEAl1yzt+4V2NaOKnqfbjAgkBTdNAoa94vZTJBodCQUqZcGOyN
         4cVonrR3zzEL7TGamulibP/gLazyGcDCT7hhUh4m83V9hvnfL23XDsBmXZtBOEYh/v5R
         gpvLPx/WEIM5BAODYGvAUqcaNSUj+kNskoMGiOtd1kV5PekRuswakUAZujXZsmce5GGO
         W9ow==
X-Gm-Message-State: AAQBX9dNIZRP3jN+yK+oqtBH8FyfpAOOK17VnKbTamnVmmFRxalJOspx
        i8CeRJ+Ur5pMRtfA5XMWdL4=
X-Google-Smtp-Source: AKy350YvW5QQ8F3pllLvIf5HJCqeL8GzHWuERe1VUWtWMxMrHM8FBwDUAVkg16gdmX1/2PUX6IRVhQ==
X-Received: by 2002:a17:907:8a8e:b0:944:49ee:aea2 with SMTP id sf14-20020a1709078a8e00b0094449eeaea2mr9148171ejc.71.1679999610846;
        Tue, 28 Mar 2023 03:33:30 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hy16-20020a1709068a7000b00931d3509af1sm15025292ejc.222.2023.03.28.03.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:33:30 -0700 (PDT)
Message-ID: <2d8f0889da0e3dfa9c1c8fe9da301d54636a2e6d.camel@gmail.com>
Subject: Re: [PATCH] arm64: remove special treatment for the link order of
 head.o
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <bpf@vger.kernel.org>
Date:   Tue, 28 Mar 2023 13:33:29 +0300
In-Reply-To: <CAK7LNASUbyDV-kMi3fuihUdfnhtzHnk9wosQ0w-fuamDcT2ZBg@mail.gmail.com>
References: <20221012233500.156764-1-masahiroy@kernel.org>
         <ZBovCrMXJk7NPISp@aurel32.net>
         <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
         <ZBzAp457rrO52FPy@aurel32.net>
         <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
         <CAK7LNASdsWMP2jud4niOkrR5+a2jG-Vfo0XEa63bh3L3W6_t0Q@mail.gmail.com>
         <CAK7LNASUbyDV-kMi3fuihUdfnhtzHnk9wosQ0w-fuamDcT2ZBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 2023-03-25 at 20:42 +0900, Masahiro Yamada wrote:
[...]
> > Strange.
> >=20
> > I used the .config file Aurelien provided, but
> > I still cannot reproduce this issue.
> >=20
> >=20
> > The vmlinux size is small
> > as-is in the current mainline.
> >=20
> >=20
> >=20
> > [mainline]
> >=20
> >=20
> > masahiro@zoe:~/ref/linux(master)$ git log --oneline -1
> > 65aca32efdcb (HEAD -> master, origin/master, origin/HEAD) Merge tag
> > 'mm-hotfixes-stable-2023-03-24-17-09' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-size  vmlinux
> >    text    data     bss     dec     hex filename
> > 24561282 8186912 622032 33370226 1fd3072 vmlinux
> > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-readelf -S
> > vmlinux | grep -A1 BTF
> >   [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
> >        000000000048209c  0000000000000000   A       0     0     1
> >   [16] .BTF_ids          PROGBITS         ffff8000096427a4  016527a4
> >        0000000000000a1c  0000000000000000   A       0     0     1
> >=20
> >=20
> >=20
> >=20
> > [mainline + revert 994b7ac]
> >=20
> > masahiro@zoe:~/ref/linux2(testing)$ git log --oneline -2
> > 856c80dd789c (HEAD -> testing) Revert "arm64: remove special treatment
> > for the link order of head.o"
> > 65aca32efdcb (origin/master, origin/HEAD, master) Merge tag
> > 'mm-hotfixes-stable-2023-03-24-17-09' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-size  vmlinux
> >    text    data     bss     dec     hex filename
> > 24561329 8186912 622032 33370273 1fd30a1 vmlinux
> > masahiro@zoe:~/ref/linux2(testing)$ aarch64-linux-gnu-readelf -S
> > vmlinux | grep -A1 BTF
> >   [15] .BTF              PROGBITS         ffff8000091c0708  011d0708
> >        00000000004820cb  0000000000000000   A       0     0     1
> >   [16] .BTF_ids          PROGBITS         ffff8000096427d4  016527d4
> >        0000000000000a1c  0000000000000000   A       0     0     1
> >=20
> >=20
> >=20
> > I still do not know what affects reproducibility.
> > (compiler version, pahole version, etc. ?)
> >=20
> >=20
> >=20
> >=20
> > Aurelien used GCC 12 + binutils 2.40, but
> > my toolchain is a bit older.
> >=20
> >=20
> >=20
> > FWIW, I tested this on Ubuntu 22.04LTS.
> >=20
> > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-gcc --version
> > aarch64-linux-gnu-gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
> > Copyright (C) 2021 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is=
 NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.
> >=20
> > masahiro@zoe:~/ref/linux(master)$ pahole --version
> > v1.22
> >=20
> > masahiro@zoe:~/ref/linux(master)$ aarch64-linux-gnu-as --version
> > GNU assembler (GNU Binutils for Ubuntu) 2.38
> > Copyright (C) 2022 Free Software Foundation, Inc.
> > This program is free software; you may redistribute it under the terms =
of
> > the GNU General Public License version 3 or later.
> > This program has absolutely no warranty.
> > This assembler was configured for a target of `aarch64-linux-gnu'.
>=20
>=20
>=20
>=20
>=20
> I did the same things in Deiban sid
> in order to use newer versions of tools.


Hi Masahiro,

An upgrade from gcc 11 to gcc 12, BTF section increase and a number of
duplicate IDs reported by resolve_btfids matches the description of
the following thread:

https://lore.kernel.org/bpf/Y%2FP1yxAuV6Wj3A0K@google.com/

The issue is caused by change in GNU assembler DWARF generation.
I've sent a patch to fix it a few weeks ago and it is merged in
dwarves master:

a9498899109d ("dwarf_loader: Fix for BTF id drift caused by adding unspecif=
ied types")

Could you please grab a fresh version of dwarves from:

git@github.com:acmel/dwarves.git

compile 'pahole' and try with?

Thanks,
Eduard

>=20
>=20
>=20
> Yup, I saw a huge increase in the .BTF section,
> and observed the difference w/wo 994b7ac.
>=20
> masahiro@3e9802d667e3:~/ref/linux2$ aarch64-linux-gnu-readelf -S
> vmlinux | grep -A1 BTF
>   [15] .BTF              PROGBITS         ffff8000091d26c4  011e26c4
>        000000000093e626  0000000000000000   A       0     0     1
>   [16] .BTF_ids          PROGBITS         ffff800009b10cec  01b20cec
>        0000000000000a1c  0000000000000000   A       0     0     1
>=20
>=20
> I guess some tool might be affecting this.
> Even with 994b7ac reverted, the .BTF section
> is much bigger.
>=20
>=20
> At the same time, I saw a ton of warnings
> while building BTF.
>=20
>=20
> masahiro@3e9802d667e3:~/ref/linux2$ cat /etc/os-release
> PRETTY_NAME=3D"Debian GNU/Linux bookworm/sid"
> NAME=3D"Debian GNU/Linux"
> VERSION_CODENAME=3Dbookworm
> ID=3Ddebian
> HOME_URL=3D"https://www.debian.org/"
> SUPPORT_URL=3D"https://www.debian.org/support"
> BUG_REPORT_URL=3D"https://bugs.debian.org/"
>=20
>=20
>=20
>   LD      vmlinux
>   BTFIDS  vmlinux
> WARN: multiple IDs found for 'task_struct': 177, 16690 - using 177
> WARN: multiple IDs found for 'file': 517, 16712 - using 517
> WARN: multiple IDs found for 'vm_area_struct': 524, 16714 - using 524
> WARN: multiple IDs found for 'inode': 586, 16773 - using 586
> WARN: multiple IDs found for 'path': 618, 16802 - using 618
> WARN: multiple IDs found for 'task_struct': 177, 17267 - using 177
> WARN: multiple IDs found for 'file': 517, 17312 - using 517
> WARN: multiple IDs found for 'vm_area_struct': 524, 17315 - using 524
> WARN: multiple IDs found for 'seq_file': 1029, 17376 - using 1029
> WARN: multiple IDs found for 'inode': 586, 17494 - using 586
> WARN: multiple IDs found for 'path': 618, 17523 - using 618
> WARN: multiple IDs found for 'cgroup': 704, 17532 - using 704
> WARN: multiple IDs found for 'task_struct': 177, 18652 - using 177
> WARN: multiple IDs found for 'file': 517, 18704 - using 517
> WARN: multiple IDs found for 'vm_area_struct': 524, 18707 - using 524
> WARN: multiple IDs found for 'seq_file': 1029, 18781 - using 1029
> WARN: multiple IDs found for 'inode': 586, 18911 - using 586
> WARN: multiple IDs found for 'path': 618, 18940 - using 618
> WARN: multiple IDs found for 'cgroup': 704, 18949 - using 704
> WARN: multiple IDs found for 'task_struct': 177, 20514 - using 177
> WARN: multiple IDs found for 'file': 517, 20515 - using 517
> WARN: multiple IDs found for 'vm_area_struct': 524, 20541 - using 524
> WARN: multiple IDs found for 'inode': 586, 20595 - using 586
> WARN: multiple IDs found for 'path': 618, 20624 - using 618
> WARN: multiple IDs found for 'cgroup': 704, 20639 - using 704
> WARN: multiple IDs found for 'seq_file': 1029, 20801 - using 1029
>    ...
>=20
>=20
>=20
>=20
> I am not sure whether these warnings are related to
> the current issue or not.
>=20
>=20
> I did not look into it any further.
> I may not be seeing a sane build result.
>=20
>=20

