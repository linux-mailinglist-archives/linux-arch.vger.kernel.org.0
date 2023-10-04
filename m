Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274417B85F5
	for <lists+linux-arch@lfdr.de>; Wed,  4 Oct 2023 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243487AbjJDQ6y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Oct 2023 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjJDQ6x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Oct 2023 12:58:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BC195;
        Wed,  4 Oct 2023 09:58:49 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394FJ1t3016039;
        Wed, 4 Oct 2023 16:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=dX31TLwAkeufAs7pvOyCIuED6k5EFIiplKJqeD3ywyY=;
 b=q6nPklgpm0Y9D3sNE6cUn/PzgDCNAkXUKn579gbso+D0Rd4QHGBtMPehpq2pRMA2Ya0+
 LFXzne92kvYGQcRGK1rC6k7xZDV8LaMQ9Zor3QLxGMGjubcn9+BUqfL5PUDNjBSDSipa
 H+agalcA4lAI3KgZ+EFDPDQnACmQdoGnytlh6siF0ndWPeLh2qc/UG6nteTPql6HHobP
 y/RE/WVOZChaSMEhiXvpZWrDoUkXOhkGKl7FaS+IRbD20MQ7os86s5zshU+PN0BOEfl9
 YpzibuVEiOA+X8T1csJENWJczEQE6LDTAjafv7Fv44TPhqjNkPkjd+0q9v601rZ0Jyv+ CQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcfn9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 16:58:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394GUJI8033618;
        Wed, 4 Oct 2023 16:58:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea481euy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 16:58:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpVVKLWdcMjqh9r9Cpg/yg8I4rPBMO9/gzLviKb4mvb41853ViJsrf/WHwBCdenDJHTIQND/fNibVK1hB+KQKuWlajC2KtkYF2qTAjrADddUVitwE9uN90R+xYTTp2t1PyYthtH998k4ZBX/wZr0rBOZoEj7BG5pWXrvKercAI8vHd3Xm/ypAhsplPXi62eIVdjvA0N2RQ9/Q/TvFzSikx3mBJpR05S/QXb5zFXCSNl2I+0zp36ACwZBjGgutq32k0rVSyDift/GjodISrQ7sWoMfqeKQAPpJbE+RSBoeb2lzmO/7p1aql0RR4gqMpY41tAd7PhoUp0N78IY+0/s9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX31TLwAkeufAs7pvOyCIuED6k5EFIiplKJqeD3ywyY=;
 b=ac4V6zdAwO7OfdeJkunPB1MwOxLYT+bpQbRFoPj+/yZuTYGjjPM64fvgVZ+V+kboXpfFtzkqbveB4pWPXmZEUxMu8YEfdcppojHLUOP0HurHhi/CukXb/6LCIHUJkmV8QZnD2iJHQcTnHdb0t0NUvjUiM0ttPqQeR4gqQ5Ql3EmMh04t4vjiqy+EyjvoEC81D1qsyYIpGfx1vVYyDhpQxXUiCK5embpj/M9kOjYZHHmqfXyiWDjvsEKzsmhw7oPxsgsPzWwTudTZK18PcOnVOpUUtdvIjr5CK+2NO+w7hdVZtRHiBUVK4yLyJ3w2G6xknuSLIg41vSx5TIjew//smA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX31TLwAkeufAs7pvOyCIuED6k5EFIiplKJqeD3ywyY=;
 b=Ze9nullKSx1qRdCbK00q9PaRWT/nBr8pXiWbmZBPeFYQhazDOitPkO2eGEFizqebUbuuAtb8wWY+ybyAfg53HcNmM4/triHHShbl/kbc3aDLTDsR4rVPhRP4vyRXU7zP3KLarI+JNKJdyXS5efu9q7SLVTVxxHDp62SXutFuZ0c=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 16:58:09 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::35e3:7e4c:72b2:cf74%7]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 16:58:09 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: [PATCH 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
Date:   Wed,  4 Oct 2023 09:58:04 -0700
Message-Id: <20231004165804.659482-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231004165804.659482-1-stephen.s.brennan@oracle.com>
References: <20231004165804.659482-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:510:324::6) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 487d72c3-6ec0-4d66-46d2-08dbc4fb1605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+WZJGGh5hAAXVAZ7RW9p7aUZ3qfXVFqbaI2PUa/gfrTJTpD1kFYASPQDn1Qt+ux/1YD6MbRyUtVmdfudCmYHlzjbdEfdBZMrLwJJkinFE4y4SY12GTjHtMVkHHzdXASY1wJqD/B6W3dsWao9g5QXPFvIRrdmbez6IUSK9wYoCjx2Qwvbun0clTvbJMmUTdpMqmAu8f+KK0NGOgrrgRifLgFxPXfjhXIA81U2C/m5WHf22t6MsUZH++D45zcCZdkdmZ/Q3Sr9TvN6ywTwv2W38tDO1L/MZiXM0+BNFu3H0Ocfo838tJGYp4IyFBomBC0Nbb52WJTsNUJeTpgJwf1HCXjZe0f6K4VsbjsuM7PzMM95XgYn8fXGISHrUAllaQaJQ8bqmrMKbtWcya3zHEZun93geHqMmonIriesYepIYPh7YHFEeVXFlabqGcJtECGGlUiADs27hTEQ95OVtK+t7fDqvnWfFb6Q0s2BFUu5W07YC2OZviG6dr0Rk1c9R5mri0dqxhP/L5Oeb4H6PLTVtLmI4Amv8LHVWen6e0zArcoIDg5ZMMUR2R9hCmn4Fcx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(8676002)(41300700001)(4326008)(8936002)(36756003)(5660300002)(66476007)(316002)(2616005)(86362001)(478600001)(6506007)(6512007)(38100700002)(6666004)(1076003)(6486002)(66946007)(66556008)(83380400001)(6916009)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKwwqJ2YM5JKEVW9j/SpK4lGxn0Bf+pm0lq2wnObW7DP5STVDIKapuuUHnSN?=
 =?us-ascii?Q?9cWt6SajPXIhNYnm67EJyTJnNpm+M7djVRQ7uyVYx9Ga8D3kEY5zyDhz2r0z?=
 =?us-ascii?Q?NloI8Isycd+PJuRmhzdZJuc+v8HR9a5Ga0UotTs8IewAwtedcR2erRgCBqCd?=
 =?us-ascii?Q?Lon+AwTxmfFJcWGR5N/IEyDpqaGepe7Q7KNLOqSM4hkhSH5C1Uw+47wzfXmw?=
 =?us-ascii?Q?zu+1P+fnE7xYShpnwTASkfuU3s0iv5hx0Q9UeWpSHRU4+zmfHs/cTcXWUJmK?=
 =?us-ascii?Q?uK0BHr3I3gNKpRN60dfNgFnt657oChCYAYdNQ27P7mqCPeXEHtQakCptI11g?=
 =?us-ascii?Q?W7Whty8uSekgJk/PXAu7TjKST1lzPwIdPRjozNqD8IxZiXaUSPM0VOxcl16K?=
 =?us-ascii?Q?7JdHujBPCftSrpUKYvoxDPLvYSMXRbM+fK74LtZyj2M0JhyYCH9N3MQ4CL3B?=
 =?us-ascii?Q?P7zx3hbJwErmgZ6sM9SywP7CTrOtv+nbA2gN4ooiOfsTNA9B9CgrKjAG0Iga?=
 =?us-ascii?Q?LT9LkGyD6cFKoTIooPyH4+MeXsvVqb9ELKweo4t8nU+qs0erSoUKt8YZIpK2?=
 =?us-ascii?Q?hcUv8I2bpqZGP+ECoJ7VmUv9MgI8gZ+0oBlZeKeAyNb3LtkWh5HzeKNuNW4A?=
 =?us-ascii?Q?dRx611+cCErAazC22hWLqXH6wM9Gu1qwMxsFgJ/BEhBz8oPHyPJrVxlllTzq?=
 =?us-ascii?Q?VP61HIA+O/ONTXkRjYqkmEh5uPTb3H8Mx3CMlBoC6Pjt7Yg8vY/yKQgddp5C?=
 =?us-ascii?Q?umAEQhsLRRMnlStslYHcIWOvn+c3AnUnp844cbI1OP3c0tBmClx2mENVJbMH?=
 =?us-ascii?Q?8jTUgcunYpif8XmCOvMTzOc8VJxSEmBXf/AZFvZ9jIrPvHj/wjEY6VF9leKW?=
 =?us-ascii?Q?dlTySGdgna9Hd6UiUzOn1F9XU/8zkT6YkTBATA1tnczvqP9ciM7hMbpnTe1U?=
 =?us-ascii?Q?zMYrJJBvv8kAHvNe2ZL72nFDOougRr0nVhMKE73Hayy0x81fcBjIcbbV1tmO?=
 =?us-ascii?Q?+cnPiiViYVfd5cFglDeIj4+pSB82/ipvuN+3j1buM12pTG+b2V0sYK/qsNZE?=
 =?us-ascii?Q?u1HV3DaYFC/wpQv249asAnvkuDOqsT4Ps7pFvYTY58ZhhMzC5PugneCFrBHx?=
 =?us-ascii?Q?xQekO3GcgLJip+0pickV8doTSIoOvVIH5nmlfhSE5sckikgmlePTR6xe+rG8?=
 =?us-ascii?Q?xUYKi3VIHsjGvBtnQvYxJfeCHwzXL4HwpLiw46Muwz+QT+lm/wGNF65MBWz2?=
 =?us-ascii?Q?PT/dKMyisVv0kF4qCPAK6paAMKwJ5jIJhGZb1Hi2kRCDuyXk+YsmxedEIOAK?=
 =?us-ascii?Q?6bVCxFpaUgc7ElHIxsiqpdpzWr1v9BJifcL8tl877xkbQFIhaIh6uKoOP299?=
 =?us-ascii?Q?qBoL5KadQVUSwO8Qf5vbIFjusOXfATBMCChR/TF8qY8W/84mqHgeZLlXyzSF?=
 =?us-ascii?Q?LiNFG8UdRqBoWVc7d/kmdz8QoFyN6+hUz5u3hkFmcQtEEl9Nz6EYY/v8xHat?=
 =?us-ascii?Q?Thzc2uqGw1fQZKgn3cRqONUQZGvFlVjK5v/JaR3mr5XGNO5MYCbJtB1BSzd+?=
 =?us-ascii?Q?Wt9Q8TWzMAXWSw36+IiURLjiohraK6yhp9LrgoIaebZW9PxR8NtE03MqK0hA?=
 =?us-ascii?Q?ghI7MmNjGh+sc82zsW4sxxL3dDujV1Nb9kBqeFbBty9NOr0Se0vsoV25ds+w?=
 =?us-ascii?Q?nFy15zZkAt4gNluoH4YrlWixKXU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7pAbHF6vZFnLFhij0Lj4crYsu1aAio0aWo8o4phvVrMmnPnV4cFuC5O3nCDE/EXHuM/aN2tvTWHsYIV5apDIeM7F5uI01euIMRnJy4LxIIfZkiIUkVQEinQaURdZnbE9aYx7aAEnUDos5NdyZsN8Q+LmKMBUlWtzY+bLlhDZG7Qj1lAlacgA1RfL0x9nNoTQ427Su898kVtpZ1GdC8gQWkdqfwM/lUinX+lO1VpkrmjfmGAA7vnESdi1BbMkP63M/rd4xNPPtHpK928daSDl09rDM8tE/UNRvAxu4ItFDxieeHeZ6xpVEKKwKdl2xpIMiLESQLd4EA8JqCcSNyexaErIf+hKvzOD+ejPcAIKhrAX5OcauaV3pqnfJBwvccQsZYsaZUzsRVR5fNFfnyw88MF24fFT6ORveKIQSxql4TQMFriWip/Cqo97uOAJ9FYFnnDhQ2sX0ShocRf5B9izPbE3/yj2C9H3pDAhXa4N7vBNZnAbiQUzbAH31OttA4itq3ykiJEbzrLkR0uBWh9w3Elzi5B4OlbZVewahigysvnp0MlYVn2cVF5b24FmNrE3DOy3zMRXyhuvbUOdP+ajcBAqtROmnZDut87fK3XkBNX/U5sfOnBmumr32UdYj1v3F6XBgY3YHrZCFXyjeKqFApeeFGgbmNTEFWrrdWRVeU4c8JYErbildPeVKCP83He3HU7S4MTCOtYcq9CY9832ulxcGTh3KA7fh9AR0RHEDxtBgehfVw7MIj/615h+f9eUyVDEkDoW8rPNjls6SmmO1qBhgMqcMlY7bOsK7MdzsO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487d72c3-6ec0-4d66-46d2-08dbc4fb1605
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 16:58:08.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoBekCbu3mJgia8peOtycLQr6ITTiZ+UdmzeHgUxMNYbzuhZuoAOoMqAFSliiLiTloRsecpBJjOBsX6UcgAFFdUHNURUHkBMMZqBcmUHgQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040123
X-Proofpoint-GUID: 4nNXAUgbiYDQAhv2JriJv9uijGQM1X6i
X-Proofpoint-ORIG-GUID: 4nNXAUgbiYDQAhv2JriJv9uijGQM1X6i
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

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 include/asm-generic/vmlinux.lds.h |  3 ++-
 kernel/Makefile                   |  1 +
 kernel/configs-debug.S            | 18 ++++++++++++++++++
 lib/Kconfig.debug                 | 14 ++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)
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
index 3947122d618b..e2f517a10f04 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -138,6 +138,7 @@ KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
 obj-$(CONFIG_SCF_TORTURE_TEST) += scftorture.o
+obj-$(CONFIG_DEBUG_INFO_IKCONFIG) += configs-debug.o
 
 $(obj)/configs.o: $(obj)/config_data.gz
 
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
index fa307f93fa2e..4ebd1bcd49c7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -429,6 +429,20 @@ config GDB_SCRIPTS
 	  instance. See Documentation/dev-tools/gdb-kernel-debugging.rst
 	  for further details.
 
+config DEBUG_INFO_IKCONFIG
+	bool "Embed KConfig in debuginfo, if not already present"
+	depends on IKCONFIG!=y
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

