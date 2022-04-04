Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4364F1578
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349247AbiDDNHO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 09:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349194AbiDDNHN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 09:07:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3013F9B;
        Mon,  4 Apr 2022 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649077517; x=1680613517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpMYCfde85sh/66ugKEnZNtNPom49Jb6tJDgfq2nsdk=;
  b=ZJU9xlvBGroD1ZW37BhbcVP8MEGckhAMfQh4hcXgYaiJUc6T0ewP1wHh
   zomN5DUhfHo4gMNg1O/m3noipdDXbt6U7vVWAx20kGSeTIpMCj2ufIahM
   C/vvsWisbf6/7sbQmxwJJiboWZ3iepv4vZxoHy+azBodHjqQP++dotHYL
   bLOhsNCPxhVpy1DZstkS7TZWrDyihjH9YXwSh8bWyH1P8LfPaCETYZSSS
   4Jy0CPNwL5mf6lHcwRre7lfj2D3/n0jGdsjshoD6ZgtO90i7mn2dpz7RW
   Tfjocv4d+x2YLXsHltXf2bu3/qNUmdXX+fmF/uBfJozSpYV5oSplnfkYH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="242650042"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="242650042"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="721639506"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Apr 2022 06:05:14 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbMOQ-00024D-2b;
        Mon, 04 Apr 2022 13:05:14 +0000
Date:   Mon, 4 Apr 2022 21:04:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 7/8] posix_types.h: add __kernel_uintptr_t to UAPI
 posix_types.h
Message-ID: <202204042058.5Kr6q6YX-lkp@intel.com>
References: <20220404061948.2111820-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-8-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on linux/master v5.18-rc1 next-20220404]
[cannot apply to soc/for-next drm/drm-next powerpc/next uclinux-h8/h8300-next s390/features arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
config: arm-randconfig-r016-20220404 (https://download.01.org/0day-ci/archive/20220404/202204042058.5Kr6q6YX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/e8154d995f34b79843e473d85645fb543d554e7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
        git checkout e8154d995f34b79843e473d85645fb543d554e7f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/misc/ sound/soc/fsl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/fastrpc.c:1639:43: warning: format specifies type 'unsigned long' but the argument has type 'uintptr_t' (aka 'unsigned int') [-Wformat]
                   dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
                                              ~~~~~        ^~~~~~~~~~
                                              %09x
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   drivers/misc/fastrpc.c:1645:46: warning: format specifies type 'unsigned long' but the argument has type 'uintptr_t' (aka 'unsigned int') [-Wformat]
                   dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
                                              ~~~~~           ^~~~~~~~~~
                                              %09x
   include/linux/dev_printk.h:144:65: note: expanded from macro 'dev_err'
           dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                  ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   drivers/misc/fastrpc.c:1737:3: warning: format specifies type 'unsigned long' but the argument has type 'uintptr_t' (aka 'unsigned int') [-Wformat]
                   buf->raddr, buf->size);
                   ^~~~~~~~~~
   include/linux/dev_printk.h:163:47: note: expanded from macro 'dev_dbg'
                   dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:129:34: note: expanded from macro 'dev_printk'
                   _dev_printk(level, dev, fmt, ##__VA_ARGS__);            \
                                           ~~~    ^~~~~~~~~~~
   3 warnings generated.
--
>> sound/soc/fsl/imx-audmux.c:148:40: warning: format specifies type 'unsigned long' but the argument has type 'uintptr_t' (aka 'unsigned int') [-Wformat]
                   snprintf(buf, sizeof(buf), "ssi%lu", i);
                                                  ~~~   ^
                                                  %u
   1 warning generated.


vim +1639 drivers/misc/fastrpc.c

6c16fd8bdd4058 Jeya R              2022-02-14  1604  
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1605  static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1606  				   struct fastrpc_req_munmap *req)
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1607  {
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1608  	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1609  	struct fastrpc_buf *buf, *b;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1610  	struct fastrpc_munmap_req_msg req_msg;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1611  	struct device *dev = fl->sctx->dev;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1612  	int err;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1613  	u32 sc;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1614  
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1615  	spin_lock(&fl->lock);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1616  	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1617  		if ((buf->raddr == req->vaddrout) && (buf->size == req->size))
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1618  			break;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1619  		buf = NULL;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1620  	}
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1621  	spin_unlock(&fl->lock);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1622  
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1623  	if (!buf) {
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1624  		dev_err(dev, "mmap not in list\n");
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1625  		return -EINVAL;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1626  	}
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1627  
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1628  	req_msg.pgid = fl->tgid;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1629  	req_msg.size = buf->size;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1630  	req_msg.vaddr = buf->raddr;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1631  
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1632  	args[0].ptr = (u64) (uintptr_t) &req_msg;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1633  	args[0].length = sizeof(req_msg);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1634  
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1635  	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1636  	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1637  				      &args[0]);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1638  	if (!err) {
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09 @1639  		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1640  		spin_lock(&fl->lock);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1641  		list_del(&buf->node);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1642  		spin_unlock(&fl->lock);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1643  		fastrpc_buf_free(buf);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1644  	} else {
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1645  		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1646  	}
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1647  
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1648  	return err;
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1649  }
2419e55e532de1 Jorge Ramirez-Ortiz 2019-10-09  1650  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
