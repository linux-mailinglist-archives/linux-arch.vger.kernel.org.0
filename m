Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2CF62A46A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 22:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKOVq2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 16:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKOVq1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 16:46:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E0CAE7A;
        Tue, 15 Nov 2022 13:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668548783; x=1700084783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tc209InMG8zJXJ2smzGRNQLL2WzafcWHWwCHeCJ2YQg=;
  b=HFI8NBXdPYpw/sRBv5cEVlbkSRknLMbwB/gvX2YaQ/jMfMKRnlrwqoA+
   czax3ViOfHVRyNntVvKurt38ysodw1Ly+3qsiNEuEBWFHhzFRpxNm108+
   ZyUvQqHyhUZ0Sfg+1AyPyQcd2GguC8NTNHDAo9QKEYM4XBWVpVhYObOrM
   b57PiBegRVsuf8eulx+Q2uZIBX0khTCI7Dg7OP/qmL26XyBsHkaJwi8Fw
   TX9rBPA4gj/TGzeOgU80kw0eOzyqflPkQfrnTPW/UBdjnzOXFTBnJQl42
   JizY7dEQadzxmwvlnIHajGqcqn+TFMoSzo4JeXjGZuAY4GY/fpK1fFGfT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="310003332"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="310003332"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 13:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="707894236"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="707894236"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2022 13:46:22 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 13:46:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 13:46:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 13:46:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgSwyCKVyNIG4S8bhw/UUk9K0I1MRoOOPxKFaARImenkhdKcoZtlebg4OX+K3Bkd8joeHUf4cUGL8FvR5V6vsxYh/wB3+TzO+Q6ZSbdN9cnN3ytiv33SKyYpyv7fBlQeZKgu7SbidhwnqoLIxG+zPQhtfdSsIxGCTu3KFgXWjhavJVtWGZt0vJfIRx42GTM9AfZy0BAGpm4uYPjIqq5gRtfI2rohWSG4o6xQ6Wjzshl0kLFuteSPoeCFkde+9DdHSppo+K7+1yf9hvTbDgF9zYjO/i6jMjr6FJNCavz9iIQQsHL3zI9n9EB6waypIq8b/7ikfApVNoiKt6ubO3Sw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc209InMG8zJXJ2smzGRNQLL2WzafcWHWwCHeCJ2YQg=;
 b=QGbiRCZmSMw79k9lbP36voa4kNL5zRPG4sO92B35oVnCENrU05ss6l+0njt9bhW3rJM1Kt20OJPEORni0PgDznDlHrE9LrIBsJdLbTkiG6E77tMQO/1n3BaSypVK77bEjhyx5s0jYwM35S8jxokGH36xzuJrK0rWo+3TkBerUZAEzW3clAh/9JZGVL1CFg0Q3IYfm/06IalfU+EijprGZ1L5konUX16es0AS1NZD9f7PCyrRkRi1IHvIEYvtoX7ht0jo+1G6tQsXZBQu8Tmbkl6WEuzPeHUd22ZWUBmrBkozQ+ShPhQ7/1FdQWjFThgbPLd+TMIddQfWhThFyzrVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 21:46:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 21:46:13 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
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
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 25/37] x86/shstk: Add user-mode shadow stack support
Thread-Topic: [PATCH v3 25/37] x86/shstk: Add user-mode shadow stack support
Thread-Index: AQHY8J5ePUADd6Ic9E+fUYJmZCKAz64/+2yAgACasgA=
Date:   Tue, 15 Nov 2022 21:46:13 +0000
Message-ID: <ef2c04a3b3156210a372b6653180cb33bc49f4d7.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-26-rick.p.edgecombe@intel.com>
         <Y3OG31hoj/q4Bgh7@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3OG31hoj/q4Bgh7@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7637:EE_
