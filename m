Return-Path: <linux-arch+bounces-3713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB18A595A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 19:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B34C1F23115
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BFA13A411;
	Mon, 15 Apr 2024 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOoyc7NQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F912C46D;
	Mon, 15 Apr 2024 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202916; cv=none; b=TEFnpP4ERCqjXe6kwDGX0nAr7lzQ+ec/cTjQe5s7oUbq5jQpXgiVhS6ssnh6Wd9gnLIHz8BrMcbA27RgEE7tbhDTkmDV9Bz1+lwFE/8i4Lg5rQu6ZaDVm+8uRlfZLk4xTYMY/U9hBpr9TphHoqEYWhL+LEIsKl8m7Mr+Xt353zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202916; c=relaxed/simple;
	bh=Nd+cGKqlC3U+o3R2XM4AQmLSXWv3wXIXsvzYcQ1+Mo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePShuOebNdOIq9FZGCeP6BhrCuT1deO0ziIoWIQUgMSwl3cg9z7fR4uP5Hx1TxLqnvM7h5cNgpRVRfcv1qmJmWj5MGszMQd3IRNeV6Ll9KAqurjvoaxxinKIUjgqWM+sf8TNAwl7XaYEZ3df0DKPWdn8QzWI8KkzPo0RUYr8f70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOoyc7NQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DEEC113CC;
	Mon, 15 Apr 2024 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713202916;
	bh=Nd+cGKqlC3U+o3R2XM4AQmLSXWv3wXIXsvzYcQ1+Mo0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kOoyc7NQkGPD3Do4tYzA2emGxOggCq9DabYmVX3J7MyZIH4S5cg5igbZI1WOG1KxG
	 ChUhfLglw54vaJijOyY9eV4L96p3pdTIwMCCDbWRV8IJrmW/BK/qsU8kDnDli7Ghln
	 xc08XuSEBl20zaRIqJHnr30EUV7BhGVMB1AekS0i74CDTpzDs+EcSceggZF5qLpJNO
	 xy2IJ8mbugGVf/guxHY7Xi64GOQygXV3wgeDGLdEMaavSw7gTSbD/Z26kjCRQ8sZUj
	 qwMymy/wMGb9uodV998OzR6OPpnvybgKqFA+fOCmLbN5d9fpfAKtW3QI23dO/D8/os
	 gLK5S4BPIjPrg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22ec8db3803so373374fac.1;
        Mon, 15 Apr 2024 10:41:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUbmHwVBrPusjWCoOQ8A9Uwh9JFES4bGDg2mMVyJCrgDAWWPf0kQoCL+f9Fo/ApXmMuj08JF8NGteEnRnUo8n6Fuh/MoZDFe/hrsN3hCNBJ3/Ulay+uylrx3tRHY3ZBmSAmyK+oMpZH3kdKmv6JoyOQAKnKCbDlk40vMLG3fzC+UQF90lsvEMWJgF+HgaxR180fK7tmjOeyKZoGhJSNg==
X-Gm-Message-State: AOJu0YxEde9rFLe6KzDGjJxrdKVhKlIfO3FMIpYzvyNrJjgeWuERuOaD
	7FcXg3bMeLORm8ZBcqxqZCl0zg2geNK/M7enpVtGEQuWOuyPbC6OSzVqg5yNyXJA/PiZbkLESrx
	rUUv5Ps8SkBNPRc0A27liTEUwVIw=
X-Google-Smtp-Source: AGHT+IFHL4CUA1EFC34zPjAiEkPOGMU0WfbEyDRpxS3+HBh/HZOHrvwKexgvTgQMN8REUusook+8615zLMm/41cNE1w=
X-Received: by 2002:a05:6870:32d3:b0:22e:cfdd:b32c with SMTP id
 r19-20020a05687032d300b0022ecfddb32cmr12214644oac.2.1713202915413; Mon, 15
 Apr 2024 10:41:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-3-Jonathan.Cameron@huawei.com> <CAJZ5v0izN5naWY7sTi16whds9ubXkLpgqV2gePQs869BoJTCDA@mail.gmail.com>
 <20240415164854.0000264f@Huawei.com> <CAJZ5v0hd+CNsnH9xY+UX0iy_AEaqUqJj4KdR=+yvtvy5FQEy5Q@mail.gmail.com>
 <CAJZ5v0j6gMaHamrCvrF8s+SgC0QVtG+naXhA4Dwg0t1YJvh4Uw@mail.gmail.com>
 <20240415175057.00002e11@Huawei.com> <20240415183454.000072f6@Huawei.com>
