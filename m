Return-Path: <linux-arch+bounces-7344-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20F97AC42
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 09:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9D01F2288E
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 07:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DC11482E2;
	Tue, 17 Sep 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djEG01Z0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77E7BB15;
	Tue, 17 Sep 2024 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558630; cv=none; b=fhTRHppoX4WnA/Y2zFTKgit8oScqLawWmzq2P7HbUjcqxDFlPnkATjiflJsMO6IGTaAUQc+HIKwHzYvBzuP0DbAXHijKvrG3BynV2dTHIUJhC5+FHZUF09eRS16/nHK0nRGcjBexOpnqzBf7duxniprOSKg1944Vp3IM6ACunFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558630; c=relaxed/simple;
	bh=jpSqmeV4F8zvF9gkT0QL3/l+GMRq3zlBQCNkbcrgjFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+FGvcqVw8yVt2/ZdedONpOk3kD0/6zETFcVplMihSZ5nq7p0FALPorjYBYj8bBpP8T2hRG3f3y12BwZsZu0qBBbqqNZJZlStRsPkMxJJceqbU93Wdb8KQ4bHCf3m6Ogqc20+hbqbHliRrx84G5kTxDxkbm6dsPKV2r4Vwz7BtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djEG01Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56FBC4CEC6;
	Tue, 17 Sep 2024 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726558630;
	bh=jpSqmeV4F8zvF9gkT0QL3/l+GMRq3zlBQCNkbcrgjFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djEG01Z03mYMCo6cGpoxgBOctC+8R09k+5yhS2FWuRaTQKORUCzKReDXfyVe+ly9L
	 U60FnjgoNpoW5qqYO+q/+fsHhyl27CC2cnM5UK5sfAkAt5ufz1+DgT4O8eSaBNDD2s
	 ryBMQZF6Eur9NS9JbE9XqXJQWt4/ksA0r+Sq7a6kh4VDNjIbV66ZQcEMNOxJZsRyBU
	 ut2P7VOo0atxYVLSlqadbPQ8HAYOWT6e4a9Vb0+CEMB+S0269r8W/qDkl2zhtdgNHj
	 HSbdlpjAta/H/3XEXjzAidptaz3Ci9H2V52zYY8cxDMQg8z0z6Rd1fwZO+arPHIP9Z
	 0Wf3jJslP3Low==
Date: Tue, 17 Sep 2024 08:37:04 +0100
From: Will Deacon <will@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: kernel test robot <lkp@intel.com>,
	Christoph Lameter via B4 Relay <devnull+cl.gentwo.org@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, oe-kbuild-all@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
Message-ID: <20240917073703.GB27290@willie-the-truck>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <202409132135.ki3Mp5EA-lkp@intel.com>
 <766fe92a-13da-f299-0ecf-f8a477d58a79@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <766fe92a-13da-f299-0ecf-f8a477d58a79@gentwo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Sep 16, 2024 at 10:52:18AM -0700, Christoph Lameter (Ampere) wrote:
> On Fri, 13 Sep 2024, kernel test robot wrote:
> 
> > >> drivers/gpu/drm/i915/gt/intel_tlb.h:21:47: error: macro "seqprop_sequence" requires 2 arguments, but only 1 given
> 
> From 15d86bc9589f16947c5fb0f34d2947eacd48f853 Mon Sep 17 00:00:00 2001
> From: Christoph Lameter <cl@gentwo.org>
> Date: Mon, 16 Sep 2024 10:44:16 -0700
> Subject: [PATCH] Update Intel DRM use of seqprop_sequence
> 
> One of Intels drivers uses seqprop_sequence() for its tlb sequencing.
> We added a parameter so that we can use acquire. Its pretty safe to
> assume that this will work without acquire.
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_tlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.h b/drivers/gpu/drm/i915/gt/intel_tlb.h
> index 337327af92ac..81998c4cd4fb 100644
> --- a/drivers/gpu/drm/i915/gt/intel_tlb.h
> +++ b/drivers/gpu/drm/i915/gt/intel_tlb.h
> @@ -18,7 +18,7 @@ void intel_gt_fini_tlb(struct intel_gt *gt);
> 
>  static inline u32 intel_gt_tlb_seqno(const struct intel_gt *gt)
>  {
> -	return seqprop_sequence(&gt->tlb.seqno);
> +	return seqprop_sequence(&gt->tlb.seqno, false);
>  }

Yikes, why is the driver using the seqlock internals here? It's a bit of
a pity, as a quick grep suggest that this is the _only_ user of
'seqcount_mutex_t', yet it's still having to work around the API.

Will

