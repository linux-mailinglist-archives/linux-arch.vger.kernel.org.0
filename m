Return-Path: <linux-arch+bounces-10608-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B811DA59586
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 14:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702F93A31A4
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAA622371A;
	Mon, 10 Mar 2025 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AebViPUq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009C2206A3;
	Mon, 10 Mar 2025 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611745; cv=none; b=qEmpm290tZizm7DIz9yqJQeyDgUlqnx4GK/AKR96hkzW5krY1Iu5S6yu32W0Uhp+mwPHSCqG0gpdmiM5RtlhQUc1PbaNVe0NmSvjUULWLZrVLXoWvaN1xXKZHD88GzcDWMcouJzdpnW7ea4wxGoWTm25q9BBpJZ7S1drNig7TcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611745; c=relaxed/simple;
	bh=9/MF3XwBaT1mcfL5fB1uFCtt3JgTm87/jrTxjrGckLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKqlZCAduLMaCsK/kFlVjVJMpGG7OzUBgKRSu8MnNVjLdOBCY6Z0kV88ecaG+4Ev15N4DbaeuXixerBjDfuNygy775fncokonC3S981RKK+jnsH6Oxyblawyki/1yWRPBE5b70aHU4bdZf/vpcQxFlRI3khIroQLLESObWM5mMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AebViPUq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso452450f8f.2;
        Mon, 10 Mar 2025 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741611742; x=1742216542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJsBCZAbkaqGsMqWjDYIUsmWMaDSGMkISy1d3AfV0dM=;
        b=AebViPUqs5QZp+3p60eYU2Rsy8oBE8LeXgioAAQgZVo2cQ/pexTGIjjBTjbmHJqyQm
         3uBHKJyhgD9km+2iD2eJ97LhJ7TLjE6jgATXV86SVot+/knqJSZP3/a6YmfyjXAwKqes
         w4oHaoOBJTBGzIYwPfgjychlci3NkgOkXLTyUxWc+6DCRva/dkd/u0GrUDTDprYKqo7K
         XfQP3vN053atwvtViADAf2YZ/p/H2LGUoGK/++G6kvcqF8aVePK+xu29oOaXXrN85U+E
         +/xIVt3xZK3cGwMJRg9iN3rlLHCNQauhlY+Is5iq40YyUFhjSdEO5JOLXzINHQLNQP/s
         7auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741611742; x=1742216542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJsBCZAbkaqGsMqWjDYIUsmWMaDSGMkISy1d3AfV0dM=;
        b=abB+dfwnaFR3A5d4PjXK9GG27dgJk7yNijp91Oo/ecNcWKu6b0yir/SXCYynQR2LuO
         0+KPUGVyjg4LfappZbjzRXg0s79djJJ1QTl+09jnA4lBk979GSga/3FJgxkPZUQon6el
         /k80mDh4HlGYI8G8nGqUT7nOjl6a19nyPRYimvl6ba/flu073/GwLYdQ5Ko8PpD03JH3
         IeEcDrtGnWCXk5iaaxQG9OS8a6uyBpEpN4cuBjeEKX5K+/dOYhGqDeved13Sir6XX/za
         aJiJh0H2WSar+uBstwXoFMGvh1TdmBPPi0ZNSZNnxMsZE7deqzaiLmj9+KXHKPvyNbME
         oxqw==
X-Forwarded-Encrypted: i=1; AJvYcCVER1ZUdYrTlNjidZyUiJ8UCT0Z/KRz4AUMSyEA/R4IH84d4QcgAOI+pTGI9NbmO7KcXqTqTtU0VOSrirlk@vger.kernel.org, AJvYcCVemK4prfmhU0Eag0lim0NS/LQI8pEEoSJ4wSsUIVXxy9ffPSsWgbBQRcTqTyZR4wzcAoTvOP2FgOnS@vger.kernel.org, AJvYcCW33WL0G1G9aLDDQkceKx2c7EjEe6R8W5+BO+TErLo3C536hncHXeKsHFxLznwZ8hSc6yNCbFsJJfY20g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYeli+guZlaB0mGXmpyyNcrPvNiKXlo8Fc5V7EgkrbAjI3maV
	i7xRgfZZxEKyS8GI7RSDRVplMHsUWRmO/+1OjkIAGQSde46FtxsCannDOvu+4jiP3uRmDAJzByi
	OeEfOa2aAwUH6eJvy2DNnPcfsNR4=
X-Gm-Gg: ASbGnctcrn+m6tcBSaUk2WrR3UFJrFwiefR3ctIGNrDUerCuAmjUrA+NzURwtVseEih
	1lJxaNr9rpUzQ+epihZgimy0ZOMSI6wa2+sbuwSDIuUpnFEOMDOFm2CS5K9wOMbd8yEyBsj26w5
	tyoEANkGVQPgiyDmZF+DQOJcyPnTB6uqPjBPu03cnkj61j
