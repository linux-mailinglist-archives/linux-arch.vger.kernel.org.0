Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD24E4464
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 17:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbiCVQmh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiCVQmh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 12:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B3B6F488;
        Tue, 22 Mar 2022 09:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78CBC6139D;
        Tue, 22 Mar 2022 16:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614B7C340F0;
        Tue, 22 Mar 2022 16:41:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d9+Hm23L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647967258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l5rpXjmPcBTfEaF5x2A6SfHzpx6gUr6w2+Nw/IurYTg=;
        b=d9+Hm23LlFsgFDGFsiK6RCL0IUjJeA/CIu7jBhXNhRImc6Dn053smPLcFNPYGaRy9m5MZL
        JR53y/6ADMFtecTsPv1zawa5lqEQvgNX9y+LL9yzWjBHsSaCaMePCbtVOqJ0czCK9l89h9
        4cdkgFbuvvJJ5hm+KyE+R2GVuOJDGfc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 821dbfd1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 16:40:57 +0000 (UTC)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2e592e700acso197526167b3.5;
        Tue, 22 Mar 2022 09:40:57 -0700 (PDT)
X-Gm-Message-State: AOAM530SrVNTTCV0bctapuzOup+4OEPE6Ssd3OiP5Z0IiS5nZ0zSixGq
        677Gui3LQYYylNfJFZkZdZCUhE+qc1ndIbjMPJI=
X-Google-Smtp-Source: ABdhPJwWWjwObwxZwLEgPdBLPF+2AvDiuPO05kGNqIv6Szrvldw4K84HJ0Npj7NucnYS6JJrp+tQkfFLirD1mrusEzw=
X-Received: by 2002:a0d:eb02:0:b0:2e5:9d37:58ba with SMTP id
 u2-20020a0deb02000000b002e59d3758bamr30618415ywe.231.1647967254689; Tue, 22
 Mar 2022 09:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
 <CAHk-=wjH7rNyP_S7ut3EUPfa_dOYAP1T6yOxS6hdVi3zPV9SzA@mail.gmail.com>
In-Reply-To: <CAHk-=wjH7rNyP_S7ut3EUPfa_dOYAP1T6yOxS6hdVi3zPV9SzA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 22 Mar 2022 10:40:43 -0600
X-Gmail-Original-Message-ID: <CAHmME9pTX8MK-cJC0zSMU0PBtyE3iTFQTCRoM8RG1zA+fCaTBw@mail.gmail.com>
Message-ID: <CAHmME9pTX8MK-cJC0zSMU0PBtyE3iTFQTCRoM8RG1zA+fCaTBw@mail.gmail.com>
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

On Tue, Mar 22, 2022 at 10:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 22, 2022 at 8:58 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > This patch (or a later version of it) made it into mainline and causes a
> > large number of qemu boot test failures for various architectures (arm,
> > m68k, microblaze, sparc32, xtensa are the ones I observed). Common
> > denominator is that boot hangs at "Saving random seed:". A sample bisect
> > log is attached. Reverting this patch fixes the problem.
>
> Ok, it was worth trying, but yeah, it clearly causes problems for
> various platforms that can't do jitter entropy and have nothing else
> happening either.
>
> Will revert.

Shucks. I wish I had a good argument here, but I suppose the most I
can say is maybe we'll be able to revisit it some time off. I'll send
you the revert patch in a minute.

Jason
