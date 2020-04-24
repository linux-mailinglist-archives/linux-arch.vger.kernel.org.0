Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE331B7B97
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgDXQ2q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 12:28:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:39131 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgDXQ2q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 12:28:46 -0400
IronPort-SDR: blpGAwZDqpro+lc0ahbbQwYhY6TGcxpRhG/PnVss1FEWoAMXWfh3ahciZgHgZjhb0TMCsz+bHa
 2prjJPP9dzVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:28:45 -0700
IronPort-SDR: jeDDky+ZJjvBy2IfDqA0f79rtfkaJHYl2liJyWlpfY/OGX7D97oMfaTjX7fRZtxeSSaGiF5THd
 s8YRO/Ecc/Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="259867503"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 24 Apr 2020 09:28:41 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jS1Bz-002sAW-Pb; Fri, 24 Apr 2020 19:28:43 +0300
Date:   Fri, 24 Apr 2020 19:28:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, vilhelm.gray@gmail.com,
        michal.simek@xilinx.com, arnd@arndb.de, rrichter@marvell.com,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        yamada.masahiro@socionext.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] Introduce the for_each_set_clump macro
Message-ID: <20200424162843.GC185537@smile.fi.intel.com>
References: <20200424122407.GA5523@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424122407.GA5523@syed>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 24, 2020 at 05:54:07PM +0530, Syed Nayyar Waris wrote:
> This patchset introduces a new generic version of for_each_set_clump. 
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro 
> in several GPIO drivers.

You have broken thread. Please, use --thread when run `git format-patch ...`.

-- 
With Best Regards,
Andy Shevchenko


