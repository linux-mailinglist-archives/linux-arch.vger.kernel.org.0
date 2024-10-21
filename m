Return-Path: <linux-arch+bounces-8358-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA379A6E6C
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D23B22442
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE61C462D;
	Mon, 21 Oct 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iEq9C0ur"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F41C4629
	for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525274; cv=none; b=HJM2mDzJtnubw/BrZydENZsVWwxyKeRcKZkGSDtpro7OjXIUwzknB6CNauK8e2UgyUOlrOMB0TlXAx2v+NJd/vDwaw6mJSNQczILQ7XMaosP1J1XM4hsKcx5IuEka67lnXIxR5HPCzwg3E8LWg0Si/EJCqXSIk4L5UqKJCQ7rO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525274; c=relaxed/simple;
	bh=QgCvodO46hTTI5gZ6i2TOnJZBpE8dcVMjVLVj2nnCnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBVSVD4Zu2IOOQR9rx94MePVvD70nzttfn5lc8rcQglHsuEtkOzpI5tUwmN9JeivOBp+XDvJr0w3to33dSyme/5EvYTTSFBYtL5AFDoY59d3vAGX1ykmbH6JeonLbUgxn1WwEhstujdUCfxUbaK4JAMx+nnz+SGwCzn/HJH44lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iEq9C0ur; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460969c49f2so403811cf.0
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729525271; x=1730130071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgCvodO46hTTI5gZ6i2TOnJZBpE8dcVMjVLVj2nnCnQ=;
        b=iEq9C0uroFXo5MUPHevr6AGJ9PJx0a+lgHaZfxW/z2aRhYk7lHfVn8WMKLllLKYY/D
         woE67qvC2YGtusobVGIv4ZnXxRkF44UASyqcZSPc/y77jyex6jXcovPXEmSVDRDUl1CU
         OPOCudnKtUgMyWurtWICqoNt/2L2qp5dnlfSOO8BO+3OKEgUQiJrWbiOAaBFeIPinI/4
         SK91VYfovmq3/nZJQsCM8w3Tk0kQIkv+OR7wloOD06tCwnXRkaoszXzof9JICuWArkkV
         NDBo/YsAx2aBT308OXmH0U7GY1+89icX/EPY3GYwuFqmr55R+G8UQ/z7PMaq730Vl89e
         jALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729525271; x=1730130071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgCvodO46hTTI5gZ6i2TOnJZBpE8dcVMjVLVj2nnCnQ=;
        b=TttgcfvH1vId6RyzHyXZmenkw9q6g5jfwIkTUDhFmLBskxWOpIPvw2pOEKsesC9bhL
         19WcYHHd2c17T7UhkvxpJpQssEOIdVm3yClcHS8xdY07j9HnaCIJI8xCqdKqavkpsErr
         tf6EaNZF0NcNmhbQAXtUj9su7A7YxqKfs3Lh0AUI1uUnak/4/7d/+wRWo07bXQkKbG9g
         7wlKWcV2br9c++HFWqfr6P5z0hsJ/ctK8mrAYGb5cYncsiRyMx3exIrg7U24MB7ip1W1
         Kwpp1fLZ3WdIIJksOJdGhFgR7bo29aDlZND7+VsG1nkC2x87XJ+6FYGZu6lgQrXerV+z
         Mqow==
X-Forwarded-Encrypted: i=1; AJvYcCWL9W8HcbBxyIE4vwYneoRb2XIVnELx4qvV3MhLncGkV5QatYrXs0r1vS5jFG9aY5g8Idhnlyz+eMrX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZJcml5S4g7HSTLPt0aClNx/NIeq4RmUUoIgHXwMCk+lpLU66
	MWpBRxJeL3OfDTfF9ur3echgfqw9D99LYjMC/OcV/HTOhxAb3PsJTYIJFxxmBITAG6kbmyEjRa0
	+EqVTQQq3JCCXZyo2GCRsoDLeWVjS1kEIjmlu
