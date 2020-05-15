Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D851D4D84
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 14:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgEOMNw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 08:13:52 -0400
Received: from foss.arm.com ([217.140.110.172]:55122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgEOMNw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 08:13:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 019C11042;
        Fri, 15 May 2020 05:13:52 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56B4B3F305;
        Fri, 15 May 2020 05:13:50 -0700 (PDT)
Date:   Fri, 15 May 2020 13:13:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200515121343.GC22393@gaia>
References: <20200429164705.GF30377@arm.com>
 <20200430162316.GJ2717@gaia>
 <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
 <20200514113722.GA1907@gaia>
 <20200515103839.GA22393@gaia>
 <20200515111359.GC27289@arm.com>
 <20200515112740.GB22393@gaia>
 <20200515120433.GE27289@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515120433.GE27289@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 15, 2020 at 01:04:33PM +0100, Szabolcs Nagy wrote:
> The 05/15/2020 12:27, Catalin Marinas wrote:
> > Thanks Szabolcs. While we are at this, no-one so far asked for the
> > GCR_EL1.RRND to be exposed to user (and this implies RGSR_EL1.SEED).
> > Since RRND=1 guarantees a distribution "no worse" than that of RRND=0, I
> > thought there isn't much point in exposing this configuration to the
> > user. The only advantage of RRND=0 I see is that the kernel can change
> 
> it seems RRND=1 is the impl specific algorithm.

Yes, that's the implementation specific algorithm which shouldn't be
worse than the standard one.

> > the seed randomly but, with only 4 bits per tag, it really doesn't
> > matter much.
> > 
> > Anyway, mentioning it here in case anyone is surprised later about the
> > lack of RRND configurability.
> 
> i'm not familiar with how irg works.

It generates a random tag based on some algorithm.

> is the seed per process state that's set up at process startup in some
> way? or shared (and thus effectively irg is non-deterministic in
> userspace)?

The seed is only relevant if the standard algorithm is used (RRND=0).

-- 
Catalin