x-ms-office365-filtering-correlation-id: b71935d9-7cc7-4c57-a95a-08dac752d0f3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIQExoQeAxkWou/Ifd95408+ytwUcZo+5LQgIkN2N9H1vZUM5XlhfnTQZxCJ7bUw5HhPTr41JD6GHZdCQTEr1sQcbHapAJXHsB+yBRAQ/qFk+5zhad3sNUsVwVl9Gfeo1LE12oWrGXxa/ZQb4IUPibreC64CyB48Dbi2IZSy6Si2kgdoUENOWJBmECrHGbMBBBkf7HwJVVgu8GAI0cdSSRXhWgSCrHCcX7giuNwmMdOn9HLmTlcce7eYbERx5nBH8ZEG/8fCAUPeHQ59pCys3FsVCXth8/Ku8y25egdfn3b/dNbeGCU6YNJTB8G1xBmBSNj/qf4qij0gh2UCLdkH4MuM8UMgSmpWP7P27cUxcCPJBKAnEWFdawbMt6OxUCJpN8pX2WiSQEH8Iyyynxc3hHXgJJ1sghTBggzGMLlaRcyGbiOGdOxaceaE6yzRd0rILNEOQyiuQuoVB2t0k7EeypXwTBIsnZj1kqneFYDi2Zj3ummPNskhAipGrr+0WWyl8qjGelT6SgCVDAUC7oF6HBSzQqYjMjolyiG2LCI6FOAOc53v0d7LtzVVuorvLwZ2ouoIR8UAXjsmk+rRpg+m1fmT7nWWkgb1nj5JTaWHeL4bOIEg625Hs09crfg6cOpoSYITeRZngc0lgs8eUt2ztHtkuvKRrUOScK2SWALhDq0kjvNx3XayiVwwDaRhOjBZUi5ZETiRAHRpWDpI3UGbN/cAHo0NodYrIVxyuORW6iN6pS8ym28V9Y9YaaqoVYqwy4h3oOq8NqRvVoxk+vd+ZxFMh5uvmU3ZJJqzA7zlJrY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(366004)(346002)(396003)(136003)(451199015)(7416002)(5660300002)(7406005)(71200400001)(36756003)(6512007)(8936002)(26005)(86362001)(2616005)(4001150100001)(6506007)(83380400001)(6486002)(478600001)(2906002)(8676002)(4326008)(186003)(38100700002)(66476007)(64756008)(54906003)(66446008)(6916009)(66556008)(82960400001)(76116006)(91956017)(316002)(122000001)(41300700001)(38070700005)(66946007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTdkWjNHUzl1TU1RdkdrazZvMWEvR3hFTjJWZ0EyMVJ6MkFxZFpqUlovNTRu?=
 =?utf-8?B?Z25JV3dSaWNUSWtoN1VJdVdhTUY1OWwzOXdkdkVVQy85LzAwMkg5UTB5eHRi?=
 =?utf-8?B?bXlRNlIxVmMrTzNvdWJPemFQQnU2Z1ZLR2VUcnBXWVZTei9obllHeDFGSFRO?=
 =?utf-8?B?aGxTejBmWmpUNzJzL3N1TS9peXFzRmZ0YlB0REFKTWxWRXk2SkRzNHRMQ0h0?=
 =?utf-8?B?RVJJNm5abmdVenpobDloR2I1MGswOFVMQ2xOSkVDcndFbG9OT29ycnA0S3Vj?=
 =?utf-8?B?TiszQlNlcUVRZWdOejBIQ1U2eGlYb3VkMngxZmZjcnBoYTloc3ltQmlNS2JN?=
 =?utf-8?B?YXh4cm9JcUVudnk2NmlHL1QrMS9KQTQ1WEVjcExLSGZ0bUM4bzhCTGVMVHBJ?=
 =?utf-8?B?WWhjVUZkRzZqaFpvblNCQVA0WWh0QUphaEYramJvV0VMUTBVd2JvcGUzUUpF?=
 =?utf-8?B?bnQzN2ZjY1VpZzZTTG9RRkhVbENBOUhKVkpHbjErNnVKSEhWZThjUy9UV0JI?=
 =?utf-8?B?aDB3NDg3VjBFRVFpSWc5N1BTc0ZPVDZtNnZDOVpMNjNacEgzeXNuZGVXMlhX?=
 =?utf-8?B?Vy9CNi93b2RtTmxQVGVUVmxjVDRJT0VlRHFZV0VqSzAyT2FaMVpyeGhFN1VP?=
 =?utf-8?B?d1BSMmVlei8vbUFNUllWQ01CWVdjb0ovWVB4TkF6MDFKbmhPdnYzN3IxMXVz?=
 =?utf-8?B?YTl3S1RpbzZYbWozbjEycHU2RG5IMCtWeG13UHJaSVJ1a3Joa2JDWExZNkRn?=
 =?utf-8?B?allPczBTcDI5QlNPYVZSM3RGcERyZ25xdzFCazQzUFlaRTh4eTRwaGliUUJj?=
 =?utf-8?B?SjJaN3VabmRPa1E3b1YwYjJSMnpRbnlUaHFYTTFmZjgxQW5qWWMyQjIvQXNF?=
 =?utf-8?B?SUhvbEFyWDVlVmZESWJhS0h5bStieXpyVW9SK0xRSEZOazNXZGlIZmNIZEkw?=
 =?utf-8?B?bnJkQkhLZENkeHVUVmF3VXRwZDBLVUY3b2swWWFtQkZyR2g1Qmh0TFYxTEdv?=
 =?utf-8?B?cFVtbVREVEd4d29Wb3lBYUQ5eDBjWm9HWW5UZCtEUmMrMEJMcGljRTZZK01G?=
 =?utf-8?B?SmtSSkpXeXhlNGkvZEw1cGdVSDh4czVNdHpzelpyNWxBdkdVOEt5MkR0YmE1?=
 =?utf-8?B?UGdnNmMvZjJUQm11YkFjamFzZmNMRVhWamUrN08ybGVRQU5xV0NBYy9ydFB2?=
 =?utf-8?B?Y0hOVDVKSmxRQStnVVFNYVZWWnZRK2tCVStKYWE0bkpIRTlKS1lvVFZzY0lx?=
 =?utf-8?B?YUJPVGRDa0FqdzlhUzRvWjQwTFViNDNtbkg4c3hCQ0JtWmdSc21RYWoza2th?=
 =?utf-8?B?d0Nya0EwUFRoMGQ5SGhSVzg0UEtNN1ppdDRQeXk0ZXJRRGpKOTZUNGJSVk83?=
 =?utf-8?B?ZHJLU2lnWUFBTmJmNitHSlpsckc2TUNSUDU1RWJsWjB2NHIyNUV2OVpGUStG?=
 =?utf-8?B?emh1dFlPM3MrSEZweFp0bXBaRlhMMElUeWNEL2JIc0kwd2twOUpvTmVoVWp5?=
 =?utf-8?B?VVRuS1FhOGZGT004OFN6VHZGM294Q2dQQVNKZ0h5dlFSV3AyNzBxTmJoWkIv?=
 =?utf-8?B?Z0tQQXVMU24rTTZWclVpa0FvMU5CWmhsbDFJV2YwcUJGcGZhclFKNDRQRjBj?=
 =?utf-8?B?U1lrMVVkRWhPcnRZY0dkcFlzd2hGbEZ0NlQ5dEZ0SFJwT0krRVJIZW1aV2dU?=
 =?utf-8?B?Ti9tQllSZndSMTBnTVdmR1B1dVQ2NmhUR2FCcDN3SHpwZW02VWdjN0p5b2lu?=
 =?utf-8?B?aUlBZUlkcjNHSHpNL1hzUFVTT3pjOEJNQ3lUcHJBM3ZTVStmbTZSQ2lSMTZ5?=
 =?utf-8?B?SGtYaVdQNm9XcEFNRTcrdnNtVTlNL1dKUEZrOStvekNzenhLZGJnR3Z3c3l5?=
 =?utf-8?B?RXJvSGJGL1RINTRwUm5Ba2YzandZWm9rN2R6eCt5MlNyN3J0SW94VlJPM0JY?=
 =?utf-8?B?alFYcVhOQlVGSU1JU3hjazIxZC8xQzRXcmtSUkV4K1BGY3ZIejNZTE9GTHBn?=
 =?utf-8?B?QUV6QTdjS0dvalU3Y0ljL2pkY3pjMTFwYzlleUI4Y2tmQWVsTW5EUjZLUHFF?=
 =?utf-8?B?bVZ5MFVwUjU3N0JKOStRYlltTmhSSDFKVktHeUVlMVNMdjEzQStqWDBNaGlD?=
 =?utf-8?B?WnFGOHZFUmZmVWZ6VUNaZmZHNERSczZkVVRSZHVpMTN0TkNLTXdWNWF2RXZM?=
 =?utf-8?Q?Os41JKbKIfEb0jgKjuynSRc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13CB2DD0210FEF4E9600102EFB8E6485@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71935d9-7cc7-4c57-a95a-08dac752d0f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 21:46:13.3065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9NxCYC7Ma3wvrXudHvjHsdQQo2iGIuUD/N+CimHwqUT/5b5VsRwNulzpB2c1FqWAhyIBejtTaU8gQilTXz4Fx4TxtSv/Us5GRck3FHvuj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDEzOjMyICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gPiArICAgICBzdHJ1Y3QgdGhyZWFkX3Noc3RrICpzaHN0ayA9ICZjdXJyZW50LT50aHJlYWQu
c2hzdGs7DQo+ID4gKyAgICAgdW5zaWduZWQgbG9uZyBhZGRyLCBzaXplOw0KPiA+ICsNCj4gPiAr
ICAgICAvKiBBbHJlYWR5IGVuYWJsZWQgKi8NCj4gPiArICAgICBpZiAoZmVhdHVyZXNfZW5hYmxl
ZChDRVRfU0hTVEspKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsg
ICAgIC8qIEFsc28gbm90IHN1cHBvcnRlZCBmb3IgMzIgYml0IGFuZCB4MzIgKi8NCj4gPiArICAg
ICBpZiAoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfVVNFUl9TSFNUSykgfHwNCj4g
PiBpbl8zMmJpdF9zeXNjYWxsKCkpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNV
UFA7DQo+ID4gKw0KPiA+ICsgICAgIHNpemUgPSBhZGp1c3Rfc2hzdGtfc2l6ZSgwKTsNCj4gPiAr
ICAgICBhZGRyID0gYWxsb2Nfc2hzdGsoc2l6ZSk7DQo+ID4gKyAgICAgaWYgKElTX0VSUl9WQUxV
RShhZGRyKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKCh2b2lkICopYWRkcik7
DQo+ID4gKw0KPiA+ICsgICAgIGZwcmVnc19sb2NrX2FuZF9sb2FkKCk7DQo+ID4gKyAgICAgd3Jt
c3JsKE1TUl9JQTMyX1BMM19TU1AsIGFkZHIgKyBzaXplKTsNCj4gPiArICAgICB3cm1zcmwoTVNS
X0lBMzJfVV9DRVQsIENFVF9TSFNUS19FTik7DQo+IA0KPiBUaGlzLi4NCj4gDQo+ID4gKyAgICAg
ZnByZWdzX3VubG9jaygpOw0KPiA+ICsNCj4gPiArICAgICBzaHN0ay0+YmFzZSA9IGFkZHI7DQo+
ID4gKyAgICAgc2hzdGstPnNpemUgPSBzaXplOw0KPiA+ICsgICAgIGZlYXR1cmVzX3NldChDRVRf
U0hTVEspOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICtzdGF0aWMg
aW50IHNoc3RrX2Rpc2FibGUodm9pZCkNCj4gPiArew0KPiA+ICsgICAgIGlmICghY3B1X2ZlYXR1
cmVfZW5hYmxlZChYODZfRkVBVFVSRV9VU0VSX1NIU1RLKSkNCj4gPiArICAgICAgICAgICAgIHJl
dHVybiAtRU9QTk9UU1VQUDsNCj4gPiArDQo+ID4gKyAgICAgLyogQWxyZWFkeSBkaXNhYmxlZD8g
Ki8NCj4gPiArICAgICBpZiAoIWZlYXR1cmVzX2VuYWJsZWQoQ0VUX1NIU1RLKSkNCj4gPiArICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArICAgICBmcHJlZ3NfbG9ja19hbmRfbG9h
ZCgpOw0KPiA+ICsgICAgIC8qIERpc2FibGUgV1JTUyB0b28gd2hlbiBkaXNhYmxpbmcgc2hhZG93
IHN0YWNrICovDQoNCk9vcHMsIHRoaXMgY29tbWVudCBpcyBpbiB3cm9uZyBwYXRjaC4NCg0KPiA+
ICsgICAgIHNldF9jbHJfYml0c19tc3JsKE1TUl9JQTMyX1VfQ0VULCAwLCBDRVRfU0hTVEtfRU4p
Ow0KPiANCj4gQW5kIHRoaXMuLi4gYXJlbid0IHZlcnkgY29uc2lzdGVudCBpbiBhcHByb2FjaC4g
R2l2ZW4gdGhlcmUgaXMgbm8NCj4gVV9JQlQNCj4geWV0LCB3aHkgY29tcGxpY2F0ZSBtYXR0ZXJz
IGxpa2UgdGhpcz8NCg0KU3VyZSwgSSBjYW4gY2hhbmdlIGl0Lg0K
