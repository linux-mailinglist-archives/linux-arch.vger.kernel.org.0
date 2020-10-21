Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17F6294E15
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 15:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411409AbgJUNzw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 09:55:52 -0400
Received: from foss.arm.com ([217.140.110.172]:35666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411321AbgJUNzw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 09:55:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1870731B;
        Wed, 21 Oct 2020 06:55:52 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCA303F66B;
        Wed, 21 Oct 2020 06:55:50 -0700 (PDT)
Date:   Wed, 21 Oct 2020 14:55:48 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add support for Asymmetric AArch32 systems
Message-ID: <20201021135548.kch2nylkbj4wkaoh@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021112656.GB1141598@kroah.com>
 <20201021131504.vc3nbf2vt5dtiuva@e107158-lin>
 <20201021133105.GA1164216@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021133105.GA1164216@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/21/20 15:31, Greg Kroah-Hartman wrote:
> On Wed, Oct 21, 2020 at 02:15:04PM +0100, Qais Yousef wrote:
> > > Without even looking at the patch set, this is not ok...
> > 
> > Sorry about that. Please keep in mind we're still debating if we want to
> > support this upstream.
> 
> What do you mean by this?

Err. I meant that we don't know how and if upstream would like to support this.
The patches are on the list to discuss what it takes for inclusion. Like all
other patches, it could be accepted or rejected. I am working on it to be
accepted *of course* but it's not my decision. I just can't assume or take it
for granted this will go in. I didn't see a straight no yet, so hopefully this
is moving in the right direction.

My point is there's still more discussion to be had and what presented in this
RFC could change completely.

Thanks

--
Qais Yousef

> Do you mean you will keep an out-of-tree patchset for all time for all
> future kernel versions for everyone to pull from and you will support
> for all chips that end up with this type of functionality?
> 
> That's a huge task to do, you all must have a lot of money to burn!
> 
> It is a "trivial cost" to get changes merged upstream compared to the
> amount of time and money it costs to keep stuff out of the tree.  Why
> you would not want to do this is beyond me.
> 
> But hey, I'm not in charge of your company's budget, for good reasons :)
> 
> good luck!
> 
> greg k-h
