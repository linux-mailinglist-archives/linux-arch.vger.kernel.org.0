Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0596BF932
	for <lists+linux-arch@lfdr.de>; Sat, 18 Mar 2023 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCRJT0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 05:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRJTZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 05:19:25 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2059.outbound.protection.outlook.com [40.107.9.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101EF3D90C;
        Sat, 18 Mar 2023 02:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwCvzuJWfh+ccnvNO4JXLV3KsnNXJXk1ys/TqsdvPHd17X4mOhODGpJ0W/v8KId772V7OXCBhNB9UEphrZ2X7cB9baeXPtHx2PBNkxLkXQ/VwbrsznT6GPe9Akh2SwTWng7P7lRTFcpO2wd9l6olJzoaHdQ0QCx6DxkmQ5xUT9nF4geH261sraf+nhyyVlDNMMn9UP0vaoLYk+cgPzbOab627pvDxLnAAT/pbw3AV4Ovz3ECz8Y0HtGcdcEbOsyWM/upzUZSf3P0A2Qb7OyLvSTqtmT1+b3Xp/Pnchhlcvp9g4uZaeEx2jkUW3yis7jKOtr2V/zorC7mCCZ2f4oJRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOu4N1Mk1yKz2OGkRaLadEiAp9QP9iPff9AgchXuXBA=;
 b=nSCHfWHe+EfLHuKaUv5uUL5p6Me3DJvjDwQgsFvjRt/jGtRSiF+HEDPHaZjnshMd/eahkzzs03XfO4PPInWxX2tk488bjAQR/xjYVwKLyIh5qfedLUPYGWnBzxijt6Ak87zXEZQHS3YYXa52sZZ/1FA8XN9RehSrkNxrxd+tzFrB1wriheYgpRJu4e4rg6zg67m167bxT2Byn9a5YnPgaZRjayYGlMXCqJOS+nzG6KKiVzsF/c/aVRKCsBVXnTweg/9Ya7rzyYZSsqXlaYOwNJjaPkO91AACc6gTSCr+sqiV2jhZWPEkDkP1QElsZDUsb/q5tI7DPRFsrsJMkMZUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOu4N1Mk1yKz2OGkRaLadEiAp9QP9iPff9AgchXuXBA=;
 b=KMcxTqS9dNS261BbTiQl/DGAttHBF1mYw5qTPPVgZrDgKLPJfTdz9+MkK9ygCwxzQNHZ3D5sTRzsRuXcA8OxhefUpV+04bIZSOKeWJCAX4/PB28TGA4rQmAF4m11arx+h/BeXbrlOBUD8wKSgrbH/6YgW8bmGp3nhL7ZunKGd5hPVCRPu7rI+zOSWIVWrg0pkmTkALpFXERHFhrLCdLJG/PfFrFIgpNbJOsDl7Ysb5MuU+nIq8t/MjRSiIvxoKgTI4DBz+jyHpQY1R5OcWKkoCfq85NVBJTE7a3i5Zt5CCw80rsEBKYX/i4luL15XSQl9s0WFeqVTJ+77AVaMHBmMQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB1927.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 09:19:04 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%8]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 09:19:04 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v4 20/36] powerpc: Implement the new page table range API
Thread-Topic: [PATCH v4 20/36] powerpc: Implement the new page table range API
Thread-Index: AQHZVv0YjMzoz9l+LU6zj9tdkgq+2a77l0WAgAAJsQCAArduAIAB7v6A
Date:   Sat, 18 Mar 2023 09:19:04 +0000
Message-ID: <eb8ad2f2-06ae-4daf-5163-11b950e640ad@csgroup.eu>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-21-willy@infradead.org>
 <1743d96f-8efe-0127-2cae-7368ce0eb2e6@csgroup.eu>
 <c7f08247-8bcd-184c-5e06-91f91257f1f6@csgroup.eu>
 <ZBPizB6TmDp0psOl@casper.infradead.org>
