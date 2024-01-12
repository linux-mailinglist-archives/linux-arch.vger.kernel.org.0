Return-Path: <linux-arch+bounces-1365-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32882C260
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 16:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3264A1C21077
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBF06E2C5;
	Fri, 12 Jan 2024 15:01:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0B26E2AB;
	Fri, 12 Jan 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5958b9cda7aso498204eaf.0;
        Fri, 12 Jan 2024 07:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071714; x=1705676514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkosH+fDx4uydKCIfas+gX+lZQ+YATp8/cxPr7LCjXQ=;
        b=hnVS9mcCzAsJ8JyEg2cqexDzAd/DNLAWAdzVysV4WxYJLUbAvn6SxWCrLHQwWZ8MaI
         bd4hFXIcRPhU2GLwLU6OdOBmDO1i+nI7oWf3NS1AJkScJ9OyR3Sg6PLK16bsI9numdnT
         Cla2L2zmk3u2sGSoXX8vzdhjZQwfnVMCr2XnTRibHE10z4lZs0fRD0y+7nnyi3L8CZ/o
         06anvIrHFsLhCBdTLh9srYlNupwFoFvXZwb6rioeH4rppu7Z3xNhrnq+xxh+6Ln55tZq
         Bul97I5P/7wc6W6uVk0d+AypSadHvFYaEq6nbwW4IbTlYDOxNpzPjYPSrFpt+a4+uiwO
         cZsg==
X-Gm-Message-State: AOJu0YxUOfwiQcVUXxNfjz4s7CY+ePQFbcJatLe2c/nxEMaYDgugqFNO
	7B9nIgjrh+h9xQ7QbM6iv27ibxF4kgOxgl66Sto=
X-Google-Smtp-Source: AGHT+IERQpK6tU+v/yvWRcm25F/amqoeR5fMDTcAHWek3SJqIecgzoDoVF8A5t7OAIKhoJcTR5teFvLzHtkulu/Qeec=
X-Received: by 2002:a05:6820:510:b0:598:c118:30d1 with SMTP id
 m16-20020a056820051000b00598c11830d1mr2644001ooj.0.1705071713471; Fri, 12 Jan
 2024 07:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com>
 <20240111175908.00002f46@Huawei.com> <ZaA3l4yjgCXxSiVg@shell.armlinux.org.uk> <20240112092520.00001278@Huawei.com>
In-Reply-To: <20240112092520.00001278@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jan 2024 16:01:40 +0100
Message-ID: <CAJZ5v0g2CFPrSfNzHKBz_Spwt304QEQtR6w57VR11i5APPrD8Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
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

On Fri, Jan 12, 2024 at 10:25=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 11 Jan 2024 18:46:47 +0000
> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>
> > On Thu, Jan 11, 2024 at 05:59:08PM +0000, Jonathan Cameron wrote:
> > > On Mon, 18 Dec 2023 21:17:34 +0100
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@ar=
mlinux.org.uk> wrote:
> > > > >
> > > > > From: James Morse <james.morse@arm.com>
> > >
> > > Done some digging + machine faking.  This is mid stage results at bes=
t.
> > >
> > > Summary: I don't think this patch is necessary.  If anyone happens to=
 be in
> > > the mood for testing on various platforms, can you drop this patch an=
d
> > > see if everything still works.
> > >
> > > With this patch in place, and a processor container containing
> > > Processor() objects acpi_process_add is called twice - once via
> > > the path added here and once via acpi_bus_attach etc.
> > >
> > > Maybe it's a left over from earlier approaches to some of this?
> >
> > From what you're saying, it seems that way. It would be really good to
> > get a reply from James to see whether he agrees - or at least get the
> > reason why this patch is in the series... but I suspect that will never
> > come.
> >
> > > Both cases are covered by the existing handling without this.
> > >
> > > I'm far from clear on why we need this patch.  Presumably
> > > it's the reference in the description on it breaking for
> > > Processor Package containing Processor() objects that matters
> > > after a move... I'm struggling to find that move though!
> >
> > I do know that James did a lot of testing, so maybe he found some
> > corner case somewhere which made this necessary - but without input
> > from James, we can't know that.
> >
> > So, maybe the right way forward on this is to re-test the series
> > with this patch dropped, and see whether there's any ill effects.
> > It should be possible to resurect the patch if it does turn out to
> > be necessary.
> >
> > Does that sound like a good way forward?
> >
> > Thanks.
> >
>
> Yes that sounds like the best plan. Note this patch can only make a
> difference on non arm64 arches because it's a firmware bug to combine
> Processor() with a GICC entry in APIC/MADT.  To even test on ARM64
> you have to skip the bug check.
>
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/processor_cor=
e.c#L101
>
>         /* device_declaration means Device object in DSDT, in the
>          * GIC interrupt model, logical processors are required to
>          * have a Processor Device object in the DSDT, so we should
>          * check device_declaration here
>          */
> //      if (device_declaration && (gicc->uid =3D=3D acpi_id)) {
>         if (gicc->uid =3D=3D acpi_id) {
>                 *mpidr =3D gicc->arm_mpidr;
>                 return 0;
>         }
>
> Only alternative is probably to go history diving and try and
> find another change that would have required this and is now gone.
>
> The ACPI scanning code has had a lot of changes whilst this work has
> been underway.  More than possible that this was papering over some
> issue that has long since been fixed. I can't find any deliberate
> functional changes, but there is some code generalization that 'might'
> have side effects in this area. Rafael, any expectation that anything
> changed in how scanning processor containers works?

There have been changes, but I can't recall when exactly without some
git history research.

In any case, it is always better to work on top of the current
mainline code IMO.

