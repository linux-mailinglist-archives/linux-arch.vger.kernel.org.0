Return-Path: <linux-arch+bounces-11218-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91A8A788FE
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 09:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC77C1886ED5
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 07:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729423370E;
	Wed,  2 Apr 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UbgPGhXY"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE472233152;
	Wed,  2 Apr 2025 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579765; cv=none; b=k1NxpZvlVmEGJT3FH9Zj658vXLCxe7ENMQ3gZX/6tcH81vMHFGFjn7FvgLmBBg4IzuIj52S7lDy6I0DIe+X6R3qy+dSxpjH8vQygDzEymElyKYztvdMm4WWHj9JryJ6Q1A+MjRqNay/tORJNB1fTOUfWAIX4Bz2Mvt09XiqCe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579765; c=relaxed/simple;
	bh=cwAu0TWkyiB0nK/W2YP6Fcl7ajWNrQiJK7yNUIwH54U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR7QMT4tDYinIwFqMwuGq6t1tChcSA/2zwHK/qRKuKOZPCRKGX63kwRgfKEEkMO8RRwV45CFdjChtfVb8wJpu2Foq783+Wgp8EkUAAktr1ep+AoWEgPmuNJtRx2b7HUhGTgz1pUfxJwJkQmzKqVR4k+VV/XwueArexvXLegCDlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UbgPGhXY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uwSUjXhnpPVALtfn6H/0Ef+Hu/5PlKbVNs0zSo5MJgI=; b=UbgPGhXYcAW7Ecq25uYBAa81JB
	YejYfLTgWYPRfCDH2TETkjUUcMvwoBl851u/SlwbYNyM+yFIyh1vaxj3MsprEfF1FK26n5zhpDDHd
	0RYGNmo+SUBtmS4ReHBp3tzeFKK0va69/75S9gYtFYaalaORY5Hw/o8guEL/XrRBXYj8AEbukW2Md
	LGryWJxcZ1Mzcn3518Ul0AimhzGe/TBpi+hQ2z98XSyzcgUfOVyd2mTc3oBmaQQd81PMoT1r62W1T
	CuUM7rCOZBxmcgETDmqQzITfoRPWmm3VOCvo6KMNAoKgoYfkVSHQQuqvcIPvXatsDpO3fjOfsgBNA
	eJdGDGWg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzsjs-00000006zGs-2jZ9;
	Wed, 02 Apr 2025 07:42:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C032230049D; Wed,  2 Apr 2025 09:42:19 +0200 (CEST)
Date: Wed, 2 Apr 2025 09:42:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 06/14] x86: Add support for suppressing warning
 backtraces
Message-ID: <20250402074219.GP5880@noisy.programming.kicks-ass.net>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <20250313114329.284104-7-acarmina@redhat.com>
 <20250401170829.GO5880@noisy.programming.kicks-ass.net>
 <ddc7939f-fb98-43af-aed1-0bc0594ecc41@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc7939f-fb98-43af-aed1-0bc0594ecc41@roeck-us.net>

On Tue, Apr 01, 2025 at 10:53:46AM -0700, Guenter Roeck wrote:

> > > @@ -92,7 +102,8 @@ do {								\
> > >   do {								\
> > >   	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
> > >   	instrumentation_begin();				\
> > > -	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
> > > +	if (!KUNIT_IS_SUPPRESSED_WARNING(__func__))			\
> > > +		_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
> > >   	instrumentation_end();					\
> > >   } while (0)
> > 
> > NAK, this grows the BUG site for now appreciable reason.
> 
> Only if CONFIG_KUNIT_SUPPRESS_BACKTRACE is enabled. Why does that warrant a NACK ?

And isn't that something distros will want enabled? All I'm seeing is
bloating every single UD2 site, and no real justification. As Josh said,
this should be done on the other side of the trap if at all.

