Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A01072267F
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jun 2023 14:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjFEMza (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Jun 2023 08:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjFEMzZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Jun 2023 08:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAADCCD
        for <linux-arch@vger.kernel.org>; Mon,  5 Jun 2023 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685969673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHxUennmoRcWdeQEiDSCkjFBqLhpEtT5XDwGS+LOflw=;
        b=H9hfBxiS08hl8BXWNUFF7kf+kItYzQ4XJpOMMn2pXRToVbz3n+wNdPmV6jtnVu2NWt2g9H
        ymhu+Z+hcgXBInVU/Rdo7VjaSbIw2XJ0Imn9ga8NWHO49PfgGwIJI1KmAztSYBZZcgvP+A
        7y+4PWsNNT1pHKLUXhPnJiTAt1K7Dyc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-7a2xeiGGPPOmZytsLmWBxQ-1; Mon, 05 Jun 2023 08:54:32 -0400
X-MC-Unique: 7a2xeiGGPPOmZytsLmWBxQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75d558057f6so190890485a.3
        for <linux-arch@vger.kernel.org>; Mon, 05 Jun 2023 05:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685969671; x=1688561671;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHxUennmoRcWdeQEiDSCkjFBqLhpEtT5XDwGS+LOflw=;
        b=Z8COCqI57zjXC2RsssIyRqHNRzksXf5i4tA9b1HkCRipZxlN+n0e7iu5uJrq2SRg60
         qyhyot2MlG115Kt58kJEJMi55T3MaKS+jH9yNOohXj9lz5YItQu2t7rtRI7lv6eZ29VT
         XGZ25NseDt8WN9eL33+wPiMNIz3HrsaIvhb4Gf7KaJ47P96k3iuLB+Ig4G40dDvB6sOo
         VXeMv7hs1TXRe6QlHY9ANiMrjH1IigBNRBGjicU9I0fsFyIHAvnqqFnQBpX40QIlbYqg
         mMr2KkhGf5fII6Q7mwc5YQmMyJ1GHGlzMdm6oC0jpY6N2dEsS8un8jyCwtLnAcqGnm4k
         3rnw==
X-Gm-Message-State: AC+VfDx8RTW9C/HWSrmOQPfaFhp+x0Uou3oMj6zFhCpXxLUEhQ2kZIAY
        +iMDg6HtzLJOFIWpmD1xm5uuvL/1VfEcAib0azq4wkAolWvo4w7DON7+em7gtcr+1+M0ZvkZXAl
        zVe1CpYw7aLfKFV3SMo6ayQ==
X-Received: by 2002:a05:620a:4382:b0:75e:ac60:620d with SMTP id a2-20020a05620a438200b0075eac60620dmr2852350qkp.9.1685969671697;
        Mon, 05 Jun 2023 05:54:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RaoDQmdKCPPrluZRGbo5LN4qXWw/NY69RzD/tKyXIn6rr/+pMbUtVBbme2QzahttCsnRfiA==
X-Received: by 2002:a05:620a:4382:b0:75e:ac60:620d with SMTP id a2-20020a05620a438200b0075eac60620dmr2852335qkp.9.1685969671439;
        Mon, 05 Jun 2023 05:54:31 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id h17-20020a05620a10b100b0075cec860842sm4192880qkk.27.2023.06.05.05.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:54:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] drivers: hv: Mark shared pages unencrypted in
 SEV-SNP enlightened guest
