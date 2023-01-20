Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1167598C
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 17:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjATQJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 11:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjATQJX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 11:09:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D37ED57;
        Fri, 20 Jan 2023 08:09:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KFwauv016502;
        Fri, 20 Jan 2023 16:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1/RcqmTTcvKPo+jo+dju19PoqI3xF3RyBUh2LCZeCzE=;
 b=qmtlxBI/XDZc6c6B0SoFPuj89esgHy57YvhcO+xdM1zTAdRU2agw12GhO2tdGzZKuP86
 TOacnJfktbVt3TmdZ0AaKY8mMlz5+nOIrwWSoq+Yztp6aSRU/eH+dLOWWAQGBUei3Ot9
 5OQK46l4Z8CLUDN+G3r4jc1x5zyBtSqsxcNMgp0Wc/kz+4LyXwnz6ymzB8twPAfTrM/L
 Tna4qbJlfmV83w9wRAf2LP27ksesPdXDanZM35FPYbPOFoFeS6cN1799de7K57HU8Bj+
 umW82DdYB1I83ob0ewEWG4DUpIR3bZhH0LPXpO/sbLgYRhLPELNXtPDvTw9f0snyoF9c rQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n7895ap3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:08:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30KFQDdG000845;
        Fri, 20 Jan 2023 16:08:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n74d2rucu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Jan 2023 16:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB5/fPFI9clQ1DHi4v29mfU0lBo6BCKBOb+3YgA11zlU7JzSPqrxLhT/VnR2A5w65fjk5/g5pyQ9lKG7UDXgZyqm7CIvTw5YtzhmxDfRexb2ESeNlCDCEuMZDC6kptwXeRv0yl08nZHah3K0xPg7QfhY6C1Q2ALD2Zwq90fVWHcDvqKWVZ+HfWkIW1KfQOaQ7hrKIKPT3C5XKJzw1rMSNJOYDQMnThjk/xjsHbt1TRkkntfyF0sKjiRDgDtbcHKVGClHMNC9UfGL+lMZe4JufuqJ8tkFHee1PMIxIAPioTMHtm6un0UvU3zsun6db63RtHMeKc+SyirHKE+HoujkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/RcqmTTcvKPo+jo+dju19PoqI3xF3RyBUh2LCZeCzE=;
 b=U5nbuvyJGhdYwVbDEzU8MaQcAwu8uIPsezYMCSHQ4MPc1u07eWLeH1WxkZdada5X+xv79yiuY294Ot0E4J5kf70+3eS8Vkf7tjXggEXcA+kdfTp7qYi66IYykgBnoYty7aOXdDF93cefa2ghtag2x3n+vVh1LvP2NjQ0XnjAJse+abSM6zbAQvczLot7H6zWhSXVfESGGCoNbNpsjcDVvzFzNlwQ9+45g0oPdF73f6Xi7t6Kq7tU2qUu9UdOquz4Mn2fvNf2IgZ9hGP35KR72ztTpLJzt//aoK/w0bixXhfHtF2FXk6tmVwaWjQyr1s3+ENwbVFglsU5jb0kburK4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/RcqmTTcvKPo+jo+dju19PoqI3xF3RyBUh2LCZeCzE=;
 b=Jm1Fq9AX5HZDNIE1vAiRidY47XbuqWdVcmbZCKkYva0LgUt5Itw61sXhZ684kuTXbmN87m4zZ952AA+kZJfOxyvlhis619APVB4TyRvxhzsMo/ZXof1cHI1iSFQlVmCgm+t4n6v5wg3cmBRLhUffjs86yf+poR12tdDTqZncxPg=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.6; Fri, 20 Jan
 2023 16:08:35 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::9f6f:c50b:3f5:7492]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::9f6f:c50b:3f5:7492%5]) with mapi id 15.20.6043.006; Fri, 20 Jan 2023
 16:08:35 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org, djwong@kernel.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, 21cnbao@gmail.com,
        arnd@arndb.de, ebiederm@xmission.com, elver@google.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com
