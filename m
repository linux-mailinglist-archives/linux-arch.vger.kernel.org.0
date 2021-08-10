Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339123E7D2C
	for <lists+linux-arch@lfdr.de>; Tue, 10 Aug 2021 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbhHJQJC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Aug 2021 12:09:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:23641 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233058AbhHJQI4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Aug 2021 12:08:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="278683136"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="278683136"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 09:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="506192288"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 10 Aug 2021 09:08:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 09:08:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 10 Aug 2021 09:08:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 10 Aug 2021 09:08:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 10 Aug 2021 09:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKSo8acKVI59bsU7v+Y6evKnDG5ayNE2rE5jmoBWtibx+hPEJm5faz20dVmmOE967xOQOHWW3rO67p1QPf5UIH8dHh7oj0RLSergqMsj3T14gJeN/Bu7Nre/N5Dn0Vs7M9d45GG3MPmOEeG1b/t7+vpbFwtwA+T/oaUVO3g84YhFs94BU0CS0kH88KDyYjnqUILHlem2o2iOjlY5MYlQqjrvqjVDcS2vhgXrInm29sCegaKiBPXgMiZ8rbMk2y+QUAxnfg8Lvvw+ZWGHxtyRcUAfKn3QMMPNUAz5DlH7Hax0jjfLhLU+ekg2c2WI9LjmWYU5FFqL6NXvJqwgeRMCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEFSwnYUjKZJs7w+er2LyIXDxu4p1UvyIlsHY8TgwgQ=;
 b=HHoYWGf7rXQmwqATbN7tyhZG8ARRoSKdhfwKwKUkJHN/SroF32yubwR5MrpaIO+WOQT5RcOepi7WV/epTkgMO2LGS5lqUXypsYFsUBZEMvkPdMnMAES9ePPtiPGdy/jajDT8ZKuo77ujVOr3kaVoWCqTVsnCNnaQDDCFO77rbvc2me/4/BW2FPkLJ1zmVkw7NgAj30AJ2SKE0v52vRW/MBKXHedecVEmFfvvhFrrRYvrbueTFqS9XqLP44K0HzJ9BhfoyrO47Jb2Muk+mD5NF4wZH2RyVen60toqpVQSEcdoKvF8S9DkGMFcVQCXq65CGmDy8XV96i24Ym2Z1gLtaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEFSwnYUjKZJs7w+er2LyIXDxu4p1UvyIlsHY8TgwgQ=;
 b=bIf0xS5DEUvcuzZ8PZdvBM2MGMg3L814ByjC3xz5fDzP1LS6JdJbyPn6oP0u4McXZgZTZNDJBUyUkwOdLkR0pAFikon7z//9ZdScp4HDfmqqDzDg53lFZ9/d0Qiui4+4qt5D3O92QKOjhZoqy2jNW0lOIt2jhbDLBiaAkg5lfQg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM5PR11MB1482.namprd11.prod.outlook.com (2603:10b6:4:4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17; Tue, 10 Aug 2021 16:07:55 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%3]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 16:07:55 +0000
Subject: Re: [PATCH v28 04/10] x86/cet/ibt: Disable IBT for ia32
To:     Andy Lutomirski <luto@kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
References: <20210722205723.9476-1-yu-cheng.yu@intel.com>
 <20210722205723.9476-5-yu-cheng.yu@intel.com>
 <3318ca57-7ac3-8296-f9ae-0ae83d5f95dd@kernel.org>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <3edaaf51-dbcf-f4fc-de2d-dd72471004f4@intel.com>
