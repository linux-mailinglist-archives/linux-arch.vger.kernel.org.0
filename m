Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17D06396B0
	for <lists+linux-arch@lfdr.de>; Sat, 26 Nov 2022 15:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiKZOyn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Nov 2022 09:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKZOym (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Nov 2022 09:54:42 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120085.outbound.protection.outlook.com [40.107.12.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E794E1E3D1;
        Sat, 26 Nov 2022 06:54:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8mtgJAGv9X8ONnILmBwrkfofB0/TgacicJAtKLJWT7uJ1tTvJve0G5KVLcGisA8M9KdkPnmFZMrpOpoKA/hg2jppuQiAOdzOEEhxhM4iRLQ5Rf7eJzdqlkwwE1An75Hqo0gAXgJcf/s9hUyRxCfM93zx51wCsV45xZMbPlwUwEIaC34ei+/yWZhZuynDgajs0+z8joErche46WywhrWes64GRctgGroq5uIje7fmi5FtdTe6wmRiyt0XosuHmKP/qN7cvtDjGe0EKPfB1/a7OUIbDQY02Hzx3tHkXRDqZnMippJstYx9vxBk4v3dhf4OtANvlcXuhYxLtnPSzdHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYaBUI6zTgVdhIghh+C6Tej6Hq2GzlBCk2y3S+0NE3c=;
 b=dMiGWEUZE2pnMpjgmi/CeX8Vjd4Ze7ETpvmKBvH5X3r3Q9IAgoldbrWZfmIjkcHDr+qMHIwvpY2wT6DIonD9CmTOGtbK0vsnJJti2LfNQmip8JzvFWvhFttqrDEkYtaxBUN/2l9PNGnV7Td8SEpW7AywivS72qFJg1SHnY3NUsdqVPVWfWEZuE24MtQPIohQD1TWrQrgpuZ7eHtrk9Rlh7XcK0n+kUl7b0VrWRlYYytEZt5ghtyNeYTDpdkdr3ZWaonv2ocE1VnlDYOtzqzq1urCU/bq6kCCJBq5xvAAMi9NUHicx043bjcZd044JIhoCSK5xXlAaOyWpMHOiT/6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYaBUI6zTgVdhIghh+C6Tej6Hq2GzlBCk2y3S+0NE3c=;
 b=AInajGbz5w5G2sbEYtAf4uWWZGegkw1hgVc3zlbJEOdcC4qX/W7Q2JzqKTuaTLVegCnDIA3wArQkwaclaRB0f7otLKmVIrMahAP8lRlkz85xe0A5+oyHh2BZkTn+ORjMphZbIUvW+dDYxXSEgOnDYLodd4yeQmvQRdx4IVB4Mc1aA/G+cIDPXJHvO/c7MAhWNev3yi+aEeAAYJkXohWrJnsvlHrsKEaGA70LQrfndWWTk+6/VTZ7+2noLf8xtKw+Gym0fs8x8kDJdd+bS69Eq4OJIVfARAW3TCWh4o8Sht5Yq6eWhGCmZlqXJN3QJxYhCDl0P/ZqTgfMKFaSXzTIdg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3221.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Sat, 26 Nov
 2022 14:54:37 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%8]) with mapi id 15.20.5857.021; Sat, 26 Nov 2022
 14:54:37 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 2/3] powerpc/book3e: remove #include
 <generated/utsrelease.h>
Thread-Topic: [PATCH 2/3] powerpc/book3e: remove #include
 <generated/utsrelease.h>
Thread-Index: AQHZAVWpki/i7bY6nkCRQ+Pno6q/Xq5Q0P+AgABtGYCAAA0+gA==
Date:   Sat, 26 Nov 2022 14:54:37 +0000
Message-ID: <d48f728c-18ac-727c-6e0f-8b30e955449e@csgroup.eu>
References: <20221126051002.123199-1-linux@weissschuh.net>
 <20221126051002.123199-2-linux@weissschuh.net>
 <03859890-bf90-4ad0-1926-4b8cb8dbfa57@csgroup.eu>
 <8f8b12fd-2e25-49e4-a1fa-247f08f56454@t-8ch.de>
