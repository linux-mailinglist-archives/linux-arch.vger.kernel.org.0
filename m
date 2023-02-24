Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00E86A216B
	for <lists+linux-arch@lfdr.de>; Fri, 24 Feb 2023 19:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBXS0O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Feb 2023 13:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBXS0N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2023 13:26:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49BE136E8;
        Fri, 24 Feb 2023 10:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677263171; x=1708799171;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B4PS+O5UH0L0f3MnE5WE6bXLvogKU6QnYkFgG71aglo=;
  b=isQCPTjm7sm/e8XBOOPCyX2wl85s0KN0nYqRkjiz18hKuVf8iJW045XW
   s/+SFOjqvD8Xf2NefC5VaropLFCnwm/U9lt/qjok2LXJlx/72437Ih3LE
   hAk2+tP2LuOD6IM1OYF2qCQn7iflbVP+dgiN/3pvsqS4LcsoGzBDjzMVd
   eLg/oTV610T/8z2VKgzNLprSB6tSHyHflagYs2HBeTL8r9FnZoRYIVnHP
   hDgSpfRHu45p+X8UFAuhtfrDKgPz/kQE3bMvQx4zOfS/D0Eonxob+nJ8r
   vv5nLO6a/I8+wKbCrmtMeaAS1qK6TEcdrJWw1+sdl/o7UHTwuis248u3U
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="313937945"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="313937945"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2023 10:26:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="796823576"
X-IronPort-AV: E=Sophos;i="5.97,325,1669104000"; 
   d="scan'208";a="796823576"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 24 Feb 2023 10:26:00 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 24 Feb 2023 10:26:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 24 Feb 2023 10:26:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 24 Feb 2023 10:25:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/JCWL2QXi42uiJJsK1e/zQ5p5YzvlsNKc47ZIGDe4UlwUMHraCa2eLRy2dFdXTlpieslK2lL/h3NmHoWVifOj5QVJvbXAzK9bzx13xIrozq+VmnVWybamYZOVDTcSlc8m15CDGYkTgwvxyCXKQqCHkxOyjMBebGyLBRg8f7Jt98efOujiMZqj09e8xZZdvkAeSaj2azOUyDn+3Ef3IUw+icAe2jnyRWjHPNg7A/1DbElOK+QXqMj/CN+THWn5XWZLHgciHgyRYQBDe4J2Da2lDmASaEQMbGNQHLakDrUng+mTnUzS9pDsUAdBzI6YrE7zXmH+GJIuFrnHORfMKsuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4PS+O5UH0L0f3MnE5WE6bXLvogKU6QnYkFgG71aglo=;
 b=HOxZjWvFJDMnfRKK2ABfVld14JEMU141Tx3H25+nPRsTVUN2gINPK0KnLG9J7YZEa2Cf1Kr+CfE7wpaV+ck4BrZqu/98TJqLBdXd2elkpA9qq6mz64D1MdIylCy5EG6e05dhaqmp3R4lFPmlTehxwN2RSebivRFzcWNAYeyImL1v7byi1Ae2jL7thpBEKgIGFAKL3u2Od0nyyDBjIa91wkmSJ+XV0Bztb5NUvkqrss0C22F7X0l5m+bqVfFSmG2/0o6J8WODEXu5bui58Vhph2tS1UV/Vb67FxZGwQZ1az9Igdr+MI89cAkzVMw5rJPA8ESToL/0p8QLxgZor3UlJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 18:25:57 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 18:25:57 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v6 29/41] x86/shstk: Add user-mode shadow stack support
Thread-Topic: [PATCH v6 29/41] x86/shstk: Add user-mode shadow stack support
Thread-Index: AQHZQ95DCpyAK8PkaUOEl2c8lBRj8q7eDXSAgABlrIA=
Date:   Fri, 24 Feb 2023 18:25:57 +0000
Message-ID: <06ade29966bbb8bd47cd05b04b5523aa0d4192f0.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-30-rick.p.edgecombe@intel.com>
         <Y/ir6dBo+8g+pnay@zn.tnic>
