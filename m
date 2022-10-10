Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E915F9F70
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJJNdG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 09:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJJNdF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 09:33:05 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32847285B;
        Mon, 10 Oct 2022 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1665408782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=T7jUtBVquei6SZlM6RBDz7a9tBsXkwQs6dtEz8QCVOU=;
  b=h4/hotXL5adqDR9UVmCYutGvmKNqT+uRm4AWLb09PRoOoXapI9ooxFMz
   a3dngIBTFeITFc8lL+zRdDFvE7MHN8EC5N9b4qONxRZ0Sc3cVVQY6DVii
   duTRBf5MneU/yMmoVWL4dFF3g+XJQq4ROLA6QAQeea709aWjuT6nLCvKr
   I=;
X-IronPort-RemoteIP: 104.47.55.171
X-IronPort-MID: 82011839
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:4RyfqKNpFxtFF2/vrR2OkcFynXyQoLVcMsEvi/4bfWQNrUom32YAx
 zRODWnQafyLYmX1eNAlbIuy/UpX7JCGyYBgQAto+SlhQUwRpJueD7x1DKtS0wC6dZSfER09v
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fQLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhnglbwr414rZ8Ek15ayr4GtC1rADTasjUGH2xiF94K03fcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD90V7tJOp6iGqE7aua60Tqm0xK6aID76vR2nQQg075TCRYpQRw/ZwNlPTxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJQWXAP6I0DuKhPRL/tS4E4eDKk6+NppITty0
 scIOWsOVwCjl8ym3+fuIgVsrpxLwMjDGqo64ysl5xeJSPEsTNbEXrnA4sJe0HEonMdSEP3CZ
 s0fLz1ycBDHZB4JMVASYH48tL7w2j+jLHsF9RTM+vNfD2v7lWSd1JDENtbPd8PMbsJShkuC/
 UrN/njjAwFcP9uaodaA2iL23raWzXiqMG4UPIKVyqE6wwG4/0gwOkNKdXKLq/aDp1HrDrqzL
 GRRoELCt5Ma+lOmT9zwRTWirXKEtwJaUN1Ve8U55QyWwa3T4C6SBnIDSz9cbZohrsBebSYr3
 VzPh5XkCTNiu7qQQ3+197GIoDf0Mi8QRUcSNXEsTgYf5dTn5oYpgXrnTs5qOLykktrvXzr3x
 liisCc6l50XjMgWy7+8+1HXxT6hzrDMTwg64S3NU26l5x8/b4mgD6Ss6F7G/bNDIZyfQ12po
 ncJgY6d4foIAJXLkzaCKM0BFa+kofaMNibRh3ZrHp8853Ks/WKuecZb5zQWDEpyI9wsYzLlY
 EbP/whW4fd7OHqscL8yapi6C+w0wqX6U9foTPbZapxJeJcZXAuG+jx+IEeI3kjzn0U216IyI
 5GWdYCrF3lyIa19yjaeTv0b3bVtyi1W7WfOWZfTzBm917eaInmPRt8tOkCPaO855bmDugz9/
 NNWNs/MwBJaOMX0egHe9Y8eKwBMIXVTLZ/xscdKcOmdCgVjEWAlTfTWxNsJf41jgrQQmuDD1
 m+yV1Uey1flg3DDbwKQZRhLbLLpQIY6qHcTPjIlNlXu3GIsCa6v7qNZa5wweaIP++lqzPoyR
 P4AE+2fD/VNSz3B9HIMZJ/yhI1kaBmvwwmJOkKNaz8ldZN8bwjW/JnicxeH3CwPDSfxttE3v
 bC8xCvcW5MIQwkkB8HTANqpxl+4oz4UneNud0TNK9hXPk7r9eBCLCj8gdctLs0MIAmFzTyfv
 y6OCAkVocHQqJBz+8uhrbiJs4qzAcN/GERAFmXW5LrwMjPVlkK5zZJGVO+QVTHbWnn99Kira
 aNS1f6UGPEKgFZNtoNUFrdg16Ul4NXz4bRdy2xMHnzNaVSDBbRnLX2Lm8JIs8Vlxb5DuA+yH
 FmP58VXPLKXEMfkFkMBYgsjcumHk/oTn1H67/M8JwP/4zV6/aCOeURUIxSIzidaKdNdMoQlx
 6EovMob7SS2jxZsOdGD5ghX/G+kIXsHXKEq8JodBefDhxAizFBLZ7TTDSj55JzJYNJJWmEwO
 ieIrKnPnbJRwgzFaXVbPXrE2O1Hn5UVkBRLykISYVGIkcDCnfg5wFta9jFfZh5c0BQBzaRoO
 mFtNERvDaSI4zpswsNEWgiEChwEDx2U/EO32kYhlWvFQk3uXWvIRFDRIs6I9UEdtmhaLj5S+
 ejCzH6/CGmzOsbswiE1REhp7eT5SsB8/RHDn8bhGNmZG549YnzuharGiXc0liYLyPgZ3CXvz
 dSGNs4qAUEnHUb8e5EGNrQ=
