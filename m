Return-Path: <linux-arch+bounces-3483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7973089C9AB
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 18:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0091F26742
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39751448D2;
	Mon,  8 Apr 2024 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTU+IVz7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C5C1442F3;
	Mon,  8 Apr 2024 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594075; cv=none; b=dErg0lcdWQ7cDOhzAC12FDmUSSJqWTrdpe6mz8h9q/DYgFQnjbLZA2BGGTtj/yUKBmwab02Uc8gSuPr8YeNljgRO2LOUJa3Ki+cBZZ5sBNlm8yQs5vGToO+LjOfEqPpphCnMelDnYYMyPzV76k47v3WIfjOJ1m9Zhvg896SBtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594075; c=relaxed/simple;
	bh=GDjg6EBXUVwAARwkkfl8HCARLRaI322ITo8J7xf4XpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgVbKgNqFb+5c5UnJ81yzx0OzQeZ5UcVuGtgFu2a9rE7AIO68vhhZFMsA0kDkBrTSfxHwGzT6DXpiT6DPeQ4UqBSETJ3X4F2ho2K29L6PgQVVoZtr40Kjynlr4CWRokeHzjKyO8gLerfBtYDvWALuBjcTqiHfhZLo9X6S0iWNtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTU+IVz7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2a7b5ef7bso38330425ad.1;
        Mon, 08 Apr 2024 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712594073; x=1713198873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8W6JiQXMJlyRVh6G0P1/xRBUWDgR2AudHru0aHPOuY=;
        b=QTU+IVz7TvT4wffdmtolLM28ZZb8ERtTjT/kTEDBsVVH2aoQZ9eWX3OSkfDLON+mGP
         /Lrn9e42beiGPwNv+84wjKjHyd5NIzeLw1buAo+hW8BBYpQe5QxKQM8dnxtE/kl97i5K
         CY7hJgkjCZwN2ZeA4zyiraBAuwTg/sBSf7swHSmIWj4BASDX0op1Uz8gOCFBEqeklzc4
         6eJ1JqUYGwVmHMIMM+YA6wjdCABihemlv5VV6PTZkTqU798GI0PnA+74OFO/HJPzpjdT
         ECmZ5qWTbxDqj6lxmfcNQ/ubQY0WVxl6EkpMTnHSnYHPdC4Pik2wo24m76VmzfOW6CB0
         1r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712594073; x=1713198873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8W6JiQXMJlyRVh6G0P1/xRBUWDgR2AudHru0aHPOuY=;
        b=XZsIVtTfROBGgTF8bkH7xuslGiQveQFFpW+MkELO0Q1KRbiTqkoq2S4Sl7ZdZmoHdt
         hv24XE6DTwzylS9buL7r/dFpiTfMv+Wd243pM0YXdmyiBmvuH74hXaB+B2EY5TpoNBiv
         8XgQyphGQIVPhnrvT4TSQAeTSHkoD+zz0hHUwZ96Exq2MMLogo/pH+F2yEwc5UsQXosU
         qBuEkkLmPZlYxn0NHfkiivkP2K5eOs8uEpSPKw1dGReWRzL4VNBKStBNubUJpAyQrkA+
         npnsNMy3ZDHRjHx0BstNkrvgMPTGQUYMuGDgxVomclN/gd/fb6PS39TNtZEXyPr+WMZ/
         oFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnetRmlnnE+4xixXAqICi8M0WxLstu4JIkfqweDjTDz1AeRzgRh7W5sA//BnBU+ty4CaIxLeg0ftA+DK7Tjtxn0GE9AGmWbQAl/27XWFbjRNGAigeYDCC3Jhthv6q09AdIfmKx6mLdCsd3xYqeb4sST7fWg3FJKwVJzC9fe8GBBvU8zm1H8669dfQYJHqiyG3jsjVqhsH1qIV44h4JagHdy5JUe6WangRv73lX53880zGhtP4FLdKm/1rkwHT+zkbsPYDH9Dua2GvcSTiyqNf3bJ1r3XkqTjT4QCovQ5seOxpMD53H1NuMdDhEwWOonw==
X-Gm-Message-State: AOJu0Yyz+0MsWPjyUrus+EYJJKcHeisIGo3v82FzoD6e3BWYJ0kzVg4t
	yl6iu1in7rdMr8aLYmTQAPmmOENonDswAlFItDpZieG8kh7MU/A5
X-Google-Smtp-Source: AGHT+IHjgwPwZy3e5AEopzEIQpEcmD2hcpsHcoA+sLwIBYMIqqkK3bLGAgIh/jDVDgJdWRaZ9xWs0g==
X-Received: by 2002:a17:902:cec7:b0:1e3:f911:22b2 with SMTP id d7-20020a170902cec700b001e3f91122b2mr6050960plg.7.1712594073047;
        Mon, 08 Apr 2024 09:34:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b001e2b36d0c8esm7189331plf.7.2024.04.08.09.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:34:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Apr 2024 09:34:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
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
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 06/15] net: kunit: Suppress lock warning noise at end
 of dev_addr_lists tests
Message-ID: <9e8718bf-da81-463b-9436-6c8b0881a045@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
 <20240403131936.787234-7-linux@roeck-us.net>
 <20240403183412.16254318@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403183412.16254318@kernel.org>

On Wed, Apr 03, 2024 at 06:34:12PM -0700, Jakub Kicinski wrote:
> On Wed,  3 Apr 2024 06:19:27 -0700 Guenter Roeck wrote:
> > dev_addr_lists_test generates lock warning noise at the end of tests
> > if lock debugging is enabled. There are two sets of warnings.
> > 
> > WARNING: CPU: 0 PID: 689 at kernel/locking/mutex.c:923 __mutex_unlock_slowpath.constprop.0+0x13c/0x368
> > DEBUG_LOCKS_WARN_ON(__owner_task(owner) != __get_current())
> > 
> > WARNING: kunit_try_catch/1336 still has locks held!
> > 
> > KUnit test cleanup is not guaranteed to run in the same thread as the test
> > itself. For this test, this means that rtnl_lock() and rtnl_unlock() may
> > be called from different threads. This triggers the warnings.
> > Suppress the warnings because they are irrelevant for the test and just
> > confusing and distracting.
> > 
> > The first warning can be suppressed by using START_SUPPRESSED_WARNING()
> > and END_SUPPRESSED_WARNING() around the call to rtnl_unlock(). To suppress
> > the second warning, it is necessary to set debug_locks_silent while the
> > rtnl lock is held.
> 
> Is it okay if I move the locking into the tests, instead?
> It's only 4 lines more and no magic required, seems to work fine.

I don't think it is that simple. Unit tests run in a kernel thread
and exit immediately if a test fails. While the unit test code _looks_
sequential, that isn't really the case. Every instance of KUNIT_ASSERT_x
or KUNIT_FAIL() results in immediate kernel thread termination. If
that happens, any rtnl_unlock() in the failed function would not be
executed. I am not aware of an equivalent of atexit() for kernel threads
which would fix the problem. My understanding is that the kunit system
doesn't support an equivalent either, but at least sometimes executes
the exit function in a different thread context.

Guenter

