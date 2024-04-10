Return-Path: <linux-arch+bounces-3534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6C689F43F
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 15:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F4F1F2DC00
	for <lists+linux-arch@lfdr.de>; Wed, 10 Apr 2024 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0115E818;
	Wed, 10 Apr 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iubVYXfK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9744315ADA2;
	Wed, 10 Apr 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755711; cv=none; b=O/M9uf7vji4Ave9amjru6NyNlQA3EDkla8qZGZQMb5iUwoYIS3kUat4RrLUZEijh9HdvxrA/LdSZgn2tH7vqus6dGqpPXt4P02Eyehr3pADBkNVuDeUszF9ijQAWDIco1g6FE4DMuhXZbTvqTB7wBzfykeUFwjGGbrIJoOn0f5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755711; c=relaxed/simple;
	bh=vG/etX9uFWDRMQyM96dxgcCHcoWyYgwQIb4SGb4iHUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Milf5EHTOqdLYwAyKHZTQlTSuq938u+2iRPrWIp907ZhHSVBK8dudVj1Ln19aZDvvyYa7+i72OuVNnl2wLWHHZL+tiYq1XRNemPygq2JXgu1G8ozB9f3Rx3KDIjB5uUiQEr8zuA7y8qvqkrPk63fp5tWLo3F6n6w7d5ORUSu9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iubVYXfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420B6C43390;
	Wed, 10 Apr 2024 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712755711;
	bh=vG/etX9uFWDRMQyM96dxgcCHcoWyYgwQIb4SGb4iHUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iubVYXfK6JPDhhN9TmRS0x6QzxNaToPZCeVJnHP93bzsfQkb7YaWzUGU5fvosdVlK
	 1iYtCJ+3WmeWgXErCaKKoO8GwwKCAVsPQSeaDEZwvjhLCuOC89oo5gQpo6M/afAEAy
	 4yeMyJV1phaU5H/syWUh2fS6hJ6AmMPbK9BuOo+0TU6FA/S11ekIIS3LR1gsLiMZaG
	 mJvEUbFS4EnjHWHw0mmkVeePQ3ozflixNW+Mf7PgkbFPaNxs5zDRXrhRsUvsJ6qIwh
	 nvaEhh/w7672EUsnJyENttVNo1/Exy/MsDqmdMXp6iyLxGelAPVwHWr0EhfXbeuCBH
	 DtboMbnFmvheg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22f0429c1ebso185206fac.0;
        Wed, 10 Apr 2024 06:28:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUcst/lEX0TrGqaZcggeqiPU+99cGmB4KLjRYNj6ZHx6CvmX/0iux/PHrv9BkgPQhexl4/cAYo0E0X+DFH2SO8qCqp2crdxsi365sCWaHER2kck0+6g38wJ68p4wvsVU4wZT2We0W5OpCOLe1es/4Y0h+vrO6jFdicgDUpj+xm3oC4hjBUAvc8D3wJav6dc5iwuiE/ycdF7RYhFpQjNAnJYiIh0S3CkHKextzPzsYbdHoQT1k7ZVZ9F50NXJiTN65baYuCYKMgUrhNTHSCxxLDlmL7vtAhwlgXEi7p0zvSAxOgh7W85X18LeMstJ2xREHVhvyR5CjdsUHC9hNm/xV5hPn9JnO0Bu5osE2rLGHH
X-Gm-Message-State: AOJu0YzEIW7zi+uQ3p6nnF2pVZwTJrnvJ+NcJT5qcWoP830PtPnIukE+
	MFAibq2RZZXmrqB0AcDGutcTJsd2vyDnkNo9oEkBzx7IKMfLSyj18pTebcrb5MZhaaedunYN+o3
	kUeOk+d8GCg4/+1GbCQBzvGyTeUs=
X-Google-Smtp-Source: AGHT+IFL5SftybRh1r8JWNftMLn5Ll2W8+pkIYo7YlzdluWnaIUYaO6UpMp9mGVfMWaTjUBfbyWqBLpc+8TxlkLduX4=
X-Received: by 2002:a05:6871:a00a:b0:22d:fb4b:9d11 with SMTP id
 vp10-20020a056871a00a00b0022dfb4b9d11mr2534660oab.4.1712755710509; Wed, 10
 Apr 2024 06:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk> <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
 <20240322185327.00002416@Huawei.com> <20240410134318.0000193c@huawei.com>
In-Reply-To: <20240410134318.0000193c@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Apr 2024 15:28:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
Message-ID: <CAJZ5v0ggD042sfz3jDXQVDUxQZu_AWaF2ox-Me8CvFeRB8nczw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from acpi_processor_get_info()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
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

On Wed, Apr 10, 2024 at 2:43=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> > >
> > > > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > > > index 47de0f140ba6..13d052bf13f4 100644
> > > > --- a/drivers/base/cpu.c
> > > > +++ b/drivers/base/cpu.c
> > > > @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(vo=
id)
> > > >  {
> > > >         int i, ret;
> > > >
> > > > -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> > > > +       /*
> > > > +        * When ACPI is enabled, CPUs are registered via
> > > > +        * acpi_processor_get_info().
> > > > +        */
> > > > +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabl=
ed)
> > > >                 return;
> > >
> > > Honestly, this looks like a quick hack to me and it absolutely
> > > requires an ACK from the x86 maintainers to go anywhere.
> > Will address this separately.
> >
>
> So do people prefer this hack, or something along lines of the following?
>
> static int __init cpu_dev_register_generic(void)
> {
>         int i, ret =3D 0;
>
>         for_each_online_cpu(i) {
>                 if (!get_cpu_device(i)) {
>                         ret =3D arch_register_cpu(i);
>                         if (ret)
>                                 pr_warn("register_cpu %d failed (%d)\n", =
i, ret);
>                 }
>         }
>         //Probably just eat the error.
>         return 0;
> }
> subsys_initcall_sync(cpu_dev_register_generic);

I would prefer something like the above.

I actually thought that arch_register_cpu() might return something
like -EPROBE_DEFER when it cannot determine whether or not the CPU is
really available.

Then, the ACPI processor enumeration path may take care of registering
CPU that have not been registered so far and in the more-or-less the
same way regardless of the architecture (modulo some arch-specific
stuff).

In the end, it should be possible to avoid changing the behavior of
x86 and loongarch in this series.

> Which may look familiar at it's effectively patch 3 from v3 which was dea=
ling
> with CPUs missing from DSDT (something we think doesn't happen).
>
> It might be possible to elide the arch_register_cpu() in
> make_present() but that will mean we use different flows in this patch se=
t
> for the hotplug and initially present cases which is a bit messy.
>
> I've tested this lightly on arm64 and x86 ACPI + DT booting and it "seems=
" fine.

Sounds promising.

Thanks!

