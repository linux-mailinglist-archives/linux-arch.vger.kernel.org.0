Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80A1348116
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 20:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhCXTAA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 15:00:00 -0400
Received: from foss.arm.com ([217.140.110.172]:38094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237571AbhCXS7d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 14:59:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D21331474;
        Wed, 24 Mar 2021 11:59:32 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763F93F718;
        Wed, 24 Mar 2021 11:59:27 -0700 (PDT)
Date:   Wed, 24 Mar 2021 18:59:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v3 13/27] arm64: Add Apple vendor-specific system
 registers
Message-ID: <20210324185921.GA27297@C02TD0UTHF1T.local>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-14-marcan@marcan.st>
 <20210324183818.GF13181@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324183818.GF13181@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 24, 2021 at 06:38:18PM +0000, Will Deacon wrote:
> On Fri, Mar 05, 2021 at 06:38:48AM +0900, Hector Martin wrote:
> > Apple ARM64 SoCs have a ton of vendor-specific registers we're going to
> > have to deal with, and those don't really belong in sysreg.h with all
> > the architectural registers. Make a new home for them, and add some
> > registers which are useful for early bring-up.
> > 
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > ---
> >  MAINTAINERS                           |  1 +
> >  arch/arm64/include/asm/sysreg_apple.h | 69 +++++++++++++++++++++++++++
> >  2 files changed, 70 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/sysreg_apple.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aec14fbd61b8..3a352c687d4b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1646,6 +1646,7 @@ B:	https://github.com/AsahiLinux/linux/issues
> >  C:	irc://chat.freenode.net/asahi-dev
> >  T:	git https://github.com/AsahiLinux/linux.git
> >  F:	Documentation/devicetree/bindings/arm/apple.yaml
> > +F:	arch/arm64/include/asm/sysreg_apple.h
> 
> (this isn't needed with my suggestion below).
> 
> >  ARM/ARTPEC MACHINE SUPPORT
> >  M:	Jesper Nilsson <jesper.nilsson@axis.com>
> > diff --git a/arch/arm64/include/asm/sysreg_apple.h b/arch/arm64/include/asm/sysreg_apple.h
> > new file mode 100644
> > index 000000000000..48347a51d564
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/sysreg_apple.h
> 
> I doubt apple are the only folks doing this, so can we instead have
> sysreg-impdef.h please, and then have an Apple section in there for these
> registers? That way, we could also have an imp_sys_reg() macro to limit
> CRn to 11 or 15, which is the reserved encoding space for these registers.
> 
> We'll cc you for any patches touching the Apple parts, as we don't have
> the first clue about what's hiding in there.

For existing IMP-DEF sysregs (e.g. the Kryo L2 control registers), we've
put the definitions in the drivers, rather than collating
non-architectural bits under arch/arm64/.

So far we've kept arch/arm64/ largely devoid of IMP-DEF bits, and it
seems a shame to add something with the sole purpose of collating that,
especially given arch code shouldn't need to touch these if FW and
bootloader have done their jobs right.

Can we put the definitions in the relevant drivers? That would sidestep
any pain with MAINTAINERS, too.

Thanks,
Mark.
