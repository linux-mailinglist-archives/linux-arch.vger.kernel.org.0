Return-Path: <linux-arch+bounces-1419-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F96836CED
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5D01C24004
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E9550A61;
	Mon, 22 Jan 2024 16:23:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0319450276;
	Mon, 22 Jan 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705940580; cv=none; b=RKJ25GmHlxp26Qcj8eYQoOLcraOG913KbiMJ65Uhxg3gJa0ZzzhhO3D7D70R7/RsIoAqgrGUZ1AAyBgesWls1jtXDM8s16FSTFPG5ZAwXBhybkw9bFNIUXspcHDQk8beXNg5KtKS4ddgc3mBYhPOdAU7AjbEailSS2bPIybYUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705940580; c=relaxed/simple;
	bh=HxG7IkgYxV45Ifv398x/WvHC2ljk6bJKTaNgioOP7ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0eZjwvggNEPcviRHXrki2JNlUKdT3o1TqL/pbwPf2W+2UG50DQ6r2whLDqKXL4fwh+x+Gb2XXNKQnOZO2rt9CRzcH7TTKKholdt2JR1tqAwqbUNWZvdRDJR6bq5mhtn2e7eMd4NpGOVjTTYwocGETY185/nPkzPC4X1i2TrWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-20475bf35a2so107839fac.1;
        Mon, 22 Jan 2024 08:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705940578; x=1706545378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeqYwsAig8OM8+vknifuJYP2AzBgf+u+iQafy2tdxVA=;
        b=MGjTXjg3/F/TOA5Hxx1OZ6rPP4oCtLd1vcwt2APgNMFG6p8H5ClitprX5iSieg0Kav
         xcrXBSNA+WIJ1Mp5726BhH3Dm0OrGOjLjjSPFym21QuWtLJi1bGyDOms7W3usdIz5vm1
         EpnxS51ipDgK8Cg8y9uj9ZKL2CYLEcPxYBmAYUXj2vjGIlHvjtf4zFW/qPT23Bbp/4wT
         xa/aU3NUq00a1FtuJSqzt5/I5TBJS9nGpFs9lZ7hwDeqETvEnPxeGUA6qhkqvwmBaPE9
         PjQOCCWrReponx/KByk3j+yCRUMlHY8Bsn+1AU4YvkFsdY93mkyyp8NWkGaH6diYqzZO
         HPHw==
X-Gm-Message-State: AOJu0YxBZk4v3xT2hLhPlIqyQveOwQSG2hB5aF1wVGteSmY4fxZWFwYo
	iFZ5FwWDgxmzOFJ5IO3XJHX38MW/sbBWYz2flBK1t93NMgliG4jQlHix8HK5zb0NNm/hVtpY1I+
	4/iiRA1XY7oQthc0/gM7nfk7WYzc=
X-Google-Smtp-Source: AGHT+IFuHJXu5mAxkwobVQKGd/S4EJuqPyP21RbRV5V/lpmKFOP7N2htShcxq/NrWRpDaEz7nw7KbFO1kuk4zNCgfuM=
X-Received: by 2002:a05:6870:7009:b0:213:7249:3fb0 with SMTP id
 u9-20020a056870700900b0021372493fb0mr6379169oae.5.1705940577897; Mon, 22 Jan
 2024 08:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
 <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
 <ZaURtUvWQyjYfiiO@shell.armlinux.org.uk> <20240122160227.00002d83@Huawei.com>
In-Reply-To: <20240122160227.00002d83@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jan 2024 17:22:46 +0100
Message-ID: <CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, 
	acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org, 
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, justin.he@arm.com, 
	James Morse <james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:02=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 15 Jan 2024 11:06:29 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>
> > On Mon, Dec 18, 2023 at 09:22:03PM +0100, Rafael J. Wysocki wrote:
> > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@arml=
inux.org.uk> wrote:
> > > >
> > > > From: James Morse <james.morse@arm.com>
> > > >
> > > > ACPI has two descriptions of CPUs, one in the MADT/APIC table, the =
other
> > > > in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processo=
rs"
> > > > says "Each processor in the system must be declared in the ACPI
> > > > namespace"). Having two descriptions allows firmware authors to get
> > > > this wrong.
> > > >
> > > > If CPUs are described in the MADT/APIC, they will be brought online
> > > > early during boot. Once the register_cpu() calls are moved to ACPI,
> > > > they will be based on the DSDT description of the CPUs. When CPUs a=
re
> > > > missing from the DSDT description, they will end up online, but not
> > > > registered.
> > > >
> > > > Add a helper that runs after acpi_init() has completed to register
> > > > CPUs that are online, but weren't found in the DSDT. Any CPU that
> > > > is registered by this code triggers a firmware-bug warning and kern=
el
> > > > taint.
> > > >
> > > > Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotpl=
ug
> > > > is configured.
> > >
> > > So why is this a kernel problem?
> >
> > So what are you proposing should be the behaviour here? What this
> > statement seems to be saying is that QEMU as it exists today only
> > describes the first CPU in DSDT.
>
> This confuses me somewhat, because I'm far from sure which machines this
> is true for in QEMU.  I'm guessing it's a legacy thing with
> some old distro version of QEMU - so we'll have to paper over it anyway
> but for current QEMU I'm not sure it's true.
>
> Helpfully there are a bunch of ACPI table tests so I've been checking
> through all the multi CPU cases.
>
> CPU hotplug not enabled.
> pc/DSDT.dimmpxm  - 4x Processor entries.  -smp 4
> pc/DSDT.acpihmat - 2x Processor entries.  -smp 2
> q35/DSDT.acpihmat - 2x Processor entries. -smp 2
> virt/DSDT.acpihmatvirt - 4x ACPI0007 entries -smp 4
> q35/DSDT.acpihmat-noinitiator - 4 x Processor () entries -smp 4
> virt/DSDT.topology - 8x ACPI0007 entries
>
> I've also looked at the code and we have various types of
> CPU hotplug on x86 but they all build appropriate numbers of
> Processor() entries in DSDT.
> Arm likewise seems to build the right number of ACPI0007 entries
> (and doesn't yet have CPU HP support).
>
> If anyone can add a reference on why this is needed that would be very
> helpful.

Yes, it would.

Personally, I would prefer to assume that it is not necessary until it
turns out that (1) there is firmware with this issue actually in use
and (2) updating the firmware in question to follow the specification
is not practical.

Otherwise, we'd make it easier to ship non-compliant firmware for no
good reason.

