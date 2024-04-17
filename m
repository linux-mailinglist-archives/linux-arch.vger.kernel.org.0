Return-Path: <linux-arch+bounces-3768-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2938A88B1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 18:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCF61F21FD1
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 16:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D214D2A4;
	Wed, 17 Apr 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APHeA33S"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2B147C7D;
	Wed, 17 Apr 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370790; cv=none; b=u9/GBe7W3zF+/IvRuE2a3FfVWitHgLYiBsbAE3ohCgi8YuBCGhQA1RixdWqFfPzlPv5JQbYMqT579fcnybS9XoXVRsAWVEHxijdQVf6/aD/ahTZ+914d/KfsHsoawi6bD0QQXM3iO/GwGHf/HK6SzjAxJ1v1ucKekZJXJZpL2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370790; c=relaxed/simple;
	bh=4MfnDIoTJ9AEl8aT+Dk5HNe/JO8QGC5IVM+uHv+oF4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmFHBANj7fHqz8KQMSF4L3zbDDza/Qj/veOhuRg1iy/o7VhoZ9kfjnrWQNQ6/PFmh67Ezh+WZ4P95u5ntYm9u79NGWZpcThb2dHy1KRUFlmSunYV6gMVa8P937RghqBXmi2+fEvVwRAQqCK+XKU2EZ2QeTAtjN8dNaludgVrDOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APHeA33S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFF8C3277B;
	Wed, 17 Apr 2024 16:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713370789;
	bh=4MfnDIoTJ9AEl8aT+Dk5HNe/JO8QGC5IVM+uHv+oF4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=APHeA33SBq4slUCwl8TvewQuR24UM74WgNb9YEOC17PUPpEFJQELhNR495jLOS60L
	 2xQE3P0wt7N+YvISq+ZmuIcRgOjaq3dH+TG6hcfBdrr8aPTbN0fh7gTHBzyHcwJQ6b
	 3MEhYUJ8VF/1CH5B+l1AM9P+IYlK+T8xstwiwcUgea5xAa3o704iv2iR2qSVA/dMOe
	 4lJfjsBCxSk4hoflnpwRVzBOBaYxrG5sC1jfsO4BFXE/qnlf11hVQvpSO4vTJIzOcB
	 wwL0njuGEeNo8eEt/lDOBIz908Wxk25rCZaSxIiiQTaiDvMadYQtz93TJIZ3St8jqC
	 nktAtPQQzc7ZQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6eba7ddca3dso17709a34.2;
        Wed, 17 Apr 2024 09:19:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBmwAhizsyb6zDRCL/wwjTZTYU8SutFBFPTMnxZO/8LnfbM/VQn8bJdOCwLX6aqwqvJSBVuTT+YsRt89Y1gIVhai8cdyJjxrdhPLo6CQbPiYRyZaNq8OgUThPR7NT41iJi/QuQ4GSVCFHes8PRTpanxkL4reWKD51PpbmyFZYNOTmNTia1Yu2zXuYCgB00Bj8GLdLszQzrwnNuO8wYsA==
X-Gm-Message-State: AOJu0YxrJ04eb7L29TpzRXXrEwgpnQAbdzhykVvBNxGVvZJFEaenv1NQ
	e1lRlAcxNxJuJSqge4P0B4j2PfPJszX6SKr13SC2xA0qJ0kfcNg++sxcEA78ZbHzh1+ra5FZlhh
	dRB2DnVySbhvXT6kKKDUE83aEGko=
X-Google-Smtp-Source: AGHT+IEG6q6/C2eQXRfsAQBOodBY7kSByt7OxznWUyBjM5ch60DYuy2Xu4bh+rAQt0z89KxeenM/+B/YI2TDdP5Hwf8=
X-Received: by 2002:a05:6871:4605:b0:222:bfb4:1ead with SMTP id
 nf5-20020a056871460500b00222bfb41eadmr19737580oab.4.1713370789036; Wed, 17
 Apr 2024 09:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com> <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk> <87bk6ez4hj.ffs@tglx>
 <e80bfa8cb9b74997a4214e531366c71d@huawei.com> <CAJZ5v0hgABc=c6L4ctTHZ+5afeQTM1-bXhxthEKGxs8hG8R=YQ@mail.gmail.com>
 <454d0d5c4ddd403c82610725b8e633d8@huawei.com> <CAJZ5v0iQ-z5+fh5hGrDEFuD=CD+YMMWTV3EazxnknWLnZj2Wyg@mail.gmail.com>
 <88179311a503493099028c12ca37d430@huawei.com>
In-Reply-To: <88179311a503493099028c12ca37d430@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 18:19:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0itoeayy6tgwq2SLhOMB8xCarSNTeE71RNqGEPsuuJtng@mail.gmail.com>
Message-ID: <CAJZ5v0itoeayy6tgwq2SLhOMB8xCarSNTeE71RNqGEPsuuJtng@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from acpi_processor_get_info()
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
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

