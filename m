Return-Path: <linux-arch+bounces-5889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D36944E46
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00EF1B22655
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F251A57E6;
	Thu,  1 Aug 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4qN+ndK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10A1A57DA;
	Thu,  1 Aug 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523418; cv=none; b=HTzf4jp6fkmYj/yWwm6M1sCRWKthYbxRLhMEc6TpS+KVhi4tifQ/PJgQu17X3rKt/2iVC64T1J8+wPFofkvDv6vOQfy3Ma47i9hsm9540XS3CHoKr9yhaVZKQB2zOnR/Z20QifphC+tYEG6UifTXmxiThnaCXwkrNe/rqB548og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523418; c=relaxed/simple;
	bh=u6/ujEJCUh4YGSpB+MrGgoSMLF8fgtd0fehvOfcOdYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1jPXRzLhTEd/I2/8Ht2HOKFJjdbxkvW1J8zBpCa7Yv1O2wqoVwQV8fIRP5Vqz9kl9DjPlgJOwBRpdpvKuh1p17u64QWQnajSR3FRpBEH9hz5a1BuFxq99+SLXIsG5BgaPSPTQd0dF0S7LB1VG7r30vV9mm/m4esY6RJlLdFPcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4qN+ndK; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so88427771fa.2;
        Thu, 01 Aug 2024 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722523415; x=1723128215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6/ujEJCUh4YGSpB+MrGgoSMLF8fgtd0fehvOfcOdYg=;
        b=N4qN+ndKaTzNZcCuXBJvLnmJMG9RKNCatlngjSmecLrUgvcgg9MkJIUTU7Ne78YGFm
         gkXVAJYLsf1phCuFzXFiz5O4QzuYsKFNza05psglD5FeN2Z2KdVUwnSJZB5+p8v8GGS8
         kdT8Li5SBx4Ljz4tZf3ExDStgvW8XYHbC3R7E+hNH9A/VJH9J+BceEokeQ8tAWMojUx3
         F0i4tIQSnd4xlqL0i3/AA9M/C4n+19kDLlEbYkJWBpRu6SDNgtSrLZwLDOq2+aiLqhc6
         93ogPzu9z+XvLpsTgQlkBRICQarUPBVS+nGHD+G35wkXhFZbRqtwDWLj15nyb8pp4G9g
         PbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523415; x=1723128215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6/ujEJCUh4YGSpB+MrGgoSMLF8fgtd0fehvOfcOdYg=;
        b=m9wRi5qFhCCvPeoJrc0WlCaP/KjjAdq/7tZwDFwGKrs5dqVXV/65bvGOD7q2YVjbA+
         KCVIiZv4iNzYptpS6qbUAH7VbwWqAR6vUgqfK2sTWEexjlen01R51NMQOocABx1NIQpx
         V/S3PforrgBrL6newGWAGJoZM/34JIbMzsbBM/HIrNofXJozhCID2WK+1kqLZ+W9Ws5F
         emfggNZ0+QnDwQuSxUgDkbZ/3trq4Xf+eCQSQct/k7QbcOV0cEJfaFBR1NfUYZqAfqFF
         fF/4CLwsb9vgmzV/ddrtEqoPpMMaND5dNWN5I3kLyozqUHr3+VewAfhDFip6RUQ/1tzY
         jCqg==
X-Forwarded-Encrypted: i=1; AJvYcCWu2j8O2Nj1grvQ9hE0qWEKxWmuh0W4EVgVfvi+WC/NMEpZFUs1bQfoS1yUuqlpvfeTUGV8oMSU7kZPJzskWuxws/qE6KJ/BLX6AQ==
X-Gm-Message-State: AOJu0YzmKDtXLLC7wDnzcQqtDcmJdR8YcPAuMNoTjB6qsJotIVk/x0Yx
	6lznyr4zHQ/feCv+GzjutEym0UPaJnNJsVq/1VPtZzH8PQZoqXppwUJziADBc4jHyCkVwuxOrnB
	d1Tt0aM6mcMiyfCQCCP1qHLaHhug=
X-Google-Smtp-Source: AGHT+IFNJ9zJgLUQjTrc19pqKpC1gHtMwjD7nkgmvnnCWPNvmfNstW2EccilTkKIAUqJ9J5+B+OYX6eazGJNyF+aqEI=
X-Received: by 2002:a05:6512:1253:b0:52e:943c:c61a with SMTP id
 2adb3069b0e04-530bb3d635fmr43845e87.57.1722523414611; Thu, 01 Aug 2024
 07:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
In-Reply-To: <20240801071646.682731-1-anshuman.khandual@arm.com>
From: Yury Norov <yury.norov@gmail.com>
Date: Thu, 1 Aug 2024 07:43:23 -0700
Message-ID: <CAAH8bW9sJmwKd19sJzpGrQ5Tr_4fYMyvLnfFyahhxxkG6r6GbA@mail.gmail.com>
Subject: Re: [PATCH V3 0/2] uapi: Add support for GENMASK_U128()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 12:16=E2=80=AFAM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This adds support for GENMASK_U128() and some corresponding tests as well=
.
> GENMASK_U128() generated 128 bit masks will be required later on the arm6=
4
> platform for enabling FEAT_SYSREG128 and FEAT_D128 features.
>
> Because GENMAKS_U128() depends on __int128 data type being supported in t=
he
> compiler, its usage needs to be protected with CONFIG_ARCH_SUPPORTS_INT12=
8.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arch@vger.kernel.org

For the patches:

Reviewed-by: Yury Norov <yury.norov@gmail.com>

This series doesn't include a real use-case for the new macros. Do you
have some?
I can take it via my branch, but I need at least one use-case to not
merge dead code.

Thanks,
Yury

