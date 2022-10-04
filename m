Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F5D5F473F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 18:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJDQN7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 12:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJDQNu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 12:13:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE7C62925;
        Tue,  4 Oct 2022 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664900025; x=1696436025;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=KocN5GmzEvtQ2aFZBYf1QT6G8J/R21IMvUkx+/XwHS8=;
  b=SnS6jp4NicY5uL/0TMzXYfji48NqkL65gWt6kSqR2CjIlnaMaZYypkhK
   GMkRreFYjIhGJ3TTRFkheTvvEuB4cukOUmXmJScdZUxhGaW/FMqeIIsjU
   9v/jHnrwGB/n0Xv7qAgy+L+toX0Nc50Ybil6ximSY81lf+Pgx3BMydHcA
   HmuzW/kHXALjDCfyF/EcGjugaBlscV4qj2YN/LbYld34c9/VIyKkb+h1g
   cDTt7BSH50MjYSXhaYp5DhqkBDfhNotinAnp4fG3n6qgzvhYCLccDA3Ba
   cdwJGdfUZpRYpy7DgItx/JqnQAtES56kdEXn26L33b6BIWW6gAx/5SYWe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="301672620"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="301672620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 09:13:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="657178704"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="657178704"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2022 09:13:05 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 4 Oct 2022 09:13:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 4 Oct 2022 09:13:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 4 Oct 2022 09:13:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoP4iXITe5Y3eDq08atPZF9rYpzNM0FOEnM5H+ZtyG+R+6QKJmI+LSxDHfz2rh+9SAF/uNBE9aEvQww9JyFNF2q4/06tpVDtoCzGsG++NeF/cgJbQXMVo/Hs/TuEsakXzFTcetfMYs78qo/R51gRnZODHjnElCSbpuHIAQ/QUAvUiLDaPeO8ht8CyTpc6x0MPldHnVFURlkO9gYFQtCLYVjYFsjuia147QofLu249TVQJ+atNHWJv1Z+anrVXX3M2mE3BRxCxEPWbhsEqvwanqMIv9jUTFwST4owFnZoA/NYlpuEAQ1Ma2uAyLH937J8tsaUTKIughwpkQ8HrqX4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KocN5GmzEvtQ2aFZBYf1QT6G8J/R21IMvUkx+/XwHS8=;
 b=LgA+gJP7y/NOYiLAFDZ/8bOF0OPPSZ/JjU/vJK6iV9lhNZMOc4/o6B1tXmomUBF8QgEbGfkKvuXXd3+QXxf+LM9vKmbYdlpJnnY70UJiaJYkz24yzMIRTdxohMRGeHw0T3uDGgoliRxWcO4DeodfdlbmbVwXFj/LjjCmrGjOKUVMq1X+By41MKDno68j9vB66tJfCfhaL47/DTj9e+j2GIk17pu2xovN2AqwKwcrAXkGquYb+YqoGCule1urlyy3DvQyUpjZCr8eM+rFbyngpQFWjl2wEIunH+4scoHHmTKSTkIHiDiJBib7A/mew/hGWUs4o+eMOp1Mqis1Fm5vgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 16:12:57 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 16:12:57 +0000
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
Subject: Re: [OPTIONAL/RFC v2 39/39] x86: Add alt shadow stack support
Thread-Topic: [OPTIONAL/RFC v2 39/39] x86: Add alt shadow stack support
Thread-Index: AQHY1FMw46i7QamtHEWiYkKxbJ7BUq39VQ+AgAEangA=
Date:   Tue, 4 Oct 2022 16:12:57 +0000
Message-ID: <b22748f80c4993192bc7113b2ed28231dfaee94f.camel@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
         <20220929222936.14584-40-rick.p.edgecombe@intel.com>
         <ed5f3a95-2854-8b36-7ed9-f1d7ad0a2e51@kernel.org>
