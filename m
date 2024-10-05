Return-Path: <linux-arch+bounces-7713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E09913D8
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 03:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE131F23C27
	for <lists+linux-arch@lfdr.de>; Sat,  5 Oct 2024 01:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5B1798F;
	Sat,  5 Oct 2024 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ao9Py+r1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799D322B;
	Sat,  5 Oct 2024 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728093300; cv=none; b=Kyf2Kz+0c6mjJmSZcCLeWL+zoe0Aj+wx0thBtSt2jz+HN4dOzvC5ZjH6V841r86M13+wnhOqVZHn+8BaoXiAIb9EGvurZkK5Uk0FIit8Hi4yyCPz52IsOrNmv4eFu+CYYFhUS9BTyekxIAKOPMikAorF53rZts74gUIvgI9LbXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728093300; c=relaxed/simple;
	bh=uXRVWVG114f3/9yWUkqrx/Xg92Pkui3oaEXL/RgQMY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT5vbHRdk5aMLReESBncPhzpJISpE0mK83YWlV2C/Kn4jtQBRmhvjhu6rHrd1Rd6KVUF7S7ia+ueRzLAuzwoS9GTTw3x2KYtq37PLrU3WyX6P7AMsoNmaAs3lKqNJweHrIdP8wd/sr/5kwTCI5EfXOn43Nv2zQr9t5FtcWMuRU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ao9Py+r1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728093297; x=1759629297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uXRVWVG114f3/9yWUkqrx/Xg92Pkui3oaEXL/RgQMY0=;
  b=Ao9Py+r1zsvQ36BTg4jeQNu1LdJdPrT9tLQw0sa09Nx2hfY9SfFXFztf
   3lnpkUGczFQWXuV6b7zUfAR5Q8nmp+1IzGnKfaSLKYhB0Q3YWY9wi3uK9
   7/9EFM6xvBKZVspMXIQVTdg2gXbvZvYKaUpPpqe9UDLKSDH6k9qM1XesU
   cW0B888mANCNAOVxkuOwZajP7AHlMYKUHVyUPXKo8uuJUjRn3xepwxhbr
   oiJl0S/C1QJsqZn8PxfRylVFnGKiWuU1Hg+zVR2ApXRuZxE1KlOYmfzBD
   cDgT3tfjBDKbuRBGqfnU/IaVIHi+vY9jQf29WIb2myVLO5cI+YBuFIc4d
   w==;
X-CSE-ConnectionGUID: pT5H4Li2S6eMNXxq3wAOxA==
X-CSE-MsgGUID: ymvFZxSAQiWyx9sk6lW+kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="30209802"
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="30209802"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 18:54:56 -0700
X-CSE-ConnectionGUID: dq26sFVKRNOHr4dJL9jIYA==
X-CSE-MsgGUID: pHBLfBJjQk2TiDi2g3fVEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,179,1725346800"; 
   d="scan'208";a="75214238"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Oct 2024 18:54:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swu0N-0002RI-13;
	Sat, 05 Oct 2024 01:54:47 +0000
Date: Sat, 5 Oct 2024 09:54:36 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in
 Hyper-V code
Message-ID: <202410050921.0o9FH5Ai-lkp@intel.com>
References: <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727985064-18362-6-git-send-email-nunodasneves@linux.microsoft.com>

Hi Nuno,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on arm64/for-next/core kvm/queue linus/master v6.12-rc1 next-20241004]
[cannot apply to kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/hyperv-Move-hv_connection_id-to-hyperv-tlfs-h/20241004-035418
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/1727985064-18362-6-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH 5/5] hyperv: Use hvhdk.h instead of hyperv-tlfs.h in Hyper-V code
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241005/202410050921.0o9FH5Ai-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050921.0o9FH5Ai-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050921.0o9FH5Ai-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/hyperv/mshyperv.c:13:
   In file included from include/linux/acpi.h:39:
   In file included from include/acpi/acpi_io.h:7:
   In file included from arch/arm64/include/asm/acpi.h:14:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/hyperv/mshyperv.c:53:19: error: use of undeclared identifier 'HV_REGISTER_FEATURES'; did you mean 'HV_REGISTER_FEATURES_INFO'?
      53 |         hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
         |                          ^~~~~~~~~~~~~~~~~~~~
         |                          HV_REGISTER_FEATURES_INFO
   include/hyperv/hvgdk_mini.h:807:2: note: 'HV_REGISTER_FEATURES_INFO' declared here
     807 |         HV_REGISTER_FEATURES_INFO                               = 0x00000201,
         |         ^
