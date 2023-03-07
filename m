Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777326AD3DA
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 02:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCGBaC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 20:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCGB37 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 20:29:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD7D4D621;
        Mon,  6 Mar 2023 17:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678152598; x=1709688598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D3iOuuYUavvJnBSJRVxv/NZYA/oKtaZnkMbMMEkCqAI=;
  b=ZRjoZnX7XuwXl3ek/jrQrMuB6icOSbwV2/3EfyAALIEN+GWKx3OZemfj
   6rBqLpu48pbOrk+JQ026Ntx4LCoD4n4pRDTkrXArnC+Q27KewjcAZ5RUw
   Wz4AtM85bLhbV1Xq2GtksWW0WvGUMOe5W4NH2nQjoISGNq42a1RSdfZqy
   5rDOBR7XVdQ44pu1ahXD1M2Q8khUH0G6/MaknUonwqJr//kAImVrwXBKS
   UTZJOolonEXV/72TrQkZor45Wl+3Oy3XaZ8t6xHPAtw/Nopy7+99xLg3L
   l9i7TJrVfgICvVZ6Eu47hcUfwVwOLwhzBU3U6lgwH13kn+/jXBxHl3mXN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="363349350"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="363349350"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 17:29:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="653786501"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="653786501"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2023 17:29:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 17:29:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 17:29:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 17:29:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 17:29:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c23mSjBL96r/aX6pDZQ3/UYHhQKVSQpSSsl0RrnniDz3zixF3UGcmCX0Con/uPRgPw1OYBWxvH04QSLFjMO8OjiUMT6ScceEwpE8SatmBi2uiZmQLdAnHoHSZUk2wWPqEbcWjbke1vVN3XhGo0tCNYW8Hir9QGGqkWO3VgsZqszu8DNmt2dCvFoWr2GFZDWRfabFx/s9mWCs7FBleWPepDWTpsHXCLgmEyUREy7HqVHq0kNjf18GOqhvuZpV7/n0JarfQ84A2yUN8bDg4C9veYhponeVtZmc9MGsAnJaXzkgNvVwMfNlQPl3ZrP4+XsCUieilKOpENymgQtJGoyehA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3iOuuYUavvJnBSJRVxv/NZYA/oKtaZnkMbMMEkCqAI=;
 b=Ppw+JO4zePFVmQO5d0WR4FUfjzCUOzvZszQxVnSa+bnHtXpJhiZXE7NG9MOlprg9uZ2YpJDeJbSZkE7xK6ZpF+hzWmAqmr2xoXnTLU72OpJ19ANGmOqla3VNkrTxCmbBehkCKvw5ksq05EQqcUHPrzTng8I4Xq4JdSrOdhfQuEAhSgkWESwKH44i5Ql1vKrSB3fmMoVwUpXkMEv/q95VLRO3sJLFtMNlQiae3wtzOlPnRP3TSJuOOEuRSFp6c/Mc6dEYUq3x6EWskspyNdWviCFMrJQh+6NjZ8r4kbc+8Go6oPAcZUueoyhvmRzmC3MpG8S/M6VMgOUlx7uDQ7InwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Tue, 7 Mar
 2023 01:29:50 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 01:29:50 +0000
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
Thread-Index: AQHZSvs++K1PtX8ek0a42/7LHbL15q7tb5iAgAEjDoA=
Date:   Tue, 7 Mar 2023 01:29:50 +0000
Message-ID: <f91bbe94b51c0855da921a770685aa17c06c8beb.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-22-rick.p.edgecombe@intel.com>
         <ZAWfZcJLXUfNt1Fs@zn.tnic>
