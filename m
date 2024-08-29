Return-Path: <linux-arch+bounces-6791-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FA3963C6D
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 09:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEC5283D13
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 07:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E9D185628;
	Thu, 29 Aug 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="q4RZcxgo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB439176233
	for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915777; cv=none; b=nTuFFqviH6VsoGDyx3KVMZxLZ+MFD4aMIUWo0WxQHdox71SC8buzLq8JVwotsGVS91vxQfgZ4nAAnooIGI/sX0VVZyiZBZIdCtGyBjxOv2mwtMg47KW080Ga2zd34CptKgL8FM9SBjY74ALRzE1TTa016l1QvfDIlAbx0GosG3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915777; c=relaxed/simple;
	bh=ge3WwvXZyWhWUVXepQG4dDA/ByeZCzK4otcQJ4z3f6Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aduY2IX6EaZES3Ha7+BU3FNGMtVv3Oh/d/A/fQF06hPFt9OIeAikOMIUTBYbVw/64enfzG4GC0WIY5Ylf0zzFjE3NCRzVk/Vi7GuY6jdv5UInvoA8+C6PMPUlJzOvB1G0Zb09v+LNmN1d26vXTiePpghaz2XQZ6Pob3J5ZVQ1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=q4RZcxgo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714114be925so254214b3a.2
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2024 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724915773; x=1725520573; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzAtIL6RDQhGfK05hmJR7MmcGIg9Atw6OyAgLvdRB8w=;
        b=q4RZcxgolHi7zNPZG7F9KT9yxVCaRkprX1FRJYUuJ07QBsQ/tbr/ErDMLFQV4rE3u0
         Nze8ofXW1CUuk9B6AcedQkslWhmttInjoR8pGBYh7NL6hvj7PLbjHabZXBmuOgiUDpfa
         z6df59hehO0roGsH+4BffFfsRenUVvsr2tkNtrz6HO3Q6XZSF0hI2wuiw2u1jZQMZkhV
         ZV9HQMlAw5Sk5mMRfQdrHF6v/Nmkh2plgaBO85bKx59ODkqQyj4i3Wk0W4RPWCCtv8Yc
         fF9zb/uoXIo19t6S47maxp3HLd2KxvcGqlOIQKULNguaLIQsnxtDEEAQmV9fYQExtXWR
         A6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724915773; x=1725520573;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzAtIL6RDQhGfK05hmJR7MmcGIg9Atw6OyAgLvdRB8w=;
        b=JQAJJToL0SnfdYfYJxGFhUOUuKT91u81/UlIqvt9bzFwGB3jFINHTRJBuwlJW++oIc
         DyXlCRs20y64kZtf00l77lwVNztWRa59ZUZyb0xoFqrWoZEz89MdHnGkpMcQoxfkHs51
         GZONZ7jAL2qVjH9YOCdjQa7aM10blesYh06yyOV34cNLadIGXhUQUueIEfMI16+b72NO
         JMuNPLkJjDDBPXc0Eu9VFe0P72jQ/ZOjhfPbMkswwnUBHW4/K03yTR57wg0yUNUceyGH
         WtcBhSjVCD1h/8TaDpRSOjyd/tocGKEbU8hGSkUhBVaYwCefgsLxW68YpCV7GQTJXTcH
         MOmw==
X-Gm-Message-State: AOJu0YwcN9Q9UG0FdeHyLSoDwfnc0GXal8PS8zhMxxJhK1BmyVdLrmwf
	1sG/iy2QR2DOi+UlBu5Ree7KX2ZL8xPEhAQTTRhp3k+EXtOrtwzrQushzJkQ+Kg=
X-Google-Smtp-Source: AGHT+IHrzBJ2Fgit9cV9vJs1usISWUDgya5+GeDNPqBqFu2p0vbtJbTyW9MLD5/YHjShE4BhfoWnAg==
X-Received: by 2002:a05:6a20:b728:b0:1cc:e5bc:37de with SMTP id adf61e73a8af0-1cce5bc3a28mr493971637.39.1724915773108;
        Thu, 29 Aug 2024 00:16:13 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9bef08sm581976a12.58.2024.08.29.00.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:16:12 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH RFC v2 0/4] mm: Introduce MAP_BELOW_HINT
Date: Thu, 29 Aug 2024 00:15:57 -0700
Message-Id: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC0g0GYC/4WNQQrCMBREr1L+2kgSW2tdCYIHcCulpOmv+WCSk
 pSolN7d0Au4fDPMmwUiBsII52KBgIkieZdB7grQRrknMhoyg+Sy5CdZs0nN2mBkPb78uzPk5s5
 aNbFeHIa6USh0VUFeTwFH+mzmB9xvV2hzaCjOPny3tyS26q84CcZZeRxHiX3DpRwugZKP5PRee
 wvtuq4/Hwm3e8YAAAA=
