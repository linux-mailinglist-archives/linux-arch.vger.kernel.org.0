Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AF558416
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 19:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiFWRkC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 13:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiFWRjY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 13:39:24 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF92862C06;
        Thu, 23 Jun 2022 10:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jshkuSfCIVNiVWM/ZOLnGbd9inGB5QOFmXdWleDbESitF4Bm9iDwuX7BLGyI8bmsU/3WaZZTuSfy4iqy3rhObAtsIi5R1VKsWrMaXg0MtJqG25Ro2Y/Ltt5MnLbqR4mojGO3LxJr1DYDidxuotiOPXsrngeBfbNQyxlTathAWJH/WTwq0nxvhCZv4IdmdgJHGh+QK8/5guCiyTHPLKeJJqPRMma2wW+47G3vsF4qiXM43AmpFtFAXg8K3iaZcCkBPAznsgk0GACxgoOCH4CBpOFr9qj6mXP3sUsuhGw7Tf6AGGKEHTknDfIM51CgF9WSlHE77nu1WEYGiB0h72EiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYbgrSFrhvGWW+RzOTE4cXKoGn9hIRNFXQJEszRuaUc=;
 b=Xo8i77FahL3t879dgv0PDz8VssJj+ixcmmbwVZzB68bAVonSDdIf/j8Oyh27Yy5NAivz3eRNWnWde3+r8CrULIIFIbPqafvXwFLsOMMyZG1meMe9DD4zPbttL3EjR83vbFBK+jfqC7c9IBUpjYC5bZwgANZeSOsG0T5chT5uY5xB+fnajQoHCZ9xK7roqf+rzcp6tE5Y5Fv58yW3KOH+2t4kqTbLZWSB4pChd/UfTy8aDSwP9NbizRFtffM+6IUvaW74EEtJAVjghg7MU3LeEEX67N5xv+sbEEq+vce6LF1dOx+0ozRzNnxfKCjBhS/A5Vf/mxciglplxiCneU+Uig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYbgrSFrhvGWW+RzOTE4cXKoGn9hIRNFXQJEszRuaUc=;
 b=Gf/2xvHtZ7v47k+N0O5bhrmLg8YhTGU0h5tQYW+DUoO3nZMyLdd4Ig7DVFDnDdXcMOzY9a/+RG/f2ZuMXld4i6h2nu8F58zDm1jMP5KQXjP5JOeSHkOruUxlwUbrM5/IXFyGAcVdF+LSCGlmQgFDqQHlT7g3AfDNHLiHHM8dis+uNtDmNc685gKO+EzOBsESGqh5UOFdJDeYIhtG3YPI1IGITavJ3g5XFb7OY1PKf8WsWq7pTWnw5FbPLsQqlVAv8G1aZJjTqzwEOEH089W/fdyeud9bzLXlrDe6ngirg8OzkgWDT6ttx2CwJVMHAvIHW/m9c+CCtkqFsnfnNK0ebQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 17:09:36 +0000
Received: from MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::9d83:45f6:174f:73c]) by MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::9d83:45f6:174f:73c%7]) with mapi id 15.20.5353.019; Thu, 23 Jun 2022
 17:09:36 +0000
