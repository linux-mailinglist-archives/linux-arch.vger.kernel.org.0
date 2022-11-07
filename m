Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF67561FA6A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 17:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiKGQuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 11:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiKGQtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 11:49:55 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010E121813;
        Mon,  7 Nov 2022 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667839795; x=1699375795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DtTLpkWAEzW8EklXYlxF81Bjsod/XhSskraShl9XugY=;
  b=Oi48bv8/nZLI2Fv4xflUaOHXbDUOBBTIk7yGmQ6Tkpy1AAqkiFsHnAWM
   pFlg103YSAiRUIviZdDMyDazG0+88ZnrBOuJoEt14J91YMKUrovF4unnH
   vf5rGLZ2gmePIWjGDZF/CfWnp6rF1rGhoy/2hE8XV/hb/TrkeFyqaWxTP
   pkIjCErIGcJ4NMdL1y8XfGDH1ug1eGY3mWD+V2FCdV6R3DODB+OHXxXQ4
   q+mNoATf9HKc7TO/gEzqLqReFcmD58yHCF5L0w4ayeQN9Zi+Q99WckLXG
   ogX3k3tV00FgM9n9pMbztOPw7ZiDe5wLOc+rQDvuBoDVkfmbwWQ1rmh/2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372582461"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372582461"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 08:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="881139936"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="881139936"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 07 Nov 2022 08:49:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 08:49:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 08:49:53 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 08:49:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giKGpmysiK12vip6BYpSKENUYPWEvQbYEl9TYt5dAfox/5gIEQJ9IaMC+H4kSUYaBS0noVcLuQgC+JKfs069qH670wAHQfE6UCey536vSNZY94x0veGXlKPQoxXqATjCEi78XSAH11nYrzA2ZLOZldAy1l6nnue/hpXCcfJAqebq7V8DgPNO1O+z6Ni8PB17RXPXuNRt/1cYswCEjCGiMXt2er3JDQsXvPb+q+XQechPf73vwF8QO3terRlClXmDbZ1zC3oWsHpuJQKNrNTp4nu7hmjswEjabLz0c6azLIvZNSx2ijxzPzdogJDHaYRAsX1HGMBiHdHFA4A34yqs+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtTLpkWAEzW8EklXYlxF81Bjsod/XhSskraShl9XugY=;
 b=n1d5U8ked1Ue46K5hEYd4yszxFs1DYzPZW9RVerB5dU3Icgn5xJNA//mMeRVV0XGFrgsi2hbYdSjaP7chlbe12YE1PXVdD4xXOohFpsFPnwHM+/gbUWF5lMNjIvkltoLqNr2nNGmw7riaYmdwnU7s/bhO2EmhRZoEwsK+i9H3tphgKasr8t4sDSSJO/U1lkeJGyp5Iwy5hIjpBsgCdJ6dBaBbNGU3iWdZPAtPGz8lb1mn1H8JIYhJ/sqe9TWCZr6WVZ8qqL7kI0l6Reku1+6V1ZY4slDSTtxy8h8l3Uqe8hhN8cKYy2Pu8TKMDtTsm/884yUEV7251ly4zw9tfS4fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ2PR11MB7545.namprd11.prod.outlook.com (2603:10b6:a03:4cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 16:49:51 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Mon, 7 Nov 2022
 16:49:50 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
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
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Topic: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
Thread-Index: AQHY8J5g32apAoMYh0aArgmkU40OVa4vYA0AgARQnQA=
Date:   Mon, 7 Nov 2022 16:49:50 +0000
Message-ID: <5b62474bfa48632803f5909f9c539a50242b991d.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-38-rick.p.edgecombe@intel.com>
         <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
