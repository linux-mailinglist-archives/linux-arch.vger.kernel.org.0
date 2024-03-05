Return-Path: <linux-arch+bounces-2820-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE8872804
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 20:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079C01F23844
	for <lists+linux-arch@lfdr.de>; Tue,  5 Mar 2024 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A635BAE6;
	Tue,  5 Mar 2024 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VEu5tKE3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803965C5FD
	for <linux-arch@vger.kernel.org>; Tue,  5 Mar 2024 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668450; cv=none; b=Vdm8mD0qTTxvQ9SiSM8hGAd2OSoUtXZ7ppDrruOOraj3LBclVRqzEOmsjh3hzn5COdtYoA5yLpp0AfK5WPeUq4xkhiMf/UrCeZH5512IQ77DtDPWu1cdB1G6/M8252XZ67J8pLS+6M9yi/k/pKbsVA53t96rQ4rIJkVe/3MHqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668450; c=relaxed/simple;
	bh=Thh+og9vWfifMZ7QUJajbgXYm3QoY+CJHcawNAefhMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWTeVDWQ5l9l5bdqyu+THooocOb2MigVqbysPUu3HBUFJRyxGpq8iChSjKhfEP/Jy8DhEPyIXbGdzt0Q5cf0GIgMmIzeP3vnsS3xD+7Ny8i5j4q7ITZhKHwKFMp2yc6tyafq3+EgXWSWwNo57VRRhmmjZVXcv2Vr7ybfELrxdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VEu5tKE3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so92795b3a.1
        for <linux-arch@vger.kernel.org>; Tue, 05 Mar 2024 11:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709668448; x=1710273248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8OJiIuppva2X62G3XuKOpZ18Of2oWMu+/RVVvODtp4M=;
        b=VEu5tKE3ZGEMGDvffumPkT0uy9dQ8tGrLGc5mS3ynHiKSCM4jxVM5Mk1gHagvtd+va
         4Iwg26a4/Jq7rwllJwhLNbUP9PnQmbrV8ntmuSzHQaslvio2ZDd3/Xg2cJSCUEe9CPxH
         Qc2vmlAQcaToA8ldYp9nPwe1NLKlztG9Emee4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709668448; x=1710273248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OJiIuppva2X62G3XuKOpZ18Of2oWMu+/RVVvODtp4M=;
        b=k3CYhEDMMPvb0UognpDdvra5bwa+zaMI07vh2s0dxGyI9CIm5obTyzzppRD9AZ8ZUN
         OnPJOUkEJE031SX+d5/gc8UIb+CJX5cyjhm+eZ91wiWBxigFqN7wXg5NP4zZxbGkV/Zx
         ay3BChpMJVMKK/2DsNhZ3jzEUBx9/fXJh6+YmchExWFUVeKMDkK0B45LF4ml0Wkq8+Zb
         tFGURpyytNfRAYHi14WZ3w/mLqmii7fN3/P6tlunIKRU5iNnunlGX8qkbEUE6G20fAfK
         Uzk2Df+2x7LJkfuN0dyre0llLYM2rOLoHCgzYmXSkfJSkJ2faXbg2jTwQhRxykDjQdQX
         vKMg==
X-Forwarded-Encrypted: i=1; AJvYcCWcv/3oTGaFCQXDz1HhQRkBl9kuEzepbLkSOeKioK4Mgc5JIETtnRNAQegkyAEhsQKp9oOnKSfT5e5dLK9sXG9C8+NnoN3C945FEA==
X-Gm-Message-State: AOJu0YyPPWqYOrj9jkH6NYXPkTkz6kBNBoZuZkj7quGPXn2OfFFgU46R
	ZgyLPKHEiTqN1/530KmMtcIcZ5wrzhZd2xuXD7fZU0ItuXzMZPSbFzSKnR1NVg==
X-Google-Smtp-Source: AGHT+IEPSGoV+PaXRY7JI9uSPnapXCs52p1ILPTe+H1wv+UxrhqJWz+AChv6CTzYH5Lp5odgHWXRGQ==
X-Received: by 2002:a05:6a00:8cc:b0:6e6:1df9:af92 with SMTP id s12-20020a056a0008cc00b006e61df9af92mr4909513pfu.14.1709668447845;
        Tue, 05 Mar 2024 11:54:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h5-20020aa786c5000000b006e52ce4ee2fsm9391340pfo.20.2024.03.05.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 11:54:07 -0800 (PST)
Date: Tue, 5 Mar 2024 11:54:06 -0800
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
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] bug: Core support for suppressing warning
 backtraces
Message-ID: <202403051149.547235C794@keescook>
References: <20240305184033.425294-1-linux@roeck-us.net>
 <20240305184033.425294-2-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305184033.425294-2-linux@roeck-us.net>

On Tue, Mar 05, 2024 at 10:40:29AM -0800, Guenter Roeck wrote:
> [...]
>  	warning = (bug->flags & BUGFLAG_WARNING) != 0;
>  	once = (bug->flags & BUGFLAG_ONCE) != 0;
>  	done = (bug->flags & BUGFLAG_DONE) != 0;
>  
> +	if (warning && IS_SUPPRESSED_WARNING(function))
> +		return BUG_TRAP_TYPE_WARN;
> +

I had to re-read __report_bug() more carefully, but yes, this works --
it's basically leaving early, like "once" does.

This looks like a reasonable approach!

Something very similar to this is checking that a warning happens. i.e.
you talk about drm selftests checking function return values, but I've
got a bunch of tests (LKDTM) that live outside of KUnit because I haven't
had a clean way to check for specific warnings/bugs. I feel like future
changes built on top of this series could add counters or something that
KUnit could examine. E.g. I did this manually for some fortify tests:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/hardening&id=4ce615e798a752d4431fcc52960478906dec2f0e

-Kees

-- 
Kees Cook

