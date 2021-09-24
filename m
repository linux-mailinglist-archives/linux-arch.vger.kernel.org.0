Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E6417C12
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 21:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348276AbhIXUBG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 16:01:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:30785 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345980AbhIXUBF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Sep 2021 16:01:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="285166332"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="285166332"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2021 12:59:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; 
   d="scan'208";a="436246456"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 24 Sep 2021 12:59:31 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 12:59:31 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 24 Sep 2021 12:59:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 24 Sep 2021 12:59:31 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 24 Sep 2021 12:59:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmjAOs71aCi7zw55HylxZwGd33JGYCfwBGq1O5jmB5jkm9eERJUYrLCAMLkOeTaZEzm05FME+jqX6qaGMhVraE0diRgISpOurMNLJ97pVLDUflZt6QJFxgPYCdkYhRD4OOO3zAQCUUHMElG4VYuk2983UOUQLgdumyfTyC2NpQ7OJsAPN2q6hre4+ywreNU0fQfIc6WftjQ0s9DgBBYXeGjyydiJw2PULqdokzg/WLPGs9eJrekHBhU2l7TT1KU9c13QtGMvth0FXI+9ll2pxfnOcT7uhcJ8S3vdIPayg+Gm2+a4yyK52BSDR6mVZicYtjzIZw8x2Asvy5JLrA7BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AiwDntc0JyWW11Z6KdmllqFVNCpLmFN/huRcrymPHwg=;
 b=ilcS9njtNhVfWB9aMKt4IvCTMsGMFoYTs+/1JN4e0Z7+CCV0XL4+1XohbPzvxqxGQnQWRx8C+lEEGUsaoxmgKOJF7C33TO3gzD40vmD11fcRuSBH5XDWQ/Gs4N0Q/UDBjBH9Wyd9HWGdcwxvGAcbm0G4KdX8HelHFt/4SqF1iADipHuyjPcZhP2ny2RybynocTXYFBLMLJkig74Umj17OwFEEC408nUfyPQ4pnUCjG14gjgHCYZLAUJ9hTRIPvhhNIHfiveoETQ64hz7D+YNIma6xCdWah7dWPJfgfhf/ubJPYt8o4KcbPEoXs05mWimG2WzNjL3cG0AG6aoSbKvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiwDntc0JyWW11Z6KdmllqFVNCpLmFN/huRcrymPHwg=;
 b=fE65cwK2eESdlc3Y4rcLtR1hbnmaCm8WWR0sCfOPUYKFYjINWMNok+7WuVvCNV+Peyiw0MvpE3DR3gaxwmGLobioXN46zVP9Nil2/4tB9kKLQ/efftY34JBoXk2bSDcSNN+Ils0qD3TBzSAFgkz0d/0IrqbjNQwPorQ7YBWevXE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB2565.namprd11.prod.outlook.com (2603:10b6:a02:c9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 19:59:29 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6db5:94d3:e534:617c%7]) with mapi id 15.20.4523.018; Fri, 24 Sep 2021
 19:59:28 +0000
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
Message-ID: <86123a94-c156-4d93-e199-1f2f1de4b95f@intel.com>
Date:   Fri, 24 Sep 2021 12:59:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <87lf3nexrz.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR05CA0177.namprd05.prod.outlook.com
 (2603:10b6:a03:339::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR05CA0177.namprd05.prod.outlook.com (2603:10b6:a03:339::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend Transport; Fri, 24 Sep 2021 19:59:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5447dbd-a364-43c9-3102-08d97f95d0f8
X-MS-TrafficTypeDiagnostic: BYAPR11MB2565:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB2565C319AA7DC38461BB992CE5A49@BYAPR11MB2565.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucY3j/b1f0fBqGODdbsJetsKeSOtlQM+FKvjHuyC5gNBagzem/Fk1TfzfXTON+jSAQ3WJGrQPXb5eKV7I1YV9TNnWaNvkU+p/gFPkUBqRAZc6vJ08IIWf2WhRx6Y9d5ylBdLuF2kU5uVN+6N2D7dOe2ADiNuXKNATL6OJFFzCHfrFhfdMtC5Cn8vi6eU1WVCpanlYfaimKV4RvY1CY/roRGSZs0pn+g6+U4796/uEIzJm9WGBtd0E29AJhl245cPUkkeGZ6syakSRLeM4YM3j24xaGxrDQLccO1LlBR95voRxeRoKq83fAc73Sr/agpBo9wQUafQQ+uZx6UywdhClolgk98rvJKNPMLGq0CLXOjrCcqliwvDtDy+c0/6THmr5L31VZ/OAo0srYbFcIcKPe0Wf5BK2iPW1mo+75ShIONjdzdXjIUMNFa5aiIMEkuJIL+VhII2OJmCtm6GzbZc9IteAOuI2q2QBB4e/dNW8UG8G3MFgvU9+SaZwg9761nLCAdMRd8YB8mRPBqGHCTeKrJdeBUmdrkovVQTMZo38WpSsDHglDCqK2XtvULl/vGM4kFTZtwYml5CNEgHO41gkVpf+gnWA+BOxDFRkL+QpYtUW35I5usUuglKIcQOcmspW5ZfLmBkJNR06gSlUXwdOBpsFHg3GZ76OdrHPYOj9eTyy1mtFksuHNJ36iGf7ytmn6fTrGfaAgROJHYYLS5/UCvZVyZ7v+H070GAw6DTpMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(186003)(53546011)(44832011)(508600001)(5660300002)(2906002)(26005)(36756003)(4326008)(2616005)(4744005)(956004)(8676002)(38100700002)(8936002)(31686004)(66476007)(86362001)(66556008)(54906003)(66946007)(16576012)(7416002)(31696002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STdxTlZKUUw3L2ZBd3VzaU1LTFdtTTVoSTNPdDNqZ3k5SWwxUVdsNFZBZ3dk?=
 =?utf-8?B?d29KV1Q2YjdCRjM3Y0VLQ1VPVk00djB4SUxrQ2d1NVB3MlFadU0zcG9xcHZr?=
 =?utf-8?B?ekZ3V0NKZUx5eFhEakZtaGQrdndJU2RGdUhTUGZnTVVZZG1uVGJvekc1S3NR?=
 =?utf-8?B?bkViVW5hM29IbmtYRnY3VWZ0eXJLSTFxN2R2eUNJWlppeXpnVHVSQ3QrL3h0?=
 =?utf-8?B?WkNOVEwyVVg3dmVEMTFoU2Z1dkFyT1Z2b2hXRkkySy9HeEhwR2FuRWZ5TVZ1?=
 =?utf-8?B?VVRVaUdHejdoWDRqaFpNRG1sQW91L0R6UDh4NnFIb1hMYW5USU9tQnpuQjFB?=
 =?utf-8?B?UmJDd3RhVUMzenhtQjhndWtXZndCVUY5OFFyME9taVIyMmlnOEd3ZnRidGlx?=
 =?utf-8?B?SzBtYlR5Szd2SHdzTDRkRk0zZmFZREJ1Q2lpZlJndFYzaHhGSGh2YjloUHlt?=
 =?utf-8?B?OFV6ajdZdXZLUVdJR1U2VkxpaWl4TXNxZUM4cUgzSU12ajZvOGRacktvNGdU?=
 =?utf-8?B?a0FnQmR0cWRmbE5BUVdSMkowbjZqNG1WazdIV3l5QjJMWnBsUHJQQmdBbXhK?=
 =?utf-8?B?Yk5GZ3l5am5ZR2FRbUR3bXUzUXBRcVc5MlZxZDhrOStXM3YxeEdUYi85R1pC?=
 =?utf-8?B?bDMxYVpZZitNNkcrZ0M2dXRCTlZibkYzTFo4eU45aFUyem9ac0RTZTMyVnpZ?=
 =?utf-8?B?NUMzNWlKVDJhL2JhK1MrNlZrTUZpS296SFZCUDdLZENOOUxTbFJLSWdubDVz?=
 =?utf-8?B?UkF4WjdWaGpjSUczN3ZYd0dCZ2RoRXdsMnB5ak9NdkF0akhINExRNE1xcU5O?=
 =?utf-8?B?YlkrOGl4Ly9BUmk4UXlMNjVQRnZ4cnpnblp0dFhYck0vaXRXaTVEeC9EYnhZ?=
 =?utf-8?B?cWkwMkV2R3pCWjVnZDFicVFUNnZlNFljQ2pQMDRHaHJkeE9DZElGMEgyN2tJ?=
 =?utf-8?B?d2lIbDFkM1pQTTI4dVVXblpZVXQyOVdKVjN6dHJTd0JuK0NTbytYcHpZQnJG?=
 =?utf-8?B?NnhpcS9VZ01qTnVWZWFpMmg1Qlp1c1l0NnZtZmg0dmJPNStuT2htQVdTYVg2?=
 =?utf-8?B?NW9OeXlXN011YWNwMVZjQmZIY1BXcnk0RkY5Q2NxcXNLN2dNOVlDYUl2QWNJ?=
 =?utf-8?B?RERjVEl4aUtwRm5zSnBKdVNzV3NmalM5R3VQWkFFZmJIQ1pRSlEzUjhMTWht?=
 =?utf-8?B?RTh1TUlremxsRjE4Zytuci9odFNrM3R4eWVkUkd2YTlkMm5UcGd1czhkMGt2?=
 =?utf-8?B?dHdBL0duZDhEVFhvS0NpZDZQblBmUFEwbTdBVE14ZjZkMjloU1hCNTBRUi9l?=
 =?utf-8?B?d1dtZXE0UHMzR21zWk5vaVZnMVI5YUNDaEJ6OU9GNnI3WVJneTlGdXFSaG5J?=
 =?utf-8?B?VkVkSlplSUxWMDdMTkJnQlJXOVJTSDdVM0FtL2xqNFVYb3lPeEtMSFZqMVJm?=
 =?utf-8?B?S2pUUHE5dnZXYUZUYmgxZnYxaDFZUG1EclcyTmpuUlhEb3lGaXFpVktuNEl2?=
 =?utf-8?B?bkk0akhseVg0UkdLMHl5bDZuaXIxbG5JM2RSeHVIdkp0azlYS1V6U1p3MlZj?=
 =?utf-8?B?SVJrSVZGcWNtb2NMUFBmTjVNOXcvdUxpeS8rYW5SdkJ3dnpTcjFFQlV4dSs4?=
 =?utf-8?B?ZWNuMFliM2MrMWx6cWlHWjdST241cXhOMUZnRkI4WTM1aUdUZ2pjYWx0YWVt?=
 =?utf-8?B?SEs5V25hSjg0dVd0djlPQUUreFRwS3krbnJ0cDUzb1Q4V0NMUGI5NnpMaFpq?=
 =?utf-8?Q?te9ZLUMX7zobul6HwAoULe4pDiXm2ePlCWtAiiJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5447dbd-a364-43c9-3102-08d97f95d0f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:59:28.7064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW1E/5fH6Zs+THpSuL29hjBrmVqwKXlEUKYi7U3kB/SbbVxyqmSOrvY6EhtEWckpPGi6JtfMOgTVDqf0oGBsfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2565
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2021 3:24 PM, Thomas Gleixner wrote:
> On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> This SOB chain is invalid. Ditto in several other patches.
>
>
Thank you Thomas for reviewing the patches! Really appreciate it.

I'll fix the SOB chain next time. I am planning to reply to rest of the 
comments over the next week.

Thanks,

Sohil


