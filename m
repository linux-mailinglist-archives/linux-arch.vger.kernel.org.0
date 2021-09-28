Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED341B593
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbhI1SDm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 14:03:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:24146 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241839AbhI1SDm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 14:03:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="247287498"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="247287498"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 11:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="520543083"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 28 Sep 2021 11:02:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 11:02:01 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 11:02:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 11:02:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 11:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntlHsaujprZ//uCnK2C6fX8HEiSDNkVu5Ic29VQAcLQDuRlyntkop18pyDfCS7rGmDAWWZ1kfILh4sNQkSBl5dLSFD9dWHyFnXxmBKpfl33BUgtmmHMGV64kyk5jsIRztmmePDJCSbEEykZWamQUdRn94/BXp+rAwjVDVWwTYY+4LeWmX6S+5z6yqZgP0NVoKcAj/g+7zoV29LpIQ34TtoDCCuwH+hTl6vFoCukIlo8AIsch8lOisdcLb1VXhXrydlO0jxFBlDwS+MVQedejHvV5MpM223R4vCzoq7zxL16rdChZDMRdLC8qU4NXxAdBtP4MQnbYjsoG7YLBSRzvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OxyreQCmF9MmJp4bDMvFrettzEULf8WyRST8zIDDFw0=;
 b=YV7kIg2Dg9bU35FsYujE+bCNr2l7l43H6I9Zd7ZEHW1xQ/+YkWsnNDvXncH5q5V2FwU/uHosPKtTWDhadTb1FxsJ5e1FJGTExRDtaoKpty1rbgAYOAko3RKbyhGyb/0o5Ygn2g2IXSykClQu+Qyr3fQ9z9TXgu2rVdkY7BHlLMV9Cx5ZPKNrzIXOn7756kLRWoCBERNzFMlwQeYoSdK4NegqDg/46IVwn+zMKrc3r0ES2GVh1f5IC8QxUSn0VKFXkXumWuuzJiPn7Aml8xVsj3AFYSfp36wZ2t1bkcDPX+adz1RQSZFo1dJXj7IVo93NczMM6ebjfF0qUnwO+jvC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxyreQCmF9MmJp4bDMvFrettzEULf8WyRST8zIDDFw0=;
 b=lHT8aEP8i7yjlTJ8tcH/9uaFn228lwJLT7aTQ0XBkyh0LZWI0F7DDDHWx3JCYWTc34Rd9afq+cgocTK09diJyeGsMr2jN6sYZ4h9AWQO/4s+o3hGsiV5pdVc1dEcevHc2c0DA+nJkN6rYR+DPJuWK9Cr4DyAqzsaPTAtg9KD34Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY5PR11MB4038.namprd11.prod.outlook.com (2603:10b6:a03:18c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Tue, 28 Sep
 2021 18:01:56 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 18:01:56 +0000
Subject: Re: [RFC PATCH 10/13] x86/uintr: Introduce user IPI sender syscalls
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <20210913200132.3396598-11-sohil.mehta@intel.com>
 <YUxy6XqMB1+DYJtP@kroah.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <4704e81d-a3d2-aedf-1c79-e45cc86826a5@intel.com>
Date:   Tue, 28 Sep 2021 11:01:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YUxy6XqMB1+DYJtP@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:e0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend Transport; Tue, 28 Sep 2021 18:01:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e928a98-e1e7-4535-072d-08d982aa0f4c
X-MS-TrafficTypeDiagnostic: BY5PR11MB4038:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR11MB4038F7DA118C0E796E8F010AE5A89@BY5PR11MB4038.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LqtatOuuKevzbqSNrzaIkJO21Xe3SrpQrfw/oni5ZaJm+eNYM62oBohWV7hK+YHhqvq8Q19Jv2kKDGHuB4vUquMBrDW83RcZqkVckIpUZQgyQ7RLVyBqwP/xvbbkmiIunpErZkUhWwf8X8zY/Zz1MPbC8fBLIJ3nMsh6eFxSyvgwPOdr/ITsDeVlq46cTlRtPyePzwE9sU07r20G4MJfMyYNeXkLPj13w4cstuRxpMzxhFNb3caDez7t4nuLBWQ+Q1WqnAsly13aPvSSiKWtPZWdRnqRPMNrS1hRieg3k5S5f234Fy3WG/snz/TFVDH0dLiQ5qP1Ma7dnWPZvtWCj7t+JkO6o2lnqCfml3a5ZPVoLevoNobUGU4ZtgwwCZKoRL7IgiA9nZgpzWxgJGd9viZltrnQDDNtuvXVZ5IEuavYsjH+o8yr/zNwYY79mz+4v+UczRHWDRYokb0/hRQwJQHvgQiWCRILJkejK40UOafYFKRk24PuM+UYHXBCeNkJiMhQJYXv3CkZ84xorWRkdgDqYGu1AA19nk9I0rqV7knd0KCiZaTjy9EY9ezpsiy4AGk2wI01rQoz0MoETwxcQdv/TquwICR014RPtagH/uyLsZYyTx7Yb46QbI3+TeQV7dXUQov+hXPWI/gs3fVYaxTr5iVBER9dimy4ZTim77bnsM15Zh7/82/E5XFDbrdt9Xpp/tFPihATFDVYu5MyeHs0BFrWlErzbK46jFSL25g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(31686004)(66476007)(66556008)(956004)(16576012)(8676002)(83380400001)(4326008)(186003)(36756003)(38100700002)(54906003)(508600001)(26005)(66946007)(2616005)(6916009)(5660300002)(7416002)(6486002)(44832011)(53546011)(31696002)(86362001)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTlvckI3elltNVBxYTR5cUZsOVcyNUdiVXN6MkhOYWFGTXNrUjUwdk5sdGE3?=
 =?utf-8?B?Vi9GdVRHcEpzSG52S3MwQitRRUE1Vm5nckZKNHFybjBrQjh5NHRkdFVoUk5z?=
 =?utf-8?B?dFhGQkllQ25nOWFMd0NtR0w3QStJUmFJUW1ZWTJIbk9oUkRUdWh2QUYrODhU?=
 =?utf-8?B?NmZlMG1ZRDh1UC9EU3E4UjZ2RzFsWDA3K0JkeThZYXkreTEvQlA4Y09xK0ZF?=
 =?utf-8?B?Mjd4SWJrelhtK21rVUQvOTNBWm0xWXgzYlcveDNvcUVneXl5OGNaeHR5eUto?=
 =?utf-8?B?eGp3K1laWlJuMEUxUzFkdk1uaEg5bExQeDhMa3hLMkwwTURzdXZ1dDFQZGlC?=
 =?utf-8?B?cXo0eFh6bXBuM3ZoUUU2ZFZLR1BXNUpGQ21IazZGVWF5dEwzbVIxMVNINWZu?=
 =?utf-8?B?RnlaSVJ0RDkvSkx2Z05DeE50S1FaNEVxL081Qm8zSmJVVHBjK2NmMzFvdy9x?=
 =?utf-8?B?ejhVd0ZaWmlzZEc2V1dRZ2JYV0dweUVjTklJSkpVaUJSc2RBbFhiWHR4VGk3?=
 =?utf-8?B?RVh6WXRFNklPWEJld0hKRXZlSHUwckw5SDlSMzcyaVQ0b2diOGNEbVdlZ0s1?=
 =?utf-8?B?Nk9Od2pmY0dXcXlvYzY5azNmVG4xaUlobUFQbmhtTUh5cFlxUHNxV2dlWG8z?=
 =?utf-8?B?dnppNE5qYi94U3JNUklLYTRIM0hrdzYybm5NNWxDRE96Q1RGYU9HK0U5aUJy?=
 =?utf-8?B?eVBhVGRUMVVwM2J1MEFNY3BWYnRocTM1c0FyK0JFTUxPT0dBTE96YnNXN1Ny?=
 =?utf-8?B?bGhEcmdGdXdCZHdLSHRTeVBydDJ1SXZTbEdzVUk1cGxnWm9wbEQ2Y3JTL1Bv?=
 =?utf-8?B?R1VvQjVXMC9uRFcwb1gwVDJwV1VtcE5nZ2cxdG9UV1d6eCtEYTF2Q2F6TVhE?=
 =?utf-8?B?bldHRjdtemdTUXdxR1BNYWZ0dnlUZyttT2ttVTE4bXRFZC91QmdXcElhRjBK?=
 =?utf-8?B?MXBpZm5jZ0pFVTJ3dUFjSEhxYURCdVI2Rjkvb1FGcWEzOFdUWTVrQWlFRGlV?=
 =?utf-8?B?RncvMWg1b0JMNnR2ZEZnYTZNeFNSKzIwWUNnNVhJdE5DSlgrdm1BcEFLS2I5?=
 =?utf-8?B?Z2NrUTNEa0pJbWRuMjR4RmZhZXhHMkhkLzBYRG5SSEpFMStjbzFGNDVQRnNt?=
 =?utf-8?B?RVhWMERxUEVlODBDelc1cW4yK3EvSTBRblJuTkFCSFoxblRIQ21KOE5Ja3Nw?=
 =?utf-8?B?SGdvUEVEYUJzRHhmQysxQi9vdTBZNHptWU5JcjcvVXdoQ1JQdVZFYWw5bTdi?=
 =?utf-8?B?N1hYcFQ3eGdESkYyTm5hemdyK00wWkpMaG9yM0RDQ084OUZsVjMyZVRBRXly?=
 =?utf-8?B?QWdQZ0RrTytZVGd5bC9VYXdmdkQ1c2pKYVhrYkJZZWxnSHVSNHpwWmlyYU9k?=
 =?utf-8?B?WW0vQnBydmUyOEo3YWtxb0MrbzZHY0JHL1dJVTVGRHJiS0V3RUVDMUg5aUNn?=
 =?utf-8?B?RGFWZzBnOVl5MmE0WDFYSmkvL3VhUCtDYk4xNE1BUldIZGthVG1FVnQvMzRH?=
 =?utf-8?B?Z1V4UnRqcFcrbUh1U3gwZFJYdC9XQmQ4algyS2MyM3djV0lPZ3JOQnpManNT?=
 =?utf-8?B?R0ZpYjFYQzQ4V2IyUWZRQ3p1SURaQXlZNU8wYUY4ZXZ3TVdxWnhDenpPY20v?=
 =?utf-8?B?cTFSRlZGMk5IbVI2d1JyTUlWcUpyRFpXcjJyTU5hOWQxRU5ha0JXUlduankx?=
 =?utf-8?B?YVFjQ2V6YVl4ckxjbzMzVCtHTlRCT0VzZmJTU2hiTUF4dTVpR0JIUHhnc1hI?=
 =?utf-8?Q?PYkzypE7Jq6mog5OV3XWANrCzP/uyedFL0p8p7C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e928a98-e1e7-4535-072d-08d982aa0f4c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 18:01:56.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8zj74uYHwS+sk+6j7AAcGxq1CMXqfU+p26gW6usI33sM7CEspTT4tSjPi7LssH4oB8uikY6Luvj9rMHa4ohgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4038
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 5:28 AM, Greg KH wrote:
> On Mon, Sep 13, 2021 at 01:01:29PM -0700, Sohil Mehta wrote:
>> +/* User Interrupt Target Table Entry (UITTE) */
>> +struct uintr_uitt_entry {
>> +	u8	valid;			/* bit 0: valid, bit 1-7: reserved */
> Do you check that the other bits are set to 0?

I don't have a check but kzalloc() in alloc_uitt() should set it to 0.

>> +	u8	user_vec;
>> +	u8	reserved[6];
> What is this reserved for?

This is hardware defined structure as well. I should probably mention 
this it in the comment above.

>> +	u64	target_upid_addr;
> If this is a pointer, why not say it is a pointer?

I used a u64 to get the size and alignment of this structure as required 
by the hardware. I wasn't sure if using a struct upid * would complicate 
that.

Also this field is never used as a pointer by the kernel. It is only 
used to program an entry that is read by the hardware.

Is this reasonable or would you still prefer a pointer?


>> +} __packed __aligned(16);
>> +
>> +struct uintr_uitt_ctx {
>> +	struct uintr_uitt_entry *uitt;
>> +	/* Protect UITT */
>> +	spinlock_t uitt_lock;
>> +	refcount_t refs;
> Again, a kref please.

Will do.

Thanks,

Sohil

