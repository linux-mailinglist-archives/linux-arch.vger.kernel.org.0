Return-Path: <linux-arch+bounces-10894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F938A63936
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 01:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6886F188CC92
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 00:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087017583;
	Mon, 17 Mar 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mpzZndO/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6BB67A;
	Mon, 17 Mar 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742172633; cv=none; b=f4n8UUU4ZH5lbGgHVqVK7lZovBPq38RBNOEB9u/StO2Lr0EutYJjdVdrNySE9uaNyAMvf3bbnYedmFVD7MX3IAklqi6OMeqSzNYkMByvycIszXk76Ou0vjByNB6XeHk8GC9IQkmQGrOLSpwFBiGOfKeNx5EN23GTqEK18SI0Z4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742172633; c=relaxed/simple;
	bh=/AOSe7aq0nChqdQRh86alo+MWwYHvaes5E17kFYiFIA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qjum72+3SMt1hyWy6DC3WNWIsEPQwcFSeIxz8zqCR90RaICJcrxgVrprSUllxNUANSK3WQN4VAtQj0est+5XRLWoxABmx7yX07Hj6yIn/oMtnogQeELW6Xix4KEZOS5ytP5HpxxYWI3A71YFAUEsq5jKaKgeID+Cvu/55wDZ3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mpzZndO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3B7C4CEDD;
	Mon, 17 Mar 2025 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1742172631;
	bh=/AOSe7aq0nChqdQRh86alo+MWwYHvaes5E17kFYiFIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mpzZndO/iEMbjsNstWhXiw29qloZefDjGCjbdLzVbu8AWoIP3rbYu8gvByPEebqZO
	 NQ94QS0uXpMoe4gHl20GGVqOEHi5wEnf+zVu6U5DIoTK8/zhixuSeyc7J4gmPPZhtv
	 jLgyPg2YA52XiVmTXCDcz7B6AaOcaYYiNRKZnq6w=
Date: Sun, 16 Mar 2025 17:50:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Jann Horn <jannh@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v4] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-Id: <20250316175030.e929cab808c976995ec662b2@linux-foundation.org>
In-Reply-To: <61e3ea6a-368a-640f-a050-b56c8d3232b5@google.com>
References: <20250127195321.35779-1-roman.gushchin@linux.dev>
	<61e3ea6a-368a-640f-a050-b56c8d3232b5@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 12:55:11 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> > Fix this by moving the tlb flush out of tlb_end_vma() into
> > free_pgtables(), somewhat similar to the stable version of the
> > original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> > for PFNMAP mappings before unlink_file_vma()").
> > 
> > Note, that if tlb->fullmm is set, no flush is required, as the whole
> > mm is about to be destroyed.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Nick Piggin <npiggin@gmail.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > 
> > ---
> > 
> > v4:
> >   - naming/comments update (by Peter Z.)
> >   - check vma->vma->vm_flags in tlb_free_vma() (by Peter Z.)
> 
> Let me just put on record: you were absolutely right not to extend to
> this the Ack I gave to v3, this v4 is silly (tlb_free_vma() and its
> multiple calls, necessary only because of the unnecessary extra test);
> but I don't see it as doing any actual damage, so I'll stop short of
> NAKking it.

I think I'll just drop this.  Let's revisit in the next -rc cycle,
if Roman is motivated.

