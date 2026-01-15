Return-Path: <linux-arch+bounces-15814-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD4FD2900F
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 23:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A16EC3010BFA
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jan 2026 22:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80451327BEC;
	Thu, 15 Jan 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM27FV00"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5AC3242AD;
	Thu, 15 Jan 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515885; cv=none; b=nnX7QCtVwO1Yk/pYX9UasIwlK4Y806cqKdkOayL4eWyHRvqdO183lOTczZPyUaiITLwrENoCeVaf/hhqQ4NHaW5FAOr58vdARgSoTWS/Ti8V/cMHMwC1/f0cs3pFCOUeSMNI/ySarbPI+pe9HMWHsjxuE7F8BvRw/NSop1m++zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515885; c=relaxed/simple;
	bh=9/JTG1V002HGID7njVifhyyVpuQDAOzcJkH22UN1D5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HlKkJdTj/maayhdu8f/l80nt/8pAFwLWDJ9FGMZodnNVjs7BA801k/ZB99MOABwYV+c2T44GU9PGh3X7KjOYWfn6PMUaRZD0xDYVDS6Au9/pB9v5tXQHVgqz0XoyoI/7UJVAQenJPgflP4vhiCvb1h7D86hSMLLS1pXRmlSqG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM27FV00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634B3C116D0;
	Thu, 15 Jan 2026 22:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768515885;
	bh=9/JTG1V002HGID7njVifhyyVpuQDAOzcJkH22UN1D5Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IM27FV00foI84A2mlK1zm7lrFV5hgC3fyW83aJEUcaGx/YkmumLMWJXggzM7hIIG6
	 wHq9ivNiDKuZzX8wPAZ68lxt3FDSZxin9jGu3Ev8p4Yb12ZmPnD8PO48CqLriTwgf/
	 U8mXleZF3ghobZtShDkk0keK+4fzXIi7L52RYv3fSVuJrHJGem+7JrO/GAA2XfETbZ
	 sQHbwNqLLVsrBUOux82jYCkLlAr4s5gGNdJDFsDqKM7h5v2m+75SfR6mWKgLiuIg2B
	 NLfl+86vgTwH6GqccrLhbOFlBPIywROVaI1j62DGeS23XHdtQwiwBd0VUs8sfK4bpd
	 3+KzyQC6zRsWg==
From: Thomas Gleixner <tglx@kernel.org>
To: Luigi Rizzo <lrizzo@google.com>, Marc Zyngier <maz@kernel.org>, Luigi
 Rizzo <rizzo.unipi@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, Sean Christopherson
 <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>, Luigi Rizzo
 <lrizzo@google.com>
Subject: Re: [PATCH v4 3/3] genirq: Adaptive Global Software Interrupt
 Moderation (GSIM).
In-Reply-To: <20260115155942.482137-4-lrizzo@google.com>
References: <20260115155942.482137-1-lrizzo@google.com>
 <20260115155942.482137-4-lrizzo@google.com>
Date: Thu, 15 Jan 2026 23:24:41 +0100
Message-ID: <87pl7a345y.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 15 2026 at 15:59, Luigi Rizzo wrote:
>  /* Initialize moderation state, used in desc_set_defaults() */
>  void irq_moderation_init_fields(struct irq_desc_mod *mod_state)
>  {
> @@ -189,7 +379,9 @@ static int swmod_wr_u32(struct swmod_param *n, const char __user *s, size_t coun
>  	int ret = kstrtouint_from_user(s, count, 0, &res);
>  
>  	if (!ret) {
> +		write_seqlock(&irq_mod_info.seq);

That's broken.

              spin_lock(seq->lock);
              seq->seqcount++;
Interrupt
              ...
              do {
              	read_seqbegin(seq)
                    --> livelock because seqcount is odd

You clearly never ran that code with lockdep enabled because lockdep
would have yelled at you. Testing patches with lockdep is not optional
as documented...

And no, using write_seqlock_irq() won't fix it either as that will still
explode on a RT enabled kernel as documented...

Also this sequence count magic on the read side does not have any real
value:

> +	if (raw_read_seqcount(&irq_mod_info.seq.seqcount) != m->seq) {

Q: What's the gain of this sequence count magic?

A: Absolutely nothing. Once this pulled the cache line in, then the
   sequence count magic is just cargo cult programming because:

      1) The data is a snapshot in any case as the next update might
         come right after that

      2) Once the cache line is pulled in, reading the _three_
         parameters from it (assumed they have been already converted to
         nanoseconds) is basically free and definitely less expensive
         than the seqbegin/retry loop which comes with expensive SMP
         barriers on some architectures.
         
Sequence counts are only useful when you need a consistent data set and
the write side updates the whole data set in one go.

As this is a write one by one operation, there is no consistency problem
and the concurrency is handled nicely by READ/WRITE_ONCE(). Either it
sees the old value or the new.

If you actually update the per CPU instances in the parameter write
functions, you can avoid touching the global cache line completely, no?

Can you please stop polishing your prove of concept code to death and
actually sit back and think about a proper design and implementation?

I don't care at all about you wasting _your_ time, but I very much care
about _my_ time wasted by this.

Thanks,

        tglx

