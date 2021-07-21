Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266AC3D1673
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhGURy3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 13:54:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:59763 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231303AbhGURy2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jul 2021 13:54:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="208377453"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="208377453"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 11:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="658375401"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 21 Jul 2021 11:35:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 21 Jul 2021 11:35:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 21 Jul 2021 11:35:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 21 Jul 2021 11:35:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk68Pe2oF8V1Zws5kE4KvMYM08/zep9X9+IaN6msAr+Y9sCrD/yQ4FbELTN8Br4lsHVPUjjwu9r44iild9c/wGu18A2xsIlfudJnPBiFXSNyMzQDvkynvHOGBXaF12SjB5NypckIFL+EmPg/bxWC7uAtTP2B/VVOz9XSITTCvv6gW6pC+xh6u9DaIu/rFQanqXgpVf1kqmPsNjavYYQ4ntHE5YZgSsa98vHPa0GLR2Asa5J6ks4mTby0eHHvY8pywEswmpmeTSXbMlyipUfegflomVaZNKMiqZNQs6F9bWsYrvHLLLC7ju4hML1Hx51LJFzh9MYt1dXL/fAsIKLfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC9OMY+KJNORPqDoREH2I122czD/pR8pIZzSxXnTKFI=;
 b=CHYrpA86kDlY64DSznM1rHyfmYHkiarcV4Z5EeOYMqH5h0elFVv9zEdwvsKaaBC2kl/7ih4qSs8F0MF7FcAr902Sh1qPQtCiiOsF820rdRH8xZJtlFWQrc7l7Qe8MB+nhhWV1padAoNOw75PhlleeLQGfkpkYABCvm/kYOZZ7ngyTaFZLHM88Noj1YHLU73fZWWainmJcA1br+M+snUoETwZfDOB4tO7fuUSqVCXOBXaVJepvLAt2n5lF3Inh4W+L7g96ZjXBmD+GmUZEhmQ84Jwqt4trX/AjMVkTNUyur3J8NW7vkp2I3bppgQoyIQW3DbRlz3+KSTARe64bEm9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC9OMY+KJNORPqDoREH2I122czD/pR8pIZzSxXnTKFI=;
 b=RSV/6JcG6oXqjsXIYXE8Ksle8cofL1fOq375X15SWjCKLva+Bt9ByWhgrIfkp1nekl3qVvQG571AHsv5gKpBVqREvX2hkEoNVN7JwfrCzziknZ5XyIgok+hzRJLgBV+l0YV0pvwIPXPJmL2bcTbhG8ug5XPHOHS3au4GBTOB+cQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.24; Wed, 21 Jul 2021 18:34:58 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197%4]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 18:34:58 +0000
Subject: Re: [PATCH v27 24/31] x86/cet/shstk: Handle thread shadow stack
To:     Florian Weimer <fweimer@redhat.com>,
        John Allen <john.allen@amd.com>
CC:     <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "Weijiang Yang" <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        "Haitao Huang" <haitao.huang@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
 <20210521221211.29077-25-yu-cheng.yu@intel.com>
 <YPhkIHJ0guc4UNoO@AUS-LX-JohALLEN.amd.com>
 <87h7gnldx4.fsf@oldenburg.str.redhat.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <ee98275e-cd1d-ad94-73cd-470bf89ca344@intel.com>
