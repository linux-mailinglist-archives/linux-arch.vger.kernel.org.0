Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600186471DD
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 15:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLHOhX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 09:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiLHOhU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 09:37:20 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D945694906;
        Thu,  8 Dec 2022 06:37:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InoQtMMLFGxSNLgFHoVpPics7uV9eZMCS8/JPYQr95+RZPHTmW7SgU9tOEJcH/5frkrRG1NLbBai7oppPI0W3AI14qvXC9TwVGhB4PnJSv9sw8AAJKpZgbWb8aanw14jyr/p/4YlK5QhZb21I6OMhbj/jb3x257u51Be/1Znrlyvi9l+YoTVEx8Kiv5fZNFbO7c+xHql6H4TNKEYF42D/kLtKgO8TRK1vtWxPcjDBy1zDAYukTyXAgQG2Wa0o2RO+v6aou6NbHlrXL7Gs4HsgJoLMVoibDylFLjGkfnrRRqmWgzCO3b0rs9F0QRVWT5P78ekISgRd1wzghCAUEoXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/MwRza61a3aYGrs7xvEym8Del1jpd2ovf54JzatWHI=;
 b=a191Sup/fFoPUE5Q4JjpdYNf8ebiFB9s2sfRSh5pPIZXQx4rBK/IjWiuSBdkCsznvj+sUsn548jUbbeAL6WHzWnLTfYy3X40WQxS3xHkLMxbyf6cgmxqy9GaEbcpy5GpW/5PH/2TB7g21G7vXBgJm2tTtXGrLWSpwQJbAR4Z/2ua0IzFyKUb+e5s0OXEXOE4KgAvlaeV+TYZJGgFtvBaJzbr+HBT1lhNJkq9BMoa0RHys7fJj6KC0V0YDDjiDzGxO/VJuigyxaeaiKxENDl5jF76mo9fHFoMqSI8MS3bqyNpY9ChhFkqsm0hhfpiocxeppnj89PJnkkRbA3+LsHt7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/MwRza61a3aYGrs7xvEym8Del1jpd2ovf54JzatWHI=;
 b=qojzHI3zR3KlELSc+o+5gYkAMRjfbWu77xjcZvYwB6YtsAHsSIKGP7Ref4h8P9Obn9fvKGtDrcPEfGPfxCP1YbhdRBjkCigC2p7JaBMVS4ixDpGpWh4njyabwu0xTlC8B+Wq2hJ2zg+tHZhC1GuaPSL9KMVWT2YVT1oBXVhlDH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.16; Thu, 8 Dec 2022 14:37:17 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::8f76:f869:2e1f:331e%6]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 14:37:17 +0000
Message-ID: <cdfb37dd-ad8f-249a-2963-87aca53c94a5@amd.com>
Date:   Thu, 8 Dec 2022 15:36:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH V2 16/18] x86/sev: Initialize #HV doorbell and handle
 interrupt requests
