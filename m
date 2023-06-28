Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DDB740793
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jun 2023 03:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjF1BXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 21:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF1BXu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 21:23:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C333268B;
        Tue, 27 Jun 2023 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687915428; x=1719451428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QKiHn6nVClD+zdtqW4XLL9ZQSOZ2HZrQAeSO52NwO8o=;
  b=itI2DPQ2f1msVx0aETCxKTfI2uRQyDbAxm7F1Sc2KdIOmOSfJIoCyxL2
   4dVC8kVY6xla3KWpl7HJ3tMqMiB16etFcZzJ5/1vs87tqhuij7IE5sLkU
   q813NGC5ko0VdrW9RecwMr1yuGRfpH6J1cBQiuuTijQSdnuTMM1KP2Inh
   iNwfE1fk9ekt34w8wZm/DUh4A03pvBJt45vPI/VCFWEUOZ1ZU5Fms+/iD
   0GxngO4PNL1BLE2L/cKmHtfj2n4wGTt6fPC0Pbciw7wCWVQfM1D7cDLSh
   wWoTNqE0Ldy8LQunquiiLiy7xjx3fkrhHq9iw68AhcUnAwiTYqSyGnVH1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="448106744"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="448106744"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 18:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="752019745"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="752019745"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 27 Jun 2023 18:23:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 18:23:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 18:23:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 18:23:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 18:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYXpLsBmYkbxzQ6crOhIDJNijlai6TQq7gzkU/DPqAu3Tf2DbD/tovoaeRPFThZvcEJeWJ29cYUyUNsI4SVvYCXCrrhAU6fZUKovLLRZvWzvqit6oEBk/4xSkSreLjXAvDINfoEG00FhUCuZS5nsDoPxeizpIGVlOlgBQfrKMMfqyCvAyP1pk+/svItjikS0bzl/h2ONKEC6NRgnExIGwLDxljUl4RCPvgbRvdd05/HE3I+EsGEOOBI+uKyTNyqpUinapYAj8REaAhWB09ZzokJIP8TpYJyzIu515l0wu1wjoidnb1WQtfhkcoWV0WDfSTt7T6IixsvwES0WdnyUIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKiHn6nVClD+zdtqW4XLL9ZQSOZ2HZrQAeSO52NwO8o=;
 b=hrfNHl/cxD7wd1inNRGwk7OBIATF7Bu1Cr5mKb2F9u+mw0E9SbOnzQFSyC/AcdrwyU0i+b/ll8loPMEu6Dsu1eyaGFpmc29ZNfnG8UU3/sGqWn6TG1ycEjz6TBU2vOYV9JKOrQYiEtNV5C7ld4h3fA/MzkPfLJv1cn1ODanQdq5Hs6FYc4vwzrT4trb5pjbj0aa+JeNP+jiRXQ2iVlApXcMSghrOlG8m7FITm6lSCKI4GOzI4PdwQs0lcBqB658bU+Cax4B8L5qm613dljC501XMv1AG9NKXVB03IX1LifafV6HQd5LQcLklhBRQJExIWiVQ1/4lUbLu/AE66T5ESA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 01:23:30 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6984:19a5:fe1c:dfec%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 01:23:29 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Topic: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Thread-Index: AQHZnYvD++9jHqJtDEOZ5j0eN4/f+6+IoOQAgAALyMOAACwFgIAAIG6AgAAMtoCAACGsAIAA96CAgABofQCAB1K5gIAAhUGAgAEVRoCAAKx+AIABDK+AgAB6bICAAEU5AIAAkNiAgACYg4CABh04gIACTu4A
Date:   Wed, 28 Jun 2023 01:23:29 +0000
Message-ID: <efb0d09bd772bd4cea9d71b5827e348c6c6f955f.camel@intel.com>
References: <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
         <ZJAWMSLfSaHOD1+X@arm.com>
         <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
         <ZJFukYxRbU1MZlQn@arm.com>
         <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
         <ZJLgp29mM3BLb3xa@arm.com>
         <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
         <CAMe9rOrmgfmy-7QGhNtU+ApUJgG1rKAC-oUvmGMeEm0LHFM0hw@mail.gmail.com>
         <ZJP664odSJC+tGzT@arm.com>
         <39786e2e74013d3006cc6081e4f7faffadcab8f2.camel@intel.com>
         <ZJmb24iHBQBXIpxB@arm.com>
