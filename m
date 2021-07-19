Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E43CED74
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 22:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbhGSSeX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 14:34:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:51788 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350537AbhGSRlH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 13:41:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211167238"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="211167238"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 11:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="656995975"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jul 2021 11:21:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 11:21:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 19 Jul 2021 11:21:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 19 Jul 2021 11:21:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 19 Jul 2021 11:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBobFXljWtyefqRVYAunBMrN5CnxQC5pOyNptL9mJQm6MwmebiSGR6U0ueGxWgv10yyYY2q+p7PPzdasGgH1DLSCcpTpEMIIyPsWjwp3uoqKtlK5Ns5GbjhQazG3lcRHO8QP0tBUUmOziEaE4FezcyzLbhK9F8aD26z+eTVhdnb7Z0L61zZ0rF9sjHk2fCAHLAEYGjRgwywXSnXYDWdZ2tlcE0pRkLyNADz6se0ATOBagmS2WVwPLQBE0OFtWFoG3ajEmBDmlC1S5Td2r3wu0NlXXRomXS0DTvqbcLe7WQXuLX0nNtgP5Ef1E52wl36F3aCs46gc4D3TqaEcOHPqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tBpEzYvMVKwlBfy+oO+Dm5USg+rKoezHiZK0sP6CUE=;
 b=SZPMH8SKuTIGViimZ0Rwr7QNMOBFZqCklp5kEtJGOpcveM1dSxGXmfxALPMFQPSpyNqH6pRMMJtlywJyKzy3w/8srOSpZLLrPTu09nt3GqKgXsIvqW593NTeAdTVM/UDqY+7ya+Jz5ydeP/1sEYn18TEBACwrWGfnapDuGUtuQuUWiWaPvMJB906/G49ySi8XBxysGmdLyVBMBSADxeC3OSMvXfTBGisn59xc7KseDieM4ZJ4rkhrVcAA5vZSrJKhlQqeSx7p42OlYssBYACG5DROmqro0NvhBA2k5gJlp1yDO/H9GTlC2PM9aqe+s8yzxu1yPVQsbJnA2gCsogxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tBpEzYvMVKwlBfy+oO+Dm5USg+rKoezHiZK0sP6CUE=;
 b=bJeqgqe1SN8fs8usnWcYo27sHqzx9M4bPEj/rHjFRFLcTp+vRye0LMRaSv5pTKXesFiOzu8sbNUxX4O+7Y78bf3ie+qj+7w3sbKKYIslIAcdgEoK/v9PALJM5y+e0BCJv63jOxzjvI/5mAC005Z+w3fmDPrCTb8NY4iJdP1NwfU=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB5068.namprd11.prod.outlook.com (2603:10b6:806:116::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 18:21:34 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::4046:c957:f6a9:27db]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::4046:c957:f6a9:27db%5]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 18:21:34 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "vedvyas.shanbhogue@intel.com" <vedvyas.shanbhogue@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "esyr@redhat.com" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v27 06/10] x86/cet/ibt: Update arch_prctl functions for
 Indirect Branch Tracking
Thread-Topic: [PATCH v27 06/10] x86/cet/ibt: Update arch_prctl functions for
 Indirect Branch Tracking
Thread-Index: AQHXfLzqqlbuDRHG5ECh81TtFyLv96tKnFOA
Date:   Mon, 19 Jul 2021 18:21:34 +0000
Message-ID: <31008f559a7263d2a4042f9c061efcd4e86b5a69.camel@intel.com>
References: <20210521221531.30168-1-yu-cheng.yu@intel.com>
         <20210521221531.30168-7-yu-cheng.yu@intel.com>
