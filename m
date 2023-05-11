Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5666FF2C8
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 15:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbjEKN2g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 09:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238054AbjEKN2Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 09:28:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495DF901F;
        Thu, 11 May 2023 06:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSFkmLMh1jXBxGzYxSbKGjZ0CXDY7wKLC3TQtx8LElkdsrU8/vnuhfT/MxCNbqapEIDjsdwEp0/jlQJUuooZGPdThaMpsMndLGKBtquWmlKgkvtymBqlPqYGeaBqaQ5+8pz60OboBNZaAmBPMzjk4Wn2ITshGOnQZMPekK5YIkAcw54PTCfjQAHNRVWXGLVdWOyNfV2wDp4G6j6pXYb8zUkDyj7wyTehZrJ+v7XGPz85dBT0JuXBP8Y21m9d+FRxksQSJlgMoMTch5zRI2WHmZeb6X6+c+m5CLcMVmb8cMD+1+MQqiVHxpQU+adNdVc97Iioz9jDkBn8isEpv/Y/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnjAyMcbvSZ6flQEIiLeP0RO7E02Pe0ZK4z9wWAIwMw=;
 b=XyVVz7wp9zRvxekt42PxSQJP7rASblp8m+TP04Vd7VR1jQB3RqPtrnc+D4FuqGgLlRJaKrmd2upNkJJBj/ugDYieZgkcEpgD3LNhdoV9z1XwhFbbp5tvJpQC3o5E/r2rr2Zv7/ZY4eaGGyWRZNHgh69wqaqyLT2CF5gic1E7R+Duj32OCgiAfD05BysL2D7jGIuDPrrdFq/Hyr0gUwUoryd/md5h2qVqBQwAnmbHrgW22xXNb1J5sRVo155/UMuuRdiG6F8w/wg+IpjS88ZKPSuohPvbF2WTmOCb56Cd3tpJkuUbOrW4p71p+zM3imcxD1X5+YmMRU2e4ZsrvuwSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnjAyMcbvSZ6flQEIiLeP0RO7E02Pe0ZK4z9wWAIwMw=;
 b=H6SF7YmfyZd5bq+4wbGfaQ1YOBlQ5+lVNmDQjnUjx4+8aUPiLPetGkuIwvfE3IOn6y2XRZWwR64JHGzowXBvHWEiPzGrhaaOw5/oWUASJp9Kz8HzMn1LNPBtoETt4i236hCqF9iMZn6/3uhyxqKchGVOa07zaWqjWVJyrFSvoPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Thu, 11 May 2023 13:26:42 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::f8b0:cf29:9e21:380]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::f8b0:cf29:9e21:380%5]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 13:26:42 +0000
Message-ID: <c40fdde7-52d6-c50f-03f4-58584f11ba4d@amd.com>
Date:   Thu, 11 May 2023 15:25:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V5 11/15] x86/sev: Add a #HV exception handler
Content-Language: en-US
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230501085726.544209-1-ltykernel@gmail.com>
 <20230501085726.544209-12-ltykernel@gmail.com>
 <3ec60d7a-c5e7-2570-a0f2-ef435d904cfd@amd.com>
