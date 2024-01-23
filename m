Return-Path: <linux-arch+bounces-1472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F628396B1
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 18:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27C781C20BBD
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689080047;
	Tue, 23 Jan 2024 17:44:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3FB5FDBE;
	Tue, 23 Jan 2024 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031853; cv=none; b=KIJC26CH1VTT1sa3vBmaopgaOD+FUTQ8CejFXZzSgsHEjTqj+ugoOssMZ4qOP98YkFuCyH8K4Bw8wBudjEX5psJQ0+oZeCKO2QZIzhw/F+r7fTvN9FhfWyqzp+H9ePcie4/j7zRNB/NTjVDPVZ5TkVOFVlGjS+roj87EJcHZAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031853; c=relaxed/simple;
	bh=h/fOGX9r8KCQE5Xn93RskzadT8HYnWRtaC3RKieW7lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O459PomfjLN5UzEK6eTelzHL4e4hwF0wHUKTliqh+CBgybtvL+8Vc82Qj0UZtH5FdAIR/T6bPIt1F8u3IlqAWVyCYjNqU9iizyP6WkkEyDRFRyaswdXfKW4f+6ZoKhDAUv3eKEmcz7HQRttbsCY7TVrnOs+JWItgVzW6RGASBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dfd973f3fdso447552a34.1;
        Tue, 23 Jan 2024 09:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031851; x=1706636651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kq6KcpPGxOZbbj6MD5pFvib4SOoS9hzSh6Dd/9DvrIs=;
        b=pN4xqgjb2BWWUsqDs8SQKtdy1G7rE9+6zUdYQRaggIEc5s7xICHgMVElzxY7veRF77
         PUIPQzMn5M/Ucmb5UADogrHWmfWYavV+nN5h4ayaxJR78WVYw5yI8C/2GYCcr9LN2vux
         TKm2C2E6wl8vilcd/pp2hzrv/S0uR0cok7t25L+nK4qzNIDP80Gww8PQMzJbAE7R2htu
         bpAdNljEl+jYMjDSJ6lQxPh3y2qSW8QJl84WhMAbH5ixhA7g0S2gqHJq55d9q8IdHFWe
         /PSIQ8osgY+fSqG4dgts9ufEIFGqi2va8ZJgm6Ybn4Vhlpt6AFodT5+cZlKLSNrwwmL+
         cHrw==
X-Gm-Message-State: AOJu0YyGOvAYaXs5G4dEMYMNL4sMkGtOF0JX3HRR2BWZBxPO1NUa3IfV
	d0lhBogAJg81k1XxUJ5fs+XanMtlVrUNuHPCLqJGCktzi7p0fSwzzy6ngac18lHmmEOKCMkmczd
	jKKIKR7NY/tZv5lnVwpASW3DTv3Y=
X-Google-Smtp-Source: AGHT+IEpP44JkahyRRncDJZ6FDB633whaZG3UM7wkrdtm7F6Y1fagxGT/g8CFvifyPleyOU2/X9qkHN1NII1GS6acpg=
X-Received: by 2002:a4a:d9c4:0:b0:599:6d16:353c with SMTP id
 l4-20020a4ad9c4000000b005996d16353cmr9505215oou.1.1706031851278; Tue, 23 Jan
 2024 09:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
 <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
 <20240122180013.000016d5@Huawei.com> <Za++/11n5KA1VS3p@shell.armlinux.org.uk>
 <CAJZ5v0h7wsLt8d3ZoLXsK1=crAx66T42WDKNoHcg8CiHpAjS8g@mail.gmail.com> <Za/q9jivG4OdZM0f@shell.armlinux.org.uk>
In-Reply-To: <Za/q9jivG4OdZM0f@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 18:43:59 +0100
Message-ID: <CAJZ5v0gwe02uzAQoX0QDHo35OTEozpbnqC6vukjM3aE6HMq9WQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
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

