Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAA4F43F9
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 00:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbiDENY5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Apr 2022 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379577AbiDELlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Apr 2022 07:41:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A21A3BB;
        Tue,  5 Apr 2022 03:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649156228; x=1680692228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6wvRk7VHAMl/TnyqPrVEEVDPoFVFwLe5+Khs3jMmwas=;
  b=bYAZPMrtmcnGByEJtQ+SELmg3oDgiX1O4z4P2bRFYLK5gKgQfKj97Ohc
   /piztIIkFyYUVs54lvxMEhNIkcGrzRjB4qIdpqbH7A7JSKXaIl+ogNKVT
   k2V4mZP2i4WAxDgBkqd26hqJD19gTUJ6pUiQ1AmX9pMQHdNxVU++v+irf
   6FqWP00XditWhsdWj5itRgNG3MKiK13oOGGResA/zUPHTI/mUCro4PoYj
   3S8H8IgDRCax0aHYta/PJjMyrnFtN5AlsqB+xTN6vRNp0rNtTlLKPFPts
   50hrH1+2ti0EV3qbbdA+LVXI2GGCR5Zw3L8U4CnzhBoKAERFgbA/rLw20
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="285678809"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="285678809"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 03:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="523414728"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2022 03:57:05 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbgrw-000364-HN;
        Tue, 05 Apr 2022 10:57:04 +0000
