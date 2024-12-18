Return-Path: <linux-arch+bounces-9423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6EF9F62A6
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1EE18950EC
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE119993B;
	Wed, 18 Dec 2024 10:20:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B418A922;
	Wed, 18 Dec 2024 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517215; cv=none; b=TCL2yiDfxQDr/Jqi9k+N2cC8vS2d2KNuE547Amu9D5ca4rv4/2XB0o7gCnwbt9iQnWjV/Ts6J2wzSKp4EC4j3YtTLjeZmrspGwcNihuUPm7ACL1qQlMC0TYh/4S/eqZGTXcMC9Wz8+mtTngH7fZi7QWzenPaMyU9TFiCWO/pcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517215; c=relaxed/simple;
	bh=hvlxii09mNYa0mWJjp/YlBjcha9/rA0O+qD/MivO288=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HX6txczLkSCpm5whzV7/+B/sffwggy8s6TKOPIwak8eopM9cKxtmcLXHM/fX6RRl1apkj+Tl0nNFIiEWqrwT1soA3ZzdYeTb5cxIlNWUGgsMaZLvKktwslOeI/BO9x8xS1Xis9dm20GpQE2Dqw1OXOTcO5veV1pAR+YV0iCvjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YCqSD111Vz9sPd;
	Wed, 18 Dec 2024 11:20:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gKpioB5BCG2d; Wed, 18 Dec 2024 11:20:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YCqSC6pM5z9rvV;
	Wed, 18 Dec 2024 11:20:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CC0DD8B770;
	Wed, 18 Dec 2024 11:20:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ffiwrVR0qIrj; Wed, 18 Dec 2024 11:20:11 +0100 (CET)
Received: from [10.25.209.139] (unknown [10.25.209.139])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D2408B763;
	Wed, 18 Dec 2024 11:20:11 +0100 (CET)
Message-ID: <e69b2927-b415-4e16-a346-8d874c9a8b39@csgroup.eu>
Date: Wed, 18 Dec 2024 11:20:10 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] powerpc/vdso: Switch to generic storage
 implementation
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-12-f7aed1bdb3b2@linutronix.de>
 <12120bbe-1d79-425b-982d-46af1fa5d70d@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <12120bbe-1d79-425b-982d-46af1fa5d70d@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



>>   #ifdef CONFIG_TIME_NS
>> -static __always_inline
>> -const struct vdso_data *__arch_get_timens_vdso_data(const struct 
>> vdso_data *vd)
>> +static __always_inline const struct vdso_time_data 
>> *__ppc_get_vdso_u_timens_data(void)
>>   {
>> -    return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
>> +    struct vdso_time_data *time_data;
>> +
>> +    asm(
>> +        "    bcl    20, 31, .+4\n"
>> +        "0:    mflr    %0\n"
>> +        "    addis    %0, %0, (vdso_u_timens_data - 0b)@ha\n"
>> +        "    addi    %0, %0, (vdso_u_timens_data - 0b)@l\n"
>> +    : "=r" (time_data) :: "lr");
>> +
>> +    return time_data;
> 
> Please don't do that, it kills optimisation efforts done when 
> implementing VDSO time. Commit ce7d8056e38b ("powerpc/vdso: Prepare for 
> switching VDSO to generic C implementation.") explains why.
> 
> For time data, the bcl/mflr dance is done by get_datapage macro called 
> by cvdso_call macro in gettimeofday.S, and given to 
> __cvdso_clock_gettime_data() by __c_kernel_clock_gettime() in 
> vgettimeofday.c . Use that information and don't redo the bcl/mflr 
> sequence.
> 
> See for instance function __c_kernel_clock_getres():
> 
> Before your series it is 30 instructions.
> After your series it is 59 instructions.
> 

It is even more obvious with __c_kernel_time()

Before your series it has 12 instructions,
After your series it has 26 instructions.

Before

00001408 <__c_kernel_time>:
     1408:	81 44 00 04 	lwz     r10,4(r4)
     140c:	6d 49 80 00 	xoris   r9,r10,32768
     1410:	2c 09 ff ff 	cmpwi   r9,-1
     1414:	40 82 00 08 	bne     141c <__c_kernel_time+0x14>
     1418:	38 84 40 00 	addi    r4,r4,16384
     141c:	2c 03 00 00 	cmpwi   r3,0
     1420:	81 44 00 20 	lwz     r10,32(r4)
     1424:	81 64 00 24 	lwz     r11,36(r4)
     1428:	41 82 00 08 	beq     1430 <__c_kernel_time+0x28>
     142c:	91 63 00 00 	stw     r11,0(r3)
     1430:	7d 63 5b 78 	mr      r3,r11
     1434:	4e 80 00 20 	blr

Versus after

00001534 <__c_kernel_time>:
     1534:	81 44 00 04 	lwz     r10,4(r4)
     1538:	6d 49 80 00 	xoris   r9,r10,32768
     153c:	2c 09 ff ff 	cmpwi   r9,-1
     1540:	41 82 00 20 	beq     1560 <__c_kernel_time+0x2c>
     1544:	2c 03 00 00 	cmpwi   r3,0
     1548:	81 44 00 20 	lwz     r10,32(r4)
     154c:	81 64 00 24 	lwz     r11,36(r4)
     1550:	41 82 00 08 	beq     1558 <__c_kernel_time+0x24>
     1554:	91 63 00 00 	stw     r11,0(r3)
     1558:	7d 63 5b 78 	mr      r3,r11
     155c:	4e 80 00 20 	blr
     1560:	7c 08 02 a6 	mflr    r0
     1564:	2c 03 00 00 	cmpwi   r3,0
     1568:	90 01 00 04 	stw     r0,4(r1)
     156c:	42 9f 00 05 	bcl     20,4*cr7+so,1570 <__c_kernel_time+0x3c>
     1570:	7c 88 02 a6 	mflr    r4
     1574:	3c 84 ff ff 	addis   r4,r4,-1
     1578:	38 84 2a 90 	addi    r4,r4,10896
     157c:	81 44 00 20 	lwz     r10,32(r4)
     1580:	81 64 00 24 	lwz     r11,36(r4)
     1584:	41 82 00 08 	beq     158c <__c_kernel_time+0x58>
     1588:	91 63 00 00 	stw     r11,0(r3)
     158c:	80 01 00 04 	lwz     r0,4(r1)
     1590:	7d 63 5b 78 	mr      r3,r11
     1594:	7c 08 03 a6 	mtlr    r0
     1598:	4e 80 00 20 	blr

Christophe

