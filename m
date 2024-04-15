Return-Path: <linux-arch+bounces-3699-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA3A8A577A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2C6289298
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D1A82481;
	Mon, 15 Apr 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btljuCii"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E768062B;
	Mon, 15 Apr 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197800; cv=none; b=Z3rEvKccooKo9iX0hZoSYKzI+JLR+mT1hxJo3kcVLJLcd4JFJ6F3gT8tv+dWQgt0Zpd3dyd4VrdE0GVIkOQzM55uFwF05/wTDOurN3YW+9O7oZ2AmYdrKQHJxnVFYaUus2VssESbT49uIQKT5NNNlGeGpRYCE00ir/YBhXzgErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197800; c=relaxed/simple;
	bh=Hs/q49qb60MQ9lAAe4xXemSwTw6fkk0SfYoTbJyFBXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8seho20nsfH3sVh7GlmyTGf+DEqkAXwclky+YakKf4ApsR+ilis1fGSP4EQPbKTGNFIzZIpu3lnIZrXRJLMojNgVeSas+5M/ie7gxLehD5tytsdZcxVCPyftSDM0NlNAuM1b4kSXNSZDy0TcX83nPPIeuLVbygtT956p/faOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btljuCii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55511C4AF0A;
	Mon, 15 Apr 2024 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713197800;
	bh=Hs/q49qb60MQ9lAAe4xXemSwTw6fkk0SfYoTbJyFBXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=btljuCiiWdQTJW7dfqzIAc7iRwxdf0AC8sj+my3GALMNqlOv43Dwpan5DYS5qLmST
	 LSIAo03teu1vXjyowKxAbEop5Iex5fXyUTDwpk8rdWCCyb7042GJJONQqVcfhjvX63
	 n9bkdcVVURuwXmDook5W60z+hx8k767W4p8cxeoBcPXf0hv3qofHJAsgI/Ymf6bYxM
	 2IFf5TeTQ/4hKHNWY2+eJ28l0jxKecULKAcK5h/Fr+V3NIm5dQMPaNnuEI2P8VKylV
	 qn7gcP4hcxBLKAShiXsT8kuWIgqrw36DCEslqrVf2BsxQr9TVn3e6u9oEtjy7gX1dj
	 FPHzN7fYOAMvQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa327a5514so593626eaf.0;
        Mon, 15 Apr 2024 09:16:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUS23cO2TcjyQif0de0m6FB8G4/P1XCRt73PFq/08dPUnTZQmVGDaX4jIZyfdDvz/dK0lZymP2+zrfHHcXgBvn01Ym+LdnaCT2S5g5Kwd/KChmL9dsZMDHJhi29KUUGCvYWmel/DEcjfJdbVdzgVcZXc9q/wEikKQe8YkWEzPe+sVjiok+/TyGP1Gpfhz3+f77zjUuW92ETuJtgmezKCA==
X-Gm-Message-State: AOJu0Ywr+iIM1zkjY3fQir89qQDqp1PI3jQ0vpAJtVFYyM6LQyckGm+p
	Nfb83Pjn3pQ95iJBxfbg5Ql3ugoyRFDDRtCqEhz21tNJSm+Di5S8dTPb9ls1yZOeX38MkZfr5AJ
	KnnHmSvc0O49hbED4xJobkIKLu0M=
X-Google-Smtp-Source: AGHT+IFfwQFWHYDwwvCKgMxQECCk6RQ2kJ/daxbr7Nx3CWpOEdn6mrSGfGG7iuqV1kOEiKYzgFgiPWVdDd9bL9zcm4k=
X-Received: by 2002:a05:6870:5248:b0:220:bd4d:674d with SMTP id
 o8-20020a056870524800b00220bd4d674dmr11333403oai.5.1713197799419; Mon, 15 Apr
 2024 09:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-3-Jonathan.Cameron@huawei.com> <CAJZ5v0izN5naWY7sTi16whds9ubXkLpgqV2gePQs869BoJTCDA@mail.gmail.com>
 <20240415164854.0000264f@Huawei.com>
