Return-Path: <linux-arch+bounces-8625-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6006B9B1C42
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 06:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D601C20AD4
	for <lists+linux-arch@lfdr.de>; Sun, 27 Oct 2024 05:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74EA39FF3;
	Sun, 27 Oct 2024 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jLIEyYQ8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A734545
	for <linux-arch@vger.kernel.org>; Sun, 27 Oct 2024 05:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730007675; cv=none; b=HnCvIAtP9QzJW8XAadnVSzNN8Ntq7xT4J/d/KCcdCqU3OsPP2Ci1Ixjkn2WLTp3Jy0buQ0RFw6PJfCvk2oUBm0otG/Tn8jwnJtVdTVerTVDIS5vJoX6Qy9dTiKbL0uJ8ap1L9jZTL5JOTzM5w2pHnex2bu03P8Oo7JSgcg8RlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730007675; c=relaxed/simple;
	bh=eQzHco7XbcnE5h8+2FLUi0C1jChSqRWsX3cElH3EZsM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lWOTNXJrwj/D8Mf353iANaIc1ZweoD4fGMx3MhmHb+tfPFZtBPmzNMZp9lLTlJf7bD9z/7ekOSfhyppd6fKAFZa50myFNC1/vbyEWZZS3GGToBo/coom6wX6a2+YcKEL/ef3GGMTOyLb7trMKKyUQ+koZ5URzM54mz91HKO1NnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jLIEyYQ8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730007673; x=1761543673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eQzHco7XbcnE5h8+2FLUi0C1jChSqRWsX3cElH3EZsM=;
  b=jLIEyYQ8pN3bL5k6oyrccsyeoZPdF4GJJ5ddfrnQUAGF6Mzot6rCiiNV
   /wFGFeQgb28m/UezgVSPNbVM0PRenx/waMpnQTUiR4kichXySDtRBC8jw
   NV6MRwypO3txlpf4MlmqxqkyxxQJUbGzepJ5GIAJLpV8Nr3F+YhLa72c1
   ipWSKWA4vRP6MmumTGjsU01fGRTlM9KkPSpwf9uqIUwdho74x/8kTt1QG
   Nmo0pVUr02XCtYLBGAjsraspIWaLj4cQZA/f0JdWulYcxVWcv1i0funQ8
   V2C0h0Vyp9ranDGAztf3x4XnoajaV3W9h9Q/xY/2LMlqbT48l7uN5Ephb
   A==;
X-CSE-ConnectionGUID: a9YxotsSROmEx+JhQV+O2w==
X-CSE-MsgGUID: sbrMM9UATq6oYl05PhHu+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29588706"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29588706"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 22:41:13 -0700
X-CSE-ConnectionGUID: 72EE6tlcQaOqglE3Qjoi3A==
X-CSE-MsgGUID: l6DTo9EYRuyKLjcMPDjisg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,236,1725346800"; 
   d="scan'208";a="86073763"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Oct 2024 22:41:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4w1U-000aPR-2Q;
	Sun, 27 Oct 2024 05:41:08 +0000
Date: Sun, 27 Oct 2024 13:40:52 +0800
From: kernel test robot <lkp@intel.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [arnd-asm-generic:master 6/12] include/asm-generic/io.h:596:15:
 error: call to '_outb' declared with attribute error: outb() requires
 CONFIG_HAS_IOPORT
