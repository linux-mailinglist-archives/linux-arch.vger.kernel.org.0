Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A1D6B2EB6
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 21:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCIU3z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 15:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCIU3o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 15:29:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE1828218;
        Thu,  9 Mar 2023 12:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678393780; x=1709929780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mkRgQk7fdVYMmXe5kdZ8p2BdplGn75dKeq+ItJbFBUQ=;
  b=ILnYWRBsjy1kSRwTg7zMs2CI/uA/AFo7xxcR14fNIx/lx/cFYMJ8bvsC
   F4gQ2xhk1ggbtk7kHnce6M5NDjmXcTwE7w91Y9Es3u/Fiiyk2Z7lCtHrv
   i3LjJjwDngUzDgEzplwy6hlnGcSV2a0jgceRWCelzF47/MBVOaWWWS+n2
   OThzjH7LAQA+DX+xqpHX286u7t3PEyIeVCfYJOLLwiPLLkcV8qjAq60N4
   JIec7bojlohyfzs7VEijod4WF/ZRWFs0LolfnMSOggzlQfVLrA3XUJR0Y
   K5AJanWd6f301ARUtDf/Z9LQKAfmKe9tzo8A8OBRU5GxyOGTqpXVMtgsX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="338926738"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="338926738"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 12:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="766570249"
