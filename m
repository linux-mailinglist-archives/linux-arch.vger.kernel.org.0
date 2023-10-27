Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED667D9EBE
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 19:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjJ0RTP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjJ0RTO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 13:19:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E08129;
        Fri, 27 Oct 2023 10:19:10 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUreu003813;
        Fri, 27 Oct 2023 17:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=rA2rGLHbFJOSYUgJ8+nsrg6UbCDy/8ZhVlI0Ro2eF9U=;
 b=BphQhp/36947BmcJBxDAn4+fNgtLGBAREc5gjPrIBaaRybwoGZu+m3e9Qnva9fuK/FrY
 RcX7zP/nmwraHMOxf5ORRv0Nyngo5YwGgKm3D94U/BDTWfSBaftNiVZ/hbfx7NhzHU7W
 aaMdB4QuhkC062Zm3ewdeTjecJIvTr8d8mdKznACeppVUAL/rJXYPftxSuSS7sw7l3DV
 ThtXlDzB4vzw0usdjZKDpIzEdAUsM+8+XIMj5RPB7wYh4I3E5I9xp+Xzadx4PCyIZ2Ch
 +BtMuFAu68wNKsW9KzQ6vBTMr/Ki4SXL/ohZ6qusysieXUsjRHj9WULebOmPY62BIBlx eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtba35g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 17:18:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RFex0C022925;
        Fri, 27 Oct 2023 17:18:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjr8t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 17:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDNfu50g66QucBwOc8HraYDbUfhPGQGmkUN+lz/kG6+bk7JiPb/sQttAN2stHxGLGrL+wauEdYdpx7jkwaHcFON/I9OiQU7SXvjZjlnOAf/0CaYubEmrqCvGQXDmqvpPCY4QBq1Pv2zrUObOCWNrRmk/N9KNqeKHsE+X1tfJNiMYCvHuHQ5qN/DnAQGVuzA4oaa/yyQ8/diwTvkzz+4u0QRmM/M8cWq8SUjz05kjSJbjAl2sgAmXRw2h5vGxor25LLY7OnFXG8z6FxPiVM97hgErtw8oSUC+0uOmMFd/Tbb+q2A5tT+bIKGFREjjaS9naqcs5xZooM5lpVOUSgnk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA2rGLHbFJOSYUgJ8+nsrg6UbCDy/8ZhVlI0Ro2eF9U=;
 b=h7qgZa6EVsMGuPo6CvOz4EHuLC9N1PzXPDmrflNN+JY2rlFXnb0LXT3Nv6uWTljE5oXVxcftA9IaRYGXQkB77sTzC8lpoDwlpWGvxnr86r/9CVpV2QGYroQTn6eXQV7oFrQjhNt84AEqqgBUXMVt2+ndlD89fMdEXTqmHh3d7npnqrSXDFzKEDAiYW6iG+OCzsm5rEKCyzxpSU7Wljis1zhjUAIj/LC4GY98/D905VBdqpJbpYQVz7EC+eQ1XD2Li+eY6KXsnHQA9ay3s72SmArRpez7HgCIIWXB3p20PFxA0aYVsNjDfirexwn50Np76biQnD1t7OEUJFZN2R3eqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA2rGLHbFJOSYUgJ8+nsrg6UbCDy/8ZhVlI0Ro2eF9U=;
 b=qGoauSbHFBuolCjSROsGRCII78Twuuvi1l7A9DreveLFj/LXUVeItbMuP4qhTh+1stKw+t3UmAO/ThwsDyx2w9ikXcKmF3qRZFgDHn1KyBpytk+FtFqgCV+MHRcOY59uJ/hZfikkrUpxgZN6YWLVfrHLf3GdjV3yV9tHsRRYgqA=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CYXPR10MB7951.namprd10.prod.outlook.com (2603:10b6:930:dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 17:17:59 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 17:17:59 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maninder Singh <maninder1.s@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH v3 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
Date:   Fri, 27 Oct 2023 10:17:56 -0700
Message-Id: <20231027171756.1241002-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231027171756.1241002-1-stephen.s.brennan@oracle.com>
References: <20231027171756.1241002-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0193.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::18) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CYXPR10MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a68422-eef2-4b0a-c3a5-08dbd710aadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjuXBQVrj4YGWfcaQaVubpVX8keoaJRJPBopB+lOjLaiymAnIXC0GDr5MRKsX8sKITiDaZ72pxbEfMNoTM+YLJJJvv9TTr9ovzNnzgZzeBdnp51QsiROPwMlJrj/yUUA14I4qpXQGN3CxOsyZ6AzsOBV653s1G93wfT3dXNt8trS+Agg+srXqjU4uP+qUI0HA7ixz7OHMjavftOz67x1/yb4X7mtGFEZU3A8/PfibY33O0PgqEjpp1xO9sj+EpDiWo+wTKAvL6z30Kqoae9m8oAQ3HcnV/gkSDmif01tvcO78loN9VTppHKWGOVTULM6zY+pkaWXuploT7Dgge+52XMRdnHLMMuZVfkgsXZtotDgZ1fmj0Yh2mnprbmGj3EAC1h7gw5H525jgWIg3d7AYL8gK1zSjhn8MZtNJGOAXhitQNKbePRke+c2PCrq3tOA5fHz3xJ6Ygfe0b1BskcJJJDKV1R2oLRuuhPlBJF64MNAKCpVMB1aZ+j/ZZYM4bDO2CpKQD2MUCeOYwj9mGHonzT4VLeYE2LKuCa6NzxUntXKdfzBiSDYY+0D36FNmIEX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(6506007)(6666004)(6486002)(1076003)(2616005)(478600001)(6916009)(316002)(66556008)(54906003)(66476007)(66946007)(38100700002)(83380400001)(103116003)(7416002)(2906002)(8676002)(86362001)(4326008)(8936002)(5660300002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iDTb3A0jCfMeMSLMwDEw/TrVUbRwrUDpT9LpDa6bqlTEfIOOQI9upHmCJVLO?=
 =?us-ascii?Q?l0MzhXvoATser3TqCvKg0ReglPgijd1JTxAnC5tO3NfXKgMA8xKEKkO8Rhrm?=
 =?us-ascii?Q?IgGH+xm3V97n8Wk4jg4Im2Qge9nfhp6AVHFpN8BcBNz9k3faWg5hM9CqG/HP?=
 =?us-ascii?Q?8eri3EJYRXfYStOhWA20vazp4hw0FuIKpn7MeyCH/w9MwqMNkmVIZ+Hy6o88?=
 =?us-ascii?Q?FO7OpbQBMmvp85Q0NHVsuGfQFb6xBkKiq3Hj3zJO6n9etjYrP6gbC6s1FsX5?=
 =?us-ascii?Q?3/VwMzXQIBbBljZs+wX35GGMKRsDFbYVdPhjoCqtqNCev2wEfuIA4lfrCWbu?=
 =?us-ascii?Q?6TnQw/Bpe0OhTX4mjeDc6/XLcimPBXS1bsGZIqJ0L4nIoBYEKQRT3xVxqY/D?=
 =?us-ascii?Q?3CVtqhAXMp7z+PzdmXePtOPzXRmwE03Wv+KBCHh+Kg8MvoBZ2WdjuuxTS4x/?=
 =?us-ascii?Q?onPgIDqNkehMkMCtV0Go2R7IRhoVDoerEzMCjkr7GpzbrmbsI2C2ARO3BUmB?=
 =?us-ascii?Q?SNAupNFzOYsds779fuppHwVcqYJ6vfvMyw5Bys0EZ7/F1Lg5GsY8CCncPI3Q?=
 =?us-ascii?Q?TpbB/SAC/S/keDAwtG1b/r5CPfexy6AvKPuyxXwOVA2UNhBPurNKMHFp5uxp?=
 =?us-ascii?Q?1DIF93lqiVnHJuwk+wEC5awLwU6tr5+LwODlscY3cBCcqdNgqPzKSoVmMUns?=
 =?us-ascii?Q?Zj7ESV6QMR67F7eVnS8Hfsqvyog3YYQ0eBdZUFLufHK280JBPmAeQdDGFGoz?=
 =?us-ascii?Q?5HCKyXJwMZJKr1tweNB1kdAqgq/YVk3Jv1QVIFIHV8+J4WuYtBXGOLjB01a7?=
 =?us-ascii?Q?Enrl04fxaSm36L+mPXARXhPkxsIf50NjvdocykdmJBrHaBrIoP5oO6pLSMHe?=
 =?us-ascii?Q?ocQoE5Ssac7KlW9CIHyeqHrdBQHUpZ6ekOfBVuJSZBtminJtzB+h1PoSRrZW?=
 =?us-ascii?Q?zvWk6wrNYJ+yUcu6bNnk0mo+YknVnHzc2btpnGims4SkpmW5G7XiENhf//vZ?=
 =?us-ascii?Q?C1LKfYlKGVRlV2bDmfw7QqUAPRo23jr6OFIPZTlpObgvwymTdpEyo68C3SII?=
 =?us-ascii?Q?Ars6aY2u+YqXBtNETRgmgmtHpMEq9UAyTKN4kpqCgGPYuLB40gp86CyS48g4?=
 =?us-ascii?Q?pGBx1h5/pdnqTAdq4Cdcq46HHPhdKTsNSwiI3HxZ5RtrUTty0iqljt5r4kKq?=
 =?us-ascii?Q?Nms0MbN5bs6XuweSRy3h4Rmh7Du0i9iAwulDGLVyq30kpL6X0sXs4l8PgZIB?=
 =?us-ascii?Q?q/KTc4pS9jgbNYf/EXJ9NOLOZJ0prEp1S6mlZL2+Z8FBmthITqn45VBNQvfe?=
 =?us-ascii?Q?7osoEBKJVZT3ZBs81sYhK4SkLFF31EzWPLJ8Ju1fxgoxcOIku7Ghqi/EBnBT?=
 =?us-ascii?Q?TQ0TguYvVSrN6jZgdNbsfbGsyFCyPLQMHFeuXAbzeQSmtCya+s1qhzBli7n1?=
 =?us-ascii?Q?VtWdjzT/pv8GBI+tqtO4+fD+t5hqR9UiNjo/kS3ofxL8HJ/7PVwlgneO74BU?=
 =?us-ascii?Q?tuJaT1hQ476aWpEI0Elq7fN2Jna1TWsZpAvFfXnCgYimsdX6MYJOd8AptyaW?=
 =?us-ascii?Q?KaZzEMKunA4HKK0dBseoKkndcE+KRBQibkiC4LhfXGqjYiRRAFsYopcAvtM+?=
 =?us-ascii?Q?sAUARAIaoYu7lqlPeNQhj63CYgh1Ov4a930kJ4n5W2tyJs5v1nbYaN/xKk43?=
 =?us-ascii?Q?Mtd2WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+rLgcpthjhSjcI+JknzKz+DAfn5TOnkIfAkxRn/txSBE+ZzxJ0FOz2i21V7i?=
 =?us-ascii?Q?no0MoZAWLE4nWNZ2wbgpqGLAozQvYf/rCeC4FiP2Zbjq2Wgts7cEkUb8qU8D?=
 =?us-ascii?Q?wr6frf2zocuobf3kfExxOb0GM0lg3rdyBngRPvSD7Un0c6GCa9uUaVrgkVLl?=
 =?us-ascii?Q?dvcX86bxqNCz5PITvJ9G73Eg06hAWMVffTulvRG93kC/LUwtAMXQkjk4uHGR?=
 =?us-ascii?Q?cpjklbBZg22Y5rFGRzpUafkyL5+HnT5kwdmi6KD/SAoG6ma/C8nIDg5nr7/U?=
 =?us-ascii?Q?6fBAJj/v2py6/Xo+ymmlSyQBYCCsmiUx8nl1taWqd9zzcsZuGHvgaIi6aJUY?=
 =?us-ascii?Q?LU1MKSuZlPbFKYCwhaCdfkqoKc5t+Nk2y/lZzD+nLgsVYL+tW/uNA0WwvHOo?=
 =?us-ascii?Q?U01zmgARGXJ8a+21XnLzO8F5SxX2Ky57KTpT8V7IsptDdNYCRv4kFK2kCB5e?=
 =?us-ascii?Q?SHxn+npD1tInFqqMg9R/J1cwY2WNeleteK7vDxWwu5up1EzQRxHQgKw0ni0J?=
 =?us-ascii?Q?6RJx/guje2ZG74xU5Un5NweqQ1I3insOg5LeTSbLJOSrh0K1fdqlS2ioH0Gh?=
 =?us-ascii?Q?X70YnDWJcR3EdgfgFcfHNs+xNq1Um4aEK8fv3N4VVh/Ilz5iVfMwkt7VzoVr?=
 =?us-ascii?Q?/t7a0/1C/N9kXECcW1pGlbW+xArK3oGyxqonek23O8SiMTJvpM8s8402szfv?=
 =?us-ascii?Q?b9xiJNG4x7PrL72E2j11WBchcQd0zvyXEWlebVXw2F2+TNDgHBMYd6EUBQh8?=
 =?us-ascii?Q?3srTC1mdkjc8u5IFJPiaNKHJLlkfg1euewICQFUrSyRQuBhPjhG+TsNAZ1jb?=
 =?us-ascii?Q?cVxM+M+fSNsYnNVMfGHjDncnQ8PDbq7sSmWV6Jae5MNgWARwB8GY6ycXlqFB?=
 =?us-ascii?Q?N4qK/5oPYT56BsacsccrEos3d9Q6jRyp/KeXzIg1IWhNwTkk085PhqrxJXD0?=
 =?us-ascii?Q?iIxVE6DpR7PI371q3T2nDAIJcCWQ+8tuRVTdGkHwEpwL/grNvTskF0YOCji3?=
 =?us-ascii?Q?U7Md4qNp4W3AfFOkmzfBtr/i2LZe4SRu37tw4QJOMTDWI4EpgJVRF0IpdA1u?=
 =?us-ascii?Q?SjVk2odTmA6hdYl4oMj/VUr3JV1J43khWTKpUPQV63Dxw5KW8wA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a68422-eef2-4b0a-c3a5-08dbd710aadf
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:17:59.1040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vv7CDn21ZzRjlZK7utYKtyRJBc/ot5s56p60qypC3J/CI8sCvxyYJN8Ar7K8fP8/0AuUSTFPrkre69EzfSO6t3XRWi6nuLiKdB7/OJhb0UI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_16,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270150
X-Proofpoint-ORIG-GUID: qZjsK50XQ2EGsyE02vSaXNjCXKy_nxKy
X-Proofpoint-GUID: qZjsK50XQ2EGsyE02vSaXNjCXKy_nxKy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The option CONFIG_IKCONFIG allows the gzip compressed kernel
configuration to be included into vmlinux or a module. In these cases,
debuggers can access the config data and use it to adjust their behavior
according to the configuration. However, distributions rarely enable
this, likely because it uses a fair bit of kernel memory which cannot be
swapped out.

This means that in practice, the kernel configuration is rarely
available to debuggers.

So, introduce an alternative, CONFIG_DEBUG_INFO_IKCONFIG. This strategy,
which is only available if IKCONFIG is not already built-in, adds a
section ".debug_linux_ikconfig", to the vmlinux ELF. It will be stripped
out of the final images, but will remain in the debuginfo files. So
debuggers which rely on vmlinux debuginfo can have access to the kernel
configuration, without incurring a cost to the kernel at runtime.

The configuration is enabled whenever DEBUG_INFO=y and IKCONFIG!=y. The
added section is not large compared to debug info sizes. It won't affect
the runtime kernel at all, and this default will ensure that
distributions intending to create useful debuginfo will get this new
addition for kernel debuggers.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/Makefile                   |  2 ++
 kernel/configs-debug.S            | 18 ++++++++++++++++++
 lib/Kconfig.debug                 | 15 +++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 kernel/configs-debug.S

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9c59409104f6..025b0bfe17bf 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -824,7 +824,8 @@
 		.comment 0 : { *(.comment) }				\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
-		.shstrtab 0 : { *(.shstrtab) }
+		.shstrtab 0 : { *(.shstrtab) }				\
+		.debug_linux_ikconfig 0 : { *(.debug_linux_ikconfig) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
diff --git a/kernel/Makefile b/kernel/Makefile
index 3947122d618b..ab28e7d9aa15 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -138,8 +138,10 @@ KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
 obj-$(CONFIG_SCF_TORTURE_TEST) += scftorture.o
+obj-$(CONFIG_DEBUG_INFO_IKCONFIG) += configs-debug.o
 
 $(obj)/configs.o: $(obj)/config_data.gz
+$(obj)/configs-debug.o: $(obj)/config_data.gz
 
 targets += config_data config_data.gz
 $(obj)/config_data.gz: $(obj)/config_data FORCE
diff --git a/kernel/configs-debug.S b/kernel/configs-debug.S
new file mode 100644
index 000000000000..d0dd5c2f7bd5
--- /dev/null
+++ b/kernel/configs-debug.S
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Inline kernel configuration for debuginfo files
+ *
+ * Copyright (c) 2023, Oracle and/or its affiliates.
+ */
+
+/*
+ * By using the same "IKCFG_ST" and "IKCFG_ED" markers found in configs.c, we
+ * can ensure that the resulting debuginfo files can be read by
+ * scripts/extract-ikconfig. Unfortunately, this means that the contents of the
+ * section cannot be directly extracted and used. Since debuggers should be able
+ * to trim these markers off trivially, this is a good tradeoff.
+ */
+	.section .debug_linux_ikconfig
+	.ascii "IKCFG_ST"
+	.incbin "kernel/config_data.gz"
+	.ascii "IKCFG_ED"
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fa307f93fa2e..c43a874ea584 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -429,6 +429,21 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config DEBUG_INFO_IKCONFIG
+	bool "Embed KConfig in debuginfo, if not already present"
+	depends on IKCONFIG!=y
+	default y if IKCONFIG!=y
+	help
+	  This provides the gzip-compressed KConfig information in an ELF
+	  section called .ikconfig which will be stripped out of the final
+	  bootable image, but remain in the debuginfo. Debuggers that are aware
+	  of this can use this to customize their behavior to the kernel
+	  configuration, without requiring the configuration information to be
+	  stored in the kernel like CONFIG_IKCONFIG does. This configuration is
+	  unnecessary when CONFIG_IKCONFIG is enabled, since the data can be
+	  found in the .rodata section in that case (see
+	  scripts/extract-ikconfig).
+
 endif # DEBUG_INFO
 
 config FRAME_WARN
-- 
2.39.3

