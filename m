Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60E836B6D9
	for <lists+linux-arch@lfdr.de>; Mon, 26 Apr 2021 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhDZQcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Apr 2021 12:32:19 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:49694 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233923AbhDZQcS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Apr 2021 12:32:18 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 448A5C0563;
        Mon, 26 Apr 2021 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619454695; bh=Hn+TcdAZ6Mo+5GEuArgCPWaDzPD7mrFfbQ+UXTi6XSk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MftyBXsWtQ38w0eA2znXN9C0VSjHSFjgOI75i9JBw0XEmFBRu97SpSauP6VDTOOPj
         agTUDWxDExxXrIOooP0miQVNkMBLpn4uSfBwoA9zpHqJ69SdsbvJFbjHIaUuS1U51q
         TZoVO3a2W1qn7DIcgKXNxDzRDEKKe7aWa9nhlWn5EbaOHqqXJrqECssHbAOpvmAxpn
         TPRD9QuEvsYUImEhcmmXigEHmLqR8MEGYlHLhTpAKBuX348aKz8aYto6QVe7Yrz8aj
         R2bNcGhhEvJxWA86WxdTlYu67lNOp4o+b3fC3Yt9Kkguc1BOE2HS+Xtn4biy9Ob1g9
         8wQIuYX5RS6jA==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5DF95A006F;
        Mon, 26 Apr 2021 16:31:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C3FCE40145;
        Mon, 26 Apr 2021 16:31:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wF+yBSfZ";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXC9rdIRjt/N7H8rKpLOOHsb7Outo+Z4f5f0mJ6mpq8uhEkV2iGvh1RKG8fLUydZR8S8XfKxTTE9WATtMOdTjPIw2weIPYGL+lQbbprXjy1hbXJaQrH3gO9usEzQlPkKvFu3uvhJ0V0D5R4CYuM5o4EAOiAw/X1j3H98le+mIM5pS9L55YBHNf76G5bP/uP6b8clFW++Kt4XdXpOLmYx2Y93IRogFlYyLzIg8/1p3RHCP3HXAIhAwhQTChv6SxhCd9tKqNqFqqgS+q2/0rG8Pgq6KIgx8BEfMxO89oZR1QwEecrQ7WXh0qp5IkWid30nc91JMWAdgDpLzzj99pv1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn+TcdAZ6Mo+5GEuArgCPWaDzPD7mrFfbQ+UXTi6XSk=;
 b=H5vGAS1T/ALF+rY/OwF6JMfwiz5GuEq31Sx8//KUtGOqdkTClcQPhGaQWvM3XpwJRfmJUfjHMuqQ626kfLaWaMfi5WdLsgFq52dGxDyyEDiHpm8jIDTJChM6XvtjPR5ENibjF6ogZ8hRv/NYKFHt5OKfTTJR7bRjmoxSBcKBWZEF1n2YslZgxsMN9TXr3jVIjNbv4zT127YTrRgpQQ6+eQ7wNvuA4moYurvbxEPOOssAHXZbuc7Iugvj62MIqIDeGZeXrZw1hgnAJ91G9WX11J0aXEe7hwtaGaT7MS20z1zxjBe0oJVh+nNS4lRxFvbWguqgJWnqpfjjhUDS3Y04LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn+TcdAZ6Mo+5GEuArgCPWaDzPD7mrFfbQ+UXTi6XSk=;
 b=wF+yBSfZ9PNTP2HU9lehG+e68RzfoJcerSvTbGyo5cGSKJ1foYFl4Pws/1fc86BeqQN/JvWHYBIZDVrL3ILEoUCl0EK8twhcEXMgbohhGiHkKcg+yXzgcARQTDSWw36I67wlUeJJADTQUtZo0zbj74ILqpnssyDbfHIYgyVQ8z0=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3826.namprd12.prod.outlook.com (2603:10b6:a03:1a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 16:31:28 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 16:31:28 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Isaev <Vladimir.Isaev@synopsys.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: Use max_high_pfn as a HIGHMEM zone border
Thread-Topic: [PATCH] ARC: Use max_high_pfn as a HIGHMEM zone border
Thread-Index: AQHXOoRsYGXQMu245kWPftN4W+3i4qrGqbaAgAAHOQCAAEjmgIAABFgA
Date:   Mon, 26 Apr 2021 16:31:28 +0000
Message-ID: <835d0c3f-ccba-e8d7-df4a-6c0ce5296e31@synopsys.com>
References: <20210426101004.42695-1-isaev@synopsys.com>
 <YIakBTNpLsPJaj7i@linux.ibm.com>
 <BY5PR12MB41318EB561C2E936B0371B5EDF429@BY5PR12MB4131.namprd12.prod.outlook.com>
 <YIbnO3BhOeUSRU0E@linux.ibm.com>
In-Reply-To: <YIbnO3BhOeUSRU0E@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea395e44-2ced-4611-ee59-08d908d0be40
x-ms-traffictypediagnostic: BY5PR12MB3826:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB382655AE07D0ED796E4F6E77B6429@BY5PR12MB3826.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tuaKJTPx2o8EB5oB/vk1i4J/UwOISOstP1ftOsoJIe4JCphoxzglQP2PByqO1u9YcnOIGUBsHaTyBTW4uuL5qWlIFwqingSjIY6gFfjhpT+QhgZWYcY/T3lqvajL5Q43diABjTVVJ+Qb9ieG0+YKZea6Hsbk6Shylk+egn/tFHg/aFE8upzDuulu8Qn2PqMoQDOokG44ALqcAdECWq+nYb+rHGxgnY3ZSYy/+jWFdn4CoCqqOSAtylIAMTrLa9XM7CflytZZso6/HuG/bbrDhmm3XVh4KGitsR8L/R7yZrP85WwPH8GAtodKinYIkMZrHvTotDmKickKccOCHiMoP975WfSJaZQrNHbcuxUcOkSChkiwYnHs5WHZoGHjl6KpPrx+d2xS91gF0PRfyFzKobGvM/bQVBf5WdLg3n8AxST9xvYQoSi2NJrTu6kUnvRCPansVRmbtZjXl+YFl3rc2sKPaCdDCTcUIsX5UKx45142Qag7ma3StFQtu/YyXFr08WTxzIEEP8lkcW7dIZ7ATOJdi/FgkQJfnlmGyMgwvqtlF7bbsK6c+TDFee5rEBebsJpgBiwqvT8EPCrOSvOq3dONPTrGE2rPNl+AStf7bcf3ayr3s27xobHlEiiENTPjZTTPpY6BDoCAQjlphR43ivopDf6p6XuNW6qaPJtVTpddUDJc8oSf2Rm4PA+yy7jT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39860400002)(376002)(71200400001)(66476007)(66556008)(8676002)(54906003)(2616005)(86362001)(76116006)(5660300002)(31686004)(478600001)(4326008)(31696002)(66946007)(66446008)(64756008)(186003)(6512007)(316002)(36756003)(4744005)(110136005)(122000001)(53546011)(6506007)(8936002)(6486002)(38100700002)(26005)(6636002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cU5wM2ZZV0xtTG91S3lZVmViUitYem5lZlpiSGJzZW9GTUN3TVpJWUpXLzM1?=
 =?utf-8?B?OFZlV3ZSTnRCZzB4WEdVZ3JZQXcvTHBKT0RWalBhWTBJL1d0WnVTRUg0VHlH?=
 =?utf-8?B?eVZ0c01FNzc2Z3hUYW5XMjl4VWdYeHFDNmg0NkhMZit1ZnpSSkZ1ek11dE5U?=
 =?utf-8?B?dE5LcG5zcWVxMkFpVFdTMmV4cEF0QzZIYm9TOXNVbGc2MHprc1hMSDFtUnA1?=
 =?utf-8?B?dEJXZUEzQmw3QkNPL0lodk9TbURNZ29xODVEWlpGYjJyTHpjcGp4Vndla25i?=
 =?utf-8?B?ajVBT3BrdUhvQW5OY1U0REdud2FEU05TbGJBc1pSMWl0L1ZvbFk5REw0MzQy?=
 =?utf-8?B?QTZMeW9HWElsaUtuN1pqc2dYVTdBOUlLY3g5SHlUb2NaT3RRbUhNYVdPZ2ZW?=
 =?utf-8?B?UzZlQ0ZLNlNLSWZDenFoYXlnWVpnVXdLWnkwVFFBeVJxZ1ZxNjVibTRnRU5l?=
 =?utf-8?B?Yi9udHBKN3U4S0U1RTJHWXVxU2xRSzRpUFBnTVo2bHRDYXQzeUd0Y3A0d1Yv?=
 =?utf-8?B?a1lYYit6RDJCZjE2VzY5UmZUdmJhbVlXZlpWWGl6OFZ2OVBhYUkvb2tCOFhB?=
 =?utf-8?B?TnV5NDJtL04rbkUrTTNrUHppMEFQM0NHU2E4WHh4aUZxVHJUUVhQRTRBK2ZB?=
 =?utf-8?B?NVErOXRLQ0JxZzhBNHQ4Uy94NkJuQmpDOVNrdEY0WHM4QmZGRWlNUjRXWkEw?=
 =?utf-8?B?eUQvQlpxNEZWVE5BcENhSVNJL05pc1RTM0xBVmNDSUtlUG5XVU9GTWRSM0pJ?=
 =?utf-8?B?VjRVL2g1WWc3OGRmdWxKTnZteTFqWXJaRDF6aXF1YzJBQzNnejZ0WDNOWjV6?=
 =?utf-8?B?QWdqUHk2Z3ZvQUIyRGhKOWxpc1BCRnRiR0UrQSs4ZHFlTUhZZkVNZVNEVC9w?=
 =?utf-8?B?M0tGZXg5NUhqQ3NKandqYWlZd05lRkhUUkt3N3lhZGgrU05OaERqVUZnbFNw?=
 =?utf-8?B?Snh1Z2ZObkpRZ1NVRTZUNDR0VHNqOUJPbWp6VDY1UGY5NFkzenlLcGlJYTBH?=
 =?utf-8?B?R0Zkb3ZhQXY3ZW5WZzBYRDdoRGxKSEdHRWFocWE2eSs4aTBqdU84b0Vyakl3?=
 =?utf-8?B?VVVyVU1EODQydWRhcnFtaVFDTkVNZEhVT1F0bzA5RnhMcDJ6cUUvU09zS2s3?=
 =?utf-8?B?RnZ2NlljbUsyUmRCZjhyaDZENk5PVUMxK1lZSW56cEp1QlJJNGxrbkdmWVZI?=
 =?utf-8?B?azZPdEY1dTE3bnBXTk9TTlB0OXBZRGZOaE8rWkRMd2psWnNNOVB5THlxcFh5?=
 =?utf-8?B?UEpZeldXZTJ0TU9lbDhxODRnK1FseGJrVVNlT05JLzM2NjVjRFJlZXUvWnRo?=
 =?utf-8?B?U3B0V292THFIb21UbWMzOFdNeGF6RHd5Z0tIOTJIZW4vYjViRG1QVmZzKzV5?=
 =?utf-8?B?QVViZXZqdVM4ZWJydFY4QkN1dzR4YVh6WmNWQkU2ZytVYlhnMU1sS21xTGF4?=
 =?utf-8?B?YUo3NmV6cFlpR0Y1TVdXZFdFclVBeHNMempxWnpsUzdUcmlnbHJJS1pGNEF6?=
 =?utf-8?B?WkNHSVBxMDNad2FyMjZpRm0zaVFNLzlQVDFHR1ludjE3M0c3ckFhQW9vdWo4?=
 =?utf-8?B?RlVjTkhXY21PeGk4cllyT2JVZFdkVDd1c1BDajAwOWQ2azhTRU1FZUM4L1lK?=
 =?utf-8?B?ZFhTQjZqTVlZR0lHa1hkMHovMzh0UXA5VVp6QTNHZk5OOTJJU3ZBdWw2UHVn?=
 =?utf-8?B?b1VWcTJsdFBjeEFRSzJXQ25tY1JoUStrVGhoZTY0cVdRTzk2S1JzeDNjM3Vz?=
 =?utf-8?Q?0mdW5yu1aQWvtEVusQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DFBC5C4EE87D143A885DB028106FDA3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea395e44-2ced-4611-ee59-08d908d0be40
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 16:31:28.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+4gRdJE19jKN/dmnOBkGCuDB0K9uV/2eAhYECBorIYP1NiWsbhwntWc8Fu4l9f6dvtTvxxSWidtLa62Kq921Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3826
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNC8yNi8yMSA5OjE1IEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiBPbiBNb24sIEFwciAy
NiwgMjAyMSBhdCAxMTo1NTowMEFNICswMDAwLCBWbGFkaW1pciBJc2FldiB3cm90ZToNCj4+IEhp
IE1pa2UsDQo+Pg0KPj4gT24gTW9uLCBBcHJpbCAyNiwgMjAyMSAyOjI5IFBNLCBNaWtlIFJhcG9w
b3J0IHdyb3RlOg0KPj4+IE9uIE1vbiwgQXByIDI2LCAyMDIxIGF0IDAxOjEwOjA0UE0gKzAzMDAs
IFZsYWRpbWlyIElzYWV2IHdyb3RlOg0KPj4+PiAtCW1heF96b25lX3BmbltaT05FX0hJR0hNRU1d
ID0gbWluX2xvd19wZm47DQo+Pj4+ICsJbWF4X3pvbmVfcGZuW1pPTkVfSElHSE1FTV0gPSBtYXhf
aGlnaF9wZm47DQo+Pj4gVGhpcyBpcyBjb3JyZWN0IHdpdGggUEFFNDAsIGJ1dCBpdCB3aWxsIGJy
ZWFrICFQQUU0MCB3aGVuICJoaWdobWVtIiBoYXMgbG93ZXINCj4+PiBhZGRyZXNzZXMgdGhhbiBs
b3dtZW0uDQo+Pj4NCj4+PiBJdCByYXRoZXIgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlOg0KPj4+
DQo+Pj4gICAgICAgICAgaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSQ19IQVNfUEFFNDApKQ0KPj4+
ICAgICAgICAgICAgICAgICAgbWF4X3pvbmVfcGZuW1pPTkVfSElHSE1FTV0gPSBtYXhfaGlnaF9w
Zm47DQo+Pj4gICAgICAgICAgZWxzZQ0KPj4+ICAgICAgICAgICAgICAJbWF4X3pvbmVfcGZuW1pP
TkVfSElHSE1FTV0gPSBtaW5fbG93X3BmbjsNCj4+Pg0KPj4gTm90IHN1cmUgaWYgSSB1bmRlcnN0
YW5kIHdoeSB3ZSBzaG91bGQgaGF2ZSBtaW5fbG93X3BmbiBoZXJlLiBJbiAhUEFFNDANCj4+IGNh
c2UgbWF4X2hpZ2hfcGZuIGp1c3Qgd2lsbCBiZSBzbWFsbGVyIHRoYW4gbWluX2xvd19wZm4uDQo+
IEhtbSwgYWN0dWFsbHksIHlvdSBhcmUgcmlnaHQuIFRoaXMgc2hvdWxkIGJlIGZpbmUuDQoNCkJ1
dCBzdGlsbCB3b3J0aCBhZGRpbmcgYSBjb21tZW50LiBJZiB0aGlzIGNvdWxkIHRyaXAgdGhlIHBl
cnNvbiB3aG8gZGlkIA0KdGhlIG1hc3NpdmUgY3Jvc3MtYXJjaCByZXdvcmsgdGhlbiBJIGRvbid0
IGtub3cgd2hhdCBtZXJlIG1vcnRhbHMgd291bGQgDQpydW4gaW50byA7LSkNCg0KLVZpbmVldA0K
