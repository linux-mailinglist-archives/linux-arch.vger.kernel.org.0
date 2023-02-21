Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ACD69E8C0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 21:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBUUDv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 15:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBUUDu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 15:03:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620E51E9C9;
        Tue, 21 Feb 2023 12:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677009829; x=1708545829;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jvnQoO1vVYDG1uiZ0B0tWa2HZywVzjbLQwETIYPvdYY=;
  b=SSazb4MEtOPdbghVfWCNbGVUCQiTj5/RKkqgGFWHkNnXQEGuVG8BU8Ho
   owwdCbvSaTdyYBobMPXSpvEzzsHWY+okytbU8MzD5t991A9jVZhzRQn6r
   4ICymxccmWxp6Ayr5cWzh2VWjZQs4IeKrPjvEvgp+DQ0JDChfnS+RLI5j
   OojwEYM1qRnKmi+w+te6spkYf7iGFSCNxOCsPi9zp3rLQ6/jXZA48pyF/
   GPIP13248xWHNDBSJIkSHtisaqo1HFNVqQAcg1ZklKfDVVHP3EuupqFHi
   iGnVKLJknuhqfRLyBGEzA/weP36WpIjmVh/2+mMyggxC/cRg74pm9QrFB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="312367894"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="312367894"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 12:02:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="704185432"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="704185432"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2023 12:02:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 12:02:45 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 12:02:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 12:02:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJWxJN4ft9VECUZYYT7tksnIMkdcQhJ1VgsO3XoTN/e/cEarxIq27/8wVt7247Al5UzzYpzuu3bf9f7qq9SO04ctSFut3j21WcdGiqkyhtlZ6Fddz+GJG95h+rchMC04a1xsIaCMR3dI3ExWtg3s0yg3v5TqWvkPPV/TKBzidwPTxc7SBQpOu2PNk82D18LNr/zhuczmK0vzfT4NnChp425ldlECuWd7dTUzKMCIRtg3zk2asLzRg1ruz/YBZeWYq6+KHIx/gQxrXPfjVgzhigieT8mGibcePZvxb23rIWT2yHl54ItTZ84ZEglTNGm5VqGtnwQ+iZYBIsnnAJczpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvnQoO1vVYDG1uiZ0B0tWa2HZywVzjbLQwETIYPvdYY=;
 b=FaVMYYmyt1aI7eqXQa/VTDPg3d9bcfQK841uitDTUtZzybX7efKxXTcCNzEA9s+S+q/WyHOOkHHMLaFtCVDYufCNZ+RynPwxFA8fBjFmezPeBzdZpG2Z/O49/wyrMHpMUHMlcqZC3ZASZngkax0RjiMxm6sXXUP+6ZKPidu64kVBq+LtxYe/49lJMvcmSmvBAyI/nfmKS4QbBGsuhWeZbhlRvBqToA0yOR2jay+hjUhJwCppZ+IxesVNtbtnwvrGbkCUlPK9SjdYUz48ojlSe1H6KcvVMOYmfdLDiSr7B5aes/DOR10ji837W9LMATGMZjq+Lf5VAFWTzFeUqWX5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 20:02:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 20:02:40 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 24/41] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v6 24/41] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZQ95DosiEG9SO2keuiwn4BYpSkK7ZGQIAgAC+JgA=
Date:   Tue, 21 Feb 2023 20:02:39 +0000
Message-ID: <10782336cc14828525c8146bd36579dd7efe1e7c.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-25-rick.p.edgecombe@intel.com>
         <8b8ffa43-9003-010d-30ea-c5de128d646d@redhat.com>
