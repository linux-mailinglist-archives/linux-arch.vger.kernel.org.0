Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBA37680D1
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jul 2023 19:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjG2RqX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jul 2023 13:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjG2RqW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jul 2023 13:46:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBBB2D4A;
        Sat, 29 Jul 2023 10:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C035D601FE;
        Sat, 29 Jul 2023 17:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8269FC433C8;
        Sat, 29 Jul 2023 17:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690652780;
        bh=e0zotVZ/XJUIPJGVsTb6UzBe7NAqRNMMif2hVV4YiQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZbtbH5WKJMuGws0Luokb+CuDmaBKbUK73w3QZie77uZxhedU9WqstnZvDo3dVwD9
         NKYZsseSEnQSPungkiwE0y8+hOJNLE8tIi3KQ6EuqArgdBEVZ4nFJGlkY9LSe6R6FT
         0EwLoNPg8BMybjeUnKIM9zadswk2O7XaWdGl7zfdjqCoGhjismZd+XOwWdND4cQ64H
         4O5qJrLekx0s9mb6RhGZrLUkCt9wqsQd2FRSGWtTe9ul0wnbLxeJ+CHMK94UyMN+WB
         eV7cfQpBj4tdS+BlsS2FK1aRi3IJPpIkRkOX6I7At4hdt6gUfuG+Y7MUbKAgQFdaU2
         5IRSLh+6capaA==
Date:   Sat, 29 Jul 2023 10:46:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 1/2] asm-generic: Unify uapi bitsperlong.h for arm64,
 riscv and loongarch
Message-ID: <20230729174617.GA1229655@dev-arch.thelio-3990X>
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
 <1687443219-11946-2-git-send-email-yangtiezhu@loongson.cn>
 <20230727213648.GA354736@dev-arch.thelio-3990X>
 <1777400a-4d9c-4bdb-9d3b-f8808ef054cc@app.fastmail.com>
 <20230728173103.GA1299743@dev-arch.thelio-3990X>
 <a2fa1a31-e8bb-4659-9631-398b564e7c2b@app.fastmail.com>
 <20230728234429.GA611252@dev-arch.thelio-3990X>
 <e7a792d9-39b9-440a-9c22-99e25b25a396@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a792d9-39b9-440a-9c22-99e25b25a396@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 29, 2023 at 09:59:23AM +0200, Arnd Bergmann wrote:
> On Sat, Jul 29, 2023, at 01:44, Nathan Chancellor wrote:
> > On Fri, Jul 28, 2023 at 10:56:38PM +0200, Arnd Bergmann wrote:
> 
> >     DESCEND objtool
> >   In file included from 
> > /usr/include/aarch64-linux-gnu/asm/bitsperlong.h:1,
> >                    from /usr/include/asm-generic/int-ll64.h:12,
> >                    from /usr/include/asm-generic/types.h:7,
> >                    from /usr/include/aarch64-linux-gnu/asm/types.h:1,
> >                    from /linux-stable/tools/include/linux/types.h:13,
> >                    from 
> > /linux-stable/tools/arch/x86/include/asm/orc_types.h:9,
> >                    from /linux-stable/scripts/sorttable.h:96,
> >                    from /linux-stable/scripts/sorttable.c:201:
> >   /linux-stable/tools/include/asm-generic/bitsperlong.h:14:2: error: 
> > #error Inconsistent word size. Check asm/bitsperlong.h
> >      14 | #error Inconsistent word size. Check asm/bitsperlong.h
> >         |  ^~~~~
> >   make[3]: *** [/linux-stable/scripts/Makefile.host:114: 
> > scripts/sorttable] Error 1
> >   ...
> >
> >> I also noticed that your command line includes CROSS_COMPILE=x86_64-linux-
> >> rather than CROSS_COMPILE=x86_64-linux-gnu-
> >
> > Right, as I was reproducing this with your kernel.org GCC for
> > CROSS_COMPILE and Fedora's GCC for HOSTCC, since I wanted to make sure
> > this was not some issue with clang (which it does not appear to be).
> 
> Ok, it's beginning to make more sense to me now. I see
> that the tools/arch/x86/include/asm/orc_types.h comes from
> the x86_64 target build and is intentional, as sorttable.c
> needs to access the ORC information. Here the Makefile does
> 
> ifdef CONFIG_UNWINDER_ORC
> ifeq ($(ARCH),x86_64)
> ARCH := x86
> endif
> HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/x86/include
> HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
> endif
> 
> in order to get the ORC definitions from asm/orc_types.h, but
> then it looks like it also gets the uapi/asm/bitsperlong.h
> header from there which contains
> 
> #if defined(__x86_64__) && !defined(__ILP32__)
> # define __BITS_PER_LONG 64
> #else
> # define __BITS_PER_LONG 32
> #endif
> 
> and this would set __BITS_PER_LONG to 32 on arm64.
> 
> However, I don't see this actually being included on my
> machine. Can you dump the sorttable.c preprocessor output
> with your setup, using -fdirectives-only, so we can see
> which of the two (__BITS_PER_LONG or BITS_PER_LONG) is
> actually wrong and triggers the sanity check?

Sure thing, this is the output of:

  $ gcc -I/linux-stable/tools/include -I/linux-stable/tools/arch/x86/include -DUNWINDER_ORC_ENABLED -I ./scripts -E -fdirectives-only /linux-stable/scripts/sorttable.c

https://gist.github.com/nathanchance/d2c3e58230930317dc84aff80fef38bf

> What I see on my machine is that both definitions come
> from the local tools/include/ headers, not from the
> installed system headers, so I'm still doing something
> wrong in my installation:

Just to make sure, you have the 6.5-rc1+ headers installed and you are
attempting to build the host tools from an earlier Linux release than
6.5-rc1? I don't see a problem with building these host programs on
mainline/6.5, I see this issue when building them in older stable
releases (my reproduction so far has been on 6.4 but I see it when
building all currently supported long term stable releases) when I have
the 6.5-rc1+ headers installed.

> ./tools/include/uapi/asm-generic/bitsperlong.h
> #define __BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)

Because this is the mainline version, whereas the stable version is:

#ifndef _UAPI__ASM_GENERIC_BITS_PER_LONG
#define _UAPI__ASM_GENERIC_BITS_PER_LONG

/*
 * There seems to be no way of detecting this automatically from user
 * space, so 64 bit architectures should override this in their
 * bitsperlong.h. In particular, an architecture that supports
 * both 32 and 64 bit user space must not rely on CONFIG_64BIT
 * to decide it, but rather check a compiler provided macro.
 */
#ifndef __BITS_PER_LONG
#define __BITS_PER_LONG 32
#endif

#endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */

which seems to be where the mismatch is coming from?

> ./tools/include/asm-generic/bitsperlong.h
> #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
> 
> Neither of these files actually contains the sanity
> check in linux-6.5-rc3, and comparing these is clearly
> nonsensical, as they are defined the same way (rather
> than checking CONFIG_64BIT), but also I don't see why
> there is both a uapi/ version and a non-uapi version
> in what is meant to be a userspace header.

May be worth looping in the tools/ folks, since that whole directory is
rather special IMO...

Cheers,
Nathan
