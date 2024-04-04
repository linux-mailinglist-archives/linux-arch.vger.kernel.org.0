Return-Path: <linux-arch+bounces-3433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B7897D66
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 03:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6DC283A53
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 01:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3714292;
	Thu,  4 Apr 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qb1JzlHC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532414285;
	Thu,  4 Apr 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712194455; cv=none; b=PH0a30A2BP3UeUxqqbbHn6XKGs9Qe9QcC294hECFJaFQP8RZKcBTL444TfQrhyC10vmyr/3LF+8zqKhV4vEz/k84hsM7vUdz1g3krF27/jlmqhr8Be0NQnfbSScHB3w7UsaytZz/NST6GoI7S9FFs/0PmQK7biFjaf7pgJi4jnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712194455; c=relaxed/simple;
	bh=PLHX9CmuF+jzJhTft7r/1Y8OPKACX4mI6u4er178G2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSymGw5ScfNgpXpy52rMtSiloUPRCHA5eJIHweEs9DSg5cnsmBOsotOjwrimS7dTw+pTckMMkFH6xLHT8fNTGh1lGtk8JmtHIhJtTdW+MtXHWGx5AhQe2TfBOTTO0ReN1f0FG4FIK/kgq+9KSTMR0r7e4kvlIZLBVeyDIHp3bqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qb1JzlHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94D4C433C7;
	Thu,  4 Apr 2024 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712194455;
	bh=PLHX9CmuF+jzJhTft7r/1Y8OPKACX4mI6u4er178G2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qb1JzlHCkOQ0xQR9xEkxKvsw8OA1eBs2sTlr4JQ5PzuUXWpA08puhxOS0+HGL5xJt
	 p+tSFhHdI0/W38jVkWUzbZ83SoA9Ze3oVX0I/xz35tzw9J8ehO4Ej2Z+v4WDgVFly6
	 bK1uHAbfHAa/MKwQyDRnXJvZKbn2ZQDjArtD+Ho/3cPayZMvc1juvsoNzlmJRr/Ju4
	 IiompHkE91W7nulKLmrSnjlpjrH1dYJE6//xltRqVI5kAJhGo2sMI29VSfrrA1CwJ3
	 2VTX8Ds9j7vLv82qYyQgrRRjYVgNl7GVkee7GY7YJqfjkE9sRb6rgoQPF1hbD/SIKA
	 JnLshHl50ZGTA==
Date: Wed, 3 Apr 2024 18:34:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook
 <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>, David Gow
 <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, Brendan
 Higgins <brendan.higgins@linux.dev>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, Ville
 =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Vetter
 <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
 netdev@vger.kernel.org, x86@kernel.org, Linux Kernel Functional Testing
 <lkft@linaro.org>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v3 06/15] net: kunit: Suppress lock warning noise at end
 of dev_addr_lists tests
Message-ID: <20240403183412.16254318@kernel.org>
In-Reply-To: <20240403131936.787234-7-linux@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
	<20240403131936.787234-7-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 06:19:27 -0700 Guenter Roeck wrote:
> dev_addr_lists_test generates lock warning noise at the end of tests
> if lock debugging is enabled. There are two sets of warnings.
> 
> WARNING: CPU: 0 PID: 689 at kernel/locking/mutex.c:923 __mutex_unlock_slowpath.constprop.0+0x13c/0x368
> DEBUG_LOCKS_WARN_ON(__owner_task(owner) != __get_current())
> 
> WARNING: kunit_try_catch/1336 still has locks held!
> 
> KUnit test cleanup is not guaranteed to run in the same thread as the test
> itself. For this test, this means that rtnl_lock() and rtnl_unlock() may
> be called from different threads. This triggers the warnings.
> Suppress the warnings because they are irrelevant for the test and just
> confusing and distracting.
> 
> The first warning can be suppressed by using START_SUPPRESSED_WARNING()
> and END_SUPPRESSED_WARNING() around the call to rtnl_unlock(). To suppress
> the second warning, it is necessary to set debug_locks_silent while the
> rtnl lock is held.

Is it okay if I move the locking into the tests, instead?
It's only 4 lines more and no magic required, seems to work fine.