Subject: [RFC RESEND PATCH 2/2] mm/ptshare: Create a new mm for shared pagetables and add basic page table sharing support
Date:   Fri, 20 Jan 2023 09:08:18 -0700
Message-Id: <9b2679745f94c6bac875abb61e5093d462626a1f.1670287696.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1670287695.git.khalid.aziz@oracle.com>
References: <cover.1670287695.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:91::27) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DS7PR10MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: b93ac789-550c-44ae-eb8e-08dafb00956e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WgVPMmb7ND1lGu2g+1qiALmPpY2AcUq5gjWXFnStDUrlaUB8+6ugL/hVMduTHz+TDfzWIlguSWlekcbmfqg6U0wOxCRou2r8ABLoY7HFdYOHi3haz2ES4homOzfIJ8duSKW4pUsCC5QmPmD6K/Mo1DhSGtON9AaLGV6UPICuD7uzOWLR3KQLjSNVN9AciCvouX356zbQ9FrFrIEofh7X1B9sU0gRf/oohNeZfnbiQv9auqB30P1JT+1ZegGuXX7x0nYrXu1ye629YZhxAUiliXZ8AxF2+TWT8FJi+ev7yQg8fCF8MfEM7I0wQKfj3Yj/FypAKY15JdQMpw2MgZKU8lzGHlRWcw2ttYY4soICL5FZlBroNR61HVtOC5SlUAkCIXLJnlB+SZuLaXcTpiUlcsN3TZxgffGFX57t+gVxvQBu4QJb4N/d1C7eCP9UhcULaAzu270+29ClfLRaTF3NXejittKiGSrenHlS5dsmvJ+TAG7GlAm8vD+c8ECfG6E5OwPf5GV1+xG9+kc7VV6J35BwZUi4waWutq4zpEojxNaE4SOaMLGFUPa6lxghUoG3W6W162uCagFLknp4d3XEBCl9QghijAiFQxP8p5HksLlMSbkuMmBCUJBqHWQWSiwTogUgkFwq3f32EHFs5lmvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(6506007)(478600001)(6636002)(6486002)(6666004)(4326008)(66556008)(8676002)(66476007)(316002)(66946007)(186003)(26005)(6512007)(8936002)(7416002)(36756003)(2616005)(41300700001)(30864003)(5660300002)(44832011)(83380400001)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X9uLeK9g5iynlutZRbP0KY7xfeM0OxBNJuzkwu6hGy0HMXsIgIYfBfc8FHG+?=
 =?us-ascii?Q?7c8gHCWiLHo9sf6wBM6xKMcf2yuoEanqQsqRDERRo6c7ZXk/QW4X1Bsbm6Ej?=
 =?us-ascii?Q?inhuS1UbRiYY/c+j1Mf+9Mq43H2ENlrkqiKW4aqFyo3W1w+SXNAYt5uArEj9?=
 =?us-ascii?Q?8RykkBa86wJNiO8GxE25ijh/29WCyd8C6p3hvuZGtQvFAw/UJa6OJ+R8Ihy6?=
 =?us-ascii?Q?H+FZpTni99Nv56VipZqPSWKSYv30On1F8Upv3/c6MVFqFC/ABUMGZT+aZXTv?=
 =?us-ascii?Q?cvxqgDtExAyL3pY5LvQw39GVx0wmfuDunSmanI5Gqs/fL7cOa6dX6Ai+pOBb?=
 =?us-ascii?Q?De4fZaOWJ5cQHWcSAmhUP5eh2yEj+BPd5xvOi5XEzXlUIN8YRkdrT4SN0JjD?=
 =?us-ascii?Q?p1B7LHMkc8ea25q0UzfICmMf5IG8KpPU3iSbMcvd5g5baT11GKPjq8eYHDT7?=
 =?us-ascii?Q?1gnTbKk1VWMaJjK1ZNvsaoaL2s1eQg3BjWkeChy8Y4+H1Ytp/WXyL2HLt1gc?=
 =?us-ascii?Q?4RWOgRhFGjee7pOcqBAhq5RaITuzmc7FSnr1ICIBNWsnD7csYSL7opI0zm+B?=
 =?us-ascii?Q?yq61XI4oPdmhrEdwcOI+KVt+QX6H1ZKI2T0VjrQuF4gtPkubSPzxyyE9nscK?=
 =?us-ascii?Q?jehBibtwWcglJkkHHTbj/0/zMdGAAe++bAYI6MCo5GnVL4f+xp+QqMznYWP1?=
 =?us-ascii?Q?OnMnvePAzS/z/SoHDHnPVJaNrfOkIsIuz1lM/+vFFw00cBOTuBP9iTuA2Bsa?=
 =?us-ascii?Q?la9oiPksqqiBsObHxwXxbmyqdZSDKiaRieanAWcshz+q3IRvB0HJ7w3tQBL5?=
 =?us-ascii?Q?XJReM35UGfhtd2ZLyp9oUhOawVJADdP1uwFwcPJzf6R3RvWjSspiyAhDNQ/w?=
 =?us-ascii?Q?rzzrkGMpAlDnEtuV2GSSnGLWdmPUVaRNjlwGnA6xfuIEAawlfkwTvkX+dMRd?=
 =?us-ascii?Q?1eQphs83oV/4mjTznATJ00ADK6ahTaPtm2KbxaTyZRbDK+ogBADr1bwnljO4?=
 =?us-ascii?Q?nBTyNkOXUZJo9BFyp2J9JJfo1IYm5fFZVPerY5WQZ9MEUAZXGsMeqZ7xRks7?=
 =?us-ascii?Q?kRSibf2ED2BRd4beH4XPDtIZLxQvzAk29aInboxblqJBTbzT/0jMiJwXm3wx?=
 =?us-ascii?Q?On+XdtT3l6gE5l8+mx7z9nEBGUHnMxgKZ6V1m6C8o51e9rnZ+nf+Hbr49Uqn?=
 =?us-ascii?Q?um2rDOTb0Vw8xXSAVvcWO07Pq0CNlrsy5K7AWxj8+tc4YmoDF6YUvDR6SLEK?=
 =?us-ascii?Q?iUO8yOYD9gdxyBnSKqbjBtRGHfu4dxwHjszKYzKVZdV0ltv+rkAyPbTny6qF?=
 =?us-ascii?Q?iP/l17pByonWygEL1ZuQhdXEpz4ZlxAUFvQRXwTDcYFLJliLBf5OYn/P8uWr?=
 =?us-ascii?Q?5CMmhg+sZghAS6tu5id/pZ2ZeQ69k1Flhu7QRbs9W9Y55p73SLXGu4O3Eme9?=
 =?us-ascii?Q?ok/2g3I/6ZUDpb5spEJPtysn9m+tpMiwubgcTvYI8Qq2AptulDqK6bUBycIe?=
 =?us-ascii?Q?FdtQgS8Yi9jKKNxG7oNrUuPGmFGTs3vTlwpn+OrUTMrsievUs6JIprh2R22q?=
 =?us-ascii?Q?su64CCFZyGDA+r5lcT1XEyf4GWIqt+xDTZgHDa3UfM+ahMozYlWb8SGodjCX?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hD6L1jyjp6N3uhNWeiheCFY9A2CbIOavBzTYV4xzmz8aDff9nBW1JPIEtBzs?=
 =?us-ascii?Q?ZtUtR8xXxAQPsjtvNvV7tWQOBzudNUE/DwwzDWfQhMaocLL5Yy7l0IzSqqMP?=
 =?us-ascii?Q?D7UXyHtsRR5YgqHE8VNOFWXiFyuZ+ENylr8sYJA6ffWKhmVqxuKSkm4UXVV/?=
 =?us-ascii?Q?WI15LcoNpDTFMg8Xd129TtI+XJONMT3hUvZBuNNm3uZwtpOkb91aVzNnuXu9?=
 =?us-ascii?Q?ta8JNFx2IuW7jBkQbVuIO/mfOC+9bkn7TsxoR5S015gKutoqmxh3kUKS3hE6?=
 =?us-ascii?Q?zlQlrgJnvXtU5kz9wSdatOPAAtY//h4avdUuC7bNas2cEqsGT9N7Vo8a4WXn?=
 =?us-ascii?Q?KdAI+jcaaX0G222/tvNRyfoHcN9ujCiJBL5FxAsNhNDVxV4Ov8uIfVyAE+kY?=
 =?us-ascii?Q?3N8s5XBgH2M92VKn/XBHPzxAUDwFGkVW8/LmA6NxtGGTMHMQnBkP9xnLtSZ+?=
 =?us-ascii?Q?+K4M3tLdQGcO+3ypMLy9l406eR2Kbv3I1kGdAlys5K3HEFEpFUk7rHB30QyX?=
 =?us-ascii?Q?4aOA87lXttkQGdH30Ip7gFGgOdCgdPx3324R77oLvJ51Odhv0Dm94pmlNUhf?=
 =?us-ascii?Q?AmfuUyWnMLwy7oJDGvITbC6UbAW4XNoB5pPugfe6qCAyJPKoElajvDzyBLxM?=
 =?us-ascii?Q?ptOaloC/AmKHVS94cB26kGmjh6hID65bBsDFiFs2ErcX1JuN1czWhcDCBWhK?=
 =?us-ascii?Q?LiFX/FN6to+WDH/Lw2N4VW+BlbugVl9fZb269Zb+MFHHWedK0rOunDGJQwIo?=
 =?us-ascii?Q?cPmptuIzh3gSaIMJpjSDPIVCIj1wAGKnMnu3QHKYQle15NwDek9xp0NgIp1J?=
 =?us-ascii?Q?erMFBkaEAaRfP0TbHHe26wW1g9vMw7E6p5dvgENDHRujLj3EM+EIgDSvdOGA?=
 =?us-ascii?Q?wgJSxexFx4OneyHWkykqOy6DIfT34BgrAW+FKrAOOCWNhX8wHqAQ44ViWDav?=
 =?us-ascii?Q?1Ou2JW5yRbKDLa0zMrPZS2MnWkX2zSCdtzmlN5fQpgR0gmxlQyC99dUXI0VI?=
 =?us-ascii?Q?xdA75NGQCKU3s0vzx3D65iEDYNDlnjbg4Hznfb3TSAYi30wgcktxXuBtacWr?=
 =?us-ascii?Q?X+gNSvjsgmCkZrWrbyy49XCKRKZXvPnY2+fTEU3QF4D4nQICqbt1SzWRlBe0?=
 =?us-ascii?Q?l3z4A/MUemrLoX4taa3goKv1h9hzek5DGJCVqKh6qYaWCZT+ByXTq0TA9Dk4?=
 =?us-ascii?Q?IwUM+aM52XkYpsfGDzpxtnXt8biQy0PwTPSAicwa0+0cGiNadmDK/8fVnylk?=
 =?us-ascii?Q?PM9IgJ1sifRIA6YMBVVoB5iNFTkx0zcVi+tflNBb0A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93ac789-550c-44ae-eb8e-08dafb00956e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 16:08:35.6680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9w/5tOTLVNEE1hH1/D4HY1mbv9wAEaSSXH1oNStWwP4qkV0vYEWW1lOighKOrMQtXs5TrAwL3pX6NYmr0KdMag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_09,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301200154
