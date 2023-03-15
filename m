Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26AF6BA7F0
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 07:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCOGkh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 02:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCOGkg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 02:40:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB72056A;
        Tue, 14 Mar 2023 23:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GroiGYtTNuCiaR+3waX9oDL1pTC8ocxgcRpQwauOdd8+QjfhuUnQnbLvFXqTmUOWzs+Ad38GKvDyWkIIRlTxWnHswfezTU+K/BWmoRx3NpKQLwFUFayMPEbXMpnG/xIoCj3r92BRnP/EmgGWyFXz/Eg0SyNYMiY6tdekrDzrz5eQJDlLuvdcIs6tU4lE8DRFq0zJC2jSRZ+W1YN/0cBLA2m8CIfF0/k/8TUIBr3ET7d4VmDAARzpTCZ7+EmWDjtIBy5XdgvdHy3p3mnUUUpjPUutmhPgUdYZn9hjC50nL9Op2gLqJhgVFa7x/qrkqoCfHgPCZuJAG0s6rcSU9tVCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eERHCNWTXNPiEe/LcK0D2h9ylR6me9upbTS6sPDkatg=;
 b=EFTJxL6RmBnxovnOaJk966GntCj/eer/MDjFkEttiEx1hCj/dDPH7okhBNRtdjlpFRdtGYSsYxybTx9QgzzEzPo6u1Q1x77Saf/4KgTz1VkwMujFPEzRvCo6IvjcSoCVf+AKd2s1V0sXCyFnAanR2OZtpDT7vuHQOqCEGV7jfJDI5BSmCaBtO9vnjhuwjd+s2elaSNrZFn/qqqUW1TaP1LqX1v9Q8QZ1VxiRjmz13BZaxTGIP3xoE1GgTjF2o+g0X3Z9n3fGgcZptegyc0y0103/vIT+twWffAe2aCdds9tthAT71I/+Sy9cs2aJDsN8BzLES0m2kaN5FQ9wQyYBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eERHCNWTXNPiEe/LcK0D2h9ylR6me9upbTS6sPDkatg=;
 b=2dVdsTi8PDKBo8Ww0JGG3torG7s1NiQVCIHj+o9FEW9tPJ9pTHtq8dZRHgow3PfG+CXEf3otRTJ7pmfxv2EyUvJAJyyuMCOtcMcV2+eKcd/NJN/uE21A3wqR5h7YOFaPRFxsmOTKkl3HWVwKW5iWcfjmN/AspaMv+O4Rp+MgI+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26; Wed, 15 Mar 2023 06:40:30 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::bad5:8f56:fc07:15cf%3]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 06:40:30 +0000
