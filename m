Return-Path: <linux-arch+bounces-12150-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F114CAC87A8
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 06:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DD518858D6
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 04:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF31A2396;
	Fri, 30 May 2025 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUxwswtv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA77A1E1E0B
	for <linux-arch@vger.kernel.org>; Fri, 30 May 2025 04:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580767; cv=none; b=g6nupeI2NpQbjWZiQixRjlwbCFJfLvtI04liwlpYymvjNmURCIWI24AUuS6RCc6o95T2CN2rFAACexQpXHryTVw+VzLtQvCBPprddemGAOHnhbmCS6WxqaUtsj92LYM/HD/e/lfARUAa2jfUzRewV36O5UHS72eff0zuOq9BTGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580767; c=relaxed/simple;
	bh=uZ58h7NhhitrVp6n6KjO0SYskciVHlxu5/lCxSESQ2A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YAdYD2p9mT7Q+rwM3dqy/AEm+tnk4L0P9V/GoRUUJvusokjlb4I+sG/1OX0Qr8K88cJsLXxA25kL1JrCpcd2OAEGuZFYwl14Ng6IJCCqH1fl3xU+HAoMX7c8bJOTYN2ZKEvgAKarjjLh7xJmxVNe76w9Uf5sXXsUYf3cEdfJx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUxwswtv; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c16e658f4so1096252a34.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2025 21:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748580765; x=1749185565; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H70bHAj8tBT7LUiVVlkKXsAA1R2ro/jkyCMIyaBzqvs=;
        b=gUxwswtvm0GplFkdQ3Pkwb1BUhgYq2iHS21hLZARvKX4DZyOGgkAmw/93wjdO9I9ux
         MHs5kHjOd/6Rd1rr53gU/xTb8g5PvvP+msm9BgbcG5KP8eXJBzPHIrXxT+lwE43py+OS
         VSU4GLcArhoHvQZXhaABXqghgZ9Uy8avOtJ+0m/tAoKWj5eM+FLQ4HyOA6hWLS//hI9D
         QuqhDgGJd84O5V47Q+nuNs+TYKiryFUa1h6LymlhvRmiL/pvIxOQg4N0LAK22ECTGOwf
         bJxE5+riSpoy6LDlGz+fclJHpCj3r/alp5RXX5er7oQhqFp7N3qNJGh/qLBt/p4JSxiT
         8oRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580765; x=1749185565;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H70bHAj8tBT7LUiVVlkKXsAA1R2ro/jkyCMIyaBzqvs=;
        b=jUzuPR2FOepj9+xASGv2aZbSJQq0Ez2ur3xmMzjZ6mVqBFyPogZiVcidwg5hS1vVOD
         1tLSwzK0J0XN4HLI+qettCHd+CC09DlS5Mu/qOIZgUADNLxkP0YseNM+tw6fS3NydsWW
         18XQcDo3gs1Gmrz1M1YE3GUbvO1vS6cRwp+0DjPfUCIfhi+yzEe+howp1ag4BMPhrOEc
         +zoN/f2hSn+Ojg0/FSBcLI9/JayhWogVSZ7iBj1OAHSd0+4LXV/bs1g3MQmvAEYxgTCi
         UXdUOnRI8paiKfjLQIs51TVwxhi/la5gn6aVWX+57h0ArbUv6fug9ejwi1OgINxPZDd9
         eb3g==
X-Forwarded-Encrypted: i=1; AJvYcCUIEjjJoUGxPe/DcJcRMuZXRXvUNKoBg9E4KYrhw5nMGyhDDvOFMvTSoJ4qr65ZZtfpB8OawZ5JabB1@vger.kernel.org
X-Gm-Message-State: AOJu0YxcXhcRaB348fR1K1VENLHYr9HnsT6ratQQ/yYspF5gx58HQoT/
	/8m3EhqbcgOwb3ZdtF24tFqKJPylrjaPPgOvR1C3iJY28CGn3y5qjeHaTfqgS5ix8g==
X-Gm-Gg: ASbGncumR+bBvvOz2JuU/FmaOQ7snCf/sZtpp9JrzX+GfG/I19LAeSNp/vC40vEwewq
	Izil8oqC8ER791nXr65cwDjDpcIP+Nd1aknI8VwuaL7yLXnG+tONQrpWSLvLk6Fm5rgHsYzdj39
	/wQZxFCn23ImcXyJT9MLXJP5enbGdO14nQr0AVd7TpZvbI5XbYQ3tqc9fN0YqSRebfWR8bMCGD+
	8SXHrzMP+fuVvAnkzVhpYdhBdaFAL02wgLtUv5fchgwEW7Bci1fl4JbpENvx89gCLLmpsUx9m0z
	ZITSoT9fClkquF/dhDC2XCRnMlInTUXiuiAgelf9J8rl5HjLb6Q0jc2xYN48YCKz/oaQt5Wxb2d
	pUHXwIiq7JvhWPfHlJ90pbRIIMRDEwMTbgjDnz+HEwEhheg==
X-Google-Smtp-Source: AGHT+IFnj/A2ltdxYXWgvJCcX8wPSmvYsWm2u+S8jbtStwL2IXVXHD6TrFshXdvgB7U2R5ac9HuVhw==
X-Received: by 2002:a05:6830:3783:b0:727:ec1:73ab with SMTP id 46e09a7af769-73670a08670mr1157404a34.19.1748580764703;
        Thu, 29 May 2025 21:52:44 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d2b8sm494958a34.3.2025.05.29.21.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 21:52:43 -0700 (PDT)
Date: Thu, 29 May 2025 21:52:31 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-arch@vger.kernel.org, 
    Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
In-Reply-To: <20250522012838.163876-1-roman.gushchin@linux.dev>
Message-ID: <9fc25829-fb3f-8a13-94d0-786127bf12ce@google.com>
References: <20250522012838.163876-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 May 2025, Roman Gushchin wrote:

> Commit b67fbebd4cf9 ("mmu_gather: Force tlb-flush VM_PFNMAP vmas")
> added a forced tlbflush to tlb_vma_end(), which is required to avoid a
> race between munmap() and unmap_mapping_range(). However it added some
> overhead to other paths where tlb_vma_end() is used, but vmas are not
> removed, e.g. madvise(MADV_DONTNEED).
> 
> Fix this by moving the tlb flush out of tlb_end_vma() into new
> tlb_flush_vmas() called from free_pgtables(), somewhat similar to the
> stable version of the original commit:
> commit 895428ee124a ("mm: Force TLB flush for PFNMAP mappings before
> unlink_file_vma()").
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
> v6:
>   - tlb->vma_pfn is initialized in __tlb_gather_mmu() and
>   is never cleared (by Jann H)

Acked-by: Hugh Dickins <hughd@google.com>

