Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D213F60017B
	for <lists+linux-arch@lfdr.de>; Sun, 16 Oct 2022 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJPQ4V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Oct 2022 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJPQ4U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Oct 2022 12:56:20 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120074.outbound.protection.outlook.com [40.107.12.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3B631EE3;
        Sun, 16 Oct 2022 09:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyF6sFlOOVw1WfbAn/ubTOIhHrb7+hA/hqJEixIIypT1R7YjusXMSCcps+yw+WkiSluq11tnVzh5Z3eKz17wMAO4cbz1j8aIBoxmoKp1tFSbuBrrB4gT2rKakjfpHA8l+NmnGB+6J0WGb/IxOcWx7HFsovzdI18/Q9h7YyYZRgPdtyRMEao3hw5lZxoQbHNonm9OHhKTJA4PpKT9dvuKa2G0fKAY70idZDcQh/GM0c7arJEJVu+ufvQ/UvGlbkcJBClx2njuF3b54RIsyL4tucZGHaGtHCKf6snE5HITd6E+JcO9HnNSp7S70U9pGt0wckSDuog1K7e/5iMnUU9BGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4mpnJ6Jddc3tet9A15JXlq6cYx1SSIaDNUy++m3S9w=;
 b=iL465rabInP69VtE9nJV+RmD7IO9sNBcjsiiIdroXKD7s12FVD/cLUKVss+ePzUQj4K2pfpfKgdoyMbIvd1CklUSSY2ZQpKahOPo3C8c2G/ql0dJZP9w/mC6XpWUX/pcFUjz3Yk2QVwegMNdOwoZEfWDFKwcQe5sSslp1dt+pkw9aRK7R33aiGHgagwhfsSXQr6xeYWIZmnnjnc6ld08HjTOZDI5lBBTr1G99i3dsFCkDVNQj2mt8iBOC1w2oZstn4F6apzQ5PQWwtklmzBnC9XYKSeSa+MpxIza8yHdXBroDTvsxGygzMq50CopFpXpTyB7si6tuSQ+RtsTXdGosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4mpnJ6Jddc3tet9A15JXlq6cYx1SSIaDNUy++m3S9w=;
 b=jciwewETQqIwMgMmyenGyzJSLhNZyato/VaNzdUX+LdBY/9B2B/20vYmYmNbH42qk2l9Ze4q41PTRVhL4V7+3ple1YXFVF4wv6zuf8hoLKmscaSKiBsoLGFPAaMDpUBG9t72a4vliwbsMBp6PMWfn28KWGYaly7DEE1JHSLbt1IlgK2C4UMQQ+kqVK9ly/Byxa9RkGtfw/YKj6fRHcab+ApEvHCwYA4Cedj2v8K7wKvv63skEVd351rcdUT7LZua2T8pAHbwLGFdaLdLVFhyRC4NXdloUeQQRxzLdW8pYeAnaL2DVLhc/+5rTOXhAbOH7WYQQ56e3BoJIBOLHei0Hw==
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 PAZP264MB1430.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:121::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Sun, 16 Oct 2022 16:56:16 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c489:75f:98f4:b143]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c489:75f:98f4:b143%6]) with mapi id 15.20.5723.032; Sun, 16 Oct 2022
 16:56:16 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Gordeev <agordeev@linux.ibm.com>
CC:     Baoquan He <bhe@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        David Laight <David.Laight@aculab.com>,
        Stafford Horne <shorne@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 7/8] mm/ioremap: Consider IOREMAP space in generic
 ioremap
Thread-Topic: [RFC PATCH 7/8] mm/ioremap: Consider IOREMAP space in generic
 ioremap
Thread-Index: AQHY3iLR8IoLwHIPZ0e6rTIF5MeuQ64KkXSAgAYbTgCAAEJagIAAVPqA
Date:   Sun, 16 Oct 2022 16:56:16 +0000
Message-ID: <cfc31334-5026-3bfc-e7b4-f418ead6f659@csgroup.eu>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <8c7ac4667c6a3cc48f98110117536f60d51ece4a.1665568707.git.christophe.leroy@csgroup.eu>
 <d0acd053-96d3-4e18-a9de-97987d8be14b@app.fastmail.com>
 <Y0u4tN+mIgNSWwdi@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <af8ba7b8-5198-42a1-84c7-9b7d7892ceb3@app.fastmail.com>