In-Reply-To: <8f8b12fd-2e25-49e4-a1fa-247f08f56454@t-8ch.de>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3221:EE_
x-ms-office365-filtering-correlation-id: 21e14cf1-fb04-4383-8a7d-08dacfbe23b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dez4DsTtIF4HJaup1/+h4T2tttVryPA7l8l3VdU8avq4eMitH5/adpqFqKx1mhMf5qTHuYpU1qipWds+8PCgOMusfTgNwICX6I/zOeIrwK+b3oNgwPcQf3/0E7EPxT1Ivk/GCsMVtVpqzQ5LhNqx5L0FKAUYF5bmku3MAm0HKg0p421AWP9tdsYenynPuKwwFiVRVLRzWWS5jGwN/CXcrOtp+UyBj1OtA7vCNlYIcgVhce2GmpJSEFxtpJikjtKvFkLgIanUvOVK3GzUf8C3haHz/Zl+FWGC/J8MJ7LKbpAPNJfc8g0C+67b3rlTtJgcuHF6b2NcSsTMVPtXqmevdR2UX/6XXtFQzefnmM478+4tuLG7H5Y4ly49UmsX08Dtf3MpQTJrRNz+q3UT4STMgZFK7rmzKkQmubeaIjtYiby6+nhuZnXqLHXb7icd9ZOGVchIJw2TiZrDyWfNufeMdMON1q0RZokblO6Osm2vNjTxh++njKyXnibl1FQWhqF3Mly1L5hoF5MsBLZ2Gi0pNCj41qcDUuAU63FP4Zc+6MC1o3TKYutsnS4yGMJpkUFccrRfCYzbHf+7ZIELOwAmS2sLUFLi7bpsYYu5N+fW6Tni4qRk9qUXdG7rf8PxqfOX36fPgPo770ap2wZifomM1Zt/oopIr2hMODm4GK1g9/CJHAbD+HaEn2lmJfC8qph0CCcW+Jsl5mWSzkoE7wbsvGHL92KSFW+LeccRczYUgbQL46HjMngbJa+Q1N0NdEgJxiJ9pyKgPLFJf0ij7r8PYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39830400003)(366004)(376002)(396003)(346002)(451199015)(5660300002)(7416002)(66946007)(71200400001)(6486002)(66556008)(66476007)(316002)(4326008)(91956017)(76116006)(6916009)(54906003)(64756008)(66446008)(36756003)(41300700001)(8676002)(83380400001)(38100700002)(38070700005)(122000001)(478600001)(31696002)(86362001)(2616005)(186003)(26005)(6506007)(8936002)(6512007)(31686004)(4001150100001)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWF4SnpUcXRyY0djTUJpck54QVBUdkRXTVMvUm80NC96UnRteGJkSkJsWDFn?=
 =?utf-8?B?QXhQTW5ZTTc4VldwaDRNaHJDSy9lOXl3dFJUOTRNU21EbVVhQmswZkNtUEpm?=
 =?utf-8?B?UGZwcnFrS0xPV09naENvNFMrbGNpaEcyZHlEUkNKcVJsNnZ0Z2Rxa01SVUJE?=
 =?utf-8?B?SllNOGtTR2hrRDZOMEYvS2lDZUJ4a09ZNWJHeG5HblRSeWxaR2tUd3pmU1Fw?=
 =?utf-8?B?Wm1hYWhwZDMxaUxIS0hTRmg2SkUyUllzWnlhRkVycll4S1c0MHRwcm9zcTBE?=
 =?utf-8?B?Zmp3UTZrYW9ERkZEMDJlWGpJdUw4U1lZcDBoMzZSTmoxZTl5cmFjUmtkUFAw?=
 =?utf-8?B?RXlXK2hjMGpYY0ZSYnhSRHVqZVlzK2xkVm54WmlSd05JTVM4YVV2dXZacFRL?=
 =?utf-8?B?eURQa1ExNjhadG5KeVF4Rm1vcERxL3NISFc5TDZvNXFOWFptN2o0L0JOVlV2?=
 =?utf-8?B?Y2xFRFE1NloycENhbytuS3Njcm5XRWx4QWxmd05XZHo3d1dqaTNJM1IrLzN4?=
 =?utf-8?B?eDNDdW05NzdoSHdyVHhPdTdZakNTWnJUR2x2R1lrUTYzejg1VCtYM2ZHcWlY?=
 =?utf-8?B?MEVvbVcveUl4dlRDSkg5Q1NJUHZrSzNWWENYdzFUd2RJdE1vVUhMZWtSMlNT?=
 =?utf-8?B?Nng5M0JqOCsyNzB5UGhyZ1BGdGUrOXZGY05vSmxMVk02VHYzMG1VQUpJTDNr?=
 =?utf-8?B?eUh6Q2h3ejdJUllvNHB6S2wrTHdVeHJHSXBtcmtxK0c0czBJMGt5NFNjcGVV?=
 =?utf-8?B?TmdOQkRCZDVDYVVrdlRBTStWbkJ0UkNtNnFON2VEYVZqdUk0RGsrd0w4WUdu?=
 =?utf-8?B?UmJNK0RtSzVJbUtTaW1TVFBSQk1VTGFBSE5STEh5OTNSVHJQZVFOdWU1dXYv?=
 =?utf-8?B?eGxQb2Q3RkVsUkN2aHVRamExcWJ6MGdhaDczb3ZDUjRrYXVnZ3VjeGVMMGFQ?=
 =?utf-8?B?Y0toc3p6WlljSkR4blhKamFEcVdrd0tLbHRhV0RyemRMa09maHhKS0Z0MURD?=
 =?utf-8?B?VWNtUVUweUpMeVhwZTZ4cXlyYzhoTjhXek5kSExZc2MvNHJhZVVhaXFTT1oy?=
 =?utf-8?B?dnRlTWV1azA0Snc5WXVsdWhJck5nT3ZpSGVxaDFmSU1veEZuMkh0c3NuZkY0?=
 =?utf-8?B?eURBL2pHMjQ5aC9KY2lOaGdkOVhQM0diRFRESXZITTlPU2cvSUNJNlB6cnJs?=
 =?utf-8?B?VmVFZFVlQ1BjRzlFb1poNUIwYld4MkVtRFVpV1M0akkwWTRvZzRPRm0vWldI?=
 =?utf-8?B?REFnUzNVZkJQTGNpaEpwMW85NmNENEtvN2ZaWmlMalY0c3RlQTdqU2dxVXIv?=
 =?utf-8?B?Q2pLYjM4M0xsWkRkOFlMQXhnRFZCaHVuNmhRbWJMQkVyazBSY1JYVnlMa3dV?=
 =?utf-8?B?bGl3MHRWbWRPNDF1Z0oyMmQxTUplVTlMNS9vcFdkQ2RydnFaYWY2Tk5BOHRL?=
 =?utf-8?B?YzFZK1RtYWNJbGdodlV5Ymd6VVpoL2R0MlRiVENYbFVxL3NaSFlqRktpU0RN?=
 =?utf-8?B?VENiSXMyNVMrd00yK1lyV1ZaclhhS1Uxa0VTK0RjenkyUnk4c0RNZ2Z2Q1R0?=
 =?utf-8?B?RVVqRnlpV0FaQ3c0OHJQbDRtcCtFRlQrN3lnUXB1NXhocjR3VG41c2pXWTlH?=
 =?utf-8?B?bmtwQUZNUnBQZjhENkM0aVAzeGVIVHRtVGUyK3BFeEl2dS9tWjY0SVJzWTFs?=
 =?utf-8?B?MmlZRENVOHkrK3ppRW5RQ04zSFk1TEFYcUNEeE9xcGRxNXFveStRR3pUYWVo?=
 =?utf-8?B?V1ZKakpobFNtVHhWTjZOTjBMeVJ0TWV0NHVmSzE5OCtJQm04YW1RWHNkdkls?=
 =?utf-8?B?UW9BYXB5TjZBbzg3aEljOFRvUWR4aVlmLzlneUx4bEMwaG9mejlNcnAwRXl5?=
 =?utf-8?B?cEUrWmpPaTlKRC9vVXVzazZaeEtsQ0NZVEdhRmJTOFd0d1JvaERtT283UElW?=
 =?utf-8?B?bDdObGNyQmNYaXRuTU5IZHNuM01KV1F5Z3ZrWGorcGk2djlyT0FHTkt5ditP?=
 =?utf-8?B?dWVVelFQSGJhUzFWRU9ZRzBsNFNnaWxDVUU1UzJhTnFNOFp3Tm85am5FNG1U?=
 =?utf-8?B?MDUxSUdVUlk1N1loK2NWVVYvZ1E3cmo3b2lhcG5TdG1lb3BVWS9zelNYOXU2?=
 =?utf-8?B?UDB4am9WQ1hJL1RaSEd4S2tWb1Q5cHlrTUtYcUNjNVR2VEVISnRzTVVmRUV2?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1FBEC1A89556469A8BD363C0966064@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e14cf1-fb04-4383-8a7d-08dacfbe23b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2022 14:54:37.5452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JiI2K4OL37dRPn0MEEiTyXbzrM/LX7n5YvwCVy1nH2gB3XJHI8WMC4TQe6GZzG9mI5JYBbqK+ni7cmoaJTG/CKJrNJP9OMS1UxpS6Rr1qDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI2LzExLzIwMjIgw6AgMTU6MDcsIFRob21hcyBXZWnDn3NjaHVoIGEgw6ljcml0wqA6
