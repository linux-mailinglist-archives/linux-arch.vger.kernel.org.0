Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416994A91E0
	for <lists+linux-arch@lfdr.de>; Fri,  4 Feb 2022 02:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356372AbiBDBIe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Feb 2022 20:08:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:22281 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353229AbiBDBId (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Feb 2022 20:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643936913; x=1675472913;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=fJIz7Mhsj/v50QFIXyHEfPztnBd4HKZp2E3HVHA3P0Y=;
  b=aFtVB8RpcCw5CiHlXeRRaAcfWvhh1Bpj4cUJ4MX0ZLAMP8sasrLzYUIu
   KPOQLFUTOGfOQHlunbXmUTvTxy04VZI5JzllPH6EZQi4NgupxYOqO10Xo
   XV7iypsUYB0LlqHPV+mH7HyD3bp+cfV4vY49qK5SjB08tHWRZSGkg13Hq
   Z0C0a8+QGizSrqkK+WmX7thhi+5TozwHJmxI0d11QRGOh0h0v/YnQ8FVI
   WU88J6KQI+YT+fF7Ven8qf559OiAJPVkp4QxLx2BkF3tIEh7ZpJx4E4r2
   1B7LPAEoQA354Yb+3ttmL6j2h+y9/NocAhuGpQQAy8rAPHpe4u1jnr2HO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="228941759"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="228941759"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:08:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="769817353"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 03 Feb 2022 17:08:30 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 17:08:30 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 3 Feb 2022 17:08:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 3 Feb 2022 17:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3ThuBvjAoSL6iYPZzD6Lu1hyKb9mKakYb+6QJwn2vVoUEDTopLc3Y1CRtlr49DufVJMdAY9LH0W8eslhJ+S0LSrehTkKMvm56Jc5U86Deia4YCbZ3bItQ/zYvKU4QF45XnYpVEHOm94hcU4R0oLbnmaTNTV+HTq8fPS9LCfGb0X6ZTf7jyN9zVlxlZhnnZfb/2vk6uxrv5cHuXk1TyTChiyxi6iqnmf2mQsmEwrnnivPUIVhdglZBYdLgjbvLz7yAX2xkOL71eRtYAGBjf9w/h+pjzVde17eHJyxBuIpcSIkPfJNw2N9lrHa7HbkoHihu6TvHDseQ+Px/Ux6TAimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJIz7Mhsj/v50QFIXyHEfPztnBd4HKZp2E3HVHA3P0Y=;
 b=iHskvbdlWA4SvkfnCeTZ/GwXKWQ/uo0xu4PdUuaZBCb8oQcfzmhZX8Asao+fNAptMSMMSL1NLZVGLaQXO4BBSMHP4Q8XlUsMP3GReVUjAjr4IsVwU8Obt5N8zaqKCvxhasvKbVRcs2KiqhmcvOLcW1wpyNjS7Sr/QArrAGBFRu44ZWk6tqmettZHzCn5AvA0q0QHJe1eLNzQ2tIGGsa6ZjuWgSaa0PNI8+hopyXy+4I5yxqroCsoK9PL9zICgwZIaO8w9BvaZJtrehKPR4e/WLI3CrYCiPVyxjElF+uqCRff6ZA0Ee6TK8i581gczyzkYw54E/x/dgEJjhH0/JIUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM5PR1101MB2250.namprd11.prod.outlook.com (2603:10b6:4:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 01:08:25 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Fri, 4 Feb 2022
 01:08:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyCV/wAgABDLwA=
Date:   Fri, 4 Feb 2022 01:08:25 +0000
Message-ID: <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
References: <87fsozek0j.ffs@tglx>
In-Reply-To: <87fsozek0j.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50709fa9-b40f-4944-2126-08d9e77ad8b0
x-ms-traffictypediagnostic: DM5PR1101MB2250:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR1101MB225085E9EE8C553906AB1E26C9299@DM5PR1101MB2250.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jABcsoNOU4+nIU2z2f7aDtB/iKIkQhyYhsZ9A9RDYJycwfN/TW5PlQE6pYDDyz6ESCo5HvvPE8Sj2pDbRPHbmmXqP/R5qaWJM2Ol81UvGpi9ack+7Etq115Fj7l8EAKfMQtC9GPfhBJsvyBkfJpcgyHzx/VIvbtWWgAjBX35noHGRUA15l4I6957F/75nJLEOJqAq6STuxW5orftJrtaFqybDGAUkinRBMeFlnxP5SQgDozFa5sS+mhyF4Bh1r5zNYyw5HFZCJeYTNv95ZLzYZ/qvBF2NKhyql/m8gAPTTqOmwDXdxW1hi4L/JAMQm/+xtyP85U95VLyRIvoXGcGohDyuWqt284yotY95K2O8JGJaqQ0OISFYtYNRpgQ2ZgwkVdqJ8cJhQpiSb0jowQMWhw/wy6Sup2/GpuIsFgFxVuGb8CkVoX5Ul3USE/kmYDzw8N9RW/G3aHJ3kRsFQ2LGvtvt2V29z6/HN8TDXVtCbuog5EHITeK5AbRV0ZHQD2jiwWhjxfpyknU3rGDgWd6EYjSjeIHq4cPazd+iwKsP3ZfQOVNr/4MRMGX+5VtHqL6ZtohUi1wlFbXY9JBDu05UolseeM4CT+nBR8+4BYj3fn+/2r4/Z+ShV3+ZGuS4UThPqp5/W35RcBcf/t4JT+g/HkUj/O5hODYu5Nxdho89xc70J8vhCcmfbGO5yKfKReqxtYM5JHX8ViZgojC7S2c4ZiEGNWEV+B6wCtc2yJZnocckok+XEDzoiHItpbOntpz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7406005)(316002)(7416002)(8936002)(110136005)(921005)(122000001)(66556008)(38100700002)(86362001)(76116006)(66946007)(82960400001)(66476007)(38070700005)(5660300002)(8676002)(64756008)(66446008)(6512007)(6506007)(186003)(26005)(83380400001)(71200400001)(2616005)(6486002)(36756003)(2906002)(508600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk05b0hDWEhpVDkrY1h6Vk12WVUzY0pRMEhVOUE3Y21MdXd3RkNkaVFURm5G?=
 =?utf-8?B?U2VvczhsZGtUYk8zV0o3K3pTYTdIL0xJU2cxaHplcDRhUWUyMWhxMzByY0Za?=
 =?utf-8?B?M2hXZXR4RzhENmZUamRFZktUa0hGazZHclJJNEFSdzBxd0U4R3hRcmhiR0tC?=
 =?utf-8?B?YkEyc0c2KzlUbTR4SWl0S0dqS3d6U0gxaGd0VUtsRWh0VkcxV0lqb3M1ek0v?=
 =?utf-8?B?R0VaZTNUSUtjTWlRbUF0UVhJMWtMYWNWMzNuaE5XTG11ZDZ4bVN1dTRnSG40?=
 =?utf-8?B?V1NJZ1VnS3I5dU0rdzdhUGxMUUd4cG5mYU5SUmhiaW8vQlcrWG9ZY2JKc1NC?=
 =?utf-8?B?bnEzanpQc0E2US9SZVpzNkNRWW5NZnUzcjlaakRxeTdDR0V3NUh5eTJwVlNJ?=
 =?utf-8?B?bCtBM3h1UnJIRlRZNG85bHlNb2JFSTdqek9EQXNLa2xpMWVhT0NsT0JyUitt?=
 =?utf-8?B?a242WEZNakgxbmdwN2p2SnAveXpnYUp5NEdrMXI0bk9WNTUvN1FJVHFUdXFo?=
 =?utf-8?B?MW80L0MzaWMzZGVBMnA3SzZ0ZGF4Q2lHVmpaeVR4c1VpZUlRMEtIbGdkUmpJ?=
 =?utf-8?B?NUxtSUFxVGtGOXlzV1NTaHlwNTRGazh4M2FFMldoaXNzZ2w4M0ViNE1SaWxT?=
 =?utf-8?B?L3lLNWs2Y0lnNjBsR3FrK0wrRE1wTWJOaHJRSFpiQ0Z5UEhPUjkxRlRIWVNH?=
 =?utf-8?B?Ukx0U1A3R0Z2Q1BYRHM4cHNaTkxVNFU0TzZCdDZnamhKVGlZYVhsWExqMCtC?=
 =?utf-8?B?aStHa3NQLzZiRytEQ0hsSVZVNUtxa0tBQzFtcEtoREtlWk1PRVFPb2pZZmR3?=
 =?utf-8?B?cFozdjhieUxFKzNab3FOQmNuR1Q3S2VuZFRnR0NwbUpyZGIyNGo2akNkWTZn?=
 =?utf-8?B?ZFZjb2RhQktRYzF6RWMwRGNsWDBtRnB4dWFlNWRoRDBhZWFHNUd5c2N0aW1V?=
 =?utf-8?B?VGEwNHkySHJlT1V5TzVzamZ5OWc3RjVHVDBjQ2pJRFlNOGQyUFUwL2wvZGJN?=
 =?utf-8?B?S08rVlFaYXhqek8xeWR3YXllOWloN3dCd1h5UHhvQmVDZ3g1TEo1VkpSUlQz?=
 =?utf-8?B?aS9FWW5CK0V0TG03TGJYbDUzd3FGN1NCVGVzQ0VtWGo4OHhPblk0cDNKLzdp?=
 =?utf-8?B?ODVCWkgydTA5cCt6U1RxSTZWV3ZsK0Q0a05uN2lYYmNHbEwyR3JySEFValNW?=
 =?utf-8?B?ZVdpMmN4alRiRmQxcW9DdGcxbzZOM0hyOXFGanZvUlZ4NzNSc3o0UGp4emJG?=
 =?utf-8?B?Z2N0c3cvdkpOd1ZlZkpCY2tBOW1oZmdQQ3BqKzYzRTZtZlJvSXAzNVdIR0Qr?=
 =?utf-8?B?Rzc0QXZqZGNlb2ZmUkJJVmtUNTRXL2Q2VlREYldjUzNTWk5HZ3ZqdnEwNFRv?=
 =?utf-8?B?UHNVUnpudUdwcTdFQnBvWEg1cjJKaE1EM0N3VGx3QnBlY0ozTkVEUjBXVHBo?=
 =?utf-8?B?MnE0YUxtTlBpZmsybVBjTFo1ZHdTZmo0Yk1sT2UrZHpEQk1RNjZLR2Q3UVJ3?=
 =?utf-8?B?cGU5bDNjVFpld0p1OFZmdWdoYUE3RjZEMVdxMVFjVzN4Y0hEUDFGeXNrbFJL?=
 =?utf-8?B?U1VJQ0VaTE1ETEQ5TlhGOUk0NHgyVm9abTFiOHVIMHFlRjBPdHdMZFJGdzQ1?=
 =?utf-8?B?Zm55aHB0ZS9iTHk1N3RZQkhrMnFPQTJTbWszUDM3bjZhdkZxVUhZNHRILzJZ?=
 =?utf-8?B?cUUwcTVOdUZ6WE9RVnJiamIyTzJBbnhONW5mdFhBL0N0N3Rna3lGOEJXVkFp?=
 =?utf-8?B?bXNzNHRrekx2aXc2YUN0cGVNU2lMOERGMU5naUhmWENtaTQyV0o4QUliOENL?=
 =?utf-8?B?K1NmWGk3dEt5U2tTK1orcURRSmZVdVZyKzR5U0lWNExWSk4rYmFhdVpLNnNz?=
 =?utf-8?B?TktrR0NmY3ovUmpyQks2Q0N5eG9zdTNtYzdxVGkxREZWckxreDNxUFJIMHZV?=
 =?utf-8?B?Sit0K0g1aEpLcTQ2b29ydnJSV0F5SVBVVEpWQno5bFlmUlMrT0c1RHBqVWRX?=
 =?utf-8?B?NWZ3Ym42NTNmVEt4SkhRaG1Pd096WVRla0R4TlJqOGtXYU40ZEdVSndQQWxO?=
 =?utf-8?B?Yms3UEYyaGY4dGNyTmU5ejd1R2hsNUhKa2NhM0ptNGJHcjJXdXdSQWZrODl2?=
 =?utf-8?B?RnAyczJVNDhUK25QKzRITlpMWVp1QjNMeDJmUUI1cUc2cmZrNHR2VVZoMnNh?=
 =?utf-8?B?Zk01Nysyai8yaVYrYzVLVHJ6OFdkbmRMeWdGMGF3YXMzZStORUgyNVlGUlZD?=
 =?utf-8?Q?SXO/4Xq3wOu4+gFSgK9VcvUF/TsaGjqRQO22zVweLU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCC1B8291701F34A831386F8832B6C45@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50709fa9-b40f-4944-2126-08d9e77ad8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 01:08:25.4271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jGy60lhcFQcq83K6g4hBDZg2WJR7x1G75BAfs1UHXGLLzg018fH+E5a1k9Cp27neefP207wzXarRq6DAXxPwqiuifl1wHBzMrM04z/1Oio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2250
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgVGhvbWFzLA0KDQpUaGFua3MgZm9yIGZlZWRiYWNrIG9uIHRoZSBwbGFuLg0KDQpPbiBUaHUs
IDIwMjItMDItMDMgYXQgMjI6MDcgKzAxMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gPiBV
bnRpbCBub3csIHRoZSBlbmFibGluZyBlZmZvcnQgd2FzIHRyeWluZyB0byBzdXBwb3J0IGJvdGgg
U2hhZG93DQo+ID4gU3RhY2sgYW5kIElCVC4gDQo+ID4gVGhpcyBoaXN0b3J5IHdpbGwgZm9jdXMg
b24gYSBmZXcgYXJlYXMgb2YgdGhlIHNoYWRvdyBzdGFjaw0KPiA+IGRldmVsb3BtZW50IGhpc3Rv
cnkgDQo+ID4gdGhhdCBJIHRob3VnaHQgc3Rvb2Qgb3V0Lg0KPiA+IA0KPiA+ICAgICAgICBTaWdu
YWxzDQo+ID4gICAgICAgIC0tLS0tLS0NCj4gPiAgICAgICAgT3JpZ2luYWxseSBzaWduYWxzIHBs
YWNlZCB0aGUgbG9jYXRpb24gb2YgdGhlIHNoYWRvdyBzdGFjaw0KPiA+IHJlc3RvcmUgDQo+ID4g
ICAgICAgIHRva2VuIGluc2lkZSB0aGUgc2F2ZWQgc3RhdGUgb24gdGhlIHN0YWNrLiBUaGlzIHdh
cw0KPiA+IHByb2JsZW1hdGljIGZyb20gYSANCj4gPiAgICAgICAgcGFzdCBBQkkgcHJvbWlzZXMg
cGVyc3BlY3RpdmUuIFNvIHRoZSByZXN0b3JlIGxvY2F0aW9uIHdhcw0KPiA+IGluc3RlYWQganVz
dCANCj4gPiAgICAgICAgYXNzdW1lZCBmcm9tIHRoZSBzaGFkb3cgc3RhY2sgcG9pbnRlci4gVGhp
cyB3b3JrcyBiZWNhdXNlIGluDQo+ID4gbm9ybWFsIA0KPiA+ICAgICAgICBhbGxvd2VkIGNhc2Vz
IG9mIGNhbGxpbmcgc2lncmV0dXJuLCB0aGUgc2hhZG93IHN0YWNrIHBvaW50ZXINCj4gPiBzaG91
bGQgYmUgDQo+ID4gICAgICAgIHJpZ2h0IGF0IHRoZSByZXN0b3JlIHRva2VuIGF0IHRoYXQgdGlt
ZS4gVGhlcmUgaXMgbm8NCj4gPiBhbHRlcm5hdGUgc2hhZG93IA0KPiA+ICAgICAgICBzdGFjayBz
dXBwb3J0LiBJZiBhbiBhbHQgc2hhZG93IHN0YWNrIGlzIGFkZGVkIGxhdGVyIHdlDQo+ID4gd291
bGQNCj4gPiAgICAgICAgbmVlZCB0bw0KPiANCj4gU28gaG93IGlzIHRoYXQgZ29pbmcgdG8gd29y
az8gYWx0c3RhY2sgaXMgbm90IGFuIGVzb3RlcmljIGNvcm5lcg0KPiBjYXNlLg0KDQpNeSB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgdGhlIG1haW4gdXNhZ2VzIGZvciB0aGUgc2lnbmFsIHN0YWNrIHdl
cmUNCmhhbmRsaW5nIHN0YWNrIG92ZXJmbG93cyBhbmQgY29ycnVwdGlvbi4gU2luY2UgdGhlIHNo
YWRvdyBzdGFjayBvbmx5DQpjb250YWlucyByZXR1cm4gYWRkcmVzc2VzIHJhdGhlciB0aGFuIGxh
cmdlIHN0YWNrIGFsbG9jYXRpb25zLCBhbmQgaXMNCm5vdCBnZW5lcmFsbHkgd3JpdGFibGUgb3Ig
cGl2b3RhYmxlLCBJIHRob3VnaHQgdGhlcmUgd2FzIGEgZ29vZA0KcG9zc2liaWxpdHkgYW4gYWx0
IHNoYWRvdyBzdGFjayB3b3VsZCBub3QgZW5kIHVwIGJlaW5nIGVzcGVjaWFsbHkNCnVzZWZ1bC4g
RG9lcyBpdCBzZWVtIGxpa2UgcmVhc29uYWJsZSBndWVzc3dvcms/DQoNCklmIGl0IGRvZXMgc2Vl
bXMgbGlrZWx5LCBJJ2xsIGdpdmUgaXQgc29tZSBtb3JlIHRob3VnaHQgdGhhbiB0aGF0IGhhbmQN
CndhdnkgcGxhbi4NCg0KPiAgICAgICAgIA0KPiA+ICAgICAgICBMaW1pdCB0byBvbmx5IEludGVs
IFByb2Nlc3NvcnMNCj4gPiAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gICAgICAgIFNoYWRvdyBzdGFjayBpcyBzdXBwb3J0ZWQgb24gc29tZSBBTUQgcHJvY2Vzc29y
cywgYnV0IHRoaXMNCj4gPiByZXZpc2lvbiANCj4gPiAgICAgICAgKHdpdGggZXhwYW5kZWQgSFcg
dXNhZ2UgYW5kIHhzYXZlcyBjaGFuZ2VzKSBoYXMgb25seSBoYXMNCj4gPiBiZWVuIHRlc3RlZCBv
biANCj4gPiAgICAgICAgSW50ZWwgb25lcy4gU28gdGhpcyBzZXJpZXMgaGFzIGEgcGF0Y2ggdG8g
bGltaXQgc2hhZG93IHN0YWNrDQo+ID4gc3VwcG9ydCB0byANCj4gPiAgICAgICAgSW50ZWwgcHJv
Y2Vzc29ycy4gSWRlYWxseSB0aGUgcGF0Y2ggd291bGQgbm90IGV2ZW4gbWFrZSBpdA0KPiA+IHRv
IG1haW5saW5lLCANCj4gPiAgICAgICAgYW5kIHNob3VsZCBiZSBkcm9wcGVkIGFzIHNvb24gYXMg
dGhpcyB0ZXN0aW5nIGlzIGRvbmUuIEl0J3MNCj4gPiBpbmNsdWRlZCANCj4gPiAgICAgICAganVz
dCBpbiBjYXNlLg0KPiANCj4gSGEuIEkgY2FuIGdpdmUgeW91IGFjY2VzcyB0byBhbiBBTUQgbWFj
aGluZSB3aXRoIENFVCBTUyBzdXBwb3J0ZWQgOikNCg0KVGhhbmtzIGZvciB0aGUgb2ZmZXIuIEl0
IHNvdW5kcyBsaWtlIEpvaG4gQWxsZW4gY2FuIGRvIHRoaXMgdGVzdGluZy4NCg0KPiANCj4gPiBG
dXR1cmUgV29yaw0KPiA+ID09PT09PT09PT09DQo+ID4gRXZlbiB0aG91Z2ggdGhpcyBpcyBub3cg
ZXhjbHVzaXZlbHkgYSBzaGFkb3cgc3RhY2sgc2VyaWVzLCB0aGVyZSBpcw0KPiA+IHN0aWxsIHNv
bWUgDQo+ID4gcmVtYWluaW5nIHNoYWRvdyBzdGFjayB3b3JrIHRvIGJlIGRvbmUuDQo+ID4gDQo+
ID4gICAgICAgIFB0cmFjZQ0KPiA+ICAgICAgICAtLS0tLS0NCj4gPiAgICAgICAgRWFybHkgaW4g
dGhlIHNlcmllcywgdGhlcmUgd2FzIGEgcGF0Y2ggdG8gYWxsb3cgSUEzMl9VX0NFVA0KPiA+IGFu
ZA0KPiA+ICAgICAgICBJQTMyX1BMM19TU1AgdG8gYmUgc2V0LiBUaGlzIHBhdGNoIHdhcyBkcm9w
cGVkIGFuZCBwbGFubmVkDQo+ID4gYXMgYSBmb2xsb3cNCj4gPiAgICAgICAgdXAgdG8gYmFzaWMg
c3VwcG9ydCwgYW5kIGl0IHJlbWFpbnMgdGhlIHBsYW4uIEl0IHdpbGwgYmUNCj4gPiBuZWVkZWQg
Zm9yDQo+ID4gICAgICAgIGluLXByb2dyZXNzIGdkYiBzdXBwb3J0Lg0KPiANCj4gSXQncyBwcmV0
dHkgbXVjaCBhIHByZXJlcXVpc2l0ZSBmb3IgZW5hYmxpbmcgaXQsIHJpZ2h0Pw0KDQpZZXMuDQoN
Cj4gDQo+ID4gICAgICAgIENSSVUgU3VwcG9ydA0KPiA+ICAgICAgICAtLS0tLS0tLS0tLS0NCj4g
PiAgICAgICAgSW4gdGhlIHBhc3QgdGhlcmUgd2FzIHNvbWUgc3BlY3VsYXRpb24gb24gdGhlIG1h
aWxpbmcgbGlzdA0KPiA+IGFib3V0IA0KPiA+ICAgICAgICB3aGV0aGVyIENSSVUgd291bGQgbmVl
ZCB0byBiZSB0YXVnaHQgYWJvdXQgQ0VULiBJdCB0dXJucw0KPiA+IG91dCwgaXQgZG9lcy4gDQo+
ID4gICAgICAgIFRoZSBmaXJzdCBpc3N1ZSBoaXQgaXMgdGhhdCBDUklVIGNhbGxzIHNpZ3JldHVy
biBkaXJlY3RseQ0KPiA+IGZyb20gaXRzIA0KPiA+ICAgICAgICDigJxwYXJhc2l0ZSBjb2Rl4oCd
IHRoYXQgaXQgaW5qZWN0cyBpbnRvIHRoZSBkdW1wZXIgcHJvY2Vzcy4NCj4gPiBUaGlzIHZpb2xh
dGVzDQo+ID4gICAgICAgIHRoaXMgc2hhZG93IHN0YWNrIGltcGxlbWVudGF0aW9u4oCZcyBwcm90
ZWN0aW9uIHRoYXQgaW50ZW5kcw0KPiA+IHRvIHByZXZlbnQNCj4gPiAgICAgICAgYXR0YWNrZXJz
IGZyb20gZG9pbmcgdGhpcy4NCj4gPiANCj4gPiAgICAgICAgV2l0aCBzbyBtYW55IHBhY2thZ2Vz
IGFscmVhZHkgZW5hYmxlZCB3aXRoIHNoYWRvdyBzdGFjaywNCj4gPiB0aGVyZSBpcyANCj4gPiAg
ICAgICAgcHJvYmFibHkgZGVzaXJlIHRvIG1ha2UgaXQgd29yayBzZWFtbGVzc2x5LiBCdXQgaW4g
dGhlDQo+ID4gbWVhbnRpbWUgaWYgDQo+ID4gICAgICAgIGRpc3Ryb3Mgd2FudCB0byBzdXBwb3J0
IHNoYWRvdyBzdGFjayBhbmQgQ1JJVSwgdXNlcnMgY291bGQNCj4gPiBtYW51YWxseSANCj4gPiAg
ICAgICAgZGlzYWJsZWQgc2hhZG93IHN0YWNrIHZpYQ0KPiA+IOKAnEdMSUJDX1RVTkFCTEVTPWds
aWJjLmNwdS54ODZfc2hzdGs9b2Zm4oCdIGZvciANCj4gPiAgICAgICAgYSBwcm9jZXNzIHRoZXkg
d2lsbCB3YW50cyB0byBkdW1wLiBJdOKAmXMgbm90IGlkZWFsLg0KPiA+IA0KPiA+ICAgICAgICBJ
4oCZZCBsaWtlIHRvIGhlYXIgd2hhdCBwZW9wbGUgdGhpbmsgYWJvdXQgaGF2aW5nIHNoYWRvdyBz
dGFjaw0KPiA+IGluIHRoZSANCj4gPiAgICAgICAga2VybmVsIHdpdGhvdXQgdGhpcyByZXNvbHZl
ZC4gTm90aGluZyB3b3VsZCBjaGFuZ2UgZm9yIGFueQ0KPiA+IHVzZXJzIHVudGlsIA0KPiA+ICAg
ICAgICB0aGV5IGVuYWJsZSBzaGFkb3cgc3RhY2sgaW4gdGhlIGtlcm5lbCBhbmQgdXBkYXRlIHRv
IGEgZ2xpYmMNCj4gPiBjb25maWd1cmVkDQo+ID4gICAgICAgIHdpdGggQ0VULiBTaG91bGQgQ1JJ
VSB1c2Vyc3BhY2UgYmUgc29sdmVkIGJlZm9yZSBrZXJuZWwNCj4gPiBzdXBwb3J0Pw0KPiANCj4g
RGVmaW5pdGVseSB5ZXMuIE1ha2luZyBDUklVIHVzZXJzIGFkZCBhIGdsaWJjIHR1bmFibGUgaXMg
bm90IHJlYWxseQ0KPiBhbg0KPiBvcHRpb24uIFdlIGNhbid0IGJyZWFrIENSSVUgc3lzdGVtcyB3
aXRoIGEga2VybmVsIHVwZ3JhZGUuDQoNCk9rIGdvdCBpdCwgdGhhbmtzLiBKdXN0IHRvIGJlIGNs
ZWFyIHRob3VnaCwgZXhpc3RpbmcgZGlzdHJvcy9iaW5hcmllcw0Kb3V0IHRoZXJlIHdpbGwgbm90
IGhhdmUgc2hhZG93IHN0YWNrIGVuYWJsZWQgd2l0aCBqdXN0IGFuIHVwZGF0ZWQNCmtlcm5lbCAo
ZHVlIHRvIHRoZSBlbmFibGluZyBjaGFuZ2VzKS4gU28gdGhlIENSSVUgdG9vbHMgd291bGQgb25s
eQ0KYnJlYWsgYWZ0ZXIgZnV0dXJlIGdsaWJjIGJpbmFyaWVzIGVuYWJsZSBDRVQsIHdoaWNoIHVz
ZXJzL2Rpc3Ryb3Mgd291bGQNCmhhdmUgdG8gZG8gc3BlY2lmaWNhbGx5IChnbGliYyBkb2Vzbid0
IGV2ZW4gZW5hYmxlIGNldCBieSBkZWZhdWx0KS4NCg0KU2luY2UgdGhlIHB1cnBvc2Ugb2YgdGhp
cyBmZWF0dXJlIGlzIHRvIHJlc3RyaWN0IHByZXZpb3VzbHkgYWxsb3dlZA0KYmVoYXZpb3JzLCBh
bmQgaXTigJlzIGFwcGFyZW50bHkgZ2V0dGluZyBlbmFibGVkIGJ5IGRlZmF1bHQgaW4gc29tZQ0K
ZGlzdHJvJ3MgcGFja2FnZXMsIEkgZ3Vlc3MgdGhlcmUgaXMgYSBkZWNlbnQgY2hhbmNlIHRoYXQg
b25jZSBhIHN5c3RlbQ0KaXMgdXBkYXRlZCB3aXRoIGEgZnV0dXJlIGdsaWJjIHNvbWUgYXBwIHNv
bWV3aGVyZSB3aWxsIGJyZWFrLiBJIHdhcw0KdW5kZXIgdGhlIGltcHJlc3Npb24gdGhhdCBhcyBs
b25nIGFzIHRoZXJlIHdlcmUgbm8gYnJlYWthZ2VzIHVuZGVyIGENCmN1cnJlbnQgc2V0IG9mIGJp
bmFyaWVzIChpbmNsdWRpbmcgZ2xpYmMpLCB0aGlzIHdhcyBub3QgY29uc2lkZXJlZCBhDQprZXJu
ZWwgcmVncmVzc2lvbi4gUGxlYXNlIGNvcnJlY3QgbWUgaWYgdGhpcyBpcyB3cm9uZy4gSSB0aGlu
ayB0aGVyZQ0KYXJlIG90aGVyIG9wdGlvbnMgaWYgd2Ugd2FudCB0byBtYWtlIHRoaXMgc29mdGVy
Lg0KDQpPZiBjb3Vyc2Ugbm9uZSBvZiB0aGF0IHByZXZlbnRzIGtub3duIGJyZWFrYWdlcyBmcm9t
IGJlaW5nIGZpeGVkIGZvcg0Kbm9ybWFsIHJlYXNvbnMgYW5kIEnigJlsbCBsb29rIGludG8gdGhh
dCBmb3IgQ1JJVS4NCg==
