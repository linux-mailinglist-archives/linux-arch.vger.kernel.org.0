Return-Path: <linux-arch+bounces-14665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 509F2C52B1F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6D374F144D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33223F40D;
	Wed, 12 Nov 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt3v8JFJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FED1ADC83
	for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956123; cv=none; b=kKFj+ak6LwuUfIMcc4o+zkKExC5OJM9fE2Svry9FnqpLqLCHsJ5O0go5xzA7ZoWJ5ZO4kzre/e/ExU6whJA2tsx8EWC9p9eGKvcXY9yHd2j78KxEIo5kRoaZsYpOlOeDW9nT/r75ptnehn7fwHROHthjo4/Bs9rMXGurx3dddxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956123; c=relaxed/simple;
	bh=6flJNLXgwwe1bxyVIrBjw3X8D6FAWRej7avnnwS5w8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+Fdk+Zb7Ltvl64fyReqmUEyoDjPpyhCjH5r9rOi7yczhEG2flWjMbAq16RW79jPdzzHODNrf6yX8h7gNs/6Qwm41crohvhtMAzws7yXFFw8MWtnbWTt61SVqHdzphIuEefL5SqWXPSJO8C8KOvYgd3aTyVPPe+rwoGevV/zEso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt3v8JFJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47728f914a4so5649325e9.1
        for <linux-arch@vger.kernel.org>; Wed, 12 Nov 2025 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762956120; x=1763560920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFiNysBG6OvNw9jo5O2oUZrLaPvoxn/0er906rz18Og=;
        b=Zt3v8JFJyvZPmu3dSusMRTFJynteQLGAn/pjB7u/p8kyajCPsicxRsW4rac28gqUTu
         jzBMdgS3Pr+1fLkH9tPQZIAM8nbRszr/QbQt0jkK3wX+Z00Z14q1oqxl2TO/XBYZora4
         /U0KC8qbU4/ez5eBRh/z1GvQLxugJS0ba3mwJdMuP7VEOdXHEBwStYM5lgrnsN27IBZa
         WWjDGGXt/gVuo2KyWTLsJ/8tM30LycKBm6DdZZpVYCyoaujjWI8HeDnuFaMWQs9YIC0F
         CqYm/rFwJ3LNiNOCoLuQPcoXv5z7QOE1I08+WzNQDqfs//fw4gjqDQTHqnmv9T6O7KTu
         l/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956120; x=1763560920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFiNysBG6OvNw9jo5O2oUZrLaPvoxn/0er906rz18Og=;
        b=i5fyk5Zzj82vXDXIHafRHUGPHsMvAkWejks6aamMV4w1ZJdpVRFPKnMu3jOIlzk/56
         LYY6RL1jggEF0A7CFXkFj0UaZkvt3+iofMoKkD2QUgoT+STw7maNCJXdkcNn/S1YwJqb
         MADpL6R9yZGGiG0ROUQ8mmIkMHnI7Byh5I7/CGo0ZuyzXMIE/FSqNEs/jpX4/NOGcM6u
         DC2A6YIIbgijXfR+J0blFvAbXR3FBDExXtV0Dq5jltBvA/nq430RfP94Nu2Z0gQXX4Fg
         QdHj0tfIzIXOyEZnF68EOhQ3rMMVlPWkNwhdYT4KuymobQjj0kK8JDv9rizCq/nWtNXG
         +wag==
X-Forwarded-Encrypted: i=1; AJvYcCXLreiL/oFUcHHT3Tr81qJWMmPW5gsXucFmext8ZLDUmzmL62230jUk93pmvmAeXGvml9OGbaiwz7yx@vger.kernel.org
X-Gm-Message-State: AOJu0YzzltqRDCMI0JVn+JPElGPPos6cxwOT65/2N1IoVouIwlMOIXFC
	wWkL+DcF+J/9u5Rz2c/4UYgw3eWj2aU+losKE1//j/Kjh9y+3XAQP8Nc
