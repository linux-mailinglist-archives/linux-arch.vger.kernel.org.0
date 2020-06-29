Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3749520E4A6
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 00:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgF2V1j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 17:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgF2Smo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:42:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABD4C031C74;
        Mon, 29 Jun 2020 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5qVKDp30/o2rhfTCB6YKi/X0MnGqhZlFhKf1/sMhnOc=; b=CgyZRCI4LA3ZIBmBTLhhJaCjB
        v+dLBN+EIMBJ+kp5cXefs7t3bDeFQwm1dVq1GicK/1jVj7WRwJc3dnu1mm4R0BFdlkhXP5ZsMNvqM
        585hpcaQtg7rdkcssVVSfAhHri4VeOT2gV3Z9yepFXNURJOoPR10+80dX2RukN013cTiMNVU37aqw
        fEasyRNBT497sRnoX2sEPoIy3v0kBHvjMQhbC34LtZG+YGjzoZpsXllkkZcEN/0rG8qJx3Z+Cn7y7
        m02by0DGgYu5kRUuQo2fynWL4sM9hJC4SdiPwI3AdJoz5rbUottEx4Avv0VVcnZc/DR7sLTgb7jJm
        xqEe+rQzA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33188)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jpyBO-00086P-1w; Mon, 29 Jun 2020 19:07:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jpyBM-0007KD-3O; Mon, 29 Jun 2020 19:07:04 +0100
Date:   Mon, 29 Jun 2020 19:07:04 +0100
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
Message-ID: <20200629180703.GX1551@shell.armlinux.org.uk>
References: <20200629061840.4065483-1-keescook@chromium.org>
 <20200629061840.4065483-15-keescook@chromium.org>
 <20200629155401.GB900899@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629155401.GB900899@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 29, 2020 at 11:54:01AM -0400, Arvind Sankar wrote:
> On Sun, Jun 28, 2020 at 11:18:37PM -0700, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly named in the linker
> > script.
> > 
> > Specifically, this would have made a recently fixed bug very obvious:
> > 
> > ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'
> > 
> > Discard unneeded sections .iplt, .rel.iplt, .igot.plt, and .modinfo.
> > 
> > Add missing text stub sections .vfp11_veneer and .v4_bx.
> > 
> > Add debug sections explicitly.
> > 
> > Finally enable orphan section warning.
> 
> This is unrelated to this patch as such, but I noticed that ARM32/64 places
> the .got section inside .text -- is that expected on ARM?

Do you mean in general, in the kernel vmlinux, in the decompressor
vmlinux or ... ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
