Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3F35AF2F4
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 19:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiIFRnB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiIFRm5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 13:42:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231482CE20;
        Tue,  6 Sep 2022 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662486163; x=1694022163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6OURVFamo3rNMfwXgPaCcwoeT8eZj3aPrQgUr/ir/2o=;
  b=Rm2xvelCUbhU7bIF3zGfOQ3uqtICSSVam5SLn2jqNWGpov9hrzD5CwWi
   bbnGb+jCvfBMOjliPXZTLh7FXY4nhKFlXrSt107KxsD9gX0TGk+j/bhTH
   Pv680LNW/r77SDQmCFvLJOz6M+QB53YJI85VZoN/d/LbA7oRKLLBrwTBA
   VDWvjhNxLFmSDDr57FLyf9pOXwYB+z5njnIMW0GDIe3sPZ40YwJ0I+b5J
   zHEZxlwQTUFcB5rkgbOBsc1b6x8/TJZYvxvBkPTMRQvMICwU446Cipl+w
   kPhnjPGIgGq8tVrJLmAkTwUZgW9YnSLP/jv2SDQfG7LTsZcQRMMzfRvpd
   g==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="179386571"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 10:42:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 10:42:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 10:42:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpPPOAAw0NOwqk3Yxcjks9gfvVXee5YIEsviPCp3AghRgNj4f+xyOqmRbSWf/nnrmT900G/x/sXIB8S+shrqyK2D/IPDktGZqMLy1e9azlg8FsDvWr5kVuMSCRCc/t0GgOPeekqxzLVTr60iAk0hRqTZGuEEJYgDx0Wi4r1dsPinXkRwPVuMy6xDg+eo2M0a9acmqSuDtS6QPrUDY2tCNxzynK6Uuj5KRPvTkZFjjXR0cwUuLWHi895Hl8JKO37U+nmb5VzMf7E9Z0jE6KAWyBt0RVOV+XzR+5smaeWK2OBjK+YYYQxSPViILJ5C+F18qPOEwY3u346p6FzQYEV4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OURVFamo3rNMfwXgPaCcwoeT8eZj3aPrQgUr/ir/2o=;
 b=mY9r73rgioIaXOOilxWJU34iuoVxbGfOlv5WiWu3DndDiR+OrTi91MxpQ5y3zA+Qei1ASi80/hGejSebeoX1fXYSCET1K1zTz/JGA+TUEAms/y3QknmppVrfYIs7B3uNIyTpzB7OkwxFt4YlCYu6EtZQZn7cUqxvxEt2XtOoQ0dgm9UATZz6yBPN9mVfbzoVWQ9eqTfK+fflOU08YU0PLuNPjWEBJZdvsdNU3yORT8YRv8p2v2JGyqQouWyU9l4OvBnmKDJxRqcJHFaicTa1rrNRDy5So4ldFMWC9igtfAlvN84bxH5iNIyZCPUIjshXUZzppoqb2sC22qogxUUYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OURVFamo3rNMfwXgPaCcwoeT8eZj3aPrQgUr/ir/2o=;
 b=Tncy1QoiFrqCLlneAmq4ZMwoe7ffThS4dJ035P8gESl8nOO6h9uIgKoygK/3v1+3hp9CCmkoa+8e4lovVnOTaFZGpYQLOXNkhKc5SyT8b+CXEDeZQfFaKwmC9S6mlKXZqa7RvJ8zwh7qAoB9VFNmvawQ7e669uAt/KMljZLya4g=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB5086.namprd11.prod.outlook.com (2603:10b6:a03:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 17:42:25 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 17:42:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <guoren@kernel.org>, <arnd@arndb.de>, <palmer@rivosinc.com>,
        <tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
        <Conor.Dooley@microchip.com>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <bigeasy@linutronix.de>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 0/7] riscv: Add GENERIC_ENTRY, irq stack support
