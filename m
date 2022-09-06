Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82B5AF2CB
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiIFRjL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiIFRib (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 13:38:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4052F59D;
        Tue,  6 Sep 2022 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662485721; x=1694021721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QR8gvZBpyv5eCF49zr2XkbTnFfFS99UEe8Eo81gM2mI=;
  b=bo0Z5SViiEaPd5s4pN7GtrH8nu0PbSZZga8Ga+c+bB3F5kp2c/WOGPym
   qVa4yaSjFBMFUhIcAxK8B8CjIxNJDHMmBg+BhzpArVPeCronl83rbV4Rq
   xvHjr14llOMGTyQ+r53Me4dnbxuE/mUOXESGhDxZC3uhNn68kcK18dwI0
   2sqLxOGc+dOgB0VlKH6RSZSn+6CvXWht97xk5ZColTgyXR6qG73uXiGNf
   99RniHa/DLP3lq4O2GtxUSQ3zv3y9hSzsZSCWZw8Hocu3BWIAZYflc5wg
   aS+O0hg7Syzig9Ldxpm4iChYwFAHqVHMl9AcEzytPCpz3ONqaBmcX0yIL
   w==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="179260968"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 10:35:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 10:35:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 6 Sep 2022 10:35:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AebR7Mtwii6SDzuUkKSRJyxYir8g1fbZmXY2wQpYH+dE2B2RKEjys+ry3Qof05yirRVPKbOQIylF6IyALDcdNi52WiKVMRSNvJK13JfOB/ZxiWeXVCjHjq5hTLCjjgLFgbdI85uyeR4r2FN257V2whaYONURkeDNK9SQ4f6pWGiBrHrFWDwIbpr6GAI0pmY4T82QdrHqFKzdA88sdDmjucCisAY8sImuHek0heEPWvQDS6AWNYu4f2oGhUtrX3nh10y/x5LwkXzbf69B+65e8jKw++A1zgGThsZnXCoDtL/xpLiAVhPtPSijftZqvg1YWucS+cVcmwvSR7IidFhyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QR8gvZBpyv5eCF49zr2XkbTnFfFS99UEe8Eo81gM2mI=;
 b=P/fXNnb67mXddIKmD4khDKSSTNN/34LXHFzrj5EBxE2Nkn+5gdD46WIkl0VefBvxmlOA//Mc+5TGmdozfr068/q5NLulfsIGzviV/OEybhCgvhPgf9tofjyfv60LV1xTF4F7eDw6TJVo+zETEYQxoo5XuWocFRrbHhz4/6AcNo172y0/O1ZyrcK6BxrTyjGy8j2TCKR1L9GPW9tix/VQOIw+8V4hYaX6Uqwee73hMuxMzABY8pI6iovdUC62XVHoLlQOn6nsoRuksXJaXyKAeRFQ5aby16ulNDf0+A+ZjcGUWgcjc7XHNnhYxjE1DoNsb10FOPe3dErVnb+RCNEbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QR8gvZBpyv5eCF49zr2XkbTnFfFS99UEe8Eo81gM2mI=;
 b=Nbv2w8ABmAvdrHMdRI+B4zd50NMRbwZrLTbfy8ld3ba3Kz4sNcWmxb5iZJWPeHxjvCnabAcjq5aDFbsEjH2dl+aVq/dm0kI7dDOX1QFOONqEBMEXxXyvhevd96+H/EGVVoakd1Cwe2PE32f/pLYyNC30Pydk7PuIdbwf6PzIkec=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR1101MB2088.namprd11.prod.outlook.com (2603:10b6:910:17::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 17:35:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 17:35:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <guoren@kernel.org>, <oleg@redhat.com>, <vgupta@kernel.org>,
        <linux@armlinux.org.uk>, <monstr@monstr.eu>, <dinguyen@kernel.org>,
        <palmer@dabbelt.com>, <davem@davemloft.net>, <arnd@arndb.de>,
        <shorne@gmail.com>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <ardb@kernel.org>, <heiko@sntech.de>,
        <daolu@rivosinc.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-snps-arc@lists.infradead.org>, <sparclinux@vger.kernel.org>,
        <openrisc@lists.librecores.org>, <xianting.tian@linux.alibaba.com>,
        <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Add STACKLEAK erasing the kernel stack at the end
 of syscalls
Thread-Topic: [PATCH] RISC-V: Add STACKLEAK erasing the kernel stack at the
 end of syscalls
Thread-Index: AQHYuuW9rugSRYh05UmTe1hHac9Fz63SuDoA
Date:   Tue, 6 Sep 2022 17:35:10 +0000
Message-ID: <6c48657c-04df-132d-6167-49ed293dea44@microchip.com>
References: <20220903162328.1952477-1-guoren@kernel.org>
 <20220828135407.3897717-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220828135407.3897717-1-xianting.tian@linux.alibaba.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c76c48a0-5560-42cf-0b22-08da902e2633
x-ms-traffictypediagnostic: CY4PR1101MB2088:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUEJXo+oFmqdtN2i7ThrqMpY2fphg4+cgcjZtJZDK9ttEX2yRJtyGX/aUPOpr3JVRd7SCWBkNue6WxL+AHAis27FFzoBLYwnaaFlbWJFpgjRE8Www9QTNTILXiTAqh3RDQqN08JS7BG0t5Y5qLZsjxQhhSkesNdHftyQlAAMHUnG9ChzMlozunl7T40LwukJ5UBWtiHOhiXKaoDKfcKhNXFkPXNPwb3qHymydDn90pnPeGb/4+2bgAlhtV3ofX8MayN3/3TWczLVW3Olc3BQ4TFkhrzjzxa/eONedQzQ00ZVWXWghmvrtT/VqmPkaluV6UV/EOjpCa003OWqe7hbJ6HQEfY2Bk2ihcMv9lbtu64cSpoSQQiRzZfxZf5DWhvrvBOFZiA8MXRpZHYtxM/D11cy6tzGX6IsyBjfNiziDRCzqbuuYMiVmAd53osWlqCjaihIpRywXuluOFaVr3cBkr5A+kwLygILUZ5xWxiiCdsQUhGOHSmQdeHSup5tcS9YuGs6Nie2kZgUU99EVwC/zxhjgvoLDWY+keq+RnoMbsJlxhnNQSOkbjjrT+3kFKhtXdp+9XT/yW3uc2K+0MGurjtviQ9LzpXdrUG5yntOTWp6etIzmFzJFbicNyrsagMgQqggLUjCsZW32WVuXrPeXlIqYpLS1HsEDJkGkzG9NXI4KJcNBLfFnVHUsuIx7CbrvpK46kqmvRT+G3KAafQREaPhXQ+9K43K/akyJlDB6D1OOFS0Z0mZGR7aWz4pC2Z5gx3Kr3dG4kDT5dI2PPEijq7VoalMTAxKmJTbT5Ww4rveY9J1UXbkIB51opv36MbuYDCEMEzW0PmLM6ngqXogqn1YVMBkKaiOVze3Ao8femCYEPk/SLZdEKtJj/ad7EYBL6In3Cdy30FqSKJBCQ7h6Co2mtpjeul0IzDZlURngKY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(396003)(346002)(39860400002)(8936002)(66476007)(76116006)(8676002)(91956017)(478600001)(71200400001)(6486002)(966005)(64756008)(54906003)(66556008)(66946007)(4326008)(316002)(110136005)(66446008)(38100700002)(2906002)(122000001)(7416002)(5660300002)(31696002)(31686004)(38070700005)(36756003)(83380400001)(921005)(6512007)(41300700001)(2616005)(186003)(26005)(53546011)(6506007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SE43ZFZieVlzTTFrNVJGRnNPakRVRHd4R2J6dVJWck9XNzd3b3hxclZINHJZ?=
 =?utf-8?B?anE4VWRlbG5WdEFKQmtMOWZ2MUxzTTJuZ2tZMTg5U2dSS1hndmE3UnJoNEx0?=
 =?utf-8?B?K05TZmM0YVNsQ3pKbU8zYkpjYWJ6d2RySlZIdjhYMVNYZmc4c1NCc2svMzU2?=
 =?utf-8?B?QzZBTkRnQjcvS3U3NWUzb0JHMVRaSHVTZGxjaDZFWWFZdDVRekZ1RWxHbEo5?=
 =?utf-8?B?ZHBYZ0haZVdFQTdlY0UrUmZ4UnFEcXFXc0hubVFKN1NYYkNZOTd1bXY0dnl4?=
 =?utf-8?B?T0tJZjBqOW03S2VOOUw2aG1qTU9xSS9pZE5pMU1YTDcrMXFHUXRqS0FLMVVa?=
 =?utf-8?B?enpJTS9xMjRqTkxPWkJXdVcydzVkT1NBbFZZQmkydTFQNGFSRXBzMmNJekZS?=
 =?utf-8?B?QWUrZkhwaDI2MDZnYTdhZEZORERsWVpja2pQbWZHYnFBQlhrcGIvTU05K1N6?=
 =?utf-8?B?TXNrZDQ4VmFjMy96dWdDOUxIQzBGeERJd2lpNjh5WUNwNGNvUUNhdUl4TnVz?=
 =?utf-8?B?aXNaREdEb3NWQW5nd2ZQVEp6RDhnb2c2ZTllTmVSUnh2K1pHa0UyMzdzNDJl?=
 =?utf-8?B?SzduMzR6a3NUUGs3UWhYTGFnRmxrL1dsZzljQm5lcGlsN29xUllpOXpwdHdC?=
 =?utf-8?B?dlpaNXZLYmNmNXhCL3d3QUcyclczSFl2L1ZmWXBycmw1OTZXbW1XbzBEZmQ1?=
 =?utf-8?B?L3Ava0gzWGxJdVhPK3ZreWExZTRGcjNDTkcxd0gwTHFvK1l6RVZPTUlQMkQv?=
 =?utf-8?B?MWlKQjR6NzFkUTNrMkN5eEZMQk1GQzdoM2t4cHlPeUtuc28wTk9EUC9lZWQ5?=
 =?utf-8?B?aEVZTWRWWERWTWM4dG1OT1lGaFhrYUVUSXpZNzhiWDFNOWMzaVJZYW5ObmxM?=
 =?utf-8?B?b3BMWDRtOExPUFF2MEVndzR1bEh4S0FqYmpLbGEvWVp3L29Yd2dnRDhDTTlC?=
 =?utf-8?B?RVBrY212T0xIaUpobEg0TDBxckFEWTF0bzBHZVFmUGNObnhJUXlSUjRYbzVl?=
 =?utf-8?B?M1JuNVZBZnlDTDBlTGoxVTlqZ2F0bFIwbUlsbnNlZnkzVDg4UGQ0S2ZRKzlh?=
 =?utf-8?B?VHhRMUx0d1BQYmxxdFE2NkVHcDRnM2lmVDJZWmtHTi9ybEd1S2s0c2I3RkUy?=
 =?utf-8?B?T0NLQmxnRG14a1ZMWU0xWVo1ZlljUHFwTnFBRjZZMWFYRVFNeTNFR2Y2WWs3?=
 =?utf-8?B?RUhLRDZhdDFiR2xWUkQxTWNaNkx1eEZoQURjM0swa1dZNmUwdTN1djRFVTA1?=
 =?utf-8?B?SjFSMldrTVdPTUFYNDRCc1lYNjNkb25hZ2RVdjI4MDlhcnZGVC9QdmJ0TEky?=
 =?utf-8?B?TGpWQkVXaHZLRXFrd3JQNUZvTi85NGpGRXAwL1d3d08rS1RaQlluSFpmOVNw?=
 =?utf-8?B?eWVSNDN0eUpGV0Mxc0s1YUliVUorMy9vSG9manl2dzhsNXZwM2JuZWJRWGJN?=
 =?utf-8?B?anJITXhuRUpUSHVmSTVSUUxEakpHNzB4UWNETUlRT1pYYjArZXl4WmxDaGpE?=
 =?utf-8?B?SkozK1g5TjhSR1NGVE5lZGpsRU1XUWtnTVNvb3BJV2VLSTREVndGVERVWGNh?=
 =?utf-8?B?N0V0UHNxbWNKaUZsUW9KczRqV0pYemEwWDllSHdjZGNCOEZYcGl6RFRCYnF5?=
 =?utf-8?B?RGNEWW9FNjVzVm1wMklYc3RKNHd1OGM4dWVwS0Z2Rld4dDBnR054NCsxc3FZ?=
 =?utf-8?B?Q1lzakFMMVdMNVdEZFNmZGFkZ1I4RjhmZmtlR3VOd0w2QUNrVVd6QUtjcmw4?=
 =?utf-8?B?UmxGWnA2ZUE2MDErSG1yWFFvV2ovNDQ4WEJlLzdCWnhHNDkyWk04OEVxeFJT?=
 =?utf-8?B?Q3JsSnpYTVIvMDAwcTRxOEZKdWMxcmw2Qk5FRlkzM2h0SFFjRW9HZCsrMXlw?=
 =?utf-8?B?cmNTb3NpdzFPMlAwdnl5Tjl0OGpsM0ZxLzVuK2U4enNteWdxQ25iQ3lpZTRu?=
 =?utf-8?B?SzJyam12MkdRaU9SVjMvVFZjaEZSSnc1Z3JXL1NNUi9WMmNGMjRvZGladlhl?=
 =?utf-8?B?bjd3YkNXR2Vxc3hzRkVESGxONDdBWEM1WnhLZXY4S1FCYVYwSU5wYjVEb25B?=
 =?utf-8?B?dEF5NU5ZOWNhbWRqUnYyQU1iZUc0Q2cxQkR3RGFsQ1U0Qll2UWtCLzBpak44?=
 =?utf-8?Q?LbBR2w3kgfv0ZFCtOdhEw+an5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E20572F5CA14F145892642055954ACDB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76c48a0-5560-42cf-0b22-08da902e2633
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 17:35:10.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hniry5rVie9lqzo/bgPVCNOrqcvsKPAy3oTIJ07JkyyEaZ0xPKICQN0UckefZIvB+w15TOwcAWFja3mR+20YiDxDjO8oxlD9DRgl4T8Ogdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2088
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDMvMDkvMjAyMiAxNzoyMywgZ3VvcmVuQGtlcm5lbC5vcmcgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRnJvbTogWGlhbnRpbmcgVGlhbiA8eGlh
bnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbT4NCj4gDQo+IFRoaXMgYWRkcyBzdXBwb3J0IGZv
ciB0aGUgU1RBQ0tMRUFLIGdjYyBwbHVnaW4gdG8gUklTQy1WIGFuZCBkaXNhYmxlcw0KPiB0aGUg
cGx1Z2luIGluIEVGSSBzdHViIGNvZGUsIHdoaWNoIGlzIG91dCBvZiBzY29wZSBmb3IgdGhlIHBy
b3RlY3Rpb24uDQo+IA0KPiBGb3IgdGhlIGJlbmVmaXRzIG9mIFNUQUNLTEVBSyBmZWF0dXJlLCBw
bGVhc2UgY2hlY2sgdGhlIGNvbW1pdA0KPiBhZmFlZjAxYzAwMTUgKCJ4ODYvZW50cnk6IEFkZCBT
VEFDS0xFQUsgZXJhc2luZyB0aGUga2VybmVsIHN0YWNrIGF0IHRoZSBlbmQgb2Ygc3lzY2FsbHMi
KQ0KPiANCj4gUGVyZm9ybWFuY2UgaW1wYWN0ICh0ZXN0ZWQgb24gcWVtdSBlbnYgd2l0aCAxIHJp
c2N2NjQgaGFydCwgMUdCIG1lbSkNCj4gICAgIGhhY2tiZW5jaCAtcyA1MTIgLWwgMjAwIC1nIDE1
IC1mIDI1IC1QDQo+ICAgICAyLjAlIHNsb3dkb3duDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFu
dGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tPg0KDQpXaGF0IGNoYW5n
ZWQgc2luY2UgWGlhbnRpbmcgcG9zdGVkIGl0IGhpbXNlbGYgYSB3ZWVrIGFnbzoNCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzIwMjIwODI4MTM1NDA3LjM4OTc3MTctMS14aWFu
dGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLw0KDQpUaGVyZSdzIGFuIG9sZGVyIHBhdGNoIGZy
b20gRHUgTGFvIGFkZGluZyBTVEFDS0xFQUsgdG9vOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtcmlzY3YvMjAyMjA2MTUyMTM4MzQuMzExNjEzNS0xLWRhb2x1QHJpdm9zaW5jLmNvbS8N
Cg0KQnV0IHNpbmNlIHRoZXJlJ3MgYmVlbiBubyBhY3Rpdml0eSB0aGVyZSBzaW5jZSBKdW5lLi4u
DQoNCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwgMSAr
DQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oICAgIHwgNCArKysrDQo+ICBh
cmNoL3Jpc2N2L2tlcm5lbC9lbnRyeS5TICAgICAgICAgICAgIHwgMyArKysNCj4gIGRyaXZlcnMv
ZmlybXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUgfCAyICstDQo+ICA0IGZpbGVzIGNoYW5nZWQs
IDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3YvS2NvbmZpZyBiL2FyY2gvcmlzY3YvS2NvbmZpZw0KPiBpbmRleCBlZDY2YzMxZTQ2NTUu
LjYxZmQwZGFkNDQ2MyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9LY29uZmlnDQo+ICsrKyBi
L2FyY2gvcmlzY3YvS2NvbmZpZw0KPiBAQCAtODUsNiArODUsNyBAQCBjb25maWcgUklTQ1YNCj4g
ICAgICAgICBzZWxlY3QgQVJDSF9FTkFCTEVfVEhQX01JR1JBVElPTiBpZiBUUkFOU1BBUkVOVF9I
VUdFUEFHRQ0KPiAgICAgICAgIHNlbGVjdCBIQVZFX0FSQ0hfVEhSRUFEX1NUUlVDVF9XSElURUxJ
U1QNCj4gICAgICAgICBzZWxlY3QgSEFWRV9BUkNIX1ZNQVBfU1RBQ0sgaWYgTU1VICYmIDY0QklU
DQo+ICsgICAgICAgc2VsZWN0IEhBVkVfQVJDSF9TVEFDS0xFQUsNCj4gICAgICAgICBzZWxlY3Qg
SEFWRV9BU01fTU9EVkVSU0lPTlMNCj4gICAgICAgICBzZWxlY3QgSEFWRV9DT05URVhUX1RSQUNL
SU5HX1VTRVINCj4gICAgICAgICBzZWxlY3QgSEFWRV9ERUJVR19LTUVNTEVBSw0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZSBiL2RyaXZlcnMvZmly
bXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZpbGUNCj4gaW5kZXggZDA1Mzc1NzM1MDFlLi41ZTFmYzRm
ODI4ODMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvTWFrZWZp
bGUNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9NYWtlZmlsZQ0KPiBAQCAt
MjUsNyArMjUsNyBAQCBjZmxhZ3MtJChDT05GSUdfQVJNKSAgICAgICAgICA6PSAkKHN1YnN0ICQo
Q0NfRkxBR1NfRlRSQUNFKSwsJChLQlVJTERfQ0ZMQUdTKSkgXA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC1mbm8tYnVpbHRpbiAtZnBpYyBcDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJChjYWxsIGNjLW9wdGlvbiwtbW5vLXNpbmdsZS1waWMtYmFz
ZSkNCj4gIGNmbGFncy0kKENPTkZJR19SSVNDVikgICAgICAgICA6PSAkKHN1YnN0ICQoQ0NfRkxB
R1NfRlRSQUNFKSwsJChLQlVJTERfQ0ZMQUdTKSkgXA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC1mcGljDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LWZwaWMgJChESVNBQkxFX1NUQUNLTEVBS19QTFVHSU4pDQo+IA0KPiAgY2ZsYWdzLSQoQ09ORklH
X0VGSV9HRU5FUklDX1NUVUIpICs9IC1JJChzcmN0cmVlKS9zY3JpcHRzL2R0Yy9saWJmZHQNCj4g
DQo+IC0tDQo+IDIuMTcuMQ0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LXJpc2N2IG1haWxpbmcgbGlzdA0KPiBsaW51eC1y
aXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YNCg0K
