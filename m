Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47775DD61
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jul 2023 18:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGVQJ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Jul 2023 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGVQJ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jul 2023 12:09:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F21FDF;
        Sat, 22 Jul 2023 09:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8807360B9E;
        Sat, 22 Jul 2023 16:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E104AC433CA;
        Sat, 22 Jul 2023 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690042163;
        bh=XlqnUjAAGQf18Gzjf58M0ZJvZ/hG9R61k0ineAbK0yg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z91QhgNtkHOANe90yfLX/U5hOUMAiNke/OL9/j3Ht5B+07iM3DUhz+gU4C9IK1oZX
         0rtJwRflazO3Amf7alGhySqNvdMl71k+O38CLyVXJmdCq3cnmnejzrrPuTPE76mHDz
         HrdBYObfkXMjvsaPbS3C0yl9rL70+AfOLxBavegUKVqmgvvLJj/StAtjOoxigV9z45
         c5UwUGBFRbEUFUFcI33UlkibL4uSWi1kkoBdPlMjgvkQXeez/3pcusQV3OOw9GbMAM
         pdNO4g4rzDguYM9rea01xtvlRUM/PGqd0QkK/iI/7tIQuKZIHJCc4dvScW5IprzgYk
         64lCFMkJ5hvqA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3a1ebb85f99so2233347b6e.2;
        Sat, 22 Jul 2023 09:09:23 -0700 (PDT)
X-Gm-Message-State: ABy/qLaF6fVt8kGdu5yZne94i4KPH+78n1M2sH5P/Jm17wRm9pqrE4p6
        z2FYg7FszbWrFYbhs0o1n+wDaadHraq14BQ5E4A=
X-Google-Smtp-Source: APBJJlHPpDv+VZ/4EYRfVhQzoIs3NEngzOUyMzM44psYtjM7fttRbAl0kW4RVp/GLWrbeOmB94cCdQ6/mjWWf/CvBmo=
X-Received: by 2002:a05:6808:7c5:b0:3a0:4ff2:340 with SMTP id
 f5-20020a05680807c500b003a04ff20340mr5280903oij.57.1690042163139; Sat, 22 Jul
 2023 09:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220109181529.351420-1-masahiroy@kernel.org> <20220109181529.351420-3-masahiroy@kernel.org>
 <YdwZe9DHJZUaa6aO@buildd.core.avm.de> <20230623144544.GA24871@lxhi-065> <20230719190902.GA11207@lxhi-064.domain>
In-Reply-To: <20230719190902.GA11207@lxhi-064.domain>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 23 Jul 2023 01:08:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQhn28Wbb97+U_3n0EwoKnonjFoY3OnKcE7aqnSgRc4ow@mail.gmail.com>
Message-ID: <CAK7LNAQhn28Wbb97+U_3n0EwoKnonjFoY3OnKcE7aqnSgRc4ow@mail.gmail.com>
Subject: Re: [PATCH 3/5] kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Nicolas Schier <n.schier@avm.de>,
        SzuWei Lin <szuweilin@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Matthias.Thomae@de.bosch.com,
        yyankovskyi@de.adit-jv.com, Dirk.Behme@de.bosch.com,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 20, 2023 at 4:09=E2=80=AFAM Eugeniu Rosca <erosca@de.adit-jv.co=
