Return-Path: <linux-arch+bounces-1776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7A840A28
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C061C21843
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390AE15443C;
	Mon, 29 Jan 2024 15:35:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A005153BC6;
	Mon, 29 Jan 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542511; cv=none; b=WNZe8QnOueebGLiCLsUHDh/gAPij+saLCPTwhCKdsxkGznywMLtxE6w5ScOW4hjf/V4HyN/2mqVCjRwo0prC16oKNvBE8Pd4AqBt7tnKdgjUJYHEcCqO1RkMCbpG3FqMIqoBiPxcbFf3gEWV3/k2RRMAVP7lwKn5sU5UzUWszfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542511; c=relaxed/simple;
	bh=oqnGdtTv/k7O49UAKeLaHEMigeXSQOzpobeqbQwsRC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPLC4zhtyD4bU50kQ5nQKdGp9+5+fo5d5TJ5aRxiheqn2QQKb+GvBSYu9K2H4RRkuKkSXUdxu4oz9DRHxOKmlMySBZFJnqG32noFb8rFGiMUMl5G2YkvQ/ReVPNa6bzyq+pjsQDKs420imoenUeTntTcIb8uoUorvWjokVcguNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-210cd12fae2so25259fac.0;
        Mon, 29 Jan 2024 07:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706542508; x=1707147308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG+8XeCHdsIlnW4L47AUTukqeea8Ay75J0VzHSz+j7A=;
        b=Twa9prJe/xBthuLdZL8KpXHwppEh7BLCz6JGLBRsCNNLLjxF39VqYtZ2F2R5h+YEpr
         Gt6/me2moiVq0hPU2hNf+a9COMR1bLm+5J6zGm6NFf9xi+X4qOEmlPfZm5wXrdouxNvz
         +FI769+JpwDznPPZZ13kYDSfxUh0MwPH2rmtCzon6QGEtRMJCslxqcQeqDlN0SqEopgB
         gcVBxuu8CPd9v8ceVp3tkjQMSVmx7+/ZrJdNC66cuWGg0y1lDDr3aUmctu2s3Od0jgQt
         oLwWaNTTEzXEDTZs7MYHHorb3avTGz4bc23NV855AP8EAtjYlx5Pik3+E7vn972jJoHs
         lQZg==
X-Forwarded-Encrypted: i=0; AJvYcCWivtAILoZlBgyc8Hp0ORscZpsAnxqYMh/fjI5p6X+eFspXzltgbFcJn+aLewMld/OHzT6lLVJmgdQteGngui6Jm4Wx5cXCwLmF+BLAKQiccmNfQWjPheCfsJTmNAAo9/W6+FCp5kNAK9v7qkGTbqlhghnwhyp3SR498xZsQa+Ad9lfpvlH8gdPlcjTfXnyojvhfpeMGBGmo+mhx9OWJ7es/Ervw5GNtxX+adYh9Z7CrCZQdGWngK18sPQFiWvcnHc8PgRgqNts2mBGkkBfOxIjsiWsW49LI6otzGfK2t736aK6iTqqQgwb+OP/Pdyzg4D8T3bd+kIItrrJ3XaJcx8eLkv6n1Clw3bd/oRaug7g
X-Gm-Message-State: AOJu0YzTLLTp9Lnb0CkAwCS2FdUSWTg8RDFNyM8Z/AhT2jLTf5O2DZO/
	dm79IWnfNajpDMPwzIhXeJxWxsl/xpSCcWzcg5q1CCygHk4RLy6U/EawPuAn56nzeovVIyKVv5N
	B4Ulk8YS2aLBN9fcXwko46xjSbE8=
X-Google-Smtp-Source: AGHT+IHhrTU6Vx9l5tJAOVsHqvjFv8owslRWENpfX2JETljBTVS4w/It4UoW1njjPVf/6maja2wtMQZ5MonYr2C+WRA=
X-Received: by 2002:a05:6870:230d:b0:214:fddf:99f7 with SMTP id
 w13-20020a056870230d00b00214fddf99f7mr7432263oao.5.1706542508620; Mon, 29 Jan
 2024 07:35:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <ZXxxa+XZjPZtNfJ+@shell.armlinux.org.uk>
 <20231215161539.00000940@Huawei.com> <5760569.DvuYhMxLoT@kreacher>
 <20240102143925.00004361@Huawei.com> <20240111101949.000075dc@Huawei.com>
 <ZZ/CR/6Voec066DR@shell.armlinux.org.uk> <20240112115205.000043b0@Huawei.com>
 <Zbe8WQRASx6D6RaG@shell.armlinux.org.uk> <CAJZ5v0iba93EhQB2k3LMdb2YczndbRmF5WGRYHhnqCHq6TQJ0A@mail.gmail.com>
 <ZbfBYgdLzvEX/VjN@shell.armlinux.org.uk>
