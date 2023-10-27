Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3F7D9EC4
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 19:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjJ0RTw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 13:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjJ0RTv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 13:19:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EBEAB;
        Fri, 27 Oct 2023 10:19:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDVJCs006061;
        Fri, 27 Oct 2023 17:19:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=UniXMJ7/vZrJQC45hq6KABWHBfI/8BFdDhvOt+yA1jc=;
 b=kOpc6fm8rPRZma77SpMyfDP4Y+/RGGZq3W398JD4x/H/kZAq5O5wKToRXI+639T9OdbF
 EgRT/g7YDe92R39JhNsUhmdZJ9VuKb5x5hfCjQ8/uR3uj0TNAE/XQt7AXi505Es/b89F
 eQXQNansuksHZYk5NtdxbyD7aumatGb7ANfSEewqy2Utbjap7iKHusQhEkS48z0O6+4f
 y+IgiY7OTAyEIiUKSslDpgTWy0J+5SexAQqkea6jofzrbQ2L9WxjRRXEy3xCK+8bfi/N
 sINvD/ao9BpIX17SpUNghrWj14HlN4zmV+PS3aAbGaZbPBndSuCvA7MUnzi1ioTbIMcF +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyx219yc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 17:19:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RFOeCA025767;
        Fri, 27 Oct 2023 17:19:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqmgs5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 17:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBAWXbRrX4H8D3CCFMqxQg5dUQtBNgs1NCA9qgFIq3+wZqmpzqiExmE17aMpiyXEHeioY8ZWFJmVszPm3T7fMDStjfYcEmB6JR7vjRD+SK293XHYR11GA/ae7gLezQYhMZi5bx4RzwKD0YunNzKJeHX1ID7yEPrwI36nsItw9VE7kxhw0CbeZAw1G7/1+Azul6PJ8F2CXLGBpo+5lyAo1KBdlPjUfoG+2EcbmRsY6vVHFqZt7d5hxQDGj8iKdaNZsmIniAyVxiQWmuKS2QQ9yg06J+SPykGZhUYYo6H6xmUP1EVeXZnBLxXMdUUn10sb55s/CEQNuZZdKA7cx9Kkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UniXMJ7/vZrJQC45hq6KABWHBfI/8BFdDhvOt+yA1jc=;
 b=LG6/atNGJFdqPPZmupAFbfTXbt2YIfsxZwkd0JPfW3D8QrKg2OirTbYOuKUvdM1OcQdcRB6iW8LI2cSqU7vAVDx/VwW8jI6BAFqBbrc7F4p33JuWOLdYy6tIcYvcAKgy1+tynyql2tAfPqdRELHnK6Xs8h/S5AAeJgFkm/eupKGvcRZIhOiTZTfyQPEga6bBApswh9NTHZ/DSL/69fQFTJ1yj8EfaK0D6+ov/TNBE8pLlRbNnWDYqtL4VwVF7kSqPaB6Zm1I8MwYpyos0v94xzQd6JwPf8DJrLSVCfPYCA7cGKU9HBlViUkVeqOza2nHLPFga7F5xX35YZJoJULkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UniXMJ7/vZrJQC45hq6KABWHBfI/8BFdDhvOt+yA1jc=;
 b=DCIZyjzucImN4kDj/tDSqr7yBzbedZKGR6uoerI4SJFOPdulqZtER/R7UNEPcfLosfN/NVYJAJxsWxWIJT48xJ+C+Ng95K7fODECRyU8apmRN2vTYat1U44dtvdTWUpFuw2r6wtWUNbqoK2cGz8JNsoSadv/EtXl7xRxwqHsiUo=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CYXPR10MB7951.namprd10.prod.outlook.com (2603:10b6:930:dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 17:17:58 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 17:17:58 +0000
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
Subject: [PATCH v3 0/1] Introduce CONFIG_DEBUG_INFO_IKCONFIG
Date:   Fri, 27 Oct 2023 10:17:55 -0700
Message-Id: <20231027171756.1241002-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0100.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::41) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CYXPR10MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dea2e59-6a2f-4f4d-3fb9-08dbd710aa5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCSFA7+ZmTjOiR7xEx0/udb0p1jfZoVfFvVdZnHfSGmVHmi2n81Pr4fugOc/eNwDUN/sA6oiLEZq6DDoWTfmseWFAAbYjHvp7R2Bupl5BxKfaMDduRTi40ki8em4z19nRCod50EKzUAhLH3PEmS2p4MnM1vTQCBmHFTU0cVnsoZiCcwn5/rhKQq+vUPGBz/nzRyuiIgCHgGy6G1fBgzs0+C6PBHaNVrEdFPHQQ+xkOBR9GrO3me0fTxP+BafFotCZnB+/rA3etCTvIJ9iLqyhJ8TddIObeGp/qiUuhSB99yxxOMeOHHOvk+PrsBr+wXSxZ8h2GDGIF/cgIotej9l55d4dPgQSG7TpnUHeQv3xoMK8SnLdNW2T6IoR6HyLHb/+snz0wyuPlIDhhpmKB//NmVgfWa9McZTIGslGWsbRvcCPHlH0xOPPBbTLtZFGsz+E5SCEVmzGOBYAOMWI1bDcemU2LR0ybMTiu5qS3nfgIw0fMX1DDAPku39c7p9kmDERsp8Z+ONxyZdaJae4lStvAIJw3jtNzJ6XP5+ARFGaB8USQ/ag1p6StzMeVkK2OrLyKxW8SbPg3Ld8oU7beZy+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(6506007)(6666004)(6486002)(1076003)(2616005)(478600001)(6916009)(966005)(316002)(66556008)(54906003)(66476007)(66946007)(38100700002)(83380400001)(103116003)(7416002)(2906002)(8676002)(86362001)(4326008)(8936002)(5660300002)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uBmllXcC47jDd+3IRjN5/KIyLoohTMPJCaAIDAr1YSRgpMVQPRpPkOH8VT8U?=
 =?us-ascii?Q?jXsyvMvFbYMJKaBtT2qNGnAv73siLZwfPuCvCi7yusAOtH3CJ4Vrob+2Cmx9?=
 =?us-ascii?Q?sykgyOAnqfLjcqAqPEMDP4pHYw5XAhuKQfdKef1ALE0lPDrh7oQYX3uaVZat?=
 =?us-ascii?Q?6oRX+ApadtbuU3hQPbKnTjze8tdM/ttwXKd3Xu5GNhEamFk6QhoGoTvJTQxr?=
 =?us-ascii?Q?saD8iteDUKHbw3ypygMLXMtQl/rZ8jwEqYpcwFyUBu7vJ98HUmWCrzIJVHZF?=
 =?us-ascii?Q?gHLDILvRBoa/M6zBbI8gdCFHJxN+yDcStOIyN63FpvHzheXp0mXuGaiIUA06?=
 =?us-ascii?Q?pBZN1I+diX95BbvpVuXsBoQljIJS59UvfzHjwZUIQUB9MG4iDpBhi197PA+h?=
 =?us-ascii?Q?2585iaziW8FFwixjPCthhBOAVi1Gloh1sctDngs7a30Gvp7B5EaC09+/LHpL?=
 =?us-ascii?Q?d/xImbO3a00UHkN+KElZ0+FcgRaWf6DSJ2MRSwffQ8yXLj0qoKHDJ6uTpAIu?=
 =?us-ascii?Q?y45hifgHRIvWihRGT1sVEfquS64Mmo7jMTYGs45aEPmTyk8MJfWuXjPRfFVM?=
 =?us-ascii?Q?oUP4p57kRE2sf0NwrHTMRV71V8gDK9U7NT0r4KV8EaykZwZgwjQ+WQOBmjsc?=
 =?us-ascii?Q?kiTOBkXF3DGP3B6K3zSEBSsYtjttQlVwcRzv/jyI0Xrm1GEmB7w+CZruqZp3?=
 =?us-ascii?Q?LxnE8hNUZ7A60rPJYmbP0Gdfs1Pb9FE3BVxS7J5vcaq92v00C5Eit9K2+x3y?=
 =?us-ascii?Q?iHZE6pMOuQ3haJxg/gWw1GRLjqstgCHSS8rqOZwnH32k12YlpLw5c8F0r5BU?=
 =?us-ascii?Q?bQg6sTg+fu0gC9G+vGbC9NRNvBY9QQz06VbI2HC37GLRyn3ZIyq17J5uQQz8?=
 =?us-ascii?Q?RxB3oBVj0ttu7hsHR+X97JudGwj9EDZqTXFEuFuqXQ/iOCc48nG+Q+4McHkR?=
 =?us-ascii?Q?BfRPCTBDSr1K076wkj8AR7oYti92vJqr43/v5APH6KRVzkHqklJXgIHOedgs?=
 =?us-ascii?Q?XhqOJ7Ouy1x0jZeH+JXYxe4S2N7G4cfFkLV0AcksuLDUGDvbYXn8arV35456?=
 =?us-ascii?Q?YbOdhJMGN5rjVFzaGJktGFMNyNGikWZR3RqA0SO3irITDdQa+9Qerrh22Koj?=
 =?us-ascii?Q?Az0/E2PAm7Iu6Y32cNCabE2Jzz15fKlpyowe7QhlATLt+N9b3hrlWkjOhfgc?=
 =?us-ascii?Q?4zwLq7UPJ13vWltK1XPfWLA5DHxdbZ3gj6snJC4t4tBX0IsXJEk4CTKSFC4t?=
 =?us-ascii?Q?QNdEKP/QrnXH/kxuL1HXVrzNN2sRcio447iOkNoZcoVoxgrW4RNCAJd5Ll97?=
 =?us-ascii?Q?KTb1Dk0EOg8arNux2gtVhVEVKuSRacT2u6eS8z9vIWH54Wgemejp4M+B0v79?=
 =?us-ascii?Q?TUCdXLPvse2CJuSn1YiBI8BWPlgX3E7EpHuIbe5vV4jTgLaqGZylKj9IRz3w?=
 =?us-ascii?Q?Mxl62ITiRTyLnIGe82s62jNdpp6lXUn+Ud9Z8F/K2EYWtcWxE/WG2XCbvXo3?=
 =?us-ascii?Q?hRP8U5Bzx2et1+pmElrcyayi5W/hHR1wGRy3TTymlP8TljQcdSHZfGwmp6bS?=
 =?us-ascii?Q?es0clVOT1Dpb/tAcxbpl3knNQEA8oW2FQdDd1XoUfN5PVGIA2VeT/g9xQ+vr?=
 =?us-ascii?Q?2DQPYIaax9G9zPH3ULtACTgHxWWo4YRqMXujAE8ZTRHhVLHRxsViUiP6BbFo?=
 =?us-ascii?Q?3pfBIg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/jW6kJLcQ5CGQdXGr8G8/QHLvaJdXqXKOb8vxcFmfzQ2LWvesJmCnUGDcD1/?=
 =?us-ascii?Q?7tggC4/8RVrU+LLeWoPfJnLvVmBKpF2RY325ou1ZAl1qJwXuGhO1QprUo0tJ?=
 =?us-ascii?Q?O2yeagisLeUwqfiNliqGBBPLKatcKiWZOJJqrXaXaINAtaX2/nvBwFCY3w3+?=
 =?us-ascii?Q?6poEPArE2hjv/iZQXA3D07ArbvcTWEjwCrURc43Z+udlpPY4WuwVGpNb3eQG?=
 =?us-ascii?Q?b4pDGt94AU55UOIMb3UjQegUoaQW3z/gGDj2ZSjVq/zkUN4WehHKvGDQww/L?=
 =?us-ascii?Q?FmN+kYpCkRkZjGKRhEfZuPTyhF1ebfikb2Fil5p1cHxt6ERNDvBIyvkBVssN?=
 =?us-ascii?Q?BkbpW1aAqDl7JjNig0EeUDBv+59TZSKLdlxRPeYGhSe4ANbRVzNg35gTLd5I?=
 =?us-ascii?Q?GtVt+iK/1vEnAafvFrzaRgzV1Gcmh8MqAHDNJj3b7O3sjb8MHz4+9EsVQnGL?=
 =?us-ascii?Q?MccCMWRZmWl441JDPAhRy3V2ZCGU/icfmXy/bc9I7Djjs4wLNCVDkX/X8ybf?=
 =?us-ascii?Q?xZPn1dd9s2WOca7dGpGMbkaKJIlTo7gaInAX+BqC6v5QEVs5UHEbDHE0jugF?=
 =?us-ascii?Q?MvpOCvyAG51gezvleFvw28q+Wi9uijzrReviG3yL+KyPbGBO5yEjYoWl975L?=
 =?us-ascii?Q?EUAzIq0p7rpr1OLyd/cLe5wLr2xL3UOA8iDTsdhvtYQ224eIiSXnc3mM25VJ?=
 =?us-ascii?Q?BJDRYtosmV0MSz34y3Um4XIoCTuzdgXlV4QY/AznxIHwtYncFPhn+5+NcI38?=
 =?us-ascii?Q?IPhb5zhmRSj38FyjIG0qBw245NE59NJEqOXlfaqZlgH8eZ2us/+xBRFkUHqh?=
 =?us-ascii?Q?mPRunQrStKmwJSArmkAUqQ+8JmWd7cpo2IWrCnCYKnZdawQrxEvhiFDoGw83?=
 =?us-ascii?Q?/SDFynZfcFJdmnlTCxdE8iYgzpnYbhQdF+tP6muoq58AdtNxiKAg7tBW/lq9?=
 =?us-ascii?Q?iFx0LwLP7sZIz6l5NRwntwWzfsY0+V4OgI7N97K/7NAYwIqFXyyTDPDiXWaT?=
 =?us-ascii?Q?ETD/MgLZv83OomeJSbfZBA7nYfok5AKA+BIE56jxG01/ZHqRYJD2v/zwOyfE?=
 =?us-ascii?Q?PMFdR8UsjkhdqG+IyraNtymZ8xAvV0bcezNjRXAKWbwBaq28TGY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dea2e59-6a2f-4f4d-3fb9-08dbd710aa5a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 17:17:58.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxKNAWJISpaP8rjEvnM0ENk4aYViXewAsacmpCntFHVEF38Sa7JPdfHRMGNfB4iO6UJfFRJGXQ+pF7DzI5Ev7ek7lDsrnzfX7NL9XR+twRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7951
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_16,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=836
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270150
X-Proofpoint-ORIG-GUID: KcJXjxt1l31QfB2BMP5TxQN92T_7qLuh
X-Proofpoint-GUID: KcJXjxt1l31QfB2BMP5TxQN92T_7qLuh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello All,

