Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2D360D84D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 02:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiJZAEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Oct 2022 20:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZAEn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2022 20:04:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848221DA41;
        Tue, 25 Oct 2022 17:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B3A461BBE;
        Wed, 26 Oct 2022 00:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458A7C433D6;
        Wed, 26 Oct 2022 00:04:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IRMU2CLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666742676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IkwAfVtYTtU51oc7/jn0Fs/YPN6o4wcDABPb9JF67Co=;
        b=IRMU2CLvIifkL42MsPhI3sulQbEzr9U6+3fTzexuHGDEHqDdCJoRJwnwnjVfq7kOB0P29/
        DdnlPZAq8bFUyY7kzXADuQeAVqE2/bIzAWRbc4tqLPkYqrlX6bvTUBGGbatNvgoZNC+stY
        P429xx95hvHaPve3E+kljj0BMdcS6wg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fd4b7e5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 26 Oct 2022 00:04:35 +0000 (UTC)
Date:   Wed, 26 Oct 2022 02:04:30 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Gabriel Paubert <paubert@iram.es>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <Y1h5jr/ZS7BORewp@zx2c4.com>
References: <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org>
 <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <Y1Elx+e5VLCTfyXi@lt-gp.iram.es>
 <CAHk-=wiYtSvjyz5xz2Sbnmxgzg_=AL2OyTiRueUem3xzCzM8VA@mail.gmail.com>
 <Y1OIXdh3vWOMUlQK@lt-gp.iram.es>
 <CAHk-=wgaeTa9nAeJ8DP1cBWrs8fZvJ7k1-L8-kjxEOxpLf+XNA@mail.gmail.com>
 <Y1Wi29MuYlCRTKfH@lt-gp.iram.es>
 <202210251555.88933A57F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210251555.88933A57F@keescook>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 25, 2022 at 04:00:30PM -0700, Kees Cook wrote:
> On Sun, Oct 23, 2022 at 10:23:56PM +0200, Gabriel Paubert wrote:
> > On Sat, Oct 22, 2022 at 11:16:33AM -0700, Linus Torvalds wrote:
> > > Practically speaking this might be a bit painful, because we've got
> > > several different variations of this all due to all the things like
> > > our debugging versions (see <linux/fortify-string.h> for example), so
> > > some of our code is this crazy jungle of "with this config, use this
> > > wrapper".
> > 
> > I've just had a look at that code, and I don't want to touch it with a
> > 10 foot pole. If someone else to get his hands dirty... 
> 
> Heh. Yes, fortify-string.h is a twisty maze. I've tried to keep it as
> regular as possible, but I admit it is weird. On my list is to split
> compile-time from run-time logic (as suggested by Linus a while back),
> but I've worried it would end up spilling some of the ugly back into
> string.h, which should probably not happen. As such, I've tried to keep
> it all contained in fortify-string.h.
> 
> Regardless, I think I'd rather avoid yet more special cases in the
> fortify code, so I'd like to avoid using transparent union if we can. It
> seems like -funsigned-char and associated fixes will be sufficient,
> though, yes?

I thought some of the motivation behind the transparent union was that
gcc still treats `char` as a distinct type from `unsigned char`, so
gcc's checker can still get upset and warn when passing a u8[] to a
string handling function that expects a char[]. (Once the
-funsigned-char changes go in, though, we should probably decide that
s8[] is never a valid string.)

Jason
