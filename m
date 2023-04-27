Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB006F0A13
	for <lists+linux-arch@lfdr.de>; Thu, 27 Apr 2023 18:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjD0Qlp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Apr 2023 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbjD0Qln (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Apr 2023 12:41:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B3E40F0;
        Thu, 27 Apr 2023 09:41:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RFn58c004247;
        Thu, 27 Apr 2023 16:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KFKkk7jBzW11hlIBI5V0pO6exLSlweSXduyEaN8C+9c=;
 b=vlXyXflf8qV4kVSHcJV+enYtbiH7o4tn+0aGu+UijDvKJy5rmvk1VkmU6snpZlNJULac
 HYBqKjPCfNDKkWYPNtqabytufoR7RQy1hGps5mpmbqaVVu2A0+6bKUxNB0WCk0ueyYVb
 iBlXSCJVPssyREkkq4gyHOoqZwHGUa4oYSZpmgmLUT63sNZB2NVwS9K+bRF+E8VA5A1f
 eD+5jIW4yMIkePl6VRSHJdQVCmLrYP5X6YK5nMkMj0EOUJVX96oUQXCGo0nykk6AzA5o
 j4MaEqfr8ONNersYoe6io8xLonTYm53SMUPcwvsdl/0mVYX1v9NMxK4WlF2PgZRQzQD3 9Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46gbvgut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 16:41:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RGUaLG007418;
        Thu, 27 Apr 2023 16:41:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4619k78u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 16:41:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgHGE3sWE1970ahHuAEmKN+S6MM1LGMu9yoT7wes+9hYHfFpH5LbSxkkSXSnk9XDMmOKzitMHdz9PQfEtsGtTaShJpVmY+k67j76cMTX9O38k0ciVzK4RQWUHThlYkk5N970sJXR1aDKehgpSgAhLk2IGMyKpS+z+8gB+yX+HQsgJTnPkhjIW/zXnRP64gNNfYwKkYTXgDAOcd98W6Pc2n6PRyXRtO/qHdF5G62ksQFDlXQH0V1xwiuve+KoP6u30bjFvoN+pKlD3aIxwtltUEf7g+d2RsNtxAApBtUS0y+6hKb8JYMWovhDEFCOcjt3IWkwVP7rhnokXFDY8P1ULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFKkk7jBzW11hlIBI5V0pO6exLSlweSXduyEaN8C+9c=;
 b=ASjqcYUokPrldoFlCR60SqBG+sPjlFLb4Bma7Ess69djr25Z0JffRnxkQ0S5ykNMKIQ9EhM/5CvJ7RMN1E2qbfrLAn1whmIMpxwla4SqXN0FuyYuhxRgDU9MuNhXkQ8zRyzrFUDqxtVZMBhF1gQ4ixOrkS/KmyO7YCWWMFvaK9FZjTEByTJI6BF0JSaxHktseywC/vFt1ToN477yn0QhQCJzMufeYcRZhPxBD3cNwDBzWTV5nwnjnqSOUE3gZme8DsKp/JHBC5ysfLWLm0rdVBn5b8WIPEYRVE/HGZQBg5ZgaVPh4UlMvz8m32E/AATAMwwlnpCujL1Hla4tDe+32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFKkk7jBzW11hlIBI5V0pO6exLSlweSXduyEaN8C+9c=;
 b=l1JcAzwerJNdhDJx8UC/YcpIf1SW4HbSwdEZZUxzzSWOzHMdvOPuiMpjyqlxtEXpyGzGxDWBNEP8e71j0IVaTr7pbMi+phRuCj/MAuzgVcHn4gXuvbX6WYHob/f3Rt3/C2Pr0dGIhXWAJx5Av2DinZWT9Wt+57EF/tGWHBTa19Q=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 16:41:02 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%5]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 16:41:02 +0000
