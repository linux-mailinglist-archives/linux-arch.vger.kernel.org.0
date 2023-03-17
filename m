Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D56BE9EB
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 14:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCQNSJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQNSI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 09:18:08 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC16EC7E;
        Fri, 17 Mar 2023 06:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDkjqRXHtlQMg0LwJv0xFSxSIgUuBgrR+TnKFCNSxYqOoX06PPQOWaIbsNcaS48xliQNd4s0t3rZW+RLoli9u/aFI7tYUufCBC1V4LNq0y/zW08zpL4ATm9pXkrvdumtMT0VYX+X7Yo16jK8agdcx0vtl84nIQYqQoYKXEtIz5ABgz9ot2jJxX1njJuTTODo8m2YlQCGg8N3cOs2dg+DQnblnF1rPZ1LqMxhIjmECNTYuDPzfBz4swUZX5zatYp2+hK88DVykLl4b3UtHw8mGBzplpN2exK3uyGwQ5U2cQ6fwxi6L0TS8VJM8T6+myhB4cH/ddglEqJKOXRt4DvPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoiR2lTFhqDjd/HzLvgmwhd08dRfewpUrke/NLOhBk0=;
 b=OH0f+7bRpZbfo/ivrf3/gOlvmqXy3QSny8L7yk7qvl/L4invnlzh/p1ghrRxAqsnTx9ebb2XLmdvtGZBpf73q/iEg2WHsYwaeloBbVLx7ecIzr+Mv7tTn14s20TWO7Um6w7Towqb5YhvYmI6F/bjWBu50yri+RdcJe2iaxoC0MZN8e4rFL84W4xF/nnpMNNWHeaO+NrHmNNaGWPxLG5cdiaG0CX4jc+ehkKiQ0UXEajh8tyJjFhQ0tiFBDL6G3MU36NXtrgWhndDKse8NPERRpUwhlfNprfUWzK/cAuyHBYXS/F85uHHTOdUV92kax4awGy2Efw60JPb/GkNhAOzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AoiR2lTFhqDjd/HzLvgmwhd08dRfewpUrke/NLOhBk0=;
 b=VPLqI3e0s+WNgbB2NHBkdyQQRBChx+lBu81/p4kfM9WJ1RnbxQHGSmVpWqpFtmTdqEvvmQCCQ8ve39qfPOq4QiSdeJBQC+ah4PfeKdmpHs/nZOYOhwu1YQSoheLYFxYTg8PkSEJHiZw0Kv/DyswHT2OIO5oV6dKLPCf7h61OCLxZ1NFtk2UJj8emo/D1iOKKGG0z2th/lBMttQ7kJiRTfC6eAb8Oe1lo5ciRVemiM28GPDx8a8uChuFbXVzunVjEUeS27kQwNsIAoSdHdgteDkYBjInIzAVgfFyf/Ro+nvQMSdv8nlWkjpKtoNdJfob+g7K/WJhUY6M+bsFOQUeFPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 13:18:02 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::bb0b:f14a:c49a:9cd7%4]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 13:18:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Date:   Fri, 17 Mar 2023 09:17:59 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <A37CA8BD-F6BD-4EDF-8F47-7FC81037B867@nvidia.com>
In-Reply-To: <20230316232144.b7ic4cif4kjiabws@box.shutemov.name>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
 <06785A33-BDBD-4EEC-B063-19E1002F87D9@nvidia.com>
 <20230316232144.b7ic4cif4kjiabws@box.shutemov.name>
