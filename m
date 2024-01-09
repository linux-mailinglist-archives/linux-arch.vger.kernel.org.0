Return-Path: <linux-arch+bounces-1311-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C49827C06
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 01:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532B01C231F7
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB071361;
	Tue,  9 Jan 2024 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhX17OvJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5885B639;
	Tue,  9 Jan 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704760168; x=1736296168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ICS0Q1nES6wmFGgjB/iavarHm9pD/C1AFIAVIA7DcCg=;
  b=UhX17OvJ5dE7T7WIKCyciBTJqWDWcu4lVS6h1KJxP6Wa2kfJ2nBA8pDu
   z7ZSIUTckegp5Tx5h9hNfhCINjYibt+/B+cLo1YEnxmLkBMK20xWRbqhS
   LI9zoA8GkpgOW8MwCUxlK+o8fd01AxKxNkvyW5zlaPZjuLntFZOnPlLAx
   z1M+BA/xKIhbEKavwGukIQowopfAAaXtKchhgLuGATa2bNYp1VtP6XPxl
   BghbUtfXg5ejUs5v22z4z+nTKi77wZ7nQunBMA6hDzFrDdDfdo0RR0n1L
   IvevUkNMAKuzokjrGuaj88yD1dF2xLsnIr/Ecdsdj7vgEG4RZYe8y2Yny
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="396911428"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="396911428"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 16:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="900547474"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="900547474"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2024 16:29:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMzzZ-0005G6-28;
	Tue, 09 Jan 2024 00:29:17 +0000
Date: Tue, 9 Jan 2024 08:28:59 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	bhelgaas@google.com, arnd@arndb.de, zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, javierm@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 2/4] arch/x86: Move internal setup_data structures
 into setup_data.h
Message-ID: <202401090800.UOBEKB3W-lkp@intel.com>
References: <20240108095903.8427-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108095903.8427-3-tzimmermann@suse.de>

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on efi/next tip/master tip/auto-latest linus/master v6.7 next-20240108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Zimmermann/arch-x86-Move-UAPI-setup-structures-into-setup_data-h/20240108-180158
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240108095903.8427-3-tzimmermann%40suse.de
patch subject: [PATCH v4 2/4] arch/x86: Move internal setup_data structures into setup_data.h
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240109/202401090800.UOBEKB3W-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090800.UOBEKB3W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090800.UOBEKB3W-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/realmode/rm/wakemain.c:3:
   In file included from arch/x86/boot/boot.h:24:
   In file included from arch/x86/include/asm/setup.h:10:
   In file included from arch/x86/include/asm/page_types.h:7:
   In file included from include/linux/mem_encrypt.h:17:
   In file included from arch/x86/include/asm/mem_encrypt.h:18:
   In file included from arch/x86/include/uapi/asm/bootparam.h:5:
>> arch/x86/include/asm/setup_data.h:10:20: warning: field 'data' with variable sized type 'struct setup_data' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
      10 |         struct setup_data data;
         |                           ^
   1 warning generated.


vim +10 arch/x86/include/asm/setup_data.h

     8	
     9	struct pci_setup_rom {
  > 10		struct setup_data data;
    11		uint16_t vendor;
    12		uint16_t devid;
    13		uint64_t pcilen;
    14		unsigned long segment;
    15		unsigned long bus;
    16		unsigned long device;
    17		unsigned long function;
    18		uint8_t romdata[];
    19	};
    20	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

