Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31168EE91
	for <lists+linux-arch@lfdr.de>; Wed,  8 Feb 2023 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBHMJ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Feb 2023 07:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBHMJ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Feb 2023 07:09:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41CA2713;
        Wed,  8 Feb 2023 04:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675858167; x=1707394167;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=is0pnbUlCSwNC13hHLUzg+YQtH+19+Etby7SBYvbZhw=;
  b=NQVU7u0R1lOu/u1ATOCoCWIPXgxsfBiQfhFWmXTVq0NQ3rnw5i2yjJZU
   vUGDP/YltIVrrJIZHl+owyPEgTwFXqxpB0QbD3+QnNiX2Yy7z+WkPCY44
   UrSklNPoX6ZyQARcTw7YzYcdb0NHZpRYzz1n+VJBW1hXNxJJRelzRZFBE
   AmRgfPhdUGox1mLPJb0x9VamiKEDPYi+xlQSvnp4//Pe3BKmDNDjacNt3
   jqJGxkvnB2H+xEIlt0U7igbnT/maKPQKYNsz9HR7U8E+s5QYCQcSWKnHD
   sT0/2Es6QTBxpmWbV8hIOfSTxMIrv8i5t12dfgs5jnmDl3rBkIHvZUWfY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="357172654"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="357172654"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 04:09:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="775994587"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="775994587"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 04:09:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 04:09:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 04:09:14 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 04:09:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UetAz8TcwLb92WJwlPycXHgOSX6nbCXukdgaXL26bB9XiWUNQxHEMRFGQ1XLYz7lM5JlQQubXnrfvTFWJNTMxEVnfQk5iKRIfpwpc872/kuMw5WHpQhA2Xl1kV6xD357u7c5JJxmbs5N/Nnj7FgWXpOmjBi5nhZLYHl3hMaCIOs3DfE3xmgRsyuC7sLeyq+HhF4rOdacNdoeQ5HMvOO2mEmakHBQGRoZUlGjgv+qMm8S056XsjhL+gxoTsdTgYojvVxYyTxa3aJYxIjQoeJUAYQE6OZ9PwGh4t+9PCQLcbzkkpmzn+liSidi3qV7wcsgk4cuyPgwUOnJU4t14TVzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgq8yb/IGQqgIlS+tWoKk1s1+G5L24A9Gc4USdsUKyE=;
 b=WeNS+txvvlnKmoMufEvu8ytm5gWM8eaDBQk/OkrOoD+LGj7D9UukdOKxxJGo9VUWaJlYlXTQQxdd4fUdxRIV7WEymCV7+Hv9/2QpUkWsaNf4Zxwml/1mkKDEDVgWwWVmHWx1d0mNr9waHkyamTklNogYiGcT0fI8YilfBdrC2DXUl4tt3oKOTIQetpHFRxf3HACisWcck6njxFEeZuazTTSa3BA2cKxxMuVcXkCqZISNPgD4mAixbnpEDBCu+UKKTYStA5XPPSdr/1GmqjpdLhKESTIIa/mUImLT4B9fEubZi6GHAqEzxV/92ly37+QeFyZNySHEfxxdoeF1beVMrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Wed, 8 Feb
 2023 12:09:11 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%6]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 12:09:11 +0000
Message-ID: <b44d5dc7-ee7a-80e0-5401-829bf5740de5@intel.com>
Date:   Wed, 8 Feb 2023 20:09:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: API for setting multiple PTEs at once
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Matthew Wilcox <willy@infradead.org>,
        <linux-arch@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <linux-alpha@vger.kernel.org>,
        <linux-csky@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@vger.kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
        <linux-parisc@vger.kernel.org>, <linux-sh@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <loongarch@lists.linux.dev>, <openrisc@lists.librecores.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <sparclinux@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>