Message-ID: <6788c295-0280-d567-dcfb-a6a852d5f9e1@amd.com>
Date:   Wed, 15 Mar 2023 07:40:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
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
 <fac62414-06f9-0454-8393-f039aa30571a@amd.com>
 <fe100597-26be-23e4-bfa9-f45aa27b7966@amd.com>
 <0a968926-670a-c383-492d-52c45b09bb18@amd.com>
 <8d385bb6-fc30-a44d-a057-f23d89a0152e@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <8d385bb6-fc30-a44d-a057-f23d89a0152e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0154.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::7) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: e39e9c7e-bc7a-4bcc-be5b-08db25202b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kxM2DcZpuFJ2FH3OrYGHJ5c+Tmid2RGm6G6vC2OoAZBNQBffyva830eEAcWd3wGPRejacc2D6bxxMCrlKgEQkwYas3NYCHjQAdeQIMUOp+wxQMtJJDQ0/L8efuQkmrwc8NIEo0k0LkjH/uKXQGiu65Qn0gnW5yKPsmdpE/dXaEEjbF7vqTlA0MjfmhE8xq9hKqKXhCWZwNXrAFdfrK0oky6DlRrU57DkwhL71Algk/lZBV60Zq8zOAb3WQPsbGVczUTn5ME6SVInVAlDrHlRFf0sF8HPaco5YsPSN9Nym3W2+BhjiTVvIyf9hIFRlTgwS57WIyY2vom1j0kpxRvhRRLvZC0DDRt6aJ5vHtIJHL+NmQjomhZdlPWjOZ4wvWOLwAlnPkK7Tk3bqSOmTgru/ViTA1q+ufinzSiQ8P18+jNkCaZp6w98AAeQBQJCvVU7EChKSBTKyOqA58S2qMDhB5Yo3qaPG2w2oWAnQfVsM9xsBF0GlzBlDLQjeodZ7sgL/JhGhDN5ZcPVcVMDiYTacT1EwED4pevCku9oR6YDb9R3fbnyITazWlnFSpyzrUG1LqkAQxBp7/N+PaSxiGug/4rHaaWv5E4jD4+VawFjwvyW97qWD54jfHDlWDHQAYd1rM0+EBHiIkFyGGX+CCIwStq3qU5odyw7MY1V6jFShgJTO5oi1aP8+R3XTCPX/6JxnCnulMDnhgW3PVS1zNFvMTh4x/1WnLI4IHLCYMRFCJCXuTvWNmGs5xDxDw5UaCr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199018)(6486002)(2906002)(83380400001)(86362001)(38100700002)(31696002)(921005)(6666004)(2616005)(36756003)(6506007)(26005)(6512007)(186003)(41300700001)(316002)(31686004)(478600001)(7406005)(7416002)(5660300002)(8676002)(66476007)(8936002)(4326008)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVRoSGNuODA0eUMrM1pscEVmd3Bua2FiY0haRWN1bnBPeXFncW51UXZlUmxt?=
 =?utf-8?B?U3hWbm5Ma0o4dFlDaWRKdU9SL1hTdnNHY3ZRZ0x3SHo3d053Y1JlM0dCNHAr?=
 =?utf-8?B?V1JSK0I5YTJ2aWhhTWkydHBUZkUwUWx3ZTJ4ZDdrY1NCT2FmcW9oOXpQSzdk?=
 =?utf-8?B?clJmbWtvbkhkMmFkUW5qTjdqdzBFWUxYZXJmWm1rcFNEVTJXakM4SEUvVG9i?=
 =?utf-8?B?aGFzRWpBck9XOUlwNVRiaTJvQ3RnbXd2ZjNuSDVEWWFYc0JFdFZYdDB0aXho?=
 =?utf-8?B?UnMvMFBDMU1qalA2Z1BWdXBNTC9Na0tKeUdPY0Z2b0VlNHY3T3hIeHJ6KzlQ?=
 =?utf-8?B?MlBHUzBUNm02My9nOHNzc1ZMcTJSdis2TnZpWnZPdVRiT0pPa2RjLzNCMmd1?=
 =?utf-8?B?aDBwNTJlVEt3N2NVR0xIME1BT3hwNDdwY0hBYWlvNmhoQlN4U01Cb2t6Zk1z?=
 =?utf-8?B?RG5uS3ZWcnZhSWlMR0Z1cVljNjc4Q29aN2FDOEc4eEJJdmVtTExWd1JNZE0w?=
 =?utf-8?B?QTVmS25qaWpGMDFrWnJNQjhwMGw1RnQyTDM4UVRFWCtLQ1ZEZHRKYzRxZDhE?=
 =?utf-8?B?NVBQWTZ4SFZsYUZBZDk2ZnpGK081TkkvSlErN1h5MkhxQlRtckRsNW1JcW5X?=
 =?utf-8?B?TjlpUHRvMFlHWHRUaFBZZHZncXdrcWRwM2Z6YjFHYnE1S1ZTRjVHQlNmbEhX?=
 =?utf-8?B?U1FISndzczZmY0c3T3VXTER4MnE1aU9UYmZ4djlhWmI3MXd4TG5Zc3NVY00w?=
 =?utf-8?B?WS9xM0RIUFlMdzByemloTVRzWFlTU2lwUnBpUWZ2VXNVUG9kcWJLekNrQVAx?=
 =?utf-8?B?aFFISEszQ0RZb3FVNmVNWHI1WWxiazFaanZLaG1IdS83M2d4dzBYZTdSaXM4?=
 =?utf-8?B?ZnVNVnQweUhGTjdRd3l1bWhHaDlhT21BMFVUTGF1REptVmk0YzhVbFJzRm40?=
 =?utf-8?B?UjVERytWV2VIR1BSNDgzVFQ5UUIyb0JMUDNxdldLUGNzckRkQVJZeXZhYVNn?=
 =?utf-8?B?Rmh1aEtGbjNDU3loaFBFVjNMRnhHRzFod2FEczNvT3NiT1RZMTdlc0pyR1Zr?=
 =?utf-8?B?MjlIS28zNllaQWRiV2xyMVNGbGJwSmlVTG05Um1RUllJS1M5dlA0eUt4eWJN?=
 =?utf-8?B?UHo3ZENWVDJaMGxTOEZtSnZBSGZvTnczSTN6dXNqVGZBUzV3R1pTNlRsK1BK?=
 =?utf-8?B?WVMzbHdSSXEvczJRTW1NY0ZiU1prdVpIQm1mZ3RDZy9uNVFVdTA3bEoxb2ZE?=
 =?utf-8?B?Sy9ueGg0ZHRGMHNjVmtBNFlNU3QzT0ZiZW5GTHhvdG5ibUExdUlLVzJsbFho?=
 =?utf-8?B?QWdNOHBleCt0TkNxMnQ3aE9YN1I3dEoxUkJrS1lYMWxxR0MzMnRGckJ6bHh2?=
 =?utf-8?B?QzZLM1lTSk5KQmdGZ0lvRm4zcHg0TUlweTNQQTFxTmZPR2hORGtoK1d4V0Fy?=
 =?utf-8?B?ZXJaS3k1bGpUUGEwaElsaW52dnVuSnZRRkRubGVhUHR0SjZCbVFhZFJVN0xm?=
 =?utf-8?B?TWNEL0kxSnpMbHV3VkNlYnFYSVMzd1R1MWdoZ285RmdjamI1Z2IvS0dIc052?=
 =?utf-8?B?ZitJSm44eXI5OFBxU3d5cjkvRTIxUU9MWDFWWm05ZzRQSGZTR1F4Vmp2ZGp5?=
 =?utf-8?B?MThtMElBZGFZaUV2RUltRzNVZFJTRm1VU0ZXaERkbTlmd2NobUJ3RkRVWFl5?=
 =?utf-8?B?RXRpT1piQms0VWRza2s1ZVdkcDNqTm9pTHlYaHpGK0Y5Sk82U3pNWG5KMjhw?=
 =?utf-8?B?T096ZURnVy9EYkRRZm5kOTNTTFN4V2o1Rm5yZEt0TXordmw3TlJhQTkycEZj?=
 =?utf-8?B?QVlKSUxMbG9QNmNTL1BMSHNpd2FITTZQYWRqQjJqajhpSGJqUUNQSXZEbEYv?=
 =?utf-8?B?dytLdTYvb0xOLzVPTHJ1eGVBcnJieDJncVdaRGpCbnJrZzdrUWFNdTNtSG1B?=
 =?utf-8?B?ZFlVNlV6UUYzVjZNOFZUYW01NXVCd296TGxWZnRGOFBnaGpNanJGay9vOXFG?=
 =?utf-8?B?NDlQTjdwUXVoNWVMZ3BDYTJ5SDBGdytMU051NW1YUldvdUd4NlV3Y0pRcThx?=
 =?utf-8?B?Z0o0TEd1anRyS3JZVnFrck9oY2xjR1dvK0F1MFVaV2VCSVp2SVZ1RitRaW45?=
 =?utf-8?Q?IiPJ1vzQ3DPmqY5PgXRJgNncR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39e9c7e-bc7a-4bcc-be5b-08db25202b3a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 06:40:30.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncELP9b11IwZqzIFlvNrHwBJaaMeyyzNOUA1ZeL8xnsjqnxuHUqe8Bhnw+k+xO98YSWgOk2xlxbrKg0eex6gpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tianyu,

