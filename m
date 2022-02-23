Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0804E4C1A50
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiBWR5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 12:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiBWR5i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 12:57:38 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB93C728;
        Wed, 23 Feb 2022 09:57:09 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21NHttsY015836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 12:55:55 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 25DFF15C0036; Wed, 23 Feb 2022 12:55:55 -0500 (EST)
Date:   Wed, 23 Feb 2022 12:55:55 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.osdn.me>,
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
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1] random: block in /dev/urandom
Message-ID: <YhZ1Kxmhs4ObbXOB@mit.edu>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <6e117393-9c2f-441c-9c72-62c209643622@www.fastmail.com>
 <CAHmME9qcUM+G8E3ag5iPfowUF4-iYATODGK+MoLjkfaipnkgjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qcUM+G8E3ag5iPfowUF4-iYATODGK+MoLjkfaipnkgjA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 23, 2022 at 06:02:52PM +0100, Jason A. Donenfeld wrote:
> 
> I think your analysis is a bit mismatched from the reality of the
> situation. That reality is that cryptographic users still find
> themselves using /dev/urandom, as that's been the "standard good
> advice" for a very long time. And people are still encouraged to do
> that, either out of ignorance or out of "compatibility". The
> cryptographic problem is not going away.

Or they open /dev/urandom because getrandom() and getentropy() isn't
available on some OS's (all the world is not Linux, despite what the
systemd folks like to believe), and some other OS's have a
/dev/urandom-like device that they can open, and so it's just more
convenient for application programers to open and read from
/dev/urandom.

> Fixing this issue means, yes, adding a 1 second delay to the small
> group of init system users who haven't switched to using
> getrandom(GRND_INSECURE) for that less common usage (who even are
> those users actually?). That's not breaking compatibility or breaking
> userspace or breaking anything; that's accepting the reality of _how_
> /dev/urandom is mostly used -- for crypto -- and making that usage
> finally secure, at the expense of a 1 second delay for those other
> users who haven't switched to getrandom(GRND_INSECURE) yet. That seems
> like a _very_ small price to pay for eliminating a footgun.

I agree.  So long as we're only blocking for short amount of time, and
only during early after the system was booted, people shouldn't care.
The reason why we had to add the "gee-I-hope-this-jitterentropy-like-
hack-is-actually-secure on all architectures but it's better than the
alternatives people were trying to get Linus to adopt" was because
there were systems were hanging for hours or days.

      	   	   		    	  - Ted
