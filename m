Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA750763F
	for <lists+linux-arch@lfdr.de>; Tue, 19 Apr 2022 19:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiDSRPd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Apr 2022 13:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbiDSRPc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2022 13:15:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDEC559C;
        Tue, 19 Apr 2022 10:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq6Po2OYCYuBpmvPbmoIlRGZXo7lIu83fPlIpTwrdPuEVBzZ7bSVg6tKRBwr2PpJFnscTrJsSG8925JiPga50sYTlWE0FQTTu1rOLAiZ6bFrQPHanQwjiphfm83Dg92+NL3WeyQ8iqrIxY1NSkJ2CEWSVwpwpXPOZHvazyMY9GpqRI9FBp7Jmfg7ywX57j8bOllCphcdvvBNHWgDl0IAtutSok4Ck1Jp/5iwWMwXs+1+NcQzjTOAK/a49jpulN8LfS0Ympj0JcsP3mbdXjtwfEoKtPLSkXLeiJeqvR2mHmLlmLevJ5WZ/YwwbzElFL+ABPv1gax3iU+FAtcWS6j3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PSp05J+jfqDQ8Tb/TuuYSWPO4ads6TbPQTzLdgrJ88=;
 b=ApruOvsDBfEuHkalo1xGqmIVgZPbwPWjdc4jkjkNnH6QNQcHpj1cDBJQ53zv4eJyoh9QEvSBoyl27mERVwSGh8tTJlH12w53NyHVi/7QT9FG6qpLNTMbGTvTvQSRd/AReQ8Tooxl/PCk/hsiSosJF4MRO2UBma6mwinxMoDdsfJ1ocvoF0z8HfteA39sqW/1g5qVU3a/NUPkQiN4mwWpv74qarh/0I12JlAELI4qBEIBtTUuqYiPDiv+lva4PVC/IDcPZs2Jeiyy86jx4sQawtDER2NbbTlb13Wzw+VPcnDabb+MlmdOje8/MzkGTMbh7WifB68TrZaXygfrJFlovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PSp05J+jfqDQ8Tb/TuuYSWPO4ads6TbPQTzLdgrJ88=;
 b=qy+HZRLU1+huYQIvMg3FGlG/AlniCgZdEeOlSGqG2hkoESvjeukK0AoXd9RxXSNldsucSwFMRIorKtLhZrLm9W1nwgEbZ8htAKToxoPf22vsPDfE+CKyy03qO5ImQxkdGIkDFdfgYR4YPqcUe9Om1ZWR/fj2r9m6YSBEDf42LDHn0ezq/MgmCmvLqZHX56EEmh2CqO4j43HqC0RD64qFNWRODnIctDb7tK6Z1+e7KvqT2U17FJRxTAD59S8qDjRoQhfn3qRErfa8gDgFZTwR582Io/OXskAKkF4VSrqczCJM4x6k0Ajosck3vX2FxgnL6mJybXYLYGLf+HZz6avtEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20)
 by MW2PR12MB2410.namprd12.prod.outlook.com (2603:10b6:907:f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 17:12:38 +0000
Received: from MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::18b1:f463:cb9b:82f0]) by MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::18b1:f463:cb9b:82f0%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 17:12:37 +0000
Message-ID: <3f7dd397-2ccd-dfa3-a0ec-dcce6cbc0476@nvidia.com>
Date:   Tue, 19 Apr 2022 13:12:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
References: <20220412034957.1481088-1-guoren@kernel.org>
 <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
 <Ylt6zqPgimmKpJzg@tardis>
 <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
