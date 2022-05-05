Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3013A51C015
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378537AbiEENEq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 09:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378598AbiEENEg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 09:04:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D312652B20;
        Thu,  5 May 2022 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651755655; x=1683291655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VhfY5oMQPJu9z7kfJxnwnpTKu6x+DbDF5VMEHafmD0g=;
  b=pxKb0iVQjnKbdJakqAUsVbM0N5itbBU5jxcBOcKbyjWkSbGdfmRW/Rkj
   n9Qe0gO6VTljOtI96fkfOH4qNykDvrzORJqmmu1aurAtiwkZZtFyo3+l2
   YtHHX3nx3lf/BlfyOacklXy+bCejhzSV1npDaojYzbhyAjf6Zu1sHb4/9
   TJ7UiG3METE+6ElxvyvZV9R7lI5Tp4g3MX/dbgG5l+AtdiccMp0AcwN8P
   jD6x/ZHRmQdTPelz06DPnZMWlAl+5wUn9YBe7fatBH7IRdPQUmiAJ7rHH
   xul/RQgGoCI/xXgciNKQf38+8ZbM+xXU2pEoagbTePs/f2Q2MM90cbt7X
   w==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="172080611"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 06:00:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 06:00:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 06:00:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUZjJHIKzUmalgblQBVaQleGpuTntDwBwOdpO4HaK33lhHj6AR84IVTCyvoWKU3IfJBDezMNZjePolmqcRlj2GAbEmftzNcdNEJwlQpmKbmzIKuCPDU5m/NiZ7ccHpmEGa0CymCOfSXK4U+lbNMnBjP93sdvWOFQQVzUH1pmtxsEi/ccm5//q4ivKlbFrWplythZlzYO3hKDAtL3QicGi/BZT7iCnif5n6Q6qrji1K3fDsdXm0RRE8UtczqYv9TcXIKDDmgjp/pWRYhCAEOnMMAfxiOlKyiU2bX/KeJhA61c/3b6UALQqrO4kpz4CsYh5IXH7qfimSQqISLH4nUbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhfY5oMQPJu9z7kfJxnwnpTKu6x+DbDF5VMEHafmD0g=;
 b=etL/ZnUA2vv6cIAxhopgTSME/KbLlO/h/9vonUdNv+5/BN6BMcsv7PoT8MrNQs6gLKQmKyHqzdG84AwZDWprlWdy6eUaqXvM6iARgPk8ZD8H4B6sibujaKy3YkOqMI1tD+d9iWvCGe7blsvvESbEHgyjKZnalXY4GRqNPgway/okzjRZRnXwiHtMwoV48/ppJzjy6dJejaq3geD0mGK3zvUVJZlbt9Oj7ZsL3Goy92lIeNj3iQFw8KXkm/Lr4arAq2dvN5Fh1T3gPL/gkRxaZtT1h0btkycsAwORTo38ZdqNZjjCcn+yYnass7/yMU8Dg3npQMOFDOZlMZ/zMDGrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhfY5oMQPJu9z7kfJxnwnpTKu6x+DbDF5VMEHafmD0g=;
 b=RNIVCmrFma53vexvueT3iGFaY9LMUzPI+TbwB3jRSb26y76b7l7JlfxnzZPFnbm2N822Lz2JBceowe5YQdmOF1dF+gLlfKF+Ms/fjvosvYbiWzxe4L9uBKKZr5NON29/+uF3dQDSRWolyhB91vi/sKWrcU3etTyG/xZLfA/c4Ac=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by BYAPR11MB3159.namprd11.prod.outlook.com (2603:10b6:a03:78::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 13:00:49 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::fcd4:8f8a:f0e9:8b18%9]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 13:00:49 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@rivosinc.com>, <arnd@arndb.de>
CC:     <guoren@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
        <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <gregkh@linuxfoundation.org>, <sudipm.mukherjee@gmail.com>,
        <macro@orcam.me.uk>, <jszhang@kernel.org>,
        <linux-csky@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <openrisc@lists.librecores.org>, <linux-riscv@lists.infradead.org>,
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] RISC-V: Move to queued RW locks
Thread-Topic: [PATCH v4 6/7] RISC-V: Move to queued RW locks
Thread-Index: AQHYXKhi75gRseSB/EiwETrRXFB3JK0QRuCA
Date:   Thu, 5 May 2022 13:00:49 +0000
Message-ID: <ed835f10-e8c2-2695-4dc8-2064c86eb931@microchip.com>
References: <20220430153626.30660-1-palmer@rivosinc.com>
 <20220430153626.30660-7-palmer@rivosinc.com>
