Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A33D3EA6
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jul 2021 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGWQsQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jul 2021 12:48:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:41899 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229808AbhGWQsP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jul 2021 12:48:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="192195228"
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="192195228"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2021 10:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,264,1620716400"; 
   d="scan'208";a="416410553"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 23 Jul 2021 10:28:47 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 23 Jul 2021 10:28:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 23 Jul 2021 10:28:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 23 Jul 2021 10:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjHu9WP/6huZ4YXZyVjx+LE2WVk3P6TTT5/Bl7hMbykgE8W2TEPLZABHSRG69ngrYmygpttgxak6usuAXRQS18G2R3Bux8fK2UKLZ55FDxAeeMOl8W+nT29oUADx/0sAAEhLkbSuOhIyTUSR2L7HezjKTzRz/I3whptQtJUsvxKlLeWglhROAs9Qzj4lm7jNTM4R+R627zIBFxc3tLgVvkSpOy7Gd65ghU5NK+0KDIpDRQYG3T8Mr8FPQJpUzpLuWqTSHBjwLuaCVFWJGb2BIod9UKrXul8qjQ59nmrR4dai0naOa6EAikfFl+6NAi5IDNCPRMPyy7dBgSvi+8G/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXiRLb0cRX1+XafO/zfgwpHbRp+9TR3jMatMoDmULsI=;
 b=aTYjX0WDx57zko74b24biBYaBExwnCcpPnYbRdKMeiURA/pUvsglGNvPoQ8srFDOBQbaWatk30wff//iBc8pkw2M1As/gsdzhqt7Qfy4BuBYiZy+H/yGjQj+UVhZ0yFSo3Ei43c1tIQaRPUijSx86Fn+RvVNVIad2DkxxL+bMMMq4iCFhQSylxOhOEC4PPj9iZEj20wMFeMpDwlwLmt2yZIK8vBBQmjpPoZHY9hyiRWTFp3/o/LSAhBhMGAIgDC1MMsYyw94H7lmny+DAcqpbQfmXSIxUe4kSEte7dTa26eHWywwIGYMJM9Y9GLuDqHSFEBd3k6Z37F3IDmYTr4uSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXiRLb0cRX1+XafO/zfgwpHbRp+9TR3jMatMoDmULsI=;
 b=k+pQx+FUPlGvLTiP4HfQKYU0ERvsfH/TXCE+i5NUB5MP1dtCsXfJwffBjVPyKZuDVtS03NEBf0mzPHzqBpYbdWlxuRYcx1gPLHbihGufWbydsfn5kvVCDHkmk6QeDoek1jT5THd+4DxES0RSu8OiCwhYgpaBWzN4GxNn220ecZk=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Fri, 23 Jul 2021 17:28:44 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::b5d2:99f4:cd51:f197%4]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 17:28:44 +0000