Date:   Tue, 10 Aug 2021 09:07:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <3318ca57-7ac3-8296-f9ae-0ae83d5f95dd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:320:31::11) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by MWHPR18CA0025.namprd18.prod.outlook.com (2603:10b6:320:31::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 16:07:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6cbfd0-1a93-4d86-7bdf-08d95c19034b
X-MS-TrafficTypeDiagnostic: DM5PR11MB1482:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB14825CC74CAE0F739522D324ABF79@DM5PR11MB1482.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BkS4xAjXizSkjMlkfbzYq8ugLps+un1ghH2cnNn5ShAoowvX+fzYqcIGv4fd7nxFi4gbP/YsLw5cfffTwMjJK56PRIMmpiJX32OnLzkAharU4FGim5+ecdAJlnNEP6EndiyP0wQlLxO3KdGyI5e44JF7tA1cmpo3L3h8mbX7qQXVlIGmrFGK9bct2S2pIw0byYThHkhCGFmPSFpFi0u6WTgovnJshL/eXZO9wellVn7yLVTkYC1E7l6BnhR0C1hn9AA5iuUvGfA88OD/5xr5IkzGc7+b8FxD8gO44SWK2Lg95VHaDjz5oGuVHJoExhY8OR6zPFjbot+bkXPv4PlhIjm7a/ACSjaTrwbygf9OGpKR+6/aTn6gD59vguUbS7/ZV+vSxSx0NKAbaMYnNAztvvzsjI/SYMBw9C/8TP5DmfjZGyhAth2OodAcPGammD0OXOkph6up/NGQ8VCnQU3h7DuNiFGELZmjuF4sFowWHIt9AcffXCn16bxauqb+r0W/Q+0Z7VLbyLoQUpCAlq+I6h8Yn1ufPRBoJW45/hXwmyBaSRtZqJc/cS5YNx1vYJCDD4t/uStOgxujjVe2YLSCfdrTitZ3HwgHd4++BEewjAZM7z4s6ovaGH7fqK+otpiUago2jFUUgRgAOc5WdqqH0i9IPdI+tGa7rB/D6zSJrn59bVaP8bSbTY0u9M61sWDUM695g3UqkdQogIuN1FgXlK7xXdtgfV01fG2XuEW/IDUhQMVUE4ntYHUNS7IzxjGG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(2906002)(26005)(66476007)(478600001)(316002)(31686004)(5660300002)(2616005)(6636002)(4744005)(38100700002)(66946007)(66556008)(36756003)(6666004)(6486002)(31696002)(186003)(8936002)(956004)(16576012)(921005)(7416002)(53546011)(83380400001)(8676002)(86362001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0h4VzFxS1NTdzZYNXpmYXUrNngyL2RCS0JMOWcxbXJiK3g5c1c1RGdic2FZ?=
 =?utf-8?B?RDNFeHBMSDJUcXRkbXBoc3hHc1VuMVliRi9lOGNob3Y1Z21nVTN5UEk2b2RI?=
 =?utf-8?B?TEg4eUVqaTQ4U1RMQ3U3b0tiNHgzQXF6djdZNEswcTZOSnk3K0VPVTJTOUVT?=
 =?utf-8?B?RkNGdkFvZmVmUnFCcUEwSmhneHRYVndyL0JWNHR1d1Y3MU1oelBQYmVVc1kr?=
 =?utf-8?B?enRlTUlmcnJScUhFMmc1MDl5RHpaamtQZG15YzhnZE5vRDkvZUZvbFNpYWNH?=
 =?utf-8?B?eVpqZ0dpbU9iWWR1Wk45QW1sRzBNVUk0TS84VGhCcndPRE1vbjZNRDVJQnpj?=
 =?utf-8?B?bmhTV0FsdUJoSU9TampUOURkSFcyb1hqS2JocXZlMWdnZUQ4MjdwK21FeHRv?=
 =?utf-8?B?OGFaK20rZFg0MlhGajJwVDl1d2RsTmwxZTk4R0JZR2Y4MWt0VVFETmNmeFN3?=
 =?utf-8?B?SEdYbmF3aEZ2N3EzVDlRdWF5OHM2UlgxSVlWR3Jnc0k4bzlxMkRwOCtOamFr?=
 =?utf-8?B?LzJhaW5zaTN3alowTkEyZmFZWGo5QU1FYVlXbU4wZDQ4blJleTl0SnhmMFBr?=
 =?utf-8?B?QWFpb04zYUJzRGtJZy9WTU13c3hTM05OQmxSdlBIN1VqdWREbDJqcmFoT2Zl?=
 =?utf-8?B?WGsySjJjOTBTTnVPRXV6cHhiQkVJSnl5YVAwcTF4OEZDTG9KV3lvZGRIcTlN?=
 =?utf-8?B?aExUR2E5a1EySDByRTd6WHhsK0tYejhiMmZzR1d0c2pkd25tVnIzakI3RTU0?=
 =?utf-8?B?b2h3KzVNZDdqN3MrcUF3Q2N2U2lUKzI4enhMYmpCOGJZdWhoajZFWkdQK3k0?=
 =?utf-8?B?cG9FUmJCckZKZUFSa21NN2J2MWw0dDBSV2VEejl3VmhlbkRZL0xFYmFkaTkv?=
 =?utf-8?B?S003QUV6UmR6d1FBaS8yQzYxb25rWjVYU25iMktQNjFuc0hFN3lJMGFTWTEr?=
 =?utf-8?B?cW1LV2hmV0dZK3ozUHpvV3ExZ0ppSit4VGNZSzFnbFQzTTRmME1ZcW5yZHgr?=
 =?utf-8?B?VWJmcFRodHJsTENlYzdUTDRTZUlCTHR0bkNkOURaRWpLR28vZG9kRTNMQUE0?=
 =?utf-8?B?eDVDdWNKK3pyenlOa3FOZUErMVRBS0prKzZHcHptMjhWUEVCYmg3bVVmVjAv?=
 =?utf-8?B?Tm5XQW4vRXJpWFZLYjlFTlVHaFI0WEtvak1VMEtMNUFSN2hjRDZ4MWtubGwr?=
 =?utf-8?B?Wnh5aTBNRXZTbVFZN3N6MGduR2RTZ2EvMjBRWXh6QWlCVXo4WUVtcWQzeGlQ?=
 =?utf-8?B?MlREWjB6bFMzZGQzT3hqZHZROGEyYmdETUYyQkYvNGdWWEVVeVhQZVNKdGlw?=
 =?utf-8?B?U1BkVndWYXZVeFVwUHZXSVlzUGI1TmliQTdpb0JWZmtYOXBldWxXMmVyNVF5?=
 =?utf-8?B?L0s5Tk43Mk5FbzhhaXcwYXVDSEg3UnVMa1VQNFp0VTljVStDSFBiamIwZUQ3?=
 =?utf-8?B?Ym8yOGV4UVN2dkVJTjFlcm5PZTd3dFMvZlZxY3VhaDY1dngrSUNaem5hemk2?=
 =?utf-8?B?OTlsdWQxei9JUUh5c1hEV3I0UFZkSHU5SldRMWRsRDZnYUNUUEpmUnNEREFm?=
 =?utf-8?B?TW14VW1ncmJad3FFeHRnZ3daNEFEQ2xiQS9GNEVSRlFKdDN4SEh2YnAyMW45?=
 =?utf-8?B?Q3JxS3MyNDgzSy9QSEZwbHZWaytIVzgvSExqUUxjdVFaSXdWa0NSOVJnbDRi?=
 =?utf-8?B?SklkUGVxTDI3SXV6S095eXd2b1ZYcGpzS3VqTDg4SFFqSXZpSVROa1RORU5K?=
 =?utf-8?Q?Og3ECcFZeKl4C7oUw2DLklOvfI+vlXnrKhJ+iDg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6cbfd0-1a93-4d86-7bdf-08d95c19034b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 16:07:55.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+7ifWdhhqChoop4B99S84QThBzz6ymDak+Vm3lAFeAJRvOhB7f0Ad5QKLOZ9p0/bjmIWqwauhePD0BmNjyO2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1482
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/9/2021 4:04 PM, Andy Lutomirski wrote:
> On 7/22/21 1:57 PM, Yu-cheng Yu wrote:
>> In a signal, a task's IBT status needs to be saved to the signal frame, and
>> later restored in sigreturn.  For the purpose, previous versions of the
>> series add a new struct to the signal frame.  However, a new signal frame
>> format (or re-using a reserved space) introduces complex compatibility
>> issues.
>>
>> In the discussion (see link below), Andy Lutomirski proposed using a
>> ucontext flag.  The approach is clean and eliminates most compatibility
>> issues.
>>
>> However, a legacy IA32 signal frame does not have ucontext and cannot
>> support a uc flag.  Thus,
>>
>> - Disable IBT for ia32.
>> - In ia32 sigreturn, verify ibt is disabled.
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 

Thanks!
