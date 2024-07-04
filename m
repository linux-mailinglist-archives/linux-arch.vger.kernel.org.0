Return-Path: <linux-arch+bounces-5245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E6926E19
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 05:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50B3F1C2156C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 03:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91045182B2;
	Thu,  4 Jul 2024 03:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4BXizSo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112318EA1;
	Thu,  4 Jul 2024 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064357; cv=none; b=CJh/tZaiD5ZbiGYRBM28wYxGwn1yAuFyM6X7JHifGIKrKqYIFF1YwDFZxuNPKPJFw7uRWxF6J04/x1E8BYwD/KtIqccHYK2BCOUhQT29zNd08YoRrv10T9jiEn+vLzNBpJnUn64snZGekU0Gh9GeGR6EDLYgxK8AgHaanHB4rFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064357; c=relaxed/simple;
	bh=rSZWX0gWlKWv/j9j9F4F3Urou4mvlKJB7ifrwMMcz9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cne9b8OyEllpXW+8Ev/Q+cAOLPkRuvQQJ0mjkfd1wwg8I8fUFobqq0RmWy+dbxT1szCOnLhPJf8rUO3sfEjOnQSR5tF1Xx/nPB2dSUoZk5GsQVCZyBQi17TAigZuXE0imiQ4kStE2iRRZZDWfIsktaINrTyBPNAXYjS0/VWSs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4BXizSo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720064356; x=1751600356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rSZWX0gWlKWv/j9j9F4F3Urou4mvlKJB7ifrwMMcz9w=;
  b=W4BXizSoHL11aIoePohIIHqf8ZgRAdxO+hVY1eAuyouHflmVTkunHGzW
   3TaQj1uPnC9n5MXRlqDTGdjH2keXrkazN/8Cgu1pTZ0sPP9a78nHjC7Mt
   hQ/dkWlvMUsC5z46o+KCEiXJG0EM4UPDKnciic/2AYm5hZcgUIOFZ6Msq
   iZiTFADZL339+3XNycYv5T666thfDFk3ZSawx4slrtp9/yMe1ZQJ5HvB0
   ggYafH1BRM+jp1ldvONfEghVMzfiYYUEQGf4UNmPkpyweVQ4nIgkPOwVN
   //cwQ+0CPozvolyfDqq1R1T6f4G5mpIhtXmuGwvygJY7fyVoHYNUmpjyI
   Q==;
X-CSE-ConnectionGUID: IUgjQt5JR1quZ4wsDaG4NA==
X-CSE-MsgGUID: gANbwQ6KSvK8QXg+nnyk2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="42745989"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="42745989"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 20:39:14 -0700
X-CSE-ConnectionGUID: KPbiy3BOTv2zmQuVt+flyA==
X-CSE-MsgGUID: cc6XAiE4SLqCt3rnpjN/aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46472076"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Jul 2024 20:39:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPDJL-000QVm-2I;
	Thu, 04 Jul 2024 03:39:07 +0000
