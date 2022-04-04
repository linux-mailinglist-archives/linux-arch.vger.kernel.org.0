Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BD24F1413
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 13:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiDDLyN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDDLyM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 07:54:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110DA3D4AA;
        Mon,  4 Apr 2022 04:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649073136; x=1680609136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oqV7gY73z/9h3vqSQ08ThtD4hYrPjtGKUG8GBOqta/c=;
  b=kqC9ibCx7Ye4YFfqR6Nqmk//fazbWDRw/WOZKA8pKv9DdQiFkNE8Oq5a
   QH6wOnsmNztHJrE5yy37NaWtSfwymBPWZnGSvH6y9d7gkk1iXmLaiC+Wo
   Yi1p0vjglIp+RZO+9OC0MIvkj3Yuym4eMqIWSdaTnL8X6zevMyve14g6T
   gVdPvYpma/DUEQTobyVmECC9vq/KqEGtqs5vqETTcTJi1gCbe5+/qOHQB
   y69UXLJivXXIJZz8xbpdge3zijSuy1YXc4YLXAvverJRaoj8v901PklrF
   z+PExJGsfr6PWGVsc/XecICYB+kJELsOLlS8FC10u2QD4xEVItE2E9DQ4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260193700"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="260193700"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 04:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="641198149"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Apr 2022 04:52:13 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbLFk-00021d-Li;
        Mon, 04 Apr 2022 11:52:12 +0000
Date:   Mon, 4 Apr 2022 19:51:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 7/8] posix_types.h: add __kernel_uintptr_t to UAPI
 posix_types.h
Message-ID: <202204041932.AgusAQLn-lkp@intel.com>
References: <20220404061948.2111820-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-8-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Masahiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on davem-sparc/master linux/master v5.18-rc1 next-20220404]
[cannot apply to soc/for-next drm/drm-next powerpc/next uclinux-h8/h8300-next s390/features arnd-asm-generic/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220404/202204041932.AgusAQLn-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e8154d995f34b79843e473d85645fb543d554e7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/UAPI-make-more-exported-headers-self-contained-and-put-them-into-test-coverage/20220404-142226
        git checkout e8154d995f34b79843e473d85645fb543d554e7f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/misc/ sound/soc/fsl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from ./arch/nios2/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/nios2/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/misc/fastrpc.c:5:
   drivers/misc/fastrpc.c: In function 'fastrpc_req_munmap_impl':
>> drivers/misc/fastrpc.c:1639:30: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'uintptr_t' {aka 'unsigned int'} [-Wformat=]
    1639 |                 dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/misc/fastrpc.c:1639:17: note: in expansion of macro 'dev_dbg'
    1639 |                 dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
         |                 ^~~~~~~
   drivers/misc/fastrpc.c:1639:48: note: format string is defined here
    1639 |                 dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
         |                                            ~~~~^
         |                                                |
         |                                                long unsigned int
         |                                            %09x
   In file included from include/linux/device.h:15,
                    from drivers/misc/fastrpc.c:6:
   drivers/misc/fastrpc.c:1645:30: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'uintptr_t' {aka 'unsigned int'} [-Wformat=]
    1645 |                 dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/misc/fastrpc.c:1645:17: note: in expansion of macro 'dev_err'
    1645 |                 dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
         |                 ^~~~~~~
   drivers/misc/fastrpc.c:1645:48: note: format string is defined here
    1645 |                 dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
         |                                            ~~~~^
         |                                                |
         |                                                long unsigned int
         |                                            %09x
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from ./arch/nios2/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/nios2/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/misc/fastrpc.c:5:
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mmap':
   drivers/misc/fastrpc.c:1736:22: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'uintptr_t' {aka 'unsigned int'} [-Wformat=]
    1736 |         dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/misc/fastrpc.c:1736:9: note: in expansion of macro 'dev_dbg'
    1736 |         dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
         |         ^~~~~~~
   drivers/misc/fastrpc.c:1736:40: note: format string is defined here
    1736 |         dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
         |                                    ~~~~^
         |                                        |
         |                                        long unsigned int
         |                                    %09x
--
   sound/soc/fsl/imx-audmux.c: In function 'audmux_debugfs_init':
>> sound/soc/fsl/imx-audmux.c:148:50: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'uintptr_t' {aka 'unsigned int'} [-Wformat=]
     148 |                 snprintf(buf, sizeof(buf), "ssi%lu", i);
         |                                                ~~^   ~
         |                                                  |   |
         |                                                  |   uintptr_t {aka unsigned int}
         |                                                  long unsigned int
         |                                                %u


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
