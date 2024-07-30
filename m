Return-Path: <linux-arch+bounces-5699-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC3940889
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 08:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D701282027
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jul 2024 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7116C877;
	Tue, 30 Jul 2024 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odNyHSwO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F62563;
	Tue, 30 Jul 2024 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321766; cv=none; b=sCmKX56khpAIFVt9kq+6STsLRLyjsoQGPuKNKzsq0IhFsj5Itt/lMM/asCbCN6ZKyYYvC+SjYh3uowA1i+ojnLEWP4zIT04B1pcSycLWftzc+M6EzlNAjgV+VGDW81/6V62DvvDpDxX8aO3WMaJElymCXFvo41xqrOLuYgfKqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321766; c=relaxed/simple;
	bh=9fMo0SqZ7mOf+MpuDKzR6wBE4n9v1usaMOUOV+GRiz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIuB1fdosAG5jpKQbQqNLIO1sLBhaS/dYfiDHW76mu2IHyyeLV1RC/ate5ei5a+VDVNlKmSX5tywcSPeetSAj1ChvrAds+R5kT80qZGydk8yLpSbcK/F9P+iRhIQU9hUIIQ8QZuqsi0AiEzZYxxkcBMs2Zpjuzq5vM8YAgp3Vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odNyHSwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B562C32782;
	Tue, 30 Jul 2024 06:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722321766;
	bh=9fMo0SqZ7mOf+MpuDKzR6wBE4n9v1usaMOUOV+GRiz8=;
	h=From:To:Cc:Subject:Date:From;
	b=odNyHSwOlBtV2oqVtExlin1GDO7kYlIOx8pVUXrIJUKZbGYwA4WqDas0/GxrcEr55
	 U96WNS8VFoK93eKlrMoYeKy3Hx5hYk7u0MHfPCvnoc4pMqeCyLihL2sOgCRB2BK0LQ
	 L8992A0T1NOO7inaUSioa2w4g0sAStq/hkXExqTSsAXodpT6mGb0xRWKuDd+nH2N+A
	 BTsDqxMoTTjSETReBcCKjEeWWC7pCscYpqZJszwilu2vcMmxr/pCQlNwRRubPXHBaB
	 JADt14YJLrGWRmg/Gsmy3mjRBjVlp6DBpI92v1G7zStat5RwD14Iv/xZapDPo4c7xq
	 lwWpWj2GOPung==
From: alexs@kernel.org
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Brian Cain <bcain@quicinc.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Vishal Moola <vishal.moola@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lance Yang <ioworker0@gmail.com>,
	Peter Xu <peterx@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-s390@vger.kernel.org
Cc: Guo Ren <guoren@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alex Shi <alexs@kernel.org>
Subject: [RFC PATCH 00/18] use struct ptdesc to replace pgtable_t 
Date: Tue, 30 Jul 2024 14:46:54 +0800
Message-ID: <20240730064712.3714387-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

We have struct ptdesc for page table descriptor a year ago, but it
has no much usages in kernel, while pgtable_t is used widely.

The pgtable_t is typedefed as 'pte_t *' in sparc, s390, powerpc and m68k
except SUN3, others archs are all same as 'struct page *'.

These blocks the conception and code update for page table descriptor to
struct ptdesc.

So, the simple idea to push the ptdesc conception forward is to update
all pgtable_t by ptdesc or pte_t pointer. But this needs widely
knowledges for most all of different archs. Common code change is easy
for include/ and mm/ directory, but it's hard in all archs.

Thanks for intel LKP framework, I fixed most all of build issues except
a bug on powerpc which reports a "struct ptdesc *" incompatible with 
struct ptdesc *' pointer issue...

Another trouble is pmd_pgtable() conversion in the last patch.
Maybe some of arch need define theirself own pmd_ptdesc()?

This patchset is immature, even except above 2 issues, I just tested
virutal machine booting and kselftest mm on x86 and arm64.

Anyway any input are appreciated!

Thanks
Alex

