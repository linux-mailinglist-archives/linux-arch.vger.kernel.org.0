Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2999334812E
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 20:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhCXTEw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 15:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237641AbhCXTEi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 15:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36CB3619B1;
        Wed, 24 Mar 2021 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616612677;
        bh=3QCrUi4hLzDRYFZDg+NEvYrrrdirK6b8d2l2R7Oezz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncVwdGNqeKq1W9b9rlLUWAStvLK2lkVj4gRYh2ReLX67sC0/f14x/6g63g809s3U/
         VyBNjz2tNFAG3tWGToDJAbzIusqCqZBBioW8C3+DLs+Got3divf6k2Ue47icKFOjvL
         ufWIrW6Jcer6K2xfngMVpH2wokF4bP2RPKuxgmnBX8/hsp7/AY0SYqOd+tTQrdlhxR
         TXpC3iPBmPr046slX6jo4edSE1giarYPxVAdVy54qJWGoK5BqCB9pZmYkGPm/hmBLy
         j+1YOqkwsOi7iAR04GLL5sxanzPcLOXi1ay31LVYOLUsFhnHOEGUyQsEx3mhEzFdka
         657QSJXUALvrQ==
Date:   Wed, 24 Mar 2021 19:04:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
Message-ID: <20210324190428.GG13181@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-14-marcan@marcan.st>
 <20210324183818.GF13181@willie-the-truck>
 <20210324185921.GA27297@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324185921.GA27297@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 24, 2021 at 06:59:21PM +0000, Mark Rutland wrote:
> On Wed, Mar 24, 2021 at 06:38:18PM +0000, Will Deacon wrote:
> > On Fri, Mar 05, 2021 at 06:38:48AM +0900, Hector Martin wrote:
> > > Apple ARM64 SoCs have a ton of vendor-specific registers we're going to
> > > have to deal with, and those don't really belong in sysreg.h with all
> > > the architectural registers. Make a new home for them, and add some
> > > registers which are useful for early bring-up.
> > > 
> > > Signed-off-by: Hector Martin <marcan@marcan.st>
> > > ---
> > >  MAINTAINERS                           |  1 +
> > >  arch/arm64/include/asm/sysreg_apple.h | 69 +++++++++++++++++++++++++++
> > >  2 files changed, 70 insertions(+)
> > >  create mode 100644 arch/arm64/include/asm/sysreg_apple.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index aec14fbd61b8..3a352c687d4b 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -1646,6 +1646,7 @@ B:	https://github.com/AsahiLinux/linux/issues
> > >  C:	irc://chat.freenode.net/asahi-dev
> > >  T:	git https://github.com/AsahiLinux/linux.git
> > >  F:	Documentation/devicetree/bindings/arm/apple.yaml
> > > +F:	arch/arm64/include/asm/sysreg_apple.h
> > 
> > (this isn't needed with my suggestion below).
> > 
> > >  ARM/ARTPEC MACHINE SUPPORT
> > >  M:	Jesper Nilsson <jesper.nilsson@axis.com>
> > > diff --git a/arch/arm64/include/asm/sysreg_apple.h b/arch/arm64/include/asm/sysreg_apple.h
> > > new file mode 100644
> > > index 000000000000..48347a51d564
> > > --- /dev/null
> > > +++ b/arch/arm64/include/asm/sysreg_apple.h
> > 
> > I doubt apple are the only folks doing this, so can we instead have
> > sysreg-impdef.h please, and then have an Apple section in there for these
> > registers? That way, we could also have an imp_sys_reg() macro to limit
> > CRn to 11 or 15, which is the reserved encoding space for these registers.
> > 
> > We'll cc you for any patches touching the Apple parts, as we don't have
> > the first clue about what's hiding in there.
> 
> For existing IMP-DEF sysregs (e.g. the Kryo L2 control registers), we've
> put the definitions in the drivers, rather than collating
> non-architectural bits under arch/arm64/.

Yeah, but we could include those here as well.

> So far we've kept arch/arm64/ largely devoid of IMP-DEF bits, and it
> seems a shame to add something with the sole purpose of collating that,
> especially given arch code shouldn't need to touch these if FW and
> bootloader have done their jobs right.
> 
> Can we put the definitions in the relevant drivers? That would sidestep
> any pain with MAINTAINERS, too.

If we can genuinely ignore these in arch code, then sure. I just don't know
how long that is going to be the case, and ending up in a situation where
these are scattered randomly throughout the tree sounds horrible to me.

Will
