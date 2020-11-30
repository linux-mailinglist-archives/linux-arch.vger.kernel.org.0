Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6582C902B
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 22:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgK3VnY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 16:43:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:37857 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgK3VnY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 16:43:24 -0500
IronPort-SDR: IxSLpgaWp21CnpQLRyx1cJRV+0ccdPjyuUeo7sreF6V4NocLOBKDW2qJuC75O5a37f1dvz2vX0
 7DHUPRSLEN6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="236844116"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="236844116"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 13:42:42 -0800
IronPort-SDR: i4iu5/SXboTWgYTCSiHGyLurCgwyH8TqvXb2q5RF0anc8U0Hb+IRtU4D7qnMM4ZT72J9QEVLJr
 /cp4Dw6SUfEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="345226386"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2020 13:42:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Nov 2020 13:42:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Nov 2020 13:42:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 30 Nov 2020 13:42:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 30 Nov 2020 13:42:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmi3hq6i8YC0zkKGIBbjDXdkuUBsfo+v4HP22PRW12JqeeEItz9749f2KnVR5HFjZTRRZU9b7iC+LkFFT3HRG+oG2Ylo9LIKZIizlnBXA55QsQmzT7WV/GTSXc06lhVjX1v2XmBjLgtG4K7auxVsUc9Fa35Cp9niZvR/RnSRpkJGC7awPuEuEe8HJpMghEwC1LkVYWzc7PpZws4RU/K3pqboBT8F6hHDaz8idjuAcz3jNYY8cE2aSuMGBpQzp3xBapUJquSmwytq25bSio/XaPcwPNqaFUZ62usR9BvEYl0D0yQVfi4wg5oavbajLCA6TPTUc3PAXd8JIftkORDzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/bG3AY+G0tW2yAQLCAWncBOCWtlJB/GJF2rCWi0kh4=;
 b=cKnog1jjUJsvMZiaD7Gsef/0CR4HF+D4G0+Mp7G/05POjlFuwOmPH1Q911eEDKwg++0Ot42DkxhlCpi7A/iNas5kMKwvfHxhKr+V7cEmOS4hV1olX8IdcB4AN91uGVTvxOdE0nodB7+4VxxA0e5UwgHjmWv+0HHhDZS5NSApBv8+6MRC43OjNkQuoVHa2gqZa9nSF4vTwhq49H5OiJdaipqhMzgxtJYzWNPWNS5bPh3soaWm1FCuEs4A653ZUohv/u49+QtbQF4RW8Smx2YUm5U8SZ6ql9Aqn8ayKqkZBj30ErIRFW6AmsJboRwxAM1DLIju79O+vPcopZDqpQx+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/bG3AY+G0tW2yAQLCAWncBOCWtlJB/GJF2rCWi0kh4=;
 b=jVwRdSCIuEEB4fH3Un3RrnKN1KLAWAXglktp584OI9frpTDj2VO4RIXHzOVCIhIk5dP7gkE4QTinbuICLF3OUdWHpz7PXRuaU7eB2imA8CZsLXCAQc6WStIZMA7up0JQSWiJGjh5wkOKJf5aaiE2LDFl7E+SEF+cB4+xoBehbts=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SN6PR11MB3120.namprd11.prod.outlook.com (2603:10b6:805:d6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 21:42:40 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 21:42:40 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "npiggin@gmail.com" <npiggin@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v8 11/12] mm/vmalloc: Hugepage vmalloc mappings
Thread-Topic: [PATCH v8 11/12] mm/vmalloc: Hugepage vmalloc mappings
Thread-Index: AQHWx0IouDnRaQC0zE26j1j/vLv2yqnhHkOAgAAWqgA=
Date:   Mon, 30 Nov 2020 21:42:39 +0000
Message-ID: <de48d828e04f662596b4b821293e10e34cdcd757.camel@intel.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
         <20201128152559.999540-12-npiggin@gmail.com>
         <e9d3a50e1b18f9ea1cdfdc221bef75db19273417.camel@intel.com>
