Return-Path: <linux-arch+bounces-3434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918A2897DA0
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 04:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1E4287698
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 02:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5A1AAD3;
	Thu,  4 Apr 2024 02:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VyMVQ3zt"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E123233;
	Thu,  4 Apr 2024 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196868; cv=none; b=nUKkBUYxIFwNq3txgVe70WcL44+XfLNoqR5RzlRTYKnsLllyRrFl8q0/QikyNyjrxtVUAuySGAzpwpxuAl5BOk3I12WP46VlBfCwpabjqkPUo0aOrU9AqMYtx/WV+PuW4mJMOYDJtogHUJRsfOwZbTlyw/jE/KnW/bmfBwUz2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196868; c=relaxed/simple;
	bh=R4aUilhN/aKLzJiF+HvkOFiYVxByUuTPeENIZPQUzeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RmIjYTi/IF4DjLMYkZQSBBYwcWRfhMoRhZXBKulQQl1GO4SrYk0fZmZR3wHZf9tNjT1hk8ehz1ZxnQvF7hUG95hUl+7GQ3KKVYafn/jS0L5Bwey9bC14FNU0c2/Lxv1gD3jOPZ15A6Z5ImWS5B130/TR4QT42IbBYID/EX5NbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VyMVQ3zt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712196863;
	bh=0PcvpW5SQPrf4QnOqaQeX/XXu99U3a1qNIXPB0jb71k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VyMVQ3ztogSJTiIgLxBnLkNGFUgd68Qe2KDkfvwgzAo6UXogiTKbR69fLdEZZdu7n
	 j3iNV2JgacCj30EfVfA0nufM6LLB0HhkUu4/gC0cH9GF15bjP6K55yY/SHfDcHG5LZ
	 C6A3Ro/1onK6pyPh3jlVC2U8y95oPYSyx7VeOvKtcmV57g7fuqL83rvaMyFKYOVpxw
	 oxm58pQDGWVdn2ucF5HZ6tep2QVSw9tARy9V9golouCtHYA3Tik7KGkuZEvWcLHYKF
	 3HCUbzR0cNgClz2PklZaCGNb+9TQaIfvB8jeqaIi2XVH6tgkaEYydsWFGiIh6MP6A8
	 HT6H386UWr5YA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V94th0jq3z4wcQ;
	Thu,  4 Apr 2024 13:14:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>, linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 =?utf-8?Q?Ma=C3=ADra?=
 Canal <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>, Kees
 Cook <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>, David
 Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>,
 Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Maxime Ripard <mripard@kernel.org>, Ville
 =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Vetter
 <daniel@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org, x86@kernel.org, Guenter
 Roeck <linux@roeck-us.net>, Linux Kernel Functional Testing
 <lkft@linaro.org>
Subject: Re: [PATCH v3 15/15] powerpc: Add support for suppressing warning
 backtraces
In-Reply-To: <20240403131936.787234-16-linux@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
 <20240403131936.787234-16-linux@roeck-us.net>
Date: Thu, 04 Apr 2024 13:14:16 +1100
Message-ID: <874jch98nb.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guenter Roeck <linux@roeck-us.net> writes:
> Add name of functions triggering warning backtraces to the __bug_table
> object section to enable support for suppressing WARNING backtraces.
>
> To limit image size impact, the pointer to the function name is only added
> to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
> CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
> parameter is replaced with a (dummy) NULL parameter to avoid an image size
> increase due to unused __func__ entries (this is necessary because __func__
> is not a define but a virtual variable).
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2:
> - Rebased to v6.9-rc1
> - Added Tested-by:, Acked-by:, and Reviewed-by: tags
> - Introduced KUNIT_SUPPRESS_BACKTRACE configuration option
> v3:
> - Rebased to v6.9-rc2
>
>  arch/powerpc/include/asm/bug.h | 37 +++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)

I ran it through some build and boot tests, LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

