Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C247841A053
	for <lists+linux-arch@lfdr.de>; Mon, 27 Sep 2021 22:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236776AbhI0Uou (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 16:44:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:56885 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236470AbhI0Uot (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 16:44:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="211809917"
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="211809917"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 13:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="553470858"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2021 13:43:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 13:43:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 27 Sep 2021 13:43:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 27 Sep 2021 13:43:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 27 Sep 2021 13:43:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JclATX2Jv0yeSalMai/wR/mnRKNQ08xX07B9AbcQn6Z9BGI4UvVtPEKLCCsVI7w4JiToGLSma4DM7Ka5WIT5QRTrXGEhxWa3j17+OB9Y8PTOwZvRAax6fkp/MJvqBKeq2mkQRr9IA/u9NheGT27O98ByyzaVq8xLfWgRrtXoUf3JVK2npZiwkOgvO73bQAac5X7aKoUlyNXn84hLSbPWZ+0atMQ5Xb29xZv1E8q/qz/83wsr6sjKYDReshRN6FtQRK8p+EJEiLcMBYSqpN6KFZjK1QXZBgaB6/yUnFlDrBkBsIN1C8qz4YlULoTpsaTej0O+n9XeopMvM6ejwSJRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VB+YX0KchxRbsVVY2oIFJzRfo71ArlTSZ5lWZ2LGp/E=;
 b=i+g0aXLZye2uaIc6oeHK0PqfsqXV6jxnoXjVIkLcOZGuvd0OwY1hI/per5WitBe0rb0ezAt/7WNrFc0sXBfQbvfzW2CEN2fahnU5Dpa9O9aXRfDrmoPF6zz0asU7//brmpTUcfu29qrhRwiIBddK5VZ77Xfp1GHbJ9oKkj4a3AGAyCmHKY3ZJ0QLjAjveL7URPQLF1BoSrzSivS+VGBg28/xi5feNiSQHx6taLumsWXdcArH7NZFWujprJMA+9v6pqmDII23/KBoUVnwBOhIW9z8/skPk24qjmDEAA7Q2KZrYNlsezwKnsJFhdpkli455xKa2458R3fELEpfSewe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB+YX0KchxRbsVVY2oIFJzRfo71ArlTSZ5lWZ2LGp/E=;
 b=TChKLO7MMmH2i3nJ7Xc/JU+/Pgwj1DKtUN/7QTdL1YNW+T6V26QFP0iGDOmryOAGlx/1X/nqEblV7A+swCgMbSLtRsh32oSzavUQkDCLKsVlegYZqGq0FzgGDc6N4+FM/6maFz+Pd4wa5daGKrWHKrTZTrpuUdQYNAVww4BKhjg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY5PR11MB3927.namprd11.prod.outlook.com (2603:10b6:a03:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Mon, 27 Sep
 2021 20:42:36 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 20:42:36 +0000
Subject: Re: [RFC PATCH 03/13] x86/cpu: Enumerate User Interrupts support
To:     Thomas Gleixner <tglx@linutronix.de>, <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-4-sohil.mehta@intel.com> <87lf3nexrz.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <42a14757-5b38-19cf-d830-1641b07f89ba@intel.com>
Date:   Mon, 27 Sep 2021 13:42:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <87lf3nexrz.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BY3PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:39a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 20:42:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b7c9686-96b1-43e5-8da2-08d981f75655
X-MS-TrafficTypeDiagnostic: BY5PR11MB3927:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR11MB39276310040765B576719F87E5A79@BY5PR11MB3927.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dysgKdKMVbsOBueh/hjVEpqbmcbiCgTLGpsRa+MTNfwi/g+jL8Can4x4zBmwstQgd2/x00JVTBqzjKIitTejLh4BHizyHAeEpKqS6YNIGe6m9Ho24IZprRQiWFXKnK2Ot9FyP3RejyKdVyUJaSVVXqfRsq7gnJWLP+S+hpLPlvjKhXKvfhAMDdak9getgjkxlqBAxdIkdyvACPtaPQdn5z65RZAs6bJ2o48zXMgyHeX9itg24RT6MUmiCdztHfb+L16pzm3DfE1X39u+HFgGJqsHtJ2jgyz6i0QbEhlbRbA6xALHUFo4Py/b2pvmvj6AyxQaAJD4nojPnUoKIg8e2wM/jbxgsBFouunt6F6TUj/a6zpVnpc40EbeWU73X4vyzknTv/XV5HniyMHnloUPtFBarzWVo2chSLRqXLeQ/hO3V8K1MlNFBUdZVFiUHSx+gGs86gUH+Wa3xdMFl4clEtMxTcE0Al68X0sOOfZMIv/8YONTkbeq4jbp54Hu9YOGMohZWGdTgQ8Tjv6mkOkCGSCm/kNY0DVmqxENVMasAswK/XHiCyP2m1xcJ6lQGT5nO36BNLD9BBEUMkx46g9GcSSIumQ9Ys1E/qhLf2+tdrkuvOBOSA4z4dPtbHf5grbeoPDJS7JfibqE8pmS0wS9v1MozO7hpNUICrm/QEAHhj7ERVZz9fUagHnFBKIuAftJO1JYc/0M6ymSdbqOl1NSViE/STBIM1j81I3OFsXJdIBlW5sjuQF4AGJUVZBrWo8s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66946007)(36756003)(31686004)(508600001)(5660300002)(8936002)(26005)(186003)(316002)(16576012)(44832011)(4326008)(54906003)(7416002)(83380400001)(2616005)(6486002)(38100700002)(53546011)(31696002)(956004)(86362001)(2906002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUVidS9nRTdyVFpmc3hqWHdKMXpZeXN2aEJjdXlCWmRGVFB4bTh2ZlozUTF4?=
 =?utf-8?B?cXZKNjg1TnBCSHRFYkxIVVJyZXVpMXpaZmI3WjhhTXdLekkwODJ2OHUrRDBX?=
 =?utf-8?B?SjNMallleHdLQTZENEoyYTZQYnRKbDdZWG43cUMraXlJdk1Vc3ZYb0hDMVFX?=
 =?utf-8?B?Ky9FSDB0NCtZaU9YZ2dmbWwxUWtMcHFvdFVPQWhJbWxsRkxsS0VKT2Q1S3pq?=
 =?utf-8?B?YVpVZUo0YVhwcmRkZGNVUU5TTGFSY1k5djlVNkFCV2ZnQjlCQUZMWlRyQ2U0?=
 =?utf-8?B?bnlCbDBKT1lFVGp5ZzM3Rk1KMjdSV1g5Nms0TVd3Ym9ZRUZlOFN4NEhDMmhS?=
 =?utf-8?B?MzYyOGJiUEJrczFZSHFXa0IwbklsWEc1RmQ0dXhGMlJvRXZ3UHdLZ1crZ0pj?=
 =?utf-8?B?dGF3Vi9XZU1iVUVRdzhyeHZHMVNjVTVpcWZtazNoT1FkelFyaXoxZmFadlNv?=
 =?utf-8?B?dWRzUU9sN0ZXWVVHaWJzSzNPdWkwUGcvOVhUdW9VUUJuUE5Ha2l3aEtsN2F3?=
 =?utf-8?B?MlVzSERRdldYWEFYZzZBWVFwc2ErQThFLzVWNDNmbWZvZHlMTGpFb2p3Q044?=
 =?utf-8?B?SEcwaEpSaXZnRFlKNHdoWGxFaUVvbXhEcmcvdXRoZy9tMzhJVWxOZFllY0JW?=
 =?utf-8?B?cEpjcWIvS0NhOE5zdnd2bE5xY01EcWhOalFmUEtGKzhQYldvUW1WS0psSXd4?=
 =?utf-8?B?d3c4MHFKQWhKOW1LcFJJdmhLZk0vSXRoc01adHlUZm53U0dTNk9FZWVzTC85?=
 =?utf-8?B?ZEJobXBBVU9RaVJQbWFHeksrb3ZOS2Z5WXJaVm52UGV6d09SN053U3RvK25J?=
 =?utf-8?B?YVRLVWRsYXJZb1pqazdyS0ZURzdDNlB4UjliViszLzlQYVNiakgyM3o4S0hu?=
 =?utf-8?B?aGZFcWViV3FtN1h1aDUrQVNZUFY1WTl4cU5qUHI3dUZLNU1EZUFwcVMzeHM3?=
 =?utf-8?B?WVpPaU9yUHJDUHd2OVJFYkY0dE5vcG01M3JBdXdHcUZYNmt0cEVMeDg0by92?=
 =?utf-8?B?OEFubnRDSllqT3JIYXllTFlmdmxFY1ZXemE4RVh1cUR4OVJCKzIyMDJ5eHRU?=
 =?utf-8?B?Qkl0dG1ucjFnNnFhRGhFMTBRczRTMjRvRFhWUG5tcldVc0dzc0RIYWxWZzdv?=
 =?utf-8?B?TGg5TWZ4OUx0WGlxYkgwVWxsMUtYSS82OFBYdFZOY2psYXdjUVFheTVySXhM?=
 =?utf-8?B?TG83MjVOQzFPRnk2U2dML05zUmVEMHRVcURmaGt0dlRVTmszR2libUtwT21R?=
 =?utf-8?B?L2ppOVN6SFlTMmFremxvRTJ5OEdMSms2TXBkNVBnKzJ3ejVVYkZPT1dtcWxm?=
 =?utf-8?B?bklhdnBua1h2NVBxdlhncGVaN2FlS3JuUEkwUE9zOEpSM1RVWVlXU1hxTXJr?=
 =?utf-8?B?dWhCTnNzQ0JZSm1DSWlqMnVSZmpPaTNOTlNRVTFudDVLejJTUjZaejRWZm4r?=
 =?utf-8?B?M042RzhFUCtKVzdpYWhDcS9ZbUt1K1N2WEFQaWI2QUlQbWsxa0hEMmZ5WEla?=
 =?utf-8?B?Skx4NFpVaHpZeXpzRkQzK1paVUxhZVJCOE1kVmMrVittZUd0bEd2S3MraGJT?=
 =?utf-8?B?eUEyd2VzNzZjZG1GVUt2d21FSVM2VHNCRlRodG94Q25ScXF3am9ldTIzWm9S?=
 =?utf-8?B?aVpLSFROQjZ1VElabmhzTmVPNlRCR01PSFhVVEJiYk1CU1lXTEpwUDFoWW5o?=
 =?utf-8?B?UGo2SWZaWEFwT1pYRFRrRWxjRFBHaEdIcUZOQUt6aHZ0bjduSkVrWGZQeFBQ?=
 =?utf-8?Q?oeIGKz/YLXbIuKHMGQv1GV0PxLl6hvvXOuwpt8x?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7c9686-96b1-43e5-8da2-08d981f75655
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 20:42:35.8166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oaVzGaLncIi1udGLYff3TcM6LhFjeZGLoT0YfA0XRwyjXew1OhRgR07BtLJyl+GL9Bdgq4m4BIm2WbB93lnWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3927
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 3:24 PM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>> SENDUIPI is a special ring-3 instruction that makes a supervisor mode
>> memory access to the UPID and UITT memory. Currently, KPTI needs to be
>> off for User IPIs to work.  Processors that support user interrupts are
>> not affected by Meltdown so the auto mode of KPTI will default to off.
>>
>> Users who want to force enable KPTI will need to wait for a later
>> version of this patch series that is compatible with KPTI. We need to
>> allocate the UPID and UITT structures from a special memory region that
>> has supervisor access but it is mapped into userspace. The plan is to
>> implement a mechanism similar to LDT.
> Seriously?

Are questioning why we should add KPTI support if the hardware is not 
affected by Meltdown?

or

Why use an LDT like mechanism to do this?

I have listed this as one of the opens in the cover letter as well. I am 
not sure if users who force enable PTI would really care about User 
Interrupts.

Any input here would be helpful.

>
>> +	if (!cpu_feature_enabled(X86_FEATURE_UINTR))
>> +		goto disable_uintr;
>> +
>> +	/* checks the current processor's cpuid bits: */
>> +	if (!cpu_has(c, X86_FEATURE_UINTR))
>> +		goto disable_uintr;
>> +
>> +	/*
>> +	 * User Interrupts currently doesn't support PTI. For processors that
>> +	 * support User interrupts PTI in auto mode will default to off.  Need
>> +	 * this check only for users who have force enabled PTI.
>> +	 */
>> +	if (boot_cpu_has(X86_FEATURE_PTI)) {
>> +		pr_info_once("x86: User Interrupts (UINTR) not enabled. Please disable PTI using 'nopti' kernel parameter\n");
> That message does not make sense. The admin has explicitly added 'pti'
> to the kernel command line on a CPU which is not affected. So why would
> he now have to add 'nopti' ?

Yup. I'll fix this and other issues in this patch.

I thought the user should know why UINTR has been disabled. In 
hindsight, this would have been better covered in the sample Readme or 
something similar.


Thanks,

Sohil

