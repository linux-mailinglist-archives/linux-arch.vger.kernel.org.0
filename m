Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5924F4847
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 02:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiDEVeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 17:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451550AbiDEPxd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 11:53:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A41C887B;
        Tue,  5 Apr 2022 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649170033; x=1680706033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+EigZUipNnJWpGEwCtYr5Ojb2vx0Lhl3QjD+kLrto9c=;
  b=lEBG1EioOZ1fNEBfWXG3HbRc9Cg+QzDRKbWqGnv8F3d1HHxyXBVtoG7y
   cggXcuUjy1tN14QpeaSfdYpohoyWAPVebglbvTjzxVxthvWAofq4f5Kkq
   UPLT5wBjc/QgJdT9HoDfPlUygN2PrBEiets53WmdC20H48XJcBzFlsOwZ
   U/9ssNdtEcLJfTJZeLsRvrQjpfm22UdD8hKFbLNlNImpOG1w+JFWXE7QJ
   /ourM7oXfHOgW0v4CIKuN3J3c5cfyBQLUyCzzQk6WYFwEuT8g7rLoFGCl
   2TF33cWNh5BaxZAyl6rM4P9K08j5mIfFojgYBELpb0mLPkEfo0YLhtcxG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="258349806"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="258349806"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 07:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="587952170"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 07:47:10 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbkSc-0003RQ-3s;
        Tue, 05 Apr 2022 14:47:10 +0000
Date:   Tue, 5 Apr 2022 22:46:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org, arnd@arndb.de
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] csky: optimize memcpy_{from,to}io() and memset_io()
Message-ID: <202204052238.Fz736aX3-lkp@intel.com>
References: <20220404144427.2793051-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404144427.2793051-1-guoren@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

