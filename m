Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040CB2507BD
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHXSeW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 14:34:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHXSeV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Aug 2020 14:34:21 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MFslN-1kPS6w26Tn-00HPRd; Mon, 24 Aug 2020 20:34:17 +0200
Received: by mail-qk1-f173.google.com with SMTP id x69so8403592qkb.1;
        Mon, 24 Aug 2020 11:34:17 -0700 (PDT)
X-Gm-Message-State: AOAM530E6WYzcehL9zfTozaW1qVFhw6ok3OquBkP40sOXC5NtzL047+E
        TKVabzB+p5BoHgT5fEKbUSvHV8BQxQQl+lA0/a8=
X-Google-Smtp-Source: ABdhPJzfY8ROha35/yKA27DcwIBkA7xUAlvphwJ6u+FCwsbDIg44VewzNpSKkyryhY9q3Kn0NN13Nz6DeNytzE5uGRg=
X-Received: by 2002:a37:b942:: with SMTP id j63mr6029416qkf.138.1598294055992;
 Mon, 24 Aug 2020 11:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com> <1598287583-71762-8-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1598287583-71762-8-git-send-email-mikelley@microsoft.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 24 Aug 2020 20:33:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1NXVJON+apBZeVDdx_bqQmenab8srqJDWS_VFVpAncRA@mail.gmail.com>
Message-ID: <CAK8P3a1NXVJON+apBZeVDdx_bqQmenab8srqJDWS_VFVpAncRA@mail.gmail.com>
Subject: Re: [PATCH v7 07/10] arm64: hyperv: Initialize hypervisor on boot
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, wei.liu@kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YpsaARO2nUsiib14Baj/dmeU1yqQL2ByGD3smqxGkzJz34iza8e
 69Vm/x+4IR2vnWunKJghm3H+Dcjz9eJLijn2jFgtA9Rrhy1Kylw27JHN0+IAsnSmqmu0U45
 6t2+RCSL3Y1lCb0i+52oHz3ZV1ZcdWBUj95aNjgR4O4Rr6LFMeN35pwL9mPuOtjQ1jMrCNI
 w4puipAykHO/7G3gsZE5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xfy/PN6TeNY=:oShZ0JCMelB3UawmNtDwBt
 iG0GwxIP1kC1PXldkFjKHBpN1AXdDtgNgCxhXEgSjSzq9uIE0BvzEoE0YEbyLdPZ7rrw0OoOa
 aupaolan9NJ4OT5Dn/23D294cJ1c8APZ3xSnKPSIFzJboCouxARJmYuNYXELMNwsuzp1trmBr
 2bum2sCuqmL0WFkBnMORANCyVwCMjTGcqIVcOdixYI8elV75DK0ZCdeE+MardFqH0Uz2NAAn9
 HyXM7dCeoEMM7I1nmFweVTA1iIE7k2Q6dFlIi/vJXEMG1EAuDRBGR3GJ/i7T1AC8ogj7QAJNs
 atBsFzvli88Xa3Q8hAciHMTFUs9xfvo2lxeaq3UCaxSdNin+kCiQWgNZ4Ap48IvsQnpTojdoG
 wUUJpVP5GBuQSXzJbQH62Ogg0eGkGxiWmTTfAhPUt1ACoGP0I6eOtZ5j+2YdAjrqgcp9wAUts
 Ba6HLJBUMvdG57sFEaYjpk3AY7soD6cBGojaAmkPb7CnpdoxAR5d/1vqGBd7KjmBofgL7UHP2
 /67A9wABmls0ul+TF1x/fIxIvVEM53hejocU0fNTiUB0dB0olFJgoRP/H5vZZRa07TSUkyHEv
 teuWw8QmzA1MpnVDPijnyLgQpAPhX+IrYnlQUu5K0D+i/2JsSpdodv9I/ehTtGJ7nb3h79P6o
 moG16C8+dOTo0MijGI+OJnS2WejoqS+0QzcWIVZwHj9VGgxvjm5o3wSwxbAymZjd9/1OyK8Bh
 Uz3J02XbGt2L2q7R7PlghB0QhoUaOYpyU9rMenuVPFhnHcLmg2K3Hft15b9HKOJfl5dkipR9N
 00j+KS221uaDu4xHH5+WNLy9hMJnQdwdg3GVN/zi0RxSjP21V8qeKWjMLKEOF7TU5bDekog
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 24, 2020 at 6:48 PM Michael Kelley <mikelley@microsoft.com> wrote:
>
>  /*
> + * This function is invoked via the ACPI clocksource probe mechanism. We
> + * don't actually use any values from the ACPI GTDT table, but we set up
> + * the Hyper-V synthetic clocksource and do other initialization for
> + * interacting with Hyper-V the first time.  Using early_initcall to invoke
> + * this function is too late because interrupts are already enabled at that
> + * point, and hv_init_clocksource() must run before interrupts are enabled.
> + *
> + * 1. Setup the guest ID.
> + * 2. Get features and hints info from Hyper-V
> + * 3. Setup per-cpu VP indices.
> + * 4. Initialize the Hyper-V clocksource.
> + */
> +
> +static int __init hyperv_init(struct acpi_table_header *table)
> +{
> +       struct hv_get_vp_registers_output result;
> +       u32     a, b, c, d;
> +       u64     guest_id;
> +       int     i, cpuhp;
> +
> +       /*
> +        * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
> +        * have the string "MsHyperV".
> +        */
> +       if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +               return -EINVAL;
> +
> +       /* Setup the guest ID */
> +       guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +       hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
> +
> +       /* Get the features and hints from Hyper-V */
> +       hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
> +       ms_hyperv.features = result.as32.a;
> +       ms_hyperv.misc_features = result.as32.c;
> +
> +       hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
> +       ms_hyperv.hints = result.as32.a;
> +
> +       pr_info("Hyper-V: Features 0x%x, hints 0x%x, misc 0x%x\n",
> +               ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
> +
> +       /*
> +        * If Hyper-V has crash notifications, set crash_kexec_post_notifiers
> +        * so that we will report the panic to Hyper-V before running kdump.
> +        */
> +       if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
> +               crash_kexec_post_notifiers = true;
> +
> +       /* Get information about the Hyper-V host version */
> +       hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
> +       a = result.as32.a;
> +       b = result.as32.b;
> +       c = result.as32.c;
> +       d = result.as32.d;
> +       pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
> +               b >> 16, b & 0xFFFF, a, d & 0xFFFFFF, c, d >> 24);
> +
> +       /* Allocate and initialize percpu VP index array */
> +       hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
> +                                   GFP_KERNEL);
> +       if (!hv_vp_index)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < num_possible_cpus(); i++)
> +               hv_vp_index[i] = VP_INVAL;
> +
> +       cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +                       "arm64/hyperv_init:online", hv_cpu_init, NULL);
> +       if (cpuhp < 0)
> +               goto free_vp_index;
> +
> +       hv_init_clocksource();
> +       if (hv_stimer_alloc())
> +               goto remove_cpuhp_state;
> +
> +       hyperv_initialized = true;
> +       return 0;
> +
> +remove_cpuhp_state:
> +       cpuhp_remove_state(cpuhp);
> +free_vp_index:
> +       kfree(hv_vp_index);
> +       hv_vp_index = NULL;
> +       return -EINVAL;
> +}
> +TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);

I think this has come up before, and I still don't consider it an acceptable
hack to hook platform initialization code into the timer code.

Please split out the timer into a standalone driver in drivers/clocksource
that can get reviewed by the clocksource maintainers.

      Arnd