IronPort-HdrOrdr: A9a23:40nff6s+xayPFDW+BuFAZwBW7skC1YMji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6H6BEGBKUmslqKceeEqTPqftXrdyRGVxeZZnMffKlzbamfDH4tmuZ
 uIHJIOb+EYYWIasS++2njBLz9C+qjJzEnLv5a5854Fd2gDBM9dBkVCe3+m+yZNNWt77O8CZf
 6hD7181l+dkBosDviTNz0gZazuttfLnJXpbVotHBg88jSDijuu9frTDwWY9g12aUIP/Z4StU
 z+1yDp7KSqtP+2jjXG0XXI0phQkNz9jvNeGc23jNQPIDmEsHfpWG0hYczAgNkGmpDr1L8Yqq
 iJn/7mBbU115rlRBD2nfIq4Xin7N9h0Q669bbSuwqfnSWwfkNHNyMGv/MWTvKR0TtfgDk3up
 g7oF6xpt5ZCwjNkz/64MWNXxZ2llCsqX5niuILiWdDOLFuIYO5gLZvi3+9Kq1wah7S+cQiCq
 1jHcvc7PFZfReTaG3YpHBmxJipUm4oFhmLT0AesojNugIm10xR3g8d3ogSj30A/JUyR91N4P
 nFKL1hkPVLQtUNZaxwCe8dSY+8C3DLQxjLLGWOSG6XXJ0vKjbIsdr68b817OaldNgBy4Yzgo
 3IVBdCuWs7ayvVeLmzNV1wg2XwqUmGLEfQI5tllulEU5XHNcrWGDzGTkwymM29pPhaCtHHWp
 +ISeBrP8M=
