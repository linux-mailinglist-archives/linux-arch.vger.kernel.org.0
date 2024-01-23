Return-Path: <linux-arch+bounces-1470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195BB839476
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 17:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BA028C3A8
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060164A8E;
	Tue, 23 Jan 2024 16:16:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0761674;
	Tue, 23 Jan 2024 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026568; cv=none; b=ediqZnRvtNZJjelby/Sn+YZPJjLQ8IfWJxnJJ4GXmFPIM427X/4iF81Mv+GUT/Yi5pDHmlglyTroq3QdzSZxaf6of6tv5UDzmVFvf1Ysg1iqv2jJxAloq2BEO3uCb0nSJma1cAL1nRJ3ZZGWcrsiWbMJj+xk60VFIRlM1qGMU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026568; c=relaxed/simple;
	bh=w3+AYXUdBPT1k1chiYw1nvRpK0AKwcZFytOy9qQHdiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mydW34joNzZQ5GFphB968f7z/i8uG6eSLhdpisEoXarGxkEU8WYE4Kxg4hULDt4J63aaZYN3H2oba/Xg+jdHAulZOvjIsnTV/q07niJtR21ybOw02Y22WIr7UFkBEV3EeKB90f4PvE0UukkT31K4M6wT1GdoSSjWNBY8v79PxPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dbc2bf4e8dso902859a34.1;
        Tue, 23 Jan 2024 08:16:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026566; x=1706631366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJEIU7VR+3J2Yia1miwsBzYF1liLE8jqQNwwQ3tqywA=;
        b=BVXybsR8i8+Q94fqKbNu65fNCDxERYr1EwBDYE4uDfZomW0ecJcrNZUQNDVSlz7rSY
         +VZ/kbFwCoT/ym3lc10W3xpU7w8RDBwFwAgLoCXcUexLvPc+NYOiI1PDSLkjv0498BX4
         aAzrJqrFX0sg47eW125TFLs3at+5DG7NdPIWox89IHARfsqeY7TT+2+OjclrVUOJcCsw
         K12grXX5NzyM8EDNp8F1dlqcb4wqyam58e6/N+9GFYImyNkcpEl7E1N0VESfzJcM27AH
         hOQLp8QG0S3x2WdtBIroeIRYW/Yn2r/830tXCuQLLw42rvRCxtP+Nh9qj0C2GilaShBM
         QUjA==
X-Gm-Message-State: AOJu0Yz2XrrpP23i7jIWUWw7f0zjQyZhlm0juwYCJfO9ydnEJeuzVLgx
	MQPQO/EnWqHBBTuWeMAu0/L1OhggYLJEKn2Ih5WUKrrYHxfiG602PbFE1TcVrN8jCnaId7oe5DR
	phZM9E0cBPoU39C21btV0odXVg8cfRJXA
X-Google-Smtp-Source: AGHT+IHQzsBW5twpX6SIjbULqATUBQ0vqIkaZWwGQH4D7Ygegig4qDUNFIf/V4v9BHOfqKgEoP5iIqbc4ar0eQw6LMM=
X-Received: by 2002:a05:6808:f10:b0:3bd:c5eb:451c with SMTP id
 m16-20020a0568080f1000b003bdc5eb451cmr2255072oiw.1.1706026566440; Tue, 23 Jan
 2024 08:16:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
 <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
 <20240122180013.000016d5@Huawei.com> <Za++/11n5KA1VS3p@shell.armlinux.org.uk>
In-Reply-To: <Za++/11n5KA1VS3p@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 17:15:54 +0100
Message-ID: <CAJZ5v0h7wsLt8d3ZoLXsK1=crAx66T42WDKNoHcg8CiHpAjS8g@mail.gmail.com>
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include 'present'
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
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

On Tue, Jan 23, 2024 at 2:28=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jan 22, 2024 at 06:00:13PM +0000, Jonathan Cameron wrote:
> > On Mon, 18 Dec 2023 21:35:16 +0100
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >
> > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@arml=
inux.org.uk> wrote:
> > > >
> > > > From: James Morse <james.morse@arm.com>
> > > >
> > > > The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
> > > > present.
> > >
> > > Right.
> > >
> > > > This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> > > > CPUs can be taken offline as a power saving measure.
> > >
> > > But still there is the case in which a non-present CPU can become
> > > present, isn't it there?
> >
> > Not yet defined by the architectures (and I'm assuming it probably neve=
r will be).
> >
> > The original proposal we took to ARM was to do exactly that - they push=
ed
> > back hard on the basis there was no architecturally safe way to impleme=
nt it.
> > Too much of the ARM arch has to exist from the start of time.
> >
> > https://lore.kernel.org/linux-arm-kernel/cbaa6d68-6143-e010-5f3c-ec62f8=
79ad95@arm.com/
> > is one of the relevant threads of the kernel side of that discussion.
> >
> > Not to put specific words into the ARM architects mouths, but the
> > short description is that there is currently no demand for working
> > out how to make physical CPU hotplug possible, as such they will not
> > provide an architecturally compliant way to do it for virtual CPU hotpl=
ug and
> > another means is needed (which is why this series doesn't use the prese=
nt bit
> > for that purpose and we have the Online capable bit in MADT/GICC)
> >
> > It was a 'fun' dance of several years to get to that clarification.
> > As another fun fact, the same is defined for x86, but I don't think
> > anyone has used it yet (GICC for ARM has an online capable bit in the f=
lags to
> > enable this, which was remarkably similar to the online capable bit in =
the
> > flags of the Local APIC entries as added fairly recently).
> >
> > >
> > > > On arm64 an offline CPU may be disabled by firmware, preventing it =
from
> > > > being brought back online, but it remains present throughout.
> > > >
> > > > Adding code to prevent user-space trying to online these disabled C=
PUs
> > > > needs some additional terminology.
> > > >
> > > > Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflec=
t
> > > > that it makes possible CPUs present.
> > >
> > > Honestly, I don't think that this change is necessary or even useful.
> >
> > Whilst it's an attempt to avoid future confusion, the rename is
> > not something I really care about so my advice to Russell is drop
> > it unless you are attached to it!
>
> While I agree that it isn't a necessity, I don't fully agree that it
> isn't useful.
>
> One of the issues will be that while Arm64 will support hotplug vCPU,
> it won't be setting ACPI_HOTPLUG_CPU because it doesn't support
> the present bit changing. So I can see why James decided to rename
> it - because with Arm64's hotplug vCPU, the idea that ACPI_HOTPLUG_CPU
> somehow enables hotplug CPU support is now no longer true.
>
> Keeping it as ACPI_HOTPLUG_CPU makes the code less obvious, because it
> leads one to assume that it ought to be enabled for Arm64's
> implementatinon, and that could well cause issues in the future if
> people make the assumption that "ACPI_HOTPLUG_CPU" means hotplug CPU
> is supported in ACPI. It doesn't anymore.

On x86 there is no confusion AFAICS.  It's always meant "as long as
the platform supports it".

