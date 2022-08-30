Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA75A5ED8
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiH3JDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 05:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3JDG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 05:03:06 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120045.outbound.protection.outlook.com [40.107.12.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBC49F1A6;
        Tue, 30 Aug 2022 02:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZCnBUWJh4ErL9afKkrtEV242fQ901gPD4HC7ft6D0q6c0/uZvjki9m6sWg8KFQYKo+EnXsoOUzk7BqdK1GmkshXylVb09UhBtWMq1eDxHiSOpN3wc9DYee5zZ7EHAR2K5sVxwrwBJr2QDY0P4DtoyfKViTUQlqbA9OpxfjK57Soul7EVv5Pzrto6wDH4FwQ8k69nhDPiHlCt50KCigmFXqxYe+QzeeBj90XfDRcbF7Yo7OV1EPsCM81EVxqHAoURVe19dooeSxooY66bK4Bk+qJgMqOrPjE6do7z2Tto2F3kAChL88C+YtxJcuWfLJzcg1P1ROC8mY/JKZf0Lx/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb9M1ZFfklg2EaPjPQr088/O091OOBKKHaKBjISfRL4=;
 b=TYunSVNqcUoKQiDccIZvhclDK8PKoRLbLqhz75ihpQvLvJ7r+JanWoTVmUyDavD10tsINWR3d7z9FCkc9ew4/o6wJ2/DyIowHXXs7kaL4OJVsdy5+ML5FQnwfBuwXNl8gCcpzw9wVZDQll/QNw5h5Rc0yAHuWWpmfyEeSDVS+/4ul+F0L6gRd8wTEftd8BrCbkt45Y1DslKVdThvoCkcK4YamusiElAoQQ4syWRoSpW2P+vH83qcbMkvIg7t2upF1lCBGTP6Vd0y87ISvPaW15r9t96fJJMGhoxNLtmXyW/kITQpDOK2lIFiPuA5AtA54QcYFXn7b13/umwOyUPS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb9M1ZFfklg2EaPjPQr088/O091OOBKKHaKBjISfRL4=;
 b=A21MorpM2vEIDmDaCgzccybT1kTBc7y7/b4j2N3+tyHfkACRDcaVFl0DrYTWKlHaQAGuwklmMn86klyAKXJD5MVlkjC5ve/WGCuROqxd4tDF/vTjh8d3+R1xc2kOu3OW4bLEyHxoxKg7RQ8Ja1WibPlvKMKXttMgeEOEhz9/RhFxNd6Yfgr+yCCMSKOCTCpthlivPLPm8WusXcbl5sm+RSf+jggB/4KHTAl8WXnGpAfAGejoYZnoGZcpaJq9eYGAaJB5hRkGh1CC41QDq8CUx468Vej44noef69m9XcE87SEZXdXnqEoNt0WKOicgo/b+saq7L90maaFwCU5FxQgPA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 09:03:00 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 09:03:00 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alessandro Rubini <rubini@gnudd.com>,
        "ciminaghi@gnudd.com" <ciminaghi@gnudd.com>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gnurou@gmail.com" <gnurou@gmail.com>,
        "acourbot@nvidia.com" <acourbot@nvidia.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Thread-Topic: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Thread-Index: AQHYq9yc0+2EsNg9hki12SrFrcAXy620c0uAgAAEKoCAABfpAIAABZOAgAAOlYCAAAXLgIALDnQAgAAGlgCAAY9WgIAAFeqAgABxeACAAk4kAIAAEC+AgAMBeQCAAAmoAIAACFqA
Date:   Tue, 30 Aug 2022 09:03:00 +0000
Message-ID: <8f108a8e-339e-9aa3-3279-ea6c9e142df3@csgroup.eu>
References: <Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
 <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
 <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
 <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu>
 <CACRpkdZpwdP+1VitohznqRfhFGcLT2f+sQnmsRWwMBB3bobwAw@mail.gmail.com>
 <515364a9-33a1-fafa-fdce-dc7dbd5bb7fb@csgroup.eu>
 <CAK8P3a36qbRW8hd+1Uhi88kh+-KTjDMT-Zr8Jq9h_G3zQLfzgw@mail.gmail.com>
 <Yw3LQjhZWmZaU2N1@arcana.i.gnudd.com>
In-Reply-To: <Yw3LQjhZWmZaU2N1@arcana.i.gnudd.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2a32559-1a5f-41f6-5970-08da8a667071
x-ms-traffictypediagnostic: PR1P264MB2295:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 72cofz/G5kz+gG5DGpz4lqU8mENtzQHzE0XKfD64HmyBdI1S/n2Lfj4iIqWQQVeCqLYQScts8763fnYbItx4mI4eRPmQG4w2lYiBtnwqqtRZunXCrYF6jaTAQw5n8DB3PZM2f9CN8aaplV8v/1YlmxjBR3hy+R4oQEfMy0yQCQrOYbMSl76NlK7x6kx2NvtjGiaKILMiJ+zz1PydtkZBPbzK35GV4VSxCJgTgkEvmNj42mIiqV/uHLwioqZ1/h6TSBsIvZvi/UcCD5jTr55395BzupLMXa095VFK8RoV6/hL16lS3rgljUw4eIG/49e2JxGE7iez/a2zgFDZYxccq2Yp/7q+VInjfXGxMAe7pksORg0Vn3Yi3rMn6/S0Psqz9i7a83gcIaAiRp7ta8rDyJes4KQuD60O9LaVg2Bjup0i7Tw0ST+CL31NT63e8O/8JFYSXbY/3h3OMgEK8bMaRwXQ9xpppZTHVevHrSygEOZBOIyDdDTRDSfwKeHN0SzgjFEHjXLNApwlucbnO1IYxOAyPBPpUL/dPWpIsDmbtvWUPyE+KFN6tH1kwLaVRYyG6zDo2o4ZwwGkatFJgRt7au2eDhqvyDbv8oCAd1yjkkZVx5z3Um1vdZjGkGkUlVE0/pbWP1ujALewOIdZECBvOa1XDw1+tIza6QzrpmrElVAbt217D6rmb4euEbR7EVvU3h0Gl/9CxA0u2w1rpbS7J/Fo8kn8vyBOZKc3HHz8FvbYHzUFDhQLTxxsN1Acb8T827p6v8YgfYDKdHa4G8cjR12tpPpGbPMUT7WEcIRraTI/MqlaeRhp0tb0y5Z7LcWsHwezk12aeO/OjDaVccxSlh3KyabXPVX6zxDDtThJHc8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(346002)(136003)(396003)(366004)(376002)(66574015)(2616005)(91956017)(2906002)(186003)(71200400001)(316002)(83380400001)(31686004)(36756003)(44832011)(6506007)(26005)(6512007)(86362001)(38070700005)(54906003)(5660300002)(478600001)(8936002)(6486002)(122000001)(41300700001)(7416002)(966005)(38100700002)(110136005)(66476007)(31696002)(66946007)(4326008)(66556008)(66446008)(8676002)(64756008)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V092bE1PZ0JFSlpudnlYQjlKN2RCUlZNNEJybk1ma3UvcHNNQ2tleGdXa2Za?=
 =?utf-8?B?d1JDMXM4Qy9WNVd2QXhobWFwSHVQVk5kTEN6ejc0N1NKUFBNN1BwQ1NXakh2?=
 =?utf-8?B?alhtOVhSeFhpWnBzTVZZLzJsbjM0ZDZPa2RBMFowZ0dJY1FSbUVXTFlmZ01F?=
 =?utf-8?B?UWxINlpnblpqeHdvQUNJd3pWRkRPamxUMVB3RFAxR21Ba0tRUjMzSjlqejNp?=
 =?utf-8?B?RitOd1c2WmN6THA2bHdDcG5HR0pjMmZUSjdVQmpIZW5XNHZ1Wnh1aHloYnZq?=
 =?utf-8?B?M1FBTlhaa2VYWVBrTzZEcVB1YnBpSkhCMWZMT2lKM01pdVIyRGFUQ3g3UDRP?=
 =?utf-8?B?RHp1ZXBxdmtFS0hrdHBScjhyZ2dYbngzNkpEWkEyLzEreTFtQXpZL2xsMUh1?=
 =?utf-8?B?TjRIdnVVQlcyaEJob0xxbGRWQU1xT3orcHNQWDlYMjczSy9pT1FXL2src04x?=
 =?utf-8?B?Wkc2UU9FMVdWc09ONXd3UHcrK2FSeTVuU2Znd3NpaGdkRmtyaWVDUFRPeGVH?=
 =?utf-8?B?bDlOU3ErcmpMTWZvQVMvOXZJQTFTVjhNRUlJQlNFZWsyekVaQm05bGpDK3Mx?=
 =?utf-8?B?eExiZTRUWjlQUnR1czNSd3M5NGRyd2I0azA1R0hiM1c5QmdMMWNqb3UybG91?=
 =?utf-8?B?UlNJOFFRRzZhYUdsWVlCV3pFQ2MyQkt1SW9HYkgrR0F5RWVLWDdtdmZDS3pK?=
 =?utf-8?B?UTFzMFZzdGtYZXRZQmVWdTZDNi8zakUrM1g3L3NaMEF3ZytSQjkxaklDZzFo?=
 =?utf-8?B?SWJGMThubEU5ckNFQVhxVTRRNlkwTCtjV21sTmhBTmwwNEEydDM4dkFWVytL?=
 =?utf-8?B?REJMSzVSMmNkYlpPc0syeXI4a0FJWmRPS3lQYmdFMVh5bU1nQ0UvU3pNZ3VM?=
 =?utf-8?B?NEthZGF5SkZzSGZjUUo1Z1k4VVJhNzVpbG1qKzNzdG1XREJsL24xUk0wMkpy?=
 =?utf-8?B?M0NRZjJjbnlIYU5FNUpOajN3V0x4bDd1TnI2RFZ2VnNWMG5iU0dyeUJ2T0NL?=
 =?utf-8?B?WDdoMnJpYWdaNmxHZEo1c1Vob1VLaXk1YVdBTDAvcVhoYWtBdmN4Vzk5VlZR?=
 =?utf-8?B?TFZ6TE54UFR6L08xREczTFR6OGEyaXF3VVR1ZTZhLzdCL0lSNlhLek95TS9K?=
 =?utf-8?B?bWxDWjRkdjdwcERGcjQ5L2dyYXVBRVh3V2w1bmNEZ2pWTUxyRytTMnBwZGg3?=
 =?utf-8?B?eVBUcytmYk9xTU9aeUI3YnRNNVNPV2xJTUlOdkduZHdFdzJPckhpbTlOam9a?=
 =?utf-8?B?THJVVEVpZmJOL2YxU01sZFV0ZlQ2TE1IY29YUmlWL2ZhcFozTDlzcU9MYktM?=
 =?utf-8?B?dmJabmVWOHpOa0NvZDhITTZDc1RWN3Y0ZnhkUm9nQS8rME1xU3VKUHVYbDhV?=
 =?utf-8?B?cWpSRHJ4UEZtaFp0VnBaeHB5WUlybnQ0UFRTeExUdW0zWXFrSnBtV3BCQmVj?=
 =?utf-8?B?TmpiQW83Y2RGNGk4RmdZZ0FZUFNCK1lhWWVMY0xBQzY4QXVSR0dsMW95U0Fk?=
 =?utf-8?B?RHhNbWkvemVrbUFMWDlJUXRncHZlaUVqd0x6eWx0RENIKzNpV1lvcTVONnVi?=
 =?utf-8?B?UUUvcU80RDg1ZWdoYlRIQ3Rsa3RDOEtHS2MrbTlOMCtyWnA4SUFkUFY5SmRi?=
 =?utf-8?B?cVdUNWs5Y0p2KzRmc25GdFNKR0hYODNNYysycW80eGtsRGdPSmMyMFFaUFFD?=
 =?utf-8?B?U0l0UnJWbnc4WmFvcjdzUDB5WDVBcko4ZG9uM0puaG4xWkNWYzFCUEJWdDZw?=
 =?utf-8?B?bndqWkRKNzBSZG04UXZEUUNkSHhTaGNmTGZYenM1eVFUdmJTbjRNNUp5ZWlu?=
 =?utf-8?B?VzhDNU5tcWlCNVl1QUM0Y0UxWkhZWi9mRW5tb2xtSnJWYUp3L0w0MEJINy9R?=
 =?utf-8?B?QktPWUhhZnljUjg0MFpnaE5QZ2lTN0lncDE1K0hSSzVuMkYzR0ZEUmVJUXBK?=
 =?utf-8?B?TzQ4VDM3ak8rUDVLTjdOT1YrL1VTRnZSRDFpNWZ4NG90NDM3Yjl6RGtoZVNG?=
 =?utf-8?B?QXpuaWdSRE5ubGE1YjF5cVpjM2QxTTJDWHQweWhHT2hFd2xYdmNYSDBacHc0?=
 =?utf-8?B?STc2UHlDaEhtdWc3ZmdpaU9QZ3poNEpLSVR6QmFOS1hTZXM0dGZ1YXl0UHdD?=
 =?utf-8?B?Ri9VbFBwNTFXcFRCQlVMd0xONWlrc2Nzdk9XUU15UUlyeUMwRVBJQUJyOEtk?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAC531872A71F04C8BD5E595BEE74EFC@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a32559-1a5f-41f6-5970-08da8a667071
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 09:03:00.3964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvoVklja1U9dYR16yKk65r7Kfqn2ty+cNlaecdMeZl4AYqr4u+nfJl/Oyw0YXQxalHr0+Y/BBvXSyW7ZdGaxFYkHpR5N7KCCgethQxM8AmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDMwLzA4LzIwMjIgw6AgMTA6MzMsIEFsZXNzYW5kcm8gUnViaW5pIGEgw6ljcml0wqA6
DQo+IFtWb3VzIG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIHJ1YmluaUBn
bnVkZC5jb20uIEQ/Y291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgPyBodHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gVGhhbmtzIGRh
dmlkZSBmb3IgdGhlIGdvb2QgZXhwbGFuYXRpb24NCj4gKGFuZCB0aGUgbGluayB0aGUgdGhlIG9s
ZCBlbWFpbCBJIGZvcmdvdCBhYm91dCkNCj4gDQo+PiB0bDtkcjogc3RhMngxMSBzdXBwb3J0IGNh
biBiZSByZW1vdmVkLg0KPiANCj4gQ29uZmlybWVkLg0KPiANCj4gVGhlIHBvaW50IGhlcmUgaXMg
dGhhdCB3ZSB0YWxrZWQgd2l0aCB0aGUgdmVuZG9yLiBUaGV5IGFyZSBzdGlsbCB1c2luZw0KPiB0
aGUgZGV2aWNlICh3aXRoIHNvbWUgZXh0cmEgaW50ZXJuYWwgcGF0Y2hlcyksIGJ1dCBuZXcgZGV2
ZWxvcG1lbnQgYXQNCj4ga2VybmVsIGxldmVsIGlzIHN0b3BwZWQuDQo+IA0KPiBTaW5jZSB0aGUg
ZGV2aWNlIGlzIG5vdCBjdXJyZW50bHkgYXZhaWxhYmxlIHRvIHRoZSBnZW5lcmFsIHB1YmxpYywN
Cj4gaXQncyBvayB0byBzYXZlIHRoZSBtYWludGFpbmluZyBlZmZvcnRzLg0KPiANCj4gSSBjYW4g
c3VibWl0IHBhdGNoW2VzXSBuZXh0IHdlZWsgb3IgYWNrIHJlbW92YWwgaWYgc29tZWJvZHkgc3Vi
bWl0cw0KPiB0aGVtIGVhcmxpZXIuDQo+IA0KDQpJIGhhdmUgcmVzdXJlY3RlZCByZW1vdmFsIHBh
dGNoIGZyb20gRGF2aWRlIENpbWluYWdoaSANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
NjQyMzZjOTZmZjYyMGQ2NGFhNDZkMGZjM2RhYzE1OWE5OGM2NDcwOS4xMzc1ODY3MjkxLmdpdC5y
dWJpbmlAZ251ZGQuY29tLw0KDQpBbmQgSSB3aWxsIGFkZCBpdCBpbiBteSBzZXJpZXMgDQpodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtZ3Bpby9saXN0Lz9zZXJpZXM9
MzE1ODI2IA0KcHJpb3IgdG8gcGF0Y2ggNCBpbiBuZXh0IHJlLXNwaW4gKGxpa2VseSBpbiBhIGZl
dyBkYXlzKSBiZWNhdXNlIHBhdGNoIDQgDQppcyBvdGhlcndpc2UgcmVxdWlyaW5nIG1vZGlmaWNh
dGlvbiBvZiBncGlvLXN0YTJ4MTEuYw0KDQpUaGFua3MNCkNocmlzdG9waGU=
