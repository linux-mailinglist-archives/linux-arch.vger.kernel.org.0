Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCCE5F4DB7
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 04:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJECbf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 22:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJECbe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 22:31:34 -0400
Received: from esa5.hc3370-68.iphmx.com (esa5.hc3370-68.iphmx.com [216.71.155.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8971BEE;
        Tue,  4 Oct 2022 19:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664937091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WIJF3lHUj0X8cpNBXNmvOLhQleGPncuL8eO0nQ0Rriw=;
  b=Vt0ZkJAxZ6NfNav7nunbbkkcE3sNsDSOTg0609XXPm/aO1ScEVh+/dfE
   2Qr/QqrImh50N5fnhyWQBhPgl9OtpxIL1KbooPU4VKUwgBkuT5Yc6JzT1
   bk0hcYY2cD8xCvOnJI3F5BV8m4/Y9zEKNKoVbKvHyC+aFFfqeh9Y8tG2x
   s=;
X-IronPort-RemoteIP: 104.47.70.107
X-IronPort-MID: 81115211
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:TJcm+KiW9xiitkCVpW0l1/fWX161SxYKZh0ujC45NGQN5FlHY01je
 htvX2+OaPrYMzD8fd92Otjl80gA7cXdm9JqGQpvrnwwFS8b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrSCYkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw//F+U4HUMja4mtC5AVmPawT4DcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KUpfp
 dYWb3c0VR+k3vzs47blULEyqu12eaEHPKtH0p1h5RfwKK9+BLrlHODN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvDCVlVQuuFTuGIO9ltiibMNZhEuH4
 EnB+Hz0GEoyP92D0zuVtHmrg4cjmAurAdtLSefhr5aGhnW66FRLLwQzcmCmnuPn00GFcM4FK
 nYtr39GQa8asRbDosPGdx61rWWPuRkfc9FQCeo/6RyIjK3O7G6xHGkPTXhZLtEqu8I9Qjkg2
 3eImc/kAXpkt7j9YWLNqJ+XoCm0NCxTKnUNDQcEVQIt8cj/p5t1hRXKJv5/H6qlptn0Hyzs2
 TeMrTh4i7h7pcsK0aq81UrKjzKlut7CSQtdzgHWWH+1qwB0foioY6S25lXBq/VNNoCUSh+Gp
 ndss8yf6v0eSJ2KnwSTT+gXWrKk/fCINHvbm1EHN5Q65i6F4XOvfYlMpjp5IS9BPNkJeDrke
 mfJtA9R7YMVN3yvBYdzYoSsG4Ej1anIC9voTLbXY8BIb5w3cxWIlAlnf0ic92n3lkQm160yU
 b+fbNqrJXUXE6JqyHyxXeh1+bUwxyYxxWrJQory5xui2LuaInWSTN8tOkOmZ+Q44aXU5gnYm
 /5QMNGB1hNYTsXxZyDW9cgYKlViBXQyG52wq8VRbeOFCg5nHnwxTf7X3b4lPYdimsx9kubO4
 2H4X0pwy0T2jn6BLh+FAlhnabXyTdN2t3k7FTIjMEzu2HU5Z4urqqAFePMffbsjsvBkyvpvZ
 /YAcsSERP9IT1zv5Dkcb5j0qoMkZR2tiiqPOTaoZH40eJsIbwfO4NXpYiPr6y9ICCer3eM7o
 r6tkADBSIQOWxZKC9zfY/aiiVi2uBA1nut+VlWOK9xSZG3j9YFrL2r6ifpfC8YIJBrr3DaW1
 w+KRxwfoIHlu4Yr/d3hmKub6Yy7e8NmE1ZXBXvz7LC4LyDW82Ovh4haX46gZzzAUmf94I2jY
 +tPxv3xOfFBm0xF26JwHqpryqc3z97urKVd1QNqADPAaFHDIrFpJH+G9cZIsaJJy/lSvg7ec
 kGO4NhePfOSON75HVsWOiIhb+KexbcVnCXf6bI+J0CSzC1w9b3BVEJIMhiWgQRcKqd4NMUux
 uJJkMwR6wr5gx4uP9CuhyVYsW+LKxQoUK4snp4dB4Dvh0wgzVQqSZHGAyn36ZenZNJLPU0nZ
 DSTgcLqnaxE2mLBfmA1GHyL2vBS7bwMsRVN1kUDPHyNm9zYlrky3RZL9i8wQBgTxRJCu8ppM
 3ZqcVMzPqWH+TRhnuBCWXyhH0dKAxjx0l3sjlAJmWvWCVi1fm3LMGA5f+2K+SgkH3l0ezFa+
 PSSzjnjWDOzJMXphHJqBghituDpSsF3+kvagse7Es+ZHp48Jz34nqupYmlOoBziaS8suHD6S
 SBR1L4YQcXG2eQ4/8XX16HyOWwsdS25
IronPort-HdrOrdr: A9a23:xWjlRaDow5yhYJ/lHehSsseALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U0ssHFJo6HiBEEZKUmsuKKdkrNhR4tKOzOW9FdATbsSp7cKpgeNJ8SQzJ876U
 4NSclD4ZjLfCBHZKXBkUaF+rQbsb+6GcmT7I+woUuFDzsaEp2IhD0JaDpzZ3cGIDWucqBJca
 Z0iPAmmxOQPVAsKuirDHgMWObO4/XNiZLdeBYDQzI39QWUijusybjiVzyVxA0XXT9jyaortT
 GtqX252oyT99WAjjPM3W7a6Jpb3PPn19t4HcSJzuQFNzn2jQ6sRYJ5H5mPpio8ru2D4Esj1I
 GkmWZhA+1Dr1fqOk2lqxrk3AftlB4o9n/Z0FedxVfzvMDjQzo+KsxZwaZUaAHQ5UYMtMx1lI
 hLw2WanZxKCg6oplWy2/H4EzVR0makq3srluAey1ZFV5EFVbNXpYsDuGtIDZYpBkvBmcIaOd
 grKPuZyOddcFucYXyclHJo2saQUnM6GQrDalQeu/aSzyNdkBlCvg4lLY0k7zM9HaAGOt95Dt
 f/Q/1VfXZ1P5crhJdGdaA8qA2MezfwqFz3QTivyB/cZdw60jr22uLKCfMOlaKXkdUzveUPcN
 6qaiImiUciP03pEsGAx5tN71TER3i8Ry3kzoVE64F+oaCUfsujDcSvciFYryKbmYRoPuTLH/
 KofJ5GCf7qKmXjXY5Pwg3lQpFXbX0TStcctNo3U0+H5pujEPygisXLNPLIYLb9GzctXW3yRn
 MFQTjoPc1FqkSmQGXxjhTdU27kPkb/4ZVzGq7H+PV78vlECqRc9gwOzVip7MCCLjNP9qQwYU
 tlObvi1ri2oGGnlFy4m1mB+iAte3q9zI+QIE+i/zV6Qn8cWYxzy+m3aCRVwGaNIAN5QoffDB
 Nfzm4Hi56KEw==
X-IronPort-AV: E=Sophos;i="5.95,159,1661832000"; 
   d="scan'208";a="81115211"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:31:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7zQ5t3VS22LeLt8WtCNf9HXrgIeskq1uh+3PApRUZHQSrBVWl5zJq4GB5gTtg+zqgU+uyLUK9xDwEWhQwKP0GorAe0QcsNueQLl8WpwGRo1dKEku4naeT+qCzDInUujWc2nTD8O1zlqBwn6kW1F9/0/9InCNDCWrQn9/A6Et0Bkb6nm6snIKJ1ajZCk/fJn7t7GkLRfiWdnu3y8Chm7A9FB4Q53+SrAQFjWi4iBbRvAyD9NWjQsXEPlHyisfP7hQ8Vvdd5/3eoXXYy/F64oblHVBxqUeZon8cvQI5b9YpHayUddF+Af7PFh6W9oQcckNOg0SmC9G7j4vkmJuqgTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIJF3lHUj0X8cpNBXNmvOLhQleGPncuL8eO0nQ0Rriw=;
 b=Vp1hQk1/oVg6+ec8zqstJqgYFCM6jOoUqfYyXv6KytaDronvQtwcbNef5MJ2rhkHhNOHVN2yK8UBI/1XKZcZeJRhJET3EO0IDCTqppkbUcE5C68aaGOO2ZUGSddKAT2F3hffeDr9QBhR5TtlaW2Xk7cEbJLeldmFWn1OdTuslmVKT0HdCJQxg3c2/hErVzVnvMbp8HZY4fD6Zl9bpuKWsshDfIP0EePkAIVibZbrdvRdvnU2fIZJHBgi01cPD6t00RLiN9FbSqpcJnxLiRG1EKt0i7JALY/tA+Q77n/rOIlNdK68EiCPWLz7ethGHxM+s8dcniN18lwL9H3hDqWt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIJF3lHUj0X8cpNBXNmvOLhQleGPncuL8eO0nQ0Rriw=;
 b=DFClX9N2dd6Y+jlr4igjg/0ybGlp+T0VIOlPJxn76w4zrYXVZl0wkPKK0/K6Rm0TDqHsHZ+sqJcD9IIgFxJlHnzNYH2aVM60DABWHhCbFbQe+afcLYD2a8RpRQ6N5HTRLF8Sv2cGqWufJQq+3DuhX2j3bbcPQJlxmMaAMwmr7ZU=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by SJ0PR03MB5854.namprd03.prod.outlook.com (2603:10b6:a03:2d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 02:30:56 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 02:30:56 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
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
Thread-Index: AQHY2EPhEQwcvkF0f0Gd0+5UmjC5K63/FHWA
Date:   Wed, 5 Oct 2022 02:30:56 +0000
Message-ID: <37ef8d93-8bd2-ae5e-4508-9be090231d06@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-19-rick.p.edgecombe@intel.com>
 <202210031127.C6CF796@keescook>
In-Reply-To: <202210031127.C6CF796@keescook>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|SJ0PR03MB5854:EE_
x-ms-office365-filtering-correlation-id: 3faa831a-22a0-4ed4-6991-08daa679a1dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ipmobnWfF3/dE/RC3svOiKk7ZpdurKw4nAjpYFGrW0lAxtxaliiLlDyz1Xk1MsYOFQ/IPz+eXa2uwaozRpAIBbh7mttaRpJfwqiouEDvWfzfxNCd4NqHkTK6gMPaVP1ntyCHedw8jy8l2mvADLl7eGsGh3xwCOFYSQPfsciurUt76d5T+IMBVJBnjUdwCCT2ZW+lsqxOQnia8HvX6F6iX0qrksYoJi4X9+4MEBHuQdXeUS0iYlzAbi/Iw0vo1997+uiTyI89wADhNCoWQCYG8/Y2EIWvEDoH07mYBAQ+gjso5/lqzpI1Z0kOB+PbmcjAB0GmsSAqTFRkXt1afvv7r+5lteZolm+YguSpfIrdr7njW/PVIP5fKSdJb7mxCX6nLNduEAwhmTd1lAFl+vMTV5cDlkOG0v0fMmxJbmSbZGVbApJ9U2XcH0vkbVEXSIt3JqmB2lgLP9ZWwjoMhDXmG2FBVpM6Xhc/BGZAOiKUdd39QFtdWCXHTO7RRM/K7jinnP6rUMrPDLP7kIjcCm7oE41h9oxku84sCAb+wVDW9B6IGMkhDl7g4geo+uEWlM+MRHxaKlrPH8TzUCEKvX+5hjv/JWhswuTzu4Qyv/b9ad1XGHhUjuklpdViRI6Po9ePhlU6FOvJAs/atap+z7WghzE1LdKsmsZfiP6ZAcOoWJw7wcSk80mTwE2n9GjgcGP42bfBdOzLJAJ/BAiUlKPTKly/DjXuMY78zuSMSb+SlIw3iDuqnpS/UM0lUeacisVvBnZ2F5QC1njvGyjCSZU6DxVUEGi/RYC84Y9z9yi/SH4xyH+ZXSMgmN3krCAnVItvuQmgIxaWCY5Usn57eg136w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199015)(66476007)(53546011)(54906003)(6506007)(26005)(71200400001)(82960400001)(36756003)(6486002)(41300700001)(66446008)(38070700005)(107886003)(8936002)(122000001)(91956017)(110136005)(38100700002)(478600001)(64756008)(66556008)(4326008)(66946007)(316002)(2906002)(186003)(8676002)(31696002)(76116006)(7416002)(7406005)(31686004)(86362001)(5660300002)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckJ5bE5kcHdGenZPYUc4amQ4UW4vMGhxcUE0aGcvSTM4bTlTUlpySkJUYVNG?=
 =?utf-8?B?RmM5ZE40REJ4UnJRaGJxckRsTnJ0d3VQelZ2eXZiTkMxbFVKN0JqaFdsa3do?=
 =?utf-8?B?R2NiOFh4WUgyNm05QUJhUGVNeEVuVlo5Q01SckMrVUQweUFzdFFwckt4RHNk?=
 =?utf-8?B?dzVia1dKeHFPNStRbm1UWktCQmlsbUJoeXloMDlxb0k0dmpFRUVWUk4vckdv?=
 =?utf-8?B?Ukc3WVRUOWtKaXFxd055VzRjajgrK2J2NlVZZFE3U05TeldXZUV3Z3lOWCtl?=
 =?utf-8?B?RFkvbTdpS3JZeWEzK2J6alVGV2M0eFZVNUZCUytUa05BZHZLdTZMQnBha091?=
 =?utf-8?B?aXdPRmlSemNoTVVhUjhJSWNxMHY0NUJIcmZIY2hndk5ZbWg4QUIzbEYyYTcr?=
 =?utf-8?B?NEhCVVQ4U2JrektNYnliUHlUNnZiMWt6ZlNtRE1FSGJCT3I5TitWYjZoUjV4?=
 =?utf-8?B?Qzg5OWR4clY1NGlGSE9vYThCLzFjblFVbFhtdDl2NlJZb0pqanptbk82L2hC?=
 =?utf-8?B?dy95NDJ5ekVlcWNReENYZFExbGwvSVV4aHNJbUIxTDN3OWdBRm11Z3BEUXQz?=
 =?utf-8?B?d09qQ3lsOHRPTFZtQ0xjc0FFM25XTDNJLzVSS2dGM1JVcU1VeU1qUTl0d3lF?=
 =?utf-8?B?ODNHTitaVDd3L0ZyYTRJcGRHZVBLanA1MWF6b2RTazZwWVpCd0RQWDB2ZHBr?=
 =?utf-8?B?Sy91NUV2Z1ZUbDROWVBicE9Zb1VKNXdqTUE0TkU3M05KL2toaytxdEo1RWRa?=
 =?utf-8?B?TkNIQ3BlMFBmWGRqQm96R1FOd1NNaHRzNVdJTk9WZWJ0b3hOT040MitlWXJq?=
 =?utf-8?B?Q2JOdnEzRHNjRjR0dkg4L1RxSEllS29sSGViT2lTZGppZ2FqUkF0c3UreFVl?=
 =?utf-8?B?L3lhVzkvUnVRbWJmSjdTVjA2cG1MS0FMYzRQRm9HRjNybEZRbmU5SmEzaTlk?=
 =?utf-8?B?M0wxQVVwalhTN3IwSjRXK0JqcDh3bHhxbHpwTE1QdDNxeTVUSkJRUmliamxS?=
 =?utf-8?B?R0VMcFcyc25Ga1JTdEQrUzA2OTFDWVY1QXpRNVdoTkdmMG8rU0dhZWNVakhG?=
 =?utf-8?B?MEhaVitTYnVCWnFGdEp0NFhIUi9IWFRaY0dvQWx6TndIT0lwQjRyOVl4aVU0?=
 =?utf-8?B?VURSTnhvTzRaemVVMnB3SGpYRmFGVVJqSjk1U2UzTVVpZmpGZjBva1JkK0xm?=
 =?utf-8?B?NDNkUzdYTEhUOHVCaDZIbk1mVWJIb3pJVmRSdnlnRVpheXEwL1luTm5TWTVk?=
 =?utf-8?B?eThkbktGVlM4Y1BRNWRFdUNPdFNNNy9GMDRNTERieTVCSXIwNW1XN3RPUTZZ?=
 =?utf-8?B?V2U5bVJWZ0dBL1ZOMGIwL0FtdWJodldISUJqRm16Z2IzSHpsTzkyMk5nN0N0?=
 =?utf-8?B?Q3FTYzJRSSs3Sks2UmUwSWZmWkNPdm41YnFnZGRoaHYrKzhBT2x4c3BTWTBP?=
 =?utf-8?B?L0R6SlVXcWZwSnZET1lCZUFtakVyR0NzbXJiZ0lnWnh5Vk1EUmkrSk8xNEdD?=
 =?utf-8?B?ZFBVK2MyU08reGFOQUxyL1FuN3FqcU45RnRxTElRQzNPVm5IT095N041eTk4?=
 =?utf-8?B?cVIyNFI1bHhHOXNqZElHSGJ5TTY1WVNOSzl2K0ZyVkc5UEQ5bVMwb2k4QXUr?=
 =?utf-8?B?N0htU2ttWGhGUTNEaEkwZ1NLY0lyT0ZvQUc1YWg2cUxNMDNFam5rT0dzWGo1?=
 =?utf-8?B?b0FLRzRISjdTeWRVR1hwZnlyWGJhMDVDYW1iS2NtLzBFOHlPcTBHd0hDSjNy?=
 =?utf-8?B?NytPVUUxZkVOMDZ1YlJKbTJCa1k2V0NwYXk0ZDFxVWhPWS90aEJTbEY2S2VR?=
 =?utf-8?B?bWs2M3V6MFZDejZZSUxXblEycVQ5RlN0MDlGbVlVb0l1ZWdzQXNRUC96WVZw?=
 =?utf-8?B?dURGRHo0dVR1SEZQdlU3NTh3ek1JdGZhbmNQVFVDWG5peXpVYURCcGhjMTl6?=
 =?utf-8?B?UElqQmFUTlNhTms5R2FLZ2JENFJyVE8veGhSejBtL1BvVi9Lcnl5aTYvREF4?=
 =?utf-8?B?VjBhUnI3OXR2VitTQ0kzdXZBRGc2eUMxUGRCbXBGalc1SHE4YXN2YjdINXdP?=
 =?utf-8?B?WnFmc2R5Q01GbkpSYW1ONjA4OS9LamluelhkbUYvUGl5ZDdFaGczVDhiT0hn?=
 =?utf-8?Q?j3BK4kWbRnL7sNgh6NTMhR97s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46F562CBC47E144A977D128B4E4549C3@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OVNsQkcrSXhkQjZNTXNPbEZORXFLRTE2TENITmZkUXB3QWpkejd6Q0RIb2Q1?=
 =?utf-8?B?VmFCRDEra08wd0lNenRyT2lqUEZXVWJnWWJ5Y1o4ZmRmWkd2WnhBQmxYUHFv?=
 =?utf-8?B?czhTbExTeU9pbUhUY3c0SHZYOFZQV2hqbzBPK1JVcHpycVZTMlNsVHV3YTNJ?=
 =?utf-8?B?MDBYUHFhTjNIUlRUK1Zyd3B4Y2RrcCtrTDhXdzF4dk5WS0YveG45QlU2b2VI?=
 =?utf-8?B?dU5uRXQ4TFFtSzFjTzBzSGJzSUoxZ1Q1OHFGUGdseGRjSCt5QWw4YVlNMWFP?=
 =?utf-8?B?NlNQQ1QzVVhrWmNrdFNXOGM2TWJxVjU0QXVYc1pLYStqYktwWTJxcXVhOE40?=
 =?utf-8?B?VXdtdzVWdW5mZjU5YVFWYTlFRlRHVEdCdzhhcUhyeWtHcUhTSEVBKzAybEZa?=
 =?utf-8?B?bVk4ZHhaSUk2enIwaUt4VHcxWkZQMWlLbXp6RmV0cGNEc2lrQjJpTkRobkEx?=
 =?utf-8?B?eW13T0ZOS0RQbDlZZFFrd2dMTHM4RTQ3SUtmWnQ3OHcxaEhkNGErUElpMmp1?=
 =?utf-8?B?RjhVN0xxeDFIdzZpdHZiMjFnQ1hpOTFxMlFFRGU5dEcyOVUxNitRNVFVbVZv?=
 =?utf-8?B?UFppd1FhSTU1S3Zqdnpsa0Y4a3k3bUZEbDVzL2ppTTFURWNNNHA1NzJ5U1FQ?=
 =?utf-8?B?bmdtOFQ1NlpvVlM3THZjbzgrWWN5cnVrd3VNQUhMb2VoVzZYNFBlUVYxQXcw?=
 =?utf-8?B?R1dqOXJhYTBsd2lqTEpHVTNjdmZvN0VaeUV1RHMzczJpY25DbkgzVHZXaVVF?=
 =?utf-8?B?S3pRLzVaQ3BJUmtjMVJvdjhCOWZxSTZNeWZ2eHdiakNkaXE3T0dtNWZTRHhR?=
 =?utf-8?B?ZUxyMDM1Z2xCYk1LOE1jVWlEVVNVWlJ3Vmt2VDMxVHR2ZlVsY1VlV0NzRFVm?=
 =?utf-8?B?a3NRWUQzd1VIZ3dwWHQ3LzRUR0YrMERyandpV2hvV1RtMXc4N0tPUjMrVkFx?=
 =?utf-8?B?MDJtR282ZU9vN0JvY3RUQ0VzdFVlMjU1SU9BQmdHRTZWS2xkZk1pNVdVWG5U?=
 =?utf-8?B?b2pRT09jMFJrN1pwZ05jM2o1RlNrU2FnbG52ZDNQWlBYN1ErejFhZmY1ZTd4?=
 =?utf-8?B?OFBSSVFjTW5XMGNzOTNNeE53TWs2K0RNS05NUk1IdGRqWnIxcEtjcUJIN0p0?=
 =?utf-8?B?TFYzdDA0MnJrZHBrK0FJVVNrdWZ0SFRqaUp4N05pV1pSR3R1UkRWTFc5LzdP?=
 =?utf-8?B?MWVZeGN4alJmSWxjekQ2SC9FaDNrNkNZbWNaaHR5SUMwRlRBY2V2RVRadW5H?=
 =?utf-8?B?SlZzaFVCQWU1RUdYTDFiNWI0dk9uQ0N6TGxhMGpDaGk1UWxaNkh0M3psR2V1?=
 =?utf-8?B?N2hxSXg5aXlpc2Q2am5vSlNOeHgvQStWR2pPNXczZXZTUzJjVmxYV3hSY1d2?=
 =?utf-8?B?M0Y1NnJhOWJHL2pzTS9hSE1KQUZGNU9SUEgwRXRxSURyS0Z4blVuQ1dLbHg2?=
 =?utf-8?B?MEV1b0J2bEl6VjF5eVhVb3VibVZRaERrUUVPbnFqNTQzV3JyWEJLNXNtMzdz?=
 =?utf-8?B?N0o1cXFQeE9XZlhyWkFTelVETEZaa0RBQ29Sb0UxMWNnazRyekpjbGlrZ2s1?=
 =?utf-8?B?b0FsMVNxL1BadzJkeEtBeDBmUVVTQ3V0RXpXTUhJRmN1RU8vQk9MTkQ0YVow?=
 =?utf-8?B?NVlmWU9sa1F6bnlHcHNIaTIvK1YvZDI3bjc3UThJc2s2WXFlcFZHTXNXNDhQ?=
 =?utf-8?B?cjNmcStLbmRielBoalJFQlkzeW5sN1pqczFtNVRNRWxsOFdzWXBWRDBqUTZo?=
 =?utf-8?B?a3A1WndtUUFEZi9abTZPRUR2TExYSldydUJqWWdSMmVGSmNjSDRvOXE5ZDZN?=
 =?utf-8?B?bGxFWUpTTVlXUk5hUjM2K1c5VUxyOFg0aWxQVkc3R0ZHcnNTN2hhNmdTeSto?=
 =?utf-8?B?VVd3TFNxZjFuemFGZGFMc05wVHo3N2JNK2wxUHhHbVBuM1gvTDlxaFYwYXFh?=
 =?utf-8?B?ajlKTm5CVDZZSC9jMExvU2ppM0FwbFNjNzNZUVhhWlhLclRmOHI4S2xOTlZY?=
 =?utf-8?B?MTZybFVuUFJ1WEdVZEtCeEFNK0RvNVZXWFFtbjQ2M0ZFbE80b3BYckVtQm51?=
 =?utf-8?B?SWt3YXNUMmFBc3NnRGVoRXZrTmRrN0FHc0Y4TS85SGs0Qy9wSWgzWUs4YU82?=
 =?utf-8?B?cVFiNWlMMDYxTFJzWFZDbmtxUlMrL3drOHZNQ3plVmNEMVMzNDZqckFnZDBW?=
 =?utf-8?B?STN3RnBaeGlZZDB0K05QY0NPU1IrdElmMG55c001QWxTcnR4MzdaOEV5bUsr?=
 =?utf-8?B?TFhMOTZ6cTgrRzVrME5hbjc5SFdkUEFvcHprUVpHdks1V1lKZWJFUmxzOXU5?=
 =?utf-8?B?cGE1NzBoRkFETkt4R0x2QTd6djc3cUtNT0d6OHgrREZQMjI5Q0hVeGV1Qjcx?=
 =?utf-8?Q?0Ooj/3Cr12UZQqZhcOvi3bjxareds0bIyg8ajt7h3E6WC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: rLXIY/ZCe9lu2/cazzgT3BIKWP+8SFkZpSq2AZ6bLJS13v6O0Gs4vjPnWQOwTv4RrK5Nrn+Rsl6YSiYaqnxY7A4ujnqnfhohukYN9mkblL5W77oxLK5izyF9TIzcwOoFb110kXrP+rtFyK2EEwfJ425bDUkh/GfWTlo=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faa831a-22a0-4ed4-6991-08daa679a1dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 02:30:56.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ascYSa+Xq+Loz3IhWfvBWEJw6eoxooAf0SJ2C5IW/Ez5U5qJTmDfRxZL6F+2P+yb3pE10iJijVwMxVGszOlrEC9wnUsbPYy2HvgYlwXh4II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5854
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDMvMTAvMjAyMiAxOTozMCwgS2VlcyBDb29rIHdyb3RlOg0KPiBPbiBUaHUsIFNlcCAyOSwg
MjAyMiBhdCAwMzoyOToxNVBNIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4+IFsuLi5d
DQo+PiArdW5zaWduZWQgbG9uZyBzdGFja19ndWFyZF9zdGFydF9nYXAoc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEpDQo+PiArew0KPj4gKwlpZiAodm1hLT52bV9mbGFncyAmIFZNX0dST1dTRE9X
TikNCj4+ICsJCXJldHVybiBzdGFja19ndWFyZF9nYXA7DQo+PiArDQo+PiArCS8qDQo+PiArCSAq
IFNoYWRvdyBzdGFjayBwb2ludGVyIGlzIG1vdmVkIGJ5IENBTEwsIFJFVCwgYW5kIElOQ1NTUChR
L0QpLg0KPj4gKwkgKiBJTkNTU1BRIG1vdmVzIHNoYWRvdyBzdGFjayBwb2ludGVyIHVwIHRvIDI1
NSAqIDggPSB+MiBLQg0KPj4gKwkgKiAofjFLQiBmb3IgSU5DU1NQRCkgYW5kIHRvdWNoZXMgdGhl
IGZpcnN0IGFuZCB0aGUgbGFzdCBlbGVtZW50DQo+PiArCSAqIGluIHRoZSByYW5nZSwgd2hpY2gg
dHJpZ2dlcnMgYSBwYWdlIGZhdWx0IGlmIHRoZSByYW5nZSBpcyBub3QNCj4+ICsJICogaW4gYSBz
aGFkb3cgc3RhY2suIEJlY2F1c2Ugb2YgdGhpcywgY3JlYXRpbmcgNC1LQiBndWFyZCBwYWdlcw0K
Pj4gKwkgKiBhcm91bmQgYSBzaGFkb3cgc3RhY2sgcHJldmVudHMgdGhlc2UgaW5zdHJ1Y3Rpb25z
IGZyb20gZ29pbmcNCj4+ICsJICogYmV5b25kLg0KPj4gKwkgKg0KPj4gKwkgKiBDcmVhdGlvbiBv
ZiBWTV9TSEFET1dfU1RBQ0sgaXMgdGlnaHRseSBjb250cm9sbGVkLCBzbyBhIHZtYQ0KPj4gKwkg
KiBjYW4ndCBiZSBib3RoIFZNX0dST1dTRE9XTiBhbmQgVk1fU0hBRE9XX1NUQUNLDQo+PiArCSAq
Lw0KPiBUaGFuayB5b3UgZm9yIHRoZSBkZXRhaWxzIG9uIGhvdyB0aGUgc2l6ZSBjaG9pY2UgaXMg
bWFkZSBoZXJlISA6KQ0KDQooSW4gY2FzZSBhbnlvbmUgaXMgaGFua2VyaW5nIGZvciBzb21lIHBy
ZW1hdHVyZSBvcHRpbWlzYXRpb24uLi4pDQoNCllvdSBkb24ndCBhY3R1YWxseSBuZWVkIGEgaG9s
ZSB0byBjcmVhdGUgYSBndWFyZC7CoCBBbnkgbWFwcGluZyBvZiB0eXBlDQohPSBzaHN0ayB3aWxs
IGRvLg0KDQpJZiB5b3UndmUgZ290IGEgbG9hZCBvZiB0aHJlYWRzLCB5b3UgY2FuIHRpZ2h0bHkg
cGFjayBzdGFjayAvIHNoc3RrIC8NCnN0YWNrIC8gc2hzdGsgd2l0aCBubyBob2xlcywgYW5kIHRo
ZXkgZWFjaCBhY3QgYXMgZWFjaCBvdGhlciBndWFyZCBwYWdlcy4NCg0KfkFuZHJldw0K
