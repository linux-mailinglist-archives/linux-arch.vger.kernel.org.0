Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BBD634468
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 20:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiKVTRr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 14:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbiKVTRq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 14:17:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA0D2DA;
        Tue, 22 Nov 2022 11:17:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj5zJJujEYabjfVj5UzelXx/jZVnCiDgszNNJ29FZP6yqjVLaa2Z30L7sNCghjZrTo5XUmpY+y26C98ZL+lofNsWm2bLAkDAwYgASVyINOnIIRfDuOkIgYrLZgT6Dk9GhZyZJmpJ0ogNYNooAhoyJSjYSp40WfFUyvsJgc6JChYEbv+fPK9YUUg/skuKNKE4/GeGYY//EXG7lUP/t4WLBgjJ+YP5umQBHcc3a6PGaqNPK3enZFc9iKOJWKbrCKWRSMXOkRzmPeZl58oNaB9E4hlH+cZHIPOU6T45rgL2kgKPsW42ENLvdMqwJOIJj3nUx2Ldxe94ZfCWKLTLDaqSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a32YFfhETknCWVru2bZJ39/AMxirIQgQTHM45Vc2dq4=;
 b=IMLPil84gLNkGB5IPfIaqtjgtn/oHucv6MYFBsWWuQzTo8egNYF3xFrUWrPpm0l4IPEcSGzxdOlgJuesv9nrbXIktWQpeOlYzJVU7P6pkNqNyQ0SvgZZmAnc9xcxIDJATculsTGasw9XcPxagNFKo7IbAUEN4PwprP6+BSZziRIHLpeV0qZ6PcaKn65PVXCeNg6bhXZ9J4AK2gKHt4AlHvitOxkqy8gkABAyYkdniX08pevz+tnVkslL5K4WWHDdJS6nkBnd+aXrQmotJjaVyUBRGVEXSdiu/8BwNUBqI3ICxhIgAZiTeZIkoYSrJcIffUU6EU5tU+lGy3LMMEAlsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a32YFfhETknCWVru2bZJ39/AMxirIQgQTHM45Vc2dq4=;
 b=foIgM/MabjHKa27pJD8Hfvh+645BpsZl0XGXr4MNNqxXevYEhJtaOTMgbfuStaDWMvpfDtUomdDcwNPc5+rt88FpH9jgpRYZk2zKLJEVUVQfWcDqC6DKoU5yrFi3AfkcErrtb6DvfgxsbbzrSMvOmJrM+rIEgZFO+hfcIpckCV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 19:17:37 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::395:21e6:abfd:7894]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::395:21e6:abfd:7894%6]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 19:17:36 +0000
Message-ID: <29c65421-2478-4e29-d803-2dbecc9ffe1c@amd.com>
Date:   Tue, 22 Nov 2022 13:17:31 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [RFC PATCH V2 16/18] x86/sev: Initialize #HV doorbell and handle
 interrupt requests
