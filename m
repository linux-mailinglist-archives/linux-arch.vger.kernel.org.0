Return-Path: <linux-arch+bounces-10739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E455A5FAE6
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D583B84B4
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9859271294;
	Thu, 13 Mar 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNVq7oOb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107627127A;
	Thu, 13 Mar 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741881658; cv=none; b=ngcr3bBRD8kn4ZoOsVw+XbYPvXPts4P4akRUdf4LTVXOLIsnwqFqpOsvc/CoczrK8Fo+Y7xSAYJUUyjTfPW9Dic0Via7+PeftH9/mcwi04nhZds53F7mShlQktDOoZo1hzY3O8YmEdLgqDc5RXddNdiBYqp2yyCV45GpRImvV7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741881658; c=relaxed/simple;
	bh=XKJtQZcokXscej3N2IxWQOYBMNaKiqVcS1bZEjhfI90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWFcn38+q5Jn51VfIxtL/fNSOFK7e0RBO4V6OBr6QVSWB0HTZ4tKElRXVkOxE9ggEKdP5QsJEjIV2A6GnwzhbVo4OxS+5oZwn6EYOcJcKiOR4KzJb64EMaOX6DIEA/VElR+NtkR8xKZaSh8M1KpEQijaKYoq+9gtTGv2VhBZ3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNVq7oOb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so2001766a12.0;
        Thu, 13 Mar 2025 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741881655; x=1742486455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Qhu1Jf1lhWvYe/Q8L9Li1P5wGlP18gn8uz7AiBpY7E=;
        b=mNVq7oObMHqYyYYkL2eowfkX6OqG4/aof+Csz9sZWn14CcgZAMKD9JGhet4zNjDby/
         hlbJj11NoNuZXxln2fuwJ/zwL1jMsEbj2zrOUdwgvanoKQ2If42w8r69ExRq/dUr22Jj
         TJEw6Hx/4uOcSoXKj6KmKCqMuqZpaNhUYOLyEvk2R0UgesoAXuYIN/qFpWyTUufb+m+9
         N/3oaprWb2Tb8Syaa3pJva/8tJFDnZLIGL7TVf7msPDebJFhIuHhaCDprdIXQ0og+g+2
         LxIZt57IqNmVR6Qr9KNuGs9SLeycU2IFBisyoIek1vPuyJJJt0yNnAreZOrJMFuQr9KL
         9Cdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741881655; x=1742486455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Qhu1Jf1lhWvYe/Q8L9Li1P5wGlP18gn8uz7AiBpY7E=;
        b=aImnZKoCTiJHOG+lDfYb/IyJo7QFdcIVjbiyypOvfA7vJWz/Guud/x18bKTvH5RqdL
         tO1K4tDzkYO7MmH2mKOH9V+IZQsbfqILznMrqhGAAZJaRtHdP5bwFgMGJ8xaXLKR4o2l
         GfaARRnWe1F99QZummSg/lnR46lz5eGTVO3pX6ljCgCIZNMnx+dOrkrzQ1r+34YR2wlz
         NDJhjK6UprzoVJFyNbZ6F9K6UKxYXD8BMlKbEmLQdNo3YnCdln8xbE+uNKUaTFyrP9ay
         11EK2yIzk1GPsSEhuqE7jK+0Ygak+wMuXUFr260THMn1ENUOZYtgDS3G4NipQE/7UAk7
         3mpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9kS1wc9nqt5PMr+QKKVI44Pm9qqyR7zgQzdf78GmMeMVE6tlRzNeCkfJRZn1e+vUMKgSrRhLdcNBjDoYt@vger.kernel.org, AJvYcCVd+1sHfwC7LAY/TIgpe1rczQfIKHF7+29UKR1+tpsJL8X2ChktqBJs8/Wo/EQM09eBg6xvmAiKf0x3@vger.kernel.org, AJvYcCWEuJ1kGZogq+9tDW4gki1juw6HY0wD0b4q+aa9ngbjqWB8DRpeCZUWFJLUOB89rC9mxV5FFpIDh0I4LQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxd2C/1iICOa+cG3Pnnl3vsSZtcVyhbWg23otDGhMf6jIT9Sh7
	yzE5DZu52k6a0UniWuMxduWIHvTrNnGnj6mqvptkpr4bLfD7zE1CLXGtJ8IVo7H6dB3O5AnrRq1
	mPBySKjJOyqUS1NVXfgp68nZakIY=
X-Gm-Gg: ASbGncui0KqhgCpwQ0Ufb5UfYSjDAeF9WpNWoHUzO01oZccY3bMfbU+HCc3J4UQRjsL
	btTOBrxmJSkO9HsjxA8L4Slum6qkOh5Lnxm8p019p0Kx+nw+PhEK5xQngz8OUzyE5WyLd81e9/s
	favDqK8UcXYbv8/t6KC6mI8IyUb0MzA2ireaXGALBOlx+5
