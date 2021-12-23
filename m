Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA2547E104
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 10:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347526AbhLWJzs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Dec 2021 04:55:48 -0500
Received: from mail-am6eur05on2121.outbound.protection.outlook.com ([40.107.22.121]:4001
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239351AbhLWJzs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Dec 2021 04:55:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ssg+xVzoTiiAYSZtN9pHpYos604A5I4PRfUpjHJnzR6kVdkN5BlC+FLFhf4u/HN5DDmFfMpe+QRy78JOZot6WB/E1GByXC9wLRALw1+3UlIeTmQITnRCC82o+RnuUVATiPBm2wQXZjvhI5iCq4CkIvUYuepo/bMBXgKFsyePU/uoNXMwU02y0y9bJnMcUNLWxD8AuERwwrHD9OkcxfmTMVN+q8dGyXOtZky0BKbbXi9zTnOMbagh2npqZDFzCMziAKBuAZ87JdqAPzSvx1aXR2ED5aQGjs9sDjIEzNyJrVB7Sl7hZCxUn9+2zjycU3EwFKkWM6mGOSNYZ9so7vSqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bDg3DgTznj1nYYpa6+ml0oS30/RxArF7kzxE1FeOO8=;
 b=VVQlZpaLWilmdR9Bjy425DgvYQWm/i624wr13wbH1ExXTHXFIn414Xw+WZ9fFuq5Ll40m5izetdyVh8QqZBBavNyyU+s8IgL9PtS+8JVoXNDk7dabOQkpLedPJcil6AsnrkEStDFJfCICETZ4WdxT0d8O3lFgDBzaaPcrTLTwazfce2AsOVVvlIEUDsF8D8Vl/35oK2criBD7+pU2xRPW9OY0oiKQwXFKPPHs8M2Vneqk3M6nOVTVKH4SIFZdIm/N7jqn7OT1xD6DTBQ5kPK8zTZxxy5P1sDC20RmrNVNfOewr46uAY4VWMrd5lgrLBD2YGer54doSNJvbZXD/8/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bDg3DgTznj1nYYpa6+ml0oS30/RxArF7kzxE1FeOO8=;
 b=RdomMqUERracOitAsS/3jc2+r3ajFaE0SIXkrDklfGl42zLWEVukeaWeK/n4Swuvmu/4DvCF2skmhoSJVV3CkmOQT8ZMMAoAMByyP6NIhHspwMEJAwdhsaHBfPUNeYjsEaXziHbwRVOn1f7cD6gkIKwL7wcjPt59rLz6uuBxN+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR08MB5328.eurprd08.prod.outlook.com (2603:10a6:803:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 09:55:43 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71%4]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 09:55:43 +0000
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
 <d6094dc4-3976-e06f-696b-c55f696fe287@virtuozzo.com>
 <290cfe1c-564f-9779-0757-5ca281055e77@intel.com>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <22a7534c-4759-4e7e-de07-d33a3682c156@virtuozzo.com>
Date:   Thu, 23 Dec 2021 12:55:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <290cfe1c-564f-9779-0757-5ca281055e77@intel.com>
Content-Type: multipart/mixed;
 boundary="------------C841C10C78D715F3120DB136"
Content-Language: en-US
X-ClientProxiedBy: AM5PR0701CA0004.eurprd07.prod.outlook.com
 (2603:10a6:203:51::14) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f2e611-147c-46f8-74b1-08d9c5fa6263
X-MS-TrafficTypeDiagnostic: VI1PR08MB5328:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB532827F2AC4A997429EDBC04F47E9@VI1PR08MB5328.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:457;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/x4uxXR1pmYjchvjyqYs0mZLKtffTkJapTkTgEPIVNQNxrUXIHNgfj6wn6slCNAtCPwXvo2QGLo+012k8xw44MgqxfrCJpbPu9acPoEmZ3vX0O0XhcMkEGBSGNwWP5ZnJM4VHsP1homIl6UdQIbXpp92XwHtRs8A0nXQ2m+jTDHJpZDTD9HtiGs1KZb9JbqI+cqZl7bevklrUaZh5mv6NSNcSKhqaF/r/UM574u6qGpcOkvflKiTIbxhNE+3nsNprfq2JSSS+ipCADDE0jQlNOO0e1CUS386HgpTS/TCVDoYQ4Ym3ifyzISVp3XxTecLmHQ8es7czNoZJTiBP7+APlEU79nq0MPfhJ75gvdJWR2rdqnzJhj3YvzGvjcIHx4VZEJix5OsaL0lVVrj/4QFhHgG6hUiGO9+pv6ep5gYc4gdlHz7cbRPgj+15iDTlsPBCpS4A4Y7lYK+8uDhlir7+30BHNgr0Tlf3nRb50QEyUESRG4XLHwpgK0Ci9PxV7YN8WI9eo/rpGOaOuvtCEhTNAuC/NYH0e6RIWJZfnuGcWNpSNFcRpCV4dvkfVeXjMold/JknNQpPk2gYo10m5u1zPmfpfCbLrmenCmiB6d2tKabb1SnNyXn9WuL5+/jXufZfz75RkmP9+P4197Hx3snOeI/a1hJ58GnDUxBAaGmz1q4SadG5XQGmChvGM/+GAV8eJNGXJ7TPDk5EaSRMzmDh1TImJZHJX6pIhEQGk8CsftsPLSGJXethzuR98jRTLc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(107886003)(83380400001)(6666004)(921005)(5660300002)(86362001)(186003)(26005)(508600001)(8676002)(6486002)(36756003)(2616005)(110136005)(44832011)(38100700002)(8936002)(66556008)(66476007)(4326008)(33964004)(2906002)(6506007)(31686004)(66946007)(31696002)(6512007)(7416002)(235185007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhSTEtlT2NLS3p3dENhZlYxVWgyakxwRnZoTU9pMjRPRDJHSGVuUkN2VEhK?=
 =?utf-8?B?VkhHWDNYa01CZ1hIbllIUUgwUkg1a3JXdlk4TTJLQ2VrUm1BcURYNlJkNVJD?=
 =?utf-8?B?YmtJeFlJT0dkYm1SVHliQ1RjYUwzbUkrTS9iMXVvYnZYRGFFVEVUZUllTndT?=
 =?utf-8?B?QTBFa3lPVWlWVW9vdStDbzhwSHBIbGxHdkFRd0tOTjRaZXV2Y3J2RzZJN3Bs?=
 =?utf-8?B?TkFadzdSeXBpbGF2Rlk0ZHRSQWd3V2JaTEo3WWJXOENpcVRJUGZ4OEtkWERK?=
 =?utf-8?B?TSt3cVpvQkgrTmR5ZUxCTHphSER5cDdma3o4cVgvcS82M1h6RmZWWXB2RkRs?=
 =?utf-8?B?L2wzMC9ZUDBCRWZ4ZitFdzBYTUd1RTJMMVZHVXcrYkxENzg1YXBxRTY2K3dI?=
 =?utf-8?B?VkkvRDRXWjd2Q2JWamhWQUczVTEzWVIyb3MxSnhpQVlnVC8yRGFzc2QwYkYz?=
 =?utf-8?B?Z3V5bkNwMVozdlh6WHhRaUNKM09jdldITVR2VlpqSlZPWWxSQ1JISWYvQVBh?=
 =?utf-8?B?MEMxU0c3ZEVidDNCQTJDYUF4NmgySDZkRk5Vbis4UGt1VUlLSSttQzBUcjRa?=
 =?utf-8?B?S2lxdjlOcnN6dGlVWGtIemtiVEFENUhXSyszaGtyTzFMbjBLVXI0OWR6R3dk?=
 =?utf-8?B?cmNpaEUxT3k0a0p1Y25NZDJjV1dLTnhOaEZzakhhK3FyS0hlWWM5REZmSzdz?=
 =?utf-8?B?UWFTUHRsbnFNVjNwSG9wM3pZQnJndzFxdEtoa2M4SWt3dmJjNEZ3aGo3Q2s1?=
 =?utf-8?B?aUtxb1RZY2J5WmxEL0VXZlJNZjlXUGhJS1NJV2hjdUN2RUNUc05SVVZmTFlU?=
 =?utf-8?B?OThUNUdGK3lndmxiZE5wRFRuUDMrZ3BNL0tSQUVLbnFFMytnZmNWQ2x0Z2d4?=
 =?utf-8?B?TzdMYi92cWRHRSsrSzExa2pRei9ONGU4My9aVHkxb1A4Rm9yUzJGakhRZ3BV?=
 =?utf-8?B?SHV4Q2VScVlCRW44ditVclU4ZTdnMHppVEhUY0pvQmE5b1dVWjU1S3RwT1RO?=
 =?utf-8?B?MnljL1FHRHV3Mm5XOHJqNUF6OUlsUmkrWUJRMWRsUmVmUUlmYXpUVnRkSWJW?=
 =?utf-8?B?WW9HKzRjUlQyd0FtVEl6TjlYdkl3VXVOdFp3elVYOE96ejlHbVZSek1HU0Y1?=
 =?utf-8?B?bm1qWUtLb2RxSXk0WVZtcVZ2cWFnY25OZ1Z2WjJpTDhUTFpzTkNBa3NxQnZB?=
 =?utf-8?B?ekN4TlNSOHk5aHV1VlNlRWQ3VWVyak1mbzRhSFZhT0ZTTkJhVy9yQWhjWlk5?=
 =?utf-8?B?aVVPem1jTFpQVmI2cElNSU1LOENZdHZqT1dZNEVFMlR6Z0phQ3ZNTkdWRVBG?=
 =?utf-8?B?YURmN2R4M0hKdGNNZDIxTFJNUDJZZFhLdVZ5NjJnSmRhbk9lNnZqQVBkTktH?=
 =?utf-8?B?dmFDdExDUVJzVGxpb1paVnl0OFFmb2tQUGFWeDVLb2VIdGtrb1pvNkNGb2wr?=
 =?utf-8?B?MC9rblRpVmZBOHprOUFMN3lzYWYyVGdCVmJ0bUZyZjgvdm9YQkE1NnVoUkQ3?=
 =?utf-8?B?aXNIcWVLREtxTTk3am5TbDVUNEFUYVRGMm1xYmZaVXBGOFpXSjcvUkxHUjFx?=
 =?utf-8?B?NFcyY0ZoTHlDTm45WGREV1ljU1NvMXQzdmJGZk9UeE9NM1oyd3F2R2RxZ0p3?=
 =?utf-8?B?d290cnRmWU1nRnJ5ZXhSSDlxSWI3cmVPOGU4THRIMzhOeEE2RnFMYkd1Slhp?=
 =?utf-8?B?c0M0ZDUyUGxFNzJkN0g3R05zSjRkQjNYa0RsbmVkY25PQ0drNFhrelgvQmpE?=
 =?utf-8?B?eFFRQnQycnpLb1J1ZUJsL3RFcWpPc3VyODFlWFZEWDF1a1F2RXp0ZXdjdkE1?=
 =?utf-8?B?dnprVVFwR3haNzRXSk13Y0dsSUNVUVdWbS9iVWtRTFhUQm92M2RlUUl2alZV?=
 =?utf-8?B?OC9LbnRIcjUvbkdjSjkxcVAycG9VenhsV2ZiL1BXdGY5am5LVXlRQWtaRStv?=
 =?utf-8?B?WjZNT2VBYWJDRDVzU1VQREdPWEtmQmxReWNXc2VwdGNyU3c5WjBsclEwK2tD?=
 =?utf-8?B?bS9nUFBPcENZTEJzU2tTQ2pHS3pWaWlBZm9PRU9JQnM3ZEJZS3RPT1p6REJF?=
 =?utf-8?B?WHovWGdIUXFVbzIxRmwxazhhZzhmdFE4bkVUeVJoRnpYaXBSTjlaZWRlWW5Q?=
 =?utf-8?B?dXdJMHZFZkU4b3UxOFlRcDNuc2MzeGR0Mk9UYlNnaTZMYWRzTGZkOWlLUndr?=
 =?utf-8?B?OG9PckJHa05FZ2QwYWsyUlNMYXNsU1F6YTlIc0RhQXpObHJielFxOHA5SjNm?=
 =?utf-8?B?YmNsMGxaUzU4MmhUUEplbFJhb2pBPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f2e611-147c-46f8-74b1-08d9c5fa6263
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 09:55:43.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6i8Fo386ZwOdV6ysCXm8W53w6aqRdi6fZSB0Z/12QCB67zXLxOBzr9wEw3pbCo/QR8+/6s/EnoYENLXStFJUFgno6VWNBsz+432SmmT4JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5328
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--------------C841C10C78D715F3120DB136
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I currently don't have numbers for this patch taken alone. This patch
>> originates from work done some years ago to reduce cost of memory
>> accounting, and x86-only version of this patch was in virtuozzo/openvz
>> kernel since then. Other patches from that work have been upstreamed,
>> but this one was missed.
>>
>> Still it's obvious that release_pages() shall be faster that a loop
>> calling put_page() - isn't that exactly the reason why release_pages()
>> exists and is different from a loop calling put_page()?
> 
> Yep, but this patch does a bunch of stuff to some really hot paths.  It
> would be greatly appreciated if you could put in the effort to actually
> put some numbers behind this.  Plenty of weird stuff happens on
> computers that we suck at predicting.

I found the original report about high cost of memory accounting, and tried to repeat the test described 
there, with and without the patch.

The test is - run a script in 30 openvz containers in parallel, and measure average time per execution. 
Script is attached.

I'm getting measurable improvement in average msecs per execution: 15360 ms without patch, 15170 ms with 
patch. And this difference is reliably reproducible.

Nikita

--------------C841C10C78D715F3120DB136
Content-Type: application/x-sh;
 name="calcprimes.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="calcprimes.sh"

#!/bin/bash

exec > ~/primes

#storing the number to be checked
for NUMBER in $(seq 1 100)
do
  i=2

  #flag variable
  f=0

  #running a loop from 2 to number/2
  while test $i -le `expr $NUMBER / 2`
  do

    #checking if i is factor of number
    if test `expr $NUMBER % $i` -eq 0
    then
      f=1
    fi

    #increment the loop variable
    i=`expr $i + 1`
  done
  if test $f -eq 1
  then
    echo "$NUMBER Not Prime"
  else
    echo "$NUMBER Prime"
  fi
done

--------------C841C10C78D715F3120DB136--
