Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13597D42DC
	for <lists+linux-arch@lfdr.de>; Tue, 24 Oct 2023 00:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjJWWpX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Oct 2023 18:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWWpW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2023 18:45:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BCFD6E;
        Mon, 23 Oct 2023 15:45:18 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NMIsVq030408;
        Mon, 23 Oct 2023 22:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=4KZjfSlXosUXoiNhslvFoxC/YVOjeBD0hB6ZCJ4KuvU=;
 b=MAunaOmjz9jVB1JgJcaHFLIMOhTQDSxKxmZb872yPB20Pu5I7WJxwKkzeeSxWbuvXqzh
 iZ6mf7sa1IWozNxxlDAmb0akJgQB2/jtxqhxEtx1kl6OrnqZWexwCx3gJkM654pEsS5U
 m5cqypVC/K0PoME9YY/6/0Jp1KSJzY1i504Wwy+bmzdsfynAlb/bK9dE54LEksEsntU8
 0SfmGtmC6sdPIME+5pdCY42fejXJZct+Qv6JD+huzAXCmCelCYbwB0VlDTsRKT86bF9I
 YCM1H95NC0HUYkkyxlrdoyFbF1pBFqVMAtdxQRys3NFgisVfFmrK0wyjnxqAOzqw6az4 3w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbc83m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 22:44:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39NL5Aco031161;
        Mon, 23 Oct 2023 22:44:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53b3uxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 22:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsfMWf4zolmyYyu5TW5V71kEF2eIliNeA39DeTFdSD7FWBuk1JInvhaMQNWIIXD2Chn4tExuiK9ueFXTwOTTWu5jsO16sxKjS2ZRi+1gHs0RynVeC9iv1uDDY81AvIcFvinNjjXtkRpZY978J0r5dGhXOONL8EifYfrNBkb1ss7J8sOAdeBTw4xDPUNtR1CUefrroKIaa6t7mUSbT1lqYUxaesBGnyoSGVRoi6l3/Tkd3VlSI1TppCGZ7n9Pm2aPtM5uuwuU0Lm9sxjOA3r+2qLOeWpX+agMthHatW5Uh3FApwdBVK/w8dc7UZkiNhmzqDt3oOyERB9sxz626gF8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KZjfSlXosUXoiNhslvFoxC/YVOjeBD0hB6ZCJ4KuvU=;
 b=excaNfngtH+WrcwugjM/QsZEu4zDIgUvKX9+5zhxlOzbLrwUZkX71/jXc0ELTs65/+1T9b8yvAqRKvfbc+Y7ldhkuhr0ZS+joTK8u41Nfywue0IbF3JVUJ4OHGrlP6tmDPokTLg4/R2aNQqkNuE7rb2/lutxG56jO76vw/1ePcTKTfEs7n3Br1PVgBc2kMmeBy8p8ziGfsu+WuWi8mVv40Ng2aix8fzG1ulKn37X+ZzQTi2auK22tPi434wFMxW3F35hUN2fiD0Bo8uUNYyKzgn8rcZelBSsegmAbybDP+Fmzr4i7e+fGuAtirttFenK2TeLOU5sRM3WJvmip3z9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KZjfSlXosUXoiNhslvFoxC/YVOjeBD0hB6ZCJ4KuvU=;
 b=OTzvBnF2Ql3JNUkv/uAT3imk5/TsVCjBDT/EWxpFKZb+iATry8Y39iKkfvM5NU8vPTfPUCij8SeTpVsgG0duDaY2oRVZPpJtw3kH+JPVNRxEeU+u1bQ9rRPPn744ELaSgDUn0KNaKaXKwbWMnAGOZga/AILc4H9BTO85zMctUV8=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by CH3PR10MB7433.namprd10.prod.outlook.com (2603:10b6:610:157::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Mon, 23 Oct
 2023 22:44:38 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ab1:d70:8f78:d876]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ab1:d70:8f78:d876%7]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 22:44:38 +0000
