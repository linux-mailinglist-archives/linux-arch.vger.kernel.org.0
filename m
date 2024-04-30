Return-Path: <linux-arch+bounces-4061-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3C8B6F4F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 12:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515621F243E9
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E864E129A6F;
	Tue, 30 Apr 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+vqZZvO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635D22618;
	Tue, 30 Apr 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471940; cv=none; b=KTCh2xdqtxFORkcX6DlJW/AeuJxtkGCvr1WHKXJ8qS8xFekV5BGFmqf4KMEytDxINdyXAru/sOo9mroKaYSa9qCpQSNEusoOj4hvO3ebzjULlJK/gRWCBLV/rDQUUWjbj2C/3kQkt4HeUzFZ5iWNQ68s7TH1tHchOz9wqQ/m/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471940; c=relaxed/simple;
	bh=NURsOywy6CZA9cVVjd03JDCKuIynBZF1dYZyedRQp4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MabhvcXM5m4MI1SP9Sak27I6m3FrCSphwbxbcBI8tpJ77Gldtv5f2ME9qCjgng5XXmQbWtkBr0fA+u45ZjVhNPzN8SqsRH/a+k+NHANdgwJweSwRL900Qmy4QxStgnKsK/6LZRcYZfJos6WXNucBR0/Hb+Bk/p9QpS+3+HfnpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+vqZZvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDFBC4AF1A;
	Tue, 30 Apr 2024 10:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714471940;
	bh=NURsOywy6CZA9cVVjd03JDCKuIynBZF1dYZyedRQp4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X+vqZZvOjZypgq0mBbFOU/tDwtRlo20JPY8W7/+T5hEB0EU1kBFvrjrXDoD4LVL9U
	 nXvbZl2/jb3FB5uawtClONaKcEkIhs8Il0/LrR5sGfphOqy0iROZ8iXzElUPONM0YI
	 JhZnUe1n8K8hiV+HA719XaWokj3xQp8wSlDLpm9IIyOZQ2FfvMiae63ZxnGe5b/U9V
	 1BQAUSZhoQo8YR8IYNRsg8um71Aa8K92G9QCazzVpJ5LtEq1HmU3DyU4jpJ1eKvunb
	 HEhkZ5HWCjr9sz+mBoNCAN+HGbn/jSsz8PeeVKXKAWLlTowQ0bWldxkeoa56jXG7k1
	 NPRWpilKAM0rg==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ee5ee29423so181788a34.2;
        Tue, 30 Apr 2024 03:12:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfJjlaUs1ToTQgIcLWsmfHe+qXBaXo8Q21ZRJqwmTy5fcJLDAMDTtJxmC2Qwwx5bJboEgaWuSP8UfwbM/Wmd3WKOtPNhVIsdy4JPnfUoAXgyFDdgNxig8gdVJF+zpZkqTvDXs4r/EplTjIEJdI0wt5PBx7TUV990la3YVSxMMAeHWbnh3Jrkg9P0JngWs3jHTDgAHvTlKULzQ/xidl9A==
X-Gm-Message-State: AOJu0YxCoLzMkY90KjGRlEiUJ7OKdOcId/smjQzqditQ948Wz8Now0Gt
	r50IWN1dhxv1VCjbBijAUJXIJK1ycY1N2oKaSx5BGfW6KbNpItEwiEqFzzM1HdnznoOJFpSY7L+
	shVEvM6M1CwbLKD4oXQ7Ki2qfTtQ=
X-Google-Smtp-Source: AGHT+IEkOTp4jMU7eudwtXqkvXjt6cTTGERhb/sNQV/MqoRF8MN5nzaetIoEPLvwr3sNLlYci5wgFWtcOQTdv18nlQ0=
X-Received: by 2002:a4a:9287:0:b0:5af:be60:ccdc with SMTP id
 i7-20020a4a9287000000b005afbe60ccdcmr3516316ooh.0.1714471939510; Tue, 30 Apr
 2024 03:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-5-Jonathan.Cameron@huawei.com> <80a2e07f-ecb2-48af-b2be-646f17e0e63e@redhat.com>
 <20240430102838.00006e04@Huawei.com>
