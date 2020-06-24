Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C001320716F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbgFXKqp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 06:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388516AbgFXKqp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 06:46:45 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C05C21473;
        Wed, 24 Jun 2020 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592995604;
        bh=6CP6qxsVEuOjCrX7ZFGs1e/lcJ7AgipGLIXDdr4Rzeo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OGlxeWyHhToHjXuphDyewr/kdrQyHf5oTZ1Rd8L/ZPUhRgE9Oqyr8efXiLjfy1vdv
         wlqn5JPvj4FaKpYJ6WF69t7WpuuIxuemrWnnyJi9jESZKOBx3OvSptVs38MLk1wikH
         QJHljm0q17sC5Q87Y9duCOxbj/6cpfnUcK6K3J/4=
Received: by mail-oi1-f178.google.com with SMTP id k4so1446032oik.2;
        Wed, 24 Jun 2020 03:46:44 -0700 (PDT)
X-Gm-Message-State: AOAM532yNUAWLMtyWZF+xQXb//ztaM67Sm+mft1/zJVMu5lCHJJuPvDR
        6Ue/+dhDNr+Z92ynXj75rcq1t/FTftbuTGI8L08=
X-Google-Smtp-Source: ABdhPJzCCS2lsuXiRvh7xwyfuolgtLv72Puo+dhV+VQ+cYin8FmuUsspPPdLhDZxpcjJd6l+eAK3mcwJ8/+MsyCgDxU=
X-Received: by 2002:aca:b241:: with SMTP id b62mr18670182oif.47.1592995603880;
 Wed, 24 Jun 2020 03:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org> <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook> <20200624104356.GA6134@willie-the-truck>
In-Reply-To: <20200624104356.GA6134@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 Jun 2020 12:46:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
Message-ID: <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 at 12:44, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 23, 2020 at 09:44:11PM -0700, Kees Cook wrote:
> > On Tue, Jun 23, 2020 at 08:31:42PM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> > > On 2020-06-23, Kees Cook wrote:
> > > > In preparation for adding --orphan-handling=warn to more architectures,
> > > > make sure unwanted sections don't end up appearing under the .init
> > > > section prefix that libstub adds to itself during objcopy.
> > > >
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > > drivers/firmware/efi/libstub/Makefile | 3 +++
> > > > 1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > > index 75daaf20374e..9d2d2e784bca 100644
> > > > --- a/drivers/firmware/efi/libstub/Makefile
> > > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > > @@ -66,6 +66,9 @@ lib-$(CONFIG_X86)               += x86-stub.o
> > > > CFLAGS_arm32-stub.o               := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > > CFLAGS_arm64-stub.o               := -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > >
> > > > +# Remove unwanted sections first.
> > > > +STUBCOPY_FLAGS-y         += --remove-section=.note.gnu.property
> > > > +
> > > > #
> > > > # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
> > > > # .bss section, so the .bss section of the EFI stub needs to be included in the
> > >
> > > arch/arm64/Kconfig enables ARM64_PTR_AUTH by default. When the config is on
> > >
> > > ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> > > branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI) := -mbranch-protection=pac-ret+leaf+bti
> > > else
> > > branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
> > > endif
> > >
> > > This option creates .note.gnu.property:
> > >
> > > % readelf -n drivers/firmware/efi/libstub/efi-stub.o
> > >
> > > Displaying notes found in: .note.gnu.property
> > >   Owner                Data size        Description
> > >   GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
> > >       Properties: AArch64 feature: PAC
> > >
> > > If .note.gnu.property is not desired in drivers/firmware/efi/libstub, specifying
> > > -mbranch-protection=none can override -mbranch-protection=pac-ret+leaf
> >
> > We want to keep the branch protection enabled. But since it's not a
> > "regular" ELF, we don't need to keep the property that identifies the
> > feature.
>
> For the kernel Image, how do we remove these sections? The objcopy flags
> in arch/arm64/boot/Makefile look both insufficient and out of date. My
> vmlinux ends up with both a ".notes" and a ".init.note.gnu.property"
> segment.
>

The latter is the fault of the libstub make rules, that prepend .init
to all section names.

I'm not sure if there is a point to having PAC and/or BTI in the EFI
stub, given that it runs under the control of the firmware, with its
memory mappings and PAC configuration etc.
