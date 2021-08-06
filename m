Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E2A3E2F9D
	for <lists+linux-arch@lfdr.de>; Fri,  6 Aug 2021 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhHFTCc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Aug 2021 15:02:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48292 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243449AbhHFTCb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Aug 2021 15:02:31 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CEB3A41089;
        Fri,  6 Aug 2021 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1628276535; bh=VPXV5W1SE2064T87JVvoyFcv53Ty8fh/SyJ2O3HIQNg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Cqah8+3y2CK+2Z7Omz54P8LB4VJ5ghcQtI99WsbEXdnO5WvUr3oAICKuTBWragYic
         n2J3IMgqCnWziyEu6Q2lkPuXrpv+ynfDAvVz/YgQQK1aVadIOPyI3VIw4IMU/u+gya
         XX/fQAvDKYBsQexdpXODqZNciqI0lNY6WwzMYg71mYGF0HR42a8c6ONp7JeoRCejOF
         9YlwB2AJbphEPf3Y00JFdHwEOpa+cEDMY2gyS+eFgo1uhngnsXYzUtKSAgnWwpeahO
         /9+iyebZQXHZmUtnlfbqnkSf5c91MeaY9d6822N0qgMrnuXCELR5KKqUuxVZSiwU8N
         B8DOuYyh7reYQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1B049A00DD;
        Fri,  6 Aug 2021 19:02:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5078480219;
        Fri,  6 Aug 2021 19:02:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Wk0SSmv3";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoEOAUFYF6Mb4XoxSk6S+wLn467NU85gJ3JAYywB5VovxGoihdRd3pFVx/hXBrljdlq0Ob8YbHQUD/P+k6xpYmazOI2i4/Zhjsh/xad+Ox03ZpxAupuiWAgdaj/qzgXug5bSndagNO2J4BGZKfbbo44zYmKCWZyYoz8K8VFfK3haYT/rMDddj9FXNCoUEwCeW9YqTcQwziTZ92yxL2VdaSGs3msZjTp/lFHhM/cv8m5DAiwIVhKc3EPr3wwse+yZgYNNDWKBS0DWaxuSah8mbkmUnkrKrK/ZJfoiqIzN+I0q2ndTWa7I4cz4AymWCQ3PAPgRjAMumuLkeHYp/TegOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPXV5W1SE2064T87JVvoyFcv53Ty8fh/SyJ2O3HIQNg=;
 b=VR/ZWJW0iDx3OrTMHJrm30fa2GSHOE6ieUKjVZUZMyCI5uxga8tTJUeSXcF/3rgHal9lePhUHLgOik544RrfIBZTojzCl2S1R6eEUbGWIiM6iocfgi3YU9P3Fk4PZh/xTwnwt0moAS2Bt/8OQvv3CInYXBzEBh1/RZYoKnxcEo4886z4P30oxFmR7xrULr/g52BOOzwFx7FWEe308iRgeqjbYtc6S+miuboUXG5fyZFQgXkUId2ir1GUxeRdC6ob97MMuQciId7qp8sqGDIAF304qaCgx3krL4Typ7z5Wvf6a0m9hHIkWfEnzPZtQ3iJxg3jQgx6yJp0ROo5ONcydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPXV5W1SE2064T87JVvoyFcv53Ty8fh/SyJ2O3HIQNg=;
 b=Wk0SSmv3u+Od7b4/WeMdzQUTUWwoDs0E1mnlJAivCq2TsFJg4tRhOj+eqJl0tfymHDBCgtRrzHwl1R4tlxxNW6zn91M9H0VtQ88opuXnRF8B0Hcw6pJZpeSgC4ch8rY0kBaUOLVNQcRgRgohsbMvthkO6qkUJfQaIMVxLn3fFtQ=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3697.namprd12.prod.outlook.com (2603:10b6:a03:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 19:02:07 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee%3]) with mapi id 15.20.4373.028; Fri, 6 Aug 2021
 19:02:07 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Will Deacon <will@kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [RFC] bitops/non-atomic: make @nr unsigned to avoid any DIV
Thread-Topic: [RFC] bitops/non-atomic: make @nr unsigned to avoid any DIV
Thread-Index: AQHXii4WOTDVGX/qWky1PyNWg17Mw6tmfYOAgABZOQA=
Date:   Fri, 6 Aug 2021 19:02:07 +0000
Message-ID: <d67f12c0-4ede-2a81-9de9-570beb662884@synopsys.com>
References: <YQwaIIFvzdNcWnww@hirez.programming.kicks-ass.net>
 <20210805191408.2003237-1-vgupta@synopsys.com>
 <20210806134244.GA2901@willie-the-truck>