In-Reply-To: <20220430153626.30660-7-palmer@rivosinc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da3eebe3-30c0-4d24-69fe-08da2e97474d
x-ms-traffictypediagnostic: BYAPR11MB3159:EE_
x-microsoft-antispam-prvs: <BYAPR11MB31597051C196D592BF433A0D98C29@BYAPR11MB3159.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81tcb2XU+rMh1wHtatzKSl6NUz68yhbs/ZU8/kTclUaCvPRKDcj4nNFuL1JE1he13CFfXssYn29/5XfkllHFQ3x1Kwz+YikVTj502PCfxxpi1YhTct7lmmjmQkdLdNsgnrqgDFcDca2BLB5hU5T0emP5VP6XMEVzcO1+Lr6byyJVBOL4ByMwOOnp9pWGXf4I56nbupi1m1x9hBzqCM1KBZmgXr4Caow8o7VeWr1AIu/nGMmGXjTwbPmQMjXj9avniVUrYFW7EXZXNnWPV6QAmd3JaxrlwE7KjsihF4JCghWKRguUS6CVtC4JVkpUC0jZwZHBmuh6Znh4RORaVux+Dy3Ey3QUoEapAwvq0c/xcJzCPFBIDR1hBi8B7YoUfzZPtOUVm46nN5GxI9jhvKnhRnQT6L6RLDwYOPIp8Bd7qMYKjk+lWW5tLbWNOFvxyr4wQf5fTRzOp+uayz20RaNUiX0mCDVhU4xzCUpXHLdyfVBE4Rp/XAxpJ5kMQ2YrWAHWbd95o7zckxJHrQnAtzGz/27IrmV6rTTMiNOmvNQbvMtQMPOFuSyqKi/mi0TEhcrp6QhBQiimjDkWh2niQEh6FjVzZE1URhZWFdbvXw87CbBQB4kc8l7rTSOhR0B4k49IqCeZOUluOeACDMoj/Cemkwu3tio8ZD5lqWEqsKhHvITbTWjiqn/aMyxEYYHPpGPfX6QxQqBg6Q4utft39JRMUuKU99W8y3tbCaAckyi9jOn8Oc/HDIucyP24zcEHoLun9pu62QtZE+HKyCeCE7+ABQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(36756003)(5660300002)(31686004)(83380400001)(6486002)(76116006)(4326008)(8676002)(91956017)(186003)(66946007)(64756008)(66556008)(8936002)(66446008)(66476007)(54906003)(6512007)(71200400001)(7416002)(110136005)(26005)(6506007)(53546011)(508600001)(316002)(38100700002)(38070700005)(2906002)(122000001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmZubzJJQTdCb1dqRUQwRHBYd2tSeGJCNUsrWVJSQUozOXllRnV2TEFJVGVy?=
 =?utf-8?B?bUYwdms1TkRZY0kzakhjNjIzdnhvU0FPaVZhRVA0ZlM5ZFYwdlJUS0FoY0RJ?=
 =?utf-8?B?R082OTk4MHZ5NCtBdW1mSEtjZnRrNWw0VEN4U0lpa0pKNkc2Rm1GbFVtZGZR?=
 =?utf-8?B?eDJRRWlaQmErbkIvWVpGaUFqMFk4NU5OQWJaYlhIbTNwWFppOTEvbEhmTlF2?=
 =?utf-8?B?UWdlMnBpTnZQTmRYUEdVTGY2U2ZPZmZrTzhSL1NvaVdZclR3NXNjU2NTUENX?=
 =?utf-8?B?Y3crNFlzMXp6NVFSL1dzNDlDNnpCMHdxYmNjQ3lwZ1N2bkdjWWgzOGp2b25R?=
 =?utf-8?B?SDVWRmRqaTUwb0VIKzlnNUdFWVpoUnFieC94UFlYa242T1lucnVzNnMvUW5z?=
 =?utf-8?B?TjVvMzRpN3NDRGpxRE5uM2dMRDNtYVhPQXRnVHFvQnZiemhhRFFMWnZDMTQ4?=
 =?utf-8?B?cEcyTmRBMHAvL3lPNkc2a3lxZmpBa3F2WEg5YnJDbzZQK0ZCbTFVZm02QXFL?=
 =?utf-8?B?bzU1eERjUXRKT0FRM2tySXl2RmwrM3hHTVRVYlJzclppOVc2d1NBOTBGQUdp?=
 =?utf-8?B?MlRacWlQNjZOSEtGa2RkS3IxR0Z3MVFOY0VuTFpreUlCOS9LU0M5aFpaMmRL?=
 =?utf-8?B?Nm5iK3Fhcyt1azBLeExFQ0plUlI2bDdJWWdUZzZKcmMwSi9vYlAyZXk4OE15?=
 =?utf-8?B?aThGRnF3cUQvSy9aTWIvQktTcXJNZjBmbU5mcCtTRGlSWEZCV09YNE5YQWxV?=
 =?utf-8?B?S09hYWV0UldJUjcxNVRKVE80TzlEUVFtd21NS1d6ZGlwb0J2cXJxbmppd3BI?=
 =?utf-8?B?L3BxY01VRXVDaGkrOWpsZnIyZ2laWkVCUHJtVCtHSnNCcjNXQ0RZRDRqTEhB?=
 =?utf-8?B?a3cwQnFyanI0UmJwUHhOZG5DNzZ4aVB6YVAxZW9SWDkzZ29zMFFtZlh2V1Mz?=
 =?utf-8?B?ejlWN1hPWXNkSmx2UDhpS2JiUHVJUjArZlRJQ2RlU2lSVEs5TW9LYm5aWWJx?=
 =?utf-8?B?WlAwUWFVV1lBMVBheTBxSjZjSnI5cmdCdWFJRkpzejBFM3RvRFM3U0FHTWxT?=
 =?utf-8?B?UVRpZzE2YitpSFFOT1JLZ3UzWGtZSkdZemxpNFdjbCtWU29MV2F2dWQxTGxN?=
 =?utf-8?B?clFvTlZ4SkZmZ2UydllncU01bVlFL09HdnByWllIYW13OXY1RExOZElid0Ir?=
 =?utf-8?B?djVENGJoMnZsUUlBMmtORVBBK0ZPaEpPZ0dwblAwMTA3elNaNmszVzEyRzFJ?=
 =?utf-8?B?aURyQzdOS0djeXVJMWtQYXYzYURBVjQ3elozWkIwNldDMHpuaFY0S250Qlhm?=
 =?utf-8?B?QWtlR3RwUFNydjJIdkJ1SHF6YVFVV0huTTA4T2pWWTFzaE16WFhBZFREMHEv?=
 =?utf-8?B?RDl3QU9OT0VsTFZWcEVLN0VISnd1bmxQbkUvQ2hBTjhpS01rTHI2M3RIcFo0?=
 =?utf-8?B?RW00dkdveGxQeFNtb0Z5Tk1kOE1iTEJuUVF1YW9rSzNWdEtoUDRQSGJ3UVFY?=
 =?utf-8?B?d09acTJrbXJocjZQVlB5NUI4VmQva3V4WkJoaFRjemdiZGgySkVhNTBPOUFq?=
 =?utf-8?B?MmkzaXprUTBlU0JuQ3JHV2duYWZKa1F4cGJOeHQxN0JkWjNWVzMvQnpMV2J1?=
 =?utf-8?B?ZStFRHR4NnBpVERjZnNmMWE1VmNUUFhCUDQzV2pNK3c2NURHdGtGWXdhRnFT?=
 =?utf-8?B?T0pmSEs5VVUzeUVJWDRxMUlxNlcvcTdNaGdWa1gxSmw3R05TTDEzU09NSENi?=
 =?utf-8?B?RGpNZ3B5TndOVXZDTElSZHFZaEh5RzVEWHV6YzAxdkk2aTNhZ25xL1YvOWhn?=
 =?utf-8?B?a3ZzdlNMVEd1NFZhT293WStlcEM4a3ByZS82MGdseTBWWk9vQ0JGcE9TNDF3?=
 =?utf-8?B?eWdnT3pIQW9WNnJrT1dPRzU2ajNGeWxEbTVhZ2FqUXJsaFNnVFJUZThrRlZG?=
 =?utf-8?B?RGkyWnd1clYzU21VVTlZVm1vYzJrQldKSlI5Wm1RNlVUVkhqQWJPbEt2dVN3?=
 =?utf-8?B?NkZiK1k2UzMrY25TZWpuZ1JhZkNKQUpZajBQZlZiWHJ3YmoxK3VCMXBibGx6?=
 =?utf-8?B?cXZJZ3JCWGJQQ0JpOS9qWUtwdFN0QXdibE5LM1lPY1o3YjQ0MG1HYTVCMnRS?=
 =?utf-8?B?N0RCd01ldnhJWGo5dDBEdndKTFhMd2hwb2dUVFExVXpmYjBZbUtvWjhvaW5J?=
 =?utf-8?B?RjJtVkdIcUVUWXZkU3ZvcnNZbkFlSG9PeXRsR0xFV3RxNkJ0M3ErZ1ZMaUNi?=
 =?utf-8?B?QStnejFwRjhOSEswQkRpbzdnSEhQR3haOCtEdE9QeXJNR2U5cHpFTWdnZ2tZ?=
 =?utf-8?B?dFFuKzJuMldTZUhIaTNxR0xyNTQ4V1d3bE5NTEhic21BRGhkdmt4SDFUWGF2?=
 =?utf-8?Q?u3Qr7v6P2BCs9SqQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <278FEC812B02B542928FD279D8B2A7A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da3eebe3-30c0-4d24-69fe-08da2e97474d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 13:00:49.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhoZek0vl5C1XABpcj0Y4UBekYYlMQKj+BQirDbLbtJokUyhLkOolT/BKYR9QxZqQ6/vdokTYCEacgsxEI1Fz5ryfh+Iq1yw7vFKMXZ/+dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3159
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQpPbiAzMC8wNC8yMDIyIDE2OjM2LCBQYWxtZXIgRGFiYmVsdCB3cm90ZToNCj4gRnJvbTogUGFs
bWVyIERhYmJlbHQgPHBhbG1lckByaXZvc2luYy5jb20+DQo+IA0KPiBOb3cgdGhhdCB3ZSBoYXZl
IGZhaXIgc3BpbmxvY2tzIHdlIGNhbiB1c2UgdGhlIGdlbmVyaWMgcXVldWVkIHJ3bG9ja3MsDQo+
IHNvIHdlIG1pZ2h0IGFzIHdlbGwgZG8gc28uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYWxtZXIg
RGFiYmVsdCA8cGFsbWVyQHJpdm9zaW5jLmNvbT4NCg0KVmVyYmF0aW0gZnJvbSB0aGUgb3RoZXIg
cGF0Y2g6DQoNCkkgYW0gbG9hdGhlIHRvIGFkZCBhIFRCIHRhZyBzaW5jZSBJIGhhdmUgbm90IGRv
bmUgbXVjaCBieSB3YXkgb2YgdGVzdGluZw0KYW55IHJlYWxpc3RpYyB1c2UgY2FzZXMgLSBidXQg
SSBoYXZlIHB1dCBpdCBpbiBvdXIgQ0kgYW5kIGhhdmUgaGFkIGEgcGxheQ0KYXJvdW5kIHdpdGgg
aXQgbG9jYWxseSAmIG5vdGhpbmcgb2J2aW91c2x5IGJyb2tlIGZvciBtZS4NCg0KSWYgeW91IHRo
aW5rIHRoYXQgaXMgc3VmZmljaWVudDoNClRlc3RlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5k
b29sZXlAbWljcm9jaGlwLmNvbT4NCk90aGVyd2lzZSBmZWVsIGZyZWUgdG8gaWdub3JlIHRoZSB0
YWcuDQoNClRoYW5rcywNCkNvbm9yLg0KPiAtLS0NCj4gICBhcmNoL3Jpc2N2L0tjb25maWcgICAg
ICAgICAgICAgICAgICAgICAgfCAgMSArDQo+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9LYnVp
bGQgICAgICAgICAgIHwgIDIgKw0KPiAgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2su
aCAgICAgICB8IDk5IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBhcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL3NwaW5sb2NrX3R5cGVzLmggfCAyNCAtLS0tLS0NCj4gICA0IGZpbGVzIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTIzIGRlbGV0aW9ucygtKQ0KPiAgIGRlbGV0ZSBtb2RlIDEw
MDY0NCBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NwaW5sb2NrLmgNCj4gICBkZWxldGUgbW9kZSAx
MDA2NDQgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9zcGlubG9ja190eXBlcy5oDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9yaXNjdi9LY29uZmlnIGIvYXJjaC9yaXNjdi9LY29uZmlnDQo+IGluZGV4
IDAwZmQ5YzU0OGYyNi4uZjhhNTVkOTQwMTZkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L0tj
b25maWcNCj4gKysrIGIvYXJjaC9yaXNjdi9LY29uZmlnDQo+IEBAIC0zOSw2ICszOSw3IEBAIGNv
bmZpZyBSSVNDVg0KPiAgIAlzZWxlY3QgQVJDSF9TVVBQT1JUU19ERUJVR19QQUdFQUxMT0MgaWYg
TU1VDQo+ICAgCXNlbGVjdCBBUkNIX1NVUFBPUlRTX0hVR0VUTEJGUyBpZiBNTVUNCj4gICAJc2Vs
ZWN0IEFSQ0hfVVNFX01FTVRFU1QNCj4gKwlzZWxlY3QgQVJDSF9VU0VfUVVFVUVEX1JXTE9DS1MN
Cj4gICAJc2VsZWN0IEFSQ0hfV0FOVF9ERUZBVUxUX1RPUERPV05fTU1BUF9MQVlPVVQgaWYgTU1V
DQo+ICAgCXNlbGVjdCBBUkNIX1dBTlRfRlJBTUVfUE9JTlRFUlMNCj4gICAJc2VsZWN0IEFSQ0hf
V0FOVF9HRU5FUkFMX0hVR0VUTEINCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vS2J1aWxkIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9LYnVpbGQNCj4gaW5kZXggYzNmMjI5
YWU4MDMzLi41MDRmOGI3ZTcyZDQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9h
c20vS2J1aWxkDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vS2J1aWxkDQo+IEBAIC0z
LDYgKzMsOCBAQCBnZW5lcmljLXkgKz0gZWFybHlfaW9yZW1hcC5oDQo+ICAgZ2VuZXJpYy15ICs9
IGZsYXQuaA0KPiAgIGdlbmVyaWMteSArPSBrdm1fcGFyYS5oDQo+ICAgZ2VuZXJpYy15ICs9IHBh
cnBvcnQuaA0KPiArZ2VuZXJpYy15ICs9IHNwaW5sb2NrLmgNCj4gK2dlbmVyaWMteSArPSBzcGlu
bG9ja190eXBlcy5oDQo+ICAgZ2VuZXJpYy15ICs9IHFyd2xvY2suaA0KPiAgIGdlbmVyaWMteSAr
PSBxcndsb2NrX3R5cGVzLmgNCj4gICBnZW5lcmljLXkgKz0gdXNlci5oDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3NwaW5sb2NrLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL3NwaW5sb2NrLmgNCj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDg4YTRk
NWQwZDk4YS4uMDAwMDAwMDAwMDAwDQo+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3Bp
bmxvY2suaA0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDk5ICswLDAgQEANCj4gLS8qIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgKi8NCj4gLS8qDQo+IC0gKiBDb3B5cmln
aHQgKEMpIDIwMTUgUmVnZW50cyBvZiB0aGUgVW5pdmVyc2l0eSBvZiBDYWxpZm9ybmlhDQo+IC0g
KiBDb3B5cmlnaHQgKEMpIDIwMTcgU2lGaXZlDQo+IC0gKi8NCj4gLQ0KPiAtI2lmbmRlZiBfQVNN
X1JJU0NWX1NQSU5MT0NLX0gNCj4gLSNkZWZpbmUgX0FTTV9SSVNDVl9TUElOTE9DS19IDQo+IC0N
Cj4gLS8qIFRoaXMgaXMgaG9yaWJsZSwgYnV0IHRoZSB3aG9sZSBmaWxlIGlzIGdvaW5nIGF3YXkg
aW4gdGhlIG5leHQgY29tbWl0LiAqLw0KPiAtI2RlZmluZSBfX0FTTV9HRU5FUklDX1FSV0xPQ0tf
SA0KPiAtDQo+IC0jaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+IC0jaW5jbHVkZSA8YXNtL2N1
cnJlbnQuaD4NCj4gLSNpbmNsdWRlIDxhc20vZmVuY2UuaD4NCj4gLSNpbmNsdWRlIDxhc20tZ2Vu
ZXJpYy9zcGlubG9jay5oPg0KPiAtDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgYXJjaF9yZWFkX2xv
Y2soYXJjaF9yd2xvY2tfdCAqbG9jaykNCj4gLXsNCj4gLQlpbnQgdG1wOw0KPiAtDQo+IC0JX19h
c21fXyBfX3ZvbGF0aWxlX18oDQo+IC0JCSIxOglsci53CSUxLCAlMFxuIg0KPiAtCQkiCWJsdHoJ
JTEsIDFiXG4iDQo+IC0JCSIJYWRkaQklMSwgJTEsIDFcbiINCj4gLQkJIglzYy53CSUxLCAlMSwg
JTBcbiINCj4gLQkJIglibmV6CSUxLCAxYlxuIg0KPiAtCQlSSVNDVl9BQ1FVSVJFX0JBUlJJRVIN
Cj4gLQkJOiAiK0EiIChsb2NrLT5sb2NrKSwgIj0mciIgKHRtcCkNCj4gLQkJOjogIm1lbW9yeSIp
Ow0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgYXJjaF93cml0ZV9sb2NrKGFyY2hf
cndsb2NrX3QgKmxvY2spDQo+IC17DQo+IC0JaW50IHRtcDsNCj4gLQ0KPiAtCV9fYXNtX18gX192
b2xhdGlsZV9fKA0KPiAtCQkiMToJbHIudwklMSwgJTBcbiINCj4gLQkJIglibmV6CSUxLCAxYlxu
Ig0KPiAtCQkiCWxpCSUxLCAtMVxuIg0KPiAtCQkiCXNjLncJJTEsICUxLCAlMFxuIg0KPiAtCQki
CWJuZXoJJTEsIDFiXG4iDQo+IC0JCVJJU0NWX0FDUVVJUkVfQkFSUklFUg0KPiAtCQk6ICIrQSIg
KGxvY2stPmxvY2spLCAiPSZyIiAodG1wKQ0KPiAtCQk6OiAibWVtb3J5Iik7DQo+IC19DQo+IC0N
Cj4gLXN0YXRpYyBpbmxpbmUgaW50IGFyY2hfcmVhZF90cnlsb2NrKGFyY2hfcndsb2NrX3QgKmxv
Y2spDQo+IC17DQo+IC0JaW50IGJ1c3k7DQo+IC0NCj4gLQlfX2FzbV9fIF9fdm9sYXRpbGVfXygN
Cj4gLQkJIjE6CWxyLncJJTEsICUwXG4iDQo+IC0JCSIJYmx0egklMSwgMWZcbiINCj4gLQkJIglh
ZGRpCSUxLCAlMSwgMVxuIg0KPiAtCQkiCXNjLncJJTEsICUxLCAlMFxuIg0KPiAtCQkiCWJuZXoJ
JTEsIDFiXG4iDQo+IC0JCVJJU0NWX0FDUVVJUkVfQkFSUklFUg0KPiAtCQkiMTpcbiINCj4gLQkJ
OiAiK0EiIChsb2NrLT5sb2NrKSwgIj0mciIgKGJ1c3kpDQo+IC0JCTo6ICJtZW1vcnkiKTsNCj4g
LQ0KPiAtCXJldHVybiAhYnVzeTsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIGlubGluZSBpbnQgYXJj
aF93cml0ZV90cnlsb2NrKGFyY2hfcndsb2NrX3QgKmxvY2spDQo+IC17DQo+IC0JaW50IGJ1c3k7
DQo+IC0NCj4gLQlfX2FzbV9fIF9fdm9sYXRpbGVfXygNCj4gLQkJIjE6CWxyLncJJTEsICUwXG4i
DQo+IC0JCSIJYm5legklMSwgMWZcbiINCj4gLQkJIglsaQklMSwgLTFcbiINCj4gLQkJIglzYy53
CSUxLCAlMSwgJTBcbiINCj4gLQkJIglibmV6CSUxLCAxYlxuIg0KPiAtCQlSSVNDVl9BQ1FVSVJF
X0JBUlJJRVINCj4gLQkJIjE6XG4iDQo+IC0JCTogIitBIiAobG9jay0+bG9jayksICI9JnIiIChi
dXN5KQ0KPiAtCQk6OiAibWVtb3J5Iik7DQo+IC0NCj4gLQlyZXR1cm4gIWJ1c3k7DQo+IC19DQo+
IC0NCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBhcmNoX3JlYWRfdW5sb2NrKGFyY2hfcndsb2NrX3Qg
KmxvY2spDQo+IC17DQo+IC0JX19hc21fXyBfX3ZvbGF0aWxlX18oDQo+IC0JCVJJU0NWX1JFTEVB
U0VfQkFSUklFUg0KPiAtCQkiCWFtb2FkZC53IHgwLCAlMSwgJTBcbiINCj4gLQkJOiAiK0EiIChs
b2NrLT5sb2NrKQ0KPiAtCQk6ICJyIiAoLTEpDQo+IC0JCTogIm1lbW9yeSIpOw0KPiAtfQ0KPiAt
DQo+IC1zdGF0aWMgaW5saW5lIHZvaWQgYXJjaF93cml0ZV91bmxvY2soYXJjaF9yd2xvY2tfdCAq
bG9jaykNCj4gLXsNCj4gLQlzbXBfc3RvcmVfcmVsZWFzZSgmbG9jay0+bG9jaywgMCk7DQo+IC19
DQo+IC0NCj4gLSNlbmRpZiAvKiBfQVNNX1JJU0NWX1NQSU5MT0NLX0ggKi8NCj4gZGlmZiAtLWdp
dCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3BpbmxvY2tfdHlwZXMuaCBiL2FyY2gvcmlzY3Yv
aW5jbHVkZS9hc20vc3BpbmxvY2tfdHlwZXMuaA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQN
Cj4gaW5kZXggZjJmOWI1ZDcxMjBkLi4wMDAwMDAwMDAwMDANCj4gLS0tIGEvYXJjaC9yaXNjdi9p
bmNsdWRlL2FzbS9zcGlubG9ja190eXBlcy5oDQo+ICsrKyAvZGV2L251bGwNCj4gQEAgLTEsMjQg
KzAsMCBAQA0KPiAtLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0K
PiAtLyoNCj4gLSAqIENvcHlyaWdodCAoQykgMjAxNSBSZWdlbnRzIG9mIHRoZSBVbml2ZXJzaXR5
IG9mIENhbGlmb3JuaWENCj4gLSAqLw0KPiAtDQo+IC0jaWZuZGVmIF9BU01fUklTQ1ZfU1BJTkxP
Q0tfVFlQRVNfSA0KPiAtI2RlZmluZSBfQVNNX1JJU0NWX1NQSU5MT0NLX1RZUEVTX0gNCj4gLQ0K
PiAtLyogVGhpcyBpcyBob3JpYmxlLCBidXQgdGhlIHdob2xlIGZpbGUgaXMgZ29pbmcgYXdheSBp
biB0aGUgbmV4dCBjb21taXQuICovDQo+IC0jZGVmaW5lIF9fQVNNX0dFTkVSSUNfUVJXTE9DS19U
WVBFU19IDQo+IC0NCj4gLSNpZm5kZWYgX19MSU5VWF9TUElOTE9DS19UWVBFU19SQVdfSA0KPiAt
IyBlcnJvciAicGxlYXNlIGRvbid0IGluY2x1ZGUgdGhpcyBmaWxlIGRpcmVjdGx5Ig0KPiAtI2Vu
ZGlmDQo+IC0NCj4gLSNpbmNsdWRlIDxhc20tZ2VuZXJpYy9zcGlubG9ja190eXBlcy5oPg0KPiAt
DQo+IC10eXBlZGVmIHN0cnVjdCB7DQo+IC0Jdm9sYXRpbGUgdW5zaWduZWQgaW50IGxvY2s7DQo+
IC19IGFyY2hfcndsb2NrX3Q7DQo+IC0NCj4gLSNkZWZpbmUgX19BUkNIX1JXX0xPQ0tfVU5MT0NL
RUQJCXsgMCB9DQo+IC0NCj4gLSNlbmRpZiAvKiBfQVNNX1JJU0NWX1NQSU5MT0NLX1RZUEVTX0gg
Ki8NCg==
