Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6212F7642E6
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 02:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjG0AT1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jul 2023 20:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjG0AT0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jul 2023 20:19:26 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF55212B;
        Wed, 26 Jul 2023 17:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LinxJAYeMfvIhkXNApQU/7i6l3mCfCW0KLKdnTldGoas4OLy7dgHSYPcfOTDQ17C2UkW4ivJoCWipAPrNgxxscD7oEzVuD6KIYbcB0K4M9qNQvpPuPlW+d3nUl1BdPLQEZNfpsJTpozfTTe1Qlacc3GPzXhGLBPhD+zz+BT+UaJjLIu0cI5sQsY28Mau32loBl7D9ob1xLqjKB5oPSXCxI5WbKuWB8j7Cw2sxz/0IbO6T3AswkMbp+LJLBH/qrgcbHrlCvAG5v3ygYz2DpZpqGjohbU3kt9LhtU4yEmusl9X8OspHvR31VCSUnhxLa4B9BJkm8mUFLGorPm9iqvdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDLsSJ/C3qayPGxnKT++SbkPcLCanQvu6x5J+1mfjZY=;
 b=FJ5u1oZ1VNj/Asx8ObKRuZ5ygji9b5GGye5hrVs1DolwvrnHIMLnbuaBtBnb5NA6eqNB5re5R7sUNgcd8+6CqaXkPdy++9lMdt6KULuS/YoCgn3uT/a0hLGC0spJg2a7tao0oxmAZjUq1HNqNqHB54P0f9TNKbKUXNVoyzvOg2kjkCHTIm/dglXJ18JAm0dIRn9qmMEJ5eXZ8Kzv9s50cGlsp8Huqyqa2GLc5jU6oL/3lg3YtJ3BZmhfUnfFcEcK+0stLCl7ilC5Xp9ORsxeicWJwEJy1wBH8rxdd7F5g1WhVUqQZqzJQxNUAf/nBbkn/bL7xhqpEg0s/EkFW+5dCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDLsSJ/C3qayPGxnKT++SbkPcLCanQvu6x5J+1mfjZY=;
 b=bavN9furCzGgSjo5wXmZwZwj7QlFJ/9SqW+K+NZMM51EWI7IjNhlMJciaIAl+adeM/JWvM5SQHrP1ycjseZZggLckxKLX6hEUv9FQJJJYM85vk4Ot/7Rsl7Ok0OdYMoBLateB/mT6sDUcLXjXZU48Q7XOyizYm10BxUpeSjlZJM=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SA3PR21MB3935.namprd21.prod.outlook.com (2603:10b6:806:303::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.3; Thu, 27 Jul
 2023 00:19:21 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::49e7:77aa:3b13:3b3a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::49e7:77aa:3b13:3b3a%6]) with mapi id 15.20.6652.002; Thu, 27 Jul 2023
 00:19:21 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
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
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH v9 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH v9 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHZuekbpm9TI9uRk06pqBaiLv7fRq/Myu9Q
Date:   Thu, 27 Jul 2023 00:19:18 +0000
Message-ID: <SA1PR21MB133579BEE517A6C414BA0876BF01A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230621191317.4129-1-decui@microsoft.com>
 <20230621191317.4129-2-decui@microsoft.com>
 <e3d2c81f-16e9-9a62-9fcb-d9552c3f12d2@intel.com>
