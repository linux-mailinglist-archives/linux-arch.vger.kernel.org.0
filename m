Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032B7AE20F
	for <lists+linux-arch@lfdr.de>; Tue, 26 Sep 2023 01:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIYXF6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Sep 2023 19:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjIYXFy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Sep 2023 19:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B7126
        for <linux-arch@vger.kernel.org>; Mon, 25 Sep 2023 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695683102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swf/1TRyjsvwDIsd/YLqft6nJR4VSEYvlPbm2UeV+EA=;
        b=SplRSOyDXFJuoqnNwrWBQcQ1GJJ31+zYDN+gFstFModJmRi9FOL5Kaeh98hzptBYQXItny
        HScY3DaNiUD8tQVd3qzGHvQJGIFkmLFH+TQvFaBgB03zQ6fap25eMtdhDX3F5ui9GOK/RG
        7CtCZ3El8AaNS4JeeilmpQAEY7zhmh8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-_Md8gds9Oni2eM3JclGZGQ-1; Mon, 25 Sep 2023 19:04:57 -0400
X-MC-Unique: _Md8gds9Oni2eM3JclGZGQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-57b6321d600so12591419eaf.0
        for <linux-arch@vger.kernel.org>; Mon, 25 Sep 2023 16:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695683097; x=1696287897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swf/1TRyjsvwDIsd/YLqft6nJR4VSEYvlPbm2UeV+EA=;
        b=sORlSCza9XjFK3eYdAkR/+yfRxgcuoYCql3JZhS4zIL6hkBi2MfTHGQC7JjiKqx978
         QuUjzRI2jIyx7ALwF9kTUOKbcVhFxJo9UjAFDyJtdOsfpVy5+DbaPvBrmDuUboZH7wh9
         cXNnengjQmGaUXe21NEFN9/uQRSJYMWoTyGI5dmFpCEkbM33MQUV+E3/hhqOUVV1vCpc
         xUq/zaq/G35KHH2kIltqfjlDljr9WMhN9rqFKY+7l0Uyzl1nUeMQsMv/7RmWXTxgB6sj
         8iI0BecGHFhPVsoWpCJT+tyEd5v2eecR4ypxhVJhj+D0wHG/tmjcH69pmWXgRQJ7kw5s
         wXFA==
X-Gm-Message-State: AOJu0YxTAmEzIRNrzRZy2zZxKIdy7mBUCYnCMCn3tylQc+Wuwr8bra94
        x+Estay/0YpU8MT+aDHFSiHhQedZT6cro1qspC0AX7GuLZ+AcHsh9e0O2AnVcud5hBfZeJHScJb
        w+eOUd50Fly/Lnz2SCTPtsA==
X-Received: by 2002:a05:6358:2823:b0:135:47e8:76e2 with SMTP id k35-20020a056358282300b0013547e876e2mr11329977rwb.4.1695683096746;
        Mon, 25 Sep 2023 16:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX7uksuEOetyapsty6ZE6ocFLTtk0JAOhDOymew1I5gw+0mo4tG1qOgOieTX36CWp+dKzNwQ==
X-Received: by 2002:a05:6358:2823:b0:135:47e8:76e2 with SMTP id k35-20020a056358282300b0013547e876e2mr11329948rwb.4.1695683096324;
        Mon, 25 Sep 2023 16:04:56 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id z27-20020a637e1b000000b00563e1ef0491sm8538475pgc.8.2023.09.25.16.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 16:04:55 -0700 (PDT)
Message-ID: <dd4dee9e-4d75-e1e6-04c8-82d84b28fd35@redhat.com>
Date:   Tue, 26 Sep 2023 09:04:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
Content-Language: en-US
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Salil Mehta <salil.mehta@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org
References: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Russell,

On 9/26/23 02:28, Russell King (Oracle) wrote:
> Provide common prototypes for arch_register_cpu() and
> arch_unregister_cpu(). These are called by acpi_processor.c, with
> weak versions, so the prototype for this is already set. It is
> generally not necessary for function prototypes to be conditional
> on preprocessor macros.
> 
> Some architectures (e.g. Loongarch) are missing the prototype for this,
> and rather than add it to Loongarch's asm/cpu.h, lets do the job once
> for everyone.
> 
> Since this covers everyone, remove the now unnecessary prototypes in
> asm/cpu.h, and we also need to remove the 'static' from one of ia64's
> arch_register_cpu() definitions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>   - drop ia64 changes, as ia64 has already been removed.
> 
>   arch/x86/include/asm/cpu.h  | 2 --
>   arch/x86/kernel/topology.c  | 2 +-
>   include/linux/cpu.h         | 2 ++
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

In Linux 6.6.rc3, the prototypes are still existing in arch/ia64/include/asm/cpu.h.
They may have been dropped in other ia64 or x86 git repository, which this patch
bases on.

In the commit message, 'static' from one of ia64's arch_register_cpu() definitions
is removed, but there is no changes related to ia64 in this patch. I guess that's
probably x86?

> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index 3a233ebff712..25050d953eee 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -28,8 +28,6 @@ struct x86_cpu {
>   };
>   
>   #ifdef CONFIG_HOTPLUG_CPU
> -extern int arch_register_cpu(int num);
> -extern void arch_unregister_cpu(int);
>   extern void soft_restart_cpu(void);
>   #endif
>   
> diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
> index ca004e2e4469..0bab03130033 100644
> --- a/arch/x86/kernel/topology.c
> +++ b/arch/x86/kernel/topology.c
> @@ -54,7 +54,7 @@ void arch_unregister_cpu(int num)
>   EXPORT_SYMBOL(arch_unregister_cpu);
>   #else /* CONFIG_HOTPLUG_CPU */
>   
> -static int __init arch_register_cpu(int num)
> +int __init arch_register_cpu(int num)
>   {
>   	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
>   }

I think arch/ia64/kernel/topology.c may need same change, as stated in the commit log.
In linux 6.6.rc3, 'static' exists in arch/ia64/kernel/topology.c::arch_register_cpu().
Again, your patch may have been based on other git repository.

> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 0abd60a7987b..eb768a866fe3 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -80,6 +80,8 @@ extern __printf(4, 5)
>   struct device *cpu_device_create(struct device *parent, void *drvdata,
>   				 const struct attribute_group **groups,
>   				 const char *fmt, ...);
> +extern int arch_register_cpu(int cpu);
> +extern void arch_unregister_cpu(int cpu);
>   #ifdef CONFIG_HOTPLUG_CPU
>   extern void unregister_cpu(struct cpu *cpu);
>   extern ssize_t arch_cpu_probe(const char *, size_t);

Thanks,
Gavin

