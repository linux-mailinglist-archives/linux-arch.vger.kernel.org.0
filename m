Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6EE73ABE4
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 23:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjFVVxd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 17:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFVVxc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 17:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161AB1FEF;
        Thu, 22 Jun 2023 14:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A78E46190C;
        Thu, 22 Jun 2023 21:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5D7C433C0;
        Thu, 22 Jun 2023 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687470810;
        bh=PJGfxTyAnCqu8Vna68rQ2voA4n9bS/jsrshp8nOUR3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2Y6v8fxX47hw/xJfyeIYjRJzAWpg8aRRtbtReWBMPAgcH9AfSyoIsdC7/mZGL2eX
         e0+EZzJOrFT4sygyF0qGhmEKCrOUa6w73xYFv6j8L/2hBJ5qwKfEPu6CqbArm0/VU0
         dD2y/4hj2fhuO3cGQiFQNfRHww0m43HysUddCGxJy4smBIuqFKNMWCdI3HfIkicAYA
         cFOgxJU9LLNLfHnpqlY3KMIWoftnhwzzzSRFUxEVcsrTs26WY/ijGDjN4vFQixpkVn
         XJy5AFHSUd3UqWfbGzcClQwAAoxRgXpeBFVI/v+Yv0+O48ThhxXoaR4cA9sgspSXPR
         CPDbi17v2qfdg==
Date:   Thu, 22 Jun 2023 21:53:27 +0000
From:   Nathan Chancellor <nathan@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     bjorn@kernel.org, ndesaulniers@google.com,
        Conor Dooley <conor@kernel.org>, jszhang@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <20230622215327.GA1135447@dev-arch.thelio-3990X>
References: <87wmzwn1po.fsf@all.your.base.are.belong.to.us>
 <mhng-1d790a82-44ad-4b9c-bfe4-6303f09b0705@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-1d790a82-44ad-4b9c-bfe4-6303f09b0705@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 21, 2023 at 11:19:31AM -0700, Palmer Dabbelt wrote:
> On Wed, 21 Jun 2023 10:51:15 PDT (-0700), bjorn@kernel.org wrote:
> > Conor Dooley <conor@kernel.org> writes:
> > 
> > [...]
> > 
> > > > So I'm no longer actually sure there's a hang, just something
> > > > slow.  That's even more of a grey area, but I think it's sane to
> > > > call a 1-hour link time a regression -- unless it's expected
> > > > that this is just very slow to link?
> > > 
> > > I dunno, if it was only a thing for allyesconfig, then whatever - but
> > > it's gonna significantly increase build times for any large kernels if LLD
> > > is this much slower than LD. Regression in my book.
> > > 
> > > I'm gonna go and experiment with mixed toolchain builds, I'll report
> > > back..
> > 
> > I took palmer/for-next (1bd2963b2175 ("Merge patch series "riscv: enable
> > HAVE_LD_DEAD_CODE_DATA_ELIMINATION"")) for a tuxmake build with llvm-16:
> > 
> >   | ~/src/tuxmake/run -v --wrapper ccache --target-arch riscv \
> >   |     --toolchain=llvm-16 --runtime docker --directory . -k \
> >   |     allyesconfig
> > 
> > Took forever, but passed after 2.5h.
> 
> Thanks.  I just re-ran mine 17/trunk LLD under time (rather that just
> checking top sometimes), it's at 1.5h but even that seems quite long.
> 
> I guess this is sort of up to the LLVM folks: if it's expected that DCE
> takes a very long time to link then I'm not opposed to allowing it, but if
> this is probably a bug in LLD then it seems best to turn it off until we
> sort things out over there.
> 
> I think maybe Nick or Nathan is the best bet to know?

I can confirm a regression with allyesconfig but not allmodconfig using
LLVM 16.0.6 on my 80-core Ampere Altra system.

allmodconfig: 8m 4s
allmodconfig + CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n: 7m 4s
allyesconfig: 1h 58m 30s
allyesconfig + CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=n: 12m 41s

I am sure there is something that ld.lld can do better, given GNU ld
does not have any problems as earlier established, so that should
definitely be explored further. I see Nick already had a response about
writing up a report (I wrote most of this before that email so I am
still sending this one).

However, allyesconfig is pretty special and not really indicative of a
"real world" kernel build in my opinion (which will either be a fully
modular kernel to allow use on a wide range of hardware or a monolithic
kernel with just the drivers needed for a specific platform, which will
be much smaller than allyesconfig); it has given us problems with large
kernels before on other architectures.

CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is already marked with 'depends on
EXPERT' and its help text mentions its perils, so it does not seem
unreasonable to me to add an additional dependency on !COMPILE_TEST so
that allmodconfig and allyesconfig cannot flip this on, something like
the following perhaps?

diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..25434cbd2a6e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1388,7 +1388,7 @@ config HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 config LD_DEAD_CODE_DATA_ELIMINATION
 	bool "Dead code and data elimination (EXPERIMENTAL)"
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
-	depends on EXPERT
+	depends on EXPERT && !COMPILE_TEST
 	depends on $(cc-option,-ffunction-sections -fdata-sections)
 	depends on $(ld-option,--gc-sections)
 	help

If applying that dependency to all architectures is too much, the
selection in arch/riscv/Kconfig could be gated on the same condition.

Cheers,
Nathan