In-Reply-To: <ZAWfZcJLXUfNt1Fs@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4678:EE_
x-ms-office365-filtering-correlation-id: a840bb5e-e423-4579-7f47-08db1eab71fb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjkmMXtXkTBQ7D8SmdBD1X5V3wb8W/6tfhA4x46ec7yCe0le8BZFujjLsZ4p/qw7nt4+ce5G4FddGV7buv+5M13GOykxkm1bgH/Gi+uGDh2ESMykbl5jRXdqWDJSwnfxZb4GL8BN82zJ5ga6+/Lpei4jjZIuSf9zrzLYnFWr9amiI2fbvjBLflLyQkZ3gEdif/IUjB0KE9wtCsyTDIE7foP9ZL/XwdnGeoY90mnXf19V7iJC32Wd1ZyExx/boHCJ6djipLIB6XweHLKCq4GQBJlWN+s5tITnCdeOgBpkzpAFFUKcymj/9Myt3c5+SvH8yyIJ4tLHWFhx3wvI4DRi85y4grE3F6DdgFT5868pDHeN8W2gdtRyHtU2PAD1URxGWCF0GxPj01BhB5CwOFptMERfRqTmzQC0J7y4nU5IWSPwYT/zUvqn1REtHUumfRjmCEt7A6iBLZGngY4qdOyNfdO/0k7u5X7Q1wBKnfhsu9A+csQ4YMMbYTDV0RTWRB+ENJSK49Q5pR5rZn7Uuxtz18pZUe63n5dA58XmVKgYrNdXaskmqu2jY8x0z5wt7zQOUyrc+Xo3zpWW9vbQgaRSV4L424B8u4rFgDTXV7HmpO+uOa25JBxJE3t3Zio/NrpBdKtUTPnOox7zcMpkQo+TEnt2qncN18AExelTttMAQnbAKv/9phI9YhPOe8XU1sBW/p/IJPSfEs40JOtqYS8J7Nssr8jNJ1VpScgatOvMrFk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199018)(66476007)(7416002)(5660300002)(8936002)(76116006)(7406005)(91956017)(64756008)(66556008)(66946007)(41300700001)(4326008)(6916009)(8676002)(66446008)(2906002)(316002)(54906003)(71200400001)(478600001)(36756003)(6506007)(6512007)(6486002)(26005)(2616005)(86362001)(82960400001)(122000001)(38070700005)(38100700002)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UytUdW9ibVFzWjhTRXlxMVZFRmdkNHdEVnBNTFRoT0dtZXE2Rnp3QlNqaWJX?=
 =?utf-8?B?am9vT1BDMU95S1hzd1pPYkNuVkJMRGxxdVczNmZkaUxkYmRxd0QwWWNmK3VJ?=
 =?utf-8?B?bnlRd1JjU1RLSDc2ajZsVVhpemhMK3FMWDg3NnBrMm90UDJDZEo2NU51T2pH?=
 =?utf-8?B?Tjhzc3hZNy9IRmw3cTNobXZ3L29KK0liMi9meXBtNzdXcUxLZHZHQTJaS3V5?=
 =?utf-8?B?VE9mVEJVL2NvNmMyYWI0dlZMVTZqTyt1a05EdXF3VWlkU2ViWnBFQnpFTUFB?=
 =?utf-8?B?NnVaQWJTTzVlVFlrNHd6eDQwRFROeXBpdW81eXZ1K2NROGxqYVM3MXgwOEhS?=
 =?utf-8?B?NWkyK1FoamtldE16eVpWdE1IUTk3OG9oWm54MUNSK2FlOERBd2NtTDcxV0JQ?=
 =?utf-8?B?YVRjWWc2U0c4aW1CMDJsTTdrUmhSU0NJc1RibXB5SWJVb21zSGZEazhveWVk?=
 =?utf-8?B?TFM0UkZxUE5Xb2g5WHkyMWt5ZzNhaDYraGxYZUdqblB6TXJCS0dJNmwvZEVI?=
 =?utf-8?B?OWUzYzc2VjJIdWRRcVpNNmFOT1JNZWR0NWQ0YVk2LzdQU2o3OENIMFBaYWV2?=
 =?utf-8?B?eEpRNS9MdnMyOU15THdWMVVFNERpK0lJWkwwOEl5UHhoYTFHODdFdEY3SXFt?=
 =?utf-8?B?K3BuZ3o3ME1qek1JMk5BSll3bSsraDA1ZndYM0VoY1A2YWJIOFFja05PWVBE?=
 =?utf-8?B?SWxFUFh3YnNNOEN3SnhpVGx4dzdKUnh0c1A3M2tlVGFtR2NraGUzOUpraEgy?=
 =?utf-8?B?UHl5UHJLNTc1N000TmFEaGM3Y3FSMGsxMkRmODVWUGFubHYrTHhBbEJoK3Nw?=
 =?utf-8?B?OGxGMjdHNmd6MmlmTHBNWlM0THErRnJuK09BOU1oY3dKV3UvT3k1RUV1emV3?=
 =?utf-8?B?bThOYUljYWQzTG1uUWFGbVB1aUxNN1YrMUhlWEFmUXhRVjd6SS9sc001cEdH?=
 =?utf-8?B?WTFGN0V0SXpxdXJBaDVCWlVJMTUrNDBTM1VQb1JlRjRxVE9hUFlCQjZhMmlM?=
 =?utf-8?B?ZzJmM3ZSTU53ckpGVXdWUnU5T1pkcDAvdnpEdm9zbkxMNEZ3akhXajdsZnpL?=
 =?utf-8?B?ZlBOV05DQ2w0dWVwNDZINE5XUVAxOXpWYlBIZWJjK3BPRUVDcVBnelhLeVl4?=
 =?utf-8?B?OTM2Q2JPaEdQWTZLOEFGKythdTFNcUxqc0hLSDFFeTNwWitHVHNtbWdnMy9Q?=
 =?utf-8?B?VEh4NGZISG1wVW0zNjF4VVcvTUordGREZlRIUlFqMHNVZ0pzMVlyZTJMR2Vw?=
 =?utf-8?B?dzJZR1JFOHVnNEdLaUJ1L1kzYXZvTm5DZm9QZlB3K0lvMVJkZ2QxTUJOQXVX?=
 =?utf-8?B?ei9kTDVKcTA0bUdBaG1PbW9HdmFRaWJ0Qk1ZNHBnNEVCd1B4eDBDQk92OFNQ?=
 =?utf-8?B?L2lKQ2t2L21uME9MZkxUZ3RJSFJsWjZ3STcydFJhY3d5SU9iTXEreXJwcW5M?=
 =?utf-8?B?b0NxVk56OEJlaUxPeXRyK2pRMXllZFBaSnlYY1JjMWNDNUowS1VVZ2l1SDMv?=
 =?utf-8?B?ZzUyNDh5V2JNQXdsQmlHTWdKam9rN1gxN1VQVkxYUnNuRk1iRGVYS2xzbFNG?=
 =?utf-8?B?MDY2RDZiV2NTMno3L3RKMFZnamU3ZEUwQ2Q0ajZ3QjFHcVNlTXJCZlBNNXlW?=
 =?utf-8?B?dGFyTmVBbFBva0wrM1JSc1N5eTR5TU96ZWkrWXQ4UHdlVk94aVVGa1Raemd0?=
 =?utf-8?B?OXRCYjBPS3dnU1p4ZDBVM240SFVwSytPYU5YWDFCcm9ZWHFZNVJJVWMzNTZo?=
 =?utf-8?B?T0tPMlVENSswb1dmSWxTMDVNOW9lc1Jsb1grVkdtWHdPbk53aDhLNVk3MDlU?=
 =?utf-8?B?QkNoOUwyWElPaHVyaXJxOXpQYkd2MWtrMDFWNTR3V1NYb1A2dXdXdGZwV0xR?=
 =?utf-8?B?OW51d2Z0ZXZmRUM3T2NQVlZiNm9ubHFFNVlab2xGaEVWWDZBOWtVNGM5U0dt?=
 =?utf-8?B?YVVPdmYwVU9xNVpIYkcwQnVCbmEzdllDZmwzMStHaUZtaEFTNG8rVktYbGVh?=
 =?utf-8?B?amVSNWUwdUNIMXlJQjVkT09jQlh6RWkxc1pvSVJBY1V5K2xwRDJwVWpMdzdR?=
 =?utf-8?B?NENab3JhU1Z6SWhRT0t3dTlUd21hM1dXdjkvRThlVHAxcEV2TTRkTWg0ZFJa?=
 =?utf-8?B?OTdLZ2o0VmcxUE9FbW9ibzFjZ1ErYUtZR0l2VTJmZk1XdVhwU3kzUmdSS2o0?=
 =?utf-8?Q?gHlz2kI5FWH9HgJnqoA9Rog=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72B58C8F5A5ED342A14476A7632DEC4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a840bb5e-e423-4579-7f47-08db1eab71fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 01:29:50.3293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjg8/tk+V2NtMSfXjUr5DobAjR4/9nIaDQUtpRxILT9vTiYTS77N/1Jnrl0uw1T5euDu3miSO2sF+KGe4tHsAPhc2+znyG+6YZthZnx9ByE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTA2IGF0IDA5OjA4ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IEp1c3QgdHlwb3M6DQoNCkFsbCBzZWVtIHJlYXNvbmFibGUgdG8gbWUuIFRoYW5rcy4gDQoN
