Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F2023D176
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgHET77 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 15:59:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10432 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgHEQkY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Aug 2020 12:40:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BMHRQ2X7cz9vB21;
        Wed,  5 Aug 2020 18:40:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ABL8vddTwZDc; Wed,  5 Aug 2020 18:40:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BMHRQ1hQXz9vB20;
        Wed,  5 Aug 2020 18:40:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 67F518B7ED;
        Wed,  5 Aug 2020 18:40:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0ZpOFuo535cP; Wed,  5 Aug 2020 18:40:20 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7627A8B7EC;
        Wed,  5 Aug 2020 18:40:19 +0200 (CEST)
Subject: Re: [PATCH v10 2/5] powerpc/vdso: Prepare for switching VDSO to
 generic C implementation.
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org, linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, linuxppc-dev@lists.ozlabs.org
References: <cover.1596611196.git.christophe.leroy@csgroup.eu>
 <348528c33cd4007f3fee7fe643ef160843d09a6c.1596611196.git.christophe.leroy@csgroup.eu>
 <20200805140307.GO6753@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <3db2a590-b842-83db-ed2b-f3ee62595f18@csgroup.eu>
Date:   Wed, 5 Aug 2020 16:40:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200805140307.GO6753@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 08/05/2020 02:03 PM, Segher Boessenkool wrote:
> Hi!
> 
> On Wed, Aug 05, 2020 at 07:09:23AM +0000, Christophe Leroy wrote:
>> +/*
>> + * powerpc specific delta calculation.
>> + *
>> + * This variant removes the masking of the subtraction because the
>> + * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
>> + * which would result in a pointless operation. The compiler cannot
>> + * optimize it away as the mask comes from the vdso data and is not compile
>> + * time constant.
>> + */
> 
> It cannot optimise it because it does not know shift < 32.  The code
> below is incorrect for shift equal to 32, fwiw.

Is there a way to tell it ?

