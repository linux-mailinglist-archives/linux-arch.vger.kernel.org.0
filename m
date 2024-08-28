Return-Path: <linux-arch+bounces-6685-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B0D961E65
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 07:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFAD6B21B0F
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2024 05:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0CD152517;
	Wed, 28 Aug 2024 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vF3w+o6O"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE7152DE7
	for <linux-arch@vger.kernel.org>; Wed, 28 Aug 2024 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824169; cv=none; b=n7IjYJIlj3vvBQ3w+YB6XFo5Clmr0A1PEuOK/Nupqz6uCrmqamN0qwrraIohTOVLwnj2o2j0+rwdxU6g4VMrfHIuHjaXx2wgNdM65XsXatj2+xExds4dJlJ2VDgm62GOK7sM44l99WYbwbSYzSUOpDt1Cd3gZoo/8yyB7rgwNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824169; c=relaxed/simple;
	bh=rybnxgXRfasNksP5lSU1TnJeqx+66siNWRNOd7Jshtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NFGiAb8t+0o6lS5AMQnnwde5adN1EYcPYSZCSU+tXXRmatXeFxyan5FlHJ681EUFLJ+zMzgq/GzMHe82nuelwSFcGG+97Txg93Ycd+zpt8Vd7X/147Wwo0xR+WmhNM125DZ0gd+4vJLZKU40F1eh9/VRQbxUPxvkdc9S77icrUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vF3w+o6O; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3802431a12.2
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 22:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724824166; x=1725428966; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IUFbDMgjzsoT48Z/N2yqe2kry93QHxmitnGNSfp0h7M=;
        b=vF3w+o6Odu3T14/pBPR1SeJWm47kCx1KEAjnK21qoyKZWR5oMc72jg2zoWzghc6Xez
         bLXe6vMQfcipJcWmB9Zm4UyQxDN6/wcuSv0Wy2yhEf50gqOzJ37hbQ0mApG1ffNoF3SL
         +IyV22aNFlOHUSpGx/JWaWTXVpXvVhzZ87kWFYEDfUSKcxkPvsGXXufwtNsoP+D+9dcn
         fZ6IsLy+dtelTu3Ok9eQy2yalUvwZ1kX92iwdULEpnK3qvCUoIWw68UUOcCp3mAg2iEX
         cfiqSSfThXuKutVUiTH1PQ3c9vAzcoIQ2EeKAuM2cNPg8q68H1w4ol+Nmrd+kb47hQkh
         gw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724824166; x=1725428966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUFbDMgjzsoT48Z/N2yqe2kry93QHxmitnGNSfp0h7M=;
        b=aSWSIxF7nc6udw7eFEP6tuyAJ/DTduiJgTq2V571pRgPTvb/4SUYoATydCxUkMeSsa
         gqv3sJ/0X+M6mGIIIX/6udR1MDCKCWxl6dYB9py0JmmPiR6iQqJz2i8KyPLT/Ag84HV0
         HdEswH32wHESSANhxZBp18z4stxkX+ygfIX9ZqbuQMlOOCYH087djiqoFoP45AE0ZWgh
         OjI5Lg0ZnOENBPXOo850Spkq6g2NnpWgNpV1f06SwaSYsIZuW1CSRhVLqE07/ZhgXIIF
         3Y1bOCAeLFqOqMJp2dcJEZzktwrhCe4fp6Wxtld2Cj8iqdtESodRpKYGBD5tIAclYS9Q
         4sbw==
X-Gm-Message-State: AOJu0Yzh938qRsqPnVtk0rLruEJhlSzYrxhuEczy54ANFUcYsXysbyHy
	yb8wP0Jh6Av11DjWHt8sKW/ulCLmr+Sp42E1rSVhCr9hyl+lKxYUewTPhFiwDQ0=
X-Google-Smtp-Source: AGHT+IF6T5IRS6PI9ffePkiTGEXwg74qwFWRmO3+h509ZqjZl31p2gGXC6rr0MOwZENhtWiyWe3S3w==
X-Received: by 2002:a05:6a21:78e:b0:1c0:eba5:e192 with SMTP id adf61e73a8af0-1cc8b49d8abmr14865175637.27.1724824165540;
        Tue, 27 Aug 2024 22:49:25 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df0c4sm92092495ad.157.2024.08.27.22.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 22:49:24 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 00/16] mm: Introduce MAP_BELOW_HINT
Date: Tue, 27 Aug 2024 22:49:06 -0700
Message-Id: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFK6zmYC/x3MTQqAIBBA4avErBPSkn6uEhFmUw6UiUYF4d2Tl
 t/ivRcCesIAXfaCx4sCHTaB5xloo+yKjOZkEIWoikbUzKlTGwxswu24R0P2HPddOTbxcq5bhVx
 LCal2Hhd6/nM/xPgBQKT3MGkAAAA=