Message-ID: <b95b651c-2e00-abdd-6d5a-5b3dea79dccb@oracle.com>
Date:   Thu, 27 Apr 2023 10:40:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhiramat@kernel.org, rostedt@goodmis.org, vasily.averin@linux.dev,
        xhao@linux.alibaba.com, pcc@google.com, neilb@suse.de,
        maz@kernel.org
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <20230426212745.GA4755@monkey>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <20230426212745.GA4755@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: eb597fc5-26c8-4aa0-c8c6-08db473e2ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnY68RHEV1NFxJaQG5DxP8YSQCFul4lt14ZEPvcUtp3JSxMZFbx2b08gHBhX497jiXIKHTLs4DBmsMhC4gUmUbqdXzpRIRs+ZMWdH6f3vFDbOKHTojT7ZeyX8KAskdOv6U7P3YfFbCU50nh44HdNiNRNMFcFx8EZTy7owkWy1u3eRedlqlBjpopIZz46uiLguzLvC2lNSaiOJ20gR+Jzt2JgtvmewP/luhxDQMQ+altO5OTBHKjH7Y9DodAh0nE+rXTSSZMhzvX9rWAk2AGdTtSVGsR3do8j7thdZXaB0ccpgJLWl4zWijSt5Tlu0BxjxdWXFLlXS+Aiut3+g74nwalHqqto/iYETo6emRR3UUXKvAjk4W0ZhtVrBEcPuK4JmaG8LLSKBtXP2ASwGsbtspP7/sDHnSlkelvteb2OCnqIPnUGByPsTlbsnptg/Lh0NTkqsuF71x8uQuVOcfkkVWQ72vIE+mAAjlKXjHGJiv3dJ8haqd1p7IhvDp8TDEHnC4K8sM0DW4ogx/LBONwIBNWoVdlj4tvUkiJHQCYZmdigTTw+YrS4ArTF6FgVKzYidDPHVO45wXe5hJT3GYyfk/QpJPXfnBTTP/E/xSZutKL2GXhTkwr+2jm5i/050VhBKLc/TLKeFYRlYytsVdaDYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(2906002)(36756003)(30864003)(31696002)(86362001)(31686004)(6666004)(6486002)(53546011)(83380400001)(2616005)(26005)(186003)(6512007)(6506007)(66556008)(37006003)(66946007)(66476007)(478600001)(41300700001)(6636002)(5660300002)(38100700002)(4326008)(8676002)(6862004)(44832011)(316002)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RURHZEFVSHI4eWdLN1NvWDdXL3JGMlR3Z0JTZnNsYTRhK3BqemsxT1NRZTV6?=
 =?utf-8?B?MnRueW1Ob29BeFJ2bURFa2lDdEtQQzVFMlBYNUxVT1FnT0hKcFFGK1QvTjB6?=
 =?utf-8?B?SjFNb0lTU28rRVF6NVdxa081d3lxbUdzYkltcnlqV2xEaFNObzU4UGoxZURB?=
 =?utf-8?B?Q3lzTFNSZm9hNzRMWjczZ1R0cnoyT0R0UXhXY1c3YkEwRVd3bG8xTGpobUN6?=
 =?utf-8?B?OS9JNGEyQjh3QXJPRUNRY1JwTEx0TlgyR1VzeVpubENZOXRZVUVpbnZVYXVj?=
 =?utf-8?B?cThHczVDTUl2Njh3K0JBSlQwU0txTzJKR2tKVmtJRFZVclhaSDN3ZU8rVlhG?=
 =?utf-8?B?T20yNE5vTzYwaldBcS9nQTRqbHRpR0NIeEwyWWtxU20ya3dRNmJSSVZ2bWhK?=
 =?utf-8?B?ZjNmWTZ6STdtZ2RhTUJFakpYN3FIVHYxNjYwdldWdWppVm1FK1BuYnpWWGl4?=
 =?utf-8?B?clA2Vi9OY3JReWdEcnBWVlJRQ1ZONDFpRE5Da3A2TE5GOVRxenNtWlBqUE42?=
 =?utf-8?B?SkhGRFUvc1JraGpPR1MrMWFUckRqck43NEVQZTlKbHZ4UnZCQXh3M2swMmhW?=
 =?utf-8?B?V3hxUWluQ01ycU5BOEhpZ09tL3pnTEV0cjAvNjRhMnQ4ZE5iRHppR3M0YzUr?=
 =?utf-8?B?L1NjR1M2dzQ2UU4vOFdWRHhxTy9taVhTeWhmWk8vYlB6bTJ1MkhTWlV2blVS?=
 =?utf-8?B?ZXN2Mm9jQ1cvUWd5VndzU2VOcUNEbURTTldjQWxnOVU4akl1N3FiUGIveUh5?=
 =?utf-8?B?Z1JKdmF3Q3krR3AzaGk4UUUwOWhGaDdJZm13eDhxaW5wYzZ0U2RGb3RudFY5?=
 =?utf-8?B?SVhJbEQ4a05GWGV6TUpGMHFyS05QSTQ3NWlPeEtySVdycHlaUEZsTWtIVW9R?=
 =?utf-8?B?ZjVxRis4ZzZVTlhnSVpzTHRjbXkrSyt3M1dkdVlkM1ZjamNUTG1SSFR2MnVI?=
 =?utf-8?B?YmthN1ZQbDdsV2xKMkt5M2RyL0F4ZW0zams3V0ljcGp2akdNRDNtU2NFeTZW?=
 =?utf-8?B?K29uL2hTT0VJU3dpYlorRk9RQXNxVDZqenA3OTE0OTJDQzFQc25Yd0l3NEVi?=
 =?utf-8?B?K3MrcEFHeDRyNnpNNmRIU3BNRzRvL04zQmlEVkZhWGtOQmtxbUU4NlZRVC9u?=
 =?utf-8?B?RktFTzF4ak1ZbHVubGlPbmQwWWdIc3VBZjNPenBJSFozTG5xR3g1TkphUjJL?=
 =?utf-8?B?cDNtK1FkTHpXL0JkdkJML0NkQ1l3N2tBcUh6MHczZXAyajNUL0ViVzZYU1VB?=
 =?utf-8?B?U2FjUGlwVDIwYVVOU1RzUnN0NUowY3R4V3VYNHRxcXNRUjlVd2cxcHlIRUkw?=
 =?utf-8?B?U2V5cEE1Snh1YVg1VzcrYThSWlB3M3BtdndkaW5GcW1BOENNY0w3Ukl5enZ4?=
 =?utf-8?B?NElKTVNpZDYvanZXSFlqUVYvYzFIQUVsM3hSeXN3VVJCS0xtSG80Uk1mdVE5?=
 =?utf-8?B?TmpTbjZ2MTZQbi94NGhJRmY4K0FIbWl0MHZKMXZxSGQ4VmdWcG1PVEdiMG1O?=
 =?utf-8?B?T09adVJ3b21JMTdRYlBRdElYZUpQVkxldmRsN1grRnYwTW1VZ2RSWk13QjFV?=
 =?utf-8?B?OUp1c3JaRjNtSXFKWFJ5QzNHTjU3NGhWZEdZSG5lYllsUXN6aWZmQzY0anli?=
 =?utf-8?B?ekJDb1VILzlJTS8rWTlsSG52dDQ4VjF4UVVjOG9HRXFzRlFWY3BwVmRtUmpv?=
 =?utf-8?B?d2REQXJoMVhZZnNibnovdlhJWGtwOE5QSUVJajdjNTZKZ29YU09DWHZCMnAv?=
 =?utf-8?B?SXFNUmZQTDVrTHZKVURpVUgrR2pId2s3RDd1SGQrYWFKUXFleURWUHNTajJ0?=
 =?utf-8?B?YTlzRUZqMkFEbkVhaEhwVVZhUkg1dkhrRHNwZXA0eWNZUmJZUjFXdkxZWFZi?=
 =?utf-8?B?aGN6TmIrbU5wT2JKaHFQZUlsN0hNSThvSnZqeEFuT3EwV0tGdnpHeVVzTkNh?=
 =?utf-8?B?SE5JeDQ0bTdLalJZQ3EzNmRJc283NXFtYVp5eTNYa25VUjZrU3BzeDlxMFU4?=
 =?utf-8?B?V3pkZXIvY2VCN0tWenhBYnZGd2N5RzVteGdKVzdWQmZtcGhZeUczYStjR3Jo?=
 =?utf-8?B?bzFGUHhtMmdKYzZwZU8reTdmMkVzczFreStqaURGUE5GZUt2Zk9qSXg1azkx?=
 =?utf-8?Q?eBmlUCj1s2Iaszb+mjlCzfWsa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?czFRellrcXRodDdISDFmUGFaZVdSdmZhRkpvK29PZU8wY2hEUnNRT041bjB0?=
 =?utf-8?B?NlJnMXVpbGNUTFY2Ty9KZU1BUkRvQm5EQTVBcGhrMUVtenY5V0tMcEk2OFRz?=
 =?utf-8?B?dTVuejV5SXZEbFdzR0oraXdqOHVLR1d6ajlwQVFqQ3BvVWVFWnhXOWhnYlc2?=
 =?utf-8?B?OWRQcDhYSVNzMGNGMm8zWE4xSm9yZ1dBQUtWbnJSVzU3ZFpkYllMRUpncUtu?=
 =?utf-8?B?Vzd4WWhHakxmaDVzaEpqRU9YMWJBeS9yUmNKME5Ea0pWeEpNNlFQT041ZFhn?=
 =?utf-8?B?MWl1SzZGWEVnZXJJZHVhREtvV09KbXIrL3NwWjNwNXUvUzY2Vk1NNE1CYkZN?=
 =?utf-8?B?clNwc21LVDZadzI0K2FvYVJwWlAzOVY3N2x0N1ZQamFNVDU4KzlGUkVOdVc1?=
 =?utf-8?B?c2lhNk9pRTdKNFdDYWxFdmNGeXdxWkRScGt4VHd2ZDJSWE1QOWpIMFFKTFFN?=
 =?utf-8?B?b0g5QW9JODZzaFR4M1lKaG8rbUlyV2F4YmcwcTRWZ29DZ2U2b1hXV05rTU9j?=
 =?utf-8?B?L3FhWHdZYjh1YVJ0Qk1hbXZMcUkyT2NpekRhb1MxdjVKemJNUWhjczBwOEJG?=
 =?utf-8?B?UmtPQi9Lak40TXhQQ0ZuTm9kYThjbEVuS1FZVU92TWNpRHlRNjlab1pzVWs5?=
 =?utf-8?B?SnQ1aExJbCttQS9BMEI1VGNsdmloQ1lrWkRLckpBREI4TjNIbVM2U0ZOVlVU?=
 =?utf-8?B?OTBENnB3YmkyZVJaaGtJK21iYnU0eFBZQWNtWFNwVU1QK24vbFM0ZVZLV2R1?=
 =?utf-8?B?SzQyNk5HcjhSc3crLzl3d2dCaTl5bk8xUXY0OVpNdXdib0VxME82RTZrdFZP?=
 =?utf-8?B?aThqMzhhTGpnazJWbW9xY1FVOXdub3cyT3VTbEVYZWg3RVBNV0d2a21ZUHdX?=
 =?utf-8?B?ZWxPYURDYkRkbXR5Y2ZHUmM2Q0hTbnlZQmhuZFpaSENpak9LZjZMd2xCNzB4?=
 =?utf-8?B?L1VqY3BZcjNSMzQzendUZFFjRnp6MExxQjFscGJOWFVXcWIwdUg1aWh6dmZT?=
 =?utf-8?B?UWRkU1RyS3JveW1PZUc2ZTZnUE1QZ2JlWTBjT2VHMGV5VHZqcFpxdHJTTUxQ?=
 =?utf-8?B?MnFPdlp4aG1nb3dOMEx3eVA1ZEF5ZGJSNzdpQ1d4aElyb2xHaXJWSm5lMUVS?=
 =?utf-8?B?OEhlNG1DOXMxU1BjRFJsY3J6YzNGSE9mMDdROG5rcDFDUE5CVVpIY3h4a3dx?=
 =?utf-8?B?NDVOWndjR3EzVk5XMWNyV05QaWY1WWZhVytKZnpxZ2RkNitvU0hCVTd4RzRR?=
 =?utf-8?B?dmRsdStDeEJQa0kwYmloSHoxR0x4cG16NUZjWGk0UjVVbTR6VCsyRlhRN1BL?=
 =?utf-8?B?SE9TOXN2RjdNcENEMFBBS2U2MUFkbElPQ2FUQldlSkNWN2ZiZklkZlRBOS9L?=
 =?utf-8?B?L2ZXbnJFSjhPTjlHa1hNbDVnUFVQRHRWamhkUU93UGo2NDY0Skt5SlJxQzZX?=
 =?utf-8?B?aUFCMUxDenJiUy82LzRJQjZ4MitXc3c5ZmJCMWxvVkd2RFRtbVFwRDJTTm0x?=
 =?utf-8?B?WEd3RXlFTzF4K0JlaWlEZ2RMZVFFOFRzMnNhYW40OTMxajRScmVaS2RXODZj?=
 =?utf-8?B?OVpEVW9hbWRtNFJNQVVYQnpBSmJjSXV2d0Nrdy9PSDYvNjdtbjQwUVJ4d3ZW?=
 =?utf-8?B?UVN0T1B3Wm1Sa1RMT3BDUDVmR0J1Y0I5VVVxZWE5TE9BQit2Y05uZjRtSUtF?=
 =?utf-8?B?MFB0d2lneCtGamtURzFxQWxkUXFkU1R6ZDhkVldBU3VDWUZuVlZqYWdsVUFN?=
 =?utf-8?Q?FbVKuATbJyIWWs0MtBS4QwBYevWqg7L2MTUCaGJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb597fc5-26c8-4aa0-c8c6-08db473e2ff7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 16:41:02.4475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDXL4wps3y/IjyLV8tP8bOK6sXUldbBFnmCU4Z9B2Dkf+MsoZ512GBoJT/L7q4arjajgffnlUZb9jQMTkMunYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270145
