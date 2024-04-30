Return-Path: <linux-arch+bounces-4065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88228B709E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC91F1C21CA5
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 10:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903B12C49F;
	Tue, 30 Apr 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGvXxDPs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613C81292C8;
	Tue, 30 Apr 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474067; cv=none; b=K6oUQHbDGsEU3GZpCXttlKRGXljevGdUK9BNNxvYoD7L8rKYTCDi0V75yN4fHvoJRWp6mYv60PtlutntAcalyTyalW4thld2ww+ieLtGkKztJh9xsrVNhDGqjIqaYhcjeDENSxyxxdZ3pmdWzd+OxwTa+LKHeXZqSGdT6Wpaq78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474067; c=relaxed/simple;
	bh=WZUKSeKyIPsk8d6ycvulrut5Qa11GliUpPCP6FFms4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxuKy+mS2heE7LEnOQIlArUQJjCkqjREETQR/MFzEeJo8oBQNUPgAW2j/y0oKjXuF+9tFEapJzeWVZSGZZb2BLut2/2P9KlmOKTSkGd6UKtEIMAgKr+ptwgpEOaIoY+qgu6rOirMgfpFdoVklC1FJPhZcxeKtk7+m/G/t2C0JQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGvXxDPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A9BC4AF5F;
	Tue, 30 Apr 2024 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714474067;
	bh=WZUKSeKyIPsk8d6ycvulrut5Qa11GliUpPCP6FFms4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mGvXxDPseshKWHrhk/EJeXU0vbKAkmpT4jipiadYfEt06SESJdnr7pN1XwuX2XKAP
	 QolD4+xZe394t1sKP3d/WuOd5qF+EUSIiZGg1zknqEDshwq0iyiHBI/YMyMynWgdAx
	 u5OJjMyNBwLAdgfIfRdCKfzy8oXNku/V63JuL/TL3MNqi6qdXxA3rpJL5BLqu1Emv6
	 vMK+E8j7Yf1PYaIr87oBrL3G7KvHXuyQAJbZBOJ2Rfz7D/f569l7zZIKPWxPhA1p9a
	 yrmrpXF3CyD39HRjByGsK1lXLjGt1BvVcQjVZB0LJtPW2PYj56DewQ5lHUyjyGYKGM
	 havP8C0Hc0PNQ==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6ea0a6856d7so804394a34.1;
        Tue, 30 Apr 2024 03:47:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUU62zyOzw/kiGVC6iSrqHCLfqb3vHRv2XbjcjM6Rc01TXYFZ24XBiu7V4cmJ1ldVlEoDC08pQlpWK5+Tl8VDrqKWyyjAX2++hs/2sn7RwRRBkOWTiyhg48TWYzR5lwIupz6IsDQciF6RR11QO+Q1DLhQvAOBNqtV7/6fQJ4j996OTI5tvyI07uL92xodlnWtb7j79ezYq+bBPN64ozWg==
X-Gm-Message-State: AOJu0Yyzkj/KMMLroO2YLMa/cBeKISxvpUZtGk4xXFLOGgBGq/2f7AyG
	gIL1VWhKIAPzwUTN+c50dQNDHA7dndJDGh1DC0aabvwoHWZaQ8DIQyXY0VsQXB9hnaJ+PZTOS0Q
	GSAFM7zeekn5RdHgDSyBtHfbLjps=
X-Google-Smtp-Source: AGHT+IHNKT5Ik0nUI8b5ABIxeB3JmGV787CqCPuIjHLaEaioVmWruFOWAVvzVNYd9L9saMxym0xKD6S5YvIRDnvFpfI=
X-Received: by 2002:a4a:9287:0:b0:5af:be60:ccdc with SMTP id
 i7-20020a4a9287000000b005afbe60ccdcmr3602815ooh.0.1714474066271; Tue, 30 Apr
 2024 03:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426135126.12802-1-Jonathan.Cameron@huawei.com>
 <20240426135126.12802-5-Jonathan.Cameron@huawei.com> <80a2e07f-ecb2-48af-b2be-646f17e0e63e@redhat.com>
 <20240430102838.00006e04@Huawei.com> <20240430111341.00003dba@huawei.com>
 <CAJZ5v0i5jpJswD7KV5RPm_HvzB+B=Rt3gY0s_Z3fn5wbJz0ebw@mail.gmail.com> <20240430114534.0000600e@huawei.com>