In-Reply-To: <e3d2c81f-16e9-9a62-9fcb-d9552c3f12d2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab62221c-46ae-4fb5-b575-ebf348e359ea;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-27T00:14:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SA3PR21MB3935:EE_
x-ms-office365-filtering-correlation-id: 4709d65f-e10d-4061-7213-08db8e371e2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZOxW7PQ+yjOE3UQW7SaZTliaxGy0UNBLLDmTyJac5uqdoC/lQiE7kwj9GqiEpleJ2yCtbojlMYyjZqSg2EIflkicwbetXXc1zyu5LPENhYzlLw6amulN4yV5qhCPKtOw4oyNOK9C8VfDodalv7Y7mvG+1de2x0tVLyKCko50JYchpunklNJV2PC05GH3ObFf+LAGmxK+tyrwIjCvVbdtcjwvpKf6lUG4R4lfPhfsA//N2okRasv79o6vV5PDACTqhM8WKcgxs7yYHxSjPY3QvaOXBSZahV5EJnKTE8EHuURKaNQeeoBHVJRWdPiSLeGDlFcaFaOkEClBX07CeFO07eQeD3oFbDQGXljEVjl+tv+I5W4Uyhql7Nwq6AxLKYDbb/+XudShW/G32DH4sxLCBYZ7XUuy0JeDnGp6x6XR5RdXxy3Obvbp6jQV7t9nWs6wQ936hAdL3CYaaptMCQ6sVpxS4qv1u08HA33b7Af1osl/Mv9ogUp+v2AlqL+JYt7lkV+CdZ2LHYKypda/YrLVVO4pi6EjecCHbo208Is2y/fVievwj0l1jyoMA0PTb5iM8KY5v1EG/dK+05zdO+jWJrndxjdkhX4YERpjWmSMbvc+nYidwcR5BVV2/Y9JJB9A6Iv9pm19lht1wB5WTwHuvxCcpvTAhDtHzCbDeMjy3FrrhQ8QWxlQlaglKSTtmFGL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(41300700001)(6636002)(4326008)(76116006)(4744005)(7696005)(64756008)(66476007)(66556008)(66446008)(66946007)(110136005)(8936002)(8676002)(316002)(54906003)(7416002)(6666004)(71200400001)(10290500003)(82960400001)(5660300002)(55016003)(52536014)(478600001)(2906002)(9686003)(186003)(82950400001)(86362001)(122000001)(38070700005)(33656002)(921005)(8990500004)(38100700002)(53546011)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXBTMkJQM3c5cHI5ak5CcldVNEtRUmVQSzFJblVpc1FsT096RWY4ckV0ZkhT?=
 =?utf-8?B?MThMYmdyRzBrdG1XRFV1cmw5SDFYc0FDcVI3bVNZNlIwSlV0Z3BJV1JHb05x?=
 =?utf-8?B?RDhRRFFtSFg0MHhXNjNzMStKVk5aWS91M1g2QmFnd1YzQ2JNSDNnbHVKZzRN?=
 =?utf-8?B?SHdtelBrVktHVkZOL1VEREhqb2tLQjJQd1RaN1J0OXFSK3A0TUMvaVdmbWxM?=
 =?utf-8?B?QmlENXVQSE5kMVB2MTFOZ05sdmZkVWVlNnJzMmZHRWphUmlaRkJyMURxNnpy?=
 =?utf-8?B?SXBGSExSZjU1dU5kLzF2LzZ6c01vOEVleU1KMlpNbE1GWWtxQ1JVYkZ3cUtp?=
 =?utf-8?B?aWpoZXlrZXZKRlZtNXlkTEtCd01LaVFlVkowQjNsNXU2U3NKb29lL3NrME5N?=
 =?utf-8?B?SFpYamdYRlNScVQ4b1lsQlNYbm5Uc012NnppdUo4TXJZM2ZiRGJEVUQxaDZK?=
 =?utf-8?B?ODQ3RzRrSGdmQ0tjUy9GT3hSWEtPMW1OV1JtY25sSGJWQ0UvWDNTTXF2Y09i?=
 =?utf-8?B?UjM5cTFFRkZ3TkEyZ2Y2amRiMFA1dmRWOVVPaVlXNjZVVDVJblNyVm5aNXQ4?=
 =?utf-8?B?WXltMWhpWmJob1ZMb0Rhd0NGaVpCeXc4Y0tTSnRSbDJHVGFwaWRJSUhiQ3gv?=
 =?utf-8?B?c1ZndlkvbjhpUlBId01YY3BQWEtYd0Q3N3pQVnlwbHZVa1ZOL0o3V093aHY1?=
 =?utf-8?B?dTROOVQzV3lybVR3aXU2bUNrQkVieVlkU3JaTVF3bVFUbU9nekNHS1gvMEZN?=
 =?utf-8?B?aHJmTzhjOVR2b3hURllrK3NtZGFhMFRZRUJYRGM3UTY5NnNLcmQ0aU1nNFU5?=
 =?utf-8?B?M2lTRTU1RkhMQk9vam5QMzVvQ3RvK0V6eThCRmc2WGVXSXE2aW9VRFhDVXIv?=
 =?utf-8?B?TjJNWW55VUpSZllFQ01hMGwza3BhczNTRmJXT3B1THZmQkJqNGdyT25lbGVU?=
 =?utf-8?B?N2hGaEIvdEZXbEg3LzUrRm1tWXNDQkxET011T2l3ZSthVWhrK0RLZDV5MzRI?=
 =?utf-8?B?alEySStPRzVnUFBRazRDRElVZFN6RTRNMmtTN05IcUc0Y2twZ3hoenRrZEFi?=
 =?utf-8?B?anpVZFpvY3hMM21xSy9XVjR5S3I2MUtzUXg4VFU3bWZoRnFheVZUUDNXaVkz?=
 =?utf-8?B?MU5BSkMyL1VvZGl4U2dkWWJ1SFdnamxXR0tCNGZBK1Y5dVJ3RC9tM25aZ0tw?=
 =?utf-8?B?Q2JuQmlLdStwTjFMV2UvQXBMREh0QjNrUXFzeG1TWHpBMVVXQnJEeWxacTlq?=
 =?utf-8?B?Y1JRVnRuYjJMV2MybnViUlJDOFVZUGMyY1RwKysvdlpEejl1cGo5MXB1NXFS?=
 =?utf-8?B?VVRFcFFadHBHUUJ1UVpqTXkxR21tZGNRSy93enpwQTNMY3B3Tm9hK2d4NURV?=
 =?utf-8?B?NGYzK3ppaFQvSXpFclhhUElON1AyUUFmdFhsVjhmU3VUeXpWS01XQStiRDht?=
 =?utf-8?B?YWlIZ2c5b200Y1h3dzI4R3FqVDR3MGtuZmJzVExFQ082UXhDdlkycEFid1NJ?=
 =?utf-8?B?U0VxYjRtVVRJRVlwbmJIL2ZLaFBNTWJNUWRFNzZWaVRhTFpwMERDeW9JTmo3?=
 =?utf-8?B?V000UjM2bHREOUh3aDZoTHZkVkhDQjBEZ09MOG14Y0NPQ0pnUk1SUTR4d0N5?=
 =?utf-8?B?aU5QdmRGdnlTNFdtS2MwQlVscW1TeTY4YUh1ZUNOajZ0amRJMkptUjUzM2ww?=
 =?utf-8?B?QTlYTHBnR3NGT05mbE1mNzdGbG84WU5QRTZhQTVkQXQ4dFZDaU5ZT1JyeHYw?=
 =?utf-8?B?Q0Zmc1lZY1NHTVdSTThYRzJ6bFZiRytLWkxWQUtiTWtDZXBFL1M1YW5pMmg1?=
 =?utf-8?B?eHl4SGVrRXk0aU1YM0g3UnNWQm1TMS9ZbTRpcjgwN3BpcXEyS3lraWFWY2FC?=
 =?utf-8?B?WjJVdzZOZFZJUTNMZjcxREVzdGg0N1dWamxILytHUkcvWm44TEhWam42SXpR?=
 =?utf-8?B?SFlwcFhOTkM2eEt3dEtLY3o0Z25nVXlRYnJGbHhyeFUyMGxIaTRFd3RuYmtH?=
 =?utf-8?B?OFdWaE9tZFZXNldtMEFiSE5YWW9SYlVsQ3pZNjJLekVTem1PNTN0dzdyRUV5?=
 =?utf-8?B?bVF4eFdPQ0RobjV6cUNRNVVqcVdILytoRTBWMml5eHZORURmSUNDVmp3dHhh?=
 =?utf-8?Q?oD8T+UTN0oyjlvTdpEox3otHI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4709d65f-e10d-4061-7213-08db8e371e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 00:19:18.3654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QMT/GKCJE/jaDmXUj6S74cZDz3Wf61m+mlIeMgK+GWr39vb1Pm2XMx+BSDdOQY77XXtgWWiE/xmZZeli/4Xwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3935
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBYaWFveWFvIExpIDx4aWFveWFvLmxpQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgSnVseSAxOCwgMjAyMyA3OjMxIFBNDQo+IC4uLg0KPiBPbiA2LzIyLzIwMjMgMzoxMyBBTSwg
RGV4dWFuIEN1aSB3cm90ZToNCj4gPiBHSENJIHNwZWMgZm9yIFREWCAxLjAgc2F5cyB0aGF0IHRo
ZSBNYXBHUEEgY2FsbCBtYXkgZmFpbCB3aXRoIHRoZSBSMTANCj4gPiBlcnJvciBjb2RlID0gVERH
LlZQLlZNQ0FMTF9SRVRSWSAoMSksIGFuZCB0aGUgZ3Vlc3QgbXVzdCByZXRyeSB0aGlzDQo+ID4g
b3BlcmF0aW9uIGZvciB0aGUgcGFnZXMgaW4gdGhlIHJlZ2lvbiBzdGFydGluZyBhdCB0aGUgR1BB
IHNwZWNpZmllZA0KPiA+IGluIFIxMS4NCj4gPg0KPiA+IFdoZW4gYSBmdWxseSBlbmxpZ2h0ZW5l
ZCBURFggZ3Vlc3QgcnVucyBvbiBIeXBlci1WLCBIeXBlci1WIGNhbiByZXR1cm4NCj4gPiB0aGUg
cmV0cnkgZXJyb3Igd2hlbiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIGlzIGNhbGxlZCB0byBkZWNy
eXB0IHVwIHRvDQo+ID4gMUdCIG9mIHN3aW90bGIgYm91bmNlIGJ1ZmZlcnMuDQo+IA0KPiBqdXN0
IG91dCBvZiBjdXJpb3NpdHksIHdoYXQgc2l6ZSBkb2VzIEh5cGVyLXYgaGFuZGxlIGF0IG1vc3Qg
aW4gb25lIGNhbGw/DQoNCkluIG15IHRlc3QsIEh5cGVyLVYgY2FuIHByb2Nlc3MgMSB0byA5IHBh
Z2VzIGluIG9uZSBjYWxsLiBNb3N0IG9mIHRoZSB0aW1lLA0KSHlwZXItViBvbmx5IHByb2Nlc3Nl
cyAyIHBhZ2VzIG9yIDEgcGFnZSwgaW4gb25lIGNhbGwuDQoNClRoYW5rcywNCkRleHVhbg0K
