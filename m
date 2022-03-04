Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC74CCB50
	for <lists+linux-arch@lfdr.de>; Fri,  4 Mar 2022 02:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiCDBbb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Mar 2022 20:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiCDBba (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Mar 2022 20:31:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2970C17B0FC;
        Thu,  3 Mar 2022 17:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646357444; x=1677893444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DhY6fjGJFQGJ8Y8K6TlgMwryiRpb8OUKhos+Wg8CPic=;
  b=TBov/k9zYpDX2b2pEQsZ0Mfe9055KRkHbSvE/YDHCB3jmHuWPwnbX+i4
   uR2/1mPzdFabGNqu2ZUrNz0+L0rqTGX3igjGuhkck7o7uztA/SS7UrcSL
   jOo2UtUWcz5hAAqDY8arPE7G+nSOAEVuXK7fNgrBbMnpD0Nwd0Qulur0V
   YdG7TrjLRprNN38oqrNcyIXNORs8P+niJ4pEcPyazR7u0yTkdGDNukJAi
   nvgpag6d4dhb8KZ/6M/ZsLx9DgwRiMF6A1ZvuIRpECrbsxiiLGESm7iHZ
   5vIHCZIJ0YYELjmma+hx8fs2GPbUD+OAupJVab0BS5wALZrLl4sndwBEN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="253597460"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="253597460"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 17:30:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="511682362"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 03 Mar 2022 17:30:43 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 17:30:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 17:30:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 3 Mar 2022 17:30:42 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 3 Mar 2022 17:30:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZZr99U3MyfK5LKmbnicGUJONfzIoow/YWXdQLych0h8nUTtcE0AKu3QDUfrDVi8f4gz3DbIYPf2aPgOkyaXqfjGu7JY7Qlws95uGcwN56aQdUhj4lMyW7gNMASRJrJHCysOeibfCCAGAmzEMS2VZ6Nq5YYShm9f7+TY/rWSpD4maUb4IlnGYrofYn6LUEi5d8XO7k3Gh5iDk0+YAIbySm9GmtCwUukslR/c3BsfOo/3eWXDl7tM7PK4sRYivZRWf5DhXhnY/2jvc90q1omPJ1Ntm13gBrr1+unFF2NVvRMjiMZ46gWX9+dx5PUwgd31/nXnTLivk15p70O5lgeGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhY6fjGJFQGJ8Y8K6TlgMwryiRpb8OUKhos+Wg8CPic=;
 b=DGHz1OQZ1x9W46DsJ5/CMd4faYn64nPoZuxKCrMVUyPWN+Ugk0HtCYlz33UhiizigZUur1Ck7R4XKlP8dvVlEDRt+EBaDznSHLcaUbOzyv781wL7TQnWyO4BFllV7XbAZtnnqzleqVUshXQ3hwcVIBnPv3BoK83kqfwdp5goR5B8DUAvytogzvwJG3jLK72izUUNQVn73tSG5YcunREhxK7577y5OssCXK9k4gbyIKrHMghvHGAmKMXGRACT0Eoppd6Evq2TbXdxpl8yGSjZdP6zbHoZxKZJtH0tqPMebi0LcYin9yL1hvdq+epa30Zd7hyd2iecMWKQzzWU1frsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA2PR11MB4779.namprd11.prod.outlook.com (2603:10b6:806:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 01:30:39 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::e593:28be:c2a3:a163]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::e593:28be:c2a3:a163%10]) with mapi id 15.20.5017.029; Fri, 4 Mar 2022
 01:30:39 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>
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
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyG5jiAgADTxwCAAJnkAIABGRSAgAADewCAAHMeAIAAC4MAgACbY4CAAZeygIAddLsAgAAA+YCAABC1gIAAF8EAgASAo4CAADfAgIAAKfMA
Date:   Fri, 4 Mar 2022 01:30:39 +0000
Message-ID: <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
References: <YgI1A0CtfmT7GMIp@kernel.org> <YgI37n+3JfLSNQCQ@grain>
         <357664de-b089-4617-99d1-de5098953c80@www.fastmail.com>
         <YgKiKEcsNt7mpMHN@grain>
         <8e36f20723ca175db49ed3cc73e42e8aa28d2615.camel@intel.com>
         <9d664c91-2116-42cc-ef8d-e6d236de43d0@kernel.org>
         <Yh0wIMjFdDl8vaNM@kernel.org>
         <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
         <Yh0+9cFyAfnsXqxI@kernel.org>
         <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
         <YiEZyTT/UBFZd6Am@kernel.org>
         <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