>> Hi Tianyu,
>>
>> While testing the guest patches on KVM host, My guest kernel is stuck
>> at early bootup. As it did not seem a hang but sort of loop where 
>> interrupts are getting processed from "pv_native_irq_enable" path 
>> repeatedly and prevent boot process to make progress IIUC. Did you 
>> face any such scenario in your testing?
>>
>> It seems to me "native_irq_enable" enable interrupts and 
>> "check_hv_pending_irq_enable" starts handling the interrupts (after 
>> disabling irqs). But "check_hv_pending_irq_enable=>do_exc_hv" can 
>> again call "pv_native_irq_enable" in interrupt handling path and 
>> execute the same loop?
> 
> 
> I don't meet the issue. Thanks for report. I will double check and 
> report back.

Thank you!

More testing with the patches: After I commented out "do_exc_hv" from
pv_native_irq_enable()->check_hv_pending_irq_enable() code path. Now, I 
am getting below [2] stack trace repeatedly when I dump stack.

This seems to me after IST stack return from #VC handling
for "native_cpuid", paranoid_exit =>"do_exc_hv" is handling interrupts. 
As we don't disable interrupts in check_hv_pending()=>do_exc_hv(), so 
interrupts are handled continuously here. This also prevents the boot 
processor to make progress and stuck here.