To: Arnd Bergmann <arnd@arndb.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
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
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6188; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ge3WwvXZyWhWUVXepQG4dDA/ByeZCzK4otcQJ4z3f6Q=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9oFBQOjmt83Ze5+Y5jJwf/h4bocwxO7Tt0q2Kl8lUP5K
 V9S/v9ZHaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEyk3oORoS/Re2N8R6fkDV2R
 mFveRs1dnurLCyI0LhvtFJlbWLXDnuG/J6uoq83X57P4m4ztnkiJ+tQFH1Eo3Fff8GpduMeUgAR
 mAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Some applications rely on placing data in free bits addresses allocated
by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
address returned by mmap to be less than the 48-bit address space,
unless the hint address uses more than 47 bits (the 48th bit is reserved
for the kernel address space).

The riscv architecture needs a way to similarly restrict the virtual
address space. On the riscv port of OpenJDK an error is thrown if
attempted to run on the 57-bit address space, called sv57 [1].  golang
has a comment that sv57 support is not complete, but there are some
workarounds to get it to mostly work [2].

These applications work on x86 because x86 does an implicit 47-bit
restriction of mmap() address that contain a hint address that is less
than 48 bits.

Instead of implicitly restricting the address space on riscv (or any
current/future architecture), a flag would allow users to opt-in to this
behavior rather than opt-out as is done on other architectures. This is
desirable because it is a small class of applications that do pointer
masking.

This flag will also allow seemless compatibility between all
architectures, so applications like Go and OpenJDK that use bits in a
virtual address can request the exact number of bits they need in a
generic way. The flag can be checked inside of vm_unmapped_area() so
that this flag does not have to be handled individually by each
architecture. 

Link:
https://github.com/openjdk/jdk/blob/f080b4bb8a75284db1b6037f8c00ef3b1ef1add1/src/hotspot/cpu/riscv/vm_version_riscv.cpp#L79
[1]
Link:
https://github.com/golang/go/blob/9e8ea567c838574a0f14538c0bbbd83c3215aa55/src/runtime/tagptr_64bit.go#L47
[2]

To: Arnd Bergmann <arnd@arndb.de>
To: Richard Henderson <richard.henderson@linaro.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matt Turner <mattst88@gmail.com>
To: Vineet Gupta <vgupta@kernel.org>
To: Russell King <linux@armlinux.org.uk>
To: Guo Ren <guoren@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
To: WANG Xuerui <kernel@xen0n.name>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
To: Helge Deller <deller@gmx.de>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Naveen N Rao <naveen@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: David S. Miller <davem@davemloft.net>
To: Andreas Larsson <andreas@gaisler.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Andy Lutomirski <luto@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Muchun Song <muchun.song@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
To: Liam R. Howlett <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Changes in v2:
- Added much greater detail to cover letter
- Removed all code that touched architecture specific code and was able
  to factor this out into all generic functions, except for flags that
  needed to be added to vm_unmapped_area_info
- Made this an RFC since I have only tested it on riscv and x86
- Link to v1: https://lore.kernel.org/r/20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com

---
Charlie Jenkins (4):
      mm: Add MAP_BELOW_HINT
      mm: Add hint and mmap_flags to struct vm_unmapped_area_info
      mm: Support MAP_BELOW_HINT in vm_unmapped_area()
      selftests/mm: Create MAP_BELOW_HINT test

 arch/alpha/kernel/osf_sys.c                  |  2 ++
 arch/arc/mm/mmap.c                           |  3 +++
 arch/arm/mm/mmap.c                           |  7 ++++++
 arch/csky/abiv1/mmap.c                       |  3 +++
 arch/loongarch/mm/mmap.c                     |  3 +++
 arch/mips/mm/mmap.c                          |  3 +++
 arch/parisc/kernel/sys_parisc.c              |  3 +++
 arch/powerpc/mm/book3s64/slice.c             |  7 ++++++
 arch/s390/mm/hugetlbpage.c                   |  4 ++++
 arch/s390/mm/mmap.c                          |  6 ++++++
 arch/sh/mm/mmap.c                            |  6 ++++++
 arch/sparc/kernel/sys_sparc_32.c             |  3 +++
 arch/sparc/kernel/sys_sparc_64.c             |  6 ++++++
 arch/sparc/mm/hugetlbpage.c                  |  4 ++++
 arch/x86/kernel/sys_x86_64.c                 |  6 ++++++
 arch/x86/mm/hugetlbpage.c                    |  4 ++++
 fs/hugetlbfs/inode.c                         |  4 ++++
 include/linux/mm.h                           |  2 ++
 include/uapi/asm-generic/mman-common.h       |  1 +
 mm/mmap.c                                    |  9 ++++++++
 tools/include/uapi/asm-generic/mman-common.h |  1 +
 tools/testing/selftests/mm/Makefile          |  1 +
 tools/testing/selftests/mm/map_below_hint.c  | 32 ++++++++++++++++++++++++++++
 23 files changed, 120 insertions(+)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240827-patches-below_hint_mmap-b13d79ae1c55
-- 
- Charlie


