Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138A06907B9
	for <lists+linux-arch@lfdr.de>; Thu,  9 Feb 2023 12:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjBILuu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Feb 2023 06:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjBILuY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2023 06:50:24 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E77658CF;
        Thu,  9 Feb 2023 03:37:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0WiLs5TkThusR3sMzqBZdp2o4B7BTSdKVHv4EeP0nQLsz11WNvVqQJi5dj4L0J4B2bHu1UxwKABfnCt9bRgx4DyL6aXP07xWTtQYPJjWKNPZhk5EPijX9/uMQMfJTkcNC7JRpnRxSVrSF2Mw8IYspjiKxUqNBgtyki5XTcnGwjCkHJrNOISeO8QSF/7zqAhm2AZQsTUiwR++Ro6yf0q8loFvA9YtRRSRv0zf8w5msHRtds53WeS57L+n2S/Ht1MHeUEfVZGFy8+i5PBHs5zIBJIzZ1dNVdujmMsgNaRLEBKXHTGYgVAJWF+uwulbijdqk5PCbxwgLmOgxGvDTrZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZqWNtrvh3ZfRNsSqJzOZklRaVHRL2v2vA7qQw/eu5Y=;
 b=drnRZDnjimBpbxBMIbuJ5H7lOcaGcFwO5KdYEE1HqSOovbTKEPQOAfOGNfMSFeLQyVzTzVM6MARbMQa5dyM5U0vvPiK/X0XdGRiR9kyqP8YbsVtIVVq4M1FMI4qI1bicKJSQsh1Ct39a/EB7XiNEFPZFHxdT0w0tK2zVpWEemV+kUEPLxaOKMnw2XVxyQySYA2u6wuwfme9iEVUo2DZa3KCv+vEDYGjaDsSE5IsJuDKBi71Hf8F7oXbjb7q0yfAJolR7v3XJVZahjyo7g88HANRmofg7rYUWRv9JUFsvoroVWzuiMBH+Og5Du83OaK3zixsaxEdhADNGO7skavtLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZqWNtrvh3ZfRNsSqJzOZklRaVHRL2v2vA7qQw/eu5Y=;
 b=fa5dzHNUm1OtkMtYyN4mkgDnOxOoR1vtpRiJJzyJ85H/VEOVRmUT90jUGSf2i4tYRmkYpbdGApkflc8ca5JKXuutsnOGZmBdgKC1zVpafBXk5H9Xz82aw81XLbV8AOtFlQMFM44VoPjN/CKFu7D80O0DzgIZHBuy582JJQh1kCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Thu, 9 Feb
 2023 11:37:04 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b84e:f638:fa40:27ef%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 11:37:04 +0000