> 
>> +static __always_inline u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
>> +{
>> +	return (cycles - last) * mult;
>> +}
>> +#define vdso_calc_delta vdso_calc_delta
>> +
>> +#ifndef __powerpc64__
>> +static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
>> +{
>> +	u32 hi = ns >> 32;
>> +	u32 lo = ns;
>> +
>> +	lo >>= shift;
>> +	lo |= hi << (32 - shift);
>> +	hi >>= shift;
> 
> 
>> +	if (likely(hi == 0))
>> +		return lo;
> 
> Removing these two lines shouldn't change generated object code?  Or not
> make it worse, at least.

I remember it made noticeable difference allthough I can't remember the 
details. See below with GCC 10.1. At least we see that with those two 
lines, GCC only sets a 16 bytes stack frame. Without those lines it sets 
a 32 bytes stack frame and seems to save some values for no reason.

With the two lines:

000006ac <__c_kernel_clock_gettime>:
  6ac:	28 03 00 0f 	cmplwi  r3,15
  6b0:	41 81 01 04 	bgt     7b4 <__c_kernel_clock_gettime+0x108>
  6b4:	39 40 00 01 	li      r10,1
  6b8:	7d 4a 18 30 	slw     r10,r10,r3
  6bc:	71 47 08 83 	andi.   r7,r10,2179
  6c0:	41 82 01 2c 	beq     7ec <__c_kernel_clock_gettime+0x140>
  6c4:	94 21 ff f0 	stwu    r1,-16(r1)
  6c8:	54 63 20 36 	rlwinm  r3,r3,4,0,27
  6cc:	93 e1 00 0c 	stw     r31,12(r1)
  6d0:	7d 85 1a 14 	add     r12,r5,r3
  6d4:	80 05 00 00 	lwz     r0,0(r5)
  6d8:	70 06 00 01 	andi.   r6,r0,1
  6dc:	40 82 00 d4 	bne     7b0 <__c_kernel_clock_gettime+0x104>
  6e0:	7d 4d 42 e6 	mftbu   r10
  6e4:	7d 6c 42 e6 	mftb    r11
  6e8:	7c ed 42 e6 	mftbu   r7
  6ec:	7c 0a 38 40 	cmplw   r10,r7
  6f0:	40 82 ff f0 	bne     6e0 <__c_kernel_clock_gettime+0x34>
  6f4:	80 e5 00 0c 	lwz     r7,12(r5)
  6f8:	80 65 00 08 	lwz     r3,8(r5)
  6fc:	7c e7 58 10 	subfc   r7,r7,r11
  700:	81 65 00 18 	lwz     r11,24(r5)
  704:	7d 43 51 10 	subfe   r10,r3,r10
  708:	7f e7 58 16 	mulhwu  r31,r7,r11
  70c:	7d 4a 59 d6 	mullw   r10,r10,r11
  710:	7c e7 59 d6 	mullw   r7,r7,r11
  714:	80 6c 00 2c 	lwz     r3,44(r12)
  718:	81 6c 00 28 	lwz     r11,40(r12)
  71c:	7c e7 18 14 	addc    r7,r7,r3
  720:	7d 4a fa 14 	add     r10,r10,r31
  724:	80 65 00 1c 	lwz     r3,28(r5)
  728:	7d 4a 59 14 	adde    r10,r10,r11
  72c:	7c e7 1c 30 	srw     r7,r7,r3
  730:	21 63 00 20 	subfic  r11,r3,32
  734:	7d 43 1c 31 	srw.    r3,r10,r3
  738:	7d 4a 58 30 	slw     r10,r10,r11
  73c:	7d 49 3b 78 	or      r9,r10,r7
  740:	39 00 00 00 	li      r8,0
  744:	40 82 00 84 	bne     7c8 <__c_kernel_clock_gettime+0x11c>
  748:	80 6c 00 24 	lwz     r3,36(r12)
  74c:	81 45 00 00 	lwz     r10,0(r5)
  750:	7c 00 50 40 	cmplw   r0,r10
  754:	40 a2 ff 80 	bne     6d4 <__c_kernel_clock_gettime+0x28>
  758:	2c 08 00 00 	cmpwi   r8,0
  75c:	41 82 00 7c 	beq     7d8 <__c_kernel_clock_gettime+0x12c>
  760:	3c e0 c4 65 	lis     r7,-15259
  764:	3c 00 3b 9a 	lis     r0,15258
  768:	60 e7 36 00 	ori     r7,r7,13824
  76c:	60 00 c9 ff 	ori     r0,r0,51711
  770:	7c a9 38 14 	addc    r5,r9,r7
  774:	7d 48 01 d4 	addme   r10,r8
  778:	2c 0a 00 00 	cmpwi   r10,0
  77c:	7d 48 53 78 	mr      r8,r10
  780:	7c a9 2b 78 	mr      r9,r5
  784:	38 c6 00 01 	addi    r6,r6,1
  788:	40 82 ff e8 	bne     770 <__c_kernel_clock_gettime+0xc4>
  78c:	7c 05 00 40 	cmplw   r5,r0
  790:	41 81 ff e0 	bgt     770 <__c_kernel_clock_gettime+0xc4>
  794:	7c 66 18 14 	addc    r3,r6,r3
  798:	90 64 00 00 	stw     r3,0(r4)
  79c:	91 24 00 04 	stw     r9,4(r4)
  7a0:	38 60 00 00 	li      r3,0
  7a4:	83 e1 00 0c 	lwz     r31,12(r1)
  7a8:	38 21 00 10 	addi    r1,r1,16
  7ac:	4e 80 00 20 	blr
  7b0:	4b ff ff 24 	b       6d4 <__c_kernel_clock_gettime+0x28>
  7b4:	38 00 00 f6 	li      r0,246
  7b8:	44 00 00 02 	sc
  7bc:	40 a3 00 08 	bns     7c4 <__c_kernel_clock_gettime+0x118>
  7c0:	7c 63 00 d0 	neg     r3,r3
  7c4:	4e 80 00 20 	blr
  7c8:	7d 2a 4b 78 	mr      r10,r9
  7cc:	7c 68 1b 78 	mr      r8,r3
  7d0:	7d 49 53 78 	mr      r9,r10
  7d4:	4b ff ff 74 	b       748 <__c_kernel_clock_gettime+0x9c>
  7d8:	3d 40 3b 9a 	lis     r10,15258
  7dc:	61 4a c9 ff 	ori     r10,r10,51711
  7e0:	7c 09 50 40 	cmplw   r9,r10
  7e4:	41 81 ff 7c 	bgt     760 <__c_kernel_clock_gettime+0xb4>
  7e8:	4b ff ff b0 	b       798 <__c_kernel_clock_gettime+0xec>
  7ec:	71 47 00 60 	andi.   r7,r10,96
  7f0:	54 69 20 36 	rlwinm  r9,r3,4,0,27
  7f4:	7d 25 4a 14 	add     r9,r5,r9
  7f8:	40 82 00 14 	bne     80c <__c_kernel_clock_gettime+0x160>
  7fc:	71 4a 00 10 	andi.   r10,r10,16
  800:	41 a2 ff b4 	beq     7b4 <__c_kernel_clock_gettime+0x108>
  804:	38 a5 00 f0 	addi    r5,r5,240
  808:	4b ff fe bc 	b       6c4 <__c_kernel_clock_gettime+0x18>
  80c:	81 05 00 00 	lwz     r8,0(r5)
  810:	71 0a 00 01 	andi.   r10,r8,1
  814:	40 a2 ff f8 	bne     80c <__c_kernel_clock_gettime+0x160>
  818:	80 69 00 24 	lwz     r3,36(r9)
  81c:	81 49 00 2c 	lwz     r10,44(r9)
  820:	80 e5 00 00 	lwz     r7,0(r5)
  824:	7c 08 38 40 	cmplw   r8,r7
  828:	40 a2 ff e4 	bne     80c <__c_kernel_clock_gettime+0x160>
  82c:	90 64 00 00 	stw     r3,0(r4)
  830:	91 44 00 04 	stw     r10,4(r4)
  834:	38 60 00 00 	li      r3,0
  838:	4e 80 00 20 	blr


Without the two lines:

000006ac <__c_kernel_clock_gettime>:
  6ac:	28 03 00 0f 	cmplwi  r3,15
  6b0:	41 81 01 14 	bgt     7c4 <__c_kernel_clock_gettime+0x118>
  6b4:	39 20 00 01 	li      r9,1
  6b8:	7d 29 18 30 	slw     r9,r9,r3
  6bc:	71 2a 08 83 	andi.   r10,r9,2179
  6c0:	41 82 01 2c 	beq     7ec <__c_kernel_clock_gettime+0x140>
  6c4:	94 21 ff e0 	stwu    r1,-32(r1)
  6c8:	54 63 20 36 	rlwinm  r3,r3,4,0,27
  6cc:	93 81 00 10 	stw     r28,16(r1)
  6d0:	93 a1 00 14 	stw     r29,20(r1)
  6d4:	93 c1 00 18 	stw     r30,24(r1)
  6d8:	93 e1 00 1c 	stw     r31,28(r1)
  6dc:	7c 65 1a 14 	add     r3,r5,r3
  6e0:	81 85 00 00 	lwz     r12,0(r5)
  6e4:	71 87 00 01 	andi.   r7,r12,1
  6e8:	40 82 00 d8 	bne     7c0 <__c_kernel_clock_gettime+0x114>
  6ec:	7d 2d 42 e6 	mftbu   r9
  6f0:	7c cc 42 e6 	mftb    r6
  6f4:	7d 4d 42 e6 	mftbu   r10
  6f8:	7c 09 50 40 	cmplw   r9,r10
  6fc:	40 82 ff f0 	bne     6ec <__c_kernel_clock_gettime+0x40>
  700:	83 83 00 28 	lwz     r28,40(r3)
  704:	83 a3 00 2c 	lwz     r29,44(r3)
  708:	81 65 00 08 	lwz     r11,8(r5)
  70c:	81 05 00 0c 	lwz     r8,12(r5)
  710:	83 c5 00 18 	lwz     r30,24(r5)
  714:	83 e5 00 1c 	lwz     r31,28(r5)
  718:	80 03 00 24 	lwz     r0,36(r3)
  71c:	81 45 00 00 	lwz     r10,0(r5)
  720:	7c 0c 50 40 	cmplw   r12,r10
  724:	40 a2 ff bc 	bne     6e0 <__c_kernel_clock_gettime+0x34>
  728:	7d 48 30 10 	subfc   r10,r8,r6
  72c:	7c cb 49 10 	subfe   r6,r11,r9
  730:	7c c6 f1 d6 	mullw   r6,r6,r30
  734:	7d 2a f0 16 	mulhwu  r9,r10,r30
  738:	7d 4a f1 d6 	mullw   r10,r10,r30
  73c:	7c c6 4a 14 	add     r6,r6,r9
  740:	7d 4a e8 14 	addc    r10,r10,r29
  744:	7c c6 e1 14 	adde    r6,r6,r28
  748:	7c c8 fc 30 	srw     r8,r6,r31
  74c:	2c 08 00 00 	cmpwi   r8,0
  750:	20 bf 00 20 	subfic  r5,r31,32
  754:	7d 4a fc 30 	srw     r10,r10,r31
  758:	7c c5 28 30 	slw     r5,r6,r5
  75c:	7c a9 53 78 	or      r9,r5,r10
  760:	41 82 00 78 	beq     7d8 <__c_kernel_clock_gettime+0x12c>
  764:	3c c0 c4 65 	lis     r6,-15259
  768:	3c 60 3b 9a 	lis     r3,15258
  76c:	60 c6 36 00 	ori     r6,r6,13824
  770:	60 63 c9 ff 	ori     r3,r3,51711
  774:	7c a9 30 14 	addc    r5,r9,r6
  778:	7d 48 01 d4 	addme   r10,r8
  77c:	2c 0a 00 00 	cmpwi   r10,0
  780:	7d 48 53 78 	mr      r8,r10
  784:	7c a9 2b 78 	mr      r9,r5
  788:	38 e7 00 01 	addi    r7,r7,1
  78c:	40 82 ff e8 	bne     774 <__c_kernel_clock_gettime+0xc8>
  790:	7c 05 18 40 	cmplw   r5,r3
  794:	41 81 ff e0 	bgt     774 <__c_kernel_clock_gettime+0xc8>
  798:	7c 07 00 14 	addc    r0,r7,r0
  79c:	90 04 00 00 	stw     r0,0(r4)
  7a0:	91 24 00 04 	stw     r9,4(r4)
  7a4:	38 60 00 00 	li      r3,0
  7a8:	83 81 00 10 	lwz     r28,16(r1)
  7ac:	83 a1 00 14 	lwz     r29,20(r1)
  7b0:	83 c1 00 18 	lwz     r30,24(r1)
  7b4:	83 e1 00 1c 	lwz     r31,28(r1)
  7b8:	38 21 00 20 	addi    r1,r1,32
  7bc:	4e 80 00 20 	blr
  7c0:	4b ff ff 20 	b       6e0 <__c_kernel_clock_gettime+0x34>
  7c4:	38 00 00 f6 	li      r0,246
  7c8:	44 00 00 02 	sc
  7cc:	40 a3 00 08 	bns     7d4 <__c_kernel_clock_gettime+0x128>
  7d0:	7c 63 00 d0 	neg     r3,r3
  7d4:	4e 80 00 20 	blr
  7d8:	3d 40 3b 9a 	lis     r10,15258
  7dc:	61 4a c9 ff 	ori     r10,r10,51711
  7e0:	7c 09 50 40 	cmplw   r9,r10
  7e4:	41 81 ff 80 	bgt     764 <__c_kernel_clock_gettime+0xb8>
  7e8:	4b ff ff b4 	b       79c <__c_kernel_clock_gettime+0xf0>
  7ec:	71 2a 00 60 	andi.   r10,r9,96
  7f0:	40 82 00 14 	bne     804 <__c_kernel_clock_gettime+0x158>
  7f4:	71 29 00 10 	andi.   r9,r9,16
  7f8:	41 a2 ff cc 	beq     7c4 <__c_kernel_clock_gettime+0x118>
  7fc:	38 a5 00 f0 	addi    r5,r5,240
  800:	4b ff fe c4 	b       6c4 <__c_kernel_clock_gettime+0x18>
  804:	54 69 20 36 	rlwinm  r9,r3,4,0,27
  808:	7d 25 4a 14 	add     r9,r5,r9
  80c:	81 05 00 00 	lwz     r8,0(r5)
  810:	71 0a 00 01 	andi.   r10,r8,1
  814:	40 82 00 28 	bne     83c <__c_kernel_clock_gettime+0x190>
  818:	80 09 00 24 	lwz     r0,36(r9)
  81c:	81 49 00 2c 	lwz     r10,44(r9)
  820:	80 e5 00 00 	lwz     r7,0(r5)
  824:	7c 08 38 40 	cmplw   r8,r7
  828:	40 a2 ff e4 	bne     80c <__c_kernel_clock_gettime+0x160>
  82c:	90 04 00 00 	stw     r0,0(r4)
  830:	91 44 00 04 	stw     r10,4(r4)
  834:	38 60 00 00 	li      r3,0
  838:	4e 80 00 20 	blr
  83c:	4b ff ff d0 	b       80c <__c_kernel_clock_gettime+0x160>


> 
>> +	return ((u64)hi << 32) | lo;
>> +}
> 
> 
> What does the compiler do for just
> 
> static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
> 	return ns >> (shift & 31);
> }
> 

