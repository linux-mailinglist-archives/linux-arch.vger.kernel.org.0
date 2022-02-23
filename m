Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CCD4C1939
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 18:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbiBWRDs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 12:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241607AbiBWRDr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 12:03:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9967F4ECF4;
        Wed, 23 Feb 2022 09:03:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48D1DB82117;
        Wed, 23 Feb 2022 17:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CD2C340F6;
        Wed, 23 Feb 2022 17:03:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CDnOLrRM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645635788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pp12ena6dYDhd7GMsoT5AC0lytZr3q+Tcps8HSwUknA=;
        b=CDnOLrRMtk4VRy2HmVtFBTs/Gbq3hrc0eMc9ePBYzEqT6grdqpdnNipnlYVZf6F4Vk0SHW
        UBQv2m2COWqYCowr3DsdzXxn0vhuP6gQQGak8DDHGqSPEvUdh4/AM8Yx8yjWa1bZLEBZ8R
        Dd+0HBkIG2pLvh7UELcEVRGSKfRHDjw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dd0a54aa (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Feb 2022 17:03:07 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id w63so28048122ybe.10;
        Wed, 23 Feb 2022 09:03:06 -0800 (PST)
X-Gm-Message-State: AOAM531s7hJD0rB4w0QrH/mhacpYiJzfuDv05Xe+rwHYV9wz2ZyrMotI
        oR7hN9EUKngAMLui61Z0frjP0/OLK0ReMztertk=
X-Google-Smtp-Source: ABdhPJwPRBaPOjS3KtoDamJStmC6n2tfcA0U7gkU1wr5DyfkQa76VS2mekyDcU8DDIo2C3IK2X3TBhpqi9a0bun2Qt0=
X-Received: by 2002:a05:6902:693:b0:613:7f4f:2e63 with SMTP id
 i19-20020a056902069300b006137f4f2e63mr567022ybt.271.1645635783597; Wed, 23
 Feb 2022 09:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <6e117393-9c2f-441c-9c72-62c209643622@www.fastmail.com>
In-Reply-To: <6e117393-9c2f-441c-9c72-62c209643622@www.fastmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 23 Feb 2022 18:02:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9qcUM+G8E3ag5iPfowUF4-iYATODGK+MoLjkfaipnkgjA@mail.gmail.com>
Message-ID: <CAHmME9qcUM+G8E3ag5iPfowUF4-iYATODGK+MoLjkfaipnkgjA@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy,

I think your analysis is a bit mismatched from the reality of the
situation. That reality is that cryptographic users still find
themselves using /dev/urandom, as that's been the "standard good
advice" for a very long time. And people are still encouraged to do
that, either out of ignorance or out of "compatibility". The
cryptographic problem is not going away.

Fixing this issue means, yes, adding a 1 second delay to the small
group of init system users who haven't switched to using
getrandom(GRND_INSECURE) for that less common usage (who even are
those users actually?). That's not breaking compatibility or breaking
userspace or breaking anything; that's accepting the reality of _how_
/dev/urandom is mostly used -- for crypto -- and making that usage
finally secure, at the expense of a 1 second delay for those other
users who haven't switched to getrandom(GRND_INSECURE) yet. That seems
like a _very_ small price to pay for eliminating a footgun.

And in general, deemphasizing the rare performance of the less common
usage in favor of fixing a commonly triggered footgun seems on par
with how things morph and change over time. There's no actual
breakage. There's no ABI change violation. What you're saying simply
isn't so.

In other words, I'm not really at all convinced by what you're saying.

Jason
