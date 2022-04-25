Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FF450DE86
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiDYLPJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Apr 2022 07:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiDYLPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2022 07:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDDA27B1C;
        Mon, 25 Apr 2022 04:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98433611BB;
        Mon, 25 Apr 2022 11:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F73BC385A4;
        Mon, 25 Apr 2022 11:11:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Fb81gOwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650885113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pyGMSlT7TKWMqyO7rxkqbT4wkDaJbn9bAIlXs0o1pvk=;
        b=Fb81gOwC3EH8unqp6LruzR4yJE1OPRBE1EZPUHJw+CxmH9eHpWvyJQv76wzpowvU+ZAu0Y
        H2zothHVmufGsf9HWMj5327ATZll2C+DDvP2eA0Cnok2buZ+Mdv6RQNOwuozlzigFulERw
        hfLhJH2Hy88KUXsF+R2lEgdjz2WG55k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bed3e851 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 11:11:53 +0000 (UTC)
Date:   Mon, 25 Apr 2022 13:11:45 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v1] random: block in /dev/urandom
Message-ID: <YmaB8TifJ7EWW1Xi@zx2c4.com>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com>
 <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
 <20220423135631.GB3958174@roeck-us.net>
 <YmRrUYfsXkF3XZ5S@zx2c4.com>
 <5dfb14f4-23c6-1aa9-9ab3-bd5373ceaa64@roeck-us.net>
 <YmXncURQMUHOS0IQ@zx2c4.com>
 <8c27dfab-db37-651e-2828-78309755cb87@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c27dfab-db37-651e-2828-78309755cb87@roeck-us.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guenter,

On Sun, Apr 24, 2022 at 06:54:10PM -0700, Guenter Roeck wrote:
> On 4/24/22 17:12, Jason A. Donenfeld wrote:
> > Hi Guenter,
> > 
> > On Sat, Apr 23, 2022 at 07:04:26PM -0700, Guenter Roeck wrote:
> >> I'll run another test tonight.
> > 
> > Super, thanks. Looking forward to learning what transpires. Hopefully
> > all pass this time through...
> > 
> 
> Build results:
> 	total: 147 pass: 146 fail: 1
> Failed builds:
> 	m68k:allmodconfig
> Qemu test results:
> 	total: 489 pass: 489 fail: 0
> 
> The failure is inherited from mainline, so all looks good.

That is excellent news! Thanks again for testing.

So what this means is: the rationale for reverting the /dev/random +
/dev/urandom unification has now been fixed. That's some real tangible
progress.

Now, I don't want to rush into trying the unification again too soon. I
think if anything, the lesson from the first attempt wasn't simply, "I
should fix a few of Guenter's test cases," but rather that the problem
is fairly nuanced and will take a lot wider testing and research.
However, the fact that the initial thing, across multiple platforms,
that lead to the revert has been fixed gives me a decent amount of
optimism that at /some point/ down the road, we'll be able to try this
again. One step at a time.

Jason
