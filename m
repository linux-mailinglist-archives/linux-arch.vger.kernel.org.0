Return-Path: <linux-arch+bounces-2989-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A473E87B868
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 08:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3731F2370A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 07:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD385C617;
	Thu, 14 Mar 2024 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHIMVnJN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053C5C618
	for <linux-arch@vger.kernel.org>; Thu, 14 Mar 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400785; cv=none; b=LHIZzY4oLTXw83zshqNvkwj1bhSgzKfIgyGd4WcXFu1+x56C4i4pFUqPzkO+miperdmEU0WykAF4tUx+plgtjgB4rXOTbZ7vAdX4rBh5zDNo4szzULnVngH2vQcJeFJ0D1Um9bIHtASuZd/jpOvChZkShXbf4HO3J/lryzhPiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400785; c=relaxed/simple;
	bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MprnRJu+t3BYSxy8gBJrvIk62fnMjPIVHSIHpyeJRrgpYgBQRM5JDS9CaD2MpwoR6pssRBg1XW4+kJjW5rNt83m6fqcgSaQpu7Yo8bgNdFlTzn0WjEtTwjMZ6iFrie25BsXL0+W+BnBG0qnFNlsgeRQiq2AQ3biVBFIEFeut1tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHIMVnJN; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d4184ea661so405605e0c.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Mar 2024 00:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710400782; x=1711005582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
        b=dHIMVnJNZyu9wR5geyJVPDj4comCj9wjcuOeFrKBDzqLgGw+CQBPZ1Rmihoo5GCkQk
         gydtmwqK3bAyUQ83K7aML4v1hC9BZsKaZY0525UWagjZ8fsfJjDvJCfTzPWBJIkRmnUw
         aqsxskaVNMTLF/3Z9nA5isBPT4u3Yq4jYupi2OgSKlS9m8HMCQRgUMFlHHuDSHNq1156
         fe20i6sKg0KFcplI/SjlxLz5IVdQUpSXorjm5CgzoGPqRpdOLawFaN1HF8KKz8kq7kL1
         bQm1n65uWSarY1LTrouE2yAnbqFw/ncMm7t62skCvSwOMTp5rQvjdSJYjYug/MnRNZrc
         YT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710400782; x=1711005582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojH9YgZdQsTdhM/5DOp0sR2SpKlzVwEvHTXac3BNoo4=;
        b=suJGBKpAtp3trQ8LeD6rxj7d4T/jYje6GbVEP9P7kbVAesMRWG2dXYL50mJUqPOrvE
         IWD+OVneZ+yQcwRVK5jq5RFzd16Ajl/l4FKBPkBMeUaAfp7jLRWWk9xuo54tOQI/vY6f
         hbjkQmu6ZgkucKH/qPjTzi/cRv/kMTDZcgI0Owq1E1N/C5lj+DP8NwX+EFA1nwu0w699
         ifqxjOseGK8svfbVWObEhZQMmNmN1ESI9K2eCDMgzwWQiiZHckJLSW5H2XD+ZMcfcqfi
         UtD7A7Q8YwaAxsJmtP7+gbucrMXf+lKZE0jqC6No+NupL1BJ48gK/911EjcIj03ssUnS
         IiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdQtm3P7cg0BTAgYD1XiDCgqWkyRhLVPK4IwXfKkQRp2jGJ71dV9F/60QPtw/zz5QA7HfeLrXxFBj8dItFSSoD/gMHrqAHbhZLlg==
X-Gm-Message-State: AOJu0YwuJvhuuQUaKTJoCc6AMplOavjNeVvVniyGcEmTJq5rQ7UtDRP6
	EStYdNcnAAa1aruTGOLsW8rG+T3FuiZIkP55XV3CQlzq+rk1IwGkZH/c0xE+dt3QaArcaXKqmSn
	+lEuey8CqDXtP0Fk2i5Z7rb/9PPfcxHLzq2eSfw==
X-Google-Smtp-Source: AGHT+IEu7MNUInwIY97dleYnWeWXfcA+5F5T/ApvKi6n0MwxHEqr/RR8abTAy2/zINbSlyHB23weCyfflgDg+RLDw2Y=
X-Received: by 2002:a05:6122:1296:b0:4b9:e8bd:3b2 with SMTP id
 i22-20020a056122129600b004b9e8bd03b2mr431224vkp.2.1710400782181; Thu, 14 Mar
 2024 00:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312170309.2546362-1-linux@roeck-us.net>
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Mar 2024 12:49:30 +0530
Message-ID: <CA+G9fYsHhTLw3c1Eg-L6G3H2g7-mPf9zdR+hKDCV10RhHk5vhg@mail.gmail.com>
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, netdev@lists.linux.dev, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 22:33, Guenter Roeck <linux@roeck-us.net> wrote:

<trim>

> This series is based on the RFC patch and subsequent discussion at
> https://patchwork.kernel.org/project/linux-kselftest/patch/02546e59-1afe-4b08-ba81-d94f3b691c9a@moroto.mountain/
> and offers a more comprehensive solution of the problem discussed there.

Thanks for the patchset.
This patch series applied on top of Linux next and tested.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org

