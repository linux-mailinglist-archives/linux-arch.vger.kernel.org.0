Return-Path: <linux-arch+bounces-15847-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0135D39712
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jan 2026 15:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 181CA300F706
	for <lists+linux-arch@lfdr.de>; Sun, 18 Jan 2026 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333F331213;
	Sun, 18 Jan 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtTGXFAH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784952DEA80
	for <linux-arch@vger.kernel.org>; Sun, 18 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768745488; cv=none; b=XLjtlhtS7LsV531Lam+SYkOZSmXBesaQTcyI/xdowpKMV76XTDWeuhhBDHp87y1eF9pmDF3Tgg1j1DIXNlA2Ewa9vms92QLQVFdpmELhK+NG3ep67Np4zzHQauFN2A7mihJ9olbG3lbxi1oemofTlSpYW5thKzTaXjDEPH91GlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768745488; c=relaxed/simple;
	bh=APuCaRsP0tJWIJZvULDtqm9mswir8H+vbo2b0RKmV7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMTYTydSc/k6pRT4rQ/sSlPfvan/nXE4CByZA7kgFMNdOQS8JkG+gcvyDFhQ5Qnts7uEqJNnw4d3sN9N7dp37dLx/OpyXH6of0kG+dXbWBB/dCe66ZBEAI77srnoLvsKe6ArnuY9HI0ESYvAEtkApXRuEA+Zhd9Vu+m+j3+Kyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtTGXFAH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso2214509a12.1
        for <linux-arch@vger.kernel.org>; Sun, 18 Jan 2026 06:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768745486; x=1769350286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqDJGvudyOS3k99PpLPEmecPUls9OZTpXwxY9UHrGPM=;
        b=KtTGXFAHKoiuI8trEVvYLcXGftTm2T2gpGipyiFqZjzlARIAduJE04J9VvEn1HB70x
         KWoqdLXW0jo6D0qSOrVa2dpoeIQpl8LmKTcsNr/HXIlChpVDWJIrQGFJcg/onrY4+w7/
         /ezIcWnGfpdTv+NGnGwHnl3skAFeTFRHlpYFxkcySI4upkIVP/IrPzy9KMgMPvzVaG2x
         DwkUYavTgQ2jrBRoSgoB/Qmef/SwoLNtfvMzucKn7zWRp+MV2r1w4RXleTaOr75oFfhM
         Lh9NQi773sOwctJBjq69Zh0Wx4lgmU9Xmhyuf0vw+TjGxvyJJprQgnkGoA/TjCL+84cq
         ekKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768745486; x=1769350286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqDJGvudyOS3k99PpLPEmecPUls9OZTpXwxY9UHrGPM=;
        b=w5KNKsMjDPAMdc1HsrNIUfFWfCeMh7JpWt2/GsFr2SKSDfULO+9nqeNCqyQhXCYbKr
         RvAlebu/Ced+B0FRfiSOOrri7VTtDTCBBh6hhaOUxD0SEgE3CVxYs/7uTD0uRIhXT/cN
         YzE1skRizpXFNQFoG8c5FT1HPXToaDs/98Q1uLg0d9uMP/5/7hb5Z8SLrBBF1Ju2JmxJ
         V6mzP6DpJ5vSs0Wak/TrLBBrDQKpc1Q/V2wtH5qYNFu7RHIxxlNC6IUiKkGCXy1OH6TL
         gPnu6wioYPeN7XjCUg612FCEQqHdpUJpGvwjV1zVDbgL7f3ltPbYsicv8ZGARDA6Aon3
         zPzA==
X-Forwarded-Encrypted: i=1; AJvYcCXIEloxPmOT7YKkvSeceXY53Y32rizkyWoKMzWwZIvWxqQNXyKfdaBgDuq4egOtZ6AJxQMncma0XcBt@vger.kernel.org
X-Gm-Message-State: AOJu0YwmEsetaMFZrmjUesAqhP5YW53+qlpYk3XkE5cA8fVVl19sWiuK
	PgJtCgiaRt4wWWNOVlsSuRwJCTmckJs/dD1fFR5ex3ymuxn2AoYHQOJ8
