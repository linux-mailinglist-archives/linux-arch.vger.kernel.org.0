Return-Path: <linux-arch+bounces-9878-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837FAA1B1BD
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 09:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A93547A38F3
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2025 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F951DAC9F;
	Fri, 24 Jan 2025 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c25q5qLT"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A11D8E16;
	Fri, 24 Jan 2025 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737707509; cv=none; b=M7dqYSnwH3V4EYLJ+WrEn9ZBrQr3HRP2J6zLmSlFUadGEoVxv8As9uNIANQwp8Pv2ky5qOZB2TSq8aCaPRxzexgtUBPEMzxNJmVMe5EPDlpR/mlmGfIi0Vbo01k+fnZmORuYe5UPexoqmv/mXs1eVhYijvy3a6jrqTq0kc7xhW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737707509; c=relaxed/simple;
	bh=j8DATyobJj9OTfl27CHBI+Eu/v0XEabVo28HSG6/qsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgVI/SZXeRxaOfXaVZgWfbEV9wLtdbwTxWdj79/HSDcvEe2lIedt5c33OlDvb7Fk0c8gTBYclWX7NBzUJJO5e0N0EKk8icWrrprQVhPBaJ1HYZp/118sCAojTrQpXSRupj7zDu3zSUPsqtRoo26hS3EHTCT6M6QXTzNMyoj62EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c25q5qLT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iJ9qop8EW3ZQ1g2Is0jbM+VSIIiH3RsTjrVaWWWQR7U=; b=c25q5qLTYw2iymCgniBGAgq6sT
	z3j+HtBHMs6XVZcXa1vKmh5kmikCjlnCqrjcf+qgBwZej7snyzqs5wAqcizASbAHe3HoeQe7k3BbR
	/AwH8+YqCWz93Yv0wJWdCpOA4DxE1wTocywX3tgRIJ7wPUIvvP/lXEX3s6lLW1V4TXEWbRjfCzf3y
	wfSvOsJevZ9NIQf2eA/OAlrPc0i1PdgUWJ+VGzHhWKI+h1dfQM+StMtwnxzT2g/X98ZvK+HnLTZbc
	GsaMPhCNVhH4Rapbi17/d2qhuJsd/9Issm6c7MEItcGcrQNgblfkrVln+eSpHXw/UW9Kmx/MlLX2z
	T3FSuCuQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tbF6K-0000000DyYq-0JDB;
	Fri, 24 Jan 2025 08:31:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2BC09300619; Fri, 24 Jan 2025 09:31:39 +0100 (CET)
Date: Fri, 24 Jan 2025 09:31:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Jann Horn <jannh@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
Message-ID: <20250124083139.GB13226@noisy.programming.kicks-ass.net>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev>
 <20250123214531.GA969@noisy.programming.kicks-ass.net>
 <Z5LM4b2sC1fHgB3p@google.com>
 <26cd41c2-b8b6-0c1d-c36d-28f2f9f369be@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26cd41c2-b8b6-0c1d-c36d-28f2f9f369be@google.com>

On Thu, Jan 23, 2025 at 08:42:36PM -0800, Hugh Dickins wrote:
> The changelog of commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush
> VM_PFNMAP vmas") has not helped me either.  Nor could I locate any
> discussion (Jann, Linus, Peter, Will?) that led up to it.

Hmm, that was probably on security -- I should have those mails around
somewhere, I'll see if I can dig them up.

> To me, Peter's patch looks much like yours, except wth different
> names and comments, plus the "vma" error you point out below.

Yes, 3 differences:

 - naming;
 - the extra check;
 - the vma_pfn clearing condition.

Under the assumption that this is all about those PFNs, the argument
(as also outlined in the email to Roman just now) is that you only need
to flush if both: you have pending TLBI for PFN and are indeed about to
unlink a PFN vma.

If we've flushed the relevant PFNs earlier, for whatever reason,
batching, or the arch has !MERGE_VMAS or whatever, then we do not need
to flush again. So clearing vma_pfn in __tlb_reset_range() is the right
place.

Similarly, if we don't ever actually free/unlink the PFN vma, we also
don't care.

