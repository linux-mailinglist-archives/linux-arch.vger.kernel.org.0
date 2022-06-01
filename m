Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA18D53ABDB
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 19:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354867AbiFAR1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 13:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355752AbiFAR1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 13:27:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B943562CF;
        Wed,  1 Jun 2022 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654104471; x=1685640471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CC+J2414YNif4uweGXY3R4p1/UU8ZZRqs7s/cBhTrio=;
  b=VXgzX8DkmVagYQ1bVDEW9FR+lE5s0ObpGHXtf9UWcpMBN8szWfuFrXa/
   Qonf9fcLl90q05DoB9Np9H4WTOwsd7g04GsxjexGspCOQXvrh/6s0XA4U
   f4PB/tYtkKcxRyGu/A5GOLfz+IyOE60XxCb8zRvt/uPQ2Y25i14Gpsi4N
   fzW+yCt4qn2EQbgQOkbXenyDlZF+IVDehfmtCdg2GqwB7Zx95WTL4VAoO
   CfppMOMsyg6MxML/frHDoEhtFsLGxPlocTFx1w1M7y+5c5oZhv3fN1GJo
   NLuhJUb7GsE014LaM/w8gjDlwyFQ2HpWUAGW6KZZHeqOrFlR3Z5gGGF8+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="274467627"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="274467627"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="562900243"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 01 Jun 2022 10:27:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 10:27:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 10:27:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 10:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MODRdH/EHqGbYTyvIFFbmzZv3n+eOfI25jY9kmSpgrUKY0UMJbvtXAJJy+wKp4Iyzc5ivlLWpoGDYDCVLic7vREe3dCiRWiTAYLCTrQr2jJYqS6xbNWH89GN2PjYSviqn2N46hUTpXe1EKgMon0xquPBK+rgif7WF9/tfNkx5i8CEm8U+zuhzAAPmj3zwdYThGrkQuQjPfcYozAJ5qeB+831Mqou+o5ZI27Ecg8R4lVP60UN4TbiSDnXyloCPZu6ZszbG3Pu12WugJ1QHjCdN2/VF1XlLL9OFKocji98X0S7590Rpb04SMvGxhmbfpfO022HjELmDfibBrzrKoCaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC+J2414YNif4uweGXY3R4p1/UU8ZZRqs7s/cBhTrio=;
 b=BxaC+UNvhl4PKIDzraNMxYc3Nlwy7gpPB9Z4XNL9gY2mIbf3lb1f8uIxoGcg+MzSXf1NpcdzPUqUP7iRA9WVSphHiBRiSOJqYZcdtQVtaBiUkC4XSzyCAKvsNHhxDqM1dpvNaxUive2Gd4Bf/QH/VA5/QqAEhJLuv/8qDwN2u0ol99Eo9xnDrDLC9gGsq6RlpTAEXM13A3ZoHGtL7ai8ulu210GD8zsXo0RFcHxMxbzOXtKX8JksqOKzDmGt1D1MBws0etK/Q8XqVSbGzaYpC8tsJSZ4KPzMtXk36G4ZvBa2/Cd67550b/uSL15qEhEAJkdpYMvMpdG9hYF8kk/eOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 17:27:45 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 17:27:45 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyG5jiAgADTxwCAAJnkAIABGRSAgAADewCAAHMeAIAAC4MAgACbY4CAAZeygIAddLsAgAAA+YCAABC1gIAAF8EAgASAo4CAADfAgIAAKfMAgAEo6oCABLJcAIAAAt+AgIUewYCAAEo0AIAAAygAgAAQTACAAAcUAIABiUSA
Date:   Wed, 1 Jun 2022 17:27:44 +0000
Message-ID: <172310e1b8fcc78fca786f9ea7966f58dd93ff93.camel@intel.com>
References: <Yh0+9cFyAfnsXqxI@kernel.org>
         <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
         <YiEZyTT/UBFZd6Am@kernel.org>
         <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
         <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
         <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
         <YiZVbPwlgSFnhadv@kernel.org>
         <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
         <YpYDKVjMEYVlV6Ya@kernel.org>
         <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
         <YpZEDjxSPxUfMxDZ@kernel.org>
         <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
         <CAMe9rOpctH-FQZH_5e=f17Ma7Ev0u9jiXap5bgqFyhLfsx102g@mail.gmail.com>
