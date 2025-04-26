Return-Path: <linux-arch+bounces-11583-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88BAA9D73F
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 04:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1611BC4E45
	for <lists+linux-arch@lfdr.de>; Sat, 26 Apr 2025 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32231EE021;
	Sat, 26 Apr 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NV3HH5cT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D31E834D;
	Sat, 26 Apr 2025 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745634771; cv=none; b=fs4VH7kMmRna2oWrUGntihuvxHH0D8Yjb6zviOFuxRpCrqyhixi0qSwIbZVUHWFycbQT1iNTtSqpENnvxOOo2uBo7MbZVqGPmA8tjDOV6FOpYI7uhX9eqg97w9JQyIe/yOPtFTY9Htw3vkq9jrxuZcUDVeXtyUqmqG2hdqwMgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745634771; c=relaxed/simple;
	bh=+RUTWIt3VFeUueyp+/LHBU7OQa1nslQTo03DjgGapQA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KZvxPmMh8fPvildNUB50dIGBJOh8LKZJLnVSTVKpTdJ4cOpiDP+pD103TAmRuZBcFzw4AwWYju6Crsa6XeJC5itsK89tIFjfPRodca2poR43PFjNS65orNctStefg8eziXAakNIwZIX5yO3R5uabW7cEg7AvuLah223sBHxSBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NV3HH5cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B430EC4CEE4;
	Sat, 26 Apr 2025 02:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1745634770;
	bh=+RUTWIt3VFeUueyp+/LHBU7OQa1nslQTo03DjgGapQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NV3HH5cTytNLqUSnhZu/e/1hOQv76j3RXu91ccBhnAZKPShm2ywlHlwxEmP2NFyJ8
	 9mJGv0SrHBCtXVkieOdFVL+aj36B86SkAmVo+3g7zY7zwp1CWMsmr/ZbWtOT8bEZyr
	 8NA5f5WhQqLgsoDwMQL/xkJ+DI4oOl2RlkHukU3w=
Date: Fri, 25 Apr 2025 19:32:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, Arnd
 Bergmann <arnd@arndb.de>, =?ISO-8859-1?Q?Ma=EDra?= Canal
 <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook
 <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>, David Gow
 <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, Brendan
 Higgins <brendan.higgins@linux.dev>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Daniel
 Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, Guenter
 Roeck <linux@roeck-us.net>, Alessandro Carminati
 <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>,
 dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, loongarch@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
Message-Id: <20250425193249.78b45d2589575c15f483c3d8@linux-foundation.org>
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 11:43:15 +0000 Alessandro Carminati <acarmina@redhat.com> wrote:

> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.

I've had this series in mm.git's mm-new branch for a while.  I didn't
send it up for 6.15-rc1 due to what I believe to be unresolved review
issues.

I'll drop this v4 series.  Please resend if/when suitable.

Some notes I have taken are:

https://lkml.kernel.org/r/202504190918.JLNuRGVb-lkp@intel.com
https://lkml.kernel.org/r/20250402074550.GQ5880@noisy.programming.kicks-ass.net
#arm64-add-support-for-suppressing-warning-backtraces.patch: check review

Some fixes I had merged which presumably should be carried forward are
https://lore.kernel.org/all/20250330212934.3F898C4CEDD@smtp.kernel.org/T/
https://lkml.kernel.org/r/20250330212739.85827C4CEDD@smtp.kernel.org

Thanks.