Content-Language: en-US
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
References: <20221119034633.1728632-1-ltykernel@gmail.com>
 <20221119034633.1728632-17-ltykernel@gmail.com>
 <ddb23472-3f8e-191d-fa5f-d18f1a9e4ad7@amd.com>
 <c3123488-1623-831e-783f-dae215b3f457@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <c3123488-1623-831e-783f-dae215b3f457@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::20) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|DM4PR12MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd51f2f-33e5-4bcc-bb71-08dad929b445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6S2zRqcjXAhEOotLk7Hpcknv9+39eFMgW6i3Gp7tGZ7/rvtt85c5FYrHWLmQCULu2v8UxMTTbSAtPknIYgKT0gqzwbOO7i5nIYuMOLUh/CVLzSJ1yQtzylGLcVek7XhrAsvVu0t4KiUtdFB+QJ1ZocDK6hfkDA7hAv0XdZ+wng9/sN3yFBBaEpY8CIZj0beax2e/KFgZDr9gs0WxJQN67GzCAJAjZl9VpFvMg39L26RuGWL+/zNkSFI7Upsv6vunwNHYgPqEk2f28b/9mnNXYMr0O3aAaHwaSZuD9Yd7cK1BXiq+xZF7uUkDfoYp3+JmKPaJnZ4NH8GdBwSBqsIpzXYcMGqEA8nKYzTLsDXXqK65ZF5f1ID860PEYLAlHLr4MACwf3GCzuEpuUyBbo1lZPzUckw/jgxYfaEzdZbC/zuKthW/E7fLjAic1a+EcTGlOMOwMP+qu2vY6b4UJam96aHhFFiPd1rGJRWxW0rzhihkvbPBaRv3wLjTXJoFgyq8SgJWMyvqCEE490Y/NR0JhJZBFBkCPNaE85oOv3DJh/W4jrP/DHISUweZEg+VWeQPkbNDCQVThNEvUA0ZTv+1WaAdjreN5L/oFZZKWSv/TTwwD6hK4LNiOrDWZ7Wu0NMcABERUuU0UbWFCqz2v46VgYlAOFkbFg7rFh6xiw7IkZIaRJWVxcKwWx6MGDmcuBIcokzr1tUyjU/wsGM1ZDrlLGXzEPhMsXMTw45IORxvjf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(86362001)(31696002)(36756003)(6666004)(2906002)(6486002)(478600001)(4744005)(6512007)(53546011)(6506007)(186003)(26005)(66476007)(4326008)(8676002)(66556008)(66946007)(316002)(8936002)(7406005)(7416002)(5660300002)(41300700001)(38100700002)(921005)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVp0ak5mNzJNUDNSNmNmdmxqRlJTVHozNXgxU3U0MVRuR2I1NjBBYjlVcFhZ?=
 =?utf-8?B?YzBDa1JYUWg5dmF3eWM0ZWZoNDI2ZnNIY2ZqZTBneVhSWStDVklZS3d1d3Vy?=
 =?utf-8?B?TitxNjQrSUJDWUgrNjk2Ky9pREx1NllLc2Q5aDVNRUYvdDlHNHBWTDA2bmU2?=
 =?utf-8?B?T0dxZFRPNWZWcDRrTTlzbzZNc004QTdZb3RTUTI1VndLcTdmTy9UeGVvQWN1?=
 =?utf-8?B?aXRIQ0xjTHJkT2JOR3JoblJMY0xFOTgxcllvU3dwZnUzS1NCSkhRQ3h2dUVE?=
 =?utf-8?B?U1BRQldxQTVhcUVGcFFuK2d4RjA0dy9GL05TMkF6aUdpUHgxQlF0WUFCWkpi?=
 =?utf-8?B?UkxydmtRWHkzWVFQajEwWHUyenFvUGtkZE9oYXcvcjRmQXdrZGpIcEgxYUN4?=
 =?utf-8?B?R3YzbXZENkYrcUEwQjhGM2lMMlR5UEZoSUttUFRCTnZsRnVBaGMrUURWVi9w?=
 =?utf-8?B?cDJ5Z2pMRzVva29PREFOUi80N004SFZuWUxaSWZ6aDhHQk9kSGFTTE9hWlJ0?=
 =?utf-8?B?SlJ3TWZva3I4Sk1yUVdJa0pPUW8vc0ZxWkY3UmJUZmptNWxYRTVudU83eVg3?=
 =?utf-8?B?MkVDM0VKQThMaU9MVmVMMmxPTWVwL0NOcWtyZ3FpNG5QWENWc3NKT3dTSlR1?=
 =?utf-8?B?ZFh1anZPWGFzWE5HaFJOMTF0NlRBcTZOZkgwUW5yc0dXTk03eEVjc3VOOW1H?=
 =?utf-8?B?WVFrZmN5YnkzanhKRWI0a3c5blZuakR6L1JuMTM1cURxSWRlaUxYeWZDTC81?=
 =?utf-8?B?NlFiOWVRdUFnekRxcTRoZHNwVjgweWlGWWMxN1U1eTZJV2JzZEkxL2ZlV3c2?=
 =?utf-8?B?K3B2RGI0L0lTcmFBOThmMWlTRTJ3dm1uTXNuR2tQQWdzRnV5Z21GVE05YXNp?=
 =?utf-8?B?aHg4Tk9tYUMrRmJCWXMrOWVBNzg1anpWbXBLSit4bE5zSFJVNjdpRHR4MzI3?=
 =?utf-8?B?SXZRNnZBeG5qUnUzUHhDa2lMWnAvVS9wL2x0T0NxTWY2ZSs0UzhYRFprV2NR?=
 =?utf-8?B?MnpnQnNWQXpCVGlDV0d3SzJvWkxGSE0rbmJ2b1dCK0hna29hOXk2c2g0L01Y?=
 =?utf-8?B?b3d2TVIrWmo5Sm9wd2ZsMUlwTWp1ZlFmMERtSWdnQWVVSmV2UGRFWldaMTlp?=
 =?utf-8?B?V2Q0aE9lWEZaUUM4T2VZOENvOEt1N0tIY0JGa1BSd3ZycGtJdm9KalZtTUZu?=
 =?utf-8?B?NmpKNm8xdmZBeDRFbE1PTnN5Z0t1T3ozTm5iQWFnUVdsNVUvc2puUk9hT05L?=
 =?utf-8?B?QmY1OWhIQjBabDBhWW1OVmZhL0JONERRc2E3NU9yZFVvWkJyem1zcWQxV3lq?=
 =?utf-8?B?YkpqTmhvL1BybU9wUHEwMW0zUG4vaVc2YTM3L1JzSFkvY1F6cWNySVRGUWhJ?=
 =?utf-8?B?bXRCc3FFdWNqVmE5aWFBdDBaV1owRURRVVlkZHk0ckx0NWtHU1dGZmo2aFNB?=
 =?utf-8?B?ME9LMEdOZHFQTHMwK25pRlhqQUdXSjAxWUQxUlpHeDdheW11UnlEVFZBdmlh?=
 =?utf-8?B?dWhsVmRmeDQ3R2c3WmROWjVweGZnemhBOTc1U0lTWDVDakY0TjRTOWJQT0Za?=
 =?utf-8?B?SGlyQkVvcG1VaVBYcEhSSXcyVVlUNTl4Vk9yM1FjUHA0YUErMlA2UjRXSDJk?=
 =?utf-8?B?NDdzdnVzQzhJVmFGd2JHNFpYMzY2OGtkQStueGVaWnJRRWg4UWlhMmwva0cx?=
 =?utf-8?B?QUx0OTFhRTIxYW1aUGptWkFDRUJqdzJKUFdqdFQzcHBreGZMY2c0WTViL2Ex?=
 =?utf-8?B?LzlLT010TkJkWFFwQkI4Y0tINlpQQVZqcXZpaDZxaytDQW9aU3FkVW1tbjdI?=
 =?utf-8?B?UUxvSXY1eWEzUFdhWXVNc1kxaWlEQk5sNTI2T0k3VDc4L0ZuZE5HRXBtY2hK?=
 =?utf-8?B?WWZacEFYcVZjdUNPQ2FZS2N1enhMTGNUWTZSYjNGUWxGZnhlRGZOelplM3Fs?=
 =?utf-8?B?YkZ1dUVSUUNISFpWemJEQ2tGbDVpUGFSM2N0Zi9SSDE5dGoxOUVxZEV4VUhP?=
 =?utf-8?B?SUtUdDZvcWorWTZDK3ZGTk9jUUJ2U09Sd2hFSDJPVFV3QTk1dllWb2pvK2tM?=
 =?utf-8?B?S1JJVlNFakMyM2gyMmZRY0t3YktsUGFLdVRRcmRTOVF2bjM1bUEyZHM0SC9N?=
 =?utf-8?Q?sOeQjtOi1orYE1YwywRrS7lci?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd51f2f-33e5-4bcc-bb71-08dad929b445
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 14:37:17.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nxe6iiH3VC8sj+5fZezymMPqOuWbFII1U8tJfHXbdorwBBCMbCz+Y4beHk4IdsR8xa8dNWhEoG1vHDHrF0/bGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/8/2022 3:21 PM, Tianyu Lan wrote:
> On 12/7/2022 10:13 PM, Gupta, Pankaj wrote:
>>> +#endif
>>> +}
>>> +
>>>   static __always_inline void native_irq_disable(void)
>>>   {
>>>       asm volatile("cli": : :"memory");
>>> @@ -43,6 +59,9 @@ static __always_inline void native_irq_disable(void)
>>>   static __always_inline void native_irq_enable(void)
>>>   {
>>>       asm volatile("sti": : :"memory");
>>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>>> +    check_hv_pending(NULL);
>>
>> Just trying to understand when regs will be NULL?
> 
> check_hv_pending() will be divided into two functions.
> 
> The one handles #hv event in the #HV exception code path.
> The other one handles pending irq event in the irq re-enable
> code path。 In this version, the "regs = NULL" for check_hv_pending()
> is used in the irq re-enable code path.

Got it.

Thanks,
Pankaj

