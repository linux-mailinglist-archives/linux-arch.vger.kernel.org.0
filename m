Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27057780FC5
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378308AbjHRQC4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 12:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378440AbjHRQCq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 12:02:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A023AB4;
        Fri, 18 Aug 2023 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692374565; x=1723910565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d3sNXlisUI+ahHQYLiPJwyjims1pnsxpaM2iiY96q3g=;
  b=XHn7ur2gLQhpq0EiMvwyHOXLH2wJHifLqOPkgLumlP6vcq60KHESPF0F
   37b6cdAhPtTmMOjFa3U5ZDqPJNySml2HS3Vr/0wRmnIcjyY9BBfieDvqm
   8YZ2WWgNtjm3gGWos5cOil6q8MWz2KS2VhwV4JNi1vZivQF2CyiEK7Efs
   Svy1/pwHaDTGJKU6bK0yf9+OJK9THtMRKz+e7gDKY1wSxvO8pS0FCnCQL
   k4NYgE408ajckvJF+duf0cv9uxt5fkZ09Ps2FqvquYrIfuSfC9x9MAT8a
   g21bkUxz4dAoc0seFgiQ8LQrEFHKLTQupo1E+4ENVASLacFfXM+lBfkru
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="363292362"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363292362"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 09:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="712053099"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="712053099"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2023 09:01:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX1v3-00Ezew-0K;
        Fri, 18 Aug 2023 19:01:49 +0300
Date:   Fri, 18 Aug 2023 19:01:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] asm-generic: Fix spelling of architecture
Message-ID: <ZN+V7P6srKrAelUQ@smile.fi.intel.com>
References: <20230724134301.13980-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724134301.13980-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 24, 2023 at 04:43:01PM +0300, Andy Shevchenko wrote:
> Fix spelling of "architecture" in the Kbuild file.

Any comments?

-- 
With Best Regards,
Andy Shevchenko


