Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5152B666BB7
	for <lists+linux-arch@lfdr.de>; Thu, 12 Jan 2023 08:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbjALHnk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 02:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239023AbjALHni (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 02:43:38 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F9F3F45B;
        Wed, 11 Jan 2023 23:43:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=me0cKIfX6vUkeyl3nf4EGAbTzcAVZJypnMQ8pmASvn0A8kvnSaI7sPimX8Ur+6OANkZ8C6ohLhVuzSaTggJut4gB5PsrdhoiUx324ElUi536LygxNanqJhvZPRQgJ+qrHpFaJl1YgSDMVPvJCflA46I17lrRypbDuF5KUJqcM+aww7ANuEKOyIjTxq/vGPI/GOI5qZlAWfZHrRycbzvMc9aGA7EjmhTt4sLacICkj7tmu9B5IatMqJ84vDIR8/SD8HcIWlez88UlM8CiNNDI0YjDmf2jWMdLPdbelxlCR20l3feLoQz/itVSEsaJF4YpHUOMMAYJ5fyLXcwxhLGOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYkgZY5Vd9xp5b46+C2MoJ1yddrrwDltXpY3cW3ANHQ=;
 b=SBT6Gpov+H6fRvW7bvL8XPo/klR0YIjMURm8S/Zy+CGRBWLU+tt50PFnCiHSjPU13FHwoGaE+6GPPIfu4fdpj2NTDqHPbmxdhInvM6P2DIAWFd9eyXj3zMkA+Yza3t2ofnFHq0IEl3088jkF2tVyki16JmtAcdt4pcLTB9ok1EHm5Y3mHRj/tX9nOyntke+ITvbeFQWgxVhx2eXzwaXYrih0kiMlWdkNSNBmDgrFcUypC4UdLvHlNC8YuFQ/WWZ1wmnS2ZtxCPM1l6pXEoRWqx7pY/ollCAvGTxmYXJJpw27ABEJjDdrbnxVMbpQmVF9gUSkAL+61dB4fT9bM90aKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYkgZY5Vd9xp5b46+C2MoJ1yddrrwDltXpY3cW3ANHQ=;
 b=2k5OYyr8qP7K9CI8bGl0eSyRPJljiaI9lW+BixO2hHpAyMko+TWX7zkdU0C+AQKMcYOk4wXvM/9mzZJRr2aRP7YwN5AoeBD3qRwtnbNm6f51B9fFz+ZrZrQJGTb+ttr5YszAiw912ydfgDB4yaobEi2i6jMG/H+LG/N8FrYF8yM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 PH7PR12MB5901.namprd12.prod.outlook.com (2603:10b6:510:1d5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 07:43:35 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::c2ca:f7ae:4ba4:eff5]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::c2ca:f7ae:4ba4:eff5%2]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 07:43:34 +0000
Message-ID: <16e50239-39b2-4fb4-5110-18f13ba197fe@amd.com>
Date:   Thu, 12 Jan 2023 08:43:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH V2 15/18] x86/sev: Add a #HV exception handler
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
 <20221119034633.1728632-16-ltykernel@gmail.com>
 <af54107e-a509-8f95-6044-b155539a590d@amd.com>
 <4b9964ad-045c-4db1-0616-81635b6221cf@gmail.com>
