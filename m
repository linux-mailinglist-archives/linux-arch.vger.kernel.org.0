Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B264AAC66
	for <lists+linux-arch@lfdr.de>; Sat,  5 Feb 2022 21:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379726AbiBEUPJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Feb 2022 15:15:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:17448 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377367AbiBEUPI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Feb 2022 15:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644092108; x=1675628108;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VzzXBb7rLhIYWqu7+oziQxZYygQJ5T3yjLCJABL4JjE=;
  b=KfJ4Kot5RljfTHVOsGJRrJ4gsF0v0Fa24MC19Qpp+Ld0q++Y9OIh06GH
   VD5WljFi6NGfm4VyWhU5uYxnN/11XIkbklc4IYQrXQPwui0KPg9FRUWzw
   fYZMaSS3BO+rjGTr6qBA8+0j0spDl1WA7i15i6ttLOwiNlsQV1qxuQ9QK
   ks+MUvTHDUA9XzddQn0eQlcTAvWJpA9zdA7kY6ZkmEDVLUYtWbPxEExIo
   WitKAx6JO8+wfhLK4Bm3AORmU0oTzLQV67VFwnWG64zvsac19NN4fIiJB
   5I12acp51/JHUhJyZMkuNc1dd8GQPS4S4VvwRZm/a/yUdeNxnusYghXM6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="248747229"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="248747229"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 12:15:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="539576772"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2022 12:15:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 5 Feb 2022 12:15:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 5 Feb 2022 12:15:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 5 Feb 2022 12:15:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGzuV+W/1EIE0AdM+3h5DfAVmYCZ1waOrOx+v01imIJKBBGwiCjbFnhYSA03e3EmFhzqqYniGqZAVJ8sfo/bCzBTVpbgYyLhP68PYpf8xVH2/PbqrgsjyfUPPVJG9Y5NRdT8+opyZ4gOX/l+hGf+/XbhsH4q7whSHV024JGb30nlt5xLbnn4XI5y7n9G2H6KeMoeskUuE13jyh5TDmago7GlfZpgs3Te3L+0MI2lHnh23J/Flwn2i+v+wVqQ8kEBVLvT3X9B7QiaG53qmlkdCblwxFF/yyI1C006icOMJ9/XBE6hV4AD9n2t3UaE9hBjsY+eCeS2qwW4Ju1qQv44fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzzXBb7rLhIYWqu7+oziQxZYygQJ5T3yjLCJABL4JjE=;
 b=HRJkZg/4HXmTZ8BdWAadY0Tu5GPlGreDG+3SVosGmGDQbRAGaEz2/A5xsuLuFOP8niPPnS658fvJN2QtXZzSeyZUZio2mrTKcq+nZlQfCbDOcDQ5XNBYlDekyiz/1Pu6R1yTb1eApT9tToD4FSsk1o5o9RbBzVbZtrpZ3Isvg5T2i6z03lUm+LptxOKG6ZUtOSkSC4U41Y+Gwt6k2044WWQV458bl4aeJO8d1rFEZVdpyl8mmGDeeR1fAeBkWwhT8pjENZ5jQa0c0nAJNrKOQ5vHlGNcEVdIVQ0zjbsWKAD4j8AFKC+R2tJS84oehPm+ZdImZ48mlfurFC1FNexHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB3630.namprd11.prod.outlook.com (2603:10b6:208:f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Sat, 5 Feb
 2022 20:15:03 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.016; Sat, 5 Feb 2022
 20:15:02 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyCV/wAgABDLwCAAl19kIAABAWAgABxL4A=
Date:   Sat, 5 Feb 2022 20:15:01 +0000
Message-ID: <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
References: <87fsozek0j.ffs@tglx>
         <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
         <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
         <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
In-Reply-To: <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17a8e779-94c8-4c44-e772-08d9e8e4310e
x-ms-traffictypediagnostic: MN2PR11MB3630:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB3630CABA8FD36AF27BB89720C92A9@MN2PR11MB3630.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bkDWdgAIhnyb8/Nuv2VXf+b45Bq6h5VmihrdJ3UeXBmew/A6Rb0Ix5NPSvPxhBoIIdj/mUvmPdOhJE3mK54ZGZxL4xOaRirkL7S5wvz/0XJPbjdf2jYhsc0x0GIS7XHas23jkXasOJKOd6cEWWX/wJs0aeAZzQU6+jhuhcz/V3H4Ib+/TLnf4gIZ47zaf3SdlqTvtjNnYhW6w21o7lVHxn7+pCvMb7Ye1+P+chMaKK24LPTr9lC6xCHTx7HOUdMpDnXqGYNs3IFQKac3VaKwo+4rwcVBorh6OGfIdHRilSSJcGpLL6BXLNj60Ju/IIjeVV1L+IqXrZDdq0n+kGkbKm6q4qGzMcZu3MlurlnAcz+IF4qv/W4Dgg6FEpnkJmhspRPzt82YtQLuVltSpPnEPZkCGipjvP4AUUVcSITmkF4kkEqF+F9pXmGfOF/f42V4uTSu/wQYAudw6ZhvSQNFY2t0W/pMjHxK+3Q9fzJ8DTVjMCSRYDFctmSKrvPmhlVNCFvgxR771NvHo2rlGmWQwfZaV1GzoOPQN+2HQHUVozSWTBU9EzRqfzXdJNtwnZ3EGX6sdpSTatpA9m4GBEB6J9cOXxXlE6YREWWGAVqYxF3bmThJ5sXsQKpxoFHJEep+UB8TW33i2dgfuvg5stiLKEvUiok/UUlMCYT+0yBu5IJ2PDzKlcKfIXVWbY4mrBS6h47kWZ/5KnJYbzRMugke3ZIdLc9bN+KqUk9rAuc0edU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(66446008)(8676002)(64756008)(8936002)(4326008)(76116006)(86362001)(6486002)(53546011)(71200400001)(508600001)(316002)(6512007)(6506007)(38070700005)(110136005)(54906003)(38100700002)(36756003)(7406005)(2906002)(2616005)(5660300002)(7416002)(186003)(26005)(83380400001)(122000001)(82960400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0hLQ1RNVWJGakNGYlhSQlNpaWpiWlByVVVLM1FZeDUvMEh2UmJCd1hqbnl6?=
 =?utf-8?B?dVlyRDhDaVV2Q1QvbG1pbTg1TlZ2YTA3ZGxwRUU2M3crYjU0aHJyam0waFBP?=
 =?utf-8?B?Q0dtMnFXalM1aWhWYUtGVzhDSXVXZ0JjMVEyWDFRUWJKek9ueTIrVE1NTStC?=
 =?utf-8?B?QjkwNVp1MFZQWnlmNWtWKzNLRlFBRUlUM1I0ZWFSNnJKNTMrTDJ0NEEyc0E5?=
 =?utf-8?B?dWhmU00raHhpNGdUMkp6dXU2bm9BU1dvemIrZEJHdnc3R0R1VlVFT3RyU2t0?=
 =?utf-8?B?Wnc5QWFGakkzdnVPQTV5aDE2K3FCRElENFZHZ1htUS9RQmh0blpVYm1XUmNt?=
 =?utf-8?B?Nno1YW1GV1NHcnk1eG1WNnhXbktHanhJRDNzS1E0Zk1WWmZpMnJTcXBsSVZk?=
 =?utf-8?B?Q1dnUU5rRlU4UW1LMzQ3STRYR20wa0hOSEluU1h1UlVmbWZTR1F2UU4zL2tM?=
 =?utf-8?B?d1F4VHJUSWZrdzRScDBiUTJySytJcEk3Nk9JYmZWdGxxeU9vN05RdjhTWHFG?=
 =?utf-8?B?eXZYQ2tabEdjcEVFZTlOQ0dKeG9DS2xHd3FYaGpscnFibWVLb0VVQ1VkUzkx?=
 =?utf-8?B?QTR1bkRiaU11cGZNTkI1MXJHZWRJRDFCT0w2dmtTMHl4YlR6N0Y5a2Y4RXpJ?=
 =?utf-8?B?KzJKVHZjRUxSRVhIQWY1aGFJTU83SjNkdTI0SlNrK2NHWlVqNXg0bzRhWGsr?=
 =?utf-8?B?S2UzeWRXeGxzT0xnU21WNFErWEJobjF0b0c0Z096a1V0bFJQelk2ekY0RjJO?=
 =?utf-8?B?QTlISUpFeHlpZG9BckZCenFmTkI0N0h3QjN0YXRGcUVMTUVlaEIzUmRZUTNx?=
 =?utf-8?B?U0FDNWRsRVpjdHEvbzFFZDFDKzRQbUlIdmFiWVVYandZYjhlRlV5aGxwWGtx?=
 =?utf-8?B?NmRHSFByMW1ZVC8zVzJSdTFpWmdUb1F2MnE5OGd1QUZKb3JsdnhVaUk0NmVr?=
 =?utf-8?B?V2R6VlNOclFoaFJSaHZCT1o5U2NSY3F3VU9GbVV6VGZXVTlhbjNOVDQ3VC9J?=
 =?utf-8?B?TEpoeE52d0x3ajFyUWExVjVBMml5N1lvUkdGd0xWeHhLclIwTnF1dHBDRy9J?=
 =?utf-8?B?eU5MdElnQmxnRDhyeTgxMnJoaHJzdFlhR21sNkNUMUhZVSs0ckJPSmdKdFdE?=
 =?utf-8?B?VWdINkI5WEtVamdHRVo2eHptc3BpODUwcHdLZkVaM3hXZ0hTQ0lUd1VMK2dQ?=
 =?utf-8?B?UzNVL3hvNDcwRGtLcWNKY2lWeVRCbHV6ZWlGZGxIRXJjZ0ZjRHlmTGxkV1dI?=
 =?utf-8?B?MHlBRDlMbGFtVFVOejNXbEZybnVBTGFMbXhaeE9vWTR0blJudkRZVlZmUW5v?=
 =?utf-8?B?YlFIL0wwbzNDUml6QitXY29uRS9PRXdSYmtJMjd6ZHVMS3FRTENwK3Vmayto?=
 =?utf-8?B?dk0wd3lTNnI0RXg2SERrU2wxV3lzNmtvcmRZbHhaNGtTdmtZU1lNUXpIWnNN?=
 =?utf-8?B?ZUwvczU3Q0FNU2E4MEZnU1JsYmFrQ2Nrd1BZMFNTZEc0U2tWT2l1cEpFamJ0?=
 =?utf-8?B?aVl0cGtMT1kvSGxRM2ZESUFkWSt0TEZaY0R5WUtxZkNES3JFUHMwckFqNWVo?=
 =?utf-8?B?RmZhRlUwU20rVFNPQkxWdXNITVVEYVJ4VDRGc28xRU1hZUd3S3pXMk03THRO?=
 =?utf-8?B?d2tsL3NHV3JmTklKaWxvbjRZSWprTWxEWWtSV0JjNy9mS2JPN0grV0RTZjEy?=
 =?utf-8?B?dFlWa1dZcXg4RmFabXJra2FDcmNrdjYrQm1tS2I0NkdnS0FwNE1LOWZiUXB3?=
 =?utf-8?B?WTlCUEIxWWlieXVySWRIMlJHMzUxOERTWC9Kb0tyWFVNUXRZQXFCdlFDMmQy?=
 =?utf-8?B?aUVZV1IvU0pmMlBBdDlGbmtRa29TY01SOURENkZNcWFpOCtNYmVCd1VNcnpk?=
 =?utf-8?B?QVI1VFhVZzQ2SkxNSE1hQ0x5VTZoV2FlOUJ3THA2UVorOTRyNDRCckowZnRS?=
 =?utf-8?B?R3RGbmdGNjljSkM2ZlVhdU1wam5UNUpoRlllek8vSFl3TXNuUHpGV2MzaHhV?=
 =?utf-8?B?Zi8xTmJRcUcxbUUvdHNXOTJVK0txdk9VUk5PMTR6TzMwYlNTM2dncFMzbzl0?=
 =?utf-8?B?dTc5bTBQUmJuZG9uWGsrSFpDN1UzZU1mckVVd1FZcklBSi9iemRVTVRmT1NZ?=
 =?utf-8?B?NE9MZjhzQ2tzWDZBcHNTZHYycFVTdkRuSG85YTJ4V0h3a2J4V3hNcnZFVWxL?=
 =?utf-8?B?bWRDNEk1SjMzTEVNQzZCcVZxZG5yRmlTdkNnTjJRWnpzd0hzTmpwRVM4VGF2?=
 =?utf-8?Q?uMmtR68oAzsjrzD0zVf5YqHrjuqt3hRsw45ZeQ6hHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <423645266FB89A4A83EF764AD8C3CE0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a8e779-94c8-4c44-e772-08d9e8e4310e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2022 20:15:01.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psTgHoW8p5kgJ2I1qxg2kPWOdK5SQ2DPQkwFJHfYK26YdoPOkYEFYqBPNyO0MTGFfo50xBJbOqP9IbbJpDVG6xGITgpLNjE5mKinTU9Z9DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3630
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIyLTAyLTA1IGF0IDA1OjI5IC0wODAwLCBILkouIEx1IHdyb3RlOg0KPiBPbiBT
YXQsIEZlYiA1LCAyMDIyIGF0IDU6MjcgQU0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRAYWN1
bGFiLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogRWRnZWNvbWJlLCBSaWNrIFANCj4g
PiA+IFNlbnQ6IDA0IEZlYnJ1YXJ5IDIwMjIgMDE6MDgNCj4gPiA+IEhpIFRob21hcywNCj4gPiA+
IA0KPiA+ID4gVGhhbmtzIGZvciBmZWVkYmFjayBvbiB0aGUgcGxhbi4NCj4gPiA+IA0KPiA+ID4g
T24gVGh1LCAyMDIyLTAyLTAzIGF0IDIyOjA3ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+ID4gPiA+ID4gVW50aWwgbm93LCB0aGUgZW5hYmxpbmcgZWZmb3J0IHdhcyB0cnlpbmcgdG8g
c3VwcG9ydCBib3RoDQo+ID4gPiA+ID4gU2hhZG93DQo+ID4gPiA+ID4gU3RhY2sgYW5kIElCVC4N
Cj4gPiA+ID4gPiBUaGlzIGhpc3Rvcnkgd2lsbCBmb2N1cyBvbiBhIGZldyBhcmVhcyBvZiB0aGUg
c2hhZG93IHN0YWNrDQo+ID4gPiA+ID4gZGV2ZWxvcG1lbnQgaGlzdG9yeQ0KPiA+ID4gPiA+IHRo
YXQgSSB0aG91Z2h0IHN0b29kIG91dC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgICAgICAgU2ln
bmFscw0KPiA+ID4gPiA+ICAgICAgICAtLS0tLS0tDQo+ID4gPiA+ID4gICAgICAgIE9yaWdpbmFs
bHkgc2lnbmFscyBwbGFjZWQgdGhlIGxvY2F0aW9uIG9mIHRoZSBzaGFkb3cNCj4gPiA+ID4gPiBz
dGFjaw0KPiA+ID4gPiA+IHJlc3RvcmUNCj4gPiA+ID4gPiAgICAgICAgdG9rZW4gaW5zaWRlIHRo
ZSBzYXZlZCBzdGF0ZSBvbiB0aGUgc3RhY2suIFRoaXMgd2FzDQo+ID4gPiA+ID4gcHJvYmxlbWF0
aWMgZnJvbSBhDQo+ID4gPiA+ID4gICAgICAgIHBhc3QgQUJJIHByb21pc2VzIHBlcnNwZWN0aXZl
LiBTbyB0aGUgcmVzdG9yZSBsb2NhdGlvbg0KPiA+ID4gPiA+IHdhcw0KPiA+ID4gPiA+IGluc3Rl
YWQganVzdA0KPiA+ID4gPiA+ICAgICAgICBhc3N1bWVkIGZyb20gdGhlIHNoYWRvdyBzdGFjayBw
b2ludGVyLiBUaGlzIHdvcmtzDQo+ID4gPiA+ID4gYmVjYXVzZSBpbg0KPiA+ID4gPiA+IG5vcm1h
bA0KPiA+ID4gPiA+ICAgICAgICBhbGxvd2VkIGNhc2VzIG9mIGNhbGxpbmcgc2lncmV0dXJuLCB0
aGUgc2hhZG93IHN0YWNrDQo+ID4gPiA+ID4gcG9pbnRlcg0KPiA+ID4gPiA+IHNob3VsZCBiZQ0K
PiA+ID4gPiA+ICAgICAgICByaWdodCBhdCB0aGUgcmVzdG9yZSB0b2tlbiBhdCB0aGF0IHRpbWUu
IFRoZXJlIGlzIG5vDQo+ID4gPiA+ID4gYWx0ZXJuYXRlIHNoYWRvdw0KPiA+ID4gPiA+ICAgICAg
ICBzdGFjayBzdXBwb3J0LiBJZiBhbiBhbHQgc2hhZG93IHN0YWNrIGlzIGFkZGVkIGxhdGVyDQo+
ID4gPiA+ID4gd2UNCj4gPiA+ID4gPiB3b3VsZA0KPiA+ID4gPiA+ICAgICAgICBuZWVkIHRvDQo+
ID4gPiA+IA0KPiA+ID4gPiBTbyBob3cgaXMgdGhhdCBnb2luZyB0byB3b3JrPyBhbHRzdGFjayBp
cyBub3QgYW4gZXNvdGVyaWMNCj4gPiA+ID4gY29ybmVyDQo+ID4gPiA+IGNhc2UuDQo+ID4gPiAN
Cj4gPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgbWFpbiB1c2FnZXMgZm9yIHRoZSBz
aWduYWwgc3RhY2sNCj4gPiA+IHdlcmUNCj4gPiA+IGhhbmRsaW5nIHN0YWNrIG92ZXJmbG93cyBh
bmQgY29ycnVwdGlvbi4gU2luY2UgdGhlIHNoYWRvdyBzdGFjaw0KPiA+ID4gb25seQ0KPiA+ID4g
Y29udGFpbnMgcmV0dXJuIGFkZHJlc3NlcyByYXRoZXIgdGhhbiBsYXJnZSBzdGFjayBhbGxvY2F0
aW9ucywNCj4gPiA+IGFuZCBpcw0KPiA+ID4gbm90IGdlbmVyYWxseSB3cml0YWJsZSBvciBwaXZv
dGFibGUsIEkgdGhvdWdodCB0aGVyZSB3YXMgYSBnb29kDQo+ID4gPiBwb3NzaWJpbGl0eSBhbiBh
bHQgc2hhZG93IHN0YWNrIHdvdWxkIG5vdCBlbmQgdXAgYmVpbmcgZXNwZWNpYWxseQ0KPiA+ID4g
dXNlZnVsLiBEb2VzIGl0IHNlZW0gbGlrZSByZWFzb25hYmxlIGd1ZXNzd29yaz8NCj4gPiANCj4g
PiBUaGUgb3RoZXIgJ3Byb2JsZW0nIGlzIHRoYXQgaXQgaXMgdmFsaWQgdG8gbG9uZ2p1bXAgb3V0
IG9mIGEgc2lnbmFsDQo+ID4gaGFuZGxlci4NCj4gPiBUaGVzZSBkYXlzIHlvdSBoYXZlIHRvIHVz
ZSBzaWdsb25nam1wKCkgbm90IGxvbmdqbXAoKSBidXQgaXQgaXMNCj4gPiBzdGlsbCB1c2VkLg0K
PiA+IA0KPiA+IEl0IGlzIHByb2JhYmx5IGFsc28gdmFsaWQgdG8gdXNlIHNpZ2xvbmdqbXAoKSB0
byBqdW1wIGZyb20gYSBuZXN0ZWQNCj4gPiBzaWduYWwgaGFuZGxlciBpbnRvIHRoZSBvdXRlciBo
YW5kbGVyLg0KPiA+IEdpdmVuIGJvdGggc2lnbmFsIGhhbmRsZXJzIGNhbiBoYXZlIHRoZWlyIG93
biBzdGFjaywgdGhlcmUgY2FuIGJlDQo+ID4gdGhyZWUNCj4gPiBzdGFja3MgaW52b2x2ZWQuDQoN
ClNvIHRoZSBzY2VuYXJpbyBpcz8NCg0KMS4gSGFuZGxlIHNpZ25hbCAxDQoyLiBzaWdzZXRqbXAo
KQ0KMy4gc2lnbmFsc3RhY2soKQ0KNC4gSGFuZGxlIHNpZ25hbCAyIG9uIGFsdCBzdGFjaw0KNS4g
c2lnbG9uZ2ptcCgpDQoNCkknbGwgY2hlY2sgdGhhdCBpdCBpcyBjb3ZlcmVkIGJ5IHRoZSB0ZXN0
cywgYnV0IEkgdGhpbmsgaXQgc2hvdWxkIHdvcmsNCmluIHRoaXMgc2VyaWVzIHRoYXQgaGFzIG5v
IGFsdCBzaGFkb3cgc3RhY2suIEkgaGF2ZSBvbmx5IGRvbmUgYSBoaWdoDQpsZXZlbCBvdmVydmll
dyBvZiBob3cgdGhlIHNoYWRvdyBzdGFjayBzdHVmZiwgdGhhdCBkb2Vzbid0IGludm9sdmUgdGhl
DQprZXJuZWwsIHdvcmtzIGluIGdsaWJjLiBTb3VuZHMgbGlrZSBJJ2xsIG5lZWQgdG8gZG8gYSBk
ZWVwZXIgZGl2ZS4NCg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhlIHNoYWRvdyBzdGFjayBwb2ludGVy
IGhhcyB0byBiZSBpbiB1Y29udGV4dCAtIHdoaWNoIGFsc28NCj4gPiBtZWFucyB0aGUgYXBwbGlj
YXRpb24gY2FuIGNoYW5nZSBpdCBiZWZvcmUgcmV0dXJuaW5nIGZyb20gYSBzaWduYWwuDQoNClll
cyB3ZSBtaWdodCBuZWVkIHRvIGNoYW5nZSBpdCB0byBzdXBwb3J0IGFsdCBzaGFkb3cgc3RhY2tz
LiBDYW4geW91DQplbGFib3JhdGUgd2h5IHlvdSB0aGluayBpdCBoYXMgdG8gYmUgaW4gdWNvbnRl
eHQ/IEkgd2FzIHRoaW5raW5nIG9mDQpsb29raW5nIGF0IHRocmVlIG9wdGlvbnMgZm9yIHN0b3Jp
bmcgdGhlIHNzcDoNCiAtIFN0b3JlZCBpbiB0aGUgc2hhZG93IHN0YWNrIGxpa2UgYSB0b2tlbiB1
c2luZyBXUlVTUyBmcm9tIHRoZSBrZXJuZWwuDQogLSBTdG9yZWQgb24gdGhlIGtlcm5lbCBzaWRl
IHVzaW5nIGEgaGFzaG1hcCB0aGF0IG1hcHMgdWNvbnRleHQgb3INCiAgIHNpZ2ZyYW1lIHVzZXJz
cGFjZSBhZGRyZXNzIHRvIHNzcCAodGhpcyBpcyBvZiBjb3Vyc2Ugc2ltaWxhciB0byANCiAgIHN0
b3JpbmcgaW4gdWNvbnRleHQsIGV4Y2VwdCB0aGF0IHRoZSB1c2VyIGNhbuKAmXQgY2hhbmdlIHRo
ZSBzc3ApLg0KIC0gU3RvcmVkIHdyaXRhYmxlIGluIHVzZXJzcGFjZSBpbiB1Y29udGV4dC4NCg0K
QnV0IGluIHRoaXMgdmVyc2lvbiwgd2l0aG91dCBhbHQgc2hhZG93IHN0YWNrcywgdGhlIHNoYWRv
dyBzdGFjaw0KcG9pbnRlciBpcyBub3Qgc3RvcmVkIGluIHVjb250ZXh0LiBUaGlzIGNhdXNlcyB0
aGUgbGltaXRhdGlvbiB0aGF0DQp1c2Vyc3BhY2UgY2FuIG9ubHkgY2FsbCBzaWdyZXR1cm4gd2hl
biBpdCBoYXMgcmV0dXJuZWQgYmFjayB0byBhIHBvaW50DQp3aGVyZSB0aGVyZSBpcyBhIHJlc3Rv
cmUgdG9rZW4gb24gdGhlIHNoYWRvdyBzdGFjayAod2hpY2ggd2FzIHBsYWNlZA0KdGhlcmUgYnkg
dGhlIGtlcm5lbCkuIFRoaXMgZG9lc27igJl0IG1lYW4gaXQgY2Fu4oCZdCBzd2l0Y2ggdG8gYSBk
aWZmZXJlbnQNCnNoYWRvdyBzdGFjayBvciBoYW5kbGUgYSBuZXN0ZWQgc2lnbmFsLCBidXQgaXQg
bGltaXRzIHRoZSBwb3NzaWJpbGl0eQ0KZm9yIGNhbGxpbmcgc2lncmV0dXJuIHdpdGggYSB0b3Rh
bGx5IGRpZmZlcmVudCBzaWdmcmFtZSAobGlrZSBDUklVIGFuZA0KU1JPUCBhdHRhY2tzIGRvKS4g
SXQgc2hvdWxkIGhvcGVmdWxseSBiZSBhIGhlbHBmdWwsIHByb3RlY3RpdmUNCmxpbWl0YXRpb24g
Zm9yIG1vc3QgYXBwcyBhbmQgSSdtIGhvcGluZyBDUklVIGNhbiBiZSBmaXhlZCB3aXRob3V0DQpy
ZW1vdmluZyBpdC4NCg0KSSBhbSBub3QgYXdhcmUgb2Ygb3RoZXIgbGltaXRhdGlvbnMgdG8gc2ln
bmFscyAoYmVzaWRlcyBub3JtYWwgc2hhZG93DQpzdGFjayBlbmZvcmNlbWVudCksIGJ1dCBJIGNv
dWxkIGJlIG1pc3NpbmcgaXQuIEFuZCBwZW9wbGUncyBza2VwdGljaXNtDQppcyBtYWtpbmcgbWUg
d2FudCB0byBnbyBiYWNrIG92ZXIgaXQgd2l0aCBtb3JlIHNjcnV0aW55Lg0KDQo+ID4gSW4gbXVj
aCB0aGUgc2FtZSB3YXkgYXMgYWxsIHRoZSBzZWdtZW50IHJlZ2lzdGVycyBjYW4gYmUgY2hhbmdl
ZA0KPiA+IGxlYWRpbmcgdG8gYWxsIHRoZSBuYXN0eSBidWdzIHdoZW4gdGhlIGZpbmFsICdyZXR1
cm4gdG8gdXNlcicgY29kZQ0KPiA+IHRyYXBzIGluIGtlcm5lbCB3aGVuIGxvYWRpbmcgaW52YWxp
ZCBzZWdtZW50IHJlZ2lzdGVycyBvciBleGVjdXRpbmcNCj4gPiBpcmV0Lg0KDQpJIGRvbid0IHRo
aW5rIHRoaXMgaXMgYXMgZGlmZmljdWx0IHRvIGF2b2lkIGJlY2F1c2UgdXNlcnNwYWNlIHNzcCBo
YXMNCml0cyBvd24gcmVnaXN0ZXIgdGhhdCBzaG91bGQgbm90IGJlIGFjY2Vzc2VkIGF0IHRoYXQg
cG9pbnQsIGJ1dCBJIGhhdmUNCm5vdCBnaXZlbiB0aGlzIGFzcGVjdCBlbm91Z2ggYW5hbHlzaXMu
IFRoYW5rcyBmb3IgYnJpbmdpbmcgaXQgdXAuDQoNCj4gPiANCj4gPiBIbW1tLi4uIGRvIHNoYWRv
dyBzdGFja3MgbWVhbiB0aGF0IGxvbmdqbXAoKSBoYXMgdG8gYmUgYSBzeXN0ZW0NCj4gPiBjYWxs
Pw0KPiANCj4gTm8uICBzZXRqbXAvbG9uZ2ptcCBzYXZlIGFuZCByZXN0b3JlIHNoYWRvdyBzdGFj
ayBwb2ludGVyLg0KPiANCg0KSXQgc291bmRzIGxpa2UgaXQgd291bGQgaGVscCB0byB3cml0ZSB1
cCBpbiBhIGxvdCBtb3JlIGRldGFpbCBleGFjdGx5DQpob3cgYWxsIHRoZSBzaWduYWwgYW5kIHNw
ZWNpYWxlciBzdGFjayBtYW5pcHVsYXRpb24gc2NlbmFyaW9zIHdvcmsgaW4NCmdsaWJjLg0KDQo=
