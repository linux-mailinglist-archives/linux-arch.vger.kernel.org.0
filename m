Return-Path: <linux-arch+bounces-15059-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC23CC7EACB
	for <lists+linux-arch@lfdr.de>; Mon, 24 Nov 2025 01:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3469B342E46
	for <lists+linux-arch@lfdr.de>; Mon, 24 Nov 2025 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36600CA5A;
	Mon, 24 Nov 2025 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="Sqqy8hS2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7135965
	for <linux-arch@vger.kernel.org>; Mon, 24 Nov 2025 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763943829; cv=none; b=iH5k4tAuLUzNZewHG0V4DIJ/8051PhE2KvkpfhVNwq+ZWGxj6EsUhkC1kj3aj+tZ1Sou+/1JA1jpYNGPS+1Ysg2mmR5dcyiDMyu+7bFfzhDQyvD2uZ0uPRmK01PtrW+51tYSgK7Etvl9v+HbZukfQEjynybaI1hJVQrVb1pK9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763943829; c=relaxed/simple;
	bh=ctJiVIxSSswM/DirKHo1uF6IBGPapc9r5i6eptPoGqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mW429sj54e2Mn+uytgGHfAYBgLURknTHnKmajB/gdc5eOUWGfwU2RGSSaQDxVIbBn/96HNDDf4xMvOUbAJy9cmn/YEtlj0GEkr5RH1ljscbKygWmeYPkqrucxB1JBuRXL++LTFXe56h3IeJXEONC55/dKSgZ9NRxm3/QOKlEeO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=Sqqy8hS2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3434700be69so5501339a91.1
        for <linux-arch@vger.kernel.org>; Sun, 23 Nov 2025 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1763943826; x=1764548626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctJiVIxSSswM/DirKHo1uF6IBGPapc9r5i6eptPoGqU=;
        b=Sqqy8hS2isW9qZtWSZIIGcAVTzxEY67RJ4Oj7M8q1kHa4aNxHUlCT4v6otKZ1+CmTy
         6w2zI/Vx8z2O+hY9CB76IWrjrcbGwFjdJQ+m4bCquvb5pwJKk4BBFfsj+ZFeuE88cN8E
         jHcRVlyKxyZhREWoIc0nsDaXlH19JeOy85EF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763943826; x=1764548626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctJiVIxSSswM/DirKHo1uF6IBGPapc9r5i6eptPoGqU=;
        b=XuC1lK1AptOXtvlWXpSHALNLj1DToCgASLM9JlzPHrxNZm4IHcbc+RQ4l6gds2N200
         ewx4HZYMuVbTdiixwQRoiRsgF7kj/qNR+OTQmNaqUGPNl1QA0i9zbdy0zan8gCuFV7EX
         PxjcciKa55qSqaK7mJjAxiUpnJnV+NuG1IJrELEnz0y072ocpIr9e27kG/9r0FPCtd6i
         Zw8XR8m2OGm78lzliR/SDCR2pM0VvnPowuEWr2qB4xOo6ZIYwmoSlM+Ynu7IwxTU69CH
         VAlZfnbyscJ2x6hMerNgpzwnWlnB9VpWvKoURwDGbHXVezH6ESp4FplfA/5/juVeW+p/
         2odA==
X-Forwarded-Encrypted: i=1; AJvYcCXK5m5aKZEHszcxX729ZSi7B/e9CQEfZ+c2BRgcxoeEzeAH8FAl8w6Q82i0QyodZnF9+1X9SUpq4z5L@vger.kernel.org
X-Gm-Message-State: AOJu0YxA8lU4jdGpkC7EgbYSrTSMgpwBogLoE+iL6G9FocxuPTj2x6fl
	nVL3eQMinATtkXN6L7VA4OT276d1Qs6RV1rcPmiWg/YQvoobw2U14gbnGsB5L6UK5wN1s3a73Ib
	6LMQguxtE4U4GXdCF+vwEdunkvSY2ayD7gccoSnfRU+XzYo1V9LvR+1E=
X-Gm-Gg: ASbGncuvXWfbY0ralDnTnsxLjBFtwv3VL7p6FKpzjMKdJbZeqzXHVAKVfLVeXIKQpuf
	sFygoLOdvp4vfRpPsiQw66bSvKQ8V0B2QEqRwel2i2eMy7GxEwxGvMwISnNLfmiZPYB0ewLcwGX
	jXMHqeVKo9nayjY9naNXzw/REvrIWIaBBj2IgqJc+xGf0/auDy5A97gyleacEnywgfml/E2hZS+
	Utnm3OhEFpKqLgo0Rr+GLYxxuxsMMfBY736e7gttlDKimOtmhk8U9hudL5xnRBdaPJrlXQZ+L0u
	wsnh2A==
X-Google-Smtp-Source: AGHT+IHB9op3daY794dPLTeV21OWyQsyLGvy/5OhyQ93d1a3QxTXfbzrEIyu3bdl3t9zonqX+aNxZEadjA62xVKNMZc=
X-Received: by 2002:a17:90b:2d8d:b0:343:5f43:933e with SMTP id
 98e67ed59e1d1-34733f2a487mr10157658a91.19.1763943826435; Sun, 23 Nov 2025
 16:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760999284.git.fthain@linux-m68k.org> <93055d50d71662261fbcc04488536e7330975954.1760999284.git.fthain@linux-m68k.org>
In-Reply-To: <93055d50d71662261fbcc04488536e7330975954.1760999284.git.fthain@linux-m68k.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 24 Nov 2025 09:23:35 +0900
X-Gm-Features: AWmQ_bldRq0iekvVOlcL30LaBFzAfFhfpZdrV67w6EpuQo-NUSpJtS3YYp72TN8
Message-ID: <CAFr9PX=MYUDGJS2kAvPMkkfvH+0-SwQB_kxE4ea0J_wZ_pk=7w@mail.gmail.com>
Subject: Re: [RFC v4 3/5] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Boqun Feng <boqun.feng@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Tue, 21 Oct 2025 at 07:39, Finn Thain <fthain@linux-m68k.org> wrote:
>
> Some recent commits incorrectly assumed 4-byte alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have
> failed on Linux/cris also). Specify the minimum alignment of atomic
> variables for fewer surprises and (hopefully) better performance.

FWIW I implemented jump labels for m68k and I think there is a problem
with this in there too.
jump_label_init() calls static_key_set_entries() and setting
key->entries in there is corrupting 'atomic_t enabled' at the start of
key.

With this patch the problem goes away.

Cheers,

Daniel

