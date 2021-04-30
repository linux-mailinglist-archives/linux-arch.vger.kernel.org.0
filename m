Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93A03703A8
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 00:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhD3Wpk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 18:45:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42380 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230508AbhD3Wpk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Apr 2021 18:45:40 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 776E7C0440;
        Fri, 30 Apr 2021 22:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619822691; bh=Y8VDyKsjeDj9XERsDeiRgYxFc/vaJvrj9Rnxa5oXY8g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Kl2dUZI1LcdgkFS8vjw3Bxgo3DgVK1dRZbzgC3/hsfbfO3Q87+m+MVmlF/rzyLVPg
         H9sHLQZpB23wfsk7M5oZMZoY7sxYGtBM827rKYAAjS1dca2Kg4tOTPETEogYQro2GM
         fh/4Y0u5KOZHeKeOxzM15Z2AVQjZDQgqIhY9jztROUQSC1PPmXOfdz6nJop3E6hs1i
         Yrj+IpOGMC70XsWCpDa2Ul+EWuy9GIFFbc3hFyGieNSs0udz3s/8GAdeR1/ilobged
         /ie+j6ujD2du3vLa2ox4/Y7FKa2chmcDkKFF1qj1AOWQplWpBJvQJaIaiNw3ONoCHH
         pgrvohpKL+aUg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 57DE8A0071;
        Fri, 30 Apr 2021 22:44:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9AFF7800C5;
        Fri, 30 Apr 2021 22:44:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="tPJzlxut";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLHJ9s7hcVk7yK2BLh5A+9o7YZWWf5TTMOd8yh/SkQRbOvAlnSuQGriA/NqA0Q0ONMnIjkIlpvEDFlq3My2kqJ7GcywWS0vqvve248kzL1/Z2WY46quZLu4XQ6Tkt7dduNr8w5Gkmkw+O2E6YD+15M9eMjpLbTXFNMTmz8N/LP84iw5j7t/Rc10ghn8AHbDBFVzk5zDujzLV6ioPV2HrdzNVo9Ndhq+/QPLfT2jUkfiYN74G2GWIoub5yX/pgi+qx9uuJKR6J5WNMuX6sjS4NlL6mF/PYAE7LSEBxY1k5sCxp3bfvwxdS3bMqXZ1JQ1xMW/hPpTdbeEdJkOdO+K76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8VDyKsjeDj9XERsDeiRgYxFc/vaJvrj9Rnxa5oXY8g=;
 b=a0MjYvHrxdy5pskc2w/1XBI15iy1ButjuvF+XBdssDxJuE9lXYTKpr9sOy+GLqYKbEwqQfWLeCUEfg0Gwni3ZMKhhQi0NgiTZ9dISI24LgwkGKjwKGuqXlhg1NHg0EqPLS/79gl+rGEgOlcu9uspYStnhl7mtqZf/fsyAUTiStxmeMqPK1krmwklWKxsRJf6MCo7lKwH5uaHDCh22N64uRhqyJJVVZxbaZDUBmuY/7Wju99sIrmODz/WASXLdYpf5jB675e45cywCYSUOGRCUsDVIp6ufCOFs7jDlnXtReJBu1erCkwCtCqrnqJNLPnbTaDFMJH2mWL8DByOg95ANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8VDyKsjeDj9XERsDeiRgYxFc/vaJvrj9Rnxa5oXY8g=;
 b=tPJzlxutUyTpPKyWrlA0OrZ46eMI1oAOtD0hn6WECV8BtF8GtTVlqYn3Dz9pcQlH5NPs4rsFiMXWpPZ65eRMNCp3Kl7y/AczzMbzr2legYlY1gmqrQlZgpHSjJrL9Zo8lKmC06qaNcHwJAZC0FZ77cftUgTHhzKxfeyMMR1IX/E=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3478.namprd12.prod.outlook.com (2603:10b6:a03:ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 22:44:42 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 22:44:42 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jann Horn <jannh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Heads up: gcc miscompiling initramfs zlib decompression code at
 -O3
Thread-Topic: Heads up: gcc miscompiling initramfs zlib decompression code at
 -O3
Thread-Index: AQHXPgHd1RlrjZ3rIE6wtN03PsVzsqrNniEAgAAKq4A=
Date:   Fri, 30 Apr 2021 22:44:42 +0000
Message-ID: <9538bb7e-a600-2211-6b4d-561b99f1deca@synopsys.com>
References: <75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com>
 <CAHk-=wjJEgjCYzHZFPxTs01p7FMEHKKqXyqwRVBk6KnvHB1qVA@mail.gmail.com>
In-Reply-To: <CAHk-=wjJEgjCYzHZFPxTs01p7FMEHKKqXyqwRVBk6KnvHB1qVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e06e9e3-09b8-4bda-1aa1-08d90c298b8e
x-ms-traffictypediagnostic: BYAPR12MB3478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB347856D5CCA12D658C7563ACB65E9@BYAPR12MB3478.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U4QdqB0RJb3jSGED2ThW9nBh6Iqc6ocSYTuBFEFJfmBGphsXsPZvd5c91VMb8Ib+uxPiiO54UtenpwpmkNvgE2tWwFYXUGwqHafu7XClit5tFE4mbILqcclyNEaVjMijgbeKX9b6APcUkZIbjXNtHyUWDHnMxCEBfiukq85SiOkY7GhTzUrgm96dU+i7mzrlb2hsZOQPwoyDRSpPpTAgOHJb7GqlMUkmQZdadLEH5nyRjXBE/VzuGMvhmkktYu3aze4js8F8n/atEQrjoM+rjX7y34X4ohBSANUfSc5UyE5IRSMEm2vlhBE9U4kwFwqWTBriSk/ZSUTmbQxRh4wvv4p63wH9MuK7h9m5SOsQXmLzGrT07v8iGejIIYdMG+dWiibn4tpks/VdIeLYRxCzdSkID1Z6XrNgck+9Y4ivkafI76BX3OGwu9smuzRLImE/cYtvMBavh1/wLmVspG3wbTalVD67JT4kIFOQfwe30KXiXvLBYwrD73glASprYoQ+BnF43xRCJOlU7uZ6MR+Pcq1db52EUZ59jKY4p0meiXmVBdEDvt1s5YxvutZMxnhZPPvJXCV7uBIEJtDZff10+40dMVIB8jYAQrX8sZeGK3byv5X79bcUcSD0VQt72DBsUwZ0cIXrnni8OQ9N6shga9kJ4p34/7Pmm6PaUWBpjWR6HGqEF2EfFvdA6e7U0ZBK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39850400004)(396003)(136003)(26005)(66946007)(76116006)(54906003)(86362001)(31686004)(66476007)(64756008)(66446008)(66556008)(110136005)(6512007)(186003)(2616005)(31696002)(53546011)(5660300002)(83380400001)(38100700002)(8936002)(71200400001)(8676002)(6506007)(6486002)(2906002)(36756003)(122000001)(4326008)(316002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MjM3Z0Nac0orNFdPTmhjWm9kRlhMN1VkMW1IZ2IrTHV4ZHNLdVk2RCtrbXcx?=
 =?utf-8?B?VTZuVlpIUE9uQkZMbUZpNHVHako2bkY3YVk0L00rSkRIMmt4L1BIZkRBNkRB?=
 =?utf-8?B?dEtNTndvbVY4Q1dNSEZ3UldyUTUxenBVM2NiWGFwMHBtd1cydnFKYXdsZzlw?=
 =?utf-8?B?RXY4NER1NlNpK1pKVklHb2JZZ2k5Y0N4ZHlZZFBZLy9GY3RHK3Uxc2l0U3RC?=
 =?utf-8?B?SXNNZVBiZzJ4cG9YRHlOaGN1dVpKdjZPMS9hMnZJdm9sczkvS255MG1VWlJ2?=
 =?utf-8?B?WnNyYWd0TVZRbEJnSTVSTnRtREZtVGFQNElCMWh1cmVKTFZKV2xpNWFDZWxT?=
 =?utf-8?B?UFhXVUVDZk0wL0lkYUVCYVZtYVpjcUlXRDh4dDA0b2krZmV3SjNFelQ0UFFU?=
 =?utf-8?B?WmRKZjVCQ1BhMkpPVkVVK0N1QlpMcW9MNjRlMklFNHN2MUswRDJ2ancxMnJl?=
 =?utf-8?B?SmM1ZDJuaG0yT0VzQUUvY2x5dng5eExzUGlLVHZhbCtCbkxmaGEwSXBsWjNl?=
 =?utf-8?B?eE1LRWZES1h4RXB0c1RROFgzc0V3d0xlZ3B1ZFE5Y1lZcXBoVHF6TzFIaHVj?=
 =?utf-8?B?YU05d2lRbWhyRjB4MHRNTUNyV1NKcVdENVh6OGJ6RGR3RWVCZVlnRERlTGha?=
 =?utf-8?B?MWlSODRPeW1BdE1vVnFzQ2ZHbDBITDU5aU1nRHJRR1J1UlVzMk9hU2NYcnBG?=
 =?utf-8?B?RWxpZTBDMHJCOFN1YjNaOGRNZnZLSmJJcVV6NlgwaFdNRGYxbTlkZDhDajVi?=
 =?utf-8?B?SDNFL3MwZ1JyZG5lcFg1RWxXL1YvaHZkc2NGQW5oWkgxa2NkQ3NkT0dQSDBR?=
 =?utf-8?B?Q3l5SklHL2ZBWk1aelkwaWhwSWdEdzJrSVFnZWdaWjFsZWJlM0c1WEpCZ3Zz?=
 =?utf-8?B?b0NZK2IyT3lBMVVFRVYzUzN4eVNvaUQwaGV6Q2p1ZWVqUVFxR1hmTmx2OFRN?=
 =?utf-8?B?QzhXcHBQcVJUcTZsSStldWMxa2ZXR0c5SkFpczZPMS8zVm0rUXdTNHUvTU5m?=
 =?utf-8?B?Qm1KcHkrcjV2UnVjNDJaSlhPMUl1TUwrcDhyR1ZBY3cvaXBxTDlzb1ZxZWtz?=
 =?utf-8?B?UXVwaDhHaUNqZ2tuTTBhR2JIMVQzeEVNbnB3Ni8wNlBXVTFzVjhsVzlBS0s0?=
 =?utf-8?B?amM2WVZhZEVmaXAzRjFUTFZFRFN0b3FZbms1aHFmVmxFbkVjRnVnbUpMTXpG?=
 =?utf-8?B?bGNTZ3l1UW4vMHI5VHIyQWY2ajRLeUpCTnh5RVBoRWV4eHZzemZOM2tudG9s?=
 =?utf-8?B?T1NkR3dNWUpZTDVIMVVaWHdTZlczSlRnY0ZuN2cvYy9neURyKzRLQzdSeUMv?=
 =?utf-8?B?d0NiYnBjVkFGaDFaUjl4VU11NzhoSFN0Y3F0eWN2SWk5VDJIVm5OZyszbDB1?=
 =?utf-8?B?M3Vxa3FIV1ZFaEo2SVduazE1TmtWbE9rZEZrWjJneXo4NHljUmp1MUJrb0t1?=
 =?utf-8?B?VFBObnJjQWZreGxQSWtiRDhqMmZucVVrSVlQdWx6WFEvR1JGczVlYXIyTkFV?=
 =?utf-8?B?TUM1bURmQWZ1aTJ3dW9uS2k4WEdSSWdYeVVuR2dPRWc2ZXhoL1pDVHQyMFhH?=
 =?utf-8?B?NTFUR0JhVW5BZnhNSzNRVFB5M2xzUlBBQk9la3RHN244U0tWRUUyL3RBVk8w?=
 =?utf-8?B?Y3QvN0MxcGpBeWtYMVpLSytkb0htNHkvSXU1VTRmZ3RXVGdacXhXOGVVbktl?=
 =?utf-8?B?a25tUTFlZDNPdGl5OEI1cStaclQ1Q0REcUl2QXV2V2FKQ0hOamxuTHZHT2xk?=
 =?utf-8?Q?NN3xE56+FkdkoM9o4M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8D91946A06707409F400D7F9875E99D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e06e9e3-09b8-4bda-1aa1-08d90c298b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 22:44:42.3294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CNUokrDI6KsOY28NgMsnSDHP1+YMJiGbx7XlV4qg+6lFsy8B4R0vxIttEI60VUQMP+lt3x2031HMWbA86pk80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3478
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNC8zMC8yMSAzOjA2IFBNLCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gT24gRnJpLCBBcHIg
MzAsIDIwMjEgYXQgMTo0NiBQTSBWaW5lZXQgR3VwdGEgPFZpbmVldC5HdXB0YTFAc3lub3BzeXMu
Y29tPiB3cm90ZToNCj4+DQo+PiBJJ3ZlIGhpdCBhIG1haW5saW5lIGdjYyAxMC4yIChhbHNvIGdj
YyA5LjMpIGJ1ZyB3aGljaCB0cmlnZ2VycyBhdCAtTzMNCj4+IGNhdXNpbmcgd3JvbmcgY29kZWdl
bi4NCj4gDQo+IEknZCBiZSBtb3JlIHRoYW4gaGFwcHkgdG8ganVzdCBkaXNhYmxlIENDX09QVElN
SVpFX0ZPUl9QRVJGT1JNQU5DRV9PMyBlbnRpcmVseS4NCj4gDQo+IFRoZSBhZHZhbnRhZ2VzIGFy
ZSB2ZXJ5IHF1ZXN0aW9uYWJsZSAtIHdpdGggYSBsb3Qgb2YgdGhlIG9wdGltaXphdGlvbnMNCj4g
YXQgTzMgYmVpbmcgYWJvdXQgbG9vcHMsIHNvbWV0aGluZyB3aGljaCB0aGUga2VybmVsIHRvIGEg
Y2xvc2UNCj4gYXBwcm94aW1hdGlvbiBkb2Vzbid0IGhhdmUuDQo+IA0KPiBNb3N0IGtlcm5lbCBs
b29wcyBhcmUgImNvdW50IG9uIG9uZSBoYW5kIiBpdGVyYXRpb25zLCBhbmQgbG9vcA0KPiBvcHRp
bWl6YXRpb25zIGdlbmVyYWxseSBqdXN0IG1ha2UgdGhpbmdzIHdvcnNlLg0KPiANCj4gQW5kIHdl
J3ZlIGhhZCBwcm9ibGVtcyB3aXRoIC1PMyBiZWZvcmUsIGJlY2F1c2Ugbm90IG9ubHkgYXJlIHRo
ZQ0KPiBvcHRpbWl6YXRpb25zIGEgYml0IGVzb3RlcmljLCB0aGV5IGFyZSBvZnRlbiByZWxhdGl2
ZWx5IHVudGVzdGVkLiBJZg0KPiB5b3UgbG9vayBhcm91bmQgYXQgdmFyaW91cyBwcm9qZWN0cyAo
b3V0c2lkZSB0aGUga2VybmVsKSwgLU8yIGlzDQo+IGdlbmVyYWxseSB0aGUgImRlZmF1bHQiLg0K
DQpJIGFncmVlIHRoYXQgLU8yIGlzIGRlZmF1bHQsIGJ1dCB3ZSd2ZSBoYWQgLU8zIGRlZmF1bHQg
Zm9yIEFSQyBrZXJuZWwgDQpmb3JldmVyLCBzaW5jZSBsYXN0IGRlY2FkZSBzZXJpb3VzbHkuIFRo
ZSByZWFzb24gSSB0dXJuZWQgaXQgb24gYmFjayANCnRoZW4gd2FzIHVwc2lkZSBvZiAxMCUgcGVy
Zm9ybWFuY2UgaW1wcm92ZW1lbnQgb24gc2VsZWN0IExNQmVuY2ggbnVtYmVycyANCm9uIGhhcmR3
YXJlIGF0IHRoZSB0aW1lIHdoaWNoIGZvciBhIHJvb2tpZSBrZXJuZWwgaGFja2VyIHdhcyB5YXkg
bW9tZW10LiANCkkgY2FuIHJldmlzaXQgdGhpcyBhbmQgc2VlIGlmIHRoYXQgaXMgc3RpbGwgdHJ1
ZS4NCg0KPiBBbmQgdGhhdCdzIGVudGlyZWx5IGlnbm9yaW5nIHRoZSBnY2MgaGlzdG9yeSAtIHdo
ZXJlIC1PMyBoYXMgb2Z0ZW4NCj4gYmVlbiB2ZXJ5IGJ1Z2d5IGluZGVlZC4gSXQncyBnb3R0ZW4g
bXVjaCBiZXR0ZXIsIGJ1dCBJIGp1c3QgZG9uJ3Qgc2VlDQo+IHRoZSB1cHNpZGUgb2YgdXNpbmcg
LU8zLg0KPiANCj4gSW4gZmFjdCwgaXQgbG9va3MgbGlrZSB3ZSBhbHJlYWR5IGhhdmUgdGhhdA0K
PiANCj4gICAgICAgICAgZGVwZW5kcyBvbiBBUkMNCj4gDQo+IGZvciAtTzMsIGV4YWN0bHkgYmVj
YXVzZSBub2JvZHkgcmVhbGx5IHdhbnRzIHRvIHVzZSB0aGlzLg0KDQpFaXRoZXIgdGhhdCBvciB0
aGF0IHBlb3BsZSBhcmUgbm90IGJyYXZlIGVub3VnaCA7LSkgUGVyaGFwcyBnY2MgZm9sa3MgDQp3
b3VsZCBsaWtlIG1lIHRvIHJldGFpbiB0aGlzIGFzIGEgdGVzdGluZyBncm91bmQgaWYgbm90aGlu
ZyBlbHNlLg0KDQo+IFNvIHRoaXMgYnVnIHNlZW1zIHRvIGJlIGVudGlyZWx5IEFSQy1zcGVjaWZp
YywgaW4gdGhhdCBvbmx5IEFSQyBjYW4NCj4gdXNlIC1PMyBmb3IgdGhlIGtlcm5lbCBhbHJlYWR5
Lg0KDQpraWQgaW4gbWUgY29tcGxhaW5pbmcgInRoYXQncyBub3QgZmFpciAhIg0KDQotVmluZWV0
DQo=
