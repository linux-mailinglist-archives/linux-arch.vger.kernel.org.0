Return-Path: <linux-arch+bounces-691-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD88050F5
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 11:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0AFE1F214F0
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0F012E7A;
	Tue,  5 Dec 2023 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/Pzv3q3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687D1FA;
	Tue,  5 Dec 2023 02:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701773112; x=1733309112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOLccH3Xzc++EaBQ0v6eolcJHqG0ji0sa1DvQVydOv4=;
  b=B/Pzv3q33kt8RpyZTy/nN4u42ZFajAZmXfsTKeD8tjpYhp42/TC16GYj
   ojRlnTUVc9MaTnwB5XaNZdyJ+S+4fXb9RIkXpNhebVWMY4TCCSVmOs4cM
   lmc8UhjjpDBe6/1nBV8/M/p+8wbozHlFSnQ968ASyoPMjFZWJVZly3MCC
   j2BlG9RBsmSRn1vBh/CZa59BePhRPgvWrqDd1vwO9DHsh8Gatu8scdG0V
   e3aC/gFjpJwoiHvAz4T9jn8yJMlYpSa9ZrVT9gpqzrg2afvNzBSegEG2w
   oDHjqn8i1CkdgEz4SR/l+x2gUKGeYQwgY7YRvSYM1HaqUapCYOLUDtg5m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="393609836"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="393609836"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 02:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914758875"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="914758875"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 05 Dec 2023 02:45:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rASus-0008na-2J;
	Tue, 05 Dec 2023 10:45:03 +0000
Date: Tue, 5 Dec 2023 18:44:01 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <guohanjun@huawei.com>, NeilBrown <neilb@suse.de>,
	Kent Overstreet <kmo@daterainc.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	John Sanpe <sanpeqf@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Baron <jbaron@akamai.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>, dakr@redhat.com
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
Message-ID: <202312051813.09WbvusW-lkp@intel.com>
References: <20231204123834.29247-6-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204123834.29247-6-pstanner@redhat.com>

Hi Philipp,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus arnd-asm-generic/master kees/for-next/pstore kees/for-next/kspp linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/lib-pci_iomap-c-fix-cleanup-bugs-in-pci_iounmap/20231204-204128
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231204123834.29247-6-pstanner%40redhat.com
patch subject: [PATCH v3 5/5] lib, pci: unify generic pci_iounmap()
config: openrisc-virt_defconfig (https://download.01.org/0day-ci/archive/20231205/202312051813.09WbvusW-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051813.09WbvusW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051813.09WbvusW-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/iomap.c: In function 'pci_iounmap':
>> drivers/pci/iomap.c:155:17: error: implicit declaration of function 'ioport_unmap'; did you mean 'devm_ioport_unmap'? [-Werror=implicit-function-declaration]
     155 |                 ioport_unmap(addr);
         |                 ^~~~~~~~~~~~
         |                 devm_ioport_unmap
   cc1: some warnings being treated as errors


vim +155 drivers/pci/iomap.c

   144	
   145	/**
   146	 * pci_iounmap - Unmapp a mapping
   147	 * @dev: PCI device the mapping belongs to
   148	 * @addr: start address of the mapping
   149	 *
   150	 * Unmapp a PIO or MMIO mapping.
   151	 */
   152	void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
   153	{
   154		if (iomem_is_ioport(addr)) {
 > 155			ioport_unmap(addr);
   156			return;
   157		}
   158	
   159		iounmap(addr);
   160	}
   161	EXPORT_SYMBOL(pci_iounmap);
   162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

