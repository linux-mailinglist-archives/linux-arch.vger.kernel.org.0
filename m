Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9931360B65F
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJXS4F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 14:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiJXSzR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 14:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D917BB97B2;
        Mon, 24 Oct 2022 10:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ECAE614C7;
        Mon, 24 Oct 2022 16:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6DAC433C1;
        Mon, 24 Oct 2022 16:33:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="coJh9+5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666629237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A5GZRDB4rbQnStmsUvEvn9MTvGqeI6fsKSlR5kgaMBk=;
        b=coJh9+5N4coe3q0l8+g431w1AVe444AG6un5QCSRH/ZjlA9o0QFDl+23R8A0v5DRzx6+Kl
        TltxQiuDLr+IC92Kg0MiuJUD5pripqalYQcoTojAONq8F67nAv/J4Upm1DJyJbetlcwbt1
        TFmi757DMTcB4kyBTvUBIeVg771pXUY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c5b9daa8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 24 Oct 2022 16:33:57 +0000 (UTC)
Date:   Mon, 24 Oct 2022 18:33:52 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <Y1a+cHkFt54gJv54@zx2c4.com>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <Y1ZZyP4ZRBIbv+Kg@kili>
 <Y1ZbI4IzAOaNwhoD@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1ZbI4IzAOaNwhoD@kadam>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 12:30:11PM +0300, Dan Carpenter wrote:
> On Mon, Oct 24, 2022 at 12:24:24PM +0300, Dan Carpenter wrote:
> > On Wed, Oct 19, 2022 at 02:30:34PM -0600, Jason A. Donenfeld wrote:
> > > Recently, some compile-time checking I added to the clamp_t family of
> > > functions triggered a build error when a poorly written driver was
> > > compiled on ARM, because the driver assumed that the naked `char` type
> > > is signed, but ARM treats it as unsigned, and the C standard says it's
> > > architecture-dependent.
> > > 
> > > I doubt this particular driver is the only instance in which
> > > unsuspecting authors make assumptions about `char` with no `signed` or
> > > `unsigned` specifier. We were lucky enough this time that that driver
> > > used `clamp_t(char, negative_value, positive_value)`, so the new
> > > checking code found it, and I've sent a patch to fix it, but there are
> > > likely other places lurking that won't be so easily unearthed.
> > > 
> > > So let's just eliminate this particular variety of heisensign bugs
> > > entirely. Set `-funsigned-char` globally, so that gcc makes the type
> > > unsigned on all architectures.
> > > 
> > > This will break things in some places and fix things in others, so this
> > > will likely cause a bit of churn while reconciling the type misuse.
> > > 
> > 
> > This is a very daring change and obviously is going to introduce bugs.
> > It might be better to create a static checker rule that says "char"
> > without explicit signedness can only be used for strings.
> > 
> > arch/parisc/kernel/drivers.c:337 print_hwpath() warn: impossible condition '(path->bc[i] == -1) => (0-255 == (-1))'
> > arch/parisc/kernel/drivers.c:410 setup_bus_id() warn: impossible condition '(path.bc[i] == -1) => (0-255 == (-1))'
> > arch/parisc/kernel/drivers.c:486 create_parisc_device() warn: impossible condition '(modpath->bc[i] == -1) => (0-255 == (-1))'
> > arch/parisc/kernel/drivers.c:759 hwpath_to_device() warn: impossible condition '(modpath->bc[i] == -1) => (0-255 == (-1))'
> > drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: assigning (-9) to unsigned variable 'tm'
> > drivers/media/dvb-frontends/stv0288.c:471 stv0288_set_frontend() warn: we never enter this loop
> > drivers/misc/sgi-gru/grumain.c:711 gru_check_chiplet_assignment() warn: 'gts->ts_user_chiplet_id' is unsigned
> > drivers/net/wireless/cisco/airo.c:5316 proc_wepkey_on_close() warn: assigning (-16) to unsigned variable 'key[i / 3]'
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9415 rt2800_iq_search() warn: assigning (-32) to unsigned variable 'idx0'
> > drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9470 rt2800_iq_search() warn: assigning (-32) to unsigned variable 'perr'
> > drivers/video/fbdev/sis/init301.c:3549 SiS_GetCRT2Data301() warn: 'SiS_Pr->SiS_EModeIDTable[ModeIdIndex]->ROMMODEIDX661' is unsigned
> > sound/pci/au88x0/au88x0_core.c:2029 vortex_adb_checkinout() warn: signedness bug returning '(-22)'
> > sound/pci/au88x0/au88x0_core.c:2046 vortex_adb_checkinout() warn: signedness bug returning '(-12)'
> > sound/pci/au88x0/au88x0_core.c:2125 vortex_adb_allocroute() warn: 'vortex_adb_checkinout(vortex, (0), en, 0)' is unsigned
> > sound/pci/au88x0/au88x0_core.c:2170 vortex_adb_allocroute() warn: 'vortex_adb_checkinout(vortex, stream->resources, en, 4)' is unsigned
> > sound/pci/rme9652/hdsp.c:3953 hdsp_channel_buffer_location() warn: 'hdsp->channel_map[channel]' is unsigned
> > sound/pci/rme9652/rme9652.c:1833 rme9652_channel_buffer_location() warn: 'rme9652->channel_map[channel]' is unsigned
> 
> Here are some more:
> 
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9472 rt2800_iq_search() warn: impossible condition '(gerr < -7) => (0-255 < (-7))'
> drivers/net/wireless/ralink/rt2x00/rt2800lib.c:9476 rt2800_iq_search() warn: impossible condition '(perr < -31) => (0-255 < (-31))'
> drivers/staging/rtl8192e/rtllib_softmac_wx.c:459 rtllib_wx_set_essid() warn: impossible condition '(extra[i] < 0) => (0-255 < 0)'
> sound/pci/rme9652/hdsp.c:4153 snd_hdsp_channel_info() warn: impossible condition '(hdsp->channel_map[channel] < 0) => (0-255 < 0)'
> 
> This might be interesting for backports if everyone starts to rely on
> the fact that char is unsigned as the PPC people currently do.

Give these a minute to hit Lore, but patches just submitted to various
maintainers as fixes (for 6.1), since these are already broken on some
architecture.

https://lore.kernel.org/all/20221024163005.536097-1-Jason@zx2c4.com
https://lore.kernel.org/all/20221024162947.536060-1-Jason@zx2c4.com
https://lore.kernel.org/all/20221024162929.536004-1-Jason@zx2c4.com
https://lore.kernel.org/all/20221024162901.535972-1-Jason@zx2c4.com
https://lore.kernel.org/all/20221024162843.535921-1-Jason@zx2c4.com
https://lore.kernel.org/all/20221024162823.535884-1-Jason@zx2c4.com
https://lore.kernel.org/all/20221024162756.535776-1-Jason@zx2c4.com

Jason
