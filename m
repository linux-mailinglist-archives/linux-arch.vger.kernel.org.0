Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFAB73AD17
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 01:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjFVXTd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 19:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjFVXT2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 19:19:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982B826A4;
        Thu, 22 Jun 2023 16:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9386861939;
        Thu, 22 Jun 2023 23:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2B9C433C9;
        Thu, 22 Jun 2023 23:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687475886;
        bh=IYLn4He+dUn8jWbCQgvPNmcloMkzjwQQPUXE3ulHjvI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FqI9zOD6e2gifJtG76n7U3TKoxxXnwhs8M0UVHn+MoXE52sfvxjhrHr/L4bynI5IZ
         TZz+VD9RENvfCSgpMrQ+VF28i/dHiYcg5WBUO0ZV71CJjU2f6kFZKxFqsj2xtYvLFm
         suhnTWft40hlVMtigVCYunFiJmuRyrTRdzytgoLMZsJgLoWFTivJb8PzlQ56DsMB49
         cy5YFWPHgQLkN3WrMjyBuCOV0t8GnsE1F90PVMexwe7AWSbULY3qNWGwgH/Evp5Edy
         658iKVi1zSDH43vP0xDQt24YoAQV/VwSrEa6Ia5CbjSdLXQ18zRTmcXovIRetKlWap
         lXG6bkPQ3NRZA==
Date:   Thu, 22 Jun 2023 23:18:03 +0000
From:   Nathan Chancellor <nathan@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     bjorn@kernel.org, ndesaulniers@google.com,
        Conor Dooley <conor@kernel.org>, jszhang@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20230622231803.GA1790165@dev-arch.thelio-3990X>
References: <20230622215327.GA1135447@dev-arch.thelio-3990X>
 <mhng-6c34765c-126d-4e6c-8904-e002d49a4336@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6c34765c-126d-4e6c-8904-e002d49a4336@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 22, 2023 at 03:16:51PM -0700, Palmer Dabbelt wrote:
> On Thu, 22 Jun 2023 14:53:27 PDT (-0700), nathan@kernel.org wrote:
> > On Wed, Jun 21, 2023 at 11:19:31AM -0700, Palmer Dabbelt wrote:
> > > On Wed, 21 Jun 2023 10:51:15 PDT (-0700), bjorn@kernel.org wrote:
> > > > Conor Dooley <conor@kernel.org> writes:
> > > >
> > > > [...]
> > > >
> > > > > > So I'm no longer actually sure there's a hang, just something
> > > > > > slow.  That's even more of a grey area, but I think it's sane to
> > > > > > call a 1-hour link time a regression -- unless it's expected
> > > > > > that this is just very slow to link?
> > > > >
> > > > > I dunno, if it was only a thing for allyesconfig, then whatever - but
> > > > > it's gonna significantly increase build times for any large kernels if LLD
> > > > > is this much slower than LD. Regression in my book.
> > > > >
> > > > > I'm gonna go and experiment with mixed toolchain builds, I'll report
> > > > > back..
> > > >
> > > > I took palmer/for-next (1bd2963b2175 ("Merge patch series "riscv: enable
> > > > HAVE_LD_DEAD_CODE_DATA_ELIMINATION"")) for a tuxmake build with llvm-16:
> > > >
> > > >   | ~/src/tuxmake/run -v --wrapper ccache --target-arch riscv \
> > > >   |     --toolchain=llvm-16 --runtime docker --directory . -k \
> > > >   |     allyesconfig
> > > >
> > > > Took forever, but passed after 2.5h.
> > > 
> > > Thanks.  I just re-ran mine 17/trunk LLD under time (rather that just
> > > checking top sometimes), it's at 1.5h but even that seems quite long.
> > > 
> > > I guess this is sort of up to the LLVM folks: if it's expected that DCE
> > > takes a very long time to link then I'm not opposed to allowing it, but if
> > > this is probably a bug in LLD then it seems best to turn it off until we
> > > sort things out over there.
> > > 
> > > I think maybe Nick or Nathan is the best bet to know?
> > 
> > I can confirm a regression with allyesconfig but not allmodconfig using
> > LLVM 16.0.6 on my 80-core Ampere Altra system.
> > 
> > allmodconfig: 8m 4s
> > allmodconfig + CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n: 7m 4s
> > allyesconfig: 1h 58m 30s
> > allyesconfig + CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n: 12m 41s
> 
> Are those backwards?  I'm getting super slow builds after merging the patch
> set, not before -- though apologize in advance if I'm reading it wrong, I'm
> well on my way to falling asleep already ;)