In-Reply-To: <8b8ffa43-9003-010d-30ea-c5de128d646d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA0PR11MB7814:EE_
x-ms-office365-filtering-correlation-id: d556b353-e620-4d8f-1c2f-08db144695dd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: egCI/3TkSbkTBemW2yRjrz2mLNWtg0LPvy/2UkUUwCWjGQxuRDKJIzObsyEUpHpy7NtB4KVOBX3ePzOo+9q74IFIoarE9OcJ/8FEMC5fXRAADtsAFTftTMzzxMUHqyWqNznfAKt2ol8FUoXTTb4XkJ+RaTBwoEy4WHEMQ7Aq/PoMQfovcFvVPoV7fxwGSWqRF21Txs5mHzzKge2jr3HvVHZ4KC1hpqgfU1RGDebkivNLwtirPwxToWGhcqRhQY9Cl5ZB5bZOtB96DoNkEf0npnzoxQ6ev2oJSWdjp4VvDTMe3KPGs8ReYhV44BEIkTV8FWkP+WghB230rsDTbAiEwDPjx2s9qBwwjD5iOAZt7rRdYEsUgPmb2N24xSDkRRNmz/pG/Nqo3OtG0F2XCN9uYod0gy4sXQfrgnOha202/eQcVpUx0C633rJH3cjGcnlqVvwRcrpjUo+mlr5F37ddxDL/Vy49mZ+gq832tXZJWgvm8xhZ7tLaO/nrAol7lvEyUJymE2Q6f5i48jAVCDh7DWYet62nHFrVKYymmq/5z13Qmt/NONH5ws4b2Vegdx6sJlOUSgayJZqnE9mnn1WbUlV8ck+BylbYGqIaEFvPbu4Cc8V+qEuaPBq5q5FSkFOFOrax6grrX3ohi4EZZmG+4+43bU1Qa3b1HfnssKZRvZGSSntWChjV8bw/YSTjpX63/2mUQdxPjycPV1VqcKwYfYg7j/+nXC/trXyvSank6M4KIKHb+o7vwx7voelytUhM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199018)(38070700005)(8936002)(5660300002)(7416002)(41300700001)(86362001)(6486002)(558084003)(26005)(186003)(66476007)(91956017)(2906002)(8676002)(7406005)(66556008)(6512007)(316002)(76116006)(2616005)(71200400001)(64756008)(66946007)(66446008)(110136005)(478600001)(921005)(38100700002)(36756003)(122000001)(6506007)(82960400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXNmUWxnUGlWNnZNTjFjcFYzVzZPWHVBNGpFeDRBTHhQRlRERHFvK251Z0xE?=
 =?utf-8?B?ako2TnpqcTNVY3lrdFRJM0ZvejczeVRQZ21qMWpaS2M1Y0c2Q3kwNVQ3Q04w?=
 =?utf-8?B?dnFQVzgrWlhONnJ3NWM0NGtocjZyMzhjeE5TT2diVG5HL3dZTGxBakFJY3hl?=
 =?utf-8?B?UG5hYTN3ZlZWRkhHU0toM0gwbzNUVEtXZ0UrK3d2N0d2b3p4ZlhPaVBSd1d1?=
 =?utf-8?B?WGZLSm9odlhNYXRnTHN0ejArWVhlNGl5UWRmZFRTa3lrYS9lVjRZUDdnMlVL?=
 =?utf-8?B?TTlyQ3BKczhkdFh4dk56aU44eGNNK3hmeGJYL2Z4ZmhJTFhDN0VuTUVZZ1dt?=
 =?utf-8?B?a1k0VE1FUzFEYzBqb09mVS90TmxJNkFqdEJtYWpWT21ZL0RVemwvUDZzRmdP?=
 =?utf-8?B?SmRZK0ZBT2JIc0R1SGhJV1U1bFVrb2kzSDI5T21YQ0dhNjlzNnRWL3JtbEJk?=
 =?utf-8?B?M213WVA5ejAzZkhIcm1seUhpSU85WHh6cktPNmdlWGNNeEp1Q3p2aXB1UVZp?=
 =?utf-8?B?VTlmOUdsTHpuNHFpdk1yUWFBYlhtR0ZNS2VpejUzeEpqbWV4T0VMK3hMV3A4?=
 =?utf-8?B?RW5XQjVqMzYzTUkxQzNDZS9wUCs1RlVxYlVwb2xTNVNQZWNVSDJkcnI4ZEpB?=
 =?utf-8?B?ZkExbGNvWWFoS1lac2tmYXc1dHBNeWE5S0dhRWVNRUVlMGk0MDFiY09lZ3ZT?=
 =?utf-8?B?a3dqZkpQZmx5R0srNHk2K2oyVEtWRmd2ckQvVnhlemMwektlcUlNQkJwQ0Vt?=
 =?utf-8?B?d0gxNnFxVEpxb25Vck04YjB3b0FHb1ZmaGVxdFFiL2lTZFRTQWhHZitkZlVh?=
 =?utf-8?B?RkdTMGVISTdkTlYrTFlOc1R5NFd1RzRIV2ZVamRCWDJPcVdQTFJZNGxNbUV3?=
 =?utf-8?B?aENGSU9hT2RBTFhvc0JTVDVaZHFvRTl4T0RwS1gydTE1T1N3aXk2QUFHWnRs?=
 =?utf-8?B?T2liSE9OTTRLVkVtYUw4VDNBdjJkZWpzaDcxbDNYQU03aFJLYk5CVGlMVktN?=
 =?utf-8?B?cHNvUEY0SHhuNFBOOVBOOER5QlF5S3QvTW1ZQ3pjWitpeTJyQUM2TjFjaEYw?=
 =?utf-8?B?YW1FUjl2ZXVZVk1aOEppc2JoM0R2WU9HeFJQZTZQTTJYVXR6dHRsbE5UUWZQ?=
 =?utf-8?B?UVMrTzZZNEE5UTIwdHhrVEtscjQ3ZjdRNElOdW16Y2gveW1hWHdHZUZNbENN?=
 =?utf-8?B?NzlVT0JFNzNzRjEybmhGalJkaFhSMythc0NXcENaenNLUC9iVkRrRTM5RjB4?=
 =?utf-8?B?U3Q1dkROS25zVVNBa0E3VGVlZUU1eXFuSjNic3lFUHlkZlhPUlJsN3dLWUhv?=
 =?utf-8?B?ZG5jc1ErRzJORk9jZU5nKzFiUHd3QjFUVVF4U1l2YzVVQmlkNkVEbC9RbU5J?=
 =?utf-8?B?bkNtQW9EM2JoRjBlc3ptaDJpOThWSWRKUnd1dE03Yk1VWXhrSXp4bE54NmUv?=
 =?utf-8?B?SWN4dzBEWDJDenBnVnJuVDZpUGFZY1V1N3NtRDZRaGlMcE9HK1NpTllpV3Qy?=
 =?utf-8?B?SFBSbUtOd0hxL0RjTTIrbUsrcEQwejJ4eDdZKzFjN3llVy9XVEtRTWg4Z2ZN?=
 =?utf-8?B?NUErLzFGZkxVZUI4bEZsZVBEQWkzaUc3Y1ZGSThJTW9qdGJ4UVltRmpEU2VC?=
 =?utf-8?B?RWJwK09pZnoyQjVmVHhWNlpmL3ZKTTRZdjR3MXdZNjNLQm53WFh1Z3AyekhN?=
 =?utf-8?B?MythdVV0d21aaEg5YTNSWStyUzREM0dmRzVCYmpJYTZBbmRzWjNraE9SRUtW?=
 =?utf-8?B?K2R0cG0ya2ZaN1I0aG1jSGp6V1VmMENORE5UeDlSS1N4M3Zzam1mM3FQS2dU?=
 =?utf-8?B?OUxXWDk5MVArVVNqeEl2V205NzhLdzVRcXlEeWlETkg4RmRzMm8wUmhlVHlj?=
 =?utf-8?B?Tk1VWTJHME0zZVRyUTNmQnlZWUhEcjM1UzZkM1ZOQk52MFllMmowdGlta3kr?=
 =?utf-8?B?N3p2dzd1WnR6c085M0xkcnZQNldXUFUrdU1VUDNTZUpNcVJVSHVqNjF2UVJX?=
 =?utf-8?B?czhjYU4zQmVYM2tzUFlIcHN1bnZpZUplNm5HTXkzb25TbkZZTUQ4MTZsVkd6?=
 =?utf-8?B?a1pOMStHNjJYa1NHNXlxd054cVI2dW95dVcwK3dZNkxOZ1hUUXNCZlM2NjFB?=
 =?utf-8?B?RGZUVzhsOWIxVTJUdmE5TmZxZUxGMVZNajhKTjR2ZkluRzVNRG1vZWtFWEh6?=
 =?utf-8?Q?ZZfBVoMZCy7c87SIpo8yLcw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3A23020D3096F458140B72727148F03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d556b353-e620-4d8f-1c2f-08db144695dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 20:02:39.7306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oh/0PP0jQCrNLl1FeTIciKIOqOhSHJsABjgyzVsd4aZRWX81G7edLiAPIL5ErldNAUpCi9HKwrHBp8eLysBNgbhgmm2oi2IOUFKr1oeZMgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIzLTAyLTIxIGF0IDA5OjQyICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gYW5kIG9yZGluYXJ5IEdVUCB3aXRob3V0IEZPTExfRk9SQ0UuDQo+IA0KPiBBY2tlZC1i
eTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQoNClRoYW5rcyEgQW5kIGZv
ciB0aGUgb3RoZXIgYWNrcy4NCg==
