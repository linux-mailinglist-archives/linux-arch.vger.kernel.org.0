Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB3122B0E4
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGWOA0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWOA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 10:00:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313FBC0619DC;
        Thu, 23 Jul 2020 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KJdNCW9/AeNTwbi0vonPFAdv6yCODfnRKfbwoV1pAmc=; b=aHknsQattCTLqx9Xifdf0U4KjV
        ys1rkNEy5yd9BDfxLIPuAhP1o15Re38t9kHAfy53kiCMHm1rrZeULc5Ls6Joh20xna6uoQOrfjAvK
        xEStBYKjqwu0NspaoQEqh+7FkHDyMdn6aMP4qqpgEgSC085tYzi8O4VJa5cEHx3MvJ+EdWAFyRWde
        V20QvR719AoWFdEgRqlYfSPdG5BSPlvbty+fnF/w+RFjvsrRDcgNmbdpaZvfz3vhEh5qsusNkgZPd
        A/zTIwQ73gWoLzUWA7V/MMEOXoE3O2/FmIF1CjP2MqLnR6z1+cJK8LV00dfdvfHJugTPz7EHVir2q
        q88kG/ng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jybld-0003bC-Nr; Thu, 23 Jul 2020 14:00:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAFF0983422; Thu, 23 Jul 2020 16:00:11 +0200 (CEST)
Date:   Thu, 23 Jul 2020 16:00:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Message-ID: <20200723140011.GR5523@worktop.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 09, 2020 at 12:06:13PM -0400, Waiman Long wrote:
> We don't really need to do a pv_spinlocks_init() if pv_kick() isn't
> supported.

Waiman, if you cannot explain how not having kick is a sane thing, what
are you saying here?
