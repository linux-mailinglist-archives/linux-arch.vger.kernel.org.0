Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25C36B7E1
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 19:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbhDZRQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 13:16:53 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235123AbhDZRQs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 13:16:48 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 223584066D;
        Mon, 26 Apr 2021 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619457367; bh=I+fvrsN1nfNEFnDQfUz7pmkpihbbDEsjeEUEAX+j2yw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FTJA2n3fCMQ0YurUoq4z8XRO7OfFOzdftK0yvYdBEJJjywo1mBKjeqpJ6rum5egzf
         5HIWGuW/BUEXMdyU2WceI2+SjTVA59slml0yxG+y1r3dcEY/bs5JaKdZ1PuY57G63X
         0H8zqIBuPA7vmtuQuXjRCzPROPQmZxLHOYzhkBFy+caAqvErjLK03GxcpsYoIqPUcj
         /CiauVGmvBuOLy0iLljzSmbP2JHnkKSzCAEVWCUykmwpJDsk86/nrKuf0NkKWULI74
         Zuqch8O9VBqYrV5Yiue6NUIz2BMeNdt55YAAg8F5cRClZaUJkK27FwlwT5+dMrXgn+
         ZqKa5mbJkq/Zg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 3689FA0077;
        Mon, 26 Apr 2021 17:16:04 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EC72980095;
        Mon, 26 Apr 2021 17:16:03 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JfGgHqpB";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAla4ibN5Xzj9br55+RiPIpdHfGDnP8lczJ6bc7t7gtVHFn66HnaHVO1NXyJj49xwvwbWry+f0m15BuTtQXHM3Xo7Q5NNALjdLXhT6+6MOlCFaTPyfK44BLu1LlLil4k4mN1LALs8kEWL9kXvpkKyp1lMysorUvQIPsWJAcQDNNYxMu5ve8mdJhptPBfVErfjdugR6cATddXXgdXeYiibMqYk7GQzO+NvYNehxvCvUIvh7+071TVKm1Uc31936Gp/58vDOcoRjnYUH9alpeteiAKAhwMdHRuWnyshiMODRIyf10qAZCK/gcBh1UZnznKGJW/AFPmzo3iYMOIwfvLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+fvrsN1nfNEFnDQfUz7pmkpihbbDEsjeEUEAX+j2yw=;
 b=Rndr9rqHdhm95McgoqK6gese+1Uij7+AF7tS2TU82xxEGZV6/IzBLoCjAoOpDYUwRXGTdoi7U2AW5zHSRNj2zqYQhKxckBeTPlrjiLcFcPhnNJ2GHbraaqSnXgUHDRAnmgmipvBvdoQubyervXlJ2657y/2NAAuKVfby19mc9clS0mGHkA2GEGHWUPB5i5X9f/6DzquCPMXaD9nB3C1GOB4k2ycBF7HT1i4iZYWk/Ny3JjggHWSb6fGJpslbA/jpP0Qu+xdmy4qRFajbbjRsGjxA8asYiaFaTvcm3+gjBB1PE+ibC585spu5UEZbfaJNU40hvBIXUm/zYLRwW/aSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+fvrsN1nfNEFnDQfUz7pmkpihbbDEsjeEUEAX+j2yw=;
 b=JfGgHqpBfrsBjWcPzOlrmVRrLA6ASt8QJtrdZzw2RSezQa0xrdTMUKSoNLXKKSgX77G0dGtDL01+Gc7shwrFEmu2G32pG23aJCvR4EuH/C25bThd+bLj9wQWtqTsXXibeyk6dXKrbnUusKr+R1SIzpu9Q6rVPZQHMU41RPhHBCc=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2853.namprd12.prod.outlook.com (2603:10b6:a03:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Mon, 26 Apr
 2021 17:16:01 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 17:16:01 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Vladimir Isaev <Vladimir.Isaev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] ARC: Use 40-bit physical page mask for PAE
