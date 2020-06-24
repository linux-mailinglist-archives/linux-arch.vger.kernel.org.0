Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EFC2074DE
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbgFXNtB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 09:49:01 -0400
Received: from foss.arm.com ([217.140.110.172]:51856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389590AbgFXNtB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 09:49:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F21631B;
        Wed, 24 Jun 2020 06:49:00 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E3913F6CF;
        Wed, 24 Jun 2020 06:48:57 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:48:55 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Collingbourne <pcc@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <20200624134854.GF25945@arm.com>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
 <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook>
 <20200624104356.GA6134@willie-the-truck>
 <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
 <20200624112647.GC6134@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624112647.GC6134@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 12:26:47PM +0100, Will Deacon wrote:
> On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> > On Wed, 24 Jun 2020 at 12:44, Will Deacon <will@kernel.org> wrote:
> > > On Tue, Jun 23, 2020 at 09:44:11PM -0700, Kees Cook wrote:
> > > > On Tue, Jun 23, 2020 at 08:31:42PM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> > > > > arch/arm64/Kconfig enables ARM64_PTR_AUTH by default. When the config is on
> > > > >
> > > > > ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> > > > > branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI) := -mbranch-protection=pac-ret+leaf+bti
> > > > > else
> > > > > branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
> > > > > endif
> > > > >
> > > > > This option creates .note.gnu.property:
> > > > >
> > > > > % readelf -n drivers/firmware/efi/libstub/efi-stub.o
> > > > >
> > > > > Displaying notes found in: .note.gnu.property
> > > > >   Owner                Data size        Description
> > > > >   GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
> > > > >       Properties: AArch64 feature: PAC
> > > > >
> > > > > If .note.gnu.property is not desired in drivers/firmware/efi/libstub, specifying
> > > > > -mbranch-protection=none can override -mbranch-protection=pac-ret+leaf
> > > >
> > > > We want to keep the branch protection enabled. But since it's not a
> > > > "regular" ELF, we don't need to keep the property that identifies the
> > > > feature.
> > >
> > > For the kernel Image, how do we remove these sections? The objcopy flags
> > > in arch/arm64/boot/Makefile look both insufficient and out of date. My
> > > vmlinux ends up with both a ".notes" and a ".init.note.gnu.property"
> > > segment.
> > >
> > 
> > The latter is the fault of the libstub make rules, that prepend .init
> > to all section names.
> 
> Hmm. I tried adding -mbranch-protection=none to arm64 cflags for the stub,
> but I still see this note in vmlinux. It looks like it comes in via the
> stub copy of lib-ctype.o, but I don't know why that would force the
> note. The cflags look ok to me [1] and I confirmed that the note is
> being generated by the compiler.
> 
> > I'm not sure if there is a point to having PAC and/or BTI in the EFI
> > stub, given that it runs under the control of the firmware, with its
> > memory mappings and PAC configuration etc.
> 
> Agreed, I just can't figure out how to get rid of the note.

Because this section is generated by the linker itself I think you might
have to send it to /DISCARD/ in the link, or strip it explicitly after
linking.

Cheers
---Dave
