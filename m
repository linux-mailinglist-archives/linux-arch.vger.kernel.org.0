Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130415F4BB6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 00:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJDWOx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 18:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiJDWN6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 18:13:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A95BC2B;
        Tue,  4 Oct 2022 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664921636; x=1696457636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qrv3I8sm9U72PjPCOb1s/zhrsBderPOXJm4zDXfRu/o=;
  b=EG2VxSTAAN0/hXrs5UjrvMjuC7E87QMftgolEFeq1jZWq6e/MZsg5GAS
   5q2ttfiWhOgvTbFW+onxki0HsfKBORoms6EhyzOKuUv98CbYQTBk5dma5
   LAc/jLUgziOWXQCaaA88yUKkBfTa9jVhJnhFJQjRt66+1Hr40DGkvFcRw
   GWRKa3Pwi7sdiosTAKCBFPgTOYRNEJ2Odw5R8hcfcCi4xexd43Ro/JbAn
   LNIIW+9IOgntGx8xmJAkPSiJHSrhBlCIQmNv+eHoSrW4Du4q6Zcxnt2/f
   ILJZZOw3gGaFH2isxKnxXLdCx47NMVfcdy9RAzhgheQsZJZy0RY8We4af
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="389329912"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="389329912"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 15:13:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="766525076"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="766525076"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 04 Oct 2022 15:13:55 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 15:13:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 15:13:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 15:13:54 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 15:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyCXXyg+Oc9+tRuQG6DkNMOpZa14Ap1fm+khcMl6bU5TpNSy91JTSyJpYPhHHKT9DQfpMlatAtteog3JC8/LvWX6miZKOW2r7M9kgyPmy09qWyc02KJsjUdLlaBFr5bFALgUKjZDwaff8EazPoGVUUoD7vGRZSuQoXxNAo8I031ITyS7yKDUcKW0iC7YGOK2z+k5iWIa96HficXMzduii9uJEGHWCLbuLR7W+kJgX98IgRiK8FXe4CR6kY4v2AThvakcFb1c6FYcvq/UsBim36mYyxDzAaLrIpZwbvnKCuwroORpPV2J4Z2b98hKh6MEocCiohR+mItHDpN8MQpdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrv3I8sm9U72PjPCOb1s/zhrsBderPOXJm4zDXfRu/o=;
 b=GJ4idht1guzP5Jtf7P5M58bduwqlBViitusBlRMinAJh7rgiiNtpS+b1oRl9y0EeUlnkh8ayMaEzB7QUnNahCP1YjkdEPLfBtbcm46cEHHBPQGT9McnaDo97bJroVlqq21u1B3wMXm3Z1g0fl/bDX4gjtZae1yvJZ0IofNVYfhN2eDzBP/e0bHsZXQCF5y/ZlZmdOlldWF3/1nVdXlThD0Qo3Hj22F7YuiKcXeISugIgct4ZWkrUpmetwkunoNMlanu98epkRmMxdI7AGEYjyzYBajdfIWL2q4nbXtEkEbyAQAKhoU1b1G/PUi2mgdgSTDb+45sDwPl9Ubi4zEocgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 22:13:51 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 22:13:51 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Topic: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Index: AQHY1FMi0mGJj2nvSk6XePU1fP3/w639KRqAgAGraoA=
Date:   Tue, 4 Oct 2022 22:13:51 +0000
Message-ID: <e9271515f40ef1350cb8b365cc3665da9ea14f5e.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-27-rick.p.edgecombe@intel.com>
         <202210031330.3C9F7E4E@keescook>
