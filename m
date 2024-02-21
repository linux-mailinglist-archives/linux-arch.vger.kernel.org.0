Return-Path: <linux-arch+bounces-2649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079D285E99C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 22:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E78B23847
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F93126F22;
	Wed, 21 Feb 2024 21:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JqGo42K0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38F86636
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549904; cv=none; b=tqvVtfCcTlaRIjwd85oQocIz7anUGoGztCch9eCY14heu+3H4tUNaX71R2HbwFHWpbuUH3GrWtkNeN2vOs2MMtR7slGfA+5ztD4khoBPzkESWFRA8GXkSyg8SB+m+CJyKKfk3/9jVEYUzZs5U9lAELiLOf/oHsd04ioCs7rTr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549904; c=relaxed/simple;
	bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfSAEkNpvtEtUv3vIXalvtk7xRf+O8hSUnhp1DQK4hj7l4dV9MiNC4FIM9LOcsZuEgZdRr7+FLR2gVmPSSzVDvcm25YaWNUUys6cY9LkAYnmR09pU99PwZznKGX/bVaXwvihB7b+nxTBlTJPS3VZk96nKhnedzyUlS2lR5YyHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JqGo42K0; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a9f4935a6so1438311cf.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 13:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708549902; x=1709154702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
        b=JqGo42K0IIZzOOrr5BR0MyClkvN7YeDKWCfNCwv/TokZY3MsqLl3j3ldqGJ1DPOTLO
         +ynRcDLGtUomnUMTZ92ie0J+88VL3PPuba2doqpMATUePt69slO+v2jfkeCM/L3caohU
         AeG2b3uqOSss4AobANVRw0xACblRms2znrJNVRRYzWYzlQNntI81UNGjjllb1CbseJO+
         N5i/i8NwBc1feIOuQ2opLu+f0BT+qsc6jM9KE2S1K2qtVlS5Xp/f5v14BZOnLMry7Kn8
         4tDyWcKwiYHiwjWzVgAwB5bfsWEsGCzJrLNPN7Fdp65xZT7Psx1y8sljX3hfAzQWWuk3
         NjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708549902; x=1709154702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azPaND/xFc8atz8F6WN4yBES0vGIQl6FM+kHStQ3aX0=;
        b=o9252oxqRhjxPQCXWgtxo/6ounkg5YZAs5N9cfKgayF0PcO3ZSnMm2S01NA7EcY5UQ
         uPtrwJSHer3kE8y7417A+MBCAThSAhC8TLN1XYvCgkibujsXiifyfAXPDoeyoAM6fOiq
         I1j9NlItWk5exIAU0hZZloq9H3zaGlk1DzLfRfJc0Uhk/D68eNhyvAM/nmOTSKPE7Oo0
         bqQzZ+4xD2Ox8tFMpEPx++X8pWEmXGzOv+uqhjAQKWjego467/ObOJgTLDXz7UqBXqm4
         Bt+874Ipy/DzJfjjIlIoU1wghGWIi0FlQx639GRSWi+JBgo8avo9Bon4ucdwh9izDny7
         +WNg==
X-Forwarded-Encrypted: i=1; AJvYcCVeXh1zVH4GXbTz7qnN6GEYneZEsNhJIVRsYCgTuQaGxf60BmQul2cK52CsUEuKUFSWoc2MjXdFOiBI5B+4glIFceI1FRzIDvmF5Q==
X-Gm-Message-State: AOJu0Yz5w+qBpT8oPlx6anFFblg1fbS23bQlHTTnTgFIox4D4pOORjWU
	FNDP1gDT+ahm/NQ4l5QqL4ZZEUT2+kviEWXUbGzCXlddyRbyO15e0W0gwi6xYL5Oe2w6W3HHgJN
	UdfobIjvdXhu7r3FWyS4O7YCajtQZMkjhYsn+9g==
X-Google-Smtp-Source: AGHT+IEHXmwL8Aza8YxstZPNawifsEoPmvz+hNBFt6a/ALIjCAdVsEQDIakNnjXyrMZE7cImyXSV0z0ORZ0TJZY1zT8=
X-Received: by 2002:a05:622a:1a0c:b0:42e:3f7a:819b with SMTP id
 f12-20020a05622a1a0c00b0042e3f7a819bmr1401231qtb.8.1708549901753; Wed, 21 Feb
 2024 13:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-3-surenb@google.com>
In-Reply-To: <20240221194052.927623-3-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:11:05 -0500
Message-ID: <CA+CK2bAs4t1UhLBahnG9GmFYgW2KxdO7PZkPwD4Wbv7oE+aMhA@mail.gmail.com>
Subject: Re: [PATCH v4 02/36] asm-generic/io.h: Kill vmalloc.h dependency
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> Needed to avoid a new circular dependency with the memory allocation
> profiling series.
>
> Naturally, a whole bunch of files needed to include vmalloc.h that were
> previously getting it implicitly.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

