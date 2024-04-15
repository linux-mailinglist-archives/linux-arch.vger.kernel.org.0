Return-Path: <linux-arch+bounces-3700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 837CD8A578A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4046828A693
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC09811F8;
	Mon, 15 Apr 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZN7k995"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66877F7FD;
	Mon, 15 Apr 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197969; cv=none; b=AD4ZwUfu3Wxm63ylOy0QaX1VOwRFbB9Du3loXVdwJ5/njMI7VkIKEhV0Y0ORMMWhJbUBkzrWCwo6LB5kTRFXA2qI5CA8vgG5K6Q4/q6aeZGffwR/emFjp1+WlvbGp31A4RWWGOoqRv6hVSP60W/+4ODTeurN+iz8wC7WxFk6lDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197969; c=relaxed/simple;
	bh=ceUpnS+eAL52LEzx3dIV9vtzMz89ZqI4TX/q8s7Nmhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co+/uMZpjd13WRIjhTfyK7l0+XVaXBjf9A0j6j0x6dcNUQhXy1/OE+vL+Y0JIEKJpKkMnLfnCcYPCspEhHGg7xlYph1iuHRZDV6BHA48Jy+U1BKTp1JQBRXckQPBahHordZaCESEeebtqVK0c8OgndV15yH/G6YWMQa5Ad3h1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZN7k995; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A45C32783;
	Mon, 15 Apr 2024 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197969;
	bh=ceUpnS+eAL52LEzx3dIV9vtzMz89ZqI4TX/q8s7Nmhs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YZN7k995Uxxea0cJLwZLFIVIoQ7wp4CsvNgcQEJv0/H4PEK0Rj6G6ExZxAU5C2HZ9
	 oetjXZtceZ0YEAvUxjxRwLvZYaJPbdijx0hAxdZEqI/RmU2mkVjdkegWRU67E9DiVT
	 7nt7RCMikPwEBCK2HXe1kb6XWUZoGtkxnZwBj4DrXQL7BEqP87amqLDJ3tjA5Etmsk
	 vuXruQZFUlOY8T5lDQ0klKgSJEEzwHGOTueOQ+F49KRvkMlM8WOjqotu/EkKMUxBfN
	 yS6Hp96ZLU0ez8Yb3Y7Qwmuy0/Qbh7vCV6fGTkkQ5lXMzWxQslMwxSU9nne9ShPxgT
	 KFFnVCiW9bcmA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a9ef9ba998so909881eaf.1;
        Mon, 15 Apr 2024 09:19:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWV44e5W19QNmWFEKDZAZ+gBg/Kr1J/Xx641P91JrFsbt+ACE1zMbTGRrP79sCxHLPBpTIdom8KXmgHcNCf9sIWr7r3gpJjTccaOHcMx3K+kWlkMv45ylRlGpyrtAUgp9p+5LA/U/IZEOKUim9iMVsvW6flDacYhLqNMFZ4FHLEh4VmdClQIVoePRT72YmJUs8LCpqWiudsINToV9rkkw==
X-Gm-Message-State: AOJu0YzdAOaEhP8vf2Aa7csFQNGhMjQxT+jnPrPlUt8+1rUL4Qol34ws
	UU9iUlkcdL3AYDkUaVYXmT5BpRGJJznbXRMaxoH8rji7Cu2/LD1wlDfrm5vGCZqnSAjdR54ELxt
	fb0onMVgnbeDC79Jccf9Swz5ArRM=
X-Google-Smtp-Source: AGHT+IEqVqP3R2NEru8EpAnjfDnRpGPI8UMTqjQFs9k8o4nbg9Pkjqx5SymZn5/1h9ERQuYB6gnaTH60Zk0fAGLxeMg=
X-Received: by 2002:a05:6870:9a97:b0:22e:514f:cd11 with SMTP id
 hp23-20020a0568709a9700b0022e514fcd11mr11036260oab.1.1713197968510; Mon, 15
 Apr 2024 09:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-3-Jonathan.Cameron@huawei.com> <CAJZ5v0izN5naWY7sTi16whds9ubXkLpgqV2gePQs869BoJTCDA@mail.gmail.com>
 <20240415164854.0000264f@Huawei.com> <CAJZ5v0hd+CNsnH9xY+UX0iy_AEaqUqJj4KdR=+yvtvy5FQEy5Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hd+CNsnH9xY+UX0iy_AEaqUqJj4KdR=+yvtvy5FQEy5Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 18:19:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j6gMaHamrCvrF8s+SgC0QVtG+naXhA4Dwg0t1YJvh4Uw@mail.gmail.com>
