Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399BB6AB6CB
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 08:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjCFHK6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 02:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCFHK5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 02:10:57 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90756A5F8;
        Sun,  5 Mar 2023 23:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678086655; x=1709622655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YDRgsN32w0HykEujrXJuffzOJBom3LdrSZ9PYeUbYbs=;
  b=KndjEUAjaNeQppDXk7EzASeC4Y26L+C6QA1U7uc5/23NEsnSy3kFb8p1
   d1J2ApeSwdjiWvFA8QCYEN6rQPpdzNJajEIN+U2Qt425GDjAuB6A2b3/b
   jW6y67DAuI0ZytBm5u2yrZeKTgvVFw8GwYPqN6shfHp0dTiThm/u/PW1W
   1KrAswQ9ZpNxREAokx9M0WjOnrKavGnhod+UzWlPgM0C5UP9Vkc3qhiaz
   yTyZtI6v4VMnJaiEwNazp3KYZq1+rhxuPH8qQzqfoPR3dPP7d8cmQW8U2
   8V5U5ugifyYHZCuHVaMROGColrLe8f4/BA5hUzLBrIwKLgOxB+hNv8XRi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="319311290"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="319311290"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 23:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="921813119"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="921813119"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Mar 2023 23:10:52 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZ4zj-00007d-2F;
        Mon, 06 Mar 2023 07:10:51 +0000
Date:   Mon, 6 Mar 2023 15:10:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Randy Dunlap <rdunlap@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] irq domain: drop IRQ_DOMAIN_HIERARCHY option, make it
 always on
