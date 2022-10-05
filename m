Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9295F4DE2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 04:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJECos (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 22:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJECoW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 22:44:22 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F010726A2;
        Tue,  4 Oct 2022 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664937802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jRt/gtdfglFw86L6agpTsG1iHNWyzSxRPHgzuPnplrw=;
  b=auAhX2sGyJ44MospK9qQn/CNz+Zi54jvoG+XIMIxtm4ki6uXGzTVIiqk
   Dye5c2/mES8GByEQSJtjqDaLLupr3Qo8woCrihbJQXv2dGaFM6FHTQRgn
   o6+ih3B7HCk7IgmWAsaQ5XN0hT6EU7uVLjMJQaMX6N3XKgygGWcgUmnpI
   M=;
X-IronPort-RemoteIP: 104.47.55.102
X-IronPort-MID: 81115541
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:w5X2cqL4+NB6BbNVFE+R+pMlxSXFcZb7ZxGr2PjKsXjdYENSgWEFy
 mYeWTzSM/aCYTP9ftgjb4Xj8R9TsJPRxoNmSVBlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/vOHtIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwRgiAo
 rsemeWGULOe82MyYz98B56r8ks15q2q4G9A4jTSWNgQ1LPgvyhNZH4gDfnZw0vQGuF8AuO8T
 uDf+7C1lkuxE8AFU47Nfh7TKyXmc5aKVeS8oiM+t5uK23CukhcawKcjXMfwXG8M49m/c3Kd/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTGCFcpqHLWyKE/hlgMK05FYZIxcZLQj93z
 KNbKCENZ1O+g/uxzovuH4GAhux7RCXqFKU2nyg4iBTmV7MhS52FRLjW79hF2jt2ntpJAfvVe
 8seb3xocQjEZBpMfFwQDfrSns/x3iW5L2Ie9Q/T/PJti4TQ5FUZPLzFGdzZYNGVA+5SmV6Vv
 Dnu9GXlGBAKcteYzFJp91r837aWwH6nAer+EpWm/+RyoVS++VUVM0QoSlqjg/ahukiXDoc3x
 0s8v3BGQbIJ3FaqRdq7R1u1rHGJtRkZUdd4Eusm5QXLwa3Riy6JVjYsTTNbbtEi8sgsSlQC1
 keAt8H4GTt19raSTBq16riQvRu2OC4IMXUFYy4UCwcIi/HmoYc8iTrVQ9pjGbLzhdrwcRn0w
 jaXvG09iq8VgMojyaq25xbEjiiqq5yPSRQ6ji3TX2S4/kZ1Y4WNeYOl8x7Y4OxGIYLfSUOO1
 FAAms6D/KULCLmOiiWGQ6MKBr7Bz/iaPTzZjERHBZQt9z2xvXWkeOh44DN6YltuNcIfUTDsa
 U7X/whW4fd7NWGsYYd+eYS9AYImwMDIEcn5UdjXY8BIb5w3cxWIlAlkfk+W0GDkik82mIkwP
 J6adYCnCnNyIa5/5DOyRuobgfkny0gWymTJTo39yAqP3r+XZXrTQrAAWHOCZ/40qqONph7Y9
 f5bNs2X21NeVvHzZm/c9ot7BV0RPGITH536q8VLMOWEJ2JOHGAnFu+UyKkqe6R7kKlP0OTF5
 HewXglf0lWXrXnGLxiaL3l7aZvxUptl63E2JyohORCvwXdLSYSm6qEfX5QwerYj+apoyvscZ
 +YIeseBC/JADCXO/Ts1bJ/hoYgkfxOu7SqNMie+az84fLZrRxbO/975e03o7iZmJi+2tsZ4o
 KepyA7HU7IEXQ1pCMuQY/Wqp3u3tHQUhqR7WkrUCtZWcUTotoNtLkTZifs6LOkWJBnDzyfc3
 AGTaT8ArPfAp6co+8aPjrLsh5+kD+ZkDGJbGWfB5Lq7PCWc+XCsqadaXPuOeTnFfGLy9r+ra
 ehcw7f7KvJvtFpHr4p7Fr9DyKM1/dz0oLFGiA9jGR3jZFOxAL58Cn2Z249Ju7El7rxYowqyX
 gSU+sRGNLCOJuvhEVgMNEwkaPiO0bcfnTy6xfYyKUK84Sht8budWG1TOQWBjGpWK74dGIEiw
 eFnscoS5gqXgx8mdN2Bi0h89G+HBnMHVKoju9cRB4qDogcxw1dDaJr0BSjx75WCLd5LNyECO
 CeMmILBiq5ay06EdGA8fVDP1O9an44PozhOzVkfNxKMm9HfgeQw0gEX+jMyJixPxwtGlfw1I
 WhiMU58P42P+StlgI5IWGXEMxBcQRaZ90r+jUoUvGzfU0SsEGfKKQUA1f2l+UkY9ydZYWJd9
 bTBkGL9C2+yJof2wzc4XlNjp7r7V9tt+wbemcehWcOYA509ZjmjiairDYYVlyba7QoKrBWvj
 YFXECxYNcUX6QZ4T3UHNrSn
IronPort-HdrOrdr: A9a23:kDeHDKtQ1w/Xl5mjgQ5XN31X7skCiIAji2hC6mlwRA09TyXGra
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
   d="scan'208";a="81115541"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:43:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijz/r2MCPDjRDtCPr6XOOO8MnRGl6n0kgQy4fckoSQ9tD34gct1RO6NJkXBzdtx+mY+1zgOvJCQIpWW6ZztZyiQpkXkKprnqbhagJRuZTiXFo3FrQ+2A/6orc1/gURH2BPHwNRfAs+3joGdC5aKVzgNMsgVpB5o8UqelD3MB8YMAoGbsbSKR0Vj7K3GVApTgopk11rg7lnX5Fe7GzQ+ZG17NIfoNWRMwN0TERDfKmtx7kq/3E4LIX7NI6DIwQBcjQUfL73qkrnMN48Hp6DNSh/dmLnNfJEk/lJC6g07F+vRVFaf6G7xkElwvDg6YzHT21I56nwlhe+u91WsKZrYArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRt/gtdfglFw86L6agpTsG1iHNWyzSxRPHgzuPnplrw=;
 b=GqLZTMxNMrxLlekPBagn2febuqyjVhomjHZPaiauoIflzZlCih3TM9FXBa1S1ZE7ImGHL56ymDeJFKLQ1hxb8A6DD95QmEj5RcPjw7ZkHAC6etb20jMw4mEDbyDk6VgSK9lJ1k3TTHKASI/k7FG9+wJoFtKweHtOT/4GsBXWY6xnaHEj0kO44XQH8mUMbDxd0eF/sZDpEV6r7MUOxN8oezMyDbh6cOjMgMuP3gEiNND4kpoX3rDB7hJKjgIu8LBRbrSRS4PY73A8uhm9+7lTN00ABtLx5j0Q2EJKXsO9Xtj0OKT9MZiCdsjj/h5bod1FP2i4h0jfw6HRNc9L8ZeGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRt/gtdfglFw86L6agpTsG1iHNWyzSxRPHgzuPnplrw=;
 b=U81qNuY7/dsb08rqZBQlLrUZQbD1vhTCNr74U1oaoYGSRkd4siZ/myFZG3PqgqEbpZx3ofjR6lfUXWUwfgz709zOlZfR0HM2RMkmpNLaALGWV+zaDXYrIos8z9H71zgfS++hY1+kopogMBSiwvmWS0q2MVY9pihq20KkSNSVA8M=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CH0PR03MB5969.namprd03.prod.outlook.com (2603:10b6:610:e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 02:43:15 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 02:43:14 +0000
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
CC:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Topic: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying
 shstk
Thread-Index: AQHY2EP4TXYAyvUmfUWnvmP4OfP5eq3/F+WA
Date:   Wed, 5 Oct 2022 02:43:14 +0000
Message-ID: <052e3e8c-0bb0-fd2d-9f67-08801a72261c@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-27-rick.p.edgecombe@intel.com>
In-Reply-To: <20220929222936.14584-27-rick.p.edgecombe@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|CH0PR03MB5969:EE_
x-ms-office365-filtering-correlation-id: 37304e6d-cac7-4a7b-1e73-08daa67b59c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i20YMJEHzD7qrqOpU2jhoE64o8SVv6RU22KFc2lMw6XDK1ouLREKKcaCzZve5of+t1bqSPkL/SVgtfu/RFNFLfiZep13X4PwBU/Qv1N82Hz2YKA4kG2SocZURvmWf0XOtge46jVjwUXK8421sC3uMziEVAD/o46Jybv6VpezLCeb2lGg+kKQSf9GqebkYh9HMwPTcbHciBV31vXturmHIV25FlKMP48NW/B3I82udxxMrGeur3mbLno/cifQE3He1jiMLK6A+jc8+R9ouurx/7lZCLFO+Lp0m1qvYhb79Rx/mPVV8HnG9uCG/1ktYHefGIdKEs3724UkP2gkLyEGIUiQuXfVJqwprptvRDYXHWUyvr2pzVbEdO3VUndQS6zWo1hVXVlNP8K0zqqed+2bS2awD5x/HrBciln3qoROpiZW5kqWIWWoP191BA0/6yDalmwhkB6sl9glcdY9w7s4Sm62cTE0Idw+j6vM/txbxhLPS8MQzd5cinvekDfAkzMsA6kUBa7o9BBK9lOeGWPY5sq5Wc5Lzh3MahnKfduz30W4yey1d3Du9a5j7pQvMDxMa3bqVOpn5LD4W3Fx+jV4MQVzCGyb/MJuk93iQ8Wit31Z+BRsZjgt7PJw365cF/F3r9mww1awVq4Ebxx132nDU4mX8VyQWF2Ksu+Es1bEbXuYbTuQm/SwZZNnhko7vAAnZGbvSIs3VCD4SxdArd+8PHORl9DfdLfbQtz4bCo1BVs1IM3Mf32vARwffAYB1P6XHrcqN5terWjYZ0TX0xurEw2sc8t62xEDQmVuoY4ekEs5mBK9YlKk8AaX1pOuJztUqIl7s68vODvNColF/SZURD/y6/P9YyJ7ghU+SSS0dnyQxW1woQvPZ3KB6bGLeff1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(8936002)(31686004)(2906002)(4744005)(7416002)(7406005)(41300700001)(110136005)(316002)(31696002)(186003)(2616005)(66446008)(66476007)(36756003)(64756008)(8676002)(921005)(4326008)(66556008)(66946007)(38070700005)(91956017)(122000001)(26005)(6512007)(76116006)(6506007)(5660300002)(53546011)(82960400001)(478600001)(86362001)(6486002)(71200400001)(38100700002)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHY1ek50NkVtWlFtV05uMVBKMXpSSXYvaVdUSXBCUjFPSjU5aWY2TUlFdGxQ?=
 =?utf-8?B?U0lrQU5WRTZsTXpxWXpqL0F4QVNZaFlIcEx1NGNEQ0NhRGJPaDJmUk53UlBj?=
 =?utf-8?B?cXdpcGF3Ry91R2pqUkFSVUNlTmJHelR2WXJzaUx6d0NCTHJXdDdoeDNIL0dI?=
 =?utf-8?B?MTZNWXB5b3JmNmFEdFRFbFk5KzBNWGxtcUtnci9TMUZabXVoc0UxMVovNVho?=
 =?utf-8?B?cnFPSnlONW1KMlRlUWZINC9hQytXalh0RzB6ZXZOeUpxcXBoYS9nVXgzZUJh?=
 =?utf-8?B?ODZ1UzhkUVc3eDRuTDdGdXNDeERuaEVXNTE3bEcvRXlpaDU1ck9DYWxscHlR?=
 =?utf-8?B?TVVnSmZKc3ZUcHN4ZUhSWG1OY1NtejNrYk94UkJNTUtYeHNmUVNIOWFIaVJi?=
 =?utf-8?B?Qnp5UGlhY2VvaUZCVVhnTWlabjJzRllaNWFIdGYweTdWSzRBN2JNSHMxY0kz?=
 =?utf-8?B?T3ZTelNEYUUwV0Noa3NPaFFCVWM4SkthOUZ2UU9VUVZJR0JRbmhiVTdQVjc4?=
 =?utf-8?B?eXVKWDlCNEZpT1NtTFFPNW5EY21McVozajRnL3VrU2hReWRpdlp1QUNCWlo3?=
 =?utf-8?B?ODBjZnN3aU5xSHhhdGlEWkQzQnlKVmhESnFnNktvellsaC93aWpEVUU4d1VC?=
 =?utf-8?B?QTFud2N2Vi9OUEQ5b1dmZUJKNU9mbmtHZFJ0RktXSEQyRFVLVzNTMXJJQTFq?=
 =?utf-8?B?VlprNGhCZ3ZaSWVzbngzdi9NeGtkWDFEVlgwcCtSektzMktEV3EreGxSNWpH?=
 =?utf-8?B?ais3aWJCT1JKYk83OEdXMm5BdUxDZDE2R05EeTh5ZW94QVZWZFkxa0txazVv?=
 =?utf-8?B?VS9La1pHaVNieWVUUUw0T1lDZFlBeGJXMThMZmlZV0FlbjFUL2VEOGROMDYx?=
 =?utf-8?B?V1pFcVJxZVN5MCtBZHZHNkJSVGdqa3hXTi9DM042Mkg5dVJlWHVKaHZRbWJG?=
 =?utf-8?B?Ly9ldDQ1aGYrVjFJaXk3MUFpN1FPR2pMeHZpdHNxeXlEM0lxRnlzNmJBMm5G?=
 =?utf-8?B?RkVicFFEUktLZXBJUTgrbThWSkhRUHZJRUR3MkcvbHJPbyt3cE1GS2hWTlRY?=
 =?utf-8?B?YnNxaWFrbmtLc1k4dXRjQm5IRE9UTkw2QkRrUzE0OS9SdG1CNUEralBNTkFM?=
 =?utf-8?B?MDBBLzFvR20yRlRLNm5jL0pqbHY2UUtReU9GQk1XWEtWSmhkcWdPdDlNay9y?=
 =?utf-8?B?cWhZZXd4eDVGd21yNG1DNjR3UnBHRG52U2xoREV0M2hsZjF0OWgxcTI4OWdO?=
 =?utf-8?B?MURlb3hQUDBwUVRWNE90WEwyL0pSZHNGUzlNUDZtNlRBTk1STnJnaHBQSEhG?=
 =?utf-8?B?akhyeTloOFk4UXJzTUZtVDI5Ni8xMDU1Mzg2VEZvN1lmZlZBcHh1NjlNUlNi?=
 =?utf-8?B?Nnl5UjlmNnU1S0Exb096U1RlQmxzL1dVci8zOGR4SHdYMXBhMFFxOHJhcjla?=
 =?utf-8?B?dDNFeVE3aE4vcm8rRUpuUTN2emZmeU82NGZFcnZCY0Z0K01mRHE5dXoybXdz?=
 =?utf-8?B?NE56V1FEZ1VsbVZuY2JDZkVHaUpXMWErYldaZmJUaklBME5ib3N5K1M1cXlD?=
 =?utf-8?B?WFQ0OUtldlQwNHV6clBKdS8vNnhySFBGYW9uTUUyaGwwbm83dXNqSDNmZGhB?=
 =?utf-8?B?NTVmVXNnSHpuWWlFWjl3dklGSUtzSU1EclJaMjlZUFZzL0JaZE9ZSi9VSEhN?=
 =?utf-8?B?djMwR280R0Z1dldwZldwM0pQdmFVZll4R3F3OVlpOXgzeUhFVzZ0NW1xdGly?=
 =?utf-8?B?YnZoM09hSjdCcWs3czNrNWlTSU9aU0xzSzROUG9BS0RRUjF0dENrek5WeWVo?=
 =?utf-8?B?eHVWdzU4cUpyTUhEZDV4ZzlJaGhHdnhyblErYWdUbElpcGk3Y1plQWFlZ2dU?=
 =?utf-8?B?TDJVMU55Mmh5ZlQwMWdsaDM1SnBLVVJ4NUpXZzNSL3lxeXg3eWdUdkFORm9m?=
 =?utf-8?B?c0M0TnBHV2k3Z1dmWmZJK1FINTd2cGNHRElTOGs0ZlJ4QXRBQmlhZGg3U1NE?=
 =?utf-8?B?WTU2dkNDQ29FTlVoK2NVRkxtVm5veUswRHBUQk8zMTBCL1RLZk4wcFcrVjhr?=
 =?utf-8?B?WitYUEE0QVV3TVB2aDJiNm01UXRqSGJlRWZzWFRMLzBxaTZjSll5cFdNZTBC?=
 =?utf-8?Q?olukCtmSkFN2k6MXS9uREEi7L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C02FE1E811A1C84E87D5C55B25A50DC2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TUY4eGFQQ3dlRDBtUGVTVElLZXZGQ0JGeDRwZCtnVjBFeDJ3S0tDYkduZ29m?=
 =?utf-8?B?U1BCSWN6a0dTay9YWm42UE1XMjZYa1pSRnBUZ2RjYm9Lc2FkU1FQWEZoN2w4?=
 =?utf-8?B?REJNaDltK0kwTWtWUXBUWmNONTRUeU5Wc0JaWjVyZDNUUFhINjV5bmpHOWNF?=
 =?utf-8?B?NjJ5R2VUMmRDZnpDUE5sN0FqZEduT3hXUnRYZUNmTlZ3VHhQbkJRaXZVT1VX?=
 =?utf-8?B?S0pNSU5KUGFvbHNTL3NUMUY1VTlTanQ1RzhJOS9yTkM2Tk5STXRBc2FHVDZ4?=
 =?utf-8?B?NjAyR0lIcHFvRW9KRklnNWNDMUlmTlFSRWQrRVFFWjlZVlNzajhRWXJjSXNm?=
 =?utf-8?B?N3F1bFVOT0hNcXYyaVh6NzhxODJBQ0tkcThLd21reEw4L2ZVQkhLLzJqRWRD?=
 =?utf-8?B?M2JTTWZFa2diZzRpbVF0YU0rR212c2labDUrYTIybUJYMGJnRW44WjVsSVZa?=
 =?utf-8?B?c1I1QXlWNW94cm1IdkdNRnBMd3ZjZUdUYVJzdFVmYWhOdXBzcThLNy8zK1FZ?=
 =?utf-8?B?Vi83SHFVLy9mSnFBUzRvUjFmayt6Mm5pQ2w0aUZNSk0wM3FOZE03ZkVZWW9T?=
 =?utf-8?B?NDFRcG93aXl5d3FicTQrRllNeEZwTVNLOUdPOXF0UFVDa0h0WFEvTUpGNHNz?=
 =?utf-8?B?TFlQMlUyWEMramIySUIyT3JXVEJaUEsxVWs4UlpRRTRRdmhsRnliaG9STThp?=
 =?utf-8?B?ZE1zZFdzYjB5Zmw1cGxEU1J5clVxV0pvUGlVMklGTC8xb2FUQzc2RW5sRm42?=
 =?utf-8?B?ekdxaFB0SnhOMzJrUVpxK2IyMUwxd0RzVytjLzF4b2lmVUFNeG1jc3ZvTmdr?=
 =?utf-8?B?dnB5MEFYU0sxdzduQVJtS285ZjAyNklTTW85OGZ5MmJnbGYvby9jZ05TQi82?=
 =?utf-8?B?WEZtN2Rtc0w5SmFJNERxU3BxcVhmSnVBejN4UkdVbTZQOVFQOE1Zdzd6N1RH?=
 =?utf-8?B?MnFSU3pSZTdCdGdHSGpaTkIvaG5MRlBEUW9FOHNjeUZ6Rjd3cmpLOUdFTG9K?=
 =?utf-8?B?SGpFY2ZhdlBnRVJyU2pkUmdMS1BsVlFycXpOTDdBQWhPOG5Ca2R2TTFFb3hz?=
 =?utf-8?B?NkRoZXpycVl2UVVtRGpqQ1FRNWJBNmhKVDQ2WWZQTEx2RnZwYjFuclc0TG0w?=
 =?utf-8?B?UGRFVlp5aUpabGVwMzdTaU9TRWdMWWErSnQ4ck15QkVqUys5V0x1dy9XbUNu?=
 =?utf-8?B?a1EyOExya3NRS2RYZCtGWjdXTmtoWW81Zm9RQStzU3NFcCtqYnRyV1Q0ckEz?=
 =?utf-8?B?M2pzUm82cXluOXlvTmJuZVZzanpnTzFBRUQrYnFBVUcrSUk0bFA5aEduM3Ir?=
 =?utf-8?B?cm16NVlEZkY2RCtaVk42MWhLVEtUeEpBdVhvWHdyMHhScUtCMmsyellsclVh?=
 =?utf-8?B?aEozeFpVQi9oZVIrVTE2VFphMzkzc205Vmt3ejNtUldlODZrZWxQNVp6dmF0?=
 =?utf-8?B?NHFiTFAyZ25DeXNjY2E0dkxwbXFCdlF3Q2tBR1JRbnRMamMyOUVmODBNUUp5?=
 =?utf-8?B?NmQzbEtrQ2ppSStEbUdabmpZUm5Ra2hNMVc3YUs5QytNZndHMTZGOUlQN0t4?=
 =?utf-8?B?RVdFWWNSWFkyOVd2K011REVVQ0w4V0QraHdTNVcwWXRnU0txVmNLUHdldUJY?=
 =?utf-8?B?blRsWU16TnVZNk5MWENWbnBhQ2NKWjJVRlFkdEdtWWdjT1ZKVC9sbVlXcGti?=
 =?utf-8?B?N1ROZG9ZNE9WRkdUc3k3RXJaTWpVOVVDZ2haTEMzWkwvVGhHZFd1T1M4TVo5?=
 =?utf-8?B?L3BCUm9lUXdIZ1ZnZ2ZvclRxejZ2SmFyVlNoaUM3MGd2R0dMM256a3pJeDJy?=
 =?utf-8?B?TytKdmY4SG1ORVJiN3IrdURhelNJNXVwUm1RTERuWVBXcit1cXN0OGRXLzc5?=
 =?utf-8?B?bmt1QkRzeW5EZDZDZUFXTUpDTzBrWTRGa0crcTZRaWEyTndCck95dWRBbDdq?=
 =?utf-8?B?TzVWMjB4QmR1bkYvcEF3MG05ak5HNGxrc1Z1Y3NYRVJ1ZFpudmlwODdodW51?=
 =?utf-8?B?d0RJMFdQdTdhd1FnU1pUcXlQVExsQzZaTDlWeWRjMXJ3YnRoYnJVYVErVnJ2?=
 =?utf-8?B?MG5TZmlZWnNmN2sxSGZmcmQ1NisxMVBhQ1UzcmxpNEJXRWFVcWxCNGpGYTBy?=
 =?utf-8?B?WS9DQjM2c3I3azUvMkJvcU1Ma1U2bU1mVGlyK0RCVDhvTjZWVFVXQUZzdUpP?=
 =?utf-8?B?OWlrNkZTbUVLdVJxSmRpODJKRHhDM0lBQ1Z6WExmSVdTYW5qZG5aUW1pS1VR?=
 =?utf-8?B?VHo1UU9rZlZwNWlnVXpMS2dJUjg5Y1hRR1BkOVlLbXAxRm5qdStGam5QczBQ?=
 =?utf-8?B?Y3JKRTYyS2lMVHgvT0xBZVQ5ck5rTjM0NWcrVzVQOG5HaFdCd0Y3bnFrd2lm?=
 =?utf-8?Q?ovqND5oVvXydLdwNxCILOLcur/WzjXBYuPffxwglXdSi9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: 32vItH6e9ERGFuQAJZ2c7r2XZk0zxHmziutdvUCB1+xgISHNmzFlzDnROKLiHdqXWYCWDoSRkga9prJYDovujFZgQywgQ+pEh5+U8GYM5gNnzAe39EOHARFiItruieMJXjMA1QYCy0Lkxw3WZmMm0tGG3Hpj+KCztZE=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37304e6d-cac7-4a7b-1e73-08daa67b59c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 02:43:14.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqRx7Na/r1DVzx+UzisctJM82MvTyBLU3wGKHPS5HGCt+Ak0hDFR68esIxxuyb09PJDOpn5muEuODGE6r6O3SfWk0e8D9SByde7BxkCZfWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5969
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMjkvMDkvMjAyMiAyMzoyOSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+IGRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmggYi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9zcGVjaWFsX2luc25zLmgNCj4gaW5kZXggMzVmNzA5ZjYxOWZiLi5mMDk2ZjUyYmQwNTkg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaA0KPiAr
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zcGVjaWFsX2luc25zLmgNCj4gQEAgLTIyMyw2ICsy
MjMsMTkgQEAgc3RhdGljIGlubGluZSB2b2lkIGNsd2Iodm9sYXRpbGUgdm9pZCAqX19wKQ0KPiAg
CQk6IFtwYXhdICJhIiAocCkpOw0KPiAgfQ0KPiAgDQo+ICsjaWZkZWYgQ09ORklHX1g4Nl9TSEFE
T1dfU1RBQ0sNCj4gK3N0YXRpYyBpbmxpbmUgaW50IHdyaXRlX3VzZXJfc2hzdGtfNjQodTY0IF9f
dXNlciAqYWRkciwgdTY0IHZhbCkNCj4gK3sNCj4gKwlhc21fdm9sYXRpbGVfZ290bygiMTogd3J1
c3NxICVbdmFsXSwgKCVbYWRkcl0pXG4iDQo+ICsJCQkgIF9BU01fRVhUQUJMRSgxYiwgJWxbZmFp
bF0pDQo+ICsJCQkgIDo6IFthZGRyXSAiciIgKGFkZHIpLCBbdmFsXSAiciIgKHZhbCkNCj4gKwkJ
CSAgOjogZmFpbCk7DQoNCiIxOiB3cnNzcSAlW3ZhbF0sICVbYWRkcl1cbiINCl9BU01fRVhUQUJM
RSgxYiwgJWxbZmFpbF0pDQo6IFthZGRyXSAiK20iICgqYWRkcikNCjogW3ZhbF0gInIiICh2YWwp
DQo6OiBmYWlsDQoNCk90aGVyd2lzZSB5b3UndmUgZmFpbGVkIHRvIHRlbGwgdGhlIGNvbXBpbGVy
IHRoYXQgeW91IHdyb3RlIHRvICphZGRyLg0KDQpXaXRoIHRoYXQgZml4ZWQsIGl0J3Mgbm90IHZv
bGF0aWxlIGJlY2F1c2UgdGhlcmUgYXJlIG5vIHVuZXhwcmVzc2VkIHNpZGUNCmVmZmVjdHMuDQoN
Cn5BbmRyZXcNCg==
