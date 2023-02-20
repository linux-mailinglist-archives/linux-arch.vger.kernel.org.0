Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB769D687
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 23:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjBTW44 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 17:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBTW4z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 17:56:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AF61EBCE;
        Mon, 20 Feb 2023 14:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676933814; x=1708469814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=87sxogROsgOIOvh4TVupc8lCT48Kss7Lsmry2uS1YCY=;
  b=cB5WwnKxWwe505xh9em/zPLNZe0vmHIQC+XTihN+sQ1PEJsErH8oXwEM
   bEt2rEiyqsk7gyJLCd+C7L9PCB625Ept0b2ARGyhe7HLam1FkIAWYlWHU
   jCLh1F7Dag1lREo7I6mbFOgxE+CBDY7L893P1iMyv6V1i+bMZ8kJ9jGQ7
   Xs0EiV73OtwIrQmnf7DxWR8QCfVG2prWz+XSbz+VAdwKd4vE2GiBUBMaZ
   5wmTkEqMOIGrwNvUAUw6KPsTOTYGmTUUoAC1Uh8D0aLoIpFft/nok3G4L
   A3vAf8ETrEmrgCLpMgpT1cJe88v8E4d5PASXmejqvwmY57dtiIIGFi2eB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="320629825"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="320629825"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 14:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="648961940"
X-IronPort-AV: E=Sophos;i="5.97,313,1669104000"; 
   d="scan'208";a="648961940"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 20 Feb 2023 14:56:51 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 20 Feb 2023 14:56:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 20 Feb 2023 14:56:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 20 Feb 2023 14:56:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcTmLuXKveF0WZqUxce7a0VvhGMA5d/ued/IeIfzhaU8Gl0VYVkds1G2HbfeYqxc7VUlRvzTKkAOmVGUCr8+QI0FpHI2eKQXLOB0LbFk+wox2TDEkKpID3/cD5Tpq3KQRzhhlnhUNRVcJScsmWBLg65a7GKReC/bHd7eTnGFeL2itIxh3rsfDaF8y7FZP9JFKDMNijo7NODanTGzUa3DGs6nLCaS9pI4h4OuUMa+hgHiNsgxALaGR6oQApnOvHSIrBYXOigjsyD6F0Z0djtptD8fmKKVKb2TyOGjm187ZNYCl/Lb+30nzL/Kia/74ySq7veW7xnLix9FFqvkpAcJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87sxogROsgOIOvh4TVupc8lCT48Kss7Lsmry2uS1YCY=;
 b=EkYzd81cCUOclcKjdLJadxKVv8tgkYdMyYUlwI7e35nKtentNXYnqPrvl6sHlliGOkykn23Wzqa/ZFc5uZc+NFC/oW4up46IraVD/DiZyz2GMCa9wo3w7AHckfl1CStetJ1uepPpCUdHfQQEfPvQdhYBZTbr5zfupgWB07NUm8vBCJfU5Jw0OO+FKQOjqF3y2N7/XK/OZJJp7oN//ViznwIZptMQy4iHfkFZDiq2hRDD5QAr+oFenHuMCKnCe0nj/ignm4WIPguno2lJqAlZpYBJiemhAet6TOINGOp0FBE24W84Isi4l+jJsyer6zhf1BY0y2PqmDq2jg5Qhd5k1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 22:56:47 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 22:56:47 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
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
CC:     "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
Thread-Topic: [PATCH v6 13/41] mm: Make pte_mkwrite() take a VMA
Thread-Index: AQHZQ94+cYJhrZsBjUaVUuq1nj/bS67Xs8UAgADBtQA=
Date:   Mon, 20 Feb 2023 22:56:46 +0000
Message-ID: <d37fca3bc7f5c1487ea45370b7d57ab67ea2ee97.camel@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
         <20230218211433.26859-14-rick.p.edgecombe@intel.com>
         <f50daeb7-7b41-0bed-73f0-b6358169521b@redhat.com>
