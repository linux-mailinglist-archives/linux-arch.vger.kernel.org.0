Return-Path: <linux-arch+bounces-3686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611488A5066
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66931F2182A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86484139579;
	Mon, 15 Apr 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2KOyKSr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E573163;
	Mon, 15 Apr 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185503; cv=none; b=JHCFBclIMFrqJB5INbP/C7vTsAeQoPMUaZlsQ2vViKYhgrp9AtnLrEacl4FgCGTd727tepvSTfpc5fYcQKn6kYeqe7wwSNcLT3h1VqT5o1B5yQs/dctW0grloSma2ATp8Mqwqi+fAUbqkfPx6CTc+mXe2IVRRL1HUA9Mw1lH3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185503; c=relaxed/simple;
	bh=jYX09rpdrm93G+82PrvfVTaDeGwVFz87SiF1eL4uh4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPNvGCgYOzPmCLL+wACLZmu+o7fPu56/k8BBnS3IFTMuolw9IP9zyOboNnHV8O6A2T53gRyyTutmtGNvKHykrNrhAkDwR7fZUhTzZsYZnvTUBOawo7wtclMdfWX/iaoMVNEuIg/n6QGqXZy7jiHbgQu0P5GCft+rNalPctzPiNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2KOyKSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEC8C113CC;
	Mon, 15 Apr 2024 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185503;
	bh=jYX09rpdrm93G+82PrvfVTaDeGwVFz87SiF1eL4uh4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X2KOyKSrplY3TQ4q9SahVWs6oObdsfm/oET5Ojm9a/yiX+Vr9aBmPSpc14PXj5UCK
	 ntBzkaUVg5iooN/jydrxGrgMMl7jipjzJRfJs3MrizMt2uW8+9fGeuDEZxjmkRUi1m
	 ZAqN4D+rTd34QSKZdRStpxcrZNhbDMhTJMfo15qa1/ype+RgrIaS2/Sx4sViDooTQ9
	 UERyYrIsubkhpyGYFPYCnFqCG71NMOvoA2LDeMeaG9CT2/ncoYfFWyejLUphbcOYkn
	 y8gZWT7SA55m7VvRNk2WK94Y5/T4GKaVyeX+CcwR3Wyw3p84a9VR4xy1i7LFDW9HpO
	 v84WXL6ILkZfA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a9ef9ba998so844111eaf.1;
        Mon, 15 Apr 2024 05:51:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXypDsMF8kshtuXYczEur+J57TQDYT9rm+NuIYmKjy9FNI3lFyAvg6n0GwB5zvDt0tau0xPRFKF3zJDsrHJJ6UpGeEpBl/kgiVUU03GzK+c27XoqzZQ2/zK1aRFAFxUfwsGWigF4JZVCP63qOaiirNOD/xbXE1T2FEGCVpFguW5xXWsoRqQ7aFA4df5ol4SLQxweABTmZQMwbpbB7p8kQ==
X-Gm-Message-State: AOJu0YwOcVnmcxATbirisS35WWH0GwR6AlxppOKXSuSsy8AZ/qkb1d1R
	Dx1hyUhyVuABiCvrgb8cGIw+6iJ3w1RY/ioNrFWdMS4uoFfdPcHzVUkS8Ssllsw4fwUnOHptY3b
	jUVDn0zXt4tFa1ExnzE5oWna6ogQ=
X-Google-Smtp-Source: AGHT+IG+/b2KS0keTNCgqFOHM9Mj89KNmkEnREchLeL6HLDGedvTzVt6H4r3tff+PQXQyqWIrKyVcHggoANlbHCH0sE=
X-Received: by 2002:a05:6870:7a6:b0:22e:e006:e5ae with SMTP id
 en38-20020a05687007a600b0022ee006e5aemr11158428oab.0.1713185502514; Mon, 15
 Apr 2024 05:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com> <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk> <87bk6ez4hj.ffs@tglx> <e80bfa8cb9b74997a4214e531366c71d@huawei.com>
