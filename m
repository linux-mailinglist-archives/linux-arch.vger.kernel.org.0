Return-Path: <linux-arch+bounces-6213-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600E952961
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 08:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DBA71F237B7
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 06:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95159176FD3;
	Thu, 15 Aug 2024 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgsHw3OM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028F315CD6E;
	Thu, 15 Aug 2024 06:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703537; cv=none; b=aR/eGClj4RDH7JrgSmPquNHs/236WdupFc8nyL+IF6TiGxBnRIvq5WSnpJW944t+FxfgLhHB7BgajgWB3yVxl3V1hrRMzsq1MakkIa86+MzX09uCY5aDhW0h6iuRn6784Xgn5qWjWvSlIhlbBwiUrc9z6a30DSc6FtFGQ8tNBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703537; c=relaxed/simple;
	bh=HXuXwTles2EvknzMcg/wNQdnX/Z4GUExBFPaBatXWHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRCK1tB0W9WefMdfNap8BzwHeiu5tzQ23N/3mJQDaUz72GvIACrVn5GO1y/gG9BFYi+xlwa2/2mO6KEgzItCx4JEbTnndGOHicHps2c/vDkXf0fQ4gGwpMCNd0PM4hvc6dFGe9HyVXLVskSpr10vNsX6dh4L/n2aENW2f2LWqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgsHw3OM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc566ac769so5972485ad.1;
        Wed, 14 Aug 2024 23:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723703535; x=1724308335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt+p09uz8tAqwLeLii8cPw/zrSYX75ywbDJiGCl6kRA=;
        b=BgsHw3OMVpS5i/Qs3DAu2+iczTm/KCuoye6MW5IuXx2aXEIYWg/NCFE8b37vS8Sp8I
         fY/5nBZW3tjy6tWVK9FMHyjTg4zrWUGg88p9sOm9p896BWnH5zzoo0kGLeFU1Ped0WIz
         6VIo6rZLY9xKh78P1lYNbg9VCx1MViHDD9K3oBpe0RajGEdy4315QbI3DSop7ZHkwKoH
         D6xwiBm0CSUMJhMvckrYBX1C0CoPv7jPtrcGDXEZQJmEhMjy+2QsSxBP8X6VDlfJ3F7e
         d6/FeFJ5CoX7m+dlyWi4Uun19SfGNh6fWjp7SJQRJ7WkYLMFyK73vNP0wGDLz5stLjHz
         do4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723703535; x=1724308335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt+p09uz8tAqwLeLii8cPw/zrSYX75ywbDJiGCl6kRA=;
        b=n2DGU8tnx2bvhhXFYDstEeJLvjSDcLuKUHFqh8nliY832WzBX9q6XS58Fzc4w4rbvh
         nFs30dYCti2kUMMrW/8gD7rCq127sAwYjDFQZHtlNZANdUaLN7hH0CHbNtozOJFOa0j6
         R1lnneVQVmsH8lA8yHEeIbigBVRHVf1Mceqeym+EQ/k3qLTAy4J5khEbNgIsL+z3O1YT
         tQAQE2heI9SIhP16Oh+Kmf6ENIbaht0gUZjSFvFetuywB545eXuSVVAulPUpC/uwHCWT
         Q10y3Up8V9UlzHJmC34+lMir1Ha97VfgmqED+Fvt5wQ5elN6z4KML3qmTIyfjhdyYZpS
         nkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6I0Yeu/GICgqiyWsYqes73LCxhJT9GYtKop03ZCAevkb3AOtNRRpeqFtfHGrYnGnQLxq+I0oumh4WgIMdRfYTb1QlVKP+ZM7XMBrF7vuvWxxcQEP4/UKrcW8A27G4lUp2H6j6OBTWLNa6Ma8XeIkVR3PQtnO5CDRflyVlGOu7r4uZgIUhWZikT/liLmUKfvjRieLTkwzgXjQnwRvkHFV6SocGnrizdQMMUWMS7EPjubHpbhyb2r+0Sf0iI/amm88QYYthOMtgdSbI08vjtZ6W3rioG+ySCX60/423WSYI
