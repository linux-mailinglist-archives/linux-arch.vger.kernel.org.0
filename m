Return-Path: <linux-arch+bounces-8491-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459729AD2FE
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 19:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB84DB23208
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 17:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331C71CF7D9;
	Wed, 23 Oct 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="p3TvOeW6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0FF1CEE80
	for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704965; cv=none; b=p8Je0AsOaFQKdXkmHxLC9QW5MHO1jzaZpjFK1QgpA4tVnGfHiPTgkztIkXq3v9hfdnD7A6CqYxDs1ZwwBQ56PMF7qf7t9m/rXkxtbfJul8WgRbAkGtM3kKKGfKMzGX4X+eAOZryBmXc8Jw1ZJ48DnOyViZSgotHxgaKGF9+n7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704965; c=relaxed/simple;
	bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+D/m6KvjYsCdmow1PEi6tyzsft29y/apXRnRoCydAmIT9xLFUcEkaT9LRUAIkv3aZsjyWgWEEInInHoyb8yQ8kNHLcF/XYXAXx6nx88Gx/x/XNY+3kDo6E9+JQLGZlay3466Y3fMdQ4z3RGkVaIHZTi9i0FTfBOXZLk9YSR12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=p3TvOeW6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460da5a39fdso326241cf.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Oct 2024 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729704962; x=1730309762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
        b=p3TvOeW6Jz9kyt/cda8b0kWu3Fs+uT+KJ3GUAjhhWHNjGVFqGrc5a3aILIlGpoILXm
         CQBK+0WGb+mwINNG+hKDM60Pz71iKsu59smtEdd2LvJywWGzgoe5asg1Cohvl6RCJ5hw
         f5GAuaDTGnsKzVaQNwO4pGW/2YYLJ5WLBkG1vYKiHwH70W4m6VEyzqBH10EXpLN4tXHO
         1iOv7WYpl+2RQ00RUbq7XU0IiuUYeB37oi2BHpO27TVbzaMYGHyzpIbY+OUsPlUzm0Gc
         +2q/r4NEfJWZHa1TfWLSMM4/DvEIzSoouR3gARLrJxzOG/1laanLF+4c+pbIqpvLLyah
         dTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704962; x=1730309762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
        b=ORg6fJTlxvM+wqLgb5Z7EWySF3pHhyrjMzcA20DOBTGjTJQOv6LSZxwJqSDRxkskpS
         Jq61YhpwCgPJyCAbpLvlODJPmtIghMQVGovVWxwyxsY5y2NdgPFMf+rYJIdriBOG7YpN
         B9EhJ3iBRUIGyj9D2ehmpV/Xo+1O4aVhN3vq6x+jMtCVlvmXvs0jGi88Zh5a+URJ+CNj
         W0NFmHRVjWqdVS+6GdamYwGGN2o4nJFeb6m9P+/6FVSdk9XAJVW9AYYr7aWWAfqPaQ7J
         xVwPZgNkQr23PkAo+b/LjxT5V1drvf0XEFRzrSJCjJlDx+vTL8FIIo8t8hS4dKOTEdND
         Ya5A==
X-Forwarded-Encrypted: i=1; AJvYcCVUIHztWE+LSzuUEsQbdKhtJCnz5zCbIIF2+li061edoeRq5C7Xn2Hh/MXlL6nrJxMcyTUV8owvB7h+@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6UvoPpY+VU0GTdCMqf9/QBaPDobIzH1UW5FHZ6SRNRQOPDwR
	ym40zIPq52C8g68S7D/wg19DCMgdIkFmSaSNKk1OAehfHVXMM8eYluGPj2X6cKm+r/jzT0Y6hik
	pFWBZCrEQjuRVWBl6gc+8xrixQE1Dl2LA/oWg7A==
X-Google-Smtp-Source: AGHT+IFV+lf1cZYVfoZTKRitSaDBfAqj+KRGY17augig5JAjskqsVjHe3OvS9TISaOCa0dNfmisxyapMIUhj1oFRM3E=
X-Received: by 2002:ac8:5e0a:0:b0:460:a942:e8be with SMTP id
 d75a77b69052e-46114714d4cmr43850111cf.37.1729704961651; Wed, 23 Oct 2024
 10:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-6-surenb@google.com>
In-Reply-To: <20241023170759.999909-6-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 13:35:24 -0400
Message-ID: <CA+CK2bCUqFeJdWqMiKRNEjWc15vUsk9YAbaLqgL5nAXM8ZkdBA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] alloc_tag: introduce pgtag_ref_handle to abstract
 page tag references
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> To simplify later changes to page tag references, introduce new
> pgtag_ref_handle type. This allows easy replacement of page_ext
> as a storage of page allocation tags.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

