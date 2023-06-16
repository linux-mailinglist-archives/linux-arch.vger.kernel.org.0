Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1835733B34
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 22:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbjFPUy3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 16:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbjFPUy2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 16:54:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2143AAA;
        Fri, 16 Jun 2023 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686948865; x=1718484865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=89y4ftzoI6FMSkooEZVizu2DFTDh1rTRCt9LSwATmwI=;
  b=lA99tmzjAuUvVTIsqXWvPQ5/Nc8oJeKSu8q7INUalWCnif0DBrmgtN7d
   KU3PYwBPuxAascvcWhp9T7hncm6pLfP93bFRXTNnMSqqvOwQHFo/BC7dt
   EzIxX0QMrod2CWvkUIL6ZAVCEhjIy5nDi1NGONe96qQC6EnMBoqoe0Stt
   aBRtdyg9OvrlKGD11WFXLWrYwYEDheUmQ4rPFdrCqvk2+AY3lhCjtQ668
   GdLMtExx1rpbZhMtT+mCLplcoE/Pdxqa5DpylqGQ7WZPKNtPr7Mgmwfl4
   v8nofQsl32vtZr0pgfh+H4s8xSouYgGfTF7MKZrjHVFEPDQbkjvmsKR88
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="344049163"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="344049163"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 13:54:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="742782825"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="742782825"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 16 Jun 2023 13:54:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 13:54:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 13:54:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 13:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGqNX2YA22yNcwGh/S3SJVWw1sD8u9EeWZWE3u/1tZArr8WNlrOPRBpzgBS/c4ugzTleILS7/Sql0nkn4FA52ZYbbRDITFayWfnlDA6rztG38mbXrDZC3r0P0d8F5ZE3m7OJshfVVHPsWBkyyO4+hiHX6kPKEbTJ/Fqm4jPKFkEPZsEXzYQUEKfXf5dbINOMqOg4Uxjqjdcwnn0K38JWnDAHZxPRDDJzVcNWzil1CofyslWQs8xhZVvjqOgj3YsDRNS9jTuMhD/mBPKUtbRcym3CgiK4WgmlI4AElqwqLvrjgf6/k+maOPEAO3Is0XZqiUMkreE1uhkygzv0X7Be/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pe1vloJ1HXm8mA0kmlbGhLAAAp2wPHCeQRPfwHldK8=;
 b=XZgA+uTQIcSRAir29f16JMukHillxbGnFRyMXxYFlT861YeHtuYFdrLptgYBdgyZwMu6PCYTc6kajPM74B5cXXRD2LDSjRj3V/P8KLZ9LMoxEaEeQIG7jn5fZ0id+B9l208KrdzCHtsSZDq4mKqUXx/Dgtsef1QerG6TQejo5kj+oYg+D90y3XcKGhIU5QefqvZQmrQEAHKrV+0ZxM6YYMTGrTTD8udoOFRlE+aEccVWfV3MjSl9QKTS3mTESDW9/REC3GczxZCZoogRWe52U2Kvig68aXdIvrCf5aTUV4z5CS6MALCA3I9Q4L5XCavTnCB/00euDLOnV/qIB3ZBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA1PR11MB6196.namprd11.prod.outlook.com (2603:10b6:208:3e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 20:54:21 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::455f:e688:3955:28b2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::455f:e688:3955:28b2%7]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 20:54:21 +0000