In-Reply-To: <Y/ir6dBo+8g+pnay@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA2PR11MB5212:EE_
x-ms-office365-filtering-correlation-id: d9e64290-0530-4e8e-8d04-08db16949290
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vGHwkmN2MDL8ZDSKmHxrsdWZ52V1k2Jfp0mSKPiaobjEEnIwepNd5fasPloyQjfivhop5+NDBfiPFIzgQuwjvLQYe2wl/Cok0NtCaZNQ7QH81IoLzJ1Sw8hAZ5yKUk3imhkE9M3y0CaEq+b/6pv2fiKLU34Uxdn+9GdaWGyoceAqMPfEZtE6QR5aDYrCq1p2Lduo/SREVhS3Ochpv8qELU4VcMEMNKsT6f5gIb887UZxpsI2H0nM2Bc0vmwbZU2u2NqnkYiFFYgrzdwG6WQqcT7olkloAlbxWJVTH52tp/kyoyGEn5wj5tfJBSU8i2yuqC1N8Qm0oONMFsd4VsH5TpvRT/Nu/ZLFOxrPoMMUHXehYVzdprUxayR3rdnzK2zTEBtt7uIWydeoUKkIf15Ofd/j5IBO/xs+kHOTL0PxZzToZZHJG7TU23t6sjeZa8UtM5rBB5n5zMPTXLVHdenMMEpo89bOV/0kRmOpXRqIsyNmsWMJjoEw3di81H5X1xE1IAx1KUBSFLfYiBXzTzvyu7JV6772po46ZDvTFlcIqcuUzRI/yNDZYR9IqwM8akB8l5Sywljh5+yg8I2yFq/GQVmA78EDtawjCxOkseEjB7VRqJhz6IN6DwIzjPgQPF34ZT9vOCgpWshgASIlEBxH43SbnFtaMMxWEPxFxaxl1HYz2H7VIYKyY5+8iNZ7awHppChksDp+pl+ExZy0HuhaPo6AdF0/DdzKydzBn4f354=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199018)(83380400001)(36756003)(38100700002)(71200400001)(7406005)(8936002)(122000001)(6916009)(5660300002)(7416002)(38070700005)(86362001)(82960400001)(2906002)(6506007)(6486002)(478600001)(26005)(4326008)(6512007)(66556008)(66446008)(66946007)(76116006)(66476007)(91956017)(2616005)(8676002)(316002)(41300700001)(64756008)(186003)(54906003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVBPckI1RmVpa2J2UUdMM1hISENYNXAveGs4N1praEdCVXRxc3Y3NUJyNmVH?=
 =?utf-8?B?d2xadzdXaUtsQk9kRDhuYmhVaENvSXU0eXo1VE5MWVhSbUJzVFRLUUNCRHNK?=
 =?utf-8?B?eEFEa1ZhWmw2cVY0WVZiSVRveitGNSt6RmxBdUZyaUxIUDVmMDhIMXpIdUU4?=
 =?utf-8?B?YUdNd0tFR05lbDc4NFRrYXlDRHp0eE5BdzR5K0hKS3dVWnN3eXFBWmRmNnhz?=
 =?utf-8?B?VzU3SjgwVnR2VkcwWm1relc5bFBETWJjcWVLblo0amRhaSs5VWV6NUQ0MTRo?=
 =?utf-8?B?WUZ1TU15T2V2cDVWM0tSQ1g3OXFQLzl2R0FheUZ6WGJWVXY4ZVZSUUtoRGll?=
 =?utf-8?B?SlhwSmxhMkhtdENYa1FENWtsaEFnZzYyL2hXUURQbGt0OVFWRjBRbzhjWDNM?=
 =?utf-8?B?blBJNkk0dTFxRm5aWlFWWjF3L1RscHR4OXRLUzFYUG5MSVl6ajJ3SjlPcHlG?=
 =?utf-8?B?aDEvK3BEZ25DZE1peDVNTHFGaGFkeHRzNTNRSlBKenpYME1IUTNITkd3cUtx?=
 =?utf-8?B?NmNZWmJ4Nkc3ODlLbmVvVEVyQWtzaHVYaEk1M3RDRlRKdGx1YVRNOHBINUJ3?=
 =?utf-8?B?ZDhqUDBiRXo5cFVOeVlBMVhJY0pFV0VobTl4anY2VEduNitwY2RSOEoxcmx2?=
 =?utf-8?B?TEhRMDRJQ3Y0WE1KQ0xsd1ZZekZOaUhhdmVjUkJwNTRrN1ZxU1psR1lqbUxy?=
 =?utf-8?B?UGtjdWhLTUNML2k1WEFCNjd1TnhWdnQxTElQem15dWdrVWsrTHBIKytUVnJv?=
 =?utf-8?B?NDY4OGY0bm1yVUxJUmJFc0krTU1iMzRta2F5QmxCekp4dkdYVjBrdWxyMU1w?=
 =?utf-8?B?NzVpYzNQZEZnTHVHVm9RS0duY2twUDZjU2g2amppUXc3akNFeFZIenFMMTU0?=
 =?utf-8?B?Y2YwMXFjWFBzQjhnRXhkYXFIV21FT0dnMGtxM25MTXRkY2ZIVG81NlNyekpv?=
 =?utf-8?B?ek52VHhaK1poQ2tERm1hakRyZGZxaUNUUWpRZHUwdWw0djhEODNrMXM3dkRh?=
 =?utf-8?B?SHpoSlNMclFmNGxqajAxUHY1OVpYMzdNd2VSd2hRMHcwVjQzeXJabmtZdjh4?=
 =?utf-8?B?NVBTTHZnMi9UcGY3cXVhdGJ6UkpRcUV4ME5WRkRSMU1nMTNhb2doSmNxUzls?=
 =?utf-8?B?cDNxUnhac09IRW5GUmg5SGRtNFJEYWFIa2NyMUNwSEFNNW1HSi9KRVowUjZk?=
 =?utf-8?B?OVE2SERXWWJJUWJKZTlFeENOSVYydlpyR0dwODBvZEdGdkhmR1UrK2JZSk4r?=
 =?utf-8?B?L28xUi94YUZvbHhma2Z6RTZEMko3SEMzNWs2cmkwREFJaG5zYVNaYWx2bFRt?=
 =?utf-8?B?dGIyMmgvakNlVUVvRUdpMDJGUWthanpxWkdSQkJsWlVGQy9sa2Z2ZHF5VEl5?=
 =?utf-8?B?NlMxTTYvN2x3VmY4Q2M5Zm5OajhzVS9rTzRrZFhocmkzQmc2czNKV1R6UFha?=
 =?utf-8?B?Mi84V201cU56SVdyc2xJbTZXVnBDY2RBYnpiYVcrWlJneFBkUi8rRGpPYWNx?=
 =?utf-8?B?d0FCL3dEMm5mZ3gxYjQrRU5qY1hBRjU0ODd6a1l6cHBsL05UUU5NMVBOV2NO?=
 =?utf-8?B?QzQ2RjRHc3k4bDBVZFhCUlFNOEZVVWJhT2cyVmtIM3ZrOURMTDJhUExSYlY5?=
 =?utf-8?B?VGlLNFFUMkt0emhIck1MR3pQSmhqaWxBenBuby8rK3dFaDdDODZoUUhsMVB3?=
 =?utf-8?B?VjJRSDhGeldsZGsyUElhNE1IbDJYSlhrWXBTNlh2OGJkOGMwazRsR2ZSdFdH?=
 =?utf-8?B?aXAwMkdMMU5vK3c2eWxLaHJsaU9XeE1iaHRrQVNkeFQrN3hPN0lmd3RjcGN4?=
 =?utf-8?B?WWh5eWw3Y25Ra1VDMHphNUxlWG41TTIrUEJJSDBVTzJKeGkrcGl6SUd0S0wx?=
 =?utf-8?B?c01JSmVmYXh3aVg5WHg0SElCbW9KaFJLN1BmcHRBc0RZU0lxem56NFFPYXFF?=
 =?utf-8?B?SHJ3THJBcFMvUEF1amZoMkdEeXhkNE1UQU1EZFp2THpzT1cwWFN3TDdJc0w1?=
 =?utf-8?B?VXhadGw1WTZFeVpDcGk5b0NvdlhxQ2N0alJyVUhNOU9EeFpUMHp5MWUvOUFI?=
 =?utf-8?B?NGpYSDFrK1NIM1Njb253YWNtOHpDL1grM3dBQTdqT0lXUk5vQUxxNzZxSGxl?=
 =?utf-8?B?QXhINkY2eDlyemFva1NDWGR2Z3F0ZUVqR0N4NUd5bXRFa3FIMkFUc1ltUkcv?=
 =?utf-8?Q?AwDpDUbW3yxOOjvu0Hm7koE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6516AAF9209F4243877997F390D6C43C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e64290-0530-4e8e-8d04-08db16949290
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 18:25:57.2662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlHKUdaDZBwRRvhU+NPPzer9bBFlF6xtS2pB4ut6EK6A+s4GVA5Pq34Sky3NFfB+y42apanROawe/dNpfFv2/NK1jQ+4vLP377aAil05zd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAyLTI0IGF0IDEzOjIyICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFNhdCwgRmViIDE4LCAyMDIzIGF0IDAxOjE0OjIxUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IERvIG5vdCBzdXBwb3J0IElBMzIgZW11bGF0aW9uIG9yIHgzMi4NCj4g
DQo+IEJlY2F1c2U/IFNpbXBsaWNpdHk/DQo+IA0KPiBObyBvbmUgY2FyZXMgYWJvdXQgMzItYml0
Pw0KDQpZZWEgYSBsaXR0bGUgb2YgYm90aC4gT3JpZ2luYWxseSBzaGFkb3cgc3RhY2sgMzIgYml0
IGVtdWxhdGlvbiB3YXMNCnN1cHBvcnRlZCBmb3IgNjQgYml0IGtlcm5lbHMsIGJ1dCB0aGVuIEFu
ZHkgTHV0b21pcnNraSBhc2tlZCBmb3IgdGhlDQpzaWduYWwgQUJJIHRvIGZsZXhpYmxlIGVub3Vn
aCB0byBzdXBwb3J0IGFsdCBzaGFkb3cgc3RhY2tzIGluIHRoZQ0KZnV0dXJlLiBUaGlzIGludm9s
dmVkIHN0dWZmaW5nIHRoaW5ncyBvbiB0aGUgc2hhZG93IHN0YWNrIHRoYXQgZGlkbid0DQp3b3Jr
IHdlbGwgZm9yIDMyIGJpdC4gUmVzb2x2aW5nIHRoaXMgd2Fzbid0IGV4aGF1c3RpdmVseSBleHBs
b3JlZCwgYnV0DQp0aGVyZSB3ZXJlbid0IGFueSBvYnZpb3VzIHRoaW5ncyB0aGF0IGp1bXBlZCBv
dXQuDQoNClRoZW4gdGhlcmUgd2FzIHRoZSBxdWVzdGlvbiBvZiBob3cgbXVjaCAzMiBiaXQgQ0VU
IGFwcHMgcnVubmluZyBvbiA2NA0KYml0IGtlcm5lbHMgd291bGQgZ2V0IHVzZWQuIFNpbmNlIHNo
YWRvdyBzdGFjayBuZWVkcyBhIHJlLWNvbXBpbGUgdGhpcw0Kd291bGQgb25seSBiZSBmb3IgbmV3
bHkgYnVpbGQgMzIgYml0IGJpbmFyaWVzLCBub3Qgb2xkIGxlZ2FjeSBiaW5hcmllcw0KdGhhdCBz
ZWVtcyB0byBiZSB0aGUgdGhpbmcgb2Z0ZW4gdXNpbmcgbGVnYWN5IGVtdWxhdGlvbi4gU28gaXQg
d2FzIGtpbmQNCm9mIG5vdCBleHBlY3RlZCB0byBiZSB1c2VkIG11Y2ggb3IgYXQgYWxsLCBzbyBh
bnkga2luZCBvZiBjb21wbGljYXRpb25zDQp0aXBwZWQgdGhlIHNjYWxlcyB0b3dhcmQgZHJvcHBp
bmcgaXQuIFBldGVyWiBicm91Z2h0IHVwIFdJTkUgcnVubmluZyAzMg0KYml0IFdpbmRvd3MgYXBw
cywgYnV0IGFwcGFyZW50bHkgV2luZG93cyBkb2Vzbid0IHN1cHBvcnQgMzIgYml0IENFVA0KZWl0
aGVyLiBBbmQgdGhlbiB0aGVyZSBpcyB0aGF0IHdlIGNhbiBhbHdheXMgYWRkIGl0IGxhdGVyIGlm
IGEgYmlnIHVzZQ0Kc2hvd3MgdXAuDQoNCkknbGwgYWRkIGEgbGl0dGxlIG1vcmUgaW5mbyBpbiB0
aGUgY29tbWl0IGxvZyBhYm91dCB0aGlzLg0K
