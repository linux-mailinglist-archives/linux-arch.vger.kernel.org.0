Return-Path: <linux-arch+bounces-2249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E985213E
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 23:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163521F21960
	for <lists+linux-arch@lfdr.de>; Mon, 12 Feb 2024 22:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C5C4EB35;
	Mon, 12 Feb 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lrtd80kQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C394D9FA
	for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776129; cv=none; b=qPzrcEeHykfVyQ7uNeRpMZxDZqYvBPMD8Pg6Q95k3HS7iW3c7gdcz8Pmp3i5oEfybuZoBTNfCIpbWVuqZzlvThp7Xvm/RJXj9BAd3WlcBRSl5Q7HK/H1UhL0adapuor6dE1oIJhdimURgaTii+cCN+iIzT16hkiLk1Jv25lu5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776129; c=relaxed/simple;
	bh=TpphJ90hO3BEQfdDdRqDvdw7C+9WN5haDjzrkAhJjPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6ezHW6NTvnqTyIglJl5HL1Kb+LL8S6Dn80XG5+tVkkURcag/Rtr7XfrgAGl+V81JAIzfIUsVn/Npx36h42F7E3FWc1N0zYidcvXIjQlYYjeiKkElWErQUXzyTNz9VXfCFZdHp3COC5t6BE9FIUnJ6di4sIUKV17GMDPh4PmNfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lrtd80kQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d94b222a3aso31196335ad.2
        for <linux-arch@vger.kernel.org>; Mon, 12 Feb 2024 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707776126; x=1708380926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGyor2jQd80o7izL2Q665nn1vzR3SBtHBIgEg9t9XJs=;
        b=lrtd80kQCt20MJK0hQoSDR5WAsK1yHe2y0E/9KuS/vqwSxdKfEkAkGrI6OuNtzNpGc
         rjf7VexrfQnRwSvAsxJRIW0uaTvDrPiHn3OaNYEqK6twPC19uG9/ntWWX3OrEg0xi1nh
         orLFoFBvpvSvNuu4DiDqg9ig5shD5vPSeIemQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776126; x=1708380926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGyor2jQd80o7izL2Q665nn1vzR3SBtHBIgEg9t9XJs=;
        b=AtjQ939Z4Uc2XsZ8VYPTcdgVEq25HGOqHZGop6PI8c6XfUJoSwTuX0PV1XtM3bh6rt
         l0oNwI3VBg4SKDHWo7f45gD0vHmH1/8Q3DXZBoSqiTSacL35XqTnYtDW/u4B8jZcOjwH
         +t0OSdP5Dv+ijJ5r35GGL/L6J2NMCe2+HpcbeuuhfCvnSSjihd9xdVvsSNe7dXqClpv2
         mdOMKZenKxnRpQNj41v1QIzM+bxBjl83oA+OzNh1hWZtRp81aRDmAUo84qUD3B2liBV7
         kqrvgUXfl8EnHDqZVjPlsb+Q9H/XX6pA1XRBqVh4hSgysC+CNem4s1VT/+Bs9Dfod8VJ
         7YTA==
X-Gm-Message-State: AOJu0Yyae0JorhpU4MqdH/EVyKffozZZr4W//1LTO1hRj9JbWZuaW5Sn
	4QVj5TuMV9l13m7MXs78Ivf0iSuInYoe5UO/wuedqZ0AX1GhCpsXpEE29eHB3A==
X-Google-Smtp-Source: AGHT+IHJ+eMFkw2LbAxe+h/oMXqSRof50VRb3yJeSh7LkAV4UN/gEpC37Gy4Bv1PGat7cqnAXmWBCw==
X-Received: by 2002:a17:902:e5cc:b0:1da:200f:de05 with SMTP id u12-20020a170902e5cc00b001da200fde05mr8415549plf.29.1707776126273;
        Mon, 12 Feb 2024 14:15:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKgO+hejNI7kEZ4YYJ9UHPdn730zo4WYg89e5PmiPyV1ma6e6+5HtAq0YPbTPfSDkVP6TeiMYAwq0HJ/FlU7M+0RgVtkFfT3pRb4HiJZEyE4Ki/2cTnd78QQ09ABwh7iA48yzo7Q1OHbIZMhemOYUjIkY6GxpI5fUe4jOTVZlOSpz9XjEmj6bNG3JdZzndqRj3tFSfVTr1kbrc/gFN/3i9C2LZpxGacAB6WiMEGe/fYjfXJrYjXkPviY5iwRBktHIUKj99/Ue9dfHWZ8SAdomMQo8258SsvKYz3FuZJCK1clovIr6KnyhkbSVYF9je+oNrukYLiBVKjtCNlJVQjL2QlZKg0I/w4Wb9qQAoi2O2uQ6she9hyLm3RekGc3CgRkm8+KEXXJRenxn8JVNghjx1Wbul+jWGDs5deoB9AZZSm7RUmAt3KMVKKonmKdiq1OnzOTCK0bwWl8NEtlPwWbEe8qiDkBxZC23glZcczJhMoO7BxnMFZWR0DRV7hZqipE4OysgkbKxNjbcq98gMRIIgv2xhAXW98X6S+UEqcEw/zR0IVRe9T02Gzm0fRVkaGrBGT87hlMuZabsd5eCZW4ad/5u1ksRZovPl7yqEaCLu7DOpPVeo75Bq0+HL+RDUhoQoML0LnjEhHS0KMw7iQaKNV7K2OTBHszwaf/XL24Bd1CbfMq0vlUm570sD6+ZXY4os6klv74r4JI7uhW9MQO4AccSm6clUUrm1s1uXnyZWZORXAx/5GA==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jx4-20020a170903138400b001d9df9a72b4sm817027plb.26.2024.02.12.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:15:25 -0800 (PST)
Date: Mon, 12 Feb 2024 14:15:24 -0800
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
Subject: Re: [PATCH v3 08/35] mm: prevent slabobj_ext allocations for
 slabobj_ext and kmem_cache objects
Message-ID: <202402121415.77843B9D39@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-9-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-9-surenb@google.com>

On Mon, Feb 12, 2024 at 01:38:54PM -0800, Suren Baghdasaryan wrote:
> Use __GFP_NO_OBJ_EXT to prevent recursions when allocating slabobj_ext
> objects. Also prevent slabobj_ext allocations for kmem_cache objects.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I almost feel like this can be collapsed into earlier patches, but
regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