In-Reply-To: <20230601151624.1757616-5-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-5-ltykernel@gmail.com>
Date:   Mon, 05 Jun 2023 14:54:26 +0200
Message-ID: <87zg5ejchp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <tiala@microsoft.com>
>
> Hypervisor needs to access iput arg, VMBus synic event and
> message pages. Mask these pages unencrypted in the sev-snp
> guest and free them only if they have been marked encrypted
> successfully.
>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  drivers/hv/hv.c        | 57 +++++++++++++++++++++++++++++++++++++++---
>  drivers/hv/hv_common.c | 24 +++++++++++++++++-
>  2 files changed, 77 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index de6708dbe0df..94406dbe0df0 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -20,6 +20,7 @@
>  #include <linux/interrupt.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
> +#include <linux/set_memory.h>
>  #include "hyperv_vmbus.h"
>  
>  /* The one and only */
> @@ -78,7 +79,7 @@ int hv_post_message(union hv_connection_id connection_id,
>  
>  int hv_synic_alloc(void)
>  {
> -	int cpu;
> +	int cpu, ret = -ENOMEM;
>  	struct hv_per_cpu_context *hv_cpu;
>  
>  	/*
> @@ -123,26 +124,76 @@ int hv_synic_alloc(void)
>  				goto err;
>  			}
>  		}
> +
> +		if (hv_isolation_type_en_snp()) {
> +			ret = set_memory_decrypted((unsigned long)
> +				hv_cpu->synic_message_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
> +				hv_cpu->synic_message_page = NULL;
> +
> +				/*
> +				 * Free the event page here and not encrypt
> +				 * the page in hv_synic_free().
> +				 */
> +				free_page((unsigned long)hv_cpu->synic_event_page);
> +				hv_cpu->synic_event_page = NULL;
> +				goto err;
> +			}
> +
> +			ret = set_memory_decrypted((unsigned long)
> +				hv_cpu->synic_event_page, 1);
> +			if (ret) {
> +				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
> +				hv_cpu->synic_event_page = NULL;
> +				goto err;
> +			}
> +
> +			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
> +			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
> +		}
>  	}
>  
>  	return 0;
> +
>  err:
>  	/*
>  	 * Any memory allocations that succeeded will be freed when
>  	 * the caller cleans up by calling hv_synic_free()
>  	 */
> -	return -ENOMEM;
> +	return ret;
>  }
>  
>  
>  void hv_synic_free(void)
>  {
> -	int cpu;
> +	int cpu, ret;
>  
>  	for_each_present_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			= per_cpu_ptr(hv_context.cpu_context, cpu);
>  
> +		/* It's better to leak the page if the encryption fails. */
> +		if (hv_isolation_type_en_snp()) {
> +			if (hv_cpu->synic_message_page) {
> +				ret = set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_message_page, 1);
> +				if (ret) {
> +					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
> +					hv_cpu->synic_message_page = NULL;
> +				}
> +			}
> +
> +			if (hv_cpu->synic_event_page) {
> +				ret = set_memory_encrypted((unsigned long)
> +					hv_cpu->synic_event_page, 1);
> +				if (ret) {
> +					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
> +					hv_cpu->synic_event_page = NULL;
> +				}
> +			}
> +		}
> +
>  		free_page((unsigned long)hv_cpu->synic_event_page);
>  		free_page((unsigned long)hv_cpu->synic_message_page);
>  	}
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 179bc5f5bf52..bed9aa6ac19a 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -24,6 +24,7 @@
>  #include <linux/kmsg_dump.h>
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
> +#include <linux/set_memory.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  
> @@ -359,6 +360,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	u64 msr_vp_index;
>  	gfp_t flags;
>  	int pgcount = hv_root_partition ? 2 : 1;
> +	int ret;
>  
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
>  	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
> @@ -368,6 +370,17 @@ int hv_common_cpu_init(unsigned int cpu)
>  	if (!(*inputarg))
>  		return -ENOMEM;
>  
> +	if (hv_isolation_type_en_snp()) {
> +		ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
> +		if (ret) {
> +			kfree(*inputarg);
> +			*inputarg = NULL;
> +			return ret;
> +		}
> +
> +		memset(*inputarg, 0x00, pgcount * PAGE_SIZE);
> +	}
> +
>  	if (hv_root_partition) {
>  		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>  		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
> @@ -387,7 +400,9 @@ int hv_common_cpu_die(unsigned int cpu)
>  {
>  	unsigned long flags;
>  	void **inputarg, **outputarg;
> +	int pgcount = hv_root_partition ? 2 : 1;
>  	void *mem;
> +	int ret;
>  
>  	local_irq_save(flags);
>  
> @@ -402,7 +417,14 @@ int hv_common_cpu_die(unsigned int cpu)
>  
>  	local_irq_restore(flags);
>  
> -	kfree(mem);
> +	if (hv_isolation_type_en_snp()) {
> +		ret = set_memory_encrypted((unsigned long)mem, pgcount);
> +		if (ret)
> +			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
> +				cpu, ret);
> +		/* It's unsafe to free 'mem'. */
> +		return 0;

Why is it unsafe to free 'mem' if ret == 0? Also, why don't we want to
proparate non-zero 'ret' from here to fail CPU offlining?


> +	}
>  
>  	return 0;
>  }

-- 
Vitaly