Message-ID: <e1a2665d-2e11-7722-a7ae-ef534829ed37@intel.com>
Date:   Fri, 16 Jun 2023 13:54:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] syscalls: Fix file path names in the header comments
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
References: <20230616183120.1706378-1-sohil.mehta@intel.com>
 <c2f3656f-b831-4009-8ee6-a2430c4ac8c7@app.fastmail.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <c2f3656f-b831-4009-8ee6-a2430c4ac8c7@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA1PR11MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: a8628eb4-71ca-4c4d-f00e-08db6eabdbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzbsqi7KTLOd6gDYYhA0JLWRvvLjWwTDLUIWsFn/YJVb/N/j2xlozrj67XwkndzmK+tBWlKtX5SE2/JSuiYLI29jHRIvbzzGf6cL9CMvxtbvsLyp3vCU9zkBgJByFGzJEJJpKfvDs0Yzmq/v1WZ/OQCUFxBav+I8p+Bp1XU6LOu+2aYfgRX/Y8QDPas8P74CtHEAVRxF0FmUeqliU+BvE4ixlG435R5uFJZlzlbFHLe1S0CJS3ZexMGp46tWqEPKparwYWKeKxVoGYvm+L6Vs2fsorjy0LrOqxN1jwfg0tARFv/irqQIyfLTNBpQfE6v0MRcNf5Mk4WulfXK4nkSaIAPEN+e9DH3f8NRJVMX38EdXsYUqorZJimqQHuYfFA0a0Ut9Ed4mO3qTEFqDQwnjhJgvccCKUdlXeYSvWKRmcMHyUzYP0+LOr2t6auxwQqAtBSKmd9r0ZnIguxEBF33c6kdJP4j8mBSS4nCz8eIvZwby0c0wk1dZl/ajRPwhq98DEADgHrT8GmoKwfsC+/LlJaE29iqe6lGwKkwXpAhVRGUlt3PnE2Ka/yxoZTY9TY35DYJJvVPsS0pB4hkvMUk70mrfu9m4Wy9xUdNHR6+zt5W4eo7Ae7xjEJav5OguwgP/vDHqIipislpK2g8udkgMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(31686004)(5660300002)(8676002)(8936002)(2906002)(82960400001)(38100700002)(41300700001)(66946007)(66476007)(66556008)(558084003)(6916009)(4326008)(2616005)(36756003)(186003)(53546011)(6506007)(26005)(6512007)(478600001)(6486002)(316002)(44832011)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnM4SDMxdEJia1kwVk8vYXlyc015d2JFUTRuMXdMM2dBUmxHL09TTS9LU2Er?=
 =?utf-8?B?U0pjQ2I3NWhYQmVidkNPbDNIVFk1ZTJPU1dFWGRwK3FSc1NtejZvamhUZC9W?=
 =?utf-8?B?anBaVFN6SVl5T3JKc0NIUW50TDJOdFFFQ3dvR0swa21JVzFUeXNYbXNPYXlx?=
 =?utf-8?B?Ym1mSnY2Q0d0dHVPV1JpS0taWTQvT2ovUlcyMlZuM1JRWWR3aTBoaXhJbGNS?=
 =?utf-8?B?K0tzTU55TlVzQzJDQnh5VjI3eUNTa0theGNaTzZQSGY4TVYvN3VlaCtPNURV?=
 =?utf-8?B?MlRDMW1BVUY4NzNaUTN5UGNSL2RYSjBiWVVKZzFYd2k4QzFuWUtqY3VqS3c3?=
 =?utf-8?B?cmV3ajlCLzlSU05BZndoU21CNE94Q2dMQUlqOWlwK2VWT0lqRkpDaldva3FD?=
 =?utf-8?B?KzZXcTRMWFNjam5FWFdNK1crUXdDOHJIMlhEMnRLWGljbmRyeUlQek40ZFZE?=
 =?utf-8?B?bDk1S3lqd2dvMHFSQ0g5YTBiWmp6M29Ia1VhVzh2c1NDUzViZVZSZFRONTNh?=
 =?utf-8?B?bDY5R0xVVEg3eXUyR2JYMXEraEc4Y3NwYWo5ZzhYMWZURklHdVNVUkp0RUcx?=
 =?utf-8?B?U0FmemFkS1BzcUtKYjAzRHFIeGE2MlBiSVlJNytkOGVaQW4ySTZzQmFLYUF4?=
 =?utf-8?B?VnlpTDdleTBCZE1Pa3VOUWdxVWpNSjhPT24rWEI1Y2QyZ1pZQWZwRlhFZWwy?=
 =?utf-8?B?eVROZmd1UENPL1RzU3Z5TzBQcHlDS1pIQjdDRkU0MjQ0Nld5blNFVjBpdE81?=
 =?utf-8?B?Q2tzanZlaGdnM0svSDg2S0pJenRRYm1nZkVIbHpWenhYcTg1Ly9EeXlvU1lD?=
 =?utf-8?B?Q2plVm1URlRHMVE3R0V3ZHZwNnhzYjdFVzJ0aSsxcnAwdkRlN3dyM2hZcWJK?=
 =?utf-8?B?WnR5M3FOQVdkV2R6cEI0Vis2ZjY1UmFPRVViZmNEdlZBSldhK3MzNXVkODZq?=
 =?utf-8?B?MmR5emxkN0tPZ1ZGSWMvb2dFL1krZDU1RWpJU21TYUIyNHhFR0Jrd0JDb3p1?=
 =?utf-8?B?YzUxWkVCL1NNYjhlcGhyMHpNbUhVSmxTMy80M0FVYmhFN1NDYWhMQVUxZFpW?=
 =?utf-8?B?TTlmVUdjYkVWZno0eUg3UXN2NkhibVczOWJBNXpONGlEeDFmRHhDS0I4NHVt?=
 =?utf-8?B?dkcveFpCOUNGeTlsUU9HelRUQXNiWWxBNmNsbnhHS2RGN0RtNHhpZ1Z5ODRO?=
 =?utf-8?B?cjhEbnl3cFBTWXpuVEdwS0YzdG5NV1JKNlRobXRIOEdGcjB5cVNabEdnaU5K?=
 =?utf-8?B?cEk3U0FSeXEwNVJVSXlrcEQ5ZXI2RG9WQjlNSjdUWktPeTdLc1NVdktrVzVo?=
 =?utf-8?B?dG9FdW9UbmwzZ21lQ1BlNE9OaXZVck41NHJ2RnhrRnFYdFk3ZEg3TDdkWjJ1?=
 =?utf-8?B?QTJWdTA2M1JReUd0Vjg0Mk9VRW5rTVowNDJLVjVoSkdTNXJFTXdwZkNBNUMr?=
 =?utf-8?B?SUpBWDM3dzRFUUdpQVRoQlZtWTZuL1lBRElKS2pWSG9HQ0NTejVRc1dCYll4?=
 =?utf-8?B?azJJT25WakhXN0N3c0RuZ3oyYS94RG9GTmltWjBFRGlrd0JXUWRCb2FjV3hr?=
 =?utf-8?B?RjBDQ0hiQWdQTDBHME4zUzdUMWZuK1RabnhtMEVpd29RTnRlZVkzSGt3SHFN?=
 =?utf-8?B?UVZnVVdxTUVXRTFnSW9Hb2V1aEdSc3FBcmx0NDk1RE54MGtRNENhc1pHeEw3?=
 =?utf-8?B?Q3A1QWRKUXNTY1JIenJnN2gwNFNQM1RYUmVMbXZ0T3Q3SHlvcGRWNWhEUXZX?=
 =?utf-8?B?dWZIOHV5MWc4QndSNTgvclZPTFFhQ2hsV3E2Y2dRTFJkV0JoYmRpVFRlRC9n?=
 =?utf-8?B?OGs1MXkzMHZVS0hUKzJPS2JwaWVlcUQvd0E1NGIxU0VDSEROS1Q5UXp4ZkVL?=
 =?utf-8?B?bXdzSUtYeWRqa0FMTDZnMy91emVrUm5uSC8ySDJocUFGUFVMNUdGWGNJWmNW?=
 =?utf-8?B?dXZDOGN0V2RlanYrRUs4a05GWU5TNUZFQ0RnM1pWNEtWaWFwaFRIMkRyZzkv?=
 =?utf-8?B?MXF6WFpsN21QU2xQODQxeS9nZEUySkZ5NWJRTFZtVnRCQTNlRHBTa0VYR0pY?=
 =?utf-8?B?c0VITEVIUVdxZ1lpMEtaaG1OZk1pZ0M5Z2ljcS8waHdEK2l6QXg4aVYxaDZt?=
 =?utf-8?Q?8u+Gn4ya6p8xG1n5y8462ATjp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8628eb4-71ca-4c4d-f00e-08db6eabdbf5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 20:54:21.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keB6sDmCWmq4nCuJ54UlZ3tHfCmurynxBfnftv1Z3ku7KKXJC9TGBPuYydHPak0f9AnFmR9eadJh0DSKlcCYUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6196
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/16/2023 1:11 PM, Arnd Bergmann wrote:
> It's probably not worth trying to keep the comments in sync, I'd be in
> favor of just removing them all.
> 

Great, thanks! I'll spin up a patch to remove them. You can then choose
to apply either of them.

Sohil

