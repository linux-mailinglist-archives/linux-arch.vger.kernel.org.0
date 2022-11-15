Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF0F62A32C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiKOUlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiKOUlL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:41:11 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3159229805;
        Tue, 15 Nov 2022 12:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668544870; x=1700080870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vuImBIY00u5KYYESIkSzcUWGNVGeaApBXqDX+SetXao=;
  b=jc+XDFknF549YOzfausWzVQUuhWbb44ZxkX4DOttkVxRhjPiNVdu3ose
   SfXmAnO1jAPOEJHGj+0/CEpvq4glPLxzeNjg7mw1eAM6dTJr/IOvz0bhu
   KM0qxra14EQmF+gr1X3kxIf6tkyvcynlm6C1uOyYN4V6ldzTvzPtVQDuo
   HyezsltS+7+ib1nXHM0Q4+/9krHE31ZvAc5d60mu0R/Ffr6+SFD5KhnMT
   3mY2nMOiXCMXk2kIcExRP1TR4gJl6cbUbG5AznheMIxfLSHq379i2z8md
   X6LQnJOF756NOeMt0PYDo642VNrTuEQqAn32P288ooSG6Lcpq+61ZAdgw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374498418"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="374498418"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 12:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="728096791"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="728096791"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2022 12:41:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:41:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 12:41:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 12:41:08 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 12:41:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDE1T9XcPJK0a7GkXJ4xHAwk10gxFY1QDPx/srrVO1fIjmk5KQwWgsdmhPDGiJ8DmKIrBg10JVVDQsii1lpNlxfMfCfkOqPnQUu/sOIytp2WGJeA7otckfq+Gr1oeO6wwx6WYExaRXvDbCq0+b1cpAY3f9KBPiCFX/cIGLT/kOxpKFOHEhv+G4mP9h3rKzJQimGJyaQ0+L9yGRE3gwfyURmxcRVyRm+2F0Zlum3NDLibvpyXkg2eSbqcrFIGLP8wI9+XNWoymSMXn9ocf0q3oBwEZUjyt8M/XFi3hLKXPT/0BhTgxKrQSS9tbf+aYGwcPs7rm7mks9lcLc8S3qBALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuImBIY00u5KYYESIkSzcUWGNVGeaApBXqDX+SetXao=;
 b=ddnKou2khTFUiApbEvYUqX+wsnTgEAy/1EnbyV1P9G/a/ERckvJSmvyDXyg573TmgF9Ywqk9N4DVu9WmzmcyLgfsXy35fnsqoR9sL7ttPd3WUHhqIFcxPo44gZvggwzVSrjW5w+cUWjwV1UX1zsbg8A/2LAG98QOG9Ef+mPPyb+SdRnXPtSW+EXu/DBHSOKrQOZrMqwh8Dw17G4jIZQtDU5EgyNpFrEeE0EGaWGO3RVKDixTSMTVBQOWh7JLS5CmOYQML16GIJl4ZH3njoKm2wL95KN2PFMIqsn3iAHUu5LYdk59KC0WWymtBcamcqjVsczP4Il+Q+9dGEl+Jzgb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB5958.namprd11.prod.outlook.com (2603:10b6:510:1e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 20:41:05 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 20:41:05 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
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
Subject: Re: [PATCH v3 20/37] mm/mprotect: Exclude shadow stack from
 preserve_write
Thread-Topic: [PATCH v3 20/37] mm/mprotect: Exclude shadow stack from
 preserve_write
Thread-Index: AQHY8J5WWp5+uoMeT0ia6pMXC1AUYq4/8/cAgACP9QA=
Date:   Tue, 15 Nov 2022 20:41:05 +0000
Message-ID: <e8a846191708514482b869bf91991597f67780be.camel@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-21-rick.p.edgecombe@intel.com>
         <Y3OAnl9nZ4CHvhVr@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3OAnl9nZ4CHvhVr@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB5958:EE_
x-ms-office365-filtering-correlation-id: b865d76e-33e6-4a72-b089-08dac749b7b0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqPwE51eJKdIU1ceuLJLULW9KYdYAWQCmbOBZnZgVM3DcbgFLzwnBzid/LwbGY5NKjhwzpswsBpYoDymEKZNNyCxSiVOaKEXr119sjny9S0iac9/kcwklDVg4xJGkzG9MpUF6jSniWU7GIvMMeSK9mne0bnmDmSJbiFiQ1wxOcchdvGPXJEWLjZQggHltnEyd/dcIIm0Qygl+flEe+q4o648bmRzRxN1jvQcpGJxYfwAm9MxEPRfJw+j5/x8ZeZ9ZX7hGItdMKkx1GKmVZyAEhzJakCm2PrNl32P9JXmyzN03ITSwxf0WLXJqKnS1ULuSHPoGBFFd5Y6RQK4yV3TrxmVCAELh3i7iOyROV5b6oX1IXOBuY6M7meOgGQ28Pk7NWGvi4dG2WQ7nVWtKyfEcAQPrPg3+Y33QcOhE5cwf+jyBTIgLyrs7se5DXAND0F0N+KII+3RhuiO2+WLOM0qc2lw+FnVcJbyGK06vNFS2IEWRCK34Ut0pI1kOq6n5Sm/vo/fNG2rXhO7xChVs7IuOu6I2sELbBIC0CVZSe3bb+ReL4Z06Dtfj6jB9fNCxOQUICi2pOYFJzA/O0fqePn2vY6rBuzwy2oIUzeR8mnXT8kbkZviAV1ISODuc0Z9WBCZTH0V73ctYFH0ivT8IqHH00diytD2xsZqyCZPjKMriafB76+fJgDLevRGLpJJL22EA3LiaNsoDo+afMmXEEZQ5t4xoVW2eTu3YbG16zA8f+Iv3T9UO/b/etM6tivZBK7uLX6efnSWUu7I71dAl/Cvu9LQVU2HHez4KP27MIHrqco=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(346002)(39860400002)(136003)(451199015)(71200400001)(6486002)(478600001)(6916009)(38070700005)(54906003)(6506007)(64756008)(66476007)(316002)(6512007)(66446008)(66556008)(66946007)(26005)(76116006)(82960400001)(86362001)(91956017)(7406005)(4326008)(8676002)(186003)(38100700002)(8936002)(2616005)(5660300002)(36756003)(7416002)(83380400001)(122000001)(4001150100001)(41300700001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjhjbEJKMmJ3WVdtTDc1Qjg3VlRJNWFldzlnZ3I5SDhCSG5kMHVJL1U3L3lR?=
 =?utf-8?B?U2dtaW52UU5IR1FHbWZtVmZlNUtIbG1KbnRhSmFXRWpLS1VQTlMyYWd2d0x1?=
 =?utf-8?B?a0h6QVRZajc3MDQ4RHVoMThmSVFjN0g2RkNjd3RkeE1HR09sc0wwaG82NmR2?=
 =?utf-8?B?UDJZU3JwTk5DcG9sR25TS1NEYW1BdjluK3lod2ttNXhwNUNlNnpWYnVqeEU4?=
 =?utf-8?B?UnJ2QjBhMHBMN3JOdWJKeXZYc1Q2b2doQ0pQdDRieXBSUmpDRitPM0cveVh5?=
 =?utf-8?B?N1BJTnNtQ0JqZklvanQ5dUVMSHRYbUdSUGhIS3NrNlMrNFIwa1hVdnl1QmpP?=
 =?utf-8?B?blQra2dIeE9RcUJESkViaTU3Y0V3Z2U0Y0lUWUlvTm94ZFlmWXYxZDdKd1Jh?=
 =?utf-8?B?N0hOa0RyTmxvNXpIQ21INFJibjRJaGpqV1NNS0p1Vy9hZDg1blBXMXhjN2kx?=
 =?utf-8?B?WW93SjVoNUFocEprZzM0aFZpYWU2d052VmJNTWIrMUpMZ0ZUdnFvSXRYclRi?=
 =?utf-8?B?eVZQWGNQUHJyRTV4cUZWMUFVcUhENDl3dGRMNS9PVEtLdjRHWnBFMFFodnV6?=
 =?utf-8?B?d2dha3FEYzhVTjB0ZXp6dmxyNTZJUGhRaU5DNUgrRkZXL09wMXF3L3N0cFhW?=
 =?utf-8?B?UXQ2bjljem93RW1BVVAzcVNiQ0ZtQmhsaW53WGgrTEFNV25BL0tROG9EM2pZ?=
 =?utf-8?B?YnE1UkNicjQzS2lpK3ZnL1Bpb0U0elZMaFVqR2RnYTdWWTBDKzZVQmwvQXZa?=
 =?utf-8?B?R09OY2QrZmFETDlqQnlSTkk5V3NNc2M2WHhuV3NlcjljbVprOGhjb3pBM0Ro?=
 =?utf-8?B?TXEzU3I2UndMekxJQkhlUlZHeEw3SHQ5RlZydUxYMm84NEcyekszQ1YzK1dC?=
 =?utf-8?B?TlU4M2pTNE1EUmU4aUt0RmNvaFFWSTBtWjBOSVZzRHk5Wnh2WHZENHhxSTBF?=
 =?utf-8?B?bzVqd1RhaFRwUmNhMWZtTk9NYUFRQ1JpM1JqcWZIUzJ2K3BsU3lEZGR2Rnpj?=
 =?utf-8?B?MUl4QWdqRkxqZEEvWUZ1Uk5Dek1IemRmWFllbUhRQlcvTm4xL1pMaXAzd2Rz?=
 =?utf-8?B?SUdQUHZlRExnd3ZOeFRXRmxmTFNHcWxERllOL0txeS9qaWZNcHR6bk82Ymh6?=
 =?utf-8?B?WGF1eHIvb3RSY2ZuSGVzUzl0WUdjZUZaOTdkN21aYmRZbklXc2FMZWpORmhW?=
 =?utf-8?B?dGF2OUZocDBmRkZiVjN0RFY1ai90c0ZnWkorUk0zczhVbi9hNlI5SE1zdERU?=
 =?utf-8?B?Zmo1WFlaSU4yOHA5NmcwWUZsUGI2TWVpMmJ0NUFLM3dIbjZ5UlZFR2RHM0FC?=
 =?utf-8?B?dzVmeG04NWFYSG1xek9lUFFBNUxtM0dmZXdPQThyMnVZZlVMTng3YXlBbVhn?=
 =?utf-8?B?WE1EV3RvLzUzYmFVcitSR051Q0MzVFFPay9kRUZja3p3TGx6UzNFYWxXcHAw?=
 =?utf-8?B?bW91MzBvUWUvV29GeGdiZFc1M256MVQ4UHJtTzE1REpwWGhEajhMbU5GbHl5?=
 =?utf-8?B?Zjc4UHJVVHBhb2lzZmNQYjk3UnhiVitQQXNYdDk4UEo1S1IxSWYxOERuRDli?=
 =?utf-8?B?bjlXdTV1Z3pMQ25FQXp3MEZmdHk1eUFMUFNwOGdjUHZuZm5lTzVzVzlpd2NI?=
 =?utf-8?B?d09qUlJ2OFk0UnZiOGxWWEZxQnJla0NsVzZ4MUVuaW5ueTJid1p4bjZVV1NH?=
 =?utf-8?B?MHJ5a0dBMVV5REp3bVhObTRRWDBlTE5LSGFqWkJQU0RwdzQrd2ErTkJwR250?=
 =?utf-8?B?bm5CMkNiRjloaTE0V1Fyam1ubnV3K1hIN3Bua3F4ZnFqOWtOeW1ZRjBxWTdy?=
 =?utf-8?B?amxOUXdQNnRneFA3L3FzcmtSQ2ZRR09qOEhpVFBZU3RaUnlua1dlT2hWK0ZL?=
 =?utf-8?B?Z2grdENpOWRKS0ovWUlyakl2U1l5N3ByOHVOcnNSc1JiV01ZZVZVOFE3aldC?=
 =?utf-8?B?RmUxTXh0SU5RN2c0OTZ0c2hRVm1RcXpWWEtBUTNrdVJrUWh6bFpaY3NIQWpT?=
 =?utf-8?B?bFEzK3A3OVRIUHRtR01MQ0NXRHp0V0ZuNHdCd2ZWNnpEd0pjOWFhL29kanJE?=
 =?utf-8?B?MGN5aTl6ZStNZkJ4UFlEZXBYc0xrbzlUQ2NTWlA3YkRJTE5BQWYzVGswaEVC?=
 =?utf-8?B?YXhkanVnNzltM3BTUitKY3RPOHZ1Q2JCdEE0S3FDVnptYkpLbFlOaXR1YnY2?=
 =?utf-8?Q?IwI2/sk6wKN9zC+ny62Ymi8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4FD31876EE6B4E9C24504D485E6CEE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b865d76e-33e6-4a72-b089-08dac749b7b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 20:41:05.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3TPRf/207aJyX2ii8nKkzWMpw/UPyJezBXz18lgH6rFW5Rm7ySsVZHYfvypq4ErWRGiuScOhPzZw1vn++cFWy9aOsqRLIDpHw5n68WBK3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5958
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDEzOjA1ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gRnJpLCBOb3YgMDQsIDIwMjIgYXQgMDM6MzU6NDdQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL21tL2h1Z2VfbWVtb3J5LmMgYi9tbS9odWdlX21l
bW9yeS5jDQo+ID4gaW5kZXggNzNiOWI3OGY4Y2Y0Li43NjQzYTRkYjFiNTAgMTAwNjQ0DQo+ID4g
LS0tIGEvbW0vaHVnZV9tZW1vcnkuYw0KPiA+ICsrKyBiL21tL2h1Z2VfbWVtb3J5LmMNCj4gPiBA
QCAtMTgwMyw2ICsxODAzLDEzIEBAIGludCBjaGFuZ2VfaHVnZV9wbWQoc3RydWN0IG1tdV9nYXRo
ZXIgKnRsYiwNCj4gPiBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gPiAgICAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPiAgIA0KPiA+ICAgICAgICBwcmVzZXJ2ZV93cml0ZSA9IHByb3Rf
bnVtYSAmJiBwbWRfd3JpdGUoKnBtZCk7DQo+ID4gKw0KPiA+ICsgICAgIC8qDQo+ID4gKyAgICAg
ICogUHJlc2VydmUgb25seSBub3JtYWwgd3JpdGFibGUgaHVnZSBQTUQsIGJ1dCBub3Qgc2hhZG93
DQo+ID4gKyAgICAgICogc3RhY2sgKFJXPTAsIERpcnR5PTEpLg0KPiA+ICsgICAgICAqLw0KPiA+
ICsgICAgIGlmICh2bWEtPnZtX2ZsYWdzICYgVk1fU0hBRE9XX1NUQUNLKQ0KPiA+ICsgICAgICAg
ICAgICAgcHJlc2VydmVfd3JpdGUgPSBmYWxzZTsNCj4gPiAgICAgICAgcmV0ID0gMTsNCj4gPiAg
IA0KPiA+ICAgI2lmZGVmIENPTkZJR19BUkNIX0VOQUJMRV9USFBfTUlHUkFUSU9ODQo+ID4gZGlm
ZiAtLWdpdCBhL21tL21wcm90ZWN0LmMgYi9tbS9tcHJvdGVjdC5jDQo+ID4gaW5kZXggNjY4YmZh
YTZlZDJhLi5lYTgyY2U1ZjM4ZmUgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbXByb3RlY3QuYw0KPiA+
ICsrKyBiL21tL21wcm90ZWN0LmMNCj4gPiBAQCAtMTE1LDYgKzExNSwxMyBAQCBzdGF0aWMgdW5z
aWduZWQgbG9uZyBjaGFuZ2VfcHRlX3JhbmdlKHN0cnVjdA0KPiA+IG1tdV9nYXRoZXIgKnRsYiwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgIHB0ZV90IHB0ZW50Ow0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgYm9vbCBwcmVzZXJ2ZV93cml0ZSA9IHByb3RfbnVtYSAmJg0KPiA+IHB0ZV93
cml0ZShvbGRwdGUpOw0KPiA+ICAgDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIC8qDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAqIFByZXNlcnZlIG9ubHkgbm9ybWFsIHdyaXRhYmxlIFBU
RSwgYnV0IG5vdA0KPiA+IHNoYWRvdw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgKiBzdGFj
ayAoUlc9MCwgRGlydHk9MSkuDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAqLw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBpZiAodm1hLT52bV9mbGFncyAmIFZNX1NIQURPV19TVEFDSykN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmVzZXJ2ZV93cml0ZSA9IGZhbHNl
Ow0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIC8qDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgKiBBdm9pZCB0cmFwcGluZyBmYXVsdHMgYWdhaW5zdCB0aGUgemVybyBvcg0K
PiA+IEtTTQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICogcGFnZXMuIFNlZSBzaW1pbGFy
IGNvbW1lbnQgaW4NCj4gPiBjaGFuZ2VfaHVnZV9wbWQuDQo+IA0KPiBUaGVzZSBjb21tZW50cyBs
YWNrIGEgd2h5IGNvbXBvbmVudDsgc29tZW9uZSBpcyBnb2luZyB0byB3b25kZXIgd3RmDQo+IHRo
aXMNCj4gY29kZSBpcyBkb2luZyBpbiB0aGUgbmVhciBmdXR1cmUgLS0gdGhhdCBzb21lb25lIG1p
Z2h0IGJlIHlvdS4NCg0KR29vZCBwb2ludCwgSSdsbCBleHBhbmQgaXQuDQo=
