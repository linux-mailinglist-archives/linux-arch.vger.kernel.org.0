Return-Path: <linux-arch+bounces-1484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD8883997A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 20:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115311F22A9F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 19:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AC7823D4;
	Tue, 23 Jan 2024 19:27:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B6F50A71;
	Tue, 23 Jan 2024 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038040; cv=none; b=k0A3f4iibpfyyk7aiNxdzOd2nn377h7Bs9iMT8XrLjDFUxGxqJ0TQp2wnrGu4eRg3MEBplA/C2mICUzuegHz86gROZT0YndhvMy8ZuleG2+2ljTMzYu/cbH2pl3glzoEoNxMYhR3zW+0vxkNFUX+PptBQL1ISaw6ralfIeoGNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038040; c=relaxed/simple;
	bh=wmW9lvIDOlgNFBwcMZe/d9NBkgjtJe+4nyAWK61XkJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRAAV+xt10AqI3u+lo4kGaliyVcSRTEHb6Y1c2lDmFhB1CeHDcXkx03jaoaPccsW3DD+QoKsIvuQIh7EV1Ale1BgQwBV2Iv/RmRGksnVMHC4YrZ2BsnnKreaZhsdenfwTkjJnDVLWSWSGm/hY1KG5Uq+cCmgV1OKMLl3hue6GqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59910dcc17bso864871eaf.1;
        Tue, 23 Jan 2024 11:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706038037; x=1706642837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoLUAVSlJ5cRkNGDxcOji1iXNDurPLjXvllgreGqMVo=;
        b=PC0dLjTC0iYQhwIcXBCS2WWyKoZnlR1/BxWYXxuRP7qkJmL6bT1ENvFke4VEApA+q8
         fu+8xHxzBqzCuEXpZPwokV2JiM+UKzWqyBLSdkDSiBe32q3oEzuY8sJ9i2+mFumVWUo3
         NS3iqOGEKKVdfMmlbCHnu8SgPL/Qi/K7QcBnjUsh9X5XOHUHXXbyfiUTnEDY3zpBme1Z
         i19kt8og7v11WoA2nj1vCW0mN7bUSSHFLry/ESEu8Tw3ijtxyPtQBlbmoJv1+a/ac+Or
         Q2OCbqu3FsKm/+YaCQ2J1qcu+QtR/N0vE8LOO2wr6fGumgQQrLeLkJkkeoUb4Kz4Z44t
         4BVw==
X-Gm-Message-State: AOJu0YwEO+Bgrn9vvtkgctLlCc2nwrYkszNd5Te51okytWNA37UlaF7P
	zjkTgHerc0tSn0WUQ1E05Ov+6bmXXqV/fHCgv48qh9r1L7FBzH6T9bi3Xu7g5FzviQvI+dqSnrE
	92RA8Cq1UYMq/Sg+ElOtwxbYPPVE=
X-Google-Smtp-Source: AGHT+IGySNaO33xUObgr3sk+79gjt+R7AGPtstTrum9hFKX2VIEoZuEKCTn14cVQfLpIhPermcVFOZqxLtY+eOm/sXY=
X-Received: by 2002:a05:6820:458:b0:599:b30c:51b with SMTP id
 p24-20020a056820045800b00599b30c051bmr197455oou.1.1706038037386; Tue, 23 Jan
 2024 11:27:17 -0800 (PST)
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
 <ZbADTBLDEFtdglho@shell.armlinux.org.uk> <CAJZ5v0jh-EdrnjkJep++UDo+Uv4hmR7VV4KYVdF4CK2K+5XLtg@mail.gmail.com>
 <ZbAMjZoybVfiAGcT@shell.armlinux.org.uk>
In-Reply-To: <ZbAMjZoybVfiAGcT@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 20:27:05 +0100
Message-ID: <CAJZ5v0gt=MR1JGsPZnZG_AqudA-KMmb4BOa_A6H9B6+Rhe_+JQ@mail.gmail.com>
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

