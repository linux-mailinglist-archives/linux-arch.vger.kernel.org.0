Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372B54B4D7F
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350168AbiBNLGQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 06:06:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350015AbiBNLGG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 06:06:06 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90083.outbound.protection.outlook.com [40.107.9.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37042A27AF;
        Mon, 14 Feb 2022 02:34:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+JNTW4B2pPjkFFyh8rN1mWkJgnvN+A3Cws9IKmNriKAZTDOkoHc6cj/BBlEr5XbBtW/FDAGCmIqKZuYRwALnzE0yd1LoK9z+oQF45imtjUHzm+x0nJenRB8s4ekrhQX6Ot7ybbSe0FEzjQjCdLlM06BonWsJfua2sLlzOStg9CkUsxWC+hazJwrh46uQzIbJUdd/uw/3tK/7yxT+3DmY2fce7jWhNRmsOisLOhpK36DJSEJoo2ldGyVPFgTEMFKi0+gBbFf0rMpxyeqq/wK53Ww7Vfg7EgW5Z+SmxFyRMQozb4ePo28V2L9EjQfeBzOMD6xS/ekpYIg6p/Io7cEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YTvX3pis+v4mSeb9oWnmw9yEzbB/NUCqLN5BqI8b7w=;
 b=j0wlX74iAziOxkuUlXSCA7gOHjT5s3RoKK9NpFIGv2K6lKvRSEiumMeCOiTGxIE2rjs9fT32RcH8Gej1t4m6nCel4NUaBfrs1p7XbnUuydrT28VZ2ytPwgT2vOimnL1YY7jgKUpKHEZwArJg72p32usAj2izf4CBlXHeXbaz9y21h07Ssd/j5FO6HAjNsYACaSZav5A4bR/Y9FLFDMvgCYis7eHLy8q++niKm6OK0ueU5H4CUdi7sj5G1Iu7P+IRv+VcfuAEfVkIlcGEalGl2OPSEabYdyiHMfrw02ku+vhgdAVwo1DaZ4sRv/l65nGtiDbIfszEBBC9u3Y92VxZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2323.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 10:34:30 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 10:34:30 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kees Cook <keescook@chromium.org>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 12/12] lkdtm: Add a test for function descriptors
 protection
Thread-Topic: [PATCH v3 12/12] lkdtm: Add a test for function descriptors
 protection
Thread-Index: AQHXw1QAGyBTdMZxwES7AYYHuFqiw6yOQViAgAVU5IA=
Date:   Mon, 14 Feb 2022 10:34:30 +0000
Message-ID: <211f5ad4-a832-8fa5-8e2a-e7997516702c@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <67f9545c9ad15048bfe0104278ef9595d051dbc8.1634457599.git.christophe.leroy@csgroup.eu>
 <202202101703.993CA9BC@keescook>