From:   "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <4b9964ad-045c-4db1-0616-81635b6221cf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|PH7PR12MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 56254fb7-61b5-4afe-4b06-08daf470b571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJvKH1yPLDvgCB6gNe1SwcToh1MS0ucop82nQL0cxal6CLz5DOcll8CD2LPyYuR+sAbwA/lWlaSDRD2AWvNXj7Ee9FMlS1dA7tHC5g20iS2i7E2bee5CqSh+Ac6/nxctqos5IXzfMBR5aDFCKNDcwRf4UMoX0XOk4jDDdiRZ3HddML3nZx/m2JYP0k0hO6Ue8P1ErSX5gG789CNf11G6Zk4JLo6Aa2uj+l7L8zQWB16ALkaumKpQaNX8p/bbStAKWF1L4rdfgRzCftOxCvh/tpHGxBxUhgQgu6KpMpxP88ZiM2iIghyg+s959LyZ+fqwBrCLaC9dMXi9CBsq4k29wEiTl/Z4/zkXk+RDLcU+WrvXwjnzhwQoX/QEvsEKejbfWEMK2AAno5cUdfDoy3Or2SA199m2zOXiNfygMx6ZvigDHL4/DB7JNTr8Co+UtRk0j5aOtrtlDBGphxu1KRDkyGIvh5GC3l2S3jWD0+ieH8kKaw9GlP+rMMC0Rep+PFi3OCcWjZsQUiAV+ugfojjadERiP/g8tGxT2DBZxlZDPIaZtoKV5wofTBLSqvJI5h7z3TMhmlJ9n9VQQRkAiucVtjaCFq9cy3nUfKvCqX2TEAkT2jHocB47dy0hnCjEr6OwTsh8GKTtt4EXPia5hkfNFc1Vcz42f5kGvbUygVKDpdNZiylwcadZIv2wqrUOUYX1y9W2hXiBF3iZ9/zSi8Q3cCvUYKf+1FIvRkpMPS7VqzGCSitIRJSLuQ48rPhFrhUM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(36756003)(31686004)(83380400001)(86362001)(4326008)(66556008)(66946007)(31696002)(8676002)(41300700001)(66476007)(38100700002)(921005)(6486002)(6506007)(186003)(6666004)(7416002)(5660300002)(8936002)(7406005)(316002)(2906002)(478600001)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJadFBRMGxxQlkrSFhYb0ZoYTEzMWpjOWdqTkNvR1ZsQWtZb2s5TGF0Lzk0?=
 =?utf-8?B?TjhLUGpLd1N6cXRoU2pDbm9ROW1td0pwcUVvRFBudnJXM2Y0TkgwSVZmajdz?=
 =?utf-8?B?SnRoWENJUDJlRmJJRWQ0RVltVW93dzhjSUtweVc2Q3QwekNxSWhKYTE4WTRl?=
 =?utf-8?B?QzMvYnZWVnpsdHlCVXRVYnBwNS9WQmlNbkVPQXhMdldjUzlOYk5VYWJVMUsw?=
 =?utf-8?B?QXlucWRhL0s3Zk0xZEoxOHFCNVl0NWN1TUdpbFNZZVQ4U1I4SGt1MG0wRTJo?=
 =?utf-8?B?cTRsUlhNUVJyV3c4S1VTQjZhUUJvY1c3Nmw2cW8rNk55UVJnQ3JzRkZUVmJG?=
 =?utf-8?B?akNnbFdxV2RMZ1MvRWlOcFVNS01QN0FvYWU0Z2dNNS8yeER0MGxOUjRyQWxK?=
 =?utf-8?B?M1R3Yk9MdDZKNmh5aytpN0RmU2EwQmhpMm1LNHloNjBUTGhlU2pQRFRiK0dm?=
 =?utf-8?B?V2kyN0t5WEx5aEtUc0VxZi9BRHlFRytZdWhSL1JZREh4RzJJemwvTXpQV0x3?=
 =?utf-8?B?cGZCUnl0YlpNQXVlaURFcWNVUTBVUnlxanZqYktoV0x1aXVvT0RNUzBmTTQr?=
 =?utf-8?B?OTRNTjVnME5yRWxjeVpIb3dyK1RpV0tlc2NhZkF3Nm43TGUxb1JmcXg2M2x0?=
 =?utf-8?B?RHJQU285UTYxQm5YN0N0TFZDRUhhY0tlanZiVjd0NFcrZFdMMjV3bGNNNitN?=
 =?utf-8?B?THZwTU4xRG00emtuS0w5ZVQwK0FReWNDUjRwT2puYWNPdU9hMGlyY3FQWGhQ?=
 =?utf-8?B?enJUZ084K0dmWW9NTHV5c3BqVThqRU5DUHhIcEpWZlZQbnUwRHBCYzhkL1RQ?=
 =?utf-8?B?djRRdHFtZlYyUWV2LzY1NGJKMnJiUk9VaG5oSUVUWUJ4dEtUYTF4aHlzeW9F?=
 =?utf-8?B?bUxRb3ViSVdNUjVIaW9IaytyMVA4QTFDVHk1Q1RTeTBvNm4yY2VFYUJWNEVr?=
 =?utf-8?B?ZncrQnREZ3lMTjRIUEJQeDhsbnRRS2dYRVluOXhtTlRjSUhUczFUMmNXNjJQ?=
 =?utf-8?B?LzhFZnJFTFBVQXJHeFhaNzkzUThNZVZ5anNCRmNTS25iL01RTWF4Yi9mSUY1?=
 =?utf-8?B?dVNyTnJDUHIxZVBPQldmZ3NIR2tnYllBVHlMelVLVHJxSVNtSUhBb1o2SnIr?=
 =?utf-8?B?azBvQ05rTmNwcVcybUt4eXFLMldxaU9MNGtSbG1sQWYwczlQcytqaXlLak9m?=
 =?utf-8?B?UlFDamdiRXFNa0VscnNMRC9SOEdXeklOMDJURU9ONzcwS0FvS2lFRCs4cENE?=
 =?utf-8?B?QSt6NFQ1Uy80czF3MUNpblVmRmlycHpkbU1YMCttcHppaFMrcXdUTDhvd2kx?=
 =?utf-8?B?V3RobWpIMU5iN3I4R2tlckVPVWIxUFZkekVVREZiL0hXZnhXWitTUlZGb2x1?=
 =?utf-8?B?d0cyd2FXcTNVbDVtZDFFaEhPTHBGOEJ4WGFYS2JFaEFscGZuU3FDMEI0azlP?=
 =?utf-8?B?TW5lUmE1VC8yMmNXRUFSaStMcU1iMzhhbEhGV0pScGdRSVdGR2dBZ1IyaEJH?=
 =?utf-8?B?RkJJN1pFbnJKYmdDcnFvWEkrWG4xWStCUS9LWGdmcmJuZlY5ZWgzay9yQzdI?=
 =?utf-8?B?Z05iTUREc3BqTHZ5dWc2VW1GZnRPM2RrWUZXbE1PQ2dqeUNzTDJabkRCY1pk?=
 =?utf-8?B?YVExVkdtaGRVbzlBWGZUSStuS0NibDNncjgyelQyeTBldlNUU3pLcytiNC9K?=
 =?utf-8?B?eTRHb3U5T3V6NnlndElRWW5sMmVqZll3dWJ3SCtjQmxRK0oxR2VuVVc0UFpP?=
 =?utf-8?B?MWRPWitHS1Y4UXJSTVdndE5EN1lrYkJMaGRtbno2QUQ1VHJCNm54YnY4a3lE?=
 =?utf-8?B?ZkRVT2w4YWxjVDFJK2F1cXFJZEtQaFJFb3pweUZGV05wL3hIVVZaTkVTTGVl?=
 =?utf-8?B?a2ZMcU1ZTEpWOU5Ba3VKTlNURG1qOUdSanl4cTh5aGh3TTA0WVFlbkxmdkNW?=
 =?utf-8?B?dHd5N3hUcTNUSEVmZmkwZ01tRlFGOHhwOXU4N2VkSk5vZU5NS0ozZS9HRUxx?=
 =?utf-8?B?L3craE9SUzJzcFpoNGxYbk5yYXp4a1A5cDg2MHliNkxNc0pLdGJiRUVNK0Ry?=
 =?utf-8?B?WnhUcEx6aStwNXpNR0FlckZhTDRHczNZQ0xpVFM5djZtZVdMaHN4cWwzZGhJ?=
 =?utf-8?B?cUtjZXVBUnljZ1AvMFpyTDdyQVRWS3owcW9SRHFxNm14eVU2bGQ5QXViL2dS?=
 =?utf-8?Q?YRvHtZEz9VWD2CsNfNvxERFH29ZbwKkwtjhRWmEJhjaj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56254fb7-61b5-4afe-4b06-08daf470b571
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:43:34.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33jNUyheyJrfubtKxBgEM1aUiQjIhJbGZzeZ+whweFACFu6c9qduBogcbQrro9gfX9T9qozAXWIs48BA9nNkyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


