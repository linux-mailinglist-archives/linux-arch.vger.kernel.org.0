Return-Path: <linux-arch+bounces-5718-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09045940ADC
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 10:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C7B20E7E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DB818D4DC;
	Tue, 30 Jul 2024 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K92aQQ6E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A118732A;
	Tue, 30 Jul 2024 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327038; cv=none; b=ozxobXcjqNONM+aZTk4ceC3Cb71lKxX6h5JYtuSLYuBAHkAcx2T1nawGDVb+BYGYs1ffkZdHz49l8SFpH1qui+B3Rndj8OhHiJXnY+Q7fpiPYBISFDOYa401PzmZ1zVBCKFHd4owRTCQawWFaOLjXNpyte9Cgucy3BATQKfcSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327038; c=relaxed/simple;
	bh=my3L8G0O16Q8jX9sqyOmzVO7D6UraxN07D2CKn52GqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+pRza2eQCjhHsRnw8d6tD8QZkss4EIh7vvq7Mwk0Y9a5qf5aL1Fa3uFl3rIYwuJK7nHwDwWBzm1mPu/CJhyw6sGA12KbEf2hzM5FMp4aiTgajwR5UdJSK+e8Tz4Y5EvEY9KB55mL3rGg+CZuIel1ZkFB5lSDGQxV2U+iqiwNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K92aQQ6E; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so2686988a91.2;
        Tue, 30 Jul 2024 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722327037; x=1722931837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/S17o3ryXO92fKPDsd+20QrVlSG6ehQAGuA4AgUnAA=;
        b=K92aQQ6EToRphSoApSUrNv9TcWAV00giqy1FKYcc1rNgbn0WatSVSzbN4RYgvXfPLq
         RDNSxMnejnatQ+v3Jb2c7c+G00c+62oUN//O7u5Sm/wdlW3iGuCO3+ZApgAw6q6BHnQT
         I9PYQdUkhmBpuYHkpYQ7/GCippVWIxS3g8fPKMK+/fM6DrO3fAvC6vyRkKWPhRFuwrTH
         h7i8tkHlhJlHFO3LqVOFNi3ofLsU6dws3lfmHy7xKUUcqw2BlD8Um4/cTiRMq/0L9IzZ
         zYbdLl0zDM8przMPBOOU5+rn7atr+JZQt0jxz0G9/Pc0KGXmvgwf3cKxpoxhBln7tgPb
         Xh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722327037; x=1722931837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/S17o3ryXO92fKPDsd+20QrVlSG6ehQAGuA4AgUnAA=;
        b=WL7HLqmNI0TNsGFXuyLR/X8gBJv8vsrf8poOC2KQDUnkfrHfrg0bfpllsVeOyUPiKX
         buY8xgk8GV77qyLbcbjIHKlKrAQZnGgPabrZktAkaTw7NE9EKoaASjOe8/GYgExRYw6T
         dkpHAeWFeXo/MpzY0F7JKIWuQTZD7nFrsj02w4ONJocyEmWBgnzLoUt2RXsAEkVEaLl6
         EfAcdz9ZCYIjorPPTwwbXePMXLorIFYI0rdoSSWSZOM1MhTjc02LpDcGPrLHlc1bgTXl
         gO6Oedl8ydH6fhopBLeFTXds27+vwPVzItVabXGsGEVB+VnGoOewZqZaH1RX4ivmeE+0
         V1PA==
X-Forwarded-Encrypted: i=1; AJvYcCVv9iHeTMP658fDH9SRkKQYheq3K3XX3u93uITJn3A+Y2LSFpHsTkCwEsoG0CfZzbuibn7cCZOwqyagORAkW4YSL4ztQL4C7ptW4qbnzSc+cAkRO/Q51KRF8eTe0pAfp0ahgiCziMSmszp/3z8u/dCzPCRttl0VC7lxOzAOuT3Nt+caJHSeJWFiEhKU1G9vACaMkJZOiQWV6GygOhzccOGHnsAPijVafygMOg00rptdLr36MiZKGC2I61r2gU/7y6kzKvNc1uTqCLA2EkAcvc/LNXZ9SmWW8hvxbVfYnW3G
X-Gm-Message-State: AOJu0Ywp2yza0NY2+Qoe8YLoIiSWhxeerinpvm6KLJQxfEEYDYD4GztN
	xHsNEsN95MWG5Br/8C9IUX/OgTuLWIHUAP6ATca8UQ6C3hKzQJoS
