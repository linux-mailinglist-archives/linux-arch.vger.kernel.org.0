Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986455AA0B7
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 22:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiIAUOM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 16:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIAUOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 16:14:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF719CCF2;
        Thu,  1 Sep 2022 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662063250; x=1693599250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pM8J3AnVQJbBuqcTeK4uG2AjiYCZxpuQqCQAnt+lLAA=;
  b=YPKl2/vZtyBCc+o6ThcC2xYf0/1L1qnKV1bAe2CGt+9ojlEJBw4wj7DE
   8gI40Zt+XoLdBYSWqGhkdmPo2KLq9klbGhoiNZzqEiu+EpCD8bYcf/3ga
   WH8i1yovZU1ATiJcEdeKqGkVO6MTec1Y0elpCtRof0Xgo1oXnHdRFNBDH
   oDxFc4Q2QbCzDpJTfUG2HdPAETbFri8g7eiLV3XOjFFZOMWgQGHq/Vkcw
   +YwxieJ4HFFQKHCw5wtaC/XatHO8y7v0C5mPsr7lt0b3L1HlJQYo0H4PH
   +9fFtWyfg2WaRKNFyWym4f0nW+t1Og6ehJqLOxPEV5ZIrr0t8UvyCBQPi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295827424"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="295827424"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:14:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589694158"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:14:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTqZh-0071wG-2p;
        Thu, 01 Sep 2022 23:14:05 +0300
Date:   Thu, 1 Sep 2022 23:14:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND][PATCH v1 1/1] asm-generic: Make parameter types
 consisten in _unaligned_be48()
Message-ID: <YxESjZsTKNgLa2Vl@smile.fi.intel.com>
References: <20220830172713.43686-1-andriy.shevchenko@linux.intel.com>
 <Yw+T12PFGYXy52Ie@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw+T12PFGYXy52Ie@kbusch-mbp.dhcp.thefacebook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 31, 2022 at 11:01:11AM -0600, Keith Busch wrote:
> On Tue, Aug 30, 2022 at 08:27:13PM +0300, Andy Shevchenko wrote:
> > There is a convention to use internal kernel types, hence replace
> > __u8 by u8.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Sorry for the delay, looks good.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks!

Andrew, can you pick this up?

-- 
With Best Regards,
Andy Shevchenko


