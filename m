Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749707DE832
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 23:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345464AbjKAWk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 18:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbjKAWk5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 18:40:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0703137;
        Wed,  1 Nov 2023 15:40:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1KvU7r010625;
        Wed, 1 Nov 2023 22:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GI295XeRZ8OT2WXisW2QzvR9pwiSutIXYWeN2ZEZ7f0=;
 b=efswAmhrSnMp+gffY9ucu2TvFy3BhlMyQHYuxzfx79qB7wGqEXwqnNCbGNVnxFSMPxIe
 i4/0JZZmWpjiSBXOGgf/tG2wgMkRF8xUyLRzTxn/IWcHmwXPtvLraecuOs6AxZFrYxLJ
 1kKjkMLJs5Rurwivux97fJ7BEbC59P6HYETXHFjxJdydh6bVFu2rKnXlEkEHz9aZT1q6
 0V5Kk+NgtyJZoLHwroJB8m9y+3RBkpOYbbcvgOYdEe0bkn8YheAWrKlNllMBmvYj+3Ot
 f9SCrZL+hLU/WEolCfFwGAAmBwidBncxM0Q5bp6unH5xbo1CgFsPHHgbu4EYmn0xUFSh Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqe0jxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 22:40:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1M1t3U009075;
        Wed, 1 Nov 2023 22:40:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x7jsja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 22:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIdMfdS+8y327uEgJ/+fild6ppeh2ea55kxPHAH0SOKXl5/rnicqm6/+y99fcKwNTEQU07zelF4GloviYm7/RYch1i+9EWhv1UOtXXGvVOUNMPnEEH5qSjrTytGgN3UU9k/Wz8WhStghUhZVYToOCTNPedsJW5PZfOwHipW1iF5cpAIg2SsdchuEheu+lR8DMYKz6pXFUXOuMqzflF7aQ8gc6+Xllp/ffTTROkeO4Dw+dESo0CuU1dyQL9KENIfjvcL2cu6wS0Nt+bS6gnxJC0BcKNhardUlE/OQ01pOQBDuLWh2lzaJOojblLITbIi2Ov1BrbGmjP77JaIe6tADHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI295XeRZ8OT2WXisW2QzvR9pwiSutIXYWeN2ZEZ7f0=;
 b=i64v7pn5bZHberRLSkqO+1d7cJ+2nQ3GxmM9vOROqMdMdxdu5Vgy5uXXfImT7BwuT9Oo85LBvhwsIrD+qNdIRvceUttKe3aaORp5Gbb2Fx8AuPABUFHvM6ws7mUT587e4hET4jMSfjotpZMxstpQlKCxhqSpZh8cBRX/2EYM1vB23F4KwD0AniKWsJEUADb+2UUpp2XtNvfx5NFSwX5uq0vAZ1CJZp1CTjnKX6bkiRgUkrYPLaqH2/Ygt2oWZhg/n01WF52hSi4ce0Z8aUJuMC81Daz8hwYGN7q/NNbcnjpLFmXQe7JxdXyQ8k3WBr9yKuwndyr9yHk9eeWqnw7cWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI295XeRZ8OT2WXisW2QzvR9pwiSutIXYWeN2ZEZ7f0=;
 b=XjDzmbItqEqZkXGzZ7F6vp+E3ps16eoHFJzB92wLDkGgRIU2EJ7gY+FYzECPhejjRfYJjFb8Sj9QlJEeOhkNb2lsKb7JAXc5bpUewRUIK+4mjlNKN5HEgv9UBSc/xqIO+1gskrb4OSJbkgJy7RAVbme7y1I/Ae4CkRdBn7sB7Rw=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by DS7PR10MB5327.namprd10.prod.outlook.com (2603:10b6:5:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 22:40:31 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ab1:d70:8f78:d876]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ab1:d70:8f78:d876%7]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 22:40:31 +0000
Message-ID: <a1d6a3de-502e-4114-a603-01710e30428e@oracle.com>
Date:   Wed, 1 Nov 2023 16:40:23 -0600
User-Agent: Mozilla Thunderbird
From:   Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: Sharing page tables across processes (mshare)
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, rongwei.wang@linux.alibaba.com,
        Mark Hemment <markhemm@googlemail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <4082bc40-a99a-4b54-91e5-a1b55828d202@oracle.com>
 <1358598e-2c5b-4600-af54-64bf241dc760@redhat.com>