In-Reply-To: <202210031330.3C9F7E4E@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4759:EE_
x-ms-office365-filtering-correlation-id: 2205e4bd-75ee-4248-d081-08daa655b80f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKjouarPV3kzh3xgq6WmDikOm7uINB8O6uVAdhArw++bQEphnJGHBO8/hXmonUcUQsZdMC/nLVzS0HILWci9jLDAEo6GOqAu4FIoTgvjbzZRIbi9/7rvaITos4cHjDacGhgzo1XEHKLalwiEneJPf6Vn3C3Q1VlenVJQTyXKB1QaQnOcj/JwDyEkpTSKll0sGZPm++MRosq8Gz4vqOHMCU0AfVVf1JNiAB9fREVcjlNTVBM8oedYauNmPEMgLS6aQY/DTGPolXIgx6SfAlc0SUENbUPiC9m0f4LwZg0AW8GIJgO0JVaxpv7bMpYUhBYqxf4CkwxxOZxbflZif46oYPlz9Vq9WtS+8QIwTS2EhzxmWFBCwVednGCZsihOtMc8iIYBMd+z04cdx8lPr2yh4vLA7iNvYCgNycy76XJ+SDKIyMzGOt2JmuKRVdDR6pWUrI/41KTunyyNO2xsw2HEti7BZP7EFnRPHg/5JgDhV6gQhoNCeBVFmZS7z/cUwuCAC4IaywfFLAbQrMAjWgy3bB7pTv2R3v8Rnh4Trg1IoGCNZtXMHj0moytoaObFinGw0jql5c8Q/cr/DQ99z+kcHtaqJQLHJLrMEvmKwgxxT0Pc4FxP5kSJbh5Rj+PF6AMzgfln69+R5UoN/L1i4rkprvKK5SrtSFz8ZT4CkcDThHRvxKW5QfFrvMpn8abSCEmm2/k6gJAMTsoMfOKfWAYn89cyLCLf6gvqUWP+IHtdyvpOmTHsT2ubL+YtluZ3aNLk6+1Ru4ZmFEDpclxUul6vZuDMhCfHE7XRTbz9yxFR4StjMGZQRHAEYp4mF029bgoV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(86362001)(7406005)(7416002)(8936002)(2906002)(5660300002)(41300700001)(82960400001)(186003)(38100700002)(66946007)(316002)(76116006)(122000001)(54906003)(66476007)(38070700005)(91956017)(66556008)(4326008)(8676002)(64756008)(66446008)(6916009)(6486002)(478600001)(6506007)(83380400001)(71200400001)(6512007)(26005)(2616005)(36756003)(99106002)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MURPQ1hYeHJBZXlrdTlib0hyckFGdmtrUGx4dDMvRFMrQjMxa1JEckNkQmda?=
 =?utf-8?B?TEpPblF5ejFKVmh6RTNnaVYybWJJNFZIbDRRUHUwRjg0d3lBdlpSWDA2SnJW?=
 =?utf-8?B?SDhSL0Z6MUl3ajB4TG0xbU9aNkw0MS81TEMxaXR6eDJBVnA4ZGxnVGdGZE5j?=
 =?utf-8?B?NUt6RzBVUHk3SGJsbjJESUdSZzhTVVQ1NmRsSWxQOUpNcC9DeC9Lc2t5aEpR?=
 =?utf-8?B?QVJGZVY0dDZBTFZZRTBmdDQ4YnA2V2pldVpSMGZaa0VIQ3hiSTE4VlBZV2k5?=
 =?utf-8?B?NklvaGdKTlpJeFcwcWc2a3NzaVFBZDNiazNoenhrUldUbWtsR2ZleXFEaGpN?=
 =?utf-8?B?N2FGQ055L0kvelBUNGk0VlpWMGVUdHZkVTJKQmw1KzJQQ3FMeEZ0MnVJV2lM?=
 =?utf-8?B?Y1dtTHE2eHl5MXBNTlltWlR5OWRnS3d4OVg0eC9PNU1jek5xdGNjYmk1cjVt?=
 =?utf-8?B?M0dhQ01raXArZWQ0ZUZyV08vcHBEN3lvOS9lZDl5azJXK1FsZjgyd1lBcmhM?=
 =?utf-8?B?YUM2djVrMzJzdVhwdHN1cWNwQVZMQlVTb29hZ2ltR3d3S1JocWhjK05tdGFl?=
 =?utf-8?B?azNYa0dUckY5K1ZxZkV1Q29LQWtmWlVKbXNRaTB3RGVtZXBTN1JHbGQwSVV5?=
 =?utf-8?B?cm1ZREhGbmtFcUVVdHNPa2NrSldNWlNpeHNqNEc1eVRsYVpvbXg0ekIzNnFW?=
 =?utf-8?B?Q0tSYTBJaEpVTm5tS2h2c0lCaDA5T0lTK0ZZbmNRWFNOdDYwQS9jK2NIUDF0?=
 =?utf-8?B?ckxzbFJ6MitKVldGS0FGWlFJWnQzS1MreFdIRHRQenN3TDhYblV2MG9raVdC?=
 =?utf-8?B?TVpDN0xwTXNjL20raVN0RHdDWTJJQnQzdUQwSzFhUFkrUFNGMkJrZzB3VXhL?=
 =?utf-8?B?eG9kQTAraW9mbU1vMjRXd1I2bjJwVVJ1bTR1a0lpVlJRb1d1SlE5VWJ6cTJ5?=
 =?utf-8?B?YzNuN2RtclZZZ0EvTVhjcEpWbDJPWlRyeTBhRHh0QlFRYWRJMmViSUdFWFJY?=
 =?utf-8?B?ZDdlaVVPVk9ub256NEppczRjeWxjWUwyOVlNTmNJT3M0Q2hvRGlUZWh3UEsw?=
 =?utf-8?B?dkJVQU1uc2FFd1RFcVdpVzkxYUNqLzZzOGN3WWFGNFAyeXgwTDc4cTBsclUw?=
 =?utf-8?B?ZW05M0FMSWY4ajZnUnIrTTc0YVptYmpJZ0dGeldiUjdjcU1jSGl0MlBlaS9u?=
 =?utf-8?B?VzJ0TCtCRGp5SEZxMkNOV1BzdkRJSmc0R01XRFRiZFdGYXdFZ3cvZEhCWks1?=
 =?utf-8?B?Tm9tRVRaZ0c5WkVKMEJYblBzcE5PTXR5TCtZZ1R2VVFhblg4aHV5YWtQNDhw?=
 =?utf-8?B?bkhwS01TREZ6NEFpQThxUWRySWJMT1FWdWk1N3M2VG14WjRadjJCRHV6blZs?=
 =?utf-8?B?SGllZk1DKzVrVE9WSmJ0RGMwYVFna1czY1g5NUExVVUrQXVpZWJPWWVDUXkr?=
 =?utf-8?B?Q2hsRGUxc3ZUdVR5MzZRaFFoT2JabmI0amVpam5BM1QvUUdlR1M1clRjS0tK?=
 =?utf-8?B?bWZuZkxrK2k5RUNxUW5MRERzeDBYY1ZDbjFxL3FPMUppTk4wMStiSFY0dGtz?=
 =?utf-8?B?d0RyaGp3VmZHQWFxZnpVZU9vanhHYnd1NXdkOXFya3EzSDU0eCttSXNWRUdX?=
 =?utf-8?B?bmR6UjgwQ0FKMUE3bXBMK25MaHJMRHhTNDg1SUx1L1JZeGo0V2d5Z2doQ2Mr?=
 =?utf-8?B?WWZqck1DQTF1QnllNnV4NXpuVFRPNk15bUt5SXJlanZuem9BdE9SVm5vRW1B?=
 =?utf-8?B?d2x2cmN0dGxGOTNMSGlNbnZBMjU3QzVjRnVCWUVybExvc3NSRUJkc08xZWtE?=
 =?utf-8?B?QmlJR0tIYm5QQnhVcko5TEVzN3NxLzVwRk1sZ0cyVmUvT1EvQW1QUVhrUDNJ?=
 =?utf-8?B?eU1NNkRqTVBlREliemRTWGVKeGxKR2c3dldZekNHNWVPUFEzNGlmSGp2MVFr?=
 =?utf-8?B?aTFkMlUyZ08yWmpEQXk4c0lLSGtVUlo3eWk2c0Z1eWRVT3VQMkx4cnJUbGVy?=
 =?utf-8?B?dlFjN3JXdFdYbEU5Wml1NTlwdzg1am16NGlTb294Zlo1d3dVOVhqZDhnUmtl?=
 =?utf-8?B?UzFWRGZVcVFTSGh1RU5uT25RVmFuVkdmVldTNTVhb3R5V28yTmswWStYb09q?=
 =?utf-8?B?K1dUMTZlQUEyU1V4NG1CbWx5S1E2TVI2Y044WjRZL0diYXk2a0RmUThNQ2tY?=
 =?utf-8?Q?EQIqfiBgLA7IWStyP2FNAAk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D2B1A10CCA6074EB856FA22426997C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2205e4bd-75ee-4248-d081-08daa655b80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 22:13:51.6665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8IFZ6uQEXjlce/3mQWBKziSAO0ebHP1KsxGjDNLMi7+AsLUjXyiMU+G5SYpHscKw2I4ZroN/IXBBe1VFVV69fhZdNHeVMXZPx7jAIeSVs80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDEzOjQ0IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgU2VwIDI5LCAyMDIyIGF0IDAzOjI5OjIzUE0gLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IEZyb206IFl1LWNoZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+ID4g