In-Reply-To: <202202101703.993CA9BC@keescook>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1667022b-9e29-4d69-9f78-08d9efa59560
x-ms-traffictypediagnostic: MR1P264MB2323:EE_
x-microsoft-antispam-prvs: <MR1P264MB232356D320A1F84331F67F1BED339@MR1P264MB2323.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qizlqGtLF24K8bCLVBEMqUATOj6D+6522YmVZ5z+TM96SSVLRqdNI1dW/zrvvr4Ao8ntuqaaEsR77iyW3QKcQPNq9h2JKeqwasIN7oco9ynxHe6fstITIn8338VUNKjOcmF+zR7LVn+vD2PPGU86xVGEAMBz89bs2lcwHgbJMn1sY0BjfQVdpqNylE3+nLWInkdf5ZAffSqzpBLElz1uEtFder5C3RdiUD+JyzetQoTsiTT5LVE1mhFrOZn+wK/wBmxofzS+m/hg5Y/wyXyYJnl2su0asmaVOsCO7PVaKwaF3gUy+Ap+GnorUPpxKEXqQBhG2XvikEavkABgbjHJfe4cti1nrSH3G6Jm2dfAM0Sp7RZvULz4StMOkT2vQ1QZeellvRbb5YiGkPBqehS/qVP2q3eE1zVqiYxp84k7sGcc4bctbbdmYxeNz7BkZUgy9RjZb0lDdC1pLtoKkeORaZ7cfkbzdp/TPbrKrgTAAMjWa42taaPQGZzjQlQn8Ym8NBP9RitJEaV5HzrjSeRZOaVEPjJnc4pryotUxxeVZBEiKPRyPssOzhtxMTQq6eWcXZnENC4MVrgk8bMCmCtUwx50/VRjUueQtbCTQWIX/rQqybBpB9nTSK1eNUpRfulKX/QI8tbpMR20Gp5E2V2WSCIG5KywvTrk8ZjsgOEpTgT7LD1RlPKVyGe9ManwFnCbJMSQyExFVAN59qod+b+2wcergmMtNe7xMbNTkqLlfwO2h6Dbl8tVLyyF9vHaj1IjYNiMdEpAZRvV6fQrGDLXaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(86362001)(38070700005)(122000001)(38100700002)(66556008)(66476007)(66446008)(64756008)(66946007)(8676002)(76116006)(4326008)(54906003)(91956017)(6916009)(316002)(7416002)(8936002)(5660300002)(2906002)(44832011)(66574015)(2616005)(26005)(186003)(83380400001)(508600001)(6486002)(36756003)(31686004)(6512007)(6506007)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHdZT29CM2VjVmg1QjZKZm9xenlOd2w2eHhkMnBFRC9RYWVLeFlwdnFHYXJY?=
 =?utf-8?B?TjRtY0JjK2xLdzM5Y3RONDRlcXkrNjlMUC83MU9ONk1HMFJXa0dVTitZcHR2?=
 =?utf-8?B?SFVsRXN3VmhOUkpyak9lNVJNQVVNVGR0WFg1L2xrSWFtQm1QN0w3dUVnbnAv?=
 =?utf-8?B?L1VpTnJaU0plNmRQUFc4SDF0Syt2ZWpOeEpVWWE4eGM5YU1NZlVYNVhyTG1J?=
 =?utf-8?B?KzlmSHRGdzhTZkhUZ0ZYRS9wRE5weE1rQzdVZjJHN05pL2N2R0tiNUtnNktN?=
 =?utf-8?B?UmJjS2hVM1dROGJSdzNLQzhTKzdvcFIyakxlZ3dGUndBWHYycTVvRmxJTUdr?=
 =?utf-8?B?RWJnMkNXS3lNOGtqWXhDZHdqdE5uR29jbXJ6VkZzSWU4aFI2dVBOWjI1VHdD?=
 =?utf-8?B?RjFnQXl2L3prRk53OGNBQ2dHSktGVy8vdTYvaW0waXlNdjBNYXNnVi9Tc2pk?=
 =?utf-8?B?YTcxVGZIVGhrZDA2ZnAzUHI3bHN6L2V6dFRDTVNqRHFaNVd1TmdDclNzbGlJ?=
 =?utf-8?B?L3pFVlpUaGMvc3IzblFJcTNWRkM0blZsdDE1b09YWXhXN3ZIbmN1VTJ3ajBx?=
 =?utf-8?B?WlhGQ21WOUcyOW5QYmZXaHBzY3JoTmp3ZDB6OHVrR0EzSVllTThidUM2Umhs?=
 =?utf-8?B?d3Vpd1RlZE9Cc3FDQ2FDWFM0dmVYQzFNaFRsNlExSkZiVG5jcTUxVUZxaTdJ?=
 =?utf-8?B?bDJxYzhBTEx6dThCWnNDY3Z4TFI1K3lxaUlVL3R1anhqekRKQk5rTHFTNHZZ?=
 =?utf-8?B?Um5IbVMzQlp1RUo5VUtpaTdTN0NxMWNyVjNCNTZadXNuTldqdWs4TUwwNmoz?=
 =?utf-8?B?TVFUR1ZsTW55SGR4VXdONHk4TzdCWEhxaERiTmpkSVlJdFViT2lqZmc0TEZt?=
 =?utf-8?B?V21kV04zZXp2ZllGU2VRMFRIR2NEVlNTekt4akZIZFdJUVdtb1E2bW5wRzRO?=
 =?utf-8?B?V1hVMVFmaitpSi9lRjA4Zmpad25qQnh5endmYmkxNjVHa1dyS0tpM3lBNUEz?=
 =?utf-8?B?cUFmdzVBRkd5Vy81QWw4cXB0OXU0ZzI5SUJjTmVTM09TVWc2UUxiZ0l3Q0ZN?=
 =?utf-8?B?TGZIR3VlZ202dXlseU1seG9pRWVua0sySXFsSGgwTkR0aW1reDdWZGtkdDRJ?=
 =?utf-8?B?aU52R3IzKzZ4bXhvWFlmaFJSTmdtUC9Mb1R1aktna2tYaUZEU2Y2b2VhZlVi?=
 =?utf-8?B?Z1hUU0cyL2ljbExieDlzRXMyRkNEN0pvQ3F0bEp5ci9qNXJTVVhDMEpXTEJu?=
 =?utf-8?B?QjJpdWxmb3FQOS9xQWh1U3l1OU50dG1pN25HLzNoYzdOQlBvY2U1bHZMLzdZ?=
 =?utf-8?B?ZVRmTDlSek5ObUNjT3VNSTRVcWxoYTdPc290RkpMSVFLbzhLQis3SjB4dkVx?=
 =?utf-8?B?Wngzb1N2UkVReHJ4ekVneitBY3JLeDljaGp3RnJ0Sm0yN0xFV3RkZUdsSUc4?=
 =?utf-8?B?K0o1bjhkcEVmTGF5Um5Ec3FRR1RpelZZcHh2TmhZdGZITlhpMlZEeGgvenZX?=
 =?utf-8?B?T3BjTktDT0xyeHgyU1MxcnFjSGEvREQvUkZCZ3hoSmphanh1YU1wdktvQXJp?=
 =?utf-8?B?bTUyVUtjaEF5ZUk3M3kvS2JoeG92aGJVbE8yZmVTeXJiZWdJblNWUGRqSng5?=
 =?utf-8?B?anZMcGs5RGZvTk1LYjBQdWtZVnVaWTZkU092ZFV4amJOdDVCRXhvRFcrQlhN?=
 =?utf-8?B?NmJLb3NiQy9HbG9sR2NSN1NFOXEySXlWNEdUdndVOHIwcXJmbGpnNEtPNTEz?=
 =?utf-8?B?S0hiK1VmVXpqRDBPMk95aFpwVUtpMUg5MVdlM2MyOHkwU1FvVTZzQTdlVDli?=
 =?utf-8?B?SVZmSExiUGdiNXhpeExITjZjY2dOdzUyOHgzcjlxOTNYZnI0a0Q2c0JjWHJu?=
 =?utf-8?B?L3VrL29KT3F4MThCMmNkT2lxeFdBSnpPV2Q3VmQxdUIwdDk3VDJiZnBwTlVD?=
 =?utf-8?B?bHdQZHdESG5PaVk0ZjllOG1DbzU4M0hxaUFOd1NwdkdsV3A4UjkrbDJUQjQ1?=
 =?utf-8?B?QVQ0RTM1YUFuM0ZYMGovT1l6M1NvSmg1Nktwb0g4WVVrZVRWYjhjSWc2WlM2?=
 =?utf-8?B?WGE5QWFhbWVPQThiQXZyK2lSZzR1bm95UXNCcmorNXdwN3RLdHBKYklBb1Zz?=
 =?utf-8?B?bjI4THlXT0RRa01TNysya1NaTG52RmRSZ2lGeGxwVHA4U3dmUVYrMnl5YlJD?=
 =?utf-8?B?a0F1MGgzSUpBSmlnTVVwUG9NMTJNL0NrZjNjbm1jeloxcXNwNHVjRHhZSERm?=
 =?utf-8?Q?RJYhLk2qFJLhvHBVk1jFjtk3g9pXFI0bFRbrJNL5fc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D64A3743B81D945831B31011C5D5D5C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1667022b-9e29-4d69-9f78-08d9efa59560
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 10:34:30.3634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Euu6ELcN3Xtm7iWk6HQQZGh4+4PmzUPFyl7NWYAxqjbcM1oOgPuNqqbwgTcMFLJxYnGwcjjElhq89UgiskiXoqyXEE4GHmSPNyAorL1Uc5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2323
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDExLzAyLzIwMjIgw6AgMDI6MDksIEtlZXMgQ29vayBhIMOpY3JpdMKgOg0KPiBPbiBT
dW4sIE9jdCAxNywgMjAyMSBhdCAwMjozODoyNVBNICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdy
b3RlOg0KPj4gQWRkIFdSSVRFX09QRCB0byBjaGVjayB0aGF0IHlvdSBjYW4ndCBtb2RpZnkgZnVu
Y3Rpb24NCj4+IGRlc2NyaXB0b3JzLg0KPj4NCj4+IEdpdmVzIHRoZSBmb2xsb3dpbmcgcmVzdWx0
IHdoZW4gZnVuY3Rpb24gZGVzY3JpcHRvcnMgYXJlDQo+PiBub3QgcHJvdGVjdGVkOg0KPj4NCj4+
IAlsa2R0bTogUGVyZm9ybWluZyBkaXJlY3QgZW50cnkgV1JJVEVfT1BEDQo+PiAJbGtkdG06IGF0
dGVtcHRpbmcgYmFkIDE2IGJ5dGVzIHdyaXRlIGF0IGMwMDAwMDAwMDI2OWIzNTgNCj4+IAlsa2R0
bTogRkFJTDogc3Vydml2ZWQgYmFkIHdyaXRlDQo+PiAJbGtkdG06IGRvX25vdGhpbmcgd2FzIGhp
amFja2VkIQ0KPj4NCj4+IExvb2tzIGxpa2UgYSBzdGFuZGFyZCBjb21waWxlciBiYXJyaWVyKCkg
aXMgbm90IGVub3VnaCB0byBmb3JjZQ0KPj4gR0NDIHRvIHVzZSB0aGUgbW9kaWZpZWQgZnVuY3Rp
b24gZGVzY3JpcHRvci4gSGFkIHRvIGFkZCBhIGZha2UgZW1wdHkNCj4+IGlubGluZSBhc3NlbWJs
eSB0byBmb3JjZSBHQ0MgdG8gcmVsb2FkIHRoZSBmdW5jdGlvbiBkZXNjcmlwdG9yLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91
cC5ldT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL21pc2MvbGtkdG0vY29yZS5jICB8ICAxICsNCj4+
ICAgZHJpdmVycy9taXNjL2xrZHRtL2xrZHRtLmggfCAgMSArDQo+PiAgIGRyaXZlcnMvbWlzYy9s
a2R0bS9wZXJtcy5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAzIGZpbGVzIGNo
YW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNj
L2xrZHRtL2NvcmUuYyBiL2RyaXZlcnMvbWlzYy9sa2R0bS9jb3JlLmMNCj4+IGluZGV4IGZlNmZk
MzRiOGNhZi4uZGUwOTJhYTAzYjVkIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9taXNjL2xrZHRt
L2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy9taXNjL2xrZHRtL2NvcmUuYw0KPj4gQEAgLTE0OCw2
ICsxNDgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNyYXNodHlwZSBjcmFzaHR5cGVzW10gPSB7
DQo+PiAgIAlDUkFTSFRZUEUoV1JJVEVfUk8pLA0KPj4gICAJQ1JBU0hUWVBFKFdSSVRFX1JPX0FG
VEVSX0lOSVQpLA0KPj4gICAJQ1JBU0hUWVBFKFdSSVRFX0tFUk4pLA0KPj4gKwlDUkFTSFRZUEUo
V1JJVEVfT1BEKSwNCj4+ICAgCUNSQVNIVFlQRShSRUZDT1VOVF9JTkNfT1ZFUkZMT1cpLA0KPj4g
ICAJQ1JBU0hUWVBFKFJFRkNPVU5UX0FERF9PVkVSRkxPVyksDQo+PiAgIAlDUkFTSFRZUEUoUkVG
Q09VTlRfSU5DX05PVF9aRVJPX09WRVJGTE9XKSwNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21p
c2MvbGtkdG0vbGtkdG0uaCBiL2RyaXZlcnMvbWlzYy9sa2R0bS9sa2R0bS5oDQo+PiBpbmRleCBj
MjEyYTI1M2VkZGUuLjE4OGJkMGZkNjU3NSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbWlzYy9s
a2R0bS9sa2R0bS5oDQo+PiArKysgYi9kcml2ZXJzL21pc2MvbGtkdG0vbGtkdG0uaA0KPj4gQEAg
LTEwNSw2ICsxMDUsNyBAQCB2b2lkIF9faW5pdCBsa2R0bV9wZXJtc19pbml0KHZvaWQpOw0KPj4g
ICB2b2lkIGxrZHRtX1dSSVRFX1JPKHZvaWQpOw0KPj4gICB2b2lkIGxrZHRtX1dSSVRFX1JPX0FG
VEVSX0lOSVQodm9pZCk7DQo+PiAgIHZvaWQgbGtkdG1fV1JJVEVfS0VSTih2b2lkKTsNCj4+ICt2
b2lkIGxrZHRtX1dSSVRFX09QRCh2b2lkKTsNCj4+ICAgdm9pZCBsa2R0bV9FWEVDX0RBVEEodm9p
ZCk7DQo+PiAgIHZvaWQgbGtkdG1fRVhFQ19TVEFDSyh2b2lkKTsNCj4+ICAgdm9pZCBsa2R0bV9F
WEVDX0tNQUxMT0Modm9pZCk7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL2xrZHRtL3Bl
cm1zLmMgYi9kcml2ZXJzL21pc2MvbGtkdG0vcGVybXMuYw0KPj4gaW5kZXggMWNmMjRjNGE3OWU5
Li4yYzZhYmEzZmYzMmIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21pc2MvbGtkdG0vcGVybXMu
Yw0KPj4gKysrIGIvZHJpdmVycy9taXNjL2xrZHRtL3Blcm1zLmMNCj4+IEBAIC00NCw2ICs0NCwx
MSBAQCBzdGF0aWMgbm9pbmxpbmUgdm9pZCBkb19vdmVyd3JpdHRlbih2b2lkKQ0KPj4gICAJcmV0
dXJuOw0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyBub2lubGluZSB2b2lkIGRvX2FsbW9zdF9u
b3RoaW5nKHZvaWQpDQo+PiArew0KPj4gKwlwcl9pbmZvKCJkb19ub3RoaW5nIHdhcyBoaWphY2tl
ZCFcbiIpOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIHZvaWQgKnNldHVwX2Z1bmN0aW9uX2Rl
c2NyaXB0b3IoZnVuY19kZXNjX3QgKmZkZXNjLCB2b2lkICpkc3QpDQo+PiAgIHsNCj4+ICAgCWlm
ICghaGF2ZV9mdW5jdGlvbl9kZXNjcmlwdG9ycygpKQ0KPj4gQEAgLTE0NCw2ICsxNDksMjMgQEAg
dm9pZCBsa2R0bV9XUklURV9LRVJOKHZvaWQpDQo+PiAgIAlkb19vdmVyd3JpdHRlbigpOw0KPj4g
ICB9DQo+PiAgIA0KPj4gK3ZvaWQgbGtkdG1fV1JJVEVfT1BEKHZvaWQpDQo+PiArew0KPj4gKwlz
aXplX3Qgc2l6ZSA9IHNpemVvZihmdW5jX2Rlc2NfdCk7DQo+PiArCXZvaWQgKCpmdW5jKSh2b2lk
KSA9IGRvX25vdGhpbmc7DQo+PiArDQo+PiArCWlmICghaGF2ZV9mdW5jdGlvbl9kZXNjcmlwdG9y
cygpKSB7DQo+PiArCQlwcl9pbmZvKCJYRkFJTDogUGxhdGZvcm0gZG9lc24ndCB1c2UgZnVuY3Rp
b24gZGVzY3JpcHRvcnMuXG4iKTsNCj4+ICsJCXJldHVybjsNCj4+ICsJfQ0KPj4gKwlwcl9pbmZv
KCJhdHRlbXB0aW5nIGJhZCAlenUgYnl0ZXMgd3JpdGUgYXQgJXB4XG4iLCBzaXplLCBkb19ub3Ro
aW5nKTsNCj4+ICsJbWVtY3B5KGRvX25vdGhpbmcsIGRvX2FsbW9zdF9ub3RoaW5nLCBzaXplKTsN
Cj4+ICsJcHJfZXJyKCJGQUlMOiBzdXJ2aXZlZCBiYWQgd3JpdGVcbiIpOw0KPiANCj4gTm9uLWZ1
bmN0aW9uLWRlc2NyaXB0b3IgYXJjaGl0ZWN0dXJlcyB3b3VsZCBzdWNjZXNzZnVsbHkgY3Jhc2gg
YXQgdGhlDQo+IG1lbWNweSB0b28sIHJpZ2h0PyAoaS5lLiBmb3IgdGhlbSB0aGlzIGlzIGp1c3Qg
cmVwZWF0aW5nIFdSSVRFX0tFUk4pDQoNClllcyBpdCBzaG91bGQuIEJ1dCBub3QgZm9yIHRoZSBn
b29kIHJlYXNvbi4NCg0KPiANCj4gSSdtIHBvbmRlcmluZyB0aGUgdXRpbGl0eSBvZiB0aGUgWEZB
SUwgdnMganVzdCBsZXR0aW5nIGlzIHN1Y2NlZWQsIGJ1dCBJDQo+IHRoaW5rIGl0IG1vcmUgYWNj
dXJhdGUgdG8gc2F5ICJoZXksIG5vIE9QRCIgYXMgeW91IGhhdmUgaXQuDQo+IA0KPj4gKw0KPj4g
Kwlhc20oIiIgOiAiPW0iKGZ1bmMpKTsNCj4+ICsJZnVuYygpOw0KPj4gK30NCj4+ICsNCj4+ICAg
dm9pZCBsa2R0bV9FWEVDX0RBVEEodm9pZCkNCj4+ICAgew0KPj4gICAJZXhlY3V0ZV9sb2NhdGlv
bihkYXRhX2FyZWEsIENPREVfV1JJVEUpOw0KPj4gLS0gDQo+PiAyLjMxLjENCj4+DQo+IA0KPiBP
bmUgdGlueSBzdWdnZXN0aW9uLCBzaW5jZSBJIHRoaW5rIHlvdSBuZWVkIHRvIHJlc3BpbiBmb3Ig
dGhlDQo+IEVYUE9SVF9TWU1CT0xfR1BMKCkgYW55d2F5LiBQbGVhc2UgdXBkYXRlIHRoZSBzZWxm
dGVzdHMgdG9vOg0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xr
ZHRtL3Rlc3RzLnR4dCBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xrZHRtL3Rlc3RzLnR4dA0K
PiBpbmRleCA2YjM2YjdmNWRjZjkuLjI0M2M3ODFmMDc4MCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbGtkdG0vdGVzdHMudHh0DQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2xrZHRtL3Rlc3RzLnR4dA0KPiBAQCAtNDQsNiArNDQsNyBAQCBBQ0NFU1NfTlVM
TA0KPiAgIFdSSVRFX1JPDQo+ICAgV1JJVEVfUk9fQUZURVJfSU5JVA0KPiAgIFdSSVRFX0tFUk4N
Cj4gK1dSSVRFX09QRA0KPiAgIFJFRkNPVU5UX0lOQ19PVkVSRkxPVw0KPiAgIFJFRkNPVU5UX0FE
RF9PVkVSRkxPVw0KPiAgIFJFRkNPVU5UX0lOQ19OT1RfWkVST19PVkVSRkxPVw0KPiANCj4gKFRo
b3VnaCBmb3IgdGhlIGZ1dHVyZSBJJ3ZlIGJlZW4gY29uc2lkZXJpbmcgbWFraW5nIHRoZSBzZWxm
dGVzdHMgYW4NCj4gb3B0LW91dCBsaXN0IHNvIHRoZSAibm9ybWFsIiBzdHVmZiBkb2Vzbid0IG5l
ZWQgdG8ga2VlcCBnZXR0aW5nIGFkZGVkDQo+IHRoZXJlLikNCj4gDQo+IFRoYW5rcyENCj4gDQo+
IEFja2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gDQoNCkRvbmUu
DQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ==
