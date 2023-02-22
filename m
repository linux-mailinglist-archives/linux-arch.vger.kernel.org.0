Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64A269FF3B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 00:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBVXHv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 18:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBVXHu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 18:07:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB913D5E;
        Wed, 22 Feb 2023 15:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677107268; x=1708643268;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mu1tmHcxODbYbxbBdUG2BtQmY6Z1hzsqtGmrD8fEwA8=;
  b=UcV9gI6VNuSeKTq9buXOMGlkUpRotWCpasJWVI2dkV16qRIk1uUQztMx
   taxjo2ZNY2/NvCr/X0x7Qn+eZZyDq82sioII3D/QdiVt+Z2L+YFuUtER3
   XZZwW27kvMhAkByyWwusxF1Zb7ZuhEC/B1Mu6V9nmZnwLOz1r/57tHY/D
   HA0RPEyrO9VQNt8d2yqdpKW62SllcrAKREKsMaMA0j14jy+YIPM3SRP+4
   KH4dhUv3L7LrKHk+RfkFwqlY6+raNBWRpC7NYaG9iC7CXSlsquXyf3+9h
   YwLsx6BJlifdGwVPi28rz3QHeuNu1Dpe3E/Svp4Tt2OsevFPTZOBsoUb5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="312685771"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="312685771"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 15:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="761117692"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="761117692"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Feb 2023 15:07:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 15:07:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 15:07:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 15:07:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzO5dc9z1lkw305leStE1LBT5HWQYaK9eAwM/M51x4zy3JQzfLWp0//bpKs9l9Pc/rUgMT6d6ldt3r6Sj83seGqa/UXzf1G0D/bfGbSgOWjHEuRPa6q8X0myPEWUcb+9Bagi9L4QYAeR7y9x5IgSuGeaqoTZ0d5gog/5LBPrU3WzpXGKY9vzenH50rHeIXwUrvKMHWsekN1BtS5lQXiH4s5qot0GJfqelxFM/HdeIGqKbWOTEHA/QDQEKsHHn8GGBeXAX6hFACHg/8QlZicV6eZ9dX87IJ+Mng1jpINBEEAwFjShgLuXuVFaqCfw/A1ZS4FWeIJeOyrZDruRiHi2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mu1tmHcxODbYbxbBdUG2BtQmY6Z1hzsqtGmrD8fEwA8=;
 b=WbZfI6A/7yk46TY3BkD6mNfoYrjJkQ892HjEQldwAqeVzruoWzzJvNr3cFGzb1tYyFhJyMntDsXZ53xHRzNWtP4CyFgEVX1mn4TElBWkxS/FbyZl6UEqK9u1Vm2CM+XUpQ5FqXfq2Ugya1fvfm/GyQOYboPstnuTrpwTJFRhkU05Huy7HyyMtJ1SBsnvq83AKg2NluEBhRTjoP2pnVkXasmfJklZ2p9JwiQRjn6/h3pEv4KsGMonjY+aME7Bg/ORdXMjIIXWhxki2bH5p96jm9xoEpLH/3Aw4BdFxASxgVmKkR+1RAvv86oUT3xpJkAZSolh6TSk2Vdc3JZiIm/3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA3PR11MB7553.namprd11.prod.outlook.com (2603:10b6:806:316::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 23:07:39 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 23:07:39 +0000
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
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 19/41] x86/mm: Check shadow stack page fault errors
Thread-Topic: [PATCH v6 19/41] x86/mm: Check shadow stack page fault errors
Thread-Index: AQHZQ94+C3xlrgx02EewEF3TPzdLrK7XzfEAgAPPPAA=
Date:   Wed, 22 Feb 2023 23:07:39 +0000
Message-ID: <c67f511516d2f28385bbe079b7d7d40f136adb27.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-20-rick.p.edgecombe@intel.com>
         <458b3d39-ddce-c0f2-fe80-4e0cc5b101bd@redhat.com>