Content-Language: en-US
In-Reply-To: <1358598e-2c5b-4600-af54-64bf241dc760@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|DS7PR10MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad3ee59-14f7-496b-2e4b-08dbdb2b8dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYW/Mft4eVFmItmP49PUKPdRDAJZX1P/WgY8oTpR/XsMZtPPA9AtGRQSamtBqmLaANsDhC9kZwmFQYqaq3GAGlHndqHSVMfK+eGa/QGMfCXc+RivGst2L1MTyYi7UFy1ncs1cxQPV9XsKBLjLF880+tjqSFfmocGiLdHrEHxNAe0CuovM1CTZwzj7SIz91uXAKI3j2IVrAjq1Wxod2pBpaefYz5NStZ4caz6QZeaiBLbdxEh9J4N4R3cIPaqj1gjAMK7M1E0N/jEJo8fLdI0qYymZ62MBAjMnhHn8mzlVRhvgEQJklvv+gWi1MnkFD8odD8OPB18WHEiYGWeZ75JZu0Msmk1bnB7zD1ClbEaLB5QTqsnmjm0BYhxkDpShrUcrVPBDas/gPQbROpNHq7uUwN7YFQ76g17Mnof2ULUtoeG/detVPxuri3G3Q6ZI3XNF37nBm16s4o2korImiZBWDcqkyrswtTVU7aB2Scuq0b7PFmgyXlA7yZOfxQ2Dg09fCYf29nAnxe5ohICIq+MM6+83SSfAakxchSwIe49O1Wx1OVxF/UOPGF7RlJjcqnoJkqMH00ktuc/EKn7SZ8DXlHuCQUZVJZH1eluxNJTVkeRUyP1ZLreKU9axDOgKZmSIwyO2iteWbD8FoL9Cz3Uww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(83380400001)(31686004)(31696002)(86362001)(2616005)(36756003)(2906002)(6512007)(5660300002)(26005)(6506007)(53546011)(41300700001)(6666004)(478600001)(44832011)(6486002)(66899024)(66946007)(8676002)(8936002)(4326008)(54906003)(66476007)(66556008)(316002)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1dRR2hDUUM5SVVCVXVZbkZoR2NWVzFLNE1nYysyQ1JMa0pHenRDWjM0RzFl?=
 =?utf-8?B?VTYwdzRVWWNvOTZwbHFoZDlNK24wTmdnZ3AyQm04Z1Q3V3lkSDBUeEtKUit1?=
 =?utf-8?B?bDFzdy8yS1haOUMrUTZuQ0lFOC9wTE5GMXRwQXY0MW1SendPQTlzTHo0UTI1?=
 =?utf-8?B?VkkzeHJCMEkvcEdYdnY0Y2RhNUJyd1dnamtBRlJuZklFOEFtcmdGU0FnaFRx?=
 =?utf-8?B?SlhPcXIvNU5qc251K2dmOW9RSUtRaVFvb2ZFV1g5R2d1SWVQZXg5NllxdFJy?=
 =?utf-8?B?U01HeU0wYS9VT1I1bE5SMEEzOG9xMTZkVUdoMURhMHZOTDNpeENZd040RlRK?=
 =?utf-8?B?eStUK0I5VFVPVEx2dGpvejJudWhBNGw4bCtzeUtWN2wwMGtTaEZnWWhYYllD?=
 =?utf-8?B?d1hnbFlTR3BFSGxJcHNIellDQUZSaDJQVFUvczdXbTZuVWNkTXFQMFBDRXQ0?=
 =?utf-8?B?Y3paU1lEV2ZPVGtGK1MxcXpWVnNaNHl3L2Rmd1N2MUJuSFp2cHdadkh5OWNU?=
 =?utf-8?B?ZHM0bmwvd2IreElJR1p3dHV3UUluVi9qa2dyRS90Z2JyVms2S0NRNHFyb0dw?=
 =?utf-8?B?bGIzZ2tFUHNrRGZ3djZ1N1hQV1F5c2NXN1NFdXd2bk5tVkh3T0RFaVRvc2sy?=
 =?utf-8?B?dW1Kd0ZoM3BRdHpOSVdiQXB0c2RETHhMaVRIREVaT3gvRXVIZlpyQ3JvdVdo?=
 =?utf-8?B?VGw4OFRka3IreHBmY2hHeEltK2JLOTU4d0lSYWFENDR6YWsrUHd1UUdoTDlF?=
 =?utf-8?B?MWhuc0xEcHk5MGorb3FCdVp5dVl5NnVkcG4xQ2d2TjlzcnVrNmdrZFRWZlc1?=
 =?utf-8?B?eGdLbGJhc2V4RDFETytQSzgzRXpibTlacnJUOVp5aFZVaE9OQjZoRnNGM3pQ?=
 =?utf-8?B?NDBUZGpZTkg0Z284elAyQTNzYTIrV0EyQWE5VExiZHNSMmNFbW1nRTZmRXBw?=
 =?utf-8?B?ZlZQaEdpcmtBK3NkaDFIVjVON3E3aFZWVFJwRFlXVFl0d3p4c0xTVXNYeThm?=
 =?utf-8?B?a2YyQ3B4amtQNEU2QWs5MEZObmJYMEFwNzFPc05SSnlHSVVmN1FEMzd2VXlt?=
 =?utf-8?B?cHBqRld0eVMwN1puY045TkJVRWlNMkNoazFkQzIxNzVKNGxLZUhkOFo1Tndl?=
 =?utf-8?B?eTNEUmRBcTNIMFFENEJwR1FpWHFjVkRlNFBpNnhJQ3ZpQmlPSjJ1SVdCWFUv?=
 =?utf-8?B?RU0rWVc0bFpoR2xGTWszMittRWErZzBEMjVJb0l2K2xFbGtxYWdZdVFtRFlm?=
 =?utf-8?B?bVVHcnhpRmM0UGRUQmdSZ0xWQVltSndibXlXK2QxQ2xIc0VmZ3FMMTlnLzF2?=
 =?utf-8?B?ZitPR0xGeGtBRklUUXUxSW5yeENuWE1udWhDWkxUU2k3OFkzZitMODF1UFhL?=
 =?utf-8?B?bTlqZitCakV0RTRHaENlMVlaV09TOXpQek5ObW1zMjVzdlhkTWJDdUJrVk1Q?=
 =?utf-8?B?YUl2UStQNmJBUTFFaldkSHY0L05JaythWHlyUWFLbXRTaGs5WWdWaEJLdHdT?=
 =?utf-8?B?ZkZXcnZJOUZHL3lzQnM5SEVTenZnc2c1aGlGdFdkbytJQ25UeUFtUzB3SmRv?=
 =?utf-8?B?TE41aUV5TXJhRnE3ZjVjWFRsMTVNSldVWW5UUnlPSzUzdHFyNnd0R1RJMk4r?=
 =?utf-8?B?b1NIYXJUL3JTYzNrdEVlQlExWFVkaHlEMHBpU1JWb2ZQOHd1bmVxZWltMk1N?=
 =?utf-8?B?RE43dzRJSEFiK0QwTW53N3FncTNxTHBHV0N6dHFxNEQ5UUFUTkZoK0s4VlBU?=
 =?utf-8?B?ZEJwOG9DaytRdFR0KzRGUWhvSjF5S2RZWDZINmpGa1VWN3lGQWZJdm1SYmhB?=
 =?utf-8?B?R2xuamw3cEhPL3EvTnNscGNiU3dQZ3UzWGMzamtVTERSQ3AwaVJsc0pIRXAy?=
 =?utf-8?B?UEw3Q3NVMDhYbnhCT3d2WDJQM2JPY3psSTRnVmxmUVU2ZEd2T3VTT1J2WWdN?=
 =?utf-8?B?bFlDT0toTHowRjBocWJ2b1VCOTZMSmZZVnMwSVFoVEczYTgzbWgxb0pUVktz?=
 =?utf-8?B?VVFZVStmMXNybkhqWFBoaHo3OTN5TzVWWG45TzErd2dwT0NucVVqOTJWbTAx?=
 =?utf-8?B?YTJhbkF4dGlBRWlWL1ZZcjdsNkFESXE0eWVDbkN4Y3k0TDRTT21pVnY1Lzh6?=
 =?utf-8?B?ejlKdnNGZlJQUnorVGozRkVIL2srV3cyUWhBRzRIU3dkQ0pMNnZUcXJ6NWRv?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TmtieTg4YytQSURLQmVVSlVleW9QRDN3TkVrZGtIMkNnS251bmtBaDlZblJC?=
 =?utf-8?B?czU0bHhza1gwRk8yQi9OZjVnT1g5Z0FHR3JnYmQxdWVHcmI0aFVCRFNZcjZ3?=
 =?utf-8?B?elU0cGphMm1RMUVBQWJ4K05ORXRIV0ZTejk4eDJUQW1XdlNCV3Q0NkY4Sjh4?=
 =?utf-8?B?WHZyQ0pDRjV3akhpS1BDWTdCaTAyUnRhVDJMUW9McWtBdlJhdTBidklxeTM5?=
 =?utf-8?B?WGxZQVd4d2x6dXZCVUt1NHhOSmFnSmlGUURXUkx0WVFlUHhrdGQrWEhFZml2?=
 =?utf-8?B?RTRiUEpEcDZ2bVJPbVd4ZldzSERmSlEvZjBUR250NGZxZlFJQmcvL3FiU3NJ?=
 =?utf-8?B?ZWU3V3hiR3lPdGVVOVpudzIyNHpyY0dnbG9zbkxxMFdpbTNzY1JIUkx4Qzcx?=
 =?utf-8?B?R2hjUTFudmZoQ0dSQk0yVzNlSUlwMDhHUlZsNHJYYnZUU2VqRThXb0hMWDRY?=
 =?utf-8?B?dHc4Y21yT2Q0dUlnWWFiSTc5ZVAxaDNyU3dHU05pekp0MkdoUFVPb3RxVjd6?=
 =?utf-8?B?eHZ3OEUzRkErS3FJOXB6ODU0M29jNnRieUlLWmxGM2d2akJLYnZ3Umtwajl0?=
 =?utf-8?B?U0dUYWRvUC8zVzMweEhhWkpKVkhQa0h5a2s5NWZYRTM3a29adm5XaTJFS1No?=
 =?utf-8?B?Z282c1NWVFphc3dlUnhGUG5kRWFvL0hjTzRuK2Y5aGFyS0VzZHpNa3BWdnl2?=
 =?utf-8?B?cmRGc3BubjFKSVJKaUhuSzJ6WHJBalhJRzdSYkQ3QzJ0NXBaZXZVMXJ2d01S?=
 =?utf-8?B?VVJnME10WUYzU0JhTDBpRDgvdHZDZVYwcUo1eFlQNytJMkp1ZVhuUTE4TlZt?=
 =?utf-8?B?d3p6R3ZKZGl2Sk5qTC9ZWGZ5bUw5V1dDSkNwaUFpMG9OTjJCWEpJM0RDaU84?=
 =?utf-8?B?Q2cwMFYrZ1pJUndOWkY5d3FCenpxYm9pNDBmS2hUS0pnSjJGVXM2Wms1L0ZT?=
 =?utf-8?B?NUMvZStsQzQ1VEJiWU5NRk1VeER0ZUZkREFCSllIc0lWNElHRkhYQzdUcm1G?=
 =?utf-8?B?dHhHSjEzelYxQzVET1NaZ1R2cmxyV3dVOU9ZSG1ZbmVsT1BJcGdrV1Q4VE5u?=
 =?utf-8?B?UGllaFBMaVY5blRZL01iYlZOcjQ2VjRSOE43YXl6eXEySXhBR3JBcElFQ0JP?=
 =?utf-8?B?NDRhOFFkS0RHWXlDK1VJcUI2YkJZUzl5TC9pVFlNWVRoenFPcW9nSUZZM2JH?=
 =?utf-8?B?bmlrS2tZRTBCK0ZhSEhDOUxOUjF4QTFqNWM4U1hMSTltZXI1d2lFSkducHNR?=
 =?utf-8?Q?R/orLYDKNfXr1Bn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad3ee59-14f7-496b-2e4b-08dbdb2b8dc9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 22:40:31.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MCraryrcf5263tRiqdSqPPPyInp2a2jZ1p4ocurjHjzbP2M6yK1rJf3rVyCjryFSuOuPbEwzmOvtn+CNYx7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5327
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_21,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=743 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010168
X-Proofpoint-ORIG-GUID: RLbgZ1nOSolnlWfpuyxz60HCAHZ7aGcs
X-Proofpoint-GUID: RLbgZ1nOSolnlWfpuyxz60HCAHZ7aGcs
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/1/23 08:02, David Hildenbrand wrote:
> 
>> ----------
>> What next?
>> ----------
>>
>> There were some more discussions on this proposal while I was on
>> leave for a few months. There is enough interest in this feature to
>> continue to refine this. I will refine the code further but before
>> that I want to make sure we have a common understanding of what this
>> feature should do.
> 
> Did you follow-up on the alternatives discussed in a bi-weekly mm session on this topic or is there some other reason 
> you are leaving that out?

