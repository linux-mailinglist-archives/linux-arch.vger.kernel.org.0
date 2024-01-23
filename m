Return-Path: <linux-arch+bounces-1474-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D468397A3
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DC71F245F3
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 18:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163B81AB6;
	Tue, 23 Jan 2024 18:27:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1657F7E3;
	Tue, 23 Jan 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706034432; cv=none; b=uo46nIU6QCapnq/CESjBhndF/t2hTeQvdQDI//6b1jSrmJnXmQ115lpprk2+3qYpRh/wC7VxYPyLhMHl2FS1PtT8YaGpvI7H/J6uEgkomvtIvk068Lo65p7OumdHmwkCXDInP2btKrjc704dFsnMxV2ntQET2reI+McdbYymERM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706034432; c=relaxed/simple;
	bh=5pvDJYcRtetTzfHaic5vo3ay4ls20L2R06x3nu6LJ2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdcfS2HnfTXbAiSSldtaupFU2TR06CktI+FIkOHFGXZtDBIpvOgUeu2Kw5R17Got82hIQmQl2K/BbQr+IHfopyHQ30NjTOyekRrLG8ipw+XQKzfJrhVm8hvwM2jOkPWv4PgNLABNb20U9G3+Wg02yJiLx2jpBIEJz3GpCpNAtTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5997edc27ccso275681eaf.0;
        Tue, 23 Jan 2024 10:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706034430; x=1706639230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJNpL6fDX95XFM2IQD2CwpFM/p5iqYY4kcX2rdX/p6A=;
        b=mu+IjAuLMKgf5yam8bwlIVVc+fd7FHqsTzi+4K+blVaf1SwClzxiGJo/HAN2qjhA9+
         BgKiFNv3v12fjNEhK5w76CxUMknwYACtuvf5Tk3WB+wm9YN6ehpUM/othYuCd7k1Go6q
         NlH+TMG0ntIcAnID1tPj9GRHVJ0lQ+u3WIJFd9+zkohBOk2l1rlz4wL+dDAwUtD+BBko
         g7s+4GdgKU0bTyCNsCNDYuaQKS8c32+VXYQhhjHjq2uVOF2CEG/sY8jWyllIMnePV62p
         686qZFavcfWIMD0sATui31NCBliMf9THKvKRvBfZ3i1iqhgObmPOP/EHLkfj9f1B5sJe
         UUfw==
X-Gm-Message-State: AOJu0YzQ+LxWJN/ZrfvLvgkx7aXCbNF7udor7zOPIu9e9r1k96/uACwW
	ABp9Vhn/GrmFlu1PQwKs+SXmwLowD8+pDgZS7WYtLhWHsE0UJGEct1JEC9SP8eGT2GZvP0V3wWr
	5XWecEIACKvTVdopLI4e+nOq2wXw=
X-Google-Smtp-Source: AGHT+IHDXgFkCwvdHOL5crsKDTQT8IRZgGzfM2BUZEO+K2++Rlkm+PAg5r5ue46EVuT8a12HUrJARg9aPq33v7AITd4=
X-Received: by 2002:a4a:cb86:0:b0:599:a116:6ca with SMTP id
 y6-20020a4acb86000000b00599a11606camr104811ooq.0.1706034429766; Tue, 23 Jan
 2024 10:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
 <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
 <20240122180013.000016d5@Huawei.com> <Za++/11n5KA1VS3p@shell.armlinux.org.uk>
 <CAJZ5v0h7wsLt8d3ZoLXsK1=crAx66T42WDKNoHcg8CiHpAjS8g@mail.gmail.com>
 <Za/q9jivG4OdZM0f@shell.armlinux.org.uk> <CAJZ5v0gwe02uzAQoX0QDHo35OTEozpbnqC6vukjM3aE6HMq9WQ@mail.gmail.com>
 <ZbADTBLDEFtdglho@shell.armlinux.org.uk>
In-Reply-To: <ZbADTBLDEFtdglho@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 19:26:57 +0100
Message-ID: <CAJZ5v0jh-EdrnjkJep++UDo+Uv4hmR7VV4KYVdF4CK2K+5XLtg@mail.gmail.com>
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

On Tue, Jan 23, 2024 at 7:20=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jan 23, 2024 at 06:43:59PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 23, 2024 at 5:36=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Jan 23, 2024 at 05:15:54PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Jan 23, 2024 at 2:28=E2=80=AFPM Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Mon, Jan 22, 2024 at 06:00:13PM +0000, Jonathan Cameron wrote:
> > > > > > On Mon, 18 Dec 2023 21:35:16 +0100
> > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > >
> > > > > > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+ker=
nel@armlinux.org.uk> wrote:
> > > > > > > >
> > > > > > > > From: James Morse <james.morse@arm.com>
> > > > > > > >
> > > > > > > > The code behind ACPI_HOTPLUG_CPU allows a not-present CPU t=
o become
> > > > > > > > present.
> > > > > > >
> > > > > > > Right.
> > > > > > >
> > > > > > > > This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> > > > > > > > CPUs can be taken offline as a power saving measure.
> > > > > > >
> > > > > > > But still there is the case in which a non-present CPU can be=
come
> > > > > > > present, isn't it there?
> > > > > >
> > > > > > Not yet defined by the architectures (and I'm assuming it proba=
bly never will be).
> > > > > >
> > > > > > The original proposal we took to ARM was to do exactly that - t=
hey pushed
> > > > > > back hard on the basis there was no architecturally safe way to=
 implement it.
