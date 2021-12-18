Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FB0479B08
	for <lists+linux-arch@lfdr.de>; Sat, 18 Dec 2021 14:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhLRNf4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Dec 2021 08:35:56 -0500
Received: from mail-eopbgr40099.outbound.protection.outlook.com ([40.107.4.99]:58382
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231189AbhLRNf4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Dec 2021 08:35:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEyD4y/X1uIa8RLLZmHnBpgwyYOnDluW49LvqkTIhk1tNGSM10BR81LSilUaUxznTM96XgaqUBWE2jvVfR5na1JXHzUjRunIt8qIu3qNp0n3DPCesqDfQOkhMM9SqhllshFvA2jf5vhd53lufR6xjEXXmgauxLRAILSwTa4B63LNGlh3ZyTacix9no7kDBJlCSAFVKq4KfXCt940Ac72hHTBFvaBT5w1DMWaXCsjItTm2q00vwnhfr7qrCk5Trrm/4i8IMXDHhU/8qZCVybJLxlAs2BIBv+eCesa1nIpdpKNGRLK4Vk174ROc0BK6C2uv0Tguy9ogubXYSYaSNg5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbeVq7zEaHMJSayr7L19zA7bWnJ9Szka7DtKuNdsZ2g=;
 b=Ba89hmEOX8gC6O+B5/mt/u5kr6EdBvoBiP3cC9etabW4IlM+Yqw+Avr1KLWdGJHZYAD47MrpsQgZoRWW63PlpvI399EAgI3j/3E70DKh97rNhMVPzPTFZUqQ2ywjs34NDKulX9nO665aXW3uwTJuHPoax2tjlGSR7v2ivp0hUmVD/C84dbrdLjhnIQfaPtGETbHskLItUXsQ+9G8Y/cMKrb8HfWc/4Tka1v1TE3Y4f1P/zC3Cz7XC1a6aBXkO1Yhwt22q2tPEjxm7vxh+eqej1LTRDCHzKuO0w5SaxsxDQG6H6LJIH1iWDrQ6z7Yxljx17LuoZxRFYUm6PCN7mPW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbeVq7zEaHMJSayr7L19zA7bWnJ9Szka7DtKuNdsZ2g=;
 b=XcRUAAIJFUhfnNBgkBMjt7gVUBfjZ7qri3WwRlSYCMYNBcG0eErXdYnId1Ig1kh/6pS0zeZCuXG3ZV8OAZBqmiiT1NMNO0WE/aPoIVjzYC6IKzO881OVD/pcVpt3vWnUJEL7pfWcOYuJvEqc2e5Uf3WZ0orPTgm/Ioy0D8GuW5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR08MB3774.eurprd08.prod.outlook.com (2603:10a6:803:c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Sat, 18 Dec
 2021 13:35:53 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71%4]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 13:35:53 +0000
Subject: Re: [PATCH/RFC] mm: add and use batched version of
 __tlb_remove_table()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        kernel@openvz.org
References: <20211217081909.596413-1-nikita.yushchenko@virtuozzo.com>
 <20211218003742.GL16608@worktop.programming.kicks-ass.net>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <8f39f74e-a108-ecd2-03f3-154373fad4b4@virtuozzo.com>
Date:   Sat, 18 Dec 2021 16:35:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211218003742.GL16608@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0107.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::48) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aabd080e-9217-4937-98b4-08d9c22b4fd4
X-MS-TrafficTypeDiagnostic: VI1PR08MB3774:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB37741B0BE2ED0CE5C1F5D9C8F4799@VI1PR08MB3774.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qtn135OldcOhB+yJOGw1L9viqsCIlWBAEJP2N/V9KIcDrbAXhoXtp6KqAfcH2nYm8wt0nxTa9RThpiaZOCWV0HwYnTmL7x6X8hjpEzXG9IaciLqsayh+CdUn/EGburB48huz1StkqU0nyrwSKNjhDoM73yX/iB0DkjVJAkuuIaufcrYHD8TyjXSGairX3NYUHW4y2Qs4stt34c+DN4Mbt7+t1mBbLmVt0fdvs4pEGEzwk4UgQ30CNHQJ+3D08xuOBX54dMj3IWy+cN8oo2/rYiRGBCey+WQhU+CqhgUdOw6b/vgN0hpMFrxQQ3xS686/xZh2HzLndSzEIzgWUZ2SrBhmMweT3Kh8VZxHbBcq2KdisYI/Gxc7f10tnJrIjFbFr0zt3Vbn51G8P3nefK+d0D29uJugCAWbXuYG8rOjzdJKinY8Y2WsMaydYvtpJoAcRtAYAQABQcaK8phGeB2ZONWQRmU60z2PCBlZRs4Cpq8a+3ioG0MnZlYHmSYqcKTClxjIYVC3L3+mJUVO/8mIDc5hmYndBIexeLuPktkEdlHQbAo0tCom6FAuFZYoiibXe3M2aBZ6wVt2ME2dTK5xE8ThHZQXCYeOAp3H6y4hQ6bzvG5LBPNy//VuodBmm92dyJBqbazfOXBSB6tIuuZaA4RbkreeXqUa2oWW/Azg2+58s4Rr/z3cWz0gscaK+ZlbbC0FGZ4TP9UYKoyMBaFobSqwhx3Rh8BAdgB+o4d8Za8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(7416002)(38100700002)(31686004)(6666004)(107886003)(508600001)(316002)(5660300002)(36756003)(2906002)(8676002)(8936002)(4326008)(2616005)(66476007)(66946007)(66556008)(86362001)(6916009)(26005)(186003)(44832011)(6512007)(6486002)(54906003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEY0cDdJQXZQRytiY2dPMVFSYkVlNlU5aVBlSUtQa25rVHhyV1lXS0o0S2gx?=
 =?utf-8?B?blRRbkFtVnNtUGZmMFI0ODRvQks3V2VodCtCaUg5UFBnVFlZLzFkajlSeGQz?=
 =?utf-8?B?SUxpZGd1MDFiZmVwY0hlcjlFeThLTW1RVmx6VVpuaUJFR1ZDd055MHpUb2RY?=
 =?utf-8?B?Z3ptbSsyQTlkYlNXbmlOOGJQZ1EyeVRvNzBQbFEzUlVXVzZyMDFIeENPMC82?=
 =?utf-8?B?elVFVDNzblBjQ1lrTE90c1poc1VLV3lINW1aczZLUEFRTW0xbUZDdHFSdGNR?=
 =?utf-8?B?dzlpWDAybXh1UVJ4VDFwRGRQd2h5TDZIQzd3Z0d6RmVWZzljVEpQTGNoRTRq?=
 =?utf-8?B?WDJCKzRmRUdMQ2RmRVlpeHlXdEZUTUxyVXVtaVlsUDlMM1FuNHRQQW1tc1Fx?=
 =?utf-8?B?TTRua3RLTWt0dkRWTHdwUDd4OU1lTjFoZGR1K2tDdnFxTnpteXN4WmR3S3Y1?=
 =?utf-8?B?YXRJMHlsQTgwU1ZpcUdDV0ttLzZjVlJZSWRSZHU0a0duK0NYeXRGcnVFd3Va?=
 =?utf-8?B?MUxqWGxTeDZNMGJncFdwQkdZdnJpT3hJOVU4dXhJZG8raW96anY1MGw5WVBu?=
 =?utf-8?B?M2IxSWUzZ1ppYWV1Q0dXSi9EZlVqWTFVUWlOdmg2eDdWZ1Rhb1FDbk0zbm40?=
 =?utf-8?B?SUl0KzkxMlpIamFUUDNhNTVISjFENk85NzBnMGNLQmlORExvWC84RW9RM1pp?=
 =?utf-8?B?dGFGd0F4emMvUXVROXdlVG5CY3RBUTkvbXM1WVJtcDhYbVAybUxPZUdDY09D?=
 =?utf-8?B?dVZ4OUpVVkNMS2p3OTh6MnpGWkdzNkExTVdpdFN4a01STlMybGR2RU5QOFpx?=
 =?utf-8?B?UlVDU2VqVUJncGRqZ0V2VXhLVkdyVExjckphbHJGYUtpdmZzNjQ4TTk1S1Zr?=
 =?utf-8?B?QmUxaitUQ3B6QUp1dHZRUG9XaDhuNndCK2JhWGllOVg0amdndnhzVk1OMk1J?=
 =?utf-8?B?VEdxRmRlWFdzRW55bTUxNWJETTl1c3pqSXNTWC94NU4zV3owRXlzUUpidEVQ?=
 =?utf-8?B?NzJ3c0w1N043Z0dZcUVQOFJ4Q0p4SzRyZkljV3dLMTZPREY5NzdUZ3VMTnVB?=
 =?utf-8?B?MGUzL1JMaVBVZGNXczhjNjRldUpLU2tDaGVTRWovTU42OTF5MWZSZ1hJQmMr?=
 =?utf-8?B?SGV2aFNETXJpV0Z4ZHQvZnZ6WnN2WCtpU1Q5ZFd0clZncmpUdEJvaDZySHdh?=
 =?utf-8?B?clNGNTROdUdzY1JYanpjK1NITmlvU3dsTzJZeVREd2JicnE3UkFEUEhvTEZj?=
 =?utf-8?B?bUQrWDhXU0tFVWlpcXJHaHJFWkJZVHZUUkdlMVNVWWxHdHFrYVAyVVFnT0xo?=
 =?utf-8?B?VnAzaTlDNHY3bXZCYUdQZWYrc1UxZE95K1gxWGQ1ekoxc3NKS3dZbkZIb3dp?=
 =?utf-8?B?TnJTSFFjSmZONDZXWDFxWEVYanVsRXBQdDJEL3FZRlpGdy84RWl6TXJFYmp6?=
 =?utf-8?B?dG9YUXI1SnN1UnczTC9WSzBzTTZNWmpsT0kvVVBHMktVbUl4b1BoL3NoblhS?=
 =?utf-8?B?aS90NGtiMElHV2hBNkFHNlZsY3Zxb21PY09KaG1ZREhaZU9TYy9yNjhBNXFQ?=
 =?utf-8?B?eDFsNG94eHNvVlkxNXVQZ1lmYnJQaDBsNTRnVVNmMXg5SlVhWngwY2VnUTlG?=
 =?utf-8?B?eUJXbEZtUjJOOU9QVFFBc2VTNXJXZ2t0WnVhQ1dMK3dyY1pnTXRGYXUydFlQ?=
 =?utf-8?B?OEk1LzQvU2dQd0Fra2hmc0Y1bFlQdm9OR3pzRURyVEVxY0ZGMDY4WU5VQ1dH?=
 =?utf-8?B?cDhncE9JbHJGL3BDaG1iS1djeFpUVkNTQmRITEhENTFlMFVSdEl0RWVxVmV3?=
 =?utf-8?B?dnNNOVl4WU5qMzE4T1IySnE4enFTQVVGaUdSbG1mNWlqdjUyaWNEdS9LcXkv?=
 =?utf-8?B?cFB0bTVIaGdHOCt3SkR2YWRiZGZGaDFRU1dQb0JlWlk1SkdDRW9sNm94ZmI0?=
 =?utf-8?B?ZkJkdkRiL2FnV0NKNXczSGdWZUhSNEt2RURRSTF1RTdieXpOYkt4aW80YkR0?=
 =?utf-8?B?aitjT3JlSENjVU1xNUFIR3VpK29EK0JSRzc5RzVNTjZpWDhDa1NoSmdOSkNW?=
 =?utf-8?B?L2xjNkRjTVE0akU3NjFFR0x3NFFKYTc2YytnYTNhU3Bua2FnaGg0MkdBWXVj?=
 =?utf-8?B?TTE2MnNrN3hpSENBcHV2bVpSc2FTUS9KQUl4UmJOTk1HUXpRYzlXM0FpYlZx?=
 =?utf-8?B?QStEeFgzRHJaOEFKY2pKa2lHVmlJd0RvaHJDZnpJNWVGb1lpaFBjM0l3T2JK?=
 =?utf-8?B?WEFXRDB0ZGlMTElOMkFKTzdmQVlnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabd080e-9217-4937-98b4-08d9c22b4fd4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 13:35:53.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YvIOEpreYzDf/7CIktzBhJwpaNkUIxs9O7a5Zagj2NJnr/CbPwt8cfxuD33ajWGYdJjmRwJc2A2pDtUWtB5nWc2M4+2S97LshN6YInGVqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3774
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> Oh gawd, that's terrible. Never, ever duplicate code like that.

What the patch does is:
- formally shift the loop one level down in the call graph, adding instances of __tmp_remove_tables() 
exactly to locations where instances of __tmp_remove_table() already exist,
- on architectures where __tmp_remove_tables() resulted into calling free_page_and_swap_cache() in loop, 
call batched free_page_and_swap_cache_nolru() instead,
- on other places, keep the loop as is - perhaps as a possible target for future optimizations.

The extra duplication added by this patch just highlights already existing duplication of 
__tlb_remove_table() implementations.

Ok let's follow your suggestion instead. AFAIU, that is:
- remove the free_page_and_swap_cache() based implementation from archs,
- instead, add it into mm/mmu_gather.c, ifdef-ed by a new Kconfig key, and define that Kconfig key into 
the archs that use it,
- then, keep the optimization inside mm/mmu_gather.c.

Indeed, the overall change will become smaller then. Thanks for the idea. Will post patches doing that soon.

Nikita
