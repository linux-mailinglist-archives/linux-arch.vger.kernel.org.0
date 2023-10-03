Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BD57B6EA6
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 18:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjJCQgK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Oct 2023 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbjJCQgB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2023 12:36:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C0A6;
        Tue,  3 Oct 2023 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696350955; x=1727886955;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cWKZD+SyDVCIZphXjh9ZrSmuS5EZAvAJ5rfGF7TIGUo=;
  b=J+C4Jtx3Wg3SUPoAS5W23tOXE5Yd25Rnqeim5lPZdRFKJQ71vILQf3zT
   MlcGWNc87HkKgELYfLX/eYKFZIZ5C4gZXpmoc42sEu9oswR5HB2beHdX1
   n+MiiwXD9X05GXt8tpzhzOBVtbE/AZpeK8C7TdBXl7r8lWXQBRGyQeAie
   RKgpHCEx5vt53qpGHAvMljuZFIDe7/hCxePBdbMa57x4ISJMFqI5fIbbI
   E0jAHXDOQUL2xo4LyxBDjtzSOUYE6PaMaa7dOI956woLMEN4fF/8YDh2S
   G9GOSNgAfx/7Y4LD5i3IaNsQK2Kqht0S6eV1ge8JoYDLlz9hoAIPy3ugr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386790570"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="386790570"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727675517"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="727675517"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 09:35:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 09:35:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 09:35:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 09:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0PGrRo5qLwx9wEoziiJgM43nkiZlKnJGQO0ehlRpmnLjQJkO+trNw4CNQ2n9EYp+V5HpW56ykmmXvXHOQALmbTgXPy0xpiCXQhI0AYaDY3m8JYKl2xa8V6mu+CejjzSkZiqbgJggsxfjWipaUhBMF01xV8/l0T9m9kTqZKhHKJObq3GJdOJYAVbhUBUQEvDmAC3v6WNrn6BCTecHdx1zeTwqXVzu8XlaGiQwWEJsR8D4EMDrzhAprw9iTr4HYdo5WdSR/B5jA0dn0wQqQgnT0oihvJgculb4rQcwyGDJg+WIsKclt/UtZa5ekP0xgQOpjd1KLH8CcSRFfR8Tl955Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuUdaP5CJww3Y5MPnHxz2DcfK1pB88n7p8zmeHivxQE=;
 b=MUYFuz+xAVLbyw5c6ncfGFmVrx+oBFPZulBCh/LUFeV+KY5eLWjZ8OHRMlVLR2NOBaKY77rLVAk/x9LzJ2n0F9GQ26/TZQ94QsYMz9gpuM+QV+7r58g7JP3IxSHteapwyRIHWOl4sGAl1euIt5XhzRfZRre69Lcp4qswjQP7J7Rp4fYZe2UpTjTu7EMRUguFz/M7pVD9xBPX2wB7XmJfaot2R8WVJYUFxpItkfLA/gcVncqxa3WyiFUuG00sWiRIlKyGzvx6UL/H/8q3u1p7LPAzNpe2AvaHr/imFuLOGqVPfor6tRR/kmNCBuiv8KqL8EjDHmnN48aU9e5AAVnIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ2PR11MB8347.namprd11.prod.outlook.com (2603:10b6:a03:544::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 16:35:43 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::5e34:ee45:c5e8:59d0%7]) with mapi id 15.20.6838.028; Tue, 3 Oct 2023
 16:35:43 +0000
Message-ID: <487836fc-7c9f-2662-66a4-fa5e3829cf6b@intel.com>
Date:   Tue, 3 Oct 2023 09:35:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] arch: Reserve map_shadow_stack() syscall number for
 all architectures
