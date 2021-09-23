Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8515416855
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 01:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243530AbhIWXKq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 19:10:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:32780 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236363AbhIWXKp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Sep 2021 19:10:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="204119655"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="204119655"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 16:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="514299544"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2021 16:09:13 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 16:09:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 16:09:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 16:09:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g97201vj0AF+T+fvbkjnvllTKmrtm5HgNi+04ynpwx2zmeoMVdfnUUoTiYHfAqpi79/cdHlD26UnkbY9aukoF9g/C55aaur33NLHuB4U5oseSEW+uYg/b7PPx4Dn9U817fjX8gXR6EBy78s7N/pNX7G6ofHaCFqW+gWrIH1CiLxbPXSLhggnGsGzm4Ho/JpQUn/Su/HFBUyRKE0MGrmWY/OjktfZt8umxWSEDZ5sXG42T7ZZUWecjiZhyHy9UrSob6ntijJUtlhVEgjFMNOpT6DQlC3iyqbo9qNeKvJUgYp6sIis7Ek0jrQR4tp5MbNn+G2NTeN4Z2ZMBfg6vw+QYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0Y8DtNvU8OFLp+xlgu1Fmb2XE+RA15MLc4udKWWfi80=;
 b=m+Lw1rGHlpISv5r/4uEZUjQUPX/kXC9vdmL/dkj28FT33yd10wbPDCwnqNC2VGUdMI9cMnnvH1vw0wQMvEFEWnIDpPweqWIxjtRdFTQmZI8UL2ISyVyJPIj/Z7wul6rojYxhaLHYvsydpRlArMSCAsTjWOpRygaGugh/H5vQvdBCJE39fKYWli3tTMyMRzvRDmzi5jXzJBAWPrjvW9lag9irGA/ZpiOz1gEfsrumnACHNNCZKzMem/i+MLy9plP9O1dj4oRwIeses5z0pc1cJNRs7jnptaHfPArLxP3gdd5iKM/ke4t6W0yx3ZvGFBYxbxBFCSfD0HTMtFeA9U8qAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Y8DtNvU8OFLp+xlgu1Fmb2XE+RA15MLc4udKWWfi80=;
 b=HtZeARZPo2bbA5xA1wry0t7GnWSe3QQuH6rPQgKUeMPVqdTP2f2miYhJWSfiK9SERrIzEyC2n3/3UJf92hkZf/3yhl6DPccCCWfgD+sU4Puy7y5LRWDACIDPfbOFHJOlECo2xIAEFvcGr6G0+CXEaZt04Ln1Z0jNNTNYohdB0YE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB3781.namprd11.prod.outlook.com (2603:10b6:a03:b1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Thu, 23 Sep
 2021 23:09:10 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c%7]) with mapi id 15.20.4523.018; Thu, 23 Sep 2021
 23:09:10 +0000
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Kammela, Gayatri" <gayatri.kammela@intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Witt, Randy E" <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Thomas, Ramesh" <ramesh.thomas@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <c08f38db-77da-c50e-23f7-b3a76688deeb@intel.com>
 <BYAPR11MB33203044CD5D7413846655F9E5DA9@BYAPR11MB3320.namprd11.prod.outlook.com>
 <YUxwuR4V+kwk1L34@kroah.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <e374787c-c376-be9a-b2e1-8739b36f69fc@intel.com>
