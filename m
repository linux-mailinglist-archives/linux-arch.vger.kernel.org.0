Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5023EF1E4
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbhHQSft (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Aug 2021 14:35:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:63533 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhHQSfs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Aug 2021 14:35:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215893890"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="215893890"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 11:35:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; 
   d="scan'208";a="680461168"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2021 11:35:14 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 17 Aug 2021 11:35:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 17 Aug 2021 11:35:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 17 Aug 2021 11:35:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 17 Aug 2021 11:35:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfICisjof6NRnn2lPD+9Xmo984hEwRC2c/zURW5ioTGeSHSj/mv/RUHRSWkHufRI/WCADdGUQzOOSWiK3mQUz60djDbTGVrkPCW4YvZ8ETSfyQrciPht09njaB6AGsACvATUpnjyMoyBDTE0q6byK1/Lk60s6IEDtpce7W3/R7/UHacIQdqnbjxfWUd/40eWD6yLb0lycrfQU9uq3ftaVyQsNKBmoqmwNoi7P/J5HxSBzmhr6LDoDZ97KAhyMNLNpTBugOyEsJFDOL6QDHRcLIg1IH8mUsbEOdl4GvEYuh56X2EICvdXNZ3u69LbVVZyI99jUevVjMQyADpebIIm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfnNJZ9RigzeSMlF3W4NXj+nlOLMnGXCOA2F01UqqFw=;
 b=ZM2pMerzfZ2SMSU+LMJpJIcmVtFRcd2S181xA6eVvByhWQbTrG+UfGRRfccnt+mAY9e28t3yy/qtY6oBSW18g0O8YnXEVV/NGfdPmrADFpM49aFi/1mb3AeeQ2tdR6gBhy9l7XpPJ0f+WDNWYaFajDzrNO70xUWvDcpmSdlCiFaU+EEt9Okr5ae0njRP4+UMaxdnh3jyrqYH964iCeA257vxlbTJ9kQ7ChaMhqoO8uCk2Bm82lRlKu20f0KhSNnyZHuC6t6pKhofyveR0y1oKfuXpI1ah84K7Bcs9Fcv353zVA0jtXG7CvOzph4Kogx3Moqqha12veo3zq8p+LM4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfnNJZ9RigzeSMlF3W4NXj+nlOLMnGXCOA2F01UqqFw=;
 b=ZqkvVv7IF2Seb1M2pjqApbY5JVeat1R33kWKp6JFSHE+7Y3+epjwoyWt3JZOdw24f8nF2BkXhigT1CV96596ntU8MzPF6V5OxqK5SWN7ySWQzEGB4ZeaysDvonu0xfB0ZhOYCuYMACh8QncdRWQFYWU4JEvJjgrWwhpdnLY5nkM=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) by
 DM4PR11MB5390.namprd11.prod.outlook.com (2603:10b6:5:395::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.19; Tue, 17 Aug 2021 18:35:07 +0000
Received: from DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666]) by DM8PR11MB5736.namprd11.prod.outlook.com
 ([fe80::2920:8181:ca3f:8666%3]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:35:07 +0000
Subject: Re: [PATCH v28 14/32] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20210722205219.7934-1-yu-cheng.yu@intel.com>
 <20210722205219.7934-15-yu-cheng.yu@intel.com> <YRqT5+ggVQ1zW9PK@zn.tnic>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <45d6c772-51af-f03c-ff33-8dc5e952f3a4@intel.com>
Date:   Tue, 17 Aug 2021 11:35:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
In-Reply-To: <YRqT5+ggVQ1zW9PK@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM8PR11MB5736.namprd11.prod.outlook.com
 (2603:10b6:8:11::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.18] (98.33.34.38) by SJ0PR03CA0268.namprd03.prod.outlook.com (2603:10b6:a03:3a0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 18:35:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d652a5a2-b829-45ec-8055-08d961adbcac
X-MS-TrafficTypeDiagnostic: DM4PR11MB5390:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR11MB539040BE742B0AA56DF9F358ABFE9@DM4PR11MB5390.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NX5/cTgrovbAbxIkQBM8sFytUQPGebEpOP+IFCJe4/v1Fzuec2r7OJngtM0P503jmDRK/gyrFQQTTwaQXCSjKs1HkopGgwigRF12n8uIC5rgnZsJ4QIgIObGTAuIQqzxG5fk6eusq051w6LQL4XeIwvG+th5qEDUgi4WjLmcO/dEDUkIRAoYfBQ6D03oNtK/jeg/r37cghVGyYjZOUt9zRZRJfEd9FAVjmOM+Y3PgG5DbXOdZwm+ybrum50nDzf+HSa1J58f8h8IvvZyO4rW7UIdvB9fzVmUOKrYm7vt4B68RvKGV1+gsxMEdvRI7RITrnbdmUxiJ3XgYRu5LiLhpP2nFXNVIxEb4QyapWcj57bPIXXV2Kvipy1t4GMQ6+ERTisZty1mq/SSI7PB3PRUsCvebtKidViGXyqhhhv5MHm6Nz3fo4vn7asJQj2Kfg2K7wvgdTCnmzoO3zzUnHk1gOZNkr0TlcFmWAi+H2vAUNWQ6SqyScKeo/X0EAxTrdNl8Pm30LEoGqjgy+u7NimG3PSFvRAzyNPbg5jmyr2BiPMTX0ZG4pixGOH21IfXvaGu7qKdUsqaTp3Cp9n82D3sJqwvcE9IHehKSveB6cUKh3wKLTqhRN07ncpH5zd8kvTOeauh/tnGEA4uv1sL4ObvYkOptksVJ+xBKErBPfVqQJxy6MEiwfpS7C0rvSR3awV1da1A+DdzWKh0j6NZbrOm9Wh/OcJM2kIw2zBZj2wPEiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(316002)(16576012)(4744005)(83380400001)(54906003)(478600001)(38100700002)(7416002)(6916009)(86362001)(31696002)(36756003)(26005)(186003)(956004)(8676002)(66556008)(66476007)(53546011)(2616005)(66946007)(5660300002)(6486002)(31686004)(8936002)(4326008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCt6V3RzYlRTVWhxOHpXSVVGSmovRGUvaS9TZnJiQnVuU2c0RmxwQWxuUTdM?=
 =?utf-8?B?dW1WKzV2M0NjeHdHRUFlOS9WTHZSVmZxNEV3ZlU1WnNpWEhpcGZna2lJeUZH?=
 =?utf-8?B?cmRqV2xObjZJcG1rdTNUSnJZajh5VFBBNGFNSmxvL0tsQlZZY0E4VHQ1MjZy?=
 =?utf-8?B?Z2ttL2ltQVY3TXM2M2ZzZGJGN0g1UTRsWnNjcGlZNjdrTStmOXVZTXRFN1Jz?=
 =?utf-8?B?VnVOa2RuWGFtVW1QSUNsUmlYODNFK3ZKUSt3ZEtiWlV6VGtPQWdPb2tqT0VD?=
 =?utf-8?B?OHczNHhUTzlJM3JWMlhhRnArdis5NWRZZURRVUNRRTZMb3VnZUc5dmtueGJD?=
 =?utf-8?B?bHErakhIdUZCMGlFNmdvQzBHWVl2RE1ZZmNrb3dGdlU2QThkR04wemIyMFF5?=
 =?utf-8?B?YWZlTG5wQVl2T3pTMWpHdkpIc1BxQm41TTEzYS82TS85eHVNSlVTRVpSSU1W?=
 =?utf-8?B?VXBzdzJpNWUveGdyWmhZbzNYU2xudk9jYkYyQXJvNzZ0RVBxVGlwV0pRUVlo?=
 =?utf-8?B?NFM3dG1WNjZNd1VyUTBUcTFvaFNaQlp2Q3Vtd09FRjB6dWxjNTRhazJhK0tw?=
 =?utf-8?B?TGpyV0RtY1BIMXpTaU1QM2lQekoyYTU3VHhDRGw0UFRHeTN3ZFpzYmw4OFBt?=
 =?utf-8?B?QkZCTnloa2pJODBuZ0R2c05zUTdLM1RYNVFiNzFVZVpXbnhqM0R4blhhYVoy?=
 =?utf-8?B?b3M1d29BSmFYc1JEcGJoU1ZqazlVcURMYzU5MEtuNEUwRWlDSzRtUVRFNSto?=
 =?utf-8?B?cEV4S1VZRkFCcXEvUzBsV01jb3RHODgyalk2VVdRYWVwOWZBZEo3NHZtOFcr?=
 =?utf-8?B?NktYalYyWGZtbE4vckl4d0xWVGY4bUFoaE9YR2NBQUV0QThIQ2NyaHkvZHhE?=
 =?utf-8?B?S0RmTkltaXFseWJIYmxNNjVwbGNEaDd4amtROGJCVU9sZ3V3RXQ5VWVtL25W?=
 =?utf-8?B?UEdodXZFWElHNjNxemxmMUhnc21IYk5KT1pmRDg3aVhBcmxwUmhGS3RkN3hF?=
 =?utf-8?B?RDh1Skgzbm1LTEFqOUs0YU96aTYrcWx2SmlIR09qQ3ZRd2hZa3k0cHZIckZu?=
 =?utf-8?B?bVN3RXFYZVBZZVdUN21Jbys0YTBHTWJWamF3Q28yK2tGTFhVRkRQSFA4aHA1?=
 =?utf-8?B?VkhxVFZjYTQrVlBQeDdMcHRvb2hteE9HazJYeFFZSVVsSnY3U3FCeWtCL05Y?=
 =?utf-8?B?RTFRTWNNRXdtbDBRYkNoRDY1b01TbllMWTJ0R205SE5iRlp6NWRVVkVDUytP?=
 =?utf-8?B?dGtlL0k0Smx2T0N1c1ROb2NzblVKTHhBNlZyNHl6RDhLeGI2bUpuOGhVaHU5?=
 =?utf-8?B?V01RNTVDYmRSTkVOU0cvSWJNbHluaE5WSjZxNDFGdnZ0ZlRaVng0ejh4TTlz?=
 =?utf-8?B?ZXM4V2FINEdWVGRpSUxic3JodUJUMDBXb1RsdUw5UURoc1M2Zy9kRFRqTWt6?=
 =?utf-8?B?ZU15ZG5ON1ZVUkdtR3Y3Q0xlMERJL0VDSTMzams0akkwN0x1ZlJTRFljSTQw?=
 =?utf-8?B?dXBOcDFIYkRTZnNJUFFuU3VRd2JTMzJmd0ljY1lBV2c1T3JCWjUreXQ5VGJu?=
 =?utf-8?B?cFcvNTBwTldNTGY0dHF0alFPNnN5aWdYOXVTT2JVbjErbkJPemR6THltbHFh?=
 =?utf-8?B?VDE4TW1JdXo1eTU0Wk5TbEE4UXE5K0VhZll4YUZjc2xhZ0thSUR2NmZkb0Vw?=
 =?utf-8?B?cXNDWmpPb3FXNE1TQ2FYUStOaDhHcjJqdjk2UlhFSDlaQWVwS0ZmU1pyTXpj?=
 =?utf-8?Q?oIxepk/LSuDGW5oisMFwclGv5elL0LpFhTrzKjt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d652a5a2-b829-45ec-8055-08d961adbcac
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 18:35:07.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnsHmPx0PzCqoinLDNsBfqf0r63EiAhazuIOgykrOuoyE0YNfM0iUC3050hc8/Zlnt27l9MDj+GZn1gF3Tp77A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5390
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/16/2021 9:35 AM, Borislav Petkov wrote:
> On Thu, Jul 22, 2021 at 01:52:01PM -0700, Yu-cheng Yu wrote:
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index eb97468dfe4c..02c70198b989 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -662,6 +662,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>>   		[ilog2(VM_UFFD_MINOR)]	= "ui",
>>   #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
>> +#ifdef CONFIG_ARCH_HAS_SHADOW_STACK
>> +		[ilog2(VM_SHADOW_STACK)]= "ss",
>> +#endif
> 
> 
> ERROR: spaces required around that '=' (ctx:VxW)
> #109: FILE: fs/proc/task_mmu.c:666:
> +		[ilog2(VM_SHADOW_STACK)]= "ss",
>   		                        ^
> 
> total: 1 errors, 0 warnings, 49 lines checked
> 
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense.
> 

I will add a space there.

Thanks,
Yu-cheng
