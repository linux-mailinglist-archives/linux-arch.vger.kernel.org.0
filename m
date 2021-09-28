Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DA241B468
	for <lists+linux-arch@lfdr.de>; Tue, 28 Sep 2021 18:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241867AbhI1QtZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 12:49:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:16089 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241872AbhI1QtY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 12:49:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="247267495"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="247267495"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 09:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="554141996"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2021 09:47:28 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 09:47:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 09:47:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 09:47:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBkpxWLf4b0NTkg1V10KR719OoXXGMbLNtgcgv/QreRusue7IvvxehLLjWjl/RGu5QQcgEgKSJwGRXmvSKi0aYYMt5YBdRdyKJVPTCcsa/cEJm9BhbQQbY2BXDsaEwm16kpDe38n3lFONxta7oAzK2BPWt8jSS6TtB8eYi9GAz9DP2os/E7jWg15aKIHUmC8+9AVKbQqvnLFq8ixhta+jrGhiHnKToebvend1Ov+iAH5UVZmkyachY31BvGHypsC/8l2vtEtfe34YkextWGJyu6Eg4oFOS4qtA7Bve3yHCH8z4V97x2qUyrrlhmiTHAlK/c7+5yFatzUQZ++Nk0/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Il+CK6iPb4I4AnlazdO9TBoqCknmK4Kf4cD5+0FSE/4=;
 b=YFPojA/wp+zaD2ZbeccMvQ+Egm92uRK52EK5qe4Ocq9zPc1B9L9IxHosTLI+Cwn6V21DjmuvRMFbyFX2pkU/BIKBvtncaHEVyYwDJx4pvgTcuE7vE02c0ElYSzj/4JaAJo39YMDnAI/gqJgppAfgrPblozGfv9HFWHcEagWJ5pC1Bq5f4csxLNEl+MmQ09bDsuMTgIaZbu+jEbUtRmW/j1pjOU4vNatN5994JOhHbvthyh2yfcVUt50xD55R84OTmRkUFzvSK7SE/1zZVpv1Gv3OITPx5SpTE8heXD65J+Vlb4qhK2/sVp+9nl9zQYBcdaZzebgRlYNg+FN+U/XljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il+CK6iPb4I4AnlazdO9TBoqCknmK4Kf4cD5+0FSE/4=;
 b=JC77XteUsqPC5OefxJKkIAxK4fDBa3MpzQd22Sza+QGbZEujJiOyLDdZW8BATu+oLjYPOExgx7Edd+gHFVSKKuSYkeC3z3IHHvyH7xFnGKkFO1r57PED//DRYIkqYQ/X/k2ctaR1g27P+AjXeZvpJFa/0aTzuEnd73RXyHUWRaA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB2822.namprd11.prod.outlook.com (2603:10b6:a02:c8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 16:47:24 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 16:47:24 +0000
Subject: Re: [RFC PATCH 06/13] x86/uintr: Introduce uintr receiver syscalls
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
 <20210913200132.3396598-7-sohil.mehta@intel.com> <YUxyZuJoK87OeGlw@kroah.com>
 <d3cabce0-922d-b09c-13b6-cafa7023d93f@intel.com> <YVKcgSx8wd2xiW1/@kroah.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <0f027e9b-c8ab-33cc-156f-a1434d515f49@intel.com>
