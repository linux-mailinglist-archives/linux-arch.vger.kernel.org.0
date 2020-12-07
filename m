Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECD22D14CC
	for <lists+linux-arch@lfdr.de>; Mon,  7 Dec 2020 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgLGPeI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Dec 2020 10:34:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:53900 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGPeH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Dec 2020 10:34:07 -0500
IronPort-SDR: pKYh/NlXU5QY//+3oB2NOslP0BXYNWziZf/fZyCnxA/cAQuhTRkEQLcfnSMfhqooVcrxlLYO7i
 EU9UXZgu0ypA==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="160762626"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="160762626"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 07:32:21 -0800
IronPort-SDR: kbW/UfEi4Dtiv+Pinbnr+yvYUc4SZeynvhGwHV+gpCbyuvAJWsAofY0KRLiI3OA6kH7npDlUQs
 j89qKjJ69ADg==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="407184186"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 07:32:14 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kmIVm-00CcUw-Tz; Mon, 07 Dec 2020 17:33:14 +0200
Date:   Mon, 7 Dec 2020 17:33:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Levi Yun <ppbuk5246@gmail.com>
Cc:     akpm@linux-foundation.org, yury.norov@gmail.com,
        richard.weiyang@linux.alibaba.com, christian.brauner@ubuntu.com,
        arnd@arndb.de, jpoimboe@redhat.com, changbin.du@intel.com,
        rdunlap@infradead.org, masahiroy@kernel.org,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        peter.enderborg@sony.com, krzk@kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        broonie@kernel.org, matti.vaittinen@fi.rohmeurope.com,
        mhiramat@kernel.org, jpa@git.mail.kapsi.fi, nivedita@alum.mit.edu,
        glider@google.com, orson.zhai@unisoc.com,
        takahiro.akashi@linaro.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, dushistov@mail.ru, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/8] lib/find_bit.c: Add find_last_zero_bit
Message-ID: <20201207153314.GB4077@smile.fi.intel.com>
References: <20201206064624.GA5871@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206064624.GA5871@ubuntu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Dec 06, 2020 at 03:46:24PM +0900, Levi Yun wrote:
> Inspired find_next_*_bit and find_last_bit, add find_last_zero_bit
> And add le support about find_last_bit and find_last_zero_bit.

Use `git format-patch ...` tool. When create a series, be sure you run it:
- with -v<n>, where <n> is a version number (makes sense from v2)
- with --thread (it will be properly formed in a thread)
- with --cover-letter (don't forget to file the patch 0/n message)

-- 
With Best Regards,
Andy Shevchenko


