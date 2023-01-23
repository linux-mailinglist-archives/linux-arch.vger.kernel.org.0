Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1418B677FC6
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 16:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjAWPac (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 10:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjAWPab (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 10:30:31 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016D0F1;
        Mon, 23 Jan 2023 07:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSWsek1/OnkVasuuhrFNlRoKIYzSY2xrJnYyzYF1907O1qYwI/UFDhztEHrmYo75YKzla/GNjazqL8tZBk9zi6I1BrRp/KE4gVllvPXPxyWhsZOyTBvprFoNoYDtcMIIoN01oIPZyFrrmSQ1jnF2hHZhmMeg3aq9gVeQ3AiBPqfiLuLeWk0OIn4A5Yan3fO7JPTUlF2NOlojH60kFkOBdqzxtb7fX5sXax9RhJGu1xLaZiU1KJGEbiFh7EHMo0FsIsKYXasg4u8yZQSkswE5LhUs6+/M0+QKNBuhvgQc7tfSxb8ABPCpMShKnSqN0d3+c+MSByNq1/F7dtTb3ReD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1avCbFlW5P6g+/+x+fpT4HfZw9TWPb938gDot2Txhw=;
 b=CMW1SgXSRxC4ItE+2xyZsQ/w6dx+0wYe2g3oPclbLXnK03AKkICdFh/SbPM/TeGqlwummz7UJ72TbdxKGOM0iZAZJHX/GUZMru+6nKA4qoJoWts7Zw6AGKPRYufOB/S3uRpW6fK4/pnbXG0qB3CRPJdO86vafptf3mdNMhKtKH9EIk6iOZjq+Yoz+vGtlQ01eGquIsxXJsKm3EYHZOARDKCnc1Bg9jzaiWfSvMYDOINFruedGbbokdLL6gLorYKZsK7MuE/Yvob4sDiM20IOUcfsL5y7X+FBGyimHyPYDBOrAGat6AFltG1TB+T4n01j914KcUgXgHqyA4eWS9keMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1avCbFlW5P6g+/+x+fpT4HfZw9TWPb938gDot2Txhw=;
 b=nD1CDTKs4VsadiXB76ZAS+n7D9uIe3PcYoRG3U/VXdUa/WjbseJg0vtYNQ6sepyV+uu8qkgw+jUhV170i9/Iv2IWgbRc4ADtBcw1rLIz/CxWKQ8Y8VO476ufRDWe6UpZHPoJW25LknccqN3ceHeOijNtyjuKQUnF+qBjdGC9xng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 15:30:26 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 15:30:26 +0000
Message-ID: <62ffd8b2-3d88-499e-ba13-1da26f664c6f@amd.com>
Date:   Mon, 23 Jan 2023 09:30:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH V3 10/16] x86/hyperv: Add smp support for sev-snp
 guest
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
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
References: <20230122024607.788454-1-ltykernel@gmail.com>
 <20230122024607.788454-11-ltykernel@gmail.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230122024607.788454-11-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:208:15e::38) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB5422:EE_
