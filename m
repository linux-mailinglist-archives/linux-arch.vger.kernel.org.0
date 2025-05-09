Return-Path: <linux-arch+bounces-11876-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB0AB08E9
	for <lists+linux-arch@lfdr.de>; Fri,  9 May 2025 05:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3123AD179
	for <lists+linux-arch@lfdr.de>; Fri,  9 May 2025 03:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0515238D52;
	Fri,  9 May 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9bIKj4I"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655F4964E;
	Fri,  9 May 2025 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746761665; cv=none; b=TFqLmePzPDmWZqFzh+NFOSeolRRAln+lZkZ1lZZmT4djOHXv0ukhVOmuPOJLzfeaEKk7ghe9eu86ND4rIM8j4EkdWqkAdV+bPHZ3rftv0bSfVotdFC6cRQEZiwP88kW991KO9CJ/EoQN3cVhtc+8G1e+j17R1hT+tO9Gi91AF/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746761665; c=relaxed/simple;
	bh=YCgZ4EmtM1kqBGsyn395LmBrCpWTYHWfQgzhyYcGRZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbVQZFjnzueTmoKZ5MCAKqlwsmXR2mo/heZHCSS53JiZc+gZggiM3gPmGu7kVhn7wsgiGZJZ4WlpQvuWnkyICveiROYN8IcQG39pfWkQXF/PoC0pPdabunG9KnJomndVjhYD7xm5EPbT7BRx6wcPQyrVWTNvQxZSsg+EYGlcLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9bIKj4I; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746761665; x=1778297665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YCgZ4EmtM1kqBGsyn395LmBrCpWTYHWfQgzhyYcGRZ8=;
  b=j9bIKj4I0e8yth4EB0PTVQMTUzUx9rvR62LpznqFyUEAG5Ze3L/yUAFU
   K6wKvEWj35J6SHfV/Se21YmqyeXxH8L6jx+3QIZw3K8qa+Ti+LyaUgCpy
   DX8vy5pd01Nhfbq0OLHYKQDqZD9ecBCuPyr0BhiP4k0BGK7gz3BvV5XSg
   PXEnstiynFU/5LRlqz7NLnhWWEmL/kJxQnRpos5iXhBPK9clrrfDG03dt
   aZ7Qtt9t/ORBQDw8X4ZPbxflqFPHy1Kwm/ry9eth/LOEpeS/COF7Qxety
   DC1eOhAOh8pazULW9ZoiWuSW1rv5zvHIjUzyhJbLSi/5bqQe6HURGVtK0
   g==;
X-CSE-ConnectionGUID: rBUfTvW9T6GEK/rLBAfOHQ==
X-CSE-MsgGUID: 7FdGuy5ZSo6k3qNRaFnnOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48483754"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48483754"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 20:34:24 -0700
X-CSE-ConnectionGUID: QD+cWyvyQn+XNLNUU53Muw==
X-CSE-MsgGUID: NJ4z7ZqrSxOD44aNuGeZCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="167432410"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 May 2025 20:34:18 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDEV6-000BdH-0t;
	Fri, 09 May 2025 03:34:16 +0000
Date: Fri, 9 May 2025 11:33:21 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenz Bauer <lmb@isovalent.com>, Arnd Bergmann <arnd@arndb.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Lorenz Bauer <lmb@isovalent.com>
Subject: Re: [PATCH bpf-next v3 1/3] btf: allow mmap of vmlinux btf
Message-ID: <202505091116.jHtyWJW4-lkp@intel.com>
References: <20250505-vmlinux-mmap-v3-1-5d53afa060e8@isovalent.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505-vmlinux-mmap-v3-1-5d53afa060e8@isovalent.com>

Hi Lorenz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 38d976c32d85ef12dcd2b8a231196f7049548477]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenz-Bauer/btf-allow-mmap-of-vmlinux-btf/20250506-024103
base:   38d976c32d85ef12dcd2b8a231196f7049548477
patch link:    https://lore.kernel.org/r/20250505-vmlinux-mmap-v3-1-5d53afa060e8%40isovalent.com
patch subject: [PATCH bpf-next v3 1/3] btf: allow mmap of vmlinux btf
config: arc-randconfig-r073-20250508 (https://download.01.org/0day-ci/archive/20250509/202505091116.jHtyWJW4-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505091116.jHtyWJW4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505091116.jHtyWJW4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arc/include/asm/page.h:136,
                    from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from kernel/bpf/sysfs_btf.c:6:
   kernel/bpf/sysfs_btf.c: In function 'btf_sysfs_vmlinux_mmap':
>> kernel/bpf/sysfs_btf.c:43:51: warning: passing argument 1 of 'virt_to_pfn' makes pointer from integer without a cast [-Wint-conversion]
      43 |                                      virt_to_page(addr));
         |                                                   ^~~~
         |                                                   |
         |                                                   long unsigned int
   include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
      18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
         |                                              ^~~
   kernel/bpf/sysfs_btf.c:43:38: note: in expansion of macro 'virt_to_page'
      43 |                                      virt_to_page(addr));
         |                                      ^~~~~~~~~~~~
   arch/arc/include/asm/page.h:123:53: note: expected 'const void *' but argument is of type 'long unsigned int'
     123 | static inline unsigned long virt_to_pfn(const void *kaddr)
         |                                         ~~~~~~~~~~~~^~~~~


vim +/virt_to_pfn +43 kernel/bpf/sysfs_btf.c

    17	
    18	static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
    19					  const struct bin_attribute *attr,
    20					  struct vm_area_struct *vma)
    21	{
    22		unsigned long pages = PAGE_ALIGN(attr->size) >> PAGE_SHIFT;
    23		size_t vm_size = vma->vm_end - vma->vm_start;
    24		unsigned long addr = (unsigned long)attr->private;
    25		int i, err = 0;
    26	
    27		if (addr != (unsigned long)__start_BTF || !PAGE_ALIGNED(addr))
    28			return -EINVAL;
    29	
    30		if (vma->vm_pgoff)
    31			return -EINVAL;
    32	
    33		if (vma->vm_flags & (VM_WRITE | VM_EXEC | VM_MAYSHARE))
    34			return -EACCES;
    35	
    36		if (vm_size >> PAGE_SHIFT > pages)
    37			return -EINVAL;
    38	
    39		vm_flags_mod(vma, VM_DONTDUMP, VM_MAYEXEC | VM_MAYWRITE);
    40	
    41		for (i = 0; i < pages && !err; i++, addr += PAGE_SIZE)
    42			err = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
  > 43					     virt_to_page(addr));
    44	
    45		if (err)
    46			zap_vma_pages(vma);
    47	
    48		return err;
    49	}
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