Date:   Tue, 5 Apr 2022 18:56:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org, arnd@arndb.de
Cc:     kbuild-all@lists.01.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] csky: optimize memcpy_{from,to}io() and memset_io()
Message-ID: <202204051859.sUrlh86t-lkp@intel.com>
References: <20220404144427.2793051-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404144427.2793051-1-guoren@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: csky-randconfig-r034-20220405 (https://download.01.org/0day-ci/archive/20220405/202204051859.sUrlh86t-lkp@intel.com/config)
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
>> init.c:(.text+0xfaa): undefined reference to `__memset_io'
>> csky-linux-ld: init.c:(.text+0x1028): undefined reference to `__memset_io'
   csky-linux-ld: drivers/pci/pci-sysfs.o: in function `pci_read_rom':
   pci-sysfs.c:(.text+0x3a6): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/pci/pci-sysfs.o: in function `pci_write_config':
   pci-sysfs.c:(.text+0x534): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/pci/switch/switchtec.o: in function `io_string_show':
   switchtec.c:(.text+0x7a2): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/pci/switch/switchtec.o: in function `vendor_id_show':
   switchtec.c:(.text+0x89c): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/pci/switch/switchtec.o: in function `mrpc_cmd_submit.part.0':
   switchtec.c:(.text+0x1c64): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/pci/switch/switchtec.o: in function `switchtec_dev_write':
   switchtec.c:(.text+0x1dbc): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/pci/switch/switchtec.o: in function `mrpc_complete_cmd':
   switchtec.c:(.text+0x1f78): undefined reference to `__memcpy_fromio'
   csky-linux-ld: switchtec.c:(.text+0x1f8c): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_read':
   dpaa2-console.c:(.text+0xd8): undefined reference to `__memcpy_fromio'
   csky-linux-ld: dpaa2-console.c:(.text+0x112): undefined reference to `__memcpy_fromio'
   csky-linux-ld: dpaa2-console.c:(.text+0x1b0): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/misc/sram.o: in function `sram_write':
   sram.c:(.text+0xa8): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/misc/sram.o: in function `sram_read':
   sram.c:(.text+0xe8): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/misc/sram.o: in function `kmalloc_array.constprop.0':
   sram.c:(.text+0x15c): undefined reference to `__memcpy_toio'
   csky-linux-ld: sram.c:(.text+0x164): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/ntb/test/ntb_tool.o: in function `tool_peer_mw_write':
>> ntb_tool.c:(.text+0xee6): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/ntb/test/ntb_tool.o: in function `tool_peer_mw_read':
   ntb_tool.c:(.text+0xf70): undefined reference to `__memcpy_toio'
>> csky-linux-ld: ntb_tool.c:(.text+0xf7c): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/ntb/test/ntb_tool.o: in function `ntb_peer_port_number':
>> ntb_tool.c:(.text+0x1018): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/ntb/test/ntb_perf.o: in function `perf_copy_chunk':
>> ntb_perf.c:(.text+0x20ca): undefined reference to `__memcpy_toio'
>> csky-linux-ld: ntb_perf.c:(.text+0x211c): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/ntb/ntb_transport.o: in function `ntb_memcpy_tx':
>> ntb_transport.c:(.text+0x9ba): undefined reference to `__memcpy_toio'
>> csky-linux-ld: ntb_transport.c:(.text+0xa04): undefined reference to `__memcpy_toio'
   csky-linux-ld: sound/pci/rme96.o: in function `snd_rme96_capture_copy_kernel':
>> rme96.c:(.text+0x74e): undefined reference to `__memcpy_fromio'
   csky-linux-ld: sound/pci/rme96.o: in function `snd_rme96_capture_copy':
   rme96.c:(.text+0x784): undefined reference to `__memcpy_fromio'
   csky-linux-ld: sound/pci/rme96.o: in function `snd_rme96_playback_copy_kernel':
>> rme96.c:(.text+0x87e): undefined reference to `__memcpy_toio'
   csky-linux-ld: sound/pci/rme96.o: in function `snd_rme96_playback_silence':
>> rme96.c:(.text+0x8c6): undefined reference to `__memset_io'
>> csky-linux-ld: rme96.c:(.text+0x8f4): undefined reference to `__memcpy_toio'
>> csky-linux-ld: rme96.c:(.text+0x8fc): undefined reference to `__memset_io'
   csky-linux-ld: sound/soc/fsl/fsl_xcvr.o: in function `irq0_isr':
>> fsl_xcvr.c:(.text+0x52c): undefined reference to `__memcpy_fromio'
>> csky-linux-ld: fsl_xcvr.c:(.text+0x546): undefined reference to `__memcpy_fromio'
>> csky-linux-ld: fsl_xcvr.c:(.text+0x588): undefined reference to `__memset_io'
   csky-linux-ld: fsl_xcvr.c:(.text+0x6a4): undefined reference to `__memcpy_fromio'
   csky-linux-ld: fsl_xcvr.c:(.text+0x6ac): undefined reference to `__memset_io'
   csky-linux-ld: fsl_xcvr.c:(.text+0x6f2): undefined reference to `__memcpy_fromio'
   csky-linux-ld: fsl_xcvr.c:(.text+0x72c): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/dma/ti/edma.o: in function `edma_write_slot':
   edma.c:(.text+0x158): undefined reference to `__memcpy_toio'
   csky-linux-ld: edma.c:(.text+0x174): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/dma/ti/edma.o: in function `dma_ccerr_handler':
   edma.c:(.text+0x24c8): undefined reference to `__memcpy_fromio'
>> csky-linux-ld: edma.c:(.text+0x2548): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/tty/serial/jsm/jsm_neo.o: in function `neo_copy_data_from_queue_to_uart':
>> jsm_neo.c:(.text+0x624): undefined reference to `__memcpy_toio'
>> csky-linux-ld: jsm_neo.c:(.text+0x69c): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/tty/serial/jsm/jsm_neo.o: in function `neo_copy_data_from_uart_to_queue':
   jsm_neo.c:(.text+0x8ce): undefined reference to `__memcpy_fromio'
   csky-linux-ld: jsm_neo.c:(.text+0x93a): undefined reference to `__memcpy_fromio'
   csky-linux-ld: jsm_neo.c:(.text+0x960): undefined reference to `__memcpy_fromio'
   csky-linux-ld: jsm_neo.c:(.text+0x9fe): undefined reference to `__memcpy_fromio'
   csky-linux-ld: jsm_neo.c:(.text+0xa94): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_copy_fw_to_device':
   firmware_if.c:(.text+0x106): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/misc/habanalabs/common/firmware_if.o: in function `usleep_range':
   firmware_if.c:(.text+0x130): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_static_init_cpu':
   firmware_if.c:(.text+0xafa): undefined reference to `__memcpy_fromio'
   csky-linux-ld: firmware_if.c:(.text+0xb60): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_read_preboot_status':
   firmware_if.c:(.text+0x2208): undefined reference to `__memcpy_fromio'
   csky-linux-ld: firmware_if.c:(.text+0x2290): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_dynamic_request_descriptor':
   firmware_if.c:(.text.unlikely+0x530): undefined reference to `__memcpy_fromio'
   csky-linux-ld: drivers/misc/habanalabs/common/firmware_if.o:firmware_if.c:(.text.unlikely+0x628): more undefined references to `__memcpy_fromio' follow
   csky-linux-ld: drivers/misc/habanalabs/common/firmware_if.o: in function `hl_fw_dynamic_send_msg.constprop.0':
   firmware_if.c:(.text.unlikely+0x7dc): undefined reference to `__memcpy_toio'
   csky-linux-ld: firmware_if.c:(.text.unlikely+0x86c): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/misc/habanalabs/goya/goya.o: in function `goya_pqe_write':
   goya.c:(.text+0x3148): undefined reference to `__memcpy_toio'
   csky-linux-ld: drivers/misc/habanalabs/goya/goya.o: in function `goya_get_dma_desc_list_size':
   goya.c:(.text+0x3240): undefined reference to `__memcpy_toio'
   csky-linux-ld: sound/core/memory.o: in function `copy_to_user_fromio':
   memory.c:(.text+0x6e): undefined reference to `__memcpy_fromio'
   csky-linux-ld: sound/core/memory.o: in function `copy_from_user_toio':
   memory.c:(.text+0x116): undefined reference to `__memcpy_toio'
   csky-linux-ld: memory.c:(.text+0x14c): undefined reference to `__memcpy_fromio'
   csky-linux-ld: memory.c:(.text+0x15c): undefined reference to `__memcpy_toio'
   csky-linux-ld: sound/pci/mixart/mixart_core.o: in function `get_msg.constprop.0':
   mixart_core.c:(.text+0x29c): undefined reference to `__memcpy_fromio'
   csky-linux-ld: mixart_core.c:(.text+0x310): undefined reference to `__memcpy_fromio'
   csky-linux-ld: sound/pci/mixart/mixart_hwdep.o: in function `mixart_dsp_load':
   mixart_hwdep.c:(.text+0x538): undefined reference to `__memcpy_toio'
   csky-linux-ld: mixart_hwdep.c:(.text+0x59c): undefined reference to `__memcpy_toio'
   csky-linux-ld: mixart_hwdep.c:(.text+0x67e): undefined reference to `__memcpy_toio'
   csky-linux-ld: mixart_hwdep.c:(.text+0x710): undefined reference to `__memcpy_toio'
   csky-linux-ld: mixart_hwdep.c:(.text+0x776): undefined reference to `__memcpy_toio'
   csky-linux-ld: sound/pci/mixart/mixart_hwdep.o:mixart_hwdep.c:(.text+0x888): more undefined references to `__memcpy_toio' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
