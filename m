Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5EA207163
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbgFXKoE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 06:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388421AbgFXKoD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 06:44:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC61F20644;
        Wed, 24 Jun 2020 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592995443;
        bh=mdTAfhkDJYCASKqPut+490INXl3yMYXb8omd1AxIpR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tw0YgqlBzSkYR/8dx7x7agmXiX8h/g6EpRmEO/a+1MwBTs1pSuTCrSWZC5vI/je1Y
         B8zTuAPx69gOyfVPgWUiRzAt6Ps2l+kX6KH9h9vy5X05ox3kvM9GqlQXGjW5kCT8lk
         WRLAu0eli8TOtr0mprB99/5d9B7o1GRFfm+BjnNo=
Date:   Wed, 24 Jun 2020 11:43:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <20200624104356.GA6134@willie-the-truck>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
 <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006232143.66828CD3@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 23, 2020 at 09:44:11PM -0700, Kees Cook wrote:
> On Tue, Jun 23, 2020 at 08:31:42PM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> > On 2020-06-23, Kees Cook wrote:
> > > In preparation for adding --orphan-handling=warn to more architectures,
> > > make sure unwanted sections don't end up appearing under the .init
> > > section prefix that libstub adds to itself during objcopy.
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > drivers/firmware/efi/libstub/Makefile | 3 +++
> > > 1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > > index 75daaf20374e..9d2d2e784bca 100644
> > > --- a/drivers/firmware/efi/libstub/Makefile
> > > +++ b/drivers/firmware/efi/libstub/Makefile
> > > @@ -66,6 +66,9 @@ lib-$(CONFIG_X86)		+= x86-stub.o
> > > CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > > 
> > > +# Remove unwanted sections first.
> > > +STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
> > > +
> > > #
> > > # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
> > > # .bss section, so the .bss section of the EFI stub needs to be included in the
> > 
> > arch/arm64/Kconfig enables ARM64_PTR_AUTH by default. When the config is on
> > 
> > ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> > branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI) := -mbranch-protection=pac-ret+leaf+bti
> > else
> > branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
> > endif
> > 
> > This option creates .note.gnu.property:
> > 
> > % readelf -n drivers/firmware/efi/libstub/efi-stub.o
> > 
> > Displaying notes found in: .note.gnu.property
> >   Owner                Data size        Description
> >   GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
> >       Properties: AArch64 feature: PAC
> > 
> > If .note.gnu.property is not desired in drivers/firmware/efi/libstub, specifying
> > -mbranch-protection=none can override -mbranch-protection=pac-ret+leaf
> 
> We want to keep the branch protection enabled. But since it's not a
> "regular" ELF, we don't need to keep the property that identifies the
> feature.

For the kernel Image, how do we remove these sections? The objcopy flags
in arch/arm64/boot/Makefile look both insufficient and out of date. My
vmlinux ends up with both a ".notes" and a ".init.note.gnu.property"
segment.

Will