m> wrote:
>
> Hello Yamada-san,
>
> On Fri, Jun 23, 2023 at 04:45:44PM +0200, Eugeniu Rosca wrote:
> > Hello Yamada-san,
> > Hello Nicolas,
> > Cc: SzuWei Lin (committer of the patch in AOSP [1])
> > Cc: Kbuild
> >
> > On Mon, Jan 10, 2022 at 12:33:15PM +0100, Nicolas Schier wrote:
> > > On Mon, Jan 10, 2022 at 03:15:27AM +0900, Masahiro Yamada wrote:
> > > > GZIP-compressed files end with 4 byte data that represents the size
> > > > of the original input. The decompressors (the self-extracting kerne=
l)
> > > > exploit it to know the vmlinux size beforehand. To mimic the GZIP's
> > > > trailer, Kbuild provides cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}.
> > > > Unfortunately these macros are used everywhere despite the appended
> > > > size data is only useful for the decompressors.
> > > >
> > > > There is no guarantee that such hand-crafted trailers are safely ig=
nored.
> > > > In fact, the kernel refuses compressed initramdisks with the garbag=
e
> > > > data. That is why usr/Makefile overrides size_append to make it no-=
op.
> > > >
> > > > To limit the use of such broken compressed files, this commit renam=
es
> > > > the existing macros as follows:
> > > >
> > > >   cmd_bzip2   --> cmd_bzip2_with_size
> > > >   cmd_lzma    --> cmd_lzma_with_size
> > > >   cmd_lzo     --> cmd_lzo_with_size
> > > >   cmd_lz4     --> cmd_lz4_with_size
> > > >   cmd_xzkern  --> cmd_xzkern_with_size
> > > >   cmd_zstd22  --> cmd_zstd22_with_size
> > > >
> > > > To keep the decompressors working, I updated the following Makefile=
s
> > > > accordingly:
> > > >
> > > >   arch/arm/boot/compressed/Makefile
> > > >   arch/h8300/boot/compressed/Makefile
> > > >   arch/mips/boot/compressed/Makefile
> > > >   arch/parisc/boot/compressed/Makefile
> > > >   arch/s390/boot/compressed/Makefile
> > > >   arch/sh/boot/compressed/Makefile
> > > >   arch/x86/boot/compressed/Makefile
> > > >
> > > > I reused the current macro names for the normal usecases; they prod=
uce
> > > > the compressed data in the proper format.
> > > >
> > > > I did not touch the following:
> > > >
> > > >   arch/arc/boot/Makefile
> > > >   arch/arm64/boot/Makefile
> > > >   arch/csky/boot/Makefile
> > > >   arch/mips/boot/Makefile
> > > >   arch/riscv/boot/Makefile
> > > >   arch/sh/boot/Makefile
> > > >   kernel/Makefile
> > > >
> > > > This means those Makefiles will stop appending the size data.
> > > >
> > > > I dropped the 'override size_append' hack from usr/Makefile.
> > > >
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > ---
> > >
> > > Reviewed-by: Nicolas Schier <n.schier@avm.de>
> >
> > If you don't mind, I would like to report another instance of
> > "/bin/sh: Argument list too long" while building some out-of-tree *ko
> > in a number of downstream v5.15.78+ kernels containing [1].
> >
> > For some time now, we've been living with ugly hacks to overcome it.
> >
> > Fortunately, recent git bisecting efforts apparently reveal that
> > current v5.17-rc1 commit (and its backports in downstream) look to
> > act as the culprit (confirmed on several host machines). So, I
> > started to have some hopes of a long-term solution and hence
> > sharing the findings as a first step.
> >
> > I am not entirely clear how to properly trace this behavior, since no
> > amount of "make V=3D1/V=3D2" uncovers more details. Purely by accident,=
 I
> > looked into the top/htop output (while running the repro) and
> > noticed several processes doing:
> >
> > /bin/sh -c dec_size=3D0; for F in <humongous list of filenames>; do \
> >   fsize=3D$(sh /abs/path/to/scripts/file-size.sh $F); \
> >   dec_size=3D$(expr $dec_size + $fsize); done; printf "%08x\n" $dec_siz=
e \
> >   | sed 's/\(..\)/\1 /g' | { read ch0 ch1 ch2 ch3; for ch in \
> >   $ch3 $ch2 $ch1 $ch0; do printf '%s%03o' '\\' $((0x$ch)); done; }
> >
> > As it was the case in the recent report [2], the above command seems
> > to require/assume generous amount of space for the shell arguments.
> >
> > I still haven't compared the exact traces before and after this commit,
> > to quantify by how much the shell argument list is increased (TODO).
> >
> > Another aspect is that current commit seems to introduce the
> > regression in a multi-threaded make only. The issue is apparently
> > masked by 'make -j1' (TBC), which adds another level of complexity.
> >
> > Unfortunately, the build use-case is highly tailored to downstream
> > and is not repeatable against vanilla out of the box.
> >
> > I will continue to increase my understanding behind what's happening.
> > In case there are already any suggestions, would appreciate those.
>
> JFYI, we've got confirmation from Qualcomm Customer Support interface
> that reverting [1] heals the issue on QC end as well. However, it looks
> like none of us has clear understanding how to properly
> troubleshoot/trace/compare the behavior before and after the commit.
>
> I would happily follow any suggestions.
>
> > [1] https://android.googlesource.com/kernel/common/+/bc6d3d83539512
> >     ("UPSTREAM: kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}")
> >
> > [2] https://lore.kernel.org/linux-kbuild/20230616194505.GA27753@lxhi-06=
5/
>
> --
> Best regards,
> Eugeniu Rosca





The only suspicious code I found in the Android common kernel
is the following line in scripts/Makefile.lib



quiet_cmd_zstd =3D ZSTD    $@
      cmd_zstd =3D { cat $(real-prereqs) | $(ZSTD) -19; $(size_append); } >=
 $@







If you see the corresponding line in the mainline kernel,
it looks as follows:


quiet_cmd_zstd =3D ZSTD    $@
      cmd_zstd =3D cat $(real-prereqs) | $(ZSTD) -19 > $@








7ce7e984ab2b218d6e92d5165629022fe2daf9ee depends on
64d8aaa4ef388b22372de4dc9ce3b9b3e5f45b6c


But, Android common kernel back-ported only
7ce7e984ab2b218d6e92d5165629022fe2daf9ee



Please backport 64d8aaa4ef388b22372de4dc9ce3b9b3e5f45b6c
and see if the problem goes away.


--=20
Best Regards
Masahiro Yamada
