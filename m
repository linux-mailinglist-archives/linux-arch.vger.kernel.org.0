Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB147B89A9
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 20:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244244AbjJDS2C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 14:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244235AbjJDS2B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 14:28:01 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0055198;
        Wed,  4 Oct 2023 11:27:57 -0700 (PDT)
Received: from [10.0.0.178] (c-76-135-56-23.hsd1.wa.comcast.net [76.135.56.23])
        by linux.microsoft.com (Postfix) with ESMTPSA id CA79020B74C0;
        Wed,  4 Oct 2023 11:27:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA79020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696444077;
        bh=H3hpMWGvjGtlXIXotdjlxYcAB+MUrjLHbNTb9FjcgmM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E2F9qALpVjKLHPt1qgbv6o+F2urPzDJk9C0SK7tHGJgziy2Xd+HvQ7t2Fz4EUlsOI
         /I01+rs+iUyXP9YNe6t2U0mQTx3zz0+vNEaFzjubblqGCdCOOn3JmzAiqzHzoLEcrX
         Ha+iNvKWADExxT2I7VlTuwbBJkw9wzTIoNOJUw2E=
Message-ID: <c79ee00f-253d-40d5-9ed6-0f156dc4ebb1@linux.microsoft.com>
Date:   Wed, 4 Oct 2023 11:27:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/15] Drivers: hv: Introduce hv_output_arg_exists in
 hv_common.c
Content-Language: en-US
To:     Alex Ionescu <aionescu@gmail.com>,
        Dexuan Cui <decui@microsoft.com>, longli@microsoft.com,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        gregkh@linuxfoundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
        mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
        jinankjain@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
        catalin.marinas@arm.com
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-10-git-send-email-nunodasneves@linux.microsoft.com>
 <CAJ-90N+A-wS-Uwrs_2WVL86Uo3qzQ1czxm-u9vDj3UuOwjhLdQ@mail.gmail.com>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <CAJ-90N+A-wS-Uwrs_2WVL86Uo3qzQ1czxm-u9vDj3UuOwjhLdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/2/2023 12:29 PM, Alex Ionescu wrote:
> Hi Nuno,
> 
> Is it possible to simply change to always allocating the output page?
> For example, the output page could be needed in scenarios where Linux
> is not running as the root partition, since certain hypercalls that a
> guest can make will still require one (I realize that's not the case
> _today_, but I don't believe this optimization buys much).

I agree - it would indeed simplify the code, and guests will probably
make use of it sooner or later.

Happy to make that change if Hyper-V guest maintainers agree.
Long, Dexuan, Michael, what do you think?

Thanks,
Nuno

> Best regards,
> Alex Ionescu
> 
> 
> On Fri, Sep 29, 2023 at 2:02 PM Nuno Das Neves
> <nunodasneves@linux.microsoft.com> wrote:
>>
>> This is a more flexible approach for determining whether to allocate the
>> output page.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Acked-by: Wei Liu <wei.liu@kernel.org>
>> ---
>>   drivers/hv/hv_common.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 39077841d518..3f6f23e4c579 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -58,6 +58,14 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>>   void * __percpu *hyperv_pcpu_output_arg;
>>   EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
>>
>> +/*
>> + * Determine whether output arg is needed
>> + */
>> +static inline bool hv_output_arg_exists(void)
>> +{
>> +       return hv_root_partition ? true : false;
>> +}
>> +
>>   static void hv_kmsg_dump_unregister(void);
>>
>>   static struct ctl_table_header *hv_ctl_table_hdr;
>> @@ -342,10 +350,12 @@ int __init hv_common_init(void)
>>          hyperv_pcpu_input_arg = alloc_percpu(void  *);
>>          BUG_ON(!hyperv_pcpu_input_arg);
>>
>> -       /* Allocate the per-CPU state for output arg for root */
>> -       if (hv_root_partition) {
>> +       if (hv_output_arg_exists()) {
>>                  hyperv_pcpu_output_arg = alloc_percpu(void *);
>>                  BUG_ON(!hyperv_pcpu_output_arg);
>> +       }
>> +
>> +       if (hv_root_partition) {
>>                  hv_synic_eventring_tail = alloc_percpu(u8 *);
>>                  BUG_ON(hv_synic_eventring_tail == NULL);
>>          }
>> @@ -375,7 +385,7 @@ int hv_common_cpu_init(unsigned int cpu)
>>          u8 **synic_eventring_tail;
>>          u64 msr_vp_index;
>>          gfp_t flags;
>> -       int pgcount = hv_root_partition ? 2 : 1;
>> +       int pgcount = hv_output_arg_exists() ? 2 : 1;
>>          void *mem;
>>          int ret;
>>
>> @@ -393,9 +403,12 @@ int hv_common_cpu_init(unsigned int cpu)
>>                  if (!mem)
>>                          return -ENOMEM;
>>
>> -               if (hv_root_partition) {
>> +               if (hv_output_arg_exists()) {
>>                          outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
>>                          *outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>> +               }
>> +
>> +               if (hv_root_partition) {
>>                          synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>>                          *synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
>>                                                          flags);
>> --
>> 2.25.1
>>
>>

