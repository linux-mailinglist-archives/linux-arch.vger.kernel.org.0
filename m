Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03876BEFF9
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 18:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCQRmq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 13:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCQRmo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 13:42:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45040E6;
        Fri, 17 Mar 2023 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679074963; x=1710610963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DZ/24kky5IsRKfcoZjLYcQNrkw6z0at+Czysz3/hVHs=;
  b=J35GQBxxM/vKZv9kiZtpPX2gI4HGMJP4SVAUuY7mvOfaZjkS11CxU5Jl
   LYO8UoFWQr7etjY4MsQukczIEkMDb+fTUvKbUKJDD86y8u2yVWVelJWsJ
   ZU9XEzSlIwvW8FHOf/1fexKN8LCPJBDQUyUTpmIQFk8Az9+eRbhOo2Mi5
   kwHISWuWHhxRenxFNnRHfzytKdHAtpep0MVwcXpTZNIqHPnKQPmuHW1iH
   hYbOvF0uD9TEX2FBtPko+hMZdH9RcoUYHAHvcxJhtdVOmeZ/HIFL4GwBd
   EbiRWzlYf79qJZEk+F/1SSGvUdL0jYh9d7VZ8cZvBbUG8z7jIG/cYK/y0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="337025178"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="337025178"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 10:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="682760826"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="682760826"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2023 10:42:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 10:42:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 10:42:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 17 Mar 2023 10:42:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 17 Mar 2023 10:42:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKrPTUdDZ4a0zlCxChLyCDkDfbS6/GpLmDDQkXIbOXRgfHKoPw+2Ry9oRRv5r4nnyIdS5E3zwFIHx7b4fOEHUF0RhBF7k2CuBHoKJXAZK4UlaEfC8NrOb8Aj69yh9KVf+NN4OONloOg/uO43m/Y9RQXPdIBNjugYcmsrDFfaafXhq9IGaLNgi+36P0ERhQC9/hGlrW3tTdV0ea8qzaoIgC+upLKQcuqBhB7FA0ifgwTZcM9f6wR+SskJ61pOfeoYfIBA75uYw77VFqRHRwGAIEg+x1eiju9qzE+5wcaD6qHpZDvrRVkDVSY4A/pHNCXXjEc4tXEILk+uo3QwHEVNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZ/24kky5IsRKfcoZjLYcQNrkw6z0at+Czysz3/hVHs=;
 b=L05ZOWa4y6bJJeho6V5xzzY6Aq6q1twcBiDm4927KGhVH9Q1AQJga7/rn5SvH1nLzFMmBTpVxpkIpwgcKzBmps4f/aEIQMRrKyEEVfbMYSj+M1VoDWBDXEWTUXDPegkpfFW+p0wCr8e7Ej2bwNVIMY2+6JLrBXKL8dfTfYmqUvYWB7+LyYPTpTnBVHn3zgQ36O1nhgCmJmrnDIobd9l9M1a1hU03Y9srcbnkoQ67JQKuAlc5C11Xr5KQ5XMPYSjFZeveU9pfBv5mDW6UJSLlZ7p0B1Yca0tNRKR46CBMcHGIGYAe4V3eW0df7e798lwx9FUF0DaAOrSXoz8wj+Fjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH8PR11MB6952.namprd11.prod.outlook.com (2603:10b6:510:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 17:42:24 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 17:42:24 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "debug@rivosinc.com" <debug@rivosinc.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
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
Subject: Re: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Topic: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
Thread-Index: AQHZSvtDnv17MMU3fEOPp7Q4ORkHzq7/UU6AgAABGgCAAANJgIAAA/+A
Date:   Fri, 17 Mar 2023 17:42:22 +0000
Message-ID: <e9a302a41d68c4886d8d1989438d92eb2a89b922.camel@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
         <20230227222957.24501-23-rick.p.edgecombe@intel.com>
         <CAKC1njQ+resjS-O8vAVLhRfLHEdgta09faEr5zwi1JTNSWK0Fw@mail.gmail.com>
         <236ae66c-fafb-80e9-d58b-6b18a22071c1@intel.com>
         <CAKC1njR6WEuXbghupaX6R8LPSVP69yofYNb5+tEp5huHvsroCw@mail.gmail.com>
In-Reply-To: <CAKC1njR6WEuXbghupaX6R8LPSVP69yofYNb5+tEp5huHvsroCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH8PR11MB6952:EE_
x-ms-office365-filtering-correlation-id: 4bfd3b9f-564b-422b-46a5-08db270ef70e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zk4gBXdpfrBwBxrGaBgM/kyAhQWlf3cX9baIQiI3MDa1YMFgIBCGpttqnQcJhPZTp3o3o93/CjOEKvmF3kMaxyFmY8gOO6Xf/LHTvekc4sa3DdqwmrgNmA/YZA/PmTYhyH960Kz6Rd4r3iVK1D92jqK5ZE7ffMeJIDZdjclZniXnx6shMeWFBfREN8Ep2VPz8E+aQJ2c9Et8LogmX8+22Hd2Ttr7HTObxDeq6mJFbrodTOjIuXz/aHQhkNTxWrpeaZwzikzzIaJlUld5G68c2IqUzXCy8V/RsBvuJF3+Kzh2VfV0HPiDY29zjoSNm8cji+1cuuucQFG93/W6DUo4q6irw5vOZQ2wqZvzpQHgG2xhV4RL6cnCRPLNBmlKQ9DF6uY4BWnSeExl+xlt+Z8iCI+ESNS0IdTXLDHCrgCQg4Zsc5oXSbRBUCy9IexwKhNlfXF1H0JUqjCNTkXnGH+Nt9NqnqMT+Bl5+4E5hwNPpIwRTJWFlo2uhCVgfxJi9SS7uX51X6GaV1uLE8ScWgkgieVsik2/C9Ecwi/eMM3Ynd2J1kfKS54FDbwq8LJLZWOYsKzE3uLwxXmH2FPlWO4+1772vcJY3TX3vvjNrn7HYKFPWe824IjJSHm7n1cot0Rrlwz8V+fv20vyeAhHpmi3430ZIeaQE5VAaHNNAvtQFhzHRPy6wm2WSiK8dhdUlJGmm5hccAo2rwAaLgPSty6ez2BEdRi+K/iuCdSUw03MFug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199018)(2906002)(53546011)(6486002)(26005)(6512007)(36756003)(6506007)(7416002)(7406005)(5660300002)(316002)(186003)(41300700001)(66946007)(54906003)(86362001)(8936002)(38070700005)(71200400001)(64756008)(2616005)(66476007)(8676002)(91956017)(38100700002)(122000001)(66446008)(76116006)(4326008)(110136005)(66556008)(6636002)(82960400001)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SktJem9iUjRVV2NOL0lVTnQwU2tXc0l1dDNOT1ZRWlI3TDlqb2hxSEc2REZ2?=
 =?utf-8?B?ZVd4ZFJkYkFOTjhpbUlhRFFiWUxUYng3TG9PekVGT01XeGFNYllvaW5RMnNU?=
 =?utf-8?B?NkZrTHJZaFBRays4NFlSMnE0dG94Q0x5cDRBTnN3d3p4ME9MK0ovbENvSnQ3?=
 =?utf-8?B?MFB0OGUzUWFTeFZQOGppWkJsV2pJcDZmck5yY1IxQ0F6ajcwY2c3NHZ6M0N6?=
 =?utf-8?B?K3BxTTlXMGJiL20rSTZwZFVmUHlHV1c3UnU4UkZzT1VpYzg5b0gzdDNtOTNL?=
 =?utf-8?B?ME9QVUZSSjlaNEFhVTE1NlEzMSttTUU0Y1lGOU5xWVRwU0dFVXhvVTZBellI?=
 =?utf-8?B?M3hQUnZ2WlpZb0g2Qm4xNzV4dGlseFB1QkxIS3hlcHhMQnNJejJ1Nit1Q1cw?=
 =?utf-8?B?Z2dpNWEzVzVHWVlXZ09JRjR2Ung4TGFNbExTVjZUeis4YnJ6Uzh2cjNaSXhV?=
 =?utf-8?B?anZKNG1yenhIQ0t1bmtzcGxVYmNDUDlvUUN3OGkrbWV4cWsvbDRlZUNMU0lt?=
 =?utf-8?B?eG1KR1ptZnM1bys3dzZrU2JEZHM4WVZsVVd5YVIxTUZFN1VCc3RBZzNRYk9i?=
 =?utf-8?B?Rmh6MzQ5dDVZNGVqOHVCaWhmVThVVWVkYXZBMlJVTUwxMEsyaHExTUIzSjN2?=
 =?utf-8?B?VE1LcTNFRmJHMnl0SG9FUHV0bjBTYjkybzRrRFNuSWY1ZWxGTW10Vlg1MHdo?=
 =?utf-8?B?NUlTY01iOUlwUEhHOW15MU5Gajh5TkswUXNKcWNRU3h3Ky8wcy9PL0Rpb3Zu?=
 =?utf-8?B?cmZBT2o4ZHJOcXhSVHF0ZEp0WGZCeWlqYi8vYnZabVJUVTkrK3N3TGNnU3d4?=
 =?utf-8?B?NTRFdTNvMHQ1dFJBbTBSWUFyZXU1UGY0TGFsdEJFc0J4dkdDWHFQTVZ5a1A0?=
 =?utf-8?B?Uk9oVHMrYkhGWXJKYkxPMlA2TGFLbEVJUEF5V1UxRVBQYXZEL09zdmRDL3ow?=
 =?utf-8?B?M29EWVptM0xpUGRBaTJtTmcxUGl3ZlNNaDErNXFqSjFFdGFlTHBBS1NNNmFC?=
 =?utf-8?B?djU3TnhTaHJsUmhac3NXQTI3SC9UTUMwbEV4WEczSWgzOW5yLzMwRWhNcEQ2?=
 =?utf-8?B?NFMvYmExZWJzblFXNmRWMXlZTDZzemJsamxpa2s1RHBDQ003WWFYalFBN29y?=
 =?utf-8?B?Tjh0c2JrZUhJVlowUkoxSXp4OUlpNjJvbVhKTWRGekI3KzJPbHJ6UkNKMGUy?=
 =?utf-8?B?ZUxqVUI5dURrL05uVkF0K0EweE9rRm10VmZzZDhKN0ttNGRqcGo1VzhUbzM4?=
 =?utf-8?B?WG1EZkhVUlp4cGtXTlY1N2VIdHRlUnRWYjc5Nk9jOE4wS3hXT2k0ZHJhOEdV?=
 =?utf-8?B?blRuQnphdStpNlZQWHdQc2tacnZCNmFzRU1tb1g4aTVBWFd0TWJ5VTdtSHpu?=
 =?utf-8?B?dTRhNmRqSmI3bC9kOUpYZHRLNXowVHJwYnFPU2JvZVZNaEFMSnRpQXRVL0s1?=
 =?utf-8?B?SXNuQTcyQWFSVjloTVpNbms0U1VsRDBDbUVqamV1djJoTUkyWU83NnRocFdx?=
 =?utf-8?B?VDFzMU5DV2ZBczdoV2xRbmRNR3NwRWtkejNxRGpwMk41WGxlZEtVaFkyUGNS?=
 =?utf-8?B?SzBOQkg4dnE2Tlh1ZXZoRFg2K0VrYjJja0ozMmx1QmZYQVhCUGZGdGZLN1FY?=
 =?utf-8?B?dGNHQXZYU2hsMzAxc3V6VVBwblZsRHhCMFFKc1l4M0ZzZTJsczVtZG1CL2Ux?=
 =?utf-8?B?Y3F2N1JoYklSS0xMRUF4c0tENGFkSEdKUGJyYU1va3NXSEFFeXBqMGdWVkdQ?=
 =?utf-8?B?bDJBMTFxeEQwWHgxUVo2Mlg0OTBOZ0JxcXpPWTN2UWRSbkRkaDJ1R20vRC9Q?=
 =?utf-8?B?V2YyUzBIY2lZOHNpYWRwZzV1QmtyWkR5TnE1bzRMVTVmbDFqYjJIdFA3czNm?=
 =?utf-8?B?eHNUc2dzNGJTQXNlMTFMTFh3cmRxMVJ4ZnhRM2hvUFdWeWdSVjMxTE05WVJp?=
 =?utf-8?B?U092dWE5YVJlSi9GcVBPNjRQN2txUTlHeHN6bjI3Mm8vb2dYTk1laXBKMW1o?=
 =?utf-8?B?b2JqamQ4ZUh0aG1NSkd6ZGtlQUJZODVwNHl3SnJROWJmbTZEcDR0dW51cEZF?=
 =?utf-8?B?VlBnaFRFN2MyVE9yR0dhT09HMTUxakJ6dExiQWxKUHVzRStrOXdDSEdqYWcz?=
 =?utf-8?B?V3cweVQ1VXRUT2NOZ1pKa2JCQWNCMElzMTZsR2k5NFpTRGl0TFNzSGRyNDV0?=
 =?utf-8?Q?XZ9A9krd/gOB73IPPAJHqMQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3C92E59432DE24A85BFF46E2D01EF04@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfd3b9f-564b-422b-46a5-08db270ef70e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 17:42:23.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64CFbMo4YirdmC56trWGn++3P0JIWLQL5xRfrw5Fc0zQd+3/ZEPZKJIr7lVgIKMbRl/AhD3UKAqsVveQkq67k2oAzS4+3xIJiwzU9Rn/jwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6952
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gRnJpLCAyMDIzLTAzLTE3IGF0IDEwOjI4IC0wNzAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
IE9uIEZyaSwgTWFyIDE3LCAyMDIzIGF0IDEwOjE24oCvQU0gRGF2ZSBIYW5zZW4gPGRhdmUuaGFu
c2VuQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gT24gMy8xNy8yMyAxMDoxMiwgRGVl
cGFrIEd1cHRhIHdyb3RlOg0KPiA+ID4gPiAgIC8qDQo+ID4gPiA+IC0gKiBTdGFjayBhcmVhIC0g
YXV0b21hdGljYWxseSBncm93cyBpbiBvbmUgZGlyZWN0aW9uDQo+ID4gPiA+ICsgKiBTdGFjayBh
cmVhDQo+ID4gPiA+ICAgICoNCj4gPiA+ID4gLSAqIFZNX0dST1dTVVAgLyBWTV9HUk9XU0RPV04g
Vk1BcyBhcmUgYWx3YXlzIHByaXZhdGUNCj4gPiA+ID4gYW5vbnltb3VzOg0KPiA+ID4gPiAtICog
ZG9fbW1hcCgpIGZvcmJpZHMgYWxsIG90aGVyIGNvbWJpbmF0aW9ucy4NCj4gPiA+ID4gKyAqIFZN
X0dST1dTVVAsIFZNX0dST1dTRE9XTiBWTUFzIGFyZSBhbHdheXMgcHJpdmF0ZQ0KPiA+ID4gPiAr
ICogYW5vbnltb3VzLiBkb19tbWFwKCkgZm9yYmlkcyBhbGwgb3RoZXIgY29tYmluYXRpb25zLg0K
PiA+ID4gPiAgICAqLw0KPiA+ID4gPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19zdGFja19tYXBw
aW5nKHZtX2ZsYWdzX3QgZmxhZ3MpDQo+ID4gPiA+ICAgew0KPiA+ID4gPiAtICAgICAgIHJldHVy
biAoZmxhZ3MgJiBWTV9TVEFDSykgPT0gVk1fU1RBQ0s7DQo+ID4gPiA+ICsgICAgICAgcmV0dXJu
ICgoZmxhZ3MgJiBWTV9TVEFDSykgPT0gVk1fU1RBQ0spIHx8IChmbGFncyAmDQo+ID4gPiA+IFZN
X1NIQURPV19TVEFDSyk7DQo+ID4gPiANCj4gPiA+IFNhbWUgY29tbWVudCBoZXJlLiBgVk1fU0hB
RE9XX1NUQUNLYCBpcyBhbiB4ODYgc3BlY2lmaWMgd2F5IG9mDQo+ID4gPiBlbmNvZGluZyBhIHNo
YWRvdyBzdGFjay4NCj4gPiA+IEluc3RlYWQgbGV0J3MgaGF2ZSBhIHByb3h5IGhlcmUgd2hpY2gg
YWxsb3dzIGFyY2hpdGVjdHVyZXMgdG8NCj4gPiA+IGhhdmUNCj4gPiA+IHRoZWlyIG93biBlbmNv
ZGluZ3MgdG8gcmVwcmVzZW50IGEgc2hhZG93IHN0YWNrLg0KPiA+IA0KPiA+IFRoaXMgZG9lc24n
dCBfcHJlY2x1ZGVfIGFub3RoZXIgYXJjaGl0ZWN0dXJlIGZyb20gY29taW5nIGFsb25nIGFuZA0K
PiA+IGRvaW5nDQo+ID4gdGhhdCwgcmlnaHQ/ICBJJ2QganVzdCBwcmVmZXIgdGhhdCBzaGFkb3cg
c3RhY2sgYXJjaGl0ZWN0dXJlICMyDQo+ID4gY29tZXMNCj4gPiBhbG9uZyBhbmQgcmVmYWN0b3Jz
IHRoaXMgaW4gcHJlY2lzZWx5IHRoZSB3YXkgX3RoZXlfIG5lZWQgaXQuDQo+IA0KPiBUaGVyZSBh
cmUgdHdvIGlzc3VlcyBoZXJlDQo+ICAtIEVuY29kaW5nIG9mIHNoYWRvdyBzdGFjazogQW5vdGhl
ciBhcmNoIGNhbiBjaG9vc2UgZGlmZmVyZW50DQo+IGVuY29kaW5nLg0KPiAgICBBbmQgeWVzLCBh
bm90aGVyIGFyY2hpdGVjdHVyZSBjYW4gY29tZSBpbiBhbmQgcmUtZmFjdG9yIGl0LiBCdXQgc28N
Cj4gbXVjaCB0aG91Z2h0IGFuZCB3b3JrIGhhcyBiZWVuIGdpdmVuIHRvIHg4NiBpbXBsZW1lbnRh
dGlvbiB0byBrZWVwDQo+ICAgIHNoYWRvdyBzdGFjayB0byBub3QgaW1wYWN0IGFyY2ggYWdub3N0
aWMgcGFydHMgb2YgdGhlIGtlcm5lbC4gU28NCj4gd2h5IGNyZWVwIGl0IGluIGhlcmUuDQo+IA0K
PiAtIFZNX1NIQURPV19TVEFDSyBpcyBjb21pbmcgb3V0IG9mIHRoZSBWTV9ISUdIX0FSQ0hfWFgg
Yml0IHBvc2l0aW9uDQo+IHdoaWNoIG1ha2VzIGl0IGFyY2ggc3BlY2lmaWMuDQo+IA0KPiANCg0K
Vk1fU0hBRE9XX1NUQUNLIGlzIGRlZmluZWQgbGlrZSB0aGlzICh0cmltbWVkIGZvciBjbGFyaXR5
KToNCiNpZmRlZiBDT05GSUdfWDg2X1VTRVJfU0hBRE9XX1NUQUNLDQojIGRlZmluZSBWTV9TSEFE
T1dfU1RBQ0sJVk1fSElHSF9BUkNIXzUNCiNlbHNlDQojIGRlZmluZSBWTV9TSEFET1dfU1RBQ0sJ
Vk1fTk9ORQ0KI2VuZGlmDQoNCkFsc28sIHdlIGFjdHVhbGx5IGhhZCBhbiBpc19zaGFkb3dfc3Rh
Y2tfbWFwcGluZyh2bWEpIGluIHRoZSBwYXN0LCBidXQNCml0IHdhcyBkcm9wcGVkIGZyb20gb3Ro
ZXIgZmVlZGJhY2suIEkgdGhpbmsgaXQgbWlnaHQgYmUgdG9vIHNvb24gdG8gc2F5DQp3aGV0aGVy
IG90aGVyIGltcGxlbWVudGF0aW9ucyB3b24ndCBlbmQgdXAgd2l0aCBhIHNpbWlsYXIgdm1hIGZs
YWcsIHNvDQp0aGlzIHdvdWxkIGJlIHByZW1hdHVyZSByZWZhY3RvcmluZy4gSWYgbm90IHRob3Vn
aCwgYSBoZWxwZXIgbGlrZSB0aGF0DQpzZWVtcyBsaWtlIGEgcmVhc29uYWJsZSBzb2x1dGlvbi4N
Cg0KDQo=
