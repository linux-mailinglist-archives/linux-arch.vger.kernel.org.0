Return-Path: <linux-arch+bounces-5054-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC6915ABF
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2024 01:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C03280DCF
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 23:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D519E7F4;
	Mon, 24 Jun 2024 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcOm6TGn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E14C6C
	for <linux-arch@vger.kernel.org>; Mon, 24 Jun 2024 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273216; cv=none; b=EBSPUKazzHaMJuLSVs1YMTuUjHvIjwdXSdItiA3ko/zPBs6HE63CKmoTbnGrW+J141STer8yJo0RRpdggB1xp5Ub9MuI4DSuIkS43LG2g8cyMr+2aLn01ceWTVVidiwc+5NI/+6yfl+SB2zB0REbhgN/h9nsrX50jF/j9F9jG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273216; c=relaxed/simple;
	bh=p35BkHilV2FjPspFUbtqHkKaRbuftrg9reUELzU5Tu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hRTTCtP8m8u/52Q86LebWbc6OS6sl6O++DKWASbLUw5cvRqgsE2Lbk8BxHvXOd5YNXklxr51hOCBOMriTEI6oSrgVw7uIkClOpvGOA0vcBNWtuDhdPVsE3P8eOx/bgeRFi8vry1vDaZ8i8MRlsu/0J0C4DsZDI7dHpnIx5Imrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcOm6TGn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719273214; x=1750809214;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p35BkHilV2FjPspFUbtqHkKaRbuftrg9reUELzU5Tu4=;
  b=hcOm6TGnlZXjaido8+ssZC2B9d0XXAMyPOIONMSmoWhl45GxeIIcItfc
   HA6fpAh2dw+aDbGcKK4L3MZCnUY5hrGNR6XqWegp8+gV7CWfdRDogwbai
   R0neOtwS8XlNa+YXYoq9DFpeV5Cg3gjfYoLpHX7PYmFW6LggpzySBbmKz
   UT3aGsUeRzbFcAujZmEAft2QzeJty1iF3mgCc20tnGq9+6nM3BMfgJwpn
   95lWnmxvgk07ubycNBazxXBi3lroLHJKx0mpePYnnXHg+BA2wlyotE4PO
   GJnWyWyonzuKsVDO+/mHjbnfP61dP5AUVOJ4SeA5QQ1zj7ZljEJZ0gai4
   w==;
X-CSE-ConnectionGUID: veJiZuGcQ1Kpv0hjcbGfEQ==
X-CSE-MsgGUID: YBAPHdUiSKO2DM/0ZnTa6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26892402"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="26892402"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 16:53:34 -0700
X-CSE-ConnectionGUID: 8ZU4Y2N0QJyTznzN2fV+lQ==
X-CSE-MsgGUID: +O6zOa/fQ7G5wG7htUDa5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43267385"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Jun 2024 16:53:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLtV5-000DpY-0C;
	Mon, 24 Jun 2024 23:53:31 +0000
Date: Tue, 25 Jun 2024 07:53:11 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org
Subject: [arnd-asm-generic:syscall-fixes-6.10 2/13]
 include/uapi/asm-generic/unistd.h:740:88: error: macro "__SYSCALL" passed 3
 arguments, but takes just 2
Message-ID: <202406250701.m5Umu4IL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git syscall-fixes-6.10
head:   f2548a9d6019f7ab1106a16893d65dea09b8909a
commit: a8b9dba1b47c8547c274255de3fe60e02f118fc6 [2/13] syscalls: fix compat_sys_io_pgetevents_time64 usage
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240625/202406250701.m5Umu4IL-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240625/202406250701.m5Umu4IL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406250701.m5Umu4IL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/openrisc/include/uapi/asm/unistd.h:30,
                    from <stdin>:2:
>> include/uapi/asm-generic/unistd.h:740:88: error: macro "__SYSCALL" passed 3 arguments, but takes just 2
     740 | __SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
         |                                                                                        ^
   include/uapi/asm-generic/unistd.h:16: note: macro "__SYSCALL" defined here
      16 | #define __SYSCALL(x, y)
         | 
   make[3]: *** [./Kbuild:44: missing-syscalls] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__SYSCALL +740 include/uapi/asm-generic/unistd.h

   713	
   714	#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
   715	#define __NR_clock_gettime64 403
   716	__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
   717	#define __NR_clock_settime64 404
   718	__SYSCALL(__NR_clock_settime64, sys_clock_settime)
   719	#define __NR_clock_adjtime64 405
   720	__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
   721	#define __NR_clock_getres_time64 406
   722	__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
   723	#define __NR_clock_nanosleep_time64 407
   724	__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
   725	#define __NR_timer_gettime64 408
   726	__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
   727	#define __NR_timer_settime64 409
   728	__SYSCALL(__NR_timer_settime64, sys_timer_settime)
   729	#define __NR_timerfd_gettime64 410
   730	__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
   731	#define __NR_timerfd_settime64 411
   732	__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
   733	#define __NR_utimensat_time64 412
   734	__SYSCALL(__NR_utimensat_time64, sys_utimensat)
   735	#define __NR_pselect6_time64 413
   736	__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
   737	#define __NR_ppoll_time64 414
   738	__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
   739	#define __NR_io_pgetevents_time64 416
 > 740	__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
   741	#define __NR_recvmmsg_time64 417
   742	__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
   743	#define __NR_mq_timedsend_time64 418
   744	__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
   745	#define __NR_mq_timedreceive_time64 419
   746	__SYSCALL(__NR_mq_timedreceive_time64, sys_mq_timedreceive)
   747	#define __NR_semtimedop_time64 420
   748	__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
   749	#define __NR_rt_sigtimedwait_time64 421
   750	__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
   751	#define __NR_futex_time64 422
   752	__SYSCALL(__NR_futex_time64, sys_futex)
   753	#define __NR_sched_rr_get_interval_time64 423
   754	__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
   755	#endif
   756	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