X-Proofpoint-GUID: 1y0FP_GQLfUcWQEXKCZyVZEt_T2CJvlv
X-Proofpoint-ORIG-GUID: 1y0FP_GQLfUcWQEXKCZyVZEt_T2CJvlv
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/26/23 15:27, Mike Kravetz wrote:
> On 04/26/23 10:49, Khalid Aziz wrote:
>> Memory pages shared between processes require a page table entry
>> (PTE) for each process. Each of these PTE consumes some of the
>> memory and as long as number of mappings being maintained is small
>> enough, this space consumed by page tables is not objectionable.
>> When very few memory pages are shared between processes, the number
>> of page table entries (PTEs) to maintain is mostly constrained by
>> the number of pages of memory on the system.  As the number of
>> shared pages and the number of times pages are shared goes up,
>> amount of memory consumed by page tables starts to become
>> significant. This issue does not apply to threads. Any number of
>> threads can share the same pages inside a process while sharing the
>> same PTEs. Extending this same model to sharing pages across
>> processes can eliminate this issue for sharing across processes as
>> well.
>>
>> Some of the field deployments commonly see memory pages shared
>> across 1000s of processes. On x86_64, each page requires a PTE that
>> is only 8 bytes long which is very small compared to the 4K page
>> size. When 2000 processes map the same page in their address space,
>> each one of them requires 8 bytes for its PTE and together that adds
>> up to 8K of memory just to hold the PTEs for one 4K page. On a
>> database server with 300GB SGA, a system crash was seen with
>> out-of-memory condition when 1500+ clients tried to share this SGA
>> even though the system had 512GB of memory. On this server, in the
>> worst case scenario of all 1500 processes mapping every page from
>> SGA would have required 878GB+ for just the PTEs. If these PTEs
>> could be shared, amount of memory saved is very significant.
> 
> When hugetlb pmd sharing was introduced the motivating factor was performance
> as much as memory savings.  See commit,
> 39dde65c9940 [PATCH] shared page table for hugetlb page
> 
> I have not verified the claims in that commit message, but it does sound
> reasonable.  My assumption is that the same would apply here.

