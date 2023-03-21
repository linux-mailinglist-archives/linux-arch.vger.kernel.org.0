Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49716C27AA
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCUB6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCUB6v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:58:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F85B1ABD1;
        Mon, 20 Mar 2023 18:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679363930; x=1710899930;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y4JAmwYORB7dcR78mICwBtvlvek3a4kbxDLmGQ16jc8=;
  b=hQEnkAqOp7YQ0QQaaVdPqgZeIEjwtJiKPcyQRCxj7uXx0bZ1imc6rWFq
   KtEdQL6sO1GigEbWJY6Vg0afscyqIRRkqxf8hynlUSiVyN7UdACwQUP8q
   Alsoifuw+bAA7s1PrTJn3C1WlbcCVmd/ybxAHZRpJgwVBYlx+91u0K9qr
   zOp7kNVYBAoGKle2zi8k3CAhm+GvtyY4n4li5LKF/FMVKrxLH/E+seZvl
   DoSgiLVK0G+HwrPXveZUsSgH2Kkj62BMmWImM7s6wAYQLbTZ4uiSsJdYq
   QTyKpI9gXBGlE+B8yMPEZ4eUqmQwTdeh5kAdlPwKtpr6e1rKtWuTHsCfj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="425102576"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="425102576"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 18:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="683666125"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="683666125"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 20 Mar 2023 18:58:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 18:58:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 18:58:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 18:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZgjL/KJUHgvEI9QgLJmGkIsovBvi/liKGI+dkDVPJWXxZo94WZaN4O5pWxvpxkeVdsBZljhP1PTnhjg4g1z8Qo65d+rVK26hog1DrDuMFvDsjcFsTN0GIEdjecWZ++RW3UUbuJgSwwhCl9O08hQ8eJYQjPMNwJK7ssKZc1uvMhXEcchiJFCL14XFfCONfYwO5+yGcSSe346k0H8mUnEMpxkItv4IeO51ZTzNpHi2UmPREVBHXF1ZNX2s13sM29+OKQ7rL8cqZYv5oeLiJmdfgToZ5aCZhwKTf2R6Z72OgCnwb1rR+/Sml8YjfeWf/735W9fQe/own7CYekUzwY2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOGqshwovZAc+abDo6UZIjJmzqYR0l6lmvElEzLQSDI=;
 b=LC6U2cFXDeWqcpbcSvSY40H7c3FPRBX3MoVNmLzZLm9D9beR4O6biLsoHtepUmFSRVqr/vBCKYwE2qUG3gd6q7n5HCnwMqqp+QVU8ntSm4Q1/7womkhDdcx7hxwlNbKmxsWsT7/0SAZXejScBptdpc+Sl/xjeZFlt4YaO55NnjZZj/VHxEi2s3iOzqxYNVGiCoqvqoNlt8UPiSbXMLbmLtl2pfz//zGF8oxPIfQL/dVu4ygVQXsA3GnjhDS2Gc1V3mkN2m7x1Rdz9Z7B8TGWelHdhnyRddg16J0ln0LKYebG+pV43WPZYCOOBEwv10PNI1UpDQI3XuE+Y4Y3oYmYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 01:58:39 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 01:58:39 +0000
Message-ID: <b38acb21-b8d4-bbe4-9bbb-8c7202ab6f1c@intel.com>
Date:   Tue, 21 Mar 2023 09:58:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Ryan Roberts <ryan.roberts@arm.com>, <linux-arch@vger.kernel.org>,
        <will@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <483fd440-df7b-fab3-b138-f3789f2dc078@intel.com>
 <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CO1PR11MB4769:EE_