On Tue, Jan 23, 2024 at 7:59=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jan 23, 2024 at 07:26:57PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 23, 2024 at 7:20=E2=80=AFPM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Tue, Jan 23, 2024 at 06:43:59PM +0100, Rafael J. Wysocki wrote:
> > > > On Tue, Jan 23, 2024 at 5:36=E2=80=AFPM Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Tue, Jan 23, 2024 at 05:15:54PM +0100, Rafael J. Wysocki wrote=
:
> > > > > > On Tue, Jan 23, 2024 at 2:28=E2=80=AFPM Russell King (Oracle)
> > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > >
> > > > > > > On Mon, Jan 22, 2024 at 06:00:13PM +0000, Jonathan Cameron wr=
ote:
> > > > > > > > On Mon, 18 Dec 2023 21:35:16 +0100
> > > > > > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > > > > > >
> > > > > > > > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk=
+kernel@armlinux.org.uk> wrote:
> > > > > > > > > >
> > > > > > > > > > From: James Morse <james.morse@arm.com>
> > > > > > > > > >
> > > > > > > > > > The code behind ACPI_HOTPLUG_CPU allows a not-present C=
PU to become
> > > > > > > > > > present.
> > > > > > > > >
> > > > > > > > > Right.
> > > > > > > > >
> > > > > > > > > > This isn't the only use of HOTPLUG_CPU. On arm64 and ri=
scv
> > > > > > > > > > CPUs can be taken offline as a power saving measure.
> > > > > > > > >
> > > > > > > > > But still there is the case in which a non-present CPU ca=
n become
> > > > > > > > > present, isn't it there?
> > > > > > > >
> > > > > > > > Not yet defined by the architectures (and I'm assuming it p=
robably never will be).
> > > > > > > >
> > > > > > > > The original proposal we took to ARM was to do exactly that=
 - they pushed
> > > > > > > > back hard on the basis there was no architecturally safe wa=
y to implement it.
> > > > > > > > Too much of the ARM arch has to exist from the start of tim=
e.
> > > > > > > >
> > > > > > > > https://lore.kernel.org/linux-arm-kernel/cbaa6d68-6143-e010=
-5f3c-ec62f879ad95@arm.com/
> > > > > > > > is one of the relevant threads of the kernel side of that d=
iscussion.
> > > > > > > >
> > > > > > > > Not to put specific words into the ARM architects mouths, b=
ut the
> > > > > > > > short description is that there is currently no demand for =
working
> > > > > > > > out how to make physical CPU hotplug possible, as such they=
 will not
> > > > > > > > provide an architecturally compliant way to do it for virtu=
al CPU hotplug and
> > > > > > > > another means is needed (which is why this series doesn't u=
se the present bit
> > > > > > > > for that purpose and we have the Online capable bit in MADT=
/GICC)
> > > > > > > >
> > > > > > > > It was a 'fun' dance of several years to get to that clarif=
ication.
> > > > > > > > As another fun fact, the same is defined for x86, but I don=
't think
> > > > > > > > anyone has used it yet (GICC for ARM has an online capable =
bit in the flags to
> > > > > > > > enable this, which was remarkably similar to the online cap=
able bit in the
> > > > > > > > flags of the Local APIC entries as added fairly recently).
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > On arm64 an offline CPU may be disabled by firmware, pr=
eventing it from
> > > > > > > > > > being brought back online, but it remains present throu=
ghout.
> > > > > > > > > >
> > > > > > > > > > Adding code to prevent user-space trying to online thes=
e disabled CPUs
> > > > > > > > > > needs some additional terminology.
> > > > > > > > > >
> > > > > > > > > > Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_C=
PU to reflect
> > > > > > > > > > that it makes possible CPUs present.
> > > > > > > > >
> > > > > > > > > Honestly, I don't think that this change is necessary or =
even useful.
> > > > > > > >
> > > > > > > > Whilst it's an attempt to avoid future confusion, the renam=
e is
> > > > > > > > not something I really care about so my advice to Russell i=
s drop
> > > > > > > > it unless you are attached to it!
> > > > > > >
> > > > > > > While I agree that it isn't a necessity, I don't fully agree =
that it
> > > > > > > isn't useful.
> > > > > > >
> > > > > > > One of the issues will be that while Arm64 will support hotpl=
ug vCPU,
> > > > > > > it won't be setting ACPI_HOTPLUG_CPU because it doesn't suppo=
rt
> > > > > > > the present bit changing. So I can see why James decided to r=
ename
> > > > > > > it - because with Arm64's hotplug vCPU, the idea that ACPI_HO=
TPLUG_CPU
> > > > > > > somehow enables hotplug CPU support is now no longer true.
> > > > > > >
> > > > > > > Keeping it as ACPI_HOTPLUG_CPU makes the code less obvious, b=
ecause it
> > > > > > > leads one to assume that it ought to be enabled for Arm64's
> > > > > > > implementatinon, and that could well cause issues in the futu=
re if
> > > > > > > people make the assumption that "ACPI_HOTPLUG_CPU" means hotp=
lug CPU
> > > > > > > is supported in ACPI. It doesn't anymore.
> > > > > >
> > > > > > On x86 there is no confusion AFAICS.  It's always meant "as lon=
g as
> > > > > > the platform supports it".
> > > > >
> > > > > That's x86, which supports physical CPU hotplug. We're introducin=
g
> > > > > support for Arm64 here which doesn't support physical CPU hotplug=
.
> > > > >
> > > > >                                                 ACPI-based      P=
hysical        Virtual
> > > > > Arch    HOTPLUG_CPU     ACPI_HOTPLUG_CPU        Hotplug         H=
otplug         Hotplug
> > > > > Arm64   Y               N                       Y               N=
               Y
