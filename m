Return-Path: <linux-arch+bounces-6815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E0964C7B
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 19:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803C5283408
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEE81B6535;
	Thu, 29 Aug 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="prPHO91H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904A1B5835
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950850; cv=none; b=NqfTeECurivw7J0PpLkCPoFR4jDA53r+MYGsYBeBELEGotpcsCLA0SkBlPFlsC2/rE26vlTG1nzh+y6L7SoKjcMnhP0cjDVhq/I51SeBF3yyJcLDIgRXrdtBVEbU78LXxsEhhHneujPLzKuN0GGNpoaW+xW65V5lN4Wu/bNBwNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950850; c=relaxed/simple;
	bh=r39iS0mZmeesAN8mRRVPFX8IPK5tuUvZAQuloWJvpeY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID; b=ighXzkJAywE9Pf4PWq48I8WYVn22uKPnWq7ZJPj20s1CYGeUmaaRUXXu3h+phr4uwwo0kavoqysJTu+K3sBLLadcMRIs8tKnfbaTsgSmRioT7aKlCe3efX29ipaqAp+lDxQ/JpD1PjEI5MGkPdaKDEznBrt7HWpJiMz3L1rT5n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=prPHO91H; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71433cba1b7so660761b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1724950847; x=1725555647; darn=vger.kernel.org;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v6yVeKIAZdNlCjwxHunt8GrVJ/ApsEacIVWq6Y0ogzc=;
        b=prPHO91HSOADrr0+kq1K3EW7V4m4kl9hSOqwXlAafDmUTelXdjybDUTlZbkiN7OVvN
         xcsMEQYJtQKmAe5ue2qfht7+JihW/zuooKT+bZzFgXecRpQyoyfPOA0r910tsIvcCe8P
         eW6BiwPE/NlP4s+EbJr/Se93Ez0FltvnHkzKdYniKxQESxLgegL2vrkH1toRHSV6WrJe
         KuVieK0r1hNlauuOjMruyaNzBN/POjtgWpeSOWp6ZTo8VIT5bRaAbjYMDrnv/vEuJQBY
         S62YQ/K3K1OPYL1ioTcwjZQ075ho3OZfAJU3dgSAWyhj+9kFwdA4RVW90DIZLApOnSD9
         P/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724950847; x=1725555647;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6yVeKIAZdNlCjwxHunt8GrVJ/ApsEacIVWq6Y0ogzc=;
        b=YXkoI6NwCdfrA8P1uldIWoVjiTt53na19wy1SIeCip3UQoddrJyIenfuNs/H7tKAgw
         hYFlLPkOu3QFSXTyUGxmZ5zob7Ze9/QWqnm/hj3oF6TZbqhH2bgNHLgsQSiafEUR4yMs
         8IU4rqjyxQP2QZdrMiN7WK835jroCy5u65zFcW5jvLP/Nu+FvsBCsWnJ4IDySBCjCYsm
         cU5NhU4EmFC6+8qnzXWyPKDgX7yZgs1jwL0JLr8sKB7P6tuOIIb2jrjIlEvae0kfntjp
         qRNJwTpscH6GHZyLC59N9OZE71ZBJdUc2ADGsHd0xuOCaYBq3IsB015RlZSXgoQD4LKw
         bNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBXEeN4IWOOwZgvI8T9ETB5nQu+J+Qu7VM0wVGsVwLyXoSzOpUQBusfLxautgdakMWZNg6xPF42eqt@vger.kernel.org
X-Gm-Message-State: AOJu0YxANt5L2MTKijF5bOt8mnfL6h3ujLcKxMTPHjzFCGVjXo/fsZig
	W9cIpFti9lUG1cu6UOMel1MlB+KT1hZFPE4bQfTO0g++0GF0tljHPrXlsB5hhkc=
X-Google-Smtp-Source: AGHT+IH3f6jrHjn3UecOjnnTSh7f1mjtosaBnqcvhiQTmwoBq2WfcZwsjSYUQZNm8240zpeF9tE3wA==
X-Received: by 2002:a05:6a00:91a0:b0:70d:2b1b:a37f with SMTP id d2e1a72fcca58-715dfc22895mr4520173b3a.24.1724950846693;
        Thu, 29 Aug 2024 10:00:46 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77438dsm1466259a12.27.2024.08.29.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 10:00:45 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:00:45 -0700 (PDT)