DQo+ID4gU2hhZG93IHN0YWNrJ3MgYXJlIG5vcm1hbGx5IHdyaXR0ZW4gdG8gdmlhIENBTEwvUkVU
IG9yIHNwZWNpZmljIENFVA0KPiA+IGluc3R1Y3Rpb25zIGxpa2UgUlNUT1JTU1AvU0FWRVBSRVZT
U1AuIEhvd2V2ZXIgZHVyaW5nIHNvbWUgTGludXgNCj4gPiBvcGVyYXRpb25zIHRoZSBrZXJuZWwg
d2lsbCBuZWVkIHRvIHdyaXRlIHRvIGRpcmVjdGx5IHVzaW5nIHRoZQ0KPiA+IHJpbmctMCBvbmx5
DQo+ID4gV1JVU1MgaW5zdHJ1Y3Rpb24uDQo+ID4gDQo+ID4gQSBzaGFkb3cgc3RhY2sgcmVzdG9y
ZSB0b2tlbiBtYXJrcyBhIHJlc3RvcmUgcG9pbnQgb2YgdGhlIHNoYWRvdw0KPiA+IHN0YWNrLCBh
bmQNCj4gPiB0aGUgYWRkcmVzcyBpbiBhIHRva2VuIG11c3QgcG9pbnQgZGlyZWN0bHkgYWJvdmUg
dGhlIHRva2VuLCB3aGljaA0KPiA+IGlzIHdpdGhpbg0KPiA+IHRoZSBzYW1lIHNoYWRvdyBzdGFj
ay4gVGhpcyBpcyBkaXN0aW5jdGl2ZWx5IGRpZmZlcmVudCBmcm9tIG90aGVyDQo+ID4gcG9pbnRl
cnMNCj4gPiBvbiB0aGUgc2hhZG93IHN0YWNrLCBzaW5jZSB0aG9zZSBwb2ludGVycyBwb2ludCB0
byBleGVjdXRhYmxlIGNvZGUNCj4gPiBhcmVhLg0KPiA+IA0KPiA+IEludHJvZHVjZSB0b2tlbiBz
ZXR1cCBhbmQgdmVyaWZ5IHJvdXRpbmVzLiBBbHNvIGludHJvZHVjZSBXUlVTUywNCj4gPiB3aGlj
aCBpcw0KPiA+IGEga2VybmVsLW1vZGUgaW5zdHJ1Y3Rpb24gYnV0IHdyaXRlcyBkaXJlY3RseSB0
byB1c2VyIHNoYWRvdyBzdGFjay4NCj4gPiANCj4gPiBJbiBmdXR1cmUgcGF0Y2hlcyB0aGF0IGVu
YWJsZSBzaGFkb3cgc3RhY2sgdG8gd29yayB3aXRoIHNpZ25hbHMsDQo+ID4gdGhlIGtlcm5lbA0K
PiA+IHdpbGwgbmVlZCBzb21ldGhpbmcgdG8gZGVub3RlIHRoZSBwb2ludCBpbiB0aGUgc3RhY2sg
d2hlcmUNCj4gPiBzaWdyZXR1cm4gbWF5IGJlDQo+ID4gY2FsbGVkLiBUaGlzIHdpbGwgcHJldmVu
dCBhdHRhY2tlcnMgY2FsbGluZyBzaWdyZXR1cm4gYXQgYXJiaXRyYXJ5DQo+ID4gcGxhY2VzDQo+
ID4gaW4gdGhlIHN0YWNrLCBpbiBvcmRlciB0byBoZWxwIHByZXZlbnQgU1JPUCBhdHRhY2tzLg0K
PiA+IA0KPiA+IFRvIGRvIHRoaXMsIHNvbWV0aGluZyB0aGF0IGNhbiBvbmx5IGJlIHdyaXR0ZW4g
YnkgdGhlIGtlcm5lbCBuZWVkcw0KPiA+IHRvIGJlDQo+ID4gcGxhY2VkIG9uIHRoZSBzaGFkb3cg
c3RhY2suIFRoaXMgY2FuIGJlIGFjY29tcGxpc2hlZCBieSBzZXR0aW5nIGJpdA0KPiA+IDYzIGlu
DQo+ID4gdGhlIGZyYW1lIHdyaXR0ZW4gdG8gdGhlIHNoYWRvdyBzdGFjay4gVXNlcnNwYWNlIHJl
dHVybiBhZGRyZXNzZXMNCj4gPiBjYW4ndA0KPiA+IGhhdmUgdGhpcyBiaXQgc2V0IGFzIGl0IGlz
IGluIHRoZSBrZXJuZWwgcmFuZ2UuIEl0IGlzIGFsc28gY2FuJ3QgYmUNCj4gPiBhDQo+ID4gdmFs
aWQgcmVzdG9yZSB0b2tlbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdS1jaGVuZyBZdSA8
eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPiA+IENvLWRldmVsb3BlZC1ieTogUmljayBFZGdlY29t
YmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2sg
RWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiBDYzogS2VlcyBDb29r
IDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+ID4gDQo+ID4gLS0tDQo+ID4gDQo+ID4gdjI6DQo+
ID4gIC0gQWRkIGRhdGEgaGVscGVycyBmb3Igd3JpdGluZyB0byBzaGFkb3cgc3RhY2suDQo+ID4g
DQo+ID4gdjE6DQo+ID4gIC0gVXNlIHhzYXZlIGhlbHBlcnMuDQo+ID4gDQo+ID4gWXUtY2hlbmcg
djMwOg0KPiA+ICAtIFVwZGF0ZSBjb21taXQgbG9nLCByZW1vdmUgZGVzY3JpcHRpb24gYWJvdXQg
c2lnbmFscy4NCj4gPiAgLSBVcGRhdGUgdmFyaW91cyBjb21tZW50cy4NCj4gPiAgLSBSZW1vdmUg
dmFyaWFibGUgJ3NzcCcgaW5pdCBhbmQgYWRqdXN0IHJldHVybiB2YWx1ZSBhY2NvcmRpbmdseS4N
Cj4gPiAgLSBDaGVjayBnZXRfdXNlcl9zaHN0a19hZGRyKCkgcmV0dXJuIHZhbHVlLg0KPiA+ICAt
IFJlcGxhY2UgJ2lhMzInIHdpdGggJ3Byb2MzMicuDQo+ID4gDQo+ID4gWXUtY2hlbmcgdjI5Og0K
PiA+ICAtIFVwZGF0ZSBjb21tZW50cyBmb3IgdGhlIHVzZSBvZiBnZXRfeHNhdmVfYWRkcigpLg0K
PiA+IA0KPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmggfCAgMTMgKysr
Kw0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYyAgICAgICAgICAgICAgfCAxMDgNCj4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMjEgaW5z
ZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9z
cGVjaWFsX2luc25zLmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMu
aA0KPiA+IGluZGV4IDM1ZjcwOWY2MTlmYi4uZjA5NmY1MmJkMDU5IDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPiA+ICsrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPiA+IEBAIC0yMjMsNiArMjIzLDE5IEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBjbHdiKHZvbGF0aWxlIHZvaWQgKl9fcCkNCj4gPiAgCQk6IFtwYXhd
ICJhIiAocCkpOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9TSEFET1df
U1RBQ0sNCj4gPiArc3RhdGljIGlubGluZSBpbnQgd3JpdGVfdXNlcl9zaHN0a182NCh1NjQgX191
c2VyICphZGRyLCB1NjQgdmFsKQ0KPiA+ICt7DQo+ID4gKwlhc21fdm9sYXRpbGVfZ290bygiMTog
d3J1c3NxICVbdmFsXSwgKCVbYWRkcl0pXG4iDQo+ID4gKwkJCSAgX0FTTV9FWFRBQkxFKDFiLCAl
bFtmYWlsXSkNCj4gPiArCQkJICA6OiBbYWRkcl0gInIiIChhZGRyKSwgW3ZhbF0gInIiICh2YWwp
DQo+ID4gKwkJCSAgOjogZmFpbCk7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArZmFpbDoNCj4gPiAr
CXJldHVybiAtRUZBVUxUOw0KPiA+ICt9DQo+ID4gKyNlbmRpZiAvKiBDT05GSUdfWDg2X1NIQURP
V19TVEFDSyAqLw0KPiA+ICsNCj4gPiAgI2RlZmluZSBub3AoKSBhc20gdm9sYXRpbGUgKCJub3Ai
KQ0KPiA+ICANCj4gPiAgc3RhdGljIGlubGluZSB2b2lkIHNlcmlhbGl6ZSh2b2lkKQ0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYyBiL2FyY2gveDg2L2tlcm5lbC9zaHN0
ay5jDQo+ID4gaW5kZXggZGI0ZTUzZjlmZGFmLi44OTA0YWVmNDg3YmYgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC94ODYva2VybmVsL3Noc3RrLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2hz
dGsuYw0KPiA+IEBAIC0yNSw2ICsyNSw4IEBADQo+ID4gICNpbmNsdWRlIDxhc20vZnB1L2FwaS5o
Pg0KPiA+ICAjaW5jbHVkZSA8YXNtL3ByY3RsLmg+DQo+ID4gIA0KPiA+ICsjZGVmaW5lIFNTX0ZS
QU1FX1NJWkUgOA0KPiA+ICsNCj4gPiAgc3RhdGljIGJvb2wgZmVhdHVyZV9lbmFibGVkKHVuc2ln
bmVkIGxvbmcgZmVhdHVyZXMpDQo+ID4gIHsNCj4gPiAgCXJldHVybiBjdXJyZW50LT50aHJlYWQu
ZmVhdHVyZXMgJiBmZWF0dXJlczsNCj4gPiBAQCAtNDAsNiArNDIsMzEgQEAgc3RhdGljIHZvaWQg
ZmVhdHVyZV9jbHIodW5zaWduZWQgbG9uZyBmZWF0dXJlcykNCj4gPiAgCWN1cnJlbnQtPnRocmVh
ZC5mZWF0dXJlcyAmPSB+ZmVhdHVyZXM7DQo+ID4gIH0NCj4gPiAgDQo+ID4gKy8qDQo+ID4gKyAq
IENyZWF0ZSBhIHJlc3RvcmUgdG9rZW4gb24gdGhlIHNoYWRvdyBzdGFjay4gIEEgdG9rZW4gaXMg
YWx3YXlzDQo+ID4gOC1ieXRlDQo+ID4gKyAqIGFuZCBhbGlnbmVkIHRvIDguDQo+ID4gKyAqLw0K
PiA+ICtzdGF0aWMgaW50IGNyZWF0ZV9yc3Rvcl90b2tlbih1bnNpZ25lZCBsb25nIHNzcCwgdW5z
aWduZWQgbG9uZw0KPiA+ICp0b2tlbl9hZGRyKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBsb25n
IGFkZHI7DQo+ID4gKw0KPiA+ICsJLyogVG9rZW4gbXVzdCBiZSBhbGlnbmVkICovDQo+ID4gKwlp
ZiAoIUlTX0FMSUdORUQoc3NwLCA4KSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+
ID4gKwlhZGRyID0gc3NwIC0gU1NfRlJBTUVfU0laRTsNCj4gPiArDQo+ID4gKwkvKiBNYXJrIHRo
ZSB0b2tlbiA2NC1iaXQgKi8NCj4gPiArCXNzcCB8PSBCSVQoMCk7DQo+IA0KPiBXb3csIHRoYXQg
Y29uZnVzZWQgbWUgZm9yIGEgbW9tZW50LiA6KSBTREUgc2F5czoNCj4gDQo+IC0gQml0IDYzOjIg
4oCTIFZhbHVlIG9mIHNoYWRvdyBzdGFjayBwb2ludGVyIHdoZW4gdGhpcyByZXN0b3JlIHBvaW50
DQo+IHdhcyBjcmVhdGVkLg0KPiAtIEJpdCAxIOKAkyBSZXNlcnZlZC4gTXVzdCBiZSB6ZXJvLg0K
PiAtIEJpdCAwIOKAkyBNb2RlIGJpdC4gSWYgMCwgdGhlIHRva2VuIGlzIGEgY29tcGF0aWJpbGl0
eS9sZWdhY3kgbW9kZQ0KPiAgICAgICAgICAg4oCcc2hhZG93IHN0YWNrIHJlc3RvcmXigJ0gdG9r
ZW4uIElmIDEsIHRoZW4gdGhpcyBzaGFkb3cgc3RhY2sNCj4gcmVzdG9yZQ0KPiAgICAgICAgICAg
dG9rZW4gY2FuIGJlIHVzZWQgd2l0aCBhIFJTVE9SU1NQIGluc3RydWN0aW9uIGluIDY0LWJpdA0K
PiBtb2RlLg0KPiANCj4gU28gc2hvdWxkbid0IHRoaXMgYWN0dWFsbHkgYmU6DQo+IA0KPiAJc3Nw
ICY9IH5CSVQoMSk7CS8qIFJlc2VydmVkICovDQo+IAlzc3AgfD0gIEJJVCgwKTsgLyogUlNUT1JT
U1AgaW5zdHJ1Y3Rpb24gaW4gNjQtYml0IG1vZGUgKi8NCg0KU2luY2UgU1NQIGlzIGFsaWduZWQs
IGl0IHNob3VsZCBub3QgaGF2ZSBiaXRzIDAgdG8gMiBzZXQuIEknbGwgYWRkIGENCmNvbW1lbnQu
DQoNCj4gDQo+ID4gKw0KPiA+ICsJaWYgKHdyaXRlX3VzZXJfc2hzdGtfNjQoKHU2NCBfX3VzZXIg
KilhZGRyLCAodTY0KXNzcCkpDQo+ID4gKwkJcmV0dXJuIC1FRkFVTFQ7DQo+ID4gKw0KPiA+ICsJ
KnRva2VuX2FkZHIgPSBhZGRyOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICBzdGF0aWMgdW5zaWduZWQgbG9uZyBhbGxvY19zaHN0ayh1bnNpZ25lZCBsb25nIHNp
emUpDQo+ID4gIHsNCj4gPiAgCWludCBmbGFncyA9IE1BUF9BTk9OWU1PVVMgfCBNQVBfUFJJVkFU
RTsNCj4gPiBAQCAtMTU4LDYgKzE4NSw4NyBAQCBpbnQgc2hzdGtfYWxsb2NfdGhyZWFkX3N0YWNr
KHN0cnVjdA0KPiA+IHRhc2tfc3RydWN0ICp0c2ssIHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3Ms
DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIHVuc2lnbmVkIGxv
bmcgZ2V0X3VzZXJfc2hzdGtfYWRkcih2b2lkKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBsb25n
IGxvbmcgc3NwOw0KPiA+ICsNCj4gPiArCWZwdV9sb2NrX2FuZF9sb2FkKCk7DQo+ID4gKw0KPiA+
ICsJcmRtc3JsKE1TUl9JQTMyX1BMM19TU1AsIHNzcCk7DQo+ID4gKw0KPiA+ICsJZnByZWdzX3Vu
bG9jaygpOw0KPiA+ICsNCj4gPiArCXJldHVybiBzc3A7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyBpbnQgcHV0X3Noc3RrX2RhdGEodTY0IF9fdXNlciAqYWRkciwgdTY0IGRhdGEpDQo+ID4g
K3sNCj4gPiArCVdBUk5fT04oZGF0YSAmIEJJVCg2MykpOw0KPiANCj4gTGV0J3MgbWFrZSB0aGlz
IGEgYml0IG1vcmUgZGVmZW5zaXZlOg0KPiANCj4gCWlmIChXQVJOX09OX09OQ0UoZGF0YSAmIEJJ
VCg2MykpKQ0KPiAJCXJldHVybiAtRUZBVUxUOw0KDQpIbW0sIHN1cmUuIEknbSB0aGlua2luZyBF
SU5WQUwgc2luY2UgdGhlIGZhaWx1cmUgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aA0KZmF1bHRpbmcu
DQoNCj4gDQo+ID4gKw0KPiA+ICsJLyoNCj4gPiArCSAqIE1hcmsgdGhlIGhpZ2ggYml0IHNvIHRo
YXQgdGhlIHNpZ2ZyYW1lIGNhbid0IGJlIHByb2Nlc3NlZCBhcw0KPiA+IGENCj4gPiArCSAqIHJl
dHVybiBhZGRyZXNzLg0KPiA+ICsJICovDQo+ID4gKwlpZiAod3JpdGVfdXNlcl9zaHN0a182NChh
ZGRyLCBkYXRhIHwgQklUKDYzKSkpDQo+ID4gKwkJcmV0dXJuIC1FRkFVTFQ7DQo+ID4gKwlyZXR1
cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBnZXRfc2hzdGtfZGF0YSh1bnNp
Z25lZCBsb25nICpkYXRhLCB1bnNpZ25lZCBsb25nDQo+ID4gX191c2VyICphZGRyKQ0KPiA+ICt7
DQo+ID4gKwl1bnNpZ25lZCBsb25nIGxkYXRhOw0KPiA+ICsNCj4gPiArCWlmICh1bmxpa2VseShn
ZXRfdXNlcihsZGF0YSwgYWRkcikpKQ0KPiA+ICsJCXJldHVybiAtRUZBVUxUOw0KPiA+ICsNCj4g
PiArCWlmICghKGxkYXRhICYgQklUKDYzKSkpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4g
Kw0KPiA+ICsJKmRhdGEgPSBsZGF0YSAmIH5CSVQoNjMpOw0KPiA+ICsNCj4gPiArCXJldHVybiAw
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBWZXJpZnkgdGhlIHVzZXIgc2hhZG93
IHN0YWNrIGhhcyBhIHZhbGlkIHRva2VuIG9uIGl0LCBhbmQgdGhlbg0KPiA+IHNldA0KPiA+ICsg
KiAqbmV3X3NzcCBhY2NvcmRpbmcgdG8gdGhlIHRva2VuLg0KPiA+ICsgKi8NCj4gPiArc3RhdGlj
IGludCBzaHN0a19jaGVja19yc3Rvcl90b2tlbih1bnNpZ25lZCBsb25nICpuZXdfc3NwKQ0KPiA+
ICt7DQo+ID4gKwl1bnNpZ25lZCBsb25nIHRva2VuX2FkZHI7DQo+ID4gKwl1bnNpZ25lZCBsb25n
IHRva2VuOw0KPiA+ICsNCj4gPiArCXRva2VuX2FkZHIgPSBnZXRfdXNlcl9zaHN0a19hZGRyKCk7
DQo+ID4gKwlpZiAoIXRva2VuX2FkZHIpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0K
PiA+ICsJaWYgKGdldF91c2VyKHRva2VuLCAodW5zaWduZWQgbG9uZyBfX3VzZXIgKil0b2tlbl9h
ZGRyKSkNCj4gPiArCQlyZXR1cm4gLUVGQVVMVDsNCj4gPiArDQo+ID4gKwkvKiBJcyBtb2RlIGZs
YWcgY29ycmVjdD8gKi8NCj4gPiArCWlmICghKHRva2VuICYgQklUKDApKSkNCj4gPiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwkvKiBJcyBidXN5IGZsYWcgc2V0PyAqLw0KPiANCj4g
IkJ1c3kiPyBOb3QgIlJlc2VydmVkIj8NCg0KWWVzIHJlc2VydmVkIGlzIG1vcmUgYWNjdXJhdGUs
IEknbGwgY2hhbmdlIGl0LiBJbiBhIHByZXZpb3VzLXNzcCB0b2tlbg0KaXQgaXMgMSwgc28ga2lu
ZCBvZiBidXN5LWxpa2UuIFRoYXQgaXMgcHJvYmFibHkgd2hlcmUgdGhlIGNvbW1lbnQgY2FtZQ0K
ZnJvbS4NCg0KPiANCj4gPiArCWlmICh0b2tlbiAmIEJJVCgxKSkNCj4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiArDQo+ID4gKwkvKiBNYXNrIG91dCBmbGFncyAqLw0KPiA+ICsJdG9rZW4gJj0g
fjNVTDsNCj4gPiArDQo+ID4gKwkvKiBSZXN0b3JlIGFkZHJlc3MgYWxpZ25lZD8gKi8NCj4gPiAr
CWlmICghSVNfQUxJR05FRCh0b2tlbiwgOCkpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4g
Kw0KPiA+ICsJLyogVG9rZW4gcGxhY2VkIHByb3Blcmx5PyAqLw0KPiA+ICsJaWYgKCgoQUxJR05f
RE9XTih0b2tlbiwgOCkgLSA4KSAhPSB0b2tlbl9hZGRyKSB8fCB0b2tlbiA+PQ0KPiA+IFRBU0tf
U0laRV9NQVgpDQo+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKw0KPiA+ICsJKm5ld19zc3Ag
PSB0b2tlbjsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgdm9p
ZCBzaHN0a19mcmVlKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1
Y3QgdGhyZWFkX3Noc3RrICpzaHN0ayA9ICZ0c2stPnRocmVhZC5zaHN0azsNCj4gPiAtLSANCj4g
PiAyLjE3LjENCj4gPiANCj4gDQo+IA0K
