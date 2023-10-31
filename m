Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08B7DD906
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 00:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347144AbjJaXCB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 19:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347136AbjJaXCA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 19:02:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE5E103;
        Tue, 31 Oct 2023 16:01:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VKWda2004709;
        Tue, 31 Oct 2023 23:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9ac4iejw4v+xQwgveoG5MYfp+Ka3WKJriViq5raxjko=;
 b=r0tD9ZhKY2yyyFo3TZGUbpVPhqCBOP9TmHmPG7LYgek8Fcb9qUYXq2itAgq1dsHxfoIJ
 8iy/FlF7neFRqs3m72Peq2PdEm2TiGA3djMIgvDe7CzpHGWFg/1iM5kQeUSHzDZNV8p4
 2wcTwVbnB/TV+hXSDCQgLHF+JvL+pPqtqwVGX+oJsPqVuZ2HzteRlHPGF2QFCsXk7z31
 YSokSkqo2zuxHBA+dr5d5vw8gV3UtRf7bFAbiQtmFkuTs9apIuh2QnNgaSlli8B+7qf2
 Fmz3guS3TRqBokqo3ALhGjw/t4wn+sXeW6CWUhDFZrZK6QTUAh21umK5wlniTxFwDcvW tA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0tbdpd96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 23:01:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39VLVH44001119;
        Tue, 31 Oct 2023 23:01:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr6qa9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 23:01:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoKOb7sG20GNuPt8/SPFup/t+JedapH/tfeMwo2VGMKY+oLRDfJhCiJL496BLNAi8z7VrjCn+1HZyUzyS18WkkXcIw/JDbBdz+CoIDCbVnKAzwh3JC64V7bA0qAny8j1qrdCjWTP0JWUcpC9hol5HT0c8wOnzIJhw4bqvOtcsI4N+0l0DSKvj2rQyKvJZSLZQxKAyOjzd2jK/rNC9yr1LBbddUdqYKs6QcGeoJ9y/yT9+cEngdH6UDK/rxxh+eu8bp7HDrVAa/0gv2/6VMjSnVMcbs8z0dBrr+u7KHdLKdPeLxIdsfhXaDv+xpHnYZYby7uJO7mVIr8l7hRAsix+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ac4iejw4v+xQwgveoG5MYfp+Ka3WKJriViq5raxjko=;
 b=THXG8pwMStYVhw83wZC+QHxeduIaISllaXI6W4rPTKo9IoHI8Owkh1pUz5248T11IN6818FPx/dUDQVp38anwbYwcGlEP8AaN/qzuI5gw6Tw63H7r2ye5GR3qUF+CvHpDOPXIyM8sceeiQwitf9bMgUdwkh9zLLIW/3SHAjotC8KdpXnxYLGb4wthBcQMB1y0MyEbz/PzRPEX3A9npKifLqfzZOjhJoJY72EUUT06ovnFLvA3yE1R9Ox8DR/kubBwoB0VqYpXHHgF70Vkth4mPUoWr/J33r2kaO9YjM4e5Sf357leqbfotM5aZzddpy1wrJ/UNdEfEsy8OQeOsIk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ac4iejw4v+xQwgveoG5MYfp+Ka3WKJriViq5raxjko=;
 b=RSkjheLqd9aY4IIgzO6810plgL0lt33s6A+DICzOP/QzaYDiA93pRLrmcqP3zmGJ+QhWrf3RutFpKEeXvH4PRQqMIAo0cceCyzIh+51jndpI4nGi+sbR9dG5GBLUbLK0z0rjFIsFffJX9o/e5Zq+XqCv2PKrzQqV8FDfEV+9zZY=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DM4PR10MB5944.namprd10.prod.outlook.com (2603:10b6:8:aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 31 Oct
 2023 23:01:32 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ab1:d70:8f78:d876]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ab1:d70:8f78:d876%7]) with mapi id 15.20.6933.022; Tue, 31 Oct 2023
 23:01:32 +0000