DQo+IE9uIDIwMjItMTEtMjYgMDc6MzYrMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+
IExlIDI2LzExLzIwMjIgw6AgMDY6MTAsIFRob21hcyBXZWnDn3NjaHVoIGEgw6ljcml0wqA6DQo+
Pj4gQ29tbWl0IDdhZDRiZDg4N2QyNyAoInBvd2VycGMvYm9vazNlOiBnZXQgcmlkIG9mICNpbmNs
dWRlIDxnZW5lcmF0ZWQvY29tcGlsZS5oPiIpDQo+Pj4gcmVtb3ZlZCB0aGUgdXNhZ2Ugb2YgdGhl
IGRlZmluZSBVVFNfVkVSU0lPTiBidXQgZm9yZ290IHRvIGRyb3AgdGhlDQo+Pj4gaW5jbHVkZS4N
Cj4+DQo+PiBXaGF0IGFib3V0Og0KPj4gYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy81Mnh4L2VmaWth
LmMNCj4+IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvYW1pZ2FvbmUvc2V0dXAuYw0KPj4gYXJjaC9w
b3dlcnBjL3BsYXRmb3Jtcy9jaHJwL3NldHVwLmMNCj4+IGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
cG93ZXJtYWMvYm9vdHhfaW5pdC5jDQo+Pg0KPj4gSSBiZWxpZXZlIHlvdSBjYW4gZG8gYSBsb3Qg
bW9yZSB0aGFuIHdoYXQgeW91IGRpZCBpbiB5b3VyIHNlcmllcy4NCj4gDQo+IFRoZSBjb21taXQg
bWVzc2FnZXMgYXJlIHdyb25nLg0KPiBUaGV5IHNob3VsZCBoYXZlIHNhaWQgVVRTX1JFTEVBU0Ug
aW5zdGVhZCBvZiBVVFNfVkVSU0lPTi4NCg0KQWgsIG9rLiBTbyB5b3VyIHNlcmllcyBpcyBjb21w
bGV0ZSB0aGVuOg0KDQokIGdpdCBncmVwIC1MIFVUU19SRUxFQVNFIGBnaXQgZ3JlcCAtbCAiI2lu
Y2x1ZGUgPGdlbmVyYXRlZC91dHNyZWxlYXNlLmg+ImANCkRvY3VtZW50YXRpb24vdGFyZ2V0L3Rj
bV9tb2RfYnVpbGRlci5weQ0KYXJjaC9wb3dlcnBjL21tL25vaGFzaC9rYXNscl9ib29rZS5jDQpk
cml2ZXJzL2Jhc2UvZmlybXdhcmVfbG9hZGVyL2Zpcm13YXJlLmgNCmluaXQvdmVyc2lvbi5jDQoN
ClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAu
ZXU+DQoNCj4gDQo+IENvdWxkIHRoZSBtYWludGFpbmVycyBmaXggdGhpcyB1cCB3aGVuIGFwcGx5
aW5nPw0KPiBJIGFsc28gY2hhbmdlZCBpdCBsb2NhbGx5IHNvIGl0IHdpbGwgYmUgZml4ZWQgZm9y
IHYyLg0KPiANCj4+IExpc3Qgb2YgZmlsZXMgdXNpbmcgVVRTX1ZFUlNJT04gOg0KPj4NCj4+ICQg
Z2l0IGdyZXAgLWwgVVRTX1ZFUlNJT04NCj4+IFsuLl0NCj4gDQo+IFRob21hcw0K
