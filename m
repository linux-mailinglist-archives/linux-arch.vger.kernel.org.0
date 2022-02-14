Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E014B4D67
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 12:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349590AbiBNLCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 06:02:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349913AbiBNLCi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 06:02:38 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90054.outbound.protection.outlook.com [40.107.9.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3E670919;
        Mon, 14 Feb 2022 02:30:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHkrWgHXD+NVxdRx67FV30n/kwCngx1CW+Rswy+2DJMoq5oWEsRRt6B1t5ZmlCPWMxi/fIeW1cpQWVfhlfnhTWyugSy7mmi2NE3iT8vBKjrmLafwjZjoKvntIXKkLGnU7AGP90EaxFhZ0dBdquUXrNpXdunkQnuE14D3webqBtOdnww9+tDILkQ+8Wz47vgGJefcZL4URk64xKMPN2owTJg3L+7qlbcjFKirfi1A/2Md1K8JVbQwhi/MseWz81tM+V4wGWtDJ+fEVCuDOP9aMFqwau23wT4ONrKSHeqQ6fPLTgN14JAZwJhs8wqAti+w2UuXsfA2c7E8Q4TM9Po8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yrIZ4Ac8HfUkS3lsqEjXIZe9RXc/XvRzhHvw1Lfw0k=;
 b=LCmrmUQ2O9nS+y0uY/lvgKTBXBScUrkiDeZAuhfTiPYSq0Zc94rgb6IlkFyJ3zJL1ITX41ytasiGNRjpuSstgjOx9kNEqmi31p99Ui/jZj8d+N4rMzm+aCw+oDKljQ+tjyvuwvPY7N/L3bcZL6GtCNhrAY+ong3RyJP/GwurBs/RX4Oiclujz0PsneSbeDl1f4zzxEtIgX/qojFggoUVA0ylMPTcT9GN0oZZJGTBu9curptlplB0STbE+FYdtu5Ha6vnOnuOLraMpAvi963I7QwQQZThmsXd1MXFnZ2QfEpq+vyPEZ8JKh8KHo1ESNKJgQsMFEsc0hd9vrrBnnEleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3510.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:142::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 10:30:01 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 10:30:01 +0000
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
Subject: Re: [PATCH v3 04/12] powerpc: Prepare func_desc_t for refactorisation
Thread-Topic: [PATCH v3 04/12] powerpc: Prepare func_desc_t for
 refactorisation
Thread-Index: AQHXw1QAqD3BcQqvOUWqJwkBvd6/KqyOPUwAgAVXsIA=
Date:   Mon, 14 Feb 2022 10:30:01 +0000
Message-ID: <c06fb573-d133-11d5-c56a-0766f8f7e401@csgroup.eu>
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <86c393ce0a6f603f94e6d2ceca08d535f654bb23.1634457599.git.christophe.leroy@csgroup.eu>
 <202202101653.9128E58B84@keescook>
In-Reply-To: <202202101653.9128E58B84@keescook>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1824636f-85ba-46ba-4bf9-08d9efa4f541
x-ms-traffictypediagnostic: PR1P264MB3510:EE_
x-microsoft-antispam-prvs: <PR1P264MB3510C725B98E72D2CF772D8EED339@PR1P264MB3510.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBMrmUJHCPpimf//B+UVBd93umoWcDE/C7AygSVPZtbfsu/wS/56mAi0RbjxiPQEybISytwe8DfVZm0mRVzHUsnTq+1arI/kiBHgaYDOhC9tnnIqOJsWWLJj/n+w7p9hSxrbKgtGdM5C+DAjUTfiD0EOAVtitEePMyJtBXenLqn33bUOet17FxiYRLGPpCZlQdyx+AS9ylAL1a11Svryj9MSWaDXMZGXntmPOskjwYVq5rgSmEj9VX6qIb643HvamfRAvHiw+rIu2Liy7KB/0t8rBYDF2X/HFZMRu6FaG0WD651k+tTRJAKuPYL26GcdENT61cMGx6SEg6lUqT317iwFw+7DYYoCKOisr1GKM+N7taaTO/ybsGnV0K3pwoaQ5eVm5Y3X7kOw9euHYdpHfcfZbKb7kqlBjBvWo3ONWtk8T/e8USd8KrpS4bIqOOpeaxNJkPqoM9ZxeRwKne9XpIj/4NLesW6M88XduPm9Of96twY0V+o3bA/zYAjOzlzJggOiJfZY6xdGl5lTsTfL/TLT8zLPHsAXnJXzzQmJQLVvKWrSBGKr/AlnfDhrf8aQAeoGmI/pyLTUWuJ3L4QP9kVbEpdKAAl6q9hAkx/hR5ZT8dGz02BxXbKFbrDPfnVw+i6UO4R4NidZOhz4aKElOHpWxCdkLuyabzULcgIBRaE0o9OruYuqUd0nfNmz/jRm9I8h5ElhoTc1fVhMHqn7VYAEjZw5kLLR8y6V4WaK73GPF2YhmxWJaVJ1EBhDKEVbK5RIqanReFv1rk2bzQW78Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(508600001)(186003)(26005)(83380400001)(31686004)(2616005)(66476007)(66446008)(64756008)(8676002)(66556008)(31696002)(6486002)(122000001)(36756003)(4326008)(5660300002)(38100700002)(76116006)(6916009)(7416002)(38070700005)(71200400001)(54906003)(66946007)(2906002)(8936002)(91956017)(86362001)(316002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2kvQVdxL3V4bDhURUdQTmJPS015UXNwZGxxb3NGR3ovb0Z5UERtTVhCbFhl?=
 =?utf-8?B?R3FXN3d1RjFYZmhsb0VqL2xLOEkzWGZpZnVCcklPRTZVTGZPK0ZrTHZvcW5h?=
 =?utf-8?B?L0pXQ0JYMU5rbDlnalpucit3VFFOR2pGWHRsbVZWT291MzY0V2taRHNVb29K?=
 =?utf-8?B?MTljYmJxOFZGdDhHMGNWRHorUXlJTkNrV01BZml0RDBncSs0TEh0aUU4K1VQ?=
 =?utf-8?B?eCt1eTNOcjlKOXF6ank1UUpaS1dNRGRQcEZFRlU1OUw4cG40YndUdnJSVytO?=
 =?utf-8?B?aXZNbWtKcFJPY2h2VXd1OW9SNkdwM25majhMa3VGQXpSeXVaUUNPUVQ4Qmt5?=
 =?utf-8?B?Yld3OXdIak9LcmZpMHdPUFpoaExubGxUV3ZVRnZ2RWZwZzlKcUduc1p2WE11?=
 =?utf-8?B?SEtYenZBWkIzaExvR1M3aWdTa1llTVkzR3ZwaFlmd0RFMXBRK01YQmo2UWpV?=
 =?utf-8?B?YzRzWFNHS0UvYlhMRjdwUFV5QW9pRjZPeXJYV0NRT2ZUV3kzZGtRdTBUZUVG?=
 =?utf-8?B?K2tkVzZQMXJscVBXd051eFpwQ3N1QXJHRjFIaWk1YVNDTTZVYVVQRG5sOUZN?=
 =?utf-8?B?eVB5eURRd2ZyTUFldS9oSG4wYXFzLzhNN2xoUklkQkV6SloxTUJFcjYwakdj?=
 =?utf-8?B?b3F0aGJjUkhla3ZmaXJOMUpwREQ4QmpIcVA0WUNPNjVnTlo3VTZ3aXVEdkF0?=
 =?utf-8?B?NEVNTUhJWjJuT0hxbWg5SmRKaXJyRE8yb0NvOXgzRkF0ekQvazNpOFgxSlcw?=
 =?utf-8?B?M1hQb1VlcjNnRTRIWDh0bStkMm9hVlJ6MWRBM2RDUjFDVzQwZzNpbmNVWll5?=
 =?utf-8?B?Y2s0WlJCZjU1ckcyNmFpQlgycmtvU1Myc1lraEtXMU1uMmJaaWI0dk10dlp3?=
 =?utf-8?B?SkplcloyVXEweHIyYm5mMVVkcXg2QzF1SytGdGlXWWlJWFFRVGtGQmo1R01w?=
 =?utf-8?B?TmMxY080c1V0bXRLM3BDeFd3UHdFQmRMN1oyMDA2REdRNmowMENsbDhjN01T?=
 =?utf-8?B?ZWZLK2I3aVRmeDE0VldHRDUzTGg4U2xpdkY5OFRVdXBNZGlBTUJTWk1VRysv?=
 =?utf-8?B?SlRVSjBWaTVjaDA2V2JnNkRXbzZSejAyNUhMY2ZnQ1cra3NDTHpWNGFZZmFq?=
 =?utf-8?B?TjkvSzNZVjBjaHhSUUIwT1JvaUFlV0t0WllreUdlKzhldEF4V1Yra1dhN0ZY?=
 =?utf-8?B?enRLR1pIQXltNndtN3ZpWG8yZytNdVdtT0g0Qk15czRtZDI4UFcrVXIzSGVG?=
 =?utf-8?B?bzE5ZlhhNzBWbmdsbmtvSzliVzJwWHc4dTZUdC9VMVhkUGJnTVR2Szhva29P?=
 =?utf-8?B?S3hDOTMvMTQ1dnJRd2hwYlIwQlBGNTh6ektCQkhUWFZ3cy9zSjZqaHZsR2Js?=
 =?utf-8?B?RXNPaThnRHFVUVFhTDFXUDJTUXV3bE5CQWdwTm95emQzMS9OOENhaDlRcklr?=
 =?utf-8?B?MHVUWnhRTGdXNE12M29lcDQxWmp0dzIwMU5oYzhFQjVXTFlLL2UzR2xtUG9E?=
 =?utf-8?B?MGdkREV2elVWMVdoZTZvWldlS0NMcHF0N3hzd0pkQ2lzVTRzU3Jrd2ZhK1RX?=
 =?utf-8?B?SmxqcXM3Y3RheFFqeDBBMnB5RzN0VFJ5REhQcWdKTlA1RkY4UHI1bzY2bUJ5?=
 =?utf-8?B?bTk1eXNSMUZwV1NHU2kvVENaZVFRRE9IUEo0dXZ4cWpzNmVPbGo2L0M1ajBG?=
 =?utf-8?B?cm9aK2JINW5LOXdhNGJVUUF2L3poZ1BmMnBRTUx5TmlOdm1ZRnc0YytiYmxo?=
 =?utf-8?B?dDgyRHB3MVBodERka3lvVjEvWDlHQlcvUlN3WWtSRjhkbXBlNGtjazhtbS8w?=
 =?utf-8?B?K21WaW5vQTNmTnRNTVpRbDV4VE4yOC9KelVrd291MkJ3MXB1c1BnNG5uT2ZQ?=
 =?utf-8?B?T2lRNWVaWVRldGlLOWNZbmZOclBrY2dkdS9vZXlKZW9BL1hUSGZwaWRDSFJC?=
 =?utf-8?B?RG4zcnZJTXVRS2gyUmhrTkl0UFo1SjE0WDRMWERjeXdXMWNoTzZlaHovUEZH?=
 =?utf-8?B?dmdhM3AxN2VTWTBBdXBDVmxpaFBqS294ZUk2VUZhMWZvZTlsS0VJb21QMW9i?=
 =?utf-8?B?UGd5dDR4OWdIZnFEbjNLRllOZXRrZ2FQcnNrN0ZjbmtsbGFDalFHNDlzcW1t?=
 =?utf-8?B?VElDQ01RQzdhWUFjV3N6UDlKUzdsV0dhL0NTZldKbmZnT2tiTHJlQzE1WW0v?=
 =?utf-8?B?S3RBeG5DM01aaUJsUUYvUmxyZmlSV0w2UVZ1VkY2U3p5anludk9ieVZSQTdW?=
 =?utf-8?Q?IM5CZux3vpOIGdbA1NQVhCz3kjND6Qylc1cYKng0dk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36F60662858D1A48953FCA93F2D89ED1@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1824636f-85ba-46ba-4bf9-08d9efa4f541
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 10:30:01.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xi6AWc/Sk9bhXfBaQNFMxWOpzjWm/fRy0nQoJW47DofbicD71L5jaXr1QKNSZGJnEOHyhuFmEn93rrryUnJaFtqSxprpm4XvaGsMs5bVlag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3510
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDExLzAyLzIwMjIgw6AgMDE6NTQsIEtlZXMgQ29vayBhIMOpY3JpdMKgOg0KPiBPbiBT
dW4sIE9jdCAxNywgMjAyMSBhdCAwMjozODoxN1BNICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdy
b3RlOg0KPj4gSW4gcHJlcGFyYXRpb24gb2YgbWFraW5nIGZ1bmNfZGVzY190IGdlbmVyaWMsIGNo
YW5nZSB0aGUgRUxGdjINCj4+IHZlcnNpb24gdG8gYSBzdHJ1Y3QgY29udGFpbmluZyAnYWRkcicg
ZWxlbWVudC4NCj4+DQo+PiBUaGlzIGFsbG93cyB1c2luZyBzaW5nbGUgaGVscGVycyBjb21tb24g
dG8gRUxGdjEgYW5kIEVMRnYyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waGUgTGVy
b3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCj4+IC0tLQ0KPj4gICBhcmNoL3Bvd2Vy
cGMva2VybmVsL21vZHVsZV82NC5jIHwgMzIgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMva2VybmVsL21vZHVsZV82NC5jIGIv
YXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1bGVfNjQuYw0KPj4gaW5kZXggYTg5ZGEwZWUyNWUyLi5i
Njg3ZWY4OGM0YzQgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3Bvd2VycGMva2VybmVsL21vZHVsZV82
NC5jDQo+PiArKysgYi9hcmNoL3Bvd2VycGMva2VybmVsL21vZHVsZV82NC5jDQo+PiBAQCAtMzMs
MTkgKzMzLDEzIEBADQo+PiAgICNpZmRlZiBQUEM2NF9FTEZfQUJJX3YyDQo+PiAgIA0KPj4gICAv
KiBBbiBhZGRyZXNzIGlzIHNpbXBseSB0aGUgYWRkcmVzcyBvZiB0aGUgZnVuY3Rpb24uICovDQo+
PiAtdHlwZWRlZiB1bnNpZ25lZCBsb25nIGZ1bmNfZGVzY190Ow0KPj4gK3R5cGVkZWYgc3RydWN0
IHsNCj4+ICsJdW5zaWduZWQgbG9uZyBhZGRyOw0KPj4gK30gZnVuY19kZXNjX3Q7DQo+PiAgIA0K
Pj4gICBzdGF0aWMgZnVuY19kZXNjX3QgZnVuY19kZXNjKHVuc2lnbmVkIGxvbmcgYWRkcikNCj4+
ICAgew0KPj4gLQlyZXR1cm4gYWRkcjsNCj4+IC19DQo+PiAtc3RhdGljIHVuc2lnbmVkIGxvbmcg
ZnVuY19hZGRyKHVuc2lnbmVkIGxvbmcgYWRkcikNCj4+IC17DQo+PiAtCXJldHVybiBhZGRyOw0K
Pj4gLX0NCj4+IC1zdGF0aWMgdW5zaWduZWQgbG9uZyBzdHViX2Z1bmNfYWRkcihmdW5jX2Rlc2Nf
dCBmdW5jKQ0KPj4gLXsNCj4+IC0JcmV0dXJuIGZ1bmM7DQo+PiArCXJldHVybiAoZnVuY19kZXNj
X3Qpe2FkZHJ9Ow0KPiANCj4gVGhlcmUncyBvbmx5IDEgZWxlbWVudCBpbiB0aGUgc3RydWN0LCBz
byBva2F5LCBidXQgaXQgaHVydCBteSBleWVzIGENCj4gbGl0dGxlLiBJIHdvdWxkIGhhdmUgYmVl
biBoYXBwaWVyIHdpdGg6DQo+IA0KPiAJcmV0dXJuIChmdW5jX2Rlc2NfdCl7IC5hZGRyID0gYWRk
cjsgfTsNCj4gDQo+IEJ1dCBvZiBjb3Vyc2UgdGhhdCBhbHNvIGxvb2tzIGJvbmtlcnMgYmVjYXVz
ZSBpdCBzdGFydHMgd2l0aCAicmV0dXJuIi4NCj4gU28gbm8gbWF0dGVyIHdoYXQgSSBkbyBteSBl
eWVzIGJ1ZyBvdXQuIDspDQo+IA0KPiBTbyBpdCdzIGZpbmUgZWl0aGVyIHdheS4gOikNCj4gDQo+
IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCg0KSSBhbSBn
b2luZyBmb3I6DQoNCiAgc3RhdGljIGZ1bmNfZGVzY190IGZ1bmNfZGVzYyh1bnNpZ25lZCBsb25n
IGFkZHIpDQogIHsNCisgICAgICAgZnVuY19kZXNjX3QgZGVzYyA9IHsNCisgICAgICAgICAgICAg
ICAuYWRkciA9IGFkZHIsDQorICAgICAgIH07DQorDQorICAgICAgIHJldHVybiBkZXNjOw0KICB9
DQoNCg0KVGhhbmtzDQpDaHJpc3RvcGhl
