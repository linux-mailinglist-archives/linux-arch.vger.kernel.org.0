Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51A62FA1E
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiKRQVg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 11:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbiKRQVf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 11:21:35 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D0A9208F;
        Fri, 18 Nov 2022 08:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668788494; x=1700324494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=KDYnOfGsVc/CJyUx+cJ4afMHHVKDIl34PmJV05JpsTA=;
  b=KOR+K/yqCl9o0pNx5JKKPoz/BqOWR6PpGz3HmQ6yGetNHOPsqEeqaCGe
   XbZdj9EWEodnhDct2uSYNIFHpGO0Lad+kphQs+OJflPBxQQVtvFMO/+Mt
   MEJjMS+p390JcBAgNlNPEoLetDvTEii0/LxJSAtDE8azowgyyorIQ3ReW
   +23gi3v6e7xmNSJ15gF7QDa8BTVo3SHPN3jqJl5ov46Ro3/hakTemVut1
   9hxL3QFznrs4UWSR2Pe9bld5yVmUQzRUriut1NZcnzmitdjIyutVhFkyV
   Y2hJPG0d8Fn8F2Ip4ClgCrjx6BjB39+DILqwhAXO0LY5Ei/aiX8kg6Oxa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="293560742"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="293560742"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 08:21:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="782696007"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="782696007"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2022 08:21:29 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 08:21:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 08:21:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 08:21:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmN7TtoSaSrrLx32bwyss0GFl2MbHgUPEUrHI1OEXX3wwq6uZHBtNvu9yNKadN91ChJDU27H+G7EQt3/XWrBKPQWipz/ou51qvqx1UbtF5rI7VN0uuBhj7CSbwDxpbvtOhFPX+n0LbDTbfjdkixHEkUs+Zr9sP2aXEbNMJaHiXo83RBFLzg2M/BThFR5MR990jsSwyloohYSc9MM/qUX+CcjNhzLPu3Y5Gd39BzHDZ+TNfCrxkS1gjODMP+6a+8PQDrma3fb1X66T4nuVIfHrxHIAmxge2OPkjHds2zCdXtGGWdotWHnldFCOv3Le5i8pyR8BrwhIP0Frr9MnvxBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLI+4isOMhwAly+DiTRFinORe1AyBvWkNkDaGk77Dqw=;
 b=fekyFPA1dhooGbqhaJuxzH7jydN0s5GbL1KugLR9ORgcyG6LSSrJRLWSfbiJq6zTlqvrOAZxb30mvIqCahiYMSHjRSKEp1Gh14FDP6VGUn58ZlCgBH4WL8uxa87qyWVUGWmgRwmnklLQ66X9G5NUmT5DVdVsOYuqxvmUz4MPbmmK6aQ8BtJh1R0KRJxxl3AbX1dmx9uNerpiMUddonDcGfHL/BCeLe74/p/7KvxkX2awIRaomhRAlaWmpGw9yTOov1C3PYzqxpW6w9QO1UKjR6Q3zvM4K+593If4GbEHj4iFV2LmSpUX4qnHgusV4RgIeO4Vwc2cp/+iGTR7Ndnrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB2005.namprd11.prod.outlook.com (2603:10b6:903:2e::18)
 by CH0PR11MB5345.namprd11.prod.outlook.com (2603:10b6:610:b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 16:21:20 +0000
Received: from CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::ad04:c349:b06a:c1b4]) by CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::ad04:c349:b06a:c1b4%9]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 16:21:20 +0000
From:   "Schimpe, Christina" <christina.schimpe@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Topic: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Thread-Index: AQHY8J5eaXgH6xugZk20MwPZdy8SOK5AIA2AgACAkACAAnwdkIAAf9AAgAFU61A=
Date:   Fri, 18 Nov 2022 16:21:20 +0000
Message-ID: <CY4PR11MB20055995B323E98C10BA159AF9099@CY4PR11MB2005.namprd11.prod.outlook.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
         <20221104223604.29615-36-rick.p.edgecombe@intel.com>
         <Y3Olme4Nl+VOkjAH@hirez.programming.kicks-ass.net>
         <223bf306716f5eb68e4f9fd660414c84cddd9886.camel@intel.com>
         <CY4PR11MB2005AD47BA1D97BC1A96A769F9069@CY4PR11MB2005.namprd11.prod.outlook.com>
 <a2c2552fcdba1a0fce0d02aeb519d33cac83bfd2.camel@intel.com>
