Return-Path: <linux-arch+bounces-12954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E43CFB11D63
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 13:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1994E350E
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604482E5417;
	Fri, 25 Jul 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx1lljtM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938E2114;
	Fri, 25 Jul 2025 11:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442540; cv=none; b=W7/bC1wUB1O3vK8WtXziosiqzTkMfetAZeTGLWCrIpjQnqYxk/Nlc2oj4cPgOh3FEMqrK/46bHeWjg3D4hxQFRinGpIIneQJ6HF7dClD+lot4hputBegRW6b7/H5te4hbv/39JjvmhGX0Syi+MYK7KzdbScNQzeZ6dvyXhX1MzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442540; c=relaxed/simple;
	bh=fZuK3vdmjJWaBTc7PamARiPpTkZpxcdOqQIZTB73QlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohoYG5rEjNoeVjOb+fX70c6JwW5p140lnnxArtyQD240o4vOGfwnHBDAxAl2IlAIz7M0BDk5oVpg0vYRLVKLKcRIyy44Vnv4+oykfISMF6xdXRsPxlvYRO2QeqH2QagJ2hFYBvD1z3IsHsJ1HqvsRzh96p7V7mifI+suWgJ7SDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jx1lljtM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23dc5bcf49eso26044465ad.2;
        Fri, 25 Jul 2025 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753442538; x=1754047338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADeETAaHqfwPNv47VY+2a6NqZqg/PEaiSFoloJQbRjk=;
        b=Jx1lljtMzuT0m5VpNoGhEp4micnltFkmKTk/VTuLNa/8WgLVgEPBhPL9hVNJnUzzAh
         HySa4ktHNfJKEAxqX+z7Fk8MxnpcbKh9wi0KDAOtMMxc80e0ZkHXrh6I5dDCwcKxCDIj
         /Fvp0pvEr9BFAPVJrzamgXfwyYlwPQgsH1RaLsGuJUToLNOrHu6LlDltGbAkEOQItBnA
         LP4Kxrk9WdPnh2LKNgmZeYdlSu2xYo5o4+0oKSTxVU6Pi36fSjPuLEcAzjL019yceEY2
         nb5Yio0DqJs7lwGhJ4t6IR0PmJ2FmcRcdaf4EKHd1BIQCGJIJL4yKSZaeSrvYVI8sI2i
         slNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753442538; x=1754047338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADeETAaHqfwPNv47VY+2a6NqZqg/PEaiSFoloJQbRjk=;
        b=orrKmC1eJOwCMyN2MZVyTBrSFmfLJR9SQc+D1NG/dYGLilHdwgdZhwVcMU7D/Go8YC
         oxoR+9rmHgOKxPeNe4ge6+mR9erSaSEAPS6Mum3I2CVBRG+B6oqMGSHTuLzvTuXYJRZn
         8DC6vlVqlZxCOFPWtNnk5mACWMF1msHqcw/RAKIYt/bcl1wJede3s1TNDzuTuZ66C58x
         epiySbPj92YMazpCeQR7CQ0NWhCRzxxsat0TcBXaXLS5bLvLZXTbLPz3GHns1jb0etLi
         iyoYvyJgv5oK7kAUgn0/2LxdE9A3Kq9lwB+KqN3Zk3k+irHYGa2JOSkzGCRkTuNa1jMp
         wh/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh0LGni5EGKN83Fe2qUJdfC/2VFr12IEzXccdhcgK63hV4gF/NsN/5FvTSMWgf00Fdf+0+Lo4XNhlN@vger.kernel.org, AJvYcCVuScbPNv7XFA2y8FfQYFcafj86GGcK+TNP72ZvdNQp06ziZmed/jPb+OBsOpsQkCwdONOLVSxZnT2a+TbA@vger.kernel.org, AJvYcCVwDJy7nuDXeuk/eX4YaSxBC9afu0uTsefJldMa6tCSwuuLzDlS154SQB+D0EgVFeDoTnRy542HjUyG@vger.kernel.org, AJvYcCWjiaV1L5hczHVpSvdr3GnxBuQBzgHYqof87VEgyX8NKoyusd/xpV6L2M/9iPgqa/iKNI+5AwqtYIPS5rwP@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7tR1mB6vJ349B22C3/hM610lt01pxO3DO9Fn0P2f3sy4zStz
	QMzEoAyeIpJ4F5suLGuy9kTUSiXvQfkGf2wW2Nuop09I1dSvY+AzEdeeNZJ8nd1qpihqnZ3V26z
	8+unT8O+m/5M8j3dmz9jWpYHPhHRE2ec=
X-Gm-Gg: ASbGnctD+TqCDLolje63K70nMPhoBh0qZvMNhRBLffgh9mTNDRraoJIQIAgeejASr9d
	ISgcXcL0dP0zhMVtr9Vo0GATmx9hB2on0fTvbbAE5MSG3/KNx0Ws0zPxYI/RnVkBJCFkbDhlU1d
	KoJhzvtWiOap3v+Tl3oKFln5mYUHaOFtcaJggrJc3DW22Yh4ddw+IcR1QufVFvuI238jNaPztwr
	odw
X-Google-Smtp-Source: AGHT+IFm+YK+Y2hJQQ1hmtCwNSUBVL0UvD5jayHigUFo6GG8rs5V2CGFs8VME+5GxbAPEVs93coICnPBamAwKQyY/yk=
X-Received: by 2002:a17:902:ccc4:b0:234:e8db:432d with SMTP id
 d9443c01a7336-23fb3166c33mr22847705ad.39.1753442538032; Fri, 25 Jul 2025
 04:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714221545.5615-1-romank@linux.microsoft.com> <20250714221545.5615-11-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-11-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 25 Jul 2025 19:21:42 +0800