Content-Type: multipart/signed;
 boundary="=_MailMate_406C40AE-05F6-4BCD-95F8-C7EC75F2F454_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c16b60-da06-4a74-0a46-08db26ea092d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +8r1JotpWXb26V5Nxs2OU75n9UWJ7NcS7bbopA1yhDUm2q8iAgGTgEiJDWyL43+AUGNC0eEh+QSdC2s+SaFjuOxHYCAOIyXD6N2IJkxElA9cotVIPXnLU8VRe2E+5EUKaz1Mf8UEI/bISLQASNiyqYZEuKchnPXzHMP7IbF0Nyzu63as0en76R5ITD1ykOfAXHSfv4wBWkWxfmmyBKg7ap1ddWUj4UHuHc6VchGK+90/asCsKjcefqu1sXFUAHEO4N5P8xvZsifvpWmuUX3/oacmqs+mCcZWHGPxOjyrzgpIMLOqOPLKMNby880eOljf3ZxyBTrQCA3f5cAc9Rtar4P1EI0b1GmOy0HeIZVMHczJzK47gfufW5kAmt8IDRTgzoFhSWpo66ZHGuR7qp4oeLFmePbvPc+S62u3VY7fp0j1q4SuUi/0m5kbpgrDXZLOmiAq/bXoqCsuDgRvSixte99PbcoK/sw9caPA0zANmsDYwzYQGGHonbFOFjjzRAPfc5OSDDaBf3pEhBmNn8NBx4a+ayrqdy3i2aE6QktoL8u4K6hFs4aUrQ5h6qFkBc6uPOkV24mRz6OfuO6/uf1hzdK4bigG9G5PlpPIGy67YyXcAiBxSjwuXn6bgFHj76lSsp1acfy60coja9mfVVPclHowQF+KA5pS3vj2vG9ErYi+JEb8upA/7kLY0YTLBi69bE0zf3/LnWh7L9i1bkkuJrOVswj+x+Pn0tQdbTYQDJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199018)(36756003)(33656002)(86362001)(38100700002)(2906002)(41300700001)(5660300002)(30864003)(8936002)(235185007)(2616005)(6512007)(6506007)(186003)(53546011)(83380400001)(316002)(26005)(54906003)(6916009)(66476007)(8676002)(6486002)(66946007)(6666004)(4326008)(478600001)(66556008)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?He1Fi4pqICJtozWzfbbbT0f1pNktfCZYOR76bj6gYsRq8HYWLKMLGwb7Vljy?=
 =?us-ascii?Q?b0rzRXIwkUc6l61SkDLUe184yMkKZRt1CPSGIw2Q2EILST1WTWzB+CH1T3Yc?=
 =?us-ascii?Q?bUAYPMbP7Lx5XfAfFDpWsLZgk0+R4hRiqZTIKaTjY5oMDJVjQY0qMHoJ4ZHM?=
 =?us-ascii?Q?VD8VUvAAP6Rinsv0lKN5sWwoysidB7SGK9+MI48DlCTIpXCGLNWIg/hLIf3u?=
 =?us-ascii?Q?XTBkD+f1iH0bowannaZttPNicI4jl1oI3TstF9kY3mTOUpb1X9fgXwEevLHE?=
 =?us-ascii?Q?c9bbytwjYAlgWjveR9K4WJlbbXVxzilHTRJcnOcrOOteZoEoTYJqn3Keqdxe?=
 =?us-ascii?Q?rhJ4MtM6kbAA8Cc5eJ506BPxYghvM9mTpOFOBj1+WHJ0kcoyTgOuraigXRBa?=
 =?us-ascii?Q?gIrNWg3+LKOCALEGevOABOmQIB7wckLw0Z6r/ngfz78W8dak1FrA0BlBAB99?=
 =?us-ascii?Q?KxC1C4kjsbFDBtEwhfhfEDq9YlRlHznOOPNjTTWlXc79kfao94B/AhJI4JR/?=
 =?us-ascii?Q?KF2ic+OvEw1vFu0P2deCilxzLUTriS3RGva8oM3tGx2BmjcoCf+KPcsw6CIt?=
 =?us-ascii?Q?73zYXpI8XgmaGFBspJG+QdTgCandbaBgqgSxPAEzqPBMxJgZI5VGmHw3xbaE?=
 =?us-ascii?Q?xyPTemKUzS8b8r2Ys73Leo+Komijz2joYoPvnNWUwD1ghzz5gyqVR4kthGNy?=
 =?us-ascii?Q?ryXKGGraLIZ0aMj+1N8n7oDiVAaswfnPpVJNl0PZ88aAr8PVMP+JLGLE7K29?=
 =?us-ascii?Q?GIlgbpZkw+IzD9cxPDi6FX0PdvADSA6/hm24trmdLFt68KmbHlHuF6a5qGF+?=
 =?us-ascii?Q?aeDMZz/skxA4nTFaOC9CZfGcs/TlpAUhbsZbH47OlzkwJn7yYZTndJM8JGVT?=
 =?us-ascii?Q?eeuKHsmigujFWToSCXZsV/5uY91ALv3gZMN+zp3/flotbo5qSE/jb1ZQvP0D?=
 =?us-ascii?Q?LYhZiRxa6IuMvZQz/Uk4BRPEdv8Nh5KRyATOscF8r0DXC9DAOLS0T4vUuAg3?=
 =?us-ascii?Q?iZJdaP2H0y1u/dqYrT4EhLzvn+sOutdbbvrHklEVYCWauDvqbZXhkcmenm/Y?=
 =?us-ascii?Q?23WKp/u4MmzIQkbnvHN8Qh1lFYnEJOLFdZ/B/12CoU5T5gPrAPKOi2RUP25V?=
 =?us-ascii?Q?ewhzaHItyDspp5o1H/ZNUmyLvsmibKHIz6Zht+yecCmzD11/1avde8czE7yG?=
 =?us-ascii?Q?KzQIPuTIWnce2LxSscf6rMxzIZ2Z5UOdyn2Sm60uTYifV903ODx3ptgea6Ys?=
 =?us-ascii?Q?c5sx27GbHjZuwQXYsIgjgJNMAW13ySjGQgIt7102pU0bzIU0nxIZ633p5fk7?=
 =?us-ascii?Q?fWNlMtb66YcvHFDxCv2QdcO4zsXwZmnhD3U15Q/gUTkmbfsdVKkscLE6lgP5?=
 =?us-ascii?Q?+uvgjVAmWb5UoB6A0kUNjRd2ri8WYRs0HLBNsh4N8/XwJWwBSrTWWdOpensq?=
 =?us-ascii?Q?/lylj4ybGvUd/58Ptt+qrWgJNWwaxvreG9pdFJFz2SZq9xefm80nOdQeuCuG?=
 =?us-ascii?Q?2eACjY+wchve3yg/JVgYqA3uli7uDdShPHMIJccWOcJqYH43zyPagVwx9QNp?=
 =?us-ascii?Q?gvBD10ta4FJYenUbNlwa6M83KG2/PQdpYWiBDfhg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c16b60-da06-4a74-0a46-08db26ea092d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 13:18:02.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJy0ThgmPDGHFv9zSCJdNazGWRhh4uiEC6VKV58w2t9pv8Xq5SNiiDEZc4YELpvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=_MailMate_406C40AE-05F6-4BCD-95F8-C7EC75F2F454_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Mar 2023, at 19:21, Kirill A. Shutemov wrote:

