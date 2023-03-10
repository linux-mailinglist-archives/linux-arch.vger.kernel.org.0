Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155A26B4CC2
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 17:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjCJQYM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 11:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCJQXz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 11:23:55 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9A91B2D8;
        Fri, 10 Mar 2023 08:20:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bo22so5804074pjb.4;
        Fri, 10 Mar 2023 08:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwF30lUOLowNwfzex7WqtpSeK7NekjZtbTSNqNiswrU=;
        b=jYedqlpqkMc5S4p/DnPvNjwPKClncXF+ZVqop2cYMZCl5k3thzAQRGM/xXRVmu7da9
         jM+q/MHQgB73JXBcGoMyufoWv3BuTF5LVZwrJ0yL3X3zA991OHcA3Y0agZN+ZbWL3dD5
         z8WTw+jzaI/+WJyjr/oD7odzTFiqb7FAbBxB/bbvRsWG2j3yO2G0ymLjBCDRyKCEsCuW
         mu0ZFmS2rRwnn3IwiP2vX4LU1pohzi4aIZ2xm35usqsYSj6KMLu3GDKkt2EO9pD2aTWH
         C5RyIp3XcellWk7rCKNw7y33pJfWTBvfNvJlYd9wPR0EnxV9CJR6ev0RcprxHI9Kh9HJ
         LlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cwF30lUOLowNwfzex7WqtpSeK7NekjZtbTSNqNiswrU=;
        b=HGQcSHL1d1rvpNLmrfmhXoy7mIzdIqdQ7m8fNTXltexdOYlA0lVdIe9Bdmxe5+HV16
         xaUhe++VpYBrOY72NSNb1K30HL19lWB1+GsH5xXsRc6WzUUNJCFYQI3+ZzSI1s7fVAni
         PwxGueBNwDWdxXbB05i4Bx0KNxe4Iv1tDUovd9Haf88qN7QzcnKz+3CvOAuoAcsOC+EL
         GCCVv1PVRl+d2Vu4qCovu3qCsQyV/mozn8lCanaHVVOcJNCzd/yA9xENQmEm6BictIZM
         2Dle/kinFwFuTPdIZN142oOE1dwMuT4oUu1lmFlvY6PSkH9GJ2Qiz37muHm5wyfHLYec
         0GDA==
X-Gm-Message-State: AO0yUKWejoCQltpX1sIgKY1hqglsv4BMQl7JrgA/7cqgUF7mZNsA5uJ0
        Ak6zV5AQsMOhbTqgziElRdU=
X-Google-Smtp-Source: AK7set9yF3jRL5G+hjchJGrZNThUMlhzCB1OXtvn1hCPesSwusBxH4szl/QI0tSB9XW405M9ba8GyQ==
X-Received: by 2002:a05:6a20:5483:b0:cd:47dc:82b5 with SMTP id i3-20020a056a20548300b000cd47dc82b5mr34507831pzk.21.1678465202159;
        Fri, 10 Mar 2023 08:20:02 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id u33-20020a631421000000b004e28be19d1csm113467pgl.32.2023.03.10.08.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:20:01 -0800 (PST)
Message-ID: <8d385bb6-fc30-a44d-a057-f23d89a0152e@gmail.com>
Date:   Sat, 11 Mar 2023 00:19:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
To:     "Gupta, Pankaj" <pankaj.gupta@amd.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <fac62414-06f9-0454-8393-f039aa30571a@amd.com>
 <fe100597-26be-23e4-bfa9-f45aa27b7966@amd.com>
 <0a968926-670a-c383-492d-52c45b09bb18@amd.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <0a968926-670a-c383-492d-52c45b09bb18@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 3/10/2023 11:35 PM, Gupta, Pankaj wrote:
> 
> 
> Hi Tianyu,
> 
> While testing the guest patches on KVM host, My guest kernel is stuck
> at early bootup. As it did not seem a hang but sort of loop where 
> interrupts are getting processed from "pv_native_irq_enable" path 
> repeatedly and prevent boot process to make progress IIUC. Did you face 
> any such scenario in your testing?
> 
> It seems to me "native_irq_enable" enable interrupts and 
> "check_hv_pending_irq_enable" starts handling the interrupts (after 
> disabling irqs). But "check_hv_pending_irq_enable=>do_exc_hv" can again 
> call "pv_native_irq_enable" in interrupt handling path and execute the 
> same loop?


I don't meet the issue. Thanks for report. I will double check and 
report back.

> Also pasting below the stack dump [1].
> 
> Thanks,
> Pankaj
> 
> [1]
> [   20.530786] Call Trace:^M
> [   20.531099]  <IRQ>^M
> [   20.531360]  dump_stack_lvl+0x4d/0x67^M
> [   20.531820]  dump_stack+0x14/0x1a^M
> [   20.532235]  do_exc_hv.cold+0x11/0xec^M
> [   20.532792]  check_hv_pending_irq_enable+0x64/0x80^M
> [   20.533390]  pv_native_irq_enable+0xe/0x20^M   ====> here
> [   20.533902]  __do_softirq+0x89/0x2f3^M
> [   20.534352]  __irq_exit_rcu+0x9f/0x110^M
> [   20.534825]  irq_exit_rcu+0x12/0x20^M
> [   20.535267]  common_interrupt+0xca/0xf0^M
> [   20.535745]  </IRQ>^M
> [   20.536014]  <TASK>^M
> [   20.536286]  do_exc_hv.cold+0xda/0xec^M
> [   20.536826]  check_hv_pending_irq_enable+0x64/0x80^M
> [   20.537429]  pv_native_irq_enable+0xe/0x20^M    ====> here
> [   20.537942]  _raw_spin_unlock_irqrestore+0x21/0x50^M
> [   20.538539]  __setup_irq+0x3be/0x740^M
> [   20.538990]  request_threaded_irq+0x116/0x180^M
> [   20.539533]  hpet_time_init+0x35/0x56^M
> [   20.539994]  x86_late_time_init+0x1f/0x3d^M
> [   20.540556]  start_kernel+0x8af/0x970^M
> [   20.541033]  x86_64_start_reservations+0x28/0x2e^M
> [   20.541607]  x86_64_start_kernel+0x96/0xa0^M
> [   20.542126]  secondary_startup_64_no_verify+0xe5/0xeb^M
> [   20.542757]  </TASK>^M
