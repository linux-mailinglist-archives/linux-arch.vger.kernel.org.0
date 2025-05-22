Return-Path: <linux-arch+bounces-12079-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3E9AC12F4
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 20:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FCF16E162
	for <lists+linux-arch@lfdr.de>; Thu, 22 May 2025 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4482F18E050;
	Thu, 22 May 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfM/oqgp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76C15F306
	for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747936894; cv=none; b=jhqpDGiwVDoI7/PgQUpir7sRb76p6PVa8Xy458in/7lvw8HtG4lBA7GcKsdQzBnia8cOymD7Ifep2cjSQU2ZhiJKeOwJS/j6ypWRQ0LEplCItgewXhU0VR5mBZbHglRON6GFZjCACmdu/zj27bT94l4Ki1Ppgv1mY7qBdcWAqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747936894; c=relaxed/simple;
	bh=zSrbOWuHQ1Z5sVIesfrhCLH21IIccGRYbToiYGXm2ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk6gF/YaUKSFnNvIuDzfuq22ggfeikYeHlWXfSkXGqRQdtzXx9QSDRmf6ilB5Ww7nCHmm5WAFwzG+VxoVN58upHIzPW70jcSXmtXqIQibRzIKrLJ9qrsG9mYOCcBRdla2RUscYGf63U+kMpOCNAUFKKmXKMx+Yp5zpDTZ1sMRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfM/oqgp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so1366a12.0
        for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747936891; x=1748541691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSrbOWuHQ1Z5sVIesfrhCLH21IIccGRYbToiYGXm2ZY=;
        b=RfM/oqgpgpo2BtQ8Hydjx6/l9ufY9xv4wAaJOqjruHsFFkRFPO+6wCY4ez1Ye8wucs
         mGfFe8PJxJMsiTjzx0X00xzWYrqzDEszkCcRrSBOGgppUme+aIpMR9ocj7sEjF6iklkX
         qaychnd5CS5VSeLT4skrXoqrOaIV6eBr9PQW6h4bZE9oBdK6II19NujshnoWClpC7XFF
         DzI1N2insLehKcDiC0zkWKpqW6CNF1I4YlplfSdmgwr5HpRJDxa2uTiBHfaZKceCloF9
         /DcHP/Cqs69AKDa6bg8xXzHYYzQHb1b8pqXJBOYOc+gg7uC2HeoAg43EP5c+uR7mZL7v
         QcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747936891; x=1748541691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSrbOWuHQ1Z5sVIesfrhCLH21IIccGRYbToiYGXm2ZY=;
        b=k7PfQrmTLhHebn74EZmnmrhWjFJBUFQ7Xrx0LHLqAKhzQNx1BcXrs8WbDr1Af0Qx73
         Z8tH5tf95IVeUuSmVKQTmGrXgb89KwrFkbgMC/7aJNPSZIutTsIL8KI19gqav11IE0FG
         52beXpFIw576W+qqnjW1KcFq19L4dD/4wP1hq6F87mfXrowZNenW+CTxhLFyRhx3L5Jo
         MdTL9xRNmdT2K/z2c9manfTMnHu709eTqNkmFsnigM/YzBBXQ4jUPVbjxCcIigiXVYHt
         Uj4Z9NW57EKoG5lNVE/xmDWdZVVJZ5gj6Se4w+mDxVdiiqFtWvhd7ORoZs5QCcJVo1wk
         u7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXoR0YRyiw0zvEyGK/Wb7bVMlagUbeIii7rAkIUN7ulsbH/KQlcHcm72sDq44y8/SlytoMVxTSoVvW9@vger.kernel.org
X-Gm-Message-State: AOJu0YwEz9qj1nXMonVYdsAQJ7Shw+magVBrz14od0VQWrVKSObH4Wbw
	xM3m2eNtwPuPVCD9xydostUERaFD5fL+Mn6BeqIXgmM0AYqmyDSyKa6FTX61Ea2YxcdNfKCUosT
	7d8Asr1kD4uh/rFu85SCxvFKpDhG9X7ULrNEsvZLg6Ost38Tq/zttY/OM
X-Gm-Gg: ASbGncteh1M0weT9SvQnVebK950/mrUzcSXrpRlkDYwxMTEFkkpnt3BA6OpxlNZvP2w
	3EvnBtzRVESK1jmyr9SLCBzW4rxjwuH5g1VZLl/0kIeDDVxah0hNk7SUovb/bHoWf+OoVN+VB2K
	sDFk7TtC5Kr8QEN/luWvDXMvTY3vo7kRj4/vyoPR+HLlTwAnD0oD+HjFl21uzqzSeEkXxMB9aOX
	8kdh4P40A==
X-Google-Smtp-Source: AGHT+IFxJE445XHoSMx5+PG2/5xKb63gk3NMgNuLdGQr4KqW7SDg77Lnmqsxp9mSej5j68Z9BUaqOffGqtQwskjYt88=
X-Received: by 2002:aa7:d905:0:b0:601:8e4f:2eb3 with SMTP id
 4fb4d7f45d1cf-6028fbe2b59mr9108a12.0.1747936890338; Thu, 22 May 2025 11:01:30
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522012838.163876-1-roman.gushchin@linux.dev>
In-Reply-To: <20250522012838.163876-1-roman.gushchin@linux.dev>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 May 2025 20:00:54 +0200
X-Gm-Features: AX0GCFsRGhGmDXFm5yb_HSIAhFgPKv3Mqm8Lu7C30sJ_pCqFSfVgLnVDarBenOE
Message-ID: <CAG48ez303kEZ8rWrP9AvsWGddcptAxuk6C56eBQ1Z6RJW-a_mw@mail.gmail.com>
Subject: Re: [PATCH v6] mmu_gather: move tlb flush for VM_PFNMAP/VM_MIXEDMAP
 vmas into free_pgtables()
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 3:28=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
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

Thanks, this looks better.

Reviewed-by: Jann Horn <jannh@google.com>

