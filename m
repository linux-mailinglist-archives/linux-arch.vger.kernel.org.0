Return-Path: <linux-arch+bounces-2273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C6A852779
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 03:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B15B1C232FD
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1864439;
	Tue, 13 Feb 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Jrb9xtg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05B62F2F
	for <linux-arch@vger.kernel.org>; Tue, 13 Feb 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790828; cv=none; b=R0ZVaiXvoG8ux2sDgD05OC4+/LwhX+VlwBUXr0VQuZC7pz6+chNpOfxzBjzMb3/mvf4EKZ3M2FLSO65qb1aaBnsQ0mv9wdYCjSNLmRpFyw93FCT3KdKVdkZeN7Co6DbtbwQ9Z6IegdxLKfb9zxPPaTPPBDkWisacj8OgXSQdUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790828; c=relaxed/simple;
	bh=S9sbRuvYiarABejv+1FZRtHjtyC1exllh7yCDkk639Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbqOT6CuUy6KdX5J/p80Lul4CLLLwq0vNF06NGRcQo59hMNgMvzGViFUE+tf0aBIDsUFtHFJyRHAvqWoUuds5Vh/0WujeY310PEioilMKFkO8xn4O1PzTpslZPlcBI/YH1v1SQqxXaJuRAAGptZSWVXsvivBbvx6cI+iqsgMmAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Jrb9xtg; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3416151276.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 18:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707790825; x=1708395625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9sbRuvYiarABejv+1FZRtHjtyC1exllh7yCDkk639Q=;
        b=4Jrb9xtgZZd68Cd8qtWKkms3W8lyscetML+GV9VkniajxjX00oCm8vO3er0J1tOJYG
         KXV6U73T7/ahxivChBXpV+Epa+r+05A2t154aRf14aPl3XbChON6p22PKWX4U7vAzS9o
         brwAToX8177IfGEf9W+XIqe1YPvjrVvfL9p54qZ1sWP3PGzpzREqC3UGYZKQKBZySG2k
         Ww0YUiGkRHSadsneVBJVnVGSj/Fif1gMg/8vv70xOYtj2wcjiPng2kr+bKGBZYgVzATG
         OKxyy6fQiAVrWs5pOrlgKVY84DYPBwXY7IoUnb6KCj+HNchnZ6OPi4x27n09k46FAdxz
         ByRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707790825; x=1708395625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9sbRuvYiarABejv+1FZRtHjtyC1exllh7yCDkk639Q=;
        b=rQohuxcefaUlbSNpSSzhttz69675Uc/O05q0/7DCgVjk/MCmkhka8FeMXBJc7g3+ew
         xE5msF1kxG6mtdxHJMQfP9beAIB98jUydohbmhzaFi+VC6cRwsRkCBiuiwjuifzpGoej
         L2AxwalN+yBVU4+QGcyIHHXfGvB0Zau870+NI1AjwVfRC8bO7LkL/qGEEdSXCvJUWbDc
         SgwAUtfYk/WVGwtAlPCVs6c9NHUVKU/Ywa9yLkZFOMNLhZK+VRQ0tfquPzDkF75yEygG
         LIyiHpnFDgnF/peqHFsEfHlg0tMu69Exqij8nhYUC61IKTyTM8pXB2IMXGqneYOoh+Rz
         +7Sg==
X-Gm-Message-State: AOJu0YwmcAWOZkZnG2BQgkrPyNiiEVTYkaH0ukvknIqx9k78QDaz7PfW
	kIlrnwvPwJ7/Gs4/nsoPKn2LEym+AxOa/maIB+AMzZ5u8zJWzZleeu2bBoGx76kxoghR+N9ZUlJ
	mZ92Xv84jhCa/BOJAbhx2XKb3WTBTpLRJCLLz
X-Google-Smtp-Source: AGHT+IF7VIKyAprzsQj97Z263Qoier3okujGUFo7m34RyS9jjnxf5dSV3vlCD/UI6jUXKLUqELRXLl2excxB7HnDSlw=
X-Received: by 2002:a25:df91:0:b0:dc6:de93:7929 with SMTP id
 w139-20020a25df91000000b00dc6de937929mr863370ybg.26.1707790825358; Mon, 12
 Feb 2024 18:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-6-surenb@google.com>
 <202402121413.94791C74D5@keescook>
In-Reply-To: <202402121413.94791C74D5@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Feb 2024 18:20:13 -0800
Message-ID: <CAJuCfpGkdAy58nR02_PSVXc4=R3faRUL-7Hack3R_aWmAgk5HA@mail.gmail.com>
Subject: Re: [PATCH v3 05/35] mm: introduce slabobj_ext to support slab object extensions
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

On Mon, Feb 12, 2024 at 2:14=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, Feb 12, 2024 at 01:38:51PM -0800, Suren Baghdasaryan wrote:
> > Currently slab pages can store only vectors of obj_cgroup pointers in
> > page->memcg_data. Introduce slabobj_ext structure to allow more data
> > to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> > to support current functionality while allowing to extend slabobj_ext
> > in the future.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> It looks like this doesn't change which buckets GFP_KERNEL_ACCOUNT comes
> out of, is that correct? I'd love it if we didn't have separate buckets
> so GFP_KERNEL and GFP_KERNEL_ACCOUNT came from the same pools (so that
> the randomized pools would cover GFP_KERNEL_ACCOUNT ...)

This should not affect KMEM accounting in any way. We are simply
changing the vector of obj_cgroup objects to hold complex objects
which can contain more fields in addition to the original obj_cgroup
(in our case it's the codetag reference).
Unless I misunderstood your question?

>
> Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

