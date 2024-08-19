Return-Path: <linux-arch+bounces-6340-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226499575D8
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 22:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D8C1C22206
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 20:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF7159598;
	Mon, 19 Aug 2024 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBLLtbxG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239C15921B
	for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099975; cv=none; b=shE4kFEbPU7qc18T2P0a0g/CvwoUvbVLCdOR6dqtY7XRnLOEiBjQlmmhLXijt3RiGWHrX16CBy3UKIBMNnuSRxOF76vwgvdmRKZXsn0cRc1Y+KLZk1cwM1h8+sMhR/aZ6DKZZ88C+q+LJ7fMO/kmvwZUEKknPIjg273nRh+wf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099975; c=relaxed/simple;
	bh=T0k1rtWSUezuUqaQR160uwVIowUlg3cjp48OabdmuNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTdiMOjmsUwMYDZGcmv0jRfo1kQHhChNmFciL9hBazYz8HWsbi9CNBJqxraYH0JsTli5iE147CcFTrYdo9hFuTHnvlUpee3k9oj2zN1jwvXsBcdZ77tbgka2iviLU7bq6mbb0nUeeGfCcW0iCt9M+b5lP8xmhYEWxlMtU8My478=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBLLtbxG; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-690af536546so47229697b3.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2024 13:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724099970; x=1724704770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5uFM/7CjPk8scoS/LKz8NVm9q32EXxQmB7Ug1L0dZjQ=;
        b=wBLLtbxGYsFTtYW13iajJYsLptlyPjlqyJ5dZKLcC43BVaqbjPSmwoSkppweLNJylY
         dZiIDlMqq7d9VeP9P/gA8cQ+KODI+abKEazvqt8Klb+kV7CzdLQRT3zY8kjm1eRpCNxp
         Dld7//B8p6TY97u9NBwvaa90L4cKe7u6Q+H+Ibb6NASeX+79FVqwB6I4SO+nfzKZUl1a
         Q7YDIeh2wp5DpbjIVBRW9HaBUEbPHb2wQkMQdeArxLsKtAS15i6QWURQTNqjcOqWF8wY
         SAn27I2o3qHuOb4wc9ubqV1bE4ygavH/zBk3Nc0Iezg6H1PIbkk0osqunVZbfN4EpgkM
         TfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099970; x=1724704770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uFM/7CjPk8scoS/LKz8NVm9q32EXxQmB7Ug1L0dZjQ=;
        b=YG04o2LVZCJN3DUvbgkVwsl+SblQg6qNm7h2F2RcegD7tzPF0kW5uGculc91nSk6+I
         g7sUlv6IS7TOF77GkJMrv8yeWCOY5w4QcBg1M1UKgg/8+GiJ35gY46toVTOWrdXc4xc+
         NvzGwO50ib8ccPw5BigdbQVn57MtmBLL9tTHFanZKV4OeGHJ+ly/ypokOXsAe4v+FVOT
         ONKFKrJpwzIpPyXNpBtCqsHP0yv9C67Y2Jx6uB6UmGPch0sxpzE2wF1QtKIJ0DNXb59k
         bVGqzJQFnM/buuYs1Qa2ZSYVdd7TppkGN55jCaktyCxknpCsSfvM25EjtUZUQRoufSiU
         Adxw==
X-Forwarded-Encrypted: i=1; AJvYcCVOoLmh0ULCYIsVQjD7pF08cfkax5TNdaBlyq70wuc2zl+uSkK4MmxA3KgtfuoQzeNgTqqpYFMMeSOMVHaySJsUo2nXd7dX8ihavg==
X-Gm-Message-State: AOJu0Yw3Qt+BYk68+OS0GUcv1GhQ01Ijnyw4Ofym/AaX7XUc+0ZlnXU8
	QWLAKAzgQCSLVPzCPJBMk+zJUJW88+B9QswC5jPfTcc1pun6m9R2O44aUWqfH4MQ4szvW2lDokJ
	H8Ft6eOfrvIFcRoqi6C36jrBUc+jgSQR3rgDc
X-Google-Smtp-Source: AGHT+IElAuirGCjfeSZJPYUAW0ei9jJHOeGrwyuGYXkqFM/e262PAdLed4KeFggiWi4ZXjelTO/ciQYl3Ojs6C8UDM4=
X-Received: by 2002:a05:690c:4dc2:b0:6b1:9815:b526 with SMTP id
 00721157ae682-6be2f5ec85bmr2324487b3.42.1724099970130; Mon, 19 Aug 2024
 13:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819151512.2363698-1-surenb@google.com> <20240819151512.2363698-6-surenb@google.com>
 <ZsOeVSlToyhsyDGD@casper.infradead.org>
In-Reply-To: <ZsOeVSlToyhsyDGD@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 19 Aug 2024 13:39:16 -0700
Message-ID: <CAJuCfpH4yFw6RNKVDK0hqXQQhAhMsyGNp5A50E+c2PZd+_vOgw@mail.gmail.com>
Subject: Re: [PATCH 5/5] alloc_tag: config to store page allocation tag refs
 in page flags
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:34=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Aug 19, 2024 at 08:15:11AM -0700, Suren Baghdasaryan wrote:
> > @@ -91,7 +97,7 @@
> >  #endif
> >
> >  #if ZONES_WIDTH + LRU_GEN_WIDTH + SECTIONS_WIDTH + NODES_WIDTH + \
> > -     KASAN_TAG_WIDTH + LAST_CPUPID_SHIFT <=3D BITS_PER_LONG - NR_PAGEF=
LAGS
> > +     KASAN_TAG_WIDTH + ALLOC_TAG_REF_WIDTH + LAST_CPUPID_SHIFT <=3D BI=
TS_PER_LONG - NR_PAGEFLAGS
> >  #define LAST_CPUPID_WIDTH LAST_CPUPID_SHIFT
> >  #else
> >  #define LAST_CPUPID_WIDTH 0
>
> So if ALLOC_TAG_REF_WIDTH is big enough, it's going to force last_cpupid
> into struct page.

Thanks for taking a look!
Yes, but how is this field different from say KASAN_TAG_WIDTH which
can also force last_cpupid out of page flags?

>  That will misalign struct page and disable HVO -- with no warning!

mminit_verify_pageflags_layout already has a mminit_dprintk() to
indicate this condition. Is that not enough?

>

