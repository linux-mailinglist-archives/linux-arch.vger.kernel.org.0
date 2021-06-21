Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D633AEAD0
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFUONd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 10:13:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50473 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhFUONb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Jun 2021 10:13:31 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G7rzl1TYPzBDBX;
        Mon, 21 Jun 2021 16:11:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5rSJmp-MP7YS; Mon, 21 Jun 2021 16:11:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G7rzl0PmszBDBM;
        Mon, 21 Jun 2021 16:11:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C90BC8B7A3;
        Mon, 21 Jun 2021 16:11:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NPGP5zm3RQSE; Mon, 21 Jun 2021 16:11:14 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6258B8B78E;
        Mon, 21 Jun 2021 16:11:14 +0200 (CEST)
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory
 barrier in switch_mm()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        maged michael <maged.michael@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Hunter <ahh@google.com>, David Sehr <sehr@google.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-api <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com>
 <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
 <8b200dd5-f37b-b208-82fb-2775df7bcd49@csgroup.eu>
 <2077369633.12794.1624037192994.JavaMail.zimbra@efficios.com>
 <4d2026cc-28e1-7781-fc95-e6160bd8db86@csgroup.eu>
 <20210619150202.GZ5077@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <52451ce4-3eb2-e14b-81a9-99da2c0a2328@csgroup.eu>
Date:   Mon, 21 Jun 2021 16:11:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210619150202.GZ5077@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 19/06/2021 à 17:02, Segher Boessenkool a écrit :
> On Sat, Jun 19, 2021 at 11:35:34AM +0200, Christophe Leroy wrote:
>>
>>
>> Le 18/06/2021 à 19:26, Mathieu Desnoyers a écrit :
>>> ----- On Jun 18, 2021, at 1:13 PM, Christophe Leroy
>>> christophe.leroy@csgroup.eu wrote:
>>> [...]
>>>>
>>>> I don't understand all that complexity to just replace a simple
>>>> 'smp_mb__after_unlock_lock()'.
>>>>
>>>> #define smp_mb__after_unlock_lock()	smp_mb()
>>>> #define smp_mb()	barrier()
>>>> # define barrier() __asm__ __volatile__("": : :"memory")
>>>>
>>>>
>>>> Am I missing some subtility ?
>>>
>>> On powerpc CONFIG_SMP, smp_mb() is actually defined as:
>>>
>>> #define smp_mb()        __smp_mb()
>>> #define __smp_mb()      mb()
>>> #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
>>>
>>> So the original motivation here was to skip a "sync" instruction whenever
>>> switching between threads which are part of the same process. But based on
>>> recent discussions, I suspect my implementation may be inaccurately doing
>>> so though.
>>>
>>
>> I see.
>>
>> Then, if you think a 'sync' is a concern, shouldn't we try and remove the
>> forest of 'sync' in the I/O accessors ?
>>
>> I can't really understand why we need all those 'sync' and 'isync' and
>> 'twi' around the accesses whereas I/O memory is usually mapped as 'Guarded'
>> so memory access ordering is already garantied.
>>
>> I'm sure we'll save a lot with that.
> 
> The point of the twi in the I/O accessors was to make things easier to
> debug if the accesses fail: for the twi insn to complete the load will
> have to have completed as well.  On a correctly working system you never
> should need this (until something fails ;-) )
> 
> Without the twi you might need to enforce ordering in some cases still.
> The twi is a very heavy hammer, but some of that that gives us is no
> doubt actually needed.
> 

Well, I've always been quite perplex about that. According to the documentation of the 8xx, if a bus 
error or something happens on an I/O access, the exception will be accounted on the instruction 
which does the access. But based on the following function, I understand that some version of 
powerpc do generate the trap on the instruction which was being executed at the time the I/O access 
failed, not the instruction that does the access itself ?

/*
  * I/O accesses can cause machine checks on powermacs.
  * Check if the NIP corresponds to the address of a sync
  * instruction for which there is an entry in the exception
  * table.
  *  -- paulus.
  */
static inline int check_io_access(struct pt_regs *regs)
{
#ifdef CONFIG_PPC32
	unsigned long msr = regs->msr;
	const struct exception_table_entry *entry;
	unsigned int *nip = (unsigned int *)regs->nip;

	if (((msr & 0xffff0000) == 0 || (msr & (0x80000 | 0x40000)))
	    && (entry = search_exception_tables(regs->nip)) != NULL) {
		/*
		 * Check that it's a sync instruction, or somewhere
		 * in the twi; isync; nop sequence that inb/inw/inl uses.
		 * As the address is in the exception table
		 * we should be able to read the instr there.
		 * For the debug message, we look at the preceding
		 * load or store.
		 */
		if (*nip == PPC_INST_NOP)
			nip -= 2;
		else if (*nip == PPC_INST_ISYNC)
			--nip;
		if (*nip == PPC_INST_SYNC || (*nip >> 26) == OP_TRAP) {
			unsigned int rb;

			--nip;
			rb = (*nip >> 11) & 0x1f;
			printk(KERN_DEBUG "%s bad port %lx at %p\n",
			       (*nip & 0x100)? "OUT to": "IN from",
			       regs->gpr[rb] - _IO_BASE, nip);
			regs->msr |= MSR_RI;
			regs->nip = extable_fixup(entry);
			return 1;
		}
	}
#endif /* CONFIG_PPC32 */
	return 0;
}

Am I right ?

It is not only the twi which bother's me in the I/O accessors but also the sync/isync and stuff.

A write typically is

	sync
	stw

A read is

	sync
	lwz
	twi
	isync

Taking into account that HW ordering is garanteed by the fact that __iomem is guarded, isn't the 
'memory' clobber enough as a barrier ?

Thanks
Christophe
