Return-Path: <linux-arch+bounces-4349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE08C3932
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 01:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450BD1C20D82
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 23:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3089D58AD0;
	Sun, 12 May 2024 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+kIG/u+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A65914C
	for <linux-arch@vger.kernel.org>; Sun, 12 May 2024 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555928; cv=none; b=Wsdd1mn5zTPE/S1unfZpcx2ohQZLcmpVcSmRbqY22vPDYXIiMDew2ydZkac3/Mez8qXUvjaPHHwm6vX3cNJrOVpjcE/o9QUYbXFm9ET0Q7bCDWUjx0vV3/i2XQ3yPrSRHoMlC0J7R0NAhks+XRfST5lecva5tYCNS7ETIVV3GPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555928; c=relaxed/simple;
	bh=fzck0haix2xbIN3u2whvsy6Qxz7xvRas8Fs3C4bIKCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NzwcF64mY34OY8V5Cjm7MONOzQMs31pnxb5alKFeDizLWa+E9fJI54veWbjbrMDUNGKK3BioOKwm6jaAX9X4H2tjb3P/PIEL/ydAVviI1iwmOzvcVNo6hzquWyADz3V5t8+JiaflQq608FjC+o/w5sZXsPb4bx8ZreTcOPnY67k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+kIG/u+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715555926; x=1747091926;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fzck0haix2xbIN3u2whvsy6Qxz7xvRas8Fs3C4bIKCg=;
  b=Y+kIG/u+po/FlxXJuzMQdPleCXLXFhiEOYyYW6wpWQR2CW8wk+FM6aci
   m1EHNmZkM//St1da14fUkkEGYl5vyTETgGAhjRzHk0VNhM87B1Gi77tPA
   7JX5PkW2DkYD/NqvctkcPZeHdxsYfY2v4OtSe4BJnIATn+9iK29yjxbe4
   ONZaMcuNgm+F3z2pHgt0sLQbh3DVbeqgfZrbSmPdFp3vZp8iHHYhtWb31
   UfqKYH5A0sk47DaU/2N4GOtS+jcXzjZgu9mr+WJJpgYggx0rIgGmEOOuQ
   k5Beeu5aKkt9oEGLmtE9EhY6wfrxWQWen0O2NkysyGgupweHWspqK22wJ
   Q==;
X-CSE-ConnectionGUID: G6BobXRSTrKXA/6c3Gdoew==
X-CSE-MsgGUID: tKIldqumQfeY1JWft9zQWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22624623"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="22624623"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 16:18:44 -0700
X-CSE-ConnectionGUID: wGmqb6umTG2SeG2/67iWyA==
X-CSE-MsgGUID: phINNd9sS2KlaVF52zu7mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30239271"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 May 2024 16:18:42 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6ISm-0009Hp-1k;
	Sun, 12 May 2024 23:18:40 +0000
Date: Mon, 13 May 2024 07:17:28 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-tbl-6.9 46/46]
 arch/arm64/include/asm/vdso/compat_gettimeofday.h:27:31: error: use of
 undeclared identifier '__NR_compat32_gettimeofday'
Message-ID: <202405130739.4E0Jd9gx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-tbl-6.9
head:   e0d7a2fe9b74052a280531e773ebaba59e2d523f
commit: e0d7a2fe9b74052a280531e773ebaba59e2d523f [46/46] arm64: use generic syscall table generation rules
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20240513/202405130739.4E0Jd9gx-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240513/202405130739.4E0Jd9gx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405130739.4E0Jd9gx-lkp@intel.com/

All errors (new ones prefixed by >>):

   unifdef: usr/include/asm-generic/unistd.h.tmp: 7: unterminated char literal
   unifdef: output may be truncated
   make[3]: *** [scripts/Makefile.headersinst:63: usr/include/asm-generic/unistd.h] Error 1
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   make[3]: Target '__headers' not remade because of errors.
   make[2]: *** [Makefile:1293: headers] Error 2
   In file included from arch/arm64/kernel/asm-offsets.c:10:
   In file included from include/linux/arm_sdei.h:8:
   In file included from include/acpi/ghes.h:5:
   In file included from include/acpi/apei.h:9:
   In file included from include/linux/acpi.h:39:
   In file included from include/acpi/acpi_io.h:7:
   In file included from arch/arm64/include/asm/acpi.h:14:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:508:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     509 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:515:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     515 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     516 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:527:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     527 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     528 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:536:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     536 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     537 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   5 warnings generated.
   In file included from <built-in>:3:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:149:
