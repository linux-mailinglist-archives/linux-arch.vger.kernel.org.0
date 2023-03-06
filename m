Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AEB6AB5A0
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 05:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCFEZw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 23:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCFEZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 23:25:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C827CEFAE;
        Sun,  5 Mar 2023 20:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678076749; x=1709612749;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ebaVe5FKXDXm5aY65KYm+6YDtAlgDOZfcPBBswXpIQ=;
  b=LcfAzt+m2DA/Bu8ywU0qLmi4NUjz0XHT5PjR35xbb3UhSqeWVOSfz28A
   uaCXpSAMUrEtxYzbGDZZYNk3ZAam0hHnPyDpvFEQ9/lHmr4e78o4v5Sli
   +T63l1COy/sF5qWDIv3wD5QQcT3LNR6nLrjIltYfyci9lhAjgWXKhJLL0
   di959QcENRmH3ZMGN2JZ9VWfWeAZekdu5hNaPUsTE2ylgJuRiQhR5zsY4
   rS6aCvB4mnzYYfQJnI5xg7z+TPizwJK0ATR7bsQ4wrzCq5C4qIrLsXCHL
   iekrkK8+hy9TAbKNAx2wtPeH8mIrPZB5ObcyIapNy2P2h5LNaHILvBKRl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="315125433"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="315125433"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 20:25:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="921773682"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="921773682"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Mar 2023 20:25:47 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZ2Py-000019-1l;
        Mon, 06 Mar 2023 04:25:46 +0000
Date:   Mon, 6 Mar 2023 12:25:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] irq domain: drop IRQ_DOMAIN_HIERARCHY option, make it
 always on