To:     <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sergei Trofimovich <slyich@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
References: <20230914185804.2000497-1-sohil.mehta@intel.com>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230914185804.2000497-1-sohil.mehta@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ2PR11MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 23356520-43ba-4f40-b7c9-08dbc42ec9b8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pY87qHJZ67+oRnav3o2AiN3F4lj7p+5LpxqvgFJ6mv5y/QDr47JGErj9t69XeAWGiNR3zdTClRbM+EzsAdunfMONmj/r/wUC9Vt4U67KlJIXvubyPAz1A7VX78T+9eSDErmRXoRytu+8haRBsGK/KZF24q2dfl9PT1gPN0vOYOGLUHBM3OM2SCsGH1QJHn+FbUW9CB3ulpnTwKMlLa1eAFK9y404a4wDBg5XkKLLLvNip2Z5Dt5EgCFCbnoeQuS/g0YqMRCSbedZL7VJPTqabZbvgtKCsePdB4xTofCLuzKO45NYWMFQuHFiOvJvRPbhvx8dZwudh7xSsg1Nge++G5FrCiGGSc5WikFkW96GSvkpqlunzofuUM7dRyzwSM7pbpv/CcZG/MGxuP0sa/xSkoVBqzTpKgim4CjQFzpkrGxN6yYbjghWGwiYYeIVBjKEih4freUiIFr5T1lMrtadk91q0zK/p+1KnRIyJw9Se8qG0ctR6q1f030g+JgUJeaILb2+guvRmJWt6s15+E2q5ZSEbdaS1NL+SnzmsduEn7jugEkMV7BR2a6Y3ZuFvQQNcFzfxi1unVRxa75CpVZtCqJPMEoTWWS6u3Y/vM/lRHIqAd3OHJXzdsPODJo+oQSWRkzHr3Z9vCbtnsPtXok3mWd7NvUH3yfLiFBZfJ4pGxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2616005)(82960400001)(5660300002)(26005)(6666004)(8676002)(4326008)(8936002)(86362001)(31686004)(478600001)(31696002)(966005)(6486002)(38100700002)(66556008)(66946007)(66476007)(6916009)(54906003)(316002)(7366002)(7416002)(7406005)(53546011)(2906002)(6512007)(30864003)(6506007)(83380400001)(36756003)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3RnTU9OQnh3SjdzZzJxZDk3TVQ1WW82VnlqWnphRXh5VG85RzA1a3hrM1Ro?=
 =?utf-8?B?L2VDL3pHbWFEOU9ibUM3WlYxeDRpNEtnc0NYSFppM1RIZU9QeGw0blZ4b1o1?=
 =?utf-8?B?RlpaTWNodEdRYndURXYzOGVwcFJmWGRUR29lYjV2enNQUmh6eXJkdVFzNkg5?=
 =?utf-8?B?ZDhVS1FsNy9uMWxMWlQ4aXpHQTl5aGhHbUthQVRnSFNvYXRzMm9kNkFWOWFJ?=
 =?utf-8?B?ZGZLaTc1MGUxTVFUeWZuTjB3ZFBEZkdjTy8yRU85UWlNeTY1RE83UTNMcUdU?=
 =?utf-8?B?WnRjanN5T2g4c1JTVmlYWWkxMEJRek4yb3V1bjZaZTJOK21mZ2trTnU5WEFs?=
 =?utf-8?B?N2QvZStHM2lPNGVhbnVRZUREZktQVGdvZFRTL0tSK2svdGlFSHpPYmNncEpH?=
 =?utf-8?B?bEN3REk0Ykh3NGFHM291NHRRWHlXWEF4dGp2ajcxdlJOYnVPM1QzN29SbTF1?=
 =?utf-8?B?cDYwaFE5VHVtREpRamxwUkZiRzVDN1FlekhzanNvNUdvK25QdmlrK1MvanA1?=
 =?utf-8?B?S25GYUFEV0dyVVJhVmlzNXVDOEd2RWhQNklGY25Uc1k0dGxVVG5rNC9wZUE2?=
 =?utf-8?B?VjZFWWdWM3ptRUlSbkxuUXVUbDJ0K0pqbkRrVWlrb1NvOUIvVTZ2NTB6Zi9n?=
 =?utf-8?B?UjBpeEJtbkkzNW9pb1FNMWN0bTFIM3A0NWhXYWJIL090cDFxbnRZY0xwOWdQ?=
 =?utf-8?B?L2U4NU5udHNzcWY3dUtDN2JjeGx6RnFqc0p6d3R0MUlZTlJ2d1BvYTgvU2di?=
 =?utf-8?B?ZjgwM25PT1c4Ynd4dlp2UUFuYytkcFBxNHFmNi9rQ0c4ZGI4eldKcW9mbnpa?=
 =?utf-8?B?SVd1ZEZYNUpMcEdCZmdRcS9yY1dpQkprMDd5TXZtKzJ1cnBoTnQ4a1crcG0v?=
 =?utf-8?B?NjJyazhReDI1QWxwMWp5bnpnckErRjdtQU5yaitMZEx5UkQ2em1CalBvUGwv?=
 =?utf-8?B?UDd5VDJ5NmNSYXpjV1dnR3NBREhiVUJ1WGZwTDJJaFpQenplMnpLQnh0R3dC?=
 =?utf-8?B?YWlkRnIwU3ZGNEJNVmE4WnlodG80S0pFVVAzdG1LL2xKYktoWk0xWWhZWitt?=
 =?utf-8?B?VEtJRmV3bWVmbTNMVnNxY3ppdy9mYUg5RDdiV2dSYVFwc09mNVZ1VVNleUMr?=
 =?utf-8?B?cjhObUpsMGU2eTB5Rk50bDZrZHAydFZzdWFMa1dYQTNPTzkxWXVYd0JKTzFm?=
 =?utf-8?B?QTk0MllDVjRlc3VvWHVKL29CRVZRWTZuaEtOdHpZK2JKZ0dsYW80MURjYzQw?=
 =?utf-8?B?NFdjNkFkSW94VjRtazRjSGFvSlU5Ulo4ZkZrOXcwZ0lzd1gzWkhta2pqVkpt?=
 =?utf-8?B?UVczTzMwcko0K0VLVW1qS3gvaGxIcVl2WGUvdzBQMzh3WVAyd0hvejRzTXFC?=
 =?utf-8?B?enlpN3R4Q3JYZFltVHVmQlpVMHI3YXFPbzBLK1kyczNiQTBCdjh2N3piclll?=
 =?utf-8?B?UnhJbGdnVHZDQmVoSHBGTFZwalZhNm9Db0R3azdVb1NIR2U2TnNUVmR4YnFW?=
 =?utf-8?B?N3NRV1VVSlZlcUhpaUREUGJ0Unl6MmZQeTRlNjJPRVhoZ2dMWkpHWTZ5NVVv?=
 =?utf-8?B?bDh3c3dOTFVrWWNXZlNjSGVWSGhBSEtqdjBsdit5WGxTdEZtL2VkcGFSbzBN?=
 =?utf-8?B?WHNXS1QrdnBRTUJaMk8vT0M4TjdCWkRBby9Db21veEZKeDEwYm9zKzN3OXk0?=
 =?utf-8?B?OTh0Z2VSOGJmR2c1UnhLRzBuQUVObkNjYjdyaEkxam9abmJrc2dGN1lMV2tV?=
 =?utf-8?B?dnJ2eXc3Y1ZvRnpxcmpWeks5amg4cEIvbHRIdzluMmcrbDZrS2dvV2NINUwy?=
 =?utf-8?B?cjZ6bjZ0Y0JMK25BQTJ3NWc5WHhnWW5GZ2pGbVJmc2JKV0ZSUWRyYTl6VWMz?=
 =?utf-8?B?eUlHbFo3c1BZN1VqUXJqODJPUC9iWHVNOWV5T2sybTNCUHRRNnpQYW5jbUI1?=
 =?utf-8?B?aFYva0RBY2VEa2VNQ05XUis1VGtLTFhXRUdHQ21aRTErK2VGaS9zczd6aHdU?=
 =?utf-8?B?SmF3VHVwTE5STnc4VXA0WWpXMTVTcThUZ2lHL1FtVTkrS05rMEx4dUlOL0ZZ?=
 =?utf-8?B?YWk2YkVRVTVtdmlieWErUmRETGtuY05TaU5SL2FqeTlFTnRQdlEzdW52UTZO?=
 =?utf-8?Q?QQLAT2opv7b5dW6/YtX38cfZU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23356520-43ba-4f40-b7c9-08dbc42ec9b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:35:43.6905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWJ7H9InOJapywMfVgSQSSPWD8p5HBOT4mY2NmI35F86DE1Thsh/A94rh9iMvIP3T2w5V1RwXxb0oYbqtCn3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8347
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/14/2023 11:58 AM, Sohil Mehta wrote:
> commit c35559f94ebc ("x86/shstk: Introduce map_shadow_stack syscall")
> recently added support for map_shadow_stack() but it is limited to x86
> only for now. There is a possibility that other architectures (namely,
> arm64 and RISC-V), that are implementing equivalent support for shadow
> stacks, might need to add support for it.
> 
> Independent of that, reserving arch-specific syscall numbers in the
> syscall tables of all architectures is good practice and would help
> avoid future conflicts. map_shadow_stack() is marked as a conditional
> syscall in sys_ni.c. Adding it to the syscall tables of other
> architectures is harmless and would return ENOSYS when exercised.
> 
> Note, map_shadow_stack() was assigned #453 during the merge process
> since #452 was taken by fchmodat2().
> 
> For Powerpc, map it to sys_ni_syscall() as is the norm for Powerpc
> syscall tables.
> 
> For Alpha, map_shadow_stack() takes up #563 as Alpha still diverges from
> the common syscall numbering system in the other architectures.
> 
> Link: https://lore.kernel.org/lkml/20230515212255.GA562920@debug.ba.rivosinc.com/
> Link: https://lore.kernel.org/lkml/b402b80b-a7c6-4ef0-b977-c0f5f582b78a@sirena.org.uk/
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---

