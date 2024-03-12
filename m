Return-Path: <linux-arch+bounces-2964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E831879E22
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 23:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C2B1F22932
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 22:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7174143C64;
	Tue, 12 Mar 2024 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/TNZHOd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C0143C4D
	for <linux-arch@vger.kernel.org>; Tue, 12 Mar 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280989; cv=none; b=MRggOh4UdHH/pRZFx6Rg30oSH6ePH0WX8dYXzPhZ3JoGfRlh/OoNYOO5XSA3vLqnscHh4q0f4ZCbSME5p5GGGFMW+qGXhVDEb4epomZBpPhuYufdtY8xVnAAuLfH+5KVp8klz0Iv4bpW37xua0iV7n6I1YLnMp/Ja9TzqR3tvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280989; c=relaxed/simple;
	bh=D4lY7fxdRPJh4W1hrWZC0Kv5/fDQzdNIZGvAvIvgwj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY/OfP4sfYTkJ2cHkPOXKLK/U8PHAjvq9r9sl6c/M/u+VrSRMDXL/tNjGPeagx+l2B1KqF9UAtrC7nT5fjuWJNny/F7OUFXfxDYga/CzCuPk0LFtjr/M3dBnsEKNkbtVg9oi0uS3zNNkosKptI6/GQMWispQzAeYQA5U9Mle7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/TNZHOd; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-366753f1477so956845ab.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Mar 2024 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280986; x=1710885786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFZkOPzjUiG9hBeGxmULl/XMqNk9IbEaqEvdeXcgD8s=;
        b=A/TNZHOduTDw50espaicZGUQX6jYzVKJBdIDeVnj4Ef+T1kYvYyYeHd8S7/kNrpvGD
         3RH+VH5SOhmcdBNAHJ8Ce3Yzv+nkQ1baRzAymYdkEDF7B0Re6olgpjR2rwsAoVR/EBe7
         bazE+AsiGg4KmyHLPgOg49cRkO+/ghkrdd1OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280986; x=1710885786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFZkOPzjUiG9hBeGxmULl/XMqNk9IbEaqEvdeXcgD8s=;
        b=V0YcLgQ4AhE+bHSbGuyFGlPn5tTMuzRIAYHZiPHEjrgFZjI+GzCxVhJMQYdduHoj95
         NBXVCTOctI/XI5dSx03KoeT5DESWdR/PNimtdMyh+mA9z9mtbYitIdAmbnoM31Rap5UY
         2H/PLhtuGXW5YCnQEWbHoHi+aekIWmzload5vKHb7R3zblri1YH+/6J6Q7rSF50VzLbx
         pYiAvdzTyCFuDwpFa8Wcp6aUW9hgz9e2g0ZR46Ex/eyrHyJ11Sq2r3ib7Myvtj6DiOnQ
         M49p/S5+4ecHKEN2lXYYI52R3/jTe8WmjD3DFrFCK7l3qIZ4wgkxJQIEmf7Fqr7KITp8
         dkrw==
X-Forwarded-Encrypted: i=1; AJvYcCW7XnDd/DsNv2qG2f1tUUx2y7FJa16t9thz2s7QXo9uqhNP/J8zhy6mGPStQM6zoh480O0cmUWdHMDC+Psz3KQmvVPlG2dcArJnHQ==
X-Gm-Message-State: AOJu0Yw3/I2tHGfBriJtaBFUcqLFqw5HOwO7jw4Zk5eJ/9FTJdt84Kee
	vWvxM2IukT//RMpQJ1ge4dT0kctR24MSKU+bnFSpXRxd1SFduPe5rsMJS6kcGw==
X-Google-Smtp-Source: AGHT+IEdwN1SY2GeciEHPDmRWgTgdPa04evl6KEFQYoPJeYQSV2BmWI4216WoCmzy6l7zJDsrZVhNw==
X-Received: by 2002:a6b:e719:0:b0:7c8:bf15:5653 with SMTP id b25-20020a6be719000000b007c8bf155653mr4918871ioh.20.1710280986087;
        Tue, 12 Mar 2024 15:03:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m14-20020a63ed4e000000b005dc816b2369sm6650251pgk.28.2024.03.12.15.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:03:05 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:03:05 -0700
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
	netdev@lists.linux.dev
Subject: Re: [PATCH 04/14] kunit: Add documentation for warning backtrace
 suppression API
Message-ID: <202403121503.B97DE8A60E@keescook>
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <20240312170309.2546362-5-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312170309.2546362-5-linux@roeck-us.net>

On Tue, Mar 12, 2024 at 10:02:59AM -0700, Guenter Roeck wrote:
> Document API functions for suppressing warning backtraces.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

