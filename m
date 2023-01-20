Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3CD675BF5
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjATRsy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 12:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjATRst (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 12:48:49 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCA86FD10;
        Fri, 20 Jan 2023 09:48:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbFUiC49x/OJ30zYJ7iq2zM5H0+0xysg2Hv+KixjHQQVtc95vdYyKyCfgUFbDnBFqsvd54WPyzxwEDSZe+JSVg+9vMaewr1JWcCEwEcaYavN1pya69y3ppeHX2axsaSy77oZTY/lXfIUI1de/YTGEci+SUOFwiP3buR+eveotGvDbbeJpqyXwHzgGV+oVVCXRFeTbwNwqNqH5RAsZuKiosRtBO0cnnTzABG0cZbi6vepqVz894TaM7l1uq7lWbOIwPGmqMA1iQ8rs3Qv72O/J8251BeIk1plMUpEfeNi/CH/sGeaXwC34ffwt9eHZNSwLndfQDtKXBNXE8CwqGH0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DezuBQ3WveODtuy7UruZjCHwcuP6jyUKWJu6mpJaBFg=;
 b=ZrVV4WbDJLc6txYhSsqMbfKx2HX6a6DmJRwEn5txDnZPVoXapD/N9MciWaiiT8ZAHltUoponuxvOHod0A8TDHbcWVn4/bDJBdVqxWjGmureptlL9bgf1ZbFviStAuhYYURFfmh2SjNzCClARNpPLrVoPFMLz30dbwVG5cHtUjcxbrzppHSD5uwnHf0AeMsdt+QyV3r6p5PHtrj0RSE7+KaGByzRQDTZP1M8sYzjKspd62Me0bByWU8E1i/dTbEUNUCBXxUGdRrzG1AletCYUD24bJh9pqtvq2YxH54XcQ+0V8lN7GlXHtlrv4qokNTXEzYeIzKcnjMqxea1ab+NGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DezuBQ3WveODtuy7UruZjCHwcuP6jyUKWJu6mpJaBFg=;
 b=D6yGKeFgb6p23OJLZzLG9WOcVQAqxNkkkRuO7LKWeu9Fw1GNGqebslP4UHXt53YqMqhCZUkCwxL+xS64cRh/gicb2Sz3E+JdOvbEaiUssehtVgkxjA/CxlOU1oBTXHHiuQcvMyo8nxRNYrtuZ6xuA5ZU4N9V69alFOizjkFaIHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 17:48:33 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::cb0c:2b31:6f3f:12a6]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::cb0c:2b31:6f3f:12a6%8]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 17:48:33 +0000
