Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161D160EB13
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 23:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiJZV7g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbiJZV7e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 17:59:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B03270E;
        Wed, 26 Oct 2022 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666821573; x=1698357573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tlG5sdvuZ5ZKe0jpbm36GuBCWoJXGHGl2a7+gow4d3E=;
  b=QsjhdZ0b4UAVvAr8zubgza4n90I0xL+14lpGnk+L8XwoZcYcJAEyycyt
   UEtTm/0alzACvFq540So4RJnjCEUH6vUv/fwLENd2cOHg521XaltofOIp
   2tVpqejl1SGQhTSLB2x+VjPqPa4fXLUWoW7waDc4n6/e24DdeWHmnBJsu
   jj44KdFC6QEFXZ/kdtCEvwZeBVX6jHOacYzwvCNzoine0vieROpOtmr8i
   eAP/EStbUO8iuAVMaM0RxpObGSWirIor2q1agta8oda1NzIaK1TpDad0q
   solL1zRsZ8k/vVDbWT/TdzLOxoZWJXVdAmS9V3gjyeY+cSNq9EF5xhtjQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="306800215"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="306800215"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 14:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="695547881"
X-IronPort-AV: E=Sophos;i="5.95,215,1661842800"; 
   d="scan'208";a="695547881"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 26 Oct 2022 14:59:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 14:59:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 26 Oct 2022 14:59:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 26 Oct 2022 14:59:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=We/zM9OqwluaKh/Ez5rsoV71Pbk3td3gQg8sl//MF77UaoM10E64v/OajKE3fN9rT9LsUFL9vbKVB1/VpScvpaRRCc61g6YNEfcudxuK/mptEMfK8qqKRWxsxPrSn4ZM1wx9obDKlgZWETAugFJwoqx8eiteZCaPYuJ1J66tXA5niG6k0w8O35ozjyTq/RyglKvE+rPhwUd2iT23qVZXcWojLlCivlLc8DWwwwSTZIVEzZUMjgoGg3UxfuTTsoJQf2G7lJX+QWMuzngkosoHqP+7w2kZcGl/ySRqlZUBIwqb8DNfaGgRLxU3uO0+A0y9FwGRfvHV/gVUwb0cz1oCyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlG5sdvuZ5ZKe0jpbm36GuBCWoJXGHGl2a7+gow4d3E=;
 b=UYGaKqWvP/tSgqGVh7BiaxVDQvJ8g9SdjWwgPawZe3nGAHTsD3BHylxpzC+3H2SOrW8Nfv+mvK7VXF1WEj79KlD9dQmOQFOBI1kq5Rm2hL//qzvKOcPZLoeScs8ZphpX1g6nSDzOkXFNpbk+ntU4TSzi8ZidPpcNmGE5RgQW8BGAz9GU7XrxQfGD9LdZzP39L5rOSl8WRRTYkTPeWSuWm2l1HsZwI0GFYb11R6ubifLD6rcRWdbytkSfL2/K+C4EPYcEglMAysuFp1coRVA5KwByUpOyWSUJgVnNXNGAa0Y3moqFZ6Cl6FTA+rrB+lcGDkZzikhL7evDLK8Ecl4nSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB6788.namprd11.prod.outlook.com (2603:10b6:303:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 21:59:27 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 21:59:27 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Topic: [PATCH v2 01/39] Documentation/x86: Add CET description
Thread-Index: AQHY1FL/9ZOrfh44YkS3ARV6MT/4g64HnGzRgABKE4CAAt11coACKNeAgBR2/AA=
Date:   Wed, 26 Oct 2022 21:59:27 +0000
Message-ID: <d780cf636f78688435fa943c2c1d9655c9c33365.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-2-rick.p.edgecombe@intel.com>
         <87ilkr27nv.fsf@oldenburg.str.redhat.com>
         <62481017bc02b35587dd520ed446a011641aa390.camel@intel.com>
         <87v8opz0me.fsf@oldenburg.str.redhat.com>
         <cc1838888e9da64415331e6f7d83965b553daae7.camel@intel.com>
