Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D85C655CB3
	for <lists+linux-arch@lfdr.de>; Sun, 25 Dec 2022 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiLYJBg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Dec 2022 04:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiLYJBe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Dec 2022 04:01:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB39CC2;
        Sun, 25 Dec 2022 01:01:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7081660B5A;
        Sun, 25 Dec 2022 09:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85D9C433F1;
        Sun, 25 Dec 2022 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671958891;
        bh=F9V6rqudNHC3w/MOuFxB946mkc6sc1VA904/FzyDybE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h14ZFajSaOP4V6xbNpCSDe3fvbAemOQtkAIfOOcmbRJHhPj43nAKt1cIX9gRSKpzG
         tF4TJfykHiwVbKcj5MkkI8qgNG8URHBDTKawtqEws+Q6q5wvUvrSU5XKzw2fJSgpjc
         PFxl0mniU9SMGHmmpOFSrDuRNcNVhlQ8ZvP9I44MkjBwlVMA5M7qcyHeXqt2BCYRQB
         nkNDUIBKr2KV5SuDe5cqSwUCwZS9d8srGrSDzV+pXHQG15aadLyiQXG/+i58tHPFku
         xtuhyf38RijtRBsVTxweg99YuS73lg6IxLQjyjZKLilBfvKdNltt6084x1HKc3pddn
         CsZCNfxLyLkig==
Received: by mail-lf1-f46.google.com with SMTP id f34so12563195lfv.10;
        Sun, 25 Dec 2022 01:01:31 -0800 (PST)
X-Gm-Message-State: AFqh2kqLziac63oQm34D4BVSnxJBwNkc4jj7Ixi44c6Nfcpa34ILJW2m
        uTuzvrNsmqlfTDiY5ksi76f970/R3K0mE/K9YWo=
X-Google-Smtp-Source: AMrXdXvHCifhu2cOK6fzHghBdE5YFYBJ3zrKV4Qy41BWeQaHSaUO0TsbnPHGhPINHwKwWZh53DTrroq6iFaXeitlD44=
X-Received: by 2002:a05:6512:15a3:b0:4bc:bdf5:f163 with SMTP id
 bp35-20020a05651215a300b004bcbdf5f163mr747945lfb.583.1671958889737; Sun, 25
 Dec 2022 01:01:29 -0800 (PST)
MIME-Version: 1.0
References: <CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com>
 <26bd2928-9d62-32b3-4f9f-9dd9293cefeb@leemhuis.info> <CAK7LNAQ5VVRdrewtxrBdw561LL=yY8fdr=i1e7pp4DRht=r_Ww@mail.gmail.com>
 <0ab93345-18e1-15c9-a4a3-066ea1cd862b@leemhuis.info> <CAMj1kXE+LBOBavOre1O8LTGPCmB8m58fbfo92Sx4WukyNAur-A@mail.gmail.com>
 <CAK7LNATQ-NjYxPvGf4o6N5mp9kS07fpphcEn4_9LOMtS2nTbmQ@mail.gmail.com>
In-Reply-To: <CAK7LNATQ-NjYxPvGf4o6N5mp9kS07fpphcEn4_9LOMtS2nTbmQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 25 Dec 2022 10:01:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF-AkDMh2EFazW_jEd7s1oy_sWSktpkiU3vLpUqofHm_Q@mail.gmail.com>
Message-ID: <CAMj1kXF-AkDMh2EFazW_jEd7s1oy_sWSktpkiU3vLpUqofHm_Q@mail.gmail.com>
Subject: Re: BUG: arm64: missing build-id from vmlinux
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 25 Dec 2022 at 03:17, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, Dec 22, 2022 at 8:53 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 21 Dec 2022 at 17:29, Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> > >
> > > On 21.12.22 16:39, Masahiro Yamada wrote:
> > > > On Wed, Dec 21, 2022 at 5:23 PM Thorsten Leemhuis
> > > > <regressions@leemhuis.info> wrote:
> > > >>
> > > >> Hi, this is your Linux kernel regression tracker. CCing the regres=
sion
> > > >> mailing list, as it should be in the loop for all regressions:
> > > >> https://docs.kernel.org/admin-guide/reporting-regressions.html
> > > >>
> > > >> On 18.12.22 21:51, Dennis Gilmore wrote:
> > > >>> The changes in https://lore.kernel.org/linux-arm-kernel/166783716=
442.32724.935158280857906499.b4-ty@kernel.org/T/
> > > >>> result in vmlinux no longer having a build-id.
> > > >>
> > > >> FWIW, that's 994b7ac1697b ("arm64: remove special treatment for th=
e link
> > > >> order of head.o") from Masahiro merged through Will this cycle.
> > > >>
> > > >>> At the least, this
> > > >>> causes rpm builds to fail. Reverting the patch does bring back a
> > > >>> build-id, but there may be a different way to fix the regression
> > > >>
> > > >> Makes me wonder if other distros or CIs relying on the build-id ar=
e
> > > >> broken, too.
> > > >>
> > > >> Anyway, the holiday season is upon us, hence I also wonder if it w=
ould
> > > >> be best to revert above change quickly and leave further debugging=
 for 2023.
