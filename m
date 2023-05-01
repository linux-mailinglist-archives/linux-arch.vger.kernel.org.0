Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2812A6F32A1
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjEAPLd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 11:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjEAPL2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 11:11:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AF61723;
        Mon,  1 May 2023 08:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBycHUAz00nD6MVMEX+a3Z16XKWvKmyU01FVzWbtDoclPo/4YFAwbbj6MEnCtFwrJPA0VQrMxHHRPbKA26bm/lkGZDnnvh4suoBhcvrU04rhxlwfUZPkx5D4cXVQF80RPK70ba/UEitVKaVjLL0jrQ0idAl2ytFlCzDOIXEacuHIiUbMFBq2TDdpuRo3cMObQ4I5x11wGamwGlCbhk9K54GR4NQjOeIwAYQ33EIrdiv8sRY1OEkUX1eJcxe4S3IrdGwDw9u13ZNdkyZ0jL/AElWTlh2LaWkjk3phnAuULqd0UeHp5Toomj9BqQSH5wQ/NuKxXzWJ/PAiBs1a28zUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/b2pfjxFUBwy0vmu+SaLGUsYPXh+D1VMxr2/Av9NfDk=;
 b=AVhwFnTUHT1fX+ngWVeZYTCKEMqnHDdmduy9EWR3t1UfSn6IEof38Sqew/EG5bE/N4+agM0rNt3DoCgY/l5i/Mg/kygS0obmYqDaje8QFodvvZgp/UMigHWzwP+Bs/DJJGBQGMpcWPHK5TKJJNANlljS0OC/X4sVdlMgNp5/ya3A/1kFfgnfkCZrNPpZdvsWHJZzfK1UJJDbDhNX9fZgsjSIYdz/uReK3XCORi5uaDcUJwYeoKo5bLFWEybGKIi8BxvhU0Gzk3Q09RsdflhijjyP53AMx/v3vCuhmYVTleXYQGkx2R80Z89017c5aUf5ykUh+rb8wJycw3qelhgtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/b2pfjxFUBwy0vmu+SaLGUsYPXh+D1VMxr2/Av9NfDk=;
 b=c9RLDKc9xj2CuMRHwcwgNdfXn+VEHdzQqr1H86U+qu0w9d9OantjJSGfPpz6Peiwrl+AvOOC+ADM29g+hw/ZAc/cu1p+QL9CaF5HYTHtXv5EP4d2nPoYMkTk6/E0MdsLsnWUsMuy1Uc9xLBAikqzS+Go4zpg2iKiIujUDDqNa/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:10:39 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::ea32:baf8:cc85:9648%7]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:10:38 +0000
