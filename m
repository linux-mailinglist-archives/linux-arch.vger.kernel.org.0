Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6E60544C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 02:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiJTACV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 20:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiJTACS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 20:02:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A31870B2;
        Wed, 19 Oct 2022 17:02:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 69731CE24C6;
        Thu, 20 Oct 2022 00:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D6DC433C1;
        Thu, 20 Oct 2022 00:02:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pNySuLQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666224128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QdiTrD4WRRi0FnFVPAP7IMCKeplG6Uwrive2CyE+3Ps=;
        b=pNySuLQh14w537yyHgsQHnDwsqOQA2ANKrrcA6IZcLUYTjdg6wXflf/bSRWyiy9ieNA+5Y
        uqCJKo+GL0UxOqeOWorCgjZ0ZQBFisuALuiCyM9dtLKO2Xw4bNArFqukyFTc/ByjmCf9G/
        xguHH8FdWAhU64Fw3O3FpwaF07YxsjU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e61d4d12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Oct 2022 00:02:07 +0000 (UTC)
Date:   Thu, 20 Oct 2022 02:02:06 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Message-ID: <Y1CP/uJb1SQjyS0n@zx2c4.com>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <CAHk-=wit-67VU=kt-8Ojtx04m6wxfqypKLzW7CuSeEH_9MYZvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wit-67VU=kt-8Ojtx04m6wxfqypKLzW7CuSeEH_9MYZvw@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 04:56:03PM -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 1:30 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > So let's just eliminate this particular variety of heisensign bugs
> > entirely. Set `-funsigned-char` globally, so that gcc makes the type
> > unsigned on all architectures.
> >
> > This will break things in some places and fix things in others, so this
> > will likely cause a bit of churn while reconciling the type misuse.
> 
> Yeah, if we were still in the merge window, I'd probably apply this,
> but as things stand, I think it should go into linux-next and cook
> there for the next merge window.
> 
> Anybody willing to put this in their -next trees?

Sure, happy to take it.


> 
> Any breakage it causes is likely going to be fairly subtle, and in
> some random driver that isn't used on architectures that already have
> an unsigned 'char' type.
> 
> I think the architectures with an unsigned 'char' are arm, powerpc and
> s390, in all their variations (ie both 32- and 64-bit).
> 
> So all *core* code should be fine with this, but that still leaves a
> lot of drivers that have likely never been tested on anything but x86,
> and could just stop working.
> 
> I don't think breakage is very *likely*, but I suspect it exists.

Given I've started with cleaning up one driver already, I'll keep my eye
on further breakage.

Jason

> 
>                        Linus