In-Reply-To: <20240430114534.0000600e@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 12:47:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hsJBmphEg8gjehtmtzt0Q=Rox1B_qBFrxp15nHvb6o5A@mail.gmail.com>
Message-ID: <CAJZ5v0hsJBmphEg8gjehtmtzt0Q=Rox1B_qBFrxp15nHvb6o5A@mail.gmail.com>
Subject: Re: [PATCH v8 04/16] ACPI: processor: Move checks and availability of
 acpi_processor earlier
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Gavin Shan <gshan@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	Russell King <linux@armlinux.org.uk>, Miguel Luis <miguel.luis@oracle.com>, 
	James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com, justin.he@arm.com, 
	jianyong.wu@arm.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:45=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 30 Apr 2024 12:17:38 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > On Tue, Apr 30, 2024 at 12:13=E2=80=AFPM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 30 Apr 2024 10:28:38 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >
> > > > On Tue, 30 Apr 2024 14:17:24 +1000
> > > > Gavin Shan <gshan@redhat.com> wrote:
> > > >
> > > > > On 4/26/24 23:51, Jonathan Cameron wrote:
> > > > > > Make the per_cpu(processors, cpu) entries available earlier so =
that
> > > > > > they are available in arch_register_cpu() as ARM64 will need ac=
cess
> > > > > > to the acpi_handle to distinguish between acpi_processor_add()
> > > > > > and earlier registration attempts (which will fail as _STA cann=
ot
> > > > > > be checked).
> > > > > >
> > > > > > Reorder the remove flow to clear this per_cpu() after
> > > > > > arch_unregister_cpu() has completed, allowing it to be used in
> > > > > > there as well.
> > > > > >
> > > > > > Note that on x86 for the CPU hotplug case, the pr->id prior to
> > > > > > acpi_map_cpu() may be invalid. Thus the per_cpu() structures
> > > > > > must be initialized after that call or after checking the ID
> > > > > > is valid (not hotplug path).
> > > > > >
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > >
> > > > > > ---
> > > > > > v8: On buggy bios detection when setting per_cpu structures
> > > > > >      do not carry on.
> > > > > >      Fix up the clearing of per cpu structures to remove unwant=
ed
> > > > > >      side effects and ensure an error code isn't use to referen=
ce them.
> > > > > > ---
> > > > > >   drivers/acpi/acpi_processor.c | 79 +++++++++++++++++++++-----=
---------
> > > > > >   1 file changed, 48 insertions(+), 31 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_=
processor.c
> > > > > > index ba0a6f0ac841..3b180e21f325 100644
> > > > > > --- a/drivers/acpi/acpi_processor.c
> > > > > > +++ b/drivers/acpi/acpi_processor.c
> > > > > > @@ -183,8 +183,38 @@ static void __init acpi_pcc_cpufreq_init(v=
oid) {}
> > > > > >   #endif /* CONFIG_X86 */
> > > > > >
> > > > > >   /* Initialization */
> > > > > > +static DEFINE_PER_CPU(void *, processor_device_array);
> > > > > > +
> > > > > > +static bool acpi_processor_set_per_cpu(struct acpi_processor *=
pr,
> > > > > > +                                struct acpi_device *device)
> > > > > > +{
> > > > > > + BUG_ON(pr->id >=3D nr_cpu_ids);
> > > > >
> > > > > One blank line after BUG_ON() if we need to follow original imple=
mentation.
> > > >
> > > > Sure unintentional - I'll put that back.
> > > >
> > > > >
> > > > > > + /*
> > > > > > +  * Buggy BIOS check.
> > > > > > +  * ACPI id of processors can be reported wrongly by the BIOS.
> > > > > > +  * Don't trust it blindly
> > > > > > +  */
> > > > > > + if (per_cpu(processor_device_array, pr->id) !=3D NULL &&
> > > > > > +     per_cpu(processor_device_array, pr->id) !=3D device) {
> > > > > > +         dev_warn(&device->dev,
> > > > > > +                  "BIOS reported wrong ACPI id %d for the proc=
essor\n",
> > > > > > +                  pr->id);
> > > > > > +         /* Give up, but do not abort the namespace scan. */
> > > > >
> > > > > It depends on how the return value is handled by the caller if th=
e namespace
> > > > > is continued to be scanned. The caller can be acpi_processor_hota=
dd_init()
> > > > > and acpi_processor_get_info() after this patch is applied. So I t=
hink this
> > > > > specific comment need to be moved to the caller.
> > > >
> > > > Good point. This gets messy and was an unintended change.
> > > >
> > > > Previously the options were:
> > > > 1) acpi_processor_get_info() failed for other reasons - this code w=
as never called.
> > > > 2) acpi_processor_get_info() succeeded without acpi_processor_hotad=
d_init (non hotplug)
> > > >    this code then ran and would paper over the problem doing a bunc=
h of cleanup under err.
> > > > 3) acpi_processor_get_info() succeeded with acpi_processor_hotadd_i=
nit called.
> > > >    This code then ran and would paper over the problem doing a bunc=
h of cleanup under err.
> > > >
> > > > We should maintain that or argue cleanly against it.
> > > >
> > > > This isn't helped the the fact I have no idea which cases we care a=
bout for that bios
> > > > bug handling.  Do any of those bios's ever do hotplug?  Guess we ha=
ve to try and maintain
> > > > whatever protection this was offering.
> > > >
> > > > Also, the original code leaks data in some paths and I have limited=
 idea
