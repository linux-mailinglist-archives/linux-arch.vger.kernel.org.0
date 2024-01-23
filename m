Return-Path: <linux-arch+bounces-1497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAF6839BCA
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 23:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49CB1F2583A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jan 2024 22:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60F34F217;
	Tue, 23 Jan 2024 22:05:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9964F211;
	Tue, 23 Jan 2024 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047558; cv=none; b=s2hQgUyvrk6o+IitWD1sMvouBOe+c4ezHMn3nWxfGkjYrnV54ePuMjzFG6965VjCrAmAhrFecLcGKOnprPfwbrOpEzsMjPdasI8dOvgc6frBxnKMEtFcwbweOJokWRN+Sk5k9rgqEKgP7nbRF70TLYgAS194vDTmDI+jF+sUV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047558; c=relaxed/simple;
	bh=vsmubtr6a+nVdA9yIIm0YwyEISa8CSnDyRWB8gYi33I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8nKAmFjArJV/QV2zN2R5Tg4OKs/58vpBVklvD7VF4qTZo59BFbEIx//n6TxWdORLjj4G2ELRf6GgJT6IVaVdaI2mdTeF4R88sXvfaSUGVcTf2QJLp9vxOxrr64kl3dIyZ6yLvqnWA7QbpUYXetYZwDXam+taoJBO2gH9iewX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5997edc27ccso306217eaf.0;
        Tue, 23 Jan 2024 14:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047556; x=1706652356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aysBJhX0WuSz/+ETJ4n6CNlBN6IDxcYCfjo2tVGWMw8=;
        b=aoY8cI65umHzqMwdnYnwPK+0ts1g5J6sphFvTMu+/MAwOH7W/iUPuv4oA1r2noVTHm
         wTGVUPPS012u+0ZeD+pJ1l990h1Ui+TwY05sq9kdmlLF0p89/0sZhwbPS7WkTfXuGuAt
         7+l/ax3rcLSUrlv2j7MCJhmAZmfoxMVQ9j6l68ThLbS5xIio8OSDgIuJZD/eHBrLux41
         ZmR6DtaBbDy/oXU/gbbKFogyRvUDCtx5U2ZkClfKut2hBRk6yxU/LIRz0UC3acEZdL4Q
         IKRrjV/H8XhT+If6K0RHEf+mqo+bszGkVw6xeW4RD3jVjEcc7+J2SQMasL/pAGT9S2ja
         8S7g==
X-Gm-Message-State: AOJu0Yxo2zsTNe4vxU2pK0wW3e2c43Pgj9xovjvmHUbxmktNoHao2XGF
	Ju6R1Yd+d6CGaUtaPZ4gyspafMNyjcUmEl0S1ByVU+omeHnCh7SApEBQy7iS+nwas+Vy8Vnl+4S
	+HqHB09NfILF5rHcJzEYo/3EqVj4=
X-Google-Smtp-Source: AGHT+IGxuSonfkyvyqMXYCwyYcKsBELyim/SUL0gp6b7rCRYXwswAvhbx4htB7UWDzGueWKNwDacix1RPMx7M/tNIDM=
X-Received: by 2002:a05:6820:825:b0:599:a348:c582 with SMTP id
 bg37-20020a056820082500b00599a348c582mr614683oob.1.1706047556215; Tue, 23 Jan
 2024 14:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0h7wsLt8d3ZoLXsK1=crAx66T42WDKNoHcg8CiHpAjS8g@mail.gmail.com>
 <Za/q9jivG4OdZM0f@shell.armlinux.org.uk> <CAJZ5v0gwe02uzAQoX0QDHo35OTEozpbnqC6vukjM3aE6HMq9WQ@mail.gmail.com>
 <ZbADTBLDEFtdglho@shell.armlinux.org.uk> <CAJZ5v0jh-EdrnjkJep++UDo+Uv4hmR7VV4KYVdF4CK2K+5XLtg@mail.gmail.com>
 <ZbAMjZoybVfiAGcT@shell.armlinux.org.uk> <CAJZ5v0gt=MR1JGsPZnZG_AqudA-KMmb4BOa_A6H9B6+Rhe_+JQ@mail.gmail.com>
 <ZbAdAdqqfXRuY3Xj@shell.armlinux.org.uk> <CAJZ5v0gsqbeJc4qX-AefOqu53=rDme2XzFXacWz_0zbVBoaXjw@mail.gmail.com>
 <ZbAoJO8f66Dg0lGF@shell.armlinux.org.uk> <ZbArzbC19L1YxLHi@shell.armlinux.org.uk>
In-Reply-To: <ZbArzbC19L1YxLHi@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jan 2024 23:05:43 +0100
Message-ID: <CAJZ5v0jvek=W-FNhiY_0DQha2wDCUv7YW_4jaHUeX0DbYJOX6Q@mail.gmail.com>
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

On Tue, Jan 23, 2024 at 10:12=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, Jan 23, 2024 at 08:57:08PM +0000, Russell King (Oracle) wrote:
> > On Tue, Jan 23, 2024 at 09:17:18PM +0100, Rafael J. Wysocki wrote:
> > > On Tue, Jan 23, 2024 at 9:09=E2=80=AFPM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:

[cut]

> > Sorry, no point continuing this.
>
> Let me be clear why I'm exhasperated by this.
>
> I've been giving you a technical argument (Arm64 supporting ACPI
> hotplug CPU, but ACPI_HOTPLUG_CPU=3Dn) for many many emails. You
> seemed to misunderstand that, expecting ACPI_HOTPLUG_CPU to become
> Y later in the series.
>
> When that became clear that it wasn't, you've changed tack. It then
> became about whether two functions get called or not.
>
> When I pointed out that they are still going to be called, oh no,
> it's not about whether those two functions will be called but
> how they get called.

As I've said already in this thread, it is all about what "ACPI-based
CPU hotplug" means to each of us.

I know what it means to me: Running the code that is compiled when
ACPI_HOTPLUG_CPU is set via the processor scan handler.

I'm not entirely sure what it means to you.

You are saying that the config option name needs to be changed,
because it is going to stay N for ARM64 and it will support
"ACPI-based CPU hotplug" and I'm not sure what exactly you mean by
this.

To me, this just means that ARM64 is not going to use the processor
scan handler in the way it is used on x86.

> Essentially, what this comes down to is that _you_ have no technical
> argument against the change, just _you_ don't personally want it
> and it doesn't matter what justification I come up with, you're
> always going to tell me something different.

Sorry, but I'm just not convinced by your justification.

> So why not state that you personally don't want it in the first
> place? Why this game of cat and mouse and the constantly changing
> arguments. I guess it's to waste developers time.
>
> Well, I'm calling you out for this, because I'm that pissed off
> at the amount of time you're causing to be wasted.

And I don't have to suffer this kind of abuse.  Sorry.

