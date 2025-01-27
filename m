Return-Path: <linux-arch+bounces-9910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F747A1CF8E
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 03:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F9D3A3BA5
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 02:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAEF41C85;
	Mon, 27 Jan 2025 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCWHNA03"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768825A654
	for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2025 02:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737945295; cv=none; b=UWvKXcIqlCE+hWp58qUavWuEq3JqD1WoR5KgzSzSiN7YwQvpUZRfs2t8+vDNIF63ohO2TOHzrvQcDZ3xtfgyBVC4EcatUucqKeXYSMXUDFmS+peb9ErcPR/ZM/BDlGlOgS39YsEMM9jUUaTg6zFyAIM/NNpoPjFFp+GevvtJbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737945295; c=relaxed/simple;
	bh=dC6O6GeUCt78YeHesy6iGFtCDtu8eSs5PaqWsyww2Zo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DudSwPJHbLumPxvUkFdyjNFWsTNxuJwicVIFs5KUtl3DRuqBtc/m66Q9odtjiKWMMfdsKxKQuK/f6cgDc8BwXntNa/fn/zdG34Wfw4YQbNM9uCxZtrzS3ZvzD/yp/fuMOl3dqqwmnqw4b1Sv1QaKSfK33tIvOyMLGA0ahpCNkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCWHNA03; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216634dd574so45522905ad.2
        for <linux-arch@vger.kernel.org>; Sun, 26 Jan 2025 18:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737945292; x=1738550092; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hitrp1AjY/PBANuAUPERQVfYWmKYms3ba5pS3m1h084=;
        b=dCWHNA03nmKEZNDTBAneA5iTED6BM+j1ikzN9HPQvLkcCATms+iYB0de+OETZTY+B0
         fYaOF8nhU/o4ySi3VOUWao5FBZopj4/7yNVMK14/JE5id9rX6sg0y/sMU5dssAoVlyMT
         YyAlD4dXHbl5/j7/1KY4V06bGfDBkUpyO+CXEjjHKxk147xH8nLfxZWPnpwkaAIJ3odn
         Q2F992z9QPbWvKHmdE8jtcxjxcdA4/tLI5bEvSYEXXCJs+hKElUK/Eo90pQAbrj9Lh7O
         o7D2mndBKbdW34fQf5nrjd9Mo8LGgtMXVD9wW1M+zUU7F8nI3jL7Cqxwt+Q8Uy3IPH0Y
         NTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737945292; x=1738550092;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hitrp1AjY/PBANuAUPERQVfYWmKYms3ba5pS3m1h084=;
        b=LRFg1FLxzMLuwAFP+2knPt3v8z+EHgb63cXXwJNNAnAuz3rIniPiZghBE6UB5w/Qus
         B0NzUiHs6vSby3Z5gdUBwzIoh+LaBhKxgVJIMd/or1rB/ewtIDfrSipzKAou+0mafqAZ
         +D4tXdw5eWyUS6pmIHwi6ys7nSHHL4ymJpkHejL5oE9Rl3nDEjPgi/kF0oG7le/PuB2i
         0TNUCrq/4EnNHIwvSN8VG34eE3579aHt3Krtuq4I28fIyN2Bhfie5Puyt1dul9mEtSMu
         yvP0pdRQfV0jGPI5synD+3bFqIMajcZk7ZVwwMUMeDm+SjLIspJrjtY9E1Rl/Jd7VpCD
         ZPfw==
X-Forwarded-Encrypted: i=1; AJvYcCWU/L0VK9BhFmhhXLsdvl4mwsOHDqm1DMme5PNZ9NMoCXJbNkfZZCe9+qIe6eH/bEzXY0nZDYi9EbOP@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZdzZY0lJ/aJobF0vIuSdB6akno0aRHDYgsCC7ma78YfrINI9
	7eu7LymcrM6j8i3mQ+l/mfYukUHndvycLt9A6dWYS9B9ITJlfaU4dg/uPlNvEg==
