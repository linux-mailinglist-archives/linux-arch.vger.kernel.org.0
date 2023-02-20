Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0B69D678
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 23:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjBTWwf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 17:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjBTWwe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 17:52:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979052200F;
        Mon, 20 Feb 2023 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676933548; x=1708469548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OnxeBoPeb/bSSOj1Yi0e6jg3GlgY34ZS/bYx74ppTjM=;
  b=Lz/RxT1OoY82YcTqX+tRqiKqee1f3duBaq9RJFdEsikUCd+7v6P9Sx02
   /7JcQMf//pw+9Z8287kZw3m0O0dA1h7/o55FGL10FgFbAO1AwbiviOHGz
   FuJAG2Ygm+M/HBRDwEY2w6NuvGfM7CE2fUNlmR3ozXN8thFPNxwa1I72s
   yEZbRunHMJI1jYEZLWxBpAdHiwEx7jC3D1famBPmM6AU4fRhmbJNbNkYr
   Jf7ixRQ1cZTTOxUA+RL9m+Mp4JxSeETTmb9OaY1uO0ekOdM1qkklxDyEQ
   ZPyw5n2bx4T8DBG/n27Xbn4N1XTQV9Bonwq5E1zJ+0M+PfKHoyhUUXpoA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="418725560"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="418725560"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 14:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="814277693"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="814277693"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2023 14:52:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:52:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:52:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 14:52:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 14:52:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ1g52FQq5Gql7HI5QLE73orYEimr6oroXYvN+iix38GbWz0CW1LoBK6mnu2uD2Illb/LlCpJxLmp3r6YLYl1p6rS7tPTI3EVNNf5gzqsQsITKw6NMgFqX1KSy2ey4yqgqa8AFRLeTkiQz69zu9gPWg9U9PmZPxNqCmIviYyXPTJTA4cvhCojTm3u9IiSyXqTt6PE7ctNhxcbIrk8yMqYXI3Myo9cOHUtQGcxURVoSL+3/NBY6HEVXLizQu5HOi3jLf4dmTNZ+T9fAzS65HuecRAuLGsM3rcEm7CF2IK8UNLxKNZevPqizswLrQJ42F5bQ3TA8fQ7gPfbzGYkligfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnxeBoPeb/bSSOj1Yi0e6jg3GlgY34ZS/bYx74ppTjM=;
 b=gy2dzatnuUwWgisMobUNd+FjREd2QKZpEdXH1Ox12KjnKy67hl+2o6E+fegIfUb5gQBYnN9RXLtz9qp/7jK65xZ0QB6p33+dSUmrD55BbMDiRBZc+l6QpEbgzXp3fjkiROriDyzK1HypEfFrgfAgixGlcKR2aLJONokp8PZVfqy9ZWOIOvU8Iw0gIn/UI56efwRzYemQwWmeHCKuJS1f/hw6cPjA8dghix8wRsxYFaoFDL+9Q08oHCHdEZVl2iM55r068Frm9MXAJIQPl5oVr1neCDVioyzsWcC44TBL63vheRAF/ZNZxbAIqwhq6CddjpFpAsooBqZHZlZ3sq4ldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 22:52:23 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 22:52:23 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 20/41] x86/mm: Teach pte_mkwrite() about stack memory
Thread-Topic: [PATCH v6 20/41] x86/mm: Teach pte_mkwrite() about stack memory
Thread-Index: AQHZQ94/o9KmkYV2wEmB4+Wapx1tsa7WvXiAgAG2xwA=
Date:   Mon, 20 Feb 2023 22:52:23 +0000
Message-ID: <5d0929e10d5333d611a8509c8e04cf8f55fd14b8.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-21-rick.p.edgecombe@intel.com>
         <63f28994.170a0220.e86dc.1134@mx.google.com>
