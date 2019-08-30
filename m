Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A68A36EA
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfH3MkM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 08:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfH3MkM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 08:40:12 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB08C21721;
        Fri, 30 Aug 2019 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567168812;
        bh=lLptPwKn0tTJaFJErmpbfjiivzsXJmC7RMXED4vz13Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nagIpY953/BMv+Q4pPCwalOrZwg2N0AQz1dWVippIw+R6rAQ2eDXJXYq4V049z/HZ
         jTGBofj789Sr56WgH2FP0VG5ViBN2dF52aabX3N/QGIMc6aQkuPWnRck2V9F6kJJeI
         IzerRXSCcK8thqGz3M6ltuOef57hyxM8wGgeV1dU=
Date:   Fri, 30 Aug 2019 13:40:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] Fix TLB invalidation on arm64
Message-ID: <20190830124007.z6f2qjujzluntrwb@willie-the-truck>
References: <20190827131818.14724-1-will@kernel.org>
 <1566947104.2uma6s0pl1.astroid@bobo.none>
 <20190828161256.uevoohval4sko24m@willie-the-truck>
 <1567085427.12jzc6eq6j.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567085427.12jzc6eq6j.astroid@bobo.none>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 30, 2019 at 12:08:52AM +1000, Nicholas Piggin wrote:
> Will Deacon's on August 29, 2019 2:12 am:
> > On Wed, Aug 28, 2019 at 10:35:24AM +1000, Nicholas Piggin wrote:
> >> From the other side of the fabric you have no such problem. The table
> >> walker is cache coherent apart from the local stores, so we don't need a 
> >> special barrier on the other side. That's why ptesync doesn't broadcast.
> > 
> > Curious: but do you need to do anything extra to take into account
> > instruction fetch on remote CPUs if you're mapping an executable page?
> > We added an IPI to flush_icache_range() in 3b8c9f1cdfc5 to handle this,
> > because our broadcast I-cache maintenance doesn't force a pipeline flush
> > for remote CPUs (and may even execute as a NOP on recent cores).
> 
> Ah, I think the tlbie does not force re-fetch indeed. We may need
> something like that as well.
> 
> What do you do on the user side? Require threads to ISB themselves?

I think they'd probably have to use sys_membarrier() with
MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, yes.

Will
