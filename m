Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353CA4C8627
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 09:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiCAIRX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 03:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiCAIRW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 03:17:22 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90074.outbound.protection.outlook.com [40.107.9.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796683031;
        Tue,  1 Mar 2022 00:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxvt4/BjScC9XnHmmjCeb47vlRHGYDqs4dBndJGsSFbGfFBC1a/rKybaZYQC4Y4kAr1RTZ4fKjPTLhgHg7VVbvcNzBDHN5HpaCc9RdcMP+HEowdSHN2fXzt02s8lrz+d/Sbih3b6JlImQddC+6GTCjuX0VncR6m6PhbOFqzfYhua/FwkXuy/4N6t+Fme4/SZQu8G78F6h4FbShGVi0TxFPQrvzzi1CZJCYAjhrnANGuFXoHejDUJUoTdrjG129y1sv6yRuLBCU2lq8to0RX65egX3/4CVzGL1HI3kr7yc35xOIgvVhURa2YVzooxooirEboKaV+9Rrw8hNCTCs2t0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LjrbCR+OmfjPHumVRItvsrnLLOnA3Oyh5KAvSD1Wt4=;
 b=WXl219YINLYT7ABQQiM12HuM+KrRZL3PQ7PR+3nQUgDWcZBeKsK+sFR9+a8wBpi94mj2+OhWmF/UWs4fFKDDOT6+e+2YJLpNrrtpazmuWsIFGzXLcS5U4wPJLxXzshM68cSX9ksAtHmSQkOemm5di3uSYG7P2jljSTHsLEbzdtiHPve1UD9yLxgApbjvI4ji9YqBViwwBKPvFzuyhGvfjEHYuKTA+1EX7QmRZWdun1K+Tfksw6AWEi3/Um9m0E6UOsiXXZwvg8gd4RKmF7Ev9nOeNrhkWdLG5H4vClMR+RFCar34UYRikIvr24g4eT7RYp/ebe++/Z6log3sNnFbsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 MRZP264MB2085.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Tue, 1 Mar 2022 08:16:40 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b4e1:6a58:710c:54f3]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b4e1:6a58:710c:54f3%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 08:16:40 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
CC:     "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Topic: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Index: AQHYLJFSiXlMrwz6p0y+BwOKpFxenayoysUAgADa34CAAAiaAIAAgfmA
Date:   Tue, 1 Mar 2022 08:16:40 +0000
Message-ID: <dc3c95a4-de06-9889-ce1e-f660fc9fbb95@csgroup.eu>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
 <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
 <542fa048-131e-240b-cc3a-fd4fff7ce4ba@arm.com>
 <Yh1pYAOiskEQes3p@shell.armlinux.org.uk>
