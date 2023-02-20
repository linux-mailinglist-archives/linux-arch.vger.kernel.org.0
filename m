Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7569D5B1
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 22:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjBTVX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 16:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjBTVX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 16:23:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9A1E5D5;
        Mon, 20 Feb 2023 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676928236; x=1708464236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1vgWoAe6ztvOHABvIiA2CHVado0jcezD+FSDqT2NC8w=;
  b=dMpwN6J3QVTSUxgNYkb/GJiBUc8uzrvjFVPq+YoGvRykNcH/h8UaVdsv
   iWwC2nKiIJbP10UxzBo62rnR3LzA7Ol5OFUwyHh5S/KlZ6iRFO01v6JkM
   ebvg5UdZAp32MRy47YND1EGO6zw5KsOHbm+duT2b5ZKwQnT3gohrDqLCj
   MkD9D5RFzqp+jVMvKnxn5MoK+Ea1DH0BRC3mgH5J2T/GuWqObHbg7kLOW
   p354Z2UTsiFFlramgMa8RlQ3ZKJUMEBIdTo/CibD+N4twfmYXasVR4kPk
   O8vU5Ls0dKWTjcWtCJy9jIII/KX6yyQBvoSYBIfQwePWgCqyPuh/XGW0G
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="334690551"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="334690551"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 13:23:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="648945863"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="648945863"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2023 13:23:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 13:23:54 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 13:23:54 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 13:23:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4wJopZqqT9k5jh1jqjQh1WGYqzi+kUbEEPsIJwPON5vpgaqrVKISUuErXxzL+xqQMp4MW5SRQM7e4BcCDMYE/Y/hrzUFHDJxrS8nLgoSc50eoq+OFH6H9h6Xn2FQidaudhTSwW5Jeh1eSJhSnTVnhXFS6nsO/0tZh3KkE9asm9mKItbrjblWxauHjps3z8EVH2y3Ho+fwMQVASrI/X0Hl3yH7kzkDLyjV8Y/OkfPAn32G+Z6tel09eIeAfPWWkfmpo6jfsRla4oWrVjiJQp2MuLRY4+MWSQ6S0d+REJiSKS8U/AuwnmikvWIUw9Nb3skiS6GTjQ09UoBlAzC4WaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vgWoAe6ztvOHABvIiA2CHVado0jcezD+FSDqT2NC8w=;
 b=epN8ynWbEC0c8IahpA3nqM3o90IYENiE8JsjZt+o/+HdKcguHcdotYqquOY7Mfq59j+2hsPcmvWedfh4OaEM8s/mMu7aVL7dvVPSbeSlKmDM18i8/DmJmcYRD+D2/VVi4N23MbX9IcPrIcaTfPClTFBwkQjh2Q6KhfMmOgo9az5qW2mgvhYq2Ji7xtiREYnkEKQIRmAaPoLDcn286WIxwPdIXf7jN7jOy+TXIh2mLDOo/Yel3EQ7N6Oy7kInafMpuy0NV8lJ4O4vnfrp7Iw9hArMBWfPKIVtKU8fBxchRoXfuYBKtv1l815rEKmDv2r6NBNPRq7UKIFnGRzxuv5TbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH0PR11MB5218.namprd11.prod.outlook.com (2603:10b6:610:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 21:23:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 21:23:51 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v6 00/41] Shadow stacks for userspace
