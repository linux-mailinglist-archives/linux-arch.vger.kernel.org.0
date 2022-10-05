Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C545F4D58
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 03:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJEBWG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 21:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEBWE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 21:22:04 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Oct 2022 18:22:03 PDT
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A874223140;
        Tue,  4 Oct 2022 18:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664932923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o6cmc+e6N23bZnWck/DVagiYjNG+ZEEJgOFB1QSyCgM=;
  b=cDMyxG93tXUUJzt2h9/9rFxofMZhKiyGDUjKBaFbMlTHVT0IjZOoOu54
   BnVyLMT8RHG33UT/cHwX2k4+l3gh6VxoQnmD0kGoU/7/HmmlClMRebqM1
   43J02FDPnFnGeG/dtVJzNamu5IvgpyIvQ7CCFd3/jHkNKARouaigl744X
   8=;
X-IronPort-RemoteIP: 104.47.56.44
X-IronPort-MID: 81113174
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:STQwMqxT+2v3y3py80V6t+f3wCrEfRIJ4+MujC+fZmUNrF6WrkUOx
 jceDD3XOqyJazf9eoskO9/g8BwDuJWHztVrHANrryAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHPykYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFtspvlDs15K6o4WtA4gRiDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw9cxLM0pl5
 9wjLHMPNAy/tdipnZWHc7w57igjBJGD0II3nFhFlWucIdN9BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI++xrvwA/zyQouFTpGPPTdsaHWoN+mUGAq
 3id12/4HgsbJJqUzj/tHneE1raWxHiiB956+LuQ+Oxog1SPhTIvJ0cwV2OmjeO/gXS7VIcKQ
 6AT0m90xUQoz2SxT9L+GQX+rXKLsxUbXtBdO+w89AyJjKHT5m6xBnANZixQdNs88sQxQFQCy
 lCNj/vtBDpyrKeST3ONsLuZxRu3OC4aKkcYaCMERBdD6N7myKk3jxTSXpNgHbSzg9ndBz792
 XaJoTI4irFVitQEv42//Fbak3egoZPhUAE4/EPUU3ij4wc/Y5SqD6Ss6F7G/bNFKa6aUFCKv
 z4Dgcf2xOQPC4yd0SWXS+UlAr6k/bCGPSfajFopGIMunxy9qyCLfo1K5jx6YkBzPa4sfT7vf
 V+WsBtQzIFcMWHsbqJtZY+1TcMwwsDIEcn5UdjXY8BIb5w3cxWIlAlkfk+W0GDkik82mIkwP
 J6adYCnCnNyIa5/5DOyRuobgfkny0gWymTJTo39yAqP3r+XZXrTQrAAWHOCZ/40qqONph7Y9
 f5bNs2X21NeVvHzZm/c9ot7BV0RPGITH536q8VLMOWEJ2JOFn4sCvrc25s7doBllrgTneDNl
 lm0QElU4FPlg3HNbwmHAlhjarepQZF4qWkTMiklPFLu0H8mCa6t5aEZd7M4er4o8OElxvlxJ
 9EOfN+KD+hnTivBvTIQcfHVqY1heVKonwuQMja3SD8ldpVkSkrC/dqMVg3m+CAQSCOytNcWr
 Lip1wedSp0GLyxlCMvZQOiiw1O4oT4Wn+cad1PBPNRXUFjn785hOUTZlvIrLtseARTFyCGT2
 wufDVEfv+ali5U57d/NjLisroGnCeJyE0NWWW7B4t6eLyDE/yy9h5RAWeCLdCr1VWXo9aHkb
 uJQp9n/PfAcl1FNsKJ3E6xsyKMj4p3ovbAy5htpHXfKZlKkTKJpJHau3M9Tu6kLzbhc0SO0X
 UuIvNxdI7iIIsrNEVgNKQ5jZeOGvdkWnTnUq/0xJEj8zCZy8PyMVkA6FxqHgwRSK7x6NI5jy
 uAk0OYb8QW5ixMsGtmBiS9Q+iKHKXloe78/ro0yA4LxjAcvjFZYbvT0CCbz54uVas5kNkgsP
 y/SgavJnbNHwUTeNXE0EBDl0edBhZMLsThPzVQYIE+OlMaDjfgytDVS8C42SgAT1RVaz+92P
 XZDM0xzOLXI/jF0icwFVGepcylQGViS+kH3xB0YiUXYSVWlUirGK2hVEeOR/wYc+mREdzdW5
 5mXzW/kVXDhe8SZ48cpcUtsqvimQdkq8ATHwJqjB57dQ8V8Zif5iKizY2ZOswHgHc46mEzAo
 69t4fp0bqr4cyUXpsXXFrWn6FjZczjcTEQqfB2r1Pph8b30EN1q5QWzFg==
