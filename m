Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092104B31B6
	for <lists+linux-arch@lfdr.de>; Sat, 12 Feb 2022 01:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354323AbiBLAKe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 19:10:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiBLAKd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 19:10:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA31D71;
        Fri, 11 Feb 2022 16:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644624630; x=1676160630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7wuFq6RsmntkfVHdtogIzYhAw+ln3zyrqvwnygojvoU=;
  b=ezIDkKW+1THnn8JD3TJ4bJ+M8CBzMvi7zOdU9BNLV0tSd5sVualTy+4F
   CyCkBPhV6X2I+xOxM3XG5x87EVpanoMG1DCjmQCf+ZqdRppbrmlvTAdFc
   qYKYCViVa1jYb/C9NcEjJBxJjDdVjcXHf01L5P1hfXFAlxntUqg9ItEnP
   mGi5uFQ68ez6DfVirWFnkbPKBDa+PXa92DFfJ3FdAFFczqtIa1M8SYnOj
   DixHlMN5xpWxPzmwwnoXrW9HLcKN3ujwEJid6qjZxR9fBoRd9xx0rSEur
   KdlQt78qQyPpburRhBrXG/I1c2FzSoY0ldNxGje0TRNDtrly/qcKqQoIY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="237238156"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="237238156"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 16:10:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="772243262"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2022 16:10:29 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 16:10:29 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 16:10:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 11 Feb 2022 16:10:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 11 Feb 2022 16:10:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F67tYa+t2mJZgUhB4LGxYvI/UW7IfiYQ6yTRNGppZBs/ZPYAvqQsYf7hNfhNYbGuTGGnnY7I0NQAzAE6Wy3oRngz26LDFD47lR9kvR8SIhRnDBmcWdaLYBZrlZrfd5BwWkP67VvhOFdDVmJmzgvP/D2glcLhwjLPmxpVDiSXpHWfe2ndmZAm2wnpRtNRd+77lDz1gS5GHS0CIER+7JSBZoRir780mQyqJw8ivJmpm0lukCRIp8AAtOPKW+k5y/ZKbETJoHgkTk6HTzJbh5YC5vFhF9rzGwpUqp9/bvF64H0vCu+UIsvA33XpWRQEXmEvPSKTYG5cOI/s+rTfkfeoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wuFq6RsmntkfVHdtogIzYhAw+ln3zyrqvwnygojvoU=;
 b=Mz8IJXMV2cJHWcINNqwNDAL5iAbVdr2R3+GQiu18NldM+k0BIg3290hsLCJ+oTmB7/aCml58UtGzll+MfWrvAqa3OMgGpCsG6wqrPb20kj1XiXkPWRSG79FXThXawXfqcdZAgPgUFuDHo264V9bplN1fj0E4D5vzVl5bRTIYdAqxRzKN/09uzVFRHmg6k3KM/bngSkV5jXlB03BnqMTNYMCS4rhUDvJFaJLp2g6MdLP+MQ8E7YV30dTin/LCqAy/X/5hRyYyEG3Mb997j8ktNPJ+QVx55mgPiyzfTbwxcsN7uICruXvSIl2iUOUXEg+x/Ga4CKbWI73gslarLp+Rpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MWHPR11MB1309.namprd11.prod.outlook.com (2603:10b6:300:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Sat, 12 Feb
 2022 00:10:26 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4951.021; Sat, 12 Feb 2022
 00:10:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH 18/35] mm: Add guard pages around a shadow stack.
Thread-Index: AQHYFh91Wc0p4+RWw0irm7tPRuygp6yNcwuAgAAGkYCAAAlAgIABMZ+AgABpIgA=
Date:   Sat, 12 Feb 2022 00:10:25 +0000
Message-ID: <e86ac1468767b8cf7f02c64bdb26b2ed951aa992.camel@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
         <20220130211838.8382-19-rick.p.edgecombe@intel.com>
         <4c216532-2b68-dd95-93f1-542df4786d7a@intel.com>
         <CALCETrWmiNi2+sPKWDUjGtGWtP9XNryfFe-dG4fTQkXyqGqpzQ@mail.gmail.com>
         <e16fcf166d8304b0b9358e8413ec4a7ffc1de147.camel@intel.com>
         <c1f159ef-a010-c356-e633-66cce859fdd5@kernel.org>