Date:   Thu, 23 Sep 2021 16:09:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YUxwuR4V+kwk1L34@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::35) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 23:09:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 546c02ff-8031-47ed-592e-08d97ee72650
X-MS-TrafficTypeDiagnostic: BYAPR11MB3781:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB37810875A11325D646D7A544E5A39@BYAPR11MB3781.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgwTQdG+33HFZUs8WU9OMXCKaTehhDKHpQuqBDBQjIVhizXi4CM2i9TCXUjf2BAbYqFUvdWvF1ENWy+MIpAXgya7ccYge4t0iVopx1A8O8Lk9A8SSQPMpryG71KIfR5jRKK/NS1ExjN5yiEXE/7axd0I07H/Cqa0lHQ/wMvSAiNsJk8aTkJiIRIpo6PftOPYkcU4RZfQocYsUvpoxEbP6f5sNRX/Nj92n0TTFsRF2koPHQ4Qsw048KZh3+bKTaj8PMjWYK25eBJnmNC95BLkybTa6Cn4kwiyiGMhaY9yqAHUKz5smlYSzKRmlwKltS/JwIlAVyssTmMQa8T+KvLtaszjIG3ck1GaL4Q5+eL0NbgySwYJtwSWTA4CqDZtEkoFDmSPbb4MCyl+2lrtxV3ZmoPuMEzyZLXAjF2lCiSNA7hFjrGhl5yUj4g7+eHw1OCpx+8Eree1yjNjkNnz9TtI5eev58/QgibVmroJta5cfyQXzwFJDHB1Zae8Ii9UQ99kpTfGfu8zVLIN+yh7RzCW+u7b08/bSSgIa1G2FSeyw+ke9oBqbJGL97rvSkdxXacl/cVTGKtRB0lyNuMoSvUY4NfodeeScOpfkZnBVTCkxj9wTZpsmlGATFly4hboL/gZdoXaQRmOPS37hppjOnBD0Se8ebJDTFgfH5Wvae/Ot6Vt/gHXICWkABFBZR38dUhqL5vasPrQXDq69cy5aW5edJSGiVAUZx7Y3aFHt5C2FzQecvRDFCH9asxzP2V5iNhX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(38100700002)(54906003)(4326008)(6916009)(16576012)(316002)(8936002)(7416002)(2616005)(956004)(26005)(508600001)(44832011)(53546011)(83380400001)(5660300002)(31696002)(186003)(86362001)(6486002)(66946007)(2906002)(66556008)(36756003)(66476007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmtaVkhWK05NT1ZvWXF4MU9yMDZ0cjF2MGx6eHNIN1VvOUhLd2FEdk4veS9U?=
 =?utf-8?B?TURXTjZ6VGhDZ2t6NnRHdWNnRU1NZzVCZjRETWtjT2ZJNS9uV21JUVZ4SGdj?=
 =?utf-8?B?TGIyRjN2c3ZrQVl3YVpvSTZ2ZXRRaUd4Mk9GVWJnZDU2ZnZUREdpZnNBTU9Y?=
 =?utf-8?B?eTZsU3NmYnVIdERnOFpybGRFVW5pbXA5WG1ubWdnUng3S0tvVHZvdW55ZVpx?=
 =?utf-8?B?QjFtVXpVR0hQQ25mNGRueVlGR2xzYzRkenlPU1EzQUQ0Sy9hazdLWFBIUzh3?=
 =?utf-8?B?bDZCQ2ZZQnFyVEJJQ2duVlBkRHJEeWx4Z1ZoaStFRStCcXY3MWtTeTdTcEU3?=
 =?utf-8?B?Sy9KdjZEWUtubFRGdmR4NXdyZzZJTXF6RUZkQWJ0L3czVHVubEV5c25MT3RN?=
 =?utf-8?B?eVN1WkZTVm9JSWMwL2s0MlJWMFNFUURaeWdWZlh2MVZ0T3puZFNjYllBc3Fh?=
 =?utf-8?B?LzRnYThvSU45VndqU3NEK2dBZGVLYkdvUU1ubm9oTDBLVndmQWFuUEhhSitj?=
 =?utf-8?B?VFpla2tvblVSbUtqTnJyUkJHT2loYTV3ZFl3aVpMME13OWUxTWhFdTYxWnY4?=
 =?utf-8?B?cmV4eUxWaEN2bUsxMjd5WHhLV1pzUzlWMVk4TDRCYTVjMzBYR3NxckJOaVJY?=
 =?utf-8?B?NkE1akFsSEpXckJ3WTQ2SitscGY0R1JydWMwOGxrTlJaYTAycUpjVEw5cUs5?=
 =?utf-8?B?RkR0R3dwSit0ampwVUYwNnRJK0V3aW5nWDJuSGp1S2tYYnNhT0lrLzcwU0VH?=
 =?utf-8?B?b1lyazNRWXhTWHUvZCtRelM0UVNBRHF5YnlWWEdlSzhhZXdkSitmRWtzOFF0?=
 =?utf-8?B?Q0dmTnp3c1hzczVPNXMydVYxVW95NFdIampiYzRIOGNFZ3ZONW9NMXI3NitF?=
 =?utf-8?B?bUxVQWtKZlZaNXRlM1NGZk5GSy8wRnQ5S1AzYXBxNU0xeHMxbXlIREJsRHRi?=
 =?utf-8?B?TDlKUGRUaGhnZHRiWTg3eC9qRi9WK1VOdHdsTHE1a252aENsdnZONEoxT0I0?=
 =?utf-8?B?MTBMSGl4cXRzdHJpeUVpZmozZEc2VmM2WHBoclY1Lzg1d2ZrZG1qM1hveExQ?=
 =?utf-8?B?Y2tkYjU1aFZTMXkva2VTamxYUnAwOHUvbW5oOEVGUTRVZ1VGaHgzZEp6Vy9P?=
 =?utf-8?B?RXZFUVFkZ3Jpd251TStFVmM2VkcyNTNnT0dWQmVaVXF3RzVQVHMwbE8zQUJQ?=
 =?utf-8?B?U0xvblhvd0tabHVqZmhYZ0dnSzFGRDQxSUhSR1A3NEZ5bG1DYXlSM3Y3Wk93?=
 =?utf-8?B?c3JRZlJIUXFHVmg4RXQxRzdCRkZDS20zYk9sdkNZeDZKWTJIYlc3dlJwbXBa?=
 =?utf-8?B?R2FPWktkb3gxc3dLZTRUSFlVVVBCcGtBZTJvZGxVUGVSdEQrZ3JLcHpWM2Rj?=
 =?utf-8?B?ZXEwZm9sOTdESG5pZUpObnk0M1NMNTdvcDlKai9FT29pZ2dHREp4a1RtYzho?=
 =?utf-8?B?ZTE1WElEK0dBb2NuUzYvMXBzengrLzQ5NUJ1VFpiL0N6T1pHQWZneXhuY3hs?=
 =?utf-8?B?blp4dEFacWVsWnc5b0h3cStWOFlIZHFmY1AzSWhiajZQeXhVNHFPbFhqakhK?=
 =?utf-8?B?VnlkYnhEcC9NREFCOTNScXVYTWQyazJFWFpERUoyZUVjb1lneWFMTFljbUdT?=
 =?utf-8?B?VERTckkrTHBJY1VuVGlFUFl3ZkpCRmx1VjBWTWRoZDBnRUVlekZGZTlBZklw?=
 =?utf-8?B?ejZ5WnM5OHRmZ3VLeUVqMEJKaVJ6NDg4eittVytRazY5aEJCMjVyajllZFZY?=
 =?utf-8?Q?O9aKVC+tIRvVokmZb5Jq3qqHLVvnc07WIHzGO73?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 546c02ff-8031-47ed-592e-08d97ee72650
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 23:09:09.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7z8xJuUeFZpcrEROR0pLyf5apsNV5cKPF0B7W0ZkylH1kI8lRavuk4zhE3OdYCgzf71UzCsgrUs4WvU0CQUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3781
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 5:19 AM, Greg KH wrote:
> On Tue, Sep 14, 2021 at 07:03:36PM +0000, Mehta, Sohil wrote:
>
> Here is the updated table:
> +---------------------+-------------------------+
> | IPC type            |   Relative Latency      |
> |                     |(normalized to User IPI) |
> +---------------------+-------------------------+
> | User IPI            |                     1.0 |
> | User IPI (blocked)  |                     8.9 |
> | Signal              |                    14.8 |
> | Eventfd             |                     9.7 |
> | Pipe                |                    16.3 |
> | Domain              |                    17.3 |
> +---------------------+-------------------------+
> Relative is just that, "relative".  If the real values are extremely
> tiny, then relative is just "this goes a tiny tiny bit faster than what
> you have today in eventfd", right?
>
> So how about "absolute"?  What are we talking here?

Thanks Greg for reviewing the patches.

The reason I have not included absolute numbers is that on a 
pre-production platform it could be misleading. The data here is more of 
an approximation with the final performance expected to trend in this 
direction.

I have used the term "relative" only to signify that this is comparing 
User IPI with others.

Let's say, if eventfd took 9.7 usec on a system then User IPI (running) 
would take 1 usec. So it would still be a 9x improvement.

But, I agree with your point. This is only a micro-benchmark performance 
comparison. The overall gain in a real workload would depend on how it 
uses IPC.

+---------------------+------------------------------+
| IPC type            |       Example Latency        |
|                     |        (micro seconds)       |
+---------------------+------------------------------+
| User IPI (running)  |                     1.0 usec |
| User IPI (blocked)  |                     8.9 usec |
| Signal              |                    14.8 usec |
| Eventfd             |                     9.7 usec |
| Pipe                |                    16.3 usec |
| Domain              |                    17.3 usec |
+---------------------+------------------------------+


> And this is really only for the "one userspace task waking up another
> userspace task" policies.  What real workload can actually use this?

A User IPI sender could be registered to send IPIs to multiple targets. 
But, there is no broadcast mechanism, so it can only target one receiver 
everytime it executes the SENDUIPI instruction.

Thanks,

Sohil

> thanks,
>
> greg k-h


