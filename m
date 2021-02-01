Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2871D30A91B
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhBANwL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 08:52:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:38958 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232399AbhBANwJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 08:52:09 -0500
IronPort-SDR: Um1vpI+/cSSqhndU66hDGjvnIe6FnxRK4f5zLZdb/x1p8p9BDqPS1f8MwXQFDXNg5k/XD2dsSk
 kmHKZxwM61sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="177177578"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="177177578"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:50:23 -0800
IronPort-SDR: hcgSNPnILhJZTpavke9oQarD8o6y15BPsDI72l1r64bBRIZ8XNdFa2A0I+8+KfxG/beLS6V34K
 adE1EqYtx6ww==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="371556379"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 05:50:18 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6Zao-00190R-DK; Mon, 01 Feb 2021 15:50:14 +0200
Date:   Mon, 1 Feb 2021 15:50:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH 8/8] lib: add fast path for find_first_*_bit() and
 find_last_bit()
Message-ID: <YBgHFhfIsu60iJc2@smile.fi.intel.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210130191719.7085-9-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130191719.7085-9-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 30, 2021 at 11:17:19AM -0800, Yury Norov wrote:
> Similarly to bitmap functions, users will benefit if we'll handle
> a case of small-size bitmaps that fit into a single word.
> 
> While here, move the find_last_bit() declaration to bitops/find.h
> where other find_*_bit() functions sit.

As per previous patches:
 - decouple from tools
 - show examples of the code generation difference

-- 
With Best Regards,
Andy Shevchenko


