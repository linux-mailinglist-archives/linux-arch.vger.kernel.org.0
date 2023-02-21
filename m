Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25F69E509
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjBUQqu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 11:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjBUQop (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 11:44:45 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1309D298C5;
        Tue, 21 Feb 2023 08:44:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9wOhqVKXZQF1yTSPCplFlEuC8m78YzNmEcb/fFPjl39LD+ZUMV0Rlmp2cNBP3dUcsgqu1Gkzi98EfjD9DB1bWH3Xo6/ukWLJSmf4Umo43xBSKFn8XYJtzdwOdaM+iyh7InR2IWzvdn34G2JLXygAyUqJ598wX3/b4DThBxaH/yELaddqZbBMqJMOIMrJLaINzX0n71y92KwVtY0Q7IhE8YMV+wka5zuPTPVf1wemtNyLvIzbTZN+fTO+81rZJ/8PCePaC7g7fWo5jUw9Ksuv9tzb12VVGqFXlW3lXJKlZMRKX6P8lWelvlvzmwAdpyUIZlZbU5W/pgJ+7WV8wL7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Crcgps/C9d28AcOsqC+mzjIQ0JHc4HnrpY+WTKcSjQA=;
 b=i+dWWLktJuuv1KgTJq6dQKTGrmhXiqO+fVaSMXwKMpOTTQu25Hqr7ZMQ912+EYMdcBXuXdRW9Icf4Mr6mqxE5gSl3i/jmz4VdlJgTIVuRP/SJ4mRwGY4+/zeNSRo3lV3IJZCd3r9RHuRm0WBHRR+dYxwCuaNvxFnheaB767pOeVHmwQxvcjGl2fZmW6ZT6/OSyMO9URGhceYC1URDHCZIusjp0ymV9jsbcEjfysDMPGA+ZOHu2Ab1PdADIp7koQZP/eYyLrkU2dlvWUo7aC2SE0OgdEMF5fGh2OiPgYUMdEDCuhcOmcVuxJq6HievFEVwqrSfmhYs+qIjfQ3Kxgo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crcgps/C9d28AcOsqC+mzjIQ0JHc4HnrpY+WTKcSjQA=;
 b=w9+tmO5CE/Fc1tUUz9Op8S+Ffdc2f0H2mtWWfzoFYGld4hD+i4B5h/05oEeUXnuNtO6DNAZG2zPvJFkzlfEisZVDfO8ip9nfk31C3tOvQP4buLSOKo6QID+w+uWhS0DUmjPEvZHooG/Qbl20HV1Hp8RvKHdA8azMAKfRk88OhJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Tue, 21 Feb 2023 16:44:28 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef%6]) with mapi id 15.20.6111.019; Tue, 21 Feb 2023
 16:44:28 +0000
