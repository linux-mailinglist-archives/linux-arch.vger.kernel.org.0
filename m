Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFAA484464
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 16:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiADPPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 10:15:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:35254 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234807AbiADPPl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jan 2022 10:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641309341; x=1672845341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U0jCFR04AFZ0j9Ko4wwHqZ7VbTHp+abDpEOURhl/QVc=;
  b=e9btkWtSmG/QtvdmSi02c3m2IzRD3/oi+sWvXDkS3r2cpbm0SyeLFsq3
   VvADP6hCFNe4CAKlUqiiIgyvbBIYraVB/MAt7QthDHF3SSXaR8Gjp7Gnf
   IFLaDShDbOIqDh3ubEDV+j0kzZeypjhmWadFW/ycxJc7ntBAn5folxudc
   ZzsglK+/QKfleVaLBcBlajpSdX00DPhVl8TKP11Pp2g1e3doStwGI7qHD
   aeM0eIjB5VfMFQ4bLblUBcvktbROmUwP1gG1PhGnwPdbiYiiplQPThkm5
   b5dWuKlLhRvy2/wKtzvuePF+m4ucXJ0fU8KRaUsp6QAc2W/2urGnB1E+6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242036232"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242036232"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:15:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="590702321"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:15:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1n4lW0-006Fpy-6I;
        Tue, 04 Jan 2022 17:14:20 +0200
Date:   Tue, 4 Jan 2022 17:14:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] per_task: Remove the PER_TASK_BYTES hard-coded constant
Message-ID: <YdRkS1iq6wtgbI3b@smile.fi.intel.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com>
 <YdRVawyDbHvI01uV@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdRVawyDbHvI01uV@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 04, 2022 at 03:10:51PM +0100, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:

> +++ b/kernel/sched/core.c

> +#include "../../../kernel/sched/per_task_area_struct.h"

#include "per_task_area_struct.h" ?

-- 
With Best Regards,
Andy Shevchenko


