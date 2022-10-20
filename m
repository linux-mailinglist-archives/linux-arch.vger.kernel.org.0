Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB7606753
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJTRxz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJTRxy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 13:53:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2B31E7446;
        Thu, 20 Oct 2022 10:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38BC761B4B;
        Thu, 20 Oct 2022 17:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADCCC433D6;
        Thu, 20 Oct 2022 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666288432;
        bh=ENyBHTU+PlCOFSNauBVolLBO7eB6Z+yD7cAHq5oAFfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itsqb22tDrJn/TaivCWnwHoR/9a1Q/K3QjttRaDQ6N0wPGbj3sGv4KhTbdN4/5Nxy
         qe9lpYkzAHrw8iXhNx+gUH/eJBvgfpinLFdJht+aIV7B43iS5L474MXiI9lVQER+YZ
         YTk7aj6vm6U8rTbfb7xKZUYPy+pGcWR7F8pJu2zwTF87vqlR9Ehr4jsb3uNftkF6wX
         W433vYi8ytZV2h2vgJcXNFub79eBqffDd5s+X9Ii4M3CXEkxnezmYYWH1bZSoXfnhK
         /DRZwynNDXEwrQwvO3QTUtZeYnREpKChG+YqGe2lhRXJ0yI7Xzeaa98a9j5d59l671
         vlXEDoBoA2chA==
Date:   Thu, 20 Oct 2022 10:53:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "H.Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: upgrade the orphan section warning to a hard link error
Message-ID: <Y1GLLnYsEC8lYTdp@dev-arch.thelio-3990X>
References: <BN6PR1101MB216105D169D482FC8C539059A8269@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y02eZ6A/vlj8+B/c@dev-arch.thelio-3990X>
 <202210171230.CC40461C@keescook>
 <Y02zWFxC92VDSpdZ@dev-arch.thelio-3990X>
 <BN6PR1101MB216126260E3A9AFEE3F9CFB8A82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR1101MB216126260E3A9AFEE3F9CFB8A82A9@BN6PR1101MB2161.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 05:17:35AM +0000, Li, Xin3 wrote:
> Hi Nathan,
> 
> > On Mon, Oct 17, 2022 at 12:32:39PM -0700, Kees Cook wrote:
> > > On Mon, Oct 17, 2022 at 11:26:47AM -0700, Nathan Chancellor wrote:
> > > > It might be interesting to turn orphan sections into an error if
> > > > CONFIG_WERROR is set. Perhaps something like the following (FYI, not
> > > > even compile tested)?
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index 0837445110fc..485f47fc2c07 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1119,7 +1119,7 @@ endif
> > > >  # We never want expected sections to be placed heuristically by the
> > > > # linker. All sections should be explicitly named in the linker script.
> > > >  ifdef CONFIG_LD_ORPHAN_WARN
> > > > -LDFLAGS_vmlinux += --orphan-handling=warn
> > > > +LDFLAGS_vmlinux += --orphan-handling=$(if
> > > > +$(CONFIG_WERROR),error,warn)
> > > >  endif
> > >
> > > Yes, this is much preferred.
> > >
> > > > Outright turning the warning into an error with no escape hatch
> > > > might be too aggressive, as we have had these warnings triggered by
> > > > new compiler generated sections, such as in commit 848378812e40
> > ("vmlinux.lds.h:
> > > > Handle clang's module.{c,d}tor sections"). Unconditionally breaking
> > > > the build in these situations is unfortunate but the warnings do
> > > > need to be dealt with so I think having it error by default with the
> > > > ability to opt-out is probably worth doing. I do not have a strong opinion
> > though.
> > >
> > > Correct; the mandate from Linus (disregarding his addition of
> > > CONFIG_WERROR for all*config builds), is that we should avoid breaking
> > > builds. It wrecks bisection, it causes problems across compiler
> > > versions, etc.
> > >
> > > So, yes, only on CONFIG_WERROR=y.
> > 
> > We would probably want to alter the text of CONFIG_WERROR in some manner
> > to convey this, perhaps like so:
> > 
> > diff --git a/init/Kconfig b/init/Kconfig index a19314933e54..1fc03e4b2af2
> > 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -165,10 +165,12 @@ config WERROR
> >  	help
> >  	  A kernel build should not cause any compiler warnings, and this
> >  	  enables the '-Werror' (for C) and '-Dwarnings' (for Rust) flags
> > -	  to enforce that rule by default.
> > +	  to enforce that rule by default. Certain warnings from other tools
> > +	  such as the linker may be upgraded to errors with this option as
> > +	  well.
> > 
> > -	  However, if you have a new (or very old) compiler with odd and
> > -	  unusual warnings, or you have some architecture with problems,
> > +	  However, if you have a new (or very old) compiler or linker with odd
> > +	  and unusual warnings, or you have some architecture with problems,
> >  	  you may need to disable this config option in order to
> >  	  successfully build the kernel.
> 
> Thanks a lot for making this crystal clear.
> 
> Do you want me to continue?  Or maybe it's easier for you to complete it?

Sure, I think it is reasonable for you to continue with this as you
brought up the idea initially! Feel free to just take those diffs
wholesale if they work and stick a

    Suggested-by: Nathan Chancellor <nathan@kernel.org>

or

    Co-developed-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Nathan Chancellor <nathan@kernel.org>

on the patch if you are so inclined or rework them in a way you see fit,
I do not have a strong opinion.

> I will need to find resources to test the patch on other platforms besides x86.

In theory, we should have already cleaned up all these warnings when we
enabled CONFIG_LD_ORPHAN_WARN for all these architectures, so that
change should be a no-op. More testing is never a bad idea though :)

I can throw it into my LLVM testing matrix as well.

Cheers,
Nathan