Alex Shi (18):
  mm/pgtable: use ptdesc in pte_free_now/pte_free_defer
  mm/pgtable: convert ptdesc.pmd_huge_pte to ptdesc pointer
  fs/dax: use ptdesc in dax_pmd_load_hole
  mm/thp: use ptdesc pointer in __do_huge_pmd_anonymous_page
  mm/thp: use ptdesc in do_huge_pmd_anonymous_page
  mm/thp: convert insert_pfn_pmd and its caller to use ptdesc
  mm/thp: use ptdesc in copy_huge_pmd
  mm/memory: use ptdesc in __pte_alloc
  mm/pgtable: fully use ptdesc in pte_alloc_one series functions
  mm/pgtable: pass ptdesc to pte_free()
  mm/pgtable: introduce ptdesc_pfn and use ptdesc in free_pte_range()
  mm/thp: pass ptdesc to set_huge_zero_folio function
  mm/pgtable: return ptdesc pointer in pgtable_trans_huge_withdraw
  mm/pgtable: use ptdesc in pgtable_trans_huge_deposit
  mm/pgtable: pass ptdesc to pmd_populate
  mm/pgtable: pass ptdesc to pmd_install
  mm: convert vmf.prealloc_pte to struct ptdesc pointer
  mm/pgtable: pass ptdesc in pte_free_defer

 arch/alpha/include/asm/pgalloc.h              |   4 +-
 arch/arc/include/asm/pgalloc.h                |   4 +-
 arch/arm/include/asm/pgalloc.h                |  13 +--
 arch/arm/include/asm/tlb.h                    |   4 +-
 arch/arm/mm/pgd.c                             |   2 +-
 arch/arm64/include/asm/pgalloc.h              |   4 +-
 arch/arm64/include/asm/tlb.h                  |   4 +-
 arch/csky/include/asm/pgalloc.h               |   4 +-
 arch/hexagon/include/asm/pgalloc.h            |   8 +-
 arch/loongarch/include/asm/pgalloc.h          |   8 +-
 arch/m68k/include/asm/motorola_pgalloc.h      |  12 +-
 arch/m68k/include/asm/sun3_pgalloc.h          |   4 +-
 arch/microblaze/include/asm/pgalloc.h         |   2 +-
 arch/mips/include/asm/pgalloc.h               |   4 +-
 arch/nios2/include/asm/pgalloc.h              |   4 +-
 arch/openrisc/include/asm/pgalloc.h           |   8 +-
 arch/parisc/include/asm/pgalloc.h             |   2 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h  |   4 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   4 +-
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   4 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h  |   4 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   8 +-
 arch/powerpc/include/asm/book3s/64/radix.h    |   4 +-
 arch/powerpc/include/asm/pgalloc.h            |   8 +-
 arch/powerpc/mm/book3s64/hash_pgtable.c       |  10 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c      |  10 +-
 arch/riscv/include/asm/pgalloc.h              |   8 +-
 arch/s390/include/asm/pgalloc.h               |   4 +-
 arch/s390/include/asm/pgtable.h               |   4 +-
 arch/s390/mm/pgalloc.c                        |   2 +-
 arch/s390/mm/pgtable.c                        |  14 +--
 arch/sh/include/asm/pgalloc.h                 |   4 +-
 arch/sparc/include/asm/pgalloc_32.h           |   6 +-
 arch/sparc/include/asm/pgalloc_64.h           |   2 +-
 arch/sparc/include/asm/pgtable_64.h           |   4 +-
 arch/sparc/mm/init_64.c                       |   2 +-
 arch/sparc/mm/srmmu.c                         |   6 +-
 arch/sparc/mm/tlb.c                           |  14 +--
 arch/x86/include/asm/pgalloc.h                |  10 +-
 arch/x86/mm/pgtable.c                         |   8 +-
 arch/xtensa/include/asm/pgalloc.h             |  12 +-
 fs/dax.c                                      |  14 +--
 include/asm-generic/pgalloc.h                 |  10 +-
 include/linux/mm.h                            |  16 ++-
 include/linux/mm_types.h                      |   4 +-
 include/linux/pgtable.h                       |   6 +-
 mm/debug_vm_pgtable.c                         |   6 +-
 mm/huge_memory.c                              | 103 +++++++++---------
 mm/internal.h                                 |   2 +-
 mm/khugepaged.c                               |  14 +--
 mm/memory.c                                   |  15 +--
 mm/mremap.c                                   |   2 +-
 mm/pgtable-generic.c                          |  37 +++----
 53 files changed, 240 insertions(+), 236 deletions(-)

-- 
2.43.0


