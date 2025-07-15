Return-Path: <linux-arch+bounces-12788-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5F5B0656A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 19:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631381AA3FBF
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1F289831;
	Tue, 15 Jul 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgVSePaI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F701289375;
	Tue, 15 Jul 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602367; cv=none; b=PDj81tHZ6kJxu6ggjYt1LCW4QSrrQmKFmnvdWC7sQxfVcII0ylsQDJ5JvMRC8iM+14YrBpLprJZyNvQ04WZBJKtphIi9AUhh3+lERggAEuwS7coWnf4fN7i2FUG0se6IwJj8ZCxgHAJl7628f0wdm93qVk16k3gGmVSIPrakk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602367; c=relaxed/simple;
	bh=pGWjgJnPdhc6fxanyYZ44FtDswTCW9PE9eD1cW30BAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GePeyNBtlfpaC0N/WTekde58t1h9wTLkzjlpr6r/ZIAXYv6rlarLuBAH+oeKm6bJ3wG9gfKt6g20DORW36Umj3EEkt62moQpJydvfUjXDVTAI991C9aClAeeLI0LYlHdm+gyxQVQvzgoagqw5bcAWS40pYOMncM1qzlcxrYAM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgVSePaI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752602365; x=1784138365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pGWjgJnPdhc6fxanyYZ44FtDswTCW9PE9eD1cW30BAE=;
  b=IgVSePaIrZ5zYk+ADsYR3JY8anq2cDIeU6whcrDWCzFiECvbXoF70yhw
   g8ZdbfmO3u+NjWl06maQ2fQa++/TCtugkqghTPUI+hvshLcG+Nbpw80mF
   wdo/MJaqTM9s1WkRraqBeRyrj8o0MiYLAyp3ZeMfvqW6Zu0IMMAtDzc1n
   thTr6vlRtYbS4oGXLJyEltuKwaYrVcR8aiK78BYnCvEv736i9S6TLLTvr
   epY5Je63pVCaxS8mJ2AAQ9ZSsBt0m8ObhE7uAsFC5izLMtUuqJfrq08ic
   tHCcF6wyv64jUoiLQGLwgfP1ac0OTLYLPbOWqPlme2APW5s61NuJoyEmz
   A==;
X-CSE-ConnectionGUID: HS8wq2aPQK+L/V/Xj8/0ag==
X-CSE-MsgGUID: tWcPbZHqQ9ugnc6Iahpg1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58488313"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58488313"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:59:25 -0700
X-CSE-ConnectionGUID: zbQificGQ6SQHgfamneVcA==
X-CSE-MsgGUID: Nr8pyyslSZW3SyFUOS5XWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="161838950"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Jul 2025 10:59:19 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubjvw-000BPn-01;
	Tue, 15 Jul 2025 17:59:16 +0000
Date: Wed, 16 Jul 2025 01:58:36 +0800
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
Subject: Re: [PATCH hyperv-next v4 04/16] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Message-ID: <202507160105.yQ34bnKl-lkp@intel.com>
References: <20250714221545.5615-5-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714221545.5615-5-romank@linux.microsoft.com>

Hi Roman,

kernel test robot noticed the following build errors:

[auto build test ERROR on d9016a249be5316ec2476f9947356711e70a16ec]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kisel/Documentation-hyperv-Confidential-VMBus/20250715-062125
base:   d9016a249be5316ec2476f9947356711e70a16ec
patch link:    https://lore.kernel.org/r/20250714221545.5615-5-romank%40linux.microsoft.com
patch subject: [PATCH hyperv-next v4 04/16] arch/x86: mshyperv: Trap on access for some synthetic MSRs
config: x86_64-buildonly-randconfig-002-20250715 (https://download.01.org/0day-ci/archive/20250716/202507160105.yQ34bnKl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160105.yQ34bnKl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160105.yQ34bnKl-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `hv_set_non_nested_msr':
>> arch/x86/kernel/cpu/mshyperv.c:91: undefined reference to `vmbus_is_confidential'


vim +91 arch/x86/kernel/cpu/mshyperv.c

    79	
    80	void hv_set_non_nested_msr(unsigned int reg, u64 value)
    81	{
    82		if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
    83			/* The hypervisor will get the intercept. */
    84			hv_ivm_msr_write(reg, value);
    85	
    86			if (hv_is_sint_msr(reg)) {
    87				/*
    88				 * Write proxy bit in the case of non-confidential VMBus.
    89				 * Using wrmsrq instruction so the following goes to the paravisor.
    90				 */
  > 91				u32 proxy = vmbus_is_confidential() ? 0 : 1;
    92	
    93				value |= (proxy << 20);
    94				native_wrmsrq(reg, value);
    95			}
    96		} else {
    97			native_wrmsrq(reg, value);
    98		}
    99	}
   100	EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
   101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

