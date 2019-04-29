Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E48E83C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 18:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfD2Q6L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 29 Apr 2019 12:58:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:10019 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbfD2Q6L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Apr 2019 12:58:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 09:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,410,1549958400"; 
   d="scan'208";a="169009686"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga001.fm.intel.com with ESMTP; 29 Apr 2019 09:58:10 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.183]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.52]) with mapi id 14.03.0415.000;
 Mon, 29 Apr 2019 09:58:09 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Christoph Hellwig <hch@infradead.org>, Meelis Roos <mroos@linux.ee>
CC:     Christopher Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: RE: DISCONTIGMEM is deprecated
Thread-Topic: DISCONTIGMEM is deprecated
Thread-Index: AQHU/ZpXmcVCt4ADQUqjpwA1uPgMxaZTXO4w
Date:   Mon, 29 Apr 2019 16:58:09 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7E9140BA@ORSMSX104.amr.corp.intel.com>
References: <20190419094335.GJ18914@techsingularity.net>
 <20190419140521.GI7751@bombadil.infradead.org>
 <0100016a461809ed-be5bd8fc-9925-424d-9624-4a325a7a8860-000000@email.amazonses.com>
 <25cabb7c-9602-2e09-2fe0-cad3e54595fa@linux.ee>
 <20190428081353.GB30901@infradead.org>
In-Reply-To: <20190428081353.GB30901@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDZlMGYwOWMtYjMxNC00ZDg2LWI2OTMtNDI5NjUwZDU1NzllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR3gxdGpVSlhOVlhRSWZVOExpNUk0emx1dkVMZzdGZ3QrK21zNE95d2g0a0VGR0tvWTVQY1lRUDBuMjkwVWNEZiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> ia64 has a such a huge number of memory model choices.  Maybe we
> need to cut it down to a small set that actually work.

SGI systems had extremely discontiguous memory (they used some high
order physical address bits in the tens/hundreds of terabyte range for the
node number ... so there would be a few GBytes of actual memory then
a huge gap before the next node had a few more Gbytes).

I don't know of anyone still booting upstream on an SN2, so if we start doing
serious hack and slash the chances are high that SN2 will be broken (if it isn't
already).

-Tony