Message-ID: <1a8d8464-94dc-b6b9-07f6-857dd3d6e35f@amd.com>
Date:   Mon, 1 May 2023 10:10:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH V5 02/15] x86/hyperv: Decrypt hv vp assist page in
 sev-snp enlightened guest
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
 <20230501085726.544209-3-ltykernel@gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230501085726.544209-3-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::11) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f53c51-2c38-4ff4-180d-08db4a5638ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oN1n/ZbxcvnkBEcCwVZp1+twnT6NkLl02H4Co1CdzSOoJVsbWEID8edteOCQNAzH/5i1lUDzkYrdrpzDwL2iTnbdix58hCz3VUGTW9XgCKecArRvtvce4rkLLa2nJOipCqCMoNdZUKcktbu3qNtXbctkZOfy4jlCQsVU7cCwYCSQ3yB4EiTPpJi2tkphlwH2MUrsvpHj3zQp7SWRfmAAQ6jD5chuAwaMZFZs6NoQ+TG7bQkCX/INhKxjJYqBLVs0YlvxYCLASIXOnlugjzkpP9VFSHy12NsQosRZ6t7PB8BWygIMCA0OluAvgaP8Fktx0RCjQXIxHVQe5ZTaoIC5iNXJjFflmEk8kpI/UL4bCWTOrBtWD8tlII9RTWtOG032d1r4OdgiTMOvWBoSKIEWR8M9Mf1Fo3xT5XmXHcaimwUUqB8SjUgcdoLzGkQOy+MPB3DhcjVc5AZ5yn5MTqsFlh2U47DV3xYe367tBdcLigYRbvAJ0rtNNDtoas85eMUDeu6Sw1sWbKU4Zu3gOXBygsCUBVOjqyLwbe27VBzlyxdw72zrGbSPTO8w0J40caWcHHhZZ9PGzUjUiA5dyNmsV+/27TFkN6ctaaaeA0J5ngnrBHhpjXeP6VuvIK4v7t3TSVWJiUGORFuZTXwqGgi+PYYBakqXh3HNCDqzbGt2Ni4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(7416002)(921005)(5660300002)(8936002)(8676002)(7406005)(41300700001)(316002)(36756003)(31696002)(86362001)(2906002)(38100700002)(31686004)(186003)(2616005)(478600001)(45080400002)(6666004)(53546011)(6486002)(26005)(6506007)(6512007)(4326008)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXU4Si9paTFuTGFDY1doa1RXZEFhWWVZdHMzaDlRdHMyL211d0l0K04rbERu?=
 =?utf-8?B?cWdNQVRVcFptdDhDVjBzUEY5WVVSdFFjdCtIRDVGc29XRTByNkdTeGZrNDNp?=
 =?utf-8?B?WE5VZXdFYnNnbWhxbjhUd3JUa3ZEWnlXQ1AxS1JEOG1LaXo5dDJ0WDFPNC9k?=
 =?utf-8?B?aE1hekw4MUFyUWtYMUQvOEVRR3ZPaWh4VEVqZGFHdHNaY3p6SlpqUm5iaGt1?=
 =?utf-8?B?MHd3SkxlbEJ6QkFkeWRhU0lxR014Ym4yR1VJdGlnMVp0YlZRN0Jnd01JUE9q?=
 =?utf-8?B?RmpJd3RneFVhOE0rQXRUbVh3ZzNhUEdUUEwrck5zRjQ0SFJYMEY2bUM0RTBE?=
 =?utf-8?B?Vm5sZ3BoWmlMckYvZlFNQzlSaFRCSFNxRlpCK2k2Z25xcXlyTWVNTFlBVFFH?=
 =?utf-8?B?TTZkcW9aWitueDYxQldWZnY3dkU0U0NSK3V3RmJGZTIwREl6YW54a0oxMGtQ?=
 =?utf-8?B?OU04K3hFdE5SZ1IrZGZyTUZjWGpKOUI3WHF2L01QY1hqUTJTRHhKZTFFaXNF?=
 =?utf-8?B?NzV1cGczY2pPY28rYkNlcWdPUExKVm0xaG5nSlc5aFJWdUo4TTR4cUlkdXNt?=
 =?utf-8?B?SDRqajh3VjNnV29sc3hOTUxtQXVMUjVrcG1XY3lOSDZVNGVPc0gwU0FOR0tp?=
 =?utf-8?B?emFHMlRkNzRsODRQZWt2Z2hTWmw4WDdzWXZZeExYS2xsc1V3QncyZEp1SmZk?=
 =?utf-8?B?VUlKNDAraWFlZXg1ZnlOcDA1U1V6SUlkNHpKWmdIckR6RnNkeDg3Uy9FMHox?=
 =?utf-8?B?SUpCWkdKYStmMkMzb0tGcFFYOWpSSTJpK3J6SjZQd2ZVN3Y0TEZnMS9vOVQ0?=
 =?utf-8?B?K3ltREc2MmdGRm0weEhWS3hIQnhVd1p5V3dYWCtRUEp1UUZJdEdNTTBKQllM?=
 =?utf-8?B?UjhHRC94NDBTbkU4SGltZDhoNS96T0ZmSFRXRXByb0R1eStrRlBLZUQ4bmxG?=
 =?utf-8?B?cCtoTThxQTRRcXZVYmdmd0t4SW9FRzJIc05SaEtmaDZSb2wvS3BCa2htdjNh?=
 =?utf-8?B?VlhJZmcvYWF2cmQwbHUvUzFPbmNBSE5NdWVBaUhRL3lxaG9GenhhckRlakVp?=
 =?utf-8?B?c2tMWjhIeGN1YlNGMG82cFVuam1MZHdCM3ZkYi9MSDVMWlp6dUhZQTBoY2pW?=
 =?utf-8?B?TnhCMjJCdWE3b1A2bjl3S3drUWxmc3hBZDlJWFdEWmRVUFlXQWJZaHgwdnN1?=
 =?utf-8?B?WmxNc0VHMjMrYTgzVzJXbUJaYk5JZFhubVVzVVFBU0FER0hRRFhoVitNM2Qx?=
 =?utf-8?B?dERoUit4Y2psK2UwWXBVK0ZDZmd5aUVqTFBVRWZwcWR3Qk9MWi9YK3k5Rkxp?=
 =?utf-8?B?TVNhdVpCb0o0dVQ3ZzYwYmhXdVlGSE9ENitwWjEwUHB2TjNsZFREOUp2SmRJ?=
 =?utf-8?B?ZHZ5YXVrVkJORUhoQXhZN1NUTDdJZlA5WWVUem5MZms5b3JQbkg5MDJCdFA0?=
 =?utf-8?B?cStXZEh1THdtK01IaWZXeEMzKysxcFEvcUk5WU5sOXF5UmUxMmVlZzVnbDVL?=
 =?utf-8?B?Y05TSmRIV2RiWVBRNDVoZmpiQjc1dlM1cW9qRVBMUlNSWUEzTFIvaWtPekp4?=
 =?utf-8?B?MHN6U2RmY01WdHN4NEk1akxkUXpxbERSS3BuRENhdEU2VnZCeDk5KzZjUThP?=
 =?utf-8?B?a3FMSFA5NUpnTTIrM0lLblB1M0NJZTc0YXZxNlpNMTFVSGx3VFB6ZXRPaVdu?=
 =?utf-8?B?eFFyeXRxMTFQVE9UWE9VZGxSV2EzVUZMZ2RUWkJmdmZvcGQ3NVdtT2RyR1Uy?=
 =?utf-8?B?YTlnL2djS2xLWStGZnNsUGMvdWhwZVNDd2s4SFNhMjljZ1BZZ2lNMVNNRi96?=
 =?utf-8?B?LzZRNFlHR0NhVnkwaisxTlNSeGp2YzBZQW5heU1GNThtQktQSmNHT3FSZXZG?=
 =?utf-8?B?NkFTU0tLdXRnMnk0cDd5NGhBRUl1Tm0yUkdWaFR4dnJqRTJBRVY1VlBmSmxK?=
 =?utf-8?B?aVJVYSthcktyUlVnUWhGK01EMmUvanRIMjZtV2hXVk5weU1NOHViZUkrV1dK?=
 =?utf-8?B?SUltcGQ3TkdYM3dhMXZyNUhxRzZNTTUvNWE5bHU5MTZnOWhteEhYQXk3K1g0?=
 =?utf-8?B?Q1ROcnd3TFV5OHlDZDl4eUNlQ1ByTHlKRUEvRDVlTEUzVEVqRm5obmJ0WHJ6?=
 =?utf-8?Q?YgMZEcs8igLm61IVWM2TrEjcv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f53c51-2c38-4ff4-180d-08db4a5638ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:10:38.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTO2Yk6ncUKHnok+nUYLECO7zU7TXR9iLuhIfcltCwjhLqBwPtwK2apNlT1o+5gokAJup+UvxPzlGxHMPJ0/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/1/23 03:57, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> hv vp assist page is shared between sev snp guest and hyperv. Decrypt
> the page when use it.

You aren't actually decrypting the page, you're changing the mapping from 
private/encrypted to shared/unencrypted (hence the memset that follows to 
clear the page to zeroes).

And please capitalize where necessary, e.g., SEV-SNP, Hyper-V, etc.

Thanks,
Tom

> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>   arch/x86/hyperv/hv_init.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a5f9474f08e1..9f3e2d71d015 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -18,6 +18,7 @@
>   #include <asm/hyperv-tlfs.h>
>   #include <asm/mshyperv.h>
>   #include <asm/idtentry.h>
> +#include <asm/set_memory.h>
>   #include <linux/kexec.h>
>   #include <linux/version.h>
>   #include <linux/vmalloc.h>
> @@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
>   
>   	}
>   	if (!WARN_ON(!(*hvp))) {
> +		if (hv_isolation_type_en_snp()) {
> +			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
> +			memset(*hvp, 0, PAGE_SIZE);
> +		}
> +
>   		msr.enable = 1;
>   		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>   	}
