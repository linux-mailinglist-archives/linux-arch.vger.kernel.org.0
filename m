Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14B93B765F
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jun 2021 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhF2QVS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Jun 2021 12:21:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:31956 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232355AbhF2QVN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Jun 2021 12:21:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="188559933"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="188559933"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 09:18:31 -0700
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="489305510"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 09:18:25 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lyGRH-006Ktj-7b; Tue, 29 Jun 2021 19:18:19 +0300
Date:   Tue, 29 Jun 2021 19:18:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Hildenbrand <david@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 0/8] all: use find_next_*_bit() instead of
 find_first_*_bit() where possible
Message-ID: <YNtHy/CpPZhaTQEE@smile.fi.intel.com>
References: <20210612123639.329047-1-yury.norov@gmail.com>
 <YNp75K4n9KQD5Cw3@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNp75K4n9KQD5Cw3@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 28, 2021 at 06:48:20PM -0700, Yury Norov wrote:
> On Sat, Jun 12, 2021 at 05:36:31AM -0700, Yury Norov wrote:
> > find_first_*_bit() is simpler and faster than 'next' version [1], and they
> > work identically if start == 0. But in many cases kernel code uses the
> > 'next' version where 'first' can be used. This series addresses this issue.
> > 
> > Patches 1-3 move find.h under include/linux as it simplifies development.
> > Patches 4-8 switch the kernel and tools to find_first_*_bit() implementation
> > where appropriate. 
> 
> Guys, do we have any blocker for this series? If not, I'd like to have it
> merged in this window.
> 
> And this too: https://lore.kernel.org/lkml/YNirnaYw1GSxg1jK@yury-ThinkPad/T/

"This window" now equals for v5.15-rc1, hence we have a few weeks time anyway.

-- 
With Best Regards,
Andy Shevchenko


