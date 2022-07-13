Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F971573790
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jul 2022 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiGMNiq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jul 2022 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbiGMNio (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2022 09:38:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260D634A;
        Wed, 13 Jul 2022 06:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH44kr5mKDUWs+Psi2oHiCksnnosIjklgKELa0E0Klde1jw1CPHO6sqnLoK8RiduPBniccv4jZg3rgMtebqR8SA0tDtdgOLUCD14fjH5tlXhOmrzt2oVfTcBI7Ff6RjXMxJw9N8ooJaUqAVs5bnidwZnVWIxn+VU+o91NO3+VQ+epCSTUwM/bhdW96OBnFfabUjXqY2bKgozfE945VqYNm0YZYS57JW5W+OADAuNzQrDvuZKL189nmvqjuCy6lpbWx4NAFmYn9KHOXeoNlE+lc1qmyfQR1VDI+GIL0ljQ4TZXkQaI4CMveJF0PGDggHzoZvmY8yBgUGyCy82rujMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYyJqw0p9Hmifk22a5F97TFVkIBLUaHpD3XjkgTocao=;
 b=YBLdBV0iitK/tTjqCwqU7dQzE1w4K8zkB1jPYsHSmV2a1VxMwKy6LIvqQr6IIGSBOpJVa6eDqQoncWAAfRdiffcJIjRxk8q4e/Mtnee6eYqwImgwcmHxdbjBjGJhAkGd2F4YDj80tT94q26mTThdKcsJLPmEXSqqyK3Wd0OGBualI+wq7IkxvznahHiNfGlLIVDBBWL9kH6IrU7NcR3hsyDnAFyiCCxUGjstm6FnmAmJsigEYtdXk90AZdsSfQu7BvIkDZ3iP2GXev1/KnoQkvXwkoKQLlj1lUxlNVSEK0PQ2WZRe0aw1ORRao6xm/VTY1nfpaOCbGAeU7DtAt4fsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYyJqw0p9Hmifk22a5F97TFVkIBLUaHpD3XjkgTocao=;
 b=YWXQuDsZiaOAchSx9CVAFEUDbJ1DZMtm8OrcKbpgavDOtDKvOlqgatjLr3lg2RLWoL9FfkXkrOo7kDmwBCx2ddlXaS0AOoS6B2QdaD3JE7OR5iU9DKVgYB1tRG2v2F9/rMi2dGWgLyc45rH4MYNedEYOL1QWi8GDcpY3KqHjfyWX/VvwiBeHREQ84ixAQX2tIh+MdPT8BJdX6VkFR1d9IClKy5lyrcYwAzdvdr7zFwogc/gAgLeI3WsvOTFZXqqkB2WMMd19OM7XfrWzxqruFVqnNIM832RUwydoLEdAPmleIyf99lUdtXSbeXR2opWyaxQLfoFafQuMbneVWGL3SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 13:38:40 +0000
Received: from MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::4966:ba15:be03:dcd1]) by MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::4966:ba15:be03:dcd1%6]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 13:38:40 +0000
Message-ID: <a9c31668-eb44-d8c1-1c66-eb1affcae3ad@nvidia.com>
Date:   Wed, 13 Jul 2022 09:38:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops with
 .aqrl annotation
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>
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
From:   Dan Lustig <dlustig@nvidia.com>
In-Reply-To: <YsYivaDEksXPQPaH@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:2d::35) To MN2PR12MB3437.namprd12.prod.outlook.com
 (2603:10b6:208:c3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db370ab3-a83c-4d39-6970-08da64d4ff0b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUlMMkN0RHhRdFRqVlZrWU1GRzhNQlRkS0kzMzAycU9PYU9DeGwzeU8rQXNn?=
 =?utf-8?B?N2NnYWRrdW0zNkVvQWxUSjdSZVQ0RWttajVqaHhiU0RnTG5lNjEyUVJwTmpG?=
 =?utf-8?B?N2pUYytUUm51OWV6TmVNOHRtQUlzcTAvRklPeHVOaHQxTk5ZY2VTWk84Qjg2?=
 =?utf-8?B?d2h2NnVVUzBVRFp3ZVVqK090RTZaWmhRbWxnOTJEU0QxZlhrdExoRWFyUGh4?=
 =?utf-8?B?VmFMMk5WcTdGakJKcGp2WFBBNSswalNaN2R1ay9yZ0hMYzBILzY2d3NVbHhM?=
 =?utf-8?B?VGd4YTl6LzN4MXF6dEFlSHNmWlBxbEFKQitVbk9uVlZOTHd6WHhQZlRsaXZN?=
 =?utf-8?B?NlltNHliSHY0alRCOVBRVFBUUmhhM3FkQ0Y3NHRYUndsWXBFWEg0eVR4TlFk?=
 =?utf-8?B?Y251THBmRURtSVd4THp1c3BhaVlCL21MQWNWZVdOODN0Z0pIY0VGdW41WXBa?=
 =?utf-8?B?UkFMVE1CUko1N3dmWjJCV3hWY0xtdE1xWS9pM1E4QU9XdG9RckVVUXF6eVZI?=
 =?utf-8?B?cE9HRTJUc1ZoVXorLzBxMU5uZUEvdXN1STEvOE0zTlltZWlHekxuZjYybmxR?=
 =?utf-8?B?NWYraTlQell5dmJHV3ROTFExMS81S1dwRzZlZ29ieEg3L1VnUU9pa2VUNzNs?=
 =?utf-8?B?NDVQUkN6K1pVUHowMlFwNjVVb0Fmbno0VVZyTVRZcGxzeTNscFJwbXpHOEQz?=
 =?utf-8?B?ZWZaM3FnUVBUMGlLRFhvQXhtYS9jTkwrc0dQQnNlWkU0MzdFajJsZTFoYjNq?=
 =?utf-8?B?cWlnWmZJc0hiN1FHRTZzanVPRzRMVTljRVZ4ZnZWeFhMWWpYRG4rN29Rbnhn?=
 =?utf-8?B?ZThFcEpGRmplUE4rdndRSGdXcGJUUzlLdTJmZVdaR3h1Z3hzNVkxbVhPb1Vo?=
 =?utf-8?B?VmFZZElZV0I2L3lKWGMrOVRTN3FGaXNuY2o5QURIdE5Bd25CZlFOR1NKZVBw?=
 =?utf-8?B?NHMyaVlOWXlwK2pHOGZHdXF6THFGMkwyMHZsV1RheWZPZlk4ZkE2ZnR4NlNs?=
 =?utf-8?B?elNTcWk1bkV2aUJQWVVxYzUzc1JaZnVPVUw1TG1jSmFMNjVEMlJrQ2NMMW8x?=
 =?utf-8?B?d1N5aGwwYnpmVkF4VEVkaG5vNEx5M3NFWVJYTmg4bGlwckNmWFVsWDhkaGNV?=
 =?utf-8?B?OEtEMm1nZEE5QVF5WFExcXZXMlRtckFkbnhjWnljamlZankvRENFZVBxQldz?=
 =?utf-8?B?cnRHaURMcEY3RldMcCtUYzJDYmN5dUdqQmt4eXFkc0N1ZEFQcjRBQWdObGty?=
 =?utf-8?B?cGttN1l6UVVhRUNnM1hEdENFTGN5SXdIY0Mvem55djJVU0k1YTZmVUY5Zkx6?=
 =?utf-8?Q?9qe0udRl542r0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(2616005)(6506007)(53546011)(4326008)(8676002)(66476007)(66946007)(66556008)(36756003)(31686004)(41300700001)(26005)(6512007)(6666004)(8936002)(7416002)(316002)(5660300002)(38100700002)(186003)(478600001)(6486002)(31696002)(110136005)(83380400001)(54906003)(86362001)(2906002)(966005)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFFnblJXS1ZXenJSSjZ3dC9LKy8zZ3d6TlBWN3dFQ002WEtsWDNIUTVCNG5X?=
 =?utf-8?B?MFAzVWhGUHM0aFZBOHpFVi85cS9XNEZxU0hrQzJ1dEVuODI4T0k2TlZZZFZZ?=
 =?utf-8?B?Z0ZQNDRoWlNINXRId0x3YUR6U2MrM1R0SWFKNVlzZHVyNjQybmQ0K2JOd2Nj?=
 =?utf-8?B?a1NGUmR3a24xazNSeXpZNkd2RW51WHFuakVHdkdXNEY1U2N5NGhyZUxTbDBD?=
 =?utf-8?B?emY4KzRRQTljTjQrZGJXRmVXWm8xRnBmRDZ3MGNYdXVhTVZZV1dHZ21sRklL?=
 =?utf-8?B?WHFqUDk4QVA0VXFxRXRZMFNZbkZpOERGN04yODRBL2p1Skd4Y0I4ZytDTzha?=
 =?utf-8?B?d0QxOVBpZ3R3TWJiRm50NGlyaUlxVHZEYktrZzlTUHY4bW53YU0vRFNLQXNK?=
 =?utf-8?B?UlUrUlV2bHBIeTBHZ1MxQzNacmpPRzhPd05aYkRsN0xKRTdyajJuWUkxOHlj?=
 =?utf-8?B?dVJZYXBkd3FmNks5VmxCc1FmOXczRkdpd3lZSGRZcHNicG5oWUUxWmZDNDlL?=
 =?utf-8?B?THNRQ1l0citwOUxqM3hRZGc2VGJnNXNRak9wTGU4MFgralBnbEdxam5PQUN3?=
 =?utf-8?B?TzZWNytBd0xHMmRZMnJCRlFSSmFmWlFQWVI4MVlPNy9sOE55NmFhYTEvbGtl?=
 =?utf-8?B?aWsvTHpxNGN2aGNoKzFJNGVUdFV3UTZmei9Rb1NOM2JudmxkT0NRc2hiZm5C?=
 =?utf-8?B?bmV4WXZkOHREVWVtNGtTTUpKVllXcG13Zlo2K2I3Ulh0L20yT1hwNmJ0WE5s?=
 =?utf-8?B?dUxEWHliQjlKc2pYSXFjTkNTdGhZSjZzS2JBa2hyMTFFRkNHU2dRcndxdVJV?=
 =?utf-8?B?bkRVdEdhekZ6L3RDek1kQlBRS3dDYkhlS0taZE8yZldLamdNVU50WHJQb1BQ?=
 =?utf-8?B?NlBMVldWcHdZUEdCNHVqY051V0RwMnAwbGo3U1FIcVBOek5NazI3ajRDNldQ?=
 =?utf-8?B?SU96RG5hNStnTlVHZnRYeVk4YkhnNDZ0N2FmMU1oMlk3UnpwUVAwd3lWSUdx?=
 =?utf-8?B?cGdpVHZMRys3TmJmTlVBVXdyQzdjS3hMcXkzUWNpMkxUcWtjaVlVMFBlLzJF?=
 =?utf-8?B?YnFSaXBJQ0Q3NVlYRVNwY0dyV3FCZFdKUW9YOFpYQVBHL29EM1NoRVpUMFhh?=
 =?utf-8?B?b0pyYXpIY0FpUW9kbGFnUHdsckxtNnRJUjRGd0NrMWZvbGo1c3RVRS84MDR1?=
 =?utf-8?B?OTZjeFpicWkrRURTdDVKdTZEa1o5czFqNFE4emRMN3EreGNLa1MzTXM1eFpj?=
 =?utf-8?B?c1I2WEpoK1QxRWVIdDQ2N28wUmlybDNQWHpBVFlxc1g5TEpqa01IUytaU080?=
 =?utf-8?B?Rmg4c2o4N1picnRPRDloVFhoMkdmWXo4NDIwUFF3MTg5ZVAyZnRNVk9vVlVJ?=
 =?utf-8?B?dGFZQ3FxTExyT2tDODNKQ2hUbzcrM3NzV2s4K2wycVRWUkNjSVpsVUU3UDk3?=
 =?utf-8?B?NVRQVmVUeG5tNkMzczNWbklnRWxNckdTTWZvZEwxckFjMDNRd1dnUklyZEhF?=
 =?utf-8?B?bDdUbk5iRnRRa2RpS1pHMDBnbE9ienMrcVU2VHVuTlNYWE5ZcG43VldMWXBo?=
 =?utf-8?B?VmVrUnBKNUMrSVNIOHRGUU1IZy9nK1VQbDVMeUVnRWliUWVKcnBKQzRvelow?=
 =?utf-8?B?bTB5cTlIc3M2VDBuVWVHMzMyQjZrYXRjUkpWME5xa0pXRlNCWXM1b3VNMFdV?=
 =?utf-8?B?enB4dGM4elJBVFp2WWdkU2IxeVNyY3Q5UmJuMEsrby9XVGsydGU4Wm03RTN4?=
 =?utf-8?B?bndxRWNqL05XRHlOZ2NiLzVVbVIrZ01CQkhvbWZDbUduWlM2NTdkUjhTS296?=
 =?utf-8?B?SkpkbGpvSEZqdkVwUG1pUDcrUVVFOGJ6MHp0T0R6eURGRGYxV2RNaVNiK3Jh?=
 =?utf-8?B?eVE2bHV1NmJWbzlHRGpCd0tONGZYSVBvM1NDNEJzd2ErTGpwQVlFc1JrVm9q?=
 =?utf-8?B?Z2p6dy8xbGpIT3gxQUpTNm8yRDhuMFJRbGlQQzdCQmlScGNOcGJIMzFBSWhm?=
 =?utf-8?B?NTg5OVJYNFB3R0VkZTBBZjF3Rmh0QWdlOS9ZMjN4MkIxZ2RYRVNiNVZmaG5o?=
 =?utf-8?B?L0hrc2R3cy9rSzJoLytZUC9ETjR5eVNKRGhiakNwUU9aV3RRUTkyNm9ReWZi?=
 =?utf-8?Q?8U6W4Z+uFwnIUBUaMkKckIDAk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db370ab3-a83c-4d39-6970-08da64d4ff0b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 13:38:40.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DswOCu4ik2EVJMAQe7m0Xc0VAEH7HaWOOGiqYEXGYJJ825Q262HgominsQOnCuksgXPuIWMVMQU1lOKIXzKygw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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

On 7/6/2022 8:03 PM, Boqun Feng wrote:
> On Sat, Jun 25, 2022 at 01:29:50PM +0800, Guo Ren wrote:
>> On Fri, Jun 24, 2022 at 1:09 AM Dan Lustig <dlustig@nvidia.com> wrote:
>>>
>>> On 6/22/2022 11:31 PM, Boqun Feng wrote:
>>>> Hi,
>>>>
>>>> On Tue, Jun 14, 2022 at 01:03:47PM +0200, Andrea Parri wrote:
>>>> [...]
>>>>>> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
>>>>>> is about fixup wrong spinlock/unlock implementation and not relate to
>>>>>> this patch.
>>>>>
>>>>> No.  The commit in question is evidence of the fact that the changes
>>>>> you are presenting here (as an optimization) were buggy/incorrect at
>>>>> the time in which that commit was worked out.
>>>>>
>>>>>
>>>>>> Actually, sc.w.aqrl is very strong and the same with:
>>>>>> fence rw, rw
>>>>>> sc.w
>>>>>> fence rw,rw
>>>>>>
>>>>>> So "which do not give full-ordering with .aqrl" is not writen in
>>>>>> RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
>>>>>>
>>>>>>>
>>>>>>>>> describes the issue more specifically, that's when we added these
>>>>>>>>> fences.  There have certainly been complains that these fences are too
>>>>>>>>> heavyweight for the HW to go fast, but IIUC it's the best option we have
>>>>>>>> Yeah, it would reduce the performance on D1 and our next-generation
>>>>>>>> processor has optimized fence performance a lot.
>>>>>>>
>>>>>>> Definately a bummer that the fences make the HW go slow, but I don't
>>>>>>> really see any other way to go about this.  If you think these mappings
>>>>>>> are valid for LKMM and RVWMO then we should figure this out, but trying
>>>>>>> to drop fences to make HW go faster in ways that violate the memory
>>>>>>> model is going to lead to insanity.
>>>>>> Actually, this patch is okay with the ISA spec, and Dan also thought
>>>>>> it was valid.
>>>>>>
>>>>>> ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
>>>>>
>>>>> "Thoughts" on this regard have _changed_.  Please compare that quote
>>>>> with, e.g.
>>>>>
>>>>>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
>>>>>
>>>>> So here's a suggestion:
>>>>>
>>>>> Reviewers of your patches have asked:  How come that code we used to
>>>>> consider as buggy is now considered "an optimization" (correct)?
>>>>>
>>>>> Denying the evidence or going around it is not making their job (and
>>>>> this upstreaming) easier, so why don't you address it?  Take time to
>>>>> review previous works and discussions in this area, understand them,
>>>>> and integrate such knowledge in future submissions.
>>>>>
>>>>
>>>> I agree with Andrea.
>>>>
>>>> And I actually took a look into this, and I think I find some
>>>> explanation. There are two versions of RISV memory model here:
>>>>
>>>> Model 2017: released at Dec 1, 2017 as a draft
>>>>
>>>>       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ
>>>>
>>>> Model 2018: released at May 2, 2018
>>>>
>>>>       https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ
>>>>
>>>> Noted that previous conversation about commit 5ce6c1f3535f happened at
>>>> March 2018. So the timeline is roughly:
>>>>
>>>>       Model 2017 -> commit 5ce6c1f3535f -> Model 2018
>>>>
>>>> And in the email thread of Model 2018, the commit related to model
>>>> changes also got mentioned:
>>>>
>>>>       https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a
>>>>
>>>> in that commit, we can see the changes related to sc.aqrl are:
>>>>
>>>>        to have occurred between the LR and a successful SC.  The LR/SC
>>>>        sequence can be given acquire semantics by setting the {\em aq} bit on
>>>>       -the SC instruction.  The LR/SC sequence can be given release semantics
>>>>       -by setting the {\em rl} bit on the LR instruction.  Setting both {\em
>>>>       -  aq} and {\em rl} bits on the LR instruction, and setting the {\em
>>>>       -  aq} bit on the SC instruction makes the LR/SC sequence sequentially
>>>>       -consistent with respect to other sequentially consistent atomic
>>>>       -operations.
>>>>       +the LR instruction.  The LR/SC sequence can be given release semantics
>>>>       +by setting the {\em rl} bit on the SC instruction.  Setting the {\em
>>>>       +  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
>>>>       +  rl} bit on the SC instruction makes the LR/SC sequence sequentially
>>>>       +consistent, meaning that it cannot be reordered with earlier or
>>>>       +later memory operations from the same hart.
>>>>
>>>> note that Model 2018 explicitly says that "ld.aq+sc.aqrl" is ordered
>>>> against "earlier or later memory operations from the same hart", and
>>>> this statement was not in Model 2017.
>>>>
>>>> So my understanding of the story is that at some point between March and
>>>> May 2018, RISV memory model folks decided to add this rule, which does
>>>> look more consistent with other parts of the model and is useful.
>>>>
>>>> And this is why (and when) "ld.aq+sc.aqrl" can be used as a fully-ordered
>>>> barrier ;-)
>>>>
>>>> Now if my understanding is correct, to move forward, it's better that 1)
>>>> this patch gets resend with the above information (better rewording a
>>>> bit), and 2) gets an Acked-by from Dan to confirm this is a correct
>>>> history ;-)
>>>
>>> I'm a bit lost as to why digging into RISC-V mailing list history is
>>> relevant here...what's relevant is what was ratified in the RVWMO
>>> chapter of the RISC-V spec, and whether the code you're proposing
>>> is the most optimized code that is correct wrt RVWMO.
>>>
>>> Is your claim that the code you're proposing to fix was based on a
>>> pre-RVWMO RISC-V memory model definition, and you're updating it to
>>> be more RVWMO-compliant?
>> Could "lr + beq + sc.aqrl" provides a conditional RCsc here with
>> current spec? I only found "lr.aq + sc.aqrl" despcriton which is
>> un-conditional RCsc.
>>
> 
> /me put the temporary RISCV memory model hat on and pretend to be a
> RISCV memory expert.
> 
> I think the answer is yes, it's actually quite straightforwards given
> that RISCV treats PPO (Preserved Program Order) as part of GMO (Global
> Memory Order), considering the following (A and B are memory accesses):
> 
> 	A
> 	..
> 	sc.aqrl // M
> 	..
> 	B
> 
> , A has a ->ppo ordering to M since "sc.aqrl" is a RELEASE, and M has
> a ->ppo ordeing to B since "sc.aqrl" is an AQUIRE, so
> 
> 	A ->ppo M ->ppo B
> 
> And since RISCV describes that PPO is part of GMO:
> 
> """
> The subset of program order that must be respected by the global memory
> order is known as preserved program order.
> """
> 
> also in the herd model:
> 
> 	(* Main model axiom *)
> 	acyclic co | rfe | fr | ppo as Model
> 
> , therefore the ordering between A and B is GMO and GMO should be
> respected by all harts.
> 
> Regards,
> Boqun

I agree with Boqun's reasoning, at least for the case where there
is no branch.

But to confirm, was the original question about also having a branch,
I assume to the instruction immediately after the sc?  If so, then
yes, that would make the .aqrl effect conditional.

Dan

> 
>>>
>>> Dan
>>>
>>>> Regards,
>>>> Boqun
>>>>
>>>>>   Andrea
>>>>>
>>>>>
>>>> [...]
>>
>>
>>
>> --
>> Best Regards
>>  Guo Ren
>>
>> ML: https://lore.kernel.org/linux-csky/