In-Reply-To: <e80bfa8cb9b74997a4214e531366c71d@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Apr 2024 14:51:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgABc=c6L4ctTHZ+5afeQTM1-bXhxthEKGxs8hG8R=YQ@mail.gmail.com>
Message-ID: <CAJZ5v0hgABc=c6L4ctTHZ+5afeQTM1-bXhxthEKGxs8hG8R=YQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
To: Salil Mehta <salil.mehta@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, 
	Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>, 
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com" <jianyong.wu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 1:51=E2=80=AFPM Salil Mehta <salil.mehta@huawei.com=
> wrote:
>
> Hello,
>
> >  From: Thomas Gleixner <tglx@linutronix.de>
> >  Sent: Friday, April 12, 2024 9:55 PM
> >
> >  On Fri, Apr 12 2024 at 21:16, Russell King (Oracle) wrote:
> >  > On Fri, Apr 12, 2024 at 08:30:40PM +0200, Rafael J. Wysocki wrote:
> >  >> Say acpi_map_cpu) / acpi_unmap_cpu() are turned into arch calls.
> >  >> What's the difference then?  The locking, which should be fine if I=
'm
> >  >> not mistaken and need_hotplug_init that needs to be set if this cod=
e
> >  >> runs after the processor driver has loaded AFAICS.
> >  >
> >  > It is over this that I walked away from progressing this code, becau=
se
> >  > I don't think it's quite as simple as you make it out to be.
> >  >
> >  > Yes, acpi_map_cpu() and acpi_unmap_cpu() are already arch
> >  implemented
> >  > functions, so Arm64 can easily provide stubs for these that do nothi=
ng.
> >  > That never caused me any concern.
> >  >
> >  > What does cause me great concern though are the finer details. For
> >  > example, above you seem to drop the evaluation of _STA for the
> >  > "make_present" case - I've no idea whether that is something that
> >  > should be deleted or not (if it is something that can be deleted, th=
en
> >  > why not delete it now?)
> >  >
> >  > As for the cpu locking, I couldn't find anything in
> >  > arch_register_cpu() that depends on the cpu_maps_update stuff nor
> >  > needs the cpus_write_lock being taken - so I've no idea why the
> >  > "make_present" case takes these locks.
> >
> >  Anything which updates a CPU mask, e.g. cpu_present_mask, after early
> >  boot must hold the appropriate write locks. Otherwise it would be poss=
ible
> >  to online a CPU which just got marked present, but the registration ha=
s not
> >  completed yet.
> >
> >  > Finally, the "pr->flags.need_hotplug_init =3D 1" thing... it's not
> >  > obvious that this is required - remember that with Arm64's "enabled"
> >  > toggling, the "processor" is a slice of the system and doesn't
> >  > actually go away - it's just "not enabled" for use.
> >  >
> >  > Again, as "processors" in Arm64 are slices of the system, they have =
to
> >  > be fully described in ACPI before the OS boots, and they will be
> >  > marked as being "present", which means they will be enumerated, and
> >  > the driver will be probed. Any processor that is not to be used will
> >  > not have its enabled bit set. It is my understanding that every
> >  > processor will result in the ACPI processor driver being bound to it
> >  > whether its enabled or not.
> >  >
> >  > The difference between real hotplug and Arm64 hotplug is that real
> >  > hotplug makes stuff not-present (and thus unenumerable). Arm64
> >  hotplug
> >  > makes stuff not-enabled which is still enumerable.
> >
> >  Define "real hotplug" :)
> >
> >  Real physical hotplug does not really exist. That's at least true for =
x86, where
> >  the physical hotplug support was chased for a while, but never ended u=
p in
> >  production.
> >
> >  Though virtualization happily jumped on it to hot add/remove CPUs to/f=
rom
> >  a guest.
> >
> >  There are limitations to this and we learned it the hard way on X86. A=
t the
> >  end we came up with the following restrictions:
> >
> >      1) All possible CPUs have to be advertised at boot time via firmwa=
re
> >         (ACPI/DT/whatever) independent of them being present at boot ti=
me
> >         or not.
> >
> >         That guarantees proper sizing and ensures that associations
> >         between hardware entities and software representations and the
> >         resulting topology are stable for the lifetime of a system.
> >
> >         It is really required to know the full topology of the system a=
t
> >         boot time especially with hybrid CPUs where some of the cores
> >         have hyperthreading and the others do not.
> >
> >
> >      2) Hot add can only mark an already registered (possible) CPU
> >         present. Adding non-registered CPUs after boot is not possible.
> >
> >         The CPU must have been registered in #1 already to ensure that
> >         the system topology does not suddenly change in an incompatible
> >         way at run-time.
> >
> >  The same restriction would apply to real physical hotplug. I don't thi=
nk that's
> >  any different for ARM64 or any other architecture.
>
>
> There is a difference:
>
> 1.   ARM arch does not allows for any processor to be NOT present. Hence,=
 because of
> this restriction any of its related per-cpu components must be present an=
d enumerated
> at the boot time as well (exposed by firmware and ACPI). This means all t=
he enumerated
> processors will be marked as 'present' but they might exist in NOT enable=
d (_STA.enabled=3D0)
> state.
>
> There was one clear difference and please correct me if I'm wrong here,  =
for x86, the LAPIC
> associated with the x86 core can be brought online later even after boot?
>
> But for ARM Arch, processors and its corresponding per-cpu components lik=
e redistributors
> all need to be present and enumerated during the boot time. Redistributor=
s are part of
> ALWAYS-ON power domain.

OK

So what exactly is the problem with this and what does
acpi_processor_add() have to do with it?

Do you want the per-CPU structures etc. to be created from the
acpi_processor_add() path?

This plain won't work because acpi_processor_add(), as defined in the
mainline kernel today (and the Jonathan's patches don't change that
AFAICS), returns an error for processor devices with the "enabled" bit
clear in _STA (it returns an error if the "present" bit is clear too,
but that's obvious), so it only gets to calling arch_register_cpu() if
*both* "present" and "enabled" _STA bits are set for the given
processor device.

That, BTW, is why I keep saying that from the ACPI CPU enumeration
code perspective, there is no difference between "present" and
"enabled".

> 2.  Agreed regarding the topology. Are you suggesting that we must call a=
rch_register_cpu()
> during boot time for all the 'present' CPUs? Even if that's the case, we =
might still want to defer
> registration of the cpu device (register_cpu() API) with the Linux device=
 model. Later is what
> we are doing to hide/unhide the CPUs from the user while STA.Enabled Bit =
is toggled due to
> CPU (un)plug action.

There are two ways to approach this IMV, and both seem to be valid in princ=
iple.

One would be to treat CPUs with the "enabled" bit clear as not present
and create all of the requisite data structures for them when they
become available (in analogy with the "real hot-add" case).

The alternative one is to create all of the requisite data structures
for the CPUs that you find during boot, but register CPU devices for
those having the "enabled" _STA bit set.

It looks like you have chosen the second approach, which is fine with
me (although personally, I would rather choose the first one), but
then your arch code needs to arrange for the requisite CPU data
structures etc. to be set up before acpi_processor_add() gets called
because, as per the above, the latter just rejects CPUs with the
"enabled" _STA bit clear.

Thanks!

