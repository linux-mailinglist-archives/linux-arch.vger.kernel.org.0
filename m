Return-Path: <linux-arch+bounces-15091-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF98C8DCE3
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BAC3A1FA0
	for <lists+linux-arch@lfdr.de>; Thu, 27 Nov 2025 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E89329C5E;
	Thu, 27 Nov 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAvjUIxc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D3A2D73A8;
	Thu, 27 Nov 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239853; cv=none; b=dN0NJvVR0i4Vbdez762LyxxqA3MnxTU1+1aP4xrdsJq9EZVDbmsuJ25OjJFsa7rZR+7DDutWA7PlWWJIa2krxRBlYeBHb5a6xXpnW6ivNo+Kzq5agNiV43/NZ/5D2ULjTwgLqemN9ibJxd8EgacC1bQ2E3L14jzCLeQ0IjrWi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239853; c=relaxed/simple;
	bh=298HmZaKryM6YUgv6+BFvsUO13W/yAJhJzw3DpfAASo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pudDiZAUEu9tVf/A3FmUsHI8I0COTEY16vTtgd0WSpixwfwdBTWzza6PR+cTb1GOuYcjvpPey9CR9WnO+C5xbi2MIQjb09ZpYZZqrn7m3VWffau/okHsgJ+4xY8I98vOrE45bYq7E75aFyEOZG19HfPYN65obt2xviqk+epT9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAvjUIxc; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764239851; x=1795775851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=298HmZaKryM6YUgv6+BFvsUO13W/yAJhJzw3DpfAASo=;
  b=TAvjUIxcGFAWe/AOL4NIaUr2Qqxk0AULnz8B00P5GvPUMqsV8CPh6Ef2
   +x4B2RZ48q1QyEVeSw5enm4ac9sbrWThV5cBTVrpuXCEqcc8KFIz+JsZ9
   AkfN762UiMBlb2uWVrMoe3Rmxehq4bOMXupTb2/5+bT+USuDWsEGXCQSg
   RO20uek6SHXcQfhKY/BBxGBpGee98xOx57eS4Vfm1AjuxGfferOPO19m7
   wmBssG5dx/zD3LuuBiPeQjjfl1JF5MZG1WfdmY+M6+avQ/dk1v4oUQLSw
   uCK6TDl4rjJ4600EVVlB8F1az43wRiAMPG4gDEZJiJFh9jfvZAVwOQ4Re
   A==;
X-CSE-ConnectionGUID: LIMs9fY/RCWYUf4BvtvqyA==
X-CSE-MsgGUID: l41r6AWERYKgyNR4hSNuJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="70152327"
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="70152327"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2025 02:37:30 -0800
X-CSE-ConnectionGUID: PVw/j0thSQOqNYTgAo7j0g==
X-CSE-MsgGUID: YKIKj3LKRsiMpyIfcDMjDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,230,1758610800"; 
   d="scan'208";a="193422642"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Nov 2025 02:37:25 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOZNL-000000004XB-19Il;
	Thu, 27 Nov 2025 10:37:23 +0000
Date: Thu, 27 Nov 2025 18:36:48 +0800
From: kernel test robot <lkp@intel.com>
To: Anirudh Raybharam <anirudh@anirudhrb.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, Arnd Bergmann <arnd@arndb.de>,
	akpm@linux-foundation.org, agordeev@linux.ibm.com,
	guoweikang.kernel@gmail.com, osandov@fb.com, bsz@amazon.de,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] arm64: hyperv: move hyperv detection earlier in boot
Message-ID: <202511271709.lBS024jA-lkp@intel.com>
References: <20251125170124.2443340-2-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125170124.2443340-2-anirudh@anirudhrb.com>

