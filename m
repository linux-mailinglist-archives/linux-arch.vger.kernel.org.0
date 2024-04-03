Return-Path: <linux-arch+bounces-3399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E36897A89
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 23:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14702288BE9
	for <lists+linux-arch@lfdr.de>; Wed,  3 Apr 2024 21:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA5A156677;
	Wed,  3 Apr 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ptx5/DWJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9881156671
	for <linux-arch@vger.kernel.org>; Wed,  3 Apr 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179238; cv=none; b=C9ks0DFEnOaHH3d+IPGa88ZMwxmwyH+V4B181bUSYESalfVHr+m1QCPAE0i0+5aq1Dq42QfqQIZJcJtQHAgiDIV0M8ASNtUoXDchFA7P47RUX4mDBTogiIfVjHEer6FWPqo/AngJEhPS79tpE8p79CVR/b5LpaV6gF/Mlhtbj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179238; c=relaxed/simple;
	bh=qNCBndGvASRj94i9gCbn2Ois8Kwv0gWWiWeAMOMLgEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=civ2Xe7YNab3qFZDFK3aSgDwAsrgvGOf47pkI3XDym/qLk8RIVl36COFBNa5DsWERad4UoXVYeQySPael9d0CF/bz98HmZXes532m3WaH+JVKrsc7kxGgGoKE4drunAYKz+OeAooWZBxhIUq6h85vdidxfpvOqIla/OB/dlM6Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ptx5/DWJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2235c630aso1668165ad.2
        for <linux-arch@vger.kernel.org>; Wed, 03 Apr 2024 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712179236; x=1712784036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gk/7t8bB/vPp5RYyhmHYp9/pKPIZpl1c0Hpc1VIArKM=;
        b=Ptx5/DWJGOU9bqEoPLyU4ZVnUh9y3Xg9DvWbgEX4H/YrkQLkMUJSAnSiWexQ4Gzw1R
         647vdzB8MXYOeAzQ/sAS2yYZmG3d071l5agv91Eq+IyAH5kdO42jY6PPSVrRvxB+lNOk
         xCuL5r/sFUNSFKhut5mZeJ47HjuCvvl+8N89U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712179236; x=1712784036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk/7t8bB/vPp5RYyhmHYp9/pKPIZpl1c0Hpc1VIArKM=;
        b=w9c9biEs60pf92660dlGyYE1N35yM8Ps1kWKAXmRVVpSq6916cw6z6uxtIItU3e2GV
         cGQrEfMCXjZw80fCaoiHK513Z2dji84aGqYv6vnWu6M95+tLunGeYzGHkv397BbGW1Ng
         DAFZVQLmMlVKaWJW5U9xUULocOsfQyI+BvUnIJuNDDeOdzu56pkoeyQTNuHc2zy+HK6H
         7HWD6G4sZj9PiOMfedn0Xo1o3rrk0iWyUdo0tlCROoLNma0NvuU/IU3PJ6CX+o2eYjR8
         7JHLiIx2qpCETfTbMWb+bK8xcB29rygVAzcQl7HJ2ivm6N7TuEegXDueL2tqt7XmkCR1
         6u8w==
X-Forwarded-Encrypted: i=1; AJvYcCUtVKe2BXSorh2s2yCnPMTX5Xz25OfT/TvR00vhx8wAenP59i+TdnbCoRZlfT70GxzmkDucJnlLhZCbGc6Vr3YvhHS5Ssu6kc4HKQ==
X-Gm-Message-State: AOJu0YwOeH5DFcrPzdOdYcRSvDrfZnFb6f9d2vuulTxEAbRk5/y+Tam8
	tyB4ZE8yxVSOHMNlxntXfB00HjrpFOucRtU5zc6wHo7xu72Vue4OWOP/81PrAQ==
X-Google-Smtp-Source: AGHT+IFNWSt+grv0aoo3QXgpCvCZ7QxZ9IBnA1B4gdZs5eLtWkdhNXO9ogb9Q/XDMKHoC6MfZl34Wg==
X-Received: by 2002:a17:903:110f:b0:1e0:f25b:e795 with SMTP id n15-20020a170903110f00b001e0f25be795mr509491plh.11.1712179236057;
        Wed, 03 Apr 2024 14:20:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m16-20020a170902bb9000b001e2a87d7d2dsm163988pls.253.2024.04.03.14.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:20:35 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:20:34 -0700
From: Kees Cook <keescook@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
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
	netdev@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 00/15] Add support for suppressing warning backtraces
Message-ID: <202404031414.645255D868@keescook>
References: <20240403131936.787234-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403131936.787234-1-linux@roeck-us.net>

