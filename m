Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C78695933
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 07:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBNGcY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Feb 2023 01:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBNGcX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2023 01:32:23 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4511B548
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 22:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676356342; x=1707892342;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PXKlDew+3N2cyCSI824XniJQpN0UHfAB+Pddf0v382M=;
  b=AE5hG5nr2jN+JFibuqSoTPuJ7xetnbxHg1FFMaUEucLqORtPIr7ZHPGu
   uhV94mzMbngcevouJRig+3Xs2sPRSoiHX5RiFvfms5fSsFXOll71ym7jY
   MUVM8bI2zmJu5RqGNNZqDoBM2wddcEUBDYyFfWR3QTBUskG9bGk2/wmC7
   OhPEXW6tYgq7D3goEWy7cJrDrBzA6cg7YX0lPR8kVRNVklu7fKN3/3Ggz
   MPDBO5HURIXTAsbz4zYMVYDMWXsuaA73v6YPWZ56LumfGWkAIyv1eMC65
   PtSt5cSGkOW3eZijBhUjMyrs/UP1ksz/jajZYykWTAMXH4GcFGff1vZ6t
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="310723657"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="310723657"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 22:32:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="757875383"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="757875383"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Feb 2023 22:32:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 22:32:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 22:32:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 22:32:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 22:32:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgvOQxks0dGNNGoDX4GI56JTq1KMXdCpuTLg5aYgiSF7BrEj4x0zgJMfU6VThC0aHbqoT8quEyvzx9bIFl8ClxQBGIYpCCImjdYY4BJshUytjWNvYJNaw0ef3W2zQOG+MK9kU0Nw1Zq6yhrZUtXn+MwQI18Lb2+iDRGT0c/fbaq8XD2z9OHg3p+KKbp9eHwwSKevpueLJe2wGA4p75TEYBXAIDw8/4/JKVOIAHGNXzWxgOz8mtAI6ZMtfsxWqd3dxecq6UYqXblPiTwa8wgb87vhiQcaVDBEw3eslvfMdCIgyYUTcB4Ux2zWfiBX8YiDWIUakGAGCwMNQ7f57BY8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWCwv6enuYJKn57NVtSHh14XPegfTbSanCD5+NJYKAw=;
 b=IZ1UCIB65JJWewJiYDPNW0DJBlz2ezxdqIZWCy0n/sBDUq7cfmb0G3v/tQFsEYiHewf1bC86H+jigACmI96qraoi0xR2ohdVrD9oEMh6DQvL4+dU98gwLfP+AxHokrDCSWyRbp7UN6TgQoywjKJvptqek3RCGQsNgVeKChcQBIP9nJ1DfHVlcZloCg5LqEwpeOxE9jwrZr9AsXKuO+ClkDfg3P5uuSHR8VCNzCzoUDnkhJLcfG9dmFgTsCwnvTT9tXvmPuAHRsPcMlHsLKL1sd/Ym/STa23RXNvq/xULQ6CPOiff0FKyHe43LaHZdcS0r2+WPCpAcC95G0/L4/A8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:32:15 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%7]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 06:32:15 +0000