Message-ID: <fd664673-c4cc-be8f-9824-5272c5c79b40@nvidia.com>
Date:   Thu, 23 Jun 2022 13:09:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops with
 .aqrl annotation
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
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
From:   Dan Lustig <dlustig@nvidia.com>
In-Reply-To: <YrPei6q4rIAx6Ymf@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To MN2PR12MB3437.namprd12.prod.outlook.com
 (2603:10b6:208:c3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83909f70-8a7e-4845-f15c-08da553b2665
X-MS-TrafficTypeDiagnostic: DM4PR12MB6040:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUg2Z3ZML05UWDcrRlRHL0Rna1FWYUFCNzFlQUZYYWRKdy9DOEpORnZ3bmtX?=
 =?utf-8?B?T2pTc2hvMDBNakJXTHRhWjRCQVFjdWFLWjVxVG1iTEo5c2FMZXNHSitYcC9O?=
 =?utf-8?B?ZUhyTDNaRWQrSmZGUUs3T21jejdNUDhxeFkycXNiY1ZMelk3MDN6SUgzQXJa?=
 =?utf-8?B?MWdkeExSUUU1WjZlbytEQTlQdE9EVUhrdTczTnNiWExYUElEajQ5d0FlRWNi?=
 =?utf-8?B?N0I3UjNXeUZoSHpsaUpYd3duM29VTWdSNHBHZ0s5NEs2RXNXTFd6SCsrdVVG?=
 =?utf-8?B?aFpzUVpGZEN1NWgyYkc1Q2NVZnVIRHYxL2ZLREpnTFBXMHFkS1pudjNwM1Nu?=
 =?utf-8?B?QUVQZWdCQUtta1RIMmlJWmFjOGR4K1cyeTZYajhkWU1PRG5WUTZzZXVUQzRB?=
 =?utf-8?B?SjVqazZHMDlFNTFINmJoT1M2Z0lNcnEvRFJZOHNVYmZKcDM4VnkyQWlMejJR?=
 =?utf-8?B?ckdZZ2pRT2FwUGRnWVMyQk02YllzMlJMbldsZ3RpbUR1NUx3cEI5YWVZL0RM?=
 =?utf-8?B?anYvbVBRdkJpcmdPTkUyOG9xZ2F6MDQyT1lQZWw3bUhXU2JhbjFwMENYdXBN?=
 =?utf-8?B?aU1MVG5Bci9yOXpTenpMZGxhdlRaZitYM1BjOXpvVThzdERjQktyMjhoQURp?=
 =?utf-8?B?azFNa2ZPUHJhL0tVTEhmdkpzZlpKY1VnWWZIY0s1dW9TNHVhZGpWbWVVb2t2?=
 =?utf-8?B?RjlTNlhMaWJDRFVLVTd3Yk5seTdqeGRsVUJna1ZNNHJhVXBQUEtOdGJ3MDhZ?=
 =?utf-8?B?MXYzejBIMHlGRm9Cd0hueUtHbnlQRVNJUnZXR3JUbmtZbG1xRTFkblhiN3pm?=
 =?utf-8?B?SlFIaTdhNXhueUNtQys3bWdmMWhVQU5DWEFmRndpNXRpcWxyQWUyMjFYYTVU?=
 =?utf-8?B?My9jTVlTSzVUbmNCYThRdTdDS1VRMVZnNGZtQ1R4T1V3SmI1WTFRaHp1eXpz?=
 =?utf-8?B?TTF2UlM3RDVIODNCaGRBN1BHeDROT2NBMkRDaTBOVmc2Tm91dk1heGFJeW85?=
 =?utf-8?B?aFVBbEkrdys5SVRXbnUwZ2N2ZDlXZnY1U2tadUNsa3V5WXdWTi8vSTdQNWZ5?=
 =?utf-8?B?ZDg1cmMxZndnN2s1UTI1cjRLVGdRVlpLQklET2tBRWVoK1lsa0tJMW5OYnFR?=
 =?utf-8?B?OUZpQXBsQWorazRkdDJEaUtmNUlXbjB5WUNUNWVTWXdXZE1MaFVsTWpEd0sv?=
 =?utf-8?B?eGVGSVNBNDgrYWp6QlBvemU3OHpSa1c5czIvZWdsdXlkL2ViMEhCUm4zcDVh?=
 =?utf-8?B?c3NKZXUzUnIxTWt3SWd1ZkpQUmtWa3FDcHI3d2tzZTBzck14dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(478600001)(5660300002)(186003)(36756003)(83380400001)(26005)(6666004)(38100700002)(6506007)(316002)(6486002)(31686004)(66556008)(4326008)(66476007)(53546011)(8936002)(7416002)(966005)(66946007)(86362001)(2906002)(31696002)(54906003)(6512007)(110136005)(41300700001)(8676002)(2616005)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0s1YnR5UFdzR3hZSnVRcUxkZjlIVytPYzVKREFYZldCajJlWENWR052Y0p6?=
 =?utf-8?B?VjRpZ0lyK0xjSHZEZEUxR25lSUFpdloyNHBmU1FPenYwSE14TjVSRG1wUlVD?=
 =?utf-8?B?R2hHS3lxZ1kzV1pXdXNkNHBrazIrb1FXWlRSNUV6S1FnSnN4VjZCS0MybVpX?=
 =?utf-8?B?eFExczNObUJVYTZ0YlZWZGozR1BJdVQxUmdzY01hNG1VOFE3ZWNoMk5HaTl4?=
 =?utf-8?B?ZDAya1JuRnlyR2lHeitPVGRxTkpiRCtINmVPRnM5V0FPNTRBWURoYXc3STAz?=
 =?utf-8?B?U3EyTUk5UlpVYWdnR0M3TWxpT1piRXhvY1lqWUZLN3V6aUdyc05Za3ZxZlV0?=
 =?utf-8?B?R3IxNWRraVZCd0NXY0twcFo2RFZPWVUwVTlmOUswVkNvdVYwck1SMUpjTnRE?=
 =?utf-8?B?eDlHTit6RmZBSTFJMjNweXo4YjBVRnFWeGdudDJwRTlDK3JXZkc4UWdDUHd3?=
 =?utf-8?B?YnBzME5ZUmJmREVheVl5NiszOCt6Z3c4YlQ0SWtiMmp2ZWczZ0xkSFNScDNW?=
 =?utf-8?B?Y05GY2lFdjdrM09tK1dXNStyVjRjdUpQcVp1Z1VLbitPS2lSTHI2dGRkQmFL?=
 =?utf-8?B?N0RWQVFWcmpzMXNmVDFOWmR1b09RZ1Ntdkd2UUM4Rk9VZTgwTlNMRVhJN1hs?=
 =?utf-8?B?K28rck5tbGJZdHBqUEhuSmpGbWV0N01pYWJiaVZUbElFZkFqYTJ0d0hRRCtC?=
 =?utf-8?B?bTIxaU1LSkY2QytxVGQ5VU5xMTRTMll2L0x4UzkrMGJaSnRZeGpQOUJLK1N5?=
 =?utf-8?B?K3Z0aGNKRTk2anhuczFZNEJZSzN1SjZILzg1S3hxNlo0WXFTL25nSFhXdkcz?=
 =?utf-8?B?dFQ0L1JENWh3UDBwZDRHei9mby9paldrMGdUaFdpTHZpbjhmZmFZS1Vzazh3?=
 =?utf-8?B?VjFmL2VPU0tpUU1PRTlQZHcrZ0tvaStMQ29qZmhUS1F3M0dHdndOVU5kdnlZ?=
 =?utf-8?B?aGFNNHBBdm9YR1pMYnAzMHo0R2dxNGZjTUJuV0VSamljTHhNcm8ySUhIdGRC?=
 =?utf-8?B?Wm1jVFQzMnVOb2d6Wm9PczJSeFY2TUFLVDZ4TUYrbm5mc3R0TEt1R3dVSHBy?=
 =?utf-8?B?OW9BTHpSa3diRGdSYXNvZ2gyR2p2MDFpK2RyTjdmL3Y2Y1NMSmJDaWJlcnQw?=
 =?utf-8?B?QnJHSG5ucTJ1NlpDVlhPSm9XNFlzQU1SaG02MXhmTkNjRmRkZXY1dHBDZXpi?=
 =?utf-8?B?dmIyOHhYdnEybkhmMWJSWit0eUlFMXZQbWNKUHMrQmxYZTZuU0dKTHE4MDZL?=
 =?utf-8?B?eG4wTEJ5R3oyTUkzQU5xZ0tHbHlEMTZheWVqbDk0Q2RZU3RLZ3FybnN1Z01B?=
 =?utf-8?B?QVFrS2ZscjJ3d2RlR2EyamJWZEx3TFUvZFJnVzltUGtOUFdFNGpTVDc1YnpV?=
 =?utf-8?B?YzJDYkozNXVUUjRGSjVTK3poOXJyTThsMXpxaURsVjdFbHNJd2xSSWY4TU5S?=
 =?utf-8?B?MlZmMGJlWjRRZXg1c3dpbzM4cWRhaUVVNUdkKzMwcVVtNVBzZjRtWFNlZjZL?=
 =?utf-8?B?bzgyOGwzN1dFVzRaNng0ZzZ4cTUzK2tGN2VWRkVCa084dnJhT3RzOWRYYjg2?=
 =?utf-8?B?UzhyNFo5M1A0TEkwS0xaSm8yZXoyMXdoYmM0VjNPWTF6aHI3N1pGL2tZQ2tP?=
 =?utf-8?B?RUp6YkRuakZLUVVpcG1peEFmSlBDTlZYc3I3NzdKN2E5KzlDWTY1YjE3QVE3?=
 =?utf-8?B?SU1OdkY4WXdySStybHVrR1pHUVBGcTN1M3M4eDAvZjkzdGVaOHpmQ05XZDhV?=
 =?utf-8?B?a05HMjhZNWMydUdpQ2U2TEJkKzFHczZTZmdMTG9ZQ2huaTExT1VQQ0tTZDVD?=
 =?utf-8?B?T3JkZytJblBmRE5PUFQ4WWt6WllnejFHbFdrVVE0WmU5aXU1VlczdHUyMWx5?=
 =?utf-8?B?c1p1bS9mNkRHT0dnWHY0b1JQbDhyVC80R3ZZdFVNTjdDT1NScjRnNVFIWVhG?=
 =?utf-8?B?SHZycnFNR01NbzZrWUZTNld4WXVIU2V0OGY4bjc5MUJ6VXRkTmlwVFJiVU43?=
 =?utf-8?B?Y2RvTlJnTWYvV1lqbHdnaW5zRzBHU3lXK3NMTm9zTlNROEtmWVhyOGcvUzhB?=
 =?utf-8?B?RGpaYVYrd1M4NzRRWFkwTHF0bHZYTHBxT1gvNTJtQkEzSmpyUTlkNHZMaklv?=
 =?utf-8?B?S1ZySzNJamszQUlhSTRjTUxBUVNaNjhTMUhkeGtmQTQwdC9YVHhBT2N1b3lS?=
 =?utf-8?B?UHZCV1NicE53WnEycklLYVRGUWdRYkk4OGV5UmpESFlreDc1UzZLdGlOMjkz?=
 =?utf-8?B?UWVObWFscDlxc0pKa2hlUU9GbWwvSzRjeHpRM1hpbkR4emRHTUh3N0JYM0xx?=
 =?utf-8?B?cmxNaGIrMDNBbUd0ZkxpMkJ0a0pPMiswYzdPdmo4dURNZStDOFlNQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83909f70-8a7e-4845-f15c-08da553b2665
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 17:09:36.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGlE0z4Q+5RoQqEybhtmZLM3ZbTjQsXPqqVaKH/UIKgImfnyGpmYHxRlC7h4O593EBfLiIRIs1aGilKyc7ugUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040
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

On 6/22/2022 11:31 PM, Boqun Feng wrote:
> Hi,
> 
> On Tue, Jun 14, 2022 at 01:03:47PM +0200, Andrea Parri wrote:
> [...]
>>> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
>>> is about fixup wrong spinlock/unlock implementation and not relate to
>>> this patch.
>>
>> No.  The commit in question is evidence of the fact that the changes
>> you are presenting here (as an optimization) were buggy/incorrect at
>> the time in which that commit was worked out.
>>
>>
>>> Actually, sc.w.aqrl is very strong and the same with:
>>> fence rw, rw
>>> sc.w
>>> fence rw,rw
>>>
>>> So "which do not give full-ordering with .aqrl" is not writen in
>>> RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
>>>
>>>>
>>>>>> describes the issue more specifically, that's when we added these
>>>>>> fences.  There have certainly been complains that these fences are too
>>>>>> heavyweight for the HW to go fast, but IIUC it's the best option we have
>>>>> Yeah, it would reduce the performance on D1 and our next-generation
>>>>> processor has optimized fence performance a lot.
>>>>
>>>> Definately a bummer that the fences make the HW go slow, but I don't
>>>> really see any other way to go about this.  If you think these mappings
>>>> are valid for LKMM and RVWMO then we should figure this out, but trying
>>>> to drop fences to make HW go faster in ways that violate the memory
>>>> model is going to lead to insanity.
>>> Actually, this patch is okay with the ISA spec, and Dan also thought
>>> it was valid.
>>>
>>> ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
>>
>> "Thoughts" on this regard have _changed_.  Please compare that quote
>> with, e.g.
>>
>>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
>>
>> So here's a suggestion:
>>
>> Reviewers of your patches have asked:  How come that code we used to
>> consider as buggy is now considered "an optimization" (correct)?
>>
>> Denying the evidence or going around it is not making their job (and
>> this upstreaming) easier, so why don't you address it?  Take time to
>> review previous works and discussions in this area, understand them,
>> and integrate such knowledge in future submissions.
>>
> 
> I agree with Andrea.
> 
> And I actually took a look into this, and I think I find some
> explanation. There are two versions of RISV memory model here:
> 
> Model 2017: released at Dec 1, 2017 as a draft
> 
> 	https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/hKywNHBkAXM/m/QzUtxEWLBQAJ
> 
> Model 2018: released at May 2, 2018
> 
> 	https://groups.google.com/a/groups.riscv.org/g/isa-dev/c/xW03vmfmPuA/m/bMPk3UCWAgAJ
> 
> Noted that previous conversation about commit 5ce6c1f3535f happened at
> March 2018. So the timeline is roughly:
> 
> 	Model 2017 -> commit 5ce6c1f3535f -> Model 2018
> 
> And in the email thread of Model 2018, the commit related to model
> changes also got mentioned:
> 
> 	https://github.com/riscv/riscv-isa-manual/commit/b875fe417948635ed68b9644ffdf718cb343a81a
> 
> in that commit, we can see the changes related to sc.aqrl are:
> 
> 	 to have occurred between the LR and a successful SC.  The LR/SC
> 	 sequence can be given acquire semantics by setting the {\em aq} bit on
> 	-the SC instruction.  The LR/SC sequence can be given release semantics
> 	-by setting the {\em rl} bit on the LR instruction.  Setting both {\em
> 	-  aq} and {\em rl} bits on the LR instruction, and setting the {\em
> 	-  aq} bit on the SC instruction makes the LR/SC sequence sequentially
> 	-consistent with respect to other sequentially consistent atomic
> 	-operations.
> 	+the LR instruction.  The LR/SC sequence can be given release semantics
> 	+by setting the {\em rl} bit on the SC instruction.  Setting the {\em
> 	+  aq} bit on the LR instruction, and setting both the {\em aq} and the {\em
> 	+  rl} bit on the SC instruction makes the LR/SC sequence sequentially
> 	+consistent, meaning that it cannot be reordered with earlier or
> 	+later memory operations from the same hart.
> 
> note that Model 2018 explicitly says that "ld.aq+sc.aqrl" is ordered
> against "earlier or later memory operations from the same hart", and
> this statement was not in Model 2017.
> 
> So my understanding of the story is that at some point between March and
> May 2018, RISV memory model folks decided to add this rule, which does
> look more consistent with other parts of the model and is useful.
> 
> And this is why (and when) "ld.aq+sc.aqrl" can be used as a fully-ordered
> barrier ;-)
> 
> Now if my understanding is correct, to move forward, it's better that 1)
> this patch gets resend with the above information (better rewording a
> bit), and 2) gets an Acked-by from Dan to confirm this is a correct
> history ;-)

I'm a bit lost as to why digging into RISC-V mailing list history is
relevant here...what's relevant is what was ratified in the RVWMO
chapter of the RISC-V spec, and whether the code you're proposing
is the most optimized code that is correct wrt RVWMO.

Is your claim that the code you're proposing to fix was based on a
pre-RVWMO RISC-V memory model definition, and you're updating it to
be more RVWMO-compliant?

Dan

> Regards,
> Boqun
> 
>>   Andrea
>>
>>
> [...]
