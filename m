Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC6053AAA1
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 18:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349275AbiFAQBi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiFAQBh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 12:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED6A309C;
        Wed,  1 Jun 2022 09:01:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9002361374;
        Wed,  1 Jun 2022 16:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86AFC341C0;
        Wed,  1 Jun 2022 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654099294;
        bh=oA+EUqddOP9mSF3/WqgqRAd5IBzHc7jbgAQPJ2l2RH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QaqrFaTf/odCGUm27lt5npWIE7gB1Xw7LWPnb8j7jaI/VFxMWGl/mYi8lnzQHTCp/
         vnsI9Z6JQtQ4dtIJrmwrNPjXOHFKSFoCdOIO8mowwPiLwHe/TZ/VYUnE/A2bi7GLNZ
         oXgycfVfzqv4swm+rb9bgW0YUlEk/lgGUqyYhilg/bgAJ03WZCG8tub22FZFZA+KxU
         jEchBXNDKDkU1RxGZqp/v8MmYhEaD2tP+lQbjcv9kjfkgmUNo1jhmhUZ1oMKuGtlfD
         16LevERUy1nEMw2XrLzOAv7SFiVWF+QznrHJO62PlZenU8orLZLDx6Xk4ZLy4EQMQX
         iGbynwcxiPfhQ==
Received: by mail-oi1-f181.google.com with SMTP id w130so3283283oig.0;
        Wed, 01 Jun 2022 09:01:34 -0700 (PDT)
X-Gm-Message-State: AOAM531yQW51zcs2xK/j66B7Dj0Vsy/awZmjuWFkoFCyxxdK04bAmFxp
        K0SxLNGiH20XBE9BgXQp2N5pYM7tQ0FLeRnRdUk=
X-Google-Smtp-Source: ABdhPJzYXHkct04PqnXR7IbV4sXZEq1LtbCs2723oYWisXmZd95HwrBLMIM/nzioeRjFTUQZo298T5EkZLhn/JA3SzA=
X-Received: by 2002:a05:6808:300e:b0:32c:425e:df34 with SMTP id
 ay14-20020a056808300e00b0032c425edf34mr84856oib.126.1654099293834; Wed, 01
 Jun 2022 09:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2_52JPnBWNvTTkFVwLxPAa7=NaQ4whwC1UeH_NYHeUKQ@mail.gmail.com>
 <CAK8P3a0SpU1n+29KQxzKnPRvzmDE=L0V9RUpKxhemv=74kevcQ@mail.gmail.com>
 <df5c406c-eec6-c340-2847-49670b7fe8bf@xen0n.name> <CAK8P3a3awFdB1-G65DC38NBuSTvo6SvFTaS0m9YBxunHjHjQvQ@mail.gmail.com>
 <CAAhV-H6sNr-yo8brBFtzziH6k9Tby0dFp7yehK55SfH5HjZ8hQ@mail.gmail.com>
 <358025d1-28e6-708b-d23d-3f22ae12a800@xen0n.name> <CAK8P3a1ge2bZS13ahm_LdO3jEcbtR4w3do-gLjggKvppqnBDkw@mail.gmail.com>
 <CAAhV-H5NCUpR6aBtR9d7c9vW2KiHpk3iFQxj7BeTSS0boMz8PQ@mail.gmail.com>
 <CAK8P3a2JgrW5a7_udCUWen-gOnJgVeRV2oAd-uq4VSuYkFUqNQ@mail.gmail.com>
 <CAAhV-H6wfmdcV=a4L43dcabsvO+JbOebCX3_6PV+p85NjA9qhQ@mail.gmail.com>
 <CAK8P3a0c_tbHov_b6cz-_Tj6VD3OWLwpGJf_2rj-nitipSKdYQ@mail.gmail.com>
 <CAAhV-H4_qqQtTp2=mJF=OV+qcKzA0j8SPWKRMR-LJgC0zNfatQ@mail.gmail.com>
 <832c3ae8-6c68-db2c-2c7f-0a5cd3071543@xen0n.name> <CAK8P3a1Mg=Mr6aig25Kk9+Qf_E6DPMs0Yd-ozcvmY11kvCU74Q@mail.gmail.com>
