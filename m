Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7BA5F5CFB
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 01:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJEXBp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 19:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJEXBo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 19:01:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAFE4D17F;
        Wed,  5 Oct 2022 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665010903; x=1696546903;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1KYeCJ1Nu+m3dzHYjKjLkpWXGY6uQwKJZ6wCtxRL1d4=;
  b=aolbB+mvE343j6VHeR6z9HcmIxgYL7UST4asXMIz9tfl5wZtLRz/uVqo
   TCLp51yW9bYn5JGPtKgmjJ3BriY+aL17LgV7qRrg8ubddlQGgwU4CD2/Y
   dfrbNBq+Kr9HRYmEJeAszlKZgcvovA4WxNVEGiGtbDYWSJ86QdGvV43fB
   Bu57XBDKBqdDm4c+cl/193J91c2JNPSaZLkwxlDEyGEh4zIBRE0y4vcH+
   x972qArai2JqAY2943ljyFuhMfhF1F4ENK1QuWVSlIUjvzR2M0mFYuRWY
   Z5ZXdT0ZX2gJJ5swwhjHWy3XrB7vS0ZMAE/7+F3jKTyQo7edwTeyPOw2p
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="300893735"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="300893735"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 16:01:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="575597490"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="575597490"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 05 Oct 2022 16:01:42 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 16:01:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 16:01:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 16:01:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL3BhFcjk1uyJCZ98BIUzeyzxt3cYdeKpHCVNSzFwgvn5kanDZOEXqY24hHGk+66TsGMh7XmFtuoP+O/vO6G/Krx+1rQcGsDVza2g3YXg6+2Kt6iscwW/xnYuvw8w2M+vR2by33FCEQdD9ly09uHz9nZ1s3WZZeR6bpXjnk3R4va+wNjDUmC3h5bJ+pCQybx3fgwCieQxCfYeET8sNW5+9Gaz0Atr8TTsGGK4UYaCoU81CGOr1/W5wO4w3P1pMQ2JgDJtwAx/a+6kXZ2FUQwLXPzy559Mtllwjn7K6UTIqip2J4e/2f4zgj9q7y0GwLRbCo5WcypntulrWJUqPTGJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KYeCJ1Nu+m3dzHYjKjLkpWXGY6uQwKJZ6wCtxRL1d4=;
 b=aboYg4Oto1zHcj2So6ryGzSJxC+LuustZRaBQbvLzmrKbTgWvKnP4pmJ9LidaGJvil/gIZ7xijvShhbGmLwqD+hxOhCLdkEvNlATQDHtSQ8QZpFvvc5NWy7+dk2VzUTio11532zdXD/vvvBkmVNLQncpGqjrgYsPjUC1jDCMSslc76Cw570AXIgBasNrFDSnjv4dRYD7h4u7ndGYKFBZLgW1EcbZ9LCr89maBpNPq0uQAJtWGUmyVLcyahffRU8/X6Vqitxxn0qjF7bxrKnQyIiY5VLbllsHOHPgCbtEVvCwj36FGwHHugcYoTXt9mt6H09aMP97ukMm3Qjw7ecrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Wed, 5 Oct
 2022 23:01:40 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.034; Wed, 5 Oct 2022
 23:01:39 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
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
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
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
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHY1FMOaUlv/a8lEUG05TjT32eaO63/GJkAgAFbmQA=
Date:   Wed, 5 Oct 2022 23:01:39 +0000
Message-ID: <6d4ff84214629fe9cfe32cb05ec63ee8d390f7ea.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-11-rick.p.edgecombe@intel.com>
         <54cdad9f-b810-7966-5928-9320d970a43d@citrix.com>
