Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D6864D143
	for <lists+linux-arch@lfdr.de>; Wed, 14 Dec 2022 21:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiLNUec (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 15:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiLNUeI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 15:34:08 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2067.outbound.protection.outlook.com [40.107.116.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2112D1D5;
        Wed, 14 Dec 2022 12:26:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMk/Zf5AvC0J8OgpALldr+b/Cw7189PdsNbVcI1viFi0fZY5lrlXaRrTqlRKJJ9ozjyNAileq2JTUwQNnjIaVCjpVEiENeWTgyIuF6AzfTYV3vols8WlM8AfN/Wj05U//yh74ZgpcBy6+xWXIPsf8XfPwHlAaxSDxh70yMsOzy5Ji2MVivi7YTidDP5SBCvISTHdN+068fzP9zxz3eLQ7LVBQlOCA02ra9Y0PYchIQlAQleNTlPPcpFkvtngb1TzfG0Xr+4CPgT3LQ+4C77637TYZ/VRXXOT6sU/brfLrPxtjJ5y29XgSkigBSEVjG/iwz61ky5fxpLXENWp1RQiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfZwq2on/ekbOK2qwGSlfOb6JvOjZ2FcfokeuNQEib8=;
 b=d6kf7hyCl2Qp0+fppOFbnR3n5AIX9qh5PP1g8zAj2dcADjCzY2G54FCltMzUWOyCDkK0HVAUjmO9IE1pgFDNs5eyxsfqgtl8fKinGOhiH8HXiqqGltj941Rf/qydWKU2yuNTirtjps9zpWeUkzoAO64GbG9MSOe8w8iOCJeRKc04vnb4qLaMQqtNH+0SJ9jWp74MrX0iyGryTnLsxPqJd7mKQSIqtKGMRu8H9asEdiY5NpneDpCg/vDB4u6/B09xC1IlS4pIahePMy8sNR4k2mkgvxSiaqSXZhHdo1FqtrIyAvqkEJzB8USqjn1DKl1hIeAoqrEK75R6lp1Ltw7s9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfZwq2on/ekbOK2qwGSlfOb6JvOjZ2FcfokeuNQEib8=;
 b=J5x0DJEYK2lT2Z9hguLQ/RPLxqcr5G2nXlxO2tpzMLjHOCh5m1vWSG0EONrkFU072ccdUoQtQSCLJuP4KU1/8DzA/nNW8yWIvurq3TJqAq1SnPBqjcz82aIuLLTIKaRQIXBl/IamsbvY32DlT3p2V2Q60SGWTVRsLQHwaJzmoKsmIqwEPVLthFnnQINZvrOPEc3MMDtWNDRyfW3eTsKaB5U5v9ZIygmzlAgXF2W14xKI7cBvP8L1EVlEJQG2g27Qc7KgleD5aA4oyLYK0cb+nQlIwV7KGtkBA/yB65iVlJxgdzyE3YFWLQVzUE+ZnKUEU5mglvDqs8d8h2MeibriTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YT3PR01MB10733.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:95::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 20:26:29 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2bff:5fa3:434e:517]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2bff:5fa3:434e:517%9]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 20:26:29 +0000
Message-ID: <a6e99b31-5719-5f21-3c4f-836f809e893e@efficios.com>
Date:   Wed, 14 Dec 2022 15:26:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH] Syscall tracing on PPC64_ELF_ABI_V1 without
 KALLSYMS_ALL
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
References: <20221212212159.3435046-1-mjeanson@efficios.com>
 <39c53bd1-432f-15f6-4cbd-b8551fc261cf@csgroup.eu>