Gentle ping...

Are there any additional comments? It applies cleanly on 6.6-rc4.

Or does it seem ready to be merged? It has the following
acknowledgements until now:

Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

>  arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
>  arch/arm/tools/syscall.tbl                  | 1 +
>  arch/arm64/include/asm/unistd.h             | 2 +-
>  arch/arm64/include/asm/unistd32.h           | 2 ++
>  arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
>  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
>  arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
>  arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
>  arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
>  arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
>  arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
>  arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
>  arch/s390/kernel/syscalls/syscall.tbl       | 1 +
>  arch/sh/kernel/syscalls/syscall.tbl         | 1 +
>  arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
>  arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
>  arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
>  include/uapi/asm-generic/unistd.h           | 5 ++++-
>  18 files changed, 22 insertions(+), 2 deletions(-)
>> diff --git a/arch/alpha/kernel/syscalls/syscall.tbl
b/arch/alpha/kernel/syscalls/syscall.tbl
> index ad37569d0507..6e8479c96e65 100644
> --- a/arch/alpha/kernel/syscalls/syscall.tbl
> +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> @@ -492,3 +492,4 @@
>  560	common	set_mempolicy_home_node		sys_ni_syscall
>  561	common	cachestat			sys_cachestat
>  562	common	fchmodat2			sys_fchmodat2
> +563	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index c572d6c3dee0..6d494dfbf5e4 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -466,3 +466,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
> index bd77253b62e0..6a28fb91b85d 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -39,7 +39,7 @@
>  #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
>  #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
>  
> -#define __NR_compat_syscalls		453
> +#define __NR_compat_syscalls		454
>  #endif
>  
>  #define __ARCH_WANT_SYS_CLONE
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index 78b68311ec81..a201d842ec82 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -911,6 +911,8 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>  __SYSCALL(__NR_cachestat, sys_cachestat)
>  #define __NR_fchmodat2 452
>  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
> +#define __NR_map_shadow_stack 453
> +__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
>  
>  /*
>   * Please add new compat syscalls above this comment and update
> diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
> index 83d8609aec03..be02ce9d376f 100644
> --- a/arch/ia64/kernel/syscalls/syscall.tbl
> +++ b/arch/ia64/kernel/syscalls/syscall.tbl
> @@ -373,3 +373,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 259ceb125367..bee2d2f7f82c 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -452,3 +452,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index a3798c2637fd..09eda7ed91b0 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -458,3 +458,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 152034b8e0a0..3c02cc3886ca 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -391,3 +391,4 @@
>  450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	n32	cachestat			sys_cachestat
>  452	n32	fchmodat2			sys_fchmodat2
> +453	n32	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index cb5e757f6621..aa9ed6a7cb48 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -367,3 +367,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	n64	cachestat			sys_cachestat
>  452	n64	fchmodat2			sys_fchmodat2
> +453	n64	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 1a646813afdc..756f6feb21c2 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -440,3 +440,4 @@
>  450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	o32	cachestat			sys_cachestat
>  452	o32	fchmodat2			sys_fchmodat2
> +453	o32	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index e97c175b56f9..c80eedbe0170 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -451,3 +451,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 20e50586e8a2..87a54acf8346 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -539,3 +539,4 @@
>  450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_ni_syscall
> diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
> index 0122cc156952..22249c07e556 100644
> --- a/arch/s390/kernel/syscalls/syscall.tbl
> +++ b/arch/s390/kernel/syscalls/syscall.tbl
> @@ -455,3 +455,4 @@
>  450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
>  451  common	cachestat		sys_cachestat			sys_cachestat
>  452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
> +453  common	map_shadow_stack	sys_map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> index e90d585c4d3e..5ccfe6fbb6b1 100644
> --- a/arch/sh/kernel/syscalls/syscall.tbl
> +++ b/arch/sh/kernel/syscalls/syscall.tbl
> @@ -455,3 +455,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 4ed06c71c43f..b2d664edebdd 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -498,3 +498,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 2d0b1bd866ea..743a7ef5a4b9 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -457,3 +457,4 @@
>  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	i386	cachestat		sys_cachestat
>  452	i386	fchmodat2		sys_fchmodat2
> +453	i386	map_shadow_stack	sys_map_shadow_stack
> diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
> index fc1a4f3c81d9..94e6bcc2bec7 100644
> --- a/arch/xtensa/kernel/syscalls/syscall.tbl
> +++ b/arch/xtensa/kernel/syscalls/syscall.tbl
> @@ -423,3 +423,4 @@
>  450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	common	cachestat			sys_cachestat
>  452	common	fchmodat2			sys_fchmodat2
> +453	common	map_shadow_stack		sys_map_shadow_stack
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index abe087c53b4b..203ae30d7761 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -823,8 +823,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
>  #define __NR_fchmodat2 452
>  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
>  
> +#define __NR_map_shadow_stack 453
> +__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 453
> +#define __NR_syscalls 454
>  
>  /*
>   * 32 bit systems traditionally used different
> -- 