In-Reply-To: <63f28994.170a0220.e86dc.1134@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL3PR11MB6506:EE_
x-ms-office365-filtering-correlation-id: d6b438fa-7c2e-41b6-277c-08db1395214c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aeJkelzleXoyzfyKFPD7wQLLYxyOpzBWRxnr5AHm+q+CvNGTY9IyPZg9yZpt3x8pdZD/BLL/QSfVKwHH2GCtmktSvBnS9ddT3gB1q5UEoTYHllrGgu1v8vBx8Q1Vra2t2LRRZbyjOyYgQbNdFMfepAjHnqAgYA2nVK41jweL654OiEHc1fazPVF29QcIFmaIwJ1y7hZAaGwu12OwzsSHwtBCbOnwgoRmZQEf0x7Mgi0XF3rfdFN7RQ+9n7VKmyiuhKyKRQg7MH/PVagyUCCERyoRDtfERrVxPJjDsfJG39qUIGAb5YFSEPoNfGbZnAedbSK7dO7WB3vMWXlctCKuk7IioQCzMKARfYs7Aw9TeNzXO1hODzF/ludjBN0ZoutcY+HZh0HSBH83DNsFQEPm0fvnKTOYevuBCIOelHgd0jl9C2Yb7LZpKE8m4imGPdb+p6RPPI8JM2T+9OO8DfqrkDKbgypxwN6VNtGnmdWMMgtvs/mE/vKpekO5FWko2nYTbOO6BXoW5Pu47Wt/GTDSwa+XTb+5HJabraNfA3sxI7rm/V8T2GDpNJ8TM8CF+tB6mShY8KKn7hF1L22bgREAzZ5QocQ54FaXFwVCqQ+Wl+PaG/5Y6ONSYyTuAE7BVpmRTJIPorZSQXhScmNV+hqpdy+4t6OMbTAPpT9i8EY0d6U17lZbNIukBlI57D4kN9Mt0GbBbYtveuwqWEAWVBnpV8joCuBrrqVzZEYd4cB/cHg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(122000001)(86362001)(2906002)(82960400001)(38100700002)(6512007)(6486002)(71200400001)(6506007)(186003)(26005)(478600001)(36756003)(38070700005)(66946007)(76116006)(66476007)(64756008)(66446008)(66556008)(316002)(41300700001)(54906003)(8676002)(6916009)(4326008)(2616005)(8936002)(7406005)(5660300002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlBrSktWZlZDOFlNRG4zZTljNHFTTXZhRCtrUzR2aVdrYmVSVDU1djBDV3Jo?=
 =?utf-8?B?M1EvZDJ0V2RGMDBiT0NNSzdpNXA5RjE4V3l4bTlmRWhPQnFONnhRcWRIOERV?=
 =?utf-8?B?S2dvT0F1czRXUWIwSk9UNGVKRDZ5bm1xSkw1OEl5M0dIajd2OUtxRXUwTkpE?=
 =?utf-8?B?Z2JtRC9qaDd2WVBZUUVkOG9wVHZ2NUd1eGNqc2VINVFCR052bFRJalhtOXpL?=
 =?utf-8?B?aVhoTzQ5dDBHdEVrTnl5YkhnUzhDV2JoeXRzU1JWN2sxTVpqbitjbkMwTlVN?=
 =?utf-8?B?NkhBQTZocXYzMFNpVXNWOUNTSldUejQ2aVZ3Sm82c2hwUXVkTEcxaFRLcWhC?=
 =?utf-8?B?VFNSUXRHUGk5bHVQdnJtTUhRcmJQOVlCYzdRZzVEd0NmNUN0emkxdExySGJX?=
 =?utf-8?B?Zm82TlozLy91TXAvYXhGV2dZSVJ4RmRzREJuYlo3eCtqeHBZWHBQMWVhV3Rx?=
 =?utf-8?B?ZmxqSjJrTUZCWHR0bWhUN0VxRmtPQnBnSjZhbG5BaFJxeDBoM3Fhei9IS2dG?=
 =?utf-8?B?S0h6Z2RzL3pGWFduMWZVVmUrRzBydmZlOExOOFNtbFJKMzJmdFFwbXlheXYx?=
 =?utf-8?B?T0Z0V3ZIeWx4NjJYcDdBRjl5TFVNNkRIdXhhaDl0a1VwVDQ0MzJIYUNGUDFo?=
 =?utf-8?B?OXJyRWJ4bHk1QWYxKzd4enFLSVMyNkZCcTd6dlovYVBuR01xT2psQ0kyd0hu?=
 =?utf-8?B?N2R1Tyt4QmlPL1JXRTZmRTZ3QTF2NlpER2J4NU1Ya2I1S3lEVjZIM3FhSEg3?=
 =?utf-8?B?bXZoRHZPbWZIQWdNeTRZVFUxTm5ZNFVKRWttRWhxSysrMHZqc2Z2emJ5NnI4?=
 =?utf-8?B?Y3MyTXZ4TG5hajNxaWxhT21oWHhmSGJaS1BzZmQzdWVIVU1LblpiWkdhanBQ?=
 =?utf-8?B?T3NoNnlqLzZ4dGZ3ZW82WmNRK0x4RnBBYnMvbGtxMWF2SmZZOVBWaFpNVC9z?=
 =?utf-8?B?eVYrZzNTRFc4UXhwblB0ZDNEZC9ObW94bnJHWTAxWityOUs0MEJBN2c1ejN1?=
 =?utf-8?B?aWJPRXIydlhiWG84Mk1uc2I0ZXdYTG0xZ0dlZlNxVHV5czBUZFJhdjk4Mmoy?=
 =?utf-8?B?ZWxPUllmWlR0T2Jvc2Vxb0hsRmQwblpmZ1RMaythK0kvbXZrT3hockEwQ2lW?=
 =?utf-8?B?UjJUVGZXNzdRejNRMUZsbExnU3hvVnFISnpVZTNqTkExSEN5dXZJaTJ4c1Rs?=
 =?utf-8?B?eVN6U2FCUUFzMkxMMXRNV05kQ3d0NkhjcmswS2JUVTVYZVBwbmhUSDBXSGIw?=
 =?utf-8?B?eDBCVUtzWkFMQlN0UlVjYWdFNFJsZU5rMnl4ekpEekVpRlNRbGZBTFVLYlNv?=
 =?utf-8?B?aG1TSXUwR0svRkEvSVVFbEM0N3B3MGxUYkZ1dDdwc0NlWkh6SGlxd2MyRjVX?=
 =?utf-8?B?OGdjQU1FczE2Qy9hakMxZmUrWmVYcnMrajJJVDhFUktZWmJ6Nm13N1VOVVBq?=
 =?utf-8?B?UUVObWhrc21DNmFCM0kySFBnVG5NVWhHMkpMZHpCWkN2UkdiVUxHek1aNXZN?=
 =?utf-8?B?Y3haNm5jODdtU0VpK2JvenBDTGRMbkRaV3MvNlp0RXJFWkV2UVJleU9SeWJP?=
 =?utf-8?B?MFplRXQyUHJpSU8vb0ZIS2Znd0gxZVR5OTdZMmIvKzRRdGhhMTF1UEVwNWJI?=
 =?utf-8?B?Sm9OcmVVVU5ucWxDMG1nZDYxdXY1SUNpbk9NcTVBRFRzdTJ4dVZOWWVVb3gy?=
 =?utf-8?B?aXVhckZMVEpralR5Vkhia3hGOVNIRUFzZ20vMlYya2pEZWx6aEhkbTBPOGZN?=
 =?utf-8?B?NlV0aVprd2szM3dEZXJwT1F0ME1VeTQyUmJTKy9QZ01ZdmRBNnh3ZExaVGp4?=
 =?utf-8?B?aEloQUdxVUs3dFpCMTFhZmw5MDBzeXVPOHBKQ04vTzNaTTV1WEh5bkNQQ0FF?=
 =?utf-8?B?My9WdFlWU2xoUGhTWlArZ0FJTnhkZ3RJcVFqZmY5VDcrVWhTMVh4VEZkKzBw?=
 =?utf-8?B?WkhsUFVJYzRlUG9KeHNvd2lIdU9laXFjc0NGbFN5M0xnNjNtZnI5ZDVuQlFk?=
 =?utf-8?B?UVZDUDNUL1F6Tm9xcnhIUGNGL3g2UldvQkQxdjV6RXREYituTm4rUnpKM2o2?=
 =?utf-8?B?NmY3a3o1TnI3QUk4K1BpVjhLT2NSU0JMTndCWGZ2SGNBcE5uMHdpbWUzc3Q5?=
 =?utf-8?B?SHhFMnFLaFF5WTZpcTgrMkwxRjFjUW4yK0tlYmlKQWthNEZCM0dOREMvZDZP?=
 =?utf-8?Q?DkzZqATmKklGBTFRceSoJHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <408F574D1E313C43B3F4FE6FA6755206@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b438fa-7c2e-41b6-277c-08db1395214c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 22:52:23.2438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1MVcaGcAGDDesCjX3jyLPFo7BWuYbvazG+yptD2GsviHDq1akGDwtWkr4Kdzu1KcawSjKhteaYp45rBcjpFWJG1WytIwLP6EYDio00TwZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU3VuLCAyMDIzLTAyLTE5IGF0IDEyOjQxIC0wODAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFNhdCwgRmViIDE4LCAyMDIzIGF0IDAxOjE0OjEyUE0gLTA4MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IElmIGEgVk1BIGhhcyB0aGUgVk1fU0hBRE9XX1NUQUNLIGZsYWcsIGl0IGlzIHNo
YWRvdyBzdGFjayBtZW1vcnkuDQo+ID4gU28NCj4gPiB3aGVuIGl0IGlzIG1hZGUgd3JpdGFibGUg
d2l0aCBwdGVfbWt3cml0ZSgpLCBpdCBzaG91bGQgY3JlYXRlDQo+ID4gc2hhZG93DQo+ID4gc3Rh
Y2sgbWVtb3J5LCBub3QgY29udmVudGlvbmFsbHkgd3JpdGFibGUgbWVtb3J5LiBOb3cgdGhhdA0K
PiA+IHB0ZV9ta3dyaXRlKCkNCj4gPiB0YWtlcyBhIFZNQSwgYW5kIHBsYWNlcyB3aGVyZSBzaGFk
b3cgc3RhY2sgbWVtb3J5IG1pZ2h0IGJlIGNyZWF0ZWQNCj4gPiBwYXNzDQo+ID4gb25lLCBwdGVf
bWt3cml0ZSgpIGNhbiBrbm93IHdoZW4gaXQgc2hvdWxkIGRvIHRoaXMuDQo+ID4gDQo+ID4gU28g
bWFrZSBwdGVfbWt3cml0ZSgpIGNyZWF0ZSBzaGFkb3cgc3RhY2sgbWVtb3J5IHdoZW4gdGhlIFZN
QSBoYXMNCj4gPiB0aGUNCj4gPiBWTV9TSEFET1dfU1RBQ0sgZmxhZy4gRG8gdGhlIHNhbWUgdGhp
bmcgZm9yIHBtZF9ta3dyaXRlKCkuDQo+ID4gDQo+ID4gVGhpcyByZXF1aXJlcyByZWZlcmVuY2lu
ZyBWTV9TSEFET1dfU1RBQ0sgaW4gdGhlc2UgZnVuY3Rpb25zLCB3aGljaA0KPiA+IGFyZQ0KPiA+
IGN1cnJlbnRseSBkZWZpbmVkIGluIHBndGFibGUuaCwgaG93ZXZlciBtbS5oICh3aGVyZSBWTV9T
SEFET1dfU1RBQ0sNCj4gPiBpcw0KPiA+IGxvY2F0ZWQpIGNhbid0IGJlIHB1bGxlZCBpbiB3aXRo
b3V0IGNhdXNpbmcgcHJvYmxlbXMgZm9yIGZpbGVzIHRoYXQNCj4gPiByZWZlcmVuY2UgcGd0YWJs
ZS5oLiBTbyBhbHNvIG1vdmUgcHRlL3BtZF9ta3dyaXRlKCkgaW50byBwZ3RhYmxlLmMsDQo+ID4g
d2hlcmUNCj4gPiB0aGV5IGNhbiBzYWZlbHkgcmVmZXJlbmNlIFZNX1NIQURPV19TVEFDSy4NCj4g
PiANCj4gPiBUZXN0ZWQtYnk6IFBlbmdmZWkgWHUgPHBlbmdmZWkueHVAaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNv
bT4NCj4gDQo+IElzIHRoZXJlIGFueSByZWFsaXN0aWMgcGVyZm9ybWFuY2UgaW1wYWN0IGZyb20g
bWFraW5nIHRoZXNlIG5vdA0KPiBpbmxpbmUNCj4gbm93Pw0KDQpIbW0sIEkgY2FuJ3Qgc2F5IGRl
ZmluaXRpdmVseS4gSSB3b3VsZCB0aGluayBpbiB3cml0ZSBwcm90ZWN0aW5nDQpvcGVyYXRpb25z
LCB0aGUgYmlnIGNvc3Qgd291bGQgbm90IGJlIHRoZSBQVEUgc2V0dGVycy4gRm9yIG1hcHBpbmcN
CnRoaW5ncyByZWFkLW9ubHkgZnJvbSB0aGUgYmVnaW5uaW5nICh1c2VyIHRleHQsIGV0YyksIEkn
bSBub3Qgc3VyZS4gSQ0KZ3Vlc3MgaXQgZ2l2ZXMgdGhlIGNvbXBpbGVyIGxlc3MgZmxleGliaWxp
dHksIGJ1dCBhbHNvIGdpdmVzIGl0IHRoZQ0Kb3B0aW9uIHRvIGhhdmUgb25lIGNvcHkgYW5kIHNv
IGxlc3MgdGV4dCBzaXplIG92ZXJhbGwgZm9yIHRoZSBrZXJuZWwuDQoNCkFyZSB0aGVyZSBhbnkg
c3BlY2lmaWMgbWljcm9iZW5jaG1hcmtzIHdlIGNvdWxkIHJ1bj8NCg==
