Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4664C266B
	for <lists+linux-arch@lfdr.de>; Thu, 24 Feb 2022 09:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiBXImU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Feb 2022 03:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiBXImT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Feb 2022 03:42:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3233E1C;
        Thu, 24 Feb 2022 00:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 482B461A41;
        Thu, 24 Feb 2022 08:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6261C340F8;
        Thu, 24 Feb 2022 08:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645692107;
        bh=3OZhY8JjlWpvQtjxNVEtkpMscELhOM136ShyKCOjsEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IUh0x46q8STA6HKAlbLTizD8XGO+kXYr3toRmLVEmVGpouO/H6aYQ8xiLiANw2a+u
         HCL4KnuaohqNkiXxcP1D+/lRJl3QntwyWsCstJnQVu8ONZ3jI6BlSUPzyejrcAPQZV
         +nzKG39Q20gmRhX85bUsq4p1JphZ4DTJi1MSq5KJ4gkH6JLtlV5bg4qOHXvgO90+wI
         G81tJHNMGlOmgb18Uj2i0lzpFYLeKAgba5P0poH7ixneTHE+747gTxVEDOdEreg2CS
         CWeIv3qxk2GxmOqug9TFXr2ZvmxluPekB2kCL2kCQbjWzVYCFZXOv5nSavxW7y+xxm
         sJyHKVwF8yVng==
Received: by mail-wr1-f44.google.com with SMTP id n14so1416445wrq.7;
        Thu, 24 Feb 2022 00:41:47 -0800 (PST)
X-Gm-Message-State: AOAM531XagoZx6Uk1zhQX/CE1ErzZlNWKgx1Hb2dIDj7LHTNtB7aMi2j
        Pa3pYMHS8M7L9M4uxxK91fu5jbudGewpzKfLI0w=
X-Google-Smtp-Source: ABdhPJzneL/9b5VqISjziF71opYqNdlSHnzAsafkxFgpoEqKa+f7LCyuasR/zxK7OReD5OXFM6yWvfz7KIyaMqF7hrc=
X-Received: by 2002:a5d:59aa:0:b0:1ed:9f45:c2ff with SMTP id
 p10-20020a5d59aa000000b001ed9f45c2ffmr1312686wrr.192.1645692105823; Thu, 24
 Feb 2022 00:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
 <YhdB7tNDvtsYLUzr@antec>
In-Reply-To: <YhdB7tNDvtsYLUzr@antec>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 24 Feb 2022 09:41:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Q6=yzX5hKX45=U80SoUXLU59sFqz-tN6U=Fr5t1m96Q@mail.gmail.com>
Message-ID: <CAK8P3a3Q6=yzX5hKX45=U80SoUXLU59sFqz-tN6U=Fr5t1m96Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 24, 2022 at 9:29 AM Stafford Horne <shorne@gmail.com> wrote:

> > -
> > -#define access_ok(addr, size)                                                \
> > -({                                                                   \
> > -     __chk_user_ptr(addr);                                           \
> > -     __range_ok((unsigned long)(addr), (size));                      \
> > -})
> > +#include <asm-generic/access_ok.h>
>
> I was going to ask why we are missing __chk_user_ptr in the generic version.
> But this is basically now a no-op so I think its OK.

Correct, the type checking is implied by making __access_ok() an inline
function that takes a __user pointer.

> Acked-by: Stafford Horne <shorne@gmail.com> [openrisc, asm-generic]

Thanks!

       Arnd
