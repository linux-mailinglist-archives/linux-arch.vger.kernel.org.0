Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC23C31FF68
	for <lists+linux-arch@lfdr.de>; Fri, 19 Feb 2021 20:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhBST1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Feb 2021 14:27:41 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34462 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBST1i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Feb 2021 14:27:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JJOGgn084138;
        Fri, 19 Feb 2021 19:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=43jX0YemR80pEyXOS00aLA0YdVuv51bCACRuKzge1xI=;
 b=FNr/YlgBYPCRcOM2xA9UaCA0LpazOrqAa7t/p/0fdEQtXvFvd1nJ3SYYbhJSrO5Dig9P
 Gjp3sBFgYkaENG+ojPKM4j8sIzHKuEVY1/B5lVSy3CFoTstwLiJGFKSVnlCn3F0NEGWH
 0QxUouOl8ZSkV3tZ7UN5nu2Fcp226BVqSjoL1jPBhgWwqOsYxXy+ZckFyv9AF4IrucO6
 2E7ebH7Ztnfhc7MbLpii7okuh0GVuwUUEIHGqtLp/urhRjxzmZkPvEqJMjHA9K5eGg55
 lHJsNu3VptnfxTBNGepWcbfHWqx1g2SD296+g1WN/uxrGy7sWM2akNu2FopUxGaFmSy7 tQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 36p7dntg0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 19:25:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JJKFBL168639;
        Fri, 19 Feb 2021 19:25:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3030.oracle.com with ESMTP id 36prq28e2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 19:25:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKI0lY4v8GOLKGJ9OrpkJQAE38/Yb/MfkJ1Y7nQNB/FNdODOi738NIuZR4xcH0DuPp2nrKPM1zG0A75G/3LdVEa77J0PxnQ8DSFs8reWoAnZdrpVVYoetp2WyH8WzvOzHBmDMyQmCUQ1RsC2f8oUfEOOEgZCWeYbhBgInMv4QwHNtZ0GWE28H52YLmFItRPLGEftCBFZXaEsDD+kaz2ooaw1p6ztBlEwLAsSvqcbHu9rH/MhzaaalYkLahV3cenbSSrRZv0JaYCvXqtQQSiBCXYyXQxuC7sjKogWpwxtAHhhjSLRFlcWEQSGgpkwUg5sOm3YfpdXhHeqRic80ib43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43jX0YemR80pEyXOS00aLA0YdVuv51bCACRuKzge1xI=;
 b=DIRCyT90VxXI6k9+XeShTUXVx+nRATIP8vW+FqJGSlrhxFBBZBQu1dPT9YP5YBKvuFrqmEJjQhlx0WftuC+zbFiTGUNd+RaPoZTbhQf6Q63gH7WT7RphVgVjZto3jAYsXVFjKvSwc6dHFE55nM4gyD8N/S+ZGaf8tUoMQabfUc3rxl7S+8B/EsJ2ALZtRAu0Ni7nzs2OWg+jzGZj9pQtKDxBLIT1Z/VmsFZva6UBqDfItBE4Kx/oD3uFoNQ8e/9xVUQjANUrjSXqc38faUVggo4p7doAZCjcuXoJ0s6kjyZ5Vb2i1gRxCxNCqK6ITMHlkcf8ZZP4VtPHo/Cv6+nMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43jX0YemR80pEyXOS00aLA0YdVuv51bCACRuKzge1xI=;
 b=eVnueDwBSgV2yH1V7HIl/6FsRjaX3EDbPzy1T6y+KonZa2pwrySdqgyHHXcVj1N6WKo/PZ6qybCzgOjBoTZ4NgJv6lwzWscH30yWPjAo3q8euFNVcPGLieI2+YapWMijae5exvFAe2aq++JPHF7A0A+Ha6hxV461t8UuhJd22pg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 19:25:54 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::ad89:6caa:4481:b733]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::ad89:6caa:4481:b733%3]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 19:25:54 +0000
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
To:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
References: <20210217154844.12392-1-david@redhat.com>
 <20210218225904.GB6669@xz-x1>
 <b24996a6-7652-f88c-301e-28417637fd02@redhat.com>
 <20210219163157.GF6669@xz-x1>
 <41444eb8-8bb8-8d5b-4cec-be7fa7530d0e@redhat.com>
 <4d8e6f55-66a6-d701-6a94-79f5e2b23e46@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <15da147c-e440-ee87-c505-a4684a5b29dc@oracle.com>
