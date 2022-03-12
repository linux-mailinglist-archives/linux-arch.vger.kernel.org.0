Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6D74D70D6
	for <lists+linux-arch@lfdr.de>; Sat, 12 Mar 2022 21:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiCLU20 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Mar 2022 15:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCLU2Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Mar 2022 15:28:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190BE20D51F;
        Sat, 12 Mar 2022 12:27:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2115B80B03;
        Sat, 12 Mar 2022 20:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98142C340EB;
        Sat, 12 Mar 2022 20:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647116835;
        bh=Ie1UhR5izPv39jYtF6t6kb5H5qt3LTLahMQQOGyrXWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKXMLtACco1+OKfG1NIWG98y2K0pSU1C7ZGfarFptU7Zq7GUgeGwzNj77Zg6NaQrq
         dByjyfVjsIvnvpZz3M18TJneHhQWtXAircDQ1Y6cFOUb3uZOGnUH2d4qgRRjNMQHH/
         IQ19JWeZ9qiOKAFGVT0kT2R0/iik0iAy5grhFlc//YTnG7rV77EL3EfHpsnAlLC31S
         MPz9X/DZQ3R4Rv57RYEOGreGLiYzZQBJchi4fV0HrmDL2JraNFgo28ePiDGy6mLvfR
         nZn73YDjj6qzz3aApz9CR5C5fwms8Hvwb3cXTMzaNxsV7p8YcCpVjbuySDIf+fMgcF
         FRuG4OYziJ8qQ==
Date:   Sat, 12 Mar 2022 12:27:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Message-ID: <Yi0CIRlY6/tDpjpf@sol.localdomain>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <Yiz/wm3nlJ/wOo6n@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yiz/wm3nlJ/wOo6n@sol.localdomain>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 12, 2022 at 12:17:09PM -0800, Eric Biggers wrote:
> On Thu, Feb 17, 2022 at 05:28:48PM +0100, Jason A. Donenfeld wrote:
> > This topic has come up countless times, and usually doesn't go anywhere.
> > This time I thought I'd bring it up with a slightly narrower focus,
> > updated for some developments over the last three years: we finally can
> > make /dev/urandom always secure, in light of the fact that our RNG is
> > now always seeded.
> > 
> > Ever since Linus' 50ee7529ec45 ("random: try to actively add entropy
> > rather than passively wait for it"), the RNG does a haveged-style jitter
> > dance around the scheduler, in order to produce entropy (and credit it)
> > for the case when we're stuck in wait_for_random_bytes(). How ever you
> > feel about the Linus Jitter Dance is beside the point: it's been there
> > for three years and usually gets the RNG initialized in a second or so.
> > 
> > As a matter of fact, this is what happens currently when people use
> > getrandom(). It's already there and working, and most people have been
> > using it for years without realizing.
> > 
> > So, given that the kernel has grown this mechanism for seeding itself
> > from nothing, and that this procedure happens pretty fast, maybe there's
> > no point any longer in having /dev/urandom give insecure bytes. In the
> > past we didn't want the boot process to deadlock, which was
> > understandable. But now, in the worst case, a second goes by, and the
> > problem is resolved. It seems like maybe we're finally at a point when
> > we can get rid of the infamous "urandom read hole".
> > 
> > The one slight drawback is that the Linus Jitter Dance relies on random_
> > get_entropy() being implemented. The first lines of try_to_generate_
> > entropy() are:
> > 
> > 	stack.now = random_get_entropy();
> > 	if (stack.now == random_get_entropy())
> > 		return;
> > 
> > On most platforms, random_get_entropy() is simply aliased to get_cycles().
> > The number of machines without a cycle counter or some other
> > implementation of random_get_entropy() in 2022, which can also run a
> > mainline kernel, and at the same time have a both broken and out of date
> > userspace that relies on /dev/urandom never blocking at boot is thought
> > to be exceedingly low. And to be clear: those museum pieces without
> > cycle counters will continue to run Linux just fine, and even
> > /dev/urandom will be operable just like before; the RNG just needs to be
> > seeded first through the usual means, which should already be the case
> > now.
> > 
> > On systems that really do want unseeded randomness, we already offer
> > getrandom(GRND_INSECURE), which is in use by, e.g., systemd for seeding
> > their hash tables at boot. Nothing in this commit would affect
> > GRND_INSECURE, and it remains the means of getting those types of random
> > numbers.
> > 
> > This patch goes a long way toward eliminating a long overdue userspace
> > crypto footgun. After several decades of endless user confusion, we will
> > finally be able to say, "use any single one of our random interfaces and
> > you'll be fine. They're all the same. It doesn't matter." And that, I
> > think, is really something. Finally all of those blog posts and
> > disagreeing forums and contradictory articles will all become correct
> > about whatever they happened to recommend, and along with it, a whole
> > class of vulnerabilities eliminated.
> > 
> > With very minimal downside, we're finally in a position where we can
> > make this change.
> > 
> > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > Cc: Nick Hu <nickhu@andestech.com>
> > Cc: Max Filippov <jcmvbkbc@gmail.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: David S. Miller <davem@davemloft.net>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Michal Simek <monstr@monstr.eu>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Joshua Kinard <kumba@gentoo.org>
> > Cc: David Laight <David.Laight@aculab.com>
> > Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> > Cc: Eric Biggers <ebiggers@google.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Lennart Poettering <mzxreary@0pointer.de>
> > Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> > Having learned that MIPS32 isn't affected by this (initially my largest
> > worry), and then heartened today upon reading LWN's summary of our
> > previous discussion ("it would seem there are no huge barriers to
> > removing the final distinction between /dev/random and /dev/urandom"), I
> > figured I'd go ahead and submit a v1 of this. It seems at least worth
> > trying and seeing if somebody arrives with legitimate complaints. To
> > that end I've also widened the CC list quite a bit.
> > 
> > Changes v0->v1:
> > - We no longer touch GRND_INSECURE at all, in anyway. Lennart (and to an
> >   extent, Andy) pointed out that getting insecure numbers immediately at
> >   boot is still something that has legitimate use cases, so this patch
> >   no longer touches that code.
> > 
> >  drivers/char/mem.c     |  2 +-
> >  drivers/char/random.c  | 51 ++++++------------------------------------
> >  include/linux/random.h |  2 +-
> >  3 files changed, 9 insertions(+), 46 deletions(-)
> > 
> 
> Just a small nit: the comments above rng_is_initialized() and
> wait_for_random_bytes() still imply that /dev/urandom is nonblocking.
> 

Also the comment describing 'Fast key erasure RNG, the "crng".' still claims
that get_random_bytes(), get_random_u32(), etc. are "equivalent to a read from
/dev/urandom".  With this patch, they're not, since they don't block whereas
/dev/urandom will block.

- Eric