Message-ID: <202303061517.pXH9Mrjx-lkp@intel.com>
References: <20230306002901.3903-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306002901.3903-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Randy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v6.3-rc1 next-20230306]
[cannot apply to tip/irq/core brgl/gpio/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Randy-Dunlap/irq-domain-drop-IRQ_DOMAIN_HIERARCHY-option-make-it-always-on/20230306-083043
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20230306002901.3903-1-rdunlap%40infradead.org
patch subject: [PATCH] irq domain: drop IRQ_DOMAIN_HIERARCHY option, make it always on
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230306/202303061517.pXH9Mrjx-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303061517.pXH9Mrjx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/msi/irqdomain.c: In function 'pci_msi_setup_msi_irqs':
>> drivers/pci/msi/irqdomain.c:16:23: error: implicit declaration of function 'irq_domain_is_hierarchy' [-Werror=implicit-function-declaration]
      16 |         if (domain && irq_domain_is_hierarchy(domain))
         |                       ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/msi/irqdomain.c: In function 'pci_create_device_domain':
>> drivers/pci/msi/irqdomain.c:244:25: error: implicit declaration of function 'irq_domain_is_msi_parent' [-Werror=implicit-function-declaration]
     244 |         if (!domain || !irq_domain_is_msi_parent(domain))
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   kernel/irq/msi.c: In function 'msi_setup_device_data':
>> kernel/irq/msi.c:319:33: error: implicit declaration of function 'irq_domain_is_msi_parent' [-Werror=implicit-function-declaration]
     319 |         if (dev->msi.domain && !irq_domain_is_msi_parent(dev->msi.domain))
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c: In function 'msi_domain_alloc':
>> kernel/irq/msi.c:692:13: error: implicit declaration of function 'irq_find_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
     692 |         if (irq_find_mapping(domain, hwirq) > 0)
         |             ^~~~~~~~~~~~~~~~
         |             irq_dispose_mapping
>> kernel/irq/msi.c:696:23: error: implicit declaration of function 'irq_domain_alloc_irqs_parent'; did you mean 'msi_domain_alloc_irq_at'? [-Werror=implicit-function-declaration]
     696 |                 ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       msi_domain_alloc_irq_at
>> kernel/irq/msi.c:708:25: error: implicit declaration of function 'irq_domain_free_irqs_top'; did you mean 'msi_domain_free_irqs_all'? [-Werror=implicit-function-declaration]
     708 |                         irq_domain_free_irqs_top(domain, virq, nr_irqs);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
         |                         msi_domain_free_irqs_all
   kernel/irq/msi.c: In function 'msi_domain_ops_init':
>> kernel/irq/msi.c:760:9: error: implicit declaration of function 'irq_domain_set_hwirq_and_chip' [-Werror=implicit-function-declaration]
     760 |         irq_domain_set_hwirq_and_chip(domain, virq, hwirq, info->chip,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c: In function '__msi_create_irq_domain':
>> kernel/irq/msi.c:830:18: error: implicit declaration of function 'irq_domain_create_hierarchy' [-Werror=implicit-function-declaration]
     830 |         domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c:830:16: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     830 |         domain = irq_domain_create_hierarchy(parent, flags | IRQ_DOMAIN_FLAG_MSI, 0,
         |                ^
>> kernel/irq/msi.c:836:17: error: implicit declaration of function 'irq_domain_update_bus_token' [-Werror=implicit-function-declaration]
     836 |                 irq_domain_update_bus_token(domain, info->bus_token);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c: In function 'msi_create_device_irq_domain':
>> kernel/irq/msi.c:976:18: error: implicit declaration of function 'irq_domain_alloc_named_fwnode' [-Werror=implicit-function-declaration]
     976 |         fwnode = irq_domain_alloc_named_fwnode(bundle->name);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/irq/msi.c:976:16: warning: assignment to 'struct fwnode_handle *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     976 |         fwnode = irq_domain_alloc_named_fwnode(bundle->name);
         |                ^
>> kernel/irq/msi.c:1003:9: error: implicit declaration of function 'irq_domain_free_fwnode'; did you mean 'irq_domain_get_of_node'? [-Werror=implicit-function-declaration]
    1003 |         irq_domain_free_fwnode(fwnode);
         |         ^~~~~~~~~~~~~~~~~~~~~~
         |         irq_domain_get_of_node
   kernel/irq/msi.c: In function 'msi_remove_device_irq_domain':
>> kernel/irq/msi.c:1024:25: error: implicit declaration of function 'irq_domain_is_msi_device'; did you mean 'irq_domain_set_pm_device'? [-Werror=implicit-function-declaration]
    1024 |         if (!domain || !irq_domain_is_msi_device(domain))
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
         |                         irq_domain_set_pm_device
>> kernel/irq/msi.c:1031:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
    1031 |         irq_domain_remove(domain);
         |         ^~~~~~~~~~~~~~~~~
   kernel/irq/msi.c: In function 'msi_domain_populate_irqs':
>> kernel/irq/msi.c:1102:23: error: implicit declaration of function 'irq_domain_alloc_irqs_hierarchy'; did you mean 'msi_domain_alloc_irqs_range'? [-Werror=implicit-function-declaration]
    1102 |                 ret = irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       msi_domain_alloc_irqs_range
>> kernel/irq/msi.c:1113:17: error: implicit declaration of function 'irq_domain_free_irqs_common'; did you mean 'msi_domain_free_irqs_all'? [-Werror=implicit-function-declaration]
    1113 |                 irq_domain_free_irqs_common(domain, virq, 1);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 msi_domain_free_irqs_all
   kernel/irq/msi.c: In function 'msi_init_virq':
>> kernel/irq/msi.c:1190:33: error: implicit declaration of function 'irq_domain_get_irq_data'; did you mean 'irq_desc_get_irq_data'? [-Werror=implicit-function-declaration]
    1190 |         struct irq_data *irqd = irq_domain_get_irq_data(domain, virq);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
         |                                 irq_desc_get_irq_data
   kernel/irq/msi.c:1190:33: warning: initialization of 'struct irq_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   kernel/irq/msi.c: In function '__msi_domain_alloc_irqs':
>> kernel/irq/msi.c:1280:24: error: implicit declaration of function '__irq_domain_alloc_irqs'; did you mean '__msi_domain_alloc_irqs'? [-Werror=implicit-function-declaration]
    1280 |                 virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
         |                        __msi_domain_alloc_irqs
   kernel/irq/msi.c: In function '__msi_domain_free_irqs':
   kernel/irq/msi.c:1512:30: warning: assignment to 'struct irq_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1512 |                         irqd = irq_domain_get_irq_data(domain, desc->irq + i);
         |                              ^
>> kernel/irq/msi.c:1517:17: error: implicit declaration of function 'irq_domain_free_irqs'; did you mean 'msi_domain_free_descs'? [-Werror=implicit-function-declaration]
    1517 |                 irq_domain_free_irqs(desc->irq, desc->nvec_used);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 msi_domain_free_descs
   cc1: some warnings being treated as errors
--
   drivers/base/platform-msi.c: In function 'platform_msi_init':
>> drivers/base/platform-msi.c:57:16: error: implicit declaration of function 'irq_domain_set_hwirq_and_chip' [-Werror=implicit-function-declaration]
      57 |         return irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/platform-msi.c: In function 'platform_msi_create_irq_domain':
>> drivers/base/platform-msi.c:137:17: error: implicit declaration of function 'irq_domain_update_bus_token' [-Werror=implicit-function-declaration]
     137 |                 irq_domain_update_bus_token(domain, DOMAIN_BUS_PLATFORM_MSI);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/platform-msi.c: In function '__platform_msi_create_device_domain':
>> drivers/base/platform-msi.c:293:18: error: implicit declaration of function 'irq_domain_create_hierarchy' [-Werror=implicit-function-declaration]
     293 |         domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/platform-msi.c:293:16: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     293 |         domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
         |                ^
>> drivers/base/platform-msi.c:307:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
     307 |         irq_domain_remove(domain);
         |         ^~~~~~~~~~~~~~~~~
   drivers/base/platform-msi.c: In function 'platform_msi_device_domain_free':
>> drivers/base/platform-msi.c:327:9: error: implicit declaration of function 'irq_domain_free_irqs_common'; did you mean 'msi_domain_free_irqs_all'? [-Werror=implicit-function-declaration]
     327 |         irq_domain_free_irqs_common(domain, virq, nr_irqs);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         msi_domain_free_irqs_all
   cc1: some warnings being treated as errors


vim +/irq_domain_is_hierarchy +16 drivers/pci/msi/irqdomain.c

aa423ac4221abd Thomas Gleixner 2021-12-06  10  
aa423ac4221abd Thomas Gleixner 2021-12-06  11  int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
aa423ac4221abd Thomas Gleixner 2021-12-06  12  {
aa423ac4221abd Thomas Gleixner 2021-12-06  13  	struct irq_domain *domain;
aa423ac4221abd Thomas Gleixner 2021-12-06  14  
aa423ac4221abd Thomas Gleixner 2021-12-06  15  	domain = dev_get_msi_domain(&dev->dev);
aa423ac4221abd Thomas Gleixner 2021-12-06 @16  	if (domain && irq_domain_is_hierarchy(domain))
d3a11dee9f946d Thomas Gleixner 2022-11-25  17  		return msi_domain_alloc_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN, nvec);
aa423ac4221abd Thomas Gleixner 2021-12-06  18  
aa423ac4221abd Thomas Gleixner 2021-12-06  19  	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
aa423ac4221abd Thomas Gleixner 2021-12-06  20  }
aa423ac4221abd Thomas Gleixner 2021-12-06  21  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
