Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB7E51DF7A
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389375AbiEFTM3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 15:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbiEFTM2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 15:12:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437421A81C;
        Fri,  6 May 2022 12:08:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246Ibonl004338;
        Fri, 6 May 2022 19:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6wKWZknwOj/wteDnVdRht8fPTKBGaDCoZYovz2lmZ7A=;
 b=DLTls3c+3AzJVw/Rgeq/g5ePaqUghKIR6VQ7Z4qmkKXPotyjMYUzCh2vhpdtESf+hrne
 rPcWZQsiKqTLcbuaYrT35w66HBeYGDTcoZiQBuDBgc19R1QO+M/8b48BCpy7ZmbonUjT
 mlJawv+KP1iRVAhYKsR9sQKXoM/BqXYg3d16eCifJl9M71+OuUJl+kQP58BdPapmFBtc
 lEluMHH8MftIXOAFuXXdY+xGBI+i41vn1y246563po13NdC1zlr1yglzVPN39aU/JgP3
 y8/zPGIRWVnkCI9/T9aV3DNdkM+RMANH6hwvjHP5Rb6p2LJe5ZWd8yLjx4wnx0krImmi sA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0q1df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 19:07:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 246J6fZV015564;
        Fri, 6 May 2022 19:07:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fus90kjdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 19:07:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3v5rCq7a93nSOYtpGWMcwrP7Say2seJy4XM/4HlAiZAeku1OyrZl+OLT3KGpEhkI/QO5f8TPId55XqnzwG0xr0ckPsorleUWDUctgwnaU4GKHDoBMJ3Wz89gpG04w8WxYkggCizOfUUzKwFFWkqEQnjRJ9nx927KjyYYM5SI2Romto11GGxoKotRAISg0Pqtyx1d/8OtUIsAGyai94aY6iFskFJ6zRySViKBmhGpo5WhY6Fw7L+9v3CBtXRdgYntiwSnOj2ZC8ZlvOwKwz+kcB0LHOn0OUImOV7bDVcOH2TJxXlEleoUa0CxAApquRfMvg+D8136nu21q4rnOD/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wKWZknwOj/wteDnVdRht8fPTKBGaDCoZYovz2lmZ7A=;
 b=R5H9zxsg1xIFTfHPCuhgU12XMI5jc03l01Pmc0FG4U4eph8wSZZCZ1kUsq7RQ5da9Q6tykkYTfpGkF7Gok5nS3MN/DlecuPS1jO+bhfPAwktBP/8vplJMd8aDAQ8DFFrBrB0ZNU3jBI5fwoIfcfD2XXaUMIo1cJw+SLsxmy5dHuX9hRfwfMk/n4oo47CJ+1Gu+3B0MYtpCvBdWD5MDmhDvaLs0AX5na9R1uClCaiUL2Wopbj8EdaCwhz8fFzlO2sCiWmLKEYhqd8KKhXN+Uba+qUyWaGCwC5dQMTZ8nwK+99b3JWhdq0HQoop0qQqWPlhWrpilp/rRgnUjSYvaDjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wKWZknwOj/wteDnVdRht8fPTKBGaDCoZYovz2lmZ7A=;
 b=OpEFdRvV75ozGsOMxi1TCa9ueuqDafNJCJUPFL7U/7qx2DmB2ZukkGe9IKifG3IeGKjWTtYLRFMJc33AUfc9h71sYXM6bU/jXDM2YWnqlL+fouPIFSx0qotyRHDMjQZAi117dmTSl8BViwwjuMn4BtL2Av3wi5zaOTKXfPMFAo8=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DM5PR10MB1579.namprd10.prod.outlook.com (2603:10b6:3:7::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.23; Fri, 6 May 2022 19:07:17 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::e81e:38af:cb6e:59e5%4]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 19:07:17 +0000
Message-ID: <927dfbf4-c899-b88a-4d58-36a637d611f9@oracle.com>
Date:   Fri, 6 May 2022 12:07:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when
 unmapping
