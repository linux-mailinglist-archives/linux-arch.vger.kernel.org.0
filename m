Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB5652A8A
	for <lists+linux-arch@lfdr.de>; Wed, 21 Dec 2022 01:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiLUAjF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Dec 2022 19:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiLUAjE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Dec 2022 19:39:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5824B186C0;
        Tue, 20 Dec 2022 16:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671583143; x=1703119143;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ME4naDnDcl4+wY1umxOQ5Dq254uRasb50xVpaWqXqcU=;
  b=lKfxmgKmHIs5HsGMfYA+ICCZteFPWZGyFbi3pJIwIP4j7iaMnnQ6CFTQ
   mWOah16cU7y4NG2n7H2uLpuaJdy/icepzd4C4Zz/4EvWDqXzp6+i8/7tT
   BMuEw3ESfjkWAO0+B23g5rMUDk5OxhdZUvBKV3zSGZV97z1eXOanBnc6x
   VePi2H8ZwCEWsKiWcvoWERnTP3DJX05OtGH18DO/UH5INe7nvnA+z50rN
   W7zucYRdePGVPrQzlZ923LRpPd0incT5zt9f7jMDrqBZT8cpQLmy73fcG
   IRHgQUFDlZ7WmgsRPD1ouJBHIAWLzo4biuu2bjDbkGyRCOapZcqaIZx3X
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="303175007"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="303175007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 16:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="980005909"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="980005909"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 20 Dec 2022 16:39:02 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 16:39:01 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 16:39:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 16:38:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHttx7YdQ85Lep3SNOMoE/qInqQnljsvmtaNkD0As6qZioAeIJo5hXUuuYnpfS7Z6Y8aE9+BLRMnSUd5SoRQ24EUzHjI8cUicPOSJcCZYmQTNYZj1ol2qQoTtKoYqz64AMQ45twVNUO8PHozhdKpxuurTP0/Gc2Qs8/ZHk1vk4/naVzjAEDeWKs4AJu16hIEs40ne/QqKRWgB162rG/jYTal5JivsaiyqsLjoSNhdmAU8iQOuTkKq5OTK2ly8hLGLXCbhQqnlshLU/3GLE6eHj4Jm9vs2G+g8UN7UiQyfdnopHlfiEWiUAyg1fCG5jwhMVvFhRCriuyqaGWJQGcsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME4naDnDcl4+wY1umxOQ5Dq254uRasb50xVpaWqXqcU=;
 b=edg6VM1KjNp8eBNzF0HqhPoYlr55MlvQFso4VjuFNLStXT5j+poERaGaYN4cHE36ixIo7JM+iJ0W9wDEDwmE8AuboU9otTy7IqGQWlxIQ7m7ultI4gYv+fkJHPfxsL0QNukiBQYT8VSuXYr3/nhMqc7WV5bnMK2l27fHXm+N89dlWYXCXnPagrBhcanEBIMlgW/MUjUh/H9Q1KWbrOXOC9yMYV5ahVWmAUOk/+swQFtPVvymSi0TilAQuSjGJADwZzTETM3+YG7Yfi0dtbSRE6V5Fj61NKuz35MwebR9YQxnjUQrM1ermCB9+WCkcBVLBcqWTtcHU33+Kc8ZfdCHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 00:38:51 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7ed5:a749:7b4f:ceff%5]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 00:38:51 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v4 07/39] x86: Add user control-protection fault handler
Thread-Topic: [PATCH v4 07/39] x86: Add user control-protection fault handler
Thread-Index: AQHZBq9UGJ4pSWbilUqMOVDoCgC2J653ZJ+AgAA3MgA=
Date:   Wed, 21 Dec 2022 00:38:51 +0000
Message-ID: <ee9e2ad1829a490f7bc858be29e394dfd984e264.camel@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
         <20221203003606.6838-8-rick.p.edgecombe@intel.com>
         <Y6InTbPwLLO1588Z@zn.tnic>