In-Reply-To: <f50daeb7-7b41-0bed-73f0-b6358169521b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL3PR11MB6506:EE_
x-ms-office365-filtering-correlation-id: e44e50fa-c744-496e-a195-08db1395be80
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ksQ7RIySPNQWtiqdtkozOmRxbrbYyv7MvZu26yZSDw0GbUBfz7lYo0F4Zn8YKnZtpB9xhLgdjKDKou+e0c/wQpGeJUC8TTEPE9GbCAmSKrkw7pHmMznfTx+wG2mGAymW6Lg//9F2D0Vyn4aFopXmZNvmMf99EaZmT3K3o16/PpfNtc0stT0JY0VrxKotBJ4mr3hcwVrKCsXL6vOXaA9DgySWhslFtRyaGPbS8kRRBl/zXRSfQjXHgXgUhbgG3A2QpIdse7CETdLXBjMdSY7irumRsGnexlYzK1WQj4BuwIWct/k1XrPvMHYWdjx6Dnk5O6P9fZR6vyPuQ2sj1qNtpbRP4RLcvd/cBoyamNtkbGZNXb68XYIUh6H8snPqjsz1Kr/eZ8MNkOYxjAg2P28eF1/qaEpMqO7Zsuq2fnBpzcb9d91NU9IULmzhTFl3jvza+EE4TYPkrWQGZFGe/vGdnj6wt2kpsXSGhVZOc7D1uIbaEzG27J8PaY2/itl7j6hD1IXIXgitSZTAGdsdZwIKXv1KBoCh+ewzvpyoWEilsHZZg9axv9quzuXBRVJdCcpOiwelhrKGKsoLqG24+k/5f93dSUJWWVMSUdoizgSGZp+DQQQheitHldiCFiVU3l9zqG3xuxOV3kQCpgdQkl5AyyGAJNlkZoHvuuLNWyfqaaXpLdoVgqhKDkvGwGVn+wv9jME+K9quQn6OQck48RpNBq5irUkgztFUDr1oM6u4EJi9LxK6aHZutQPgagp0kGcm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199018)(122000001)(86362001)(2906002)(82960400001)(38100700002)(6512007)(6486002)(71200400001)(6506007)(110136005)(186003)(26005)(478600001)(36756003)(558084003)(921005)(38070700005)(66946007)(76116006)(66476007)(64756008)(66446008)(66556008)(316002)(41300700001)(54906003)(8676002)(4326008)(2616005)(8936002)(7406005)(7366002)(5660300002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YW56eGRwMjJPaXZWRzQ0NkV1SFRiUGFSUlRjbm13ZVA3ejRKRlBWRktCVW5o?=
 =?utf-8?B?bnA2T1JKcnpRUVhQUGtlWmF4TDFDQVpPVis0c2NHVllBc0dlTHdZZ1hmRWYy?=
 =?utf-8?B?TWRHRm1KUGhlazQ5MzlwYkJmeFVvTXBlbTE3Y0J1Smc4azRJK20vUng2M2Nn?=
 =?utf-8?B?amQveGl0NEVzYjROSEM1QVhZenlpaTJ6L1NxRER5QkFmNWl0ZDd3R0RHVHNv?=
 =?utf-8?B?OHNDZ1BadXpnUkpCQmhWMUNFdkdIOEd5QlVNNE9GQURzWFg0MW5vSDdMRkww?=
 =?utf-8?B?Ykw3S2pNUC83a1RUdy9sc1V5N0wyTnh4NWFpbWEwYzZLZDdQYVp0cjNXbms3?=
 =?utf-8?B?VWo0QzJuNEYzWG1LTWtCdVdiZlRjcXBRTUs3VnNWUWFmNC9yM094cWFMOFY3?=
 =?utf-8?B?MjROQ2xlU3NmT3c5QmUvTVFrbUplaEV4ZXg4d2JiNDNxZExKWG4zOG1OWkd0?=
 =?utf-8?B?ZHVYalFjZ2w0SkVuc0lrVWxITlAzUHpXY1p6MGl0NDAzS3Z1Qzk2dUZGNHVi?=
 =?utf-8?B?cGF5YTZSdUdwazFaSlFWdFpyeS9yY1IrM1UzRU9FQ0gzRVY1RTllQUpMRkFt?=
 =?utf-8?B?bHlBRWlhYXRWVVFSd0M1RnNhbnNLTzlFcU5hdDFlTndGVjltMS9jWXFOSlZs?=
 =?utf-8?B?b2JtYjhWWnBiancrSmcyRDdpSWtoWnZyMjhWMXEwRlllNEtaTmt2MmI1WlFB?=
 =?utf-8?B?NllSakM2MFRiU1paUXB3RUhqTGUwS2RtV1ZRZGo3Y2k4VTBTVWpqemtONUQ2?=
 =?utf-8?B?amtoUitIUG1zYWxNOWVzcm0vRnRkUE5zczFPNGNjZ2xOd3dDM0pDY1MxYmJi?=
 =?utf-8?B?dk14WEJzOUd5MEZla2k2eXFSdFpLR2ZuWUwrdDdLNmtWb2cwNEd4SnJ4a1RZ?=
 =?utf-8?B?RDRtUTg3UjR3SFdJOGRqYXhvMm5lZzkxdEl1OUJBOHRnK2JJbGFkNWk2Z1lt?=
 =?utf-8?B?S2pkTXQ3MmNBYVpHT0JwbUVLU2lrVFlVR1RqOVJ3KzJqUzR5M3NRQ2oyN2x5?=
 =?utf-8?B?RUVQYVl5NG43aDd2L3hoWitqMTdZOVdXd1JuWWtVVXVIU1BQRkIyZUpaNDZO?=
 =?utf-8?B?b0NmRWJmMEoySzZwRmFsamFUZ096dTlPWGpTamFUZmEzR082eE9McjkrZllM?=
 =?utf-8?B?c0t2MjRMNzZBMFYrVWNqcy8wNk9iT3JsbjBoUDFCdTFpWjRoUGozU1ZuUjBm?=
 =?utf-8?B?c0l2SWZjSktnMkw0UmFSL2xINUcrbFd0Wm9TMWRwQVlFQXZiSnhwTHZpUSth?=
 =?utf-8?B?SUZ6R1RRbW9FYklRWVpsUmR2NXlzOGdKVTIyL0h1S2FuZzQycFVGckdsZHlY?=
 =?utf-8?B?bk5zQjRtQVVvSTRIMXRiR29IRmRaWGpJaEFIV2ROelp2NDVvb2dFM1JVR01J?=
 =?utf-8?B?TmVyT0NnYnc5YUUwSVhkRWE2alZ5QTlJZW8rbXNMdk1xUkwySXZrbEErd2ly?=
 =?utf-8?B?d0hWeXdJZHAwZWdEdkFoSCs4YW5vUEtKUllsb2xPaVU3WnJGMmc4U3ZuNmU2?=
 =?utf-8?B?Q1FkREc5ckhjeUtXN2IvaXh2d2NsNS9HZzFjTXJLVGxkcUtyVlkzOUFuVW9i?=
 =?utf-8?B?MTdQbDVaTmNuUVJMNFIvbngrSkZETDZ5VUpMYW1iaWdiQkZZMGlVaUFiajkv?=
 =?utf-8?B?Q2VKUHA3eHovMmdjYnpZVG1xeDFWNWhvdnNiZmV3R2JNV3FjZnA1bTJSTDVm?=
 =?utf-8?B?d0g0cmdlbWlxa0l3dUdJT0ZmaGJlWlNFZk1PNkZiaFV2SEQ5bm5CaEdlNnNj?=
 =?utf-8?B?WHNFdFNvVllPT3lPUERVcE5IUVVncjg2NmpJU3o4U3k0Zm9qdm81T3ZvNll0?=
 =?utf-8?B?MkVVY2FrYUdUVWhsVmtmdCs2NTZSdDhFbGpldkM4NTVOSjZkY29uZ2lWcy9M?=
 =?utf-8?B?NlQrcXZNMEppZHh4S1pRSm5oeUxZQTd6WTdaekNkRDJTYzh2YUt0VjRsb0ta?=
 =?utf-8?B?RTNFOUdXbzdmajNYQTJJSXVlVkpsalhUQTZyTng4di9aVEtQK1VhWkJzTGFP?=
 =?utf-8?B?VGpzREc2OWtCMmJQdkMxVy9xakc0NWZZWE9vWW1icVVvcWduQ3JQVWdTTUI1?=
 =?utf-8?B?SmtPVEhINW1Nbkl3OCswOUpFaHVSc0RjMU1EVmNtMzFEaTRkZU1XTFV6U0NR?=
 =?utf-8?B?OEhTeWhGQ3RDVVV4eG5Ha2lBb0lrRG1nV0ZBYkNYTmhTaTNRVVhJc3lydk5h?=
 =?utf-8?Q?jOiiC3V+rt/XwEVkOa/vMqQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23B918A044316A48BC65B5C98C4B680C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44e50fa-c744-496e-a195-08db1395be80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 22:56:46.9900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IO8b5p75DKogOcIKA0BCZfvD12QKviBW5V3yC9aiMleQN4Ofh9+wjy1xmbwCu0fZfCTp9uz7T5Nm0+W8BUZhH1HMjs6i6gsXQlPwVFHg2WI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDEyOjIzICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gVGhhdCBsb29rcyBwYWluZnVsIGJ1dCBJTUhPIHdvcnRoIGl0IDopDQo+IA0KPiBBY2tl
ZC1ieTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQoNClRoYW5rcy4gWWVz
IGl0IHdhcyBub3QgdGhlIG1vc3QgZnVuLCBidXQgSSBhZ3JlZSAtIHdvcnRoIGl0Lg0K
