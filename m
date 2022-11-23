Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4546369AD
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 20:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiKWTNp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 14:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiKWTNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 14:13:44 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2128.outbound.protection.outlook.com [40.107.94.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9267B1096;
        Wed, 23 Nov 2022 11:13:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAmt1JiQ7QPJjipfo7QMfMfJLcOUkuz0TDwka11QvEFjRCTMlVswpfb3lUjwcVLzL75BZ9StASdJENAejt1Id8b1x8re4CWYA24vhgW+sjs7zcdiHuGBEocFBr3TjTQ696WQi0B1n8nr4NJewfSL3DzzFUm360lnY5cJaIxf9WSva/wUw0Rq3Rxc3ygMzIiQMxGQkp7RMlozELLoIZ7hl3kRHhe35jCV6VsS3TzI7rQdYQt2qtLkur47B/o3pW12ec9ZP+prNxOoaQ2cuBAhTyiGMtX79RtoyWRADbohTQjSpd9AfsrOjUwkvPUw9AUCMHGaf927H0B9nK/2Rq3QpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWdDd6l/2O2VND5VnKFMa0kWarsqPk2BHjs7rLUOOhw=;
 b=QPrEaBYpimXeuGMaUrmnhEX9pQxGaq6bDEdBPityaw8n9JnLwPPSKSv4Gq2JZzTZlu73Ouy3jxndFArgPYwrD84O3PI6EYZ4qmGGfjFxlTjA+cqcP3EJ/yHSab9LRGxvAhGfg883Cpzcl7E5TBbdhHGdWBykhI18CzOYkHL3LMoTrS38IWewKagH8KoYffg50EzeFCoz/203bpbbONYni17DJyZ878gRL4qYl/JKGVmGH7dxz6qIMBTIrm47FJfUi8QXUS+QeI2nv0ltD0HQFijGitHYckBV1CTH0GgqEZTMQo9DKFMfVjsOKLiVZMzcUEVzoH7R0wl+b/cMBVpQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWdDd6l/2O2VND5VnKFMa0kWarsqPk2BHjs7rLUOOhw=;
 b=d2p2YuKj9BBqoqVL4Q7Bx8bBs5McMLGw8UHNYX+ZqMEaiB6VVueVZZhyukML9Qgd3ZJC607VSc0F/IwvNTTDijCaOzj4Zr08jJzcAnAMXc83YoTOxanYW/mQaba2HM7zUPR5VFQbhH0UxoAnhhSQOnszDwY4AvJtq3TABlb/yHc=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by MN2PR21MB1421.namprd21.prod.outlook.com (2603:10b6:208:1f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.1; Wed, 23 Nov
 2022 19:13:33 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%5]) with mapi id 15.20.5880.004; Wed, 23 Nov 2022
 19:13:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX
 guests
Thread-Topic: [PATCH 4/6] x86/hyperv: Add hv_isolation_type_tdx() to detect
 TDX guests
Thread-Index: AQHY/gnkWonWlqfL7kGkMye7Sjr9Uq5M4NNw
Date:   Wed, 23 Nov 2022 19:13:33 +0000
Message-ID: <SA1PR21MB13358502F5B2FA15A7C9C4ABBF0C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-5-decui@microsoft.com>
 <bad51bc6-c52e-dd71-1ee7-7f64140eadfb@linux.intel.com>