Thread-Topic: [PATCH V3 0/7] riscv: Add GENERIC_ENTRY, irq stack support
Thread-Index: AQHYwaR9Zg4qVJdaxUOmW+ltdyCEZa3SrMIA
Date:   Tue, 6 Sep 2022 17:42:24 +0000
Message-ID: <8db7caea-a1a0-25a3-ade0-2f1714d709c8@microchip.com>
References: <20220906035423.634617-1-guoren@kernel.org>
In-Reply-To: <20220906035423.634617-1-guoren@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76642d8d-2129-4ca1-cff5-08da902f28da
x-ms-traffictypediagnostic: SJ0PR11MB5086:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWdXClxCDw699jRiUhGiO2D0b449GOTiuqv/fp55aLT9L4rOvziKtvgbQefAyRAgAWjShHcltnNVWgNyRf3+nmVpNPhf5FQ5oD7iirEsxuvGtgR/YZUqS8mYs9q1MaW5f4kkt7wtAppMtCtWR/uLK0TrWMbnEkoZl4qzx4UZYQfWEZn3uFNAYorB4VW3sEN6lxPJPmbmuhEfwChLemeFGEgwLUlgEINkHmWraaDTan8cF6HdcloIVqLVf32FK0Uir+7bVtP10MU44mwOrNccBU+gyC56Gove+ts6hjPtjCRVUPev43wz5seNcbj8sYqzNdxYojiaZqYndfjyZLj4BdvO57jCosqMTH5x59E3NWLPFrZxca1O4Os0i3Uv+Ox4V2O+DRBrF8HWrfL3f6XVC932Ukp16zZFVONV7meUYdJQ+7b5UKKMrlJaXdbwW7pVcbSfdr6UQJNtzHvT3Z7VbcUPKp105n5Ce+P4x2g50s2eyHGdLcupLkCUn/06QGp+uRoa39larJRCs+lknIxVnezWR4qmmivy7WfAgZkkPn85sEVEVrHp6aiW1mK0zMWEFXcXGkcrrHKlRKhjGjqobzZQ7sw5LQyghFcKDgqmLzM+O1iTPf8NtQueO7oGTPnzvFpXYVgZNxU2M9PhTJNIY3yqfq6O2E4KrwoT/64C33p3oSwOqEYQ8wgh2Avg0T5wtXo//GODSNtz08QWAB6HAyXO0lhdbTOOy/ct0gDR3Ls5tnqcoRTsTF27eYR1UkOpem2f5dUNf7ja6ieu2xlZiI3nfIuqenAObXjsWeQZeXG+XgvNLTioYRp3vpub9d7LZMmwhSGCQ7jYgItgMlWxqblKGUK9wuirrD5IWQQUUGtZjaaSE2GI+9O12TBVkF3ayqO4WRCMuy/aQ7PPRC1RUJi9Fq0/HIDf7geV/QcOzSgsAKiuHGuzFpJnw00oTJkK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(39860400002)(346002)(366004)(5660300002)(36756003)(41300700001)(6486002)(26005)(966005)(2906002)(122000001)(38100700002)(7416002)(66446008)(478600001)(66476007)(66946007)(76116006)(86362001)(64756008)(91956017)(66556008)(8676002)(53546011)(4326008)(8936002)(6506007)(31696002)(110136005)(921005)(38070700005)(31686004)(186003)(6512007)(54906003)(71200400001)(2616005)(316002)(83380400001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjNFMkt2cDRENTBjWkJ0M1lwcm1IejlsRlNMdUxjWllDcnlOdXN2NzB4T0Ja?=
 =?utf-8?B?cEU3ZVdNUFBoL0lQMCtLTmh6ZEdJVjVvQlJlL2UyK1d1c1pKMmdkODI2cHo1?=
 =?utf-8?B?NXFVMnkvb0lnWWkyblp3NndoZEM4a0lZTnZsZXhkaTl4TTZabWFmcUZvbjlt?=
 =?utf-8?B?bVZ0OWhPblJaRVBLemRzeUZnLzNsZGtvQVQvaGdTYzhOQzVqOEc1T0R4RzFo?=
 =?utf-8?B?aVhXaEVEaTFmcWJ2NVYvL3pJRmRUQXlWMmdXNTBaVm1GNW1XZG9CbkNOaEVN?=
 =?utf-8?B?dllERTFodkZvZCs0dU9MMC9IeVFRWWNKdXBKUS9CUTA1RHJoMmswd1pYWU1z?=
 =?utf-8?B?cnFqR3lndzN2SUlDTmFveWdzeTZyQmlRSGs0NU5JQ2ZsR0R3UXZLZDJFcFVR?=
 =?utf-8?B?dm9FQmZ3aGhZa0JQcFYrLzNOaU1IWHQrTFVISFVmU2ZqNGhNNVNsY25nVkF3?=
 =?utf-8?B?WmdyYktlcWlaK3RVWHZsSytGYllWaXBuNDVGNkxOdVFMblJORTU2K1ZXMFdu?=
 =?utf-8?B?VVlWZGlGeWVQME9KeEdPRURra0JOc2ZESnA2SGNoTGVTWXdYcmsvTVJIcXhX?=
 =?utf-8?B?aTNlck5IbmREV0NHNG8yTmJaUUxoMFpHbmpLZ2xWdVJnS2VhNmtIN1NHa01v?=
 =?utf-8?B?MnkrSmNGN1RXV0VyVXBpTndHTnJydGVHazQ3VzZxSlRNTlQ0eUxxVWhyeno5?=
 =?utf-8?B?WGgyUDVIcG5KdGdXN1I0VWZNdFVSRDdkVWZHYWUyUzh3V2Z2UHFQM08yNnA5?=
 =?utf-8?B?djRzQWE0a2tQRUVybVdqTjlDMFRCcGU5bmZzRnhQSkVFdDF1RWUzTFN2ODdO?=
 =?utf-8?B?R3NWUHAydEllTDQ2Vk5sMWthVWJTUTNPREFWMHNWb3VkcmNqVDdNdlF1L0xC?=
 =?utf-8?B?dDZQUGVJb0Z3elg4ZnJacWMzdFY5OXFBM0prbEluRGdUb0VOb3pFS29jM3J0?=
 =?utf-8?B?TTBxOHE0UlROYVhnb2ZPb0ZBS2tVTDZTQnd2aTB6SkhpY1hjZno2cERmR3Nj?=
 =?utf-8?B?SHRkdUhXQ21vWWFuTXYzRnZqWk1kUS9LWWRRL1hSUXJOWk8yRTVacmpBbERK?=
 =?utf-8?B?bDRaOHZYOXQ3VmdDa21SQ3NUc1gwVzhFNnpBM3pyci90T0tKbWpMYTFuejRK?=
 =?utf-8?B?R0hnQU0zTWtTa3hnTVpZUUhnczduK2E2Tk9ITmg3d1dLNlVoWjlmUkpVeXBD?=
 =?utf-8?B?T0RQWTJIQzhPVW9xMUc3WVd4RE05SVdPd1JSbVJNd3d5THcxTUFwVE83bzd2?=
 =?utf-8?B?c1hBMWplSjdSejQzQUkrVDdnbVpXdG9XZ0p3dXRQendEcHU4dk1ITnMwbi9w?=
 =?utf-8?B?RGJPKzZ6blorU2xncThGeUl6akphZk5rNDltdWVYT1J1enpLUTlvUjE1ZFdn?=
 =?utf-8?B?OE1rTDlyL3VnZ216MXc1cDVocDJlZkMvejEzRHl6RnovQ1p0STVFNUM4dlJI?=
 =?utf-8?B?TEJaOW9PckY0dXUzWk1YUG1nZXUwTFR1RDIrWVVENzc0WnlJLzJTYVNEQ2dD?=
 =?utf-8?B?U0pUTVR3M3VyZWNwWnZsclpoZ1lkRFV1KzRiRGYzTjgydVU2YlNpV0gwYkNk?=
 =?utf-8?B?MDZmaHh5TldmSFZlWUtmdHFIUzhrZDlQOGhveVVrOEhLS1czS29PWldaa3NL?=
 =?utf-8?B?eG1tNXQ0b3d4UmM0bUtMM0dGQVJOTjdKVW5DUjRFN3hhVGwvekZKa05zYlda?=
 =?utf-8?B?VnhaUXpEd2tvUFpwblBRdWRxOHlLenBzTHBqWjk4cWtJRTZCYStNcWFQMW9S?=
 =?utf-8?B?T3pQU1NvUk1MSi9QQlBMdk5ySTF0bjlHenIxS2swSFkzanhNcEZRNnpydkY3?=
 =?utf-8?B?cG1OQzJCREtEcnhtSlkvbXo0V09jL1pnaGtueHA2NmUwcHp0QklwZWd2Yjdo?=
 =?utf-8?B?a0lheFFtdzRHMzcrWFJiRTVrZDZsSU9JeHZURUJFOFZiRHh2U3o0dVJxZEtn?=
 =?utf-8?B?a0RvUEdVSTFPL3dLNFR2Y0pjaDdHYkIwNFh1MW5FUmlPdEN2ZGl4c0VGVjJj?=
 =?utf-8?B?WXVHVWo2cW1PdzJNVVQzbEpNcS9qbFdUcDViRGcxWHI5Yk1RVldmNUdLN0dx?=
 =?utf-8?B?cUpZbDdVQTRhTFJFNHBhc3QvSXhIaWZHTDlYUGlOaVlPemp4WWxLWnN0SmR3?=
 =?utf-8?Q?f4V6iqqQpG2hVAunIiiXBwpdF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <342286757AABF6428375FBA3E906684B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76642d8d-2129-4ca1-cff5-08da902f28da
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 17:42:24.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FApoG+2vAVEQQK+1DKdETHWXoCO8wlaAuqQNwt8PcFmtodMl/qsCsQpWib4gJxFe43qow/3dNLi7aZGungMT1EmcIAfeVK29w+WADLD4kC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5086
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDYvMDkvMjAyMiAwNDo1NCwgZ3VvcmVuQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEZyb206IEd1
byBSZW4gPGd1b3JlbkBsaW51eC5hbGliYWJhLmNvbT4NCj4gDQo+IFRoZSBwYXRjaGVzIGNvbnZl
cnQgcmlzY3YgdG8gdXNlIHRoZSBnZW5lcmljIGVudHJ5IGluZnJhc3RydWN0dXJlIGZyb20NCj4g
a2VybmVsL2VudHJ5LyouIEFkZCBpbmRlcGVuZGVudCBpcnEgc3RhY2tzIChJUlFfU1RBQ0tTKSBm
b3IgcGVyY3B1IHRvDQo+IHByZXZlbnQga2VybmVsIHN0YWNrIG92ZXJmbG93cy4gQWRkIHRoZSBI
QVZFX1NPRlRJUlFfT05fT1dOX1NUQUNLDQo+IGZlYXR1cmUgZm9yIHRoZSBJUlFfU1RBQ0tTIGNv
bmZpZy4gWW91IGNhbiB0cnkgaXQgZGlyZWN0bHkgd2l0aCBbMV0uDQoNCkhleSBHdW8gUmVuLA0K
SSBhcHBsaWVkIHRoaXMgcGF0Y2hzZXQgdG8gdjYuMC1yYzQgJiByYW4gaW50byBhIGJ1aWxkIGVy
cm9yOg0KL3N0dWZmL2xpbnV4L2FyY2gvcmlzY3Yva2VybmVsL2VudHJ5LlM6MzQ3Ojk6IGVycm9y
OiBvcGVyYW5kIG11c3QgYmUgYSBiYXJlIHN5bWJvbCBuYW1lDQogbGEgYTMsICgoMSA8PCAoMTIp
KSA8PCAoMiArIDApKQ0KICAgICAgICBeDQogIENDICAgICAgYXJjaC9yaXNjdi9rZXJuZWwvcHJv
Y2Vzcy5vDQptYWtlWzVdOiAqKiogWy9zdHVmZi9saW51eC9zY3JpcHRzL01ha2VmaWxlLmJ1aWxk
OjMyMjogYXJjaC9yaXNjdi9rZXJuZWwvZW50cnkub10gRXJyb3IgMQ0KbWFrZVs1XTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCg0KVGhhbmtzLA0KQ29ub3IuDQo+IA0KPiBb
MV0gaHR0cHM6Ly9naXRodWIuY29tL2d1b3JlbjgzL2xpbnV4L3RyZWUvZ2VuZXJpY19lbnRyeV92
Mw0KPiANCj4gVjM6DQo+ICAtIEZpeHVwIENPTkZJR19DT01QQVQ9biBjb21waWxlIGVycm9yDQo+
ICAtIEFkZCBUSFJFQURfU0laRV9PUkRFUiBjb25maWcNCj4gIC0gT3B0aW1pemUgZWxmX2tleGVj
LmMgd2FybmluZyBmaXh1cA0KPiAgLSBBZGQgc3RhdGljIHRvIGlycV9zdGFja19wdHIgZGVmaW5p
dGlvbg0KPiANCj4gVjI6DQo+ICBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1y
aXNjdi8yMDIyMDkwNDA3MjYzNy44NjE5LTEtZ3VvcmVuQGtlcm5lbC5vcmcvDQo+ICAtIEZpeHVw
IGNvbXBpbGUgZXJyb3IgYnkgaW5jbHVkZSAicmlzY3Y6IHB0cmFjZTogUmVtb3ZlIGR1cGxpY2F0
ZQ0KPiAgICBvcGVyYXRpb24iDQo+ICAtIEZpeHVwIGNvbXBpbGUgd2FybmluZw0KPiAgICBSZXBv
cnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+ICAtIEFkZCB0ZXN0
IHJlcG8gbGluayBpbiBjb3ZlciBsZXR0ZXINCj4gDQo+IFYxOg0KPiAgTGluazogaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMjA5MDMxNjM4MDguMTk1NDEzMS0xLWd1b3Jl
bkBrZXJuZWwub3JnLyANCj4gDQo+IEd1byBSZW4gKDcpOg0KPiAgIHJpc2N2OiBlbGZfa2V4ZWM6
IEZpeHVwIGNvbXBpbGUgd2FybmluZw0KPiAgIHJpc2N2OiBjb21wYXRfc3lzY2FsbF90YWJsZTog
Rml4dXAgY29tcGlsZSB3YXJuaW5nDQo+ICAgcmlzY3Y6IHB0cmFjZTogUmVtb3ZlIGR1cGxpY2F0
ZSBvcGVyYXRpb24NCj4gICByaXNjdjogY29udmVydCB0byBnZW5lcmljIGVudHJ5DQo+ICAgcmlz
Y3Y6IFN1cHBvcnQgSEFWRV9JUlFfRVhJVF9PTl9JUlFfU1RBQ0sNCj4gICByaXNjdjogU3VwcG9y
dCBIQVZFX1NPRlRJUlFfT05fT1dOX1NUQUNLDQo+ICAgcmlzY3Y6IEFkZCBjb25maWcgb2YgdGhy
ZWFkIHN0YWNrIHNpemUNCj4gDQo+ICBhcmNoL3Jpc2N2L0tjb25maWcgICAgICAgICAgICAgICAg
ICAgIHwgIDE5ICsrDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2Nzci5oICAgICAgICAgIHwg
ICAxIC0NCj4gIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vZW50cnktY29tbW9uLmggfCAgIDggKw0K
PiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9pcnEuaCAgICAgICAgICB8ICAgMyArDQo+ICBhcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL3B0cmFjZS5oICAgICAgIHwgIDEwICstDQo+ICBhcmNoL3Jpc2N2
L2luY2x1ZGUvYXNtL3N0YWNrdHJhY2UuaCAgIHwgICA1ICsNCj4gIGFyY2gvcmlzY3YvaW5jbHVk
ZS9hc20vc3lzY2FsbC5oICAgICAgfCAgIDYgKw0KPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90
aHJlYWRfaW5mby5oICB8ICAxOSArLQ0KPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS92bWFwX3N0
YWNrLmggICB8ICAyOCArKysNCj4gIGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlICAgICAgICAg
ICAgfCAgIDEgKw0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvZWxmX2tleGVjLmMgICAgICAgICB8ICAg
MiArLQ0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvZW50cnkuUyAgICAgICAgICAgICB8IDI1NSArKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvaXJxLmMgICAgICAg
ICAgICAgICB8ICA3NSArKysrKysrKw0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvcHRyYWNlLmMgICAg
ICAgICAgICB8ICA0MSAtLS0tLQ0KPiAgYXJjaC9yaXNjdi9rZXJuZWwvc2lnbmFsLmMgICAgICAg
ICAgICB8ICAyMSArLS0NCj4gIGFyY2gvcmlzY3Yva2VybmVsL3N5c19yaXNjdi5jICAgICAgICAg
fCAgMjcgKysrDQo+ICBhcmNoL3Jpc2N2L2tlcm5lbC90cmFwcy5jICAgICAgICAgICAgIHwgIDEx
ICsrDQo+ICBhcmNoL3Jpc2N2L21tL2ZhdWx0LmMgICAgICAgICAgICAgICAgIHwgIDEyICstDQo+
ICAxOCBmaWxlcyBjaGFuZ2VkLCAyNTkgaW5zZXJ0aW9ucygrKSwgMjg1IGRlbGV0aW9ucygtKQ0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vZW50cnktY29tbW9u
LmgNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3ZtYXBfc3Rh
Y2suaA0KPiANCg==
