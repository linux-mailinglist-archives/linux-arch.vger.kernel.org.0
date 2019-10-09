Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA5D16F5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2019 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfJIRjB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Oct 2019 13:39:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:63868 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731989AbfJIRjA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Oct 2019 13:39:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 10:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,277,1566889200"; 
   d="scan'208";a="206922667"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 09 Oct 2019 10:38:56 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iIFvL-0003UF-5R; Wed, 09 Oct 2019 20:38:55 +0300
Date:   Wed, 9 Oct 2019 20:38:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de
Subject: Re: [PATCH v18 00/14] Introduce the for_each_set_clump8 macro
Message-ID: <20191009173855.GH32742@smile.fi.intel.com>
References: <cover.1570641097.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570641097.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 09, 2019 at 01:14:36PM -0400, William Breathitt Gray wrote:
> Changes in v18:
>   - Apply style change on gpio-uniphier as suggested by Masahiro Yamada

Unfortunately there is no point to resend for small style fixes since we are
waiting for two things to happens:
- Andrew's ACK
- my testing

Sending new versions so often actually delays the process.

-- 
With Best Regards,
Andy Shevchenko