In-Reply-To: <ZJmb24iHBQBXIpxB@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH8PR11MB6609:EE_
x-ms-office365-filtering-correlation-id: 0937fa7d-b4a1-4775-27cd-08db7776479c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDbfahP9ePKwB00StlpJ+dDiurO9vdnaQr1e0AZUHPk7pWHMgyGAND0v4tfScQE6UgaQ/eii96yz1lg8KiIHDrXpBhk5IPoSPQP0dciptiyxmbH4FRsCb0iCtasZ0qNqY3I7qmWkEwVPli4fSHniqFf8/LOHK5RDZuITxbf+BFcpzro5AL0XFNJK4Ztmo2vgBJLRnaHWLcb/YIy7z3fp3hk+upBC03kI0md7FAygEMDZcSVy2M1gBkgAJBmsutE9LpWWVsrg6xW9dHkrUxe4jmoGOEoObmnHKY6yg+sj12toPYNBFBcFNukmD3hHJqOPWgOpw284Kuv8qZVk2JV4NUkJ/0K/SUl538uB/Ydfb25NZVAXqOtri0tHYpdFNEu6Ijh10/jBvd4Ac8dYf/jEab57K9DzdvPUNZy4Ll1727T5FSyYhreKQZOoIINWoMaw55GzxlgFL225bhP9hZEusmsnU2u9X6ALWC1kU/o1NYVzwYLlwqoYBI14u4urVrvbOFuvt+vV7/1R2GSOPUWzq2Jj7d98q/PyOErM9/4+6kG69zvMb78nRoTywYcI+oGVBHHJSDjU3S23g/tIcnK4Tk0M8AAQaFcx0g1xeJaPh5Pnsdi0kFg5OSYsjBDXu0H9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199021)(2906002)(6486002)(26005)(83380400001)(38100700002)(82960400001)(71200400001)(2616005)(122000001)(6506007)(6512007)(186003)(41300700001)(54906003)(110136005)(86362001)(4326008)(38070700005)(478600001)(76116006)(66556008)(66946007)(66446008)(66476007)(316002)(64756008)(8936002)(8676002)(5660300002)(91956017)(36756003)(7406005)(7416002)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXJuTG5WWXBlVDdkU2J3eEFwTzZqM1VGWGIrSkh1clZpaHNjenVtTU5EKzZt?=
 =?utf-8?B?dXBTTEx0N0twK1ZwWFVzWU9RK3VXSnRqMi9Oa0UwWm5lcW9JL0puNXdzdjNs?=
 =?utf-8?B?bnM0WDBBVTNUUks5RTlFZjMxYmU1ZFIxNWs5cHROS3ZIaHNncXhKZGZvQWpX?=
 =?utf-8?B?TGxRTEZEM0xJWmgvKzhkVU9ERThYdDQxbHBBL0xocHNyY3o4QkduQmpOR040?=
 =?utf-8?B?VWxWU0U5SlhocWNqd3pJK3ZzM3ZvZmpJek8xeUkrc010S1NUd2dkMWFFTzFx?=
 =?utf-8?B?ZnN4ZUtQSUpqKytRVUxnQ0VhajBiM3ZISEwrN09SNVBwY2puM0lqUUdHSVBE?=
 =?utf-8?B?Z2lxbG1UYSt1NGFEdHNzL3Jnbkd6aHZyeXV0Q2hMRzFHZ1ovYWR2RS9OUVc4?=
 =?utf-8?B?TWNkOUVIWnJmM3E2L1VrcjA2c2JrY3FscTV4R1J0Vm9YUWZrcE5BbDdROVp0?=
 =?utf-8?B?UnJEeFpTaG5UeHZraitXUU1DemxJOUR6SHVSV2IvcTRaRStTa2kwZ0lBUVRv?=
 =?utf-8?B?STQ2OExyNjB5UlFsRzBvdHpHWDIxN3J1ZTZUNHA4T0dwRlFheFZua3AyRm5U?=
 =?utf-8?B?RFJzMDh3eUtsQ1lNZm56TVhUTWhkWmg5M1NNelhmd1pBZk10bVZRYUxnVnpI?=
 =?utf-8?B?M1FORjBWME5JbXJBUk5xVXJuRXZlQUNsdlRrbDZLc3FIZWlTOHl0RWJpVmVN?=
 =?utf-8?B?VlhPRktOSjVHVkFlYlI1RCsyMG5YM2tzOEgydWZ4UkVwQkZ1VG5FRUk5emFy?=
 =?utf-8?B?NkNKUWVrRFV2WVpLbmRNRE5xWUU4V2VXS054SDZVUDAxRzErWEx6UHF6STFy?=
 =?utf-8?B?TkI0bHpwNXZLVEhMQ0JRam1hd1M1c3RZckNOVm5FSTBHU3IyUFF0cnA2aGRt?=
 =?utf-8?B?SDdGenV4ZlNHT1VWYkpNaTQrNlFObG9FbXQrOGtmV1YxMUNCTzZnbjQ0cTFI?=
 =?utf-8?B?TWVlQ1kvWENwTlU2TVlOdzYyVEZTTVJRT0ZjbWx2cnljZVZkbWE2cWMyRGRU?=
 =?utf-8?B?dDBpSExCQUNkRHFLNGt6dVhDUHpIZnVkdlRtU05QWkE0eStiVFRxa2xPb2dY?=
 =?utf-8?B?Nk9DelFPelFHeTI4c2xwckFaNktpTEJjUWV0VFlPajdHd2t3R2tKVWo0NkV6?=
 =?utf-8?B?KzJObG43b0VQam9ZWUxaZDgxWS9JQUtxbVpHNjc4Z2FGb1JMZnpIMXBZUC9r?=
 =?utf-8?B?eE9QVUFVa0pQNk54SW5lYlRhMytVS3ZBMFU1WkRCWW9PQWMvd0Z1QXF6dGJF?=
 =?utf-8?B?SXhld1cxWkVMS25ZcHJlakFXS1pWRllZV2dEYkdrT0VCQy93ak5sRGgwS0o2?=
 =?utf-8?B?RzBrZmkvbzBnV2tvU2UxYTFHOHMrS3lJbUgwSGhqTGdwR29LK09VMmNrNzNw?=
 =?utf-8?B?eUE5c0I3cG9zSW80VHBwbkxiYS9DWENBRlFweG1lQUVURE9EYnByL2FONHRK?=
 =?utf-8?B?RjlKWVcxd0t0RER5M0Q2UXFCZmM5NFZ6MEZVQ2FuSmZIQXU2QTRsS25CKzh0?=
 =?utf-8?B?NzJ2ZFpIMW9PNU9MK2Rqem1aNHIxVlo1cVl3SVVGWldiRzZ6b2ozaXlDT3lZ?=
 =?utf-8?B?MUozbWtvc1R0TitXU0NWbmdXaUxGdU1EaVgrWEVObGZwSi9nUTRzRU5CeGpR?=
 =?utf-8?B?bGpKOFQrS2k4ZitVenN3VWJGbDc3aXB4VlcxRXVML3phaExtYWMrb3lKU1hz?=
 =?utf-8?B?YjJGL3ZWRnU1ZG5QNHI5TEYyTXROdnhCWWx2SkJ3Z05ta3BVdnJKVnkxcnBt?=
 =?utf-8?B?dFdrYXowbnR1aWQxdUF1T0liUzJMalpuMEptVHZjMEhPV2JoWTFONXIwUjJt?=
 =?utf-8?B?SysxVGRBOGNZaWlCVTRIdzRhUkFERysxZDdmem9NaTlxcFlmemJqbktFZGQz?=
 =?utf-8?B?ZWErRTdySFpZWkU5MVRHYS9sNW1qK3c1SVRjVnJhNXl0S0dTcVJHT2x3SEp0?=
 =?utf-8?B?VnNwWGRYNThGaTBFQmd5M01OdHhHNEIxQ2dwOGFtdUZEN0ZQcmxmWEwvUFF4?=
 =?utf-8?B?dnZLK09SdFVSV3BJdVF6VkNMVVlqYks1YWVjaTErSnV3ZFp5cFNMUjZERHp3?=
 =?utf-8?B?dUxLS29PT0ZKYit1UStCTE52bUhNS2ZXOHk1MUFSYlFZcGNOeWY1VWQxMjNu?=
 =?utf-8?B?ZW1kSGx0NWowdTdxZElNOEl5VFZ6WG9Va2pQR0hjUVl6UmdZVlREem1OaEdY?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <649A8F434C653D4DB1B9F619B3CD33C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0937fa7d-b4a1-4775-27cd-08db7776479c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 01:23:29.3894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDJNRrOTfHTcCHhvnoaYv6Xkx0nMKMraJL7eK/j3qfZBnKcIyMeU1NyORi7giwIJa30QDp2Vp0+9Fz3fC2cd1uXvFsvz1rhUsldosFnbMeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTI2IGF0IDE1OjA4ICswMTAwLCBzemFib2xjcy5uYWd5QGFybS5jb20g
