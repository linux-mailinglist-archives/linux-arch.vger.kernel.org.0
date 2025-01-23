Return-Path: <linux-arch+bounces-9868-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B1CA19F8B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 09:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C451163FF9
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1748920B7EC;
	Thu, 23 Jan 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyL7Mfke"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCB520B21F
	for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737619625; cv=none; b=aQW4dZww8eqXBN5GCiHU1tzsoOBDa1rreatGeXR+K8TnJYFRTPQOOomt8IE9RRs8F6TL4hpuP8bM2DLRc7u2nI/iHXP0H4ZhkrCEOpU7Zl7nc+++SvAmjqJNB20mAmK3hwvzYrdHR+B+0UPC5pJkGiITR/O7X2dv3CdEtyEfvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737619625; c=relaxed/simple;
	bh=/OVVa4PFdyaTHkYGkZqNTwVtn3TyCCbn3A1XAyZZRrk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XPNYJ4ylwY8dUTIghHsowQOTwsNpW9U/SlI6yx5N1XO8qpXHz01TjLyHhR/7wIKIwaGa2aGXeGYhFbkIvuWzLR1e84jvYaTDmx7UKzD+PWaUOFH2ijgiGa76zvuT+NCMwnmkyizpVMGoA0olWyTOJ07RjANnSNNSuDm7MWBRoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyL7Mfke; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166022c5caso8366965ad.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2025 00:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737619623; x=1738224423; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RxLyd0j5M0G3spzS+RTBF1u+LB8fnxQzXix63wIwVfk=;
        b=RyL7MfkeW/CZ65tpJxmY0Z78UWkO0F1aKjkBjrlbVaWE4q4sIrmW/pFDhhYR3u4EdE
         6ChccFdeI/DbyRpTQ0PBz2wsQC9k2dXolDSfU0qr0fiVpO9vtZUS4FQ8DN/7O0VERblM
         q0Do6tVf8V7jApAQojKMy0L5aceeUdQc1stW+TRGtO3sq9K6gwTeQJX4/W0p8T6szQrM
         rbUqVcNvLbUHjyDcMrRPd8KVawVXgWAFiRh14nj5cEo/822egGQ9fGH/sy96jCVR62lG
         /sE1Fpd7Ixe0j3+C4tqVpbbwD4VkTTo0FvmG3Dvnw1Srw6lem5jco/D8io2UUj4hlYGU
         +XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737619623; x=1738224423;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxLyd0j5M0G3spzS+RTBF1u+LB8fnxQzXix63wIwVfk=;
        b=PjqCk4Qo3EMEAXyO/F6v9KnwNggAF8vsHpc7hjKb4W9j8FS31G495Mmn1X6EpyaUJG
         uN8fvajHyr2vvgYanrrQP9Q4Lk+kzr66D58qVtkPrtIzvQMOb1ho8neBrwT+NVCH3nPE
         NEnQX1tfRQ0NoBKjBTSXxFGlnRpGuYcKMrD5FMVqYFGKsKp68vewJwenOZsFQP9RZ0jc
         KVUb0BOrwkRC7sLhrR6p5Fu7mSGUqIJ42QTubu4pL9jxN2NzgxRbFff6ugrvmaNxMOLj
         /D0AVJoFptHGbu0xVs/cr+QPv1H6hEqPU/qPiUrzwO8Kkgk9K657wu93VkK6ftYK9egg
         kE+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9PgeIz+5HHqp66ipeX/lETahqPF4wIumQOM/MnpwI1PtK20qe2PRwaWQxYNAt35YXqQdADJ8VA/Xm@vger.kernel.org
X-Gm-Message-State: AOJu0YzAGWFP8wrpkOCn1IZKmtTI5XOsK7D0C21sRQd2/fcDgtPaul92
	oJ+uHjrT0FhX1OyKMPTaqMrrAPhyRnj9kxF4QtPPEKA/yDR+5/Tesi8x/XkG3A==
X-Gm-Gg: ASbGncttTip8j7EgnRaEJ65K/chj9FDtfcqp9VbHdKPN8/o45zZ+gDge6Y22+b8I3dP
	qimFjNr09IU+uA05Int0rHarVapmDQjqGIV9J7r2fZfl3j6KMgynCaRByxdPpwY9BaisiD1GPlN
	KgVhbh6gk13nhJNGz3GjTM9q4kpDJ9gISJFGGcrGf11FajWoXqoPM5fERnjklk1wmYpAVixRbZo
	1WBYxO52QPYvPmd3IcuB+ZOQ0pIJI+P10cvz3bRTT1lJg4z8gujekHT/ykoG4D//6ztEUagI1FM
	5k1HjxsXLntMefObmxOhqtVuzEkX+54runbdU9sS4nxt89vMjKj0X13n0LWObJFW
X-Google-Smtp-Source: AGHT+IE7u+9Ai6CeI4NF8qNYNW7JMWK79y0CWYSHpK6OSfOIGBCitwQjVFd+BOZdZ8v0vVLAtIJgnQ==
X-Received: by 2002:a05:6a00:6ca7:b0:728:e40d:c5fc with SMTP id d2e1a72fcca58-72dafbe2776mr32050779b3a.22.1737619622728;
        Thu, 23 Jan 2025 00:07:02 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab9c8da5sm12254458b3a.118.2025.01.23.00.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 00:07:01 -0800 (PST)
Date: Thu, 23 Jan 2025 00:06:51 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
    Jann Horn <jannh@google.com>, Peter Zijlstra <peterz@infradead.org>, 
    Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <c549a9af-cd5f-fd77-1af6-a10b30dd3256@google.com>
Message-ID: <cdc9cb25-c43c-e829-5483-2f28d57f609f@google.com>
References: <20250122232716.1321171-1-roman.gushchin@linux.dev> <c549a9af-cd5f-fd77-1af6-a10b30dd3256@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 22 Jan 2025, Hugh Dickins wrote:
> On Wed, 22 Jan 2025, Roman Gushchin wrote:
> 
> > Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> > added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> > race between munmap() and unmap_mapping_range(). However it added some
> > overhead to other paths where tlb_vma_end() is used, but vmas are not
> > removed, e.g. madvise(MADV_DONTNEED).
> > 
> > Fix this by moving the tlb flush out of tlb_end_vma() into
> > free_pgtables(), somewhat similar to the stable version of the
> > original commit: e.g. stable commit 895428ee124a ("mm: Force TLB flush
> > for PFNMAP mappings before unlink_file_vma()").
> > 
> > Note, that if tlb->fullmm is set, no flush is required, as the whole
> > mm is about to be destroyed.
> > 
> > v2:
> >   - moved vma_pfn flag handling into tlb.h (by Peter Z.)
> >   - added comments (by Peter Z.)
> >   - fixed the vma_pfn flag setting (by Hugh D.)

And in v3, that changelog should be after the ---, not in the commit.

