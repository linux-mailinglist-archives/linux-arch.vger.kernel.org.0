Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE965336A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 16:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiLUPeO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Dec 2022 10:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbiLUPdv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Dec 2022 10:33:51 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2110.outbound.protection.outlook.com [40.107.20.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A8B286EB;
        Wed, 21 Dec 2022 07:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKq+xWmkWN8SF5JudabQXCK0ilwmA/x7b7QqVMkirJsILrVzWrswRGud2h5FiQJnk0Go04/0wHk/T14s6+eT4TeO3coXcI9qrv6hnSzys1N3MCZVu4HnJsvwOHhR+xiKPDFTM7gFio03D9d52/IiMyEbpgbBMBFDxDs2pja9rDH8gds1OiUeeu8ANYJ6BTO0kzIVgDvOnQYJThlEXATTs48XWXApSy7diYGym1ll/+Jq3Yn9dGEFaaXCunYi73c3yq16FU4hf2ilIl39GQsn7pzHULT1jsBalwak2WrAUOQNyQNYSlgUPa9FixzEaWJAaBdhmUHVSzgmK8XEJe05Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9VEjpQddD5IGOOllmqtHQjytTZrrqtV1G4TyW1fwqs=;
 b=mLyB3bCTbEpG0xx7Q36BK667TnpOl0kNZuJf3lXrjs9B3lF7I/roK9YkxesPkpnr7qTnHTASaStPIhWZHuaN9dDZ57YaP9t9dya3b/hMl+/xnHyWFiQG/rD3X1adQrSW0G8p+cE0R/UcKH7Mfm+P9eaZjhZqQ+o1NNH5Fd0Ajc8IExsQE+Cu/zOuYNyf7n03t/wC4pfkhoVMbv+/I7GeYJ/JZ+ObyghoNyKPm5ABwZ2SYehXnqlOo37t4pbN2D8RfRm7XxfCoAHDGSP8p7aP2DSEtPiAIpk+rBgzkHJDREaH51dGlAOMN6Raf4573y4FMdGHVlWwck2y97AomE8tAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9VEjpQddD5IGOOllmqtHQjytTZrrqtV1G4TyW1fwqs=;
 b=UPpxLmk3P9aKvZ/9ZmPg940Me5VrCGhNOE8c4lZaVepQdjVsUTOqf2VahTo5t2UsuG0qR9ayYPvuodzhzR3VTaVjaa+OySJCJtbF9JEqM/slHhx+8xyMqwHSz8QxW8ZF8pC6nB2OiAQeH7khRqaAJZc0nGnYgFHneKWhsLd8hMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 15:29:14 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::722b:5d41:9862:10e5]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::722b:5d41:9862:10e5%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 15:29:14 +0000
