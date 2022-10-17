Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E651601823
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJQT4R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 15:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJQT4Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 15:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE016B165;
        Mon, 17 Oct 2022 12:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8F9C61211;
        Mon, 17 Oct 2022 19:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD87C433D7;
        Mon, 17 Oct 2022 19:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666036570;
        bh=o6DvTfMjzEjmSYQ5N/gIC5fqJTcEYtiJOSjGBgmMUY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WU9S90BKukmbyqw/bIrfNn/cxkRGB96dZiaMRX3b67mchHiFRHHgoOhh+ZZBc3ual
         c7TfaajarCyZxQHIaVx4NOkvJ+YGFYOvQ4yEVC91rgghbsrQhCMh4JJb4V/n0j0tQj
         IT8pGDH+X25XGko8lSUEAYHC4oflTJZti1Qf21CQLmGHi8Aal8X8qazl93Ibl0+Mb9
         4i1oyhcJg8JxRLOwsbflfsc9KIj+b+PZq305Tkp+/9H2zumf5Kr9B9Bfbcfe1UvTjq
         jM0/z/vv2bdnUc88Q6qJhVQdSW0RO50vxa7RJfMIaAvFBM8u9UipBSM57yvG0HFjoQ
         +EwgH0vPTTT4w==
Date:   Mon, 17 Oct 2022 12:56:08 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Li, Xin3" <xin3.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "H.Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org
Subject: Re: upgrade the orphan section warning to a hard link error
Message-ID: <Y02zWFxC92VDSpdZ@dev-arch.thelio-3990X>
References: <BN6PR1101MB216105D169D482FC8C539059A8269@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y02eZ6A/vlj8+B/c@dev-arch.thelio-3990X>
 <202210171230.CC40461C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210171230.CC40461C@keescook>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 17, 2022 at 12:32:39PM -0700, Kees Cook wrote:
> On Mon, Oct 17, 2022 at 11:26:47AM -0700, Nathan Chancellor wrote:
> > It might be interesting to turn orphan sections into an error if
> > CONFIG_WERROR is set. Perhaps something like the following (FYI, not
> > even compile tested)?
> > 
> > diff --git a/Makefile b/Makefile
> > index 0837445110fc..485f47fc2c07 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1119,7 +1119,7 @@ endif
> >  # We never want expected sections to be placed heuristically by the
> >  # linker. All sections should be explicitly named in the linker script.
> >  ifdef CONFIG_LD_ORPHAN_WARN
> > -LDFLAGS_vmlinux += --orphan-handling=warn
> > +LDFLAGS_vmlinux += --orphan-handling=$(if $(CONFIG_WERROR),error,warn)
> >  endif
> 
> Yes, this is much preferred.
> 
> > Outright turning the warning into an error with no escape hatch might be
> > too aggressive, as we have had these warnings triggered by new compiler
> > generated sections, such as in commit 848378812e40 ("vmlinux.lds.h:
> > Handle clang's module.{c,d}tor sections"). Unconditionally breaking the
> > build in these situations is unfortunate but the warnings do need to be
> > dealt with so I think having it error by default with the ability to
> > opt-out is probably worth doing. I do not have a strong opinion though.
> 
> Correct; the mandate from Linus (disregarding his addition of
> CONFIG_WERROR for all*config builds), is that we should avoid breaking
> builds. It wrecks bisection, it causes problems across compiler versions,
> etc.
> 
> So, yes, only on CONFIG_WERROR=y.

We would probably want to alter the text of CONFIG_WERROR in some manner
to convey this, perhaps like so:

diff --git a/init/Kconfig b/init/Kconfig
index a19314933e54..1fc03e4b2af2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -165,10 +165,12 @@ config WERROR
 	help
 	  A kernel build should not cause any compiler warnings, and this
 	  enables the '-Werror' (for C) and '-Dwarnings' (for Rust) flags
-	  to enforce that rule by default.
+	  to enforce that rule by default. Certain warnings from other tools
+	  such as the linker may be upgraded to errors with this option as
+	  well.
 
-	  However, if you have a new (or very old) compiler with odd and
-	  unusual warnings, or you have some architecture with problems,
+	  However, if you have a new (or very old) compiler or linker with odd
+	  and unusual warnings, or you have some architecture with problems,
 	  you may need to disable this config option in order to
 	  successfully build the kernel.
 
---

Cheers,
Nathan