Message-ID: <eeb060d5-4a90-ee92-91c3-af94a57a2859@amd.com>
Date:   Fri, 20 Jan 2023 11:48:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 00/39] Shadow stacks for userspace
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        akpm@linux-foundation.org, Andrew.Cooper3@citrix.com,
        christina.schimpe@intel.com
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
Content-Language: en-US
From:   John Allen <john.allen@amd.com>
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: b8465f3c-eb16-42c7-ac34-08dafb0e8c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /k5sLPtKY0EFFl0idm0QzkYOFFJxQ8vJ55SrthoULcPGHMkorOi0bD+dIOFzyaV4aAPk0+M1P5zAy2IyEJVgJYw1NWuXVZNudDL8Bg4np1idrUdwS1dPZVmYQF6EfBAdUXRBLyp3EqcKU7HDFpj9MAF4TKaVQXu5bGciSI57zq51dBXxKnYQ22xnNc6ytrzl69vlh/q5amE3yj4Cg/SC4bw3LVw7G/AcVTgf+EsVLr9C5z7xRBq1eAtK0jeVhNaebhMm1WLE6euLhhC2y8QsGpm+imqg6/6/kbEUV6JlAq+nMSN/+gVfIG1VD9RTV2ZoFIgnwyfxlafG3xybo5E2jDjAm0pTJVnagJVKNQzk3iG9xKZxWL6RlsGxPT6AOieoFV2AGhq38LDjvMandofDDahevJwZ9PpEIQ1ul7W+9NqaZdXke5P7OKqPGkLZaWjaCyM1YFHlVrI75OAXSU0cOyzbwNdR/8ZIe1Dzl87IjmSizbsmE1RIZf3rmRv7DeEzwDfz+S0V+06cnqoitGETyFMT/RxZP4J5m7Qa00TTpTNSobHLtBxu9X1WVA/yEPYYbJspgb43ZwcZcdQTx76qyfE3EODddUXvpkB0/fN6hrR5qVvSzC4naGUVS6uvIJQ0nkYvEh8xLJ8UMahTOe4XCmJ99JSbKL+KoTsgMUXpW513Gdr+3xF9Ip9V5bwlg9vAChTkvEHQ10Q1HyDELIrlk8LLaSrM9e8RqeQFJEzxmoOYCCyVtXl8U+q/xt1GATCsondKx+WpgdAZ/EW4OTC93MsNQb/xD1OOUObikBskVEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(186003)(6666004)(6512007)(31686004)(478600001)(26005)(38100700002)(110136005)(2616005)(6506007)(316002)(8676002)(966005)(6486002)(53546011)(66476007)(66946007)(66556008)(41300700001)(8936002)(83380400001)(2906002)(5660300002)(7406005)(44832011)(7416002)(36756003)(86362001)(31696002)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNaVXhNaWtmYnZTVUtXN2R5L1lyWEpHTVRkcFBpMmNMRlRWL09HUUx2RlFm?=
 =?utf-8?B?bFNwTisweUUrdWFDSGVjQnhTN0UvTjBLSnIvdWVXWlg2RXBxUThzUEdIMDNZ?=
 =?utf-8?B?MkNObzV2TjgxdTVLYjNIT3FOeUlzQ2dZTEk4L2ZaOEMrYkVCY2d0MlI1azh3?=
 =?utf-8?B?MjRDcTJvN2NwN0tmWERqY0x3Ykk1R3BzRFloYmxKMFdMZXNWcGFzbm1EMDZp?=
 =?utf-8?B?UStxNU1FT2k5a212bVhhQ2FoNk5mS0swR2IxeVVtRUpjb1FmU29BTHdWaVhV?=
 =?utf-8?B?Nk1HeWhqTUVNNVgreVhwemY1SUh5QVpkb0Y4V0FlUk5LUzMzdHlRcWtIRGk2?=
 =?utf-8?B?amdJejBXREFNTkJkMWNtVWNqR0oyMjJnV2VWMEZWa2MxS004Yml4MkxDMEM0?=
 =?utf-8?B?MVlzM3hqdVVKQUhRcGplZE54bUROUzZpa01VWFlZNHIwRGI2UmJZWGZXMFZi?=
 =?utf-8?B?N3oxbFRqRFdPeWU5emJBLzZtSEU4cDZZS09uU3hNcWltSHFYSmtmRkhTZkJk?=
 =?utf-8?B?eDVlaStxSVlMa3BXTnFVcVNHVDBmcHdqL1U4VXc4b0xObHFibGtNdDVlR2Iv?=
 =?utf-8?B?Wm9Ta0IxNk1jZ0ZhUFlzMnBHR0ZqNDRLaXIwcVJPZWJEV01EUUtrWURUZ2dO?=
 =?utf-8?B?THhFYW1ZR0ZiSXg4akxnVkxTZlV5U0xVZUZUd2x5NTl3MHE1ajJuUHdCalRS?=
 =?utf-8?B?QnBJenpUUnJWTUpxakQwdk40QVdJbk0xQnlrSG5wd2VlUUVIL3hGZDljK2tw?=
 =?utf-8?B?eTExZW5pWjRpbWk4SVU2d3dzSndFVFd6WGRUQXNmQjRJdjRmaG5MeUlzYVE4?=
 =?utf-8?B?MjR2TkN3YXI4ZHk2Yk5SZU1KNjhrN01ZZHhLVjI2bjEwNWVFWWRiQ0NyRExz?=
 =?utf-8?B?cmtxYmNtWGUvVXRBWmtkR0pCVG1kZWtCb2o5cmVBM3ZhMWJraGJUQW1ydmlB?=
 =?utf-8?B?S0VLd0luQUFpMUNKSThHUWRzekNsS1dxU3lVVFhWT3lzRTRLUmdBbS95RmVN?=
 =?utf-8?B?Q2xOQkxVVE1EWitqZFdCYXcvckZ0TFhtWnlubUlGbEE2aTJ6TjlFT1ZXZ0dz?=
 =?utf-8?B?ei9JMnZ3b1hMbm1lTzFyZU1ET2xFaDNjeXlCWm4vVDBENWtiREN2YUtzZzM3?=
 =?utf-8?B?ZU9nc2RBZ3BOQnpYL0NoYTd4ZWJ1dENlYmlaNThFeElpNWVxVytaSFEvTnNW?=
 =?utf-8?B?SGJDWmduaDlMZ0tSNnhGdkNiNWVGQ1VUeSt3eTF0QmJFV3JkQTFSV0hXSzRz?=
 =?utf-8?B?a0lxRk1WTU5BYVQ4cmExR3ZhR1pUU2ltYTI5TG5haFBSblZnTE9KemJyYmVW?=
 =?utf-8?B?OVUxZEM1SS9UUXpnYnZha28weGk1ellab1BmSXl4OHlMNFJ6cTU2K3ExM3hE?=
 =?utf-8?B?dEQwaVBpRU0zRVQ2MisyNnkxbUtrR2lzc2krRnVmMEJDLzFWYWhvN1d0Y080?=
 =?utf-8?B?WnpjVGpqZXBPMWJEZ1h2Z0FBOFI4TmYrRmt4T0hvL2o1UHY3WmwxaG5NeGZP?=
 =?utf-8?B?bHJrSjd2S2RnTkJiSVVxV3VCSjBmeExkcGJvK2xnQXpSSWl4U0FZdVFRaEt3?=
 =?utf-8?B?eGg2Q2FMMjJ5MFpCNE9kZVZFWlAwaURYRUdCNTFrTUNNcTNoSE44b1VwV09B?=
 =?utf-8?B?eXgrTXJCazhIdmozYVlxNmxHcFFyYWZ6b1JrcStaellQS2pGTHltWmc1WTlt?=
 =?utf-8?B?TzM0VU04OEN6ZHo4YXl0Ky9ZVVFzNjltcjNNSFNiRVJ4dHU5blBaQmFIZEVO?=
 =?utf-8?B?dWtHQ0VaRkpzOFl0LzdQY1Y3RGl5ZVRlczY4eTlMdG5iWkpKS09ia1JPSGl1?=
 =?utf-8?B?ekltT3diUERWeWpIZjZGRnp4R2paRWJWOFpQb0ttNlI2MHJYbmVMWFJJbWlF?=
 =?utf-8?B?ajdPemRvc3o2eCtKdzZyZC91Wko3ZytPU1A1YXlESytzYWVMWlVjbkRRVFZu?=
 =?utf-8?B?SUVvbTVaQlBDZ244TXZhUGkva2p5M01md3JXYUdUUnV1RkFpcVRlbThTUVpx?=
 =?utf-8?B?dVVMWUFQTXQzTTR2WVlZWmJiY0dONldmSkFHVzBhL1hacUpkSGhzeFZuKy8r?=
 =?utf-8?B?WHlBamhOZ2QzRHZpRmpxdndlVGViU3g3TU5sTEJtaktoZzBENzRBZEd5ekZh?=
 =?utf-8?Q?JF00rPd5FiPCocWcYhqMmd1th?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8465f3c-eb16-42c7-ac34-08dafb0e8c8b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 17:48:33.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxzbH0TSmJQ7uHZFw9DcWzpTfUEIvCTVjzR5ZWJJMCFmL2qGwyq/1FGGmSdnh8PxZvrldF32HXMYG2Bqz+6ZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/19/23 3:22 PM, Rick Edgecombe wrote:
> I left tested-by tags in place per discussion with testers. Testers, please
> retest.

Re-tested on my AMD system (Dell PowerEdge R6515 w/ EPYC 7713) and it looks
like everything is still working properly.

The selftests seem to run cleanly:

[INFO]	new_ssp = 7ff19be0dff8, *new_ssp = 7ff19be0e001
[INFO]	changing ssp from 7ff19c7f1ff0 to 7ff19be0dff8
[INFO]	ssp is now 7ff19be0e000
[OK]	Shadow stack pivot
[OK]	Shadow stack faults
[INFO]	Corrupting shadow stack
[INFO]	Generated shadow stack violation successfully
[OK]	Shadow stack violation test
[INFO]	Gup read -> shstk access success
[INFO]	Gup write -> shstk access success
[INFO]	Violation from normal write
[INFO]	Gup read -> write access success
[INFO]	Violation from normal write
[INFO]	Gup write -> write access success
[INFO]	Cow gup write -> write access success
[OK]	Shadow gup test
[INFO]	Violation from shstk access
[OK]	mprotect() test
[OK]	Userfaultfd test
[OK]	32 bit test

Additionally, I could see the control protection messages in dmesg when
running the shstk violation test from here:
https://gitlab.com/cet-software/cet-smoke-test

ld-linux-x86-64[99764] control protection ip:401139 sp:7fff025507d8 ssp:7f186e017fd8 error:1(near ret) in shstk1[401000+1000]

Tested-by: John Allen <john.allen@amd.com>