In-Reply-To: <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ2PR11MB7545:EE_
x-ms-office365-filtering-correlation-id: 81eb5fe9-87fd-47f2-41c8-08dac0e01676
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bl6pJmJU1BMfbj+0i58NdvWt/KaA9o0agyRh8kMtNOps4/nmrAp7vE68RZEY03kuhSa+BK9mvAXTgm5VcxqjxndofBhNwA+Bd6Ntquijpq+hbHSOibjCeKjc4S4rR0nqsD+ktBitqFG+944YIJoNgYJWmbS9oK6jaRCPfKa6zfkiBdvGFPFCugUFPTGsPRLKPlFAhyk2GBTh74yHF34NQTQQpBBi8QISJPAn/TpNUA3CoEjnfd3meHNmGpw8LGyZtXNfT28Eke8kLvsRLRwVyxJwFLQm2Dff928SdFxDj507mf1jMMEUKDZ6XGO5B0M5MX9SK/bW4hlfdNr98QxgO1ts9V8FEovrHkrew65DflnROVYGIFc+cEk3tLPNMXGU042au5bsO3T30fvrS4FR3epdnkFtCrHM4HkOAoY4YKAn61+5Z7x32fLLbuLKfYdKICxxZEz4UNF8cHf1SoZ2EDkRVpJUxVqBLSOLTRR24dxwcw1W+FQJD+6fnqmuEQ+aT0JCA6m1tfpZ70vJ1Irs+U/aQKs9tGwZViBT0InhIaRSAbw+UvaGkYsAFMP3sp3SqfOHJnqwxJcgBUqjUTQdAO/DHAUw57UgR7MGsFUEX/lsjvWS4xOwLiCULlmuvFkUeRYNjI6weWzjytpJE3LYiKtIiCmjAWHbX6jX4vRBqSD08O18WOSQdFB6t8v39ExQLgUN3Vt6v/tDwMo3xXbE0u3zpOCv5eHup12Y0Dob0uMlmxlJfyxNrya3Fldld6MUvBHR1jd5jONhlKTTASOkXbLOuz4jP/CWwjp1RsA6Pe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(6486002)(2906002)(6512007)(26005)(478600001)(36756003)(6506007)(41300700001)(8936002)(38100700002)(316002)(6916009)(76116006)(122000001)(38070700005)(7416002)(66476007)(66946007)(82960400001)(66556008)(66446008)(4326008)(7406005)(64756008)(8676002)(4744005)(86362001)(71200400001)(54906003)(5660300002)(2616005)(83380400001)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlJNYUhVSkh1OEZuWENXWGxmZzFXLzBtR2N0TDF1OHYrc2QxeXhOM0VTcXpu?=
 =?utf-8?B?RjFqRDNlWHYxbUw4b0tjemhaaWZ5YnRPWlRXN3NVUlNBaCt0eHNlNFBBaXR3?=
 =?utf-8?B?cTZncXd3Y2NGUFBLUXdKK3pkTXZaQzc3bWhFK1hMNDhuVFRsWUhkWDhSUlJm?=
 =?utf-8?B?ZnowMTJUNTJhZ2NGS09WN05GSE9laG1TaWp2K09QWk5ySVVzSU1INjFyV081?=
 =?utf-8?B?V2Q4bzQ1R2RtVHI0K3E5Ujh6WTFaNU16THRGN2hHSmw0UkVJSlJMdWdlMElB?=
 =?utf-8?B?cGtUakZtNGtnRUJhMTIrbVVURlpnQUFFZ1FQZ1lwMTdjMTA5aWFGL3Rvc2Ux?=
 =?utf-8?B?ZWx1c1h2WUJ4d0o4WVU4WEpDeHFoNzdIMXp4amRCTmwwQm9GWGN3WXh2Ly92?=
 =?utf-8?B?eUQ0bENINkdxUUJJb2JzeVVTRjlmU3ZibUlFRnhEaDcxam54cG80SXhEbzMx?=
 =?utf-8?B?R3JMNWlocytpYlE1Q0xHamxUdW5oVlYzTmtUa1p4akdyZDZUU0gyM2hvanM1?=
 =?utf-8?B?RU1GVTU2aWZFVFV0OWVaM1lEV05OWjh0bmQwc3pnTnJtV3hKZi9zcnBVY1pv?=
 =?utf-8?B?QTVMay80LzU4eUNwZUFnQVpnVWg2ZlA0bnlxNkZwVFlKSXFjUHVZWGM5dk1S?=
 =?utf-8?B?STlsaENRc2c4ZkNNckVDMUdGc1d5N3prbHpWSjBDbDRUSzQ4MnhxRDlkVThn?=
 =?utf-8?B?OU0zMmZHMWxyYWZ1MGo1MW9zTHFDckRmOWlIZDU0NFliM0J6QVNIc2F2cUF0?=
 =?utf-8?B?TVpSMTNjcU5JZHdJeGJPRWlTa2cyMlhxT0NpdThHclYzSmhiQ2F3UVZOSE03?=
 =?utf-8?B?d0RINVg2ZURTMnRQRXdSRmRkM1hWK1BIenpQVDR0TFRwVGxHdnAzeURSTUM3?=
 =?utf-8?B?WjF2N1c4VjZpV212WFVtVG81cnhYRG1DMnE4YWNrdE9oOFkvYUNISUpSYWRD?=
 =?utf-8?B?OWU5cUcyNXMvTnBvMVkvamh6WFdZWGN0MTRZa1NsVmdRK0NudTlEZ0lGbjRv?=
 =?utf-8?B?QWpIaWlwckFMdk5qVUx4MWNtTEIzQVVrWWtud3hEeGlkUjFicU1Xd1Z4WGNQ?=
 =?utf-8?B?dlAwV0RSWVAzMGxhUTc2bEZveWpxZjFKY2phSktlc041QTJ6UmhCUHpUSWRT?=
 =?utf-8?B?K3VjT2V4bHNBTDQzejlhOUgzdVI1UmlBOUxucEwweVBpNDhPMnpqNlVtSHZV?=
 =?utf-8?B?NDVUVWFkbWhEbURVanFEUXN2WTJReS9udjlNcjdWUk1rdFcrQUp6ZEozZUpq?=
 =?utf-8?B?eW1telRmV3lVaE93aVZiclNmdGNyVlMvSHJqSUJvT3pKbGZFM0ZBRWtiaEhE?=
 =?utf-8?B?eFZkZFhKbytINzlPMTZTeUdEWDJlNlNEK3cyZytmcUJsT1ZETHpkQXdIREVx?=
 =?utf-8?B?V0VJZUpkblREK3NDclQ4UVdPeURqNHE2TENydk1rZ0tkTXgzdG43Mm5KZXFB?=
 =?utf-8?B?SXduemcwcGVUSmtsMFpERkhsUmZZNFZ3YkN6SVZxN2cwZ3c4YTZJaXk3b1Qv?=
 =?utf-8?B?dHFkajhJWmxaRm1mLzZrV0xZc3NIR3FlS3JEMmdRZDRadWlXdTZ1WkZYYldy?=
 =?utf-8?B?akhzYTJRNHdsWWkxNkM1Sk5ZVk9pQXEvV2V1SDRDbTZPOWN0OE0vc0JwRWdD?=
 =?utf-8?B?SFNjN2ZiQmJXcXZVaFQ1L1A4cTU5YjhWTElVZnRyZUxOS3pxVHNOdmhYSzFZ?=
 =?utf-8?B?K0RCMDZyWFFLUGVYbmxMTksxdVdTWVBFQS9EYmJQZmNrVEo1ZE9DeXViYVE1?=
 =?utf-8?B?QVlaZU5oWVRQQlBNaE14VUgyMWhjQ1dlSjhPSXgzQlgwWmVTKzJPOHFKeEVM?=
 =?utf-8?B?M3JCcm9IcWYvQXBCQStGSFpHcityZkhkQWw0M2c4bmxwN3AyQ2wzUmhySnF3?=
 =?utf-8?B?SmNsS01JWU9kQXJFMUU5N2tsbTVoMUw3engrWmVKOXJzT21uZ295ZXBNVnlh?=
 =?utf-8?B?UGttR0FXc3BUUC96Q3F0M01TZEIvTDJ1K0ZrNnJ6d3NJZmJYR05zNUNFQXlE?=
 =?utf-8?B?V2VvWUVoMkJwUW1xejJpbG1hOTJGeEl5NWFPRHNOdXlOS2dkekc1c2MrSzdm?=
 =?utf-8?B?Znk0bXlZRld6eDk4WjEyMGVQdGc1c3BTTk5FWHRyNkJVZWpTdGN2NmU3NFE0?=
 =?utf-8?B?c1BESDV2czNCbmMvVTJrR1FZbDV4dE53Z3dtd0xhZEk0K1NpZHFZbUM0b09n?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39CAC30C9E0F6E49884B24A68851BB54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eb5fe9-87fd-47f2-41c8-08dac0e01676
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 16:49:50.8246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0t0FJt/cmzRZgH9RJC5jIBrrABr5Hbv3PVZ6ylwTM/x4qSt93t7gTHuJV1OyKMsZE5yddF78CevNYwQN1IjLOYLEJy3dW4MkVNEdGfGef2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTExLTA0IGF0IDE1OjU2IC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiBUaGlz
IGNoYW5nZSBkb2Vzbid0IG1ha2UgYSBiaW5hcnkgQ0VUIGNvbXBhdGlibGUuICBJdCBqdXN0IHJl
cXVpcmVzDQo+IHRoYXQgdGhlIHRvb2xjaGFpbg0KPiBtdXN0IGJlIHVwZGF0ZWQgYW5kIGFsbCBi
aW5hcmllcyBoYXZlIHRvIGJlIHJlY29tcGlsZWQgd2l0aCB0aGUgbmV3DQo+IHRvb2xjaGFpbiB0
bw0KPiBlbmFibGUgQ0VULg0KDQpJIGd1ZXNzIHlvdSBtZWFuIGRpc3Ryb3MgY291bGQgYWdhaW4g
YmxpbmRseSBtYXJrIGFsbCBiaW5hcmllcyBhcw0Kc3VwcG9ydGluZyBzaGFkb3cgc3RhY2s/IEkg
dGhpbmsgdGhleSB3b3VsZCBzZWUgdGhlIGZhaWx1cmVzIHByZXR0eQ0KcXVpY2tseSBpbiB0aGlz
IGNhc2UsIHVubGlrZSB0aGUgZmlyc3QgdGltZSB3aGVyZSB0aGVyZSB3YXMgbGl0dGxlIEhXDQph
bmQgbm8ga2VybmVsIHN1cHBvcnQuDQoNCj4gICBJdCBkb2Vzbid0IHNvbHZlIGFueSBpc3N1ZSB3
aGljaCBjYW4ndCBiZSBzb2x2ZWQgYnkgbm90DQo+IHVwZGF0aW5nIGdsaWJjLg0KDQpJZiB1c2Vy
cyBuZXZlciB1cGRhdGVzIGdsaWJjLCB0aGVyZSB3b24ndCBiZSBhIHByb2JsZW0sIGFzIEkgZWxh
Ym9yYXRlZA0Kb24gaW4gdGhlIGNvdmVybGV0dGVyLiBCdXQgaG93IGFyZSB0aGV5IHN1cHBvc2Vk
IHRvIGtub3cgdGhlDQpjb25zZXF1ZW5jZXMgb2YgdHVybmluZyBvbiBDRVQ/DQoNCg==
