Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047AC77C115
	for <lists+linux-arch@lfdr.de>; Mon, 14 Aug 2023 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjHNTxD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Aug 2023 15:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjHNTwp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Aug 2023 15:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3644B120;
        Mon, 14 Aug 2023 12:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C964263000;
        Mon, 14 Aug 2023 19:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9F1C433C8;
        Mon, 14 Aug 2023 19:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692042763;
        bh=lcz8SXMrvxLPwawIXo2qAouwG8tznPnDE2Oo0Ma25GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rntjU4wKabKCG9vCSYTEAbGAOxHYY53ttCovv8mvF19G+Z+Y6H+17PkF/nRDt4bhU
         MRxA5kfv5pmEV5xRW5qULA+AUJ1xxXBbO5pPay4/ssiETLXv0BqiuaC5acP0pGJhfk
         M9rZJhyFnjFjOz9dWhAUpMMp47GAy0redIpThGPamh1rIt24HQcma8E8WvEmEkJGb8
         HrbQeB6D9GVtIocc+3DunUH9BYwmX9ioZ2r6V7YsWPWSjB6Cw75iPD7Jgt8Pe+f7ia
         TZzGqhJ26loLAgwwnT+PJPh5x+13ana6PFgXOk/waCav6ChRm56w415lRRfUNdjp+6
         oPJcPS2ZW39Cw==
Date:   Mon, 14 Aug 2023 12:52:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 9/9] [RFC] extrawarn: enable more W=1 warnings by default
Message-ID: <20230814195240.GA1060032@dev-arch.thelio-3990X>
References: <20230811140327.3754597-1-arnd@kernel.org>
 <20230811140327.3754597-10-arnd@kernel.org>
 <20230811160939.GA426470@dev-arch.thelio-3990X>
 <defc2883-659b-4805-a279-783fbd3357cc@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <defc2883-659b-4805-a279-783fbd3357cc@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023 at 08:23:45PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 11, 2023, at 18:09, Nathan Chancellor wrote:
> > On Fri, Aug 11, 2023 at 04:03:27PM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> A number of warning options from the W=1 set are completely clean in current
> >> kernels, so we should just enable them by default, including a lot of warnings
> >> that are part of -Wextra, so just turn on -Wextra by default.
> >> 
> >> The -Woverride-init, -Wvoid-pointer-to-enum-cast and
> >> -Wmissing-format-attribute warnings are part of -Wextra but still produce
> >> some legitimate warnings that need to be fixed, so leave them at the
> >> W=1 level but turn them off otherwise.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ...
> >> -KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
> >> -KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
> >> -KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
> >
> > I am still running through my builds but I don't think that dropping
> > these three is acceptable at the moment. I see a good number of all of
> > these warnings in -next still. I see some patches that I have picked up
> > to address a couple of the really noisy ones but some others that I
> > looked at are not fixed. I'll have a list eventually.
> 
> Ok, thanks. I have a backlog of warning fixes in my randconfig
> tree, which is currently clean with these warnings addressed, at
> least on arm/arm64/x86 and it looks like there are a couple that
> I've never sent out so far. I'll drop the above for now, as I
> won't have time to send all the fixes before my vacation.

Thanks, that takes care of the vast majority of extra warnings that this
series produces. I have included all my build logs at [1].

The slightly-filtered-warnings file is the result of searching for all
warnings in the log files and passing them through 'sort | uniq -c',
additionally ignoring the instances of -Wnull-pointer-arithmetic that
are present in certain configurations, as those are pretty well known at
this point.

The more-filtered-warnings file does the same thing but also ignores
instances of the three warnings above, which just reveals some instances
of -Wunused-but-set-parameter, which I am pretty sure I have seen you
sent fixes for recently, so I think with those three warnings left as
disabled, this series should be safe.

[1]: https://github.com/nathanchance/bug-files/tree/9100c6a21cbdce3c03fbca1bd00a7c34f316a137/enable-more-W%3D1-warnings-by-default

Cheers,
Nathan
