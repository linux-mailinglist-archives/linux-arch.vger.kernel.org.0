Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68BF4168DA
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 02:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbhIXASu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 20:18:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:61156 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232143AbhIXASu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Sep 2021 20:18:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="220772226"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="220772226"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 17:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; 
   d="scan'208";a="704955663"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2021 17:17:17 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 17:17:17 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 23 Sep 2021 17:17:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 23 Sep 2021 17:17:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 23 Sep 2021 17:17:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XikVDcXbVWx1XSAzIMqJlkqRE3j9zrV7FmdID3MQoHeGciQNyg6bNTzWM9sblqPaYXCKWJIZrCfHECr4Bd/N4+nbJMDZd6mac2qBwEn/HFp3OM2hB0aXwJZkC9bqligabHZlru2/ntz9ejQiNTcJfds/W/EK3LAkpYHQbX8q+T2cppDknU0ghkQRPqbDiUqkuTcYcuseJAVWOIwNr/Jq0xyziydEcTyqo5uEsYTPNHjTbOjfiVjx5BmgFEfOlukVUYxbgp6T7zMWGFHtolljzh/u7Z3cTw5LowAYq6QdGYVF7QqW+JKiUAjaGlYWYp6/iIfpIHI9LuLXt6UDZOeK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3avj7XDBbg5PtV6M/TeE/+a1Wd7rl2KbNT+mnpsBqlI=;
 b=DpYVnE0EB7P59y9NIHZiiD3iqHAa/RMMYoJl2ChletQVsdFr8hqZSPp7EG/ecdk+/hBMZvFwhyvh/GAqwJgmynu6UbZSv6Q+qrWulDQOxzsaI3RRyx4ZmKTWlt4m/sv0QDkOrG4MNQFMK07+evNCs4foAWCbxJALRKbRuFEE8FqN6RRpjtID8uOuWU+Mt7rd7/FxHaXBgrd2Iw+OMXWr+lvfBGNGWD/BTtBAtQwnfTmRVbg6uiCDEdIYXXbwr+k3huuA3puQInelHR8OcARGGzdzk9OP7heNLCiypCncUtnwW3QaSWeZG5kwDf+LKuGPyJgc7oIBP+pXqtfhG0Dssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3avj7XDBbg5PtV6M/TeE/+a1Wd7rl2KbNT+mnpsBqlI=;
 b=a6vI3yXJy3LUyrKnonRuQN1ISeBPQzcQy8bzxMCsF8n3a2VYEVe2ghJomgjoulc7M9/CrOACUmVyfNsckRpvt1BrszSqJf6eF+EEQMmDDIUbQbxgzHerB4FlvmiuZE+zODN3PpHns/mdosLu7XOMRdIzmYxhu+zabNNITwaU/e0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 00:17:14 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c%7]) with mapi id 15.20.4523.018; Fri, 24 Sep 2021
 00:17:14 +0000
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
Message-ID: <783bb314-ecf4-2a46-6baf-72758586123e@intel.com>
Date:   Thu, 23 Sep 2021 17:17:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YUxwuR4V+kwk1L34@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Fri, 24 Sep 2021 00:17:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f18fb8f-a9f2-4929-bf88-08d97ef0a8ee
X-MS-TrafficTypeDiagnostic: BY5PR11MB4419:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR11MB4419CB97D4F8BC7DC0954779E5A49@BY5PR11MB4419.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YF7aJI1zqlCeXn7SY6oDhv1lJl8g5TeK6/1Czb4wIWctM6ZFuRUkBXd+cCJsOhWYPrEJEiRvTbFNsg2QtzWU7aT5+pjq0bN/kc9atCQhHDHuQme5URVjbvApZpphpEVX+ZB+qkoDCRetKBLuT9IF3POVHOhHiIucQzqgwnbpnIvaslboKQCMzFagnVNvy6DysZye+vS9WwF2D4VW/tovEOSQramM4LOElZpmnBPOxkd26TCcF8eKNj7pjmoeFyh7FHSvGkxa/ny7gkS+MYRMxzsEWewkmNYKfXY5UcVC0obfWySpZYLILwKAWZC/CtrAGUftTcOpuLYDxk2gv8Ks/ZtNxXfeIzAcgGoimE9Xw7/zlM9h5JyfQ/Ef2vfu6nYuJ2ehCS1kK3syjtk9ettXJjIrC6luJd88PEF6SbvJoEBjjGfdo7hJ/HhuQ6VYpuzsPxGQAGUT2W9sGM8pge3oNlBJPfSWsXYPuiX4qoF44TlTQaQTUVOQC7oL3GFRLi94D/GcfnzQPLHh4x9xGEYqzcn6pGD4XNhr1P1CQKgWyek9NWtP66aeJOz4vZ8E3j7IYRMfHOLxualmv/4b08mvIpQehtKFajXp9OtDIfPLRMSY2ZmRoxtCegddcXFF5lLrX9FqFELmUYnOFFM2mngYadN6omNFZ+pj9LX4F5fXdItE3l7zdZOEOovi4C7lI8HBm5We3kDT7wh9G6HYICgeOmEgYohgFSNMG6yl+34vpL32Xo62Tqpc5GBqGEFhDW6A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(66556008)(5660300002)(2906002)(6486002)(4326008)(26005)(44832011)(2616005)(16576012)(508600001)(86362001)(83380400001)(6916009)(8676002)(956004)(7416002)(316002)(4744005)(186003)(31686004)(36756003)(54906003)(31696002)(8936002)(38100700002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2VnRzJ0L2wvOGVXUXZtREZ4czVaYlNWNVJ0Q09LZWcydk5nbWYxUXl5QmZR?=
 =?utf-8?B?dXpySDNFZy9qcWxXamhoU0ZaQ0VnVk5Ga1lnRFk1WlpndS9LQnFUT2M1MU42?=
 =?utf-8?B?bzNGRDA0aW9lanZ5aFU4d29rOVo1SFJaRWVLYnZkVEZnR2FKS3ZyUG5mTVMy?=
 =?utf-8?B?bGZRMWtTRUE3V2hXWVpNaE5NMUk2MlNvR0s5TUwwOHdyRE9sYUpZZU5WTHN0?=
 =?utf-8?B?TUJxdGYzN0FIUzhqMkhrZTQ0ZE43b1NQeXJRd0gwcmNpT25Eb0xrWW9WZ3I0?=
 =?utf-8?B?d1FMSmwxY1ZlQ3d0ZW5SWEN5eFQxb0F6cURmT3Y4dFI0TnpTeU8xVkZ2dTJq?=
 =?utf-8?B?OHhoVDg5U3FqR2FkbU1WUWFOMXpsMkg3djV2WFNmcEl6UWh5SVM1Ukh2Zi80?=
 =?utf-8?B?SnNIL251Qk41bm5Ncm90WHByeE9aTHpSQnB6RHVwL2xYbUdSQkRVSElBUkxq?=
 =?utf-8?B?b0RNZzkyNnVUdFpTMjJRTTlaUGkxRXU2dVM4MVN4ZEloam5aeHRybkdYb0NP?=
 =?utf-8?B?NENtUjlobmdYZjZpK0VJL1hQOXhBaEFXUFZvcUJNT0ViT1cwdzRVMlZEV2dk?=
 =?utf-8?B?bjRXOXAwejZCbXd3ME8wSWdUMTE1TFdRdzhVOXl4eDBYTnhkWXpMWjBtVWM4?=
 =?utf-8?B?MHUvSGNvTkFSd25OK3QzQ2liQzE0SjJOcDdtZTJvTGxra3hid2pwVm4xRWJI?=
 =?utf-8?B?cW56Z1AwNS91TGVoM0xhUVpiVW9TcnRPYmEyZVR3c3NDa1hNQmQyaGYxSEdX?=
 =?utf-8?B?U2tJSkdWd1ZSSzFjVGNFaEFCQmxHczdubXlJWGtkUlNSYm9MdUhPcm1TTk5v?=
 =?utf-8?B?K2tING5yWm5DQzFSdDE3UkIzMXVhbDJYQXhzMDdxVm9GejRYY1MxSytPTHUz?=
 =?utf-8?B?a1pHd1hqbHZVK2ZLR055OTN0dTZMSzc5MFNtV2dlUjBsZ0MydVYvcTlkQ1or?=
 =?utf-8?B?bnhMK1FUalJPVXY3Sy9SVDJSdWRsaG95amk2Njc4VUNmWEtjZU5JSUdSanU2?=
 =?utf-8?B?dzFIZFRyMnlaQkxqZTdtb2IzY2NReGlncVdxeHNvZ1VWTXdodnNvd0N5WnhL?=
 =?utf-8?B?S25LNUU1dWlLVUxLaWh4UnJNbk8zU3RkM1JEemEzYjNiK3J3UFI3Y05SK2Z0?=
 =?utf-8?B?Z2F3NG1ySlV0OUpWcXNuSHVRREdKUmU2STBUUHZ3SEhSRm1qZytHQ2JyUm15?=
 =?utf-8?B?eElTb1hSMS92Y0ljRlFCSmtnZ2Z3aXFxVkg0VTcydGdmSnBYU2tCTU9sL0w5?=
 =?utf-8?B?am53SHczSW1JVE5vWUJUV1FzendLZEQxcUxhbjdYZmRIbjJZZzJxVWFHSE5L?=
 =?utf-8?B?M05Ib1lNYTNCbDhZWG1kS2U5WXVrdXltTWVTKzdMTFowSmdpOThDUjMzcHZP?=
 =?utf-8?B?RFhLdGxOaUJDblUwMGhNTWV6bDJKTjM4NFlVSXBYemdhVHNITkhYOFNDeDM5?=
 =?utf-8?B?dE9vRVlyRnk3VlVTMkNkWTRzei9uRElMdE5HYndFOHl2Sk1ZcWdPVkw2WHdJ?=
 =?utf-8?B?ZnRPN3dUeHVjOGxhT1pCN1pRc2U3OUxvc0tmeUpnekxjNU1rUVRTVjFPS1ox?=
 =?utf-8?B?WTdTTDJkR2NzTlRidjlXVHhBNlpWTmx3NEtsVklienphalhCZFlXaS96bkE1?=
 =?utf-8?B?aVVDdVIzTjI5bVBudnhKNjQ4V0FTMHZoNUd0dERIa204cHNQWFE4ai9XNytW?=
 =?utf-8?B?M04vYnZja1EwVndsZnNvTkxSSjN2MDR1WUtrQ3BxNmZhSVhlUitwaFkwWGRw?=
 =?utf-8?Q?z2wgfLpPldcRBXdVFsP0IjmTK01CCee4PG6eeGm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f18fb8f-a9f2-4929-bf88-08d97ef0a8ee
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 00:17:14.3993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTz+jsketzd5mFnbrjhz9zuLFKZfehK4Wad3pu0RfrnWe88VGW++VbMTyxWzyc3RxHFsgLQbXYTi+vPK4SQszA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4419
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 5:19 AM, Greg KH wrote:

> What real workload can actually use this?
>
I missed replying to this.

User mode runtimes is one the usages that we think would benefit from 
User IPIs.

Also as Jens mentioned in another thread, this could help kernel to user 
notifications in io_uring (using User Interrupts instead of eventfd for 
signaling).

Libevent is another abstraction that we are evaluating.


Thanks,

Sohil

