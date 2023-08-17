Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A8277FC46
	for <lists+linux-arch@lfdr.de>; Thu, 17 Aug 2023 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243390AbjHQQlu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 12:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353712AbjHQQlp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 12:41:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E3DDF7;
        Thu, 17 Aug 2023 09:41:44 -0700 (PDT)
Received: from [192.168.0.5] (71-212-112-68.tukw.qwest.net [71.212.112.68])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4ED97211F7B4;
        Thu, 17 Aug 2023 09:41:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4ED97211F7B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692290503;
        bh=PhqN4PucaHQXTvLiBBBtzGfGBYANCAr3QrybNH//oIs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=itdHj1aiMIT16YHCnTWRgVpKNpWOzSgQMMO/YS/CzaOZIknaPbjPJIvJ6K8CKFTjV
         T1y32/y0aflFFuWFcdmQtlC/2SXjWszW7sGIUVVyRHnAv+SXZgawUnFXQt59Ek81Nt
         J56jglGEbkyrhV34NmE029C/7rfxwNSreERr/zBg=
Message-ID: <075cff41-fe21-48a8-bdc4-03b13a4ee973@linux.microsoft.com>
Date:   Thu, 17 Aug 2023 09:41:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] asm-generic: hyperv: Use mshv headers
 conditionally. Add asm-generic/hyperv-defs.h
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1690487690-2428-15-git-send-email-nunodasneves@linux.microsoft.com>
 <ZMr5ebxAqfjHPkVb@liuwe-devbox-debian-v2>
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <ZMr5ebxAqfjHPkVb@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/2/2023 5:48 PM, Wei Liu wrote:
> On Thu, Jul 27, 2023 at 12:54:49PM -0700, Nuno Das Neves wrote:
>> In order to keep unstable hyper-v interfaces independent of
>> hyperv-tlfs.h, hvhdk.h must replace hyperv-tlfs.h eveywhere it will be
>> used in the mshv driver.
> 
> Please properly capitalize "Hyper-V" when it is used as a term.
> 
Will fix, thanks.

>> Add hyperv-defs.h to replace some inclusions of hyperv-tlfs.h.
>> It includes hyperv-tlfs.h or hvhdk.h depending on a compile-time constant
>> HV_HYPERV_DEFS which will be defined in the mshv driver.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  arch/arm64/include/asm/mshyperv.h |  2 +-
>>  arch/x86/include/asm/mshyperv.h   |  3 +--
>>  drivers/hv/hyperv_vmbus.h         |  1 -
>>  include/asm-generic/hyperv-defs.h | 26 ++++++++++++++++++++++++++
>>  include/asm-generic/mshyperv.h    |  2 +-
>>  include/linux/hyperv.h            |  2 +-
>>  6 files changed, 30 insertions(+), 6 deletions(-)
>>  create mode 100644 include/asm-generic/hyperv-defs.h
>>
> [...]
>> diff --git a/include/asm-generic/hyperv-defs.h b/include/asm-generic/hyperv-defs.h
>> new file mode 100644
>> index 000000000000..ac6fcba35c8c
>> --- /dev/null
>> +++ b/include/asm-generic/hyperv-defs.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_GENERIC_HYPERV_DEFS_H
>> +#define _ASM_GENERIC_HYPERV_DEFS_H
>> +
>> +/*
>> + * There are cases where Microsoft Hypervisor ABIs are needed which may not be
>> + * stable or present in the Hyper-V TLFS document. E.g. the mshv_root driver.
>> + *
>> + * As these interfaces are unstable and may differ from hyperv-tlfs.h, they
>> + * must be kept separate and independent.
>> + *
>> + * However, code from files that depend on hyperv-tlfs.h (such as mshyperv.h)
>> + * is still needed, so work around the issue by conditionally including the
>> + * correct definitions.
>> + *
>> + * Note: Since they are independent of each other, there are many definitions
>> + * duplicated in both hyperv-tlfs.h and uapi/hyperv/hv*.h files.
>> + */
> 
> Is this because we accidentally introduced some host only, unstable
> interfaces to hyperv-tlfs.h? Is the long term plan to drop those from
> hyperv-tlfs.h and further separate the helper functions?
> 
> Thanks,
> Wei.
> 

We do have some host-only interfaces in hyperv-tlfs.h that should not be there.
E.g. the create LP/VP hypercall inputs. We should drop them.

However, even if we fix that problem, the new headers still have conflicting
definitions, so need to be independent.
E.g. enum hv_message_type has many more members in the new headers.

We don't want to put anything not in the TLFS doc into hyperv-tlfs.h, even if it
can be ignored by the guest code.

>> +#ifdef HV_HYPERV_DEFS
>> +#include <uapi/hyperv/hvhdk.h>
>> +#else
>> +#include <asm/hyperv-tlfs.h>
>> +#endif
>> +
>> +#endif /* _ASM_GENERIC_HYPERV_DEFS_H */
>> +
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 2b20994d809e..e86b6f51fb64 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -25,7 +25,7 @@
>>  #include <linux/cpumask.h>
>>  #include <linux/nmi.h>
>>  #include <asm/ptrace.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <asm-generic/hyperv-defs.h>
>>  
>>  #define VTPM_BASE_ADDRESS 0xfed40000
>>  
>> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
>> index f90de5abcd50..66ed8b3e5d89 100644
>> --- a/include/linux/hyperv.h
>> +++ b/include/linux/hyperv.h
>> @@ -24,7 +24,7 @@
>>  #include <linux/mod_devicetable.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/reciprocal_div.h>
>> -#include <asm/hyperv-tlfs.h>
>> +#include <asm-generic/hyperv-defs.h>
>>  
>>  #define MAX_PAGE_BUFFER_COUNT				32
>>  #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
>> -- 
>> 2.25.1
>>

