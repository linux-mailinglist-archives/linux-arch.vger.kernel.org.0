Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507195BB6A8
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 08:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIQGb1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIQGb0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 02:31:26 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90083.outbound.protection.outlook.com [40.107.9.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4034E855;
        Fri, 16 Sep 2022 23:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVkfkS6rez5Ypb66hGFVnIjz0GaT00TT4Yu+moZrRt2CqTkUb95O38buNe4tIIe/aL70539EoVUBezqHgBpR6LwtCYjIyt19gp/uu1NbA64qSR2K0DP2ziw+bQNdfzd07YrFFy8+SU8QVQtpL0indczwUVy5uGWlMPo6QnLLy+MwQEJca30tY1MNHCNpuVLSLHc38qZlQdAy/yJLGfs5FZepyWAegeinA7kkllIPi9ENqXdcS5hrQOqg1SWHHHOuUlZZko+OY26L4+jeR5KNPbDFTP8wOcIoUeIrlUEuFH8sehNyh5+NpIpM8+XOqXOCjdEgJ4vkmOv9N4dSKcC+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bVHNjWVNnj/67BctOOsQOdcEuhDBnFiRmo/+pKZyWY=;
 b=MidUxRqYKB4gadZ+mZ8r81dJENImElfXn7vYa0d+SDOrUVEd4p0QfSu3IBgLJN+YaR8QWjk0jb0ZLhekJCgwwU1zLj92DOt08EKVRl3rRVguLHJjv77jk3Skc0xSBY92d0BGdnH3DOisAeP7fWRhT9EdJGG9dCc6zCfDoWVtQhgNaCDKHyxL6cQDAGOs46cHFM3D6jwN+uBghV9ejJNZ/lUeKBdzE8tdNiaWw4MfP+aEzIgE3RpDhWPAZ9h84Gc91nnQ5D0gaA4rBwCfTJnz2z0ytBAcUyF1nsjgfr08I9g5Hxi0U4E9Imvc3iTWrjR1zGUhdHhiXLMhPaA0gwbkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bVHNjWVNnj/67BctOOsQOdcEuhDBnFiRmo/+pKZyWY=;
 b=Y6KAvRLjmKsGsuOqVuP9i7Jg1diWjSRnWPnJTFrWzxdVQHvkR0ysomChmCRHeeHAVxOEKTg8i8AqYFeo0HYESoHnSBbYi+N2a75D13QC3kdhBODPPe1vAKAdh6FJRh4zkJHMjdSFjkotlwd1f1XCrxYxX6soqRZZ5+wplUQjSCxVtnk7OpJBL1esN0tJ7UkVIgy26KHnjx/FT9RYokq4yKLgjK38YzXWe5yL5EMRw8iA7rIaeJ8E9CgwHC5PzlAA43+T8bZ2QKAYT218irMJx3YB2NBgonSuqttAOpuPB2Um72Oxo4oReVAdy4VS5hAQrSVAao14dX6nOpyc0AROGQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2343.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Sat, 17 Sep
 2022 06:31:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5632.017; Sat, 17 Sep 2022
 06:31:20 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Omar Sandoval <osandov@osandov.com>,
        "H.J. Lu" <hjl.tools@gmail.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] Discard .note.gnu.property sections in generic NOTES
Thread-Topic: [PATCH 2/2] Discard .note.gnu.property sections in generic NOTES
Thread-Index: AQHYyj7A0SiqvL0/MUOS6WM4C4lvfq3jKbQA
Date:   Sat, 17 Sep 2022 06:31:20 +0000
Message-ID: <e15de60c-8133-3d93-eb1c-c6b1b5389887@csgroup.eu>
References: <20200428132105.170886-1-hjl.tools@gmail.com>
 <20200428132105.170886-2-hjl.tools@gmail.com>
 <YyTRM3/9Mm+b+M8N@relinquished.localdomain>
