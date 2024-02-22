Return-Path: <linux-arch+bounces-2659-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4534E85EDA1
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 01:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A6F28482F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCF4881F;
	Thu, 22 Feb 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="V4v3q5zW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A7186A
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 00:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560550; cv=none; b=RXbp7Q1ainI3w9E5e1IyeWTprAska4nGyeSh7yKv2L9OW4nhl8lbuaXlbBGHEz9xsz94x13Bt57NFeOWklmQAJ/1wbva1kjBXL8XiaSvCq9cPjTJ4W4vkQW4LxxD0GjjSotZm59wATbbkUK8G0CnAGnonWAGRcZgfKhPKTlWRG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560550; c=relaxed/simple;
	bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEx7aiD864CqywevAYXtKgTc2jr/XXZ42P1XYqpiF1jiSLr67GDHsS2fvQTTintSmoDuUK2ZpWNj6V8vWVgqa59mqkhHHfKV+JD9Z8+X7GCMpRaIRWFWTLpz8GqElo3NWY/aUZDPd8l57fmg1E2L5wDSO4v1uEWgSp/olMNuwRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=V4v3q5zW; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so4629621241.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 16:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560547; x=1709165347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
        b=V4v3q5zWy6TRguaajZ4nQ7fJK1qziegRcyc2f4uuaXkZgb4nKEsRZW5usZn2/WC6UG
         2HWxXkyggg+HnHBE4LSYDAV3qlSVSEAJ7vgj3MpYcNlVANNi82gJyKs3TGO95H7vQQs3
         P+mjK3bnK/Tsa/y3lgPnoCSvSJbs2j87+GMbVDg3j9OYX0gZdOAxTTKJHTxjoXOw0Gwx
         0DKKNqPgam6bcmtKcoMyNXiATqMuN8yiT32970gwjqs7o9zipOX4DhXrYhTml3lKxizt
         +ishB81w04QpeSmjviwcPT5P0aChisMAKE13nexWROtuY9dinTAdSxKj6PHKgtTQO6OK
         fdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560547; x=1709165347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiZ2wjkXdUeF2DZJw2oBIl8u+9EyfQfZ9ycNkF8fAgk=;
        b=h4wPvXUHBZ89rONvFLzp38qJ3SnPS2UUw74a/g6rdixxmVTwJ2iAZa1uAW5m8n4djt
         ims8qjtmYLAKSRQtiMHyFb0NaykNeF/3TqXEwPNK+idutIyoFW4wwpzcnR3QRog+wzxR
         dTEgmB+S+8zEQ7foWuCwvXmTJJUUg0Lt35LA9bE+gwiefnteF01R1OD7gFg/46GlNAU1
         MmiU9sQmmf8fYsErwDVKVYv0Zn75T1kPk0VjVbz47KvkycqqOpmdY5nFe6rds7c0/Q9O
         oCWZnwHs4QJ79jYJ7gCWPL+6mD70c6gwp0w4TK08NpXX2Ka8Oi9pu026uP7FVrMb4Um6
         gjug==
X-Forwarded-Encrypted: i=1; AJvYcCWMyv0EAcKAiMv7/mE6zO4r+DQD5T+Z0XvZm3lpIMtFmaex/MYK2bGxJa/cMiimdNld9raZRjK5dNjqM083J3HhQR8JFPZkj+QzMg==
X-Gm-Message-State: AOJu0YwN86WkESjrkSrACLToJrq307iBRkNhSUFVUMtr/oAEOcZcIp5J
	ZzBOUZn+5n0HTp0fVF5wFL4EkjfxSnVX5Z3HCXuKQO1wmCEUFN03RoBN+JmLKeL2oUb4zm44zyw
	bQnsfsSYi4hlxunz55Rqmq7aY3Sjue84z0g3CYw==
X-Google-Smtp-Source: AGHT+IE8YdNcoy9yHPyWH3FSVi3grCuLLJ8fT8RNUBKoMQxE9UzcTUruywG2qiU3pKHX1/up6wOF6uOUyIuOPTAbvgM=
X-Received: by 2002:a05:6102:953:b0:470:605a:6a4 with SMTP id
 a19-20020a056102095300b00470605a06a4mr10156813vsi.21.1708560547208; Wed, 21
 Feb 2024 16:09:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-9-surenb@google.com>
In-Reply-To: <20240221194052.927623-9-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:08:30 -0500
Message-ID: <CA+CK2bD-AvHR45zWrLOGA7Y=HQeFf=Ty4vCB5bWxbX7XyMsYRw@mail.gmail.com>
Subject: Re: [PATCH v4 08/36] mm: introduce __GFP_NO_OBJ_EXT flag to
 selectively prevent slabobj_ext creation
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
> Introduce __GFP_NO_OBJ_EXT flag in order to prevent recursive allocations
> when allocating slabobj_ext on a slab.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

