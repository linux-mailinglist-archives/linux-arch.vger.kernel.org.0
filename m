Return-Path: <linux-arch+bounces-10598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CBCA57FC4
	for <lists+linux-arch@lfdr.de>; Sun,  9 Mar 2025 00:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DF63AD3DC
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 23:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B542C2FA;
	Sat,  8 Mar 2025 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1Q6wvn/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73F17C77
	for <linux-arch@vger.kernel.org>; Sat,  8 Mar 2025 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741475504; cv=none; b=Gc336RfAunpuSBKIHgMTgQJVHzpEOny727VH0WszH72at325vR1X5o85PWHxL3SfP3jPF4dULIU2O1xiB/P8dUQOwd3BDS5m8e6FtJbWYsODrLU+rhkPrspLPAv4eZrx03mqIp3kjjOIFfI2G7Z/pkhrIxPLxhGTrskYDm91F8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741475504; c=relaxed/simple;
	bh=H1xLV8PUIVgl87SBWr8mG/hzImGywz8EaDqCCB0y4rA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=trUUjFNCJ4zUDgIMKfo4QCgpPTuC/5RruxqojdCBu6Nv2UEXJU4rQou/XKPtp+HHbfOJwG6v5WOdiZSKWjDfOqG+pfgitEr2tB8gGdaZ8LauotMJb2AsvOdjQmC4WACfKKcKbuvI9NbczE6M8jxnSXznKgLjH1Eryq9NARp3qKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1Q6wvn/; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741475502; x=1773011502;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=H1xLV8PUIVgl87SBWr8mG/hzImGywz8EaDqCCB0y4rA=;
  b=U1Q6wvn/BefEftLjaZ1MizzrGBb+8VTtCACUTTi68YYNUG/vv8nd5ZRm
   zbhDNVLgi0zvG70tL+nbOHHnfJJe+gLOajFh5EI5oHamFGiAuMNskBMML
   FqykcbmnsPtHL/jM2t9eHDZKWPv3R8y2LPTkTiEjHtK4oI8QS8YWxoWrj
   qsCinmkpZg1+YdMwfsV/Uk4XaF1wdGAZ5KCy72S60mO0pH9rZRzNm/WFX
   NNQW8jzlI2e5F2wGLOGE+Kf9bxq43kE0JgFLq0qa0WK75kZq9xUbmUehm
   wYQTBkPfFggQhZsOf8ghRK4fXpkbxOnY+iP3gS9DBCH4d56lO9OQUueM2
   A==;
X-CSE-ConnectionGUID: +C65lCoxRH6+E6OmWiNgDQ==
X-CSE-MsgGUID: 1IohXSFwTxiL4qPgGSc+iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="46416235"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="46416235"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 15:11:41 -0800
X-CSE-ConnectionGUID: Zb2xpZrdQ+qe8Y/aJRY4EA==
X-CSE-MsgGUID: 0hLQ37MFT0yOQLd+kzrMaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124656672"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 08 Mar 2025 15:11:40 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tr3KT-0002Qx-2b;
	Sat, 08 Mar 2025 23:11:37 +0000