In-Reply-To: <YyTRM3/9Mm+b+M8N@relinquished.localdomain>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2343:EE_
x-ms-office365-filtering-correlation-id: 793c524a-2365-4dc4-c6ec-08da98763c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ouzgcsik7X6jSTRUvRxfjx0j0/4zbU0OtvnocLh5HY+cW2uXJrq8T99qZ4Vp0czabXOWcmnusWh/rQh4i5c7gkJS2fsFQBgoDF5yw1hyINFm+YeVWZP1OQRhREF0TbsesRN+IW29oOVvVM0S9YlMSDlPlHT6hN6Y/TEwzz2sdrQU+ZzPQDQwngky0z6ttCY8xv/GKnnLE4js4MEsfbZMgVD/lzftXEqoGBDkkKybkDHwuxDS9baGG24aHt23rI3OavtQEnBqXITgEiBHT0MMdaXk0kjoJs2We6Xr6CD+/TVKReOyBUqBSTXicPqkz7DZeIL0arrgM1/a355MaOANMWSiyS+1cX9OLLnlZ2uOOSahShWlbjmUJNJufsvV4+8ng9B2Xy2VjCHdi05XvPvnPhMGzb6OusVn8IolrSN8leb2qyGg67hM81pHyumo3wcYGwU+AaOJck5VdpYOEf2wZRDgtHJ9KP/p3JN0EApz3SJViNe2FmXdDfqFAx7TNKqTu6WZ/NdQjas2iRWs8Ued0oBy7r3hC+rGew7VYBr7oiL203gjuWykX9cx06dXaQ1NjmcSHH2/BS9A4FDR/6QhweW9R3ASiF0+lHNAJL5FnxXDXglYDWwRAGWPGcY9kNQxENCSobSwiKFZ3iy2TrH6C29k12bXiyqgWeInIpe4UDttVhcrRAbFaboKTIo7q1LGySVXiSfGadn0EjIaYAqF3EHbd8on114zA0JghySi8YcMa5YEMkrsx98FHXNjlsZAC0g3zoBFc8DlEWluUNsBU/8EV0d265ZYbTOjzyf63HzcytyPffBEfKx7Y45NTHC/fC5mS7isz4eqOBMI6oTCspJcGfqOcfGCSvQ7QeAscF1Wiu8XZRAgz1p1V8C3oRHU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(71200400001)(54906003)(31686004)(6486002)(110136005)(316002)(91956017)(64756008)(76116006)(4326008)(38070700005)(66476007)(66446008)(478600001)(2906002)(86362001)(66556008)(186003)(2616005)(44832011)(66574015)(31696002)(66946007)(966005)(83380400001)(8676002)(38100700002)(41300700001)(6506007)(36756003)(5660300002)(7416002)(8936002)(122000001)(26005)(6512007)(41533002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TndiaDF4OC9ONzQ2dklOQWlhMUNDMFIzWjVQS0J3WXhJdFhXSVZtMTVydHRC?=
 =?utf-8?B?NGZUdUYrZUpDT3RTcUZFQ0ozRGZzMDVUVnRGaXZBaTRHUTFwOGdGNlNjQTZZ?=
 =?utf-8?B?OGZIUzYrSFdWSWNSNkplWWVSVmlIcHloSDh6K0JaT0JVNytZb0pQRHNveDRx?=
 =?utf-8?B?YkJFTUVKTkNBaUg4bXZ3Mk05TVNnZEZobHZVdHl1SXUzV2FycnhvTTdEK3RY?=
 =?utf-8?B?VzQ1bHc3cmlodVR1eExTZFdQSThYeG1XdTlBUUhEVXdYTVgybWhYRGoxYzhY?=
 =?utf-8?B?SjdmYTFvZEFFNTRjcWJRcWsvNGhzVVczdWhJUTY5VVFUdGdIWFRRVUJXL0x1?=
 =?utf-8?B?WjZMa3B3dGM4YnFjTW1iK3hndTc0S2hzVEt0L05lUXR5clNTQ285cGdIai9M?=
 =?utf-8?B?YlJkSmdUdGZrVVBVd0JkMWcvRTJaWkM1aFlFYys0OEEwaW9hSTI3RE4zMWxp?=
 =?utf-8?B?TFlzbERNcFdmU1ltOUNDWjhmTEZGOGlyS0M3akdKdCtnWTc4Sm51NHc5NGhu?=
 =?utf-8?B?eE0ydHU1YTg3akJsejhTZmorV1FMUGZveEVpc3h3bVYxbzZQekozZFlRYWNm?=
 =?utf-8?B?YkU4NlhHbTlDclVqTXdhTXVnS1I2VFpPd2FFNWcyK1k3SXFxb0pHbzRLWU5t?=
 =?utf-8?B?czZmL3JqU0lqaEthSHp5WUxzbVUreGFsWEphM0FkcWQ1UG9ZWUdvdi9BV21I?=
 =?utf-8?B?MFlxTUpudzNhYXBFdEJ1bFZjSW9HSkRvOC9xNmo0VS9KbDN1UzU5eGRGbnl2?=
 =?utf-8?B?NjkxM29KZUpxeXhLYVF2aHQ3alA0Uks3dEFxdlk0eGFKdmQxbnpySWgvbWsw?=
 =?utf-8?B?cGdPV25LZEc5MTZlb0lxZUwvTTRSZ1ZsZFFVc1lzeUNIbzZvTWpzY3E0THF4?=
 =?utf-8?B?YkNXaFVjdWtscWg0ZzBES2IvTmhJcHhOdXpmaGs1NEU3S1NtK1pjMjRXYWVJ?=
 =?utf-8?B?MmQ5Q3FaSFg3UUhSNjZIRDhUYzRyclBwQkVpZUJqZ2NWZnEyaEY3KzBTckJq?=
 =?utf-8?B?bnN5b3dBTWU5U01GTHVBYWNPN0pnNDBjSEhFUXBuQ2RGb09jdnM1MzM1ek9O?=
 =?utf-8?B?bmFSUDB5MnRDWE9kd0tqMUY5VERkNWJYRmZmSlJMU1cvbG5JOW5kSkJ6ZXNR?=
 =?utf-8?B?VmhWZitrY0ZOVTVNbUMrT2FBdFEycnRTczRtS1pFUVVPTzR2WTg1YzAzVjhh?=
 =?utf-8?B?THZDMHJJUGxHUEx5aVZyMGtucjVYZ25hRWdKUGZCdkFKemVkbXRVQmErZXZ4?=
 =?utf-8?B?SEdUREQ0cFViektucTBxNGZuVm1pUWh6WGs3NVk5YTczU3MrME95V2MyaEt5?=
 =?utf-8?B?czVXalVCTXFjZnB0Tk92Z002OW1MQ0I5dTRWcVVyZUp6eld1aTg2ZWhYZFdN?=
 =?utf-8?B?NnZ3Y0RKYll4WEIrdk4xVDBqS0xNazlLYjUxVUxkL0ZGUE5MYjJRNHBPa2xj?=
 =?utf-8?B?dDg3WjdWQ052YjVLZmFDa3JISWlKRWl4R0ZEL1RsdXhXb3VkVWw0NUt5M0xQ?=
 =?utf-8?B?aForR0k5YzlLejE4a2RSZ3Y1YjY0N1NsdHlvU253RldVVkdYa1FwNk5lcytx?=
 =?utf-8?B?SjhFYW1HcGx0T0YxWDlBbDFVaU83YVBZZGhtWGplbjVMZ09GZzIwaGR0N2Rq?=
 =?utf-8?B?YVR1UTlndW9Gd3c1SE9EV0xhU0d1Tys0Y01rYUhPNUd3ZDJESHlMTzQyckN4?=
 =?utf-8?B?TTN4Q3ZHa3JMOGsrbTVVS3lFVVErWDcyeGlQSml2MktQUngyRFpreldkSVI3?=
 =?utf-8?B?SjdhMlZBdjZ6U2FYREJjN2JDWWZuZ0d4U3YxdG1IS0R2cW8rTlNJckNtbHV5?=
 =?utf-8?B?MDRnKzFyNm1vRTRpSXpidy9XK2RCR200bXBOTGVDZ09TWWl0WGlXTDY0dmVm?=
 =?utf-8?B?bnJxRUt5MVk4ZFp0bkxoT3V2cE02cTRvTUEwYStqSERKcUJrZWJpZDErYXhq?=
 =?utf-8?B?L0JKT212b0UramR5QUNnUWpMaktWd1hGUU5QMTBsYk15RTQxY3ljT2tHZlJa?=
 =?utf-8?B?ZWt2ekthWktybWphenF0cTNneDRWRnV0bXphSlNJM3FwaCs5bG1NUWErQktF?=
 =?utf-8?B?YldrMjFKT3lPMlZvcFIvMmpDcENoRVdXWVNiOEVBWlVWay8xekNnNVU0b0Za?=
 =?utf-8?B?Ris3OVdMZHNuM1Rma1BZRllnTmtlQzBGMEpqMzFWbVlUaUdIWTh0TWh5U0dE?=
 =?utf-8?Q?m/SPajp8asIVc36cxf8C5As=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82B006B208500C498E1140F21616673D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 793c524a-2365-4dc4-c6ec-08da98763c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2022 06:31:20.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GATYJ32LyaiZEaWf7jRqmbGGpBG09AIYrma/xv+laK48EVxXT+7NK33vlE49Fw2pkFthSc/McDuZrcqbMFYc9f143Fm+SHJ8dDQYc/YpOf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2343
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE2LzA5LzIwMjIgw6AgMjE6NDAsIE9tYXIgU2FuZG92YWwgYSDDqWNyaXTCoDoNCj4g
W1ZvdXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgb3NhbmRvdkBvc2Fu
ZG92LmNvbS4gRD9jb3V2cmV6IHBvdXJxdW9pIGNlY2kgZXN0IGltcG9ydGFudCA/IGh0dHBzOi8v
YWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiBPbiBUdWUsIEFw
ciAyOCwgMjAyMCBhdCAwNjoyMTowNUFNIC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPj4gV2l0aCB0
aGUgY29tbWFuZC1saW5lIG9wdGlvbiwgLW14ODYtdXNlZC1ub3RlPXllcywgdGhlIHg4NiBhc3Nl
bWJsZXINCj4+IGluIGJpbnV0aWxzIDIuMzIgYW5kIGFib3ZlIGdlbmVyYXRlcyBhIHByb2dyYW0g
cHJvcGVydHkgbm90ZSBpbiBhIG5vdGUNCj4+IHNlY3Rpb24sIC5ub3RlLmdudS5wcm9wZXJ0eSwg
dG8gZW5jb2RlIHVzZWQgeDg2IElTQXMgYW5kIGZlYXR1cmVzLiAgQnV0DQo+PiBrZXJuZWwgbGlu
a2VyIHNjcmlwdCBvbmx5IGNvbnRhaW5zIGEgc2luZ2xlIE5PVEUgc2VnbWVudDoNCj4+DQo+PiBQ
SERSUyB7DQo+PiAgIHRleHQgUFRfTE9BRCBGTEFHUyg1KTsNCj4+ICAgZGF0YSBQVF9MT0FEIEZM
QUdTKDYpOw0KPj4gICBwZXJjcHUgUFRfTE9BRCBGTEFHUyg2KTsNCj4+ICAgaW5pdCBQVF9MT0FE
IEZMQUdTKDcpOw0KPj4gICBub3RlIFBUX05PVEUgRkxBR1MoMCk7DQo+PiB9DQo+PiBTRUNUSU9O
Uw0KPj4gew0KPj4gLi4uDQo+PiAgIC5ub3RlcyA6IEFUKEFERFIoLm5vdGVzKSAtIDB4ZmZmZmZm
ZmY4MDAwMDAwMCkgeyBfX3N0YXJ0X25vdGVzID0gLjsgS0VFUCgqKC5ub3QNCj4+IGUuKikpIF9f
c3RvcF9ub3RlcyA9IC47IH0gOnRleHQgOm5vdGUNCj4+IC4uLg0KPj4gfQ0KPj4NCj4+IFRoZSBO
T1RFIHNlZ21lbnQgZ2VuZXJhdGVkIGJ5IGtlcm5lbCBsaW5rZXIgc2NyaXB0IGlzIGFsaWduZWQg
dG8gNCBieXRlcy4NCj4+IEJ1dCAubm90ZS5nbnUucHJvcGVydHkgc2VjdGlvbiBtdXN0IGJlIGFs
aWduZWQgdG8gOCBieXRlcyBvbiB4ODYtNjQgYW5kDQo+PiB3ZSBnZXQNCj4+DQo+PiBbaGpsQGdu
dS1za3gtMSBsaW51eF0kIHJlYWRlbGYgLW4gdm1saW51eA0KPj4NCj4+IERpc3BsYXlpbmcgbm90
ZXMgZm91bmQgaW46IC5ub3Rlcw0KPj4gICAgT3duZXIgICAgICAgICAgICAgICAgRGF0YSBzaXpl
IERlc2NyaXB0aW9uDQo+PiAgICBYZW4gICAgICAgICAgICAgICAgICAweDAwMDAwMDA2IFVua25v
d24gbm90ZSB0eXBlOiAoMHgwMDAwMDAwNikNCj4+ICAgICBkZXNjcmlwdGlvbiBkYXRhOiA2YyA2
OSA2ZSA3NSA3OCAwMA0KPj4gICAgWGVuICAgICAgICAgICAgICAgICAgMHgwMDAwMDAwNCBVbmtu
b3duIG5vdGUgdHlwZTogKDB4MDAwMDAwMDcpDQo+PiAgICAgZGVzY3JpcHRpb24gZGF0YTogMzIg
MmUgMzYgMDANCj4+ICAgIHhlbi0zLjAgICAgICAgICAgICAgIDB4MDAwMDAwMDUgVW5rbm93biBu
b3RlIHR5cGU6ICgweDAwNmU2NTU4KQ0KPj4gICAgIGRlc2NyaXB0aW9uIGRhdGE6IDA4IDAwIDAw
IDAwIDAzDQo+PiByZWFkZWxmOiBXYXJuaW5nOiBub3RlIHdpdGggaW52YWxpZCBuYW1lc3ogYW5k
L29yIGRlc2NzeiBmb3VuZCBhdCBvZmZzZXQgMHg1MA0KPj4gcmVhZGVsZjogV2FybmluZzogIHR5
cGU6IDB4ZmZmZmZmZmYsIG5hbWVzaXplOiAweDAwNmU2NTU4LCBkZXNjc2l6ZToNCj4+IDB4ODAw
MDAwMDAsIGFsaWdubWVudDogOA0KPj4gW2hqbEBnbnUtc2t4LTEgbGludXhdJA0KPj4NCj4+IFNp
bmNlIG5vdGUuZ251LnByb3BlcnR5IHNlY3Rpb24gaW4ga2VybmVsIGltYWdlIGlzIG5ldmVyIHVz
ZWQsIHRoaXMgcGF0Y2gNCj4+IGRpc2NhcmRzIC5ub3RlLmdudS5wcm9wZXJ0eSBzZWN0aW9ucyBp
biBrZXJuZWwgbGlua2VyIHNjcmlwdCBieSBhZGRpbmcNCj4+DQo+PiAvRElTQ0FSRC8gOiB7DQo+
PiAgICAqKC5ub3RlLmdudS5wcm9wZXJ0eSkNCj4+IH0NCj4+DQo+PiBiZWZvcmUga2VybmVsIE5P
VEUgc2VnbWVudCBpbiBnZW5lcmljIE5PVEVTLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEguSi4g
THUgPGhqbC50b29sc0BnbWFpbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVz
Y29va0BjaHJvbWl1bS5vcmc+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9hc20tZ2VuZXJpYy92bWxp
bnV4Lmxkcy5oIHwgNyArKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy92bWxpbnV4Lmxkcy5o
IGIvaW5jbHVkZS9hc20tZ2VuZXJpYy92bWxpbnV4Lmxkcy5oDQo+PiBpbmRleCA3MWUzODdhNWZl
OTAuLjk1Y2Q2Nzg0MjhmNCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1s
aW51eC5sZHMuaA0KPj4gKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy92bWxpbnV4Lmxkcy5oDQo+
PiBAQCAtODMzLDcgKzgzMywxNCBAQA0KPj4gICAjZGVmaW5lIFRSQUNFREFUQQ0KPj4gICAjZW5k
aWYNCj4+DQo+PiArLyoNCj4+ICsgKiBEaXNjYXJkIC5ub3RlLmdudS5wcm9wZXJ0eSBzZWN0aW9u
cyB3aGljaCBhcmUgdW51c2VkIGFuZCBoYXZlDQo+PiArICogZGlmZmVyZW50IGFsaWdubWVudCBy
ZXF1aXJlbWVudCBmcm9tIGtlcm5lbCBub3RlIHNlY3Rpb25zLg0KPj4gKyAqLw0KPj4gICAjZGVm
aW5lIE5PVEVTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCj4+ICsgICAgIC9ESVNDQVJELyA6IHsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+PiArICAgICAgICAgICAgICoo
Lm5vdGUuZ251LnByb3BlcnR5KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
Pj4gKyAgICAgfSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwNCj4+ICAgICAgICAubm90ZXMgOiBBVChBRERSKC5ub3RlcykgLSBM
T0FEX09GRlNFVCkgeyAgICAgICAgICAgICAgICAgICAgICAgXA0KPj4gICAgICAgICAgICAgICAg
X19zdGFydF9ub3RlcyA9IC47ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBc
DQo+PiAgICAgICAgICAgICAgICBLRUVQKCooLm5vdGUuKikpICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4+IC0tDQo+PiAyLjI1LjQNCj4+DQo+IA0KPiBIaSwgSC5K
LiwNCj4gDQo+IEkgcmVjZW50bHkgcmFuIGludG8gdGhpcyBzYW1lIC5ub3RlcyBjb3JydXB0aW9u
IHdoZW4gYnVpbGRpbmcga2VybmVscyBvbg0KPiBBcmNoIExpbnV4Lg0KPiANCj4gV2hhdCBlbmRl
ZCB1cCBoYXBwZW5pbmcgdG8gdGhpcyBwYXRjaD8gSXQgZG9lc24ndCBhcHBlYXIgdG8gaGF2ZSBi
ZWVuDQo+IG1lcmdlZCwgYW5kIEkgY291bGRuJ3QgZmluZCBhbnkgZnVydGhlciBkaXNjdXNzaW9u
IGFib3V0IGl0LiBJJ20gaGFwcHkNCj4gdG8gcmVzZW5kIGl0IGZvciB5b3UgaWYgeW91IG5lZWQg
YSBoYW5kLg0KDQpBcyBmYXIgYXMgSSBjYW4gc2VlLCBBUk02NCBpcyBkb2luZyBzb21ldGhpbmcg
d2l0aCB0aGF0IHNlY3Rpb24sIHNlZSANCmFyY2gvYXJtNjQvaW5jbHVkZS9hc20vYXNzZW1ibGVy
LmgNCg0KSW5zdGVhZCBvZiBkaXNjYXJkaW5nIHRoYXQgc2VjdGlvbiwgd291bGQgaXQgYmUgZW5v
dWdoIHRvIGZvcmNlIA0KYWxpZ25tZW50IG9mIC5ub3RlcyB0byA4IGJ5dGVzID8NCg0KVGhhbmtz
DQpDaHJpc3RvcGhlDQoNCg0KPiANCj4gVGhhbmtzLA0KPiBPbWFy