I love your patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master linux/master v5.18-rc1 next-20220405]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/csky-optimize-memcpy_-from-to-io-and-memset_io/20220404-224954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: csky-randconfig-r022-20220405 (https://download.01.org/0day-ci/archive/20220405/202204052238.Fz736aX3-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2e50048555b298851590ec8272100b595b8801f9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review guoren-kernel-org/csky-optimize-memcpy_-from-to-io-and-memset_io/20220404-224954
        git checkout 2e50048555b298851590ec8272100b595b8801f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/bus/mhi/core/init.o: in function `mhi_prepare_for_power_up':
>> init.c:(.text+0xa50): undefined reference to `__memset_io'
>> csky-linux-ld: init.c:(.text+0xaa8): undefined reference to `__memset_io'
   csky-linux-ld: drivers/pci/pci-sysfs.o: in function `pci_read_rom':
>> pci-sysfs.c:(.text+0x2b8): undefined reference to `__memcpy_fromio'
>> csky-linux-ld: pci-sysfs.c:(.text+0x2f4): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_read':
   dpaa2-console.c:(.text+0xbc): undefined reference to `__memcpy_fromio'
   csky-linux-ld: dpaa2-console.c:(.text+0xee): undefined reference to `__memcpy_fromio'
   csky-linux-ld: dpaa2-console.c:(.text+0x16c): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/misc/hpilo.o: in function `ilo_ccb_close':
>> hpilo.c:(.text+0x204): undefined reference to `__memset_io'
   csky-linux-ld: drivers/misc/hpilo.o: in function `ilo_poll':
   hpilo.c:(.text+0x31c): undefined reference to `__memset_io'
   csky-linux-ld: drivers/misc/hpilo.o: in function `ilo_open':
>> hpilo.c:(.text+0xc3c): undefined reference to `__memcpy_toio'
>> csky-linux-ld: hpilo.c:(.text+0xd1c): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/scsi/smartpqi/smartpqi_init.o: in function `pqi_process_firmware_features':
>> smartpqi_init.c:(.text+0x3a92): undefined reference to `__memcpy_toio'
>> csky-linux-ld: smartpqi_init.c:(.text+0x3b30): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/scsi/smartpqi/smartpqi_init.o: in function `pqi_process_config_table':
>> smartpqi_init.c:(.text+0x3bda): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/scsi/smartpqi/smartpqi_init.o: in function `pqi_configure_events.constprop.0':
   smartpqi_init.c:(.text+0x3d68): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/scsi/hptiop.o: in function `mv_inbound_write':
>> hptiop.c:(.text+0x90e): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/scsi/hptiop.o: in function `hptiop_post_req_mv':
   hptiop.c:(.text+0x9b4): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/scsi/hptiop.o: in function `hptiop_request_callback_itl':
>> hptiop.c:(.text+0xa58): undefined reference to `__memcpy_fromio'
>> csky-linux-ld: hptiop.c:(.text+0xa88): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/scsi/hptiop.o: in function `iop_intr_mv':
   hptiop.c:(.text+0xd48): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/scsi/hptiop.o: in function `iop_intr_itl':
   hptiop.c:(.text+0xe10): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/scsi/hptiop.o: in function `iop_get_config_itl':
   hptiop.c:(.text+0x123a): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/scsi/hptiop.o: in function `iop_set_config_itl':
   hptiop.c:(.text+0x1278): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/scsi/hptiop.o: in function `dma_alloc_coherent.constprop.0':
   hptiop.c:(.text+0x12ec): undefined reference to `__memcpy_fromio'
>> csky-linux-ld: hptiop.c:(.text+0x12f0): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/net/wan/pc300too.o: in function `sca_rx_done':
>> pc300too.c:(.text+0xbfa): undefined reference to `__memcpy_fromio'
>> csky-linux-ld: pc300too.c:(.text+0xc64): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/net/wan/pc300too.o: in function `sca_xmit':
>> pc300too.c:(.text+0xd40): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/net/wan/pc300too.o: in function `sca_poll':
   pc300too.c:(.text+0xf30): undefined reference to `__memcpy_toio'
   csky-linux-ld: fs/pstore/ram_core.o: in function `persistent_ram_update':
>> ram_core.c:(.text+0x164): undefined reference to `__memcpy_toio'
>> csky-linux-ld: ram_core.c:(.text+0x18c): undefined reference to `__memcpy_toio'
   csky-linux-ld: fs/pstore/ram_core.o: in function `persistent_ram_save_old':
>> ram_core.c:(.text+0x4f2): undefined reference to `__memcpy_fromio'
   csky-linux-ld: ram_core.c:(.text+0x500): undefined reference to `__memcpy_fromio'
   csky-linux-ld: fs/pstore/ram_core.o: in function `persistent_ram_write_user':
   ram_core.c:(.text+0x5e0): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/scsi/sym53c8xx_2/sym_hipd.o: in function `sym_start_up':
   sym_hipd.c:(.text+0x3e3e): undefined reference to `__memcpy_toio'
   csky-linux-ld: sym_hipd.c:(.text+0x3e60): undefined reference to `__memcpy_toio'
   csky-linux-ld: sym_hipd.c:(.text+0x3fc8): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/remoteproc/remoteproc_coredump.o: in function `rproc_copy_segment':
   remoteproc_coredump.c:(.text+0xb8): undefined reference to `__memcpy_fromio'
   csky-linux-ld: remoteproc_coredump.c:(.text+0xd4): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/remoteproc/remoteproc_elf_loader.o: in function `rproc_elf_load_segments':
   remoteproc_elf_loader.c:(.text+0x328): undefined reference to `__memcpy_toio'
   csky-linux-ld: remoteproc_elf_loader.c:(.text+0x34c): undefined reference to `__memset_io'
   csky-linux-ld: remoteproc_elf_loader.c:(.text+0x378): undefined reference to `__memcpy_toio'
   csky-linux-ld: remoteproc_elf_loader.c:(.text+0x37c): undefined reference to `__memset_io'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