Message-ID: <202303061226.DHJUNNIc-lkp@intel.com>
References: <20230306002901.3903-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306002901.3903-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Randy,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes linus/master v6.3-rc1 next-20230303]
[cannot apply to tip/irq/core brgl/gpio/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Randy-Dunlap/irq-domain-drop-IRQ_DOMAIN_HIERARCHY-option-make-it-always-on/20230306-083043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20230306002901.3903-1-rdunlap%40infradead.org
patch subject: [PATCH] irq domain: drop IRQ_DOMAIN_HIERARCHY option, make it always on
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230306/202303061226.DHJUNNIc-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e208a5e4e6963263a3993c9980d61645f4e0b9d9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Randy-Dunlap/irq-domain-drop-IRQ_DOMAIN_HIERARCHY-option-make-it-always-on/20230306-083043
        git checkout e208a5e4e6963263a3993c9980d61645f4e0b9d9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/base/ drivers/pci/msi/ kernel/irq/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303061226.DHJUNNIc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/base/platform-msi.c: In function 'platform_msi_init':
   drivers/base/platform-msi.c:57:16: error: implicit declaration of function 'irq_domain_set_hwirq_and_chip' [-Werror=implicit-function-declaration]
      57 |         return irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/platform-msi.c: In function 'platform_msi_create_irq_domain':
   drivers/base/platform-msi.c:137:17: error: implicit declaration of function 'irq_domain_update_bus_token' [-Werror=implicit-function-declaration]
     137 |                 irq_domain_update_bus_token(domain, DOMAIN_BUS_PLATFORM_MSI);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/platform-msi.c: In function '__platform_msi_create_device_domain':
   drivers/base/platform-msi.c:293:18: error: implicit declaration of function 'irq_domain_create_hierarchy' [-Werror=implicit-function-declaration]
     293 |         domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/base/platform-msi.c:293:16: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     293 |         domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
         |                ^
   drivers/base/platform-msi.c:307:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
     307 |         irq_domain_remove(domain);
         |         ^~~~~~~~~~~~~~~~~
   drivers/base/platform-msi.c: In function 'platform_msi_device_domain_free':
   drivers/base/platform-msi.c:327:9: error: implicit declaration of function 'irq_domain_free_irqs_common'; did you mean 'msi_domain_free_irqs_all'? [-Werror=implicit-function-declaration]
     327 |         irq_domain_free_irqs_common(domain, virq, nr_irqs);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         msi_domain_free_irqs_all
   cc1: some warnings being treated as errors
--
   kernel/irq/msi.c: In function 'msi_setup_device_data':
   kernel/irq/msi.c:319:33: error: implicit declaration of function 'irq_domain_is_msi_parent' [-Werror=implicit-function-declaration]
     319 |         if (dev->msi.domain && !irq_domain_is_msi_parent(dev->msi.domain))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c: In function 'msi_domain_alloc':
   kernel/irq/msi.c:692:13: error: implicit declaration of function 'irq_find_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
     692 |         if (irq_find_mapping(domain, hwirq) > 0)
         |             ^~~~~~~~~~~~~~~~
         |             irq_dispose_mapping
   kernel/irq/msi.c:696:23: error: implicit declaration of function 'irq_domain_alloc_irqs_parent'; did you mean 'msi_domain_alloc_irq_at'? [-Werror=implicit-function-declaration]
     696 |                 ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       msi_domain_alloc_irq_at
   kernel/irq/msi.c:708:25: error: implicit declaration of function 'irq_domain_free_irqs_top'; did you mean 'msi_domain_free_irqs_all'? [-Werror=implicit-function-declaration]
     708 |                         irq_domain_free_irqs_top(domain, virq, nr_irqs);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
         |                         msi_domain_free_irqs_all
   kernel/irq/msi.c: In function 'msi_domain_ops_init':
   kernel/irq/msi.c:760:9: error: implicit declaration of function 'irq_domain_set_hwirq_and_chip' [-Werror=implicit-function-declaration]
     760 |         irq_domain_set_hwirq_and_chip(domain, virq, hwirq, info->chip,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c: In function '__msi_create_irq_domain':
   kernel/irq/msi.c:830:18: error: implicit declaration of function 'irq_domain_create_hierarchy' [-Werror=implicit-function-declaration]
     830 |         domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/irq/msi.c:830:16: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     830 |         domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
         |                ^
   kernel/irq/msi.c:836:17: error: implicit declaration of function 'irq_domain_update_bus_token' [-Werror=implicit-function-declaration]
     836 |                 irq_domain_update_bus_token(domain, info->bus_token);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c: In function 'msi_create_device_irq_domain':
   kernel/irq/msi.c:976:18: error: implicit declaration of function 'irq_domain_alloc_named_fwnode' [-Werror=implicit-function-declaration]
     976 |         fwnode = irq_domain_alloc_named_fwnode(bundle->name);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/irq/msi.c:976:16: warning: assignment to 'struct fwnode_handle *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     976 |         fwnode = irq_domain_alloc_named_fwnode(bundle->name);
         |                ^
   kernel/irq/msi.c:1003:9: error: implicit declaration of function 'irq_domain_free_fwnode'; did you mean 'irq_domain_get_of_node'? [-Werror=implicit-function-declaration]
    1003 |         irq_domain_free_fwnode(fwnode);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         irq_domain_get_of_node
   kernel/irq/msi.c: In function 'msi_remove_device_irq_domain':
   kernel/irq/msi.c:1024:25: error: implicit declaration of function 'irq_domain_is_msi_device'; did you mean 'irq_domain_set_pm_device'? [-Werror=implicit-function-declaration]
    1024 |         if (!domain || !irq_domain_is_msi_device(domain))
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
         |                         irq_domain_set_pm_device
   kernel/irq/msi.c:1031:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
    1031 |         irq_domain_remove(domain);
         |         ^~~~~~~~~~~~~~~~~
   kernel/irq/msi.c: In function 'msi_domain_populate_irqs':
   kernel/irq/msi.c:1102:23: error: implicit declaration of function 'irq_domain_alloc_irqs_hierarchy'; did you mean 'msi_domain_alloc_irqs_range'? [-Werror=implicit-function-declaration]
    1102 |                 ret = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       msi_domain_alloc_irqs_range
   kernel/irq/msi.c:1113:17: error: implicit declaration of function 'irq_domain_free_irqs_common'; did you mean 'msi_domain_free_irqs_all'? [-Werror=implicit-function-declaration]
    1113 |                 irq_domain_free_irqs_common(domain, virq, 1);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 msi_domain_free_irqs_all
   kernel/irq/msi.c: In function 'msi_init_virq':
   kernel/irq/msi.c:1190:33: error: implicit declaration of function 'irq_domain_get_irq_data'; did you mean 'irq_desc_get_irq_data'? [-Werror=implicit-function-declaration]
    1190 |         struct irq_data *irqd = irq_domain_get_irq_data(domain, virq);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                                 irq_desc_get_irq_data
>> kernel/irq/msi.c:1190:33: warning: initialization of 'struct irq_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   kernel/irq/msi.c: In function '__msi_domain_alloc_irqs':
   kernel/irq/msi.c:1280:24: error: implicit declaration of function '__irq_domain_alloc_irqs'; did you mean '__msi_domain_alloc_irqs'? [-Werror=implicit-function-declaration]
    1280 |                 virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
         |                        __msi_domain_alloc_irqs
   kernel/irq/msi.c: In function '__msi_domain_free_irqs':
>> kernel/irq/msi.c:1512:30: warning: assignment to 'struct irq_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1512 |                         irqd = irq_domain_get_irq_data(domain, desc->irq + i);
         |                              ^
   kernel/irq/msi.c:1517:17: error: implicit declaration of function 'irq_domain_free_irqs'; did you mean 'msi_domain_free_descs'? [-Werror=implicit-function-declaration]
    1517 |                 irq_domain_free_irqs(desc->irq, desc->nvec_used);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 msi_domain_free_descs
   cc1: some warnings being treated as errors


vim +293 drivers/base/platform-msi.c

a80713fea3d123 Thomas Gleixner      2021-12-06  251  
552c494a7666c7 Marc Zyngier         2015-11-23  252  /**
9835cec6d557b0 Thomas Gleixner      2021-12-10  253   * __platform_msi_create_device_domain - Create a platform-msi device domain
552c494a7666c7 Marc Zyngier         2015-11-23  254   *
552c494a7666c7 Marc Zyngier         2015-11-23  255   * @dev:		The device generating the MSIs
552c494a7666c7 Marc Zyngier         2015-11-23  256   * @nvec:		The number of MSIs that need to be allocated
3c652132ce9052 Pierre-Louis Bossart 2021-03-31  257   * @is_tree:		flag to indicate tree hierarchy
552c494a7666c7 Marc Zyngier         2015-11-23  258   * @write_msi_msg:	Callback to write an interrupt message for @dev
552c494a7666c7 Marc Zyngier         2015-11-23  259   * @ops:		The hierarchy domain operations to use
552c494a7666c7 Marc Zyngier         2015-11-23  260   * @host_data:		Private data associated to this domain
552c494a7666c7 Marc Zyngier         2015-11-23  261   *
9835cec6d557b0 Thomas Gleixner      2021-12-10  262   * Return: An irqdomain for @nvec interrupts on success, NULL in case of error.
9835cec6d557b0 Thomas Gleixner      2021-12-10  263   *
9835cec6d557b0 Thomas Gleixner      2021-12-10  264   * This is for interrupt domains which stack on a platform-msi domain
9835cec6d557b0 Thomas Gleixner      2021-12-10  265   * created by platform_msi_create_irq_domain(). @dev->msi.domain points to
9835cec6d557b0 Thomas Gleixner      2021-12-10  266   * that platform-msi domain which is the parent for the new domain.
552c494a7666c7 Marc Zyngier         2015-11-23  267   */
552c494a7666c7 Marc Zyngier         2015-11-23  268  struct irq_domain *
1f83515bebc236 Marc Zyngier         2018-10-01  269  __platform_msi_create_device_domain(struct device *dev,
552c494a7666c7 Marc Zyngier         2015-11-23  270  				    unsigned int nvec,
1f83515bebc236 Marc Zyngier         2018-10-01  271  				    bool is_tree,
552c494a7666c7 Marc Zyngier         2015-11-23  272  				    irq_write_msi_msg_t write_msi_msg,
552c494a7666c7 Marc Zyngier         2015-11-23  273  				    const struct irq_domain_ops *ops,
552c494a7666c7 Marc Zyngier         2015-11-23  274  				    void *host_data)
552c494a7666c7 Marc Zyngier         2015-11-23  275  {
552c494a7666c7 Marc Zyngier         2015-11-23  276  	struct platform_msi_priv_data *data;
552c494a7666c7 Marc Zyngier         2015-11-23  277  	struct irq_domain *domain;
552c494a7666c7 Marc Zyngier         2015-11-23  278  	int err;
552c494a7666c7 Marc Zyngier         2015-11-23  279  
fc22e7dbcdb3e0 Thomas Gleixner      2021-12-10  280  	err = platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
fc22e7dbcdb3e0 Thomas Gleixner      2021-12-10  281  	if (err)
552c494a7666c7 Marc Zyngier         2015-11-23  282  		return NULL;
552c494a7666c7 Marc Zyngier         2015-11-23  283  
a80713fea3d123 Thomas Gleixner      2021-12-06  284  	/*
a80713fea3d123 Thomas Gleixner      2021-12-06  285  	 * Use a separate lock class for the MSI descriptor mutex on
a80713fea3d123 Thomas Gleixner      2021-12-06  286  	 * platform MSI device domains because the descriptor mutex nests
a80713fea3d123 Thomas Gleixner      2021-12-06  287  	 * into the domain mutex. See alloc/free below.
a80713fea3d123 Thomas Gleixner      2021-12-06  288  	 */
a80713fea3d123 Thomas Gleixner      2021-12-06  289  	lockdep_set_class(&dev->msi.data->mutex, &platform_device_msi_lock_class);
a80713fea3d123 Thomas Gleixner      2021-12-06  290  
fc22e7dbcdb3e0 Thomas Gleixner      2021-12-10  291  	data = dev->msi.data->platform_data;
552c494a7666c7 Marc Zyngier         2015-11-23  292  	data->host_data = host_data;
34fff62827b254 Thomas Gleixner      2021-12-10 @293  	domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
1f83515bebc236 Marc Zyngier         2018-10-01  294  					     is_tree ? 0 : nvec,
6943acf67311e8 Hanjun Guo           2017-03-07  295  					     dev->fwnode, ops, data);
552c494a7666c7 Marc Zyngier         2015-11-23  296  	if (!domain)
552c494a7666c7 Marc Zyngier         2015-11-23  297  		goto free_priv;
552c494a7666c7 Marc Zyngier         2015-11-23  298  
91f90daa4fb2b7 Marc Zyngier         2020-11-29  299  	platform_msi_set_proxy_dev(&data->arg);
552c494a7666c7 Marc Zyngier         2015-11-23  300  	err = msi_domain_prepare_irqs(domain->parent, dev, nvec, &data->arg);
552c494a7666c7 Marc Zyngier         2015-11-23  301  	if (err)
552c494a7666c7 Marc Zyngier         2015-11-23  302  		goto free_domain;
552c494a7666c7 Marc Zyngier         2015-11-23  303  
552c494a7666c7 Marc Zyngier         2015-11-23  304  	return domain;
552c494a7666c7 Marc Zyngier         2015-11-23  305  
552c494a7666c7 Marc Zyngier         2015-11-23  306  free_domain:
552c494a7666c7 Marc Zyngier         2015-11-23  307  	irq_domain_remove(domain);
552c494a7666c7 Marc Zyngier         2015-11-23  308  free_priv:
fc22e7dbcdb3e0 Thomas Gleixner      2021-12-10  309  	platform_msi_free_priv_data(dev);
552c494a7666c7 Marc Zyngier         2015-11-23  310  	return NULL;
552c494a7666c7 Marc Zyngier         2015-11-23  311  }
552c494a7666c7 Marc Zyngier         2015-11-23  312  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