To: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Shuah Khan <shuah@kernel.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-mm@kvack.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6044; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=rybnxgXRfasNksP5lSU1TnJeqx+66siNWRNOd7Jshtg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ9q5XSH3lM7XXzj5QFjW4OtX+60nZ+rMb1N2D9F5e2t+8
 tuSp8uiOkpZGMQ4GGTFFFl4rjUwt97RLzsqWjYBZg4rE8gQBi5OAZjIkUMMf8WSWp0unDgcOEl5
 8kUJVXP5KYyTLI0KMiNvKmnOTI5taWBk2Cj+dkXn/qc3T0v2+U/SXhD+ZpOA/e/6H56BP2LNukr
 5GQE=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Some applications rely on placing data in free bits addresses allocated
by mmap. Various architectures (eg. x86, arm64, powerpc) restrict the
address returned by mmap to be less than the maximum address space,
unless the hint address is greater than this value.

On arm64 this barrier is at 52 bits and on x86 it is at 56 bits. This
flag allows applications a way to specify exactly how many bits they
want to be left unused by mmap. This eliminates the need for
applications to know the page table hierarchy of the system to be able
to reason which addresses mmap will be allowed to return.

---
riscv made this feature of mmap returning addresses less than the hint
address the default behavior. This was in contrast to the implementation
of x86/arm64 that have a single boundary at the 5-level page table
region. However this restriction proved too great -- the reduced
address space when using a hint address was too small.

A patch for riscv [1] reverts the behavior that broke userspace. This
series serves to make this feature available to all architectures.

I have only tested on riscv and x86. There is a tremendous amount of
duplicated code in mmap so the implementations across architectures I
believe should be mostly consistent. I added this feature to all
architectures that implement either
arch_get_mmap_end()/arch_get_mmap_base() or
arch_get_unmapped_area_topdown()/arch_get_unmapped_area(). I also added
it to the default behavior for arch_get_mmap_end()/arch_get_mmap_base().

Link: https://lore.kernel.org/lkml/20240826-riscv_mmap-v1-2-cd8962afe47f@rivosinc.com/T/ [1]

To: Arnd Bergmann <arnd@arndb.de>
To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Naveen N Rao <naveen@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
To: Liam R. Howlett <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Huacai Chen <chenhuacai@kernel.org>
To: WANG Xuerui <kernel@xen0n.name>
To: Russell King <linux@armlinux.org.uk>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
To: Helge Deller <deller@gmx.de>
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
To: Shuah Khan <shuah@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

---
Charlie Jenkins (16):
      mm: Add MAP_BELOW_HINT
      riscv: mm: Do not restrict mmap address based on hint
      mm: Add flag and len param to arch_get_mmap_base()
      mm: Add generic MAP_BELOW_HINT
      riscv: mm: Support MAP_BELOW_HINT
      arm64: mm: Support MAP_BELOW_HINT
      powerpc: mm: Support MAP_BELOW_HINT
      x86: mm: Support MAP_BELOW_HINT
      loongarch: mm: Support MAP_BELOW_HINT
      arm: mm: Support MAP_BELOW_HINT
      mips: mm: Support MAP_BELOW_HINT
      parisc: mm: Support MAP_BELOW_HINT
      s390: mm: Support MAP_BELOW_HINT
      sh: mm: Support MAP_BELOW_HINT
      sparc: mm: Support MAP_BELOW_HINT
      selftests/mm: Create MAP_BELOW_HINT test

 arch/arm/mm/mmap.c                           | 10 ++++++++
 arch/arm64/include/asm/processor.h           | 34 ++++++++++++++++++++++----
 arch/loongarch/mm/mmap.c                     | 11 +++++++++
 arch/mips/mm/mmap.c                          |  9 +++++++
 arch/parisc/include/uapi/asm/mman.h          |  1 +
 arch/parisc/kernel/sys_parisc.c              |  9 +++++++
 arch/powerpc/include/asm/task_size_64.h      | 36 +++++++++++++++++++++++-----
 arch/riscv/include/asm/processor.h           | 32 -------------------------
 arch/s390/mm/mmap.c                          | 10 ++++++++
 arch/sh/mm/mmap.c                            | 10 ++++++++
 arch/sparc/kernel/sys_sparc_64.c             |  8 +++++++
 arch/x86/kernel/sys_x86_64.c                 | 25 ++++++++++++++++---
 fs/hugetlbfs/inode.c                         |  2 +-
 include/linux/sched/mm.h                     | 34 ++++++++++++++++++++++++--
 include/uapi/asm-generic/mman-common.h       |  1 +
 mm/mmap.c                                    |  2 +-
 tools/arch/parisc/include/uapi/asm/mman.h    |  1 +
 tools/include/uapi/asm-generic/mman-common.h |  1 +
 tools/testing/selftests/mm/Makefile          |  1 +
 tools/testing/selftests/mm/map_below_hint.c  | 29 ++++++++++++++++++++++
 20 files changed, 216 insertions(+), 50 deletions(-)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240827-patches-below_hint_mmap-b13d79ae1c55
-- 
- Charlie