On Wed, Apr 17, 2024 at 5:01=E2=80=AFPM Salil Mehta <salil.mehta@huawei.com=
> wrote:
>
> HI Rafael,
>
> >  From: Rafael J. Wysocki <rafael@kernel.org>
> >  Sent: Monday, April 15, 2024 5:39 PM
> >
> >  On Mon, Apr 15, 2024 at 5:31=E2=80=AFPM Salil Mehta <salil.mehta@huawe=
i.com>  wrote:
> >  >
> >  > >  From: Rafael J. Wysocki <rafael@kernel.org>
> >  > >  Sent: Monday, April 15, 2024 1:51 PM
> >  > >
> >  > >  On Mon, Apr 15, 2024 at 1:51=E2=80=AFPM Salil Mehta
> >  > > <salil.mehta@huawei.com>
> >  > >  wrote:
> >  > >  >
> >
> >  [cut]
> >
> >  > >  > >  Though virtualization happily jumped on it to hot add/remove
> >  > > CPUs  > > to/from  a guest.
> >  > >  > >
> >  > >  > >  There are limitations to this and we learned it the hard way
> >  > > on  > > X86. At the  end we came up with the following restriction=
s:
> >  > >  > >
> >  > >  > >      1) All possible CPUs have to be advertised at boot time =
via  firmware
> >  > >  > >         (ACPI/DT/whatever) independent of them being present =
at boot time
> >  > >  > >         or not.
> >  > >  > >
> >  > >  > >         That guarantees proper sizing and ensures that associ=
ations
> >  > >  > >         between hardware entities and software representation=
s and the
> >  > >  > >         resulting topology are stable for the lifetime of a s=
ystem.
> >  > >  > >
> >  > >  > >         It is really required to know the full topology of th=
e system at
> >  > >  > >         boot time especially with hybrid CPUs where some of t=
he cores
> >  > >  > >         have hyperthreading and the others do not.
> >  > >  > >
> >  > >  > >
> >  > >  > >      2) Hot add can only mark an already registered (possible=
) CPU
> >  > >  > >         present. Adding non-registered CPUs after boot is not=
 possible.
> >  > >  > >
> >  > >  > >         The CPU must have been registered in #1 already to en=
sure that
> >  > >  > >         the system topology does not suddenly change in an in=
compatible
> >  > >  > >         way at run-time.
> >  > >  > >
> >  > >  > >  The same restriction would apply to real physical hotplug. I
> >  > > don't  > > think that's  any different for ARM64 or any other arch=
itecture.
> >  > >  >
> >  > >  >
> >  > >  > There is a difference:
> >  > >  >
> >  > >  > 1.   ARM arch does not allows for any processor to be NOT prese=
nt. Hence,  because of
> >  > >  > this restriction any of its related per-cpu components must be
> >  > > present  > and enumerated at the boot time as well (exposed by
> >  > > firmware and  > ACPI). This means all the enumerated processors wi=
ll
> >  > > be marked as  > 'present' but they might exist in NOT enabled (_ST=
A.enabled=3D0) state.
> >  > >  >
> >  > >  > There was one clear difference and please correct me if I'm wro=
ng
> >  > > > here,  for x86, the LAPIC associated with the x86 core can be br=
ought online later even after boot?
> >  > >  >
> >  > >  > But for ARM Arch, processors and its corresponding per-cpu
> >  > > components  > like redistributors all need to be present and
> >  > > enumerated during the  > boot time. Redistributors are part of ALW=
AYS-ON power domain.
> >  > >
> >  > >  OK
> >  > >
> >  > >  So what exactly is the problem with this and what does
> >  > >  acpi_processor_add() have to do with it?
> >  >
> >  >
> >  > For ARM Arch, during boot time, it should add processor as if no
> >  > hotplug exists. But later, in context to the (fake) hotplug trigger
> >  > from the virtualizer as a result of the CPU (un)plug action  it shou=
ld just
> >  end up in registering the already present CPU with the Linux Driver Mo=
del.
> >
> >  So let me repeat this last time: acpi_processor_add() cannot do that,
> >  because (as defined today) it rejects CPUs with the "enabled" bit clea=
r in  _STA.
>
>
> I understand that now because you have placed a check recently. sorry for=
 stretching
> it a bit but I wanted to clearly understand the reason for this behavior.=
 Is it because,
>
> 1. It does not makes sense to add a disabled but present/functional proce=
ssor or
>     perhaps there are repercussions to support such a behavior?

Yes because it is unusable.

