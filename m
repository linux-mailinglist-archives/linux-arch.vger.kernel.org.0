Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5016869D892
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 03:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjBUCiH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 21:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjBUCiF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 21:38:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377882333F;
        Mon, 20 Feb 2023 18:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676947051; x=1708483051;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pJYEIgNOCbjutS3bVbfbPZEsCLggPaoJ1ZLtawowN7s=;
  b=jFM9j9CmtVchmhLsE7guwMKaUtmVKqHNTWGXXEuCtjNmwlXTk4Yi4ikF
   U2xOlwlKepntuFN31QvdupSmbJjwQWpJEBc+fkkX0JFBTM7hHQyoQr5oN
   bQ6XOHWBNjDnJeubpSisWWRfuI4oQU57wnwoooud0dSawkK3rHhwcCNyi
   ZRWUoD7QqGrHdgqqqYWQaNgFDyfjkHVJewOfxh3fR1/KF0v/4npXzsjyt
   PjaTvr7ZDt0oq460Z03Dns28vAb1kB51p8vvqdn1bp+2RW9VhI0vuH4Jd
   wRNQVGujYS0WWPxaLqEjZxBESEDkff34rLwE42yyJtBDFHB0ze3KstDZ+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="312899154"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="c'?scan'208";a="312899154"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 18:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="673523766"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="c'?scan'208";a="673523766"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 20 Feb 2023 18:37:30 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 18:37:29 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 18:37:29 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 18:37:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTrf13t8pp6l9PqH04tWFasDPYSz6xJwU10sE0RM4zLwfcft2DxdhvN4gNWlmHIi34guFQj6tLmqH/Qpl4eQmkAEeNJZ/DwxghI2sodGZpqY0SVGwGrwqjaLqldZBQ5SEsTDVbBqBZxHMYKi9XW1wR11F8H/Qp9Y69QnEgPGERc3XF6Xt7wPAL3X+gf7Zx8DA0Y1XRma/GxneWxpOLRB41bNqQkTxZhGEefJp+uB5Ky/A2y54irl/uv04y0ecjJ9O89zcQe4hSH+zDZe9GvcUXIXJlDB1TaLocisV8vZ0Zo8FV0hRAQaO6LAhBAWZHmiRxtYOANz9E72ejnb3VZlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsVT3xKBS5usxg59mGJB8ifkyhw5L/i5MKwt1cd5tzM=;
 b=mse6F2MlCk/rmWsAjpFCiVztPPZtB4YhCywD0cv6iJ4dvBZ7JRRGCN9qJDzOMUvpcAgBYREM8b9WYYLh1IfqYZ74B1nXW+s+iXy42YVWpN27geKCuvrxp18rpCkqDDTtzCWm2kJ0skm0QjkT9ELhnSkrIFNb4jxPXT8O64WYkwZMzljCdLF5G5IZCygbBSppCiHnrWkOY+h8n2YuVzADdrOF7wfJcQVQPE2j10ROFNQ9W/9el+FXk38/4eR5RP20yORwADe+yLVDZg387/kUiydEx59jbPrc0eZO/MgMUyhZBeZ0RljT13k7NQisUS0M6HVzy/CBzbehQY/dsMUHtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by DS0PR11MB7288.namprd11.prod.outlook.com (2603:10b6:8:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 02:37:21 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::e28f:b27b:4b9d:2154%4]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 02:37:21 +0000
Date:   Tue, 21 Feb 2023 10:38:21 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CC:     <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
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
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, <kcc@google.com>,
        <eranian@google.com>, <rppt@kernel.org>,
        <jamorris@linux.microsoft.com>, <dethoma@microsoft.com>,
        <akpm@linux-foundation.org>, <Andrew.Cooper3@citrix.com>,
        <christina.schimpe@intel.com>, <david@redhat.com>,
        <debug@rivosinc.com>, <heng.su@intel.com>
