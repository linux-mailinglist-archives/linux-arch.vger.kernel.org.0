Return-Path: <linux-arch+bounces-2923-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3F2877A65
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 05:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C680EB20AFD
	for <lists+linux-arch@lfdr.de>; Mon, 11 Mar 2024 04:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A38D6D39;
	Mon, 11 Mar 2024 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5XaLtQT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D863AE;
	Mon, 11 Mar 2024 04:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131775; cv=none; b=MDxxboAY6FOph+YsMtiLi4GJx7BbxoWpr0A1YmDAJzoaget2WfVfB8LjVw66vdFUkzl5EUz61/MyHcVgwZNMCc++lcebotZV5+R7m/opRwaDq5sviCepcMrbpVzIUEADINqk+2qvGcjdNL4HUyoxybljlsvlxfTgci6MHq2R9/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131775; c=relaxed/simple;
	bh=gqmZzmP8nlpwp+4dLArAfocYsyqp64vuYa7f4fUPuiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1iOm5TPHzun+PvQqP0rtkMKii7SK33bGCievtv9aRibKzZgnMLDWn03JQzRmHMRFp0Kbu8CSAGPIHvZtVS/7uRwiNLUzJIL+DF+tTzPNmgtw4WIX9bVg7Wd1UVZ5sbCgmE1ZSfTDdLhP0kP7QelEZxRyh29Nwgtc+sHFBEW+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5XaLtQT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299b818d63aso2670880a91.0;
        Sun, 10 Mar 2024 21:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710131772; x=1710736572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiEYgTiVIfRWezz5AaQue6rBdCpnJEAVy8ZiGZDVI+E=;
        b=L5XaLtQTAOVyrL5jHQkeZC5ulydLU65SNcQY110eJwhw8DtuVN9Mkri6LIXnpvILJ0
         Jlyph52ih1qpwZv69QCJKYbI6YEuJbGbR6hI/9qmU7H/09o+P7NHnuQTkVjt4EeuCFaC
         cHkWnoRc7qkpM9+tUfH5ANjdqd/JAiwhHZebZRy78wzv4yZixIUnFD62Iw8yqG6F9UZS
         +h3I9CykA/Q07SZmsdZ3b6ODk9x6tcBXUHA0hjrfr+jKFx1hrb2lUIzaI4l2HhKPGBkF
         4tYetoWB8pkMEpXKR79VK1mRjC7cmvQtTSYi6n9x8Qq4MJ3knya/2evahTjsehY66DeK
         hNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710131772; x=1710736572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiEYgTiVIfRWezz5AaQue6rBdCpnJEAVy8ZiGZDVI+E=;
        b=h5SIcgG+gsaPNetAmwgQr31OccyXyhJmYTiB+XebQiv+pVcp41RsCv2cszSI+X4eYf
         mPD9HR61SbIoWWLaUFpCixbLcCvFrLvlkfIoiTcgMAalxfZebxsYk79RHN1M18JpXsVU
         yhPdWqtGq9dRifVN8abhYg52UhMNO8UxKpUgoZYHxPPaa4/yq9/SGZKP3N75zC7z/hx6
         /qUe2ZPGO+ctfVol7czoygjVBX7UUTYQ8/uPqEcri822JDFmmydVAuQSvjhqxl1hUXeh
         ixC9RFYz6IWyt+SoCYS5iP1hsnrISzcZWXXAZRqMRP70SrWumAOuRB0P+NxDh62QHV5V
         sAWw==
X-Forwarded-Encrypted: i=1; AJvYcCWW9NoRdAzUck3Gqhn2Ya6/AiD5+xPgik7gSsqAKxtwvDMKeBVbr5JAP3AfgPqXZIYBdQH28Eek22FRZ04TUCx+RjqHkYNvlz9KbjgXzUfFOsjY5KLW2VfWs5cFD3TnapgfLJcbeBCEWw==
X-Gm-Message-State: AOJu0YxtVY2dIMZndn+7LzFzrz+tBxZp32iOolWQGGWBYrpNVMfuD1AP
	InyS0SR9qOHbFdxQTAPvC+6nnlndfx2Olj67R/iuu1Su+DVsEq4mTTR7ZII9
X-Google-Smtp-Source: AGHT+IH+D9y4G7q+l3gX0afrHis3jTndC+4q6rRWXxESOkmoncT+9xkRPwtY2kgZHGqK0rqBuSHufw==
X-Received: by 2002:a17:90b:e8a:b0:29b:6cfb:14a6 with SMTP id fv10-20020a17090b0e8a00b0029b6cfb14a6mr8043401pjb.11.1710131772355;
        Sun, 10 Mar 2024 21:36:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902e30a00b001d9aa663282sm3583751plc.266.2024.03.10.21.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 21:36:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 10 Mar 2024 21:36:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Add support for suppressing warning backtraces
Message-ID: <d24f147c-a304-4395-aefc-bed7490278b6@roeck-us.net>
References: <20240305184033.425294-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305184033.425294-1-linux@roeck-us.net>

On Tue, Mar 05, 2024 at 10:40:28AM -0800, Guenter Roeck wrote:
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
> The second patch marks the warning message in drm_calc_scale() in the DRM
> subsystem as intentional where warranted. This patch is intended to serve
> as an example for the use of the functionality introduced with this series.
> The last three patches in the series introduce the necessary architecture
> specific changes for x86, arm64, and loongarch.
> 
> This series is based on the RFC patch and subsequent discussion at
> https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
> and offers a more comprehensive solution of the problem discussed there.
> 
> Checkpatch note:
>   Remaining checkpatch errors and warnings were deliberately ignored.
>   Some are triggered by matching coding style or by comments interpreted
>   as code, others by assembler macros which are disliked by checkpatch.
>   Suggestions for improvements are welcome.
> 
> Some questions:
> 
> - Is the general approach promising ? If not, are there other possible
>   solutions ?
> - Function pointers are only added to the __bug_table section if both
>   CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE are enabled. This avoids image
>   size increases if CONFIG_KUNIT=n. Downside is slightly more complex
>   architecture specific assembler code. If function pointers were always
>   added to the __bug_table section, vmlinux image size would increase by
>   approximately 0.6-0.7%. Is the increased complexity in assembler code
>   worth the reduced image size ? I think so, but I would like to hear
>   other opinions.
> - There are additional possibilities associated with storing the bug
>   function name in the __bug_table section. It could be independent of
>   KUNIT, it could be a configuration flag, and/or it could be used to
>   display the name of the offending function in BUG/WARN messages.
>   Is any of those of interest ?
> 

I am ready to send a full version of this series with support for
all affected architectures. I am undecided if I should send it now,
based on v6.8, and send v2 after rebasing it to v6.9-rc1, or if I
should just wait for v6.9-rc1.

I understand that some maintainers dislike getting new patch series
while the commit window is is open. On the ther side, I tested the
series thoroughly on top of v6.8-rc7, and initial v6.9 release candidates
may have their own problems. Given that, I tend to send the series now.

Any thoughts ? Unless there is strong negative feedback, I'll likely
do that in a day or two.

Thanks,
Guenter