> Or
>
> 2. None of the existing processors need such a behavior?
>
>
>
> >  > >  Do you want the per-CPU structures etc. to be created from the
> >  > >  acpi_processor_add() path?
> >  >
> >  >
> >  > I referred to the components related to ARM CPU Arch like redistribu=
tors etc.
> >  > which will get initialized in context to Arch specific _init code no=
t
> >  > here. This i.e. acpi_processor_add() is arch agnostic code common to=
 all architectures.
> >  >
> >  > [ A digression: You do have _weak functions which can be overridden =
to
> >  > arch specific  handling like  arch_(un)map_cpu() etc. but we can't u=
se
> >  > those to defer initialize  the CPU related components - ARM Arch
> >  > constraint!]
> >
> >  Not right now, but they can be added I suppose.
> >
> >  >
> >  > >
> >  > >  This plain won't work because acpi_processor_add(), as defined in
> >  > > the  mainline kernel today (and the Jonathan's patches don't chang=
e
> >  > > that  AFAICS), returns an error for processor devices with the
> >  > > "enabled" bit clear  in _STA (it returns an error if the "present"
> >  > > bit is clear too, but that's  obvious), so it only gets to calling
> >  > > arch_register_cpu() if
> >  > >  *both* "present" and "enabled" _STA bits are set for the given
> >  > > processor  device.
> >  >
> >  >
> >  > If you are referring to the _STA check in the XX_hot_add_init() then
> >  > in the current kernel code it only checks for the
> >  > ACPI_STA_DEVICE_PRESENT flag and not the ACPI_STA_DEVICE_ENABLED fla=
g(?).
> >
> >  No, I am not.  I'm referring to this code in 6.9-rc4:
> >
> >  static int acpi_processor_add(struct acpi_device *device,
> >                      const struct acpi_device_id *id) {
> >      struct acpi_processor *pr;
> >      struct device *dev;
> >      int result =3D 0;
> >
> >      if (!acpi_device_is_enabled(device))
> >          return -ENODEV;
>
>
> Ahh, sorry, I missed this check as this has been added recently. Yes, now=
 your
> logic of having common legs makes more sense.
>
>
> >
> >      ...
> >  }
> >
> >  where acpi_device_is_enabled() is defined as follows:
> >
> >  bool acpi_device_is_enabled(const struct acpi_device *adev) {
> >      return adev->status.present && adev->status.enabled; }
>
>
> Got it.
>
>
> [digression note:]
> BTW, I'm wondering why we are checking adev->status.present
> as having adev->status.enabled as set and adev->status.present
> as unset would mean firmware has a BUG. If we really want to
> check this then we should rather flag a warning on detection
> of this condition?

Adding a warning would be fine with me.

> Either this:
>  bool acpi_device_is_enabled(const struct acpi_device *adev) {
>
>      if (!acpi_device_is_present(adev)) {
>             if (adev->status.enabled)
>                        pr_debug("Device [%s] status inconsistent: Enabled=
 but not Present\n",
>                                           device->pnp.bus_id);
>             return false;
>      }
>       return  true;
> }
>
> Ideally this inconsistency should have been checked in acpi_bus_get_statu=
s()
> and above function should have been just,

Yes, it can be added there.  It can even clear 'enabled' if 'present' is cl=
ear.

> file: drivers/acpi/scan.c
> bool acpi_device_is_enabled(const struct acpi_device *adev) {
>       return !!adev->status.enabled; }

Sure.

> file: drivers/acpi/bus.c
> int acpi_bus_get_status(struct acpi_device *device)
> {
>        [...]
>
>         status =3D acpi_bus_get_status_handle(device->handle, &sta);
>         if (ACPI_FAILURE(status))
>                 return -ENODEV;
>
>         acpi_set_device_status(device, sta);
>
>         if (device->status.functional && !device->status.present) {
>                 pr_debug("Device [%s] status [%08x]: functional but not p=
resent\n",
>                          device->pnp.bus_id, (u32)sta);
>         }
>
> +       if (device->status.enabled && !device->status.present) {
> +               pr_debug("BUG: Device [%s] status [%08x]: enabled but not=
 present\n",
> +                        device->pnp.bus_id, (u32)sta);
> +                         /* any specific handling here? */
> +       }
>
>         pr_debug("Device [%s] status [%08x]\n", device->pnp.bus_id, (u32)=
sta);
>         return 0;
> }
>
> >
> >  > The code being reviewed has changed
> >  > exactly that behavior for 2 legs i.e. make-present and make-enabled =
legs.
> >
> >  I'm not sure what you mean here, but the code above means that
> >  acpi_processor_add) does not distinguish between CPU with the "present=
"
> >  bit clear (in which case the "enabled" bit must also be clear as per t=
he spec)
> >  and CPUs with the "present" bit set and the "enabled" bit clear.  Thes=
e two
> >  cases are handled in the same way.
> >
> >  > I'm open to further address your point clearly.
> >
> >  I hope that the above is clear enough.
>
>
> Yes, clear now. I missed the new check.
>
> >
> >  > >
> >  > >  That, BTW, is why I keep saying that from the ACPI CPU enumeratio=
n
> >  > > code  perspective, there is no difference between "present" and
> >  "enabled".
> >  >
> >  >
> >  > Agreed but there is still a subtle difference.  Enumeration happens
> >  > once and for all the processors during the boot time. And as confirm=
ed
> >  > by yourself and Thomas as well that even in x86 arch all the
> >  > processors will be discovered and their topology fixed during the bo=
ot
> >  > time which is effectively the same behavior as in the ARM Arch. But
> >  > ARM assumes those 'present' bits in the present masks to be set duri=
ng
> >  > the boot time which is not like x86(?).  Hence, 'present cpu' Bits
> >  > will always be equal to 'possible cpu' Bits. This is a constraint pu=
t by the
> >  ARM maintainers and looks unshakable.
> >
> >  Yes, there are differences between architectures, but the ACPI code is=
 (or
> >  at least should be) architecture-agnostic (as you said somewhere above=
).
> >  So why does this matter for the ACPI code?
>
>
> It should not. There were few bits like overriding of arch_register_cpu()=
 which