X-Google-Original-Date: Thu, 29 Aug 2024 10:00:42 PDT (-0700)
Subject:     Re: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
In-Reply-To: <a048515e-f6e4-4d77-920b-6742529f3ca4@suse.cz>
CC: Charlie Jenkins <charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
  Richard Henderson <richard.henderson@linaro.org>, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org,
  linux@armlinux.org.uk, guoren@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
  tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au,
  npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, agordeev@linux.ibm.com,
  gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
  svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de,
  davem@davemloft.net, andreas@gaisler.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
  dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
  muchun.song@linux.dev, akpm@linux-foundation.org, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
  shuah@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
  linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
  linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: vbabka@suse.cz
Message-ID: <mhng-77a89c0b-bfdf-4a6f-bb6e-cee3ff1efbc6@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

On Thu, 29 Aug 2024 02:02:34 PDT (-0700), vbabka@suse.cz wrote:
> Such a large recipient list and no linux-api. CC'd, please include it on
> future postings.
>
> On 8/29/24 09:15, Charlie Jenkins wrote:
>> Some applications rely on placing data in free bits addresses allocated
>> by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
>> address returned by mmap to be less than the 48-bit address space,
>> unless the hint address uses more than 47 bits (the 48th bit is reserved
>> for the kernel address space).
>>
>> The riscv architecture needs a way to similarly restrict the virtual
>> address space. On the riscv port of OpenJDK an error is thrown if
>> attempted to run on the 57-bit address space, called sv57 [1].  golang
>> has a comment that sv57 support is not complete, but there are some
>> workarounds to get it to mostly work [2].
>>
>> These applications work on x86 because x86 does an implicit 47-bit
>> restriction of mmap() address that contain a hint address that is less
>> than 48 bits.
>>
>> Instead of implicitly restricting the address space on riscv (or any
>> current/future architecture), a flag would allow users to opt-in to this
>> behavior rather than opt-out as is done on other architectures. This is
>> desirable because it is a small class of applications that do pointer
>> masking.
>
> I doubt it's desirable to have different behavior depending on architecture.
> Also you could say it's a small class of applications that need more than 47
> bits.

We're sort of stuck with the architeture-depending behavior here: for 
the first few years RISC-V only had 39-bit VAs, so the defato uABI ended 
up being that userspace can ignore way more bits.  While 48 bits might 
be enough for everyone, 39 doesn't seem to be -- or at least IIRC when 
we tried restricting the default to that, we broke stuff.  There's also 
some other wrinkles like arbitrary bit boundaries in pointer masking and 
vendor-specific paging formats, but at some point we just end up down a 
rabbit hole of insanity there...

FWIW, I think that userspace depending on just tossing some VA bits 
because some kernels happened to never allocate from them is just 
broken, but it seems like other ports worked around the 48->57 bit 
transition and we're trying to do something similar for 39->48 (and that 
works with 49->57, as we'll have to deal with that eventually).

So that's basically how we ended up with this sort of thing: trying to 
do something similar without a flag broke userspace because we were 
trying to jam too much into the hints.  I couldn't really figure out a 
way to satisfy all the userspace constraints by just implicitly 
retrofitting behavior based on the hints, so we figured having an 
explicit flag to control the behavior would be the sanest way to go.

That said: I'm not opposed to just saying "depending on 39-bit VAs is 
broken" and just forcing people to fix it.