Message-ID: <fac62414-06f9-0454-8393-f039aa30571a@amd.com>
Date:   Thu, 9 Feb 2023 12:36:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
Subject: Re: [RFC PATCH V3 00/16] x86/hyperv/sev: Add AMD sev-snp enlightened
 guest support on hyperv
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
Content-Language: en-US
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 8096887b-dc4d-44e1-808c-08db0a91f73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vaj/20azQ7PddtBBE0B1TEQ38NLLKREogabRJ7IkP5juh+njW1FOSQGxNEdiMxlveQDTwXwSg30vIoZRM+piYWF2YF7mUhnwPsVasc7809DXSuHFX4kukmXSiaFtJvVT9/S2ugh2jBsgnC2jI8m3G1BhboWuODo0R5nnw65JbDKw3zdVkJl6bPeTKf7u3CSp7mjsGIM2ZO7aGYEt9XrKvRbmPEbB1XDQ3pXfVpu+X/7JWe3nBi79Z6XPTrCzPV0fBXix8Y3zphlbYGW6Jz3qYpSfopBYqG4KrMzCNjCDcQ+KGXpxsDtJPsGd0GrZ6FbxnY54s5HIKMNtTuGQws9MO5qsmsRLT4eseMT+f4C666lEkELwOkHsGIMbktfZRBU/LgKczY8XWr6FT7MDc5SnHUHIJsrjwt4dbg6sxfdV+W1eYheDMih/09H54D5d1+1MfFPhq0QnbVFEomLldA/97pPgkevfgA1CChJfEXNoz3p+kFMFWrQV1TVZXMdJxnon/1dJn/Ft9OSaPfk0jaIv8xTmjOjFOXsSudXU7ZdoTMptCi1AW2hNn94mPsphZWfc40nJK9JGN4LQUZ709j7n0/vUYCawjAPAwCuRoPh24M3fEmU3FZfKK9SiAK+V/HdmVDePD3Jp17gE1c+Tmi9BchxHGeaS4z4+tinW54Hv5jLWZHFjsV0EA5eW30bOR1D5O20PWVQwfHnZQgzOptgfD0hUDkFdprx968YfwQNIvxOMtnX95+vM1TYPwQrHCb/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(41300700001)(36756003)(2906002)(38100700002)(921005)(478600001)(186003)(6512007)(316002)(2616005)(4326008)(6506007)(86362001)(66476007)(6666004)(66556008)(66946007)(31696002)(8676002)(6486002)(83380400001)(7416002)(4744005)(5660300002)(7406005)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDNTaXFKUW1nalcySm1GTDF2cVQrMGhLQVkwOUJTbk9jQUpQRU4xWXZESW9M?=
 =?utf-8?B?ckZTZjhsWmE4UUMwZ0xYcVVEWFdjeC9aYURrRnJlQmlCVmtEeXNmaXhqTTJH?=
 =?utf-8?B?LzhmSEsxVkpJN0ZNNjlVNFV0b1FORzBqejViL3p3THRkaWxtOEVaSVVCWTdm?=
 =?utf-8?B?MUMrODF0cUFEZCtPZEtQSFlLM0ZmRTQzaDVhYUEvb09VNkdhOStyZVpROTdY?=
 =?utf-8?B?UDc2QUJIRDRWUS83NWRhNXZCakg2b2RtVHRHUCsrbVRpN29ka3VHVDNBMHZk?=
 =?utf-8?B?aEorWmNnVlRWQis0ZU9PTEFKMTdBZXBGVzVoemY2VXpjUW1JM2dsZy9hT3dT?=
 =?utf-8?B?WHdWbjAvOTdvRitpbUJjWlYwTmVya0xVdlhYKzFrdjRQcHgvK0lSeVBPVDJ0?=
 =?utf-8?B?Z011d2JkVVhQcmw5KzRjR1FYeUdJeFVXNDE0QjdtaFVqSTNwd1o0eEZDZFpS?=
 =?utf-8?B?cks5dzgwUCsvY0l0WVRFRmdGTmpOSmoxZTQrUzRkMnRLYm5YUzBaY2VKU3A4?=
 =?utf-8?B?ajl3UEFXZTE2QnRJdnBoS1dRN0pEamhCUHNpZVlhbnhBWGh5bUtHRHh6MUxk?=
 =?utf-8?B?ZTNRMEJzN01KbnJpNkJpcU9wSExzaGFOOTN2NGhWSDUwY1R2b2dwVldtZWQv?=
 =?utf-8?B?Q3BjUVFaeUJsOUh0ZGlFOUNObFdBbzc4bE5mZUhEclg4YUFmdzJFUXVIQm9x?=
 =?utf-8?B?aHBibUJxZTZsRjZsTDdtYmtja2xtVDlkSWRISFh3MTlCNGxKSGd3VlZDZnA1?=
 =?utf-8?B?YkZnSERRSHBoV1M3RTRrenpnQ2t4YTFZZjFWNWN2ZlFYUTlVd09wR3E3NWx2?=
 =?utf-8?B?d1h1V2lXaGNZODArblNhRDhDM1UyeEVGZ24waDlTSGUxNm5ZZUNiVVlSVW9K?=
 =?utf-8?B?RDkxSGFpVWk4bStwczJwOGFFYUpvMERIOUVFU3Q3aVlJVGozbDNJUm5kQ09j?=
 =?utf-8?B?TUdwUFc2TUNBdk9YOFc4RjBPVG9lUWwzOVBxNTNQWldld05jdVdGd1hQbExu?=
 =?utf-8?B?ekRndmFGQUpaelVwTVVIZVdFRWYvcXRWUiticWtBMTRFWDc5R3lTajlGUWVY?=
 =?utf-8?B?NVEvNHV5cmdaYXBJMks2N2U4TW96R1l1MDhvb0UxRFdvOGgvanR2M1A0b3RH?=
 =?utf-8?B?cEdjMm4xT283MVJUM1htSHBLWXhOOFBWLzJqL3hMZmwrS0hDT1ZCak0wYTQx?=
 =?utf-8?B?VFVUbDlzS0N4YUxyUDFKQ2hzM0NTZUxVekNORU1GNTZDQ01kSC9DQmtzWXZw?=
 =?utf-8?B?UmpCRmpUbmJkR2NTQnVFa0FhVm5TcjdCVktSTGp3TEV6b1lYU1JkVmhYdzdl?=
 =?utf-8?B?TXRraFpoUkRIbjgyYkwvNlFjTHFVQUtqbkhvSzNxanVMQWJVdnVENndtVmFr?=
 =?utf-8?B?RVllbFFOWHRsUVVoa3loR0k0RlUyaWhZNHN5elc5bzdyUEZGU003bGU4ajl0?=
 =?utf-8?B?MXB3N1lUdExyTys1K09kaFR6dmIwWnJ1aHhoaWg1YmhnOSt1QU5YZjRIWHYr?=
 =?utf-8?B?V0RmLzNXcG94WFFjVFFSRWlsc0x0ZlV4MUs2UGdnZTJyMW9YQTRjQTlZd2do?=
 =?utf-8?B?U3lhL0F2c0JHUytjWkNFZXZXaVNmaTRFMlFsR054UGxNU1k4c0N3Y0x1Z0hW?=
 =?utf-8?B?Z1pqM0FTeE15MVowMk10dldmQTRMWldQazE0SnM1Z0RZbzV6YWNPSG9YMlk3?=
 =?utf-8?B?dm01LzdoRnQ1QkZaeXBmblNkL2w0dkVzQXdQVU5MaGlsUWdxcCtoVVozSzhH?=
 =?utf-8?B?eWhTenM4cS9wVVROcldjTE43cWRQcmFoeXNjQTBmV09tTUtOYng1Z2pPN1V5?=
 =?utf-8?B?K053MjB0TXdtb1FGQVJiMmtoWG5qb3VPdmh4T0NLQ1NOeEFLU29DS2FKTld3?=
 =?utf-8?B?M0JOR1RpM2RSWjlHd2wwbVp1UDBSM2FqMHNOQUgyU0pzeFJPWlpFVml0a0Ux?=
 =?utf-8?B?bTc3a3dtak9mUnpSZ2c4QXRoZHoyT1FWVXRNVTIrT2laMnFqQk9jK2lIWFp1?=
 =?utf-8?B?OHZhcjhERUV1VnpFK0NZWFRGdENiTURCdmdGK0FOK0ErN2hVN25Vc3ByRmVo?=
 =?utf-8?B?ZkxwMU5zbm0xQUYzeWZWWWJCa2p5SlM0VXhTOE1jdFNQRU9STFJkTVExRHd4?=
 =?utf-8?B?NUVNUEwvb3p4bkV3d1A2VUgzelM0MkRVWi9Id2w4WXZ2Z0pYakJ6SUQ2UU9O?=
 =?utf-8?Q?/OheBW5+DVb+JwsMD5T0mtM8c8+rZAq1NTJLi7WruabI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8096887b-dc4d-44e1-808c-08db0a91f73a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 11:37:04.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzttXlfaQYt0OKZiNiZk/guk3E5gNu0Zrkug/zpMEcp+UKtKyEjFh0TbYpwAxNClJB/I5Ho6tEYjyvNsk525gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Tianyu,

> This patchset is to add AMD sev-snp enlightened guest
> support on hyperv. Hyperv uses Linux direct boot mode
> to boot up Linux kernel and so it needs to pvalidate
> system memory by itself.
> 
> In hyperv case, there is no boot loader and so cc blob
> is prepared by hypervisor. In this series, hypervisor
> set the cc blob address directly into boot parameter
> of Linux kernel. If the magic number on cc blob address
> is valid, kernel will read cc blob.
> 
> Shared memory between guests and hypervisor should be
> decrypted and zero memory after decrypt memory. The data
> in the target address. It maybe smearedto avoid smearing
> data.
> 
> Introduce #HV exception support in AMD sev snp code and
> #HV handler.

I am interested to test the Linux guest #HV exception handling (patches 
12-16 in this series) for the restricted interrupt injection with the 
Linux/KVM host.

Do you have a git tree which or any base commit on which
I can use to apply these patches?

Thank You,
Pankaj