Hi Mike,

Thanks for the feedback. I looked up the commit log for 39dde65c9940. You are right, same does apply here.

> 
>>
>> This patch series adds a new flag to mmap() call - MAP_SHARED_PT.
>> This flag can be specified along with MAP_SHARED by a process to
>> hint to kernel that it wishes to share page table entries for this
>> file mapping mmap region with other processes. Any other process
>> that mmaps the same file with MAP_SHARED_PT flag can then share the
>> same page table entries. Besides specifying MAP_SHARED_PT flag, the
>> processes must map the files at a PMD aligned address with a size
>> that is a multiple of PMD size and at the same virtual addresses.
>> This last requirement of same virtual addresses can possibly be
>> relaxed if that is the consensus.
> 
> I would think the same virtual address requirement is problematic in the
> case of ASLR.  hugetlb pmd sharing does not have the 'same virtual
> addresses' requirement.  My guess is that requiring the same virtual
> address does not make code simpler.

Same virtual address requirement make pevious mshare implementation quite a bit simpler, but this reimplementation in 
this RFC does not rely upon virtual addresses being same as much. This does open up the possibility of removing this 
requirement. I just haven't looked through any potential complications enough.

> 
>> When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
>> is created to hold the shared page tables. Host mm struct is not
>> attached to a process. Start and size of host mm are set to the
>> start and size of the mmap region and a VMA covering this range is
>> also added to host mm struct. Existing page table entries from the
>> process that creates the mapping are copied over to the host mm
>> struct.
> 
> It seems there is one host mm struct per shared mapping.  Is that
> correct?  And, the host mm is the size of that single mapping?

