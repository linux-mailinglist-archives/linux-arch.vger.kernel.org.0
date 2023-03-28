Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718F56CB54B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Mar 2023 06:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjC1EGP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Mar 2023 00:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjC1EGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Mar 2023 00:06:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57A3DE;
        Mon, 27 Mar 2023 21:06:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so44364234edb.6;
        Mon, 27 Mar 2023 21:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679976371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDI9x5S91I3YVFHLIUQDSl5pwYy7y0vI8J4VR3cNmtA=;
        b=aex3Yrg/Zgqv/q4oJydULrECV0VRQxmBcGBvlzqy7giPT0KNqCxtRIO9gLVQdcaF2q
         X6CCu1FGOM0ppzji2X73IpSzhzIjT57KrsnpQqOWlqoElQEO9GzvGA+3y7at5WzRDsKy
         pVccKI1j4sj9O1ovhdY3WH3YqH/Ii7MCVtaDLPKJRQ5h1MtjVi3xT9cvMKOAtQANoDzB
         +snrLTO9DKEaRJU8LfHfz71weUbf3RVfrT5DxiLR+GNTNndWffqva18u53e5GGv/w4Le
         cAN0QhYKiPKkOBzMYrncmiKYn/y66YTnelkiUP22OceslUGkRbLi8IC2k9ylwUPOxrgX
         jaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679976371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDI9x5S91I3YVFHLIUQDSl5pwYy7y0vI8J4VR3cNmtA=;
        b=LkjZg4ZL9LR3L5uDJLi/mIRaWpmZaEca3Zr9bo5iV/rvXbBltown+kmpyrw39kG+mM
         iN286R42RVm4g4IJpegx8aTCMkTaUOplZEPWDUDAwB7Dbl1TEYQoSYCYs7jVTLP703qR
         /buGuK7ej7HWME5JPAVqtju/e8HRd6yZJZwslvHvQEECoaOdlw3RTkCvLQprOkF70oWK
         DUyhbmqfhnx1CNNxF5GfhVoSjSB/ELDjHrk2wkKsa34afb2aNohbzk2D4o5cmwiPTNf+
         2h0GZDceD7IFVoTxVLFsN1UUceLxARPY+GSdk6h6klDRNsVI2nqoyZbJA4LCRO56jKDg
         0KTg==
X-Gm-Message-State: AAQBX9eIKnqefxGpUB1QWPMux2dm/5V1G0A+98xjqAB5M1jR06aigVBz
        U8ZhmjVifwviuekkkR3VMN/IJQ000b//oMVwzgU=
X-Google-Smtp-Source: AKy350Zy4YfNXBDnbEAXN4mrQxPhTDk1MN+1EaNG1aUo8NLjCHMUjH40vByu3GdYBYAfOENFwC/wqlz9D0zPmVLrcbw=
X-Received: by 2002:a17:906:4746:b0:8ab:b606:9728 with SMTP id
 j6-20020a170906474600b008abb6069728mr7083779ejs.5.1679976371283; Mon, 27 Mar
 2023 21:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221012233500.156764-1-masahiroy@kernel.org> <ZBovCrMXJk7NPISp@aurel32.net>
 <CAMj1kXHwtb9aY+vd4e69Wg47GpL0sT=dDaCUA1sF7=edzc+Qeg@mail.gmail.com>
 <ZBzAp457rrO52FPy@aurel32.net> <CAMj1kXHvfHwQFX1SKbUvpHWOr3+i7Tp5Hod-_jZE4hDHZmmRZg@mail.gmail.com>
 <CAADnVQLniq_NTN+dayioY76UvJ6Rt88wC31tboQx0UAvMn3Few@mail.gmail.com>
In-Reply-To: <CAADnVQLniq_NTN+dayioY76UvJ6Rt88wC31tboQx0UAvMn3Few@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Mar 2023 21:05:59 -0700
Message-ID: <CAEf4BzYFkBp55CkuKgDxgw+zqcZn73AFwFDBDL6F7FAdgEKUcA@mail.gmail.com>
Subject: Re: [PATCH] arm64: remove special treatment for the link order of head.o
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "open list:BPF JIT for MIPS (32-BIT AND 64-BIT)" 
        <bpf@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Fri, Mar 24, 2023 at 4:34=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 24, 2023 at 4:39=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
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
> That's a huge increase.
> It's not just that commit responsible, but the whole series ?
> https://lore.kernel.org/lkml/20220906061313.1445810-1-masahiroy@kernel.or=
g/
> I'm guessing "Link vmlinux and modules in parallel" is related.
> I'm not sure what "parallel link" means. Running 'ar' in parallel?
> I cannot read makefile syntax, so no idea.
>
> Jiri, Andrii, Alan, please take a look.

So it seems to come from the difference in return type for mm_struct's
get_unmapped_area callback:


struct mm_struct {
        struct {
                struct maple_tree mm_mt;
#ifdef CONFIG_MMU
                unsigned long (*get_unmapped_area) (struct file *filp,
                                unsigned long addr, unsigned long len,
                                unsigned long pgoff, unsigned long flags);
#endif


It seems that sometimes we have "unsigned long" as return type, but
sometimes it's just "void". I haven't debugged why this is happening.
But cc'ing Eduard, just in case it's related to the "unspecified type"
tracking in pahole, which he recently fixed. There could be some other
related bug lurking around.