In-Reply-To: <ed5f3a95-2854-8b36-7ed9-f1d7ad0a2e51@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW3PR11MB4585:EE_
x-ms-office365-filtering-correlation-id: d7dd6e18-4aab-4cb4-077a-08daa6234d25
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCVthYqAWEjKl7Hmp1O8MZD9UK8fTPwJ7YaOU+/qKVd9C0aMM/opVZfLycknLext3eiTbMVPkvZxnxCNSoviYn+ZnmFrk6wy1ebTmZx5QbRtRqzjr7CC23w+GrvCmHjYJ+vhHMkprdfHEUQgx1YOnlw6CODqrWEEQ5oy+Tqk2OKXtYdVcgDyn4oTeameqaKwOJ5x59SI185+eReFP2g4jymX9XUNd6+v8R4hw2KdQIMo9vcYxSY3LSL+ll8Uf9DvfJwOC4PxfgJ2ovQXgkvj7NZIUejoZKQmkJiqmmwwkzDBKT1GS8QqDsz+l+yAgwhLZ9F7bYcJCjECGRu+shpMwkRqoTQjp+HyL5FqkWX/Ix1/Drq/yfcsIByX3pxnwZuWVoeRrN2E2bgX5fuXYwvmP3JQYdnbGRxvS9VzS8X49NU4ShehCoOY4BMI9eQWPPys11j/KQ9QTlls29RaSlNZOozj7zhF83/xAy7vxrzh8LsUptEE8CXleIrgEXHkRBQzMH/QoiC4QoogOmJ82nwfSdYD7m/UJQhgNQIgRiuXohKTv2M3aDRvMmmIsnWX8hpIAsuB5Dt7Hw2Y4sCkb7iXfAa39KsjAni8cObnHdXnr6UJFRiCCaM6OQFES+K48WOv5VnWbFMLB+RKLuxoQYSxf6GmPzaxD2RVOTv4ayBmCY/PNC3ZjqzF2qwQVM5sU/EKXsUHM4u0jDDHo5J3N/QN7Bdx1Dayj6UAQAvVF3+2EeIY9RohauPTy1gv8E9Jb/4atz5vkIxBeHoJQ0oxhbpxJkVypwkm99jM3lcIKbl3xZpbLYsjXJW46YlOz+N/X2Xh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(921005)(122000001)(38100700002)(82960400001)(86362001)(38070700005)(36756003)(8936002)(6506007)(53546011)(41300700001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(7406005)(7416002)(5660300002)(6512007)(26005)(478600001)(186003)(110136005)(71200400001)(6486002)(8676002)(91956017)(316002)(2616005)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXB0cGxqdloySG51cjdvZkk3ZnZUbUJWNnV4dXRtYlJVb21iUGdtd0RrU1hQ?=
 =?utf-8?B?V2pSTVIwOHlSSkpJbGh3Qy85NmMxTW5DVHFGdWxvNUNnSU5FOU1ad0JKTmtn?=
 =?utf-8?B?aHFJNWJCemNFME9yUmFQd2diY05yMEZmMVdPa3JPQkdQVkhqazZzVTJSOEtL?=
 =?utf-8?B?b3g4V3RReVBndERyaTAyNjR1SEJGSDVWK2J6bmZ0aWFhc0k1OUdRTGVtaGJY?=
 =?utf-8?B?WmJKSmRrQm1ORHFKSkNYdDMyNGN1OGt2cnV6QUFHRDMrZFZWSURBK2hEbzVB?=
 =?utf-8?B?REtKZDhObmQrSEErL0wzaGVLTHA4WTRRbTRoTGVCT25oenFQVktHMXZxbWll?=
 =?utf-8?B?VjF5aElDVko5T3ZFblJFWWRlQmNqVjhMM09OK1B3aUhZcTdQczFTL29JMk1C?=
 =?utf-8?B?cCt2NXg5OVllL1c1b01HOTJidFNBRkNDU2dXVmcvWXBGRnlFOHptT09XWjRn?=
 =?utf-8?B?eDJ4ZlJjVVV1REl2NHBXRnFpbHNQNXJ0NDFPTFNERkk4R2tFRXdkdVl1Sjdr?=
 =?utf-8?B?MUd4V0szOWxqYmd0RFpPZmVtYTc3aGI3K25rTkw1bWhUUDN4OVN4R2R5cVpW?=
 =?utf-8?B?ZWhINnVOQVBGbGR2MTJXcGt4RlBVUE82amFwcWp1VDM5cjBsOFJwdnFVQ2JF?=
 =?utf-8?B?U1NndTZka3NBcEtSakZqa285Z3hYK2FuTFBLVkFhRHJRWU9vYTc1TXdZQkZt?=
 =?utf-8?B?VitzU3FHOWZyZTFxVk9KckhSTzNidDZKYUVkQ1VnamRZYnpnZW9RQ0FYdXR5?=
 =?utf-8?B?bTVHaDlQYkIxMkJkL2x3NXpRemUzWTNRNk0wNnA1NDgwODBxLzVySHovNy81?=
 =?utf-8?B?dktONDVlY05MVVpvakRxc1ZsUXJ5NnVQU2ZkN0FNd0F5VCtJTU5SUGRndEJZ?=
 =?utf-8?B?a3JqL1llTFhZRTZ3N1hYdGtycjZlbDkrODNvK1NraTE3SzBXaVZYeGNxeU1x?=
 =?utf-8?B?R2YzNWFuc2NDa2xDcXBwVkF1VVZOZ1VIdklYTzRxc2QwSnF5TnYycVBxM0Mx?=
 =?utf-8?B?Ky8vVDRDd0VIUm9Jcnl0ajZjT2lMYnNUdUdYTW9qczhodkxWUm1ZUFh4RXR0?=
 =?utf-8?B?TitPTXMrZ0QxSFVrUGlRSFhYemUvR3I4RWJJeEtpZ1U2c1VmZ3hmT2d5bjgy?=
 =?utf-8?B?bFp5SWZkTERnekFKVDBCelpBQ3RwSlMrTWJGSWw1UXc0dDBQWjJ0d3B0K28w?=
 =?utf-8?B?eW9LNjFwNEFCUGJmZ1JhclhhbmlIdndBeTgvUC80UHlBVnhYSmJqWjNpU28r?=
 =?utf-8?B?bkVVVjRZK2lweC9lWGl0dzk2WjZJRkg1VVk5ZDBleWR5MFNXU0RnQnJ2clZi?=
 =?utf-8?B?S3hZamI3WVorQ21ScldjZG5UVk9hRTFKNkd1ZVBnaVJ1MC9IbGhNSDFjQzhL?=
 =?utf-8?B?U04vcjdHRHM1YWJVNDJNZkt6Z3h1TW9zZExJR3RBaE15NnJIVXcvRmdWSWlS?=
 =?utf-8?B?SmFNWkNsQUZvZVpEeE9wUHltUDBqYXl2TnpPYWxCdnk2TGYxbm1qMWl2a2F4?=
 =?utf-8?B?TkNQUlpUS3BLZHUzVisrS1VaNVJzN1hMVjdwb0lxUmtESlIzSkROVXNmaldp?=
 =?utf-8?B?eXdxMm1NN2VaTGRCdTdxZ1BvY1A5V0hkT3JoR053U243TUhzbGVHNDBkMnBq?=
 =?utf-8?B?QXBNelpvTEpueVEzMjRSRGZJeWJGTkI3ZEhhYVJ3LzN4U1NRYUxDbkdvOStD?=
 =?utf-8?B?RWFIdEQ4MGh3ekRkb3czM0svWnV2dUl0YWs1VVBkTW9ubGw4TDBGempVWXVl?=
 =?utf-8?B?bkl2WnkwSXAwdnA2UEI3TzBaRFFCcGhEVWlBMkNKc2RnNk9DWlczRVhWRzdW?=
 =?utf-8?B?RVBUWmdnTE5iMWZRd2Z2NTBxWXFTZmM2elVlVDBBZ2Z2bEV5Rm1VeCtZOHpD?=
 =?utf-8?B?WUNFWGlRN0NOMFB6R01zTTI1cmRwTnhST2l2TkV5Vkd4QVNzaEdjVnhjUXB4?=
 =?utf-8?B?Z1VxVXhGaVgzVGFpcjI4YkpndW8vZ2pXMnR5NjBIdWcwNGU2VUsxT24rTkVU?=
 =?utf-8?B?MHJrUDRyYkxobjBGeE4zV1ROVHNYNU1mU2tZRlE3dE81eE9VeHBCZEFReTBx?=
 =?utf-8?B?V2lSSWY1Q0puQStOM1NFdk9yLzJIZmNER0JtYWx2WmpMYndUZUdlMVVsNGJ2?=
 =?utf-8?B?TGJnSnhBQnZZWUxvbDRFMklnbE5oOWtJT25sZldiSThCdWFJc2Y0QVB0TlFL?=
 =?utf-8?Q?9/PYRomzJ89Y66KWAlsbTik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B21C499EEB9C2F479674149B04E308D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dd6e18-4aab-4cb4-077a-08daa6234d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 16:12:57.4528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aySpJyQC5+0uWXFkBaE++4cEvbdGhamSrrwlfdLL+gNJQaCX3SvQ2tA16ijh1qDKVYLddl6q2ASuLz1XNFFW5M5s4q3rJPNnj2mBWjaYsXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTAzIGF0IDE2OjIxIC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+IE9uIDkvMjkvMjIgMTU6MjksIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPiA+IFRvIGhhbmRs
ZSBzdGFjayBvdmVyZmxvd3MsIGFwcGxpY2F0aW9ucyBjYW4gcmVnaXN0ZXIgYSBzZXBhcmF0ZQ0K
PiA+IHNpZ25hbCBhbHQNCj4gPiBzdGFjayB0byB1c2UgZm9yIHRoZSBzdGFjayB0byBoYW5kbGUg
c2lnbmFscy4gVG8gaGFuZGxlIHNoYWRvdw0KPiA+IHN0YWNrDQo+ID4gb3ZlcmZsb3dzIHRoZSBr
ZXJuZWwgY2FuIHNpbWlsYXJseSBwcm92aWRlIHRoZSBhYmlsaXR5IHRvIGhhdmUgYW4NCj4gPiBh
bHQNCj4gPiBzaGFkb3cgc3RhY2suDQo+IA0KPiANCj4gVGhlIG92ZXJhbGwgU0hTVEsgbWVjaGFu
aXNtIGhhcyBhIGNvbmNlcHQgb2YgYSBzaGFkb3cgc3RhY2sgdGhhdCBpcyANCj4gdmFsaWQgYW5k
IG5vdCBpbiB1c2UgYW5kIGEgc2hhZG93IHN0YWNrIHRoYXQgaXMgaW4gdXNlLiAgVGhpcyBpcw0K
PiB1c2VkLCANCj4gZm9yIGV4YW1wbGUsIGJ5IFJTVE9SU1NQLiAgSSB3b3VsZCBsaWtlIHRvIGlt
YWdpbmUgdGhhdCB0aGlzIHNlcnZlcw0KPiBhIA0KPiByZWFsIHB1cnBvc2UgKHByZXN1bWFibHkg
cHJldmVudGluZyB0d28gZGlmZmVyZW50IHRocmVhZHMgZnJvbSB1c2luZw0KPiB0aGUgDQo+IHNh
bWUgc2hhZG93IHN0YWNrIGFuZCB0aHVzIGNvcnJ1cHRpbmcgZWFjaCBvdGhlcnMnIHN0YXRlKS4N
Cj4gDQo+IFNvIG1heWJlIGFsdHNoc3RrIHNob3VsZCB1c2UgZXhhY3RseSB0aGUgc2FtZSBtZWNo
YW5pc20uICBFaXRoZXINCj4gc2lnbmFsIA0KPiBkZWxpdmVyeSBzaG91bGQgZG8gdGhlIGF0b21p
YyB2ZXJ5LWFuZC1tYXJrLWJ1c3kgcm91dGluZSBvcg0KPiByZWdpc3RlcmluZyANCj4gdGhlIHN0
YWNrIGFzIGFuIGFsdHN0YWNrIHNob3VsZCBkbyBpdC4NCj4gDQo+IEkgdGhpbmsgeW91ciBwYXRj
aCBoYXMgdGhpcyBtYXliZSAxLzMgaW1wbGVtZW50ZWQNCg0KSSdtIG5vdCBmb2xsb3dpbmcgaG93
IGl0IGJyZWFrcyBkb3duIGludG8gMyBwYXJ0cywgc28gaG9wZWZ1bGx5IEknbSBub3QNCm1pc3Np
bmcgc29tZXRoaW5nLiBXZSBjb3VsZCBkbyBhIHNvZnR3YXJlIGJ1c3kgYml0IGZvciB0aGUgdG9r
ZW4gYXQgdGhlDQplbmQgb2YgYWx0IHNoc3RrIHRob3VnaC4gSXQgc2VlbXMgbGlrZSBhIGdvb2Qg
aWRlYS4NCg0KVGhlIGJ1c3ktbGlrZSBiaXQgaW4gdGhlIFJTVE9SU1NQLXR5cGUgdG9rZW4gaXMg
bm90IGNhbGxlZCBvdXQgYXMgYQ0KYnVzeSBiaXQsIGJ1dCBpbnN0ZWFkIGRlZmluZWQgYXMgcmVz
ZXJ2ZWQgKG11c3QgYmUgMCkgaW4gc29tZSBzdGF0ZXMuDQooTm90ZSwgaXQgaXMgZGlmZmVyZW50
IHRoYW4gdGhlIHN1cGVydmlzb3Igc2hhZG93IHN0YWNrIGZvcm1hdCkuIFllYSwNCndlIGNvdWxk
IGp1c3QgcHJvYmFibHkgdXNlIGl0IGxpa2UgUlNUT1JTU1AgZG9lcyBmb3IgdGhpcyBvcGVyYXRp
b24uDQoNCk9yIGp1c3QgaW52ZW50IGFub3RoZXIgbmV3IHRva2VuIGZvcm1hdCBhbmQgc3RheSBh
d2F5IGZyb20gYml0cyBtYXJrZWQNCnJlc2VydmVkLiBUaGVuIGl0IHdvdWxkbid0IGhhdmUgdG8g
YmUgYXRvbWljIGVpdGhlciwgc2luY2UgdXNlcnNwYWNlDQpjb3VsZG4ndCB1c2UgaXQuDQoNCj4g
LCBidXQgSSBkb24ndCBzZWUgYW55IA0KPiBhdG9taWNzLCBhbmQgeW91IHNlZW0gdG8gaGF2ZSBy
ZW1vdmVkICg/KSB0aGUgY29kZSB0aGF0IGFjdHVhbGx5IA0KPiBtb2RpZmllcyB0aGUgdG9rZW4g
b24gdGhlIHN0YWNrLg0KDQpUaGUgcGFzdCBzZXJpZXMgZGlkbid0IGRvIGFueSBidXN5IGJpdCBs
aWtlIG9wZXJhdGlvbi4gVGhlIHRva2VuIGp1c3QNCm1hcmtlZCB3aGVyZSB0aGUgc2lncmV0dXJu
IHNob3VsZCBiZSBjYWxsZWQuIFRoZXJlIHdhcyBhY3R1YWxseSBhDQpzaW1pbGFyIHByb2JsZW0g
dG8gd2hhdCB5b3UgZGVzY3JpYmVkIGFib3ZlLCBpbiB0aGF0IHRoZSB0b2tlbiBtYXJraW5nDQp0
aGUgc2lncmV0dXJuIHBvaW50IGNvdWxkIGhhdmUgYmVlbiB1c2FibGUgYnkgUlNUT1JTU1AgZnJv
bSBhbm90aGVyDQp0aHJlYWQuIEluIHRoaXMgdmVyc2lvbiAoZXZlbiBiYWNrIGluIHRoZSBub24t
UkZDIHBhdGNoZXMpIHVzaW5nIGEgbWFkZQ0KdXAgdG9rZW4gZm9ybWF0IHRoYXQgUlNUT1JTU1Ag
a25vd3Mgbm90aGluZyBhYm91dCwgYXZvaWRzIHRoaXMgYQ0KZGlmZmVyZW50IHdheSB0aGFuIGEg
YnVzeSBiaXQuIFR3byB0aHJlYWRzIGNvdWxkbid0IHVzZSBhIHNoc3RrDQpzaWdmcmFtZSBhdCB0
aGUgc2FtZSB0aW1lIHVubGVzcyB0aGV5IHNvbWVob3cgd2VyZSBhbHJlYWR5IHVzaW5nIHRoZQ0K
c2FtZSBzaGFkb3cgc3RhY2suDQoNCj4gDQo+ID4gICAgDQo+ID4gK3N0YXRpYyBib29sIG9uX2Fs
dF9zaHN0ayh1bnNpZ25lZCBsb25nIHNzcCkNCj4gPiArew0KPiA+ICsgICAgIHVuc2lnbmVkIGxv
bmcgYWx0X3NzX3N0YXJ0ID0gY3VycmVudC0+dGhyZWFkLnNhc19zaHN0a19zcDsNCj4gPiArICAg
ICB1bnNpZ25lZCBsb25nIGFsdF9zc19lbmQgPSBhbHRfc3Nfc3RhcnQgKyBjdXJyZW50LQ0KPiA+
ID50aHJlYWQuc2FzX3Noc3RrX3NpemU7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBzc3AgPj0g
YWx0X3NzX3N0YXJ0ICYmIHNzcCA8IGFsdF9zc19lbmQ7DQo+ID4gK30NCj4gDQo+IFdlJ3JlIGZv
cmNpbmcgQVVUT0RJU0FSTSBiZWhhdmlvciAocmlnaHQ/KSwgc28gSSBkb24ndCB0aGluayB0aGlz
IGlzIA0KPiBuZWVkZWQgYXQgYWxsLiAgVXNlciBjb2RlIGlzIG5ldmVyICJvbiB0aGUgYWx0IHN0
YWNrIi4gIEl0J3MgZWl0aGVyDQo+ICJvbiANCj4gdGhlIGFsdCBzdGFjayBidXQgdGhlIGFsdCBz
dGFjayBpcyBkaXNhcm1lZCwgc28gaXQncyBub3Qgb24gdGhlIGFsdCANCj4gc3RhY2siIG9yIGl0
J3MganVzdCBzdHJhaWdodCB1cCBub3Qgb24gdGhlIGFsdCBzdGFjay4NCg0KRXJyLCByaWdodC4g
VGhpcyBjYW4gYmUgZHJvcHBlZC4gVGhhbmtzLg0K
