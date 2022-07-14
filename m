Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFE2574EA2
	for <lists+linux-arch@lfdr.de>; Thu, 14 Jul 2022 15:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiGNNGh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Jul 2022 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbiGNNGg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2022 09:06:36 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FFC4E848;
        Thu, 14 Jul 2022 06:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrCBp1IgJo/NGtO2j2N/gSO2Kb2WRJE0HQlK7a9kXjBpYuS4LXjrDsnnRY+v4qrq/CkUmrIv+QHypBLrQq6Lr4h0vCnx3V3SpDyxURItSckUnJP9RrX10INJBV91hLOvnViyxIImA/uBOTTmFSXdyZ3xOxauPOMQLTYefhyXmTe6mGxppmD5mfDYNwtlN6RZeNV7zIv7x9R4jiaymr0itKU0pAnjL+Ucm3Db05T1o+4NEtLhkyvpxmMMJfpsiwldtEb06Dbe/g2zHz2hTX5zvNFsndENbRNnQ4nuutea973DtAm0OjBeiPJPKp8fuQmZdaUq6ios9yfEKCwLTs/NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxBiV9mjRarcCP4E4/k8zPOJoEJqDXHUcxElXeNe0oE=;
 b=Fy+9GcBCgUGafH7R8mhP/fcIsl3rFRgldEmEd1VI3+RcGv1aPwmltkkExVVdnoK2z18fMp47AcFxwgdy9vV4yd2SgoiQR7AxOEEcIhugG/9sNmiYt3GOzznG0t/qEYq7WQk26FuF3toSYRUEE0XKvB3YbEzwWLQMmxcndxHrCI800VYmTS949Y2h5uJ2BJgzdGihLoSVzfpTif+sYqZhF+z0z/4cl0mYmcnrC0juQSOHQSXsgXKyh3OmCeaLasbzlEANE84qS5WpjBh5rPwNCT7q4KzOLsad6jQ+kA9dnHAkMUUydmp8yykMHIxqKZrdugZPJPhBw+WgORFULrD+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxBiV9mjRarcCP4E4/k8zPOJoEJqDXHUcxElXeNe0oE=;
 b=aJbryZpjVVk38Mp9A4VB1vHyviKqAA97dRaH6Rb+Gs9WYDhLhQUGJy4jYhYRYq7tYowxzB7xsNgvX8VLDtmtxAeqADzD1yZYvJt/RRY9CnuanDuxM81ZGGWoyPZEvrlutCZPn8U/Ag4s3hjkOh6jnXrWiklzEA/bTnvkRwYRyWNbDt6wW97lVBfjUlNpLM4crIFNwEoG+VFbkYOjVsuT+FNYR/l1wuNL3E6dwJQN4h5oSVadFTWNGPjenIQy0T+6zx/AkcG8fceXnHxoz+TiokJXQKMngCty62PeNygUhvAe/9HEb3oCQe3XAATMQZZgKauVckn0PxDJZEa8OMJE9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20)
 by DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 13:06:33 +0000
Received: from MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::4966:ba15:be03:dcd1]) by MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::4966:ba15:be03:dcd1%6]) with mapi id 15.20.5417.028; Thu, 14 Jul 2022
 13:06:32 +0000
Message-ID: <4179929a-5062-7bf6-4115-121582822504@nvidia.com>
Date:   Thu, 14 Jul 2022 09:06:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops with
 .aqrl annotation
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <CAJF2gTQoSQq_S4UvAiXgMviT040Ls8+VkDszQSke1a0zbXZ82A@mail.gmail.com>
 <mhng-7a274375-0d99-41c8-98a3-853d110f62e9@palmer-ri-x1c9>
 <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com>
 <20220614110258.GA32157@anparri> <YrPei6q4rIAx6Ymf@boqun-archlinux>
 <fd664673-c4cc-be8f-9824-5272c5c79b40@nvidia.com>
 <CAJF2gTSEBQd75VWyyMwKuSDsLFoiBqB0WJfYsiEHVQbJgAgBvA@mail.gmail.com>
 <YsYivaDEksXPQPaH@boqun-archlinux>
 <CAJF2gTT=7+qYC-y1PapVx5yprmsr4mZGzRqz3hPq1i4SM-xqXg@mail.gmail.com>
