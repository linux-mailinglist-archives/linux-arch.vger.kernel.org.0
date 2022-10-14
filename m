Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692FE5FF368
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 20:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJNSGR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJNSGN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 14:06:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7861CC75F;
        Fri, 14 Oct 2022 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665770772; x=1697306772;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MPRQ21u0wdS4EH90Jz7G7WsZokoz6KPx0OjbX+aLJ1Q=;
  b=SusAOzdyfOdg4jXuGE4RaCyVWWQd5R1eBfZYSRL5iP/dUp8eSsVc1MqU
   aVFK459MZvDwtQFGtoLkoA9kJctU2rU+IktwZeqb5aeH7aE+upmjL9tfJ
   DJrS7WMjjCptJb9ZDl44Qys3gwHHuj1VKiJMjraO1fQemSaeueM3yhC6O
   YXnGZL6Vmkv9qMkDsc2IShgP+iNCUztFh1gakk49A5HXi+V7YPxcvxe/R
   byPxOQTrMiKtQkHDt9Qils0TGSPwL64VuIyoCwSZij48qcnd7r0T3jMby
   p0PuUzoQpJxDhOmRnAbwHhHcix213x4NQHJCf3kmjLadHMawueAQ2anrr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="305425879"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="305425879"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 11:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="956671446"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="956671446"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 14 Oct 2022 11:06:10 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:06:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 11:06:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 14 Oct 2022 11:06:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 14 Oct 2022 11:06:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdjQL3XsWK7J8Hm+HwIqxKY8bXPZbbshChNBQOclslas4DUpKg3JEFK5g8tv4U7qOndOPK1prz9R/E8cQU6u9lxMSC9OT97MN+kK1yHSUwzx+VsQ0GRUBkTV47PSPNgYstEv86UrMAqM8SRbYJ2hEnJG8+GuchmPH6Wr6ZW2/8OyG/SY7PpbQ6ppkFn6rraJGeGhxzlA/d7jVbKdEnydM3mLJbgP/6/zOzdCvKo6ghUPHKvcVQxmQNnp1qZxg12nUsT8JYU1zZU+DgrEU5cXqGPIDRdV4Z4+K7wBLxq4ESAI4RIcC9zLELjL47bd0CroovmQ9f5yqhWnXqNcor5S0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPRQ21u0wdS4EH90Jz7G7WsZokoz6KPx0OjbX+aLJ1Q=;
 b=mh1QarS/KuysGWUfPZpPiD5bWZFpT1eVznp94cUtzbE9uGhkiAmb1YNXaTcEr6X2tQQ8JZcfvpn589W8Y9vhrgEs6pY1G/FFviFpiSVgeC+BNgQoeg4UYvjXhwiQrx172dV8kMzCqEz0HdpPoiPDjoeLmHt7LPGUly+u1oxgATNeQiOGQU6tBFiQVeGoTILY0XZrcee8UrXH9199undO0mVY3fAl4UPen42PsdxxOcrWyGi184hsmBzxkPqqGMe8iuIQqzx8c+KbBkobk+KNgl+dYs8L81Ug38XFu1Z7gMQc4YciTNfiYItX4FHUcB99CB63qH+L+ZgViar2IC6Mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA0PR11MB7353.namprd11.prod.outlook.com (2603:10b6:208:435::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 18:06:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5723.030; Fri, 14 Oct 2022
 18:06:06 +0000
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
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Topic: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Thread-Index: AQHY1FMOaUlv/a8lEUG05TjT32eaO64Nud4AgACMvIA=
Date:   Fri, 14 Oct 2022 18:06:06 +0000
Message-ID: <a6d6e3fec807bfada22968bbaa07538c04b0b491.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-11-rick.p.edgecombe@intel.com>
         <Y0ku/kgLrs77rGxz@hirez.programming.kicks-ass.net>
In-Reply-To: <Y0ku/kgLrs77rGxz@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA0PR11MB7353:EE_
x-ms-office365-filtering-correlation-id: caa75654-529e-4f28-1936-08daae0ec3b5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tZvPMqk+TFqEhQGar2hjcEmfTJ7drBy6MCeyTYZyRzKOCeaq2od1IjxALbpli42G/dyafpn8Hw0GnzxfiCcc+sKbo90Qi0Pdl0UM6kNM++NvmL1v9b/cSPIWWR30ZOSlrZj6JJMkeZA76ryZ6sEIIsTI5zALrE88lpf5wnCwucml242aK65arBlK3WSm6qQV034cV6QV5ivltDFBCGhwYnKEPkpPdzl1NJgD2W91UXRFFxOpgDZZKTwTYCJb0krcHROXm44a9AsdI+VojpQmd6sML84LmocflhW44h2b6bFQe+trHsZ1QmPmp6oxXdtV8q3MqF2LqfqI+ir+BNNOMK5k5M6B1LfvppF+lyHgPlPgIBpYEpqDyF5Zgd21eNj1Ao5K4Jneq86KUWHlPo4wXLKLy9N+VQTEPqAwozYie4MPnVsBhgwszz576pv7lWsMgL8yPQIYOZZM0WFhasmYt4CSTSdA46eMnmGSIv1bky+O+HH+EOU+ylO221Yrm+GU4tr8wO2QU/3SJo8wjO6m8Tn4EZUP1o4UK7LGnI5HKF6+rhOB7QTjd7tMbT6jy2uUJ8/lTrvRPTRPj73Cg5j91oOD56K5dG3lx0I+VhR5DQrUyeqdO42/PoSOtZ4cM+gn5BDc9beGuUvXRaN1eCklrDnGUFR0MJZPhyGefjr/fn1xZMY3uGkgWZDSVlkeUZ4rAUTnYZiKpbOwvwgMYY9vDjQgCTt8blLhT+t6zdAj+w7mfl8FJjhFNrBPi2mQ29s0En7TZoSindqcc+t6Omg+6lB+1NDY6616tzDTyRGu5D42eeaDOU3s4jNkupCvBQKR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(2616005)(4001150100001)(4326008)(2906002)(122000001)(6512007)(86362001)(66476007)(26005)(8936002)(6916009)(54906003)(64756008)(186003)(66446008)(91956017)(66556008)(8676002)(76116006)(66946007)(5660300002)(38070700005)(6506007)(82960400001)(478600001)(7416002)(71200400001)(38100700002)(6486002)(7406005)(316002)(966005)(41300700001)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bld4SG03MWpybWRDOVdOUzd3RjF1ck4xTU9zRUx3NCs1NTdXQUFMS1RHRkNn?=
 =?utf-8?B?eHpXeHZ5N1Fnb2NVTFNCeDRhUUhRbXFSdWJaOHlvWEwzd1FJRTE1SlNGOUdY?=
 =?utf-8?B?YmJKa09wRWZ5VTZaNlZIQUlja1h3R1dZZWhieE1jM3lpV0diOWRRbEdSQ1g3?=
 =?utf-8?B?RkJRZ2dVdGZ3SS9FYnBGTmgvZWloYzI4YXh6dTA3aG80UjlQOFpmVVpreGRs?=
 =?utf-8?B?bXdOemh6VDMvYjF1NC9pam5NZEpXejVVVWlNYmtTdkROQUJvOFpqMm92b0NS?=
 =?utf-8?B?TXN0RHdXQW0xQlJYYWI0SDZtZnN4cFlramJaeTlPTk0xY1NwU1BhamYwekVo?=
 =?utf-8?B?VDZUaEpoUEVvSXQ3eWMvRDdJZ2RJMzVaeTBZVGZWNzVCeUFSMnlvTmgzZy90?=
 =?utf-8?B?THlMUFJYK0hORGtiRGFncTlOV0tkU3pxOVNaSlVxREJLN0xCQnNZV3I2cnRy?=
 =?utf-8?B?QmVnRW5UZ1Btai84clZuRDdjNGptaWNuQVdDQ2RiKzBqRUlXZHJWRk1WWTFs?=
 =?utf-8?B?S051S2xOR1pPM2dROUV1cmxVR3gyM0lhWXZVc3VDSldIVlU3eHpVU1NMdDlG?=
 =?utf-8?B?WDM4VHYxQUZtWlprWUdGOUxCcG53bEdaajJvRHJ6eDZ2dlgreVRqVU5Lb2E0?=
 =?utf-8?B?VTZGU3JCZ3lIUFlvRm0zeXQ1eXpQN2FGU1JSNVgvSkRYbktiVXZGeDhxandE?=
 =?utf-8?B?aXE0cng5TUxpcDh0ZmsySHdlaDBua1JJRU5sM1p2bDNyYStrUHZDdFpJZWl3?=
 =?utf-8?B?T3lWQitzTzMyeXNKWCs0bkl1cVZNNlcwUXhSL1YzZ0E3bkxIZGQvSUROdTlQ?=
 =?utf-8?B?cVUrdEduR0YrajlzQ3NTeXFOSVF6alR3Q3Z3UkZPLzlMVWlJVDU3aWpWZC9Y?=
 =?utf-8?B?aUZUdGo3VldYdU8yd2k0VGVpZytmU2R5aDZic0JCblh1K3RaQk1MREdUK3dY?=
 =?utf-8?B?WjVCMG5GY0VKaENHb1J6SzZIWDBpSjE0UkNSUUVVZU1yZTBqNXp4UzhzS1hQ?=
 =?utf-8?B?NkdIYzlnUFdiUVYxbzdNS3lRRkJmb2Y5Z0FzS0xJTVNra3dkU2VINC9VQVl6?=
 =?utf-8?B?TTJBd0dCZzQyZGtybGNvT0czUmtQRFN5QmMyNnY3c3RSekpQZzhhQ0tCZVU3?=
 =?utf-8?B?RlA1UGlZZ2s1ZUQyYUc4UHRLdGpFejlnbDRhREduNHRJNytIRXpNeHFIenRu?=
 =?utf-8?B?V290Y2VlSWxVMURqNlhqZS95cWZzQkpVMkJjTkFYNXNYRUJiMklFaWlDVlhH?=
 =?utf-8?B?SERYMDkwM3REeTB3TDhEVmJZTGEvOUttRllKTWcxUGNsYVpKdzZsV0JSenps?=
 =?utf-8?B?V0hpN1MvWlI4aXZkaE1XeDhlbktuOEpCWjVOYy9WdTNMU0NaYml0bTI5dXEx?=
 =?utf-8?B?WkhaWEZNQ3c4N0J1Y0kwbElxb2ZzVDdNbEtoREVmc1kraG5pNUQyTHJEZjNK?=
 =?utf-8?B?MnBSbG9LZm54SWhncGtrQW4xK3UwaWZ1bERiMld2RXhYQ2FyNGpva1lDZU9h?=
 =?utf-8?B?b3NLWUMvSFBtL1c5bk1wMHFmVCtQYmNzTXl1Yi9tOHlzUHl0UDByakxJTTFa?=
 =?utf-8?B?LzZldVd3YVBndm03OXh2UlYxd3E1MlZGZm1udGdmVTlteXM5VFM0OG9mTEZ5?=
 =?utf-8?B?eHYwYXFXODNKblN3aTEvWjUrZ0JCR2l6bmdaclV3NGhGTHNTMGlmQUdlaWlS?=
 =?utf-8?B?ZHl5TU5OZWN6TTc0MmwyalByQTFldE9Ra2UrWHBzenVVeEpkUTJ4VTk0Qm1V?=
 =?utf-8?B?cVNnWGJ3cERXME13M1ZRUXA1MW9OWnIzUFh1OEZZMjJqeHJMMzJlRC9tNFhE?=
 =?utf-8?B?Q3djd2dGZ1NJK2pHa0VyQWVRdzdlTmNCRTZjY1FmWDNQMmM4ajExbFRxdGI4?=
 =?utf-8?B?WWM2WlFlWVp2eTRjL2h1SGJYTUY2b2hqdzVnamRuOXorNWxoL3pVYjdFMUN4?=
 =?utf-8?B?clcvb3hHMUxUdFdpNmIzNXJDL045a2NKenh5REN1WHg5VU5tbi84SGJEdzFS?=
 =?utf-8?B?NEFoSk5ocTU2WklscWNDYkRTOVQyenAwVXJMdEM4RVZQZE1YS2RpWWU3d2t1?=
 =?utf-8?B?ZnFpdThhcjlMTFhKUitiL2NyWnlFNGFTdzJGK0Z4Zmk1MlpMQy9XRk90ZEhK?=
 =?utf-8?B?MVdnN3NNYnZhYlhXWXE0YlhQclphVmdWdzZCZHdEWnREZ1E5QWRSMTluZE1L?=
 =?utf-8?Q?9M5lhkdKnchg7kSHZ2VosLk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A95ABB0395130141BE7700469AA0D837@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa75654-529e-4f28-1936-08daae0ec3b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 18:06:06.1922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLMuVQxvHfpQ6AT3UYp3mPtgBfd720uTevWR9pLSIBjgsLHt4Ofurnz/17BLVo0YNfIHFyCYwQlOmbbiMR/c1NDlvaVC45fyeIonWD5KLYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7353
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTE0IGF0IDExOjQyICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBTZXAgMjksIDIwMjIgYXQgMDM6Mjk6MDdQTSAtMDcwMCwgUmljayBFZGdlY29t
YmUgd3JvdGU6DQo+ID4gQEAgLTMwMCw2ICszMjQsNDQgQEAgc3RhdGljIGlubGluZSBwdGVfdCBw
dGVfY2xlYXJfZmxhZ3MocHRlX3QgcHRlLA0KPiA+IHB0ZXZhbF90IGNsZWFyKQ0KPiA+ICAgICAg
ICByZXR1cm4gbmF0aXZlX21ha2VfcHRlKHYgJiB+Y2xlYXIpOw0KPiA+ICAgfQ0KPiA+ICAgDQo+
ID4gKy8qDQo+ID4gKyAqIE5vcm1hbGx5IHRoZSBEaXJ0eSBiaXQgaXMgdXNlZCB0byBkZW5vdGUg
Q09XIG1lbW9yeSBvbiB4ODYuIEJ1dA0KPiANCj4gVGhpcyBpcyBtaXNsZWFkaW5nOyB0aGlzIGlz
bid0IGFuIHg4NiBzcGVjaWZpYyB0aGluZy4gVGhlIGNvcmUtbW0NCj4gY29kZQ0KPiBkb2VzIHRo
aXMuDQoNCldlbGwgcHRlX21rZGlydHkoKSBkb2VzIG1hcCB0byBvdGhlciBIVyBiaXRzIG9uIGRp
ZmZlcmVudA0KYXJjaGl0ZWN0dXJlcy4gQnV0IHllYSwgaXQncyBjb25mdXNpbmcuDQoNCkhtbSwg
aXMgdGhpcyBjb21tZW50IGEgYml0IHN0YWxlIGVpdGhlciB3YXkgbm93IHRob3VnaD8gSW4gdGhl
IHBhc3QgaXQNCndhcyBwcm9iYWJseSBtb3JlIGFjY3VyYXRlIHRvIHNheSBjb3JlIE1NIGNvZGUg
dXNlZCBpdCB0byAiZGV0ZWN0Ig0KY293ZWQgbWVtb3J5LiBCdXQgdGhlIEdVUCBwdGVfZGlydHko
KSBjaGVjayB3YXMgY2hhbmdlZCByZWNlbnRseToNCg0KDQpodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD01
NTM1YmUzMDk5NzE3NjQ2NzgxY2UxNTQwY2Y3MjU5NjVkNjgwZTdiDQoNCkkgZG9uJ3QgdGhpbmsg
YW55IGNvZGUgaXMgbG9va2luZyBzcGVjaWZpY2FsbHkgZm9yIENPV2VkIG1lbW9yeSB1c2luZw0K
dGhlIFBURSBkaXJ0eSBiaXQgYW55bW9yZSwgaXQganVzdCBoYXBwZW5zIHRvIGNvaW5jaWRlIHdp
dGggaXQuIERvdWJsZQ0KY2hlY2tpbmcgbXkgdW5kZXJzdGFuZGluZy4uLg0KDQpNYXliZSB0aGlz
IHdvdWxkIGJlIG1vcmUgYWNjdXJhdGU/DQoNCi8qDQogKiBOb3JtYWxseSBDT1cgbWVtb3J5IGNh
biByZXN1bHQgaW4gRGlydHk9MSxXcml0ZT0wIFBURXMuIEJ1dCBpbiB0aGUNCiAqIGNhc2Ugb2Yg
WDg2X0ZFQVRVUkVfU0hTVEssIHRoZSBzb2Z0d2FyZSBDT1cgYml0IGlzIHVzZWQsIHNpbmNlIHRo
ZQ0KICogRGlydHk9MSxXcml0ZT0wIHdpbGwgcmVzdWx0IGluIHRoZSBtZW1vcnkgYmVpbmcgdHJl
YXRlZCBhcyBzaGFvZHcNCiAqIHN0YWNrIGJ5IHRoZSBIVy4gU28gd2hlbiBjcmVhdGluZyBDT1cg
bWVtb3J5LCBhIHNvZnR3YXJlIGJpdCBpcyB1c2VkDQogKiBfUEFHRV9CSVRfQ09XLiBUaGUgZm9s
bG93aW5nIGZ1bmN0aW9ucyBwdGVfbWtjb3coKSBhbmQNCiAqIHB0ZV9jbGVhcl9jb3coKSB0YWtl
IGEgUFRFIG1hcmtlZCBjb252ZW50aWFsbHkgQ09XIChEaXJ0eT0xKSBhbmQNCiAqIHRyYW5zaXRp
b24gaXQgdG8gdGhlIHNoYWRvdyBzdGFjayBjb21wYXRpYmxlIHZlcnNpb24gb2YgQ09XIChDb3c9
MSkuDQogKi8NCg==
