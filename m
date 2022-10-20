Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99026055AF
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 05:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJTDAG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 23:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJTDAF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 23:00:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690E1E09C1;
        Wed, 19 Oct 2022 20:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30053B82660;
        Thu, 20 Oct 2022 03:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02FBC433D6;
        Thu, 20 Oct 2022 02:59:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fU541ryY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666234796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZNUaZDaHnzZsUmQctOVwbGgLyndW6prLbOXUbqsna0=;
        b=fU541ryY3FgZlW4sy4ZBU2+3tuFup0EiTiAzLaXAMN1R88EcqVK7kqDHzbrgpE8O2EDtdx
        z3NaSZd3R3nk15Y1zIh3kjGP3UgbUcUFi8+xMhwPm5vTuWVK7SET0bG61Nty/K7ytPES2t
        ocFi3PpAuYJskEbIOHYho0vam5dn0vA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3befa121 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 20 Oct 2022 02:59:55 +0000 (UTC)
Date:   Wed, 19 Oct 2022 20:59:53 -0600
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
Message-ID: <Y1C5qZ4sSGuUfXmF@zx2c4.com>
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <CAHk-=wit-67VU=kt-8Ojtx04m6wxfqypKLzW7CuSeEH_9MYZvw@mail.gmail.com>
 <Y1CP/uJb1SQjyS0n@zx2c4.com>
 <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whg00wpUzNLs0obmMKA3GhUnLzat9syA1=_tfi8Ms8TLg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 05:38:55PM -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 5:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Given I've started with cleaning up one driver already, I'll keep my eye
> > on further breakage.
> 
> I wonder if we could just check for code generation differences some way.
> Having some scripting automation that just notices "this changes code
> generation in function X" might actually be interesting, and judging
> by my quick tests might not be *too* verbose.

Or even just some allyesconfig diffing. 

> I tested a couple of files, and was able to find differences, eg
> 
>   # kernel/sched/core.c:8861: pr_info("task:%-15.15s state:%c",
> p->comm, task_state_to_char(p));
>  - movzbl state_char.149(%rax), %edx # state_char[_60], state_char[_60]
>  + movsbl state_char.149(%rax), %edx # state_char[_60], state_char[_60]
>    call _printk #
> 
> because the 'char' for the '%c' is passed as an integer. And the

Seems harmless though.

> tracing code has the
> 
>         .is_signed = is_signed_type(_type)
> 
> initializers, which obviously change when the type is 'char'.

And likewise, looking at the types of initializers that's used with.
Actually, for the array one, unsigned is probably more sensible anyway.

The thing is, anyhow, that most code that works without -funsigned-char
*will* work with it, because the core of the kernel obviously works fine
on ARM already. The problematic areas will be x86-specific drivers that
have never been tested on other archs. i915 comes to mind -- as a
general rule, it already does all manner of insane things. But there's
obviously a lot of other hardware that's only ever run on Intel. So I'm
much more concerned about that than I am about code in, say, kernel/sched.

Jason
