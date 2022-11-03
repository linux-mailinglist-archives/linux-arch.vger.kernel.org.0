Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE1618651
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiKCRjo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiKCRjn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 13:39:43 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D27260E;
        Thu,  3 Nov 2022 10:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxpBgPnKjfKj2RGsozKOSxUr+0PS0+p00Cq5zXEw8BAlXKan+9X29yz69NBqpRVXdY5HsTmdiONh01rufgdVlsvgaDgPrk6GPuxtk9yB+mv9EPq6qScrWRA+DHqrO8YKWOdw+Vqq0qdBO0iIjvIpV4ykOuehiS4fnvz61DM3wr9gzPyYxmmMmwjiUozHHBrmPWONwDi/Wni/AOt+F7N64J1ybQ5H5FYFbLQv+16AUwQxOhjnHkRhgDBdD55YbNd2PmfxVoMRVlMH0KRhWqEoTGftQ/MvwzvuceZxTi/Tt38WStelXkhNKgRe0oPvM1U1XjtJeMLAus5DZkx4jjTCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSngz2I4PwpvXW47MQzBJGQyQnBbTiZvA03dmN9YNsE=;
 b=YriCHMYwyFG4SZSN3/EHp5y+XpPgRo+KKrlX3l/BBbQJKAU+I1lwefWKic0md5BIWDGQH9zFRBGR5ycibF4oUVfXKBpUipUPJ7CfeP1TqJhgoFKz46jKaNufdxEPOiftMpaMeLfasj2Pg03sg9jttqM4lHfSuxO/gq6XGH2J+dDqRYcJ1Se4xoKGEMaSlzFCid3vq0yb1EfqEN8iz7wt+J1KDpzjtxJILCBMufZs6g18WNToqc1zZc0lR6E2g/lYm5HR9FBzYOXzTp5x9gExDpaMQl/oi8BNVDaILnEa/qczFu5jdj0fIU67IklTgcjG7NiFtxwfr9jN1A5Z/ltUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSngz2I4PwpvXW47MQzBJGQyQnBbTiZvA03dmN9YNsE=;
 b=WBbumcw/KbaQ1hTByhPuaArKC8KTRJ0t6X80CPLokaBq7eao9OWhzsUIYBV0KVccFWBMTILbsAGou5lLpggkO9eK8at6rLN2FB48Lxc+WREoZ6uKWw6AlOgRD4BSfL1c4mOl4nwRIW+BggE7wT0b409F4MfdNTIBJaNBq9q+hhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 17:39:39 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7f07:d964:4d46:fa3b]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::7f07:d964:4d46:fa3b%9]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 17:39:39 +0000
Message-ID: <67da8e11-c9b1-3445-bf7d-3854cea72b7e@amd.com>
Date:   Thu, 3 Nov 2022 12:39:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "nathan@kernel.org" <nathan@kernel.org>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-34-rick.p.edgecombe@intel.com>
 <202210031656.23FAA3195@keescook>
 <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
 <202210032147.ED1310CEA8@keescook> <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X>
 <ae5fea4b-8c33-c523-9d6d-3f27a9ae03d0@amd.com>
 <9e9396e207529af53b4755cce9d1744c0691e8b2.camel@intel.com>
 <YzycjLUVh/WhPtKa@dev-arch.thelio-3990X>
 <73904829-0BAC-41BA-BFD7-025B1645F698@zytor.com>
 <8429968c22a9532a6855a8fd9e4dd0a7f2344408.camel@intel.com>