Message-ID: <a2d6ba93-a42c-479e-57f4-7664deb9a7d4@intel.com>
Date:   Tue, 14 Feb 2023 14:32:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 6/7] arc: Implement the new page table range API
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230211033948.891959-7-willy@infradead.org>
 <8a84172a5007b568392b2040e889780da198e20f.camel@intel.com>
 <Y+pUOVc4DFPX6119@casper.infradead.org>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <Y+pUOVc4DFPX6119@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW5PR11MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdbcc65-c288-4c59-f142-08db0e5536a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4A39Ks/bCLDa6vkmaqpQb3IVXn1jG7MxK1JGL//w7dl5siH8IUrFBMH4wNUP+olpLDkY4uYnD2PC9u6astpbLKXkyLvoPL8qaH81JyQ2gQ5bbklZL7sr/6H2w4/9c7WsFuWFX0TFO1xRqySiCPhhUxiXyAkuBzdeWyp9y8VMWJVZH3G7ob+7smZfPHBWXxfV1XYrqkYnY3eQUeDPmOBIg0foy1v1K3Ftbchdc9PNI/D2VfhxUu+N50CEebnZOB12c9innWnR7+tnMBzycnk2UnFmoVNm5SLE9S0uJ8AxmT4ebYMn8SiUMCNm1GvmeF/SDYh22n3RQLKiKalkPLWPcKehau4HbMeq9BgKde87nYsOVJX1N7vsFOcuRbVcHnKomLjyftUa1mP8ctx+nWY3c1WtVHy8YThZ1xVWaB1xGf5Vm4Mv5Njwaa8FghSEzw1gOzUksJ+f21c9qqlyIplhQhoNSD6YXyacTlrTu9CIrPesBmPm0lzY2njDopmbBOYsDuotnkghHuzpU7Ci0wOrj29ITYFWSIWT+0VoNdbZxPOxvf8W8mhrnsdmeptdWZ8tXRETiLWAJ5hpjLM8iVxuGSluQUoolAwMlU/FQJbpP6FrmMrzlG5Edtg9yDvylHLY5ktionRWyjT9N7FRb9UTMU9haTBSyCZEvU8W3Lrcm2k+OF8a0khLnibiEqvDZSe7KR4A95umFGiybYf/R2aEmsOc8QJ8ZOeNG+8BIBNnw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199018)(5660300002)(2906002)(83380400001)(36756003)(54906003)(31686004)(316002)(8936002)(66946007)(6916009)(186003)(41300700001)(4326008)(8676002)(66556008)(53546011)(31696002)(6512007)(38100700002)(66476007)(86362001)(82960400001)(478600001)(2616005)(6506007)(26005)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFhKbmRxRER5aUpRNGpjR3dkSDRGV0xSby92cUVQcDVZYnZtbmViZlZiRTFZ?=
 =?utf-8?B?aGVDa0Rxek1HUVNWaGllbk5WeFNtOWNWVFVORGZXMHZYeVFUNm1WSDlmZHBo?=
 =?utf-8?B?bGl2VlhZeWd4VEpqUEdHRko0ODZYU3Q3QWNQSTRpaTQvWGFvOXRpOHd3alVt?=
 =?utf-8?B?RHVjNXJUOVVjVnhFUWlKK1lDcnBqRGU1NCtIZHh5OTM2NUM4OWg0RkNvUGc1?=
 =?utf-8?B?ckovL2tieFBZMXdabmlxcEtiRTVoaUtFV21LQ2EvcGI3ZnVraUVmRWNvYVdV?=
 =?utf-8?B?TlRwckFodDkzZ1BzQjRPZHYxZi85ODNFUEVTcFZqYUlKd1UySWpDL3A2TG5k?=
 =?utf-8?B?MjErZ0R0eGx0YUZiTDZwNFBhM1poRnhFZnFsRHFtc1lWZ241T0ZoY3IyYkhX?=
 =?utf-8?B?ZmowUzJVQTNnWlc1V3VQUzFEU0dSbG1EV1ZXRWVTL25GbVNpWHhzUngvUkM1?=
 =?utf-8?B?eVFyeklJbCtobU5RMy9CZ1JYYW40WUt3Q1JOa3ZjYTBpekUwWk5RMWNadStx?=
 =?utf-8?B?RHhUT3Q3MUVNVkdlTHZZVUlLTldmbzdNMDV4OG9kUUtlU3NNeUVkZyt5YStZ?=
 =?utf-8?B?TjQ1bFFFbllTVDlnT0p1WVhrNFoxbmZjT2s2TEpIYUtKb3lWSHdUTm1Nbmpl?=
 =?utf-8?B?VWJJQ2p5Ykk0TFNNL0I0MUdoM3MzdWJ2VHF5TkhzRkZRZmtpRUFiSjNGOXdW?=
 =?utf-8?B?TkNBaEJPaW9YOEhhMGJvallKL0ZsR0xvL3pvb29PYjFKbDRpL0E5VWpDemox?=
 =?utf-8?B?TjRSTlIrMDlzWU1vT2NPU1BCaFdabld1WU5LY3ZSY3hqbzE2TlJjeTZuYXha?=
 =?utf-8?B?bVVyQi9PWkVEZU5CYmlZK2ZKZVkwTHh2aFZZMDZ4UkRRTUdkY085QkpwSHIw?=
 =?utf-8?B?WXZOVGxSNkp4NnZnMG9iVTl4ZmpENWJxOHFtOGYzWVpRMFJGdDNCSWt0Wjg1?=
 =?utf-8?B?eVhhOXhwWCs1ZEdGNTdzNmMvTktlTVRReVlyckdDWUFlLy9telVVWlR3OUNE?=
 =?utf-8?B?OEo2cmIrTDVZRGZPYk1aeDRObk5XeHppSGNRMGhuSFpyb0tPL2o3TzE5Wk94?=
 =?utf-8?B?ZDRkaXB6K05oQ0ZVZ3Y1aUhPUzZqRThMVm4reVc4eEZ4NXhKOE1BM05NQity?=
 =?utf-8?B?RlRxemZkb2RyMjVSb2oxODZNV05IenVqSmplYjFrc1Jaa2hxRnRSb0V0aTV2?=
 =?utf-8?B?ODdkdk5CU2hqS2g2eXZ5MmFOOVpzTzdyS1RaaWFSQkpnTnJOQUJGZDdHTjNB?=
 =?utf-8?B?aHJlSzN3N1ZqZ0FsVkpxTHJhZU15VFgwZmQrYnRVSTJ2c3lsK1ZNM1M3VlNW?=
 =?utf-8?B?emVMMGNPSGJSbW5vK0pNck9hOTZIL3hqSUpKeEQrNFJrY3V2U2tpYUhNMzFF?=
 =?utf-8?B?MXkxZk1Xb3FtZGhnbDkrL3JqaDl2Yld4VC9jZVRvWlBpcEwrQXNMVitNVzZy?=
 =?utf-8?B?ZHdGRGxzQ1M2a01MWGlmZ3NDbUs5MjFzVTJxdXQ5VFFBU09qa3hhOEZZVjZr?=
 =?utf-8?B?WCs2VXRBb0x1dGhvQXU3M0lBQkswbmhNUXFxZHc3QnRJVG5aT1dzUFNmMFIx?=
 =?utf-8?B?K2dvN1hBYmlwTXBpbURka2dWUFVSY2ZTemxsSFcyc3B5SWRIR3NhSk1SM1Vt?=
 =?utf-8?B?RGVZelltTjFlRmtnNjNZK1NjcUtyRk1oa2dVZUltKzVmckdKeE9yanVGOFNH?=
 =?utf-8?B?UzVoOUNjZ1cvSXBiMndYc05tcVJRekh3UTl5cEhqL3lFOHM5cnVLaDJIMkc4?=
 =?utf-8?B?eDlqQmxTYUpjZXZJcStGUE9SQm5ZSTRqVUZOSWQraXhpbmNtdjZzalNLTTNB?=
 =?utf-8?B?NWNjdDRReVUydGpOdVZJUXk0Z1BtRzZObU0yUzdLaUZDektMMFF5bWUxczUx?=
 =?utf-8?B?UnJaOHJWR1p4RnFjcEkyNlpCQlkyVjVlU2x3SjcxUENLS1NXRlJrdFpxcDZY?=
 =?utf-8?B?c1JiOWNEYTU5S2NYeGxveU1Yc1JQVWxBNjAxeHZxNVczZ2w0cks2akxxU3Q4?=
 =?utf-8?B?WUMyQ3JaUVFQNmdKb1U3WXFnSUxmZnZzMFhOQTBFZHRnN3ZHR2xnREtEd0Vz?=
 =?utf-8?B?blI1S3haSXdBKzFrSHBSVzVBTjVxaGVnYllZSEY2bzR2MlVTRy83ODlKS0Vm?=
 =?utf-8?B?anJYWndvWldyWjVmYkR3eXUycVVCUjVYNGVCMnlkcG9IbFNsbUFGQy92MlhM?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdbcc65-c288-4c59-f142-08db0e5536a2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:32:15.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWpDkCCvfFioWuh8zBDph9FOtL7zdrtvE0Jf0HTReZ5DMf+vtg/EmhelJykgO3yyRjYsr1AiexeEAhpINquj+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/13/2023 11:16 PM, Matthew Wilcox wrote:
> On Mon, Feb 13, 2023 at 03:09:37AM +0000, Yin, Fengwei wrote:
>>> +++ b/arch/arc/include/asm/cacheflush.h
>>> @@ -25,17 +25,20 @@
>>>   * in update_mmu_cache()
>>>   */
>>>  #define flush_icache_page(vma, page)
>>> +#define flush_icache_pages(vma, page, nr)
>> Maybe just remove these two definitions because general
>> implementation is just no-op?
> 
> Then arc would have to include asm-generic/cacheflush.h and I don't
> particularly want to debug any issues that might cause.  This is
> easier.
> 
> Long term, asm-generic/cacheflush.h's contents should be moved into
> linux/cacheflush.h, but I've lacked the time to do that work.
> 
> To answer your question from the other email, the documentation says:
> 
>   ``void flush_icache_page(struct vm_area_struct *vma, struct page *page)``
> 
>         All the functionality of flush_icache_page can be implemented in
>         flush_dcache_page and update_mmu_cache_range. In the future, the hope
>         is to remove this interface completely.
> 
> I'm not planning on doing that to an architecture that I'm not set up
> to test ...
Thanks a lot for the detail explanation.

> 
>>> +void flush_dcache_page(struct page *page)
>>> +{
>>> +       return flush_dcache_folio(page_folio(page));
>>> +}
>> I am wondering whether we should add flush_dcache_folio_range()
>> because it's possible just part of folio needs be flush. Thanks.
> 
> We could.  I think it's up to the maintainers of architectures that
> need their caches flushing to let us know what would be good for them.
> Since I primarily work on x86, I have no personal desire to do this ;-)
> 
> One of the things that I've always found a little weird about
> flush_dcache_page() (and now flush_dcache_folio()) is that it's used both
> for flushing userspace writes (eg in filemap_read()) and for flushing
> kernel writes (eg in __iomap_write_end()).  Probably it was designed for
> an architecture that flushes by physical address rather than by virtual.
I noticed the copy_page_from_iter_atomic() is using kmap_atomic(page) as
access address. So even if it's VIVT, if there is no highmem, it should
work with flush_dcace_page/folio(). arm is VIVT and seems no complain
about this. It may be very rare that it has no highmem?

> 
> Anyway, if we do have a flush_dcache_folio_kernel(), I'd like it
> to take byte offsets.  That would work well for __iomap_write_end();
> it could be:
> 
> 	flush_dcache_folio_kernel(folio, offset_in_folio(folio, pos), len);
> 
> But I'm not volunteering to do this work.
I'd like to give it a try. :).


Regards
Yin, Fengwei
