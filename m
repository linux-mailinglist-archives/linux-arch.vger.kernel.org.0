Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5E4E461E
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiCVSin (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 14:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbiCVSiX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 14:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D684D279;
        Tue, 22 Mar 2022 11:36:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C173615FD;
        Tue, 22 Mar 2022 18:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143F8C340F6;
        Tue, 22 Mar 2022 18:36:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="U6eTZV/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647974210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PFNl2hhMhFSK/CjCgits39oiGFWK73F16o9EWoPZX7Y=;
        b=U6eTZV/jEq7GcZ7SXAwdSpLlLP1XFmZKMdWHADW/M1rz11ul0qik8F2ClsditzoBrJMXKl
        6pO+qMEQ65jzy6oOlrGqJzILBtCk8bv//uOd4pWHQphuHCWAM6yW0fDbF3LqT1UpjvMTLF
        akBYSubeYcp6dhVPyRY/0GD5oQQHVGk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e8345de8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 18:36:50 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id z8so35270844ybh.7;
        Tue, 22 Mar 2022 11:36:49 -0700 (PDT)
X-Gm-Message-State: AOAM530rC/KDqezWoWTCmr6czTbMN7ERT25zw9UGbOifS/zjOPsxJ0h8
        i+O3wwgrakrLLbcD5LiY0QReXDNjZK5ugWSS6RU=
X-Google-Smtp-Source: ABdhPJzMi7Riq+0tA+ngc/YdK6aVhmhPnJ7JnVdbmSZAB21cxagMr9oxQwdK2c8/x/OwKm/fAz9e7XzjfCLosl7CGuc=
X-Received: by 2002:a25:b905:0:b0:61e:23e4:949f with SMTP id
 x5-20020a25b905000000b0061e23e4949fmr29614489ybj.373.1647974206146; Tue, 22
 Mar 2022 11:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com> <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <YjoTJFRook+rGyDI@zx2c4.com> <CAHk-=wiq3bKDdt7noWOaMnDL-yYfFHb1CEsNkk8huq4O7ByetA@mail.gmail.com>
In-Reply-To: <CAHk-=wiq3bKDdt7noWOaMnDL-yYfFHb1CEsNkk8huq4O7ByetA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 22 Mar 2022 12:36:35 -0600
X-Gmail-Original-Message-ID: <CAHmME9oi-XM--3c4fbM6LydM_Q7CTBdEzKC9fDEE7gXcwUwtcw@mail.gmail.com>
Message-ID: <CAHmME9oi-XM--3c4fbM6LydM_Q7CTBdEzKC9fDEE7gXcwUwtcw@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Linus,

On Tue, Mar 22, 2022 at 12:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Christ, how I hate the crazy "no entropy means that we can't use it".
>
> It's a disease, I tell you.
>
> And it seems to be the direct cause of this misfeature.

A disease indeed.

> By all means the code can say "I can't credit this as entropy", but
> the fact that it then doesn't even mix it into the fast pool is just
> wrong, wrong, wrong.
>
> I think *that* is what we should fix. The fact is, urandom has
> long-standing semantics as "don't block", and that it shouldn't care
> about the (often completely insane) entropy crediting rules.
>
> But that "don't care about entropy rules" should then also mean "oh,
> we'll mix things in even if we don't credit entropy".
>
> I hope that's the easy fix you are thinking about.

Yes, exactly. And the patch to fix it is literally 2 lines. I'm
playing with it now and I'll think about it a bit and hopefully have
something for you to pull not before long.

In general, your intuition is correct, I think, that the entropy
crediting scheme is sort of insane and leads to problems. As I wrote
in <https://www.zx2c4.com/projects/linux-rng-5.17-5.18/> at the end,
other RNG schemes like Fortuna don't really suffer from this in the
same way because they're not even counting entropy. This might be
something to look at seriously in the future.

Jason