Message-ID: <202410271353.43UzOIXC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   a6653736cdcedcb7c2c22ee0af0288a326a0e036
commit: afa7c814bff3a9aae82ebd8316d421eb9653e375 [6/12] asm-generic/io.h: Remove I/O port accessors for HAS_IOPORT=n
config: um-randconfig-r123-20241027 (https://download.01.org/0day-ci/archive/20241027/202410271353.43UzOIXC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241027/202410271353.43UzOIXC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410271353.43UzOIXC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/um/include/asm/io.h:24,
                    from include/linux/io.h:14,
                    from drivers/watchdog/sbc8360.c:49:
   In function 'sbc8360_stop',
       inlined from 'sbc8360_notify_sys' at drivers/watchdog/sbc8360.c:293:3:
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/watchdog/sbc8360.c:233:9: note: in expansion of macro 'outb'
     233 |         outb(0, SBC8360_ENABLE);
         |         ^~~~
   In function 'sbc8360_stop',
       inlined from 'sbc8360_close' at drivers/watchdog/sbc8360.c:276:3:
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/watchdog/sbc8360.c:233:9: note: in expansion of macro 'outb'
     233 |         outb(0, SBC8360_ENABLE);
         |         ^~~~
   In function 'sbc8360_ping',
       inlined from 'sbc8360_write' at drivers/watchdog/sbc8360.c:255:3:
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/watchdog/sbc8360.c:226:9: note: in expansion of macro 'outb'
     226 |         outb(wd_margin, SBC8360_BASETIME);
         |         ^~~~
   In function 'sbc8360_activate',
       inlined from 'sbc8360_open' at drivers/watchdog/sbc8360.c:268:2:
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/watchdog/sbc8360.c:212:9: note: in expansion of macro 'outb'
     212 |         outb(0x0A, SBC8360_ENABLE);
         |         ^~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/watchdog/sbc8360.c:214:9: note: in expansion of macro 'outb'
     214 |         outb(0x0B, SBC8360_ENABLE);
         |         ^~~~
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/watchdog/sbc8360.c:217:9: note: in expansion of macro 'outb'
     217 |         outb(wd_multiplier, SBC8360_ENABLE);
         |         ^~~~
   In function 'sbc8360_ping',
       inlined from 'sbc8360_open' at drivers/watchdog/sbc8360.c:269:2:
>> include/asm-generic/io.h:596:15: error: call to '_outb' declared with attribute error: outb() requires CONFIG_HAS_IOPORT
     596 | #define _outb _outb
   include/asm-generic/io.h:655:14: note: in expansion of macro '_outb'
     655 | #define outb _outb
         |              ^~~~~
   drivers/watchdog/sbc8360.c:226:9: note: in expansion of macro 'outb'
     226 |         outb(wd_margin, SBC8360_BASETIME);
         |         ^~~~


vim +/_outb +596 include/asm-generic/io.h

9216efafc52ff9 Thierry Reding  2014-10-01  594  
f009c89df79abe John Garry      2020-03-28  595  #if !defined(outb) && !defined(_outb)
f009c89df79abe John Garry      2020-03-28 @596  #define _outb _outb
afa7c814bff3a9 Niklas Schnelle 2024-10-24  597  #ifdef CONFIG_HAS_IOPORT
f009c89df79abe John Garry      2020-03-28  598  static inline void _outb(u8 value, unsigned long addr)
9216efafc52ff9 Thierry Reding  2014-10-01  599  {
a7851aa54c0cdd Sinan Kaya      2018-04-05  600  	__io_pbw();
a7851aa54c0cdd Sinan Kaya      2018-04-05  601  	__raw_writeb(value, PCI_IOBASE + addr);
a7851aa54c0cdd Sinan Kaya      2018-04-05  602  	__io_paw();
9216efafc52ff9 Thierry Reding  2014-10-01  603  }
afa7c814bff3a9 Niklas Schnelle 2024-10-24  604  #else
afa7c814bff3a9 Niklas Schnelle 2024-10-24  605  void _outb(u8 value, unsigned long addr)
afa7c814bff3a9 Niklas Schnelle 2024-10-24  606  	__compiletime_error("outb() requires CONFIG_HAS_IOPORT");
afa7c814bff3a9 Niklas Schnelle 2024-10-24  607  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  608  #endif
9216efafc52ff9 Thierry Reding  2014-10-01  609  

:::::: The code at line 596 was first introduced by commit
:::::: f009c89df79abea5f5244b8135a205f7d4352f86 io: Provide _inX() and _outX()

:::::: TO: John Garry <john.garry@huawei.com>
:::::: CC: Wei Xu <xuwei5@hisilicon.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

