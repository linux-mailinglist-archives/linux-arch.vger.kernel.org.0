Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB3741BADA
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 01:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhI1XPe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Sep 2021 19:15:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:21714 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhI1XPd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Sep 2021 19:15:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="310373379"
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="310373379"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 16:13:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="456806932"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 28 Sep 2021 16:13:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 16:13:34 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 16:13:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 16:13:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 16:13:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDGRdMm9LBNGmGW3Bxpt23mNlaB8d5yniKKcputFmq3iWkj8G5UB0feo31W1Uv1eqv2gNXiw7K1Oz9vgAOnhBHqE/EYLFUPII4jDlnUgXiLYRlVmzGtUnpTXDBBp/bP2CLd7tUUWJ6p01Jce//dGU7rccj2eL1VQ471pBO559PIqd25ZcVPHYT53790XKlw+AilC3R+48m+1n3fRX5o4D4VW0CnuiLBxqTSUI2YmYfE5YN7I5KVh0XCleC0d8vj3ERQv70UG4EdiFiVMT/THrJoljDKOzry7/laMa20gXUWteawbf6k/7T4rRXaf4RRIuS3sIqEfI9FXlYpNOH1Hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yOBLqkzkwtuUPkhac5OO5larY786qx5THE+ltfgyG1k=;
 b=Cih9UutJCR4euiIioIR3Nv6Z4fpLzHYSNtmW7o/duXZP/QOPoNL6DkvB2uICDLupqNG8rRRqIdfegDOa7V0i0CpxJ/mNzDuTaTeA3y0uta9GETVz7Q8yGqW02if6jQdThn91xZWmEJ8J7UVqtz/OGDVDWwh/40wg4R52isG3UJk2fZvlUC9CY6TAeRLYGwQEIVvlxcxD0j205atvVcaAJ2QPHFo4ZKbPyAJsMIG01NJQk9GIG4MeMi7EIouICrbZeVyVgX/CLQuSHhvaJdvvfj5KK/lku+xMjelWZ/Co0FyOYL2fX20IffrjGisMwty3CMiGgm5YA/kS5Rfc8G31VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOBLqkzkwtuUPkhac5OO5larY786qx5THE+ltfgyG1k=;
 b=erOjZD3YrAyuOznBM4kdk2InNFQ7VXhkqjPkh4eEsMwgKoWiEvAxtqFMmwIe3zlIlibUveYaP5KYK4pmPebnVs04SfntYfDAqFlRQNlM/sIiMUGsYlDGfzRaz/3VpgVxUMBx8NhEbQi1zFXioWpYRsf2fsQfnUhxu6bZ9Ccr0qE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB3128.namprd11.prod.outlook.com (2603:10b6:a03:86::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Tue, 28 Sep
 2021 23:13:29 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 23:13:29 +0000
Subject: Re: [RFC PATCH 11/13] x86/uintr: Introduce uintr_wait() syscall
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
 <20210913200132.3396598-12-sohil.mehta@intel.com> <87r1dedykm.ffs@tglx>
 <87czoweu2d.ffs@tglx>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <c7d9d081-f0db-bd8d-b283-4aa001f2a6b3@intel.com>
Date:   Tue, 28 Sep 2021 16:13:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <87czoweu2d.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by BYAPR06CA0031.namprd06.prod.outlook.com (2603:10b6:a03:d4::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Tue, 28 Sep 2021 23:13:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b0bbe9-6874-4432-2bfa-08d982d59558
X-MS-TrafficTypeDiagnostic: BYAPR11MB3128:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB3128132916A03F48F073990AE5A89@BYAPR11MB3128.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 249hdRC7vkBcRUzTo+QhTD7RWWWqUTlwjp3GNULoxn3e6UcU2x9yCtAtddptiJFA8Xsy8I9pIH6tFegPiE/W7Dvx6OfvCK2fjPVPPNvbwWhPefqi7HLOVMb/lECgA4HJ5CGtTDIPf9eAdFUtYDyrnRcqigsW8Sr2qXlAqULAVCwrgBWJOx567R578s4qKS/vyPnrPVEyrab2s6F0GZ2hBLSgmoPyULeuiLuLvZS4uhTPcRprA2pttyBvOImGymzMqvfov2p5q6l1BlZlbjpwP60fTQuQRVVcGVHyQxCiF4QgHE669juSuj31GnAZq0wPdz3DfqukSNNmdQNNc66RU2GM286bq++sdlucHiVAbMFHjbZylSVCOKvSu+287jnRpW/uea5xqtHq/irnfY6YFATSC0WS2wqe/00HJO9pmZxOdUHWsAmmYkpPCrCWsk6yYa92E1+bgtFCS7WAca/iVBoeMH802s9EqMXmo/QHzbRnbcJwrBZn514itggQRQuJcGSrJHQOKNc27KxuKLUS7ZMkltsO+qiLl3axHRK29YCA+vIiKcwqCb/vw3W4OUbhm0TH8Jrhx7QYJSbYSEcMxFjLQYPUL6Xdd1F89xWFklhkmQnh4qb+OqmRVvECl0JTSMuD86xZJKMyCUn6UZFIqRtW4UIAK+8Za0nHn3Y4Qdydsu0PAZnS0PQqzzFCS3SLeGHXn0rr+mZSgVBFPryEkpTA7cl6ShytkXKhGWuefpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(16576012)(26005)(8676002)(66946007)(53546011)(8936002)(186003)(2906002)(44832011)(5660300002)(66556008)(7416002)(31686004)(66476007)(558084003)(31696002)(2616005)(316002)(956004)(38100700002)(36756003)(86362001)(4326008)(508600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2N3SktYNnJpOTliT2psNWFLanZDZ2wyYVJESFRCVzJ2dUNSMHdFZmp5QmFU?=
 =?utf-8?B?WGllcVRocHVDZUc4c25WM2hxSUNEQkowNUZ0aHgyS2Z4eWxKYmJrdDF2S2F5?=
 =?utf-8?B?TVZRbUJMTmxLQUxQZm5GVzUyZ3crYkpUeHBIeWpTcTNxY1owTFRuVjlLN1NW?=
 =?utf-8?B?Z3BxRVIweWx4WTAzVUZPS3h1QnU3WnFGejE4WlozNXNnVitkV2FiZE4zam03?=
 =?utf-8?B?aGhQQVA2TmphQVVJRzhiVENYdStkL2xzbHdlc3RJbzllQ25tNHJkSERrcTBV?=
 =?utf-8?B?cUFGNG5sQWNPbThkenJDTEZwbjVhNDdwVU1SWmlpRWtjd0hNak5pLzBHV2cx?=
 =?utf-8?B?UHY0Mk5jRzhKUzgrbmJOWXdLL21PLytzakRMU0wyeWdQTzI2Qi9UM0J6Y2NO?=
 =?utf-8?B?MnNpenNFOWtqbDhYUXREV3cwS28rOFBxdm0yRVBUaHpmK0l6Nmk0bGhoNUxr?=
 =?utf-8?B?M2o3UXlZK3NCS25FeDZlYzBTVU1rZVkyTStxQktwdll4UDh6Zmgya0tvenpq?=
 =?utf-8?B?T0JJZ0cvaXY1R0FTNXNlVlhsWnFMSDZIRUdKWWk3dmlDYWhFOVZyQzY1L21o?=
 =?utf-8?B?ME0zNTZ0ZTNhUlliQkVhS3JKak5KRHhZRzY0SlpoL0RvQkh4MFkweDg3eGcx?=
 =?utf-8?B?aEZLQVdSTUM5ejVZUEhlL2ZpTFRmYVVvTGFaOTRBcmJtdU5vY0hOa0hiQ3Z6?=
 =?utf-8?B?UmZTd0RpcTI5bmtnVjd0cmlJOXR4NWY4dTRwTElwZGVqeXhQVEhBUUJsOExi?=
 =?utf-8?B?cll3WkJwOFVKT3pzS0IzY3FzbWFNeUUrZjVGTE5zak9HbkZUcVhLUlNoanJq?=
 =?utf-8?B?a3R1bGo3MWQrVSsraGszTFNEcUtQR1ZWS2NnQ0k5TlJuVE1yRmJEQ0cxeTcy?=
 =?utf-8?B?RkhsQkFGV1dtMms5Z3JoS2ZYNWk4eWRzdDAvbThFRFlkVlBNV0JYeWRRUmdw?=
 =?utf-8?B?TjBOSlN4TjJQT0JjeFV0eFVVTjFERkU4N3E3dzVzVFJObDlLbDFRdkR1L2Jt?=
 =?utf-8?B?RlJVRFQ2eDJFQ1BxVnN4VnNLSzVZSTNaaWdpN1R6QThzczNuSC9GVGlHWERy?=
 =?utf-8?B?TWZ2VUNFNHBQb1lBZGpvRnZaVUpJNlhUc1NDWUlSU0FMVnZSaWJweFRjNThN?=
 =?utf-8?B?WWgzcGl0ZUlnTjdrVGRtOWNRbEoxeFkwbGt3elRtU3l3a0puTjErdTVDbUVq?=
 =?utf-8?B?VzVla2taZGtkcnR6K0lYRzcrR2JlZHY5YVdEZXBqWGRRVVNvckYwVHNRc2s1?=
 =?utf-8?B?SEloSHM5RTZoc2xscktJZVk3WGh5a2QyS1VlcWZtbTZPa2dNUThpaldSMnVw?=
 =?utf-8?B?c2lnNlpoY1YwcENiS2NoTDJFZVFMRFU5cXVFOXBUcXVtWFhVUVozUGUycEtH?=
 =?utf-8?B?Y2Y1azhjTVppRk1DcVE1b1FUYUs2V0lKM0VOalUzM1M2dVhEUkxqYjFFYUE2?=
 =?utf-8?B?KythTWlEUkVTRy82a3R1RDRJNEkxeHd0cEtKeTVuVU1zM21ZVzJ2RU5xbmRt?=
 =?utf-8?B?dlBKd1NvbHlnZ28vMjArajk3RmZpd3JQYzltWTRpVGJ1YWdLQ1JJK09iUUdo?=
 =?utf-8?B?cWdSbFFHTHFZRmNQdGZnZXl2dXh5ZHZGcld5VzVPSW02Z08rN3pDN1h6K212?=
 =?utf-8?B?clpSVTNLNjlyRFVlRFYzUGRlOS9DL085ay80NWRscnY5WkZUM0s3QU9hUjda?=
 =?utf-8?B?V0VENHprVnNyY2RTQ3YwVlBaTGIwWmh6dVZsWUNNNkd6TDFEWnB4cXNjQytB?=
 =?utf-8?Q?slSrO2r2DMACXjpV5lwd9f2RStPgxQJ84n+C/Fd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b0bbe9-6874-4432-2bfa-08d982d59558
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 23:13:29.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ii8tg9qPnrP7PhbsjLo0BiV4SwldeFFRtfGuJq+YAz6oPgDL4wP0f8YlNeiNQgP2IBPIOj4fr7Nx3XBNmLZ+pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3128
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/25/2021 5:08 AM, Thomas Gleixner wrote:
> Aisde of that this is completely broken vs. CPU hotplug.
>
Thank you for pointing this out. I hadn't even considered CPU hotplug.

Thanks,
Sohil