From:   Michael Jeanson <mjeanson@efficios.com>
In-Reply-To: <39c53bd1-432f-15f6-4cbd-b8551fc261cf@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::40) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YT3PR01MB10733:EE_
X-MS-Office365-Filtering-Correlation-Id: fa2266fc-331f-4308-bee0-08dade117b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CszFifJ2Uew0l0OeOno6CNVr2VPMuBJG3oXqCcBfP2j7lEIeuYdk9HJT0EuNmxVvzzzK1aAl/BXagOxOsUXSUAi0BLnloWxp0NnywArBtu+URrmoOHJFmfuQC192b72wuLV8A5wJuRQZ6suDSoLpPHc74jxWz/5CAkxz3avLEkQdSGRtYi4UZcXgXSnYviW1HeHWkAPqA1CEW4iHtDjndcuNIqRIxBB/vxMch0f0AInhqYi3hmtlCHMVN3lxXYTKqOaA+POdA0Ln0u1anXkAtKoD/yYDXkRUU2UVUKDAS2fz2QU/4GY77cPg6XNbl+3D8luFRNMT5fcjDFWN46+NsGaJTl1uTOX5YKCn3kbVKblTASi830EFAMOIMmhYZmzZKY4aHWP4IhWq6+5M7Y6ZcpzG/jbBM+brrVFzyEA1h3AqeiZC8zrgYLJQ53jtz3cNA2NBJOs34ocz+nGj3QCeZ9hu/6H+vy2F7p8V4OamdJ6kLKpz6+1YQlqO67yAiMUOzC9mI+gr0FaJqE1HNNLNQqMDMjmRr1FHzW7AnSLaHIGaoau3lO152JMmQzl9Frb+GwNgIj0I87xJb0EN93uivBLqerOjUY7n19WA6Wpu4SmbEaHG/r+cPecc6LgLpTlZF4b7ZaoM9UFmrDQekmiZekMj3gQ61TTPr5eFdkQAxVybl35UpngRa49iUE8kqRToAr9E1jCpjhJR6lOrDrlFcsidlHswrBn1zQ26fY/s9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39830400003)(366004)(136003)(396003)(451199015)(4326008)(66556008)(66476007)(8676002)(36756003)(83380400001)(54906003)(316002)(66946007)(110136005)(4001150100001)(2906002)(86362001)(31696002)(41300700001)(38100700002)(7416002)(5660300002)(8936002)(31686004)(6506007)(6486002)(478600001)(2616005)(6512007)(53546011)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFydmJFZTBhZzVib1ByRmtEckgrZDcwYklLNFluYVZZbzUvVEhwQXlDamhE?=
 =?utf-8?B?ZGM4a1djNVFmVGliWVhEN0g0azZUdkVza0xYNkJhN3lvWGNjaHFOMExmYXUx?=
 =?utf-8?B?U091YkRENGtzUU1GcGREdTYwai9GYkhtSEVaMUEzUEV0ZmZMSkxlZk9mL3o3?=
 =?utf-8?B?aEVBTkl4eXpmQ0h3N0pSN0JPL01DbXpQdWlaTE4vZWhBODZJRU1XTTZ2VHJo?=
 =?utf-8?B?WllmZUVzMjlWV1FMOW90aENtVVhDSWErTy84WTFBeUwrN1hqRjM5alFINVZE?=
 =?utf-8?B?cHROSk1kSUZTOGNOSElCci93eE1tWDhDdnpLTWcyWktNRGNZeEZlZ1M4N09P?=
 =?utf-8?B?NVpQREVqY3J0aThsRXVPVHVQR2tMY21zTDdRcnAxSjN5S2REalRQYWNCc0c2?=
 =?utf-8?B?WGZLV1N2aHpkWDgyZEJwNmcwbi9xK09yWFJEVUIxTzRqVThDUFpRb3QyNVhq?=
 =?utf-8?B?WjNYamhvY1FZWmtuT1N2andzV0dqY2VHeFdPTzRiSFhyNGdTZkFwRjhvUU15?=
 =?utf-8?B?TFplUndDcU1wVkhpNFlCeHdUb0VxSW54NjFHdi9nZWc3aVp6WkZvV3QrdE45?=
 =?utf-8?B?YXhXazEvVnZGUlhEMmZSd0UxRUtkL1Zmd2ZWVzFpZWlJdkhmRzlCT2VtY0F5?=
 =?utf-8?B?NmlEZnJwaXdWMUtFNitmMzVWdWRtQldoMlJ0Y3FjaDRvYU5QVDRZMU9rcWNX?=
 =?utf-8?B?RzRBNUpCNnVZaFVvTkFUQzk1Ky9iMk15SHk4dWpuRmNzd2JxdTluSnZXWXQ3?=
 =?utf-8?B?eFgyTml3YytaSEx5NDlkSThXVjNZUndQVTlwMHZkMmVmMzQ3YStOUmVIUENx?=
 =?utf-8?B?RkdvWnVRejNHWDRMQ1lmT0tBK1cyZUVKcXk5QUwrYlN3Z0FRbjB3UXVzamVy?=
 =?utf-8?B?NXJYYkF4NFQrWVdoN3BqOWNDTzFBa2VCdThSUHF1UjBKS25ic0FiN1hBQ0lx?=
 =?utf-8?B?Y2JWZVFwOW1MNlNQODFwb05jRnh4alRKa3U4SmxCSER2WnAxUnVkNHlvUlQy?=
 =?utf-8?B?dGswU2MrYkR5YTVmMXBtYWhuUnY1QXpuYkNZQ3l4WTk1ZWsrbGR0NXFMQ09H?=
 =?utf-8?B?MERvbVRLKzZrMW9JdXBteWhyZW5mTWJpcXl6TU9yWkVCbVJXTWJsZW9xRmRY?=
 =?utf-8?B?NDdXQ1liR0VBK1JIRUVtU2kwYUxwMlVPV0RPVGZzdFZFSnNXWDkzOE12Njdx?=
 =?utf-8?B?TmdCU2JrVVgwMU1PZTl4MWRrYmJKT1R6N3lBcTEzSlRNNTViL09iZmkvdHZW?=
 =?utf-8?B?UEVqTVM4dHVGYWJLd3B0dUVQSWdqU3Vsa2c5ZTgramlNTmM4dVhnMkkzUmpp?=
 =?utf-8?B?RC9FbFh5cDBVS3dVY1pJVmpzUjFhNUxJMUh4M3pIeVBYMW5CaFA2N0lvSERj?=
 =?utf-8?B?MnJSSTBSSnFSZGtHQ2QxbFB6Mkg5SUx5TElGUUM1U3ovbVcxTXNDYkZkS3lV?=
 =?utf-8?B?VU1hWjdWbDBlM0pDNVJrNmg0SVNNT1U1K3p1VXU3bWNpTTkzMXlqRHlFVEZD?=
 =?utf-8?B?VUZ0RjBzTjVXRmExSUNhbFcvUXJSWldEQjZvWW5VbDJpQ1VialAyUkhKQ2h4?=
 =?utf-8?B?NllUOXh5SUw0TTlnOC9EV3RxSC9tcjNiZHhIdTRUdE1oaDVJQ3dPZjBVOEF5?=
 =?utf-8?B?bUttekcwT1g5REM5Z3hqSlZaa3J1RkFRY0JNSUxlQjA5THMzREt6eXZseXVh?=
 =?utf-8?B?R00wUnBpMEJXZjBQOGJjSUNrcmFyRWZNRHhoamZnZ2s3bmxkUUNONUZleUxv?=
 =?utf-8?B?TmlHemJNTWdzNVR4dlRoeEM3SFJkYmlJN1Rsa2NxSkVyNGEydU15b0RTREYy?=
 =?utf-8?B?Z09ZTUNlQWxSNmxtaE9qdERSVlFxaHhWYWNXL1NxdkMxRlJnWSt1aEltZ3h0?=
 =?utf-8?B?TE0rVkhEaXl6SzBBUW93TnA5cyt1KzBhcWsrK2ZJektoOXZUY0o5RjlROWpn?=
 =?utf-8?B?b0l0Rm9HeDVoSW1mYkV4NEJ3NFMvR2xtcE1XbjVHV3pKVjFLR216KzZ1cjM4?=
 =?utf-8?B?cXBtY0N4eTJYdDRlNWN5dXgrL2J5SU5xcHV4bFo4dCtEemRSb3ZOVFJSaFZG?=
 =?utf-8?B?ZDNrbXNmUEQ2OSs4TlhWaWpLVEpjbjRRZzhHQTZLcHNsbk5IRjFlUmg5YS9w?=
 =?utf-8?Q?0fBr9FdvFvwDnCDAZXVL9p5Ym?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2266fc-331f-4308-bee0-08dade117b49
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:26:29.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/jR/MVLmBR1ZJfyt7V7Vae8wdiGMvcvRJEdIxFTqBNw4d0NXV/ivzcMMJr0VHhGpxkefpQxlY7jTb4H02Oizw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-12-13 02:29, Christophe Leroy wrote:
> The changes are absolutely not specific to powerpc. You should adjust
> the subject accordingly, and copy linux-arch and tracing and probably
> also ia64 and parisc.