Date:   Tue, 28 Sep 2021 09:47:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YVKcgSx8wd2xiW1/@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.9 via Frontend Transport; Tue, 28 Sep 2021 16:47:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c636cc3-b7af-42e5-38e7-08d9829fa5cc
X-MS-TrafficTypeDiagnostic: BYAPR11MB2822:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB28224D1622C4E653FF36CF75E5A89@BYAPR11MB2822.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9bZM63O6ffmGChf8c2Y0dpyvfa4ffbtPGiinfdQ0z+I4HPL8iM/kolovDr8eRymzPQ+oociEjaq9uIinfELLX9dyxqAk92QhFLmSUMgH8mFNnDizYahV3KMKXa0uz+A5z+4VYXJnUU+YCsHpeW0cSBKN6aIiSDAItkPehgf4Y0qIgRNzt3qDy/+I1CIqEi/UoKV3p/8iyG3qI1S1Euy6ZPTIoaXrw3c4EhRVxHlPZzbLixxGcrQzpQ+/RJNchP9q0Yu4pWyMPcdj7JFlz9L0+7KhBW5YwZvcvm46cCdLZ7ImNB+3dqx9rWuOrSZN1Z5iLw8T/tRUZbHPlwaVA13sqI3d2jkyDAKWhE/8oF7RQk+VQ3Z17Vn9q8BnSsDSXSDowE8cgcv13Zpq0re5UFSeR7sEqZ71k9IKHZFymHJyGwIPAQF+U1lx8Vc7E791O8oIcZcYYXf24gu/gbFiexN+obtQjFavpiTQC3y6ZMK7WgQlMKdC26ezZ9zUKtrJCgToqu67myEOO4SpcKOwqeDbJVwdTkwhbWsazYe2Jdm7zNO91QdBRwR0pOE+u2XxBnModR3FiFcijSldW1Z8uWMt7lOkNwjD7EIpjGUAKWu4GcdLZ5sioqNNX05FEUkF500yENcAzMMbz1GSAo8vi00V8uHLWsiHkNAHXSuclgbyTu5zyiDHcAwX+Ouqli9PC1NmFFmvNNYNme0rG7RA33fbzoQxKPcdVxMfVJo1dEmFkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(6916009)(44832011)(36756003)(956004)(2906002)(5660300002)(186003)(26005)(2616005)(7416002)(6486002)(66476007)(558084003)(53546011)(66556008)(31696002)(66946007)(16576012)(54906003)(86362001)(38100700002)(508600001)(8676002)(4326008)(8936002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2o5YTFLV0c5SWQyNjVONjdlbS9Ra2RJdHVzaE5yaHV1WDJxMTd2Z2M2eGh4?=
 =?utf-8?B?eTJrRTdSSEhVSVRVM1Y2Tit4SHJFdkFrN0xKYjAzVnE3SGxIMDBYWWpmYnBy?=
 =?utf-8?B?NnN2cEJuUlBOTDFsMTdQWFBXa3hTbW1qN3VMRkowaStxdk1QZmRkMDNEOVFN?=
 =?utf-8?B?Uzd4UTRqUnd0aDQ1bWF3R0NxVnp1SnIvMEE4djNWaXJYMjhvR3lwTlhPQmZH?=
 =?utf-8?B?aDRISVorV28wRmhDc2VScG93VldCTkR5YysrUVNMalFmN1gyY3hralFEMUlx?=
 =?utf-8?B?aWtFdDRobWhENU8rZng5Snhpa2U4RDMwd1dHZ3pSVFdZdjhYSkMySjczOFhW?=
 =?utf-8?B?dHI2bVVTK09wekVieHJ1SjZLMitmeUlvdVgrVDlrQzhld1RzdWtwNFEzdTlk?=
 =?utf-8?B?NmJOclRsbmYzR2Y3ZmlNUytGS3AzcHBMbUNuOXRGa2VhVWc5QzlaeXRCbElR?=
 =?utf-8?B?dy9taUxzWElhWDQ2dFNiRjNuZ1hBY1JaRThSNzYxWmZhL0JMK2xwZ2tLRE00?=
 =?utf-8?B?NFZqT1dBeE51cTk0Zk1WdVc0Yml3d1h2ckt0V0Z3djUrV1JlREJQN0NYZnds?=
 =?utf-8?B?cVREVjg5UE1pbzREMjZNNHNjLytIR2wxL0V4TXNsT1MzYWpFNDB6a3BVbkMv?=
 =?utf-8?B?Z3krc0pRL3NEZ1pzMUtid0s0WEpHRm5wdmZEV0dIQkhVbGZGMVJVNHI2a0Fh?=
 =?utf-8?B?VFhrMTJSbFg4bFV2aWNIc2Q4ckZsTWZxRDl6MW9wS3k2OWxjSXB6SVdHWlZB?=
 =?utf-8?B?UE9RaTJoVFNLbWlWQldSTzZ6ZVdReGlUTk0vQmRRSU54b3BDVE9sQnNIWEVE?=
 =?utf-8?B?TFVKNXNEQ093S21jd1VMTzEwc01ONzhKQ3dwdXRhRHhyNEFBK3cxTE1CTWxU?=
 =?utf-8?B?N0tEMEQ0V2RycWNHNTkzenJhcGhaaktaN242cjQyMWEyc1gyTENaU3NFcmtp?=
 =?utf-8?B?cCt0M25CaTBsOHRwY3lYMU9UZVBvUGZVNjluUmtqSm5aZmFGNFU4di9xVERF?=
 =?utf-8?B?clVwQ1M0a3dGL3BzME9OMlVYS2pTckcrUTJwK0VoY1dYbFFaeElXQ1JvT2lr?=
 =?utf-8?B?WjN5T0t4ck8vYW54TUlWMkEyVzNyc0t2dDhuU2xmdjhqeWJXL2VhY3hCcmlX?=
 =?utf-8?B?TXRoQVZnbEdLY212ODlpcDZIWFV1ZTBtT1l1MExoZzdVQmxBRnVyY1BIekYr?=
 =?utf-8?B?NExpT1hBRmpRbk1EZFhYN2VKbWgxKzh2ZkpTQ1JWNGcyV0llNXdjVWl6WnNT?=
 =?utf-8?B?OXVJYUltRVZnN2FtR3IxSVJNZWNCZ3RCYm90dVQrMFJBNC83ckljcnU4U3FS?=
 =?utf-8?B?NzY4RU93eWVMU25GS1Y5M05CNnBCN2I0QTNHS0EwMWxOVktDSC9vcXJrSXlI?=
 =?utf-8?B?ZG5ITktTQ25JUm1nWTA3OUlyWWVxVk5BTVg3Qk92OGQwQXVxeU9MSkNBWnp5?=
 =?utf-8?B?UlZ4blB4KzYwdEc2TzlhMCtzSC9sK2V4M0lQVWdDMk1qb2o5MkFiYnIvWU5Y?=
 =?utf-8?B?ZVpKaHh2M3ZSLzRaOG9VSGxFT2NneTdjNWZlZDBjNy9YaEppdFNDZDZkYWlD?=
 =?utf-8?B?ZHRuK2lIYW83NVV5VUxoRlhMQW9NUXl2SmtMWXk2SUtpMlF1Q1IvalRubU1j?=
 =?utf-8?B?bkZOM2FvcVdueVc5dTVVUHZoSXljVm5Ca1hKeHNCbmZqcDBpQUhUY0p2SW1C?=
 =?utf-8?B?NDN0TVdZbnpRQ3RCQWpFYUlCN2g2RWJXcnVjUkREUU1aYVhDZzVlRDdQcmVq?=
 =?utf-8?Q?i3jmo0FLE62XcGXeyGN2qXNv0yYsbZmjo5Pz9UN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c636cc3-b7af-42e5-38e7-08d9829fa5cc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:47:24.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fcf6QCn3YJ8XR6jM9ftHwesE/plqtDG3A595A/n4QcWWrThp5c3BOTfiL5V3ezY0RLyN1KLD3OOlC23Pv0J7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2822
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/27/2021 9:39 PM, Greg KH wrote:
>
> Then those values must be set to 0, right?  I think I missed the part of
> the code that set them, hopefully it's somewhere...

Yes. The kzalloc() as part of alloc_upid() does it.

Thanks,

Sohil