In-Reply-To: <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acf0428f-dc8a-47de-c23e-08d9fd7e975b
x-ms-traffictypediagnostic: SA2PR11MB4779:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR11MB477941505ACCE37D395338FDC9059@SA2PR11MB4779.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nw8L9MLsX24Q9BkVTrFa0BvEwVX1Vt/ZBzfaFz7a1GqpSQuHr2J4Ht9Out4e3f8hAFyav35DZ/fgBnluDw8aQq3wNlTxsTnlRBmrfAJGdINT6cxexti5C9ZsHID7o7cVyHdM75Ag/PxQ1pOh5lpG+9IevnJg23zvBOFGjT3nBTLJH4Jj2zMcPKXzSet7Sm3HxZCCvXYowxblqMw6eaNQTLqu/C0Jw9f8AzWpXRsHSyUrXU28fOqinWcvFqYMCQ7wP2aOoY5Vp0Yoex57GBCM3ybf1WdkQETJsKWTos7Emzg/erIdwlTl+eTCCbFRhkHm9b3WOUC3FQ2MO5giHvZb660EVZNuhdQGTbOMBr24qc6sRGeZ2shDYsUieJJ7pDMOb15vb4B/NjvxHpmTVvl2lrMGJlGhutITID7KVYD8TnfbQ/KazS4kG/ArIcg22PymmM0kQ9iIleQVmCLtB/9VVdm/Q3ZTlFEwTUt6EzQbjTDGLalsVtRjTmosbAXIrrqoHf5fmpwEJUaS6uxO9yecx3jMCjm2VEjyy3Io11Jj8zYiQvG0BJ478fPSdwlS3bVYzzcDXFl5yOEb8OH3KMW/VrvgVfvizetjuRREbglcaYGuFMcNXA5NTx+8aQfIH+TcXd7FiRGovZq+ySqRuW0pkA/86CWP3N0Dy3PfLyzonykIvReFhjCnAoZLGhRMbKXxdeZ37FmM1Erj/NaX6Bwt26/QG45ry3/Re5W0/zZgoSE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(38100700002)(4326008)(38070700005)(66476007)(122000001)(64756008)(66446008)(66946007)(76116006)(2906002)(6512007)(82960400001)(6506007)(71200400001)(6486002)(508600001)(36756003)(8936002)(83380400001)(2616005)(86362001)(54906003)(7406005)(7416002)(26005)(186003)(5660300002)(110136005)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1FIRGFtTUlBVDBrNG5oZldTVDZ2QTNCcTg1RE9BVjlZNmg3cEZBWFZhQ0tH?=
 =?utf-8?B?NWJDNTk0M0V5bTNnMDF5SWphZG5PdCs2dmErdTR6RlZxQUs4WDJmWUtOV3ZT?=
 =?utf-8?B?OVJDVkFiYUJ0K0Q4WkpRZnI3SStLQWNlZ2tnUzlJeXlTTXIxUnpaUHVTMVp1?=
 =?utf-8?B?Tmx3bXV4YWpiM3IxRmpGR0oyZVNlYVJETTVnSmluY3U1dDQvMmZGTHFwc1pt?=
 =?utf-8?B?THpIQzllYnkrL1RkMUVkTHJkUXJmbDlKMmZqUjA4d1JzT1hzYzM3ZUFYc3FF?=
 =?utf-8?B?VHRiVHpWT2hJQ2F1R1g5dDY3YkEwNUg5eGZldDR3L1AvL0xWWmNNa1hXOWhr?=
 =?utf-8?B?cCtxSzhMZTZYb3picXNIUmFCWWF4NzJNLzkvcTR5c3VGRTNTWFJyYk1ub29j?=
 =?utf-8?B?UUNtZitzWVRzNUxUZ3oxc09sMXoxYkJrK1dreXFSOVZyT3QzejhPVHdIZ0Nw?=
 =?utf-8?B?dTJhKzlVN2VFL3I3UHVhMDl2UlY0WVljWHc5VWxrQU9nS1NsZlE0VFJPK1pS?=
 =?utf-8?B?YjFvUCtreWRyaVlDVTFLM3ZvMys1QVl3MUphc0VZcTFzRzJYdGtLNUdEWkh0?=
 =?utf-8?B?MFhaQ1Ara3BZTUwxb2E2cE81cDBIUFZUQ3ZaanJBM29QMlZ0blRPWDJWWVZ5?=
 =?utf-8?B?ZlhPWFpwMnYxaStrV0NPOTFTeC8xQ3MyclordWlaajkwUm5Kd0FvdmZ2TUFs?=
 =?utf-8?B?VXdxd2tEcndkL0h3QjFVWHpSRjZKVHJmYVBLYmRtVVdhT3ZrOG5pWTVBVFdY?=
 =?utf-8?B?QlpYOVQwSWN6OE9mQ042UTAzS0VpclhEK1crb0ZzRWQwZWgzWWdnZ29lcnRM?=
 =?utf-8?B?dFhEU1VYa2RFM1hMemdUNlYrNDdGYUExZ2l6bERnUTlNeWsrRjN5bXlvd3Zr?=
 =?utf-8?B?ZmpKM2VaclhQdTRJNUIvN2hKdHoySG1nUHFrNVRYYlppQ3doa2VtN3JvVmNU?=
 =?utf-8?B?ZW4wTWx4ZmM2ZGl6QmlPaDEvZmFIczlFUHlGSjc0T1FJb3NPSHl4eHZQbHJW?=
 =?utf-8?B?UU0wU0pDdVZGbThmNnlWbFVWbWRzdFJqV1hvNEdKdGxDMFpnTlRtay96RHFi?=
 =?utf-8?B?U05IcjdicWlQMXczdmxtM25SZWxZQWxtQkJ2R1ZMcTdOWEF6NHJ4Tjk3Q2pt?=
 =?utf-8?B?ZEF0YVlLdENidHZhNTE3K3FSWjRndTg5TUcxYkxNR2lwQ2pNTFU0dGQ1eTl1?=
 =?utf-8?B?MFRHOFhCTjlBK0pFNUlrdWhZbTMxakhtZEFhM3JramNuMml5bGJJQk85SE5I?=
 =?utf-8?B?YXQyM0FBVXNZemxhLzR0UFRUMjJCZ0FBM1NNTWtSTktDVlRBRW0yaVBKdkov?=
 =?utf-8?B?L3ZJc0VrT1NVWk1BMFZuS2pIVzZCMDVTSHVYcWppVkdrM215MWNqTGJXOFJ1?=
 =?utf-8?B?cEQ3QXJaN1RHYzV3OFZUVG5SOStRM2NtZEIwZ3oxUkxWTlpzZlU2MEM3NVlC?=
 =?utf-8?B?L1c0a0lCWExOQmJMU0h3V1hNOGVzM0NBaDFGTzl5M1hEODFHQU0yZmU3a3BH?=
 =?utf-8?B?dy9kZmxKR1FuSzFnMEdpQTljSGVPc1liUlA1WHJaSjBCSFhtMEZUQm1zRHZu?=
 =?utf-8?B?VWRNSHVQbHlpMjhRRzVKVUhCWW5Gcjl3Wkl4b0xhUjJadkRGdEVJNUlDNU5u?=
 =?utf-8?B?ZkNwUHdqSFZrenVCL05CcTErOStweCtqZjdSZ211RW5WdWlXOEhhazhzNkFY?=
 =?utf-8?B?OXd5Nkp1UjZRTk82ZVdiZGNjcDd3OGpLbFFvUGJNZTBtaWtjcTVwOWp6UzRm?=
 =?utf-8?B?WS9QMEthZ0VOaVJuTkZLWDhLYUszbzYxRVpBVW83QlpTemRZU0gvUFZlbDZZ?=
 =?utf-8?B?WVdjMnlSVGtLK0RwY1ZqeWdieDVoci8zTWo5UVRmVFM1aHhrSkZCTDVhbUFt?=
 =?utf-8?B?YXN2THFLWHE5ZUMxMUFOUWZNc0xJOGdKMERPTmdmc1VobFpZbFFoL0RSaGd4?=
 =?utf-8?B?VElkL3d3UEZiSjFNM1RycTlqcWxWSVlMN0JXS0dUZmtJRzlIWUZtNDhNZXNR?=
 =?utf-8?B?bGFFbmxjbnJHd2V5SDRuMTZkRFRIZXBMQktwUGdtRFNvNVhmd3JHRmN0YnRV?=
 =?utf-8?B?K0twUjFrQUhUUlM2SnNTNDQ1SU4wNE5QbDI0ZEx1SVlLVmVqOHVoTldBb1Vt?=
 =?utf-8?B?S2FxTmlzdkNYZlZUWkMxUFdVME1aTjZtY25YS3BDcHE3MzlnNXh6YVJWZXBV?=
 =?utf-8?B?ejNuWkhXa1k0L3VQWVhiVHpMTzJtclZPVGVrUzFqZVBMbzNxcXhmTmQ0WXlO?=
 =?utf-8?Q?hi+yabsrorP+JnBJA18/dXzmgraiWVFG7Nb/iE7Ank=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D5C4C785C90274C962746B04FAA9DBB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf0428f-dc8a-47de-c23e-08d9fd7e975b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 01:30:39.3747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cayhz8Uf05JmFwfTgiNC8OIERKky264R/NU74lt+rrRJMvOYC2ABvyV+V46Jwh4XYyN3LhpcqHz7wUhBRpSwZ/NZGuxJcDO00sx+eQH+9Mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4779
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIyLTAzLTAzIGF0IDE1OjAwIC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+ID4gPiBUaGUgaW50ZW50IG9mIFBUUkFDRV9DQUxMX0ZVTkNUSU9OX1NJR0ZSQU1FIGlzIHB1
c2ggYSBzaWduYWwNCj4gPiA+IGZyYW1lIG9udG8NCj4gPiA+IHRoZSBzdGFjayBhbmQgY2FsbCBh
IGZ1bmN0aW9uLiAgVGhhdCBmdW5jdGlvbiBzaG91bGQgdGhlbiBiZSBhYmxlDQo+ID4gPiB0byBj
YWxsDQo+ID4gPiBzaWdyZXR1cm4ganVzdCBsaWtlIGFueSBub3JtYWwgc2lnbmFsIGhhbmRsZXIu
DQo+ID4gDQo+ID4gT2ssIGxldCBtZSByZWl0ZXJhdGUuDQo+ID4gDQo+ID4gV2UgaGF2ZSBhIHNl
aXplZCBhbmQgc3RvcHBlZCB0cmFjZWUsIHVzZQ0KPiA+IFBUUkFDRV9DQUxMX0ZVTkNUSU9OX1NJ
R0ZSQU1FDQo+ID4gdG8gcHVzaCBhIHNpZ25hbCBmcmFtZSBvbnRvIHRoZSB0cmFjZWUncyBzdGFj
ayBzbyB0aGF0IHNpZ3JldHVybg0KPiA+IGNvdWxkIHVzZQ0KPiA+IHRoYXQgZnJhbWUsIHRoZW4g
c2V0IHRoZSB0cmFjZWUgJXJpcCB0byB0aGUgZnVuY3Rpb24gd2UnZCBsaWtlIHRvDQo+ID4gY2Fs
bCBhbmQNCj4gPiB0aGVuIHdlIFBUUkFDRV9DT05UIHRoZSB0cmFjZWUuIFRyYWNlZSBjb250aW51
ZXMgdG8gZXhlY3V0ZSB0aGUNCj4gPiBwYXJhc2l0ZQ0KPiA+IGNvZGUgdGhhdCBjYWxscyBzaWdy
ZXR1cm4gdG8gY2xlYW4gdXAgYW5kIHJlc3RvcmUgdGhlIHRyYWNlZQ0KPiA+IHByb2Nlc3MuDQo+
ID4gDQo+ID4gUFRSQUNFX0NBTExfRlVOQ1RJT05fU0lHRlJBTUUgYWxzbyBwdXNoZXMgYSByZXN0
b3JlIHRva2VuIHRvIHRoZQ0KPiA+IHNoYWRvdw0KPiA+IHN0YWNrLCBqdXN0IGxpa2Ugc2V0dXBf
cnRfZnJhbWUoKSBkb2VzLCBzbyB0aGF0IHN5c19ydF9zaWdyZXR1cm4oKQ0KPiA+IHdvbid0DQo+
ID4gYmFpbCBvdXQgYXQgcmVzdG9yZV9zaWduYWxfc2hhZG93X3N0YWNrKCkuDQo+IA0KPiBUaGF0
IGlzIHRoZSBpbnRlbnQuDQo+IA0KPiA+IA0KPiA+IFRoZSBvbmx5IHRoaW5nIHRoYXQgQ1JJVSBh
Y3R1YWxseSBuZWVkcyBpcyB0byBwdXNoIGEgcmVzdG9yZSB0b2tlbg0KPiA+IHRvIHRoZQ0KPiA+
IHNoYWRvdyBzdGFjaywgc28gZm9yIHVzIGEgcHRyYWNlIGNhbGwgdGhhdCBkb2VzIHRoYXQgd291
bGQgYmUNCj4gPiBpZGVhbC4NCj4gPiANCj4gDQo+IFRoYXQgc2VlbXMgZmluZSB0b28uICBUaGUg
bWFpbiBiZW5lZml0IG9mIHRoZSBTSUdGUkFNRSBhcHByb2FjaCBpcw0KPiB0aGF0LCBBSVVJLCBD
UklVIGV2ZW50dWFsbHkgY29uc3RydWN0cyBhIHNpZ25hbCBmcmFtZSBhbnl3YXksIGFuZA0KPiBn
ZXR0aW5nIG9uZSByZWFkeS1tYWRlIHNlZW1zIHBsYXVzaWJseSBoZWxwZnVsLiAgQnV0IGlmIGl0
J3Mgbm90DQo+IGFjdHVhbGx5IHRoYXQgdXNlZnVsLCB0aGVuIHRoZXJlJ3Mgbm8gbmVlZCB0byBk
byBpdC4NCg0KSSBndWVzcyBwdXNoaW5nIGEgdG9rZW4gdG8gdGhlIHNoYWRvdyBzdGFjayBjb3Vs
ZCBiZSBkb25lIGxpa2UgR0RCIGRvZXMNCmNhbGxzLCB3aXRoIGp1c3QgdGhlIGJhc2ljIENFVCBw
dHJhY2Ugc3VwcG9ydC4gU28gZG8gd2UgZXZlbiBuZWVkIGENCnNwZWNpZmljIHB1c2ggdG9rZW4g
b3BlcmF0aW9uPw0KDQpJIHN1cHBvc2UgaWYgQ1JJVSBhbHJlYWR5IHVzZWQgc29tZSBrZXJuZWwg
ZW5jYXBzdWxhdGlvbiBvZiBhIHNlaXplZA0KY2FsbC9yZXR1cm4gb3BlcmF0aW9uIGl0IHdvdWxk
IGhhdmUgYmVlbiBlYXNpZXIgdG8gbWFrZSBDUklVIHdvcmsgd2l0aA0KdGhlIGludHJvZHVjdGlv
biBvZiBDRVQuIEJ1dCB0aGUgZGVzaWduIG9mIENSSVUgc2VlbXMgdG8gYmUgdG8gaGF2ZSB0aGUN
Cmtlcm5lbCBleHBvc2UganVzdCBlbm91Z2ggYW5kIHRoZW4gdGllIGl0IGFsbCB0b2dldGhlciBp
biB1c2Vyc3BhY2UuDQoNCkFuZHksIGRpZCB5b3UgaGF2ZSBhbnkgb3RoZXIgdXNhZ2VzIGZvciBQ
VFJBQ0VfQ0FMTF9GVU5DVElPTiBpbiBtaW5kPyBJDQpjb3VsZG4ndCBmaW5kIGFueSBvdGhlciBD
UklVLWxpa2UgdXNlcnMgb2Ygc2lncmV0dXJuIGluIHRoZSBkZWJpYW4NCnNvdXJjZSBzZWFyY2gg
KGJ1dCBkaWRuJ3QgcmVhZCBhbGwgODE5IHBhZ2VzIHRoYXQgY29tZSB1cCB3aXRoDQoic2lncmV0
dXJuIikuIEl0IHNlZW1lZCB0byBiZSBtb3N0bHkgc2VjY29tcCBzYW5kYm94IHJlZmVyZW5jZXMu
DQo=