On Wed, Apr 03, 2024 at 06:19:21AM -0700, Guenter Roeck wrote:
> Some unit tests intentionally trigger warning backtraces by passing bad
> parameters to kernel API functions. Such unit tests typically check the
> return value from such calls, not the existence of the warning backtrace.
> 
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons.
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad-hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
> 
> One option to address problem would be to add messages such as "expected
> warning backtraces start / end here" to the kernel log.  However, that
> would again require filter scripts, it might result in missing real
> problematic warning backtraces triggered while the test is running, and
> the irrelevant backtrace(s) would still clog the kernel log.
> 
> Solve the problem by providing a means to identify and suppress specific
> warning backtraces while executing test code. Support suppressing multiple
> backtraces while at the same time limiting changes to generic code to the
> absolute minimum. Architecture specific changes are kept at minimum by
> retaining function names only if both CONFIG_DEBUG_BUGVERBOSE and
> CONFIG_KUNIT are enabled.
> 
> The first patch of the series introduces the necessary infrastructure.
> The second patch introduces support for counting suppressed backtraces.
> This capability is used in patch three to implement unit tests.
> Patch four documents the new API.
> The next two patches add support for suppressing backtraces in drm_rect
> and dev_addr_lists unit tests. These patches are intended to serve as
> examples for the use of the functionality introduced with this series.
> The remaining patches implement the necessary changes for all
> architectures with GENERIC_BUG support.
> 
> With CONFIG_KUNIT enabled, image size increase with this series applied is
> approximately 1%. The image size increase (and with it the functionality
> introduced by this series) can be avoided by disabling
> CONFIG_KUNIT_SUPPRESS_BACKTRACE.
> 
> This series is based on the RFC patch and subsequent discussion at
> https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
> and offers a more comprehensive solution of the problem discussed there.
> 
> Design note:
>   Function pointers are only added to the __bug_table section if both
>   CONFIG_KUNIT_SUPPRESS_BACKTRACE and CONFIG_DEBUG_BUGVERBOSE are enabled
>   to avoid image size increases if CONFIG_KUNIT is disabled. There would be
>   some benefits to adding those pointers all the time (reduced complexity,
>   ability to display function names in BUG/WARNING messages). That change,
>   if desired, can be made later.
> 
> Checkpatch note:
>   Remaining checkpatch errors and warnings were deliberately ignored.
>   Some are triggered by matching coding style or by comments interpreted
>   as code, others by assembler macros which are disliked by checkpatch.
>   Suggestions for improvements are welcome.
> 
> Changes since RFC:
> - Introduced CONFIG_KUNIT_SUPPRESS_BACKTRACE
> - Minor cleanups and bug fixes
> - Added support for all affected architectures
> - Added support for counting suppressed warnings
> - Added unit tests using those counters
> - Added patch to suppress warning backtraces in dev_addr_lists tests
> 
> Changes since v1:
> - Rebased to v6.9-rc1
> - Added Tested-by:, Acked-by:, and Reviewed-by: tags
>   [I retained those tags since there have been no functional changes]
> - Introduced KUNIT_SUPPRESS_BACKTRACE configuration option, enabled by
>   default.
> 
> Changes since v2:
> - Rebased to v6.9-rc2
> - Added comments to drm warning suppression explaining why it is needed.
> - Added patch to move conditional code in arch/sh/include/asm/bug.h
>   to avoid kerneldoc warning
> - Added architecture maintainers to Cc: for architecture specific patches
> - No functional changes
> 
> ----------------------------------------------------------------
> Guenter Roeck (15):
>       bug/kunit: Core support for suppressing warning backtraces
>       kunit: bug: Count suppressed warning backtraces
>       kunit: Add test cases for backtrace warning suppression
>       kunit: Add documentation for warning backtrace suppression API
>       drm: Suppress intentional warning backtraces in scaling unit tests
>       net: kunit: Suppress lock warning noise at end of dev_addr_lists tests
>       x86: Add support for suppressing warning backtraces
>       arm64: Add support for suppressing warning backtraces
>       loongarch: Add support for suppressing warning backtraces
>       parisc: Add support for suppressing warning backtraces
>       s390: Add support for suppressing warning backtraces
>       sh: Add support for suppressing warning backtraces
>       sh: Move defines needed for suppressing warning backtraces
>       riscv: Add support for suppressing warning backtraces
>       powerpc: Add support for suppressing warning backtraces

Tested-by: Kees Cook <keescook@chromium.org>

(for x86 and um)

I was planning to add warning suppression for the "overflow" KUnit
tests, but it seems the vmalloc routines aren't calling warn_alloc() any
more for impossible sizes. So, I think, no patches needed for
lib/overflow_kunit.c, but at the end of the day, I've tested this series
is working for me. :P

-- 
Kees Cook