In-Reply-To: <458b3d39-ddce-c0f2-fe80-4e0cc5b101bd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA3PR11MB7553:EE_
x-ms-office365-filtering-correlation-id: 54195342-026a-47f1-068d-08db15299814
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0AqsPEbqewttU7zSFJG5S4GDDJJU1aSgmBKj+TS+UEaVYSOjSW1ZvBOToxZ22IXkNYsnl53mzg/0Zg6IR/7meaEFkDEG7GW65FkCfnYm/eIKyIJxtMiHsOfMyddDG/YwI3Q3L+ZQBMCqmUp4VZeYsujRRnOWEwzK32rwpBddknHB/dUiKNZLABj39aifOfU89GUvnG1oOykalihdMpC38/WP21BcqF6JOgASir+rjTkfMFb86Rnd10owvCEcvHAz0VSvKL/2hbkIEe4PGF4JsnFhO2eBqwKwiQ9Tq5zPmINFvCMygaOKtmW+ItD97mhqX7L3nXkecb43V4pRfijKw7D1npDAYHMrIM9vtSkHRQSVm6AjRp6g5Dlf4n1CyG/7lDMGvVCtqoPfEFkMSjbqKJG/T0KCxB2VlS6G6SQPeOhzF68sINw9M9WeJPdnNIKrLWpvYBd78QBKKiPfZ/t6aVZ5yXaXmdXKnQL3/2BWdZKXJTn6gYQnyPJA2YFGVtjcKwfl+nMUWnKNhnlXxWKcly4wV2vLPMIwtpA8PxtpfCIfXGX5fW6jjqV4eMyvXmVhebBWQRn424RXulUpUweu15E3QpmR7PmDVBCC0n5ICXwCtm9jC38BqViMA+WoZq2vnhY7M4KHuQ0KIoWWlA5OD7AqPSc7jvjy+NGgUaRdwHQgJLmQqTsjv78fxam3hk+9U4dUXfOi8AC1uZdgElEk3oS7z5ovpIvWDMDywxJmh/V0la3uXoh13QFY2x3/0bM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199018)(110136005)(316002)(83380400001)(82960400001)(921005)(86362001)(122000001)(38070700005)(71200400001)(38100700002)(478600001)(6486002)(36756003)(6512007)(2616005)(26005)(6506007)(186003)(41300700001)(8936002)(2906002)(7416002)(7406005)(5660300002)(66446008)(4326008)(8676002)(66556008)(64756008)(66476007)(76116006)(66946007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkxVUU93ZlI5MnMwMjVuRHJBSFVQQlF4QUhlRVpZbEg0ZFU2ZkUzcW9SRjdB?=
 =?utf-8?B?UWlBaTgwdFVVUVVQejExbmRIeVJHS2p0K2M5aXNqUkgvRnd1QXBFUFA1a3o0?=
 =?utf-8?B?M0g2bkRxOGIwQXJjZGZiSjI0bzV6ZkpaeDl6aW1PVXBPbTJWV2JvV1EvS2FI?=
 =?utf-8?B?RnoyeGd2MjBZRzBhbnNqUHpYZHRCV3VjZnZINlQzWXM1OGdIUi9UU0hBUzh5?=
 =?utf-8?B?MGl1VDJ6UmpORFZsbGpTNEQ0YXZhWll0bG1UUzY3K2VDNU9RSGI1VlUrdk9S?=
 =?utf-8?B?cFRwUVd2VkFwYVpQUWpKWFdEalhTYkE2TmE3Tkc1U3pGdE5qaDg4TVhtaGRm?=
 =?utf-8?B?YnhjZXFuVm1UQ0EyQzh3SEJ2SDRyMEVXSXJ0Z25FZXAwV1h0SE1uTWs2V3Nv?=
 =?utf-8?B?WHJrQVp0Z2d6eFB6THRMT2V0aDJuTXlTS1FuSWxiRmRUUXQ4NDE1RDB5dkFq?=
 =?utf-8?B?Zmlyb0FKWUNQU0dyY2lUUXhwU3RvcTdmbTNiZGFmSVFJKzdkQzRTUXlFOGVB?=
 =?utf-8?B?RlBCbjV5cFFUbXJKb253T1lSUUpFaGV0TWhFVi9VMUdTYnY2ejcxQlpCUHRG?=
 =?utf-8?B?dFREdjdyWmJ0WGU4WVFBQlJoaUJhZ2VNTzFvUlNWVnFXRGVRRngxTTc1ckY5?=
 =?utf-8?B?eTFpaEU4MExWN3N3d1lxUTJIdzVjRTJDSmZORmdBTVcyd2pUdVRhMFJpenRt?=
 =?utf-8?B?WnZUcEVENStTenFtOHVDU2hEYUJueWFUMXEzK2JwVVpBMFlJcFgrTXQ2bmdw?=
 =?utf-8?B?Z2grU0tjU2FzR2VobzdRY2lBdE82TE1HeUhoQ0ZPVlpDdkJDb2Ruc1ZVT3lt?=
 =?utf-8?B?NmpQYytQTTVEL0ZYRlJ5N3FFZFBxWEN3bnFnOVNOdklsZVNtR2RET3hsU1Vv?=
 =?utf-8?B?cUV3dGhWWTVMWjNoZTFCb2lkNmJDekhiTm53MjduSVdTZW8wTzFqNmdXNzlh?=
 =?utf-8?B?RThUYWZiSVI5bTlVRUw1Wlk3RklnMGNrdXJySXRLYUxQWlJyZlhBczlnWCtk?=
 =?utf-8?B?R3VnUVdpeVVrdlZZZW5aaW5HUks0MDJUb1ZySjNIMHZSSzFCNzRjSzZBY0lY?=
 =?utf-8?B?V0N4M2I2QmF3Q3RzSHpJWVlFd084a3dHN3Q4TDd3cEdQbzF5MUN6SFNpam16?=
 =?utf-8?B?emU1M0Mxek80NEo2Zjh3TXliREF1WTlLTmg1YUtJK0lNS2tFem1Hc1hUNXd6?=
 =?utf-8?B?dDdDcmR5MkhaclZHb1VpcmQ0TDVTUXBFZWtpaHZDb3REZVp3aENrMk10UlZr?=
 =?utf-8?B?YUMxM0Yrc05OanNiSy9SQ3pPQTliVTJod2NVbXFHdDNJTzhFRjdpV2FxQm1n?=
 =?utf-8?B?ZGV4bU1EVkRpZ3NtTzNPR1NpRDF1WXhPdGc4ZWV1UVNwajdiWGhMKytHdnZW?=
 =?utf-8?B?WmFhdWhaS2dVclcwZTdxSkxvc3BrcXFKQ1cwakJMcXNmVFo3RkdDUlFQRTQ0?=
 =?utf-8?B?WGswdFFYZ0dsSlVGR1Z4dm11dDdCMWtOOTczSm04Y29VTTA4TVRhd09TWStM?=
 =?utf-8?B?YkRhZ09IS2VUdW5WbzJvTStXWjc0YzBlN3ZoUW53TFVScld3VXNEWlZwUFlS?=
 =?utf-8?B?M0U2Uml6d1E0enNNYU0rQXBtNVZHN3VtRGZmQXluL2RwUWowNG9hNmZtOTBC?=
 =?utf-8?B?ZmpNTlRGbTNNWG1aS2g2VlhCcm5qUE1TOTU0ejlRZ0ZobWVTM013SE9hTURi?=
 =?utf-8?B?WXlucDFiMTR4YmtmRXp1KzhsT3VFTXJFckR2dlVQZlI1a3RFaGVPaXJ2Tzk1?=
 =?utf-8?B?NjZXd2o2aU9mQ3hlWVFNS2hBWTdWMHJGSG4rTkV5SDRnaGdkbXNWQUVxTUVz?=
 =?utf-8?B?R0NQVkVPVkRvS2J3NWV2Wi9YeFJwTE5ySm81VHd2aUI2QXpIWWNHU2RYaVdL?=
 =?utf-8?B?Zkt4VU9yZU1jSUozZmZIcGdJV1N3TTJKOFlPL2MvK3p5bVdTMDk3TGJlVjRW?=
 =?utf-8?B?RW55clRXbitVMTMxMzFMVDhERU1LWjVKUFIxWXVjNUpEazYwbnM5T05UaTNY?=
 =?utf-8?B?am9BWTVXU1JjTlZ6RHRoZldMSmJBYlMzUXFvZXZFZ2NuWk5MWWhqWXY1UG5q?=
 =?utf-8?B?cE1ZU21ibTRXYzdzQyt5UjhzOXh4SkxhcDR0L3BzcjJ3VmpIVlhSSis3bm42?=
 =?utf-8?B?Z1JUbm1QNnZQWGtUVmcxcmlmRUpLR2QwVEwzZ2pkWDRaVWlpQXFyekRaSlhC?=
 =?utf-8?Q?2THamJ5597Xudv6EYeI0BfQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0368B9988B66C48A74D4411EC40F6CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54195342-026a-47f1-068d-08db15299814
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 23:07:39.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FQDqFqOet6O2JBVX7RZRR4TiTUpB+pTQmKXa1HOqbKF62oapjIwffP4odR2sd6GzAlJLZCuY8kza2twRTymsfXFwB1LsUVJEaRbk5SmNoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7553
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDEzOjU3ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gPiAgICANCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIFdoZW4gYSBwYWdlIGJlY29t
ZXMgQ09XIGl0IGNoYW5nZXMgZnJvbSBhIHNoYWRvdyBzdGFjaw0KPiA+IHBlcm1pc3Npb24NCj4g
PiArICAgICAgKiBwYWdlIChXcml0ZT0wLERpcnR5PTEpIHRvIChXcml0ZT0wLERpcnR5PTAsU2F2
ZWREaXJ0eT0xKSwNCj4gPiB3aGljaCBpcyBzaW1wbHkNCj4gPiArICAgICAgKiByZWFkLW9ubHkg
dG8gdGhlIENQVS4gV2hlbiBzaGFkb3cgc3RhY2sgaXMgZW5hYmxlZCwgYSBSRVQNCj4gPiB3b3Vs
ZA0KPiA+ICsgICAgICAqIG5vcm1hbGx5IHBvcCB0aGUgc2hhZG93IHN0YWNrIGJ5IHJlYWRpbmcg
aXQgd2l0aCBhICJzaGFkb3cNCj4gPiBzdGFjaw0KPiA+ICsgICAgICAqIHJlYWQiIGFjY2Vzcy4g
SG93ZXZlciwgaW4gdGhlIENPVyBjYXNlIHRoZSBzaGFkb3cgc3RhY2sNCj4gPiBtZW1vcnkgZG9l
cw0KPiA+ICsgICAgICAqIG5vdCBoYXZlIHNoYWRvdyBzdGFjayBwZXJtaXNzaW9ucywgaXQgaXMg
cmVhZC1vbmx5LiBTbyBpdA0KPiA+IHdpbGwNCj4gPiArICAgICAgKiBnZW5lcmF0ZSBhIGZhdWx0
Lg0KPiA+ICsgICAgICAqDQo+ID4gKyAgICAgICogRm9yIGNvbnZlbnRpb25hbGx5IHdyaXRhYmxl
IHBhZ2VzLCBhIHJlYWQgY2FuIGJlIHNlcnZpY2VkDQo+ID4gd2l0aCBhDQo+ID4gKyAgICAgICog
cmVhZCBvbmx5IFBURSwgYW5kIENPVyB3b3VsZCBub3QgaGF2ZSB0byBoYXBwZW4uIEJ1dCBmb3IN
Cj4gPiBzaGFkb3cNCj4gPiArICAgICAgKiBzdGFjaywgdGhlcmUgaXNuJ3QgdGhlIGNvbmNlcHQg
b2YgcmVhZC1vbmx5IHNoYWRvdyBzdGFjaw0KPiA+IG1lbW9yeS4NCj4gPiArICAgICAgKiBJZiBp
dCBpcyBzaGFkb3cgc3RhY2sgcGVybWlzc2lvbiwgaXQgY2FuIGJlIG1vZGlmaWVkIHZpYQ0KPiA+
IENBTEwgYW5kDQo+ID4gKyAgICAgICogUkVUIGluc3RydWN0aW9ucy4gU28gQ09XIG5lZWRzIHRv
IGhhcHBlbiBiZWZvcmUgYW55IG1lbW9yeQ0KPiA+IGNhbiBiZQ0KPiA+ICsgICAgICAqIG1hcHBl
ZCB3aXRoIHNoYWRvdyBzdGFjayBwZXJtaXNzaW9ucy4NCj4gPiArICAgICAgKg0KPiA+ICsgICAg
ICAqIFNoYWRvdyBzdGFjayBhY2Nlc3NlcyAocmVhZCBvciB3cml0ZSkgbmVlZCB0byBiZSBzZXJ2
aWNlZA0KPiA+IHdpdGgNCj4gPiArICAgICAgKiBzaGFkb3cgc3RhY2sgcGVybWlzc2lvbiBtZW1v
cnksIHNvIGluIHRoZSBjYXNlIG9mIGEgc2hhZG93DQo+ID4gc3RhY2sNCj4gPiArICAgICAgKiBy
ZWFkIGFjY2VzcywgdHJlYXQgaXQgYXMgYSBXUklURSBmYXVsdCBzbyBib3RoIENPVyB3aWxsDQo+
ID4gaGFwcGVuIGFuZA0KPiA+ICsgICAgICAqIHRoZSB3cml0ZSBmYXVsdCBwYXRoIHdpbGwgdGlj
a2xlIG1heWJlX21rd3JpdGUoKSBhbmQgbWFwDQo+ID4gdGhlIG1lbW9yeQ0KPiA+ICsgICAgICAq
IHNoYWRvdyBzdGFjay4NCj4gPiArICAgICAgKi8NCj4gDQo+IEFnYWluLCBJIHN1Z2dlc3QgZHJv
cHBpbmcgYWxsIGRldGFpbHMgYWJvdXQgQ09XIGZyb20gdGhpcyBjb21tZW50DQo+IGFuZCANCj4g
ZnJvbSB0aGUgcGF0Y2ggZGVzY3JpcHRpb24uIEl0J3MganVzdCBvbmUgc3VjaCBjYXNlIHRoYXQg
Y2FuIGhhcHBlbi4NCg0KSGkgRGF2aWQsDQoNCkkgd2FzIGp1c3QgdHJ5aW5nIHRvIGVkaXQgdGhp
cyBvbmUgdG8gZHJvcCBDT1cgZGV0YWlscywgYnV0IEkgdGhpbmsgaW4NCnRoaXMgY2FzZSwgb25l
IG9mIHRoZSBtYWpvciByZWFzb25zIGZvciB0aGUgY29kZSAqaXMqIGFjdHVhbGx5IENPVy4gV2UN
CmFyZSBub3Qgd29ya2luZyBhcm91bmQgdGhlIHdob2xlIGluYWR2ZXJ0ZW50IHNoYWRvdyBzdGFj
ayBtZW1vcnkgcGllY2UNCmhlcmUsIGJ1dCBzb21ldGhpbmcgZWxzZTogTWFraW5nIHN1cmUgc2hh
ZG93IHN0YWNrIG1lbW9yeSBpcyBmYXVsdGVkIGluDQphbmQgZG9pbmcgQ09XIGlmIHJlcXVpcmVk
IHRvIG1ha2UgdGhpcyBwb3NzaWJsZS4gSSBjYW1lIHVwIHdpdGggdGhpcywNCmRvZXMgaXQgc2Vl
bSBiZXR0ZXI/DQoNCg0KLyoNCiAqIEZvciBjb252ZW50aW9uYWxseSB3cml0YWJsZSBwYWdlcywg
YSByZWFkIGNhbiBiZSBzZXJ2aWNlZCB3aXRoIGENCiAqDQpyZWFkIG9ubHkgUFRFLiBCdXQgZm9y
IHNoYWRvdyBzdGFjaywgdGhlcmUgaXNuJ3QgYSBjb25jZXB0IG9mDQogKiByZWFkLQ0Kb25seSBz
aGFkb3cgc3RhY2sgbWVtb3J5LiBJZiBpdCBhIFBURSBoYXMgdGhlIHNoYWRvdyBzdGFjaw0KICoN
CnBlcm1pc3Npb24sIGl0IGNhbiBiZSBtb2RpZmllZCB2aWEgQ0FMTCBhbmQgUkVUIGluc3RydWN0
aW9ucy4gU28NCiAqIGNvcmUNCk1NIG5lZWRzIHRvIGZhdWx0IGluIGEgd3JpdGFibGUgUFRFIGFu
ZCBkbyB0aGluZ3MgaXQgYWxyZWFkeQ0KICogZG9lcyBmb3INCndyaXRlIGZhdWx0cy4NCiAqDQog
KiBTaGFkb3cgc3RhY2sgYWNjZXNzZXMgKHJlYWQgb3Igd3JpdGUpIG5lZWQgdG8gYmUNCnNlcnZp
Y2VkIHdpdGgNCiAqIHNoYWRvdyBzdGFjayBwZXJtaXNzaW9uIG1lbW9yeSwgc28gaW4gdGhlIGNh
c2Ugb2YgYQ0Kc2hhZG93IHN0YWNrDQogKiByZWFkIGFjY2VzcywgdHJlYXQgaXQgYXMgYSBXUklU
RSBmYXVsdCBzbyBib3RoIGFueQ0KcmVxdWlyZWQgQ09XIHdpbGwNCiAqIGhhcHBlbiBhbmQgdGhl
IHdyaXRlIGZhdWx0IHBhdGggd2lsbCB0aWNrbGUNCm1heWJlX21rd3JpdGUoKSBhbmQgbWFwDQog
KiB0aGUgbWVtb3J5IHNoYWRvdyBzdGFjay4NCiAqLw0KDQoNCg0KVGhhbmtzLA0KUmljaw0KDQo=
