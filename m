Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0DC5F49CF
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJDTnc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJDTnb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 15:43:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BA7659F2;
        Tue,  4 Oct 2022 12:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNEkoXBoo8OxfULHw5cFrYNmZiwCZ76hDU4Pysb/JxgxKGm6rydQeUmk7qgo0iT8XfTwIyMDagAZDQBZIf/d7eV7IE65Evzqv962LSf0GZE5On9oAENme1SdRbdWtAW57sZBLgbex3Ao6UmLzjoKLOkJaJ+u7r2Zp/+hAuSSDPiYB1jP4EFa0QBtrIB1u87NvHpH3LdCrR6rMlJYT7HGeBk3h0ZgKntIyPtTa9A60VpCAzRsT3HekBci2KBPtuhNB1pfDJAsKjdu54IdCJrsVX4BK0NBa5aaD4jvhBey/9kQmC9uaH8vPy4Wg/gnQhcYDbgBX9t8xuDHcZoaa/qeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOH/LEb2GfanRxMIbt9KpBCiit+uIMD1BTQ6MJ5CblM=;
 b=Th46XRor3AAIOJdWGFyFuZ6C+sFMMY/IYuafsQdTz/NK2GqQdfFP+OzL6xShk27rJ+kL6/rj0x0FNkIQZsMuxEhIevvgQaw/uxjEW0OkvIL5aozT/wv2wip8lbcUGcqMxJFCOuVrM5u4LN1szc3VgegPpvbK3b10Km2h1mOiNas30qlAVgYcrRf+gjWhS+WX29zNp4EdoC+EzpLegzIGpcVrysK/8tfJyEncIMlO9eMSLRVx/x/ej2IpqbBM2q1oJZvz3pQmEUMyXngwnFAGQ6LyC+h1bixh2DWMZ7e+C7b+aQ6f3Xao8eG0uSUFsoT/PNZ/rvzwBbGlAu31XabTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOH/LEb2GfanRxMIbt9KpBCiit+uIMD1BTQ6MJ5CblM=;
 b=G+Og3E/ffN4Zf+UwS23wdhfjD0cG72wFP1Jk2h8bszrlql069zeIWD0W5xyTBkO9BHu+3DZS+8UgwjZua5L0SCiyHIFo0Zp1IoJZCJAFvgJJRd1XV+ZFqFhVzXO8ZumFWxYg+dXozdDMTxwsYMLgF4o2zEy1VYkK6rhdPdJi/8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 19:43:27 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::9e7d:6fa5:ddb4:986f]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::9e7d:6fa5:ddb4:986f%5]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 19:43:27 +0000
Message-ID: <ae5fea4b-8c33-c523-9d6d-3f27a9ae03d0@amd.com>
Date:   Tue, 4 Oct 2022 14:43:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel
 CPUs
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, kcc@google.com, eranian@google.com,
        rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, Tom Lendacky <thomas.lendacky@amd.com>,
        "Moger, Babu" <babu.moger@amd.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-34-rick.p.edgecombe@intel.com>
 <202210031656.23FAA3195@keescook>
 <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com>
 <202210032147.ED1310CEA8@keescook> <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X>