References: <Y9wnr8SGfGGbi/bk@casper.infradead.org>
 <Y+K0O35jNNzxiXE6@casper.infradead.org>
 <ba99ed28-61e4-4acd-ce17-338f5a49ef26@ghiti.fr>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ba99ed28-61e4-4acd-ce17-338f5a49ef26@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:4:7c::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 74446351-54ae-4c4a-5f78-08db09cd4997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3uX1/jzWwBD41j7lQH8xDqE+z6KOqrU1p4GTnaVEZudK4K+xQcNEe7JAbr9CB3MseGBWBguyx5VwRX6Y/tz7USNfmgAShnSfzhsH6sYkgxQ8Sk/jb/MRKCpEom3TzXzItgeSnB0SODs8AxMGHZZl9Cugno4pcmAjgtAIBv4/2nqWYrqkZz9etf9EGD83SsNp+YSKe1TsNf7ZPPhj9CYXnBFSdTWukPdBFLWLKBqL5/6+gZgfXGeUmDEBvXWCQsGyzMPBkMCg4dylY+ufTpZCLLAVjm7Nn4oND+dvxVMHprsDmcD823aBG3cbfEOuAc2qLGYUKCUoGw5Z9pkPxLXaANeFKt7cqUGmUofFPQSwiNlm0WmT0nxJNhMGrbMa8Q3cbgBx2MoJKK8G8CLySJHA5NmfsdH7VFnFtOyvW3hvZM3FlJV+sgXxCtlSa5js53PEO51DBa5WlUrG5OmygOfZnYtNE0//jR7abLekuGkxR/n+reTKdKJu9HapwjfDEU703n0dfrH8m1mkC+ilA1uQQjiX+W9qaYvAQUf4eTxpFiQbBVVuKyy7QjAhdDQ7VdM2FDFAS6wjEjpG1+RlThnW4CJP2JGVb9DjelTlMZE+QgiaF/wC0kij8/DxcZGr+aLxKTZAvI3k7O3l7/gf4qLLRzcdWTYRwShEGWNk1O2m+niYSD4fuMwiqjX45gy59budM5zfhO2t4DftoVIlk2AKGbcAl+SYD9xqsZ9o7J4+bgNSX2Jsaoff//dSYcSobzYgfg2Z0JIISBANMJhJxnvpbgw7EadXJ0FS6posiH9pVv3e0UkhC8/I9vNd6rRz0wlt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199018)(8936002)(41300700001)(8676002)(6512007)(186003)(26005)(2616005)(83380400001)(82960400001)(2906002)(66946007)(4326008)(66476007)(66556008)(31696002)(31686004)(5660300002)(110136005)(7416002)(316002)(38100700002)(86362001)(6486002)(478600001)(966005)(6666004)(53546011)(6506007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3k1QkJlbXFBcHM2TDZ1N3d2NEF2bXk4b20wMEdHdmFPa2ZuTkdMYXZYbE9L?=
 =?utf-8?B?RlY1Vy9sNXV1a1ltMythM2d4ZllRU2M2cHhLTnMxS3B5c051Vm9FTmMxd3hM?=
 =?utf-8?B?MG5WSFZjdmN5SkZnWkt3Sml6ZWZROURpby9DVVY1WnhiaThFZ3F5V3RKeHZ2?=
 =?utf-8?B?ZXNqV3FVSWlpM2NGbmFtYzhSdEE0d25rM01qbUNBc24xSFVadDl1QmZMMzA4?=
 =?utf-8?B?UzBuYnFRNU1ldVVielIxMzAxVUFITzRYb1pkS2gxdTN3bVlSdmhISWIzNEdK?=
 =?utf-8?B?OUhyNmJERXBJcXo3Y2huR0RkaVc1azJWYVFDVGJ1US9IbkJRU2E2cnpSN244?=
 =?utf-8?B?aWJQVklSNzdDVHJaZ0M2czBQYTNaempPYjBma2hmL0EzRW1ldlVDUkpZY2tM?=
 =?utf-8?B?dlVCSFRyMk5iS2EyV2ZhTVdaZTdvbXZuNktiVjNsL0Z2ZFQzTzlldXlEVEJH?=
 =?utf-8?B?UFlZcFRONWxUMXBZeU5CdHNza2tBdDg5Yk1TMDlVZTNMYUVBWGxmcmFSNHV3?=
 =?utf-8?B?dGt5YVRKSWUyWXlJQmRtRmJaakpIVzdzeFRnNXZqSVRoTThSN1Z6Z2pjcHJl?=
 =?utf-8?B?UVgrUlBjbmljV3hjWjNEanhHa1MybGxZWWp1d1dpWnFZOXJRaE1HUTNvbUVx?=
 =?utf-8?B?NW5jUkdYWVdSSWFnQXNwN3BsenZuWVVCMElvajNsQi9MZm9WN0Mzc29kTTdG?=
 =?utf-8?B?UEZyY2w1MmU1R2k1UVNNUzRqTmJZTmxGMDlIQmtqeDR0NFQ0SGFDdDZyZ25r?=
 =?utf-8?B?cml1UHd4dCtiU2xQdHJNazgrMHU5dTNrdW9kZ0VmK1FCS2M1MnppenJKV3dT?=
 =?utf-8?B?VTB4RkdWYVFEdG54VXpxMnF1WWZTM29DQnJVQWxlUzUwRzR1ZithSFdERHNk?=
 =?utf-8?B?TzZNVjdsMzRGdHVOMXdjazE1Qm05alZXSCtuQmVVQnpMeHZma0x3NmhrcHJ0?=
 =?utf-8?B?UjJCRFZ1bllFaHA2R2JBZEp2UEpZOTdiT0FxZm8wZkZsTUNyR0NTL3hLMmM3?=
 =?utf-8?B?NHl1aHBoelhWTnBpUnMreThNaTU2SkVEazZmMnR3b21xMlY2eGtrSkJ5cHRV?=
 =?utf-8?B?S0paMjFndXVaSEFMYUlVWWsyOUxnbkJkWTdncE9XNDBCVkJ1T0hBYWpQd2Vs?=
 =?utf-8?B?bzc0NjExNTFWOUZheDJFQmlCa3VKWTVObW0ycmdnQ0h2dTNaa0d5UmxKVFBI?=
 =?utf-8?B?SFI0dU5WVnlpWjd0bWF4NDZTTklpYnlRSWpJU21iUHFoS0JLYjV0QVNXSTJK?=
 =?utf-8?B?VmVyaHFLT0RwYmtuMmMrNTgxVno4ZU9kdnhNTHlIRzhnNnAyL0N2MWJmTDMz?=
 =?utf-8?B?ZytRRHBnZVF5a3FYVjJ3TG9GRGZyOWpmUlVQT05CYXk1WXRJQVU0UnNlbmFt?=
 =?utf-8?B?UmdRUUJxZHB3V05XTnVDN1dSTEViVHNuQWRlYmFmMXQyS0M0VTluTU5CcmFj?=
 =?utf-8?B?SDV5alUvWEltS1B0MDhMWFBEZDRsK3FQYzFpZ1ZUVWdGTHh6a0JGY2NHdGxP?=
 =?utf-8?B?b0lmNFkwRk9mcVZiT1ZSRDZTdWI3UnlxaklmeHBIcGJTZEV1Zm9yK01Wangy?=
 =?utf-8?B?WjE0WW14THN0SWNhRUJSOEZNdFZMSlRCMDVVN3NlYmxoOHloN25oeUlvdjVQ?=
 =?utf-8?B?YnYzamU2aXpOVy93aU5IMHVJWmZxVWhxYzJRNXdiaUh0blR1V1I1Q09kUXp1?=
 =?utf-8?B?cXZSejU3TE9zeisvVUhSZ2J1ejduQVlxdFo2L1hBR0d0ZVh0MEpiak9lVnVu?=
 =?utf-8?B?Q1IycWxQUURIWFpOZ0dVY05TNmdwdC9jcnJ3L3Azd2lqL29od3YyWSs4d214?=
 =?utf-8?B?SkJqOWhnV2VzZW12cU55UTBGdHl6ODdSZGlQNldiVzR6U2VHYS85Zi91OGVO?=
 =?utf-8?B?eFFEV201Q0YvUGN2M2ZISUQ4WUkxVHNPNjFTZ3FPVGZ4akMyTTdyb1pJeVIy?=
 =?utf-8?B?YzRpNWhLVWpkaGpPVWVWWEg0Nzg4K3Y5WWU4TDdrcE1uT2FqQkFXTlMvMWxu?=
 =?utf-8?B?N2ZBMUhWSzdlYmZKMUJSbjlnaHRpeHZVUm0xcWN1MlEwRkhlS1F5L2daNzFz?=
 =?utf-8?B?Y2Q0VkdFZVoxUXRzdy9OVWdVbU8zMldHZm8wQmd6K1RZdE11MWZoSEJ0VDhy?=
 =?utf-8?B?WWxXM0kvV1IwZjV5TkZSUFB3VVFOdXduNmh2R0ZPSDVZQkluMDRROElUbUto?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74446351-54ae-4c4a-5f78-08db09cd4997
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 12:09:11.3003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zosHd4DwCyREAi4opUOQu23bZx1HzMLtiKazf49KiBq+KVmyfnJXQ3lMJfd91Maax6AZIK+hLTFMjjTOdSuVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/8/2023 7:23 PM, Alexandre Ghiti wrote:
> Hi Matthew,
> 
> On 2/7/23 21:27, Matthew Wilcox wrote:
>> On Thu, Feb 02, 2023 at 09:14:23PM +0000, Matthew Wilcox wrote:
>>> For those of you not subscribed, linux-mm is currently discussing
>>> how best to handle page faults on large folios.  I simply made it work
>>> when adding large folio support.  Now Yin Fengwei is working on
>>> making it fast.
>> OK, here's an actual implementation:
>>
>> https://lore.kernel.org/linux-mm/20230207194937.122543-3-willy@infradead.org/
>>
>> It survives a run of xfstests.  If your architecture doesn't store its
>> PFNs at PAGE_SHIFT, you're going to want to implement your own set_ptes(),
> 
> 
> riscv stores its pfn at PAGE_PFN_SHIFT instead of PAGE_SHIFT, se we need to reimplement set_ptes. But I have been playing with your patchset and we never fall into the case where set_ptes is called with nr > 1, any idea why? I booted a large ubuntu defconfig and launched will_it_scale.page_fault4.
Need to use xfs filesystem to get large folio for file mapping.
Other filesystem may be also OK. But I just tried xfs. Thanks.


Regards
Yin, Fengwei

> 
> I'll come up with the proper implementation of set_ptes anyway soon.
> 
> Thanks,
> 
> Alex
> 
> 
>> or you'll see entirely the wrong pages mapped into userspace.  You may
>> also wish to implement set_ptes() if it can be done more efficiently
>> than __pte(pteval(pte) + PAGE_SIZE).
>>
>> Architectures that implement things like flush_icache_page() and
>> update_mmu_cache() may want to propose batched versions of those.
>> That's alpha, csky, m68k, mips, nios2, parisc, sh,
>> arm, loongarch, openrisc, powerpc, riscv, sparc and xtensa.
>> Maintainers BCC'd, mailing lists CC'd.
>>
>> I'm happy to collect implementations and submit them as part of a v6.
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
