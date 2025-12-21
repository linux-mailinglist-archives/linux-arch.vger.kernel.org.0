Return-Path: <linux-arch+bounces-15526-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1980FCD3F4A
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 12:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA69D300B831
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761DD27C842;
	Sun, 21 Dec 2025 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LuUYon/i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC62309AB;
	Sun, 21 Dec 2025 11:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766316136; cv=none; b=bxDFJeN0HD1rlXOq7PqNtgqVbpy7PFW6hsqWqKWI33sn198Z3FoV6Lv3ZplUxooBguMNQPhZb4gbTjA/26O3bTsWOvRuIQgGH98uiOiCpWGM5iQZdeQvRfBavJTTZoMLUcQqWm4sFiz2mRdTEhA8r5fPUo5UnF99D8fRU9+ICzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766316136; c=relaxed/simple;
	bh=eKcsE2VJnI/4lSfqhwMzJl/DukDh/7mH6GBUXDAbjv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHHIINYBux7aCzgBSTHUkry5WGuhT08S4KevkFD8DMECnCcyR4KW+0EncEMfCiVgRWowLckoFZCAv7dAj7NRqGgMEPzOqOeKMM9M3ucVmYlruq/PTwmT4eyiv7m1z/zCmS+5X3SlmR8f4Xiej18mdFMVE51gy2yGOLTazULernQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LuUYon/i; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766316134; x=1797852134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eKcsE2VJnI/4lSfqhwMzJl/DukDh/7mH6GBUXDAbjv0=;
  b=LuUYon/il4JL7BMiKLVhDeWwOtWaMZlVdO7KcCjVjI661l2GebzklzFI
   Li6e5C80WruLK3hT3aOnYwtbOP6bH+zbCNyT+n8PbUVA/qVoog0FBT7rJ
   kAmilq7R9kFdC/nofRA+Rf9U0F27kW7jWD9bCv9TGd/kz4AXlF48p9vrZ
   P/EqMd5m1+fokKiT5GLO2pvEtByhBNQ0dJUiQCvJ8EXn3KpTJSezDguG1
   5BC8UuO+FCKf+zyW72JTd7DuIP9b+AEhh454NvwBk17+2q1iJxUlEvWb4
   Oid6E88g1/jc7tSNcsL/yNGh7OqVo11QjmmejWX23lVfN4PVZ64+YNq5O
   Q==;
X-CSE-ConnectionGUID: Gy93nRYLQM+zeo7OaYFGdA==
X-CSE-MsgGUID: x//p9D3LQzCAFBaqdEmiQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="67399305"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="67399305"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 03:22:13 -0800
X-CSE-ConnectionGUID: etHw95yLTB+B+7dyQ9t8Lg==
X-CSE-MsgGUID: i2dI9tmSS4+zB5KsAJCk6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199253512"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 21 Dec 2025 03:22:10 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXHVn-000000005bB-2OgN;
	Sun, 21 Dec 2025 11:22:07 +0000
Date: Sun, 21 Dec 2025 19:21:23 +0800
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
Subject: Re: [PATCH-v3 1/3] genirq: Fixed Global Software Interrupt
 Moderation (GSIM)
Message-ID: <202512211933.p2Yg8Zzq-lkp@intel.com>
References: <20251217112128.1401896-2-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217112128.1401896-2-lrizzo@google.com>

Hi Luigi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.19-rc1]
[cannot apply to next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/genirq-Fixed-Global-Software-Interrupt-Moderation-GSIM/20251217-193249
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20251217112128.1401896-2-lrizzo%40google.com
patch subject: [PATCH-v3 1/3] genirq: Fixed Global Software Interrupt Moderation (GSIM)
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20251221/202512211933.p2Yg8Zzq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512211933.p2Yg8Zzq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512211933.p2Yg8Zzq-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/irq/irq_moderation.c:141: warning: ignoring '#pragma clang diagnostic' [-Wunknown-pragmas]
     141 | #pragma clang diagnostic error "-Wformat"
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:13,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/mm.h:36,
                    from include/linux/kallsyms.h:13,
                    from kernel/irq/irq_moderation.c:7:
   In function 'check_copy_size',
       inlined from 'copy_from_user' at include/linux/uaccess.h:218:7,
       inlined from 'mode_write' at kernel/irq/irq_moderation.c:259:6:
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

