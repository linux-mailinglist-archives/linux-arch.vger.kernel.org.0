Return-Path: <linux-arch+bounces-12792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D510B068CD
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 23:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9D9503B36
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE05D2BEC53;
	Tue, 15 Jul 2025 21:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRBQJFp4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38B84039;
	Tue, 15 Jul 2025 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616013; cv=none; b=sOtKErHTar9Movltt9LpGnAES2Dn+XmnM33BpVzjtWn2Zf+hBhZyIBQANacceyHWdNvAN6+WTdV3R19gH+fmZ+6G4ChYf9R/OS81sfbR5VE0AHn5xqw9NkB6uT7axrqDH3+cWY+p5oNquTv07JAsAA0xvSx7v3e7bJ4QmHUAi9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616013; c=relaxed/simple;
	bh=/fbCXxYG9LmNT4xAvtTpUg70myuhYb1fO1TUkt6+IOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+iMmGee40EYSrmsK8Ao2CtLH2MefdJsxlASrPOdqmEQhnxFZmV3FYRO+lOFlEfwBvlW3wMCTNesecXKMbI44D8YMw05qNoFqHLvXicZud+nepFlf0IIY5TRVc5/iOdH5KeQbHAYdsQHsViaP5StTfVzt4LnAzp5SJxfBuJprJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRBQJFp4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752616011; x=1784152011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/fbCXxYG9LmNT4xAvtTpUg70myuhYb1fO1TUkt6+IOw=;
  b=RRBQJFp4QtvpYckGmQkXWMbN0waoqqkJGX9G/2E4+zq13xO/2wKZXwTJ
   61i1eRRR3yICfyoyhzrV0Qpl2WjiPkQDfrd2I7+3iwd+gY4iJI72DVtYv
   CXw8WRqUHC89UTy63459ebfIfHU6tbb9KEVg5Kst3Co+bExuS6KIt3WlW
   EIEnM655pYweVWSGIRGEsK0uMQF8DOZJruRynazpNmAz79AiklTKOzwMo
   2QDF804mlDie4uIFAsTbPRtAld8Z0F+xgaWpDRAB5GM3bVJjn2ryr+LDV
   EVTCYQfsf3dCnGxOKNfFEnirwud04ZlrlPgYm4w4Rgka11yZhCDFDJfa+
   Q==;
X-CSE-ConnectionGUID: WTY8K1dZS0mEIDeg5U8suw==
X-CSE-MsgGUID: EGS1IiWATuSjb1gRiWVeWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58505084"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="58505084"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 14:46:50 -0700
X-CSE-ConnectionGUID: G7AsTZjkRAOl3IiMQnNgVg==
X-CSE-MsgGUID: 85Y0TFLdSmSHhlAnOFaMBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="161876101"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Jul 2025 14:46:45 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubnU2-000BaB-0T;
	Tue, 15 Jul 2025 21:46:42 +0000
Date: Wed, 16 Jul 2025 05:46:34 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>, alok.a.tiwari@oracle.com,
	arnd@arndb.de, bp@alien8.de, corbet@lwn.net,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mhklinux@outlook.com, mingo@redhat.com, rdunlap@infradead.org,
	tglx@linutronix.de, Tianyu.Lan@microsoft.com, wei.liu@kernel.org,
	linux-arch@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v4 05/16] Drivers: hv: Rename fields for
 SynIC message and event pages
Message-ID: <202507160553.amoW6Ty0-lkp@intel.com>
References: <20250714221545.5615-6-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714221545.5615-6-romank@linux.microsoft.com>

Hi Roman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d9016a249be5316ec2476f9947356711e70a16ec]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kisel/Documentation-hyperv-Confidential-VMBus/20250715-062125
base:   d9016a249be5316ec2476f9947356711e70a16ec
patch link:    https://lore.kernel.org/r/20250714221545.5615-6-romank%40linux.microsoft.com
patch subject: [PATCH hyperv-next v4 05/16] Drivers: hv: Rename fields for SynIC message and event pages
config: i386-randconfig-061-20250715 (https://download.01.org/0day-ci/archive/20250716/202507160553.amoW6Ty0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160553.amoW6Ty0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160553.amoW6Ty0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/hv/hv.c:280:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hv/hv.c:299:26: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hv/hv.c:361:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *hyp_synic_message_page @@
   drivers/hv/hv.c:361:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hv/hv.c:361:31: sparse:     got void *hyp_synic_message_page
>> drivers/hv/hv.c:373:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *hyp_synic_event_page @@
   drivers/hv/hv.c:373:31: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hv/hv.c:373:31: sparse:     got void *hyp_synic_event_page

vim +361 drivers/hv/hv.c

   334	
   335	void hv_synic_disable_regs(unsigned int cpu)
   336	{
   337		struct hv_per_cpu_context *hv_cpu =
   338			per_cpu_ptr(hv_context.cpu_context, cpu);
   339		union hv_synic_sint shared_sint;
   340		union hv_synic_simp simp;
   341		union hv_synic_siefp siefp;
   342		union hv_synic_scontrol sctrl;
   343	
   344		shared_sint.as_uint64 = hv_get_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT);
   345	
   346		shared_sint.masked = 1;
   347	
   348		/* Need to correctly cleanup in the case of SMP!!! */
   349		/* Disable the interrupt */
   350		hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
   351	
   352		simp.as_uint64 = hv_get_msr(HV_MSR_SIMP);
   353		/*
   354		 * In Isolation VM, sim and sief pages are allocated by
   355		 * paravisor. These pages also will be used by kdump
   356		 * kernel. So just reset enable bit here and keep page
   357		 * addresses.
   358		 */
   359		simp.simp_enabled = 0;
   360		if (ms_hyperv.paravisor_present || hv_root_partition()) {
 > 361			iounmap(hv_cpu->hyp_synic_message_page);
   362			hv_cpu->hyp_synic_message_page = NULL;
   363		} else {
   364			simp.base_simp_gpa = 0;
   365		}
   366	
   367		hv_set_msr(HV_MSR_SIMP, simp.as_uint64);
   368	
   369		siefp.as_uint64 = hv_get_msr(HV_MSR_SIEFP);
   370		siefp.siefp_enabled = 0;
   371	
   372		if (ms_hyperv.paravisor_present || hv_root_partition()) {
 > 373			iounmap(hv_cpu->hyp_synic_event_page);
   374			hv_cpu->hyp_synic_event_page = NULL;
   375		} else {
   376			siefp.base_siefp_gpa = 0;
   377		}
   378	
   379		hv_set_msr(HV_MSR_SIEFP, siefp.as_uint64);
   380	
   381		/* Disable the global synic bit */
   382		sctrl.as_uint64 = hv_get_msr(HV_MSR_SCONTROL);
   383		sctrl.enable = 0;
   384		hv_set_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
   385	
   386		if (vmbus_irq != -1)
   387			disable_percpu_irq(vmbus_irq);
   388	}
   389	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