In-Reply-To: <CAMe9rOpctH-FQZH_5e=f17Ma7Ev0u9jiXap5bgqFyhLfsx102g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c87887ce-2c73-405e-2bf0-08da43f40a44
x-ms-traffictypediagnostic: PH0PR11MB4983:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB49832F235ED0922637044B77C9DF9@PH0PR11MB4983.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FV5fkYpNUFAUpLsbAqSAWYneGZy9q/W5Lf3B5PnVBJaNKWkAM5MLjlUJKClvS0McIRxxBMYMY6WLU37unr5cCN56AdrtWavxgWUpvKhs46wvemqo+atbOtdUagmKKlajoEQQXKPkragIVO3j+FVCd83llTrTMZiSNyrC5aZv1KJyGbqN2V4LjBav7AnHttq3n764Sjf2alwSpxvZQKuXplG6JpLnyGQz1z/KpGZwus53ne5JU8adsBaTIPgPxHNffOGkBwy8vP+2IyR+qLbuasLKlqoP0ofpczpykyTrKOLo8yde4p03eFvGK229BRScoJyaEnQlVJ6MfOk2/NW+MF4CgqDb7Mb5QelhJmm4OLGXlmlM2+VmOBwA4HQth/g8v48sZiE8Bt5jwp8w/wLrztm2+kbcGfgo4kFFsMo1Wv1rfhCCjUwHRNFrEXLiigkeQ8QtXKSdwpj8GU3WghxYRCjlPBWZQ8dwfsfBDcDx+R4w3/3XlKTrzUL3RMPEI0YF1f1EKxuVjE5S7pPPs799wx7KqLEIEYZu7gpwon/6vgstGJ/5eab0/MTTjbene5KeJFDr9CgIgmJr3WD2OMDJi1UiX13tVgkWjjjQrh/Kk8aLH0+R6CslTOYrU9aSNUDcl9fvQS4O0vL0EteJzPbvADWJEYYRPj4Dk/+TwoE9sWbpTmNvMlNXZlfcEwHZBCWfDexo9npS5vMzXqUI9QcEX2Vj/JShJvZp2WMPOlGfxiM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(86362001)(66476007)(66446008)(66946007)(66556008)(64756008)(71200400001)(38070700005)(76116006)(122000001)(82960400001)(316002)(38100700002)(6916009)(54906003)(508600001)(5660300002)(186003)(2616005)(6512007)(2906002)(26005)(6506007)(4744005)(8936002)(36756003)(83380400001)(7416002)(7406005)(6486002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnhZWXVia2ZZMllHbzl6a1Z0ZDZCZlJsNVZodFBqbzVsZzZHQlVPNVpPN2FC?=
 =?utf-8?B?Tmlpd1J3N3FNWjBjQm55dm4wckZaNnVDZXRGLy9zNzZBRGU3TDU4RlNqRm42?=
 =?utf-8?B?bVZEVGlpV3c4OVgvQzRueGJpL2lXaVRjb3BYQWNDQk5pSmZHR01JbU5UVFBa?=
 =?utf-8?B?b3JLNk1EWTZkdzU2UE54b1ZsWU1zVWJUNUQ4b3MveUtFRVA0d0I1K2tZZjNa?=
 =?utf-8?B?UFB3WFAxOXUwcWlsWkFCWU5oYytMZWdmVm1zVlVtVlFvZlk2K3pmTTVpVUM5?=
 =?utf-8?B?V3hxanpHNG5NVG4vLzNrSFgxUEpxeW54WjJPSDZjanpWT0lLcjFhQW90MkdS?=
 =?utf-8?B?QVhnazdZcjZRbW5adFBQZ2RHdTA3UWIrWktsdnp5SHRHYWJOeVg1V1lHT2Vk?=
 =?utf-8?B?Q1YxbjZpa3BaMW9vb2hyU2FXRW00QzlQNkJHVXY4Rm9IWklvNG96SWdSUmJE?=
 =?utf-8?B?dlR3WTk0SytKTTZrU0pXdHFhSlczazZRQ1R1N1d1Z0ZFNmFLRVBXMDZNQW5y?=
 =?utf-8?B?MXJzcWcrM0NmcU5hN0pXUnE2aHJ6V3ZyZXplblhnc0JXTGdtN29DTHFIbmR3?=
 =?utf-8?B?NnRiZHFyWkhDTkJZeldkeUNna2s4N2g2cXNIYUF3aFh2L3E1eUJCazdudkpy?=
 =?utf-8?B?SHcwVnFBQmtlbkkzclhQTW9GRWcvZ1FoSmhRUnNZbC9DUE9vQ0JhUVdna1FF?=
 =?utf-8?B?SC9mcCtFVjNlS3dETFVWUWltZ3FUNkhyUnArOFhyb1BYY3pQcnhvSmx1OUd4?=
 =?utf-8?B?MFFBRm9nL3JSeVFKTXBBZDFXYWNiS01hTWY5YVE4TTRKeCtQNHMyS2pEM2xD?=
 =?utf-8?B?TTkvc2d0TnFMYmc4TGFYQWRHRkJjMS8zYzF5UmVUY3BiZjhzNHIwVW5LWkZH?=
 =?utf-8?B?d01ZMFo2ZmxqVnFUcTBobzdlQml5RTBKV3VOWGNKc3dmRGFJUEZ1bDBENjNN?=
 =?utf-8?B?cnFiY1hoeC8wdGFacmRQMUdiUnA1emU3emd3VjF5Q3JNOVhlZDdDcTJFQTg0?=
 =?utf-8?B?bzdabUZUQU9aMXgwWkI1SERXTkpSS3FBWmJtamJ2L2Yzb0VJUWhVTXJ2YTRO?=
 =?utf-8?B?ZHJYUHlzSFdpVHpHMFF0NzBKaWhqNWJJd0JPSW9VRW9uZlVNcW81WGdUcU9M?=
 =?utf-8?B?ckJ1cmpVNzA1VWR3NHdvMStRQUhvTmtubXNuTzg1d3VwUWxudjNxZDZCR1J1?=
 =?utf-8?B?ZkJLTW9rV29aNG5XeGF6S2pkR29OUG5sRm1yMThoRGJVQSt5bWpPZFBNTW93?=
 =?utf-8?B?S2lPVTNUdzdkZ3JhU2xlYVJnUXFFUDhKTHdndVF0THhhbnhSY29SbUcyVElO?=
 =?utf-8?B?MGtSL1loYk5uWHdTYnk4ZmkzSnYvK2orRlpKOWkrTndOT0FWOUtEVkdsam9Q?=
 =?utf-8?B?a3M3Vi9pR0E1Y1ViWG1oM0FGQXI0UTBacFJSVXMzZ215OEhiclpqZWNvc0dz?=
 =?utf-8?B?R1RrSXNGTXdnY3I3WEhDRFRQMldHSHAzMmkxL3NyalhvdGdoOWlnS2JOcjJv?=
 =?utf-8?B?QmYra3RvK1hnTFRWRGpoeStvWEt3a0xvRmpjM1pER3RhMUZ6SWlZRko4bDQ2?=
 =?utf-8?B?OE1pdGJaRm5ESjRpa3pmL3l3ZDVabSsxUXhHQ1Y2RmIvcVZUNTFrd0w3eFU0?=
 =?utf-8?B?Q0hWVG5MbURDd2J2anUwT0NOSXVTVVZ2L2pVdUF2bVpOdEJJbkJ6MXhxVjN4?=
 =?utf-8?B?bCtkYTBMQVhCSk51NzB5TGM2Z1liNnR6RjNKU3hZNkR2L042OXlGVmZjZ3RG?=
 =?utf-8?B?K1RpUE9pakdWekdBT1dnYjlkT2dscG0zWU1MeERTS2RNUGdNN215Nk95UEhy?=
 =?utf-8?B?UURBUGRnVEdxTXEzaUlvT1N6S0NGKytyUkJhS1A1N0VvTWJXbUwwT2U2MFV5?=
 =?utf-8?B?NVZQaXdzMkErSDBFWkg2VElwZDdxU01JZ09BbDBEVWxxc1RTenNTR1h4WE9t?=
 =?utf-8?B?UVlIL3Bvb3ExTXhBUzRYYzVqaVBMZmorU203MmtLTVBYMmNWWng4ZFRhaWN0?=
 =?utf-8?B?d3ZMZmVUVFZPZTlONUZ4cTFvSThSRkRsMDRvRXV5eTV6TXMza0h1cmFpVjdr?=
 =?utf-8?B?aThvdjMzMmhNVTdFaTJ6a0VRalpkRndUSnFGMDJMck9La2xzMDFxMGJzWEsy?=
 =?utf-8?B?QTg4ZUhRODNqakpWVmxacGNpbUJ5ZzJuZm5meXpUZXVwR0t6anVWVy92a3Uv?=
 =?utf-8?B?TGxmSjdQYURsN3FSem91SlFRUHVSS3BXaER2eTlHYjArb0NHaGs1d29BSSt1?=
 =?utf-8?B?Qm05VTQ5c00vN2RJOWFPWk1ZS1Z0cjF5bVllYWl3VGxlY2JwOURjZ1F4Vncw?=
 =?utf-8?B?Mjg3T1FjMVBNMWNCZGZGaWJ4WnRxTjhKd25yZEsyWHp3eFp6b2pZWk1hbjJZ?=
 =?utf-8?Q?iHrHsEMbkl8p8cxEasJZKU55H5T2uQbyWrGFy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F71753B508D62644AE8D2CEED127A11C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87887ce-2c73-405e-2bf0-08da43f40a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 17:27:44.9511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwXb3MS+MpDr+X2Kw+6U9uXuSXiojtEpL4k3BLHf1cLxiHbgFuE9YPOde2GaHCO7gjbpWkVUBxV+FOpGe5Ff6rVnF3BdOsbNdJO19IpbdA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTMxIGF0IDExOjAwIC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiA+IFRo
ZSBnbGliYyBsb2dpYyBzZWVtcyB3cm9uZyB0byBtZSBhbHNvLCBiZWNhdXNlIHNoYWRvdyBzdGFj
ayBvciBJQlQNCj4gPiBjb3VsZCBiZSBmb3JjZS1kaXNhYmxlZCB2aWEgZ2xpYmMgdHVuYWJsZXMu
IEkgZG9uJ3Qgc2VlIHdoeSB0aGUgZWxmDQo+ID4gaGVhZGVyIGJpdCBzaG91bGQgZXhjbHVzaXZl
bHkgY29udHJvbCB0aGUgZmVhdHVyZSBsb2NraW5nLiBPciB3aHkNCj4gPiBib3RoDQo+ID4gc2hv
dWxkIGJlIGxvY2tlZCBpZiBvbmx5IG9uZSBpcyBpbiB0aGUgaGVhZGVyLg0KPiANCj4gZ2xpYmMg
bG9ja3MgU0hTVEsgYW5kIElCVCBvbmx5IGlmIHRoZXkgYXJlIGVuYWJsZWQgYXQgcnVuLXRpbWUu
DQoNCkl0J3Mgbm90IHdoYXQgSSBzYXcgaW4gdGhlIGNvZGUuIFNvbWVob3cgTWlrZSBzYXcgc29t
ZXRoaW5nIGRpZmZlcmVudA0KYXMgd2VsbC4NCg0KPiAgSXQgZG9lc24ndA0KPiBlbmFibGUvZGlz
YWJsZS9sb2NrIFdSU1MgYXQgdGhlIG1vbWVudC4gIElmIFdSU1MgY2FuIGJlIGVuYWJsZWQNCj4g
dmlhIGFyY2hfcHJjdGwgYXQgYW55IHRpbWUsIHdlIGNhbid0IGxvY2sgaXQuICBJZiBXUlNTIHNo
b3VsZCBiZQ0KPiBsb2NrZWQgZWFybHksDQo+IGhvdyBzaG91bGQgaXQgYmUgZW5hYmxlZCBpbiBh
cHBsaWNhdGlvbj8gIEFsc28gY2FuIFdSU1MgYmUgZW5hYmxlZA0KPiBmcm9tIGEgZGxvcGVuZWQg
b2JqZWN0Pw0KDQpJIHRoaW5rIGluIHRoZSBwYXN0IHdlIGRpc2N1c3NlZCBoYXZpbmcgYW5vdGhl
ciBlbGYgaGVhZGVyIGJpdCB0aGF0DQpiZWhhdmVkIGRpZmZlcmVudGx5IChPUiB2cyBBTkQpLg0K
