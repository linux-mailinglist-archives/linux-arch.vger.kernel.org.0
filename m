Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666F14B672A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 10:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiBOJNK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 04:13:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiBOJNJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 04:13:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E751224BC1;
        Tue, 15 Feb 2022 01:12:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 637BE616C6;
        Tue, 15 Feb 2022 09:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E00C34101;
        Tue, 15 Feb 2022 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644916378;
        bh=nPLs5v71E/xzzKRq/jdD2UxtX1DBSgxHKB2i8EHy1KY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j3kUIfoQTYxq0nCVjg3xJUAdSTCwwH8temh7NFjmZfpkIjAXQ/i5eqNNYmAAO/ny1
         Uhrqg321bjTbiL2bLfcsiw3L/YssCCJFSkB1FTV4deiCrv9oCd+WLuGBXT1JJy17rS
         k8cMdKEehveud6wTzU+zMEsNNO9j8HHxKx2E1NBNFWFufNsE2sT4ymojJeWA5L/d5h
         cw/DGlUHQEdW9cC4Q+y80YkhF8+ZZBz928QLF/gO6sphG+kkzt0wgVNEOYTAhGmy7s
         fFzb6USqyb2JRrGEB+Xy9zVF9/7CIibD5o8jjgMioj1JxGYIThdIqK2msRJNx3V5hb
         RhnYTF7LWjKEQ==
Received: by mail-wr1-f53.google.com with SMTP id s10so17397971wrb.1;
        Tue, 15 Feb 2022 01:12:58 -0800 (PST)
X-Gm-Message-State: AOAM5326jOU9poDd7nicGzGVYqcKXu6zBv1rw1GVFd7ne8SXkSFiRPjk
        0nhHrMbsfN7Si6N9gM2CoMfhsBGks4+0R8nwRUE=
X-Google-Smtp-Source: ABdhPJwP302M1cXBE3IXsZS/v83gWi9XJR2q13sQJhY9b6tnSpJCd4099durtVh9QEm0yhQ4WeUq4MKNAAS9P/JPfzc=
X-Received: by 2002:adf:f6ce:: with SMTP id y14mr2380558wrp.219.1644916376776;
 Tue, 15 Feb 2022 01:12:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Feb 2022 10:12:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
Message-ID: <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>, X86 ML <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 15, 2022 at 9:17 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Mon, 14 Feb 2022 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
>
> With set_fs() out of the picture, wouldn't it be sufficient to check
> that bit #55 is clear? (the bit that selects between TTBR0 and TTBR1)
> That would also remove the need to strip the tag from the address.
>
> Something like
>
>     asm goto("tbnz  %0, #55, %2     \n"
>              "tbnz  %1, #55, %2     \n"
>              :: "r"(addr), "r"(addr + size - 1) :: notok);
>     return 1;
> notok:
>     return 0;
>
> with an additional sanity check on the size which the compiler could
> eliminate for compile-time constant values.

That should work, but I don't see it as a clear enough advantage to
have a custom implementation. For the constant-size case, it probably
isn't better than a compiler-scheduled comparison against a
constant limit, but it does hurt maintainability when the next person
wants to change the behavior of access_ok() globally.

If we want to get into micro-optimizing uaccess, I think a better target
would be a CONFIG_CC_HAS_ASM_GOTO_OUTPUT version
of __get_user()/__put_user as we have on x86 and powerpc.

         Arnd
