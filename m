Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DFF13B689
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 01:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgAOAZ2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 19:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbgAOAZ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 19:25:28 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7362524658;
        Wed, 15 Jan 2020 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579047927;
        bh=t47i4w95/DIUUMrwWQ8/0OpI2zfXnSX/nTKhPDQjj3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C04IgBqNac5Tr6TP2KFYhPKu9LtJWqxYSm3atW4PhXrvKpzVK781u9g36NgSHZeB/
         by+Mas1xVtmq/5iyd5yBA8zZBK+vC86Fz9vLo4aTdUO1a83UCr18jqR9DVBTn0LxiX
         5gZBfQvAwfCPjehY4gCn6jGnQKWjjtCaNrnxsdYM=
Date:   Tue, 14 Jan 2020 16:25:26 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     peterz@infradead.org, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Fixup page directory freeing
Message-Id: <20200114162526.87863ebce00695cc979b5217@linux-foundation.org>
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 14 Jan 2020 15:31:36 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> This is a repost of patch series from Peter with the arch specific changes except ppc64 dropped.
> ppc64 changes are added here because we are redoing the patch series on top of ppc64 changes. This makes it
> easy to backport these changes. Only the first 3 patches need to be backported to stable. 

But none of these patches had a cc:stable in the changelog?

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