X-MS-Office365-Filtering-Correlation-Id: deff4c8b-250b-4b7c-86c0-08dafd56c03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFtc5HsgPzKy/GZRu+8vopxTEzIY2ki3W5XvDiK0GlIKqYPt/+Lwnr5hnU2HXESfPQQO10svOJGU+GdhLlMLXSrOkh4KRNBpFsHS62F62gPalboOU7rx/VXCJKNp/0tt5I0kBaWm85SO86Kbe8Yu+c4nvl9rMedPS8CzXU5t7gQrdpjwTCPRkOmTceDtvCoNZLikj70JlGrqGJs3UClPob9A7QSwMFe/K9EBCx0AE9o82xGSwb2wAX2ZUVaDIUZaTyuGOhNea6pCVZvc/09m1W3VUhIIZ8otFED4QmiAVHBZIZT3nOaOiCP298Ibegwnds+F1wtsYSM+L/uUk2k+DmBWaQSF/agBFyrmWRmwPq/h0JcRVrb4E4UZjAXu9f2KVDPwLRkqFvlCd0QJaVwHRsXV28lert5zZqQ5d8EzIvxQcdwennPOzmpXxuq90GRXGDbxAKe4kFi/Jscm3nugC8lrQSMSPygIqHG/YNJJVRM+f0ZMK3FkklTURaBgw5351ej8NLaTLY56VOeCcQTEiMZ3v3cJWeMfD2sMl5ePYY6eZn5QBCbmH9aymxHCkMcYHlhtsNQuIcIYG8GLC/ldKfX0IecX5iwQNR6baG9qzZU/xivnd8Lq37KAc0+OMNb4Hb/jW+5pkRxvzRKBU0z7s3phgR70l8sQVsAYfApCjorF9EmJxL2c+Ma5t2YmIP8xp0az8Sm/PAa4OJjI2QxiaCzUIqa4bVPFTBTENHUiyPl1jWTc+3NBeInq7s/GztsW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199015)(36756003)(86362001)(2906002)(921005)(38100700002)(8936002)(7416002)(7406005)(4326008)(41300700001)(30864003)(5660300002)(83380400001)(31696002)(45080400002)(478600001)(6486002)(31686004)(186003)(8676002)(53546011)(6506007)(26005)(6512007)(66946007)(66556008)(66476007)(2616005)(316002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVljclJRT0srY0VJTzhKL0R2QUVtV3JBbjFhY0RGVkxtRUxVbTlpdWhMdkc0?=
 =?utf-8?B?SGw3bkpwdk13NmcrejRkbkJLYVBYREl3b3RXR0hqUTB3OWFWNk55N0dnN0Vh?=
 =?utf-8?B?b1BGNkhDZGczRkl3SVVwSE0xY3B5L2FpN3BkNzA0aFA4ZXlOZDVRWGMvSnl2?=
 =?utf-8?B?N1ZtSElQMG5zQ05Bby8wa24vUFhLamtFZzVMRi9McEJ5THRObXI4a1kwTFBK?=
 =?utf-8?B?WWFibnQrL2RrUXAzMVhwNkRWVjZpY0hXdm5tM1U5NzR0SGRteXVxUnYrOUNu?=
 =?utf-8?B?Tks4Yllzb2tqendwVWkzbjlCdE83TC9Wd1NjT2xJenBtSTVZVjhHMS93L2VW?=
 =?utf-8?B?Q0VvRDlXSFpHc3NReEZSYklMK05CbHFGZGQ5dnpDTVc5bWN4dE8wcXQwYWx6?=
 =?utf-8?B?RkFhL09kYlVPeVJyWWFmRnhOaTNkMHFVaDBhOXMwVkN0RXRBZW5ibGJKa1JH?=
 =?utf-8?B?VmREU2FmdjJENFRTNWJVVXBMdURrWTNWWkxwUUhkdUVhVWdRcEZYSDh4ZGt2?=
 =?utf-8?B?d0lrTWFMU3JSWG04ZmFpZVBsT2pFcUFmM3hDZWVGZm1oT1lvL2FSL1pHbERj?=
 =?utf-8?B?aWJnbVNpWDFhclZHendkWm1qQ3FtS1AwNnRuT0M5d1JNTTdmUHRPT1FkVTN0?=
 =?utf-8?B?TnhheWtnb0crQnlhSHNySTNPWFFPNTRkNWc5U2hCZFhTMC9WQzhGM3lJeStY?=
 =?utf-8?B?MmxIYXIzdmk3K0t2YnJZNGpKUjlvOUNoemhITWRNZitlZVczbHZvWUxXdFVQ?=
 =?utf-8?B?L1l4MGJQYnpBdXFTaEdIL244Y2Y3aDVCMGp2ejdYaVJXeGZQZThnZ3BlMGNy?=
 =?utf-8?B?V0RlenVPTnVmcWlZOWh4bmd5bERwWnpkZWxNNHlVTXZaL0xjVlplZ1NQbFND?=
 =?utf-8?B?S1JWL3RBaENqRWc2Z0gvNnB6eURaSTVRa1FNcnk1blBjbnpDZXM2K0JnUEll?=
 =?utf-8?B?Qms4YURxWURlZ3FRYzVXN2RSTFErczlXYXZ4SnA1MUdNdy9kd2o1eXdwQWpx?=
 =?utf-8?B?dVFCUFN4R21Nem82V1VPeUN1b2J5ZjBKYjlVRFVMYW1LQjFTSnBFV292VDZ5?=
 =?utf-8?B?cWhIbGNPNUpBZDh5WmIyNDBCTi96Ym1YUW5Bd2w1U1hjWW81R09TRVFpU1Zi?=
 =?utf-8?B?c0ZZVVJtczdFS2xYUWFaTXFsMlhOYXVrTFFjNXVCZDhZSVl4eTFkNDNuMDcy?=
 =?utf-8?B?ZmJkRTFnc0NkUWhnbU0vWnY1amRPL0JMYUZ0dWVIOVJoTG9wU3JHN2J3N2h2?=
 =?utf-8?B?bGV5Y1JHbktQR0h1ODcvbStCdDY0U0ZOUEMvWnk2cWR6YnV2UzlkRHNJZ3Ro?=
 =?utf-8?B?bzU4WDBlVUxWbmlVZjhoY2pCNjhrQ1lhVTc5TmppUjhRQVRTL3JJeG0vZ280?=
 =?utf-8?B?aHpnR1VFTHJzN2VTSjRhRHFZVkdVR0FHVmhuZzRDbDdxZy9ZeWx3cnpybm1I?=
 =?utf-8?B?c0laOTVMQTlyc0N2cm9qbXBGQzBlRUVVUWZGRDlQVHZzYlNxMHFWZG1KcFpE?=
 =?utf-8?B?U0J3Wm83NFFSQzFXY1lUeWZKZ0pUZUR4YjJXeFEwQ0dUc1lFQUk5bG9zcFZa?=
 =?utf-8?B?a0kvRnZ6dDlKYVY3Q0ozd1EvdGNEOHV0c3RUbG9FSHBoNzlXQmNCZndNU1Fx?=
 =?utf-8?B?UUpkNXpiWStYR0lic000OUFxRnZveHREcTAxNDR4Y0VqbkNSS2xaRmxWZjZQ?=
 =?utf-8?B?UDV2RFI4Q3MxUzZGK3RXUTN1YnlxcitPS3gyS0tUUlZKdzZLeTVrNG5BZVpz?=
 =?utf-8?B?aUxtT2tPajhPS1EzUHBJamM5TnU2NmlPZC94WHZrVTNQeHRGOFMzQlc0ZVJT?=
 =?utf-8?B?d2Yrd3hvbnFNa3VDWlRKaGY1UFE5cTZ3Uno3bWZEZEdhNDNjMXBPdjVFaUpC?=
 =?utf-8?B?dW5uYWF4SFVuaHc0QUIydHBGekEwQUdwMWE2ZzRTb1F0dXpyYll2RE9QUlFs?=
 =?utf-8?B?NzB3YVhnMlloSmlPZVZoT1B0WDFMejRnQzhJWm1LSTVnRDNkcW9OZ2dvbFFN?=
 =?utf-8?B?U2lNNUljL21XRGZkK1lJdTBBL2xnMTdBdlNUMTFNc3N0Rk9QWVJDZjk4RDgw?=
 =?utf-8?B?NS9Cb044dGlYSmYxaFdrVHlMTjhIa2hOTGpiWGhaaXl2dWppcnloc1BOWEx5?=
 =?utf-8?Q?G9nI3kuggWoH5PClhoWS42eBy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deff4c8b-250b-4b7c-86c0-08dafd56c03c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 15:30:26.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZOsiym0LZQuIr4ffSe0HsU/vdSavhB5Z8gqcZzj9evLvkp7dmz9ccJCDGJ1h43RzeoVdgez9v4yKZm/Nt+kQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/21/23 20:46, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> The wakeup_secondary_cpu callback was populated with wakeup_
> cpu_via_vmgexit() which doesn't work for Hyper-V. Override it

An explanation as to why is doesn't work would be nice here.

> with Hyper-V specific hook which uses HVCALL_START_VIRTUAL_
> PROCESSOR hvcall to start AP with vmsa data structure.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC v2:
>         * Add helper function to initialize segment
>         * Fix some coding style
> ---
>   arch/x86/include/asm/mshyperv.h   |   2 +
>   arch/x86/include/asm/sev.h        |  13 ++++
>   arch/x86/include/asm/svm.h        |  47 +++++++++++++
>   arch/x86/kernel/cpu/mshyperv.c    | 112 ++++++++++++++++++++++++++++--
>   include/asm-generic/hyperv-tlfs.h |  19 +++++
>   5 files changed, 189 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 7266d71d30d6..c69051eec0e1 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -203,6 +203,8 @@ struct irq_domain *hv_create_pci_msi_domain(void);
>   int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
>   		struct hv_interrupt_entry *entry);
>   int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
> +int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip);
>   
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   void hv_ghcb_msr_write(u64 msr, u64 value);
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index ebc271bb6d8e..e34aaf730220 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -86,6 +86,19 @@ extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
>   
>   #define RMPADJUST_VMSA_PAGE_BIT		BIT(16)
>   
> +union sev_rmp_adjust {
> +	u64 as_uint64;
> +	struct {
> +		unsigned long target_vmpl : 8;
> +		unsigned long enable_read : 1;
> +		unsigned long enable_write : 1;
> +		unsigned long enable_user_execute : 1;
> +		unsigned long enable_kernel_execute : 1;
> +		unsigned long reserved1 : 4;
> +		unsigned long vmsa : 1;
> +	};
> +};
> +
>   /* SNP Guest message request */
>   struct snp_req_data {
>   	unsigned long req_gpa;
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index cb1ee53ad3b1..f8b321a11ee4 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -336,6 +336,53 @@ struct vmcb_save_area {

Please don't update the vmcb_save_area, you should be using/updating the 
sev_es_save_area structure for SNP.

>   	u64 last_excp_to;
>   	u8 reserved_0x298[72];
>   	u32 spec_ctrl;		/* Guest version of SPEC_CTRL at 0x2E0 */
> +	u8 reserved_7b[4];
> +	u32 pkru;
> +	u8 reserved_7a[20];
> +	u64 reserved_8;		/* rax already available at 0x01f8 */
> +	u64 rcx;
> +	u64 rdx;
> +	u64 rbx;
> +	u64 reserved_9;		/* rsp already available at 0x01d8 */
> +	u64 rbp;
> +	u64 rsi;
> +	u64 rdi;
> +	u64 r8;
> +	u64 r9;
> +	u64 r10;
> +	u64 r11;
> +	u64 r12;
> +	u64 r13;
> +	u64 r14;
> +	u64 r15;
> +	u8 reserved_10[16];
> +	u64 sw_exit_code;
> +	u64 sw_exit_info_1;
> +	u64 sw_exit_info_2;
> +	u64 sw_scratch;
> +	union {
> +		u64 sev_features;
> +		struct {
> +			u64 sev_feature_snp			: 1;
> +			u64 sev_feature_vtom			: 1;
> +			u64 sev_feature_reflectvc		: 1;
> +			u64 sev_feature_restrict_injection	: 1;
> +			u64 sev_feature_alternate_injection	: 1;
> +			u64 sev_feature_full_debug		: 1;
> +			u64 sev_feature_reserved1		: 1;
> +			u64 sev_feature_snpbtb_isolation	: 1;
> +			u64 sev_feature_resrved2		: 56;

For the bits definition, use:

			u64 sev_feature_snp			: 1,
			    sev_feature_vtom			: 1,
			    sev_feature_reflectvc		: 1,
			    ...

Thanks,
Tom

> +		};
> +	};
> +	u64 vintr_ctrl;
> +	u64 guest_error_code;
> +	u64 virtual_tom;
> +	u64 tlb_id;
> +	u64 pcpu_id;
> +	u64 event_inject;
> +	u64 xcr0;
> +	u8 valid_bitmap[16];
> +	u64 x87_state_gpa;
>   } __packed;
>   
>   /* Save area definition for SEV-ES and SEV-SNP guests */
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 197c8f2ec4eb..9d547751a1a7 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -39,6 +39,13 @@
>   #include <asm/realmode.h>
>   #include <asm/e820/api.h>
>   
> +/*
> + * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
> + * to start AP in enlightened SEV guest.
> + */
> +#define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
> +#define HV_AP_SEGMENT_LIMIT		0xffffffff
> +
>   /* Is Linux running as the root partition? */
>   bool hv_root_partition;
>   struct ms_hyperv_info ms_hyperv;
> @@ -230,6 +237,94 @@ static void __init hv_smp_prepare_boot_cpu(void)
>   #endif
>   }
>   
> +static u8 ap_start_input_arg[PAGE_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
> +static u8 ap_start_stack[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
> +#define hv_populate_vmcb_seg(seg, gdtr_base)			\
> +do {								\
> +	if (seg.selector) {					\
> +		seg.base = 0;					\
> +		seg.limit = HV_AP_SEGMENT_LIMIT;		\
> +		seg.attrib = *(u16 *)(gdtr_base + seg.selector + 5);	\
> +		seg.attrib = (seg.attrib & 0xFF) | ((seg.attrib >> 4) & 0xF00); \
> +	}							\
> +} while (0)							\
> +
> +int hv_snp_boot_ap(int cpu, unsigned long start_ip)
> +{
> +	struct vmcb_save_area *vmsa = (struct vmcb_save_area *)
> +		__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	struct desc_ptr gdtr;
> +	u64 ret, retry = 5;
> +	struct hv_start_virtual_processor_input *start_vp_input;
> +	union sev_rmp_adjust rmp_adjust;
> +	unsigned long flags;
> +
> +	native_store_gdt(&gdtr);
> +
> +	vmsa->gdtr.base = gdtr.address;
> +	vmsa->gdtr.limit = gdtr.size;
> +
> +	asm volatile("movl %%es, %%eax;" : "=a" (vmsa->es.selector));
> +	hv_populate_vmcb_seg(vmsa->es, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%cs, %%eax;" : "=a" (vmsa->cs.selector));
> +	hv_populate_vmcb_seg(vmsa->cs, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ss, %%eax;" : "=a" (vmsa->ss.selector));
> +	hv_populate_vmcb_seg(vmsa->ss, vmsa->gdtr.base);
> +
> +	asm volatile("movl %%ds, %%eax;" : "=a" (vmsa->ds.selector));
> +	hv_populate_vmcb_seg(vmsa->ds, vmsa->gdtr.base);
> +
> +	vmsa->efer = native_read_msr(MSR_EFER);
> +
> +	asm volatile("movq %%cr4, %%rax;" : "=a" (vmsa->cr4));
> +	asm volatile("movq %%cr3, %%rax;" : "=a" (vmsa->cr3));
> +	asm volatile("movq %%cr0, %%rax;" : "=a" (vmsa->cr0));
> +
> +	vmsa->xcr0 = 1;
> +	vmsa->g_pat = HV_AP_INIT_GPAT_DEFAULT;
> +	vmsa->rip = (u64)secondary_startup_64_no_verify;
> +	vmsa->rsp = (u64)&ap_start_stack[PAGE_SIZE];
> +
> +	vmsa->sev_feature_snp = 1;
> +	vmsa->sev_feature_restrict_injection = 1;
> +
> +	rmp_adjust.as_uint64 = 0;
> +	rmp_adjust.target_vmpl = 1;
> +	rmp_adjust.vmsa = 1;
> +	ret = rmpadjust((unsigned long)vmsa, RMP_PG_SIZE_4K,
> +			rmp_adjust.as_uint64);
> +	if (ret != 0) {
> +		pr_err("RMPADJUST(%llx) failed: %llx\n", (u64)vmsa, ret);
> +		return ret;
> +	}
> +
> +	local_irq_save(flags);
> +	start_vp_input =
> +		(struct hv_start_virtual_processor_input *)ap_start_input_arg;
> +	memset(start_vp_input, 0, sizeof(*start_vp_input));
> +	start_vp_input->partitionid = -1;
> +	start_vp_input->vpindex = cpu;
> +	start_vp_input->targetvtl = ms_hyperv.vtl;
> +	*(u64 *)&start_vp_input->context[0] = __pa(vmsa) | 1;
> +
> +	do {
> +		ret = hv_do_hypercall(HVCALL_START_VIRTUAL_PROCESSOR,
> +				      start_vp_input, NULL);
> +	} while (hv_result(ret) == HV_STATUS_TIME_OUT && retry--);
> +
> +	if (!hv_result_success(ret)) {
> +		pr_err("HvCallStartVirtualProcessor failed: %llx\n", ret);
> +		goto done;
> +	}
> +
> +done:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
>   static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>   {
>   #ifdef CONFIG_X86_64
> @@ -239,6 +334,16 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
>   
>   	native_smp_prepare_cpus(max_cpus);
>   
> +	/*
> +	 *  Override wakeup_secondary_cpu callback for SEV-SNP
> +	 *  enlightened guest.
> +	 */
> +	if (hv_isolation_type_en_snp())
> +		apic->wakeup_secondary_cpu = hv_snp_boot_ap;
> +
> +	if (!hv_root_partition)
> +		return;
> +
>   #ifdef CONFIG_X86_64
>   	for_each_present_cpu(i) {
>   		if (i == 0)
> @@ -475,8 +580,7 @@ static void __init ms_hyperv_init_platform(void)
>   
>   # ifdef CONFIG_SMP
>   	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> -	if (hv_root_partition)
> -		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
> +	smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
>   # endif
>   
>   	/*
> @@ -501,7 +605,7 @@ static void __init ms_hyperv_init_platform(void)
>   	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
>   		mark_tsc_unstable("running on Hyper-V");
>   
> -	if (isolation_type_en_snp()) {
> +	if (hv_isolation_type_en_snp()) {
>   		/*
>   		 * Hyper-V enlightened snp guest boots kernel
>   		 * directly without bootloader and so roms,
> @@ -511,7 +615,7 @@ static void __init ms_hyperv_init_platform(void)
>   		x86_platform.legacy.rtc = 0;
>   		x86_platform.set_wallclock = set_rtc_noop;
>   		x86_platform.get_wallclock = get_rtc_noop;
> -		x86_platform.legacy.reserve_bios_regions = x86_init_noop;
> +		x86_platform.legacy.reserve_bios_regions = 0;
>   		x86_init.resources.probe_roms = x86_init_noop;
>   		x86_init.resources.reserve_resources = x86_init_noop;
>   		x86_init.mpparse.find_smp_config = x86_init_noop;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index c1cc3ec36ad5..3d7c67be9f56 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -148,6 +148,7 @@ union hv_reference_tsc_msr {
>   #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
>   #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>   #define HVCALL_SEND_IPI				0x000b
> +#define HVCALL_ENABLE_VP_VTL			0x000f
>   #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>   #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>   #define HVCALL_SEND_IPI_EX			0x0015
> @@ -165,6 +166,7 @@ union hv_reference_tsc_msr {
>   #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
>   #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
>   #define HVCALL_RETARGET_INTERRUPT		0x007e
> +#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>   #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>   #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
> @@ -219,6 +221,7 @@ enum HV_GENERIC_SET_FORMAT {
>   #define HV_STATUS_INVALID_PORT_ID		17
>   #define HV_STATUS_INVALID_CONNECTION_ID		18
>   #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_TIME_OUT                     0x78
>   
>   /*
>    * The Hyper-V TimeRefCount register and the TSC
> @@ -778,6 +781,22 @@ struct hv_input_unmap_device_interrupt {
>   	struct hv_interrupt_entry interrupt_entry;
>   } __packed;
>   
> +struct hv_enable_vp_vtl_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
> +struct hv_start_virtual_processor_input {
> +	u64 partitionid;
> +	u32 vpindex;
> +	u8 targetvtl;
> +	u8 padding[3];
> +	u8 context[0xe0];
> +} __packed;
> +
>   #define HV_SOURCE_SHADOW_NONE               0x0
>   #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
>   
