Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F28F655C29
	for <lists+linux-arch@lfdr.de>; Sun, 25 Dec 2022 03:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLYCRc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Dec 2022 21:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYCRb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Dec 2022 21:17:31 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582E9FF5;
        Sat, 24 Dec 2022 18:17:29 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2BP2Gulc020368;
        Sun, 25 Dec 2022 11:16:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2BP2Gulc020368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1671934617;
        bh=i1CIlvrMeJ6Unbiyi8M56TQKpTSPQORn+vyN2VH1KLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TlzKd+OynjRK7+M8sQW8wRR4k8WqowL+gpNeTjrpACNS45QyuLpAmhVT9aLTgkfe/
         BIKUrcwv9n1OQY3XJM18jJ2e5bTopV3ViY7yT+fPtf5wNTYPZ7RG4kwSxPj3ENYlUS
         Oitw2EdM9pdwryE5pzRLFzAXyWgLLDOvVmZMp1U9kz8DxNHglWYIL9Et/bS1TsWORJ
         EBfQoR5di9WRPrevc2IumoMjqjwTFpREz+qZuesiQ42M8eqyf9KBbJhqLjTZgvO86H
         /C00LuJKIMH+t4OcuEqVW3XemG1/4vwrIgdSt98TMv1efAF9tcwzKclPiCnml9FAAJ
         hd+FfUYVToYLQ==
X-Nifty-SrcIP: [209.85.167.173]
Received: by mail-oi1-f173.google.com with SMTP id r11so7837114oie.13;
        Sat, 24 Dec 2022 18:16:57 -0800 (PST)
X-Gm-Message-State: AFqh2krLjK9ft8dp5AiuT+ez2Nx9XvZTfym0DOpjRFQd5/rfQc4gRdb3
        NPz06jPPD1ZIHvR0hmvEmEkwnLdVoNu3b42b4Lw=
X-Google-Smtp-Source: AMrXdXvpgo6G9vs/ZB2O/40m6ifPH6XCi9zSwh0/qIqn/vJD7OIUzU98ld/qHJP14DbdYesxzVXTzed0a3GcJP37dpo=
X-Received: by 2002:aca:2b17:0:b0:361:24b6:466c with SMTP id
 i23-20020aca2b17000000b0036124b6466cmr465364oik.194.1671934615944; Sat, 24
 Dec 2022 18:16:55 -0800 (PST)
MIME-Version: 1.0
References: <CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com>
 <26bd2928-9d62-32b3-4f9f-9dd9293cefeb@leemhuis.info> <CAK7LNAQ5VVRdrewtxrBdw561LL=yY8fdr=i1e7pp4DRht=r_Ww@mail.gmail.com>
 <0ab93345-18e1-15c9-a4a3-066ea1cd862b@leemhuis.info> <CAMj1kXE+LBOBavOre1O8LTGPCmB8m58fbfo92Sx4WukyNAur-A@mail.gmail.com>