I was hoping to get feedback from the PPC maintainers before posting something 
more widely. I'll send an updated patch which addresses your comments.

Thanks.

> 
> Le 12/12/2022 à 22:21, Michael Jeanson a écrit :
>> In ad050d2390fccb22aa3e6f65e11757ce7a5a7ca5 we fixed ftrace syscall
>> tracing on PPC64_ELF_ABI_V1 by looking for the non-dot prefixed symbol
>> of a syscall.
> 
> Should be written as:
> 
> Commit ad050d2390fc ("powerpc/ftrace: fix syscall tracing on
> PPC64_ELF_ABI_V1") fixed ....
> 
> 
>>
>> Ftrace uses kallsyms to locate syscall symbols and those non-dot
>> prefixed symbols reside in a separate '.opd' section which is not
>> included by kallsyms.
>>
>> So we either need to have FTRACE_SYSCALLS select KALLSYMS_ALL on
>> PPC64_ELF_ABI_V1 or add the '.opd' section symbols to kallsyms.
>>
>> This patch does the minimum to achieve the latter, it's tested on a
>> corenet64_smp_defconfig with KALLSYMS_ALL turned off.
>>
>> I'm unsure which of the alternatives would be better.
>>
>> ---
>> In 'kernel/module/kallsyms.c' the 'is_core_symbol' function might also
>> require some tweaking to make all opd symbols available to kallsyms but
>> that doesn't impact ftrace syscall tracing.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> ---
>>    include/asm-generic/sections.h | 14 ++++++++++++++
>>    include/linux/kallsyms.h       |  3 +++
>>    kernel/kallsyms.c              |  2 ++
>>    scripts/kallsyms.c             |  1 +
>>    4 files changed, 20 insertions(+)
>>
>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>> index db13bb620f52..1410566957e5 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -180,6 +180,20 @@ static inline bool is_kernel_rodata(unsigned long addr)
>>    	       addr < (unsigned long)__end_rodata;
>>    }
>>    
>> +/**
>> + * is_kernel_opd - checks if the pointer address is located in the
>> + *                 .opd section
>> + *
>> + * @addr: address to check
>> + *
>> + * Returns: true if the address is located in .opd, false otherwise.
>> + */
>> +static inline bool is_kernel_opd(unsigned long addr)
>> +{
> 
> I would add a check of CONFIG_HAVE_FUNCTION_DESCRIPTORS:
> 
> 	if (!IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS))
> 		return false;
> 
>> +	return addr >= (unsigned long)__start_opd &&
>> +	       addr < (unsigned long)__end_opd;
>> +}
>> +
>>    /**
>>     * is_kernel_inittext - checks if the pointer address is located in the
>>     *                      .init.text section
>> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
>> index 649faac31ddb..9bfb4d8d41a5 100644
>> --- a/include/linux/kallsyms.h
>> +++ b/include/linux/kallsyms.h
>> @@ -43,6 +43,9 @@ static inline int is_ksym_addr(unsigned long addr)
>>    	if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
>>    		return is_kernel(addr);
>>    
>> +	if (IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS))
>> +		return is_kernel_text(addr) || is_kernel_inittext(addr) || is_kernel_opd(addr);
>> +
> 
> With the check inside is_kernel_opd(), you can make it simpler:
> 
> 	return is_kernel_text(addr) || is_kernel_inittext(addr) ||
> is_kernel_opd(addr);
> 
>>    	return is_kernel_text(addr) || is_kernel_inittext(addr);
>>    }
>>    
>> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
>> index 60c20f301a6b..009b1ca21618 100644
>> --- a/kernel/kallsyms.c
>> +++ b/kernel/kallsyms.c
>> @@ -281,6 +281,8 @@ static unsigned long get_symbol_pos(unsigned long addr,
>>    			symbol_end = (unsigned long)_einittext;
>>    		else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
>>    			symbol_end = (unsigned long)_end;
>> +		else if (IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS) && is_kernel_opd(addr))
>> +			symbol_end = (unsigned long)__end_opd;
> 
> Same, with the check included inside is_kernel_opd() you don't need the
> IS_ENABLED(CONFIG_HAVE_FUNCTION_DESCRIPTORS) here.
> 
>>    		else
>>    			symbol_end = (unsigned long)_etext;
>>    	}
>> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
>> index 03fa07ad45d9..decf31c497f5 100644
>> --- a/scripts/kallsyms.c
>> +++ b/scripts/kallsyms.c
>> @@ -64,6 +64,7 @@ static unsigned long long relative_base;
>>    static struct addr_range text_ranges[] = {
>>    	{ "_stext",     "_etext"     },
>>    	{ "_sinittext", "_einittext" },
>> +	{ "__start_opd", "__end_opd" },
>>    };
>>    #define text_range_text     (&text_ranges[0])
>>    #define text_range_inittext (&text_ranges[1])