On Tue, Jan 23, 2024 at 5:36=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jan 23, 2024 at 05:15:54PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 23, 2024 at 2:28=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Mon, Jan 22, 2024 at 06:00:13PM +0000, Jonathan Cameron wrote:
> > > > On Mon, 18 Dec 2023 21:35:16 +0100
> > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > >
> > > > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@=
armlinux.org.uk> wrote:
> > > > > >
> > > > > > From: James Morse <james.morse@arm.com>
> > > > > >
> > > > > > The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to be=
come
> > > > > > present.
> > > > >
> > > > > Right.
> > > > >
> > > > > > This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> > > > > > CPUs can be taken offline as a power saving measure.
> > > > >
> > > > > But still there is the case in which a non-present CPU can become
> > > > > present, isn't it there?
> > > >
> > > > Not yet defined by the architectures (and I'm assuming it probably =
never will be).
> > > >
> > > > The original proposal we took to ARM was to do exactly that - they =
pushed
> > > > back hard on the basis there was no architecturally safe way to imp=
lement it.
> > > > Too much of the ARM arch has to exist from the start of time.
> > > >
> > > > https://lore.kernel.org/linux-arm-kernel/cbaa6d68-6143-e010-5f3c-ec=
62f879ad95@arm.com/
> > > > is one of the relevant threads of the kernel side of that discussio=
n.
> > > >
> > > > Not to put specific words into the ARM architects mouths, but the
> > > > short description is that there is currently no demand for working
> > > > out how to make physical CPU hotplug possible, as such they will no=
t
> > > > provide an architecturally compliant way to do it for virtual CPU h=
otplug and
> > > > another means is needed (which is why this series doesn't use the p=
resent bit
> > > > for that purpose and we have the Online capable bit in MADT/GICC)
> > > >
> > > > It was a 'fun' dance of several years to get to that clarification.
> > > > As another fun fact, the same is defined for x86, but I don't think
> > > > anyone has used it yet (GICC for ARM has an online capable bit in t=
he flags to
> > > > enable this, which was remarkably similar to the online capable bit=
 in the
> > > > flags of the Local APIC entries as added fairly recently).
> > > >
> > > > >
> > > > > > On arm64 an offline CPU may be disabled by firmware, preventing=
 it from
> > > > > > being brought back online, but it remains present throughout.
> > > > > >
> > > > > > Adding code to prevent user-space trying to online these disabl=
ed CPUs
> > > > > > needs some additional terminology.
> > > > > >
> > > > > > Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to re=
flect
> > > > > > that it makes possible CPUs present.
> > > > >
> > > > > Honestly, I don't think that this change is necessary or even use=
ful.
> > > >
> > > > Whilst it's an attempt to avoid future confusion, the rename is
> > > > not something I really care about so my advice to Russell is drop
> > > > it unless you are attached to it!
> > >
> > > While I agree that it isn't a necessity, I don't fully agree that it
> > > isn't useful.
> > >
> > > One of the issues will be that while Arm64 will support hotplug vCPU,
> > > it won't be setting ACPI_HOTPLUG_CPU because it doesn't support
> > > the present bit changing. So I can see why James decided to rename
> > > it - because with Arm64's hotplug vCPU, the idea that ACPI_HOTPLUG_CP=
U
> > > somehow enables hotplug CPU support is now no longer true.
> > >
> > > Keeping it as ACPI_HOTPLUG_CPU makes the code less obvious, because i=
t
> > > leads one to assume that it ought to be enabled for Arm64's
> > > implementatinon, and that could well cause issues in the future if
> > > people make the assumption that "ACPI_HOTPLUG_CPU" means hotplug CPU
> > > is supported in ACPI. It doesn't anymore.
> >
> > On x86 there is no confusion AFAICS.  It's always meant "as long as
> > the platform supports it".
>
> That's x86, which supports physical CPU hotplug. We're introducing
> support for Arm64 here which doesn't support physical CPU hotplug.
>
>                                                 ACPI-based      Physical =
       Virtual
> Arch    HOTPLUG_CPU     ACPI_HOTPLUG_CPU        Hotplug         Hotplug  =
       Hotplug
> Arm64   Y               N                       Y               N        =
       Y
> x86     Y               Y                       Y               Y        =
       Y
>
> So ACPI_HOTPLUG_CPU becomes totally misnamed with the introduction
> of hotplug on Arm64.
>
> If we want to just look at stuff from an x86 perspective, then yes,
> it remains correct to call it ACPI_HOTPLUG_CPU. It isn't correct as
> soon as we add Arm64, as I already said.

And if you rename it, it becomes less confusing for ARM64, but more
confusing for x86, which basically is my point.

IMO "hotplug" covers both cases well enough and "hotplug present" is
only accurate for one of them.

> And honestly, a two line quip to my reasoned argument is not IMHO
> an acceptable reply.

Well, I'm not even sure how to respond to this ...

