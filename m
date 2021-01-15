Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123652F895B
	for <lists+linux-arch@lfdr.de>; Sat, 16 Jan 2021 00:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbhAOXZB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 18:25:01 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44846 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbhAOXY6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Jan 2021 18:24:58 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10FNOBpT010506;
        Fri, 15 Jan 2021 15:24:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9WWX9W+IUHPQQwpSPWleeT3PUfQ8ajDtQ6KPlqL1d64=;
 b=l5vFcsAhlmFe2Ij6IzKLcn/XijQQB77GoR6VIFgY3jx6UbX/3uIRmZVwW93w5jGlWK+o
 fOK48cdhHklybONScdW3xEpDbh02owK2nQ8Au5+iAAu1PIGnHj4VYeB11T5CFBKmz2zG
 f9w+hG/RdZM5JGVN1KWzCFCkEpH8ircIpMc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3631caw3qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 15:24:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 15 Jan 2021 15:24:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUwRUvS0oqGKmbFCmfQHuqwyFAqG0ZIZsxZDKRyxEt8GKdriYVaI72zm/QcXiDLIsKsDInBUy8f8ezainLuIDtc4RFRBCMLtyCVyR2KxLeqQyU+I3hn5qs/lJVQwp5o+rKXY751me/r7JJlr0UAImyWj8UGZIfPKesL9dFyyyFfUrtXv0gZ9MvCO3JlOHRpHx2qLjhvosx/q/U1qTq0w9QJCw5eRN5QzJOGJsYuxntcm+bMBIlmxmiO2136+hW/eGksXrGd+rvmLk2rvtHmmcoALJkhtQDllbHThyl3M73CZjRAuMOjIkms7fdJPPdO3Qvu5Cp4xxxw64T2GRTSuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwhc5r4PzWuFWkLztzfyeWuH8g5vcBKFCvf2BJClvXg=;
 b=kHWHI2j1IlhKFeMMSoP0ctHXL50TW446kLPTUesVwbWfaeRpc9jBaZrRBc4LAkQOQWKTtVcjTilLYyuvnVTPw465C/I0I+0zbl5Hlh/6H62SgSa7q95dRl+Pb7vjFBdhBFfmC/v+7lEUkbxnbbZwmSDxGbAFp/RT9SfiqDdaTlvXCO+8hzteMCLwOl/E3xvLd1wAiOY6JYWUSYxP5+wF9qTcYyk4e/21083+nmQeuN28UGni59kbHeA6KsZ2NiT3utRCbmrzI4caTZV8pHdPC/rxgH0b+ZFiXMm0Evuh5q6cYYNcv253TZVjs2D2ZzRv7eNp1lYY38ZqSP8gSDA7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwhc5r4PzWuFWkLztzfyeWuH8g5vcBKFCvf2BJClvXg=;
 b=N70qOpcM1HllhMS9Nyhi0QjZ2GeJ1qtMdilz6HiXvglEZlO+uYKqCq2u+q07yXtLWn0mGlDu5TiySvcyJZUZr3NzaE33kR0GZzsXLvdbTsoxLiRs4/RA6eVId88oZ9+VXG4iogiXP+SgxjwJ0B8CWFsFUyC60GSIEWvxKSBhJL8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4247.namprd15.prod.outlook.com (2603:10b6:a03:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 23:24:09 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 23:24:08 +0000
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     <sedat.dilek@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        <linux-kbuild@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com>
Date:   Fri, 15 Jan 2021 15:24:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:bb30]
X-ClientProxiedBy: MWHPR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:300:4b::24) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1366] (2620:10d:c090:400::5:bb30) by MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 23:24:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d70b55cf-d52c-403a-9d74-08d8b9aca8a3
X-MS-TrafficTypeDiagnostic: BYAPR15MB4247:
X-Microsoft-Antispam-PRVS: <BYAPR15MB424787F460FD032B7CC017C3D3A70@BYAPR15MB4247.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyR0N9n+tpK5GZ0lJFeINLlFZhs0JCpC6f429mnfy1+vT60W35Fqx0mOKJSUF/NpkTwSsu3vSrFmSlbPvpyW0weg04pqEOH6zANnOJC4Dm1e4tZXFFErGszh/FeuSxVYr3BrRu+2c5woY6/ZcCxw9c4/iA0a20MJTdpUhkVyNuhWcSmxacxlCuxFoYfxZfH8K84ktF9RKjAI7pRbHRRtgGT5q8YY+R6SRsjNE6mm2jIHFPAiB+S5Jx9nijabn5Mks3yLXaWJBU33AHOn171S98anp4l8WKiIp9PvqcbgZTeXn7GFghK6KXfmWtBU5yP6ZNc/F2/wYh8gObfe73dQLPz2iUSwfYhClvRxSd8V/Zbvc8dKOPV53GI3XpwZCd28llDheZHWab4TJL1RLA9SzVIkUmcRqmWcOTPfEfitqLRrCGmrJEt7yArNLRmmUKyJnrvII9l0bBqc9Be1ORcbbDg9f7p6HI8ZAbWqh/HgN+kYclwAzoiWVJYhks5B6fR4dvKk96DOsIVv2dr9kpiFI5KK0Bfnt4zE3QCSVcTXMbrZSn+GUn4iFcISwpmZzpor
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(8936002)(478600001)(54906003)(316002)(16526019)(6916009)(186003)(5660300002)(2906002)(7416002)(31696002)(86362001)(4326008)(8676002)(6486002)(53546011)(66476007)(83380400001)(966005)(52116002)(31686004)(66556008)(2616005)(36756003)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UEdJUEZHSnVtVWhLNFNVSFZRU1cyL25OcTUvbEJxUTJFVVJ2ck5Oa3MveWpu?=
 =?utf-8?B?QTFxU1VhYk8zRVc2eEF2VGtaOFROeHVPS24xcldrcXluZ0JtaEorNEMvbDZJ?=
 =?utf-8?B?MUNFaEhobnY4andsQTY5SGdGMkVpSDI1eW50ZjdGckdnbWZrZzFQbVVCOHc3?=
 =?utf-8?B?eGJUbDVRSWhCT3V5NEtIWkZ3dmNuS3FPVWdNYnJ3eEtyUlcxNzVGWXJuNEl3?=
 =?utf-8?B?MTlLRSswQW1Jc3JZYjk4ZXFST2lYc3JxZDRKU2R1V3ZBcDR5SkV4T2kyMzN4?=
 =?utf-8?B?MWJXcTV2SENld2dJYmNEN1p3UFJGaUppVVpLMWUrb0xnOFdsQ2hYK2ZRWFY0?=
 =?utf-8?B?aVg1ZDdFMW5PT3d5M0ROMWM5bVNENFhWYU1Ydmg1M1d2enpZc29iRXZTeWtT?=
 =?utf-8?B?UjV1QWM3MXAwOFp0c3liS0ZtalpoaVJtUFMwUHFnd3FvdmVQMHhndHMvZUN0?=
 =?utf-8?B?c3pOQ2pZQUhCMVhHYmcrZ2U0Uldzb2xlMHdqVUwrUjFpaUNldDk0WkZpcTY1?=
 =?utf-8?B?Vk5UZGZUNTIxV0Q0UlVVNDVkYjFFY1Z2dlhxekwxbmxWZDRjNWMxWk56YS9h?=
 =?utf-8?B?Y2JRSGd5QUZJU0tybUhPY0ljOEVUMFZzajdoNVpPSm9WRkRpZ0ZjUU5qeE5H?=
 =?utf-8?B?d0wxcDJXUm5RdmZvQkdaUkkrM1puR1VqRW90VkNqbGkrTzNNc2pTU2Y1UXlw?=
 =?utf-8?B?U21QTFdVcnpXVjdsUXRKcHFQVEZFT2xxYzB2bklFY2VBa0dMQ2RuS056aFg1?=
 =?utf-8?B?akpKU0VpdWNEVzM4Zm1NSHFlZHd0QmJPb2R1UWNoNWpZaE9uMStzTnFWVVc3?=
 =?utf-8?B?TzMzV3ZLR1FYZ3psVVhHaW1sbjM4bDNtNCs1QVl5bVZkNHBYOENnNFo1VGZL?=
 =?utf-8?B?L3pBWml3ZTdMRG9IRlYza2xtNE9YclJKU3VHQm5XY1RiWmdvZGFLSW1qRlBo?=
 =?utf-8?B?RmZtOW1GT2NORHVWSGkwVjRWWk00Q3hNdUlRdHplYmV5R25ac3YyQ2xhSjZ6?=
 =?utf-8?B?UlRLY0grcGs2V0owamhGQU8raG5PMnJORC9FSVlERFZoL1FLRkxwb296Znlv?=
 =?utf-8?B?Y05IVTZmdzJNcnpVaERzZmw2dU9lT0ZGQU9wMmhUQU9tanNMbnVocXUyeGt5?=
 =?utf-8?B?VjNDb1cza2ZodUhqSk9GY01JWFNkWTRjSVhlc3B0N2daSWtLdDRuVTQwUjMv?=
 =?utf-8?B?YnJ1WE1kaXVHdlRCSjBRR1A1MUdFYlFSeThrZHJLQlgybWZXTnVXd1QzVURj?=
 =?utf-8?B?QWtVQ05BeDR3OVg2QUZQRkNDU0RManVmZ1JNdXpLc1BoTmMzeXMyMkR6RzRn?=
 =?utf-8?B?VzZlWU9vMXVhdHZpLzR5UW90WGUxNG8vTDBiWE5XbzRXbUFhWHp3cC9XaG42?=
 =?utf-8?B?cVRYT28vREV0VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d70b55cf-d52c-403a-9d74-08d8b9aca8a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 23:24:08.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyJQNNNpeAr5II+dUWX/qUwwdNwRQqjL4jINwYjxKp8ont9HaOTnloMMpIG5oIxu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4247
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_15:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 1/15/21 1:53 PM, Sedat Dilek wrote:
> On Fri, Jan 15, 2021 at 10:06 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> DWARF v5 is the latest standard of the DWARF debug info format.
>>
>> DWARF5 wins significantly in terms of size when mixed with compression
>> (CONFIG_DEBUG_INFO_COMPRESSED).
>>
>> Link: http://www.dwarfstd.org/doc/DWARF5.pdf
>>
>> Patch 1 is a cleanup from Masahiro and isn't DWARF v5 specific.
>> Patch 2 is a cleanup that lays the ground work and isn't DWARF
>> v5 specific.
>> Patch 3 implements Kconfig and Kbuild support for DWARFv5.
>>
>> Changes from v4:
>> * drop set -e from script as per Nathan.
>> * add dependency on !CONFIG_DEBUG_INFO_BTF for DWARF v5 as per Sedat.
>> * Move LLVM_IAS=1 complexity from patch 2 to patch 3 as per Arvind and
>>    Masahiro. Sorry it took me a few tries to understand the point (I
>>    might still not), but it looks much cleaner this way. Sorry Nathan, I
>>    did not carry forward your previous reviews as a result, but I would
>>    appreciate if you could look again.
>> * Add Nathan's reviewed by tag to patch 1.
>> * Reword commit message for patch 3 to mention LLVM_IAS=1 and -gdwarf-5
>>    binutils addition later, and BTF issue.
>> * I still happen to see a pahole related error spew for the combination
>>    of:
>>    * LLVM=1
>>    * LLVM_IAS=1
>>    * CONFIG_DEBUG_INFO_DWARF4
>>    * CONFIG_DEBUG_INFO_BTF
>>    Though they're non-fatal to the build. I'm not sure yet why removing
>>    any one of the above prevents the warning spew. Maybe we'll need a v6.
>>
> 
> En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
> CONFIG_DEBUG_INFO_DWARF4.
> So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.

