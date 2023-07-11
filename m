Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565F074E64A
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 07:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGKFTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 01:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKFTf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 01:19:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B5E93;
        Mon, 10 Jul 2023 22:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689052775; x=1720588775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9gvsfw2aw1hq5eUUY4aV9dtjyY6IHvhPCTwJRmbe4Zc=;
  b=OvHaAa1Uu0B/roVx1kiNOzvSXFPmeUyUge2wmnQYJQXok/SBImy5MtyU
   KTT2MJ+zps3hMcmR64GvSRzGA1skoNstipX1/Ik7E/yvhbuBbVKT7DWaW
   Z6H333FSp3XumASeMnaUBhp5nUgHfovqE5dMQ+xnADOfnpNzAiB6PYui8
   M0jaJKKuku1EeBYMz8fAVN3cij+V+JD2eG2tBSIUlFCH4TtS9l8irrREy
   s16ERnfAKrOP9CEawLTbRzxKyTxL8NbqDiCxB57m5wumRg7LHVBd7JQEL
   PpAvIuBKae9X50WsKrYRlVj/WuuQYxtIfq0t6BtiIk1CqHRR/41tHTFKc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="450888602"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="450888602"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 22:19:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="967655071"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="967655071"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2023 22:19:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 22:19:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 22:19:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 22:19:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXrP9etBYJnj4klu62ij1mCYFMYhhQvOMG99bG+0YMZNBX+0rnWV/gNPJZQ8JAFbgCjulFgujHQPEobbTOSQDXof+++GVqKMMKfP6nNVPDescAzsSk84D1UMFCioRJWmgZUNGXi++gqtHAVO4d+9KBaSjr/lJoD59CGhuLRpg/0qNzRzhx0OJUHL0yoIL/pfKv8x7+fTyqcE7hmmzNp1kYK9XqWrkag2rSHuaAXzG0CQaRLzbGEZfs4/NBfNU4KieZoyV5wXVNNyl8yCK+ZcPvZ0iMo8C9H6i4YXq9JxaFb9ubb89fcAfuGs9dFOC0shRSR+tDrWR0GBHSyjQnHwkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoWTCKOa0Oeh+xR/jCnEsdjrlfuhNItOsAq32ZNtoVA=;
 b=diPtQY2B8vqCyK5UT3yTjthoZuKxI5ASKyznzeW5cmAO/Q9ZeUjeIlL4f/TFz1wubStBkkXBsXr8fjhmfJz8oWfVzfWeEuY954Y1m+jz5JaGp+HEwD5KzmoLF1Q1eimAuKi7q8mmUcNGsAA7EYUq1BTV9dNq6Acwir/W6lYbFoOapTRHGR8fUtkjJagJUIemf/3R1isbiolU2fs6zHLy8FEpSd86eamvDlb5GmPMzLAmpsFRCJlwlrlkhQmCCfAU/p1AiQ0UKU+zPf0KzE4n51inc3CnpubRytE2r7bC9V1gsnUmEfC7iwmw6i+GvO+osDhdLLmxNVQoPJ22xcqGEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by LV3PR11MB8694.namprd11.prod.outlook.com (2603:10b6:408:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 05:19:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 05:19:32 +0000
Message-ID: <b7adcefb-1e49-79f0-33e0-c84c82e6ed95@intel.com>
Date:   Tue, 11 Jul 2023 13:19:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v5 24/38] sh: Implement the new page table range API
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@kernel.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>
References: <20230710204339.3554919-1-willy@infradead.org>
 <20230710204339.3554919-25-willy@infradead.org>
 <e6842fb7d1f77702bff00d32c42f35dfc8a9ad50.camel@physik.fu-berlin.de>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <e6842fb7d1f77702bff00d32c42f35dfc8a9ad50.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|LV3PR11MB8694:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fae171d-0eba-4c22-bd78-08db81ce6878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FipN+WVK+YZKDx4QGTaEMxYe65DpStdg2bcRHHZGycVnLhq12p0Q0huABL0/Ly3HhBOmF/Kd0TTH+zUDoOX5ECBhfFgyUBo/RvkkUMZ+7OQiBLbOlp/fcal56dofwEFbyY1s69Gc45wt3gcb1tLcB5+MfBlm7Xg+pXCcaNbj9J8yka20q6oF/RnSoP8ieORyaOWTnIFIY/UJg+Z/85sy4sTT5F+ECeJ9/DCZdazJdmGW9tI9rdeKDzJvusP3A0vjqx238epOZH+/kI/OLp59+At47YsPQ070rymAmcPUCByrz45YmcJqdbHWuMKQobreop6YIfP3FuFzlbd/iV0cIGLqXkJGlvU2vm8eDQs8X/eMdlBxjRo3/hjjqRNICVmQ/tHr++qK8LXAshG9TCFWHe3TfrbHodV6eO+4UJbCKo+O0cRKhkyyKLOXydKFVyA4Z23AucCaFvYJ/FfbA8vVgXJUUJSfQQXjJTOgxo09LqTEGYDLRnkDZ8TKnwpQ9p0q3IhflxlP/7FD9Bxh14dLYoVMgcch1Qg9SQp8yE+KhSfNr0VoZMIJhMaNsyqhjqy7UBZRPuUEacTzadG51DbGHX/809+Bs010f04Z0Gvnn+M5VIRUoSqvwhWVjHGqMDPjXfkQwN/pA3Xm/igDJr7a+0xwWjvVujC9x1/ddAJlHa8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(186003)(6506007)(6512007)(53546011)(966005)(2616005)(26005)(478600001)(66574015)(83380400001)(4744005)(41300700001)(4326008)(66556008)(5660300002)(2906002)(7416002)(316002)(8936002)(8676002)(66946007)(66476007)(6486002)(6666004)(110136005)(54906003)(36756003)(82960400001)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUd1QkhOOFMwZkpndzlWcGlRZG5nMUE2SURGRS9PdDBjaVhJL2JYRXlleDFx?=
 =?utf-8?B?S3dyZms2TW16czA1SS9uTVJ0a2crcVZRbVdYNUw3TVQ1c0JkL3dQTnJRNllL?=
 =?utf-8?B?TEluY2txTGJjeTVSNHJ6QVlNejdrdkFKUmhYQ3BUbzVPQ1lUbW95RmdlT3JO?=
 =?utf-8?B?Nzhya1BSMzRBV3lNRnJyNWtOUUErN1QwRUE1OGhzVVNPQkxzZjlvR25CQzl5?=
 =?utf-8?B?MUhzZUJUTVhSYzlWTzVRbkV2d0FJZzVhVjd4RVVtMDljTU9pZXhNSFVYWlll?=
 =?utf-8?B?Y2VFYW8vWk01aVlzZ1NPSVFmT1d1TG9MKzFPd2puTUJwaUZyMFNLZy9hbGZh?=
 =?utf-8?B?UmtqOG9WR1lrbmhIWWpiNVRBRmI4OTQ2eGUxdlU1M0gvdUVRQStQUFkzbUdW?=
 =?utf-8?B?Y1ZZMGY2dU43MHVVM1gvR1h4NGl3UDdxMnVWYmtWRGZaUWY0V3UxSVRiaWNW?=
 =?utf-8?B?bXAwU2VtS1h5L0pwVmlRL0l6OUd3bjVMS0doTVZQeXVGUnBOSjRQN2ppbURI?=
 =?utf-8?B?K0l6dUkrR1cranM4UVZMUlhDSlBaM09IT3FHMFFZMmJPSTFrTThFdG5pT1Fj?=
 =?utf-8?B?T28waGRWeWNvYWVUR1lYYlEwQTQ3b2dzMWMwSEFqWElsNTM2T0tKREtaMHhl?=
 =?utf-8?B?b2p1VENZVHUxRzYrY2VyVFY4aXh3eHkyeXVSM3ZQTktKM0NxUmhDMmZ3MFIy?=
 =?utf-8?B?OVBhOTdZNFlvRnBjYkd0VEF5Y1NpYnM1a1NwMi9NL1VOWThrTUhqQnpUY3Uz?=
 =?utf-8?B?QlBXdW11NDVvbVdGQk5FOGJWWU1qNFFsMFZxNU9DaDU5bWZrUHEyMmhZMXZq?=
 =?utf-8?B?MGxDTlpwUmNON2pPQ3V6QkRxbFlBc3hJN3g1R291dndka3ppWGFoTmhQSU9m?=
 =?utf-8?B?YldhM1hVcHU0dlNnK1Q3bUJDZ3BFVmJWTFdZREF6NkhGTjMxZUMrZFlnMk5i?=
 =?utf-8?B?aEVBdVg1SENPSTJIOVlUTFMxZXgxVjBPZlBXOUdKcm9qYUU1Yk95N2lkcHhT?=
 =?utf-8?B?ZEJrYVFBK0txNEEvQmhmaHdNemx0NnoreUVMRVRvVTdJTndreFB4cER1SEY0?=
 =?utf-8?B?WTJPdzJrVzlsNkVKMzhGeHNtSW5uY2xvd0xtdCtXcG9Vb3hiMngyaHJCQndt?=
 =?utf-8?B?QXAvNTdud0hPRVBrVmhNUVRyZFRkWGFRMVI2amtxRUlySXhtYzVRQWVJWjRK?=
 =?utf-8?B?SDh4TE4ySXU0WGtOV3pFZ3k3M28wSnorVDRPSENRN0ZheHh5dUFPNXl0UEVh?=
 =?utf-8?B?d2F2c2tUc01VcmpDOHBRSHY2VGpqanpBOUJiOS9senFwdXVBVXpmUUkzT2d4?=
 =?utf-8?B?Vm9ib0x5RUY3MDhoQzB5WnUxZGxJVkRxRnB1TmVxWlN2bm5Jbmw5SjFFVitC?=
 =?utf-8?B?QStLVEkyNXJkbGMweXpRaEdyMXpUOEw5TllsTDZ4WUhXaDAwcFlJTnZ4VWZQ?=
 =?utf-8?B?dG5Mdm5OZlhVUE5MNHRiQVlpaXNyaU5HYjJJTDFKbHcrRVhkUFA2TmM0R1Q5?=
 =?utf-8?B?UmtrRDh4cCtlM0I1emU4b1ZmcTNrNjZCcWo5ZVpqcmcwcUp4SGl6azN3UndJ?=
 =?utf-8?B?OW55eFF4OEtrYVR0eWJqWkx5dmZrQ2g1SEtXUkVrTlVFSEkySDdVc2d3dVZn?=
 =?utf-8?B?UjIrK2QrSWNVSkFzcGh0eVk3eGoyZ0piRVVTckFyMXN4bjJWL1JPVFJpUXpt?=
 =?utf-8?B?SitFTGdGN2xyS3psbEJRbndvVEhSbzB5YkhwSlNxb1lRK2ZoU2IvOU1GQmQw?=
 =?utf-8?B?V2NkODJDWGFpTCtBSmQ3VXBpZmlxYVlqaVJ6azRsM2NhMVArMHN2SHVwTnda?=
 =?utf-8?B?VHoweTRNQVhpaHM1dEZFRUM1ck1TeWxxS2RTZkZ0b3JsVm4rd1o0K2lDRkF2?=
 =?utf-8?B?YlZpcExIMjZDNmZzQmZwQ0ZoemJlazh6MWxaVUovWlNQeVlpUjZsTWlBaGh5?=
 =?utf-8?B?Q0xFRy9wYzRMWFFqZVp3dnBnWVBBSHljeExTVDlUY2NvUEY1MVVVZDNHOEVE?=
 =?utf-8?B?YTdvQzB0aFFWL2prNG5XRmN2aEo0NlNCaGJka0d4bzQvQjdGallJV3h1SVoz?=
 =?utf-8?B?cE8xNEdGQmFXemtEckwwU2E5cllkZHRYaEZuTm5GcXRsSDg4RlVjWlR2dWFj?=
 =?utf-8?Q?kMgcRB7OBQMXQwOvYXPkLvpBj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fae171d-0eba-4c22-bd78-08db81ce6878
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 05:19:32.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3rdcqkS8Or7k+QBu++gss+bQtdBQNWOCxYv4b6ykHCsLCo154q1jPfD9F/wubEmdS8TJI/WlyVrlRujcSVOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/11/2023 12:00 PM, John Paul Adrian Glaubitz wrote:
> What's the best way to test this? Just build Andrew's kernel?
I didn't see the patchset shown on:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-unstable
yet. I believe the patchset will be in mm-unstable soon.

From the cover letter:
The point of all this is better performance, and Fengwei Yin has
measured improvement on x86.  I suspect you'll see improvement on
your architecture too.  Try the new will-it-scale test mentioned here:
https://lore.kernel.org/linux-mm/20230206140639.538867-5-fengwei.yin@intel.com/
You'll need to run it on an XFS filesystem and have
CONFIG_TRANSPARENT_HUGEPAGE set.

It's for performance testing. For functionality, I used:
   - System boot/reboot.
   - Using browser to access internet, Thunderbird to check email.
   - Build kernel.


Regards
Yin, Fengwei

> 
> I would like to give it a go on my SH7785LCR to be sure nothing breaks.