From:   Dan Lustig <dlustig@nvidia.com>
In-Reply-To: <CAJF2gTT=7+qYC-y1PapVx5yprmsr4mZGzRqz3hPq1i4SM-xqXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:208:234::23) To MN2PR12MB3437.namprd12.prod.outlook.com
 (2603:10b6:208:c3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 614b790f-8423-40e4-b2a0-08da6599ac4b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2619:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEhqa0NURDBhNU45RUFvdEdibllpMndhZVVpcWdnVzg4aEh6dEgrdkpLZ0pq?=
 =?utf-8?B?a1RGRjdkR1p1bUViUG1KWGRPZVhCNXV1dFBmYlFvUDBNSWdIU3M5U0orOGNk?=
 =?utf-8?B?MXA2L3dJT295cWwrQjBpUTBLQXo2R0hCUnNaYWNYMEtScGcxU29oMUdjU1BS?=
 =?utf-8?B?VFM4UnlhNHFDakFXYndBUU53eW9MWTJ5cWhTSWtMQ3NxUFJkdndSeEdOS3Uy?=
 =?utf-8?B?SkhVbzNUMFZmYmhsYVMwYkQxUElzUExObXNRY2lmZ1dSbnJNTThnR1pCZG1G?=
 =?utf-8?B?ZWZycU9xaG1zT1ROREtkdEhZS1Robkx6S3k1QzhBdFNCVWZqazJHelRmRVRG?=
 =?utf-8?B?L2w1ZkNQV1RYT09HMHllM0RHWjFOZ1F1MVVVdHcvaWpUdTduZDZqb0xqRzZ0?=
 =?utf-8?B?WFhGOXY5bVVzWWNPczR5T3RGa0lRblA2MW5NTzlCQ0VTSWFjbjZyS0VOeE9y?=
 =?utf-8?B?V0MydEN2T0NkOFBPa040QzcrRThTUHlSR0xmaUZhMWpSUjR6cUcxQUpEV2w0?=
 =?utf-8?B?MXZGL2FqUlkrVEM3c3hybkJ2V3pxV2VhN1dzblZocVhSVkg2cXgzdjlTRDNk?=
 =?utf-8?B?d3RlcmtidVhTSnRqeW9DT1BIWGpzM2Y3UHduVmlNcHAwNkx5bGU4UE4yRU5C?=
 =?utf-8?B?RGFOU0pCMk1OWnE4K3RnSWRPdXZzdGYvQjU4anVDR0Z0MVJLZkpVKzNTQmh4?=
 =?utf-8?B?TmxVbWx6NEs2Z05KTDBqMVZnVXRKaGxmaTQvaFVOWGsrb2cxTXRETTVCKzVP?=
 =?utf-8?B?ZGhTdjVCTFBaa2lwSkpIbkkzamRSeFA5cjZQd0FqNjh5bExzeXNCYStpT3Mv?=
 =?utf-8?B?S1NTbytKZVAwQ3hrUXZKV0liRUhqbGdFTFYxS0svUmRyQ1pjTzVibVpaL0px?=
 =?utf-8?B?WUJBcWxrYmcrTU45WmMxK0d6a0xPaFo1czhhWHNpanJKQ3gwdVdtYjVWNThs?=
 =?utf-8?B?RFRpRzBkeFlkdjd1UTNYTnJlRGdoeFVTaVU5V21DVGxKRHhYUm9SSWtYMFVt?=
 =?utf-8?B?M2l1Unp0QzRkcDQzc3U4MWdLS1l0QXMvRHN1bWhiVmdPRkk5dGl2Uk9FWnVU?=
 =?utf-8?B?WU1GNlBXSVQxWEQ1UURSeWVNZm0vVW5LSnh2ZzBNQ2IrL1RqRW9DNnpNR0Qy?=
 =?utf-8?B?R3Fpci9hSHkyUUtuWmpQM3BXRWxUTWNFdjBjSUlSRFlIc3JrK3M3aW9SdVNU?=
 =?utf-8?B?TjNibFo0cjYyVy9JaGtFWk43MWsyb0VKUDFPMEUwdFJ2YU5BOG1vMThXdDhl?=
 =?utf-8?B?ZTFjRWtTY2hxMDI3ZVZRTTBMbXhxb3ViQWcyakhnKzRSL1psTXlJcmo4VEhP?=
 =?utf-8?Q?Xgfj/Pa1UTut0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(26005)(66946007)(966005)(6512007)(31686004)(66556008)(66476007)(7416002)(4326008)(54906003)(38100700002)(186003)(110136005)(5660300002)(36756003)(8936002)(8676002)(6666004)(478600001)(6486002)(6506007)(86362001)(83380400001)(31696002)(53546011)(41300700001)(2906002)(316002)(2616005)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0NiQld5OEE0a0lpVGZGUzJIamZxM3NhdC9wNmlBb2s5UGd5NzRGc2F4TjM3?=
 =?utf-8?B?ZlBEOUcyN3V3cGI0bEZPMzI0dmI5aGltTEdqNGYrK1dSYlY0cGFMbUNaK3Ax?=
 =?utf-8?B?WjlWMVZ5WkF0QnJWTm5zVVBZREFXbG1vUFBGUWhMcTlSMFM5NytGRnVaUDl4?=
 =?utf-8?B?enlQQTJpR3VROW1ENU11aUwrdStySHRDOXVZalUzazNPc0pHaC9BZ3hDNUYx?=
 =?utf-8?B?Z3dOd2NUQkZrTWZNMWtmZmFKcFpkbGxub2RheVNQS2NOSUFsWjdDWjNEZnZ5?=
 =?utf-8?B?S0tyV0xKY2ZKL1Y4eW9qYmRpSFVqQmlYSjMyNzN3azhpWVZFbVN2bDVxclNv?=
 =?utf-8?B?VXVGU25WaWpmRU0xMWxFbmZBQnNGSVVmMGdnV1dKSFJaNjg4RjN4VmdjbWhD?=
 =?utf-8?B?R2lIdjIxTU1ORTJQUzV0UzNUWmVzRzhEMEtETWdqV0d5TjhLaUhEK0hjVHpZ?=
 =?utf-8?B?ek5pT2dFK3VlTlc2elI4RGRkL08xZkNZY3VmTkNNVndTNGhYQ3Q5bjN1Y2Fh?=
 =?utf-8?B?Y1FCZm94R2pYbkhUeG00T3htdGxxNjlQbkRFd2JubmtkSkhFemtpbUxjeFA1?=
 =?utf-8?B?c1RrcXFZeUUyTUFQazZha1gyZVd2azZXczBZS0NkL2p4YllOajhCbjNaSjVs?=
 =?utf-8?B?Mk16VVo0N3kvMUpyV1MwWWhQSE1Xc0dKSFJOekRsajdRbXgwOFBUa0ppbW5L?=
 =?utf-8?B?NGtNRGtPYUtBdUlRYVZLRm9aQXJFV3ZBeEo1QjRyMFJBRTJWZUs2ajN3ejhF?=
 =?utf-8?B?ZDlZL0JLb0RVVm44bDVVRkN5MTBCZnAzRFl0elMrUFZ0MnhOWWhDcTdTZkVL?=
 =?utf-8?B?SFJBODI1MjhkR3RrZ29xWFhwZzA0YUpwZ2lNUGwyR0Y2MDZVbEZsN1R5RWIw?=
 =?utf-8?B?ZnVaYmlsdzhnUU5tQ2kzRDgwRWk4MWdJRVJBYXhBSEw3cmJUOTh2cC9CeTV5?=
 =?utf-8?B?ajBmR3cxR1BjU0l4VURwdVhvbHVsempEeDlRaUV2RjRueERpUTdUc0FOaU5r?=
 =?utf-8?B?VFFxdUxSZUxTL3dYcTNSejNJRHovS1ZTZmVCd1RnRDUrTDIvdG05ME53bmNI?=
 =?utf-8?B?SW54VXZVd1pSOG5DalJHM1czcWN1WGRncmp0U0s3Ni9ONENjcm9ZOE9TTTl2?=
 =?utf-8?B?KzlGODByMjhIaWJtTkZNTS9pU29FMzNOMVRxY1hIaVN1WXF4MUw1YS91NkhV?=
 =?utf-8?B?REN4d1oyejNvQ3pXckdnRHJmY0h1ZVpML3k1VWdKOXhMYkpIUkQ3aHdnMklD?=
 =?utf-8?B?dWEyR2FkVDdQcXZSWm1pSTBFMmIxYkU2RmxERktXOWJPSDliVFdnTlVtZ3J4?=
 =?utf-8?B?QUgyR05aTTVBbnREVjJmNUZacEt2bEpkNVhxUDJCdDNKbFNaSFA1NUhhYzdP?=
 =?utf-8?B?MFlzRGFrb0l3M0VjSWFDSzE2ODJkNkttdWszc2hJQnp5L3lmVklzYW50Z25v?=
 =?utf-8?B?SDloUDI1S0VpKzczbWZ6cWtZd2M5SWZJOTNHMnNIWGQzZ2FVOHVGOGhRWnp1?=
 =?utf-8?B?U3ZlWTJaT1paa3RTT2xvcHlqUU5TeGpWMlVDK0VZSzVhck45Y3NnVlVZK3J2?=
 =?utf-8?B?NndqcTFNS1JsRHYyUUQzdVRCdFNQT244WVVPZUpNcHpsVUJ4Zk9tWU1BNEJ6?=
 =?utf-8?B?Uk0xaStXY0dSSW9ybUJtK0Y3dU5qa3REQjFGemRTZldxMHRXQU91NGx6bVRV?=
 =?utf-8?B?ZGdrQitDMlp0ZkFBVE9oZ3lkcFVjNGpLekRKK1FaVzN3N0pHQm9xNU9JU2Fk?=
 =?utf-8?B?TG4zN0dWV3dlaENVYTJkSHF1cERubDQ3ZlpNZUlBSVFxSDZtMGM2NC8zM09m?=
 =?utf-8?B?QXoxcnd4S0N3OERaenAvSXVQeEVuYVkzSTkva3VQRUJTaDRvMVcrcENzLzlT?=
 =?utf-8?B?Qy9hREg2S2VtVEMzYlg0OS9MZXZPSmphcU55R1ViUUFrLzNqR1BmV0Zxd08r?=
 =?utf-8?B?TFhxQStrMVREUW13dmkrSlZTNXNQcEFkK3BkT3NKWUU1VFM2M1Faak1hWU9j?=
 =?utf-8?B?UVBSSWNWVGEwUXRTTmhoNGIranIycG83L3lzMW14YkorRm1PQ1BCTHBxTnhI?=
 =?utf-8?B?UmZlenUyanhlVE54dVZWWXd3OWJFWmlXUW9KNUJydW5xaXdxRTY3SFNSNWtn?=
 =?utf-8?Q?s+3lqDh8OsHcItUHVz5HyihZY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614b790f-8423-40e4-b2a0-08da6599ac4b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 13:06:32.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gune+DmQAn05QIsRAtJ257bIdKdnIqtFcS877vQDqOPih4PIjR1LrNUW14aYTzIji6P7D7XA8SzQtrBm3Dd1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/13/2022 7:47 PM, Guo Ren wrote:
> On Thu, Jul 7, 2022 at 8:04 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>>
>> On Sat, Jun 25, 2022 at 01:29:50PM +0800, Guo Ren wrote:
>>> On Fri, Jun 24, 2022 at 1:09 AM Dan Lustig <dlustig@nvidia.com> wrote:
>>>>
>>>> On 6/22/2022 11:31 PM, Boqun Feng wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Jun 14, 2022 at 01:03:47PM +0200, Andrea Parri wrote:
>>>>> [...]
>>>>>>> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
>>>>>>> is about fixup wrong spinlock/unlock implementation and not relate to
>>>>>>> this patch.
>>>>>>
>>>>>> No.  The commit in question is evidence of the fact that the changes
>>>>>> you are presenting here (as an optimization) were buggy/incorrect at
>>>>>> the time in which that commit was worked out.
>>>>>>
>>>>>>
>>>>>>> Actually, sc.w.aqrl is very strong and the same with:
>>>>>>> fence rw, rw
>>>>>>> sc.w
>>>>>>> fence rw,rw
>>>>>>>
>>>>>>> So "which do not give full-ordering with .aqrl" is not writen in
>>>>>>> RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
>>>>>>>
>>>>>>>>
>>>>>>>>>> describes the issue more specifically, that's when we added these
>>>>>>>>>> fences.  There have certainly been complains that these fences are too
>>>>>>>>>> heavyweight for the HW to go fast, but IIUC it's the best option we have
>>>>>>>>> Yeah, it would reduce the performance on D1 and our next-generation
>>>>>>>>> processor has optimized fence performance a lot.
>>>>>>>>
>>>>>>>> Definately a bummer that the fences make the HW go slow, but I don't
>>>>>>>> really see any other way to go about this.  If you think these mappings
>>>>>>>> are valid for LKMM and RVWMO then we should figure this out, but trying
>>>>>>>> to drop fences to make HW go faster in ways that violate the memory
>>>>>>>> model is going to lead to insanity.
>>>>>>> Actually, this patch is okay with the ISA spec, and Dan also thought
>>>>>>> it was valid.
>>>>>>>
>>>>>>> ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
>>>>>>
>>>>>> "Thoughts" on this regard have _changed_.  Please compare that quote
>>>>>> with, e.g.
>>>>>>
>>>>>>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
>>>>>>
>>>>>> So here's a suggestion:
>>>>>>
>>>>>> Reviewers of your patches have asked:  How come that code we used to
>>>>>> consider as buggy is now considered "an optimization" (correct)?
>>>>>>
>>>>>> Denying the evidence or going around it is not making their job (and
>>>>>> this upstreaming) easier, so why don't you address it?  Take time to
>>>>>> review previous works and discussions in this area, understand them,
>>>>>> and integrate such knowledge in future submissions.
>>>>>>
>>>>>
>>>>> I agree with Andrea.
>>>>>
>>>>> And I actually took a look into this, and I think I find some
>>>>> explanation. There are two versions of RISV memory model here:
>>>>>
>>>>> Model 2017: released at Dec 1, 2017 as a draft
>>>>>
>>>>>       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ
>>>>>
>>>>> Model 2018: released at May 2, 2018
>>>>>
>>>>>       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ
>>>>>
>>>>> Noted that previous conversation about commit 5ce6c1f3535f happened at
>>>>> March 2018. So the timeline is roughly:
>>>>>
>>>>>       Model 2017 -> commit 5ce6c1f3535f -> Model 2018
>>>>>
>>>>> And in the email thread of Model 2018, the commit related to model
>>>>> changes also got mentioned:
>>>>>
>>>>>       https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a
>>>>>
>>>>> in that commit, we can see the changes related to sc.aqrl are:
>>>>>
>>>>>        to have occurred between the LR and a successful SC.  The LR/SC
>>>>>        sequence can be given acquire semantics by setting the {\em aq} bit on
>>>>>       -the SC instruction.  The LR/SC sequence can be given release semantics
>>>>>       -by setting the {\em rl} bit on the LR instruction.  Setting both {\em
>>>>>       -  aq} and {\em rl} bits on the LR instruction, and setting the {\em
>>>>>       -  aq} bit on the SC instruction makes the LR/SC sequence sequentially
>>>>>       -consistent with respect to other sequentially consistent atomic
>>>>>       -operations.
>>>>>       +the LR instruction.  The LR/SC sequence can be given release semantics
>>>>>       +by setting the {\em rl} bit on the SC instruction.  Setting the {\em
>>>>>       +  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
>>>>>       +  rl} bit on the SC instruction makes the LR/SC sequence sequentially
>>>>>       +consistent, meaning that it cannot be reordered with earlier or
>>>>>       +later memory operations from the same hart.
>>>>>
>>>>> note that Model 2018 explicitly says that "ld.aq+sc.aqrl" is ordered
>>>>> against "earlier or later memory operations from the same hart", and
>>>>> this statement was not in Model 2017.
>>>>>
>>>>> So my understanding of the story is that at some point between March and
>>>>> May 2018, RISV memory model folks decided to add this rule, which does
>>>>> look more consistent with other parts of the model and is useful.
>>>>>
>>>>> And this is why (and when) "ld.aq+sc.aqrl" can be used as a fully-ordered
>>>>> barrier ;-)
>>>>>
>>>>> Now if my understanding is correct, to move forward, it's better that 1)
>>>>> this patch gets resend with the above information (better rewording a
>>>>> bit), and 2) gets an Acked-by from Dan to confirm this is a correct
>>>>> history ;-)
>>>>
>>>> I'm a bit lost as to why digging into RISC-V mailing list history is
>>>> relevant here...what's relevant is what was ratified in the RVWMO
>>>> chapter of the RISC-V spec, and whether the code you're proposing
>>>> is the most optimized code that is correct wrt RVWMO.
>>>>
>>>> Is your claim that the code you're proposing to fix was based on a
>>>> pre-RVWMO RISC-V memory model definition, and you're updating it to
>>>> be more RVWMO-compliant?
>>> Could "lr + beq + sc.aqrl" provides a conditional RCsc here with
>>> current spec? I only found "lr.aq + sc.aqrl" despcriton which is
>>> un-conditional RCsc.
>>>
>>
>> /me put the temporary RISCV memory model hat on and pretend to be a
>> RISCV memory expert.
>>
>> I think the answer is yes, it's actually quite straightforwards given
>> that RISCV treats PPO (Preserved Program Order) as part of GMO (Global
>> Memory Order), considering the following (A and B are memory accesses):
>>
>>         A
>>         ..
>>         sc.aqrl // M
>>         ..
>>         B
>>
>> , A has a ->ppo ordering to M since "sc.aqrl" is a RELEASE, and M has
>> a ->ppo ordeing to B since "sc.aqrl" is an AQUIRE, so
>>
>>         A ->ppo M ->ppo B
> That also means M must fence.rl + sc + fence.aq. But in the release
> consistency model, "rl + aq" is not legal and has no guarantee at all.
> 
> So sc.aqrl should be clarified in spec, but I only found "lr.aq +
> sc.aqrl" description, see the patch commit log.

