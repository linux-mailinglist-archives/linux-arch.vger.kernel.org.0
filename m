Return-Path: <linux-arch+bounces-10447-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44BA48C7E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2226416B30C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84327425B;
	Thu, 27 Feb 2025 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XipCgQP5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7ED272926
	for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697986; cv=none; b=WYehS/unfHpSdF+j9XO8frz+p6rXQrT+tpneEndVtfrlUVp23mYjdfOp0mfli+CEvHBnTk21tocIlKwk4v07PW8zlG6rvP1/1fjViK0ubu3/VRehX5pq9JnrXye2n/fQM7T2X4aMG+wcg9E99b13AP6iV+0nYKhk4MlKjAqsIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697986; c=relaxed/simple;
	bh=VrMyULN9yRhX0362jZvsXqzL/blFpYThDTo1AkO/c30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+vhy4TvPxMvM9EZx1g61Vg2CqrxAj4GkyQE2b0gTqWrQAm2CsqBQokE2jVeyGEp5s9UGuTluZ5WOo7J7xP4v0ISzQX7m8w0clm1oMUnfjHzaR3KDjRjeJ2/KdfmdYj9OGJFs2+AFilxquT9fGxW6nq2M2LrTrJ+BPi1Qr8FJBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XipCgQP5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3091fecb637so13107661fa.1
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2025 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740697981; x=1741302781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmkybCOSFne6yK3kY+Du84AtHtcKYiWZlsF8gbRhEyU=;
        b=XipCgQP5AMF9HQZrYR98rzjGwiwORxjbfuqc08WQYkF5sJfbva3dXBMA18/bZAYruq
         lYzFIm066i1nKA/I7Wzwj6MRBy+0n/39lK+vm6FC6CVRgGDu7WVqIrB8ipuDCvhsn2zX
         gv0fpICwmOY5QulyxYLrcoOFj5IBGXjw4THDC8H5KzFtAVKQ4BSA0oM7EMfJbsaTTsxD
         VZVNpjtUVnbHGmSynxMcIgz16aEeDQ4C2vuh5WGjDtLxJlH3J37QUF3px8FPH2CV6ejF
         XHzz6NQx80JJCWwT0F7ydmGCbLFt4WTzVd+9gutJtxv6qDO2V0i8yvXAaddp2Q2ZPUFr
         Z/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697981; x=1741302781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmkybCOSFne6yK3kY+Du84AtHtcKYiWZlsF8gbRhEyU=;
        b=sEP6rwdCEVI1fA8c/4g1/45Kq2Vsh196J4SdaxZLCZCHC4gT1cewMbBn94o1XYGHK/
         wplX3GhDhy433f0d44jJFHxntXhgw62Zvb+AW4Q6VxpcvD4lK1z6qKQVUcahbgfDflLg
         DK/OMX+o3FtJwAXEvXn45vNTQhuzR/Cy38YjlbgVWiYV2uHsPVf63OSqvdgbeljPSkW7
         jlYZUu+TPHURfKkdIQN4tLiscaKte996y68Wg+GV6APP/fcuuM4cwE9KiX4d9vraFDVI
         LtXenQyS+CNrxQJFDbjdL4KWJzkAc2mSc6xZTkizRMCwGsEoKSsGOSiUS38cd3fPeuBK
         tNxg==
X-Forwarded-Encrypted: i=1; AJvYcCUGHPFCIid2AtELpEIvHnxK/sf/duCFOxbFZO9NyUjULZzkk54dixdSDsgRUe8nf8JIq61rufqXAcrz@vger.kernel.org
X-Gm-Message-State: AOJu0YywQx5dCa/dPm3VT3qDguT40/msQK/afopCrxjHm0WyssypNVHk
	4g0bFMgvwqegXGLdOUuRXrdcAGW7hpGf3WcwDOCX7bxkQ6KWqp1hgfCE6dnfODqD91olC0y8vxR
	/0+VAnRYWSGDnbf2vT9ck/xbE1/1ABGv58Htb6w==
X-Gm-Gg: ASbGncuJ2o0XrXM5lujnnbgbsfPyht2ZwYReRlKAGS8PocVdqKVRPintg9KCurYM7eW
	tjD7hZSZz373s5YC5tOTj2PBJX9CL/CgB9cLtEth7pHDmfZHgNmx4jgk8XMssrmAb7Mr77NFUkE
	I7HNvd36M=
X-Google-Smtp-Source: AGHT+IHLcUchRQ5RHejMZKQOgPdGa2RgldlYInULBrGmDbyHiaxGOnJDGcYbTPdwNuvGN5wuzKGCGgT0iWuzwLntJq0=
X-Received: by 2002:ac2:4e0e:0:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-5494c354e58mr578980e87.49.1740697980909; Thu, 27 Feb 2025
 15:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com> <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-15-cc8dff275827@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 00:12:48 +0100
X-Gm-Features: AQ5f1Jra6Y1TNly1NYmSkFPtENvNIwlGHtsux17X3bXg-g3qhlo7h9G9hMQoxr8
Message-ID: <CACRpkdZV4EHGxYrX77FgsZvPrHohCEixXX6dkEoVSYSsaAzbYg@mail.gmail.com>
Subject: Re: [PATCH *-next 15/18] mfd: db8500-prcmu: Remove needless return in
 three void APIs
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Lee Jones <lee@kernel.org>, Thomas Graf <tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu <zijun_hu@icloud.com>, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 2:03=E2=80=AFPM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:

> Remove needless 'return' in the following void APIs:
>
>  prcmu_early_init()
>  prcmu_system_reset()
>  prcmu_modem_reset()
>
> Since both the API and callee involved are void functions.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

