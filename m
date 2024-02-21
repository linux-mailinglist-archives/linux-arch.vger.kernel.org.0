Return-Path: <linux-arch+bounces-2653-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D785EA11
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 22:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AA11C23F56
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 21:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598E51272B3;
	Wed, 21 Feb 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="CD/Z8BK7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124866B4E
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550658; cv=none; b=bwuA+o9tsW4OYU/ZUas9264KkfMpilH3n+BmfgBw7ECF2jeHxEgbGj1lJS59URVWVZOyYaXhhwHfWbF6D8m+wtQBHjgOrufjHUgGlBYVSed1tOE/PJ/MYOFNRSOsonPE00XZm9IebyfFOXh/30CTNBqvFoMcOZ87wFyloul6vnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550658; c=relaxed/simple;
	bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdNXWjVHWX6BLrVXG2k6tDpZqVRViXsfTWjCo6NfkfIzfUaau0yY+5RFGLnu2Wc6x9GLsU4sWaM+Rmpj3H9KXpSYIreCbw8TLvILdZcn3oi2O6i3WAmxuttQ0k9O7gdAzgKmMDmth41YLxgixrwxv5kly2rcnj9LDwd15iXnvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=CD/Z8BK7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e44c9a62b6so1817698a34.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 13:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550656; x=1709155456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
        b=CD/Z8BK7Rp9L3i5Vl3s2KolMt7yZM3Q7SV1NrREyMTfzFMVwamp0srcydy69ptyQJn
         QXSSqU31Y95owRZ167SQF3FdA3AuKMFckDCDMgq52UyBL2DglRABg7BatfCiiEhFvdrs
         50eRs7e0ctmnkZhCHUQIzE22K+8+RjFGVMUOfer6IBBrxibv9FJqB8lZLekkBAUHlrcK
         fK7XYKOrVx125m1pLAnDgz7S9JgR3h0CmVz/xvIlHXzYcZZ/DjgPKtk+CPQ9SH3PAId+
         nvooirTukSELTOSVm+fMpwLm+WfP74t0mos9xXu9O7qBhtlU34sLNfg9keaEfyE0eDHQ
         a3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550656; x=1709155456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZXkUcelidv55pcogEZ5q8CQsV5tGZzpTAAvQxpkWOQ=;
        b=BkXPPJ0FD9y/WU0RPlAJYbfB2LgCNwUNsOXLO8P/K8pyRV4+w14NychOWQCjPyzRr/
         tDT3bfBSU2adG7IBkOy0lOVxU9cwuxh84cq7l6pFRTQjOYq1AT19LnrlpPt6xYQVdHg9
         jGLZSSXZ42nSG6ISPu0S60mu+NXqRfC2d2v1lCqnPhnzJ/ndccQ+RzzDAQfD4pGpcelR
         5v9L0MVgXhwj2qQ/TWD6322y0Y4xEVQ/BCDdHAj5+tdBOWESgiPmVNWHW+7qzRh+iYev
         GukUCwGR8IKTP7/AavboinJSv9kg88XVisnuG3T3bfwY340/zpNWdQkCTJgIwhAtzmMN
         YMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1u+mtu8UgMnorPpnMVct9IQKZ6XWMAdX3pJactktD7TtjOO10peW/AJm6aFKIus8KufQY20LvF7EjPxeCdSYn5igZZV5o8FbKQw==
X-Gm-Message-State: AOJu0YxQGWckqZf3Z0eEmupveHb0lQ6eCwSo8v8vUMdd0ztzUWqeWZ0+
	2jN95/dpMajeP4KrRmK/dmsywuupRJXK7D1d0+sRJAjlTYzR2xdX+MSc2o1C1dj8jHoarACNBZv
	C/UvL4t+hG2eNv+NFrXvXOOVznjfvLMgSUEiKtg==
X-Google-Smtp-Source: AGHT+IFvWKjWPK3amI8VL9W53BBk35ttzb77PzRBdxcUJJDHyxRlktLp+XaDhvA82AT8l0qmpbPOUDFRSVqjGiC7KOY=
X-Received: by 2002:a05:6830:1005:b0:6e2:eba0:ec4d with SMTP id
 a5-20020a056830100500b006e2eba0ec4dmr18796951otp.33.1708550655819; Wed, 21
 Feb 2024 13:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-6-surenb@google.com>
In-Reply-To: <20240221194052.927623-6-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:23:39 -0500
Message-ID: <CA+CK2bAAzRfsDYG+LVvp9LAJLpJoakhTAB3i6JiGDogvz8kfHg@mail.gmail.com>
Subject: Re: [PATCH v4 05/36] fs: Convert alloc_inode_sb() to a macro
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
	cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> We're introducing alloc tagging, which tracks memory allocations by
> callsite. Converting alloc_inode_sb() to a macro means allocations will
> be tracked by its caller, which is a bit more useful.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

