Return-Path: <linux-arch+bounces-6210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0D9527F1
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 04:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3041C21831
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 02:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7011863E;
	Thu, 15 Aug 2024 02:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMX6DI4b"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67207DF5C;
	Thu, 15 Aug 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723689958; cv=none; b=EWBBS8JABYiZUXbMVGozHrElIR/26wYk4Z7OBDZfftdJwCAag1/etINlC8APZYoVttXUmHuThZSft+G2c/ALJ6VZme5nPKSAi4hGeyfSioxzuTCkRjjNwPMPthXGL9QcSoZLuTMeMylbu3sePRvXXrUXe3EIGAzDGYmstjGiJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723689958; c=relaxed/simple;
	bh=+u3XTavjkbuxY8GKnvcN2PMrpWamDcirFx/TdBwdhs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCEZGe/KZvMIrVnuOMriE+hUfUxlw/MwDKrAZUwAPCLYx6lteW1HtIjG7g/ACRo3lztrz9Gs3TIc8TyLUxBt9Ht0gkSw1vVj65K7eEf7oT9jMhgwArD3+/JdjOL9U0P/4ggCIVSgZDH0lo+FTfW+udpxIkCiHwfyD9wuvzve0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMX6DI4b; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723689956; x=1755225956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+u3XTavjkbuxY8GKnvcN2PMrpWamDcirFx/TdBwdhs8=;
  b=SMX6DI4bwtPbikGhnaFcPiLxOQw+9rcyqRSwnUWuHIK8G9MDT3c7Tav3
   kSA+4AreSBG7Wgv8KJfcysvRObhs0GUeOvP8A77YAGCk+04K6adNGLEzw
   Is7xaG6wZQ/xUa5809ZUvr/p9w+ehF5+7c2qor7x9aWwlgxkDDKbR1XBF
   cK9rrmKckM4DtPIFdsqbPH2QnVP7szDZeWmr0W+DapbuLJqDwLCPmAsA7
   jdsn3rmq5P4tdB96KCVjOL7hyf/N4/FsPBmM8qG5+YJ9UPjOcgMR3WHXW
   zf1YA24IVoCKZ/VlOlUH3SAUvtP6KJ4SvTVGpo2/Gf98JU4TIKrTrJcZt
   g==;
X-CSE-ConnectionGUID: 6Rybu8MTSwi9To8lFvYvCg==
X-CSE-MsgGUID: RmTqdxhaQKWNNWJL5If08g==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21905403"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="21905403"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:45:53 -0700
X-CSE-ConnectionGUID: e6+ZbYP3Rg6XynfxE0oMGQ==
X-CSE-MsgGUID: SO6r+U/QSlKKQ7j3nvsDiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="89918473"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2024 19:45:51 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seQUn-00036Q-0m;
	Thu, 15 Aug 2024 02:45:49 +0000
Date: Thu, 15 Aug 2024 10:45:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH 1/5] mm: Introduce a common definition of mk_pte()
Message-ID: <202408151035.TtR6QRvZ-lkp@intel.com>
References: <20240814154427.162475-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814154427.162475-2-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-m68k/for-next]
[also build test ERROR on geert-m68k/for-linus uml/next linus/master v6.11-rc3 next-20240814]
[cannot apply to uml/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/mm-Introduce-a-common-definition-of-mk_pte/20240815-001852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
patch link:    https://lore.kernel.org/r/20240814154427.162475-2-willy%40infradead.org
patch subject: [PATCH 1/5] mm: Introduce a common definition of mk_pte()
config: arc-allnoconfig (https://download.01.org/0day-ci/archive/20240815/202408151035.TtR6QRvZ-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151035.TtR6QRvZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151035.TtR6QRvZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/asm/io.h:11,
                    from include/linux/io.h:14,
                    from lib/iomap_copy.c:7:
   include/linux/pgtable.h: In function 'mk_pte':
>> include/asm-generic/memory_model.h:19:59: error: 'mem_map' undeclared (first use in this function); did you mean 'memcmp'?
      19 | #define __page_to_pfn(page)     ((unsigned long)((page) - mem_map) + \
         |                                                           ^~~~~~~
   arch/arc/include/asm/page.h:75:37: note: in definition of macro '__pte'
      75 | #define __pte(x)        ((pte_t) { (x) })
         |                                     ^
   include/asm-generic/memory_model.h:62:33: note: in expansion of macro 'PFN_PHYS'
      62 | #define __pfn_to_phys(pfn)      PFN_PHYS(pfn)
         |                                 ^~~~~~~~
   arch/arc/include/asm/pgtable-levels.h:179:39: note: in expansion of macro '__pfn_to_phys'
     179 | #define pfn_pte(pfn, prot)      __pte(__pfn_to_phys(pfn) | pgprot_val(prot))
         |                                       ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:16: note: in expansion of macro 'pfn_pte'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                ^~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:24: note: in expansion of macro 'page_to_pfn'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^~~~~~~~~~~
   include/asm-generic/memory_model.h:19:59: note: each undeclared identifier is reported only once for each function it appears in
      19 | #define __page_to_pfn(page)     ((unsigned long)((page) - mem_map) + \
         |                                                           ^~~~~~~
   arch/arc/include/asm/page.h:75:37: note: in definition of macro '__pte'
      75 | #define __pte(x)        ((pte_t) { (x) })
         |                                     ^
   include/asm-generic/memory_model.h:62:33: note: in expansion of macro 'PFN_PHYS'
      62 | #define __pfn_to_phys(pfn)      PFN_PHYS(pfn)
         |                                 ^~~~~~~~
   arch/arc/include/asm/pgtable-levels.h:179:39: note: in expansion of macro '__pfn_to_phys'
     179 | #define pfn_pte(pfn, prot)      __pte(__pfn_to_phys(pfn) | pgprot_val(prot))
         |                                       ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:16: note: in expansion of macro 'pfn_pte'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                ^~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:24: note: in expansion of macro 'page_to_pfn'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^~~~~~~~~~~


vim +19 include/asm-generic/memory_model.h

a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  17  
67de648211fa04 Andy Whitcroft    2006-06-23  18  #define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
67de648211fa04 Andy Whitcroft    2006-06-23 @19  #define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  20  				 ARCH_PFN_OFFSET)
a117e66ed45ac0 KAMEZAWA Hiroyuki 2006-03-27  21  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

