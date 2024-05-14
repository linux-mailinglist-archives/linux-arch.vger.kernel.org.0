Return-Path: <linux-arch+bounces-4394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C128C51D6
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 13:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394A8282955
	for <lists+linux-arch@lfdr.de>; Tue, 14 May 2024 11:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996A06EB67;
	Tue, 14 May 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcynIji5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF02B9AD;
	Tue, 14 May 2024 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685090; cv=none; b=bu8at+9LwatWLM2Ov8PgJL87luyxJyRZv5cDhizT0oEXKtXbUA0Ur8GlZTfwT0c4fCiCoJLXzmwf52eUy6EcaErXeuadzFn6PHlmaxvR6K7iN3Cc6K4yFNltwTZ5gEftKrjyPDHLLqqDWwKUNNAWzy42kyRdl4jY4RIwxRq7rU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685090; c=relaxed/simple;
	bh=KVxauejPvzJyYfFFOTtFe4fgmJL7fCO6DpO6baFN0Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMsmsqzeny5clH+4KNkAEf+tzEhGnTEGBhAlrpnPJ8ds5BsWNgE0/Vd8iUor8YLR4PQTWyYXoMZu+qeztSBiEdeeNQAGfJo67TNqZgIeUVw21+di7MNOh5QQptKkuNjrKFJEnwZ3us56NFwVbVyiRLXpxNOhogkoSmrVxccPx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcynIji5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a934ad50so5943566b.1;
        Tue, 14 May 2024 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715685087; x=1716289887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMZS59XPLiwO3KU38pBXDe0DPh6/r3MnqwWDc7YDc7k=;
        b=QcynIji5UB9REepE497ALPH8ZE5QqdS3/0YECmfuZZ4lR308exRGSDC96yW7W2enQX
         a7GjDQEmgmsn02SbR9HGkqLHKIook1+ntZcEn2qeNVJIO9fkkLdN4d1oVz4EoioakKbu
         tVFmH5IU+vb8yVZIeVXAh71uie9UqQWtTNpN6bUakvvNfy25Lj1jekKRCpKvmp8L/Vyu
         uFd473PGM6Y+cA/732QtS4Urm2ds5/6x5Yrs4nBebHR7u5IyCKdmCgvgnkUTjSY8qXn/
         56u8l1Qb5bKrTj4Bm+XrPOVlRnRf2G5Y09mar5xE5UEWWa7u0c7vVf0Vl4T2ftigwV5k
         t/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715685087; x=1716289887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMZS59XPLiwO3KU38pBXDe0DPh6/r3MnqwWDc7YDc7k=;
        b=iZfTshXBpKWtAamHqvMJRV/sBfkVuzCJ/lcLmjdsu1umKa5fPpZDPkirirVPTV49VL
         XiltUTe44VH2yrsA3PgBSrjzKLlLnq7FPT92LsXqo6Ut+LCl/bFGGbAv5NJw2soVLweg
         /HvxodjLuz5vZZczAHlSeEImVmgNgJF1HlCpDnVdenHBiGF1IvhrlAlltWR0z9OeMv/Q
         ifDV/xJ9xjueML/g0ho5256ESNq3HOsreI0i4jkdS/d/D1RHNe0qRt6T0E/68nkgchaF
         wuMN6uts32Io/sMIk06RZvxYlfB1PhSIUwz0AyXvKZDrno4v+F52mMZfEuHbcEWVmdNd
         rX0w==
X-Forwarded-Encrypted: i=1; AJvYcCUL9Mt0khbf+eLIdZTpJqr5PYTclf5R7VlCuUnDeB2s2bex6jz8EYygroNzF6AxiyJZuOhYpuHZKuFZSzyx4FuN4JhP5eN6MQA+gKwDNcE/ZTn0bGPgS4cJGxq2HvyQnsbfJPsHAW1OOg==
X-Gm-Message-State: AOJu0YyZBaOidu+H1hXQ76bfLp6wjeElAN5lo0Cne0M5AvP6TW0XtJ0A
	Rf+Rn0M7eqlLv5lLGR8cOEzdr5m9BZ49Nf3ZrKNZ8A9c3IGZwCsr
X-Google-Smtp-Source: AGHT+IHGVdfiDH0W0ZEt67IjZyymiDzBJpktNaocdRBB84h8WvjuC+dAQjmnH+C4qaK7GsEnZSwP+Q==
X-Received: by 2002:a17:907:3609:b0:a5a:8849:2205 with SMTP id a640c23a62f3a-a5a884925ffmr87208566b.42.1715685086926;
        Tue, 14 May 2024 04:11:26 -0700 (PDT)
Received: from andrea (host-79-8-228-115.business.telecomitalia.it. [79.8.228.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a5c033afasm360911066b.156.2024.05.14.04.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 04:11:26 -0700 (PDT)
Date: Tue, 14 May 2024 13:11:22 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	puranjay12@gmail.com
Subject: Re: [PATCH] tools/memory-model: Add atomic_andnot() with its variants
Message-ID: <ZkNG2uZEiF1S6M7z@andrea>
References: <20240514094633.48067-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514094633.48067-1-puranjay@kernel.org>

> C andnot
> 
> {
> atomic_t u = ATOMIC_INIT(7);
> }
> 
> P0(atomic_t *u)
> {
> 
>         r0 = atomic_fetch_andnot(3, u);
>         r1 = READ_ONCE(*u);
> }
> 
> exists (0:r0=7 /\ 0:r1=4)

Fair enough for the changelog.  If/when submitting proper tests, please
check their format using klitmus7 (besides herd7); say,

  $ mkdir mymodule
  $ klitmus7 -o mymodule <.litmus file>
  $ cd mymodule ; make
  $ sudo sh run.sh

Documentation/litmus-tests/ provides some examples litmus tests.


> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Andrea Parri <parri.andrea@gmail.com>

  Andrea

