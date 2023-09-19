Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024A17A56F4
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 03:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjISBYD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Sep 2023 21:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjISBYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Sep 2023 21:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1162010D
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 18:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695086590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rZEMBXcWAsOd1JUxhybBTc4j/duZaFTPteC/Fr9lkM=;
        b=FtA3w0XeVotf1iW5q6N+Vh9jAK/1v7a4TuX3AKoWOCUcCDL2uhzBhdGyTJISJgDXHeK6qt
        vVjFaQUYkYHCdEU8yyyekNPuAnk9+tqsxJLCW/8Nq1HsMuqFHiFny2GSYIzk/Q2hTEbiA2
        9EVjvlQ2grEjb8fU3cwn+I3Lf4r+VdY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-_3jdMWSpNoaXKNQ-7xSzPw-1; Mon, 18 Sep 2023 21:23:08 -0400
X-MC-Unique: _3jdMWSpNoaXKNQ-7xSzPw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1c4588f622aso17474375ad.2
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 18:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695086588; x=1695691388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rZEMBXcWAsOd1JUxhybBTc4j/duZaFTPteC/Fr9lkM=;
        b=gkpLR9UzabVG9hdI0RpTb6EjsTsNwguB7WtX38Z27LALJ7pgrzXgucJ8fU3MjYA1l0
         f0JEygCqeZYtdWU5Jwe3UBxtPGPaj0L+6LKG6cWc7CnrWUI8JfX0jE6LjgJ2lfQRbJ5q
         3OBaYJ2mZ9w2lvmki/nz0LKgZNRFdM586ZUBqPE3DQgfPIGTInGzkeRh2AFR7qCt9DjC
         MnGh28Ur+w3YNEucbFYhHjvBN5oZckZ+Gs1svdX38Xyqw5K2VFhJQbIjepKhPwqFCmGF
         RcANDxkUIEoMJpKCxB7LYsPYIOVhQSmr4twhmqQaVwp5K/o0p9UjY5XGkxtlr5Ic8L3c
         j9YQ==
X-Gm-Message-State: AOJu0YyY0BPrtcOit1yxBpZm3HE5gWKyAH71AsRoRDKH4HyEV7hvMWE5
        pgcY3uhOUq+/CV5WkOnHGuf/QHJhbKZYzmNRNNvrEVA1jAfWE5IIcCKdF3O3l2vk5aa0HLuM55n
        fl4NEhhHSOB50qsxR6R3ucg==
X-Received: by 2002:a17:902:d4c7:b0:1c3:c687:4793 with SMTP id o7-20020a170902d4c700b001c3c6874793mr10025102plg.63.1695086587821;
        Mon, 18 Sep 2023 18:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoDFw/kgFjKPQwWTf0Oet8p5HAvy+YamWqASTKA/sRdSVgiuLoUsA4+OwthgzDWlhTMjCURQ==
X-Received: by 2002:a17:902:d4c7:b0:1c3:c687:4793 with SMTP id o7-20020a170902d4c700b001c3c6874793mr10025086plg.63.1695086587495;
        Mon, 18 Sep 2023 18:23:07 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b001beef2c9bffsm8873509plg.85.2023.09.18.18.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 18:23:06 -0700 (PDT)
Message-ID: <f45820cf-3ea5-6f5a-7702-bb4b14811e56@redhat.com>
Date:   Tue, 19 Sep 2023 11:23:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 28/35] arm64, irqchip/gic-v3, ACPI: Move MADT GICC
 enabled check into a helper
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, linux-pm@vger.kernel.org,
        loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
References: <20230913163823.7880-1-james.morse@arm.com>
 <20230913163823.7880-29-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-29-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 9/14/23 02:38, James Morse wrote:
> ACPI, irqchip and the architecture code all inspect the MADT
> enabled bit for a GICC entry in the MADT.
> 
> The addition of an 'online capable' bit means all these sites need
> updating.
> 
> Move the current checks behind a helper to make future updates easier.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/arm64/kernel/smp.c       |  2 +-
>   drivers/acpi/processor_core.c |  2 +-
>   drivers/irqchip/irq-gic-v3.c  | 10 ++++------
>   include/linux/acpi.h          |  5 +++++
>   4 files changed, 11 insertions(+), 8 deletions(-)
> 

With Jonathan and Russell's comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 960b98b43506..8c8f55721786 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -520,7 +520,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>   {
>   	u64 hwid = processor->arm_mpidr;
>   
> -	if (!(processor->flags & ACPI_MADT_ENABLED)) {
> +	if (!acpi_gicc_is_usable(processor)) {
>   		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
>   		return;
>   	}
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index 7dd6dbaa98c3..b203cfe28550 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -90,7 +90,7 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
>   	struct acpi_madt_generic_interrupt *gicc =
>   	    container_of(entry, struct acpi_madt_generic_interrupt, header);
>   
> -	if (!(gicc->flags & ACPI_MADT_ENABLED))
> +	if (!acpi_gicc_is_usable(gicc))
>   		return -ENODEV;
>   
>   	/* device_declaration means Device object in DSDT, in the
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index eedfa8e9f077..72d3cdebdad1 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2367,8 +2367,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
>   	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
>   	void __iomem *redist_base;
>   
> -	/* GICC entry which has !ACPI_MADT_ENABLED is not unusable so skip */
> -	if (!(gicc->flags & ACPI_MADT_ENABLED))
> +	if (!acpi_gicc_is_usable(gicc))
>   		return 0;
>   
>   	redist_base = ioremap(gicc->gicr_base_address, size);
> @@ -2418,7 +2417,7 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
>   	 * If GICC is enabled and has valid gicr base address, then it means
>   	 * GICR base is presented via GICC
>   	 */
> -	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address) {
> +	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
>   		acpi_data.enabled_rdists++;
>   		return 0;
>   	}
> @@ -2427,7 +2426,7 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
>   	 * It's perfectly valid firmware can pass disabled GICC entry, driver
>   	 * should not treat as errors, skip the entry instead of probe fail.
>   	 */
> -	if (!(gicc->flags & ACPI_MADT_ENABLED))
> +	if (!acpi_gicc_is_usable(gicc))
>   		return 0;
>   
>   	return -ENODEV;
> @@ -2486,8 +2485,7 @@ static int __init gic_acpi_parse_virt_madt_gicc(union acpi_subtable_headers *hea
>   	int maint_irq_mode;
>   	static int first_madt = true;
>   
> -	/* Skip unusable CPUs */
> -	if (!(gicc->flags & ACPI_MADT_ENABLED))
> +	if (!acpi_gicc_is_usable(gicc))
>   		return 0;
>   
>   	maint_irq_mode = (gicc->flags & ACPI_MADT_VGIC_IRQ_MODE) ?
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b7ab85857bb7..e3265a9eafae 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -256,6 +256,11 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
>   int acpi_parse_mcfg (struct acpi_table_header *header);
>   void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
>   
> +static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
> +{
> +	return (gicc->flags & ACPI_MADT_ENABLED);
> +}
> +
>   /* the following numa functions are architecture-dependent */
>   void acpi_numa_slit_init (struct acpi_table_slit *slit);
>   

Thanks,
Gavin

