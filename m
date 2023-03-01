Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD5D6A72A1
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 19:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCASHp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 13:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCASHo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 13:07:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF913B464;
        Wed,  1 Mar 2023 10:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677694062; x=1709230062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D/wnnqvH4WCTFxBzIZJlEPLhrgA9nKFbJuv5Ir2u01c=;
  b=eQ3YHDsvEIlXoDQl+EyjXquS9L91wx96adsykp/gpRTuagqdXo8G458d
   Hq4LU0SDkyQckVHbxFf6x+CYryw2a9xXBsACfW35uBVe9HR2CcTfVcZbN
   mBfOxSGzjQ3St2KhSFh814sEihJAqQ2WhVqm323QQyaug/m+X5/7oDUOa
   qKZGNpdidxSaDKbIeE0p9cLQI/OkqQgrkbw8PgrVSe8BGwNGaf0ppc7GA
   8+bda/UaF7IEA4cAF9SyE6uHGwgzyjvEQl51tEubIbe7MTbH6gTfwhUJW
   IBU9hM2xpaKMn9zFkMXs/yprwq2d8g9aD9PJmWJKs/JNxAt3xBJvsbE/p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="334513773"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="334513773"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 10:07:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="652101422"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="652101422"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 01 Mar 2023 10:07:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 10:07:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 10:07:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 10:07:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 10:07:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtHG2joYT3T2SfiWllBsgV1qBaD/mZcRigki3wNusqnupfFMQHrjZcOmX8/+VZ58qqxY9LRF3exD5nrZoymKu0STk4HzbWSNk4sOe3NC/DTT6SJYPGyMcmMP8OBMia7HpV2H9ngknVEfsx1z+Tigi254vSqSmyj6ZgLjvPLrDoCLUiOokIJxoddxM+TzhdeHLI3ZX77qdbrm824yiFQ0XJzB0bN9ea9E1V/luFx85WkPL3hUl1mDW7jkmEp0U3SDgrewk2d6bOC5Q/a5mjY+5D6nRsaLUNe/dxe/UbL58Rbz273exjYl0JXYJQokGKHl6WpGwgU2PzqC6xkeUkYwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/wnnqvH4WCTFxBzIZJlEPLhrgA9nKFbJuv5Ir2u01c=;
 b=ZfzoKrGq0kbbXShWNM046UwewRjdKT160/5t02Id8dehDBgLjRgDMDZldctgt6ZQ2qL69fDf84Mb3dDDsqJyC5F6gMw1nf6qujC+5vw2wDLO2WmJe4jtdcbuA+uAa7ZT3OKI6UNbZB5zqt47xHAJPfzqu1jyfbAxhy1URl+rOiivkVavJNo1YWZepCduWrP0VGSms/Qd1W56mKY1VX1a2EIMR62fAQVKachAJF5Q4kx9L98rx+2/AxkpBsC9zLeIpC2I5iP4JKGSmkxIXlh5ONVnD/MIdjivjSEhUGtBqSQQ+c7jvTByPDreQV+ZzM4Dq19ppD6eUC6JDw/qgSuloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4598.namprd11.prod.outlook.com (2603:10b6:208:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 18:07:34 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 18:07:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZSvs0qmse+4pcp0Wr5jGCLtkFY67l/FKAgAA/GgA=
Date:   Wed, 1 Mar 2023 18:07:33 +0000
Message-ID: <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
In-Reply-To: <Y/9fdYQ8Cd0GI+8C@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4598:EE_
x-ms-office365-filtering-correlation-id: d85854de-61f6-4a53-3abe-08db1a7fd4d0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ev3MGcfRIafbyrNNBtcmWcFn60hKnFVzCHO1QE0y4/MHxc0PMwGUo0SaiBrgH39InG1HRvReTVcQb6dLE0b2UN9kbfpuLqh7BSV3tROPcNkWhGhwFdHS+CFz9C3+jzzu/MbYm1DGkqzxZT/4lqD4Anebfk23+n1BIKuEYcps2HRACboa8rk8GHze8UsxHoCugV5SKTPdI5yvqQ2n6N6KLePCz8wstjYI2/fy+45isAGoc6zD5S1YNUYpLOxXZHs0PB2epjEq34fQcTnrGDBvORoTlTOprbBFROww/OyVkFJk0oou3lTDS9mKf4N/zq1pbXikKwTENnspTR4mByr5RQwKN7u5RS/luSFrfb/vdwq3oa9384bRBghdg05y9HyNkdrkNK7zE0ux4dUgsXWG26cZ766r1GcqNR7dncQPDtHNF3KAMQBJv5KMEcF7/qm6AIXKQhKULSayeKBg5nT0R9sDAOt3X3fC2sHQo4QjuVo41aJsU2KtXjX5vIU5LzkVeP+GP01z8OB97KU+cM4gvZICJ7oOmY/oq0GRq13wMfDayov12Y6LkmwvaoIa37zO3/4JnK7hY3TVV7G+7a4944PmCvtVbsQLoL72q0b0M31SW3p1QH+VwF3Qr02UHFT9POEpuEWH9D7hgt8Yl+udOcnFDEBXwPcXLxp6iARhnHfPiVTfufic6cClAx852YgNskatxS1bSS9OTspSsKITaAigwrc50Lfr+ctKqDXEke8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(36756003)(5660300002)(41300700001)(86362001)(66446008)(64756008)(8676002)(7416002)(66946007)(7406005)(8936002)(66476007)(4326008)(30864003)(2906002)(38100700002)(82960400001)(38070700005)(66556008)(122000001)(921005)(6486002)(966005)(316002)(91956017)(478600001)(186003)(71200400001)(76116006)(110136005)(83380400001)(2616005)(6506007)(26005)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b25aOG94WTVsdzVQb1hOQUF5V3ZsdTFQZklBTjUwVmhjYVMzb0FVOVhVWXdj?=
 =?utf-8?B?T0R3K2RzWlVDNkJNM0dOTklJS2J6N3dBdjcvOHVJU04vbTFaSUlUZmRlcGRH?=
 =?utf-8?B?UzlXekdUVCt5UHFjSTdOQlVpRDhleExaRXJ5ckJsTStlNU9xZi9abmZ4M2hM?=
 =?utf-8?B?ajJ0M2g0OCtPRTZNU042M2dUSHJSdGE0YmZpWm5rNkNJRXRMQ0MyWXBnQ2hV?=
 =?utf-8?B?TE1mNDYyOVByMnFpOHFiand2VElqSlQ0NDZIaWwranoyMEd3eXZIWFdJQjhX?=
 =?utf-8?B?WkwxUlVRcEZvSVFQOW1tcDVGalZzUi9lSGMwMVhCWlBUazhxSERScHVDWFBs?=
 =?utf-8?B?R2V3cm1yVHBQN1JyOUVUaDFJbGlZZ25KRVFaVy96YU41NFd3RWxKMk5UUEJa?=
 =?utf-8?B?Rnh6WTF6UlJ1UUpHOE9BcEtDbGY0M3NsOFNzdmVxSjV6anZHUmJQOVF1aGV3?=
 =?utf-8?B?UjdXY1UveTVjTHQzQ0IxSDZZdU1HVGliK2ViZnVjYWJYRThpYkkyaVJlV04r?=
 =?utf-8?B?OWJ3bWsyMU5qbWVKVlVnaGw5bElab0pZZHFTalg1Vy9Jd0ljMGRYT04zdHlD?=
 =?utf-8?B?QU42THJ5bUZkT09Ib3Z1N0dsWUtERUl6ZWJBVlVyaWV2Vmh5TjZjaWVqOXp3?=
 =?utf-8?B?aFYrbDUyWFBzZHNTMmJDRHZ3MVRRWjQvSXRLd1dqL2orK1B5OVVtdG9kVFp6?=
 =?utf-8?B?WHkzeEtnc0FzUzhaMTVwS1JydHczbkVNQ3dLV0pZWEZTN1I5OE1CcHRTNXhh?=
 =?utf-8?B?UWVIYWRUdTFHejhzREdlM2FJSmM1bHArbXRNbkJRM1NuMG1yeHJEd1ptRFhh?=
 =?utf-8?B?ODVndVVIR0JEYnJVTG52anNMK2dCSWdTR2lmRlVwNjBLY1NaZzBNeHFENkoy?=
 =?utf-8?B?blZqREZyNDBDb2FpTzdVL3dLdFZEWnhIWktsamR5bGg5S01aZWFTY090dU52?=
 =?utf-8?B?NzAzcDNPZzZxNEhyYkcxT0owRWxZQUhFa1g3VDRaWGEzNUJZR2FrRnF5SzAz?=
 =?utf-8?B?bmpPOGJvN1VSWitpS0xYcTVZcFJ5cVJ6OGY4NUNhU2hZcmRYT0xrc1l3ZUJC?=
 =?utf-8?B?aStSTUpyUVVUM1k2OHViV0RMbXMrbCtYQm9Td3RaUjQvYjgwaGRKelJ3VXFa?=
 =?utf-8?B?RkxLTzFmSysyUStEMGRwekxsbko1elpJRFZ1WXBrQ1ovL050aFZQRU0vVld3?=
 =?utf-8?B?NzJ4U3Z4K3ROVDc4dmRseXZWRURnam10QTR6ampiUTZBbVZOK0dSMzlWdVJS?=
 =?utf-8?B?VUVENjQrY0VXMHlOK2pVVDE3eHBBeHVHRm9TNGZjR0Y2eTc1TnMwdC81Tk5T?=
 =?utf-8?B?bjROWE5aK29POEV2NmxnbjVNT0xMR2N4ZTJNY2xvWUZmZE9UbklqTTBqV0c3?=
 =?utf-8?B?TmF5eGZ0TTlLN29Ec2N6clpEUmg2bzBwVlRYS0g0MFE5ZDJOMTRZUFNRdmEr?=
 =?utf-8?B?WUVHU21ESEtsei9MK05kY28xNUh3OHRqZTRvY0pqOWo5U2NCbkJoRG9TOFpa?=
 =?utf-8?B?NVU1TVZSQXdnNDh1MElaUENMZkQ0RGF5cnlrVlJFb1FlNGtwbGplMWZDL3kw?=
 =?utf-8?B?MWdzZXM0QU5OZFhsWGZNeVp1aWpxS0VYRFFzWXVJVnNIUUY3dGo2WlVGSGw1?=
 =?utf-8?B?YTc3dmdvQzV1ZlZIWWt5Q2grUittaG1OVU1OWjFMK2FQWXErQzRXeVJjVU1O?=
 =?utf-8?B?bWFIa2VMZWZ2dk9lTXB0S1pMdWRRR3lPcHNCdXdoUzdjdmZTcm5CRDA0T1dI?=
 =?utf-8?B?MllhUjhpZ0xueGxKclJ2Qi9KNHY1M1ZoVUR1SFRUVUh0TDhHaEo0SldBUnJK?=
 =?utf-8?B?U2V6NWtnUTRqTVEraHNEUFFZQ2dkeE9tSE82RndFdW1XeTcxV09XYnUyU0lP?=
 =?utf-8?B?b3ZMY2tWMUg0MmNpb3JFUEJtMUtaTFdiZklERGZXUGhEUkI5aUxSZzNtVDg2?=
 =?utf-8?B?VVVMS1I1TTYwZG9FNnFRZkI3eExsQm05R2RpSUF1VEhYZzQ5VlB5NndvQmJu?=
 =?utf-8?B?OFFZK2lPWHlNTExlYnBkdzhpT0dPZyszbEx6dStKS1hkc3pBSDdZSlQ4MDNt?=
 =?utf-8?B?bXRhS1pHdUNTbzNVL0lQS1RxRVFTemk5NFlZc21vNmd1VURzNS9laTZHSTd1?=
 =?utf-8?B?bC9FOWdCRTBKYVRWcE04SUwvWmZ5b1gwZGRZZ2pxbmp6dm9acXlEa3BucEZl?=
 =?utf-8?Q?SgGK+xsZLRrqLKhcyoqAbw8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBD09F971B5B794891390C6DC90CCF5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85854de-61f6-4a53-3abe-08db1a7fd4d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 18:07:33.6486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkwCiaMpT9bMqRbQ2pphfz+5cmYw9wB+Lri0OX1tSmih+ccn2D8/O583K3eMsR1XsGRqAuPpljLJ+9fS19ZR1o+MdOQQyQBrJoqmccEtFFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4598
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTAxIGF0IDE0OjIxICswMDAwLCBTemFib2xjcyBOYWd5IHdyb3RlOg0K
PiBUaGUgMDIvMjcvMjAyMyAxNDoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gK0FwcGxp
Y2F0aW9uIEVuYWJsaW5nDQo+ID4gKz09PT09PT09PT09PT09PT09PT09DQo+ID4gKw0KPiA+ICtB
biBhcHBsaWNhdGlvbidzIENFVCBjYXBhYmlsaXR5IGlzIG1hcmtlZCBpbiBpdHMgRUxGIG5vdGUg
YW5kIGNhbg0KPiA+IGJlIHZlcmlmaWVkDQo+ID4gK2Zyb20gcmVhZGVsZi9sbHZtLXJlYWRlbGYg
b3V0cHV0OjoNCj4gPiArDQo+ID4gKyAgICByZWFkZWxmIC1uIDxhcHBsaWNhdGlvbj4gfCBncmVw
IC1hIFNIU1RLDQo+ID4gKyAgICAgICAgcHJvcGVydGllczogeDg2IGZlYXR1cmU6IFNIU1RLDQo+
ID4gKw0KPiA+ICtUaGUga2VybmVsIGRvZXMgbm90IHByb2Nlc3MgdGhlc2UgYXBwbGljYXRpb25z
IG1hcmtlcnMgZGlyZWN0bHkuDQo+ID4gQXBwbGljYXRpb25zDQo+ID4gK29yIGxvYWRlcnMgbXVz
dCBlbmFibGUgQ0VUIGZlYXR1cmVzIHVzaW5nIHRoZSBpbnRlcmZhY2UgZGVzY3JpYmVkDQo+ID4g
aW4gc2VjdGlvbiA0Lg0KPiA+ICtUeXBpY2FsbHkgdGhpcyB3b3VsZCBiZSBkb25lIGluIGR5bmFt
aWMgbG9hZGVyIG9yIHN0YXRpYyBydW50aW1lDQo+ID4gb2JqZWN0cywgYXMgaXMNCj4gPiArdGhl
IGNhc2UgaW4gR0xJQkMuDQo+IA0KPiBOb3RlIHRoYXQgdGhpcyBoYXMgdG8gYmUgYW4gZWFybHkg
ZGVjaXNpb24gaW4gbGliYyAobGQuc28gb3Igc3RhdGljDQo+IGV4ZSBzdGFydCBjb2RlKSwgd2hp
Y2ggd2lsbCBiZSBkaWZmaWN1bHQgdG8gaG9vayBpbnRvIHN5c3RlbSB3aWRlDQo+IHNlY3VyaXR5
IHBvbGljeSBzZXR0aW5ncy4gKGUuZy4gdG8gZm9yY2Ugc2hzdGsgb24gbWFya2VkIGJpbmFyaWVz
LikNCg0KSW4gdGhlIGVhZ2VyIGVuYWJsaW5nIChieSB0aGUga2VybmVsKSBzY2VuYXJpbywgaG93
IGlzIHRoaXMgaW1wcm92ZWQ/DQpUaGUgbG9hZGVyIGhhcyB0byBoYXZlIHRoZSBvcHRpb24gdG8g
ZGlzYWJsZSB0aGUgc2hhZG93IHN0YWNrIGlmDQplbmFibGluZyBjb25kaXRpb25zIGFyZSBub3Qg
bWV0LCBzbyBpdCBzdGlsbCBoYXMgdG8gdHJ1c3QgdXNlcnNwYWNlIHRvDQpub3QgZG8gdGhhdC4g
RGlkIHlvdSBoYXZlIGFueSBtb3JlIHNwZWNpZmljcyBvbiBob3cgdGhlIHBvbGljeSB3b3VsZA0K
d29yaz8NCg0KPiANCj4gRnJvbSB1c2Vyc3BhY2UgUE9WIEknZCBwcmVmZXIgaWYgYSBzdGF0aWMg
ZXhlIGRpZCBub3QgaGF2ZSB0byBwYXJzZQ0KPiBpdHMgb3duIEVMRiBub3RlcyAoaS5lLiBrZXJu
ZWwgZW5hYmxlZCBzaHN0ayBiYXNlZCBvbiB0aGUgbWFya2luZykuDQoNClRoaXMgaXMgYWN0dWFs
bHkgZXhhY3RseSB3aGF0IGhhcHBlbnMgaW4gdGhlIGdsaWJjIHBhdGNoZXMuIE15DQp1bmRlcnN0
YW5kIHdhcyB0aGF0IGl0IGFscmVhZHkgYmVlbiBkaXNjdXNzZWQgYW1vbmdzdCBnbGliYyBmb2xr
cy4NCg0KPiBCdXQgSSByZWFsaXplIGlmIHRoZXJlIGlzIGEgbmVlZCBmb3IgY29tcGxleCBzaHN0
ayBlbmFibGUvZGlzYWJsZQ0KPiBkZWNpc2lvbiB0aGF0IGlzIGJldHRlciBpbiB1c2Vyc3BhY2Ug
YW5kIGlmIHRoZSBrZXJuZWwgZGVjaXNpb24gY2FuDQo+IGJlIG92ZXJyaWRkZW4gdGhlbiBpdCBt
aWdodCBhcyB3ZWxsIGFsbCBiZSBpbiB1c2Vyc3BhY2UuDQoNCkEgY29tcGxpY2F0aW9uIHdpdGgg
c2hhZG93IHN0YWNrIGluIGdlbmVyYWwgaXMgdGhhdCBpdCBoYXMgdG8gYmUNCmVuYWJsZWQgdmVy
eSBlYXJseS4gT3RoZXJ3aXNlIHdoZW4gdGhlIHByb2dyYW0gcmV0dXJucyBmcm9tIG1haW4oKSwg
aXQNCndpbGwgZ2V0IGEgc2hhZG93IHN0YWNrIHVuZGVyZmxvdy4gVGhlIG9sZCBsb2dpYyBpbiB0
aGlzIHNlcmllcyB3b3VsZA0KZW5hYmxlIHNoYWRvdyBzdGFjayBpZiB0aGUgbG9hZGVyIGhhZCB0
aGUgU0hTVEsgYml0IChieSBwYXJzaW5nIHRoZQ0KaGVhZGVyIGluIHRoZSBrZXJuZWwpLiBUaGVu
IGxhdGVyIGlmIHRoZSBjb25kaXRpb25zIHdlcmUgbm90IG1ldCB0byB1c2UNCnNoYWRvdyBzdGFj
aywgdGhlIGxvYWRlciB3b3VsZCBjYWxsIGludG8gdGhlIGtlcm5lbCBhZ2FpbiB0byBkaXNhYmxl
DQpzaGFkb3cgc3RhY2suDQoNCk9uZSBwcm9ibGVtICh0aGVyZSB3ZXJlIHNldmVyYWwgd2l0aCB0
aGlzIGFyZWEpIHdpdGggdGhpcyBlYWdlcg0KZW5hYmxpbmcsIHdhcyB0aGUga2VybmVsIGVuZGVk
IHVwIG1hcHBpbmcsIGJyaWVmbHkgdXNpbmcsIGFuZCB0aGVuDQp1bm1hcHBpbmcgdGhlIHNoYWRv
dyBzdGFjayBpbiB0aGUgY2FzZSBvZiBhIGV4ZWN1dGFibGUgbm90IHN1cHBvcnRpbmcNCnNoYWRv
dyBzdGFjay4gV2hhdCB0aGUgZ2xpYmMgcGF0Y2hlcyBkbyB0b2RheSBpcyBwcmV0dHkgbXVjaCB0
aGUgc2FtZQ0KYmVoYXZpb3IgYXMgYmVmb3JlLCBqdXN0IHdpdGggdGhlIGhlYWRlciBwYXJzaW5n
IG1vdmVkIGludG8gdXNlcnNwYWNlLg0KSSB0aGluayBsZXR0aW5nIHRoZSBjb21wb25lbnQgd2l0
aCB0aGUgbW9zdCBpbmZvcm1hdGlvbiBtYWtlIHRoZQ0KZGVjaXNpb24gbGVhdmVzIG9wZW4gdGhl
IGJlc3Qgb3Bwb3J0dW5pdHkgZm9yIG1ha2luZyBpdCBlZmZpY2llbnQuIEkNCndvbmRlciBpZiBp
dCBjb3VsZCBiZSBwb3NzaWJsZSBmb3IgZ2xpYmMgdG8gZW5hYmxlIGl0IGxhdGVyIHRoYW4gaXQN
CmN1cnJlbnRseSBkb2VzIGluIHRoZSBwYXRjaGVzIGFuZCBpbXByb3ZlIHRoZSBkeW5hbWljIGxv
YWRlciBjYXNlLCBidXQNCkkgZG9uJ3Qga25vdyBlbm91Z2ggb2YgdGhhdCBjb2RlLg0KDQo+IA0K
PiA+ICtFbmFibGluZyBhcmNoX3ByY3RsKCkncw0KPiA+ICs9PT09PT09PT09PT09PT09PT09PT09
PQ0KPiA+ICsNCj4gPiArRWxmIGZlYXR1cmVzIHNob3VsZCBiZSBlbmFibGVkIGJ5IHRoZSBsb2Fk
ZXIgdXNpbmcgdGhlIGJlbG93DQo+ID4gYXJjaF9wcmN0bCdzLiBUaGV5DQo+ID4gK2FyZSBvbmx5
IHN1cHBvcnRlZCBpbiA2NCBiaXQgdXNlciBhcHBsaWNhdGlvbnMuDQo+ID4gKw0KPiA+ICthcmNo
X3ByY3RsKEFSQ0hfU0hTVEtfRU5BQkxFLCB1bnNpZ25lZCBsb25nIGZlYXR1cmUpDQo+ID4gKyAg
ICBFbmFibGUgYSBzaW5nbGUgZmVhdHVyZSBzcGVjaWZpZWQgaW4gJ2ZlYXR1cmUnLiBDYW4gb25s
eQ0KPiA+IG9wZXJhdGUgb24NCj4gPiArICAgIG9uZSBmZWF0dXJlIGF0IGEgdGltZS4NCj4gPiAr
DQo+ID4gK2FyY2hfcHJjdGwoQVJDSF9TSFNUS19ESVNBQkxFLCB1bnNpZ25lZCBsb25nIGZlYXR1
cmUpDQo+ID4gKyAgICBEaXNhYmxlIGEgc2luZ2xlIGZlYXR1cmUgc3BlY2lmaWVkIGluICdmZWF0
dXJlJy4gQ2FuIG9ubHkNCj4gPiBvcGVyYXRlIG9uDQo+ID4gKyAgICBvbmUgZmVhdHVyZSBhdCBh
IHRpbWUuDQo+ID4gKw0KPiA+ICthcmNoX3ByY3RsKEFSQ0hfU0hTVEtfTE9DSywgdW5zaWduZWQg
bG9uZyBmZWF0dXJlcykNCj4gPiArICAgIExvY2sgaW4gZmVhdHVyZXMgYXQgdGhlaXIgY3VycmVu
dCBlbmFibGVkIG9yIGRpc2FibGVkIHN0YXR1cy4NCj4gPiAnZmVhdHVyZXMnDQo+ID4gKyAgICBp
cyBhIG1hc2sgb2YgYWxsIGZlYXR1cmVzIHRvIGxvY2suIEFsbCBiaXRzIHNldCBhcmUgcHJvY2Vz
c2VkLA0KPiA+IHVuc2V0IGJpdHMNCj4gPiArICAgIGFyZSBpZ25vcmVkLiBUaGUgbWFzayBpcyBP
UmVkIHdpdGggdGhlIGV4aXN0aW5nIHZhbHVlLiBTbyBhbnkNCj4gPiBmZWF0dXJlIGJpdHMNCj4g
PiArICAgIHNldCBoZXJlIGNhbm5vdCBiZSBlbmFibGVkIG9yIGRpc2FibGVkIGFmdGVyd2FyZHMu
DQo+IA0KPiBUaGUgbXVsdGktdGhyZWFkIGJlaGF2aW91ciBzaG91bGQgYmUgZG9jdW1lbnRlZCBo
ZXJlOiBPbmx5IHRoZQ0KPiBjdXJyZW50IHRocmVhZCBpcyBhZmZlY3RlZC4gU28gYW4gYXBwbGlj
YXRpb24gY2FuIG9ubHkgY2hhbmdlIHRoZQ0KPiBzZXR0aW5nIHdoaWxlIHNpbmdsZS10aHJlYWRl
ZCB3aGljaCBpcyBvbmx5IGd1YXJhbnRlZWQgYmVmb3JlIGFueQ0KPiB1c2VyIGNvZGUgaXMgZXhl
Y3V0ZWQuIExhdGVyIHVzaW5nIHRoZSBwcmN0bCBpcyBjb21wbGljYXRlZCBhbmQNCj4gbW9zdCBj
IHJ1bnRpbWVzIHdvdWxkIG5vdCB3YW50IHRvIGRvIHRoYXQgKGFzeW5jIHNpZ25hbGxpbmcgYWxs
DQo+IHRocmVhZHMgYW5kIHByY3RsIGZyb20gdGhlIGhhbmRsZXIpLg0KDQpJdCBpcyBraW5kIG9m
IGNvdmVyZWQgaW4gdGhlIGZvcmsoKSBkb2NzLCBidXQgeWVzIHRoZXJlIHNob3VsZCBwcm9iYWJs
eQ0KYmUgYSByZWZlcmVuY2UgaGVyZSB0b28uDQoNCj4gDQo+IEluIHBhcnRpY3VsYXIgdGhlc2Ug
aW50ZXJmYWNlcyBhcmUgbm90IHN1aXRhYmxlIHRvIHR1cm4gc2hzdGsgb2ZmDQo+IGF0IGRsb3Bl
biB0aW1lIHdoZW4gYW4gdW5tYXJrZWQgYmluYXJ5IGlzIGxvYWRlZC4gT3IgYW55IG90aGVyDQo+
IGxhdGUgc2hzdGsgcG9saWN5IGNoYW5nZSB3aWxsIG5vdCB3b3JrLCBzbyBhcyBmYXIgYXMgaSBj
YW4gc2VlDQo+IHRoZSAicGVybWlzc2l2ZSIgbW9kZSBpbiBnbGliYyBkb2VzIG5vdCB3b3JrLg0K
DQpZZXMsIHRoYXQgaXMgY29ycmVjdC4gR2xpYmMgcGVybWlzc2l2ZSBtb2RlIGRvZXMgbm90IGZ1
bGx5IHdvcmsuIFRoZXJlDQphcmUgc29tZSBvbmdvaW5nIGRpc2N1c3Npb25zIG9uIGhvdyB0byBt
YWtlIGl0IHdvcmsuIFNvbWUgb3B0aW9ucyBkb24ndA0KcmVxdWlyZSBrZXJuZWwgY2hhbmdlcywg
YW5kIHNvbWUgZG8uIE1ha2luZyBpdCBwZXItdGhyZWFkIGlzDQpjb21wbGljYXRlZCBmb3IgeDg2
IGJlY2F1c2Ugd2hlbiBzaGFkb3cgc3RhY2sgaXMgb2ZmLCBzb21lIG9mIHRoZQ0Kc3BlY2lhbCBz
aGFkb3cgc3RhY2sgaW5zdHJ1Y3Rpb25zIHdpbGwgY2F1c2UgI1VEIGV4Y2VwdGlvbi4gR2xpYmMg
KGFueQ0KcHJvYmFibHkgb3RoZXIgYXBwcyBpbiB0aGUgZnV0dXJlKSBjb3VsZCBiZSBpbiB0aGUg
bWlkZGxlIG9mIGV4ZWN1dGluZw0KdGhlc2UgaW5zdHJ1Y3Rpb25zIHdoZW4gZGxvcGVuKCkgd2Fz
IGNhbGxlZC4gU28gaWYgdGhlcmUgd2FzIGEgcHJvY2Vzcw0Kd2lkZSBkaXNhYmxlIG9wdGlvbiBp
dCB3b3VsZCBoYXZlIHRvIGJlIHJlc2lsaWVudCB0byB0aGVzZSAjVURzLiBBbmQNCmV2ZW4gdGhl
biB0aGUgY29kZSB0aGF0IHVzZWQgdGhlbSBjb3VsZCBub3QgYmUgZ3VhcmFudGVlZCB0byBjb250
aW51ZQ0KdG8gd29yay4gRm9yIGV4YW1wbGUsIGlmIHlvdSBjYWxsIHRoZSBnY2MgaW50cmluc2lj
IF9nZXRfc3NwKCkgd2hlbg0Kc2hhZG93IHN0YWNrIGlzIGVuYWJsZWQgaXQgY291bGQgYmUgZXhw
ZWN0ZWQgdG8gcG9pbnQgdG8gdGhlIHNoYWRvdw0Kc3RhY2sgaW4gbW9zdCBjYXNlcy4gSWYgc2hh
ZG93IHN0YWNrIGdldHMgZGlzYWJsZWQsIHJkc3NwIHdpbGwgcmV0dXJuDQowLCBpbiB3aGljaCBj
YXNlIHJlYWRpbmcgdGhlIHNoYWRvdyBzdGFjayB3b3VsZCBzZWdmYXVsdC4gU28gdGhlIGFsbC0N
CnByb2Nlc3MgZGlzYWJsaW5nIHNvbHV0aW9uIGNhbid0IGJlIGZ1bGx5IHJvYnVzdCB3aGVuIHRo
ZXJlIGlzIGFueQ0Kc2hhZG93IHN0YWNrIHNwZWNpZmljIGxvZ2ljLg0KDQpUaGUgb3RoZXIgb3B0
aW9uIGRpc2N1c3NlZCB3YXMgY3JlYXRpbmcgdHJhbXBvbGluZXMgYmV0d2VlbiB0aGUNCmxpbmtl
ZCBsZWdhY3kgb2JqZWN0cyB0aGF0IGNvdWxkIGtub3cgdG8gdGVsbCB0aGUga2VybmVsIHRvIGRp
c2FibGUNCnNoYWRvdyBzdGFjayBpZiBuZWVkZWQuIEluIHRoaXMgY2FzZSwgc2hhZG93IHN0YWNr
IGlzIGRpc2FibGVkIGZvciBlYWNoDQp0aHJlYWQgYXMgaXQgY2FsbHMgaW50byB0aGUgRFNPLiBJ
dCdzIG5vdCBjbGVhciBpZiB0aGVyZSBjYW4gYmUgZW5vdWdoDQppbmZvcm1hdGlvbiBnbGVhbmVk
IGZyb20gdGhlIGxlZ2FjeSBiaW5hcmllcyB0byBrbm93IHdoZW4gdG8gZ2VuZXJhdGUNCnRoZSB0
cmFtcG9saW5lcyBpbiBleG90aWMgY2FzZXMuDQoNCkEgdGhpcmQgb3B0aW9uIG1pZ2h0IGJlIHRv
IGhhdmUgc29tZSBzeW5jaHJvbml6YXRpb24gYmV0d2VlbiB0aGUga2VybmVsDQphbmQgdXNlcnNw
YWNlIGFyb3VuZCBhbnl0aGluZyB1c2luZyB0aGUgc2hhZG93IHN0YWNrIGluc3RydWN0aW9ucy4g
QnV0DQp0aGVyZSBpcyBub3QgbXVjaCBkZXRhaWwgZmlsbGVkIGluIHRoZXJlLg0KDQpTbyBpbiBz
dW1tYXJ5LCBpdCdzIG5vdCBhcyBzaW1wbGUgYXMgbWFraW5nIHRoZSBkaXNhYmxlIHBlci1wcm9j
ZXNzLg0KDQo+IA0KPiBEb2VzIHRoZSBtYWluIHRocmVhZCBoYXZlIHNoYWRvdyBzdGFjayBhbGxv
Y2F0ZWQgYmVmb3JlIHNoc3RrIGlzDQo+IGVuYWJsZWQ/DQoNCk5vLg0KDQo+IGlzIHRoZSBzaGFk
b3cgc3RhY2sgZnJlZWQgd2hlbiBpdCBpcyBkaXNhYmxlZD8gKGUuZy4NCj4gd2hhdCB3b3VsZCB0
aGUgaW5zdHJ1Y3Rpb24gcmVhZGluZyB0aGUgU1NQIGRvIGluIGRpc2FibGVkIHN0YXRlPykNCg0K
WWVzLg0KDQpXaGVuIHNoYWRvdyBzdGFjayBpcyBkaXNhYmxlZCByZHNzcCBpcyBhIE5PUCwgdGhl
IGludHJpbnNpYyByZXR1cm5zDQpOVUxMLg0KDQo+IA0KPiA+ICtQcm9jIFN0YXR1cw0KPiA+ICs9
PT09PT09PT09PQ0KPiA+ICtUbyBjaGVjayBpZiBhbiBhcHBsaWNhdGlvbiBpcyBhY3R1YWxseSBy
dW5uaW5nIHdpdGggc2hhZG93IHN0YWNrLA0KPiA+IHRoZQ0KPiA+ICt1c2VyIGNhbiByZWFkIHRo
ZSAvcHJvYy8kUElEL3N0YXR1cy4gSXQgd2lsbCByZXBvcnQgIndyc3MiIG9yDQo+ID4gInNoc3Rr
Ig0KPiA+ICtkZXBlbmRpbmcgb24gd2hhdCBpcyBlbmFibGVkLiBUaGUgbGluZXMgbG9vayBsaWtl
IHRoaXM6Og0KPiA+ICsNCj4gPiArICAgIHg4Nl9UaHJlYWRfZmVhdHVyZXM6IHNoc3RrIHdyc3MN
Cj4gPiArICAgIHg4Nl9UaHJlYWRfZmVhdHVyZXNfbG9ja2VkOiBzaHN0ayB3cnNzDQo+IA0KPiBQ
cmVzdW1hbHkgL3Byb2MvJFRJRC9zdGF0dXMgYW5kIC9wcm9jLyRQSUQvdGFzay8kVElEL3N0YXR1
cyBhbHNvDQo+IHNob3dzIHRoZSBzZXR0aW5nIGFuZCBvbmx5IHZhbGlkIGZvciB0aGUgc3BlY2lm
aWMgdGhyZWFkIChub3QgdGhlDQo+IGVudGlyZSBwcm9jZXNzKS4gU28gaSB3b3VsZCBub3RlIHRo
YXQgdGhpcyBmb3Igb25lIHRocmVhZCBvbmx5Lg0KDQpTaW5jZSBlbmFibGluZy9kaXNhYmxpbmcg
aXMgcGVyLXRocmVhZCwgYW5kIHRoZSBmaWVsZCBpcyBjYWxsZWQNCiJ4ODZfVGhyZWFkX2ZlYXR1
cmVzIiBJIHRob3VnaHQgaXQgd2FzIGNsZWFyLiBJdCdzIGVhc3kgdG8gYWRkIHNvbWUNCm1vcmUg
ZGV0YWlsIHRob3VnaC4NCg0KPiANCj4gPiArSW1wbGVtZW50YXRpb24gb2YgdGhlIFNoYWRvdyBT
dGFjaw0KPiA+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID4gKw0KPiA+
ICtTaGFkb3cgU3RhY2sgU2l6ZQ0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICsNCj4gPiAr
QSB0YXNrJ3Mgc2hhZG93IHN0YWNrIGlzIGFsbG9jYXRlZCBmcm9tIG1lbW9yeSB0byBhIGZpeGVk
IHNpemUgb2YNCj4gPiArTUlOKFJMSU1JVF9TVEFDSywgNCBHQikuIEluIG90aGVyIHdvcmRzLCB0
aGUgc2hhZG93IHN0YWNrIGlzDQo+ID4gYWxsb2NhdGVkIHRvDQo+ID4gK3RoZSBtYXhpbXVtIHNp
emUgb2YgdGhlIG5vcm1hbCBzdGFjaywgYnV0IGNhcHBlZCB0byA0IEdCLiBIb3dldmVyLA0KPiA+
ICthIGNvbXBhdC1tb2RlIGFwcGxpY2F0aW9uJ3MgYWRkcmVzcyBzcGFjZSBpcyBzbWFsbGVyLCBl
YWNoIG9mIGl0cw0KPiA+IHRocmVhZCdzDQo+ID4gK3NoYWRvdyBzdGFjayBzaXplIGlzIE1JTigx
LzQgUkxJTUlUX1NUQUNLLCA0IEdCKS4NCj4gDQo+IFRoaXMgcG9saWN5IHRyaWVzIHRvIGhhbmRs
ZSBhbGwgdGhyZWFkcyB3aXRoIHRoZSBzYW1lIHNoYWRvdyBzdGFjaw0KPiBzaXplIGxvZ2ljLCB3
aGljaCBoYXMgbGltaXRhdGlvbnMuIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGltcHJvdmVkDQo+IChv
dGhlcndpc2Ugc29tZSBhcHBsaWNhdGlvbnMgd2lsbCBoYXZlIHRvIHR1cm4gc2hzdGsgb2ZmKToN
Cj4gDQo+IC0gUkxJTUlUX1NUQUNLIGlzIG5vdCBhbiB1cHBlciBib3VuZCBmb3IgdGhlIG1haW4g
dGhyZWFkIHN0YWNrIHNpemUNCj4gICAocmxpbWl0IGNhbiBpbmNyZWFzZS9kZWNyZWFzZSBkeW5h
bWljYWxseSkuDQo+IC0gUkxJTUlUX1NUQUNLIG9ubHkgYXBwbGllcyB0byB0aGUgbWFpbiB0aHJl
YWQsIHNvIGl0IGlzIG5vdCBhbiB1cHBlcg0KPiAgIGJvdW5kIGZvciBub24tbWFpbiB0aHJlYWQg
c3RhY2tzLg0KPiAtIGkuZS4gc3RhY2sgc2l6ZSA+PiBzdGFydHVwIFJMSU1JVF9TVEFDSyBpcyBw
b3NzaWJsZSBhbmQgdGhlbiBzaGFkb3cNCj4gICBzdGFjayBjYW4gb3ZlcmZsb3cuDQo+IC0gc3Rh
Y2sgc2l6ZSA8PCBzdGFydHVwIFJMSU1JVF9TVEFDSyBpcyBhbHNvIHBvc3NpYmxlIGFuZCB0aGVu
IFZBDQo+ICAgc3BhY2UgaXMgd2FzdGVkIChjYW4gbGVhZCB0byBPT00gd2l0aCBzdHJpY3QgbWVt
b3J5IG92ZXJjb21taXQpLg0KPiAtIGNsb25lMyB0ZWxscyB0aGUga2VybmVsIHRoZSB0aHJlYWQg
c3RhY2sgc2l6ZSBzbyB0aGF0IHNob3VsZCBiZQ0KPiAgIHVzZWQgaW5zdGVhZCBvZiBSTElNSVRf
U1RBQ0suIChjbG9uZSBkb2VzIG5vdCB0aG91Z2guKQ0KDQpUaGlzIGFjdHVhbGx5IGhhcHBlbnMg
YWxyZWFkeS4gSSBjYW4gdXBkYXRlIHRoZSBkb2NzLg0KDQo+IC0gSSB0aGluayBpdCdzIGJldHRl
ciB0byBoYXZlIGEgbmV3IGxpbWl0IHNwZWNpZmljYWxseSBmb3Igc2hhZG93DQo+ICAgc3RhY2sg
c2l6ZSAod2hpY2ggYnkgZGVmYXVsdCBjYW4gYmUgUkxJTUlUX1NUQUNLKSBzbyB1c2Vyc3BhY2UN
Cj4gICBjYW4gYWRqdXN0IGl0IGlmIG5lZWRlZCAoYW5vdGhlciByZWFzb24gaXMgdGhhdCBzdGFj
ayBzaXplIGlzDQo+ICAgbm90IGFsd2F5cyBhIGdvb2QgaW5kaWNhdG9yIG9mIG1heCBjYWxsIGRl
cHRoKS4NCg0KSG1tLCB5ZWEuIFRoaXMgc2VlbXMgbGlrZSBhIGdvb2QgaWRlYSwgYnV0IEkgZG9u
J3Qgc2VlIHdoeSBpdCBjYW4ndCBiZQ0KYSBmb2xsb3cgb24uIFRoZSBzZXJpZXMgaXMgcXVpdGUg
YmlnIGp1c3QgdG8gZ2V0IHRoZSBiYXNpY3MuIEkgaGF2ZQ0KdHJpZWQgdG8gc2F2ZSBzb21lIG9m
IHRoZSBlbmhhbmNlbWVudHMgKGxpa2UgYWx0IHNoYWRvdyBzdGFjaykgZm9yIHRoZQ0KZnV0dXJl
Lg0KDQo+IA0KPiA+ICtTaWduYWwNCj4gPiArLS0tLS0tDQo+ID4gKw0KPiA+ICtCeSBkZWZhdWx0
LCB0aGUgbWFpbiBwcm9ncmFtIGFuZCBpdHMgc2lnbmFsIGhhbmRsZXJzIHVzZSB0aGUgc2FtZQ0K
PiA+IHNoYWRvdw0KPiA+ICtzdGFjay4gQmVjYXVzZSB0aGUgc2hhZG93IHN0YWNrIHN0b3JlcyBv
bmx5IHJldHVybiBhZGRyZXNzZXMsIGENCj4gPiBsYXJnZQ0KPiA+ICtzaGFkb3cgc3RhY2sgY292
ZXJzIHRoZSBjb25kaXRpb24gdGhhdCBib3RoIHRoZSBwcm9ncmFtIHN0YWNrIGFuZA0KPiA+IHRo
ZQ0KPiA+ICtzaWduYWwgYWx0ZXJuYXRlIHN0YWNrIHJ1biBvdXQuDQo+IA0KPiBXaGF0IGRvZXMg
ImJ5IGRlZmF1bHQiIG1lYW4gaGVyZT8gSXMgdGhlcmUgYSBjYXNlIHdoZW4gdGhlIHNpZ25hbA0K
PiBoYW5kbGVyDQo+IGlzIG5vdCBlbnRlcmVkIHdpdGggU1NQIHNldCB0byB0aGUgaGFuZGxpbmcg
dGhyZWFkJ2Qgc2hhZG93IHN0YWNrPw0KDQpBaCwgeWVhLCB0aGF0IGNvdWxkIGJlIHVwZGF0ZWQu
IEl0IGlzIGluIHJlZmVyZW5jZSB0byBhbiBhbHQgc2hhZG93DQpzdGFjayBpbXBsZW1lbnRhdGlv
biB0aGF0IHdhcyBoZWxkIGZvciBsYXRlci4NCg0KPiANCj4gPiArV2hlbiBhIHNpZ25hbCBoYXBw
ZW5zLCB0aGUgb2xkIHByZS1zaWduYWwgc3RhdGUgaXMgcHVzaGVkIG9uIHRoZQ0KPiA+IHN0YWNr
LiBXaGVuDQo+ID4gK3NoYWRvdyBzdGFjayBpcyBlbmFibGVkLCB0aGUgc2hhZG93IHN0YWNrIHNw
ZWNpZmljIHN0YXRlIGlzIHB1c2hlZA0KPiA+IG9udG8gdGhlDQo+ID4gK3NoYWRvdyBzdGFjay4g
VG9kYXkgdGhpcyBpcyBvbmx5IHRoZSBvbGQgU1NQIChzaGFkb3cgc3RhY2sNCj4gPiBwb2ludGVy
KSwgcHVzaGVkDQo+ID4gK2luIGEgc3BlY2lhbCBmb3JtYXQgd2l0aCBiaXQgNjMgc2V0LiBPbiBz
aWdyZXR1cm4gdGhpcyBvbGQgU1NQDQo+ID4gdG9rZW4gaXMNCj4gPiArdmVyaWZpZWQgYW5kIHJl
c3RvcmVkIGJ5IHRoZSBrZXJuZWwuIFRoZSBrZXJuZWwgd2lsbCBhbHNvIHB1c2ggdGhlDQo+ID4g
bm9ybWFsDQo+ID4gK3Jlc3RvcmVyIGFkZHJlc3MgdG8gdGhlIHNoYWRvdyBzdGFjayB0byBoZWxw
IHVzZXJzcGFjZSBhdm9pZCBhDQo+ID4gc2hhZG93IHN0YWNrDQo+ID4gK3Zpb2xhdGlvbiBvbiB0
aGUgc2lncmV0dXJuIHBhdGggdGhhdCBnb2VzIHRocm91Z2ggdGhlIHJlc3RvcmVyLg0KPiANCj4g
VGhlIGtlcm5lbCBwdXNoZXMgb24gdGhlIHNoYWRvdyBzdGFjayBvbiBzaWduYWwgZW50cnkgc28g
c2hhZG93IHN0YWNrDQo+IG92ZXJmbG93IGNhbm5vdCBiZSBoYW5kbGVkLiBQbGVhc2UgZG9jdW1l
bnQgdGhpcyBhcyBub24tcmVjb3ZlcmFibGUNCj4gZmFpbHVyZS4NCg0KSXQgZG9lc24ndCBodXJ0
IHRvIGNhbGwgaXQgb3V0LiBQbGVhc2Ugc2VlIHRoZSBiZWxvdyBsaW5rIGZvciBmdXR1cmUNCnBs
YW5zIHRvIGhhbmRsZSB0aGlzIHNjZW5hcmlvIChhbHQgc2hhZG93IHN0YWNrKS4NCg0KPiANCj4g
SSB0aGluayBpdCBjYW4gYmUgbWFkZSByZWNvdmVyYWJsZSBpZiBzaWduYWxzIHdpdGggYWx0ZXJu
YXRlIHN0YWNrDQo+IHJ1bg0KPiBvbiBhIGRpZmZlcmVudCBzaGFkb3cgc3RhY2suIEFuZCB0aGUg
dG9wIG9mIHRoZSB0aHJlYWQgc2hhZG93IHN0YWNrDQo+IGlzDQo+IGp1c3QgY29ycnVwdGVkIGlu
c3RlYWQgb2YgcHVzaGVkIGluIHRoZSBvdmVyZmxvdyBjYXNlLiBUaGVuIGxvbmdqbXANCj4gb3V0
DQo+IGNhbiBiZSBtYWRlIHRvIHdvcmsgKGNvbW1vbiBpbiBzdGFjayBvdmVyZmxvdyBoYW5kbGlu
ZyBjYXNlcyksIGFuZA0KPiByZWxpYWJsZSBjcmFzaCByZXBvcnQgZnJvbSB0aGUgc2lnbmFsIGhh
bmRsZXIgd29ya3MgKGFsc28gY29tbW9uKS4NCj4gDQo+IERvZXMgU1NQIGdldCBzdG9yZWQgaW50
byB0aGUgc2lnY29udGV4dCBzdHJ1Y3Qgc29tZXdoZXJlPw0KDQpObywgaXQncyBwdXNoZWQgdG8g
dGhlIHNoYWRvdyBzdGFjayBvbmx5LiBTZWUgdGhlIHYyIGNvdmVybGV0dGVyIG9mIHRoZQ0KZGlz
Y3Vzc2lvbiBvbiB0aGUgZGVzaWduIGFuZCByZWFzb25pbmc6DQoNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMjA5MjkyMjI5MzYuMTQ1ODQtMS1yaWNrLnAuZWRnZWNvbWJlQGludGVs
LmNvbS8NCg0KPiANCj4gPiArRm9yaw0KPiA+ICstLS0tDQo+ID4gKw0KPiA+ICtUaGUgc2hhZG93
IHN0YWNrJ3Mgdm1hIGhhcyBWTV9TSEFET1dfU1RBQ0sgZmxhZyBzZXQ7IGl0cyBQVEVzIGFyZQ0K
PiA+IHJlcXVpcmVkDQo+ID4gK3RvIGJlIHJlYWQtb25seSBhbmQgZGlydHkuIFdoZW4gYSBzaGFk
b3cgc3RhY2sgUFRFIGlzIG5vdCBSTyBhbmQNCj4gPiBkaXJ0eSwgYQ0KPiA+ICtzaGFkb3cgYWNj
ZXNzIHRyaWdnZXJzIGEgcGFnZSBmYXVsdCB3aXRoIHRoZSBzaGFkb3cgc3RhY2sgYWNjZXNzDQo+
ID4gYml0IHNldA0KPiA+ICtpbiB0aGUgcGFnZSBmYXVsdCBlcnJvciBjb2RlLg0KPiA+ICsNCj4g
PiArV2hlbiBhIHRhc2sgZm9ya3MgYSBjaGlsZCwgaXRzIHNoYWRvdyBzdGFjayBQVEVzIGFyZSBj
b3BpZWQgYW5kDQo+ID4gYm90aCB0aGUNCj4gPiArcGFyZW50J3MgYW5kIHRoZSBjaGlsZCdzIHNo
YWRvdyBzdGFjayBQVEVzIGFyZSBjbGVhcmVkIG9mIHRoZQ0KPiA+IGRpcnR5IGJpdC4NCj4gPiAr
VXBvbiB0aGUgbmV4dCBzaGFkb3cgc3RhY2sgYWNjZXNzLCB0aGUgcmVzdWx0aW5nIHNoYWRvdyBz
dGFjayBwYWdlDQo+ID4gZmF1bHQNCj4gPiAraXMgaGFuZGxlZCBieSBwYWdlIGNvcHkvcmUtdXNl
Lg0KPiA+ICsNCj4gPiArV2hlbiBhIHB0aHJlYWQgY2hpbGQgaXMgY3JlYXRlZCwgdGhlIGtlcm5l
bCBhbGxvY2F0ZXMgYSBuZXcgc2hhZG93DQo+ID4gc3RhY2sNCj4gPiArZm9yIHRoZSBuZXcgdGhy
ZWFkLiBOZXcgc2hhZG93IHN0YWNrJ3MgYmVoYXZlIGxpa2UgbW1hcCgpIHdpdGgNCj4gPiByZXNw
ZWN0IHRvDQo+ID4gK0FTTFIgYmVoYXZpb3IuDQo+IA0KPiBQbGVhc2UgZG9jdW1lbnQgdGhlIHNo
YWRvdyBzdGFjayBsaWZldGltZXMgaGVyZToNCj4gDQo+IEkgdGhpbmsgdGhyZWFkIGV4aXQgdW5t
YXBzIHNoYWRvdyBzdGFjayBhbmQgdmZvcmsgc2hhcmVzIHNoYWRvdyBzdGFjaw0KPiB3aXRoIHBh
cmVudCBzbyBleGl0IGRvZXMgbm90IHVubWFwLg0KDQpTdXJlLCB0aGlzIGNhbiBiZSB1cGRhdGVk
Lg0KDQo+IA0KPiBJIHRoaW5rIHRoZSBtYXBfc2hhZG93X3N0YWNrIHN5c2NhbGwgc2hvdWxkIGJl
IG1lbnRpb25lZCBpbiB0aGlzDQo+IGRvY3VtZW50IHRvby4NCg0KVGhlcmUgaXMgYSBtYW4gcGFn
ZSBwcmVwYXJlZCBmb3IgdGhpcy4gSSBwbGFuIHRvIHVwZGF0ZSB0aGUgZG9jcyB0bw0KcmVmZXJl
bmNlIGl0IHdoZW4gaXQgZXhpc3RzIGFuZCBub3QgZHVwbGljYXRlIHRoZSB0ZXh0LiBUaGVyZSBj
YW4gYmUgYQ0KYmx1cmIgZm9yIHRoZSB0aW1lIGJlaW5nIGJ1dCBpdCB3b3VsZCBiZSBzaG9ydCBs
aXZlZC4NCg0KPiBJZiBvbmUgd2FudHMgdG8gc2NhbiB0aGUgc2hhZG93IHN0YWNrIGhvdyB0byBk
ZXRlY3QgdGhlIGVuZCAoZS5nLg0KPiBmYXN0DQo+IGJhY2t0cmFjZSk/IElzIGl0IHVzZWZ1bCB0
byBwdXQgYW4gaW52YWxpZCB2YWx1ZSAoLTEpIHRoZXJlPw0KPiAoYWZmZWN0cyBtYXBfc2hhZG93
X3N0YWNrIHN5c2NhbGwgdG9vKS4NCg0KSW50ZXJlc3RpbmcgaWRlYS4gSSB0aGluayBpdCdzIHBy
b2JhYmx5IG5vdCBhIGJyZWFraW5nIEFCSSBjaGFuZ2UgaWYgd2UNCndhbnRlZCB0byBhZGQgaXQg
bGF0ZXIuDQo=
