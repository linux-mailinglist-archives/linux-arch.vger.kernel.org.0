Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D32183382
	for <lists+linux-arch@lfdr.de>; Thu, 12 Mar 2020 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCLOnn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Mar 2020 10:43:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:17696 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgCLOnn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 10:43:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="246391848"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2020 07:43:38 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCP3k-0090m7-Jt; Thu, 12 Mar 2020 16:43:40 +0200
Date:   Thu, 12 Mar 2020 16:43:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-nvme@lists.infradead.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH v1] asm-generic: Provide generic
 {get,put}_unaligned_{l,b}e24()
Message-ID: <20200312144340.GV1922688@smile.fi.intel.com>
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
 <20200312140542.GA17152@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312140542.GA17152@lst.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 12, 2020 at 03:05:42PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 12, 2020 at 01:39:41PM +0200, Andy Shevchenko wrote:
> > There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
> > implementation. Provide generic helpers once for all.
> 
> I have a vague memory of Bart sending a patch like this a while ago,
> adding him to verify my theory.

Thanks!

> Also is there any good to have this in asm-generic/ vs linux/?

For now on it is least invasive. asm-generic/unaligned is a cross point for all
unaligned accessor helpers, since we here do byteshift approach for all
possible variants, I don't see any other header suitable. Or are you talking
about something like linux/unaligned/24bit.h -> #include <...> here?

-- 
With Best Regards,
Andy Shevchenko