>> arch/arm64/include/asm/vdso/compat_gettimeofday.h:27:31: error: use of undeclared identifier '__NR_compat32_gettimeofday'
      27 |         register long nr asm("r7") = __NR_compat32_gettimeofday;
         |                                      ^
>> arch/arm64/include/asm/vdso/compat_gettimeofday.h:44:31: error: use of undeclared identifier '__NR_compat32_clock_gettime64'
      44 |         register long nr asm("r7") = __NR_compat32_clock_gettime64;
         |                                      ^
>> arch/arm64/include/asm/vdso/compat_gettimeofday.h:61:31: error: use of undeclared identifier '__NR_compat32_clock_gettime'
      61 |         register long nr asm("r7") = __NR_compat32_clock_gettime;
         |                                      ^
>> arch/arm64/include/asm/vdso/compat_gettimeofday.h:78:31: error: use of undeclared identifier '__NR_compat32_clock_getres_time64'
      78 |         register long nr asm("r7") = __NR_compat32_clock_getres_time64;
         |                                      ^
>> arch/arm64/include/asm/vdso/compat_gettimeofday.h:95:31: error: use of undeclared identifier '__NR_compat32_clock_getres'
      95 |         register long nr asm("r7") = __NR_compat32_clock_getres;
         |                                      ^
   5 errors generated.
   make[3]: *** [arch/arm64/kernel/vdso32/Makefile:146: arch/arm64/kernel/vdso32/vgettimeofday.o] Error 1
   make[3]: Target 'arch/arm64/kernel/vdso32/vdso.so' not remade because of errors.
   make[2]: *** [arch/arm64/Makefile:199: vdso_prepare] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__NR_compat32_gettimeofday +27 arch/arm64/include/asm/vdso/compat_gettimeofday.h