Content-Language: en-US
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, tsbogend@alpha.franken.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1651216964.git.baolin.wang@linux.alibaba.com>
 <c91e04ebb792ef7b72966edea8bd6fa2dfa5bfa7.1651216964.git.baolin.wang@linux.alibaba.com>
 <20220429220214.4cfc5539@thinkpad>
 <bcb4a3b0-4fcd-af3a-2a2c-fd662d9eaba9@linux.alibaba.com>
 <20220502160232.589a6111@thinkpad>
 <48a05075-a323-e7f1-9e99-6c0d106eb2cb@linux.alibaba.com>
 <20220503120343.6264e126@thinkpad>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220503120343.6264e126@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdc15f75-3f66-4e23-d490-08da2f93a37b
X-MS-TrafficTypeDiagnostic: DM5PR10MB1579:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB15794AE42A2A8F4AFF72F807E2C59@DM5PR10MB1579.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faA73i6R1kN4qjncBji2P9Doe5tAYrrGr2+PO/vwL6h/x5ms7+o/pYjSqp+TkcHtxg08lKWmBgx31QvJoarcpwsvoR5defatCUG24uys1dVhOyguymNQYDIRo0u0eBE5UdrDKbKieuTjqApfJc7JrO35XLiq63Me399X5z6X9AvO8zULL4iE3qsl1g+YZaaw+LBuoE5qgz+0EHE87lzms90ZZHOyM+zAE7uFg6wVnpKrJeBTNSbFpAejj7Rpxn+4u1mdcBXAWGHl6wukr+jNV3DOl9X9THYrOwtgSfjh13iMat3M5Y5Yr7HmvjWS8iX0OJqw4tcxgO2AYqEv0rdxhuQLkbs5rMl7jnrGSEMOzv9csYUgF4wQlj1PsQ9dPBMMx1iRnX07is236AvZKEVQGjfFuRVGKaUdIg1Is6hvkfBubajIoHBrz9iMXOJ6rqgu0Njdff7ubM2TJge6JnrhtsHjPskh4I6toeWF03vE3lZHgoIGuFYDWTxWpCszrc3RgiygBOSzqucvWHW3vxLUgPVcIoLp11JI5UWKCKzr9IXB+9da2dPYkHPBGY+whW2frzfD815y+zGGDLKGxPYrI5g6u7HzJ4MBiCJ3pLxg2/9BEpcH62YYEF122cg7fZ8uJG3J57BSeFKEnj7zeSAHeP70WB6Li4hHJkiEmA4CYRSSqaQtVdojpycH+4oCeXrIXUc+yKp2eJh8//nw6h9mrBIKJLLlp/0YwJzrU8meUe3YVm+XcDfJjwxlzF45YHThOrQr89Y9wOTGxG9br/NT7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(6486002)(53546011)(6506007)(6666004)(52116002)(508600001)(8936002)(7416002)(5660300002)(7406005)(44832011)(86362001)(2906002)(38350700002)(38100700002)(83380400001)(66946007)(26005)(2616005)(6512007)(186003)(66556008)(66476007)(8676002)(110136005)(4326008)(31686004)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djJTcm9VVG9GWk83bTJIeXVZOEoveEM5TlVXMXY0STRSbzRvamdNOWErS1FU?=
 =?utf-8?B?Q0pWUlBtT1dzT1J6aTh6dDNHTEpGRFZLclozcGIzOTJWdUpvTGVZNkw1QTNp?=
 =?utf-8?B?bDRWOTJTYk50Ui9JaEtZcWVjS01wRjc2cDJZcE80VFRaNmlTM2ZrZktGWUow?=
 =?utf-8?B?ckZ2eXltK0RvUFo1aWx0TVFVWmtXL2IwTTYya1M0U0RUSGJVc2Nwb2lXVHp5?=
 =?utf-8?B?aWJIU28vT3FvV1laNjVEOEtZVm12eXpRV2tPcnI3TER5MzM0Sjg0S1pLcVlL?=
 =?utf-8?B?dW1wR0tHY0Z1WFNyUG9TRnR4UG5melZtWFhpaU1RS3BFdUszMWhhRnRJOENV?=
 =?utf-8?B?a0xsNXhpZTd5aW9mK3NDL25UbWlsK1FuaGxjakxub0ovaXoranp5OFF0a2Er?=
 =?utf-8?B?OXhLbWpnbWdlbi9VNCttKzNORUdQSUdjMTRkTmdGMjI5c1BCc3NQZjFGQkZ4?=
 =?utf-8?B?YksxZHcvcGF1OWVyV3MxR24yVDF3TUwwc0lmb2w3b01GbkcvTzk1VEM5dkhV?=
 =?utf-8?B?T1A2a2RZNVhxdE01blpxSlVvT2hTbm1EWDh2SDFmQTNXT0QrZkNCMzJhdDNS?=
 =?utf-8?B?cWVmRDZPTkR6cllHSzJBZlZwZk5wRDJnZ2lVM3RBblVPejBWSjQzWkoxc3dR?=
 =?utf-8?B?MTZrYUVJeGllWngwYk5mb2tXaGdtdjh4S25NK3NFcXpjS2h5QWhCYVFyYVN4?=
 =?utf-8?B?R2Y2ZW1ydjJ5QlI0MXlUSkFVRTdOMklWeHJtQ0ZsWFlVOWxIaGFidlc1NWYx?=
 =?utf-8?B?bklkaXlPMlJDc2xaN2VHSTFYaS9vMTNYbW5FcTZOdC9WZTdnWFFQNG5QYmlU?=
 =?utf-8?B?ZWlRczhsVmRnTjIwUDVJT2hienFOekxqUXhqMUZhZzMySUxxMG11cXg0c29n?=
 =?utf-8?B?N3RvbEdwcmMyUjRyOTg1K2I5QTNaL0lVS1ovSTFDQzFxTlZwUVVBMmJDL0hI?=
 =?utf-8?B?eEw5Vmt3THl4a0ZmYWY5M0xhZURxYXBKdmxta0doQzBGVlJzajc0dWlack8r?=
 =?utf-8?B?VGhzQklJZWtlMmtJZDNsUGFyM2Z6R3B4ZjRxbG9pUytkL3NwdkxQdGZOUEpN?=
 =?utf-8?B?MDZnejR3LzYvUjZZdHBBMDJIazVhR2RoY1pUdXZBUEU1R3IxcXRDMndrZHBq?=
 =?utf-8?B?UDI3dkRYZWdEMU0weGdCb044Z1VIMTBLN1gyNkpmRXRGWSs3NExsZFh3cHdV?=
 =?utf-8?B?WE5WZXVwdG1VeTA4WUlEVlZNVzJaNzRac0RtbnNMRDVnaHEvVU9kVWxtVURN?=
 =?utf-8?B?Z1U3YzVnWGZDeVE2Yy9lZSsxckJSbEU1MFpIV1hGZ1NwdEVMQm81VGRvLzI5?=
 =?utf-8?B?ZmJLUWdYWHhLM3EybDdiSmpwS21DWjdVZUNvRzhxckxVODArblF0VnhHdTA5?=
 =?utf-8?B?VzlOOEFVVUtFZWtUak5FSU5BRFN1UUJmekExSEluVkJIbmdzR045aXdneU54?=
 =?utf-8?B?akFsYm1oQzVhZnpwc0dvN0xQRGUwbUVoQlhhSnk5MGZDaVYyZDQ0VVQ5TXJo?=
 =?utf-8?B?NUpZKyt5d01WWHRNc2UrS1RxclhXWTNyTXEzdGM3RlJsY1J0MUdIaVhReFh1?=
 =?utf-8?B?UjN3Sk9RYnd6cHZFMG5GTm5YOVlacEhFbTB0YnVBWGszQ3RCdmdtUFVXaXdn?=
 =?utf-8?B?ZW5XV2RSUEo0a1VmZWROWFAxWlNHMzl4VFhnemZvSEU2OENmSkZ3ZnY1UnJu?=
 =?utf-8?B?MHYzOXNRcEczUW53LzJUSHlLZ3Y0QmJiV05NaVg4M0pldklKdzRQZmZ5TE1G?=
 =?utf-8?B?OGdGOEpmUVB3UjkzK2hkT0VaUnR3U0RIanQ2SVFjUkRPTysvSUdtZUk2TVFv?=
 =?utf-8?B?VFdCcUd0KzFvMjNMYkFvT3VLK1dDRmpuYTZBbSszejdRVlRKaEw5bXh2dWY3?=
 =?utf-8?B?N2hiQTZqR0ZWbFQ3b1VacWFVUExZWWxwcCtzbUZFSzJsVkcrTGQ2RGxDaTBR?=
 =?utf-8?B?YUN0N1VOd1k5RUlhendyODdwdWxTU0ZZQzdOOElFa1FJT2g5SWZiWmNJcC94?=
 =?utf-8?B?YW94YmJkc2dQTjZoUWYxRXhtcG55NHJYVWVQWFNtdldSSlZvRUprZnhpWjR5?=
 =?utf-8?B?Sm5mMHdQWWRYVGR0UUVDNEEvRjZRQWoxUXg3SGJkT0IyTC9WVmN5TTR0Q1pk?=
 =?utf-8?B?ajllOG5wL09acEVsMm9LMFJ5aTZyVW5KTzVqVkFIbGY1RmtuczFJVi82QzZC?=
 =?utf-8?B?a05hQk9RL3ZmZkVSVU16blgxZEVxWHV1NWltU2gyYVhNbUF3dVlGTlJlaCtG?=
 =?utf-8?B?YTUwL1E5MmFZWS9WVkhTUXl5NTRaWXd3NzhjMERsWlRzVnE3cXJaaUlEN3Vi?=
 =?utf-8?B?anNpdU1mcEI1MEtZNFNQb3grTU4zZ2FIbTFtN1FKMC9IWi8rNnh0cTFENXoy?=
 =?utf-8?Q?iljguG6WzAlagHZY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc15f75-3f66-4e23-d490-08da2f93a37b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 19:07:17.7408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH3aXgfMQrOYITZCsH2wNNp0J6ScYKpNvZgcVsD5yZ2ASCkx72/+Pga2qoXw/iS33rBcS7x/5gHi9Iha+8Rexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1579
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_07:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060096
X-Proofpoint-ORIG-GUID: sQ5aNxh6rg9waKDrB3AHcQ_HRGaVRly2
X-Proofpoint-GUID: sQ5aNxh6rg9waKDrB3AHcQ_HRGaVRly2
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/3/22 03:03, Gerald Schaefer wrote:
> On Tue, 3 May 2022 10:19:46 +0800
> Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>>
>>
>> On 5/2/2022 10:02 PM, Gerald Schaefer wrote:
>>> On Sat, 30 Apr 2022 11:22:33 +0800
>>> Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>>
>>>>
>>>> On 4/30/2022 4:02 AM, Gerald Schaefer wrote:
>>>>> On Fri, 29 Apr 2022 16:14:43 +0800
>>>>> Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>>
>>>>>> On some architectures (like ARM64), it can support CONT-PTE/PMD size
>>>>>> hugetlb, which means it can support not only PMD/PUD size hugetlb:
>>>>>> 2M and 1G, but also CONT-PTE/PMD size: 64K and 32M if a 4K page
>>>>>> size specified.
>>>>>>
>>>>>> When unmapping a hugetlb page, we will get the relevant page table
>>>>>> entry by huge_pte_offset() only once to nuke it. This is correct
>>>>>> for PMD or PUD size hugetlb, since they always contain only one
>>>>>> pmd entry or pud entry in the page table.
>>>>>>
>>>>>> However this is incorrect for CONT-PTE and CONT-PMD size hugetlb,
>>>>>> since they can contain several continuous pte or pmd entry with
>>>>>> same page table attributes, so we will nuke only one pte or pmd
>>>>>> entry for this CONT-PTE/PMD size hugetlb page.
>>>>>>
>>>>>> And now we only use try_to_unmap() to unmap a poisoned hugetlb page,
>>>>>> which means now we will unmap only one pte entry for a CONT-PTE or
>>>>>> CONT-PMD size poisoned hugetlb page, and we can still access other
>>>>>> subpages of a CONT-PTE or CONT-PMD size poisoned hugetlb page,
>>>>>> which will cause serious issues possibly.
>>>>>>
>>>>>> So we should change to use huge_ptep_clear_flush() to nuke the
>>>>>> hugetlb page table to fix this issue, which already considered
>>>>>> CONT-PTE and CONT-PMD size hugetlb.
>>>>>>
>>>>>> Note we've already used set_huge_swap_pte_at() to set a poisoned
>>>>>> swap entry for a poisoned hugetlb page.
>>>>>>
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> ---
>>>>>>    mm/rmap.c | 34 +++++++++++++++++-----------------
>>>>>>    1 file changed, 17 insertions(+), 17 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>> index 7cf2408..1e168d7 100644
>>>>>> --- a/mm/rmap.c
>>>>>> +++ b/mm/rmap.c
>>>>>> @@ -1564,28 +1564,28 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>>>    					break;
>>>>>>    				}
>>>>>>    			}
>>>>>> +			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>>>>>
>>>>> Unlike in your patch 2/3, I do not see that this (huge) pteval would later
>>>>> be used again with set_huge_pte_at() instead of set_pte_at(). Not sure if
>>>>> this (huge) pteval could end up at a set_pte_at() later, but if yes, then
>>>>> this would be broken on s390, and you'd need to use set_huge_pte_at()
>>>>> instead of set_pte_at() like in your patch 2/3.
>>>>
>>>> IIUC, As I said in the commit message, we will only unmap a poisoned
>>>> hugetlb page by try_to_unmap(), and the poisoned hugetlb page will be
>>>> remapped with a poisoned entry by set_huge_swap_pte_at() in
>>>> try_to_unmap_one(). So I think no need change to use set_huge_pte_at()
>>>> instead of set_pte_at() for other cases, since the hugetlb page will not
>>>> hit other cases.
>>>>
>>>> if (PageHWPoison(subpage) && !(flags & TTU_IGNORE_HWPOISON)) {
>>>> 	pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>>>> 	if (folio_test_hugetlb(folio)) {
>>>> 		hugetlb_count_sub(folio_nr_pages(folio), mm);
>>>> 		set_huge_swap_pte_at(mm, address, pvmw.pte, pteval,
>>>> 				     vma_mmu_pagesize(vma));
>>>> 	} else {
>>>> 		dec_mm_counter(mm, mm_counter(&folio->page));
>>>> 		set_pte_at(mm, address, pvmw.pte, pteval);
>>>> 	}
>>>>
>>>> }
>>>
>>> OK, but wouldn't the pteval be overwritten here with
>>> pteval = swp_entry_to_pte(make_hwpoison_entry(subpage))?
>>> IOW, what sense does it make to save the returned pteval from
>>> huge_ptep_clear_flush(), when it is never being used anywhere?
>>
>> Please see previous code, we'll use the original pte value to check if 
>> it is uffd-wp armed, and if need to mark it dirty though the hugetlbfs 
>> is set noop_dirty_folio().
>>
>> pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
> 
> Uh, ok, that wouldn't work on s390, but we also don't have
> CONFIG_PTE_MARKER_UFFD_WP / HAVE_ARCH_USERFAULTFD_WP set, so
> I guess we will be fine (for now).
> 
> Still, I find it a bit unsettling that pte_install_uffd_wp_if_needed()
> would work on a potential hugetlb *pte, directly de-referencing it
> instead of using huge_ptep_get().
> 
> The !pte_none(*pte) check at the beginning would be broken in the
> hugetlb case for s390 (not sure about other archs, but I think s390
> might be the only exception strictly requiring huge_ptep_get()
> for de-referencing hugetlb *pte pointers).
> 

Adding Peter Wu mostly for above as he is working uffd_wp.

>>
>> /* Set the dirty flag on the folio now the pte is gone. */
>> if (pte_dirty(pteval))
>> 	folio_mark_dirty(folio);
> 
> Ok, that should work fine, huge_ptep_clear_flush() will return
> a pteval properly de-referenced and converted with huge_ptep_get(),
> and that would contain the hugetlb pmd/pud dirty information.
> 


-- 
Mike Kravetz
