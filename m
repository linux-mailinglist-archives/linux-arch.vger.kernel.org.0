Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87586A6B74
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 12:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCALMU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 06:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCALMT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 06:12:19 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE5018B2B;
        Wed,  1 Mar 2023 03:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWatQxGVcFTPTeLP5oivEMKtMwbvFS0unh6Ak8t3DnFOI+fti+1bYp5OWBApb56Ai/N26m6RgoyoiiWL84RUrjbetpJJCzakzH3LK5NuHdSpGNIxIimOkbxX8LDcdRLD4SuMvfl1swxfm4Zl9TLRVcS5GKRcsH2jAF2j4GvfGUFaJ88s/A9Xts/qJYuQOFNKgwkYOEzNN2V8Xid0CN64f6Icj2I03hztK1EyzVQYofFPynbo4AJuFWpouqBDT5IHBEE2hYhHfNB7e3kxsZN8bD9TcDs/SQJGeFSJJVUe7Y84y3NNVA6b4intR/qwf+2wfGdk5EnwgCqfI7/W7lAb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55OybL9vqp1n/WkXr1U+Um0rHbLtebXEuGnLRWuACZU=;
 b=Bnr6Levj8+6WcCo8ap90kLESre5C/epmaL/ntT0hIxbM3wz3wnyhIiJheOteHZRnDsnY6qhl6JRXraMh8Hf1tCdaD++04eC06ikG0zIX9ffUfpp9p5j5OpQEoloxnpQnz9Qjk3eKThkPFSaWpOZywogHlJQpEUigvfrj0IMUJg709s5g0MGqfrfboOGUp90g9noHX/EMlmvta/k5f5Obstbwoao4pwyMllfeDLgBqYPvB34tPpImSS1Z9dLcBr+ELSxdF/YAzJp/ahmZoW/QHUU4kZ4kJkPmN5h+CImOSBYZoeIv0qe20OP0jdQELEqveG1soVt8qSb6p9Q6YYmByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55OybL9vqp1n/WkXr1U+Um0rHbLtebXEuGnLRWuACZU=;
 b=yXfd4yfe+Oqpgwj0OPKFYeHdfQe57C+XeAgNc2vahJTCcLjRQJ05608FJLGya1MR8dXUZTI3IXCNKRmWCQHpwy4ReNAw7Ak9Txt5XNTYwPJ8b9g5OFWoN3WU+8OPfGFbrGgQL1ipbHkjaJ2K2fHIl4ufR+SaiM2SGiHAbvso478=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 11:12:12 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf%3]) with mapi id 15.20.6134.025; Wed, 1 Mar 2023
 11:12:11 +0000