In-Reply-To: <ZBPizB6TmDp0psOl@casper.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB1927:EE_
x-ms-office365-filtering-correlation-id: 2c12e85a-0a33-4e70-2c5d-08db2791d17c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FdZtzWC/LwpM6ErBwQ/dhGLJTXYGzKi3bDkDItM7YD8qnDZ+mwMLrLtJGtavC8pjZ53wRNmFOb0ByY94zYblsl+lsD+hg4/nCL4FoS0lI1qrpWlHQU9fAfO2Tmyqyz7qI/tu4cuqoipJe6yeh6CIj/I7t47j4w5wY3DDL1EFuyvlJc2LLyh1MODUWKio278l+M5xZuzRcuBxjJmFEccAeOrtTla1MNkpch03hMjxaykXtPO2do93IuBmRGjRbebssNM4SCqIp3MY79SQL+PwDcAA1tiElte0H3V7dDppp34GkNY7YbDiI0GNb1DUfUHfMbHiMivki9ghRxzY2Ipi1HNUI0gJRf8w386I30KfrKDwI8O588+HAy+Phx0hoMiYrQ3y+O0UUvEiY4y9lZs0ZaHoo4xUuGRY+RCLLUhnUjQwGYCMWRmKZc2P3qUdJvyMRo6OJr6MOOgrygcSq2VC3VDJ8frvNLFGscVSMuhpGRgFryCf+Vrbba9Vr93ldRrvie1LXAnHjUk4sAn4B0/dPDoUZc6vznT8LioIkFTv5bpfeQ4Xmajcys4YNwWTObjmD7PRAQKlk6TNLlTqn9tXSJJ/ma876/JHSuQsZ4YioFrdhNA1uiWdX/IDXmKYvkjlKPf7PCYGvOQrq2Xm6Cmw6YSHcP6r7gqrncccqqXocBeEtuRSlI9HC7Vson62tQgYDVHhezM9U5EcDQoHqKaEQqNP2BmxZWDoOI4Pll+pWJAsipSWGgbRiItRqVt2j5Vx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39850400004)(366004)(376002)(136003)(451199018)(31686004)(2906002)(966005)(71200400001)(6486002)(478600001)(36756003)(86362001)(38070700005)(31696002)(2616005)(83380400001)(38100700002)(122000001)(66574015)(8936002)(4326008)(5660300002)(6916009)(316002)(44832011)(26005)(6512007)(186003)(6506007)(41300700001)(54906003)(91956017)(76116006)(66446008)(64756008)(66946007)(8676002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHRDK3IyZUJhaC9ReUpId2p0aStOdks3eVFhOE45Tlh6bXdiYkR2d0huZXBo?=
 =?utf-8?B?S2ZwVEtLQ0FqMTlyREpYSHRISDlHTm1jNjcrQk85alpDbmdBVlMvQi8rUnhr?=
 =?utf-8?B?U1NzeXhSY1NiaEY5Y3h6Wlc4a2xUdnJBVStlNjNZOTJLTkZYYS9xN1FGWXRW?=
 =?utf-8?B?cU40ZUlZa1JOVFkrOTVnSUh2Ris1UHZ3Vjh3R2NoR0xpa3BoU2VpSnJZNDhI?=
 =?utf-8?B?d2lIbzBpWFFNSXlHV1I2dHBFQmYydnVHRlk2SmNtcHBYUXl0MlBCOWpHSyt0?=
 =?utf-8?B?OWg5L044SWRCakhNU2x1dCtPWG5UNTVqVy9KQnIxRjYwZXJzNWlTYmlYMm9s?=
 =?utf-8?B?Y2tzaWVpNTBrVURRaVp2a1NNNTdwdlV3eGF5bFJVNnpWMW9hUmpNV2JXUDM1?=
 =?utf-8?B?elhnM0JkZ3BiTElYQzQvczh5RmNRR2tnZTV5Qnc3dWpHUUdPRk1ZMnZDUGdp?=
 =?utf-8?B?OGR4VEpaanBDeEQ4bHhCMkZYb2pwKzFNeEtlVVBiNGVMMmFrd0xBZEdQQ3Q2?=
 =?utf-8?B?VC95K3NyR1M3NHA3WUJPU0pJNmQxLzI1L2U4SGFzbWdKdnFnWHBPTktrYko5?=
 =?utf-8?B?MW1mNklWUWEvWWxSUkR1dkZwSURTcUoyZDhjWTR4anpuMmJDWmd3TVpiR1h3?=
 =?utf-8?B?TWtaRGpqWUZ6ZFU1UXlyVmZyeHFUWm5LTGdMdEhtS2tkODl5QWhmV3pDZ201?=
 =?utf-8?B?dzVOQW1XNjBRSi9tdWxNdFpqenNGY291eXNReGpsZzdXeWozNjZoeE9YbGZw?=
 =?utf-8?B?MmZxZ2tQN0hHNjgxL3h2QjhLQ3ZIZFJjNWIyNXc4UmZJazlZYyt6VXVuYlBB?=
 =?utf-8?B?clVUclNOQ2FVM2luUEcvYm00KzFNSitHQUJyYUdUekxTTG9TNG4xOXZ3T3pM?=
 =?utf-8?B?Y2R0RGNaSjNybk5qNzg4bEJVUi80Z1FZZUZ2aTlsV3BIM0llMlF2bjVMeXZF?=
 =?utf-8?B?N3NDQ2dNeW4vMDJ2aHN1TXpiZlZFU0NZZjZVam5zQWVOS2JNTndXbWw1RXJx?=
 =?utf-8?B?UC9qcTlUTnhZOXJiaHZsSEFobjJycDg0enFheGxZcHcwTmlWbE1BaEhrK3NE?=
 =?utf-8?B?eTNlVnhMMTBOODVMVGU1RjFjZTlOUWtJOUE3ZTFkQ0ZKVjZveFo4cHRpTTNB?=
 =?utf-8?B?cU1McFc0N0J1OWxRcDdObGN3Y0RnQld0VzRyTzNkQW94Q01QVzlXcUNMMWNm?=
 =?utf-8?B?b1NwS1hRUFhMUjA3ZGtXaEx5OUdwWmQ3UjRCM21ZbStuQ0IrSGY1YzZqUWto?=
 =?utf-8?B?MzlCRml3VHZLcXhaNXI3aTRoSlN3b0hxUGRXRGl2U3hha1ByNXhCcmxEanNx?=
 =?utf-8?B?bjFtU2tiWGhZQi9EbHFmUG40YmlhcHVYejBFMGZhdmZXNVdUTFA3ZWZacjNa?=
 =?utf-8?B?NkZiTllYVTVweTFOOFhQZXhQRzJadU9NRm1VNUlTOEE3Q0MrVmNYVEMxRHgr?=
 =?utf-8?B?bG1IZUpDckpyR3YrT3JET2xmU1RyTXJoVFZleUNpUUVhSlV0NFBITys0VmRC?=
 =?utf-8?B?dlhkQmlsOWZMWG9kMUdncFViSEFOYUcvbzlIV3lqSVFTQzVNdmlFZERGNWZC?=
 =?utf-8?B?WUJhcmVhS2ZDNmZQNXNCS0ltOWd3am8xUWlDbGVpblBic0ZFeStnWHJGMEts?=
 =?utf-8?B?bmExY05qencramZtKzhrKzZ5SG5zV2VTeG1WVjRHWWg3dWI3UzNVVTJ2UGFZ?=
 =?utf-8?B?VzFBYU5pWElGSnhuUS90M3FIUUhqbndDSzdGakNXSlhOY0VSUk5LbUtFTzY5?=
 =?utf-8?B?RFZlL0FrUHY0bzNWVCtqY3FxTjR4ZXBDd2ROWWJiN3hUaUlWaUNFRFR3MEJx?=
 =?utf-8?B?N2ZUdGtyWjB0a0hTbGtoY0k3RC81RkVEZkxLbzdTSjNLdTdaSy9YVWlzMzFx?=
 =?utf-8?B?U0JwYUtHaGxJcWNZS0JtZk55N1ZMK2hycldXcXhlUSsvUGhjeG55dG1kUldm?=
 =?utf-8?B?Y1ZES3FCaXo1QnJOUE9qZXdvMTFPRlhpWEZtcnVyWjdjWk8rSVYveG5aVWJR?=
 =?utf-8?B?V3hTbVlsSTE2T0JGQlI2YXBqT1RGOHkvU1hkck9VTlVUSWYvMHJGbGdLeXJh?=
 =?utf-8?B?STNKeEJzU2VabWFJVVp1YUxSWjhEenludjJOS21BbGNEMU96azY4SVN6OHBm?=
 =?utf-8?B?bDl3N2FBTHd4aGUzbWgwSVRlRGpYZ1UzWXJ2WHlQN2NnWk5ic1BXMnIwWmN0?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAE1C94924B53E498B727CF50712D610@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c12e85a-0a33-4e70-2c5d-08db2791d17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2023 09:19:04.0748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZFCyO+QuIi40KEzwfsbIP4DeuNlTVaU14sU7RebMbKtpgGjdHkpW58siGxCeZFjzoeUofvwOrAxna3umWCfFmTsnFJfEugTZzJLVPRhXyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1927
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE3LzAzLzIwMjMgw6AgMDQ6NDcsIE1hdHRoZXcgV2lsY294IGEgw6ljcml0wqA6DQo+
IE9uIFdlZCwgTWFyIDE1LCAyMDIzIGF0IDEwOjE4OjIyQU0gKzAwMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6DQo+PiBJIGludmVzdGlnYXRlZCBhIGJpdCBmdXJ0aGVyIGFuZCBjYW4gY29uZmly
bSBub3cgdGhhdCB0aGUgYWJvdmUgd29uJ3QNCj4+IGFsd2F5cyB3b3JrLCBzZWUgY29tbWVudA0K
Pj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMy1yYzIvc291cmNlL2FyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gvMzIvcGd0YWJsZS5oI0wxNDcNCj4+DQo+PiBBbmQg
dGhlbiB5b3Ugc2VlDQo+PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4zLXJj
Mi9zb3VyY2UvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL25vaGFzaC9wdGUtZTUwMC5oI0w2Mw0K
PiANCj4gR290IGl0LiAgSGVyZSdzIHdoYXQgSSBpbnRlbmQgdG8gZm9sZCBpbiBmb3IgdGhlIG5l
eHQgdmVyc2lvbjoNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
Ym9vazNzLzMyL3BndGFibGUuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvMzIv
cGd0YWJsZS5oDQo+IGluZGV4IDdiZjFmZTcyOTdjNi4uNWYxMmI5MzgyOTA5IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzMyL3BndGFibGUuaA0KPiArKysg
Yi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzMyL3BndGFibGUuaA0KPiBAQCAtNDYy
LDExICs0NjIsNiBAQCBzdGF0aWMgaW5saW5lIHB0ZV90IHBmbl9wdGUodW5zaWduZWQgbG9uZyBw
Zm4sIHBncHJvdF90IHBncHJvdCkNCj4gICAJCSAgICAgcGdwcm90X3ZhbChwZ3Byb3QpKTsNCj4g
ICB9DQo+ICAgDQo+IC1zdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgcHRlX3BmbihwdGVfdCBw
dGUpDQo+IC17DQo+IC0JcmV0dXJuIHB0ZV92YWwocHRlKSA+PiBQVEVfUlBOX1NISUZUOw0KPiAt
fQ0KPiAtDQo+ICAgLyogR2VuZXJpYyBtb2RpZmllcnMgZm9yIFBURSBiaXRzICovDQo+ICAgc3Rh
dGljIGlubGluZSBwdGVfdCBwdGVfd3Jwcm90ZWN0KHB0ZV90IHB0ZSkNCj4gICB7DQo+IGRpZmYg
LS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L3BndGFibGUuaCBiL2Fy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ib29rM3MvNjQvcGd0YWJsZS5oDQo+IGluZGV4IDRhY2M5
NjkwZjU5OS4uYzViYWEzMDgyYTVhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vYm9vazNzLzY0L3BndGFibGUuaA0KPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9h
c20vYm9vazNzLzY0L3BndGFibGUuaA0KPiBAQCAtMTA0LDYgKzEwNCw3IEBADQo+ICAgICogYW5k
IGV2ZXJ5IHRoaW5nIGJlbG93IFBBR0VfU0hJRlQ7DQo+ICAgICovDQo+ICAgI2RlZmluZSBQVEVf
UlBOX01BU0sJKCgoMVVMIDw8IF9QQUdFX1BBX01BWCkgLSAxKSAmIChQQUdFX01BU0spKQ0KPiAr
I2RlZmluZSBQVEVfUlBOX1NISUZUCVBBR0VfU0hJRlQNCj4gICAvKg0KPiAgICAqIHNldCBvZiBi
aXRzIG5vdCBjaGFuZ2VkIGluIHBtZF9tb2RpZnkuIEV2ZW4gdGhvdWdoIHdlIGhhdmUgaGFzaCBz
cGVjaWZpYyBiaXRzDQo+ICAgICogaW4gaGVyZSwgb24gcmFkaXggd2UgZXhwZWN0IHRoZW0gdG8g
YmUgemVyby4NCj4gQEAgLTU2OSwxMSArNTcwLDYgQEAgc3RhdGljIGlubGluZSBwdGVfdCBwZm5f
cHRlKHVuc2lnbmVkIGxvbmcgcGZuLCBwZ3Byb3RfdCBwZ3Byb3QpDQo+ICAgCXJldHVybiBfX3B0
ZSgoKHB0ZV9iYXNpY190KXBmbiA8PCBQQUdFX1NISUZUKSB8IHBncHJvdF92YWwocGdwcm90KSB8
IF9QQUdFX1BURSk7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25n
IHB0ZV9wZm4ocHRlX3QgcHRlKQ0KPiAtew0KPiAtCXJldHVybiAocHRlX3ZhbChwdGUpICYgUFRF
X1JQTl9NQVNLKSA+PiBQQUdFX1NISUZUOw0KPiAtfQ0KPiAtDQo+ICAgLyogR2VuZXJpYyBtb2Rp
ZmllcnMgZm9yIFBURSBiaXRzICovDQo+ICAgc3RhdGljIGlubGluZSBwdGVfdCBwdGVfd3Jwcm90
ZWN0KHB0ZV90IHB0ZSkNCj4gICB7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vbm9oYXNoL3BndGFibGUuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gv
cGd0YWJsZS5oDQo+IGluZGV4IDY5YTdkZDQ3YTlmMC4uMDNiZThiMjJhYWVhIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbm9oYXNoL3BndGFibGUuaA0KPiArKysgYi9h
cmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbm9oYXNoL3BndGFibGUuaA0KPiBAQCAtMTAxLDggKzEw
MSw2IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBwdGVfYWNjZXNzX3Blcm1pdHRlZChwdGVfdCBwdGUs
IGJvb2wgd3JpdGUpDQo+ICAgc3RhdGljIGlubGluZSBwdGVfdCBwZm5fcHRlKHVuc2lnbmVkIGxv
bmcgcGZuLCBwZ3Byb3RfdCBwZ3Byb3QpIHsNCj4gICAJcmV0dXJuIF9fcHRlKCgocHRlX2Jhc2lj
X3QpKHBmbikgPDwgUFRFX1JQTl9TSElGVCkgfA0KPiAgIAkJICAgICBwZ3Byb3RfdmFsKHBncHJv
dCkpOyB9DQo+IC1zdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgcHRlX3BmbihwdGVfdCBwdGUp
CXsNCj4gLQlyZXR1cm4gcHRlX3ZhbChwdGUpID4+IFBURV9SUE5fU0hJRlQ7IH0NCj4gICANCj4g
ICAvKiBHZW5lcmljIG1vZGlmaWVycyBmb3IgUFRFIGJpdHMgKi8NCj4gICBzdGF0aWMgaW5saW5l
IHB0ZV90IHB0ZV9leHByb3RlY3QocHRlX3QgcHRlKQ0KPiBAQCAtMjc5LDcgKzI3Nyw3IEBAIHN0
YXRpYyBpbmxpbmUgaW50IHB1ZF9odWdlKHB1ZF90IHB1ZCkNCj4gICB2b2lkIHVwZGF0ZV9tbXVf
Y2FjaGVfcmFuZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgYWRk
cmVzcywNCj4gICAJCXB0ZV90ICpwdGVwLCB1bnNpZ25lZCBpbnQgbnIpOw0KPiAgICNlbHNlDQo+
IC1zdGF0aWMgaW5saW5lIHZvaWQgdXBkYXRlX21tdV9jYWNoZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKnZtYSwNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB1cGRhdGVfbW11X2NhY2hlX3JhbmdlKHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KPiAgIAkJdW5zaWduZWQgbG9uZyBhZGRyZXNzLCBw
dGVfdCAqcHRlcCwgdW5zaWduZWQgaW50IG5yKSB7fQ0KPiAgICNlbmRpZg0KPiAgIA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BndGFibGUuaCBiL2FyY2gvcG93ZXJw
Yy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gaW5kZXggNjU2ZWNmMmIxMGNkLi40OTFhMjcyMGY4
MzUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4g
KysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiBAQCAtNTQsNiArNTQs
MTIgQEAgdm9pZCBzZXRfcHRlcyhzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQgbG9uZyBh
ZGRyLCBwdGVfdCAqcHRlcCwNCj4gICAvKiBLZWVwIHRoZXNlIGFzIGEgbWFjcm9zIHRvIGF2b2lk
IGluY2x1ZGUgZGVwZW5kZW5jeSBtZXNzICovDQo+ICAgI2RlZmluZSBwdGVfcGFnZSh4KQkJcGZu
X3RvX3BhZ2UocHRlX3Bmbih4KSkNCj4gICAjZGVmaW5lIG1rX3B0ZShwYWdlLCBwZ3Byb3QpCXBm
bl9wdGUocGFnZV90b19wZm4ocGFnZSksIChwZ3Byb3QpKQ0KPiArDQo+ICtzdGF0aWMgaW5saW5l
IHVuc2lnbmVkIGxvbmcgcHRlX3BmbihwdGVfdCBwdGUpDQo+ICt7DQo+ICsJcmV0dXJuIChwdGVf
dmFsKHB0ZSkgJiBQVEVfUlBOX01BU0spID4+IFBURV9SUE5fU0hJRlQ7DQo+ICt9DQo+ICsNCj4g
ICAvKg0KPiAgICAqIFNlbGVjdCBhbGwgYml0cyBleGNlcHQgdGhlIHBmbg0KPiAgICAqLw0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL21tL25vaGFzaC9lNTAwX2h1Z2V0bGJwYWdlLmMgYi9h
cmNoL3Bvd2VycGMvbW0vbm9oYXNoL2U1MDBfaHVnZXRsYnBhZ2UuYw0KPiBpbmRleCBmM2NiOTEx
MDdhNDcuLjU4M2IzMDk4NzYzZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL21tL25vaGFz
aC9lNTAwX2h1Z2V0bGJwYWdlLmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL21tL25vaGFzaC9lNTAw
X2h1Z2V0bGJwYWdlLmMNCj4gQEAgLTE3OCw3ICsxNzgsNyBAQCBib29rM2VfaHVnZXRsYl9wcmVs
b2FkKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGVhLCBwdGVfdCBw
dGUpDQo+ICAgICoNCj4gICAgKiBUaGlzIG11c3QgYWx3YXlzIGJlIGNhbGxlZCB3aXRoIHRoZSBw
dGUgbG9jayBoZWxkLg0KPiAgICAqLw0KPiAtdm9pZCB1cGRhdGVfbW11X2NhY2hlKHN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsDQo+ICt2b2lkIHVwZGF0
ZV9tbXVfY2FjaGVfcmFuZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxv
bmcgYWRkcmVzcywNCj4gICAJCXB0ZV90ICpwdGVwLCB1bnNpZ25lZCBpbnQgbnIpDQo+ICAgew0K
PiAgIAlpZiAoaXNfdm1faHVnZXRsYl9wYWdlKHZtYSkpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bv
d2VycGMvbW0vcGd0YWJsZS5jIGIvYXJjaC9wb3dlcnBjL21tL3BndGFibGUuYw0KPiBpbmRleCBi
M2M3Yjg3NGE3YTIuLmRiMjM2YjQ5NDg0NSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL21t
L3BndGFibGUuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvbW0vcGd0YWJsZS5jDQo+IEBAIC0yMDgs
NyArMjA4LDcgQEAgdm9pZCBzZXRfcHRlcyhzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQg
bG9uZyBhZGRyLCBwdGVfdCAqcHRlcCwNCj4gICAJCWlmICgtLW5yID09IDApDQo+ICAgCQkJYnJl
YWs7DQo+ICAgCQlwdGVwKys7DQo+IC0JCXB0ZSA9IF9fcHRlKHB0ZV92YWwocHRlKSArIFBBR0Vf
U0laRSk7DQo+ICsJCXB0ZSA9IF9fcHRlKHB0ZV92YWwocHRlKSArICgxVUwgPDwgUFRFX1JQTl9T
SElGVCkpOw0KPiAgIAkJYWRkciArPSBQQUdFX1NJWkU7DQo+ICAgCX0NCj4gICB9DQoNCg0KV2hh
dCBhYm91dDoNCg0Kdm9pZCBzZXRfcHRlcyhzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQg
bG9uZyBhZGRyLCBwdGVfdCAqcHRlcCwNCgkJcHRlX3QgcHRlLCB1bnNpZ25lZCBpbnQgbnIpDQp7
DQoJcGdwcm90X3QgcHJvdDsNCgl1bnNpZ25lZCBsb25nIHBmbjsNCgkvKg0KCSAqIE1ha2Ugc3Vy
ZSBoYXJkd2FyZSB2YWxpZCBiaXQgaXMgbm90IHNldC4gV2UgZG9uJ3QgZG8NCgkgKiB0bGIgZmx1
c2ggZm9yIHRoaXMgdXBkYXRlLg0KCSAqLw0KCVZNX1dBUk5fT04ocHRlX2h3X3ZhbGlkKCpwdGVw
KSAmJiAhcHRlX3Byb3Rub25lKCpwdGVwKSk7DQoNCgkvKiBOb3RlOiBtbS0+Y29udGV4dC5pZCBt
aWdodCBub3QgeWV0IGhhdmUgYmVlbiBhc3NpZ25lZCBhcw0KCSAqIHRoaXMgY29udGV4dCBtaWdo
dCBub3QgaGF2ZSBiZWVuIGFjdGl2YXRlZCB5ZXQgd2hlbiB0aGlzDQoJICogaXMgY2FsbGVkLg0K
CSAqLw0KCXB0ZSA9IHNldF9wdGVfZmlsdGVyKHB0ZSk7DQoNCglwcm90ID0gcHRlX3BncHJvdChw
dGUpOw0KCXBmbiA9IHB0ZV9wZm4ocHRlKTsNCgkvKiBQZXJmb3JtIHRoZSBzZXR0aW5nIG9mIHRo
ZSBQVEUgKi8NCglmb3IgKDs7KSB7DQoJCV9fc2V0X3B0ZV9hdChtbSwgYWRkciwgcHRlcCwgcGZu
X3B0ZShwZm4sIHByb3QpLCAwKTsNCgkJaWYgKC0tbnIgPT0gMCkNCgkJCWJyZWFrOw0KCQlwdGVw
Kys7DQoJCXBmbisrOw0KCQlhZGRyICs9IFBBR0VfU0laRTsNCgl9DQp9DQoNCg0KQ2hyaXN0b3Bo
ZQ0K
