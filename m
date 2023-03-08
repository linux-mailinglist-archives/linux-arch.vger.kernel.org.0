Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAB6B0E6C
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 17:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCHQSi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 11:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCHQSe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 11:18:34 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A45C9D8;
        Wed,  8 Mar 2023 08:18:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpTpFNetVpKd6xpNY5wi97fyHb0jYT9CFCWMOI6XG3zWjTNCQnS0BbrDZFF9/2+2Z/1cJCYAI2v1Ha0f/BiMYmRK00hTOh1mwoiW5Ymb56MRdeemLH1WEMImEYzBJVYTxXqObe/b749R5SpczWKqoIxpUqwGAM+SP/yDBgcUU2Sm423JTrxB6TMHrsY3V8rnB55e+6zaKScA7T3vyBEk/TCRfMyXWFauz4JAW1twqId4yas/XW40UlRlDTzi5CosvTibaLZFSZSbxjXbStLkI28lbejeZpLptUD77Lmnqrgq5tEzNpsje7frf123LgSd+dCkyP2MQXQm0rpP+gacVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5KQkv9OMYdoR66YLzSYfcspeil79aV/4IT2zyy2NWU=;
 b=fMWoNffoNx5WjvnIhfMDYlnks/znOBTJbSR56ZtMEmpyruHiZrzBHWcBsn6VTfVixR3L825I2FdxIPE5MfvqRCQJkHIe96m4QHXBM1BFDOKP8WqCFf/X2wFZAQwf6dFtFTa4wIq3lHMYhNqkcLI6OJgXCm1RdN+ikZE3zPPvTD5yVek8Yu8A60bNIMYzvQBzXYwSRemRgSORNyeQCpxyRm6CCONHWntUSZfHm0ZBgYLShUmaSNy36IuAtw4AvZF7+dMwZEyCGpNcZ2Xqc9l0Skof+cQjE/UOMYBE+50P0y7yFdakQY6XnY18AxcGYaNN517GeO1AR/VaduOan2OD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5KQkv9OMYdoR66YLzSYfcspeil79aV/4IT2zyy2NWU=;
 b=B7GhCKsS9lvqPqe92RoDQX7Q/V/5LS4BidoGgiGhjpWTg2l//zvcVuAJoofDLtOPeOGjG8ZMm6gDoHvQEbUY4Cs4a96rVCG5UGobwsdQzhwFxKl4NJY7iEglPP/tiORs2xsIpZ6O4IKwWSL4WFPZbusapRKmDgtPSUaXvaJfYjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28; Wed, 8 Mar 2023 16:18:28 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf%3]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 16:18:28 +0000
Message-ID: <5061dfee-636c-6b68-8f33-5f32e5bfa093@amd.com>
Date:   Wed, 8 Mar 2023 17:18:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 13/16] x86/sev: Add Check of #HV event in path
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
To:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
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
 <20230122024607.788454-14-ltykernel@gmail.com>
 <e3c53388-f332-5b52-c724-a42d8ea624a7@amd.com>
