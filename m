Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368B86C894B
	for <lists+linux-arch@lfdr.de>; Sat, 25 Mar 2023 00:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCXXeN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 19:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXXeM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 19:34:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DFB2128;
        Fri, 24 Mar 2023 16:34:10 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so13703773edb.13;
        Fri, 24 Mar 2023 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679700849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgItKrX+omIU9rZpNlw4Q+2It9vk7cbT9xavBL46gQE=;
        b=jhhtQYQhwSI1lUOacB6rX6mQ6I9kcNngJjlT25U2XMe2EBOP2LZkRzUJI5uO0onZT9
         QS9spWGM6ub7lEX5PQZwpfVufsW/HoiurnwsZyA2JTDaiwfFSGhG3Oyfl9SQh71iG0o3
         gjrCNIk+aT5plzF5gcJbsHAkNqknm6OhSvr3lkAgVe9naRZHzLaNBPCa+rap90AcIItL
         s6LZax6BRYSjhY2VW9RIyvIRwNJQxZdmYddrdrqUv6Q5kBUdshsk0EfRiWXpLL670K9e
         Kf2QljzpYsiwn7F2/BINg4/dXiHGDT/VdChMuPjee77g6zEwfTERr7XSoLdaisvZKjFH
         Q6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679700849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgItKrX+omIU9rZpNlw4Q+2It9vk7cbT9xavBL46gQE=;
        b=RBBEE7e8LW+JEhgcX21HwWdlkLFJIKqQoe9u8L9yT6r7idHKzBj2ETTX7LrhaX6Vdq
         nBmuMrQ+OiIJ3eBvOYV0gKSSpj4Vh8GVIuBTlmh5vgBsQo3TbHhymOhyHOzSCxaY0tDq
         FWd06D52B2gPIL2R/JvYJuNgbxhH3fG+CWX+NHUKL4qbr+4AehqKbXfL2nSDO2q8spYe
         W9jotzZTRTNe/g6BLuUCtSV4rASa0WG8mam1ZfhZiLmwlvNqUbPPBY9WQJB8BDr+rkDt
         VpTDA0TEaHwbR21IHyG3ILRAMf3JAEyiu3pOeiWilmfXKpPMUY0oM/uxjg/mlVjRUwnY
         sOBA==
X-Gm-Message-State: AAQBX9dQRbWvO/G5IlScfvE+TP3T1+amRAGJyapvy2AO7m2v3JcOom9L
        IfKx3Z59ZuMIoWHfEH5DYTplaw4XjvLVYxnfFjI=
X-Google-Smtp-Source: AKy350brcVccDKLSCNemmSxxbeInWb75qa6vMOl2tfUtV4JIn1vn2IHNipB+v4CqYEiT4ZW+T2GgE8018gwBsfqqAjE=
X-Received: by 2002:a17:907:f90:b0:924:32b2:e3d1 with SMTP id
 kb16-20020a1709070f9000b0092432b2e3d1mr2278540ejc.3.1679700848823; Fri, 24
 Mar 2023 16:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221012233500.156764-1-masahiroy@kernel.org> <ZBovCrMXJk7NPISp@aurel32.net>
 <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
 <ZBzAp457rrO52FPy@aurel32.net> <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
In-Reply-To: <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Mar 2023 16:33:57 -0700
Message-ID: <CAADnVQLniq_NTN+dayioY76UvJ6Rt88wC31tboQx0UAvMn3Few@mail.gmail.com>
Subject: Re: [PATCH] arm64: remove special treatment for the link order of head.o
To:     Ard Biesheuvel <ardb@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 4:39=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
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

That's a huge increase.
It's not just that commit responsible, but the whole series ?
https://lore.kernel.org/lkml/20220906061313.1445810-1-masahiroy@kernel.org/
I'm guessing "Link vmlinux and modules in parallel" is related.
I'm not sure what "parallel link" means. Running 'ar' in parallel?
I cannot read makefile syntax, so no idea.

Jiri, Andrii, Alan, please take a look.