Worse:

000006ac <__c_kernel_clock_gettime>:
  6ac:	28 03 00 0f 	cmplwi  r3,15
  6b0:	41 81 01 30 	bgt     7e0 <__c_kernel_clock_gettime+0x134>
  6b4:	39 20 00 01 	li      r9,1
  6b8:	7d 29 18 30 	slw     r9,r9,r3
  6bc:	71 2a 08 83 	andi.   r10,r9,2179
  6c0:	41 82 01 48 	beq     808 <__c_kernel_clock_gettime+0x15c>
  6c4:	94 21 ff e0 	stwu    r1,-32(r1)
  6c8:	54 63 20 36 	rlwinm  r3,r3,4,0,27
  6cc:	93 81 00 10 	stw     r28,16(r1)
  6d0:	93 a1 00 14 	stw     r29,20(r1)
  6d4:	93 c1 00 18 	stw     r30,24(r1)
  6d8:	93 e1 00 1c 	stw     r31,28(r1)
  6dc:	7c 65 1a 14 	add     r3,r5,r3
  6e0:	80 c5 00 00 	lwz     r6,0(r5)
  6e4:	70 c7 00 01 	andi.   r7,r6,1
  6e8:	40 82 00 f4 	bne     7dc <__c_kernel_clock_gettime+0x130>
  6ec:	7d 2d 42 e6 	mftbu   r9
  6f0:	7d 0c 42 e6 	mftb    r8
  6f4:	7d 4d 42 e6 	mftbu   r10
  6f8:	7c 09 50 40 	cmplw   r9,r10
  6fc:	40 82 ff f0 	bne     6ec <__c_kernel_clock_gettime+0x40>
  700:	83 83 00 28 	lwz     r28,40(r3)
  704:	83 c3 00 2c 	lwz     r30,44(r3)
  708:	81 65 00 08 	lwz     r11,8(r5)
  70c:	81 45 00 0c 	lwz     r10,12(r5)
  710:	83 e5 00 18 	lwz     r31,24(r5)
  714:	81 85 00 1c 	lwz     r12,28(r5)
  718:	80 03 00 24 	lwz     r0,36(r3)
  71c:	83 a5 00 00 	lwz     r29,0(r5)
  720:	7c 06 e8 40 	cmplw   r6,r29
  724:	40 a2 ff bc 	bne     6e0 <__c_kernel_clock_gettime+0x34>
  728:	7d 0a 40 10 	subfc   r8,r10,r8
  72c:	7c cb 49 10 	subfe   r6,r11,r9
  730:	7c c6 f9 d6 	mullw   r6,r6,r31
  734:	7d 28 f8 16 	mulhwu  r9,r8,r31
  738:	7d 08 f9 d6 	mullw   r8,r8,r31
  73c:	55 8c 06 fe 	clrlwi  r12,r12,27
  740:	7f c8 f0 14 	addc    r30,r8,r30
  744:	7c c6 4a 14 	add     r6,r6,r9
  748:	7c c6 e1 14 	adde    r6,r6,r28
  74c:	34 6c ff e0 	addic.  r3,r12,-32
  750:	41 80 00 70 	blt     7c0 <__c_kernel_clock_gettime+0x114>
  754:	7c c9 1c 30 	srw     r9,r6,r3
  758:	39 00 00 00 	li      r8,0
  75c:	2c 08 00 00 	cmpwi   r8,0
  760:	41 82 00 94 	beq     7f4 <__c_kernel_clock_gettime+0x148>
  764:	3c c0 c4 65 	lis     r6,-15259
  768:	3c 60 3b 9a 	lis     r3,15258
  76c:	60 c6 36 00 	ori     r6,r6,13824
  770:	60 63 c9 ff 	ori     r3,r3,51711
  774:	7c a9 30 14 	addc    r5,r9,r6
  778:	7d 48 01 d4 	addme   r10,r8
  77c:	2c 0a 00 00 	cmpwi   r10,0
  780:	7d 48 53 78 	mr      r8,r10
  784:	7c a9 2b 78 	mr      r9,r5
  788:	38 e7 00 01 	addi    r7,r7,1
  78c:	40 82 ff e8 	bne     774 <__c_kernel_clock_gettime+0xc8>
  790:	7c 05 18 40 	cmplw   r5,r3
  794:	41 81 ff e0 	bgt     774 <__c_kernel_clock_gettime+0xc8>
  798:	7c 07 00 14 	addc    r0,r7,r0
  79c:	90 04 00 00 	stw     r0,0(r4)
  7a0:	91 24 00 04 	stw     r9,4(r4)
  7a4:	38 60 00 00 	li      r3,0
  7a8:	83 81 00 10 	lwz     r28,16(r1)
  7ac:	83 a1 00 14 	lwz     r29,20(r1)
  7b0:	83 c1 00 18 	lwz     r30,24(r1)
  7b4:	83 e1 00 1c 	lwz     r31,28(r1)
  7b8:	38 21 00 20 	addi    r1,r1,32
  7bc:	4e 80 00 20 	blr
  7c0:	54 c3 08 3c 	rlwinm  r3,r6,1,0,30
  7c4:	21 6c 00 1f 	subfic  r11,r12,31
  7c8:	7c 63 58 30 	slw     r3,r3,r11
  7cc:	7f c9 64 30 	srw     r9,r30,r12
  7d0:	7c 69 4b 78 	or      r9,r3,r9
  7d4:	7c c8 64 30 	srw     r8,r6,r12
  7d8:	4b ff ff 84 	b       75c <__c_kernel_clock_gettime+0xb0>
  7dc:	4b ff ff 04 	b       6e0 <__c_kernel_clock_gettime+0x34>
  7e0:	38 00 00 f6 	li      r0,246
  7e4:	44 00 00 02 	sc
  7e8:	40 a3 00 08 	bns     7f0 <__c_kernel_clock_gettime+0x144>
  7ec:	7c 63 00 d0 	neg     r3,r3
  7f0:	4e 80 00 20 	blr
  7f4:	3d 40 3b 9a 	lis     r10,15258
  7f8:	61 4a c9 ff 	ori     r10,r10,51711
  7fc:	7c 09 50 40 	cmplw   r9,r10
  800:	41 81 ff 64 	bgt     764 <__c_kernel_clock_gettime+0xb8>
  804:	4b ff ff 98 	b       79c <__c_kernel_clock_gettime+0xf0>
  808:	71 2a 00 60 	andi.   r10,r9,96
  80c:	40 82 00 14 	bne     820 <__c_kernel_clock_gettime+0x174>
  810:	71 29 00 10 	andi.   r9,r9,16
  814:	41 a2 ff cc 	beq     7e0 <__c_kernel_clock_gettime+0x134>
  818:	38 a5 00 f0 	addi    r5,r5,240
  81c:	4b ff fe a8 	b       6c4 <__c_kernel_clock_gettime+0x18>
  820:	54 69 20 36 	rlwinm  r9,r3,4,0,27
  824:	7d 25 4a 14 	add     r9,r5,r9
  828:	81 05 00 00 	lwz     r8,0(r5)
  82c:	71 0a 00 01 	andi.   r10,r8,1
  830:	40 82 00 28 	bne     858 <__c_kernel_clock_gettime+0x1ac>
  834:	80 09 00 24 	lwz     r0,36(r9)
  838:	81 49 00 2c 	lwz     r10,44(r9)
  83c:	80 e5 00 00 	lwz     r7,0(r5)
  840:	7c 08 38 40 	cmplw   r8,r7
  844:	40 a2 ff e4 	bne     828 <__c_kernel_clock_gettime+0x17c>
  848:	90 04 00 00 	stw     r0,0(r4)
  84c:	91 44 00 04 	stw     r10,4(r4)
  850:	38 60 00 00 	li      r3,0
  854:	4e 80 00 20 	blr
  858:	4b ff ff d0 	b       828 <__c_kernel_clock_gettime+0x17c>

Christophe