CkZvciB1c2luZyB0aGUgbG9nIHZlcmJpYWdlIGZvciB0aGUgY29tbWVudCwgaXQgaXMgcXVpdGUg
YmlnLiBEb2VzDQpzb21ldGhpbmcgbGlrZSB0aGlzIHNlZW0gcmVhc29uYWJsZT8NCg0KLyoNCiAq
IFRoZSBzaGFkb3cgc3RhY2sgcG9pbnRlcihTU1ApIGlzIG1vdmVkIGJ5IENBTEwsIFJFVCwgYW5k
IElOQ1NTUFEuDQogKiBUaGUgSU5DU1NQIGluc3RydWN0aW9uIGNhbiBpbmNyZW1lbnQgdGhlIHNo
YWRvdyBzdGFjayBwb2ludGVyLiBJdA0KICogaXMgdGhlIHNoYWRvdyBzdGFjayBhbmFsb2cgb2Yg
YW4gaW5zdHJ1Y3Rpb24gbGlrZToNCiAqDQogKiAgIGFkZHEgJDB4ODAsICVyc3ANCiAqDQogKiBI
b3dldmVyLCB0aGVyZSBpcyBvbmUgaW1wb3J0YW50IGRpZmZlcmVuY2UgYmV0d2VlbiBhbiBBREQg
b24gJXJzcCANCiAqIGFuZCBJTkNTU1AuIEluIGFkZGl0aW9uIHRvIG1vZGlmeWluZyBTU1AsIElO
Q1NTUCBhbHNvIHJlYWRzIGZyb20gdGhlDQogKiBtZW1vcnkgb2YgdGhlIGZpcnN0IGFuZCBsYXN0
IGVsZW1lbnRzIHRoYXQgd2VyZSAicG9wcGVkIi4gSXQgY2FuIGJlDQogKiB0aG91Z2h0IG9mIGFz
IGFjdGluZyBsaWtlIHRoaXM6DQogKg0KICogUkVBRF9PTkNFKHNzcCk7ICAgICAgIC8vIHJlYWQr
ZGlzY2FyZCB0b3AgZWxlbWVudCBvbiBzdGFjaw0KICogc3NwICs9IG5yX3RvX3BvcCAqIDg7IC8v
IG1vdmUgdGhlIHNoYWRvdyBzdGFjaw0KICogUkVBRF9PTkNFKHNzcC04KTsgICAgIC8vIHJlYWQr
ZGlzY2FyZCBsYXN0IHBvcHBlZCBzdGFjayBlbGVtZW50DQogKg0KICogVGhlIG1heGltdW0gZGlz
dGFuY2UgSU5DU1NQIGNhbiBtb3ZlIHRoZSBTU1AgaXMgMjA0MCBieXRlcywgYmVmb3JlDQogKiBp
dCB3b3VsZCByZWFkIHRoZSBtZW1vcnkuIFRoZXJlZm9yZSBhIHNpbmdsZSBwYWdlIGdhcCB3aWxs
IGJlIGVub3VnaA0KICogdG8gcHJldmVudCBhbnkgb3BlcmF0aW9uIGZyb20gc2hpZnRpbmcgdGhl
IFNTUCB0byBhbiBhZGphY2VudCBzdGFjaywNCiAqIHNpbmNlIGl0IHdvdWxkIGhhdmUgdG8gbGFu
ZCBpbiB0aGUgZ2FwIGF0IGxlYXN0IG9uY2UsIGNhdXNpbmcgYQ0KICogZmF1bHQuDQogKg0KICog
UHJldmVudCB1c2luZyBJTkNTU1AgdG8gbW92ZSB0aGUgU1NQIGJldHdlZW4gc2hhZG93IHN0YWNr
cyBieQ0KICogaGF2aW5nIGEgUEFHRV9TSVpFIGdhdXJkIGdhcC4NCiAqLw0K