The spec doesn't try to enumerate every possible synchronization
instruction sequence.  That's why the RVWMO rules are in place.

> Could we treat sc.aqrl as a whole in ISA? Because in micro-arch, we
> must separate it into pieces for implementation.
> 
> That is what the RVWMO should give out.

What exactly would you like the spec to say about this?  RVWMO and the
RISC-V spec in general describe the required architecturally observable
behavior.  They're not implementation guides. 

Generally speaking, I would expect splitting an sc.aqrl into a
".rl; sc; .aq" pattern to be OK.  That wouldn't introduce new observable
behaviors compared to treating the sc.aqrl as a single indivisible
operation, would it?

Dan

>> And since RISCV describes that PPO is part of GMO:
>>
>> """
>> The subset of program order that must be respected by the global memory
>> order is known as preserved program order.
>> """
>>
>> also in the herd model:
>>
>>         (* Main model axiom *)
>>         acyclic co | rfe | fr | ppo as Model
> If the herd7 model has defined that, I think it should be legal. Good catch.
> 
> 
>>
>> , therefore the ordering between A and B is GMO and GMO should be
>> respected by all harts.
>>
>> Regards,
>> Boqun
>>
>>>>
>>>> Dan
>>>>
>>>>> Regards,
>>>>> Boqun
>>>>>
>>>>>>   Andrea
>>>>>>
>>>>>>
>>>>> [...]
>>>
>>>
>>>
>>> --
>>> Best Regards
>>>  Guo Ren
>>>
>>> ML: https://lore.kernel.org/linux-csky/
> 
> 
> 
