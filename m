Return-Path: <linux-arch+bounces-15524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB9CD3E0B
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 10:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A24EA3004BB8
	for <lists+linux-arch@lfdr.de>; Sun, 21 Dec 2025 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191219D07A;
	Sun, 21 Dec 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZA/yq+0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06EEEEA8;
	Sun, 21 Dec 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310432; cv=none; b=fpTRSPRcpRqODk65RpQifo2OmiIgbq9rz95dP3qYQX7PisUfqQz9vBr6KF8Yqmlh3HqB6dJcCyL8KeiqVBphizXsoTBH5TOOnsF0ypZt0dh1JcwUALC0UjpWyp7uOEhWq2mR9nX+eerwqrVz34Tc4wCLFTrWBOeg1PJfQ+3PmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310432; c=relaxed/simple;
	bh=4rJv5dqd8vQSSuUWkhvYaw7fdGbR4zlzLZporGj9z9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSFjEBaOThki30Rh+gskxd7Ka8nz9yYMVMva6MJ8sdfU/rjUqxA4Tey992qzl0oWEHWd/2szCfJLbbHis7a0NyC7LOMi1c6s8NUwjctuHPWvBWU/VaPpDSazD0PEEv0z1tzEvuab9Phy+LC/t9JFo0FBW8lYDgqzLsSvMvTBUbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZA/yq+0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766310430; x=1797846430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4rJv5dqd8vQSSuUWkhvYaw7fdGbR4zlzLZporGj9z9g=;
  b=IZA/yq+0KCpiqnsPPB5kXMm5/qaUQPJ0mrZRApAPoY+EbqbqKrY4vqro
   lHc9JPjulfcV8FtkU+uHJkQGX1lPZ3ntIAQdVVolgZucwz1yfNfExZWp/
   WcWSRZu+eQtDPHtuovt0Aih2YY6a3JVDXRUK8pvH6sMTjR2+Rs4l/Ysp3
   84ja2FsVcBebkWWgJYKpRAc/c8+F9iXAjrdOvnhTqQhLMv0NEULmfFMKD
   m0ssnvEpTBrrmqN57evbd6lB0hA8BZacPRcqYsPJvDEms+vnujM3Klqrk
   VPAw5hRjba5yBB4/QaIvOSeONCCjqXDngOyo7EPbtGvLRmt3K7TAVll9Q
   Q==;
X-CSE-ConnectionGUID: WAza96BVQ6Sr3WyzUa5Hsw==
X-CSE-MsgGUID: 1UpGwv1IR0iVTo6GadIP9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="68246104"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="68246104"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 01:47:10 -0800
X-CSE-ConnectionGUID: MeU1WLjjRvyTa7CkqD6twQ==
X-CSE-MsgGUID: CMUSjbIkShmtezCjTP8dpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="229935926"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Dec 2025 01:47:06 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXG1n-000000005Vl-21fQ;
	Sun, 21 Dec 2025 09:47:03 +0000
Date: Sun, 21 Dec 2025 17:46:40 +0800
From: kernel test robot <lkp@intel.com>
To: Luigi Rizzo <lrizzo@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH-v3 2/3] genirq: Adaptive Global Software Interrupt
 Moderation (GSIM)
Message-ID: <202512211737.PVtnFVdB-lkp@intel.com>
References: <20251217112128.1401896-3-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217112128.1401896-3-lrizzo@google.com>

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
patch link:    https://lore.kernel.org/r/20251217112128.1401896-3-lrizzo%40google.com
patch subject: [PATCH-v3 2/3] genirq: Adaptive Global Software Interrupt Moderation (GSIM)
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251221/202512211737.PVtnFVdB-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512211737.PVtnFVdB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512211737.PVtnFVdB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __hexagon_udivdi3
   >>> referenced by irq_moderation_hook.c
   >>>               kernel/irq/irq_moderation_hook.o:(irq_moderation_update_epoch) in archive vmlinux.a
   >>> referenced by irq_moderation_hook.c
   >>>               kernel/irq/irq_moderation_hook.o:(irq_moderation_update_epoch) in archive vmlinux.a
   >>> referenced by irq_moderation_hook.c
   >>>               kernel/irq/irq_moderation_hook.o:(irq_moderation_update_epoch) in archive vmlinux.a
   >>> referenced 1 more times
   >>> did you mean: __hexagon_udivsi3
   >>> defined in: vmlinux.a(arch/hexagon/lib/udivsi3.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