X-Proofpoint-ORIG-GUID: DreXxmzakgoOY2u74R48Hrhpi3US7JFj
X-Proofpoint-GUID: DreXxmzakgoOY2u74R48Hrhpi3US7JFj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a process mmaps a file with MAP_SHARED flag, it is possible
that any other processes mmaping the same file with MAP_SHARED
flag with same permissions could share the page table entries as
well instead of creating duplicate entries. This patch introduces a
new flag MAP_SHARED_PT which a process can use to hint that it can
share page atbes with other processes using the same mapping. It
creates a new mm struct to hold the shareable page table entries for
the newly mapped region.  This new mm is not associated with a task.
Its lifetime is until the last shared mapping is deleted.  It adds a
new pointer "ptshare_data" to struct address_space which points to
the data structure that will contain pointer to this newly created
mm.

Add support for creating a new set of shared page tables in a new
mm_struct upon mmap of an region that can potentially share page
tables. Add page fault handling for this now shared region. Modify
free_pgtables path to make sure page tables in the shared regions
are kept intact when a process using page table region exits and
there are other mappers for the shared region. Clean up mm_struct
holding shared page tables when the last process sharing the region
exits.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/fs.h                     |   1 +
 include/uapi/asm-generic/mman-common.h |   1 +
 mm/Makefile                            |   2 +-
 mm/internal.h                          |  16 ++
 mm/memory.c                            |  52 ++++-
 mm/mmap.c                              |  87 ++++++++
 mm/ptshare.c                           | 262 +++++++++++++++++++++++++
 7 files changed, 418 insertions(+), 3 deletions(-)
 create mode 100644 mm/ptshare.c

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 59ae95ddb679..f940bf03303b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -441,6 +441,7 @@ struct address_space {
 	spinlock_t		private_lock;
 	struct list_head	private_list;
 	void			*private_data;
+	void			*ptshare_data;
 } __attribute__((aligned(sizeof(long)))) __randomize_layout;
 	/*
 	 * On most architectures that alignment is already the case; but
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..4d23456b5915 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -29,6 +29,7 @@
 #define MAP_HUGETLB		0x040000	/* create a huge page mapping */
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+#define MAP_SHARED_PT		0x200000	/* Shared page table mappings */
 
 #define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5b3e29..d9bb14fdf220 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -40,7 +40,7 @@ mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= highmem.o memory.o mincore.o \
 			   mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
 			   msync.o page_vma_mapped.o pagewalk.o \
