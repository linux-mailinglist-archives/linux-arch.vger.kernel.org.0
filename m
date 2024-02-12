Return-Path: <linux-arch+bounces-2240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AE88520EA
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 23:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED81D1F2130E
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8D4D131;
	Mon, 12 Feb 2024 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JWqCC6eS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1492487B0
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775610; cv=none; b=ITVb4HMpRCPVE/vmewhBQ3ZuR8TcBfPFRfI1zoswJ61KO5UXwI5OYDjmEZFRHVs3dRKf/S63IddURq2MlEOCIyy7CXOaBZnrboBzKcVPtpmwinb4Wxu7JKZCy7FDpGrdpl3E+Eexwznve8vB7wlEzpcB+lQlwCd71tlsuAmHp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775610; c=relaxed/simple;
	bh=JHTQeNLLMkswmIE/y7V+PKYlGU7fYxgX1dVgIvM2E2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzocw4mvY4NzLOc3ttIjs4qYUhVLkly6XWJKdzkAsYu0Tb4gW1RFUyVEOd0y+ywl2R1pxDvB7agEUA9z7bmoeQadoDkgY4eQAL/T7CHWmihgpP7Epk5rFwyixoSyBfsrOLGrNq+7wxWIoyCEEQAVHQiclb33aes/ffoZdYnZsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JWqCC6eS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e09a890341so1507350b3a.3
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 14:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707775608; x=1708380408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfBFT3E6uuwQvv/Pq6TrncKe1LxZZQMXwgtmc4u2niM=;
        b=JWqCC6eSCspu4tyejcBHoNi739eEEtsiI8nu/phsiwkzGh2CwJZAR2pJ6Qllt6A/Jw
         9HJ/ALeiEMOa7gPJSyaczA+tRACn9cNtqy00Kp1NTGke6DpkXyex+PakJU5bRr2G11j7
         oKgrSMsAPS/fJg5mGxN6P+6FnRvYE6ZnS77qE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775608; x=1708380408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfBFT3E6uuwQvv/Pq6TrncKe1LxZZQMXwgtmc4u2niM=;
        b=ajvVemAehUDGaGr21DrMiRwFrdjBqz3RT4gbJYPrm+uzqWjSbbIO5DQu77VXrTzLM9
         g8wZIWylZQeBXj65O1yb6K53xxGZWGN9FCAMQJQ303StCkGyWW6Klbu4gt5fqzmmFd4K
         SsyAOsqae2o4qihm8ZlJ6WO+AGBcfCvu3rlf3KQa2I1xO5VG1PbKES2q1gcfpRejOlx9
         /qEv/5ujpoE7VNTt1M12LILBjVtv4S531awpLQCwj+/NKQXtM+JpFaqjy4ClitM/HuSN
         GbzNYFScYBKAd/Z/cP+0B/CKm4fRcMddFH9DHl+MOu3YRyLQ73H7+MGyEtRTkZ8lRN3L
         VTIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfk/p2TvagrSdUaXZxr/eEQnBCuJuKV1HBeFSVOWpEmyqBzF+PHwy4MiimP1j1xfp8jHc9mACn34lHct2uR2F9OqaBpFLgayfc+g==
X-Gm-Message-State: AOJu0YwOw4h1yDuQq2G6YzvVvr3VA1RfPPBH6giR0blaMhfh6RJiHIhp
	NIl8j4DykBY56ff7j4oo1zApRjLGezccWJfnneOkYHnfxcFXsDXwVPSJ/kp3uQ==
X-Google-Smtp-Source: AGHT+IGaCS4FE1fgtoRRnsmXSTy6fZAOSF37rEolH25HBo4sIUQjN9QncvXzf6oIO60VYs+syL8/fQ==
X-Received: by 2002:a62:cdcf:0:b0:6e0:6c0d:f55a with SMTP id o198-20020a62cdcf000000b006e06c0df55amr8081618pfg.8.1707775608405;
        Mon, 12 Feb 2024 14:06:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkewCVc6tHL4+EISv7PCsXM9ydkTsXDaDTLcNzXCcXhbrh/9C+ax0nndC/hzVRMx0nInEYWC0KIt/8lOHNzqIEmD1e/R6JnZN1Vl+JE8tkYrbQRcuHv6+76ApR26qH2E5I+H4dL02gaOsP2GqZB9zhAy+BzP/Xam7kiNv0f1NuAtutolmP4BxJOHmv6p/4+nri8gPYYXx2yBFWr5NL014vNsFwE6yR+EkHWpxHabW2jspuy9JvVw5xPvjVtcx+kvAQx351WFQx6EglHMAWoZHCmE67J7tbB0AYuj4mbHYYbddcGzVGmVl83+H+ZJVi0l8UQ1MFnuAEpXE85ZyohrEgLDkUOUmLNpo5LXxpY8EL/z6HU+Ff72PctyzucnexTN6EgJ+LopCob78Xl2LSlS9m7Ivnmm+zD+jBT2XwGVBKbJNFVx16AG7BaXeIN5J2hp1pyPl3fYTs6QzbQHFqYGdt/KOaLXF/t+5fNoJGIhQCbRMi6TsRpi6j4BsJHstaOHdJ5KSeuSow+uLH8y+XYLIPoT7s3U1XgCzMerDbCQG1HcJw1Pi8y0yNdBB+Crwddz+Y/8nUZLOjR3UWe68zNMfDp/kXRYB2oKryBCMWf9T9s6UIV20y0o/B5yoF/9R3JnIr5YkWHN5jc7H0L5PAL0RJLKW5561RaYHPERkxxltLBWDSgGUo0ausv8conJoy1YdIJlpbVK3bCp4QtXVKMFGW2S5HONUn9votHX11blRYyN+m6teOEA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j18-20020aa79292000000b006e0545768dasm6015711pfa.151.2024.02.12.14.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:06:47 -0800 (PST)
Date: Mon, 12 Feb 2024 14:06:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 02/35] scripts/kallysms: Always include __start and
 __stop symbols
Message-ID: <202402121406.16006BBE54@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-3-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:48PM -0800, Suren Baghdasaryan wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> These symbols are used to denote section boundaries: by always including
> them we can unify loading sections from modules with loading built-in
> sections, which leads to some significant cleanup.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Seems reasonable!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

