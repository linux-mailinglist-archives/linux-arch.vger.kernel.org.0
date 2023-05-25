Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4B710297
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 04:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjEYCG0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 22:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEYCGZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 22:06:25 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E274D3;
        Wed, 24 May 2023 19:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+ZiD8EjafPQyvHt1JT+jcyaWu0+M7shjUY9AjBxlIAUiV7hlVOImGlrxXylX1DIL6edp20xbQSnEMyqolYUeDjfVA3FzfINGwCoHuZTqN6zEGhPRc/PEILjyt27P1lj3DBhpKb+bdpp5MlCtksaEL6BqQzojkq6UvsSxPLIbKRUWX7ZpCRaOfYKdZAu6bGfHCijc/0o8jOgjWjuPp/AYiBiDQ90HW3CHvA/OLnn0IGuiyQ5tBP78+QJtt/pedz642z4IANxBHbCjGLQum3SqcAqO/wgLWYBpFvMvtlGxrmXA9U4WoTPskHyEZZccnhrbXI2Y53uUzj3eJYEKtsH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVKiF/2l/MRuRFtF5IumgDeW/tPDoCMd0lhvBEPz+Bc=;
 b=ldUWyT2zOxgFuykUfayz9UQOjhl6ONahQ+k+e2EFSZ+0Y55gL1CAx7u24tbU6aeKuUyJ6xcqAUS+1JAQYYVj5AexL1xqYnFzedE8G+tsToJTCEDNOpcKHSMe5+aLvVZmFioDsmIfzN2t2sYHyMoHrxxBk1IVn4A2/qIviqw/PDIxtyzlEFLpx2+QeC3jLJTQjQMgWYLZ12YZUfuhVZoFPtlDp7vOf5I/+cShHPjsG30xJqzbVk++tE7zp84XNWakSLzloeIWbv8HcmXfmigLWQUz87kBDcgfHSqPW96jm4vsBo/g1izgh6XawQb8ifkNw0QJDDi7q3PwkEracZg8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVKiF/2l/MRuRFtF5IumgDeW/tPDoCMd0lhvBEPz+Bc=;
 b=W5nt2RS6W7t+PqZTVND+2iSDIWSN6hvBbolSk6nx8nQgrDfjv4MtQ50XUwxJx1hPld2kr5frgpoX8ZWQLYH+L1BrcjzA75GWS1YKAt8FCPSiVGQ+UQNa1XZWfgjvmXV9JwX+d76H/vBs2M4We9dhr98rvVk6oTEid/WbXrZmaGU=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3340.namprd21.prod.outlook.com (2603:10b6:8:7f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.13; Thu, 25 May
 2023 02:06:20 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6455.004; Thu, 25 May 2023
 02:06:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v6 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH v6 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHZjbtoOY6hB4AsVEWN3dq4K3z1Ba9qK53Q
Date:   Thu, 25 May 2023 02:06:20 +0000
Message-ID: <SA1PR21MB1335736123C2BCBBFD7460C3BF46A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230504225351.10765-1-decui@microsoft.com>
 <20230504225351.10765-2-decui@microsoft.com>
 <949f953c-f36c-b421-5132-353e2d373413@intel.com>
In-Reply-To: <949f953c-f36c-b421-5132-353e2d373413@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4177fe5b-59eb-4b83-8e9b-b75f8465b2a1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-25T00:55:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3340:EE_
x-ms-office365-filtering-correlation-id: 0291f7d0-5f03-4a58-274d-08db5cc4a1d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l0U0fD/nAdDye2rkZWT238jutAjwo0FQxj1A1VI8dIYyMG4TpxBtia8i94c8CBruYwl1N3hgLTF8BdXNcE2p91c4j9CyGKOUpqtkYor7Y8TYH5rBtrdrtjNqdG+wk1yeKDtbiNYKoPmHdkfgFOA8C9Saach6LnnEvlUmWjkENIVtc3vNbChXIV7k0GN27I5jhIBmA9K4vQnucBwOJw10tS9FMFbpod3eaWr/hh8oq2fv8Dr5QRSjFZOi/mmB2PfdqCtfk7nFc130K111K5OFPvNfagua57L08wpeDOBUFoPoRKg04FOUz60mBtZSUKVpySI7mCL9LTAkJqI9QvSuZvG3f46MzbOsjV8B6jbyPkca9QVvdR+tA7LDyDdOMy67006Orm85WWfWLs/LXK8stWxdSjFkjKo3aFymVaI8IeiIpGaRBVfIrmJU6nfUGUknqAYCG+DMmMmQ2B/dwDRYWJ14vGOzZe0tvUaUEiErlASVYIUafJOR5qviHd1KPklUHphbB7AkfqKwTLCXXGIDY7+CmW+hqI7GTrCWvITu9ABBNiE0Z96qVU1XXkFV3wY7MEegzphpkH8OP/9krxVBwK0Dt6WLCq5z2UfggLkVnHZrErZjF9bOlKiL7SwzSkdDqVoFSLij1ELXyOeJaSMMnzV2zxWynsKvv/BjgAdpOUE/7Kk4WESl/a2j/VT073Qz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199021)(86362001)(54906003)(921005)(122000001)(110136005)(83380400001)(10290500003)(8990500004)(7696005)(478600001)(66476007)(66946007)(82960400001)(66556008)(64756008)(76116006)(66446008)(82950400001)(38100700002)(4326008)(6636002)(71200400001)(316002)(786003)(6506007)(41300700001)(8936002)(2906002)(186003)(26005)(7416002)(8676002)(9686003)(38070700005)(53546011)(107886003)(5660300002)(33656002)(55016003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M045YWdMdWM1dFVKYzQzd3VoM2VBZ091cE8wRm1LQll6WjRUcmVmSmhPYmRm?=
 =?utf-8?B?VzluRkhJUnhqQmtTaGFxUXhjUnJLNGdFMVFlSkpMcDhKa09RTUdVR2tOS2Zp?=
 =?utf-8?B?dldTYnpHd3pqRnBFODBRYlh0VU5MN0ZuK0cvQlJGZ2c1Yzk0Z3h0NmttNmND?=
 =?utf-8?B?eUxPOWZSVVdSMlRkcHl2WktSYnF2aEpYaXlJSGw1LzZSQXZMOHVrRXJ0NVBD?=
 =?utf-8?B?emdRMndOZ2tiVXFxdHhpWkVpWm9vQ21XMWlVYjlTa01nbjFrOGFKMHAxZTI1?=
 =?utf-8?B?OXcyVHBMbURMYld5TzN3V1ZKYjRaOUFPVnpVT1ZEWEsvZExxUGVYT0pQMVlR?=
 =?utf-8?B?REdpYTdHU0tyanRhVUNHU3V2eldCN3k0eUpQcGdEamNaZ2pRdGErdmIyekd3?=
 =?utf-8?B?ME5VeE1xRXY0L092RVNKbmgrN0xTSHlFeHBMNUp4YjBXeFVUNkVQbHBianh0?=
 =?utf-8?B?Um5BSU5HMXJwM0tPdEZ4dnJ0QVBUdlBGOHd3WUNhaFhWSXZydkErMEVmT2du?=
 =?utf-8?B?bVozNm5lbFN5OTJ3QXZHN205aE9hV0FpTTNmeXlXVmdvTzRMSXoyMzZCU3h1?=
 =?utf-8?B?WHFjVDBqY09CbkQ4WkFqQmVtTy9wZlVhbkx5K21RbmREVUZGSXZjZnh2SzNJ?=
 =?utf-8?B?dFJKYVIvUG54OGw3bkFFU2JJbXhZY0EzOXFIdFo5UjQ0RGQ2TUhJam5GdTV2?=
 =?utf-8?B?UGplUnJqdnRTdVh0OHprNURzMG4vMGNZSmJ4K250UnZURzhWR2pheHVuZXpr?=
 =?utf-8?B?U0dYQWZ0OENpaHVKbDJTakhQQUlsZ2R4aVUyOCtaakRsakRQZmZYUHY5aDJZ?=
 =?utf-8?B?Q0orODMwSWU0MmdtbG5kWlNFbDkyY1NrbTI1NGd1REVjdVI3L1pmeGZJUFlN?=
 =?utf-8?B?Lzh3bC9GVTQ4UkhFVXROb0phT2FXNFBUeFN2clcrazZMLy9MOFI3TDZuTkJS?=
 =?utf-8?B?SjloWVJjYWswcHRJQXM2cmo3R2xOL2krTWFtNEpDek4wY3RNd081ZitLc2hC?=
 =?utf-8?B?UmhBOEdDeDg0dDlKTDZrUDFSUzRuY3UweXJraStDOHVRVG0vMjVwUVVmQUFt?=
 =?utf-8?B?cmhyQVdPUktJRGpVeDhaRXdKV1JQQ0oyN0dsb29YMmZuQmw5VzFNaFNTSW9G?=
 =?utf-8?B?dW5ta2hXOHBQL1dNU0lFOVhzRXd1WkFMVFF6c1J6UTVrVUdjUUJzNE5JRkZw?=
 =?utf-8?B?ZS9sL0sremlUazM1blNRUjNWL3dXM2pJMklMYWV3NGN6bG1PYkU5dHZMS0Vq?=
 =?utf-8?B?WnBKaGhOOFA5ZUpnT0d1N0pkQ1NpbzdEZG9RZHpXcXFZZXlHMUhjVXZaVEVT?=
 =?utf-8?B?dmFURTU4YUUybFlvT1FsWlByVEZDRTgrbnNKeTB3R3FNMkVLYm1aK1VwODdS?=
 =?utf-8?B?SFpzUlhzWkt4cE9lWXlaaFR5Q3JXTjlmd1BuaFFVYkl1QW9BNXVOSjJWbUt0?=
 =?utf-8?B?RFdSUlBRaFJDUjlkRzBGT1dVaGxxU0ZSMW9tTWI0a1c0K0dYa0tBL2dxT2Jw?=
 =?utf-8?B?dnNGVEx2cGVPK0ZnYmkwaURGMW5oaWREUkJQRkxZMWoyRy9lSFNrUWVQa1BD?=
 =?utf-8?B?blZDQUxIZ0F6SWIybjBGdW9abUpwR01sR3M3Wm9RdnorTGlHZExQSmFaUXFE?=
 =?utf-8?B?VGQyTXE3SUVuVncvZlhsT0xaU1BUTytGNkpTUUZTYzA1WWFyUldDQTgySTZB?=
 =?utf-8?B?NVlCMWVGckxrMy9XTldlMjdudmhIVkFaVUpkcVR6MFh2enBmYndUMXcyWW41?=
 =?utf-8?B?VnBnS0krdXNLcVdydHMrVG5NNEZqSTBVeVlna0dhM0VuUHhJZ1UyRkJCRzR4?=
 =?utf-8?B?OTVSRjZXY0o0VFZzS09iT2o0aTIvVExtNTl3NHRoV0xYc0ZSekV6Umc2cVY1?=
 =?utf-8?B?SlJBMVNNMFIva25LRkI4bDcvdE5paVNKL2VYdWhINWhJRnVOVHk2a3NvNW9t?=
 =?utf-8?B?M2lNekY0dTFFNHBqQUVablBRQmxqcFFoYnE3d21tVTRxbThoVk9mY0U0ajZI?=
 =?utf-8?B?bWpCTUxmOE03enBjc0NibENtaEhHMklJQTc3VDRvWEVWYWZGa2c0U3FwVDN2?=
 =?utf-8?B?S0IycUEwR21PMGx2TUlhOTUzT2k0b1V4K0hLQWprVkU4b2RVTHQ0cXFKa3pR?=
 =?utf-8?Q?IoiapqbYn64NHPMWjeFdLt7BM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0291f7d0-5f03-4a58-274d-08db5cc4a1d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 02:06:20.1709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RW36V7bxpahZrGRF48H32Kq2G7nLl09Ku9qp0gQydxEBvBP7udaFrO+cAni2LvEesrJ4ijKGXwlwH/1kHO9GYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBNYXkgMjMsIDIwMjMgMjoxMyBQTQ0KPiAuLi4NCj4gT24gNS80LzIzIDE1OjUzLCBEZXh1
YW4gQ3VpIHdyb3RlOg0KPiA+IC0JaWYgKF90ZHhfaHlwZXJjYWxsKFREVk1DQUxMX01BUF9HUEEs
IHN0YXJ0LCBlbmQgLSBzdGFydCwgMCwgMCkpDQo+ID4gKwl3aGlsZSAoMSkgew0KPiA+ICsJCW1l
bXNldCgmYXJncywgMCwgc2l6ZW9mKGFyZ3MpKTsNCj4gPiArCQlhcmdzLnIxMCA9IFREWF9IWVBF
UkNBTExfU1RBTkRBUkQ7DQo+ID4gKwkJYXJncy5yMTEgPSBURFZNQ0FMTF9NQVBfR1BBOw0KPiA+
ICsJCWFyZ3MucjEyID0gc3RhcnQ7DQo+ID4gKwkJYXJncy5yMTMgPSBlbmQgLSBzdGFydDsNCj4g
PiArDQo+ID4gKwkJcmV0ID0gX190ZHhfaHlwZXJjYWxsX3JldCgmYXJncyk7DQo+ID4gKwkJaWYg
KHJldCAhPSBURFZNQ0FMTF9TVEFUVVNfUkVUUlkpDQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCS8q
DQo+ID4gKwkJICogVGhlIGd1ZXN0IG11c3QgcmV0cnkgdGhlIG9wZXJhdGlvbiBmb3IgdGhlIHBh
Z2VzIGluIHRoZQ0KPiA+ICsJCSAqIHJlZ2lvbiBzdGFydGluZyBhdCB0aGUgR1BBIHNwZWNpZmll
ZCBpbiBSMTEuIE1ha2Ugc3VyZSBSMTENCj4gPiArCQkgKiBjb250YWlucyBhIHNhbmUgdmFsdWUu
DQo+ID4gKwkJICovDQo+ID4gKwkJbWFwX2ZhaWxfcGFkZHIgPSBhcmdzLnIxMTsNCj4gPiArCQlp
ZiAobWFwX2ZhaWxfcGFkZHIgPCBzdGFydCB8fCBtYXBfZmFpbF9wYWRkciA+PSBlbmQpDQo+ID4g
KwkJCXJldHVybiBmYWxzZTsNCj4gDQo+IFRoaXMgc2hvdWxkIHByb2JhYmx5IGFsc28gc2F5OiAi
cjExIiBjb21lcyBmcm9tIHRoZSB1bnRydXN0ZWQgVk1NLg0KPiBTYW5pdHkgY2hlY2sgaXQuDQoN
ClRoYW5rcyEgSSdsbCB1c2UgdGhlIHdvcmRpbmcgeW91IHJlY29tbWVuZGVkIGluIHRoZSBuZXh0
IHZlcnNpb24uDQogDQo+IFNob3VsZCB0aGlzICpyZWFsbHkqIGJlICJtYXBfZmFpbF9wYWRkciA+
PSBlbmQiPyAgT3IgaXMNCj4gIm1hcF9mYWlsX3BhZGRyID4gZW5kIiBzdWZmaWNpZW50LiAgSW4g
b3RoZXIgd29yZHMsIGlzIGl0IHJlYWxseQ0KPiB3b3J0aCBmYWlsaW5nIHRoaXMgaWYgYSBWTU0g
c2FpZCB0byByZXRyeSBhIDAtYnl0ZSByZWdpb24gYXQgdGhlIGVuZD8NCg0KQWNjb3JkaW5nIHRv
IHRoZSBHSENJIHNwZWMsIFIxMyAibXVzdCBiZSBhIG11bHRpcGxlIG9mIDRLQiIuIE15DQp1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgUjEzIHNob3VsZCBub3QgYmUgMCwgYW5kIGEgaHlwZXJ2aXNvciBp
cyBub3QNCnN1cHBvc2VkIHRvIHRlbGwgdGhlIGd1ZXN0IHRvIHJldHJ5IGEgMC1ieXRlIHJlZ2lv
biBhdCB0aGUgZW5kLg0KDQpJTUhPIGl0IHNob3VsZCBiZSBhIGh5cGVydmlzb3IgYnVnIGlmIGEg
aHlwZXJ2aXNvciByZXR1cm5zDQpURFZNQ0FMTF9TVEFUVVNfUkVUUlkgYW5kIHRoZSByZXR1cm5l
ZCAnbWFwX2ZhaWxfcGFkZHInIGVxdWFscw0KJ2VuZCcgKE5vdGU6IHRoZSB2YWxpZCBwYWdlIHJh
bmdlIGlzIFtzdGFydCwgZW5kIC0gMV0pLg0KDQpIeXBlci1WIHJldHVybnMgImludmFsaWQgcGFy
YW1ldGVyIiBpZiB0aGUgbGVuZ3RoIChpLmUuIGFyZ3MucjEzKSBpcyAwLA0Kc28gInJldHJ5IGEg
MC1ieXRlIHJlZ2lvbiBhdCB0aGUgZW5kIiB3b3VsZCBmYWlsIGFueXdheS4gSSBndWVzcw0Kb3Ro
ZXIgaHlwZXJ2aXNvcnMgbWF5IGFsc28gcmV0dXJuIGFuIGVycm9yIGlmIHRoZSBsZW5ndGggaXMg
MC4NCg0KU28gSSdkIGxpa2UgdG8ga2VlcCB0aGUgY29tcGFyaXNvbiBhcy1pcy4NCg0KPiA+ICsJ
CWlmIChtYXBfZmFpbF9wYWRkciA9PSBzdGFydCkgew0KPiA+ICsJCQlyZXRyeV9jbnQrKzsNCj4g
PiArCQkJaWYgKHJldHJ5X2NudCA+IG1heF9yZXRyeV9jbnQpDQo+IA0KPiBJIHRoaW5rIHdlIGNh
biBzcGFyZSB0d28gYnl0ZXMgaW4gYSBmZXcgc3BvdHMgdG8gbWFrZSB0aGVzZSAnY291bnQnDQo+
IGluc3RlYWQgb2YgJ2NudCcuDQoNCk9rLCBJJ2xsIHJlbmFtZSB0aGUgdmFyaWFibGUgJ21heF9y
ZXRyeV9jbnQnIHRvICdtYXhfcmV0cmllc19wZXJfcGFnZScsDQphbmQgJ3JldHJ5X2NudCcgdG8g
J3JldHJ5X2NvdW50Jy4NCg0KPiA+ICsJCQkJcmV0dXJuIGZhbHNlOw0KPiA+ICsJCX0gZWxzZSB7
DQo+ID4gKwkJCXJldHJ5X2NudCA9IDA7DQo+ID4gKwkJCXN0YXJ0ID0gbWFwX2ZhaWxfcGFkZHI7
DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiANCj4gdGhpcyBmYWlscyB0aGUgIm5vcm1hbCBvcGVyYXRp
b24gc2hvdWxkIGJlIGF0IHRoZSBsb3dlc3QgaW5kZW50YXRpb24iDQo+IHJ1bGUuICBIb3cgYWJv
dXQgdGhpczoNCj4gDQo+IAl3aGlsZSAocmV0cnlfY291bnQgPCBtYXhfcmV0cmllcykgew0KPiAJ
CS4uLg0KPiANCj4gCQkvKiAiQ29uc3VtZSIgYSByZXRyeSB3aXRob3V0IGZvcndhcmQgcHJvZ3Jl
c3M6ICovDQo+IAkJaWYgKG1hcF9mYWlsX3BhZGRyID09IHN0YXJ0KSB7DQo+IAkJCXJldHJ5X2Nv
dW50Kys7DQo+IAkJCWNvbnRpbnVlOw0KPiAJCX0NCj4gDQo+IAkJc3RhcnQgPSBtYXBfZmFpbF9w
YWRkcjsNCj4gCQlyZXRyeV9jb3VudCA9IDA7DQo+IAl9DQo+IA0KPiAJLy8gcGx1cyBtYXliZSBh
IHdlZSBiaXQgZGlmZmVyZW50ICdyZXQnIHByb2Nlc3NpbmcNCj4gDQo+IA0KPiAnbWF4X3JldHJp
ZXMnIGFsc28gZW5kcyB1cCBiZWluZyBhIG1pc25vbWVyLiAgWW91IGNhbiBoYXZlIGFzIG1hbnkN
Cj4gcmV0cmllcyBhcyB0aGVyZSBhcmUgcGFnZXMgcGx1cyAnbWF4X3JldHJpZXMnLiAgSXQncyBy
ZWFsbHkgIm1heGltdW0NCj4gYWxsb3dlZCBjb25zZWN1dGl2ZSBmYWlsdXJlcyIuICBNYXliZSBp
dCBzaG91bGQgYmUgIm1heF9yZXRyaWVzX3Blcl9wYWdlIi4NCg0KVGhhbmtzLCBJJ2xsIHJhbmFt
ZSAnbWF4X3JldHJpZXMiIHRvICdtYXhfcmV0cmllc19wZXJfcGFnZScuDQoNCkknbGwgdXNlIHRo
ZSBiZW93IGluIHRoZSBuZXh0IHZlcnNpb24uDQpJIGFkZGVkICJjb25zdCIgdG8gImludCBtYXhf
cmV0cmllc19wZXJfcGFnZSIuDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSBtaXNzZWQgYW55dGhp
bmcuDQoNCitzdGF0aWMgYm9vbCB0ZHhfbWFwX2dwYShwaHlzX2FkZHJfdCBzdGFydCwgcGh5c19h
ZGRyX3QgZW5kLCBib29sIGVuYykNCit7DQorCWNvbnN0IGludCBtYXhfcmV0cmllc19wZXJfcGFn
ZSA9IDM7DQorCXN0cnVjdCB0ZHhfaHlwZXJjYWxsX2FyZ3MgYXJnczsNCisJdTY0IG1hcF9mYWls
X3BhZGRyLCByZXQ7DQorCWludCByZXRyeV9jb3VudCA9IDA7DQorDQorCWlmICghZW5jKSB7DQor
CQkvKiBTZXQgdGhlIHNoYXJlZCAoZGVjcnlwdGVkKSBiaXRzOiAqLw0KKwkJc3RhcnQgfD0gY2Nf
bWtkZWMoMCk7DQorCQllbmQgICB8PSBjY19ta2RlYygwKTsNCisJfQ0KKw0KKwl3aGlsZSAocmV0
cnlfY291bnQgPCBtYXhfcmV0cmllc19wZXJfcGFnZSkgew0KKwkJbWVtc2V0KCZhcmdzLCAwLCBz
aXplb2YoYXJncykpOw0KKwkJYXJncy5yMTAgPSBURFhfSFlQRVJDQUxMX1NUQU5EQVJEOw0KKwkJ
YXJncy5yMTEgPSBURFZNQ0FMTF9NQVBfR1BBOw0KKwkJYXJncy5yMTIgPSBzdGFydDsNCisJCWFy
Z3MucjEzID0gZW5kIC0gc3RhcnQ7DQorDQorCQlyZXQgPSBfX3RkeF9oeXBlcmNhbGxfcmV0KCZh
cmdzKTsNCisJCWlmIChyZXQgIT0gVERWTUNBTExfU1RBVFVTX1JFVFJZKQ0KKwkJCXJldHVybiAh
cmV0Ow0KKwkJLyoNCisJCSAqIFRoZSBndWVzdCBtdXN0IHJldHJ5IHRoZSBvcGVyYXRpb24gZm9y
IHRoZSBwYWdlcyBpbiB0aGUNCisJCSAqIHJlZ2lvbiBzdGFydGluZyBhdCB0aGUgR1BBIHNwZWNp
ZmllZCBpbiBSMTEuIFIxMSBjb21lcw0KKwkJICogZnJvbSB0aGUgdW50cnVzdGVkIFZNTS4gU2Fu
aXR5IGNoZWNrIGl0Lg0KKwkJICovDQorCQltYXBfZmFpbF9wYWRkciA9IGFyZ3MucjExOw0KKwkJ
aWYgKG1hcF9mYWlsX3BhZGRyIDwgc3RhcnQgfHwgbWFwX2ZhaWxfcGFkZHIgPj0gZW5kKQ0KKwkJ
CXJldHVybiBmYWxzZTsNCisNCisJCS8qICJDb25zdW1lIiBhIHJldHJ5IHdpdGhvdXQgZm9yd2Fy
ZCBwcm9ncmVzcyAqLw0KKwkJaWYgKG1hcF9mYWlsX3BhZGRyID09IHN0YXJ0KSB7DQorCQkJcmV0
cnlfY291bnQrKzsNCisJCQljb250aW51ZTsNCisJCX0NCisNCisJCXN0YXJ0ID0gbWFwX2ZhaWxf
cGFkZHI7DQorCQlyZXRyeV9jb3VudCA9IDA7DQorCX0NCisNCisJcmV0dXJuIGZhbHNlOw0KK30N
Cg==