Message-ID: <e3c53388-f332-5b52-c724-a42d8ea624a7@amd.com>
Date:   Wed, 1 Mar 2023 12:11:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 13/16] x86/sev: Add Check of #HV event in path
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
 <20230122024607.788454-14-ltykernel@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230122024607.788454-14-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: bd344748-59f6-4966-4923-08db1a45cdff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/+o6Mj2hvdF7qsONDiHLYoq0PHcKE3QGU/ZIEvyZxaLiS/0dI4SPHsuJinz/O8Zoew7VpuboDszvpdmbmncLYr/8tmTSF8cS8wcvR/VNgLyUHWMwqlTX6aazfYUo6/MYxnhyIrhR3t38ezpJIVAAhMkywb9g4TGlPszDtfjM8skDWjDG+X2kUQ8WMS8b5Lj5jAbsO7n8H00HT2lO0I3CsP0Q664ewRWKT5euK5oIifP3hthrITAQY2lUKjOhs4OBVcGOu8YKq0SQf0rZ8bzYt9M7faTOf6uFNb+/0oU/HhHYX5c3BoCZ6sIxtBu7fUOeq+YKeAqgB7eQTKh+eHMc9O2aVcGdheZepuKCALskgzk9KcTQV7ok5w9MHylT691p16rP6jdyMXXY5uG2tV7H2p2qxRJ+bsoCSz2HvadeqL5hHzy2r73vluyghqfw0MAVxxVUsYoMICl4UKaAGsWyfqAzn/lDGYNb0sudgmRAOhPaON5qsiKbBBNas/muFyzRHZGb6xIiRExcajO0bhD9Sg/18OuuqsQSxZO+VKTOv/2911as5itw/oQev77+pp4ttZ8rCZZcvjgwHbRd6Mx5Hb6dMsW5wvqT0iF01U1tU3Wdp83vIMO5NJdQWL+vlu7aPIGwhP+i23WgXls4EpmVI/1X47+p/PIrCmdVTJEZ6M9oTNPdTa6fTnPQy1aw0uOD97R/X1DZDZJTEyi3eIPJB8HXwo7VnvMNtzqajvYCaARDREh5ezNgIITXOGzo4oq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199018)(921005)(86362001)(31696002)(38100700002)(8676002)(5660300002)(36756003)(7406005)(7416002)(2906002)(66946007)(8936002)(66556008)(4326008)(66476007)(41300700001)(45080400002)(2616005)(53546011)(186003)(26005)(6506007)(83380400001)(6512007)(6666004)(478600001)(316002)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1KaDhRc0VaNHBWc2FOUGxpV2I1dzVudU1KR2xQSDJ0Q3hkUGpCdHMvbWZB?=
 =?utf-8?B?SjZBMkRheUlXVVdXZWJ3WCtwTjFZdjZscTZsdVhsemJNTi9kUHNhSFFyZkpW?=
 =?utf-8?B?R2dqZGRrY3E0QiswMXFBQlhkUUlpTU5UMDFsVmRUc1R2TUlvRjl3TEc4R2Ja?=
 =?utf-8?B?aE9xWGdNNnpybzMzU2RkNWE2dndSVmgrWEFOVlZ6MFNhZTNNTVhjbG9yNm9a?=
 =?utf-8?B?YUltOUJtWVdOSW4vMFJUQzE1aWZjMzZYWFhPQlgwVmxjV2x1T2p0S0VNa21Z?=
 =?utf-8?B?TWlWYnl6dWtldy9zbityMEpZcnk3MDlwZEZGeng5aldSM3ZSdVB0Q0FYWTl5?=
 =?utf-8?B?bXMwaDlJSGpFWEFmc3l2U3hjcXFHVllOWllBRk9hcWkyNVVJb1hZUU41SHVD?=
 =?utf-8?B?M1dEblBYckFET3lLd2JhMlk4VkdzZHJKcFU1aFdiQzNjMW9udkpaOE5NOXV1?=
 =?utf-8?B?WUQ1SWR5VHlVcG5hRVNsRzBJVVRjT2hoLzVjM0FPQzBFR05PTXp1U3BRWWZv?=
 =?utf-8?B?WkRmY2VURFNRbldiRVhZTVBjaGdBaWh0V20zT01nTHAyWmVOelFpcmxFTjE5?=
 =?utf-8?B?T1RMQXJLNENOUUhubVhhOERtQ09YQmpBWWRBM1dQWEltSG00YVlqa0gvYlox?=
 =?utf-8?B?eUNnSHNtcFhEdFBBakM4R0RWVFNsWmxRSGVZSk8weGlCejZjOUNCSks0OXdI?=
 =?utf-8?B?RGFJUXVicTZBVm9mdUYrbUZlQ2p4b3Q2QWViNXNNSTQ2NWU0Q21vYmFIZVJ5?=
 =?utf-8?B?SVJUdmhnOE9xaVNXZ3JQTXNDUDVXbmQ0NG0vQ3htQ3hlcktESlFZZjZXQlZM?=
 =?utf-8?B?QXh4aTZnM2Ryd0h2RXRFaXcyNEtQWTdBZjU5TjlQcDYwTEY4ZS9ZOWVpTnBL?=
 =?utf-8?B?NlBqbGVFSTQ3Z1Vjc2JudzFYYUJBSlZob1JlaUxlU2MrNEYrRzhoNWJ1K29u?=
 =?utf-8?B?aitmdm9aNUI4Mk5YaEdpeVp2cnpDNWhoUHBlRm00bHpHaWthTVFoVDFsZXp6?=
 =?utf-8?B?U3NRcGdTdGNkek5PODM2TTRpVDdsNERidlg1eG00emYyK01qa0lXK2NzQUo0?=
 =?utf-8?B?dTdmUmVNdjNkVnVlU1M3R2o3MzBEVG82MUZKRkFXRXRyaFBDWmZ3ZXpYU1hR?=
 =?utf-8?B?S3BQOHQrWTZ1dTlpS0FOTWRtbkZYRi9UNXBYbTVNeVBGUEV3S092dGQrNHRC?=
 =?utf-8?B?WlltUmhmd3I1SUZiUWdiL3BIcHdQRVh0bTNtejI4bUZncjVhNnFFSkt0RWsz?=
 =?utf-8?B?aVVCWE1JTWxiVWFQb1R6aVpwMVArSURHL3NaMit4VVl3cTRvYUVRK09NSm1i?=
 =?utf-8?B?L2NSOFJjTlRlT2l5MXhtMm5UTUVsM0ZsbURlZDNNWUJUSHZiMkg5M3Rhc2lY?=
 =?utf-8?B?alRHc1hvSFAvMHhkL3k1ZmFDV0pqQ3ZCR3lnaUtQbTFnSjdNWC93bTBNd0Rl?=
 =?utf-8?B?MGsxanZqNnhrdDRpM3lrYlpuSVdWTXBzSitIV09BSGUvZUlFQnRoSUZ5emcz?=
 =?utf-8?B?STg4ZnlrRFcwMVc2UG1oREdBRjNmY1JmSlgySitXYjAvRmJ4ZkVRczhlOUow?=
 =?utf-8?B?OUVEcGc3NFlOb00wRDFpVjlsakxuMkJCU3U4TVZvbm1CWW5GQWxGM2xZM2VD?=
 =?utf-8?B?OVZ6R29UaUcwaTU0ZUgvL3NXQnpKR0tkTEZiVjBnU05oc3gzVzE5cGlPZlUv?=
 =?utf-8?B?YzhNRVdMQ2tQT3k3YWxTL0lpTTFnVkhidXpIWjRSRmZhT2tWTlA3QkJTc212?=
 =?utf-8?B?YWMxUG1aems3eDYzTEtBSTJyYkNqcmhyN09TcnRNRHNzUmZXdWRZSjFqTFEx?=
 =?utf-8?B?aGZYMkZYazVJR2VTdVMxa3FqWTZhSVdtSjF1c3FYL3lKa285NmRwd1o3NGdB?=
 =?utf-8?B?QTB5RjN4RkdZQTFBQ2lpQzZTNzJIWGtTcG5qSkFjNWVjN2ROeDRvY2ZBQWg5?=
 =?utf-8?B?NHdjSVl1VEs0bFBFMjRyeUVEYkh3L2NxM0M4eml4NGFvWW4wVG56SlRBdzZp?=
 =?utf-8?B?YWswRk82NGh0bld5ZHNiaml0YVhNQjhxZUYwakc3Si9aT2txMk1XWDMyVXJ2?=
 =?utf-8?B?N0F5TFkxSXRMYmh6UEE3RXJhSDJRTWE4eHA1Z2V3R3liTVpuSHN0ZjNMMDlZ?=
 =?utf-8?Q?qf8xKo0JYzh4ZYXlSNsjLCHfi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd344748-59f6-4966-4923-08db1a45cdff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 11:12:11.7307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Szf03JdYYiSP5oXU1GAYY1lxpGHgibA7co6G6kTL4Znbw7aWS790nhwuCM5jizbi7U/ORZCt9y3P6n9LGedbEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
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
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Add check_hv_pending() and check_hv_pending_after_irq() to
> check queued #HV event when irq is disabled.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/entry/entry_64.S       | 18 +++++++++++++++
>   arch/x86/include/asm/irqflags.h | 10 +++++++++
>   arch/x86/kernel/sev.c           | 39 +++++++++++++++++++++++++++++++++
>   3 files changed, 67 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 6baec7653f19..aec8dc4443d1 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1064,6 +1064,15 @@ SYM_CODE_END(paranoid_entry)
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
> @@ -1188,6 +1197,15 @@ SYM_CODE_START(error_entry)
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
> index 7793e52d6237..fe46e59168dd 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -14,6 +14,10 @@
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
> @@ -43,12 +47,18 @@ static __always_inline void native_irq_disable(void)
>   static __always_inline void native_irq_enable(void)
>   {
>   	asm volatile("sti": : :"memory");
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	check_hv_pending_irq_enable();
> +#endif
>   }
>   
>   static inline __cpuidle void native_safe_halt(void)
>   {
>   	mds_idle_clear_cpu_buffers();
>   	asm volatile("sti; hlt": : :"memory");
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	check_hv_pending_irq_enable();
> +#endif
>   }
>   
>   static inline __cpuidle void native_halt(void)
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index a8862a2eff67..fe5e5e41433d 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -179,6 +179,45 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
>   	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
>   }
>   
> +static void do_exc_hv(struct pt_regs *regs)
> +{
> +	/* Handle #HV exception. */
> +}
> +
> +void check_hv_pending(struct pt_regs *regs)
> +{
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return;
> +
> +	if ((regs->flags & X86_EFLAGS_IF) == 0)
> +		return;

Will this return and prevent guest from executing NMI's
while irqs are disabled?

Thanks,
Pankaj

> +
> +	do_exc_hv(regs);
> +}
> +
> +void check_hv_pending_irq_enable(void)
> +{
> +	unsigned long flags;
> +	struct pt_regs regs;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> +		return;
> +
> +	memset(&regs, 0, sizeof(struct pt_regs));
> +	asm volatile("movl %%cs, %%eax;" : "=a" (regs.cs));
> +	asm volatile("movl %%ss, %%eax;" : "=a" (regs.ss));
> +	regs.orig_ax = 0xffffffff;
> +	regs.flags = native_save_fl();
> +
> +	/*
> +	 * Disable irq when handle pending #HV events after
> +	 * re-enabling irq.
> +	 */
> +	asm volatile("cli" : : : "memory");
> +	do_exc_hv(&regs);
> +	asm volatile("sti" : : : "memory");
> +}
> +
>   void noinstr __sev_es_ist_exit(void)
>   {
>   	unsigned long ist;