X-Gm-Features: Ac12FXyz3bssr1OLL9BFtYmc0Edy0F9YKk5P-0fTYGoeZUcLahAw8xTcKbOlq4Q
Message-ID: <CAMvTesADrxV4vwU_mqYygm1bE39PKLZaaL-wLPT8snATRVkwNg@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v4 10/16] Drivers: hv: Rename the SynIC enable
 and disable routines
To: Roman Kisel <romank@linux.microsoft.com>
Cc: alok.a.tiwari@oracle.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, 
	dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, 
	hpa@zytor.com, kys@microsoft.com, mhklinux@outlook.com, mingo@redhat.com, 
	rdunlap@infradead.org, tglx@linutronix.de, Tianyu.Lan@microsoft.com, 
	wei.liu@kernel.org, linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com, 
	benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:16=E2=80=AFAM Roman Kisel <romank@linux.microsoft=
.com> wrote:
>
> The confidential VMBus requires support for the both hypervisor
> facing SynIC and the paravisor one.
>
> Rename the functions that enable and disable SynIC with the
> hypervisor. No functional changes.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c |  2 +-
>  drivers/hv/hv.c           | 11 ++++++-----
>  drivers/hv/hyperv_vmbus.h |  4 ++--
>  drivers/hv/vmbus_drv.c    |  6 +++---
>  4 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 6f87220e2ca3..ca2fe10c110a 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -845,7 +845,7 @@ static void vmbus_wait_for_unload(void)
>                         /*
>                          * In a CoCo VM the hyp_synic_message_page is not=
 allocated
>                          * in hv_synic_alloc(). Instead it is set/cleared=
 in
> -                        * hv_synic_enable_regs() and hv_synic_disable_re=
gs()
> +                        * hv_hyp_synic_enable_regs() and hv_hyp_synic_di=
sable_regs()
>                          * such that it is set only when the CPU is onlin=
e. If
>                          * not all present CPUs are online, the message p=
age
>                          * might be NULL, so skip such CPUs.
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index a8669843c56e..94a81bb3c8c7 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -266,9 +266,10 @@ void hv_synic_free(void)
>  }
>
>  /*
> - * hv_synic_enable_regs - Initialize the Synthetic Interrupt Controller.
> + * hv_hyp_synic_enable_regs - Initialize the Synthetic Interrupt Control=
ler
> + * with the hypervisor.
>   */
> -void hv_synic_enable_regs(unsigned int cpu)
> +void hv_hyp_synic_enable_regs(unsigned int cpu)
>  {
>         struct hv_per_cpu_context *hv_cpu =3D
>                 per_cpu_ptr(hv_context.cpu_context, cpu);
> @@ -334,14 +335,14 @@ void hv_synic_enable_regs(unsigned int cpu)
>
>  int hv_synic_init(unsigned int cpu)
>  {
> -       hv_synic_enable_regs(cpu);
> +       hv_hyp_synic_enable_regs(cpu);
>
>         hv_stimer_legacy_init(cpu, VMBUS_MESSAGE_SINT);
>
>         return 0;
>  }
>
> -void hv_synic_disable_regs(unsigned int cpu)
> +void hv_hyp_synic_disable_regs(unsigned int cpu)
>  {
>         struct hv_per_cpu_context *hv_cpu =3D
>                 per_cpu_ptr(hv_context.cpu_context, cpu);
> @@ -528,7 +529,7 @@ int hv_synic_cleanup(unsigned int cpu)
>  always_cleanup:
>         hv_stimer_legacy_cleanup(cpu);
>
> -       hv_synic_disable_regs(cpu);
> +       hv_hyp_synic_disable_regs(cpu);
>
>         return ret;
>  }
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 16b5cf1bca19..2873703d08a9 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -189,10 +189,10 @@ extern int hv_synic_alloc(void);
>
>  extern void hv_synic_free(void);
>
> -extern void hv_synic_enable_regs(unsigned int cpu);
> +extern void hv_hyp_synic_enable_regs(unsigned int cpu);
>  extern int hv_synic_init(unsigned int cpu);
>
> -extern void hv_synic_disable_regs(unsigned int cpu);
> +extern void hv_hyp_synic_disable_regs(unsigned int cpu);
>  extern int hv_synic_cleanup(unsigned int cpu);
>
>  /* Interface */
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 72940a64b0b6..13aca5abc7d8 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2809,7 +2809,7 @@ static void hv_crash_handler(struct pt_regs *regs)
>          */
>         cpu =3D smp_processor_id();
>         hv_stimer_cleanup(cpu);
> -       hv_synic_disable_regs(cpu);
> +       hv_hyp_synic_disable_regs(cpu);
>  };
>
>  static int hv_synic_suspend(void)
> @@ -2834,14 +2834,14 @@ static int hv_synic_suspend(void)
>          * interrupts-disabled context.
>          */
>
> -       hv_synic_disable_regs(0);
> +       hv_hyp_synic_disable_regs(0);
>
>         return 0;
>  }
>
>  static void hv_synic_resume(void)
>  {
> -       hv_synic_enable_regs(0);
> +       hv_hyp_synic_enable_regs(0);
>
>         /*
>          * Note: we don't need to call hv_stimer_init(0), because the tim=
er
> --
> 2.43.0
>
>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
--=20
Thanks
Tianyu Lan