In-Reply-To: <CAMj1kXE+LBOBavOre1O8LTGPCmB8m58fbfo92Sx4WukyNAur-A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 25 Dec 2022 11:16:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQ-NjYxPvGf4o6N5mp9kS07fpphcEn4_9LOMtS2nTbmQ@mail.gmail.com>
Message-ID: <CAK7LNATQ-NjYxPvGf4o6N5mp9kS07fpphcEn4_9LOMtS2nTbmQ@mail.gmail.com>
Subject: Re: BUG: arm64: missing build-id from vmlinux
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 22, 2022 at 8:53 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 21 Dec 2022 at 17:29, Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > On 21.12.22 16:39, Masahiro Yamada wrote:
> > > On Wed, Dec 21, 2022 at 5:23 PM Thorsten Leemhuis
> > > <regressions@leemhuis.info> wrote:
> > >>
> > >> Hi, this is your Linux kernel regression tracker. CCing the regressi=
on
> > >> mailing list, as it should be in the loop for all regressions:
> > >> https://docs.kernel.org/admin-guide/reporting-regressions.html
> > >>
> > >> On 18.12.22 21:51, Dennis Gilmore wrote:
> > >>> The changes in https://lore.kernel.org/linux-arm-kernel/16678371644=
2.32724.935158280857906499.b4-ty@kernel.org/T/
> > >>> result in vmlinux no longer having a build-id.
> > >>
> > >> FWIW, that's 994b7ac1697b ("arm64: remove special treatment for the =
link
> > >> order of head.o") from Masahiro merged through Will this cycle.
> > >>
> > >>> At the least, this
> > >>> causes rpm builds to fail. Reverting the patch does bring back a
> > >>> build-id, but there may be a different way to fix the regression
> > >>
> > >> Makes me wonder if other distros or CIs relying on the build-id are
> > >> broken, too.
> > >>
> > >> Anyway, the holiday season is upon us, hence I also wonder if it wou=
ld
> > >> be best to revert above change quickly and leave further debugging f=
or 2023.
> > >>
> > >> Masahiro, Will, what's your option on this?
> >
> > Masahiro, many thx for looking into this.
> >
> > > I do not understand why you rush into the revert so quickly.
> > > We are before -rc1.
> > > We have 7 weeks before the 6.2 release
> > > (assuming we will have up to -rc7).
> > >
> > > If we get -rc6 or -rc7 and we still do not
> > > solve the issue, we should consider reverting it.
> >
> > Because it looked like a regression that makes it harder for people and
> > CI systems to build and test mainline. To quote
> > Documentation/process/handling-regressions.rst (
> > https://docs.kernel.org/process/handling-regressions.html ):
> >
> > """
> >  * Fix regressions within two or three days, if they are critical for
> > some reason =E2=80=93 for example, if the issue is likely to affect man=
y users
> > of the kernel series in question on all or certain architectures. Note,
> > this includes mainline, as issues like compile errors otherwise might
> > prevent many testers or continuous integration systems from testing the
> > series.
> > """
> >
> > I suspect that other distros rely on the build-id as well. Maybe I'm
> > wrong with that, but even if only Fedora and derivatives are effected i=
t
> > will annoy some people. Sure, each can apply the revert, but before tha=
t
> > everyone affected will spend time debugging the issue first. A quick
> > revert in mainline (with a reapply later together with a fix) thus IMHO
> > is the most efficient approach afaics.
> >
>
> Agree with Masahiro here.
>
> The issue seems to be caused by the fact that whichever object gets
> linked first gets to decide the type of a section, and so the .notes
> section will be of type NOTE if head.o gets linked first, or PROGBITS
> otherwise. The latter PROGBITS type seems to be the result of the
> compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.
>
> The hunk below fixes it for me, by avoiding notes emitted as PROGBITS.
> I'll leave it to Masahiro to decide whether this should be fixed for
> arm64 only or for all architectures, but I suspect the latter would be
> most appropriate.
>
> Note that the kernel's rpm-pkg and binrpm-pkg targets seem to be
> unaffected by this.


Thanks for root-causing this.


I like to fix this for all architectures because riscv is also broken.

https://lore.kernel.org/lkml/20221224192751.810363-1-masahiroy@kernel.org/




> diff --git a/arch/arm64/include/asm/assembler.h
> b/arch/arm64/include/asm/assembler.h
> index 376a980f2bad08bb..10a172601fe7f53f 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -818,7 +818,7 @@ alternative_endif
>
>  #ifdef GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT
>  .macro emit_aarch64_feature_1_and, feat=3DGNU_PROPERTY_AARCH64_FEATURE_1=
_DEFAULT
> -       .pushsection .note.gnu.property, "a"
> +       .pushsection .note.gnu.property, "a", %note
>         .align  3
>         .long   2f - 1f
>         .long   6f - 3f


I did not fold this hunk in my patch.

I compiled with CONFIG_ARM64_BTI_KERNEL=3Dy.

.note.gnu.property section in VDSO was already NOTE
without this hunk.







> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.=
lds.S
> index 4c13dafc98b8400f..8a8044dea71b0609 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -160,6 +160,7 @@ SECTIONS
>         /DISCARD/ : {
>                 *(.interp .dynamic)
>                 *(.dynsym .dynstr .hash .gnu.hash)
> +               *(.note.GNU-stack) # emitted as PROGBITS
>         }
>
>         . =3D KIMAGE_VADDR;



--=20
Best Regards
Masahiro Yamada