IronPort-HdrOrdr: A9a23:zr2MoKGff8cZz5ZupLqFFpLXdLJyesId70hD6qkvc3Fom52j/f
 xGws5x6fatskdrZJkh8erwW5Vp2RvnhNNICPoqTM2ftW7dySeVxeBZnMHfKljbdxEWmdQtsp
 uIH5IeNDS0NykDsS+Y2nj2Lz9D+qjgzEnAv463oBlQpENRGthdBmxCe2Sm+zhNNW177O0CZf
 +hD6R8xwaISDAyVICWF3MFV+/Mq5nik4/nWwcPA1oK+RSDljSh7Z/9Cly90g0FWz1C7L8++S
 yd+jaJp5mLgrWe8FvxxmXT55NZlJ/IzcZCPtWFjow4OyjhkQGhYaVmQvmnsCouqO+ixV42mJ
 2Vyi1Qf/hb2jf0RCWYsBHt0w7v3HIH7GLj80aRhT/OsNH0XzUzDutGnMZ8fgHC40Qtkdlg2O
 Zg3n6ftbBQERTc9R6NqeTgZlVPrA6ZsHAimekcgzh0So0FcoJcqoQZ4Qd8DIoANDiS0vFkLM
 BeSOXnoNpGe1KTaH7U+kN1xsa3Y3g1FhCaBmAfp82u1SRMlnwR9Tpc+CVfpAZFyHsOcegD2w
 32CNUwqFiIdL5PUUtJPpZHfSJwMB2XffuDChPJHb2tLtB7B5uEke+K3Fxy3pDoRHVA9upNpH
 yKOmkoylIaagbgD9aD04ZM9Q2ISGKhXS71wsUb/JRhvKbgLYCbeBFrZWpe5PdImc9vdPHzSr
 K2ItZbEvXjJWzhFcJA2BD/QYBbLT0bXNcOstg2VlqSqoaTQ7ea/dDzYbLWPv7gADwkUmTwDj
 8KWyXyPtxJ6gSuVmXjiBbcVnvxcgj0/I52EqLd4+8PobJ9frFko0wQkxC098uLITpNvug/e1
 Z/OqruluehqWy/7Q/znhFU09pmfzNoCZnbIgB3TFUxQjLJmJ44yqWiUHEX2mebLRliSM6TGB
 JDpj1MiNCKE6A=
X-IronPort-AV: E=Sophos;i="5.95,159,1661832000"; 
   d="scan'208";a="81113174"
