Return-Path: <linux-arch+bounces-7001-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA4D96BAF0
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 13:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DCF1C209B7
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4961D0145;
	Wed,  4 Sep 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jTxyrwnu"
X-Original-To: linux-arch@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4AA1CCB43;
	Wed,  4 Sep 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449915; cv=fail; b=Yw/65YafFdYU+tcMUluIWHEas5ZFLlY+1hYZLww0+/E2Ed0XadGX7E/48x9aI3JV4uq5QUbCxwF7BsIJQ9c7plpR3yHj4vfkkioiHRN4JP77Rh0BSJZncsRDp7d40d3Yb0tG3OnSXJVj15X0+LrspQyQt6uT1WmlRHRyLGiM9vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449915; c=relaxed/simple;
	bh=bFouIepDHNoOko1hJTQBkqCtSLE2IfrMMkoTs5lJlAc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YZrGJr8QVUxqSjtGZnOSnDPqEyUQu/ZHcfBDYdVLjisd5532kpEk278cRFmHMtCV6kCO4i+9m8xCrgAIqJ5TFntlu5HH5sVxeQ36MmP1mlqxlr8r4NS+S+ZTWFJn4uESDXi+tMaN46jyqV8yxpGCbfFXZA8HJ8c+65sRIyPTGmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jTxyrwnu; arc=fail smtp.client-ip=40.107.117.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdiMa9O2ykZ6OKVj1gQVSoC4XlaITBGSuUwgGXa7VBPHkLkOjpZT/Qd+fef+9GHQnJfGiHWLK3E67DUjg1hCWPH/zbIW4wJ/1KYbnmuquiylv9fUDtK5iMugEgNFbU87/sXFGGYcu5OWLjAi+btz58SjNUpQVXWcsDTbXNGjbfLEu0mQ9eyNydXSVysjzgkEZszvmx1x70A9rnIIS5IpGONcWp4bda5d7gjKFUrYjfKOcTPUIffRNSFue7Yw6M7Hl5Njk0bQ2JvPEpHUrQR9jilDmfIKYvppyhFW+I+UkTGb3aFr4KdDw6qz6HMiNeyCYOQiF2hAwk9J2vnlRfbQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMQ8isQmFpxEc/Q5PeIvbWk6FSwIokZI+MLPGR2qJfg=;
 b=JK+SzCa++3Sdyb0Us+dDocDQcBbAKgEtluSN8mVm7XXamXkWjLdJSvxWB4i5d7ZgPH/062nJ2fiXnmNa/hcZC8uDLuZiF/Z3gRE3BUziAbsENSl4U5FxypJMxKXYUJ9+6t7adFbNnaMnXomRALlCafkrXUN/4A1fbNdlz9EuZC0IUa3NSU3jmaKbF/3J/CxBuZ9jELLeHZTfxR4M7I3WAy7nP9ml/v/Czd1Or8EsfcsgKBF4pfHyLjoqaBemwBULHSi0474xQiu3DIDGUUauM+ibCuEypHH2m/0OBtiua49oLzVLAqQwNu6Tc38y2esHxFF8GbooI8h2xuk5hEU2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMQ8isQmFpxEc/Q5PeIvbWk6FSwIokZI+MLPGR2qJfg=;
 b=jTxyrwnuf9z7W+/1ExG19xxrCmh85HKt47GpJoQbXBTRZlLbYJoVV5jveLF7ItR55cQWvUWogg97O+McAmumMUIIIH89fUzJUAohc8F4VD2JXMIIxg5+gTXDub9DEozXcM+bkTq75BTRzX+007YxPeeYYEMRL091jGP57ReoDiAAN84NX2Wupx77UpzfmAlp4JG8DFGiDp6xU6MB9hDQ5hOqVj5tHAvl6IkEHkp8+zUc/cmWVBgjkravMGVpKlzhQFzReKunoS4vkU/3QHx20vOVOQp1kOzez6PWlQd3cX9Yp6THcu5TD9QQu411lKNRHYk+KFUeRgTAMhbRkuPyEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB5416.apcprd06.prod.outlook.com (2603:1096:101:67::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:38:27 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:38:27 +0000
Message-ID: <84f5bb25-fcdd-4509-aae6-de9a5bd49e86@vivo.com>
Date: Wed, 4 Sep 2024 19:38:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: tlb: add tlb swap entries batch async release
From: zhiguojiang <justinjiang@vivo.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-arch@vger.kernel.org, cgroups@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, opensource.kernel@vivo.com
References: <20240805153639.1057-1-justinjiang@vivo.com>
 <20240805153639.1057-3-justinjiang@vivo.com>
 <CAGsJ_4zXtJvBdgpDs+yyEwfdJ0gy+_dgrWLF1zxMgBbaLBeiYA@mail.gmail.com>
 <400918d7-aaaf-4ccc-af8e-ab48576746d1@vivo.com>
In-Reply-To: <400918d7-aaaf-4ccc-af8e-ab48576746d1@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fe68c8-c94c-4b17-6cee-08dcccd617b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1l2c1J6TUZ4bCs5RUpmQnV4MkVwdmtJb1dLL1pjakdIMDBKQTBmU0Q3VDVx?=
 =?utf-8?B?QWF4Smd2NjVxQnhiRGVqSmNiaWNjcnljVkFVeVZCeFJIdFdLcWhCVVZHVjNK?=
 =?utf-8?B?TG8ydFV5NHgvYkU2NWFiV0VTTXl1QmNjc0R6VEZMR2c2TkMzVnRVZWVHSjRL?=
 =?utf-8?B?b2R0SzJXZmxuZmtEK25hczluSlhoN05LQ1UwNzJBYU5CYU5oblY5SktKTlBl?=
 =?utf-8?B?dXRIWllackVWUFoyMnBTTUc4b0lidlliYkxoMi9TWFIvRkhnQmZranFFQ3Rx?=
 =?utf-8?B?cnhhZ2xISWJYcEZuQzdWSllZTnVXblNEK2JJSUF0aU4vM0tTNFF2MDdiaUpV?=
 =?utf-8?B?dDcxV0dKb2RwMXFXZUs1Qjh2MnRVb0FOMWh0VUZ5bTB2dnFRQ2ZxeThBNTBP?=
 =?utf-8?B?N3RrR01xU2pKbStxakhYT09IUjNjVHFldng1cWFTVGxNVXE5Qkt0aHNrWWwr?=
 =?utf-8?B?Ynd3TFV0QWZmaGM2aUtHazAzVzk0YVUrUkROWk85cUVpT1pRaU13d0dPZlRu?=
 =?utf-8?B?TDFzUEFGdGFqRUNFZm56N25Vbi9sV1krc09ITGVrVThtZ1AzVFJOL1ZselFR?=
 =?utf-8?B?K29sSUlERXlQV2VybTFOSlY5ZDZlUDZEMWhUbDBBeTVBak40UmtpYzQ4dXJm?=
 =?utf-8?B?OW0zekcxYUhFa05WU1hUM21zTnRhZVRNdG4vajNUYkpRaVNydUVGT3lHK3F0?=
 =?utf-8?B?SU1SekFDM0RPUGd5OC9MTi9NNXVWbkxpQnVwcWZVTkpXRmxaZGxTK01ZbWln?=
 =?utf-8?B?K2JDQkR0Z3FzVlM2ZUVPSms1OVBuZ2pPY2tMMFN2RkQvL0RLVmlLNDV4amVY?=
 =?utf-8?B?Q2JkeG1BWmdwUUFtaDVDSVlua2JOanI2aDVCVTFpQ3djWjk1VS9aSlNNVHkx?=
 =?utf-8?B?bm50Q05PU3pEOGVKUVJTMm9rOWcrSFYwbHBqVUdDUk1XZ0c3RGcrQ2pMS25l?=
 =?utf-8?B?aG54S1Q2UFdVTUo1eGFUOXBYZVVxa2pWZEhIUTlXU21TOW1YL3hPOFE2alV0?=
 =?utf-8?B?eXMzcDB6SHhaWDFoNzJSbzNPVFJWbHljMGwxN2ttczdqc3VYSC93TzJDbzVj?=
 =?utf-8?B?dFNNZzZYdkxwRThwb1VTZWI1czlRRDNSNy9tNk12U0s1MG1pYm9zVEZwOE41?=
 =?utf-8?B?VWRVRmdmZVVxVmJaV3k0Y3Jqd2RwYU1iZmNSS3Z5Vi9MbUJSbnpFK3lPVnhT?=
 =?utf-8?B?dUdPS0ZYYmhPUnhpbEJIWTUyeTlia0svU2FmVW83eVRTSGlrZkFkakh4Q3dJ?=
 =?utf-8?B?YzRvc0pxK3ZTVHhJUlBhNUFVTlcrQ2dkQitKN1I3a2tuSzZKaktzYlRBK1hp?=
 =?utf-8?B?YzA1N3pCR01vck0rZDVyNmNqcUd5bnVFcS9IZ2o4MUh2SmM1dHFwV1RrUk50?=
 =?utf-8?B?Nng0OWg1bTA3VEtZTnVIYUxaT0ZtbW4xdWt0ZWRUUERDRjc0MmJNMkRCalJU?=
 =?utf-8?B?cGMvYjRDdjBHVHV1VXAvbDNWb3dTZUl6SFFJRG1VdytFTFNmZUtaVGM1d0Fm?=
 =?utf-8?B?WStjT1lvanJCbWt4am5mNzNUNGN1Mzc1WE44RzVvTkdHbXBHUFVxTVFiSFBU?=
 =?utf-8?B?eWt3RkJCU3lGbHRRMXlRUUNwMHRNOGhvaER4Zmg3ZjVJU2R4dm5NRnFJVGRJ?=
 =?utf-8?B?SzlCVFRUb0EvRkI4OWNRZ2RWYnhjZGxESFMvZHZaN2Rhd2pLa0NXNUNRRzg3?=
 =?utf-8?B?Q2tBS2VxWlFtc1VkWXlhUEY5eEwraEltaXg0TkVtbE8wNzVwQUhMQVFMZEp4?=
 =?utf-8?B?bzBTSHlPSng2d2VUODY4dHAvaS9FYTNKTkJUNUlTajFFTzZsNk9HSU94cE5V?=
 =?utf-8?B?NEdrMDh0UTQxK05qN09SQkVLUHVXdHpoemsvanhoQ254aFVkRkNKR3RvU3or?=
 =?utf-8?B?SnI5T0oxV2hsV0FVR3JuUUhYdHdkdG5IMVVYaDRnMXRDRXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3VSM0pxY3NOaW5GK1hYeDNBYnJkQ20yVkhiVjFpdVhTNW94YnF3bUFRcTlk?=
 =?utf-8?B?LzVFbisvMkJ5a3BYUzF6MmpPbnZRdXhwQThUTGo4RWhXVDhtUmdieldMZHpp?=
 =?utf-8?B?R20wOEdzZ2dZL2kyOEcwUEErLzJ3Tlo1NzlONW1CWVNid3puajNiMWFaZXkw?=
 =?utf-8?B?WjRFaXhrK29XYnNDQ2tlYmhGOGtwcjZNNUkyalVWM1I3MGZVbkdubEJVeUg4?=
 =?utf-8?B?YnJJMjY2WlQranVNTjk1YmJVUCtUSVVnb2lhNldzOTZ1UGFFY3JJSlJlQ1R4?=
 =?utf-8?B?RmMyYlltYkc1VUtPc3pHb2llREZWa1BGSG9kSGhPbTkyK2tpTUF1MnhTWkNL?=
 =?utf-8?B?Q2cwV2dkc3NpRHBxRzFhbFFqRmR2SXpSRkVjbTMrTXdlYzE0ejVkVjdvbk4v?=
 =?utf-8?B?bEdsbkVwLzZ5Sy9pcmlUM2lkVEowQmlGK3ljNkhvN1A4QlpDREhRdWZ5THhE?=
 =?utf-8?B?b3ZCTDZJdnVYK3pKb3JYN2xYSkgxa2dnMG5GWmdyRHRrY3RTZ1djeHZuSG9J?=
 =?utf-8?B?Sis4ZFFMTmJGc0FLaGRNZEhQYjhMK2tkRXNsb0djeTQwZlBSMngrUTdlOHVY?=
 =?utf-8?B?S0ROdnhUVDlQM3IrYmVrRTVXUXRaU3IydjNRbHlwRGRHcm1pcXJQdDROaWF3?=
 =?utf-8?B?bDVDUnBISHZLUGZHYUd5RldnSzlTUmZJb2kyUlV3ZEtWdGRWMStZTU93LzhU?=
 =?utf-8?B?Y1Y3RU1iYU1zV2FZMGZaWVQ0NHFMMFhlR20xMExrc085QWxlTzJzUkpSbEpI?=
 =?utf-8?B?NXIwbmhTTFd6L0RKT2dWaXZuY1R6a2NHOU1IcnBnV003L0E2dHVhWUNWTlY5?=
 =?utf-8?B?Z2ZMenE0NXNzUmlaVmdNdE5leEhNc3ZUNUw4SmpDL09ta1ZvN0FVQ3U4bVor?=
 =?utf-8?B?Mm1XdHEvKzBUcHlDeDUyZ2NPbGZCM3RzcjJ4UnFSdXdzVk5qaTRCeGJKeXB5?=
 =?utf-8?B?dGZwMVdMYThuR1RYcjJ5WkhlNDRmaDRRYVdtUEM1K1Z5T0dPTnRpNFFCZW02?=
 =?utf-8?B?TGVadW9tR1p1SFppNEV5ODZwQlVMeGFNbVpSaFkvYW44U0hWWjZubnVMZG1s?=
 =?utf-8?B?cTROeThmbkJZbU1pdS9pK2s0YkU3aXRSOUxldTllUC9Ccmh5Tng0Rlc0cDNz?=
 =?utf-8?B?WFJGNXErNmh2N3ZNcGRRTm1IV3gxZHltaEhuQjZ6QnRWbURCTWtTSTdJMEVz?=
 =?utf-8?B?b3Nld3dKRWNHaFNvUGtBOXcrWElHZWhlL2IyUDJPUDBweVdYWmhsWVJPZ2lk?=
 =?utf-8?B?N1hzZlo4SVNFYnFvcXBuV2JYZG8raUdNT25ZdFhLRHM2c0lVQVFIY3VaUlM4?=
 =?utf-8?B?Sng4SjdxRFRNbVhmdE5kTWVXTjNFb092SDBycW5uTUtlbThTQ1doSU5QN3Y2?=
 =?utf-8?B?TTI2d2lOK21VSlE1NzVXcSt2UmtpZnBQdVIwUS8zZzNDTzZZLzhpckZ4R2Uv?=
 =?utf-8?B?SFFCZnp2dmVvZEI4ZzVoa3ZvVFJ4NS84RnVQT3kvQjdaU1NhclZaVXdNdFcw?=
 =?utf-8?B?eEp5SDA3OE1GS3oyQjdIYmVlQUdVOGdGVHIvRkFyV1krclpkZE5CdVphMUg4?=
 =?utf-8?B?Y0RYZWNvT29ESGZybTN3enJ4Y1lmMzJ1QkVmcjhma1Y4Zm9vVHIxNi96bTFT?=
 =?utf-8?B?dE5yUFNmSDNLcldMamg2WjJ6YW00cVoyWmRiblJNL21XUDJLRzJVSmZiRTIv?=
 =?utf-8?B?REZpVzdnVFRYU2ZmZnAwOHNBY0oyK0ZoM2pQWlc1dkhVWmZqOUFrVVVrdjZt?=
 =?utf-8?B?TjdyUklvU1pYNStiL0Y1aWlTVlp6UXhrMjRpS01jM08wbzFNalJhbTVEcEVX?=
 =?utf-8?B?UGNST3RVWlM0QXlhUFg2UzJjeVNUYlZZbjBXdmRqSFI3ZldXdlRqbzVVRzZ6?=
 =?utf-8?B?QUNrRnVQK0dGa0k4RmFjY0tDaEVYWklnUmFlRktwZzY4aHcxQ1NkUEZ0SlA0?=
 =?utf-8?B?a2w2aGZhTWMya21MZ3Q4ZlJWRjhTVmJGbDlpZXlYL252dkxBSEFFWUM4V0ts?=
 =?utf-8?B?SDNXUkNmRXFGejJEaytEV0hsc2xIWDlUanV5UmczNnM2SDZnbzVKLzZXRU4z?=
 =?utf-8?B?aTV1VVc0QWJNcktUUDVmbVJRaldnRFlaRkJIYU01dkFhc2YwZnlNYXZSY3BJ?=
 =?utf-8?Q?nQrfJMVBP/4X9SUS/higTjRI1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fe68c8-c94c-4b17-6cee-08dcccd617b9
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:38:27.4214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H58Lqk+BMvdUgBYnUG9wSUYMOTH0dSiwupdVmPQGgILzzmSp+wr7C8DqplRq4lzv1jmdKVOz2rYPvP1bYEi8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5416



在 2024/9/4 19:26, zhiguojiang 写道:
>
>
> 在 2024/9/4 17:16, Barry Song 写道:
>> On Tue, Aug 6, 2024 at 3:36 AM Zhiguo Jiang <justinjiang@vivo.com> 
>> wrote:
>>> One of the main reasons for the prolonged exit of the process with
>>> independent mm is the time-consuming release of its swap entries.
>>> The proportion of swap memory occupied by the process increases over
>>> time due to high memory pressure triggering to reclaim anonymous folio
>>> into swapspace, e.g., in Android devices, we found this proportion can
>>> reach 60% or more after a period of time. Additionally, the relatively
>>> lengthy path for releasing swap entries further contributes to the
>>> longer time required to release swap entries.
>>>
>>> Testing Platform: 8GB RAM
>>> Testing procedure:
>>> After booting up, start 15 processes first, and then observe the
>>> physical memory size occupied by the last launched process at different
>>> time points.
>>> Example: The process launched last: com.qiyi.video
>>> |  memory type  |  0min  |  1min  |   5min  |   10min  | 15min  |
>>> -------------------------------------------------------------------
>>> |     VmRSS(KB) | 453832 | 252300 |  204364 |   199944 | 199748  |
>>> |   RssAnon(KB) | 247348 |  99296 |   71268 |    67808 | 67660  |
>>> |   RssFile(KB) | 205536 | 152020 |  132144 |   131184 | 131136  |
>>> |  RssShmem(KB) |   1048 |    984 |     952 |     952  | 952  |
>>> |    VmSwap(KB) | 202692 | 334852 |  362880 |   366340 | 366488  |
>>> | Swap ratio(%) | 30.87% | 57.03% |  63.97% |   64.69% | 64.72%  |
>>> Note: min - minute.
>>>
>>> When there are multiple processes with independent mm and the high
>>> memory pressure in system, if the large memory required process is
>>> launched at this time, system will is likely to trigger the 
>>> instantaneous
>>> killing of many processes with independent mm. Due to multiple exiting
>>> processes occupying multiple CPU core resources for concurrent 
>>> execution,
>>> leading to some issues such as the current non-exiting and important
>>> processes lagging.
>>>
>>> To solve this problem, we have introduced the multiple exiting process
>>> asynchronous swap entries release mechanism, which isolates and caches
>>> swap entries occupied by multiple exiting processes, and hands them 
>>> over
>>> to an asynchronous kworker to complete the release. This allows the
>>> exiting processes to complete quickly and release CPU resources. We 
>>> have
>>> validated this modification on the Android products and achieved the
>>> expected benefits.
>>>
>>> Testing Platform: 8GB RAM
>>> Testing procedure:
>>> After restarting the machine, start 15 app processes first, and then
>>> start the camera app processes, we monitor the cold start and preview
>>> time datas of the camera app processes.
>>>
>>> Test datas of camera processes cold start time (unit: millisecond):
>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>>> | before | 1498 | 1476 | 1741 | 1337 | 1367 | 1655 |   1512  |
>>> | after  | 1396 | 1107 | 1136 | 1178 | 1071 | 1339 |   1204  |
>>>
>>> Test datas of camera processes preview time (unit: millisecond):
>>> |  seq   |   1  |   2  |   3  |   4  |   5  |   6  | average |
>>> | before |  267 |  402 |  504 |  513 |  161 |  265 |   352   |
>>> | after  |  188 |  223 |  301 |  203 |  162 |  154 |   205   |
>>>
>>> Base on the average of the six sets of test datas above, we can see 
>>> that
>>> the benefit datas of the modified patch:
>>> 1. The cold start time of camera app processes has reduced by about 
>>> 20%.
>>> 2. The preview time of camera app processes has reduced by about 42%.
>>>
>>> It offers several benefits:
>>> 1. Alleviate the high system cpu loading caused by multiple exiting
>>>     processes running simultaneously.
>>> 2. Reduce lock competition in swap entry free path by an asynchronous
>>>     kworker instead of multiple exiting processes parallel execution.
>>> 3. Release pte_present memory occupied by exiting processes more
>>>     efficiently.
>>>
>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>> ---
>>>   arch/s390/include/asm/tlb.h |   8 +
>>>   include/asm-generic/tlb.h   |  44 ++++++
>>>   include/linux/mm_types.h    |  58 +++++++
>>>   mm/memory.c                 |   3 +-
>>>   mm/mmu_gather.c             | 296 
>>> ++++++++++++++++++++++++++++++++++++
>>>   5 files changed, 408 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
>>> index e95b2c8081eb..3f681f63390f
>>> --- a/arch/s390/include/asm/tlb.h
>>> +++ b/arch/s390/include/asm/tlb.h
>>> @@ -28,6 +28,8 @@ static inline bool __tlb_remove_page_size(struct 
>>> mmu_gather *tlb,
>>>                  struct page *page, bool delay_rmap, int page_size);
>>>   static inline bool __tlb_remove_folio_pages(struct mmu_gather *tlb,
>>>                  struct page *page, unsigned int nr_pages, bool 
>>> delay_rmap);
>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>> +               swp_entry_t entry, int nr);
>>>
>>>   #define tlb_flush tlb_flush
>>>   #define pte_free_tlb pte_free_tlb
>>> @@ -69,6 +71,12 @@ static inline bool 
>>> __tlb_remove_folio_pages(struct mmu_gather *tlb,
>>>          return false;
>>>   }
>>>
>>> +static inline bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>> +               swp_entry_t entry, int nr)
>>> +{
>>> +       return false;
>>> +}
>>> +
>>>   static inline void tlb_flush(struct mmu_gather *tlb)
>>>   {
>>>          __tlb_flush_mm_lazy(tlb->mm);
>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>>> index 709830274b75..8b4d516b35b8
>>> --- a/include/asm-generic/tlb.h
>>> +++ b/include/asm-generic/tlb.h
>>> @@ -294,6 +294,37 @@ extern void tlb_flush_rmaps(struct mmu_gather 
>>> *tlb, struct vm_area_struct *vma);
>>>   static inline void tlb_flush_rmaps(struct mmu_gather *tlb, struct 
>>> vm_area_struct *vma) { }
>>>   #endif
>>>
>>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
>>> +struct mmu_swap_batch {
>>> +       struct mmu_swap_batch *next;
>>> +       unsigned int nr;
>>> +       unsigned int max;
>>> +       encoded_swpentry_t encoded_entrys[];
>>> +};
>>> +
>>> +#define MAX_SWAP_GATHER_BATCH  \
>>> +       ((PAGE_SIZE - sizeof(struct mmu_swap_batch)) / sizeof(void *))
>>> +
>>> +#define MAX_SWAP_GATHER_BATCH_COUNT    (10000UL / 
>>> MAX_SWAP_GATHER_BATCH)
>>> +
>>> +struct mmu_swap_gather {
>>> +       /*
>>> +        * the asynchronous kworker to batch
>>> +        * release swap entries
>>> +        */
>>> +       struct work_struct free_work;
>>> +
>>> +       /* batch cache swap entries */
>>> +       unsigned int batch_count;
>>> +       struct mmu_swap_batch *active;
>>> +       struct mmu_swap_batch local;
>>> +       encoded_swpentry_t __encoded_entrys[MMU_GATHER_BUNDLE];
>>> +};
>>> +
>>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>> +               swp_entry_t entry, int nr);
>>> +#endif
>>> +
>>>   /*
>>>    * struct mmu_gather is an opaque type used by the mm code for 
>>> passing around
>>>    * any data needed by arch specific code for tlb_remove_page.
>>> @@ -343,6 +374,18 @@ struct mmu_gather {
>>>          unsigned int            vma_exec : 1;
>>>          unsigned int            vma_huge : 1;
>>>          unsigned int            vma_pfn  : 1;
>>> +#ifndef CONFIG_MMU_GATHER_NO_GATHER
>>> +       /*
>>> +        * Two states of releasing swap entries
>>> +        * asynchronously:
>>> +        * swp_freeable - have opportunity to
>>> +        * release asynchronously future
>>> +        * swp_freeing - be releasing asynchronously.
>>> +        */
>>> +       unsigned int            swp_freeable : 1;
>>> +       unsigned int            swp_freeing : 1;
>>> +       unsigned int            swp_disable : 1;
>>> +#endif
>>>
>>>          unsigned int            batch_count;
>>>
>>> @@ -354,6 +397,7 @@ struct mmu_gather {
>>>   #ifdef CONFIG_MMU_GATHER_PAGE_SIZE
>>>          unsigned int page_size;
>>>   #endif
>>> +       struct mmu_swap_gather *swp;
>>>   #endif
>>>   };
>>>
>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>> index 165c58b12ccc..2f66303f1519
>>> --- a/include/linux/mm_types.h
>>> +++ b/include/linux/mm_types.h
>>> @@ -283,6 +283,64 @@ typedef struct {
>>>          unsigned long val;
>>>   } swp_entry_t;
>>>
>>> +/*
>>> + * encoded_swpentry_t - a type marking the encoded swp_entry_t.
>>> + *
>>> + * An 'encoded_swpentry_t' represents a 'swp_enrty_t' with its the 
>>> highest
>>> + * bit indicating extra context-dependent information. Only used in 
>>> swp_entry
>>> + * asynchronous release path by mmu_swap_gather.
>>> + */
>>> +typedef struct {
>>> +       unsigned long val;
>>> +} encoded_swpentry_t;
>>> +
>>> +/*
>>> + * The next item in an encoded_swpentry_t array is the "nr" 
>>> argument, specifying the
>>> + * total number of consecutive swap entries associated with the 
>>> same folio. If this
>>> + * bit is not set, "nr" is implicitly 1.
>>> + *
>>> + * Refer to include\asm\pgtable.h, swp_offset bits: 0 ~ 57, 
>>> swp_type bits: 58 ~ 62.
>>> + * Bit63 can be used here.
>>> + */
>>> +#define ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT (1UL << (BITS_PER_LONG 
>>> - 1))
>>> +
>>> +static __always_inline encoded_swpentry_t
>>> +encode_swpentry(swp_entry_t entry, unsigned long flags)
>>> +{
>>> +       encoded_swpentry_t ret;
>>> +
>>> +       VM_WARN_ON_ONCE(flags & ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
>>> +       ret.val = flags | entry.val;
>>> +       return ret;
>>> +}
>>> +
>>> +static inline unsigned long 
>>> encoded_swpentry_flags(encoded_swpentry_t entry)
>>> +{
>>> +       return ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
>>> +}
>>> +
>>> +static inline swp_entry_t encoded_swpentry_data(encoded_swpentry_t 
>>> entry)
>>> +{
>>> +       swp_entry_t ret;
>>> +
>>> +       ret.val = ~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT & entry.val;
>>> +       return ret;
>>> +}
>>> +
>>> +static __always_inline encoded_swpentry_t 
>>> encode_nr_swpentrys(unsigned long nr)
>>> +{
>>> +       encoded_swpentry_t ret;
>>> +
>>> +       VM_WARN_ON_ONCE(nr & ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT);
>>> +       ret.val = nr;
>>> +       return ret;
>>> +}
>>> +
>>> +static __always_inline unsigned long 
>>> encoded_nr_swpentrys(encoded_swpentry_t entry)
>>> +{
>>> +       return ((~ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT) & entry.val);
>>> +}
>>> +
>>>   /**
>>>    * struct folio - Represents a contiguous set of bytes.
>>>    * @flags: Identical to the page flags.
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index d6a9dcddaca4..023a8adcb67c
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1650,7 +1650,8 @@ static unsigned long zap_pte_range(struct 
>>> mmu_gather *tlb,
>>>                          if (!should_zap_cows(details))
>>>                                  continue;
>>>                          rss[MM_SWAPENTS] -= nr;
>>> -                       free_swap_and_cache_nr(entry, nr);
>>> +                       if (!__tlb_remove_swap_entries(tlb, entry, nr))
>>> +                               free_swap_and_cache_nr(entry, nr);
>>>                  } else if (is_migration_entry(entry)) {
>>>                          folio = pfn_swap_entry_folio(entry);
>>>                          if (!should_zap_folio(details, folio))
>>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>>> index 99b3e9408aa0..33dc9d1faff9
>>> --- a/mm/mmu_gather.c
>>> +++ b/mm/mmu_gather.c
>>> @@ -9,11 +9,303 @@
>>>   #include <linux/smp.h>
>>>   #include <linux/swap.h>
>>>   #include <linux/rmap.h>
>>> +#include <linux/oom.h>
>>>
>>>   #include <asm/pgalloc.h>
>>>   #include <asm/tlb.h>
>>>
>>>   #ifndef CONFIG_MMU_GATHER_NO_GATHER
>>> +/*
>>> + * The swp_entry asynchronous release mechanism for multiple 
>>> processes with
>>> + * independent mm exiting simultaneously.
>>> + *
>>> + * During the multiple exiting processes releasing their own mm 
>>> simultaneously,
>>> + * the swap entries in the exiting processes are handled by 
>>> isolating, caching
>>> + * and handing over to an asynchronous kworker to complete the 
>>> release.
>>> + *
>>> + * The conditions for the exiting process entering the swp_entry 
>>> asynchronous
>>> + * release path:
>>> + * 1. The exiting process's MM_SWAPENTS count is >= 
>>> SWAP_CLUSTER_MAX, avoiding
>>> + *    to alloc struct mmu_swap_gather frequently.
>>> + * 2. The number of exiting processes is >= NR_MIN_EXITING_PROCESSES.
>> Hi Zhiguo,
>>
>> I'm curious about the significance of NR_MIN_EXITING_PROCESSES. It 
>> seems that
>> batched swap entry freeing, even with one process, could be a
>> bottleneck for a single
>> process based on the data from this patch:
>>
>> mm: attempt to batch free swap entries for zap_pte_range()
>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-stable&id=bea67dcc5ee 
>>
>> "munmap bandwidth becomes 3X faster."
>>
>> So what would happen if you simply set NR_MIN_EXITING_PROCESSES to 1?
> Hi Barry,
>
> Thanks for your comments.
>
> The reason for NR_MIN_EXITING_PROCESSES = 2 is that previously we
> conducted the multiple android apps continuous startup performance
> test on the case of NR_MIN_EXITING_PROCESSES = 1, and the results
> showed that the startup time had deteriorated slightly. However,
> the patch's logic in this test was different from the one I submitted
> to the community, and it may be due to some other issues with the
> previous old patch.
>
> However, we have conducted relevant memory performance tests on this
> patches submitted to the community (NR_MIN_EXITING_PROCESSES=2), and
> the results are better than before the modification. The patches have
> been used on multiple projects.
> For example:
> Test the time consumption and subjective fluency experience of
> launching 30 android apps continuously for two rounds.
> Test machine: RAM 16GB
> |        | time(s) | Frame-droped rate(%) |
> | before | 230.76  |         0.54         |
> | after  | 225.23  |         0.74         |
Sorry, update date.
Test machine: RAM 16GB
|        | time(s) | Frame-droped rate(%) |
| before | 230.76  |         0.74         |
| after  | 225.23  |         0.54         |
> We can see that the patch has been optimized 5.53s for startup time and
> 0.2% frame-droped rate and better subjective smoothness experience.
>
> Perhaps the patches submitted to the community has also improved the
> multiple android apps continuous startup performance in the case
> of NR_MIN_EXITING_PROCESSES=1. If necessary, I will conduct relevant
> tests to verify this situation in the future.
>>
>>> + *
>>> + * Since the time for determining the number of exiting processes 
>>> is dynamic,
>>> + * the exiting process may start to enter the swp_entry 
>>> asynchronous release
>>> + * at the beginning or middle stage of the exiting process's 
>>> swp_entry release
>>> + * path.
>>> + *
>>> + * Once an exiting process enters the swp_entry asynchronous 
>>> release, all remaining
>>> + * swap entries in this exiting process need to be fully released 
>>> by asynchronous
>>> + * kworker theoretically.
>> Freeing a slot can indeed release memory from `zRAM`, potentially 
>> returning
>> it to the system for allocation. Your patch frees swap slots 
>> asynchronously;
>> I assume this doesn’t slow down the memory freeing process for 
>> `zRAM`, or
>> could it even slow down the freeing of `zRAM` memory? Freeing compressed
>> memory might not be as crucial compared to freeing uncompressed 
>> memory with
>> present PTEs?
> Yes, freeing uncompressed memory with present PTEs is more important
> compared to freeing compressed 'zRAM' memory.
>
> I guess that the multiple exiting processes releasing swap entries
> simultaneously may result in the swap_info->lock competition pressure
> in swapcache_free_entries(), affecting the efficiency of releasing swap
> entries. However, if the asynchronous kworker is used, this issue can
> be avoided, and perhaps the improvement is minor.
>
> The freeing of zRAM memory does not slow down. We have observed traces
> in the camera startup scene and found that the asynchronous kworker
> can release all swap entries before entering the camera preview.
> Compared to not using the asynchronous kworker, the exiting processes
> completed after entering the camera preview.
>>
>>> + *
>>> + * The function of the swp_entry asynchronous release:
>>> + * 1. Alleviate the high system cpu load caused by multiple exiting 
>>> processes
>>> + *    running simultaneously.
>>> + * 2. Reduce lock competition in swap entry free path by an 
>>> asynchronous kworker
>>> + *    instead of multiple exiting processes parallel execution.
>>> + * 3. Release pte_present memory occupied by exiting processes more 
>>> efficiently.
>>> + */
>>> +
>>> +/*
>>> + * The min number of exiting processes required for swp_entry 
>>> asynchronous release
>>> + */
>>> +#define NR_MIN_EXITING_PROCESSES 2
>>> +
>>> +static atomic_t nr_exiting_processes = ATOMIC_INIT(0);
>>> +static struct kmem_cache *swap_gather_cachep;
>>> +static struct workqueue_struct *swapfree_wq;
>>> +static DEFINE_STATIC_KEY_TRUE(tlb_swap_asyncfree_disabled);
>>> +
>>> +static int __init tlb_swap_async_free_setup(void)
>>> +{
>>> +       swapfree_wq = alloc_workqueue("smfree_wq", WQ_UNBOUND |
>>> +               WQ_HIGHPRI | WQ_MEM_RECLAIM, 1);
>>> +       if (!swapfree_wq)
>>> +               goto fail;
>>> +
>>> +       swap_gather_cachep = kmem_cache_create("swap_gather",
>>> +               sizeof(struct mmu_swap_gather),
>>> +               0, SLAB_TYPESAFE_BY_RCU | SLAB_PANIC | SLAB_ACCOUNT,
>>> +               NULL);
>>> +       if (!swap_gather_cachep)
>>> +               goto kcache_fail;
>>> +
>>> + static_branch_disable(&tlb_swap_asyncfree_disabled);
>>> +       return 0;
>>> +
>>> +kcache_fail:
>>> +       destroy_workqueue(swapfree_wq);
>>> +fail:
>>> +       return -ENOMEM;
>>> +}
>>> +postcore_initcall(tlb_swap_async_free_setup);
>>> +
>>> +static void __tlb_swap_gather_free(struct mmu_swap_gather 
>>> *swap_gather)
>>> +{
>>> +       struct mmu_swap_batch *swap_batch, *next;
>>> +
>>> +       for (swap_batch = swap_gather->local.next; swap_batch; 
>>> swap_batch = next) {
>>> +               next = swap_batch->next;
>>> +               free_page((unsigned long)swap_batch);
>>> +       }
>>> +       swap_gather->local.next = NULL;
>>> +       kmem_cache_free(swap_gather_cachep, swap_gather);
>>> +}
>>> +
>>> +static void tlb_swap_async_free_work(struct work_struct *w)
>>> +{
>>> +       int i, nr_multi, nr_free;
>>> +       swp_entry_t start_entry;
>>> +       struct mmu_swap_batch *swap_batch;
>>> +       struct mmu_swap_gather *swap_gather = container_of(w,
>>> +               struct mmu_swap_gather, free_work);
>>> +
>>> +       /* Release swap entries cached in mmu_swap_batch. */
>>> +       for (swap_batch = &swap_gather->local; swap_batch && 
>>> swap_batch->nr;
>>> +           swap_batch = swap_batch->next) {
>>> +               nr_free = 0;
>>> +               for (i = 0; i < swap_batch->nr; i++) {
>>> +                       if 
>>> (unlikely(encoded_swpentry_flags(swap_batch->encoded_entrys[i]) &
>>> + ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT)) {
>>> +                               start_entry = 
>>> encoded_swpentry_data(swap_batch->encoded_entrys[i]);
>>> +                               nr_multi = 
>>> encoded_nr_swpentrys(swap_batch->encoded_entrys[++i]);
>>> + free_swap_and_cache_nr(start_entry, nr_multi);
>>> +                               nr_free += 2;
>>> +                       } else {
>>> +                               start_entry = 
>>> encoded_swpentry_data(swap_batch->encoded_entrys[i]);
>>> + free_swap_and_cache_nr(start_entry, 1);
>>> +                               nr_free++;
>>> +                       }
>>> +               }
>>> +               swap_batch->nr -= nr_free;
>>> +               VM_BUG_ON(swap_batch->nr);
>>> +       }
>>> +       __tlb_swap_gather_free(swap_gather);
>>> +}
>>> +
>>> +static bool __tlb_swap_gather_mmu_check(struct mmu_gather *tlb)
>>> +{
>>> +       /*
>>> +        * Only the exiting processes with the MM_SWAPENTS counter >=
>>> +        * SWAP_CLUSTER_MAX have the opportunity to release their swap
>>> +        * entries by asynchronous kworker.
>>> +        */
>>> +       if (!task_is_dying() ||
>>> +           get_mm_counter(tlb->mm, MM_SWAPENTS) < SWAP_CLUSTER_MAX)
>>> +               return true;
>>> +
>>> +       atomic_inc(&nr_exiting_processes);
>>> +       if (atomic_read(&nr_exiting_processes) < 
>>> NR_MIN_EXITING_PROCESSES)
>>> +               tlb->swp_freeable = 1;
>>> +       else
>>> +               tlb->swp_freeing = 1;
>>> +
>>> +       return false;
>>> +}
>>> +
>>> +/**
>>> + * __tlb_swap_gather_init - Initialize an mmu_swap_gather structure
>>> + * for swp_entry tear-down.
>>> + * @tlb: the mmu_swap_gather structure belongs to tlb
>>> + */
>>> +static bool __tlb_swap_gather_init(struct mmu_gather *tlb)
>>> +{
>>> +       tlb->swp = kmem_cache_alloc(swap_gather_cachep, GFP_ATOMIC | 
>>> GFP_NOWAIT);
>>> +       if (unlikely(!tlb->swp))
>>> +               return false;
>>> +
>>> +       tlb->swp->local.next  = NULL;
>>> +       tlb->swp->local.nr    = 0;
>>> +       tlb->swp->local.max   = ARRAY_SIZE(tlb->swp->__encoded_entrys);
>>> +
>>> +       tlb->swp->active      = &tlb->swp->local;
>>> +       tlb->swp->batch_count = 0;
>>> +
>>> +       INIT_WORK(&tlb->swp->free_work, tlb_swap_async_free_work);
>>> +       return true;
>>> +}
>>> +
>>> +static void __tlb_swap_gather_mmu(struct mmu_gather *tlb)
>>> +{
>>> +       if (static_branch_unlikely(&tlb_swap_asyncfree_disabled))
>>> +               return;
>>> +
>>> +       tlb->swp = NULL;
>>> +       tlb->swp_freeable = 0;
>>> +       tlb->swp_freeing = 0;
>>> +       tlb->swp_disable = 0;
>>> +
>>> +       if (__tlb_swap_gather_mmu_check(tlb))
>>> +               return;
>>> +
>>> +       /*
>>> +        * If the exiting process meets the conditions of
>>> +        * swp_entry asynchronous release, an mmu_swap_gather
>>> +        * structure will be initialized.
>>> +        */
>>> +       if (tlb->swp_freeing)
>>> +               __tlb_swap_gather_init(tlb);
>>> +}
>>> +
>>> +static void __tlb_swap_gather_queuework(struct mmu_gather *tlb, 
>>> bool finish)
>>> +{
>>> +       queue_work(swapfree_wq, &tlb->swp->free_work);
>>> +       tlb->swp = NULL;
>>> +       if (!finish)
>>> +               __tlb_swap_gather_init(tlb);
>>> +}
>>> +
>>> +static bool __tlb_swap_next_batch(struct mmu_gather *tlb)
>>> +{
>>> +       struct mmu_swap_batch *swap_batch;
>>> +
>>> +       if (tlb->swp->batch_count == MAX_SWAP_GATHER_BATCH_COUNT)
>>> +               goto free;
>>> +
>>> +       swap_batch = (void *)__get_free_page(GFP_ATOMIC | GFP_NOWAIT);
>>> +       if (unlikely(!swap_batch))
>>> +               goto free;
>>> +
>>> +       swap_batch->next = NULL;
>>> +       swap_batch->nr   = 0;
>>> +       swap_batch->max  = MAX_SWAP_GATHER_BATCH;
>>> +
>>> +       tlb->swp->active->next = swap_batch;
>>> +       tlb->swp->active = swap_batch;
>>> +       tlb->swp->batch_count++;
>>> +       return true;
>>> +free:
>>> +       /* batch move to wq */
>>> +       __tlb_swap_gather_queuework(tlb, false);
>>> +       return false;
>>> +}
>>> +
>>> +/**
>>> + * __tlb_remove_swap_entries - the swap entries in exiting process are
>>> + * isolated, batch cached in struct mmu_swap_batch.
>>> + * @tlb: the current mmu_gather
>>> + * @entry: swp_entry to be isolated and cached
>>> + * @nr: the number of consecutive entries starting from entry 
>>> parameter.
>>> + */
>>> +bool __tlb_remove_swap_entries(struct mmu_gather *tlb,
>>> +                            swp_entry_t entry, int nr)
>>> +{
>>> +       struct mmu_swap_batch *swap_batch;
>>> +       unsigned long flags = 0;
>>> +       bool ret = false;
>>> +
>>> +       if (tlb->swp_disable)
>>> +               return ret;
>>> +
>>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
>>> +               return ret;
>>> +
>>> +       if (tlb->swp_freeable) {
>>> +               if (atomic_read(&nr_exiting_processes) <
>>> +                   NR_MIN_EXITING_PROCESSES)
>>> +                       return ret;
>>> +               /*
>>> +                * If the current number of exiting processes
>>> +                * is >= NR_MIN_EXITING_PROCESSES, the exiting
>>> +                * process with swp_freeable state will enter
>>> +                * swp_freeing state to start releasing its
>>> +                * remaining swap entries by the asynchronous
>>> +                * kworker.
>>> +                */
>>> +               tlb->swp_freeable = 0;
>>> +               tlb->swp_freeing = 1;
>>> +       }
>>> +
>>> +       VM_BUG_ON(tlb->swp_freeable || !tlb->swp_freeing);
>>> +       if (!tlb->swp && !__tlb_swap_gather_init(tlb))
>>> +               return ret;
>>> +
>>> +       swap_batch = tlb->swp->active;
>>> +       if (unlikely(swap_batch->nr >= swap_batch->max - 1)) {
>>> +               __tlb_swap_gather_queuework(tlb, false);
>>> +               return ret;
>>> +       }
>>> +
>>> +       if (likely(nr == 1)) {
>>> + swap_batch->encoded_entrys[swap_batch->nr++] = 
>>> encode_swpentry(entry, flags);
>>> +       } else {
>>> +               flags |= ENCODED_SWPENTRY_BIT_NR_ENTRYS_NEXT;
>>> + swap_batch->encoded_entrys[swap_batch->nr++] = 
>>> encode_swpentry(entry, flags);
>>> + swap_batch->encoded_entrys[swap_batch->nr++] = 
>>> encode_nr_swpentrys(nr);
>>> +       }
>>> +       ret = true;
>>> +
>>> +       if (swap_batch->nr >= swap_batch->max - 1) {
>>> +               if (!__tlb_swap_next_batch(tlb))
>>> +                       goto exit;
>>> +               swap_batch = tlb->swp->active;
>>> +       }
>>> +       VM_BUG_ON(swap_batch->nr > swap_batch->max - 1);
>>> +exit:
>>> +       return ret;
>>> +}
>>> +
>>> +static void __tlb_batch_swap_finish(struct mmu_gather *tlb)
>>> +{
>>> +       if (tlb->swp_disable)
>>> +               return;
>>> +
>>> +       if (!tlb->swp_freeable && !tlb->swp_freeing)
>>> +               return;
>>> +
>>> +       if (tlb->swp_freeable) {
>>> +               tlb->swp_freeable = 0;
>>> +               VM_BUG_ON(tlb->swp_freeing);
>>> +               goto exit;
>>> +       }
>>> +       tlb->swp_freeing = 0;
>>> +       if (unlikely(!tlb->swp))
>>> +               goto exit;
>>> +
>>> +       __tlb_swap_gather_queuework(tlb, true);
>>> +exit:
>>> +       atomic_dec(&nr_exiting_processes);
>>> +}
>>>
>>>   static bool tlb_next_batch(struct mmu_gather *tlb)
>>>   {
>>> @@ -386,6 +678,9 @@ static void __tlb_gather_mmu(struct mmu_gather 
>>> *tlb, struct mm_struct *mm,
>>>          tlb->local.max  = ARRAY_SIZE(tlb->__pages);
>>>          tlb->active     = &tlb->local;
>>>          tlb->batch_count = 0;
>>> +
>>> +       tlb->swp_disable = 1;
>>> +       __tlb_swap_gather_mmu(tlb);
>>>   #endif
>>>          tlb->delayed_rmap = 0;
>>>
>>> @@ -466,6 +761,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
>>>
>>>   #ifndef CONFIG_MMU_GATHER_NO_GATHER
>>>          tlb_batch_list_free(tlb);
>>> +       __tlb_batch_swap_finish(tlb);
>>>   #endif
>>>          dec_tlb_flush_pending(tlb->mm);
>>>   }
>>> -- 
>>> 2.39.0
>>>
>> Thanks
>> Barry
> Thanks
> Zhiguo
>


