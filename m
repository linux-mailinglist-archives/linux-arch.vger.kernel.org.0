Return-Path: <linux-arch+bounces-4521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0B8CE5E5
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 15:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26649282D0D
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962986244;
	Fri, 24 May 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGS/4oW2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474084FCC;
	Fri, 24 May 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556730; cv=none; b=DRdC+C4tETMB19AB8Hv62fNohxn+68D5r16Zm/duZmx1cGBWUBHGHlYmj9s4Syozf30WtaBHVLDIM46xzERXtQ5hVrNE+lUUWKPGw7lOlu0Dq8sDgvWbRIJoBoQ7eftLspus8ElO1yySB0AR3Nh8hDv795A5CZFGrBoaocm4naU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556730; c=relaxed/simple;
	bh=vZD5jP0xz4NBhWN8Zgsp2iFPrsWGp03cRwKrWdar1DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azFMNNTkoz1dFDK4glOBniGSZKdIUE7tcSqUYKsduhSF7Ym/zOdit8kCYyaKCVb68S1hHnszVBPPptKPXLV9+swNS7rcTRBWtX4xUmpyNVznBRV0Pv+mIa1veFa2bbyRWDdwMFki4cqtZHW63EMpjkgCE+DfZQ3Ey8t/ai7d7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGS/4oW2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f67f4bebadso3227545b3a.0;
        Fri, 24 May 2024 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716556728; x=1717161528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZD5jP0xz4NBhWN8Zgsp2iFPrsWGp03cRwKrWdar1DE=;
        b=ZGS/4oW2iBuF7yZFl+j/aImKTtSSLjXPjQJC126OeEDPqSSzmXSfOi1IDYr6rwtgbW
         K7XxJmiF20XCp2lASMHVeWLrmNfBUI2sxb1ocPOk5OjMgCvTtIlekRXnDyXaRK6mx7uN
         qHNe7sA6U8sgmtq24VsZ4IggjpeQWloWrk3DuZNrS1r3pFeOJ/Rprswt6UnX6ITelNNu
         1Srun7yVNXKqklq7DgKsWEcAU21odxcy1uzHdeQrVKfxMYGzmhA0b6dyQyfVl3dg54js
         TLKjHWNgOMTBcLiXCsp21V3AE7pqLrE6a834w9/N6K4XgefsFehKdMQsQHZ6YaFl7oBV
         d4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556728; x=1717161528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZD5jP0xz4NBhWN8Zgsp2iFPrsWGp03cRwKrWdar1DE=;
        b=SLQ5Vg3mPhxz4stbUEbRANm3RMGFSGH9/fj1py5WOOF1iZ2/yCz27D58Ml2BA0/l4o
         GslSlSTy2P9hcb/DElaKKARK1pUxY2VlhFiboYcRaXtHMzBa0bdb8qQeKLbGLWQP/7YA
         90qqdfNRdgvdrJ5f/pbYP6GbTYkN0HEXvsFUhCm3Zkb25vJKyEX9gPK5Z8CFim6BTXJZ
         vHNcrHIXHZTdTNT+3PVcNvRHK9S9Er5CONA/OdJ+xG4t7R4GPVEh7KJHubZExHugFYJn
         he9nFhuANqSEk+84Xy/+ZH7mUz1B32Wxmpy8+YmT4eLBkd+VG45L3XbwU9yWd8MqvV7c
         aKIg==
X-Forwarded-Encrypted: i=1; AJvYcCVh0tuJeDiSuxuRkkdN0tZAj1SFpWha2Pi27vrRrxVBaGZ8OO1O23mVD8vAx2hVC/2SNW8JTfYAkJHZH/9iK0BH0xTUfUe85TngGR+unGewsXqwr+R1631Yzq2ZKKfVfGzNKgDlyI+ZKA==
X-Gm-Message-State: AOJu0Yws0Xjuf/7w4QJg8w6XUOiK/iaIpnuLCT3AIe5TxgfGk7i1F3WT
	4LwN27pFU2oq9pqyKMSOLWmLF7V83NDvUDsWm0dfKzVHguFI/JLbnpdvuqNHIfabNTJuuH35ww8
	t3GeCYNorl0BolN6Ja97Y+xQ0KT4=
X-Google-Smtp-Source: AGHT+IE8pCp8W5E13VNHTBajd1iiFRN6k3JoN7VIxHp3GdM/LrEcuL4DsERnr62fGGcgTS9Bh/R3Y3m/qNihJWl6krM=
X-Received: by 2002:a17:90a:c394:b0:2ae:346d:47cc with SMTP id
 98e67ed59e1d1-2bf5f715486mr2416381a91.38.1716556727885; Fri, 24 May 2024
 06:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com> <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
 <CADnq5_NmKyTBbE6=V+XdEKStnjcyYSHyHqdkgBen4UhPnVKimQ@mail.gmail.com>
In-Reply-To: <CADnq5_NmKyTBbE6=V+XdEKStnjcyYSHyHqdkgBen4UhPnVKimQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 May 2024 09:18:36 -0400
Message-ID: <CADnq5_Ndzw5Gre=yyPKyFNX5yFWjTCMg2xqrn6tEj6h8t-nAYg@mail.gmail.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
To: Guenter Roeck <linux@roeck-us.net>
Cc: Samuel Holland <samuel.holland@sifive.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev, amd-gfx@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 9:17=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Fri, May 24, 2024 at 5:16=E2=80=AFAM Guenter Roeck <linux@roeck-us.net=
> wrote:
> >
> > Hi,
> >
> > On Fri, Mar 29, 2024 at 12:18:28AM -0700, Samuel Holland wrote:
> > > Now that all previously-supported architectures select
> > > ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol inst=
ead
> > > of the existing list of architectures. It can also take advantage of =
the
> > > common kernel-mode FPU API and method of adjusting CFLAGS.
> > >
> > > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >
> > With this patch in the mainline kernel, I get the following build error
> > when trying to build powerpc:ppc32_allmodconfig.
> >
> > powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/displa=
y_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/amdgpu_=
dm/amdgpu_dm_helpers.o uses soft float
> > powerpc64-linux-ld: failed to merge target specific data of file driver=
s/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
> >
> > [ repeated many times ]
> >
> > The problem is no longer seen after reverting this patch.
>
> Should be fixed with this patch:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/5f56be33f33dd1d50b943=
3f842c879a20dc00f5b
> Will pull it into my -fixes branch.
>

Nevermind, this is something else.

Alex


> Alex
>
> >
> > Guenter