> > > >>
> > > >> Masahiro, Will, what's your option on this?
> > >
> > > Masahiro, many thx for looking into this.
> > >
> > > > I do not understand why you rush into the revert so quickly.
> > > > We are before -rc1.
> > > > We have 7 weeks before the 6.2 release
> > > > (assuming we will have up to -rc7).
> > > >
> > > > If we get -rc6 or -rc7 and we still do not
> > > > solve the issue, we should consider reverting it.
> > >
> > > Because it looked like a regression that makes it harder for people a=
nd
> > > CI systems to build and test mainline. To quote
> > > Documentation/process/handling-regressions.rst (
> > > https://docs.kernel.org/process/handling-regressions.html ):
> > >
> > > """
> > >  * Fix regressions within two or three days, if they are critical for
> > > some reason =E2=80=93 for example, if the issue is likely to affect m=
any users
> > > of the kernel series in question on all or certain architectures. Not=
e,
> > > this includes mainline, as issues like compile errors otherwise might
> > > prevent many testers or continuous integration systems from testing t=
he
> > > series.
> > > """
> > >
> > > I suspect that other distros rely on the build-id as well. Maybe I'm
> > > wrong with that, but even if only Fedora and derivatives are effected=
 it
> > > will annoy some people. Sure, each can apply the revert, but before t=
hat
> > > everyone affected will spend time debugging the issue first. A quick
> > > revert in mainline (with a reapply later together with a fix) thus IM=
HO
> > > is the most efficient approach afaics.
> > >
> >
> > Agree with Masahiro here.
> >
> > The issue seems to be caused by the fact that whichever object gets
> > linked first gets to decide the type of a section, and so the .notes
> > section will be of type NOTE if head.o gets linked first, or PROGBITS
> > otherwise. The latter PROGBITS type seems to be the result of the
> > compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.
> >
> > The hunk below fixes it for me, by avoiding notes emitted as PROGBITS.
> > I'll leave it to Masahiro to decide whether this should be fixed for
> > arm64 only or for all architectures, but I suspect the latter would be
> > most appropriate.
> >
> > Note that the kernel's rpm-pkg and binrpm-pkg targets seem to be
> > unaffected by this.
>
>
> Thanks for root-causing this.
>
>
> I like to fix this for all architectures because riscv is also broken.
>
> https://lore.kernel.org/lkml/20221224192751.810363-1-masahiroy@kernel.org=
/
>
>
>
>
> > diff --git a/arch/arm64/include/asm/assembler.h
> > b/arch/arm64/include/asm/assembler.h
> > index 376a980f2bad08bb..10a172601fe7f53f 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -818,7 +818,7 @@ alternative_endif
> >
> >  #ifdef GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT
> >  .macro emit_aarch64_feature_1_and, feat=3DGNU_PROPERTY_AARCH64_FEATURE=
_1_DEFAULT
> > -       .pushsection .note.gnu.property, "a"
> > +       .pushsection .note.gnu.property, "a", %note
> >         .align  3
> >         .long   2f - 1f
> >         .long   6f - 3f
>
>
> I did not fold this hunk in my patch.
>
> I compiled with CONFIG_ARM64_BTI_KERNEL=3Dy.
>
> .note.gnu.property section in VDSO was already NOTE
> without this hunk.
>

You're right - the VDSO is completely separate anyway, so this should
not be needed. It did seem to make a difference when I was playing
around with this, but I probably made a mistake somewhere, as this
macro is never used in .o files that are actually linked into vmlinux
