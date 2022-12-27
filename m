Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3965698A
	for <lists+linux-arch@lfdr.de>; Tue, 27 Dec 2022 11:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiL0Kqg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Dec 2022 05:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0Kqf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Dec 2022 05:46:35 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616EF8FCB;
        Tue, 27 Dec 2022 02:46:34 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2BRAk7wg030969;
        Tue, 27 Dec 2022 19:46:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2BRAk7wg030969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672137968;
        bh=hAT2+icp0FeS8KOgo46qo7t6Jef4JstaJu/ndZaqtFg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fEOpxgS2x2gxsFd1RrBk9e4q/yj03wiP6CeZRGPiTxBMRfiI1DJa6Aa180cSLf9ib
         NtyHili+AAtXemeTM7Lo79IHeyx+Ce+CuLzDqwbMbHpPqEBic8KqYINcdDlMO+/cIm
         5psXSGGGbBPDe/n6kUvta0QZZNvtmslpW7eK+QcSt030pzzlB+j4GuE17bL5oMu6L0
         9JFWWyH4RIzvA+I+amTEsTbr4NCLIF0D+NQG0FNt5tCn+v/5JflK8FJEQ6l+1BDRBP
         TsZkY4AKooI5bvmvZdUPQdaazSvBQI4NxR2eeX4qo++fEnUkJPlQX9bPm691ZtHlJW
         yMWBIgz+0s7UA==
X-Nifty-SrcIP: [209.85.167.47]
Received: by mail-lf1-f47.google.com with SMTP id m6so8715473lfj.11;
        Tue, 27 Dec 2022 02:46:08 -0800 (PST)
X-Gm-Message-State: AFqh2kryuw0ArUFp37TlADD0yqiodoXBs4o150GGcHHAONOteeNPJAB1
        8YTSo3vQtlFBkKwUWfMqRZfshIbWURllqdaimOQ=
X-Google-Smtp-Source: AMrXdXuE4MnsgNK7LbgNeBTPEXqbxTBO86saMESr9nvBj5yzAt2imNQX944Tj4ygTEzqgMUKgV9rSrjqAoEVs1kFEYY=
X-Received: by 2002:a05:6512:260f:b0:4cb:88c:c798 with SMTP id
 bt15-20020a056512260f00b004cb088cc798mr262689lfb.227.1672137966893; Tue, 27
 Dec 2022 02:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20221224192751.810363-1-masahiroy@kernel.org> <Y6hptEk8FmISixLS@spud>
 <CAK7LNAT39aZEw=0209ovYZ2kxtOaA2a51=XD9=LqYHjkTOEK4g@mail.gmail.com> <Y6oZ40fEArg7MJGo@spud>
In-Reply-To: <Y6oZ40fEArg7MJGo@spud>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 27 Dec 2022 19:45:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkWU+ViAQ6QaTCivOuWFzQUiGQg3Fo9HqPOKymcOhOGA@mail.gmail.com>
Message-ID: <CAK7LNARkWU+ViAQ6QaTCivOuWFzQUiGQg3Fo9HqPOKymcOhOGA@mail.gmail.com>
Subject: Re: [PATCH] arch: fix broken BuildID for arm64 and riscv
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Dennis Gilmore <dennis@ausil.us>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 27, 2022 at 7:02 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Masahiro,
>
> On Tue, Dec 27, 2022 at 04:06:35AM +0900, Masahiro Yamada wrote:
> > On Mon, Dec 26, 2022 at 12:18 AM Conor Dooley <conor@kernel.org> wrote:
> > > On Sun, Dec 25, 2022 at 04:27:51AM +0900, Masahiro Yamada wrote:
> > > > Dennis Gilmore reports that the BuildID is missing in the arm64 vmlinux
> > > > since commit 994b7ac1697b ("arm64: remove special treatment for the
> > > > link order of head.o").
> > > >
> > > > The issue is that the type of .notes section, which contains the BuildID,
> > > > changed from NOTES to PROGBITS.
> > > >
> > > > Ard Biesheuvel figured out that whichever object gets linked first gets
> > > > to decide the type of a section, and the PROGBITS type is the result of
> > > > the compiler emitting .note.GNU-stack as PROGBITS rather than NOTE.
> > > >
> > > > While Ard provided a fix for arm64, I want to fix this globally because
> > > > the same issue is happening on riscv since commit 2348e6bf4421 ("riscv:
> > > > remove special treatment for the link order of head.o"). This problem
> > > > will happen in general for other architectures if they start to drop
> > > > unneeded entries from scripts/head-object-list.txt.
> > > >
> > > > Discard .note.GNU-stack in include/asm-generic/vmlinux.lds.h.
> > > >
> > > > riscv needs to change its linker script so that DISCARDS comes before
> > > > the .notes section.
> > >
> > > No idea why I decided to look at patchwork today, but this seems to
> > > break the build on RISC-V, there's a whole load of the following in the
> > > output:
> > > `.LPFE4' referenced in section `__patchable_function_entries' of kernel/trace/trace_selftest_dynamic.o: defined in discarded section `.text.exit' of kernel/trace/trace_selftest_dynamic.o
> > >
> > > I assume that's what's doing it, but given the day that's in it - I
> > > haven't looked into this any further, nor gone and fished the logs out of
> > > the builder.
> >
> >
> > arch/riscv/kernel/vmlinux.lds.S clearly says:
> > /* we have to discard exit text and such at runtime, not link time */
> >
> > riscv already relies on the linker not discarding EXIT_{TEXT,DATA}
> > so riscv should define RUNTIME_DISCARD_EXIT like x86, arm64.
>
> Huh, fair enough. The diff for that appears to be trivial, but I was not
> able to correctly determine a fixes tag. I may have erred in my
> history-diving, but it's a wee bit hard to determine the correct fixes
> tag. That comment about runtime discards appears to date back to
> commit fbe934d69eb7 ("RISC-V: Build Infrastructure") in 2017 -
> apparently pre-dating the addition of the define in the first place.
>
> Commit 84d5f77fc2ee ("x86, vmlinux.lds: Add RUNTIME_DISCARD_EXIT to
> generic DISCARDS") added it to x86 but not to arm64 - but it seems like
> it was added to arm during a later reword. Does that make 84d5f77fc2ee
> the correct one to mark it as a fix of & riscv was just overlooked when
> the define was added?
>


You do not need to add the Fixes tag.

Currently, it is working, but it turns out bad
only when somebody moves "DISCARDS" up in the linker script.







> > Anyway, I came up with a simpler patch, so I do not need to
> > touch around arch linker scripts.
> >
> > I sent v2.
> > https://lore.kernel.org/lkml/20221226184537.744960-1-masahiroy@kernel.org/T/#u
>
> Sweet, thanks. Hopefully the automation likes that version better :)
>


-- 
Best Regards
Masahiro Yamada