Message-ID: <4082bc40-a99a-4b54-91e5-a1b55828d202@oracle.com>
Date:   Mon, 23 Oct 2023 16:44:29 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, rongwei.wang@linux.alibaba.com,
        Mark Hemment <markhemm@googlemail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Subject: Sharing page tables across processes (mshare)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|CH3PR10MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 4616b85b-167a-4783-e787-08dbd419a35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2lWSyDybP+9+b4d220MfL8FU6bybtXvDULbbvySKj42nbNGd+p/Es7LY4e8IxuUXdZ+rbLzTAOuUhldyX437am+opFfoiG0hlx6sLVNLwItlJlEZ+wAoVpHN+FPsr+3oj82R5bfvLrIlhjZVjQHhFOmyFgrLePb2EWgPEg0EtAZfREcZZw+XS4WizNQpjYbYp7WJISnB74V7e+QMkg8CQXatEBYYzeW3TT/M9vl++UzFMoE2FsWyOetcqPrb/70meV03ir2KHz8Vzu4NkoHX+WU1ckScXcZ0eR8fiszoPL9PjNJiXhmIeJAungQWcf/iP5WfezXkzzvPD8TVDWcGyorQMYCZFcVKwlGZ4xK+v6fHVhWuxLa+uRZMNYekb7S1PgPwDYvSpQ16i46IxF11XMh4IsFEaV/PLHy6mUf9rcdRCmWKn87ciU85vh5QKUGWMvJt5XxWORGShV++ZDs1dQz6+izLpR8AaC0v17uwcuo9R1HxBk5UdkX8SIzg410SLaN7mg7HNt218dwkZiwZ6oY2IO4n/AufP7og73bLBDPEpMgEbTQl67KaxfMc1kUrZSUAt7AkmeoJQW0iowT+xBgBCZOgJl5q7nBw2IrRDGt1Y9MpUFd2IM0Iewoel+pY52IE1tZ0OoDCEVPXovPMHvh+uoRwGIuuvR5sWzLWs3mXAWyRFu4SnmUDNPyvJeN3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(31686004)(6506007)(2616005)(83380400001)(26005)(6666004)(6486002)(478600001)(2906002)(38100700002)(41300700001)(4326008)(31696002)(8676002)(5660300002)(44832011)(110136005)(66946007)(86362001)(36756003)(8936002)(54906003)(66476007)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzY0VmtkNFhZUVVFNnVNZExqcGxmNGZVTGhaZUkvcm5nWlZwOUVyd3A2cEJr?=
 =?utf-8?B?Vm5SYXZXaFJjSVpXYUF4Y2Y3V0NraDFjT0hQUWlqcm81dHBTd1FxUlkzcSta?=
 =?utf-8?B?VDMzWXdzd004WXJjM2IzWGhjelNDRmp0bUVKUWtPbnpKdDZBVExVMEM2ZW5N?=
 =?utf-8?B?UERXOURYUDVZWkxYR20vRXdQdTJHeXQwdGtPTk4vTUpSQVdmQlMwTXUyRkhu?=
 =?utf-8?B?WU5pMCsxSTJSS1RXQmZhQ2l6TVVzdmY4SkJKZ201aVJILzIvdFVUeFJ4M09U?=
 =?utf-8?B?a0VKUXBMZzY2eTdNaGZaaVNQMTczVjc4aTluQWJyY0hlT21KQUhjeXkyUzBi?=
 =?utf-8?B?eVk5TWdUcmJkM3k2VEg4dStBR3J5dGErUDZKcDEzTUlhUmJZNkpEVDJLa1Yv?=
 =?utf-8?B?cUJGZ0xaS2ZSalMwNzIzc0dxOFdvRGM3djIvSlVqNjNyb1d5UWhpTExYRkhq?=
 =?utf-8?B?Wm9QalJVWDhQbDZRYjNneUlaenJsNCtRN1hTd2pkOHZtL0crWHVEM0ZpcnlV?=
 =?utf-8?B?eVg5VGQxRmIwWXU4cXVleVRIUHhOOVdTY3I3RFZsbVgyV1pybGR0MGhsTTZD?=
 =?utf-8?B?UUZqRjUxQlRuaE5kbDBrcmU1aHJTWTJUU0FEMXlOcVUyRERlZ0pheTlHWTU2?=
 =?utf-8?B?K20ybVl5QnRxeUdBS3AyblZVQ2NEb05MTzd2SmgrbUJhL2xCbWVISWJRaFRL?=
 =?utf-8?B?QXdycitJb2tCczlrOEE3MkRXU3ZGUEhuQXdENjZHZEo4ZFhqUmlDMXZUWFZL?=
 =?utf-8?B?dE5sRm1ZbVlrbzY4cGl4TWhyTys2b3RYeFFBdXBOVW1LaGFjWmJZUHhEQUND?=
 =?utf-8?B?SERyWEd6SlZYRkFHUnZvQmNsUmxyUFJQNW5kUitNeHBnR2RjYWI5VEVpejFw?=
 =?utf-8?B?Kzh5TXJtSVBEbitHTTgzS05uWkNydzNZanRaajNkQVF1SHkzT0JVeXUvR213?=
 =?utf-8?B?dnVpLzk3R0dwbnFxWktLRnQ2Rmx2ZzUzZFY0VE9yZW5TOEVjU042QTk0R0ZF?=
 =?utf-8?B?aVZDdi9keUlxZnMzbS9uU216QytXWlBhakRDWFhtZEFyQVkyVGlWUkpLVmVN?=
 =?utf-8?B?WE52K21jSnhleUkyaTRZazhSQWlFM0Y3dkFqbzVSTDRmaHN3UDBzTU4rWUov?=
 =?utf-8?B?cGVKZUNZNStyRnhBYU1wbXV0NkxjMmd2RGllT1U4OExkb0owS0pYKzhSUTBL?=
 =?utf-8?B?bytoYnFZTEl3TnZPUDdQbUd5TThNNS84ejR1eU9qQmpRWUpoWG9nN0xtcEJt?=
 =?utf-8?B?eTlwVHFCd2VVQ1BxU3V1ckgzaGpqcElvcU5TWG9lVVdtSHNydnBTa1hOT0VP?=
 =?utf-8?B?a1ZqQXB0R1VCMHpjQ2hwc0JQNlIxbnNZTVVER01DMXlycW14SVo1SVI0bnlR?=
 =?utf-8?B?TTQ5MHNjb1Y2aFB3ekRoaTlpaEJja1kvbVI3eFFHQTd4NXVFZGg1MU9IdzNF?=
 =?utf-8?B?b1I2bk1hU2EwcGQ1ZElBRU1aOGdaazRCak5lNU1kS2plSDNFaFhUd09nNEpy?=
 =?utf-8?B?MTIrcXpUZzRYV3pQL2RXZWNFV21zRlQrSlNITzZnb1ljWUo4aWlEYW96eGlI?=
 =?utf-8?B?OFR2TFQ0dHEyU2JIQVRwcW5UdVRxL29jd1JnV2hXWGpCZldUT2x1R2paaCtn?=
 =?utf-8?B?UTF2MHhrUlVyQ2FKMkgrWERKT0FmU2xDajE0V2FjV3M0U1R4MW05djgxUSs0?=
 =?utf-8?B?RUNKaFgyaC8wdC9tRDJMSWd5RkVjMkFNWTZ5RitEL3Y2LzdrZU1qZ1hYWGlw?=
 =?utf-8?B?YS83Q1JxU2tMbHZ3Uy9WNEI1WTR5djlVdHFXZFl1ZGRpNk41cFR4bWhEaElR?=
 =?utf-8?B?STlGbnJaU3JaWjJJZCtTT0tMVEVZU0djejJPTWd0UERLTmxxT2pMSzNWc01k?=
 =?utf-8?B?eVFSS0tpT1NxNWpFUkdsYWdVZzBBRStuS3B2c2NTYnV2eCtNelVsV1YvRk5W?=
 =?utf-8?B?a0hLRVpIRWJTUEtoZjZuRDgwSFh4eEEwSytYWGJvN0Z4WVZaTDdnZjdndVEr?=
 =?utf-8?B?cjdGb2tDVTNPcUxxdFBlMzlLVTUwdStWcVpaTHBqaGZpRDMzczRJM0E1YjBj?=
 =?utf-8?B?V1E1NS90YVBHYlhHUkRnZWxHOVFNV0FHbkhVRXFSZ0NWajU5Yk9ETTRtZlND?=
 =?utf-8?B?MTJwdkt4NG1xNUplTXdoYmxSNDh0UDNtR2dmcjBmMmdjeHc1aWM5MDBDaVVi?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cW92T05QbWY1ZFJ3NzJXZzVPTDRBbEF4TTkwOHBuWVNmeGVPZUYxWitHQ2FM?=
 =?utf-8?B?TXlOLzRoUFIrazd2YmcxeHFFdVNRSmFqV25KWkdEeUxDVDVIdWFvZ0NVZWZ6?=
 =?utf-8?B?bTZVMVQ0K3hPRjY0dVFaVnJ1Mzd6dXA1aTkzWUNJZC9ReWRqMW1Tb3FIeVdU?=
 =?utf-8?B?SXZuNFJFZDU4RGRHcy8wUjlxSjNjQ29OZ0Mwbmd0blAydDQyRG1iZEFiTXl5?=
 =?utf-8?B?QTM5bkoxZEVKZEcvdUhaWnd0V2RIQjEyUmVxbEdkWlVJemVMVzBVN1dVTndY?=
 =?utf-8?B?Wm12UkdZeFV3MzZ3VHBwOXA4em5WK29qdjg2Vk1iQys1SlZqL0JUVUlRdUtu?=
 =?utf-8?B?Yi9lSHVyK0F3SmMvRzZjK1kwYnA4aHg1UkV4NFJ5c3plK2xZcU91MXM4NGdo?=
 =?utf-8?B?REdJUzkxRTBsWEltZVp2T01xWEUxT3FYcmFxSUNxWGlMWThDUk0yVE5OdS9N?=
 =?utf-8?B?a2pHZzhQL3dySXZFNHVYRG5lRTFUdWtTb1p3UXJ2cThnWVBCZHAyVzJSSkxX?=
 =?utf-8?B?b2xzaWpBMlVHWEFkMXVHOExrbWxNeHRiT0NRZVN3OWlyb3FIbmhWUUNSTVQy?=
 =?utf-8?B?RlpQeCtwd0EvSkVQd3lncVo3TjMvOWxCeUdlTDgyTWNYSHdDY053S1VyWVVO?=
 =?utf-8?B?QnY5WlNvWlhQUGFsbDN5VCtoR1BFMUg4d1NQem1OeUJsRWl3YTVFdkw0VDJZ?=
 =?utf-8?B?Tno4eC9TT01ZUHFsb1pDTTBYWG8vY25FeHhNYk8yb3BBN0VDZTloMU9KSUQv?=
 =?utf-8?B?cU1oRFFTN3ptRGl4SUlHZW9tMXBJalJ1TzRQNVNGNTdCendDMFpvZ0FLQUNE?=
 =?utf-8?B?UmhUMFRVWHdpd3BqaE00WXorR04yWDhtNlB2UVZjeGxieGVHdEZEV0E0V1F4?=
 =?utf-8?B?aXVYdXljbDNIbnQ0ZVdLODJVNVlEUWZpUWduTm5taWpzOHBRczZOamo2RVdk?=
 =?utf-8?B?L3A5YkpDcTJUMTZMMGFPTnRERlNLRE1wVW1WZmpSU2czdnhnakk4NGg1WFlD?=
 =?utf-8?B?QTBxRDlvWVBTcVNCcG10VTVKYy9RZ1ZyZHZGVFVnSnZlSklDSlVvbUVxOXh4?=
 =?utf-8?B?VmV0NGpuU24yc3JYUTFPcUJKMTBVN0tkOHltV3FNanl4SEZ0TmtBZ2tNUXdz?=
 =?utf-8?B?T2p0cm56dkZMQWNEVHJvTUE5bGxCbG85Vk5iVCt1WGpIRXF3dGx2VEY5RWhQ?=
 =?utf-8?B?K0tjRkZ2SmJEMVpKTHBCNEF6UzFFTVlrTXdUamJ5Zjg4SHBYR09lYW5uNGlp?=
 =?utf-8?Q?aEH40hGdCAkvRGY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4616b85b-167a-4783-e787-08dbd419a35d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 22:44:38.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5guIGuyd9qXz4OIyAtrof8HjB/X3SKgK/HJMq0m0+zyFKnhdfQHjR80S78n4Qie0X/Lf5qyT2931Bd/kou9Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230200
