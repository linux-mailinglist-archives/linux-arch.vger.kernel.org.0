Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848655F548B
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 14:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJEMeU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiJEMeT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 08:34:19 -0400
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E06367A9;
        Wed,  5 Oct 2022 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1664973256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UzTtzqhhc1S/+tS1qHoFs4nRGT1t6f8Iq84bwy0o/RQ=;
  b=ZIJXXZIjnYr8sowRMc/5vLvin3oyCzbDH8iNhTbPp60L67twoOJnCHG8
   flfiJl2JqtwTg2YeXaMvnMwbPZgy8kjbiReWAPDCY47H0Idg7FmxW4ouz
   fJ8zNPnTnlfkliW6paASYHAQYhxFZvS1Ud3ivx2jguxsQmtPy73z6ip/t
   Q=;
X-IronPort-RemoteIP: 104.47.58.169
X-IronPort-MID: 84539044
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:nksyBKnu7lUIEFRG41LX14no5gy+IERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJC2GEOPmIZTb8fdxyYYu/9EoFusOAmNdlSlQ4/ngxRSMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6UqicUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tq3qMDEULOf82cc3lk8tuTS9XuDgNyo4GlC5wRmOKgS1LPjvyJ94Kw3dPnZw0TQGuG4LsbiL
 87fwbew+H/u/htFIrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRrukoPD9IOaF8/ttm8t4sZJ
 OOhF3CHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqFvnrSFL/hGVSkL0YMkFulfA0psz
 b9IbxY0Vzu+2/j10LDjbe5miZF2RCXrFNt3VnBI6xj8VK9ja7aTBqLA6JlfwSs6gd1IEbDGf
 c0FZDFzbRPGJRpSJlMQD5F4l+Ct7pX9W2QA9BTJ+uxqsy6Kkl0ZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXOnBdlDTOHknhJsqHy5ynACGDkxb0SAovPnqk+QYOJ8c
 kNBr0LCqoB3riRHVOLVRxCkrWSWlh8aVcBZH+Az5EeK0KW8yxbJWEAHQyRHZdhgs9U5LRQqz
 lahjcL1AiYpu7qQIVqB+bOEhTezPzUJN2gEZD9CQQZty9zipo40pgjCQtZqDOi+ididMTXxx
 S2a6SsznbMeieYV2Kihu1PKmTShot7OVAFdzgHWWH+1qw9+b6a7aIGyr1vW9/BNKMCeVFbpl
 HwFndWOqeULJZKTnSeOBuIXE9mB/feOM3vEx1NjEJQq8DGn9laie5xd5Hd1I0IBGsIFfyL5J
 UbJsgN5+pBeJj2pYLVxbob3DN4lpYDpD9LpfvnOaNZEJJR8HCeD4T1pTU2dxWbglA4ri65XE
 Z2AcMCjDX8ADr5u5DWzTuYZl7Qsw0gWz3v7TJT6whL3l7aTDFaaTq0OLV2JcMg26aqFpEPe9
 NM3H8eD1RgZUOT4eSTR2YoSK00aa3k9GZ3y7cdQc4arLxF3Akk7BvPRyK9ncItg94xRl+HV7
 jS0Qk5w1lXynzvEJB+MZ3Qlb6ngNb5xsn86OCE2FUyl13gqfcCk66J3X5s1ef878+tn1tZ7S
 vAEf4OLBfEnYjbO/TIdRZb6q4NmeVKgggfmFymobSM0eJljbwfJ4Njhfxbqsi4UAUKfsMo9r
 vujzArFTIYRbwN4Bc3SZbSkyFbZlX4UlOtsGULNI8V7d0Dl8YwsICv05tcwJ8wDAQ/OyjuTy
 0CdBhJwjfHEvYIx2MTCmuaPve+BCedjGE5TB0Ha67isPCXX92blxpVPOM6SdC7cEn2y46WrY
 +Zc1dn9NuEKmBBBtI8UO71s16gz+/PruLkcyAl4dF3UYlWpC7pmLT+X1M9AnqxL2rJd/wCxX
 yqn+N5TPvOMP9noEUQYDAsjcumHk/oTn1H67/M1JgPz4Ct6+pKOVEkUNB6J4AReJ7BdP4Qiz
 uMs/sUR7mSXhwAjNNePiAhb8GODKnFGWKIi3rkAGJf3ogkm0FdPZdrbECCeyJOGbtJWKEgxC
 juVgrfSwbFdzVDFaH09CT7G2u81rZgDpBBNyVYqIlWCgN3egfErmhZW9FwfTQVPzxFDlflzJ
 3RmMkprDaGP+Sp4wslFQ22oXQpGAXWx61G0wFsEkmKfXlSAV2rRIWl7MuGIlGgZ+GJ0eiNHu
 r2VoFsJSh7vdcD1myE0CUhsrqW6ScQrr1OT3se6A86CAp82JyL/hbOjbnYJrB2hBt4tgErAp
 q9h++MYhbDHCBP8apYTU+GyvYn8gjjdTICeaZmNJJ80IFw=
