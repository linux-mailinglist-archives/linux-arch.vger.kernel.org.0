Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A14B3279
	for <lists+linux-arch@lfdr.de>; Sat, 12 Feb 2022 02:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiBLBoe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 20:44:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiBLBod (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 20:44:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78A1266;
        Fri, 11 Feb 2022 17:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644630268; x=1676166268;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=NSVje8707UpS2MRxfG0sPUNgzjjU3YaT70Dby4yXEDM=;
  b=Jt5nIf6kHObI6K9ayHfyWq7EHQRTT8rZkfl9k+xZ8iniG+eNw1Ag6YML
   z4xosMwgQeIoBlYMZPmSINqKCz0jzcHijDm5aPmp+8tld+UKaQ4uJrbRR
   TcBKEWfp6Z4mKCSBSLW81CR4d/Qk4SO0wYcsbcR5zN66Hj9+mdSDaKfKo
   vxFwAMy29kHUj1d1Q+aUNBu0On0pNopzvA2TPf9wRRG++XbZIdnon4bbP
   NctvswvPqo9AOXxnFAkeT/7cy+1vz+3+vv2lClmRc7ZdJomUpiSURrGGt
   T1zwZJAnqRYHyxwdgxlZOegK8Hg9SjHP+sqUfcggKiV63jjMHmDaqFjz6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="313123676"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="313123676"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:44:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="527165264"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2022 17:44:28 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 17:44:27 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 17:44:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 11 Feb 2022 17:44:27 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 11 Feb 2022 17:44:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fItMc96aFlWguViSgTJeqdfKk7PmT7JqPFRWctPjwP3dotAFip18dk4MHIoG1PpcWLU8w5LI1z5lYfPT6rZ7l6c3aKMsgBipNpc0v8r3g5i4fPkw8WQzjKFW6t7i/KDTzJEUs4JTivTPaVYwDpu2NtQMe7thEG2TYTAaAqIWAibWL6kTXZjq6LZrv++2/hpJKTIeJ3RZxHxAGr8DmbnteZcdn35dJeNeaTl+BaXm11pioIbGsjVBHRxr89EsYahsoiWc/vP+PV8QLXOAI1/F11+cXP+4Ih856GMsNn4KSa/5WdY3ad4grhSlQDV1RIfLHn5j7s0RlDV/4FuuTqALdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSVje8707UpS2MRxfG0sPUNgzjjU3YaT70Dby4yXEDM=;
 b=Zf3x6W1ukPFx1jQGMIh067voOB4ea5tVPCFHBpsRPHSMGbbr856++msroupiM1pf9C5LGUwNfJxHTBVbbW0XIcfnmNVBR4j032eyUKYjPfp/biM9b32VEB574py9jNHRh9O4IUNMrMDhushz0I9Ng/9Q4JvEOVDekmWdh+tqYtM49erJPtDVzf5Ac4RB7o03idYmBe/p+zrvGt1QnLxEKFi/cMLL066fbC8zuxv9KuZMpJCGEgk3YFc2hJpW3zBU1uF8r9FxjrXXUZ/xRycdnOJavG+e243Kx7PWb6KqQZKLmoqOtdTFYV4vWRM5dn4Z5iymUL/u4cH+hYsgY8gRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN6PR11MB1874.namprd11.prod.outlook.com (2603:10b6:404:107::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Sat, 12 Feb
 2022 01:44:20 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Sat, 12 Feb 2022
 01:44:19 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
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
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 22/35] x86/mm: Prevent VM_WRITE shadow stacks
Thread-Topic: [PATCH 22/35] x86/mm: Prevent VM_WRITE shadow stacks
Thread-Index: AQHYFh90hf7NWSs4cU+zbxiSHQOXZKyO/riAgAA5IQA=
Date:   Sat, 12 Feb 2022 01:44:19 +0000
Message-ID: <277fdb2e28576fe64e6a66a39c48d2cdddb76c98.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-23-rick.p.edgecombe@intel.com>
         <3df8595d-46d9-aaee-dd33-3118102ef750@intel.com>
In-Reply-To: <3df8595d-46d9-aaee-dd33-3118102ef750@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f11ca32b-0b8d-48ec-08d7-08d9edc92f99
x-ms-traffictypediagnostic: BN6PR11MB1874:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB1874AFDE854EA77C2E3FF391C9319@BN6PR11MB1874.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IWqhHO3VOWEWSQKIECpbDGSU1OVCLeb2lf2pkFX2VCUoCenRFXW7q/NVAarLM8wxAP9mE1MDXbMztTs00PuF2MrxW3pg4nORJPWxwjcvAB0cvd83gp2gW9tD4J8aP2sQYaniLOnEmS8pT5R7k0yEdJmhJ4/m0VeGZ7wMjjzOEAKVEo160XIpBBqjOAltCQKN2N3qv7LYoGqKe8ZILxExj+aycH3w86jIEn4oXYqJlyXiUn7agf1Qx1CcgliJlOqv+gSOBpuXXfwPrbNEDTqJqGFa0xlKpTTcPhAwDLV75IxwFlh0aFSog6ohkR6FgFnaLh/v0ShrnM2aju5SHXoYURidAHcEoTcrWTWcFu7UstuXL8uee+hoVfgtcZOs5Z9zc5ORYdcq6mi+r3x94CbXO3ztCD18JCQijwXlO4k6GBEi9n0NcUry5D/EjXsYdwqkJal1PaPoHRy+az520LwLe9t7izG46wuNavIu926ummSKXaG6Fi1ZWHHn6bO+acvEAoosAVcmPtfhUvkSygVG+xz0qN/P757+GCBmU/v6iyU0fYGHL5W1cBJzG6Cca+dFeeiPy7uLw7ZdZLlnywQUIGCN1/zSfp0eYaVJIdJDOeX7glJP9V+aZj59HGVAeBTaCT84T/gwXkJFgZ4v9gYTw9eP/yVkgnjfaBj0epPi4IdBaF+MuH3+LiG9f29GmaqPG2dOgVo6h3rrliJQHwcrJdDUkKqR3zH0ql+gsFWIpRyChCeT7eJz9PcfYNrwYrJM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38070700005)(66476007)(64756008)(8676002)(66446008)(66556008)(6486002)(508600001)(76116006)(66946007)(82960400001)(36756003)(7406005)(6512007)(83380400001)(5660300002)(7416002)(86362001)(2906002)(2616005)(26005)(186003)(71200400001)(110136005)(122000001)(6506007)(38100700002)(53546011)(316002)(921005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjhaMlh1WGQ0OWh6OTNQaEwwZkZrSTUyMGJoeE5ZOVJaQXB5eWRPckJzR3Rz?=
 =?utf-8?B?Wit5TXJXaldLRjdLWmhVZUZNalZzUTlnWXQxY3NwTnFhN3ZqM1g1K1VVands?=
 =?utf-8?B?dnJES1lYYytXN1lYRmJkelkvN0pYcFp4WkFMNnJ1Q2MxU0JEUGNXKzc3RDUy?=
 =?utf-8?B?VnNoWFNUemlqN21ISFVWK1Nua29KTUJrcU1WaHhPT3ByK1JBU3RzVEJKMThW?=
 =?utf-8?B?VGRMcUJDSE9KUlMwTm5jd1RzWDMzTGkyZFlDQVZ5VmJlMVFvcFlORDNoVTk4?=
 =?utf-8?B?aHE4cG5SQzVyZUIwOVBLZFNKUytoQkMwZFhXWjV4TU0ybHNIVFJFRTR0N1NW?=
 =?utf-8?B?WTIvZHZuKzJkRy9ZRUhENFNteER0TndNZXBpK1dlL1dPSEJQbjZoUExNYU5L?=
 =?utf-8?B?aEx1K09uSnhzcEdkZWJsZXZqeGhBRUV5K1ljTFBBcjYzRHZxME5QTG1VbHNQ?=
 =?utf-8?B?VWxvYUloQ2RsRkhqQmtSbTRhMkd3NU0vZFdVZStoc2hmUzk2WE1MOVBvKzl0?=
 =?utf-8?B?UXo1VXZJbGl0bHpFbnpCWTIzQXA4c1lPbkdram1Xd0dTU1h6WG1qMFdKUTM1?=
 =?utf-8?B?aHIvQnByUmYwb1VMV1RlTmZuZitGb2FDZ21nNEl1U1BPQlZ1aFEvNnk5UDh5?=
 =?utf-8?B?VlE3ekFNUDhFUTcxdzd6dlhTMjNIaFBwM0JleDAzN2toZHJrejVtTjBOckZC?=
 =?utf-8?B?QnNWNnQwM1ZTNm0wU1RiNTA4VC9UbU5RL0R2WXV5L1RNbVBHRVVicFE2Q0V2?=
 =?utf-8?B?ZnBQRS9ubHJwaXVvV3ovL01tMWFhSnE0bHpZRk5wSTNCQWxGd3VVZWtSU0cx?=
 =?utf-8?B?RTBYS3Q4WWtlOGNKUjU0eFlxaW51ZHA3YnBmVWZoZjRtdnhaeXNZSXl1VHlT?=
 =?utf-8?B?b01DdWg1SFdmQW82L2tNU0JtbWIyNUZMcG5wUDRsQVBDUUVhMmU4VnFhMXpF?=
 =?utf-8?B?SEcxTlg2ZkV6bXlaeXU3anU4ZEZWRlFUem5IUEFBUGZFeU53K0JXTm1vQ2Ux?=
 =?utf-8?B?OHJmYnJMVE5lblZNY1NtRTBjOUxBVlZzeDFTcDdXWlRYbkhRNFZBOWRVTVhT?=
 =?utf-8?B?U2xHb05rUTNLQk02MHZ2MlplcFNPY0VWTXpqdXYzUlJTbXdTSjh2OW0zMVpp?=
 =?utf-8?B?OVM0b2dMRmlXZnk5VU95T0NYVkI1UE0wZzQ2Tm45RjA0aGFYK29zZ1BKM0F1?=
 =?utf-8?B?UzAzWEliWVM3bkVaSnFwaCtMUkVzNE1jYS9HVDJLbENDZ1lqN0FodzFiU1dx?=
 =?utf-8?B?Qnl6Q1BXVXpNZ0NPcFRhMlVDeDBlbHFEemhpMm5Rbzg3aHk1SFpDTDVwdy9v?=
 =?utf-8?B?WTgwZ3ZCTktYdWVjNjZZcUF3cCswQ1NCam9jaEUyay9CZ0ZXVjlkOXJUNDQy?=
 =?utf-8?B?WGViWGtpejBWbVltMjJzUGY1QlRwVDVrb2dvVTB1UDNlWnJhS1Qwb29Ca3Zm?=
 =?utf-8?B?RnVEaE42UDhvMzBreTNtS1gyN0hiaWV1OGlJMVBIWngydWc5TUlnTDlIcEJN?=
 =?utf-8?B?Zzh3alpUaVM1YnFSTERPRklXRjRqZXZOVHc1YmZ3WGRnRVVOemJPdzlxRWJM?=
 =?utf-8?B?TUxoV3drV2xON3U1eWsyKyswWXpUSGdqQUxRV0w5T28rR1hqam0xT21HVjl0?=
 =?utf-8?B?bFdPelpVVXk3eDM4NWtFUktyY1NxVGFvVWlzc3laMW0ydGpKWGFoWHExZmhY?=
 =?utf-8?B?M1JpQlBKeEgrc1diM1R4aGpmNVJ1ZE5LWkFielc0Vnh0Y1JUMm9nKzFVUFZK?=
 =?utf-8?B?UTM2WDVzQ0RFaEJqOG90Uk9OcEtvbG5OSHhjcmNNcEdHbjZnVHBjSnZWVWpM?=
 =?utf-8?B?TWNHWmhFc2ZFMm1XaDRQTW1sNDZXK0JRL0NPRXBOSnE1bGRUM1E4WW9SRTdN?=
 =?utf-8?B?U2Q3eHZDWVB2bmFuQXJUTktFWEZXMDBBOGNqcEUvMTZhV1doWHNQZFBWR2Fo?=
 =?utf-8?B?RmFHSnJtVkcvcEFXMG1RWGlMRno1b29TMzZXb3dzQjRXdlREYmZzWit6MEov?=
 =?utf-8?B?NWUrajZBMnhLQk0wcXlUTlIyNXVVcjRZRVJiUTNvalZCR0d0dTdxY1l6d2VG?=
 =?utf-8?B?RlJKbFJhK0NrWmEyaDlVR3RTcUZNNlZLVWV0MWxCdjZmTHVnRkFFL2QwODMw?=
 =?utf-8?B?ZG8yN1k1a3Bvd1dUR3Bpclp4OTN6STlUeXo4OWlPYklTd2N3TEdxaVpkSXBk?=
 =?utf-8?B?NXQzVS92K244dXhmZjZlU2tBSHZFcGJZeFpqNXNpUDJjclQzSUVJSW9seGJ5?=
 =?utf-8?Q?tqOsHF+Ve1dicL/YUanwPDAv8vNM0JT57DXyw2lQn8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5EB788057C680419D80C672E7707FC0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11ca32b-0b8d-48ec-08d7-08d9edc92f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2022 01:44:19.0997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SozRYdS7lEn9Gv0+iREoEMBGc2hhtzNSFPqacHtJ3hqI3XU2myhxfqzSRyx+XhkazCM/gqsUpTJzLrKnSG49q1jiu/5Ry0yz/K270j4YzOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1874
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTExIGF0IDE0OjE5IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS8zMC8yMiAxMzoxOCwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gU2hhZG93IHN0YWNr
IGFjY2Vzc2VzIGFyZSB3cml0ZXMgZnJvbSBoYW5kbGVfbW1fZmF1bHQoKQ0KPiA+IHBlcnNwZWN0
aXZlLiBTbyB0bw0KPiA+IGdlbmVyYXRlIHRoZSBjb3JyZWN0IFBURSwgbWF5YmVfbWt3cml0ZSgp
IHdpbGwgcmVseSBvbiB0aGUgcHJlc2VuY2UNCj4gPiBvZg0KPiA+IFZNX1NIQURPV19TVEFDSyBv
ciBWTV9XUklURSBpbiB0aGUgdm1hLg0KPiA+IA0KPiA+IEluIGZ1dHVyZSBwYXRjaGVzLCB3aGVu
IFZNX1NIQURPV19TVEFDSyBpcyBhY3R1YWxseSBjcmVhdGFibGUgYnkNCj4gPiB1c2Vyc3BhY2Us
IGEgcHJvYmxlbSBjb3VsZCBoYXBwZW4gaWYgYSB1c2VyIGNhbGxzDQo+ID4gbXByb3RlY3QoICwg
LCBQUk9UX1dSSVRFKSBvbiBWTV9TSEFET1dfU1RBQ0sgc2hhZG93IHN0YWNrIG1lbW9yeS4NCj4g
PiBUaGUgY29kZQ0KPiA+IHdvdWxkIHRoZW4gYmUgY29uZnVzZWQgaW4gdGhlIGV2ZW50IG9mIHNo
YWRvdyBzdGFjayBhY2Nlc3NlcywgYW5kDQo+ID4gY3JlYXRlIGENCj4gPiB3cml0YWJsZSBQVEUg
Zm9yIGEgc2hhZG93IHN0YWNrIGFjY2Vzcy4gVGhlbiB0aGUgcHJvY2VzcyB3b3VsZA0KPiA+IGZh
dWx0IGluIGENCj4gPiBsb29wLg0KPiA+IA0KPiA+IFByZXZlbnQgdGhpcyBmcm9tIGhhcHBlbmlu
ZyBieSBibG9ja2luZyB0aGlzIGtpbmQgb2YgbWVtb3J5DQo+ID4gKFZNX1dSSVRFIGFuZA0KPiA+
IFZNX1NIQURPV19TVEFDSykgZnJvbSBiZWluZyBjcmVhdGVkLCBpbnN0ZWFkIG9mIGNvbXBsaWNh
dGluZyB0aGUNCj4gPiBmYXVsdA0KPiA+IGhhbmRsZXIgbG9naWMgdG8gaGFuZGxlIGl0Lg0KPiA+
IA0KPiA+IEFkZCBhbiB4ODYgYXJjaF92YWxpZGF0ZV9mbGFncygpIGltcGxlbWVudGF0aW9uIHRv
IGhhbmRsZSB0aGUNCj4gPiBjaGVjay4NCj4gPiBSZW5hbWUgdGhlIHVhcGkvYXNtL21tYW4uaCBo
ZWFkZXIgZ3VhcmQgdG8gYmUgYWJsZSB0byB1c2UgaXQgZm9yDQo+ID4gYXJjaC94ODYvaW5jbHVk
ZS9hc20vbW1hbi5oIHdoZXJlIHRoZSBhcmNoX3ZhbGlkYXRlX2ZsYWdzKCkgd2lsbA0KPiA+IGJl
Lg0KPiANCj4gSXQgd291bGQgYmUgZ3JlYXQgaWYgdGhpcyBhbHNvIHNhaWQ6DQo+IA0KPiAJVGhl
cmUgaXMgYW4gZXhpc3RpbmcgYXJjaF92YWxpZGF0ZV9mbGFncygpIGhvb2sgZm9yIG1tYXAoKSBh
bmQNCj4gCW1wcm90ZWN0KCkgd2hpY2ggYWxsb3dzIGFyY2hpdGVjdHVyZXMgdG8gcmVqZWN0IHVu
d2FudGVkDQo+IAktPnZtX2ZsYWdzIGNvbWJpbmF0aW9ucy4gIEFkZCBhbiBpbXBsZW1lbnRhdGlv
biBmb3IgeDg2Lg0KPiANCj4gVGhhdCdzIHNvbWV3aGF0IGltcGxpZWQgZnJvbSB3aGF0IGlzIHRo
ZXJlIGFscmVhZHksIGJ1dCBtYWtpbmcgaXQNCj4gbW9yZQ0KPiBjbGVhciB3b3VsZCBiZSBuaWNl
LiAgVGhlcmUncyBhIG11Y2ggaGlnaGVyIGJhciB0byBhZGQgYSBuZXcgYXJjaA0KPiBob29rDQo+
IHRoYW4gdG8ganVzdCBpbXBsZW1lbnQgYW4gZXhpc3Rpbmcgb25lLg0KDQpPaywgbWFrZXMgc2Vu
c2UuDQoNCj4gDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tbWFu
LmgNCj4gPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21tYW4uaA0KPiA+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5iNDRmZTMxZGViM2ENCj4gPiAtLS0gL2Rl
di9udWxsDQo+ID4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbW1hbi5oDQo+ID4gQEAgLTAs
MCArMSwyMSBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0K
PiA+ICsjaWZuZGVmIF9BU01fWDg2X01NQU5fSA0KPiA+ICsjZGVmaW5lIF9BU01fWDg2X01NQU5f
SA0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+ID4gKyNpbmNsdWRlIDx1YXBp
L2FzbS9tbWFuLmg+DQo+ID4gKw0KPiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9TSEFET1dfU1RBQ0sN
Cj4gPiArc3RhdGljIGlubGluZSBib29sIGFyY2hfdmFsaWRhdGVfZmxhZ3ModW5zaWduZWQgbG9u
ZyB2bV9mbGFncykNCj4gPiArew0KPiA+ICsJaWYgKCh2bV9mbGFncyAmIFZNX1NIQURPV19TVEFD
SykgJiYgKHZtX2ZsYWdzICYgVk1fV1JJVEUpKQ0KPiA+ICsJCXJldHVybiBmYWxzZTsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiANCj4gVGhlIGRlc2lnbiBkZWNpc2lvbiBo
ZXJlIHNlZW1zIHRvIGJlIHRoYXQgVk1fU0hBRE9XX1NUQUNLIGlzIGl0c2VsZiBhDQo+IHBzZXVk
by1WTV9XUklURSBmbGFnLiAgTGlrZSB5b3Ugc2FpZDogIlNoYWRvdyBzdGFjayBhY2Nlc3NlcyBh
cmUNCj4gd3JpdGVzDQo+IGZyb20gaGFuZGxlX21tX2ZhdWx0KCkiLg0KPiANCj4gVmVyeSBlYXJs
eSBvbiwgdGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBtYWRlIHRoZSBkZWNpc2lvbiB0aGF0DQo+
IHNoYWRvdw0KPiBzdGFja3MgYXJlIHdyaXRhYmxlIGFuZCBuZWVkIGxvdHMgb2Ygd3JpdGUgaGFu
ZGxpbmcgYmVoYXZpb3IsICpCVVQqDQo+IHNob3VsZG4ndCBoYXZlIFZNX1dSSVRFIHNldC4gIEFz
IGEgd2hvbGUsIHRoYXQgc2VlbXMgb2RkLg0KPiANCj4gVGhlIGFsdGVybmF0aXZlIHdvdWxkIGJl
ICpyZXF1aXJpbmcqIFZNX1dSSVRFIGFuZCBWTV9TSEFET1dfU1RBQ0sgYmUNCj4gc2V0DQo+IHRv
Z2V0aGVyLiAgSSBndWVzcyB0aGUgZG93bnNpZGUgaXMgdGhhdCBwdGVfbWt3cml0ZSgpIHdvdWxk
IG5lZWQgdG8NCj4gYmUNCj4gbWFkZSB0byB3b3JrIG9uIHNoYWRvdyBzdGFjayBQVEVzLg0KPiAN
Cj4gVGhhdCBwYXJ0aWN1bGFyIGRlc2lnbiBkZWNpc2lvbiB3YXMgbmV2ZXIgZGlzY3Vzc2VkLiAg
SSB0aGluayBpdCBoYXMNCj4gYQ0KPiByZWFsbHkgYmlnIGltcGFjdCBvbiB0aGUgcmVzdCBvZiB0
aGUgc2VyaWVzLiAgV2hhdCBkbyB5b3UgdGhpbms/ICBXYXMNCj4gaXQNCj4gYSBnb29kIGlkZWE/
ICBPciB3b3VsZCB0aGUgYWx0ZXJuYXRpdmUgYmUgbW9yZSBjb21wbGljYXRlZCB0aGFuIHdoYXQN
Cj4geW91DQo+IGhhdmUgbm93Pw0KDQpGaXJzdCBvZiBhbGwsIHRoYW5rcyBhZ2FpbiBmb3IgdGhl
IGRlZXAgcmV2aWV3IG9mIHRoZSBNTSBwaWVjZS4gSSdtDQpzdGlsbCBwb25kZXJpbmcgdGhlIG92
ZXJhbGwgcHJvYmxlbSwgd2hpY2ggaXMgd2h5IEkgaGF2ZW4ndCByZXNwb25kZWQNCnRvIHRob3Nl
IHlldC4NCg0KSSBoYWQgb3JpZ2luYWxseSB0aG91Z2h0IHRoYXQgdGhlIE1NIGNoYW5nZXMgd2Vy
ZSBhIGJpdCBoYXJkIHRvIGZvbGxvdy4NCkkgd2FzIGFsc28gc29tZXdoYXQgYW1hemVkIGF0IGhv
dyBuYXR1cmFsbHkgbm9ybWFsIENPVyB3b3JrZWQuIEkgd2FzDQp3b25kZXJpbmcgd2hlcmUgdGhl
IGJpZyBDT1cgc3R1ZmYgd291bGQgYmUgaGFwcGVuaW5nLiBJbiB0aGUgd2F5IHRoYXQNCkNPVyB3
YXMgc29ydCBvZiB0dWNrZWQgYXdheSwgb3ZlcmxvYWRpbmcgd3JpdGFiaWxpdHkgc2VlbWVkIHNv
cnQgb2YNCmFsaWduZWQuIEJ1dCB0aGUgbmFtZXMgYXJlIHZlcnkgY29uZnVzaW5nLCBhbmQgdGhp
cyBwYXRjaCBwcm9iYWJseQ0Kc2hvdWxkIGhhdmUgYmVlbiBhIGhpbnQgdGhhdCB0aGVyZSBhcmUg
cHJvYmxlbXMgZGVzaWduIHdpc2UuDQoNCkZvciB3cml0YWJpbGl0eSwgZXNwZWNpYWxseSB3aXRo
IFdSU1MsIEkgZG8gdGhpbmsgaXQncyBhIGJpdCB1bm5hdHVyYWwNCnRvIHRoaW5rIG9mIHNoYWRv
dyBzdGFjayBtZW1vcnkgYXMgYW55dGhpbmcgYnV0IHdyaXRhYmxlLiBFc3BlY2lhbGx5DQp3aGVu
IGl0IGNvbWVzIHRvIENPVy4gQnV0IHNoYWRvdyBzdGFjayBhY2Nlc3NlcyBhcmUgbm90IGFsd2F5
cyB3cml0ZXMsDQppbmNzc3AgZm9yIGV4YW1wbGUuIFRoZSBjb2RlIHdpbGwgY3JlYXRlIHNoYWRv
dyBzdGFjayBtZW1vcnkgZm9yIHNoYWRvdw0Kc3RhY2sgYWNjZXNzIGxvYWRzLCB3aGljaCBvZiBj
b3Vyc2UgaXNuJ3Qgd3JpdGluZyBhbnl0aGluZywgYnV0IGlzDQpyZXF1aXJlZCB0byBtYWtlIHRo
ZSBpbnN0cnVjdGlvbiB3b3JrLiBTbyBpdCBjYWxscyBta3dyaXRlKCksIHdoaWNoIGlzDQp3ZWly
ZC4gQnV0Li4uIGl0IGRvZXMgbmVlZCB0byBsZWF2ZSBpdCBpbiBhIHN0YXRlIHRoYXQgaXMga2lu
ZCBvZg0Kd3JpdGFibGUsIHNvIG1ha2VzIGEgbGl0dGxlIHNlbnNlIEkgZ3Vlc3MuDQoNCkkgd2Fz
IHdvbmRlcmluZyBpZiBtYXliZSB0aGUgbW0gY29kZSBjYW4ndCBiZSBmdWxseSBzZW5zaWJsZSBm
b3Igc2hhZG93DQpzdGFja3Mgd2l0aG91dCBjcmVhdGluZyBtYXliZV9ta3Noc3RrKCkgYW5kIGFk
ZGluZyBpdCBldmVyeXdoZXJlIGluIGENCndob2xlIG5ldyBmYXVsdCBwYXRoLiBUaGVuIHlvdSBo
YXZlIHJlYWRzLCB3cml0ZXMgYW5kIHNoYWRvdyBzdGFjaw0KYWNjZXNzZXMgdGhhdCBlYWNoIGhh
dmUgdGhlaXIgb3duIGxvZ2ljLiBJdCBtaWdodCByZXF1aXJlIHNvIG1hbnkNCmFkZGl0aW9ucyB0
aGF0IGJldHRlciBuYW1lcyBhbmQgY29tbWVudHMgYXJlIHByZWZlcmFibGUuIEkgZG9uJ3Qga25v
dw0KdGhvdWdoLCBzdGlsbCB0cnlpbmcgdG8gY29tZSB1cCB3aXRoIGEgZ29vZCBvcGluaW9uLg0K
DQoNCg==
