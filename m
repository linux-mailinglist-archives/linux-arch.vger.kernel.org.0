Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51D4207202
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389223AbgFXL0z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 07:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388811AbgFXL0z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 07:26:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2917020836;
        Wed, 24 Jun 2020 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592998014;
        bh=0UmukP6NVeEd+zs9QbZciKhf63orfAMQP6x99v2ThjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaJFnJBJH6v57vh4k4qpqczHZE+gAEuxHL0D7vQKZQV7498wW0m4uJi1n74icYaZA
         4pEeFLTVg9u3esVOG13VCDEP7R/rDl5jdIk3cq65wbNF6TsH1UVIJvzqGffQpDl5ff
         dRwYJhIecRl6FOQtcWKDOiGr4iahuuAGRSV4kBsU=
Date:   Wed, 24 Jun 2020 12:26:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <20200624112647.GC6134@willie-the-truck>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
 <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook>
 <20200624104356.GA6134@willie-the-truck>
 <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> On Wed, 24 Jun 2020 at 12:44, Will Deacon <will@kernel.org> wrote:
> > On Tue, Jun 23, 2020 at 09:44:11PM -0700, Kees Cook wrote:
> > > On Tue, Jun 23, 2020 at 08:31:42PM -0700, 'Fangrui Song' via Clang Bu=
ilt Linux wrote:
> > > > arch/arm64/Kconfig enables ARM64_PTR_AUTH by default. When the conf=
ig is on
> > > >
> > > > ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> > > > branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI) :=3D -mb=
ranch-protection=3Dpac-ret+leaf+bti
> > > > else
> > > > branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) :=3D -mbranc=
h-protection=3Dpac-ret+leaf
> > > > endif
> > > >
> > > > This option creates .note.gnu.property:
> > > >
> > > > % readelf -n drivers/firmware/efi/libstub/efi-stub.o
> > > >
> > > > Displaying notes found in: .note.gnu.property
> > > >   Owner                Data size        Description
> > > >   GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
> > > >       Properties: AArch64 feature: PAC
> > > >
> > > > If .note.gnu.property is not desired in drivers/firmware/efi/libstu=
b, specifying
> > > > -mbranch-protection=3Dnone can override -mbranch-protection=3Dpac-r=
et+leaf
> > >
> > > We want to keep the branch protection enabled. But since it's not a
> > > "regular" ELF, we don't need to keep the property that identifies the
> > > feature.
> >
> > For the kernel Image, how do we remove these sections? The objcopy flags
> > in arch/arm64/boot/Makefile look both insufficient and out of date. My
> > vmlinux ends up with both a ".notes" and a ".init.note.gnu.property"
> > segment.
> >
>=20
> The latter is the fault of the libstub make rules, that prepend .init
> to all section names.

Hmm. I tried adding -mbranch-protection=3Dnone to arm64 cflags for the stub,
but I still see this note in vmlinux. It looks like it comes in via the
stub copy of lib-ctype.o, but I don't know why that would force the
note. The cflags look ok to me [1] and I confirmed that the note is
being generated by the compiler.

> I'm not sure if there is a point to having PAC and/or BTI in the EFI
> stub, given that it runs under the control of the firmware, with its
> memory mappings and PAC configuration etc.

Agreed, I just can't figure out how to get rid of the note.

Will

[1] -mlittle-endian -DKASAN_SHADOW_SCALE_SHIFT=3D3 -Qunused-arguments -Wall=
 -Wundef -Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -f=
no-common -fshort-wchar -fno-PIE -Werror=3Dimplicit-function-declaration -W=
error=3Dimplicit-int -Wno-format-security -std=3Dgnu89 --target=3Daarch64-l=
inux-gnu --prefix=3D/usr/local/google/home/willdeacon/bin/ --gcc-toolchain=
=3D/usr/local/google/home/willdeacon -no-integrated-as -Werror=3Dunknown-wa=
rning-option -mgeneral-regs-only -DCONFIG_CC_HAS_K_CONSTRAINT=3D1 -fno-asyn=
chronous-unwind-tables -mbranch-protection=3Dpac-ret+leaf+bti -Wa,-march=3D=
armv8.3-a -DKASAN_SHADOW_SCALE_SHIFT=3D3 -fno-delete-null-pointer-checks -W=
no-address-of-packed-member -O2 -Wframe-larger-than=3D2048 -fstack-protecto=
r-strong -Wno-format-invalid-specifier -Wno-gnu -mno-global-merge -Wno-unus=
ed-const-variable -fno-omit-frame-pointer -fno-optimize-sibling-calls -g -W=
declaration-after-statement -Wvla -Wno-pointer-sign -Wno-array-bounds -fno-=
strict-overflow -fno-merge-all-constants -fno-stack-check -Werror=3Ddate-ti=
me -Werror=3Dincompatible-pointer-types -fmacro-prefix-map=3D./=3D -Wno-ini=
tializer-overrides -Wno-format -Wno-sign-compare -Wno-format-zero-length -W=
no-tautological-constant-out-of-range-compare -fpie -mbranch-protection=3Dn=
one -I./scripts/dtc/libfdt -Os -DDISABLE_BRANCH_PROFILING -include ./driver=
s/firmware/efi/libstub/hidden.h -D__NO_FORTIFY -ffreestanding -fno-stack-pr=
otector -fno-addrsig -D__DISABLE_EXPORTS    -DKBUILD_MODFILE=3D'"drivers/fi=
rmware/efi/libstub/lib-ctype"' -DKBUILD_BASENAME=3D'"lib_ctype"' -DKBUILD_M=
ODNAME=3D'"lib_ctype"' -c -o drivers/firmware/efi/libstub/lib-ctype.o lib/c=
type.c