IronPort-HdrOrdr: A9a23:p7GQAKi5OAXgg6WSnM/1IfWj/nBQXlIji2hC6mlwRA09TyXBrb
 HIoBwavSWatN9jYgBHpTngAtj0fZqyz+8X3WB8B9qftUzdyQ+VxeJZnP/fKl/bak/DH4dmvM
 8KGZSWSueAaGSS5vyV3ODMKbYdKa68kZxA692z854nd3ASV0gp1XYANu5Zf3cGNjWuK6BJb6
 Z1vKd81kCdkVd7VLXHOpFEMtKz2OEi2v/dEGA771BM0nj8sdsbhYSKbySwz1MCVztUzfM4/X
 LYlhGR3NTTj9irjgLZ33Xeq4tbg8HgzNwrPr39tvQo
X-IronPort-AV: E=Sophos;i="5.95,159,1661832000"; 
   d="scan'208";a="84539044"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Oct 2022 08:34:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtulLzuGa2lkcQlpmeXdUzwcdmQBzkq96A+J6M8uTv2o9PgsqWeU3qSn+kJQXH1xFTXs9lfoKSafT523xdylrXmOXWz8G1T+bScW2Md9LxYDrmyLOadMf18ff3fDS0S3vHNOI53sYSdGzBwo47iBoRiajCbfjJQ/hBlFRcnWYg2zMP9z5KR2kpJnmTDvoeyfh60qJvRRhTxTNx2ju2jQ9PrRuc/t8xl1Ui9lmIDtrzyO+pqxGX9vvDmZ13AEv3BEFWuxuB7elR0J2IZ3tpxj/ueX6DVOhMx+aH4843bllOLJeMhhuWSqslyF8GWuiggnJhCjxj9Q3L87Rrxmyz427g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzTtzqhhc1S/+tS1qHoFs4nRGT1t6f8Iq84bwy0o/RQ=;
 b=mD/qZKL7o6xekOqlMzhtpvy7FC7G1oLA1QXLFIKulQW2PH8bY+ddYvieVWYFXSYnPOGVzrgTSuPXiSQsSPcwJsqBJS/iBe2KruYuUxzwvPyKPgEFnCknlBldATvNz50ddmLv8yeJ7+rMWyHjOjYkQazjLnS+oqUt+8U8/Mw5ddPQDPLKG4O0i1SjXuFGyEZmqVxbbjHgqs4YrdkPuOGssjpZmNqkSkgg3v5fAJaZFUspqG9kjBSx7dJzGWntq6UqyCHG1s0ZhpC5dHf7ums4OJ0OP/rdA/pJ6Ycfw7Y9ttmddKLcCVXK0kOllO467usjuLvVw16hhB10UEmWQb9g9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzTtzqhhc1S/+tS1qHoFs4nRGT1t6f8Iq84bwy0o/RQ=;
 b=ts+IeRfmt/bug1jDdtK5sYGUJ2BsUkNlp8K6Bzt2awGdLTsOBmSv4vvPL3UoSOCw1tzGHe1Re0rr2hz/8+52ybFw9qbDWo6eFGGF9bF+kD5PzHCtRjXUj5alL7pRcM8rN/wBbaZCqZRMCnx93AOWhTQsoPTxL/afvn/Th3s1F5Y=
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by CO1PR03MB5857.namprd03.prod.outlook.com (2603:10b6:303:90::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 12:34:07 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::988c:c9e4:ce0d:b37c%4]) with mapi id 15.20.5676.023; Wed, 5 Oct 2022
 12:34:07 +0000
