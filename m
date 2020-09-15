Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0426A319
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 12:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIOK10 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 06:27:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52594 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbgIOK1Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 06:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600165641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fkoLRj4CpMUCFaAU/c0cpXEpa6XQZl3hQi3pkjeuyww=;
        b=N4ta0p4905FLUxM52TPf34cmfw5NFMR/Kgyk6rLeTVuM3cgkYkOlIHppH4FfugeV4fNITP
        y+g6x/f1JTBC53Nq82+4lwW7Cs2fkhVIGkdATbud7JgKSJRlGOKap5HEDTNTH/qh5JupVP
        gP8frDOvAP4uKPjgH8FNqwR72Cgo1TI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-icqSAzx2Nt2PvoDF-ZqgOg-1; Tue, 15 Sep 2020 06:27:19 -0400
X-MC-Unique: icqSAzx2Nt2PvoDF-ZqgOg-1
Received: by mail-wr1-f71.google.com with SMTP id r15so1051022wrt.8
        for <linux-arch@vger.kernel.org>; Tue, 15 Sep 2020 03:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fkoLRj4CpMUCFaAU/c0cpXEpa6XQZl3hQi3pkjeuyww=;
        b=CwtdPvh9iw/dk0srL/0/PDs1AivElr+ySZCYvOvt80FP8SNzx7ZTF9I29qraQ+QCMr
         njmRtoycHZ3xgntkSSWRXseziGAGMhQsvaZoa2EjVIoedEM+OqY0x8QyWdXo98I7nWLK
         EPAO4pVHgbmG7ZSz6kbmt7Kgr0zuVfJ48xm5EItKmjzvG5SFJ7X950mrJ07iRlKXMXJk
         UxQqGJH3zsnN5NTMsyIFVKEQmzb+NR1TszBtnLc1O7znQ4BbKpP9aU7yYA+nx+f9pz/m
         ncHBT4z4xDQorcVZLQz7czEWjugsB+kVzIVhMRofABxa5HYwVm8bkCXvr8+6CddNX2Rz
         NoVQ==
X-Gm-Message-State: AOAM533/sPZ6CvvU0lvUCNnbBKv04vOgf3xbgSwEi/t/w0R6GQRLI1nN
        47aAnP9hvGG12aQJK0D7LsfshJmHC+KbJsxy7tYwuvpcgUqSOEtJTdgdppUvyLTEk1I0zdqJJk9
        ptAld6TFuuEaWbVrrg+9PRQ==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr4181809wmc.112.1600165638453;
        Tue, 15 Sep 2020 03:27:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV7+MNnmdJ7LoABeyhT5kZ24BSMQZtr2CvPEQVPzv2SqkmoR19M8GCrVTONoAPOxgeK7xVNw==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr4181777wmc.112.1600165638158;
        Tue, 15 Sep 2020 03:27:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z15sm25217526wrv.94.2020.09.15.03.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:27:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list\:GENERIC INCLUDE\/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC v1 07/18] x86/hyperv: extract partition ID from Microsoft Hypervisor if necessary
In-Reply-To: <20200914112802.80611-8-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-8-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 12:27:16 +0200
Message-ID: <87y2lbjpx7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> We will need the partition ID for executing some hypercalls later.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c         | 26 ++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  2 ++
>  include/asm-generic/hyperv-tlfs.h |  6 ++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index ebba4be4185d..0eec1ed32023 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -30,6 +30,9 @@
>  bool hv_root_partition;
>  EXPORT_SYMBOL_GPL(hv_root_partition);
>  
> +u64 hv_current_partition_id;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>  
> @@ -345,6 +348,26 @@ static struct syscore_ops hv_syscore_ops = {
>  	.resume		= hv_resume,
>  };
>  
> +void __init hv_get_partition_id(void)
> +{
> +	struct hv_get_partition_id *output_page;
> +	int status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
> +		HV_HYPERCALL_RESULT_MASK;

Nit: in this case status is 'u16', we can define it as such (instead of
signed int).

> +	if (status != HV_STATUS_SUCCESS)
> +		pr_err("Failed to get partition ID: %d\n", status);
> +	else
> +		hv_current_partition_id = output_page->partition_id;
> +	local_irq_restore(flags);
> +
> +	/* No point in proceeding if this failed */
> +	BUG_ON(status != HV_STATUS_SUCCESS);
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -440,6 +463,9 @@ void __init hyperv_init(void)
>  
>  	register_syscore_ops(&hv_syscore_ops);
>  
> +	if (hv_root_partition)
> +		hv_get_partition_id();

According to TLFS, partition ID is available when AccessPartitionId
privilege is granted. I'd suggest we check that instead of
hv_root_partition (and we can set hv_current_partition_id to something
like U64_MAX so we know it wasn't acuired). So the BUG_ON condition will
move here:

        hv_get_partition_id();
        BUG_ON(hv_root_partition && hv_current_partition_id == U64_MAX);

> +
>  	return;
>  
>  remove_cpuhp_state:
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index f5c62140f28d..4039302e0ae9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -65,6 +65,8 @@ extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
>  extern void  __percpu  **hyperv_pcpu_output_arg;
>  
> +extern u64 hv_current_partition_id;
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e6903589a82a..87b1a79b19eb 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -141,6 +141,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_GET_PARTITION_ID			0x0046
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
> @@ -407,6 +408,11 @@ struct hv_tlb_flush_ex {
>  	u64 gva_list[];
>  } __packed;
>  
> +/* HvGetPartitionId hypercall (output only) */
> +struct hv_get_partition_id {
> +	u64 partition_id;
> +} __packed;
> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;

-- 
Vitaly