In-Reply-To: <20240415164854.0000264f@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 18:16:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hd+CNsnH9xY+UX0iy_AEaqUqJj4KdR=+yvtvy5FQEy5Q@mail.gmail.com>
Message-ID: <CAJZ5v0hd+CNsnH9xY+UX0iy_AEaqUqJj4KdR=+yvtvy5FQEy5Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] ACPI: processor: Set the ACPI_COMPANION for the
 struct cpu instance
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Mon, Apr 15, 2024 at 5:49=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 12 Apr 2024 20:10:54 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Fri, Apr 12, 2024 at 4:38=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > The arm64 specific arch_register_cpu() needs to access the _STA
> > > method of the DSDT object so make it available by assigning the
> > > appropriate handle to the struct cpu instance.
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/acpi/acpi_processor.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proces=
sor.c
> > > index 7a0dd35d62c9..93e029403d05 100644
> > > --- a/drivers/acpi/acpi_processor.c
> > > +++ b/drivers/acpi/acpi_processor.c
> > > @@ -235,6 +235,7 @@ static int acpi_processor_get_info(struct acpi_de=
vice *device)
> > >         union acpi_object object =3D { 0 };
> > >         struct acpi_buffer buffer =3D { sizeof(union acpi_object), &o=
bject };
> > >         struct acpi_processor *pr =3D acpi_driver_data(device);
> > > +       struct cpu *c;
> > >         int device_declaration =3D 0;
> > >         acpi_status status =3D AE_OK;
> > >         static int cpu0_initialized;
> > > @@ -314,6 +315,8 @@ static int acpi_processor_get_info(struct acpi_de=
vice *device)
> > >                         cpufreq_add_device("acpi-cpufreq");
> > >         }
> > >
> > > +       c =3D &per_cpu(cpu_devices, pr->id);
> > > +       ACPI_COMPANION_SET(&c->dev, device);
> >
> > This is also set for per_cpu(cpu_sys_devices, pr->id) in
> > acpi_processor_add(), via acpi_bind_one().
>
> Hi Rafael,
>
> cpu_sys_devices gets filled with a pointer to this same structure.
> The contents gets set in register_cpu() so at this point
> it doesn't point anywhere.  As a side note register_cpu()
> memsets to zero the value I set it to in the code above which isn't
> great, particularly as I want to use this in post_eject for
> arm64.
>
> We could make a copy of the handle and put it back after
> the memset in register_cpu() but that is also ugly.
> It's the best I've come up with to make sure this is still set
> come remove time but is rather odd.
> >
> > Moreover, there is some pr->id validation in acpi_processor_add(), so
> > it seems premature to use it here this way.
> >
> > I think that ACPI_COMPANION_SET() should be called from here on
> > per_cpu(cpu_sys_devices, pr->id) after validating pr->id (so the
> > pr->id validation should all be done here) and then NULL can be passed
> > as acpi_dev to acpi_bind_one() in acpi_processor_add().  Then, there
> > will be one physical device corresponding to the processor ACPI device
> > and no confusion.
>
> I'm fairly sure this is pointing to the same device but agreed this
> is a tiny bit confusing. However we can't use cpu_sys_devices at this poi=
nt
> so I'm not immediately seeing a cleaner solution :(

Well, OK.

Please at least consider doing the pr->id validation checks before
setting the ACPI companion for &per_cpu(cpu_devices, pr->id).

Also, acpi_bind_one() needs to be called on the "physical" devices
passed to ACPI_COMPANION_SET() (with NULL as the second argument) for
the reference counting and physical device lookup to work.

Please also note that acpi_primary_dev_companion() should return
per_cpu(cpu_sys_devices, pr->id) for the processor ACPI device, which
depends on the order of acpi_bind_one() calls involving the same ACPI
device.