X-Google-Smtp-Source: AGHT+IExtPufc3i1BL5ORPSIurwCGrgj6wuZl2/Fc9n60P6WgQQhEtufE2gQBIUUvs6EKf6872QUIbUZidcdeHoRLZY=
X-Received: by 2002:ac8:5742:0:b0:460:900e:d6f2 with SMTP id
 d75a77b69052e-460be412160mr3854491cf.1.1729525271200; Mon, 21 Oct 2024
 08:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9c81a8bb-18e5-4851-9925-769bf8535e46@redhat.com>
 <CAJuCfpH-YqwEi1aqUAF3rCZGByFpvKVSfDckATtCFm=J_4+QOw@mail.gmail.com>
 <ZxJcryjDUk_LzOuj@tiehlicka> <CAJuCfpGV3hwCRJj6D-SnSOc+VEe5=_045R1aGJEuYCL7WESsrg@mail.gmail.com>
 <ZxKWBfQ_Lps93fY1@tiehlicka> <CAJuCfpHa9qjugR+a3cs6Cud4PUcPWdvc+OgKTJ1qnryyJ9+WXA@mail.gmail.com>
 <CAJuCfpHFmmZhSrWo0iWST9+DGbwJZYdZx7zjHSHJLs_QY-7UbA@mail.gmail.com>
 <ZxYCK0jZVmKSksA4@tiehlicka> <62a7eb3f-fb27-43f4-8365-0fa0456c2f01@redhat.com>
 <CAJuCfpE_aSyjokF=xuwXvq9-jpjDfC+OH0etspK=G6PS7SvMFg@mail.gmail.com> <ZxZ0eh95AfFcQSFV@tiehlicka>
In-Reply-To: <ZxZ0eh95AfFcQSFV@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 21 Oct 2024 08:41:00 -0700
Message-ID: <CAJuCfpGHKHJ_6xN4Ur4pjLgwTQ2QLkbWuAOhQQPinXNQVONxEA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, mcgrof@kernel.org, 
	rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, tglx@linutronix.de, 
	bp@alien8.de, xiongwei.song@windriver.com, ardb@kernel.org, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	yuzhao@google.com, vvvvvv@google.com, rostedt@goodmis.org, 
	iamjoonsoo.kim@lge.com, rientjes@google.com, minchan@google.com, 
	kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:34=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 21-10-24 08:05:16, Suren Baghdasaryan wrote:
> [...]
> > Yeah, I thought about adding new values to "mem_profiling" but it's a
> > bit complicated. Today it's a tristate:
> >
> > mem_profiling=3D0|1|never
> >
> > 0/1 means we disable/enable memory profiling by default but the user
> > can enable it at runtime using a sysctl. This means that we enable
> > page_ext at boot even when it's set to 0.
> > "never" means we do not enable page_ext, memory profiling is disabled
> > and sysctl to enable it will not be exposed. Used when a distribution
> > has CONFIG_MEM_ALLOC_PROFILING=3Dy but the user does not use it and doe=
s
> > not want to waste memory on enabling page_ext.
> >
> > I can add another option like "pgflags" but then it also needs to
> > specify whether we should enable or disable profiling by default
> > (similar to 0|1 for page_ext mode). IOW we will need to encode also
> > the default state we want. Something like this:
> >
> > mem_profiling=3D0|1|never|pgflags_on|pgflags_off
> >
> > Would this be acceptable?
>
> Isn't this overcomplicating it? Why cannot you simply go with
> mem_profiling=3D{0|never|1}[,$YOUR_OPTIONS]
>
> While $YOUR_OPTIONS could be compress,fallback,ponies and it would apply
> or just be ignored if that is not applicable.

Oh, you mean having 2 parts in the parameter with supported options being:

mem_profiling=3Dnever
mem_profiling=3D0
mem_profiling=3D1
mem_profiling=3D0,pgflags
mem_profiling=3D1,pgflags

Did I understand correctly? If so then yes, this should work.

> --
> Michal Hocko
> SUSE Labs