From:   Andrew Cooper <Andrew.Cooper3@citrix.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
        Christoph Hellwig <hch@lst.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [PATCH v2 08/39] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Thread-Topic: [PATCH v2 08/39] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Thread-Index: AQHY2EQA6XM0CgiZ10WXzrN2yB2NVq3/A9eAgACjVoCAABXPAA==
Date:   Wed, 5 Oct 2022 12:34:07 +0000
Message-ID: <dd971008-a87a-c020-f4b1-f874fc4df3eb@citrix.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-9-rick.p.edgecombe@intel.com>
 <8d58f57f-cece-c197-2a8b-dd02b4e405bc@citrix.com>
 <Yz1ncw+up1nRb9Eo@hirez.programming.kicks-ass.net>
In-Reply-To: <Yz1ncw+up1nRb9Eo@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR03MB3623:EE_|CO1PR03MB5857:EE_
x-ms-office365-filtering-correlation-id: 6d15e3c1-f3e6-4a55-8e50-08daa6cde547
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4RFPL2Beaz/9So7k8p3ik0tg+4Xe7uRMxo/JN+SmHqOveiOgrAQF0GQvwVm3Vby2suLd8hLPIVpY7GMIkY77/b8hOdET7tGLkzqlunaPNep53djHgMSA5dF9JchtHtsXY1LS/nnzIjIKTNPrWDcaFXphliX6fO/nAKUq68AqxCBLZrPiZyKzqhvwqxYTa7UEnAeIKgH13P6sA7r8Txa3vLQe2gvY6Pv3/6WVDa4wKI0tov0gV+WKEgXfCsEBFz/fdDOOLLJaPyQAczKCc9rB/xXOAQupNvfsXZo+V29dXhOta5NwqZjlL/caQx9FpwuTniFj8GK/Dpjs8D60ZiVHgdD8psRpyuZY5EPmpoNkpieKxwzrpkAkWkukCRVwbLiyKrVlzqgcix0fqyBiSkkxEPeegmcrUs0aLRPUsX3dmpqcM0q/1gPNo8qlt5hlh2P/5ThOHrIAAAGsmUASFK0wLtXTlpkFCjJrnCkZYmipEF7uiR89RPgL4oGy3IMR0JuAAbFuD0IpLAuS8tj7U/IdYN/h+6DvwsAUqqi7PTN0VwAykeijU4/glz8Lgr3lTNZ+GjEfJaoeHWGC2C5D5f55PZ/EXjMIAGAJlOZBNBgZxdSNRPZFBSzxEdBzALxx+noFsgoiowowK9TbyUlauc4vfpxdsyrqX16qVwyDuewp2CfM1KipHoV4qxnpCUvSg2N7oN59lT+/pzvgC+vE/MEHRkic7n+mu54hK/HcIS1icCbL2iut6G8KZ17KkWI4S0OEAvzMcueQtzR8lSrXfhSm6Gv+YDIH6ZmQ0ChaiTkQ/YeRAtrfVU/B6QBEKTZX/0lJK9wa+RH2NIafm4lukzP5l+3nUlEnKU1r5vu85iYTWT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(316002)(478600001)(6916009)(54906003)(6506007)(83380400001)(36756003)(66946007)(107886003)(4326008)(8676002)(91956017)(64756008)(5660300002)(66446008)(66476007)(66556008)(7416002)(6512007)(7406005)(53546011)(8936002)(31696002)(86362001)(76116006)(26005)(41300700001)(31686004)(82960400001)(71200400001)(2906002)(2616005)(186003)(38070700005)(38100700002)(6486002)(122000001)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlZjRFRzSTI0NlR2eUFTMWdRNVlKYk5ZRDd4UHlHQW4rcmIzRUZSSnZuU0Jp?=
 =?utf-8?B?OE9PbjhGWktFcnpuUHg2aDhvai9mb0VreDdsNXdRc0krLzZqcVR2VExzd0Zi?=
 =?utf-8?B?T2VjSjc4Y2lCemlNSU5iOUdqZXdQQmF5U05hNDloTWN2STVzeVBpZ01iNDFq?=
 =?utf-8?B?MElUYXQ1V0Y5ak5xMTZEcUtQNWFUa0lXZVVmZW1VSmphaEY4L1E5TnlpK1ZJ?=
 =?utf-8?B?aGExSGo3dlIyUGMxNkh2RzJ6bXNWYlBTa3RabHkzdUtyeFc1TEZQbkNjSVNw?=
 =?utf-8?B?U3hjMm9TT0ZtUXVtcm1oYjVtdFNaTmJxNkFFbWIySFozZ3BvVmQyOEl3SXVJ?=
 =?utf-8?B?MmFldk9JWXowZlJaQlZYcXJLbXJmVmVvbHRRNW9hRUhsc3lkd3pxdTVVbGZv?=
 =?utf-8?B?OU02OFhtTG55T0xsNTUvNURWVUdjbjBIV0NvRzhvbzlPU0FzWDNCdUFGVlUy?=
 =?utf-8?B?MXI5RWxyVVZVSzIrV2krSTI4bDNmOGhlVkU5Z1VHbVpHeXZFNHVSRStLekpL?=
 =?utf-8?B?b1lzK1JNajdYTGdDN0g1R0tGOUZXZzh4aHNubGdWYlFMMm1ycERTeGxVQXFk?=
 =?utf-8?B?WFpRaU54YUZnWjdPK0N6QytwTzJNTE12YksxMjVtZzU0QjZha1R1WUU2MjhT?=
 =?utf-8?B?RDAxSWd6VFVIU2xsZEVtWjdsSEpMd3JsSjFhcXVqY3dYaFcwMW5YYkVodmds?=
 =?utf-8?B?a0ludkZtUVVkQStMbFI1bU04VzZOdFhtSFcvaEh2bHAzVXVtaUFsUWxMbnVq?=
 =?utf-8?B?NlRoWUZNUWVWUFp5L3pEaW1WNldOaU5EWHNtQzk3T29ObnFTeW5UeVMyeW5P?=
 =?utf-8?B?S1F3SXBDZ2VwSkVwVzNFa1V4WnF4RENCZ0dvQk9sK1o2Uy9OZzBKUEdjd2Zo?=
 =?utf-8?B?dnFDV0hWRjVvVlpsU0hKT1M5REpzVEkvZWVWUk1za1BmVFlyMEFROW5pYjhS?=
 =?utf-8?B?MFVSQ05nRjJMR1J6V0VWUEF2T1pnam10aE5pTjk0OENmRjNOdU9JUFN0MmNx?=
 =?utf-8?B?RnBuSDhXWDVDb2tZR25yWDRNc2duVjNHL1NYUDVYRUdVY3ltM1QvR2FBQzc0?=
 =?utf-8?B?Rko1dUF4WGx6djNIdEZWS0JkREJ2ZUUrSVk1S0xmU2VWVW9sZTE1VS9HWVJJ?=
 =?utf-8?B?WmxBWFp3MCt2UEpZeU1Cbk8yU014MFFzZVEwZ2d0THdtRzNDakdVWXVwRmtO?=
 =?utf-8?B?eDgyOHpKUlNpS1JXV2RDNUNFdndCOWJ3Z2ZUQXFuYTF5WkovZm16SjFkc0ha?=
 =?utf-8?B?NEZZVnJkeW8za3lsc0JJMEZhbWpIUnpRSmNMY0xHNXdFZjh3eVp4dXJkQXR1?=
 =?utf-8?B?d3E2czVKV2lyTnJoL3lpbDhUd0xNTno0Wk0xbDBTSGpFbkhsaTFndUVBM0d1?=
 =?utf-8?B?U20vSm1JQTZCdnExS2dnY2JUWmRJTEkrTmMyUkRxQjlaN2Qwa0w1V2VWT3BI?=
 =?utf-8?B?WWFKUSszZDRkQ0lnL0ViWE1LZTMwazd3TjN3dWo5NTUyRm9sV3BFZTFka083?=
 =?utf-8?B?dWl4c0VwS1EzREhOM1JjbGw0OXpMeGdUQnhEWFpZVWZ4T2hmdnpmNGZza1lz?=
 =?utf-8?B?RzdXd0VGc2tZZDVrR250VHYyMGJ5Mll0ZUYzZHdnSEZxK3VSY0lJdERMTEFX?=
 =?utf-8?B?bmN6UnU3RzJXSzFiMytuRy9xWHplclhLMEdsTlloeFUwNUFkS25kVzBkZHRE?=
 =?utf-8?B?K3pIUzdtRTVaZVZwNWhaUHJuNTNTWWZEVFNlVUl0cFJWT3BhTUttR0N3MWwr?=
 =?utf-8?B?RnZiQmZoVkNMb1BQVkhtazY0ZzB1S2lpK3U2U3ZLdnV5QWtvOUU3akdNR3BU?=
 =?utf-8?B?NGhJQnVTbm1JWHlLajZUdFZNV29iYzdxMmEvOVdUL01rNlRaMTVMQUtEc1pp?=
 =?utf-8?B?dTUvOHFadGhvMG5VWUxyZDBVSStHWXBVSTlXQ29KU0VWYy9XZ3BYaTgrVGo5?=
 =?utf-8?B?T00yOGo0Y0JsMXdpRjlIQ3JldVZjSlFBMUkraWpzR05YbS8xeWxtLzI1dnVs?=
 =?utf-8?B?UFVkVDFXMDJDMm5aZDl2ZzNkeWoyMEZacFh2WklMdm9jVmFvL2hmRnpLQkEv?=
 =?utf-8?B?MDRuREFtOGpHT1BnYkRkc2tYZ28xQ2ZITUh4SzhaRlRWUXFPbUJDRDZDTW9i?=
 =?utf-8?B?cVlaVi81UnVLbXVxS01EMXBQc3p1N3lQODdPZ1BCS09EUitGQzJMUUZKN2w3?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87AD7CBE52BFE840A107EAD2DB8D49FC@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXZzKzAwVnVoSG83OGhPQVY3dnFGaGpOZnJYQ3h1TjlEU0hpRUNUeHFxYUZm?=
 =?utf-8?B?MExKNFdNSTN5YzdjM2o5Zjc2R08wbDJXdlU4RExKQWo2YytERE5oTVdNMUJ0?=
 =?utf-8?B?UmtsVVdVZ1dFUUdzSDl1L1lKclk5TFd6N3o0M3dSRUNtamlSVEIzSHIrbFcx?=
 =?utf-8?B?SHBYZ2h0Z2htUXlxN21NYzlxYmViYjM1MlNPSGp2eUZCc0MyNDVkLzNVTTBM?=
 =?utf-8?B?SkRzSERQcGZPL2tXNFJBQzgwQjFhMXgvSDZtcXpQTVUrRGpxb2pOZ3N5UEg0?=
 =?utf-8?B?ZmZyTzAvRFJiUUp4cjgyb21maTRwTzdoT3ZBNisvd0R2OFFaMFd3VTlZdzB4?=
 =?utf-8?B?UzJQbDY1WHpOcnJQT2NLM0NjM0wwQU0vVDlRcmpmZ2p3UWlsTEV1MENMSm91?=
 =?utf-8?B?dy9hemFBUERURmprTUdNUUlNalE3TFFLWFl4U3BjYk1GWFpGNkJuZCtXTWVv?=
 =?utf-8?B?VjR6Y3o0bTNSejJHQ3VQbWpoTmpIMVpneXk3cFFqNStUWXRyN1I5bTNrbzZs?=
 =?utf-8?B?UE8rY0hVa3B4K29GVjZkWHgxZHZESnN1MVlTdEdZNEhmMTZkYmdxVHVzU2Vp?=
 =?utf-8?B?NU9JTEh6NzBqeUlkbXh5bWJkSDhBaUlsQ05hUFZLY0RuNUJBb0gvZk9zTUpN?=
 =?utf-8?B?SUtDNVR2RXhnbTJXZUFxQTBoLytBSFpUY1dGT0Uyc09sOW0rWjBEZGJmUndl?=
 =?utf-8?B?Y0taRnFsNW5yVlp5cW5oYTltYUl1QXgxUkVFWXFOMS9PcWg0MDRueS96N203?=
 =?utf-8?B?cDJ4NFIxLzhhakZCVnFTRGNZTzBqbUpkaGk0V1lldVJ4a3dOVGpZWFVHelZ3?=
 =?utf-8?B?RFFrTUpVbXBCaFBMVVVIdCtFZjd0VEw4OERWdnJEdUVFc1NOUXlTb2JhQml4?=
 =?utf-8?B?dktIWG5iS2ROclhGcDVrZ2NMTWRGZFU4dDVOTmhpYWg0UlI0Z1NSdVU3Tytk?=
 =?utf-8?B?aG1IemtQaFQrYzJYdEV0QzZlb3F3a0JBdmQ1ZndRRGYzYSs3RHBTSStqOEM4?=
 =?utf-8?B?MDgyYjBDNjRVK1pvV3FqTVJvcjJWOGcydnp2OE5IVStpbmMrcmErMGtIUFQ4?=
 =?utf-8?B?UDJvWC9XWDdwaUxKQmU1OUN2T1ZEdjVGMGVFdjJZZnNhb3Q3WXpFQkRjU0FO?=
 =?utf-8?B?ZlJwQUJxNm1YMWxkdmpScHVTcTRhRk5MYXF1eU9wU0ZjbDkrNkVoakkwbEkv?=
 =?utf-8?B?TWlwMi9jbHVPQ2Q0U3dIdFJmZ2p0QjZLVXVJMXZFQnBoQVhSMklybU82d3V5?=
 =?utf-8?B?cTlQR0RWSnVac3VjVGNOcmpKTjkzODd2RENCSUFaZkNsTkhqem1kcHlmQVda?=
 =?utf-8?B?cnhOUEtHZGpCcnR3VHZYM0lRdER0K0JrclByUXg4WS8rKzlsMXhMMVhocTlW?=
 =?utf-8?B?NWRpdDRoTC84RG4xTmI1d0VPZG1VNHUyREdvUWFHZnN6YS95V2VsY09VT3o2?=
 =?utf-8?B?YkswQWFndE9TN3RaamozUUpwMGFRazd2a1dZRDhKNjR5SWIrVXYzdGdMT3dP?=
 =?utf-8?B?RXFlSndhREJyU2prN3o1MTZ1SUdJYVJJdFdPZEJNMGxSbWRBMkhZSHdmZ3J3?=
 =?utf-8?B?dWpFa2Z4RW1DZXNyRWFHUlpwWXVCcnFpVVpiNitvZGRjWXZobFQ1YUVzZFFq?=
 =?utf-8?B?TXJTNnFsTGduSmFrMGllRlRQL3ZMM1daKzRDcit4TWswWGE0Y2NrSUtLZlRS?=
 =?utf-8?B?bUUvWUlQejJaZnBtaWJGb2ZEVWJ5TGdLMHRCSmd0S0MvV01hOTZjTFZpV3pl?=
 =?utf-8?B?TEV6YUFlRkV1SDhldkgwUU1FV1g4SGEvdzUrc0U5Ly8zbEdSaGgwbGdxdWd4?=
 =?utf-8?B?b2hBZERhZ0tNV2JnczRETktrc2tHM0FuczhvNnBXWmZ6RXk5MnR3YjhpSnhM?=
 =?utf-8?B?dlZWWUxCV1hSNXZLV0RoK0d5N3ZLVmdjeTZ5M3ZtbHh6NVRoRDAraFo0VkdG?=
 =?utf-8?B?V2tXckY5RmdRQjlCejJZYkM4aE10THBuMEZnd2NwOXh6Q21yZ1FuZkNYYVY0?=
 =?utf-8?B?WmEzR1FRVmdueEVONjlNY0owTXRXYWNhY05UVytnWVhISVdLeDN3ZjhJUzRw?=
 =?utf-8?B?ZGdsaEtFbG9EOGovSnZ3aG1ld2t3RUU0N0FJY3NuWkpOc1B3S0QxdjRiOXda?=
 =?utf-8?B?a1BBcEZMZjIrdXltSjNYejRjbFovWk9vZEpHMWh3YlJXdkx3SXpBOVJ6MXdY?=
 =?utf-8?B?emg4MzdsT1Zkdm81Z0lSK0dsMndZR1JwaWpDemc1Tjd0b3pFL24zVXc0OUx3?=
 =?utf-8?B?NzFuZEdDMGR1MDBJc0FmTUtIV3FZak1ZWSs0VFBwenZ3K29hRURhRXRIN1NO?=
 =?utf-8?B?c2ZlKy9ubUlyT0dTcUIrODNwUU1kTnRXeXZXSWJ6eVViSzk5bkU1a0d0ZnRU?=
 =?utf-8?Q?N204bvG4X88ieel9cuLYq74CZ5AJp6v7RMUdrZ1Kq2WkL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: X/n9zirTA5k1IujV2ZggGF1mZYznZc1c7kgi/A0NtXf4QHkt1H8yxp3Jt0qB9w9WHdEtovPbAM/mBW6jwSjxXxYasj2VA2HPqicJa1MuppG/+w4Ln5PyiZYQdvupMqtmIU7PLSszi26+mL85wwxoVfuKH8htEK70oV6RfRPWpDqVEzuCW7mpWSec
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d15e3c1-f3e6-4a55-8e50-08daa6cde547
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 12:34:07.1056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCiSTwDxLVJhdDvqj8L5Ro8aGV/Kdh8GNU3j3h3PFoOKX7iJA7RK0k38ZFPlw6ngJCFi5Uj+lbuHNxhevRpBUMxUnrLYmbu6Z36sQpG3DIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5857
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMDUvMTAvMjAyMiAxMjoxNiwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IE9uIFdlZCwgT2N0
IDA1LCAyMDIyIGF0IDAxOjMxOjI4QU0gKzAwMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+PiBP
biAyOS8wOS8yMDIyIDIzOjI5LCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToNCj4+PiBGcm9tOiBZdS1j
aGVuZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwuY29tPg0KPj4+DQo+Pj4gUHJvY2Vzc29ycyBzb21l
dGltZXMgZGlyZWN0bHkgY3JlYXRlIFdyaXRlPTAsRGlydHk9MSBQVEVzLg0KPj4gRG8gdGhleT8g
KFJoZXRvcmljYWwpDQo+Pg0KPj4gWWVzLCB0aGlzIGlzIGEgcmVsZXZhbnQgYW5lY2RvdGUgZm9y
IHdoeSBDRVQgaXNuJ3QgYXZhaWxhYmxlIG9uIHByZS1UR0wNCj4+IHBhcnRzLCBidXQgaXQgb25l
IG9mIHRoZSBtb3JlIHdyb25nIHRoaW5ncyB0byBoYXZlIGFzIHRoZSBmaXJzdCBzZW50ZW5jZQ0K
Pj4gb2YgdGhpcyBjb21taXQgbWVzc2FnZS4NCj4+DQo+PiBUaGUgcG9pbnQgeW91IHdhbnQgdG8g
ZXhwcmVzcyBpcyB0aGF0IHVuZGVyIHRoZSBDRVQtU1Mgc3BlYywgUi9PK0RpcnR5DQo+PiBoYXMg
YSBuZXcgbWVhbmluZyBhcyB0eXBlPXNoc3RrLCBzbyBzdG9wIHVzaW5nIHRoaXMgYml0IGNvbWJp
bmF0aW9uIGZvcg0KPj4gZXhpc3RpbmcgbWFwcGluZ3MuDQo+Pg0KPj4gSSdtIG5vdCBldmVuIHN1
cmUgaXQncyByZWxldmFudCB0byBub3RlIHRoYXQgQ0VUIGNhcGFibGUgcHJvY2Vzc29ycyBjYW4N
Cj4+IHNldCBEIG9uIGEgUi9PIG1hcHBpbmcsIGJlY2F1c2UgdGhhdCBkZXBlbmRzIG9uICFDUjAu
V1Agd2hpY2ggaW4gdHVybg0KPj4gcHJvaGliaXRzIENSNC5DRVQgYmVpbmcgZW5hYmxlZC4NCj4g
V2hpbHN0IEkgYWdyZWUgdGhhdCB0aGUgQ2hhbmdlbG9nIGlzICdzdWJvcHRpbWFsJyAtLSBJIGRv
IHRoaW5rIGl0IG1pZ2h0DQo+IGJlIGdvb2QgdG8gbWVudGlvbiBob3cgd2UgZW5kZWQgdXAgYXQg
dGhlIGN1cnJlbnQgc3RhdGUgd2hlcmUgd2UNCj4gZXhwbGljaXRseSBzZXQgdGhpcyBub24tc2Vu
c2ljYWwgVz0wLEQ9MSBzdGF0ZS4NCg0KU3VyZSwgYnV0IHRoYXQncyBnb3Qgbm90aGluZyB0byBk
byB3aXRoIGhhcmR3YXJlIGVycmF0YS4NCg0KSGF2aW5nIGhhcmR3YXJlIHNldCBBL0QgYml0cyBp
cyBleHBlbnNpdmUuwqAgQmVpbmcgYSBsb2NrZWQgb3BlcmF0aW9uLA0KaXQncyByb3VnaGx5IGEg
c21wX21iKCkgYmVoaW5kIHRoZSBzY2VuZXMuDQoNClRoZXJlZm9yZSwgd2hlbiBBL0QgdHJhY2tp
bmcgZG9lc24ndCBtYXR0ZXIsIHRyYWRpdGlvbmFsIHdpc2RvbSBzYXlzIHNldA0KYm90aCBvZiB0
aGVtIHdoZW4gY3JlYXRpbmcgdGhlIFBURS4NCg0KSXQncyBvbmx5IG5vdyB0aGF0IFIvTytEaXJ0
eSBoYXMgYSBtZWFuaW5nIChvdGhlciB0aGFuIGJlaW5nIGEgc2xpZ2h0bHkNCndlaXJkIGJ1dCBz
YWZlIGJpdCBjb21iaW5hdGlvbiksIGFuZCB3ZSd2ZSBnb3QgdG8gYmUgbW9yZSBjYXJlZnVsIGFi
b3V0DQp1c2luZyBpdC4NCg0KfkFuZHJldw0K
