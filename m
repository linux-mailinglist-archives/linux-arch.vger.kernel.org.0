Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5F3AD904
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jun 2021 11:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhFSJhr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Jun 2021 05:37:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1921 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFSJhr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Jun 2021 05:37:47 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G6VyZ7271zBCrT;
        Sat, 19 Jun 2021 11:35:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RMgoAH-W2QMk; Sat, 19 Jun 2021 11:35:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G6VyZ5z1fzBCpZ;
        Sat, 19 Jun 2021 11:35:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8790E8B76C;
        Sat, 19 Jun 2021 11:35:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JVPRvw2P2n4I; Sat, 19 Jun 2021 11:35:34 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 462238B763;
        Sat, 19 Jun 2021 11:35:33 +0200 (CEST)
Subject: Re: [PATCH for 4.16 v7 02/11] powerpc: membarrier: Skip memory
 barrier in switch_mm()
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        maged michael <maged.michael@gmail.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        David Sehr <sehr@google.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
        Andrew Hunter <ahh@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180129202020.8515-1-mathieu.desnoyers@efficios.com>
 <20180129202020.8515-3-mathieu.desnoyers@efficios.com>
 <8b200dd5-f37b-b208-82fb-2775df7bcd49@csgroup.eu>
 <2077369633.12794.1624037192994.JavaMail.zimbra@efficios.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4d2026cc-28e1-7781-fc95-e6160bd8db86@csgroup.eu>
Date:   Sat, 19 Jun 2021 11:35:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2077369633.12794.1624037192994.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 18/06/2021 à 19:26, Mathieu Desnoyers a écrit :
> ----- On Jun 18, 2021, at 1:13 PM, Christophe Leroy christophe.leroy@csgroup.eu wrote:
> [...]
>>
>> I don't understand all that complexity to just replace a simple
>> 'smp_mb__after_unlock_lock()'.
>>
>> #define smp_mb__after_unlock_lock()	smp_mb()
>> #define smp_mb()	barrier()
>> # define barrier() __asm__ __volatile__("": : :"memory")
>>
>>
>> Am I missing some subtility ?
> 
> On powerpc CONFIG_SMP, smp_mb() is actually defined as:
> 
> #define smp_mb()        __smp_mb()
> #define __smp_mb()      mb()
> #define mb()   __asm__ __volatile__ ("sync" : : : "memory")
> 
> So the original motivation here was to skip a "sync" instruction whenever
> switching between threads which are part of the same process. But based on
> recent discussions, I suspect my implementation may be inaccurately doing
> so though.
> 

I see.

Then, if you think a 'sync' is a concern, shouldn't we try and remove the forest of 'sync' in the 
I/O accessors ?

I can't really understand why we need all those 'sync' and 'isync' and 'twi' around the accesses 
whereas I/O memory is usually mapped as 'Guarded' so memory access ordering is already garantied.

I'm sure we'll save a lot with that.

Christophe
