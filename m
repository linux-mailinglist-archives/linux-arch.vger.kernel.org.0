Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A3524E710
	for <lists+linux-arch@lfdr.de>; Sat, 22 Aug 2020 13:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHVLbr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Aug 2020 07:31:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgHVLbn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Aug 2020 07:31:43 -0400
Received: from gaia (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE41820738;
        Sat, 22 Aug 2020 11:31:40 +0000 (UTC)
Date:   Sat, 22 Aug 2020 12:31:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>, nd@arm.com,
        libc-alpha@sourceware.org, Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Matthew Malcomson <Matthew.Malcomson@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200822113138.GC16635@gaia>
References: <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com>
 <20200807151906.GM6750@gaia>
 <20200810141309.GK14398@arm.com>
 <20200811172038.GB1429@gaia>
 <20200812124520.GP14398@arm.com>
 <20200819095453.GA86@DESKTOP-O1885NU.localdomain>
 <20200820164313.GL29343@arm.com>
 <80a8937b-6e48-44ce-221c-84c6d27b211d@cs.ucla.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80a8937b-6e48-44ce-221c-84c6d27b211d@cs.ucla.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 20, 2020 at 10:27:43AM -0700, Paul Eggert wrote:
> On 8/20/20 9:43 AM, Szabolcs Nagy wrote:
> > the compat issue with this is existing code
> > using pointer top bits which i assume faults
> > when dereferenced with the mte checks enabled.
> > (although this should be very rare since
> > top byte ignore on deref is aarch64 specific.)
> 
> Does anyone know of significant aarch64-specific application code that
> depends on top byte ignore? I would think it's so rare (nonexistent?) as to
> not be worth worrying about.

Apart from the LLVM hwasan feature, I'm not aware of code relying on the
top byte ignore. There were discussions in the past to use it with some
JITs but I'm not sure they ever materialised.

I think the Mozilla JS engine uses (used?) additional bits on top of a
pointer but they are masked out before the access.

> Even in the bad old days when Emacs used pointer top bits for typechecking,
> it carefully removed those bits before dereferencing. Any other
> reasonably-portable application would have to do the same of course.

I agree.

-- 
Catalin
