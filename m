Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B976C4E4435
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 17:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiCVQ3i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiCVQ3h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 12:29:37 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57963D483
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 09:28:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l20so30629010lfg.12
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24K1hLJb9rmuEHEKW5a8QYhjnmRyomvMSDjxeIg/X38=;
        b=VYS/UqPlwEg8dUg0nl76d7UJ1IUszygkxcr1j2/1mvgghsV+p3mYrgwsp34aOKQ6tk
         ScvhZMD1nx0OBvbT+5UaohuxHTKJjXselVVpziaLmccjKez67+onMBakhk/M73Kxl+Ut
         p2gOZHShBVjr2xBbgB8NPD9eut9eQpbmThYAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24K1hLJb9rmuEHEKW5a8QYhjnmRyomvMSDjxeIg/X38=;
        b=a8EqkZMuOf/3tR4Dmmhi19JRxjoA/0fI1W3zJhnOqQvOiOEbUpGpWfjWdRuECtRt1M
         AMjqcNcy0g+h3SCWRpBv8HJX1Mm3L0Gspjg4N+TMbFkV+62+e9uz9vdc4gZs10kxmbH5
         c6nQDrGfTT9n8DC2Lyi1Dct2OMFLXneLaW/XOpUhHbooj2PXB5IvnG87V+y5xaf8SkT+
         tbmeqMyxUL54M2FXAFLuL1ECuHp7P1fjUM+wFJJ5wqOIZI5J54Dd1Q/dMkg28yAz+kru
         G081mZvsVLcxaldsg1YIPPlw9R58F5P1UW+xLSDhw+qXNkrNrikvqgAox4XgD2Y7CivP
         mjtg==
X-Gm-Message-State: AOAM531j/+4i7Ovrx+vrzRZQQD2QZmTR5CPzgtMnEeCUFH7/ZTOytjje
        9mRWYhfvJol53jobj3ejLl0mz76T4cG4JDJR0OU=
X-Google-Smtp-Source: ABdhPJxdFaOydgfjJAkuDDgdG8bvLd3oS1m8l2CxU6KAHY4JNlPH+czQpJs1OAERi1OQMJDA5rUgow==
X-Received: by 2002:a05:6512:1594:b0:44a:2d71:f14d with SMTP id bp20-20020a056512159400b0044a2d71f14dmr7212780lfb.446.1647966483670;
        Tue, 22 Mar 2022 09:28:03 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id c27-20020a2ebf1b000000b00247eba13667sm2488952ljr.16.2022.03.22.09.28.03
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 09:28:03 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id g24so23473424lja.7
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 09:28:03 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr19763021ljc.506.1647966097175; Tue, 22
 Mar 2022 09:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
In-Reply-To: <20220322155820.GA1745955@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 09:21:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH7rNyP_S7ut3EUPfa_dOYAP1T6yOxS6hdVi3zPV9SzA@mail.gmail.com>
Message-ID: <CAHk-=wjH7rNyP_S7ut3EUPfa_dOYAP1T6yOxS6hdVi3zPV9SzA@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 8:58 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch (or a later version of it) made it into mainline and causes a
> large number of qemu boot test failures for various architectures (arm,
> m68k, microblaze, sparc32, xtensa are the ones I observed). Common
> denominator is that boot hangs at "Saving random seed:". A sample bisect
> log is attached. Reverting this patch fixes the problem.

Ok, it was worth trying, but yeah, it clearly causes problems for
various platforms that can't do jitter entropy and have nothing else
happening either.

Will revert.

Thanks.

               Linus
