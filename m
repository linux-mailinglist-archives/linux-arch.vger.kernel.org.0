Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D996A877A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 18:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCBRCN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 12:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCBRCM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 12:02:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F323E61A;
        Thu,  2 Mar 2023 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677776531; x=1709312531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Iq3qSJHH1meqC6rHEWOcv6WPDVBWedStWeWSRmrMYU4=;
  b=fmmlebJU2QAbLaF3kohr3smnE2oxtW0YzMJwNaAbTT49sMKxzRXdLEjT
   7i0UkOttPxjcPOyi/pquBCX1zWrAjMHwSs63fQ4dFlpHZ1WxoFYt0w2tZ
   11hEndhQyzzveNnt04Z9sjnJfMi27vOIieHlgUwFRbMQLB+UljSW9d/On
   8FbYtcF0xw+f7XJoWYW63hmEeW/vcRHPPFs4hvEdmJypff9WiWtvnNKV6
   RDLdHFiaB6r1bHDO9rbyEldDrQ8+qxMmHBIIoHayFpU+0S/CIfuST/s7k
   TAaKqBXMXrquEgbqMTb30NvlqlSYJ169JOfVEQWHfYdG6lBP3DLuv34Gx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397370970"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="397370970"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 09:01:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="798899767"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="798899767"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2023 09:01:32 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 09:01:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 09:01:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 09:01:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 2 Mar 2023 09:01:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbquhXM44hwm/EdFgQ0AGcMfo2UuONARkJVFospn1kx0Hwf4Oma+Ra1Zd+0pWktTM4+b+iWhqA4OybinkEUuHn2JB9Ex+bJvQd0H84/NVoUMa85ZNC7hztiO/WI4IOYgQJoyl1TvBHFoETLAWkaige3fWATjhitGKeMOQlatgwWJ4U0l1cbhgvnqA6VAqFMqTr0QBtMakFkMpkFVkEG/LVq6tnxhnDGzG95aQAZ4M8PnTCe9/G6dqc7H5Skwg9PGek5EPs3Nh/xATIG2kYLUWrmza4BontxL7cqLtpiAAqFmsaE0cQside2EPKvvZwmSCCppdlmw9GU8Uf0X58GULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq3qSJHH1meqC6rHEWOcv6WPDVBWedStWeWSRmrMYU4=;
 b=Iwl805K6M/q3+w+wDvWhKQ0S6T5PfT4ItC6sXIubcpvFHf5coaMWYUbBqOd620fDyEzAS2uWzqFgN9+ShrxC8uXgcNM9GXG2acZtshTmphoPYJwwUrPDNxea3Jv9LZ+40yoTp4dmHC4U6DQraIFr/LrblDCyG5uUaYM3eSELvF0YD+Rob6mLV+LHG4MglTKGRmvOgGXosdEvM1NRkRb6Ci7jP0zkTajdxs5OHiv4fIK3hrlgNa/NF1AR1Gf2HKsYALgZ5m2L/3odqzmaJY9A3C7ASVGr5S47WMqHoogCM1E9EvoySwJj52ZS9y7tFNcnHF+3fr+/ED4hA+PCrzZAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 17:01:28 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 17:01:26 +0000
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
Subject: Re: [PATCH v7 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Topic: [PATCH v7 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
Thread-Index: AQHZSvtAiYkbfjLm+EeslAE2EtxDq67ndJOAgABGswA=
Date:   Thu, 2 Mar 2023 17:01:25 +0000
Message-ID: <6e8b659e180d5f5848844e3d3506d216718e8ee9.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-15-rick.p.edgecombe@intel.com>
         <ZACbFc55bcVYRXpG@zn.tnic>
In-Reply-To: <ZACbFc55bcVYRXpG@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB6468:EE_
x-ms-office365-filtering-correlation-id: 4e72cfcd-a8ed-4522-3545-08db1b3fc257
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+nki5DLI74XilpH+VzetXFx+rZ/GhWTCNIQEmLulXjUJmQNZ2SEEa3yfSaL258qwHt8Au4kRhabd0Y1qwN0C4OROj2fOBwJmFyDvnwimAX+N+vDR0A9jvIj85CzrFObX94PzARqALhS38E+zphvfq/guYVa2FMMsEAZU0ma/pAe6F9vZpQTyRd4/+edRPhxf2mk+VZPiQ95Uih2QSO6hdPNkWAjICB5zbJnNoVXMinne5d/pM0fva8tNFZL9Y+O5LurG8Uik9Nz9MYmwz8gvXbVRrnZOcNQEtoLF557t5/3MflsA3errZ2vE9Xv12BlkMqp5gMJs2Dgq+TQAudg/sUrOVbZZQKXKuhcbWEet0RE1rvUY9MbtqJNWk3RpnpDbJRtAiizNXR9yHc5O0yGKpemxiG8MpPwwxK7/Lst5+2Q3eBF27tRrAi+2kYoHp48kMxRsdtwV4kd4pnKhbwXB8m3Sjwq6iQ/IeHAB9GHWwRkR9FNEC3oyPSznq3KobPQq99F1ReoJ1+KwDZ3szoQOueQcSA1H5Erija3GNYs4PXXBihR6Cz3En8iPlSit9W4vzc5fWxPBTiy1U4g50qI37ypL8xObvY47eZ9DuSInNDgENEZkXkodPOBN2ki1nGgQSB2X6ex5qKoOvI5dM+pwp0LaHcN5YYQ+10FgL8yZ1xkIMevXauU83akE4FqYHlcvy7gM+/zlYkIRRMFjIgl821h/jWB6uwcJY/kBigQPvkiohic5+yFUuPgEjWAc0RB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199018)(36756003)(6486002)(6506007)(26005)(2616005)(186003)(8676002)(54906003)(91956017)(4326008)(41300700001)(66476007)(6512007)(66446008)(6916009)(76116006)(316002)(2906002)(64756008)(66556008)(66946007)(71200400001)(7406005)(478600001)(7416002)(82960400001)(5660300002)(38100700002)(8936002)(86362001)(38070700005)(83380400001)(122000001)(99106002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEh2cGVQTUs1aVI5clc2ZVIrQVAwRk9NMVNBOUs3SmU0QS9LeWRhVFZwK3ZW?=
 =?utf-8?B?MDdpYVd3MjA5bmtWWnRuZVF3TFh4OTRmemVaRXdBZjN4eWJGVS9BVGduSkhW?=
 =?utf-8?B?c1BoSSs4MDFzemUyT25WUmg5VFpueUJwVmpKMFlHanNodmFrcmxLME85RU5R?=
 =?utf-8?B?K1RjNGY4K1ZRT3lPdURqejIrZmJla0p3bkhuS3hUanlJanpvMWZkOXhZVHV3?=
 =?utf-8?B?S1BQVmdvK3BSSDFGVTlqNkc3WFlPYmNVSERXMWpXa3Vyb280MTRrODUzRk0r?=
 =?utf-8?B?Um1taHA5ZllwcWk0M01IUXlURW9zd1B0SWRlbE1XM3pYSjZkV216RHJ6Mi9D?=
 =?utf-8?B?SllsdDZCRXEzeG1qM3kwaldISzZiN3N4L1NlSHBoRWNvdnV5REVrNEVESllI?=
 =?utf-8?B?eXIrcTI4UVJKWllvZzE1eEdkdGt5L25WZ0RTSmdISlk2TDY0ZkkzeTVtUVVs?=
 =?utf-8?B?UE5TRFJOa1FWcFl5QjlYemo4YkdBakR3ZDdSV2Zub2w2S1BrL0VSbkJwS2ha?=
 =?utf-8?B?dGh5U3hhQUdSMEZYR0hWN0NuOVdObU5BQ05PTGxpMVVmS0xhQTNwcklaSWc5?=
 =?utf-8?B?NVBBdHRUV0VQdXE1Z3ZLM0pFYTdUSXdGMkR3YTgvaGFLaTl6OWZ1SWlyaWFH?=
 =?utf-8?B?eGd1Z1hLRlc5dWVUSjJqeUt2WUpDMkZJbTQzQzhyV2YyNVkzS0g5YnFER0Jz?=
 =?utf-8?B?bTBVbWlVZlNnOU1uRlBpYUFBd0JQQVdKZU81Y1pkdFFmaFNpNXF5Y0h6NGhz?=
 =?utf-8?B?cTJwbFZnT21DNHY5b2FEVDlVbGxaSHNncjdFK2hSMTkzS0IrbnpZU25kTXBz?=
 =?utf-8?B?aXBzNmh5ODV2UkhueG80THJ5Qm9SeU1qMCtGZlRML3ZVOUVaR0FFNlppWlZI?=
 =?utf-8?B?Q3dkbm9waXZCaUVqV2pLTEJHV25zS2U4N0FZWXBWNFM2MkdndFNoNjM1aExE?=
 =?utf-8?B?S1IvQXZJcDBnMTd3aHdwYU9semRGNnRSTVZlRU5mQzNWYi82RHQ5aFBjTUNL?=
 =?utf-8?B?bURUUUxheGxMeVQ4WWRNeHdCU0lVaFhQTUw2eXo4Vi9ydU42R3N4Q2Q1d1hK?=
 =?utf-8?B?NUlsQjRmQzVDaHBaQ2plTjFiUmhDeXBycjE1SHdyUmhiT0NDaENQRnhWVzZF?=
 =?utf-8?B?amc5TzBQYWU1SG5uYStZNytyL0FDa1A3NXduSThiUGFhRS9Kb0FZMG1DbkM4?=
 =?utf-8?B?N0MrVGVHa2kyZGFhOUxTRUF1eUFJMGQxb2NUbE0rUGRRR2pIcGY5ZC81UFBt?=
 =?utf-8?B?ZFJ5b1V5eFdIV0NFU0ZScVNqb1h4OEFuOVNtSitSR3ZmcXg3VDBhdVJnQlkw?=
 =?utf-8?B?QXRWTGtxUnhMWnRVUTVzSjJ6TVZDZkxZaVkrYWtBd2t2TVRvd0ZWQWtCTmZu?=
 =?utf-8?B?LzV4NXhneXVWZEMxOFNaMTBRZ0gxYms1OXAwOWx2dUF2SGo1WkY3dHBJa3ZU?=
 =?utf-8?B?N2Yyc1k4eTlOZ0g2NFhOcmJoTmcvMmhZaXA5MUtzN2FBUEIvNm9vM2hXa1BE?=
 =?utf-8?B?T0k3cWJIMjFLemh4WEVYTXhCM1Ftcng1M3NNVmVESVZLQ3ZhUDFyQ1JaMmdh?=
 =?utf-8?B?ZTFuMVZOM2ErT0ZqMXRZSGdTR1VJZE1kazNIK28raE1uNEtEQnVVbFk3THRx?=
 =?utf-8?B?cVpaU2V3TXpNV281M04zd01kYndxQnFMZXN0eHFyNHVia3N2MkYySUJHUENK?=
 =?utf-8?B?SEd6TWRwSDUzOGhLLzhWQ2VrRWM4c0FvUCt2R1V6SXNvTDMrckpoNy9OdzM2?=
 =?utf-8?B?NkVlTmhpNnN5cUNMQWg1Y0NrVUx0NjR3UjloV2RYa3ZXVmRsODVhUDM5eVlK?=
 =?utf-8?B?WmZrMW5rcmZYWXVNNXBzUzNjc1AzdGlMZm1yeEw2NnR0WlpBU3d5QzI2ZVVB?=
 =?utf-8?B?NFBSSWIzS2E4NXhVU0ZsT1J4QU9iUTVDbXltZWRBQkVrVzRGek1HUGpjK3U4?=
 =?utf-8?B?UHYrbFF1UHQ4N1A5bDllRG9McUxhbytlS3NQWFFNMVRaWS9qU0JMWkpyVWJS?=
 =?utf-8?B?VDA5QTVzQ1J2R1FxNWNGSWFQa2NzTXFKS2N3eXF0MHM5ZlZPaFQvRVd4YjE4?=
 =?utf-8?B?ODZsaCtrTVZYRDJydDlxQzArYXNXSkNkT2pueWdUZXJianBBZ2g3YzhXaVQx?=
 =?utf-8?B?VkFJQnpVUldYOGM3UFU0UEVVWHhmc1NvSzcwNmo4NHVheTdlcERCUVpZd05q?=
 =?utf-8?Q?Snr6zfmzrEPVBOH3Ta6VL30=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E5040D63A1B4548A22722A2E89676BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e72cfcd-a8ed-4522-3545-08db1b3fc257
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 17:01:26.0285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZMSD2aAnT5p+vAKAB+uN82OrR/iH7Kr3JK/7l4bCybj9XnhT9Gu8PbjL2cVXN5EvFAB1Hek6Uf/BYxUDzUOUe8sR+0POw9oc+MG7b16+tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTAyIGF0IDEzOjQ4ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDAyOjI5OjMwUE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxl
X3R5cGVzLmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfdHlwZXMuaA0KPiA+
IGluZGV4IDA2NDZhZDAwMTc4Yi4uNTZiMzc0ZDFiZmZiIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL3BndGFibGVfdHlwZXMuaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL3BndGFibGVfdHlwZXMuaA0KPiA+IEBAIC0yMSw3ICsyMSw4IEBADQo+ID4gICAjZGVm
aW5lIF9QQUdFX0JJVF9TT0ZUVzIgICAgIDEwICAgICAgLyogIiAqLw0KPiA+ICAgI2RlZmluZSBf
UEFHRV9CSVRfU09GVFczICAgICAxMSAgICAgIC8qICIgKi8NCj4gPiAgICNkZWZpbmUgX1BBR0Vf
QklUX1BBVF9MQVJHRSAgMTIgICAgICAvKiBPbiAyTUIgb3IgMUdCIHBhZ2VzICovDQo+ID4gLSNk
ZWZpbmUgX1BBR0VfQklUX1NPRlRXNCAgICAgNTggICAgICAvKiBhdmFpbGFibGUgZm9yIHByb2dy
YW1tZXINCj4gPiAqLw0KPiA+ICsjZGVmaW5lIF9QQUdFX0JJVF9TT0ZUVzQgICAgIDU3ICAgICAg
LyogYXZhaWxhYmxlIGZvciBwcm9ncmFtbWVyDQo+ID4gKi8NCj4gPiArI2RlZmluZSBfUEFHRV9C
SVRfU09GVFc1ICAgICA1OCAgICAgIC8qIGF2YWlsYWJsZSBmb3IgcHJvZ3JhbW1lcg0KPiA+ICov
DQo+ID4gICAjZGVmaW5lIF9QQUdFX0JJVF9QS0VZX0JJVDAgIDU5ICAgICAgLyogUHJvdGVjdGlv
biBLZXlzLCBiaXQgMS80DQo+ID4gKi8NCj4gPiAgICNkZWZpbmUgX1BBR0VfQklUX1BLRVlfQklU
MSAgNjAgICAgICAvKiBQcm90ZWN0aW9uIEtleXMsIGJpdCAyLzQNCj4gPiAqLw0KPiA+ICAgI2Rl
ZmluZSBfUEFHRV9CSVRfUEtFWV9CSVQyICA2MSAgICAgIC8qIFByb3RlY3Rpb24gS2V5cywgYml0
IDMvNA0KPiA+ICovDQo+ID4gQEAgLTM0LDYgKzM1LDE1IEBADQo+ID4gICAjZGVmaW5lIF9QQUdF
X0JJVF9TT0ZUX0RJUlRZIF9QQUdFX0JJVF9TT0ZUVzMgLyogc29mdHdhcmUgZGlydHkNCj4gPiB0
cmFja2luZyAqLw0KPiA+ICAgI2RlZmluZSBfUEFHRV9CSVRfREVWTUFQICAgICBfUEFHRV9CSVRf
U09GVFc0DQo+ID4gICANCj4gPiArLyoNCj4gPiArICogSW5kaWNhdGVzIGEgU2F2ZWQgRGlydHkg
Yml0IHBhZ2UuDQo+ID4gKyAqLw0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9VU0VSX1NIQURPV19T
VEFDSw0KPiA+ICsjZGVmaW5lIF9QQUdFX0JJVF9TQVZFRF9ESVJUWSAgICAgICAgICAgICAgICBf
UEFHRV9CSVRfU09GVFc1IC8qDQo+ID4gU2F2ZWQgRGlydHkgYml0ICovDQo+ID4gKyNlbHNlDQo+
ID4gKyNkZWZpbmUgX1BBR0VfQklUX1NBVkVEX0RJUlRZICAgICAgICAgICAgICAgIDANCj4gPiAr
I2VuZGlmDQo+ID4gKw0KPiA+ICAgLyogSWYgX1BBR0VfQklUX1BSRVNFTlQgaXMgY2xlYXIsIHdl
IHVzZSB0aGVzZTogKi8NCj4gPiAgIC8qIC0gaWYgdGhlIHVzZXIgbWFwcGVkIGl0IHdpdGggUFJP
VF9OT05FOyBwdGVfcHJlc2VudCBnaXZlcyB0cnVlDQo+ID4gKi8NCj4gPiAgICNkZWZpbmUgX1BB
R0VfQklUX1BST1ROT05FICAgX1BBR0VfQklUX0dMT0JBTA0KPiA+IEBAIC0xMTcsNiArMTI3LDI1
IEBADQo+ID4gICAjZGVmaW5lIF9QQUdFX1NPRlRXNCAoX0FUKHB0ZXZhbF90LCAwKSkNCj4gPiAg
ICNlbmRpZg0KPiA+ICAgDQo+ID4gKy8qDQo+ID4gKyAqIFRoZSBoYXJkd2FyZSByZXF1aXJlcyBz
aGFkb3cgc3RhY2sgdG8gYmUgV3JpdGU9MCxEaXJ0eT0xLg0KPiA+IEhvd2V2ZXIsDQo+ID4gKyAq
IHRoZXJlIGFyZSB2YWxpZCBjYXNlcyB3aGVyZSB0aGUga2VybmVsIG1pZ2h0IGNyZWF0ZSByZWFk
LW9ubHkNCj4gPiBQVEVzIHRoYXQNCj4gPiArICogYXJlIGRpcnR5IChlLmcuLCBmb3JrKCksIG1w
cm90ZWN0KCksIHVmZmQtd3AoKSwgc29mdC1kaXJ0eSANCj4gPiB0cmFja2luZykuIEluDQo+ID4g
KyAqIHRoaXMgY2FzZSwgdGhlIF9QQUdFX1NBVkVEX0RJUlRZIGJpdCBpcyB1c2VkIGluc3RlYWQg
b2YgdGhlIEhXLQ0KPiA+IGRpcnR5IGJpdCwNCj4gPiArICogdG8gYXZvaWQgY3JlYXRpbmcgYSB3
cm9uZyAic2hhZG93IHN0YWNrIiBQVEVzLiBTdWNoIFBURXMgaGF2ZQ0KPiA+ICsgKiAoV3JpdGU9
MCxTYXZlZERpcnR5PTEsRGlydHk9MCkgc2V0Lg0KPiA+ICsgKg0KPiA+ICsgKiBOb3RlIHRoYXQg
b24gcHJvY2Vzc29ycyB3aXRob3V0IHNoYWRvdyBzdGFjayBzdXBwb3J0LCB0aGUgDQo+IA0KPiAu
Z2l0L3JlYmFzZS1hcHBseS9wYXRjaDoxNTQ6IHRyYWlsaW5nIHdoaXRlc3BhY2UuDQo+ICAqIE5v
dGUgdGhhdCBvbiBwcm9jZXNzb3JzIHdpdGhvdXQgc2hhZG93IHN0YWNrIHN1cHBvcnQsIHRoZSAN
Cj4gd2FybmluZzogMSBsaW5lIGFkZHMgd2hpdGVzcGFjZSBlcnJvcnMuDQo+IA0KPiBIbSwgYXBw
YXJlbnRseSBnaXQgY2hlY2tzIGZvciB0aGF0IHRvbyAtIG5vdCBvbmx5IHRyYWlsaW5nIGVtcHR5
DQo+IGxpbmVzLg0KDQpXZWlyZC4gQW5kIG9vcHMgb24gdGhlIHNwYWNlLiBKdXN0IHdvbmRlcmlu
ZyBob3cgY2hlY2twYXRjaCBtaXNzZWQNCnRoaXMuIEl0IGRpZG4ndCwganVzdCB3YXMgaW4gYSBw
aWxlIG9mIGZhbHNlIHBvc2l0aXZlcyBvbiB0aGF0IHBhdGNoDQphbmQgSSBkaWRuJ3Qgbm90aWNl
IGl0IGluIHRoZXJlLg0K
