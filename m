Return-Path: <linux-arch+bounces-6991-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C1D96AD9D
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 03:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E52BB2104E
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0DC4A3F;
	Wed,  4 Sep 2024 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzhWyZSg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9EE1FC8
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412064; cv=none; b=X0NNKdVPw3AGab+ufCI7+MlEmX2I22FaLPIpPSqIsNvWTjlb+UF+pTzDh8QoDEa68PDJQsqVub+0JljJqw008aeeCfUGuHNobMNIhcq3IzTTkgyudjAQkCeuMg+xHnd4JO6OkcCkCj3TMobwLwhqxQ34pn5KgYqfPUR/hdvecLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412064; c=relaxed/simple;
	bh=DX5NSZHC7V9EGffvDIQaVtzuppthSm2cBnyQmbw3uR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLgWz8jETXShRRETXG8dpN//NSIsJ3bBknag+RkF2f7Ey+fZs5xqSSUEm69uoNZnLNl+SgOIn8v1RT6QRDeg7mcrIChFs8zjqwtNcYLSs3vqif93rkpOv2oZ200BFx+3DfAoJjwmDx2mBIVbLlU25wn5e+e0OF0of8Fayjojvuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzhWyZSg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20546b8e754so58495ad.1
        for <linux-arch@vger.kernel.org>; Tue, 03 Sep 2024 18:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725412062; x=1726016862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiMCdeWSF+tl7YGOAELZGKbNlcDS1t44j3ggjkwtiLI=;
        b=VzhWyZSgaDy2et+aRhDn3RP/F06NPFUNlPl7Lqc9tLf/BuosBQXOVmpR3OuKZKxA7W
         fmoZZF6mDmPFyu0xnBqrC/WsOHBtHAS6DXsTW4+6pzmbVQ1FRM3F488YEQ9UO7ZW1nlP
         KYQXwqJXbuYPsWVVtgdtGhYu59hnGv6THNE6Se5Cfun/Vk4ycAGQjToY06CLTAKOu0Qm
         pxqMJO1/cRgvLYjE9htMhfcHEBdjlLRpcC8+wwCdyt115uX6BJTcznDM9+eLrmyEOJWp
         sN/XxjLF5aDNB1gOLzGHPOi9vJJvMCazisXhQCb2JSkfa1xpHzBkERNosWhNNfUAQv/j
         /gNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725412062; x=1726016862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiMCdeWSF+tl7YGOAELZGKbNlcDS1t44j3ggjkwtiLI=;
        b=nTdDuyv5ne2Y/8bVwMJHcweWEZNYz/5U6XtfBM5WJiC5FlvXwyT9KakBDbrD6oflq3
         kaD8WUnNOs64TIDV0PA+8lvOIqJwto9S7Y47aepyj5fToIenrQrYn+gf34ltAdw6vW72
         ckepw8JYK9HfnNPEfyzSy1lMWiAkEsic/wzzZ2cTkxkkLE2rDYZuviRTXFzyK5R6NpP8
         9rzWAD8fiiNtKrz/9aNgpJoCPS2FdKOesXR0SkD5tkzLQPXRITskkZsditlu8djI6Pk0
         i6U81SVKzrzbfxu92xw1h8VRm1lJEjLkM05EYewzqo1yItgNZ8ohzbR0jKeSi3oB1jOW
         78cA==
X-Forwarded-Encrypted: i=1; AJvYcCXAnSIXksAUsPl7SXlx+RvJrbFJqfdN39J27ffLHqhUw3UsMgkGl+lHEX6Jhk+QYwyy1RIl/9Y5QMwN@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdIdz6PCcPu3w0UvdUxOAWOQe2ZSS5EgOwZDTcXIuNbX/9iQw
	OGQYklolLm5MS0nNoYafYm8OtGkZfoOX2ZtXv9EnUSUN1uVD3hYhOxBTMX6+J4aLSANkOUKJMbw
	vYM4ylXJYrfbaHrdE95gilZC43BG05W64+xyQ
X-Google-Smtp-Source: AGHT+IHMZ7W6FQKnT8cNzSPAoQtVn4rXVv70QDuyzkhCB6YXblkNORpk0oIaHX18vr/BWumo0bGcKw60Ta+8WLK79nY=
X-Received: by 2002:a17:902:c412:b0:206:9e8f:7cb with SMTP id
 d9443c01a7336-206b070e38cmr1640645ad.2.1725412061797; Tue, 03 Sep 2024
 18:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902044128.664075-1-surenb@google.com> <20240902044128.664075-6-surenb@google.com>
 <20240901220931.53d3ad335ae9ac3fe7ef3928@linux-foundation.org>
In-Reply-To: <20240901220931.53d3ad335ae9ac3fe7ef3928@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 3 Sep 2024 18:07:28 -0700
Message-ID: <CAJuCfpHL04DyQn5WLz0GZ_zMYyg1b6UwKd_+8DSko843uSk7Ww@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] alloc_tag: make page allocation tag reference size configurable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 10:09=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun,  1 Sep 2024 21:41:27 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Introduce CONFIG_PGALLOC_TAG_REF_BITS to control the size of the
> > page allocation tag references. When the size is configured to be
> > less than a direct pointer, the tags are searched using an index
> > stored as the tag reference.
> >
> > ...
> >
> > +config PGALLOC_TAG_REF_BITS
> > +     int "Number of bits for page allocation tag reference (10-64)"
> > +     range 10 64
> > +     default "64"
> > +     depends on MEM_ALLOC_PROFILING
> > +     help
> > +       Number of bits used to encode a page allocation tag reference.
> > +
> > +       Smaller number results in less memory overhead but limits the n=
umber of
> > +       allocations which can be tagged (including allocations from mod=
ules).
> > +
>
> In other words, "we have no idea what's best for you, you're on your
> own".
>
> I pity our poor users.
>
> Can we at least tell them what they should look at to determine whether
> whatever random number they chose was helpful or harmful?

At the end of my reply in
https://lore.kernel.org/all/CAJuCfpGNYgx0GW4suHRzmxVH28RGRnFBvFC6WO+F8BD4HD=
qxXA@mail.gmail.com/#t
I suggested using all unused page flags. That would simplify things
for the user at the expense of potentially using more memory than we
need. In practice 13 bits should be more than enough to cover all
kernel page allocations with enough headroom for page allocations
coming from loadable modules. I guess using 13 as the default would
cover most cases. In the unlikely case a specific system needs more
tags, the user can increase this value. It can also be set to 64 to
force direct references instead of indexing for better performance.
Would that approach be acceptable?

>

