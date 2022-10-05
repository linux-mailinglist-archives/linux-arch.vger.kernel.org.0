Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6D5F4D65
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 03:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJEBcJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 21:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJEBcH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 21:32:07 -0400
Received: from esa6.hc3370-68.iphmx.com (esa6.hc3370-68.iphmx.com [216.71.155.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E47452FD2;
        Tue,  4 Oct 2022 18:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664933526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FbkOtp9k9E05fRKN3a3utBAJa98xca9mdrDaTGt8Z4s=;
  b=QQYwd15f4e8ihrQBfqqnYiRU60kTfIG9s1Uobg640LNE9L36bhk7Uf2O
   of78oECGhqrvN8qEvmiEprY4LmY3xOsefBVov65kjn3z3Y6d1+do3wrm1
   7fNeRPFf8Om3aGvvOmAhzg9xudS1CwcMP5y2Ji0n0LLShYxcla2ciEyGx
   w=;
X-IronPort-RemoteIP: 104.47.51.47
X-IronPort-MID: 81635937
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:F/2atqxn7B00Y+MR8RR6t+cIwCrEfRIJ4+MujC+fZmUNrF6WrkUEy
 mAYUD2GOv3YM2L8KY1yPYXnpk4A75Ddn4dnGgBrqiAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHPykYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbyRFtspvlDs15K6o4WtA4gRiDRx2lAS2e0c9Xcp3yZ6ZdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVDmZkh+AsBOsTAbzsAG6Y4pNeJ0VKtio27hc+ada
 jl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CA6IoKvn3bEmp1T4E8K0YIw1fRXOX8Q2
 PwjOjEqayCvie2I+bmxRbw57igjBJGD0II3nFhFlWucJ9B/BJfJTuPN+MNS2yo2ioZWB/HCa
 sEFaD1pKhPdfxlIPVRRA5U79AuqriCnL3sE9xTI/OxrvAA/zyQouFTpGPPTdsaHWoN+mUGAq
 3id12/4HgsbJJqUzj/tHneE1raRxn6qA916+LuQqvBh2U/DzEUoMTITaXyV+KOjtn+MVIcKQ
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
 XZDM0xzOLXI/jF0icwFVGepcylQGViS+kH3xB0YiUXYSVWlUirGK2hVEeaG/Ggd6H4acjUzw
 V2D4GPsUDKvdseo2CI3ARFhs6a7EYM38RDekse6GcjDB4M9fTfunq6pYywPtgfjBsQywkbAo
 IGG4dpNVEEyDgZIy4VTNmVQ/e1PIPxYDASumc1cwZ4=
IronPort-HdrOrdr: A9a23:G7KLFqtuY1AsQQ/1DpKBUXPu7skCiIAji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6H6BEGBKUmslqKceeEqTPqftXrdyRGVxeZZnMffKlzbamfDH4tmuZ
 uIHJIOb+EYYWIasS++2njBLz9C+qjJzEnLv5a5854Fd2gDBM9dBkVCe3+m+yZNNWt77O8CZf
 6hD7181l+dkBosDviTNz0gZazuttfLnJXpbVovAAMm0hCHiXeF+aP3CB+R2zYZSndqza05+W
 bIvgTl7uH72svLiyP05iv21dB7idHhwtxMCIiljdUUECzljkKFdZlsQLqLuREyuaWK5EwxmN
 fBjh88N4AqgkmhPl2dkF/I4U3NwTwu43jtxRuxhmbim9XwQHYXGtdMnoVQdzre8g4FsMtn2K
 xG8mqFv958DA/Gng76+9/UPisa2HackD4Hq6o+nnZfWYwRZPt6tooE5n5YF58GAWbT9J0nOP
 MGNrCf2N9mNXehK1zJtGhmx9KhGl4pGA2df0QEssuJlxBLgXFCyVcCzsB3pAZEyHt9cegB2w
 33CNUvqFh8dL5OUUu7PpZYfSKDMB2LffsLChPIHb2oLtBcB5uHke+L3Fx83pDXRHVP9upwpH
 2JaiIniYZ5EXiedvGmzdlF9AvAT366WimowsZC54Jhsrm5X7bzNzafIWpe2vdIjs9vdfEzYc
 zDTq5+ErvmNy/jCIxJ1wrxV91bLmQfStQcvpI+V0iVqszGJ4X2vqiDGcyjb4bFAHIhQCfyE3
 EDVD/8KIFJ6V2qQGbxhFzUV2n2ckLy8JpsGOzR/vQVyoIKKopQ2zJlwWiR94WOM3lPo6Y2dE
 xxLPfulb66v3C/+SLS42BgKnNmfzJoCXXbIgZ3TCMxQjDJmOw4yqSikEhprQu6Dw46Sd/KGw
 hCoFky8b6rLvWrtFIfN+4=
X-IronPort-AV: E=Sophos;i="5.95,159,1661832000"; 
   d="scan'208";a="81635937"
Received: from mail-bn1nam07lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:31:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwqKZCBEpL0ZqUbIawyf+1+xYu3CTcUENmlz2pD7GojUCVGyJDRJdg7EGUGDTr3Xcyi3sq16a3Ecpve6Zb2Z1SdRhsksmyJcayNbBvihWWL0XWufFBA+7RaoBymm4o8CcQ6WtmmeosIhBoS1XjtxIlwyZ9CXRwYNk0nnmg+07iZp4WlspX5sn6lUm94+KTM+n8tSDl5yzkyGvSEGkv+ke2XH+/VwlgsLsZroZiFifFW1vYHvh/OUyIrrpe9ba76BHcMeR5sIQpB+eAy6AObKB3+u9sInhn+H9m2D54RtC2VvoEL3Is27xXRGUeUyoyxlTBD/NYVIKoDSN9Z+UZkVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbkOtp9k9E05fRKN3a3utBAJa98xca9mdrDaTGt8Z4s=;
 b=N42qUrqxkyDNptAemv0vNs5dH+sCFdTSfsJd6rcAmjE2nX0Ys133g0yLYTqqJ8c98wLPfaBfMnDRuNqNp5dDwZrc5pGvc08fXP0o51BJu7dhuBhw1ec4u6PWMODJqrM5RWqyLdEry6iZ1PrWnom0EHjm0QIcS9O2FK9rXVia168bBc+DbwPOJTwSmEMzQ1vxDVX1iNICDaAaQQcF5opLpmgH0nyMIAYv7KQmPYJjANHc60mXlPNboZsfxnG6Ug8FuzZKVuKpXtebnq8613B6bYpxWsiWs22FAyZJyj1Zg3h1ccPYWLYgkpF8Lup8p0C1nOQS0G7Ft2lbmWBjfIf8eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbkOtp9k9E05fRKN3a3utBAJa98xca9mdrDaTGt8Z4s=;
 b=SRPPgP3RmBsxKDzrGu1Vwy56ENxQDuAlXgfKW91KtBWLaFNpih83Uk9VFYAy1d5o2vM7Vnm6lNOoQ+WmeqMSkQz8zzfYnELSoLE46NX5F4tQ670T5d8PL/5lF8Q7InCgMG3SCOefNjDOKqxQ1P3H02CVwEaIsPhmzP68Q+DKXaY=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by DM4PR03MB7000.namprd03.prod.outlook.com (2603:10b6:8:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.30; Wed, 5 Oct
 2022 01:31:28 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 01:31:28 +0000
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
CC:     Yu-cheng Yu <yu-cheng.yu@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 08/39] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Thread-Topic: [PATCH v2 08/39] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Thread-Index: AQHY2EQA6XM0CgiZ10WXzrN2yB2NVq3/A9eA
Date:   Wed, 5 Oct 2022 01:31:28 +0000
Message-ID: <8d58f57f-cece-c197-2a8b-dd02b4e405bc@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-9-rick.p.edgecombe@intel.com>
In-Reply-To: <20220929222936.14584-9-rick.p.edgecombe@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|DM4PR03MB7000:EE_
x-ms-office365-filtering-correlation-id: e255b2c7-cd9d-4445-f70f-08daa6715314
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXVmVnvWqDydfxQFskB0Xa6ophRg/+5g5FWqd/x761WRfClwvC+UJP1QX1gSA6Vch2s7kyTXAmoNbFXySJmJK5yKgjY2t00aJ07PO23omH+B2+6V/vyzj+ZW4Zrp2Msgt5mGY4feZRaNX9DkgW31RlXmLPdKjvJaLuPp+mhK0J93CL27tiDRb+66L2cHTozsDU6WtewqoS9zqGpY5R+TjoL/zvVTRnoXYXhZhN/BVcz4d12sHeFJqjW3qDEQz4OY2WIviMrsHtyVGCRbWRUBchtEnBI+UMCpupO80/XdiIU7FdMXvKhCyvGDf1umJfzJmctAfEukEtMb6/TgByh4knKeADaH10ZCehb2SwlKcuVO2fr/6u2sybOPBio6Lxeio2iSu5Jw4t92R9zew7mefLwC9CkZSdKzV2/rXIDbPeTsazJlFtqi+6uxE6gtXfqtuBst7ocejHj89+5NFC7CUiXzC4r4WjEnsq6PaUyhIBAakv2yzhLh8XuRRqghVRE0iEiWuahj8ej8njIgWfOvvH/RMOzGhhH4o1o4zXRXZBttU+pKXcExfTIcRnPOcxU9UyGaEdNEbrDvOptJp+e1mdgFXkun7EMsrICzGHQayDZCZ92Iu7lU4DVeJNoxrVDg29bFjoLb/QJA2O/62L7rzHPnYPA/5mzTlp+ahyohAp+bHphHxeKONH+Gqb8d52MGdxFuERqzQeIQ+CetL7X70lYk/zUObTYdiZIpiDORhsJUkZUdvTw+zhTdllUSCyoNBVNIyueucpXVG/fwadn+zRhuq4BlRDmAkWiTDgGsPyJqaS5PzNlvMYqg0boBt78wZsKhjWIzlcGEIXi4zpUHzKt2dwMkBKD8VPG6l3zXfehaLSa9wE1z/kuUiuMwNktS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199015)(86362001)(66556008)(64756008)(76116006)(66946007)(8676002)(31686004)(66446008)(66476007)(316002)(91956017)(7406005)(38070700005)(36756003)(921005)(7416002)(5660300002)(83380400001)(6486002)(478600001)(2906002)(110136005)(41300700001)(82960400001)(4744005)(8936002)(71200400001)(31696002)(186003)(38100700002)(4326008)(2616005)(6512007)(26005)(122000001)(54906003)(6506007)(53546011)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFFaVTc2b01WUFlwUGd2MXVTbWZSaHY5d3dleERpalRlc3FrOW1zYUQrZ1BN?=
 =?utf-8?B?M2JVWHpCYjNVWUd3UWF3SUNKdlBNQlM5U3JqNVVHcW5SY256ajMySkg1U3ZI?=
 =?utf-8?B?bnFUK1N6bjhlMU0wdTJJMlQwOVlFVU5DeTFXM0wxRnBzTEZSY1pHOWtVMWQv?=
 =?utf-8?B?ZnRWbUNSb0tRYVpud3pjeUQ3SjRaSWk5VjZONFplb081RVZ1S3grZ21HelZG?=
 =?utf-8?B?YjhrbXlML3N3N2lTc1NVaUY1eGZFVHJ5MmpuYmZ1ZGFEV042Q2xlekYySyto?=
 =?utf-8?B?RXZqbFFRUnNCYmE5bzZRcGdlOTNEUCtpMXhOMzNvbHpQdllNdll3ZVNCOEUr?=
 =?utf-8?B?RlBQM0g3OG04amRvNkxwRFFOMnpmQVE4MTRDalRvbkhYMVZIcGRxakdyTk9K?=
 =?utf-8?B?NW1aZUdFb0pCb3lqdG0zSC9TYVdieVV0enhaNlhFQVF5cjJMbzhxVkZyZFZ3?=
 =?utf-8?B?TVZJaGpndmd6UEt6blBDdmZlSkJVLzhjcmlLY0IrMWtUQ2lCUkp6UnNWaVgy?=
 =?utf-8?B?enFUZEhxL0FERFZDYVFvMEhFZHVPUVBBUDZua3BET2RhWS9tdENQR0dWZHd1?=
 =?utf-8?B?QXU1UU1RVmdSVXZuUTA5L1NMN3N2a0lPcjlkSVYyV3M2czIzdWhBb1JPZWoy?=
 =?utf-8?B?ZWJZcWh5WVJPS0JubWk0QVo1bjBOd3k3azB0WDVaaUtET3V3QUk2WFViOFVa?=
 =?utf-8?B?akJOQnJRajB5RlFoNlVnMXZsM1dzMkFSSzJCT0pYakFIQzNWdEo0T2EvQzVz?=
 =?utf-8?B?cDFobVNFMXliVndMbnd2UEJxcmFHNE9YM2dPb1pXRjN4dTVKcGtXa3Fza2Zl?=
 =?utf-8?B?UGpkK3VEU3p3MzRqZkJlU1JqWWFxVWJmaW00SjhZai9GbENyVU5Hb0cwRnlF?=
 =?utf-8?B?ak81eUx5amJ5RjZnWFZ5Qko5NjN4U0JLZnlQbnc4MWJMK3R6Zk9FYjE2UmNp?=
 =?utf-8?B?dE5nUGw3ZFJ5RCsyYkR4V1VWZ1JUSS9FS1FNQ0N6ODBEekk0K3p3TGw3MXh2?=
 =?utf-8?B?L1FiRUJNY0Rpa2sxdmg5Uy9hK0ZiNDRSTzNvUTFDakFQSnhqWXo1TFYxUzZ4?=
 =?utf-8?B?SWUxZy95eFZqeEVGN3k1aTdmR2JpS2R0YmM2dEtnbGE4dEZaNjlYdjhTbFhW?=
 =?utf-8?B?bFJNQnp6RVhGc3c1NDFqaTl3aEFISW44cisyS2paVDRRVUJ0ZHE1WTA5N3V4?=
 =?utf-8?B?S21YQnhlcVplVXpmSnhDeC9lVVdpWW9XMThZeHdOMHlGTzlYZVlZL2gzZkNP?=
 =?utf-8?B?TFVrRXp1QjlOY2syUTRjNmR0a0drZGNIREgxYkRlMG1vaU82SXpzNFRLRUJR?=
 =?utf-8?B?OXVuUDlrSGw0NW5zbjMxRzFXMitKWXoxUE91QXEyYXc4a1c4N2R3SUxJdEpI?=
 =?utf-8?B?N2lsNVI0OElCK280ZzBwMDlRY3NWQVhseXQ3d1pjK2NEVDN0T3NPZkMrcXdF?=
 =?utf-8?B?TXlwRFU4S3VVbVBKZ3Z5SGdoZUhXTnJlNlpIWHF3RzF3bXZrKysyOFJTZUla?=
 =?utf-8?B?SGoyK2NMUTUxQ3ZBN0NybWJmRjBWZWtGazVIOHYxeHV5WG5xZWlVVEZOUFR5?=
 =?utf-8?B?NXovTTZFVzQ2WGlrTy9TNFdCdkhRT1ozclRSc3gyRzJqaGxYbE0zOExDMU1R?=
 =?utf-8?B?L2VCM2FaS0NxN2JRZ3J4alQxYi9tSDRqVFozMFdTYnhlUHNrdUZZblN5U2tM?=
 =?utf-8?B?TkhwNGc3L3ZUVjRiRUVlRm9USzdpRFlDeW5MZGc4WTY3OVZZU0twTEEzaGpZ?=
 =?utf-8?B?aEFJMkNwOFUyNnNUSy9KSlZYL3lPSUQ5TWNBUm9wL3RFY3ZRR3cva3dLM2xJ?=
 =?utf-8?B?SFR6anNub1liMG1Ca09yYW56Q2VCcWZKZGRRQUZSV1pncVg3Z0tUOEU0Yncz?=
 =?utf-8?B?VXdZSytxTDJBbGZrV2lmaTFxeFFiVkkrZTNubng2WjduMDhXcEtYVmM3SE10?=
 =?utf-8?B?OUpTaWxjRmVCODZpLy9kZ2FOQktEekxpQzZCZ1c5MEtRdGZaM0pOd3lNa0M4?=
 =?utf-8?B?R0x0MlBLcUpyTENEQitvaU56cUhGbFZaZHdFRGFkaWxzcit2NHBKVjd4VWJ0?=
 =?utf-8?B?WEp3WnZYOUxiYWFvWlJQaittYnIyY0ExSkt2MkxjbDBiWUxPRGtHMkk4allx?=
 =?utf-8?Q?UWpBRhYZJ9h2E97t4umgmnZQr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1292586F7984A44C8233306CBBF1D0B4@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UzJVbG1yRkJnMURSakJWTHJYdTNVSTVwdkVCWWxpVEpnWjd0MldWNjR0QjRs?=
 =?utf-8?B?V3RwRHlNWUdrWnhlMGludkJaZjlXcXAyYTBjTlpWSXNQUU45b25xd0Y0eDV3?=
 =?utf-8?B?VCtnWFBrK0tEY2U1ZldZbVRRNi9wM25CK3RRMlk1T3FXR1hpSlFiVnQxZW5N?=
 =?utf-8?B?T3hiTDZIT244UmdTQ2k3NnA4Zy9VSXdPK0xoa1RVSUdEbDI5WFpSOG5iTzNr?=
 =?utf-8?B?NVhHQ0kzVzd6WlE2MUNaUEFEQ3BQNjhhTTBXWHNnTHdiM25uVGRQSlNHMEJH?=
 =?utf-8?B?cWVmNlI4Mmo1TkNkcnQwL0V2dkR2cisvdHovaGEwSDVOQnVtUlozT3M2STJC?=
 =?utf-8?B?aGljYVY3bVovRThpWkQwdjlIMnV4d0JjaThuTWJNUDlzdC8rMFBhSHRaMVBU?=
 =?utf-8?B?VWF4KzI1ZnV0MVpxamgwNmI3K01ib0lkNGlqb3NYOUFDZ2gzem9POXZhZlB2?=
 =?utf-8?B?dUs4bXV3UkpiMHkweDZXWmV6Q1Npd1doMUZqYkwwYStaQ0FUWHhTcTFpaU8y?=
 =?utf-8?B?YzlGdFplN1lpT0JlWE5jcnFtK21nWWhTRjBrZUl6VXNDcURXQUJNc1dnTjRZ?=
 =?utf-8?B?bkptN1licnNjaTYyanBiY1B6SkxLTHM1alNYQ094MXhIcEZQeEdWbVliM3cy?=
 =?utf-8?B?VE9FZVVYOUk2cFNkQmd3djJHMG5LR3lpVXRTVDQxd3NUMjh2Qk03TC80dmNF?=
 =?utf-8?B?OU1wbzV3d0xoa2ZVcVE4WmlHaFRadHBhVkpkbjNiNGx6OTkzZHR3RUp2S2Ez?=
 =?utf-8?B?cFhxMzZGY1E2RDRrNlM2ODZPcmlaSmFHZUNoWHRHcngzQzZBd05YcGRtZTBF?=
 =?utf-8?B?YkxNSUJ1dDlkVFVubkdMaWYrd1FvUVg2SHhGTlNJc0E2UXBsSnZsZkRlRTNo?=
 =?utf-8?B?VUNKUHg0ZjRrK3RYMVhHcHJHYWJidEQ0Y2FCRE1VSkVEK2ZENTJvVmpEQnB1?=
 =?utf-8?B?RXg1bGVnSWE3cEE1N2JpcTZWSno3WkszM2pQbXFzRVdPRTlPVTRCMXZhU3JV?=
 =?utf-8?B?MFRkQjFXbzhROFZlRXVSOTNCRy9CbnJMRjAyRnhxWWttWWpTL2k1VlZETFhJ?=
 =?utf-8?B?RnpwNjE0RXdhV1NCWWoyRm5kNFFqZVN6aTRNZy9sQzZsZ3R2S3U2UlVuMlZl?=
 =?utf-8?B?SFpCNW1VSlJiVWxhTUc4TTVrUU5ta3lPMnRaNjJxSWJ2cC9iRUR5OThrb3Iy?=
 =?utf-8?B?TGNtNXhxWmloajJJZllWSDQvbzYrbWF4ajNwcDR3ZnBlK0htZk1GRURGRjhs?=
 =?utf-8?B?aU9DWm9rQU9seG5aV3VwblBVYkwwak10YjZ6Qit3elJ6YS9HamFtbHBrYWRN?=
 =?utf-8?B?L29seXRFY09xb0ZyL2JJN0ovdTdQMkZHc1VXcFRYa1lHRnE1eFZNUVlmNE83?=
 =?utf-8?B?ZnFnWHh1RS8wMW82Sk5FbFdaU3FIREJ1QVd4MHBYemd2KzlLVHpnNndDdnNw?=
 =?utf-8?B?VTRtQk9OeW1WQ2tCUjJ0aXhCTHBpajM1T3NWOTR2a2o1RU1rTE54ZnVBWVhi?=
 =?utf-8?B?QWNrOStxMVVjN0lRdUE4RUFzeWdVUlVJRnI5d25Ba3JoT0gvbEpDNjRRODJS?=
 =?utf-8?B?TEowcjVzUy9uSzB4aXdueXkvbHlwN3gwWXg0K1ZDY3V0NlZaRSt4M3lBcTYv?=
 =?utf-8?B?RUg5cm1SS2hRUTZidGRzQUVPc3cwVTh3aFpwWE9HLzh2ZUJiR2xYdDl1L3JE?=
 =?utf-8?B?QTJFUmhOaWY4TS8rSlRvWGRobE5uNnlNNnFvb2I3Tk96dmZmaHRZTG9rR2VF?=
 =?utf-8?B?RDY0aGJWQ2ZMUXZmdjRkNmdNTWVHS1JSZDE2WURjanhTOWEwWEVpWUZhRkc2?=
 =?utf-8?B?eFFzRGJVT1lCUnAvQzB0cGZGeEgvMkZHZS9GMUJtNkVhZWpmU1ptRWJQV2lI?=
 =?utf-8?B?Y2R6dlM4WStaY2I3SHd1cXdxUTBhVTNBdzlRTzRqYXhmcUwvQ2k1WEEvT1F0?=
 =?utf-8?B?MjhqTlV5dC85MjN5c3hOUkxjZ2lxRTFOQ0M0dWdkdVpyamhGT2VzQlNnbi9j?=
 =?utf-8?B?SjFVMXdaWi9NT2Ura2JjNXBaeWZtUFd4K0ZjL0d2S0o3MEl5eFVRR2FHS1Uz?=
 =?utf-8?B?SEc3QWxuc1laYW5ZMTA1My94MTgyK3pvaCtaMURYMldlcXEvSnkxMnlGcjJJ?=
 =?utf-8?B?d3dUSjBKUTg4T3JoWmJKLzgrMllaRnI5clJpYTNQSU90QzhLK3R6RmFwVmpC?=
 =?utf-8?B?bkpIc0hUZHlHSGdsc0pRMWMrbENGc3Jnck5FbStvcDJkUmVvalZQbXlOZ0da?=
 =?utf-8?B?NVU1NmZQK0llZXlURWRJZzE3dXZIemRNR04yKzBmMUhGRVlBRFpMNWN5QmtL?=
 =?utf-8?B?Q1JzL0wxc2FCTGhUNUZlN083bnd6ZExyUGJKeGZWbWdGanJqRXRLSWNyYXNx?=
 =?utf-8?Q?8A0qc0609trgz9fM0UP+7rGLEzgoy14w8bwApHid6lsaU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: nWCL3L8WKdWAPXUJ8GrmtUoC+kQucAF4DgYN/HSvwVpchHWvIeaL3Jcw9xlGRFkfg1Fnug6OmmvZXdd5b8J7mWfTyKo1DyD9GJv1mrhHCkrr2ntc2lli5mrved0SJcR8Q872YRDt27U5DityAsNIXFzA8hMMvUkWcIN6v2LCoteo2pafr7c0gQY5
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e255b2c7-cd9d-4445-f70f-08daa6715314
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 01:31:28.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20EtrSkiysSxd3sbvV1sHbQsDTVFQ1J9EYScLTrUGLU7zTFGQJjgFOuXZ0XrNSbZ0zBXLkTl+MJ19D6xiahpr4v2EfFaYvX19JpmDa7cbOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB7000
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjkvMDkvMjAyMiAyMzoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+IEZyb206IFl1LWNo
ZW5nIFl1IDx5dS1jaGVuZy55dUBpbnRlbC5jb20+DQo+DQo+IFByb2Nlc3NvcnMgc29tZXRpbWVz
IGRpcmVjdGx5IGNyZWF0ZSBXcml0ZT0wLERpcnR5PTEgUFRFcy4NCg0KRG8gdGhleT8gKFJoZXRv
cmljYWwpDQoNClllcywgdGhpcyBpcyBhIHJlbGV2YW50IGFuZWNkb3RlIGZvciB3aHkgQ0VUIGlz
bid0IGF2YWlsYWJsZSBvbiBwcmUtVEdMDQpwYXJ0cywgYnV0IGl0IG9uZSBvZiB0aGUgbW9yZSB3
cm9uZyB0aGluZ3MgdG8gaGF2ZSBhcyB0aGUgZmlyc3Qgc2VudGVuY2UNCm9mIHRoaXMgY29tbWl0
IG1lc3NhZ2UuDQoNClRoZSBwb2ludCB5b3Ugd2FudCB0byBleHByZXNzIGlzIHRoYXQgdW5kZXIg
dGhlIENFVC1TUyBzcGVjLCBSL08rRGlydHkNCmhhcyBhIG5ldyBtZWFuaW5nIGFzIHR5cGU9c2hz
dGssIHNvIHN0b3AgdXNpbmcgdGhpcyBiaXQgY29tYmluYXRpb24gZm9yDQpleGlzdGluZyBtYXBw
aW5ncy4NCg0KSSdtIG5vdCBldmVuIHN1cmUgaXQncyByZWxldmFudCB0byBub3RlIHRoYXQgQ0VU
IGNhcGFibGUgcHJvY2Vzc29ycyBjYW4NCnNldCBEIG9uIGEgUi9PIG1hcHBpbmcsIGJlY2F1c2Ug
dGhhdCBkZXBlbmRzIG9uICFDUjAuV1Agd2hpY2ggaW4gdHVybg0KcHJvaGliaXRzIENSNC5DRVQg
YmVpbmcgZW5hYmxlZC4NCg0KfkFuZHJldw0K
