Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4142A47C337
	for <lists+linux-arch@lfdr.de>; Tue, 21 Dec 2021 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbhLUPmw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Dec 2021 10:42:52 -0500
Received: from mail-am6eur05on2109.outbound.protection.outlook.com ([40.107.22.109]:33376
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234659AbhLUPmv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Dec 2021 10:42:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIezKlEIJY9o65icOMj9fNzFJ+XDXCsVfzkziw/KfizTEzUaXPPLjeqY53ZI8HHSeQ60x7sb11bzdj+abo01U4sVM+R0hnFRuOB/6cQn3Y684zpCkB1XtGhv49JOBOCNMVeAjqPtIagRxRbZOlQoRw22lXdstq50XtzS+DDYc5axcKto0/Qr3nq6GNpRXIizBv3dWVETlhdtDgQdYunOqqOz9KdI64wLquyhQktBKJIg2GN35HUZAx63vVfijkdDQYtvJYu9ZYrvS1GYmgunXg1jXf5i6csNjCeHj5zVIGIJO1KQO49krjskYdIARTsybcKHSVYsOcdBxsweufVRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGpegmfBSYbwW5iX2vDrCOWbsyAdh+adI7zDsMvPJMQ=;
 b=Mw2cBdUsJhK9la5FfclUgX5ToMQeabx0JGnYWV1BI5hfRtZoNbHxx5C3yUaC2mEAf4U1tdQG+EcnqFRFp0QjcdUZMhD/karPgW2MJqRkKn/JaxO3WaBEIRsI29zjybeGp7EF/gV+//3sjwoRCGJ6Jw8afmEZM2d+CmEezm0m1tgxt1+BRYXTeZxHWJTuCj+QTcRsMPRgXZcuwzXkZt9ZjWHTL1kjck7ZXkSVczc0y/7uQJjjxi3HC+2fG/O6HKLSwF6gvH6dwpta/Rq7KR48van1k+bBhmYGD/z0AVvUu6/vUYMZxXZPto3N1FzAAPRow2wCghbDHf84hz3IVqKOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGpegmfBSYbwW5iX2vDrCOWbsyAdh+adI7zDsMvPJMQ=;
 b=itdU5tso+RWZ6yFVPMYZP25aRATCf6B4+m7krSO4KB9KhcRwGgPzpp0yedJFJubI0EKPQtInyxc+8r8gBq0bJkChsSuuXYeBW+0dKacu2Ked8cP1HTOuqfH/77qPfoD1G8c6mDXdq+smxkkgjt65yDXcU2x2dVlkz/4GcjN6g60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR08MB4112.eurprd08.prod.outlook.com (2603:10a6:803:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Tue, 21 Dec
 2021 15:42:49 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::5807:e24c:a173:3b71%4]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 15:42:49 +0000
Subject: Re: [PATCH/RFC v2 1/3] tlb: mmu_gather: introduce
 CONFIG_MMU_GATHER_TABLE_FREE_COMMON
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, kernel@openvz.org
References: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
 <20211218185205.1744125-2-nikita.yushchenko@virtuozzo.com>
 <YcHU1maQkp4VXZvS@hirez.programming.kicks-ass.net>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <89d10f73-dca3-844b-d42d-26da8dc4c65e@virtuozzo.com>
Date:   Tue, 21 Dec 2021 18:42:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YcHU1maQkp4VXZvS@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR01CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::34) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 190ef957-bf8a-4319-84b7-08d9c4988a86
X-MS-TrafficTypeDiagnostic: VI1PR08MB4112:EE_
X-Microsoft-Antispam-PRVS: <VI1PR08MB41125145135B81414ABC365CF47C9@VI1PR08MB4112.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mLn+OJ5AmFaEv3/lD5ABt2SOcpaeewXvdtZHhNcbzziL8INzYRZCSKOzIW+ZuKOhLThLDVtWMcVjJYfxPjIyTbmtJmwFuUMdF6F03QzY3HLyR6r7lCrNp8WdDr5n95KbHlvuUzOlqGfSOcI2GlkWEeXw5hHmyJWN7TtfM6wVokxiqlUE1B/wlf80oFGvvXADi+W1cm7vGpuZANnh0sDI799eAZ7QN9Bm0lgII7hc+vU0m6WnxqqEhGLOhDxekGatSQ4QPbMMbl3nBA8og/fWPFWLypNCcOBZVh1RgQ9mllN7M+kz9UgQFvfVtNi9brdKPnAZw24h7j/uxYzXGdycZ3pfs5TIqVCs2bk9FvmfKj8FuUSZIXCEgn64NRBvuk7mxw0Awh2AowoFg6MxwdY+AtLWoRDHjRH6Hq9Ydi4Lv2TlfOopWPtNCYbgX/ZQuVdAV/jbjpetRsPRSuNpPSN/JYpGqI1c8uyi0qp71fs40fpq+4vls0trlPxJHv2KGwY22cb0k3mtkzwA2hlpSrxi/1FHBJ1jAHLuJSxFCAgPVJViJIR3KtZm9bf5Cz5/WVXEXq7fRH00dpDuZ53doHrwDAasghPOnfCJdX0X20D1/UBj6QnKc9b0Z0OqHzFr7LsCHlczA3yhFl0MoPBGdOagVIq1CAkfr5LDf0EPDzjqLaymCNIIFiXa0WyT4Rbv6/3silY5V1zp703WJoLMotwNECBZi9q317+CUL3HSwzORs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(26005)(7416002)(8676002)(2906002)(31696002)(6506007)(186003)(558084003)(31686004)(2616005)(54906003)(36756003)(6666004)(8936002)(5660300002)(6916009)(6486002)(508600001)(316002)(44832011)(6512007)(107886003)(4326008)(38100700002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndvUjB6QVl3UHBLY1FEcStIOVF5Q0daSlFQUUZrYWk5MkFJMTF5QncreGdF?=
 =?utf-8?B?U2xJWDRaNVBqaFVYYzlkQVVRVGF0a3NNTnlVcmY2YUhJYWNnMHNkaS9PWGtD?=
 =?utf-8?B?bjhnVU90aFFQYWl1VXd5eGovYzBYa09jNGVMS0ZId0FGWTloVjV0aUlibXpG?=
 =?utf-8?B?d1doTHJ3d2ZrZVZjci9lNHNFZS9MNXcyWFAxVE1xRE1uQjNpNHpIaFQ0a3JX?=
 =?utf-8?B?V1ZSaC9DUlNGRDArMGxoTlRSbngvbkZKSHkvbFhFZXpKRS9VaFVnek0rWHR1?=
 =?utf-8?B?Y09uNnpXRUJKUDkzVzRrQWw3TWtFQmJvSll1QXdmeWFpWTd6NWhRalptVjQ2?=
 =?utf-8?B?NVFkc2xLL1FSNXRlSEsxNkgxenFneld6ejFrYjBLem51WGxYZ21LUFVuR0Qy?=
 =?utf-8?B?ZFhvU3psVnlzaDhuMVNIU05aMEhKMnRjRVJsSE5pQkJ1aXh4a3A5aHZId0gz?=
 =?utf-8?B?N3lwSmZ6VC9IR2l1b1NDVUpEU2hpdE10bGxKRzhaU0RGN3ZLR0x0Ny8zWHZ1?=
 =?utf-8?B?MUtJTmczbkUyeGJWZGJZL0NYbHdSM1ZWS051S3M0SHlxa1pxaXlBRDJFbE0r?=
 =?utf-8?B?T1ZlNENKVUZaSS81Yk9xVm44elo1NjVvLzdObkVTQzdQSERKSnhlOWYrVFNa?=
 =?utf-8?B?RTdUSnR2SXl4ZzZqenBHNnpqeFVMZFk4elpJckQ5QldMWWVMR0owVVVwdXI2?=
 =?utf-8?B?d3dVclJadW92N2ZKV0NQdFViQWhHbWMvTnZoRU5aN3RSeWFmMjlpL3BGU1ph?=
 =?utf-8?B?ZFlrMTl4NmtTNUdCcnErTVd2ZnpWQUdzdjRrQ2R5MU00cUg4VHR0ZWg1a2Y2?=
 =?utf-8?B?NjJGems5WkcxY2paT2cxQkpwbGJGRjZDd1AvUW1xMkthWnBRc2FJZTZPaXND?=
 =?utf-8?B?c2pTWEROb3NSTnZRdmdiRi9KUFZiTUdGQk1WbjVEUzlFUFVUanp5Wmo2WXZ3?=
 =?utf-8?B?eWtFZTNsVGY2QUpoMjFFZFJNVUhmV3BDYk1OMWxDN2treUJWaHBjMG82cjJi?=
 =?utf-8?B?ZFBncVhyQzhURnkzWXNjdTRUdjJ1NDFCdjlTenlxdEF5T1BEY3pZLzNjeitE?=
 =?utf-8?B?Qzg3OEx6eVJUNWRxbWEzK01GWVJ1OEt6a2NmcDBVUVpuS1NKY0VLcnpFRG9y?=
 =?utf-8?B?SXNJMVU1S09VcElUWERTSUo1dmhtYjA0cFpoTEcvYVp2TVBuY1FsS3lLcE1t?=
 =?utf-8?B?Q1Axa1JmaWxrNlhONWxmWEtXTkthV29qMmw1Qi95K2pBQ0JlSEF0NnM5MW5N?=
 =?utf-8?B?RHM5YXY5Z0NvRTFXWFdLYi93STM0WWdUYmwwOVlXbFlhNzNrYmpRVE1Qbysv?=
 =?utf-8?B?MXk4RTc0U1A1SUpMSXR5ZFArV3kzdExqZk5QVWxzaVl1c1hiSmJ6L0dDRWp1?=
 =?utf-8?B?WXhGbEFycnBDakVIU2JDakliTFR0RDRWcXRGM3VEM05leU9kK1h1QkFFSXpJ?=
 =?utf-8?B?dTNEaTR1eW9seHc5NHAvQVRUdnRWOW1rTXJFdFFUNFhkL2Z5YjloY0RNcTc4?=
 =?utf-8?B?T0tScFNxSkhXUEcxL0Z0MnlvMFJuY0pYRTlURDZDUXkyKzdBMFMyNmpGZ0xE?=
 =?utf-8?B?YVVKa0oyMmVabXpReGw5UnE3WDJGSjhJenFGS2hQN0lmNmJTdjJ3ckhKRGpE?=
 =?utf-8?B?SWZ3VHcyS2V2b3lmS3dXcENnTE1nV0JONjBOK3NqS0ViaDc1OU9kYTVuSTRS?=
 =?utf-8?B?aWVqY1JEcnVMTGNNcllHQzlla0M0SXh3eGk3MHVsVXNNOU1mZ01KZ20wOEFs?=
 =?utf-8?B?N1lqazRITUJKSmNDejJ4ZERneWRUem51dmlQNzd0MW9WYzdDVFdsUW5ZYzBB?=
 =?utf-8?B?d240YWxSUVdadDdTZXU3UkxzUHJoTWJ3S0Y1SGtaVVYwL2c4TlFlU24yVmxV?=
 =?utf-8?B?azVTd2pZSXZBMFVPeVNvK2dWNHJqY2xCUFp5d3c2MXpydGxnWHkyK2k2RjRS?=
 =?utf-8?B?K3pSRVBEdGIrVlFiM0lZcVlpdythS212QTR4MTdmNVhDNjJ4L2JCa1E2OUdS?=
 =?utf-8?B?UUxiYWRpYlBaL2djVnl6TnJuZVQ0cmRzaDVRSGZFYzcrN3kwbitPTFlvaXl1?=
 =?utf-8?B?MUVwTmp0TEpONW1RYlc0OWNEMFgxRlJvR0FGT0ZQVFRIS2hEbVhua2UwS3V4?=
 =?utf-8?B?c1FFdUc1MEhSamVWVVhRU0RSN3VEUE8zd0NYZVQ3ZWdrc2R0d0xqSjFHRmIx?=
 =?utf-8?B?S2I0S1lPQm1VOEE2LzZQRXQvbDM0Y2krdGo0SGl0L0RRbGJwUTM3MHY0dmJB?=
 =?utf-8?B?NzRBbDJJZXc5MUw4Z3hwNlU0RXdnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190ef957-bf8a-4319-84b7-08d9c4988a86
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 15:42:49.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KJh628yFOI7Vr8/g9tVWd+AHcCxfIbfFZTEZYSrWooVgd1pbS2To55e0w4SOySJ7oOPpvlxABFsD40d7nHu5/HLflfXckcFYqGaVKGL4zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4112
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>> +config MMU_GATHER_TABLE_FREE_COMMON
>> +	bool
> 
> I don't like that name... The point isn't that it's common, the point is
> that the page-table's are backed by pages.

What is a better name?

MMU_GATHER_TABLE_FREE_PAGES?

MMU_GATHER_TABLE_FREE_PAGES_BACKED?

Nikita