X-Proofpoint-GUID: 34fP7oTbK73ZCZnW-NVXtAow5d0HGzN4
X-Proofpoint-ORIG-GUID: 34fP7oTbK73ZCZnW-NVXtAow5d0HGzN4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Threads of a process share address space and page tables that allows for
two key advantages:

1. Amount of memory required for PTEs to map physical pages stays low
even when large number of threads share the same pages since PTEs are
shared across threads.

2. Page protection attributes are shared across threads and a change
of attributes applies immediately to every thread without any overhead
of coordinating protection bit changes across threads.

These advantages no longer apply when unrelated processes share pages.
Some applications can require 1000s of processes that all access the
same set of data on shared pages. For instance, a database server may
map in a large chunk of database into memory to provide fast access to
data to the clients using buffer cache. Server may launch new processes
to provide services to new clients connecting to the shared database.
Each new process will map in the shared database pages. When the PTEs
for mapping in shared pages are not shared across processes, each
process will consume some memory to store these PTEs. On x86_64, each
page requires a PTE that is only 8 bytes long which is very small
compared to the 4K page size. When 2000 processes map the same page in
their address space, each one of them requires 8 bytes for its PTE and
together that adds up to 8K of memory just to hold the PTEs for one 4K
page. On a database server with 300GB SGA, a system crash was seen with
out-of-memory condition when 1500+ clients tried to share this SGA even
though the system had 512GB of memory. On this server, in the worst case
scenario of all 1500 processes mapping every page from SGA would have
required 878GB+ for just the PTEs. If these PTEs could be shared, amount
of memory saved is very significant.

