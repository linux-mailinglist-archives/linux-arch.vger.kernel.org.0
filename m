Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD767A18D
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jan 2023 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjAXSnJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Jan 2023 13:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjAXSnC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jan 2023 13:43:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967D2BF13;
        Tue, 24 Jan 2023 10:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674585754; x=1706121754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U2EWMTFR69Q1bevgZj0pFvUTGM1puYxkNayUHUe/wHI=;
  b=i5luXO4/zrLEKObfq1zUITyRTpg37TGQ701fVrnyhs/SBPRmh17jQuT6
   l4aCcZaRDqgUEZt+kQK7FhVDRl+B3DWJAJeeeyPUYDRJ7+ur3slko/mJk
   XZLR3e+wPi+0Jih60O0T0x15cFVtKYg1R4vtNMrEPkFtWPbPa28WIFmgd
   KGWky8CHKG+bOcpkmi/IHGY0o6wWIOua5hs5K12NFFEsn+fbzUVb+QYCX
   aUF6BBUH83gQssDxxoeD/mvogeOcpDPkJJjB30lAp1F78RcgRUyTgcbTm
   QlkoX0NT3uLOlFmSVe+06CqhueDLxXHn+9tG6z268WZ8DyxBPQ9rNe2f5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="353651483"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="353651483"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 10:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="786184696"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="786184696"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2023 10:42:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 10:42:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 10:42:31 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 10:42:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWHu3VKH+nDhSTqjxjabDR9t1fzGnxnTJEmFkMZcUDcclKRRl7IKu5GO1oKmR0Q+Tqg20D0V33+J0CJ/6myIUFnmJHc62wDNxzHHTjAB9EYbZ7gqP1g4VMP1lqFYS/xR7jS5cHZobSEIqAfJNdGGwVx2NKaexxMxeW6PkEeBNWK/QYA+Jve5ZM/pEVzABLlqefSoTQul5oKwXXf9YOAa8TLUinyVIC/DEP9MNN5KvykDblaEixk3KgBMfhRdlufNo3CLKicfnw3j2i2JfscOKsyu8NWLolQkqOKNxX4ksAMvJGkBhdViEkdq93/ue+TaWFZSnuRdStMeLnnK0wV5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2EWMTFR69Q1bevgZj0pFvUTGM1puYxkNayUHUe/wHI=;
 b=HJIpIZb8sQSq878g2B91ojrYGbdXajp7Y82ayQPd5Qu0yOh3AEUfQWZExnNAWtaOZp+x3XJaTKHukOkrfryUAzl4GHuNP5tZKfThWLzZ7RzPXxw+kGrAHF0wV4wxx7R1oBH4QUW10er/YqS8UqY6MyOdSAFTD0xxLv//OVkXReBOMJ7KEKPy1OeVEVFHrqhkYhButByygh/jWRxLyVQwNRiPbJy2JrJONSvdWc4bwHzkx9/arDyUlpVp2arkEG2A9JQrVroK+PgzyQBLdtHTJl5vtdk59ti4sTMVOMsKpU/Q3twEOz4vxm7uke33O2s/6uM36bOZ4LL4mIWaexmYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 18:42:28 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 18:42:28 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "fweimer@redhat.com" <fweimer@redhat.com>,
        "david@redhat.com" <david@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Topic: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Thread-Index: AQHZLExd1uIADC0jSEapGta3tBezb66rvFwAgAAatYeAAKfVgIABScuAgAAl7IA=
Date:   Tue, 24 Jan 2023 18:42:28 +0000
Message-ID: <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
         <20230119212317.8324-24-rick.p.edgecombe@intel.com>
         <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com>
         <87fsc1il73.fsf@oldenburg.str.redhat.com>
         <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com>
         <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com>