In-Reply-To: <af8ba7b8-5198-42a1-84c7-9b7d7892ceb3@app.fastmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2980:EE_|PAZP264MB1430:EE_
x-ms-office365-filtering-correlation-id: 12166f38-7f2e-4f8c-1e92-08daaf975767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j3AsgLlVz5r3pWd/6J3xD2wIm/g4fev51XEsF/pCuFXV4ddHKHnwAhUsKjrGjLuxmZ3rWTMc4DIgRI9BZeQWudH08Nwfw/ZYMvPlN7uLDJ9725sWYla+k0fXf5T1sh01pTGNk5Z09yffLpe0PTB/FHJfRKEBNzfYRdrCHF/ybhDay6DV2g7x1CDdDmZ8XLQgFImhpnruwgkn4kfAee8e2veyYfuzZkdqKYNJpQbqjJiZ3s/Tr0siz4SImHgpiNEDUNWO4jb27QExnkvo6mPpNtHE2vVTTfr5TaUHfJqxCWBcWYzM3MUOR/tyNYvKRuSkmX8/n7x+/MvIDYQHgE1mCs2GmRkQGNWAEjcCBkbzvtHRSfnJFQ/rOLDLXFuYJM2/rG9RA+YAsLU9jswSvRupxAqpcyUax0/OCHXGtw6rzE7gJk/u9jWSeXNjd7U+F6BYu+IHsYe+ZPGo0XyO6Ib+eKZPL4tlL5+IassF+1GDxDABkx0XzT/VbY7+hEJ0iZx4wNXNAfmoU1MurTRMd0+50vZuztniTmkwkNOwWTrakycrTL9SBU5Zme1lS4dkhRvV5ruTNZHPpxgUzeLKU/Luf2vsbmXAMgw+hiK5Obt3XM+TkOrFBAGnQcdGLOp7/YWSN9Evua9sKOAgdMvWAjJ1Lf0abwufbF8Yydfu6FTuvf2fOW37T7yvmMULhIS/yQ0UelrWR7Z/EOSKCgbwVAs6hTj95WeDCc7FOLdHLX6LTQY/vGULTJEDaQnKC1v0SQRvL7pB71qCZ9agzjB6+gVhbF7pXwWP0Y0fRTTuKpkx3G7t0TPhuvZk78J/38xpem/HmaLkYbYfaYVoxiJ3DFQdjOdUjmoeFLX24CZGWyMCKdw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(451199015)(38070700005)(36756003)(122000001)(86362001)(31696002)(38100700002)(91956017)(76116006)(66556008)(66476007)(64756008)(8676002)(66446008)(5660300002)(54906003)(316002)(31686004)(66946007)(110136005)(7416002)(44832011)(4326008)(186003)(71200400001)(6486002)(2906002)(8936002)(2616005)(6506007)(478600001)(6512007)(26005)(41300700001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1pJTzlnRTlmWUNxYzMvdlpLV0lXOE4rdHdVT0N2VVNyalhVNjN4Mlptd0ZS?=
 =?utf-8?B?clRCblhwTmdXNmxXSGpPZlRJQXVEdEYyOFlKVDFhQWNjZ2M5S3pObENtQjgv?=
 =?utf-8?B?VThyWDh5WDBTMzR6L3FkNWV0UjJCajRyaEJOYVlTcnhoRm5WTVhYYStrdHBh?=
 =?utf-8?B?YXlmZHFZY2tFSDRPM2hqUG44QU16K2c0ZHJIRmtHS052TjlRTDRSNTFMbDlI?=
 =?utf-8?B?Q295dGE3UU5qa3pCNFNNTHpldkw3aDB3ak1FWkhmMzdNUUU3amtrTlFzYlhG?=
 =?utf-8?B?cnJXbk9Yam5IZ2F3dTdnMGNFR0Y4eDA0UjVDMCtXTkxlbTVQb2N0NUNVKzJN?=
 =?utf-8?B?cnIzaVhHVUdEUVB4MlNIcmwvNVNwUGhJOVVQZHhxUHBtUno5VW1kSkQ2dFVs?=
 =?utf-8?B?dUNWK2U2UlVyU2FWanJwaWlJVEZHcThQNUtES0RoUU5TcVY1UmxmWG9VMnpl?=
 =?utf-8?B?cEZxS2IxWWVRTDZDZXFPam1XcndqZmZRZ2RVN2ltUjhHcFdpY3NNOE5UUUlx?=
 =?utf-8?B?ODlKMm5QT3pmM3pBTlhGNnlBTE03MFJSVzg2T0NaeUlOMjlnNmJra0NpWVVs?=
 =?utf-8?B?eHhWcm9ZZ3VPd1Z5dDdUWUIvcUlvZlRVN1VUZUI2QVZzU2J6RzQ3c1h0dHk0?=
 =?utf-8?B?cmx1VGdxZEVOY3NzTUxqekZQWVZERWgrQXBkUU81WkUvRE5FZlphYmFaaDFj?=
 =?utf-8?B?QlBWN3BPM29sbTYwTTJHU2kzSEhEdFVaN1dJT1QvZmczU1dRNkl5SWdzR0Ji?=
 =?utf-8?B?M2tIYVJGK2MycVNnUlpWS0RDelAwSkI1NUhjTGZHT3pHOHRCdGlPNW5rK056?=
 =?utf-8?B?c2JFeTE4WXNrYW16TWtBZ2RsM3NnbkdsNDRDRzh3dUw1Y3dNVU5uOER5YlVY?=
 =?utf-8?B?cTMrY0xnaFNtZ3lFSCtDSERFaFFYMFRLSk81SzU4MzZoY1EvZWYyejl2aVpN?=
 =?utf-8?B?QUhLTmUvK3RaV01wTXkyNko3OHRWbTcyNURIc2Vsci91VmNjUWordG9VdUNF?=
 =?utf-8?B?bGRYM01HVDRwd0JiREw1VEdNZldaTWtuNFdYdHkxSGlHYVRueUNzeTNzSUdL?=
 =?utf-8?B?Y3dUL1dtRmc4cS9LaXA0TEtrNnZKeHp6K3Zhc3B5ZDIwVWFLa3VLVUlVUVhn?=
 =?utf-8?B?cUM0RGg0TjlKVjFIQWIyUkpOdEVnajUxL1drS2VJRGxROHF1SWsxdU1vTHpV?=
 =?utf-8?B?SkZ2WTFBbkQ5dVU1SnI5VDdFUVdyS0lZSmtna09wdEg2Y3dDN0YvQUdmT0ls?=
 =?utf-8?B?aHVkWjBMdFJscDFvWnRCN0ZML0RkME5qSWZjMnRnTm9zQURTeXp2bk1JVlhG?=
 =?utf-8?B?K0pQT3lKMVdUZ0Q0NVIrakVSUVo0NGRMTkVXK2VORmpDV3ZtNzVqZFhPbkJI?=
 =?utf-8?B?eFV4bHMwVjBoalZSYVQ3djVuY2JPTUVvOHFmUTFBbklGemt4cjg1YzhmZGh3?=
 =?utf-8?B?T2ZRcFFxeE1qRzBwTWFqU2ZuL0tVR0NCcWFQMjFhZ3dITGR5eWh6YVhka05o?=
 =?utf-8?B?V29oQVVPVG9TUm9xb3dUSDdXTEZYOVFaSlBYZWpHVXpyWTRTVUZTWHQ3SWFp?=
 =?utf-8?B?eDZuRkFTTGZsZDQzVWZqdXIyUGJ0RTZzQnBtRDJkRTd3Nm1KenlSRUNEUkgx?=
 =?utf-8?B?Vk9NU1kzKzJZZFRYSzAvMjNPbCt4OEdjUnc4KzhOTHdBK2FSTmU1QVVic0ds?=
 =?utf-8?B?bFROQ0JhMkdxMVpYK0Zyb0FtS0NHME93VTN1eVBxMnMzV00wVURzWk8rK3g0?=
 =?utf-8?B?US8wY3pmTjJKbHZVMSs0QVZ0ZG9LaXcyU0FONTYyd1ArZWJXbmdqQnJMSnFk?=
 =?utf-8?B?YVlmTDJQMFNKNEJCRTJ0clM3TWVRUUdEOEV5a2pqRUhENGdMZFdBMHpLR2lL?=
 =?utf-8?B?VGFGOHJWcHA2K3JnN3N2bWRQa1pTSlhvRWdsQWpQQnBob2tWemNvVXBYanlW?=
 =?utf-8?B?SXNCdVIyeDVTMUQwWlgzYVppRUhvSWRRc0RsMXNGUGdCVFAxVDgzaDJ4Rk1X?=
 =?utf-8?B?azFBdG1WV2dPaFJFdmJiN2ExWjhFZ3VlVVgwNWtZbVl2NmUvV21SbWRyMjh0?=
 =?utf-8?B?V0RpTUpvTEs2a21icHZJVC9NOGM0N3dtSWpoZEtTZUVBQVNkaXZmb0l6ZmNw?=
 =?utf-8?B?aFE5aTNrdmhKUFpQR1JTMnduVWhmYzVNTFBZdU5SRnJRdXd5MER0YjBXdUZz?=
 =?utf-8?Q?ksLdH6CMbUNUqF/ut9yVopc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8230E92324CE144C9E888184438EA2C6@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 12166f38-7f2e-4f8c-1e92-08daaf975767
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2022 16:56:16.7176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6gOVzy8FN3cYOFnhe69RIe6RcIWjpe1su3AIpZ9WWU6KUfh49ZS/ZwVlMl+GyjpJGPBl9R0+nLAZ7+ny2DHkDwNTRPKSE0bCImS1YdWL6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB1430
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SSdtIG1vcmUgZm9jdXNzZWQgb24gcG93ZXJwYzMyDQoNCisgQWRkaW5nIGxpbnV4cHBjLWRldiwg
c29tZW9uZSBlbHNlIG1pZ2h0IGhlbHAuDQoNCkxlIDE2LzEwLzIwMjIgw6AgMTM6NTEsIEFybmQg
QmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4gT24gU3VuLCBPY3QgMTYsIDIwMjIsIGF0IDk6NTQgQU0s
IEFsZXhhbmRlciBHb3JkZWV2IHdyb3RlOg0KPj4gT24gV2VkLCBPY3QgMTIsIDIwMjIgYXQgMTI6
Mzk6MTFQTSArMDIwMCwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4+PiAiU29tZSIgbWVhbnMgZXhh
Y3RseSBwb3dlcnBjNjQsIHJpZ2h0PyBJdCBsb29rcyBsaWtlIG1pY3JvYmxhemUNCj4+PiBhbmQg
cG93ZXJwYzMyIHN0aWxsIHNoYXJlIHNvbWUgb2YgdGhpcyBjb2RlLCBidXQgZWZmZWN0aXZlbHkN
Cj4+PiBqdXN0IHVzZSB0aGUgdm1hbGxvYyBhcmVhIG9uY2UgdGhlIHNsYWIgYWxsb2NhdG9yIGlz
IHVwLg0KPj4+DQo+Pj4gSXMgdGhlIHNwZWNpYWwgY2FzZSBzdGlsbCB1c2VmdWwgZm9yIHBvd2Vy
cGM2NCBvciBjb3VsZCB0aGlzIGJlDQo+Pj4gY2hhbmdlZCB0byBkbyBpdCB0aGUgc2FtZSBhcyBl
dmVyeXRoaW5nIGVsc2U/DQo+Pg0KPj4gT3IgbWFrZSBpdCB0aGUgb3RoZXIgd2F5IGFyb3VuZCBh
bmQgc2V0IElPUkVNQVBfU1RBUlQvSU9SRU1BUF9FTkQNCj4+IHRvIFZNQUxMT0NfU1RBUlQvVk1B
TExPQ19FTkQgYnkgZGVmYXVsdD8NCj4gDQo+IFN1cmUsIGlmIHRoZXJlIGlzIGEgcmVhc29uIGZv
ciBhY3R1YWxseSBtYWtpbmcgdGhlbSBkaWZmZXJlbnQuDQo+ICBGcm9tIHRoZSBnaXQgaGlzdG9y
eSwgaXQgYXBwZWFycyB0aGF0IGJlZm9yZSBjb21taXQgM2Q1MTM0ZWU4MzQxDQo+ICgiW1BPV0VS
UENdIFJld3JpdGUgSU8gYWxsb2NhdGlvbiAmIG1hcHBpbmcgb24gcG93ZXJwYzY0IiksIHRoZQ0K
PiBpb3JlbWFwKCkgYW5kIHZtYWxsb2MoKSBoYW5kbGluZyB3YXMgbGFyZ2VseSBkdXBsaWNhdGVk
LiBCZW4NCj4gY2xlYW5lZCBpdCB1cCBieSBtYWtpbmcgbW9zdCBvZiB0aGUgaW1wbGVtZW50YXRp
b24gc2hhcmVkIGJ1dCBsZWZ0DQo+IHRoZSBzZXBhcmF0ZSBhZGRyZXNzIHNwYWNlcy4NCj4gDQo+
IE15IGd1ZXNzIGlzIHRoYXQgdGhlcmUgd2FzIG5vIHRlY2huaWNhbCByZWFzb24gZm9yIHRoaXMs
IG90aGVyDQo+IHRoYW4gaGF2aW5nIG5vIHJlYXNvbiB0byBjaGFuZ2UgdGhlIGJlaGF2aW9yIGF0
IHRoZSB0aW1lLg0KPiANCj4gICAgICAgICBBcm5k
