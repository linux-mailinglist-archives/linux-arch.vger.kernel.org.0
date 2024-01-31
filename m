Return-Path: <linux-arch+bounces-1888-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F98437FF
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 08:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4FA287365
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7D53E25;
	Wed, 31 Jan 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qugRA3lU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E974F608
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686676; cv=none; b=RsHWXBcNWoW8EVG394iGLszAGA4SNZNMA2k8yHVo24K4bfhsb9nby+7mjJvQ1krDavS7qEL7UJYn9JagBhV8bkiO2/SYOGQWuFAxwsHHnGVsx0GBidwP4BCAI0UMaWs1HLDA7sJ2ButjLkqTonOPPAbTTcJdYcwaGg8wqm4G8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686676; c=relaxed/simple;
	bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMk2VZGNDzzxwXhoEbxUc+/PxYl+Nc9RSePY/Kpyn1w+UxcWntIpeQlRsZl4qIW9SUlmVZclFkYBcpN1zX9UwxA3cLHdIib1JQZQGZSqmcCQLhP/DhwzAOHIHs3z29PszWNQw+AZYOs0B+rWQXbTjOoYTTOMsoqk7N8xJgN3kWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qugRA3lU; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6040a879e1eso5092857b3.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Jan 2024 23:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706686672; x=1707291472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
        b=qugRA3lUGE+4iv2RbCrW9rOiaw+w1w3TnSsPYDomTVfsIhBg2yT8hCDktaLzV3YGPN
         WBPsoZOl2KfuIr0rENOH+XOCCEeDvC3sZczUAKUMtG7ZqIdeEaKs1yFvO/WULHi4fXYc
         QXg/hYuy920fMaLiFZcR5MURBY0NKyO505nTAXQiC2yHNPMZ2aENuRnHDJlfmFVDwVJl
         7qt9yIFqWkVfGto8L5BeZSTJ3GlnL8D6EaEgkKMbzlDnoa/G03OPi52x9soysoVd0wst
         agXaaPO1fxdI4jS0s22srNBdAFPD1+vYng+hLso2Z0EQi5ud482G+YaHuHAD5CMh49p0
         UHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686672; x=1707291472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
        b=iBCnpWiW3cCm07vXgtI7G7oVwFku3QCdaI0DWqu7VRsb9SIBKXapSZ9GqyyTg8ACkJ
         r0dWpk49MZS0yz+5lK2IQSMlKQu8Jx0o5YAydIWu2wQqS1HSa83jJovkfyTRW6vebfcN
         n1QBLktMXRtj2D5n4dVtosSlLh99ocU5EuFdarSiWKnzKYTa8vsYb3yr8Wc0mth1OkId
         j5wZr+7CRLMF49rclvL4DY2W7SlAMnS0vCe2G40VFYIl3HJgADBvrJP1lhmu+jFbBSaz
         PVMpew7LrZeT5orXAhN1ncX5usX/O8sdNrrtJCDb+LJsDq6ssvbLTzEbLgzMmTxx0Rfb
         0jgg==
X-Gm-Message-State: AOJu0Yz0Sh+C7b8qPIW4zeKXS8ZWmu9bwT1pJXQ5LZIMWRsUCNndAK/H
	mfzcQr6GXfl+gpuMMrFOBy42yG9D6weJvCmfR19boYh1jNHw+c2oR+HA7PHZBSHDwuwDHrPZSTj
	DsUzp5roc3vZoOYjoLxl6yD9DNl4vwmyFPP9Brw==
X-Google-Smtp-Source: AGHT+IHYpXRaWLqQlh0oX2pZAjMnT3Ad18mWcU8jYVwFB0aAGnyeiCdKxqpu+uBFZ0ub/5leFryzgJhdACbtZXLSvtQ=
X-Received: by 2002:a81:c545:0:b0:5ff:a52b:55ac with SMTP id
 o5-20020a81c545000000b005ffa52b55acmr594058ywj.34.1706686672385; Tue, 30 Jan
 2024 23:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055159.2506-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 08:37:40 +0100
Message-ID: <CACRpkdY6dS_sedemVk-fGzhsyT_B5dXAeFX-PO+GcvCrt9Je5w@mail.gmail.com>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:25=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:

> This is a tiny fix to pfn_to_virt() for some platforms.
>
> The original implementaion of pfn_to_virt() takes PFN instead of PA as th=
e
> input to macro __va, with PAGE_SHIFT applying to the converted VA, which
> is not right under most conditions, especially when there's an offset in
> __va.

Ooops that's right, I wonder why I got it wrong.
Arithmetic made it not regress :/
Thank you so much for fixing this Yan!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Arnd: I think you can take most of them through the arch tree.

Yours,
Linus Walleij

