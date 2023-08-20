Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75149781C9E
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 08:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjHTGYy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 02:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjHTGYs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 02:24:48 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020026.outbound.protection.outlook.com [52.101.128.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC2D2782F;
        Sat, 19 Aug 2023 22:19:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVnCP6S2ucfQ7CD6Sq4qdj51N9es1bFAfHFQgKt7jM7TmwwqSoQ6rAE6McU5VXQWXbRo/pMPErZQblvttxbc+TQ1J04gQbKhurX0JCO+zE2ZdUnrRcWMAtojvNkzvszEh3CxfaGGqXcjnK5p0btCaiMnoeIPBv7inx975XIQ0uCWyv4oRbcrI1cFXWtELyf7Vlzlqe1YTVFCkM6Sk5ZyWpUyG/lzLCTZ/0EKBJLoWUGA3+pscQWjJjCjrFfbnY72xbWiotcCvnZ1qODO586fUBrQEQuNzklwBl0eDFSFfUpb0K9fx6hOR9UK+uFM+TudnQRAWC7vax4afNJDPhylhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5sucshz072AsP4dO4gV0m6DBYQ5Ig6nZbsaUSCCz6Q=;
 b=VsiLBCc5/Ph8LPcgVwEkIPNJpq6kmKexenhMf1W72PwbHdy/hFIGs7tq3muHT7ly0aUkrjVhlNI6TmQ5Rs181/KdBcUFlHshgI0L4WDYrCUTsDjOQv8uziaX8azcpQOAFQAZchFhPLMwttZ920MgFpXg70rqybHExSJ3ZWLLEpRuCt8h5RRol8xxYTvMV3RgHr4ofOJC5tADM7FU5S12OqvaBAxXR+zw1LM0qfTVLmb0uM1XHGTG0L6rxuictjZMtYzlzVPbhA/ZXUIiLL5NJZa/IXs9yPZhnLGUtMssQpaSPL1tj8xRjAaU3UqEukJTEmsy8Db106EdtthPtvELZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5sucshz072AsP4dO4gV0m6DBYQ5Ig6nZbsaUSCCz6Q=;
 b=W14N5NnpNVJxHInuXaDGMDHkSEJCUUuC7O2ucFifAFDoQMERr/jpPMad5BR9L9BrFGU7XJGIih1FCcRZ2m2lpgroVUgBfPuBabm0wfCFzCTMJAIDKKKuZOUMZnETVS8r1HMQTI1QSHDhzcsyZetf4NhTgyGBqcZxKvRI82M1/aI=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 TYZP153MB0494.APCP153.PROD.OUTLOOK.COM (2603:1096:400:58::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6723.11; Sun, 20 Aug 2023 05:19:52 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6745.000; Sun, 20 Aug 2023
 05:19:51 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        MUKESH RATHOR <mukeshrathor@microsoft.com>,
        "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Thread-Topic: [PATCH v2 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Thread-Index: AQHZ0VZ96EEPB9Xi80mUoj983vpcr6/v7KBwgAB88wCAAjguIA==
Date:   Sun, 20 Aug 2023 05:19:49 +0000
Message-ID: <PUZP153MB0635A9EBE87C3589612B628CBE19A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-16-git-send-email-nunodasneves@linux.microsoft.com>
 <PUZP153MB063545036E6B547C009F6AECBE1BA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <664aec4c-7ea9-447f-afab-9e31e9e106c1@linux.microsoft.com>
In-Reply-To: <664aec4c-7ea9-447f-afab-9e31e9e106c1@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2d523610-1953-42eb-9926-c0dba99793cc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-20T04:53:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|TYZP153MB0494:EE_
x-ms-office365-filtering-correlation-id: 7a73b770-e25b-45a2-6a50-08dba13d1399
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VyAfttaG2JjuXqSmnV2m1MsxUYXTsW5wKzgfq46aPVLzKBC86Mrn1dAyQZF7oixcs3nHNiI3QIYPJWRW9Pzf61Od1/7ILxnx2bvLVm5x/WDQnL271cxeCj1Ye2W7DNAPjTc6813tlsdY0icxCo8+u0zm1Ew/h7e3UYFHBuNX8Ci6AL8cxhcN78JoaW3JtkGjS3u7kAFFlT5Nm8ef/81vwG7XKjcAaCkMvELNWwFVP7KWnvni4k9CO87HOBzTjm8motzYHBIompsP83IjQroWAWPd40Vh0G2CYp6LgJCTKA+S7InN2r4Dp6R+/fw3VLj9eJVN+TNw06nkXskz8zHGTJr7T9/Et2WeCVJkzGySxTD2odSGzAlDTV0XGRjL87mgbyLx9gBPTKxsseP6VPuS/o4HR395LnhT234E7uA5eKG3rTWx3Fd/qQkg8rWo8fInDbZ/3npV7auWhhhYwO0DfEgtVgK5a4DRzzBEZzonHvD5nPg5nmyHCXNPPtCJM05uZVcYPXgOcQeiGNDiPRpA2H1FZlQ/3f2xj4R8eIX4NWJWZFC9owELdnXF4MJcE68Mgt4UrlWkUHZBSkb/PIjB9w7HcdPROSkz/zSanb4k20FQhutJgctx3N6hmpqHE8KjNLzcX08+50kqEM4sFqrY/L7eAqPwMXGA79Hyw/jcEUc3Dq+nTznEV6VadTyKdJYZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199024)(1800799009)(186009)(71200400001)(7696005)(53546011)(9686003)(6506007)(83380400001)(8990500004)(5660300002)(4326008)(8676002)(8936002)(52536014)(2906002)(7416002)(478600001)(10290500003)(41300700001)(966005)(76116006)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(316002)(66946007)(38070700005)(82950400001)(38100700002)(122000001)(55016003)(82960400001)(33656002)(86362001)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGlWQkk0TTRqTmc2ZDQ3QWtnd1BqL24xUExQNWx6UFVYaWwvUldVem9IdjBv?=
 =?utf-8?B?VXNIeS9CRjVVMldrMjNzUi9GQ1c2V09rK3B1VFZ5bGdGcUppN1JvcC8zT0kw?=
 =?utf-8?B?R2MyQW5vb2dJdDJ2YThDZ2U4c1pQZTJRSi84STdwVzQvdGZsbktZcXVJa05n?=
 =?utf-8?B?Z0dUOFc5dCtkWjRTTm95ZklGaDFMSCtuT2hkVHRUZmJQQTBOcmdzOXBGekhx?=
 =?utf-8?B?OUI3RXd3Rm55cStJQUtMeUl6Vkd1dFZDKytjN3AwMmhKTWI2NldjVTlxcVJC?=
 =?utf-8?B?ZEQwRzdYWEh6TEtFaDJzeUFUYWJ0Z2d2MzloQ0F4cXNWRCsxMGtTOUpaRGRj?=
 =?utf-8?B?aVgxQWNMMmdKZHUwRVJGZDhJRXZJSnZkcGloNW9IU1NxZ1c3RUZMUWNvK1p0?=
 =?utf-8?B?Rmx1WTNaVjNST2ZObmREcW52ZGZYejU3TmdTMTAyd1dMaGQ3bkVLQ2hkMGc4?=
 =?utf-8?B?eUhiRGlJVTQzb25VV3BiSFhRR3cyZXNmTENWTXJyZmVueng3elJxTTBpTVRk?=
 =?utf-8?B?VzA1L1FVMUc5YlVZeWw1bTkyRGVFcHdiaHdGLzQyU2lDNTRtcTQ2VEpwUUtZ?=
 =?utf-8?B?Ykl2R1U2Q3FkRkcwaEM3L3VCejVvajhmRlBEVXcwMHRDdXg0Z2pPRmFSbGxH?=
 =?utf-8?B?NHVONi9QdU1DN2dXZ2VSVGNMaWl1b1BSSkdPbjdET1JIMFhkVEpvN2EycjIr?=
 =?utf-8?B?Qy9DUzE4TTErVi9sSWJ5K2JqczF6bzMvclBGZzF6ZUpScXc4S2RhNTR0SUVV?=
 =?utf-8?B?ZU1KTms5dlVwbVJ1QnJ1MjQ4YWh3WERtM2xlVzVReXJsZ3dmSVpsRDdYeGdH?=
 =?utf-8?B?QmpHTjhSUVZLUFl4ZkFFVmlpVVpjTDErOXRCZzBYY3ZScmFYZGd1OCtFSEtZ?=
 =?utf-8?B?UVdUaU9GUVBhM2h1bE9rSjNKY1BpSTMyME0rUGZzZnNmWExPeXY2aEMvVng3?=
 =?utf-8?B?djBNVEFWYjh1Wkt5N09pY1RNazFlVlNQZ0lUUlNEaGlEYktURlJmbDV1aWdE?=
 =?utf-8?B?M2R2QWp6d09vR1lkRHBVdzZpb1Rib1ZiUWRQdGVLZ2FKYzlseHdBT29TWEZQ?=
 =?utf-8?B?V3BiVlB1ZVp5K2NiRVVLT1BDdG44OG1VM0FDd0pFQ1RlSmZCQXlsZUFGMDdH?=
 =?utf-8?B?Q1diTlltVW9aWERDS3pvVkNrdENmU2lvVEtLUkkycnBJbHh3dzNnZUE2bFRm?=
 =?utf-8?B?NTBQTStHcGs2bjA3UXJLNytJVUFMem9tbjdEaXR5ZTJzSmlJR09ZMVhJcmFr?=
 =?utf-8?B?cWIycXowRkZMSTJYaTZJRHdQL3cxZHlueVk1SWNsNXpvWExYWDA2Qi9HSUVl?=
 =?utf-8?B?K2JDdXNsUkpTOFVLT2tPd2dJbVV4QktLRUprVUw5c1gzUUVheG5CSllyck1k?=
 =?utf-8?B?U3pTMnhZZzhEbVB2NmcyZ3FCZ3ZJOVlkWHFIZTdSeU5kbUdRT3REZnhqQ0hn?=
 =?utf-8?B?b0dRc1JjZU9OSFpueUpodW9zRHJlQURrVDVYRDRoWlBHOXZBak9jOGpiYVVh?=
 =?utf-8?B?NDd0K2s4NWhEaW5nSWpscEh3Z1YvOGhDMGUxUmY2RGx1WFhjMkNsWkMyMTM3?=
 =?utf-8?B?MllHSEhUNFkweUphREZUdVRYcW1RTUNRUjVuRk1XTDJlRW85SG1qTlVic3FZ?=
 =?utf-8?B?L0tFdlUvcThRYk50OE5FUkZBZFhjcitVTGk4SWRNY3JiRWVhd3ZwcllUNm9W?=
 =?utf-8?B?V0VWZEJGdVB3cTJRaDhCWXd5RmR0MG4vazg0VHVtMlIwckkyV2pRYnVMWDZP?=
 =?utf-8?B?dkhMSHhtNEpPMmtxanhiNkdTNTdGOG9odTNnVHBNVUtoSXRsMDdHa1VISXVw?=
 =?utf-8?B?clQ5NTUwL242MlRDZXJDWjNJYUMxaUc2R2FxdytSVmIxZGpGa21IZEVoQmdW?=
 =?utf-8?B?SWJ5ZWh2dEE2NVJ3SjkvdkJ5WjJ5SWZxd2hTa0ZzZ0Z0TGpsOHF4WTdNMFJn?=
 =?utf-8?B?U2hpaG5MSE1nVHNjRmJ0d0hVL0hkR0x1SVVtWTh1NElTV1RuN3U2ei9RQ1ZR?=
 =?utf-8?B?MHhIS3JFNlJGQ3QyS1NRZ0tSQlUzS2g0ZEFWSnF0SWc2ZUE2YUtaVDRUbFlh?=
 =?utf-8?B?aXJOOU45SkRsc2ZucXlvNlVOY3J3T3FvYW1DQVFhMDJleEs2d3YwbGZGT2Y1?=
 =?utf-8?Q?bd8VXR4b76zbdvsMkoz0CqMDL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a73b770-e25b-45a2-6a50-08dba13d1399
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2023 05:19:49.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9GVcieuld6xGX2cnq2wkVV4utKhs3EFgqGrLlpNovm+OpqXhlT5EpC35yEwH4cT7QRQ7AcFCrKQpeeq29vKAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0494
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBEYXMgTmV2ZXMg
PG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgQXVn
dXN0IDE5LCAyMDIzIDEyOjMwIEFNDQo+IFRvOiBTYXVyYWJoIFNpbmdoIFNlbmdhciA8c3Nlbmdh
ckBtaWNyb3NvZnQuY29tPjsgbGludXgtDQo+IGh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnOyBsaW51eC0NCj4gYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogcGF0Y2hlc0BsaXN0cy5saW51eC5kZXY7IE1pY2hhZWwgS2VsbGV5IChMSU5VWCkNCj4gPG1p
a2VsbGV5QG1pY3Jvc29mdC5jb20+OyBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47
DQo+IHdlaS5saXVAa2VybmVsLm9yZzsgSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0
LmNvbT47IERleHVhbiBDdWkNCj4gPGRlY3VpQG1pY3Jvc29mdC5jb20+OyBhcGFpc0BsaW51eC5t
aWNyb3NvZnQuY29tOyBUaWFueXUgTGFuDQo+IDxUaWFueXUuTGFuQG1pY3Jvc29mdC5jb20+OyBz
c2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5jb207IE1VS0VTSA0KPiBSQVRIT1IgPG11a2VzaHJhdGhv
ckBtaWNyb3NvZnQuY29tPjsgc3RhbmlzbGF2LmtpbnNidXJza2l5QGdtYWlsLmNvbTsNCj4gamlu
YW5ramFpbkBsaW51eC5taWNyb3NvZnQuY29tOyB2a3V6bmV0cyA8dmt1em5ldHNAcmVkaGF0LmNv
bT47DQo+IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgYnBAYWxpZW44LmRl
Ow0KPiBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207IGhwYUB6eXRvci5jb207IHdpbGxAa2Vy
bmVsLm9yZzsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAxNS8xNV0gRHJpdmVyczogaHY6IEFkZCBtb2R1bGVzIHRvIGV4cG9zZSAvZGV2L21zaHYN
Cj4gdG8gVk1NcyBydW5uaW5nIG9uIEh5cGVyLVYNCj4gDQo+IE9uIDgvMTgvMjAyMyA2OjA4IEFN
LCBTYXVyYWJoIFNpbmdoIFNlbmdhciB3cm90ZToNCj4gPj4gKw0KPiA+PiArY29uZmlnIE1TSFZf
VlRMDQo+ID4+ICsJdHJpc3RhdGUgIk1pY3Jvc29mdCBIeXBlci1WIFZUTCBkcml2ZXIiDQo+ID4+
ICsJZGVwZW5kcyBvbiBNU0hWDQo+ID4+ICsJc2VsZWN0IEhZUEVSVl9WVExfTU9ERQ0KPiA+PiAr
CXNlbGVjdCBUUkFOU1BBUkVOVF9IVUdFUEFHRQ0KPiA+DQo+ID4gVFJBTlNQQVJFTlRfSFVHRVBB
R0UgY2FuIGJlIGF2b2lkZWQgZm9yIG5vdy4NCj4gPg0KPiANCj4gSSB3aWxsIHJlbW92ZSBpdCBp
biB0aGUgbmV4dCB2ZXJzaW9uLiBUaGFua3MuDQo+ID4+ICsNCj4gPj4gKyNkZWZpbmUgSFZfR0VU
X1JFR0lTVEVSX0JBVENIX1NJWkUJXA0KPiA+PiArCShIVl9IWVBfUEFHRV9TSVpFIC8gc2l6ZW9m
KHVuaW9uIGh2X3JlZ2lzdGVyX3ZhbHVlKSkNCj4gPj4gKyNkZWZpbmUgSFZfU0VUX1JFR0lTVEVS
X0JBVENIX1NJWkUJXA0KPiA+PiArCSgoSFZfSFlQX1BBR0VfU0laRSAtIHNpemVvZihzdHJ1Y3Qg
aHZfaW5wdXRfc2V0X3ZwX3JlZ2lzdGVycykpIFwNCj4gPj4gKwkJLyBzaXplb2Yoc3RydWN0IGh2
X3JlZ2lzdGVyX2Fzc29jKSkNCj4gPj4gKw0KPiA+PiAraW50IGh2X2NhbGxfZ2V0X3ZwX3JlZ2lz
dGVycygNCj4gPj4gKwkJdTMyIHZwX2luZGV4LA0KPiA+PiArCQl1NjQgcGFydGl0aW9uX2lkLA0K
PiA+PiArCQl1MTYgY291bnQsDQo+ID4+ICsJCXVuaW9uIGh2X2lucHV0X3Z0bCBpbnB1dF92dGws
DQo+ID4+ICsJCXN0cnVjdCBodl9yZWdpc3Rlcl9hc3NvYyAqcmVnaXN0ZXJzKSB7DQo+ID4+ICsJ
c3RydWN0IGh2X2lucHV0X2dldF92cF9yZWdpc3RlcnMgKmlucHV0X3BhZ2U7DQo+ID4+ICsJdW5p
b24gaHZfcmVnaXN0ZXJfdmFsdWUgKm91dHB1dF9wYWdlOw0KPiA+PiArCXUxNiBjb21wbGV0ZWQg
PSAwOw0KPiA+PiArCXVuc2lnbmVkIGxvbmcgcmVtYWluaW5nID0gY291bnQ7DQo+ID4+ICsJaW50
IHJlcF9jb3VudCwgaTsNCj4gPj4gKwl1NjQgc3RhdHVzOw0KPiA+PiArCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQo+ID4+ICsNCj4gPj4gKwlsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+ID4+ICsNCj4g
Pj4gKwlpbnB1dF9wYWdlID0gKnRoaXNfY3B1X3B0cihoeXBlcnZfcGNwdV9pbnB1dF9hcmcpOw0K
PiA+PiArCW91dHB1dF9wYWdlID0gKnRoaXNfY3B1X3B0cihoeXBlcnZfcGNwdV9vdXRwdXRfYXJn
KTsNCj4gPj4gKw0KPiA+PiArCWlucHV0X3BhZ2UtPnBhcnRpdGlvbl9pZCA9IHBhcnRpdGlvbl9p
ZDsNCj4gPj4gKwlpbnB1dF9wYWdlLT52cF9pbmRleCA9IHZwX2luZGV4Ow0KPiA+PiArCWlucHV0
X3BhZ2UtPmlucHV0X3Z0bC5hc191aW50OCA9IGlucHV0X3Z0bC5hc191aW50ODsNCj4gPj4gKwlp
bnB1dF9wYWdlLT5yc3ZkX3o4ID0gMDsNCj4gPj4gKwlpbnB1dF9wYWdlLT5yc3ZkX3oxNiA9IDA7
DQo+ID4+ICsNCj4gPj4gKwl3aGlsZSAocmVtYWluaW5nKSB7DQo+ID4+ICsJCXJlcF9jb3VudCA9
IG1pbihyZW1haW5pbmcsIEhWX0dFVF9SRUdJU1RFUl9CQVRDSF9TSVpFKTsNCj4gPj4gKwkJZm9y
IChpID0gMDsgaSA8IHJlcF9jb3VudDsgKytpKQ0KPiA+PiArCQkJaW5wdXRfcGFnZS0+bmFtZXNb
aV0gPSByZWdpc3RlcnNbaV0ubmFtZTsNCj4gPj4gKw0KPiA+PiArCQlzdGF0dXMgPSBodl9kb19y
ZXBfaHlwZXJjYWxsKEhWQ0FMTF9HRVRfVlBfUkVHSVNURVJTLA0KPiA+PiByZXBfY291bnQsDQo+
ID4+ICsJCQkJCSAgICAgMCwgaW5wdXRfcGFnZSwgb3V0cHV0X3BhZ2UpOw0KPiA+DQo+ID4gSXMg
dGhlcmUgYW55IHBvc3NpYmlsaXR5IHRoYXQgY291bnQgdmFsdWUgaXMgcGFzc2VkIDAgYnkgbWlz
dGFrZSA/IEluDQo+ID4gdGhhdCBjYXNlIHN0YXR1cyB3aWxsIHJlbWFpbiB1bmluaXRpYWxpemVk
Lg0KPiA+DQo+IA0KPiBUaGVzZSBsaW5lcyBlbnN1cmUgcmVwX2NvdW50IGlzIG5ldmVyIDAgaGVy
ZToNCj4gDQo+IAl3aGlsZSAocmVtYWluaW5nKSB7DQo+IAkJcmVwX2NvdW50ID0gbWluKHJlbWFp
bmluZywgSFZfR0VUX1JFR0lTVEVSX0JBVENIX1NJWkUpOw0KPiANCj4gUmVtYWluaW5nIGNhbid0
IGJlIDAgb3IgdGhlIGxvb3Agd291bGQgZXhpdCwgYW5kDQo+IEhWX0dFVF9SRUdJU1RFUl9CQVRD
SF9TSVpFIGlzIG5vdCAwLCBvciB3ZSB3b3VsZCBuZXZlciBnZXQgYW55IHJlZ2lzdGVycy4NCg0K
VGhlcmUgaXMgYSBwYXJhbWV0ZXIgaW4gdGhpcyBmdW5jdGlvbiAiY291bnQiLiBJIHdhcyBjaGVj
a2luZyBpZiB0aGVyZSBpcyBhbnkgcG9zc2liaWxpdHkNCnRoYXQgaXMgcGFzc2VkIGFzIDAgYnkg
bWlzdGFrZSA/IHRoaXMgd2lsbCBsZWFkIHRvICJyZW1haW5pbmciIHZhbHVlIGFzIDAgYW5kIGxv
b3Agd2lsbCBuZXZlcg0KZXhlY3V0ZS4gV2hpY2ggcmVzdWx0cyB1c2luZyAic3RhdHVzIiB1bmlu
aXRpYWxpemVkIGxhdGVyIGluIHRoZSBmdW5jdGlvbi4NCg0KDQo+IA0KPiA+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9odi9odl9jb21tb24uYyBiL2RyaXZlcnMvaHYvaHZfY29tbW9uLmMgaW5kZXgN
Cj4gPj4gMTNmOTcyZTcyMzc1Li5jY2Q3NmYzMGE2MzggMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZl
cnMvaHYvaHZfY29tbW9uLmMNCj4gPj4gKysrIGIvZHJpdmVycy9odi9odl9jb21tb24uYw0KPiA+
PiBAQCAtNjIsNyArNjIsMTEgQEAgRVhQT1JUX1NZTUJPTF9HUEwoaHlwZXJ2X3BjcHVfb3V0cHV0
X2FyZyk7DQo+ID4+ICAgKi8NCj4gPj4gIHN0YXRpYyBpbmxpbmUgYm9vbCBodl9vdXRwdXRfYXJn
X2V4aXN0cyh2b2lkKSAgew0KPiA+PiArI2lmZGVmIENPTkZJR19NU0hWX1ZUTA0KPiA+DQo+ID4g
QWx0aG91Z2ggdG9kYXkgYm90aCB0aGUgb3B0aW9uIHdvcmtzIHRvZ2V0aGVyLiBCdXQgdGhpbmtp
bmcNCj4gPiB3aGljaCBpcyBtb3JlIGFjY3VyYXRlIENPTkZJR19IWVBFUlZfVlRMX01PREUgb3IN
Cj4gPiBDT05GSUdfTVNIVl9WVEwgaGVyZSBmb3Igc2NhbGFiaWxpdHkgb2YgVlRMIG1vZHVsZXMu
DQo+ID4NCj4gDQo+IEdvb2QgcG9pbnQuIFRob3VnaCBJJ20gbm90IHN1cmUgaXQgbWF0dGVycyB0
b28gbXVjaCByaWdodCBub3csDQo+IHNpbmNlIGFzIHlvdSBtZW50aW9uIHRoZXkgd2lsbCBhbHdh
eXMgYmUgZW5hYmxlZCB0b2dldGhlci4NCj4gDQo+IERvZXMgQ09ORklHX0hZUEVSVl9WVExfTU9E
RSB1c2UgdGhlIG91dHB1dCBhcmc/DQoNCkN1cnJlbnRseSBpdHMgbm90LCBJIHRoaW5rIE1TSFZf
VlRMIGlzIGdvb2QgZm9yIG5vdy4gVGhhbmtzLg0KDQo+IA0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9odi9tc2h2LmggYi9kcml2ZXJzL2h2L21zaHYuaA0KPiA+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjE2NjQ4MGE3M2YzZg0KPiA+PiAtLS0gL2Rl
di9udWxsDQo+ID4+ICsrKyBiL2RyaXZlcnMvaHYvbXNodi5oDQo+ID4+IEBAIC0wLDAgKzEsMTU2
IEBADQo+ID4+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+
ID4+ICsvKg0KPiA+PiArICogQ29weXJpZ2h0IChjKSAyMDIzLCBNaWNyb3NvZnQgQ29ycG9yYXRp
b24uDQo+ID4+ICsgKi8NCj4gPj4gKw0KPiA+PiArI2lmbmRlZiBfTVNIVl9IXw0KPiA+PiArI2Rl
ZmluZSBfTVNIVl9IXw0KPiA+PiArDQo+ID4+ICsjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4N
Cj4gPj4gKyNpbmNsdWRlIDxsaW51eC9tdXRleC5oPg0KPiA+PiArI2luY2x1ZGUgPGxpbnV4L3Nl
bWFwaG9yZS5oPg0KPiA+PiArI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+ID4+ICsjaW5jbHVk
ZSA8bGludXgvc3JjdS5oPg0KPiA+PiArI2luY2x1ZGUgPGxpbnV4L3dhaXQuaD4NCj4gPj4gKyNp
bmNsdWRlIDx1YXBpL2xpbnV4L21zaHYuaD4NCj4gPj4gKw0KPiA+PiArLyoNCj4gPj4gKyAqIEh5
cGVyLVYgaHlwZXJjYWxscw0KPiA+PiArICovDQo+ID4+ICsNCj4gPj4gK2ludCBodl9jYWxsX3dp
dGhkcmF3X21lbW9yeSh1NjQgY291bnQsIGludCBub2RlLCB1NjQgcGFydGl0aW9uX2lkKTsNCj4g
Pj4gK2ludCBodl9jYWxsX2NyZWF0ZV9wYXJ0aXRpb24oDQo+ID4+ICsJCXU2NCBmbGFncywNCj4g
Pj4gKwkJc3RydWN0IGh2X3BhcnRpdGlvbl9jcmVhdGlvbl9wcm9wZXJ0aWVzIGNyZWF0aW9uX3By
b3BlcnRpZXMsDQo+ID4+ICsJCXVuaW9uIGh2X3BhcnRpdGlvbl9pc29sYXRpb25fcHJvcGVydGll
cyBpc29sYXRpb25fcHJvcGVydGllcywNCj4gPj4gKwkJdTY0ICpwYXJ0aXRpb25faWQpOw0KPiA+
PiAraW50IGh2X2NhbGxfaW5pdGlhbGl6ZV9wYXJ0aXRpb24odTY0IHBhcnRpdGlvbl9pZCk7DQo+
ID4+ICtpbnQgaHZfY2FsbF9maW5hbGl6ZV9wYXJ0aXRpb24odTY0IHBhcnRpdGlvbl9pZCk7DQo+
ID4+ICtpbnQgaHZfY2FsbF9kZWxldGVfcGFydGl0aW9uKHU2NCBwYXJ0aXRpb25faWQpOw0KPiA+
PiAraW50IGh2X2NhbGxfbWFwX2dwYV9wYWdlcygNCj4gPj4gKwkJdTY0IHBhcnRpdGlvbl9pZCwN
Cj4gPj4gKwkJdTY0IGdwYV90YXJnZXQsDQo+ID4+ICsJCXU2NCBwYWdlX2NvdW50LCB1MzIgZmxh
Z3MsDQo+ID4+ICsJCXN0cnVjdCBwYWdlICoqcGFnZXMpOw0KPiA+PiAraW50IGh2X2NhbGxfdW5t
YXBfZ3BhX3BhZ2VzKA0KPiA+PiArCQl1NjQgcGFydGl0aW9uX2lkLA0KPiA+PiArCQl1NjQgZ3Bh
X3RhcmdldCwNCj4gPj4gKwkJdTY0IHBhZ2VfY291bnQsIHUzMiBmbGFncyk7DQo+ID4+ICtpbnQg
aHZfY2FsbF9nZXRfdnBfcmVnaXN0ZXJzKA0KPiA+PiArCQl1MzIgdnBfaW5kZXgsDQo+ID4+ICsJ
CXU2NCBwYXJ0aXRpb25faWQsDQo+ID4+ICsJCXUxNiBjb3VudCwNCj4gPj4gKwkJdW5pb24gaHZf
aW5wdXRfdnRsIGlucHV0X3Z0bCwNCj4gPj4gKwkJc3RydWN0IGh2X3JlZ2lzdGVyX2Fzc29jICpy
ZWdpc3RlcnMpOw0KPiA+PiAraW50IGh2X2NhbGxfZ2V0X2dwYV9hY2Nlc3Nfc3RhdGVzKA0KPiA+
PiArCQl1NjQgcGFydGl0aW9uX2lkLA0KPiA+PiArCQl1MzIgY291bnQsDQo+ID4+ICsJCXU2NCBn
cGFfYmFzZV9wZm4sDQo+ID4+ICsJCXU2NCBzdGF0ZV9mbGFncywNCj4gPj4gKwkJaW50ICp3cml0
dGVuX3RvdGFsLA0KPiA+PiArCQl1bmlvbiBodl9ncGFfcGFnZV9hY2Nlc3Nfc3RhdGUgKnN0YXRl
cyk7DQo+ID4+ICsNCj4gPj4gK2ludCBodl9jYWxsX3NldF92cF9yZWdpc3RlcnMoDQo+ID4+ICsJ
CXUzMiB2cF9pbmRleCwNCj4gPj4gKwkJdTY0IHBhcnRpdGlvbl9pZCwNCj4gPj4gKwkJdTE2IGNv
dW50LA0KPiA+PiArCQl1bmlvbiBodl9pbnB1dF92dGwgaW5wdXRfdnRsLA0KPiA+PiArCQlzdHJ1
Y3QgaHZfcmVnaXN0ZXJfYXNzb2MgKnJlZ2lzdGVycyk7DQo+ID4NCj4gPiBOaXQ6IE9wcG9ydHVu
aXR5IHRvIGZpeCBtYW55IG9mIHRoZSBjaGVja3BhdGNoLnBsIHJlbGF0ZWQgdG8gbGluZSBicmVh
ayBoZXJlDQo+ID4gYW5kIG1hbnkgb3RoZXIgcGxhY2VzLg0KPiA+DQo+IA0KPiBjaGVja3BhdGNo
LnBsIGRvZXNuJ3QgY29tcGxhaW4gYWJvdXQgYW55dGhpbmcgaW4gdGhpcyBmaWxlLg0KDQpJZiB3
ZSB1c2UgLS1zdHJpY3Qgc3dpdGNoIHdpdGggY2hlY2twYXRjaC5wbCB3ZSBvYnNlcnZlIGFkZGl0
aW9uYWwgQ0hFQ0socykuDQpJIG9ic2VydmUgMTU5IENIRUNLKHMpIHdpdGggdGhpcyBwYXRjaCBv
dmVyYWxsLg0KKHRvdGFsOiAxIGVycm9ycywgNyB3YXJuaW5ncywgMTU5IGNoZWNrcywgNzQ2MCBs
aW5lcyBjaGVja2VkKQ0KRmV3IGV4YW1wbGVzOg0KDQpDSEVDSzogTGluZXMgc2hvdWxkIG5vdCBl
bmQgd2l0aCBhICcoJw0KIzI0MDogRklMRTogZHJpdmVycy9odi9odl9jYWxsLmM6NzM6DQoraW50
IGh2X2NhbGxfc2V0X3ZwX3JlZ2lzdGVycygNCg0KQ0hFQ0s6IEFsaWdubWVudCBzaG91bGQgbWF0
Y2ggb3BlbiBwYXJlbnRoZXNpcw0KIzI2NjogRklMRTogZHJpdmVycy9odi9odl9jYWxsLmM6OTk6
DQorICAgICAgICAgICAgICAgbWVtY3B5KGlucHV0X3BhZ2UtPmVsZW1lbnRzLCByZWdpc3RlcnMs
DQorICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IGh2X3JlZ2lzdGVyX2Fzc29j
KSAqIHJlcF9jb3VudCk7DQoNCg0KSSBhbHNvIHNlZSBhbiBlcnJvciB3aXRoIGZsZXhpYmxlIGFy
cmF5LCBwb3NzaWJseSB3ZSBjYW4gZml4IHRoYXQgYXMgd2VsbC4NCg0KRVJST1I6IFVzZSBDOTkg
ZmxleGlibGUgYXJyYXlzIC0gc2VlIGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvZGVw
cmVjYXRlZC5odG1sI3plcm8tbGVuZ3RoLWFuZC1vbmUtZWxlbWVudC1hcnJheXMNCiM3NDY4OiBG
SUxFOiBpbmNsdWRlL3VhcGkvbGludXgvbXNodi5oOjEzNDoNCisgICAgICAgc3RydWN0IG1zaHZf
bXNpX3JvdXRpbmdfZW50cnkgZW50cmllc1swXTsNCit9Ow0KDQotIFNhdXJhYmgNCg==
