Return-Path: <linux-arch+bounces-10609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285EFA595F7
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 14:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7220B3A66D6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D785422A7F8;
	Mon, 10 Mar 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvKOExco"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AB229B1F;
	Mon, 10 Mar 2025 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612672; cv=none; b=HCHmAydzGJH3EP8XYZu/KmB1CS01nWehYieY1VII1RAg9O3j5SeFxSGT9ryFjVTrKilQaJV+AH9/mZfozxci/XIZYCinJBc9eKgN+hUIas7OYIgOM4e16Ym829eoUo8c3JNPbLaA6zicaIdXH1P9E5ESk090camqtCCYEm48R8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612672; c=relaxed/simple;
	bh=e81hWutsLUVTbqCvfJFaNFyyZMm2S/O9LJi7D6VMUY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QH/BllqgdLa6mUICQuWobtuY4iZR6VUQDMS6nDvtIkXDGxC0x1F/Fk8hlUrQbRQobAGG2SBT/t4jfwRb9IfHwwD06glZF2xt7VK/ZKm+B/4EdpfQEu7NodNdof1cANEOPCGfreaN3kBW5ILOOPLfmbaj3BFdnZe6t09Vez3bsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvKOExco; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaeec07b705so652761566b.2;
        Mon, 10 Mar 2025 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741612669; x=1742217469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e81hWutsLUVTbqCvfJFaNFyyZMm2S/O9LJi7D6VMUY0=;
        b=XvKOExcoYYRwSmCvg0kxxM/oWBzKWPNHVnn81jELnHH0tEd1hwU6N+YObjYFXVJqYv
         akZ3fD1HZYhBesq9VVnTWr/9uX1BzzpOtbVo1xYzI7HnlQa5A1XY05Ou3vYDv3rKyeyt
         3UV0J4uxVWCa1BJZRb/DJuaz29khSdnC2tQGbePmr5VgolDF7aOyLRtjD/b/yIXEgIHU
         BKy5m6WCrF7l/yTMD3sxd3aInO5B8UB9TIpOd1Gb7aIuSIm1pbJwSUyyJPnN6r8fQxAf
         9AFu29uDaJQ4dpH3If7nj7tnwQm0Xp75/HQxz3xMUqTOLj5eESqdi9dqF+1kVsb18VJU
         cRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741612669; x=1742217469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e81hWutsLUVTbqCvfJFaNFyyZMm2S/O9LJi7D6VMUY0=;
        b=cvFO4gGQ3TPBe0gYTX0TdoBz9MJhlvhi4LBs1XBx+YQun94ass+/N5FEzMIV9fLeL6
         yH6ep1lIDuLXvkMR8CtC3JpPX+CJ9bKE2K/Jh3Ja/GZALQO6IU5V8xAb8zROIO738J3M
         4yshE90d2RBTA7hkuBgtobDQI9U2QbcJn/WBZ3nsDHlYrVaN3iPd5cx1TG/Pi7ZPTnku
         adlKcz+Ekq2MRHoSIqDfZ5JhuCjHG3uf285JhIc20MFbAC09YwlPBslNiyzcinoQdQqX
         Zk+TRdXdcTlCvf0ekhS6+Lq+dsGBGXtKlL+P7UZcpr/oLZsUK1Vus6VWNQblv/Mn6mwb
         4b4w==
X-Forwarded-Encrypted: i=1; AJvYcCVFeqyxhWZVIkz2HWrrd98TAiOs3842a1EOLlv80RTW1jmdkduCsv9nLisZWLPwT/I3xFX3MKP+1bMg@vger.kernel.org, AJvYcCWgJYqa9zZSicz/eZCxwmMOf7+mOk1Kk+h7G41h4EHnIkCY3IYna1tfYpbB4g4fdsJK82Nl9pVj9WPy8Q==@vger.kernel.org, AJvYcCXJxlfexEGnWTKcO2xxmgPZ35AVNipt1G/uqfJ8ag/hxJrKMI0hhPwicxlIE+D461gB/RvRLhNu0qLeXoKh@vger.kernel.org
X-Gm-Message-State: AOJu0YyfdTtW5zyjS+UXwnMqwVly9SsMOPwEApaFoix8ZH+vOn1iyxbq
	J3VX9Mwc0NgA0BOTCs5M79AkNLlubRiNJMSKsZgqxsJeMLZXbp+1RS6eT0lansmNHapNOGnbaUb
	NRsUFn3J8jgKRC5KOkyui8Hy8s+E=
X-Gm-Gg: ASbGncsQfHx8eX1KFm79b8xgepEMcfJvhWeme0z0fhxwB8MhUeKEngl3xoKp46/Ch2K
	Mlkcmpo2IwpNw8iz2JmtpZnwns6YlQGtRlt8M1p6ccBPoUIvK0LXLXNpQw9+JMZ/aHONL5i9iyx
	5CiGpqVtOzKi8mc0CbFPX4rLJ2nqF0nsKL+E2VijAzw8QwGzrd+aMFjFk=
X-Google-Smtp-Source: AGHT+IHNxB7jUw7U1sU/YqvDy1jvAc6QAzamEdqe5B5rflGZNx7smc4lFSrtP5k1Y6lgh3In9FvZqyrp1KvyKGAvTYo=
X-Received: by 2002:a17:906:b385:b0:ac1:daba:c6c with SMTP id
 a640c23a62f3a-ac2526df221mr1329698266b.24.1741612669113; Mon, 10 Mar 2025
 06:17:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 10 Mar 2025 21:17:12 +0800
X-Gm-Features: AQ5f1JqV0EUVop03OzEgZ2BTz5oBdKMCuLbK2kh3Jb2YpPh1RrSVLJOuu0BV0dg
Message-ID: <CAMvTesBG_=Vzwm5DtMcC29DELWvMEhC+XFZhZ=9p7WdiJBSK8Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V features
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com, 
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org, 
	joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de, 
	jinankjain@linux.microsoft.com, muminulrussell@gmail.com, 
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com, 
	ssengar@linux.microsoft.com, apais@linux.microsoft.com, 
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com, 
	gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com, 
	muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org, 
	lenb@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 7:09=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>
> Extend the "ms_hyperv_info" structure to include a new field,
> "ext_features", for capturing extended Hyper-V features.
> Update the "ms_hyperv_init_platform" function to retrieve these features
> using the cpuid instruction and include them in the informational output.
>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>

--=20
Thanks
Tianyu Lan