Date: Sun, 9 Mar 2025 07:10:59 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:master 4/4] include/asm-generic/io.h:878:18:
 error: conflicting types for 'ioread64'; have 'u64(const void *)' {aka 'long
 long unsigned int(const void *)'}
Message-ID: <202503090739.34zIgOk9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
head:   51d1826adbe1b018cf4ba8120dc04848d88438e6
commit: 51d1826adbe1b018cf4ba8120dc04848d88438e6 [4/4] alpha: fix ioread64/iowrite64 macros
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20250309/202503090739.34zIgOk9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503090739.34zIgOk9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503090739.34zIgOk9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/alpha/include/asm/io.h:644,
                    from arch/alpha/kernel/io.c:10:
>> include/asm-generic/io.h:878:18: error: conflicting types for 'ioread64'; have 'u64(const void *)' {aka 'long long unsigned int(const void *)'}
     878 | #define ioread64 ioread64
         |                  ^~~~~~~~
   arch/alpha/kernel/io.c:44:5: note: in expansion of macro 'ioread64'
      44 | u64 ioread64(const void __iomem *addr)
         |     ^~~~~~~~
   include/asm-generic/io.h:878:18: note: previous definition of 'ioread64' with type 'u64(const volatile void *)' {aka 'long long unsigned int(const volatile void *)'}
     878 | #define ioread64 ioread64
         |                  ^~~~~~~~
   include/asm-generic/io.h:879:19: note: in expansion of macro 'ioread64'
     879 | static inline u64 ioread64(const volatile void __iomem *addr)
         |                   ^~~~~~~~
>> include/asm-generic/io.h:912:19: error: conflicting types for 'iowrite64'; have 'void(u64,  void *)' {aka 'void(long long unsigned int,  void *)'}
     912 | #define iowrite64 iowrite64
         |                   ^~~~~~~~~
   arch/alpha/kernel/io.c:71:6: note: in expansion of macro 'iowrite64'
      71 | void iowrite64(u64 b, void __iomem *addr)
         |      ^~~~~~~~~
   include/asm-generic/io.h:912:19: note: previous definition of 'iowrite64' with type 'void(u64,  volatile void *)' {aka 'void(long long unsigned int,  volatile void *)'}
     912 | #define iowrite64 iowrite64
         |                   ^~~~~~~~~
   include/asm-generic/io.h:913:20: note: in expansion of macro 'iowrite64'
     913 | static inline void iowrite64(u64 value, volatile void __iomem *addr)
         |                    ^~~~~~~~~


vim +878 include/asm-generic/io.h

9216efafc52ff99 Thierry Reding 2014-10-01  875  
9e44fb1816dba8f Horia Geantă   2016-05-19  876  #ifdef CONFIG_64BIT
9e44fb1816dba8f Horia Geantă   2016-05-19  877  #ifndef ioread64
9e44fb1816dba8f Horia Geantă   2016-05-19 @878  #define ioread64 ioread64
9e44fb1816dba8f Horia Geantă   2016-05-19  879  static inline u64 ioread64(const volatile void __iomem *addr)
9e44fb1816dba8f Horia Geantă   2016-05-19  880  {
9e44fb1816dba8f Horia Geantă   2016-05-19  881  	return readq(addr);
9e44fb1816dba8f Horia Geantă   2016-05-19  882  }
9e44fb1816dba8f Horia Geantă   2016-05-19  883  #endif
9e44fb1816dba8f Horia Geantă   2016-05-19  884  #endif /* CONFIG_64BIT */
9e44fb1816dba8f Horia Geantă   2016-05-19  885  
9216efafc52ff99 Thierry Reding 2014-10-01  886  #ifndef iowrite8
9216efafc52ff99 Thierry Reding 2014-10-01  887  #define iowrite8 iowrite8
9216efafc52ff99 Thierry Reding 2014-10-01  888  static inline void iowrite8(u8 value, volatile void __iomem *addr)
9216efafc52ff99 Thierry Reding 2014-10-01  889  {
9216efafc52ff99 Thierry Reding 2014-10-01  890  	writeb(value, addr);
9216efafc52ff99 Thierry Reding 2014-10-01  891  }
9216efafc52ff99 Thierry Reding 2014-10-01  892  #endif
9216efafc52ff99 Thierry Reding 2014-10-01  893  
9216efafc52ff99 Thierry Reding 2014-10-01  894  #ifndef iowrite16
9216efafc52ff99 Thierry Reding 2014-10-01  895  #define iowrite16 iowrite16
9216efafc52ff99 Thierry Reding 2014-10-01  896  static inline void iowrite16(u16 value, volatile void __iomem *addr)
9216efafc52ff99 Thierry Reding 2014-10-01  897  {
9216efafc52ff99 Thierry Reding 2014-10-01  898  	writew(value, addr);
9216efafc52ff99 Thierry Reding 2014-10-01  899  }
9216efafc52ff99 Thierry Reding 2014-10-01  900  #endif
9216efafc52ff99 Thierry Reding 2014-10-01  901  
9216efafc52ff99 Thierry Reding 2014-10-01  902  #ifndef iowrite32
9216efafc52ff99 Thierry Reding 2014-10-01  903  #define iowrite32 iowrite32
9216efafc52ff99 Thierry Reding 2014-10-01  904  static inline void iowrite32(u32 value, volatile void __iomem *addr)
9216efafc52ff99 Thierry Reding 2014-10-01  905  {
9216efafc52ff99 Thierry Reding 2014-10-01  906  	writel(value, addr);
9216efafc52ff99 Thierry Reding 2014-10-01  907  }
9216efafc52ff99 Thierry Reding 2014-10-01  908  #endif
9216efafc52ff99 Thierry Reding 2014-10-01  909  
9e44fb1816dba8f Horia Geantă   2016-05-19  910  #ifdef CONFIG_64BIT
9e44fb1816dba8f Horia Geantă   2016-05-19  911  #ifndef iowrite64
9e44fb1816dba8f Horia Geantă   2016-05-19 @912  #define iowrite64 iowrite64
9e44fb1816dba8f Horia Geantă   2016-05-19  913  static inline void iowrite64(u64 value, volatile void __iomem *addr)
9e44fb1816dba8f Horia Geantă   2016-05-19  914  {
9e44fb1816dba8f Horia Geantă   2016-05-19  915  	writeq(value, addr);
9e44fb1816dba8f Horia Geantă   2016-05-19  916  }
9e44fb1816dba8f Horia Geantă   2016-05-19  917  #endif
9e44fb1816dba8f Horia Geantă   2016-05-19  918  #endif /* CONFIG_64BIT */
9e44fb1816dba8f Horia Geantă   2016-05-19  919  

:::::: The code at line 878 was first introduced by commit
:::::: 9e44fb1816dba8f283809a25c29ff7969a3acb99 asm-generic/io.h: add io{read,write}64 accessors

:::::: TO: Horia Geantă <horia.geanta@nxp.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