d3JvdGU6DQo+IFRoZSAwNi8yMi8yMDIzIDE2OjQ2LCBFZGdlY29tYmUsIFJpY2sgUCB3cm90ZToN
Cj4gPiBZb3UgcHJldmlvdXNseSBzYWlkOg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyMy0wNi0yMSBh
dCAxMjozNiArMDEwMCwgc3phYm9sY3MubmFneUBhcm0uY29twqB3cm90ZToNCj4gPiA+IGFzIGZh
ciBhcyBpIGNhbiB0ZWxsIHRoZSBjdXJyZW50IHVud2luZGVyIGhhbmRsZXMgc2hzdGsgdW53aW5k
aW5nDQo+ID4gPiBjb3JyZWN0bHkgYWNyb3NzIHNpZ25hbCBoYW5kbGVycyAoc3luYyBvciBhc3lu
YyBhbmQNCj4gPiA+IGNsZWFudXAvZXhjZXB0aW9ucw0KPiA+ID4gaGFuZGxlcnMgdG9vKSwgaSBz
ZWUgbm8gaXNzdWUgd2l0aCAiZml4ZWQgc2hhZG93IHN0YWNrIHNpZ25hbA0KPiA+ID4gZnJhbWUN
Cj4gPiA+IHNpemUgb2YgOCBieXRlcyIgb3RoZXIgdGhhbiBmdXR1cmUgZXh0ZW5zaW9ucyBhbmQg
ZGlzY29udGlub3VzDQo+ID4gPiBzaHN0ay4NCj4gPiANCj4gPiBJIHRvb2sgdGhhdCB0byBtZWFu
IHRoYXQgeW91IGRpZG4ndCBzZWUgaG93IHRoZSB0aGUgZXhpc3RpbmcNCj4gPiB1bndpbmRlcg0K
PiA+IHByZXZlbnRlZCBhbHQgc2hhZG93IHN0YWNrcy4gSG9wZWZ1bGx5IHdlJ3JlIGFsbCBvbiB0
aGUgc2FtZSBwYWdlDQo+ID4gbm93LsKgDQo+IA0KPiB3ZWxsIGFsdCBzaHN0ayBpcyBkaXNjb250
aW5vdXMuDQo+IA0KPiB0aGVyZSB3ZXJlIHR3byBzZXBhcmF0ZSBjb25mdXNpb25zOg0KPiANCj4g
LSB5b3VyIG1lbnRpb24gb2YgZm5vbi1jYWxsLWV4Y2VwdGlvbiB0aHJldyBtZSBvZmYgc2luY2Ug
dGhhdCBpcyBhDQo+IHZlcnkgc3BlY2lmaWMgY29ybmVyIGNhc2UuDQo+IA0KPiAtIGkgd2FzIHRh
bGtpbmcgYWJvdXQgYW4gdW53aW5kIGRlc2lnbiB0aGF0IGNhbiBkZWFsIHdpdGggYWx0c2hzdGsN
Cj4gd2hpY2ggcmVxdWlyZXMgc3NwIHN3aXRjaC4gKGN1cnJlbnQgdXdpbmRlciBkb2VzIG5vdCBz
dXBwb3J0IHRoaXMsDQo+IGJ1dCBpIGFzc3VtZWQgd2UgY2FuIGFkZCB0aGF0IG5vdyBhbmQgaWdu
b3JlIG9sZCBicm9rZW4gdW53aW5kZXJzKS4NCj4geW91IGFyZSBzYXlpbmcgdGhhdCBhbHQgc2hz
dGsgc3VwcG9ydCBuZWVkcyBhZGRpdGlvbmFsIHNoc3RrIHRva2Vucw0KPiBpbiB0aGUgc2lnbmFs
IGZyYW1lIHRvIG1haW50YWluIGFsdCBzaHN0ayBzdGF0ZSBmb3IgdGhlIGtlcm5lbC4NCj4gDQo+
IGkgdGhpbmsgbm93IHdlIGFyZSBvbiB0aGUgc2FtZSBwYWdlLg0KDQpJIGRvbid0IHRoaW5rIEkg
ZnVsbHkgdW5kZXJzdGFuZCB5b3VyIHBvaW50IHN0aWxsLiBJdCB3b3VsZCByZWFsbHkgaGVscA0K
aWYgeW91IGNvdWxkIGRvIGEgbGV2ZWxzZXQgc3VtbWFyeSwgbGlrZSBJIGFza2VkIG9uIG90aGVy
IGJyYW5jaGVzIG9mDQp0aGlzIHRocmVhZC4NCg0KPiANCj4gPiBCVFcsIHdoZW4gYWx0IHNoYWRv
dyBzdGFjaydzIHdlcmUgUE9DZWQsIEkgaGFkbid0IGVuY291bnRlcmVkIHRoaXMNCj4gPiBHQ0MN
Cj4gPiBiZWhhdmlvciB5ZXQuIFNvIGl0IHdhcyBhc3N1bWVkIGl0IGNvdWxkIGJlIGJvbHRlZCBv
biBsYXRlciB3aXRob3V0DQo+ID4gZGlzdHVyYmluZyBhbnl0aGluZy4gSWYgTGludXMgb3Igc29t
ZW9uZSB3YW50cyB0byBzYXkgd2UncmUgb2sgd2l0aA0KPiA+IGJyZWFraW5nIHRoZXNlIG9sZCBH
Q0NzIGluIHRoaXMgd2F5LCB0aGUgZmlyc3QgdGhpbmcgSSB3b3VsZCBkbw0KPiA+IHdvdWxkDQo+
ID4gYmUgdG8gcGFkIHRoZSBzaGFkb3cgc3RhY2sgc2lnbmFsIGZyYW1lIHdpdGggcm9vbSBmb3Ig
YWx0IHNoYWRvdw0KPiA+IHN0YWNrDQo+ID4gYW5kIG1vcmUuIEkgYWN0dWFsbHkgaGF2ZSBhIHBh
dGNoIHRvIGRvIHRoaXMsIGJ1dCBhbGFzIHdlIGFyZQ0KPiA+IGFscmVhZHkNCj4gPiBwdXNoaW5n
IGl0IHJlZ3Jlc3Npb24gd2lzZS4NCj4gDQo+IHNvdW5kcyBsaWtlIGl0IHdpbGwgYmUgaGFyZCB0
byBhZGQgYWx0IHNoc3RrIGxhdGVyLg0KDQpBZGRpbmcgYWx0IHNoYWRvdyBzdGFjayB3aXRob3V0
IG1vdmluZyB0aGUgZWxmIGJpdCBydW5zIHRoZSByaXNrIG9mDQpyZWdyZXNzaW9ucyBiZWNhdXNl
IG9mIHRoZSBvbGQgR0NDcy4gQnV0IG1vdmluZyB0aGUgZWxmIGJpdCBpcyBlYXN5DQooZnJvbSB0
aGUgdGVjaG5pY2FsIHNpZGUgYXQgbGVhc3QpLiBUaGVyZSB3ZXJlIHNldmVyYWwgdGhyZWFkcyBh
Ym91dA0KdGhpcyBpbiB0aGUgcGFzdC4NCg0KU28gSSBkb24ndCB0aGluayBhbnkgaGFyZGVyIHRo
YW4gaXQgaXMgbm93Lg0KDQo+IA0KPiAoaSB0aGluayBtYWludGFpbmluZyBhbHQgc2hzdGsgc3Rh
dGUgb24gdGhlIHN0YWNrIGluc3RlYWQgb2YNCj4gc2hzdGsgc2hvdWxkIHdvcmsgdG9vLiBidXQg
aWYgdGhhdCBkb2VzIG5vdCB3b3JrLCB0aGVuIGFsdA0KPiBzaHN0ayB3aWxsIHJlcXVpcmUgYW5v
dGhlciBhYmkgb3B0LWluLikNCg0KVGhlIHg4NiBzaWdmcmFtZSBpcyBwcmV0dHkgZnVsbCBBRkFJ
Sy4gVGhlcmUgYXJlIGFscmVhZHkgZmVhdHVyZXMgdGhhdA0KcmVxdWlyZSBhbiBvcHQgaW4uIEl0
IG1pZ2h0IGJlIHRydWUgdGhhdCB0aGUgYWx0IHNoYWRvdyBzdGFjayBiYXNlIGFuZA0Kc2l6ZSBk
b24ndCBuZWVkIHRvIGJlIHByb3RlY3RlZCBsaWtlIHRoZSBwcmV2aW91cyBTU1AuIEknZCBoYXZl
IHRvDQp0aGluayBhYm91dCBpdC4gSXQgY291bGQgYmUgbmljZSB0byBvcHRpb25hbGx5IHB1dCBz
b21lIElCVCBzdHVmZiBvbg0KdGhlIHNoYWRvdyBzdGFjayBhcyB3ZWxsLCB3aGljaCB3b3VsZCBy
ZXF1aXJlIGdyb3dpbmcgdGhlIGZyYW1lLCBhbmQgYXQNCnRoYXQgcG9pbnQgdGhlIGFsdCBzaGFk
b3cgc3RhY2sgc3R1ZmYgbWlnaHQgYXMgd2VsbCBnbyB0aGVyZSB0b28uDQoNCg==