X-Google-Smtp-Source: AGHT+IHd+8idtSf9No9KXFiHPkFqgsgm8Dqu198TXfzlUpyaNdqot/AMDpkwkaetathdKfNuieqdfQ==
X-Received: by 2002:a17:90b:3a90:b0:2c9:9fdf:f72e with SMTP id 98e67ed59e1d1-2cf7e606d04mr8262857a91.26.1722327036447;
        Tue, 30 Jul 2024 01:10:36 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28e3cbaasm9886868a91.51.2024.07.30.01.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:10:35 -0700 (PDT)
Message-ID: <c2accb5d-33f6-404b-9298-6b9e8bf24a9b@gmail.com>
Date: Tue, 30 Jul 2024 16:10:23 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/18] use struct ptdesc to replace pgtable_t
To: alexs@kernel.org, Will Deacon <will@kernel.org>,
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
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Vishal Moola <vishal.moola@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Lance Yang <ioworker0@gmail.com>,
 Peter Xu <peterx@redhat.com>, Barry Song <baohua@kernel.org>,
 linux-s390@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Mike Rapoport <rppt@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel
 <anup@brainfault.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Breno Leitao <leitao@debian.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>
References: <20240730064712.3714387-1-alexs@kernel.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240730064712.3714387-1-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

BTW, the patchset based on the latest git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-unstable branch.