In-Reply-To: <ZbfBYgdLzvEX/VjN@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 16:34:57 +0100
Message-ID: <CAJZ5v0gr3ZmLY9m+rYGP36zQYNH4ohL=zbym4LS3Eq+Qt4nZLA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional) devices
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
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

On Mon, Jan 29, 2024 at 4:17=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 29, 2024 at 04:05:42PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Jan 29, 2024 at 3:55=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > Hi Jonathan,
> > >
> > > On Fri, Jan 12, 2024 at 11:52:05AM +0000, Jonathan Cameron wrote:
> > > > On Thu, 11 Jan 2024 10:26:15 +0000
> > > > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> > > > > @@ -2381,16 +2388,38 @@ EXPORT_SYMBOL_GPL(acpi_dev_clear_dependen=
cies);
> > > > >   * acpi_dev_ready_for_enumeration - Check if the ACPI device is =
ready for enumeration
> > > > >   * @device: Pointer to the &struct acpi_device to check
> > > > >   *
> > > > > - * Check if the device is present and has no unmet dependencies.
> > > > > + * Check if the device is functional or enabled and has no unmet=
 dependencies.
> > > > >   *
> > > > > - * Return true if the device is ready for enumeratino. Otherwise=
, return false.
> > > > > + * Return true if the device is ready for enumeration. Otherwise=
, return false.
> > > > >   */
> > > > >  bool acpi_dev_ready_for_enumeration(const struct acpi_device *de=
vice)
> > > > >  {
> > > > >     if (device->flags.honor_deps && device->dep_unmet)
> > > > >             return false;
> > > > >
> > > > > -   return acpi_device_is_present(device);
> > > > > +   /*
> > > > > +    * ACPI 6.5's 6.3.7 "_STA (Device Status)" allows firmware to=
 return
> > > > > +    * (!present && functional) for certain types of devices that=
 should be
> > > > > +    * enumerated. Note that the enabled bit should not be set un=
less the
> > > > > +    * present bit is set.
> > > > > +    *
> > > > > +    * However, limit this only to processor devices to reduce po=
ssible
> > > > > +    * regressions with firmware.
> > > > > +    */
> > > > > +   if (device->status.functional)
> > > > > +           return true;
> > >
> > > I have a report from within Oracle that this causes testing failures
> > > with QEMU using -smp cpus=3D2,maxcpus=3D4. I think it needs to be:
> > >
> > >         if (!device->status.present)
> > >                 return device->status.functional;
> > >
> > >         if (device->status.enabled)
> > >                 return true;
> > >
> > >         return !acpi_device_is_processor(device);
> >
> > The above is fine by me.
> >
> > > So we can better understand the history here, let's list it as a
> > > truth table. P=3Dpresent, F=3Dfunctional, E=3Denabled, Orig=3Dhow the=
 code
> > > is in mainline, James=3DJames' original proposal, Rafael=3Dthe propos=
ed
> > > replacement but seems to be buggy, Rmk=3Dthe fixed version that passe=
s
> > > tests:
> > >
> > > P F E   Orig    James   Rafael          Rmk
> > > 0 0 0   0       0       0               0
> > > 0 0 1   0       0       0               0
> > > 0 1 0   1       1       1               1
> > > 0 1 1   1       0       1               1
> > > 1 0 0   1       0       !processor      !processor
> > > 1 0 1   1       1       1               1
> > > 1 1 0   1       0       1               !processor
> > > 1 1 1   1       1       1               1
> > >
> > > Any objections to this?
> >
> > So AFAIAC it can return false if not enabled, but present and
> > functional.  [Side note: I'm wondering what "functional" means then,
> > but whatever.]
>
> From ACPI v6.5 (bit 3 is our "status.functional":
>
>  _STA may return bit 0 clear (not present) with bit [3] set (device is
>  functional). This case is used to indicate a valid device for which no
>  device driver should be loaded (for example, a bridge device.) Children
>  of this device may be present and valid. OSPM should continue
>  enumeration below a device whose _STA returns this bit combination.
>
> So, for this case, acpi_dev_ready_for_enumeration() returning true for
> this case is correct, since we're supposed to enumerate it and child
> devices.
>
> It's probably also worth pointing out that in the above table, the two
> combinations with P=3D0 E=3D1 goes against the spec, but are included for
> completness.

The difference between the last two columns is the present and
functional, but not enabled combination AFAICS, for which my patch
just returned true, but the firmware disagrees with that.

It is kind of analogous to the "not present and functional" case
covered by the spec, which is why it is fine by me to return "false"
then (for processors), but the spec is not crystal clear about it.

