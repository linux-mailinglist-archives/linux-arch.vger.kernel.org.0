Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00B0294D82
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 15:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392158AbgJUNa2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 09:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392144AbgJUNa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 09:30:28 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701792071A;
        Wed, 21 Oct 2020 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603287026;
        bh=GSjuoFu9OaFRSGYXjDmP3io5XtylKhQQISW5HO5TsMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w2BsJD/LiP1XZk2DrYgEuGou6fSlt4Wu84UKkOhMAEbrsa1c0D8wDipSifpM2GT2f
         +dIOXoMN68jHFGuFrnzCmi/Wx1thDnxfuWqDN8ZPDHaqXRHidQTngFgAJGUnWv1aOu
         oBIjDMkyaQLdvGSyEbm3slhcRsCQjBVfVqBE5br4=
Date:   Wed, 21 Oct 2020 15:31:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add support for Asymmetric AArch32 systems
Message-ID: <20201021133105.GA1164216@kroah.com>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021112656.GB1141598@kroah.com>
 <20201021131504.vc3nbf2vt5dtiuva@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021131504.vc3nbf2vt5dtiuva@e107158-lin>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 02:15:04PM +0100, Qais Yousef wrote:
> > Without even looking at the patch set, this is not ok...
> 
> Sorry about that. Please keep in mind we're still debating if we want to
> support this upstream.

What do you mean by this?

Do you mean you will keep an out-of-tree patchset for all time for all
future kernel versions for everyone to pull from and you will support
for all chips that end up with this type of functionality?

That's a huge task to do, you all must have a lot of money to burn!

It is a "trivial cost" to get changes merged upstream compared to the
amount of time and money it costs to keep stuff out of the tree.  Why
you would not want to do this is beyond me.

But hey, I'm not in charge of your company's budget, for good reasons :)

good luck!

greg k-h
