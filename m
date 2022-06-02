Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B356E53BC43
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 18:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiFBQOy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiFBQOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 12:14:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF20DF61;
        Thu,  2 Jun 2022 09:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6595B81F7B;
        Thu,  2 Jun 2022 16:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90393C34115;
        Thu,  2 Jun 2022 16:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654186488;
        bh=ExZkpaJMlh5IV5m2XAR8t091YaQ6Aj1CTeb3KGHavU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gEnpAetn4OV5h2XvNdDgCQtnxx3n2BnU3x3c+cvu9h4Nbwb0Ahmgor2H3mHxibeaD
         3TYUYtUDgwYUHOq5xX+RPoFi2Xl4F5HE28hMj187wOxNjinB2+FKJpKyUv2pg/kjFI
         jc3gbUNqkdCZunkSkmoOv541sReVQN4sMrVw0qRediY+ndys8n7cxp2rg1WlZDCIbx
         al1ex/puD/qFnaiu6XEMz3g/pJNBSyrgIdAlyGlxaosfqqrqaTNWII+7bwSKsWJoZu
         eMRGZ0Elw8ChoBUg46WK0FYVmhg+cgxcrqtIBeD7WZf80PWGWxhv8WIC+G0K/VrqNA
         aB1z2F53SClig==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-f33f0f5b1dso7304315fac.8;
        Thu, 02 Jun 2022 09:14:48 -0700 (PDT)
X-Gm-Message-State: AOAM530M7y777jO18j+ufe8TBUi3VY8X5w3w1snRCkxdpD7fGUB5cgr2
        Gjv/+xRNZulUZnfWHxBRIbEBXpBV/HHgdOQq/Po=
X-Google-Smtp-Source: ABdhPJz4PemwUpOmHvnByGG51hsSPRTgHWdIHYmWrUoOWbF8WImiHoyVTApzqHUNHgPY+Z4TF1OqZZkLmJsFNk0kNcM=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr3245194oan.126.1654186487686; Thu, 02
 Jun 2022 09:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-12-chenhuacai@loongson.cn> <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
In-Reply-To: <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 2 Jun 2022 18:14:36 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE1Gg+jN0yGZCi86HQBPrtX=-EHjMW9Z9XxsobH=RS0LA@mail.gmail.com>
Message-ID: <CAMj1kXE1Gg+jN0yGZCi86HQBPrtX=-EHjMW9Z9XxsobH=RS0LA@mail.gmail.com>
Subject: Re: Steps forward for the LoongArch UEFI bringup patch? (was: Re:
 [PATCH V14 11/24] LoongArch: Add boot and setup routines)
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        WANG Xuerui <git@xen0n.name>, Yun Liu <liuyun@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Thu, 2 Jun 2022 at 16:09, WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi Ard,
>
> Sorry for sounding particularly rushed and I really don't like rushing
> things either, but as explained in the previous reply [1], what we want
> to do is mainly to get the arch/loongarch into mainline first,
> stabilizing an ABI surface already under heavy testing for many months;
> plus Huacai has removed the questioned kernel version string, and the
> Loongson-specific "boardinfo" sysfs file that doesn't really belong to
> /sys/firmware/efi.
>

OK, that is an improvement.

> So, would you please clarify and explain how Huacai and I could best
> proceed to hopefully get the *rest* of the port readied for a (late)
> merge window PR? Otherwise much of userspace development would have to
> shift target once more, and many Linux distros would have to carry and
> rebase this big patchset for another 2 months which is real churn.
>
> If some more background is necessary, let me explain a bit more about
> the LoongArch boot protocol peculiarities...
>
> For one thing, the standard EFI stub boot flow is a recent development,
> and has not shipped yet; all currently existing LoongArch systems
> actually implement the previous Loongson-specific boot protocol based on
> "struct bootparamsinterface", or BPI for short, that was carried over
> from the MIPS era. Systems with BPI firmware provide full EFI services
> too, but all pointers in BPI structs are virtual addresses, and the
> memory maps are not provided in the same way as their new firmware. In
> addition to that, all BPI systems launch Linux via a special GRUB2 that
> can only boot ELF files (so cannot chainload an EFI stub), and it's
> unclear whether directly booting an EFI stub would work, so the EFI stub
> logic is not invoked at all but SVAM still have to be executed somehow
> to ensure sanity. All of this means the SVAM oddity will eventually get
> in, regardless of whether we take it out now or not, if the BPI support
> is to be mainlined in the future.
>

This means the boot chain is still relying on the internal stub <->
kernel API, which is the reason I objected to previous revisions of
this series. You *cannot* call EFI services at boot or at runtime if
you don't boot via the EFI stub. You either implement EFI boot
correctly, or not at all.

Also, is calling SetVirtualAddressMap() actually needed? On other
architectures, we don't map EFI memory regions into the kernel address
space, but into a separate set of page tables that is only active on
the CPU that calls into the firmware, and only while the firmware call
is in progress. This address space can typically describe the 1:1
mapping that the firmware uses, making SVAM() entirely optional.

Another thing I don't understand is how LoongArch implements both ELF
and PE/COFF, as they cannot co-exist in the same executable. Will
there be a flag day when all bootloaders and kernels switch from one
mode to the other?

> For another thing, it seems Loongson really wanted to support the "PMON"
> use case that wouldn't provide full EFI services but sharing some logic
> with UEFI boot. PMON is one of the MIPS firmware varieties that Loongson
> has supported back in the days, and they seem to have ported it to
> LoongArch as well.
>

Having different boot methods and ABIs is fine. The thing I mainly
objected to is reusing the EFI code in Linux to implement a boot
method that is not EFI.

If PMON wants to boot the core kernel and provide another
memory/machine description than UEFI/ACPI, LoongArch is free to
implement that. But any dependencies in the LoongArch boot code on
implementation details in Linux's EFI layer that it re-exports via an
alternative boot ABI are a big problem, as it turns those
implementation details into external ABI for all architectures that
implement EFI.

> For this, I don't know if Huacai should really just leave those
> modification in the downstream fork to keep the upstream Linux clean of
> such hacks, because to some degree dealing with such notoriety is life,
> it seems to me. I think at this point Huacai would cooperate and tweak
> the patch to get rid of the SVAM and other nonstandard bits as much as
> possible, and I'll help him where necessary too.
>

I don't want to be the one standing in your way, and I understand the
desire to get this merged for the user space side of things. So
perhaps it is better to merge this without the EFI support, and take
another cycle to implement this properly across all the other
components as well.