Content-Language: en-US
To:     Tianyu Lan <ltykernel@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        seanjc@google.com, pbonzini@redhat.com, jgross@suse.com,
        tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-17-ltykernel@gmail.com>
 <116799e9-8b14-66d6-d494-66272faec9e9@amd.com>
 <2f3c100f-355d-e4f2-ff42-2cb076e8aa86@gmail.com>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <2f3c100f-355d-e4f2-ff42-2cb076e8aa86@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0416.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::31) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: fc354a68-1be9-41f9-df68-08daccbe36d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SNvt9P7Ag+SdxH0h8ZGAh3ojqD3q3SixQ8k/98YrMmfuooZOE+VAMAigh8j5V1St+ag3K4sQZ3q/frYb4HCS5jRDKgc8wOmSkQ1IwySoJU++MEofSgk/M0emxXymULhWQV2mOV+40BaDsrNOmVBJsR+PBHDaui9rszpawi3mv45mT55C52JO7K4LtFDsW5XiF7bLoQmqHqKxlvvDSeltE5cnptx0QJN9dym1XZdiRTBDZmFe5PluP8bl0xrwanZkUVbYwXwAQMDPUbzcL3yIo0y0PiYnBdKHVjeeQtj8HXEP6IqcUIf6ulgDWnbcCCTvgOsb5KB3Q/ZfvxaKOxiyQKfZol8VNk59wP2OtZVkSTJYMaYEFUldKtjGB45Gc34zBu0RVv6Jcu2fPysX4J0/Bls+KRENI6p2DzOEFGhslFZ6j9xAI+KEcw3nsS1g6zAwEuFs3ydaZCLXaf2T7Vw85CIFIjqCcgvf1EQPMbvAk+94s0xxlaYyyqHp9hX/VVT+Qt9Kuu8v3Kx0dEBZ3IZ99mO0kjtWi9bCFSd1+Fch8tZN0oGFslxCZEMhyPPW25tSDMcs/RVycBZJyOd4CZNFvZSnPs7gVQc7ds5l/WRbiJEI03H4mgCzesCVrVN9t1/LeQPO6CWuNJH9o2PgXa0SxL1rT5kQ/T3PW1ne5pqBJwh4n+pVWW7ZHJ6Bm7L8s9nQ5SSVFhiilYVagVcT9eDEEd8qbqI6VMjm5c5sjUkh+fcHDOWc1bUA/fXSrSzsnUy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(921005)(38100700002)(86362001)(6506007)(8676002)(31696002)(53546011)(26005)(6666004)(186003)(5660300002)(316002)(6512007)(6486002)(66946007)(478600001)(66476007)(4326008)(2616005)(83380400001)(8936002)(66556008)(2906002)(7406005)(7416002)(41300700001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXhIL2ZtU3M5ZGZiNWdnS1BpblFDdjU5RWhZc216S3JqNGcwL1VCQlBMWXlX?=
 =?utf-8?B?cnF1MkFrRFVIUE13dC9zVFFHaVR1MGdSa0ZFODZvcnR5YWFsTDRWNitUaUhP?=
 =?utf-8?B?bVRTcnpabXJCZjBVOXBuVUp1SlBjT2xNbnBlMDRSYW9mcnNxUUxxWmxSQ1NQ?=
 =?utf-8?B?WGZTTllzYzFZR2pqTnFGM25FWmpJRGJINzhRWUp3dy9IWkE4MFJpQ0ZLVEpx?=
 =?utf-8?B?cEpJYVMvakt5bmdKbHlFMFYzNGRMWDJXKzc2ZitsR3lCRXRPMVR6ZjhuT2RP?=
 =?utf-8?B?ZkNzTjhaRVBSaVJEWG1BK1hNUUJjNEs4QzJtb1pQcXZIUGpFenlGQ2pLYjU3?=
 =?utf-8?B?c01ZK0NjQ3FzdUN3RHB5dldmWEpGcGJLZDJwVUIwYjNSaVNTYTJEdjBVU0Nx?=
 =?utf-8?B?cjNOVnVBWFl3SytlTUlnVmJLWitPRllNWHBjdVErdnJoQ2RrYTY3b2tTVzBh?=
 =?utf-8?B?UEFJZ3N4U0NkNTN3ZGIrNkh3YUtOdXdNUVlDbDVqMEVlbVhiRmpRWXFGTG9y?=
 =?utf-8?B?UjAzdlhLNTZLczczRlVpSmltSHQrTEhrM0pxemtSL0JnRlg5dzFVQjVRejVl?=
 =?utf-8?B?Q2ZWZHRRdFRtZ3hXeERDVy96dUhGWVBFYTlVamlPYnV0VnAwc1I0MXZYd2lV?=
 =?utf-8?B?TTI1WXh3Z25ERHZYTlNOK2JBYWRidjI4Tk8yYWtISENEZ21mcGh3b2ZwQUlq?=
 =?utf-8?B?ZjdjYkM2Qk4rQUdHeVNZOXlkNHpUeDV0QkNGVG5GcFVKMHlhSWdxVzhicmZS?=
 =?utf-8?B?OFVUWWY4RXRZbW9TaHYzelRRbmh3ZHhjQmlkOUt0ZEh0MThPTWFzVTNVME1Y?=
 =?utf-8?B?dXl4d0RaK004bFEwZjBHcU5FRDNmSTE4R3kyUWlqSUwvWDY0bnUyNGR6Y0dj?=
 =?utf-8?B?aUlLSm4ycXZlbkpvQzc5SUZsV3Q4QjhITVpaWHVhZUNBMkNucHZUN2UyY3h4?=
 =?utf-8?B?SzA1U3ltRlNSUWpzbGF4WGhvRDF1RUE5QzVaZE9XLzZqOC95MnZ5OXR6OVpR?=
 =?utf-8?B?OHNhWUx3V0pCVUpZSlVKcFhtQ0tTcVJUL0F4Q1MrS0R5eEJRdmg3b0FzdUl2?=
 =?utf-8?B?UTJxaVJuc28yT2wyRDhaU1kvQS8vQTBsRW5BdlQrL05pSVJCUDIzYmFOWGU4?=
 =?utf-8?B?NDlyUmZRbDhZcVRnckNIWjE0cXdiZXQ5RHhtaStCUTlZeEhHOUtrN3JSYTMr?=
 =?utf-8?B?Zy9MS2FpNU54VVBQQmhIbW1lLy9CZE5CSGI4VjlQdXVOdWdmbmp6RU1TQlZE?=
 =?utf-8?B?aEx1bUVZVTd6Q2wvVHMrVUVzM25VVEVQdWpYUERybUdKdGE5UThpTHMwNmxr?=
 =?utf-8?B?VnE0NVdhNDBnUEZXZGw2NEMxSlhTZGdZREsxSHk1YUdSRXd4MzZadzAzWGdu?=
 =?utf-8?B?N0hUdUZGTUM5WCtabFYrVHFwRXV5clpGZWozRXRidTlWdS9HMmhXUDVJc1Np?=
 =?utf-8?B?OUY5L3cvNmlkejhuaFY2eHVpTzIwK2gwU0pYOVBmbG9vVFhWdTNlMy92VHJI?=
 =?utf-8?B?TUJlZ3dSdFZFK1lsdUx1WWQ0RDdBeDQ5L09qSTdYTmdBRFhaZ0UvQlFYalFZ?=
 =?utf-8?B?QWVoZnhBTStkSkllMEtobTBrVDdKQUZsVGdLdk5zTmFGSUVRRTI0OHJtVGlV?=
 =?utf-8?B?UXQ2dXRwYmhQRDF0V1VvMWY2TStJaytRRERqVWhiUWJUVHhVcm5wc2ZJRHo2?=
 =?utf-8?B?dDRTMHQ2alBDWUlNWUc1UXVYV1k5NDQ5UGJMZFd0MUZ4bXNNaGlLSTI1MXJ0?=
 =?utf-8?B?YlNkVUVtejh3c2ppdU13R1NvQ2tHdTRTcHkvempRekwzWXQ2Zm5MSS9SQWZn?=
 =?utf-8?B?KzNseVFCeVhnR1VFazlmTXR2TXJ2SnVjc05naDZIZzlXbmxIUXNtWTBuSFor?=
 =?utf-8?B?S1lKaVpuZEd6UFUrN2RSS3ZvZ3hBYVdDQS92SXhtVnJhQ0JLeVptRDZSSTg4?=
 =?utf-8?B?Uk5SWSt1d0xEekg3eUUrWWFUTVY3OXRSd29MeUhua1VSODdoTDFhSlJDL3RD?=
 =?utf-8?B?YjByVzBOeHhMZ2Qwc1ZCekZ6UWVoa0JxOThSaGdnTGlINHdScFVtWE9NZlFs?=
 =?utf-8?B?MkJDa2JndzVVRHRZWHVsZkpucWVzYUVRdFFUTDl3LzdHNFlMVkYxd0s4SERV?=
 =?utf-8?Q?RK3GI/Jofddof15fhxuVYj5cW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc354a68-1be9-41f9-df68-08daccbe36d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 19:17:36.4422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2oAxX6qnRH8lnz9ZbwaEvJA/fL5v+VJYqDaxoX5SqCywmBhxCzT3U+sWTj6FB5apdKvjTn89ZzCWCltJ0Q6/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/22/2022 7:46 AM, Tianyu Lan wrote:
> On 11/21/2022 11:05 PM, Kalra, Ashish wrote:
>>> +static void do_exc_hv(struct pt_regs *regs)
>>> +{
>>> +    union hv_pending_events pending_events;
>>> +    u8 vector;
>>> +
>>> +    while (sev_hv_pending()) {
>>> +        asm volatile("cli" : : : "memory");
>>> +
>>
>> Do we really need to disable interrupts here, #HV exception will be 
>> dispatched via an interrupt gate in the IDT, so interrupts should be 
>> implicitly disabled, right ?
>>>    panic("Unexpected vector %d\n", vector);
>>> +                unreachable();
>>> +            }
>>> +        } else {
>>> +            common_interrupt(regs, pending_events.vector);
>>> +        }
>>> +
>>> +        asm volatile("sti" : : : "memory");
>>
>> Again, why do we need to re-enable interrupts here (in this loop), 
>> interrupts will get re-enabled in the irqentry_exit() code path ?
> 
> Hi Ashish:
>      Thanks for your review.    check_hv_pending() is also called in the
> native_irq_enable() to handle some pending interrupt requests after re
> -enabling interrupt. For such case, disables irq when handle exception
> or interrupt event.
> 

Then probably add the interrupt disable/enable in the caller
function like native_irq_enable() which seems logical as 
check_hv_pending() is always called with interrupts disabled (either via 
HW or SW) and also interrupt disable/enable seems redundant in 
check_hv_pending().

Thanks,
Ashish