In-Reply-To: <a2c2552fcdba1a0fce0d02aeb519d33cac83bfd2.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB2005:EE_|CH0PR11MB5345:EE_
x-ms-office365-filtering-correlation-id: ac394334-2f85-4529-8fa7-08dac980ed56
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HauJnHPC+CdL2+WnU3nZKiM+uT5F1zhxzds2UJw4fp//gEIz4MRayAYehgqmQW0Mjh1ABQL3yfbx6JTU734X+IcKEiqxVIndm6sp5AbMm4oevUEupWvhWKtw+SPHIF6cTrfMAYRaf6WhIan8EjLPMhw2hU9J6r/wCTEi8e1GMzkhoefO9IeW4KYREh8SFVyQNnG9f7NtCcUvm380QkO/2sZ8V3nakdc3BkatrG5cK+fv7A6JVIqsbnytyCgXvy9UzNwNZW2xxpaxgEFOtz0/XfUfFagMDaX3Lf0AGQBtv6RrJ5XLXPff8+tZ5mcDPDRMh4S88FPS6wqTVF6r3PIgxm2hioHUVTN9ekb5OrBIPWiMisyAkwpl25xim5EHYN4RBTv9r04J+tUkAzxfbuHDboUVyJFP0cgJOoqYU37AA66ckrZW+G1EEzBR4G4/UlrAb4X3N/RNTGj2qZPCPz5SSy0m80AamTStpWm5Ekmc1tLZk3VrFuKen9tEzb3UEUEOHMu6AWOqrkNLn7KNnzL5QZ6PhWmIRHqBiiAipcYCQHVJYlZYjfwx5SvOR9Jjj+h7LllhsV4vcFBUAET/Eq7CH6HFQb9VFhbgvccUh5KZzCTpD5TraQnKCyKwJf2ktDw+I5bIwO21nI7pM5N3EqAY5saNZRbotit/vl9kuR1bSL2LoE3r1f+Xgn54GjgYZZvmZcEB/aAvZfGl0uJa5+2+HQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199015)(66476007)(71200400001)(478600001)(52536014)(38070700005)(33656002)(86362001)(7696005)(8936002)(5660300002)(7406005)(7416002)(2906002)(4001150100001)(6506007)(66556008)(110136005)(76116006)(4326008)(8676002)(66946007)(64756008)(41300700001)(66446008)(55016003)(122000001)(9686003)(82960400001)(26005)(54906003)(38100700002)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUFiK1NuemxQeFljdjI4eWVsaGlhRzJQV1MwaEZUUEs0WFp5ODdqUUxkZlBW?=
 =?utf-8?B?eURhcnNoeGRJQUN5TStKUFJQcnF2MkFVdEdCWlYvS2FlcG9oWWRwNHNMOHVK?=
 =?utf-8?B?UGEwTTRkT0FaanhUT241eXUvTktTUkFod3ZUL2JtVEM5Z0YwelVXTWJkTDFn?=
 =?utf-8?B?WGR2RVFNRDV2bUJrZ3c4UTlVSmh0M1MyNy9zaStramIyMVFTRVVqdEdaYXNN?=
 =?utf-8?B?UUY2bDY1TlQ2dGFTTjFINk5HSTZPeEtKa0owWjB6czU5a0hMWTRPa0locW9a?=
 =?utf-8?B?VW8wWENBTllCTk9iWVZrWThmdXRNRG93TFZLWUI0bzFsZjA5OXl5RFQweDl2?=
 =?utf-8?B?ZjVTelhydWU4V1JCdlQ5U2drMklzZ1llakJTOVplVUFnZHZaYmJzVk1ONy80?=
 =?utf-8?B?OWpDSnlpR3VDZ2RBcVdQWmY2M3dCR01sYVVJSGJJdFA0Q3h5SWNPandqMjhi?=
 =?utf-8?B?S1hHeVliMTF6OW9SNlNXaWNiZG9OZFhiV2JwUXJqL2pVYXpLK3J3WHRkSFZQ?=
 =?utf-8?B?b1dUYlZDb1hTKytkUkNtK21nL29zT25xM0ZhdWtmc0JBM2ZlbUNjTnNPZlRk?=
 =?utf-8?B?RWgrMDdrYWZ6K0Q3MWFIWkNkVDdZc1BYYWQ4andFckJ2TzFHaHVWTE92VXNP?=
 =?utf-8?B?eWcrNGJLRGxnOXJKVTE2SWNOVlFUeTJuZWJqZ2tiUHlaWmcvd1N4QTZvZGJW?=
 =?utf-8?B?L2s5bkg4TXRNTFJsUTY4Tit0ekk3S2RJZThJN1Vua2hDMjZxMGlQQWhHNDdj?=
 =?utf-8?B?VnJBRG9iSGZiSVVzVXFwVHNxWVlUR3NJaEhBR0hQYnluc25DcFlHN1dhSWlS?=
 =?utf-8?B?dit2ZFkycHUzU1Qxc3JOWWdqV3gvaFFMT00wRkZwYkd3dDd3dktRQU5veUJM?=
 =?utf-8?B?MEZuQ1MveGg0MmVLWDhGZDJkbWg4U2ZKMWoxUFd4N00xL0ZoUTZNbVpoTytQ?=
 =?utf-8?B?dFJzZ1RFWjhZY0pLMVdjc0Y0bDFDenBHQWhZZTlVbTZRK2h6VGtDUU5yWFlr?=
 =?utf-8?B?QWMveTB5Y0lQZEtSSVM0ejY4VW9mcWFDWEl4b1FkdGFIL3RRTUdvaDVyZTFw?=
 =?utf-8?B?TVZLRENOWk5wVGtYQUtHMnZCeCtiS3VQTlFmb3JNbGtxS1hET1ZXWjJXSUpr?=
 =?utf-8?B?YWRBZVkyNmVzYjFHOVJBaW5hZWpyUUd3L21pTUZPNG5ydzB2c1cwQ2hyMDhh?=
 =?utf-8?B?WTBROE15OVIxMC9WdXVNcUlLQ3htV3lxS25jdGxqUVBjODQxa3ZkbEVtSmFv?=
 =?utf-8?B?RXArcmpMQnZYNzl1LzlONHZXb0lCa29qdTZEL0h5RncxTEdTL1FKRlhWTjRR?=
 =?utf-8?B?T2FlYytobmt0ZEhkRndLOGRBdDV5Wk8zWE5ZUDluQUhPNTRMS0tWQ0owTkFu?=
 =?utf-8?B?MDhvS3dDRWM5UmxxZUlRWHNIMThhVk1xalNUbU5rQjIyTmtVNlRFUjZXVmQr?=
 =?utf-8?B?RlZCb04xNjIyL1lBRTF2N3JOelVWMk5yQXJQZFEvWlN1T1hVRTVHS0N1WFpI?=
 =?utf-8?B?TGFXZ0o3ZXBOQjNVbndneVZUZmpWdnp1YzgvbnhCaGVCUnVIckNUaGg4bGJY?=
 =?utf-8?B?NGNnbGNXRnd2VS9nL2hOUGVWSVBoay9UU3pJckZ4NStST1l3Nk9sYjJuaDF2?=
 =?utf-8?B?R01TOFpBRDFtSkV5aU9GNy93dUpaTTFhcHJSR0V3aEtKNUhqdzAxR3A4a0tE?=
 =?utf-8?B?OWp1aHFIT2Z4dmFqQ2crWVdGeC8xclNEOVAzR0k5RVVvUG9qbGVmSzNLZ2tQ?=
 =?utf-8?B?Tm53b0dsRlJZQXRDSUxSdy8zSUJPem1xYlduYVUvOUxzTnpXb1FpM1Z3NTE3?=
 =?utf-8?B?d20vc242bCtacUtNMEM5R0h6dzlpMmIya0hnN0MxKzgvbFFPWU1LWDI1RklH?=
 =?utf-8?B?V3hpUm5lTmFHRFNzR3l3bzlZK1hjc2xYb3ZvWkpTVjA3QldLVGp4MkMra2th?=
 =?utf-8?B?cTJ1cXpDVVhobFJNdndqWlREZ0szL2ZCRTRXVXk3MDJENThGRFd0VitabjBL?=
 =?utf-8?B?YUVabWtGUFJiOE5RU1lqRlRxUzRBUTJnUVRmeEpPeGRTd2VtbUd2bXdrTndy?=
 =?utf-8?B?TGJZNEpJSWRzc3h6YVhuMy9DaHcraEtqOFIzOTdITkk1S0NBZUYxcVlxYTF1?=
 =?utf-8?B?SlYzN0h5YTY4RlhWVEhvRm4zYlNGTTNTNjYvSk96NVJObkVaZloyVml3TVM4?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac394334-2f85-4529-8fa7-08dac980ed56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 16:21:20.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yR6rDH6HJN6uazqh+hMyFwdYkFRYtUH6lNYcMR0MqoScUjQ5k9f2bn9i0M8BNMeXsYsVsiwCTq01SiwIrTxNQGgrtIkhEw1CrWVphOT89o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5345
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBPbiBUaHUsIDIwMjItMTEtMTcgYXQgMTI6MjUgKzAwMDAsIFNjaGltcGUsIENocmlzdGluYSB3
cm90ZToNCj4gPiA+IEhtbSwgd2UgZGVmaW5pdGVseSBuZWVkIHRvIGJlIGFibGUgdG8gc2V0IHRo
ZSBTU1AuIENocmlzdGluYSwgZG9lcw0KPiA+ID4gR0RCIG5lZWQgYW55dGhpbmcgZWxzZT8gSSB0
aG91Z2h0IG1heWJlIHRvZ2dsaW5nIFNIU1RLX0VOPw0KPiA+DQo+ID4gSW4gYWRkaXRpb24gdG8g
dGhlIFNTUCwgd2Ugd2FudCB0byB3cml0ZSB0aGUgQ0VUIHN0YXRlLiBGb3IgaW5zdGFuY2UNCj4g
PiBmb3IgaW5mZXJpb3IgY2FsbHMsIHdlIHdhbnQgdG8gcmVzZXQgdGhlIElCVCBiaXRzLg0KPiA+
IEhvd2V2ZXIsIHdlIHdvbid0IHdyaXRlIHN0YXRlcyB0aGF0IGFyZSBkaXNhbGxvd2VkIGJ5IEhX
Lg0KPiANCj4gU29ycnksIEkgc2hvdWxkIGhhdmUgZ2l2ZW4gbW9yZSBiYWNrZ3JvdW5kLiBQZXRl
ciBpcyBzYXlpbmcgd2Ugc2hvdWxkIHNwbGl0DQo+IHRoZSBwdHJhY2UgaW50ZXJmYWNlIHNvIHRo
YXQgc2hhZG93IHN0YWNrIGFuZCBJQlQgYXJlIHNlcGFyYXRlLg0KPiBUaGV5IHdvdWxkIGFsc28g
bm8gbG9uZ2VyIG5lY2Vzc2FyaWx5IG1pcnJvciB0aGUgQ0VUX1UgTVNSIGZvcm1hdC4NCj4gSW5z
dGVhZCB0aGUga2VybmVsIHdvdWxkIGV4cG9zZSBhIGtlcm5lbCBzcGVjaWZpYyBmb3JtYXQgdGhh
dCBoYXMgdGhlDQo+IG5lZWRlZCBiaXRzIG9mIHNoYWRvdyBzdGFjayBzdXBwb3J0LiBBbmQgYSBz
ZXBhcmF0ZSBvbmUgbGF0ZXIgZm9yIElCVC4NCj4gDQo+IFNvIHRoZSBxdWVzdGlvbiBpcyB3aGF0
IGRvZXMgc2hhZG93IHN0YWNrIG5lZWQgdG8gc3VwcG9ydCBmb3IgcHRyYWNlDQo+IGJlc2lkZXMg
U1NQPyBJcyBpdCBvbmx5IFNTUD8gVGhlIG90aGVyIGZlYXR1cmVzIGFyZSBTSFNUS19FTiBhbmQg
V1JTU19FTi4NCj4gSXQgbWlnaHQgYWN0dWFsbHkgYmUgbmljZSB0byBrZWVwIGhvdyB0aGVzZSBi
aXRzIGdldCBmbGlwcGVkIG1vcmUgY29udHJvbGxlZA0KPiAocmVtb3ZlIHRoZW0gZnJvbSBwdHJh
Y2UpLiBJdCBsb29rcyBsaWtlIENSSVUgZGlkbid0IG5lZWQgdGhlbS4NCj4gDQoNCkdEQiBjdXJy
ZW50bHkgcmVhZHMgdGhlIENFVF9VIGFuZCBTU1AgcmVnaXN0ZXIuIEhvd2V2ZXIsIHdlIGRvbuKA
mXQgbmVjZXNzYXJpbHkgaGF2ZSB0byByZWFkIEVCX0xFR19CSVRNQVBfQkFTRS4NCkluIGFkZGl0
aW9uIHRvIFNTUCwgd2Ugd2FudCB0byB3cml0ZSB0aGUgYml0cyBmb3IgdGhlIElCVCBzdGF0ZSBt
YWNoaW5lIChUUkFDS0VSIGFuZCBTVVBQUkVTUykuDQpIb3dldmVyLCBiZXNpZGVzIHRoYXQgR0RC
IGRvZXMgbm90IGhhdmUgdG8gd3JpdGUgYW55dGhpbmcgZWxzZS4NCg0KDQpJbnRlbCBEZXV0c2No
bGFuZCBHbWJIClJlZ2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1Ymli
ZXJnLCBHZXJtYW55ClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwgd3d3LmludGVsLmRlIDxodHRwOi8v
d3d3LmludGVsLmRlPgpNYW5hZ2luZyBEaXJlY3RvcnM6IENocmlzdGluIEVpc2Vuc2NobWlkLCBT
aGFyb24gSGVjaywgVGlmZmFueSBEb29uIFNpbHZhICAKQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVy
dmlzb3J5IEJvYXJkOiBOaWNvbGUgTGF1ClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gKQ29tbWVy
Y2lhbCBSZWdpc3RlcjogQW10c2dlcmljaHQgTXVlbmNoZW4gSFJCIDE4NjkyOAo=