I did a poor job of addressing it :) What we are trying to implement here is to allow disjoint processes to share page 
tables AND page protection across all processes. It is not the intent to simply catch a process trying to write to a 
protected page. Mechanism already exists for that. The intent is when page protection is changed for one process, it 
applies instantly to all processes. Using mprotect to catch a change in page protection continues the same problem 
database is experiencing. Database wants to be able to change read/write permissions for terrabytes of data for all 
clients very quickly and simultaneously. Today it requires coordination across 1000s of processes to accomplish that. It 
is slow and impacts database performance significantly. For each process to have to handle a fault/signal whenever page 
protection is changed impacts every process. By sharing same PTE across all processes, any page protection changes apply 
instantly to all processes (there is the TLB shootdown issue but as discussed in the meeting, it can be handled). The 
mshare proposal implements the instant page protection change while bringing in benefits of shared page tables at the 
same time. So the two requirements of this feature are not separable. It is a requirement of the feature to bypass 
per-process vma permissions. Processes that require per-process vma permissions would not use mshare and thus the 
requirement for a process to opt into mshare. Matthew, your thoughts?

Hopefully I understood your suggestion to separate the two requirements correctly. We can discuss it at another 
alignment meeting if that helps.

> 
> To be precise, I raised that both problems should likely be decoupled (sharing of page tables as an optimization, NOT 
> using mprotect to catch write access to pagecache pages). And that page table sharing better remains an implementation 
> detail.
> 
> Sharing of page tables (as learned by hugetlb) can easily be beneficial to other use cases -- for example, multi-process 
> VMs; no need to bring in mshare. There was the concern that it might not always be reasonable to share page tables, so 
> one could just have some kind of hint (madvise? mmap flag?) that it might be reasonable to try sharing page tables. But 
> it would be a pure internal optimization. Just like it is for hugetlb we would unshare as soon as someone does an 
> mprotect() etc. Initially, you could simply ignore any such hint for filesystems that don't support it. Starting with 
> shmem sounds reasonable.
> 
> Write access to pagecache pages (or also read-access?) would ideally be handled on the pagecache level, so you could 
> catch any write (page tables, write(), ... and eventually later read access if required) and either notify someone 
> (uffd-style, just on a fd) or send a signal to the faulting process. That would be a new feature, of course. But we do 
> have writenotify infrastructure in place to catch write access to pagecache pages already, whereby we inform the FS that 
> someone wants to write to a PTE-read-only pagecache page.
> 
> Once you combine both features, you can easily update only a single shared page table when updating the page protection 
> as triggered by the FS/yet-to-be-named-feature and have all processes sharing these page tables see the change in one go.
> 
>>
>> As a result of many discussions, a new distinct version of
>> original proposal has evolved. Which one do we agree to continue
>> forward with - (1) current version which restricts sharing to PMD sized
>> and aligned file mappings only, using just a new mmap flag
>> (MAP_SHARED_PT), or (2) original version that creates an empty page
>> table shared mshare region using msharefs and mmap for arbitrary
>> objects to be mapped into later?

