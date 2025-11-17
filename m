Return-Path: <linux-arch+bounces-14848-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB55C665FD
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 22:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7B3634E267
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 21:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA55322A3E;
	Mon, 17 Nov 2025 21:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiAIUe7f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968A31A810;
	Mon, 17 Nov 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763416622; cv=none; b=ZAi3tBq1C3kH2vPIJdDhYDRI66itDa4rU7gwko0OTUgFieMrLpydGWS6FaTPFgfrPNNYQxdNkCAOOFXViT2nBCMGqMJoXzkU68+3NR84I8fED7x2cOVFyxikFC4N+49HCLUq7Wmh7goLCyuBJSdZgOJ9QfS9mhfPLifXcg7Hvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763416622; c=relaxed/simple;
	bh=gZdQ90uRnhftwMuOkOtLdGvhk8V2MVWMreJIfq9LKXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkJiMH+MsL6uo0fXziGw/p0rTnJeErwc8Img53xfXJyt5ffVSAq9zl8ZfE8IyFxSCPDRHqQiX9Dy6JRDtCjkBNbbnwYCXu6/YZz5oqeRw8K1jWWEPvIkfzZ6IUOK4oMRzzt7iQakJC9BPLOktcyZJdhtbHkPjCJEZ2Nu77b3udY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiAIUe7f; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763416620; x=1794952620;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gZdQ90uRnhftwMuOkOtLdGvhk8V2MVWMreJIfq9LKXw=;
  b=RiAIUe7frsXnEk0au8aAKyyYDiuy3moboSX2pANHSIfkyr0OdErx6G5W
   eoOGUO4oH3Idoi7hBvu7WScyNHwjXpF+6DOrT0E+4titEgvZkDV6OSDNv
   1gBlfGL4mCi9t5QkaccjBAOS85/VgvdyPRdq6j/E7JJcRGLVZGrPEaDth
   dks9zZBRXfZwGIje48gVt7pOzyVU7ev78yeHcoki8pYbT6e6d6K5ogLZ9
   Hoe0Buej9vc3rmS2AFeYzk7xWosaP5noyMu6Gx1f0vT+wwG0Y+XaIDXNa
   1XrSGV4iaBRmUI1P5MEe3qaCrmAQ2NLWj8FfMWfRXrbGuW+DxrGcLQDTn
   g==;
X-CSE-ConnectionGUID: gMeXHycaTDKp1RaWV0FJ9w==
X-CSE-MsgGUID: fjFtLozeSua1jlzX2XNgGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65520967"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="65520967"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 13:56:59 -0800
X-CSE-ConnectionGUID: 8a+ZIWu4Sd+EFLgDUG4S/w==
X-CSE-MsgGUID: fA7tsMzESkeByHSIqb02ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="190364405"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Nov 2025 13:56:56 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vL7DR-00015n-0p;
	Mon, 17 Nov 2025 21:56:53 +0000
Date: Tue, 18 Nov 2025 05:56:52 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2 2/8] genirq: soft_moderation: add base files, procfs
Message-ID: <202511180547.snSezdSu-lkp@intel.com>
References: <20251116182839.939139-3-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116182839.939139-3-lrizzo@google.com>

Hi Luigi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on tip/x86/core tip/master linus/master v6.18-rc6 next-20251117]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/genirq-platform-wide-interrupt-moderation-Documentation-Kconfig-irq_desc/20251117-023148
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20251116182839.939139-3-lrizzo%40google.com
patch subject: [PATCH v2 2/8] genirq: soft_moderation: add base files, procfs
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20251118/202511180547.snSezdSu-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251118/202511180547.snSezdSu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511180547.snSezdSu-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/irq/irq_moderation.c:103: warning: ignoring '#pragma clang diagnostic' [-Wunknown-pragmas]
     103 | #pragma clang diagnostic error "-Wformat"
   In file included from include/linux/uaccess.h:10,
                    from include/linux/sched/task.h:13,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:34,
                    from include/linux/seq_file.h:11,
                    from kernel/irq/irq_moderation.c:8:
   In function 'check_copy_size',
       inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
       inlined from 'moderation_write' at kernel/irq/irq_moderation.c:169:6:
>> include/linux/ucopysize.h:54:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
      54 |                         __bad_copy_to();
         |                         ^~~~~~~~~~~~~~~
   In function 'check_copy_size',
       inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
       inlined from 'mode_write' at kernel/irq/irq_moderation.c:223:6:
>> include/linux/ucopysize.h:54:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
      54 |                         __bad_copy_to();
         |                         ^~~~~~~~~~~~~~~


vim +/__bad_copy_to +54 include/linux/ucopysize.h

808aac63e2bdf9 Kees Cook 2025-02-28  43  
808aac63e2bdf9 Kees Cook 2025-02-28  44  static __always_inline __must_check bool
808aac63e2bdf9 Kees Cook 2025-02-28  45  check_copy_size(const void *addr, size_t bytes, bool is_source)
808aac63e2bdf9 Kees Cook 2025-02-28  46  {
808aac63e2bdf9 Kees Cook 2025-02-28  47  	int sz = __builtin_object_size(addr, 0);
808aac63e2bdf9 Kees Cook 2025-02-28  48  	if (unlikely(sz >= 0 && sz < bytes)) {
808aac63e2bdf9 Kees Cook 2025-02-28  49  		if (!__builtin_constant_p(bytes))
808aac63e2bdf9 Kees Cook 2025-02-28  50  			copy_overflow(sz, bytes);
808aac63e2bdf9 Kees Cook 2025-02-28  51  		else if (is_source)
808aac63e2bdf9 Kees Cook 2025-02-28  52  			__bad_copy_from();
808aac63e2bdf9 Kees Cook 2025-02-28  53  		else
808aac63e2bdf9 Kees Cook 2025-02-28 @54  			__bad_copy_to();
808aac63e2bdf9 Kees Cook 2025-02-28  55  		return false;
808aac63e2bdf9 Kees Cook 2025-02-28  56  	}
808aac63e2bdf9 Kees Cook 2025-02-28  57  	if (WARN_ON_ONCE(bytes > INT_MAX))
808aac63e2bdf9 Kees Cook 2025-02-28  58  		return false;
808aac63e2bdf9 Kees Cook 2025-02-28  59  	check_object_size(addr, bytes, is_source);
808aac63e2bdf9 Kees Cook 2025-02-28  60  	return true;
808aac63e2bdf9 Kees Cook 2025-02-28  61  }
808aac63e2bdf9 Kees Cook 2025-02-28  62  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