In-Reply-To: <20240430102838.00006e04@Huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 12:12:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iKU8ra9jR+EmgxbuNm=Uwx2m1-8vn_RAZ+aCiUVLe3Pw@mail.gmail.com>
Message-ID: <CAJZ5v0iKU8ra9jR+EmgxbuNm=Uwx2m1-8vn_RAZ+aCiUVLe3Pw@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] ACPI: processor: Move checks and availability of
 acpi_processor earlier
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, x86@kernel.org, Russell King <linux@armlinux.org.uk>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:28=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 30 Apr 2024 14:17:24 +1000
> Gavin Shan <gshan@redhat.com> wrote:
>
> > On 4/26/24 23:51, Jonathan Cameron wrote:
> > > Make the per_cpu(processors, cpu) entries available earlier so that
> > > they are available in arch_register_cpu() as ARM64 will need access
> > > to the acpi_handle to distinguish between acpi_processor_add()
> > > and earlier registration attempts (which will fail as _STA cannot
> > > be checked).
> > >
> > > Reorder the remove flow to clear this per_cpu() after
> > > arch_unregister_cpu() has completed, allowing it to be used in
> > > there as well.
> > >
> > > Note that on x86 for the CPU hotplug case, the pr->id prior to
> > > acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> > > must be initialized after that call or after checking the ID
> > > is valid (not hotplug path).
> > >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > ---
> > > v8: On buggy bios detection when setting per_cpu structures
> > >      do not carry on.
> > >      Fix up the clearing of per cpu structures to remove unwanted
> > >      side effects and ensure an error code isn't use to reference the=
m.
> > > ---
> > >   drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++-----------=
---
> > >   1 file changed, 48 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proces=
sor.c
> > > index ba0a6f0ac841..3b180e21f325 100644
> > > --- a/drivers/acpi/acpi_processor.c
> > > +++ b/drivers/acpi/acpi_processor.c
> > > @@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(void) {=
}
> > >   #endif /* CONFIG_X86 */
> > >
> > >   /* Initialization */
> > > +static DEFINE_PER_CPU(void *, processor_device_array);
> > > +
> > > +static bool acpi_processor_set_per_cpu(struct acpi_processor *pr,
> > > +                                  struct acpi_device *device)
> > > +{
> > > +   BUG_ON(pr->id >=3D nr_cpu_ids);
> >
> > One blank line after BUG_ON() if we need to follow original implementat=
ion.
>
> Sure unintentional - I'll put that back.
>
> >
> > > +   /*
> > > +    * Buggy BIOS check.
> > > +    * ACPI id of processors can be reported wrongly by the BIOS.
> > > +    * Don't trust it blindly
> > > +    */
> > > +   if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
> > > +       per_cpu(processor_device_array, pr->id) !=3D device) {
> > > +           dev_warn(&device->dev,
> > > +                    "BIOS reported wrong ACPI id %d for the processo=
r\n",
> > > +                    pr->id);
> > > +           /* Give up, but do not abort the namespace scan. */
> >
> > It depends on how the return value is handled by the caller if the name=
space
> > is continued to be scanned. The caller can be acpi_processor_hotadd_ini=
t()
> > and acpi_processor_get_info() after this patch is applied. So I think t=
his
> > specific comment need to be moved to the caller.
>
> Good point. This gets messy and was an unintended change.
>
> Previously the options were:
> 1) acpi_processor_get_info() failed for other reasons - this code was nev=
er called.
> 2) acpi_processor_get_info() succeeded without acpi_processor_hotadd_init=
 (non hotplug)
>    this code then ran and would paper over the problem doing a bunch of c=
leanup under err.
> 3) acpi_processor_get_info() succeeded with acpi_processor_hotadd_init ca=
lled.
>    This code then ran and would paper over the problem doing a bunch of c=
leanup under err.
>
> We should maintain that or argue cleanly against it.

The return value needs to be propagated to acpi_processor_add() so it
can decide what to do with it.

Now, acpi_processor_add() can only return 1 if the CPU has been
successfully registered and initialized, so it is regarded as
available (but it may not be online to start with).

Returning 0 from it may get messy, because acpi_default_enumeration()
will get called and it will attempt to create a platform device for
the CPU, so in all cases in which the CPU is not regarded as available
when acpi_processor_add() returns, it should return an error code (the
exact value doesn't matter for its caller so long as it is negative).

> This isn't helped the the fact I have no idea which cases we care about f=
or that bios
> bug handling.  Do any of those bios's ever do hotplug?  Guess we have to =
try and maintain
> whatever protection this was offering.
>
> Also, the original code leaks data in some paths and I have limited idea
> of whether it is intentional or not. So to tidy the issue up that you've =
identified
> I'll need to try and make that code consistent first.

I agree.

> I suspect the only way to do that is going to be to duplicate the allocat=
ions we
> 'want' to leak to deal with the bios bug detection.
>
> For example acpi_processor_get_info() failing leaks pr and pr->throttling=
.shared_cpu_map
> before this series. After this series we need pr to leak because it's use=
d for the detection
> via processor_device_array.
>
> I'll work through this but it's going to be tricky to tell if we get righ=
t.
> Step 1 will be closing the existing leaks and then we will have something
> consistent to build on.

Sounds good to me.

