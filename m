Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2E344EDB7
	for <lists+linux-arch@lfdr.de>; Fri, 12 Nov 2021 21:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhKLUMu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Nov 2021 15:12:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:55969 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhKLUMt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Nov 2021 15:12:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10166"; a="220090415"
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="scan'208";a="220090415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 12:09:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,230,1631602800"; 
   d="scan'208";a="505018696"
Received: from rjlank1-mobl1.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.91.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2021 12:09:58 -0800
Date:   Fri, 12 Nov 2021 12:09:57 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 0/2] Nuke PAGE_KERNEL_IO
Message-ID: <20211112200957.qem4dyjnzjhls4v3@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20211021181511.1533377-1-lucas.demarchi@intel.com>
 <20211112190403.GK174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211112190403.GK174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 12, 2021 at 08:04:03PM +0100, Peter Zijlstra wrote:
>On Thu, Oct 21, 2021 at 11:15:09AM -0700, Lucas De Marchi wrote:
>> Last user of PAGE_KERNEL_IO is the i915 driver. While removing it from
>> there as we seek to bring the driver to other architectures, Daniel
>> suggested that we could finish the cleanup and remove it altogether,
>> through the tip tree. So here I'm sending both commits needed for that.
>>
>> Lucas De Marchi (2):
>>   drm/i915/gem: stop using PAGE_KERNEL_IO
>>   x86/mm: nuke PAGE_KERNEL_IO
>>
>>  arch/x86/include/asm/fixmap.h             | 2 +-
>>  arch/x86/include/asm/pgtable_types.h      | 7 -------
>>  arch/x86/mm/ioremap.c                     | 2 +-
>>  arch/x86/xen/setup.c                      | 2 +-
>>  drivers/gpu/drm/i915/gem/i915_gem_pages.c | 4 ++--
>>  include/asm-generic/fixmap.h              | 2 +-
>>  6 files changed, 6 insertions(+), 13 deletions(-)
>
>Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

thanks, Peter.

The intention was to merge this through the tip tree. Although now I'm
not sure. Options:

	1) take the first patch through the drm-intel tree and apply the
	   second patch later
	2) take everything through the drm tree
	3) take everything through the tip tree

What's your preference here?

Lucas De Marchi
