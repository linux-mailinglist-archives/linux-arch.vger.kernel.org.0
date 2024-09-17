Return-Path: <linux-arch+bounces-7345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC097AFD5
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 13:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC711F24636
	for <lists+linux-arch@lfdr.de>; Tue, 17 Sep 2024 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5AE16193C;
	Tue, 17 Sep 2024 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BYufc599";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0W9NCMyQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4F1531CC;
	Tue, 17 Sep 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573835; cv=none; b=l41ELfvNnrBOrJQODVKqhY6HPjBs8PSGBvhfKktWs4ApkBcGt82txXN4riaPq15Zj5zTnWuQ0l8uInzqDiGXNb7qMVmacNnTByb6D3pkiCSuuHrswh0kqOr9taZm4gx3bwuaf8MIaB/2+l+6qtxkiK6qAqcwwwYNU6sKz7kfEe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573835; c=relaxed/simple;
	bh=V7zuHvgXuRc8iq2E+pOOYB04xiPvo3LhqGRkCJZlQZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FDND5+qG/oIQD8zsTQwOFmzyTusXxbp8lCAbsEXgIXwgy+CkguCKzIT1/1k6IGT3n+QfkflDehcdeGo8/F7wD0aaoL/EofwdGZgyBiZ1uVK+07RPuPUoVGfWMtgOLjNIl8q/bxoArFgGbiepiWi1uz3LiFXMk6Sr6DrUNugWncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BYufc599; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0W9NCMyQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726573826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNebPkkCATOz/8G2Ty+8PI8yqXvC2oGmbRAGfEPpIEQ=;
	b=BYufc599OW5+qnbK4980v4vs8tbQ87dmQIKHUIPm3bX0LdTh0yIimmqTGgpRF4pdPWiMQ/
	9atAPwy9bSVufVu+YVSgJRUcHYhyAZXzi70kAHjGnnew2XCIKo6bSYoarnmjAdCO8coEc+
	nGYLJhoqUfmAsEP1lx4eG7K9Ilf00dKu7Y4/Wv8fktbDVILaQe2r8tZhjww40k8cslhg0+
	vxwi/ZrPIiQuKFeSlDldo1u+YI/eJCpR28+wc0QfOP/DxCzgbjls4tyLRTIT1q6YwvvynM
	xzD5E20+n5g/hImN0kKjIE50A5ZLyfqcK3N4s46/l+BF23pdTEpg8rSLzjDZ/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726573826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNebPkkCATOz/8G2Ty+8PI8yqXvC2oGmbRAGfEPpIEQ=;
	b=0W9NCMyQ+egH0HM5V0+4TQQneA5B2GzQAI0DJcSHVUfp/Ie0VUkXoSOjbkPqE/A0+QEHRs
	mDGYjLCZ8ngz+7CA==
To: Will Deacon <will@kernel.org>, "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: kernel test robot <lkp@intel.com>, Christoph Lameter via B4 Relay
 <devnull+cl.gentwo.org@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load
 acquire
In-Reply-To: <20240917073703.GB27290@willie-the-truck>
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <202409132135.ki3Mp5EA-lkp@intel.com>
 <766fe92a-13da-f299-0ecf-f8a477d58a79@gentwo.org>
 <20240917073703.GB27290@willie-the-truck>
Date: Tue, 17 Sep 2024 13:50:25 +0200
Message-ID: <87r09i1ou6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Cc+ i915 people

On Tue, Sep 17 2024 at 08:37, Will Deacon wrote:
> On Mon, Sep 16, 2024 at 10:52:18AM -0700, Christoph Lameter (Ampere) wrote:
>> On Fri, 13 Sep 2024, kernel test robot wrote:
>> 
>> > >> drivers/gpu/drm/i915/gt/intel_tlb.h:21:47: error: macro "seqprop_sequence" requires 2 arguments, but only 1 given
>> 
>> From 15d86bc9589f16947c5fb0f34d2947eacd48f853 Mon Sep 17 00:00:00 2001
>> From: Christoph Lameter <cl@gentwo.org>
>> Date: Mon, 16 Sep 2024 10:44:16 -0700
>> Subject: [PATCH] Update Intel DRM use of seqprop_sequence
>> 
>> One of Intels drivers uses seqprop_sequence() for its tlb sequencing.
>> We added a parameter so that we can use acquire. Its pretty safe to
>> assume that this will work without acquire.
>>
>> Signed-off-by: Christoph Lameter <cl@linux.com>
>> ---
>>  drivers/gpu/drm/i915/gt/intel_tlb.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/gpu/drm/i915/gt/intel_tlb.h b/drivers/gpu/drm/i915/gt/intel_tlb.h
>> index 337327af92ac..81998c4cd4fb 100644
>> --- a/drivers/gpu/drm/i915/gt/intel_tlb.h
>> +++ b/drivers/gpu/drm/i915/gt/intel_tlb.h
>> @@ -18,7 +18,7 @@ void intel_gt_fini_tlb(struct intel_gt *gt);
>> 
>>  static inline u32 intel_gt_tlb_seqno(const struct intel_gt *gt)
>>  {
>> -	return seqprop_sequence(&gt->tlb.seqno);
>> +	return seqprop_sequence(&gt->tlb.seqno, false);
>>  }
>
> Yikes, why is the driver using the seqlock internals here? It's a bit of
> a pity, as a quick grep suggest that this is the _only_ user of
> 'seqcount_mutex_t', yet it's still having to work around the API.

Why the hell can't i915 use the proper interfaces and has to bypass the
core code? Just because C allows that does not make it correct.

Can the i915 people please remove this blatant violation of layering?

Thanks,

        tglx


