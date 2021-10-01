Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA941E598
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 02:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350104AbhJAAmf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Sep 2021 20:42:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:54352 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349760AbhJAAme (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Sep 2021 20:42:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="286343931"
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="286343931"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 17:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="564552041"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 30 Sep 2021 17:40:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 30 Sep 2021 17:40:30 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 30 Sep 2021 17:40:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 30 Sep 2021 17:40:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 30 Sep 2021 17:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV5jmUKZuHnSNzeYeIQTf1h7oNTdBhgYOzz0YcF3Ns77FcZhRNr2130vFvLDvZJsSeSt2yRpxavvlncAmmT7t4ZluaKHzEK/dtDsaANlkDrb+AGXHcoqbVk39Tz89JA4qWzb+jdsYKS/LKBuIfkKNnkoLNRvPDo7CsXs27//vVBRW2i2mMeDU0/ZBXJRy6mX7XKUyuFL4pWzy6f99qUQkY82fGhkHk3iSUB1JFzsNhkX3tdERq6uyTsEpq1MT7m+UlfOSiIsZ97dOLGPSdfUaHwr4acTh1ANqqbb7KIutBaPtl/Cm5tdRNsRKGQfIr/xdy9BpxyFjFcXPbcD1Ji/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqMOt9UR4Nu+hD7zvVuQmRP9Z4ORnMa3A5tWNXxUUmk=;
 b=OiJc+4O2M5q0jIP7DbOjpidlhlK3kxeXr5/TCcSHreGC6I0f8pnIFZZPivj991ocI+IFRdXbWwkCH/slC8BrgUsRMauzigPz9lzY2wyI9ypmJixLWtTqKcewhFK5gG5rGAqNcjJRR37SilAq8U6vSpUndBaZq4g1FbD+BQjZmxOQU4CAYkuOv3lTGTpETs2FjbV9OWcIIR5u+z/Pz8nmGXHwXOeEjANa/uDH1IQAXZQbYGs6zfiE1ftqnHdtmMh2f6UtQVEsXS51mcCr6ETCJa4clwydeNwUY3FxrIzKZe1ojSaj8Ya3jECjbX+TeIy2Dkb0ABp6ptWUe/r3Zt8Fxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqMOt9UR4Nu+hD7zvVuQmRP9Z4ORnMa3A5tWNXxUUmk=;
 b=Fz2jwYGs+f63X6bA6pC4z13RL4yWn25ZZ1zhHpG+SRM/eyX1Ql6E0vklcZEJdo/tg0/4Fx52+XI0BiphnO5Ev5yrQdkFSL/jE/iCiAd6wKi4ubgJ+gfgERDUp8IycnrrzZ0feVEVdFPW2Lhq2g5Xgh+y2AlxMh508WGFLIUWkcI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB2760.namprd11.prod.outlook.com (2603:10b6:a02:c0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 1 Oct
 2021 00:40:26 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::4167:f9ef:19b2:eaff%3]) with mapi id 15.20.4566.016; Fri, 1 Oct 2021
 00:40:26 +0000
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
To:     Stefan Hajnoczi <stefanha@redhat.com>
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
 <YVXlQIt/oWQlIupu@stefanha-x1.localdomain>
