Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8333A4E45DB
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 19:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiCVSU6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 14:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240234AbiCVSU4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 14:20:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF786FF6B;
        Tue, 22 Mar 2022 11:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAE84B81D57;
        Tue, 22 Mar 2022 18:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB13C340EC;
        Tue, 22 Mar 2022 18:19:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="f7++ytaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647973161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kC3rlTX6IZ1qsGZ7LbDOlnDblc/s2ccWEzBAw4VZMDc=;
        b=f7++ytaT+H4u8qIP3z8QM4EFX6FAMoDH590KSUK64ZOpOrVJ5PuZLQuBMwkGrSFTEN1k/a
        d05Aa9C/shaEo0E+EIQY7x2vghRnB6o4FvQbDIhwvvXfNkxlVtbdf2zIVQKm0FLTxA2H1K
        /o8yXOT4AC4cjLQqpX6LcrKPdfygCxQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 262f21e8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 18:19:20 +0000 (UTC)
Date:   Tue, 22 Mar 2022 12:19:16 -0600
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
Message-ID: <YjoTJFRook+rGyDI@zx2c4.com>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com>
 <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guenter,

On Tue, Mar 22, 2022 at 10:56:44AM -0700, Guenter Roeck wrote:
> Everything - including the various root file systems - is at
> git@github.com:groeck/linux-build-test.git. Look into rootfs/ for the
> various boot tests. I'll be happy to provide some qemu command lines
> if needed.

Thanks. It looks like the "problem" is with this shell script:

  init_rng() {
    if check_file_size; then
      printf 'Initializing random number generator: '
      dd if="$URANDOM_SEED" bs="$pool_size" of=/dev/urandom count=1 2> /dev/null
      status=$?
      if [ "$status" -eq 0 ]; then
        echo "OK"
      else
        echo "FAIL"
      fi
      return "$status"
    fi
  }
  
  save_random_seed() {
    printf 'Saving random seed: '
    if touch "$URANDOM_SEED" 2> /dev/null; then
      old_umask=$(umask)
      umask 077
      dd if=/dev/urandom of="$URANDOM_SEED" bs="$pool_size" count=1 2> /dev/null
      status=$?
      umask "$old_umask"
      if [ "$status" -eq 0 ]; then
        echo "OK"
      else
        echo "FAIL"
      fi
    else
      status=$?
      echo "SKIP (read-only file system detected)"
    fi
    return "$status"
  }

  case "$1" in
    start|restart|reload)
      # Carry a random seed from start-up to start-up
      # Load and then save the whole entropy pool
      init_rng && save_random_seed;;

This code is actually problematic for a number of reasons. (And Linus,
I'm not saying "userspace is wrong" to justify breaking it or something,
don't worry.)

The first `dd if="$URANDOM_SEED" bs="$pool_size" of=/dev/urandom count=1`
will write the seed into the input pool, but:

  - It won't credit the entropy from that seed, so the pool won't
    actually initialize. (You need to use the ioctl to credit it.)
  - Because the pool doesn't initialize, subsequent reads from
    /dev/urandom won't actually use that seed.

The first point is why we had to revert this patch. But the second one
is actually a bit dangerous: you might write in a perfectly good seed to
/dev/urandom, but what you read out for the subsequent seed may be
complete deterministic crap. This is because the call to write_pool()
goes right into the input pool and doesn't touch any of the "fast init"
stuff, where we immediately mutate the crng key during early boot.

As far as I can tell, this has been the behavior for a really long time,
making the above innocuous pattern a pretty old thing that's broken. So
I could perhaps say, "this behavior is so old now, that your userspace
code is just plain broken," but I think I might actually have a very
quick unobtrusive fix for this. I'll mull some things over for rc2 or
later in rc1.

But, anyway, this only fixes the second point mentioned above. The first
one -- which resulted in the revert -- remains a stumper for now.

Jason
