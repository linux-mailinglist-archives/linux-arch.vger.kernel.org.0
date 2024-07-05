Return-Path: <linux-arch+bounces-5286-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B579928D08
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157FB2839EB
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 17:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873116A95C;
	Fri,  5 Jul 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+GP2NpY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4881E;
	Fri,  5 Jul 2024 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720200473; cv=none; b=jQ36da4Zvzcya1ZCH9R6IFzWW1FBrHCMQ6Lk9BBEs0DXX/7Goqu06h5509O1REWw9f0apq++C5mKxCl1hnpc+J1oTeY7yG7WyOhqBkYEdh0xf+qoy3lurd1n+oKvsyrMeShzaWXbLvTOmni9i9IlnJ2as9ZX6o9P7J/8v1pCHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720200473; c=relaxed/simple;
	bh=UFVPAqRzqVT/p6Fkd12jSpwFaK0O3pMzpk6h3778Y08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSkOQnOleMyADWofUhuEL1pGZSlo5RUckyXbd7fBIwyQMzrgjc2wd8xATdLfWyl7UIHIuXySE8jdLvKiBufTcNjRQM6AtomxUrRWBaW4lCgOarzGcv8aYaXr0hTzpPgsQgOf1YGgscvs6GK5C29SME+tSDlsFrHBaSJwLc8zrOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+GP2NpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC732C116B1;
	Fri,  5 Jul 2024 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720200473;
	bh=UFVPAqRzqVT/p6Fkd12jSpwFaK0O3pMzpk6h3778Y08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+GP2NpY0ut/WIX+ybo8MYYpHvTp8h6a8vetEwsE/CbsZlhV+S991AWIZQb+Jg+40
	 Xub3zFx2IpPojnRyBNL0MkZVtnDZt1V/zZhl2sEeONoOWw7jyoGc9lHYogye7A1WBo
	 AUHbhFUiJizR4/QRRv0a+vBtq65BJGzTWnCT2Szffa42qipZHQBkX0x4WA8bnciHcB
	 UPLGQqqHEWbqWMA7tm9Mn/iIcyaFG654UF2ohEHfnpUJ+60mEL8CkilSUEoc8wGBlu
	 bIOKp4D2LiBLowXpcxchn5BGGI1OhqAU8JU1YXF57oGQbB9lLjEY0fx8VJDrSuQL0R
	 KLTiruSZV+s+A==
Date: Fri, 5 Jul 2024 10:27:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <20240705172750.GF987634@thelio-3990X>
References: <20240626130347.520750-2-alexghiti@rivosinc.com>
 <202407041157.odTZAYZ6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407041157.odTZAYZ6-lkp@intel.com>

On Thu, Jul 04, 2024 at 11:38:46AM +0800, kernel test robot wrote:
> Hi Alexandre,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v6.10-rc6 next-20240703]
> [cannot apply to arnd-asm-generic/master robh/for-next tip/locking/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Implement-cmpxchg32-64-using-Zacas/20240627-034946
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> patch link:    https://lore.kernel.org/r/20240626130347.520750-2-alexghiti%40rivosinc.com
> patch subject: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
> config: riscv-randconfig-002-20240704 (https://download.01.org/0day-ci/archive/20240704/202407041157.odTZAYZ6-lkp@intel.com/config)
> compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240704/202407041157.odTZAYZ6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407041157.odTZAYZ6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/sched/core.c:11873:7: error: cannot jump from this asm goto statement to one of its possible targets
>                    if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
>                        ^
>    include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded from macro 'try_cmpxchg'
>            raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
>            ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>                   ^
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
>    #define raw_cmpxchg arch_cmpxchg
>                        ^
>    arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'arch_cmpxchg'
>            _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
>            ^
>    arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_arch_cmpxchg'
>                    __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
>                    ^
>    arch/riscv/include/asm/cmpxchg.h:144:3: note: expanded from macro '__arch_cmpxchg'
>                    asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,            \
>                    ^
>    kernel/sched/core.c:11840:7: note: possible target of asm goto statement
>            if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
>                 ^
>    include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded from macro 'try_cmpxchg'
>            raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
>            ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>                   ^
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
>    #define raw_cmpxchg arch_cmpxchg
>                        ^
>    arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'arch_cmpxchg'
>            _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
>            ^
>    arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_arch_cmpxchg'
>                    __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
>                    ^
>    arch/riscv/include/asm/cmpxchg.h:161:10: note: expanded from macro '__arch_cmpxchg'
>                                                                            \
>                                                                            ^
>    kernel/sched/core.c:11872:2: note: jump exits scope of variable with __attribute__((cleanup))
>            scoped_guard (irqsave) {
>            ^
>    include/linux/cleanup.h:169:20: note: expanded from macro 'scoped_guard'
>            for (CLASS(_name, scope)(args),                                 \
>                              ^
>    kernel/sched/core.c:11840:7: error: cannot jump from this asm goto statement to one of its possible targets
>            if (!try_cmpxchg(&pcpu_cid->cid, &cid, lazy_cid))
>                 ^
>    include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded from macro 'try_cmpxchg'
>            raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
>            ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>                   ^
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
>    #define raw_cmpxchg arch_cmpxchg
>                        ^
>    arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'arch_cmpxchg'
>            _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
>            ^
>    arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_arch_cmpxchg'
>                    __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
>                    ^
>    arch/riscv/include/asm/cmpxchg.h:144:3: note: expanded from macro '__arch_cmpxchg'
>                    asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,            \
>                    ^
>    kernel/sched/core.c:11873:7: note: possible target of asm goto statement
>                    if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
>                        ^
>    include/linux/atomic/atomic-instrumented.h:4880:2: note: expanded from macro 'try_cmpxchg'
>            raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
>            ^
>    include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
>            ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
>                   ^
>    include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
>    #define raw_cmpxchg arch_cmpxchg
>                        ^
>    arch/riscv/include/asm/cmpxchg.h:212:2: note: expanded from macro 'arch_cmpxchg'
>            _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
>            ^
>    arch/riscv/include/asm/cmpxchg.h:189:3: note: expanded from macro '_arch_cmpxchg'
>                    __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
>                    ^
>    arch/riscv/include/asm/cmpxchg.h:161:10: note: expanded from macro '__arch_cmpxchg'
>                                                                            \
>                                                                            ^
>    kernel/sched/core.c:11872:2: note: jump bypasses initialization of variable with __attribute__((cleanup))
>            scoped_guard (irqsave) {
>            ^
>    include/linux/cleanup.h:169:20: note: expanded from macro 'scoped_guard'
>            for (CLASS(_name, scope)(args),                                 \
>                              ^
>    2 errors generated.

Ugh, this is an unfortunate interaction with clang's jump scope analysis
and asm goto in LLVM releases prior to 17 :/

https://github.com/ClangBuiltLinux/linux/issues/1886#issuecomment-1645979992

Unfortunately, 'if (0)' does not prevent this (the analysis runs early
in the front end as far as I understand it), we would need to workaround
this with full preprocessor guards...

Another alternative would be to require LLVM 17+ for RISC-V, which may
not be the worst alternative, since I think most people doing serious
work with clang will probably be living close to tip of tree anyways
because of all the extension work that goes on upstream.

I am open to other thoughts though.

Cheers,
Nathan

