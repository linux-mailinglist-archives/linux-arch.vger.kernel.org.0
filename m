Return-Path: <linux-arch+bounces-1966-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C28455BB
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 11:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAB4B24E7E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Feb 2024 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6B15A48D;
	Thu,  1 Feb 2024 10:46:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955415B970;
	Thu,  1 Feb 2024 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784417; cv=none; b=fKzD+8W4/nEdnL7JborArpWv7zmTZvF/z7OTG0KWodysF2c3RplW1Hpx2ZrrAVHu6+Y0WsNduvNrS1B/sFtVEsCauRSAcP2ujShTf5FAFpHr9di5BqtYVujlUIP2yxyzGISoGlgvKIO/3pCQ3IMqmzjyZ3jZ7CPTq2HtNSqCGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784417; c=relaxed/simple;
	bh=V/x1b1ldsDYK3JfVzlP9ZZq7WJ2uPOBTgaU55XZNPrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uae74+ml/x9I8YHsawncyZ/bLn9nMjJgD/nQyKq5iSu/6u9CGaLlOl4FAWn20jMx8XtzDq72Nt/QgJpyEDlVaY2gwESdAWOoltPW1GSoQzMXhse1vCGvQf2FaRI/juEPR33rjgcZN5MBwWsl/hXl3wBpqoPsVKa4KsxVa/mEVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-46b2aaa36d5so314226137.1;
        Thu, 01 Feb 2024 02:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706784413; x=1707389213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFZPcFLhDs+gYYjGu7bIEoeJY8eTRZGl5q1i/K40hjQ=;
        b=AfuD/sPbMby0fAp02Uipxv1N1hhgGlyfRNBoHYWA5TxYrbndJ7584pgDZFssUVyyoA
         tzmh5/mHUh4uEaJ46pxMfVIm0hLkefgukuPlTc58ElBFdIgx5RZfUCvMEG000CyEdLyc
         DtNeweYULzfHKJ4LkEHR5UtyOedmc49kgWt76NFIHbH1v9ub3XmRG978ecgBpFDTnurJ
         EGiK22H9CN2TGQ7NLD5RobNSa7JvwKGruu5JU4LESwPB4C2DT2QELOKnsKkcVUmZEKNT
         nzUAjU58clAK3Pnsf3d/fRxQrQr1kjUVqCcNn2z7qQHppQDZwF1NKQeCi/U8ld5jnpQD
         ioOw==
X-Gm-Message-State: AOJu0YxHEe8ubUmZcjL/kT9sbQO9p7wDesxu328zED16Ocw4fB72g0b9
	tS6enfEBNVHHzDd0qSPIZEA5HbPhFneU/f+Zav/ZHOEtM/QTTKfSBjsIo97eirQ=
X-Google-Smtp-Source: AGHT+IGAax/Sb4kznliaD3ZikyM2fMNpStWpgDSjdppPgPo6zArlRUDDpv43TD1zZV1AYQmu+PZg0A==
X-Received: by 2002:a05:6102:529:b0:46c:ad31:a013 with SMTP id m9-20020a056102052900b0046cad31a013mr1938286vsa.32.1706784413193;
        Thu, 01 Feb 2024 02:46:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUCcA6+DcW2Zid2/1Bir3jdUBSreyAhSoWuY/+WAnYhGDWSwKlYqOphWSKItWfgw1kvyyOrhc8AQanKU1MTMniidZzz8SYazmZoA8HCkuZGCq9DgERUd5F32ESn8X1KKaVTwp0MF+rxTU+DbSzAOIqG0l/v4EOswjtN+PXeDCLKqE8CJS9bE8mBeRewetkh+hWKiUJHL1JW4iDFrBgIqZXouAS4nU2xmoWXz6wja0SotnznG9cDzGnaan4xHDAqL5ME8uQ=
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id ly9-20020a0562145c0900b0068509353fb6sm5840691qvb.133.2024.02.01.02.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 02:46:52 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78406c22dc7so58782585a.0;
        Thu, 01 Feb 2024 02:46:52 -0800 (PST)
X-Received: by 2002:a0d:ea85:0:b0:5ff:7cdc:404b with SMTP id
 t127-20020a0dea85000000b005ff7cdc404bmr1645047ywe.52.1706784391742; Thu, 01
 Feb 2024 02:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com> <5e55b5c0-6c8d-45b4-ac04-cf694bcb08d3@app.fastmail.com>
 <ZbrfcTaiuu2gaa2A@yzhao56-desk.sh.intel.com> <9f27c23b-ea8b-443c-b09c-03ecaa210cd5@app.fastmail.com>
In-Reply-To: <9f27c23b-ea8b-443c-b09c-03ecaa210cd5@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2024 11:46:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPToeXdcBWv2LJuu2Z6td-JYz3GGf5fD1+ScqVD+Wurg@mail.gmail.com>
Message-ID: <CAMuHMdWPToeXdcBWv2LJuu2Z6td-JYz3GGf5fD1+ScqVD+Wurg@mail.gmail.com>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	guoren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Thu, Feb 1, 2024 at 11:11=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
> I think it's fair to assume we won't need asm-generic/page.h any
> more, as we likely won't be adding new NOMMU architectures.

So you think riscv-nommu (k210) was the last one we will ever see?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

