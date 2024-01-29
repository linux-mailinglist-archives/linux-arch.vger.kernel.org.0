Return-Path: <linux-arch+bounces-1773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46584094A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54AB28B552
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F84153500;
	Mon, 29 Jan 2024 15:05:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C461534FA;
	Mon, 29 Jan 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540756; cv=none; b=BlTqYCNVkxatawn0jsvXkH0NOKXRJVJQUru+vHACrFOYlw3VKycmxn41v8TLVyZy80nK27VMYGCrK35PxToAgSd0dsVsWKPE6YgsLvuHNdPsiKS7fEsDggGbCcRr+5FVPsB/T0xXKynTOBk8J6nhUthTwOXYHYsIveqlOCmtmBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540756; c=relaxed/simple;
	bh=q6I0vmpSP+EMAN7W7TMgr8TqOcKWKp2AWgbxZCoyOoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jshDNDuXyMa6IjBPRyZsbT5mW1WKGMJa5plJtQW1BQf4/9dSsAbrxH1ciqcJzZwl1+Kom0Kqor3+7S3V+yNJkugESGDile7P/tqhHaZed/qyp2bK1JqHM/GPxE0hNHZPgUJFhvTQsviiatpFtx+yDia5dywNbrieETJvoWx42qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5958d3f2d8aso366388eaf.1;
        Mon, 29 Jan 2024 07:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540754; x=1707145554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkpAjVvacpcOYBIZJzTULHFzBo21BcPnaUhokGVxGPM=;
        b=PMHpL80aiNTB4ZvOmet2EYAuO6Flfy9141JhM5N3Ummz/dDXwURf4bASPc1qeR2yJE
         a4NhOIuROgiJ4gA6IA8RrynZYdKxL8LCvvFTQbliG3aXiI+uyJYBc1Cyq33+pAQ/z9Bj
         dpBwiLH8fQZLe35za1edbynpQ+Qhv4524XM8S1w3AgKLEubxIbLakMZPw6vT/ydt+DK8
         QtSkS77Td4qdfKCcuEfxz3hS02YbmpvGPizkAQwfegs4GtDgPdg1m0MYesRfvA3A/QCC
         JiBmHSLFIi1GdjN7ABmy5tAdNxkftNge1xmGSUfzSE0rNNcMAq39rdQDnSStA7K6+kW8
         DXLQ==
X-Gm-Message-State: AOJu0Yxuk9ZpxzMuQXKzTXox41y8h4cz6jObDkWB14/QcJnxSKpEw4VZ
	yYjUCv1YlapoMsaRph1JlGyJPMAX5WRRe7HxrJtry2iiAVpegOdDaLcsb0NGuPpzUG91n/ZpKKP
	Njqg03uSDVtJz5BtSwE29ksegdlE=
X-Google-Smtp-Source: AGHT+IEoV4wd4p7kTQOJWXxXpqTUH+qihI2/dlN0Po7tPQqbaCmtMIoU00Uv7+V2Gh58aCyndi1c4Fekk9NhHFrJKEg=
X-Received: by 2002:a4a:c48a:0:b0:599:fbcc:1c75 with SMTP id
 f10-20020a4ac48a000000b00599fbcc1c75mr6541388ooq.0.1706540754026; Mon, 29 Jan
 2024 07:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
 <20231215161539.00000940@Huawei.com> <5760569.DvuYhMxLoT@kreacher>
 <20240102143925.00004361@Huawei.com> <20240111101949.000075dc@Huawei.com>
 <ZZ/CR/6Voec066DR@shell.armlinux.org.uk> <20240112115205.000043b0@Huawei.com> <Zbe8WQRASx6D6RaG@shell.armlinux.org.uk>
In-Reply-To: <Zbe8WQRASx6D6RaG@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 16:05:42 +0100
Message-ID: <CAJZ5v0iba93EhQB2k3LMdb2YczndbRmF5WGRYHhnqCHq6TQJ0A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional) devices
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:55=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Hi Jonathan,
>
> On Fri, Jan 12, 2024 at 11:52:05AM +0000, Jonathan Cameron wrote:
> > On Thu, 11 Jan 2024 10:26:15 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > @@ -2381,16 +2388,38 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependencies=
);
> > >   * acpi_dev_ready_for_enumeration - Check if the ACPI device is read=
y for enumeration
> > >   * @device: Pointer to the &struct acpi_device to check
> > >   *
> > > - * Check if the device is present and has no unmet dependencies.
> > > + * Check if the device is functional or enabled and has no unmet dep=
endencies.
> > >   *
> > > - * Return true if the device is ready for enumeratino. Otherwise, re=
turn false.
> > > + * Return true if the device is ready for enumeration. Otherwise, re=
turn false.
> > >   */
> > >  bool acpi_dev_ready_for_enumeration(const struct acpi_device *device=
)
> > >  {
> > >     if (device->flags.honor_deps && device->dep_unmet)
> > >             return false;
> > >
> > > -   return acpi_device_is_present(device);
> > > +   /*
> > > +    * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to ret=
urn
> > > +    * (!present && functional) for certain types of devices that sho=
uld be
> > > +    * enumerated. Note that the enabled bit should not be set unless=
 the
> > > +    * present bit is set.
> > > +    *
> > > +    * However, limit this only to processor devices to reduce possib=
le
> > > +    * regressions with firmware.
> > > +    */
> > > +   if (device->status.functional)
> > > +           return true;
>
> I have a report from within Oracle that this causes testing failures
> with QEMU using -smp cpus=3D2,maxcpus=3D4. I think it needs to be:
>
>         if (!device->status.present)
>                 return device->status.functional;
>
>         if (device->status.enabled)
>                 return true;
>
>         return !acpi_device_is_processor(device);

The above is fine by me.

> So we can better understand the history here, let's list it as a
> truth table. P=3Dpresent, F=3Dfunctional, E=3Denabled, Orig=3Dhow the cod=
e
> is in mainline, James=3DJames' original proposal, Rafael=3Dthe proposed
> replacement but seems to be buggy, Rmk=3Dthe fixed version that passes
> tests:
>
> P F E   Orig    James   Rafael          Rmk
> 0 0 0   0       0       0               0
> 0 0 1   0       0       0               0
> 0 1 0   1       1       1               1
> 0 1 1   1       0       1               1
> 1 0 0   1       0       !processor      !processor
> 1 0 1   1       1       1               1
> 1 1 0   1       0       1               !processor
> 1 1 1   1       1       1               1
>
> Any objections to this?

So AFAIAC it can return false if not enabled, but present and
functional.  [Side note: I'm wondering what "functional" means then,
but whatever.]

