Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA02F898E
	for <lists+linux-arch@lfdr.de>; Sat, 16 Jan 2021 00:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbhAOXoB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 18:44:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbhAOXoA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Jan 2021 18:44:00 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10FNcbxt020503;
        Fri, 15 Jan 2021 15:43:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CMAOhzlDIzG1jB9QqrVc3eQkCxeXiAKXY92yqL5w6ro=;
 b=pwcVfihaWh5DWGg60bDPQawkMKIrQuEVf6Ki45PsVw3yBnnEAVk6guwZSB4izkhlQLuL
 fnQuIwyYvClJL8ycyYYQKrulOsO8CKH6OnVSqyzXeEIXSkNp2Jz+bclwjImn5n1mlT0h
 IhwanvzyNaQiKMSff8tYJxNLiHSZ1qt2UXE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 363e4ft8ry-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 15:43:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 15 Jan 2021 15:43:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djOxeKPSPiqAi7fADZztZQA0mnozb7DQMHk/EJqccxCRn8GgnZgUKgJbmd42IRCnlQfYB1vUa6gtcCrTKIsKq35ZYqpnjKlB1kfcxaib6vc9sDGkbETaQM5QNTuOrjVHJWAo0SDF59lkPgvqY8TUz26Rp3EAkVZam7gjYZ0//73KDB8PAq+wycAvYpfnoRYqh5tv62PLyHeM3OrwgRHyYYaWo06HngWKz10syXiv54fI1oEkOresK9J4EajhPD2p0l6hPL/tqe5DrzanK8LyqktqTDYm65a+3cEfPtUBdHZZsgRSg+EAC2v8NUsqgTxj4onTcmLh7e3kAFbToJ46kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMAOhzlDIzG1jB9QqrVc3eQkCxeXiAKXY92yqL5w6ro=;
 b=JX1qvhEJ1JyJB1dqrXZ5De3aiStzKxUUf7JzvW2pceOIYBG4Cp0RKEcuk8HBj/NmH9kBzuJSTP6/tKd2X15BHyBDkHzbBTtWj5SvHZ60ZKTUKwSDiqmNMi/mTM7sO4Yb0T8dpuas8342XoOvgGgNwu5w+qUOS0jKyv6L9Z1xJ/jov7/BPFfHMsoHKdhb5nL5a1jY/3Mo7gEpVbF5IgQ4VgjybfWsAY9ycncPMbCfhX8M35enZvR14i366l2WcAx/NbQUp/aXebLGpP/NfhPOM2+0GV1eOjm2oebbq0HGrufyHsR224ETGRGEbzLSErm9D07KKuRRN+2c67wzgNm7Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMAOhzlDIzG1jB9QqrVc3eQkCxeXiAKXY92yqL5w6ro=;
 b=SRnCT3olPKet2cbjizlYGk9m7xYZ1tSLBFg5xCpyI2W6mjPrPFJqsEo8EsT42PQYYbEP9YhWxxztQ4Nukf0kLnLshxfpSoy+jhBIn1rSdqcjJcjtZoyZr4w9T2miecPtYcBVYuFr4QHtCek1SdXMsj2hqtxqsUGfzxANBddsY4M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3191.namprd15.prod.outlook.com (2603:10b6:a03:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 23:43:10 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 23:43:09 +0000
Subject: Re: [PATCH v5 0/3] Kbuild: DWARF v5 support
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20210115210616.404156-1-ndesaulniers@google.com>
 <CA+icZUVp+JNq89uc_DyWC6zh5=kLtUr7eOxHizfFggnEVGJpqw@mail.gmail.com>
 <7354583d-de40-b6b9-6534-a4f4c038230f@fb.com>
 <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <12b6c2ca-4cf7-4edd-faf2-72e3cb59c00e@fb.com>
Date:   Fri, 15 Jan 2021 15:43:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <CAKwvOd=5iR0JONwDb6ypD7dzzjOS3Uj0CjcyYqPF48eK4Pi90Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:bb30]
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1366] (2620:10d:c090:400::5:bb30) by MW4PR04CA0207.namprd04.prod.outlook.com (2603:10b6:303:86::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 23:43:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2379ac7d-e28b-402b-f851-08d8b9af50b4
X-MS-TrafficTypeDiagnostic: BYAPR15MB3191:
X-Microsoft-Antispam-PRVS: <BYAPR15MB31914E5CC3B6B79A7F4B69DFD3A70@BYAPR15MB3191.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSn9idgM69BTkFnTcpefAyJDk9syYDYM7jwBbKoGmd9smck4PG09k3lwZFxv8tkjW1HVgycS+zzUtn1+aNvhyR89lAo+lIHRcT/SWBLbd1TwEWucnjJ1TKiTQKwRRyHfiJf8tyNlO8R3lfO/r5yrIDeITGvvawHJTgHWhdiY6mYEiD0RD2Z6gGQfATfLGTYZl6VK+29YhyPzCoflE2v+k6GMvjQwd8MQyfvTRog81btU+JdvLaVIxAB9I4clzXqNVTvGAF0WTdubxVxUXokYQizGwMI1/GituXUYU1AeufGyBt5+d5Ueg1tTqVu58RQtuzKwHUXfK0tTbj8Oi0IvAjdy9oTbOAZOo0aP9ygY1sFyYHM9ozFsxwoe4sN4XnlV+TtQ1VkMcMiTd7niWDHbLTBISkUgYAOkSFCqR6WxYBLfYPgCpLaut2AqHnEbA+rjtrHN/tIOjaHNXnLeE3VBgxPeEaYnEPmX+98ee5jJupw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(376002)(136003)(366004)(8936002)(31686004)(36756003)(86362001)(31696002)(16526019)(110136005)(186003)(7416002)(2906002)(8676002)(52116002)(54906003)(316002)(5660300002)(66946007)(66556008)(83380400001)(6486002)(4326008)(66476007)(478600001)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bTdrb0NtRFkzVnJkMG5VNStkdzRLMlpBcmcrUUdXNUFYUWxBWFkvT3RSMlI5?=
 =?utf-8?B?cUNHZGs3Q1pJMUN0VTVWalVPbFBiS21ORE8vTy9Nb0xHM1VMTkZHZ2NKUjZv?=
 =?utf-8?B?cHd4bVdTTWlUU21jZ2ZSOGhXcGNzNHBOdFA4VnI0OGt1RE4vZkJiNGoyQXVq?=
 =?utf-8?B?SWNscmVJc1dLTHpyOVJGeXpvMTdLL0Y5OGg5WEU5LzJBSkpKZ3VRSUdtYXVz?=
 =?utf-8?B?K3pXeFpVWlg4NmROODg3UnJ6VFZQUHVTem1LdysvRHFqTk8yUWRQd0grQTZZ?=
 =?utf-8?B?WUF1aSt6UEFTcUEzaTdrRXNHSTlKY3Y4NDA3MEhvcGdtQk1hR1R5Snd3OGwy?=
 =?utf-8?B?QmVDRmJKTDRoMExYUWZEWUQ1M1FOWjhPVHJwOGZ2UEMzWjFySGJuVzlLendN?=
 =?utf-8?B?bFYwNU1SVEFlRG5VanEzNXMyamlrYnQ4NnAxOUNUNVE2eS83NVJERzhhWkVo?=
 =?utf-8?B?Z2s1MThwQXdFRGhTU0ZoTDFBSXNKY3E0TXA1WGdMWGRDeGlCbmp1OEl5RUd6?=
 =?utf-8?B?RS9JV1F4b29xb2VQZk1OV0p4bkVoL0xrZjU4MkRRb2sreVdWdVR3Y08raCt3?=
 =?utf-8?B?Vnp6bjRISVBVRVNHMHBRWU5ldktvNUgvNEdDSW1ZNU5zT0d1b0JDOXZ3aTRz?=
 =?utf-8?B?THlLeEF3czVOWkZjZU5SUTlKQ2FaTzFIRlJ3OWpBK3dMS1pXaURQbnJOT2d2?=
 =?utf-8?B?YjZpQ3V0bEROdmxBNHZuSGJ1YmtBV3NHOHF4Wmd4UittenRZQXRmdTlVT3pi?=
 =?utf-8?B?UzRERXA4VzdtMHlxYmZ4RG5mbFZCY0VWNUV6QVk3dUROQisxY1BpN3Z0ZzVK?=
 =?utf-8?B?T0pyblhVdkdJaEZjQURJUkprYVU5Wm9kTzA2MzBxOTJrZUVWMk00SzJZd01z?=
 =?utf-8?B?Z2s4N3BrZldBM2JCQyt4OFJpZ3FEbHBnMkVPcFJKMC9SYVRmQmJoaytUMzFr?=
 =?utf-8?B?SXdpQTJWSmhwUkRwbllTaEJNNnM4Mlh1U01kWTdqZFNMazdwYWJFY2QrTkxj?=
 =?utf-8?B?c29VQk1JRkpoRWJ3SzZWU3pwc05EMlZsR1VpdFQzTTNENllGRnVsNHczbURO?=
 =?utf-8?B?N3N0Sk0rNm1DQzJKLzZkeTBqTkd5Vko3Ly9tNVlHSkdUZXVLakduRVFCSGtr?=
 =?utf-8?B?N3NQYjUzTlNEWGliUXZFc0FXaElYby9iQWNqMWlQd0k3NGZxVFpJUWt3VVd6?=
 =?utf-8?B?ZnNwWlBTZzBFamVJMFNGcW9rR1Q3WDdMOXlJOVcxV2ZPVUNYeFRFSlBVaG5v?=
 =?utf-8?B?U0xVMkZJZ3EzS0ZwUjNFZFM1NzJnRlRzemhEbktwbURSVThjeUgrYXhpZ3NN?=
 =?utf-8?B?cmJ4NU9Ua3EvVkRQYUUvSHFxMmo3c0V3YjQzb0s4QTcxaEJFWEowNGZLU3RN?=
 =?utf-8?B?c3NpbU0xMUMyZ2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2379ac7d-e28b-402b-f851-08d8b9af50b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 23:43:09.8587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBfnz8+g9yVKTiAODMwwjMgGOKJQlf5C1NWP+jkMSTjBVyVyLxeErcIJUB3LUvMl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3191
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_15:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=861 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 1/15/21 3:34 PM, Nick Desaulniers wrote:
> On Fri, Jan 15, 2021 at 3:24 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 1/15/21 1:53 PM, Sedat Dilek wrote:
>>> En plus, I encountered breakage with GCC v10.2.1 and LLVM=1 and
>>> CONFIG_DEBUG_INFO_DWARF4.
>>> So might be good to add a "depends on !DEBUG_INFO_BTF" in this combination.
> 
> Can you privately send me your configs that repro? Maybe I can isolate
> it to a set of configs?
> 
>>
>> I suggested not to add !DEBUG_INFO_BTF to CONFIG_DEBUG_INFO_DWARF4.
>> It is not there before and adding this may suddenly break some users.
>>
>> If certain combination of gcc/llvm does not work for
>> CONFIG_DEBUG_INFO_DWARF4 with pahole, this is a bug bpf community
>> should fix.
> 
> Is there a place I should report bugs?

You can send bug report to Arnaldo Carvalho de Melo <acme@kernel.org>, 
dwarves@vger.kernel.org and bpf@vger.kernel.org.

> 
>>
>>>
>>> I had some other small nits commented in the single patches.
>>>
>>> As requested in your previous patch-series, feel free to add my:
>>>
>>> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> 
> Yeah, I'll keep it if v6 is just commit message changes.
> 
