Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC839BAA1
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFDOJm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 10:09:42 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42600 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhFDOJl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 10:09:41 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7F8D940802;
        Fri,  4 Jun 2021 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622815675; bh=/iWL2EUwUpDDPxZxHx0x/vjOZIshZIA6OpLIvaoqpqw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ig0Tcd0IeA/j61iMEUSYCkWoSIh/PdwNA4zHXhhgjUDYGRk/mjcQsEwXaz0/IB0+q
         mYe3G6PDOJ923llXkjDyvgujHvRbUB8orz0QWTJCpb6YfjQSPPqMJJMXpCfskPONxX
         8ck29oymfwd/GQTriQ5O3D1at7P/mo8C/A4PpNnshBUOlFAhn/4PuH4RKsLquospn7
         TzoQjRqJMTe2fXRdVzkoHwKGX0kXtAJXVnmOUihWQ8w4uq+g14ILbJZwoB1i0FQr3w
         MWjlGRd+ScMyGrkeOLiOwuvB6sU9xImT2X0xfKodIu6fb0HpBpt7oGtn8rskBVwH2T
         HwNl+wqPHOlFQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 95D17A0080;
        Fri,  4 Jun 2021 14:07:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A87F1800BD;
        Fri,  4 Jun 2021 14:07:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ZU44du+A";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRwmBLWGZuy5GVa/jaUO6Lgpuzv92lEeNz/dwSiKmxBhx1YI9MJaTC6GTT8KHd5L/Oc4n2ig8zhvtPLMaLgMiVfFYDEeF2cUWluXpRukewgxtrCgrAli9QZmTU50gZwM2cIAIDstPWagpClLBN2waC4B99OdsEHUo1AbLykwCxpL3sJbKUAnKe0o80l5WJjc+vNCm5L0YbWN21joi+lr/ngX8C7iLfECKEIX9DRV8ggy19mE67ccVwvujRpV2pQs9Ag4B9FOBrqC5O/vWjuPgFFEJz9bfF8GP/lPTjFci9pnUtfyikg18efZtcAC1XXOy1ZIbpez6EkoX43lFtVtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iWL2EUwUpDDPxZxHx0x/vjOZIshZIA6OpLIvaoqpqw=;
 b=MQjwCHifCUp5BHBbLM/Y8hmWTX83vE+OjBXoNZ46YYpiZ2eSLBa1wxQgoKayTchwy8t1DrMkzsnPb21qwfUlbBNqf6R6rKmeYym1Tb8ZXm8gwsnET6MwgeJRq3F23oLZdaSl6FOYufU+BR6DqBXjL9WecZ0NO+x1TomnZrgCT/0u3NB2Y8MhUPqArwyQhVkaFr379OMu7fzfIhHkeyxdOpyGpeKroujaVI5S2T7/Xuy9nMko0yp/a1xm3yhvZcpOoun+shEpyjWVwjoN6hM2qmHw0B/3C1Y/IysaHQiBleZZZnYL/+H3yJ3Kn2ar3As+youH5i0qxU/Hkh8by168hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iWL2EUwUpDDPxZxHx0x/vjOZIshZIA6OpLIvaoqpqw=;
 b=ZU44du+AyBefM2tR/UMqIrz2bwj1abWuuO+VMoofYgFnkvZrvhqIuKD7iltQPsuxw3i/60AxswauiD5u+M3qgQF0s6oP0X8Ul3B6JFDA8JBsoXBH4sHYxjzUsTzrLWmyQSOyWsV3+kxP3VZQjXsokuLssr+Kcegm/8esqHksbV8=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2952.namprd12.prod.outlook.com (2603:10b6:a03:13b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 14:07:40 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4173.033; Fri, 4 Jun 2021
 14:07:40 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 3/9] arc: remove support for DISCONTIGMEM