Date:   Fri, 19 Feb 2021 11:25:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <4d8e6f55-66a6-d701-6a94-79f5e2b23e46@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:303:b6::15) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0070.namprd03.prod.outlook.com (2603:10b6:303:b6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 19:25:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6d00cfd-3ecb-4243-da37-08d8d50c2ce1
X-MS-TrafficTypeDiagnostic: DS7PR10MB5006:
X-Microsoft-Antispam-PRVS: <DS7PR10MB50067C3CC1CD487CB96A8740E2849@DS7PR10MB5006.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XaveUdgH52O9xOOVCmRBDZQeRNj4+2Ihos/d5fJj5tR42+sB7jZdZGk/+yRZTZa267OZ6UXxlMONOISky9YpNeGbKjPxrzVonrzzX7YqWelvtlxhMFkDCR/uRIA/Z4EdE3/fx8EJHid7AESsNtWT/yTmUWvI4BtkinULvnXiuVoyL1AXrXW7x7UKP7tZSnidlNEmIAqdJmlwTxhKy7e8JoetpSB2lPNwzKIHB2c3u1KERp43cxOsRYB2EG7j9fUqoDb/EW14IkiHz4BUYQV9McdZ+wV1MuEZvSQhwdowAqSEu3J1JnrPiG5HhFaie7h7mB/Lut88BswXWh1CAo0/plvz3AQkEhHK4XZaT2gl9AUj5TJs8rSRgIAjMyh0JuADHovIvCyVg15Mv5r7hT05LsxaKv4TIX9J5Dy0JOtzDUvZ74VHelSx/RnIsM0iM+LkXFmQBulPpZ+mlBgzTMYXO/uS1jVUUxPA/+Nqhl5HKz+zxTPRf8Z2zbNI7Cyii+A44cJNSuj6zpQPtXA+h8YFPkFqWHYUzUWx3cpAZ2tkdQe8YrjcXoll170u6uJ73qXsItKnD47U/FTDjMYVFBLaA+BCy6UbeoVrWLXWZZLxnBxj/IrKzOLHDt4Zzkp2GqQfGZWZY3kHnMFCTGgMbbEwZnqF4fNBCzyU1d50zif+JmSRh8FJbg+wofjBK9DV5MdS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(376002)(396003)(5660300002)(36756003)(966005)(8676002)(31686004)(54906003)(53546011)(66556008)(31696002)(66476007)(956004)(52116002)(2616005)(44832011)(66946007)(83380400001)(26005)(110136005)(16526019)(186003)(478600001)(2906002)(316002)(7416002)(7406005)(86362001)(16576012)(6486002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Mmh2eUpleDRISDEwNDY3VkN5N0hscS9HNW1EQWRLYlBzRlAyWFdVV2ErVytk?=
 =?utf-8?B?RG9IelRFbXRMalEzQzloYVlBTjQxYS9MSDFaQkVsOC95eDk4OGt0N2NIbkpr?=
 =?utf-8?B?NGtvb2JhTU9IZHNFcWdoVnh0djJyekZGZVNzd205WHhsNU1kQjg5YUhyNmVZ?=
 =?utf-8?B?ZTNHR29GMVROYXl0eDl5YktmT3BpbGVaUDRYa3VsWEk0ZXVYOExlMGRMSXVF?=
 =?utf-8?B?Ym85YkZkOW9GVDRkWG5ZOVNiNDJwTTR3TityblNpK05Cc05mK0NBWFN4am1a?=
 =?utf-8?B?d3ZnTzRsUjNPQ1ZENS90QTRSZy9pS0NTSzR6ZGVCY3VFZXJMK2VHeVM2Zm9k?=
 =?utf-8?B?bS9xSE9sR1UzUXdaSCtaN2l6MEJzK1d6OVlFUyttOGNLQ0loUTJaL2dpTzBV?=
 =?utf-8?B?WTNUSFo0ci83T0tvYk5ENzZLZlJEZkxyRGZuS0hMNDE1aS82RDV2TXhrUTJu?=
 =?utf-8?B?eXBWQjVRRk5kTFJKRzMrQXBpYUtPTWRtc2MwZjBlNndNVEhBWHlnZzZUd1Js?=
 =?utf-8?B?ZEpQRlN2RTdLeW1KT3FpM2dYK0pzWTdNMmFSazhpTElFS2pDeTBQSUREL0NF?=
 =?utf-8?B?T3prenlTTW93WWw0VHpXUThJTWRaakJ2bkhrdjVSU3psbkh6L1NCQlphL3Fj?=
 =?utf-8?B?bE16VXhtWlNNeHRFYkdTdHQweVBkRWpIOU96cjRYRjVPNlRMY0FhTHU4SWU2?=
 =?utf-8?B?MVBZU0ltMkcwUzM4TFVjaDRJbDUwUHJpMXdnN2o3dlNRbjkzb0lZQjVOTExW?=
 =?utf-8?B?aTFSWkxnSFJnblR5K211dEFROVIrdmE2TUU4RXZvdG9uVU1jZGZ5dlU2ZjR2?=
 =?utf-8?B?L1h5NUdsVlI3RkJNUUc0N0ZORWtURldjazBOKzBESUVpWTh1eW94S1d4OFBo?=
 =?utf-8?B?MnFiVHZ0MHdndFMwaTZlK3ZnS2pTbGVRRC9zaERwT3hJendMUEVZWE1MQkdT?=
 =?utf-8?B?UkNwdlFabXFET052aGRaaW4vWEc3SGdyczQ2ekI1VUZWR3c3elNoM0hQZE1H?=
 =?utf-8?B?Y2tlbzNKOTgwMVZJNCtyaEpNaStZd2c0dUpiM0E5ZXRXeVVyTDNZTlllRTI1?=
 =?utf-8?B?MkU4SjRZVm10VXpjNEF6K2xHK21WM3cwQmt6RlZBUSs3RVZHNWMyaDBoSHF6?=
 =?utf-8?B?NlcvdHcvbCtyWTJuNGI2U2x5MCs1Y3pYRHdsQ0EwanNlZjh4Vy9XbHNaUFZm?=
 =?utf-8?B?S1I3bEtHS3AwZHBQQ2FtTGRqdE1JSHc2WHZEVXFxVWpvSXV0R29PdnFVUFpX?=
 =?utf-8?B?K0s0L3J2Z2dNQVF3UENNYmJmRXFvQVY1RytVZzltRzRWNXF1TkNXSVBpd2xh?=
 =?utf-8?B?Z2FORnZsYzlUaUw2RENwQkFpYnBlYzA4UDRiSFdrakJnRFNicE5VYjlTSU9C?=
 =?utf-8?B?b29mUFNTbVcrUG5WdVlVcnk4RnhJMURyQU0xayticXdzNDArT0hJN2xaaDc2?=
 =?utf-8?B?VmdOTElZanlhSWlDMnFCMURvLzAvVzNrVkN1ay9yb3ZiWHo2cjhXZGw3SFpZ?=
 =?utf-8?B?OHVVU3pRTmJFckhNK3NNVkpqRG54Wm0vV1pRZ3BmcVJONkdqYnc5Y1F4VXhJ?=
 =?utf-8?B?WlZUK0hxS1liK2U1aCtFb0ZKNVcyQjB5NmRwZEtNV2F2YlZLNmlPZzVneGU0?=
 =?utf-8?B?NVFlcXBBcTc2Sy9HNFE0T2QvMldoMy96U0JmblpzUmlBcWJmVnp1THVPeUc3?=
 =?utf-8?B?eXV1TCtuSzZWTW9hUTVtcGh1a2UwUkg3cXpseHptZGJBSmlabXdWOExFa04v?=
 =?utf-8?Q?e4ZAfBHX6R7I8PJO4Et+9fxevlziXHnwcqsajHJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d00cfd-3ecb-4243-da37-08d8d50c2ce1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 19:25:54.6708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3x90M24ygCjnBtabCczoIolN0Lv+L5tAdgw1i0E/x2+hT7BEg4rkMgYFkCThlCcae8WgBHxe2KMQA0SSoj8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190152
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190153
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/19/21 11:14 AM, David Hildenbrand wrote:
>>> It's interesting to know about commit 1e356fc14be ("mem-prealloc: reduce large
>>> guest start-up and migration time.", 2017-03-14).  It seems for speeding up VM
>>> boot, but what I can't understand is why it would cause the delay of hugetlb
>>> accounting - I thought we'd fail even earlier at either fallocate() on the
>>> hugetlb file (when we use /dev/hugepages) or on mmap() of the memfd which
>>> contains the huge pages.  See hugetlb_reserve_pages() and its callers.  Or did
>>> I miss something?
>>
>> We should fail on mmap() when the reservation happens (unless
>> MAP_NORESERVE is passed) I think.
>>
>>>
>>> I think there's a special case if QEMU fork() with a MAP_PRIVATE hugetlbfs
>>> mapping, that could cause the memory accouting to be delayed until COW happens.
>>
>> That would be kind of weird. I'd assume the reservation gets properly
>> done during fork() - just like for VM_ACCOUNT.
>>
>>> However that's definitely not the case for QEMU since QEMU won't work at all as
>>> late as that point.
>>>
>>> IOW, for hugetlbfs I don't know why we need to populate the pages at all if we
>>> simply want to know "whether we do still have enough space"..  And IIUC 2)
>>> above is the major issue you'd like to solve too.
>>
>> To avoid page faults at runtime on access I think. Reservation <=
>> Preallocation.
> 
> I just learned that there is more to it: (test done on v5.9)
> 
> # echo 512 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
> # cat /sys/devices/system/node/node*/meminfo | grep HugePages_
> Node 0 HugePages_Total:   512
> Node 0 HugePages_Free:    512
> Node 0 HugePages_Surp:      0
> Node 1 HugePages_Total:     0
> Node 1 HugePages_Free:      0
> Node 1 HugePages_Surp:      0
> # cat /proc/meminfo  | grep HugePages_
> HugePages_Total:     512
> HugePages_Free:      512
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> 
> # /usr/libexec/qemu-kvm -m 1G -smp 1 -object memory-backend-memfd,id=mem0,size=1G,hugetlb=on,hugetlbsize=2M,policy=bind,host-nodes=0 -numa node,nodeid=0,memdev=mem0 -hda Fedora-Cloud-Base-Rawhide-20201004.n.1.x86_64.qcow2 -nographic
> -> works just fine
> 
> # /usr/libexec/qemu-kvm -m 1G -smp 1 -object memory-backend-memfd,id=mem0,size=1G,hugetlb=on,hugetlbsize=2M,policy=bind,host-nodes=1 -numa node,nodeid=0,memdev=mem0 -hda Fedora-Cloud-Base-Rawhide-20201004.n.1.x86_64.qcow2 -nographic
> -> Does not fail nicely but crashes!
> 
> 
> See https://bugzilla.redhat.com/show_bug.cgi?id=1686261 for something similar, however, it no longer applies like that on more recent kernels.
> 
> Hugetlbfs reservations don't always protect you (especially with NUMA) - that's why e.g., libvirt always tells QEMU to prealloc.
> 
> I think the "issue" is that the reservation happens on mmap(). mbind() runs afterwards. Preallocation saves you from that.
> 
> I suspect something similar will happen with anonymous memory with mbind() even if we reserved swap space. Did not test yet, though.
> 

Sorry, for jumping in late ... hugetlb keyword just hit my mail filters :)

Yes, it is true that hugetlb reservations are not numa aware.  So, even if
pages are reserved at mmap time one could still SIGBUS if a fault is
restricted to a node with insufficient pages.

I looked into this some years ago, and there really is not a good way to
make hugetlb reservations numa aware.  preallocation, or on demand
populating as proposed here is a way around the issue.
-- 
Mike Kravetz