I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
It is not there before and adding this may suddenly break some users.

If certain combination of gcc/llvm does not work for 
CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
should fix.

> 
> I had some other small nits commented in the single patches.
> 
> As requested in your previous patch-series, feel free to add my:
> 
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> 
> - Sedat -
> 
>> Changes from v3:
>>
>> Changes as per Arvind:
>> * only add -Wa,-gdwarf-5 for (LLVM=1|CC=clang)+LLVM_IAS=0 builds.
>> * add -gdwarf-5 to Kconfig shell script.
>> * only run Kconfig shell script for Clang.
>>
>> Apologies to Sedat and Nathan; I appreciate previous testing/review, but
>> I did no carry forward your Tested-by and Reviewed-by tags, as the
>> patches have changed too much IMO.
>>
>> Changes from v2:
>> * Drop two of the earlier patches that have been accepted already.
>> * Add measurements with GCC 10.2 to commit message.
>> * Update help text as per Arvind with help from Caroline.
>> * Improve case/wording between DWARF Versions as per Masahiro.
>>
>> Changes from the RFC:
>> * split patch in 3 patch series, include Fangrui's patch, too.
>> * prefer `DWARF vX` format, as per Fangrui.
>> * use spaces between assignment in Makefile as per Masahiro.
>> * simplify setting dwarf-version-y as per Masahiro.
>> * indent `prompt` in Kconfig change as per Masahiro.
>> * remove explicit default in Kconfig as per Masahiro.
>> * add comments to test_dwarf5_support.sh.
>> * change echo in test_dwarf5_support.sh as per Masahiro.
>> * remove -u from test_dwarf5_support.sh as per Masahiro.
>> * add a -gdwarf-5 cc-option check to Kconfig as per Jakub.
>>
>> *** BLURB HERE ***
>>
>> Masahiro Yamada (1):
>>    Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
>>
>> Nick Desaulniers (2):
>>    Kbuild: make DWARF version a choice
>>    Kbuild: implement support for DWARF v5
>>
>>   Makefile                          | 13 +++++++---
>>   include/asm-generic/vmlinux.lds.h |  6 ++++-
>>   lib/Kconfig.debug                 | 42 +++++++++++++++++++++++++------
>>   scripts/test_dwarf5_support.sh    |  8 ++++++
>>   4 files changed, 57 insertions(+), 12 deletions(-)
>>   create mode 100755 scripts/test_dwarf5_support.sh
>>
>> --
>> 2.30.0.284.gd98b1dd5eaa7-goog
>>