X-Gm-Gg: ASbGncsupIqEuzW1GgQ9HDL+lK3vlk0L6k58vayAUYESYo5BCEiIWX0K9yr4UYxLQ6x
	LdhpQHxG/QRvwAQ/9zQUBZTBFslcU6JqasQdK9IN+rQ1x++ukUSg4YM42srhwhKdDqBu8XvKqlp
	5pRIAIs8LTFNRi99xdx6dy7AAUsfQZ9lTi3IqduHcTSMzyv/g4kBsMXVvoytKcN1Ve9Uo8wZJE9
	hHErnZlnxg6HeIwW6d64uzjfTtMQTCuljq9fOLMnQV5sWBO9kZMHD/RaRfHslyT6HXzKeLE0C1Y
	4Ugq54qn+3DDlLCZu13gmLL6UD7EYEJiHROmyN7vqvwoyxeqi5knq2dq8ub7sFbs
X-Google-Smtp-Source: AGHT+IGiu/swikkYWFBdEOfZ7nvltJFv4cFRPVj2396mtucRyMQnsKqob3RQxYYlmInvmFhb24glhw==
X-Received: by 2002:a17:903:22c6:b0:205:4721:19c with SMTP id d9443c01a7336-21c355b73b2mr499638665ad.37.1737945290852;
        Sun, 26 Jan 2025 18:34:50 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3076sm52457395ad.68.2025.01.26.18.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 18:34:49 -0800 (PST)
Date: Sun, 26 Jan 2025 18:34:48 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Peter Zijlstra <peterz@infradead.org>
cc: Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <20250124083139.GB13226@noisy.programming.kicks-ass.net>
Message-ID: <d01c2d60-3901-1f66-770f-e9d12bfd89b5@google.com>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev> <20250123214531.GA969@noisy.programming.kicks-ass.net> <Z5LM4b2sC1fHgB3p@google.com> <26cd41c2-b8b6-0c1d-c36d-28f2f9f369be@google.com> <20250124083139.GB13226@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Jan 2025, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 08:42:36PM -0800, Hugh Dickins wrote:
> > The changelog of commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush
> > VM_PFNMAP vmas") has not helped me either.  Nor could I locate any
> > discussion (Jann, Linus, Peter, Will?) that led up to it.
> 
> Hmm, that was probably on security -- I should have those mails around
> somewhere, I'll see if I can dig them up.

That was very helpful, thank you: I've gone through a lot of confusion,
but feeling more confident about it all today.

> 
> > To me, Peter's patch looks much like yours, except wth different
> > names and comments, plus the "vma" error you point out below.
> 
> Yes, 3 differences:
> 
>  - naming;
>  - the extra check;
>  - the vma_pfn clearing condition.
> 
> Under the assumption that this is all about those PFNs, the argument
> (as also outlined in the email to Roman just now) is that you only need
> to flush if both: you have pending TLBI for PFN and are indeed about to
> unlink a PFN vma.
> 
> If we've flushed the relevant PFNs earlier, for whatever reason,
> batching, or the arch has !MERGE_VMAS or whatever, then we do not need
> to flush again. So clearing vma_pfn in __tlb_reset_range() is the right
> place.

Yes, Roman moved to clearing vma_pfn in __tlb_reset_range() in his v3:
we are all in agreement on that.

> 
> Similarly, if we don't ever actually free/unlink the PFN vma, we also
> don't care.

I cannot think of a case in which we arrive at free_pgtables(), but do not
unlink the vma(s) which caused vma_pfn to be set.  If there is such a case,
it's not worth optimizing for; and wrong to check just the first vma in the
list (don't look only at the stable commit 895428ee124a which Roman cited -
it had to be fixed by 891f03f688de afterwards).

Personally, I prefer code inline in free_pgtables() which shows what's
going on, as Roman did in v1, rather than struggling to devise a
self-explanatory function name for something over there in tlb.h.

But I may be in a minority on that, and his tlb_flush_mmu_pfnmap()
is much more to the point than tlb_free_vma().

Hugh