X-Gm-Gg: ASbGnctuDdVJUUuE0BRbe6d/GmjM7UxffQODDQYGgAoRYttH3pfb2yqewJ8xrTuGHBn
	N359po+mmdhAH2rmnhMae9B+KpDD/YpbtgBLXobeBjoEqm8Ognb6sE/tVJV0H46ILy45LCW41jJ
	krHuetPJyoy7vcUAJiICiwuYqqDAFP/NrG/WSFJo6GC8f3hpejkyWCtr3dmFJH8noXKq7honPGa
	RVUtsIbhRtRaV1+7ziEw285bin0l0LHrYozaTEdub985DQlUyWFl63CXOLO/O8VAKH0c3brx/Sx
	O0AA/EQFWcY1TzOMOOKmaTNWzAHyRgFkAQE22+dpFrhRucBM0bgnyStBoWhVd0p4Z0IMKg2KpQJ
	wNd9Si2gcbpW2f33LPG7S/CavpQ0LI8sdTyENZE2mNfCh1reivHsbgFT98+dHIxdkCcinjnwspu
	i3RFqJf6hSrowscTbtR1ipj3RzMne0GSyGAzu/8SJx0Q==
X-Google-Smtp-Source: AGHT+IEPEHr94PrGNc5EHN4MH5qDhAUHAyxSl1e3kw9Nt1S+if+1dRlR+YYzG83HBOq1lnqrURitPg==
X-Received: by 2002:a05:600c:3b17:b0:475:de12:d3b2 with SMTP id 5b1f17b1804b1-477870cdce6mr27931775e9.36.1762956119466;
        Wed, 12 Nov 2025 06:01:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm16272835e9.13.2025.11.12.06.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:01:59 -0800 (PST)
Date: Wed, 12 Nov 2025 14:01:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Chenghai Huang <huangchenghai2@huawei.com>, arnd@arndb.de,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 anshuman.khandual@arm.com, ryan.roberts@arm.com,
 andriy.shevchenko@linux.intel.com, herbert@gondor.apana.org.au,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, fanghao11@huawei.com, shenyang39@huawei.com,
 liulongfang@huawei.com, qianweili@huawei.com
Subject: Re: [PATCH RFC 4/4] arm64/io: Add {__raw_read|__raw_write}128
 support
Message-ID: <20251112140157.24ff4f2e@pumpkin>
In-Reply-To: <aRR9UesvUCFLdVoW@J2N7QTR9R3>
References: <20251112015846.1842207-1-huangchenghai2@huawei.com>
	<20251112015846.1842207-5-huangchenghai2@huawei.com>
	<aRR9UesvUCFLdVoW@J2N7QTR9R3>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 12:28:01 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Nov 12, 2025 at 09:58:46AM +0800, Chenghai Huang wrote:
> > From: Weili Qian <qianweili@huawei.com>
> >=20
> > Starting from ARMv8.4, stp and ldp instructions become atomic. =20
>=20
> That's not true for accesses to Device memory types.
>=20
> Per ARM DDI 0487, L.b, section B2.2.1.1 ("Changes to single-copy atomicit=
y in
> Armv8.4"):
>=20
>   If FEAT_LSE2 is implemented, LDP, LDNP, and STP instructions that load
>   or store two 64-bit registers are single-copy atomic when all of the
>   following conditions are true:
>   =E2=80=A2 The overall memory access is aligned to 16 bytes.
>   =E2=80=A2 Accesses are to Inner Write-Back, Outer Write-Back Normal cac=
heable memory.
>=20
> IIUC when used for Device memory types, those can be split, and a part
> of the access could be replayed multiple times (e.g. due to an
> intetrupt).

That can't be right.
IO accesses can reference hardware FIFO so must only happen once.
(Or is 'Device memory' something different from 'Device register'?
I'm also not sure that the bus cycles could get split by an interrupt,
that would require a mid-instruction interrupt - very unlikely.
Interleaving is most likely to come from another cpu.

More interesting would be whether the instructions generate a single
PCIe TLP? (perhaps even only most of the time.)
PCIe reads are high latency, anything that can be done to increase the
size of the TLP improves PIO throughput massively.

	David

>=20
> I don't think we can add this generally. It is not atomic, and not
> generally safe.
>=20
> Mark.
...

