Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC71450CB30
	for <lists+linux-arch@lfdr.de>; Sat, 23 Apr 2022 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiDWOc2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 23 Apr 2022 10:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiDWOcJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Apr 2022 10:32:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD3289B4;
        Sat, 23 Apr 2022 07:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4B8DB80688;
        Sat, 23 Apr 2022 14:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4A0C385A5;
        Sat, 23 Apr 2022 14:29:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Q7s5qcAl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650724145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGCSqF1/roTZOFlPi0CAeOLjCByjkUs4ceONVf8EcjA=;
        b=Q7s5qcAlnaV2fXpBY0hm9KYIo+Hg3/6ZvLqT+99ji+Hw01JNZx+N4iQrs5Y0OfnyutZiLR
        5TfEn1Dua7iWhpV9RFf2rn0UnqflYZuOjkqtA1nRCwovp1F0M70CjFwls9SctZ5VpNUtoL
        n7oR4/5UP1MyXic5d1en9mp8GRuc26c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 27a510e4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 23 Apr 2022 14:29:04 +0000 (UTC)
Date:   Sat, 23 Apr 2022 16:28:59 +0200
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
Message-ID: <YmQNK2uicWbklo7U@zx2c4.com>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com>
 <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
 <20220423135631.GB3958174@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220423135631.GB3958174@roeck-us.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guenter,

On Sat, Apr 23, 2022 at 06:56:31AM -0700, Guenter Roeck wrote:
> Looks like your code is already in -next; I see the same failures in
> your tree and there.

It's not in next, actually. The branch I made for you has that
additional testing commit.

Jason
