Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824964B4D08
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 12:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349929AbiBNLER (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 06:04:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242452AbiBNLEH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 06:04:07 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90055.outbound.protection.outlook.com [40.107.9.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9A98F68;
        Mon, 14 Feb 2022 02:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTMv+N0x+nO+1WBiMVMLfkem4buOLhUdVda1urOwV2gYiJeSr64+cKIFroUACKDl12fuTgykLOndlMUdvfHMQSKpT1QgSdtXzNDoxWTiqwnePyCtd6czBwYpgnGsMiVnQdwn29Q81sIYlvgXgMcqIuW0Z950reYzBrH+9t53qvxO6lpCqhFS3E8X2dtmfFlKudAce2zDq6ffnCZxTbKZGBQfcaEMg094QXhDriDRFIAM1xN2R3dwFDCLcA1Mhko4xOGC552ZhoACdVWSzPIGzNvviCx5mWSibjaO1AYDAQsOmT9jQGVg1Qcc/TxOD+/mksYiTA/oqksjpOMAN7onaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cuo4qimfKjBPuK/hoO6apT0bj6Z03RZibWibq0ra9SY=;
 b=mVr9cu5zIaUGY/uvtiFB9IlVN/n/L5hzRgvXZeqWwtTXIooGDDjE5Mf/brPFvYy65HbvOq/MhvoiZVhxd0WkBKZgbUhrGE/4A8kvpPCqPrcEEIPyPjLv1VxefN033fanIUYFJCNF6nArGm2Ek7S2wqJzBaGMt2g/c8egYFxdi7/xN1Fkise86Nto6vZVkyVguqazpG7GP+eUEA3BnPEwPQw1UjPE5Gqu2TZmx0k8HrrfOLKmQfrN6DY6VayfASONXmuCNJos6EKMZ4Vs4OvgRfdbKroah/Co9Ebnni2EKdbniaUGFnH1a5OFJA6QLqye+UwteQ8kB4rsv589Dq/vVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1439.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 10:32:08 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 10:32:08 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
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
Subject: Re: [PATCH v3 08/12] asm-generic: Refactor
 dereference_[kernel]_function_descriptor()
Thread-Topic: [PATCH v3 08/12] asm-generic: Refactor
 dereference_[kernel]_function_descriptor()
Thread-Index: AQHXw1P/PUxVyxRC4kaaREcUBcBn5ayNS9uAgADyA4CABVe0gA==
Date:   Mon, 14 Feb 2022 10:32:08 +0000
Message-ID: <5bb6160d-0f7b-ad2b-8933-3cb97a535b54@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <93a2006a5d90292baf69cb1c34af5785da53efde.1634457599.git.christophe.leroy@csgroup.eu>
 <8735kr814c.fsf@mpe.ellerman.id.au> <202202101655.13C794F0F@keescook>
In-Reply-To: <202202101655.13C794F0F@keescook>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 284c394f-a0fb-4f5f-2fe2-08d9efa5409c
x-ms-traffictypediagnostic: PR1P264MB1439:EE_
x-microsoft-antispam-prvs: <PR1P264MB14393A2BCD6EFEF0116B4DD8ED339@PR1P264MB1439.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fQhC+53FkY7fVzWKWzwwZ3uwU60C1eSwpvM192FugAX66P1ES1+eCTx0YTqaZcDJIceeb0XLN6CnXVjh17afO7sWHNHtH1IqpvuL3qMlwAPezqJCUN+w3wWqUVJFhp58vz/b84AxNq4bcrw97NqLRb6dqflrvJmVjL0Z1PBrfRjWQpTZMLot2GTq2FZ4DNyPsxAHRADDItlY0v9I50qoMVgkjRUv+0e37CM71Dyof09D0UOAksBti/6HpYO32eWwAxkXG/ZKXI+t7oO5pMqbNViphnFAQHveFGldkbBt9JEQPjUWcAuupq9XSkbCfMH1ounobfkbWbeq+W1YhjLUJ1UUFLgr/TMtAe/tAc2K4db1a/1QIiAdrm6KOTIFqCSBCS9SWEs8nQPelDNGvd1VInVEXSpJhoFCQdA2oS6jn4mSw4CE5DgwrZ9cfG7XD+o0x1OEgKZkGvINtRs/lcftnC13qflL6/EeQfGtm8uWTPsZ5O9r5K/LeSvY0mLxQxZtxrRgq0alvAtWYAPOu0WHPVw4eKv9wd5S7QZ45RpOXntq/Np3222mwWBcwUOj1nTgBUQzvE4gYviFDbH6tZ2MTsKH1MjGCJX5YXiEcQYLL5guEdY85y3qOGQMaxyQnJ4/GebWz+rVW0/gWTiadmP+zH1ooo4OW1iQKPOppYBaHU6DqLRb7zjQ6snsDlK71IG+DWmVD9GwDgDi8eD6/bTYkourSFZS010zCD6DyMMNBAoQIcof82XUTaioz16qMbINFBYBeLLFSe654ZnYMDZLR0I4/32HVsAJkv7WSxmg2QA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(5660300002)(44832011)(6506007)(31686004)(26005)(2906002)(7416002)(186003)(36756003)(2616005)(66574015)(66946007)(54906003)(110136005)(38070700005)(508600001)(6486002)(6512007)(122000001)(38100700002)(91956017)(71200400001)(316002)(86362001)(8676002)(4326008)(31696002)(66476007)(66556008)(76116006)(66446008)(64756008)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVVwZzdnK1EvUC9UOGEzMHNoVkhiVVpVODJoWWlKeStaN1VrMUNVeVFVTHQy?=
 =?utf-8?B?cnpuM1RsbUpOdTNHOEtGeXVjWCtFeDdPbDl1eWJ1bEZRTndIWG1STThHRU5E?=
 =?utf-8?B?NlR0cnBzZVd0blg4ODRITERzdVA3Sm1ueFpyT0NWcnhTUHNJZXM3Q2xraHVq?=
 =?utf-8?B?L1o2aVFjYktaZ3RMSWpqQ1dLV2RYNDlGdG9BQ0g1b0d5bGlKNm81OGwwemRP?=
 =?utf-8?B?SEptanY0ZzJJOVpaWU1VOWkyaEdwS3RzOWlRVHFUZDc2TDhqT0VCUHRvK3Vt?=
 =?utf-8?B?bEIrekorNmlYamIrSjAydnhaRVpxVG5JUHcyNy8zNmNMUmlhek9TREdqaFky?=
 =?utf-8?B?SkN4U2k4N3E0bHExNkJOY0xoa1hSaVUreUE4MGlpcWc1NXhDRVhOczFxRE8y?=
 =?utf-8?B?N1RrWkd0eldXcFhiKzlqODBQbXVtTi8vUlE5M1gzRTlFMCtQcUpUa2NhSjli?=
 =?utf-8?B?c3BQVHA0em9mWGlRdXlrRzllNnNqNnhRVzM1NFJVc3pLTkg1Vm1NL3p4cFVJ?=
 =?utf-8?B?TTF2TGxIUlo0TGh0aW1taFo5dFNFcHgrODd2WUNQbHZMYkFUTktoaHBCamFY?=
 =?utf-8?B?a1A1WU5BYUZtKzZ2b3pLUTU1cUFNMjY5RHBSM1FvTHZOSW1KbkY1WWlTZC9p?=
 =?utf-8?B?YlFZa0FTNkhpN3N3Nng0SjQ2VXVTOXNHR3RwV3FEWWs1czJYVm5tTkZBZzVa?=
 =?utf-8?B?U3pDZnlDeUpHSitPWHlRSVhTbDRnaWNHanBaMjVJSkt4dVZXV25SUlJDYk5I?=
 =?utf-8?B?NVlVSTduMXM2blJVSjlhbHVyWXJpMHJHdld1N0NReHBzNk5zc0xWTHNWR0FG?=
 =?utf-8?B?YkhsWC9hWGZQY1Bud1VPZU4razBqTDNBdU0zYXIrbDZIVXdad2ZYZ2MwQzND?=
 =?utf-8?B?dTZuQzBXTjJmR3lqN2ZOQWkwbGRxdTd5WjVocWxSSjRRMTM3dk5lUitoQ1h4?=
 =?utf-8?B?QTBPdmtDUmZVS1FDSTN3Z1ZDSGkvY2UrK2dKWVlpbk9zdWFXL3pLMmdwSXJ3?=
 =?utf-8?B?WlZ4ZUMvRGxieDU3ajFiWFFZMTBCWlF2d05RcmVTOVRIMSs4Q0ZSeStXbUxu?=
 =?utf-8?B?YXY3MnlVbVloRkZTNlkxdGdOekJ3V3hwVURqZGtCakxCV0pMb0UxcjgrYVd4?=
 =?utf-8?B?OXkyZXV4dVNhSXZPQ3dJNWkyN0ZpMEFjak9JVStYWkphbW1tVDBkdWdhMDIz?=
 =?utf-8?B?bjV5RVpwRFJPM0RjTEFLZ0J3T0pOZmxCb1c2VFdla0h2M1htck44RE8zcitY?=
 =?utf-8?B?MEdLVHdLR1NkZDV0VVR0RXpxT1M4MWt4T3p5eWt6RmhyVkNYSUNGZGZ0U245?=
 =?utf-8?B?a3BROXF6dFNIdHZPVHFjTWNsOXZjemd6ZHMzcEtzTFFLTGRkSjlaaW1GTnds?=
 =?utf-8?B?SVV5dG5zOW0vbmljUlFXYzhJU2JidWN3aWE2UGhXQjV4RmVBU1BEVU9Uc2k3?=
 =?utf-8?B?L1o4M3c3Q2ZPR1BQeTNHMWhhWVBYdVhMU1E3YkpVU0MxWHNwN1dISWpneFlV?=
 =?utf-8?B?NUhjdUZvck81cXRvVGp6OUw1M21pcXRIcGJTdVVzY1RCRTFpZjZNYW1tNE1F?=
 =?utf-8?B?RGJRNEZ1KzN4UXhOTGFKMmFMYWdncTVMMG1XWFFPYTFDeE9CWENta0ROTFk1?=
 =?utf-8?B?TzU3ZWR3ckZwT09MTkxGTFBzUVEvZTYvRSs4S3cxQTh0dGczazZNUzkzNFhG?=
 =?utf-8?B?a2l4cFc0UzFYdkY4S3o4SmljVHhmbjZkRzhxTlRvbmlGSFg1S1J1cEZrdVlX?=
 =?utf-8?B?bU5KZVFOM0paREtVMjBaS2NkclBrc1pTbEw1WmI2bFJZbUFPNWV0NzRJSkox?=
 =?utf-8?B?MFJCOHNqeXE3ZitnNXVLb2xZS1Z1MkhSeUdlNkhTQnpxWWphVkk5NXkxSERj?=
 =?utf-8?B?UG9xaTNRb2owN1ByMWEvdTR6RzU0eUJ0aXJycjJSMnQrOXB4UjlIdjNOZ3dv?=
 =?utf-8?B?Q2lsUXdzaFJjTU9hK25xME9GeXViTnJmVEdvbnMzekQwQjBXb29EU0ZGeDVw?=
 =?utf-8?B?anI4YmRyNmc0NU5hNjJESGdlbVZISEFIZUNIMldxbnZxWmhpckQzUlRXQUxI?=
 =?utf-8?B?VUM3OUVpTW9DRER2aDlGckUyN0JaMWkxNnZjQ1lVL1Fxa3Bmb0M3UUQ3dTBR?=
 =?utf-8?B?MzJML1VZSzR3UmNydjBjalFORXQ0WG1TREp3YUN1dTZhaFUwS21VLzBkYTll?=
 =?utf-8?B?eklDRUoxWEhEdWdDQW5xZW1wcjIyKzliMkVwUmNlZkw4Zk84YVZBTEM4MlJt?=
 =?utf-8?Q?d6r/lT8Z+fdjZa2vSo/sXd20us+GtkO9EN7tk6y55U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B58436803DD0049B0EEE7FEFBAFC545@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 284c394f-a0fb-4f5f-2fe2-08d9efa5409c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 10:32:08.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +c+uOljieL4tzyKN03yx0uMs17gbri3FdipkY+4IdliCCpCclQRP6A88yid+3jG8WNAPXikzQp1HkdA2tpZ5LTielZKX1Uj/DRvWjNQI1nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1439
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDExLzAyLzIwMjIgw6AgMDE6NTYsIEtlZXMgQ29vayBhIMOpY3JpdMKgOg0KPiBPbiBU
aHUsIEZlYiAxMCwgMjAyMiBhdCAwOTozMDo0M1BNICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdy
b3RlOg0KPj4gQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3
cml0ZXM6DQo+Pj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9leHRhYmxlLmMgYi9rZXJuZWwvZXh0YWJs
ZS5jDQo+Pj4gaW5kZXggYjBlYTVlYjBjM2I0Li4xZWYxMzc4OWJlYTkgMTAwNjQ0DQo+Pj4gLS0t
IGEva2VybmVsL2V4dGFibGUuYw0KPj4+ICsrKyBiL2tlcm5lbC9leHRhYmxlLmMNCj4+PiBAQCAt
MTU5LDEyICsxNjAsMzIgQEAgaW50IGtlcm5lbF90ZXh0X2FkZHJlc3ModW5zaWduZWQgbG9uZyBh
ZGRyKQ0KPj4+ICAgfQ0KPj4+ICAgDQo+Pj4gICAvKg0KPj4+IC0gKiBPbiBzb21lIGFyY2hpdGVj
dHVyZXMgKFBQQzY0LCBJQTY0KSBmdW5jdGlvbiBwb2ludGVycw0KPj4+ICsgKiBPbiBzb21lIGFy
Y2hpdGVjdHVyZXMgKFBQQzY0LCBJQTY0LCBQQVJJU0MpIGZ1bmN0aW9uIHBvaW50ZXJzDQo+Pj4g
ICAgKiBhcmUgYWN0dWFsbHkgb25seSB0b2tlbnMgdG8gc29tZSBkYXRhIHRoYXQgdGhlbiBob2xk
cyB0aGUNCj4+PiAgICAqIHJlYWwgZnVuY3Rpb24gYWRkcmVzcy4gQXMgYSByZXN1bHQsIHRvIGZp
bmQgaWYgYSBmdW5jdGlvbg0KPj4+ICAgICogcG9pbnRlciBpcyBwYXJ0IG9mIHRoZSBrZXJuZWwg
dGV4dCwgd2UgbmVlZCB0byBkbyBzb21lDQo+Pj4gICAgKiBzcGVjaWFsIGRlcmVmZXJlbmNpbmcg
Zmlyc3QuDQo+Pj4gICAgKi8NCj4+PiArI2lmZGVmIENPTkZJR19IQVZFX0ZVTkNUSU9OX0RFU0NS
SVBUT1JTDQo+Pj4gK3ZvaWQgKmRlcmVmZXJlbmNlX2Z1bmN0aW9uX2Rlc2NyaXB0b3Iodm9pZCAq
cHRyKQ0KPj4+ICt7DQo+Pj4gKwlmdW5jX2Rlc2NfdCAqZGVzYyA9IHB0cjsNCj4+PiArCXZvaWQg
KnA7DQo+Pj4gKw0KPj4+ICsJaWYgKCFnZXRfa2VybmVsX25vZmF1bHQocCwgKHZvaWQgKikmZGVz
Yy0+YWRkcikpDQo+Pj4gKwkJcHRyID0gcDsNCj4+PiArCXJldHVybiBwdHI7DQo+Pj4gK30NCj4+
DQo+PiBUaGlzIG5lZWRzIGFuIEVYUE9SVF9TWU1CT0xfR1BMKCksIG90aGVyd2lzZSB0aGUgYnVp
bGQgYnJlYWtzIGFmdGVyDQo+PiBwYXRjaCAxMCB3aXRoIENPTkZJR19MS0RUTT1tLg0KPiANCj4g
T2ggZ29vZCBjYXRjaCENCj4gDQo+IChUaGVyZSBoYXZlIGJlZW4gYSBmZXcgY2FzZXMgb2YgTEtE
VE09bSBiZWluZyB0aGUgb25seSB0aGluZyBuZWVkZWQgYQ0KPiBzeW1ib2wsIHNvIEkndmUgcG9u
ZGVyZWQgZ2l2aW5nIGl0IGEgbmFtZXNwYWNlIG9yIGNvbnN0cnVjdGluZyBhIGxpdHRsZQ0KPiBp
ZmRlZiB3cmFwcGVyLi4uIGJ1dCB0aGlzIHNlZW1zIG9rIHRvIGV4cG9ydC4uLikNCj4gDQoNCnBv
d2VycGMgYW5kIGlhNjQgaGFkIGl0IGFzIGEgc3RhdGljIGlubGluZSwgYnV0IHBhcmlzYyBoYWQg
aXQgYXMgYSBwbGFpbiANCmZ1bmN0aW9uIGFuZCBkaWRuJ3QgZXhwb3J0IGl0LiBTbyBJIGd1ZXNz
IHRoZSBleHBvcnQgaXMgbm90IHJlcXVpcmVkIGF0IA0KdGhpcyBwb2ludC4gSSB3aWxsIGV4cG9y
dCBpdCBpbiBwYXRjaCAxMCB3aGVuIGl0IGJlY29tZXMgbmVjZXNzYXJ5Lg0KDQpDaHJpc3RvcGhl
