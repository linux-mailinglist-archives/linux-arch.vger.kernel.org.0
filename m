Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5D41E020
	for <lists+linux-arch@lfdr.de>; Thu, 30 Sep 2021 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352564AbhI3R0P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 13:26:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:4769 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhI3R0P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 13:26:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="288900216"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="288900216"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 10:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="564306474"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 30 Sep 2021 10:24:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 30 Sep 2021 10:24:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 30 Sep 2021 10:24:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 30 Sep 2021 10:24:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 30 Sep 2021 10:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2sWFwXnUKh806gNHmOP9QafSisBvN49oFpXK0ixLp8uxxsY63TegnAnJLEovGWBoEAGORMHYsKNiLpV1jY3Z+RJYgSePv079AKMrOKyxkluHsR4pKTwHsRKYrcihQAHA4EzpdZgS/iGALSQMze2B+yIn3bxxjPsd6R6shoFLG/upEznlP1D5Aot2DAYkq2Aue+Uq83D0ZrdV4MWx1Gj3W34skWJFAoaU50cyQcO80Q7fzTHvWvDWuPokj8ZPs88nyKMDZGKa4wNQ2DiW19aeNgTnMIg15kx7maAJRTmbnWNhD2iFvLMP+uuYkCLUksw8RlHC3u0WN0WnSjaClvckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iIP5QJohS1xXw0W57v1HfkwY83OtUuPZEm30/bfMDgk=;
 b=QJCAyhhl15Kb3fY3UEmXwPH34Jr/j1E0vuy/HPxzDwJrQo9ih7dUGw1Z7xLp89LZAwKiGqA3q0I3mTOC1cMzSOY3c6BcvIJQYVje/nKeXy/CYA+19UoyCusjRdLsIWGi6ciuKiUCAAcRdpo3JTUSawMOSkS+b+h6aDKeFsyi6B7ZxMloa87P5IW3xvBoPYqkrKxTKkGMY73okhvssBefKqy17iguAHFWPnjvKY0sCeZcea9oQ4clnWcIuKkKabTJHviwPWYZy+SOVzsaaM11KpSv3fGscv+iL3rN/5AGXNu/GXsU71FREpkrNxifeEKEko9r8FbF9afo3zXfK/aiqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIP5QJohS1xXw0W57v1HfkwY83OtUuPZEm30/bfMDgk=;
 b=WVbdBwDsVdCakOTuJEc8oZLbDxNIeBayPElnlueLozYLBC7OWoKVivH/pf+hySfv5IGWxeRIMGZIzpY4gDL0jtSdAH8Gq6zQNyZ+jeF3jXhP7BcvLCUl2OWRwZXlP1VSBmVrwyBqFvrO/o5Hh3x6mA8bV4JJb4iNDQZ7u1atLbg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Thu, 30 Sep
 2021 17:24:27 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4566.016; Thu, 30 Sep 2021
 17:24:27 +0000
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Gayatri Kammela" <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        <linux-arch@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <456bf9cf-87b8-4c3d-ac0c-7e392bcf26de@www.fastmail.com>
 <YVXmGTo5Uzp44QQq@stefanha-x1.localdomain>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <778d40fe-ad8e-fd7c-4caa-499910bb0925@intel.com>