There is one host mm per shared file. This was done to allow for multiple VMAs to exist in this mm for a file that can 
potentially represent multiple shared regions of the file. In the RFC, I am creating only one shared region per file for 
now.

> Suppose the following:
> - process A maps shared file offset 0 to 2xPMD_SIZE
> - process B maps shared file offset 0 to 2xPMD_SIZE
> It then makes sense A and B would use the same host mm.  Now,

Yes, that is correct.

> - process C maps shared file offset 0 to 4xPMD_SIZE
> Does C share anything with A and B?  Are there multiple host mm structs?

In the RFC implementation, C does not share anything with A. The code is written to allow for expansion to support this 
sharing as well as sharing multiple non-contiguous regions of the file. My goal is to debug and finalize sharing 
infrastructure for the simple case and then start expanding it. In this specific case, implementation would expand the 
existing shared VMAs to cover offset 0 to 4xPMD.

> 
> Just wondering at a high level how this would work without looking at
> the code.
> 
>>          All processes mapping this shared region are considered
>> guest processes. When a guest process mmap's the shared region, a vm
>> flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
>> fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
>> flag is found, its corresponding PMD is updated with the PMD from
>> host mm struct so the PMD will point to the page tables in host mm
>> struct. vm_mm pointer of the VMA is also updated to point to host mm
>> struct for the duration of fault handling to ensure fault handling
>> happens in the context of host mm struct. When a new PTE is
>> created, it is created in the host mm struct page tables and the PMD
>> in guest mm points to the same PTEs.
>>
>> This is a basic working implementation. It will need to go through
>> more testing and refinements. Some notes and questions:
>>
>> - PMD size alignment and size requirement is currently hard coded
>>    in. Is there a need or desire to make this more flexible and work
>>    with other alignments/sizes? PMD size allows for adapting this
>>    infrastructure to form the basis for hugetlbfs page table sharing
>>    as well. More work will be needed to make that happen.
>>
>> - Is there a reason to allow a userspace app to query this size and
>>    alignment requirement for MAP_SHARED_PT in some way?
>>
>> - Shared PTEs means mprotect() call made by one process affects all
>>    processes sharing the same mapping and that behavior will need to
>>    be documented clearly. Effect of mprotect call being different for
>>    processes using shared page tables is the primary reason to
>>    require an explicit opt-in from userspace processes to share page
>>    tables. With a transparent sharing derived from MAP_SHARED alone,
>>    changed effect of mprotect can break significant number of
>>    userspace apps. One could work around that by unsharing whenever
>>    mprotect changes modes on shared mapping but that introduces
>>    complexity and the capability to execute a single mprotect to
>>    change modes across 1000's of processes sharing a mapped database
>>    is a feature explicitly asked for by database folks. This
>>    capability has significant performance advantage when compared to
>>    mechanism of sending messages to every process using shared
>>    mapping to call mprotect and change modes in each process, or
>>    using traps on permissions mismatch in each process.
> 
> I would guess this is more than just mprotect, and anything that impacts
> page tables.  Correct?  For example MADV_DONTNEED, MADV_HUGEPAGE,
> MADV_NOHUGEPAGE.

