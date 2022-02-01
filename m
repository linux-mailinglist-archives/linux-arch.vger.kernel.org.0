Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF094A5B15
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 12:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiBALXa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 06:23:30 -0500
Received: from mail-eopbgr90049.outbound.protection.outlook.com ([40.107.9.49]:31832
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233102AbiBALX3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Feb 2022 06:23:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKhIZmmqu5OdxFTI/AF2D6bwgJH8xX7y7mon4VuyutfOkeUdNPLY2a9AbOZADHXTPJQaLPq9XiKEgtYrzyzPku7O1CC5BeK9J1gBE9nkYJr+GQ2v2sHTuCPlnZaL8XBsghCw/Iq4pbtG6wDWnL7/3Pz5iZAudHTgJTGvraCGo77qvD4iP7Rnu35aD4WYEmVy9PIuC3TBSIs+v2s2lM5MVIoIYpHrgemFzW/lGbvwkQB0HlxEuwyuFRLPrWfHc7bsbEZWVYIpWN2bOrIUlsjDSM+s9DKR5ncom+6+Hh2Z+GbeAkZD82P1TKFzew7hQQ8IA+BG2BlUC288/hd6k6BrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gs2FxEVNLo6MNQdjxwVnZZ7kRzquSBwVvwMBUlMHOU=;
 b=SqzwSDPDEy3SU/El6Fj18huyjZnDoFKF8c6WQii7ts/kU25F2PCjzHDSYZ6htv3AosUB0lvGI3A0C92w4wj+Vkk+/XoIgto3gGa/F1CrkuccL6Re60NDQ34MaSqcHiruavDH5BerobdwUg4LOrtWNZ4624y95HvQPkwnYiv2ZbljDvGVIbUAazKcYUotBTTzvUeeKGOkZWjb3/BE27MtUNEdfZ8wwgdue9KXVXOmitvH78CtFHQvC7c3Dx57hybawtYDUwU9wQd6s9kEsxi5d7sKbwvEd5lG/5YSEhHe1GqYRro4ITh8HZCiy8XuIqCBXTCqRlQO4W2U2CgwXHxA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1784.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Tue, 1 Feb 2022 11:23:26 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 11:23:26 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: consolidate the compat fcntl definitions v2
Thread-Topic: consolidate the compat fcntl definitions v2
Thread-Index: AQHYFm7TqAcQcIR8I0eC2BX/s6mvCax+j2OA
Date:   Tue, 1 Feb 2022 11:23:26 +0000
Message-ID: <7cd776d9-17bb-7990-f5d8-3b6e5f14d5df@csgroup.eu>
References: <20220131064933.3780271-1-hch@lst.de>
In-Reply-To: <20220131064933.3780271-1-hch@lst.de>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28db1cb0-98a7-48c1-26b6-08d9e5754429
x-ms-traffictypediagnostic: MRZP264MB1784:EE_
x-microsoft-antispam-prvs: <MRZP264MB1784FF0C9ECF492AFFDE9D33ED269@MRZP264MB1784.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LseynbMgYrDs1RdoSQ7BoVLkrUTl1Up2RsKAGM7LhIRpQim1Kakk4z2VuM99fqIOJPtgNWBx4aKOQGiOb6gYMTloRPQDYC+fS8efCE6gUj5ME9hM/iYTb52oblQke48kMEG023lEvzhukhQWg71J4WtyVzYJ7Eov9WcZXZXgCGi8RTRf3270dsKPxhG+2o1j0vGH2yUGp6ISM8iEiS8qK/V7vnVe0rOejeQOXpR9CcLmj/Ve6PhRc+aGDOfmEBdwrTQWwOrcMpBHQntGG79fT+ywlN4EakurQDaXogrgS8l8XQ2PaPd9TdnVVb1NXIQ9h/IIZctSY8h7yHp0/kWACrj2aGLhvvX5LT27+6H0QqkVXFUIy8VfZYXLQKlkNLZ9m/Nasmw8h2T38MwNLusa0zqRnegrnkyWoi1CVegEyg+hczmj/1HnYF2p+Png9HS31GcajP7hK3hFEByXjwJqjOj6VnmN3+ASnRrHVPLUTU5JwxNRN1MFYfREchJbtD8x2Nz4LcRJX60Y8uB8fjoO336NgCDrCA2sU3IozY/8xEunTBTXElnOpt76+f7USnax6sEtZVygOzhtZuzppu5GSocpMpGzu/w4gZt+4oAV6yrlU18QI91Xt8L0eJMqBScZ3ytS/4N9uHFeMT9u3pdxwPpL7RZ4vCP6TSYDe5xpU0HxUuNjcTuHeClCa98eqjOHpTRX1y2qIbF9bugwabNU3mp7CPQkZLqe2PrVhc8sYp2uj4FhaFW6HLDO+UpDheP4sn7hgtJmG1Qgvwd+CBdiKGzNYBedMWPg7R7+m4IApvyBJjtb054UFjY0Rt3PHD/7OTecMeaP0K7MXWwtXk9pSe16/xl3nU11iQJGiQeat8M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(76116006)(8936002)(66446008)(91956017)(6506007)(66476007)(966005)(6486002)(8676002)(64756008)(508600001)(316002)(6512007)(26005)(36756003)(110136005)(54906003)(31696002)(38100700002)(186003)(2616005)(86362001)(83380400001)(38070700005)(31686004)(7416002)(5660300002)(44832011)(122000001)(71200400001)(2906002)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGdQeHRuKzBHMWxMbFJMZUpxOG00ZUR2aENCSWtLNEFRa2dVZG9Pa0JNb1FX?=
 =?utf-8?B?ZUJXVTQ0NzJWYlEwaWwxbzVOUHk2N0MybW1uajErdmIwaG0zTDkrTlpnbTkw?=
 =?utf-8?B?bnJGdXVEcGhYdXd2RjVDNHViYUJzUXZtbDBjTDVhQ25NU1poMVRudWg5aTZ1?=
 =?utf-8?B?WHZIN3VmUGpneVJ5ekNBNm1va2krY1p2elhnK1U0UXUzRWZWNUNsY0RpRUY4?=
 =?utf-8?B?dTFHWU9memZMeGkzTUlDdmdQMmVUbUVTVkd3Mkg5cGRSZGNIMWttY0JkRUQv?=
 =?utf-8?B?d2RpTEZrR1UzUTQrRDVOSzlDd1NnbzE1ODlJTVFOa0tHVTZ3VHBrQnQ3Tmlh?=
 =?utf-8?B?T1VqdENKUlVvU2lzSE15bEUzV1NQYjFlUmljVllrZzBrTm9wWHVoQ0lHcWxJ?=
 =?utf-8?B?TGJ5RTg4VXhkS0VpODk0NXFXdlY0akE0VFJIaUlOaDVqQVpMaVN4TTdKanY5?=
 =?utf-8?B?VjJUTWxLSStNTmRwaWE0QUppYmg3OVpWbUVVNHR5eFBrcDZjS2JtOVBHS0xO?=
 =?utf-8?B?aE93MEtTUXZBRWFIaHhNYVZZRE03MHJqcm9vUFFGazFCbkh5ZWhqSG5COEZr?=
 =?utf-8?B?WGRneU11bHRLY2xlb2NQcXFvQXFKcVU5aFlMVE5vK3l1OWNRSUFOY0hhVU5l?=
 =?utf-8?B?SmZ6cUpOOHFWUlNMbHJ4cXpvRlB5cjJoZ2xCemZMbkdmQmRadzI3Y1Nqem8z?=
 =?utf-8?B?R2dTNFNwTGlDa252RXlzYjY3VTJMNWxuVkV0TkF5Q3ZhQ3V2V3RNbVhVeUw2?=
 =?utf-8?B?YUoyMzZKSk1sYVl5TUFSL1AyK0ZxeWVPdjdGRFZoUnNEd2d2SUlGZWJ5ZG9B?=
 =?utf-8?B?eHYzNE5zSDJ0WXZsb20zZXkrT2hVOExyRmRxbkJxVmxjUzRmc3pVdVZTNzht?=
 =?utf-8?B?anIxWXZnZExVMllVb002VHN6ZW1PYTJCdkp1MFRGUmg1d1U5RGF4bkJZK2Yy?=
 =?utf-8?B?cHVsM2pmZWE4N29OUHcxaXB5V3draXZla0xBRHljNVdiOVVVQ3crTlJRYzE4?=
 =?utf-8?B?NWgxQ2QrWWFyOG5KRGpRWjNFZFlFeDZmMng4Tmxsdjk4WHp3RXRkMGp2eTBC?=
 =?utf-8?B?VjNkWUl1NFFWWGxvcFV0VzlXaXdhWWVnbGtRNUpxeVFhMVFZL1k5aEowQ1l5?=
 =?utf-8?B?ZWM1UHg0T2tJVk9HbFNTNmZPM0ZYakJDOHlVRC8xRFFyaVhJUHhrM3IxcUZR?=
 =?utf-8?B?aTZyNUo0WVVKa1BkRW5CdEtSWXdkQndPclJhY2wycFc3Njh0QnU2RFJkK2Nh?=
 =?utf-8?B?cU0xM2k2ZmdsZkNnMWJRUDdJRnJmRklPUmdwczN6QnhNcmRhV2FIREFmVnhV?=
 =?utf-8?B?VERWdjFMZjRtMEh5ZzVIWEtSOVFPNnBoVm14Lys1OUdDb2k3RUlKUVBjRE5y?=
 =?utf-8?B?YXlMU3FhdlZGLzNheEhjSWwrUUxYTTg3OHVHTTRsTWhaR1I1N2VvNWRoZDJM?=
 =?utf-8?B?SW94RWdKejR4a1J4aEVSckdObGhqWlE2cEgzUGpaYUhrMnhlVVZIZTVXNE9T?=
 =?utf-8?B?K2hOTkVCMkgxeVlMMnMwTi9xZi9mL3NDdFJIMG1zcGRvd3FZakRQN05HaWw3?=
 =?utf-8?B?L3N2bGV4YmRveXlSeFdFQUg1eUtBM2FJeXo3RTIwbXNzZGV4SEFXZkRwaDN2?=
 =?utf-8?B?WGsyVFZXOVJtRXNtVjN3bHF3cXhBcXFRa3NhaG5taENZL2czbEVhSEJyc1k2?=
 =?utf-8?B?UlQwY2ZYa25DckxKSFY5a1Z1bStlRXpTWDB6UG5WdmIvTUREYXZoSUhkRzdu?=
 =?utf-8?B?TWs1bXJ5RS9SMjBpMEYvWW1valp2U3o2cVF5SmNHK0FRVFRmNmdnelAvZXE2?=
 =?utf-8?B?VFZVWGtNeWk3U210TkZDdG4zbHYzeUFSd2lVV0loTlRNdDBJNUc5ZzlQdUJl?=
 =?utf-8?B?Z3VkbEZIOGZWdVdxWlR0bmpQOUpRcUsvLzVtbXJycmJrOUhsMTdleFBjREpm?=
 =?utf-8?B?TW5OZGhvZW1TZXQzT2thK2JMNzAxeWxTZTdqTVJEaytkMDN0QVZROFRnVU02?=
 =?utf-8?B?bWpoekVPSnNqcUJ3VThtbFU4R21iZzBXNXRJZERjQkF1a1liS3JDS2tlQXNv?=
 =?utf-8?B?SzBKRFlVR2FpVjZPNHBtYmQ2Q0ZQTkIwbmlkanJaQkI1ajhObkExeFZhRkhE?=
 =?utf-8?B?eGVaM0JRdytRNzgzSFUrVElGeDhIeVErYUM2b2lxWmN2dHZwVlRkZlBmU2tY?=
 =?utf-8?B?dmo3WWhFV1B4M0piN0ltRUFzNkpiT200RHhhcDBPcmEwOG5rR0lzSVBHSHdt?=
 =?utf-8?Q?dK3jQbxMiofGIsZbjEs7NRTL0yimiEreKTx5R07M7Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <03C9CD2B03369246AD2B36AA1BB47472@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 28db1cb0-98a7-48c1-26b6-08d9e5754429
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 11:23:26.6336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKA/iMQ1SOLfrcLzOQXySxF4mPiZe5rtBpgOY9uliK1gg3T+suewXCpP5oD9QV3aEBzb0IcquJ4AxbccihhmQ99uV7tq+D+4pWPRvJ1TFaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1784
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpMZSAzMS8wMS8yMDIyIMOgIDA3OjQ5LCBDaHJpc3RvcGggSGVsbHdp
ZyBhIMOpY3JpdMKgOg0KPiBIaSBhbGwsDQo+IA0KPiBjdXJyZW50eSB0aGUgY29tcGF0IGZjbnQg
ZGVmaW5pdGlvbnMgYXJlIGR1cGxpY2F0ZSBmb3IgYWxsIGNvbXBhdA0KPiBhcmNoaXRlY3R1cmVz
LCBhbmQgdGhlIG5hdGl2ZSBmY250bDY0IGRlZmluaXRpb25zIGFyZW4ndCBldmVuIHVzYWJsZQ0K
PiBmcm9tIHVzZXJzcGFjZSBkdWUgdG8gYSBib2d1cyBDT05GSUdfNjRCSVQgaWZkZWYuICBUaGlz
IHNlcmllcyB0cmllcw0KPiB0byBzb3J0IG91dCBhbGwgdGhhdC4NCg0KVGhlcmUgbXVzdCBiZSBz
b21ldGhpbmcgd3Jvbmcgd2l0aCB0aGlzIGNvdmVyIGxldHRlciwgcGF0Y2h3b3JrIGRvZXNuJ3Qg
DQpzZWUgaXQsIHNlZSANCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9saW51
eHBwYy1kZXYvbGlzdC8/c3VibWl0dGVyPTgyDQoNCkFueSBpZGVhIHdoYXQgdGhlIHByb2JsZW0g
aXMgPw0KDQpUaGFua3MNCkNocmlzdG9waGUNCg0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4g
ICAtIG9ubHkgbWFrZSB0aGUgRio2NCBkZWZpbmVzIHVhcGkgdmlzaWJsZSBmb3IgMzItYml0IGFy
Y2hpdGVjdHVyZXMNCj4gDQo+IERpZmZzdGF0Og0KPiAgIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20v
Y29tcGF0LmggICAgICAgIHwgICAyMCAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gvbWlw
cy9pbmNsdWRlL2FzbS9jb21wYXQuaCAgICAgICAgIHwgICAyMyArKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgIGFyY2gvbWlwcy9pbmNsdWRlL3VhcGkvYXNtL2ZjbnRsLmggICAgIHwgICAzMCAr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBhcmNoL3BhcmlzYy9pbmNsdWRlL2Fz
bS9jb21wYXQuaCAgICAgICB8ICAgMTYgLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gvcG93ZXJw
Yy9pbmNsdWRlL2FzbS9jb21wYXQuaCAgICAgIHwgICAyMCAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAgIGFyY2gvczM5MC9pbmNsdWRlL2FzbS9jb21wYXQuaCAgICAgICAgIHwgICAyMCAtLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gvc3BhcmMvaW5jbHVkZS9hc20vY29tcGF0LmggICAgICAg
IHwgICAyMiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20v
Y29tcGF0LmggICAgICAgICAgfCAgIDI0ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGlu
Y2x1ZGUvbGludXgvY29tcGF0LmggICAgICAgICAgICAgICAgIHwgICAzMSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS91YXBpL2FzbS1nZW5lcmljL2ZjbnRsLmgg
ICAgICAgfCAgIDIzICsrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAgdG9vbHMvaW5jbHVkZS91
YXBpL2FzbS1nZW5lcmljL2ZjbnRsLmggfCAgIDIxICsrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAg
IDExIGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDE5MiBkZWxldGlvbnMoLSk=