In-Reply-To: <20210806134244.GA2901@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ecea63d-1617-4e03-757b-08d9590caff9
x-ms-traffictypediagnostic: BY5PR12MB3697:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3697688F27B788D9099EC05BB6F39@BY5PR12MB3697.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76gDTepXpVA2svDw7/oMvXyk/Zz0jc6wqNFqzaKxJKliYqqjxT2k25PYEThxOezUC6RAN+iEH9faQdsoFsDHRJYP54+x11BBOtdxoLln8sKqQ8hMN+8aHiB3t/OiXi7FaRjX+TjgzcZjjnGOz55cv4DhyEob4EqNz/3kXt+sIffpCE5E6/9En2p6Wa83rGZMFr8UuzN/e9fBC6DSNLOuRvNEUx0798BQzfGJlm9KE24LtF6pvd8Vj1+0J8k2CX9K3I2UA9Js1ZtYsmgypllZndBuI4RTHetR3HWewHGdJZt8zocTGSlHhBBsT1kHf2LPvRO+QFUfNuupJhbnYDCFFPIqIsGy7rVrTuXc4nVdFlGrnRHQfE6booT7f9W/ctuGRzI06Xd3VeRXwmw7aWbeGfxNpskxr8L3ZWFH8YXYz+QH96kgiMFoQiK7khphOFIMVLwuVkDqDGFjhkmPzBi7jHOVn4Nf8pyY+HIn0h4N9j4lJaRo7Eq26wehM9CR/m9oETFKEq4WnoZnJ9Wufib8zdHIcBYl2n0bkD1bvdC2jjIHSiSn/XqketiaMI2F2ClOoZDXBjS/4q+d++Y2KkCF7IPjWCKiFNkYq0ta2f5nbig9QLu+NlYWrw7Cj0g9IzPQ3EyGby6r7/Sws2wu2fIIRN0FgJf4gLAhQoGRBl9rntyRHT+XQfrxKBFN/u+rq/HBuVrKmMbHoqsDk27fOszx0i7UNwv7oIODzrqQ96+9ZSeBOzwD2rxm/LvQrQ6vFfFE92yKPYJw4UgfQOiH7VL5BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(366004)(376002)(346002)(64756008)(66446008)(66556008)(38070700005)(71200400001)(66476007)(86362001)(83380400001)(66946007)(31696002)(8676002)(6506007)(6486002)(5660300002)(53546011)(2616005)(6512007)(36756003)(31686004)(26005)(186003)(38100700002)(478600001)(316002)(122000001)(8936002)(110136005)(4326008)(54906003)(2906002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHlWOUlmWmlmSFo2Vy9JODJxVEs0UG1SaCtINFNpWW9QNC9BU3dJcnlUdHUv?=
 =?utf-8?B?SVZnbHVJQUdKTm1zcVdmOERpVFhEWEI1SWlJQ05nMTlpNmVaZ0dhV0xKZ0FD?=
 =?utf-8?B?Ry9CREw3VDc2dTIycjJIMGVLcWhNdm9mTGpzdXVLaTVzakRMSmVLaVc1UnVp?=
 =?utf-8?B?a1VpT2VKM0xzN2dEclFsbUVMUzFldGtqNjdxa1FVTzNBTXo2NFZYRFAxTC8v?=
 =?utf-8?B?WmphNkpzQmoyd3pFcGFPQjZGYURBQjRTYi9aeXBsRmhMOHF5cW11TlJVZldG?=
 =?utf-8?B?T1M1bURPWDMyWlJRVWtEdVpidWdVVVJ0ZnlKRE9TN2Ztak0reDUycFFTTHVx?=
 =?utf-8?B?dHdhSHdhbUQ1Nml3dXpRNFoyU21iaHRwbUtUeVFGU2pYdkRJdHViM3d6TGpL?=
 =?utf-8?B?VGZab2dYTjlQQU1YaWZob09wZlNoMTlLYk5hYUdjVzVQMk83aWZQZzZYK2tS?=
 =?utf-8?B?WURJSFdaRFkxRzhmRTdkMjJCNm5VYmNsNk1Md2d6SFBtUkgyd1pjV3REYUNN?=
 =?utf-8?B?Z2g4KzYzVHlvZFhSd2treWJXRFZMVmJtMkxkdjByMEYyTGc0T0pSQXVhMkdE?=
 =?utf-8?B?ZXd0eC9XazhlTTNtN0tadUdyQUJvM0FTUnpPbGh0YlhJb1RjcjRHTVY3d0tY?=
 =?utf-8?B?c3RoVmJBSGxJVW96cXZlUWJSZW9BMlVJL20xczN2SzErZTNaVHNEQXFvYjNW?=
 =?utf-8?B?b1NiK1U5cEQvS1ZQYXpWdk4weTFPRTZLeC94UmRKVW1jMGlKME5xS3VYVlJB?=
 =?utf-8?B?eXc4dDJZU2Z2bkFLUDYreFNuL3gwMEpvSEVJRXN4aDRNNnNjRjlaRTQ0anh4?=
 =?utf-8?B?R3B4ZnZVZDJLZjAvTkJLSlZkQUphTjFXdGI0M05vdllwcXdaVUlmOWhyeG92?=
 =?utf-8?B?ZGcvRW1jWHpuMU95cVAyb0RJZjd5MEtydnZNTlZDdFEzSytsRFIwNGZKWTU0?=
 =?utf-8?B?K0I4azNXSlEraGk5SWpVUzRRbFFKSzlaTHhBQVJacndqRFpRSUdxbkM2QzhQ?=
 =?utf-8?B?VWhZU3R4a3pPbTRwTWZxOHBpWTh1bUZpSVRIUjhDU04wTjdYOW1VaHF6b2JR?=
 =?utf-8?B?MTB0S0Zxc1p6dTRtamFoQWlSVEZUR0crbDI4SlYxcGcxQVg0anJUazhIOVNi?=
 =?utf-8?B?aFhFNEdTQW5WYjAybnZvOE1sbDVRQWJJNm5wTitmeGEzWXI4Sm1keWE3NlhM?=
 =?utf-8?B?ZGhlOGR3djRsZGlHYkVWMTNic2FDT2daUnRucWRGSUZ3MUVyZXZTbFFkbG8y?=
 =?utf-8?B?SG5Da3lDc1pHZ3lrVll5TW5ybmwzb2hiOE0zQ21SMzFKTXgxeFROOTE3RFZO?=
 =?utf-8?B?SzRyVHRBTlJUbnp6VkhXN1ZtanFuNVozdzRCakVFanRoT2ROd0gvVXFucXRX?=
 =?utf-8?B?eTcwNk5sa0RDcms3VitTdngwTlhCbVhROHhpSzllTzRTeTl1VkN4d0VyeHlD?=
 =?utf-8?B?dFNSZ2tvazkyYU9vZUUvalhkQXh3MVpSNXdPREdJZzhjUGJRb1RTbm9uQ2x4?=
 =?utf-8?B?TkExcUY4dlZuUFQ2Unk1cDVzOVU5M0NpSXBqVUdVMWJGVGU4M3RYOWVoUzRV?=
 =?utf-8?B?NXBUUkduWnV4SVRzc25ZWU55em5XelNSbVNIRzJIUXM4L0JaOFhFYVJQK1U0?=
 =?utf-8?B?ZWx5N1FkS3g2RzRtUUtNd2xwcStDNXdhNUkza3EyREdGOHBJZ2hzdnFNNjM2?=
 =?utf-8?B?c0NQWHZ2NkpmQytObnIzdDRxOGR1UkdYZzRIQzN3b2hGbXhsdGR2Qk1hQVUr?=
 =?utf-8?Q?KF8snT+TM1QsRANQno=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D85589D197A0394EB49185054034B434@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecea63d-1617-4e03-757b-08d9590caff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 19:02:07.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SqkSAMsoDx6htIK8fPN9qNpHW/b6MPifpIadwcfqxT6etQCMMtGugUQacofndlyuFRQXgunW9WNyaU66QHc5Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3697
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gOC82LzIxIDY6NDIgQU0sIFdpbGwgRGVhY29uIHdyb3RlOg0KPiBPbiBUaHUsIEF1ZyAwNSwg
MjAyMSBhdCAxMjoxNDowOFBNIC0wNzAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+PiBzaWduZWQg
bWF0aCBjYXVzZXMgZ2VuZXJhdGlvbiBvZiBjb3N0bGllciBpbnN0cnVjdGlvbnMgc3VjaCBhcyBE
SVYgd2hlbg0KPj4gdGhleSBjb3VsZCBiZSBkb25lIGJ5IGJhcnJlcmwgc2hpZnRlci4NCj4+DQo+
PiBXb3JzZSBwYXJ0IGlzIHRoaXMgaXMgbm90IGNhdWdodCBieSB0aGluZ3MgbGlrZSBibG9hdC1v
LW1ldGVyIHNpbmNlDQo+PiBpbnN0cnVjdGlvbiBsZW5ndGggLyBzeW1ib2xzIGFyZSB0eXBpY2Fs
bHkgc2FtZSBzaXplLg0KPj4NCj4+IGUuZy4NCj4+DQo+PiBzdG9jayAoc2lnbmVkIG1hdGgpDQo+
PiBfX19fX19fX19fX19fX19fX18NCj4+DQo+PiA5MTliNDYxNCA8dGVzdF90YWludD46DQo+PiA5
MTliNDYxNDoJZGl2CXIyLHIwLDB4MjANCj4+ICAgICAgICAgICAgICAgICAgXl5eDQo+PiA5MTli
NDYxODoJYWRkMglyMiwweDkyMGY2MDUwLHIyDQo+PiA5MTliNDYyMDoJbGRfcwlyMixbcjIsMF0N
Cj4+IDkxOWI0NjIyOglsc3IJcjAscjIscjANCj4+IDkxOWI0NjI2OglqX3MuZAlbYmxpbmtdDQo+
PiA5MTliNDYyODoJYm1za19zCXIwLHIwLDANCj4+IDkxOWI0NjJhOglub3Bfcw0KPj4NCj4+IChw
YXRjaGVkKSB1bnNpZ25lZCBtYXRoDQo+PiBfX19fX19fX19fX19fX19fX18NCj4+DQo+PiA5MTli
NDYxNCA8dGVzdF90YWludD46DQo+PiA5MTliNDYxNDoJbHNyCXIyLHIwLDB4NSAgQG5yLzMyDQo+
PiAgICAgICAgICAgICAgICAgIF5eXg0KPj4gOTE5YjQ2MTg6CWFkZDIJcjIsMHg5MjBmNjA1MCxy
Mg0KPj4gOTE5YjQ2MjA6CWxkX3MJcjIsW3IyLDBdDQo+PiA5MTliNDYyMjoJbHNyCXIwLHIyLHIw
ICAgICAjdGVzdF9iaXQoKQ0KPj4gOTE5YjQ2MjY6CWpfcy5kCVtibGlua10NCj4+IDkxOWI0NjI4
OglibXNrX3MJcjAscjAsMA0KPj4gOTE5YjQ2MmE6CW5vcF9zDQo+IEp1c3QgRllJLCBidXQgb24g
YXJtNjQgdGhlIGV4aXN0aW5nIGNvZGVnZW4gaXMgYWxyaWdodCBhcyB3ZSBoYXZlIGJvdGgNCj4g
YXJpdGhtZXRpYyBhbmQgbG9naWNhbCBzaGlmdHMuDQoNCkFSQyBkb2VzIHRvbzogVGhlcmUncyBM
U1IgKExvZ2ljYWwgc2hpZnQgcmlnaHQpIGFuZCBBU1IgKEFyaXRobWV0aWMgDQpTaGlmdCBSaWdo
dCkuDQpTbyBwZXJoYXBzIHNvbWV0aGluZyB0byBiZSBkb25lIGluIHRoZSBjb21waWxlci4NCg0K
Pj4gU2lnbmVkLW9mZi1ieTogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KPj4g
LS0tDQo+PiBUaGlzIGlzIGFuIFJGQyBmb3IgZmVlYmFjaywgSSB1bmRlcnN0YW5kIHRoaXMgaW1w
YWN0cyBldmVyeSBhcmNoLA0KPj4gYnV0IGFzIG9mIG5vdyBpdCBpcyBvbmx5IGJ1bGQvcnVuIHRl
c3RlZCBvbiBBUkMuDQo+PiAtLS0NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2FzbS1nZW5lcmljL2Jp
dG9wcy9ub24tYXRvbWljLmggfCAxNCArKysrKysrLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiBBY2tlZC1ieTogV2lsbCBEZWFj
b24gPHdpbGxAa2VybmVsLm9yZz4NCj4NCj4gV2Ugc2hvdWxkIHJlYWxseSBtb3ZlIHRlc3RfYml0
KCkgaW50byB0aGUgYXRvbWljIGhlYWRlciwgYnV0IEkgZmFpbGVkIHRvIGZpeA0KPiB0aGUgcmVz
dWx0aW5nIGluY2x1ZGUgbWVzcyBsYXN0IHRpbWUgSSB0cmllZCB0aGF0Lg0KDQpPSyBJJ2xsIGdp
dmUgaXQgYSB0cnkgdG9vLg0K