Date: Thu, 4 Jul 2024 11:38:46 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <202407041157.odTZAYZ6-lkp@intel.com>
References: <20240626130347.520750-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626130347.520750-2-alexghiti@rivosinc.com>

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.10-rc6 next-20240703]
[cannot apply to arnd-asm-generic/master robh/for-next tip/locking/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Implement-cmpxchg32-64-using-Zacas/20240627-034946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240626130347.520750-2-alexghiti%40rivosinc.com
patch subject: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
config: riscv-randconfig-002-20240704 (https://download.01.org/0day-ci/archive/20240704/202407041157.odTZAYZ6-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041157.odTZAYZ6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/core.c:11873:7: error: cannot jump from this asm goto statement to one of its possible targets
                   if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
                       ^
   include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded from macro 'try_cmpxchg'
           raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
           ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
                  ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
   #define raw_cmpxchg arch_cmpxchg
                       ^
   arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'arch_cmpxchg'
           _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
           ^
   arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_arch_cmpxchg'
                   __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
                   ^
   arch/riscv/include/asm/cmpxchg.h:144:3: note: expanded from macro '__arch_cmpxchg'
                   asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,            \
                   ^
   kernel/sched/core.c:11840:7: note: possible target of asm goto statement
           if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
                ^
   include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded from macro 'try_cmpxchg'
           raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
           ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
                  ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
   #define raw_cmpxchg arch_cmpxchg
                       ^
   arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'arch_cmpxchg'
           _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
           ^
   arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_arch_cmpxchg'
                   __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
                   ^
   arch/riscv/include/asm/cmpxchg.h:161:10: note: expanded from macro '__arch_cmpxchg'
                                                                           \
                                                                           ^
   kernel/sched/core.c:11872:2: note: jump exits scope of variable with __attribute__((cleanup))
           scoped_guard (irqsave) {
           ^
   include/linux/cleanup.h:169:20: note: expanded from macro 'scoped_guard'
           for (CLASS(_name, scope)(args),                                 \
                             ^
   kernel/sched/core.c:11840:7: error: cannot jump from this asm goto statement to one of its possible targets
           if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
                ^
   include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded from macro 'try_cmpxchg'
           raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
           ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
                  ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
   #define raw_cmpxchg arch_cmpxchg
                       ^
   arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'arch_cmpxchg'
           _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
           ^
   arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_arch_cmpxchg'
                   __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
                   ^
   arch/riscv/include/asm/cmpxchg.h:144:3: note: expanded from macro '__arch_cmpxchg'
                   asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,            \
                   ^
   kernel/sched/core.c:11873:7: note: possible target of asm goto statement
                   if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
                       ^
   include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded from macro 'try_cmpxchg'
           raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
           ^
   include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
           ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
                  ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
   #define raw_cmpxchg arch_cmpxchg
                       ^
   arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'arch_cmpxchg'
           _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
           ^
   arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_arch_cmpxchg'
                   __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
                   ^
   arch/riscv/include/asm/cmpxchg.h:161:10: note: expanded from macro '__arch_cmpxchg'
                                                                           \
                                                                           ^
   kernel/sched/core.c:11872:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
           scoped_guard (irqsave) {
           ^
   include/linux/cleanup.h:169:20: note: expanded from macro 'scoped_guard'
           for (CLASS(_name, scope)(args),                                 \
                             ^
   2 errors generated.


vim +11873 kernel/sched/core.c

223baf9d17f25e Mathieu Desnoyers 2023-04-20  11821  
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11822  static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_cid,
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11823  				      int cpu)
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11824  {
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11825  	struct rq *rq = cpu_rq(cpu);
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11826  	struct task_struct *t;
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11827  	int cid, lazy_cid;
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11828  
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11829  	cid = READ_ONCE(pcpu_cid->cid);
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11830  	if (!mm_cid_is_valid(cid))
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11831  		return;
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11832  
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11833  	/*
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11834  	 * Clear the cpu cid if it is set to keep cid allocation compact.  If
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11835  	 * there happens to be other tasks left on the source cpu using this
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11836  	 * mm, the next task using this mm will reallocate its cid on context
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11837  	 * switch.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11838  	 */
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11839  	lazy_cid = mm_cid_set_lazy_put(cid);
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11840  	if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11841  		return;
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11842  
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11843  	/*
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11844  	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11845  	 * rq->curr->mm matches the scheduler barrier in context_switch()
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11846  	 * between store to rq->curr and load of prev and next task's
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11847  	 * per-mm/cpu cid.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11848  	 *
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11849  	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11850  	 * rq->curr->mm_cid_active matches the barrier in
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11851  	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11852  	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11853  	 * load of per-mm/cpu cid.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11854  	 */
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11855  
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11856  	/*
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11857  	 * If we observe an active task using the mm on this rq after setting
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11858  	 * the lazy-put flag, that task will be responsible for transitioning
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11859  	 * from lazy-put flag set to MM_CID_UNSET.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11860  	 */
0e34600ac9317d Peter Zijlstra    2023-06-09  11861  	scoped_guard (rcu) {
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11862  		t = rcu_dereference(rq->curr);
0e34600ac9317d Peter Zijlstra    2023-06-09  11863  		if (READ_ONCE(t->mm_cid_active) && t->mm == mm)
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11864  			return;
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11865  	}
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11866  
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11867  	/*
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11868  	 * The cid is unused, so it can be unset.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11869  	 * Disable interrupts to keep the window of cid ownership without rq
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11870  	 * lock small.
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11871  	 */
0e34600ac9317d Peter Zijlstra    2023-06-09  11872  	scoped_guard (irqsave) {
223baf9d17f25e Mathieu Desnoyers 2023-04-20 @11873  		if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
223baf9d17f25e Mathieu Desnoyers 2023-04-20  11874  			__mm_cid_put(mm, cid);
0e34600ac9317d Peter Zijlstra    2023-06-09  11875  	}
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  11876  }
af7f588d8f7355 Mathieu Desnoyers 2022-11-22  11877  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

