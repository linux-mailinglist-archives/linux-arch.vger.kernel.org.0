Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF32E22C085
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 10:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgGXIQy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 04:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgGXIQx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jul 2020 04:16:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 776FE2074A;
        Fri, 24 Jul 2020 08:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595578613;
        bh=MtSSJVr7CkQ6qYnldFXBBhVSH/FImYJYfT41DnqnyfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RwKzdNIM0IbM4QhStWrpabxkbmQfmemxolOJQbQ35i0L7IjfMB2mLxbxDs3yf9OMG
         t5gjDHgkaIcsKKrEcDnxZ3E6OOSzQ0tacBMUiHRqwCuYIXYMIMsfdvbx+wenpuiypB
         b+V/llaOX/7WR8IKO4GbceZdbj7sGKlc3q02Gn3Q=
Date:   Fri, 24 Jul 2020 09:16:48 +0100
From:   Will Deacon <will@kernel.org>
To:     peterz@infradead.org
Cc:     Waiman Long <longman@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Message-ID: <20200724081647.GA16642@willie-the-truck>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
 <20200723184759.GS119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723184759.GS119549@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 23, 2020 at 08:47:59PM +0200, peterz@infradead.org wrote:
> On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
> > BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
> > I will have to update the patch to fix the reported 0-day test problem, but
> > I want to collect other feedback before sending out v3.
> 
> I want to say I hate it all, it adds instructions to a path we spend an
> aweful lot of time optimizing without really getting anything back for
> it.
> 
> Will, how do you feel about it?

I can see it potentially being useful for debugging, but I hate the
limitation to 256 CPUs. Even arm64 is hitting that now.

Also, you're talking ~1% gains here. I think our collective time would
be better spent off reviewing the CNA series and trying to make it more
deterministic.

Will
