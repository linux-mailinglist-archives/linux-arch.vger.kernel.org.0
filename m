Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8042885F0
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbgJIJ0G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbgJIJ0G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 05:26:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F1C0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 02:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JNGNyWioD2qy2twOLu4S3eTj6REIroIWKQfPbqNIF/w=; b=cwKNd47XGQ3mYFqgcBeM2C8YGo
        ZA0nEJJrKMg0yGkgSVrbrB3lpsnEHvHlCPGVD1xFg2Bcb7ftEFvTCtK9OKI1QxbFiynmZRXOgce6q
        psYrpVvpjHNmXLXC23wnFKn96vuZHqdXO+lU3m3Mg+xu5bHeXEWWwNcbJW59171RTCt+YZ2HsWiO9
        ECve1uP6HxAw7vrLMbnUfET0Cr6SWmmzgr9Et0mvViUOIcW1xNDA/6dE2WXyerwL1637FtlPZ918b
        FayNUZXR6XiooY5X/OqDSH5jPeAFaH+kxziFe3rVfJvC22ngH1I7BXZ10xozSRnc0pASwP2e+aOEu
        k5DFiMXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQof1-0003iJ-TU; Fri, 09 Oct 2020 09:26:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73EC9301A42;
        Fri,  9 Oct 2020 11:25:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C16229E7878A; Fri,  9 Oct 2020 11:25:59 +0200 (CEST)
Date:   Fri, 9 Oct 2020 11:25:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non
 AArch32 cpu
Message-ID: <20201009092559.GE2628@hirez.programming.kicks-ass.net>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-4-qais.yousef@arm.com>
 <20201009072943.GD2628@hirez.programming.kicks-ass.net>
 <20201009081312.GA8004@e123083-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009081312.GA8004@e123083-lin>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 09, 2020 at 10:13:12AM +0200, Morten Rasmussen wrote:
> On Fri, Oct 09, 2020 at 09:29:43AM +0200, Peter Zijlstra wrote:

> > Fundamentally, you're not supposed to change the userspace provided
> > affinity mask. If we want to do something like this, we'll have to teach
> > the scheduler about this second mask such that it can compute an
> > effective mask as the intersection between the 'feature' and user mask.
> 
> I agree that we shouldn't mess wit the user-space mask directly. Would it
> be unthinkable to go down the route of maintaining a new mask which is
> the intersection of the feature mask (controlled and updated by arch
> code) and the user-space mask?
> 
> It shouldn't add overhead in the scheduler as it would use the
> intersection mask instead of the user-space mask, the main complexity
> would be around making sure the intersection mask is updated correctly
> (cpusets, hotplug, ...).

IFF we _need_ to go there, then yes that was the plan, compose the
intersection when either the (arch) feature(set) mask or the userspace
mask changes.

