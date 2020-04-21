Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4C1B2C67
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgDUQRJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 12:17:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:55926 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgDUQRJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 12:17:09 -0400
IronPort-SDR: X8qZqP2KAnPQURDobRYcRpVlCzf127nkLrDDS5kH4Qxsbst2RDGAN2iAiG7MI62Xc3l2kk6ILr
 rwLvu/vrIPVA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 09:17:07 -0700
IronPort-SDR: XALjvezF56ivcRHV0d/2zCurfffdMTEr3JadGE4uHkEhGYH5+nmnaQKf2REvk5qbSQcrs9K95G
 UrMnIwFqOosQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="gz'50?scan'50,208,50";a="300653614"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2020 09:17:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jQvZy-000EMx-CQ; Wed, 22 Apr 2020 00:16:58 +0800
Date:   Wed, 22 Apr 2020 00:16:12 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kbuild@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kbuild@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Leon Romanovsky <leonro@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: split MODULE_ARCH_VERMAGIC definitions out to
 <asm/vermagic.h>
Message-ID: <202004220013.Ji0JcrHY%lkp@intel.com>
References: <20200419222804.483191-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <20200419222804.483191-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.7-rc2 next-20200421]
[cannot apply to arm/for-next arm64/for-next/core ia64/next powerpc/next jeyu/modules-next arc/for-next tip/x86/core]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/arch-split-MODULE_ARCH_VERMAGIC-definitions-out-to-asm-vermagic-h/20200421-194238
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ae83d0b416db002fe95601e7f97f64b59514d936
config: openrisc-simple_smp_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/vermagic.h:6,
                    from net/ethtool/ioctl.c:20:
>> ./arch/openrisc/include/generated/asm/vermagic.h:1:10: fatal error: asm-generic/vermagic.h: No such file or directory
       1 | #include <asm-generic/vermagic.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--liOOAslEiF7prFVr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
EZUBaKoaOSpsnfsX9jT+HwYugJ++eQAA

--liOOAslEiF7prFVr--