In-Reply-To: <54cdad9f-b810-7966-5928-9320d970a43d@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB6468:EE_
x-ms-office365-filtering-correlation-id: 81ba8b56-8d5a-4877-e947-08daa7258fd1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5ls3bgY13RH84nVG1T7DzwVfMyKI3UEM3NUVYQcHrBFSaZ7nDRC+xZLhiKuz+JS0A/zf0exMrRwHlsVNOuLqWJJDDi8qTEmIZrgyneUw9zji+WriLhfdDYziyYtXjWCaQK70mJMTuFaJ6WGDS/arhGy/BonsJghgluIcaYApqyhxkFFw/Vg5/gO25x0HXMnlvcQ/IUhGOI3PFWq6KO92UXo4d5GvlA6dokJ09ScdP7u37CZ0r3MfyD9Iqd6w163tnYl6iYAUXT1wFDoA5st2wQPuLr7guxU90Xz/KaNNmlnvH+KYUusEJt9T1b/pvnX/GlQ9n6n4sqtOJcwxTEQPBEEicg4J/Aw8jjHLrtmaQcwp7aCVxP476nVd8d/R/yuNsWThifCbgfH5LdT1WVwqGvVxcTW39nuAoCa8jhWfS8Ly+iy1YHVYw5nNtUUwTiOS5JBokQPQHIp7g7suXBoB/xZWPLbhYCBcduPW00u1QZWM/qNrDmDEhItTLmNj0V3sMkx34/IWvNoYsfB4B6eoLJMOozxazGAaVI/XHqMnViwcRX8VLEPJ021aayzM5Ab+TEXTNBd432eLDVFdRRwWnCDAK8NUhG1LQwXPOOBELssvGT0rq+ipTZD5hKFDuwtn8MenZ/uBHiPvZV+Vk65a0b89KDlX4gRrbgWlY6KfCpGy+zBEPJihqimtoGRjREiSbkhUqp6RQwjufdIWMtmTAMU0gK3IU+BVvhF095uBjy8vpPDRmtfhrjw+S88BuCn7jpsRhDyHd/oUGoSWsTb/pjQ/4fXChJl7wvmtjJZdFfTlpyohc5suIxX0HjpRMI+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(71200400001)(2906002)(86362001)(2616005)(186003)(83380400001)(6486002)(122000001)(110136005)(41300700001)(38070700005)(6512007)(7416002)(26005)(8936002)(5660300002)(36756003)(64756008)(66446008)(8676002)(921005)(66556008)(4326008)(66476007)(7406005)(478600001)(76116006)(316002)(6506007)(66946007)(82960400001)(38100700002)(91956017)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlJzdzZrTS9FRHEzcG5zU3BCWXVySzFQRXB0ck93d2oyY2huSmJQTmd2dmgr?=
 =?utf-8?B?NUY0UUw0YXQ2Qk1sUm1tUG5jTi9sUFVxb3ZXNVkza2VFY2lBdU10Ly8wWG02?=
 =?utf-8?B?R2FTV0RHS2g1KzBOa1lsc2Rna3hGQ1U3VEpoa3BUMnhaSFlkVnVQcWs1a3ZM?=
 =?utf-8?B?VWEzWVMzS1VsT3VERHF6K1BqN1dMY1dib05DL21QdTRKb0FuNDVZL3Q4dnVM?=
 =?utf-8?B?SHRBeGlKdXdKSzRsWTcwemZ1Y3FMOFVKTTRVZG9wMkxFYXdrRVJCUHBlNXlQ?=
 =?utf-8?B?UmVBNytuWWRsNG9CTnNkemZpUVFLU2UyRmVCV0dWZ25XSCtYVGhreEtNaC80?=
 =?utf-8?B?YmJJeDg2MmFSV1JvL1MvOFI3emZyMkhaN1ZjN2hES29EMGdXa2FnanB1YjJF?=
 =?utf-8?B?azA4eHNMNURVeHM5ekViR2RTS0ZNdkI2OXNVMmtkOGFhZ3l0OW5wTURTM3A2?=
 =?utf-8?B?cFR6blNwNUFFSG1vUFMvQVR2NjdUbG5lN09wUHpkVW8zcEJwS2hIMHRKZW5i?=
 =?utf-8?B?YzJ1NzFWVnRWMk05c0g5aHliL25wdGVUUE1kZGJFcFBNejNLMG9pNVVZNFpJ?=
 =?utf-8?B?WWdEQnkzUWg4RElJWVlSdmJpdUJFbEd3a0dGZGd4dnN6Y2EzMGZ0YWxBcTlu?=
 =?utf-8?B?Rlk1aENDOWtIUzRNWk5Ncm5oZDk2c0tOcjlubG5jbUs0ejJXcStwaXVpeGVV?=
 =?utf-8?B?d0UwRXRRNWFJb0ExSFBlWG1NZFREbEsvSXY3SzE0K0Q0SEVVdlhEWm1yTVQx?=
 =?utf-8?B?SHNSeWFrc1lTUFlDOTJRTE5Pd0lEN2doUTl2cUFGRy82R29ibXJaeVdLSUVp?=
 =?utf-8?B?N3FOUi9ySFVPRzhjR0VPWUFJb0hXOUdQcVArdy9wM2RzTEZXWGVVNFR3MUFy?=
 =?utf-8?B?aVdERUdyVGw0SmMyNEtqY25KOVM5R201N3BDM3RIWDZzMkpKVEtMb0xQdGJ6?=
 =?utf-8?B?b0p3TUd4SUJUVTdyZGZ1bHcyU0FGSlRuOS8xL0pLd3NkZDh6VXlaVDhSNVl6?=
 =?utf-8?B?VW1jTzJQY2pzcjJiT3F1bG51VGk1dkdTL1p0SUpoN3RrZDFDZlM0dGJOeDZS?=
 =?utf-8?B?bCtjYkN6eklZb2hXd1BWRVQwNWpaZ2V1bXE3RWdrZTg3cmx6d0hLa1NXcHRI?=
 =?utf-8?B?SFZaYXlldXhvWmk1NVpPWVA3SGM2ditvb1FkUmZqVVdydzlnOXMxLzBtVnp5?=
 =?utf-8?B?SHIzdDV6cDcyU0hiNlE4dkZGSWwwOEJsK0w1WHEwZ3hJUlpJdkp3a3NNaE8z?=
 =?utf-8?B?QUhoSlJ4NkdZQ2dPOVdIeCtyNXcrYlFSdkxYWE5KWkk3WC8xc3dOdXR5UEdJ?=
 =?utf-8?B?b2ZQck5wOGNrSUFub3hQbk1MYWhnWis1QkJ4elJpbFZOOEI0UytUdFJIajBF?=
 =?utf-8?B?QUVwbmUwOU9tN3hYeGx0eXgrRjRoSWhIQ1krRmJaY0pDdStrRHpCZTdHalJQ?=
 =?utf-8?B?QWlOYy9UalhrZ3MrU0RZTm1YN0tka1dUdE5pS2UrYVg1RHJXRGdmUmdpUVRv?=
 =?utf-8?B?LzluVXlkWGJWcVF3TXBNK0V6ZzBKLzg5T2xmQnpOZ2hLcEpwTmQ2V0VsZ1Uw?=
 =?utf-8?B?ZzdYd0FnNEI5WStCREEzSFJVdlBhbDBOektOYWpaNjRDbEVadVdrZnBwTHc5?=
 =?utf-8?B?RklWUEJKcXZpdGVhL1V1Y3l2R1FsQzFlK0V4ejRpU2lCQ1F3WFJnZzNRekp6?=
 =?utf-8?B?R1k0bE9hdTNLS1MvUWdiSnRhRVJLSVR3UnE5N05HcGtJZmc4V25weUU5WTBt?=
 =?utf-8?B?R3V1dmhEN3ZBaUx0SHhvQnhhelp2R2VxTlJnc1FoVFJjb1RHTk5ZWDljanQz?=
 =?utf-8?B?cWdTM0FwQzFXT1hLV3BrWU5vanQ2NVhVTWd4M0dHSWN0bHg3MTR6WSs1WGNq?=
 =?utf-8?B?Y2ZTYk5vRUJ6OHB2WDZXQXJ3SEEzVWdtVzFFZ01JQlkyY1ZjNVFURWMrL2R3?=
 =?utf-8?B?S05FSUsydkozV2FjT2ltTUhiWU5HWkVUelRYQS9DOTBHQVJFUHRJdnRaRlFW?=
 =?utf-8?B?NVJOOGtraUpjUjVjV3ViQk1BMTkrNW01ZTZQcmpiYWJIdm9OTlF6eUF0RUlW?=
 =?utf-8?B?c0xSZ1BCcGZaeW5vejFaVlZwb0tMdzRKRll2ekI2Y25VSjU2MWV2YTgwdTBw?=
 =?utf-8?B?Qm5YYTZqVXFGVHhIQlVkWHEvSThQT1Y0dHk5c1o4MWNvMzhpVFNKK2ZxcUZ6?=
 =?utf-8?Q?4S/wjegmDu4sFg+0IU9owB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9EB5840BF66984992742E4A627CBC11@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ba8b56-8d5a-4877-e947-08daa7258fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 23:01:39.4717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1PSdfx634BuvecJ5n6YHn5Uv7ZFgSY5f6kKTPCcxlC7EWclgh/ten0NJknhhl0tNZx4+kf8mHDNnuMXr+uu8vTOZDeSg86GdWdjRyurmz80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gV2VkLCAyMDIyLTEwLTA1IGF0IDAyOjE3ICswMDAwLCBBbmRyZXcgQ29vcGVyIHdyb3RlOg0K
