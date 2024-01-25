Return-Path: <linux-arch+bounces-1583-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A67983C509
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 15:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934341C22285
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98336E2DA;
	Thu, 25 Jan 2024 14:42:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F606E2BE;
	Thu, 25 Jan 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193768; cv=none; b=j3r3DXqrfz30ufF3kd/DxqHHFm9HaviolvCyVunL78NRb0FpDDG4fAwOr4y7ggEtcVBrB5P3WDik8qyNDjaxa4lEdF0p/PNpE+OtWBp//gJJMYcPIqTMnOBBqT6U0lr3hz6S3QFoJmwm4L8UxOpnNUifvr4bYrW06gtbE16S45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193768; c=relaxed/simple;
	bh=JaK07Zkj3cT2yhn6Ow34x5ujcw/CKNJtlZf/Ls0PoA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbZslrDJaKPlwZU1G/h2QbxCOX5IXjCYd0FuK7kpCBywYl9zdvdP2GwZmHkKlMDyVqxi2o6lB2TQL2FBbE9LtLoQ2orphGEFRwLn6bk8N4E1S9QAwaLQxLKzh3SkZIbo0RJon7wKVk4STGvKxys8SEIL5WLxkMudBbWKZj+XoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bc21303a35so1267870b6e.0;
        Thu, 25 Jan 2024 06:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193766; x=1706798566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WansAIK1kV2qngBkKGzUZEv8a9oLEEFRWHM6D4Yzd+M=;
        b=IoiMUcqNl7waglleg4DMIDbjGLYPOtueAM47JFRrHhPGkxwxuLLsVS9de59v5QoP9B
         5Uc5KkUmSuyqw8j1K7AmEDhnU4r287eMQqUbdfVvONklySaCn3eqHmds9fCpNOZUIMEf
         bMWfE0WQmvEOQ3JtfjtspI4FU9p6H8lllR+/9DfJwge3Lzkzs+mFM8/pl2eUbyx4nZ1o
         t9m1BHY3hwL4HBI5nMdY2oj8YImSrEwLyosoO/DZ9MB0WhNop5w6Hf2/0nEg1sTiG0gC
         s7em5sXAcOw5RfiDD//kODRQEDIXIvo7iPyUinOQTFFpFJVzB1j5GDcAFqurlHi4S/er
         RgTA==
X-Gm-Message-State: AOJu0YyFgNwgV1M4/ZtQ2OUQEOPW6B+T/bT7jf4AzXMzJusQqhM/5GsG
	yedihfax1gzKbOeQSJpvXrPLZ+dbTEZWcrOSLDNkyylxlcX9nlcIPwPkztqeyFH7K8ejlVNKHyv
	uT616HujBtSTzsDE/UQwXwV2W3eg=
X-Google-Smtp-Source: AGHT+IHrMMS6irD8BFopNOqV65JYF32HklaFUv2M5fjsXBTp38AaiSFl3qoFRWI4K+lpO8xVl3bxSYdmwfq7Su82484=
X-Received: by 2002:a05:6870:618a:b0:214:dbdd:a173 with SMTP id
 a10-20020a056870618a00b00214dbdda173mr987239oah.3.1706193766071; Thu, 25 Jan
 2024 06:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
 <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
 <ZaURtUvWQyjYfiiO@shell.armlinux.org.uk> <20240122160227.00002d83@Huawei.com>
 <CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
 <Za6mHRJVjb6M1mun@shell.armlinux.org.uk> <20240123092725.00004382@Huawei.com> <3A26D95F-7366-4354-A010-318A98660076@oracle.com>
In-Reply-To: <3A26D95F-7366-4354-A010-318A98660076@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jan 2024 15:42:34 +0100
Message-ID: <CAJZ5v0h1na9BQiT6a4dK==8anmt15S4sArktzuLiSyScvw=bqg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, 
	"acpica-devel@lists.linuxfoundation.org" <acpica-devel@lists.linuxfoundation.org>, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, 
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, "jianyong.wu@arm.com" <jianyong.wu@arm.com>, 
	"justin.he@arm.com" <justin.he@arm.com>, James Morse <james.morse@arm.com>, 
	"vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 25, 2024 at 2:56=E2=80=AFPM Miguel Luis <miguel.luis@oracle.com=
> wrote:
>
> Hi
>
> > On 23 Jan 2024, at 08:27, Jonathan Cameron <jonathan.cameron@huawei.com=
> wrote:
> >
> > On Mon, 22 Jan 2024 17:30:05 +0000
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >
> >> On Mon, Jan 22, 2024 at 05:22:46PM +0100, Rafael J. Wysocki wrote:
> >>> On Mon, Jan 22, 2024 at 5:02=E2=80=AFPM Jonathan Cameron
> >>> <Jonathan.Cameron@huawei.com> wrote:
> >>>>
> >>>> On Mon, 15 Jan 2024 11:06:29 +0000
> >>>> "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >>>>
> >>>>> On Mon, Dec 18, 2023 at 09:22:03PM +0100, Rafael J. Wysocki wrote:
> >>>>>> On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@a=
rmlinux.org.uk> wrote:
> >>>>>>>
> >>>>>>> From: James Morse <james.morse@arm.com>
> >>>>>>>
> >>>>>>> ACPI has two descriptions of CPUs, one in the MADT/APIC table, th=
e other
> >>>>>>> in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Proces=
sors"
> >>>>>>> says "Each processor in the system must be declared in the ACPI
> >>>>>>> namespace"). Having two descriptions allows firmware authors to g=
et
> >>>>>>> this wrong.
> >>>>>>>
> >>>>>>> If CPUs are described in the MADT/APIC, they will be brought onli=
ne
> >>>>>>> early during boot. Once the register_cpu() calls are moved to ACP=
I,
> >>>>>>> they will be based on the DSDT description of the CPUs. When CPUs=
 are