Yes. For instance, the RFC implementation allows one process to set MADV_DONTNEED and remove PTEs which removes them for 
all other processes sharing the mapping. That behavior does not quite sound right. A more robust implementation would 
possibly remove PTEs only if all sharing processes have set MADV_DONTNEED. Other flags might need different treatment, 
for instance MADV_WILLNEED should trigger read-ahead even if set by just one process.


> 
>> - This implementation does not allow unmapping page table shared
>>    mappings partially. Should that be supported in future?
>>
>> Some concerns in this RFC:
>>
>> - When page tables for a process are freed upon process exit,
>>    pmd_free_tlb() gets called at one point to free all PMDs allocated
>>    by the process. For a shared page table, shared PMDs can not be
>>    released when a guest process exits. These shared PMDs are
>>    released when host mm struct is released upon end of last
>>    reference to page table shared region hosted by this mm. For now
>>    to stop PMDs being released, this RFC introduces following change
>>    in mm/memory.c which works but does not feel like the right
>>    approach. Any suggestions for a better long term approach will be
>>    very appreciated:
>>
>> @@ -210,13 +221,19 @@ static inline void free_pmd_range(struct mmu_gather *tlb,
>> pud_t *pud,
>>
>>          pmd = pmd_offset(pud, start);
>>          pud_clear(pud);
>> -       pmd_free_tlb(tlb, pmd, start);
>> -       mm_dec_nr_pmds(tlb->mm);
>> +       if (shared_pte) {
>> +               tlb_flush_pud_range(tlb, start, PAGE_SIZE);
>> +               tlb->freed_tables = 1;
>> +       } else {
>> +               pmd_free_tlb(tlb, pmd, start);
>> +               mm_dec_nr_pmds(tlb->mm);
>> +       }
>>   }
>>
>>   static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>>
>> - This implementation requires an additional VM flag. Since all lower
>>    32 bits are currently in use, the new VM flag must come from upper
>>    32 bits which restricts this feature to 64-bit processors.
>>
>> - This feature is implemented for file mappings only. Is there a
>>    need to support it for anonymous memory as well?
> 
> I have not looked at the implementation, are 'file mappings' only
> mappings using the page cache?  Or, do you just need a file descriptor?
> Would a file descriptor created via memfd_create work for anonymous
> memory?
> 

I look for just a file pointer, so an fd created by memfd would work for anonymous memory.

Thanks,
Khalid

