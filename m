Return-Path: <linux-arch+bounces-4704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40D38FC529
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 09:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8D92815F0
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jun 2024 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4CD18F2E7;
	Wed,  5 Jun 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3GSuJjCW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC218F2C7
	for <linux-arch@vger.kernel.org>; Wed,  5 Jun 2024 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574000; cv=none; b=MBQzwrg1DJfSlQdIGLVYGxEk4mkbZnVlUv+vxfqbU0VA2CO6mx00nPQODkLSbNd7/vQYaypiqg2kGN18a3LpYl+ClO7idkWd6POFJZuFPyBb/PxfuNLeYGeoW+04tlp+An3G5XGvfdEKlOqtZ8etFOjZ6puLEuldHFyl+SM52mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574000; c=relaxed/simple;
	bh=rc0+EnOjjlcqrlZBSxhgDHouHLknnPbYCYKcXR2MDhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyK9wwc+RZsbFgZICO9ez2BqV2JOOarPGRAd3bm2dPeF3SDMQ6ej5a/JXc/q27iBn5YeKfBR5pp4cCiSTO67TGhc+kEv9w4yGKoy25qgBmWk5gczRF1cVI6xv02+eUdEhVABMJiSSIwA+brEKwoTQVyiViohlNkYldmoMph8vAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3GSuJjCW; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4eaf67ad82dso1974649e0c.1
        for <linux-arch@vger.kernel.org>; Wed, 05 Jun 2024 00:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717573997; x=1718178797; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dH9aFv02Wu6clD2z8MVw+PuL/jNAUoVwhNcfaDFd6Rg=;
        b=3GSuJjCWZAdDUAsWB3hZtLo9nCNjkW6uFnNSOnyPUik3YrmS14a19V7FO2VNL7yqap
         l54Q1NvpVLy7q/O8+7wcAPJf+vbq+PD5PxXgthWi/LJkMGcWQEhBvFmLeQeVWJjNRzZC
         d1EaHRFYlcRHpExtwIraEm+73jl5V46QAvZ5fPmKdZQqaGRJKlA/qJUArUuH4CmWhEDZ
         lf6cfjiN9/kKPzllFeWjWedRaFxGj2ZfkkYpyPkdiZ5XmBcYS8qB+/nILH8yqZOFA8Ho
         tnIooks/9yujF0UzULihCnEanle8HowmkD/zcKS5CMZPenkcYDy0z7ZyfFWgNRruMdAl
         x+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573997; x=1718178797;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dH9aFv02Wu6clD2z8MVw+PuL/jNAUoVwhNcfaDFd6Rg=;
        b=UVCoU2SO68ErC37HoHdDbfRpAaS/H1KJI8OUfh6pNcMaSrhENlPmi3B95H2gqvLyKv
         B//dx0y1wDIPkDigik60ANkBB5X+6DZ5TOLGdCaaxZKlv7LrSqB0dxsMI+/HQRBJy8tp
         b29yw7/sAzM1BDq01n7Ex/VPoOrOmbJ55O9AYwWoI6f8LLLWZ3DJMNe2qlIQbsVLC2HE
         B2g+FRU1F54zkqb2Ck9a6cSBfmAwUDBuwVdMX/w55Rk6UYx6XYNOS9GO5j8m/6NSEi+N
         6qGd0Pjre4c4t8MbmYkR2ZlnKDADJ0lVYeb6o93fTettDFhMyBoaDmukMwfwYDOwnewZ
         Ktpw==
X-Forwarded-Encrypted: i=1; AJvYcCW8tzoLfqF1x8XXuDsnf+53Y8KTpl4HpgF/FsC8R+yuLZS4IWRCTj8x1t9ItCjfWD0iuujCX24LE1gmh1CBfHzr+T76B5tUTUwZYQ==
X-Gm-Message-State: AOJu0YxHEqGqYthazJ31TC4kmUyJXeS+3Yblh/fSjPyiPWPE7uAkQ4gz
	6yX3ivzdlZ+f1czGA7UqEjNDdPbdaE6hFNnAFnJcBPXbxtG1wDgzVrXS++LK0MBT7sHLCjh5ARO
	HDGujji8ecDLYOUjLzSozlRMHEqC2lHhVEjx1
X-Google-Smtp-Source: AGHT+IHw4sctzHvhh3i0frOqnT98DxfC219+bnTQ3By91zpdxKyoqnBwKXVmxQ5sf0WjrwPk3YhmlepYfomplHKzrIY=
X-Received: by 2002:a05:6122:31a4:b0:4dc:b486:e4a5 with SMTP id
 71dfb90a1353d-4eb3a27fe04mr2565829e0c.0.1717573997139; Wed, 05 Jun 2024
 00:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b290acd5-074f-4e17-a8bf-b444e553d986@paulmck-laptop> <20240604221419.2370127-3-paulmck@kernel.org>
In-Reply-To: <20240604221419.2370127-3-paulmck@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 5 Jun 2024 09:52:38 +0200
Message-ID: <CANpmjNPPaqcHPowRSb=8u+rqykctRW_Mod5nO_0KTc68WdRLWw@mail.gmail.com>
Subject: Re: [PATCH memory-model 3/3] tools/memory-model: Add KCSAN LF
 mentorship session citation
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu, 
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, 
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, 
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 00:14, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Add a citation to Marco's LF mentorship session presentation entitled
> "The Kernel Concurrency Sanitizer"
>
> [ paulmck: Apply Marco Elver feedback. ]
>
> Reported-by: Marco Elver <elver@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Marco Elver <elver@google.com>

Thanks for adding.

> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: <linux-arch@vger.kernel.org>
> ---
>  tools/memory-model/Documentation/access-marking.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
> index 65778222183e3..f531b0837356b 100644
> --- a/tools/memory-model/Documentation/access-marking.txt
> +++ b/tools/memory-model/Documentation/access-marking.txt
> @@ -6,7 +6,8 @@ normal accesses to shared memory, that is "normal" as in accesses that do
>  not use read-modify-write atomic operations.  It also describes how to
>  document these accesses, both with comments and with special assertions
>  processed by the Kernel Concurrency Sanitizer (KCSAN).  This discussion
> -builds on an earlier LWN article [1].
> +builds on an earlier LWN article [1] and Linux Foundation mentorship
> +session [2].
>
>
>  ACCESS-MARKING OPTIONS
> @@ -31,7 +32,7 @@ example:
>         WRITE_ONCE(a, b + data_race(c + d) + READ_ONCE(e));
>
>  Neither plain C-language accesses nor data_race() (#1 and #2 above) place
> -any sort of constraint on the compiler's choice of optimizations [2].
> +any sort of constraint on the compiler's choice of optimizations [3].
>  In contrast, READ_ONCE() and WRITE_ONCE() (#3 and #4 above) restrict the
>  compiler's use of code-motion and common-subexpression optimizations.
>  Therefore, if a given access is involved in an intentional data race,
> @@ -594,5 +595,8 @@ REFERENCES
>  [1] "Concurrency bugs should fear the big bad data-race detector (part 2)"
>      https://lwn.net/Articles/816854/
>
> -[2] "Who's afraid of a big bad optimizing compiler?"
> +[2] "The Kernel Concurrency Sanitizer"
> +    https://www.linuxfoundation.org/webinars/the-kernel-concurrency-sanitizer
> +
> +[3] "Who's afraid of a big bad optimizing compiler?"
>      https://lwn.net/Articles/793253/
> --
> 2.40.1
>

