Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1358AC3C2
	for <lists+linux-arch@lfdr.de>; Sat,  7 Sep 2019 02:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393550AbfIGAyg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Sep 2019 20:54:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:41831 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732615AbfIGAyg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Sep 2019 20:54:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 17:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,474,1559545200"; 
   d="gz'50?scan'50,208,50";a="199645947"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2019 17:54:32 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i6Ozn-000H21-WE; Sat, 07 Sep 2019 08:54:31 +0800
Date:   Sat, 7 Sep 2019 08:54:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@01.org, linux-arch@vger.kernel.org
Subject: [asm-generic:ipc-fixes-5.3 2/2] sys_sparc_64.c:undefined reference
 to `ksys_semtimedop'
Message-ID: <201909070800.pxPxw4gg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cftw5cpsi5pxe5zn"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--cftw5cpsi5pxe5zn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/arnd/asm-generic.git ipc-fixes-5.3
head:   d3eb82fa8fb30ca3ad57e33c127a4b38aaf8f9e6
commit: d3eb82fa8fb30ca3ad57e33c127a4b38aaf8f9e6 [2/2] ipc: fix sparc64 ipc() wrapper
config: sparc64-allnoconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d3eb82fa8fb30ca3ad57e33c127a4b38aaf8f9e6
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/sparc/kernel/sys_sparc_64.o: In function `__se_sys_sparc_ipc':
>> sys_sparc_64.c:(.text+0x724): undefined reference to `ksys_semtimedop'
>> sys_sparc_64.c:(.text+0x76c): undefined reference to `ksys_old_msgctl'
>> sys_sparc_64.c:(.text+0x7a8): undefined reference to `ksys_semget'
>> sys_sparc_64.c:(.text+0x7c8): undefined reference to `ksys_old_semctl'
>> sys_sparc_64.c:(.text+0x7e4): undefined reference to `ksys_msgsnd'
>> sys_sparc_64.c:(.text+0x7fc): undefined reference to `ksys_shmget'
>> sys_sparc_64.c:(.text+0x808): undefined reference to `ksys_shmdt'
   sys_sparc_64.c:(.text+0x828): undefined reference to `ksys_semtimedop'
>> sys_sparc_64.c:(.text+0x844): undefined reference to `ksys_old_shmctl'
>> sys_sparc_64.c:(.text+0x858): undefined reference to `ksys_msgget'
>> sys_sparc_64.c:(.text+0x86c): undefined reference to `ksys_msgrcv'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cftw5cpsi5pxe5zn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--cftw5cpsi5pxe5zn--
