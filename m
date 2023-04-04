Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10976D604D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjDDM0u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 08:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjDDM0q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 08:26:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F96E212A;
        Tue,  4 Apr 2023 05:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHMqE6YScsjy1TIExkONv7WHmwTbFItRHKptr/+AV1tdjWrsUQAX9ZfrtxLoS7q0waRe1G1fX2uxbIs+LufZ1jgdC/7uV4qFCOWV7oaagEVAQJeNJ7riHsVY9VviXwxhXGYLKxsq8qxN8cHAtBsvU9NPN8heFGxTl7Iza5qm7qp48KLs5vDOeISojTO9C9S2z7BqozkDfwYuhs+/+PbrPnrDTuIfWtMFQ463lZV/dHX415MIGmrX1utlM+wFOd3SUCrIgeEaDbUKsfN2TuX3mPQ4AmSWNr+ummVNC5a5l+HnIics/LQ44hYUh++T/TYXWgB8lLFPVlfi9ZMr1WhXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3rSf80nQXERL5Q2CTDFFM+dezlKvYNWSR2PnmWwy3M=;
 b=GtlG9ersmLtNfSnWliyL1Qm00+JSGfa0Zp5ACrtQixgeWtJnpwF/4QdxI2GEdSUGil+eqsKofQ5Yd8fASV5Y0+LnfHpX1St7ziwNKtiU1N8oCbfBJV2tB67OfVbFaWhbTqS0PGz08Px6oH+v6HBuz8lEBaKisBN0p2rzgX0cUa+vYuWR1AsMC0z+CVdYdwEncGzuPiY1FGZAX21ABJ3JZn72n3fIcYnZ3hwx6DBF8K6CPfIX+yZ4kNCVS5nN20R2KGfI2s1OrT9spiwRqLs9pPygXfm0jXQNjjhGFi90tmY/tTa3ENS77UGzpo/P1DL31b+lVlNypRfBOrBAkqylgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3rSf80nQXERL5Q2CTDFFM+dezlKvYNWSR2PnmWwy3M=;
 b=Qv75FtbuD1ahTI3s/3RQJUtmUja1KSYixCoJS4qRnziFMjZBPeQ01UNc72ek8p5oNxiYpbtOrptJehzxxv8quOR+ayUVqHf73n/XqmFMbKLbI7kcQ8zvqvOBB7PYSCzL2iBfarU8jqRhnKFOxIPlZFBzQgNTu9Hxi8DfcGMVnqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Tue, 4 Apr 2023 12:26:22 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b6b7:4b22:74f0:dfeb]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::b6b7:4b22:74f0:dfeb%2]) with mapi id 15.20.6254.034; Tue, 4 Apr 2023
 12:26:21 +0000
Message-ID: <f2dde9d6-dc04-4c33-7f9d-49454bb192da@amd.com>
Date:   Tue, 4 Apr 2023 14:25:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V4 17/17] x86/sev: Remove restrict interrupt injection
 from SNP_FEATURES_IMPL_REQ
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20230403174406.4180472-1-ltykernel@gmail.com>
 <20230403174406.4180472-18-ltykernel@gmail.com>
