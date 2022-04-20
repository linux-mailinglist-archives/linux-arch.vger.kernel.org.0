Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F269508DED
	for <lists+linux-arch@lfdr.de>; Wed, 20 Apr 2022 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbiDTRGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Apr 2022 13:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiDTRGK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2022 13:06:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBAC40916;
        Wed, 20 Apr 2022 10:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0TzPnB0dKOWy1ER6/e8SqP033y3pov2ZmXRAo0bwnD0qPFn37WmcUWyL2POpUt/5r6YcsWhQYg6Kjzw2llg5Zjh+fSKvz51LnCS/u4v3aMCpdjPwzLwG3576CpuNQRJj7M4lw04tazRuXrhjeG5x3Z95a/3jpCOH2pnvNcB3/7m1paFxBLpRmbIocvAonlj2gJkEO53ZIfqtyKDxyoAgfhYNy4eQlfAkQxywcofuyjyOSzU7iJh3xl1MtU4It5JUvJBJEIp2NeSE8TI6j2U+/RUPfVJ1C3HlwIuTDKiGjWyiOBKQyYG9BQVzFlzJ9lj1N3RqxqgPsIjcWKyd9wS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGsXbb788akZUdPEAeEI3YpjZ84YVuexN1dvmcPjKb4=;
 b=CtLvf+scsHuIGXGJfhLFwoK9t0VLI7bw3F8TeV70g71Kz/qrWOUTCb93sXaZOePIpkWtMaygL25JrxFgKARPf1SS6Z5YOwy2SaqHRMU/vebcMyktEdYbaljt6wOn20hg0cXA91tlI/3bbtTlal7DrXzLza1hNNfxwyOXUt6SIvcuIu0z3Fv7DjVdWU9Sxdby0YzZMR4W3MWD3/1ybYbfgmfYIhqsjcaBH/l8PXcJZRpiH6OW5sz8CgOAVAwEMM69xl9IsOuCQt8H5qglrt+hkpooNavfgo9UecGj4Eqmdfbi4mLvoQKzp+50lsJuNDOY3NHqfHcytkUyF+CfBEUEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGsXbb788akZUdPEAeEI3YpjZ84YVuexN1dvmcPjKb4=;
 b=A9p+aokFBngKmPq4rH6Z0KC7zNkXuDeUQek/NpWPFkoSp945xWnmsmz2r36niNfpcw3XtqI8nWIachELg0uI+AauHCLAokYHqLGwaF5jDYR0cndXnnJwPcjKjeJo8mVWSVGxed9841aFMnR4RaLORUl5eXM9rkOmfA2T1IDIiW2/qwGtRPwAv/GKPx/jte+0rK9L8aBnAc5WD9q5zPbrK6lJDDp2+irOICsu8roHmF5a4SyKQzp/vah9ZsvC+6LT7xsSH8WWgIpIQ4um9zXYTaNlUfMHPWn26xUrjZipEInAMfAxS7ob9A9Xp7EC6KtxUjCO3BVDOHDQcNOKA7uWxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3437.namprd12.prod.outlook.com (2603:10b6:208:c3::20)
 by PH0PR12MB5678.namprd12.prod.outlook.com (2603:10b6:510:14e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 17:03:21 +0000
Received: from MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::18b1:f463:cb9b:82f0]) by MN2PR12MB3437.namprd12.prod.outlook.com
 ([fe80::18b1:f463:cb9b:82f0%6]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 17:03:21 +0000
Message-ID: <41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com>
Date:   Wed, 20 Apr 2022 13:03:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
Content-Language: en-US
To:     Guo Ren <guoren@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
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
 <3f7dd397-2ccd-dfa3-a0ec-dcce6cbc0476@nvidia.com>
 <CAJF2gTQzPsM0X-gib3V0EYYU=weMFXMQZCEbru9y+dDbV+9eXQ@mail.gmail.com>
From:   Dan Lustig <dlustig@nvidia.com>
In-Reply-To: <CAJF2gTQzPsM0X-gib3V0EYYU=weMFXMQZCEbru9y+dDbV+9eXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0067.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::12) To MN2PR12MB3437.namprd12.prod.outlook.com
 (2603:10b6:208:c3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb4e6b3-f7c0-496a-a7b4-08da22efac60
X-MS-TrafficTypeDiagnostic: PH0PR12MB5678:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5678FF04F463DFC276F4774FDCF59@PH0PR12MB5678.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4jkN1BLhjICuSq0uuVTvtQYtwt7xEybP5Tmf2H7TtR6es3ipjL0MONUveGaBrQwrUgyKki9FbiPBdrAn1SFlYGJefvI5R2KOWJM7QyZgqeOT5tb2G+dWrP3cQrsAG7ou6Gbw49SOUKLNnpd45LhZBMiMnhzg7LLxQtbn2auFMlHqA1uekEaVok2OuqsBaxmQhdCFDb5aSp9+Bs80wHdA1hVYYoJG5UHRtXy05fV5E2F8HeIoLuRg50WjXdXttymqW80lll7+nH5pt75MU5TwSBFCabwTzhIdC5eD4rUgowIol9t4mnRW2eAnTPB9DNolDWy61OzpGNTZdtBFyJx2bfMVg0Uf6evbzFDjfHUjGnx+KRMlTQnHB1MY/GJPI5ut2Cj9rV/sXm5SDjN4nL/p5Z8WXls1E09Rma00CESftf5TvmjpmLc/PM35ZxXYYI4b1lNZLI015mOhWXOerYfQ8ZeDAYLsDnWeRFISYAAPhGjnpREkwA9ioDJOguxrwxuv1fLgAr+6ECfSU+QfZKMdQ+BlKwWEfl80g9aRb0+Q+jGzvIIr+Kv0z5chOcg5ZWXjI4soBN4pCUrviDgs2uUIUYCHlgw8ioSurSUnGH56Hc7uxoSaOIC/n4G1Txg4Go2s0sddQYOXiaQLenaBT0YBbdE0+MEpHElqor0g3ZmBysUaLSmXcLYUEvBiFQjcbaib3b2zudDZt6yxgKcxnIHI5Dv4Lb0tEX5QYXktEbyZYc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(54906003)(38100700002)(36756003)(316002)(31686004)(83380400001)(6506007)(53546011)(8936002)(6666004)(508600001)(5660300002)(7416002)(2906002)(6486002)(66556008)(66476007)(186003)(26005)(66946007)(6512007)(31696002)(86362001)(2616005)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05KV2FJQWwrNU5ob3lQdWZUbHFzbVRsSlMyb0dGOHRHN3Ywd1lqcW83dTNr?=
 =?utf-8?B?by92bEZvbXpiZ1VpNVJOdVB0NXVqNWNkcXVyb3lUclVSZnBxNlFzZG5uRjZP?=
 =?utf-8?B?OUhEMHpqQ0JRVG9WMGhjQ2dmbm5qdmFaSVBDdDFBL0VROG1zb1BQVW10N1Mw?=
 =?utf-8?B?OFRFNzZNejZIWHRaZ1FGNFljdzR4bzRlZS9wbTZ6QmFTOU9VVzVFNFcvN3E0?=
 =?utf-8?B?TTQxb3hrMTFVZ285bzdtZkZUNTU4c0x5a2JTYnRObklPZTd5S1hCTWlRM2pQ?=
 =?utf-8?B?ZEQ2em44WGdYMkg5ZWxGTVZCajg5WE90dXJ5NExxd0pCSlF3ZGt2Nzdya0lV?=
 =?utf-8?B?WUFDclprLzhXYjRxS25TMy9OT2VzMHlnSU81R25tV3hsOHl1RlB0K00zWDNx?=
 =?utf-8?B?RmRmcmdNNkhlV3RCcTNTOE5lYUpsOXhEY21nT3pqUGU5dWU3aE9vRFBTbld1?=
 =?utf-8?B?R0dHT1NNTTRGaUNRMGZJNzZ3V3ArN3dQR2RXNFdiQW5pL0c1ekhzRC9hdHdw?=
 =?utf-8?B?OU44cXI2S1U5eTF3QWhvZGFDSDVLRHlSSHd3c0N4cVk4Vm92a0VkRDVCbXhM?=
 =?utf-8?B?aG1HZ0VlTmc0ZmxBNitvdFhXYXpkNmtGTmUxYnBFR3RYUUg4UWZFSU0reGlF?=
 =?utf-8?B?WTZOcUNUcjZtV0dma0xjWEhiSXV1MlAzYjhKbXE0dlJ3NW9oZE1TekhYbjVB?=
 =?utf-8?B?V08ycFlBWHJIREQ3Ukd2U2djRUVJV0F4QUdSZ3ROZXBJZlE2OE5WeG9ROStX?=
 =?utf-8?B?b25CQzdJUTVPQUVvNFIyV1lhcWYzbzFUM043UE94WjU5dFZldmwrdTcxaFYx?=
 =?utf-8?B?ZHFLU3JsektmK1dIbDF3NEptRUxxZEVyaVkzL0hqMnkxbHZDYzdwMFhSY0Q4?=
 =?utf-8?B?RDVwNXhGa3ZpUHdKNlM4c2UyN1kxUDVJVm1lWGFUQUYrZ2dNcTNER2R6RFVk?=
 =?utf-8?B?NjRpOTRQMms2eFlWby9YbUtwejkzMGxqQklwbHpHRnlud05IYitlL21Fb3ZP?=
 =?utf-8?B?YU91MnZGMWVIS2g2OUpPYnJzK2ovSitUZDdiRDBVbWt0dmhyV0RibnBqSFVI?=
 =?utf-8?B?SVQ0cXA0MzE1VHZZc1RqMyt5UVU5M0U2STliTjliWDFpaHJMMURuaWlCaDBv?=
 =?utf-8?B?bWhFRlF1a0krUHJsY3lrbXM5RUprcHdtcnZ3TzJhQlhHN2NEV3FSMlBPb0th?=
 =?utf-8?B?MGhicTdtT2VZSjZ1ZXZFWUMrN3RBd09qZ2cvWTVRaThOQW9LMHlyOHkyZEc1?=
 =?utf-8?B?ZnBrajNEZmExTCszV0NFZDg4WEFJUXpKekdQRVF0ek05cWdPLzBzYnRxai94?=
 =?utf-8?B?OE1URnJya3BTOXFpM2UwUEVGaEoyZFF3M1N1c2FoVllFVm9yQUlMb3dPemtp?=
 =?utf-8?B?K0JFU0Jaa2FEOUFmSjFqZlJaUWtINDMxT29JSk9oK21GYWt3Ym5UV2ZrdmNF?=
 =?utf-8?B?OVU4ZXNWQ0F4aEZpVkhsd1ZiTE5tdXBUWVA1QUw4VzFiTnA2NXVweHV0NVBN?=
 =?utf-8?B?STQ1SjFZTVY1b1Z1WHVJY1VlQVV3MjFRcjFPMm5jL1FpeXZkbU5HZHo4M1pO?=
 =?utf-8?B?alMvRnZFTC9RZDQzcUJleS9NNGlnRkQwaGVMT2E5Rm5ZaFNsTVh1VCtLNy9E?=
 =?utf-8?B?VGVCdjVlRTQvMXBRZjI1WHQ3ZUZhbGx6bzlaTldiYk9mQzJjbENhcHoyR09K?=
 =?utf-8?B?VXVDdTV4YjFmeXJZajBoYTgxN29NSG9WbXZESmcvTmhOSkRtakNEc3Zab29B?=
 =?utf-8?B?dFFvVGhzYlg5NXdLOHBVdTh3QWxuOE5ZV3prTDl0YnhkbnVrM29HcGVQRkhN?=
 =?utf-8?B?K1VIYlV2R0VCdDh6dXpwdEpSWUpkaFF1dXUrTmR5VkRoZXpncStVcmdWRTBU?=
 =?utf-8?B?ZGl3UjUybUVvVXVVNDliZE1JeUdDMW9wZjNadis2Zk0xYUlreUs1aWt5YUlC?=
 =?utf-8?B?Y0R1VTVYajlNMGxuYnZZV2hxVTBReGdlYXdjWDl3U3VpcCt3b256YzlVR1Iv?=
 =?utf-8?B?aGZ4em1DSk4wVDRCa0JQbDNiYzV6WWNwVS9jelo5YXI0dkp1THAwU1dMajJu?=
 =?utf-8?B?R2RXcitHdFZkRUp2NnVZZUE3Ym9TeXhkWDE4OVBDK1dzTXVqam4xY0QwMFZL?=
 =?utf-8?B?UkRzQTRDZ1RYdkgzb2FaSWJGNXFERzFvaWN5YXZ3QlZrVjFYRmIxK1lNSTYw?=
 =?utf-8?B?Yk9YaUJiaXBlbzNKc09veTBzdyt6a1VGVGc4S1hhZ2IySmRIVzZQZkl5dnhG?=
 =?utf-8?B?ZEFJcjBJaDRCZXRtZ01jbklJL1RrRk1FS05XUUkzWGZFMFM0ZTBJczRvV2pG?=
 =?utf-8?B?aHI3eTdsR2tWRGtXbDl2TXZLNUV0V3VVUy9ZYXU1R3hybkwzdWI5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb4e6b3-f7c0-496a-a7b4-08da22efac60
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 17:03:21.2608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLb3MMV15MP1rOkUVeKxcpFaVNMuBpZyo7nKxMf9KhWaX9b98Ps05vGU5CKg7QcyomfGufczI/QnVDPM3kpfSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5678
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/20/2022 1:33 AM, Guo Ren wrote:
> Thx Dan,
> 
> On Wed, Apr 20, 2022 at 1:12 AM Dan Lustig <dlustig@nvidia.com> wrote:
>>
>> On 4/17/2022 12:51 AM, Guo Ren wrote:
>>> Hi Boqun & Andrea,
>>>
>>> On Sun, Apr 17, 2022 at 10:26 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>>>>
>>>> On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
>>>> [...]
>>>>>
>>>>> If both the aq and rl bits are set, the atomic memory operation is
>>>>> sequentially consistent and cannot be observed to happen before any
>>>>> earlier memory operations or after any later memory operations in the
>>>>> same RISC-V hart and to the same address domain.
>>>>>                 "0:     lr.w     %[p],  %[c]\n"
>>>>>                 "       sub      %[rc], %[p], %[o]\n"
>>>>>                 "       bltz     %[rc], 1f\n".
>>>>> -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
>>>>> +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
>>>>>                 "       bnez     %[rc], 0b\n"
>>>>> -               "       fence    rw, rw\n"
>>>>>                 "1:\n"
>>>>> So .rl + fence rw, rw is over constraints, only using sc.w.aqrl is more proper.
>>>>>
>>>>
>>>> Can .aqrl order memory accesses before and after it (not against itself,
>>>> against each other), i.e. act as a full memory barrier? For example, can
>>> From the RVWMO spec description, the .aqrl annotation appends the same
>>> effect with "fence rw, rw" to the AMO instruction, so it's RCsc.
>>>
>>> Not only .aqrl, and I think the below also could be an RCsc when
>>> sc.w.aq is executed:
>>> A: Pre-Access
>>> B: lr.w.rl ADDR-0
>>> ...
>>> C: sc.w.aq ADDR-0
>>> D: Post-Acess
>>> Because sc.w.aq has overlap address & data dependency on lr.w.rl, the
>>> global memory order should be A->B->C->D when sc.w.aq is executed. For
>>> the amoswap
>>
>> These opcodes aren't actually meaningful, unfortunately.
>>
>> Quoting the ISA manual chapter 10.2: "Software should not set the rl bit
>> on an LR instruction unless the aq bit is also set, nor should software
>> set the aq bit on an SC instruction unless the rl bit is also set."
> 1. Oh, I've missed the behind half of the ISA manual. But why can't we
> utilize lr.rl & sc.aq in software programming to guarantee the
> sequence?

lr.aq and sc.rl map more naturally to hardware than lr.rl and sc.aq.
Plus, they just aren't common operations to begin with, e.g., there
is no smp_store_acquire() or smp_load_release(), nor are there
equivalents in C/C++ atomics.

> 2. Using .aqrl to replace the fence rw, rw is okay to ISA manual,
> right? And reducing a fence instruction to gain better performance:
>                 "0:     lr.w     %[p],  %[c]\n"
>                  "       sub      %[rc], %[p], %[o]\n"
>                  "       bltz     %[rc], 1f\n".
>  -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
>  +              "       sc.w.aqrl %[rc], %[rc], %[c]\n"
>                  "       bnez     %[rc], 0b\n"
>  -               "       fence    rw, rw\n"

Yes, using .aqrl is valid.

Dan

>>
>> Dan
>>
>>> The purpose of the whole patchset is to reduce the usage of
>>> independent fence rw, rw instructions, and maximize the usage of the
>>> .aq/.rl/.aqrl aonntation of RISC-V.
>>>
>>>                 __asm__ __volatile__ (                                  \
>>>                         "0:     lr.w %0, %2\n"                          \
>>>                         "       bne  %0, %z3, 1f\n"                     \
>>>                         "       sc.w.rl %1, %z4, %2\n"                  \
>>>                         "       bnez %1, 0b\n"                          \
>>>                         "       fence rw, rw\n"                         \
>>>                         "1:\n"                                          \
>>>
>>>> we end up with u == 1, v == 1, r1 on P0 is 0 and r1 on P1 is 0, for the
>>>> following litmus test?
>>>>
>>>>     C lr-sc-aqrl-pair-vs-full-barrier
>>>>
>>>>     {}
>>>>
>>>>     P0(int *x, int *y, atomic_t *u)
>>>>     {
>>>>             int r0;
>>>>             int r1;
>>>>
>>>>             WRITE_ONCE(*x, 1);
>>>>             r0 = atomic_cmpxchg(u, 0, 1);
>>>>             r1 = READ_ONCE(*y);
>>>>     }
>>>>
>>>>     P1(int *x, int *y, atomic_t *v)
>>>>     {
>>>>             int r0;
>>>>             int r1;
>>>>
>>>>             WRITE_ONCE(*y, 1);
>>>>             r0 = atomic_cmpxchg(v, 0, 1);
>>>>             r1 = READ_ONCE(*x);
>>>>     }
>>>>
>>>>     exists (u=1 /\ v=1 /\ 0:r1=0 /\ 1:r1=0)
>>> I think my patchset won't affect the above sequence guarantee. Current
>>> RISC-V implementation only gives RCsc when the original value is the
>>> same at least once. So I prefer RISC-V cmpxchg should be:
>>>
>>>
>>> -                       "0:     lr.w %0, %2\n"                          \
>>> +                      "0:     lr.w.rl %0, %2\n"                          \
>>>                         "       bne  %0, %z3, 1f\n"                     \
>>>                         "       sc.w.rl %1, %z4, %2\n"                  \
>>>                         "       bnez %1, 0b\n"                          \
>>> -                       "       fence rw, rw\n"                         \
>>>                         "1:\n"                                          \
>>> +                        "       fence w, rw\n"                    \
>>>
>>> To give an unconditional RSsc for atomic_cmpxchg.
>>>
>>>>
>>>> Regards,
>>>> Boqun
>>>
>>>
>>>
> 
> 
> 
