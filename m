Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2C6C854C
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 19:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCXSpX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Mar 2023 14:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjCXSpW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Mar 2023 14:45:22 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FD10F;
        Fri, 24 Mar 2023 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679683521; x=1711219521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=83Lc9CrAWs2RQDU4wewaehgjBTQlOty5Dvxf+sSKZFY=;
  b=hwz6iwgBQs08LcrSv0SmMU5AnCy9ogtluYgWXGjR/Eoc9YFuh+6EQXkj
   DIcGEtHLl9d6YK+pK3IhNwlk9he+kcsk+sUXh5b/einLLNr2JSEbVldqH
   9iyvwUAVv7ZRYrsGy3nbRlj4Pa/EF8fWi0JbW3xtmLN+2zk29ynJlsOjU
   eRXOcFIMwDMtY0fRDSxJxmsaVCtidapVgm2fUpfR6eRqsRsevWvMz8GMV
   /QzBqsFIrVK3zgPgbWlvnZPkQk+JabLYk8QcKxeTfNt4VwUmR9qRjmg+j
   LNSi2YX+by6c4en0yuisjNKccCKVJ9co7koIrezhNG9CORoeaYxCNzkma
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="323738080"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="323738080"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 11:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="771986377"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="771986377"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Mar 2023 11:45:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 11:45:19 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 11:45:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 11:45:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL2THX/jf5gEfwHy63eO4rXy9dYjcD165HDiuG2tCoGCAjHVWCm1kUwGsAngpW5AwQ6UfO5yPfRWk4o/XAS1fcAsU2NKmaXm0hkbVpUKhhboVSeLmC1n+YnLDqpNc/DSdSt3iJWho4G7CZhjzfjj5jUpLL/ho1sjeuUJ2nRgmYiJ1WVRPWXjPZo5GgzUUzhE/mW4nvHBL/EVB1PluK8z8AXgFMlkMgz1aw4W47BqCJW1P01aLT2DtAtkAQO3D35ElIAJu7JKc9/hWiaub7s6d4h3D+ryF0BuMmsDPbskbZewv0YFf5GnSSlmPSCrhkQ1wUYa4S3I5txkrv/bwu+kgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iji4LtQdzdkI7kp+3oRGWMGjYb2vJfifCRWDFZh4pAE=;
 b=mZkl1dSXIb7XhWdm+6h2g5MNMfA38XevFbIa6SaGd9o0AGzXxH1L/JXW8lM0RYsiC8Z937fSSgoCDJPlejZ2WU3V7b7wGDgBU9osVQ+kbMhQymkf6aXaLDnswUgFBsLnuz3PqYpqVSJoH19LBwGRu4wdK6rrKx4/mMiCja+AJr9k85p+oPKxv4uLJKAnLlQUEMKDpEjL3QgAdQPklg/c6brmkf6ppuWGw6991f4GaIwwvWf3jwcLq3/HaDNjC+AHRVrFIW1CGIVn+oWcX357gFDIQjprnLd+gIsJ5kacsRJX0tgIXqFzttBjo/R2e6nvtDBYXLwlpiU1w+hMZqowng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS7PR11MB7952.namprd11.prod.outlook.com (2603:10b6:8:eb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.38; Fri, 24 Mar 2023 18:45:17 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::9121:8fa8:e7d9:8e46%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 18:45:17 +0000
Message-ID: <04bef83e-8679-d8f9-1f11-e55a2e5f5b58@intel.com>
Date:   Fri, 24 Mar 2023 19:45:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 26/38] pnp: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        <linux-acpi@vger.kernel.org>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-27-schnelle@linux.ibm.com>
 <CAJZ5v0gYGkbUk4uFXgidMaRBniwiXpizZWwMGixeNNejeZjPzg@mail.gmail.com>
 <CAJZ5v0gHFA_BgLuCx=Eb3J5D7f7j8kV3Pthqy3jAfpavY6UMuQ@mail.gmail.com>
 <2bcabfceab658ae62bf854e5fdaf5bc916481359.camel@linux.ibm.com>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <2bcabfceab658ae62bf854e5fdaf5bc916481359.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DS7PR11MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbf6668-874a-4d96-00f7-08db2c97e967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XK/HuChKqYVzvhPcjwX+AFRlrZQxLoiZdDjSQrtzdKIxp3WVIvJRbMWy9ULxt3Q2wBRBsQHyXpdHFEDcRvpxCJzPkkPsNmM8NmlyRigTsiIEAYiPZMieplKsFiRzXOXwAcJTLTMcGLGRJCurJW6G7De8xLXhZn4FedFYoQvKcte5ThP9UQd78Z8EiApAegT/7riJW8WNy5Wxsz0/wlyqYc20EP1mFKvT5az8Qs/F3y40mhVx4nTMUGfqCk89aMQ5kuD+JIhH1vXkrL8RKCXyk1EtzWU3N8agrHWQFqXTvpyUEEYGqGGz61F7j3zqX/vpLEwM8uWZFEbFHXCDZJEvACTl2F3pa/HE2cNIvmKfYwtH5I5mEcf21eDZddOsK/01xjT1EkcMMglMv/tyPGPDgnO845jFMpcm3V2tFR5a05HjG/oqjq1X8vDWRA7K7c0yx4hQ6zz755CcnNjt4Lv7JFStA8fzOCG79idymo8eFuCdPTY+SLdxrEYdKge00v+wVztsz9UxcVtazmBWXoFwBDlj8jtFU525Szi6VhidrOzo7y8GdVXt2p8Tum4T9cmOuStmPbiPPbK0ioYDACp5pVAaenglEKazvw9vMcBl/Q49OzC5I9q9fFfbbYF6eKcYa2KRu05bBc8XNgz3KKulHhDxrMNbzuqUyDOZTQ8HiwPrdsZraht1Fg+XnwWYA49k0ns9dKngCgaE59UCRfv6/oZsj7bapn/G5Y262XqNg+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199021)(6486002)(36756003)(8676002)(966005)(38100700002)(31686004)(66556008)(54906003)(2906002)(66946007)(41300700001)(5660300002)(7416002)(82960400001)(316002)(6666004)(110136005)(26005)(6512007)(6506007)(8936002)(2616005)(83380400001)(53546011)(4326008)(31696002)(86362001)(66476007)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck1KUjNHcUhacVkzTFJpY2hMZ3pQUUlJc2YrYlQrK1pmRnhDYUNlVlJWWUtp?=
 =?utf-8?B?WnkxQVpSRHgzUlN2R0plWEpqTjk3SHJTdkRZZmh1TnhYenU3RmR4NUw0dURz?=
 =?utf-8?B?cEVhVGZnQTBkZUFuQlRULy8wTUpDNTlzTGlHVXJwMG5sVnJQV29sNW5QcElR?=
 =?utf-8?B?UzRYaUVWbWQ3b1NBNVE4R0psZDNTaGpvbVNyUWl1RVpQQ3owMVEvNGt1Y0oz?=
 =?utf-8?B?dzN2ZWpUZkpmcFkyL0MrN2pjN1lJQ1dNN2M5WFNjWlA4ekVHZzBOWHZYd1ox?=
 =?utf-8?B?SGRRczN3TjVnZythdUQ0TjdDK2l3a21ucmcxWVJicDRIRmxjNzJZek5aZXU3?=
 =?utf-8?B?Mzg1OUxuNFZpdE0wWkx4VExrNU1keDRmcGIzRk5mcWYvSWNvQ2szb0krQlhJ?=
 =?utf-8?B?dSsyN0diRmo1Vmp3bjdXaXVjMCtiK0RrRzM4cXpBMmtsRlV5Tk9MMWxUVHMw?=
 =?utf-8?B?bktwcnk0VlNZajdGdmFBbHlwUXJQVEV4RzA0OGRnZks3R0o3bjNHSnByVnRP?=
 =?utf-8?B?aVJGanAwT0V3Yit0NUU4eXIyZkJGYmVZUXhjZ2t4N3YrMDZyVi9WOW8wd2Zt?=
 =?utf-8?B?SU9TZWR1c3FRVTh2emhwb2lJYmRicHY4R1BkdjZXaXNpcDNyaTI0Nmo2c2lK?=
 =?utf-8?B?T1B0RHJFWEF4NGdJSTl6M012TWZyTS80eFBUWnJScmo0MzBaZG95U0N3UTFh?=
 =?utf-8?B?bGJRODlxcEhxOS96RnNvT3BhVXcxMm9TL1Vzbno3ZkFNRmhQOE85SWVvNGV3?=
 =?utf-8?B?VExsN0drOUJDcERNVVFJUUNKVldWRDBxdU54M2FXeUo5R1RZb1FkME4xS1R4?=
 =?utf-8?B?SzB6ODRKaEJoYUJYeHJHWGpBdUFsNnB2cnhZK04yN3MvQUJGVXFFZkFubVMr?=
 =?utf-8?B?OUJxdmVpUmZRMkNFeXVuS3BwY1pQTk00aFQ4amRvcGZ3RTVnWmFzTU1KZzZj?=
 =?utf-8?B?Z1V3WTVmTXVCUm15T0hzcGwwUVozWCtKczZCTzRkR0k1Vm9wT3o1MkNKSlNX?=
 =?utf-8?B?TDlpeTVzMGw5eEpTYk4xbTBwUGk2VEdyaHdUSFNMMnVTejRud3NFRjJMRHFx?=
 =?utf-8?B?SUhLMDNOQ294RXJrY1dPUWVkOTBYbm0ya3E4Nytzc2gwdlErQ3ViTUpYaVpZ?=
 =?utf-8?B?VjJ4cEVKbkc1TXlsbFBRWGdaSy9VQVFUTmFmOVB4UlVHNzNTeVVNMUY0OHF3?=
 =?utf-8?B?cVpnbk54OFVUdVVKUU45elhHbENlU09iSm8zaUI2Y0pBLzh5RFVOWlN6c01U?=
 =?utf-8?B?ZjRic0FxSWdIVWpGNDZ1ZVZTVUFnMVYzejRKTmxMRjlBc280NlUzSENtTXFs?=
 =?utf-8?B?MU1WZTFEcU1xU0U0aUJZYllXSCttN1ZVd0V6aDh3RTZpL2VIUXFqeld1c090?=
 =?utf-8?B?SGxVNCsrOXNjWktrMjFPalBVbWxsQUhuZjNES2wweXhDVlF2UEZFOWtMNnIx?=
 =?utf-8?B?ZTdJN2RQclZ4alByREFlbjg0TFNva3U3bGEyQU5nOWZlaDMwOWUxbW52eTkz?=
 =?utf-8?B?UU9TS2xaY1BhTSswSWtGVGdtYS8wOC81SWgyY0xYWDlQSHVvSGZyYitmYnhE?=
 =?utf-8?B?Rjh1MzYwbW44SUlpYlp3Uk40OG9JSHZ6N1F1Qkd0am5zUXIzVmJoeTFnTnJy?=
 =?utf-8?B?dFhubzdYVnZGSHJ0a2VFOHNyUUUxWlBaNUhnRDRIMDRtb3JKYkVwaFMyeUgr?=
 =?utf-8?B?Y3hCY1JtUkZZWUplOFdpRXBzSlhSMllaRDBGaldkenNiM2pFc2YvMmIxTEtF?=
 =?utf-8?B?a0NXYlo4RWJSdVFIeHAvVlZMZzFiZlVJT3ptVTFuclpDVTNkTldnWjZIdWVL?=
 =?utf-8?B?cEdJNU1SZk1la3kzcEpJQWdCYlhUb2JrYkNUNWdsOTErcEM3SmR0b2JVREht?=
 =?utf-8?B?b3lKOHhYOWJmMmpqb0RZaVZCVVVhWVhCOTZKaWsrbUZ4Tys3aHBGVTNJK2Jx?=
 =?utf-8?B?VVVSMFk3TW1vQUR0N2lSTmFvQURVNWF0SXc1Nmh5d3NPZjhNRUFkeDBrQmsz?=
 =?utf-8?B?UCtuSG9mT1R4aEdwSEVEeUJsdHI4NDJPbkZXWllFYUhaUXdtSWF1TjNVaWNa?=
 =?utf-8?B?Z3liclJkQjNvclBvc3pZV25MSjFnRUNHQ0ZwYWlrV1d0Q1VRTnJpNDQySUpI?=
 =?utf-8?B?NE16QjJKUk9zVDNFVE0vMDRjK3ZodThRS0w2WFM2bVlFZUw0ZWNHaGtIa0dP?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbf6668-874a-4d96-00f7-08db2c97e967
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 18:45:17.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCyzffHJXhxL5kLf3eyBtA84lyR8t6I0/YJe3ZnqcCVn7Dv+fI8YUfZOju73dGmDeOWiQby7p9LDKyBQSyg1z5v9y46nj1IKpW/8sxLqegE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7952
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 3/23/2023 1:55 PM, Niklas Schnelle wrote:
> On Tue, 2023-03-21 at 14:56 +0100, Rafael J. Wysocki wrote:
>> On Mon, Mar 20, 2023 at 6:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Tue, Mar 14, 2023 at 1:13 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>>>> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>>>> not being declared. We thus need to depend on HAS_IOPORT even when
>>>> compile testing only.
>>>>
>>>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>>> ---
>>>>   drivers/pnp/isapnp/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
>>>> index d0479a563123..79bd48f1dd94 100644
>>>> --- a/drivers/pnp/isapnp/Kconfig
>>>> +++ b/drivers/pnp/isapnp/Kconfig
>>>> @@ -4,7 +4,7 @@
>>>>   #
>>>>   config ISAPNP
>>>>          bool "ISA Plug and Play support"
>>>> -       depends on ISA || COMPILE_TEST
>>>> +       depends on ISA || (HAS_IOPORT && COMPILE_TEST)
>> This breaks code selecting ISAPNP and not depending on it.  See
>> https://lore.kernel.org/linux-acpi/202303211932.5gtCVHCz-lkp@intel.com/T/#u
>> for example.
>>
>> I'm dropping the patch now, please fix and resend.
>>
> Sorry if this wasn't super clear but all patches in this series depend
> on patch 1 which introduces the HAS_IOPORT Kconfig option. There's
> really two options, either the whole series goes via e.g. Arnd's tree
> at once or we first only merge patch 1 and then add the rest per
> subsystem until finally the last patch can remove inb()/outb() when
> HAS_IOPORT is unset.

Well, it looks like you need to decide on the approach then and tell 
people what it is.

If I see an individual patch without context, this is quite hard to 
figure out.


> That said I'm a little unsure about the linked error if that is just
> due to missing HAS_IOPORT or something else. I'll still have to try
> with the instructions in that mail and will report back if it is
> something else.
>
> Thanks,
> Niklas
