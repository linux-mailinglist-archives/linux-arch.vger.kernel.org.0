Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079F83F8D17
	for <lists+linux-arch@lfdr.de>; Thu, 26 Aug 2021 19:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243127AbhHZReH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Aug 2021 13:34:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:13739 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243082AbhHZReG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Aug 2021 13:34:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="240004498"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="240004498"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 10:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="537534495"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2021 10:33:17 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 26 Aug 2021 10:33:16 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 26 Aug 2021 10:33:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Thu, 26 Aug 2021 10:33:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 26 Aug 2021 10:33:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAqw5dHZA3wLz0h1h+XNXpewIo35jG+yKUUlLc0zyCCWJ6zTkHq5ubi7vm5gIJtTwAzWjjCN/HUfvUXXQwy3O/UqD7yYZIQGJiViWuXGRz4V+WcGL+YilU6uvLmTXQwxOtSz1UU1xdWz6fhS6OjtjoP7hhTfKVQdmpcw+BPRFIFUG868IkPXsJ5t5QpyXqodqieHBlOM9OJn4pLJx6x7KnNLf6zied62Qx24r2u6ZLXnM5UxXIJtmYEC+SfQljFaWomlc4tmwNS5gPld35J7FN6w+t1Zk38ROxx3IWHxnxt8US87sbQbIWVE5YVE2iCPBrTW8gfqmvAg8ZluMLbJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y7AFltwjNLdTBKi8FyhGktj6hCoxfH2H+LT5zye3rw=;
 b=ibA0Fh2VVHbzKQjVNcbC0rt6eJxL/n08v0GAv9Y34NN3T0c9KoHysCFj/O97fxPAy22DQyXKvTuK+NIcs2TlAGYqLWTpH52n6S49FPdhehsgVpm5HeiCD9GPULBzdNVfi4hOUfwoPWxXQH6ChgZFaun9b3uyOt3rJmnB1Dn8tNlOvXbSK+2Et+/90LFB8K4VClnVWr2ojfnUzExDlcfsmO+LQ51bM9r7N8Kdd0ST+Xnapa5oZkU5sra9EEXGsp45+L7blqP5Hq6z7gEEyNfkxr4s4U73CDyy1zmXLDt5Cy7n6cYiOxzAziNsfSAJl/HvS5wCk9oxtFNGBajMuEaV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y7AFltwjNLdTBKi8FyhGktj6hCoxfH2H+LT5zye3rw=;
 b=TpyQTii9G397DQ8rhXUsDJv3GFJ8bsCQCrvZvBFjtoP9uy24auFOFdR8LbUeNKtLi/Sqf2djTSYZbd50IXx44406lLamS6e9hLHVSemh76Uwc4EeAizkSWBAKq/soSqQnwzu6LbpZBV35giHmoI5VlO51HOt3xxIOhB1iEVeWMQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB4363.namprd11.prod.outlook.com (2603:10b6:5:14f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Thu, 26 Aug 2021 17:33:10 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%4]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 17:33:10 +0000
Subject: Re: [PATCH v29 25/32] x86/cet/shstk: Handle thread shadow stack
To:     Borislav Petkov <bp@alien8.de>, "H.J. Lu" <hjl.tools@gmail.com>
CC:     the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Jann Horn" <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
 <20210820181201.31490-26-yu-cheng.yu@intel.com> <YSfGUlGJdV/5EcBs@zn.tnic>
 <CAMe9rOoo5wC7AWbo3WO_GWvT5CXV3r3ysZ2qB8ZPi=giRBDetg@mail.gmail.com>
 <YSfPQYjNxFPALmgC@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <47a73ab7-20c9-f7bb-14b0-ba81e33fa1ad@intel.com>