-			   pgtable-generic.o rmap.o vmalloc.o
+			   pgtable-generic.o rmap.o vmalloc.o ptshare.o
 
 
 ifdef CONFIG_CROSS_MEMORY_ATTACH
diff --git a/mm/internal.h b/mm/internal.h
index 16083eca720e..22cae2ff97fa 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -861,4 +861,20 @@ static inline bool vma_is_shared(const struct vm_area_struct *vma)
 	return vma->vm_flags & VM_SHARED_PT;
 }
 
+/*
+ * mm/ptshare.c
+ */
+struct mshare_data {
+	struct mm_struct *mm;
+	refcount_t refcnt;
+	unsigned long start;
+	unsigned long size;
+	unsigned long mode;
+};
+int ptshare_new_mm(struct file *file, struct vm_area_struct *vma);
+void ptshare_del_mm(struct vm_area_struct *vm);
+int ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma);
+extern vm_fault_t find_shared_vma(struct vm_area_struct **vmap,
+				unsigned long *addrp, unsigned int flags);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 8a6d5c823f91..051c82e13627 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -416,15 +416,21 @@ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
 		unlink_anon_vmas(vma);
 		unlink_file_vma(vma);
 
+		/*
+		 * If vma is sharing page tables through a host mm, do not
+		 * free page tables for it. Those page tables wil be freed
+		 * when host mm is released.
+		 */
 		if (is_vm_hugetlb_page(vma)) {
 			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
-		} else {
+		} else if (!vma_is_shared(vma)) {
 			/*
 			 * Optimization: gather nearby vmas into one call down
 			 */
 			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
-			       && !is_vm_hugetlb_page(next)) {
+			       && !is_vm_hugetlb_page(next)
+			       && !vma_is_shared(next)) {
 				vma = next;
 				next = mas_find(&mas, ceiling - 1);
 				unlink_anon_vmas(vma);
@@ -5189,6 +5195,8 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
 {
 	vm_fault_t ret;
+	bool shared = false;
+	struct mm_struct *orig_mm;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -5198,6 +5206,16 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 	/* do counter updates before entering really critical section. */
 	check_sync_rss_stat(current);
 
+	orig_mm = vma->vm_mm;
+	if (unlikely(vma_is_shared(vma))) {
+		ret = find_shared_vma(&vma, &address, flags);
+		if (ret)
+			return ret;
+		if (!vma)
+			return VM_FAULT_SIGSEGV;
+		shared = true;
+	}
+
 	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
 					    flags & FAULT_FLAG_INSTRUCTION,
 					    flags & FAULT_FLAG_REMOTE))