From:   John Allen <john.allen@amd.com>
In-Reply-To: <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::38) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: 34873315-46ac-4f5c-d4a0-08daa640b525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6UwpSJ3PG4YNWU0k3cY19TkABVLTJfvmIvXYC0MucOp85tFfiup9Y/b28tElsmlA/KNURk38i5V8UjSuqsIY2GKwLFjyjSN5myjhn7V2WYTkGOyLx/dvVgiHGa4Hsf6j6CKoaJAqOgbln5EKdCm5XFhjfEdTlAb6Xe7sPhlO6N0ALfxh1NurSeFSKDY36wcQoo8ecrW1t7xOD40A4oQSW23LdkNDf4HsLuKhV6EWfBrDou68i8V2NrRTnIdqeo43F+ooIkKUZn3DV/jbuwtnt8Z417yiM2SA63jUC4fyErLirlmBK+01pR3O4H6MA2V42SHGWydvaH7rPBX4dQFzL1Q7v1e4lMZ/0Syd15+ZX0gFhuMfTqkGv7bMTr5gI6Cd59sxIVARc6Am7qQYrvlS9qmfUzXE6EK60ZQc4hi6nmtAIbzuC0uujazIsH4TwU1Sz0MbltIPF0nXkUqG7OxktygYjrnXKoS2aCj7diQz1lcjQGNnxu9c+vFLbD4XecfJpKY1CL5/DkamteUvcOUmtUMdwVBzQ79aMeuZGvsgHutLbp4UnoMWe9MmsVM7goHwxtaYZ0+p3joJSW1vkcfdWrMN0I1J/YZ5Di4nAS0NcwtecBWhdOrk2pkn0YRisk6MHlASUWoJuKBYN0U7V8wmqvYIzEFZG8R2MxJfufV3SIrmzVkPvqvw6PDCgAYWX/gcQw0FyVJxA2HVumLuT8JKRh72sYr0bdIG6xJs/gn98IlFB41Wm39iKmU5COHc59NNuwIzGL2Cs0aQqe0e/eKxVynAaqtNoLBMxRAiUXPGxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(66556008)(316002)(53546011)(54906003)(6512007)(6666004)(66476007)(8676002)(4326008)(2616005)(110136005)(478600001)(36756003)(31696002)(38100700002)(86362001)(6506007)(6486002)(186003)(66946007)(83380400001)(26005)(31686004)(7416002)(5660300002)(8936002)(41300700001)(7406005)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0QyL2VBaENaajI5WFNiUnBTdG5IWSsxZnBOMDg4NlhQbUN4aTRNQUxtYmdB?=
 =?utf-8?B?bU5NN05zNW5rRDAwY2dKYkNtTXUvWmdKM3NMd3NWUDBoNndPTitCRDd1TTVO?=
 =?utf-8?B?V013dkdkYmwwcFdyeVJ0WU1Jamw0a3l5TXFBNGxLWkgzOHNlNGt3djFLaW8v?=
 =?utf-8?B?T2FSWm5pWEg3QXBQMzlrMU90U2dydEhyYkNpYVRBN2Yzd2NEY0hsc2l5R0Vw?=
 =?utf-8?B?OHRjZzVjWFRyUW5DVU1RQTNTRlkzL0RtbFE2djQzYjlnaHRoK2ZzWWFSY2lm?=
 =?utf-8?B?U3pkZ2o3Zkd5T0dqbTJRZjVINnlsRTJlREN4dTZLOWlaUHJ5RUduNWhhdXBw?=
 =?utf-8?B?QUhidk5xWUpjeGRDTy9tRWxwSFFnSFYwcm5EdkxJNnZOTnh3Y2ZJb2pkS0c5?=
 =?utf-8?B?QzNGa3IwY0tqbjZOY3NodVN2MmREU1dvdjlWbjZFaGxiT09tRGg3UFI3b3Zv?=
 =?utf-8?B?bmhZRjVkUFF0SHJKWXphNVU3SWZZOEtvMUZMOGlReDBtZ1dhc2FmMmt3dUw4?=
 =?utf-8?B?MnhnZWxucTI0Vk5wVEZKOVBYVVB5U0E0cXRGajlWclNDYTQ0eHROd3hybjJG?=
 =?utf-8?B?aWdyWWdzZksrNUJPa21XN2VrQWpLWUI2anBRUzBKZGRGTWsvdFA0Skh2ZUI1?=
 =?utf-8?B?SjdocTc5VWU2b3R4aGE4V1l1Nlc0M0FpYVdxaitaVGI1OXozRk9sTzBhRWxv?=
 =?utf-8?B?UVNVVHB1bG12UmN3QVlIUTZQYnNFL1JYR0FsM3lETkNvQUdqS1NobStZSEpX?=
 =?utf-8?B?M3NQeE1UZDlrbHZNRlVNQ2Q0RjhmTGRvdC9Xa3gyd2NEQ1pCR3FEbzloVjBk?=
 =?utf-8?B?ZnQxRzFHRHA0dUIzRk5JN25EcEJHWWY0dUVvekpZRHkvRC9GbUlTYXZ2dVN0?=
 =?utf-8?B?SUY4L1hmbU1tMUxxNWp3ODVEejRqM0o5TlhUb1FNRjFCZnZOQzFmK0xXdUsr?=
 =?utf-8?B?bE5NZmQ2QkpSdENiVHRORlI2NllETzA0UnpCajVZZWlFMjNraytwTXVaSGtx?=
 =?utf-8?B?a3JMTkZMSG1RdzZsNlBIT0t2RWZxMysyZHczcnEwbE1wUXozVE5FcWxpYmJ4?=
 =?utf-8?B?eVdPNmo1R09MU09WSFFkZGh4d05mTzFhVGVNUUo4ZWtML005bmZYNGlUSlB1?=
 =?utf-8?B?VDNFZ1BoU2t0Tk5rcEhLTVJldFNQSWdZWVlrMzZvS0ZCR09MRGF4YU9sNGg1?=
 =?utf-8?B?Q3FyQVo5ZVl1a0hTUWphcUN1aUZBUlhRUXVoNGtYblMyNzBTUUUyYXhLNE5L?=
 =?utf-8?B?MlNGRnFuTDkyTDBmVUxlQlBvSUN2MkpXZUtlRHE4NCtPM3pkZSt5K1VWVys2?=
 =?utf-8?B?RmxMbDE1L0hGVE81YmlPRHlaWDl3UkkvdVV1dDZjUG1yd3MvMHhTZDduMUt1?=
 =?utf-8?B?MWM1VlFjWDRjb2JJRVltMlU2c2hRYkhERS85eSsrUmJjS1R2a0YyYW1WR0Jk?=
 =?utf-8?B?eVMzWXI4MkxBRk5JWjlLWlNhWUZmUDdGVG55K3lKbHhia1JBUFVwakR5Z3ZI?=
 =?utf-8?B?YkVDajBoTE4ra0I4NFhVSlliMHpsRFFUdEJGRkRJamxYRjdVMDlKaFd1bU5s?=
 =?utf-8?B?U2E1VzlwKzE5cmhZbWRnbWx2N2NBdnVTZFMvZVdxU2hYZ2hGTm5zT0xZM21Q?=
 =?utf-8?B?dm5MZUlGbEZKL0V4bzc3UDlSWmJsakdXT3owYW1mYkxxTnJOc3ErZTYzTTZk?=
 =?utf-8?B?anhnamJRYnc2UzVWd2ZrQXJwdWtWSUo1U0dqcXBCS3FKYUxBWU1yTi8wV2NT?=
 =?utf-8?B?OXlnVVI2SERwMklma2g0eVpFdUduNE1YT0kwc3FEcytHYmtqSlB6YkdWMmdt?=
 =?utf-8?B?dlNrNUhJWlRqb24rSC9JeFl4T1Y1QW5yVlJsZXpyV0V5NC9hc05saFplZmRB?=
 =?utf-8?B?bGFRbms0S3Rscnl0YlNQSDZNZXg1bnVJVE9rMnF6TFpnZUprN0RtYVdhWlhN?=
 =?utf-8?B?SkpSOXJBT1J2L1h0Njk0OXBVZUE3dTMvb29BTFpmZW5YcW15S2lkNnF4TnVz?=
 =?utf-8?B?eWJya1pLNEFpU0xRUXJ4ZWpPcHJHOGRNZ3JJaUhya3hDTGJtS2x4Umg4OHA1?=
 =?utf-8?B?R2JuM0VrMngyRjhxRmhZWGlMQU1Gb2ZrZGhWV3BLZVZ0RnVBdkhzZXA5MTFP?=
 =?utf-8?Q?tco43NZu0xqvri0c88kyidG3p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34873315-46ac-4f5c-d4a0-08daa640b525
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 19:43:27.6587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re1ULdxRQtzSmF5c8iZ57JyXBJiRDEy2WwcQAtA4Jz7WZOHgVBJswVUzjZWKIF0hoqDT6Wl/UFsVC3l+xdK+nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/4/22 10:47 AM, Nathan Chancellor wrote:
> Hi Kees,
> 
> On Mon, Oct 03, 2022 at 09:54:26PM -0700, Kees Cook wrote:
>> On Mon, Oct 03, 2022 at 05:09:04PM -0700, Dave Hansen wrote:
>>> On 10/3/22 16:57, Kees Cook wrote:
>>>> On Thu, Sep 29, 2022 at 03:29:30PM -0700, Rick Edgecombe wrote:
>>>>> Shadow stack is supported on newer AMD processors, but the kernel
>>>>> implementation has not been tested on them. Prevent basic issues from
>>>>> showing up for normal users by disabling shadow stack on all CPUs except
>>>>> Intel until it has been tested. At which point the limitation should be
>>>>> removed.
>>>>>
>>>>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>>> So running the selftests on an AMD system is sufficient to drop this
>>>> patch?
>>>
>>> Yes, that's enough.
>>>
>>> I _thought_ the AMD folks provided some tested-by's at some point in the
>>> past.  But, maybe I'm confusing this for one of the other shared
>>> features.  Either way, I'm sure no tested-by's were dropped on purpose.
>>>
>>> I'm sure Rick is eager to trim down his series and this would be a great
>>> patch to drop.  Does anyone want to make that easy for Rick?
>>>
>>> <hint> <hint>
>>
>> Hey Gustavo, Nathan, or Nick! I know y'all have some fancy AMD testing
>> rigs. Got a moment to spin up this series and run the selftests? :)
> 
> I do have access to a system with an EPYC 7513, which does have Shadow
> Stack support (I can see 'shstk' in the "Flags" section of lscpu with
> this series). As far as I understand it, AMD only added Shadow Stack
> with Zen 3; my regular AMD test system is Zen 2 (probably should look at
> procurring a Zen 3 or Zen 4 one at some point).
> 
> I applied this series on top of 6.0 and reverted this change then booted
> it on that system. After building the selftest (which did require
> 'make headers_install' and a small addition to make it build beyond
> that, see below), I ran it and this was the result. I am not sure if
> that is expected or not but the other results seem promising for
> dropping this patch.
> 
>   $ ./test_shadow_stack_64
>   [INFO]  new_ssp = 7f8a36c9fff8, *new_ssp = 7f8a36ca0001
>   [INFO]  changing ssp from 7f8a374a0ff0 to 7f8a36c9fff8
>   [INFO]  ssp is now 7f8a36ca0000
>   [OK]    Shadow stack pivot
>   [OK]    Shadow stack faults
>   [INFO]  Corrupting shadow stack
>   [INFO]  Generated shadow stack violation successfully
>   [OK]    Shadow stack violation test
>   [INFO]  Gup read -> shstk access success
>   [INFO]  Gup write -> shstk access success
>   [INFO]  Violation from normal write
>   [INFO]  Gup read -> write access success
>   [INFO]  Violation from normal write
>   [INFO]  Gup write -> write access success
>   [INFO]  Cow gup write -> write access success
>   [OK]    Shadow gup test
>   [INFO]  Violation from shstk access
>   [OK]    mprotect() test
>   [OK]    Userfaultfd test
>   [FAIL]  Alt shadow stack test

