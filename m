Return-Path: <linux-arch+bounces-15809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB69D28883
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 21:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0D27300CCCD
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 20:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268EC2877D4;
	Thu, 15 Jan 2026 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1n63cWg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8F27F72C;
	Thu, 15 Jan 2026 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510339; cv=none; b=CNJouEbpMP7F00rLv67vGt9dK0owQ8wWgZVwGVRj5kjMf72UQqMq/8d826sj3rz4ebeGj82OYADQ8k2cGTK98eZHhDuujrBUDjx4rFQ0CGGMkHTwUliXU4/Dsd8WplIA+A39+PdaOzzQvogyBCvs+QUFyC7mb54tkvKttLkDhdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510339; c=relaxed/simple;
	bh=pQQGVRG/NDVNSldCrMgbQd2NvjFlVVpwVNlrxeOnPug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+LGmMWwpSsLicyUZCJnKPOqxqA6wHkYNCCPodH542JGo0gqRRCJBqkQESXxV+M7JQIDz+b85fVv/Fz5hAqcH9JpKenaue96Nk2uEQmGc/wNop88xd8c9fN+won67whUM4ZEcW4aUz9udiqR2Wqz8nS5cGCX+8WhJnQBrZ0k7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1n63cWg; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768510337; x=1800046337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pQQGVRG/NDVNSldCrMgbQd2NvjFlVVpwVNlrxeOnPug=;
  b=g1n63cWgkjl/yAt/Nw7XGcAoCvDbK+8KGbLrDTrOdQuxRV5YLtiGAibs
   f+QIJnH8itGMLNagcQ4i9sEU1D3dGFeShwmqVqtBxWx3LQa/kJtjFR4dM
   NbCKZp0ZMSEXMinisrVP9S7rOewGUbqhPiHp0gNbNBfRWTLmUQ8vczAhi
   ax3sHf5oujdhk00eo4h2fFjgnO+63LR3W4FS6d/9qV+kcvsQmyl9mih7c
   99XXW6hiVK2P6EedSjXVDJ2uby6k9frImJMJO7DsrsRgcqkXemYOfGQ8B
   Nv9ekIH2TSf6ZUO+bv136mFAEE5/lLgyyGbCeR7+KmhcpTdOa0bnwvCgh
   A==;
X-CSE-ConnectionGUID: iI+oQB01Tw66uUhDLShA5A==
X-CSE-MsgGUID: 9QcjnhCkRYuW2Or+Ia7OnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="72411544"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="72411544"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 12:52:17 -0800
X-CSE-ConnectionGUID: tDozUA/lQe+FKS9fq9cx3g==
X-CSE-MsgGUID: KmJ1BYAsT/GswGHVSqYj+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204939722"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jan 2026 12:52:14 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vgUKC-00000000Jya-08M7;
	Thu, 15 Jan 2026 20:52:12 +0000
Date: Fri, 16 Jan 2026 04:52:05 +0800
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
Subject: Re: [PATCH v4 2/3] genirq: Fixed-delay Global Software Interrupt
 Moderation (GSIM)
Message-ID: <202601160402.Z1oBJhge-lkp@intel.com>
References: <20260115155942.482137-3-lrizzo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115155942.482137-3-lrizzo@google.com>

Hi Luigi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.19-rc5]
[cannot apply to tip/irq/core next-20260115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luigi-Rizzo/genirq-Add-flags-for-software-interrupt-moderation/20260116-000808
base:   linus/master
patch link:    https://lore.kernel.org/r/20260115155942.482137-3-lrizzo%40google.com
patch subject: [PATCH v4 2/3] genirq: Fixed-delay Global Software Interrupt Moderation (GSIM)
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260116/202601160402.Z1oBJhge-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260116/202601160402.Z1oBJhge-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601160402.Z1oBJhge-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/irq/irq_moderation.c:217: warning: ignoring '#pragma clang diagnostic' [-Wunknown-pragmas]
     217 | #pragma clang diagnostic error "-Wformat"


vim +217 kernel/irq/irq_moderation.c

   216	
 > 217	#pragma clang diagnostic error "-Wformat"
   218	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