@@ -5219,6 +5237,36 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 
 	lru_gen_exit_fault();
 
+	/*
+	 * Release the read lock on shared VMA's parent mm unless
+	 * __handle_mm_fault released the lock already.
+	 * __handle_mm_fault sets VM_FAULT_RETRY in return value if
+	 * it released mmap lock. If lock was released, that implies
+	 * the lock would have been released on task's original mm if
+	 * this were not a shared PTE vma. To keep lock state consistent,
+	 * make sure to release the lock on task's original mm
+	 */
+	if (shared) {
+		int release_mmlock = 1;
+
+		if (!(ret & VM_FAULT_RETRY)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
+			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
+			mmap_read_unlock(vma->vm_mm);
+			release_mmlock = 0;
+		}
+
+		/*
+		 * Reset guest vma pointers that were set up in
+		 * find_shared_vma() to process this fault.
+		 */
+		vma->vm_mm = orig_mm;
+		if (release_mmlock)
+			mmap_read_unlock(orig_mm);
+	}
+
 	if (flags & FAULT_FLAG_USER) {
 		mem_cgroup_exit_user_fault();
 		/*
diff --git a/mm/mmap.c b/mm/mmap.c
index 74a84eb33b90..c1adb9d52f5d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1245,6 +1245,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	vm_flags_t vm_flags;
 	int pkey = 0;
+	int ptshare = 0;
 
 	validate_mm(mm);
 	*populate = 0;
@@ -1282,6 +1283,21 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
+	/*
+	 * If MAP_SHARED_PT is set, MAP_SHARED or MAP_SHARED_VALIDATE must
+	 * be set as well
+	 */
+	if (flags & MAP_SHARED_PT) {
+#if VM_SHARED_PT
+		if (flags & (MAP_SHARED | MAP_SHARED_VALIDATE))
+			ptshare = 1;
+		else
+			return -EINVAL;
+#else
+		return -EINVAL;
+#endif
+	}
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
@@ -1414,6 +1430,60 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	    ((vm_flags & VM_LOCKED) ||
 	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
 		*populate = len;
+
+#if VM_SHARED_PT
+	/*
+	 * Check if this mapping is a candidate for page table sharing
+	 * at PMD level. It is if following conditions hold:
+	 *	- It is not anonymous mapping
+	 *	- It is not hugetlbfs mapping (for now)
+	 *	- flags conatins MAP_SHARED or MAP_SHARED_VALIDATE and
+	 *	  MAP_SHARED_PT
+	 *	- Start address is aligned to PMD size
+	 *	- Mapping size is a multiple of PMD size
+	 */
+	if (ptshare && file && !is_file_hugepages(file)) {
+		struct vm_area_struct *vma;
+
+		vma = find_vma(mm, addr);
+		if (!((vma->vm_start | vma->vm_end) & (PMD_SIZE - 1))) {
+			struct mshare_data *info = file->f_mapping->ptshare_data;
+
+			/*
+			 * If this mapping has not been set up for page table
+			 * sharing yet, do so by creating a new mm to hold the
+			 * shared page tables for this mapping
+			 */
+			if (info == NULL) {
+				int ret;
+
+				ret = ptshare_new_mm(file, vma);
+				if (ret < 0)
+					return ret;
+				info = file->f_mapping->ptshare_data;
+				ret = ptshare_insert_vma(info->mm, vma);
+				if (ret < 0)
+					addr = ret;
+				else
+					vma->vm_flags |= VM_SHARED_PT;
+			} else {
+				/*
+				 * Page tables will be shared only if the
+				 * file is mapped in with the same permissions
+				 * across all mappers with same starting
+				 * address and size
+				 */
+				if (((prot & info->mode) == info->mode) &&
+					(addr == info->start) &&
+					(len == info->size)) {
+					vma->vm_flags |= VM_SHARED_PT;
+					refcount_inc(&info->refcnt);
+				}
+			}
+		}
+	}
+#endif
+
 	return addr;
 }
 
@@ -2491,6 +2561,21 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
+	/*
+	 * Check if this vma uses shared page tables
+	 */
+	vma = find_vma_intersection(mm, start, end);
+	if (vma && unlikely(vma_is_shared(vma))) {
+		struct mshare_data *info = NULL;
+
+		if (vma->vm_file && vma->vm_file->f_mapping)
+			info = vma->vm_file->f_mapping->ptshare_data;
+		/* Don't allow partial munmaps */
+		if (info && ((start != info->start) || (len != info->size)))
+			return -EINVAL;
+		ptshare_del_mm(vma);
+	}
+
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
@@ -2660,6 +2745,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			}
 		}
 