Thread-Topic: [PATCH] ARC: Use 40-bit physical page mask for PAE
Thread-Index: AQHXOoQeRoAsdo9ybEqvN+qAfiw8IKrG/bcAgAADygCAAAkeAA==
Date:   Mon, 26 Apr 2021 17:16:01 +0000
Message-ID: <977ba565-6fb4-b0b0-b982-fa3ecc478563@synopsys.com>
References: <20210426100801.41308-1-isaev@synopsys.com>
 <5010e4f4-c881-6c9f-b24c-4a87d9a4d55f@synopsys.com>
 <BY5PR12MB4131E059EA9C630661349A0EDF429@BY5PR12MB4131.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB4131E059EA9C630661349A0EDF429@BY5PR12MB4131.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e781beff-e309-41d3-00f2-08d908d6f724
x-ms-traffictypediagnostic: BYAPR12MB2853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2853D0EAF5D38C71D983D1D0B6429@BYAPR12MB2853.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqKsBt73UgWLsZB3P1ImaWMkbWnGq5QHjSgBqlBq4XSO+18GTGNH2HFd1HrOd7oFPsGl4yJrrk8Q6z+eQB7aok4wvIcNq+gBs7cKWGycaMfERaFzeoyCrixk3+XaHiYREvN0DkO7NQYXwGDNd3/HjDTaKMgfcvonxHlhnlGucfAI6aJOXh1EY7E7j7irHfh7o4IwvesT3HJe9hD5+WeNTiQaggyzAekKsx2CNoDn3ygdZlfsibJLC9GIsDfThAl6ciE4gsaFa2tN5K8Z53u0NDcPMOYYNzrSjB70FKrNhDDoQlXMr1d6tK3sP/XqdIel/eX0hSktVg0nvQvRCarOQdgNlCSgQkWVDHF3h3QD1gzn5ZHCtTv0507z+nxrYCWB0PnT329Dl8ZjFbLhnf/njfOrxqsUDWPJvIud+Oz7rYbloeKNN/Pt0hq0nMBOcC8cooECqhLsAN5u88QfnPAjfS3waDfYt5ojb6VqIj4AjP6JbgJXygRZ5PrfFoe3MNzJH6+2TT6kwF1mN2jDcAycxsiBMncxkktnf6xi/pICVAvRfwuIQwDZizMBcQM/d3Z+EksT+oGUuseVz5ZAwMhGy4VqSicpNRuwpLTbbCI0RHapUejUQohokxHoMIUHkKh1nxZec9cVIU9f/vFbt4WSsxT20WYwi0zYpJa98A76XnQS7NWCuIFoHaELl6i4qN+8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39860400002)(4326008)(8676002)(478600001)(6486002)(110136005)(54906003)(5660300002)(66946007)(38100700002)(76116006)(66476007)(66556008)(53546011)(26005)(71200400001)(316002)(186003)(31696002)(36756003)(6512007)(2906002)(8936002)(64756008)(6506007)(66446008)(2616005)(86362001)(122000001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bkFteFIwZnJWVXIrME9JZ3dXUWdIU1MyN2xYQURSQlV6TUExWjdGMm5KUGxE?=
 =?utf-8?B?M1hzTUZtMnhsNXh5cTl1SEVMQUgzZXJESTUyeWtEdys1QmtFMkZsQlBZbWJq?=
 =?utf-8?B?bE1mQTNQdjZybUhVRFlra1RlNWtxS1dUNUR1VGwyMzZ4YzVnQU5oMVVOemhP?=
 =?utf-8?B?SE9pSTQ3eGx6OEg1UHJoME8ybmNWa0svUjEzM0lWRlJCRktleStHVG1TbUIz?=
 =?utf-8?B?c094U0pWYU9uMHRGN1FHZjVjcys0a1FaYUxhdEYwK2lJeHR4aXkvZHRSV2Vw?=
 =?utf-8?B?WTZLRHpWVkNlOGwweFhCQ0QxQlEwcnhyc2dORGxUaUc2eEpkU2FJSnBVK1BG?=
 =?utf-8?B?bWt3SGtsY3o3cWtDVDhjS3RvcHlzN0d0N1J0RXovQ1BCWFVYOVp4elk4Y0Rv?=
 =?utf-8?B?NlFvcndRR0hiNGV4QlAyZ0RUVXFoNWNiNjRNVExJcFpMWWtmWG1oYVV1Mklh?=
 =?utf-8?B?RW5RV204MHpUS0ZZY2UvWHlBVENPZXRxdHQ4Rmp0eDFvaXl2NG8zWm5ZQlQ0?=
 =?utf-8?B?RG9iZW5KZ09pVkNjV0JZY2k1UkZFY0VQS005ZnM5VHp3NHRmMWpzRUFvcWdi?=
 =?utf-8?B?bzRVNWQvSE83eEgwTHNMN0t4SDQyQmJYdVA5ZHRFMXJySTVxR3R6MzRTNGV4?=
 =?utf-8?B?eVRnc2pwekFBTVd2YlRtb1kvNEdnck9ZS1FicjJzVjlhTWx4TmpWMUJyN0dt?=
 =?utf-8?B?NDFHUTJsYW9aWThPU2N4emsxYVdiL1BZczk0bWplRU5tN2RrbEJhb3JzSm45?=
 =?utf-8?B?UEUzaWF5eDZUK1RHSlRIOEFOOGpQRUhReTBDNWxHTkJjdWZKcE81eSt2Y2Mx?=
 =?utf-8?B?dUFDVG9pcU53aXR6UmlYZ0FleDAybGpJTU5tTWd3a0ZSU1kvcFNkRjZGbkR1?=
 =?utf-8?B?YlYrR3ZPTnBodGdocXlGSS9CQmNSeGd0eUh3Y1NUTTJKZWZ6QWpoRHZ6QXFk?=
 =?utf-8?B?VXlHd3RrRmdNMG1wcjVHRVRjNlo0UmhIMjJ2eXZSRnh2RXNlZUtVblNxaDdH?=
 =?utf-8?B?ZUdDM2laQXpWOHlYTHZjWWhGVVdHcVFLSHl6OE5NT0l0RjR6dWpEZXFLazZH?=
 =?utf-8?B?NGZ3QlNGcjdUZ1lvVjExdFJTYStjR1F4bjEzSjAwZm1LajBaNityZkc2c09i?=
 =?utf-8?B?QlJoSXduMzEwOGR6a1dSYW9qRVFMbVJ3L1lPZjNvYXFEb3MxSllXSlVlcUEy?=
 =?utf-8?B?cjdiT3c2UEtob2xYS2hlNlFrTzNqVi9wYkVzOTI4cDNaSnoyeER4R1ZKVXl1?=
 =?utf-8?B?K0RuVjVHUnp5aGlNSHhudkRkK2ZTcTV0c3ZSbzQ0Q2haRy9JRDZsTU92S0tD?=
 =?utf-8?B?UjN6S2dlNytJVUdqeHBWWlVTdVZXSDRKZERCQVhQM3k2STJ3blpMNHcwQWJm?=
 =?utf-8?B?VUZpYTVYN1JhWVFBbEVJQnVuQ2Q1c2NvZE05c0xWNEU1MjVJejB3c0J2bTI0?=
 =?utf-8?B?TzVhbEU3d0lpRjl4SFd0SEVqeHFCMlJWbHRpS2loOENrWlNOM3Y2SDN5dFhY?=
 =?utf-8?B?U0VBOG10UU4zZ0ZvRGtTQmk1Zzlzend3dElhaUJXa2JrK1VDVkRYYXl4ZTIx?=
 =?utf-8?B?MmREd2hveXBOSS9lSXR5YmxLRDVPbkVjZnVYejhFQkY4UlJEL1VxSkU5NGFU?=
 =?utf-8?B?akJVMjBZNUZVYlZSTDMxZFl2aSt0NTRxMUJONklkU0NDY0pkL0xIKzlEbHJw?=
 =?utf-8?B?TFNIdVNOcVhWRmFMVERhYW12Lzg4Yi9NTXRONjdoOXZlS2ttZHhUbVFlSy9w?=
 =?utf-8?Q?faDfYxEFgA3IQRDLI8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75E9AAA977E63844997DDA156B364A82@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e781beff-e309-41d3-00f2-08d908d6f724
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 17:16:01.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cl0qT3iEJFCGR+Af7OwUTUXd9UfTq+mLfRmSaaCPrPIi3czERUkbB2ynzaf7KJgACzxcHjE1RM5GAGz8ZyXqKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2853
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNC8yNi8yMSA5OjQzIEFNLCBWbGFkaW1pciBJc2FldiB3cm90ZToNCj4gSGksDQo+DQo+IE9u
IE1vbmRheSwgQXByaWwgMjYsIDIwMjEgNzozMCBQTSwgVmluZWV0IEd1cHRhIHdyb3RlOg0KPj4g
T24gNC8yNi8yMSAzOjA4IEFNLCBWbGFkaW1pciBJc2FldiB3cm90ZToNCj4+DQo+Pj4gICAgI2Vu
ZGlmIC8qIF9VQVBJX19BU01fQVJDX1BBR0VfSCAqLw0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
Yy9tbS9pb3JlbWFwLmMgYi9hcmNoL2FyYy9tbS9pb3JlbWFwLmMNCj4+PiBpbmRleCBmYWM0YWRj
OTAyMDQuLmViMTA5ZDU3ZDU0NCAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FyYy9tbS9pb3JlbWFw
LmMNCj4+PiArKysgYi9hcmNoL2FyYy9tbS9pb3JlbWFwLmMNCj4+PiBAQCAtNzEsOCArNzEsOCBA
QCB2b2lkIF9faW9tZW0gKmlvcmVtYXBfcHJvdChwaHlzX2FkZHJfdCBwYWRkciwNCj4+IHVuc2ln
bmVkIGxvbmcgc2l6ZSwNCj4+PiAgICAJcHJvdCA9IHBncHJvdF9ub25jYWNoZWQocHJvdCk7DQo+
Pj4NCj4+PiAgICAJLyogTWFwcGluZ3MgaGF2ZSB0byBiZSBwYWdlLWFsaWduZWQgKi8NCj4+PiAt
CW9mZiA9IHBhZGRyICYgflBBR0VfTUFTSzsNCj4+IFRoaXMgaXMgb2Zmc2V0ICp3aXRoaW4qIGEg
cGFnZSBzbyB1cHBlciBiaXRzIG11c3Qgbm90IG1hdHRlci4gSW4gZmFjdCwNCj4+IHdpdGggdGhp
cyBhIGJvZ3VzIG9mZnNldCBsaWtlIDB4RkZfRkZGRkZGRkYgY2FuIHR1cm4gaW50byBzb21ldGhp
bmcNCj4+IHdlaXJkIHN1Y2ggYXMgMHhGRl8wMDAwMDAwMA0KPiBJIHVuZGVyc3RhbmQsIGJ1dCBp
ZGVhIGhlcmUgaXMgdG8gdXNlIFBIWVNJQ0FMX1BBR0VfTUFTSy9QQUdFX01BU0tfUEhZUw0KPiBm
b3IgYW55IHBoeXNfYWRkcl90IHZhcmlhYmxlIHdpdGhvdXQgdGhpbmtpbmcuIFNvIGlmIG9mZiBp
cyBhY3R1YWxseSBvZmZzZXQgZm9yDQo+IHZpcnR1YWwgYWRkcmVzcyB3ZSBjYW4gdXNlIHVuc2ln
bmVkIGxvbmcgZm9yIGl0Lg0KDQpAb2ZmIGhlcmUgaXMgZm9yIGEgcGh5c2ljYWwgYWRkcmVzcywg
YnV0IGlzIGl0IGludHJhLXBhZ2Ugc3RpbGwgc28gDQpkb2Vzbid0IG1hdHRlciBpZiB2aXJ0dWFs
IG9yIHBoeS4gSW5kZWVkIGl0IGlzIGEgZ29vZCBpZGVhIHRvIGZpeCBpdCB0byANCmJlIHVuc2ln
bmVkIGludCAobm90IGxvbmcgc2luY2UgdGhhdCBpcyA2NC1iaXQgYXR0dW5lZCkNCg0KLVZpbmVl
dA0K