X-IronPort-AV: E=Sophos;i="5.95,173,1661832000"; 
   d="scan'208";a="82011839"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2022 09:32:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmnYq/C5XgTTjevp7CfFevqUwzVuabCu73J8E8HB+OxVcuUBnNvMLVDt8PJIL5V9YOGbi+zkOH7tNpTTzwvDh/Al/ihT3B160NPnYo51unoPltehOXBlTV6bI87SPCGBz7k7LL8vlhuCDMQUG6j7TuAkJbJxrgkPNwrFUCi2upe/Zcx6rZ2yJrk859XMa2H73r0pruY31NZReQWAXvqurSr2rhRiDrZmXx1VcBFaC/pTsHeeyPcqRgIvsisxF/WpmyiwAynq8g8MO5B0hC2urGPa72VDG6iLdNycKB6TX0n6k3N6BBdEj0shF9oLtW2XKrGH/vONMaHPeeeJISlJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7jUtBVquei6SZlM6RBDz7a9tBsXkwQs6dtEz8QCVOU=;
 b=RwR/uy4LrL3lcvQW4CrSBGlvORdcL2pDvQivXQn26XiJSgSwEW7R/bwn01OfMFrqWPMsejK0eDg+6TQWEuZz7QuVREXFUCAOjOqkRWC6rdjO5iiVqer+vFPvE9aJNHRRHWS/A2ukJIiVT/3j/WPgM8C5ZUuD4TjFMyR/MV+Hk+Ys+HzCfdBkqrHI+lBYgwzQEDz67A5+S3uebHMVjVSSLqX7LLdxuvemyPhIqiYIwf3PVnDjEnTfvwz03h53tig6euzpqFohIWD08wNcASu21MV8mDenIwajSUbHzC9I/d6TUuK2xg5+8JRwDDGJhRkahm/263wl6ld0Q5qNQeYZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7jUtBVquei6SZlM6RBDz7a9tBsXkwQs6dtEz8QCVOU=;
 b=j/vG7yA2dhWQB2oZUSv21ZukGaGgeEQ3cqozW9nWtK9gKq1Jn8A3E56fr2gpWbjxY9e067vEIQXVpzIRDSCeQC+Lec1cqI7VQRoSfXA2U+VrZwIt6DqYNu2a31vR5HVGo+pETuWFOuPrqTmO20ghYS1C2pubg1kpTlG1TOYhSOk=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by BN8PR03MB4945.namprd03.prod.outlook.com (2603:10b6:408:78::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 13:32:54 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::1328:69bd:efac:4d44%3]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 13:32:52 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Florian Weimer <fweimer@redhat.com>
CC:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v2 18/39] mm: Add guard pages around a shadow stack.
Thread-Topic: [PATCH v2 18/39] mm: Add guard pages around a shadow stack.
Thread-Index: AQHY2EPhEQwcvkF0f0Gd0+5UmjC5K63/FHWAgAiEIeaAABB4gA==
Date:   Mon, 10 Oct 2022 13:32:51 +0000
Message-ID: <6e75eb27-c16b-ccfe-08b9-856edeff51eb@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-19-rick.p.edgecombe@intel.com>
 <202210031127.C6CF796@keescook>
 <37ef8d93-8bd2-ae5e-4508-9be090231d06@citrix.com>
 <87bkqj26zp.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87bkqj26zp.fsf@oldenburg.str.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|BN8PR03MB4945:EE_
