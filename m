Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6749F6F3365
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjEAQGI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjEAQGH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 12:06:07 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5AF1B3;
        Mon,  1 May 2023 09:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4Ta83JBP7DaB8ph9z2xfRV7h+ZxeWw01Zd0CXoDHtjABimtDw+zYJiH1PIIgCKMoBs21R//1qd6kovgPcRO4jom1dol7cdcdMnjJJKRHfulNNk4uVWiNVxikXJWUAfX2CpXpJxx7Ru/pZBe86u/uhF/z7qxy3iFQei+DQsGGD6dPuFZms/y7a7KrlmQs84n5AObZGvyucaf7/5A20P/SBOJ7aGweJr2mMGgmdsUnD+IVcp+CvKazxDTrj+EGNnzcuVA33voAVxm/ykGhvSp+sKx6ZBFdzjw9QVRfuY38e2HdjKKJ2eHuQDl3ocbUPK4jhmQfPDZ3MK/3Rfb/p7nIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UO4xMzPf08KLEYcVTWohLrpJn2gBR6WX2gVcQ5pRFc=;
 b=UtOxQ6EJpGoj3eAG2R6hWTTIk+p9B0e8gdwitt/oHpl3pIBSiU8uOEjR9Ajy8sO1Bct4MA3uar/M/H+XQZFxbnYi5Vt/tKPH0rKz52ScXkqzAdhP6CFO6QciEzrk5jO4UMurryWNCm7sSdjEPb+uRfCa92qziBXie9NTAExcDOV01TjJa8DHgBYBgtlM7i1WqDEw8qFwNcXwb254FJlKADrR9JIHAMEduhQdfqmP7s57Hzff/Fddy7Rb2LvB6Hv/TOvduY9acLWMo/9NfR6LL137D1SbgHhnSiNolcpoJ4Oe0/BGeiW/v0C6sxlz7aPqg8SspuKsRas7nvGeTx19EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UO4xMzPf08KLEYcVTWohLrpJn2gBR6WX2gVcQ5pRFc=;
 b=3XtygAAsfsHS4HNJ97/BvOvF6HQWzdSzBBox225Whsjo4NptwHAIaOdtm4DA7FwH0BSAPxT2k65IyvlKzQKe1Ru//HfxxGkNoTDZIbUGr2Eqs2aaXAOtmmzflEXTpcBYsfTNUatDjs2UjUARtFpffu1n6WV7x2srqeJ7Go3/Emg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 16:06:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 16:06:00 +0000