In-Reply-To: <bad51bc6-c52e-dd71-1ee7-7f64140eadfb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6af93156-1bc6-458a-b9b4-9af8185ac2d5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T19:04:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|MN2PR21MB1421:EE_
x-ms-office365-filtering-correlation-id: 8b0a0eb4-a114-4fbd-6fc6-08dacd86d064
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xgjw39esqIYDbmhhdGM/oarLFJBsYscp/w4jStuyDQ+KV+UhpsT1xCKMiPavIyF4P1fAy3H/6Se3vrJOwP84KOMa/MivlBUDOgXnwlobRIFE2+FPbkSIs7zlk+3YkTPLEPNNb1hn2unwCFD120c4AWlSmnSIhtgkEaEdG094VhfKUHGC0RvX958mZiM7SkJpPJpvtB0Xhe6u74i+HirGcTzzw835JH6Tb8DjhDwqfKh6MKrfiti8LtPetjRywc/iOUiSXEuvWR++TINB5MPZ6a6ezUnprIQSEUk+hMrtc3+SM/hWv8eElavaHjN/FNXIV1oPhaTFusknFp3mVfTuHvDC5Rn1SXi9Pe8H83+aojlESpZUdPkRUYuy4YbjUfgWqVqKJYqDJE4Y2+Bri/3R78K3dQMQaIEk/970imUROYH6ImIw+X4rt8LkJ1lG8skjsVX1bFIqDpVyCEPa6Yu9rRl651appv3gMbyLCfgfWJSgZhpxGNJ79CECzZ3EtvgpXHV+Z3QxUJnnO5rlCpsvsNgflUAHLrfBdMD4W/N07kS5IoGgUO49ni4agobYT97GXL8JeOTD26PYqIRWs2LBKdoPhpk5SAmcWPtKJQzZDVTMwhJodWhy7tlSYoPyakjEAe2MLvrUbd4GBM2BV4xQmsBnof0MN0yCyRCsdY5cFXSjqK01mJfQsm0cvSqP0wR1v0KWKikxTvUY7Tjj9R++N6KPG019bq+gNYQLNMjPUJ77/qab2UjPKIosegyztdcHCx+p2KC28d4IjYIMiXdX6/9T5Y/HRuZzhS6M8T3BBn0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199015)(82950400001)(82960400001)(8936002)(186003)(71200400001)(52536014)(122000001)(38100700002)(5660300002)(7416002)(10290500003)(86362001)(26005)(110136005)(33656002)(7696005)(53546011)(6506007)(316002)(921005)(38070700005)(41300700001)(66446008)(55016003)(9686003)(66946007)(66476007)(4326008)(8676002)(64756008)(76116006)(66556008)(478600001)(8990500004)(2906002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWl2ZSszQm1zWmpwZ1RDSDZTV3FQVGJ5U2dHRHVCaTFXeklHNW5rMnYwbDdZ?=
 =?utf-8?B?c2VtenNnVnBXZHJZNURiN0VRS2pqZndaM3lCajArQStIa29VeWNqOGxGUmxk?=
 =?utf-8?B?TmgvdmQ4aXlpbFJaaW1BYmxzTjBQOUg4V0hRWEhSTk14YXo5VjN1Nm45R2dj?=
 =?utf-8?B?TldhSWFoQldlZW9BTzRBazdCZk1PVUJ1R0NXeE5YR3FuWHFLVW9hWTUxK0Jp?=
 =?utf-8?B?L2lDQlR1WTNHWlVYSkVIbVF2T0dINURkd2lhZEpVZG5lTE51NzhOTFMwdzh2?=
 =?utf-8?B?RjVPRUMyK2g5T05jNzZRaEIvUUpMN0Y3WmMyRGNZbjVqOUtCUm56aVloTlFu?=
 =?utf-8?B?Y0JHR0VyQXhKZWZpSE1hTUp6ckRlWXlYdkl6OTFIWEI0M1liZklvWmJCQlEr?=
 =?utf-8?B?aEd6aDI2WmxUSjNtL3hQYTgraHB5WU05VTBEbkdJZEEwVlY2RVNvN1d3Ynli?=
 =?utf-8?B?MEpHSXRPbUJvZytlZG1RSWhNVDhyYlVhN0hZRm93ZzdKbU5aTnlEclpQelpF?=
 =?utf-8?B?dHAzQ3BOTzBOa050bHIwQm1GVXJwckUwOEIyRzhRNGE1Zk1Fa0cwTmlEV3Jh?=
 =?utf-8?B?Q0hLY285TmxFb0hFVEtDMHVjMHh4VUFhK2t3eEtpR2R5WFR2OXkxV1pSREFl?=
 =?utf-8?B?S0t1dmpma1dJcFFEcEM2UUFTMkxSK1dUb3VXK3FKbHhXbVF3eG1mbU1UNlgv?=
 =?utf-8?B?QzlSZXA1ckVRTW9jTjRzd2N0azVpL29ERVZNZ1ZXUWRlSXdYVjdiWGR4VkN1?=
 =?utf-8?B?T01mZ0NZN0V4bXlxNVlNY2VoMjlwUGU2THBRTHppYkFBYlU0WWc5b1hVbUpD?=
 =?utf-8?B?VE15NzZISHVRbUVINVRKTUgvS2haNlFNdkozZ1lBNDNFOVI3c1V4amhqM3o0?=
 =?utf-8?B?eXhDVWVPbnF1NmFJV0dQcVo5ZkZNYzRpNDZBSk5VNDhtRFBrQk8rNVlPMGFn?=
 =?utf-8?B?Tkg3RzBtOXJ6MkgycE1CMVp0WTVwaGlXOVpNd2xiK25zazArNStYZkNSZkRK?=
 =?utf-8?B?SzZOZWN1WllKRTA2UkZEMWVRVWRLeGkwVUx5YnhtcUpVMEF0amkwNWx2Q1Bw?=
 =?utf-8?B?THhqSU93dTBobE9nNWRGMU1SQStIbmNTcmRTVWt6UzVDOTJSV2d0eTJhd3ls?=
 =?utf-8?B?Zngva2dvRjh5aGJsaFBKanhjUW9pRHcrajZHV21zWk96RTFxK3NWK3k0ejV5?=
 =?utf-8?B?Wm1nQ3BoVkI3dU5lK0ZWNnZ1a2JiZU1xWEtwTUl3S295OFZKeDFOcDA3RjE4?=
 =?utf-8?B?OFI2Vm1JQThZTnhKWkJIWEw5VXRiNkRnSi9yZ3hteEJUYWxkN3BtaHlSTGxU?=
 =?utf-8?B?Z3VsTFZJR3RQb1kvcVlJTHBKakh6SzFVakpyNExjbkFHTGRpcjRQMDRlYnVC?=
 =?utf-8?B?Wm1TRW82OWJQWjhKSHI0bkFIazJRQzdqVXFkbm5HOENhV04yc0k1RDRtaHNh?=
 =?utf-8?B?Mm5JYUVvY3E3YmNFbW8vTFFab0pPbVNkNTNDVzJLK3BFNFlWbDB0ZzNORWVO?=
 =?utf-8?B?aUVEOEd6azZlNi9MRGtHZFZzbzJOTmhBSkFHZGxqN0ZYRTZsVCtkVXZZL0ZW?=
 =?utf-8?B?WDdNdnlPaWY3dXRPRDBJOUQ3QVQ2UGRxejhPMXE3TGVFODIydi96VWpmbWtC?=
 =?utf-8?B?eUNtZlhnZDZXV2hObmNES1FubEpENWdQZTVnZk52emlUOW5OQ1M3T1BQckVa?=
 =?utf-8?B?QUszNGcrUzg4S2RFN3oyaURLbURVOGNHZW1YYVpKQkoxVkhIanRwbVVxRHVJ?=
 =?utf-8?B?RFFOS1EwdTJPd0luTm5DaDVHUDNKL3BpaGV6djVMSnNWZVRNYXdXNnR6OUha?=
 =?utf-8?B?WlUzTmpPZVFRNkhqM2hFcFdCS2ZuUlpNa3dQV0xlbVlvZmI5d1JCcEZsSkdm?=
 =?utf-8?B?akJnNXE2ZEZmelM4ZklTRm1CQXloZGdLNjdCQW0yWG5vVG5jZHV3UG9wSHpy?=
 =?utf-8?B?eVp3WTl1dDRuTXZrVXh2cTgvWWNFN283cTJqK1VwK0JjUTJyc2tGNkhVY0Ex?=
 =?utf-8?B?c2ZXR0xDL0tuTU9BTnhiL2d2UkR3S2NmaU1UL2xQL3F1QXo1VkZiMkFzUmg3?=
 =?utf-8?B?bjFMYzBkdWR1Z09oUEtTL2FlcnJSVHU3bSs5SzJUZ0ZGMFB6L2hxOFR0SmE4?=
 =?utf-8?Q?GHwlminjPXgZVZtTNkUtUCRUr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0a0eb4-a114-4fbd-6fc6-08dacd86d064
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 19:13:33.1576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiYVKnULOlQBqK6g5y9NYsNyvo4ozvt2mgYfHJBHOQ75jwAftfaC6asvEGDAR3u4n0+yApwZRnvqbMFQaHc5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1421
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQ0KPiA8c2F0aHlhbmFyYXlhbmFuLmt1
cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KPiANCj4gT24gMTEvMjEvMjIgMTE6NTEgQU0sIERl
eHVhbiBDdWkgd3JvdGU6DQo+ID4gTm8gbG9naWMgY2hhbmdlIHRvIFNOUC9WQlMgZ3Vlc3RzLg0K
PiANCj4gQWRkIHNvbWUgaW5mbyBvbiBob3cgYW5kIHdoZXJlIHlvdSBhcmUgZ29pbmcgdG8gdXNl
IHRoaXMgZnVuY3Rpb24uDQoNCldpbGwgZG8uDQoNCj4gPiArREVGSU5FX1NUQVRJQ19LRVlfRkFM
U0UoaXNvbGF0aW9uX3R5cGVfdGR4KTsNCj4gPiArDQo+ID4gK2Jvb2wgaHZfaXNvbGF0aW9uX3R5
cGVfdGR4KHZvaWQpDQo+ID4gK3sNCj4gPiArCXJldHVybiBzdGF0aWNfYnJhbmNoX3VubGlrZWx5
KCZpc29sYXRpb25fdHlwZV90ZHgpOw0KPiA+ICt9DQo+IA0KPiBEb2VzIGl0IG5lZWQgI2lmZGVm
IENPTkZJR19JTlRFTF9URFhfR1VFU1Q/IElmIG5vdCBURFgsIHlvdSBjYW4NCj4gbGl2ZSB3aXRo
IHdlYWsgcmVmZXJlbmNlLg0KDQpXaWxsIGFkZCB0aGUgI2lmZGVmLg0KDQo+ID4gLQkJaWYgKElT
X0VOQUJMRUQoQ09ORklHX0FNRF9NRU1fRU5DUllQVCkpIHsNCj4gPiAtCQkJaWYgKGh2X2dldF9p
c29sYXRpb25fdHlwZSgpICE9IEhWX0lTT0xBVElPTl9UWVBFX05PTkUpDQo+ID4gKwkJaWYgKElT
X0VOQUJMRUQoQ09ORklHX0FNRF9NRU1fRU5DUllQVCkgfHwNCj4gPiArCQkgICAgSVNfRU5BQkxF
RChDT05GSUdfSU5URUxfVERYX0dVRVNUKSkgew0KPiA+ICsNCj4gPiArCQkJc3dpdGNoIChodl9n
ZXRfaXNvbGF0aW9uX3R5cGUoKSkgew0KPiA+ICsJCQljYXNlIEhWX0lTT0xBVElPTl9UWVBFX1ZC
UzoNCj4gPiArCQkJY2FzZSBIVl9JU09MQVRJT05fVFlQRV9TTlA6DQo+ID4gIAkJCQljY19zZXRf
dmVuZG9yKENDX1ZFTkRPUl9IWVBFUlYpOw0KPiA+ICsJCQkJYnJlYWs7DQo+ID4gKw0KPiA+ICsJ
CQljYXNlIEhWX0lTT0xBVElPTl9UWVBFX1REWDoNCj4gPiArCQkJCXN0YXRpY19icmFuY2hfZW5h
YmxlKCZpc29sYXRpb25fdHlwZV90ZHgpOw0KPiA+ICsJCQkJYnJlYWs7DQo+ID4gKw0KPiANCj4g
SXQgaXMgbm90IGNsZWFyIHdoeSB5b3UgbmVlZCBzcGVjaWFsIGhhbmRsaW5nIGZvciBURFg/DQoN
Ckl0J3MgYmVpbmcgZGlzY3Vzc2VkIGluIGFub3RoZXIgdGhyZWFkOg0KaHR0cHM6Ly9sd24ubmV0
L21sL2xpbnV4LWtlcm5lbC9CWUFQUjIxTUIxNjg4NkZGOEIzNUY1MTk2NEE1MTVDRDVENzBDOUBC
WUFQUjIxTUIxNjg4Lm5hbXByZDIxLnByb2Qub3V0bG9vay5jb20vDQoNCkknbGwgd2FpdCBmb3Ig
TWljaGFlbCBLZWxsZXkncyB2NCBhbmQgcmViYXNlIG15IHBhdGNoZXMgYWNjb3JkaW5nbHkuDQo=