Hi Anirudh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20251125]
[also build test WARNING on v6.18-rc7]
[cannot apply to arm64/for-next/core tip/irq/core arnd-asm-generic/master linus/master v6.18-rc7 v6.18-rc6 v6.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anirudh-Raybharam/arm64-hyperv-move-hyperv-detection-earlier-in-boot/20251126-011057
base:   next-20251125
patch link:    https://lore.kernel.org/r/20251125170124.2443340-2-anirudh%40anirudhrb.com
patch subject: [PATCH 1/3] arm64: hyperv: move hyperv detection earlier in boot
config: arm64-randconfig-003-20251127 (https://download.01.org/0day-ci/archive/20251127/202511271709.lBS024jA-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251127/202511271709.lBS024jA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511271709.lBS024jA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/mshyperv.h:66,
                    from arch/arm64/kernel/setup.c:57:
   include/asm-generic/mshyperv.h:326:38: error: return type is an incomplete type
     326 | static inline enum hv_isolation_type hv_get_isolation_type(void)
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/mshyperv.h: In function 'hv_get_isolation_type':
   include/asm-generic/mshyperv.h:328:9: error: 'HV_ISOLATION_TYPE_NONE' undeclared (first use in this function)
     328 |  return HV_ISOLATION_TYPE_NONE;
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/mshyperv.h:328:9: note: each undeclared identifier is reported only once for each function it appears in
>> include/asm-generic/mshyperv.h:328:9: warning: 'return' with a value, in function returning void [-Wreturn-type]
   include/asm-generic/mshyperv.h:326:38: note: declared here
     326 | static inline enum hv_isolation_type hv_get_isolation_type(void)
         |                                      ^~~~~~~~~~~~~~~~~~~~~


vim +/return +328 include/asm-generic/mshyperv.h

7ad9bb9d0f357d Wei Liu                  2021-09-10  289  
3817854ba89201 Nuno Das Neves           2025-03-14  290  #define _hv_status_fmt(fmt) "%s: Hyper-V status: %#x = %s: " fmt
3817854ba89201 Nuno Das Neves           2025-03-14  291  #define hv_status_printk(level, status, fmt, ...) \
3817854ba89201 Nuno Das Neves           2025-03-14  292  do { \
3817854ba89201 Nuno Das Neves           2025-03-14  293  	u64 __status = (status); \
3817854ba89201 Nuno Das Neves           2025-03-14  294  	pr_##level(_hv_status_fmt(fmt), __func__, hv_result(__status), \
3817854ba89201 Nuno Das Neves           2025-03-14  295  		   hv_result_to_string(__status), ##__VA_ARGS__); \
3817854ba89201 Nuno Das Neves           2025-03-14  296  } while (0)
3817854ba89201 Nuno Das Neves           2025-03-14  297  #define hv_status_err(status, fmt, ...) \
3817854ba89201 Nuno Das Neves           2025-03-14  298  	hv_status_printk(err, status, fmt, ##__VA_ARGS__)
3817854ba89201 Nuno Das Neves           2025-03-14  299  #define hv_status_debug(status, fmt, ...) \
3817854ba89201 Nuno Das Neves           2025-03-14  300  	hv_status_printk(debug, status, fmt, ##__VA_ARGS__)
3817854ba89201 Nuno Das Neves           2025-03-14  301  
3817854ba89201 Nuno Das Neves           2025-03-14  302  const char *hv_result_to_string(u64 hv_status);
9d8731a1757bef Nuno Das Neves           2025-02-21  303  int hv_result_to_errno(u64 status);
f3a99e761efa61 Tianyu Lan               2020-04-06  304  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
765e33f5211ab6 Michael Kelley           2019-05-30  305  bool hv_is_hyperv_initialized(void);
b96f86534fa310 Dexuan Cui               2019-11-19  306  bool hv_is_hibernation_supported(void);
a6c76bb08dc7f7 Andrea Parri (Microsoft  2021-02-01  307) enum hv_isolation_type hv_get_isolation_type(void);
a6c76bb08dc7f7 Andrea Parri (Microsoft  2021-02-01  308) bool hv_is_isolation_supported(void);
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25  309  bool hv_isolation_type_snp(void);
20c89a559e00df Tianyu Lan               2021-10-25  310  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
d6e0228d265f29 Dexuan Cui               2023-08-24  311  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
3e1b611515d286 Tianyu Lan               2025-09-18  312  void hv_enable_coco_interrupt(unsigned int cpu, unsigned int vector, bool set);
a156ad8c508209 Roman Kisel              2025-10-08  313  void hv_para_set_sint_proxy(bool enable);
e6eeb3c782739c Roman Kisel              2025-10-08  314  u64 hv_para_get_synic_register(unsigned int reg);
e6eeb3c782739c Roman Kisel              2025-10-08  315  void hv_para_set_synic_register(unsigned int reg, u64 val);
765e33f5211ab6 Michael Kelley           2019-05-30  316  void hyperv_cleanup(void);
6dc2a774cb4fdb Sunil Muthuswamy         2021-03-23  317  bool hv_query_ext_cap(u64 cap_query);
37200078ed6aa2 Michael Kelley           2022-03-24  318  void hv_setup_dma_ops(struct device *dev, bool coherent);
765e33f5211ab6 Michael Kelley           2019-05-30  319  #else /* CONFIG_HYPERV */
db912b8954c23a Nuno Das Neves           2025-02-21  320  static inline void hv_identify_partition_type(void) {}
765e33f5211ab6 Michael Kelley           2019-05-30  321  static inline bool hv_is_hyperv_initialized(void) { return false; }
b96f86534fa310 Dexuan Cui               2019-11-19  322  static inline bool hv_is_hibernation_supported(void) { return false; }
765e33f5211ab6 Michael Kelley           2019-05-30  323  static inline void hyperv_cleanup(void) {}
f2580a907e5c0e Michael Kelley           2024-03-18  324  static inline void ms_hyperv_late_init(void) {}
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25  325  static inline bool hv_is_isolation_supported(void) { return false; }
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25  326  static inline enum hv_isolation_type hv_get_isolation_type(void)
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25  327  {
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25 @328  	return HV_ISOLATION_TYPE_NONE;
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25  329  }
765e33f5211ab6 Michael Kelley           2019-05-30  330  #endif /* CONFIG_HYPERV */
765e33f5211ab6 Michael Kelley           2019-05-30  331  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