On 7/30/24 2:46 PM, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> We have struct ptdesc for page table descriptor a year ago, but it
> has no much usages in kernel, while pgtable_t is used widely.
> 
> The pgtable_t is typedefed as 'pte_t *' in sparc, s390, powerpc and m68k
> except SUN3, others archs are all same as 'struct page *'.
> 
> These blocks the conception and code update for page table descriptor to
> struct ptdesc.
> 
> So, the simple idea to push the ptdesc conception forward is to update
> all pgtable_t by ptdesc or pte_t pointer. But this needs widely
> knowledges for most all of different archs. Common code change is easy
> for include/ and mm/ directory, but it's hard in all archs.
> 
> Thanks for intel LKP framework, I fixed most all of build issues except
> a bug on powerpc which reports a "struct ptdesc *" incompatible with 
> struct ptdesc *' pointer issue...
> 
> Another trouble is pmd_pgtable() conversion in the last patch.
> Maybe some of arch need define theirself own pmd_ptdesc()?
> 
> This patchset is immature, even except above 2 issues, I just tested
> virutal machine booting and kselftest mm on x86 and arm64.
> 
> Anyway any input are appreciated!
> 
> Thanks
> Alex
> 
> Alex Shi (18):
>   mm/pgtable: use ptdesc in pte_free_now/pte_free_defer
>   mm/pgtable: convert ptdesc.pmd_huge_pte to ptdesc pointer
>   fs/dax: use ptdesc in dax_pmd_load_hole
>   mm/thp: use ptdesc pointer in __do_huge_pmd_anonymous_page
>   mm/thp: use ptdesc in do_huge_pmd_anonymous_page
>   mm/thp: convert insert_pfn_pmd and its caller to use ptdesc
>   mm/thp: use ptdesc in copy_huge_pmd
>   mm/memory: use ptdesc in __pte_alloc
>   mm/pgtable: fully use ptdesc in pte_alloc_one series functions
>   mm/pgtable: pass ptdesc to pte_free()
>   mm/pgtable: introduce ptdesc_pfn and use ptdesc in free_pte_range()
>   mm/thp: pass ptdesc to set_huge_zero_folio function
>   mm/pgtable: return ptdesc pointer in pgtable_trans_huge_withdraw
>   mm/pgtable: use ptdesc in pgtable_trans_huge_deposit
>   mm/pgtable: pass ptdesc to pmd_populate
>   mm/pgtable: pass ptdesc to pmd_install
>   mm: convert vmf.prealloc_pte to struct ptdesc pointer
>   mm/pgtable: pass ptdesc in pte_free_defer
> 
>  arch/alpha/include/asm/pgalloc.h              |   4 +-
>  arch/arc/include/asm/pgalloc.h                |   4 +-
>  arch/arm/include/asm/pgalloc.h                |  13 +--
>  arch/arm/include/asm/tlb.h                    |   4 +-
>  arch/arm/mm/pgd.c                             |   2 +-
>  arch/arm64/include/asm/pgalloc.h              |   4 +-
>  arch/arm64/include/asm/tlb.h                  |   4 +-
>  arch/csky/include/asm/pgalloc.h               |   4 +-
>  arch/hexagon/include/asm/pgalloc.h            |   8 +-
>  arch/loongarch/include/asm/pgalloc.h          |   8 +-
>  arch/m68k/include/asm/motorola_pgalloc.h      |  12 +-
>  arch/m68k/include/asm/sun3_pgalloc.h          |   4 +-
>  arch/microblaze/include/asm/pgalloc.h         |   2 +-
>  arch/mips/include/asm/pgalloc.h               |   4 +-
>  arch/nios2/include/asm/pgalloc.h              |   4 +-
>  arch/openrisc/include/asm/pgalloc.h           |   8 +-
>  arch/parisc/include/asm/pgalloc.h             |   2 +-
>  arch/powerpc/include/asm/book3s/32/pgalloc.h  |   4 +-
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |   4 +-
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |   4 +-
>  arch/powerpc/include/asm/book3s/64/pgalloc.h  |   4 +-
>  arch/powerpc/include/asm/book3s/64/pgtable.h  |   8 +-
>  arch/powerpc/include/asm/book3s/64/radix.h    |   4 +-
>  arch/powerpc/include/asm/pgalloc.h            |   8 +-
>  arch/powerpc/mm/book3s64/hash_pgtable.c       |  10 +-
>  arch/powerpc/mm/book3s64/radix_pgtable.c      |  10 +-
>  arch/riscv/include/asm/pgalloc.h              |   8 +-
>  arch/s390/include/asm/pgalloc.h               |   4 +-
>  arch/s390/include/asm/pgtable.h               |   4 +-
>  arch/s390/mm/pgalloc.c                        |   2 +-
>  arch/s390/mm/pgtable.c                        |  14 +--
>  arch/sh/include/asm/pgalloc.h                 |   4 +-
>  arch/sparc/include/asm/pgalloc_32.h           |   6 +-
>  arch/sparc/include/asm/pgalloc_64.h           |   2 +-
>  arch/sparc/include/asm/pgtable_64.h           |   4 +-
>  arch/sparc/mm/init_64.c                       |   2 +-
>  arch/sparc/mm/srmmu.c                         |   6 +-
>  arch/sparc/mm/tlb.c                           |  14 +--
>  arch/x86/include/asm/pgalloc.h                |  10 +-
>  arch/x86/mm/pgtable.c                         |   8 +-
>  arch/xtensa/include/asm/pgalloc.h             |  12 +-
>  fs/dax.c                                      |  14 +--
>  include/asm-generic/pgalloc.h                 |  10 +-
>  include/linux/mm.h                            |  16 ++-
>  include/linux/mm_types.h                      |   4 +-
>  include/linux/pgtable.h                       |   6 +-
>  mm/debug_vm_pgtable.c                         |   6 +-
>  mm/huge_memory.c                              | 103 +++++++++---------
>  mm/internal.h                                 |   2 +-
>  mm/khugepaged.c                               |  14 +--
>  mm/memory.c                                   |  15 +--
>  mm/mremap.c                                   |   2 +-
>  mm/pgtable-generic.c                          |  37 +++----
>  53 files changed, 240 insertions(+), 236 deletions(-)
> 