Thoughts please? as I might be missing some important details here.

Thanks,
Pankaj

[2]

[   59.845396] Call Trace:^M
[   59.845703]  <TASK>^M
[   59.845980]  dump_stack_lvl+0x4d/0x67^M
[   59.846432]  dump_stack+0x14/0x1a^M
[   59.846842]  do_exc_hv.cold+0x22/0xfd^M
[   59.847301]  check_hv_pending+0x38/0x50^M
[   59.847773]  paranoid_exit+0x8/0x70^M
[   59.848205] RIP: 0010:native_cpuid+0x19/0x30^M
[   59.848729] Code: 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 
f3 0f 1e fa 55 49 89 f8 49 89 c9 48 89 d7 41 8b 00 48 89 e5 53 8b 0a 0f 
a2 <41> 89 00 89 1e 48 8b 5d f8 89 0f 41 89 11 c9 e9 f7 bc df 00 0f 1f^M
[   59.850995] RSP: 0000:ffffffffbd403e48 EFLAGS: 00010202^M
[   59.851636] RAX: 000000000100007b RBX: 0000000000000000 RCX: 
0000000000000000^M
[   59.852498] RDX: 0000000000000000 RSI: ffffffffbd403e64 RDI: 
ffffffffbd403e68^M
[   59.853361] RBP: ffffffffbd403e50 R08: ffffffffbd403e60 R09: 
ffffffffbd403e6c^M
[   59.854240] R10: ffffffffbd403d10 R11: ffff9af5bff3cfe8 R12: 
0000000000000056^M
[   59.855111] R13: ffff9af5bffc8e40 R14: 0000000000000000 R15: 
ffffffffbd41a120^M
[   59.855976]  kvm_arch_para_features+0x4e/0x80^M
[   59.856511]  pv_ipi_supported+0xe/0x34^M
[   59.856973]  kvm_apic_init+0x12/0x3f^M
[   59.857414]  apic_intr_mode_init+0x8d/0x10d^M
[   59.857939]  x86_late_time_init+0x28/0x3d^M
[   59.858435]  start_kernel+0x8af/0x970^M
[   59.858894]  x86_64_start_reservations+0x28/0x2e^M
[   59.859461]  x86_64_start_kernel+0x96/0xa0^M
[   59.859965]  secondary_startup_64_no_verify+0xe5/0xeb^M
[   59.860583]  </TASK>^M