>> arch/arm64/hyperv/mshyperv.c:58:19: error: use of undeclared identifier 'HV_REGISTER_ENLIGHTENMENTS'
      58 |         hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
         |                          ^
   5 warnings and 2 errors generated.


vim +53 arch/arm64/hyperv/mshyperv.c

410779d8d81fcf Nuno Das Neves 2024-03-07  30  
9bbb888824e38c Michael Kelley 2021-08-04  31  static int __init hyperv_init(void)
9bbb888824e38c Michael Kelley 2021-08-04  32  {
9bbb888824e38c Michael Kelley 2021-08-04  33  	struct hv_get_vp_registers_output	result;
9bbb888824e38c Michael Kelley 2021-08-04  34  	u64	guest_id;
9bbb888824e38c Michael Kelley 2021-08-04  35  	int	ret;
9bbb888824e38c Michael Kelley 2021-08-04  36  
9bbb888824e38c Michael Kelley 2021-08-04  37  	/*
9bbb888824e38c Michael Kelley 2021-08-04  38  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
9bbb888824e38c Michael Kelley 2021-08-04  39  	 * a non-Hyper-V environment, including on DT instead of ACPI.
9bbb888824e38c Michael Kelley 2021-08-04  40  	 * In such cases, do nothing and return success.
9bbb888824e38c Michael Kelley 2021-08-04  41  	 */
9bbb888824e38c Michael Kelley 2021-08-04  42  	if (acpi_disabled)
9bbb888824e38c Michael Kelley 2021-08-04  43  		return 0;
9bbb888824e38c Michael Kelley 2021-08-04  44  
9bbb888824e38c Michael Kelley 2021-08-04  45  	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
9bbb888824e38c Michael Kelley 2021-08-04  46  		return 0;
9bbb888824e38c Michael Kelley 2021-08-04  47  
9bbb888824e38c Michael Kelley 2021-08-04  48  	/* Setup the guest ID */
d5ebde1e2b4615 Li kunyu       2022-09-28  49  	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
b967df6293510b Nuno Das Neves 2024-03-12  50  	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
9bbb888824e38c Michael Kelley 2021-08-04  51  
9bbb888824e38c Michael Kelley 2021-08-04  52  	/* Get the features and hints from Hyper-V */
9bbb888824e38c Michael Kelley 2021-08-04 @53  	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
9bbb888824e38c Michael Kelley 2021-08-04  54  	ms_hyperv.features = result.as32.a;
9bbb888824e38c Michael Kelley 2021-08-04  55  	ms_hyperv.priv_high = result.as32.b;
9bbb888824e38c Michael Kelley 2021-08-04  56  	ms_hyperv.misc_features = result.as32.c;
9bbb888824e38c Michael Kelley 2021-08-04  57  
9bbb888824e38c Michael Kelley 2021-08-04 @58  	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
9bbb888824e38c Michael Kelley 2021-08-04  59  	ms_hyperv.hints = result.as32.a;
9bbb888824e38c Michael Kelley 2021-08-04  60  
9bbb888824e38c Michael Kelley 2021-08-04  61  	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
9bbb888824e38c Michael Kelley 2021-08-04  62  		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
9bbb888824e38c Michael Kelley 2021-08-04  63  		ms_hyperv.misc_features);
9bbb888824e38c Michael Kelley 2021-08-04  64  
9bbb888824e38c Michael Kelley 2021-08-04  65  	ret = hv_common_init();
9bbb888824e38c Michael Kelley 2021-08-04  66  	if (ret)
9bbb888824e38c Michael Kelley 2021-08-04  67  		return ret;
9bbb888824e38c Michael Kelley 2021-08-04  68  
52ae076c3a9b36 Michael Kelley 2023-05-23  69  	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:online",
9bbb888824e38c Michael Kelley 2021-08-04  70  				hv_common_cpu_init, hv_common_cpu_die);
9bbb888824e38c Michael Kelley 2021-08-04  71  	if (ret < 0) {
9bbb888824e38c Michael Kelley 2021-08-04  72  		hv_common_free();
9bbb888824e38c Michael Kelley 2021-08-04  73  		return ret;
9bbb888824e38c Michael Kelley 2021-08-04  74  	}
9bbb888824e38c Michael Kelley 2021-08-04  75  
f2580a907e5c0e Michael Kelley 2024-03-18  76  	ms_hyperv_late_init();
f2580a907e5c0e Michael Kelley 2024-03-18  77  
9bbb888824e38c Michael Kelley 2021-08-04  78  	hyperv_initialized = true;
9bbb888824e38c Michael Kelley 2021-08-04  79  	return 0;
9bbb888824e38c Michael Kelley 2021-08-04  80  }
9bbb888824e38c Michael Kelley 2021-08-04  81  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