X-Gm-Gg: AY/fxX7o2Zmh3PtIuFrbHtm17ytALxiAvqWK7RjXd1KfJT2fLs7L52wVTJcEkgYkGoI
	kKdoDZmgWj7i7IO3EMMBXo+mmW+31ALLE/Ks3rNCkN8RWzdVW3KjFwDoYWjgo+GSCpCe4cSMdgg
	42GYE3Y5e3iX3HLvakwj9i142v9ytfNNkjZomu4wOTB+k2cv2TAM6g9bIBO9mDrT3IefVhcYI3k
	c4xtMN5swSkwAPx3V4s6B77kiKlIRDML0TKO2zj5tQxfIjw+DLSzkarqfJIopV0Kc6QOdrddAwe
	9WoBPWX2UlE/yPnodJ33SHHuwZkZo7uytJD7MJHDU+HuTFeejQgAI81OdbTzBHh5NGjB1zbOFnj
	yaXaq26Tvu5EsXu7AusQLeD048LkodFR++yvcri7cJgQGJGDyAaWUQ2LIBWsn1OjPnyGEXNc+t4
	cBdF4DXvCM
X-Received: by 2002:a05:6a20:a122:b0:37e:61fc:a896 with SMTP id adf61e73a8af0-38dfe7c3042mr7636975637.66.1768745485767;
        Sun, 18 Jan 2026 06:11:25 -0800 (PST)
Received: from [192.168.2.226] ([114.92.45.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d1f1sm6549138a12.22.2026.01.18.06.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 06:11:25 -0800 (PST)
Message-ID: <b27b8bc4-8730-4ce8-bf39-0ca8459feecc@gmail.com>
Date: Sun, 18 Jan 2026 22:10:50 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/pgtable: convert pgtable_t to ptdesc pointer
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, alexs@kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 "open list:MMU GATHER AND TLB INVALIDATION" <linux-arch@vger.kernel.org>,
 "open list:MMU GATHER AND TLB INVALIDATION" <linux-mm@kvack.org>,
 "open list:C-SKY ARCHITECTURE" <linux-csky@vger.kernel.org>,
 "open list:QUALCOMM HEXAGON ARCHITECTURE" <linux-hexagon@vger.kernel.org>,
 "open list:LOONGARCH" <loongarch@lists.linux.dev>,
 "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 "open list:OPENRISC ARCHITECTURE" <linux-openrisc@vger.kernel.org>,
 "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
 "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>,
 "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>
References: <20260107064642.15771-1-alexs@kernel.org>
 <aV4h5vQUNXn5cpMY@kernel.org>
 <080e493a-e4f1-4c97-a3e1-f76f126b5213@gmail.com>
 <aV5yIuGi9Ni5YP5E@casper.infradead.org>
 <1d110134-89ab-474b-bca6-cfbfd4b5057f@gmail.com>
 <85a0be43-3598-435d-a50e-9403b7e963f7@gmail.com>
 <4fd1610b-acc5-4c17-a227-4d63272d3718@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <4fd1610b-acc5-4c17-a227-4d63272d3718@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/1/18 18:51, David Hildenbrand (Red Hat) wrote:
> On 1/18/26 09:13, Alex Shi wrote:
>>
>>
>> On 2026/1/8 10:23, Alex Shi wrote:
>>>
>>>
>>> On 2026/1/7 22:48, Matthew Wilcox wrote:
>>>> On Wed, Jan 07, 2026 at 05:28:36PM +0800, Alex Shi wrote:
>>>>> Right, I will fix this. and sent the 2nd version.
>>>> No, the patch is stupid and wrong.  Don't send a v2.  You seem to 
>>>> have a
>>>> hairtrigger resend, so I'm trying to prevent a v2 being sent instead of
>>>> sending a patient reply.
>>>
>>> Hi Matthew,
>>>
>>> I hear you—no v2 will be sent.
>>> but sorry for a bit confusing, what's your expected fix? is the too
>>> quick resenting? or the direction to alignment pgtable_t with ptdesc is
>>> wrong?
>>
>> Hi Willy, Do you mind to share the detailed concern for this patch?
> 
> I think we recently had a discussion that we should much rather rework 
> core code to consistently make pgtable_t a pointer to the start of the 
> page table or something like that.
> 
> Because the way you change the code just means that we will not be able 
> to handle code that fits multiple pages tables into a single page 
> (s390x, ppc) consistently.
> 
>      arch/s390/include/asm/page.h:typedef pte_t *pgtable_t;
> 

Got it. Thanks a lot for the explanation!


