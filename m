Return-Path: <linux-arch+bounces-1052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D418139C0
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 19:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7528318D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41868B7C;
	Thu, 14 Dec 2023 18:16:17 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC710A6;
	Thu, 14 Dec 2023 10:16:14 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b9fb227545so688621b6e.1;
        Thu, 14 Dec 2023 10:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577774; x=1703182574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fVrLLiv/CD23rD47e8kGnLhnnuQbRgVTt+cM3Cov5A=;
        b=ENG+GXthL/SA75mRfhxCaaWTQVIZcYD81czKsMwRHjHZij23ng/ehK6ulS+QSeLWjd
         mzOt2STAO69+23gZMUx2bkyrgQOQ2Maw0gse1VWFLI8geX6q/pO5pVnMHeC8v8tN3mvl
         E3b8nFiiTdwWoFrkz4QvATVkQ+P568fVqquODZdxdOd2aFLt7tKbQXGRPse+0yLw09dy
         1r22OU+Q8eDo8qCP32fOvReL+8KmK3DijBH+JACCYb2hANprogXvdUV+hldAzdXT6ktr
         dEPp4Z4GeNRU1mMvY9iVMcP6w2DV3hvlSrRuYGOoMoZzdsuE0afoogagvZe+g1tKCu01
         Oulw==
X-Gm-Message-State: AOJu0YzO+TDxeAIrWOBiBY8krLz4ZD434tAwBiNvBtxRT8fyh6eUs1xx
	aBwbTPoe7kQ3nbccH1QfOOxSNPaTAc8HaspvWOE=
X-Google-Smtp-Source: AGHT+IHJijZImnPNUIIOWv84OL2w1tGUmgZPvXQ1Drc8dHZAkuSK99fCqBUWsD+7YUkvDs3ihxHUMSQwP8kpLp8yZOg=
X-Received: by 2002:a05:6870:9a8a:b0:203:36fc:6c8a with SMTP id
 hp10-20020a0568709a8a00b0020336fc6c8amr4450470oab.4.1702577773953; Thu, 14
 Dec 2023 10:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
 <20231214173241.0000260f@Huawei.com> <CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
 <ZXtFBYJEX2RrFrwj@shell.armlinux.org.uk>
In-Reply-To: <ZXtFBYJEX2RrFrwj@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Dec 2023 19:16:02 +0100
Message-ID: <CAJZ5v0h2Keyb-gFWFuPsKtwqjXvM2snyGpo6MMfFzaXKbfEpgw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 01/21] ACPI: Only enumerate enabled (or functional) devices
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

On Thu, Dec 14, 2023 at 7:10=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Dec 14, 2023 at 06:47:00PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 14, 2023 at 6:32=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Wed, 13 Dec 2023 12:49:16 +0000
> > > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > > From: James Morse <james.morse@arm.com>
> > > >
> > > > Today the ACPI enumeration code 'visits' all devices that are prese=
nt.
> > > >
> > > > This is a problem for arm64, where CPUs are always present, but not
> > > > always enabled. When a device-check occurs because the firmware-pol=
icy
> > > > has changed and a CPU is now enabled, the following error occurs:
> > > > | acpi ACPI0007:48: Enumeration failure
> > > >
> > > > This is ultimately because acpi_dev_ready_for_enumeration() returns
> > > > true for a device that is not enabled. The ACPI Processor driver
> > > > will not register such CPUs as they are not 'decoding their resourc=
es'.
> > > >
> > > > Change acpi_dev_ready_for_enumeration() to also check the enabled b=
it.
> > > > ACPI allows a device to be functional instead of maintaining the
> > > > present and enabled bit. Make this behaviour an explicit check with
> > > > a reference to the spec, and then check the present and enabled bit=
s.
> > > > This is needed to avoid enumerating present && functional devices t=
hat
> > > > are not enabled.
> > > >
> > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > > If this change causes problems on deployed hardware, I suggest an
> > > > arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> > > > acpi_dev_ready_for_enumeration() to only check the present bit.
> > >
> > > My gut feeling (having made ACPI 'fixes' in the past that ran into
> > > horribly broken firmware and had to be reverted) is reduce the blast
> > > radius preemptively from the start. I'd love to live in a world were
> > > that wasn't necessary but I don't trust all the generators of ACPI ta=
bles.
> > > I'll leave it to Rafael and other ACPI experts suggest how narrow we =
should
> > > make it though - arch opt in might be narrow enough.
> >
> > A chicken bit wouldn't help much IMO, especially in the cases when
> > working setups get broken.
> >
> > I would very much prefer to limit the scope of it, say to processors
> > only, in the first place.
>
> Thanks for the feedback and the idea.
>
> I guess we need something like:
>
>         if (device->status.present)
>                 return device->device_type !=3D ACPI_BUS_TYPE_PROCESSOR |=
|
>                        device->status.enabled;
>         else
>                 return device->status.functional;
>
> so we only check device->status.enabled for processor-type devices?

Yes, something like this.

