Return-Path: <linux-arch+bounces-9927-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AFEA1DD9B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 21:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23CD67A1BFA
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 20:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488C19644B;
	Mon, 27 Jan 2025 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHfnhls/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58C195811
	for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011327; cv=none; b=U9ddIuWMZO70xJlHs/x0iqG5iDRORGmRAUDdzMlTY59yu5DA80p+VW6jcE3QS9AzMdi95FVhQ32sORWAg6AtBlNUiaF+xzacumDHCGoBSy6kLl6oJYiMYB/8bhRRTb6hG2msvScfdd7jX8RJ8jCI5GgU12/9TXh6DRHWRQimOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011327; c=relaxed/simple;
	bh=RiEYPKOPO7q6k13o/tZSS8EgYGgh41NCmP6v1ZbgPZo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sxtF86e+tRbkAAlrTCUdlpPR7zkTy+7hA9J3O82jSpTmwCp+TSNzot8TkcYHRre/b3en+WGPVucu85CL2/AKhklOWZAM4EP1VNm8GNNefls1paDPtq8vdtpRFenB8ADeQxB5wrSo8PpMvrqTjwlHNvHNQsWETJwtKAtpCvtMcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHfnhls/; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e1b1767b3so2810025a34.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Jan 2025 12:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738011325; x=1738616125; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtNyaQZENeD0DxRfJZjJ+rbicuEc2Uoje+9OeN7mxRc=;
        b=DHfnhls/I46DB+wqIoZbOUaMOSoG+4FHngpe+fUM5qTXm/PskLZp6iiI9IVkEg5Xy/
         SuHMX8EPCoihvXtjBYTaPlJ+x5BaizVt8bbcYXtiaakijfLxh5frMi25vY41763ZWpOO
         4d40mHke2dV96/SwnwtQh67sBmII8vtBdBysLfKd9yDoln6hQdJVZPKinVO10B9/i3yB
         U3gDYe0j87RCu9QjP9TA/1pf2UzQ5uz7RqzrgJl63SSexYjki6UiH+hEwAy3iv2tgEjk
         cibfp5RXIOB5y9vzipIVeG8Hd9csB6OM4bllzX5KY+7TD8tU3RvCiydb9B2rSR2RBuAv
         VKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738011325; x=1738616125;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtNyaQZENeD0DxRfJZjJ+rbicuEc2Uoje+9OeN7mxRc=;
        b=TsTnLipuotUvlN59XZFpjm0EldxtUaKCgkZtU5i0upLaEJf4pjqYoihu77Blvenaat
         ksk+5wyCVo6dVuybnxSAjdkQYYkmBMftQuHecYHgP3RvQcpK6QFIChMkdeDcqgZnzycc
         2c0dBSqBUpiv661N0oX5ev4Vm/PCMs4vdMi70M3oSvEXUMyVK/TMlqhjNClVVjKxjkLX
         bgL3YfW47NDEcda693FJPXLcGB8BcjLCXwS0JUL8ZMY2+Faqj8bwWawIsArbVCWgvwxL
         L9qVlTCuj7Yao1C+R5jTPMrUftbBoikGX8TgouTB37KjHxVtNQFhzvwHdHHMRL+GKyDw
         li7A==
X-Forwarded-Encrypted: i=1; AJvYcCUmc3kA94a+VySYkdjsp0fgkl3QrTKUQtRaT+4owDRC3ikpgRK4YPejuQOTCXz/q5Ho9RF114Xyw8+c@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPSqPU1v1Z3PQZhBerP8oAZX6JqrW/vPUnEHmGofW19tTmTU1
	ppEfpGsMdUyDsxvjIj8hOMevtvVyUm8qj1gG1EG11qzDjGxL+ndL6Bq9UwZgxA==
X-Gm-Gg: ASbGnctCiI0w7Y6bf7xoHsXme6/S+VGvWTxrLB4FoC6sYtt9tw+Bg75xaX3PWve6RnS
	BNykf2p6iXp2W2EmwaSB2cOYQ4cUY7dAYfas3eU72e8HhimIILurdmvIMXP/lVy0zbBEGPud02Z
	XFMrEc2d/TdjOYC+z3Yq2L+KFRr9yol0JzgWUPZ5I89D++i4rYuiQ8I5HqlxqHwexbjAGOUSgd6
	3ThMjpyfMF/urxEZMV1f7Bd4lx77xD+Yh06FEQVLRuElMpGaAUBHUMGgQonnqPoKhIydwu6GHqh
	kYwXrj2HFj38ZrBjA+2hd/qSDMCYNj19EK945ZlJ3L0y9j/X9UOvvpFjIH51cPdp
X-Google-Smtp-Source: AGHT+IG7mxID1E1Wnbon1hYK72BJDX6j1zpH+6xmheGxineJU0WZO3bKoLO8VEhR3un4OSnRY+1/sw==
X-Received: by 2002:a05:6830:641a:b0:71d:eee3:fd26 with SMTP id 46e09a7af769-7249da56939mr25255340a34.4.1738011324598;
        Mon, 27 Jan 2025 12:55:24 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecdecdc1sm2462473a34.36.2025.01.27.12.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 12:55:23 -0800 (PST)
Date: Mon, 27 Jan 2025 12:55:11 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
    Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>, 
    linux-arch@vger.kernel.org
Subject: Re: [PATCH v4] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <20250127195321.35779-1-roman.gushchin@linux.dev>
Message-ID: <61e3ea6a-368a-640f-a050-b56c8d3232b5@google.com>
References: <20250127195321.35779-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Jan 2025, Roman Gushchin wrote:

> Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> race between munmap() and unmap_mapping_range(). However it added some
> overhead to other paths where tlb_vma_end() is used, but vmas are not
> removed, e.g. madvise(MADV_DONTNEED).
> 
> Fix this by moving the tlb flush out of tlb_end_vma() into
> free_pgtables(), somewhat similar to the stable version of the
> original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> for PFNMAP mappings before unlink_file_vma()").
> 
> Note, that if tlb->fullmm is set, no flush is required, as the whole
> mm is about to be destroyed.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Jann Horn <jannh@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> 
> ---
> 
> v4:
>   - naming/comments update (by Peter Z.)
>   - check vma->vma->vm_flags in tlb_free_vma() (by Peter Z.)

Let me just put on record: you were absolutely right not to extend to
this the Ack I gave to v3, this v4 is silly (tlb_free_vma() and its
multiple calls, necessary only because of the unnecessary extra test);
but I don't see it as doing any actual damage, so I'll stop short of
NAKking it.

Hugh

