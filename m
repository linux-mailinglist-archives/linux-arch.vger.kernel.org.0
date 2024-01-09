Return-Path: <linux-arch+bounces-1315-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F6A828998
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 17:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F051F2522D
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jan 2024 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E25F39FF9;
	Tue,  9 Jan 2024 16:05:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C043F38DC1;
	Tue,  9 Jan 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5958b9cda7aso99270eaf.0;
        Tue, 09 Jan 2024 08:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704816327; x=1705421127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTP9EiyEeva0GUJp/wJKIwTcNHCIZPpR3j0J43X6b+g=;
        b=nxWnuh45KgkIE081cfLsGH5hj6NpGc+NaDu+eKB87d8LKa3hjPtZ4KvZPUpgpdj7xC
         7ZQiO87BccZkoBUKabImwdG6lh01VlUM+GMhYBIxKVmZLNfy5xeAaBt0LKLMCu0FUlI7
         aDia4Gp9x991h9tNw3RhsSZnWYUHDOd01ADtuHQvtC0WGfl6y4aviZMteJruWpjJv0ZA
         kssQiU5/WU0Ij98pOWqozDfZ1XHP6cCFtfmmXZA6vCwYjGUPaL/YdISciconI+Y9PLnk
         hNA79xCd1MRRzoleQv7LWvmHs5IGaPwE9k4C3mZP+yn9ukFmMOgcf0Q234npRDC278ls
         52IQ==
X-Gm-Message-State: AOJu0YzX1nmipWVKmckDWLkNZxGMYx2Tgs5hZ1TtPGqKhVGjl/d/yC/n
	ElEnKY1qyJKKDGDvgTT3EN+bKe877N8Gi4H0D1w=
X-Google-Smtp-Source: AGHT+IHRqsiYjS0UsEPStnFKOygnAmrZHBpCnrANvUVJi1e1QtXAE7l8zfFAjXuasM2dCT8ERtMsi1F9sFJ5XRWSXf8=
X-Received: by 2002:a05:6820:d0a:b0:598:8d98:286d with SMTP id
 ej10-20020a0568200d0a00b005988d98286dmr696771oob.0.1704816326785; Tue, 09 Jan
 2024 08:05:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iB0bS6nmjQ++pV1zp5YSGuigbffK5VD3wsX+8bY9MA5w@mail.gmail.com> <ZZ1q+7GXqnMMwKNR@shell.armlinux.org.uk>
In-Reply-To: <ZZ1q+7GXqnMMwKNR@shell.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jan 2024 17:05:15 +0100
Message-ID: <CAJZ5v0jvuTAMak-x=ekphwgNsUWABGRcDPb8D4QB=KhfyC76Sg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
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

On Tue, Jan 9, 2024 at 4:49=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Dec 18, 2023 at 09:17:34PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlin=
ux.org.uk> wrote:
> > >
> > > From: James Morse <james.morse@arm.com>
> > >
> > > ACPI has two ways of describing processors in the DSDT. From ACPI v6.=
5,
> > > 5.2.12:
> > >
> > > "Starting with ACPI Specification 6.3, the use of the Processor() obj=
ect
> > > was deprecated. Only legacy systems should continue with this usage. =
On
> > > the Itanium architecture only, a _UID is provided for the Processor()
> > > that is a string object. This usage of _UID is also deprecated since =
it
> > > can preclude an OSPM from being able to match a processor to a
> > > non-enumerable device, such as those defined in the MADT. From ACPI
> > > Specification 6.3 onward, all processor objects for all architectures
> > > except Itanium must now use Device() objects with an _HID of ACPI0007=
,
> > > and use only integer _UID values."
> > >
> > > Also see https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_a=
nd_Control.html#declaring-processors
> > >
> > > Duplicate descriptions are not allowed, the ACPI processor driver alr=
eady
> > > parses the UID from both devices and containers. acpi_processor_get_i=
nfo()
> > > returns an error if the UID exists twice in the DSDT.
> >
> > I'm not really sure how the above is related to the actual patch.
> >
> > > The missing probe for CPUs described as packages
> >
> > It is unclear what exactly is meant by "CPUs described as packages".
> >
> > From the patch, it looks like those would be Processor() objects
> > defined under a processor container device.
> >
> > > creates a problem for
> > > moving the cpu_register() calls into the acpi_processor driver, as CP=
Us
> > > described like this don't get registered, leading to errors from othe=
r
> > > subsystems when they try to add new sysfs entries to the CPU node.
> > > (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> > >
> > > To fix this, parse the processor container and call acpi_processor_ad=
d()
> > > for each processor that is discovered like this.
> >
> > Discovered like what?
> >
> > > The processor container
> > > handler is added with acpi_scan_add_handler(), so no detach call will
> > > arrive.
> >
> > The above requires clarification too.
>
> The above comments... yea. As I didn't write the commit description, but
> James did, and James has basically vanished, I don't think these can be
> answered, short of rewriting the entire commit message, with me spending
> a lot of time with the ACPI specification trying to get the terminology
> right - because at lot of the above on the face of it seems to be things
> to do with wrong terminology being used.
>
> I wasn't expecting this level of issues with this patch set, and I now
> feel completely out of my depth with this series. I'm wondering whether
> I should even continue with it, since I don't have the ACPI knowledge
> to address a lot of these comments.

Well, sorry about this.

I met James at the LPC last year, so he seems to be still around, in
some way at least..