Date:   Thu, 30 Sep 2021 10:24:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YVXmGTo5Uzp44QQq@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:33a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Thu, 30 Sep 2021 17:24:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe542f7-17d9-462d-8b64-08d98437274d
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5022:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR11MB50223AB0ADD44CF53333EB65E5AA9@SJ0PR11MB5022.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFCPV5+y2kwypik/UHvzDPOn0bP/upl8Ft8wqm1rs/JESauc8V5L8T07uBcnprHcn8ZlK8QUkRlj57fsOL1NLMnOgVRsy8gVAGENSYA5lMJJu7OSSFcvr4nETb9elwTHFRi+VdzrE/WcBwj1GwkqlYZb30Sl/yC54Xhoz+nQ61+hRwvhJdDkCo6A2eHLSImbszBodUWs90Xv2VKmr5pzAw47UrYBBo6oXPWPzHCFqtMKdJxMnJnedMoWUYhhrQJG7FnBtRx3pHld4+HwIgrmNmmcw6qaFnfZK6WjeL+BU2X6Yw7HhDSRsvcDPQCyMMAWl1jaKQNTyZN+aFprEl8eOQGuxM9HaiggvbDGp+juf39c5f12omVjWzaa992aBiVwR0aP+6x6cLZ/t2R5+WaFqOEeKylQ3OJdivw0HlBhmdoSDe5MTvVh263U/H6Z8SA376ivGVzjNpFJymhPmT/dOrzXDRnUN+wUv8u0iTUB7AKN969pVDzsmDAMl9Nz/m9LulWNQ7Myp8dVzZrGLajnKiizhG3ASd8HKwzU/+9bgcmRfeAZtvt9r2rwk66WVavZDFic3DSLldg8xU0JDatTTafLBPhwy6rZ9dAnr/w6B1aU1uSE9ueXZ3PHd1pt0kj4FrXhh5JLu6reyRW4MqOpB5ja4nclGo8Rjz2CihLYMi7ZKUugu6PpZCuD2LDoOrEQNK43KVEA8XhxjvZaxQirgFS46yGh/ctmHjYeYSdYcgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(66476007)(83380400001)(2616005)(956004)(66556008)(316002)(16576012)(38100700002)(6486002)(110136005)(54906003)(7416002)(86362001)(4326008)(36756003)(31696002)(2906002)(8936002)(66946007)(508600001)(8676002)(26005)(5660300002)(44832011)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?05sjFsorYqWsOi6Uj/FHM1Vk54DbJ+W6Ikdws7T7TXFOUsnJHRLPD6oU?=
 =?Windows-1252?Q?oKPIXPdEdKyemuHvaTe9FgVcOmawnhm3OkauvjkgFP/s26CrI9ZMq7Hd?=
 =?Windows-1252?Q?uAtytEo/j4eU3GKSaGRjYa6HMInj3Wu7YO/2JHl/T9Nuv7ULA1vGKQmV?=
 =?Windows-1252?Q?Xejrlwmz/jyDri3ZLvrfPKabywBua66Esp2jHE2ooeJgNF3i2jR8puC7?=
 =?Windows-1252?Q?iFPjFRKoJlMLkturIrDQAXMOT8c/1wxZCpt5F5WQ/Szm/UNNrj7628tg?=
 =?Windows-1252?Q?/IltCQvDyTZIM7j+qrX0mFJGwEykcdhOdUmUHmO1jHkeUxnoK/oJvKny?=
 =?Windows-1252?Q?I14ii7BupU2WKjqLP4tyg2wBTNAIaSL94FGjiedjr0p2XNBszYC+Fe8M?=
 =?Windows-1252?Q?c/QaRcNh/jSdTuOok3BpYORdbiYpPMJr27qpdzDJbwO+Rz2e+NQOlPPI?=
 =?Windows-1252?Q?9QMoK/tnVTrHIpYJt1tA0Jzicjm86QrgHgEHmRiuesrvnek3t2FW2wwa?=
 =?Windows-1252?Q?HQKFwfo+QKRj5CsSz9SHso5fUhJAHA1ivoVaWl8k1+yeN3XhgUkA2i6O?=
 =?Windows-1252?Q?bapoDIEOL3UUkbWiUJ1tYAF17sKHaa5LrB1+lPYyXfPiu/PDeqnqd9tG?=
 =?Windows-1252?Q?FCSJAmklORddk9FkDB9W6R/Rt9k2Nc3FYFzEA90A9PH5B+D0JTxsBNJY?=
 =?Windows-1252?Q?odVU76WeqDoDd1SGUtetD9Kk5lZQ4hT8QYL5gT0bwtV46+/MhMosX2mf?=
 =?Windows-1252?Q?XduQZQasKixBwglMD085kWg/cE09SsoEeX9O+EizC9fcsPaLuB36sTWi?=
 =?Windows-1252?Q?oN018MHpFBaOU0Jp76fgjUQDVwmrj6nnWkBxy8/2CK8/HNc1RwkfQhA+?=
 =?Windows-1252?Q?6uYk4QAAeb/ijEwV7zGyz0/Eyt8F1KzR3xolzd4nqwLjOl4ubKytmajA?=
 =?Windows-1252?Q?VGb9DHxkhbjKdJGDNXrN7mRvHJldLk0eUdyyNJp7GxYYrWYi1Ke1YtjA?=
 =?Windows-1252?Q?C9rJAJankkdMr85OoMBqC0nFzJ+BkgYvGr9abQH5CHy/57amAIFjyIWY?=
 =?Windows-1252?Q?nQSzZNTF9Hy7MFAEzEyu9Hq07LeWUek9RdlDq/TycqIQzi3G3K8dMZSU?=
 =?Windows-1252?Q?GUR55pKmtAlQ0gISbu8KoNaJLyRj81SID8+OtE1J2KxqbjQlzDur44JH?=
 =?Windows-1252?Q?42HnwNwzO/OEH8v9p44y2WN1vRwnH6GHLMUrCI48XfbbhL+eeYZBz+sR?=
 =?Windows-1252?Q?EhOuQ3jP1+Kbqyr03VAbSKjOU1kDHuLghJLz4izogz0Ry5V5pPvbngEc?=
 =?Windows-1252?Q?DjWyPMFxw73NAs+K70STE5furKMr0Rpu6hSTwZbqax0Cay9nTfTAFmwg?=
 =?Windows-1252?Q?wSwTrqaxCuOK/vY8xNFFX7mZGJyFrJLwEYvm/lQDEMTaU+6XnMfgrkyT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe542f7-17d9-462d-8b64-08d98437274d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 17:24:27.0435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJdZjmwDlWDkSrUrBhDjnkwdSVIy6Qxvt4D/8mAbc0KscD3i0XFPMtb7zi1ZZbtw4CQOeK54Da/jVBjGTtsNqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 9/30/2021 9:30 AM, Stefan Hajnoczi wrote:
> On Tue, Sep 28, 2021 at 09:31:34PM -0700, Andy Lutomirski wrote:
>>
>> I spent some time reviewing the docs (ISE) and contemplating how this all fits together, and I have a high level question:
>>
>> Can someone give an example of a realistic workload that would benefit from SENDUIPI and precisely how it would use SENDUIPI?  Or an example of a realistic workload that would benefit from hypothetical device-initiated user interrupts and how it would use them?  I'm having trouble imagining something that wouldn't work as well or better by simply polling, at least on DMA-coherent architectures like x86.
> I was wondering the same thing. One thing came to mind:
>
> An application that wants to be *interrupted* from what it's doing
> rather than waiting until the next polling point. For example,
> applications that are CPU-intensive and have green threads. I can't name
> a real application like this though :P.

Thank you Stefan and Andy for giving this some thought.

We are consolidating the information internally on where and how exactly 
we expect to see benefits with real workloads for the various sources of 
User Interrupts. It will take a few days to get back on this one.


> (I can imagine some benefit to a hypothetical improved SENDUIPI with idential user semantics but that supported a proper interaction with the scheduler and blocking syscalls.  But that's not what's documented in the ISE...)

Andy, can you please provide some more context/details on this? Is this 
regarding the blocking syscalls discussion (in patch 11) or something else?


Thanks,
Sohil