X-IronPort-AV: E=Sophos;i="5.98,247,1673942400"; 
   d="scan'208";a="766570249"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Mar 2023 12:29:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 12:29:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 9 Mar 2023 12:29:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 9 Mar 2023 12:29:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 9 Mar 2023 12:29:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4x19bzoAjGnLn4OTUrZVLhpNW3dvCJBEMojWuflYuX4rYyWdS2hTs8bM9i7AVMy6mV5Tz14h6e/u3tBzar/4djoMFtnv6tmQl0Sd9n+1gzAAr0L0/3stpD5T06foYLHZqXcK5R9OhH+RMobYrbEKtxO5ZmifJy0Qmj6kunDHpT3pwdV4n01JfKODFDaVQauJqtQcLfkdWg8SRqAF+WHxA5YpGwKqBjEx/gEL2P4YDaTcZAfRWj5qxZGGlKAPfgBO53Z/X1t9FCLVMztGxAddy8H7o9qUqMs5+A3D61E6OA5nHp/evggBoAfUP3tLIl8GPNFjohpYO8YEEHkTbY/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkRgQk7fdVYMmXe5kdZ8p2BdplGn75dKeq+ItJbFBUQ=;
 b=CTtK3CVCzouSLEummHyPMghyEH09gl9h6Xoa30/OihbUTSeHo7Isdd4zPm6PkNrsVy5Ch/gxJ4bw+Y1K0Gtnd3bZNI9qxXncOQbQJ2v2+djw30z9Ih31RAD2sSvHZJRy7E9Ld+W4Eu65rqAHAcEhSd9DLyZm9cCR/XzcJTgk0wK7dDM09RJVRjouHF1oGbg1I/NsFg+F567p7xyIM6X3mrCLqKBSRwVQZ0XONlGV7Dhs4Zfn7RnTgIeW2PGGecu2+esaEFAo6XK5zLxtBGJHn7mcBS2qAbpomXbpcZ+WV1gtSZwPlgkh2I8a/Oa+V/hyql+wMkJtlOUmQEu+R8IekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BY1PR11MB8007.namprd11.prod.outlook.com (2603:10b6:a03:525::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 20:29:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 20:29:31 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Thread-Topic: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Thread-Index: AQHZSvtG+2WnM2cLTkqogSV10ayPpq7xDpwAgABNdwCAATBTgIAALsOAgAABb4CAADkjgA==
Date:   Thu, 9 Mar 2023 20:29:30 +0000
Message-ID: <c8b340708a5d5aac04ae9a16786c3a35637272c8.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-31-rick.p.edgecombe@intel.com>
         <ZAipCNBCtPA2bcck@zn.tnic>
         <d4d472e2e44787eccfbcc693bdf338370013f8a9.camel@intel.com>
         <ZAnpTYV55gbdROxx@zn.tnic>
         <5b0ce47840bf2f6747ebf722053f6b3c1f99bb64.camel@intel.com>
         <20230309170459.GGZAoRuxYy1zxwluev@fat_crate.local>
In-Reply-To: <20230309170459.GGZAoRuxYy1zxwluev@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BY1PR11MB8007:EE_
x-ms-office365-filtering-correlation-id: 5fc838aa-abcb-4fb8-effb-08db20dcfcaf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l0cuuDYQkAMrsjBT3zgwKLDWGMGZEyF6pJhGFwesnvfStj7B9kS01yqzEpXHZmg4gBWwa9m6P9ordY9lS3zS7+WlZP6uSe7e2A4UhmCtqxU1KmoYVh49zATZNYtlcPivLa7WAb/T3nDTxVZPO9aGduavUWr7ca1AzHoFi0WHdLpELS6blP9UuJ4rxdJlRZ+jMWiqWn6RKfRlMka4exKMKVf9nxBRJAQ42RZBd59BXle/AosHFV5vaYhToZMQC0oKYOsRwL/cMyjgZC/SiBLvV0RXVIPTFTEF9+NnUtb55sZNiKzY1KcHn2P9XjW6StLK51tpSmUMFnWvQmL2nOyrq4dg4Fud/rOaVwiMsUlhJq5iezumsvk9TbiWTpNbRRsOu5blClNr/9HGIlxGtEEcuUYxboror6tcQONjheo0JiKsfg2IyniIeWIP9OZuLlAAjBuUklGVukwdDRRO2DjoGBe7WsZp0AugaJTDc1HxJVFCypDZk50Noyk2YQLEMilSYwKHqpq5c1MmpVNUmps4CMwR02OFP2R8DKCOBBK0MogS6octUAu8rrcu4SdZza9VjkeP77dDZOl1AC+FqGvtdMDdOfUO3kkrMKFF+8zbMLs71Roo6N4tnu5IWy84JYnm5kxg48ZDyaO7dWOxWXEezftV8UOqMsKz2I8Zjr+9INQtUa5lT7McAUdI4WzrMKkFKgPDNoaIp0SSk7F+BWPL5DsyV6+fhm/4UoOehchCzTY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(82960400001)(6486002)(186003)(36756003)(478600001)(122000001)(38070700005)(54906003)(86362001)(38100700002)(316002)(71200400001)(6512007)(6506007)(41300700001)(2616005)(26005)(66556008)(7416002)(4744005)(5660300002)(7406005)(76116006)(91956017)(66946007)(8936002)(64756008)(2906002)(66476007)(66446008)(4326008)(6916009)(8676002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDNudzV1Y1pFc2lZNHNieFhQQzhrZUtiYWxtMjI0OUZodlpQUW5xekhXcTFW?=
 =?utf-8?B?UG9uSjlrclI2Ump0Um1DODFVN2NONlg4VHk3ZlcrMktZKzhSR0pOWENod3Bz?=
 =?utf-8?B?ZS9jb3I2elhGanpVQjRxY2dhWVptN0l2Q2RyWUJld1pZL1cwS1dEYVYydHdn?=
 =?utf-8?B?YWN1VTdBK3RXL2o0c0QwUjBVT1lMTzlEOUc2RkFhazd2MGk2VmJ5blNVMTQx?=
 =?utf-8?B?NGlGcTRpZStjUHdYWkNkT1hWaUVvNklRM1U3VG9xQ0ZvUVdaT29tSU9kMG1w?=
 =?utf-8?B?MHFIQ3lNZnRjN041VDdnNDhDdWZ1TVB5UzU0UDB1MGwrdWZteTIxR29nVEVr?=
 =?utf-8?B?enUzTURXbWs1Z3FZYnNhVmVZb0RJZzBUUTJvU1N0YzNObDMvaitEREcxdDZh?=
 =?utf-8?B?cEQ0WHRkcWpINDFqbzN4Unk1SG5wemZNZFJtbnRRWlZlTTVWVExKOStNUHFS?=
 =?utf-8?B?YURCRTB0SzZFMklWdzBPWXY5TGlCVHBEWnMxT1YvRnhrSmJCL0JDZFhVSGIy?=
 =?utf-8?B?azdHUEtnMGdzVit3a3ZBK09XakVVN2Y3aWJ4cXlJSzhHQUN6NEIwb29qZzI1?=
 =?utf-8?B?bDkvUDBhcTBwNzR2SWtyRW5ZS3RJZmkxWnIxbndmTnNGU1hiOTZJLzM3SXhZ?=
 =?utf-8?B?ZXU1MDYvejI2U3crcUdSZzN0ekhiMG1QUDJDay9id1dxYkNFODFUMFlwZG5G?=
 =?utf-8?B?SU5jOGIwYkdjQ2tkTUJiY0JIUWNMQWZUQXN3WmdhU0dxTStPZGFJendJYVhR?=
 =?utf-8?B?Z0NWZmdLZzZNU2JyTmFVRkhkcUYyMlFKazVSQmZuNStnSEhpZjlHazJpZ3dm?=
 =?utf-8?B?TXN5VTEvWSsrUDBNSFZrakFjZ2pNNGZxWXczVG9hSkZwRVFZc1hFZk01WTZU?=
 =?utf-8?B?aEYzNldjVm5qNmNIa3BSUUF6cHRrTFBDVTcyUTlLNmdwSkZ6Y2VZVHg1NitQ?=
 =?utf-8?B?ZWtYUmdJbFJzeGZxdTgrWkFuSUc2UlZ2YityU09NbXN3dzVha1V2WWFiNmJJ?=
 =?utf-8?B?bzl1V0VrZ3J3N0tNK3hDMHVRZ1hKRHJyeWcybHdpUnBpQ3loeGtFUE0zRHoy?=
 =?utf-8?B?QWRGaGhoK0luQTdBU0tDVFljalMreWxUK1hWUTROVVNuOFRSOW5pODN2S1dY?=
 =?utf-8?B?RE8vQTRneVRFMjBrQ01nTDY2djRHMjFEWmwycEozUmhPTXRYNTlaRVAybnFT?=
 =?utf-8?B?M1oydWJzWVJQYmlFa2xZOUVkeFZFTThTdDd3bjhZaUxVMWFYeTJORFdZWk9y?=
 =?utf-8?B?ajNzUmppa3FUb2VjejUxOU5qVEhpK3FoT3VwZHl3VlEzV0N6bS9OcklqWVF6?=
 =?utf-8?B?aGZkSklQOVpjaXJXK0pxVGppVEVDNUFrUkZKdUcxY2lIS1FDNjRnZ2JSSDNU?=
 =?utf-8?B?Zkszb1pzK24vR0NGUE1oMzQ1d2ZiVE81aHVhRXQ0ZEo4R2ZlNDhabVZ5Nmw3?=
 =?utf-8?B?SHlQSTJWK0NvaWFRU3o3Q3E5ZnhlYnFyUXdmTGxmQmNqMERJWlA1bDEzWDJh?=
 =?utf-8?B?K3UyVndGN3ZyWkpTWHRuTDF2SDV1anQ3UDJ5azk0MkxmTVJRYWMyckczMHY0?=
 =?utf-8?B?MGIraWxPOW94UEdnZXVjanZUUFgvQTlMcXBWakIrRmNkakEramowREdaYXo0?=
 =?utf-8?B?QXU2ZUIwckI5WWJLcDlIWUI1RFIzV0prVU1WMlM5NFByNnRUN3RWeTRRQ1JY?=
 =?utf-8?B?S1hvcDVpYXZMNlZoY25ZYTNTTStBN0lGQkdZTlloQW5XczNscHQ3K2NsSldF?=
 =?utf-8?B?RGV6WUltMTBqTGFZdUhvODErM1VrZVk3Wm1Tc3JZbVZJQytHZUd6ekhMVmE4?=
 =?utf-8?B?U3JVdkxqdUNzRmhRRTdORjNWSjFaalFjZ0UxZ0FUWWNUWXFKRWNHZmxRb2Vk?=
 =?utf-8?B?Uzg3YXU2ak5SVjBWRnpTT2VHRTZBT2tSWVl2SWZHbkQrbUhnYll4T3ZoWC9D?=
 =?utf-8?B?YW8yYUpPR2krS3RDZVdYNDVJSnVRdWNzNE4wR0Y3UGhaSnhYN2huemxQa0hP?=
 =?utf-8?B?WnFkbmlGNmhZZW85UC9vNXFranhBc0pRWlM3TThwdlovbm1vZFRQL2o3eHpr?=
 =?utf-8?B?ZFYxcG8xRU00QXUxQmhncVptU25zaFpLRzNPYWsxNGlvVDBUQW05WnA0VTBh?=
 =?utf-8?B?TU1Da1pzVm8wb0FQM2ZsY2NIMzRLckM1aVVuYVVzeVBiNlhPYzd4VVVaRkRI?=
 =?utf-8?Q?D09s5FtMFbNLGA4EfXvdKsA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A4E778F4A96634E94B2E7C4C6F01290@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc838aa-abcb-4fb8-effb-08db20dcfcaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 20:29:30.6714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yln3gfg1LOC3b2Jtz1JoFjQTB4xZryMwbrpzpWiNeTMQtcSVBvfbAY7nTG3bXYFIA0O8gx00P4ctvHxSGD5R6FKTlihPCO3xPZPck/vhHvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8007
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTA5IGF0IDE4OjA0ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIFRodSwgTWFyIDA5LCAyMDIzIGF0IDA0OjU5OjUyUE0gKzAwMDAsIEVkZ2Vjb21iZSwg
UmljayBQIHdyb3RlOg0KPiA+IEFoLCBJIHNlZSB3aGF0IHlvdSB3ZXJlIHNheWluZyBub3cuIEl0
IGxvb2tzIGxpa2UgaXQgd2lsbCB3b3JrIHRvDQo+ID4gbWUgaWYNCj4gPiB5b3UgdGhpbmsgaXQg
aXMgYmV0dGVyIHN0eWxpc3RpY2FsbHkuDQo+IA0KPiBZZWFoLCBoYXZpbmcgYSBmdW5jdGlvbiBy
ZXR1cm4gYW4gZXJyb3IgKmFuZCogYW4gSS9PIHBhcmFtZXRlciBhdCB0aGUNCj4gc2FtZSB0aW1l
IGlzIG1vcmUgY29tcGxpY2F0ZWQgYW5kIGVycm9yIHByb25lIGluc3RlYWQgb2Ygd2hlbiB5b3UN
Cj4gaGF2ZQ0KPiBhIHNpbmdsZSByZXR2YWwgYW5kIG9ubHkgaW5wdXQgcGFyYW1ldGVycy4NCj4g
DQo+IEknZCBzYXkuDQoNClllYSwgSSBhZ3JlZSBpdCdzIGJldHRlciB0aGlzIHdheSwgYW5kIGF0
IGZpcnN0IEkganVzdCBtaXNzZWQgeW91cg0KcG9pbnQuIEJ5ICJpZiB5b3UgdGhpbmsgaXQncyBi
ZXR0ZXIiLCBJIGp1c3QgbWVhbnQgdGhhdCBpZiBzb21lb25lIHRvbGQNCm1lIHRvIGRvIGl0IHRo
ZSBvdGhlciB3YXkgSSB3b3VsZG4ndCBkaWUgb24gdGhlIGhpbGwuDQo=