> On Thu, Mar 16, 2023 at 01:09:30PM -0400, Zi Yan wrote:
>>> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documen=
tation/admin-guide/kdump/vmcoreinfo.rst
>>> index 86fd88492870..c267b8c61e97 100644
>>> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
>>> @@ -172,7 +172,7 @@ variables.
>>>  Offset of the free_list's member. This value is used to compute the =
number
>>>  of free pages.
>>>
>>> -Each zone has a free_area structure array called free_area[MAX_ORDER=
].
>>> +Each zone has a free_area structure array called free_area[MAX_ORDER=
 + 1].
>>>  The free_list represents a linked list of free page blocks.
>>>
>>>  (list_head, next|prev)
>>
>> In vmcoreinfo.rst, line 192:
>>
>> - (zone.free_area, MAX_ORDER)
>> + (zone.free_area, MAX_ORDER + 1)
>
> Okay.
>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docume=
ntation/admin-guide/kernel-parameters.txt
>>> index 6221a1d057dd..50da4f26fad5 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3969,7 +3969,7 @@
>>>  			[KNL] Minimal page reporting order
>>>  			Format: <integer>
>>>  			Adjust the minimal page reporting order. The page
>>> -			reporting is disabled when it exceeds (MAX_ORDER-1).
>>> +			reporting is disabled when it exceeds MAX_ORDER.
>>>
>>>  	panic=3D		[KNL] Kernel behaviour on panic: delay <timeout>
>>>  			timeout > 0: seconds before rebooting
>>
>> line 942:
>> -		    possible value is MAX_ORDER/2.  Setting this parameter
>> +			possible value is (MAX_ORDER + 1)/2.  Setting this parameter
>>
>
> I don't think it worth it. See below, on the relevant code change.
>
>>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.=
c
>>> index d6bbdb7830b2..273a0fe7910a 100644
>>> --- a/kernel/events/ring_buffer.c
>>> +++ b/kernel/events/ring_buffer.c
>>> @@ -609,8 +609,8 @@ static struct page *rb_alloc_aux_page(int node, i=
nt order)
>>>  {
>>>  	struct page *page;
>>>
>>> -	if (order >=3D MAX_ORDER)
>>> -		order =3D MAX_ORDER - 1;
>>> +	if (order > MAX_ORDER)
>>> +		order =3D MAX_ORDER;
>>>
>>>  	do {
>>>  		page =3D alloc_pages_node(node, PERF_AUX_GFP, order);
>>
>> line 817:
>>
>> -	if (order_base_2(size) >=3D PAGE_SHIFT+MAX_ORDER)
>> +	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)
>
> Right.
>
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 4751031f3f05..fc059969d7ba 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -346,9 +346,9 @@ config SHUFFLE_PAGE_ALLOCATOR
>>>  	  the presence of a memory-side-cache. There are also incidental
>>>  	  security benefits as it reduces the predictability of page
>>>  	  allocations to compliment SLAB_FREELIST_RANDOM, but the
>>> -	  default granularity of shuffling on the "MAX_ORDER - 1" i.e,
>>> -	  10th order of pages is selected based on cache utilization
>>> -	  benefits on x86.
>>> +	  default granularity of shuffling on the MAX_ORDER i.e, 10th
>>> +	  order of pages is selected based on cache utilization benefits
>>> +	  on x86.
>>>
>>>  	  While the randomization improves cache utilization it may
>>>  	  negatively impact workloads on platforms without a cache. For
>>
>> line 669:
>>
>> -	  Note that the pageblock_order cannot exceed MAX_ORDER - 1 and will=
 be
>> -	  clamped down to MAX_ORDER - 1.
>> +	  Note that the pageblock_order cannot exceed MAX_ORDER and will be
>> +	  clamped down to MAX_ORDER.
>>
>
> Okay. Missed that.
>
>>> diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
>>> index 7fb794242fad..ffedf4dbc49d 100644
>>> --- a/mm/kmsan/init.c
>>> +++ b/mm/kmsan/init.c
>>> @@ -96,7 +96,7 @@ void __init kmsan_init_shadow(void)
>>>  struct metadata_page_pair {
>>>  	struct page *shadow, *origin;
>>>  };
>>> -static struct metadata_page_pair held_back[MAX_ORDER] __initdata;
>>> +static struct metadata_page_pair held_back[MAX_ORDER + 1] __initdata=
;
>>>
>>>  /*
>>>   * Eager metadata allocation. When the memblock allocator is freeing=
 pages to
>>
>> line 144: this one I am not sure if the original code is wrong or not.=

>>
>> -	.order =3D MAX_ORDER,
>> +	.order =3D MAX_ORDER + 1,
>
> I think the original code is wrong, but the initialization seems unused=
:
> it got overridden in kmsan_memblock_discard() before the first use.
>
>>> @@ -211,8 +211,8 @@ static void kmsan_memblock_discard(void)
>>>  	 *    order=3DN-1,
>>>  	 *  - repeat.
>>>  	 */
>>> -	collect.order =3D MAX_ORDER - 1;
>>> -	for (int i =3D MAX_ORDER - 1; i >=3D 0; i--) {
>>> +	collect.order =3D MAX_ORDER;
>>> +	for (int i =3D MAX_ORDER; i >=3D 0; i--) {
>>>  		if (held_back[i].shadow)
>>>  			smallstack_push(&collect, held_back[i].shadow);
>>>  		if (held_back[i].origin)
>>> diff --git a/mm/memblock.c b/mm/memblock.c
>>> index 25fd0626a9e7..338b8cb0793e 100644
>>> --- a/mm/memblock.c
>>> +++ b/mm/memblock.c
>>> @@ -2043,7 +2043,7 @@ static void __init __free_pages_memory(unsigned=
 long start, unsigned long end)
>>>  	int order;
>>>
>>>  	while (start < end) {
>>> -		order =3D min(MAX_ORDER - 1UL, __ffs(start));
>>> +		order =3D min(MAX_ORDER, __ffs(start));
>>
>> while you are here, maybe using min_t is better.
>>
>> order =3D min_t(unsigned long, MAX_ORDER, __ffs(start));
>
> Already addressed by fixup.
>
>>>
>>>  		while (start + (1UL << order) > end)
>>>  			order--;
>>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>>> index db3b270254f1..86291c79a764 100644
>>> --- a/mm/memory_hotplug.c
>>> +++ b/mm/memory_hotplug.c
>>> @@ -596,7 +596,7 @@ static void online_pages_range(unsigned long star=
t_pfn, unsigned long nr_pages)
>>>  	unsigned long pfn;
>>>
>>>  	/*
>>> -	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback m=
ight
>>> +	 * Online the pages in MAX_ORDER aligned chunks. The callback might=

>>>  	 * decide to not expose all pages to the buddy (e.g., expose them
>>>  	 * later). We account all pages as being online and belonging to th=
is
>>>  	 * zone ("present").
>>> @@ -605,7 +605,7 @@ static void online_pages_range(unsigned long star=
t_pfn, unsigned long nr_pages)
>>>  	 * this and the first chunk to online will be pageblock_nr_pages.
>>>  	 */
>>>  	for (pfn =3D start_pfn; pfn < end_pfn;) {
>>> -		int order =3D min(MAX_ORDER - 1UL, __ffs(pfn));
>>> +		int order =3D min(MAX_ORDER, __ffs(pfn));
>>
>> ditto
>>
>> int order =3D min_t(unsigned long, MAX_ORDER, __ffs(pfn));
>
> Ditto.
>
>>>
>>>  		(*online_page_callback)(pfn_to_page(pfn), order);
>>>  		pfn +=3D (1UL << order);
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index ac1fc986af44..66700f27b4c6 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>
>> line 842: it might make a difference when MAX_ORDER is odd.
>>
>> -	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
>> +	if (kstrtoul(buf, 10, &res) < 0 ||  res > (MAX_ORDER + 1) / 2) {
>
> I don't think it worth the complication: the upper limit here is pretty=

> arbitrary and +1 doesn't really make a difference. I would rather keep =
it
> simple.
>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 32eb6b50fe18..0e19c0d647e6 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4171,8 +4171,8 @@ static inline int calculate_order(unsigned int =
size)
>>>  	/*
>>>  	 * Doh this slab cannot be placed using slub_max_order.
>>>  	 */
>>> -	order =3D calc_slab_order(size, 1, MAX_ORDER - 1, 1);
>>> -	if (order < MAX_ORDER)
>>> +	order =3D calc_slab_order(size, 1, MAX_ORDER, 1);
>>> +	if (order <=3D MAX_ORDER)
>>>  		return order;
>>>  	return -ENOSYS;
>>>  }
>>> @@ -4697,7 +4697,7 @@ __setup("slub_min_order=3D", setup_slub_min_ord=
er);
>>>  static int __init setup_slub_max_order(char *str)
>>>  {
>>>  	get_option(&str, (int *)&slub_max_order);
>>> -	slub_max_order =3D min(slub_max_order, (unsigned int)MAX_ORDER - 1)=
;
>>> +	slub_max_order =3D min(slub_max_order, (unsigned int)MAX_ORDER);
>>
>> maybe min_t is better?
>>
>> slub_max_order =3D min_t(unsigned int, slub_max_order, MAX_ORDER);
>
> Fair enough.
>
> ...
>
>> The changes look good to me. I added some missing changes inline, alth=
ough the line
>> number might not be exact. Feel free to add Reviewed-by: Zi Yan <ziy@n=
vidia.com>.
>>
>> Do you think it is worth adding a MAX_ORDER check in checkpatch.pl to =
warn people
>> the meaning of MAX_ORDER has changed? Something like:
>>
>> # check for MAX_ORDER uses as its semantics has changed.
>> # MAX_ORDER now really means the max order of a page that can come out=
 of
>> # kernel buddy allocator
>>         if ($line =3D~ /MAX_ORDER/) {
>>             WARN("MAX_ORDER",
>>                  "MAX_ORDER has changed its semantics. The max order o=
f a page that can be allocated from buddy allocator is MAX_ORDER instead =
of MAX_ORDER - 1.")
>>         }
>>
>
> We can add, if you think it is helpful. I don't feel strongly about thi=
s.
>
> Below is fixup I made based on your feedback:
>
> diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documenta=
tion/admin-guide/kdump/vmcoreinfo.rst
> index c267b8c61e97..e488bb4e13c4 100644
> --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> @@ -189,7 +189,7 @@ Offsets of the vmap_area's members. They carry vmal=
loc-specific
>  information. Makedumpfile gets the start address of the vmalloc region=

>  from this.
>
> -(zone.free_area, MAX_ORDER)
> +(zone.free_area, MAX_ORDER + 1)
>  ---------------------------
>
>  Free areas descriptor. User-space tools use this value to iterate the
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 273a0fe7910a..a0433f37b024 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -814,7 +814,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long wat=
ermark, int cpu, int flags)
>  	size =3D sizeof(struct perf_buffer);
>  	size +=3D nr_pages * sizeof(void *);
>
> -	if (order_base_2(size) >=3D PAGE_SHIFT+MAX_ORDER)
> +	if (order_base_2(size) > PAGE_SHIFT+MAX_ORDER)
>  		goto fail;
>
>  	node =3D (cpu =3D=3D -1) ? cpu : cpu_to_node(cpu);
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 467844de48e5..6ee3b48ed298 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -666,8 +666,8 @@ config HUGETLB_PAGE_SIZE_VARIABLE
>  	  HUGETLB_PAGE_ORDER when there are multiple HugeTLB page sizes avail=
able
>  	  on a platform.
>
> -	  Note that the pageblock_order cannot exceed MAX_ORDER - 1 and will =
be
> -	  clamped down to MAX_ORDER - 1.
> +	  Note that the pageblock_order cannot exceed MAX_ORDER and will be
> +	  clamped down to MAX_ORDER.
>
>  config CONTIG_ALLOC
>  	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
> diff --git a/mm/slub.c b/mm/slub.c
> index 0e19c0d647e6..f49d669ff604 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4697,7 +4697,7 @@ __setup("slub_min_order=3D", setup_slub_min_order=
);
>  static int __init setup_slub_max_order(char *str)
>  {
>  	get_option(&str, (int *)&slub_max_order);
> -	slub_max_order =3D min(slub_max_order, (unsigned int)MAX_ORDER);
> +	slub_max_order =3D min_t(unsigned int, slub_max_order, MAX_ORDER);
>
>  	return 1;
>  }
> -- =

>   Kiryl Shutsemau / Kirill A. Shutemov

LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_406C40AE-05F6-4BCD-95F8-C7EC75F2F454_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmQUaIgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUudkP/RxyO+DL4mu5lV4ZmMdc1/UsIRqg23WexQvm
b5zmsyEzfkt64vjaoJ2Ci6mjQcEf83zaN64GloWP97mW3osoaGOjuh6qOCMOC/im
VDHF2j8AdHA835MPnCt+TR55cwkjgAyLSn++ypAsGPy1AvcelvNJkvDRm7AGh8+8
urdPXtS/OKhkhruEbnCUNMHUmBUbOSuNsudJuPHm2SemKMqNfsrTn46AepedeHIL
rHDsNMJx7cvlymIr4wQ5ix2Eg9CU4ReHix63PYTvw78wqdpFTxxCmvMkMR8AhYgX
J5WOp3Hv7Wji3A0RpuxCQ2a+tuk0ZUj3daIjvX9SVDEP7CLrP1vO7gOuePQg5eXT
eUWaVKm+RMiG5Hez6UqP2oRW58C/ZkYVLWayDMMNz4DQadsskd9aNw/+Mst5317R
wWUx7yPyuba5pWIT+CMOWp8jokSxR5AgCLDYZRI1Vhfywmc8/ZvzOk9kY8IVtksR
GA856HHVmSIJRLm5CqZ2OE51r8zk2nq9h3aQIOpwS8ZcT4qYMnFrMs98tfW72hlQ
02RmXg9bclP6rKSpAHXv6QtfeoFbLQTJVwrtexdeN8E5ZAaTxuqB1O2XjHPhXTPX
xDTdoravSBfakUGuwvXKAtQH3k4eXuAZMS/f861wVvbKcDCRrF5xZT0+lTCJWn60
588aRucU
=qc9+
-----END PGP SIGNATURE-----

--=_MailMate_406C40AE-05F6-4BCD-95F8-C7EC75F2F454_=--
