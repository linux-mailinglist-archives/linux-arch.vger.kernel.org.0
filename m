Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61E636990
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 20:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbiKWTHj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 14:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239765AbiKWTHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 14:07:31 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020026.outbound.protection.outlook.com [52.101.46.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804B98A161;
        Wed, 23 Nov 2022 11:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLfu8nwEFoG3CR5GbM8kgW9zsuNYF5Wuks+LHX+QGIUHs25d3G3CWFzpoUkSwdo0/euzODLa4YsezG1/d5EGmwx4UKexA3lDj2Myi9ydgPWXKdTVffCddvm/N1uo9bcqfIc1N0pL45T4qgcwzDzRaaoA/Xqze2IIY2Bcf0r14wnYo+l6tCRU/kmLO/54qOFY/Cy/u5GocWJcBEmY2iyQhS51nLL0KON/pduOCGTGEE/IgScCO5/vjcUg/WHPkG9E1qUnCuGiV3iSBpqK2XrEAemWQkhs7Isgx3yCgnXQYRHEbIXRFz/6X/wdntwouF/B56fxBI/5PCs1RM0h34YK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U09ZAfLLrZ8NPL1uLY25ACkYBW0bx/QZQKyJ+LVyH08=;
 b=Cyd7XlxFo+7F7zozc+YVxTobzCckeqcplrnXcOW56ZCNJAbs4ogPPnvBQOG+97ORgpfeJ6XIB19Y9QwIFRPdToC2wIPZf9/oNumehhQ04k6nV8aAVY9TaWva+kdPoBbsH+rPNrii8JpeMfMEHxPTwAlSHFRFQZD1dRxQ9a3X3ATTbjMhvAYBItSXSFWj8JU4FyWymtKTGMWRE38/lPYgPaWSbOFqhbE5PIVGRopsGwMc1DMCyX/sGu1ykBOzdyClIE1idPsk4R++3tSlj2X+EcOTjuFTD3cgL3wdirBde5LYYKqZpt3pSmH7vGYHMgKr6au32GR87RCqxv9inwSoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U09ZAfLLrZ8NPL1uLY25ACkYBW0bx/QZQKyJ+LVyH08=;
 b=J0fKSIsnXeytvfaJiriIaqiSGLhQZyqhBS35jAQL32QkfCJBER/kj+RQVG9/8kjug2J/m6iWWoGCP14MV0fFiuc9sejJ6EpFG8XUHFIh+3mwnYi3kgVXSArA5fCXJp/szdhe9e5ef0Hat25STkKRMp9RwgjWW+h2fK3NdHYKB5E=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN2PR21MB1421.namprd21.prod.outlook.com (2603:10b6:208:1f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.1; Wed, 23 Nov
 2022 19:07:13 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%5]) with mapi id 15.20.5880.004; Wed, 23 Nov 2022
 19:07:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Dave Hansen <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/eSSvJMCdibbbUqzNA0JVsxn0a5LwurggAERRqqAAA1NwA==
Date:   Wed, 23 Nov 2022 19:07:13 +0000
Message-ID: <SA1PR21MB13356DD1B890854852AF92FCBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <344c8b55-b5c3-85c4-72b3-4120e425201e@intel.com>
 <SA1PR21MB13359D878631F5C327DE8148BF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20221123144714.vjp6alujwgzdjz5v@box.shutemov.name>
 <73407b18-d878-48de-167d-c23fa7e13e31@linux.intel.com>