The selftest is looking OK on my system (Dell PowerEdge R6515 w/ EPYC
7713). I also just pulled a fresh 6.0 kernel and applied the series
including the fix Nathan mentions below.

$ tools/testing/selftests/x86/test_shadow_stack_64
[INFO]  new_ssp = 7f30cccc5ff8, *new_ssp = 7f30cccc6001
[INFO]  changing ssp from 7f30cd4c6ff0 to 7f30cccc5ff8
[INFO]  ssp is now 7f30cccc6000
[OK]    Shadow stack pivot
[OK]    Shadow stack faults
[INFO]  Corrupting shadow stack
[INFO]  Generated shadow stack violation successfully
[OK]    Shadow stack violation test
[INFO]  Gup read -> shstk access success
[INFO]  Gup write -> shstk access success
[INFO]  Violation from normal write
[INFO]  Gup read -> write access success
[INFO]  Violation from normal write
[INFO]  Gup write -> write access success
[INFO]  Cow gup write -> write access success
[OK]    Shadow gup test
[INFO]  Violation from shstk access
[OK]    mprotect() test
[OK]    Userfaultfd test
[OK]    Alt shadow stack test.

> 
>   $ echo $?
>   1
> 
> I am happy to provide any information that would be useful for exploring
> this failure and test further iterations of this series as necessary.
> 
> Cheers,
> Nathan
> 
> test_shadow_stack.c: In function ‘create_shstk’:
> test_shadow_stack.c:86:70: error: ‘SHADOW_STACK_SET_TOKEN’ undeclared (first use in this function)
>    86 |         return (void *)syscall(__NR_map_shadow_stack, addr, SS_SIZE, SHADOW_STACK_SET_TOKEN);
>       |                                                                      ^~~~~~~~~~~~~~~~~~~~~~
> test_shadow_stack.c:86:70: note: each undeclared identifier is reported only once for each function it appears in
> test_shadow_stack.c:87:1: warning: control reaches end of non-void function [-Wreturn-type]
>    87 | }
>       | ^
> 
> diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
> index 22b856de5cdd..958dbb248518 100644
> --- a/tools/testing/selftests/x86/test_shadow_stack.c
> +++ b/tools/testing/selftests/x86/test_shadow_stack.c
> @@ -11,6 +11,7 @@
>  #define _GNU_SOURCE
>  
>  #include <sys/syscall.h>
> +#include <asm/mman.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>