At the meeting Matthew expressed desire to support mapping in any objects in the mshare'd region which makes this 
feature much more versatile. That was the intent of the original proposal which was not fd and MMAP_SHARED_PT based. 
That is (2) above. The current version was largely based upon your suggestion at LSF/MM to restrict this feature to file 
mappings only.

> 
> So far my opinion on this is unchanged: turning an implementation detail (sharing of page tables) into a feature to 
> bypass per-process VMA permissions sounds absolutely bad to me.

I agree if a feature silently bypasses per-process VMA permissions, that is a terrible idea. This is why we have 
explicit opt-in requirement and intent is to bypass per-vma permissions by sharing PTE, as opposed to shared PTE 
bringing in the feature of bypassing per-vma permissions.

> 
> The original concept of mshare certainly sounds interesting, but as discussed a couple of times (LSF/mm), it similarly 
> sounds "dangerous" the way it was originally proposed.
> 
> Having some kind of container that multiple process can mmap (fd?), and *selected* mmap()/mprotect()/ get rerouted to 
> the container could be interesting; but it might be reasonable to then have separate operations to work on such an fd 
> (ioctl), and *not* using mmap()/mprotect() for that. And one might only want to allow to mmap that fd with a superset of 
> all permissions used inside the container (and only MAP_SHARED), and strictly filter what we allow to map into such a 
> container. page table sharing would likely be an implementation detail.
> 
> Just some random thoughts (some of which I previously raised). Probably makes sense to discuss that in a bi-weekly mm 
> meeting (again, this time with you as well).
> 

I appreciate your thoughts and your helping move this discussion forward.

Thanks,
Khalid

