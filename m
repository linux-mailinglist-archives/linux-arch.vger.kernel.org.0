Return-Path: <linux-arch+bounces-7117-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8A96F498
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 14:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DDF1C21F23
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 12:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295201CBEBC;
	Fri,  6 Sep 2024 12:49:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC35266AB;
	Fri,  6 Sep 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626993; cv=none; b=oF+sH+NbN0Yzb+U+7e2SdHVSh4hoAou+wBxjCj4/UfRXc/0PfPbqb6xXF4QG+HOvB2rI9Haq1jK80T8arCUJ7TQ3vdt8qOYaDWHK28EQ/3EjMmLtGk/VCA8Wfu2W+qox7IGoVON6PwaaObRt53529CN/B6GTShIkQ/phVt6vnfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626993; c=relaxed/simple;
	bh=QaYcT11Zyn+WdN0AhbAZUWQJOXX0cxwqfqioGMJDiWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+v0KXJdOPwKK3scMslODWi0PcLIDg14Ynm1a0FJDiD2t6mxrXAW4V5QBQuP/I0AypmHtzEcjARZ8dABIvBBxzqM9in/GC8XRNcjZsASh/WfhvKpDUBnEdMRlg1P9JY9n55QjrB3VmpquUgmPl4AG3VQB964LCqJNB9JE39B4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0bfN6fPHz9sRs;
	Fri,  6 Sep 2024 14:49:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id agw7d8TAxvw7; Fri,  6 Sep 2024 14:49:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0bfN5Z16z9sRr;
	Fri,  6 Sep 2024 14:49:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AC44A8B778;
	Fri,  6 Sep 2024 14:49:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id nqS38ZzxOd5w; Fri,  6 Sep 2024 14:49:48 +0200 (CEST)
Received: from [192.168.235.70] (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DBC568B764;
	Fri,  6 Sep 2024 14:49:47 +0200 (CEST)
Message-ID: <2aaf06aa-af16-43fc-8bc5-3908760438bb@csgroup.eu>
Date: Fri, 6 Sep 2024 14:49:47 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vdso: Modify getrandom to include the correct
 namespace
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-10-vincenzo.frascino@arm.com>
 <b899bce8-8704-4288-9f32-bcb2fa0d29a8@csgroup.eu>
 <72f3d6cf-a03b-4a16-9983-77d3dd70b0ea@arm.com>
 <4a4873d9-c783-4374-a505-3628d3c92137@csgroup.eu>
 <3155e7ba-33fe-4de8-bb63-867579c3eac8@arm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <3155e7ba-33fe-4de8-bb63-867579c3eac8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/09/2024 à 14:40, Vincenzo Frascino a écrit :
> 
> 
> On 06/09/2024 13:04, Christophe Leroy wrote:
>>
>>
>> Le 06/09/2024 à 13:52, Vincenzo Frascino a écrit :
>>>
>>>
>>> On 04/09/2024 18:26, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
>>> ...
>>>
> 
> ...
> 
>>
>> More details:
>>
>> $ make ARCH=powerpc CROSS_COMPILE=ppc-linux- mpc885_ads_defconfig
>>
>> $ LANG= make ARCH=powerpc CROSS_COMPILE=ppc-linux- vmlinux
>>    SYNC    include/config/auto.conf
>>    SYSHDR  arch/powerpc/include/generated/uapi/asm/unistd_32.h
>>    SYSHDR  arch/powerpc/include/generated/uapi/asm/unistd_64.h
>>    SYSTBL  arch/powerpc/include/generated/asm/syscall_table_32.h
>>    SYSTBL  arch/powerpc/include/generated/asm/syscall_table_64.h
>>    SYSTBL  arch/powerpc/include/generated/asm/syscall_table_spu.h
> 
> Thank you Christophe, is upstream code sufficient to reproduce the issue? Or do
> I need specific patches?
> 

You need random git tree plus the patch "[PATCH] powerpc patches for 
Vincenzo's series" I have just sent to you.

Christophe