In-Reply-To: <20210521221531.30168-7-yu-cheng.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3162ab92-4dad-432e-1bb6-08d94ae20a2e
x-ms-traffictypediagnostic: SA2PR11MB5068:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5068E6691C493D121DC7D40CC9E19@SA2PR11MB5068.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qjrcS/DIm9d5HY0rWoBjMBYBFTDU0gkwZiEbLzwrPHaSeFZh0J4HexvWTSDO+jdS44uSPBCVlvm7fQAda4t7qoGZzd1IsoiOMLp78pql5sNVD64+B8MIBtjA8aTe+zJf4Al5nPR0OS2IUZCFDs6c/a0gJSzAfrqDoaoEjL1ZEn1NclaJG2T+WJUr/TKaKvP8qtjtu769iho9j++YkvJYD6h5LstfoS+jvsJOIr3jYEROzX59lOnxebmNC6QdtqV5yM0bKhshHo05kLrnPfzzl78jbDawK9rwGaV7XRAxq9QFF9YQ0jPEbzCUMSZ4lQz2/HnY7g8BsXunkUGv6dcWo2sEMsDqAsM2NptkcQ86h04kk/JApOrxUCgxTTHX5R1rFfAUamT87ud+F2bF7t5UF4awqn4Q1pBxo+z7D4GlrXDpKSy4TCak1SyQ/nS91dfnt17BVk+K5BKTQx+5d1/zSaEUBPVr+V/m4C5fuBlNTdDxTffpz1hVDqi0gWpMXHIyQSVHqCbLHV4JGp2E7q/w1bdC+I4svDxkZGlOBwTDgYA+8GuZyimwarYJ7qSJmzMU63PDXU0ekWL39lQc7kMeorzLYyYBmJ9EG8mQvaWnRpT6S0LmzS37X03rF2EEjFTul0RBT87lEruL52rfMiTJ49N/XFuA8I1WWoBjxfV8GQJnvgpDA8mOP/98JfRfdngPuCyMK7HfV3Y2jbLzswzcLGvRnoMeP1ZRlxwW49n9LU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(83380400001)(76116006)(2906002)(8936002)(7416002)(122000001)(921005)(66446008)(110136005)(6506007)(64756008)(66556008)(26005)(316002)(8676002)(478600001)(186003)(91956017)(6486002)(6512007)(86362001)(5660300002)(38100700002)(15650500001)(71200400001)(66946007)(2616005)(66476007)(36756003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blNpa0cyYlk0Q2RZS3hSQXpsNXdLQUNjVEwrZDhqaExKYTdnVHhhZUNPS2dW?=
 =?utf-8?B?ZlJJUldxbGlFdUpxd044Q08wQzV5RStOeHlpZjZEWnVNbXpRNkNIb0ltcXo2?=
 =?utf-8?B?aEcyc3k1STQyQmw5SDRCNForT09mR1Faa0JQUTV4eGRmK1ZNejJ0QkJVdnEz?=
 =?utf-8?B?WG14Y1lDMnl0cXJmeENrK2Zaa2VadFBTeGlVYVkrMWd2V1NRcHpGWDEwU2Q4?=
 =?utf-8?B?MnZHR0tYZUlyZkxWSkZyNzdLNjBkTExDK1VUSTN1eElqVkdWbGdlL29mS0Ix?=
 =?utf-8?B?QnpQZjJDeWhvN1pHVVVkWDRtVDR6YzkxZFNwT1M1L2llVGJEa2MrcnpDSGM2?=
 =?utf-8?B?bmhQdGVlVXllS3RsQ3VwOE5wbWNoeDV6UGYrQjF3VTNDV0k3WGJPSmdJNm1u?=
 =?utf-8?B?cHEwQVVtMUl2eTI4R2RwMk1nSEpXZ0ttazlRbmJYSVNhblNHcmpCbVFwbHBx?=
 =?utf-8?B?YytnbEJuZVpGOVVGR3NWWEZhYjZCN2luSks3MXd6ZDJtT2JmQXd4d3hiSE9Y?=
 =?utf-8?B?Mks0QlZWdVVmVWNvUHI2K291QkNKcHJJTWtqamFYRGNMck1qZVRSUk51UCtr?=
 =?utf-8?B?b2kzZmR1ZnNiVGpxMHpUMGlFaFdhczY2dXJkeWRna0xndUtxaXpxdmlwR2U2?=
 =?utf-8?B?YmJtYXZyVis0TXhmVWo5aUcwTW4yV3RodisvMlUvMlArUXIrWGVMS1QwbkFG?=
 =?utf-8?B?V0lNT2p6Z3B2WFdhUVhqcE4ybVNQOVpyV0JYcWZraFltWXhxYWhGN21OOTlU?=
 =?utf-8?B?L1NoVTQzWUg0QWNUVFJGZkFoZmkwMW9LclY0b2NFV0xiZ3JzeDFDVitLUysw?=
 =?utf-8?B?SUJvdWlJVmtuaGNNNkFpT083ZCt4d0Voc0JFTHpVcVhWQnA4OWtxdTlDdFU4?=
 =?utf-8?B?Uk1BRTZnZGRiVU5OYlhjV1FKdjZ1dWRxK1BnYzdTYmlaMElNMWd2OG5zaUh3?=
 =?utf-8?B?aDVNRzRsOFV6QlZnaDFTWko1R05SMm5DbWh3UjY3MUJyanVXdEdqUTErdVYz?=
 =?utf-8?B?RWlUYjJyZXQ2RXp2Zm1KejJvTFRoa00vRDhEOXdmK3J0VlVqQlJCTlJ2a0pk?=
 =?utf-8?B?REE0MitIR2pYQ3lHekIyRDBRaHJzRUhkQU9BajdrK2xvWHBDcnBkV1BzcEo4?=
 =?utf-8?B?U3oxWHo2MGJNMnVpTGFxb0ZrM3FqKzhaRmtKWGZROVQybTNoSTdzV1BIcURQ?=
 =?utf-8?B?ZjBzRjJFczAvU0k0L0cycFdmZXhJaG05Y09xWnNUdlJ1ZVJwRktxK0lCTzhZ?=
 =?utf-8?B?dzVlb3J0ZVlwYUwzTzZvUWlRaVY2T3F3MWZUd2x2b0ttWnd2a0FvUTRSQ0ZT?=
 =?utf-8?B?VU5nYWk1YlRVcUJOODN4alhGcDRwb3RnMTVKVmFjUGQ1eW9YR1ZIN1A1YXkv?=
 =?utf-8?B?UXZkQ3p6UlBqVVI5Sld2cFpJRGJBeWtiOVZMN2FCTUNPWEFBVlpnUzl0V1NU?=
 =?utf-8?B?SGhhdUtURWNCdUJ0eS9YVkpod1h5N0ZHdUJJem94ZnlCWXFiU1FCejJCTGRX?=
 =?utf-8?B?b0tJYUx0SVhHNW1PYnpONXhPNWxWcEpxQ2lpRkxtMDRhWjNJWEt4ODdZTHhV?=
 =?utf-8?B?Z0hxa1pmZnZ5MC9iM3liMTM5dndmcjB1UmtwdDJlcGRuNkpHS1NmUUlWZGdI?=
 =?utf-8?B?WDYwelI4Q1YySTVGOGYvczN5b3M2dFNOd3hzdXFoRm4zSGxiSnhQUTFGTjdw?=
 =?utf-8?B?Ymlkb1pxSGdSazhkQUZ2akVjblAxUG1BanIvSHVTa1hvSjZBYk45REtucTJp?=
 =?utf-8?Q?nV1AixumbF3wZrIeulfV4zohHTjZZpI3T3x6LYk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE2AC082E2BA4E4487A35D78075D303D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3162ab92-4dad-432e-1bb6-08d94ae20a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2021 18:21:34.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPzeWfE6POa5xs1QQuhCyrQ/pNc+ab2ogBu656GGn9KWrGckQ5txj2IWSNU2kBThYOYWwRgfl+EAitnDDRyKsO/mTZlJi+cVwF3Nfwh9zyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5068
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTIxIGF0IDE1OjE1IC0wNzAwLCBZdS1jaGVuZyBZdSB3cm90ZToNCj4g
RnJvbTogIkguSi4gTHUiIDxoamwudG9vbHNAZ21haWwuY29tPg0KPiANCj4gVXBkYXRlIEFSQ0hf
WDg2X0NFVF9TVEFUVVMgYW5kIEFSQ0hfWDg2X0NFVF9ESVNBQkxFIGZvciBJbmRpcmVjdA0KPiBC
cmFuY2gNCj4gVHJhY2tpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBILkouIEx1IDxoamwudG9v
bHNAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZdS1jaGVuZyBZdSA8eXUtY2hlbmcueXVA
aW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5v
cmc+DQo+IC0tLQ0KPiDCoGFyY2gveDg2L2tlcm5lbC9jZXRfcHJjdGwuYyB8IDUgKysrKysNCj4g
wqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYva2VybmVsL2NldF9wcmN0bC5jDQo+IGIvYXJjaC94ODYva2VybmVsL2NldF9wcmN0bC5j
DQo+IGluZGV4IGI0MjZkMjAwZTA3MC4uYmQzYzgwZDQwMmU3IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L3g4Ni9rZXJuZWwvY2V0X3ByY3RsLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NldF9wcmN0
bC5jDQo+IEBAIC0yMiw2ICsyMiw5IEBAIHN0YXRpYyBpbnQgY2V0X2NvcHlfc3RhdHVzX3RvX3Vz
ZXIoc3RydWN0DQo+IHRocmVhZF9zaHN0ayAqc2hzdGssIHU2NCBfX3VzZXIgKnVidWYpDQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVmWzJdID0gc2hzdGstPnNpemU7DQo+IMKg
wqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+ICvCoMKgwqDCoMKgwqDCoGlmIChzaHN0ay0+aWJ0KQ0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnVmWzBdIHw9IEdOVV9QUk9QRVJUWV9Y
ODZfRkVBVFVSRV8xX0lCVDsNCj4gKw0KQ2FuIHlvdSBoYXZlIElCVCBlbmFibGVkIGJ1dCBub3Qg
c2hhZG93IHN0YWNrIHZpYSBrZXJuZWwgcGFyYW1ldGVycz8NCk91dHNpZGUgdGhpcyBkaWZmIGl0
IGhhczoNCmlmICghY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9TSFNUSykpDQoJcmV0
dXJuIC1FTk9UU1VQUDsNCg0KU28gaWYgIm5vX3VzZXJfc2hzdGsiIGlzIHNldCwgdGhpcyBjYW4n
dCBiZSB1c2VkIGZvciBJQlQuIEJ1dCB0aGUNCmtlcm5lbCB3b3VsZCBhdHRlbXB0IHRvIGVuYWJs
ZSBJQlQuDQoNCkFsc28gaWYgc28sIHRoZSBDUjQgYml0IGVuYWJsaW5nIGxvZ2ljIG5lZWRzIGFk
anVzdGluZyBpbiB0aGlzIElCVA0Kc2VyaWVzLiBJZiBub3QsIHdlIHNob3VsZCBwcm9iYWJseSBt
ZW50aW9uIHRoaXMgaW4gdGhlIGRvY3MgYW5kIGVuZm9yY2UNCml0LiBJdCB3b3VsZCB0aGVuIGZv
bGxvdyB0aGUgbG9naWMgaW4gS2NvbmZpZywgc28gbWF5YmUgdGhlIHNpbXBsZXN0Lg0KTGlrZSBt
YXliZSBpbnN0ZWFkIG9mIG5vX3VzZXJfc2hzdGssIGp1c3Qgbm9fdXNlcl9jZXQ/DQoNCj4gwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBjb3B5X3RvX3VzZXIodWJ1ZiwgYnVmLCBzaXplb2YoYnVmKSk7
DQo+IMKgfQ0KPiDCoA0KPiBAQCAtNDYsNiArNDksOCBAQCBpbnQgcHJjdGxfY2V0KGludCBvcHRp
b24sIHU2NCBhcmcyKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBpZiAoYXJnMiAmIEdOVV9QUk9QRVJUWV9YODZfRkVBVFVSRV8xX1NIU1RLKQ0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzaHN0a19kaXNhYmxlKCk7
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoYXJnMiAmIEdOVV9QUk9QRVJU
WV9YODZfRkVBVFVSRV8xX0lCVCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBpYnRfZGlzYWJsZSgpOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAwOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBBUkNIX1g4Nl9D
RVRfTE9DSzoNCg0K
