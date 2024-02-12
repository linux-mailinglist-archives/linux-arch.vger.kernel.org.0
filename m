Return-Path: <linux-arch+bounces-2257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4579F85222A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 00:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC0FB22F75
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 23:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF24F608;
	Mon, 12 Feb 2024 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CSHsxssM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01051008
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778802; cv=none; b=f/bAkto+xmMMd5Ocsi02761S3HbfoHIq64KSO0gSj64A6iQOLyHrQs4YZYtKLp65cl37ISolQe6OGM9s3JDFs/u+a7ae5x9gByRgrA+4bb88v90Pd46uW/caWQ0bIW6e9yPTwDzC0LhDtAcA0e87/P/1FLmdT7V2kq70ARpL1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778802; c=relaxed/simple;
	bh=aYY2Rs2oW/xk4wvqKVnHjM5RBsMS+W7rJ4ZfUJGebUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGPIS5GSixJzj3Eh8Xc+5YEq1EXBEDL4jJf7HDSD0iWd8C7E+nvbdIPInEkuVtbEsG/FykpBJZhDEHlCtoKldHkxYkuQare5iFC+sstn76pZYPAGMWgwdnWletSQFT7CKeTzwClIIEJOuaMk5juAL9y0BFF6tK5pTGlkDikGqtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CSHsxssM; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e2e44aad03so960381a34.2
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 14:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707778798; x=1708383598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6AxC+gFNzLegoAwuSB5/O4MPPTQdLkk2fG8bSEFU8c=;
        b=CSHsxssMI9FixXVytsmRDJhZdsRn9ZYT//YUZXzZ5VtUokI5Mm5H4M9E1UmXM+xU/8
         h7ekOzi+2N41WsdclXz5sk8MpFXC8vJFdXlP0lQKafy0NRF0EF0LEhH6mD8N7Or6Qf2K
         vEI3BrqIsDFZEo1z3zmJlpZ1K/NC480bTbBYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707778798; x=1708383598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6AxC+gFNzLegoAwuSB5/O4MPPTQdLkk2fG8bSEFU8c=;
        b=PtiTC3IcVnOX487RnSwLT7X40Y3Pj+xULvU0DDYBNSrIJY/eKY4jl4g0L9RxjEN+tp
         pasoe0Ot3/x4VVJKtId0wMq9T774ub6jFD9oL5Lf5v9NNcf6Rm2r3p8+tQksduYaoNPZ
         XlklkcYrdaCWW2wGgu8XU9ft3Wteu68nPLSa5GQdHV4uxQmUtXj36bZqUejvCqfaXN2D
         hxFoPkjDrd6EGv4AzScdTlDTdM9MmcKa6Jaeyw31QeElVYLxaggl2wzH6qR1FkDFVBAv
         YurLyRs3dVFH6q3LVvbiHLDlzlOPlHsBQGIrtCZDcCGyFF46wf04YS6EFbpM66qIRcvH
         6/zg==
X-Forwarded-Encrypted: i=1; AJvYcCX9lKOs1U44M/3K6H27Y17d7IEIr/v9GsWqRvuDH4y4PdfIVUx9KFIO19kFFDGnTaXSv7dwgkP/watb67axEGFju8Kq4FUnQ4R81Q==
X-Gm-Message-State: AOJu0YypAngrz+j1zCbbbqn8aDaYw6FCDRbiKl+9BwuEWmNkx8gf48Nm
	NwcKJsyALWOb/+sgjwQs2/eHf0PBg1ppzJKN/w3oKkK7oCE5eGpDPcu/Z3mmKQ==
X-Google-Smtp-Source: AGHT+IFsaEygC2XO+Q0B03sBU7ZPnujQ/EvxYG+Mtl9An+rAOeacCcFpEMP2zzjc5kz2TyLf8ip3kg==
X-Received: by 2002:a05:6358:717:b0:176:3e0d:8a36 with SMTP id e23-20020a056358071700b001763e0d8a36mr7448969rwj.0.1707778797911;
        Mon, 12 Feb 2024 14:59:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUN/x1eVaIcn54RxZcQlNsO+ucIPMk7vlyGVyb87st4NyQ/iZ5l5eTz+mMvz9NX05jSKiZ7ZYO5ITibQUWmRc7IEE5sufBNZd2s8GtAEKSyxpknXaVNC9tmfgDMUJR9NYKVlEe/1LnldNDMUfaVmNHswunnZihDs4P/cvAafcI5W1vrHt8V4+Z+bO/k1ZTsPWxRokFSjfm6oCTiLjrrP4auVfEEOpepy7gb186UC3MH+XFtfPqQzSUY796e3OjPPwec8NsPkF0A20TiWDOFlAk3uNFcDoC4ngIlqIwrH9914N58Ba0PY05+q4yO//boTwxmNncZmfC9Phux3mDRTZQCfx7swsk9ps8J1y15zrHI9KUOqyBvcIYAbwWVl1G1XQbWAs9oo+aZikxTLaedFUex+JS992rESnig9RhrGExdrpNpjrhRHzO9mBxFPQQqkElUlL9icPTY9fTP8M5BjI7ayc7E5RQdtrdxpmMnbkR8a/E+boRmW8Fm3yrvR+qY8h/wetMaTa16l+tuMMMS1qVK3sxFtgyJ9/3irb0qV9n2X12TpuGrerIcNVx8AnddtXhoDct7E0b0iQqPVoR2gEXyAiXrq9UYPhT74rkEeIDU5eBs/d6G4spgU31W5T0LAZetTYBBRZno0gRcQHgKdiQc2H2OD64kIly/FXTx0a3EBYTi9MKcHcNIbKzwz07Las74bFVxmpCmDa9K+RptA9QWEyp3fON09CgBZ+rjTkTikn3L5bdPLA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z16-20020aa78890000000b006dff3ca9e26sm6089537pfe.102.2024.02.12.14.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:59:57 -0800 (PST)
Date: Mon, 12 Feb 2024 14:59:57 -0800
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
Subject: Re: [PATCH v3 21/35] mm/slab: add allocation accounting into slab
 allocation and free paths
Message-ID: <202402121459.DEFAB0280@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-22-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-22-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:07PM -0800, Suren Baghdasaryan wrote:
> Account slab allocations using codetag reference embedded into slabobj_ext.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