X-Gm-Message-State: AOJu0YxxMBipPaiU6JN7VhDNbRqdEkOfRyTsUIBYHysMseaL7Up6gzF6
	3a2sGR7In1XYbje2nlGVV4Iec1zx8KTFRE8GjLIoPQItXnQVos4Q
X-Google-Smtp-Source: AGHT+IGHQF6v1wj4OnSDtmW1i+o0W3hXKMZnU/CMxWJVexuFM/VLhfFkwN0de8G4/UHXSn+MbeyB0Q==
X-Received: by 2002:a17:903:11c4:b0:1fb:cf82:11b4 with SMTP id d9443c01a7336-201d63bc296mr66187655ad.6.1723703534763;
        Wed, 14 Aug 2024 23:32:14 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f039ef06sm5216095ad.249.2024.08.14.23.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 23:32:14 -0700 (PDT)
Message-ID: <3351b0db-4764-48a4-8bab-478ba7bfa4f4@gmail.com>
Date: Thu, 15 Aug 2024 14:32:01 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] use struct ptdesc to replace pgtable_t
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
 "alexs@kernel.org" <alexs@kernel.org>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Brian Cain <bcain@quicinc.com>,
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Vishal Moola <vishal.moola@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Lance Yang <ioworker0@gmail.com>,
 Peter Xu <peterx@redhat.com>, Barry Song <baohua@kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang
 <jszhang@kernel.org>, Samuel Holland <samuel.holland@sifive.com>,
 Anup Patel <anup@brainfault.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
 <392b267e-cf98-4aa0-bb6e-90f6861d097d@cs-soprasteria.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <392b267e-cf98-4aa0-bb6e-90f6861d097d@cs-soprasteria.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/15/24 12:50 AM, LEROY Christophe wrote:
> Hi,
> 
> Le 30/07/2024 à 08:46, alexs@kernel.org a écrit :
>> From: Alex Shi <alexs@kernel.org>
>>
>> We have struct ptdesc for page table descriptor a year ago, but it
>> has no much usages in kernel, while pgtable_t is used widely.
>>
>> The pgtable_t is typedefed as 'pte_t *' in sparc, s390, powerpc and m68k
>> except SUN3, others archs are all same as 'struct page *'.
>>
>> These blocks the conception and code update for page table descriptor to
>> struct ptdesc.
>>
>> So, the simple idea to push the ptdesc conception forward is to update
>> all pgtable_t by ptdesc or pte_t pointer. But this needs widely
>> knowledges for most all of different archs. Common code change is easy
>> for include/ and mm/ directory, but it's hard in all archs.
>>
>> Thanks for intel LKP framework, I fixed most all of build issues except
>> a bug on powerpc which reports a "struct ptdesc *" incompatible with
>> struct ptdesc *' pointer issue...
> 
> Can you tell more about that problem on powerpc ? Which defconfig for 
> instance ?
> 

Hi Leroy,

Thanks a lot for response. The detailed error and code tree is from LKP:

On 8/3/24 11:26 AM, kernel test robot wrote:
> tree:   https://github.com/alexshi/linux.git ptdesc
> head:   3735e634f8feb67c941d17222b53906ace2fd2b8
> commit: 8ac2ea5f299444d065b292043aed0a1e94996159 [14/17] mm/pgtable: use ptdesc in pgtable_trans_huge_deposit
> config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20240803/202408031130.UnwgnuLS-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408031130.UnwgnuLS-lkp@intel.com/reproduce)

>    In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:
>>> arch/powerpc/include/asm/book3s/64/pgtable.h:1372:52: error: incompatible pointer types passing 'struct ptdesc *' to parameter of type 'struct ptdesc *' [-Werror,-Wincompatible-pointer-types]

>>
>> Another trouble is pmd_pgtable() conversion in the last patch.
>> Maybe some of arch need define theirself own pmd_ptdesc()?
>>
>> This patchset is immature, even except above 2 issues, I just tested
>> virutal machine booting and kselftest mm on x86 and arm64.
>>
>> Anyway any input are appreciated!
> 
> Can you tell on which tree you based this series ? Last patch doesn't 
> apply on 6.11-rc1:

The code based on akpm/mm-unstable tree, not upstream, you can check the code on:
https://github.com/alexshi/linux.git ptdesc

Thanks a lot!
Alex