> > > > of whether it is intentional or not. So to tidy the issue up that y=
ou've identified
> > > > I'll need to try and make that code consistent first.
> > > >
> > > > I suspect the only way to do that is going to be to duplicate the a=
llocations we
> > > > 'want' to leak to deal with the bios bug detection.
> > > >
> > > > For example acpi_processor_get_info() failing leaks pr and pr->thro=
ttling.shared_cpu_map
> > > > before this series. After this series we need pr to leak because it=
's used for the detection
> > > > via processor_device_array.
> > > >
> > > > I'll work through this but it's going to be tricky to tell if we ge=
t right.
> > > > Step 1 will be closing the existing leaks and then we will have som=
ething
> > > > consistent to build on.
> > > >
> > > I 'think' that fixing the original leaks makes this all much more str=
aight forward.
> > > That return 0 for acpi_processor_get_info() never made sense as far a=
s I can tell.
> > > The pr isn't used after this point.
> > >
> > > What about something along lines of.
> > >
> > > diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_proces=
sor.c
> > > index 161c95c9d60a..97cff4492304 100644
> > > --- a/drivers/acpi/acpi_processor.c
> > > +++ b/drivers/acpi/acpi_processor.c
> > > @@ -392,8 +392,10 @@ static int acpi_processor_add(struct acpi_device=
 *device,
> > >         device->driver_data =3D pr;
> > >
> > >         result =3D acpi_processor_get_info(device);
> > > -       if (result) /* Processor is not physically present or unavail=
able */
> > > -               return 0;
> > > +       if (result) { /* Processor is not physically present or unava=
ilable */
> > > +               result =3D 0;
> >
> > As per my previous message (just sent) this should be an error code,
> > as returning 0 from acpi_processor_add() is generally problematic.
> Ok. I'll switch to that, but as a separate precusor patch. Independent of
> the memory leak fixes.

Sure, thank you!

