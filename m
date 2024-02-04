Return-Path: <linux-arch+bounces-2079-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E8848D85
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 13:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841911C20FA3
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0196922618;
	Sun,  4 Feb 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPKMz2Ub"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE472260C;
	Sun,  4 Feb 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048933; cv=none; b=uJYh3aBXTjaogIMJHWnzbYSaH0YvrC4BREI499fn2uQKiLRyl5aJfRhMiLrInh1TvnPyc624dfCVNrMtUCCsTZCuylQ1BV/WcMl/hePfcjCmXYm5rNA3MYHKqiBKVp29lrDxM8Dx5WCdD4AyBrLKiuyGgraHve/PQin87iSpbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048933; c=relaxed/simple;
	bh=4wQVnyZkqM9ZkKkYrxE4cjx2wJXAt5jGMzRqxojtYTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA2/cDg/7XjhkZFmFcOQvjZyFwgH1IK7BSGtuemo1Stm8wMSYb6Ilv5UBdALW6ej9zVwcuRQIbijTRrb1hAWAnkMocOI2l/zigLk1El8oLVAkuk2Bs9O9369+LVB6dbFTIMKp/2whyYbfZk1RSLBLjIstFV6P1Ckx5kyRxqlBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPKMz2Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FD5C433F1;
	Sun,  4 Feb 2024 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707048933;
	bh=4wQVnyZkqM9ZkKkYrxE4cjx2wJXAt5jGMzRqxojtYTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPKMz2Ubcsw3jIma98yrbStdwh3KVrJIe0DpVO2pr10RTT41XeeKHATPQy5TkPeL7
	 3nsQi9VE87S5ksghMe5LDHP8uqrDNlDaL8iVNHJnvk6qJFvjYhYTsu7oXQi2DSEISI
	 TrVPWwtW/5VZNJK3UhXv9IVFl78OAP7d04j+D09v4zdskPXpAOtR2bhfrcLlB/5qCt
	 clbOWmRgNmOTjfZAs7hJCvLYSBSVOq8ldozOcEGDD+hU57W/WZnC61z4B0hKP9xMxf
	 /OXQQlx7cUPaK0nvR6Vwd8pl9bcKqg2gFhEVmi3L33a5KW6LiVXnxgGtD85d/oeEuA
	 A7Jz5+A+0jhig==
Date: Sun, 4 Feb 2024 13:15:24 +0100
From: Mike Rapoport <rppt@kernel.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, muchun.song@linux.dev,
	david@redhat.com, willy@infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: pgtable: add missing flag and statistics for
 kernel PTE page
Message-ID: <Zb9_3K2Kp9d-dtcV@kernel.org>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
 <Zb9t7WtFbZofN5WZ@kernel.org>
 <3b7e9435-d78e-4430-98d1-f4a839899425@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7e9435-d78e-4430-98d1-f4a839899425@bytedance.com>

On Sun, Feb 04, 2024 at 07:39:38PM +0800, Qi Zheng wrote:
> Hi Mike,
> 
> On 2024/2/4 18:58, Mike Rapoport wrote:
> > On Thu, Feb 01, 2024 at 04:05:40PM +0800, Qi Zheng wrote:
> > > For kernel PTE page, we do not need to allocate and initialize its split
> > > ptlock, but as a page table page, it's still necessary to add PG_table
> > > flag and NR_PAGETABLE statistics for it.
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > ---
> > >   include/asm-generic/pgalloc.h |  7 ++++++-
> > >   include/linux/mm.h            | 21 ++++++++++++++++-----
> > >   2 files changed, 22 insertions(+), 6 deletions(-)
> > 
> > This should also update the architectures that define
> > __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL, otherwise NR_PAGETABLE counts will get
> > wrong.
> 
> Yes, this patchset only focuses on the generic implementation. For those
> architectures that define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL, some reuse
> the generic __pte_alloc_one_kernel(), but some have their own customized
> implementations, which indeed need to be fixed.
> 
> I wasn't familiar with those architectures and didn't investigate why
> they couldn't reuse the generic __pte_alloc_one_kernel(), so I didn't
> fix them.

But with your patch NR_PAGETABLE will underflow e.g. on arm and it'd be a
regression for no good reason.

> It would be better if there are maintainers corresponding to
> the architecture who can help fix it. After all, they have a better
> understanding of the historical background and have a testing
> environment. ;)

-- 
Sincerely yours,
Mike.

