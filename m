Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB93D26C2
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhGVOyV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 10:54:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45466 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232766AbhGVOyT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 10:54:19 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9C5EFC0D1A;
        Thu, 22 Jul 2021 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1626968094; bh=BUmPkDLja1uFLv96/XaBMTZsg8QTHky2W5R4FFmrI0A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EIBBJjugEky3JsM7pf0+Ro1POZNEpA6I0endH1gjRIsXabif4tbTX13wdSJ+6QjD+
         +gupSERS45/x83PZeXCIlNP/0KCqeF3C8f5Co24jStQe0xLALliO3W6be1xwTewoDd
         ks4P/B+mKp5T5SH3wZhXNeJl+OYiCsfJOz+Dvz2WaJXslqAacXnQ/IiW796m56O6kZ
         m5veQ10zPJWEy3oFDpBDGX5vPsx/R9w3o8+pje/aA69xQrNEs2qramTLnXCSnwgZgd
         nLDbEfKsgC3w50wkvQdlu+HzOEs7vyYNEQNhnKweCLi1H6bQciUUuKw+tRk0Ouh+5e
         umoBaTUMc7W5A==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 60522A0071;
        Thu, 22 Jul 2021 15:34:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EEC3E8145C;
        Thu, 22 Jul 2021 15:34:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="aiooDNAn";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvs7Igd15MDCOZ3H2UErwkI7rrwKjGclHqmf/Aj5ToYKPLF4TX1Q2a1fgHZsixzGYU6+2oN11C2D5jgnuuFHZ7E4jKEJkeeDwxis0u1LoR0XlugOviZ59dkMENO1B7q6eITDomzgZowcU734Fos3DPiZbJni0JYa3xj/V3cJZVWA3ji64+SD8bB/mCwFFYy7y7e912UbsDKeDI6IGD3W+4uBqA2XBSRAG91W57PPJDz4DychN9jCWSAGhfC6vhG/ewiIt8yTVssGKfQP2La5M1H//yY4L/s6k744IVB5SEHL0qsF3uFQ6SUJVuKhA68LqWz1X3kgSlNWQZiV/7PyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUmPkDLja1uFLv96/XaBMTZsg8QTHky2W5R4FFmrI0A=;
 b=KYr+WbDIrMqOjBtbHDrnV395/meOSgByulfyVeIYS/FExybBYe6eisO8R3TnNASghvHanre4zL4pgZA4CRNwxOcLAzV78NXpj6abD40WA/t8OA0ugMRB6rG8GgUKFjCdYbMbtWH+rJ8SdiHV2zt7qP97FSk9ACxf+ly/896SjnNW7VKHqPBocmGKl5E5S5iHcANkwIzgNns/68sXcRS9aBZde9wLWCrgNe6k9zPXMS3dmMcYlhQFNmr5IdT2AqISFzSAyWz2n4fpIR0YSUhQ3GVSdzx293nEre0yJSCbKlpnplhkUoqC4y1rxVYQOwciRsZf9cQkr3wocW0fprxTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUmPkDLja1uFLv96/XaBMTZsg8QTHky2W5R4FFmrI0A=;
 b=aiooDNAn7Gf4KLOsE97sIs0YcAwQ7fBI+30gcSsyK19oOGc2BSVQJ9fm675PQ6uSfeztqJ/oRDTgxvKb7qt3BXp99KPIGpuhV/ryEIRkgGqwMmjyOKKdndt4iDsOxARKDQAnUxoRFMMtsNyT1+n7bxof6wD1lI0O8wklP+j0Qe0=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 22 Jul
 2021 15:34:31 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::acbd:42ac:9bab:39ee%3]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 15:34:31 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Subject: Re: [PATCH v3 4/9] arc: use generic strncpy/strnlen from_user
