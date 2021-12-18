Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4BE479B5E
	for <lists+linux-arch@lfdr.de>; Sat, 18 Dec 2021 15:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhLRObx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Dec 2021 09:31:53 -0500
Received: from mail-vi1eur05on2137.outbound.protection.outlook.com ([40.107.21.137]:19872
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230237AbhLRObx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Dec 2021 09:31:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+WLDFqlZ4x5bhv5yU3vBV3d4X64hryHHuktuZx9YK9C9NP2/11Q4GwDW7a45XQVMHPU55dY+cDUoZ+BoOtH92MJNIRnOlQytf92k61C7rpjkZQjLnvwZBs6FW0/5X+FCWjhhttS3iQMKHXbfphn1uXfp9vRe9jjQZeOqueygzvqtGmbdkFx+OEaaMX6EXw3RcJre69Fc9lKnKPn+vV3LgnIZUXheASSlsimp5NtOuV7I5DQcqVjMzcwpkB4QMiI8E7bchEmwqc61THYasOapCg43DEUO7+zKj84FhY+j7YZCNc1Oxv7Wok7dKsaTenAEiF7/NPZIfeqLi4SFdQ1Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxDT9bbu+LB4qwOjc5O4MNgs+jXEZ+Qpsn9QoQWCZUI=;
 b=T1cjSvKQiHXjzS0NHy+kjFrorvETOIquMzwfT9g5g0ViBNQFdxrF/0Yl0S/iYQ5O6pmkHG+fQGjO9mVcKajotlb9Ygu4ZoOPQs8/88CkyP4IHBF2WNa6ow8E0qInWGcOpI+hGSQ7btlc85EpI80gdLAmQxfIt+tG8g2qqu5b8PmwYRFcRvFpfiST3g9TTGGiUqEoRlVNY7m26Ej4nMd0R5w4kwEdiD3iiauhDb4zrOxosYJ7feWppvM1f4kV2gaXtdrlBPUMmHssuJz5lqlVB5ruPFDWd0HxpXe656OHzLbbomJkH9Ft60+4Wvq/K/110Uce78pZpRlprCiUTVE3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxDT9bbu+LB4qwOjc5O4MNgs+jXEZ+Qpsn9QoQWCZUI=;
 b=fNc6rF9+EKRQ55Q4JWXxC0TH+3/XsfB65MiweBcQzP6gM5xBKA30liofOAI98/yfKmlmEhYxeD+6PozBuyJA2PtpjElR9tAqB7s7PnBf4tM8eV7nkiA1cpFS485riHFkQZ3yJbJHmQNhSU7U1FLDvPCIKsdopnqoDvFh6kwIZxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR08MB3997.eurprd08.prod.outlook.com (2603:10a6:803:e0::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sat, 18 Dec
 2021 14:31:48 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71%4]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 14:31:48 +0000
Subject: Re: [PATCH/RFC] mm: add and use batched version of
 __tlb_remove_table()
To:     Dave Hansen <dave.hansen@intel.com>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, kernel@openvz.org
References: <20211217081909.596413-1-nikita.yushchenko@virtuozzo.com>
 <fcbb726d-fe6a-8fe4-20fd-6a10cdef007a@intel.com>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <d6094dc4-3976-e06f-696b-c55f696fe287@virtuozzo.com>
Date:   Sat, 18 Dec 2021 17:31:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <fcbb726d-fe6a-8fe4-20fd-6a10cdef007a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0074.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::15) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f98acc0-fce1-403f-2641-08d9c2331fd8
X-MS-TrafficTypeDiagnostic: VI1PR08MB3997:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB3997B05C6CAECD75EF97A8FCF4799@VI1PR08MB3997.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzXu6fqi1R0YLR7mYCVba7pbvp5GjXce7rDCo0fK5vyCW2xE+WLhGeZTUCqWk2AvzE0E/eVKYtY/X6myCipZJOVaaiZhqI3pRxZVmZcHKkfpDRMY/aSk8k9ADO57rjbzccvIa1z0HXWpBrJv2JZZlzh+OGiV+7k8D7tbUKQyvaurJ0kk9WgU/7MOqwDKHvhPwSSUU2Z3YqsL9xOqVd0R8ZvbOzIunQtkxV2IdHTdjTPM42PQSJh2LPePbC16V/PnBTwm3OGmUa2ryjokw44ofYU8baafKE+9bmvfA+vFTyKVoH2kCxbb2ddavKyaz7Zw5St+ybO7ReTtAldduXUf16LH5I0K0C1ddKI52Dq1aUdnmX0qKslhRxJy4t5dy0TsLYDNJQixpzKzZkSi6gfDkzRF90pIkEanU0S3ji5PC2I2Z6q5+oI+odQ8hNmOSBBj1BqImCbn2+Bq5Y24UdxJ1Z66h1L6LQBR3MccRA2POyF9TPcWqrrORJ/u+SDmx+XjvhHdevgDW+QN+W1QgeesxC0xqSHc+jvE/HamFYNcmf7CuOfc98frP4BOlOQu+3RiSU7r9ncak8O+UDPbujjNHxkfYnRcB/mfONdhVBXotbdrymemFG1I/F0ABdlxDNqaQJr1UzPrGFDOTVlRoDgK/YdZKjCD1dl8HeypKKLB+IgZD/eyk/tGntRW8KXSsdmQbjU0kAmI/ewTqQxpkQHEpERsJpyIlMGym3VBGK3p0V2Jeg90XgMs2kWK9Js1qXX5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(921005)(31696002)(107886003)(6486002)(86362001)(5660300002)(66946007)(83380400001)(66556008)(6666004)(66476007)(186003)(8676002)(316002)(508600001)(36756003)(2616005)(6506007)(26005)(8936002)(44832011)(7416002)(38100700002)(6512007)(4326008)(110136005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01NT2hRZnA3RU0xQ0RqdXJWb0VIa2FSejlTQlB4Nzc0V3BmU0Fhb3VGSmY2?=
 =?utf-8?B?ekRtdWdKeDEvOWV3OFBGNDFjV3ppcjYvenpNNlpONE5PY3R3NzMzUzlUbTI1?=
 =?utf-8?B?UUFNRGRWUXl2NDM1T2hwYUFHbXJOTXdXcXFVa0ovYk5zam15UmkrUkVFQld3?=
 =?utf-8?B?TTBTUkh5Y0dIU1JTT3Z1RHF3cjNaQlJhMllJQlRBV3QrcjROamdBNEJLUi9s?=
 =?utf-8?B?ZEFMS3UrRDE1ZExPOVBYYVFremQrNkFPREdoejM2MmRUbFFDMEJiYk1JVFN6?=
 =?utf-8?B?Z1kvcVJyRVQyRkJyT25JN3ZHUjdublgyaEdOa0FjeHU2MlJsZmp4MndIWVJT?=
 =?utf-8?B?TjNkbG1ZUFhxNk5TeG1tL2pEamd0VG9DaFZYWS9tZlVJakg1RVl1Y2FEcGd6?=
 =?utf-8?B?aTgrdzE0Z1FrcExuam1YS2Q5SFZtQmVPdkVvalA0R3FYbkUvd1VESVlSUTkw?=
 =?utf-8?B?NXI3UjRPdm9SQUxuUGhJemI3RkhFdDlYVkt4eU1Jc2VCdXJsWExvSWVZNUR4?=
 =?utf-8?B?b3F6dk5GZmZnbGx0T3VCVE1WaTdTY0RTeGRod0lSekEvZVJML2dJQXM2dHhU?=
 =?utf-8?B?SXpVM2hwa0Z5M1VqZnRZWTNKcUMzSHp4Y1FnRmd4RCsyZWpMNDQ2YUV0UVcx?=
 =?utf-8?B?NmgwNFR3aVRwNU1XL1Q1SWorU2pFZStodER4TjBseDN0bFB0aFdPRHZOa0N3?=
 =?utf-8?B?RlpDb0ZCd2RFZ203MG82Ryt6STBZazBKL3hFVVhBQnhXc3YwcS9lSEp3YUdR?=
 =?utf-8?B?SURoREJqRXc5NnQ5Y2VvRDFMVEl6ak1GVGgxTUlsUytmZmVNNDRGUGJZN1Nt?=
 =?utf-8?B?Z0owNXRteVFlZy9rcDJaTE4xVTNDV1pYVDNQRFJLa0VEKzRXaWxhR3RDNFZ4?=
 =?utf-8?B?eUtQQ2hZTkplQWNRYUFNVHFuUE1UVzUybVROaGJxdEEzS0NrR1FDRGNFWUts?=
 =?utf-8?B?b1A1ZkErb2FQcFhJYTB3T1hCVUV6WWNoS0VGMHdWZFRoMUtqSGc1UHA3SmR5?=
 =?utf-8?B?NXJSNkdSTHdCTC8xNzRYRVU5WVZNMGgxN2dReG5yOUd1SE9QQnZoS1M0QTlP?=
 =?utf-8?B?TmhjbmdJYzgrSS82b3RHYnRlUWdGTTJxcW4xK01EZnFVVWlpbVd4aWRGMW55?=
 =?utf-8?B?SExvamVBL3M4VjNnMkdZdEdrK21RUXRJMDFCaEMwYUcrblo3SnpVTnMrNTdT?=
 =?utf-8?B?TWxvT2xhTnNhS0xMdFcxUXF4Q0x0Myt6Yk05TnZQMUZ6QW5MbDh2UFJlNzNP?=
 =?utf-8?B?WmlZMzZYdXVpc3ZnTEYvQXppemtxQmxHS2ZjRjc3YTBnYWpLMGZQTTdidC9F?=
 =?utf-8?B?RGprNVNaTkhiK3QxNVNaTlUrQWVCZk9KV1pjcTZwWWo2ZHhnV3B3ZU15bEtE?=
 =?utf-8?B?ZWhCSU1RQ1ZTdUhUcE1PZlFOVkhPRldFSVJ6N0dJSllnSmJsdVNnVU5WRnAv?=
 =?utf-8?B?eVQ2TVV4dWpOVXZ2VythRHA4WVM4SUdOVVl0VnB3SDZCeitoWUkvYnZXd0Rm?=
 =?utf-8?B?V2NoL1QzT0dxZDVsN2t6c3VJdnR2VU5PR1JYN3dqZEQ4Z1lRY1NyOHNqaU94?=
 =?utf-8?B?WHJ0cTNqK3p6UVJFOHNOSThqdTNkM21iTGdTRDRYdmpwWm1DenVBaFdIUGdK?=
 =?utf-8?B?MFZWTWJiT2pwczZiMTA4QktrOWc4SlhBY3BzZE9FVTh3RHI2TUF0bGphWmFt?=
 =?utf-8?B?MlJlbjluSHhuU3A3eXBnb0UrUXo2dE9rSUhhV3dtaWMySjlBTmVGYjN5SWxP?=
 =?utf-8?B?ZGNUd2dkc3dESFVIR0VJMVBWd0tsUHhBK0tkb0ZWaTZ4Yms3YTh6Um0xdGs1?=
 =?utf-8?B?Q0MxUnFEZDFpYWptRWJLRUpDbHA2blJVcmlaOWJwaCt1S3N2aEhyZ1ZTTzNJ?=
 =?utf-8?B?Zm9wNXFrbUxjclhTS0Q5T3JHQVlWVnhGblhYZUZ5b1NIUDhyQ2dwVG5xa0tp?=
 =?utf-8?B?MElxR1lZb3lKcUNqS1VyZEl2Z0l2KzFQZmsvd0U2aHNpOEJEam1GQXhWRVUr?=
 =?utf-8?B?THVvSHltdWhscmx1UnhSbjNtVHlFdVBTQXB1MGtZS1JFdVl3T3NqQmdSRGhX?=
 =?utf-8?B?ekphekd6WWFyWEdZL1B5NGplOFFHL3pjVTQwYU85ZEY4SGdWZmxBVzNyTVgr?=
 =?utf-8?B?eWhxelZKbm5mNlVrWTV0MjhrZFUyeGp5RlAvTTJoUTB0U0hKbVhnQ3V6S2gy?=
 =?utf-8?B?dStNSGVjSzBLeXBVOFFON0FjKzlCQi93aFVuMjBHUWNkRWhKeEUyS0ZCZUZB?=
 =?utf-8?B?Z1VJUFZIQWdPT1l3YlFNSisvWHlBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f98acc0-fce1-403f-2641-08d9c2331fd8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 14:31:48.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Di02MfvmZq/ZzeKPwiVnRju+jpJ8HzLGAoa/XlQXOKBEaFBw4gGqhLhFEXSSuGqsus6a7rVb6e5N6FLVpEVy2tI8mYtpmuhom0qvwDsyVVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3997
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> This allows archs to optimize it, by
>> freeing multiple tables in a single release_pages() call. This is
>> faster than individual put_page() calls, especially with memcg
>> accounting enabled.
> 
> Could we quantify "faster"?  There's a non-trivial amount of code being
> added here and it would be nice to back it up with some cold-hard numbers.

I currently don't have numbers for this patch taken alone. This patch originates from work done some 
years ago to reduce cost of memory accounting, and x86-only version of this patch was in 
virtuozzo/openvz kernel since then. Other patches from that work have been upstreamed, but this one was 
missed.

Still it's obvious that release_pages() shall be faster that a loop calling put_page() - isn't that 
exactly the reason why release_pages() exists and is different from a loop calling put_page()?

>>   static void __tlb_remove_table_free(struct mmu_table_batch *batch)
>>   {
>> -	int i;
>> -
>> -	for (i = 0; i < batch->nr; i++)
>> -		__tlb_remove_table(batch->tables[i]);
>> -
>> +	__tlb_remove_tables(batch->tables, batch->nr);
>>   	free_page((unsigned long)batch);
>>   }
> 
> This leaves a single call-site for __tlb_remove_table():
> 
>> static void tlb_remove_table_one(void *table)
>> {
>>          tlb_remove_table_sync_one();
>>          __tlb_remove_table(table);
>> }
> 
> Is that worth it, or could it just be:
> 
> 	__tlb_remove_tables(&table, 1);

I was considering that while preparing the patch, however that resulted into even larger change in 
archs, due to removal of non-batched call, and I decided not to follow this way.

And, Peter's suggestion to integrate free_page_and_swap()-based implementation of __tlb_remove_table() 
into mm/mmu_gather.c under ifdef, and then do the optimization locally in mm/mmu_gather.c, looks better.

>> +void free_pages_and_swap_cache_nolru(struct page **pages, int nr)
>> +{
>> +	__free_pages_and_swap_cache(pages, nr, false);
>>   }
> 
> This went unmentioned in the changelog.  But, it seems like there's a
> specific optimization here.  In the exiting code,
> free_pages_and_swap_cache() is wasteful if no page in pages[] is on the
> LRU.  It doesn't need the lru_add_drain().

This is a somewhat different topic.

In scope of this patch, the _nolru version was added because there was no lru draining in the looped 
call to __tlb_remove_table(). Having it added to the batched version, although won't break things, does 
add overhead that was not there before, which is in direct conflict with the original goal.

If the version with draining lru is indeed not needed, it can be cleaned out in scope of a different 
patchset.

> 		if (!do_lru)
> 			VM_WARN_ON_ONCE_PAGE(PageLRU(pagep[i]),
> 					     pagep[i]);
> 		free_swap_cache(...);

This looks like a good safety measure, will add it.

> But, even more than that, do all the architectures even need the
> free_swap_cache()?

I was under impression that process page tables are a valid target for swapping out. Although I can be 
wrong here.

Nikita