From:   John Allen <john.allen@amd.com>
In-Reply-To: <8429968c22a9532a6855a8fd9e4dd0a7f2344408.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 641e47d9-7067-4236-5076-08dabdc261bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKYx3MZQCFw4h8V3F8QU8qUcXQmW0mf8SdIFVDJyTIKTWl624XyD+Vq1ca3BP+s24QjVLqZpKOM03mw9ZeaAML8r0MmOZlv9PFiwA1t4C3vh94+9ht3O66YcQfQ/pM4t2lY6B9ftjKaYFxleBbMLFhEXuhYFWPNtDWXBKfSdS8BlbKqlYDCnGz9wuQNQg551/+FPAYpu4CnPJeF8jSl5kLOLj9BSmlYTpfAF0EtEBPODNs2odpTrFrOqhpBWPqYd4N/jpRheEIvBgjhxZluIsQCaU+i1NaWLzzfL64R8os2F+vKJ/vLOXZPjyB/CEZiwJIJMpQoIckNVOUYeAg99cK3/JP3y7asFNDPGqw9XtP/DxbKxwowvDSlN1ybB2ReUa3z7Godo2B3bHJzF17N7MgxwrJ87DNZpxLRkQMFjwyhiejuIFKGCXaDCyYqaknF3xG6rdASeYMlsTeeaLUk3jXB4gixZEVV45A/KsSrL6Pc72y1Ne/81newywccyWCr9eLOs4aw+kkqRAgR/td29JRqsrkoGEvnbqaFnz1jCL+R4+KOSTgl0oGp21lvEGkFk4J0FGpE8z338jKxTRysZEJM5SAAdp2R1hXgZ2ZZ3RVWcys8FH+6AoHRYcC26RCZAnm8JSqV85RvGQNFrGxFHzABIPXa40XEIG0kGynrlmZVTFHWQN621UXRuDIjJbm20Ore3kHU1WlRoLPYIhekGQDC6G83se8ldIH+u8vW/+ECpZ/wd2jiRnMDVNXuDkhn4ZbdkYcZwhRQT0gkHM+E9+g2laMoQlNGYa3oGK9DyAoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(186003)(31696002)(66556008)(6666004)(36756003)(4326008)(86362001)(66476007)(66946007)(8676002)(6506007)(7406005)(7416002)(110136005)(44832011)(2616005)(5660300002)(8936002)(478600001)(83380400001)(38100700002)(26005)(41300700001)(6486002)(6512007)(54906003)(316002)(53546011)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekU2THRud3RTTmUxbEZXMVF3SkovZUhUNlFTMWU3L3hXRDg4L1hOMGprb0lW?=
 =?utf-8?B?ak1VOHhCUzF3c21PNzhOWEROQjdScDFmR0Q4M3lLY3B6TmgwWWRPMlQ4Rzln?=
 =?utf-8?B?LzQzN2tXbzhjV1hBSjU1c2VVZVFvRkFYMWRQVyt6MjVHRHMzc3NrWDY1RG53?=
 =?utf-8?B?T2g2S05mL2ZGZHdzbEtqSUh4SUc0ai9HWGU0dnhvUXYrVUE4V3o2T0c0dXZw?=
 =?utf-8?B?ZVJ5QUI2TDlsZlEwOWRZMTdYMjRLZ0M1UlRLVHlFNFpiTXRoL3lCVUhWZEt5?=
 =?utf-8?B?ZmUvNDhwYTExaGZnbzd6ZFZmYWQvUVpmNVljNmRvUmI5Sk9JWitPWG13YTY2?=
 =?utf-8?B?TGxZT0dyR1VCenVaZmlkQ2xXWGZ1eVBmU1d5dnh6eFZQUTNMREYxZ2lpRUxL?=
 =?utf-8?B?UkVnY2UybXhhN2RzbVNvVXVnYUJsNlVwWmg5UVhzNVlETU8relc3Q2lSTlpP?=
 =?utf-8?B?ejg1dVREbmQ4dG5LN04xNXlOMUhNeFBLUDhqdjUxRit5VjBWM1NoL2xIdlV4?=
 =?utf-8?B?L08yU1BkMzhqdlQyZEhyU2FONTRNZVRaYmJRMmVwZ3pwelEyY1ZVSFV2NHBt?=
 =?utf-8?B?WWZ6NEF0VnhHVXA2cDB5RGNKOGhYQUJBbzg1TFNMeHdFRCtkNGNpKzNIQ2NK?=
 =?utf-8?B?bktPVFRNUzdTMnkxQS9hK3A4SENkLzkwYktadzdNQ3BiMkFsdlJCVW9sMGlW?=
 =?utf-8?B?UGV1U2xna0NuOHR6L1RNbW9IMEppamszckxQRzVzM29pTUcwdm9KbUwraTVl?=
 =?utf-8?B?dWF2eHdhWnRxVk5xdnBDejdtZ2xaN2xsRCthU09STEd0K1RkSnZzRGxrcHph?=
 =?utf-8?B?bk13bU54Zmg1OTZ6M2NoRDVqOW90NytNdFQ3akdJbExUZ3BxSm5VMGpLTk9o?=
 =?utf-8?B?OTJUbklTbGdSZU9EdkNkZ2hGWHA1dHNWRGlQYk44bDUxa3JiOWRtT1VDVnJp?=
 =?utf-8?B?ZVg4UGVESVBhR05TZjVKYUZqY0lOWHozZkxoQjAyK3dSL0VRdnA2V1VDOFgy?=
 =?utf-8?B?V1BISWNwMEhyeHM5bUlpK0dMaGgwcG52VEg2V2drMWhHMEVuVFhFRWJvNzUv?=
 =?utf-8?B?VkREZ1cxaWFhMjdQbVVMM3YwWGpPOHAyZkV3bEZLTTVQOTc3YjdxVndpTGRm?=
 =?utf-8?B?eUc1aVF0a2FhUy9TZ1hNbUZZZmVJdDdsd0NtUXZSQWZ0NG51bFd1Tm9wNG9M?=
 =?utf-8?B?U2VHbjJ5K09UUTFNbm50YnQ0RzBybTRhbks2NmMyTGU5WFZNOVlxeEEzMjRk?=
 =?utf-8?B?OXRYQlpIOVNUVkFMdFpONkd3aFpXNkkyMEwyc1dsTFlmclp1WDR3VWVDWWRX?=
 =?utf-8?B?cU0wM3RGY1F4R3ROeHJ0S3pkR09BelhDeDJGQzc4UWxqdmJMenpJL21JREln?=
 =?utf-8?B?MUo2L0tGOTFHZ3JKZ2ZtSlNvR2thTGtmcXpWdm95RlFmcnV0eEcrTjAxK2Uw?=
 =?utf-8?B?bTJwaDRmamhBTjRQTmVBa3BXYlpWS2paTGkrOGJ5VkhVQkFBSmc0QjhBbjVY?=
 =?utf-8?B?SGQrOW1wUzhjWHVOeGFNQ0tEbXlVWkdHbzN0c1NOczdGY0pneFdodGprMjhB?=
 =?utf-8?B?bDA0aCtZTWVSSHhGU2NUcXVPNzBtMTRHbS9DOVBLdDV5bzl5aERsanVENk1I?=
 =?utf-8?B?NFZYVEJyOG9zQXFWVnppMzh0MmR6cnB5LzJYbGNvUW9zaGFoQjlqUjVwUnE1?=
 =?utf-8?B?WDZxZUp1ZndwNlVyTUhOeFRUcStSN3ZyVjZFcjc5S0hiRVhvRHpSVUZ1ZEtl?=
 =?utf-8?B?a2hsRUdiU3VCN2wvUThIVGVGQkVId2V4MVBXSVJzVTRZdW83N3EvbjN5QTVu?=
 =?utf-8?B?QWJkUjFoM0RUOHR0cFZqOWh2ZWE3SHdmNndRc2hQT25ycmk3aElxVmJIVG1F?=
 =?utf-8?B?Z2JWRHk1VnVsbVdNY3RXbzZrbFZUaTdQUzAvQ1VPV3ZzQXZrbDZvRk5wSUxu?=
 =?utf-8?B?UE13VzRZbkE4MG5RdStaTTVETkkwYldNZ0xVT1BieWE2eWxudHZYWGFHRFlQ?=
 =?utf-8?B?NHJndEc3VkZyd0R3UVZPV00vcmxjQ0hMaDRtc0RDQVZCU3doV1dlM2FKaFpp?=
 =?utf-8?B?Q0xPY1Jub1k0MncwUXVydityNFlqWFVzQ0lxOVN6dlhpMW1XTldySDBwU1po?=
 =?utf-8?Q?tdogqIYIuopETkjiWdBSyxW4w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 641e47d9-7067-4236-5076-08dabdc261bb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 17:39:39.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1NrZqAvXryaeCrLdpxdUec2gfjHfPtShN7d2zLzieojQNKsxS3FbH8ig2jJA07t5A6vcp6x5d+0lilDH+QbcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/4/22 6:24 PM, Edgecombe, Rick P wrote:
