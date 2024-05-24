Return-Path: <linux-arch+bounces-4520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DDA8CE5E1
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 15:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 998F0B217E9
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29388625B;
	Fri, 24 May 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRN/KYpo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90285959;
	Fri, 24 May 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716556673; cv=none; b=i0Xb/gvSupOonhGRG2w92makdDt9BXBDe0wi8JuIO6HOJpFN2GgxAwQV34blvxpCFSYChkzfb9m/zOgZqF2+d8bdlS9VYAGOBOwRxQWTqvWQp3v3Wxmo1/UvNydRv5TxlPHV/rLU/jXsJ/KaL2h3khkNdjGjEVk8S1lrrIrNLmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716556673; c=relaxed/simple;
	bh=SlXCQc3o/MB52ttkYbUWNblq+v3TZ5Rf15VGTVZLLpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1gMXfimHbMWeLHOYM4jBkEvKaESgF50b7U/snP1Jhax+CmsBK0ARc1cvPfZuoV1gfd/7KWw0b23ZnO7WLKWWF1sOMgM5B4Mz2u5scY6QQOxWG3rbAgns9qEliCP1lwpaQtDSSpHPLx6p+3jCi1d28eZaNCfpQSYMJECYrnDewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRN/KYpo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso611790b3a.2;
        Fri, 24 May 2024 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716556671; x=1717161471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlXCQc3o/MB52ttkYbUWNblq+v3TZ5Rf15VGTVZLLpk=;
        b=iRN/KYpovpFye/RhwC4ixASJxRtJdGlzjp4JJHi/TL5i5nzflZ/+jrTBlzImqeeqFA
         Nf2sYF8ErsLhqpccWb87sII1eDidDBObuLtI4V0MJkL3BlWlE3Uk962IQaqFmsCgEpWc
         Ir6uRiKZfYAFg2U2bz/grOHSkBi80Q+Gck/mOi1puJCjnt7KiMYjjksIGdNsrRgA0xTp
         WXkkNcTqXazrLCtGPecXgQRy2Fblr6QcACWJDhTF/71yD/Y+2779VG1Qzse1l1/DmURZ
         XKODVkswaXbzbU+lpZQ+vLFJcVuSH9F5K4QHdYeV4K1JdPc0SUVnOE8PX2yLop2wDeml
         poSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716556671; x=1717161471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlXCQc3o/MB52ttkYbUWNblq+v3TZ5Rf15VGTVZLLpk=;
        b=qpe3xle8uUjZakCyoGv6hxTNXP33TjUBYPzytEp7uC7z4qoqvl3NauQkBC3Ls9JzeG
         PUoR0FF6hrh2W3MJNOsnw4z+hQfwGK/mccnZCN3wZOFPYMEYS6/F/ritLeVXRYNk8NXi
         CIqJ9LGiXOCEXp4eR9kvLFLdHa4VtyMJ52FVorS+Bdgdbzcbo5cMLTDoBIKdccOn/4Wk
         R59VxPplHmAKeRhFk00j6JyDAQi3WHjRejNxgbA5bTlzLMrdub5gN8FVlKTjPwbtvVQi
         /Mk6CQ3OBnIup6CctOPlBb+Nm19z/eRqmxigvA/2HsO4Ea4WnF/QKq6L8yklcIMgTObC
         pB6A==
X-Forwarded-Encrypted: i=1; AJvYcCVnXlhPYn8CDpx6175Utcz01m/x/FNKQEIdXmsDZh1UHeyjQiBQ9CNojauSqTPyrhKaUeFLDHQuOfxQ3HAPQGTkK8wCJ1x90GpQPDYx+TpuOwEdBskVAck6drguvd/gebAi8gwDB6afXw==
X-Gm-Message-State: AOJu0Yxm/1I4HEsuFrzC/3KjTIfEzsfMuMMlkJtC5dwO/SN8G/r8cmAS
	9/YzCNcAauSuXuKNapMpaiDBiDXowSbH/OyhjH56Rv0zPjF+YwMxDuzdUrAZV54F5/p7+RfW129
	UhJwKE8onkuOkUb9Q6plcrVN3wWUuyiYi
X-Google-Smtp-Source: AGHT+IEwoe8jd0oZgn4cZUVcBCDA8tK4CYreDWY9kJHQp57IWOrilIahqDCBhTgwJSyB8G7rI/D9MAOMBfFiB7nWxpM=
X-Received: by 2002:a17:90b:1888:b0:2ac:5d2d:12ac with SMTP id
 98e67ed59e1d1-2bf5e84abfdmr2678646a91.5.1716556671509; Fri, 24 May 2024
 06:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com> <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
In-Reply-To: <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 May 2024 09:17:40 -0400
Message-ID: <CADnq5_NmKyTBbE6=V+XdEKStnjcyYSHyHqdkgBen4UhPnVKimQ@mail.gmail.com>
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

On Fri, May 24, 2024 at 5:16=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi,
>
> On Fri, Mar 29, 2024 at 12:18:28AM -0700, Samuel Holland wrote:
> > Now that all previously-supported architectures select
> > ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instea=
d
> > of the existing list of architectures. It can also take advantage of th=
e
> > common kernel-mode FPU API and method of adjusting CFLAGS.
> >
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>
> With this patch in the mainline kernel, I get the following build error
> when trying to build powerpc:ppc32_allmodconfig.
>
> powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_=
mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm=
/amdgpu_dm_helpers.o uses soft float
> powerpc64-linux-ld: failed to merge target specific data of file drivers/=
gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
>
> [ repeated many times ]
>
> The problem is no longer seen after reverting this patch.

Should be fixed with this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/5f56be33f33dd1d50b9433f=
842c879a20dc00f5b
Will pull it into my -fixes branch.

Alex

>
> Guenter

