Return-Path: <linux-arch+bounces-1310-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09EC827C00
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 01:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D1028331C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C77838A;
	Tue,  9 Jan 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVN9XmnH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E20370;
	Tue,  9 Jan 2024 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704760166; x=1736296166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2+RHqZFLG1LFHYWdUL8HJxFLdTqp/dv6VkqJQHfJKAc=;
  b=nVN9XmnHfrevFuWMBFczRX9gbtKE79g81DxaZ0RAMOkK7XLivq6HEfeH
   3ASgt0a5/a8GHkXR7m+tjQtSet7n81EZ72bJdQWTNstzyaZD9i6hjBYFw
   3y7IQ97ijsO+vTfBdnj1kPtYLBu3mlI1Hfj5c7ycjMkP9dLBHcIQ2iPL6
   5d5ESl/gUELjYsMsq95oEfUH9yjq3AYyfwfHPCKqDg7m+kU0jFZXWfRWG
   lpyhcnCW535ryxUXeZvQH+OHWpIURFcvk5gASFKLmuRt8RKm+qZQYI3qh
   9Qxep9KJ6TVOA/j/PdyMxeOJEAkrRt0HU0/ulnoz9m665XElMQHRS5+BW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="396911406"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="396911406"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 16:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="900547475"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="900547475"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2024 16:29:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMzzZ-0005G8-2G;
	Tue, 09 Jan 2024 00:29:17 +0000
Date: Tue, 9 Jan 2024 08:29:01 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, javierm@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 4/4] arch/x86: Do not include <asm/bootparam.h> in
 several files
Message-ID: <202401090850.YMrW5H2K-lkp@intel.com>
References: <20240108095903.8427-5-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108095903.8427-5-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on efi/next tip/master tip/auto-latest linus/master v6.7 next-20240108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/arch-x86-Move-UAPI-setup-structures-into-setup_data-h/20240108-180158
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240108095903.8427-5-tzimmermann%40suse.de
patch subject: [PATCH v4 4/4] arch/x86: Do not include <asm/bootparam.h> in several files
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240109/202401090850.YMrW5H2K-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090850.YMrW5H2K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090850.YMrW5H2K-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/boot/compressed/cmdline.c:2:
   arch/x86/boot/compressed/misc.h: In function 'sev_enable':
>> arch/x86/boot/compressed/misc.h:154:19: error: invalid use of undefined type 'struct boot_params'
     154 |                 bp->cc_blob_address = 0;
         |                   ^~


vim +154 arch/x86/boot/compressed/misc.h

cec49df9d331fea Joe Millenbach    2012-07-19  135  
597cfe48212a3f1 Joerg Roedel      2020-09-07  136  #ifdef CONFIG_AMD_MEM_ENCRYPT
ec1c66af3a30d45 Michael Roth      2022-02-09  137  void sev_enable(struct boot_params *bp);
8c29f0165405325 Nikunj A Dadhania 2023-01-18  138  void snp_check_features(void);
597cfe48212a3f1 Joerg Roedel      2020-09-07  139  void sev_es_shutdown_ghcb(void);
69add17a7c19925 Joerg Roedel      2020-09-07  140  extern bool sev_es_check_ghcb_fault(unsigned long address);
4f9c403e44e5e88 Brijesh Singh     2022-02-09  141  void snp_set_page_private(unsigned long paddr);
4f9c403e44e5e88 Brijesh Singh     2022-02-09  142  void snp_set_page_shared(unsigned long paddr);
76f61e1e89b32f3 Michael Roth      2022-02-24  143  void sev_prep_identity_maps(unsigned long top_level_pgt);
597cfe48212a3f1 Joerg Roedel      2020-09-07  144  #else
4b1c742407571ef Michael Roth      2022-08-23  145  static inline void sev_enable(struct boot_params *bp)
4b1c742407571ef Michael Roth      2022-08-23  146  {
4b1c742407571ef Michael Roth      2022-08-23  147  	/*
4b1c742407571ef Michael Roth      2022-08-23  148  	 * bp->cc_blob_address should only be set by boot/compressed kernel.
4b1c742407571ef Michael Roth      2022-08-23  149  	 * Initialize it to 0 unconditionally (thus here in this stub too) to
4b1c742407571ef Michael Roth      2022-08-23  150  	 * ensure that uninitialized values from buggy bootloaders aren't
4b1c742407571ef Michael Roth      2022-08-23  151  	 * propagated.
4b1c742407571ef Michael Roth      2022-08-23  152  	 */
4b1c742407571ef Michael Roth      2022-08-23  153  	if (bp)
4b1c742407571ef Michael Roth      2022-08-23 @154  		bp->cc_blob_address = 0;
4b1c742407571ef Michael Roth      2022-08-23  155  }
8c29f0165405325 Nikunj A Dadhania 2023-01-18  156  static inline void snp_check_features(void) { }
597cfe48212a3f1 Joerg Roedel      2020-09-07  157  static inline void sev_es_shutdown_ghcb(void) { }
69add17a7c19925 Joerg Roedel      2020-09-07  158  static inline bool sev_es_check_ghcb_fault(unsigned long address)
69add17a7c19925 Joerg Roedel      2020-09-07  159  {
69add17a7c19925 Joerg Roedel      2020-09-07  160  	return false;
69add17a7c19925 Joerg Roedel      2020-09-07  161  }
4f9c403e44e5e88 Brijesh Singh     2022-02-09  162  static inline void snp_set_page_private(unsigned long paddr) { }
4f9c403e44e5e88 Brijesh Singh     2022-02-09  163  static inline void snp_set_page_shared(unsigned long paddr) { }
76f61e1e89b32f3 Michael Roth      2022-02-24  164  static inline void sev_prep_identity_maps(unsigned long top_level_pgt) { }
597cfe48212a3f1 Joerg Roedel      2020-09-07  165  #endif
597cfe48212a3f1 Joerg Roedel      2020-09-07  166  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