x-ms-office365-filtering-correlation-id: 8e3bbd1a-33f2-4b83-f7e7-08daaac3ee50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hhtTAivHxTsBQ456nHhSoaWIq74tn5xjVVCPy+VvguOblCJqHqJ1Dg8IOkNbx90tAZZIJsgxNjsDlH6MlpBgPykgUZCfYHwW0fMZvNgmLLT9KOfet/5578W35JHipFz5AoLeGzV1038mfyR5Ex+m7oFeKrk6XbZK8kEwED6ZKZS3FPSupgIhRl2P9RrqbkKqUiYl3k4xY4EuKJANO5L0zkAakj7FrGea/aUBswBQjBk0aHXtmvPA9CEdPAqN+x77BcCS2xEEX9cQ8EQs01fGj3dWRVZW/DGkSPKlzQFRC3NyZ3ZkWoS1OvwU44Y2HTtf63PZu+2Q5H5emyYLtNg7LGJSYFq89vP5TLxtOcuRZNnBdmNscF4dZ5aG6S1VxGdQJ3VS9cvpW6fI5mLMcQ+rsAQa7ffa1EnWRg5RK9ji94P9d4b6GMKKAlkKUdWTXtpguI/Emk7S2JY+KQyMx897eD6hQmCiKv4xvkU3Xxp+V/yBtiIZ9h9hmPZWcS8nDJX0OUQEsh1eY5VzUSBtMitDpdT0Xpi5Ufptxelnl7tD6kJw86qZR+Iqo/w9OnrWrNF0A/XEaaThRHri8DJuFEw/9RoGjPohEAH0Hbp+WJ4Y16zJZ6UqHNYKHzTcJDuUUH+81OkInnS5ZnNzqAsL1eISmh5nHDjpr9rQlkwb6upIU+cmSwvLTC3jDggjzgEGBmM2UtCvgiqsPp2KOFFhZ3sFkYxRQJMB4Vrlrkbbxci3RPNyw+rc0nEX7vecV8i0somUBLniH1qmHag+aQCwO1iQIQfihUYovMfTt+0R6j4OEJzefN0HsiLrsJHXfZSHfkjj3bo+LeS6TteEruoOvPMKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39850400004)(366004)(346002)(376002)(136003)(451199015)(6916009)(54906003)(31686004)(316002)(7406005)(2906002)(186003)(6486002)(2616005)(66476007)(107886003)(66556008)(41300700001)(66946007)(83380400001)(76116006)(66446008)(7416002)(8936002)(91956017)(8676002)(64756008)(38070700005)(71200400001)(4326008)(5660300002)(122000001)(31696002)(26005)(6506007)(6512007)(53546011)(86362001)(82960400001)(478600001)(36756003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0FDcFRTclVyZ2dJS2YwVmZ1eWJlSzA0Z0UvQk9uTUVxN3BSampXZzFBMWlO?=
 =?utf-8?B?SFQ1MytQeGIya0ttQngyRFpZcnZyZWttY0JyOXdFclZqRjlYK2I1VVdKNEdR?=
 =?utf-8?B?UkdodEZqekR0YnVyUmJOdEhMYkg5aGo4RWowTVZERHRjTnpESE45QmFDaWUw?=
 =?utf-8?B?U3BBSGI5SElBOWIvTVVkMjAxVzhuYkg2ZGRmWFJBVzMyejBjRVo3MXVLdUlw?=
 =?utf-8?B?ZmNXQndDTDA4QWdCQjhwNEZIK3d6Qy8vdFBIVUk4aTlMVk1US1JkNGdmMHk1?=
 =?utf-8?B?djFzNmFYSnp1T1lkNVdkTHNLbnJxazQvTWtoRlgwaDAyVlBBcmVyRXp2Tzgv?=
 =?utf-8?B?WHVFa1RVdFJ1NWUxRytLZmwxYTdKZEZmekNBZStWUnlDSG0xK0R5MVlZTU01?=
 =?utf-8?B?dXBNdll6WWlaWEtCdkdyaUg3REtjS1ByUy96cTVVS1pYcS9LUnU5VVV0SFVq?=
 =?utf-8?B?TGpicXJLbWI0bjJtRDBZemlPdlgxUmMvRVFCTHlLSW5scWg3SU8wZlh2M2hi?=
 =?utf-8?B?UUhLVUp5eUI5QjZZdEtZc25lMU0yYjQ2UGZTK1h1ODIzcVY2S1V1Zi9NUm1O?=
 =?utf-8?B?VktwVVBXeVRuaGVnc1RhUG9TeVl3b29xTlFZdVEzZ3loOUlHS0xrZHl4U0Nh?=
 =?utf-8?B?UElJa2ZzWm5UOHRWQmREN0RvTFZuUHBtYmFDODRUUzgySTV2V0ZJSUlKbmpT?=
 =?utf-8?B?VlFuZ2huVU42QVNiWFpEdEN1VmtrQVY2NW9kWWJRT3RWVVE2RlpvMGM0QkV6?=
 =?utf-8?B?cnBzMHp3ckpuTzcxK3BSaDdTbDlPQlZVc1FpOWJOVWxZNXMvcHByV3poTG52?=
 =?utf-8?B?aGRKdEczWCtHSmFMRUNFS2RmV1YxUy84UnM3MW04V1EzN2tTNFpMQ2F6blFm?=
 =?utf-8?B?d3RuYXE5c0VpVTZWVTRUaGx5dXMweGhKSVNVY1pZdUZMSWx6YUh1ZWtJaVBi?=
 =?utf-8?B?L01YK2ZpRG5VU3dBTzlDdFRTTlBCSHNxU1Z2SjJFeThKcnl2MUZxWkpPVVBQ?=
 =?utf-8?B?OEJBanNPeHhTK2pKV1pxbE81SnVCdXlrQ3doZzJyYWNNZzJOclZlUVZ0Ym1E?=
 =?utf-8?B?Sm1OSmlLSDJKeUdSU3JZWkI3S0RIeUYyblZ2d1pWUVVQRExmUWVGQ0tRK0RT?=
 =?utf-8?B?R2ttK1VzWFhkMjZVZnNCMHovWVVlbHpWYnJxVmxHMjBJKzVVd3hMLzNHWi9S?=
 =?utf-8?B?Z2M3cE0zNWw5QlJkZ0FGNTZXM0swbHYwS2dVeGl0dm0vZFlIMVZsQWtwbmt5?=
 =?utf-8?B?YjRaYkFMdjVXNnJnMW9ZT1Q3SFZRSThnM2NGVkNGT2NXczVxQVJNMFd1MEJT?=
 =?utf-8?B?TUJsKzdoR2tBWGx3THIvS3pNMUNpTEpGTDFxS1AxelY1QjZMUmZaK3hib1dM?=
 =?utf-8?B?TnN1dUNuRUdKM0dKWDVxTGNDbzRyNy81ZTc4bDVwcGc0RlVSTE9aN0gwQWFz?=
 =?utf-8?B?Z3lCUHNBTFUrUVovN2ZUNGFUck04ZytubHRiN0FTVFFpbzg5a2VUV0p1TnpO?=
 =?utf-8?B?WmdKWThzUEdTS1pUdGJrYjNWNnk3WnRzUUl0TlpZSUg5ZGMwd0NNSVdIeFN2?=
 =?utf-8?B?QWNjNVhDNnowNlZtTFAxOERmcjNDVmYyeFN2VE5VSFZlQ3NRZzMram5FUGtl?=
 =?utf-8?B?WkpUa0ViWWg4RFBNK1JvRnNldmZLZVQrUkZaZUF5T3VZTll0TUJJQUlQQ1JG?=
 =?utf-8?B?MjZ6Q1Z4VHUwSGdITWJPbDdNdFEzdDlDY2FQNll3dENJT0dkb3NnaFdVUGpt?=
 =?utf-8?B?QXVOcVFmaHhBSUI5cldZaGNQUVJYQkdFMXRkaXR1NlhmRGVvdnZUWUxPZkFj?=
 =?utf-8?B?czJ4bFVDQzR3T2taQ005Q1dQU01yeUVtSUJJWGMyeE9DaWVTQ2NMU095dHRz?=
 =?utf-8?B?Ykg0ejZWTEQ4M1VLMytjeWpKSS96bGkyZDVpWjJjdjZoMnljTFlKYmVVbDVn?=
 =?utf-8?B?aXlHM2hUYUF6WDV1T1FLSlI4dm4yVjg5RWk1Rmk0bGZpTWIrNStMeGhNRjVE?=
 =?utf-8?B?YzRJTXlWYVdja1UvdEdzWGxsQVNhYW5qbkVCU0Fkb2srelFyT2ovNjVRaFNm?=
 =?utf-8?B?Q1BZTHBGcFBZQzIyNDdHKzJxMC9aWGJ2bWNIOGxPS2lGYysrK29KemlQcUdT?=
 =?utf-8?Q?1z8sCCMsWgdokKoLdMX7GuGXu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <634C929F9F738944A4F86E880F120F52@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3bbd1a-33f2-4b83-f7e7-08daaac3ee50
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 13:32:51.9818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4t5DKgrpXQ6XaVJwaGSWxhkqv9PkgsiUMuEq+xgVpJCXbSqv0WrG3fVngOP7vHn7BQzXp7HJcLpvZYoXwNwqminsLwv0ZswIhcFEjUPRbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4945
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMTAvMTAvMjAyMiAxMzozMywgRmxvcmlhbiBXZWltZXIgd3JvdGU6DQo+ICogQW5kcmV3IENv
b3BlcjoNCj4NCj4+IFlvdSBkb24ndCBhY3R1YWxseSBuZWVkIGEgaG9sZSB0byBjcmVhdGUgYSBn
dWFyZC7CoCBBbnkgbWFwcGluZyBvZiB0eXBlDQo+PiAhPSBzaHN0ayB3aWxsIGRvLg0KPj4NCj4+
IElmIHlvdSd2ZSBnb3QgYSBsb2FkIG9mIHRocmVhZHMsIHlvdSBjYW4gdGlnaHRseSBwYWNrIHN0
YWNrIC8gc2hzdGsgLw0KPj4gc3RhY2sgLyBzaHN0ayB3aXRoIG5vIGhvbGVzLCBhbmQgdGhleSBl
YWNoIGFjdCBhcyBlYWNoIG90aGVyIGd1YXJkIHBhZ2VzLg0KPiBDYW4gdXNlcnNwYWNlIHJlYWQg
dGhlIHNoYWRvdyBzdGFjayBkaXJlY3RseT8gIFdyaXRpbmcgaXMgb2J2aW91c2x5DQo+IGJsb2Nr
ZWQsIGJ1dCByZWFkaW5nPw0KDQpZZXMgLSByZWd1bGFyIHJlYWRzIGFyZSBwZXJtaXR0ZWQgdG8g
c2hzdGsgbWVtb3J5Lg0KDQpJdCdzIGFjdHVhbGx5IGEgZ3JlYXQgd2F5IHRvIGdldCBiYWNrdHJh
Y2VzIHdpdGggbm8gZXh0cmEgbWV0YWRhdGEgbmVlZGVkLg0KDQo+IEdDQydzIHN0YWNrLWNsYXNo
IHByb2JpbmcgdXNlcyBPUiBpbnN0cnVjdGlvbnMsIHNvIGl0IHdvdWxkIGJlIGZpbmUgd2l0aA0K
PiBhIHJlYWRhYmxlIG1hcHBpbmcuDQoNCkl0J3MgYG9yICQwLCAoJXJzcClgIHdoaWNoIGlzIGEg
cmVhZC9tb2RpZnkvd3JpdGUgYW5kIHdpbGwgZmF1bHQgd2hlbg0KaGl0dGluZyBhIHNoc3RrIG1h
cHBpbmcuDQoNCj4gUE9TSVggZG9lcyBub3QgYXBwZWFyIHRvIHJlcXVpcmUgUFJPVF9OT05FIG1h
cHBpbmdzDQo+IGZvciB0aGUgc3RhY2sgZ3VhcmQgcmVnaW9uLCBlaXRoZXIuICBIb3dldmVyLCB0
aGUNCj4gcHRocmVhZF9hdHRyX3NldGd1YXJkc2l6ZSBtYW51YWwgcGFnZSBwcmV0dHkgY2xlYXJs
eSBzYXlzIHRoYXQgaXQncyBnb3QNCj4gdG8gYmUgdW5yZWFkYWJsZSBhbmQgdW53cml0ZWFibGUu
ICBIZW5jZSBteSBxdWVzdGlvbi4NCg0KSG1tLsKgIElmIHRoYXQncyB3aGF0IHRoZSBtYW51YWxz
IHNheSwgdGhlbiBmaW5lLg0KDQpCdXQgaG9uZXN0bHksIHlvdSBkb24ndCBnZXQgdmVyeSBmYXIg
YXQgYWxsIHdpdGhvdXQgZmF1bHRpbmcgb24gYQ0KcmVhZC1vbmx5IHN0YWNrLg0KDQp+QW5kcmV3
DQo=
