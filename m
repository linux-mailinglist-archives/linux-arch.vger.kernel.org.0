Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F326E6689
	for <lists+linux-arch@lfdr.de>; Tue, 18 Apr 2023 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjDROBc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Apr 2023 10:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDROBb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Apr 2023 10:01:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F057C10244;
        Tue, 18 Apr 2023 07:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTMSNSAW8s+0wDqxyEy/v7fPTXAi2cKsDwMws2lWqzrKIBqOgvBTf+kFhUqOvPGEgoAi2hSaAZTuVbgYdgkmAh+6E1tSUnEfaQsoIf48KU7ecX5gtssO7Y39GXxGs9NqXstnkip/xMWqJPf992Z5m9ttrZYpqPXkzMWFfuS0CcU8Jtb5Cwx1gbzIggD6/sFI9MheHEHzp/zFNXzmBaz8Ck/9gr3GpZDf7cjw+exUSSNknDfn9zDTzJNN3jGQp69247/5pwGbi8yYZgL0JQBwddzArr9FQH/RJ9827XembZLZ+rP1kwM1v52F/Cg8aFTGQ6WE/V8d6KP5anW0qvmO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkTgp8eopxx5rF3jXB0wRJ0NH+ZiOq8gkTmm6PADmsc=;
 b=c/pFyB8kVHG8yG3wFb6pLcgqHsxD7xQzz0HIuAGNYBPhiTwqIohNCOYYairaaoxNgKV/jAUIgf/bJytoVKjsYy3A+uZgyFMSAOrH43c/2IbcdmAWgLEuAZuOUuDPcENRrYjoAAESqMefVabbyk5E14SB/sOVp/4FeSMI16aKf/nechSF8bghyCN+s3soVSGycr08bynOfMpqt5oCzE659QmZGWzErmVWkhpG0j8QBHHR5gPZZ9n2e8rAnX+Y7FueFb7xQGlh1OJg/YJrRbJ1VBdQqdomyzw4pvULzJfUCleS1PeNYZ1IT4E6adPFXjsi1c/evisRx9VgaKoxNqummg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkTgp8eopxx5rF3jXB0wRJ0NH+ZiOq8gkTmm6PADmsc=;
 b=lYxjaPwCqsAQ9PUcyhi8x+IbcQq5SoDDK68qIgRQbA9wQgJ6WHgliX+ZP+ogi+zp95RXGII5ELLKTDV+iQ3Iye3d7MhD9L/5IF/UkuHRi9knBMJDAUZKs3kPYRoCcKzqYfVZAKE22ehhWBM3/D6P4r7GQkvMpdmEQK6jmFtkBjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2815.namprd12.prod.outlook.com (2603:10b6:805:78::24)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 18 Apr
 2023 14:01:27 +0000
