Return-Path: <linux-arch+bounces-6209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0D59527F0
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 04:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD2F283F38
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2024 02:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774418C0C;
	Thu, 15 Aug 2024 02:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6Wlp5yi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57603D9E;
	Thu, 15 Aug 2024 02:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723689956; cv=none; b=kDvbmTGDKcl82YBye4hQCI08zB+lWI36m42Ri960Q0ttfh8wwvaH0PryTTPAzg9MmQYGzQS3HXuE1tWt3YYaHVUHT1xKG34uYvFY7WaxqDsg+x3uY9A71Y+MvKvcR6qO8kLXMSn3l5PSC24f9rbIcHXIoJvDAldB2te8r3I/IBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723689956; c=relaxed/simple;
	bh=wN1lGSgwOBVxwBXCDXoWhdwRlgzBubcOETAKBJXANJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7fZfnGwQ+d1XA5fi2f9gVlyt1hpW9o1jMPP96lDrwd2sgEmWxEMjB3UVTLEmvEXXdx6LIo8PPzB/IfQlCJfVrxsahz+u4rXeR42+B6gibP6UIFjkYcMozvc4+3uM5YZ+WwRTMR3MvSpQZwj8C6+/hEJqsjCMk7hP3I9g55FAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6Wlp5yi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723689954; x=1755225954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wN1lGSgwOBVxwBXCDXoWhdwRlgzBubcOETAKBJXANJw=;
  b=G6Wlp5yiqQVNhIrbMUNZvjgxpivguuZH89FS5XpFkZz/6qpw/qJqJ3cl
   OJP3vUHnPqQaY0cQN4SItmFhGZBlxNleQyl3MR7cOX3dUoJAdv8G+fQa5
   H0INUxXYynXRtc4960snQ7PAp0/bFLmcZ25lkV0vq1pKc78Q+89FlBOzN
   e4z9J2qP/HoQyv9M34Z481Tnnq2KjD9bF6F4xGCl92gmvkFueXPPxNDo4
   bk4GSRxJrEHtuKG5QIAyNfi/4g0QyRHsJUVGETBFZFAZyvuTakWDkwB7h
   Ljkqr+pnFJfW5O96nxitCYxGgWTU+gIAPXSl9o7SLiISug+QAbyGLFlrP
   g==;
X-CSE-ConnectionGUID: H6QOpBP8QByDDnnsymepWw==
X-CSE-MsgGUID: u2inQTWRSmSOjS41AznCEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21905406"
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="21905406"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 19:45:53 -0700
X-CSE-ConnectionGUID: S51CQW4bREuH/ZKw2p5iCw==
X-CSE-MsgGUID: g1bJHEwdRuebaVjuE0SO8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,147,1719903600"; 
   d="scan'208";a="89918474"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2024 19:45:52 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seQUn-00036S-0t;
	Thu, 15 Aug 2024 02:45:49 +0000
Date: Thu, 15 Aug 2024 10:45:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH 1/5] mm: Introduce a common definition of mk_pte()
Message-ID: <202408151008.zU4OfDoL-lkp@intel.com>
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
config: alpha-randconfig-r051-20240815 (https://download.01.org/0day-ci/archive/20240815/202408151008.zU4OfDoL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408151008.zU4OfDoL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408151008.zU4OfDoL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/alpha/include/asm/page.h:89,
                    from include/linux/shm.h:6,
                    from include/linux/sched.h:23,
                    from arch/alpha/kernel/asm-offsets.c:10:
   include/linux/pgtable.h: In function 'mk_pte':
>> include/asm-generic/memory_model.h:47:21: error: implicit declaration of function 'page_to_section'; did you mean 'present_section'? [-Werror=implicit-function-declaration]
      47 |         int __sec = page_to_section(__pg);                      \
         |                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:24: note: in expansion of macro 'page_to_pfn'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^~~~~~~~~~~
   In file included from include/linux/pid_namespace.h:7,
                    from include/linux/ptrace.h:10,
                    from arch/alpha/kernel/asm-offsets.c:11:
   include/linux/mm.h: At top level:
>> include/linux/mm.h:1904:29: error: conflicting types for 'page_to_section'; have 'long unsigned int(const struct page *)'
    1904 | static inline unsigned long page_to_section(const struct page *page)
         |                             ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:47:21: note: previous implicit declaration of 'page_to_section' with type 'int()'
      47 |         int __sec = page_to_section(__pg);                      \
         |                     ^~~~~~~~~~~~~~~
   include/asm-generic/memory_model.h:64:21: note: in expansion of macro '__page_to_pfn'
      64 | #define page_to_pfn __page_to_pfn
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:47:24: note: in expansion of macro 'page_to_pfn'
      47 |         return pfn_pte(page_to_pfn(page), pgprot);
         |                        ^~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:117: arch/alpha/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +47 include/asm-generic/memory_model.h

8f6aac419bd590f Christoph Lameter 2007-10-16  39  
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  40  #elif defined(CONFIG_SPARSEMEM)
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  41  /*
1a49123b3434615 Zhang Yanfei      2013-10-03  42   * Note: section's mem_map is encoded to reflect its start_pfn.
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  43   * section[i].section_mem_map == mem_map's address - start_pfn;
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  44   */
67de648211fa041 Andy Whitcroft    2006-06-23  45  #define __page_to_pfn(pg)					\
aa462abe8aaf219 Ian Campbell      2011-08-17  46  ({	const struct page *__pg = (pg);				\
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27 @47  	int __sec = page_to_section(__pg);			\
f05b6284ee5d3be Randy Dunlap      2007-02-10  48  	(unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec)));	\
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  49  })
a117e66ed45ac05 KAMEZAWA Hiroyuki 2006-03-27  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