When PTEs are not shared between processes, each process ends up with
its own set of protection bits for each shared page. Database servers
often need to change protection bits for pages as they manipulate and
update data in the database. When changing page protection for a shared
page, all PTEs across all processes that have mapped the shared page in
need to be updated to ensure data integrity. To accomplish this, the
process making the initial change to protection bits sends messages to
every process sharing that page. All processes then block any access to
that page, make the appropriate change to protection bits, and send a
confirmation back.  To ensure data consistency, access to shared page
can be resumed when all processes have acknowledged the change. This is
a disruptive and expensive coordination process. If PTEs were shared
across processes, a change to page protection for a shared PTE becomes
applicable to all processes instantly with no coordination required to
ensure consistency. Changing protection bits across all processes
sharing database pages is a common enough operation on Oracle databases
that the cost is significant and cost goes up with the number of clients.

This is a proposal to extend the same model of page table sharing for
threads across processes. This will allow processes to tap into the
same benefits that threads get from shared page tables,

Sharing page tables across processes opens their address spaces to each
other and thus must be done carefully. This proposal suggests sharing
PTEs across processes that trust each other and have explicitly agreed
to share page tables. The proposal is to add a new flag to mmap() call -
MAP_SHARED_PT.  This flag can be specified along with MAP_SHARED by a
process to hint to kernel that it wishes to share page table entries
for this file mapping mmap region with other processes. Any other process
that mmaps the same file with MAP_SHARED_PT flag can then share the same
page table entries. Besides specifying MAP_SHARED_PT flag, the processe
must map the files at a PMD aligned address with a size that is a
multiple of PMD size and at the same virtual addresses. NOTE: This
last requirement of same virtual addresses can possibly be relaxed if
that is the consensus.