33a58980ff3cc5 Thomas Gleixner   2019-07-28   19  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   20  static __always_inline
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   21  int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   22  			  struct timezone *_tz)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   23  {
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   24  	register struct timezone *tz asm("r1") = _tz;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   25  	register struct __kernel_old_timeval *tv asm("r0") = _tv;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   26  	register long ret asm ("r0");
56921b57d82d74 Arnd Bergmann     2024-05-08  @27  	register long nr asm("r7") = __NR_compat32_gettimeofday;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   28  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   29  	asm volatile(
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   30  	"	swi #0\n"
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   31  	: "=r" (ret)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   32  	: "r" (tv), "r" (tz), "r" (nr)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   33  	: "memory");
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   34  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   35  	return ret;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   36  }
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   37  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   38  static __always_inline
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   39  long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   40  {
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   41  	register struct __kernel_timespec *ts asm("r1") = _ts;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   42  	register clockid_t clkid asm("r0") = _clkid;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   43  	register long ret asm ("r0");
56921b57d82d74 Arnd Bergmann     2024-05-08  @44  	register long nr asm("r7") = __NR_compat32_clock_gettime64;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   45  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   46  	asm volatile(
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   47  	"	swi #0\n"
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   48  	: "=r" (ret)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   49  	: "r" (clkid), "r" (ts), "r" (nr)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   50  	: "memory");
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   51  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   52  	return ret;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   53  }
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   54  
33a58980ff3cc5 Thomas Gleixner   2019-07-28   55  static __always_inline
33a58980ff3cc5 Thomas Gleixner   2019-07-28   56  long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
33a58980ff3cc5 Thomas Gleixner   2019-07-28   57  {
33a58980ff3cc5 Thomas Gleixner   2019-07-28   58  	register struct old_timespec32 *ts asm("r1") = _ts;
33a58980ff3cc5 Thomas Gleixner   2019-07-28   59  	register clockid_t clkid asm("r0") = _clkid;
33a58980ff3cc5 Thomas Gleixner   2019-07-28   60  	register long ret asm ("r0");
56921b57d82d74 Arnd Bergmann     2024-05-08  @61  	register long nr asm("r7") = __NR_compat32_clock_gettime;
33a58980ff3cc5 Thomas Gleixner   2019-07-28   62  
33a58980ff3cc5 Thomas Gleixner   2019-07-28   63  	asm volatile(
33a58980ff3cc5 Thomas Gleixner   2019-07-28   64  	"	swi #0\n"
33a58980ff3cc5 Thomas Gleixner   2019-07-28   65  	: "=r" (ret)
33a58980ff3cc5 Thomas Gleixner   2019-07-28   66  	: "r" (clkid), "r" (ts), "r" (nr)
33a58980ff3cc5 Thomas Gleixner   2019-07-28   67  	: "memory");
33a58980ff3cc5 Thomas Gleixner   2019-07-28   68  
33a58980ff3cc5 Thomas Gleixner   2019-07-28   69  	return ret;
33a58980ff3cc5 Thomas Gleixner   2019-07-28   70  }
33a58980ff3cc5 Thomas Gleixner   2019-07-28   71  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   72  static __always_inline
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   73  int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   74  {
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   75  	register struct __kernel_timespec *ts asm("r1") = _ts;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   76  	register clockid_t clkid asm("r0") = _clkid;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   77  	register long ret asm ("r0");
56921b57d82d74 Arnd Bergmann     2024-05-08  @78  	register long nr asm("r7") = __NR_compat32_clock_getres_time64;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   79  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   80  	asm volatile(
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   81  	"       swi #0\n"
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   82  	: "=r" (ret)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   83  	: "r" (clkid), "r" (ts), "r" (nr)
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   84  	: "memory");
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   85  
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   86  	return ret;
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   87  }
a7f71a2c8903f8 Vincenzo Frascino 2019-06-21   88  
33a58980ff3cc5 Thomas Gleixner   2019-07-28   89  static __always_inline
33a58980ff3cc5 Thomas Gleixner   2019-07-28   90  int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
33a58980ff3cc5 Thomas Gleixner   2019-07-28   91  {
33a58980ff3cc5 Thomas Gleixner   2019-07-28   92  	register struct old_timespec32 *ts asm("r1") = _ts;
33a58980ff3cc5 Thomas Gleixner   2019-07-28   93  	register clockid_t clkid asm("r0") = _clkid;
33a58980ff3cc5 Thomas Gleixner   2019-07-28   94  	register long ret asm ("r0");
56921b57d82d74 Arnd Bergmann     2024-05-08  @95  	register long nr asm("r7") = __NR_compat32_clock_getres;
33a58980ff3cc5 Thomas Gleixner   2019-07-28   96  
33a58980ff3cc5 Thomas Gleixner   2019-07-28   97  	asm volatile(
33a58980ff3cc5 Thomas Gleixner   2019-07-28   98  	"       swi #0\n"
33a58980ff3cc5 Thomas Gleixner   2019-07-28   99  	: "=r" (ret)
33a58980ff3cc5 Thomas Gleixner   2019-07-28  100  	: "r" (clkid), "r" (ts), "r" (nr)
33a58980ff3cc5 Thomas Gleixner   2019-07-28  101  	: "memory");
33a58980ff3cc5 Thomas Gleixner   2019-07-28  102  
33a58980ff3cc5 Thomas Gleixner   2019-07-28  103  	return ret;
33a58980ff3cc5 Thomas Gleixner   2019-07-28  104  }
33a58980ff3cc5 Thomas Gleixner   2019-07-28  105  

:::::: The code at line 27 was first introduced by commit
:::::: 56921b57d82d74e6e7433932f8b33a52ca7e6977 arm64: rework compat syscall macros

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@arndb.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

