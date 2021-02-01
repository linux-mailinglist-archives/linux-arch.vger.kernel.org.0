Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2DB30AC8A
	for <lists+linux-arch@lfdr.de>; Mon,  1 Feb 2021 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhBAQY0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Feb 2021 11:24:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:29698 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBAQYZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 11:24:25 -0500
IronPort-SDR: emSQniScOxAxSCmM7/qcS8sSWrDDmo0/a5iHdRJMrWhKkDZdOWOnphNOfTV5RqIhHZUqaGF38S
 /DR+MHXQHrMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180854790"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="180854790"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:22:36 -0800
IronPort-SDR: k6s+zarLevdYJoLssP9Apm++1N99I6/o1hRQHcqf1zrR51lrlo+Qa0FTOdbd2TDBVRXdYHy3jF
 PTC+iN9sxPiQ==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="412816627"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:22:31 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l6by7-001Als-Ig; Mon, 01 Feb 2021 18:22:27 +0200
Date:   Mon, 1 Feb 2021 18:22:27 +0200
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
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
Subject: Re: [PATCH 7/8] lib: add fast path for find_next_*_bit()
Message-ID: <YBgqwwrfWqU8wx+s@smile.fi.intel.com>
References: <20210130191719.7085-1-yury.norov@gmail.com>
 <20210130191719.7085-8-yury.norov@gmail.com>
 <YBgG35UTDLpVSYWV@smile.fi.intel.com>
 <e9c66d506a614a7e95d039bea325c241@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c66d506a614a7e95d039bea325c241@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 01, 2021 at 04:02:30PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 01 February 2021 13:49
> > On Sat, Jan 30, 2021 at 11:17:18AM -0800, Yury Norov wrote:
> > > Similarly to bitmap functions, find_next_*_bit() users will benefit
> > > if we'll handle a case of bitmaps that fit into a single word. In the
> > > very best case, the compiler may replace a function call with a
> > > single ffs or ffz instruction.
> > 
> > Would be nice to have the examples how it reduces the actual code size (based
> > on the existing code in kernel, especially in widely used frameworks /
> > subsystems, like PCI).
> 
> I bet it makes the kernel bigger but very slightly faster.
> But the fact that the wrappers end up in the i-cache may
> mean that inlining actually makes it slower for some calling
> sequences.

> If a bitmap fits in a single word (as a compile-time constant)
> then you should (probably) be using different functions if
> you care about performance.

Isn't this patch series exactly about it?

-- 
With Best Regards,
Andy Shevchenko


