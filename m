Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4024B59E891
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245431AbiHWRHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343816AbiHWRDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 13:03:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B2A89937;
        Tue, 23 Aug 2022 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661263787; x=1692799787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bi4jdslH1XmMlExJRJY2zoC8ta2OhPcunCg0oaSmBRI=;
  b=akrrD9Im9E3kyEtTN174wjK1qizLG0gq2jFqKsVzHhOWpLDs+EHisf84
   tnfJtI0REdgA1Sj0oYFZyetREmM6GTgAGmdT6ATACe11/TkG8Zzmvy/FV
   jN1LRzVa8WgV6IKi3nhDmDK1mffHGGigxhfco16if2WbDXbFRybyo2J4j
   wODzdv7cnW2Dd3RznXttY3+dZkesJ9kntKXehx8g89VWSDNZq6r8jpvYd
   0xL47s7f2D/KoPySm+h2/tN4EON+G6ztLOSDT5CLYELDROM0a4cO7Sy+E
   USiYo9c7dCKpFhNW3zCZq5RVEuHs8lx4Kbitw3qi2jbytv+cxi+AQf9+M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="319742310"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="319742310"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638667953"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:09:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQUb9-002T5h-09;
        Tue, 23 Aug 2022 17:09:43 +0300
Date:   Tue, 23 Aug 2022 17:09:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Keith Busch <kbusch@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/1] asm-generic: Make parameter types consisten in
 _unaligned_be48()
Message-ID: <YwTfpu13CibZNS4a@smile.fi.intel.com>
References: <20220726082908.71341-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726082908.71341-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 26, 2022 at 11:29:08AM +0300, Andy Shevchenko wrote:
> There is a convention to use internal kernel types, hence replace
> __u8 by u8.

Any comments on this? Otherwise I may push it through different tree.

-- 
With Best Regards,
Andy Shevchenko