When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
is created to hold the shared page tables. Host mm struct is not
attached to a process. Start and size of host mm are set to the
start and size of the mmap region and a VMA covering this range is
also added to host mm struct. Existing page table entries from the
process that creates the mapping are copied over to the host mm
struct. All processes mapping this shared region are considered
guest processes. When a guest process mmap's the shared region, a vm
flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
flag is found, its corresponding PMD is updated with the PMD from
host mm struct so the PMD will point to the page tables in host mm
struct.  When a new PTE is created, it is created in the host mm struct
page tables and the PMD in guest mm points to the same PTEs.


--------------------------
Evolution of this proposal
--------------------------

The original proposal -
<https://lore.kernel.org/lkml/cover.1642526745.git.khalid.aziz@oracle.com/>,
was for an mshare() system call that a donor process calls to create
an empty mshare'd region. This shared region is pgdir aligned and
multiple of pgdir size. Each mshare'd region creates a corresponding
file under /sys/fs/mshare which can be read to get information on
the region.  Once an empty region has been created, any objects can
be mapped into this region and page tables for those objects will be
shared.  Snippet of the code that a donor process would run looks
like below:

         addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
                         MAP_SHARED | MAP_ANONYMOUS, 0, 0);
         if (addr == MAP_FAILED)
                 perror("ERROR: mmap failed");

         err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
			GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
         if (err < 0) {
                 perror("mshare() syscall failed");
                 exit(1);
         }

         strncpy(addr, "Some random shared text",
			sizeof("Some random shared text"));