Received: from SN6PR12MB2815.namprd12.prod.outlook.com
 ([fe80::77ff:cc9b:4e6d:55fe]) by SN6PR12MB2815.namprd12.prod.outlook.com
 ([fe80::77ff:cc9b:4e6d:55fe%4]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 14:01:27 +0000
Message-ID: <97f2ddbd-8495-9479-a11c-054296602027@amd.com>
Date:   Tue, 18 Apr 2023 16:01:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V4 13/17] x86/sev: Add Check of #HV event in path
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
        michael.roth@amd.com, thomas.lendacky@amd.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-14-ltykernel@gmail.com>
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230403174406.4180472-14-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To SN6PR12MB2815.namprd12.prod.outlook.com
 (2603:10b6:805:78::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a188ac-4741-463d-d78c-08db4015672a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5SHU7uISJbNaQYtpY9MsGCDMMuHr3mo58yrV5sNviC1mxGQ/P9enZj5mCPKoqCDNW9/YDijDpaogifomqsSpV7/+63AAg7wus2kvog+8KOcFuv6rMul6kSvbNNyNO++LApbkjRhtBQJl5uq0emwjAcFnOnJc+/KcFl4G8NHd5cfB16PLG6HhLXGcICMMvO0oWzhrzbBaehijEfqmT/m1ul3Gpwv9RcW+Areb0cvNeXrzvrisIgVFxpKcNoMWyy60Vhmb6mCIuC2jK6gtQ5YXU7IOmV/3zx2IT5U8qCKyaj+JMsaBJuMnr940iGv+LQPzzju/Ufkt1dDjA+RyT32FfFGqOLlYrLY7h8wFCHellyTGXzB9ysfBXT7MtmHrp+Alcz4sBgdzlNv4CK5EDA4iAj1BtnAgXoqOwTE9lgWWjV3uuYu+Rn1gxAOaqTtK5V+HASepJzjHp22vkNscRQKvDOIRap+mIfCgDmyyCGydkdjKaiVnXV3Di1Yg2X40Wx85xtU/029S+JbrcVqq60gCkp3IhRZYy5iRsjkqy04Qq/rEg49I7QyGidVXOs4tUrizyQJOVuTcB7rF3f8Qnw3CKPxvdjHrcg0JeTWXYt4Saj2WFv5pfIjkFcwyvwQ6XoXK67bW+NFRAJ9LzFe04Gk8ETOJHUyn//rUwtxfdG1X8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2815.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(2616005)(7416002)(36756003)(6666004)(6486002)(86362001)(921005)(31686004)(7406005)(5660300002)(83380400001)(2906002)(6512007)(6506007)(186003)(38100700002)(45080400002)(26005)(478600001)(31696002)(4326008)(66556008)(66946007)(66476007)(8936002)(316002)(41300700001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekowSlgrQVRzc0dNaVhOOXJBZCtZTUZvOFNYV3p2TzQyUU1LcDc4bENiNks5?=
 =?utf-8?B?OFhtbFpuSXI5cXJIdytReVRzTE5Zbk1YUUZ5ZFczSDJwc3hvdVNIYjlHLzBR?=
 =?utf-8?B?YjVzYUJDOGhRTFR4cmQrblVLS0xSRCtOQVhSMTJqdVlMenB5V284ZUIvSWtq?=
 =?utf-8?B?TXhMb1MxdkxjdWtCcFVJUDZDbUh6OE5UUFZWbXdoNHNpVzB0RGJHcTRyTisy?=
 =?utf-8?B?d2xjOVRUMVZ4MFhUMjZoenJFVTJielpyMWM0S1ZEYUxLMzEyWndYMVh1SHF0?=
 =?utf-8?B?Ym1MYW1PUTlTR25oVVFCSjBZN2kzUEJIUXJKQWFmRWV0ZkxocGZOVWpSazQ0?=
 =?utf-8?B?UUNEM0wwRzZsWjRscHV2eHdnbUxqVzRDWUh4UTIxYkhRcjRmY2VQbjJUeHBz?=
 =?utf-8?B?QlpPVmZRVG5rc29FRWVOdHU4TFA2K3NxRVprbzI2bThnVS9zNXUrRE0vQS8x?=
 =?utf-8?B?bkhFZTBQYlJ3eSs1UHFjaWxXMnRWQTJGa2pYcUpjV3pKSjY2MmlwVEl4Qk40?=
 =?utf-8?B?WVN1K3B2SmF3TlpxOWtzaUhWa1l1VTAySWxmQTc0eGpNcUVsMFV3dFQrMlUz?=
 =?utf-8?B?UVpSWDJWTThVbklBV3Z4c1JRcXRSWXBNMXdXbHRDZkZWQ2FpeUZCcHVmSXJn?=
 =?utf-8?B?ODNRRjJHR2ZKeTQ1U3NudlMzdWlENWZCV3Z3bU5Xa3NHSzYvVkw4N1hjVDAz?=
 =?utf-8?B?YXpBT3dJOXM3NVlDTWp3Vm02TnlXc0IxOTM4alNhMmtIZlROWHRUUGVRTTFn?=
 =?utf-8?B?Nlp5ZnhtRG9rV3dvUEl6SHFrNW9DU2dMbUFycFBDNW5Ra2hXVWl2bjk0ZlNr?=
 =?utf-8?B?aXF0cTlrMlNSUkRvSE9IL3daaUtMeENvemgyUk1FL1dncDd6MytTTjdMWTdu?=
 =?utf-8?B?WEd2Nm9ONmJSRGdnUmRSN3BWblBUU0hURVJpeEdhTUo2OXd0eE1FYzFLQVdC?=
 =?utf-8?B?TU9wNUdaQVYyOS9xdnZJakhQcmZLUzluTWRsNmVMaVJVdkd2dXRmTUNkWTBp?=
 =?utf-8?B?QVBsMjROUk5ZbHdkcTlZbGRmLzB4QmpxQ1JHMTdhTlFrVTkvc2l0WGpzRTd3?=
 =?utf-8?B?NW8wWGNPODBaRlVaU1o4MUlTU1ZJbzUxT0ZZM3B0cTFWNEJLaHBiODdCK0hF?=
 =?utf-8?B?M2lkdVFTOUNTZ05jWXRFRFhSNTcvRzJST2lkNGJiTDlxcHN5eVlQUWJoNCtt?=
 =?utf-8?B?bXNiVnBDbENuTnhlQkt0U0lvTUxZeDNyWnU0NU50WUM0VVFOU0U4L2o3MGFt?=
 =?utf-8?B?OWhCTjFHZXhWbGwxcnIwMlNUWDk3b3F5TGFGOCs2c2dCbyt5OExoaFdONTJ3?=
 =?utf-8?B?R1Q3K2tYY0xaN29VZExJRnBlUy9KOGFaUkRyVGtyQ29RZnYwSGt6OTJsSWVT?=
 =?utf-8?B?dXJwd1JvWm1vaUhpVkJsV05vK3VsVDlpbHNWUUV2LzlERkN0aUdZVG9wUUhN?=
 =?utf-8?B?S2VudVgwL3hRZnJVSWJpWEJrN0pOYXk5RnJvQ0JYZUN5UDE3QXlZbW1MZlV6?=
 =?utf-8?B?TkViTUhlcUV4V3cvQ1FnVDY5bkJBdjFNdHpaZXRrd01yNWdhWFRUbEozRS95?=
 =?utf-8?B?bEhTYmxBNXRibFNqaW9YK1FkYVFoZW1jbzg3bUZWNDV2UWg1R1dCK05iMUk0?=
 =?utf-8?B?ekV6UGV0WlBOL25EakZHUVFsVmFzSzczTUF1NHVNVGVqUTZLb3ZYMmlnVzh6?=
 =?utf-8?B?c1FMUW4rd1VDNXdjVmZtemJsQ1ZFZDAyRXZocGdtRkM1c29ESzRYbExiUG9r?=
 =?utf-8?B?WW1jYjR6cEVyUjJHZWJtWTRzVXlaUGVZOVRVV1dDOXA3Umw3dW51TUY2TW4r?=
 =?utf-8?B?bDRlT1dMRDgxYnJkVVhSd1U4OFAvdG5iVmVOdGJ5a3psVXpWVW1OZFNCWEJP?=
 =?utf-8?B?TmN3NXZEdzFBbVRyWjBhL2pwalQrODB0SmR4SHJkenZ5b3ZieHNZMVB3YW50?=
 =?utf-8?B?dFh5L1FpSVZ1WmZ4Tjh2QS83RjFpcFNSNGtJWU53S1VpYVo5K21NSXNqbzNK?=
 =?utf-8?B?MzVxbGZaTVZucEhYSnIybXhSTEt0MEE5NmFkQzh0dkdjU1lOSDhPTGNRY21a?=
 =?utf-8?B?eC9JbmxxSE12bWFlclMvbVJNaUhiR2YrajJOR244d1RDUlhSeW5HSVhwOGZn?=
 =?utf-8?Q?qPWm6uPioojIPXk+gkKDtkowT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a188ac-4741-463d-d78c-08db4015672a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2815.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 14:01:27.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0y/Gx0rmoLMZJp17TT8wRvy47oYc84ii03OSbbbDrvxCo9sh/PEzjR3PFMhMmFNDqD9oLNFQEECdfNVDHlDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tianyu,


> Add check_hv_pending() and check_hv_pending_after_irq() to
> check queued #HV event when irq is disabled.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/entry/entry_64.S       | 18 ++++++++++++++++
>   arch/x86/include/asm/irqflags.h | 11 ++++++++++
>   arch/x86/kernel/sev.c           | 38 +++++++++++++++++++++++++++++++++
>   3 files changed, 67 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index d877774c3141..efa56dfde19e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1073,6 +1073,15 @@ SYM_CODE_END(paranoid_entry)
>    * R15 - old SPEC_CTRL
>    */
>   SYM_CODE_START_LOCAL(paranoid_exit)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * If a #HV was delivered during execution and interrupts were
> +	 * disabled, then check if it can be handled before the iret
> +	 * (which may re-enable interrupts).
> +	 */
> +	mov     %rsp, %rdi
> +	call    check_hv_pending
> +#endif
>   	UNWIND_HINT_REGS
>   
>   	/*
> @@ -1197,6 +1206,15 @@ SYM_CODE_START(error_entry)
>   SYM_CODE_END(error_entry)
>   
>   SYM_CODE_START_LOCAL(error_return)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * If a #HV was delivered during execution and interrupts were
> +	 * disabled, then check if it can be handled before the iret
> +	 * (which may re-enable interrupts).
> +	 */
> +	mov     %rsp, %rdi
> +	call    check_hv_pending
> +#endif
>   	UNWIND_HINT_REGS
>   	DEBUG_ENTRY_ASSERT_IRQS_OFF
>   	testb	$3, CS(%rsp)
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 8c5ae649d2df..8368e3fe2d36 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -11,6 +11,10 @@
>   /*
>    * Interrupt control:
>    */
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +void check_hv_pending(struct pt_regs *regs);
> +void check_hv_pending_irq_enable(void);
> +#endif
>   
>   /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
>   extern inline unsigned long native_save_fl(void);
> @@ -40,12 +44,19 @@ static __always_inline void native_irq_disable(void)
>   static __always_inline void native_irq_enable(void)
>   {
>   	asm volatile("sti": : :"memory");
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	check_hv_pending_irq_enable();
> +#endif
>   }
>   
>   static __always_inline void native_safe_halt(void)
>   {
>   	mds_idle_clear_cpu_buffers();
>   	asm volatile("sti; hlt": : :"memory");

I was able to boot the Linux guest on KVM SNP host with below [1]
change above your patch series.

Thanks,
Pankaj

[1]
diff --git a/arch/x86/include/asm/irqflags.h 
b/arch/x86/include/asm/irqflags.h
index 8368e3fe2d36..df993bec56c4 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -52,11 +52,13 @@ static __always_inline void native_irq_enable(void)
  static __always_inline void native_safe_halt(void)
  {
         mds_idle_clear_cpu_buffers();
-       asm volatile("sti; hlt": : :"memory");
+       asm volatile("sti": : :"memory");

  #ifdef CONFIG_AMD_MEM_ENCRYPT
         check_hv_pending_irq_enable();
  #endif
+       asm volatile("hlt": : :"memory");
  }
