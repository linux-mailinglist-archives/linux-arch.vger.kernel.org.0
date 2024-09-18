Return-Path: <linux-arch+bounces-7352-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FDA97BB6D
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 13:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181771C24676
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF90180A6A;
	Wed, 18 Sep 2024 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="RnYf2xIj"
X-Original-To: linux-arch@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB71714B8;
	Wed, 18 Sep 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658148; cv=none; b=mFZKnUcxODtQfD43dbG5U8YJYc61WXUH3s2SQnH9CLB4GCfAqSOcEZwQOYWApxUIazXDEsa2iQcOtWkAuEDDip0Jw1m2wBEmbxKmxQPqNqX9nj4Z03YOYhRVjI/B0Bau9e+MC4FRE2dfspZTnKVEE1UsgpHMI3w5J0WFX5vRT+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658148; c=relaxed/simple;
	bh=ZgUWGooFw76r+k5wBvmlHDduQIe0avoz9de+sDKki94=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z/9PV9Yu90MCaPzAEAT2k+GTRJEj7fa94XXXWGK2QxBbqTcNGwCaLtmnVU1+R0Vt+E7G10aXsoYGJ/euRSHKA9tsGpGlLkYoDUnY0/i7L98sAVbpKFsC91HhPSvgLIpoMMuPD3g36EMcXBZPBY5TwqjYFVsIVTa8SoG71ynm1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=RnYf2xIj; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1726657424;
	bh=ZgUWGooFw76r+k5wBvmlHDduQIe0avoz9de+sDKki94=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RnYf2xIjia8kxFaxgE5zNbG1A4jQohfdQhO9/HqyD7NHlSSZ+uqty1MGTQhdUUSnB
	 4+e7y0HXJ78In+FNkWr+1jUsmr10WlgqINk7f04CDnG+iUb19ZniyUC2k15r+u4xoO
	 //LIPfjTRRkUHc71bLql/EdvKlGy+hUvgvnJAXII=
Received: by gentwo.org (Postfix, from userid 1003)
	id 7D55D401CA; Wed, 18 Sep 2024 04:03:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 7C90A401C5;
	Wed, 18 Sep 2024 04:03:44 -0700 (PDT)
Date: Wed, 18 Sep 2024 04:03:44 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Will Deacon <will@kernel.org>
cc: Thomas Gleixner <tglx@linutronix.de>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <20240917071246.GA27290@willie-the-truck>
Message-ID: <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org> <20240917071246.GA27290@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Sep 2024, Will Deacon wrote:

> > +config ARCH_HAS_ACQUIRE_RELEASE
> > +	bool
> > +	help
> > +	  Setting ARCH_HAS_ACQUIRE_RELEASE indicates that the architecture
> > +	  supports load acquire and release. Typically these are more effective
> > +	  than memory barriers. Code will prefer the use of load acquire and
> > +	  store release over memory barriers if this option is enabled.
> > +
>
> Unsurprisingly, I'd be in favour of making this unconditional rather than
> adding a new Kconfig option. Would that actually hurt any architectures
> where we care about the last few shreds of performance?

Other arches do not have acquire / release and will create additional
barriers in the fallback implementation of smp_load_acquire. So it needs
to be an arch config option.

> > +	if (USE_COND_LOAD_ACQUIRE)
> > +		return smp_cond_load_acquire((unsigned int *)&s->sequence, (s->sequence & 1) == 0);
>
> This looks wrong to me.
>
> The conditional expression passed to smp_cond_load_acquire() should be
> written in terms of 'VAL', otherwise you're introducing an additional
> non-atomic access to the sequence counter.

Hmmm... The compiler seems to have optimized that out. Will use VAL in
next rollup.


