Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D70F4E44C4
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 18:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiCVRLi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbiCVRLg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 13:11:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745997890C;
        Tue, 22 Mar 2022 10:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1C3F614BA;
        Tue, 22 Mar 2022 17:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B984C340F0;
        Tue, 22 Mar 2022 17:10:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Umso1iRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647969001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gPX0nJxefwWFFSNK75somPtzsLvzvt9oMVqDAB0yArg=;
        b=Umso1iRg6iLt1J9W2agcmRvJm8/SwpH5XzKQ2jWhqRWp2rJMQFPahsU7BNThUuO3/kTZrU
        BzyfqemUzgGr2R9+Jlb2Zw0o2gCLNOns0Ma4jGaIgkzGU78vKHYj/MrBuIFFD4YHluuKbF
        vaCL5KqJKrn+BR1+D5ezEAVXc1tGj+k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f4b3020f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 17:10:01 +0000 (UTC)
Date:   Tue, 22 Mar 2022 11:09:58 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arch@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
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
Message-ID: <YjoC5kQMqyC/3L5Y@zx2c4.com>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220322155820.GA1745955@roeck-us.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hey Guenter,

On Tue, Mar 22, 2022 at 08:58:20AM -0700, Guenter Roeck wrote:
> On Thu, Feb 17, 2022 at 05:28:48PM +0100, Jason A. Donenfeld wrote:
> > This topic has come up countless times, and usually doesn't go anywhere.
> > This time I thought I'd bring it up with a slightly narrower focus,
> > updated for some developments over the last three years: we finally can
> > make /dev/urandom always secure, in light of the fact that our RNG is
> > now always seeded.
> > 
> 
> [ ... ]
> 
> This patch (or a later version of it) made it into mainline and causes a
> large number of qemu boot test failures for various architectures (arm,
> m68k, microblaze, sparc32, xtensa are the ones I observed). Common
> denominator is that boot hangs at "Saving random seed:". A sample bisect
> log is attached. Reverting this patch fixes the problem.

As Linus said, it was worth a try, but I guess it just didn't work. For
my own curiosity, though, do you have a link to those QEMU VMs you could
share? I'd sort of like to poke around, and if we do ever reattempt this
sometime down the road, it seems like understanding everything about why
the previous time failed might be a good idea.

Jason