In-Reply-To: <c1f159ef-a010-c356-e633-66cce859fdd5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46b7ca25-5487-48e1-4afc-08d9edbc1227
x-ms-traffictypediagnostic: MWHPR11MB1309:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR11MB130948A50D75899BE2A4E3D0C9319@MWHPR11MB1309.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUGDFP/6bUv8fArhvWI/3TDCt+IlXm23AiuqTFYJom4ZN7hkQGV543qGWkT7ZG2YI2S+AlsxromIRAX3uHKYsypwXGcsGADaOR1tAG2sSYQscfBOCJjzXYrHSJGRzTa/dvJTOZxLvJKCrJWZNsq3V02OXy3QG6BkDoVFlDLGKQ2WD3t2PrUvufVp3oN8ZKheF0O3oV5eLpkoauZsIuh6RNwCMMHA+aysBp+y4ZKMa5q5dtNFsVS0bNQE13/N1LWaZiMTpwIDTUWbfJZrDFH0IAHP73nhq+DPCZHhFSMCPPT0MAcWQeI0J5APzzfuUIY3Pb5k1V5b2Y6uM/sspYBQs9wc3+etCvxEqLEjK3/96edQH/VZLJuMvLfSDsThy33zUr4iXDiCEvb0DO5jW2+1h5Arxwy9lzI68OU72DSS8HXwUqtUUe9bP3SvPpqFtoGQMd2XjwE9PJsQzFEtJLOcRdJ5cY8+2Qpvy99RI95cAizfwwhAL1zS9FpRi6legebyGEwI3oftV8DNU+jzg39OC63xfvJYTrrwEMdJR0kAZ5WpiduLkp2oUfT3TENQ0MitOLQ/oCecWLwYDJu89I+fkqCWUauCYwivUs9+JdHBDOOgU1qrhluvnqh/0Ru6t1GmCJiFT3aGZNctMtMPZbPNo7IhbEev1eK8t9fN+n3WqXVA6er5QGyjPu9Lez9IjDUrZgLAxpTnkmKo7MkMD68vXalLcqBau12c7CgZz3XVqOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(2906002)(26005)(186003)(71200400001)(122000001)(2616005)(8676002)(8936002)(82960400001)(66946007)(6512007)(6506007)(508600001)(316002)(86362001)(6486002)(110136005)(6636002)(54906003)(38100700002)(4326008)(38070700005)(7406005)(66556008)(64756008)(76116006)(7416002)(66476007)(5660300002)(66446008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUg5K2NUREdjTWNWem9MaEhIcGo0WHNLUTF4a1A3NFVIK3hOd0xOQlRmVTVM?=
 =?utf-8?B?cWc5Rm5HbVplVXFReXdMTzhOcXAza1FMQXhGcUFOeDZSRTBidlR5WkNxMThy?=
 =?utf-8?B?Q1Q3bVJ4MlhNeVVLTFF4U3FVSE5jU3RkWXEvSkkxaUR5ZURsVGZLZTY4ZVRi?=
 =?utf-8?B?WUdIMytlYzVzYURKUVNVcnBhNmFiaTF2QnhocWlJcDVhN3Nqd0oxVWtzU3Ux?=
 =?utf-8?B?SjBnZkhnb0dNL1krZHBiRm9FSDhhdXJDNW0xNVNJM0RobGgySDcrVE9BR25B?=
 =?utf-8?B?bTFPTklwMDJFRUY5TGNFNEVGZ1luNUtHZVA5N2JiVjltMFhXSHJ3Y0R0NWVB?=
 =?utf-8?B?cGo3UnNWWW5Dc3RPcFkwQ2hla2hUWFYrNEZtRldqcCtZVmdVMmV3WDZ5bjA0?=
 =?utf-8?B?TWhhMW1lS3NFcTRFbDZzdnlyY3ovVXBFeWJxUVhNRUFXSW9pS2lvT28vWmNI?=
 =?utf-8?B?SXFiTDVVWmNLRGthODF0c1o0c1NyRmIyaW1ITyt2SjM2MnRKN3pBbDYvSEdz?=
 =?utf-8?B?STBxcGNsd1ZabjVMQnF4dFF1K1paSkJtZWtkTFNxTktKekNIenlCazIxVHYz?=
 =?utf-8?B?TnZVYTI0MlNBczBmN3BUdmI0M1BTbGdWc3MwWDZXbWszdWhsQ2YzaytBVTVx?=
 =?utf-8?B?ZnlhR1hpcXhDOW1JaW94T3BkWDh1SmJ3NnpydTY3QlcrblpuSHIwZUY3d0lW?=
 =?utf-8?B?STlZemJNTWtCc3FWdE1FQkZMYmcyaU1PMWg3STUxQWJONi9jU2ZXQzU0ODlG?=
 =?utf-8?B?Q2dvaXlnRlVFYlQ0ZkZSV3lldUNTUld0WUpXVzM2eW9KcjF2alcyRFBOcUxH?=
 =?utf-8?B?S0lQVkxaUUNmOExFYjJZalIrVU83ejllYmt0anZMV0FjYXlQelhSWm9OK05t?=
 =?utf-8?B?L3VieUpEd1dDNFJ4blNpK2hzYXkvUjRNZldMUHI4TnE1MlRIeWg3R0FxSHJa?=
 =?utf-8?B?UUJCeFV2UXd5UkVWdS9jNjhhTWhTYmpqMlk2VWFXUHVqbldVaitsSEpDVXRa?=
 =?utf-8?B?aEJ5R0lZL3pENk9vSUYzYUwwV2hjVjJKOVY4MlhFcnh1cG9wc2Yya2xsdmdI?=
 =?utf-8?B?bWxDMEd4SFZNM0RlQjNzUFRDQ1ZsNWtXU2N2T3o5enVZZ0d3Ny9NaERGbUp6?=
 =?utf-8?B?TUJzblozcHpyd2lKMU9McXZVUkpNbTd2aGVlYTVFVndPTXUwdGlOdU9nVUw5?=
 =?utf-8?B?M0h4R3l4MGh3cSsvQ3V6cUFML3lJYi81V0FpR2JnckVLVTZFUFd0SEZkZGJT?=
 =?utf-8?B?RElYd1ZsejBXZVlvZ2NzYUk1clB0U0xFUGNXU1RtSmd0MWJ6VXlieDlsSUpM?=
 =?utf-8?B?YklxbUVlRms0clpwNmlZSVQyR2JrNVFmUUR0NE1RMWJFbUFreCsyOVBXUGwy?=
 =?utf-8?B?aGhwZVRpVk4yNGV4SWo1dEFpVWZSeEkyVitydDlVRHhaU3hheWhmRUJIVEpj?=
 =?utf-8?B?anFaZHFoRDl6MVBpRUkzU3NBbStuVmdINFRhVUZBaDFNMmpQU1FCRm01c1kr?=
 =?utf-8?B?Y2R4QjdJeSszcU9LWEFTVTREaUJHa0Y4b0w3cVZhYWhRc0N3UUg2NHdnNnQx?=
 =?utf-8?B?Mm53d2FMSjJ0azBGeWpTTXpma1dhWlRDa01tL0NyV00ybTBuRGwwZDhKOVVI?=
 =?utf-8?B?WG5iZCtRMVFSMUZWSDExUzlXeXAxWitUdnBvd2xMUnhsMTFWbEtkK3BYcXZt?=
 =?utf-8?B?d0tvTGRHdU5CUERMcktpL1BVYlV0MENNUlRXRkFDbzdFQW5lUDRiWEJ5L0NM?=
 =?utf-8?B?b1M5ZU1PcXFMeHJxTm9IT1dzOWMrSHVvVkt3ZUp0dHJ2MFBSNm9xRzRLaEky?=
 =?utf-8?B?dWxkR21MSEFVZXI1dUg0SS9HMDE1ZXB6eHFZK0JhdzE1a01BSFFLV1dnem9q?=
 =?utf-8?B?OVBqbVNlOGJCMlBwdnRpQ2hrWUNhaWRpVDRHMUdFMng3YVNma2p2VHpQNVRN?=
 =?utf-8?B?cW1BR1ZWTUkrc2piTVRqcU44YlN6aEc5bW92UThIMVg1OEhWNGJwTEtYM2RM?=
 =?utf-8?B?SmR1dHZtbVE0alpBYzQydDZOZVpvTUZvM3M5U003NzZYcUFPbThZZmpEWWZr?=
 =?utf-8?B?L1Y0WW04djlKYU1iaGE4VktrM25nOCtNNWJiL3BEWFRQazFjK3FsNzJlTXJO?=
 =?utf-8?B?eGpOZS9JTlhSYURqY3NTblVWMFdCSzJBTjVkSDk3NXdBdjFCbWJpT3R0Z3ZK?=
 =?utf-8?B?RVBDSXdRWXd2YThGQ3BKVEx6bllWK1N3QWZxY2paMU04MmlPa0pycXVzUXVB?=
 =?utf-8?Q?aHqkEcGcW8nQ4FLySg5uXbEpC/xGVxPN+VdfiU/Cxc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C854C3E80294D46A1AB87CA2A89CAAF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b7ca25-5487-48e1-4afc-08d9edbc1227
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2022 00:10:25.4772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csu/EW46IdxLA+Bv76j9zu1gxcWt+rvrqtk6qEsdGivSyGm3oj/yIieTSWpDnK//HucjrLSsXSjIMGjKfs0UbrKsbK6b1mKRB9qLNfIQgwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1309
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTExIGF0IDA5OjU0IC0wODAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6
DQo+ID4gTGlrZSBqdXN0IHVzaW5nIFZNX1NIQURPV19TVEFDSyB8IFZNX0dST1dTRE9XTiB0byBn
ZXQgYSByZWd1bGFyDQo+ID4gc3RhY2sNCj4gPiBzaXplZCBnYXA/IEkgdGhpbmsgaXQgY291bGQg
d29yay4gSXQgYWxzbyBzaW1wbGlmaWVzIHRoZSBtbS0NCj4gPiA+c3RhY2tfdm0NCj4gPiBhY2Nv
dW50aW5nLg0KPiANCj4gU2VlbXMgbm90IGNyYXp5LiAgRG8gd2Ugd2FudCBhdXRvbWF0aWNhbGx5
IGdyb3dpbmcgc2hhZG93IHN0YWNrcz8gIEkgDQo+IGRvbid0IHJlYWxseSBsaWtlIHRoZSBoaXN0
b3JpY2FsIHVuaXggYmVoYXZpb3Igd2hlcmUgdGhlIG1haW4gdGhyZWFkDQo+IGhhcyANCj4gYSBz
b3J0LW9mLWluZmluaXRlIHN0YWNrIGFuZCBldmVyeSBvdGhlciB0aHJlYWQgaGFzIGEgZml4ZWQg
c3RhY2suDQoNCkFoISBJIHdhcyBzY3JhdGNoaW5nIG15IGhlYWQgd2h5IGdsaWJjIGRpZCB0aGF0
IC0gaXQncyBoaXN0b3JpY2FsLiBZZWEsDQpwcm9iYWJseSBpdCdzIG5vdCBuZWVkZWQgYW5kIGFk
ZGluZyBzdHJhbmdlIGJlaGF2aW9yLg0KDQo+IA0KPiA+IA0KPiA+IEl0IHdvdWxkIG5vIGxvbmdl
ciBnZXQgYSBnYXAgYXQgdGhlIGVuZCB0aG91Z2guIEkgZG9uJ3QgdGhpbmsgaXQncw0KPiA+IG5l
ZWRlZC4NCj4gPiANCj4gDQo+IEkgbWF5IGhhdmUgbWlzc2VkIHNvbWV0aGluZyBhYm91dCB0aGUg
b2RkYmFsbCB3YXkgdGhlIG1tIGNvZGUgd29ya3MsDQo+IGJ1dCANCj4gaXQgc2VlbXMgaWYgeW91
IGhhdmUgYSBnYXAgYXQgb25lIGVuZCBvZiBldmVyeSBzaGFkb3cgc3RhY2ssIHlvdSANCj4gYXV0
b21hdGljYWxseSBoYXZlIGEgZ2FwIGF0IHRoZSBvdGhlciBlbmQuDQoNClJpZ2h0LCB3ZSBvbmx5
IG5lZWQgb25lLCBhbmQgdGhpcyBwYXRjaCBhZGRlZCBhIGdhcCBvbiBib3RoIGVuZHMuDQoNClBl
ciBBbmR5J3MgY29tbWVudCBhYm91dCB0aGUgIm9kZGJhbGwgd2F5IiB0aGUgbW0gY29kZSBkb2Vz
IHRoZSBnYXBzIC0NClRoZSBwcmV2aW91cyB2ZXJzaW9uIG9mIHRoaXMgKFBST1RfU0hBRE9XX1NU
QUNLKSBoYWQgYW4gaXNzdWUgd2hlcmUgaWYNCnlvdSBzdGFydGVkIHdpdGggd3JpdGFibGUgbWVt
b3J5LCB0aGVuIG1wcm90ZWN0KCkgd2l0aA0KUFJPVF9TSEFET1dfU1RBQ0ssIHRoZSBpbnRlcm5h
bCByYiB0cmVlIHdvdWxkIGdldCBjb25mdXNlZCBvdmVyIHRoZQ0Kc3VkZGVuIGFwcGVhcmFuY2Ug
b2YgYSBnYXAuIFRoaXMgbmV3IHZlcnNpb24gZm9sbG93cyBjbG9zZXIgdG8gaG93DQpNQVBfU1RB
Q0sgYXZvaWRzIHRoZSBwcm9ibGVtIEkgc2F3LiBCdXQgdGhlIHdheSB0aGVzZSBndWFyZCBnYXBz
IHdvcmsNCnNlZW0gdG8gYmFyZWx5IGF2b2lkIHByb2JsZW1zIHdoZW4geW91IGRvIHRoaW5ncyBs
aWtlIHNwbGl0IHRoZSB2bWEgYnkNCm1wcm90ZWN0KClpbmcgdGhlIG1pZGRsZSBvZiBvbmUuIEkg
d2Fzbid0IHN1cmUgaWYgaXQncyB3b3J0aCBhDQpyZWZhY3Rvci4gSSBndWVzcyB0aGUgc29sdXRp
b24gaXMgcXVpdGUgb2xkIGFuZCB0aGVyZSBoYXNuJ3QgYmVlbg0KcHJvYmxlbXMuIEknbSBub3Qg
ZXZlbiBzdXJlIHdoYXQgdGhlIGNoYW5nZSB3b3VsZCBiZSwgYnV0IGl0IGRvZXMgZmVlbA0KbGlr
ZSBhZGRpbmcgdG8gc29tZXRoaW5nIGZyYWdpbGUuIE1heWJlIHNoYWRvdyBzdGFjayBzaG91bGQg
anVzdCBwbGFjZQ0KYSBndWFyZCBwYWdlIG1hbnVhbGx5IGFuZCBub3QgYWRkIGFueSBzcGVjaWFs
IHNoYWRvdyBzdGFjayBsb2dpYyB0byB0aGUNCm1tIGNvZGUuLi4NCg0KT3RoZXIgdGhhbiB0aGF0
IEknbSBpbmNsaW5lZCB0byByZW1vdmUgdGhlIGVuZCBnYXAgYW5kIGp1c3RpZnkgdGhpcw0KcGF0
Y2ggYmV0dGVyIGluIHRoZSBjb21taXQgbG9nLiBTb21ldGhpbmcgbGlrZSB0aGlzIChib3Jyb3dp
bmcgc29tZQ0KZnJvbSBEYXZlJ3MgY29tbWVudHMpOg0KDQoJVGhlIGFyY2hpdGVjdHVyZSBvZiBz
aGFkb3cgc3RhY2sgY29uc3RyYWlucyB0aGUgYWJpbGl0eSBvZiANCgl1c2Vyc3BhY2UgdG8gbW92
ZSB0aGUgc2hhZG93IHN0YWNrIHBvaW50ZXIgKHNzcCkgaW4gb3JkZXIgdG8gDQoJcHJldmVudCBj
b3JydXB0aW5nIG9yIHN3aXRjaGluZyB0byBvdGhlciBzaGFkb3cgc3RhY2tzLiBUaGUgDQoJUlNU
T1JTU1AgY2FuIG1vdmUgdGhlIHNwcCB0byBkaWZmZXJlbnQgc2hhZG93IHN0YWNrcywgYnV0IGl0
IA0KCXJlcXVpcmVzIGEgc3BlY2lhbGx5IHBsYWNlZCB0b2tlbiBpbiBvcmRlciB0byBzd2l0Y2gg
c2hhZG93IA0KCXN0YWNrcy4gSG93ZXZlciwgdGhlIGFyY2hpdGVjdHVyZSBkb2VzIG5vdCBwcmV2
ZW50IA0KCWluY3JlbWVudGluZyBvciBkZWNyZW1lbnRpbmcgc2hhZG93IHN0YWNrIHBvaW50ZXIg
dG8gd2FuZGVyIA0KCW9udG8gYW4gYWRqYWNlbnQgc2hhZG93IHN0YWNrLiBUbyBwcmV2ZW50IHRo
aXMgaW4gc29mdHdhcmUsIA0KCWVuZm9yY2UgZ3VhcmQgcGFnZXMgYXQgdGhlIGJlZ2lubmluZyBv
ZiBzaGFkb3cgc3RhY2sgdm1hcywgc3VjaA0KCXRoYXQgdA0KaGVyZSB3aWxsIGFsd2F5cyBiZSBh
IGdhcCBiZXR3ZWVuIGFkamFjZW50IHNoYWRvdyBzdGFja3MuDQoNCglNYWtlIHRoZSBnYXAgYmln
IGVub3VnaCBzbyB0aGF0IG5vIHVzZXJzcGFjZSBzc3AgY2hhbmdpbmcgDQoJb3BlcmF0aW9ucyAo
YmVzaWRlcyBSU1RPUlNTUCksIGNhbiBtb3ZlIHRoZSBzc3AgZnJvbSBvbmUgc3RhY2sgDQoJdG8g
dGhlIG5leHQuIFRoZSBzc3AgY2FuIGluY3JlbWVudCBvciBkZWNyZW1lbnQgYnkgQ0FMTCwgUkVU
IA0KCWFuZCBJTkNTU1AuIENBTEwgYW5kIFJFVCBjYW4gbW92ZSB0aGUgc3NwIGJ5IGEgbWF4aW11
bSBvZiA4IA0KCWJ5dGVzLCBhdCB3aGljaCBwb2ludCB0aGUgc2hhZG93IHN0YWNrIHdvdWxkIGJl
IGFjY2Vzc2VkLg0KDQogICAgICAgIFRoZSBJTkNTU1AgaW5zdHJ1Y3Rpb24gY2FuIGFsc28gaW5j
cmVtZW50IHRoZSBzaGFkb3cgc3RhY2sgDQoJcG9pbnRlci4gSXQgaXMgdGhlIHNoYWRvdyBzdGFj
ayBhbmFsb2cgb2YgYW4gaW5zdHJ1Y3Rpb24gbGlrZToNCg0KICAgICAgICAgICAgICAgIGFkZHEg
ICAgJDB4ODAsICVyc3ANCg0KICAgICAgICBIb3dldmVyLCB0aGVyZSBpcyBvbmUgaW1wb3J0YW50
IGRpZmZlcmVuY2UgYmV0d2VlbiBhbiBBREQgb24NCiAgICAgICAgJXJzcCBhbmQgSU5DU1NQLiBJ
biBhZGRpdGlvbiB0byBtb2RpZnlpbmcgU1NQLCBJTkNTU1AgYWxzbw0KICAgICAgICByZWFkcyBm
cm9tIHRoZSBtZW1vcnkgb2YgdGhlIGZpcnN0IGFuZCBsYXN0IGVsZW1lbnRzIHRoYXQgd2VyZQ0K
ICAgICAgICAicG9wcGVkIi4gSXQgY2FuIGJlIHRob3VnaHQgb2YgYXMgYWN0aW5nIGxpa2UgdGhp
czoNCg0KICAgICAgICBSRUFEX09OQ0Uoc3NwKTsgICAgICAgLy8gcmVhZCtkaXNjYXJkIHRvcCBl
bGVtZW50IG9uIHN0YWNrDQogICAgICAgIHNzcCArPSBucl90b19wb3AgKiA4OyAvLyBtb3ZlIHRo
ZSBzaGFkb3cgc3RhY2sNCiAgICAgICAgUkVBRF9PTkNFKHNzcC04KTsgICAgIC8vIHJlYWQrZGlz
Y2FyZCBsYXN0IHBvcHBlZCBzdGFjayBlbGVtZW50DQoNCglUaGUgbWF4aW11bSBkaXN0YW5jZSBJ
TkNTU1AgY2FuIG1vdmUgdGhlIHNzcCBpcyAyMDQwIGJ5dGVzLCANCgliZWZvcmUgaXQgd291bGQg
cmVhZCB0aGUgbWVtb3J5LiBUaGVyZSBmb3IgYSBzaW5nbGUgcGFnZSBnYXAgDQoJd2lsbCBiZSBl
bm91Z2ggdG8gcHJldmVudCBhbnkgb3BlcmF0aW9uIGZyb20gc2hpZnRpbmcgdGhlIHNzcCANCgl0
byBhbiBhZGphY2VudCBnYXAsIGJlZm9yZSB0aGUgc2hhZG93IHN0YWNrIHdvdWxkIGJlIHJlYWQg
YW5kIA0KCWNhdXNlIGEgZmF1bHQuDQoNCglUaGlzIGNvdWxkIGJlIGFjY29tcGxpc2hlZCBieSB1
c2luZyBWTV9HUk9XU0RPV04sIGJ1dCB0aGlzIGhhcyANCgl0d28gZG93bnNpZGVzLg0KCSAgIDEu
IFZNX0dST1dTRE9XTiB3aWxsIGhhdmUgYSAxTUIgZ2FwIHdoaWNoIGlzIG9uIHRoZSBsYXJnZSAN
CgkgICAgICBzaWRlIGZvciAzMiBiaXQgYWRkcmVzcyBzcGFjZXMNCgkgICAyLiBUaGUgYmVoYXZp
b3Igd291bGQgYWxsb3cgc2hhZG93IHN0YWNrJ3MgdG8gZ3Jvdywgd2hpY2ggDQoJICAgICAgaXMg
dW5uZWVkZWQgYW5kIGFkZHMgYSBzdHJhbmdlIGRpZmZlcmVuY2UgdG8gaG93IG1vc3QgDQoJICAg
ICAgcmVndWxhciBzdGFja3Mgd29yay4NCg==