X-Google-Smtp-Source: AGHT+IGaxbWiEzsbhn8u7OT4l7aLcqESH5XxF4YWsiFb1XdbKvnztHuQze3R8m7aqPgVjjpK0+JYaE4xvj1QZAkWR9c=
X-Received: by 2002:a05:6000:1f8f:b0:391:304f:34e7 with SMTP id
 ffacd0b85a97d-39132d985f6mr9687116f8f.44.1741611742101; Mon, 10 Mar 2025
 06:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To: <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Mon, 10 Mar 2025 21:01:45 +0800
X-Gm-Features: AQ5f1Jq0GptIRLQ74YOF7jUY6vVGVBckkuZztDE6uDxvc_UbKBeBzzaPI8HiFPA
Message-ID: <CAMvTesAW-9Mo0oY6UUh2anp6DQCSsVCUhBiV2-bKp2VD_N0DYw@mail.gmail.com>
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

On Thu, Feb 27, 2025 at 7:09=E2=80=AFAM Nuno Das Neves
<nunodasneves@linux.microsoft.com> wrote:
>
> Add a pointer hv_synic_eventring_tail to track the tail pointer for the
> SynIC event ring buffer for each SINT.
>
> This will be used by the mshv driver, but must be tracked independently
> since the driver module could be removed and re-inserted.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>

It's better to expose a function to check the tail instead of exposing
hv_synic_eventring_tail directly.

BTW, how does mshv driver use hv_synic_eventring_tail? Which patch
uses it in this series?

Thanks.


> ---
>  drivers/hv/hv_common.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 252fd66ad4db..2763cb6d3678 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -68,6 +68,16 @@ static void hv_kmsg_dump_unregister(void);
>
>  static struct ctl_table_header *hv_ctl_table_hdr;
>
> +/*
> + * Per-cpu array holding the tail pointer for the SynIC event ring buffe=
r
> + * for each SINT.
> + *
> + * We cannot maintain this in mshv driver because the tail pointer shoul=
d
> + * persist even if the mshv driver is unloaded.
> + */
> +u8 __percpu **hv_synic_eventring_tail;
> +EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
> +
>  /*
>   * Hyper-V specific initialization and shutdown code that is
>   * common across all architectures.  Called from architecture
> @@ -90,6 +100,9 @@ void __init hv_common_free(void)
>
>         free_percpu(hyperv_pcpu_input_arg);
>         hyperv_pcpu_input_arg =3D NULL;
> +
> +       free_percpu(hv_synic_eventring_tail);
> +       hv_synic_eventring_tail =3D NULL;
>  }
>
>  /*
> @@ -372,6 +385,11 @@ int __init hv_common_init(void)
>                 BUG_ON(!hyperv_pcpu_output_arg);
>         }
>
> +       if (hv_root_partition()) {
> +               hv_synic_eventring_tail =3D alloc_percpu(u8 *);
> +               BUG_ON(hv_synic_eventring_tail =3D=3D NULL);
> +       }
> +
>         hv_vp_index =3D kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
>                                     GFP_KERNEL);
>         if (!hv_vp_index) {
> @@ -460,6 +478,7 @@ void __init ms_hyperv_late_init(void)
>  int hv_common_cpu_init(unsigned int cpu)
>  {
>         void **inputarg, **outputarg;
> +       u8 **synic_eventring_tail;
>         u64 msr_vp_index;
>         gfp_t flags;
>         const int pgcount =3D hv_output_page_exists() ? 2 : 1;
> @@ -472,8 +491,8 @@ int hv_common_cpu_init(unsigned int cpu)
>         inputarg =3D (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>
>         /*
> -        * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is alr=
eady
> -        * allocated if this CPU was previously online and then taken off=
line
> +        * The per-cpu memory is already allocated if this CPU was previo=
usly
> +        * online and then taken offline
>          */
>         if (!*inputarg) {
>                 mem =3D kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
> @@ -485,6 +504,17 @@ int hv_common_cpu_init(unsigned int cpu)
>                         *outputarg =3D (char *)mem + HV_HYP_PAGE_SIZE;
>                 }
>
> +               if (hv_root_partition()) {
> +                       synic_eventring_tail =3D (u8 **)this_cpu_ptr(hv_s=
ynic_eventring_tail);
> +                       *synic_eventring_tail =3D kcalloc(HV_SYNIC_SINT_C=
OUNT,
> +                                                       sizeof(u8), flags=
);
> +
> +                       if (unlikely(!*synic_eventring_tail)) {
> +                               kfree(mem);
> +                               return -ENOMEM;
> +                       }
> +               }
> +
>                 if (!ms_hyperv.paravisor_present &&
>                     (hv_isolation_type_snp() || hv_isolation_type_tdx()))=
 {
>                         ret =3D set_memory_decrypted((unsigned long)mem, =
pgcount);
> --
> 2.34.1
>
>


--=20
Thanks
Tianyu Lan

