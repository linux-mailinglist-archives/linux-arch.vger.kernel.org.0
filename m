Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86E59556A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Aug 2022 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiHPIhK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Aug 2022 04:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiHPIgp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Aug 2022 04:36:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8699DAEEE;
        Mon, 15 Aug 2022 23:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660632052; x=1692168052;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/5f7Qm9fUm8yzhTZpIN4YXB5bzvc8pTE1V6A+SJF5pI=;
  b=CKRfEByCfg16OmNIUDC053aP9I8QYu4+1IwLpDCU5dNIPAYHqVdJ9I1x
   FRUTxNkvIzFgU86dckws/SJIJkMv7J8QOBYa7/s9FkUFQwgOvoSNHojJG
   6QLjDZtefKP+6qPjH5MFE2E9PPQqORlPZMB6C+uZ/nlJUKJWnZoHCDFQX
   RfJrn76VIZhFESPaCi1oBNcInK0urQNryPGRI+Idl3r8/zIupH6vJEJ8e
   K1ucKVyI5GXhB1pF0H++B1FYh3vkoTcrVYAlxj8osCOys4yMuibxrot2S
   VLkNniQeh2YFWTV6ua/jxr05JzBAOWpvlyx+B0mexvqaJIZfekoY8a2qg
   A==;
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="176531362"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 23:40:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 23:40:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 23:40:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvI2weKdQ7CXZhgP6YAKcxImWkSjnbLgIx16G1AD7Qz2K5EV/N5vv7WsV2yK1nlyfA287qtI6QtbXc8MBCcfnCw5dVhIbHlw8KDF6sn32/y8dN4B/BysXJezT86RxYBJAAzWPLTzs2qZq08TP+Esw1FdbTGWIt22UwHzMSTZ7lKq7EXQ2vCPM19Dm76rGsCsXnKx9V4Z6EsBW7Fft+K2Yib8tY8j6lXKJtWA4juNBA5J/61nl3iTNRNV5EiKxY4BlcvkiCd/zFrTSh2jo4VWCkFXhqm2F0Um3L66GHHVcp0JVQ4MDyWmvZOtzFeg2pFD8eXvQEBLgcy8QSJRD9obRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5f7Qm9fUm8yzhTZpIN4YXB5bzvc8pTE1V6A+SJF5pI=;
 b=fK5kg8ZdE3CF6pvHQw0lxylCVMSd71gc4Cqrjcybgr337lM+0mKepo3+8UhboeseL69jaRwnz3KO724r3RT7T3Iihh6/f1sS1qIiEnMspUIHO1OQ5PKPb9kSugv++oNn/40y8pFu/DaeVcp8xXMpZEg9GnewScLx/ayLn2hZWxbAIpMeCc8fWGNyxVWc8zFhcMJnYXTpTMKmqxuEks9Qu7Pl+6XxV/3+AkiOREQksujWgr25lCJrmyTUpkpY6FWdzjoT/UX+uBPXBQgTfOKvjm/N1Tuzz2lJMkKeoWJq9dreRxHBYtIOXO89Nlu20sp0H8GTdcdkXENNWwxn4GbikA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5f7Qm9fUm8yzhTZpIN4YXB5bzvc8pTE1V6A+SJF5pI=;
 b=XnPeoFd3EHx8qu7bsCzQWxEfvF5v1o5Gr690z8XgqyumyknGWseHjsMuSil5KJtCYbfGqDWs64PaY6wL4vvlLjGtTBSv6DwJFExCn7HjJtBaFNdacCt79dqVGBCUXwFNT2sSNzfNbDmtC1e+pPqoy2DEe8bvUchC2cFAIvgs6yc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1243.namprd11.prod.outlook.com (2603:10b6:3:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Tue, 16 Aug 2022 06:40:47 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 06:40:47 +0000
From:   <Conor.Dooley@microchip.com>
To:     <guoren@kernel.org>, <xianting.tian@linux.alibaba.com>,
        <palmer@dabbelt.com>, <heiko@sntech.de>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <liaochang1@huawei.com>,
        <mick@ics.forth.gr>, <jszhang@kernel.org>,
        <guoren@linux.alibaba.com>
Subject: Re: [PATCH 0/2] riscv: kexec: Support crash_save percpu and
 machine_kexec_mask_interrupts
Thread-Topic: [PATCH 0/2] riscv: kexec: Support crash_save percpu and
 machine_kexec_mask_interrupts
Thread-Index: AQHYsQ99A9Ffer/rCEKVNoU1WaOmaa2xFAmA
Date:   Tue, 16 Aug 2022 06:40:47 +0000
Message-ID: <3ca459c5-53d9-48f4-81b2-65d94ab38e98@microchip.com>
References: <20220816012701.561435-1-guoren@kernel.org>
In-Reply-To: <20220816012701.561435-1-guoren@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdef03b2-8b8d-4aac-fed9-08da7f524081
x-ms-traffictypediagnostic: DM5PR11MB1243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9bRp8o8w3DEyCHNQSr1xaxeTeqBhDJUZImmRrLzS/QcfpA4HRaJV6f9TGKFhxjU033YRUNCzu7Cnj5mE/uhlRe7rhVBYnd9ThIaqkQ3NPukNtuvEZyDm77tinN/1dzss/rvI3raKEpRmCuJYvOlo+4gEAVIhTj2G5wDaxGa/XSj6wjYMvnIi1f7y/ahHo0/QX3Ddn+0FqnDg91LKR5He28LXM/7i1agm5jxBfJObVEgsPkYt/kK4WFFTdekd3Aq7xOBqbAfWkSePP/4wVpoPVTYCzb2BmD1yq1E4HAjXpC1Fs8Qu0NImm6GgeCifEP7jzz5+UjpHPKHMwpvI9DkP5VZhr4uUz+AJKW10YcqqcB9OlBCfU9015aJFg6H6smE9eNZ2GEXpWxbBckjh5t90LM4TxcmtvYaCLx4yfpmMTkXliIPmU6+cNsfevws/SGA59tMQc+6+sy2OEP2ObiRSKj0A8OFOqjT6n9oZd0tjbQLOxWQTQrGJK3YGr/pK69t2ZVShOrc7Zp9bnkGOHG1sSd/ZHCOOWybC4BBvQk3KtCsWLeETGE/d0tS1ollKePz8D2gHMsB/dgAoGlZsoiRP/vOE3QyWaY9fs/svpOENvHO+OSm7FWpiJ6Cn3aysaTAIvSZX8KCNEGmzzIbxko0whs3U+XyttutpFa94xU7ejp1Dd2HUkaJd8mRGfwU8IaLZXOswjQjbCVPKbajkK5odznXcfpoZeT9M+1eVdI3sgsUr4JBKPY6jr8wXR2wLLTmrhsHnU1JySObslIbT9QbxpXN0Fy5wk+Jp9Lw952DBS/U8HuIj0dxl9aC6mTsQQlZz5y/3esk4sMx/SPX+RpsJdJi4+pbB/til8sTYhUtP8pTsnGbXCDDLpaS7YDvODxLcZ3LmWHiAwUvZfTsdmF7ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(376002)(366004)(396003)(76116006)(6486002)(31696002)(4326008)(4744005)(2906002)(86362001)(64756008)(966005)(122000001)(66446008)(71200400001)(66946007)(8936002)(91956017)(5660300002)(66476007)(66556008)(38100700002)(110136005)(38070700005)(53546011)(54906003)(316002)(26005)(8676002)(6506007)(36756003)(7416002)(186003)(41300700001)(31686004)(2616005)(83380400001)(478600001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHJoMHdSNE9VeUNoK3RIUVhSNC80eG5Zc1pCVjQyWmEycWlEWjRwWFBLMDh2?=
 =?utf-8?B?Sld0TnZGNHhNS2JrQmhoZmdsSUlsaVJ0Wit5c0RUMVhIbncxNml5d2FJZFd1?=
 =?utf-8?B?a3hmVitWM09mUmdMUks2ckw0d0wydllESGxVb0lvb0V2QmxCQ2VFbHgzUEFi?=
 =?utf-8?B?aExQcGJYNWpwYkd0ZDJRZTNjdWN4TWx0TFpoc2MxemNSRVpWQVJMK1ArVWlK?=
 =?utf-8?B?YlpiNU82OG9FUmZ5UGFpUWowMS82UWMyc3ZBc09iNjhDOGEvMktzTWdaQkE2?=
 =?utf-8?B?cW5lU0U1MlUxdDlFZXBNeGJ4dVB5TWZNNHNZVGZrTUkvSDdSVndnUFc4aE9w?=
 =?utf-8?B?ZGhBOWFSQmY4TUtXWDJod2tYbnl5VENVcXBRa2xrMzRTMlRwaDRQSURsbmdy?=
 =?utf-8?B?UkIzbjd6TWs0bTVSNWxvSzR3ZlBQaVdJSG94c3BURGJ4UHdWRC96ZXJ4LzR1?=
 =?utf-8?B?a1pYWWxEd1NqbHBkc3dOMjVZQ29tUWJ6SkgxbDl4VzRlU0RmVlYzbnJ2dzZK?=
 =?utf-8?B?ZGlhOTd4K3kyK1F4N3N3ZnFlWFBtM2hDR1ZZc2VsQUxrYThrNEdwWXpJaFdt?=
 =?utf-8?B?cVg5clQ5K1lDT2J3d29hQlZDOGRJS0FSV2VuWWpsbk9tNGdpLzhWVlBSY09Y?=
 =?utf-8?B?YmNDYmVvR3BUZk9GQTJtSEVLWTV4dTgzREEzMFNBRWZCRFBHaWFZNkJsNXJU?=
 =?utf-8?B?YU00S3E3TnZPWUFDSzY1ZDlGNDNRZlJOQnRjdHZudzVsQjFXb1BFc2JOMW94?=
 =?utf-8?B?R3FQTmswdldZZThqZ3FwcDBpTFFlQ3hQSDZ6Qjd6NGdLN2NHa0c1Y1Z6UjFt?=
 =?utf-8?B?OTNYNDB5YjNzMHN4VWd6UlphRVFrWmIrb0psNHpKTEVvVEJlTnh4bEtUWU1N?=
 =?utf-8?B?ZS9ZZjVtVndpdWpZNWtoTCtGQmhDK0NWcGc0R0hrcVRXWjF0dGJpNGxYQ3hF?=
 =?utf-8?B?d05XMmZnaEVxU1lXUFFWUEllVmxSTlRlVEdmNGVSSmx4YTRId3p3Z0wwQTZ1?=
 =?utf-8?B?dmg2OHd4SWd3VkRRNkt4NmlVcU5vWFpPOHVLN2c1MzkyV214WmhjSnlJZkhB?=
 =?utf-8?B?M2dnbmt4TDdWbmQxMzJGMEFPMmg2b0RVRzRscjFyVmJJR2RUVndnOHZDQnpU?=
 =?utf-8?B?b1ZrajZ1WjhFTitoNFhnZDZOdnV2eU9JcGhnNVFIOVJZUlpCMEYveU4wZ1Vj?=
 =?utf-8?B?R3JCUnMzTzNQZHhkc1pLdGJmdnZPTlBCMWhlbndyRTdtZVhaTDViMmgvNjBY?=
 =?utf-8?B?Ri9KaFpNNjFKZHJpdlhsT3NQVUpEMGxMUlB0MWpHaGlpeDdqQmllQmpjTHVP?=
 =?utf-8?B?U3N4MmQ4NkhiU0pIOEdQMnlUTW52T3JKdXUya0RDUWRjcW1Jc1ZzelEwTVd6?=
 =?utf-8?B?aUZSTTlIdmVONXJHM28yRUs5c21QSEVjcHMrNnRkUUI2Vk9TZHZmTnp0Vkow?=
 =?utf-8?B?WWxZb1BRcWJ4bUt3UW81MWRGNFNsUzk4eE5PY0liZzJIWkFscDZEUkcyZXV5?=
 =?utf-8?B?RWYwTVdxOEdaakpkVExaRmppMVY2R1FDeWxSSVp1eStXNHVMZmZ0MmZsYlJt?=
 =?utf-8?B?clhlVnYrRDJZRk5mYnZQOWI1MXpDWXA4YjVzbjNXVHVoSCtBOS9BY2V3Mmdm?=
 =?utf-8?B?Z2UxVTJQMjBYdWVLSEZ4QXlFcWZtV1pvZUV1WXhIdy9vS2lEOS90aWxTN1Vk?=
 =?utf-8?B?Q3FRaVg1a0w3UmFGc1dVR21vbE9mNi83ZzVKb3QxTUhpQ2ZiY1NITDNFZUkv?=
 =?utf-8?B?ak9jb1VNRVdlUy8zc1BYK0NTV0RsNDVwMlRWZm11YWt3LzluZ3hBRG5nQ1pU?=
 =?utf-8?B?M0NQc3JIRlRxRGMrK1FzaWJIdUhUMThONCtMTEFDZWJpR3NseWJzUG91aTlQ?=
 =?utf-8?B?NCtQbWQyQWJWRVZId0o1QS80blYxRVp0UDJrVnRiQ2NJeUcvYTBWR3ZJcVZM?=
 =?utf-8?B?THUvaW40RXMvRThRY2tOUktjK3I4d21JVDNPcUl5enJXNkowTm95bENyN1Zn?=
 =?utf-8?B?WktuY21ySDB0V0drekxJeTk5ZTEwOWtrVFpSaEtXMGtabEZQQ3JWRHRSWGti?=
 =?utf-8?B?VmM4UTNUUWg0dGdaRTlkM0pVS0d5ZXFLOFdENWc5Nmc5NHNHVXNHRkxrVW9m?=
 =?utf-8?Q?3mtwfv60HRk3GWoNkvYluTmnD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DFFB7592AA93E42B4BFB66B22EA7699@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdef03b2-8b8d-4aac-fed9-08da7f524081
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 06:40:47.2184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HTSsDKFcyV6hKBVIv6MTeEJBi7h2i9nYxnU/aO6tZqeJDvEdqvLXmt52siApkkmxa4u3tG5LNPT+wR/5ehqv2jSl8U5Sf7iYFlppD4gVKJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1243
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMTYvMDgvMjAyMiAwMjoyNiwgZ3VvcmVuQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTogR3VvIFJlbiA8Z3VvcmVuQGxp
bnV4LmFsaWJhYmEuY29tPg0KPiANCj4gQ3VycmVudCByaXNjdiBrZXhlYyBjYW4ndCBjcmFzaF9z
YXZlIHBlcmNwdSBzdGF0ZXMgYW5kIGRpc2FibGUNCj4gaW50ZXJydXB0cyBwcm9wZXJseS4gVGhl
IHBhdGNoIHNlcmllcyBmaXggdGhlbS4NCg0KSGV5LA0KSWYgdGhlc2UgYXJlIGZpeGVzLCBhcmUg
dGhlcmUgZml4ZXMgdGFncyB5b3UgY291bGQgYWRkPw0KSSBkb24ndCBzZWUgb25lIGZvciBlaXRo
ZXIgcGF0Y2guDQpUaGFua3MsDQpDb25vci4NCg0KPiANCj4gR3VvIFJlbiAoMik6DQo+ICAgIHJp
c2N2OiBrZXhlYzogRU9JIGFjdGl2ZSBhbmQgbWFzayBhbGwgaW50ZXJydXB0cyBpbiBrZXhlYyBj
cmFzaCBwYXRoDQo+ICAgIHJpc2N2OiBrZXhlYzogSW1wbGVtZW50IGNyYXNoX3NtcF9zZW5kX3N0
b3Agd2l0aCBwZXJjcHUgY3Jhc2hfc2F2ZV9jcHUNCj4gDQo+ICAgYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9zbXAuaCAgICAgIHwgIDYgKysrDQo+ICAgYXJjaC9yaXNjdi9rZXJuZWwvbWFjaGluZV9r
ZXhlYy5jIHwgNDQgKysrKysrKysrKystLS0tDQo+ICAgYXJjaC9yaXNjdi9rZXJuZWwvc21wLmMg
ICAgICAgICAgIHwgODkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgIDMgZmls
ZXMgY2hhbmdlZCwgMTI2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0N
Cj4gMi4zNi4xDQo+IA0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gbGludXgtcmlzY3YgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJpc2N2QGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1yaXNjdg0KDQo=