Thread-Topic: [PATCH v3 4/9] arc: use generic strncpy/strnlen from_user
Thread-Index: AQHXfvf8c+XCb73zs0+6DIklrzt0SqtPIDGA
Date:   Thu, 22 Jul 2021 15:34:31 +0000
Message-ID: <fe655b87-8fbc-101e-7b53-9f2a2887f7df@synopsys.com>
References: <20210722124814.778059-1-arnd@kernel.org>
 <20210722124814.778059-5-arnd@kernel.org>
In-Reply-To: <20210722124814.778059-5-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec03b6d6-36b6-418f-a43e-08d94d263399
x-ms-traffictypediagnostic: BY5PR12MB4051:
x-microsoft-antispam-prvs: <BY5PR12MB40515E5AB0629753B94FCE4EB6E49@BY5PR12MB4051.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:466;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Ze4QZoZrS/OGnzY/ThZU1iOBTj4Wxus30kAe++63CnGmoI6DafaY5PRSnuOg+F93BUUSKBJzjB2js3ekTBommfasCh/F4EDJY4mfyzE8UGWkXvTHhbTh2otH7K4Tqdl6et+HBu5lXGZ4fVHxeKtmObZnpegKCk1UWV5SSzWcgb6oS9mheqkYwp1Ap3hiNZcHHcF9TpzUeN+5PFjspFrOLxRptD/EfWJG6xrN+1b1jTDoaE7QiExNCDgWRaXNYCEduexciDMMpsvHZbdd60r9Hr8Q9vqHaZuGpAEIfFTlBas82Fyx1dB1WUBg9ARsXK4wHBe9DRALZ0fBrIQ4tCr7Zkzmidb6e914zGDpCMNO2yZ+Prjtqew6Q/Othl2o1f3SJJGNm+ATX47BffPULvYsjJUQWOeUJI/9YmYAq170Hmgn3gJMaWcQlTp0ZC9vhV55PZBuLm7/GMwru+z0+rfxRIQ9hezI4MPIgGxZe61fjjBnXv7FUJfBUwFVo/t1/LSOcrLzauJjTpIDO0pZ8GganXwduiKVDLr7qo+sGQCAbvJTbVWKwTdHQAxWsJmvmAltieVW8r1DUFSJXRuweuYlFMq0B+pDTBTHsLVYmmhW7lo2M2W4xGgrDOKajPujpmFfr06LMyBIBViG8Yat3dK0hob4Z3wUSl1Jz4j184CYccXrqUxwdD8N4eVfuYxtB+eHsE3dSZCY6mDYLP+KUU3apxtHPs5cu69Efzlak6TbgGy3GoPIyN+CzgmQHQ+zUwZbM/VMl4QMIQO9sH9EHrkLTN9ZycTT1lwDReYfq+hjBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(396003)(346002)(6512007)(2616005)(71200400001)(8676002)(7416002)(478600001)(8936002)(4326008)(110136005)(7406005)(316002)(54906003)(6486002)(2906002)(53546011)(5660300002)(83380400001)(186003)(31686004)(38100700002)(66476007)(66446008)(64756008)(31696002)(66556008)(6506007)(86362001)(26005)(36756003)(66946007)(122000001)(76116006)(41533002)(45980500001)(43740500002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWVDeE1LU0pLRHpjb2dQKzBiaTNPcVg3bldUUmdpTXZhT1grWURhaml4QXJv?=
 =?utf-8?B?K0N6d2NLRFNQYkVXaHo5OTBnWHQwT1Q5R2V1aUFzeFQ2MmhzVHlXT0dNZ3Q1?=
 =?utf-8?B?TkVWa082V2xDMHlxUDB6Mkd6dGhnTVN3bVYzZDd2Y3JjS0ZHek9vREhwcThy?=
 =?utf-8?B?WjQ5cG85d2h0Zk45NzNxWERLTFJYTEpnTWlWZXdiNnFNSkJRR1Bub1RLSHdw?=
 =?utf-8?B?YXlrcVQ1UG1LODdBaUkxMUZ1aHVkNXpING8xekZhWEFpMWlTaHl6alE0enFp?=
 =?utf-8?B?T0Y3R3h5L0ZSektSSmpKWlJjQVZ0U1Y1VENHRkFucWljVXpIN01aK1FpVWxB?=
 =?utf-8?B?c2NWK3pNWnRPMWo2UitKT2dtS1MvYmMzeVdwYWZ5c0gxTThzaVhPbVZHQzhw?=
 =?utf-8?B?aTFTdVJUcjJNaXU3QlpBektZcjlEOFdLWmo0VHJIMDN5MVAxSllMcUc3NDlR?=
 =?utf-8?B?TEhwcUhuT2s2SW5ySW5lMEM3UUt0WEtPQjdBTGhEUzN4UEJpWWFQQzZHeDcr?=
 =?utf-8?B?ZWdCU2ZtR1B4ZC8zOTJ5QkR4TFZoMExCaUJDRGZwMS8rTW94anlSOHFCN2dl?=
 =?utf-8?B?WjNtVUlOVmNEaHVvbU5uNnU4L1o4a09XOG8zYjVLdElwSFVPQzhGMDMxMVRW?=
 =?utf-8?B?aVNEQ2hYSkZuaHI5RUg1bW1oT21HNnBmek51ZTNRQXg1eURCb2Z0R0lwZ1R0?=
 =?utf-8?B?dG40dHdmMFQycTVNcVJ1U2lCL1NpSU54cUNEY284OXNBN1BDZUtTWGN0YytR?=
 =?utf-8?B?NWdNUHBNZmR6dkpHUnRDL21XQ2VvUnNuQTVYNjhDTDhXTk1GWGp5ZzNVWUlY?=
 =?utf-8?B?aHZGMWFGNzAzTnlDWUFWaTF1aE5obWdJdkVpbDZ5d1grYmFnZGpRSWZvY1hC?=
 =?utf-8?B?YWg2am9yNm40VmJBcExITEN4bng0bFZTSXB4Tm5FdDZrK2s0L04vY01tLzJ6?=
 =?utf-8?B?cUxjdTJ4bi8ySkMyY0JHdkZLQXZiWkhBZXFWUk1tU2RkbStrTEQwc21saWsy?=
 =?utf-8?B?L3pCSjdjQTg2anQ5VGFlK0F3MGRDc0JidFlxVEpjcUU2SlluTWUzWG5XRHlD?=
 =?utf-8?B?ZWFYS2RTS2FENGx4dkRObktHSmNqL2dNbklMY0ZaREZKNXh5ekRVa1l2ZWpS?=
 =?utf-8?B?NnB1VWdaODFkNUpKRDIxUldZdHVWaWwzNU1iZEZFTFdTNWRVN0o4cms0ZjM4?=
 =?utf-8?B?ZDgwbEg1eko5S2FENDRMSzZkVEtzVmljdU9hSlBjNlhOV3lZWFJPZDk0YXhD?=
 =?utf-8?B?Yk9ybDU2alhwczVURXdPNStBYkxhRklKeVpDRU9DclRmS01OZ1NMZStCaVVm?=
 =?utf-8?B?cnlxOUx0VE8wUmNqbSt4OERhVFpUSXVpTFhpbVVtL3lZZ1J3NXY5OGNnSTRx?=
 =?utf-8?B?N01WcDFRalBnNnZuVHBhMDlnTStOTW44c21sbk1wdWp4WStaOEZXZXl5Uzd3?=
 =?utf-8?B?VGs1cjFjVzJxc2tHdmRLV0VTN0Z0S0wrc0JRSFVOSTJ3Si9zaG5nRk9Qb1Ft?=
 =?utf-8?B?OWMrM0Q1dG4xSnk1cVRxZEpWU2pJd3ZGWUZpay9hVlJoNnM2WkJ1elBkQ1FC?=
 =?utf-8?B?VnUvc2Z2S3JvSHByUHNaOXhNNk1rc0tjZkxVRHYrSVlSSHdBZTd3Y3ZXdFBQ?=
 =?utf-8?B?MFZ1MGM3VmpGZVVtTE5oK3ZoTGJOa3A0L2JxYkVFSDk2QjZLMnRTa0ZoZEsz?=
 =?utf-8?B?ZkxRUnk2WkI1b1ZFb01VbXFOTDErWTJ0d3Q2ZDJKamVoMWM5L2s5NXZvUkFu?=
 =?utf-8?Q?2fHhAKVPSWZZWvACs0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <73F9861E435C6E489C89616888EB6F96@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec03b6d6-36b6-418f-a43e-08d94d263399
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 15:34:31.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOC0QwW4JOMjzcPFA2Q5I4qw3NXUoEet0AYLJGf9kjCxGZYBT+GgNCH3P1sgynooHp67EE7OKcLm8F/OJ0lEBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gNy8yMi8yMSA1OjQ4IEFNLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiBGcm9tOiBBcm5kIEJl
cmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPg0KPiBSZW1vdmUgdGhlIGFyYyBpbXBsZW1lbmF0aW9u
IG9mIHN0cm5jcHkvc3RybmxlbiBhbmQgaW5zdGVhZCB1c2UgdGhlDQo+IGdlbmVyaWMgdmVyc2lv
bnMuICBUaGUgYXJjIHZlcnNpb24gaXMgZmFpcmx5IHNsb3cgYmVjYXVzZSBpdCBhbHdheXMgZG9l
cw0KPiBieXRlIGFjY2Vzc2VzIGV2ZW4gZm9yIGFsaWduZWQgZGF0YSwgYW5kIGl0cyBjaGVja3Mg
Zm9yIHVzZXJfYWRkcl9tYXgoKQ0KPiBkaWZmZXIgZnJvbSB0aGUgZ2VuZXJpYyBjb2RlLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KDQpMR1RNLiBU
aHggZm9yIGRvaW5nIHRoaXMgQXJuZCAhDQoNCkFja2VkLWJ5OiBWaW5lZXQgR3VwdGEgPHZndXB0
YUBzeW5vcHN5cy5jb20+DQoNCi1WaW5lZXQNCg0KPiAtLS0NCj4gICBhcmNoL2FyYy9LY29uZmln
ICAgICAgICAgICAgICAgfCAgMiArDQo+ICAgYXJjaC9hcmMvaW5jbHVkZS9hc20vdWFjY2Vzcy5o
IHwgODMgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gvYXJjL21t
L2V4dGFibGUuYyAgICAgICAgICB8IDEyIC0tLS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDkwIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMv
S2NvbmZpZyBiL2FyY2gvYXJjL0tjb25maWcNCj4gaW5kZXggZDhmNTFlYjg5NjNiLi42NGU1Zjkz
NjY0MDEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL0tjb25maWcNCj4gKysrIGIvYXJjaC9hcmMv
S2NvbmZpZw0KPiBAQCAtMjcsNiArMjcsOCBAQCBjb25maWcgQVJDDQo+ICAgCXNlbGVjdCBHRU5F
UklDX1BFTkRJTkdfSVJRIGlmIFNNUA0KPiAgIAlzZWxlY3QgR0VORVJJQ19TQ0hFRF9DTE9DSw0K
PiAgIAlzZWxlY3QgR0VORVJJQ19TTVBfSURMRV9USFJFQUQNCj4gKwlzZWxlY3QgR0VORVJJQ19T
VFJOQ1BZX0ZST01fVVNFUg0KPiArCXNlbGVjdCBHRU5FUklDX1NUUk5MRU5fVVNFUg0KPiAgIAlz
ZWxlY3QgSEFWRV9BUkNIX0tHREINCj4gICAJc2VsZWN0IEhBVkVfQVJDSF9UUkFDRUhPT0sNCj4g
ICAJc2VsZWN0IEhBVkVfQVJDSF9UUkFOU1BBUkVOVF9IVUdFUEFHRSBpZiBBUkNfTU1VX1Y0DQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9pbmNsdWRlL2FzbS91YWNjZXNzLmggYi9hcmNoL2FyYy9p
bmNsdWRlL2FzbS91YWNjZXNzLmgNCj4gaW5kZXggMzQ3NjM0OGYzNjFlLi43NTRhMjNmMjY3MzYg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL3VhY2Nlc3MuaA0KPiArKysgYi9h
cmNoL2FyYy9pbmNsdWRlL2FzbS91YWNjZXNzLmgNCj4gQEAgLTY1NSw5NiArNjU1LDIzIEBAIHN0
YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBfX2FyY19jbGVhcl91c2VyKHZvaWQgX191c2VyICp0
bywgdW5zaWduZWQgbG9uZyBuKQ0KPiAgIAlyZXR1cm4gcmVzOw0KPiAgIH0NCj4gICANCj4gLXN0
YXRpYyBpbmxpbmUgbG9uZw0KPiAtX19hcmNfc3RybmNweV9mcm9tX3VzZXIoY2hhciAqZHN0LCBj
b25zdCBjaGFyIF9fdXNlciAqc3JjLCBsb25nIGNvdW50KQ0KPiAtew0KPiAtCWxvbmcgcmVzID0g
MDsNCj4gLQljaGFyIHZhbDsNCj4gLQ0KPiAtCWlmICghYWNjZXNzX29rKHNyYywgMSkpDQo+IC0J
CXJldHVybiAtRUZBVUxUOw0KPiAtDQo+IC0JaWYgKGNvdW50ID09IDApDQo+IC0JCXJldHVybiAw
Ow0KPiAtDQo+IC0JX19hc21fXyBfX3ZvbGF0aWxlX18oDQo+IC0JIgltb3YJbHBfY291bnQsICU1
CQlcbiINCj4gLQkiCWxwCTNmCQkJXG4iDQo+IC0JIjE6CWxkYi5hYiAgJTMsIFslMiwgMV0JCVxu
Ig0KPiAtCSIJYnJlcS5kCSUzLCAwLCAzZiAgICAgICAgICAgICAgIFxuIg0KPiAtCSIJc3RiLmFi
ICAlMywgWyUxLCAxXQkJXG4iDQo+IC0JIglhZGQJJTAsICUwLCAxCSMgTnVtIG9mIE5PTiBOVUxM
IGJ5dGVzIGNvcGllZAlcbiINCj4gLQkiMzoJCQkJCQkJCVxuIg0KPiAtCSIJLnNlY3Rpb24gLmZp
eHVwLCBcImF4XCIJCVxuIg0KPiAtCSIJLmFsaWduIDQJCQlcbiINCj4gLQkiNDoJbW92ICUwLCAl
NAkJIyBzZXRzIEByZXMgYXMgLUVGQVVMVAlcbiINCj4gLQkiCWogICAzYgkJCQlcbiINCj4gLQki
CS5wcmV2aW91cwkJCVxuIg0KPiAtCSIJLnNlY3Rpb24gX19leF90YWJsZSwgXCJhXCIJXG4iDQo+
IC0JIgkuYWxpZ24gNAkJCVxuIg0KPiAtCSIJLndvcmQgICAxYiwgNGIJCQlcbiINCj4gLQkiCS5w
cmV2aW91cwkJCVxuIg0KPiAtCTogIityIihyZXMpLCAiK3IiKGRzdCksICIrciIoc3JjKSwgIj1y
Iih2YWwpDQo+IC0JOiAiZyIoLUVGQVVMVCksICJyIihjb3VudCkNCj4gLQk6ICJscF9jb3VudCIs
ICJtZW1vcnkiKTsNCj4gLQ0KPiAtCXJldHVybiByZXM7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBp
bmxpbmUgbG9uZyBfX2FyY19zdHJubGVuX3VzZXIoY29uc3QgY2hhciBfX3VzZXIgKnMsIGxvbmcg
bikNCj4gLXsNCj4gLQlsb25nIHJlcywgdG1wMSwgY250Ow0KPiAtCWNoYXIgdmFsOw0KPiAtDQo+
IC0JaWYgKCFhY2Nlc3Nfb2socywgMSkpDQo+IC0JCXJldHVybiAwOw0KPiAtDQo+IC0JX19hc21f
XyBfX3ZvbGF0aWxlX18oDQo+IC0JIgltb3YgJTIsICUxCQkJXG4iDQo+IC0JIjE6CWxkYi5hYiAg
JTMsIFslMCwgMV0JCVxuIg0KPiAtCSIJYnJlcS5kICAlMywgMCwgMmYJCVxuIg0KPiAtCSIJc3Vi
LmYgICAlMiwgJTIsIDEJCVxuIg0KPiAtCSIJYm56IDFiCQkJCVxuIg0KPiAtCSIJc3ViICUyLCAl
MiwgMQkJCVxuIg0KPiAtCSIyOglzdWIgJTAsICUxLCAlMgkJCVxuIg0KPiAtCSIzOgk7bm9wCQkJ
CVxuIg0KPiAtCSIJLnNlY3Rpb24gLmZpeHVwLCBcImF4XCIJCVxuIg0KPiAtCSIJLmFsaWduIDQJ
CQlcbiINCj4gLQkiNDoJbW92ICUwLCAwCQkJXG4iDQo+IC0JIglqICAgM2IJCQkJXG4iDQo+IC0J
IgkucHJldmlvdXMJCQlcbiINCj4gLQkiCS5zZWN0aW9uIF9fZXhfdGFibGUsIFwiYVwiCVxuIg0K
PiAtCSIJLmFsaWduIDQJCQlcbiINCj4gLQkiCS53b3JkIDFiLCA0YgkJCVxuIg0KPiAtCSIJLnBy
ZXZpb3VzCQkJXG4iDQo+IC0JOiAiPXIiKHJlcyksICI9ciIodG1wMSksICI9ciIoY250KSwgIj1y
Iih2YWwpDQo+IC0JOiAiMCIocyksICIxIihuKQ0KPiAtCTogIm1lbW9yeSIpOw0KPiAtDQo+IC0J
cmV0dXJuIHJlczsNCj4gLX0NCj4gLQ0KPiAgICNpZm5kZWYgQ09ORklHX0NDX09QVElNSVpFX0ZP
Ul9TSVpFDQo+ICAgDQo+ICAgI2RlZmluZSBJTkxJTkVfQ09QWV9UT19VU0VSDQo+ICAgI2RlZmlu
ZSBJTkxJTkVfQ09QWV9GUk9NX1VTRVINCj4gICANCj4gICAjZGVmaW5lIF9fY2xlYXJfdXNlcihk
LCBuKQkJX19hcmNfY2xlYXJfdXNlcihkLCBuKQ0KPiAtI2RlZmluZSBzdHJuY3B5X2Zyb21fdXNl
cihkLCBzLCBuKQlfX2FyY19zdHJuY3B5X2Zyb21fdXNlcihkLCBzLCBuKQ0KPiAtI2RlZmluZSBz
dHJubGVuX3VzZXIocywgbikJCV9fYXJjX3N0cm5sZW5fdXNlcihzLCBuKQ0KPiAgICNlbHNlDQo+
ICAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcgYXJjX2NsZWFyX3VzZXJfbm9pbmxpbmUodm9pZCBfX3Vz
ZXIgKnRvLA0KPiAgIAkJdW5zaWduZWQgbG9uZyBuKTsNCj4gLWV4dGVybiBsb25nIGFyY19zdHJu
Y3B5X2Zyb21fdXNlcl9ub2lubGluZSAoY2hhciAqZHN0LCBjb25zdCBjaGFyIF9fdXNlciAqc3Jj
LA0KPiAtCQlsb25nIGNvdW50KTsNCj4gLWV4dGVybiBsb25nIGFyY19zdHJubGVuX3VzZXJfbm9p
bmxpbmUoY29uc3QgY2hhciBfX3VzZXIgKnNyYywgbG9uZyBuKTsNCj4gLQ0KPiAgICNkZWZpbmUg
X19jbGVhcl91c2VyKGQsIG4pCQlhcmNfY2xlYXJfdXNlcl9ub2lubGluZShkLCBuKQ0KPiAtI2Rl
ZmluZSBzdHJuY3B5X2Zyb21fdXNlcihkLCBzLCBuKQlhcmNfc3RybmNweV9mcm9tX3VzZXJfbm9p
bmxpbmUoZCwgcywgbikNCj4gLSNkZWZpbmUgc3Rybmxlbl91c2VyKHMsIG4pCQlhcmNfc3Rybmxl
bl91c2VyX25vaW5saW5lKHMsIG4pDQo+IC0NCj4gICAjZW5kaWYNCj4gICANCj4gK2V4dGVybiBs
b25nIHN0cm5jcHlfZnJvbV91c2VyKGNoYXIgKmRzdCwgY29uc3QgY2hhciBfX3VzZXIgKnNyYywg
bG9uZyBjb3VudCk7DQo+ICsjZGVmaW5lIHN0cm5jcHlfZnJvbV91c2VyKGQsIHMsIG4pCXN0cm5j
cHlfZnJvbV91c2VyKGQsIHMsIG4pDQo+ICtleHRlcm4gbG9uZyBzdHJubGVuX3VzZXIoY29uc3Qg
Y2hhciBfX3VzZXIgKnNyYywgbG9uZyBuKTsNCj4gKyNkZWZpbmUgc3Rybmxlbl91c2VyKHMsIG4p
CQlzdHJubGVuX3VzZXIocywgbikNCj4gKw0KPiAgICNpbmNsdWRlIDxhc20vc2VnbWVudC5oPg0K
PiAgICNpbmNsdWRlIDxhc20tZ2VuZXJpYy91YWNjZXNzLmg+DQo+ICAgDQo+IGRpZmYgLS1naXQg
YS9hcmNoL2FyYy9tbS9leHRhYmxlLmMgYi9hcmNoL2FyYy9tbS9leHRhYmxlLmMNCj4gaW5kZXgg
YjA2YjA5ZGRmOTI0Li40ZTE0YzQyNDRlYTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL21tL2V4
dGFibGUuYw0KPiArKysgYi9hcmNoL2FyYy9tbS9leHRhYmxlLmMNCj4gQEAgLTMyLDE2ICszMiw0
IEBAIHVuc2lnbmVkIGxvbmcgYXJjX2NsZWFyX3VzZXJfbm9pbmxpbmUodm9pZCBfX3VzZXIgKnRv
LA0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MKGFyY19jbGVhcl91c2VyX25vaW5saW5lKTsNCj4g
ICANCj4gLWxvbmcgYXJjX3N0cm5jcHlfZnJvbV91c2VyX25vaW5saW5lKGNoYXIgKmRzdCwgY29u
c3QgY2hhciBfX3VzZXIgKnNyYywNCj4gLQkJbG9uZyBjb3VudCkNCj4gLXsNCj4gLQlyZXR1cm4g
X19hcmNfc3RybmNweV9mcm9tX3VzZXIoZHN0LCBzcmMsIGNvdW50KTsNCj4gLX0NCj4gLUVYUE9S
VF9TWU1CT0woYXJjX3N0cm5jcHlfZnJvbV91c2VyX25vaW5saW5lKTsNCj4gLQ0KPiAtbG9uZyBh
cmNfc3Rybmxlbl91c2VyX25vaW5saW5lKGNvbnN0IGNoYXIgX191c2VyICpzcmMsIGxvbmcgbikN
Cj4gLXsNCj4gLQlyZXR1cm4gX19hcmNfc3Rybmxlbl91c2VyKHNyYywgbik7DQo+IC19DQo+IC1F
WFBPUlRfU1lNQk9MKGFyY19zdHJubGVuX3VzZXJfbm9pbmxpbmUpOw0KPiAgICNlbmRpZg0KDQo=