Content-Language: en-US
In-Reply-To: <e3c53388-f332-5b52-c724-a42d8ea624a7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3c610b-15da-4824-d10f-08db1ff0c062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwzbxmUSYcAAy77TAhAod8Uy3Jax5z+I8OZfxQCkc+k4RBzqVQ4dHHOoNt4Lg49FkQXFBFjtd0vn9A2aJIEohYH9925Ud7wqWgZ27PhgNxqRhw1HlxmTkUeliUT6Mm5CVgdTv+S/h4cMwOsi4LISABCWN34DsANY6+RqR4nrBMR57UFu0TKUZPK5q6yM+2ZY7W2MWq0mumcrOVvqhiVkxoYnSYwDQSF8QMv1pcDTBDmu1pEktrjhkNE9IyyG8gLBYjm7VpmvyAn6TOm1ZCeH03m+JkK3rj/6X5CbinqNMK+QWO4WJQihPNb8Hb7KlJoEAfW1E1KFDeXO1kKrKJbtDvg4zy6B4gIv1e9DfDMX9zMpSVey31D/eUCh6CIOofdOAEWc50YyQJ6yxIUPdiGLzXlMA/uQOWtjKcUzzEM9xwORdQmwXb8mvwvxZkCg+h2NrUoDkJ/CO+PCdyBVZb3ywU35IIqdQXXHxHNIe2jMqRxKQOyoJvd+JEVxWcQrdR9O/197lD2+ZrHkysL4uQVCLH6XLJKHvrud0FJACRzj07Wc5RD655iwrFOQK0aO8gT3kI6WgQP4O6d5g6gc2QjqDPB1ykCUwTAUGMa7skH7naNSZ0PUX0Hdk52xS1wTEVZz10FO1+wBU6CVOw3vHHyY7ZUUz+C3VX6y9Ft4K0UbyHojq6rAKm+owxtusKqbR33r3+qpWo5EUvEUpj9KEdjXcn5Hi/oNpdHQocGK48NId+BE9KASEcrI5CunHAX7m+GN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199018)(31686004)(316002)(36756003)(83380400001)(31696002)(86362001)(6506007)(6486002)(186003)(45080400002)(66476007)(2906002)(7406005)(6666004)(41300700001)(7416002)(8676002)(66946007)(2616005)(6512007)(26005)(478600001)(66556008)(53546011)(8936002)(4326008)(38100700002)(5660300002)(921005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWd2MFdtcW1TSTg5eUJudDZtNFJtdWlicll0NDUxWWl6T1p1dHhjNytEY2NW?=
 =?utf-8?B?U2krQXIwdEpJRTRvYXdBY0VBSE9VQ0luTG1VWUd0SFJXOUVxREZrWVJqNE5s?=
 =?utf-8?B?WGxINks4QWs5SEYrNmN5RFlRRmN5cVRkYVZBUGxJVWljSkFzb3ZIMWQwdGtR?=
 =?utf-8?B?aDI0bkI1enBzVjlsVUdlc1RpUHVENFFuRjQyMUhzdkZrR2lCaUJRaFFoU1RO?=
 =?utf-8?B?RldLNk9abkRBVWZNOVkzdCtMQms5bkVMWDgzTjl2YlVySGV4ekN3NVh6eEhY?=
 =?utf-8?B?RVlxZFpYZDJibW1oZXl6T3ZWcHhDOCszN3VBN1FsR3VjWHlQRnlTVXZuSGg2?=
 =?utf-8?B?d292NndxalBVZk42Z2YrWXdZV1RGUkFjVEZ2QUczUTNPbmE5aFRoa0orb211?=
 =?utf-8?B?bG5HZ0pQdTl3NklWWS93emFhSzQwZWFWc05sUUx4YWREZElZZko5Ly9hNHpp?=
 =?utf-8?B?T1RCWHdaMFNaLzZsdEtOZkZEQjNCNmp4alptVURkMExVRkhjQnJISTVlSkNw?=
 =?utf-8?B?Q1MyYWd5anlBdXZzTC9TZjlTOGJ5b2lxZ244Zm5zd0x4MVk4SzdsK0JOWWNk?=
 =?utf-8?B?UXh3bTFDQTRLNTdzZ1dKTUQzQ3NCWEZJaGE4eTVkdG5LQ1RqZGtHYjg1bjQv?=
 =?utf-8?B?TDdrZmJwNE03ZGMvejcva3RjaFRhdkQyUmRKZ3JwVGpwUnVDVjJzNUpLaUJZ?=
 =?utf-8?B?KytUWmx1MHdUdTliZ1FWQU9SeUg1RGxEQnYwVjV2MmVEa2dvd2U1SU9IOVFx?=
 =?utf-8?B?cm95dFlrY1BFKzdJM21JY2ZXRHBKTmR4RFZtTlFXZ1JDUDM0ajBXdnFWNCtJ?=
 =?utf-8?B?YTRJMzhlNFFmZ05UU0JNQjRvZFBGOFRYUExPMnl3cGlYZWpsUDdFN1lSeFZ4?=
 =?utf-8?B?U01CUUg4cTVYUFBYeUJKTSs0MzN4RUNteHlYZVR3UjRJcG42YnVISVhrRVNr?=
 =?utf-8?B?bTFPM0VseFUxaXA4bEp3Uld5enNsTHVFZkxJdGxYeVZaUTJmY21sMTczVzVG?=
 =?utf-8?B?Z1JHZWZEVEo3dU0xRkxzTlAzZWJ1bkFKNnVCT0xlYVQvZG5oZXhoeUlzZnZW?=
 =?utf-8?B?R1RkZVNkUWk3YkNRMkNiVDBlWVB2QmFLcXdWalcvajl2MEJ3Tm1kTjl2Y0ZQ?=
 =?utf-8?B?ZVNRZ2xVYUV3QmlpMGRMcEluaE1mSWt1czFQZVlUaENDNmpjUS9TQStwVUJB?=
 =?utf-8?B?ejJoNlZKeVRTRmRyRUxLWE00RWp6ZmVOejRWeXVKd3NsTkZVZW9peHB5SXdx?=
 =?utf-8?B?a1p0NWZqQzZwaFFJZ2d4K3dEblFjM2I1OXVXR1hZZS9mTUxabllvcGRnbEVF?=
 =?utf-8?B?T3dBUW5HR1hTbW1uYzU3eGM5SnBWc1d6SkRYYWdmZ3lFV3hhWDExaENpR3lo?=
 =?utf-8?B?STE1RHdQMzJVbzhWZnhNdzdoK08xMldld0RWamt0V0lmVGhFeXpVWHZsQWNO?=
 =?utf-8?B?TlE1Z0tlNXY5cHNhQnlHaSttVS9vR0tQNjBQeTFjWEEyTWZjeS84aGhKNlBU?=
 =?utf-8?B?OHFPKzdFS2pQRFRHZ0tFeml1WWx6N0E2MHNKYnlYS0d0VjBVVzNnQmt0UHhB?=
 =?utf-8?B?V0lTYWNsTVZOb0duV2dRV0xPUm5qcUh3MVZJRUhTR1dtdHNhZHpSSTJzQTZq?=
 =?utf-8?B?b0RzMGNjNEY2WTI3eWJwejBwNkVVNnNLZXVoV21ESmxiWE14dWhwQXVNeVlJ?=
 =?utf-8?B?bG81anprMHM0U3B0dkF1VjJHNTFSTUsvZEFlVjlnM2hFMHJvc1d4c0xPNTN5?=
 =?utf-8?B?UGFHaFVDejdJRTBOa0QybkRqRHh5SS90bjFDL3NKSjM5a3lTUG1xa3BwTTNO?=
 =?utf-8?B?RWdON2JNTjFuRytlQlRhUXlYd21yOHBmbGJ0OFhCQ2xob3ZabEdNV3pIZWxa?=
 =?utf-8?B?OGs1bnc1b0xyVytPdkFFK2M2aU1sZ3VmeGNlU1Z6RVl0cUI1c3VzOGlSVkhv?=
 =?utf-8?B?NGNnN2NuYnJJL2pvc25QbWcvOWd2L2dFYUovMnhaS3JoWThiR0V2cXRUK0tL?=
 =?utf-8?B?YUJzOHlpT1RXdFdsMVRDVU1qSlJBYXBHVUNLd2xKQndqOHJXWlM2QVpGRVBN?=
 =?utf-8?B?R1JrdGdmWUZha0dSbW5WZ28vK2FjdVdrK21jZkphNnQyYVVtMEVyalQzMStu?=
 =?utf-8?Q?8gV/GssbBylHNrV7qnuUIRPOx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3c610b-15da-4824-d10f-08db1ff0c062
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 16:18:28.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q00zt1nqUdYoFYzYe2slpyaL+SEq/5BrQQRb/stG3rRDU85GorG1UYFPq3vJHwg9IDo+RE4Re/eM/XKiUYPvpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/1/2023 12:11 PM, Gupta, Pankaj wrote:
> On 1/22/2023 3:46 AM, Tianyu Lan wrote:
>> From: Tianyu Lan <tiala@microsoft.com>
>>
>> Add check_hv_pending() and check_hv_pending_after_irq() to
>> check queued #HV event when irq is disabled.
>>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>>   arch/x86/entry/entry_64.S       | 18 +++++++++++++++
>>   arch/x86/include/asm/irqflags.h | 10 +++++++++
>>   arch/x86/kernel/sev.c           | 39 +++++++++++++++++++++++++++++++++
>>   3 files changed, 67 insertions(+)
>>
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index 6baec7653f19..aec8dc4443d1 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -1064,6 +1064,15 @@ SYM_CODE_END(paranoid_entry)
>>    * R15 - old SPEC_CTRL
>>    */
>>   SYM_CODE_START_LOCAL(paranoid_exit)
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +    /*
>> +     * If a #HV was delivered during execution and interrupts were
>> +     * disabled, then check if it can be handled before the iret
>> +     * (which may re-enable interrupts).
>> +     */
>> +    mov     %rsp, %rdi
>> +    call    check_hv_pending
>> +#endif
>>       UNWIND_HINT_REGS
>>       /*
>> @@ -1188,6 +1197,15 @@ SYM_CODE_START(error_entry)
>>   SYM_CODE_END(error_entry)
>>   SYM_CODE_START_LOCAL(error_return)
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +    /*
>> +     * If a #HV was delivered during execution and interrupts were
>> +     * disabled, then check if it can be handled before the iret
>> +     * (which may re-enable interrupts).
>> +     */
>> +    mov     %rsp, %rdi
>> +    call    check_hv_pending
>> +#endif
>>       UNWIND_HINT_REGS
>>       DEBUG_ENTRY_ASSERT_IRQS_OFF
>>       testb    $3, CS(%rsp)
>> diff --git a/arch/x86/include/asm/irqflags.h 
>> b/arch/x86/include/asm/irqflags.h
>> index 7793e52d6237..fe46e59168dd 100644
>> --- a/arch/x86/include/asm/irqflags.h
>> +++ b/arch/x86/include/asm/irqflags.h
>> @@ -14,6 +14,10 @@
>>   /*
>>    * Interrupt control:
>>    */
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +void check_hv_pending(struct pt_regs *regs);
>> +void check_hv_pending_irq_enable(void);
>> +#endif
>>   /* Declaration required for gcc < 4.9 to prevent 
>> -Werror=missing-prototypes */
>>   extern inline unsigned long native_save_fl(void);
>> @@ -43,12 +47,18 @@ static __always_inline void native_irq_disable(void)
>>   static __always_inline void native_irq_enable(void)
>>   {
>>       asm volatile("sti": : :"memory");
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +    check_hv_pending_irq_enable();
>> +#endif
>>   }
>>   static inline __cpuidle void native_safe_halt(void)
>>   {
>>       mds_idle_clear_cpu_buffers();
>>       asm volatile("sti; hlt": : :"memory");
>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>> +    check_hv_pending_irq_enable();
>> +#endif
>>   }
>>   static inline __cpuidle void native_halt(void)
>> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
>> index a8862a2eff67..fe5e5e41433d 100644
>> --- a/arch/x86/kernel/sev.c
>> +++ b/arch/x86/kernel/sev.c
>> @@ -179,6 +179,45 @@ void noinstr __sev_es_ist_enter(struct pt_regs 
>> *regs)
>>       this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
>>   }
>> +static void do_exc_hv(struct pt_regs *regs)
>> +{
>> +    /* Handle #HV exception. */
>> +}
>> +
>> +void check_hv_pending(struct pt_regs *regs)
>> +{
>> +    if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> +        return;
>> +
>> +    if ((regs->flags & X86_EFLAGS_IF) == 0)
>> +        return;
> 
> Will this return and prevent guest from executing NMI's
> while irqs are disabled?

I think we need to handle NMI's even when irqs are disabled.

As we reset "no_further_signal" in hv_raw_handle_exception()
and return from check_hv_pending() when irqs are disabled, this
can result in loss/delay of NMI event?

Thanks,
Pankaj
