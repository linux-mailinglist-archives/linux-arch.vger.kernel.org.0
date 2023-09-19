Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9327A587D
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 06:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjISEr0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 00:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISErY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 00:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94B010E
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 21:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695098794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0md79eddiFVt37093ccE7iiQ7K8nZkLOgQESfCPy8Vw=;
        b=ABBcJbCglt1qxSif2IH5J3qgXYyXsxJaWfF3gBRp1dPh6ss73WMMOWAbl+ey1zKq2ZQVUs
        uLFgztIA8qetI/t/H6tYs1zxuUXVPiCDw6S12ftz0f8EI3VpWgl1tYFVayboLVpoORjp2E
        I3Ro9znR8eHFbfC3m2M6w7pXHJHP1EY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-ZZeQVwgvOgavIJp5KSwzcQ-1; Tue, 19 Sep 2023 00:46:32 -0400
X-MC-Unique: ZZeQVwgvOgavIJp5KSwzcQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6c0d4cb748bso7349208a34.3
        for <linux-arch@vger.kernel.org>; Mon, 18 Sep 2023 21:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695098791; x=1695703591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0md79eddiFVt37093ccE7iiQ7K8nZkLOgQESfCPy8Vw=;
        b=s+PvRjs9AxUgjiBuGktzsI7fqN5dOPD/MYXh7XVdT4nl1qxjBCWdEpu+L+AkZRlMDC
         1Z7oSTv+KsQWpQ9fc4lTaED7vpEGA8ZuM/WO/P9ZNwwV5zuOghgxTgl0gNa5nXLVTesn
         IyZiJ3r+6H+tZ+C2hdhsOJlRUv6BHFNYOOewYNV+fS//+9rMiIRU7YTOeEjuDbKrimET
         QD+CHcfrYZ5BNpa3TZIq9BkwJ25EKDDr+9BPuycokgC8NPUr3LPPkT7F9CVidZRfHHG+
         jhTIMVDbQtDI+bAfkJTHYmRLwohgnSXAOFL6JUxjWmt+6K8QCpCYrxFBd3Qdcd4rkEAG
         79Gg==
X-Gm-Message-State: AOJu0Ywik63+/+7H2DiBKYwXjwdqdTcGyjt7qiGXC1AiepF6uyqIUcJG
        8/cg29LCd+RBiA9htexrO6GptjNZlCmcY/V+/tdGeVA/IiNknJ/zm0XB3qWbK1w4dEaWzoH2ZvU
        tanSBhToQ44Gqlx/Q2vENIA==
X-Received: by 2002:a05:6358:249d:b0:134:e603:116e with SMTP id m29-20020a056358249d00b00134e603116emr9678035rwc.6.1695098791616;
        Mon, 18 Sep 2023 21:46:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKkoLP87+mw9T8TQ8bjb6RIWKH/vCCTjI0tHPFOvwV8K6Ynikd7+Ff2EaTqVQJl8SE4ves7A==
X-Received: by 2002:a05:6358:249d:b0:134:e603:116e with SMTP id m29-20020a056358249d00b00134e603116emr9678018rwc.6.1695098791296;
        Mon, 18 Sep 2023 21:46:31 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id d3-20020a633603000000b0057749dc8d3asm196597pga.47.2023.09.18.21.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 21:46:30 -0700 (PDT)
Message-ID: <ad068df5-d5b1-030a-af25-723cd5c3b854@redhat.com>
Date:   Tue, 19 Sep 2023 14:46:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 32/35] ACPI: add support to register CPUs based on
 the _STA enabled bit
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
 <20230913163823.7880-33-james.morse@arm.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230913163823.7880-33-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 9/14/23 02:38, James Morse wrote:
> acpi_processor_get_info() registers all present CPUs. Registering a
> CPU is what creates the sysfs entries and triggers the udev
> notifications.
> 
> arm64 virtual machines that support 'virtual cpu hotplug' use the
> enabled bit to indicate whether the CPU can be brought online, as
> the existing ACPI tables require all hardware to be described and
> present.
> 
> If firmware describes a CPU as present, but disabled, skip the
> registration. Such CPUs are present, but can't be brought online for
> whatever reason. (e.g. firmware/hypervisor policy).
> 
> Once firmware sets the enabled bit, the CPU can be registered and
> brought online by user-space. Online CPUs, or CPUs that are missing
> an _STA method must always be registered.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/acpi/acpi_processor.c | 31 ++++++++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 

With below nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index b67616079751..b49859eab01a 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -227,6 +227,32 @@ static int acpi_processor_make_present(struct acpi_processor *pr)
>   	return ret;
>   }
>   
> +static int acpi_processor_make_enabled(struct acpi_processor *pr)
> +{
> +	unsigned long long sta;
> +	acpi_status status;
> +	bool present, enabled;
> +
> +	if (!acpi_has_method(pr->handle, "_STA"))
> +		return arch_register_cpu(pr->id);
> +
> +	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	present = sta & ACPI_STA_DEVICE_PRESENT;
> +	enabled = sta & ACPI_STA_DEVICE_ENABLED;
> +
> +	if (cpu_online(pr->id) && (!present || !enabled)) {
> +		pr_err_once(FW_BUG "CPU %u is online, but described as not present or disabled!\n", pr->id);
> +		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +	} else if (!present || !enabled) {
> +		return -ENODEV;
> +	}
> +
> +	return arch_register_cpu(pr->id);
> +}
> +

The message needs to be split up into multiple lines to make ./scripts/checkpatch.pl
happy:

	pr_err_once(FW_BUG "CPU %u is online, but described "
			   "as not present or disabled!\n", pr->id);

>   static int acpi_processor_get_info(struct acpi_device *device)
>   {
>   	union acpi_object object = { 0 };
> @@ -318,7 +344,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>   	 */
>   	if (!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
>   	    !get_cpu_device(pr->id)) {
> -		int ret = arch_register_cpu(pr->id);
> +		int ret = acpi_processor_make_enabled(pr);
>   
>   		if (ret)
>   			return ret;
> @@ -526,6 +552,9 @@ static void acpi_processor_post_eject(struct acpi_device *device)
>   		acpi_processor_make_not_present(device);
>   		return;
>   	}
> +
> +	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_ENABLED))
> +		arch_unregister_cpu(pr->id);
>   }
>   
>   #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC

Thanks,
Gavin

