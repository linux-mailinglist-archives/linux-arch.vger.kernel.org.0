Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA40C4BE552
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379032AbiBUPXb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 10:23:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379020AbiBUPXa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 10:23:30 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49D6C1DA7C;
        Mon, 21 Feb 2022 07:23:07 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nMAWk-00025w-00; Mon, 21 Feb 2022 16:23:02 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 22D4EC25F8; Mon, 21 Feb 2022 16:21:30 +0100 (CET)
Date:   Mon, 21 Feb 2022 16:21:30 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Arnd Bergmann <arnd@kernel.org>
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
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
Message-ID: <20220221152130.GA17373@alpha.franken.de>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
 <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2usZWPDDDUcscwS0aVKsY6aLXFGFPqYNkm4hcDERim9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 21, 2022 at 03:31:23PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 21, 2022 at 2:24 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> > On Wed, Feb 16, 2022 at 02:13:23PM +0100, Arnd Bergmann wrote:
> > >
> > > diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> > > index db9a8e002b62..d7c89dc3426c 100644
> >
> > this doesn't work. For every access above maximum implemented virtual address
> > space of the CPU an address error will be issued, but not a TLB miss.
> > And address error isn't able to handle this situation.
> 
> Ah, so the __ex_table entry only catches TLB misses?

no, but there is no __ex_table handling in address error hanlder (yet).

> Does this mean it also traps for kernel memory accesses, or do those
> work again?

it will trap for every access.


> If the addresses on mips64 are separate like on
> sparc64 or s390, the entire access_ok() step could be replaced
> by a fixup code in the exception handler. I suppose this depends on
> CONFIG_EVA and you still need a limit check at least when EVA is
> disabled.

only EVA has seperate address spaces for kernel/user.

> > Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
> > for the 32bit case ?
> >
> 
> For 32-bit, the __UA_LIMIT is a compile-time constant, so the check
> ends up being trivial. On all other architectures, the same thing can
> be done after the set_fs removal, so I was hoping it would work here
> as well.

ic

> I suspect doing the generic (size <= limit) && (addr <= (limit - size))
> check on mips64 with the runtime limit ends up slightly slower
> than the current code that checks a bit mask instead. If you like,
> I'll update it this way, otherwise I'd need help in form of a patch
> that changes the exception handling so __get_user/__put_user
> also return -EFAULT for an address error.

that's what the patch does. For aligned accesses the patch should
do the right thing, but it breaks unaligned get_user/put_user.
Checking if the trapping vaddr is between end of CPU VM space and
TASK_MAX_SIZE before exception handling should do the trick. I'll
send a patch, if this works.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
