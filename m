Return-Path: <linux-arch+bounces-1053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81093813A18
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 19:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C3BB214D6
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296168B8F;
	Thu, 14 Dec 2023 18:37:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E272410E;
	Thu, 14 Dec 2023 10:37:22 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9db92bd71so1362896a34.1;
        Thu, 14 Dec 2023 10:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579042; x=1703183842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VqDz+iAKQeDij2eq7OD06mj+eeeCJzCcbsR1GzAidN0=;
        b=XPa67Fu8rCw9+gYXEnw46OvwrzQGu2ZUqMJvgc6Wb/9g8bImHk47f48+MC57wXWGZN
         5za+OI1931IkcQZjRvhSe0YVXx8bCjIq24aI5uUyuh4hmWHDhPkV8WjdqGrerPI0TEbK
         Kusub0AQ26qOLEHzeb/ERkZBnB7RjVrZMZqFCTP5LXjvn+yMpJoTiGr+np/Q2HOP3aWZ
         G48w+kW+acRpW45nHmQC2Lrg5fayElUNHHNK0v/RBfPRoq/RNX9QKr//U6tITHmOaOZf
         LN1OkqcBUjOOL7eXeNAt/LumEVWso5Vu1wByD43cZYhKP6bw43XD0qgNUN3up1dm/mZ1
         Smjg==
X-Gm-Message-State: AOJu0Yw/qDxVDglLonMlcfzGNwjZ1UgzLI464Ws5JAXdfcM8K/8QiG89
	L+xwhDTHSZ/i5cwX6QylYpRKel4a+n4cQg5BXr0=
X-Google-Smtp-Source: AGHT+IH8dSvedIux9d+NZsh4BTm5s5Qcmw1364ii+UUrmzx3iZ4v2EO7x7vwseaBvGWSY8WP8bGNCshWcK/LSOMs+p0=
X-Received: by 2002:a05:6871:2284:b0:1fb:648:5207 with SMTP id
 sd4-20020a056871228400b001fb06485207mr19135855oab.2.1702579042101; Thu, 14
 Dec 2023 10:37:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOfs-00DvjY-HQ@rmk-PC.armlinux.org.uk>
 <20231214173241.0000260f@Huawei.com> <CAJZ5v0jymOtZ0y65K9wE8FJk+ZKwP+FoGm4AKHXcYVfQJL9MVw@mail.gmail.com>
 <ZXtFBYJEX2RrFrwj@shell.armlinux.org.uk> <CAJZ5v0h2Keyb-gFWFuPsKtwqjXvM2snyGpo6MMfFzaXKbfEpgw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h2Keyb-gFWFuPsKtwqjXvM2snyGpo6MMfFzaXKbfEpgw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Dec 2023 19:37:10 +0100
Message-ID: <CAJZ5v0h3WWtvrbxRpaGfq6c756k+L1SzZ1Gv3A14JxXHNcUMKA@mail.gmail.com>
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

On Thu, Dec 14, 2023 at 7:16=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Dec 14, 2023 at 7:10=E2=80=AFPM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Dec 14, 2023 at 06:47:00PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Dec 14, 2023 at 6:32=E2=80=AFPM Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:
> > > >
> > > > On Wed, 13 Dec 2023 12:49:16 +0000
> > > > Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> > > >
> > > > > From: James Morse <james.morse@arm.com>
> > > > >
> > > > > Today the ACPI enumeration code 'visits' all devices that are pre=
sent.
> > > > >
> > > > > This is a problem for arm64, where CPUs are always present, but n=
ot
> > > > > always enabled. When a device-check occurs because the firmware-p=
olicy
> > > > > has changed and a CPU is now enabled, the following error occurs:
> > > > > | acpi ACPI0007:48: Enumeration failure
> > > > >
> > > > > This is ultimately because acpi_dev_ready_for_enumeration() retur=
ns
> > > > > true for a device that is not enabled. The ACPI Processor driver
> > > > > will not register such CPUs as they are not 'decoding their resou=
rces'.
> > > > >
> > > > > Change acpi_dev_ready_for_enumeration() to also check the enabled=
 bit.
> > > > > ACPI allows a device to be functional instead of maintaining the
> > > > > present and enabled bit. Make this behaviour an explicit check wi=
th
> > > > > a reference to the spec, and then check the present and enabled b=
its.
> > > > > This is needed to avoid enumerating present && functional devices=
 that
> > > > > are not enabled.
> > > > >
> > > > > Signed-off-by: James Morse <james.morse@arm.com>
> > > > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > > > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > > > > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > > ---
> > > > > If this change causes problems on deployed hardware, I suggest an
> > > > > arch opt-in: ACPI_IGNORE_STA_ENABLED, that causes
> > > > > acpi_dev_ready_for_enumeration() to only check the present bit.
> > > >
> > > > My gut feeling (having made ACPI 'fixes' in the past that ran into
> > > > horribly broken firmware and had to be reverted) is reduce the blas=
t
> > > > radius preemptively from the start. I'd love to live in a world wer=
e
> > > > that wasn't necessary but I don't trust all the generators of ACPI =
tables.
> > > > I'll leave it to Rafael and other ACPI experts suggest how narrow w=
e should
> > > > make it though - arch opt in might be narrow enough.
> > >
> > > A chicken bit wouldn't help much IMO, especially in the cases when
> > > working setups get broken.
> > >
> > > I would very much prefer to limit the scope of it, say to processors
> > > only, in the first place.
> >
> > Thanks for the feedback and the idea.
> >
> > I guess we need something like:
> >
> >         if (device->status.present)
> >                 return device->device_type !=3D ACPI_BUS_TYPE_PROCESSOR=
 ||
> >                        device->status.enabled;
> >         else
> >                 return device->status.functional;
> >
> > so we only check device->status.enabled for processor-type devices?
>
> Yes, something like this.

However, that is not sufficient, because there are
ACPI_BUS_TYPE_DEVICE devices representing processors.

I'm not sure about a clean way to do it ATM.