> >>>>>>> missing from the DSDT description, they will end up online, but n=
ot
> >>>>>>> registered.
> >>>>>>>
> >>>>>>> Add a helper that runs after acpi_init() has completed to registe=
r
> >>>>>>> CPUs that are online, but weren't found in the DSDT. Any CPU that
> >>>>>>> is registered by this code triggers a firmware-bug warning and ke=
rnel
> >>>>>>> taint.
> >>>>>>>
> >>>>>>> Qemu TCG only describes the first CPU in the DSDT, unless cpu-hot=
plug
> >>>>>>> is configured.
> >>>>>>
> >>>>>> So why is this a kernel problem?
> >>>>>
> >>>>> So what are you proposing should be the behaviour here? What this
> >>>>> statement seems to be saying is that QEMU as it exists today only
> >>>>> describes the first CPU in DSDT.
> >>>>
> >>>> This confuses me somewhat, because I'm far from sure which machines =
this
> >>>> is true for in QEMU.  I'm guessing it's a legacy thing with
> >>>> some old distro version of QEMU - so we'll have to paper over it any=
way
> >>>> but for current QEMU I'm not sure it's true.
> >>>>
> >>>> Helpfully there are a bunch of ACPI table tests so I've been checkin=
g
> >>>> through all the multi CPU cases.
> >>>>
> >>>> CPU hotplug not enabled.
> >>>> pc/DSDT.dimmpxm  - 4x Processor entries.  -smp 4
> >>>> pc/DSDT.acpihmat - 2x Processor entries.  -smp 2
> >>>> q35/DSDT.acpihmat - 2x Processor entries. -smp 2
> >>>> virt/DSDT.acpihmatvirt - 4x ACPI0007 entries -smp 4
> >>>> q35/DSDT.acpihmat-noinitiator - 4 x Processor () entries -smp 4
> >>>> virt/DSDT.topology - 8x ACPI0007 entries
> >>>>
> >>>> I've also looked at the code and we have various types of
> >>>> CPU hotplug on x86 but they all build appropriate numbers of
> >>>> Processor() entries in DSDT.
> >>>> Arm likewise seems to build the right number of ACPI0007 entries
> >>>> (and doesn't yet have CPU HP support).
> >>>>
> >>>> If anyone can add a reference on why this is needed that would be ve=
ry
> >>>> helpful.
> >>>
> >>> Yes, it would.
> >>>
> >>> Personally, I would prefer to assume that it is not necessary until i=
t
> >>> turns out that (1) there is firmware with this issue actually in use
> >>> and (2) updating the firmware in question to follow the specification
> >>> is not practical.
> >>>
> >>> Otherwise, we'd make it easier to ship non-compliant firmware for no
> >>> good reason.
> >>
> >> If Salil can't come up with a reason, then I'm in favour of dropping
> >> the patch like already done for patch 2. If the code change serves no
> >> useful purpose, there's no point in making the change.
> >>
> >
> > Salil's out today, but I've messaged him to follow up later in the week=
.
> >
> > It 'might' be the odd cold plug path where QEMU half comes up, then ext=
ra
> > CPUs are added, then it boots. (used by some orchestration frameworks)
> > I don't have a set up for that and I won't get to creating one today an=
yway
> > (we all love start of the year planning workshops!)
> >
> > I've +CC'd a few people have run tests on the various iterations of thi=
s
> > work in the past.  Maybe one of them can shed some light on this?
> >
>
> IIUC, this patch covers a scenario for non compliant firmware and in whic=
h my
> tests for AArch64 using RFC v2 have been unable to trigger its error mess=
age so
> far. This does not mean, however, this patch should not be taken forward =
though.
>
> It seems benevolent enough detecting non compliant firmware and still pro=
ceed
> while having whoever uses that firmware to get to know that.

There is one issue with this approach, though.

If this is done by Linux and Linux is used as a main testing vehicle
for whoever produced that firmware, it may pass the tests and be
shipped causing a problem for the rest of the industry (because other
operating systems will not support that firmware and now they will be
put in an awkward position).

I've seen enough breakage resulting from a similar policy in some
other OS and with Linux on the receiving end that I'd rather avoid
doing this to someone else.

So if the firmware is not compliant, the best way to go is to ask
whoever ships it to please fix their stuff, or if other OSes already
work around the non-compliance, it's time to update the spec to
reflect the reality (aka "industry practice").

Thanks!