>>> + * To make this work the #HV entry code tries its best to pretend it 
>>> doesn't use
>>> + * an IST stack by switching to the task stack if coming from 
>>> user-space (which
>>> + * includes early SYSCALL entry path) or back to the stack in the 
>>> IRET frame if
>>> + * entered from kernel-mode.
>>> + *
>>> + * If entered from kernel-mode the return stack is validated first, 
>>> and if it is
>>> + * not safe to use (e.g. because it points to the entry stack) the 
>>> #HV handler
>>> + * will switch to a fall-back stack (HV2) and call a special handler 
>>> function.
>>> + *
>>> + * The macro is only used for one vector, but it is planned to be 
>>> extended in
>>> + * the future for the #HV exception.
>>
>> Noticed same comment line in the #VC exception handling section (macro 
>> idtentry_vc). Just wondering we need to remove this line as the patch 
>> being proposed for the #HV exception handling? unless this is planned 
>> to be extended in some other way.
> 
> Nice catch! Will remove this in the next version.

Thanks. Just a note: the referred 'idtentry_vc' macro has some 
instructions added/moved (e.g CLD is moved at start of IDT entry, ENDBR 
added) plus some additional comments added later. Don't know what all of 
them are required to be replicated in 'idtentry_hv', just want to share 
my observation.

Thanks,
Pankaj