In-Reply-To: <Y6InTbPwLLO1588Z@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MW4PR11MB6691:EE_
x-ms-office365-filtering-correlation-id: 56e5f20f-3b95-40d4-030a-08dae2ebbb40
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ET72bdYFlvsqxr3uCzLLxSzlxkp9J/gI5L6HZsEBUza1uLu2hDUE+IGhJNhDHAT6VfzRIIKhZ72Fa4r2S/vi6KMVMBfvwqF2UiAL1zTrZEr0XqyVW8eK4i//qwk2FbheStWmHF0Lyvlnxt3J4gcYL4RkkI7YFAVCu8AcVrFvbgMYTNCJQI1Z6XDtQLr13lTAi1HEYGH2+XB8rO8X5oTGclJUTCJ+rezsAbyeiCQ5NrXMGZe6i7N3ObjJusL8N06ummnbwWvgx1nqqRS+aKkPLNu+sOc4bdvFcPudC9G+AtdVh6BV42i4wmCWcdThUFPmy+q+CdTjjhq0Wr7j8pNgd8LPgmJ/XKc8X0jD/jqq945/yXxU/Dp7MEWw0YXt0IYl24Lmld16Bj1iGtSJ5FGndEuEGu52BrV9l+wWMvh55daIl28GL4/VSvvERLO7q6Z0pxEcHNgh7HgsjmUJu2rVEmDtuzoOvYcrfWvokat5OeGB6OhJ2EgAZp24sQgiB8MMQxA2ITEhngFYe+egP4NstsxQMfpguSpxGLLWLcYJJGwwmh7SEprRLFwgYkQXKq5TNJkG65tD2q6K938U37IoJK1u8SP/OyrrzLOw9RdpHboskQpaCu3WnszmFtGSnKXdDoypFqgwfGFsJC3ESE12IkBU1yjOGd39+mBUAe5NBPdb+6vBCwgCNFMEZPSjtAge
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199015)(8936002)(38100700002)(83380400001)(6486002)(71200400001)(36756003)(6506007)(4001150100001)(41300700001)(54906003)(2906002)(478600001)(4744005)(26005)(186003)(122000001)(5660300002)(6916009)(6512007)(316002)(7406005)(8676002)(7416002)(4326008)(2616005)(66446008)(91956017)(64756008)(86362001)(66946007)(76116006)(82960400001)(66556008)(66476007)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHNkVGxyVEVzczArcDJJMU5pOU1BOE1JK3VqWHFtdkxUalVJTDUwYVBCeWcr?=
 =?utf-8?B?VVNheU9MbnZ4UUVrZ3M4VUJBcDVJUVFEY3VMZXFveWhPSnNocThWemtPbnJu?=
 =?utf-8?B?WERpcTdhR2htQ0NMSkNub3FwVmFydDkza2JkWDZxSm1rckU3azNTSDh2SVRl?=
 =?utf-8?B?L29SclJmai9OdW9kWXRZeUZ4TDB1ZnZCTGpQcmZDdHhYNWFKbGxpMW1kdjkw?=
 =?utf-8?B?NndDaG5NTEVzak5oUTZwYzN1aHFPWENDQmpadkYxbkZWNnV0ZkV5MGphaWJU?=
 =?utf-8?B?WVJVa1VkRGR4Q1RvRXRxTVlrOE1YVUdmc1ByS3JkdzRoTDFFU2p0T0RVSk1u?=
 =?utf-8?B?Z3Y0RmlxUmpNdVJEZVhZUFI2R3o1cUpualBES0J3Nm0wb0s0WjVGQTFSUlQx?=
 =?utf-8?B?ekpuNkdqamhmdUxpN2N6WUdQZzY4LzNReHBkbGhtU29sNkI1UkdIVWVtVXM0?=
 =?utf-8?B?dmI1VVBXOGFlSjJjOCtHYWtsQU1UeDNLaDB3U1d0cFBqMkRNUis4ODlZUk5z?=
 =?utf-8?B?cHYwdWtLTUFLT05wS29sb1pVYmJvWnk5YVJKREU5SllkYjRHblQ3N1hBMDdD?=
 =?utf-8?B?UWNSRzU5TXRJV0UveDZrdEd6UUMvNmF5Uk42RWdLb3EyTEMvczdUdnNaNzhl?=
 =?utf-8?B?dHVubGxRclREWkplSU9wdllvL1BLUTZCaGJ6akhBcFd6WmJ5YkRoMXhkSEN1?=
 =?utf-8?B?UzZjVnM4NGUxY2RjUDFnNHFQdUh5WER4TG5EZmtlQStXbHc1cGgrblFKVzl1?=
 =?utf-8?B?R3V6NWtMRlFpUkFvb1dRT0wxQlFvbjc4dC9xdW5qaTNqVEtldWVtZUxjajlT?=
 =?utf-8?B?SUpzMHNXZlVvOXIraEJpMFVKemNYVXNtWjdHbjdNVHBkSzEwM3YzTlgzcE1C?=
 =?utf-8?B?SnorNzZsZFFOMjI5ZDNLU05saWdROG03eStITWdWSlM5U1BsSWFvNUlXQzkx?=
 =?utf-8?B?QXNFVEpFaDdaNmVBYkpHQjVDQnhBREJqUXhJeFlTZXpEN3U2NVQwRit3c2ha?=
 =?utf-8?B?QW9VdktDdGJEdkd3eFlmczNId3d3U1ZNMVBKMnQ5TkJVUWRTWVhkOGpra1RY?=
 =?utf-8?B?WWJMTldwSEVyTm9BcjNlT2lWMzJkTW84MCtBS0RUU05kQmFjSWIwR2tCdGxC?=
 =?utf-8?B?MnhuRG1HYUxTZGQ2TTJRenh6UzhVTkRoREtDL201c2FZLzNhMEc4MytoUjNo?=
 =?utf-8?B?UGhZekI0cW8vTEZHNFpmY0JiWWVaaWNBRzBZR0NrZXB2YmkrbW1uT1QrajBK?=
 =?utf-8?B?bk9yNUlOVmk0T3dCbGNlamRtdFFvNWtRd2MwcDBaMldEaUp0MFN2YWVSc0JT?=
 =?utf-8?B?WVVXR3J5ZzJNUUJaTVZLYXdTOTdlVXdWTTQ0eDRDNW1mV0xWUUlpMHQ4ei96?=
 =?utf-8?B?Tzkyc1YzbjBBVm1reitobXFSRjF3amRHKzJOcmhUaXh6Y1RHck8vMTA3dXhE?=
 =?utf-8?B?MTJ0cmszbHJ0by9hWmVVWlBXNzBUR3lwRmZYTUlrYlZJM2Q1MTRsV01DVDR2?=
 =?utf-8?B?T3FzOEwzU0ZrVVluKzEvYzV4OC9XMldFdk5xUlNuQVozRVhhbDhGRUFOcTZC?=
 =?utf-8?B?VDQzeGhvM3k2b1ZyblF0dWFWQlB1c2JPN0J2UkVOcnFVWjZYMFA1RVZMaEg2?=
 =?utf-8?B?QldqUk5qWHlhcVNST2d6RUkyMHJIQ2RvbjkwL3lwWjFsZWhENlF4WXdFRGVu?=
 =?utf-8?B?WEplMkh1dE4yNzZBV2U4M0FKQTlhb2RXeG4xUVh0TGhVamo5RWx5SzZJS043?=
 =?utf-8?B?alpNYVBJZXAzaC9pVS91R1JBR3RLWTJDWVVveFNYWURlVTdyWERZV0x6emM0?=
 =?utf-8?B?K0drMUVaeVUxak4vczZQQXVhMkJ3dTNEM0xCck9vSFBEUUxJUXNveG9DNVVr?=
 =?utf-8?B?WldEQkpFc3ZlU3hNOFhRK3dqZFdmRGl4V0wwVmI2ZGp4ajJhN1Z2eFdNOVlQ?=
 =?utf-8?B?Tk9ZVW1vbVpWMVJyVUZGR3E2Z3JJNk10clV3WWJOb21JZCtEK2ptS2lmU01n?=
 =?utf-8?B?aysyTUt0SDN3OUI0K1BuT2xvRzUzUUZHb1Zsc2J4bjdQa3BEbXkvQWtwQmow?=
 =?utf-8?B?anIweXkrRVVpM0RCN0luK3A0QjhoeXhYb3RRc0RDQlBnZDJ5Z3pZSmxNTG45?=
 =?utf-8?B?RjNLZmJnYVBtZWZ4KzZFb0lINTN0cWNnUXBwUWlpN3d1Y2o1UkV4d3RtcU9X?=
 =?utf-8?Q?KubHujYS6M8OAZ0bAUMVWtk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B79FF2C76DEBE4296489BD388F691CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e5f20f-3b95-40d4-030a-08dae2ebbb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 00:38:51.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwtmU3ZwZ8UeQGNpQX+7anP5eRI/U1SNxbfZK6I2v/d20egaLmK7THL6WoCERzocco25+PuGPgUjoDR0ByNibncrR/UeKjbLqBdQb8D/kfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTIwIGF0IDIyOjIxICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIEZyaSwgRGVjIDAyLCAyMDIyIGF0IDA0OjM1OjM0UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IEtlZXAgdGhlIHNhbWUgYmVoYXZpb3IgZm9yIHRoZSBrZXJuZWwgc2lk
ZSBvZiB0aGUgZmF1bHQgaGFuZGxlciwNCj4gPiBleGNlcHQgZm9yDQo+ID4gY29udmVydGluZyBh
IEJVRyB0byBhIFdBUk4gaW4gdGhlIGNhc2Ugb2YgYSAjQ1AgaGFwcGVuaW5nIHdoZW4NCj4gPiAh
Y3B1X2ZlYXR1cmVfZW5hYmxlZCgpLg0KPiBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eDQo+IA0K
PiBZZWFoLCBsZXQncyBzdGljayB0byBwbGFpbiBlbmdsaXNoIGluIHRoZSBjb21taXQgbWVzc2Fn
ZSBwbHMsIGluc3RlYWQNCj4gb2YNCj4gcHNldWRvIGNvZGUuDQoNClN1cmUsIEknbGwgY2hhbmdl
IGl0LiBUaGFua3MuDQo=