X-Google-Smtp-Source: AGHT+IF//s5JFhhMz1vXUsSDxcGZw1gNGBJyGuwueP01uLjPSgBsSzQhu+mR5NorVsyg5kbLscyeEYUe12nwcFZ/Fic=
X-Received: by 2002:a05:6402:2793:b0:5de:4b81:d3fd with SMTP id
 4fb4d7f45d1cf-5e5e22b8668mr33542305a12.13.1741881654811; Thu, 13 Mar 2025
 09:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
 <CAMvTesAW-9Mo0oY6UUh2anp6DQCSsVCUhBiV2-bKp2VD_N0DYw@mail.gmail.com>
 <5e3e8c30-912c-4fe3-bfac-1ae21242473b@linux.microsoft.com>
 <CAMvTesAPeLBfYVa5TGx-o6p+0g_Q1bn6s+nZK5i7NK8QGyfbTA@mail.gmail.com> <6ba21efb-7065-44d7-9cee-265a0c137f0c@linux.microsoft.com>
In-Reply-To: <6ba21efb-7065-44d7-9cee-265a0c137f0c@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 14 Mar 2025 00:00:18 +0800
X-Gm-Features: AQ5f1JoY20sfCYd5hoFXQ7-iNAPjORddneakJM5FpRpMqnWdK9ekAfBUaAWFCjI
Message-ID: <CAMvTesCUOTAkiGHq2eh9N7MA86-ZFbLTGaypjKHU8fE0cmc1Dg@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com, 
	decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org, 
	joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de, 
	jinankjain@linux.microsoft.com, muminulrussell@gmail.com, 
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com, 
	ssengar@linux.microsoft.com, apais@linux.microsoft.com, 
	Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com, 
	gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com, 
	muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org, 
	lenb@kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:56=E2=80=AFPM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> On 3/13/2025 12:34 AM, Tianyu Lan wrote:
> > On Thu, Mar 13, 2025 at 3:45=E2=80=AFAM Nuno Das Neves
> > <nunodasneves@linux.microsoft.com> wrote:
> >>
> >> On 3/10/2025 6:01 AM, Tianyu Lan wrote:
> >>> On Thu, Feb 27, 2025 at 7:09=E2=80=AFAM Nuno Das Neves
> >>> <nunodasneves@linux.microsoft.com> wrote:
> >>>>
> >>>> Add a pointer hv_synic_eventring_tail to track the tail pointer for =
the
> >>>> SynIC event ring buffer for each SINT.
> >>>>
> >>>> This will be used by the mshv driver, but must be tracked independen=
tly
> >>>> since the driver module could be removed and re-inserted.
> >>>>
> >>>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >>>> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> >>>
> >>> It's better to expose a function to check the tail instead of exposin=
g
> >>> hv_synic_eventring_tail directly.
> >>>
> >> What is the advantage of using a function for this? We need to both se=
t
> >> and get the tail.
> >
> > We may add lock or check to avoid race conditions and this depends on t=
he
> > user case. This is why I want to see how mshv driver uses it.
> >
> >>
> >>> BTW, how does mshv driver use hv_synic_eventring_tail? Which patch
> >>> uses it in this series?
> >>>
> >> This variable stores indices into the synic eventring page (one for ea=
ch
> >> SINT, and per-cpu). Each SINT has a ringbuffer of u32 messages. The ta=
il
> >> index points to the latest one.
> >>
> >> This is only used for doorbell messages today. The message in this cas=
e is
> >> a port number which is used to lookup and invoke a callback, which sig=
nals
> >> ioeventfd(s), to notify the VMM of a guest MMIO write.
> >>
> >> It is used in patch 10.
> >
> > I found "extern u8 __percpu **hv_synic_eventring_tail;" in the
> > drivers/hv/mshv_root.h of patch 10.
> > I seem to miss the code to use it.
> >
> > +int hv_call_unmap_stat_page(enum hv_stats_object_type type,
> > +                           const union hv_stats_object_identity *ident=
ity);
> > +int hv_call_modify_spa_host_access(u64 partition_id, struct page **pag=
es,
> > +                                  u64 page_struct_count, u32 host_acce=
ss,
> > +                                  u32 flags, u8 acquire);
> > +
> > +extern struct mshv_root mshv_root;
> > +extern enum hv_scheduler_type hv_scheduler_type;
> > +extern u8 __percpu **hv_synic_eventring_tail;
> > +
> > +#endif /* _MSHV_ROOT_H_ */
> >
>
> It is used in mshv_synic.c in synic_event_ring_get_queued_port():
>
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> new file mode 100644
> index 000000000000..e7782f92e339
> --- /dev/null
> +++ b/drivers/hv/mshv_synic.c
> @@ -0,0 +1,665 @@
> <snip>
> +static u32 synic_event_ring_get_queued_port(u32 sint_index)
> +{
> +       struct hv_synic_event_ring_page **event_ring_page;
> +       volatile struct hv_synic_event_ring *ring;
> +       struct hv_synic_pages *spages;
> +       u8 **synic_eventring_tail;
> +       u32 message;
> +       u8 tail;
> +
> +       spages =3D this_cpu_ptr(mshv_root.synic_pages);
> +       event_ring_page =3D &spages->synic_event_ring_page;
> +       synic_eventring_tail =3D (u8 **)this_cpu_ptr(hv_synic_eventring_t=
ail);
> +       tail =3D (*synic_eventring_tail)[sint_index];

OK. I got it. Thanks.

--=20
Thanks
Tianyu Lan