PiAoZmxhZ3MgJiBQU0V8Uld8RCkgPT0gUFNFfEQ7DQo+IA0KPiBSL08rRCBjYW4gZXhpc3QgaGln
aGVyIGluIHRoZSBwYWdpbmcgc3RydWN0dXJlcyBhbmQgZG9lcyBub3QgY29udmV5DQo+IHR5cGU9
c2hzdGstbmVzcyB0byBsYXRlciBzdGFnZXMgb2YgdGhlIHdhbGsuDQoNCkhtbSwgeWVzLiBJIGd1
ZXNzIGl0IHdvdWxkIGJlIG1vcmUgY29ycmVjdCB0byBjaGVjayBpZiBpdCdzIGEgbGVhZiBhcw0K
d2VsbC4NCg0KPiANCj4gDQo+IEhvd2V2ZXIsIHRoZXJlIGlzIGEgZnVydGhlciBjb21wbGljYXRp
b24gd2hpY2ggaXMgYm91bmQgcmVhciBpdHMgaGVhZA0KPiBzb29uZXIgb3IgbGF0ZXIsIGFuZCB3
YXJyYW50cyBkaXNjdXNzaW5nLg0KPiANCj4gdHlwZT1zaHN0ayBpc24ndCBhY3R1YWxseSBvbmx5
IFIvTytEIG9uIHRoZSBsZWFmIFBURTsgaXRzIGFsc28gUi9XIG9uDQo+IHRoZSBhY2N1bXVsYXRl
ZCBhY2Nlc3MgcmlnaHRzIG9uIG5vbi1sZWFmIFBURXMuDQo+IA0KPiBTcGVjaWZpY2FsbHksIGlm
IHlvdSBjbGVhciB0aGUgUlcgYml0IG9uIGFueSBoaWdoZXIgbGV2ZWwgaW4gdGhlDQo+IHBhZ2V0
YWJsZSwgdGhlbiBldmVyeXRoaW5nIG1hcHBlZCBieSB0aGF0IFBURSBjZWFzZXMgdG8gYmUgb2Yg
dHlwZQ0KPiBzaHN0aywgZXZlbiBpZiB0aGUgbGVhZiBoYXMgdGhlIFIvTytEIGJpdCBjb21iaW5h
dGlvbi4NCj4gDQo+IFRoaXMgaXMgYWxsZWdlZGx5IGEgZmVhdHVyZSBmb3IgdGhlIGRhdGFiYXNl
IGZvbGtzLCB3aGVyZSB0aGV5IGNhbg0KPiBjcmVhdGUgUi9PIGFuZCBSL1cgYWxpYXNlcyBvZiB0
aGUgc2FtZSBtZW1vcnksIHNoYXJpbmcgaW50ZXJtZWRpYXRlDQo+IHBhZ2V0YWJsZXMsIHdoZXJl
IHRoZSBSL1cgYWxpYXMgd2lsbCBzZXQgRCBiaXRzIHBlciB1c3VhbCBhbmQgdGhlIFIvTw0KPiBh
bGlhcyBuZWVkcyBub3QgdG8gdHJhbnNtb2dyaWZ5IGl0c2VsZiBpbnRvIGEgc2hhZG93IHN0YWNr
Lg0KDQpUaGFua3MsIEkgc29tZWhvdyBtaXNzZWQgdGhpcyBjb3JuZXIgb2YgdGhlIGFyY2hpdGVj
dHVyZS4gSXQgbG9va3MgbGlrZQ0KdGhpcyBpcyBub3QgYW4gaXNzdWUgZm9yIExpbnV4IGF0IHRo
ZSBtb21lbnQgYmVjYXVzZSBub24tbGVhZiBQVEVzDQpzaG91bGQgaGF2ZSBXcml0ZT0xLiBJIGd1
ZXNzIHdlIG5lZWQgdG8ga2VlcCB0aGlzIGluIG1pbmQgaWYgd2UgZXZlcg0KaGF2ZSBXcml0ZT0w
IHVwcGVyIGxldmVsIFBURXMgdGhvdWdoLiBNYXliZSBhIGNvbW1lbnQgYXJvdW5kDQpfUEFHRV9U
QUJMRSB3b3VsZCBiZSB1c2VmdWwuDQoNCg0K
