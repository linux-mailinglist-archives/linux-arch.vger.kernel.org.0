Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82629606CC6
	for <lists+linux-arch@lfdr.de>; Fri, 21 Oct 2022 03:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJUBCC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Oct 2022 21:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJUBB7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Oct 2022 21:01:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB65A229E44;
        Thu, 20 Oct 2022 18:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1437361D7E;
        Fri, 21 Oct 2022 01:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73175C433D6;
        Fri, 21 Oct 2022 01:01:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eIVWBMZa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666314114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6vjKU3y4XcGUvVhqTEBbIddmaW3jyno5zUCPx3v5JkA=;
        b=eIVWBMZawG1psqVjOZiZanO/BQ2VSLq8NLoiJb0IXdy9xayPA7uYHHQ/PnnaZCszmZFECu
        RVc/TpnhYGDL8phHLgu+fkZIOFJKGTBiZCz8syhVKy809yLcWNvMwEQ9G++I2DGm3hS+IU
        +CSVb6nHNk+WQZTciXnA/J4QMLKSd3c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f4dd807b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 21 Oct 2022 01:01:53 +0000 (UTC)
Date:   Thu, 20 Oct 2022 21:01:32 -0400
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ndesaulniers@google.com
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <Y1HvbO6wnhoHrszN@zx2c4.com>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <CAHk-=wit-67VU=kt-8Ojtx04m6wxfqypKLzW7CuSeEH_9MYZvw@mail.gmail.com>
 <Y1CP/uJb1SQjyS0n@zx2c4.com>
 <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
 <202210201056.DEE610F6F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210201056.DEE610F6F@keescook>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 11:41:29AM -0700, Kees Cook wrote:
> On Wed, Oct 19, 2022 at 05:38:55PM -0700, Linus Torvalds wrote:
> > Having some scripting automation that just notices "this changes code
> > generation in function X" might actually be interesting, and judging
> > by my quick tests might not be *too* verbose.
> 
> On the reproducible build comparison system[1] we use for checking a lot
> of the KSPP work for .text deltas, an allmodconfig finds a fair bit for
> this change. Out of 33900 .o files, 1005 have changes.
> 
> Spot checking matches a lot of what you found already...
> 
>         u64 flags = how->flags;
> 	...
> fs/open.c:1123:
>         int acc_mode = ACC_MODE(flags);
> -    1c86:      movsbl 0x0(%rdx),%edx
> +    1c86:      movzbl 0x0(%rdx),%edx
> 
> #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
> 
> Ignoring those, it goes down to 625, and spot checking those is more
> difficult, but looks to be mostly register selection changes dominating
> the delta. The resulting vmlinux sizes are identical, though.
> 
> -Kees
> 
> [1] A fancier version of:
>     https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/

Say, don't we have some way of outputting LLVM IL? I saw some
-fno-discard-value-names floating through a few days ago. Apparently you
can do `make LLVM=1 fs/select.ll`? This might have less noise in it.
I'll play on the airplane tomorrow.

Jason
