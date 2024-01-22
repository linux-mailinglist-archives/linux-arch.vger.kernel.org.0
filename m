Return-Path: <linux-arch+bounces-1428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7D0836FFB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 19:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62B528DB76
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC1755775;
	Mon, 22 Jan 2024 18:03:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8163155769;
	Mon, 22 Jan 2024 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946633; cv=none; b=m0KmqlLQghRNEXDewsogkOIUMCFgHCBnXSM6ia7mJDb6mtcaxnjSdqym3OU+oBoFT7P/0g8oB4zN5nlwevKMuTOD6oU6JRWEuEu8E8I40x3deC59gCIWuaE7mPS/CJBOU20bHkEgXNCtfDKNWXFqbta092g6hXjYqRySriResLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946633; c=relaxed/simple;
	bh=Fh6Mfh+ZfjN747uqw1yJY2/Biltz7BVQb6iuhi4PHr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtYADGuDh0NnJf/KSD0EaVAZwzDP+83qmyrNq3aJbF6eaaL4zEHzuUOBidWZEHKK/FuussvfY1sMjZQQKETkS0R1RqfmQcrhQuE5xbQOiXUxVnM7a2pwlIxiP6UVOI/rPJbviGnkIq1v5O8BuInAHhnRzcnulglq3Jv0xPHmU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68197b99138so219246d6.1;
        Mon, 22 Jan 2024 10:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946631; x=1706551431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s26G0NnkppbXguh7peNPWPJ5jelauHZoMn0Xk4NSQUw=;
        b=f9sj8dapz8X8s4X3rV7CprJ4yVeGEoaicBNlidoCaSjayweKFDw/PcvRUBrg/YCxmi
         a+rpuUJYG3ww7Tx71XUdvnDc+IHZ1UIltCJM38MJzu6ACo1VbbFBz3hQUPvoXJgRVtdm
         +Duv+eDNfM9T1ILJmxw3/p/26plcEi8Ums4q43FDoD/YPhnW1+La3M2la2iSAHWfUres
         BGz/iiWlr4lGOQwwjbBwLrLIsvNyr5Ysj+qQYg86jmvBmIxsBOp0clHXDDB3mH1iaWDz
         SmcR4vaTtgHc/S8updpLDKvE0HmyemNypUaJewLmInX+1YNwdh8irNp9j0fQHwUn0hVw
         hizw==
X-Gm-Message-State: AOJu0YzpKSZgMLO8owwP/NzVyChGP+JCTvPwJk7rJh7QVSnjZaC68sV5
	Ofp8gX/ZrAQWnZ27ua6C5rk3IOTIQfe9P70ZQsBG8GnWKFwqkZezKhpIcwIiF8bqUoCYGSSdJ+y
	F/qM9B7On8XvDtCou/+FbN1VApeiPS5Zjyos=
X-Google-Smtp-Source: AGHT+IHydxkoIcTGgPnithAm3ZZ3Lbs6GLo4uCDeUNHWYMYJDcQ7kkQEBWJsEM9NkDfdwTNwYrCyeGF8yf+5uFu9gbc=
X-Received: by 2002:a4a:cb87:0:b0:599:9e03:68da with SMTP id
 y7-20020a4acb87000000b005999e0368damr789760ooq.0.1705946610762; Mon, 22 Jan
 2024 10:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOg7-00Dvjq-VZ@rmk-PC.armlinux.org.uk>
 <CAJZ5v0je=-oVnSumZs=dzcyVuVUeVeTgO7yOnjGg1igyrS7EHQ@mail.gmail.com> <20240122174449.00002f78@Huawei.com>
In-Reply-To: <20240122174449.00002f78@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jan 2024 19:03:19 +0100
Message-ID: <CAJZ5v0gePAsbRecOXDZ+q-Ds+nsoSBq6VU89ikuQoxds7TeQ3g@mail.gmail.com>
Subject: Re: [PATCH RFC v3 04/21] ACPI: processor: Register all CPUs from acpi_processor_get_info()
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

On Mon, Jan 22, 2024 at 6:44=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 18 Dec 2023 21:30:50 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlin=
ux.org.uk> wrote:
> > >
> > > From: James Morse <james.morse@arm.com>
> > >
> > > To allow ACPI to skip the call to arch_register_cpu() when the _STA
> > > value indicates the CPU can't be brought online right now, move the
> > > arch_register_cpu() call into acpi_processor_get_info().
> >
> > This kind of looks backwards to me and has a potential to become
> > super-confusing.
> >
> > I would instead add a way for the generic code to ask the platform
> > firmware whether or not the given CPU is enabled and so it can be
> > registered.
>
> Hi Rafael,
>
> The ACPI interpreter isn't up at this stage so we'd need to pull that
> forwards. I'm not sure if we can pull the interpreter init early enough.

Well, this patch effectively defers the AP registration to the time
when acpi_processor_get_info() runs and the interpreter is up and
running then.

For consistency, it would be better to defer the AP registration in
general to that point.

> Perhaps pushing the registration back in all cases is the way to go?
> Given the acpi interpretter is initialized via subsys_initcall() it would
> need to be after that - I tried pushing cpu_dev_register_generic()
> immediately after acpi_bus_init() and that seems fine.

Sounds promising.

> We can't leave the rest of cpu_dev_init() that late because a bunch
> of other stuff relies on it (CPU freq blows up first as a core_init()
> on my setup).

I see.

> So to make this work we need it to always move the registration later
> than the necessary infrastructure, perhaps to subsys_initcall_sync()
> as is done for missing CPUs (we'd need to combine the two given that
> needs to run after this, or potentially just stop checking for acpi_disab=
led
> and don't taint the kernel!).  I think this is probably the most consiste=
nt
> option on basis it at least moves the registration to the same point
> whatever is going on and can easily use the arch callback you suggest
> to hide away the logic on deciding if a CPU is there or not.

I agree.

