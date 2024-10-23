Return-Path: <linux-arch+bounces-8499-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C40C9AD58D
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 22:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D79C2813E7
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13F1C9EAF;
	Wed, 23 Oct 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B7oeB1tA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848B15697B
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715678; cv=none; b=iSIzDkmuCt7ZCzy9YApkUyB7BTIu37wap1nNZqVSazb9RQmU3FocDgzd5qaHdxVpa2x+3UwQmI/g6GlcA3iYQzPdFLTJTvv+kaoDLW/lfKJaJR5OFziM6awmjfrwqFeHeIip8o2jOttoI0LeAuqwXywMfDg0P7f05hU04vIUdCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715678; c=relaxed/simple;
	bh=Eb3WWCqlJBEuYN11gpG3daPfKrsqw1rRCRAIlkwBXWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hagg4XXylv1jnD9ztPRLbCeu8qHTOpk+P/pUFgFO+Nja72jPm/EC1JFJtth1jn3wwMra8ddDkcTh4xfVNOoZIhbfLPN8y44Vf2NVNNmDlxbxp40ZCeJyeYb6lbsh6lh2Cnv1bJkMc+iWMXBHVGST3We0or+zQ5wxGAcEJzQpF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B7oeB1tA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so13080766b.2
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729715675; x=1730320475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LEsOPb+l1iotdIHwOTelo3swhljmhVTkrXLfVmt8ycc=;
        b=B7oeB1tAanN6yUFaUpOqHMi3DYp4yaHU1aquBXyc6+ogcynVard2+8QsceCFAgjLaL
         6eXHjEi7i5A7pPTKZdCQdCi6bcVUbMDIxKb0G45K2Buk5OuAidvXw852+6gkuY/6wLJD
         RpnNGvtUIvcUAvaV/KZA7wJKQGmeOFeGBpO7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715675; x=1730320475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEsOPb+l1iotdIHwOTelo3swhljmhVTkrXLfVmt8ycc=;
        b=sh9iZlNMlQqlN3A0daRfdQU/uRCvDSKZOxgtLfKpNopIoeL/0zGy/2Ro7H/eZmfD0R
         p120DoUms3O/wdywHGwEWi02FHrXG8+l5qZ4MKmoK9/scUlEO5C1X9BEW3JD7RFQN/EP
         Cj/43msuj7kb0M3FZAJvrz4yw508ZXR8g8Cv+3vF2niOu5TeY/u28ez3tztVR2j40DZI
         X81kWu+Y4m23SuCBPY5dYqACDoOPAavmrcBLw1iRHkMLYfEqZrCAJ0SmMakySOqpPqLc
         uvd2w3lo+IZ3KgfWnuvAhKkqQQuqXz7Nb/TjVH6tzLYOa5uRh1qQKlJoytb7N42pSEs6
         H1hg==
X-Forwarded-Encrypted: i=1; AJvYcCWRNoEkaxxd/9eAP1gLCRkNtSnynpX2Z2ii8ROJ4iprikB5l1z30AHWZOieXw/O80owEs86rl6pfEJu@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYcPRzf6uvz0vumnroA/ouE7+UOjQxWmNS16oo881Pg1as5CO
	dhxHgYjBsHFIa436VMX1pUfnz5IWJ1Hqoo0jd/xEkM6vqfud1ZmrfJXU9aygIGFtKHN1enu4kFf
	EfaO3vw==
X-Google-Smtp-Source: AGHT+IEzk23KBmL4nr7qNJfSYpxujEPX36x3ylAcQiJ21AVyip28OF6ZJDJYCCOHwWwcBEzSf6KXcg==
X-Received: by 2002:a17:907:3187:b0:a99:f945:8776 with SMTP id a640c23a62f3a-a9abf88a58bmr309352966b.24.1729715674568;
        Wed, 23 Oct 2024 13:34:34 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157360esm515488566b.157.2024.10.23.13.34.33
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 13:34:33 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso15427366b.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 13:34:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX69oWWFfMA3C22bsXBRp0jyn7zDnc7DqIuWFzetKxFQF8Lf6n3VTwvMBKAadKv9jWkK7VJW2ZhAg8I@vger.kernel.org
X-Received: by 2002:a17:907:72cb:b0:a99:87ea:de57 with SMTP id
 a640c23a62f3a-a9abf852bb7mr329557766b.2.1729715672886; Wed, 23 Oct 2024
 13:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <20240917071246.GA27290@willie-the-truck> <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
 <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
 <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com> <20241023194543.GD11151@noisy.programming.kicks-ass.net>
In-Reply-To: <20241023194543.GD11151@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 13:34:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=Ji6-xi32167i3M1JL_YyRj6tgUAJS=YQ94GKzMBvkg@mail.gmail.com>
Message-ID: <CAHk-=wi=Ji6-xi32167i3M1JL_YyRj6tgUAJS=YQ94GKzMBvkg@mail.gmail.com>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load acquire
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:45, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Do we want to do the complementing patch and make write_seqcount_end()
> use smp_store_release() ?
>
> I think at least ARM (the 32bit thing) has wmb but uses mb for
> store_release. But I also think I don't really care about that.

So unlike the "acquire vs rmb", there are architectures where "wmb" is
noticeably cheaper than a "store release".

Just as an example, on alpha, a "store release" is a full memory
barrier followed by the store, because it needs to serialize previous
loads too. But wmp_wmb() is lightweight.

Typically in traditional (pre acquire/release) architectures "wmb"
only ordered the CPU write queues, so "wmb" has always been cheap
pretty much everywhere.

And I *suspect* that alpha isn't the outlier in having a much cheaper
wmb than store-release.

But yeah, it's kind of ugly how we now have three completely different
orderings for seqcounts:

 - the initial load is done with the smp_read_acquire

 - the final load (the "retry") is done with a smp_rmb (because an
acquire orders _subsequent_ loads, not the ones inside the lock: we'd
actually want a "smp_load_release()", but such a thing doesn't exist)

 - the writer side uses smp_wmb

(and arguably there's a fourth pattern: the latching cases uses double
smp_wmb, because it orders the sequence count wrt both preceding and
subsequent stores)

Anyway, obviously on x86 (and s390) none of this matters.

On arm64, I _suspect_ they are mostly the same, but it's going to be
very microarchitecture-dependent. Neither should be expensive, but wmb
really is a fundamentally lightweight operation.

On 32-bit arm, wmb should be cheaper ("ishst" only waits for earlier stores).

On powerpc, wmb is cheaper on older CPU's (eieio vs sync), but the
same on newer CPUs (lwsync).

On alpha, wmb is definitely cheaper, but I doubt anybody really cares.

Others? I stopped looking, and am not familiar enough.

          Linus

