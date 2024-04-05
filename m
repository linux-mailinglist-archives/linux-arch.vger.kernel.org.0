Return-Path: <linux-arch+bounces-3461-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBAC899A2A
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 12:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897EBB2135A
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 10:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3556161332;
	Fri,  5 Apr 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGZzqsqC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970F27447;
	Fri,  5 Apr 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311521; cv=none; b=HSPiC6D000hitAH+kLRdA/titRX5PVg+AMCzW2HDph7VMYwF1MNbIWU6r2Fv60+x+PRimm0zBQL1z2S/dTDKgcbQkb9qWxoN4W/N53pkYESVngYw7uy9MRVCZaTepy3JWVTd3PwgvO/3WP+z8RkwPSEQsgBabb67W1SLG4RXwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311521; c=relaxed/simple;
	bh=7kM1F19yoDOcUM2VHaBFp2c+soyX1IiwreAYmFx4a+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmfnQMP5B+7IySTDet8N7EDNMzESVclg6Zx5WDFUbzUqRj9P9huJY4w97OD2RW5/fhk857H/CIyKscwQavk9zWuoo4vhz7YI3gxiWxKbTZs6mVdd2V5k4YAJF8MDJwFguEc5lksBV9pZqFut+mnrxdIEXckrJE5tRipUOBoeBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGZzqsqC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41551500a7eso15673425e9.2;
        Fri, 05 Apr 2024 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712311518; x=1712916318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VnK8I425dCI37ex6fueoi4IBtnoCCvi/FqHwWJZqFc=;
        b=QGZzqsqCxu2dBhB7OPb9oJCfC2mXNgNvv91ZNtCLWEP9kcB6O5g/bSOim370Tiunq+
         Ue/1YXAQkrVuwm+v/udWZCaFG+u0nAKo8wVu5/fBCgzkOd98QfngW8vPjmzsYxrvS1yl
         w0FgVwGTxGWXC4jfdmTfNgf39fr7wJeh1Eev4IVPhKjGBF+fbi+XSDm/uNwwcM4bObqL
         ZZPAk/zaoszYU/+Suw57lwGPP/IhN2+qPtQ9qoisvVZlcW5TIjQimw4hYSlsTsoa00eI
         am5QVAyz5hjbdGIFnZfoQozEgHbAroonT4uizCPEcgGxCP97FSQAztJ9tGGUKne6DgCB
         Mh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712311518; x=1712916318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VnK8I425dCI37ex6fueoi4IBtnoCCvi/FqHwWJZqFc=;
        b=cuzPeMQWGBzbl2p9kWb3pJoUs3xoMztaVLIKJEcRKI5lu8nAN+1fp2kFrEwC/WY7Cg
         3drrhVE4Uxj7WAM38PioGIqCAIztwwzmcNtuQlWsuEADT10kufoZDvKjf5u0Ew6nGwhq
         msTLK3R0IJxX3py2BxGJ2pJm5nYjvV+wAOUnVIS6xTjZC6a1cPL9Ud59VgFrMdQ/Pkqy
         FiOwlT+G7/nLy/vxj6jDiPtHE3CLZzRJ0qyKDwiO2/MftHO5hNLKT8DXZl6sXHDN2a1c
         AQRnoY6zVPv0i1nBeO7kBYQim0j+uuBy7RtsE8hKH+p5He1kJ/e+CHJ3N3jV9Jzss+Y/
         mkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlBQvvpu2rj0GTNHqVaC7WtcvxpwZh22OKVpKoLBAR/rR9+u9b6+PldYWJgC1d33iMLD2q2FF0cSv2/EoU0DY6CXcOcmtXgyYW9rp+irmfaenZuNUV14xAd+goKZ7TmU4pY/QnXA==
X-Gm-Message-State: AOJu0YxRAZCK5EsfFJgSfsh3Db6eggvK/jEsJDiCY2o1tsoHsNBO63+n
	jPFIptxXp7BnXKPA8a2J8TIzadjYup/MprfgCaBbl6Jf/sI6+/M6
X-Google-Smtp-Source: AGHT+IHmwsqWFX78cI8qG9wG7iEN0QIO4wBuRjuQHpMWUf6mVAabIxXpRFZnZkvY3v0ce1Vc92K0/A==
X-Received: by 2002:a05:600c:4e4a:b0:415:63df:6513 with SMTP id e10-20020a05600c4e4a00b0041563df6513mr746663wmq.39.1712311517988;
        Fri, 05 Apr 2024 03:05:17 -0700 (PDT)
