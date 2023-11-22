Return-Path: <linux-arch+bounces-385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873087F514F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 21:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94BC1C20AFC
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 20:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F445D90B;
	Wed, 22 Nov 2023 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F23A4;
	Wed, 22 Nov 2023 12:12:16 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1d542f05b9aso30635fac.1;
        Wed, 22 Nov 2023 12:12:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683935; x=1701288735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRAUhzzHnP+XZxzQEXs8TfAKCs5HsmLQBIFGrTTFm+M=;
        b=J932pq15PT2CkREZCSSNK0BlpQ0nqyfU+osRNkVIv3m87wFFPEovtx968w3ftk0mrR
         L4BJjIXOmkY3RasRwH2E4xZO9jCM1zIdVITtVND9wfwmf9KTZo6AbAaJg2ahocJbgEJP
         m9Ogi/7pgWxW7e5JL7XLI6aAdofpE0Lgu0HN+YIgvEtJhAjukunww7j7Fce3cNFvRRKH
         Vm/E11BfpPS1ZTW6/sWS+Wi7sgtlW17oYIMqq/48VwGC3Z+/1+qLoZgadILNEyFcgOFU
         m1q7StboXi64wXeLFB+302Rbsvrnkbji6zf483imMzQvQKawJbcP2kAReb/qGNLljMoM
         Mvvw==
X-Gm-Message-State: AOJu0YyPK8bkC9ADQ/dhTSY789AKLC2Pe78CyyhPxQ2Vt5CM789NFZ4g
	KRX6YSzf7Lwud5nlfKxe2pWSPlwaMCUtiKsdwRU=
X-Google-Smtp-Source: AGHT+IH/N9ldr6Rfz2HMts22gtDdEZrdomZQ3Wqdv4io0UUWkzkPpVzYdpFHz7cSkxilm43rTrV9+lWFNT1vpjiJ/R4=
X-Received: by 2002:a05:6871:a58b:b0:1ea:1510:d8df with SMTP id
 wd11-20020a056871a58b00b001ea1510d8dfmr3742289oab.4.1700683935194; Wed, 22
 Nov 2023 12:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk> <E1r5R2m-00Csyb-2S@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1r5R2m-00Csyb-2S@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Nov 2023 21:12:04 +0100
Message-ID: <CAJZ5v0jbjykNooJ_PvkOjpE6hA0QFJUw+kpwYfNY7jOtkcPA0Q@mail.gmail.com>
Subject: Re: [PATCH 02/21] x86: intel_epb: Don't rely on link order
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, 
	Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com, 
	justin.he@arm.com, James Morse <james.morse@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 2:44=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> intel_epb_init() is called as a subsys_initcall() to register cpuhp
> callbacks. The callbacks make use of get_cpu_device() which will return
> NULL unless register_cpu() has been called. register_cpu() is called
> from topology_init(), which is also a subsys_initcall().
>
> This is fragile. Moving the register_cpu() to a different
> subsys_initcall()  leads to a NULL dereference during boot.
>
> Make intel_epb_init() a late_initcall(), user-space can't provide a
> policy before this point anyway.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'd suggest sending this separately to the x86 list.

> ---
> subsys_initcall_sync() would be an option, but moving the register_cpu()
> calls into ACPI also means adding a safety net for CPUs that are online
> but not described properly by firmware. This lives in subsys_initcall_syn=
c().
> ---
>  arch/x86/kernel/cpu/intel_epb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_=
epb.c
> index e4c3ba91321c..f18d35fe27a9 100644
> --- a/arch/x86/kernel/cpu/intel_epb.c
> +++ b/arch/x86/kernel/cpu/intel_epb.c
> @@ -237,4 +237,4 @@ static __init int intel_epb_init(void)
>         cpuhp_remove_state(CPUHP_AP_X86_INTEL_EPB_ONLINE);
>         return ret;
>  }
> -subsys_initcall(intel_epb_init);
> +late_initcall(intel_epb_init);
> --
> 2.30.2
>
>