Message-ID: <a28c5655-8d7a-0fe2-2759-cc69ebbe0a3a@amd.com>
Date:   Mon, 1 May 2023 11:05:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH V5 00/15] x86/hyperv/sev: Add AMD sev-snp enlightened
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
        michael.roth@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230501085726.544209-1-ltykernel@gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230501085726.544209-1-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:806:27::13) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c3547b-4e02-4193-c445-08db4a5df4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ivFBuD58wG85inwRDIEEb1RhRvIqFZkY5/4R+LDcpRoJlrgaL41t+yZJYvVnN5xSXOP2FNJK6uQkR6H5e3FPe9337iZv8rA5a+eC0Jqq2bE03j6rCV0t2hTbNBkEjXD8KwC5NbmOnB6SfHQEzh7ZICfOKkq+SIj6TmfYNfHEKRWp+lV7ChvTIfCg2VWQRI3DorOz9655uzkWVsg02iq9mhJ9XNZOWnIFaK9fDvXbAKomuDo87jgQ4k68Z5Le6UnBlpAWxSOPqft4RiDPpH2oaJckbF6tAQPA9l7rR0VmjI/2DiF4d46z9apS0CQHwir+VsjoyHl8emf/aP+zaT2q1Y3wV+BkJGXsuKlksCfg+6E1l1cic2tLkys0ddlU7p7M3DXumbEUbnUMxNH8/wNlVkA/T4/+G6D84LKdoo453yKrLMBPXpGOHTYqbdaLpeke/DaqLBELQEriur/4VRws3HXhEzGpn+YjDBybKOP2ijTHTZQVknK0Xwg2Um4FHphWnXuONi84RiraPIfLvTnXVZKJOLoiZwFFzImfEQtECiZdBvX6X0aoqqCrs1SpGZlOPrQeCmdb8ebpG3OzvsSvw5Mch477uthZFmqamWJo98/WvGmkOaMN1cpiuTwdO4nQKAZDWtYuoQrIJMmzLptVCJqfcvoeCn08cpefqJIznU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(2616005)(478600001)(45080400002)(83380400001)(31686004)(186003)(4326008)(66476007)(66556008)(66946007)(53546011)(6486002)(6666004)(26005)(6506007)(6512007)(316002)(7406005)(8676002)(8936002)(921005)(7416002)(5660300002)(41300700001)(2906002)(38100700002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdSbTBoNlFobVJoZ25HMGcwZzhSdkZoaGZmK1V6RmdJdlArWHM1a0pFNmd2?=
 =?utf-8?B?bTJCdlFZbUtZd2tFVCtKMUpSOS9wUW1OZEd6UDhXODlLaUpaMmxYVjJKWkQy?=
 =?utf-8?B?K2pxYitZU2xBbUtaR0ZuSk5nWitvNXlUdjU1Tm9Pc1Jqb3lub2RuQ0V5UGdt?=
 =?utf-8?B?SFVJU2FsNWtycEpZYlBwNzJlTmVrRTVsWWkyNE5ZWXlyZTM5VHZtdklJOVdC?=
 =?utf-8?B?dUNzWkJEN0FkVjVXREU3MjE1K21pZGtkNlZBRGNKcktlU0NjeXBTMi8rTWI4?=
 =?utf-8?B?TC95SFErRlBOc2xCeEdzVWEvZFQ5L3V1TzRUMXp4T294aGM1cW9aMC94Vzda?=
 =?utf-8?B?ZGdlZVJuaFloaUpENWZFZnZ1WHFZMHdwQXdCUCtQNzlnN3hEU2YrbCtXR29D?=
 =?utf-8?B?Mzkwc09KMFEwV0svVERsZUYxTWNNS3JaVExoTzBIeVFSNXBrUGRTVG9ncDd0?=
 =?utf-8?B?WEhmSWpTK1Rid3BPcDV1bXo3M1JaZnZ3QlYxNm9XbUhQV25LNkZ3Wno0V2Vm?=
 =?utf-8?B?OWhpeFB2ZHpoLzhRbkdFVU9MTDFlMXl4L0U4aVM2ZlRLczczNngxa3NQTUJJ?=
 =?utf-8?B?emlvZzlFUkllYnVtVzRKc2JqTlZxby9nUUFHQkxlZWRJVVM1REtxQzd3QXpE?=
 =?utf-8?B?UnVsWlFNUzNyalQ4bmgwek5sdDNDTy9GMTV1R3gvOXEwMmt3VVRhWXhrZy9z?=
 =?utf-8?B?dlBzRW5ORnFYL3hOMnU2czZ4Q3NvYTBBUWxueFFzdU1lRkEwMXVUUnhJazJE?=
 =?utf-8?B?VGZqaDE4Q0dyNWxxRmErUlVzSVJYZlNRcXJaeitsSDBsRjJOL3JDRFAxc3Qw?=
 =?utf-8?B?QlRKaVN3Z2YyaFBtTHJERGIxaWhsME5ZVHBXYlRYeDRKc0FjRXhXMkVNbGVC?=
 =?utf-8?B?R25OdHY0VFFxVnBpbU9TMTloQTNjbEtPbXM2SVY2TkNlNGY4dkdPUTdBQ1Z4?=
 =?utf-8?B?Ync0TDFrQkNzYmlOSnBvbGx0WGVrdTlYbXNNcU5pTmluU3NieVVNL2UrWjd4?=
 =?utf-8?B?YlJlOE9xWUtlTXVWdDkrTW9nUzR3L056UUpmdFVYNXh5b2dUVVhBTUJxZXZn?=
 =?utf-8?B?WVBNTXFYOTE3TklTbzlJaWtaTXdINXMyWmhKajAyTHlKYUpWRU5DbzVYOEh3?=
 =?utf-8?B?VkpsaklDb0FyMFQwOFZoR0IvMXBhbFU2alJreXZWRnYxTG9vNEJtTGV1b05F?=
 =?utf-8?B?dzN6Njc0Mlh4czlNdEpnUW9QRFoySzR3Z3VlVEhZTHBmY0E2dS9uSjNuK3R2?=
 =?utf-8?B?elp0N1BnT2JsQmlUbHNoclI1RXkxUFNzay9oREU2VlFnRzFLNDExQmtzbS9h?=
 =?utf-8?B?algrNUdiem81S0xzT0gxZHJuRDBkSENMSktmYUlENHBCNHA5UW4yL1czamx1?=
 =?utf-8?B?TWRpcjZGdVRyVlU5QXFCQU5SSGRUakNXcUhqaWE1c1lzejI4OXBsT3ZNdW13?=
 =?utf-8?B?RFh6bFhjRkgvek1zaEVTalBHT095SHNweXEyNXBLdGZRMC9nMVhmRlc5bElo?=
 =?utf-8?B?WEpnZi9oMjBCTFFHY1FNOUhJeGg3RzZqVWFLSFhSbGR4V1JFNmdUOElwUi8y?=
 =?utf-8?B?eThyVHZZb2dCWE84aXR5aEJ2djBCdnI3bXZMVUZUYkVMUkkvNXRMbGNBQUsv?=
 =?utf-8?B?UDN0cDNqTitsbFREeGRzZkFNb0laUFZOdkJ4MUNZMWo1MWJrZ29abElKeWJv?=
 =?utf-8?B?OU1YZXc3UlNBaFl4MmJRbitNUGtsYkhyS241RmtKVHltSWIxUWVOV1BwTjNu?=
 =?utf-8?B?VTRINWZSenEzTTFINkxrRXQwUUgwVWk4OHo1T3JVUGZMMWpNR00vdkltOTh1?=
 =?utf-8?B?Y0VsU2FHUzhZTHMvOWkxV0t0d1dNaXlNcmIyMThmL0tOWS8rRWVOWUtpcHBx?=
 =?utf-8?B?UlBkV3RPZUhZV2xHSEVBQVI1Z3h2dEErQXpRWkpnSjY0Vk4vNE1kcWp1UDBF?=
 =?utf-8?B?S2hHUVg2RmxaRjNWZ2ZvMUpZWFRYWTFaRTZEZGwrOVFOdFMvTFZYSXhXbGp5?=
 =?utf-8?B?VXdJWHZxNkdqaTZyR2ZPTzR6NVJOa09VV3dMVjB2UXQ1Y1BENUEzU2xkMW9x?=
 =?utf-8?B?V1dDOUxjZGQvOVNCQSt6Y25YUnllVGJndEFiM3g0bFFIQjI4eXdGeVU0WDJ3?=
 =?utf-8?Q?8OIE+Pb8TcZcC5+AspOdKzgaH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c3547b-4e02-4193-c445-08db4a5df4ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 16:06:00.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnZhiLAAA8a7QT+wVJLRdz1IhYeFu2DZpbwVu7+G9PHAzxMvbOgOoCvWkBRxa9ZAn4l+pAyo9lfou6IqmvIMiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/1/23 03:57, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> This patchset is to add AMD sev-snp enlightened guest
> support on hyperv. Hyperv uses Linux direct boot mode
> to boot up Linux kernel and so it needs to pvalidate
> system memory by itself.
> 
> In hyperv case, there is no boot loader and so cc blob
> is prepared by hypervisor. In this series, hypervisor
> set the cc blob address directly into boot parameter
> of Linux kernel.
> 
> Shared memory between guests and hypervisor should be
> decrypted and zero memory after decrypt memory. The data
> in the target address. It maybe smearedto avoid smearing
> data.
> 
> Introduce #HV exception support in AMD sev snp code and
> #HV handler.

For bisectability, shouldn't the #HV patches be in place before the 
enlightened SNP support is added, e.g., AP's are launched with the 
restricted injection enabled (even though the BSP will also have that), so 
that things don't crash right away?

Thanks,
Tom

> 
> Change since v4:
>         - Use pgcount to free intput arg page.
>         - Fix encrypt and free page order.
>         - struct_size to calculate array size
>         - Share asm code between #HV and #VC exception.
> 
> Change since v3:
>         - Replace struct sev_es_save_area with struct vmcb_save_area
>         - Move smp, cpu and memory enumerating code from mshyperv.c to ivm.c
>         - Handle nested entry case of do_exc_hv() case.
>         - Check NMI event when irq is disabled
> 
> Change since v2:
>         - Remove validate kernel memory code at boot stage
>         - Split #HV page patch into two parts
>         - Remove HV-APIC change due to enable x2apic from
>         	 host side
>         - Rework vmbus code to handle error of decrypt page
>         - Spilt memory and cpu initialization patch.
> Change since v1:
>         - Remove boot param changes for cc blob address and
>         use setup head to pass cc blob info
>         - Remove unnessary WARN and BUG check
>         - Add system vector table map in the #HV exception
>         - Fix interrupt exit issue when use #HV exception
> 
> Ashish Kalra (2):
>    x86/sev: optimize system vector processing invoked from #HV exception
>    x86/sev: Fix interrupt exit code paths from #HV exception
> 
> Tianyu Lan (13):
>    x86/hyperv: Add sev-snp enlightened guest static key
>    x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
>    x86/hyperv: Set Virtual Trust Level in VMBus init message
>    x86/hyperv: Use vmmcall to implement Hyper-V hypercall in sev-snp
>      enlightened guest
>    clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp
>      enlightened guest
>    hv: vmbus: decrypt VMBus pages for sev-snp enlightened guest
>    drivers: hv: Decrypt percpu hvcall input arg page in sev-snp
>      enlightened guest
>    x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
>    x86/hyperv: Add smp support for sev-snp guest
>    x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
>    x86/sev: Add a #HV exception handler
>    x86/sev: Add Check of #HV event in path
>    x86/sev: Add AMD sev-snp enlightened guest support on hyperv
> 
>   arch/x86/entry/entry_64.S             |  46 ++-
>   arch/x86/hyperv/hv_init.c             |  42 +++
>   arch/x86/hyperv/ivm.c                 | 186 ++++++++++++
>   arch/x86/include/asm/cpu_entry_area.h |   6 +
>   arch/x86/include/asm/hyperv-tlfs.h    |   7 +
>   arch/x86/include/asm/idtentry.h       | 106 ++++++-
>   arch/x86/include/asm/irqflags.h       |  14 +-
>   arch/x86/include/asm/mem_encrypt.h    |   2 +
>   arch/x86/include/asm/mshyperv.h       |  82 +++++-
>   arch/x86/include/asm/page_64_types.h  |   1 +
>   arch/x86/include/asm/sev.h            |  13 +
>   arch/x86/include/asm/svm.h            |  15 +-
>   arch/x86/include/asm/trapnr.h         |   1 +
>   arch/x86/include/asm/traps.h          |   1 +
>   arch/x86/include/uapi/asm/svm.h       |   4 +
>   arch/x86/kernel/cpu/common.c          |   1 +
>   arch/x86/kernel/cpu/mshyperv.c        |  42 ++-
>   arch/x86/kernel/dumpstack_64.c        |   9 +-
>   arch/x86/kernel/idt.c                 |   1 +
>   arch/x86/kernel/sev.c                 | 408 ++++++++++++++++++++++----
>   arch/x86/kernel/traps.c               |  42 +++
>   arch/x86/kernel/vmlinux.lds.S         |   7 +
>   arch/x86/mm/cpu_entry_area.c          |   2 +
>   drivers/clocksource/hyperv_timer.c    |   2 +-
>   drivers/hv/connection.c               |   1 +
>   drivers/hv/hv.c                       |  41 ++-
>   drivers/hv/hv_common.c                |  27 +-
>   include/asm-generic/hyperv-tlfs.h     |  19 ++
>   include/asm-generic/mshyperv.h        |   1 +
>   include/linux/hyperv.h                |   4 +-
>   30 files changed, 1047 insertions(+), 86 deletions(-)
> 