In-Reply-To: <20240415183454.000072f6@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 19:41:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0huAAa5UpK4kqR-Uz4ALfY-wQ-gv7CC8C-kx9UDFvCgUw@mail.gmail.com>
Message-ID: <CAJZ5v0huAAa5UpK4kqR-Uz4ALfY-wQ-gv7CC8C-kx9UDFvCgUw@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] ACPI: processor: Set the ACPI_COMPANION for the
 struct cpu instance
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linuxarm@huawei.com, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, justin.he@arm.com, jianyong.wu@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 7:35=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 15 Apr 2024 17:50:57 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Mon, 15 Apr 2024 18:19:17 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > On Mon, Apr 15, 2024 at 6:16=E2=80=AFPM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Mon, Apr 15, 2024 at 5:49=E2=80=AFPM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Fri, 12 Apr 2024 20:10:54 +0200
> > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > >
> > > > > > On Fri, Apr 12, 2024 at 4:38=E2=80=AFPM Jonathan Cameron
> > > > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > > > >
> > > > > > > The arm64 specific arch_register_cpu() needs to access the _S=
TA
> > > > > > > method of the DSDT object so make it available by assigning t=
he
> > > > > > > appropriate handle to the struct cpu instance.
> > > > > > >
> > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > > ---
> > > > > > >  drivers/acpi/acpi_processor.c | 3 +++
> > > > > > >  1 file changed, 3 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acp=
i_processor.c
> > > > > > > index 7a0dd35d62c9..93e029403d05 100644
> > > > > > > --- a/drivers/acpi/acpi_processor.c
> > > > > > > +++ b/drivers/acpi/acpi_processor.c
> > > > > > > @@ -235,6 +235,7 @@ static int acpi_processor_get_info(struct=
 acpi_device *device)
> > > > > > >         union acpi_object object =3D { 0 };
> > > > > > >         struct acpi_buffer buffer =3D { sizeof(union acpi_obj=
ect), &object };
> > > > > > >         struct acpi_processor *pr =3D acpi_driver_data(device=
);
> > > > > > > +       struct cpu *c;
> > > > > > >         int device_declaration =3D 0;
> > > > > > >         acpi_status status =3D AE_OK;
> > > > > > >         static int cpu0_initialized;
> > > > > > > @@ -314,6 +315,8 @@ static int acpi_processor_get_info(struct=
 acpi_device *device)
> > > > > > >                         cpufreq_add_device("acpi-cpufreq");
> > > > > > >         }
> > > > > > >
> > > > > > > +       c =3D &per_cpu(cpu_devices, pr->id);
> > > > > > > +       ACPI_COMPANION_SET(&c->dev, device);
> > > > > >
> > > > > > This is also set for per_cpu(cpu_sys_devices, pr->id) in
> > > > > > acpi_processor_add(), via acpi_bind_one().
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > cpu_sys_devices gets filled with a pointer to this same structure=
.
> > > > > The contents gets set in register_cpu() so at this point
> > > > > it doesn't point anywhere.  As a side note register_cpu()
> > > > > memsets to zero the value I set it to in the code above which isn=
't
> > > > > great, particularly as I want to use this in post_eject for
> > > > > arm64.
> > > > >
> > > > > We could make a copy of the handle and put it back after
> > > > > the memset in register_cpu() but that is also ugly.
> > > > > It's the best I've come up with to make sure this is still set
> > > > > come remove time but is rather odd.
> > > > > >
> > > > > > Moreover, there is some pr->id validation in acpi_processor_add=
(), so
> > > > > > it seems premature to use it here this way.
> > > > > >
> > > > > > I think that ACPI_COMPANION_SET() should be called from here on
> > > > > > per_cpu(cpu_sys_devices, pr->id) after validating pr->id (so th=
e
> > > > > > pr->id validation should all be done here) and then NULL can be=
 passed