This adds an alternative for CONFIG_IKCONFIG, which nearly all Linux
distributions disable (probably due to memory considerations). It adds the
section ".debug_linux_ikconfig" to the vmlinux ELF file, which is stripped
out for final images, but retained for debuginfo (objcopy detects the ".debug"
prefix). It is enabled by default whenever IKCONFIG is disabled, so that
debuggers can rely on having the kernel config available.

v1: https://lore.kernel.org/linux-debuggers/20231004165804.659482-1-stephen.s.brennan@oracle.com/T/#t
v2: https://lore.kernel.org/linux-debuggers/20231025223640.1132047-1-stephen.s.brennan@oracle.com/T/#t

Changes v2-v3:

* Added missing dependency on kernel/config_data.gz in kernel/Makefile.

Changes v1-v2:

* I added "default y if IKCONFIG!=y". The result is that whenever DEBUG_INFO=y
  is enabled, and IKCONFIG is not built-in, then DEBUG_INFO_IKCONFIG will get
  enabled automatically. The whole point of this patch is for kernel debuggers
  to be able to rely on having kernel configuration information. The IKCONFIG
  data is quite small compared to kernel debuginfo, and it doesn't change
  anything at runtime. It's safe to enable this automatically, and it's
  important so that distributions (who create debuginfo explicitly to allow
  kernel debugging) will automatically begin creating this info for debuggers.

* Randy Dunlap did review this, but I didn't apply that tag with the update,
  since I understand changing defaults is a major update, and it's a small patch
  to begin with, so I didn't want to misrepresent the review.

Stephen Brennan (1):
  kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG

 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/Makefile                   |  2 ++
 kernel/configs-debug.S            | 18 ++++++++++++++++++
 lib/Kconfig.debug                 | 15 +++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 kernel/configs-debug.S

-- 
2.39.3