Subject: Re: [PATCH v28 00/32] Control-flow Enforcement: Shadow Stack
To:     Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eugene Syromiatnikov" <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <dbad8677-bad3-a940-276b-dc2b6abf8b28@intel.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <0bee5718-eb3c-3563-9736-287584fed949@intel.com>
Date:   Fri, 23 Jul 2021 10:28:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <dbad8677-bad3-a940-276b-dc2b6abf8b28@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by BYAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:a02:a8::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Fri, 23 Jul 2021 17:28:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6da1f774-6fed-4191-45d7-08d94dff5245
X-MS-TrafficTypeDiagnostic: DM6PR11MB4642:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4642FC1818F5F8EF423393FCABE59@DM6PR11MB4642.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjQRjqGjms0Lnhu7WbODr9Iek4M3MjQeTSu9Zvgm6Y01Fp5CLPbjO55H205t2Nl24gEqUM+uT2TmpqFiiWvJtniVTZYxSmSKuuB+EMDLf4Wkiw9r4BZo9CwTZOhr9hiWyCrwWjRupEnDrq5W4Pq3eIU5z6iL3G8fWoIjsgIp6naEr1EP2WOxLgs+84VkpxP4Fr8EfHOGreWlv5x2vLGXianwCQ1fmgSj8eH4M4H4oOP2BNzrP6NkUTkfvmSxnLaYIG1/LoJ4mzGJNqXHcorvg6CtE7f6ZrN65tI7nWIFzP9ODjSDzKmbZzTDogYbpoUlFPUiWxGGk9sitGWl/bRc54XOfhTB/AumXaPEXfw9DLqr5wcMSeY0n8+VhM5z9Zwcm+K3eUAUTFk/YoWIGi086LDQjbJqWTN7/qWOYSGG4ywFbGMOLgj8eNFhCDI1F/BGRm2pHAW4uld/JdyZBymSX5Ah1f3pzAsn6GDasfzCt7M0XoJm3aaW+qBCc+Nf0rQOsxiHvyVr0lTNDLV1mZWWREa+kk9/CpfUIssfiOBCo272JjjclJO8QWjpN8QYVAGbzOm4WYp3z+6DtstZBvNIfSERcUq1gi3iSZr2mitUVIxldUYU8+3KdT9zKs5cVnmWAlpESbV8vUvVDtnLcRWJLVu46N2XGYYZrjB20XoIpTUPuJH3rT+Tvwp2Oddhoo0afuZIIwVlkdYs86K+WUjiut/aIqSg/M3K1BhfCE7dldIUkghEczVvQuvCptg1K6RH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(2906002)(110136005)(2616005)(956004)(31686004)(5660300002)(53546011)(16576012)(36756003)(86362001)(83380400001)(921005)(8936002)(478600001)(6666004)(31696002)(66556008)(186003)(26005)(6636002)(66946007)(38100700002)(7416002)(6486002)(66476007)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9JVmd4V2VIeXFheFZhNlhMR0t3QWlSc1ljb0YrSU4yc2lnYlBXVG04eloz?=
 =?utf-8?B?YmkyRFptejFhbW80VFhxMTJmL3dWaUcrRWlDTSt2VVk1enVvSHNCTkhQb0FX?=
 =?utf-8?B?MUdyUTZKZGxnVEFKZVE4bER5NTB0TkJpclVjRGl4Z25RNVYxYjdSRVM2Z1ZP?=
 =?utf-8?B?TXBFeXJHbVk0dHMxclFIMUM4VGx0WjFBQlJFamNuTkc2eWxJdHYxbWJMbTFT?=
 =?utf-8?B?Vi9EWlgybGkrOGY4NDl1UXVFWUFWRUJjbm5uMjdEdXhoUVFEZUdxS3EwaVA2?=
 =?utf-8?B?WWJCc3NtYWhUcUtsSWJvajNFOWtNUld6Szc2YWJnTERXUkFiL1ZGaFFFUGZ1?=
 =?utf-8?B?blFLY0t0OWlZazdrWmorSGxEemNCckF0VGpRM25EVy9Nb2llQjkySmpjalVC?=
 =?utf-8?B?b0VncG8wQkU1cFBPUG1mZ0g0eHBtR0R1RXRvSDdwcXR5V1JOWnpLSEtmejN2?=
 =?utf-8?B?MHZBU283WHNjcGJtM0NCaWtIU0lmc052T0dZd1FSMU1JYXpRNldJL0pWY1JV?=
 =?utf-8?B?b0FHRkRKSG1FUTU4UVBEc01qaDF6ZTEvN0twRUplbGh3b1VKNEp4SFpOaFhu?=
 =?utf-8?B?eGxWY0FudkZ0NDZEYU1tQU05S29oZEw4NmptajQ1cit0Mk1Wd2IzWXpqdGJ5?=
 =?utf-8?B?enBQT1RqOG5BZmZtT21ac2R5N3RTQnlYaUJPZ1FJb0x3RmJZSUR1alBSenVE?=
 =?utf-8?B?RDlxckNFTm1GZWpnN2NDYVdxY0hLTjZmZ0UvQ1ZaeWtaVGIweE02L3VHLyt4?=
 =?utf-8?B?aDVCcFplUTZuRWxrTldneU9NK0h5QXA0YThPYmZRNXZmanhtOWlUaEhDMzlH?=
 =?utf-8?B?OEtRRUNLcjBKR3dQbTBuTkFoeVhLMjh4VU0zL0xKTzE2SEhmaVorWndZT0Fj?=
 =?utf-8?B?cXd6amRwTnNJNTlIWW94ODdjb1ZrL3BBdW55NTdsQms2d3A3dko4ak95S1Rj?=
 =?utf-8?B?TzlvSkZQN3BpTW9KRDBuWGlkSml4Sjh1RGxrTlZ5ZjdiK0huWWUzV3ZUS0NI?=
 =?utf-8?B?SWxuaDdqbmY2RDU1Sm43VGdOZTZnSUtTRWNURXVhQnRmb0JaRUdkU0k3MFFT?=
 =?utf-8?B?S29yY2lTM0ZDNnFkdmFWTFgwN093eUdxdzJXTnJiZnNkaTYvd1JnR0poNXJM?=
 =?utf-8?B?bUF5Q1hDQVlWeXNrcnkrVmN1aGsyOVdIWml0MTVrbTZpRm92M3NjVnprUWF2?=
 =?utf-8?B?ODZJYVVUTlRGRks2MFFqSll3WCt6ZnZjRzNSano2cVJCZ3o4SGdVOW9yWXBm?=
 =?utf-8?B?MzBYdDZhVnB3UWpyNkJYV3lMM2pmRDB1aUp1YnBHRVpRT0NudzZuTXpDTkw0?=
 =?utf-8?B?REVyY0dLY3dPOUg0V0RheWdIS1NsYmFaSytJOVJhWHpIQk9mMnhSU2pNQTBx?=
 =?utf-8?B?QXlidERtTHpWbk5TSERQVCtlWGZ5ZTdnWFBEMmNoaWRpbWs0MWh6ZXBTeDND?=
 =?utf-8?B?SlpSTmxOdXFCbnB5MS9pczlTdHppYVZ4TmRZTzJ2dnlsM0xTeExnc3luaExM?=
 =?utf-8?B?VUxhZFJhSVE3SmlneW4yNmpTTXBHVHRhNlh4VGt4b0ZQOHRubTl0RkplRk1G?=
 =?utf-8?B?UkNYc3M5enpEQUwvVE01czNRNzIrWDA0cnZzVU9yY293akRkT0pockZwOGRk?=
 =?utf-8?B?ZldyTUdQYUFMbVVRYUhJNjE1aHhxVGVhVlZoQTQ0eGJaWVlIYXpUOHFoL1VC?=
 =?utf-8?B?OFFoSWxYMVgzSlJBNko5RHBrODZPcUFrZXlNSGd4UjF1czZ5d2NEaHRpZ0Yx?=
 =?utf-8?Q?lw15gZV/KzhCEApNoJ44K0a5TA6tWi6IxfufC52?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da1f774-6fed-4191-45d7-08d94dff5245
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 17:28:44.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYer+t3ifmfSc+UNc+OzvSQQZx1sXRYnT+l+e2sVVCFeC+jBtdp7QkMcn+T/aVjF4+m/NVg2M36eNWztOwJzBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/22/2021 2:08 PM, Dave Hansen wrote:
> On 7/22/21 1:51 PM, Yu-cheng Yu wrote:
>> Linux distributions with CET are available now, and Intel processors with CET
>> are already on the market.  It would be nice if CET support can be accepted
>> into the kernel.
>>
>> Changes in v28:
>> - Rebase to Linus tree v5.14-rc2.
>> - Patch #1: Update Document to indicate no-user-shstk also disables IBT.
>> - Patch #23: Update shstk_setup() with wrmsrl_safe().  Update return value.
>> - Patch #25: Split out copy_thread() changes.  Add support for old clone().
>>    Add comments.
>> - Add comments for get_xsave_addr() (Patch #25, #26).
> 
> Could you characterize where this whole thing is?
> 
> Are we at the point where the feedback is slowing down?  What kind of
> feedback are you getting?  How stable is the ABI versus the last revision?
> 

The ABI has not changed since last version, except the addition of 
shadow stack support for legacy clone().  This does not de-stabilize the 
ABI.

Looking back at recent feedback:

- Boris had given lots of comments on code flow, syntax, etc.  Those are 
all addressed.

- Andy L. commented on the signal handling part, especially the 
introduction of a ucontext extension.  That is eliminated and now there 
is the UC_WAIT_ENDBR flag.

- Kirill commented a few issues on mm patches.  Those are addressed.

- Peter Z. requested splitting shadow stack and ibt.  That is done.

As for running/testing of the series, overall it is stable.

Yu-cheng
