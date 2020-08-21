Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117FF24CF02
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 09:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHUHR5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 03:17:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:27836 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgHUHRU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 03:17:20 -0400
IronPort-SDR: ME25rkXR0WKCGnAzYVDu1sf5kmv6m9qEzjZ/9nrAZEwiWkSkhgHB5VXzbhtn7TQZqubJCP4fwI
 QQj5QfxGxPhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="153081895"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="gz'50?scan'50,208,50";a="153081895"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 00:17:18 -0700
IronPort-SDR: LqgiHPEqEjLBFsWFYAzRWmq5Z4aJbhfgZ4pNu4Dvxhg2b5LuE4pgUMpJaEEJ/8c5SLtQEOWsg9
 AN55TK8dwCRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="gz'50?scan'50,208,50";a="278847464"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2020 00:17:15 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k91IZ-0000jv-3J; Fri, 21 Aug 2020 07:17:15 +0000
Date:   Fri, 21 Aug 2020 15:17:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: Re: [PATCH v5 8/8] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <202008211553.jglH5Nul%lkp@intel.com>
References: <20200821044427.736424-9-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20200821044427.736424-9-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicholas,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on arm64/for-next/core tip/x86/mm linus/master v5.9-rc1]
[cannot apply to hnaz-linux-mm/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/huge-vmalloc-mappings/20200821-124543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: riscv-allnoconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: mm/page_alloc.o: in function `.L1578':
>> page_alloc.c:(.init.text+0x11a4): undefined reference to `find_vm_area'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ibTvN161/egqYuK8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ibTvN161/egqYuK8--