In-Reply-To: <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS0PR11MB6445:EE_
x-ms-office365-filtering-correlation-id: b2cad8b1-a35a-4ead-dd80-08dafe3abe90
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrfRmLv55GaZLE3We7P5AirJlgM9EueGRkZOfo+zfit4hbozJRZZt9O6GavMWVrz/jVc2GUARTgeLLy07Cm+UpJfSr+kcktSsHrfw3+2UWL46yJcbU/JxotWmQKhB+/Lf7nZ8SmihGOb7BWhC19kC2cuZ46dGPfINKH7YutQO4q6OznDIoRHxisu06mlSg/+sgk8qQV5C+DUi+9mw8FHTENK0AakDcllLBJy0UQ635jzvB62nTWg3vukmfFw+gXuSqj9WKHMmqmmvBgpd3gY4wGw3ng5GiCoR5kfH5CrjczTltvNrbooxwsppPLNUD3OsUWSMERa+BzG+mA4OL4w1RPEQYQEGewYce7qDxSgj1B8v8NDoUVT3VUo7aWwpDpqudk93dTy1/+of4Lu1ZZrrnLJBoQebb1PP0ngjmdUm9lsCrNU2ULqOb/3U4h/sDyxVXWJBDPyacWgFZtXjTfRAZmaj+VcXy//ssji79xPt9MiH5k0NyiPg80jaHBIwjHq0UimmP+TNSanlVAyVlKosmBaIrH/PkN7U2yeMNQ5bMBi0K4Pa3ktgCVq7GKj50flOEv0T4HRpp2bYc4vaAJh8LMGon+vcQAkXxlpRCHTXzjAhOgmobUgNZ4CyIq+WQ6Ewuc4LAl5hlK41redgJFf/TM2a6wTxd827HDZ7/P0CO0r5BF/XTn8GoDqCA+5DFZ7rePl3IrwYn6LPgK45z4ZlpVC/UUrRcZEktR/UcHcIS4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230024)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199017)(38070700005)(86362001)(38100700002)(7406005)(64756008)(316002)(54906003)(2906002)(122000001)(83380400001)(82960400001)(71200400001)(6486002)(36756003)(478600001)(66946007)(76116006)(66446008)(66476007)(4326008)(66556008)(7416002)(8676002)(41300700001)(110136005)(2616005)(26005)(6512007)(6506007)(91956017)(186003)(5660300002)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1RTVDZOdlJUcTk0Z28rcHhUQWZKSFNEV3hWNzlUbTFpUStoajNpTDVQWUZU?=
 =?utf-8?B?OVVTR2lJeWpjaThhaGNrSFpoeTBFR3EyRmVJSWp2OFRPeGJTOGtGQzQxK1Jz?=
 =?utf-8?B?cW5iTjZ0VUhKYVVhNlNDVlMvSVZlVUNEakZBdnludEhqQmV6WEg2ejUrM1Ev?=
 =?utf-8?B?elU0MHNTRGJYMGgvb1lJMmlxUlFDVFdWWGxqeXRUMTc1Z2UxSm5vZFkyNU5F?=
 =?utf-8?B?NzhnUEY5ZjM4ZVptUDNkaEhFSlFybWtDS1ltaDdXbU1SSk5mcmxzbmRRVDNJ?=
 =?utf-8?B?ZHZIdXJXSWFEQWxnRDBLVVQxU3FTZWZDV3hqL3JGU2EwUU9YREdZMFJydmsv?=
 =?utf-8?B?cC9xQ0tVQW5XSUgrckZlOUIxeDZya0JrSWtrM0IvYUM1NmxwdU9jUGRLV3BR?=
 =?utf-8?B?SVY5YklYSkNLemtnaWVqZjZJb1VncGhGQmNsZHhMUkFRZmEwOFB6Qyt3aS90?=
 =?utf-8?B?NXRnMUhyaThTT01ZcVVITC8wUkdERWw0Y3dKc0RDUWVSdUp5bklrb2xOTGNS?=
 =?utf-8?B?T1pOTHRtb1hWRHVvSG93dW80UmJyT0srZGZKaWhaWlczaW05UTJJbDZVYUxF?=
 =?utf-8?B?dkRNQTlGQnJjYmFCdTlzNHA2T241aU1hdVljUjY0VDNQc3JRQm9JRjNwcXNW?=
 =?utf-8?B?dDNUMHhqS2tPeXVKUkk3QVN3Z0o2TUdleEk2ODQ1MWhQRlJVWkRGUVBHbTZw?=
 =?utf-8?B?TU5iUWRPYzBGMFVIbytrQ1FPbG5FeXhMYkJacVFrT1JHcUNZSFMrUGYycFQy?=
 =?utf-8?B?TEJrRDJ3L0s5YkVBNnVjK0M5YVpqOWRnbWFQT0lpQlhGUVNLS0FuY3BHNlBT?=
 =?utf-8?B?VFp5SmpveWZkTkJFOUlzSVdWcDU5dlBxMjM3VGFhVDNyTi9neGlvc09YdzdU?=
 =?utf-8?B?WnlXWkE5Y1cvUWdyZ09mWVVxWXhXeHcwSmFUaU9MY3lJMU5IWElrSFVZRmhy?=
 =?utf-8?B?cmV5d3NSeklCdFgwVmowUzV5RmFPNEtTMDVFVFhsUHdpcE9odmZmK09lbTho?=
 =?utf-8?B?L2xuRVVZN3hZR2xLbzFHK0hjWUJPcnpOa1ZzVytVVm9Sd0NnS3YxSWl5SU1I?=
 =?utf-8?B?ZlphL3ZId056dGZEQVBTUDVzSi8waXBJYlRLczZ6VWFlSWFiYks0S2hGdWRw?=
 =?utf-8?B?WUN0d0ExN1pMdTdLY3Bwd2FsY2Z3aWMzNytsS1FwWDlSVkxmMjVPMW9UcGln?=
 =?utf-8?B?RFlTNVpLaFZlMjFDanpCdWFpSXgvRjljVFlvSGFSMWhNcnVtWFlBVWdLUVNX?=
 =?utf-8?B?T3YzMnlad0hGNElWRmp0dkwrSndZOE5JdG5WbVJDQlJxeC81dzZDLy9saUF1?=
 =?utf-8?B?ZTNGUy9IOE92ejJFMmNPTzRUcFlGMXlKVDhFUmJsWjhXSmk4RWllV1dHaUhT?=
 =?utf-8?B?RE96L2I4RUFXdEI1MjdVSXZ0aEh3NkxiL0wwTlZiRjBMTVordWdLYnNMVUZB?=
 =?utf-8?B?cE9McTFPWGkyN2VLNkUzd3liR1I5QUtuMTdUYW5mL2d4bndYblN3dW9qU0Jw?=
 =?utf-8?B?U1Z6V2hJWkpQRzFyZ2gyblFkdUhPNzVuNVQyd01xVnNtN1BRSm5PdjBOWUpJ?=
 =?utf-8?B?SFlKV0hrZy9CWW83SHRKSzJFVUF0eTF1dWdGdGNlcnZQRmlTTjlsY1ZjTG5B?=
 =?utf-8?B?UWRwTHJGSm9FOWdSQ2VhQ1F1bTQvTmx5cUh3S2JCUjE2eEhpZnB0dHVzNklM?=
 =?utf-8?B?QUV0bXFPYnpycWlOa3VXcDgvOHFHQlU4SVNYak9WM3phWlExSHBiMVdrSkNk?=
 =?utf-8?B?dmd2aGFHanZrVlg2Uk9Ud0lwL0M0UmROYkswbVBrcFlmMGdPTzJtLy9GOXFD?=
 =?utf-8?B?Sy85QUhuOStJN21PS1hUd0tva3JHMlRCS0sxa3B0QnFOVUlNaC84dml6NElv?=
 =?utf-8?B?cE44Ylgzb05uZVpHa09peDIxKzV0NlpsZ1l4NG9qOG9ja1JvQzhTTUZPSU5v?=
 =?utf-8?B?cFo5SEFKeU9rMnc2SmxRZVBBV3RTcmhxaVdQTlQ3RGRwbTczQmtIZngyZ0FE?=
 =?utf-8?B?WUJlczZsYUlnTkR5UTJOdGNaVnl6dnEwMzV3aFA5TUh3aXRWY2tWYTNwOUJv?=
 =?utf-8?B?Yk1PS2NGUEpPRzh0TGw0bjNnbTdFTkE3aEtGSUNHMGpDekFQb2EyZkZCSFZl?=
 =?utf-8?B?eURscXNpTXZIU1ExcURZQzZ4UDgxTWZVN3lTNXpSOGYvODdwcFdqRUFwcmVp?=
 =?utf-8?Q?XrHO0HUkurzG98SkNJzWMEI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCAD0A9D8971FE46B8EDB7375157AE88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cad8b1-a35a-4ead-dd80-08dafe3abe90
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 18:42:28.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgzsbmVZ5/4PqYL112ud7ojuA9flc8G/XG6RsEijQwupecFvMmYjHqQ7uxqnGOY2oA1rgIvahy48wGNFsneTveqT2Dc4i7eVo3RdeHfJRRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