+		if (vm_flags & VM_SHARED_PT)
+			vma->vm_flags |= VM_SHARED_PT;
 		vm_flags = vma->vm_flags;
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
diff --git a/mm/ptshare.c b/mm/ptshare.c
new file mode 100644
index 000000000000..97322f822233
--- /dev/null
+++ b/mm/ptshare.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Share page table entries when possible to reduce the amount of extra
+ * memory consumed by page tables
+ *
+ * Copyright (C) 2022 Oracle Corp. All rights reserved.
+ * Authors:	Khalid Aziz <khalid.aziz@oracle.com>
+ *		Matthew Wilcox <willy@infradead.org>
+ */
+
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <asm/pgalloc.h>
+#include "internal.h"
+
+/*
+ */
+static pmd_t
+*get_pmd(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd))
+		return NULL;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d)) {
+		p4d = p4d_alloc(mm, pgd, addr);
+		if (!p4d)
+			return NULL;
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		pud = pud_alloc(mm, p4d, addr);
+		if (!pud)
+			return NULL;
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd)) {
+		pmd = pmd_alloc(mm, pud, addr);
+		if (!pmd)
+			return NULL;
+	}
+
+	return pmd;
+}
+
+/*
+ * Find the shared pmd entries in host mm struct and install them into
+ * guest page tables.
+ */
+static int
+ptshare_copy_pmd(struct mm_struct *host_mm, struct mm_struct *guest_mm,
+			struct vm_area_struct *vma, unsigned long addr)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *host_pmd;
+	spinlock_t *host_ptl, *guest_ptl;
+
+	pgd = pgd_offset(guest_mm, addr);
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d)) {
+		p4d = p4d_alloc(guest_mm, pgd, addr);
+		if (!p4d)
+			return 1;
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		host_pmd = get_pmd(host_mm, addr);
+		if (!host_pmd)
+			return 1;
+
+		get_page(virt_to_page(host_pmd));
+		host_ptl = pmd_lockptr(host_mm, host_pmd);
+		guest_ptl = pud_lockptr(guest_mm, pud);
+		spin_lock(host_ptl);
+		spin_lock(guest_ptl);
+		pud_populate(guest_mm, pud,
+			(pmd_t *)((unsigned long)host_pmd & PAGE_MASK));
+		put_page(virt_to_page(host_pmd));
+		spin_unlock(guest_ptl);
+		spin_unlock(host_ptl);
+	}
+
+	return 0;
+}
+
+/*
+ * Find the shared page tables in hosting mm struct and install those in
+ * the guest mm struct
+ */
+vm_fault_t
+find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp,
+			unsigned int flags)
+{
+	struct mshare_data *info;
+	struct mm_struct *host_mm;
+	struct vm_area_struct *host_vma, *guest_vma = *vmap;
+	unsigned long host_addr;
+	pmd_t *guest_pmd, *host_pmd;
+
+	if ((!guest_vma->vm_file) || (!guest_vma->vm_file->f_mapping))
+		return 0;
+	info = guest_vma->vm_file->f_mapping->ptshare_data;
+	if (!info) {
+		pr_warn("VM_SHARED_PT vma with NULL ptshare_data");
+		dump_stack_print_info(KERN_WARNING);
+		return 0;
+	}
+	host_mm = info->mm;
+
+	mmap_read_lock(host_mm);
+	host_addr = *addrp - guest_vma->vm_start + host_mm->mmap_base;
+	host_pmd = get_pmd(host_mm, host_addr);
+	guest_pmd = get_pmd(guest_vma->vm_mm, *addrp);
+	if (!pmd_same(*guest_pmd, *host_pmd)) {
+		set_pmd(guest_pmd, *host_pmd);
+		mmap_read_unlock(host_mm);
+		return VM_FAULT_NOPAGE;
+	}
+
+	*addrp = host_addr;
+	host_vma = find_vma(host_mm, host_addr);
+	if (!host_vma)
+		return VM_FAULT_SIGSEGV;
+
+	/*
+	 * Point vm_mm for the faulting vma to the mm struct holding shared
+	 * page tables so the fault handling will happen in the right
+	 * shared context
+	 */
+	guest_vma->vm_mm = host_mm;
+
+	return 0;
+}
+
+/*
+ * Create a new mm struct that will hold the shared PTEs. Pointer to
+ * this new mm is stored in the data structure mshare_data which also
+ * includes a refcount for any current references to PTEs in this new
+ * mm. This refcount is used to determine when the mm struct for shared
+ * PTEs can be deleted.
+ */
+int
+ptshare_new_mm(struct file *file, struct vm_area_struct *vma)
+{
+	struct mm_struct *new_mm;
+	struct mshare_data *info = NULL;
+	int retval = 0;
+	unsigned long start = vma->vm_start;
+	unsigned long len = vma->vm_end - vma->vm_start;
+
+	new_mm = mm_alloc();
+	if (!new_mm) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+	new_mm->mmap_base = start;
+	new_mm->task_size = len;
+	if (!new_mm->task_size)
+		new_mm->task_size--;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		retval = -ENOMEM;
+		goto err_free;
+	}
+	info->mm = new_mm;
+	info->start = start;
+	info->size = len;
+	refcount_set(&info->refcnt, 1);
+	file->f_mapping->ptshare_data = info;
+
+	return retval;
+
+err_free:
+	if (new_mm)
+		mmput(new_mm);
+	kfree(info);
+	return retval;
+}
+
+/*
+ * insert vma into mm holding shared page tables
+ */
+int
+ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	struct vm_area_struct *new_vma;
+	int err = 0;
+
+	new_vma = vm_area_dup(vma);
+	if (!new_vma)
+		return -ENOMEM;
+
+	new_vma->vm_file = NULL;
+	/*
+	 * This new vma belongs to host mm, so clear the VM_SHARED_PT
+	 * flag on this so we know this is the host vma when we clean
+	 * up page tables. Do not use THP for page table shared regions
+	 */
+	new_vma->vm_flags &= ~(VM_SHARED | VM_SHARED_PT);
+	new_vma->vm_flags |= VM_NOHUGEPAGE;
+	new_vma->vm_mm = mm;
+
+	err = insert_vm_struct(mm, new_vma);
+	if (err)
+		return -ENOMEM;
+
+	/*
+	 * Copy the PMD entries from host mm to guest so they use the
+	 * same PTEs
+	 */
+	err = ptshare_copy_pmd(mm, vma->vm_mm, vma, vma->vm_start);
+
+	return err;
+}
+
+/*
+ * Free the mm struct created to hold shared PTEs and associated data
+ * structures
+ */
+static inline void
+free_ptshare_mm(struct mshare_data *info)
+{
+	mmput(info->mm);
+	kfree(info);
+}
+
+/*
+ * This function is called when a reference to the shared PTEs in mm
+ * struct is dropped. It updates refcount and checks to see if last
+ * reference to the mm struct holding shared PTEs has been dropped. If
+ * so, it cleans up the mm struct and associated data structures
+ */
+void
+ptshare_del_mm(struct vm_area_struct *vma)
+{
+	struct mshare_data *info;
+	struct file *file = vma->vm_file;
+
+	if (!file || (!file->f_mapping))
+		return;
+	info = file->f_mapping->ptshare_data;
+	WARN_ON(!info);
+	if (!info)
+		return;
+
+	if (refcount_dec_and_test(&info->refcnt)) {
+		free_ptshare_mm(info);
+		file->f_mapping->ptshare_data = NULL;
+	}
+}
-- 
2.34.1