> On Tue, 2022-10-04 at 14:17 -0700, H. Peter Anvin wrote:
>> On October 4, 2022 1:50:20 PM PDT, Nathan Chancellor <
>> nathan@kernel.org> wrote:
>>> On Tue, Oct 04, 2022 at 08:34:54PM +0000, Edgecombe, Rick P wrote:
>>>> On Tue, 2022-10-04 at 14:43 -0500, John Allen wrote:
>>>>> On 10/4/22 10:47 AM, Nathan Chancellor wrote:
>>>>>> Hi Kees,
>>>>>>
>>>>>> On Mon, Oct 03, 2022 at 09:54:26PM -0700, Kees Cook wrote:
>>>>>>> On Mon, Oct 03, 2022 at 05:09:04PM -0700, Dave Hansen
>>>>>>> wrote:
>>>>>>>> On 10/3/22 16:57, Kees Cook wrote:
>>>>>>>>> On Thu, Sep 29, 2022 at 03:29:30PM -0700, Rick
>>>>>>>>> Edgecombe
>>>>>>>>> wrote:
>>>>>>>>>> Shadow stack is supported on newer AMD processors,
>>>>>>>>>> but the
>>>>>>>>>> kernel
>>>>>>>>>> implementation has not been tested on them. Prevent
>>>>>>>>>> basic
>>>>>>>>>> issues from
>>>>>>>>>> showing up for normal users by disabling shadow stack
>>>>>>>>>> on
>>>>>>>>>> all CPUs except
>>>>>>>>>> Intel until it has been tested. At which point the
>>>>>>>>>> limitation should be
>>>>>>>>>> removed.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Rick Edgecombe <
>>>>>>>>>> rick.p.edgecombe@intel.com>
>>>>>>>>>
>>>>>>>>> So running the selftests on an AMD system is sufficient
>>>>>>>>> to
>>>>>>>>> drop this
>>>>>>>>> patch?
>>>>>>>>
>>>>>>>> Yes, that's enough.
>>>>>>>>
>>>>>>>> I _thought_ the AMD folks provided some tested-by's at
>>>>>>>> some
>>>>>>>> point in the
>>>>>>>> past.  But, maybe I'm confusing this for one of the other
>>>>>>>> shared
>>>>>>>> features.  Either way, I'm sure no tested-by's were
>>>>>>>> dropped on
>>>>>>>> purpose.
>>>>>>>>
>>>>>>>> I'm sure Rick is eager to trim down his series and this
>>>>>>>> would
>>>>>>>> be a great
>>>>>>>> patch to drop.  Does anyone want to make that easy for
>>>>>>>> Rick?
>>>>>>>>
>>>>>>>> <hint> <hint>
>>>>>>>
>>>>>>> Hey Gustavo, Nathan, or Nick! I know y'all have some fancy
>>>>>>> AMD
>>>>>>> testing
>>>>>>> rigs. Got a moment to spin up this series and run the
>>>>>>> selftests?
>>>>>>> :)
>>>>>>
>>>>>> I do have access to a system with an EPYC 7513, which does
>>>>>> have
>>>>>> Shadow
>>>>>> Stack support (I can see 'shstk' in the "Flags" section of
>>>>>> lscpu
>>>>>> with
>>>>>> this series). As far as I understand it, AMD only added
>>>>>> Shadow
>>>>>> Stack
>>>>>> with Zen 3; my regular AMD test system is Zen 2 (probably
>>>>>> should
>>>>>> look at
>>>>>> procurring a Zen 3 or Zen 4 one at some point).
>>>>>>
>>>>>> I applied this series on top of 6.0 and reverted this change
>>>>>> then
>>>>>> booted
>>>>>> it on that system. After building the selftest (which did
>>>>>> require
>>>>>> 'make headers_install' and a small addition to make it build
>>>>>> beyond
>>>>>> that, see below), I ran it and this was the result. I am not
>>>>>> sure
>>>>>> if
>>>>>> that is expected or not but the other results seem promising
>>>>>> for
>>>>>> dropping this patch.
>>>>>>
>>>>>>    $ ./test_shadow_stack_64
>>>>>>    [INFO]  new_ssp = 7f8a36c9fff8, *new_ssp = 7f8a36ca0001
>>>>>>    [INFO]  changing ssp from 7f8a374a0ff0 to 7f8a36c9fff8
>>>>>>    [INFO]  ssp is now 7f8a36ca0000
>>>>>>    [OK]    Shadow stack pivot
>>>>>>    [OK]    Shadow stack faults
>>>>>>    [INFO]  Corrupting shadow stack
>>>>>>    [INFO]  Generated shadow stack violation successfully
>>>>>>    [OK]    Shadow stack violation test
>>>>>>    [INFO]  Gup read -> shstk access success
>>>>>>    [INFO]  Gup write -> shstk access success
>>>>>>    [INFO]  Violation from normal write
>>>>>>    [INFO]  Gup read -> write access success
>>>>>>    [INFO]  Violation from normal write
>>>>>>    [INFO]  Gup write -> write access success
>>>>>>    [INFO]  Cow gup write -> write access success
>>>>>>    [OK]    Shadow gup test
>>>>>>    [INFO]  Violation from shstk access
>>>>>>    [OK]    mprotect() test
>>>>>>    [OK]    Userfaultfd test
>>>>>>    [FAIL]  Alt shadow stack test
>>>>>
>>>>> The selftest is looking OK on my system (Dell PowerEdge R6515
>>>>> w/ EPYC
>>>>> 7713). I also just pulled a fresh 6.0 kernel and applied the
>>>>> series
>>>>> including the fix Nathan mentions below.
>>>>>
>>>>> $ tools/testing/selftests/x86/test_shadow_stack_64
>>>>> [INFO]  new_ssp = 7f30cccc5ff8, *new_ssp = 7f30cccc6001
>>>>> [INFO]  changing ssp from 7f30cd4c6ff0 to 7f30cccc5ff8
>>>>> [INFO]  ssp is now 7f30cccc6000
>>>>> [OK]    Shadow stack pivot
>>>>> [OK]    Shadow stack faults
>>>>> [INFO]  Corrupting shadow stack
>>>>> [INFO]  Generated shadow stack violation successfully
>>>>> [OK]    Shadow stack violation test
>>>>> [INFO]  Gup read -> shstk access success
>>>>> [INFO]  Gup write -> shstk access success
>>>>> [INFO]  Violation from normal write
>>>>> [INFO]  Gup read -> write access success
>>>>> [INFO]  Violation from normal write
>>>>> [INFO]  Gup write -> write access success
>>>>> [INFO]  Cow gup write -> write access success
>>>>> [OK]    Shadow gup test
>>>>> [INFO]  Violation from shstk access
>>>>> [OK]    mprotect() test
>>>>> [OK]    Userfaultfd test
>>>>> [OK]    Alt shadow stack test.
>>>>
>>>> Thanks for the testing. Based on the test, I wonder if this could
>>>> be a
>>>> SW bug. Nathan, could I send you a tweaked test with some more
>>>> debug
>>>> information?
>>>
>>> Yes, more than happy to help you look into this further!
>>>
>>>> John, are we sure AMD and Intel systems behave the same with
>>>> respect to
>>>> CPUs not creating Dirty=1,Write=0 PTEs in rare situations? Or any
>>>> other
>>>> CET related differences we should hash out? Otherwise I'll drop
>>>> the
>>>> patch for the next version. (and assuming the issue Nathan hit
>>>> doesn't
>>>> turn up anything HW related).
>>
>> I have to admit to being a bit confused here... in general, we trust
>> CPUID bits unless they are *known* to be wrong, in which case we
>> blacklist them.
>>
>> If AMD advertises the feature but it doesn't work or they didn't
>> validate it, that would be a (serious!) bug on their part that we can
>> address by blacklisting, but they should also fix with a
>> microcode/BIOS patch.
>>
>> What am I missing?
> 
> I have not read anything about the AMD implementation except hearing
> that it is supported. But there are some microarchitectual-like aspects
> to this CET Linux implementation, around requiring CPUs to not create
> Dirty=1,Write=0 PTEs in some cases, where they did in the past. In
> another thread Jann asked how the IOMMU works with respect to this edge
> case and I'm currently trying to chase down that answer for even Intel
> HW. So I just wanted to double check that we expect that everything
> should be the same. In either case we still have time to iron things
> out before anything gets upstream.

Hi Rick,

Sorry for the delayed reply. After asking around, I think you can safely
assume that AMD will not create Dirty=1,Write=0 PTEs in rare
circumstances and shadow stack should behave the same as Intel in that
regard.

Thanks,
John