In-Reply-To: <3ec60d7a-c5e7-2570-a0f2-ef435d904cfd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 3233ecf1-3b14-4fe5-4244-08db52235b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qK34l1R4kMFoG76G04VkKyvp2RieEQXV9KmmXcqXbirbqacFCqOHuGEwxKk7vRj3vluNB8JIsiVOQkiJg7+OBH4RGnMENsgSIf5KT+zMkNpADA8fmTD4ay9FORd9s+ZZu/Lj0ZVUkQWIDeqGL66aD0uYY+IkMgIBYlhYo+iXA6F/H9O7WHbG/1uGDPBERQiLkWfYJfDReWPSH9Ey+keS3AoFbi7DRlDfF/d25YnK1iNhzOqlWJHWGFk7cWmN5UE3rRpoVbhjpMH2eKbl0GXNVNPi8EfEDSemOs9VYxKDkcyRLsI45KQJVZUW7a7t4uz+9iARzoa0a8O8JiKr/IUuC3HZWAjBIX/m1gl20nmGftM6aIihsi7C1oXbTi6KadO9Xb/nBHjjPbX5i+M5rxU7d+txVH6BSNo6pSCfI4L2DLBo/hrSWW4yBEO1VTaer8s+eLt+ZieXNXYWj2/GYeHLJl7QIJGHCRlclUelj0uTLfjPtCmXF7y1MRQX5vjSbaxD5gGFdV/UZF7H5O395DH0HNtHCinT+1JxIPh6FrhT79XnMj+MA56LMjJ4rAiBM99Nw/uHERnpRKWV5Y0dms3EKOkXiVurydIvVzOqZdIQRPO2ow0IcuF3i+JVZuoc0eglr5OHi4DojotAVvtjIV9QFQqVXu9ZoDVSC2J0Ntyo+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(66476007)(5660300002)(4326008)(31686004)(8936002)(2906002)(8676002)(316002)(66556008)(41300700001)(478600001)(6666004)(45080400002)(66946007)(7416002)(7406005)(31696002)(966005)(6506007)(6486002)(26005)(6512007)(53546011)(186003)(2616005)(83380400001)(36756003)(921005)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FmRitLd2RVNm04aVFHMWdRZ3AxQlhwQlBWbmFwZFZXYno0SkkwNmdQWmZu?=
 =?utf-8?B?dlkwZ1NZajFIbXBoNDJXOUtmTUliMmdRZnpBYXZzQk1PODF2cHAxTFliT3Fn?=
 =?utf-8?B?c1pyOWVCcCtIeHl3ZmYzSTFibkp6bFFWU0Z4WEtBZ2YxeVJ1UGRDVy9zM3dM?=
 =?utf-8?B?MlRyeURIR2ovL0JPRDJyMkhmcTMzeTJCNWYwVmlPQ0RqWlZKZ1VybVNGQ1l2?=
 =?utf-8?B?dU9uRTMxeVU5a3JmMmxIc1VyUFp4Z28yUTJDTDVkZFNJR0tBRjVxTTZuV1Fv?=
 =?utf-8?B?SFJUbmkxRkdGeGcvUnZpZ3VHeHpKb3pPYzc0R0psMGdRQkZDWGdUL3pxS0Fx?=
 =?utf-8?B?bFV4Q1QrRnFiSytzRjVseWZUbVAzdHNNUTdKQS8vdCtOSkpwTWx0dFYyeDNB?=
 =?utf-8?B?TUplZnBzaUlJZ0VBV3RMQVJkOXkxOFp6dFhPMXR4ay9DTFQreTJmdmFXai9V?=
 =?utf-8?B?RnpBbzNjdElIQ0hjbkhOOWkwMmViNVJoNHVjVURRVXEwbGRwQ1Fqa0ttZnZH?=
 =?utf-8?B?TU93bWo1M3ZQT0ZsNFdGKzRJNDNxWlZFclRRWmQyUnBWSjl0dEpScTJ5Nnht?=
 =?utf-8?B?NkZUM1RLUmRHMXRzcTBvNGF2M1RCM3lxMHByREFqZ3RwNFRZdHJqWVNDSnR4?=
 =?utf-8?B?VUNRR2hhblRZTytZVGJmcklkSU44RWcydHY3Rlo3bE9iSHV6S2NLN3B6UnY2?=
 =?utf-8?B?Qlh4SDlKWVp1N0M4b01VdkdXL2tabWhkZUNvY3E5WHR4RXJmN0hOeDgzYnZi?=
 =?utf-8?B?dTZkSGJuUklpZXVlbnU2MlBDTkVJMWh0RUc1QXZLaE5PR3RrZW1KRFRRVytR?=
 =?utf-8?B?WEFwb2lIWjRETXE3dzhEcERNN0FVSUZQL0tTVDZJWlVFQzM1L3RIMnJBaDFz?=
 =?utf-8?B?ZEFKT3pjU0FOaytCRWdlc3EwNXlaNHpYRVVFR1F6bWlyUG5FL2JZMkJlWVpY?=
 =?utf-8?B?Q2lqV1lIQXZpc1BjenFDUlNqajV0Rkg5K0VvVk5oakI5Qmt4alJXbDdqWWZi?=
 =?utf-8?B?L2VPZnRNd3pnRUVDY0VGTmNGN29pWGJ0QU5OM0ZTNGVGeUFiK3BINW5TUHUv?=
 =?utf-8?B?K1h5MFlNM1NCbi8zLzVvNzdBaVZIVmZteFYyYW4xTEdkb1B6ME5FZWptb055?=
 =?utf-8?B?eVFrcU1VbDJmVXA4aG5ROWpvVjgyaEZpb3A3RU1rakJCM1dMWVNLOWhNY3l1?=
 =?utf-8?B?am54Ni80ZldxaEI3aVljMVdWcjRCanhzdXdMcFpNQjRsOEN6cHE3aFA5eG9I?=
 =?utf-8?B?OVZpZmorR0tDb1pKek9oYkhmdXpDejdnSGJzOGN1bHM5SXRYaUc2VGhRUkg3?=
 =?utf-8?B?aDFFRkVpSkIzL3VsZWMwTnVhRmpyeUlITTh2ZE51dU81bnViSjAwcis1WDVv?=
 =?utf-8?B?ZHFtMEpkVmpoYXdNV3pjdm9PM0dpYWg3V25yaVB5MGg0dEZSUFpnakNadUsz?=
 =?utf-8?B?bzhkWGpxV1U3NXRsTkx5bTN0NExVWGMrZFp0a0lCMWlpWVhReTU4VVlMTW1V?=
 =?utf-8?B?aFJ2SEp2RXE4SktDVVNnbS9wT2FoV0xiZHNDS1dQOEJTb0E4cnZMUU1wNExi?=
 =?utf-8?B?ZHVvd3BmRnpyWFo3ZCtHYXpvNGhybm56Smo0bVU5ZnlsZ2VIR2xDcW9iNjVX?=
 =?utf-8?B?aEo2d2VKb0FhVVZlQlZVVHpTY3pwRHNrem5rc2crNXpiL2NxNlhjVVVnZERL?=
 =?utf-8?B?TGJGMjNYWGlnQ1NzV0toWmVlclhXNGhkbUx5Ny9Fd3FFWlFvU0xZck1JSTdp?=
 =?utf-8?B?ZHFodm5reXVqeGpWbDNpY3JaOEJmNTBBaWFPYUd6d0d1WGZtVUFjblBoSmZo?=
 =?utf-8?B?bmJkOHVBK0JKRkNGcVZhUEZ2bkU2bXlYOWNhQVZtWGdmMGFtSlRtSjJDTVFU?=
 =?utf-8?B?NVEzRDB5STAwY1dHaENCbHU3cHZwcWpJM0RVSWk4YjZPdUM2MGNJYkZ5RWxH?=
 =?utf-8?B?ZjNuV3dQU3k1N0gydVNUVWZNMTFWamtrWTlyTTg1YTVERzl2TkEzdmwvR1Fs?=
 =?utf-8?B?TDVrZmdNeGNWRm5FSk5EZWJwd1JWb2dGckd6Ym1nRVdnc0s4VGh0OWRPYVJQ?=
 =?utf-8?B?UWl2OGtVN1hCdDkvclByc3pVMlB0SnVYSzRaUG1SU3JTZklzb2VOLzNsbTl1?=
 =?utf-8?Q?IHw868iyiVIkXf55zTKGOJ5Np?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3233ecf1-3b14-4fe5-4244-08db52235b6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:26:41.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llq9EMqs8TIFIu/JiS9CkVpR5u1Gx6CRAHBb/EH/+/A+pLUQ2RKtej6w+lrkv9nDSgwuBF/jrN6O34U/ZyWYdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/5/2023 12:59 PM, Gupta, Pankaj wrote:
> Hi Tianyu,
> 
> I tried to understand some details of this patch. Please find below
> some comments/questions.
> 
> Thanks,
> 
> 
>> Add a #HV exception handler that uses IST stack.
>>
>> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>> ---
>> Change since RFC V2:
>>         * Remove unnecessary line in the change log.
>> ---
>>   arch/x86/entry/entry_64.S             | 22 +++++++----
>>   arch/x86/include/asm/cpu_entry_area.h |  6 +++
>>   arch/x86/include/asm/idtentry.h       | 40 +++++++++++++++++++-
>>   arch/x86/include/asm/page_64_types.h  |  1 +
>>   arch/x86/include/asm/trapnr.h         |  1 +
>>   arch/x86/include/asm/traps.h          |  1 +
>>   arch/x86/kernel/cpu/common.c          |  1 +
>>   arch/x86/kernel/dumpstack_64.c        |  9 ++++-
>>   arch/x86/kernel/idt.c                 |  1 +
>>   arch/x86/kernel/sev.c                 | 53 +++++++++++++++++++++++++++
>>   arch/x86/kernel/traps.c               | 40 ++++++++++++++++++++
>>   arch/x86/mm/cpu_entry_area.c          |  2 +
>>   12 files changed, 165 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index eccc3431e515..653b1f10699b 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -496,7 +496,7 @@ SYM_CODE_END(\asmsym)
>>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>>   /**
>> - * idtentry_vc - Macro to generate entry stub for #VC
>> + * idtentry_sev - Macro to generate entry stub for #VC
>>    * @vector:        Vector number
>>    * @asmsym:        ASM symbol for the entry point
>>    * @cfunc:        C function to be called
>> @@ -515,14 +515,18 @@ SYM_CODE_END(\asmsym)
>>    *
>>    * The macro is only used for one vector, but it is planned to be 
>> extended in
>>    * the future for the #HV exception.
>> - */
>> -.macro idtentry_vc vector asmsym cfunc
>> +*/
>> +.macro idtentry_sev vector asmsym cfunc has_error_code:req
>>   SYM_CODE_START(\asmsym)
>>       UNWIND_HINT_IRET_REGS
>>       ENDBR
>>       ASM_CLAC
>>       cld
>> +    .if \vector == X86_TRAP_HV
>> +        pushq    $-1            /* ORIG_RAX: no syscall */
>> +    .endif
>> +
>>       /*
>>        * If the entry is from userspace, switch stacks and treat it as
>>        * a normal entry.
>> @@ -545,7 +549,12 @@ SYM_CODE_START(\asmsym)
>>        * stack.
>>        */
>>       movq    %rsp, %rdi        /* pt_regs pointer */
>> -    call    vc_switch_off_ist
>> +    .if \vector == X86_TRAP_VC
>> +        call    vc_switch_off_ist
> 
> I think the stack switching logic is similar for #VC & #HV.
> So, we can use common function. Just the corresponding fallback
> stack switching is different. Maybe we can pass the hint as an
> argument (%rsi?) to something like "sev_switch_off_ist()", and use
> the corresponding (#HV or #VC) fallbacks stack?

Also, Please include the below patch from Ashish for #HV
reentrancy check.

https://github.com/ashkalra/linux/commit/6975484094b7cb8d703c45066780dd85043cd040

Thanks,
Pankaj