Thread-Topic: [PATCH v6 00/41] Shadow stacks for userspace
Thread-Index: AQHZQ94zC/f+ziZRo0mOlVOyPZwhw67XZ4CAgAD0AwA=
Date:   Mon, 20 Feb 2023 21:23:51 +0000
Message-ID: <0806937dfacf1ff38f35b17e85335bd02963e62a.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <Y/MYNRHrG61ZiAgt@kernel.org>
In-Reply-To: <Y/MYNRHrG61ZiAgt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CH0PR11MB5218:EE_
x-ms-office365-filtering-correlation-id: a9f87922-c899-4152-4a8c-08db1388c344
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EdU2A/a7eqlINANSt3wTclW2248fY+bpYuVuL61DorysvSDMlVDq4jFVA58POZjHxlqVRT/9+xCvzcyVAVTVYw6AeZhGhK+1Rfx68O9z6+6B03CLBZ35qN6D752+k4MH5dD5OR9dlDDp3Eybr9CHTv07PV1nw7a7oDNZOoNC/Uf7DIzLXdqsxSPysM0rYhFCLfHHNkVcUc89twJ2IZnFtGpmAZWPx+gid4LPPEZWcU2zTPAptFqgqv7PGdqNrL0KlGGDSmErjaKPp22tKo2AyVRkTUTLAS0qkGvBTq8RtVpNTDNfhF+ruodOZgjr7sDe0R/jl4vvgtW/NipAA09LvIr9EHyGRQBjTG/INqnoSrMJCGzcmbZjZkpZosBlf10X8PevzGHZuExse+ZYHlM0CFSusUIrENIZvO6dqcyUw7EXKjKTnd4BZf4DF6nNDbfImeTaCF3J1zetq+iNIorWcyO9n0GVOn//92BSfjaFLCNRcScCpL+Mni9ENRawUQ485mx1lrAyF+yxLhM2x7fdSCW+5jKtbDY8YEimypU4jNq9s78eLAaqDcYZubulL1Z9UkRzFyzy6fkl8Ybys8aRna0MFZnErO5WMWfs9M2iNTVMtLXRj2cG1nrfrPPB9rMxd1UgCeQuOcnztOj7d7Fm5EWzFfhhuUbsuvBhZ05wos2GGsurp5cTX0eycX0MBkJnGwIPwu/7BIIE7w06kCRJKDTCsROlmC2Omkye5xX6rOI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199018)(5660300002)(8936002)(83380400001)(36756003)(86362001)(38070700005)(66946007)(122000001)(82960400001)(38100700002)(316002)(54906003)(478600001)(41300700001)(64756008)(4326008)(66476007)(66556008)(8676002)(66446008)(76116006)(6916009)(71200400001)(6512007)(2616005)(6506007)(26005)(186003)(6486002)(2906002)(7406005)(4744005)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlcxNEJGQzNtdjlEZFRVQ1ZGcG1DM1kreXcrNGZ5RXVScThxOU45WWRKRzZp?=
 =?utf-8?B?RmFsaTlPUFFWK0p2M2pYbVBacXdWLy9ldkN0Y3NrY2YzVi92d05sbERlWjY5?=
 =?utf-8?B?UkhzeUEzZlRub1BrTDQyK2JKcWloaDZmdkhkWHRDZW8yV3huendBVDJFN1c1?=
 =?utf-8?B?alVXLzVxV2l1Z0VraDVIVkJmTTc4ZnRGYWo0N2ZpU2U0dkxYMHVyODFydW9z?=
 =?utf-8?B?N0lKeDJIeWVWL0Y4RGZDbHlRVU9XdVd2MGh3ZDBPcEE5QVRLTnJFa0lzR1hP?=
 =?utf-8?B?NTMyb1EvK1BKTG4rZDg4L3FOUVhLK2tmK1FoSjFZTUgreUVkdTQrUTdZa0pD?=
 =?utf-8?B?eU5wREt2Ty9mQ05lUDdSTGNLM1A2V0hMdjNKbzVDazFaSUFjL2pDcTUyVGNO?=
 =?utf-8?B?TE9TRHFPSFRrSGJlWlNGTHltNmI1U1BWeDc4a0FkaFFWSEZ3cFVBMUNQNWcw?=
 =?utf-8?B?SzgwUmZBcVJDQkFub3dRNFV2bERCQzJhbUpCQ29TZ3lURHhUMUxmSzU1R1dL?=
 =?utf-8?B?NnRpVFRjTFlYN3E2UGZ5V282ZWRFSHVYaXpkWHZtOG5DekdjbzdnZ3JBbnEw?=
 =?utf-8?B?TEtNYUl6eU02amxxbmJ2RCs0SWZ4K0VQenlNRGdxeVZienY0MHZzT1hwbXRs?=
 =?utf-8?B?TlVhdkkrR0crdzBRN2RkWWVJZGJLUi9BYUpKVmxibEFTYkM5VnNZTkRyMk9L?=
 =?utf-8?B?WUpXOWRIQXliazF5cytaTDgzY2VYcDQ1T0kzQXBzcXVlTE5iZCtwaTdjRjN6?=
 =?utf-8?B?dXduQzh4ZVJhaVkybW94dXppcnpoSURVeEhXUXNuck5WYW1vc3lRbEZkeEtW?=
 =?utf-8?B?ejdoMDd1Z1RpRmhiYXFCWEdJZUxVRW0vOGFGekNQTHVMUHpwdms4K1BkUDJX?=
 =?utf-8?B?THlqYzZTM2R0amNnNllqNFRNOEdBT29YV3QyaTk5Y2RSSWsrQjR2NHUvNUVK?=
 =?utf-8?B?MG96RStJMWtLakJ0dVZxRmd1NTVreVFHR20xZEZUbkp2UHdaZDRvMXBGZHFr?=
 =?utf-8?B?YmFuYW4xQm9hRXN4a2NnZkZsbTlvT3dKeVJnMjgvL2dIdmZXTXNqdlVBOGtw?=
 =?utf-8?B?TDFrT1RIWktTMFc2c013Q2s1KzN4bkc2U0R5Q1VlWHdibUxoTkkwakFhVFVt?=
 =?utf-8?B?WjloOUwrVXVXM0MxVjcyaHkyajNvUnVnVHFuZ3JCSkZSa2hOTkFhY2t0M3FY?=
 =?utf-8?B?Vkl4R3NWa2UvWUtQRnRpVXVSNVJEYmRGenFBTFdSY0xRcEppbitpdWt5cENO?=
 =?utf-8?B?YU9xM25LVWdOMFV6QmtXbktjQjUrZ29raTlPRGE4UWozM2lVM1VtaWFjdGxm?=
 =?utf-8?B?U1F2WnNGKzJGb1M3bTNHSVFMVVVyaDVydHI5UHNxRTMyZ2ZRdzh2ckd5QU5i?=
 =?utf-8?B?SFNPQlNCZWRQcEZveUl4eDdEdEZyV09hOEpaYjZZOWkvVHR6a2pFU2o4bjM1?=
 =?utf-8?B?eS8vbUEyU204UWxaSFpyZ3BUTlpIU2lzU1ZGOFRRSGZQbUR3a2Q3Sm93L2pk?=
 =?utf-8?B?MHBVbUVPSVl1UUROREI4MTUwbk5ZbTB5d051NUNyUjBVbGl3MmRFdWp6bU9r?=
 =?utf-8?B?M01LRThqcGlQNHBjenpqWkE4WE9aMkg3eTJSZzA5dWViNFVwSVhaV1NDZkdB?=
 =?utf-8?B?bHhuWFZsQ05MM0QyMGxUQ1kvQnJaYW9EdGQ5a3ZlMlNLRmJLdDlPVkp3b3Uz?=
 =?utf-8?B?NUVIYTEvbkpkZU90R0I1VEliYXdzVmtTNHZVV0dkWldqRzVLK2FqaklhaVAx?=
 =?utf-8?B?RU1mSC9KQzk4ck9INlZHWmpWeWsvcVkxU251bDRhRzNlUndKWk5qTURGa3pr?=
 =?utf-8?B?cXhVOWhCd3g5ekh3QWxQVlNjaEhTVXlJem9WS085TzBjOHY5dy8vZm94SUd1?=
 =?utf-8?B?dElHY2NFQzRKdnFZTWRKSE9IUUFIQmRXUVB5RHgrRDUzbkFjRFBTeUdCd0Ru?=
 =?utf-8?B?L3JoQ2dPVW1OTmk1cEJNY0k1OGJvczlZRW4zbUp2aHBQWjFlekZVaFpkdldL?=
 =?utf-8?B?S2c2WUJNVURlT1l3UE9YWmkvanorUTNyKzVHN2ZJYWlURWdIdDRhM2ZFVVFC?=
 =?utf-8?B?U1ZJUCtOZmROcjNKRTRqNkRlT2l2YmFsVENrcmV3SktGK0VoYWF5dExQcTkz?=
 =?utf-8?B?dG42dUM4RlJORzQ3MGpOZStvSmNoR1NMRWE4ZWRQeDhvYkxKUEMvenlDcnYr?=
 =?utf-8?Q?Nl91b/ET0ZRmzEFCu34Yalg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B63A82AF21BC47A359E7DA7FA3A815@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f87922-c899-4152-4a8c-08db1388c344
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 21:23:51.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KXmCY2CM2PGeuYMaFy+ApdPaZIMeRqN2on+jhg8/wk1Ywn7lk955lLPMI9WCX2eyZKGOxa3uNO5n8VXiJIK+J3pY9XEaeUWNa3en6/f2WA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDA4OjUwICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBTYXQsIEZlYiAxOCwgMjAyMyBhdCAwMToxMzo1MlBNIC0wODAwLCBSaWNrIEVkZ2Vjb21i
ZSB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4gPiBUaGlzIHNlcmllcyBpbXBsZW1lbnRzIFNoYWRv
dyBTdGFja3MgZm9yIHVzZXJzcGFjZSB1c2luZyB4ODYncw0KPiA+IENvbnRyb2wtZmxvdyANCj4g
PiBFbmZvcmNlbWVudCBUZWNobm9sb2d5IChDRVQpLiBDRVQgY29uc2lzdHMgb2YgdHdvIHJlbGF0
ZWQgc2VjdXJpdHkNCj4gPiBmZWF0dXJlczogDQo+ID4gc2hhZG93IHN0YWNrcyBhbmQgaW5kaXJl
Y3QgYnJhbmNoIHRyYWNraW5nLiBUaGlzIHNlcmllcyBpbXBsZW1lbnRzDQo+ID4ganVzdCB0aGUg
DQo+ID4gc2hhZG93IHN0YWNrIHBhcnQgb2YgdGhpcyBmZWF0dXJlLCBhbmQganVzdCBmb3IgdXNl
cnNwYWNlLg0KPiANCj4gRm9yIHRoZSBzZXJpZXMNCj4gDQo+IEFja2VkLWJ5OiBNaWtlIFJhcG9w
b3J0IChJQk0pIDxycHB0QGtlcm5lbC5vcmc+DQoNClRoYW5rcyBNaWtlISBTb3JyeSBmb3Jnb3Qg
dG8gYWRkIGl0IHNpbmNlIGxhc3QgdGltZS4NCg==
