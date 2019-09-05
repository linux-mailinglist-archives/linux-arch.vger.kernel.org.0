Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31A47A9C63
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2019 09:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfIEH5n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Sep 2019 03:57:43 -0400
Received: from foss.arm.com ([217.140.110.172]:38734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfIEH5n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Sep 2019 03:57:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0521128;
        Thu,  5 Sep 2019 00:57:42 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A29863F67D;
        Thu,  5 Sep 2019 00:57:40 -0700 (PDT)
Date:   Thu, 5 Sep 2019 08:57:38 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Message-ID: <20190905075735.GC27757@arm.com>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
 <201908292224.007EB4D5@keescook>
 <20190830083415.GI27757@arm.com>
 <201909040942.7BC809C5E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909040942.7BC809C5E@keescook>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 04, 2019 at 05:50:06PM +0100, Kees Cook wrote:
> On Fri, Aug 30, 2019 at 09:34:18AM +0100, Dave Martin wrote:
> > Do you have any thoughts on Yu-Cheng Yu's comments?  It would be nice to
> > early-terminate the scan if we can, but my feeling so far was that the
> > scan is cheap, the number of properties is unlikely to be more than a
> > smallish integer, and the code separation benefits of just calling the
> > arch code for every property probably likely outweigh the costs of
> > having to iterate over every property.  We could always optimise it
> > later if necessary.
> 
> I feel like there are already a lot of ways to burn CPU time with
> mangled ELF files, so this potential inefficiently doesn't seem bad to
> me. If we want to add limits here, perhaps cap the property scan depth
> (right now, IIRC, the count is u32, which is big...)

I was thinking more of valid ELF files where the number of properties is
large.

I feel that the GNU properties system will have become unfit for purpose
if the number of defined properties gets large enough for this to be an
issue though.

I'll keep this code as-is for now.

> > I need to double-check that there's no way we can get stuck in an
> > infinite loop with the current code, though I've not seen it in my
> > testing.  I should throw some malformed notes at it though.
> 
> I think the cursor only performs forward movement, yes? I didn't see a
> loop, but maybe there's something with the program headers that I
> missed.

That's the principle: always step forward, always by a non-zero amount.
So forward progress should be guaranteed...

> > Do you have any objection to merging patch 1 with this one?  For
> > upstreaming purposes, it seems overkill for that to be a separate patch.
> 
> I don't _object_ to it, but I did like having it separate for review.

I'm equally happy to leave them separate; I just wasn't sure how much
they made sense as separate patches.  I'll have a think when I respin.

> > Do you have any opinion on the WARN_ON()s?  They should be un-hittable,
> > so they're documenting assumptions rather than protecting against
> > anything real.  Maybe I should replace them with comments.
> 
> I think they're fine as self-documentation. My rule of thumb has been:
> 
> - don't use BUG*() unless you can defend it to Linus who wants 0 BUG()s.
> - don't use WARN*() if userspace can reach it (and if you're not sure,
>   use the WARN*ONCE() version)
> - use pr_*_ratelimited() if unprivileged userspace can reach it.

OK, I'll probably keep them for now, then.

This isn't a super-hot path, and with multiple kernel_read() calls in
the mix already it's hard to imagine the WARN_ON() calls being a
significant part of the overall cost.

Cheers
---Dave
