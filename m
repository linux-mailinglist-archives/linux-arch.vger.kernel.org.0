Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A570C5FA1EF
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiJJQ3Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 12:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJJQ3S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 12:29:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDDC1C933;
        Mon, 10 Oct 2022 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665419356; x=1696955356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y31HIJg+/EIZCoZaRWOGtGDxOOzeoCylM8A2cM85UzU=;
  b=Tq6vOs3TyzgIr0ZNuydxmLOCaMy/V+pYSFIyq2V/6q/4lFsjiHCSlM6u
   qhzkc/2DV7+zD7q3ql7Z66c1gKQg9BzJM6Hj3vL9pf65JCoRJGKzlZnsX
   J+mdITluvB8mxihsaL3Qzm451+b8ag9qQsmuzui1FQ81mYu+OO5/WJave
   7LwynnBAJ5RWsJnASNCsQCoB8uwOn3A9YuOJBzCUOJcFgRKnMMSuElAhX
   WiFkl1DzOsR4ywRBPsEfyxRkobfO0r/gBhh1jR9kmDrD5GtJjWzyO0MPA
   y9BK7eOKAea/4TG4ANrlFAF/fppmZuGjzj4GMZ99ja8T2jO1x0H06ahWQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291561051"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291561051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 09:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="730600903"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="730600903"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 10 Oct 2022 09:29:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 09:29:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 10 Oct 2022 09:29:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 10 Oct 2022 09:29:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NROMR2MlXlDS4QBvHS+Rr9OjbzivsbbNQ+1Dm/efL0D/Aa9p6TFGJKGlVoCj66mWmxF03dCyXeT3wTHJWCzmziFKbX1nnK7O82NI45VBZh9Kc3yAmJ12hJmFAyB7CVWN4J3lClAxDPiRZdOCh98vqBA8QPMk23O2TJKVG3a7t3IF4QP511+BYflfWFhDjjSF1ZrIfTImVhWrnd85DwgJCXsmGkN8FAkhdZ48secPmfIQogl/XjRHIcAl1eBWXdWrL3lmkhnvia0+2o6RMieLUeaMEUflcSpNcqJ1UtmrzvcZpQA+DT77xqkBRwdr5sl27UvA5bR2vakDHj5kxJWKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y31HIJg+/EIZCoZaRWOGtGDxOOzeoCylM8A2cM85UzU=;
 b=WYQ5Xy9A+NAI4SP/9RFIHdUA8D+PDQn4MnvLuTotwds23ohLqdopz2XMTvybqWzQ9mapWqnS2UYROrecWDBKyz3eDjIzDwaMMPivN3oCLr2BcHCR+rxhUgTaD7ALZp1aWXO9CCO8C/IvaEojXaVdx3y/iIBrUzmF1cByvkzj17LrZbvABLOea06EIRDnefPVVYgIQMtSPSPWzSHeXW1p6uajMFyKbCWA3HxfhrJ5gcC5HyaGd240IEFhZflx1UPiIg2dyJytYKndJAzwFQiubNqqnNnR/fld6l5aA27TsgBwHsMzISFOgOZxK9hGlAiT2H8MS2rAdm/KP5Jzcvo3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB4548.namprd11.prod.outlook.com (2603:10b6:5:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 16:28:58 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.040; Mon, 10 Oct 2022
 16:28:58 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Thread-Topic: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
Thread-Index: AQHY1FMhBBwtibGlfkiKNuNOGUg8sa4HhVsJgABcyIA=
Date:   Mon, 10 Oct 2022 16:28:57 +0000
Message-ID: <8599719452d9615235f7fdd274a9b6ea04ab1f7c.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-24-rick.p.edgecombe@intel.com>
         <87v8os0wx5.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87v8os0wx5.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM6PR11MB4548:EE_
x-ms-office365-filtering-correlation-id: a2e25d1a-7a40-41f4-4809-08daaadc882d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZARB/NzePpZ5qBt8g9k8iMjCeRZiY7IIO/s7y7F5+Xzk111sWi+4V/uk5Z6T7Edvq/TQroqZt60zkdCVAwr89+26uHJNTIc8a7MGrTvrctIxzGVTaPdHwkBmiSwCW4c/0cbhC91L8gaBPvn9lDjSSVQG8KxncK/d4OIkrPzKNvdL+C3qBrp/hPROgHUAeeX1lGTDtnH/Vgv9SRGpkq4GdghEtKH+8YgV7iEJCljr75RhjuHTKZ+7uzLXchjD3sOs5e4Gk3Jr/MOP1YAOpsqQmwUEaAKkbHLZboTxEdBcmedxVA88licpo8tWJvbGdQHLmbcedfsSND9R5HEZk/Ao90IW4LExaUsWETwDwlKx+8LZafdJy0ry3xQcC2moRkr2aStN9H69Cr5G2L7U1LirubqoRw2xjSgb5xyM1SOAJ4T/KpfARDo8z+NzSopcUYmmhH0dEfno3Puh1malMsGUdCzYcPnOiNbAUT6GGSVm3tN/UiL/z1BBX6eznfKsTS3vFYAmtLsczMJWirVOkv+7P4kpUzrM2pjl78tfhIvvCyOVVyn7NFBirdgi0ZnOHT3wxoFEZyo5CWd9dpL35X1GrDk1Junb7Xqs2bDGG83jsI+Rgqndr9inqK2UtkUGhl3n3cdkKuOI3wl6xH+DNv4lkorGEux6s1QXUpwqgnRTlXLEGd6KCD38zQElHfUT/w5pGWxfVhxK9jIPo8H6pf7q/fkkk5mjhDHFZgMYL+EdGA1QwWzjBgh6BlDgY5PdFg/0+XIuO6nwP8O3FKkVMRFzn1TuaQSi7ytToMm+UAQSKlEX011U+fAja9qQesbP9gS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199015)(5660300002)(7406005)(7416002)(8936002)(36756003)(4744005)(6512007)(26005)(2616005)(4001150100001)(6506007)(2906002)(186003)(122000001)(6916009)(38070700005)(316002)(54906003)(71200400001)(41300700001)(478600001)(4326008)(86362001)(66446008)(64756008)(8676002)(6486002)(66476007)(66556008)(76116006)(66946007)(91956017)(966005)(38100700002)(82960400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW4yNzRtazNjOU4wWUdvempmZVhCMXFObXdXU1ZJYTJPTDlxZnpGK2h5SExh?=
 =?utf-8?B?Wms0SjZLbWsxYk9sMEFzblc3VFozZ2JpeWVFRW00cEh3NlpURE8yQ3dId1BG?=
 =?utf-8?B?UFBFVlk0ZWlqTlVwREpKeWx4STlhc0NQUmdrRTJITmJWYlVxa25CRHgzRVgy?=
 =?utf-8?B?UWtPSStzVW5GUWlOOEY4VTc4V3Q4VVpheDRYY1hMTmhhejFIdmZUSENDamxi?=
 =?utf-8?B?eWkwZWRqVTE0RmQ5eE1vd3NzOGlvMzBDd2crejBiUWo3d24xQldJTkEyZ1FS?=
 =?utf-8?B?K3loNzJsTGtRQVM2ZUNORDNUSUJTQnpxai8vZWdMWDdtNXluOHZGUnVwYXZw?=
 =?utf-8?B?bEtvOTlyN0k0RTdVNzZmOGhkZVo3aGMwVXc1bWJWb2F1c2RHQ0tBYmFrYzVB?=
 =?utf-8?B?TjhENlBBM05WKzdZdG5uUVZzUHhuRzU5QmNaOEI3MTdqSFA5c2E4Qk1vY2t5?=
 =?utf-8?B?NTg1Wnlyb1dUYWZnN0hwMjRuZ0pwRWhzc1d1TFZxT3I1R3NoU2d1eEhGZE1w?=
 =?utf-8?B?eVduVWVNOVRKSUpqRTZuK1RDK1JwREF0ZW5CQ1JCczZYTnk3UGlrTVoxbXAy?=
 =?utf-8?B?NTQ2cjJQbGVyK24xRzFhOERncEVtYzhVTEx1RkpwKzMybUt2S2hnckZjdHVz?=
 =?utf-8?B?UXdFSjBicXRnUlorTFRKZW53SGcrTW1NaXBlMUFzU0k1eE9UV0J5dU9pdHpv?=
 =?utf-8?B?Sy9uLzM0N1V1cHhSMGUyWmZ5Y0pwZ0xWUVRRdEthdjZ0bHZXU0xsRDFaYkxZ?=
 =?utf-8?B?RmtVYjk1UXNrQ1lsTC9sNlNTcW9EZ2xFRzdYd1hQQ1ZtY1Rzc0xwK3R5ekp6?=
 =?utf-8?B?amg1cmoyWXhLVXVkUks1ZGdjNVRDamRQQ0pwQWM3RG5kYzFPV3UreWJ2S0Uy?=
 =?utf-8?B?YTNTWXIzYVg4VEtkNEMyZFFEWFBUTEtoa0ppeVFVLys2cFVpT200aHRCa2dh?=
 =?utf-8?B?QWxEQWdwZVpVUk1WNVVUdXNobXJ5MEo0L2g0eFBqVHlJZjJiQ3hBK1ZHdXEv?=
 =?utf-8?B?azM5SkdjdzM3bmJZZE8rZUFQc2JwdUx5OEdGem15Z1BMRFduaHJFNFRuUklO?=
 =?utf-8?B?R3o2VVVramY1Wnk2VUJYYUlzSE1WaUY3N09CNFdTVkRFQUczdENhYndpOWF5?=
 =?utf-8?B?MzNWZWJKOGFzRERsN3k5cDluSzI0Y2gvZnZOcmFqYVM5dWtkZWVMbmR5RlFP?=
 =?utf-8?B?aVlraE5QTHBWZ0VpVDhZeDhLZ2c1RmZtZkNWaXIvTEsxQWVWTTZsRE5yelQ4?=
 =?utf-8?B?TE9mZWIxMms0eW9wcXR1SmpIamNQQXljVFpUK2srdWJHa01IWUJQUDJEZVUr?=
 =?utf-8?B?WTVrWngwa0p6dEcxdmdOeFM5RFFseGs2b1dnMnVucDJaQXo1NXlBSVZIWGN5?=
 =?utf-8?B?NmJ1a3k3NUtTL050SWpmYWl4Q0h4NnYxWDJpbHUxd0thNmx2MHEwcktONkJx?=
 =?utf-8?B?SDZyRFE5b3JzSnZ1Q2k5NnU3UlhoelVzSVdjZDNBelpRdFVUSVZuYUhkSU5i?=
 =?utf-8?B?bkNCOE5ncXRaaDU5QXdJNkVIa1g1Ym10TGdoWTlkMXFObW9sTzZhYjNZcHJV?=
 =?utf-8?B?RjBSY29HT25JbEpDQlMwMDZ5cFRhWXErRThxTHQrRkVEWklOV1FJOVFGUWhT?=
 =?utf-8?B?UzZCL0VMK1Axb0N0TkdRekZOczUxQ3FQcTU1aHE2M2p2RmVoY29SZWhXOUhL?=
 =?utf-8?B?ZENkNXVpcDFZNEk3K1pHZmYwRmQrZGhqcWtCRUxMNVFKNWptdVN0a1NhckVl?=
 =?utf-8?B?VFdkYkVPdWlwck14OTkzWHRmMEFFZW84Rmw2S2E4dWJmY0x5NDVtd21XbDZs?=
 =?utf-8?B?NzBzcnpnb25LOThKYWN1S05nSUt2ME5NczlTbFlhKzFFb0Q5YmZva1ZNRGU5?=
 =?utf-8?B?S0JrWnJhcm1aUDRGS0N5WHVKSWNlYkpUaXFCa2F4c2FPSGNiYzlZRlA2TGk1?=
 =?utf-8?B?RFdzYWtyT29VMUpXRjZXbklWOGQ3a05mc3g1S3dROFJjVWZiN2NnNjJ2dDBl?=
 =?utf-8?B?YnM3SEdFNjdELzNpRmRMOVFmV2FjZUwrZWpWRHRlWkpqUlV6K2N2dzdjSllN?=
 =?utf-8?B?VDBoNDlta0N2Zkp2bDVlTzZ4MWdDbVFmcDhtSDBYZUY3T2JXQUZMcnZUY2Js?=
 =?utf-8?B?bzVjN3FjRGRuWml4UERvTThmZTZsZWNYRUxvdWx5Ky9Wd0tnNEFkcmdqeHI2?=
 =?utf-8?Q?t/s2ZAjTiLUSQt5APV7lvUA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4CF9C427BC1A04298000982113C3827@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e25d1a-7a40-41f4-4809-08daaadc882d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 16:28:57.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxJMY0b5tjwaeMFpi8TNrb/Ikd1V7AwRex4YEApZ+BQctIyFhKOcgJA0PqhFcjOQbBp6U28/Gm/avjlChGfYSp0B7p8r6mAzlH3KoQUXRVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTEwIGF0IDEyOjU2ICswMjAwLCBGbG9yaWFuIFdlaW1lciB3cm90ZToN
Cj4gPiArICAgICAvKiBPbmx5IHN1cHBvcnQgZW5hYmxpbmcvZGlzYWJsaW5nIG9uZSBmZWF0dXJl
IGF0IGEgdGltZS4gKi8NCj4gPiArICAgICBpZiAoaHdlaWdodF9sb25nKGZlYXR1cmVzKSA+IDEp
DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IFRoaXMgbWVhbnMgd2Un
bGwgc29vbiBuZWVkIHRocmVlIGV4dHJhIHN5c3RlbSBjYWxscyBmb3IgeDg2LTY0DQo+IHByb2Nl
c3MNCj4gc3RhcnQ6IFNIU1RLLCBJQlQsIGFuZCBzd2l0Y2hpbmcgb2ZmIHZzeXNjYWxsIGVtdWxh
dGlvbi4gIChUaGUgbGF0dGVyDQo+IGRvZXMgbm90IG5lZWQgYW55IHNwZWNpYWwgQ1BVIHN1cHBv
cnQuKQ0KPiANCj4gTWF5YmUgd2UgY2FuIGRvIHNvbWV0aGluZyBlbHNlIGluc3RlYWQgdG8gbWFr
ZSB0aGUgc3RyYWNlIG91dHB1dCBhDQo+IGxpdHRsZSBiaXQgY2xlYW5lcj8NCg0KSW4gcHJldmlv
dXMgdmVyc2lvbnMgaXQgc3VwcG9ydGVkIGVuYWJsaW5nIG11bHRpcGxlIGZlYXR1cmVzIGluIGEN
CnNpbmdsZSBzeXNjYWxsLiBUaG9tYXMgR2xlaXhuZXIgcG9pbnRlZCBvdXQgdGhhdCAodGhpcyB3
YXMgb24gdGhlIExBTQ0KcGF0Y2hzZXQgdGhhdCBzaGFyZWQgdGhlIGludGVyZmFjZSBhdCB0aGUg
dGltZSkgaXQgbWFrZXMgdGhlIGJlaGF2aW9yDQpvZiB3aGF0IHRvIGRvIHdoZW4gb25lIGZlYXR1
cmUgZmFpbHMgdG8gZW5hYmxlIGNvbXBsaWNhdGVkOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzg3emdqanFpY28uZmZzQHRnbHgvDQo=