>> This flag will also allow seemless compatibility between all
>> architectures, so applications like Go and OpenJDK that use bits in a
>> virtual address can request the exact number of bits they need in a
>> generic way. The flag can be checked inside of vm_unmapped_area() so
>> that this flag does not have to be handled individually by each
>> architecture.
>>
>> Link:
>> https://github.com/openjdk/jdk/blob/f080b4bb8a75284db1b6037f8c00ef3b1ef1add1/src/hotspot/cpu/riscv/vm_version_riscv.cpp#L79
>> [1]
>> Link:
>> https://github.com/golang/go/blob/9e8ea567c838574a0f14538c0bbbd83c3215aa55/src/runtime/tagptr_64bit.go#L47
>> [2]
>>
>> To: Arnd Bergmann <arnd@arndb.de>
>> To: Richard Henderson <richard.henderson@linaro.org>
>> To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>> To: Matt Turner <mattst88@gmail.com>
>> To: Vineet Gupta <vgupta@kernel.org>
>> To: Russell King <linux@armlinux.org.uk>
>> To: Guo Ren <guoren@kernel.org>
>> To: Huacai Chen <chenhuacai@kernel.org>
>> To: WANG Xuerui <kernel@xen0n.name>
>> To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
>> To: Helge Deller <deller@gmx.de>
>> To: Michael Ellerman <mpe@ellerman.id.au>
>> To: Nicholas Piggin <npiggin@gmail.com>
>> To: Christophe Leroy <christophe.leroy@csgroup.eu>
>> To: Naveen N Rao <naveen@kernel.org>
>> To: Alexander Gordeev <agordeev@linux.ibm.com>
>> To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>> To: Heiko Carstens <hca@linux.ibm.com>
>> To: Vasily Gorbik <gor@linux.ibm.com>
>> To: Christian Borntraeger <borntraeger@linux.ibm.com>
>> To: Sven Schnelle <svens@linux.ibm.com>
>> To: Yoshinori Sato <ysato@users.sourceforge.jp>
>> To: Rich Felker <dalias@libc.org>
>> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> To: David S. Miller <davem@davemloft.net>
>> To: Andreas Larsson <andreas@gaisler.com>
>> To: Thomas Gleixner <tglx@linutronix.de>
>> To: Ingo Molnar <mingo@redhat.com>
>> To: Borislav Petkov <bp@alien8.de>
>> To: Dave Hansen <dave.hansen@linux.intel.com>
>> To: x86@kernel.org
>> To: H. Peter Anvin <hpa@zytor.com>
>> To: Andy Lutomirski <luto@kernel.org>
>> To: Peter Zijlstra <peterz@infradead.org>
>> To: Muchun Song <muchun.song@linux.dev>
>> To: Andrew Morton <akpm@linux-foundation.org>
>> To: Liam R. Howlett <Liam.Howlett@oracle.com>
>> To: Vlastimil Babka <vbabka@suse.cz>
>> To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> To: Shuah Khan <shuah@kernel.org>
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-alpha@vger.kernel.org
>> Cc: linux-snps-arc@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-csky@vger.kernel.org
>> Cc: loongarch@lists.linux.dev
>> Cc: linux-mips@vger.kernel.org
>> Cc: linux-parisc@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-sh@vger.kernel.org
>> Cc: sparclinux@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>
>> Changes in v2:
>> - Added much greater detail to cover letter
>> - Removed all code that touched architecture specific code and was able
>>   to factor this out into all generic functions, except for flags that
>>   needed to be added to vm_unmapped_area_info
>> - Made this an RFC since I have only tested it on riscv and x86
>> - Link to v1: https://lore.kernel.org/r/20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com
>>
>> ---
>> Charlie Jenkins (4):
>>       mm: Add MAP_BELOW_HINT
>>       mm: Add hint and mmap_flags to struct vm_unmapped_area_info
>>       mm: Support MAP_BELOW_HINT in vm_unmapped_area()
>>       selftests/mm: Create MAP_BELOW_HINT test
>>
>>  arch/alpha/kernel/osf_sys.c                  |  2 ++
>>  arch/arc/mm/mmap.c                           |  3 +++
>>  arch/arm/mm/mmap.c                           |  7 ++++++
>>  arch/csky/abiv1/mmap.c                       |  3 +++
>>  arch/loongarch/mm/mmap.c                     |  3 +++
>>  arch/mips/mm/mmap.c                          |  3 +++
>>  arch/parisc/kernel/sys_parisc.c              |  3 +++
>>  arch/powerpc/mm/book3s64/slice.c             |  7 ++++++
>>  arch/s390/mm/hugetlbpage.c                   |  4 ++++
>>  arch/s390/mm/mmap.c                          |  6 ++++++
>>  arch/sh/mm/mmap.c                            |  6 ++++++
>>  arch/sparc/kernel/sys_sparc_32.c             |  3 +++
>>  arch/sparc/kernel/sys_sparc_64.c             |  6 ++++++
>>  arch/sparc/mm/hugetlbpage.c                  |  4 ++++
>>  arch/x86/kernel/sys_x86_64.c                 |  6 ++++++
>>  arch/x86/mm/hugetlbpage.c                    |  4 ++++
>>  fs/hugetlbfs/inode.c                         |  4 ++++
>>  include/linux/mm.h                           |  2 ++
>>  include/uapi/asm-generic/mman-common.h       |  1 +
>>  mm/mmap.c                                    |  9 ++++++++
>>  tools/include/uapi/asm-generic/mman-common.h |  1 +
>>  tools/testing/selftests/mm/Makefile          |  1 +
>>  tools/testing/selftests/mm/map_below_hint.c  | 32 ++++++++++++++++++++++++++++
>>  23 files changed, 120 insertions(+)
>> ---
>> base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
>> change-id: 20240827-patches-below_hint_mmap-b13d79ae1c55