Subject: Re: [PATCH v6 00/41] Shadow stacks for userspace
Message-ID: <Y/QunS2skya40mUu@xpf.sh.intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
Content-Type: multipart/mixed; boundary="gkqNPeSovw7GjVb3"
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|DS0PR11MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: d5eb152b-3ebe-4033-af0e-08db13b48e41
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yELK2NAn1406M5LOfRq00EWZKsoxWnRzsFQv3eoUXuGeMygFc4E0IOnysi+dvRslChymBk3tjNt8q3ljLDp4NCQ70qnjJlN5lN9md0/BMKv/GyIegbH978pV1R1vop+iff0zaRLMyaCMYWth28hPEsN6GsMQzOBMXo9/pWpUfpDgoMAyvz8Y1QILpGo4QOctf07EH2JhUDOWpieKlpqSd+p0Ri+CMJhXk3lqBL1xU4kJg+FXJShfCClijlRfDc/YLDcsgHhgxgG5Tm8xtRAsiylfBlgQzYudR0Osu6MvXJi80zwWUecIF6CKTMLrXjVHDetLoiKHve/30h0samxTXv5ZL+G7FueJGCBe8yLOIlKe+kh691KezsZnfHuR2g90jKCvF0tnk2V0nnzpiFv97SaDe1TdfPgni/8t2ywbwwWHS4HVenHg6zbP3kiuyMLZht3P9Xf9Y7c2/Py08u4gjWjF92obo7KxjGNj9u4mqEJo7YuPL6G/91qNLOThtC3w+ED1nUrxi8w8+/TrEL/d4aTw13sOOaQNG2UM0ZoOGoJCtw8VqpZhViE9jJHXQWWHRRiz4luA++YWLfNeVBb0ddlhqQ33GtQrc/edZsAVUlbV9ZFK/wi6lGZq76Zw+Ef2KYyIvZfXB5yCSyl/Koiurfor0yX1z5v0NUnXpUAZKO/Ip5oie8jzfhzqze5gQhPlgub9WCoMuyKnNMDPjOaDIyoHziMPI4bfNvqClXBIBLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199018)(82960400001)(38100700002)(186003)(26005)(966005)(6486002)(6506007)(316002)(53546011)(2906002)(44144004)(6636002)(478600001)(54906003)(66946007)(66476007)(6512007)(4326008)(8676002)(66556008)(8936002)(83380400001)(5660300002)(6862004)(235185007)(86362001)(44832011)(7416002)(7406005)(41300700001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLrBQ7EyayoH4FrjjaCrzMjMvxXose/CHOs+7QYJvsBI+RwkSKbrPcYj+4tl?=
 =?us-ascii?Q?L8WK725kUECCp9/hAwWepSJcpHOMFAU6AV6Liolx3dCZoFVgi7xiYVfjBXTh?=
 =?us-ascii?Q?mRoBVuJcIT9LGbjW3Zbb5s/kfgK3yBcWyhsz9XXX3bXiyiY4AenxIwQNzHu9?=
 =?us-ascii?Q?vYrS5Bhcl9yRX7uB1nn90ykvhK0ymDgMrfUFRQHPVnfqw73CXy9nlKF8k05a?=
 =?us-ascii?Q?FYXiC9QKm+03JiL/GO7ggN13AHsANR+FSHODEif6g3Q7oX5PdMcJsVVL9EDc?=
 =?us-ascii?Q?sC/gwQyRUadSCqbUjg+bh5B0CDBp9F4+u9GRk3O3C8JdMUYKFnxQ7OngXubs?=
 =?us-ascii?Q?ZkON01Nj9Pi2XRg17dtqNNWkke62sz7OLqYVMrlqvcxtVoSL80FjwnG52r+Y?=
 =?us-ascii?Q?Vn3vWj/M7zPZKn8nIbOx4fsPFrLEqyyxgnKOpjUMwHOdzrROgqumRZqD1n2Q?=
 =?us-ascii?Q?msce7cddguzQM9XixRiugb6b2KunhP3xs/KMUL9IjQO72U55+0PASxfUR3UZ?=
 =?us-ascii?Q?OHDlZfLv4Jk+MNOK2Nw5Gri1qwpnxuSa/1U5zbJsNL7AoYntoa1XMhQVz0ho?=
 =?us-ascii?Q?N3zfPI9/qCm47Cwqi3syO37GPS1H/P5XdfLishv06g2aMTw5rmAd6d4ZroKT?=
 =?us-ascii?Q?Vw3oCoGps7C7yLvAIj/BNo5x4Ynm9l4r2CEeAh14+ZabBTvi9mOglbN3CN4I?=
 =?us-ascii?Q?glKI1nGBbT+RJeazgRcvJLssLrN2Ug7eAFfHi3NrLipDMQyU8HbUy2UNNIyT?=
 =?us-ascii?Q?k+/GZ514NY/yQuiqfQKHLXvR3FO3ecBPp3CIZ2qN2hns76BAz/G+sq+0NjRJ?=
 =?us-ascii?Q?UW0XmChfqUKwGSrWDsQNaRtiDIIDHCNaItroUzFdfxYkVDuMKeEbhyP8WlZg?=
 =?us-ascii?Q?yNCbf7ivl7YOhsoJygswkzAt+akZJOKr03FmFpyiy9gsEUPm5MECnsqAi04T?=
 =?us-ascii?Q?6FlBM2JumczvrCeVWbuLP+81gmyPoNJS45Dd5eJMn+AZ4RqXuBvWHDo2eKai?=
 =?us-ascii?Q?yV70zCSLfOJcjKOmA6KWKAcQlcCP71HAGrN31sonnBRMbtg8jIkIdHDBIejC?=
 =?us-ascii?Q?adZ5tqShM+GrFVmTZBh2sVXmlcf7hCFYrSIDF0jjkSsVgbyxYi9uOsQ3CmAm?=
 =?us-ascii?Q?fg/jKqqOpm9MBH7BII/hsFgcoJW8dVOEfgMQ55oF8Znh0iIi3Yia0g1mdX/G?=
 =?us-ascii?Q?qmYXIJ6wdP9EyuqVyTZq2AdfVR7jTiXR1Jw2WnXcVJmeGzWgYBOQpUoYlJS7?=
 =?us-ascii?Q?nxKjUMk3GvNGWPV5NihNz6fkBCLK7F995YUCyw+M8Lw0ytFF08tt83H2E3CD?=
 =?us-ascii?Q?601fqCu4oqt1bOZ1MEkcycUNf+ivQ/WQ8QRCpti/gNGFIk4nCUWpS4DxXoDB?=
 =?us-ascii?Q?e6iY8E76BZCLOBZox84L74bYcOnu8RrySIH+E1QY7E380sUa/e1ByULPjHrK?=
 =?us-ascii?Q?LXN5bnCujmyNz6BtKeJQd9y84OmOXrj8PegVM+3dnsYLrvuUGTe+ymptIrzp?=
 =?us-ascii?Q?Swh7/aRm1bWJYWdbTLsYvZj58GcG0mqe74NPleWW3M9awPpwASsNW5d0yHpv?=
 =?us-ascii?Q?+SpQzdZ8tkMH4NYnWVpKX5ovX6gRhmnK6qCcRAy3o8MpUQye1h8HKBrMS0lk?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5eb152b-3ebe-4033-af0e-08db13b48e41
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 02:37:21.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQi+4KtbunTVitUmA6LOLhYuI3KFexYs8iPuBUVLmYOVCdPCNKA4TWwfiT+kl1gcD5p6gcxZ1rc/VTsNY2IZgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7288
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--gkqNPeSovw7GjVb3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Rick,

On 2023-02-18 at 13:13:52 -0800, Rick Edgecombe wrote:
> Hi,
> 
...
> 
> I left tested-by tags in place per discussion with testers. Testers, please
> retest.
> 

1. Tested kself-test from user space shstk on ADL-S, TGL-U without Glibc shstk
support in CentOS 8 stream OS:

// From the test_shadow_stack code in this patch series:
# ./test_shadow_stack
[INFO]  new_ssp = 7f014ac2dff8, *new_ssp = 7f014ac2e001
[INFO]  changing ssp from 7f014a1ffff0 to 7f014ac2dff8
[INFO]  ssp is now 7f014ac2e000
[OK]    Shadow stack pivot
[OK]    Shadow stack faults
[INFO]  Corrupting shadow stack
[INFO]  Generated shadow stack violation successfully
[OK]    Shadow stack violation test
[INFO]  Gup read -> shstk access success
[INFO]  Gup write -> shstk access success
[INFO]  Violation from normal write
[INFO]  Gup read -> write access success
[INFO]  Violation from normal write
[INFO]  Gup write -> write access success
[INFO]  Cow gup write -> write access success
[OK]    Shadow gup test
[INFO]  Violation from shstk access
[OK]    mprotect() test
[OK]    Userfaultfd test
[OK]    32 bit test

// shstk violation without SHSTK glibc support
// Code link: https://github.com/intel/lkvs/blob/main/cet/shstk_cp.c
# ./shstk_cp
[PASS]  Enable SHSTK successfully
[PASS]  Disabling shadow stack successfully
[PASS]  Re-enable shadow stack successfully
[PASS]  SHSTK enabled, ssp:7fa3bfe00000
[INFO]  do_hack() change address for return:
[INFO]  Before,ssp:7fa3bfdffff8,*ssp:40133f,rbp:0x7ffc23b5b440,*rbp:7ffc23b5b480,*(rbp+1):40133f
[INFO]  After, ssp:7fa3bfdffff8,*ssp:40133f,rbp:0x7ffc23b5b440,*rbp:7ffc23b5b480,*(rbp+1):401146
Segmentation fault (core dumped)

Dmesg:
[1117184.518588] shstk_cp[1523882] control protection ip:40122c sp:7ffc23b5b448 ssp:7fa3bfdffff8 error:1(near ret) in shstk_cp[401000+1000]

// shstk ARCH_SHSTK_STATUS read/set test without SHSTK Glibc support
// Code link: https://github.com/intel/lkvs/blob/main/cet/shstk_unlock_test.c
# ./shstk_unlock_test
[PASS]  Parent process enable SHSTK.
[PASS]  Parent pid:1522040, ssp:0x7f57fc400000
[INFO]  pid:1522040, ssp:0x7f57fc3ffff8, *ssp:401799
[PASS]  Unlock CET successfully for pid:1522041
[PASS]  GET CET REG ret:0, err:0, ssp:7f57fc3ffff8
[PASS]  SET CET REG ret:0, err:0, ssp:7f57fc3ffff8
[PASS]  SET ssp -1 failed(expected) ret:-1, errno:22
[PASS]  GET xstate successfully ret:0
[PASS]  SHSTK is enabled in child process
[INFO]  Child:1522041 origin ssp:0x7f57fc400000
[INFO]  Child:1522041, ssp:0x7f57fc400000, bp,0x7ffcf32ba0f0, *bp:401dc0, *(bp+1):7f57fc43ad85
[PASS]  Disabling shadow stack succesfully
[PASS]  SHSTK_STATUS ok, feature:0 is 0, ret:0
[PASS]  Child process re-enable ssp
[PASS]  SHSTK_STATUS ok, feature:1 1st bit is 1, ret:0
[PASS]  Child process enabled wrss
[PASS]  SHSTK_STATUS ok, feature:3 2nd bit is 1, ret:0
[INFO]  Child:1522041, ssp:0x7f57fc400000, bp,0x7ffcf32ba0f0, *bp:401dc0, *(bp+1):7f57fc43ad85
[INFO]  ssp addr:0x7f57fc400000 is same as ssp_verify:0x7f57fc400000
[PASS]  Child process disable shstk successfully.
[PASS]  Parent process disable shadow stack successfully.


2. Tested fedora37 OS + Hongjiu provided user space SHSTK support Glibc:
// shstk with Glibc support:
// Related Glibc support for Fedora37:  http://gnu-4.sc.intel.com/git/?p=hjl/misc.git;a=tree;f=setup/fedora/37;h=63af84a8f28f3d0802f09266e47fb94eb5cdff26;hb=HEAD
# readelf  -n shadow_test_fork | head
readelf: Warning: Gap in build notes detected from 0x4011d7 to 0x4011e4

Displaying notes found in: .note.gnu.property
  Owner                Data size        Description
    GNU                  0x00000040       NT_GNU_PROPERTY_TYPE_0
          Properties: x86 feature: IBT, SHSTK
...
// shadow_test_fork code is in attached
// gcc -fcf-protection=full -mshstk -O0 -fno-stack-check -fno-stack-protector    shadow_test_fork.c   -o shadow_test_fork
# ./shadow_test_fork s2
[INFO]  s2: stack rbp + 1
[INFO]  do_hack() change address for return:
[INFO]  After change, rbp+1 to hacked:0x401296
Segmentation fault (core dumped)

Dmesg:
[418653.591014] shadow_test_for[16529] control protection ip:401367 sp:7fff6ed0a728 ssp:7f661265bfe0 error:1(near ret) in shadow_test_fork[401000+1000]

All above user space SHSTK tests are passed.

Many thanks Rick and all!

Thanks!
BR.
Pengfei

> -- 
> 2.17.1
> 

--gkqNPeSovw7GjVb3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="shadow_test_fork.c"

// SPDX-License-Identifier: GPL-2.0
/*
 * Contributors:
 *      Pengfei, Xu <pengfei.xu@intel.com>
 *      - Test CET shadow stack function, should trigger #CP protection
 *      - Add the print, and show stack address and content before and after
 *        changed
 */

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <sched.h>
#include <immintrin.h>

static long hacked(void)
{
	printf("[INFO]\tAccess hack function\n");
	printf("[FAIL]\tpid=%d Hacked!\n", getpid());
	printf("[WARN]\tYou see this line, which means CET shstk #CP failed!\n");
	return 1;
}

/*
 * stack variable y + 1(1 means 8bytes for 64bit, 4bytes for 32bit) is bp,
 * and here use bp directly, it's bp hacked not sp hacked, so it should not
 * trigger #CP.
 */
static void stack_add1_test(unsigned long changed_bp)
{
	unsigned long *func_bp;

#ifdef __x86_64__
	asm("movq %%rbp,%0" : "=r"(func_bp));
#else
	asm("mov %%ebp,%0" : "=r"(func_bp));
#endif
	printf("[INFO]\tReal add1 function rbp content:%lx for main rbp.\n",
	       *func_bp);
	*func_bp = changed_bp;
	printf("[INFO]\tChange add1 rbp content:%lx, but right main rbp content in it!\n",
	       *func_bp);
}

/* stack base rbp + 1 addr test, which should be hacked and #CP should work */
static unsigned long stack_add2_test(void)
{
	unsigned long y;
	unsigned long *i, *j;

	i = (unsigned long *)_get_ssp();
	j = __builtin_frame_address(0);

	printf("[INFO]\tdo_hack() change address for return:\n");
	printf("[INFO]\tBefore change,y:%lx,&y:%p,j:%p,*j:%lx,*(&j+1):0x%lx, ssp:%p *ssp:0x%lx\n",
	       y, &y, j, *j, *(j+1), i, *i);

	/* j(rbp)+1 is sp address, change rbp+1 to change sp content */
	*(j + 1) = (unsigned long)hacked;

	printf("[INFO]\tAfter change, rbp+1 to hacked:0x%lx\n", *(j+1));
	printf("[INFO]\tAfter hacked  &y:%p, *j:0x%lx,*(&j+1):0x%lx\n",
	       &y, *j, *(j + 1));

	/* Debug purpose: it's not related with ret instruction in objdump. */
	return y;
}

/* stack base y + 3 addr test, which should not be hacked and #CP */
static unsigned long stack_add3_test(void)
{
	unsigned long y;

	printf("[INFO]\tdo_hack() change address for return:\n");
	printf("[INFO]\tBefore change, y:0x%lx, *(&y+2):0x%lx\n", y,
	       *((unsigned long *)&y + 2));
	*((unsigned long *)&y + 3) = (unsigned long)hacked;
	printf("[INFO]\tAfter change, *(&y+3) to change:0x%lx\n", (unsigned long)hacked);
	printf("[INFO]\tAfter change &y+3:%p,*(&x+2):0x%lx\n",
	       (unsigned long *)&y + 3, *((unsigned long *)&y + 3));
	printf("[INFO]\tAfter changed &y:%p, &y+2:%p,*(&y+2):0x%lx\n",
	       &y, (unsigned long *)&y + 2, *((unsigned long *)&y + 2));

	return y;
}

static long stack_long2_test(unsigned long i)
{
	unsigned long *p;


	printf("[INFO]\tuse rbp + long(+8bytes) size to hack:\n");
	/*
	 * Another way to read rbp
	 * asm("movq %%rbp,%0" : "=r"(p));
	 */
	p = __builtin_frame_address(0);

	printf("[INFO]\t*(p+1):%lx will be hacked\n", *(p + 1));
	*(p + 1) = (unsigned long)hacked;

	return 0;
}

/* stack base y + 2 change to random value to do shstk violation */
static unsigned long stack_random(unsigned long j)
{
	unsigned long y;
	unsigned long *p;

	y = j;
	printf("[INFO]\tSHSTK hack with random value:\n");
#ifdef __x86_64__
	asm("movq %%rbp,%0" : "=r"(p));
#else
	asm("mov %%ebp,%0" : "=r"(p));
#endif

	*(p + 1) = j;

	return y;
}

/* stack base y + 2 changed but no return */
static void stack_no_return(void)
{
	unsigned long *p;

	printf("[INFO]\tSHSTK with void no return function:\n");
#ifdef __x86_64__
	asm("movq %%rbp,%0" : "=r"(p));
#else
	asm("mov %%ebp,%0" : "=r"(p));
#endif

	*(p + 1) = (unsigned long)hacked;
}

/* buffer overflow change stack base, which should trigger #CP */
static void stack_buf_impact(void)
{
	char buffer[20];
	int overflow_num = 44;

	printf("[INFO]\tbuffer[20]:%x\n", buffer[20]);
	memset(buffer, 0, overflow_num);
	printf("[INFO]\tbuffer[44]:%x,&buffer[44]:%p\n", buffer[44], &buffer[44]);
	printf("[INFO]\tbuffer[20] after overflow:%x\n", buffer[20]);
}

/* buffer overflow not change stack base, which should not trigger #CP */
static void stack_buf_no_impact(void)
{
	char buf[20];
	int overflow_24 = 24, overflow_28 = 28;

	printf("[INFO]\tbuf[20]:%x\n", buf[20]);
#ifdef __x86_64__
	memset(buf, 0, overflow_28);
#else
	memset(buf, 0, overflow_24);
#endif
	printf("[INFO]\tbuf[20] after overflow:%x\n", buf[20]);
}

/* test hack function */
static int do_hack(void *p)
{
	/*
	 * Ret and then rip will get this value(rbp + 8 bytes in 64 bit OS)
	 * rbp(8 bytes in 64bit OS)
	 * *i, *j and so on variable content
	 */
	unsigned long *i, *j;

	i = (unsigned long *)_get_ssp();
	j = __builtin_frame_address(0);

	printf("[INFO]\tBefore: rbp+8:0x%p content=0x%lx; ssp=0x%p, ssp content=0x%lx\n",
		j + 1, *(j + 1), i, *i);
	*(j+1) = (unsigned long)hacked;
	printf("[INFO]\tAfter: rbp+8:0x%p content=0x%lx; ssp=0x%p, ssp content=0x%lx\n",
		j + 1, *(j + 1), i, *i);

	return 0;
}

/* check shadow stack wo core dump in child pid */
static void stack_wo_core(void)
{
	void *s = malloc(0x100000);

	if (fork() == 0)
		do_hack(s);
}

/* test shstk by clone way */
static int stack_clone(void)
{
	pid_t cid;

	void *child_stack = malloc(0x100000);

	if (child_stack == NULL) {
		printf("[FAIL]\tmalloc child_stack failed!\n");
		return 1;
	}

	cid = clone(
	do_hack, /* function */
	child_stack + 0x100000,
	SIGCHLD,
	0 /*arg*/
	);

	if (cid == -1) {
		printf("[FAIL]\tclone failed!\n");
		free(child_stack);
		return 1;
	}

	printf("[INFO]\tparent=%d, child=%d\n", getpid(), cid);

	if (waitpid(cid, NULL, 0) == -1) {
		printf("[FAIL]\twaitpid() failed!\n");
		return 1;
	}
	printf("[INFO]\tchild exits!\n");

	free(child_stack);
	return 0;
}

/*
 * Check shadow stack address and content and
 * rbp address and protect address content
 */
static int shadow_stack_check(void)
{
	unsigned long y;
	unsigned long *bp_a, *ssp_a;
	unsigned long long size_bp, size_ssp;

	ssp_a = (unsigned long *)_get_ssp();
	bp_a = __builtin_frame_address(0);
	size_bp = sizeof(*(bp_a + 1));
	size_ssp = sizeof(*ssp_a);

	printf("[INFO]\t&y=0x%p\n", &y);
	printf("[INFO]\tbp=%p,bp+1=%p,*(bp+1):0x%lx(size:%lld) ssp=%p *ssp=0x%lx(size:%lld)\n",
		bp_a, bp_a + 1, *(bp_a + 1), size_bp, ssp_a, *ssp_a, size_ssp);
	return 0;
}

static void usage(void)
{
	printf("Usage: [null | s1 | s2 | s3 | sl1 | sr | sn...]\n");
	printf("  null: no parm, stack add 2 test, should trigger #CP\n");
	printf("  s1: stack add 1 test\n");
	printf("  s2: stack add 2 test, should trigger #CP\n");
	printf("  s3: stack add 3 test\n");
	printf("  sl1: stack with long add 2 test\n");
	printf("  sr: stack change to random value\n");
	printf("  sn: stack change but no return\n");
	printf("  buf1: buffer overflow change stack base\n");
	printf("  buf2: buffer overflow not change stack base\n");
	printf("  snc: test shadow stack wo core dump\n");
	printf("  sc: test shadow stack by clone way\n");
	printf("  ssp: check shadow stack addr and content\n");
}

int main(int argc, char *argv[])
{
	char *parm = "";
	unsigned long a = 0, *main_rbp, fake_bp[2];

	a = rand();
	enum {
		e_s1, /* enum stack base, y + 1 */
		e_s2, /* enum stack base + 1 addr content change test */
		e_s3, /* enum stack base y + 3 */
		e_sl1, /* enum stack base with long + 2 */
		e_sr, /* enum stack base change to random value */
		e_sn, /* enum stack base changed but no return */
		e_buf1, /* buffer overflow change stack base */
		e_buf2, /* buffer overflow not change stack base */
		e_snc, /* shadow stack wo core dump */
		e_sc, /* test shstk by stack clone way */
		e_ssp /* check shadow stack addr and content */
	} option;

#ifdef __x86_64__
	asm("movq %%rbp,%0" : "=r"(main_rbp));
#else
	asm("mov %%ebp,%0" : "=r"(main_rbp));
#endif

	/* Use real main rbp address and content to make one fake bp and sp */
	fake_bp[0] = *main_rbp;
	fake_bp[1] = *(main_rbp + 1);

	if (argc == 1) {
		usage();
		stack_add2_test();
	} else {
		parm = argv[1];
		if (strcmp(argv[1], "s1") == 0)
			option = e_s1;
		else if (strcmp(argv[1], "s2") == 0)
			option = e_s2;
		else if (strcmp(argv[1], "s3") == 0)
			option = e_s3;
		else if (strcmp(argv[1], "sl1") == 0)
			option = e_sl1;
		else if (strcmp(argv[1], "sr") == 0)
			option = e_sr;
		else if (strcmp(argv[1], "sn") == 0)
			option = e_sn;
		else if (strcmp(argv[1], "buf1") == 0)
			option = e_buf1;
		else if (strcmp(argv[1], "buf2") == 0)
			option = e_buf2;
		else if (strcmp(argv[1], "snc") == 0)
			option = e_snc;
		else if (strcmp(argv[1], "sc") == 0)
			option = e_sc;
		else if (strcmp(argv[1], "ssp") == 0)
			option = e_ssp;
		else {
			usage();
			exit(1);
		}
	}

	switch (option) {
	case e_s1:
		printf("[INFO]\ts1: stack + 1\n");
		stack_add1_test((unsigned long)&fake_bp[0]);
		break;
	case e_s2:
		printf("[INFO]\ts2: stack rbp + 1\n");
		stack_add2_test();
		break;
	case e_s3:
		printf("[INFO]\ts3: stack + 3\n");
		stack_add3_test();
		break;
	case e_sl1:
		printf("[INFO]\tsl1: stack with long + 2, a:0x%lx\n", a);
		stack_long2_test(a);
		break;
	case e_sr:
		printf("[INFO]\tsr: stack changed to random value a:0x%lx\n", a);
		stack_random(a);
		break;
	case e_sn:
		printf("[INFO]\tsn: stack changed but no return\n");
		stack_no_return();
		break;
	case e_buf1:
		printf("buf1: buffer overflow change stack base\n");
		stack_buf_impact();
		break;
	case e_buf2:
		printf("[INFO]\tbuf2: buffer overflow not change stack base\n");
		stack_buf_no_impact();
		break;
	case e_snc:
		printf("[INFO]\tsnc: test shadow stack wo core dump\n");
		stack_wo_core();
		break;
	case e_sc:
		printf("[INFO]\tsc: test shstk by stack clone way\n");
		stack_clone();
		break;
	case e_ssp:
		printf("[INFO]\tssp: check shadow stack addr and content\n");
		shadow_stack_check();
		break;
	default:
		usage();
		exit(1);
	}

	printf("[RESULTS]\tParent pid=%d is done.\n", getpid());

	return 0;
}

--gkqNPeSovw7GjVb3--
