Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F478F213
	for <lists+linux-arch@lfdr.de>; Thu, 31 Aug 2023 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbjHaRlm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Aug 2023 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjHaRll (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 31 Aug 2023 13:41:41 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2044.outbound.protection.outlook.com [40.107.12.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C677E70;
        Thu, 31 Aug 2023 10:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+UrPj+0dwq44aEG7myLoKHqz3JPhnlNpuTwWmUXMkV/WZgfHJcmybOscj64GpMaF18ZB2bPW/nIiBXUNqwG3uFEhOqR3u3MKmEhfqEu5yIv7veUC8k+NFZiO9kdTT7Zwp0zateiGZFmhM6Eh5vD/jKLFnr1oTWgJGbBo31O2FaL1hEmh5ldisS7VsTKvPJ5G/H9clpD5d7J1hE1/sZ/QWnwiAowGLj88COh9BRW+SXseIVziTN/qtFW67jnUX5JZq0pfkVy1ovry8vhH3IJCPqMUIC178kbZlgBbwQQUd4aPyNPi8BViBii5yDy3sykLcfhNq3gPnr9fxBUwTBTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAcc+iHqKIlf78lUb+5dvi1t52eAPHFEdUTfX0ST6Ec=;
 b=mc5Im3REIQQbfZAdjbUBzcM5y4wr+4YSjcLB9Z4WRrzmvwqcM8J3hFZyl0UXWdlpwcA1M4vv8+v8J2lhjAS78qJxOF3tpdw9Zbs/oTxblcQK6BVrtfZtKceWEz/n65Jsmek4+JbTtLDNA7G6yTYKFgHriOIsJzemMrvRJATMhuBBoQMwDIcU1zzuF0/lUSqqwadSFDtHVneNPZLcSSZxFt6zMEyP8rqWad+aqFlO213IQdhVYr0xca6tUvALrxWAttTQgUQxx2Znmgvu6iuMMKwPHOa3utP46qnlkPg9D0LO4b3FLUVuuW2mZyKkrx/7RYR/23dX/h+/iXdzSLJt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAcc+iHqKIlf78lUb+5dvi1t52eAPHFEdUTfX0ST6Ec=;
 b=LojPjIqI0gQIthRZlYkwk4+gmCditWomo2/HTeadRJRQfMVXhlUsF/JeWa5309nnssC0j+MMFUs/FiW4Hejus8VQ9sUAb+2clSWxuDyRJ+LGRBRXWHAym9z3CTeV/efw/bdE4H7LzCurfYUoy2BqJIFcBLTGUwmAi6r4uB/j57j5TeP1hEEf3g5q/1FGcAIhjOtRnYtyDWb+5rEDVmosdjmxwFCOJYIDG98roktoCqEtB+YvqZv0U1x5D9UgbRW08wWekQqefLDPSNQOw3UzYFhPe+p9bFAjjEe3djOkIh70huTvjttOV+fhqhVs0oFkHC+Ypj9nrGjlwhixaQsCOA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1867.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 17:41:36 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 17:41:36 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Thomas Zimmermann <tzimmermann@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>
CC:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Framebuffer mmap on PowerPC
Thread-Topic: Framebuffer mmap on PowerPC
Thread-Index: AQHZ3BlEDkN2rOOk3UWNJ6HsYG/HmLAEq7sAgAAA2IA=
Date:   Thu, 31 Aug 2023 17:41:36 +0000
Message-ID: <2eb985ae-aa34-229d-0968-1eb0cd6d8689@csgroup.eu>
References: <5501ba80-bdb0-6344-16b0-0466a950f82c@suse.com>
 <aea5e33a-1251-3188-6222-719fe9358762@csgroup.eu>
In-Reply-To: <aea5e33a-1251-3188-6222-719fe9358762@csgroup.eu>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1867:EE_
x-ms-office365-filtering-correlation-id: eafc29c7-f448-4c96-9629-08dbaa49860a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKBe5yQzo0GyHkjn7LYoQ5ws8t2htRO+og/W2gj6EKnM6t0YXnWrSPSWopeyH/e5X+01VjEyQVjAMkf5iQPnZbu1KjcizqyrsiJsmqj4u0X9IC8Xy+U7c9y7Z8XuYZUItJSZAgKRPEbehfMpAvvkCs6lNekg/vOI0kkOhQ2QtDRUDJqyH7bwL6GaLLxbggywLSTfGt2ORrMhCQGwXmKfoDJHI6oyIstDf8/isb1km6Wj1x+bD3MiwSe+06hfY6XMfJxuNIoW2FHcn1rcTYTpFwscs52bat+ilEtl1YwKIPpGKRIJ4uawaKFMjHEq1yGLHhV10TDTS9ONSAxI6AG1XunN+zJumIqDkBOOmiPZ1EhTwUSVQ/uVO/IXArCUoBLgOr3ClgQiiwLgeNFtMEZ5kNB7ZWFofYyKSjNOt+IpkNvvcG5ouRu6wRXDkM/f5b4mY1geayBD6Dz266qQV2Sr2GDWfRY80MTEbpYLLT1DTSkJUMUwKSgqYaVTLCk0ydW5tv12VunC3tHHm2l7cKYdznpO5rfv4hl99cWG2wMpwAlxHoOeDRJ5hNNTgDj3wDt0bE3mD58zLokUezC0k/bD//1dfq5l1MRPSi8nIFwx/6lzPGDKPTr1fTBsVmnt38DHlJYjmx+YRSdzepTf39iIYfpDOcB7GAUK63mXDkHcJO8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(376002)(346002)(396003)(136003)(451199024)(1800799009)(186009)(44832011)(5660300002)(316002)(66446008)(36756003)(76116006)(110136005)(64756008)(91956017)(54906003)(2906002)(66946007)(66476007)(66556008)(8936002)(8676002)(31686004)(4326008)(41300700001)(6486002)(6506007)(6512007)(3480700007)(26005)(38070700005)(38100700002)(71200400001)(122000001)(478600001)(66574015)(966005)(2616005)(83380400001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEkzc0xNSXlQeEVyWlUzblpHVTdwWmxxUmNHWnB6K3BXSkVldG1DQk9Vald6?=
 =?utf-8?B?SnM1RjB5b0ZLWUJDS2RRSkJrbkxzaStJaXNLWXJzcWVURGVBa2ZES3NoYnFl?=
 =?utf-8?B?Zk9oaHVYRXgvSXNRZlp6QUtvbFNNOHJiRlpYK0ZkdUhGREE2NlNveGk0ZTdV?=
 =?utf-8?B?dkE4aUxSNzNSZ2hNMGhwRFJGUmMvOERkekJHOHFUVzFwcUh4UnBLMnNJRlB2?=
 =?utf-8?B?WW9uMnp5S0I4RXVSc3lJVG9ZbEpaVlNraXVMYmViNit2RGhielJwcWIxajRx?=
 =?utf-8?B?QjZCUUNhbU9kOEJhWHhzVWhlekJRN1JyTjcrVmszUVBKSTRqUFEvR3E0R3BE?=
 =?utf-8?B?MTk4ZXFPU0VsM1ZSWm5rWUpzcHg5VG1GeFJrY3JZUVpqT0VoQWVDc1B3cW9v?=
 =?utf-8?B?ME9MUGx5MU1qRi9MdlhoOTVSTnV6YmlkOWsxYVQxbFcrZ3R1MXFmR3c5RHpC?=
 =?utf-8?B?NWNlclZpQ3hPRVFMemF2QzQrYTM3cldQZ3NUQmVpdU1tSHVJT1JYZWtpd1pZ?=
 =?utf-8?B?VHZrbFlnNitSNkpjazVSRzZxOVF3Nmc0a0JNaER5WnM2dTVNVXlvZ092bG93?=
 =?utf-8?B?Z0dNMUl3M3hENTl0ckhMNGlWYk12QWg5TGdFTG43TzZkVnFrZmR4Z1ZmMGRX?=
 =?utf-8?B?cU4wUi9taVcxVVZGTlpLWEJ1MEtOQ0w4RDhPUFo1WU9uUUdUT2ROSnRNZmdV?=
 =?utf-8?B?bi9Pbzh2dVd5NGJlRzNzZCtvWWpKb0VnVUFwTjIwbFY1dmY2cWgzVkdYQS90?=
 =?utf-8?B?bkM5a2JlN2ZkaWdZcXZYeG9xM09vV1YxRllnWXFCZEdnL2FGdnJORUp2M1JO?=
 =?utf-8?B?emVTZ21uNTJQMTNaRlFjbmdlcXMxRi9mTVNPSC9BVW1kbVVCaVkwTzE3bDRN?=
 =?utf-8?B?dWR0RDNGTS9ibE83QkZDbmdlQnpuRHQ5RXhETmNrMmYxMy9SZnYreWUrTmpS?=
 =?utf-8?B?aFJHWUErR0xWYnVMcnpXbWpoZ0MzZmRMUEY3TWJ0OWxweUFYZDIzSFFXaEMz?=
 =?utf-8?B?S3FnTThJVXc1OGFxcnYzK3pqL3dURDFBeWpMMmRRS29aN0cvOVBGRi9mMlZu?=
 =?utf-8?B?bHVnUW5wajJwcS8xbnRibHNqUjcvTzFTNGNUUDNQWDMrbmtRdDRjeXpZOWlm?=
 =?utf-8?B?RElEelQwNHVlaUNFV2ptL0NLZmh4QWpXajFOTTVJR0lqYU9WcU1IOXJ0OUFs?=
 =?utf-8?B?Zi9DSTZvZzBwbWIyWFo1MW1wajVFS1QxSTJmRFB3bEdlSWRsVlp2alFGVmVJ?=
 =?utf-8?B?OXRyRkNuT05RcTFUQnd4VlM2RGVMdXhFVjBPTGpXYlJ0T0M0T3QzOFQrT2ZR?=
 =?utf-8?B?M0NVbmFHMFYvdUVvWGQ0REVoYUxwWmNLZnlsODJXaWQwbU1tMHdVZjZRZTls?=
 =?utf-8?B?bFBqcUZGblBuQlhNa0RtSGlma3E3ZHBqMTlack9yc1dlS1diemJiaENjc1E4?=
 =?utf-8?B?Y0xYeXhtcE9pZUltN1EyQ3QzbHI3VXgzcVZNc2dHMUp4c1Rwc2gyNjJWd3Nv?=
 =?utf-8?B?TStTZW1NS3pIcUdsUDRpUjJlYnNKMGdlOWpnZGRHNTVPTDl5Q2hGN2FWZU9r?=
 =?utf-8?B?VUZyRGZJWmtRQUlndExhUk9Cem84bE1NOWJUb1NRQ0RSVFdGK0k0eEsycVA0?=
 =?utf-8?B?eUQvQWc1RG9udXp6SU8vbFpTZzdpQ09YT0lIb2d4ckFoMktiaXRHSlNxRFBR?=
 =?utf-8?B?STFrdG8zNHRPMTlQdkZxc2F6YkhyS3l2a1ZtUHMvZGxzWW92bVZBTkpyc2R2?=
 =?utf-8?B?MDMvOFpIRWlWdEQrVVh4UFRybVRFUUFaZ0pGWjJEZFFocVRGclFiU1VPbVBx?=
 =?utf-8?B?cmVnSXVSaXF6MjBNMTF5WjQrZW1rUmw1anI4R1JONldxUVZNQ3VSUHBTZHJ6?=
 =?utf-8?B?YW9GdHFYelNZRy9YU3NFd0dGSWh1Z3BvdytNaHZncGNLclV0emdRN1laV1FS?=
 =?utf-8?B?aHAyQytrWHFYcmg4bkY0Mk1wU0ZuUWRQcVFaY3BxR25ZUnY0WDRZVFVWSzJJ?=
 =?utf-8?B?Z1ZwTFR0SmRKUVZmOUxRYVVlZTlJdUxIWGtoc3hJLzBwV3EwVm42eXFndzVP?=
 =?utf-8?B?MGRJdWlYTEU5VnhIeGd5Z0dsZmo5dWpNaGEvaE9JYWFlVloyUm4zNVFTZ293?=
 =?utf-8?B?THNTRHZKRkQ1Q25KR3JWcnNwNHEwZndtMnNwV2plQ0Z4N3ZrM1VMNDRwcXBl?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E536EE39E5D8744592D3659C22DD982C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eafc29c7-f448-4c96-9629-08dbaa49860a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 17:41:36.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4RsK2pMnmesS5lKmQSB1wd8Yj545JNiEJtLIXcjbol1T93FWm9Qj62PR0d7Bs8dPbelOv1/+JYH7FFkV6T8fbu97yB7WozLzOSjSZ2ZIFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1867
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDMxLzA4LzIwMjMgw6AgMTk6MzgsIENocmlzdG9waGUgTGVyb3kgYSDDqWNyaXTCoDoN
Cj4gDQo+IA0KPiBMZSAzMS8wOC8yMDIzIMOgIDE2OjQxLCBUaG9tYXMgWmltbWVybWFubiBhIMOp
Y3JpdMKgOg0KPj4gSGksDQo+Pg0KPj4gdGhlcmUncyBhIHBlci1hcmNoaXRlY3R1cmUgZnVuY3Rp
b24gY2FsbGVkIGZiX3BncHJvdGVjdCgpIHRoYXQgc2V0cyANCj4+IFZNQSdzIHZtX3BhZ2VfcHJv
dCBmb3IgbW1hcGVkIGZyYW1lYnVmZmVycy4gTW9zdCBhcmNoaXRlY3R1cmVzIHVzZSBhIA0KPj4g
c2ltcGxlIGltcGxlbWVudGF0aW9uIGJhc2VkIG9uIHBncHJvdF93cml0ZWNvbWluZSgpIFsxXSBv
ciANCj4+IHBncHJvdF9ub25jYWNoZWQoKS4gWzJdDQo+Pg0KPj4gT24gUFBDIHRoaXMgZnVuY3Rp
b24gdXNlcyBwaHlzX21lbV9hY2Nlc3NfcHJvdCgpIGFuZCB0aGVyZWZvcmUgDQo+PiByZXF1aXJl
cyB0aGUgbW1hcCBjYWxsJ3MgZmlsZSBzdHJ1Y3QuIFszXSBSZW1vdmluZyB0aGUgZmlsZSBhcmd1
bWVudCANCj4+IHdvdWxkIGhlbHAgd2l0aCBzaW1wbGlmeWluZyB0aGUgY2FsbGVyIG9mIGZiX3Bn
cHJvdGVjdCgpLiBbNF0NCj4+DQo+PiBXaHkgaXMgdGhlIGZpbGUgZXZlbiByZXF1aXJlZCBvbiBQ
UEM/DQo+Pg0KPj4gSXMgaXQgcG9zc2libGUgdG8gcmVwbGFjZSBwaHlzX21lbV9hY2Nlc3NfcHJv
dCgpIHdpdGggc29tZXRoaW5nIA0KPj4gc2ltcGxlciB0aGF0IGRvZXMgbm90IHVzZSB0aGUgZmls
ZSBzdHJ1Y3Q/DQo+IA0KPiBMb29rcyBsaWtlIHBoeXNfbWVtX2FjY2Vzc19wcm90KCkgZGVmYXVs
dHMgdG8gY2FsbGluZyBwZ3Byb3Rfbm9uY2FjaGVkKCkgDQo+IHNlZSANCj4gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNS9zb3VyY2UvYXJjaC9wb3dlcnBjL21tL21lbS5jI0wz
NyANCj4gYnV0IGZvciBhIGZldyBwbGF0Zm9ybXMgdGhhdCdzIHN1cGVyc2VlZGVkIGJ5IA0KPiBw
Y2lfcGh5c19tZW1fYWNjZXNzX3Byb3QoKSwgc2VlIA0KPiBodHRwczovL2VsaXhpci5ib290bGlu
LmNvbS9saW51eC92Ni41L3NvdXJjZS9hcmNoL3Bvd2VycGMva2VybmVsL3BjaS1jb21tb24uYyNM
NTI0DQo+IA0KPiBIb3dldmVyLCBhcyBmYXIgYXMgSSBjYW4gc2VlIHBjaV9waHlzX21lbV9hY2Nl
c3NfcHJvdCgpIGRvZXNuJ3QgdXNlIGZpbGUgDQo+IHNvIHlvdSBjb3VsZCBsaWtlbHkgZHJvcCB0
aGF0IGFyZ3VtZW50IG9uIHBoeXNfbWVtX2FjY2Vzc19wcm90KCkgb24gDQo+IHBvd2VycGMuIEJ1
dCB3aGVuIEkgZm9yIGluc3RhbmNlIGxvb2sgYXQgYXJtLCBJIHNlZSB0aGF0IHRoZSBmaWxlIA0K
PiBhcmd1bWVudCBpcyB1c2VkLCBzZWUgDQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xp
bnV4L3Y2LjUvc291cmNlL2FyY2gvYXJtL21tL21tdS5jI0w3MTMNCj4gDQo+IFNvLCB0aGUgc2lt
cGxlc3QgaXMgbWF5YmUgdGhlIGZvbGxvd2luZywgYWxsdGhvdWdoIHRoYXQncyBwcm9iYWJseSB3
b3J0aCANCj4gYSBjb21tZW50Og0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS9mYi5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2ZiLmgNCj4gaW5kZXggNWYx
YTJlNWY3NjU0Li44YjliODU2ZjQ3NmUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS9mYi5oDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9mYi5oDQo+IEBA
IC02LDEwICs2LDkgQEANCj4gDQo+ICDCoCNpbmNsdWRlIDxhc20vcGFnZS5oPg0KPiANCj4gLXN0
YXRpYyBpbmxpbmUgdm9pZCBmYl9wZ3Byb3RlY3Qoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCAN
Cj4gdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1bnNpZ25lZCBsb25nIG9mZikNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBmYl9wZ3Byb3RlY3Qo
c3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIA0KPiBsb25nIG9mZikNCj4gIMKg
ew0KPiAtwqDCoMKgIHZtYS0+dm1fcGFnZV9wcm90ID0gcGh5c19tZW1fYWNjZXNzX3Byb3QoZmls
ZSwgb2ZmID4+IFBBR0VfU0hJRlQsDQo+ICvCoMKgwqAgdm1hLT52bV9wYWdlX3Byb3QgPSBwaHlz
X21lbV9hY2Nlc3NfcHJvdChOVUxMLCBvZmYgPj4gUEFHRV9TSElGVCwNCj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZtYS0+dm1fZW5kIC0gdm1h
LT52bV9zdGFydCwNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHZtYS0+dm1fcGFnZV9wcm90KTsNCj4gIMKgfQ0KDQpBbmQgd2hpbGUgYXQgaXQs
IG1heWJlIGFsc28gcmVwbGFjZSBvZmYgPj4gUEFHRV9TSElGVCBieSBQSFlTX1BGTihvZmYpDQoN
CkNocmlzdG9waGUNCg0KPiANCj4gDQo+IENocmlzdG9waGUNCj4gDQo+IA0KPj4NCj4+IEJlc3Qg
cmVnYXJkcw0KPj4gVGhvbWFzDQo+Pg0KPj4NCj4+IFsxXSANCj4+IGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y2LjUvc291cmNlL2luY2x1ZGUvYXNtLWdlbmVyaWMvZmIuaCNMMTkN
Cj4+IFsyXSANCj4+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjUvc291cmNl
L2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9mYi5oI0wxMQ0KPj4gWzNdIA0KPj4gaHR0cHM6Ly9lbGl4
aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNS9zb3VyY2UvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNt
L2ZiLmgjTDEyDQo+PiBbNF0gDQo+PiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
Ni41L3NvdXJjZS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2NvcmUvZmJtZW0uYyNMMTI5OQ0KPj4NCj4+
DQo=