> was not allowed by ARM folks in 2020 when I floated the first prototype.
>
>
> >  > >  > 2.  Agreed regarding the topology. Are you suggesting that we
> >  > > must  > call arch_register_cpu() during boot time for all the 'pre=
sent'  CPUs?
> >  > >  > Even if that's the case, we might still want to defer
> >  > > registration of  > the cpu device (register_cpu() API) with the
> >  > > Linux device model. Later  > is what we are doing to hide/unhide t=
he
> >  > > CPUs from the user while  STA.Enabled Bit is toggled due to CPU  (=
un)plug action.
> >  > >
> >  > >  There are two ways to approach this IMV, and both seem to be vali=
d
> >  > > in  principle.
> >  > >
> >  > >  One would be to treat CPUs with the "enabled" bit clear as not
> >  > > present and  create all of the requisite data structures for them
> >  > > when they become  available (in analogy with the "real hot-add" ca=
se).
> >  >
> >  >
> >  > Right. This one is out-of-scope for ARM Arch as we cannot defer any
> >  > Arch specific sizing and initializations after boot i.e. when
> >  > processor_add() gets called again later as a trigger of CPU plug act=
ion at the Virtualizer.
> >  >
> >  >
> >  > >
> >  > >  The alternative one is to create all of the requisite data
> >  > > structures for the  CPUs that you find during boot, but register C=
PU
> >  > > devices for those having  the "enabled" _STA bit set.
> >  >
> >  >
> >  > Correct. and we defer the registration for CPUs with online-capable
> >  > Bit set in the ACPI MADT/GICC data structure. These CPUs basically
> >  > form set of hot-pluggable CPUs on ARM.
> >  >
> >  >
> >  > >
> >  > >  It looks like you have chosen the second approach, which is fine
> >  > > with me  (although personally, I would rather choose the first one=
),
> >  > > but then your  arch code needs to arrange for the requisite CPU da=
ta
> >  > > structures etc. to be  set up before acpi_processor_add() gets
> >  > > called because, as per the above,  the latter just rejects CPUs wi=
th the  "enabled" _STA bit clear.
> >  >
> >  > Yes, correct. First one is not possible - at least for now and to ha=
ve
> >  > that it will require lot of rework especially at GIC. But there are
> >  > many other arch components (like timers, PMUs, etc.) whose behavior
> >  > needs to be specified somewhere in the architecture as well. All the=
se are closely coupled with the ARM CPU architecture.
> >  > (it's beyond this discussion and lets leave that to ARM folks).
> >  >
> >  > This patch-set has a change to deal with ACPI _STA.Enabled Bit accor=
dingly.
> >
> >  Well, I'm having a hard time with this.
> >
> >  As far as CPU enumeration goes, if the "enabled" bit is clear in _STA,=
 it does
> >  not happen at all.  Both on ARM and on x86.
>
> sure, I can see that now.
>
> >
> >  Now tell me why there need to be two separate code paths calling
> >  arch_register_cpu() in acpi_processor_add()?
>
>
> As mentioned above, in the first prototype I floated in the year 2020 any=
 attempts
> to override the __weak call of arch_register_cpu() for ARM64 was discoura=
ged.
> Though, the reasons might have changed now as some code has been moved.
>
> Once we are allowed to override the calls then there are many more possib=
ilities
> which open up to simplify the code further.

Well, IMV this should just be an arch function with no __weak
defaults, because the default would probably be unusable in practice
anyway.

