Return-Path: <linux-arch+bounces-13154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B95B2420F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C807C5637E4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 06:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9438A2D29DF;
	Wed, 13 Aug 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FU88SFlr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76C02737E6;
	Wed, 13 Aug 2025 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068201; cv=none; b=G9B5+Y4aa0HTkMJXtFIQr2uHC4DrtcVwHTdjW058qv5S5xckD97Eg88Ve0MM/P3Hjeq4si6Swf+4jxvQM+nLs6PLn976/XSwHeOvvBVwLiKTAYUrveyOQPYvUd+TAAh3o/obFz9fhoHKSJV8HLJL7Jcfdw26Pzo8Y5Tq15/oYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068201; c=relaxed/simple;
	bh=2b1COblDpAIUuYejzeV5esO2WB8etW2fL7OBAJ4d5UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIC0qQGcFL3GKyW4eV0tdxF1b04OfuAq7ynuTrxAs7WHzoWywjWkbDRh8GlhIVM73o68U6425D/4lP0au2rmKE8Ua7JV5qsO6iuG2AoFXIQDhwXOj8JDsyII+zYh+g9Znh360Pl/ZPtO0EZkdOoXPSeBTEVVkYo/sxuTOedmLoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FU88SFlr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755068200; x=1786604200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2b1COblDpAIUuYejzeV5esO2WB8etW2fL7OBAJ4d5UU=;
  b=FU88SFlrOjTwOT5dnRqOAWHecRYQ59ZpvBEoUyCLRMJqzeZWIxPnhouG
   Yhcamd0LbT4UGEspFRmOmgkvumHAecHxO8nsEz55hTP9weE0RA4lLV0x1
   2HNCKTa6ck95QVhw0WK6zJEto13KS4ys2PSac8F6fGfE1tLSm5wrezV3D
   mIbqWXLFdv9/PtAmovY3N5whYipkTnm1bjcbJVZoCsEFb2iDeJhGXIsHV
   6B/36jQ32vsb2ZJhG0PCFVCfXOQ3vOvD16wQM0hYz6OgBthmszHhbv05E
   cawz5uImnd2XFOZu9imzKWB1pjUvGdg0hoLeiBmgMPO+3eXWAdj77mmvi
   Q==;
X-CSE-ConnectionGUID: XH6TIKq6StGvj+VNQNBIqg==
X-CSE-MsgGUID: TDNfqsqAT5+ZmoW4T/3xMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56563433"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="56563433"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 23:56:39 -0700
X-CSE-ConnectionGUID: 4Be4PehFTYqPSTxVpOFDGg==
X-CSE-MsgGUID: W0wSj/oQRMODQtEyk6Xq7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165616782"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 12 Aug 2025 23:56:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1um5PV-0009dE-0P;
	Wed, 13 Aug 2025 06:56:33 +0000
Date: Wed, 13 Aug 2025 14:56:13 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
	Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Remove pud_user() from asm-generic/pgtable-nopmd.h
Message-ID: <202508131402.ZaPLdNsY-lkp@intel.com>
References: <c7f99612ecfa04054b37518df661d04f88f7c9af.1754997083.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f99612ecfa04054b37518df661d04f88f7c9af.1754997083.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/mm-Remove-pud_user-from-asm-generic-pgtable-nopmd-h/20250812-195212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/c7f99612ecfa04054b37518df661d04f88f7c9af.1754997083.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH] mm: Remove pud_user() from asm-generic/pgtable-nopmd.h
config: arm64-randconfig-002-20250813 (https://download.01.org/0day-ci/archive/20250813/202508131402.ZaPLdNsY-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250813/202508131402.ZaPLdNsY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508131402.ZaPLdNsY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/pgtable.h:6,
                    from arch/arm64/include/asm/io.h:12,
                    from include/linux/io.h:12,
                    from include/linux/irq.h:20,
                    from include/asm-generic/hardirq.h:17,
                    from arch/arm64/include/asm/hardirq.h:17,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from arch/arm64/kernel/asm-offsets.c:12:
   arch/arm64/include/asm/pgtable.h: In function 'pud_user_accessible_page':
>> arch/arm64/include/asm/pgtable.h:958:33: error: called object is not a function or function pointer
     958 | #define pud_user                false /* Always 0 with folding */
         |                                 ^~~~~
   arch/arm64/include/asm/pgtable.h:1307:54: note: in expansion of macro 'pud_user'
    1307 |         return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
         |                                                      ^~~~~~~~
>> arch/arm64/include/asm/pgtable.h:958:33: error: called object is not a function or function pointer
     958 | #define pud_user                false /* Always 0 with folding */
         |                                 ^~~~~
   arch/arm64/include/asm/pgtable.h:959:33: note: in expansion of macro 'pud_user'
     959 | #define pud_user_exec(pud)      pud_user(pud) /* Always 0 with folding */
         |                                 ^~~~~~~~
   arch/arm64/include/asm/pgtable.h:1307:71: note: in expansion of macro 'pud_user_exec'
    1307 |         return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
         |                                                                       ^~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:182: arch/arm64/kernel/asm-offsets.s] Error 1 shuffle=3093671401
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1281: prepare0] Error 2 shuffle=3093671401
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:248: __sub-make] Error 2 shuffle=3093671401
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:248: __sub-make] Error 2 shuffle=3093671401
   make: Target 'prepare' not remade because of errors.


vim +958 arch/arm64/include/asm/pgtable.h

   955	
   956	#define pud_valid(pud)		false
   957	#define pud_page_paddr(pud)	({ BUILD_BUG(); 0; })
 > 958	#define pud_user		false /* Always 0 with folding */
   959	#define pud_user_exec(pud)	pud_user(pud) /* Always 0 with folding */
   960	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