> > > > > > Too much of the ARM arch has to exist from the start of time.
> > > > > >
> > > > > > https://lore.kernel.org/linux-arm-kernel/cbaa6d68-6143-e010-5f3=
c-ec62f879ad95@arm.com/
> > > > > > is one of the relevant threads of the kernel side of that discu=
ssion.
> > > > > >
> > > > > > Not to put specific words into the ARM architects mouths, but t=
he
> > > > > > short description is that there is currently no demand for work=
ing
> > > > > > out how to make physical CPU hotplug possible, as such they wil=
l not
> > > > > > provide an architecturally compliant way to do it for virtual C=
PU hotplug and
> > > > > > another means is needed (which is why this series doesn't use t=
he present bit
> > > > > > for that purpose and we have the Online capable bit in MADT/GIC=
C)
> > > > > >
> > > > > > It was a 'fun' dance of several years to get to that clarificat=
ion.
> > > > > > As another fun fact, the same is defined for x86, but I don't t=
hink
> > > > > > anyone has used it yet (GICC for ARM has an online capable bit =
in the flags to
> > > > > > enable this, which was remarkably similar to the online capable=
 bit in the
> > > > > > flags of the Local APIC entries as added fairly recently).
> > > > > >
> > > > > > >
> > > > > > > > On arm64 an offline CPU may be disabled by firmware, preven=
ting it from
> > > > > > > > being brought back online, but it remains present throughou=
t.
> > > > > > > >
> > > > > > > > Adding code to prevent user-space trying to online these di=
sabled CPUs
> > > > > > > > needs some additional terminology.
> > > > > > > >
> > > > > > > > Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU t=
o reflect
> > > > > > > > that it makes possible CPUs present.
> > > > > > >
> > > > > > > Honestly, I don't think that this change is necessary or even=
 useful.
> > > > > >
> > > > > > Whilst it's an attempt to avoid future confusion, the rename is
> > > > > > not something I really care about so my advice to Russell is dr=
op
> > > > > > it unless you are attached to it!
> > > > >
> > > > > While I agree that it isn't a necessity, I don't fully agree that=
 it
> > > > > isn't useful.
> > > > >
> > > > > One of the issues will be that while Arm64 will support hotplug v=
CPU,
> > > > > it won't be setting ACPI_HOTPLUG_CPU because it doesn't support
> > > > > the present bit changing. So I can see why James decided to renam=
e
> > > > > it - because with Arm64's hotplug vCPU, the idea that ACPI_HOTPLU=
G_CPU
> > > > > somehow enables hotplug CPU support is now no longer true.
> > > > >
> > > > > Keeping it as ACPI_HOTPLUG_CPU makes the code less obvious, becau=
se it
> > > > > leads one to assume that it ought to be enabled for Arm64's
> > > > > implementatinon, and that could well cause issues in the future i=
f
> > > > > people make the assumption that "ACPI_HOTPLUG_CPU" means hotplug =
CPU
> > > > > is supported in ACPI. It doesn't anymore.
> > > >
> > > > On x86 there is no confusion AFAICS.  It's always meant "as long as
> > > > the platform supports it".
> > >
> > > That's x86, which supports physical CPU hotplug. We're introducing
> > > support for Arm64 here which doesn't support physical CPU hotplug.
> > >
> > >                                                 ACPI-based      Physi=
cal        Virtual
> > > Arch    HOTPLUG_CPU     ACPI_HOTPLUG_CPU        Hotplug         Hotpl=
ug         Hotplug
> > > Arm64   Y               N                       Y               N    =
           Y
> > > x86     Y               Y                       Y               Y    =
           Y
> > >
> > > So ACPI_HOTPLUG_CPU becomes totally misnamed with the introduction
> > > of hotplug on Arm64.
> > >
> > > If we want to just look at stuff from an x86 perspective, then yes,
> > > it remains correct to call it ACPI_HOTPLUG_CPU. It isn't correct as
> > > soon as we add Arm64, as I already said.
> >
> > And if you rename it, it becomes less confusing for ARM64, but more
> > confusing for x86, which basically is my point.
> >
> > IMO "hotplug" covers both cases well enough and "hotplug present" is
> > only accurate for one of them.
> >
> > > And honestly, a two line quip to my reasoned argument is not IMHO
> > > an acceptable reply.
> >
> > Well, I'm not even sure how to respond to this ...
>
> The above explanation you give would have been useful...
>
> I don't see how "hotplug" covers both cases. As I've tried to point
> out many times now, ACPI_HOTPLUG_CPU is N for Arm64, yet it supports
> ACPI based hotplug. How does ACPI_HOTPLUG_CPU cover Arm64 if it's
> N there?

But IIUC this change is preliminary for changing it (or equivalent
option with a different name) to Y, isn't it?

> IMHO it totally doesn't, and moreover, it goes against what
> one would logically expect - and this is why I have a problem with
> your effective NAK for this change. I believe you are basically
> wrong on this for the reasons I've given - that ACPI_HOTPLUG_CPU
> will be N for Arm64 despite it supporting ACPI-based CPU hotplug.

So I still have to understand how renaming it for all architectures
(including x86) is supposed to help.

It will still be the same option under a different name.  How does
that change things technically?

