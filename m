Return-Path: <linux-arch+bounces-8127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A2F99DA64
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A9F1C21296
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747641D9A60;
	Mon, 14 Oct 2024 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1F0Z/yp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE81E4A6
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950232; cv=none; b=oFM5ZyZAnR+ouIwYFm8y7DZuKpSBw0ML2AYfEOqR8iUc/T0ljX6QDq3w4LSBVjnjKgNlhh1Wy9bwD4kXx5NMIH7+bl6JgUii4mYQRn5U352Bds75YrNotEHkaMEN5hzXGzhmXXkW4HrmqbjviMomJSJ5bKTiZV5IY0QBBxQ5EHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950232; c=relaxed/simple;
	bh=8mMv1+/qYexUlPZZXjGJlHSVSZyeZZNxj0qHf5BogRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APXJ7NMiIx18qYFAFOEyh2Q8Dvc3FYiOfjNY9u2kt/W8Ignawrfb4MysZvHEkT++yel8A68v0+yfx+3+bebnugE0cvkdK/SlKZuIf90CB29T+Sg8ZDfJ5dWKiPx++CAU90CGFfNVNzjB6CPHNH/yVw9wRIUmcHD6aTpIcE2L3tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1F0Z/yp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a994cd82a3bso717510466b.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728950229; x=1729555029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mMv1+/qYexUlPZZXjGJlHSVSZyeZZNxj0qHf5BogRM=;
        b=V1F0Z/yppu5snQoQNnKGiskGOaom5M9dE1nCdnqMx0Sh++MfM71joAGVJZc6E7bOyb
         TyFDdGnOY8VCIRMbR4sSUyaVfvXacXjuIoZthYs/tCYhIkatOkWWQsJ0Asjv1Kfmpgkd
         yy3x5B6alXQaGjMp+W6N4m5ZoYJaVsFT6tGCcQM13KfkAD/DhBmN5EJq/Z6Um3kfJI0q
         sxLaLNpjFZzTN+96+jC2jT4v0T4MXjHeOef6/b6hAWnCCgv0gmpNjxkkzhDxlrQ0VuGJ
         Reibacf8AB3o8kB3/7azJXsqY3UKHrsivIb5Kl3til7Wf4h3QQm03QsXS+/eFK9pBLvT
         86sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728950229; x=1729555029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mMv1+/qYexUlPZZXjGJlHSVSZyeZZNxj0qHf5BogRM=;
        b=haXSm235M7ujHbC2oQ15lLhG5D/seDDH354hrgkulFow2ie+gW1BAz5nUPCVcqdtC1
         lEv9jiSUsXybcRqcxhPEw2P8H2RFo5Wf63yl+lwew5hQ7vQS1Kw+7aLx6whzm5svdZg1
         pbi51soaNDAEz1X2go0soHx9byG9oxeCVq9rEeqha6VcWtT5XS7u/d+vQCwsxh4N5FkH
         ChjWDhwZUBH72wQ7RMP4QosHpUfe+HAIdi16n9ZveZSW46ARvAlpZ7Nq8V0MTaXoop8z
         IjEPHbJgXbSwUucyIKQOuQ6cffVkw+Vzu2JavlXU4QbID88ppuP+MPA1C0lH181iAfPt
         W/sg==
X-Forwarded-Encrypted: i=1; AJvYcCWMk3THtcbvYkJJJi5Ya/DWEwZCTwJrO0la/ihbQfwqbxOpK2QsxW0cBKO4qjHqUlodmj7HP9ghw/zo@vger.kernel.org
X-Gm-Message-State: AOJu0YzxbOtBzgVq2VVbTQnogYL6BHOOyD+Xe/3OmsHGHcRECpF1BG/+
	uthnCsyZy7m0nfgShGcsgVNkwvrjAKdZgNmZ88h4vnerMmyFf77hQn8gaIL6T+sllV2lljJr9bW
	NzPaDrT4sLAv/AyGYnVLK39TNBMyqktwnfkPC
X-Google-Smtp-Source: AGHT+IHCRbSEFH8dvrQfl8w/MPZdNADUHU+gGQqJoXe1fpzCrFvaqa6J94TlpNAt8drNzGuJlS0SjcmCg/I0CEvyR2M=
X-Received: by 2002:a17:907:2ce6:b0:a99:fb56:39cc with SMTP id
 a640c23a62f3a-a99fb563b89mr582010566b.38.1728950228942; Mon, 14 Oct 2024
 16:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com> <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
In-Reply-To: <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 14 Oct 2024 16:56:32 -0700
Message-ID: <CAJD7tkY8LKVGN5QNy9q2UkRLnoOEd7Wcu_fKtxKqV7SN43QgrA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: John Hubbard <jhubbard@nvidia.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, 
	paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	dennis@kernel.org, yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:53=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> On 10/14/24 4:48 PM, Yosry Ahmed wrote:
> > On Mon, Oct 14, 2024 at 1:37=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
> >> references directly in the page flags. This eliminates memory
> >> overhead caused by page_ext and results in better performance
> >> for page allocations.
> >> If the number of available page flag bits is insufficient to
> >> address all kernel allocations, profiling falls back to using
> >> page extensions with an appropriate warning to disable this
> >> config.
> >> If dynamically loaded modules add enough tags that they can't
> >> be addressed anymore with available page flag bits, memory
> >> profiling gets disabled and a warning is issued.
> >
> > Just curious, why do we need a config option? If there are enough bits
> > in page flags, why not use them automatically or fallback to page_ext
> > otherwise?
>
> Or better yet, *always* fall back to page_ext, thus leaving the
> scarce and valuable page flags available for other features?
>
> Sorry Suren, to keep coming back to this suggestion, I know
> I'm driving you crazy here! But I just keep thinking it through
> and failing to see why this feature deserves to consume so
> many page flags.

I think we already always use page_ext today. My understanding is that
the purpose of this series is to give the option to avoid using
page_ext if there are enough unused page flags anyway, which reduces
memory waste and improves performance.

My question is just why not have that be the default behavior with a
config option, use page flags if there are enough unused bits,
otherwise use page_ext.

