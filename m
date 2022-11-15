Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FA162A381
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiKOUzN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiKOUzM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:55:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1FCCD9;
        Tue, 15 Nov 2022 12:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668545711; x=1700081711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=71Se6G42N+ALiaMMx4xhwkTOfJspLGT5Zr9Pzazfq2Y=;
  b=QccjKsnROZiRNQ+2fq0qIc3lLlNQAZ9xiPWfefztPyNfVJ31o2hhZ1p8
   exEIfdKjWRAIks8qSfaTQubguaHmvnky+YXwIPJdZ1Da5op0jItMzP+Fj
   AH/D82AgjrqdFOp1+3n+ka94VQsEXIqsHCcZJWWRdsi8ghOikfA9OocZ2
   XshgbDgy6WBe1X5r52BZK9dnSQPSNKHdy9vNIfDOXwB7McN3tADr7iYn+
   7K8woXOObTPhH1tpSrxJAhCxDP0H3L5cb7X7JMp9cjax/zlwNIP99y5aI
   pMBN+g8gFP1EUn8vWiv7kOUrSizDL1bsxxbPc+3BgqNTGU4zhT28XbIJN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292076356"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="292076356"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="744748285"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="744748285"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 15 Nov 2022 12:55:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:55:10 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:55:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:55:09 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:55:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2if1tCgeI3mSGW8MyWtaJ9p6q3Vw4yEDQI2zRVeUSgP+IkEI+PmqctOkDdPF7tbAXL3Wm2zIduLl3TfW35eP6+mjoln67l8XL3fiKTe+56hiVZ0LP17blJtx+gQmnl/JeWC8HVwl5VGjo0tT9RayHPcQDWteyqc3ZgoKE+LVgN+1G7zb0eSWbjkmbPECYMQ1itvww/zez7rMkgN6xeq51cFPJum63/ifFa64Vqbq4Gh8MYtsGlm9iSpDywY4jcuyjZIUex6jztpBFl3Y3+QS8Yw2bu7Ft1o66xIQMhvYgJT5Vka7NyfGFEX4FVY7eAtnY8N+ibMiFTxNX05R2jbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71Se6G42N+ALiaMMx4xhwkTOfJspLGT5Zr9Pzazfq2Y=;
 b=bmm9cMmO6x6ORh3gJhSd0eOvFkURDL+alNfQywEqsTg43kxEydFyiCdH+t4NxQXBHuLR+6cuuOiZ4zt9fNe6s7ZWKE4y4hrq4ErqlINmRzuO+2HpNURDLlYKdE9CGXZ/KwNVp3u97R347wkzW8Lts3SD+l1rQMcV0aV74lrdBgq6mV2T6vlPW0bCnPA5juK4pyJsIh9U6jxKegUvcg9XgmJOLVsyuQX3yVyTpjxo0k0Y7WfFXEb1ecxVhVyj4otNa5rGTVKwLmwr2yAEI3MHFJKjhybwACLhBjMEyc9RH9YrE00myOAqHuzkW3EgqpovmTWzpsBCfKV0FwhEo6tEeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 20:55:04 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 20:55:04 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
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
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 24/37] x86: Introduce userspace API for CET enabling
Thread-Topic: [PATCH v3 24/37] x86: Introduce userspace API for CET enabling
Thread-Index: AQHY8J5YHr+v2xwnHECK23R1RZ+v4a4/+bWAgAAKf4CAAIOggA==
Date:   Tue, 15 Nov 2022 20:55:04 +0000
Message-ID: <049eb42bdcb72731af34cd9de4ad04a770b2dc7a.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-25-rick.p.edgecombe@intel.com>
         <Y3OFb1035Ef+4oLj@hirez.programming.kicks-ass.net>
         <Y3OOPQ/vhhwBH/dr@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3OOPQ/vhhwBH/dr@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: 684d8389-a598-46bc-0a2e-08dac74bab8f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W587KC4hYoxPFHP0qT9zdyj/BX7RSoq9+STntPZUPyo4d5scplFYQ+Q7Q+zgPc1C03u2ey8kGZPywi1ucFMqAD+eioppPejgi5uo2RjgLa8uOWL6eiSh3CIDcT2dih8moCO5mZF4PJtAudNxsHfm3LHD6/mOyY7tGDla++vWPC6d4eR4thf8U8Mwi95QwKbzBHsn/T8E85wFDs3ESxg3G4ntL5LtQF0iFeT8tw8ibvpXjBkg9W98RhIX9+VndLzJt+8hn42ngHW4oOhMPUx3OzFCD1R+d2I3TTjZIWP5fYmg9+WJPL5W59qDlcxZknFRiNeiR1sbQNN0kPQhlmnVSCQSFq4UqHMl1ENBP/kAGA3/ce1quYe9tN2xQ2ujc5qlUv6d9CyKgKnAqercfzj/IHINSWXDaJPDHw+6FUswtzEBkbEqaQV22Efk7M/OS2tXxYtNd4qPXTr0UTF+uK8Vz8PpZ67a28yP7IQuNij1k4V9w6H0jb45Gk0MXs/6DijodnBgq973QGV99o9s8uiS+/nw/8EZ3ru98aSkrpS71xiPDimPdxHBVRpfWecBCaSfFLTE16msugYcBTBqN/0c/GoRh6wU/WWmEShItZG1epkn39vUbuRTqQ5rHXqdD3iu8GbpQYcJgMIddGa+0Gte/OHeHkI9p0Ayjftr4fRfgqaaguNouQ/zKfhbTh0VwxlrruNYApv/KZn7jXKf7+qpftzMT48aYgCOVCLhbBQ7Eg6Qxin20SlnHvgnvhfBXI2EsXNUwddX4e9BhYqKNcI+kX5LecyNcA6jg5yo1nFu2io=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199015)(36756003)(316002)(7406005)(2906002)(66556008)(86362001)(38070700005)(4001150100001)(38100700002)(4326008)(122000001)(2616005)(66946007)(66476007)(91956017)(66446008)(8936002)(5660300002)(54906003)(76116006)(7416002)(64756008)(6916009)(6506007)(6486002)(8676002)(186003)(71200400001)(26005)(478600001)(82960400001)(6512007)(83380400001)(41300700001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amcvVjhUckVxajZxbEZuWmNkUEQ2dkhIeUVla29ZaGJKQTVlUXcxSUtpNFV2?=
 =?utf-8?B?QW1jNnpWMjdUL0llbktmektBL0pueTJFR2hZU0RxMGRnbm5ROEVEbUhIM2No?=
 =?utf-8?B?QnBFWVBEQ2x5Szd6VVFEQjNYOUVPMjNSWXBQTURRT3kvYitsdWRWRnREdHVs?=
 =?utf-8?B?bHo1SnlrZm91VnN5Qkl6VGN2ZGZwNDVzOXB6V3VOZjQzcWN2MFZ0MWRtUkww?=
 =?utf-8?B?Snp5bEpMN05uNDFtdVVwZ1duV1p5Mk9ZNGlwQjBoSFFqbUQ0THhOVmo3YUsx?=
 =?utf-8?B?a1d0TzRtNWNLelBWRmdjWElqL2szaFhZM05RZ211UkM2bEhVTlN6dlBSd081?=
 =?utf-8?B?QlNWR2h4VUdIUmlFODRHVG5oQTI5elpxN3A0azNsajFJa1RUNkZwM09hSzMx?=
 =?utf-8?B?RVlWR3pMQmxkSnpKd3ViMWxaTEV4M1pVY3BJOGtrTU4zWmZLdmkxNkNYcjZO?=
 =?utf-8?B?T1JtZjFqeVdQQW50T2hLbTBob1JUOFRKSWdnZ3ZPc3lNWWk3eC9OdmgwVC9j?=
 =?utf-8?B?Q1U4Y29sbkJUUGZtelFjNDhmNTJaeXdsYlBCTGpraHA3VHBHSzRPT0V4NzlU?=
 =?utf-8?B?L29wbHArclE3aXF5LzFLa0ZqNnlCRXhJUE4rVG15RTM0M1VNQm43bnAxUzJ3?=
 =?utf-8?B?TmtiRnB1OW9OYlBSZ3JnSVJDMXFRd1FRUDBuVnFHaGUwV0N3bXpmcUE3YWtB?=
 =?utf-8?B?MmcxcjR1amFheEQwdUliZ1JVOHd0N25VSlhISEFLUlMzTjk3ZjFMNnF2Qzhm?=
 =?utf-8?B?TWdyUXZFeEthT0tpMk42VTRRMjJBRk5LYy9laW1pM0hyZE5Ka1hvc0UzRWNQ?=
 =?utf-8?B?QitMM3Vlb1RXdE5HM0VPMjZOaEsyVUVzWWZoYVl4aGNXaTh1SlRCOEkrNXgz?=
 =?utf-8?B?N1NNUFNoc00zTEMyRGs5MFZSZWxGalU0VFBhbFp6N3hsb3VsSWgrZzJVSmJO?=
 =?utf-8?B?alFHL1JxN1ZBd2dVQWkvWlY3MVZxVlhhZFdDaTY4bml1RVgxSHRuZVNHaGpt?=
 =?utf-8?B?U2lSR3JJM2J5VjdCWXJ4ZXp1ekpNN2xHQ2xJZDA2MTA4b2xrY1F3SXFjNy9v?=
 =?utf-8?B?OFJPSTlkbW84b0F2cW1lYTFNTmVQaW4wbUpQZTZTb0w3WWpzNWp0R2JIbkxz?=
 =?utf-8?B?cjVwc1hLRlNnN25lSjRXK0dLQTRRelowNGZYNmtCdlRGeWFrRjI2WDN4bE1n?=
 =?utf-8?B?U3pFMm9TV2MxY2NXdmJ6UWtTaVpwd2o2V1ByaWRKSDVNbStNTzlHdXA5aVZV?=
 =?utf-8?B?UDR2ZnB1cHZDNzVOQXcrLzhWL3NLMjZHSTJubGZ6cW1XclhxWHBMZ3lCWHd3?=
 =?utf-8?B?WGZiMWxrK0w1UzlnNkhZNjVzMUxycG5PSEtwaHBOQy9CVUhuOHdrdUtxZDBJ?=
 =?utf-8?B?aVRaU0FjZ3hDNTVaTElBR3F5UWk3cHkvL3lBZnhraVRicDFFY3dKd0xkaEpy?=
 =?utf-8?B?dVluQUFRaWoyd3RuVnk2WlI4ZkdiWWgzOE9BS3dvZlZIRktFL3MwZG8ycXU0?=
 =?utf-8?B?Yi82S0N6ODR1R3ppdDFBWkdPOUt0bVV5QXFzSWpHeEYxWlRxREZRZWp6UWV5?=
 =?utf-8?B?bjI3d05NeS8zS3RidGQ1TVVBYzNpaHM5U2xhZW5qNlUrRWdWenZKcFVObjd3?=
 =?utf-8?B?bmRHZXJvU0wxZTdjZVJIaFdyM1plaGRtcEVtWStrb2sxS2ZVY3Z1OFBGZkQv?=
 =?utf-8?B?L3dQcEkrSnU2dUdkUEtwS00zVzNIWnZyNDl5Wk4wV1Z2SUNzb2NqdkdlM0Nr?=
 =?utf-8?B?angwbjNiUUtISkl4Y2Y5MlNRdlFIa3JHOVo5b3NaOG9yU0F4VS8rRG1aaXFG?=
 =?utf-8?B?WUdvZ2JXdUZBTWd6VUtnVndMVW80alpoOHFmc0F4WS84N0psQ0o1TEVYTE5M?=
 =?utf-8?B?UU0vZlBvNFoxSkJzUU9wVzEwdmkzNmtQelAwcTF2NUhJZm1vZ3p5c1RlUUR4?=
 =?utf-8?B?U2xnMG9NVGFiS09hZWhScGJHTFQxWHIybGlpQkZqLy82Vm5tSEt0bzVZOVZ4?=
 =?utf-8?B?d250UjlVeklZdXJDMjV5cjNKM2gxeTBQcHBUN1RVL3dnN0d3SzRReEFRL0J3?=
 =?utf-8?B?cDJyVVo4U1h6Ukc0ck5qK2FJbmhvVWkxKzBLSllZdW42TGhTWGVqTm5vWmpG?=
 =?utf-8?B?MVg0VzFGWFhQeDN3MmNqcnJ6SzNMT3BFSzVpVVFzeGVXb2NkNExnazJyZnVj?=
 =?utf-8?Q?tnnzKThVc53q/u7Sbp1DBxk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <766F3D53C24D8345ABD11661197EFA04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684d8389-a598-46bc-0a2e-08dac74bab8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 20:55:04.0474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmFXT++uHB/zgVbsumWKKOY/e3xzHZaIhiaW9enuelmXA60YYzLSJwoUYPy8FnHx28h58W7M+XOcFHd63yHK8vF7rZflgcTiMsbl3HcGPHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDE0OjAzICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVHVlLCBOb3YgMTUsIDIwMjIgYXQgMDE6MjY6MjNQTSArMDEwMCwgUGV0ZXIgWmlqbHN0
cmEgd3JvdGU6DQo+ID4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzU6NTFQTSAtMDcwMCwg
UmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gPiBGcm9tOiAiS2lyaWxsIEEuIFNodXRlbW92IiA8
a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IA0KPiA+ID4gQWRkIHRocmVl
IG5ldyBhcmNoX3ByY3RsKCkgaGFuZGxlczoNCj4gPiA+IA0KPiA+ID4gICAtIEFSQ0hfQ0VUX0VO
QUJMRS9ESVNBQkxFIGVuYWJsZXMgb3IgZGlzYWJsZXMgdGhlIHNwZWNpZmllZA0KPiA+ID4gICAg
IGZlYXR1cmUuIFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGFuIGVycm9yLg0KPiA+ID4gDQo+ID4g
PiAgIC0gQVJDSF9DRVRfTE9DSyBwcmV2ZW50cyBmdXR1cmUgZGlzYWJsaW5nIG9yIGVuYWJsaW5n
IG9mIHRoZQ0KPiA+ID4gICAgIHNwZWNpZmllZCBmZWF0dXJlLiBSZXR1cm5zIDAgb24gc3VjY2Vz
cyBvciBhbiBlcnJvcg0KPiA+ID4gDQo+ID4gPiBUaGUgZmVhdHVyZXMgYXJlIGhhbmRsZWQgcGVy
LXRocmVhZCBhbmQgaW5oZXJpdGVkIG92ZXINCj4gPiA+IGZvcmsoMikvY2xvbmUoMiksDQo+ID4g
PiBidXQgcmVzZXQgb24gZXhlYygpLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIHByZXBhcmF0aW9u
IHBhdGNoLiBJdCBkb2VzIG5vdCBpbXBsZW1lbnQgYW55IGZlYXR1cmVzLg0KPiA+IA0KPiA+IFVy
Z2guLi4gc28gbXVjaCBmb3Igc2hhcmluZyB3aXRoIG90aGVyIGFyY2hpdGVjdHVyZXMgSSBzdXBw
b3NlIDovDQo+ID4gDQo+ID4gVGhlIEFSTTY0IEJUSSB0aGluZyBpcyB2ZXJ5IHNpbWlsYXIgdG8g
SUJUIChleGNlcHQgSSB0aGluayB0aGVpcg0KPiA+IGFwcHJvYWNoIHRvIHRoZSBsZWdhY3kgYml0
bWFwIGlzIG11Y2ggc2FuZXIpLg0KPiA+IA0KPiA+IEdpdmVuIHRoYXQgSUJUIGlzbid0IHN1cHBv
cnRlZCBhbmQgbmVlZHMgdGhlIHdob2xlIGxlZ2FjeSBiaXRtYXANCj4gPiBtZXNzLA0KPiA+IGRv
IHdlIHJlYWxseSB3YW50IHRvIGNhbGwgdGhpcyBDRVQgPyBXaHkgbm90IGp1c3QgbWFrZSBhIFNo
YWRvdw0KPiA+IFN0YWNrDQo+ID4gQVBJIGFuZCB0YWNrbGUgSUJUIGluZGVwZW5kZW50bHkuDQo+
IA0KPiBPbiB0aGF0OyBBUk02NCBleHBvc2VzIFBST1RfQlRJICh0byBiZSB1c2VkIGJ5IG1wcm90
ZWN0KCkpIGFuZCBoYXZlDQo+IGFuDQo+IEVMRl9BUk02NF9CVEkgbm90ZSBmb3IgdGhlIGxvYWRl
ciB0byBib290c3RyYXAgdGhpbmdzLg0KPiANCj4gV2UgY291bGQgY28tb3B0IHRoYXQgc2FtZSBp
bnRlcmZhY2UgYW5kIGluc3RlYWQgb2YgZmxpcHBpbmcgYWN0dWFsDQo+IFBURQ0KPiBiaXRzLCBo
YXZlIHRoaXMgdGhpbmcgbWFuYWdlIHRoZSBsZWdhY3kgYml0bWFwIC0tIGJhc2ljYWxseSBoYXZl
IHRoZQ0KPiBsZWdhY3kgYml0bWFwIGZ1bmN0aW9uIGFzIGFuIGV4dGVybmFsIFBURSBiaXQgYXJy
YXkgKGluIGludmVyc2UpLg0KPiANCj4gQmFzaWNhbGx5LCBoYXZlIGV2ZXJ5IHBhZ2UgbWFwcGVk
IFBST1RfRVhFQyBzZXQgdGhlIGJpdCBpbiB0aGUgbGVnYWN5DQo+IGJpdG1hcCB3aGlsZSBldmVy
eSBwYWdlIG1hcHBlZCBQUk9UX0VYRUN8UFJPVF9CVEkgd2lsbCBoYXZlIHRoZQ0KPiBsZWdhY3kN
Cj4gYml0bWFwIGJpdCB0byAwLg0KPiANCj4gQW5kIGFzIGxvbmcgYXMgdGhlcmUgaXMgYSBzaW5n
bGUgMCBpbiB0aGUgYml0bWFwLCB0aGUgZmVhdHVyZSBpcw0KPiBlbmFibGVkLg0KPiANCj4gKG9i
dmlvdXNseSB3ZSBjYW4gZGVsYXkgYWxsb2NhdGluZyB0aGUgYml0bWFwIHVudGlsIHRoZSBmaXJz
dA0KPiBQUk9UX0VYRUMNCj4gbWFwcGluZyB0aGF0IGxhY2tzIFBST1RfQlRJKQ0KDQpUaGlzIGlz
IGFuIGludGVyZXN0aW5nIGlkZWEuIEknbGwgaGF2ZSB0byB0aGluayBhIGxpdHRsZSBtb3JlIG9u
IGl0Lg0KDQpPbmUgbm9uLWltcG9zc2libGUgaXNzdWUgd291bGQgYmUgc2V0dGluZyBJQlQgaW4g
dGhlIE1TUiBsYXRlLiBFYWNoDQp0aHJlYWQgd291bGQgaGF2ZSB0byBiZSBpbnRlcnJ1cHRlZCBh
bmQgaGF2ZSBpdCBzZXQsIHdoaWxlIG5vIG5ldw0KdGhyZWFkcyBhcmUgY3JlYXRlZC4gTWF5YmUg
dGhpcyBpcyBlYXN5IGFuZCBJIGp1c3QgZG9uJ3Qga25vdyBob3cgdG8gZG8NCml0Lg0KDQpUaGUg
b3RoZXIgdGhpbmcgaXMgdGhlcmUgd291bGQgYmUgb3ZlcmhlYWQgY29tcGFyZWQgdG8gYW4gSUJU
DQppbXBsZW1lbnRhdGlvbiB3aXRoIGEgc2VwYXJhdGUgaW50ZXJmYWNlIGZyb20gQlRJLiBXb3Vs
ZCBoYXZlIHRvIGxvb2sNCmF0IHRoZSB0cmFkZW9mZnMuDQo=