Message-ID: <18d80012-193b-47cf-ab75-794c5730aa71@oracle.com>
Date:   Tue, 31 Oct 2023 17:01:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Sharing page tables across processes (mshare)
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Mark Hemment <markhemm@googlemail.com>
References: <4082bc40-a99a-4b54-91e5-a1b55828d202@oracle.com>
 <3bbdc5de-ce97-4a4d-b420-1605cef3ffcd@linux.alibaba.com>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <3bbdc5de-ce97-4a4d-b420-1605cef3ffcd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:5:134::35) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DM4PR10MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: ae31ff61-f7b7-415f-3240-08dbda6552c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg0nbdOn0pxwcAlL/RtNTSLgEx6rRN0yOaYP3gn2E1ssThKhKFZkzOz8Xeh0xX11HIJ0bH78hY/P6ZsZJ62LOvG55VB2UPpgYe3byrwRXAS6krGv+rRo0sCtCegL2MqH3M2gBn95qDMf2b/qmHxuYfFOsctaaUOB/2l/gCFPxJVsUc4yKMmr0NHTJSHKBaZrodT+jyx2Gq1wr96eum+5MEc2oEumvLEdKof72I3K5jiTvKsiXwGXSh/EFm2PvfmscBKoskJynIsQNtxwdS77Y4rt2S5vM6zps0qY8aCB7yuW80CHWJUOelAeWNjkO987mv5Y06JW821mur6YovEpwJqYsLG/GReq1IfoWhnvf3zZNsDtrYu3aaYSY4yn/8CPZBbQPSksZj6ke0bfsL6pSJWJMdrOMNRKC9Jk+YeGy/7SHuxGctDcl6A5CsAwZMcsLMdQkE9x5yxSBq99YrJ2/kBmt8d9V7RY5TW08p/JnyyUaKDBA2Oq9nScTSKv4cSuxiQjlfeUnGCL50ly2IQ3QOftSHQ7FmMDFd4pEl5jnvGdEcFX9gCaBb9sTqpb6dNIMlevFT7q2OlN7i2bSKt43lT9LybYDVMZkG6bwji/Q3qtsKP/SusC8V7bht1yLeeQETA1p/Zi1kTWdSDj5wx9QAoeOsxN3AViTVXd6gtk+sccBczAzQqSc0xYUCnZXeoJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(83380400001)(6486002)(38100700002)(30864003)(8676002)(4326008)(26005)(44832011)(53546011)(2906002)(8936002)(36756003)(2616005)(66476007)(5660300002)(31696002)(6916009)(54906003)(316002)(6506007)(41300700001)(6512007)(6666004)(86362001)(66556008)(66946007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTA5Uk41UVJUOGxFeERlQlVXSG5sTWFqNjF0cS9TQzI3bWUyOVRETWYvMmQ3?=
 =?utf-8?B?RkhpaW45c3B5Uk9HS3dUV3hMblIyVnJiL3lKYllaMDVJcWd0RFg2aUd4Wmt3?=
 =?utf-8?B?SGpjTVhpMVY5bldMcjBScVlkb1F2VENmcjh5RTdHZnpOellZRjhvNDh6Tlp1?=
 =?utf-8?B?VUg5OE16b1FMcStiK3FVSE96cE5tV2V0QXZQSlVDekZ5RG9PL3pqMmU5akhn?=
 =?utf-8?B?Qlc5WWw5ajdZdXZjbnBtQWlva1lScEVmMTk0dVN4bCt5dkpVTERPL2Nncjhy?=
 =?utf-8?B?ZTZSMmNNNDBGQ2QvSTVybDZlRDRVRE1Kenh5d1VLOUxwdjYxQWFuSXpIYUhy?=
 =?utf-8?B?eVpzR3g4UmQ3N1ptRXNGMlBvTDQ5dElFMTRic1M3YllqNFRuZU9ZQ0JIVEJX?=
 =?utf-8?B?TUh5NnI1MWExdWtCZUVLTmJkY3Yvb0pQQlBROUhKQk9NT25tTEI2VFplNmlG?=
 =?utf-8?B?OVU5VzhVSVhla256aWgyZGtGck5JejlRVmtnMURXZGthbTNNMjV2VGltTzdr?=
 =?utf-8?B?b1VPRHVyMEEwdENhNHoxSmZ4ZVJORDNCb1hKRDZDQ1VJeEMvZ2hsWUhLeEta?=
 =?utf-8?B?RDI4RU9ncG5LUVJ5d0hBM1d4K0pxSXduYndSK2M2VUNTb3dIWXY2UStzQzZX?=
 =?utf-8?B?ZzVrQ1BwZmtiSGJheTM2dWhoUGNiYTlINGRFZkV0TkVLaHRranMzZFpjQ0gy?=
 =?utf-8?B?M1NndmJpV1kwZUE3VVlvMjc5ZG5rN0JsNHRTQnovakI0SXpFaThneFBYTitw?=
 =?utf-8?B?MWF1WUYydW1KM2NzMks5WUduTnpPTCtBbnBEYUVDU0tRMVArakFOTnFlMTRv?=
 =?utf-8?B?QkJrS2hkdVkwcXZsQ1J6dVVRWHBQQVJtM1UyTGJwYnQzQUVqVDlMRDZDV1kz?=
 =?utf-8?B?alIwelVadE50RnFGQUxuaHBzK3gwUmN3OHRtekh1dWpzNkU1cmh6cXovMmZo?=
 =?utf-8?B?Yk9tTk15OWlvYzlFdTZDbC9kQ00weEFueGxpRGRMNzZzSlQzR0VzWjVmZUN5?=
 =?utf-8?B?M3NLUW9NUVRqa0NzOGZCcEZiUE5xUFlIWDBmMmI2T2xnV0RhU3JFVk5hRU01?=
 =?utf-8?B?bDBQcHkvY0pCN2VMa3REeEE0bEZJdEU1ZDJoRUVMbDMvbm1ROGtZZVlKRm92?=
 =?utf-8?B?YS9KMzY2Yml0S0tnNEpDTjZvdWJmZXNRRWZmamQxSGhyZFg0YjdKOGRvaXI4?=
 =?utf-8?B?RC9BVU54WnAyZzlYRm1hd0NrOU5PclV2Wkpod2YvaXFuRVBsL1dYcEdvV29h?=
 =?utf-8?B?NGdKeXd0Z0hhSnRGaTJoRXNpWHFYNWI4NTVFMDNSUmRaSGlWMkp1WmpxUk8v?=
 =?utf-8?B?V1BLUnpacENpRUVaeDhHWk4zd0VwQmtJbkxzdE1wN3RMaURTUVdnT1libm5r?=
 =?utf-8?B?aUJOWTZJSHV5WU51Sjh0bHlEdmxaTFlnTmoyb25XaVR6UFVraS8yUDR4S2Ja?=
 =?utf-8?B?dXZ5YVVHcEhLM2w4bklGOXJoVGZkOEFxQ29rK2d5bmdzZlFDMUF5MVBTWmRS?=
 =?utf-8?B?Nm45ay8yRGt3azBQWFYvUnE1S3BhUjFkcm9KR09xOEpqUFN0M0NQc3N2MmNk?=
 =?utf-8?B?RmhYUjl3YWROb3hzb2pKb05UMkNsWTZMSm9OaTQ1L1o2T2kxSTVMcDhKR1JN?=
 =?utf-8?B?aTZwYjRtL3BIRHJRMzQ4L0RXQk5EZXlseklmTEttTjBtUXQ1VDlLdHVUL2dM?=
 =?utf-8?B?dGFCT2NzVG5zNmtOUXdzV2s2Rkp0c05taXc0VmRNTE1FcXFycjIwckExR2Vy?=
 =?utf-8?B?Skw5K2V0MVhmZEpBOFpNaXIxZTYwWC9ZNDlaNXRwSUQxWmx6NzFXM0RpMjRo?=
 =?utf-8?B?SzlUc1hCbXFFRnNKL1ZSK1VGRDd1ZEJqdmp2L1Y1TXllTytCWnovSlo2NlRp?=
 =?utf-8?B?enlUVmtaa3JHbGtlMzJhZHZvck9DZGJoVUZ1aEgzQkJDV3BKUThETUxCVndX?=
 =?utf-8?B?UC8vUHI5bFdieHpDazYyaUpUeFVrQ3d3UUhkTVA1RHZJcFQxQ2UraDNWdWtp?=
 =?utf-8?B?ejF1SlZRTG5yM1RGV01IcmxYTzlKZ0tTeHJOMzlKcEVxOW1GbmNFdzdDWC92?=
 =?utf-8?B?STdMakZkSWJSL2k1em1VZ01ZYkdFcVE1NXgvZkE3bjZpN0trRm4wUGpHSDBj?=
 =?utf-8?Q?u/Tss+r1yr71x1i8ecpZjGDe5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OThQZkhDV1VHNzdnZEFyTVJKdTljSDdSNUJ0eXMvWUlXVmlNRE1jbEJXOFBX?=
 =?utf-8?B?Sk1BbDV6S2JNZVByU2k3ei9oYkFuWFhhQktQRXJXZytXcGhhSnNFYklocHBJ?=
 =?utf-8?B?NU1xTEYycWxib2R2NnNJQmNpOVd4OVhYV1hvYmx5MFRxTVF2MnMzUjVOWjd6?=
 =?utf-8?B?ZDVnMllvdjE3UDVWeDlHUXBEZWRFa09LcGVOS3Rzb3hWL0pvVk5iUEowUi9H?=
 =?utf-8?B?QUovVUx6Nm1zUllpVGtINzNvdVBKS2UreDlnY3hPeHJWbFcwL0RnTWczYVBr?=
 =?utf-8?B?cVJ0eEpqQTFuZHdLbTRZOHRTcEowWDBYa1k3MkF1RmNkVG9ZOXplMjV4Znh4?=
 =?utf-8?B?RStNaTNtT2w3R0pxZkd2MDJobE5mMFhoZEZTY0FkSS85K1VybzRJVzlHOU83?=
 =?utf-8?B?a3FjbEI3YURHaXpGNXRhcHZXR0JYanpJQ2RSemRjUXJGd0lKbktrMVdyODkz?=
 =?utf-8?B?V1U0R1dHK3Y0Q1VEQ21aaHo4OUlENGZOQmtXcytoa3BIaUlZNGFhRWRpTHNB?=
 =?utf-8?B?Z2NBTHJNZXFZejUzUkhMdDF6NEtQTGNCK0NJNTlzNFc4Y1V3WVF4MUVnUVcv?=
 =?utf-8?B?R2lTMEFwdlljSU52S2dtZmlvZkRoRmMxdFRXY0NqU0lYM0RROGdRUTIrbmNx?=
 =?utf-8?B?K3VWd21mVlRScHNWUG13ZVRwS1A3VW9JekR4eG0xcmc1L0thT0RrRUdjYlFF?=
 =?utf-8?B?L1BNemF1ZThxVFJwTFpIN3lGU2k4YmxIeFU5NURkb0tlUjhHT3J4c3NrZmV2?=
 =?utf-8?B?S3dWenFRVllvRXpCTXNrYlhGR2h2UHNaL0ZjTnQyNTZnUm9sVG96bEhnTStT?=
 =?utf-8?B?QkltaU1vbnBVZjRXSXBpQ2dRRHpvWlZYSEVGMlhwNjNWRXhhLzVNNlc2TUtq?=
 =?utf-8?B?UW1hY0ErbjZMM0poMnR4V2k4OXRSY1ZlL3NtQUtwWFlTYW9yZVAzakhBcFli?=
 =?utf-8?B?STBDbjNROUd5cHlUOURwTTkzbWJPZGc0M3ZnM2NLQWUzTnozK2VwRHlSaXln?=
 =?utf-8?B?R1FBQTFZdU9qdDNxMk5EZXhZS0tlbTd0WTBFemFuWU9hLy9BVllwcXdGa2VY?=
 =?utf-8?B?Qm40N0JnNXNVRDJxMGV3VnUrQVdmbktBV3VNdTl3cERibHpNU1JvZEFiVmhy?=
 =?utf-8?B?QXc4ZFhxVUVTdkFicnpBMjdGbUtzYmdJTmtIc3ZCL1Brc0djUHRoaElPK3Rm?=
 =?utf-8?B?UGFwS0M4T3YyNFZ0czB5WnJCN2Z4anJnOUpPcm9GZmFFTjdORzZQY3hDUDVW?=
 =?utf-8?Q?Ix7EyITh7xmZEN7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae31ff61-f7b7-415f-3240-08dbda6552c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 23:01:32.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWMSM2y0rYpmUfHnz+NlKuYgzLslAld7wU8W/rgOjQQw3Do9ypukKegUeKVeuEaBLe0qjl2z7S+5+WF5WvjOqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5944
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_10,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310190
X-Proofpoint-GUID: lEPLkyRWPZDUz5zeOQVzz8C8ObjzZ97g
X-Proofpoint-ORIG-GUID: lEPLkyRWPZDUz5zeOQVzz8C8ObjzZ97g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/29/23 20:45, Rongwei Wang wrote:
> 
> 
> On 2023/10/24 06:44, Khalid Aziz wrote:
>> Threads of a process share address space and page tables that allows for
>> two key advantages:
>>
>> 1. Amount of memory required for PTEs to map physical pages stays low
>> even when large number of threads share the same pages since PTEs are
>> shared across threads.
>>
>> 2. Page protection attributes are shared across threads and a change
>> of attributes applies immediately to every thread without any overhead
>> of coordinating protection bit changes across threads.
>>
>> These advantages no longer apply when unrelated processes share pages.
>> Some applications can require 1000s of processes that all access the
>> same set of data on shared pages. For instance, a database server may
>> map in a large chunk of database into memory to provide fast access to
>> data to the clients using buffer cache. Server may launch new processes
>> to provide services to new clients connecting to the shared database.
>> Each new process will map in the shared database pages. When the PTEs
>> for mapping in shared pages are not shared across processes, each
>> process will consume some memory to store these PTEs. On x86_64, each
>> page requires a PTE that is only 8 bytes long which is very small
>> compared to the 4K page size. When 2000 processes map the same page in
>> their address space, each one of them requires 8 bytes for its PTE and
>> together that adds up to 8K of memory just to hold the PTEs for one 4K
>> page. On a database server with 300GB SGA, a system crash was seen with
>> out-of-memory condition when 1500+ clients tried to share this SGA even
>> though the system had 512GB of memory. On this server, in the worst case
>> scenario of all 1500 processes mapping every page from SGA would have
>> required 878GB+ for just the PTEs. If these PTEs could be shared, amount
>> of memory saved is very significant.
>>
>> When PTEs are not shared between processes, each process ends up with
>> its own set of protection bits for each shared page. Database servers
>> often need to change protection bits for pages as they manipulate and
>> update data in the database. When changing page protection for a shared
>> page, all PTEs across all processes that have mapped the shared page in
>> need to be updated to ensure data integrity. To accomplish this, the
>> process making the initial change to protection bits sends messages to
>> every process sharing that page. All processes then block any access to
>> that page, make the appropriate change to protection bits, and send a
>> confirmation back.  To ensure data consistency, access to shared page
>> can be resumed when all processes have acknowledged the change. This is
>> a disruptive and expensive coordination process. If PTEs were shared
>> across processes, a change to page protection for a shared PTE becomes
>> applicable to all processes instantly with no coordination required to
>> ensure consistency. Changing protection bits across all processes
>> sharing database pages is a common enough operation on Oracle databases
>> that the cost is significant and cost goes up with the number of clients.
>>
>> This is a proposal to extend the same model of page table sharing for
>> threads across processes. This will allow processes to tap into the
>> same benefits that threads get from shared page tables,
>>
>> Sharing page tables across processes opens their address spaces to each
>> other and thus must be done carefully. This proposal suggests sharing
>> PTEs across processes that trust each other and have explicitly agreed
>> to share page tables. The proposal is to add a new flag to mmap() call -
>> MAP_SHARED_PT.  This flag can be specified along with MAP_SHARED by a
>> process to hint to kernel that it wishes to share page table entries
>> for this file mapping mmap region with other processes. Any other process
>> that mmaps the same file with MAP_SHARED_PT flag can then share the same
>> page table entries. Besides specifying MAP_SHARED_PT flag, the processe
>> must map the files at a PMD aligned address with a size that is a
>> multiple of PMD size and at the same virtual addresses. NOTE: This
>> last requirement of same virtual addresses can possibly be relaxed if
>> that is the consensus.
>>
>> When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
>> is created to hold the shared page tables. Host mm struct is not
>> attached to a process. Start and size of host mm are set to the
>> start and size of the mmap region and a VMA covering this range is
>> also added to host mm struct. Existing page table entries from the
>> process that creates the mapping are copied over to the host mm
>> struct. All processes mapping this shared region are considered
>> guest processes. When a guest process mmap's the shared region, a vm
>> flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
>> fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
>> flag is found, its corresponding PMD is updated with the PMD from
>> host mm struct so the PMD will point to the page tables in host mm
>> struct.  When a new PTE is created, it is created in the host mm struct
>> page tables and the PMD in guest mm points to the same PTEs.
>>
>>
>> --------------------------
>> Evolution of this proposal
>> --------------------------
>>
>> The original proposal -
>> <https://lore.kernel.org/lkml/cover.1642526745.git.khalid.aziz@oracle.com/>,
>> was for an mshare() system call that a donor process calls to create
>> an empty mshare'd region. This shared region is pgdir aligned and
>> multiple of pgdir size. Each mshare'd region creates a corresponding
>> file under /sys/fs/mshare which can be read to get information on
>> the region.  Once an empty region has been created, any objects can
>> be mapped into this region and page tables for those objects will be
>> shared.  Snippet of the code that a donor process would run looks
>> like below:
>>
>>         addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
>>                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);
>>         if (addr == MAP_FAILED)
>>                 perror("ERROR: mmap failed");
>>
>>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
>>             GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
>>         if (err < 0) {
>>                 perror("mshare() syscall failed");
>>                 exit(1);
>>         }
>>
>>         strncpy(addr, "Some random shared text",
>>             sizeof("Some random shared text"));
>>
>>
>> Snippet of code that a consumer process would execute looks like:
>>
>>         fd = open("testregion", O_RDONLY);
>>         if (fd < 0) {
>>                 perror("open failed");
>>                 exit(1);
>>         }
>>
>>         if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
>>                 printf("INFO: %ld bytes shared at addr %lx \n",
>>                 mshare_info[1], mshare_info[0]);
>>         else
>>                 perror("read failed");
>>
>>         close(fd);
>>
>>         addr = (char *)mshare_info[0];
>>         err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
>>             mshare_info[1], O_RDWR, 600);
>>         if (err < 0) {
>>                 perror("mshare() syscall failed");
>>                 exit(1);
>>         }
>>
>>         printf("Guest mmap at %px:\n", addr);
>>         printf("%s\n", addr);
>>     printf("\nDone\n");
>>
>>         err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
>>         if (err < 0) {
>>                 perror("mshare_unlink() failed");
>>                 exit(1);
>>         }
>>
>>
>> This proposal evolved into completely file and mmap based API -
>> <https://lore.kernel.org/lkml/cover.1656531090.git.khalid.aziz@oracle.com/>.
>> This new API looks like below:
>>
>> 1. Mount msharefs on /sys/fs/mshare -
>>     mount -t msharefs msharefs /sys/fs/mshare
>>
>> 2. mshare regions have alignment and size requirements. Start
>>    address for the region must be aligned to an address boundary and
>>    be a multiple of fixed size. This alignment and size requirement
>>    can be obtained by reading the file /sys/fs/mshare/mshare_info
>>    which returns a number in text format. mshare regions must be
>>    aligned to this boundary and be a multiple of this size.
>>
>> 3. For the process creating mshare region:
>>     a. Create a file on /sys/fs/mshare, for example -
>>         fd = open("/sys/fs/mshare/shareme",
>>                 O_RDWR|O_CREAT|O_EXCL, 0600);
>>
>>     b. mmap this file to establish starting address and size -
>>         mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
>>                         MAP_SHARED, fd, 0);
>>
>>     c. Write and read to mshared region normally.
>>
>> 4. For processes attaching to mshare'd region:
>>     a. Open the file on msharefs, for example -
>>         fd = open("/sys/fs/mshare/shareme", O_RDWR);
>>
>>     b. Get information about mshare'd region from the file:
>>         struct mshare_info {
>>             unsigned long start;
>>             unsigned long size;
>>         } m_info;
>>
>>         read(fd, &m_info, sizeof(m_info));
>>
>>     c. mmap the mshare'd region -
>>         mmap(m_info.start, m_info.size,
>>             PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>
>> 5. To delete the mshare region -
>>         unlink("/sys/fs/mshare/shareme");
>>
>>
>>
>> Further discussions over mailing lists and LSF/MM resulted in eliminating
>> msharefs and making this entirely mmap based -
>> <https://lore.kernel.org/lkml/cover.1682453344.git.khalid.aziz@oracle.com/>.
>> With this change, if two processes map the same file with same
>> size, PMD aligned address, same virtual address and both specify
>> MAP_SHARED_PT flag, they start sharing PTEs for the file mapping.
>> These changes eliminate support for any arbitrary objects being
>> mapped in mshare'd region. The last implementation required sharing
>> minimum PMD sized chunks across processes. These changes were
>> significant enough to make this proposal distinct enough for me to
>> use a new name - ptshare.
>>
>>
>> ----------
>> What next?
>> ----------
>>
>> There were some more discussions on this proposal while I was on
>> leave for a few months. There is enough interest in this feature to
>> continue to refine this. I will refine the code further but before
>> that I want to make sure we have a common understanding of what this
>> feature should do.
>>
>> As a result of many discussions, a new distinct version of
>> original proposal has evolved. Which one do we agree to continue
>> forward with - (1) current version which restricts sharing to PMD sized
>> and aligned file mappings only, using just a new mmap flag
>> (MAP_SHARED_PT), or (2) original version that creates an empty page
>> table shared mshare region using msharefs and mmap for arbitrary
>> objects to be mapped into later?
> Hi, Khalid
> 
> I am unfamiliar to original version, but I can provide some feedback on the issues encountered
> during the implementation of current version (mmap & MAP_SHARED_PT).
> We realize our internal pgtable sharing version in the current method, but the codes
> are a bit hack in some places, e.g. (1) page fault, need to switch original mm to flush TLB or
> charge memcg; (2) shrink memory, a bit complicated to to handle pte entries like normal pte mapping;
> (3) munmap/madvise support;
> 
> If these hack codes can be resolved, the current method seems already simple and usable enough (just my humble opinion).
Thanks for taking the time to review. Yes, the code could use some improvement and I expect to do that as I get 
feedback. Can I ask you what you mean by "internal pgtable sharing version"? Are you using the patch I had sent out or a 
modified version of it on internal test machines?

Thanks,
Khalid

> 
> 
> And besides above issues, we (our internal version) do not care memory migration, compaction, etc,. I'm not sure what
> functions pgtable sharing needs to support. Maybe we can have a discussion about that firstly, then decide
> which one? Here are the things we support in pgtable sharing:
> 
> a. share pgtables only between parent and child processes; > b. support anonymous shared memory and id-known (SYSV shared memory);
> c. madvise(MADV_DONTNEED, MADV_DONTDUMP, MADV_DODUMP), DONTNEED supports 2M granularity;
> d. reclaim pgtable sharing memory in shrinker;
> 
> The above support is actually requested by our internal user. Plus, we skip memory migration, compaction, mprotect, 
> mremap etc, directly.
> IMHO, support all memory behavior likes normal pte mapping is unnecessary?
> (Next, It seems I need to study your original version :-))
> 
> Thanks,
> -wrw
>>
>> Thanks,
>> Khalid
> 

