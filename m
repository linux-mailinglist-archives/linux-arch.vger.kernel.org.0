Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C985114793
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2019 20:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLETZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Dec 2019 14:25:42 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:51470 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLETZl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 14:25:41 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1icwiY-0004sv-00; Thu, 05 Dec 2019 19:23:14 +0000
Date:   Thu, 5 Dec 2019 14:23:14 -0500
From:   Rich Felker <dalias@libc.org>
To:     Rob Landley <rob@landley.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Message-ID: <20191205192314.GC16318@brightrain.aerifal.cx>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <e2cf6780-ba7e-d6f6-9d15-92e182f98e84@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2cf6780-ba7e-d6f6-9d15-92e182f98e84@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 05, 2019 at 01:24:02PM -0600, Rob Landley wrote:
> On 12/4/19 4:47 AM, Peter Zijlstra wrote:
> > On Tue, Dec 03, 2019 at 12:19:00PM +0100, Geert Uytterhoeven wrote:
> >> Hoi Peter,
> >>
> >> On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>> Generic mmu_gather provides everything SH needs (range tracking and
> >>> cache coherency).
> >>>
> >>> Cc: Will Deacon <will.deacon@arm.com>
> >>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Nick Piggin <npiggin@gmail.com>
> >>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >>> Cc: Rich Felker <dalias@libc.org>
> >>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>
> >> I got remote access to an SH7722-based Migo-R again, which spews a long
> >> sequence of BUGs during userspace startup.  I've bisected this to commit
> >> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
> > 
> > Whoopsy.. also, is this really the first time anybody booted an SH
> > kernel in over a year ?!?
> 
> No, but most people running this kind of hardware tend not to upgrade to current
> kernels on a regular basis.
> 
> The j-core guys tested the 5.3 release. I can't find an email about 5.4 so I
> dunno if that's been tested yet?

Being that this code is about mmu, does it affect nommu machines?
That's what we've got at present on the J-core side.

Rich
