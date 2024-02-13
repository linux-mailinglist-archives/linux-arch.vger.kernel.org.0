Return-Path: <linux-arch+bounces-2269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581E3852587
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 02:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8A31C23FAC
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 01:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3B71AAD7;
	Tue, 13 Feb 2024 00:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyfumgKA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBEA18E1C
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785239; cv=none; b=FQUUHVI4j/vaKJA8tSqeXpcTQkIXu0yn8uB5xITEEgnXBWvW+3ZYscwAgS/a2xJJJaGoOgZxs11RZSOTE8oY18cq9qvgexnegbhZX2lORwUItgKBNuzisc2TrzjzLobczoSuZdkB7eL/6M26qAsWOdrhy+my5cqPTIF5pSKUjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785239; c=relaxed/simple;
	bh=vhshgUQEMVOYmzGB73Sv6P0idtfPu8TvDbWS2Ao2ViM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRzOG5xl5S4p4KAjSnOB1ib7EOAhBZkG6P3gXC+wxsgwud6Nz/XfZUvu0dGOm9kdFPN3ypW436r/0g4QqgvKlfY+ZtC167/UwrH6NeHwnn+va00vRorrxxhRT9vSZX3MPW1Jpry/JQ2z1Ji/8QOVxgDWHCY4WOeptb6p/loG/bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyfumgKA; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso125217276.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 16:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707785237; x=1708390037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sfE4CKDsYgzSNtG/2Z/eISWKsnaJqJipJlJ0mll8gM=;
        b=fyfumgKA94Kgr5KyPD1Vrqt0YbS0rqT8sOp1pFHm9s8Pxeq4CntxOuztXKMBlSddTe
         9w9NRxkP/t724Ws90+hC9Ec2T56g3ZCmgr+/M+7a8i+a3+basEH7KIZfrooeNBQbkztP
         W9cmzqhXfhcDQSgcO8Ht52/qdDmpQAraZqqZexkKMINS06ryY2yf8SfbRmTSqfTogAZt
         R8Eq414Pt7FHMMQDSBLVL07sNjXU1xBuCVTWm2bFuxiiphDwenEE3+FKpP4D+q6oGTWU
         Vrbp5OU656s710gCp+2yaZTU2NCVsDVRqEV9VPdHFDT8k66AbHrYx6MDnM8tqqrjeolD
         WvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707785237; x=1708390037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sfE4CKDsYgzSNtG/2Z/eISWKsnaJqJipJlJ0mll8gM=;
        b=gN/fabw9Gl7EQ+ZXZViY3l1CTNSxhErizNzHetPwYaGFNwwFbGmHf3ObIIWLYUokXR
         fJuirpsUx5NoZtadXUXUmjY0FNL79KIbhRHssr2oNWcc8e8qcOMBq46T5JSZAZ4IJEG8
         eqOij5S9RqiXMWQ1PMrZws5IZ907NIx3oeMOGCy902qK12u/PUe3dEvfd7JMRGdVcuDb
         hv4sbOPvOyh6d+8JFX86AZzb+/1dcrAaW1ugprI0z+l7c9k5zP+mnO/1sscY9xbobCKy
         up7FJD1u+o8a7cWtXvboGWgKmFOiK9/H03ngHoNq6y9QhIPqRrzpjfLoViEX0qawxlt0
         CNMw==
X-Forwarded-Encrypted: i=1; AJvYcCVWHqGAoNuCfwx6JK7yPYdIO515xgEjLieZZ/lc8VzTnbzZP+Wa9PQncA1QOQNOjoaMfFu6lNGzgjLT0eAt1slWElQ/HheUIRKhqg==
X-Gm-Message-State: AOJu0YxqjqLYxqMvAZGZpWxQobg+6XIyg9EZP6u6ravkN3lMmJzzdmxW
	llS/6XsdGkudjsewO0xPfLCjOMIZKw6imoRsGWqBhXuvbK38rMMy1kjdQLnAa9RO5d1lrqulseU
	F+z27ce5wS8AMc5KQQFC+0O5DjKvT2CEKtgrl
X-Google-Smtp-Source: AGHT+IEd+FNtHN/ZZbzmP1f2A4KejGHdBoOnJaz/mv/ay/4vdGzg6uBQFsFNAQAmwG2iUWNQFb7fDd1J4oxNlZWT4bQ=
X-Received: by 2002:a25:848d:0:b0:dc2:50ca:7d03 with SMTP id
 v13-20020a25848d000000b00dc250ca7d03mr6944337ybk.1.1707785236496; Mon, 12 Feb
 2024 16:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <202402121602.CC62228@keescook>
In-Reply-To: <202402121602.CC62228@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 16:47:05 -0800
Message-ID: <CAJuCfpF677Fu152GQAgD-GW=eFPsRMXfXzyXtnc5p6kPsxeQJA@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Memory allocation profiling
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, ndesaulniers@google.com, 
	vvvvvv@google.com, gregkh@linuxfoundation.org, ebiggers@google.com, 
	ytcoode@gmail.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com, 
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com, 
	42.hyeyoo@gmail.com, glider@google.com, elver@google.com, dvyukov@google.com, 
	shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:29=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:38:46PM -0800, Suren Baghdasaryan wrote:
> > Low overhead [1] per-callsite memory allocation profiling. Not just for=
 debug
> > kernels, overhead low enough to be deployed in production.
>
> What's the plan for things like devm_kmalloc() and similar relatively
> simple wrappers? I was thinking it would be possible to reimplement at
> least devm_kmalloc() with size and flags changing helper a while back:
>
> https://lore.kernel.org/all/202309111428.6F36672F57@keescook/
>
> I suspect it could be possible to adapt the alloc_hooks wrapper in this
> series similarly:
>
> #define alloc_hooks_prep(_do_alloc, _do_prepare, _do_finish,            \
>                           ctx, size, flags)                             \
> ({                                                                      \
>         typeof(_do_alloc) _res;                                         \
>         DEFINE_ALLOC_TAG(_alloc_tag, _old);                             \
>         ssize_t _size =3D (size);                                        =
 \
>         size_t _usable =3D _size;                                        =
 \
>         gfp_t _flags =3D (flags);                                        =
 \
>                                                                         \
>         _res =3D _do_prepare(ctx, &_size, &_flags);                      =
 \
>         if (!IS_ERR_OR_NULL(_res)                                       \
>                 _res =3D _do_alloc(_size, _flags);                       =
 \
>         if (!IS_ERR_OR_NULL(_res)                                       \
>                 _res =3D _do_finish(ctx, _usable, _size, _flags, _res);  =
 \
>         _res;                                                           \
> })
>
> #define devm_kmalloc(dev, size, flags)                                  \
>         alloc_hooks_prep(kmalloc, devm_alloc_prep, devm_alloc_finish,   \
>                          dev, size, flags)
>
> And devm_alloc_prep() and devm_alloc_finish() adapted from the URL
> above.
>
> And _do_finish instances could be marked with __realloc_size(2)

devm_kmalloc() is definitely a great candidate to account separately.
Looks like it's currently using
alloc_dr()->kmalloc_node_track_caller(), so this series will account
the internal kmalloc_node_track_caller() allocation. We can easily
apply alloc_hook to devm_kmalloc() and friends and replace the
kmalloc_node_track_caller() call inside alloc_dr() with
kmalloc_node_track_caller_noprof(). That will move accounting directly
to devm_kmalloc().

>
> -Kees
>
> --
> Kees Cook