Message-ID: <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk>
Date:   Wed, 21 Dec 2022 16:29:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
Content-Language: en-US, da
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
 <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net>
 <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0090.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::31) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AS8PR10MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbdf601-8bba-4e28-73e0-08dae3681ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9OLzdG1Ba56IOY0A6eJKiZ83w4bEv2RbVpXP/jU+9kMkTFYKrXXpp7FUrOdeSx5WGOi+Y4WRJpvREU4PAvqD050Vx7fPlfVf72zX9lmtjjc6l3Q/UcDun8IpKkX9R7p/rMa638VNYE85Z72r7L84MB9Nfop0ZXTvrZPolu9V7rnk+ruRM03tZHH6ECO28bMWi0hHsTL8dGjR9I+60/rW96qk33o0iM4vSjZEM5dHrlH9uxyWBHRC4r/zR5jAFo6YG7g/kpQFllE5p/ZJDBv2e2yvuJY+JchezNBi5oWwCr4K/QFhHpgx9B0pHif3ULfd82UYoc3RlgmRd95Mg6iV44+osCEq3rRX1XIrxS9QcgycOkTvZRxmhj0R/sJO+/kBkzYTNiatibEu7XUVzYBupRCBMFg/UZpDAMXvpPjkzfy3OXGX5SYtrU/JY3ca7O1arKCthNtXgsRRQCFCvV81Em9jGgVa73kYlEUd5qYpMDb3Ax4YKLQhENBATbk7UC/rD8dE7pQsn7ANwoyZtI0bWsJRV2goLs1otpH87IKQwi4O7fRUwSaEOrLM09BPY1m1z5mLUe9FFhbUI4fNv3Qw9p3HP7uvtRY+UaN/zqWI901Lj8WCjiy7ys4Y+1iohuujKUQvEpMGGTzkk3hsXtNGkDa4gSg9kEggoLWp9l5Q1r5DZXq/6xNNM95PRy5fcxYxshGhnSB+2RJpMzQmIjSkDycwF/i2ZuivwLlndn9FzjLEjYK7v+Jn9bBpA4izMWmncG8A1v3zCHZufcCRM3sjtu/o2ifcrrRlU/we3CbQQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(396003)(39850400004)(366004)(346002)(451199015)(36756003)(31696002)(54906003)(86362001)(110136005)(478600001)(316002)(41300700001)(38350700002)(6486002)(6666004)(44832011)(66946007)(5660300002)(8676002)(66476007)(4326008)(2906002)(66556008)(8976002)(7416002)(8936002)(966005)(186003)(52116002)(66574015)(26005)(38100700002)(53546011)(6512007)(6506007)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzZmMTZVRXZlcFJNM1hVRkFSMUJNRU9RSVg1dzQvdUJlbFNlcVFxNVN2aGZL?=
 =?utf-8?B?cUZCK1YwZ1h5L2dZQm5MMXpHbkhUWTVRWGR6bUE5ZHZsSVVibXFnWVJ2OFEv?=
 =?utf-8?B?ZHZ4NFhlVW5LdVY4a0QzU2Vld1ZJSVd3VUlkK0FMVEtXRlJkclgxaXVoVy83?=
 =?utf-8?B?MEtmV1FkbkZGby9UUjFwOTErTWpicy9zczdpRXA3RkFhWTJDZGk3M3Q3NFBl?=
 =?utf-8?B?b2FySFJxcEp6YVN0TmlKRXRVcDRGQVZyamRKUEZpLzQ2ZE5zT1M1cjU0TEV2?=
 =?utf-8?B?NHAwR1VzVFIybGExU0NqcGpoa2hmbGFJTUpTZi8zZVYvQnBYVjllL3RNWlY0?=
 =?utf-8?B?RmVOWUp2ZUgxVmtialN6ZnBVbk10b2N4a09LYzVjaUt0Uzl6dlBuSWtHRUYw?=
 =?utf-8?B?WmZUWVRyeEhOMmlNWUZJMkJtRFM3QVo5a1F4WGtMNVpFUGJqVS9CQ2VmVXds?=
 =?utf-8?B?aGdkVHo2cTVSb2ZyWVczUC84U21jbGRvNGVEYjIva1dzVUFHV1VYMWc2cDBJ?=
 =?utf-8?B?L1dwR0oxekJvejNqTFB3QnZreU5pdTVDaGFEbEU3MDdCRUphR0k5K1Y1R1ll?=
 =?utf-8?B?bTVvU1B0TDBFejZ0VGNWL0xkR09WY1N2MnBVcGhWSnRVZkhOYzA1MnkrQzRF?=
 =?utf-8?B?UXlKZXhkb3djZVplazRjVWxOSHNSZXl1d2NONEZzcXpIRGo1dVUxN3p6SGFY?=
 =?utf-8?B?MHlGQlJwV096VzRvTjlkcGg4Uk1aTXA5M1VNeHRQb21IK0o1WlpMSklMdGxZ?=
 =?utf-8?B?VGI4SkxZekNZL2VJdWtzeGxPTnR2aHNwVWVHWFhwTEwrYWQvTWZGR0YyMnI2?=
 =?utf-8?B?WjByS2RYMU1qTlBGcGROMlNFTCtROTlRTjE0Ky9SNmNWZFZwMjJ5S3hXZW9M?=
 =?utf-8?B?MytXTDdXcFp2c0dSSjk4SjB5QnhCTXdZM2VUTUhOZXF5clY0NEc1SmlHS3Nl?=
 =?utf-8?B?bVJmSzRpVmliRWVNRmJuR2xqUTU3RWYvakQ4Y2s4QlZIWkNoM0N3Wk4zMk5W?=
 =?utf-8?B?SVloL2lhY0p2N1phTEdnU3VEWk9lTG16UjZLRC9oVFp1T08zdFVXSTRDYnhP?=
 =?utf-8?B?dEp4VHBqVU1CM1NaS2VaRmptUEVWL1lBMXp1NGtwMEpJVTV1SDBVbzFFMXA3?=
 =?utf-8?B?em50VG5lMjZwcytMenA4WDNNdEhWQSt4WVlTK1A4bVpzMllwaEtDeGFzSStt?=
 =?utf-8?B?ME4vQ202WjZjemMvOVZoa1hCd29vZ1UwQS9vYi9tVzg5dkpoclgzVXNmenR1?=
 =?utf-8?B?eFR2NVJ6c28yWnhDUjh2MlM1TDRDQ3R1TjVCUWpDV1NYMFkzUk9qOGJwNlpy?=
 =?utf-8?B?YWU1d2Vrbm9DSHZUcnNudjZ1OEhMcUs2OVU2VEc1ek1oeFl2MjFmU2VKZjNn?=
 =?utf-8?B?QUFrTWpRVWM0TW5DaEl0cGtOeXRULzMwQkE5L2s1NnlWVWdBaUx5NC9wNHVn?=
 =?utf-8?B?dmxWb1JWMUxnQUswUHYzSWNwQjhxTlZHM0hKdFJ3cU1jVjFCQ2VaeGFaUlps?=
 =?utf-8?B?cUZRb3JoVzIrajJaaUlPVXZWaTJROHhUdHZKMVV2aDVsT29oWXAxajNDaExS?=
 =?utf-8?B?bi9yeG5BMzFMRjJBZGtHYWdpem1qb0FLdmc5Qy9MOVZrbXpNeTdSU1NOZ1R4?=
 =?utf-8?B?ZHdiQjR4WGFuR0xTeEtwU0ZpT25FWmN2VS90YUM2S3hkNlIwZGxEbWh5RlZF?=
 =?utf-8?B?dWxGVU8vb2ZENThJUTNiQURLY0txcmVLVEFHaGVQRE1jNXFKcER1Z2lMQmFr?=
 =?utf-8?B?Qi9aOC8wdG1qZHI0TTNHWmp5MjNKcXZDbXZqaVdKemJkUjU3MXN2TExUVCtZ?=
 =?utf-8?B?VHdIOEVIY0E2NEhqRDdXdGdYMDJERm9sTytDekszMVU3Sy9ablFlVG42Wk9C?=
 =?utf-8?B?QVRYR2hmTDZxNkxWWHdwWWkrUTIveEJGN08zWUl6V0tHajNYMFNybEprZHBz?=
 =?utf-8?B?aHJVOVJ5UEt5ZHFDUy9CeEhyTG8vZDlmY2JFQzdIZUQ5NFI2NTBGaUZTZVRi?=
 =?utf-8?B?WmJteU1XYmQvc1lnR2RvK3Jqdm9CR0lsb0ZkWW02OEtMSHhjODJhUVBJQjdE?=
 =?utf-8?B?MlB5amduS21aa3B2UlpCODlMMG4vMTY4L1dSQXk4dzNPdkF0amlGbE13TG12?=
 =?utf-8?B?Q01kSGpXcXB0b3ZLQmh1TVBKM0ErUnFkT3c3ekhydWdaeUpRWCtKTDFFVmVH?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbdf601-8bba-4e28-73e0-08dae3681ddd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 15:29:14.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaUAPxt/DfWANVnPypJTN8uv7ajDVMY8f7/Q2+IitiljJb3dTSFWECgkCIf16mWqJpoZ10pyFkcxpaPvFBUTOGat0wpuq48P9jnuIgPjJ70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7524
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 21/12/2022 16.05, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Wed, Dec 21, 2022 at 3:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Wed, Oct 19, 2022 at 02:30:34PM -0600, Jason A. Donenfeld wrote:
>>> Recently, some compile-time checking I added to the clamp_t family of
>>> functions triggered a build error when a poorly written driver was
>>> compiled on ARM, because the driver assumed that the naked `char` type
>>> is signed, but ARM treats it as unsigned, and the C standard says it's
>>> architecture-dependent.
>>>
>>> I doubt this particular driver is the only instance in which
>>> unsuspecting authors make assumptions about `char` with no `signed` or
>>> `unsigned` specifier. We were lucky enough this time that that driver
>>> used `clamp_t(char, negative_value, positive_value)`, so the new
>>> checking code found it, and I've sent a patch to fix it, but there are
>>> likely other places lurking that won't be so easily unearthed.
>>>
>>> So let's just eliminate this particular variety of heisensign bugs
>>> entirely. Set `-funsigned-char` globally, so that gcc makes the type
>>> unsigned on all architectures.
>>>
>>> This will break things in some places and fix things in others, so this
>>> will likely cause a bit of churn while reconciling the type misuse.
>>>
>>
>> There is an interesting fallout: When running the m68k:q800 qemu emulation,
>> there are lots of warning backtraces.
>>
>> WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
>> testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha12,aes)' before 'adiantum(xchacha20,aes)'
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 23 at crypto/testmgr.c:5724 alg_test.part.0+0x7c/0x326
>> testmgr: alg_test_descs entries in wrong order: 'adiantum(xchacha20,aes)' before 'aegis128'
>>
>> and so on for pretty much every entry in the alg_test_descs[] array.
>>
>> Bisect points to this patch, and reverting it fixes the problem.
>>
>> It looks like the problem is that arch/m68k/include/asm/string.h
>> uses "char res" to store the result of strcmp(), and char is now
>> unsigned - meaning strcmp() will now never return a value < 0.
>> Effectively that means that strcmp() is broken on m68k if
>> CONFIG_COLDFIRE=n.
>>
>> The fix is probably quite simple.
>>
>> diff --git a/arch/m68k/include/asm/string.h b/arch/m68k/include/asm/string.h
>> index f759d944c449..b8f4ae19e8f6 100644
>> --- a/arch/m68k/include/asm/string.h
>> +++ b/arch/m68k/include/asm/string.h
>> @@ -42,7 +42,7 @@ static inline char *strncpy(char *dest, const char *src, size_t n)
>>  #define __HAVE_ARCH_STRCMP
>>  static inline int strcmp(const char *cs, const char *ct)
>>  {
>> -       char res;
>> +       signed char res;
>>
>>         asm ("\n"
>>                 "1:     move.b  (%0)+,%2\n"     /* get *cs */
>>
>> Does that make sense ? If so I can send a patch.
> 
> Thanks, been there, done that
> https://lore.kernel.org/all/bce014e60d7b1a3d1c60009fc3572e2f72591f21.1671110959.git.geert@linux-m68k.org

Well, looks like that would still leave strcmp() buggy, you can't
represent all possible differences between two char values (signed or
not) in an 8-bit quantity. So any implementation based on returning the
first non-zero value of *a - *b must store that intermediate value in
something wider. Otherwise you'll get -128 from strcmp("\x40", "\xc0"),
but _also_ -128 when you do strcmp("\xc0", "\x40"), which is obviously
bogus.

I recently fixed that long-standing bug in U-Boot's strcmp() and a
similar one in nolibc in the linux tree. I wonder how many more
instances exist.

Rasmus

