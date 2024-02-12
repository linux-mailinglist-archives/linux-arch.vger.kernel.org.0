Return-Path: <linux-arch+bounces-2246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32013852121
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 23:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58FF281056
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A484D5B4;
	Mon, 12 Feb 2024 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0pKnnLM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A571D4D5A3
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776060; cv=none; b=KzlnLZx3+iTLMM9OaricuUqRmE0dEMwxZntYzilhM0quu2mki7MpuzPmbKedeUZOfxhzzPS4sbv283bhVZiTR8NFfTLX4NrXgQ6howHYPAJEtu/AXknq+rdJuk97A680Hijqphp0GG+XIkqJhLv8KfJubsrJNUTZscyULUkIDy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776060; c=relaxed/simple;
	bh=16fk7xoE50+bBNfgxcCm+Ee3v/cfVODmJmytJVNx6ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwYh/O997xZOCvDnxNibsZYy2UGx4U1wYo/+ukWGm3eSE0Psp/l3Ea4CX49auEhMuHrh21eg+M6Ba1vwrp0O2k23Fw/WhOJuavf4kQCScJA/URYSUA5aQjYMLG2qFnbt+TQdRLSZTubkl0Xvw9yIIEIFB2W1NQxUXNUj9EP/pkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y0pKnnLM; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e12d0af927so2503276a34.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 14:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707776057; x=1708380857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZiXjxKnrMyz6iBNN8FZ/8Z5umOyXaSKjAB1K7uHil4=;
        b=Y0pKnnLMUuTV5nTgugxSZPcfBuGuQ2jKMG+tv/9HT2Q2WXIryA6UU0aQZrBAaBet73
         aAW/gQnbPsIsASOLqhCY2pkSOe7gWKbpo/zrQbqfFSAttIF3GLTrRAFCFT3o+qHgEpht
         XoDjQJqAfIiTfdkZc6LbecsTBWuRapkfu6KCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776057; x=1708380857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZiXjxKnrMyz6iBNN8FZ/8Z5umOyXaSKjAB1K7uHil4=;
        b=jgm4Wf9uAk1aBcrF1zDtrsv6Kxtp4o/sNWAqb3qwHOUNve1A5I7af0fB3YKdJXBDZ+
         tbLRMsYsS2glMQTaNfPBeHlQaaXyxt0U3DWEcl8as8KifNnt1wZU7JyoQIpazw8LEy2D
         U/SoI+pxTuRvXk80x4BRB22HKh/8lETA7dnJ1qJ6nvhWC0FRicSYu/VSfKgx+48U70+U
         zhxEoaN9QqB4COv4YEu+ZaKcGOv/+mPXcfznBeRTuQebRQl4b4l5gK73JR2mZmdV0nxb
         wlvzI1/n1b0ozamzSye/jX9xqFRSZXbQkEQnnK0UMJE3RALSNX9+O25K7XBoTLmheznt
         6VwA==
X-Forwarded-Encrypted: i=1; AJvYcCUdlM/aeHgQnmMkgFbwX8+TzgWaHWIdkX7tNguL571pHfH11UpjXiPtvXwgJH+4rKj8G3i4Xpj8Q0ZsoVwF2QYVGaXrHf8/UOxX+Q==
X-Gm-Message-State: AOJu0Yxhsd91h0D8wHn4S7D33Zsgtt90ZDt6Zcx5pZIasSPQrtHyIkeq
	8kj2hWidoDBjFwVxxS/ZTt0HynNyUqBw53l+Mjh5KuJgK/grnkmreSSjUh2VHQ==
X-Google-Smtp-Source: AGHT+IFJECsPbCNbGliZWvIYHRL4c/uXXAZZuCyqsAn1ZVqvZdYBLBf67fObnnMqVDNeWoqRd4Gw6Q==
X-Received: by 2002:a05:6358:7e41:b0:17a:ec8c:72cd with SMTP id p1-20020a0563587e4100b0017aec8c72cdmr2085486rwm.16.1707776057707;
        Mon, 12 Feb 2024 14:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWg3dML8VKifNsHk2CVNShk758+NTmByKLZI72E1V2q4Wu9oUmJYkccV4vQiDGOQgADidt5TguGkvh7V4YwOg63GLUryvPiyAQ7f48JUGKHk5FmbcUkOWNBC3Ux7+ARsfis4drosOSrq4FcO2E/nb4nKPd5tTo1IpF7Z2ZQEg+WFRPMypAJ1e34DAT+XFI/el7dGRYPGKNGvKQ6aS8/NETGtgnEw4gK8U9U1Hv73eJqHAkKRRk3J8Ph4Ck//KLXOSNRvO+rAIzUOniypVv1/4JK6yXaykyMLrjMOY39G+2fpgxPBGFw3nZ/LH0KQIjw0EkWhY3rJoqcS/NUxqyJmBf0+SxOykkUoB0LcAsReO1NjiWu0KRnzfLjhQG17Mx1k6lSx7ZZighHq1IIEqMNKmrf+vg0gcVHjQdB9dMPLIKL8hpNfHfvE4J6f62rNrCDo8Bd7E53U+GZrPnL0LkHPW+og8Hr772ylPjBjfFLnALXxOiqaNCPEiXgFsI4tlEu7NYq0RiV8tZ22FLSM13tuC21ckHIWSqolHrrEG281jvnKKCQqMQuN+O/NTCkXba09zfBsvtBX8T2lqUmkKdD00zzZRvUtnr587FITudCjm3qCRbvrPscljCRS1dQo3iBQh8Zy18C+pJxaLHX0SyV1nKKQzyumJgyrZRPaWmuLpyLmJijRnh1cQeWSVGBxt1Wxl7ZPOvMuLO8rM6/m1ZJffXJtGOBjfOlZIyZ/d2SeZ/s9b2tmn7hjA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id le22-20020a056a004fd600b006e0a30c8c8dsm5334232pfb.117.2024.02.12.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:14:16 -0800 (PST)
Date: Mon, 12 Feb 2024 14:14:16 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 05/35] mm: introduce slabobj_ext to support slab
 object extensions
Message-ID: <202402121413.94791C74D5@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-6-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-6-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:51PM -0800, Suren Baghdasaryan wrote:
> Currently slab pages can store only vectors of obj_cgroup pointers in
> page->memcg_data. Introduce slabobj_ext structure to allow more data
> to be stored for each slab object. Wrap obj_cgroup into slabobj_ext
> to support current functionality while allowing to extend slabobj_ext
> in the future.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

It looks like this doesn't change which buckets GFP_KERNEL_ACCOUNT comes
out of, is that correct? I'd love it if we didn't have separate buckets
so GFP_KERNEL and GFP_KERNEL_ACCOUNT came from the same pools (so that
the randomized pools would cover GFP_KERNEL_ACCOUNT ...)

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

