Return-Path: <linux-arch+bounces-15079-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8DEC87365
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 22:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4558E4E5539
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 21:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9ED2FBE03;
	Tue, 25 Nov 2025 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2YXELGz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1F2FB0BC;
	Tue, 25 Nov 2025 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764105623; cv=none; b=sHPCfSiaZ94AsNh2iFpXOMWrCRyQYevzJoTxWX7OUF3WwbUfHKdZPS0e2efX7BowBv9UGI91jIsbGd2q20DIYiQYuI8cPSK3gJVQtPNNLqTtYPx2F5zkJOdO7bfwdEZSTLxk4AoEjoHqVqjo50RpEPEiMV84oQ9fdqizUcZzfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764105623; c=relaxed/simple;
	bh=3eMZ/MfM5RHhwJQ7d0IQHir4UVOOL7Et7y72tZ0G6FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVhYqhuCk+u6TjU/h6m7u6qLGoRXO2M88NVQWTD76FMp2qIpJAGIKD+TEV+0IgB0/7g2OdQNzCwKUCD7Uz5yUK/DiLQwAHNQ1Hwu+9RmgdSBnbgT+t2UR54IkWhvgZJOtHoBy8IhbKsUFFjYq7LpwtLZMyOw5M9uycsoNAZME50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2YXELGz; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764105622; x=1795641622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3eMZ/MfM5RHhwJQ7d0IQHir4UVOOL7Et7y72tZ0G6FI=;
  b=i2YXELGzRtZ7aHkIjTp4sJk9J9MzR30dEN2JXL58s0wRAlnaR7V8juOJ
   NeQ03em1sagRC1/BEXBwi3jBMzwfTdpY6qAP3KzTiIl1V9a5ltqLwC3Vf
   uuf3nwm/ojmuukX5h1lSBgdskGEijFV+w1yQxbKKX5P3dpeKstByhxiNZ
   8EhdsyoB/KlpfDOA15rXN55SqftFLXRgTaLPoM7RcSEwixvFm/X3kdcji
   dRNtRYYH0Q/p3d5FbTuRo6p2u14lxhd36qWndQP/IK/e3khSPfD7FbmM+
   bkReccy5XfA92XuAoy2w3SnJ1huWZ9RB7XFNfj8ndX56IJapwQ4CYlu/4
   g==;
X-CSE-ConnectionGUID: iYWJv6P0Q82qkUb61AWuTw==
X-CSE-MsgGUID: 2iNLX7n1TmaJNR2855P9+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66167345"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="66167345"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 13:20:21 -0800
X-CSE-ConnectionGUID: +bze+cwnTKGwewcZ8/D4nA==
X-CSE-MsgGUID: 24lLGtmWRNuYvDsvao4o3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="196911755"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 13:20:16 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vO0SM-000000002Gz-0eIn;
	Tue, 25 Nov 2025 21:20:14 +0000
Date: Wed, 26 Nov 2025 05:19:14 +0800
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
Message-ID: <202511260546.RGx7vwyX-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251125]
[also build test ERROR on v6.18-rc7]
[cannot apply to arm64/for-next/core tip/irq/core arnd-asm-generic/master linus/master v6.18-rc7 v6.18-rc6 v6.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anirudh-Raybharam/arm64-hyperv-move-hyperv-detection-earlier-in-boot/20251126-011057
base:   next-20251125
patch link:    https://lore.kernel.org/r/20251125170124.2443340-2-anirudh%40anirudhrb.com
patch subject: [PATCH 1/3] arm64: hyperv: move hyperv detection earlier in boot
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20251126/202511260546.RGx7vwyX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251126/202511260546.RGx7vwyX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511260546.RGx7vwyX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/include/asm/mshyperv.h:66,
                    from arch/arm64/kernel/setup.c:57:
>> include/asm-generic/mshyperv.h:326:38: error: return type is an incomplete type
     326 | static inline enum hv_isolation_type hv_get_isolation_type(void)
         |                                      ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/mshyperv.h: In function 'hv_get_isolation_type':
>> include/asm-generic/mshyperv.h:328:16: error: 'HV_ISOLATION_TYPE_NONE' undeclared (first use in this function)
     328 |         return HV_ISOLATION_TYPE_NONE;
         |                ^~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/mshyperv.h:328:16: note: each undeclared identifier is reported only once for each function it appears in
>> include/asm-generic/mshyperv.h:328:16: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
   include/asm-generic/mshyperv.h:326:38: note: declared here
     326 | static inline enum hv_isolation_type hv_get_isolation_type(void)
         |                                      ^~~~~~~~~~~~~~~~~~~~~


vim +326 include/asm-generic/mshyperv.h

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
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25 @326  static inline enum hv_isolation_type hv_get_isolation_type(void)
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25  327  {
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25 @328  	return HV_ISOLATION_TYPE_NONE;
0cc4f6d9f0b9f2 Tianyu Lan               2021-10-25  329  }
765e33f5211ab6 Michael Kelley           2019-05-30  330  #endif /* CONFIG_HYPERV */
765e33f5211ab6 Michael Kelley           2019-05-30  331  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

