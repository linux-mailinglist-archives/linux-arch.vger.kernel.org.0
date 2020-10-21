Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA9294EC5
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443018AbgJUOfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 10:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443017AbgJUOfT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 10:35:19 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32512224E;
        Wed, 21 Oct 2020 14:35:16 +0000 (UTC)
Date:   Wed, 21 Oct 2020 15:35:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add support for Asymmetric AArch32 systems
Message-ID: <20201021143513.GE3976@gaia>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021112656.GB1141598@kroah.com>
 <20201021131504.vc3nbf2vt5dtiuva@e107158-lin>
 <20201021133105.GA1164216@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021133105.GA1164216@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 03:31:05PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 21, 2020 at 02:15:04PM +0100, Qais Yousef wrote:
> > > Without even looking at the patch set, this is not ok...
> > 
> > Sorry about that. Please keep in mind we're still debating if we want to
> > support this upstream.
> 
> What do you mean by this?
> 
> Do you mean you will keep an out-of-tree patchset for all time for all
> future kernel versions for everyone to pull from and you will support
> for all chips that end up with this type of functionality?
> 
> That's a huge task to do, you all must have a lot of money to burn!

From a maintainer perspective (and not as an Arm employee), hopefully
the high cost would be a deterrent to other such hardware combinations
in the future ;). Even if it will (likely) end up in mainline, we
shouldn't make it straightforward.

-- 
Catalin