Thread-Topic: [PATCH v2 3/9] arc: remove support for DISCONTIGMEM
Thread-Index: AQHXWQ3S63f+nukXKkSTjzTrbs0oKKsD49kA
Date:   Fri, 4 Jun 2021 14:07:39 +0000
Message-ID: <f1616f95-f99c-c387-4ed4-88961457a7c6@synopsys.com>
References: <20210604064916.26580-1-rppt@kernel.org>
 <20210604064916.26580-4-rppt@kernel.org>
In-Reply-To: <20210604064916.26580-4-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.75.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec9aea38-5ce5-496c-6277-08d927621d4f
x-ms-traffictypediagnostic: BYAPR12MB2952:
x-microsoft-antispam-prvs: <BYAPR12MB29522BC568D1FC8DB1E567D1B63B9@BYAPR12MB2952.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kLGKfeIgCWSG658DWPO+RXBE8ujEWs7JhD7enmZOZPb4UnkNkXvgHmfbArkDNFWJ3EAQ2xskpJ0QuMNxLhQARdSRzoZxsZrCYChc1gvkWIKRIAD+ZHYrkOUumU1MoGkcWxW89wTEXcJcCbBBN202Z6FM0aEBYVWqaGlZ2jFxiVovufvjdF0rqLsyyMX8F7d3vPfFCwDvQMKSBifW3SojFdInPrmO4cEmuAV5Oo6Iw6kxJ4xQvt+4jY0eAxHyt2L4iT33J8vLDwOXDG20YrTIUCDz08LJtClL3vrFT+R2CXz6C+EkOswrccotla1X+QjiHxIdaZOw3gmnq4k25aVQDaOwaY9SxsvJWq8EwCyvcrDjz/m6ncGyLv2gnkt4290OpMm7z4aXoLewFYE2eklVGrrnlXZFiQ5U6sGSCiJTyr6oDFRGg7igaon14aqliBLHDnBg42kOKo3F15VRREYFClk33I9wc8gx7JIB54QCO1GvascoscVou7hc52gFg8SHZOyJ+yIQeNFIkW3BAsLIehO7pKY6eOLvMMZLec+AWe5Q0EZpPAjuhpeQqHtZOZ5IUGAKSTcgq/D9rJPJvDo+g6JXnibZzL2gXw/O2euDkEiyda0UYIUcYNElHP6NaEj2R2dp70agPnZsUvvZ7so3imkSnxOyWLj196l481mugvFl6WvVwuRD7aBculrGmZCfgYvwRgB3LQdBJtNW1ive4nxTrzyzt5Yl8XiySrOEZf/hcKUNyDhxbD8gBUP/U8it/ecRTJ0MPpQDtT0cQEmXMeP02jJEwogUXJ2gg+Eylwfu3YUYpicRtbEZQIYvUzP2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(376002)(346002)(136003)(31696002)(31686004)(7416002)(86362001)(2616005)(4326008)(8936002)(8676002)(186003)(26005)(478600001)(6506007)(53546011)(71200400001)(122000001)(76116006)(6512007)(38100700002)(6486002)(66946007)(316002)(66446008)(5660300002)(83380400001)(2906002)(54906003)(64756008)(66556008)(66476007)(36756003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V2ptQUlwVGViWUcvZjBLdXc2aGo4TUxWMm1CWTA5T0dOQTJ6VmxkRUYyc094?=
 =?utf-8?B?ZjBSSDA4UUpMaUlGVDdPZktFVjRZRW9mUFdCeUtXb3lUY0ZobFhRWU9RanVI?=
 =?utf-8?B?NlVMSjFiMFVLOEJjeGU1aS9DOFBudXBxV0ZTeFVLMVoycTNZQm1NdllWOUlV?=
 =?utf-8?B?c3o0WlMyMnFYc3RiZm9oOTlIVVZNR25NaGx1M1VaWUFaK3U0RXlWYkFBclI4?=
 =?utf-8?B?NEMvWWFzaGNMWHVmYVBqM1FOclJ0bTF5aFdRKzdoemdQN0p1b3FGQXBybGZ5?=
 =?utf-8?B?cXFMNGJCUmxTc2FIMGRsRGo5S1VOZU1SU2Z6ZzZNd2I5dTdOQnAyYnh1WUgr?=
 =?utf-8?B?RjFnZ2d6bS9aRHNjWE9lTjhjV0N3V0YyUktGdHRTZzkyWnNhVUVPdFNCYlhO?=
 =?utf-8?B?OUkvYmRKQzJyYVpQZDhmQ05uNHIwM29Ob0d1QTJnUVQ0ekMyeFlGeUpFN0pC?=
 =?utf-8?B?YVZVOU9TWkkwRllwSGR0UEV5ei95UTJlQmpCY0JTcWNidHZBQ0gyLzExM2ZY?=
 =?utf-8?B?Slkvc0xtQmxwajRzWEJtWEVodG9nTk9zYjkxZEZVYkNiakpjd2U4TTcwZkY1?=
 =?utf-8?B?UHBaaHhJUjR2ZUZDZ3ZBTm9hc292UG96dXNNZGJKeHNhcnpUZURCaGVQa1R0?=
 =?utf-8?B?dC9hOFJsTk9tMTBzSCtuazRFUEI5VUFBaFJ5UjNaSkRXREliU2VnWlpyd2ZS?=
 =?utf-8?B?VFJ3Z2g3SVBKZ3hOSDNhdVlWNU9QRHArNWF6RTZzbkJFOE84eExJRmFRS2Rk?=
 =?utf-8?B?OWFtVENZTVp0K25ycE93RE96b2QyVTBpanY3NC9sQUlZVUs1Smk1dTkzSXhY?=
 =?utf-8?B?bmFTYjJtbWxseWFldVBuTnhHOC9YTGZhRFUxRVhqZzU4bHZWVGYwR2lmMW4w?=
 =?utf-8?B?RWpOWitBSlpQQVlYWHJEOEh0NEFmdnhrMTlLdUoxY01YalBIK0RnQ3dEU3dp?=
 =?utf-8?B?SVJ2NE5yTXVOY2poTGJWRkZoZkJpNlNWY3ZuZkhUc0wrOXFsSkxVd08xMDBM?=
 =?utf-8?B?aUhNWHZncUJ5cXhoMXZkUUM3L25xMHNRMlJPQzZscHFMRHJ6Y2M5UEpob1U4?=
 =?utf-8?B?R0FDeHl3MkNOTFhTMi9rVGE5bXBrTHlocXZ6dDViRE9kMkU4bHQwTG5NZ0kz?=
 =?utf-8?B?Njc3ckZYNWUzNVVTczFlZXlkS1Ezb3NON2libklGWXBoTnFVdGxQK2dlRzl0?=
 =?utf-8?B?RzVuc09ocWhGczVmNmZKd1RETmRJZHRoZ3o4UlhPckFUalBRVFJ3eTBUUEVK?=
 =?utf-8?B?UkVockgveHlhNjZ2WnFrVzl2N3FxT2hlb28xcVJCOUl2UVN1dTVuNCtibDVm?=
 =?utf-8?B?dVdIblZiaWZZOG41WHlMWWF2VXNlZHN2M2tHL1dSTVlZc3NWSmFBUHh6Nlk1?=
 =?utf-8?B?by8yMTh5Y29hTkt3MHNWVVJrZ2c5aVJyc1JXZGk3SmFvRUt3alFqaXhrenB6?=
 =?utf-8?B?V3VDVGZkMlhOQ01iQWxwS3Jsbk13YUdScDVMZGFUVERVYnZsRHZkQmcvZDF6?=
 =?utf-8?B?Z0dDZERKUjdQdy9GK281amFVeWlndXE1UktRcUQzM0c1aDFCREU1aklDcEhQ?=
 =?utf-8?B?VjVUb0x6UXErSzNCZ0VwOVRkOVBrSE90bFNhUklMNHU1aDBzVm1Gd3kxV2Fv?=
 =?utf-8?B?REREa09yMWFvWDA0NkhOL0syNVlWeXRxUDZvNzdLQnJMbTVqYmR2RU11ZTM1?=
 =?utf-8?B?Z1BKVFR1ZEFrMEZIWXpoeVYva3N6VUg5Y3JockoxSkVlTlkrUHJDN3BZczdo?=
 =?utf-8?Q?M6izgQBg/bQSkkMM/IT8ZsezvVWgJxoWySEx7iD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFE347B03AED33409071190E62241FD8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9aea38-5ce5-496c-6277-08d927621d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 14:07:40.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrnBrqH3QrBA+OiEtUWfGqfKpkTqnMj72MVfU9v8X0BoGXWJ2Bk846vc+/WCuWvXWSMV28xcZ2P1phTJSwdxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2952
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNi8zLzIxIDExOjQ5IFBNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBGcm9tOiBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+DQo+IERJU0NPTlRJR01FTSB3YXMgcmVwbGFj
ZWQgYnkgRkxBVE1FTSB3aXRoIGZyZWVpbmcgb2YgdGhlIHVudXNlZCBtZW1vcnkgbWFwDQo+IGlu
IHY1LjExLg0KPg0KPiBSZW1vdmUgdGhlIHN1cHBvcnQgZm9yIERJU0NPTlRJR01FTSBlbnRpcmVs
eS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29t
Pg0KDQpMb29rcyBub24gaW50cnVzaXZlLCBidXQgSSdkIHN0aWxsIGxpa2UgdG8gZ2l2ZSB0aGlz
IGEgc3BpbiBvbiBoYXJkd2FyZSANCi0gY29uc2lkZXJpbmcgaGlnaG1lbSBvbiBBUkMgaGFzIHRl
bmRlbmN5IHRvIGdvIHNpZGV3YXlzIDstKQ0KQ2FuIHlvdSBwbGVhc2Ugc2hhcmUgYSBicmFuY2gg
IQ0KDQpBY2tlZC1ieTogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KDQpUaHgs
DQotVmluZWV0DQoNCj4gLS0tDQo+ICAgYXJjaC9hcmMvS2NvbmZpZyAgICAgICAgICAgICAgfCAx
MyAtLS0tLS0tLS0tLS0NCj4gICBhcmNoL2FyYy9pbmNsdWRlL2FzbS9tbXpvbmUuaCB8IDQwIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgYXJjaC9hcmMvbW0vaW5pdC5j
ICAgICAgICAgICAgfCAgOCAtLS0tLS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA2MSBkZWxldGlv
bnMoLSkNCj4gICBkZWxldGUgbW9kZSAxMDA2NDQgYXJjaC9hcmMvaW5jbHVkZS9hc20vbW16b25l
LmgNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJjL0tjb25maWcgYi9hcmNoL2FyYy9LY29uZmln
DQo+IGluZGV4IDJkOTg1MDFjMDg5Ny4uZDhmNTFlYjg5NjNiIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2FyYy9LY29uZmlnDQo+ICsrKyBiL2FyY2gvYXJjL0tjb25maWcNCj4gQEAgLTYyLDEwICs2Miw2
IEBAIGNvbmZpZyBTQ0hFRF9PTUlUX0ZSQU1FX1BPSU5URVINCj4gICBjb25maWcgR0VORVJJQ19D
U1VNDQo+ICAgCWRlZl9ib29sIHkNCj4gICANCj4gLWNvbmZpZyBBUkNIX0RJU0NPTlRJR01FTV9F
TkFCTEUNCj4gLQlkZWZfYm9vbCBuDQo+IC0JZGVwZW5kcyBvbiBCUk9LRU4NCj4gLQ0KPiAgIGNv
bmZpZyBBUkNIX0ZMQVRNRU1fRU5BQkxFDQo+ICAgCWRlZl9ib29sIHkNCj4gICANCj4gQEAgLTM0
NCwxNSArMzQwLDYgQEAgY29uZmlnIEFSQ19IVUdFUEFHRV8xNk0NCj4gICANCj4gICBlbmRjaG9p
Y2UNCj4gICANCj4gLWNvbmZpZyBOT0RFU19TSElGVA0KPiAtCWludCAiTWF4aW11bSBOVU1BIE5v
ZGVzIChhcyBhIHBvd2VyIG9mIDIpIg0KPiAtCWRlZmF1bHQgIjAiIGlmICFESVNDT05USUdNRU0N
Cj4gLQlkZWZhdWx0ICIxIiBpZiBESVNDT05USUdNRU0NCj4gLQlkZXBlbmRzIG9uIE5FRURfTVVM
VElQTEVfTk9ERVMNCj4gLQloZWxwDQo+IC0JICBBY2Nlc3NpbmcgbWVtb3J5IGJleW9uZCAxR0Ig
KHdpdGggb3Igdy9vIFBBRSkgcmVxdWlyZXMgMiBtZW1vcnkNCj4gLQkgIHpvbmVzLg0KPiAtDQo+
ICAgY29uZmlnIEFSQ19DT01QQUNUX0lSUV9MRVZFTFMNCj4gICAJZGVwZW5kcyBvbiBJU0FfQVJD
T01QQUNUDQo+ICAgCWJvb2wgIlNldHVwIFRpbWVyIElSUSBhcyBoaWdoIFByaW9yaXR5Ig0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vbW16b25lLmggYi9hcmNoL2FyYy9pbmNs
dWRlL2FzbS9tbXpvbmUuaA0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggYjg2
YjlkMWU1NGRjLi4wMDAwMDAwMDAwMDANCj4gLS0tIGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vbW16
b25lLmgNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSw0MCArMCwwIEBADQo+IC0vKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQo+IC0vKg0KPiAtICogQ29weXJpZ2h0
IChDKSAyMDE2IFN5bm9wc3lzLCBJbmMuICh3d3cuc3lub3BzeXMuY29tKQ0KPiAtICovDQo+IC0N
Cj4gLSNpZm5kZWYgX0FTTV9BUkNfTU1aT05FX0gNCj4gLSNkZWZpbmUgX0FTTV9BUkNfTU1aT05F
X0gNCj4gLQ0KPiAtI2lmZGVmIENPTkZJR19ESVNDT05USUdNRU0NCj4gLQ0KPiAtZXh0ZXJuIHN0
cnVjdCBwZ2xpc3RfZGF0YSBub2RlX2RhdGFbXTsNCj4gLSNkZWZpbmUgTk9ERV9EQVRBKG5pZCkg
KCZub2RlX2RhdGFbbmlkXSkNCj4gLQ0KPiAtc3RhdGljIGlubGluZSBpbnQgcGZuX3RvX25pZCh1
bnNpZ25lZCBsb25nIHBmbikNCj4gLXsNCj4gLQlpbnQgaXNfZW5kX2xvdyA9IDE7DQo+IC0NCj4g
LQlpZiAoSVNfRU5BQkxFRChDT05GSUdfQVJDX0hBU19QQUU0MCkpDQo+IC0JCWlzX2VuZF9sb3cg
PSBwZm4gPD0gdmlydF90b19wZm4oMHhGRkZGRkZGRlVMKTsNCj4gLQ0KPiAtCS8qDQo+IC0JICog
bm9kZSAwOiBsb3dtZW06ICAgICAgICAgICAgIDB4ODAwMF8wMDAwICAgdG8gMHhGRkZGX0ZGRkYN
Cj4gLQkgKiBub2RlIDE6IEhJR0hNRU0gdy9vICBQQUU0MDogMHgwICAgICAgICAgICB0byAweDdG
RkZfRkZGRg0KPiAtCSAqICAgICAgICAgSElHSE1FTSB3aXRoIFBBRTQwOiAweDFfMDAwMF8wMDAw
IHRvIC4uLg0KPiAtCSAqLw0KPiAtCWlmIChwZm4gPj0gQVJDSF9QRk5fT0ZGU0VUICYmIGlzX2Vu
ZF9sb3cpDQo+IC0JCXJldHVybiAwOw0KPiAtDQo+IC0JcmV0dXJuIDE7DQo+IC19DQo+IC0NCj4g
LXN0YXRpYyBpbmxpbmUgaW50IHBmbl92YWxpZCh1bnNpZ25lZCBsb25nIHBmbikNCj4gLXsNCj4g
LQlpbnQgbmlkID0gcGZuX3RvX25pZChwZm4pOw0KPiAtDQo+IC0JcmV0dXJuIChwZm4gPD0gbm9k
ZV9lbmRfcGZuKG5pZCkpOw0KPiAtfQ0KPiAtI2VuZGlmIC8qIENPTkZJR19ESVNDT05USUdNRU0g
ICovDQo+IC0NCj4gLSNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvbW0vaW5pdC5jIGIv
YXJjaC9hcmMvbW0vaW5pdC5jDQo+IGluZGV4IDM5N2EyMDFhZGZlMy4uYWJmZWVmN2JmNmY4IDEw
MDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9tbS9pbml0LmMNCj4gKysrIGIvYXJjaC9hcmMvbW0vaW5p
dC5jDQo+IEBAIC0zMiwxMSArMzIsNiBAQCB1bnNpZ25lZCBsb25nIGFyY2hfcGZuX29mZnNldDsN
Cj4gICBFWFBPUlRfU1lNQk9MKGFyY2hfcGZuX29mZnNldCk7DQo+ICAgI2VuZGlmDQo+ICAgDQo+
IC0jaWZkZWYgQ09ORklHX0RJU0NPTlRJR01FTQ0KPiAtc3RydWN0IHBnbGlzdF9kYXRhIG5vZGVf
ZGF0YVtNQVhfTlVNTk9ERVNdIF9fcmVhZF9tb3N0bHk7DQo+IC1FWFBPUlRfU1lNQk9MKG5vZGVf
ZGF0YSk7DQo+IC0jZW5kaWYNCj4gLQ0KPiAgIGxvbmcgX19pbml0IGFyY19nZXRfbWVtX3N6KHZv
aWQpDQo+ICAgew0KPiAgIAlyZXR1cm4gbG93X21lbV9zejsNCj4gQEAgLTE0Nyw5ICsxNDIsNiBA
QCB2b2lkIF9faW5pdCBzZXR1cF9hcmNoX21lbW9yeSh2b2lkKQ0KPiAgIAkgKiB0byB0aGUgaG9s
ZSBpcyBmcmVlZCBhbmQgQVJDIHNwZWNpZmljIHZlcnNpb24gb2YgcGZuX3ZhbGlkKCkNCj4gICAJ
ICogaGFuZGxlcyB0aGUgaG9sZSBpbiB0aGUgbWVtb3J5IG1hcC4NCj4gICAJICovDQo+IC0jaWZk
ZWYgQ09ORklHX0RJU0NPTlRJR01FTQ0KPiAtCW5vZGVfc2V0X29ubGluZSgxKTsNCj4gLSNlbmRp
Zg0KPiAgIA0KPiAgIAltaW5faGlnaF9wZm4gPSBQRk5fRE9XTihoaWdoX21lbV9zdGFydCk7DQo+
ICAgCW1heF9oaWdoX3BmbiA9IFBGTl9ET1dOKGhpZ2hfbWVtX3N0YXJ0ICsgaGlnaF9tZW1fc3op
Ow0KDQo=