In-Reply-To: <73407b18-d878-48de-167d-c23fa7e13e31@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=73a3b9d4-2ed8-4457-9659-aeaed232e859;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T19:06:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN2PR21MB1421:EE_
x-ms-office365-filtering-correlation-id: 173d9f19-383e-4d8d-368b-08dacd85ede3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8R94b9EHKqEF8kqBwdli8IHTBGeE5g7D8p4Mm8fUG5PHf00peN4If5/d0997+ITtKkY+YrQaoabYCDDzCLWdZZhRQVJT1H7NyCcMqI4Wy+bcknTicsfMFgDpeEXS4bbS8d187usIGHZzUjuFRUsBFfCYTgN/SXxKz4v0GzLd5lfaGKBAGtYZT8t8zQEVdgzq1CQgid1Q4QQmvbF8OH6vqZzNsqTcSnQoI1uA/3kf58G4y3U8EqqL/quFHEhIbNXSp3hCb4xkzQ9Tu0kmyVnEATK4NWEl2kzk9TP7+MMRqpkbkmE02tHzYq30+sPA+m0nxd2AycfInZLFMFBV2es94YHYOaE7sed4hadI4a097EkGmqoFNoU8pFKrG9SsRrnhpEDCkpNzUqW7uBoTudoPavmGFc9wXT7k29Gr8/bLMd/grjnqFXROYG5VKe6pTVlMCr8SsTS7DQ7BuBhinAE/k3EKbqldAFOEwqrODgUp97GXpua/sEdD+KF3Czy7DPAWeGKyY0FQ62WigeEGYcycPUsc2UnNtdmYm25c6kBsfOuMB/EbTPwhjDXCbXNcNWj/3OWTMe4ObxtcTtQPzzd4IqAPdlPRbq+Ff1jTUJ/i3GuUCKQieppyFisGJeXDpNkn/lXH4wNpxuGcg15W+dFs/ufsv/3WH/dyGH6ZiORofHlxw+I6r1xUDIaQceId7uBOyAgucJwibOi1ojBuYn3FsHP+b+6svYwly/ICDJxYHWaGJcLHCJuDRR1ThqsgTIfE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(82950400001)(82960400001)(8936002)(186003)(71200400001)(52536014)(122000001)(38100700002)(5660300002)(7416002)(10290500003)(86362001)(26005)(110136005)(33656002)(7696005)(6506007)(316002)(54906003)(38070700005)(41300700001)(66446008)(55016003)(9686003)(66946007)(66476007)(4326008)(8676002)(64756008)(76116006)(66556008)(478600001)(8990500004)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW5qQ3RKUWVta3BQcWtjMDRTL3dmMC9qSEJUZkRLOEw1RS9OMFZDZTl6T2dw?=
 =?utf-8?B?RzFrWnJOTXVpbVVJVzRmQVhQbWpIL3NBVnJVK2E0cmY4UmFIZWJHdytyOG9i?=
 =?utf-8?B?TzBxTFpqNFpHZm1xUC84NWQxNHBST21uWno4TXYzRTNmdzc3akxzd2NINkhF?=
 =?utf-8?B?d3Z0aTkwNE5LNGJIT2pVRG5oRWJyQmJsNFVhV290MWhWcllLTDQyMjB0Q25i?=
 =?utf-8?B?MjZZaFlSQ3RLMmRZWWlIdHlSTVdkOEFaQk5abVloYWcxdVJ0N1o4MkdnWTlE?=
 =?utf-8?B?bGNldkZRU2Y1dXlRYkVsdHlOQS80Qm12aVo3RHY0MTBDYjduNWZMbkc5WDFI?=
 =?utf-8?B?aEpOdmhYcEw1K3dkTUowVFNranM0cndPd0E5TFlmZThOckx1cUt4bjl5U0Y2?=
 =?utf-8?B?UlZvem9xUityZnpUL1dsT2l3V0hkZ29nYW5MYS8vNlFFTEVLeEJzMmZIaFF2?=
 =?utf-8?B?N0lxTmlCNlVqNjg3MCtNZmFLOHdXRWx6eG8waitNQkxxMFJGSVlySzBXQnRQ?=
 =?utf-8?B?bXlyeUdNSTRibDBIaXUwNGhPM3RwWm1xRFNTV0VDQUdzR3g2YWlTaksyVkZh?=
 =?utf-8?B?Y0tyaWF5Q2pUeXlpQ25GSkppWjIvNWkxMjYzT0Z5Vk9xZ2FCVDZTc3A1aDFa?=
 =?utf-8?B?Q004ejVod2M5T2wvcXBQM0hodm1oNU1pMlRGQnUrNEdpbzRZcGhLNFdKczVq?=
 =?utf-8?B?aXNNVmx2a0lYN2xyNFowc3JsQWpQYXJrTW4wanRoVHBFZzYzWkdDL1ZXd2pM?=
 =?utf-8?B?RkZRNzNBL1lZZ2FGOUdoVHo4ME5jZ2RTZS9qSGZWb0J6M2lrNUZoeGpQcHpF?=
 =?utf-8?B?VW5aWERtWVVzK1dESFR3R2ZSU1A2YXQyNXNqSHU1ajB3Z1VUS1VyY3ZUWmNC?=
 =?utf-8?B?cndDRG8zQUdGRFh1UzBZR1BVS1l3V1VWSmMvS0ZFNncwUklrTW1raW1VTEdy?=
 =?utf-8?B?VGt3b1dyeXBOL3lJaHZMMUpUdXZKSUNaV2Y2VHJFR0w4NUtHazExbXRZNmMx?=
 =?utf-8?B?N3J0WkMrS3dBME5NRmtxVUFhRVRrdEVEOTBweHA0bXFFV2M3eUVUbWQzcVl3?=
 =?utf-8?B?LzJYbW1qRXc1OStUTXhmM0xnZ2lQRG5BVHhlT1FPdTZzZ0lTbWhKSTYzZlNr?=
 =?utf-8?B?VTV3bTRmUDc3K2FvNythc0ZxdEFvaWZTODhqMUNoWG5pcDBVUGVIVkc3Q2Rp?=
 =?utf-8?B?bUV5TU84QVZJT0JpMTh6THNoNWtUUDNGamhGdEl1L053RTZNclFvdWJ1ejM3?=
 =?utf-8?B?ZnljZW9qOEtXdnNWcUJPTlFyc2V5a3l5YURJV2hteFNSaFU4dHE3TkpCcFBC?=
 =?utf-8?B?TzMwTUp3cDVpVG1IWDJUUkpzNlFJU3BzMDNrRWQyY1hzWk9VKzJwOC85YjE0?=
 =?utf-8?B?L2pEYXpnL0lsVmpHNmFXSzBKQmp0d2hSSC81bC95ZHRwNzhkZnVkck9XNmp1?=
 =?utf-8?B?OXIySGhpUVp3aEV0bDRIWXJZNXBydlRwS1N3bVJuazkzZzhoTkoyL2UrOUhk?=
 =?utf-8?B?TERqd1RvMUR2ekJIYmQzclRtWC9NRlBjOVlqZnRKTmlpOFVtUjJnZlJRblls?=
 =?utf-8?B?QUlKUFJIcVM0Y0FocXM5Uzd3Q3VtK0o1cHFuU3NDWkhxRWFqMlhlRFpGVUtK?=
 =?utf-8?B?OWMraUxNQ0c3OVhvUGJMMDBMRm5vMHBvOXlBMVIxK3R2ZEdJbzU5VlJPaGxk?=
 =?utf-8?B?d2VYYVNESkhVUUVIUkZRNUtmNDRyeC9xM1VrWnAyVXl0NGxUREQra2NIOXNC?=
 =?utf-8?B?ZFhvZ1RuVkpJcGFINXR3S3VPNjIyOGVGaWR1ZFZmTnIycnk1Y3MvTUxXeWda?=
 =?utf-8?B?dVNickxqOWhxT003WE1vdEdFY1phZVBKZnEyNnRxanlsMHpkd0VONDdET3Y2?=
 =?utf-8?B?dnA4KzlJVkRsMEdhaVlqbTQ2eVFpT3lLblNvVGljZWpiT3Y0bjVhU1kyZ2Ew?=
 =?utf-8?B?THR4TG55aGEwbDYvZjU0Nkl4RkM2WUFaRk1TcmZ4WlFpWkxpRENFTzl6dEFK?=
 =?utf-8?B?ekZudW1FckZucEU2MDgzOWZtalZrMVhqTEQ0aVIwVGN0MWJHUFU3ZVg1QVo3?=
 =?utf-8?B?UllsekZGa2xqd3h5akw2VkM1OUlwU1hzeFpOMVZSVXZaOXgxZ29wY04rWVkx?=
 =?utf-8?Q?/EUFBk1G+6LBuiU2a0km9pCe5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173d9f19-383e-4d8d-368b-08dacd85ede3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 19:07:13.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NfhhaRBJAWvD8QcmSlhpZb840WIBWEu9RQ1UaACdcs+XSeUFEhrI4B5I5kfmg/3tZU7gu6XHx9WZZ2Edj5KG+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1421
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQ0KPiA8c2F0aHlhbmFyYXlhbmFuLmt1
cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KPiA+IFsuLi5dDQo+ID4gTGlrZSBtYWtlIGl0IHJl
dHVybiBmYWxzZSBmb3IgIUNPTkZJR19JTlRFTF9URFhfR1VFU1QgYW5kIGF2b2lkIGFsbA0KPiA+
ICNpZi8jaWZkZWZzIGluIEMgZmlsZS4NCj4gDQo+IFRoZXJlIGlzIGEgd2VhayByZWZlcmVuY2Ug
dG8gaHZfaXNvbGF0aW9uX3R5cGVfdGR4KCkgd2hpY2ggcmV0dXJucyBmYWxzZQ0KPiBieSBkZWZh
dWx0LiBTbyBkZWZpbmluZyB0aGUgaHZfaXNvbGF0aW9uX3R5cGVfdGR4IHdpdGhpbg0KPiAjaWZk
ZWYgQ09ORklHX0lOVEVMX1REWF9HVUVTVCB3b3VsZCBiZSBlbm91Z2guDQoNCldpbGwgZG8uIFRo
YW5rcyENCg==
