Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02F167E72F
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 14:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjA0N52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 08:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjA0N5W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 08:57:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C07EFD9;
        Fri, 27 Jan 2023 05:57:12 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9T63N011579;
        Fri, 27 Jan 2023 13:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tvUYrK6dVz/aL+luVFm1k4aNwv7Yo2HH3bRsWA0AL7E=;
 b=OJiH0KPMD2/2OaMGQFEwEFf+d3WYDWUH/2R04+boVA8FycdlEApLNxnrDabceJyUHehq
 eJYRVsoPDcuh3+m6ugvw2MQ3f0eESVLmcudhPHE3piMmup5WPdQIp9y92ZjHeOZnk8op
 usxSQsiLgvLCB5Dt9BrywoKwLSUXDrYouFERyrzFch+hFmGbGYiMuF61mlE1Nqj97S1i
 i6iFMOOy9DzJqLzpzoa9Q5UbWqDQlookzZjta9gRiB7qQOqDiEPP+Q5pI9F7fY59Ytw0
 pHGiE8ak4Pc+N/vHowqqQSl+AoYVqUGGff4Kw3K6MWH/tDxW3SWnMz+4vfXj9MvluRmK Dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ku4psx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 13:56:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30RDi47K010616;
        Fri, 27 Jan 2023 13:56:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g97uc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 13:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogfGXTD7Ch6dzHmQSLXPrTrsUgiF69UskzB3MqaiCepD4N0cjDL7/OSpjD3s2CHsRsqMH5K/EycbyP6/27Onos+HoRc4mVHQdqqG+Hh2qEzPxlEYR4LB8f0+eZoNudPHyQ8C750KfqNdbTmt3o6sfMfiI/imGfXdoEC9pDuOhbsZ+lGPT1DQsz8Te2FnsF79GLPMhHQpyb8RPCQEpOCFH+pFX7A6bXyBcQPjUDse7tahMgofIV13O3/yqC/0fq4bTD4sF0qGUy95il5lD7S7LHRBbmieFuyWRESWQ1SZS0AB2nqdTuVj+eogKU6O1tjiBLcu0T+V2fI1/dLK9B/MoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvUYrK6dVz/aL+luVFm1k4aNwv7Yo2HH3bRsWA0AL7E=;
 b=ai4revgFzATgAqZeBSaByt6pX9jCy9E3PShBZDmyvjIpO+UvE083SJnzDUWnTlScbF7OreeF/l9eo2MT2/UhHwdwju4hZm/yxrXnL6bqHJX30yO0+Qbcnm2m5367bihdInlFJP43NCaBepuRBKBxpw7VuCM3OBcFeC75vpZmOuIRB65V2jrjDpmkj5sV+jqyBCBLSmDHftR656hEhPjEahYLKs1o6kYQcQtasXx2fRzCmh450zQG/pZEUP+NENrLFNslNz4anqOHSzt8KC0Joa8hLkNIuHGJyJv4lIdL24yFqTinSHgj7dDA+YNzX+L3XGgl1NuIP5UIGYelMat93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvUYrK6dVz/aL+luVFm1k4aNwv7Yo2HH3bRsWA0AL7E=;
 b=e0nYbGT5ne7pY+GmBI7vSdVqhV0iZKBxC1S1/D0lj6yVF0uni+WK6tSCXdOZosxZMR5f70Yt2t9c4KjDQzwCVqsLvNAqb/Laqbq8Uv6J5e+PeOgripWu3JfcqRZNn5f6NeFGBNOxS1hSQwDZVpAklOE1Gzwl9f2ZRfxOYVMjH2U=
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by DS0PR10MB6029.namprd10.prod.outlook.com (2603:10b6:8:cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 13:56:53 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::f37e:ad45:7d9e:d84d]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::f37e:ad45:7d9e:d84d%6]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 13:56:53 +0000
Date:   Fri, 27 Jan 2023 07:56:47 -0600
From:   Tom Saeger <tom.saeger@oracle.com>
To:     akpm@linux-foundation.org
Cc:     akpm@linux-foundation.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Dennis Gilmore <dennis@ausil.us>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        torvalds@linux-foundation.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] sh: define RUNTIME_DISCARD_EXIT
Message-ID: <20230127135647.dzus6jmin53aq6nv@oracle.com>
References: <9166a8abdc0f979e50377e61780a4bba1dfa2f52.1674518464.git.tom.saeger@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9166a8abdc0f979e50377e61780a4bba1dfa2f52.1674518464.git.tom.saeger@oracle.com>
X-ClientProxiedBy: SA9PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:806:22::19) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:EE_|DS0PR10MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 5806792c-43eb-4f3f-cbbd-08db006e5814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMuDzzKnyexW5CdSCxGhecDsi3u7NiO2QHUR6ZiBD18nanz/Alv0ingZO0Fx3OrC8A3xbka8mHwfOc3oYBRkM2hzaOFXKkw5T/jsqQXnF4QTz1EnPF4uWyFkVcyRRSdtXXEPlb/WwO9yRbiLUnPfbJ5ntdTq9RqAt3MPKD87XU/8yyPIFQPNy4Qsem5myllxmCqMUflYw0X6lXq6Ky/fgI1KjSHTD9klyk/fU3HczoKj6vJJBxpxQcsTdPQgG8Gl2btd/6HYXHPgaOKdOt1XYwpulJPKNncjEAszXSFAhTmhGG0hOdLjlq+7OIX6SJLVYMEs2jFJ8YhxiKcGQMMrQ/bUbt9TLqX53JwROMrqdcXkQKrYLWudVTnBGUxIgdPsxfRnDI0WaMyNOWFBjvB6zxM9Lf6Q51piugeH29VgcioSB2gpHfGTKqZHud9JyT4UPSrzTzx2BwKqdTLEWFwyxbnSYrreHRG2A67FHGNw044Mi3C2os5gjbAViSdqIAGiB/mCoRsBDyZVDbN8A1gNjHW5UEp/wl8GYo1OxtW9a/oqO1MYuevqOvOHD0+CjXlPyG8BISVEUxhaTFDuh1ayzl4VE3YvojAA9ktQqjkmmHNKva/0kr811MHzX9ie27mRJzPbqJOpyCABIgPg35TlWd4Q4ddjERV4+lJ6iOYUmEhuMjU7W9MdkS1+Tsf/aDds+y+r3T7OYQxQyNOOChezqax7f1Klbzry6DEdn8UPO5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199018)(66556008)(66946007)(4326008)(66476007)(6916009)(8676002)(66899018)(1076003)(2616005)(41300700001)(38100700002)(6512007)(6506007)(6666004)(8936002)(186003)(26005)(478600001)(966005)(316002)(6486002)(44832011)(5660300002)(2906002)(54906003)(36756003)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERLSFJndHFZWS9mbDIvK2QxMW0xVDlLMkgyWFo2a25HbU0wZFR4eGNTMmtq?=
 =?utf-8?B?cXRBL1NEZXN4MVlOR1AwbnF5UjBNQklvU2VEN1IyWDRMeWtWM3U5U2tQd0kr?=
 =?utf-8?B?YmxpVVhnd1ZOcnFZbmx6U3Vhd3hYRHBEK1lMZlFqUlhqYmxmUDR1d3VYUXZZ?=
 =?utf-8?B?blpPbUpVNFVnTGFtZThBS1VBakhlYjVBU3B0a2pJcUlKczVVM3JqdjlMQzF0?=
 =?utf-8?B?SGJDRVhQbkpSWGYzMXFrQi9hY2g5NUdLNG9qQjV6a2xSbG9zREVDNVFqT0k4?=
 =?utf-8?B?NC9DOTc4a0V2LzRyYWpERHZqUnVRZTVocVY4a3pQZGt2ZTgxZk5nTGJIVEhM?=
 =?utf-8?B?S2oyMzFqTUdCYStTYytIeHA2N0x3OGxORzZ6MzhGdVJzWHZibFpDWHlCS1NX?=
 =?utf-8?B?QU5pR3BrdjVpL09HUVhNWmNGUTFYUFFUbFh2UTVPQjg3Wm51Q1cySzRQem9n?=
 =?utf-8?B?MjZySGlOdjVTVTcwM0llMjJSRXdLMTc3NjFzRGdQbjlZVk5tZHloeTlEQnI1?=
 =?utf-8?B?cENoL054aE9HZ0dPdFZDSE9OaGdHK2FkQ3R4YnB1dWNaVjZQNS9Pd0gxMTJr?=
 =?utf-8?B?VjQ1bFlRZVZOUmllSWhubnVVcDZqSCtVOTZJL2xFRTVKTTFKVkxoME1YSm81?=
 =?utf-8?B?alZDM0hFNXlYV0gvTDduZ2Z1Uk9rYjU4UnVqM2oyWTlDUm1TdnpocFErUHF6?=
 =?utf-8?B?VzhyNUM3ZWRVb0VpY056dk9UOGp6TXUwVWZvWWgzcy95ejVBWDUzNUdOaDJC?=
 =?utf-8?B?azVXVUFPS1ZLajFzbmNpYmU4M0x6di8yMUlLalprMENPbjJFRkovek9xNEln?=
 =?utf-8?B?QTdDcWtVclYzdXhibVF3ZFlFaTUxSGJnK2ZqeUYvaTBBaFJVZVhkOXZ5TzRn?=
 =?utf-8?B?ZytHNmNjME1MMEVMMDhmK2Y4UDh6QlhvMGJXVEtQM2pibGhkS0lFazk4M0Zv?=
 =?utf-8?B?TUtmWCtlU21BZDdKNytjTlFLbmFKemdzTStQKzBrdU56cU9BajFKT1cyRzIv?=
 =?utf-8?B?aUlsamh5akNrbllTZUtER283NGxtS2N5UWxhaWFQOFRiQnNVbkx4aUlnclBs?=
 =?utf-8?B?bjRUb2RrVEJMVUUySGpwUmUyQUpKV2xXWkVkWDYzMVp2QmN4SGpuMnhjdHdG?=
 =?utf-8?B?RkNycXNtMVh1aHBRalQ4NkdWMFQySnhISm9VQWdrY2o2NDNMc0ZqczB1a1Rp?=
 =?utf-8?B?eS9MNENKcjJleUxUQ1NzZjh4RWJCbWc2S1hJcldRbEhDOU4rektsTmk5SEFj?=
 =?utf-8?B?K2JoL1d2UTZvQTM3ZDQ5MGFodWVKbDB2WG1vYnc4bEQvSk5ISUR5eHRNTnhz?=
 =?utf-8?B?VXZ4bE52SkF6VFFwNGlQV203NWRvN1RlTktab0sySWJCSE4yQmM1bm9yUVVy?=
 =?utf-8?B?bFVjb0xsTWNveDlNSDdVdW5nSVc1a2VlNERXRkVROG45V0N2T2RTaEpzK3BE?=
 =?utf-8?B?TG41UXV1SkZGN2ZCTnZIVHFuMU9DeFBoQ0FaZEl2WDZJd0lYemhpbUYxUy9m?=
 =?utf-8?B?dWU2cU4walFpNVVObTJuOHJaU1lNT2Fhc3dmRTNMRE1MTTkreFV2bTNlTDl2?=
 =?utf-8?B?MlFhR0RpUlpMQU9iUHV6R05LWTlxRld2OGtKUjZIVVZGZm90RUtpd2w4NzV1?=
 =?utf-8?B?TmVvVlp3cVFIeDlOeVBiS3VCYmdlUXdqaXAyQUdrekNJZGRxaXZMN1FjK1dL?=
 =?utf-8?B?MGRGUHRndE90U3FZM0phajNDVW55NEw1WU5Eb2xva2F3dnJTWDBiVEJRWDg0?=
 =?utf-8?B?aHpxVkw1MDhsNE9mMjZJQXhRcndZeStzMnFKbE5tZzBTa05PUnBPbGZsMDZP?=
 =?utf-8?B?U3NCcHp6czhVZmRUQmkyZjQ4TU1UN0pFR2cwRytnZUt2ay9Ud2Y3S1VlVDhl?=
 =?utf-8?B?M21zWVVPOS8wTGE1aEUvRVBDR3JhS0hQT1RVTmZyMFh5ZGF0Q3cwb2RiWGR3?=
 =?utf-8?B?aDg4MEthSTVCZjdxTE45alpRLzBmTDZVdXhsU2NsaEQrTTA4UnpyNnNZam10?=
 =?utf-8?B?UXhvVHIzSVdoNmhqbHNVamNVV2x4M3UvOGNTMEVHclVXOC9Hc1FsbmJLd2Np?=
 =?utf-8?B?WG85WGkxSmNOK2tpS0NsUWFFVWxiZDFDandCU1JLTFdEckdrcEZKMUZMazJO?=
 =?utf-8?Q?u49HuwfFhUQljEy4xy5EZWg+U?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dTZ6cmdPa1o5MlhzNU16Smx4QVV0SzVvN1AyYkorV1E4eXBLdmsxQjI1bmQ1?=
 =?utf-8?B?VFl6TEhKSUs0bmQ3S1BEc3FFY3EvNXhDMlpmSmM5a2s2TTRUbHRxOGoxaG5Z?=
 =?utf-8?B?NURGQXJZY0NKN2c5cnUwYkU4WEtPMTVHTldWNndaZUJCalhibi94SndoOUFL?=
 =?utf-8?B?T0ZDZUJXRG9jeVNOVVZyaERROTNOYnRsei9KK3I2dldNVDJhTmNOVW1hd0Q3?=
 =?utf-8?B?OGpUZnk2NndVemxYRkVwUW5vRys0SlBmNmZKMHhMNDlrL3lSMFNXbC9USTV3?=
 =?utf-8?B?aHlhMmJpcUFUYnZYVGhydnBDbkp4NytSZ042UlNCWTZTc1RvUXliNkFWYXAr?=
 =?utf-8?B?OE45ZllNc1hOUy8zL2d4eU5WNVh6cmxyRkxCSHdhUit5RmUvdVNBa3V1R1h2?=
 =?utf-8?B?Q29RNllwMVVaY0VlRmc5cDNzcDl4MHY5TnZ2R1dvMEhXTXlBVGFFMVZGa0w4?=
 =?utf-8?B?dldmY3dGbW9hUHQvSFFiVUJpdkRUWUh5SDQwTmUwVXdXTGkxbVVDVEZEUzdt?=
 =?utf-8?B?UHIzS3c3WE52R0JmUkZuaGhJcXB4d2puclU5ZTV5bHhuSm1qU2J3UW9QaGhG?=
 =?utf-8?B?Vkdkai9nNmdLS3ZFZ0twSHVGYjZzK2FBdVZxZmNBUDM4ck9jc2xnR0R5b1ht?=
 =?utf-8?B?QUlYdm1TeHBPdzJneGtlakMxdUxBUzl2SUlVZUMwSFdPMlBDMUVZSmU3Mm9r?=
 =?utf-8?B?bldSWE1yZks2NkpYaHo5SUI3NmRwS2xVd3lOSDk5VWg5aGluaEEwM0xhaXdk?=
 =?utf-8?B?NFROWXo0M1M2TEF3YmR0NWlTOFBXK0hKSDF3eUNIWGZpbmZTUFpIVkZtbStH?=
 =?utf-8?B?aUZSSlZPTGY0WlVOc0g5NSttMjlTc3Z5YVZTL0Uxd2pIb0xFelRhWEdGVHZw?=
 =?utf-8?B?K3c4cE1najFRN2hPblpiQXlGOTNicmNaaVdSblhxYWxzZjM2NXVkMFBQYXhQ?=
 =?utf-8?B?QXQ1VG54YXc5eWR1UzRWMHE1VmV6ZWlabUd5VmRZQTQ3VDlTeFRJV2N1S2p6?=
 =?utf-8?B?M0p4Um0wRW5oMXdFM05WbGF3eTI0QjJ0SkIvdm95ZHlNUWJRMXVmRmpsK0hE?=
 =?utf-8?B?VjVpOE9hdjJ2dis5RWxxU0VtaGgraDhWL2c4RmJzUHRnUmR1WGF6Y0pIYmFY?=
 =?utf-8?B?SGdIanpoZkhoWG5tNnBXQlNuMjFxVmdIalNOOURPR0h3bndJN0N5bXIyU0V5?=
 =?utf-8?B?T1VFTlZpbDNrT2VVNk5ncEg4VTBuandUWHFCbUkzSnRyWUQ3QTY4TVRhLytv?=
 =?utf-8?B?dGR0eW0zTVpGMWJqRzJ5MnV0YWZaM0pCUmNMSUIxZGlJbVJhRzF2OHFlbER1?=
 =?utf-8?B?cjRRcU5kcXd3b0o4QUl2SUF3U3Z2b0I5UmxoNkc2ZTV4RVVzcEdnYnhra0NR?=
 =?utf-8?B?WjROeHkrenN4MWhKT01tZ2taUEl5WTd4bzUxVTBlK002WHllMnl1VGxVdmFa?=
 =?utf-8?B?TFlndGhTWk43WU1md3E4bkR3MVNiQ21vdVJWWHFoejl6R1hsa3pIaXdrZUJE?=
 =?utf-8?Q?/nEqZo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5806792c-43eb-4f3f-cbbd-08db006e5814
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 13:56:53.3467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBAnheZAJpoW0GZZB2SOqH2PH7ArQN+bc0PrGe9TrSzKp6cDtIDfNa6sl1ZGHec3WLctDSQdtkVw6cmoyDwKaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_08,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270132
X-Proofpoint-GUID: AqQoFCN8ZRDrXZs5C0lOHpnd1qia5Z2F
X-Proofpoint-ORIG-GUID: AqQoFCN8ZRDrXZs5C0lOHpnd1qia5Z2F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 23, 2023 at 05:09:35PM -0700, Tom Saeger wrote:
> sh vmlinux fails to link with GNU ld < 2.40 (likely < 2.36) since
> commit 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv").
> 
> This is similar to fixes for powerpc and s390:
> commit 4b9880dbf3bd ("powerpc/vmlinux.lds: Define RUNTIME_DISCARD_EXIT").
> commit a494398bde27 ("s390: define RUNTIME_DISCARD_EXIT to fix link error
> with GNU ld < 2.36").
> 
>   $ sh4-linux-gnu-ld --version | head -n1
>   GNU ld (GNU Binutils for Debian) 2.35.2
> 
>   $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu- microdev_defconfig
>   $ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu-
> 
>   `.exit.text' referenced in section `__bug_table' of crypto/algboss.o:
>   defined in discarded section `.exit.text' of crypto/algboss.o
>   `.exit.text' referenced in section `__bug_table' of
>   drivers/char/hw_random/core.o: defined in discarded section
>   `.exit.text' of drivers/char/hw_random/core.o
>   make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
>   make[1]: *** [Makefile:1252: vmlinux] Error 2
> 
> arch/sh/kernel/vmlinux.lds.S keeps EXIT_TEXT:
> 
> 	/*
> 	 * .exit.text is discarded at runtime, not link time, to deal with
> 	 * references from __bug_table
> 	 */
> 	.exit.text : AT(ADDR(.exit.text)) { EXIT_TEXT }
> 
> However, EXIT_TEXT is thrown away by
> DISCARD(include/asm-generic/vmlinux.lds.h) because
> sh does not define RUNTIME_DISCARD_EXIT.
> 
> GNU ld 2.40 does not have this issue and builds fine.
> This corresponds with Masahiro's comments in a494398bde27:
> "Nathan [Chancellor] also found that binutils
> commit 21401fc7bf67 ("Duplicate output sections in scripts") cured this
> issue, so we cannot reproduce it with binutils 2.36+, but it is better
> to not rely on it."
> 
> Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
> Link: https://lore.kernel.org/all/Y7Jal56f6UBh1abE@dev-arch.thelio-3990X/
> Link: https://lore.kernel.org/all/20230123194218.47ssfzhrpnv3xfez@oracle.com/
> Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
> ---
> 
> This may be moot given sh might be soon removed:
> https://lore.kernel.org/all/20230113062339.1909087-1-hch@lst.de/#t
> 
> However this did come up here:
> https://lore.kernel.org/all/20230123194218.47ssfzhrpnv3xfez@oracle.com/

Andrew,
  Adrian suggested I ask if you can pick this up in your tree, while the
  arch/sh maintainership gets figured out:

  https://lore.kernel.org/all/8981c636-6145-6589-d4c9-8cdc12801be3@physik.fu-berlin.de/

  This is needed in stable 5.4, 5.10, and 5.15 as well.

> 
> 
> Regards,
> 
> --Tom
> 
> 
>  arch/sh/kernel/vmlinux.lds.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
> index 3161b9ccd2a5..b6276a3521d7 100644
> --- a/arch/sh/kernel/vmlinux.lds.S
> +++ b/arch/sh/kernel/vmlinux.lds.S
> @@ -4,6 +4,7 @@
>   * Written by Niibe Yutaka and Paul Mundt
>   */
>  OUTPUT_ARCH(sh)
> +#define RUNTIME_DISCARD_EXIT
>  #include <asm/thread_info.h>
>  #include <asm/cache.h>
>  #include <asm/vmlinux.lds.h>
> 
> base-commit: 2475bf0250dee99b477e0c56d7dc9d7ac3f04117
> -- 
> 2.39.1
> 