Snippet of code that a consumer process would execute looks like:

         fd = open("testregion", O_RDONLY);
         if (fd < 0) {
                 perror("open failed");
                 exit(1);
         }

         if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
                 printf("INFO: %ld bytes shared at addr %lx \n",
				mshare_info[1], mshare_info[0]);
         else
                 perror("read failed");

         close(fd);

         addr = (char *)mshare_info[0];
         err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
			mshare_info[1], O_RDWR, 600);
         if (err < 0) {
                 perror("mshare() syscall failed");
                 exit(1);
         }

         printf("Guest mmap at %px:\n", addr);
         printf("%s\n", addr);
	printf("\nDone\n");

         err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
         if (err < 0) {
                 perror("mshare_unlink() failed");
                 exit(1);
         }


This proposal evolved into completely file and mmap based API -
<https://lore.kernel.org/lkml/cover.1656531090.git.khalid.aziz@oracle.com/>.
This new API looks like below:

1. Mount msharefs on /sys/fs/mshare -
	mount -t msharefs msharefs /sys/fs/mshare

2. mshare regions have alignment and size requirements. Start
    address for the region must be aligned to an address boundary and
    be a multiple of fixed size. This alignment and size requirement
    can be obtained by reading the file /sys/fs/mshare/mshare_info
    which returns a number in text format. mshare regions must be
    aligned to this boundary and be a multiple of this size.

3. For the process creating mshare region:
	a. Create a file on /sys/fs/mshare, for example -
		fd = open("/sys/fs/mshare/shareme",
				O_RDWR|O_CREAT|O_EXCL, 0600);
	
	b. mmap this file to establish starting address and size -
		mmap((void *)TB(2), BUF_SIZE, PROT_READ | PROT_WRITE,
                         MAP_SHARED, fd, 0);

	c. Write and read to mshared region normally.

4. For processes attaching to mshare'd region:
	a. Open the file on msharefs, for example -
		fd = open("/sys/fs/mshare/shareme", O_RDWR);

	b. Get information about mshare'd region from the file:
		struct mshare_info {
			unsigned long start;
			unsigned long size;
		} m_info;

		read(fd, &m_info, sizeof(m_info));
	
	c. mmap the mshare'd region -
		mmap(m_info.start, m_info.size,
			PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

5. To delete the mshare region -
		unlink("/sys/fs/mshare/shareme");



Further discussions over mailing lists and LSF/MM resulted in eliminating
msharefs and making this entirely mmap based -
<https://lore.kernel.org/lkml/cover.1682453344.git.khalid.aziz@oracle.com/>.
With this change, if two processes map the same file with same
size, PMD aligned address, same virtual address and both specify
MAP_SHARED_PT flag, they start sharing PTEs for the file mapping.
These changes eliminate support for any arbitrary objects being
mapped in mshare'd region. The last implementation required sharing
minimum PMD sized chunks across processes. These changes were
significant enough to make this proposal distinct enough for me to
use a new name - ptshare.


----------
What next?
----------

There were some more discussions on this proposal while I was on
leave for a few months. There is enough interest in this feature to
continue to refine this. I will refine the code further but before
that I want to make sure we have a common understanding of what this
feature should do.

As a result of many discussions, a new distinct version of
original proposal has evolved. Which one do we agree to continue
forward with - (1) current version which restricts sharing to PMD sized
and aligned file mappings only, using just a new mmap flag
(MAP_SHARED_PT), or (2) original version that creates an empty page
table shared mshare region using msharefs and mmap for arbitrary
objects to be mapped into later?

Thanks,
Khalid