From:   Sohil Mehta <sohil.mehta@intel.com>
Message-ID: <d0e9d6cd-16ea-173d-36ba-24ab814553b1@intel.com>
Date:   Thu, 30 Sep 2021 17:40:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YVXlQIt/oWQlIupu@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::7) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
Received: from [192.168.86.37] (73.222.31.188) by SJ0PR03CA0272.namprd03.prod.outlook.com (2603:10b6:a03:39e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend Transport; Fri, 1 Oct 2021 00:40:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5011ac40-95c7-48d9-d06b-08d984740f93
X-MS-TrafficTypeDiagnostic: BYAPR11MB2760:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR11MB27602F56DD92054D634D0096E5AB9@BYAPR11MB2760.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zazQW2HYzw9/ERTAOc8Gr4pxyTTRnA93WCMNgSSuGA3gialiXsAy6by0BFTI+03Wxt0K8nu7Bq1j8S5oXSPvmQiDYnMiCmHkY5zK3VZnxqita5WzXB84lV9Eu8nND74x29LbqRR4fPrebXZqfGFkQ7rXBQ4CrNW+afIYne7YEkne//K0vvM3WNYLp6ni8h6TgUD7u8DE/ORaaTasqGyA5ZJbk9C0uzVPcBqrLNOy4/dh8K7+FXrsIMKExAeqcHN1wmOcofH87J4FW7uvoiEUYlmYTJ2Ue86i2cG/xyMwOUSiwqE4GdvRqyC2xxfATZueqjchld5CBnahcTG0T+tx9DK0/oZ4T+MGTbJ2Q8cI7z0+ZKpiL1wo32S6FzH5zS9t9mhMHGm164NV0/anpAvKKoxSVAUFtBgekTWGeMB1nZwXsxoaxpN95u070M4WRcbqkd8JaGtlWcNhfN7Ie3hE5mVgtV+MWarr0ou8Ru/3Lee54LRbpCOilaXRBa5ZzPWmBLzhhi4h69MISA3mjDkr5plwKV8zk11FYgGxTT5ZY9FNUR4Rju+LVZtOrusKboZ65Aj6fqA7W7Qo6OogxtB1xtin22AzO+K2194p7+KgDXUvqCgUN8V9Xdyl3xh21wXRl482XW1o/F51HiV9T1uIHHejGrUOGBmogotz5fzXSpZovbX65fJZPRqH2j+y+dHvTGed55MhniID/T4/gsKJUVehEL//E0HE7zDSkN+PTHDdVUMZJWIrsutZutgLPgwMgIhY5kCuUvoVRfl8BtapmiElTDMJhaI8RJ010fOnS+tjrc3T/iIg3LR+P1pASUBt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(316002)(16576012)(36756003)(54906003)(86362001)(8676002)(508600001)(83380400001)(8936002)(31686004)(5660300002)(956004)(31696002)(186003)(2616005)(6486002)(966005)(26005)(38100700002)(2906002)(4326008)(6916009)(53546011)(66946007)(66476007)(66556008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?HI0rd6/EGpvb7asDPWAPwYaFkxRXRlpvMaRo1gSxY9RBDFXw5EmN7Uzs?=
 =?Windows-1252?Q?uP617BRfSCCaktcb0YA6x4OSHDARWOTX20hambzcfA95+h8zDXIzsF0v?=
 =?Windows-1252?Q?Zi3yteKDICcmvEb04hz1uVxtERcNVEn5IKbeyx1NmPb8PHa6FUEF3/C1?=
 =?Windows-1252?Q?yQaeUngIQ12krMcZh35p9L5A6wLvEDnDHVrqpWI5yWzZGziCPsNrvj2G?=
 =?Windows-1252?Q?oxo68cePPbSDReYNk3mEzkpfhLNOfzw2V2cnKgPNmDue6vNpTsTSOYBT?=
 =?Windows-1252?Q?JWG/uEnamjgLU6F9o2MpsLmQdz1Ou6UR96JniJlT8YKJAS16QKHGUkXd?=
 =?Windows-1252?Q?Tjf8s8X/vWvEJEj9vbMpHf/I52KDhlJoZr0rz2lIX2XBwVFDx1h2zKq0?=
 =?Windows-1252?Q?XCIMPPvnLfp5atj6igFg1oIkRQ3stjEJ666PUk4uDzb/EQSyqBxl6SzN?=
 =?Windows-1252?Q?BhCw8iqOU9qVOWia6+ZvPQ8tzYw/oG/XdR8UZnwH6HzZfrDgYH7r30iV?=
 =?Windows-1252?Q?QfjMKsy0GdJb2NkbrRe74zUNTO/JrCKHvIKRSery8Sge+ecxpihz4ubT?=
 =?Windows-1252?Q?Td5pieh0T2YabUEIyyuz0/fiSjBhb00Lok76dDculQCrVp+xSy8rj+R2?=
 =?Windows-1252?Q?2nuHLnGD0AJyAPzWv7PrQCLAhElzIrHCGojRGWMZl+A7zIu1YBPONvOF?=
 =?Windows-1252?Q?tmmoyU+D3tLk4pfjL77GMqofl/xtrNd9yhMZQRS9K996KYjyifZwp7I9?=
 =?Windows-1252?Q?RK+IWL1ftBABeQNJ/EZVy+AW3pbLg+Iye461iJNDOnXz7bupwRLJxxVU?=
 =?Windows-1252?Q?+yI3bS6xUpWRbuBTs9sIXMpJaSr6JUGWevPbSroOnNkIJsoWzt17EB2Q?=
 =?Windows-1252?Q?TMWyEiGaUe5iMswnxniqaSMBQZe9VOs+11DWeTcUQ59BUo0aSIzBPVmT?=
 =?Windows-1252?Q?TgWrzXncLFSdaJSwAlkUVFqC7R9M2pbkQGOvnZ+/SGZxwjLtF7GF8rIK?=
 =?Windows-1252?Q?u/xqdeQFcllyNYQScgTlhDhdE6jyVqHN8xlRDn0TZgK3zpNUro59VV05?=
 =?Windows-1252?Q?QiW4Cj5EntatLPIArk8ntk9gio97DqseeLU2BsMsJfpYr38I0HpWBuc0?=
 =?Windows-1252?Q?Jy3WeacPo7AwybHb3hdduqzBjc6YFUy6hlGTgjQkEGU4C/qJyyeZaQPq?=
 =?Windows-1252?Q?yeDsggapk21abCS5I7/24/X7VIrtm8b56zRveJOX2fphAZsu572ia9xF?=
 =?Windows-1252?Q?v5tGnYZVx2mY3GSEbsWRdN6mwCG/M5u+wyOhaN6wxj6ExM4M6tWCC1nf?=
 =?Windows-1252?Q?YykAzlFcuqUR941+w1L2jEzDTprfHPHaETz6xzh56A/QrqdrJ/XyQ3/2?=
 =?Windows-1252?Q?ghC8Qvis9orWMlAytxjH2Z7bDwkfQZ7OHYfQ0HXdUZY8BD+BAduJas5b?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5011ac40-95c7-48d9-d06b-08d984740f93
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 00:40:26.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OnjXpLwYwp0fmiglsSVEgESwZkoQjQW6x7UTLHL+GljOw5+SaOkzzNycqImj9UxXpbyYpKiBGf5C6RZJxa7bAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2760
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/30/2021 9:26 AM, Stefan Hajnoczi wrote:
> On Mon, Sep 13, 2021 at 01:01:19PM -0700, Sohil Mehta wrote:
>> +------------+-------------------------+
>> | IPC type   |   Relative Latency      |
>> |            |(normalized to User IPI) |
>> +------------+-------------------------+
>> | User IPI   |                     1.0 |
>> | Signal     |                    14.8 |
>> | Eventfd    |                     9.7 |
> Is this the bi-directional eventfd benchmark?
> https://github.com/intel/uintr-ipc-bench/blob/linux-rfc-v1/source/eventfd/eventfd-bi.c

Yes. I have left it unmodified from the original source. But, I should 
have looked at it more closely.

> Two things stand out:
>
> 1. The server and client threads are racing on the same eventfd.
>     Eventfds aren't bi-directional! The eventfd_wait() function has code
>     to write the value back, which is a waste of CPU cycles and hinders
>     progress. I've never seen eventfd used this way in real applications.
>     Can you use two separate eventfds?

Sure. I can do that.


> 2. The fd is in blocking mode and the task may be descheduled, so we're
>     measuring eventfd read/write latency plus scheduler/context-switch
>     latency. A fairer comparison against user interrupts would be to busy
>     wait on a non-blocking fd so the scheduler/context-switch latency is
>     mostly avoided. After all, the uintrfd-bi.c benchmark does this in
>     uintrfd_wait():
>
>       // Keep spinning until the interrupt is received
>       while (!uintr_received[token]);

That makes sense. I'll give this a try and send out the updated results.

Thanks,
Sohil