From:   Dan Lustig <dlustig@nvidia.com>
In-Reply-To: <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0398.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::13) To MN2PR12MB3437.namprd12.prod.outlook.com
 (2603:10b6:208:c3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05564653-418d-4ebd-9a95-08da2227cd94
X-MS-TrafficTypeDiagnostic: MW2PR12MB2410:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2410D4084D87AAEF150B5DADDCF29@MW2PR12MB2410.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLjb9UhexdN5E2Vc2QZHKZNlOE3nqlOPIOdBZLDEamHeZ/OkoxcK8BwkgbItVCcIJkIxGA3VXLm/Vdeeijaa5id4jHaIoa2PXi+NXl4vtRTp9LkUBTknOkZbar+UsZS9oYyueEvBshDJ396SHl63RjnVpqItQlNe9GE8VS8FXaP14D9qRAjI7+hSd3p8RChBcf7ypgDQy42Df4qgcZdrt71ckHpTZVt7ISWfunufHAH2sPufP6Z/jntlBXb8KuMlpXrI8J5ri7sDNPdsxMCY0pepxceM+dnYyCszRzWU/66Sm6TADM37Q8tVMPE9h52gx+J842WafZxmBYmtSToQLahZWuR26btCBYZFw2MfOD/NZ37Yyayb51fl211iNi+j2mgOfikp9qni7bierDiCWZ3aGFOdpGcAxOuEpQW0RcJ3jy6IX/YyDpFtUb9S/SYFJ8A5TLXvNgzddYSHNTGKVEjho844P8+1lkoAc4gRFeOhEnuqisjobngcdODjTX5V6RWwGfT7H+cPgBpC8NLQSHE6JyFRS4cGxUICYjssGDqI0bA7fV33lJ5VlzMn8V5teVfpTjKz+GmdawzFt0B96Yyt3pY/T9KRBScPMmBCf/WoozjeaAPwio5xP6sjymhuA4wekBUtvv+Gr2kpqNb0vMqHAqDY0CWm0jczsMBPOu64UjbWZaHVVkadnsI8oymYdNkWqZVM6Yqj3fF3COy1ZNU+89qsIFQaYW1D5/SEC+fboQdlpQTdEh6AYAe9Y+H8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(66476007)(110136005)(26005)(6512007)(186003)(5660300002)(6486002)(8676002)(66946007)(4326008)(508600001)(31696002)(86362001)(316002)(7416002)(66556008)(38100700002)(6666004)(6506007)(54906003)(31686004)(36756003)(83380400001)(2906002)(8936002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3ErMFdpa2V5OXovQXNvQkV6ZUEyclpEekVYUVZZWi9Fblo2eHcvcWZwWlBH?=
 =?utf-8?B?M0cweUNLNnFZdlU1SWVhL1ZINy84dUprQVdEKy93TEhhV2FtemJpSXgvODZE?=
 =?utf-8?B?OU1kUnA2SUxQRyttT290eUMrMjhMM2pLeVpYeHdwaGxaTUJRZVduR1hyWG8w?=
 =?utf-8?B?dHM5UmxuTGh3ekUvZ05wcUFOc3M4RG5zcWxvRGxzck05SGRBT3BTSUpYeWQy?=
 =?utf-8?B?RHcvSTd5WDZWemU4OEhhdytCT0gybU9KZ0lDN0dFM0dtSngxczVQaitoODZl?=
 =?utf-8?B?OUxTcmVuQjZ5OXB4QXQ4Sk1odjdFNGltWG5WNU9ObmtUSUlyTXNEaTdrRU1m?=
 =?utf-8?B?U0RCMjdlNnBtKzV3SkRJOGxWVXEyZFdpOENIY1NpcmxTQzRnWGh6a0p1REo1?=
 =?utf-8?B?cThreHdZVGxDUWVrZnNzU3Q2SFhQdHN6YTlCVWVOMmZ5TW1NTzFUUXN5bFlV?=
 =?utf-8?B?Rkp1OW4xN3hEMlZZMjB2MFpiQUU0bUVSc1pWQVZHV210bDNrZWhvTW9Fc3V5?=
 =?utf-8?B?bmxUWU1pbkc2UkJ6NXgrTTZzUGZtTXY0bFZjUTE0aUx3UjBuWGhVMkt2MzN5?=
 =?utf-8?B?dGlVelh3TXNFZUNEbnpQWm5GL2F6NThKZTdxZkt1eXBDRzF1dXZTNjkvTExn?=
 =?utf-8?B?NDZPd1hrNGs4bjJoMzN5eC9tcUVWdTM1YUI0VGRLWGlaWUplRXozdDhjYXEy?=
 =?utf-8?B?UlVJeTZRRkRHZXEvamIyY1NaaStDRlVmZXBoYUJBSnBjbm5NN0ZaQW5TY0Vn?=
 =?utf-8?B?ODZ6WncrajZzeHVCVmxJakV1OXRHYVNFQ2ZWTkpPc2NYUEpKc3NDWFB3NmZO?=
 =?utf-8?B?M21MOHFiSGxNekc0YVJoT3hSUE1UR0FtUGMvTDAwK2FyRG0xWVJoczNyQWZ0?=
 =?utf-8?B?U1ZyYXMzWHgrTStvRTU1NFBiRCtaalIzNVBHbFdYak1Mby9lRmxJQ1M5MmEx?=
 =?utf-8?B?NnlGNHoxMVp1QW9qeEpsQ0RlUTdxT2tBSmlXNHlSaFdWcmlZMFNObXR5Snli?=
 =?utf-8?B?ZEtSVmxZaEtnNSswVmdPcWhQajhtQUpRZUJjUU0rMldKUVM3bnZqNjRIUWtm?=
 =?utf-8?B?L3V0NDNvZ2k1bC81bzR0VkNnaXVrOGRCVXVVb0dXbE9UdnVkT21zVkdHMEtx?=
 =?utf-8?B?ak1SZWpleFYrZlQ5SklTbkM2NnAzKzdkTjNNVnBZUWczLyt0R3AvWDZhZzhK?=
 =?utf-8?B?OWtZckozZ0ovNTBnWmRQQkRCYktsZUVaTVNtSUhxVlBqaTlvVDcvemFWajlo?=
 =?utf-8?B?bDV0UHdZZEdlMGpBRUJkZTlTMUpRTFR1K0hBZnF0NnJYZjRrSGlJV1pRMTNI?=
 =?utf-8?B?bHR1aE51SmdKMkZGZ2FQVys1dWszazFjaXp5WkE1dGN6S2NXMFphUzBKbUM0?=
 =?utf-8?B?eW9EK0lIdnZnNXN0VW1TTkVyZVJNL1BkU0JpbXhQdFB2c2NldXZFT0l0VDg4?=
 =?utf-8?B?RytxeGV6ZDhFcGVnY042ajdOcWxzdis0ZkRrVVJEa0ZtZWxrTUxQamx6SE9n?=
 =?utf-8?B?OVN3R3VCUGpZMXNTMWY1endGYWEvNGR5a3JnVzN6dXJjakJQKzhjR2RXT0xN?=
 =?utf-8?B?YWdkcDc1VXhyeVB4bVJDb2pQbGllMjF3c1d0OXhlM0FaNklMVFpFWDEwSzA2?=
 =?utf-8?B?ZFNNRnNqSlBkaVBFVzU2dnN5RGVrMzNVa0ZQYU9PSG4yTGM1aUdNem1CWGY0?=
 =?utf-8?B?VTJGakE4dGI5am9McUszMjJvUXpBRHFnek1DT044R0JXblJzSlFEWkhQWDRI?=
 =?utf-8?B?VnR2Z01SZUZmSDg1bUsyeWJhelB3WGk5L0RuSlN3UU40N2k3czY4NXBnYjkv?=
 =?utf-8?B?STVtSkowdGJQS1BMek1HZmpKUXV2ZDQ2K0xsTDFWeFJFaHJPU2xoR01tNDk5?=
 =?utf-8?B?aDJYUEZuOU5NbWVVdTdKY3lzT2J3eEtLQmh6eGpHVmpheG8xSUs1YmdaNmtS?=
 =?utf-8?B?Uks2QUNXWDlxRFcwdDNOOERDV1F1S29KZkF0bGZRckRqcmJQVTFzbnBkb2Nl?=
 =?utf-8?B?VjJsWWVhZTJWdHJSVjZ2ZHQxQkp2b1B1d3ExWnNRSE9pTjNJYmJ2TmJ2TWZH?=
 =?utf-8?B?WXFTc0UvbS8vakxTVGtvait5Q3NPSFZra3J0elhuNllmc3NFWkFWdlpPNSt3?=
 =?utf-8?B?VlRZenJIa0Z2ZHpvREhCY1VrYnJtdzdvZXIrMmx2TGVIVEV4NXNDSHFUc3Rv?=
 =?utf-8?B?SFNjVEZBU0pCdzNKUFpYQnd2RjQvaEppUm5FcmExM1NWa3h6YTAwMkVxcGtp?=
 =?utf-8?B?RVRuWTkra2JqMTFnVXZxTENYaWFrcEc5UXhHalVwTVNwVWo2QXBsdjhpbW9z?=
 =?utf-8?B?RXoxcE1QOWRZQmwvbG9XNHdNL3l3Sm44VzZpcG91eDhXU2lFdUo3dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05564653-418d-4ebd-9a95-08da2227cd94
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 17:12:37.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GBpB7tS9C+iQijMOK6Nk3d2esM9TIgf0JDxw3NpskaXPStWDHbmeZgi8q1aQ35sBP/DiEsAAybNLPO1C1kDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2410
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/17/2022 12:51 AM, Guo Ren wrote:
> Hi Boqun & Andrea,
> 
> On Sun, Apr 17, 2022 at 10:26 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>>
>> On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
>> [...]
>>>
>>> If both the aq and rl bits are set, the atomic memory operation is
>>> sequentially consistent and cannot be observed to happen before any
>>> earlier memory operations or after any later memory operations in the
>>> same RISC-V hart and to the same address domain.
>>>                 "0:     lr.w     %[p],  %[c]\n"
>>>                 "       sub      %[rc], %[p], %[o]\n"
>>>                 "       bltz     %[rc], 1f\n".
>>> -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
>>> +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
>>>                 "       bnez     %[rc], 0b\n"
>>> -               "       fence    rw, rw\n"
>>>                 "1:\n"
>>> So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is more proper.
>>>
>>
>> Can .aqrl order memory accesses before and after it (not against itself,
>> against each other), i.e. act as a full memory barrier? For example, can
> From the RVWMO spec description, the .aqrl annotation appends the same
> effect with "fence rw, rw" to the AMO instruction, so it's RCsc.
> 
> Not only .aqrl, and I think the below also could be an RCsc when
> sc.w.aq is executed:
> A: Pre-Access
> B: lr.w.rl ADDR-0
> ...
> C: sc.w.aq ADDR-0
> D: Post-Acess
> Because sc.w.aq has overlap address & data dependency on lr.w.rl, the
> global memory order should be A->B->C->D when sc.w.aq is executed. For
> the amoswap

These opcodes aren't actually meaningful, unfortunately.

Quoting the ISA manual chapter 10.2: "Software should not set the rl bit
on an LR instruction unless the aq bit is also set, nor should software
set the aq bit on an SC instruction unless the rl bit is also set."

Dan

> The purpose of the whole patchset is to reduce the usage of
> independent fence rw, rw instructions, and maximize the usage of the
> .aq/.rl/.aqrl aonntation of RISC-V.
> 
>                 __asm__ __volatile__ (                                  \
>                         "0:     lr.w %0, %2\n"                          \
>                         "       bne  %0, %z3, 1f\n"                     \
>                         "       sc.w.rl %1, %z4, %2\n"                  \
>                         "       bnez %1, 0b\n"                          \
>                         "       fence rw, rw\n"                         \
>                         "1:\n"                                          \
> 
>> we end up with u == 1, v == 1, r1 on P0 is 0 and r1 on P1 is 0, for the
>> following litmus test?
>>
>>     C lr-sc-aqrl-pair-vs-full-barrier
>>
>>     {}
>>
>>     P0(int *x, int *y, atomic_t *u)
>>     {
>>             int r0;
>>             int r1;
>>
>>             WRITE_ONCE(*x, 1);
>>             r0 = atomic_cmpxchg(u, 0, 1);
>>             r1 = READ_ONCE(*y);
>>     }
>>
>>     P1(int *x, int *y, atomic_t *v)
>>     {
>>             int r0;
>>             int r1;
>>
>>             WRITE_ONCE(*y, 1);
>>             r0 = atomic_cmpxchg(v, 0, 1);
>>             r1 = READ_ONCE(*x);
>>     }
>>
>>     exists (u=1 /\ v=1 /\ 0:r1=0 /\ 1:r1=0)
> I think my patchset won't affect the above sequence guarantee. Current
> RISC-V implementation only gives RCsc when the original value is the
> same at least once. So I prefer RISC-V cmpxchg should be:
> 
> 
> -                       "0:     lr.w %0, %2\n"                          \
> +                      "0:     lr.w.rl %0, %2\n"                          \
>                         "       bne  %0, %z3, 1f\n"                     \
>                         "       sc.w.rl %1, %z4, %2\n"                  \
>                         "       bnez %1, 0b\n"                          \
> -                       "       fence rw, rw\n"                         \
>                         "1:\n"                                          \
> +                        "       fence w, rw\n"                    \
> 
> To give an unconditional RSsc for atomic_cmpxchg.
> 
>>
>> Regards,
>> Boqun
> 
> 
> 