Message-ID: <65f08b1e-ecae-7100-cdbe-79e07ade90e4@amd.com>
Date:   Tue, 21 Feb 2023 17:44:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 16/16] x86/sev: Fix interrupt exit code paths from
 #HV exception
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
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-17-ltykernel@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230122024607.788454-17-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: d266cb96-f9f0-48d1-aea1-08db142ae606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFJKZowtgwhdTkSPjtzbj2EDQTBacJx7qVgSEU/lDA8O+L3ikUuub1b66Xe4SyQDVv1N1fgDLkjCS9DgfuNR6MIMeSg4Pau1SNYhJmXhn+KiDx/Q74AKj92TLabSOV4UYsFaUfeJPdXmLnlYSOOan8E7KUYU2/kCms2RddgSSfBVbouIxKDFZiUh+0Lv6k5hA5dHtY/B5Re2KiVzmY9FDNiBpAXAth1UtpQpgkiNHBHOi5ViqAqPsLN4kWKuEWh/aBCmKkKtCGfd+GNdaU1CHx2St2WkeNN70MkzqKo2526H6msw7b4dWxVBjqboZVd+FK1d4PXPxaVNTyeXei2f2yr9elY5dFqGIlgJCiYKnVzH9XoAyf1Le+6+vE8RkXwdSRkbPmi7T4FkQ9CMiYh9MULcF5kl1dAzFG1OXHOGB5bzWiW6hcs+emxy94zsJgmzcrwLOIjdfNYhkt4hgalmRhwzLvJymE5P+bVv74ql/BKAqwC6Pp9WLfDS2uRQx1yom1bd3SWdGuBWULixl9EdLPLvchrtcWu3CNASUfOZ32kWpxuTe5Uz/I4zITFNj/mHHqzGkVbCmsffgnQR4DGuQeUOY/PR0Ym+ahtEX+eDAvOJhjPL+VNg6W8SrLtwETDyWh1jtd7dKihNQN1kueEme0365dlYyD1LS+qNewbABneGVuIdoQSeaOMeYwzx5DpXiwM1/+XRKLff/OCdHvTX7KAsq3CCEYTokxDAW6Im6/2VUtDag0abv8X7RNkIXmR1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199018)(478600001)(31696002)(38100700002)(86362001)(2906002)(921005)(316002)(41300700001)(7416002)(5660300002)(8936002)(7406005)(4326008)(66476007)(66946007)(8676002)(66556008)(2616005)(6666004)(6486002)(31686004)(6512007)(26005)(186003)(53546011)(6506007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZJVGpGREtsQTN3VVd1V2wzK3R2RjQ2VTZOQVU5ZVRTajNlbU1XQU5LeU9l?=
 =?utf-8?B?ZndaQkxMYWswM1pMSGJOSTE3RytVYjd0NHdQV2RUazNrU1A4MHFLM3NJNlox?=
 =?utf-8?B?Y25vZDg1Qkp1T3MvaXVUaU1JQTcveFBCTU9KT1h5R0F0V0RDMm5yaXZ0a0Fl?=
 =?utf-8?B?aUFJWTV5WEwzdGNpcFdEWXp1OERGakdSUWsrcFAvYjZxbVlwTWR4YWFsMXV6?=
 =?utf-8?B?UkthS1YrU25FZ0p3cWVneTB4TWtudENiVE5wckdlZGJzRm9yWXlYdmtVNmNQ?=
 =?utf-8?B?YnJXNmpuam5LekVxZkVkU2ZodFdmRHlOZ2FLSE9GOVl1czBhRHI5Z1lNR2VV?=
 =?utf-8?B?MjNZakJtQjA2UTVSenkwTFg2bGszTFpxUzVlVnJud05RenlUREkzMnlrUlNk?=
 =?utf-8?B?WWhROW4rcEpuQXNKZ2dBOTg2WE1TNnJBeml5UmozUU42aWpPd1pvb2d4eVNn?=
 =?utf-8?B?YlJ5TTNhWVcxRjZZVitLc1ZFNldVQTFYS1IxMWpvN2IvWUdCMjZzNVhsMnpa?=
 =?utf-8?B?bFhtZ1ZvWjFML1Y3UndMK1Z5QW0xMVZHd3oySjZXWGVYNU1TZmRic0VZTUJT?=
 =?utf-8?B?QUVzLytHSzRqQVIrUlBER2ExdmRKZk9SeWEyNzRKaUI4YTlsb2pDQ25DNlV0?=
 =?utf-8?B?UEpxTEJRK1h3dkM4eFJuZGxJYkJzam5DNzdsRHladXI2TlV2cDQxSkk3NTlY?=
 =?utf-8?B?TlNHQ09vQkkvelRqOVZEa2VkdFh2QVB4RDV1aTUwdEpLL0ZSSE9XTVhXUmVl?=
 =?utf-8?B?L01maTRPOHkzL1NiL3FwSWhoNDJRMXhUTE5mcE1HK1dhc2R4TXVqMGR2Mkhp?=
 =?utf-8?B?MVYrdk9adW1KekpFeEJOZElZQ0NodjBKem02UUloWFNYWHkyKzhrbEppRENh?=
 =?utf-8?B?YXJQTHErRnJoL0xzV1FVMHgzR3FRYWd1WkdQLzNTc3BKMWhuUmp3VFRGVzZv?=
 =?utf-8?B?MTJITkwrUWZ6c1JrZHdIZ2dIVDhMRXB4ZDZPOEpEN3BtYUhubDlEdWdQVStq?=
 =?utf-8?B?SEdtWXE0TC9VbjRpSzhBbStMcVQrdDBKVmJRcXQvSnpZalVKbnNIZXcxMGNP?=
 =?utf-8?B?OG1rWHU5anNsVkZBOENmWitjcFZrNzAyUTd5MUptV3dDS2FZd0ZnSHNaVXpq?=
 =?utf-8?B?eERzZVBaOVNWUFZWQ3F1QUpBQzYrb0d2VzRDcVYvNit1OGFtMjNpdDV2Uklp?=
 =?utf-8?B?TGtXRDVoUDRlVVJiSG5tYXBSVmdsNzdDOUNQUEg4aEd6aFM3cDNJdUZROGdE?=
 =?utf-8?B?TnpYRHpROWJZbktnblRpb3BxdVlUK3A0MDNaUGZkcTNrMmE1allYbHNEeXdP?=
 =?utf-8?B?ak5sZEJpcGdYNFBZczYveFpUZjZZNjRWcHdoQllWV2NJNHJ0UCtiVTZOUThV?=
 =?utf-8?B?SzJCNk0wTFNPczdHVlA0MWV6enRoTXduZFNOWXNYLytsOEVodDhONEhtK2xN?=
 =?utf-8?B?YmtqblRIZEdIOFhmQWNNeGNoMVhIMS96djgwOUxQUHJLdDZwdzFTbi9jVlkx?=
 =?utf-8?B?cmo0YkFQY3BEQkRROWxTL21BYWREcDlrTUw5VFVtMDVnblR0ekhocmRuU0Rn?=
 =?utf-8?B?b2NXTFhIdGpTMlRzaUlIMzkrNzh6UUFEcTlCMXRsdmZhcnpkU1JEZXBlUzhz?=
 =?utf-8?B?YlpjNWdNUjgyeHhuS3ozYzVNSkxVN0kxS3pTNGsyR25iR1VQd21OVlFyWDRp?=
 =?utf-8?B?V01IZG5RR0pON0dNVlRHdU45eXJiRFdsNEVhWEhkbHluNDlIV1BkdU1UL1ZB?=
 =?utf-8?B?bVpKNVFYZEhyNmxNMjcvWS9yZGVlY3Rhd0xqNTBiaDZ4Vi9DYW02dWJLQWlz?=
 =?utf-8?B?bjRwQkxaRGVXN1VHZURuOW85Q2N4MDhvTzZyV2o4NHMvNnFLY3JMZmEyR01v?=
 =?utf-8?B?VVEzQ2oydFVMVjRrVUpsUXdOdjBXTnAzVWV0ekVmR0tHQ0pBa0pSckxHV0or?=
 =?utf-8?B?SVRSd2RjeXI1V2tGdmJQaE9SYy9yaFUvZkoxa1VvbmFPZWVIVWdheHU3a2Ny?=
 =?utf-8?B?VzFSSHprQitQOTZPeXlLMnRhV0x3Y21sL1hVY3p4V25BOTRqRGVRQTlXTmtr?=
 =?utf-8?B?QlRscThCd2lrY1JOZ0kzbUYrRkNEM3FHVUdxUnBtS1ZuSHQ0dmxhNEZBTW5t?=
 =?utf-8?Q?K3ZkKdA/TwPg9DKRBA2e8lqDr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d266cb96-f9f0-48d1-aea1-08db142ae606
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 16:44:28.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldnvs6vsdCV9GbSyS5RZjNKTT29RZICd71bnQ5b/h5FsDy0RgXfUZup8OOJJJsuABHR/yDzN98dnN4QVhu0pDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/22/2023 3:46 AM, Tianyu Lan wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Add checks in interrupt exit code paths in case of returns
> to user mode to check if currently executing the #HV handler
> then don't follow the irqentry_exit_to_user_mode path as
> that can potentially cause the #HV handler to be
> preempted and rescheduled on another CPU. Rescheduled #HV
> handler on another cpu will cause interrupts to be handled
> on a different cpu than the injected one, causing
> invalid EOIs and missed/lost guest interrupts and
> corresponding hangs and/or per-cpu IRQs handled on
> non-intended cpu.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>   arch/x86/include/asm/idtentry.h | 66 +++++++++++++++++++++++++++++++++
>   arch/x86/kernel/sev.c           | 30 +++++++++++++++
>   2 files changed, 96 insertions(+)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index 652fea10d377..45b47132be7c 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -13,6 +13,10 @@
>   
>   #include <asm/irq_stack.h>
>   
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state);
> +#endif
> +
>   /**
>    * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
>    *		      No error code pushed by hardware
> @@ -176,6 +180,7 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
>   #define DECLARE_IDTENTRY_IRQ(vector, func)				\
>   	DECLARE_IDTENTRY_ERRORCODE(vector, func)
>   
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>   /**
>    * DEFINE_IDTENTRY_IRQ - Emit code for device interrupt IDT entry points
>    * @func:	Function name of the entry point
> @@ -205,6 +210,26 @@ __visible noinstr void func(struct pt_regs *regs,			\
>   }									\
>   									\
>   static noinline void __##func(struct pt_regs *regs, u32 vector)
> +#else
> +
> +#define DEFINE_IDTENTRY_IRQ(func)					\
> +static void __##func(struct pt_regs *regs, u32 vector);		\
> +									\
> +__visible noinstr void func(struct pt_regs *regs,			\
> +			    unsigned long error_code)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +	u32 vector = (u32)(u8)error_code;				\
> +									\
> +	instrumentation_begin();					\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	run_irq_on_irqstack_cond(__##func, regs, vector);		\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static noinline void __##func(struct pt_regs *regs, u32 vector)
> +#endif
>   
>   /**
>    * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
> @@ -221,6 +246,7 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
>   #define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
>   	DECLARE_IDTENTRY(vector, func)
>   
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>   /**
>    * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
>    * @func:	Function name of the entry point
> @@ -245,6 +271,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
>   }									\
>   									\
>   static noinline void __##func(struct pt_regs *regs)
> +#else
> +
> +#define DEFINE_IDTENTRY_SYSVEC(func)					\
> +static void __##func(struct pt_regs *regs);				\
> +									\
> +__visible noinstr void func(struct pt_regs *regs)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	run_sysvec_on_irqstack_cond(__##func, regs);			\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static noinline void __##func(struct pt_regs *regs)
> +#endif
> +
> +#ifndef CONFIG_AMD_MEM_ENCRYPT
>   
>   /**
>    * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
> @@ -274,6 +320,26 @@ __visible noinstr void func(struct pt_regs *regs)			\
>   }									\
>   									\
>   static __always_inline void __##func(struct pt_regs *regs)
> +#else
> +
> +#define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
> +static __always_inline void __##func(struct pt_regs *regs);		\
> +									\
> +__visible noinstr void func(struct pt_regs *regs)			\
> +{									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
> +									\
> +	instrumentation_begin();					\
> +	__irq_enter_raw();						\
> +	kvm_set_cpu_l1tf_flush_l1d();					\
> +	__##func(regs);						\
> +	__irq_exit_raw();						\
> +	instrumentation_end();						\
> +	irqentry_exit_hv_cond(regs, state);				\
> +}									\
> +									\
> +static __always_inline void __##func(struct pt_regs *regs)
> +#endif
>   
>   /**
>    * DECLARE_IDTENTRY_XENCB - Declare functions for XEN HV callback entry point
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index b1a98c2a52f8..23f15e95838b 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -147,6 +147,10 @@ struct sev_hv_doorbell_page {
>   
>   struct sev_snp_runtime_data {
>   	struct sev_hv_doorbell_page hv_doorbell_page;
> +	/*
> +	 * Indication that we are currently handling #HV events.
> +	 */
> +	bool hv_handling_events;
>   };
>   
>   static DEFINE_PER_CPU(struct sev_snp_runtime_data*, snp_runtime_data);
> @@ -200,6 +204,8 @@ static void do_exc_hv(struct pt_regs *regs)
>   	union hv_pending_events pending_events;
>   	u8 vector;
>   
> +	this_cpu_read(snp_runtime_data)->hv_handling_events = true;
> +
>   	while (sev_hv_pending()) {
>   		pending_events.events = xchg(
>   			&sev_snp_current_doorbell_page()->pending_events.events,
> @@ -234,6 +240,8 @@ static void do_exc_hv(struct pt_regs *regs)
>   			common_interrupt(regs, pending_events.vector);
>   		}
>   	}
> +
> +	this_cpu_read(snp_runtime_data)->hv_handling_events = false;
>   }
>   
>   static __always_inline bool on_vc_stack(struct pt_regs *regs)
> @@ -2529,3 +2537,25 @@ static int __init snp_init_platform_device(void)
>   	return 0;
>   }
>   device_initcall(snp_init_platform_device);
> +
> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state)
> +{

This code path is being called even for the guest without SNP. Ran
a SEV guest and guest crashed in this code path. Checking & returning
made guest (non SNP) to boot with some call traces. But this branch 
needs to be avoided for non-SNP guests and host as well.

Thanks,
Pankaj

+++ b/arch/x86/kernel/sev.c
@@ -2540,6 +2540,9 @@ device_initcall(snp_init_platform_device);

  noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, 
irqentry_state_t state)
  {
+
+       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+                               return;

> +	/*
> +	 * Check whether this returns to user mode, if so and if
> +	 * we are currently executing the #HV handler then we don't
> +	 * want to follow the irqentry_exit_to_user_mode path as
> +	 * that can potentially cause the #HV handler to be
> +	 * preempted and rescheduled on another CPU. Rescheduled #HV
> +	 * handler on another cpu will cause interrupts to be handled
> +	 * on a different cpu than the injected one, causing
> +	 * invalid EOIs and missed/lost guest interrupts and
> +	 * corresponding hangs and/or per-cpu IRQs handled on
> +	 * non-intended cpu.
> +	 */
> +	if (user_mode(regs) &&
> +	    this_cpu_read(snp_runtime_data)->hv_handling_events)
> +		return;
> +
> +	/* follow normal interrupt return/exit path */
> +	irqentry_exit(regs, state);
> +}