In-Reply-To: <e9d3a50e1b18f9ea1cdfdc221bef75db19273417.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7cc18e31-dbac-4693-53fe-08d89578dca1
x-ms-traffictypediagnostic: SN6PR11MB3120:
x-microsoft-antispam-prvs: <SN6PR11MB3120FC3BFF4160F4A48746E0C9F50@SN6PR11MB3120.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PhApG1H38ZzPqJJ532eGDeZpBC4VnPMkOAdVEal0didxBGZh4GAQMTR7P0MA9S5eqFIow5Qj9bEKgmgIYUi9ATkURHyrrF2ftk/WNqu+k0Xzxln4mxknAPBSLpEjsc4Ki9aZ6h1verDVMxzwcuvSegOhV1ej61KaX+eP7pklxUATby/7zgFnvoKFTUCv44xrY7RuCevow9hk+Ir+oh0gL2mHisLCBTr1TyoX9HfgTln19vgAIrUqe2J10U5KXGH3USvNEvZYVC7uhkHIhSmpyFaGSeu2WkyGiCWhdSR4fH5lNhhw6s2lEU1sQ0m3CiO5vTiPKMFS9z3/j5IPc7uxPuEW85tavSy+rbd43GOFtkUBprHVbyniLPI7SZPrtVM+bGqlMs92XquqcRG1xbr/VQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(6506007)(66556008)(54906003)(8936002)(186003)(966005)(110136005)(2906002)(2616005)(5660300002)(4744005)(478600001)(86362001)(7416002)(26005)(71200400001)(8676002)(6512007)(64756008)(66446008)(76116006)(66946007)(91956017)(6486002)(36756003)(4001150100001)(66476007)(4326008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2NQTFp1YTU4UzRTTnZIOHBiditTWUx6OGI4V0pSaFlNNjFIMUVJVTRENXgz?=
 =?utf-8?B?bW9HNHIwYTdYckUvYi90OFU1VmplMFVLd0JPbUt4TFRGTlF0cHB4c1pxSG1v?=
 =?utf-8?B?WE1SZjJNV2JhUGgwSE8zQ3dTNjlGeS85Z0pEeWh4RlZHRXU3WFI0THhZSEhx?=
 =?utf-8?B?ekJ1bVNGYXRkTmtYL3dXRkI3RHhEZkEyUWFETzJCSVhYV3BxZ3FIdkowSGhX?=
 =?utf-8?B?YTZxbnkveFJ6NklKYWxDZ292MGwyL204ODAxbm5BajlydUVJOU41czZKRy8z?=
 =?utf-8?B?Tk9ocWEwUXR2cGRDVGVCRkJHMGVPRGp0TDFkcnNnNlozZ2tWMmhkT1I0NEJJ?=
 =?utf-8?B?ZG5BdEpyUmc0OWFXWGMrYTU5UW8zZlAvbmxUcUNwMUxPQWt6bjkwNWY1OVRF?=
 =?utf-8?B?YU9IZWIwSndpT3UwQk9IWHdFMCtEY04zL3JYZ3ltL3g1OE51WDR0cnNNUzd1?=
 =?utf-8?B?amRLRU82cWtPd09ObStIOVFZWHFUQlM3bzhyL3FoTFZRV01GTkk0emdPckUx?=
 =?utf-8?B?ODUrRHdBZDNVd2ZGR0NHZm42SWU5UERjZ2NvMDVxaG9mU0srb2ttcnJGZjdZ?=
 =?utf-8?B?QWw3V1VSR3dsajRQTWdGNUJBcTdCU045UFdINkNac25sSUpqRUplRXAzOWQ4?=
 =?utf-8?B?ZHc3eHJSSFBpbHQ3UmRRR0RxQzJYL3h3S0FQcEt4dW1QOGtFSFBucjY2UnpP?=
 =?utf-8?B?YmF5dVRSTURKQ256S3cvNjljdGVhR0ZadnE4ZTRFK01TSEt2YlVTY0RqaGQw?=
 =?utf-8?B?Rmk3RHJsTHNsRWtOcHJ4QWcyUnJ5eWlPOE5OdERiUFZ4UFgvbFM0QU9VMFRF?=
 =?utf-8?B?bTZ5QWZ2RVRqL0RuSTRheWtaaDJaNTJ2anAvdEVZMzZtMWFrYTZlVm9mc011?=
 =?utf-8?B?TGRiL1VhQ012NUQ3aW9uL0I0NWk3SnVXelVUMlIxVnovWHV2Y3NmRjBacUhl?=
 =?utf-8?B?YjVWRHpPNnJkUnA5ZnFhcEt6czBrQ2U4eUNldGZzU0lmbG5tQ21zMWVRelpH?=
 =?utf-8?B?eHJjWmxPWldIZVNmdmZLTnhjR0Y2bllvWkUvVTZWdTNVd0o2YWxMRGF0U2FU?=
 =?utf-8?B?VnNFU2FTZm5XZXozeDVVd1RhUFQyRTJZTSttcnJ1ZS9nSFUyT3lxSWN0ZUV1?=
 =?utf-8?B?L3l0V1NzZ01PVUptT01BWjVNeVR0Q0pNajZGcmdQSUdNZUlBeXZPa1JiWXh4?=
 =?utf-8?B?dDB3UUJSZ05NWkxVYVVETzFDYXVHSzFraDJSU25kd0cyeUx0RXN2c0FzR3Yz?=
 =?utf-8?B?dnFubzJjTXhlaXJOMXhyY0xqMU8zejIvZWhkMFJNYkc3U3Vzc01UcWNlQll1?=
 =?utf-8?Q?smgH0OfRh7gOwAzFTfxKfupTquaYq2XVzC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <06DA975E02F10F4AA6101C20BC814DA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc18e31-dbac-4693-53fe-08d89578dca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 21:42:40.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzSJ6/BDIgzzzVyM3p1ZIkvuZl0ABNqjsvFNG6ggUviBIhlmwguhR6dv5AoTOHeC3eMzhAdVdbvZPmVIyMmsQ1n+2pIvz6+4zoNrTdK0PR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3120
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDEyOjIxIC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gYW5vdGhlciBvcHRpb24gY291bGQgYmUgdG8gdXNlIHRoZSBjaGFuZ2VzIGhlcmU6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDExMjUwOTIyMDguMTI1NDQtNC1ycHB0QGtl
cm5lbC5vcmcvDQo+IHRvIHJlc2V0IHRoZSBkaXJlY3QgbWFwIGZvciBhIGxhcmdlIHBhZ2UgcmFu
Z2UgYXQgYSB0aW1lIGZvciBsYXJnZSANCj4gdm1hbGxvYyBwYWdlcy4NCg0KT29wcywgc29ycnku
IFRoaXMgd291bGRuJ3QgYmUgc28gc2ltcGxlIGJlY2F1c2UgaGliZXJuYXRlIGN1cnJlbnRseQ0K
ZXhwZWN0cyBOUCBkaXJlY3QgbWFwIHBhZ2VzIHRvIGJlIDRrLg0K