Date:   Thu, 26 Aug 2021 10:33:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
In-Reply-To: <YSfPQYjNxFPALmgC@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR10CA0070.namprd10.prod.outlook.com
 (2603:10b6:300:2c::32) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MWHPR10CA0070.namprd10.prod.outlook.com (2603:10b6:300:2c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 17:33:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64acde2b-954e-4b12-a7d1-08d968b792ca
X-MS-TrafficTypeDiagnostic: DM6PR11MB4363:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB43631B6878F5BF308C90F623ABC79@DM6PR11MB4363.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KK6gimRlT31AKCjymw+QQyuNiiXNru26zrUsz4DCH0/wbN6EnoWRVYKNnW9JE77cpkfm6Sr3bvpf4L9ooZEiWJP4BxvkSo8TO8TcIG91BVRPTwaSMtw2wHQL6paeooHlYObv47m6N+cWaq31KzoYlq+fLk/vJCz4SPpEHizMdsqN6PmNEn3U44yx1RnYwOiyE6+NbaW4aFLJe3ZyPHTNmITJPlIGVEtWgFf6N4JJEhTgXv1w9DvHq+/ytwVyS7hwO67nefIn7JMLiH5F9T4EpISpHfjH+yNez3MzAXVdC2Xzd+lp+P8Pk5eWIhDW/TJVW6wzHmPVTCSt0dGThoXVlK+acpui53AMPKYW70gp1C4D5mkGP1EJVhc/JQ9VwWycMgNNdfDNkcMbwvG9U21Tqn74rT/QUPl1XVszrzeSDqurVsTZvEqKlnCvAkDWDH7Lso3SQhLJjg8kF5dJBiAiP4mz1Ic1pIpVbTbNrpE//qHaEDdpAp+rN5MEPKgo2p+lRrwrE49dSEL9/IdIEctWrjVRXGM59RIC/xGJ6tNqXOCHR4jFNind/oZKXT3re4Vma1OOS52MlmRiCnC+hlwOjN/S4kRizsyOFh7YqOcnvWgRwOZhuOc7NwCrLXJAjctqSRLcS9YC4SNzMCAb8bDQrmNBlMDWlRBFmZyy60kctFnu5bqkn5dxn1udY5PWVxVoLtgKVBO2rxhTzHcJjTbmDWRthsf4+nsj+8ymJzS3c0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(316002)(31686004)(6486002)(6666004)(83380400001)(53546011)(66476007)(2906002)(2616005)(4326008)(8676002)(66556008)(956004)(110136005)(66946007)(54906003)(36756003)(16576012)(86362001)(478600001)(4744005)(186003)(8936002)(31696002)(26005)(5660300002)(7416002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJ6SFl6TkdrTVUrNWZSdGRCclVlaDdKV1RMaklYeVNWQ2hoNkhaekhXdVMr?=
 =?utf-8?B?TzNORFlVaUZZK0V5ckhsYlZ0NkI5b0ZuUGR4SDhGZ2RjaVE0Z2krdEJjSm90?=
 =?utf-8?B?ZllCL3FyanRWYzJ2TTcxQ3VoemRTc2FNYTAzVkM5V2NWNzFQZWUzZmZGZlpq?=
 =?utf-8?B?UHJWNTNXRzRTN2I5RXpTWWJNM0VJdVRKZzY5V2tJSWdQWmdHK2VCUjVORlNW?=
 =?utf-8?B?NFpuclh1bTVQc3QyMFFJQzJnWTZIeGFrVlYzRTM2MlBLcVIxak9OTW1SdUk3?=
 =?utf-8?B?aG1oMmY0MjBtYjZIUDJUNnVGWE5ZK3d0RVk5SndmWXpMb2VTeVRJeVR2VjU4?=
 =?utf-8?B?NDlqdFhpYlI4VWo0R2lIYldYWWVxbXhxNVpnTE9WdGpUOTUwYTlTbC9KekNt?=
 =?utf-8?B?d1NueTlGbUIzOW5zcHBockFGcVRGNlRmZnJyRVRuQm82WVQ0ZXpnZVhESkJN?=
 =?utf-8?B?bDBhOXN5a2o3OWh0VGdqZXVYTDRDdC9ZcjBqNE1jTlJuMUVYZWd4OXMzYzdq?=
 =?utf-8?B?d0U1eHNYSDMrSThsYlN3SXV2eXdheVQ4blNBV29qbUUrNll5dndoem04cU1Q?=
 =?utf-8?B?Y0VHTDc1YVMzM1VjTUN3YWY3U1NCNjdXUWt6OXRtQURtRjNRaHBGVVppaG4z?=
 =?utf-8?B?blcyMTNLdHVkQkxEWXBYR3lNYWFwdjNrVXNWc2U0blF0UmhCVWNmWUlhc2l6?=
 =?utf-8?B?aUpPTExBblZESWlDTElRWmZPNThkenh1c2l0QXBiSEJ0OVlycXN0dEFYd1Zp?=
 =?utf-8?B?bkt5VmgwVCtNR3laT0RxdlMxWjBYSDlaY0ROY1Nob1NnY1V3d2V3OGZ2aER5?=
 =?utf-8?B?RHc0UnROaVJPNjByVHJ4S3JNa1NnclpjQ1BkVmUyVURzK2tIMW9BSmpQNk1w?=
 =?utf-8?B?a3lIZG5zVUNmVGhlSzlLTWJ0cHBRemtyRjBVa3BiZllQd3NqdndLMmkzTXJs?=
 =?utf-8?B?L1NBM2h3dm8yVHErbGdBQ0g5QzFOR0tkcDhpUm9rc0NORXQ2NGllZUhDV21R?=
 =?utf-8?B?ZXNKUysrZWQya1U1clluWnhURkEzeWFWamFHbXhnL292RmI2dkUreGEyaGhk?=
 =?utf-8?B?MDYxNm5BU1BPenRDcm9EbmRXVlF2UHBRUW9KQ01DM0pSVk9WYVRMdGhVdmM5?=
 =?utf-8?B?TWpPUUtPL2RNTE1ETCt2RkswYXBCNVJyblZNa01CVENhUWljRjZEeHpMeVJP?=
 =?utf-8?B?UlFjdnlVbm1jNDcrSjlFTW1rNlVLemxUd2NLSU1BVE5kcEZ2Ui9QRkh6M0Iy?=
 =?utf-8?B?MUtQK2dEa2UyZ1AzKzZiY0RSZWh3VWJPVmRrZXh6ekp5d2tKMWl6Lyt3MXpw?=
 =?utf-8?B?dVR1NUNtQ1NkalVBMnZhbkl1NkV5OW9WNWlCSnNUQ3dFRTJuV211NHk0enUw?=
 =?utf-8?B?Z0kzZXRRZSthMk5pWGl3UGZjZ0VWWkwwb0FNa2RoUVJ0aUFIL3BIYkQvYUJP?=
 =?utf-8?B?aUZrc3VteGd5MXdxZ3RTSU50VERxUFZ0R0I2UXhPc0hVT0dnNEY0RlQvbXlz?=
 =?utf-8?B?MGlwME1xMHBtUVZTVkpiaXo5ejFtdXZ3SWIzS0dFR2FMWlpUSzNqWE1WMC9z?=
 =?utf-8?B?dTVhVHpTak1iVXZWYTZzNXBLRjhNMWRsZzRGSk8yYms4ejRFWTFhUm9oL0N0?=
 =?utf-8?B?eVhpRWFKNElmTDgvdjI4Qmk0YUtHUVIrVjdpc2x1MkNCWWNVZjN0a1JsL1BK?=
 =?utf-8?B?WlNOMlJYS0I5UEwvNCsrL2QwTnYvMGE3YWZqbTh2R3ZjS0l0R05OdUk2aWZQ?=
 =?utf-8?Q?+zGTQKOGOLgPU3TCGBqeJjI/mhIAvYa2DdKxvsE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64acde2b-954e-4b12-a7d1-08d968b792ca
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 17:33:10.2406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQivYIYU7s5Wg+yMVa9EKOvznXFJNxgOubXuVU0v70H01Ul8dcRLE3/sxcC16qJJ4xzeSxpflzPs9IgE+M3UQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4363
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/26/2021 10:28 AM, Borislav Petkov wrote:
> On Thu, Aug 26, 2021 at 10:22:29AM -0700, H.J. Lu wrote:
>>>> +     /*
>>>> +      * Earlier clone() does not pass stack_size.  Use RLIMIT_STACK and
>>>
>>> What is "earlier clone()"?
>>
>> clone() doesn't have stack size info which was added to clone3().
> 
> /me goes and reads the manpage...
> 
>     clone3()
>         The  clone3()  system call provides a superset of the functionality of the older
>         clone() interface.  It also provides a number of  API  improvements,  including:
>         space  for additional flags bits; cleaner separation in the use of various argu‐
>         ments; and the ability to specify the size of the child's stack area.
> 
> Aha, Yu-cheng, pls use those words to make your comment understandable.
> 
> Thx.
> 

Sure!

Yu-cheng