In-Reply-To: <CAK8P3a1Mg=Mr6aig25Kk9+Qf_E6DPMs0Yd-ozcvmY11kvCU74Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Jun 2022 18:01:22 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFijHBnQVPR=O85u78n6A1Ev_24k=vns4yPQ=d-aiAC8Q@mail.gmail.com>
Message-ID: <CAMj1kXFijHBnQVPR=O85u78n6A1Ev_24k=vns4yPQ=d-aiAC8Q@mail.gmail.com>
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        musl@lists.openwall.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 1 Jun 2022 at 09:41, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Jun 1, 2022 at 7:52 AM WANG Xuerui <kernel@xen0n.name> wrote:
> > On 6/1/22 00:01, Huacai Chen wrote:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
> > > has been updated. Now this branch droped irqchip drivers and pci
> > > drivers. But the existing irqchip drivers need some small adjustment
> > > to avoid build errors [1], and I hope Marc can give an Acked-by.
> > > Thanks.
> > >
> > > This branch can be built with defconfig and allmodconfig (except
> > > drivers/platform/surface/aggregator/controller.c, because it requires
> > > 8bit/16bit cmpxchg, which I was told to remove their support).
> > >
> > > [1] https://lore.kernel.org/lkml/e7cf33a170d0b4e98e53744f60dbf922@kernel.org/T/#t
> >
> > I see the loongarch-next HEAD has been updated and it's now purely arch
> > changes aside from the two trivial irqchip cleanups. Some other changes
> > to the v11 patchset [1] are included, but arguably minor enough to not
> > invalidate previous Reviewed-by tags.
>
> Very nice! I don't see exactly how the previous build bugs were addressed,
> but I can confirm that this version builds. Regarding the two irqchip patches,
> 621e7015b529 ("irqchip/loongson-liointc: Fix build error for LoongArch") is
> a good way to work around the mips oddity, and I have no problem taking
> that through the asm-generic tree. The other one, f54b4a166023 ("irqchip:
>  Adjust Kconfig for Loongson"), looks mostly unnecessary, and I think only
> the LOONGSON_HTPIC change should be included here, while I would
> leave out the COMPILE_TEST changes and instead have the driver
> changes take care of making it possible to keep building it on x86, possibly
> doing
>
>         depends on MACH_LOONGSON64 || (COMPILE_TEST && ACPI)
>
> in the future, after the loongarch64 ACPI support is merged.
>
> > After some small tweaks:
> >
> > - adding "#include <asm/irqflags.h>" to arch/loongarch/include/asm/ptrace.h,
> > - adding an arch/loongarch/include/uapi/asm/bpf_perf_event.h with the
> > same content as arch/arm64's, and
> > - adding "depends on ARM64 || X86" to
> > drivers/platform/surface/aggregator/Kconfig,
> >
> > the current loongarch-next HEAD (commit
> > 36552a24f70d21b7d63d9ef490561dbdc13798d7) now passes allmodconfig build
> > (with CONFIG_WERROR disabled; my Gentoo-flavored gcc-12 seems to emit
> > warnings on a few drivers).
>
> The only one of these issues that I see is the surface aggregator one.
> I think we can address all three as follow-up fixes after -rc1 if the port
> gets merged and these are still required.
>
> > The majority of userspace ABI has been stable for a few months already,
> > after the addition of orig_a0 and removal of newfstatat; the necessary
> > changes to switch to statx are already reviewed [2] / merged [3], and
> > have been integrated into the LoongArch port of Gentoo for a while. Eric
> > looked at the v11 and gave comments, and changes were made according to
> > the suggestions, but it'd probably better to get a proper Reviewed-by.
>
> Right.
>
> > Among the rest of patches, I think maybe the EFI/boot protocol part
> > still need approval/ack from the EFI maintainer. However because the
> > current port isn't going to be able to run on any real hardware, maybe
> > that part could be done later; I'm not sure if the unacknowledged EFI
> > bits should be removed as well.
>
> Ard, do you have any last comments on this?
>

It would be nice if the questions I raised against the previous
revision (v11) were addressed (or at least answered) first. In
general, I think this is feeling a bit rushed and IMHO we should
probably defer this to the next cycle.
