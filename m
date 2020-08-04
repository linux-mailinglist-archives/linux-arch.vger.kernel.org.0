Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BCF23B964
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgHDLSx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 07:18:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8764 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730084AbgHDLPA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Aug 2020 07:15:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BLXFr27chz9vBn9;
        Tue,  4 Aug 2020 13:14:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id J7v0qFDUwkDo; Tue,  4 Aug 2020 13:14:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BLXFr1B65z9vBn7;
        Tue,  4 Aug 2020 13:14:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D16BF8B79F;
        Tue,  4 Aug 2020 13:14:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RHtyYIa6J2Cp; Tue,  4 Aug 2020 13:14:25 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AF828B767;
        Tue,  4 Aug 2020 13:14:25 +0200 (CEST)
Subject: Re: [PATCH v8 5/8] powerpc/vdso: Prepare for switching VDSO to
 generic C implementation.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org,
        Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
 <2a67c333893454868bbfda773ba4b01c20272a5d.1588079622.git.christophe.leroy@c-s.fr>
 <878sflvbad.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <65fd7823-cc9d-c05a-0816-c34882b5d55a@csgroup.eu>
Date:   Tue, 4 Aug 2020 11:14:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <878sflvbad.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 07/15/2020 01:04 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Prepare for switching VDSO to generic C implementation in following
>> patch. Here, we:
>> - Modify __get_datapage() to take an offset
>> - Prepare the helpers to call the C VDSO functions
>> - Prepare the required callbacks for the C VDSO functions
>> - Prepare the clocksource.h files to define VDSO_ARCH_CLOCKMODES
>> - Add the C trampolines to the generic C VDSO functions
>>
>> powerpc is a bit special for VDSO as well as system calls in the
>> way that it requires setting CR SO bit which cannot be done in C.
>> Therefore, entry/exit needs to be performed in ASM.
>>
>> Implementing __arch_get_vdso_data() would clobber the link register,
>> requiring the caller to save it. As the ASM calling function already
>> has to set a stack frame and saves the link register before calling
>> the C vdso function, retriving the vdso data pointer there is lighter.
> ...
> 
>> diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
>> new file mode 100644
>> index 000000000000..4452897f9bd8
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
>> @@ -0,0 +1,175 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_VDSO_GETTIMEOFDAY_H
>> +#define __ASM_VDSO_GETTIMEOFDAY_H
>> +
>> +#include <asm/ptrace.h>
>> +
>> +#ifdef __ASSEMBLY__
>> +
>> +.macro cvdso_call funct
>> +  .cfi_startproc
>> +	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
>> +	mflr		r0
>> +  .cfi_register lr, r0
>> +	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
> 
> This doesn't work for me on ppc64(le) with glibc.
> 
> glibc doesn't create a stack frame before making the VDSO call, so the
> store of r0 (LR) goes into the caller's frame, corrupting the saved LR,
> leading to an infinite loop.
> 
> This is an example from a statically built program that calls
> clock_gettime():
> 
> 0000000010030cb0 <__clock_gettime>:
>      10030cb0:   0e 10 40 3c     lis     r2,4110
>      10030cb4:   00 7a 42 38     addi    r2,r2,31232
>      10030cb8:   a6 02 08 7c     mflr    r0
>      10030cbc:   ff ff 22 3d     addis   r9,r2,-1
>      10030cc0:   58 6d 29 39     addi    r9,r9,27992
>      10030cc4:   f0 ff c1 fb     std     r30,-16(r1)			<-- redzone store
>      10030cc8:   78 23 9e 7c     mr      r30,r4
>      10030ccc:   f8 ff e1 fb     std     r31,-8(r1)			<-- redzone store
>      10030cd0:   78 1b 7f 7c     mr      r31,r3
>      10030cd4:   10 00 01 f8     std     r0,16(r1)			<-- save LR to caller's frame
>      10030cd8:   00 00 09 e8     ld      r0,0(r9)
>      10030cdc:   00 00 20 2c     cmpdi   r0,0
>      10030ce0:   50 00 82 41     beq     10030d30 <__clock_gettime+0x80>
>      10030ce4:   a6 03 09 7c     mtctr   r0
>      10030ce8:   21 04 80 4e     bctrl					<-- vdso call
>      10030cec:   26 00 00 7c     mfcr    r0
>      10030cf0:   00 10 09 74     andis.  r9,r0,4096
>      10030cf4:   78 1b 69 7c     mr      r9,r3
>      10030cf8:   28 00 82 40     bne     10030d20 <__clock_gettime+0x70>
>      10030cfc:   b4 07 23 7d     extsw   r3,r9
>      10030d00:   10 00 01 e8     ld      r0,16(r1)			<-- load saved LR, since clobbered by the VDSO
>      10030d04:   f0 ff c1 eb     ld      r30,-16(r1)
>      10030d08:   f8 ff e1 eb     ld      r31,-8(r1)
>      10030d0c:   a6 03 08 7c     mtlr    r0				<-- restore LR
>      10030d10:   20 00 80 4e     blr					<-- jumps to 10030cec
> 
> 
> I'm kind of confused how it worked for you on 32-bit.

Indeed, 32-bit doesn't have a redzone, so I believe it needs a stack 
frame whenever it has anything to same. Here is what I have in libc.so:

000fbb60 <__clock_gettime>:
    fbb60:	94 21 ff e0 	stwu    r1,-32(r1)
    fbb64:	7c 08 02 a6 	mflr    r0
    fbb68:	48 09 75 c9 	bl      193130 <_IO_stdout_+0x24b0>
    fbb6c:	93 c1 00 18 	stw     r30,24(r1)
    fbb70:	7f c8 02 a6 	mflr    r30
    fbb74:	90 01 00 24 	stw     r0,36(r1)
    fbb78:	93 81 00 10 	stw     r28,16(r1)
    fbb7c:	93 a1 00 14 	stw     r29,20(r1)
    fbb80:	83 9e fc 98 	lwz     r28,-872(r30)
    fbb84:	93 e1 00 1c 	stw     r31,28(r1)
    fbb88:	80 1c 00 00 	lwz     r0,0(r28)
    fbb8c:	83 82 8f f4 	lwz     r28,-28684(r2)
    fbb90:	7c 7f 1b 78 	mr      r31,r3
    fbb94:	7c 00 e2 79 	xor.    r0,r0,r28
    fbb98:	7c 9d 23 78 	mr      r29,r4
    fbb9c:	41 82 00 40 	beq     fbbdc <__clock_gettime+0x7c>
    fbba0:	7c 09 03 a6 	mtctr   r0
    fbba4:	4e 80 04 21 	bctrl
    fbba8:	7c 00 00 26 	mfcr    r0
    fbbac:	74 1c 10 00 	andis.  r28,r0,4096
    fbbb0:	40 82 00 24 	bne     fbbd4 <__clock_gettime+0x74>
    fbbb4:	80 01 00 24 	lwz     r0,36(r1)
    fbbb8:	83 81 00 10 	lwz     r28,16(r1)
    fbbbc:	7c 08 03 a6 	mtlr    r0
    fbbc0:	83 a1 00 14 	lwz     r29,20(r1)
    fbbc4:	83 c1 00 18 	lwz     r30,24(r1)
    fbbc8:	83 e1 00 1c 	lwz     r31,28(r1)
    fbbcc:	38 21 00 20 	addi    r1,r1,32
    fbbd0:	4e 80 00 20 	blr
...
   193130:	4e 80 00 21 	blrl

But I guess if a prog has a way to avoid having anything to save, we may 
face the same issue. So lets create two frames:

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h 
b/arch/powerpc/include/asm/vdso/gettimeofday.h
index a0712a6e80d9..0b6fa245d54e 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -10,6 +10,7 @@
    .cfi_startproc
  	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
  	mflr		r0
+	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
    .cfi_register lr, r0
  	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
  	get_datapage	r5, r0
@@ -19,7 +20,7 @@
  	cmpwi		r3, 0
  	mtlr		r0
    .cfi_restore lr
-	addi		r1, r1, STACK_FRAME_OVERHEAD
+	addi		r1, r1, 2 * STACK_FRAME_OVERHEAD
  	crclr		so
  	beqlr+
  	crset		so
@@ -32,6 +33,7 @@
    .cfi_startproc
  	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
  	mflr		r0
+	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
    .cfi_register lr, r0
  	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
  	get_datapage	r4, r0
@@ -41,7 +43,7 @@
  	crclr		so
  	mtlr		r0
    .cfi_restore lr
-	addi		r1, r1, STACK_FRAME_OVERHEAD
+	addi		r1, r1, 2 * STACK_FRAME_OVERHEAD
  	blr
    .cfi_endproc
  .endm



> 
> There's also no code to load/restore the TOC pointer on BE, which I
> think we'll need to handle.

I see no code in the generated vdso64.so doing anything with r2, but if 
you think that's needed, just let's do it:

commit 5a704d89bd5d7aac39194fb4c775f406905bf0a4
Author: Christophe Leroy <christophe.leroy@csgroup.eu>
Date:   Tue Aug 4 06:31:48 2020 +0000

     Save and restore GOT

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h 
b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 0b6fa245d54e..fa774086173b 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -13,10 +13,16 @@
  	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
    .cfi_register lr, r0
  	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
+#ifdef CONFIG_PPC64
+	PPC_STL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
+#endif
  	get_datapage	r5, r0
  	addi		r5, r5, VDSO_DATA_OFFSET
  	bl		\funct
  	PPC_LL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
+#ifdef CONFIG_PPC64
+	PPC_LL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
+#endif
  	cmpwi		r3, 0
  	mtlr		r0
    .cfi_restore lr
@@ -36,10 +42,16 @@
  	PPC_STLU	r1, -STACK_FRAME_OVERHEAD(r1)
    .cfi_register lr, r0
  	PPC_STL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
+#ifdef CONFIG_PPC64
+	PPC_STL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
+#endif
  	get_datapage	r4, r0
  	addi		r4, r4, VDSO_DATA_OFFSET
  	bl		\funct
  	PPC_LL		r0, STACK_FRAME_OVERHEAD + PPC_LR_STKOFF(r1)
+#ifdef CONFIG_PPC64
+	PPC_LL		r2, STACK_FRAME_OVERHEAD + STK_GOT(r1)
+#endif
  	crclr		so
  	mtlr		r0
    .cfi_restore lr


Christophe