I know I already responded to you around this on IRC but I will do it
here too for the benefit of others following this thread.

These numbers are from the patchset applied on top of dad9774deaf1
("Merge tag 'timers-urgent-2023-06-21' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip"); in other words,
allmodconfig and allyesconfig have CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y
so turning it off is basically like building allmodconfig and
allyesconfig before the patchset was applied.

> > I am sure there is something that ld.lld can do better, given GNU ld
> > does not have any problems as earlier established, so that should
> > definitely be explored further. I see Nick already had a response about
> > writing up a report (I wrote most of this before that email so I am
> > still sending this one).
> > 
> > However, allyesconfig is pretty special and not really indicative of a
> > "real world" kernel build in my opinion (which will either be a fully
> > modular kernel to allow use on a wide range of hardware or a monolithic
> > kernel with just the drivers needed for a specific platform, which will
> > be much smaller than allyesconfig); it has given us problems with large
> > kernels before on other architectures.
> 
> I totally agree that allyesconfig is an oddity, but it's something that does
> get regularly build tested so a big build time hit there is going to cause
> trouble -- maybe not for users, but it'll be a problem for maintainers and
> that's way more likely to get me yelled at ;)

Agreed. That comment was more around justification for opting out of
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION with these configurations, since
CONFIG_COMPILE_TEST has effective become "am I allmodconfig or
allyesconfig?" nowadays.

> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is already marked with 'depends on
> > EXPERT' and its help text mentions its perils, so it does not seem
> > unreasonable to me to add an additional dependency on !COMPILE_TEST so
> > that allmodconfig and allyesconfig cannot flip this on, something like
> > the following perhaps?
> > 
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 32c24950c4ce..25434cbd2a6e 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1388,7 +1388,7 @@ config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >  config LD_DEAD_CODE_DATA_ELIMINATION
> >  	bool "Dead code and data elimination (EXPERIMENTAL)"
> >  	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> > -	depends on EXPERT
> > +	depends on EXPERT && !COMPILE_TEST
> >  	depends on $(cc-option,-ffunction-sections -fdata-sections)
> >  	depends on $(ld-option,--gc-sections)
> >  	help
> > 
> > If applying that dependency to all architectures is too much, the
> > selection in arch/riscv/Kconfig could be gated on the same condition.
> 
> Is the regression for all ports, or just RISC-V?  I'm fine gating this with
> some sort of Kconfig flag, if it's just impacting RISC-V then it seems sane
> to keep it over here.

I am not sure. Only mips selects HAVE_LD_DEAD_CODE_DATA_ELIMINATION
unconditionally and we don't test ARCH=mips all{mod,yes}config (not sure
why off the top of my head). powerpc selects it when using objtool for
mcount generation, which only happens for ppc32 (which we don't test
heavily or with large kernels) or using '-mprofile-kernel', which clang
does not support.

If you wanted to restrict it to just LD_IS_BFD in arch/riscv/Kconfig,
that would be fine with me too.

  select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if LD_IS_BFD

Nick said he would work on a report for the LLVM side, so as long as
this issue is handled in some way to avoid regressing LLD builds until
it is resolved, I don't think there is anything else for the kernel to
do. We like to have breadcrumbs via issue links, not sure if the report
will be internal to Google or on LLVM's issue tracker though;
regardless, we will have to touch this block to add a version check
later, at which point we can add a link to the fix in LLD.

Cheers,
Nathan