Content-Language: en-US
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230403174406.4180472-18-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: b096c2cb-a8d3-4098-d14e-08db3507cc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUSFFvkbWvAlss/wnsJ2uU0z5EUjzwfpRJh67J5HfMim1re7FMgB0r15kdg1qIIkfYFZcqWB5zSsPClxUsH+XxUUQoEuXhceWSrb2cjp6cTR1+jZl1HCCWEKVHL7DwMfMMdVol+uxrgIDQk/DvoWJnvzP3zxXY55+CM/nmKv0aoovbt6/gqcwSbaHj4Qf9CK1khy7O6nx/KBiM/FxMAoz8aX/XKN/Xt1dr8lVIMyntfwT3r8tLIgqbe/TFF3DWcwgo2UC74d9XoKDXToJhWCrUJ9KUgc94VuwaGziI5EWytBX1elGiKfPZumLiaZtQjVmjcUWB7PNwQgn2zXfcMHIHAH1LDq4FsA9eWKsa5alClHhpZ9avgrryuv9OI51dlN744qwe4yQreP7zckrtKLo7xONo5pZ4ho4t4GmGRlXXHzWtGxUboZLFLyQXgMYIGb1PYdeqJFlzOkdsfaQzNOfu5+pYrhzTdXbb/x5RQHlu8etPdJf3KQEO72VXd/6XcKdE83hkvZkZBMy89/FdsdauqRY/SrUbXRbvePH9fvJtAXCjMZ6Qw7q4Smdqn4UGh90/LhRV1XXIFhriOKfeAXnMli13QtatvgoxzBBrhTkX6pE5jy2S6bZFMgvc1g3NlfOVnhIuzbyMdkB6ykl/nw893LWTzZ9wiqWGeC2eNhaLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(478600001)(2906002)(186003)(2616005)(6512007)(6506007)(36756003)(6666004)(83380400001)(6486002)(921005)(38100700002)(4744005)(86362001)(316002)(31696002)(5660300002)(7416002)(41300700001)(7406005)(8936002)(4326008)(31686004)(66476007)(66556008)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1QTWlCNEt2YTFhenp0NWVXM1JJU1k3Qm10aEtPb004VGxiQTZvVVFXdHVQ?=
 =?utf-8?B?Zy9CU0dYYTRTaXh6a0NWRkl0RFdickcxSXBFQ2U0V0ExcHdYZHRXOGllZURl?=
 =?utf-8?B?NTVERGRRMkhNTWFyMzliRHloSExWZHhSR0ZQdmRYbGsvbUJHY2RibGI0QUYw?=
 =?utf-8?B?dk0xak5MMGlJSnlzRjJRSUYxUWxpQ2NMMXJ6WnFGbGdjanF0Y08vS3hSbERN?=
 =?utf-8?B?enh4K0l3Q25acU16YVZTemtHOXdJbGNQVVhoL1c2L1NGaGVCbU1VeStnbTdL?=
 =?utf-8?B?eGhNUVRhWW9BOVlMYmk5VEJlTUlyOXJaYldqdGlXc3lvTWU5dkdQcHJteHp0?=
 =?utf-8?B?d0VRaXEyNkgwakdTaU12ZGZjWHI0T1BpaVRyV3l1RTlHc0EwSGUvamJZL2JF?=
 =?utf-8?B?Y0VvSVVyb3dic2J4aFFpTmhOWjZYK0E2WnFkSVhBQVZvbEZwMkk1bExPVE1o?=
 =?utf-8?B?WGJiYUZucnpWRlRJZlBGa3RQQjdRdGkrclBtS1hkT2JWWllJcUtZdEh0b0hG?=
 =?utf-8?B?SU5TMjNpRzAxSnNEdEN4SytmVE1LV0oxVDBlZXQ4Ryt0KzNoVzMxb2pFeVA3?=
 =?utf-8?B?UzBIaGMxcDRZWEZhR3Zxelg4TS9kUHRuYnZuVWtqQytnc0N5MkFFcmhIRmEx?=
 =?utf-8?B?WFdEdm00cWZnVHJ3WkdTZFo2RXlXZGxjcEhpeDlUTlAvVmR1b1N5d1JhcTlU?=
 =?utf-8?B?NDE2RUpTOC8wcGhYY3JqRU8wYm85L2dtcmhoNmkzKzhJekhNVnVieXJOWnVR?=
 =?utf-8?B?TE1nV2k0TWNvcnYvVVhxeDlqb2w0cExhcUJlbUlTR09EemcrbjBUaDhWOGpX?=
 =?utf-8?B?MEMvNWR4N1NLczlFT1R1TzgxK3Rqd3VFc0RLVElkdGpLeGVMcWkvbjRCa0pB?=
 =?utf-8?B?bVpWdWtrUHFqa0ZObVYvSDNQYlM1dW96VzZEc2k2S2RRZWZUQmw4V2diWi9R?=
 =?utf-8?B?dmtIM2FCNG1MRndjS1FmWmJ2VENzUWt5cVNuRGVwSVFtVEhWSzJtbGNybnVj?=
 =?utf-8?B?WEUvenVVUjBqNSs1N0tSQVhDOU5rNWIvZlhZaUMyWTNma09WZGNYN3JvWndV?=
 =?utf-8?B?cDFlNDBtTUE5azVEZ0poVmFvSDI3T0NSZVRsN2l4M0FvT3BURFhjVXlLVEhZ?=
 =?utf-8?B?eDVRNXpqNnRHY01nYUsyaldVeFpwRmFvYUdjcEEzS2t0eUd1WWQ1MXlUci9j?=
 =?utf-8?B?cmJ5LzJEcGcrSlZRRHhtS2M5RHV1dFNTbGQrYWdIMW1UWHJ6cllNRVZsMDMx?=
 =?utf-8?B?ZWpIQXR6dURHcGF6eDRGSWNCSGZGV0I4MHMxOWsxYXhPREtueDBKRTRoYUhP?=
 =?utf-8?B?T2R2SWQ2Wmt0VXUvQ0ZKM1BFZTZRTENQbTdycWIzS1kxRHNkWEg5OUNXN0Fw?=
 =?utf-8?B?djFjcHQvYzJxbjJ2dFNLQW9BaHZWN2pSdkJ6MnMrenI3MVd3eHlYcWFMc3Rt?=
 =?utf-8?B?SEpxcU1PY2dRaGxFZHZQUWY0a1ZqU0RzRkZ3cXVoSnc5aFo2Z3I0a3lKZUJa?=
 =?utf-8?B?VE5wNGRiQnVWRDJ1dERlU3JDT0J3c3M5ZjFHRjM1TFUzSENUcFRXWklDTlUz?=
 =?utf-8?B?Mk9mWTE2V3ZIQTBIeWV5LzV3YWRtZnRBMFRYaXorcEkrMEtDMTZrdXhLNm8y?=
 =?utf-8?B?dmFBWDlzeUh3dGFoZmRsd2ViMm8yUlFBaE45b0lGQWhwNFVjRUd3VGd3eVZY?=
 =?utf-8?B?MWJSRzY3Y1FxaWRrLzMzQXBsOTdsUjVNNEhzdUdrK0kzSlhLRnU0aUVwNyty?=
 =?utf-8?B?MDVQY3NlYmJsUHlIdnBxQWx0aGcwS1l5UVl5aXlLU2wwSkR4Q3J5Y2tTMG5F?=
 =?utf-8?B?dHpBaGw2THlsWkdqUGdNUG1zSnFROTdqSzY3L1h5dFNyRjk2ZURCVDA3OXhV?=
 =?utf-8?B?OW9nMFNHYjZqVTlVb3NXOGQrQ3dZUnYxRXpjR1E4TEhZTktlLzBWbnpQZjV1?=
 =?utf-8?B?TlRyTnlJallER3hpTzFoU3ZqbGJQRHgwNTNHWFB6OEVwUU1oVTczZnE1c1JU?=
 =?utf-8?B?N2ZlNHZNaGFJMWFKM1EvZ3dBNVhOeUxZQlNpd3ZjZEJzRDJNMVRDQTd2Y3pO?=
 =?utf-8?B?TnZjd3FQWEFXeTJKZnZnOWZsZEZEUnhLYTBhM3NrRStGRDBxZFd1VzhvZEVP?=
 =?utf-8?B?dUFqbVNYejNrYXphZTFUWStBaHk4OHdDNFkrUlNjaDBPbkJWV1l1QUIydWNM?=
 =?utf-8?Q?JnUTle3WSa+G+jqFw/UnK0MSIm1vzyktQ7Bp1cTxDEuC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b096c2cb-a8d3-4098-d14e-08db3507cc34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 12:26:21.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6LALqDz9PmyU1K83FyB5TD+ACp3xpQxqoA8rzR+eq9lMYi/ZM3Eteaz9mbJBTCpkWtPvuQgXox7SX5PWC71Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
X-Spam-Status: No, score=-1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Enabled restrict interrupt injection function. Remove MSR_AMD64_
> SNP_RESTRICTED_INJ from SNP_FEATURES_IMPL_REQ to let kernel boot
> up with this function.
> ---
>   arch/x86/boot/compressed/sev.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index d63ad8f99f83..a5f41301a600 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -299,7 +299,6 @@ static void enforce_vmpl0(void)
>    */
>   #define SNP_FEATURES_IMPL_REQ	(MSR_AMD64_SNP_VTOM |			\
>   				 MSR_AMD64_SNP_REFLECT_VC |		\
> -				 MSR_AMD64_SNP_RESTRICTED_INJ |		\

Should we update the bit in "SNP_FEATURES_PRESENT" instead?

Thanks,
Pankaj	
>   				 MSR_AMD64_SNP_ALT_INJ |		\
>   				 MSR_AMD64_SNP_DEBUG_SWAP |		\
>   				 MSR_AMD64_SNP_VMPL_SSS |		\

