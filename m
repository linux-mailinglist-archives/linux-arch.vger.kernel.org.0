Return-Path: <linux-arch+bounces-1477-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808E839914
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A85F1F2D53D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A11292F3;
	Tue, 23 Jan 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gv1+sAfN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B0129A6E
	for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036438; cv=none; b=kpPUZ2YTS5tKJzV5/C/if0W1Tj//5DUe/jEhktIEDtGLdQ02Z7A34ZX/7+jhUQcilTWvnKOq9tGPyvFpcQjNftjYU97ctMKR6S4B9VMDBgXQkyFr1iKUUuwHTn3CH30SbpFAiehNrje+eNQRok5EyetdGvqX6J4iM5A0aTBNA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036438; c=relaxed/simple;
	bh=ZKIUReDJHL8PnaXbcu3q7fLjNP7xT5ogthRdWpyN2Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwpStrHMaznvhp+bC69VpKTEyiXFmtLJJakpZRx6uhA4n7YcMU7/Q2nJbcQnQ09pmF3R5nPIFtYpWUGnQ8RvPT/1neC7fTbQUdHCXveaTG7hY3eouIi2hTnPlZLvl1De59FLkKdeJ+Jr+H22wEkzKoaUHWbf3kvG/PVxVIMdTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gv1+sAfN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cf1f4f6c3dso2368691a12.2
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 11:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706036437; x=1706641237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmD7dH3qV8pv67RKjqLHiAxOFddNPr4ehUigPqKBvas=;
        b=Gv1+sAfN9oQ3ohxET0P9VDHpRQAScBVhCmZBc7zYVHpZsHYZUKmv/zdyjt9WEKgZUC
         zxPwGNyddiGL1WMgPYI5ISVdReZtuDL6NuVZg/OrJLfog33zn6lejW9cdM1B3MuNpxGP
         mCDO83y6C53ZboG0jqDd8C2WGM2c2ykc4OrtNLlQk+90cOZOKugEbccgQbAbpGhJk0xD
         Zu6ENNWKGnAQfQz12L7ds3RmjzbdWm0HJLGoEP14AHgr/Z8dpmiCaXJHWWXNEWXE+3nY
         mywZEP2Ckp1jT5UKZp0arJL0mRXqfef5ok6DGc9RZG4hs/AfijlhgWmiymEjVcN/WeP2
         xcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036437; x=1706641237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmD7dH3qV8pv67RKjqLHiAxOFddNPr4ehUigPqKBvas=;
        b=btarO8mh2AB8ickk0n6JImDuvwGmAF7imSpqwBeCa1SuGegCdgZVgPq2dM3GCgsXRq
         6Zvkt24S+9NITKQVUGtV2GmGlScwBQCc1LjJtPV2OJ+lKB6IwyCFOAwC93igaYfBLp+3
         F0l23dKIbS3UqdQHsz/RuURVUVTDzvJpUM7LcHC6ve84o5WpwfqRfycrGWHYqC/yIe5u
         1qVusCfkY0RULvn0THXF5YolBj3VRIIR2GgWf68ZGYXetjtzapurw8N1/vH0OUE+b/NV
         oIhGyAFYlyq5igvIieqxTwkF6vf8AtCo8x5kLTloO08Bid9y1tGPYtIjAzf9ek0pvqv+
         G4XA==
X-Gm-Message-State: AOJu0YyYqHCAH9oCSdcKsLaA4kWQWLjenREcbBBP3xPIGf5djq31yjBa
	FVSJbJ8/NteXznp0NkX+skb+CR4UjWnOJFkHwNHvgD4Ag9PEGLXp2OfSihOSFAUEQX6asbMwH0H
	8PaSuMT+Uf67e1vDpcscAPbUZyqoW7R+bO5e6tQ==
X-Google-Smtp-Source: AGHT+IFtt2avi3/WFpubHex5rv8MfO7wLgxXcE6UTmcf3PTwqa8lOjnkVcGgZpxjZjETxZcvz2YZkN830u6srUK93C4=
X-Received: by 2002:a05:6a20:3d95:b0:19b:1da3:cb99 with SMTP id
 s21-20020a056a203d9500b0019b1da3cb99mr3801518pzi.5.1706036435251; Tue, 23 Jan
 2024 11:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-22-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-22-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:00:24 -0600
Message-ID: <CAPLW+4=dtRQT3QMfXLPE_0=TfANTZVa-Jm1Kt9CVTH64hUsGCA@mail.gmail.com>
Subject: Re: [PATCH 21/21] MAINTAINERS: add Tudor Ambarus as R for the samsung
 SPI driver
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> I'm working with the samsung SPI driver and I'd like to review further
> patches on this driver. Add myself as reviewer.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..b9cde7ed8489 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19404,6 +19404,7 @@ F:      include/linux/clk/samsung.h
>
>  SAMSUNG SPI DRIVERS
>  M:     Andi Shyti <andi.shyti@kernel.org>
> +R:     Tudor Ambarus <tudor.ambarus@linaro.org>
>  L:     linux-spi@vger.kernel.org
>  L:     linux-samsung-soc@vger.kernel.org
>  S:     Maintained
> --
> 2.43.0.429.g432eaa2c6b-goog
>

