Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF71D2CB9A1
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 10:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbgLBJsU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 04:48:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:47109 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387847AbgLBJsU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 04:48:20 -0500
IronPort-SDR: jBQ+scQGYgYA7J1yGbc8TGX2sxz5zAqs6X7dF39bzEpU/BpsI3CX8CXzy9XWVKTyZ3N2010qTK
 T9vSZ0SaGf5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="160044157"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="160044157"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 01:46:19 -0800
IronPort-SDR: fdvpCu4LKJtzIw6OKe18ZEzN2E4Mf7z7aFv8zacZOZQTlNPMdPurke/7A1ibbvXwQSMT0GwKK3
 KSE/RUnLUc/A==
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="365228059"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 01:46:16 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kkOjF-00BTr4-MB; Wed, 02 Dec 2020 11:47:17 +0200
Date:   Wed, 2 Dec 2020 11:47:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     dushistov@mail.ru, arnd@arndb.de, akpm@linux-foundation.org,
        gustavo@embeddedor.com, vilhelm.gray@gmail.com,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, yury.norov@gmail.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] lib/find_bit: Add find_prev_*_bit functions.
Message-ID: <20201202094717.GX4077@smile.fi.intel.com>
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 02, 2020 at 10:10:09AM +0900, Yun Levi wrote:
> Inspired find_next_*bit function series, add find_prev_*_bit series.
> I'm not sure whether it'll be used right now But, I add these functions
> for future usage.

This patch has few issues:
- it has more things than described (should be several patches instead)
- new functionality can be split logically to couple or more pieces as well
- it proposes functionality w/o user (dead code)

-- 
With Best Regards,
Andy Shevchenko