Message-ID: <CAJZ5v0j6gMaHamrCvrF8s+SgC0QVtG+naXhA4Dwg0t1YJvh4Uw@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] ACPI: processor: Set the ACPI_COMPANION for the
 struct cpu instance
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linuxarm@huawei.com, 
	justin.he@arm.com, jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 6:16=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Apr 15, 2024 at 5:49=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 12 Apr 2024 20:10:54 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > On Fri, Apr 12, 2024 at 4:38=E2=80=AFPM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > >
> > > > The arm64 specific arch_register_cpu() needs to access the _STA
> > > > method of the DSDT object so make it available by assigning the
> > > > appropriate handle to the struct cpu instance.
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  drivers/acpi/acpi_processor.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proc=
essor.c
> > > > index 7a0dd35d62c9..93e029403d05 100644
> > > > --- a/drivers/acpi/acpi_processor.c
> > > > +++ b/drivers/acpi/acpi_processor.c
> > > > @@ -235,6 +235,7 @@ static int acpi_processor_get_info(struct acpi_=
device *device)
> > > >         union acpi_object object =3D { 0 };
> > > >         struct acpi_buffer buffer =3D { sizeof(union acpi_object), =
&object };
> > > >         struct acpi_processor *pr =3D acpi_driver_data(device);
> > > > +       struct cpu *c;
> > > >         int device_declaration =3D 0;
> > > >         acpi_status status =3D AE_OK;
> > > >         static int cpu0_initialized;
> > > > @@ -314,6 +315,8 @@ static int acpi_processor_get_info(struct acpi_=
device *device)
> > > >                         cpufreq_add_device("acpi-cpufreq");
> > > >         }
> > > >
> > > > +       c =3D &per_cpu(cpu_devices, pr->id);
> > > > +       ACPI_COMPANION_SET(&c->dev, device);
> > >
> > > This is also set for per_cpu(cpu_sys_devices, pr->id) in
> > > acpi_processor_add(), via acpi_bind_one().
> >
> > Hi Rafael,
> >
> > cpu_sys_devices gets filled with a pointer to this same structure.
> > The contents gets set in register_cpu() so at this point
> > it doesn't point anywhere.  As a side note register_cpu()
> > memsets to zero the value I set it to in the code above which isn't
> > great, particularly as I want to use this in post_eject for
> > arm64.
> >
> > We could make a copy of the handle and put it back after
> > the memset in register_cpu() but that is also ugly.
> > It's the best I've come up with to make sure this is still set
> > come remove time but is rather odd.
> > >
> > > Moreover, there is some pr->id validation in acpi_processor_add(), so
> > > it seems premature to use it here this way.
> > >
> > > I think that ACPI_COMPANION_SET() should be called from here on
> > > per_cpu(cpu_sys_devices, pr->id) after validating pr->id (so the
> > > pr->id validation should all be done here) and then NULL can be passe=
d
> > > as acpi_dev to acpi_bind_one() in acpi_processor_add().  Then, there
> > > will be one physical device corresponding to the processor ACPI devic=
e
> > > and no confusion.
> >
> > I'm fairly sure this is pointing to the same device but agreed this
> > is a tiny bit confusing. However we can't use cpu_sys_devices at this p=
oint
> > so I'm not immediately seeing a cleaner solution :(
>
> Well, OK.
>
> Please at least consider doing the pr->id validation checks before
> setting the ACPI companion for &per_cpu(cpu_devices, pr->id).
>
> Also, acpi_bind_one() needs to be called on the "physical" devices
> passed to ACPI_COMPANION_SET() (with NULL as the second argument) for
> the reference counting and physical device lookup to work.
>
> Please also note that acpi_primary_dev_companion() should return
> per_cpu(cpu_sys_devices, pr->id) for the processor ACPI device, which
> depends on the order of acpi_bind_one() calls involving the same ACPI
> device.

Of course, if the value set by ACPI_COMPANION_SET() is cleared
subsequently, the above is not needed, but then using
ACPI_COMPANION_SET() is questionable overall.

