Return-Path: <linux-arch+bounces-8512-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2756C9AD8AA
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 01:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD93B2842F5
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 23:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878FC200120;
	Wed, 23 Oct 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="JNNt4dk8"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683C1FF7B9;
	Wed, 23 Oct 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727480; cv=none; b=eLWB3JThhmZp+cm0Ug27tSk7GiNVhbNkaF+Ej6EB/2myhkCWTSiP/hR6M03Wfr14ytl3MMApMQMYY7/bkFSnOmaks/xGk1pA4CeQZ8okeuBAhvtfx+C0RGaxGM/DE5vmw+RGUwhm+4IMSqqY/7j1dbJ2vpLfuJFQpUbWRVm34HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727480; c=relaxed/simple;
	bh=N5Ha61iGv8UBir+niT+G49NgrMxO0LqYfl/tYGxc/84=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jq2EZFIk4kbEarx0kq7iA3sx+1KtmyJU2f78hzWlXFHFD4DDS6EPbzB7bbpbuJ42SZRQodPO03J1UXAdWoQKQVNu38Tn/IEL8cCorzpaloCG2ZWblLwkBlOL5/w9fsMhszCAHrDnwt+ozjB4Uzyhh8rwGFxiVlR2TVy+ctaYPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=JNNt4dk8; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1729726956;
	bh=N5Ha61iGv8UBir+niT+G49NgrMxO0LqYfl/tYGxc/84=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JNNt4dk8tZM9am9qFrK1MgYcweN8QSIWAAfwNjYrXyAPt1rvn0vd3hl5Se8Kdcu6z
	 hYNWi54noABInnYI/bkcV8K8IHxlkI1RA9UP/mofSl0tdyJaYV9DHlFv9hwGBZ+jT3
	 gy6HGfZqRWmvoSzN/namuh8iUPIbDEhCDnh7nz+4=
Received: by gentwo.org (Postfix, from userid 1003)
	id 3F74E4027B; Wed, 23 Oct 2024 16:42:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 3D14040264;
	Wed, 23 Oct 2024 16:42:36 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:42:36 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
    Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
    Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <20241023194543.GD11151@noisy.programming.kicks-ass.net>
Message-ID: <e9fd5ba0-bd84-76a8-a96e-1378c66d0774@gentwo.org>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org> <20240917071246.GA27290@willie-the-truck> <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org> <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
 <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com> <20241023194543.GD11151@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 23 Oct 2024, Peter Zijlstra wrote:

> > I doubt anybody will notice, and smp_load_acquire() is the future. Any
> > architecture that does badly on it just doesn't matter (and, as
> > mentioned, I don't think they even exist - "smp_rmb()" is generally at
> > least as expensive).
>
> Do we want to do the complementing patch and make write_seqcount_end()
> use smp_store_release() ?
>
> I think at least ARM (the 32bit thing) has wmb but uses mb for
> store_release. But I also think I don't really care about that.

The proper instruction would be something like

atomic_inc_release(&seqcount)

The current atomics do not provide such a macro.

The closest in the current tree is atomic_inc_return_release().

We would prefer atomic_inc_release(&seqcount) because such an
atomic may be executed as a far atomic in the ARM mesh.

This could be cheaper than a local atomic and could f.e. be executed
on the memory controller of a remote NUMA node in order to avoid a costly
transfer of cacheline ownership.

The code generated is a atomic that also does a release. So there would be
no extra barrier etc needed.



