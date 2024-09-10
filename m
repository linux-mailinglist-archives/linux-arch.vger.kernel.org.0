Return-Path: <linux-arch+bounces-7169-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CDA972D52
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 11:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 217141C222B7
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0863F18892C;
	Tue, 10 Sep 2024 09:21:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B7187871;
	Tue, 10 Sep 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960059; cv=none; b=fCokRSuwXi/adYvJpW8/6OFvNct1YjFfJVuQbocGWXYzDR76zNHNcc9j9hXssIulucYzXR+Aa9hpU/nAQI3ySGk4porkjCkKNRrogbkcseFBZIeol1jnOvnDumQbwjZZTd5P5loTQa2O2jZuBDW7UZAIkgygU3riyMTstxv8wYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960059; c=relaxed/simple;
	bh=t7RstencTxbPCax7NqKjh0Q/O//hJkQzy/Uio3Lz6vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uztTpVahGqDLJv4BAlSZusuVR8iqCVAIft8K6ayxPOop6PQ/jlOdPvplX54N4Xu03qWhn+Vzpt5H0+C2R+ocoO3WZigov/LMf6YVuu57VnrHB9iyevLZZkh/QltKxJJwv8kEnxUR+gPaW80715WoVhJssp3ATuFjgjrWj7OluCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X2yqV65wcz9sSY;
	Tue, 10 Sep 2024 11:20:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IH7tHx1tf7FV; Tue, 10 Sep 2024 11:20:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X2yqM6SKKz9sRr;
	Tue, 10 Sep 2024 11:20:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CAC578B770;
	Tue, 10 Sep 2024 11:20:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 2EIwfKNuyIWc; Tue, 10 Sep 2024 11:20:47 +0200 (CEST)
Received: from [192.168.232.177] (unknown [192.168.232.177])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 089D78B766;
	Tue, 10 Sep 2024 11:20:44 +0200 (CEST)
Message-ID: <1aca8e4c-1c12-4624-a689-147ff60b75d6@csgroup.eu>
Date: Tue, 10 Sep 2024 11:20:44 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
To: Charlie Jenkins <charlie@rivosinc.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Shuah Khan <shuah@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
 Chris Torek <chris.torek@gmail.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-abi-devel@lists.sourceforge.net
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <87zfol468z.fsf@mail.lhotse> <Zt9HboH/PmPlRPmH@ghost>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zt9HboH/PmPlRPmH@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> diff --git a/include/uapi/linux/personality.h b/include/uapi/linux/personality.h
>>> index 49796b7756af..cd3b8c154d9b 100644
>>> --- a/include/uapi/linux/personality.h
>>> +++ b/include/uapi/linux/personality.h
>>> @@ -22,6 +22,7 @@ enum {
>>>   	WHOLE_SECONDS =		0x2000000,
>>>   	STICKY_TIMEOUTS	=	0x4000000,
>>>   	ADDR_LIMIT_3GB = 	0x8000000,
>>> +	ADDR_LIMIT_47BIT = 	0x10000000,
>>>   };
>>
>> I wonder if ADDR_LIMIT_128T would be clearer?
>>
> 
> I don't follow, what does 128T represent?
> 

128T is 128 Terabytes, that's the maximum size achievable with a 47BIT 
address, that naming would be more consistant with the ADDR_LIMIT_3GB 
just above that means a 3 Gigabytes limit.

Christophe