> > > > > x86     Y               Y                       Y               Y=
               Y
> > > > >
> > > > > So ACPI_HOTPLUG_CPU becomes totally misnamed with the introductio=
n
> > > > > of hotplug on Arm64.
> > > > >
> > > > > If we want to just look at stuff from an x86 perspective, then ye=
s,
> > > > > it remains correct to call it ACPI_HOTPLUG_CPU. It isn't correct =
as
> > > > > soon as we add Arm64, as I already said.
> > > >
> > > > And if you rename it, it becomes less confusing for ARM64, but more
> > > > confusing for x86, which basically is my point.
> > > >
> > > > IMO "hotplug" covers both cases well enough and "hotplug present" i=
s
> > > > only accurate for one of them.
> > > >
> > > > > And honestly, a two line quip to my reasoned argument is not IMHO
> > > > > an acceptable reply.
> > > >
> > > > Well, I'm not even sure how to respond to this ...
> > >
> > > The above explanation you give would have been useful...
> > >
> > > I don't see how "hotplug" covers both cases. As I've tried to point
> > > out many times now, ACPI_HOTPLUG_CPU is N for Arm64, yet it supports
> > > ACPI based hotplug. How does ACPI_HOTPLUG_CPU cover Arm64 if it's
> > > N there?
> >
> > But IIUC this change is preliminary for changing it (or equivalent
> > option with a different name) to Y, isn't it?
>
> No. As I keep saying, ACPI_HOTPLUG_CPU ends up N on Arm64 even when
> it supports hotplug CPU via ACPI.
>
> Even with the full Arm64 patch set here, under arch/ we still only
> have:
>
> arch/loongarch/Kconfig: select ACPI_HOTPLUG_PRESENT_CPU if ACPI_PROCESSOR=
 && HOTPLUG_CPU
> arch/x86/Kconfig:       select ACPI_HOTPLUG_PRESENT_CPU         if ACPI_P=
ROCESSOR && HOTPLUG_CPU
>
> To say it yet again, ACPI_HOTPLUG_(PRESENT_)CPU is *never* set on
> Arm64.

Allright, so ARM64 is not going to use the code that is conditional on
ACPI_HOTPLUG_CPU today.

Fair enough.

> > > IMHO it totally doesn't, and moreover, it goes against what
> > > one would logically expect - and this is why I have a problem with
> > > your effective NAK for this change. I believe you are basically
> > > wrong on this for the reasons I've given - that ACPI_HOTPLUG_CPU
> > > will be N for Arm64 despite it supporting ACPI-based CPU hotplug.
> >
> > So I still have to understand how renaming it for all architectures
> > (including x86) is supposed to help.
> >
> > It will still be the same option under a different name.  How does
> > that change things technically?
>
> Do you think that it makes any sense to have support for ACPI-based
> hotplug CPU

So this is all about what you and I mean by "ACPI-based hotplug CPU".

> *and* having it functional with a configuration symbol
> named "ACPI_HOTPLUG_CPU" to be set to N ? That's essentially what
> you are advocating for...

Setting ACPI_HOTPLUG_CPU to N means that you are not going to compile
the code that is conditional on it.

That code allows the processor driver to be removed from CPUs and
arch_unregister_cpu() to be called from within acpi_bus_trim()  (among
other things).  On the way up, it allows arch_register_cpu() to be
called from within acpi_bus_scan().  If these things are not done,
what I mean by "ACPI-based hotplug CPU" is not supported.

