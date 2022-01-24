Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED572497F81
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 13:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiAXM1p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 07:27:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:64863 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239166AbiAXM1o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jan 2022 07:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643027264; x=1674563264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ynT/qixLnUd/rCOCLxvQhigT+gasAy3POU2QKgKgKvQ=;
  b=iBmBvh4fWDenrjuTDhpdxgp0XHpSD3DYEMbj4WAeng+1Yp65s5YANkrl
   QjhRnHk7oMPEc+Cy3oCgGZIUKPLKxotacL2zA1l9/nL9EXwb4+6qjBSlx
   PTvQNA7qDEvmgHkLmaP1BOsYOkpYVYeYXXnYsR3jmrfTZ1nitDDPtVvDI
   sTQGYMwqg8fD7oJa2xgGeZ843PC2Oe1Qd5C5pbfYxbfBubVy5XiteqJu/
   crNNoNehszzytOun6VeBZW4++FTxoRsmKiy0Y+jK/hkb4bxXcbb1/Krcn
   cvPCsNRm+jKqHTUH5iQIFBIeZRNpd7nmHmKCfTRz+EdvpG1meFOEbJrXi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243629366"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243629366"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:27:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695405990"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 04:27:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nByRf-000IJC-DB; Mon, 24 Jan 2022 12:27:39 +0000
Date:   Mon, 24 Jan 2022 20:27:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/7] powerpc: Select ARCH_WANTS_MODULES_DATA_IN_VMALLOC
 on book3s/32 and 8xx
Message-ID: <202201242036.OjeEPlOb-lkp@intel.com>
References: <ff7a8bdc9a90a77de2ebc059beb4f644b34186c1.1643015752.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff7a8bdc9a90a77de2ebc059beb4f644b34186c1.1643015752.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on mcgrof/modules-next]
[also build test WARNING on powerpc/next linus/master jeyu/modules-next v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/Allocate-module-text-and-data-separately/20220124-172517
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220124/202201242036.OjeEPlOb-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2a5f7a254dd5c1efcfb852f5747632c85582016d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/Allocate-module-text-and-data-separately/20220124-172517
        git checkout 2a5f7a254dd5c1efcfb852f5747632c85582016d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/debug/kdb/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/debug/kdb/kdb_main.c: In function 'kdb_lsmod':
>> kernel/debug/kdb/kdb_main.c:2027:38: warning: format '%p' expects a matching 'void *' argument [-Wformat=]
    2027 |                 kdb_printf("/%8u  0x%px ", mod->data_layout.size);
         |                                     ~^
         |                                      |
         |                                      void *


vim +2027 kernel/debug/kdb/kdb_main.c

5d5314d6795f3c1 Jason Wessel     2010-05-20  2006  
5d5314d6795f3c1 Jason Wessel     2010-05-20  2007  #if defined(CONFIG_MODULES)
5d5314d6795f3c1 Jason Wessel     2010-05-20  2008  /*
5d5314d6795f3c1 Jason Wessel     2010-05-20  2009   * kdb_lsmod - This function implements the 'lsmod' command.  Lists
5d5314d6795f3c1 Jason Wessel     2010-05-20  2010   *	currently loaded kernel modules.
5d5314d6795f3c1 Jason Wessel     2010-05-20  2011   *	Mostly taken from userland lsmod.
5d5314d6795f3c1 Jason Wessel     2010-05-20  2012   */
5d5314d6795f3c1 Jason Wessel     2010-05-20  2013  static int kdb_lsmod(int argc, const char **argv)
5d5314d6795f3c1 Jason Wessel     2010-05-20  2014  {
5d5314d6795f3c1 Jason Wessel     2010-05-20  2015  	struct module *mod;
5d5314d6795f3c1 Jason Wessel     2010-05-20  2016  
5d5314d6795f3c1 Jason Wessel     2010-05-20  2017  	if (argc != 0)
5d5314d6795f3c1 Jason Wessel     2010-05-20  2018  		return KDB_ARGCOUNT;
5d5314d6795f3c1 Jason Wessel     2010-05-20  2019  
5d5314d6795f3c1 Jason Wessel     2010-05-20  2020  	kdb_printf("Module                  Size  modstruct     Used by\n");
5d5314d6795f3c1 Jason Wessel     2010-05-20  2021  	list_for_each_entry(mod, kdb_modules, list) {
0d21b0e3477395e Rusty Russell    2013-01-12  2022  		if (mod->state == MODULE_STATE_UNFORMED)
0d21b0e3477395e Rusty Russell    2013-01-12  2023  			continue;
5d5314d6795f3c1 Jason Wessel     2010-05-20  2024  
299a20e0bead4b7 Christophe Leroy 2022-01-24  2025  		kdb_printf("%-20s%8u", mod->name, mod->core_layout.size);
299a20e0bead4b7 Christophe Leroy 2022-01-24  2026  #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
299a20e0bead4b7 Christophe Leroy 2022-01-24 @2027  		kdb_printf("/%8u  0x%px ", mod->data_layout.size);
299a20e0bead4b7 Christophe Leroy 2022-01-24  2028  #endif
299a20e0bead4b7 Christophe Leroy 2022-01-24  2029  		kdb_printf("  0x%px ", (void *)mod);
5d5314d6795f3c1 Jason Wessel     2010-05-20  2030  #ifdef CONFIG_MODULE_UNLOAD
d5db139ab376464 Rusty Russell    2015-01-22  2031  		kdb_printf("%4d ", module_refcount(mod));
5d5314d6795f3c1 Jason Wessel     2010-05-20  2032  #endif
5d5314d6795f3c1 Jason Wessel     2010-05-20  2033  		if (mod->state == MODULE_STATE_GOING)
5d5314d6795f3c1 Jason Wessel     2010-05-20  2034  			kdb_printf(" (Unloading)");
5d5314d6795f3c1 Jason Wessel     2010-05-20  2035  		else if (mod->state == MODULE_STATE_COMING)
5d5314d6795f3c1 Jason Wessel     2010-05-20  2036  			kdb_printf(" (Loading)");
5d5314d6795f3c1 Jason Wessel     2010-05-20  2037  		else
5d5314d6795f3c1 Jason Wessel     2010-05-20  2038  			kdb_printf(" (Live)");
568fb6f42ac6851 Christophe Leroy 2018-09-27  2039  		kdb_printf(" 0x%px", mod->core_layout.base);
299a20e0bead4b7 Christophe Leroy 2022-01-24  2040  #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
299a20e0bead4b7 Christophe Leroy 2022-01-24  2041  		kdb_printf("/0x%px", mod->data_layout.base);
299a20e0bead4b7 Christophe Leroy 2022-01-24  2042  #endif
5d5314d6795f3c1 Jason Wessel     2010-05-20  2043  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
