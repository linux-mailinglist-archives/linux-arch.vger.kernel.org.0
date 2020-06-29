Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D51F20D3F2
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgF2TD3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgF2TD0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:03:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94700C031C40;
        Mon, 29 Jun 2020 12:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+IitMUk+eOYapugNWdcU2qNl/SJeRY/e+GCy2zsMLo8=; b=N+rbp9GAXyeaJr2JEOHz+UXKi
        RsSRxVTngHhTRvU12HFs410qqK0KgYvJnLV4c+gxMbCoh3lnabXdW68dUe+tiDxwUQf835ZcIukvO
        nP+iLDAsjH6047RD10Y8a3A+vLOoAIdwFz5UwQ2vjB/iPjCPwyjp8PTOsP1erptR/bqeZGFkElxUE
        YTaLVJEib0JGcCyLbw2ccxW1Y35fnPlTX4rz1m2859yaEtnKzdu6gF39mRrYiZLlsKQEKRCiINLWl
        z0QldW6EbOGfQyx1S0HxtBSebUfIaVLEDFaPlc4HlkrZS+WwFMrEEJcwTNdvYY2LcRWZaTe5c6mzz
        zvLOSXRqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33208)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jpz3m-00088W-9q; Mon, 29 Jun 2020 20:03:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jpz3k-0007MT-Qr; Mon, 29 Jun 2020 20:03:16 +0100
Date:   Mon, 29 Jun 2020 20:03:16 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/17] arm/build: Warn on orphan section placement
Message-ID: <20200629190316.GY1551@shell.armlinux.org.uk>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-15-keescook@chromium.org>
 <20200629155401.GB900899@rani.riverdale.lan>
 <20200629180703.GX1551@shell.armlinux.org.uk>
 <20200629181514.GA1046442@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629181514.GA1046442@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 02:15:14PM -0400, Arvind Sankar wrote:
> On Mon, Jun 29, 2020 at 07:07:04PM +0100, Russell King - ARM Linux admin wrote:
> > On Mon, Jun 29, 2020 at 11:54:01AM -0400, Arvind Sankar wrote:
> > > On Sun, Jun 28, 2020 at 11:18:37PM -0700, Kees Cook wrote:
> > > > We don't want to depend on the linker's orphan section placement
> > > > heuristics as these can vary between linkers, and may change between
> > > > versions. All sections need to be explicitly named in the linker
> > > > script.
> > > > 
> > > > Specifically, this would have made a recently fixed bug very obvious:
> > > > 
> > > > ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
> > > > 
> > > > Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
> > > > 
> > > > Add missing text stub sections .vfp11_veneer and .v4_bx.
> > > > 
> > > > Add debug sections explicitly.
> > > > 
> > > > Finally enable orphan section warning.
> > > 
> > > This is unrelated to this patch as such, but I noticed that ARM32/64 places
> > > the .got section inside .text -- is that expected on ARM?
> > 
> > Do you mean in general, in the kernel vmlinux, in the decompressor
> > vmlinux or ... ?
> > 
> 
> Sorry, in the kernel vmlinux. ARM_TEXT includes *(.got) for 32-bit, and
> the 64-bit vmlinux.lds.S includes it in .text as well. The decompressor
> for 32-bit keeps it separate for non-EFI stub kernel and puts it inside
> .data for EFI stub.

The main 32-bit kernel image doesn't use the .got - I don't think it
actually even exists.

The decompressor (non-EFI) uses the .got as a way of getting position
independence, and that must be part of the binary image at a fixed
offset from the .text section.  The decompressor self-fixes up the
GOT entries.

In the case of the decompressor being flashed and executed from NOR
flash, the decompressor must be built for the specific address(es)
that it will reside (which does away with the .got table.)

For EFI, it needs to be in the .data section (which is in that case
always a fixed offset from .text) so that it can be written to so the
fix-ups work.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
