Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA254B6768
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 10:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiBOJVn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 04:21:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiBOJVn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 04:21:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A231F13DFB;
        Tue, 15 Feb 2022 01:21:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56034B81809;
        Tue, 15 Feb 2022 09:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14939C340F1;
        Tue, 15 Feb 2022 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644916891;
        bh=RZSvrBa9M+3bZFIsmIZDqZd7d5VDsf+KxZINLGmOa8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RAHiiSoOT+qkGjStonZhYrYy/J3OZkS+nBm5D1plR6odf8spdLFI55sA0GVSG+gX1
         FmPcCDRzKeNuLVHvCjfGJTHBTxbwgzR030DFU2LsjuGz8pZEhKbeR/hgIeCQIxEcqx
         HIj4CCTOLKxrGhK2W31aOh+D7o/B8cTcO951Ev77NRvhE6lAtkLsACcoUhM/z6tTLu
         qhTXBSD0ylFj48SjE2u2QLeEZrRNw+HEiuL8QU8JNZPpShvXVrQypqOZsWhDE9yRc2
         D5rdiVAwgITkzu5kXiFsxejSLdB78l1bk+Ac3J6FFkDPU8n6d+5fZ9lqTH30MQ3R7+
         eJDiITKNJvo0Q==
Received: by mail-wr1-f53.google.com with SMTP id u1so17209940wrg.11;
        Tue, 15 Feb 2022 01:21:30 -0800 (PST)
X-Gm-Message-State: AOAM533FzJSsT8a7w1ImWBVvt3HK9GnWvbMGEtf/XTO1+QttXjfyOpGP
        fFIXt+xpSAJIbkE0u6f2d3wLzhIDWQZ2eryvBuk=
X-Google-Smtp-Source: ABdhPJxTZ3T3Abm/GIU6+FEpYkuoBAl5nS/ZOniPodztANRfoa0z/A0V8x7uBN46c9isaaDTdlBbvvwdEiVYUyGe5DM=
X-Received: by 2002:adf:da4c:: with SMTP id r12mr2454185wrl.550.1644916889390;
 Tue, 15 Feb 2022 01:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com> <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
In-Reply-To: <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Feb 2022 10:21:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
Message-ID: <CAMj1kXGkG0KMD2rnKAJc3V7X9LP1grbcHTNYMnj_q4GiYfG2pQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
To:     Arnd Bergmann <arnd@kernel.org>
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

On Tue, 15 Feb 2022 at 10:13, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Feb 15, 2022 at 9:17 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Mon, 14 Feb 2022 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> >
> > With set_fs() out of the picture, wouldn't it be sufficient to check
> > that bit #55 is clear? (the bit that selects between TTBR0 and TTBR1)
> > That would also remove the need to strip the tag from the address.
> >
> > Something like
> >
> >     asm goto("tbnz  %0, #55, %2     \n"
> >              "tbnz  %1, #55, %2     \n"
> >              :: "r"(addr), "r"(addr + size - 1) :: notok);
> >     return 1;
> > notok:
> >     return 0;
> >
> > with an additional sanity check on the size which the compiler could
> > eliminate for compile-time constant values.
>
> That should work, but I don't see it as a clear enough advantage to
> have a custom implementation. For the constant-size case, it probably
> isn't better than a compiler-scheduled comparison against a
> constant limit, but it does hurt maintainability when the next person
> wants to change the behavior of access_ok() globally.
>

arm64 also has this leading up to the range check, and I think we'd no
longer need it:

    if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
        (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
            addr = untagged_addr(addr);

> If we want to get into micro-optimizing uaccess, I think a better target
> would be a CONFIG_CC_HAS_ASM_GOTO_OUTPUT version
> of __get_user()/__put_user as we have on x86 and powerpc.
>
>          Arnd