Received: from andrea ([31.189.25.240])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00416326cc353sm310063wmq.8.2024.04.05.03.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:05:17 -0700 (PDT)
Date: Fri, 5 Apr 2024 12:05:11 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kernel-team@meta.com, mingo@kernel.org, stern@rowland.harvard.edu,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com,
	Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH memory-model 2/3] Documentation/litmus-tests: Demonstrate
 unordered failing cmpxchg
Message-ID: <Zg/M141yzwnwPbCi@andrea>
References: <8550daf1-4bfd-4607-8325-bfb7c1e2d8c7@paulmck-laptop>
 <20240404192649.531112-2-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404192649.531112-2-paulmck@kernel.org>

>  DCL-broken.litmus
> -	Demonstrates that double-checked locking needs more than just
> -	the obvious lock acquisitions and releases.
> +    Demonstrates that double-checked locking needs more than just
> +    the obvious lock acquisitions and releases.
>  
>  DCL-fixed.litmus
> -	Demonstrates corrected double-checked locking that uses
> -	smp_store_release() and smp_load_acquire() in addition to the
> -	obvious lock acquisitions and releases.
> +    Demonstrates corrected double-checked locking that uses
> +    smp_store_release() and smp_load_acquire() in addition to the
> +    obvious lock acquisitions and releases.
>  
>  RM-broken.litmus
> -	Demonstrates problems with "roach motel" locking, where code is
> -	freely moved into lock-based critical sections.  This example also
> -	shows how to use the "filter" clause to discard executions that
> -	would be excluded by other code not modeled in the litmus test.
> -	Note also that this "roach motel" optimization is emulated by
> -	physically moving P1()'s two reads from x under the lock.
> +    Demonstrates problems with "roach motel" locking, where code is
> +    freely moved into lock-based critical sections.  This example also
> +    shows how to use the "filter" clause to discard executions that
> +    would be excluded by other code not modeled in the litmus test.
> +    Note also that this "roach motel" optimization is emulated by
> +    physically moving P1()'s two reads from x under the lock.
>  
> -	What is a roach motel?	This is from an old advertisement for
> -	a cockroach trap, much later featured in one of the "Men in
> -	Black" movies.	"The roaches check in.	They don't check out."
> +    What is a roach motel?  This is from an old advertisement for
> +    a cockroach trap, much later featured in one of the "Men in
> +    Black" movies.  "The roaches check in.  They don't check out."
>  
>  RM-fixed.litmus
> -	The counterpart to RM-broken.litmus, showing P0()'s two loads from
> -	x safely outside of the critical section.
> +    The counterpart to RM-broken.litmus, showing P0()'s two loads from
> +    x safely outside of the critical section.

AFAIU, the changes above belong to patch #1.  Looks like you realigned
the text, but forgot to integrate the changes in #1?


> +C cmpxchg-fail-ordered-1
> +
> +(*
> + * Result: Never
> + *
> + * Demonstrate that a failing cmpxchg() operation will act as a full
> + * barrier when followed by smp_mb__after_atomic().
> + *)
> +
> +{}
> +
> +P0(int *x, int *y, int *z)
> +{
> +	int r0;
> +	int r1;
> +
> +	WRITE_ONCE(*x, 1);
> +	r1 = cmpxchg(z, 1, 0);
> +	smp_mb__after_atomic();
> +	r0 = READ_ONCE(*y);
> +}
> +
> +P1(int *x, int *y, int *z)
> +{
> +	int r0;
> +
> +	WRITE_ONCE(*y, 1);
> +	r1 = cmpxchg(z, 1, 0);

P1's r1 is undeclared (so klitmus7 will complain).

The same observation holds for cmpxchg-fail-unordered-1.litmus.


> +	smp_mb__after_atomic();
> +	r0 = READ_ONCE(*x);
> +}
> +
> +locations[0:r1;1:r1]
> +exists (0:r0=0 /\ 1:r0=0)


> +C cmpxchg-fail-ordered-2
> +
> +(*
> + * Result: Never
> + *
> + * Demonstrate use of smp_mb__after_atomic() to make a failing cmpxchg
> + * operation have acquire ordering.
> + *)
> +
> +{}
> +
> +P0(int *x, int *y)
> +{
> +	int r0;
> +	int r1;
> +
> +	WRITE_ONCE(*x, 1);
> +	r1 = cmpxchg(y, 0, 1);
> +}
> +
> +P1(int *x, int *y)
> +{
> +	int r0;
> +
> +	r1 = cmpxchg(y, 0, 1);
> +	smp_mb__after_atomic();
> +	r2 = READ_ONCE(*x);

P1's r1 and r2 are undeclared.  P0's r0 and P1's r0 are unused.

Same for cmpxchg-fail-unordered-2.litmus.

  Andrea