Date:   Wed, 21 Jul 2021 11:34:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <87h7gnldx4.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR12CA0039.namprd12.prod.outlook.com
 (2603:10b6:301:2::25) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MWHPR12CA0039.namprd12.prod.outlook.com (2603:10b6:301:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Wed, 21 Jul 2021 18:34:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcb914a7-b01e-4f2a-e072-08d94c763e35
X-MS-TrafficTypeDiagnostic: DM4PR11MB5293:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR11MB52935F037E53BBF1ABF114D5ABE39@DM4PR11MB5293.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+b2v3DEJ5NxTNVK/8i809C72uI1i+QA7akhZ+tb7HehAvwyhc7aNw+RneDcmVyjBzdULlnVVXLey7HaDYcHUahMCg0WPrsD7gT13hy09DbJ6o5GKsYSmJk6Kskdjkv8Imkr1o+ymwf4VHi6ZM5D+Buu9dNCn4M3bHdJwrvWUTugTiKiN8xnstVjRa+eKvPQdP3LOiaeFw6dUjP0nqENGV1p6jxTjRiDDYZKbuEazvxzN0F5a9us/SRUMpryiT9rfjsMW/VxM2F2izVJfHmYiU6C/OrXLwukej0g5cvVa40RVGrvFLCJe9ZbKBEwAUet95AJWtjIR+E62jbqCe4jc5v/chAZmX1ITks3f7uWzP5NGeLn6LVnG8G21N1I/ZjllKdRtZiBPbwVXJ98dzqKSzVf+TEEnRwP6ZKRqhl5gPmj5m4DEd386iF2Wf4Ml0PtAe2tdQpmRBZxju/sXBh7NNbTKNjNm+iu+75wMk8wNhHQo4Zo9k1Kk+IpsjmlzJWkR6VsvNNrUZr3MAgU9Jg8dFb2Z23HR6pxKVYVr4LncDKb0n2iWzoCHPkR/xX3HX6VLMN97EWoxvyyP3ev6A2jnY+v3D2BvHFh6eD/KbBb5tSxgTpdmWlLVaMJS51l6sMPTleC72yLPcUVvzul5IUF7fhcnnzWPXbYzb6xnbRz9AktPybO5CtdEAThEhno3NDTqvVM8cy3km/dhPFW+8RtbrMxI0wjZp2KEff9azYv9JxmtHIyL/9ESTEhe9TgcUwQR4LTu86U2KgpYIi57hXxSvZH+kThlcq2q70znnq5KAxDlocrMrmbGZjVOud3jfEf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(2616005)(956004)(8676002)(26005)(186003)(6486002)(8936002)(5660300002)(53546011)(83380400001)(316002)(31696002)(36756003)(66556008)(4326008)(86362001)(16576012)(478600001)(110136005)(54906003)(66946007)(66476007)(7416002)(2906002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRveVdFNUNNaTVxTmkzUmR4cGpVK0kzK3R0NmswaytPeFp6NFpjMHQvbEVv?=
 =?utf-8?B?NnJMdWpHK1pnd0FXQzlQampXUE5PT1dFQ094TUI5d2tKV1k5eTRpVWsvakR5?=
 =?utf-8?B?YUNWeHpIdytPQjZoZ0Y0ZEhkU1M1TzQrS2RQUE51VWZCVWRkTTN2UTBYdmtl?=
 =?utf-8?B?dFpNa1h1YlRQZWZHSTJUbjViSXdkdnlnZll4UXRTaTE5VGlMd0FjaEpmWUZp?=
 =?utf-8?B?YXdOMTdGOUtyZFNuWXpFbHVxeUlIMUF3T1hKR0IwYkFaVWV0SUVtdzBjb1h4?=
 =?utf-8?B?UzNoQVYwL2lBMUtwMVZ2azA4cU1POXJyM3F5RDR4RUNMRWVRY0JMa3hUM1Js?=
 =?utf-8?B?V092c0M2Zkc0NTdlZHFkVURWMkl4a2kyUkhNcjZadFIvYmlpeTN1eGZQM2Ry?=
 =?utf-8?B?VGpOUFNreC9lYi9mZ1ExUEc2eHc3QkRXMWZJQWdzNkNadWFoc1d4b0UyVXkv?=
 =?utf-8?B?WXdONENlYkJoSEVoM0JkWE5BcXVKWGNNUnV6aEVnblR5d1BiVUtEaVpDdkYr?=
 =?utf-8?B?aUt2am1lQ21ndkFJaG1pMmJENlhoeUludmJBSEh2bGNURmNhT3JzaU5NN2Zn?=
 =?utf-8?B?cWh5YmpqdkZlY2JqQXRialVUMUlFU0dBcjRxUEkwS1hCSG83NThNTmo5RGxk?=
 =?utf-8?B?R0FucXVnSXpXdkVvamMxRDA4T0FkdEFsd3M3WjVpdWxkRzlQU3JvWkFlTVA1?=
 =?utf-8?B?anpoNHBiMnlaSkxtakNwbmRiemFZbldNMjAyWEsrQm5SRU82N3F2NkZIREIy?=
 =?utf-8?B?MlBWcVZ4RkR2bnFqTkhwU1BSazcwcUsrZWphdDM0ckJUcG1DKzExRUdXSXh5?=
 =?utf-8?B?bHh6ZGt5R2dadUFUQUpSR1V3VDBad2UxRGdsZ09ZNzRpQXVURTIyZ0MrWUNC?=
 =?utf-8?B?NitWSXJoTUlsWVFZZUVHYlI1Uk5iTVpUcFdja3ROZDdETXRjOWpVZTN6dHF3?=
 =?utf-8?B?LzBSVzIwemFxcDFFWFZ5VkJpQmlmczlDVGdnY0NZa1VPR01sOEJPQmlEbHZj?=
 =?utf-8?B?RTU3TmxSbXRYeVV1OU4xbFB0dlZSSC8zQWsvQWgvaXhFV1BYcmdZbXZuS1JX?=
 =?utf-8?B?ZlVUMnMyYWlBcDllUUtweWs4RXZLZzF5aG9GRno3dFVzQWkxMWU2bWpBRXNq?=
 =?utf-8?B?SmZsV1JiVExnL0lnRGp2d2dpZnBvamoydXlseXBQVmtGbG9kb2dtWEREN2Y0?=
 =?utf-8?B?Q0ZLL0tvclZ1aVRWdUlibjd4bzg1M0c1VUF2T0F6elFiN1BxV1F6ai9NNVc0?=
 =?utf-8?B?OGhxZXJhYXNMZm9Xa3d2WEc2aUQwYmJxTSttQVBDTGZuUmsyZUlLLzdURHRy?=
 =?utf-8?B?Wkxob2tiU1dDaHR2QkpNRnFrY3dhakp4MXZaT0xacm92K2x0TzMzaUN2MEhm?=
 =?utf-8?B?RDZDUTA3STB1NFBoWUsyTjN2ZUVBMmFObnNBdXNoZFEvU0s1SktUcHVJTVNJ?=
 =?utf-8?B?R21ERlUyS1lDSWxsRHRQMTMzMDN0RUl0QUQ5UHJBMUgvWjd1bm5PVjlhZWYx?=
 =?utf-8?B?M2JZUTc1WmRIQmJuV3VtTC9TZlBBcDNtUy9HUVpIUThQMnVlRUNoTk5kdUJU?=
 =?utf-8?B?OUR5QWd5Mm5SRkNxWHJET3BsMmVEYkxZUE5LZmUrNXZCb3N6QkhxSFNPNnpj?=
 =?utf-8?B?eDF0UHpmZ2tyaTl2RXVVVEYwRDRPNlJNZXlpV2p6cjlWZHhjZVRmVUoxakdE?=
 =?utf-8?B?eHZpb1RCRGZ5NjVnSnE4V3JTOHV1OFZIdkx3K1Jpc3RtNzFINERKT0thS2xD?=
 =?utf-8?Q?y8GKCMaXVPX+VezEfT1cEZORirpJBOgVMIXTeu7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb914a7-b01e-4f2a-e072-08d94c763e35
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 18:34:58.5864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ctesnf7g9734UR+HhW3yKAAYQ3SB2Kz7QbaxW/vhfJLcP8hryOcoNgIoBUdwNn3cwuaEOOlje6uYdCk7sPMPyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/21/2021 11:28 AM, Florian Weimer wrote:
> * John Allen:
> 
>> At the very least, it would seem that on some systems, it isn't valid to
>> rely on the stack_size passed from clone3, though I'm unsure what the
>> correct behavior should be here. If the passed stack_size == 0 and sp ==
>> 0, is this a case where we want to alloc a shadow stack for this thread
>> with some capped size? Alternatively, is this a case that isn't valid to
>> alloc a shadow stack and we should simply return 0 instead of -EINVAL?
>>
>> I'm running Fedora 34 which satisfies the required versions of gcc,
>> binutils, and glibc.
> 
> Fedora 34 doesn't use clone3 yet.  You can upgrade to a rawhide build,
> e.g. glibc-2.33.9000-46.fc35:
> 
>    <https://koji.fedoraproject.org/koji/buildinfo?buildID=1782678>
> 
> It's currently not in main rawhide because the Firefox sandbox breaks
> clone3.  The “fix” is that clone3 will fail with ENOSYS under the
> sandbox.
> 
> I expect that container runtimes turn clone3 into clone in the same way
> (via ENOSYS), at least for the medium term.  So it would make sense to
> allocate some sort of shadow stack for clone as well, if that's possible
> to implement in some way.
> 
> Thanks,
> Florian
> 

Thanks Florian!  And because of that reason, we will put back clone2 
support in my next v28 patches.

Yu-cheng
