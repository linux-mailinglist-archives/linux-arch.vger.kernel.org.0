Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2F539E99
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350348AbiFAHmC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 03:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346393AbiFAHly (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 03:41:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423EC65B9;
        Wed,  1 Jun 2022 00:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0504CB8184A;
        Wed,  1 Jun 2022 07:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A7FC36AE2;
        Wed,  1 Jun 2022 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654069309;
        bh=x4AIh+8q3rwHWHDzV5VGJkJYLLDH7ynhZZhfLnEb+8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f38QWAmT3Lba2A3sBJrOOy+sbERvR52YnVrVyOkc70a+cykluMt/EwKYPWff9s4Q7
         fQb/vRHE7IhLBYWrF4Usip+yBpvWX5/ORzxQtuAb+tO+Ne3eAhJ1tdUojRy+fUqRPg
         3U2kltQxqVSIIt4GjUq8U8/lO2FOapPQCBsQDNPgDRYael1JXUlQ+iYOEzaWtTUVwD
         8Nm7VufhCXSC3v3giaD9D8v08nhbhzlICHQjufyUzGNPjA5Whbb8OJvMgxDJBTzCe9
         2XKbLDTOozmfFVp4SrJw0LqKPSQBG+RzNmRevVR8J4WoJD28DG3PBt9y1yjig3m1Ba
         B3ZkVzVvXhK0Q==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2ec42eae76bso9118007b3.10;
        Wed, 01 Jun 2022 00:41:49 -0700 (PDT)
X-Gm-Message-State: AOAM5309uqVIFwxbfTPDYvjqvJBugjzv7RPlQYus9Sy+FhSlDc5IOVEz
        yshUDsDikQ/xXC8U6fcyivEQ5WM/kPkjYPdXbT0=
X-Google-Smtp-Source: ABdhPJyjOONnyJpMnxwuZX80GyUim9f3pxgvQNDhKxagtl+rn8W3Zcqx8LrJG4sPZuMnrG1jw0k3rHUJoO3UT+XkIcs=
X-Received: by 2002:a81:6d8c:0:b0:30f:777:3eab with SMTP id
 i134-20020a816d8c000000b0030f07773eabmr1979670ywc.135.1654069308563; Wed, 01
 Jun 2022 00:41:48 -0700 (PDT)
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
 <CAAhV-H4_qqQtTp2=mJF=OV+qcKzA0j8SPWKRMR-LJgC0zNfatQ@mail.gmail.com> <832c3ae8-6c68-db2c-2c7f-0a5cd3071543@xen0n.name>
In-Reply-To: <832c3ae8-6c68-db2c-2c7f-0a5cd3071543@xen0n.name>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 1 Jun 2022 09:41:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Mg=Mr6aig25Kk9+Qf_E6DPMs0Yd-ozcvmY11kvCU74Q@mail.gmail.com>
Message-ID: <CAK8P3a1Mg=Mr6aig25Kk9+Qf_E6DPMs0Yd-ozcvmY11kvCU74Q@mail.gmail.com>
Subject: Re: [musl] Re: [GIT PULL] asm-generic changes for 5.19
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
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
        Ard Biesheuvel <ardb@kernel.org>,
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

On Wed, Jun 1, 2022 at 7:52 AM WANG Xuerui <kernel@xen0n.name> wrote:
> On 6/1/22 00:01, Huacai Chen wrote:
> > https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next
> > has been updated. Now this branch droped irqchip drivers and pci
> > drivers. But the existing irqchip drivers need some small adjustment
> > to avoid build errors [1], and I hope Marc can give an Acked-by.
> > Thanks.
> >
> > This branch can be built with defconfig and allmodconfig (except
> > drivers/platform/surface/aggregator/controller.c, because it requires
> > 8bit/16bit cmpxchg, which I was told to remove their support).
> >
> > [1] https://lore.kernel.org/lkml/e7cf33a170d0b4e98e53744f60dbf922@kernel.org/T/#t
>
> I see the loongarch-next HEAD has been updated and it's now purely arch
> changes aside from the two trivial irqchip cleanups. Some other changes
> to the v11 patchset [1] are included, but arguably minor enough to not
> invalidate previous Reviewed-by tags.

Very nice! I don't see exactly how the previous build bugs were addressed,
but I can confirm that this version builds. Regarding the two irqchip patches,
621e7015b529 ("irqchip/loongson-liointc: Fix build error for LoongArch") is
a good way to work around the mips oddity, and I have no problem taking
that through the asm-generic tree. The other one, f54b4a166023 ("irqchip:
 Adjust Kconfig for Loongson"), looks mostly unnecessary, and I think only
the LOONGSON_HTPIC change should be included here, while I would
leave out the COMPILE_TEST changes and instead have the driver
changes take care of making it possible to keep building it on x86, possibly
doing

        depends on MACH_LOONGSON64 || (COMPILE_TEST && ACPI)

in the future, after the loongarch64 ACPI support is merged.

> After some small tweaks:
>
> - adding "#include <asm/irqflags.h>" to arch/loongarch/include/asm/ptrace.h,
> - adding an arch/loongarch/include/uapi/asm/bpf_perf_event.h with the
> same content as arch/arm64's, and
> - adding "depends on ARM64 || X86" to
> drivers/platform/surface/aggregator/Kconfig,
>
> the current loongarch-next HEAD (commit
> 36552a24f70d21b7d63d9ef490561dbdc13798d7) now passes allmodconfig build
> (with CONFIG_WERROR disabled; my Gentoo-flavored gcc-12 seems to emit
> warnings on a few drivers).

The only one of these issues that I see is the surface aggregator one.
I think we can address all three as follow-up fixes after -rc1 if the port
gets merged and these are still required.

> The majority of userspace ABI has been stable for a few months already,
> after the addition of orig_a0 and removal of newfstatat; the necessary
> changes to switch to statx are already reviewed [2] / merged [3], and
> have been integrated into the LoongArch port of Gentoo for a while. Eric
> looked at the v11 and gave comments, and changes were made according to
> the suggestions, but it'd probably better to get a proper Reviewed-by.

Right.

> Among the rest of patches, I think maybe the EFI/boot protocol part
> still need approval/ack from the EFI maintainer. However because the
> current port isn't going to be able to run on any real hardware, maybe
> that part could be done later; I'm not sure if the unacknowledged EFI
> bits should be removed as well.

Ard, do you have any last comments on this?

> Arnd, what do you think about the current branch's status? Do Huacai
> need to send a quick final v12 to gather tags?

I think that would be good, yes.

        Arnd
