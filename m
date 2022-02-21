Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17CB4BE034
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 18:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377926AbiBUOc0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 09:32:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377965AbiBUOcJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 09:32:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FED1FA56;
        Mon, 21 Feb 2022 06:31:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08BA86101C;
        Mon, 21 Feb 2022 14:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5AAC340FA;
        Mon, 21 Feb 2022 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645453901;
        bh=12Bbx9GqAhHL6qqDyToeCYzPAWe2m8+m6+gTGV+hFTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dWMiI8z7xtZHkIlGi7baHffVMjwIn0mdLtr8w3vUAA5dDZqhK8ZI+KhxrCTrxvery
         mRfleZO0SSscQ7KVHRUh2QGlGW5v/gw6LGH9t2vGIJ9GkNRHieJ694s+DQVSh8xG3o
         1QAKmXJLcJTGwkGYaV1wYGfF51PnInRtSU+fVsx8t4J76oPDgdmMoUbmKLWffZoAAd
         kmIbWlsuSubrQtmT6agHzwSbb3tqK56Q4BV05Zptd15vS9GZroHUtkz4s+wh3Rty9l
         7L/rHU3TLbzMVdK84DCafmUJBj3eUYCSTyyb3m9KPwB8ieX+FNQVnZHH0l+/WrTztv
         U44sZb72pp5dg==
Received: by mail-wr1-f46.google.com with SMTP id j22so1339154wrb.13;
        Mon, 21 Feb 2022 06:31:41 -0800 (PST)
X-Gm-Message-State: AOAM533a2H7ocTlopcm5BzOdjzFDcxstj3/3xk8HgvFTcDOeJ5DLWrNF
        iLhhNNxBfaVJ3UGE/9RELQXDvR1fj7bALeC5esQ=
X-Google-Smtp-Source: ABdhPJwkamQNFHYmlXBqgC6u1r1MKNMeB6x6hm57ILAz8yVFLOW/Qf4lv8t2aLUhrb2kSK2FAx/PKmoUpYjfFDbRcw0=
X-Received: by 2002:adf:90c1:0:b0:1e4:ad27:22b9 with SMTP id
 i59-20020adf90c1000000b001e4ad2722b9mr16170850wri.219.1645453899581; Mon, 21
 Feb 2022 06:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
In-Reply-To: <20220221132456.GA7139@alpha.franken.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 21 Feb 2022 15:31:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
Message-ID: <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
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

On Mon, Feb 21, 2022 at 2:24 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> >
> > diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> > index db9a8e002b62..d7c89dc3426c 100644
>
> this doesn't work. For every access above maximum implemented virtual address
> space of the CPU an address error will be issued, but not a TLB miss.
> And address error isn't able to handle this situation.

Ah, so the __ex_table entry only catches TLB misses?

Does this mean it also traps for kernel memory accesses, or do those
work again? If the addresses on mips64 are separate like on
sparc64 or s390, the entire access_ok() step could be replaced
by a fixup code in the exception handler. I suppose this depends on
CONFIG_EVA and you still need a limit check at least when EVA is
disabled.

> With this patch
>
> diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
> index df4b708c04a9..3911f1481f3d 100644
> --- a/arch/mips/kernel/unaligned.c
> +++ b/arch/mips/kernel/unaligned.c
> @@ -1480,6 +1480,13 @@ asmlinkage void do_ade(struct pt_regs *regs)
>         prev_state = exception_enter();
>         perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,
>                         1, regs, regs->cp0_badvaddr);
> +
> +       /* Are we prepared to handle this kernel fault?  */
> +       if (fixup_exception(regs)) {
> +               current->thread.cp0_baduaddr = regs->cp0_badvaddr;
> +               return;
> +       }
> +
>         /*
>          * Did we catch a fault trying to load an instruction?
>          */
>
> I at least get my simple test cases fixed, but I'm not sure this is
> correct.
>
> Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
> for the 32bit case ?
>

For 32-bit, the __UA_LIMIT is a compile-time constant, so the check
ends up being trivial. On all other architectures, the same thing can
be done after the set_fs removal, so I was hoping it would work here
as well.

I suspect doing the generic (size <= limit) && (addr <= (limit - size))
check on mips64 with the runtime limit ends up slightly slower
than the current code that checks a bit mask instead. If you like,
I'll update it this way, otherwise I'd need help in form of a patch
that changes the exception handling so __get_user/__put_user
also return -EFAULT for an address error.

       Arnd
