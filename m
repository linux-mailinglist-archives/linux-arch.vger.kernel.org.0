Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813AC654096
	for <lists+linux-arch@lfdr.de>; Thu, 22 Dec 2022 13:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiLVMBg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Dec 2022 07:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiLVMBQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Dec 2022 07:01:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C6E33CF4;
        Thu, 22 Dec 2022 03:53:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E18FB81D30;
        Thu, 22 Dec 2022 11:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9314C433F2;
        Thu, 22 Dec 2022 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671710016;
        bh=dwRgGhvkMsp229h+rO5gqtrhdXxrFhA631KDq6GCycY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WifJDlvxmHu39qI6F+fDSJ5b1cObtwXpINE6FUABMBEy0GM/b8I4BYqJKUOvrl/Ws
         SpRbSnqddfHC9RohYxVrBf2oZ9WyphQhtOb0T+h3nYNZm4/SNZEYTm31Xkak0N5kIr
         WTvYcPiVEaufsYUtmZj2LiyCI1Q5setZj6fTkkjBcIxfmkmvEu0qH/mwrx1wR/kg3k
         v+I7niKR0Iwa1jrd03hAzn6pCnLFZHrk3eELuFxwOam/vXZRhWSY1ckDQWqZdLyaMP
         XYtZns5zGWWcIkQthsXtJb5UKcGdymf10jv1nxZDn00mvP+wg0v9kPSsFobNVRfaw3
         xdK/9aOin6M1g==
Received: by mail-lf1-f46.google.com with SMTP id z26so2366639lfu.8;
        Thu, 22 Dec 2022 03:53:36 -0800 (PST)
X-Gm-Message-State: AFqh2kqXAvfO2rQtRdg8RrjNzaPGeu1Xf8khoMGgY0bAZ5mTznuXLjRG
        pa4v6DbgJfZVhjhkj2UVQJhXDYltSFdZEqE1XeQ=
X-Google-Smtp-Source: AMrXdXvrt9G9hSeWg+GElY+cYYoH6hbx0Lc+3N6i5piAcI92l/HeoPS1Z81DFG39t0aA0cn/00XO87rpCaoY9xDesuQ=
X-Received: by 2002:a05:6512:15a3:b0:4bc:bdf5:f163 with SMTP id
 bp35-20020a05651215a300b004bcbdf5f163mr310195lfb.583.1671710014879; Thu, 22
 Dec 2022 03:53:34 -0800 (PST)
MIME-Version: 1.0
References: <CAABkxwuQoz1CTbyb57n0ZX65eSYiTonFCU8-LCQc=74D=xE=rA@mail.gmail.com>
 <26bd2928-9d62-32b3-4f9f-9dd9293cefeb@leemhuis.info> <CAK7LNAQ5VVRdrewtxrBdw561LL=yY8fdr=i1e7pp4DRht=r_Ww@mail.gmail.com>
 <0ab93345-18e1-15c9-a4a3-066ea1cd862b@leemhuis.info>
In-Reply-To: <0ab93345-18e1-15c9-a4a3-066ea1cd862b@leemhuis.info>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Dec 2022 12:53:23 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE+LBOBavOre1O8LTGPCmB8m58fbfo92Sx4WukyNAur-A@mail.gmail.com>
Message-ID: <CAMj1kXE+LBOBavOre1O8LTGPCmB8m58fbfo92Sx4WukyNAur-A@mail.gmail.com>
Subject: Re: BUG: arm64: missing build-id from vmlinux
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
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

On Wed, 21 Dec 2022 at 17:29, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 21.12.22 16:39, Masahiro Yamada wrote:
> > On Wed, Dec 21, 2022 at 5:23 PM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> Hi, this is your Linux kernel regression tracker. CCing the regression
> >> mailing list, as it should be in the loop for all regressions:
> >> https://docs.kernel.org/admin-guide/reporting-regressions.html
> >>
> >> On 18.12.22 21:51, Dennis Gilmore wrote:
> >>> The changes in https://lore.kernel.org/linux-arm-kernel/166783716442.=
32724.935158280857906499.b4-ty@kernel.org/T/
> >>> result in vmlinux no longer having a build-id.
> >>
> >> FWIW, that's 994b7ac1697b ("arm64: remove special treatment for the li=
nk
> >> order of head.o") from Masahiro merged through Will this cycle.
> >>
> >>> At the least, this
> >>> causes rpm builds to fail. Reverting the patch does bring back a
> >>> build-id, but there may be a different way to fix the regression
> >>
> >> Makes me wonder if other distros or CIs relying on the build-id are
> >> broken, too.
> >>
> >> Anyway, the holiday season is upon us, hence I also wonder if it would
> >> be best to revert above change quickly and leave further debugging for=
 2023.
> >>
> >> Masahiro, Will, what's your option on this?
>
> Masahiro, many thx for looking into this.
>
> > I do not understand why you rush into the revert so quickly.
> > We are before -rc1.
> > We have 7 weeks before the 6.2 release
> > (assuming we will have up to -rc7).
> >
> > If we get -rc6 or -rc7 and we still do not
> > solve the issue, we should consider reverting it.
>
> Because it looked like a regression that makes it harder for people and
> CI systems to build and test mainline. To quote
> Documentation/process/handling-regressions.rst (
> https://docs.kernel.org/process/handling-regressions.html ):
>
> """
>  * Fix regressions within two or three days, if they are critical for
> some reason =E2=80=93 for example, if the issue is likely to affect many =
users
> of the kernel series in question on all or certain architectures. Note,
> this includes mainline, as issues like compile errors otherwise might
> prevent many testers or continuous integration systems from testing the
> series.
> """
>
> I suspect that other distros rely on the build-id as well. Maybe I'm
> wrong with that, but even if only Fedora and derivatives are effected it
> will annoy some people. Sure, each can apply the revert, but before that
> everyone affected will spend time debugging the issue first. A quick
> revert in mainline (with a reapply later together with a fix) thus IMHO
> is the most efficient approach afaics.
>

Agree with Masahiro here.

The issue seems to be caused by the fact that whichever object gets
linked first gets to decide the type of a section, and so the .notes
section will be of type NOTE if head.o gets linked first, or PROGBITS
otherwise. The latter PROGBITS type seems to be the result of the
compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.

The hunk below fixes it for me, by avoiding notes emitted as PROGBITS.
I'll leave it to Masahiro to decide whether this should be fixed for
arm64 only or for all architectures, but I suspect the latter would be
most appropriate.

Note that the kernel's rpm-pkg and binrpm-pkg targets seem to be
unaffected by this.

diff --git a/arch/arm64/include/asm/assembler.h
b/arch/arm64/include/asm/assembler.h
index 376a980f2bad08bb..10a172601fe7f53f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -818,7 +818,7 @@ alternative_endif

 #ifdef GNU_PROPERTY_AARCH64_FEATURE_1_DEFAULT
 .macro emit_aarch64_feature_1_and, feat=3DGNU_PROPERTY_AARCH64_FEATURE_1_D=
EFAULT
-       .pushsection .note.gnu.property, "a"
+       .pushsection .note.gnu.property, "a", %note
        .align  3
        .long   2f - 1f
        .long   6f - 3f
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.ld=
s.S
index 4c13dafc98b8400f..8a8044dea71b0609 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -160,6 +160,7 @@ SECTIONS
        /DISCARD/ : {
                *(.interp .dynamic)
                *(.dynsym .dynstr .hash .gnu.hash)
+               *(.note.GNU-stack) # emitted as PROGBITS
        }

        . =3D KIMAGE_VADDR;
