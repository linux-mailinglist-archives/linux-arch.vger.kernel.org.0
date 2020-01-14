Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A913A7B6
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 11:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgANKuM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 05:50:12 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42186 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgANKuM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 05:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zpOpHUjbhC0rJlP6b+TZpjlC26yEgKMY83qh9k5bu3U=; b=06WPGrTR6s6NFO7DsI67V5+Wb
        czeAIAK6w/njHcQBpq93jCuo23ME14WPrkiMr/UMjsHGO4vzBJNoFc9LXxprLIKuw3e+y2ZUtBvLZ
        tesAN9rgpIW2rciGL43nVoFli7oDpK4HQ3iFt49iyuScNAwqus9zOxEK3vcqfYuHzFIeaPs0BBAi7
        lninJVJH/XZ/XwdXFmS0UNyoy8ad6Pjp7JZ2risRViJXfec0wFZmyDB8U3Jbovtk1HYPR8Pb7tIZT
        HHzHcW9AuK70ebMSNFvqwaf3Oa8sKUUNUr4K72419Hr6A4bsNCLcv3Ssh0Fpm7qAmHGI9JhHtBhUb
        Y5/ugemyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irJls-0008BE-LF; Tue, 14 Jan 2020 10:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 45F9C304123;
        Tue, 14 Jan 2020 11:48:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B42629D73921; Tue, 14 Jan 2020 11:50:02 +0100 (CET)
Date:   Tue, 14 Jan 2020 11:50:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Fixup page directory freeing
Message-ID: <20200114105002.GD2844@hirez.programming.kicks-ass.net>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 03:31:36PM +0530, Aneesh Kumar K.V wrote:
> This is a repost of patch series from Peter with the arch specific changes except ppc64 dropped.
> ppc64 changes are added here because we are redoing the patch series on top of ppc64 changes. This makes it
> easy to backport these changes. Only the first 3 patches need to be backported to stable. 
> 
> The thing is, on anything SMP, freeing page directories should observe the
> exact same order as normal page freeing:
> 
>  1) unhook page/directory
>  2) TLB invalidate
>  3) free page/directory
> 
> Without this, any concurrent page-table walk could end up with a Use-after-Free.
> This is esp. trivial for anything that has software page-table walkers
> (HAVE_FAST_GUP / software TLB fill) or the hardware caches partial page-walks
> (ie. caches page directories).
> 
> Even on UP this might give issues since mmu_gather is preemptible these days.
> An interrupt or preempted task accessing user pages might stumble into the free
> page if the hardware caches page directories.
> 
> This patch series fixup ppc64 and add generic MMU_GATHER changes to support the conversion of other architectures.
> I haven't added patches w.r.t other architecture because they are yet to be acked.

Obviously looks good to me; will you route this through the Power tree
since you're in a hurry to see this fixed?