> > > > > > as acpi_dev to acpi_bind_one() in acpi_processor_add().  Then, =
there
> > > > > > will be one physical device corresponding to the processor ACPI=
 device
> > > > > > and no confusion.
> > > > >
> > > > > I'm fairly sure this is pointing to the same device but agreed th=
is
> > > > > is a tiny bit confusing. However we can't use cpu_sys_devices at =
this point
> > > > > so I'm not immediately seeing a cleaner solution :(
> > > >
> > > > Well, OK.
> > > >
> > > > Please at least consider doing the pr->id validation checks before
> > > > setting the ACPI companion for &per_cpu(cpu_devices, pr->id).
> > > >
> > > > Also, acpi_bind_one() needs to be called on the "physical" devices
> > > > passed to ACPI_COMPANION_SET() (with NULL as the second argument) f=
or
> > > > the reference counting and physical device lookup to work.
> > > >
> > > > Please also note that acpi_primary_dev_companion() should return
> > > > per_cpu(cpu_sys_devices, pr->id) for the processor ACPI device, whi=
ch
> > > > depends on the order of acpi_bind_one() calls involving the same AC=
PI
> > > > device.
> > >
> > > Of course, if the value set by ACPI_COMPANION_SET() is cleared
> > > subsequently, the above is not needed, but then using
> > > ACPI_COMPANION_SET() is questionable overall.
> >
> > Agreed + smoothing over that by stashing and putting it back doesn't
> > work because there is an additional call to acpi_bind_one() inbetween
> > here and the one you reference.
> >
> > The arch_register_cpu() calls end up calling register_cpu() /
> > device_register() / acpi_device_notify() / acpi_bind_one()
> >
> > With current code that fails (silently)

And that's why there is an explicit acpi_bind_one() invocation in
acpi_processor_add().

> > If I make sure the handle is set before register_cpu() then it
> > succeeds, but we end up with duplicate sysfs files etc because we
> > bind twice.

Right, I should have recalled that earlier.

> > I think the only way around this is larger reorganization of the
> > CPU hotplug code to pull the arch_register_cpu() call to where
> > the acpi_bind_one() call is.  However that changes a lot more than I'd =
like
> > (and I don't have it working yet).

I see.

> > Alternatively find somewhere else to stash the handle, or just add it a=
s
> > a parameter to arch_register_cpu(). Right now this feels the easier
> > path to me. arch_register_cpu(int cpu, acpi_handle handle)
> >
> > Would that be a path you'd consider?
>
> Another option would be to do the per_cpu(processors, pr->id) =3D pr
> a few lines earlier than currently and access that directly from the
> arch_register_cpu() call.  Similarly remove that reference a bit later an=
d
> use it in arch_unregister_cpu().
>
> This seems like the simplest solution, but I may be missing something.

This should work AFAICS, but I'd move the entire piece of code between
BUG_ON() and setting per_cpu(processors, pr->id) inclusive:

    BUG_ON(pr->id >=3D nr_cpu_ids);

    /*
     * Buggy BIOS check.
     * ACPI id of processors can be reported wrongly by the BIOS.
     * Don't trust it blindly
     */
    if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
        per_cpu(processor_device_array, pr->id) !=3D device) {
        dev_warn(&device->dev,
            "BIOS reported wrong ACPI id %d for the processor\n",
            pr->id);
        /* Give up, but do not abort the namespace scan. */
        goto err;
    }
    /*
     * processor_device_array is not cleared on errors to allow buggy BIOS
     * checks.
     */
    per_cpu(processor_device_array, pr->id) =3D device;
    per_cpu(processors, pr->id) =3D pr;

into acpi_processor_get_info(), right after the point where pr->id is set.