Received: from mail-dm3nam02lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:20:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNZLIlaCJD/eZMm6B5+4gM/qd71X4afgb7ogSIloX/+79JGx7YiLvAEFnNPzA+N7e4p2uW6P2q7pZX5Z7cAHq2khR86KNSYrWiCPQHGhG3drbTzl/0XSOaLMRohMNMShTLNnKpZAIM0cU1nq8O/hgYbmyhGx66rG/qpB8N4MDvOAqY6BUA3gqu+qhFizLXfD87ciCeXV6HSMTgpdNOL+mZjKb/ePgtUI+U90CzX+L26vPbDOzqqSv6OZn/ta/yNvNGfB99AzvtgqJgVEtSnMAjciAz4r/Xk4jhIRdodFpEFAUfKfHHSoRXBd7PIuv4HXhX+q+E0QhJf+A38fyEmK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6cmc+e6N23bZnWck/DVagiYjNG+ZEEJgOFB1QSyCgM=;
 b=G0Gk5Ffgk1C2vZq5zA0B0yqR4SWiRmXadkJ/emXqf/Vz0GS42wXfGQUNDR5PicoBXmRiOtVslzx1XL2efpOOH/G6WSP5R4znz7LkY/jMabK7xZVIWaXWxbq5vk51khzT3/nuXbvkoQI2eAoRrc89jxdVE4VRnBMPfrQs/asZwTaDWBe30bE9zONlTRR3qGI8v39aoCy5UN71IdNdbYmzJgAu+/UQH4JgKHHwrKk5QrUfXtRdvF4EHp2h4fzjtH4gLLMaGszZ2IQ7hrQgRDnb9IukKKY9HrYwo335fntD3ewlT/UJn3t97RGv0UGaOGr3nyhT2xU329btFJNWsapq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6cmc+e6N23bZnWck/DVagiYjNG+ZEEJgOFB1QSyCgM=;
 b=mtprNvwHVTNPYMrBz740h+D/eCvr7aFFz70Jbfh9yxf8Foe1NTQTLeXgooOybVY8FuI1caHwumnQhK7paZM7Hu2X38/idjcaK2ULAnzHjIA/VSHVqv5PS8GYqb+IVkVCmS9rRAitaceoLFgOAWhv1FYM17yT0xRbFJvIK/R6QTU=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CO1PR03MB5732.namprd03.prod.outlook.com (2603:10b6:303:97::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 5 Oct
 2022 01:20:52 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 01:20:52 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
CC:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Topic: [PATCH v2 07/39] x86/cet: Add user control-protection fault
 handler
Thread-Index: AQHY2EQAHAMjJxI9oEaOieFpwC0WU63/AOGA
Date:   Wed, 5 Oct 2022 01:20:52 +0000
Message-ID: <55592df6-a138-4995-5b2f-3720bedccf50@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-8-rick.p.edgecombe@intel.com>
In-Reply-To: <20220929222936.14584-8-rick.p.edgecombe@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|CO1PR03MB5732:EE_
x-ms-office365-filtering-correlation-id: b514f683-0505-4d7c-54ef-08daa66fd814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUQH5N1SRDZAhhcsy1sD9ds5jqMNlpLRVlX3Qr5PmE7ax/RVk/mVJlkCUy5NMMCp6v+ZAh4mWFoIcQdc09tCMUJs6khsU8SwWLpkpPmqh0r7GmhBN4DmOBHzQgvSRs1istY8ZYpN4cdlXW4D4Kqbakl9PW//x5HKVSyOPpJkkYFDNM2JNQUJcI5xmVQvACF91Ml7Pk0MbR7Gv7kVevEy47p8rLhvyNL+/BKb6eJykSyKwbzw2vccYeS1cK7aBr6ffn/p0qZcj2DHkRdscUSFaQXaq2tMbGNtvhmvQsdQdTF1vuKXJHSZdZtpv46cxZds/dFpVrJpjU6vGHbDP1NQqiHPL3jdm52bvjDZ/GLbc1BkoM2wEnQH1sLl1XE6I/JyDD8vKgHslScbIlbDuYYpHrhoYlhrsn632FWbZYA7FHXrq3x2BLw9E1jB/dfHTDoRpc5BcFu8sWyLxxu0lg6ww8fynT/gTTnWCvA9kmxT1tSbtTRRKp2DQyAFxmEZV2151sCfX5p6UkYwuW3ggolTc47KbDGcncc7J+Nu67gYIgVy7TdOBC/pubagXe8N21LezBwoF35fssJzRMMFZe1qsVKPMTlYxbi8JDFD/vPy6eEkjcCoxCRSh4NTw9sszWv05BaGgzAIUheqH/hwaDDsVMwF4vkthWEZikOGMpKmflQJ/JyQKkMc4nwqdBsuqByHPaJNKyzBQIQaT4XIwgK2NEQ+lI/Px4RIoPYdtgkK8fQlSmU8piiRPeEVrPQ+FRTtG6VvRVuvS0STBA25BzRl87BKugTZpb0TexA2JUtoK+cbv2oq+uSWMTDYZyTOfDtFqmkiUcwOVzkHhDPhUnCOAw8g6euRkioS69jY7Pxpe6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(66446008)(316002)(38070700005)(186003)(83380400001)(38100700002)(2616005)(82960400001)(31696002)(122000001)(921005)(7416002)(7406005)(5660300002)(2906002)(4326008)(41300700001)(8936002)(6486002)(26005)(478600001)(6512007)(6506007)(71200400001)(66476007)(86362001)(8676002)(64756008)(66556008)(66946007)(91956017)(76116006)(53546011)(110136005)(54906003)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enhxN0ZuU0YwTWVuOFZabFNxeU9yc1VQc29Cblpra0tkNS9KWFdENU82cXFu?=
 =?utf-8?B?V3ZyK1JHUk85Rzd6K2xISTVyeGV6UWRWMVhLRzRBNjVCQllyWXVUNy9TaDNB?=
 =?utf-8?B?bnI2RW5YNjFoR1FuZ0plUWZicWdUeVdsbDU4MkNENXUyU3VYNm9ZbXJGanRq?=
 =?utf-8?B?K0QxZGtSY1FSOVF5S1ZhUzR5dW9WWW90Rm9GazU3RmtrWjV4UUQxdDlVNGVI?=
 =?utf-8?B?azZxZTlCaW1LaGhvZ0NkR1d3RnVDdnJRNWFEdThNTys1VXJBdnYwZDdtU3FK?=
 =?utf-8?B?MlR5Z0VjbWZROFZLYkU1Z3FuUzJQc2RWZ0hpRnBaY2RsMGNaZjRZLzI2SFpn?=
 =?utf-8?B?QkNBNjBIbGtOditaU0RvWDlxcG1jNmxUaG85RE5UZVpkS0hJVkZMS0xiUUYw?=
 =?utf-8?B?NVZrWFQzRWw5aWc3ZEp4RUpNNVdYbzluaExiNTc2RjRHVlZHaCtyaEUwb2ZX?=
 =?utf-8?B?UGJuMDdkblhHSmE0SHdzUVl0bjd6anVyMk83RDZVZ1FGenRibjhvKzhhdENr?=
 =?utf-8?B?bTdWLzYvNm5DZ25FUnltVXNDcW5VQzN2anlMZXdaWTVEMDhvMnBmaEhaWWd0?=
 =?utf-8?B?NzdqZDgreTk2dW1icFV6Y0VtZW45Wmw1djVqUkk4bUpMMUM1bTRXMHJPenlB?=
 =?utf-8?B?dmorZGpVMFlUQitlcTA0UFBVT3Y4NE5YMmhGLzVVS01lYVZScGc2RXZkekFZ?=
 =?utf-8?B?V2J6VmhxT1FZaHJWODVjZVdqVHkyNXZEL2hOK1Jpcm10NFl6anlHUENPMHln?=
 =?utf-8?B?VmdBaU0vWThnTnk5andVTStKb29NeGJyc2NORXU2a0JjZ2hWZGt1WnVXUWlw?=
 =?utf-8?B?NllxekFlaWdYZVo3ak54S2F2ZE44RzkzS3c4UHM5NnJTZTlzS3lTZkpsVHRt?=
 =?utf-8?B?eERVejJ5L2psS2p6NkZYZE9ZWlhHbXhIT1NEckVnd08wOHhSL0xJd25zN0JS?=
 =?utf-8?B?ZTRaS0Q1V20wMXB1VzN2ekl4eXRJVW5NNTVnQk5oNVFrbEJleHdUakxDK2s3?=
 =?utf-8?B?Ry9TdkU0R3MrK2UzZVk2amxUUjFTRkpuNXdqWHpNRHFNWi9CM3U0ZENIZTI3?=
 =?utf-8?B?cm1xd2JCOVp2SjhSNGNWZ0hGYThLWm5sMDlGRlZLc1lsVWpnMVBadmVaSU8r?=
 =?utf-8?B?cFFFWnNHRVZzVHFVUlVPY3lMTDd2STJoSVFmMTRnMWU0dnlNNDN5a3oxbnEz?=
 =?utf-8?B?R0FrbjY3cThseUhZbmxka2lRMUZpdjV1TW83N21GTnppdFZQV2NCUWh0Rlg2?=
 =?utf-8?B?YldRU2sxUGYrREIyZjBJNkxrQXVEclkxZmdaek1lMG1nZ0Y4KzBmZTJzZWNx?=
 =?utf-8?B?SjBDajdjNklrKzlFT0swR3QzblY5OXdoQkRtcW5lc2xLbm9KbzNDVkF1aEtH?=
 =?utf-8?B?YWJDN1E5d3NTR1ZxSlMvRzlFdG8zWm10VFY0UXUwR1pnS0NlNW9FeFNWUmRI?=
 =?utf-8?B?aWhkc2pRekQ4TWkyUG1MVm5aM1hPZXRjZDlTTmhoZ24vd2RhS09vQ2Y5S0ZE?=
 =?utf-8?B?Z1dXYzM1SWF1VlBLREpleE9kNGhydTZucGlvbTdIRTRxcVI1VExlL3BpY2Rm?=
 =?utf-8?B?L0s4YzU5V0s1aXFkRDRSOE5jRlNKdU9aN3Y3ZE03UVVnV1Y1eFRZR2k0ZFhW?=
 =?utf-8?B?bzcrR3BnRGdvcjhuUk1XcFpqVVVYYTRvWXhQUlZIalBLZnpvc2Y1cTBPVVpl?=
 =?utf-8?B?dlpYazZSVEdGeUc0Unh1Q1NKczJzMm5JOTdMdG1BOWlyZk1JQituaCtUNWVw?=
 =?utf-8?B?RzNWUmVDakk4eFhKRGZEbjJib2Z4QlhWRGFycjJtTkQ3YlM2QWVGVlBPc1ha?=
 =?utf-8?B?d0s5UzZLVTFGRCtpTzB1QUZJTTVqMXRDRlR5REl6eFRvNFkyTXBnYjBTYTVz?=
 =?utf-8?B?TG9waWMwaC9IZlkxcnlEK243Nllkd2JlNG1GNzNUS2xOcTZPc09FR25RRi9n?=
 =?utf-8?B?eTZiOGJseWZ6TXg3aDdFak5DUGpFaWI0R3NJcmtDTzJ6VnhvUG11eEd2N1gw?=
 =?utf-8?B?TE5iMDNXVjZwZXZhNkcxNFdZRmMzQjJNUEQzdlpzejE1T3B4S0owZ2xtUmhy?=
 =?utf-8?B?eTRMc2JwbGJodzFhOGd6SWNQazVxVSt6TGY4N2RGWmVaS004U01UTDF6YUVq?=
 =?utf-8?Q?B4S61VkIQnbq/ROx3jX1sjk/S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E2003332C4F6441A1E692745BD199E2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NGZtMEs3eUJ6a3JOR0t0bUUybUlHYU1xRzdCZkRHVFRva0IvWWNtMUR3Wlc5?=
 =?utf-8?B?YkwrdXZPRmUzTFVnQ2dGaTdsYTU0dkhXa1R3eUpYSXk3bWY0cGxlQWR2T3NR?=
 =?utf-8?B?dFZsd2NCZTFXOWFNcDdtVkoyUU5XM0ltVVVBTGRQK2tkSk9iU3MwYmhFV291?=
 =?utf-8?B?eFl3NXZZdW9wdFZyOXpkK1krZ0dVNCtGN2hIZmdWOUd2RjBadWtmdDN0cGM3?=
 =?utf-8?B?Sld6SU5NNDIxQit5dlpFTDNRVzk4VHFtMGFjbDVYeUpyQmRtaEZQUzF6dnBM?=
 =?utf-8?B?TXZQQW01cWd1OFRoVzNKbHRDWWt2NVg1TmJsMUY3Z2NOUk1DYVB2NS9ONmNX?=
 =?utf-8?B?SnpSRndGNEZZOXNSV0JoUXAxbUUzOTRaRERxWlVWbjcvTmhMN0R0RUxiVjNH?=
 =?utf-8?B?QUx2amhtcXNPK3poY1dNVVQxYnVBbzBHT0xQNjZUa2lxb0RlTlI3SjhWL3Q0?=
 =?utf-8?B?YWVwOXRRY3UxTy9jbDZvMlZNTkViM2dPRzZ4R3IvWXBxcG5XeWlrZENLYlEx?=
 =?utf-8?B?emg1d0VITENkZndGaUhNdEdVa2p5TXQ0ZzRXdlc5eklZSzduUkVjMEZZbGVZ?=
 =?utf-8?B?b1U1ZzVRdjk4eG5vNWNwR0RiQU1wTTF1SmRaY2x3TEZBRGdBOVl3VHplRTVz?=
 =?utf-8?B?Vm5JSzZVeHNoVDFpRmtMMHgxY3E0dmtUSDlvaHJSamhPN2tEamNYanQvWVd3?=
 =?utf-8?B?YVZCUjJWUWhSNGFzOFJJMGd1V1dIUm5YYmg3TURrZGk3VDk3UW56ZVJZeG1o?=
 =?utf-8?B?Si9IaXR5ZWFjRWFQZFF3Y0crQzhZRGRNQjVmbUlhUEdQck9VdTFYaFA5alZN?=
 =?utf-8?B?Wmc0OTg0akZVL0dSR3YwcGp3SG1OYVZBc2M5ZGMxeEd4SkE4WFJXRHdvMGpk?=
 =?utf-8?B?UUYxZTRvbWZubkE3enF4cnN1RFJ1aVBEZCtvNDRKc0pjRlc0emlNNUI3c0tI?=
 =?utf-8?B?L043ZGdpdWR2bkQvODBZNzd3d21SMXhJb1Z3RnhNZFBaUStLdWFXN3o4YWpa?=
 =?utf-8?B?TkpvZ0lLSVpzQ1dXeFE3VFluNm5RMXV6d3dWQWdseXZQdEhTYVpwb3owTk9Z?=
 =?utf-8?B?dm9wNGhDU2g0RlpxbU5FdU42bW1qTDlYNTdPWXFKaW1KQnl5ZnRNMWpvcmI4?=
 =?utf-8?B?enJKTTVOQzA4N0Z6S0kvRlRNdmRiSnd5b1BKLzdIZkI4QW1WUGYvZmNaT0k5?=
 =?utf-8?B?OG9zakJYai91SG5PV2ZtWWZhRGM4OEZZZUZrMFRjWDF1b09NSHNlYW9QcWVB?=
 =?utf-8?B?eUNVbUtqR2d6cVlOQU1kS0FvdUtCTzlOYUlSUDltMVdqMXNmRXcrVXFSaXRq?=
 =?utf-8?B?YjMzWExrbkM3YU1mY0M0enFLRHViRUNUR3I1YXdLdjI1K1E4MHFCTEtkeTdL?=
 =?utf-8?B?Ty9ZVnArNGhpUytYNVpzNk42UmNWUU5OazhvZ1RCaDlDWGVhUisxb2lmWU9H?=
 =?utf-8?B?RlNOUXRwTDZFZUo3aE12bXk1UURLVE9nekxIMWNNMGdXWEJDejJBV1VmUnN4?=
 =?utf-8?B?SlVxYWF4YkI5Z3RXMndXZFcvL1hXUVVCSmRYcHFNcitBMHRPSWlTYVVONit3?=
 =?utf-8?B?b3dWT3ZmK3cweU1tTDhXUzVQTVlxeHBRTWo0ZmZRTktORXM1RC9VOXo5K0g2?=
 =?utf-8?B?S2RNcEFyaFpDWTlXOWhvbXJUY1NUVWh6UU5zdDZsc09yYktrNzlzYmVodkxw?=
 =?utf-8?B?cEM0aTJBR1lvWGF6VC96Tm8yaE5aT1BORGNwR0FrYm9xb01kVVMyWHN0TmZt?=
 =?utf-8?B?OXJaZ0cxRm1YQlUwVFR5NEY0VlY3bTVOQ3hFTVRET2RhZ0JyUHZFRU9rcTJV?=
 =?utf-8?B?bEpUNm5ISW5oRWFxcWEwdzNsS2lROCtodDY2QzVZM1VMZmQyNjUzb29QVVJj?=
 =?utf-8?B?OVA3WTlJaDg5c1MxUzc3enNOOW00QkNRTlg0a0o5VUJsMVJaL1J6RjRudlJL?=
 =?utf-8?B?TXhkY2tvL1FPblJNVUxkL1k0WVZzQlFoYzBhU2pnYlUyRmtPT29RdTNUQ3Ba?=
 =?utf-8?B?RUxNdzRQdDhQZW9yaFcxKzBJcFljZVpXdURmcUJwWng1dytYZDR2YU9wdmlR?=
 =?utf-8?B?QTloM2lReXhydnVvU3FFdWs2RWJrUTFFalBFY0dEVUtrNmVxQTN2amNNU00y?=
 =?utf-8?B?V1NnWkI3WjdxZFJwMWgyY2pRSmoyYkpud1F2aVN5WUJXNlRvSnh6Y3lFWU05?=
 =?utf-8?B?czY2ME1UT0h3OEtlaVhNdW9iSmRWUUtoUG4ramxidVpnbkhENUhSRUdaVjMy?=
 =?utf-8?B?SExRRkc1Z0hmalBIM2llOGE1M3NpWW5MQ0txaVNqMTh0SzR2S2llUWJjK3F5?=
 =?utf-8?B?N1RCRFRZdlh1OVpVNkxWRnUyMncyVE5WWlMrQm1iOEVxZG56OFByemVsV1dn?=
 =?utf-8?Q?bilbDcyoLWbnzYlcGL7STStYRoQCnffyHVEnj3EckfV+5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: hSfEDifEIbEFoJvPTGDDKLR+HdqS34Wj14X2jX1vknWecSLLsJV3tfiL0eQd2Uga+08IwUa5ms84bYHA3h7JS5tqz9bbminnMT/TZC6hvfonsjznMCQ1P36cTTFHqwudGW41YDAeTEqNg49kjcb3zhfs9omFz0qdStJ1dqVwNrX8GAWCdBPsWrm8
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b514f683-0505-4d7c-54ef-08daa66fd814
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 01:20:52.2513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvNWqoeL/ze41mFMIgl/U7u/x0tEYmlPCzOriPhahGOJq8fI+6XyEgN8H03SiXaljAvuxcXs3EXoSwPW8Ph72bVrCBA2eS8srLOFBOorj/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5732
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjkvMDkvMjAyMiAyMzoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYyBiL2FyY2gveDg2L2tlcm5lbC90cmFwcy5jDQo+IGlu
ZGV4IGQ2MmIyY2I4NWNlYS4uYjdkZGU4NzMwMjM2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9r
ZXJuZWwvdHJhcHMuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYw0KPiBAQCAtMjI5
LDE2ICsyMjMsNzQgQEAgZW51bSBjcF9lcnJvcl9jb2RlIHsNCj4gIAlDUF9FTkNMCSAgICAgPSAx
IDw8IDE1LA0KPiAgfTsNCj4gIA0KPiAtREVGSU5FX0lEVEVOVFJZX0VSUk9SQ09ERShleGNfY29u
dHJvbF9wcm90ZWN0aW9uKQ0KPiArI2lmZGVmIENPTkZJR19YODZfU0hBRE9XX1NUQUNLDQo+ICtz
dGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGNvbnRyb2xfcHJvdGVjdGlvbl9lcnJbXSA9IHsNCj4g
KwkidW5rbm93biIsDQo+ICsJIm5lYXItcmV0IiwNCj4gKwkiZmFyLXJldC9pcmV0IiwNCj4gKwki
ZW5kYnJhbmNoIiwNCj4gKwkicnN0b3Jzc3AiLA0KPiArCSJzZXRzc2JzeSIsDQo+ICt9Ow0KDQpU
aGVzZSBhcmUgYSBtaXggb2YgU0hTVEsgYW5kIElCVCBlcnJvcnMuwqAgVGhleSBzaG91bGQgYmUg
aW5zaWRlDQpDT05GSUdfWDg2X0NFVCB1c2luZyBLZWVzJyBzdWdnZXN0aW9uLg0KDQpBbHNvLCBp
ZiB5b3UgZXhwcmVzcyB0aGlzIGFzDQoNCnN0YXRpYyBjb25zdCBjaGFyIGVycm9yc1tdWzEwXSA9
IHsNCsKgwqDCoCBbMF0gPSAidW5rbm93biIsDQrCoMKgwqAgWzFdID0gIm5lYXIgcmV0IiwNCsKg
wqDCoCBbMl0gPSAiZmFyL2lyZXQiLA0KwqDCoMKgIFszXSA9ICJlbmRicmFuY2giLA0KwqDCoMKg
IFs0XSA9ICJyc3RvcnNzcCIsDQrCoMKgwqAgWzVdID0gInNldHNzYnN5IiwNCn07DQoNCnRoZW4g
eW91IGNhbiBlbmNvZGUgYWxsIHRoZSBzdHJpbmdzIGluIHJvdWdobHkgdGhlIHNwYWNlIGl0IHRh
a2VzIHRvIGxheQ0Kb3V0IHRoZSBwb2ludGVycyBhYm92ZS4NCg0KPiArDQo+ICtzdGF0aWMgREVG
SU5FX1JBVEVMSU1JVF9TVEFURShjcGZfcmF0ZSwgREVGQVVMVF9SQVRFTElNSVRfSU5URVJWQUws
DQo+ICsJCQkgICAgICBERUZBVUxUX1JBVEVMSU1JVF9CVVJTVCk7DQo+ICsNCj4gK3N0YXRpYyB2
b2lkIGRvX3VzZXJfY29udHJvbF9wcm90ZWN0aW9uX2ZhdWx0KHN0cnVjdCBwdF9yZWdzICpyZWdz
LA0KPiArCQkJCQkgICAgIHVuc2lnbmVkIGxvbmcgZXJyb3JfY29kZSkNCj4gIHsNCj4gLQlpZiAo
IWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfSUJUKSkgew0KPiAtCQlwcl9lcnIoIlVu
ZXhwZWN0ZWQgI0NQXG4iKTsNCj4gLQkJQlVHKCk7DQo+ICsJc3RydWN0IHRhc2tfc3RydWN0ICp0
c2s7DQo+ICsJdW5zaWduZWQgbG9uZyBzc3A7DQo+ICsNCj4gKwkvKiBSZWFkIFNTUCBiZWZvcmUg
ZW5hYmxpbmcgaW50ZXJydXB0cy4gKi8NCj4gKwlyZG1zcmwoTVNSX0lBMzJfUEwzX1NTUCwgc3Nw
KTsNCj4gKw0KPiArCWNvbmRfbG9jYWxfaXJxX2VuYWJsZShyZWdzKTsNCj4gKw0KPiArCWlmICgh
Y3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9TSFNUSykpDQo+ICsJCVdBUk5fT05DRSgx
LCAiVXNlci1tb2RlIGNvbnRyb2wgcHJvdGVjdGlvbiBmYXVsdCB3aXRoIHNoYWRvdyBzdXBwb3J0
IGRpc2FibGVkXG4iKTsNCg0KU28gaXQncyBvayB0byBnZXQgYW4gdW5leHBlY3RlZCAjQ1Agb24g
Q0VULWNhcGFibGUgaGFyZHdhcmUsIGJ1dCBub3Qgb24NCkNFVC1pbmNhcGFibGUgaGFyZHdhcmU/
DQoNClRoZSBjb25kaXRpb25zIGZvciB0aGlzIFdBUk4oKSAoYW5kIG90aGVycykgcHJvYmFibHkg
d2FudCBhZGp1c3RpbmcgdG8NCndoYXQgdGhlIGtlcm5lbCBoYXMgZW5hYmxlZCwgbm90IHdoYXQg
aGFyZHdhcmUgaXMgY2FwYWJsZSBvZi4NCg0KPiBAQCAtMjgzLDkgKzMzNSwyOSBAQCBzdGF0aWMg
aW50IF9faW5pdCBpYnRfc2V0dXAoY2hhciAqc3RyKQ0KPiAgfQ0KPiAgDQo+ICBfX3NldHVwKCJp
YnQ9IiwgaWJ0X3NldHVwKTsNCj4gLQ0KPiArI2Vsc2UNCj4gK3N0YXRpYyB2b2lkIGRvX2tlcm5l
bF9jb250cm9sX3Byb3RlY3Rpb25fZmF1bHQoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ICt7DQo+
ICsJV0FSTl9PTkNFKDEsICJLZXJuZWwtbW9kZSBjb250cm9sIHByb3RlY3Rpb24gZmF1bHQgd2l0
aCBJQlQgZGlzYWJsZWRcbiIpOw0KPiArfQ0KPiAgI2VuZGlmIC8qIENPTkZJR19YODZfS0VSTkVM
X0lCVCAqLw0KPiAgDQo+ICsjaWYgZGVmaW5lZChDT05GSUdfWDg2X0tFUk5FTF9JQlQpIHx8IGRl
ZmluZWQoQ09ORklHX1g4Nl9TSEFET1dfU1RBQ0spDQo+ICtERUZJTkVfSURURU5UUllfRVJST1JD
T0RFKGV4Y19jb250cm9sX3Byb3RlY3Rpb24pDQo+ICt7DQo+ICsJaWYgKCFjcHVfZmVhdHVyZV9l
bmFibGVkKFg4Nl9GRUFUVVJFX0lCVCkgJiYNCj4gKwkgICAgIWNwdV9mZWF0dXJlX2VuYWJsZWQo
WDg2X0ZFQVRVUkVfU0hTVEspKSB7DQo+ICsJCXByX2VycigiVW5leHBlY3RlZCAjQ1BcbiIpOw0K
DQpEbyBzb21lIGZ1dHVyZSBwb29yIHNvbGUgYSBmYXZvdXIgYW5kIHJlbmRlciB0aGUgbnVtZXJp
YyBlcnJvciBjb2RlDQp0b28uwqAgV2l0aG91dCBpdCwgdGhlIGVycm9yIGlzIGFtYmlndW91cyBi
ZXR3ZWVuIFNIU1RLIGFuZCBJQlQgd2hlbiAlcmlwDQpwb2ludHMgYXQgYSBjYWxsL3JldCBpbnN0
cnVjdGlvbi4NCg0KfkFuZHJldw0K