UGluZyBDcmlzdGluYSByZWdhcmRpbmcgR0RCLg0KDQpQaW5nIEtlZXMgcmVnYXJkaW5nIC9wcm9j
L3NlbGYvbWVtLg0KDQpPbiBUdWUsIDIwMjMtMDEtMjQgYXQgMTc6MjYgKzAxMDAsIERhdmlkIEhp
bGRlbmJyYW5kIHdyb3RlOg0KPiA+ID4gSXNuJ3QgaXQgcG9zc2libGUgdG8gb3ZlcndyaXRlIEdP
VCBwb2ludGVycyB1c2luZyB0aGUgc2FtZQ0KPiA+ID4gdmVjdG9yPw0KPiA+ID4gU28gSSB0aGlu
ayBpdCdzIG1lcmVseSByZWZsZWN0aW5nIHRoZSBzdGF0dXMgcXVvLg0KPiA+IA0KPiA+IFRoZXJl
IHdhcyBzb21lIGRlYmF0ZSBvbiB0aGlzLiAvcHJvYy9zZWxmL21lbSBjYW4gY3VycmVudGx5IHdy
aXRlDQo+ID4gdGhyb3VnaCByZWFkLW9ubHkgbWVtb3J5IHdoaWNoIHByb3RlY3RzIGV4ZWN1dGFi
bGUgY29kZS4gU28gc2hvdWxkDQo+ID4gc2hhZG93IHN0YWNrIGdldCBzZXBhcmF0ZSBydWxlcz8g
SXMgUk9QIGEgd29ycnkgd2hlbiB5b3UgY2FuDQo+ID4gb3ZlcndyaXRlDQo+ID4gZXhlY3V0YWJs
ZSBjb2RlPw0KPiA+IA0KPiANCj4gVGhlIHF1ZXN0aW9uIGlzLCBpZiB0aGVyZSBpcyByZWFzb25h
YmxlIGRlYnVnZ2luZyByZWFzb24gdG8ga2VlcCBpdC4NCj4gSSANCj4gYXNzdW1lIGlmIGEgZGVi
dWdnZXIgd291bGQgYWRqdXN0IHRoZSBvcmRpbmFyeSBzdGFjaywgaXQgd291bGQgaGF2ZQ0KPiB0
byANCj4gYWRqdXN0IHRoZSBzaGFkb3cgc3RhY2sgYXMgd2VsbCAob2ggbXkgLi4uKS4gU28gaXQg
c291bmRzIHJlYXNvbmFibGUNCj4gdG8gDQo+IGhhdmUgaXQgaW4gdGhlb3J5IGF0IGxlYXN0IC4u
LiBub3Qgc3VyZSB3aGVuIGRlYnVnZ2VyIHdvdWxkIHN1cHBvcnQgDQo+IHRoYXQsIGJ1dCBtYXli
ZSB0aGV5IGFscmVhZHkgZG8uDQoNCkdEQiBzdXBwb3J0IGZvciBzaGFkb3cgc3RhY2sgaXMgcXVl
dWVkIHVwIGZvciB3aGVuZXZlciB0aGUga2VybmVsDQppbnRlcmZhY2Ugc2V0dGxlcy4gSSBiZWxp
ZXZlIGl0IGp1c3QgdXNlcyBwdHJhY2UsIGFuZCBub3QgdGhpcyBwcm9jLg0KQnV0IHllYSBwdHJh
Y2UgcG9rZSB3aWxsIHN0aWxsIG5lZWQgdG8gdXNlIEZPTExfRk9SQ0UgYW5kIGJlIGFibGUgdG8N
CndyaXRlIHRocm91Z2ggc2hhZG93IHN0YWNrcy4NCg0KPiANCj4gPiBUaGUgY29uc2Vuc3VzIHNl
ZW1lZCB0byBsZWFuIHRvd2FyZHMgbm90IG1ha2luZyBzcGVjaWFsIHJ1bGVzIGZvcg0KPiA+IHRo
aXMNCj4gPiBjYXNlLCBhbmQgdGhlcmUgd2FzIHNvbWUgZGlzY3Vzc2lvbiB0aGF0IC9wcm9jL3Nl
bGYvbWVtIHNob3VsZA0KPiA+IG1heWJlIGJlDQo+ID4gaGFyZGVuZWQgZ2VuZXJhbGx5Lg0KPiAN
Cj4gSSBhZ3JlZSB3aXRoIHRoYXQuIEl0J3MgYSBkZWJ1Z2dpbmcgbWVjaGFuaXNtIHRoYXQgYSBw
cm9jZXNzIGNhbg0KPiBhYnVzZSANCj4gdG8gZG8gbmFzdHkgc3R1ZmYgdG8gaXRzIG1lbW9yeSB0
aGF0IGl0IG1heWJlIHNob3VsZG4ndCBiZSBhYmxlIHRvIGRvDQo+IC4uLg0KDQpPay4NCg==