X-MS-Office365-Filtering-Correlation-Id: 6099d4bd-8db5-41cb-8d16-08db29afca1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /szDGg2+VIAVVG7Ocf+y7tzzlVlhdXi+a1V3MmeP39Qft2boGuX0fRxvPCrxjnpeRlzmroQrLQBHwm/aO7btvgpvt5Asi6jQI0j2s/2rZYDnOvUM96YP+L4pNFGKPbN1ADmEnwNJSY18xur87C4JP5zWEy2KP5v7XpPZ52+14gfwM1SW4knuCW6F9AYT7cY7MVEvOF9VIYPh9/6ngAxxTy5b32gQ7g9LVbAFHh/iNSqTgkW56UvfFJMGLLhBlTwBsZ12EJSUdAd2j5rFZ4io+KdiT5Udybh/MV7lQ9vtIxVKJNO8QBN1KXqFQ5zpQc+z3dU6NDtLCKgAGg9VydTfWsQekjNG1l6WKf5HtHaJwtmiNSnSaU0vDicOWPOqwWfcE3SJSPiCbGj8Fvs3RsLkMWsCFCO81mRkB8zv/lmEy3CjEFDbLORVFmRpkiQz9XDTHxDJzah5kNubB5AsHjIIDsHESzlOJlB9JThkvQiYkYxnE8qcdG2xO6jEqu25ngUfGjbMxlg1Q1KANtFO4qhjY3Ck9q/AOrsGE/HOkQzHM0J51jXvQJ6vut6gLoDloBJEXAEx4sf4kVnY9XhB6av71rnsf+xfO2zroFmkNC88+dT9mLGM8mdX99q02XkQtSbiUZoC8kHyVHy/o3yGGuMhr82EbHnrEKQtO8v2rugbWDpWvGLCSCXRWP/kL7cxRzGDxDkhGNC+X/W6jPdx/Kp4z+44hYlvYbDNeqhn28al9jY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199018)(31686004)(2616005)(83380400001)(478600001)(6512007)(6486002)(6506007)(316002)(26005)(5660300002)(53546011)(186003)(6666004)(31696002)(86362001)(38100700002)(2906002)(66946007)(41300700001)(6916009)(4326008)(8676002)(82960400001)(8936002)(66476007)(66556008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elUzYmFTcWcwMmNVNFRtQ1BzenBqZ0lyMHhPSkpzYkYweFRzeDJYN1pKUVdL?=
 =?utf-8?B?TGdLS1RERUJPV3dtbW10aTk3VERYaE1XYjhHY1Mva3I0WUVOK0lHWDJBN3Rv?=
 =?utf-8?B?YXhnVWxkWWZraXN6VXRKN2NUQkRmOFVzZmx4YU1DTm9PNUVrRElWWVlha043?=
 =?utf-8?B?YTdoUFR4QU9vSHZHRXZiTWFaSjRYakh4OUVUMVMxRlBlRU5VVndxZVVtVGVq?=
 =?utf-8?B?OGk1a1E5aUduU3JHc2JYT1piN2JCWEtaYkZuakNkRGszZTMzT3Rtc1YrR29S?=
 =?utf-8?B?MG9oNHE5MTFIbWNrUzFGUWdzTGc4L2hlL2pzdmd2Slo2c29iRHpXdnZ1ZjFP?=
 =?utf-8?B?NzBtdm8zYkdLdnloa2N3N3BrR2JiSnhyT0x0aGVZbFhUaU1UZWtIUkloV05Q?=
 =?utf-8?B?d0dBVlpJR0t1VkVuRWo5V0xWdWljaTFkcGJsWTJoR21keGxOSUdNRlFHUWR5?=
 =?utf-8?B?Z1FpNnM5NERlTWFNK1MzQ3RLb1c4Q0JPaWc1OXQ4UjQvaWpoR24rWU1CR2Yz?=
 =?utf-8?B?WmtpbytaaGJDTldKWk5VT21oN20vcSsrKzFrMWZqTldEVmx5ODVaY1pSaFBI?=
 =?utf-8?B?Mjl1UkhDTG5QREhZSkM3cWdRMmJvZlhDdUJVREpBQjZXQ21GdllUL2w5QjZB?=
 =?utf-8?B?L3ZKcmZ3TVU4U2hmM1RFd0NOcElma0Y3aXZWMTdSdzZtSzgyZ0NRakh1akFk?=
 =?utf-8?B?MTVCQmlhNWl4TzlxNXQwWVpXeFcyZmpzMWJHUklaNXVQRHR6RlNPS3BadGJq?=
 =?utf-8?B?NHFQWlI1TjJyZnVZM2NWb012a0dGem84cU4rd1ljY3RxYTkveDR2MmFOeVJD?=
 =?utf-8?B?MFR6aSszWUNtRnhZMkdLS1VVeHFrNWd1dkZKZXJBb09jeGZlMElZQW4vWVBh?=
 =?utf-8?B?WFZnSE5QWXZvMEtoRndBYk1xSERtdkVreDNCZnN2M3I4WC9taFR5ZEN6VzFi?=
 =?utf-8?B?RGZMZ0dkdVBCck1oU3JVRTVKMXI4aFNHYktianYrMjBRM2dKR094RW1XZkIv?=
 =?utf-8?B?bytmRU5iUXdmbHlWWlIvOFI1YlY2dnBBV1prcklYdkk2ZFpyVitSK21kMUZr?=
 =?utf-8?B?WWVtUmVCVEk2TmErbHkvWnRzVDV1aWNrM2FZbDBnaXVHZFZ5Wm1aTTRtVzcx?=
 =?utf-8?B?S3QrWlhhaW1tK2RjR3dPVE1zRmptOUFnNFhwT2hoeUlhWDFqN296RjNSblVP?=
 =?utf-8?B?SkZiS3BhU0tGaGdJWHd3U25EU0p0RWhqSzBhZ2g5bFRBOWZNZU1lQmt6TjhM?=
 =?utf-8?B?R1JkQldKU05GNTlaMTk1VHhyN3IvU3A0NGoveW9IVlVsakp3ekc5WWFsR0JN?=
 =?utf-8?B?Z3NDMmRxTnBFeVc3UlNIeVN3LzRQczdwczlIdlNJRmJNa1V3RFBkQ3poUjFE?=
 =?utf-8?B?NUJjRWE5bHJlajNlNjdZam1nWWZzbVh3TzBtdnAxVkNPYzEvUTlVSGtYMU5D?=
 =?utf-8?B?UkpmWnJlQW5tSXpJUGpqTDBteGovWEdnemFOTTh4b1dacURhVlV1aVpBb1FR?=
 =?utf-8?B?ZkdjaXUzMUFDR0pkM0hRNGNzYzJUT0w1cXhHN1RFUXQzOVN2L2FTcm9rZno2?=
 =?utf-8?B?UGpib2k1K3hmczBSQUpCWGZDY1hMYzBxcmhZOEUzZHJtZXhSRmQ1dnErTklX?=
 =?utf-8?B?aHh3L2pHUzhoT0R2bWVsNnRxdiszWVh6ZXlkRWNyWU1TdzJ6b082akJyNko5?=
 =?utf-8?B?RWJZR0hDT00wUVBWeEtKek5KeE1VVTI0OTV6cGUrSkx2OXVOVVYreEFBL1RO?=
 =?utf-8?B?RFY5d0txVTFuam1HMmVyUzI5UllpMVZxOTZFemJtZUo4eCtrd1ZqUzF1ZitZ?=
 =?utf-8?B?ZVhFUWVWRm1QdWRHV1J3VHVaYUZqNURnYUpZQ01XVGFCMzFZN0Z5SVptK2E3?=
 =?utf-8?B?b21ONDJZM3JlbHphNHc5MkZwVUo1V2VJK1ZaNExsdDRKUk1CcWhwQWhQNC9E?=
 =?utf-8?B?eFNkKy90NnB6Y1dwVmtyS3M5SzdaajVZRzhFSVJpNE92a3FWYTErdGRqRC9q?=
 =?utf-8?B?S0ZId3B5N3o2Q3RrZzgwOW1DQ1FzdzRkYVJ0blFSSiszN1lIWEh1VVdjR0xr?=
 =?utf-8?B?bkF3cnMxQjlVY0w4Z1p0bUF5YWhtL3puUFFpRm5DMmtSZkZOaWk1MUJOd0Jw?=
 =?utf-8?Q?q2WFliI+JyT7Ti8NuElf/2HBn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6099d4bd-8db5-41cb-8d16-08db29afca1c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:58:39.3847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLgTUStFE+DBKB1MGkBrlaiw0StoAeHn1Oly9AJ7w+2PrdYRIGyn2XYhfJnOBD9tRlx8VN7WksNZw/ViVwgCkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/20/2023 10:08 PM, Matthew Wilcox wrote:
> On Mon, Mar 20, 2023 at 09:38:55PM +0800, Yin, Fengwei wrote:
>> Thanks a lot to Ryan for helping to test the debug patch I made.
>>
>> Ryan confirmed that the following change could fix the kernel build regression:
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index db86e459dde6..343d6ff36b2c 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3557,7 +3557,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>
>>                 ret |= filemap_map_folio_range(vmf, folio,
>>                                 xas.xa_index - folio->index, addr, nr_pages);
>> -               xas.xa_index += nr_pages;
>> +               xas.xa_index += folio_test_large(folio) ? nr_pages : 0;
>>
>>                 folio_unlock(folio);
>>                 folio_put(folio);
>>
>> I will make upstream-able change as "xas.xa_index += nr_pages - 1;"
> 
> Thanks to both of you!
> 
> Really, we shouldn't need to interfere with xas.xa_index at all.
> Does this work?
I will give this a try and let you know the result.

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 8e4f95c5b65a..e40c967dde5f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3420,10 +3420,10 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
>  	return false;
>  }
>  
> -static struct folio *next_uptodate_page(struct folio *folio,
> -				       struct address_space *mapping,
> -				       struct xa_state *xas, pgoff_t end_pgoff)
> +static struct folio *next_uptodate_folio(struct xa_state *xas,
> +		struct address_space *mapping, pgoff_t end_pgoff)
>  {
> +	struct folio *folio = xas_next_entry(xas, end_pgoff);
>  	unsigned long max_idx;
>  
>  	do {
> @@ -3461,22 +3461,6 @@ static struct folio *next_uptodate_page(struct folio *folio,
>  	return NULL;
>  }
>  
> -static inline struct folio *first_map_page(struct address_space *mapping,
> -					  struct xa_state *xas,
> -					  pgoff_t end_pgoff)
> -{
> -	return next_uptodate_page(xas_find(xas, end_pgoff),
> -				  mapping, xas, end_pgoff);
> -}
> -
> -static inline struct folio *next_map_page(struct address_space *mapping,
> -					 struct xa_state *xas,
> -					 pgoff_t end_pgoff)
> -{
> -	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
> -				  mapping, xas, end_pgoff);
> -}
> -
>  /*
>   * Map page range [start_page, start_page + nr_pages) of folio.
>   * start_page is gotten from start by folio_page(folio, start)
> @@ -3552,7 +3536,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	int nr_pages = 0;
>  
>  	rcu_read_lock();
> -	folio = first_map_page(mapping, &xas, end_pgoff);
> +	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
>  	if (!folio)
>  		goto out;
>  
> @@ -3574,11 +3558,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  
>  		ret |= filemap_map_folio_range(vmf, folio,
>  				xas.xa_index - folio->index, addr, nr_pages);
> -		xas.xa_index += nr_pages;
>  
>  		folio_unlock(folio);
>  		folio_put(folio);
> -	} while ((folio = next_map_page(mapping, &xas, end_pgoff)) != NULL);
> +		folio = next_uptodate_folio(&xas, mapping, end_pgoff);
> +	} while (folio);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
>  	rcu_read_unlock();
> 
>> Ryan and I also identify some other changes needed. I am not sure how to
>> integrate those changes to this series. Maybe an add-on patch after this
>> series? Thanks.
> 
> Up to you; I'm happy to integrate fixup patches into the current series
> or add on new ones.
Integrating to current series should be better. As it doesn't impact the
bisect operations. I will share the changes Ryan and I had after verify
the above change you proposed. Thanks.


Regards
Yin, Fengwei

