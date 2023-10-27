Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A417D9E19
	for <lists+linux-arch@lfdr.de>; Fri, 27 Oct 2023 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjJ0Qhp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 12:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjJ0Qho (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 12:37:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F941A7;
        Fri, 27 Oct 2023 09:37:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUnIw031062;
        Fri, 27 Oct 2023 16:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=8lIS4tpbnc9hbaGSg40uxY0lA/6rYN7osXgTwjsZUvY=;
 b=TEhTG2G2j8/GdLmuAZ2co2VNs4WSpBIgMT27wngemXI0lWNetbxEj+CHPowfMs68BHNI
 Me4cC5Vk5twLEkOVll+oWR+6dAZo052KVM327SfIzs/dtOU88dY50+y0Af4Ze+zVXn5y
 TGZC2hb76vetB/RDEos6GeZW6sa9EjpcYDUn2kVPkcJgm47l5iPgIyNlK1i5HXbulGLe
 /fORCy2QdcZNRhjKwDVvC5keipF/rxl8K88b02SvQ9YWqP4n+pkbKs88PZ0W2juBXgli
 /XSysfOSEQBb1TUqJ9soVs+Aovqm25wfhIUPWrZmklTdGkG9Vcnl0+B43XCgqtOg60UH Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxge1uwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 16:37:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RFBTs5008126;
        Fri, 27 Oct 2023 16:37:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjrubu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 16:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os3y81EuUgeeuv1hah4qa5Ncbg+6u4doM9xJ79C0KwWCkyaQxIYdoNe48LKRCFyxofxDpUkCSEjzmXIOlI+Brjz08VjfqIORwYXiyaT0NaWnHcR5bNfDeVPFDbXKgSrSk95CCAPfhCkKMTC1DHTOkdTkldAchzsgLQkiPgkKJoKvYz/Xq0tb5bdTvp0jtUNqrP8Cqlj9xn+6fQQ4/8OVrNgXRypR3aHBdRyrJ30WqqMqkUomMpXwjAqbiBCN+S0Eso4PezbEiO0pE0XDOxqrqOxVfA+nMNLTzbtcYuG6ixv2D3vWKRtjFeOxhmWn9MgRKdeDNDIdltUr50r6NeUoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lIS4tpbnc9hbaGSg40uxY0lA/6rYN7osXgTwjsZUvY=;
 b=jjrBbgy4WYx6r9IJAU4sPM0ReSKwWbAodQfA947Lry7+bBhUlbv3b2SgExetQvlMO41ePugnTI2zeLAxrMhXnya623tzgHYFzPpo5372EFdQg3tg65w0YjDJmOEd71mrQOGTAljqG0KGkx9WVEYVVgNmYQcHM+agafbp2kHYPxxwef203yCZArWL+RsR+tfQqXgL6pyzkz51RzrCwhVewfwH1riBSq2u2ed3DN7wGhhrYx3H1cva2fvNJafDLQHu8YDJcWb+tejHHxeRgnLfP9j8+4Ucgnicj/ukP0ycdUnJ5pDMLqw9xJBYmbYwCW3tvVRTnCnIBcLTQ0Y00LgILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lIS4tpbnc9hbaGSg40uxY0lA/6rYN7osXgTwjsZUvY=;
 b=zfI34A6f7a7IF9921V6vmoqNNQ8T3wadSeqigsSNp2/YEf7USZ0+DnA4sPOTFkh3LrKVaEmSgimhVjvtmyqbSnZl8gSu/5aNQkwoK5aPExEmcOe6BOLIRpWgD99W4x+ZPv3fLgm87sQhAJ14OD3y2gSxiH1n10lqNbfOolF+z5I=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SA2PR10MB4650.namprd10.prod.outlook.com (2603:10b6:806:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 16:37:23 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6d2c:be3a:dbc5:6f9e%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 16:37:22 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-debuggers@vger.kernel.org
Subject: Re: [PATCH v2 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
In-Reply-To: <202310270605.GjEqZtAA-lkp@intel.com>
References: <20231025223640.1132047-2-stephen.s.brennan@oracle.com>
 <202310270605.GjEqZtAA-lkp@intel.com>
Date:   Fri, 27 Oct 2023 09:37:21 -0700
Message-ID: <87edhgyqbi.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SA2PR10MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: 88fdaaef-e1eb-4469-cc5f-08dbd70afecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttCfJyzftJenZKRUaUQXqIeTI+vkQW9lk3qBqR4dkDfcNuPLv3nkkWqklpqJMEORBTBbHZ3AGO8VBQ8AKgrf8ibgnuDVSvy0MG92zLORl8ZeFLm1+M4wHeh9Sk63ZZJNvqbWSpHXFoioWgHhuu1L5EYFk77QY/GGU40UJxTCxfbMOZpodPgdCtY6Ku+q4m024QpfopzftcLy1rdj9z+8+917hoHDxJ0F74Wy8FLafBQlAuL0crnGTwF3shbnsA+0+G5PqGuGBmCKieHJY54oSDHPsVBR2WiPkq12NGvEGAAVz58SxoX4eBZ5i76yjnrYCcP0/54jgzHNJXMaRHIlwYmsoI79VvJkU0/PGqK4l+MB/YxoDWqOhr/YwBv3W5rT4h/nEIRaixsZZPOb1Y97nsaHbUn/4FgqtQDRHcMMT6NjrMlNst2drcx8Czi5YVkqijB6g7yuwQY0d5L7jKaelTMdn0aep3kwZIL6f6D/UVghNmvl66PKyyxSdgJnmCr0s+BGRopiz3wpxRVrwOlWybZm2UklvtV3wbh/fA/xzk/N3PwCjoJNITN2/mt7NxR4KKtruBO4cwBmSzGhlhzt8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(83380400001)(4326008)(38100700002)(6512007)(2616005)(86362001)(66476007)(316002)(5660300002)(2906002)(66556008)(8936002)(66946007)(41300700001)(8676002)(110136005)(36756003)(966005)(6486002)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+fwCjjX5dAbkwV/Bm+4LaiJrMnBQGcwzitJ5AMA4btC4cG/DJFvMTNIzqkh2?=
 =?us-ascii?Q?vJg/+QVh1e+ZOIxUscRb/TN2txjYbcW92GfTURlYi3Cv3bwDrwUx+E/zXEzR?=
 =?us-ascii?Q?N9CXsm+dfRd+mlr+JLBdtRmJ7SrRTKQf/fHwHfy7JMpi1bOoJN5sE2tuNdj8?=
 =?us-ascii?Q?XQ6H8jyCBeaE5u5/DrzOLw9mCxodcDk5h0gdJr88sJGLAJYM53pj4Ub1qfJu?=
 =?us-ascii?Q?OXXeKRYZ6nRRENz5S4ojpk5penO8LDuN7mT+Xp3xDHJ8IySj0jnTJQvzc3P/?=
 =?us-ascii?Q?1iqGC4gxOyC/1VJ4ZaZTllBCD2VBTed4amli0zXtGjH/k9BFB9OCQeRY+UWb?=
 =?us-ascii?Q?TaCLW5tp1+XfRxU6y9pktxdJyzY128BJS1ypre5tgKcxHTbAjjwqUmwoITWt?=
 =?us-ascii?Q?fnYk5dMQupSyH8bgVw+E5pHDXbvsdUNH/cX6AzWoi2WmfXrynD5QIBXJN06u?=
 =?us-ascii?Q?Vmrei7pWihOffv0jL+ku3eHfF87B/gQRJmWr0hhBdcc7Rt7Utf+HajOYWof7?=
 =?us-ascii?Q?p9VFF/ZuaZZqM947VnnI2CMfuTMCGklpFAmgC+VSFDbBMFSSgVeLshYTHvCB?=
 =?us-ascii?Q?B8+PHVpYWST7lI+w3xLsmGxnTh/TxtkoWZTnJjzqR6y+8FTBQKS+bY+VCNBb?=
 =?us-ascii?Q?eCrbaENRPPSwhHTy/fl0yM15+crzI7z7z4Y8igoiRhfDnqS9H7Fs7JTSejSU?=
 =?us-ascii?Q?jbcT6jZY74Sk7J/X8bWx56pPXb0RgjfLYgdJ7K3afnsODRLPWfNU1Rn6XHCt?=
 =?us-ascii?Q?M9oNxEJNd5ndxxcDL5Ha8j+RE7+d0TEsNprSkpLNAXHF7EUYVxrVTrstuKEv?=
 =?us-ascii?Q?73HwvIvJVIRQr+oU9yn1KWNgZ2WoYViLvIxEIQOD3ybcdzZZZVcZKBDVgUNJ?=
 =?us-ascii?Q?6ldFn4xLt+QyiThZfvGEX8gPe/CZj6JzhQDwrOXmrdoW/zrvPRAdFZp+gd3m?=
 =?us-ascii?Q?d4pvnlg8hO0fq99KeW7F91WaA/py3WhPVroAIaEdTUmg8eXWzBNHMY/qLBh+?=
 =?us-ascii?Q?eT3K+NbU/8JNXiqncweRvRdRxayBCvDWglmsSx9L76WWbVQ8RpDA4XqOeJ/8?=
 =?us-ascii?Q?f4x8UlXmGDH/WLyv73ITd3e9gzEg3uGOXqVhqXuMXC/lqW0zILIkT/yBBo58?=
 =?us-ascii?Q?GEH4wB3F/kCc4T+KlsQo6g/jJRRqHIYHFd5HsXOTtO0Io7bR1/g1hDi/v3nn?=
 =?us-ascii?Q?y6Y7yQWmlWHbnOiUkz7QomSVjJ/IXF351W/4SdolmubaUbxwOGhF0jxZXqop?=
 =?us-ascii?Q?GzUXTKWjGcbe8zcDuCnznAucKQoDuz4rMMl9zAcHEnCTyz2kIagw/VYwt7ZV?=
 =?us-ascii?Q?PbSNJ2efbUGKFkPsU3Ud/1fXvpOeOEqszq3TgKJTuPnS0ACmC1FxQ6riqcpL?=
 =?us-ascii?Q?tT31W+aX5LU+RHT/QV4aPbQ/VBsiQBUtVQS7MhtXAQk5j+tONT8zlfCHUkG6?=
 =?us-ascii?Q?bymS9fCnerlwsSI6NAKshYeaJh8FWSB3+vnG0jjMU3kfqVoMjtZO/oJ8Zy2D?=
 =?us-ascii?Q?nZ+9+/CtPOMyYWb0hO4psljP7P1IqeTEreCYwu/uSS/stfPk2tGFcntxLFr9?=
 =?us-ascii?Q?qDGFSDebhcyxQzkzeHNI0BdArZ8pZtFJDspS+omU0rKUMjM08tibB9UF+6Gi?=
 =?us-ascii?Q?Ife9RLHqTwZ9lq6FIIqq4qF5wuGFkaZKpPJSDUD39K7+RVF7U95sbmaZ07Kr?=
 =?us-ascii?Q?xrrKzQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: La7uT3lo32Cuaom9rEzPSjeTiskKhUNo3+ksFI1k//Ik65Ua32CHy+KdD9akzG9GCav3+DW2I3QM1SpQXDFs6ZaY+ly7h8t/fPzoQNgYrdFCKd+MrhgocoDBU9BJOWQTfzyMlzyxKaUgnwNIh6+H96AuCmiKXNNxM3XhQHf5b5hO413Z7PwPBSx7u398U1RDfWjiYzfhB5Zio45C9rcd2r55UAWZlqdrA2vgPg5k1EfhQpQUPlkLeEMgnNMlboBg+oJpqINjnudMGlnr8QY0RPUQKsjm8uLihkq3uvs7QJBj2deN/BkSRfewPy3C5f9aAF4BiiMezL9JZq4tnN5n7/uUrMwECgnEmFaqNPPGOZTZ59BzigD8ZwugfbSG8EzSDidXuMApqBJNJ4CUyqLxLD48udZAkJZwCHq85qSvoJ5/9V1vPGXpHE3TTVrbiXKcBZCDshlVKct6AiQsL0wHbS9XzHyNGuaS3IEfpnLACxMNLdubVLeeUa0gLz9EDQuUMg8QJkHzOmJlZk47cBpPLeXBKnADGV/J5pzB3uBoSEF8xAxCx8Nsz96KvGH2RvvxpI0NG/yGBulPx9A/NhAi5QDF06wTu7C9bZdo0PymfAkkqDssMzPjV4lDqjSiQHpvoTHRDUJGje3kOibLNB9gPfYTfyYmn9lafM89Vp63jUx+ghslXvfBJ5x3A/5J9LHZuggXVps2fam6jmAKJGp0KMISxaF9j/EnQTn0hOyODJ/evZBpkIlj+igyRqc/n2cCvsNHmLE5FTujfqW92e+Awbw5Ygv6orw+tvG9cUcnnNz49D2koFxvsvTHSqqQRqwXxEB+YAmv66I0pcoJNSUIjrIr1PkgRWznbb8I4ak/x5GagLSd774Qtv2j4dxdlt55QZZtMAajKqqMIzAr1Eb5mQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fdaaef-e1eb-4469-cc5f-08dbd70afecc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:37:22.8935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEcIXmq5EPiYljvL2VTU2YQWCyRAvP43X4ENe3ECDHDjMBMxJi6AlGNYgFf+zBDbn7JRfGmS9ljyy/mP5rCu0nW+cJU1UFYpjzowM28/UNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_15,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270143
X-Proofpoint-GUID: hVRPky9q_McKqi84aw0YwKAtSEXbFBQp
X-Proofpoint-ORIG-GUID: hVRPky9q_McKqi84aw0YwKAtSEXbFBQp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kernel test robot <lkp@intel.com> writes:
> Hi Stephen,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on arnd-asm-generic/master linus/master v6.6-rc7 next-20231026]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Stephen-Brennan/kernel-config-Introduce-CONFIG_DEBUG_INFO_IKCONFIG/20231026-063844
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> patch link:    https://lore.kernel.org/r/20231025223640.1132047-2-stephen.s.brennan%40oracle.com
> patch subject: [PATCH v2 1/1] kernel/config: Introduce CONFIG_DEBUG_INFO_IKCONFIG
> config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231027/202310270605.GjEqZtAA-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231027/202310270605.GjEqZtAA-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310270605.GjEqZtAA-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    kernel/configs-debug.S: Assembler messages:
>>> kernel/configs-debug.S:17: Error: file not found: kernel/config_data.gz

A silly omission on my part, v3 incoming will fix this.

> vim +17 kernel/configs-debug.S
>
>   > 17		.incbin "kernel/config_data.gz"
>
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
