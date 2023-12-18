Return-Path: <linux-arch+bounces-1127-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D2E817BC3
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 21:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C732E285AB6
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 20:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D572061;
	Mon, 18 Dec 2023 20:22:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6321348784;
	Mon, 18 Dec 2023 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6da682dcf66so513815a34.1;
        Mon, 18 Dec 2023 12:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702930934; x=1703535734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGmAXhjX5Y4s1RFRjJ9B0I+ERw19f5OL+MbL6CYALRM=;
        b=Ewc749Ov3tSnW7kxInzjvOz9y0X89L9WZH5F2NhPIGtsqEZ0G3Bx8BbhqRfEXQM535
         9BKkPq9xcP2VSSAvYyUJuKh0WkxJ51Zb09XIk8hxOG0R+XMh1et5DyeqV2EVd8myWWad
         8EfoF5Q62zb1QPX307G8jvFIs3EdVQ3H1am29PtWmsIiMpfrlp2kbW4SeLWQwReZptHf
         XcwtWMTBDi8NskJtEPfvTMSQNY5ZNAMBPp3EMuk08KOa81A0TY9AHCQLWAN0VKOAmUAJ
         q7u7Fwss5mGw7nlbT64mZQG4bfHTpQcgcPZOAfi+MvQ7nzD8OaRLwa/5td20uFIOR0k0
         R/XQ==
X-Gm-Message-State: AOJu0YznsevHnQ91cbokb1kD3rUeOQn3+y1Gtls3UVoMEBS6NTJVMyNL
	5adZuJRLjyjxVowXRYwpOfvLjqrLKd9TtuykCu07b6JX
X-Google-Smtp-Source: AGHT+IFFmOzyX7COzVhRLC4hkeEXc2MIlTmVhC4D34QheVfbqsxG755bG+zIachM1eZIx9UOshFO0sQ+BYaFyFhhPA4=
X-Received: by 2002:a4a:a581:0:b0:591:cdc0:f28d with SMTP id
 d1-20020a4aa581000000b00591cdc0f28dmr5277719oom.0.1702930934339; Mon, 18 Dec
 2023 12:22:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk> <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Dec 2023 21:22:03 +0100
Message-ID: <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev, 
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

On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> ACPI has two descriptions of CPUs, one in the MADT/APIC table, the other
> in the DSDT. Both are required. (ACPI 6.5's 8.4 "Declaring Processors"
> says "Each processor in the system must be declared in the ACPI
> namespace"). Having two descriptions allows firmware authors to get
> this wrong.
>
> If CPUs are described in the MADT/APIC, they will be brought online
> early during boot. Once the register_cpu() calls are moved to ACPI,
> they will be based on the DSDT description of the CPUs. When CPUs are
> missing from the DSDT description, they will end up online, but not
> registered.
>
> Add a helper that runs after acpi_init() has completed to register
> CPUs that are online, but weren't found in the DSDT. Any CPU that
> is registered by this code triggers a firmware-bug warning and kernel
> taint.
>
> Qemu TCG only describes the first CPU in the DSDT, unless cpu-hotplug
> is configured.

So why is this a kernel problem?

> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/acpi/acpi_processor.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.=
c
> index 6a542e0ce396..0511f2bc10bc 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -791,6 +791,25 @@ void __init acpi_processor_init(void)
>         acpi_pcc_cpufreq_init();
>  }
>
> +static int __init acpi_processor_register_missing_cpus(void)
> +{
> +       int cpu;
> +
> +       if (acpi_disabled)
> +               return 0;
> +
> +       for_each_online_cpu(cpu) {
> +               if (!get_cpu_device(cpu)) {
> +                       pr_err_once(FW_BUG "CPU %u has no ACPI namespace =
description!\n", cpu);
> +                       add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STIL=
L_OK);
> +                       arch_register_cpu(cpu);

Which part of this code is related to ACPI?

> +               }
> +       }
> +
> +       return 0;
> +}
> +subsys_initcall_sync(acpi_processor_register_missing_cpus);
> +
>  #ifdef CONFIG_ACPI_PROCESSOR_CSTATE
>  /**
>   * acpi_processor_claim_cst_control - Request _CST control from the plat=
form.
> --

