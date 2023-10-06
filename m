Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7DE7BBB4A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Oct 2023 17:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjJFPH4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Oct 2023 11:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjJFPHr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Oct 2023 11:07:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F482FC;
        Fri,  6 Oct 2023 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696604863; x=1728140863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DwQeK5g+nZrAsMFaywjVF9oKx41J1cDOJOgnHvkpWNk=;
  b=WwgNFnupgrxVQhAHmsB1O64kFr1uu8AO40HEUGZqmYqeB0g5AMY3UrGJ
   +ogy/sswWRp7vcc1+6vgVD3aBDuMcv0O3L1bwndzYjGwWikuzB0YMHr5v
   WJs1cyyd/rYKKVogXXvS4TgoaEHb+VMTxJgoHANkmtoOcOnJXaLgWjk6h
   MNJRkv6T30yaN3Y1FiEUXVMFq44alRfHDKa/EgsFulaPm57u8u0Wt0xrr
   dfmHW0xLrMLn/ipE39KbTn4ejXn8p19v6xj9X0lK+3BPxZP2qtI1dk9DQ
   deJlpZFh5F6AXwFSzRyKnWPD+bMfAqSOovUzXqtS/+PlvHa+BQNub5jus
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363120403"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="363120403"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="1083484364"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="1083484364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:07:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qomQU-00000003LPZ-0p8U;
        Fri, 06 Oct 2023 18:07:38 +0300
Date:   Fri, 6 Oct 2023 18:07:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] asm-generic: Fix spelling of architecture
Message-ID: <ZSAiueycCL067TrJ@smile.fi.intel.com>
References: <20230724134301.13980-1-andriy.shevchenko@linux.intel.com>
 <ZN+V7P6srKrAelUQ@smile.fi.intel.com>
 <3a5898a1-71b3-7377-cf46-94149e53cbce@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a5898a1-71b3-7377-cf46-94149e53cbce@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 18, 2023 at 04:08:13PM -0700, Randy Dunlap wrote:
> On 8/18/23 09:01, Andy Shevchenko wrote:
> > On Mon, Jul 24, 2023 at 04:43:01PM +0300, Andy Shevchenko wrote:
> >> Fix spelling of "architecture" in the Kbuild file.
> > 
> > Any comments?
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thank you!

Arnd, is it possible to get this applied?
Or should I use another tree?

-- 
With Best Regards,
Andy Shevchenko


