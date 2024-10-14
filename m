Return-Path: <linux-arch+bounces-8123-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F6E99DA4E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FAF283437
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADE1D9A7E;
	Mon, 14 Oct 2024 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4gZIBAbm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7571D9A5B
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949762; cv=none; b=sQbDtyqyqrjbTrqvAF7v9kTYHKV/vk/qlVDQXhb1DaWnk72iG/x7eRFpRpknzry5/W/V89u2vWCGkEldvj6y1Sj6lWZE/LKU6Kd4s/SVJ4b7AJu9bugQM2lzvZye+fxYKcPtDK9kWOEatshEbkZVLQCqG8VSsJeZY3xXqULlkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949762; c=relaxed/simple;
	bh=1SZ+jfinI7KnF20uWq+5MiVKe7evA6ps9MC+h5JnAKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqzxrkylH2B5FBEHqpK9YEV/OrncFldx94W+lFzo5+MOT6s3E9AIr/32V/mkwBiixI2ncXERcuJTCaEhfDy5EdNmylRi/qq0G0deRfZRlTeFqjBg08qxRzNWvHQUSDOwgknKRBbC36stGx5CbISWz1nnALesk0SGEYi2ELmSbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4gZIBAbm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso4954158a12.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 16:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728949759; x=1729554559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SZ+jfinI7KnF20uWq+5MiVKe7evA6ps9MC+h5JnAKA=;
        b=4gZIBAbmXgMngcMGOdEzLFMrVuIhioYRlNLl7eDALx9Od7dFttDJ+fPgSm6qLuAqXq
         zvrLFPzqR2Fz2ucqNevLXwsCwyTbYV6oF4cvjjjW1mHoNE83439TzUWbBFy8xD2PrMG8
         aE1PlRDeP9H6T0KW6tMJL7hJKIGlOjIwjAq/SX2wGAAuOT80wagHxyGwEotpFtoCsS1d
         FjZ50o72Yqza+ImIP3hbMg5GdbvJZjUfgXSxNpMm2wcfv3FTVB0fRlBWh9VjEA7GyxyD
         6Ajg2gw9ui4JmA40AEQAWtFkNzvukfjsY2Cr19+j+qVFIbLqISZei/3QGZ+Vo4ZopgmX
         Pywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728949759; x=1729554559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SZ+jfinI7KnF20uWq+5MiVKe7evA6ps9MC+h5JnAKA=;
        b=WeYQ1rW+ZgVRQgyBy82/XNdw/VB+P47ccyGASiulS4nhekjIHxN+1oqKN4xl8/rYOk
         KWHbOPm4Iuz5ChyBAQbnN4zU/ujOc3cRFD/ykM73nmKn2YP+UaAwwUZW+30NLkMUehNQ
         glWoT7tyT+AQp2ebh3tRUHhhmMWeOnW6dM5BphC23BlHPynk/nkWpSdxdtStHE5cvtgV
         c4hVlERx/sDiGytP+hQatJkF+F+ysGEoZlBUH8yn4k9fL9Zwtf77zfatlXUJaQD4+A7v
         Oc21qf7a5Aiw8amoRINYYw3qQM93KvPRNg3mJr3LTmfbwPDzoxmmbtR84M+tFl0J+X8K
         UP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHPZxFY9M9XZPWsygN4IBJ+oD8+F2KBFVa5QnFu4B0lrB917qqdDYJts/sj4PtvU22Rea+iFWafb5x@vger.kernel.org
X-Gm-Message-State: AOJu0YwNN/6vFuLAv/sF4SI07mPZzsXuy70Fpaoj7c5Vk+kI/fXumMIc
	JrmbbW7HWmu4K+H9ioKGqmKfzHp2pJj01ofj7ZizhjhNivIfPPqsLmlm00aLyvOkgc6tMPGJG60
	or0x0MtVs5wJ1n1mNPen8AQbTEl6BEyRvBU7m
X-Google-Smtp-Source: AGHT+IF3LTkRo2bNnzsq5dT0NEdsT3wmUih6L0PdgKsa4EEm9X0C1vz+srf2kxl0ec7RLeunLrfhzidYV/TpVSBkxmQ=
X-Received: by 2002:a17:907:e6cc:b0:a86:94e2:2a47 with SMTP id
 a640c23a62f3a-a99e3b5a86dmr831600866b.15.1728949758341; Mon, 14 Oct 2024
 16:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
In-Reply-To: <20241014203646.1952505-6-surenb@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 14 Oct 2024 16:48:41 -0700
Message-ID: <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	dennis@kernel.org, jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 1:37=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> references directly in the page flags. This eliminates memory
> overhead caused by page_ext and results in better performance
> for page allocations.
> If the number of available page flag bits is insufficient to
> address all kernel allocations, profiling falls back to using
> page extensions with an appropriate warning to disable this
> config.
> If dynamically loaded modules add enough tags that they can't
> be addressed anymore with available page flag bits, memory
> profiling gets disabled and a warning is issued.

Just curious, why do we need a config option? If there are enough bits
in page flags, why not use them automatically or fallback to page_ext
otherwise?

Is the reason that dynamically loadable modules, where the user may
know in advance that the page flags won't be enough with the modules
loaded?

