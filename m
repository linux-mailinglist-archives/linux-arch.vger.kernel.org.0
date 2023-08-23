Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166E77852AE
	for <lists+linux-arch@lfdr.de>; Wed, 23 Aug 2023 10:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjHWIbO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Aug 2023 04:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjHWI32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Aug 2023 04:29:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD922701;
        Wed, 23 Aug 2023 01:18:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f9521de4cso942865a91.0;
        Wed, 23 Aug 2023 01:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692778686; x=1693383486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8aHxB2kz2NVsCyn+YWPwHA5DwGbi4gw2OrktjdJz4Q=;
        b=r7987ylOfBbjvEL6e+i2Ye+X8gZhHAYwxYncNKkTivMsQ1I0G/x3tRa20Q6IkCor24
         DhhxxEaLbAi4bZwv433Wh/SfmkJ238T/ua9Oi3rlqolPTqLGHHl8CtpLEJM+IhD3KWXa
         x0YJOB28U+yvFROZhAM0djqw3p5aQwfcjOvHpEyy+vYwcvLuOOdXyWoBLPZ5O4DUUIvY
         RqcmetNnYJoUcC+ameTZ5vbhBz4D53KBTI1w6OYcC80tVvG0kb70hdVZWvXDUAVEtFye
         lUP1ZoXO8fJ3kPKWiuuhI4qrEhjhNft0P0vKC+0lXHsmDwvJpiN05Nlv/Cl5UFryU2F2
         TJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778686; x=1693383486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J8aHxB2kz2NVsCyn+YWPwHA5DwGbi4gw2OrktjdJz4Q=;
        b=KAGsJsdfnnElq8hclTiZxi91pbfTWhCsYQf6LbrhFpAQCH10n5N4nnTi15UgzK97AW
         qh5CJZZdnVwXf22rE0BYM/4aaQp8+eQvT30ZgHHCERaxd7UKeUmMZQ4ABt5QPbmxLAqn
         qLRa2Zk7exLFSHbNFPM2pkAJEkM7g//yvdZ2G1gJ/NKDjmqU+EpnZXgA6s3qupu7Q4z3
         VKkcLbphelagTqv7Xs4qBTkLDnlguInIbVdGp3f+Jp5/zDui5wWVUTu8W+ax2gqze9oT
         nHN44ffcU9izajJhsSP/CI/9Mvz/oagdR4Aq7XxlMTWENwRJqVXJn+OBOhOLceQwqA1O
         7k8A==
X-Gm-Message-State: AOJu0YwePK9LecaV4oRHbe77PmwQ2htxg7tZCr5HxQAErJn4150edIgi
        vwnT4h2y8cX+pbgqInLQB0s=
X-Google-Smtp-Source: AGHT+IHAaGAmIl6NEEBmFcn3UDDJwD0Ictdip7Zj+i5dYacoeYXGOZ3fshWe4waklTy8ZhsKdv81NA==
X-Received: by 2002:a17:90a:558f:b0:26b:4e40:7be8 with SMTP id c15-20020a17090a558f00b0026b4e407be8mr8533815pji.12.1692778686048;
        Wed, 23 Aug 2023 01:18:06 -0700 (PDT)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a804700b0026b4d215627sm9100385pjw.21.2023.08.23.01.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 01:18:05 -0700 (PDT)
Message-ID: <13e03561-eff6-a90f-902f-05252e1b8949@gmail.com>
Date:   Wed, 23 Aug 2023 16:17:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/9] x86/hyperv: Fix serial console interrupts for fully
 enlightened TDX guests
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com
References: <20230811221851.10244-1-decui@microsoft.com>
 <20230811221851.10244-5-decui@microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20230811221851.10244-5-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/12/2023 6:18 AM, Dexuan Cui wrote:
> When a fully enlightened TDX guest runs on Hyper-V, the UEFI firmware sets
> the HW_REDUCED flag and consequently ttyS0 interrupts can't work. Fix the
> issue by overriding x86_init.acpi.reduced_hw_early_init().
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 507df0f64ae18..b4214e37e9124 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -324,6 +324,26 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>   }
>   #endif
>   
> +/*
> + * When a fully enlightened TDX VM runs on Hyper-V, the firmware sets the
> + * HW_REDUCED flag: refer to acpi_tb_create_local_fadt(). Consequently ttyS0
> + * interrupts can't work because request_irq() -> ... -> irq_to_desc() returns
> + * NULL for ttyS0. This happens because mp_config_acpi_legacy_irqs() sees a
> + * nr_legacy_irqs() of 0, so it doesn't initialize the array 'mp_irqs[]', and
> + * later setup_IO_APIC_irqs() -> find_irq_entry() fails to find the legacy irqs
> + * from the array and hence doesn't create the necessary irq description info.
> + *
> + * Clone arch/x86/kernel/acpi/boot.c: acpi_generic_reduced_hw_init() here,
> + * except don't change 'legacy_pic', which keeps its default value
> + * 'default_legacy_pic'. This way, mp_config_acpi_legacy_irqs() sees a non-zero
> + * nr_legacy_irqs() and eventually serial console interrupts works properly.
> + */
> +static void __init reduced_hw_init(void)
> +{
> +	x86_init.timers.timer_init	= x86_init_noop;
> +	x86_init.irqs.pre_vector_init	= x86_init_noop;
> +}
> +
>   static void __init ms_hyperv_init_platform(void)
>   {
>   	int hv_max_functions_eax;
> @@ -442,6 +462,8 @@ static void __init ms_hyperv_init_platform(void)
>   
>   				/* Don't trust Hyper-V's TLB-flushing hypercalls. */
>   				ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
> +
> +				x86_init.acpi.reduced_hw_early_init = reduced_hw_init;
>   			}
>   		}
>   	}