In-Reply-To: <Yh1pYAOiskEQes3p@shell.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86abfc16-126a-48cc-df4e-08d9fb5bd033
x-ms-traffictypediagnostic: MRZP264MB2085:EE_
x-microsoft-antispam-prvs: <MRZP264MB2085C7FCD7801E44A0C7436AED029@MRZP264MB2085.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qKr9J3hfp8R5am51Eg/HumouWBwrF5/hqph9pjGSMWgySgmszTVhrf4h4198tXSqUupD+4uD/wJIbj1BIw6Y547QF8GZvm0WkOlKi8AIn9/1vZixZxiNOfPNBHwmxcdTjMMMHkV2lXbinf04wLrDkUEn5TocmYcoc2MsEcjTB2Q1niW22oTk8LIq3dzirvp5wytTJRr2ipXQ/QXbctZAv51surpWufbhkIwFzgUxH6yLU/6SX3YiP2MZ1mvb0C0dSx+9vvt5ZWnKcwozBBaMZk2vIVOBc0zFs1pr4tjIvQsZiF45bpIhRRlImZS/RHoaXgga1g5xGnYwIZbjHKxCjIWv/iRQj4SbZuRYD2Nu+lS1TgjCzJfhDc8boYwlAjs3E4P9aNe/Sle7giO4Z71AbYn5W8nvsHdC6LWB5YvxLB5prnrVfzTVo9EDM3cI8gKHjQD0Dbg6EaL6/W8504FJ5DZUCRVI41WBxudY5Y+z7aXvFKrChDB19Z3moPjn0Rl+Zll3B5VAFbYpx/+/aV/tghI0dmEn1Hpas66mViHALN7/hDRX04ian43I/tb8pb/J5Wgur4rVIuoDnKHCeUqsc9892VudQ+57k1s0/ruedZ7qSJI1CX5Rb4rSQP90a+8fHX9brJaI22+k6dCrtPLExtPcUf927MiAS1wF/dUxYdAQsDoCXr77sLJ7dw+EvsG0vmCKweUCnzbI/ra0XSwDhJ0Wkck0x72ltnvZvf6y41/AZluHxEIBHCO+LTRndFkPIisHj7K0kIS7iOgvpP17zQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66574015)(36756003)(2906002)(71200400001)(6512007)(26005)(53546011)(2616005)(6506007)(186003)(316002)(6486002)(31686004)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(8676002)(38100700002)(122000001)(508600001)(44832011)(86362001)(76116006)(38070700005)(91956017)(7416002)(5660300002)(110136005)(31696002)(8936002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWY5V2xsdXF0VkZiMko1dHdsd3lHY0xOKzNBQ0tsU3BMWWxkVmVGaEFxY1Jw?=
 =?utf-8?B?VDJVYXloa2hBS2VrNTZHbFlRMUtWeHVuOGFsRVg0SmFOLzJFS05SQ2w1Nk5P?=
 =?utf-8?B?RkNFS2ZFKzFVa1h6WlNGY0FuU3Z3KytUdzJuQmRjM3dhaURiaXBPMUw5YVhu?=
 =?utf-8?B?cGlJdjUyR1FPMkpPUDNzUjJzZ0p2MmtSMlpuQVlENzMvM3M0VE1jbFRXR3Vu?=
 =?utf-8?B?NklsR1FCa0Y3K29GOWJiT0Z0ZnUxYnU5SlBYQy9FWG1WdSswWlBqVVc0QjdU?=
 =?utf-8?B?UEtic2s3alQ0bEpCWmc1SEthd0lZU2JYeTF4eThTSkFGUVNNSXA3UDZGQ3pu?=
 =?utf-8?B?ZmpndTQvaVZaT3liaExoSkd0MmJGVVhpUnNidUNhK254TFBnZ2NJOUdqM2FI?=
 =?utf-8?B?ZG9rVWh4TW8vZ1JhN3N4djZpenRCclNDdWNkMkE1S3Q5UW52TVdHNlpmTU9a?=
 =?utf-8?B?RVNIRnY0MGV5aWJhU3FlbVZEaFlETUxEUzIzS0ZTSVlzTWxNWlIyMFlXbDdI?=
 =?utf-8?B?R3F5SkR4SGxPdzNqeUVwVFdlK3l6T2RZdFkvbGdkRXkyMDZQS0xiSkRXa0Iy?=
 =?utf-8?B?NlpSRlNNekVrbE15ZUk4WHdxZk5jcEFuSEhtWGlFYW1LMStzZnNUcURjRkE4?=
 =?utf-8?B?Z3RUS0FDbkJlU3NSbnNzQm0vWHpaZ01DQnV0Y0dXRTJ4R2hTTi84TXY5WjlV?=
 =?utf-8?B?ZEpmdlFUcFNkWmNRenVDb3dGOHlIemlpdlBFZitQUWdoTjJZaHJwZ2ZVam5R?=
 =?utf-8?B?UDdIOFRKSStHMzRRRTlFcFVCRlp4ZzZpNTJWeExBYk9IRlFsOThFZzVkV2Ex?=
 =?utf-8?B?ZERhWWNkZVNuRGpNNlM5YWUvVnpaaGFFM2cwejZLYkNucFAxRHd1SmdTSUMy?=
 =?utf-8?B?U296YnBNbmNXc0lJUi9mTURtRlZYMU1tUUNRb0p6dVdlV1BNUmM3UEw3aDZH?=
 =?utf-8?B?cytNZFBBN2NQVnhJUWd3cFlVZkJWanJTbkRSb2tObmdsVmpxbjJqc2QxQTBj?=
 =?utf-8?B?azJqOTQyakVUUEZuL1lwL00zdVpTOWtMeEZTajQvYjg1WGFjUFp0MjV1Y3ph?=
 =?utf-8?B?V2NTZmlhMnF1ZkoybHFBR1NTc0lBUGZVbHlPdDhtMzdsNVR0ZUtacW5zQ0pE?=
 =?utf-8?B?UHJHM0MrR0p4Y3pkWUorV2NSTHQ0VjVYQlZhZ0tubndrZEFFWWtWNmxhYmdV?=
 =?utf-8?B?MUNxY3VIdjBYRmJ3dkc1MXlZcURkUFd6RmR3UnhxWGtLOGxjZG05WlpCY0xU?=
 =?utf-8?B?VUtHeW1oOUxSMm9UVGJzQjhrNUt5M0QvUzFVQkxrZzVXUHU2M0lrVGE4ZCt1?=
 =?utf-8?B?dE90ajFOQnR3R3VBU09xd1VkY1I4YitvbzdFNDdoSkt0Znd1L0MwNFdBWHEv?=
 =?utf-8?B?cmYrYW1vc3pHRm9RZVpSTWFFUDhFWk5OS0JrOWRaTUlCUlNnaVdUOXQzaFFm?=
 =?utf-8?B?K1lnOTRQYllSMFN0YzlnWjRma2s0eTFsSFpta1ErSVFmRi95WERNM2Z4RzV5?=
 =?utf-8?B?REg4alNCNjBMZ0JPenlKSEF4ajlLYW9mZnZZYlNkdlR0ZDJYVWVSRjA3ZUl0?=
 =?utf-8?B?THRKSisvVVVUT0JXQ3NEUXRRWFRtcWNuZlBhUm1wM1p4YTQzMzN1cXkzYk4w?=
 =?utf-8?B?K09RaHluK0dtL3BtOTdwd1JJMnR1VCtwVDBNcFgyaHlYdXVVMFNEb0kyODJD?=
 =?utf-8?B?RVh3dGhQdzRNMFFWaE5vRVVuRnBqbXBuZytlU3J2QjhPb0k3b2YxbmJncmhF?=
 =?utf-8?B?d1VDMjN6VUVXY1JRSE02TzJGdll1TnR4NjVWRElPWTNwWTV1cEM4WE40dmF2?=
 =?utf-8?B?ck4wQWlrNVZRMnpoQ0NYNE1TMDJrbFVmTEUyeGQzUkFLMFJrNnRySFMrZEg5?=
 =?utf-8?B?WmJ5dlZ6aEtNTlY4dnNaeE05UkpvZ0lkQWNYUGVkc1RBb2ZaNlJ1NnJ2OEQw?=
 =?utf-8?B?bnM1ME4weG9UeEZjQ28vRzB5SkZqcy9tUExrSmcvL0NQTnRoLzJsNFFtaldn?=
 =?utf-8?B?OXM2R2ZrZmlGWHVudHZwemh3S2Rzd3k3YW4xU3BGRWtHaUpRY1pWSDZUT1dt?=
 =?utf-8?B?OThlVkhpU0ZrYkpHVC9HU3FEMzBya0lrU3piWlZ6NXdZRmgyS0xqaVluSVBU?=
 =?utf-8?B?SzRJa2pmU0RlNHFONnYrb3JuWVN4cWNrWVllMjUwQXl5bUlwZzhlb2xBZG1z?=
 =?utf-8?B?dDJkc2YrUVpUWE9yQW9SUjVsbXhiOVRrSGFtdWJESzhIUVRzN3ZpUlNHUS85?=
 =?utf-8?Q?LnmSzdL8TVI5Z5SgXwQB8AB/PjR1x3z7vubkBRnPa4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A56E783369F704ABC810F1AD4794DD3@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86abfc16-126a-48cc-df4e-08d9fb5bd033
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 08:16:40.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTNIK4gooeYwRiShlyFAedXhkvYC0tb1JunUwqGdIlczeGxiZybmy6d+QU8SyE8A57+TC42Ee4GFnfv3bRbpr0xMlTz3qRFvITgl7ZteiTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2085
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDAxLzAzLzIwMjIgw6AgMDE6MzEsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSBhIMOpY3Jp
dMKgOg0KPiBPbiBUdWUsIE1hciAwMSwgMjAyMiBhdCAwNTozMDo0MUFNICswNTMwLCBBbnNodW1h
biBLaGFuZHVhbCB3cm90ZToNCj4+IE9uIDIvMjgvMjIgNDoyNyBQTSwgUnVzc2VsbCBLaW5nIChP
cmFjbGUpIHdyb3RlOg0KPj4+IE9uIE1vbiwgRmViIDI4LCAyMDIyIGF0IDA0OjE3OjMyUE0gKzA1
MzAsIEFuc2h1bWFuIEtoYW5kdWFsIHdyb3RlOg0KPj4+PiBUaGlzIGRlZmluZXMgYW5kIGV4cG9y
dHMgYSBwbGF0Zm9ybSBzcGVjaWZpYyBjdXN0b20gdm1fZ2V0X3BhZ2VfcHJvdCgpIHZpYQ0KPj4+
PiBzdWJzY3JpYmluZyBBUkNIX0hBU19WTV9HRVRfUEFHRV9QUk9ULiBTdWJzZXF1ZW50bHkgYWxs
IF9fU1hYWCBhbmQgX19QWFhYDQo+Pj4+IG1hY3JvcyBjYW4gYmUgZHJvcHBlZCB3aGljaCBhcmUg
bm8gbG9uZ2VyIG5lZWRlZC4NCj4+Pg0KPj4+IFdoYXQgSSB3b3VsZCByZWFsbHkgbGlrZSB0byBr
bm93IGlzIHdoeSBoYXZpbmcgdG8gcnVuIF9jb2RlXyB0byB3b3JrIG91dA0KPj4+IHdoYXQgdGhl
IHBhZ2UgcHJvdGVjdGlvbnMgbmVlZCB0byBiZSBpcyBiZXR0ZXIgdGhhbiBsb29raW5nIGl0IHVw
IGluIGENCj4+PiB0YWJsZS4NCj4+Pg0KPj4+IE5vdCBvbmx5IGlzIHRoaXMgbW9yZSBleHBlbnNp
dmUgaW4gdGVybXMgb2YgQ1BVIGN5Y2xlcywgaXQgYWxzbyBicmluZ3MNCj4+PiBhZGRpdGlvbmFs
IGNvZGUgc2l6ZSB3aXRoIGl0Lg0KPj4+DQo+Pj4gSSdtIHN0cnVnZ2xpbmcgdG8gc2VlIHdoYXQg
dGhlIGJlbmVmaXQgaXMuDQo+Pg0KPj4gQ3VycmVudGx5IHZtX2dldF9wYWdlX3Byb3QoKSBpcyBh
bHNvIGJlaW5nIF9ydW5fIHRvIGZldGNoIHJlcXVpcmVkIHBhZ2UNCj4+IHByb3RlY3Rpb24gdmFs
dWVzLiBBbHRob3VnaCB0aGF0IGlzIGJlaW5nIHJ1biBpbiB0aGUgY29yZSBNTSBhbmQgZnJvbSBh
DQo+PiBwbGF0Zm9ybSBwZXJzcGVjdGl2ZSBfX1NYWFgsIF9fUFhYWCBhcmUganVzdCBiZWluZyBl
eHBvcnRlZCBmb3IgYSB0YWJsZS4NCj4+IExvb2tpbmcgaXQgdXAgaW4gYSB0YWJsZSAoYW5kIGFw
cGx5aW5nIG1vcmUgY29uc3RydWN0cyB0aGVyZSBhZnRlcikgaXMNCj4+IG5vdCBtdWNoIGRpZmZl
cmVudCB0aGFuIGEgY2xlYW4gc3dpdGNoIGNhc2Ugc3RhdGVtZW50IGluIHRlcm1zIG9mIENQVQ0K
Pj4gdXNhZ2UuIFNvIHRoaXMgaXMgbm90IG1vcmUgZXhwZW5zaXZlIGluIHRlcm1zIG9mIENQVSBj
eWNsZXMuDQo+IA0KPiBJIGRpc2FncmVlLg0KDQpTbyBkbyBJLg0KDQo+IA0KPiBIb3dldmVyLCBs
ZXQncyBiYXNlIHRoaXMgZGlzYWdyZWVtZW50IG9uIHNvbWUgZXZpZGVuY2UuIEhlcmUgaXMgdGhl
DQo+IHByZXNlbnQgMzItYml0IEFSTSBpbXBsZW1lbnRhdGlvbjoNCj4gDQo+IDAwMDAwMDQ4IDx2
bV9nZXRfcGFnZV9wcm90PjoNCj4gICAgICAgIDQ4OiAgICAgICBlMjAwMDAwZiAgICAgICAgYW5k
ICAgICByMCwgcjAsICMxNQ0KPiAgICAgICAgNGM6ICAgICAgIGUzMDAzMDAwICAgICAgICBtb3Z3
ICAgIHIzLCAjMA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgNGM6IFJfQVJNX01PVldfQUJT
X05DICAgLkxBTkNIT1IxDQo+ICAgICAgICA1MDogICAgICAgZTM0MDMwMDAgICAgICAgIG1vdnQg
ICAgcjMsICMwDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICA1MDogUl9BUk1fTU9WVF9BQlMg
ICAgICAuTEFOQ0hPUjENCj4gICAgICAgIDU0OiAgICAgICBlNzkzMDEwMCAgICAgICAgbGRyICAg
ICByMCwgW3IzLCByMCwgbHNsICMyXQ0KPiAgICAgICAgNTg6ICAgICAgIGUxMmZmZjFlICAgICAg
ICBieCAgICAgIGxyDQo+IA0KPiBUaGF0IGlzIGZpdmUgaW5zdHJ1Y3Rpb25zIGxvbmcuDQoNCk9u
IHBwYzMyIEkgZ2V0Og0KDQowMDAwMDA5NCA8dm1fZ2V0X3BhZ2VfcHJvdD46DQogICAgICAgOTQ6
CTNkIDIwIDAwIDAwIAlsaXMgICAgIHI5LDANCgkJCTk2OiBSX1BQQ19BRERSMTZfSEEJLmRhdGEu
LnJvX2FmdGVyX2luaXQNCiAgICAgICA5ODoJNTQgODQgMTYgYmEgCXJsd2lubSAgcjQscjQsMiwy
NiwyOQ0KICAgICAgIDljOgkzOSAyOSAwMCAwMCAJYWRkaSAgICByOSxyOSwwDQoJCQk5ZTogUl9Q
UENfQUREUjE2X0xPCS5kYXRhLi5yb19hZnRlcl9pbml0DQogICAgICAgYTA6CTdkIDI5IDIwIDJl
IAlsd3p4ICAgIHI5LHI5LHI0DQogICAgICAgYTQ6CTkxIDIzIDAwIDAwIAlzdHcgICAgIHI5LDAo
cjMpDQogICAgICAgYTg6CTRlIDgwIDAwIDIwIAlibHINCg0KDQo+IA0KPiBQbGVhc2Ugc2hvdyB0
aGF0IHlvdXIgbmV3IGltcGxlbWVudGF0aW9uIGlzIG5vdCBtb3JlIGV4cGVuc2l2ZSBvbg0KPiAz
Mi1iaXQgQVJNLiBQbGVhc2UgZG8gc28gYnkgYnVpbGRpbmcgYSAzMi1iaXQga2VybmVsLCBhbmQg
cHJvdmlkaW5nDQo+IHRoZSBkaXNhc3NlbWJseS4NCg0KV2l0aCB5b3VyIHNlcmllcyBJIGdldDoN
Cg0KMDAwMDAwMDAgPHZtX2dldF9wYWdlX3Byb3Q+Og0KICAgIDA6CTNkIDIwIDAwIDAwIAlsaXMg
ICAgIHI5LDANCgkJCTI6IFJfUFBDX0FERFIxNl9IQQkucm9kYXRhDQogICAgNDoJMzkgMjkgMDAg
MDAgCWFkZGkgICAgcjkscjksMA0KCQkJNjogUl9QUENfQUREUjE2X0xPCS5yb2RhdGENCiAgICA4
Ogk1NCA4NCAxNiBiYSAJcmx3aW5tICByNCxyNCwyLDI2LDI5DQogICAgYzoJN2QgNDkgMjAgMmUg
CWx3enggICAgcjEwLHI5LHI0DQogICAxMDoJN2QgNGEgNGEgMTQgCWFkZCAgICAgcjEwLHIxMCxy
OQ0KICAgMTQ6CTdkIDQ5IDAzIGE2IAltdGN0ciAgIHIxMA0KICAgMTg6CTRlIDgwIDA0IDIwIAli
Y3RyDQogICAxYzoJMzkgMjAgMDMgMTUgCWxpICAgICAgcjksNzg5DQogICAyMDoJOTEgMjMgMDAg
MDAgCXN0dyAgICAgcjksMChyMykNCiAgIDI0Ogk0ZSA4MCAwMCAyMCAJYmxyDQogICAyODoJMzkg
MjAgMDEgMTUgCWxpICAgICAgcjksMjc3DQogICAyYzoJOTEgMjMgMDAgMDAgCXN0dyAgICAgcjks
MChyMykNCiAgIDMwOgk0ZSA4MCAwMCAyMCAJYmxyDQogICAzNDoJMzkgMjAgMDcgMTUgCWxpICAg
ICAgcjksMTgxMw0KICAgMzg6CTkxIDIzIDAwIDAwIAlzdHcgICAgIHI5LDAocjMpDQogICAzYzoJ
NGUgODAgMDAgMjAgCWJscg0KICAgNDA6CTM5IDIwIDA1IDE1IAlsaSAgICAgIHI5LDEzMDENCiAg
IDQ0Ogk5MSAyMyAwMCAwMCAJc3R3ICAgICByOSwwKHIzKQ0KICAgNDg6CTRlIDgwIDAwIDIwIAli
bHINCiAgIDRjOgkzOSAyMCAwMSAxMSAJbGkgICAgICByOSwyNzMNCiAgIDUwOgk0YiBmZiBmZiBk
MCAJYiAgICAgICAyMCA8dm1fZ2V0X3BhZ2VfcHJvdCsweDIwPg0KDQoNClRoYXQgaXMgZGVmaW5p
dGVseSBtb3JlIGV4cGVuc2l2ZSwgaXQgaW1wbGVtZW50cyBhIHRhYmxlIG9mIGJyYW5jaGVzLg0K
DQoNCkNocmlzdG9waGU=