In-Reply-To: <cc1838888e9da64415331e6f7d83965b553daae7.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB6788:EE_
x-ms-office365-filtering-correlation-id: 47a182df-8f8d-442f-9ea1-08dab79d5a10
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTvfzivdSAMaV2LVXsCEaWXvsNZEX1BJnUpgQL3D++n0N7jgXpgXvF3dltGVpaZ2ebS7PIxY9Yv7V087nV+vEGmrmLgcC0RUequOJeOMjbBZ75QCOy1TVYDJavevX2ywGgv1t836UFrCIs5DqqXOjhQ3praxayZ/NvEBy9a7okZ+NkOPkAVpft+Suc9zw27M3nrnHO82tWoITUqoJ7ymw4LYPyo1UQvBTQx4GNtkvu4q1jTUDBeCa9t0B+TuRzEXAFjycs27y06odJuH7dBi8YUM8yUEC+UFZ9TYmh/VGUUpfInzS7jWPnPcK8npLgg2a0TnuImfiXpN0enuDWZci56RVln3UMVkSQDtEJLPer84ejSU4Ws+zmjUZNbHqh8DURjVZaR/t5dS10u1p0LleuwYg5dwBrqnt0rYD0i/8NOUxwMOYHbaS+Lv3jo21ThFc+g2T2wNKP+jOLBc1IXWT0mb/eH1WF7JNdHKGInPrIsBVTkTiM1VivrM8hNniQWr7dWsPxCNiLFse4Le+DRxcmlOSgobsVurA7iP6J5eY5RG8R39/6Ro++l6L/RH9WZTpjnzWmjaPNbt7qtqpfaJuga0eBK9xkNvsuqUPW1oQoQgGeJQVUkN8iT8I/Pst9g04kGPR6KGlG28Wq35IAzBiGYH4ESA//OHeBk1en2MbNDaGUW8YewLPePd3rpa5WMKX8oYeapimwjxaLwG8DpsTRF95ZnxUyipQNLQUmSp/TPLx3O4aZKFK+XSsDExquqIUWrRMkaMxrssOarC22R0OhmiVp7yOi+UQeZ3j9yIpls=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199015)(38070700005)(54906003)(71200400001)(6916009)(82960400001)(5660300002)(38100700002)(122000001)(316002)(76116006)(66946007)(91956017)(66476007)(6506007)(8676002)(8936002)(41300700001)(86362001)(66446008)(66556008)(4326008)(6512007)(26005)(478600001)(186003)(83380400001)(2616005)(64756008)(6486002)(4001150100001)(7416002)(7406005)(2906002)(4744005)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVBNTFNMd2ZtSHFtc1lLeDk2cFRKWEpXM2o2WTJBNFh5ODZBSjliUWRzRlFL?=
 =?utf-8?B?OG9EUE9UM3Z4WWIwQWlldHpyWm05SHUyK2h0SDgwYmwxZ250UEZybzgzVzBQ?=
 =?utf-8?B?VERyM3Z2KzJDMnVDTWJlYm9XOEU5MjZBNml0SndVeTdCUFQ1TnBmWnRUK2Rp?=
 =?utf-8?B?bDZVS0o4TE1uNUxHZnZuVkVYUld2NGhsL1Ztb1dYNlRWVDVENUJTWW5ZMWNU?=
 =?utf-8?B?SWJwbXlJQVU5OTJTemVVMEdtZDFQSHA4U1FsWGE2S3h5b2ViVFJSWE0ycitm?=
 =?utf-8?B?SERyWDNRV2RObzVpekEyRjh0Ukt5REpWZXNISUxjclpmVVdoUklkdGFZeElj?=
 =?utf-8?B?UXVnRWpNVXFHY3RKTjFHR0RGYWVzRlB5NmZBeFR2U3htLzFnRFNYZ01SbFhJ?=
 =?utf-8?B?TWYwbkFTUlk3WEgvVkYvaDlpWEpuT0p3ZnJDbmExaXMrWUp2VUlBZ3RKZVdE?=
 =?utf-8?B?bTYzNFBEVENyYTNZTjFFYTNvSzFkUTdJcFh4NWtHak5lQ3dpN3MwK25WNG9S?=
 =?utf-8?B?bjNoMnlBVEdQSSsxMkZJc1R1WmNSWmNGSDFEdkVFQjRrZDRCak4rUEZ2VVNs?=
 =?utf-8?B?Q25oSHROc1I5aG1acTVScUNjRmk4d003TE5XRzJUN2tPSjhHcWtrY0U3b3ZE?=
 =?utf-8?B?QjdkcTRBalVYaEp0aXpNNXJMMWhOVHkrNXVkMi9wd1N5TkF1aUdkNmQ4MVA3?=
 =?utf-8?B?STlTd05TYW0rMGhuOWlsbG9EL2MxNnNLZUkxbXgzZVZRRTBmN2ZZcEd1elp2?=
 =?utf-8?B?c2Fkc1BXR2dIdzF5OFN6dXFIbzRyTUYxS1I0YWhzYzI2WGJjQmtEbWVkOGlu?=
 =?utf-8?B?THMvVE8xdERlTmg4V0U3bXYwNDhlaG1xL2ZYRTJkTHFjVDVHdW9FVi9WbXNS?=
 =?utf-8?B?c3pVVzZQbWxFeWFVMmJHay9tL2RZU2ZnVEtXYXFZaWRrWGRnWnlzZHptNUFu?=
 =?utf-8?B?UEpjQjFScnFhT3FwSTl2WlJ0TlZSOENZYURxOUV1U2hvcmp5MkQvSEhINWZJ?=
 =?utf-8?B?aUJLNlRMckhoYXc4YlhJSzlRSHlJVkRhM3RtSklsY1YyL1Qwcm1jRGNaMjI2?=
 =?utf-8?B?WEtadHNudDVBNFdjL2EvNUJUQW9mWXh6SU5jOUZzdDM5YXRTcXhQZDMwV0ZF?=
 =?utf-8?B?MDVXRml5SDlTa1pWZ3F4eGlYYnY5ZUtXVUxybGpGOU1wcUdIQmNFY1JNSWVS?=
 =?utf-8?B?R0JYNi9admFtVGMxNmZ2TnRWU2RPS0FNMEF0NmJzTVNoV2JIV0xhdzhFSjRu?=
 =?utf-8?B?RDR4VVROWGpLRHdHSEFpUjN6ZCtjcGFGRzBHeDQrcUkzNElXY1BXZ3Y3M2h2?=
 =?utf-8?B?Sk5Ibld1citnWko2bExHYUt2M25uNnpBazJRRWd3V1hEQnV0dVpPUWNLY3JF?=
 =?utf-8?B?NkR1ZWVGNmViL1ZCdkFMVWJSVzFaMlZmTXkyT2tPbEVoVGhKL0h4NXhvdmhn?=
 =?utf-8?B?K095ZlpHWWxqTWhJd1VxN3pHM1Z4R3VEUHVnY3p5NVh5aXJVMjE1ZzRKQ1RU?=
 =?utf-8?B?TFhPaDVjQ2cySVNhZmordnp6OEZRSmpDZUQzZitWemthZGJuUHY4K0xISTNO?=
 =?utf-8?B?Q2RodFpSN3FFYldOSmJ4K2xuZEhmZGUzVndOR2FnQmcxa3RHOFpNT08yVFBY?=
 =?utf-8?B?VkJUZDdGN1FsNzZ1ekpROHNndnU3QmV5K2I4L3VhZUM5ejdSaW5wSStlRkI1?=
 =?utf-8?B?N293Ykl6d2h4SS9BSkZLQm9QZjR1anJuQ0hBa1dkVzVRYjBQZlNkQWhIdXJZ?=
 =?utf-8?B?bmg3UHExS1BUdHBMUDB4WStDS0U3eEFIWm5pcHJEZUlPUW9EOFZSenNFYmx5?=
 =?utf-8?B?dVorNzNFcWJrbTVpRWpkZTdhRXhKNXJWVDNsWXJ0Yytid3NLMTdrUG4xVjRZ?=
 =?utf-8?B?Zmp4SkRMQTAyVFpFdXhWeXE3cmlaOHN5SjZGeDBBOXo2UzgyYmY0Qk56b3dT?=
 =?utf-8?B?L0tMVitmL3NmUzRxUnpyZmxBL0d2Z0Z6em9iUVdyTEEvSHhNaHJwS1NoUmxl?=
 =?utf-8?B?RUxWT3BxRlNRMHowZS9nL0I1UldybWRCYVFuS0h6d3AxVDhlRHVVb1E2MjQz?=
 =?utf-8?B?UzFLbGZhWVhac0dsNjVveUhpMjdsZkJ2M0ZTWE1KMjJnUWdwYW91RXFselRr?=
 =?utf-8?B?R1pNcERMcDlXb2ZmMzZPVWZwU0prTVBiZU9UdnE3ZGRGVmw3SUNNSzBndm9D?=
 =?utf-8?Q?C+nTMSYDCUtOVSd4uSgy5Fw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72DA8DB2B6A9A84FAA7DCBBA8D742202@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a182df-8f8d-442f-9ea1-08dab79d5a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 21:59:27.4508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: goRrcB6ypeoOBa5BjMUbux1AjSP5Kbf/Y8V5ndLnaVH8ZL8sa8usFjd8o0zFhaCpuBAmJ/5Ta6MFOT9vhRstTwNraRHg3e2Bc0iwDg1Y1x4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6788
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTEzIGF0IDE0OjI4IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gSW4gdGhlIG1lYW50aW1lIHdlIGNvdWxkIGhhdmUgYSBuZXcgYml0IHNoc3RrX3N0cmljdCwN
Cj4gdGhhdCByZXF1ZXN0cyBiZWhhdmlvciBsaWtlIHRoZXNlIHBhdGNoZXMgaW1wbGVtZW50LCBh
bmQga2lsbHMgdGhlDQo+IHByb2Nlc3Mgb24gdmlvbGF0aW9uLiBHbGliYy90b29scyBjb3VsZCBh
ZGQgc3VwcG9ydCBmb3IgdGhpcyBzdHJpY3QNCj4gYml0DQo+IGFuZCBhbnlvbmUgdGhhdCB3YW50
cyB0byBtb3JlIGNhcmVmdWxseSBjb21waWxlIHdpdGggaXQgY291bGQgZmluYWxseQ0KPiBnZXQg
c2hhZG93IHN0YWNrIHRvZGF5LiBUaGVuIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgd2FybiBh
bmQNCj4gY29udGludWUgbW9kZSBjb3VsZCBmb2xsb3cgdGhhdCwgYW5kIGdsaWJjIGNvdWxkIG1h
cCB0aGUgb3JpZ2luYWwNCj4gc2hzdGsNCj4gYml0IHRvIHRoYXQga2VybmVsIG1vZGUuIFNvIHRo
ZSBvbGQgYmluYXJpZXMgd291bGQgZ2V0IHRoZXJlDQo+IGV2ZW50dWFsbHksIHdoaWNoIGlzIGJl
dHRlciB0aGFuIHRoZSBjb250aW51aW5nIG5vdGhpbmcgdGhleSBoYXZlDQo+IHRvZGF5Lg0KDQpI
aSwNCg0KQW55IHRob3VnaHRzIG9uIHRoaXMgcHJvcG9zYWw/DQoNClRoYW5rcywNCg0KUmljaw0K
