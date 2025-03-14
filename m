Return-Path: <linux-arch+bounces-10757-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE6AA607C0
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 04:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B3916F2B8
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC931339A4;
	Fri, 14 Mar 2025 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IySOSGHi"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D8130AC8;
	Fri, 14 Mar 2025 03:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741922899; cv=fail; b=ItMA9bOOgGC3qqJGBekYyiXGu1nLRPXR+mMWqqRoSiXVOWhQRxOQtfMObc2nV9JHAMQWgXvZonAdA09aoBVQmX1SIRSiY5qiW6lNCVz17uCKmAKkesXFAmqD5jSBJ6XdxV6tIcm3+X7JqZSQq7xwEeWytum6S4ZvcnkNRJG3r4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741922899; c=relaxed/simple;
	bh=BOWRFNvCjNXVkJ1yjwfvXMSVff9c+ll1DWTi0mlfxXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PFi3WuwWKo2xvkEVL7SJdcT6OEOmrGBL8ecFDGUQoJvmqPqhd3m8oieF2qfT9Fd9KQgER82Z42cByFpDZf9Uin0VajcbbCcHnlFW4ys8Mdfc5rc1KPbfyAKHPhInkGLmt2Ro86uhelx4aa8qMxRlEw2cNz7gKw1+bmUqR/BePEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IySOSGHi; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7TrVfbuurm2+68HO5fnEPO/XBgNA+KbhB4c7ipqKZHv9V2DZ1KQd8y4yQtAQizUv3EF412R9RecrWFc74sBrOWEyh+UbhfJoPBW8txkLJHZTyubSr3tqIlwJsPf7PHysY89Ig4mISXrXOC3zyMQnS4RNwh8luFU4RGbvMk8JbnRIdiZmdbDVL/eiYWUs5CXCAn5GpMm0dhEzW152VHt+oCCOkoK0ir/Gkib2I1LTBnrmjVT5IozI2EwLkiSQhP4SdpkrQ1ohzkresy6cRxL+Hfn1Lbwr4SeW/29/lG8cI19n3n6jIGuiuTg506wjEfE5ugeDiwthw2fUEoZB9RCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpr0HsvDFjoQaOCAnF6Vwtt8xlBWn1gZv1OGhFcTqIw=;
 b=njQoEiyjsMwI5858KfPZN17fpdxZe1imA0Sauvp+WbYheCd6DieZKjC+ffEsLB1vUf15gvlRcg9EdvWwP+pO3WN+FCokSJI/LcT091RI0UHqFj00bRIqhNlWaIpKjm29IHEy7gSeg0tFC5iIyKvzaU6iIvkqE+MqnjA51uy5AgyA4VDNw8tQFGQan7L9So+iIkS0ktvUt9jJG9CV+yFAjHVDU7/2w0SQjnnLfVKoCCaSprW5umeic3bwt1IgL2Y/tSGq/aNAccmuyYbvMIYZA+VbhbWhQsITdtAwTwstFzmyIkPS9s40RwUUYpOh4L5LzLPJ3Gsq/axFp3uA/kGIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpr0HsvDFjoQaOCAnF6Vwtt8xlBWn1gZv1OGhFcTqIw=;
 b=IySOSGHifg/FOa+o98zVSV5f5zPlAsMX0cULrhwCgULrL7AKT7EjgbSs5lMCDNF3OHQGXixJAJHkHwVaxOA3KdOsLbBTz86Udxu/eCM4SwX5yXuiGZlbqqBq6S21OmDMFy9BCimAnRV0kl0kZgHIvZlidpMoxkF/czcbE0k7SWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 03:28:14 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 03:28:14 +0000
Message-ID: <844aca18-6d75-4a75-801a-09ae12d1f512@amd.com>
Date: Fri, 14 Mar 2025 14:28:00 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 06/22] KVM: X86: Define tsm_get_vmid
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, x86@kernel.org
Cc: kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Michael Roth <michael.roth@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Joao Martins <joao.m.martins@oracle.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Steve Sistare <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev, Zhi Wang
 <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-7-aik@amd.com>
 <67d23a3e6667_201f0294ed@dwillia2-xfh.jf.intel.com.notmuch>
 <7719c1ad-84b8-40e2-9ce7-93248a410ebd@amd.com>
 <67d32d60bf4f4_1198729418@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67d32d60bf4f4_1198729418@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0144.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d5::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: eca58bc6-1570-4cfc-bd5b-08dd62a84122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjNzZDh4UWo4cFFCVnhBeFREMEdRU2lrQndiWVhNenBsRFdqOVFvenI0c2Zy?=
 =?utf-8?B?UGNUcENsWldVcVZhcG9nVnJRZXNVWk1PUUxlUHZBcUg1eXBqaklLdzlDcFlr?=
 =?utf-8?B?TWJ6TTVPN0dTMGV4RExuZXNmM3lFQkE1dytkaTFLdG02eXYzYkw1a1UrT1hi?=
 =?utf-8?B?dEE4cnRnaUxmV0pHZytNYWZEckJxYlpvTkRFMTYwZnJSYyt0L2J0ZllDaTlL?=
 =?utf-8?B?cS96emFxR3pYVXV1VWl6V3hMblFSTGlnZmtNM1c0N0s2MGRPVTVWSk5qdlpX?=
 =?utf-8?B?M2pKU1dRcVVDdm93QUFUTERJdDZ0K210c1BaaitBRC9qc01rZkhkTi9PcEZY?=
 =?utf-8?B?MGd6ditrWHAwb3U2Y2NoVGF4VVErMkNWWjZaSHU2QWxub3d6Q1kvY1RRcG9D?=
 =?utf-8?B?aG5pRlRvWmdOeitmQ1pna04veEZpa283ZkFKYXVsSXltRDY2d1RXdHp4a3lk?=
 =?utf-8?B?NmF3RVEzWHNiTGdjbER1Y3piMWIva1VjUDZjZ1lsSDN1RzJDTkZIZnFaMkF5?=
 =?utf-8?B?UmpDUGJwTXNMaFVQNk10ZjVzM2VDeTlHVTUvY0txTEI5cVdoeCs2cmVMYktT?=
 =?utf-8?B?elFtSm1hRHVqMXZCUDlFQXhaWlV4eU5IMmJOcmIyN0o2aGNJenRzbUtRaVU3?=
 =?utf-8?B?V0U2T0t1RTlIcFNoOHowVGUxYmsxV252aVNHRTF4dFlpNUVhM3pmUFhyVUNH?=
 =?utf-8?B?RkpDSUhneU5UVnk2dEZuU3RUQ2R5YWdzUjBBZUI2RXgrRllnVVo4YnlFUFV0?=
 =?utf-8?B?UERib3JERUZoTGpXT1JIT1dUUFlMZGlML0hkZ2NTS3lpNUttSWFQNEpsUjRH?=
 =?utf-8?B?eHhxUFQ4MzBjZ25DKy9qNkw0Um1xMjJ4bEp6ZkxkTGxXUXZYU214ZlQ5WEs2?=
 =?utf-8?B?SVFSY1BZWDlXakpEZEpYRFFSUS9TUkE5ajdTMUxhcVp3NjRHUCtEdzFCOXd5?=
 =?utf-8?B?VTdhMGE3alFrd3piZyt0ODduanljZnVsbnZaSzQ5VkhaV2R4M0F0Z1hFUkxa?=
 =?utf-8?B?UEJxaDBEWFBJaVl1K1dqbzIveVNYdzVBUXNXVXZYN2hnYjVNNGdiSTdpS2M0?=
 =?utf-8?B?bTVIQnlHWVhXL3JDQlhXczZrVnQzdnRZYlNRWXY5UHVsTW9OTGRsbFlKTlJJ?=
 =?utf-8?B?MUxBbzJhWkZIKzllZ1FydEtKQWVvanc5S09RMkxOYzlSOEhWQURKRmtyVHVt?=
 =?utf-8?B?NGhKS0c1N2ZRSU5jSHRzM1FSbi80UFpaejFnSUU5UktFMDJ5TXpNKzBIbldx?=
 =?utf-8?B?bzVtNlF5eHNvRTNmQitDTy80bjg3SWljZGxCelBLNVR3RTNDU0g2eGNtUVU0?=
 =?utf-8?B?Rll1dW16OWlyOHFWYkxoUW1VZ3lOMzRKcStKVjdMZ0tnem1xMy9WV0FCSW1z?=
 =?utf-8?B?SDdib2M5SFpqV3JWc0crUmtPYktLdy94K1JTSUlTWDRwWitVaGVHNzR4bi9X?=
 =?utf-8?B?a1dGMFIwR2xpSWdwS3lDdW00M0l3SU5QS2VDNEZiS0tIZG1RT2Vrb3BGeU00?=
 =?utf-8?B?Zm02WWR1akFocmsyVFZXU0pWSVpvZXZaUlBmaTh3M2w0ZVpUQXdtUVcvanJT?=
 =?utf-8?B?T1g0NWVwbTd5SHhkbnhVZVhQZkpSNFJSajVUVjg0RkR4VGpia1VxVTI1VEtz?=
 =?utf-8?B?ckVZTkhHTGtER29RbzhsQXh5TExMc3EvWFp6UUxlcFh0ZTFQLzFkSTFNSEoy?=
 =?utf-8?B?NHI2YkFCbU5ySDBIV0lKcHd4WjQyd2ZlMElXN2xCQitrUjBGR1FHZlVzNnh0?=
 =?utf-8?B?cjc0UkppUW4ydjRaOGtJT2h0amlrdCtEVFhzdlgxaVc3Ulp6eEhpUnJwSnhk?=
 =?utf-8?B?Wm1tekFFSkNTdmVwSjd6OUJLY0o1UDVDL0VBU2RzSTBhRjdBaTlXT2dZSDJj?=
 =?utf-8?Q?hec2QmrBuP+OH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmxjNWx3d0wvbG9Xc2NnNFJUSVNsNHp6SGd4aEE2U3M4Uy96NWlXcG9kUFhI?=
 =?utf-8?B?VUJ2N1BobmNYSXRlcjJtY3J3bE5MMUdYY01JUHRvZUVjanNiVHJtN0M1L01S?=
 =?utf-8?B?aGp6TmkzYjdaWDhIdGdhem5HQjBIQVZiQ1l4UjhuVm9Hd0R2QW5qUzd5WVFZ?=
 =?utf-8?B?bFZHYzlqZDFhWlpvVWI0YzEyVVFGcU5NSTRSd2JVRjA5TGFEU2hjMzk0ZVl0?=
 =?utf-8?B?YXBGTXp0aWpkRkptSkZBOGdjTTVJeE9YYzRQRVBRTzd5emt1Wm5TR3pzVmtB?=
 =?utf-8?B?SmpMNDRKcTBmNGFzQ2VCQkNSRVh2QVNWcWE4c2t6UUtod0JpOFM2VFA3SEVO?=
 =?utf-8?B?ZWs1bG9RQ3FQemErdFlzNU9WL2hzSTVtOUpGaEFLdE1hVlFNbmFCazVTZmRs?=
 =?utf-8?B?a1pEc0J5TXAwRkpsV1hWTVBHSm1FMlg1VVlWSTUxMlJLNXZGWEpDcmRrYzhy?=
 =?utf-8?B?TjhKWGlPa1g1cDluWWRJdHNDWFQ5K3NvN2JBaDI0aXNoRjNhZXNzM0tyRVFD?=
 =?utf-8?B?Sm5zVEowMEJVS28vdGJRK2VrS2NlZ2d3SE4rdnozVnhkdUtVMGd0TFMwZE9x?=
 =?utf-8?B?RFZqWkM3VjJXU2ZSdmVUNkM2RWNtYnZ2OE02WDBKMlFJajFGNUZVZjZ0OWxG?=
 =?utf-8?B?VktQVUpQdlZVbm1oVWVpVGNXYWJ1ekdnckVCWVBQT2hwYndKSkNwNzZXTHVC?=
 =?utf-8?B?cmdrK1hPc2VhVVdJM1BNT0JYR3NRVU9iTGVHYzM4OVVaV1ZVbWJRT2kwUzFK?=
 =?utf-8?B?N3dlTDBUdFBKVUcwRmhDZDEwZGM1cXhtSjFDRDhEemlwMGtvVkZFK1ZJWGxM?=
 =?utf-8?B?M1BIdFBub3NGa00rbU9IQ2Vob0pWMThyajNXS2V1TFZpb2NLVFdPNnJOMDUy?=
 =?utf-8?B?SGtOTjc3aXpYVENFM1JyWGxpTW1lVlNtSUVmWDdJSjFyNWZ4QkNoT2ozdUJ5?=
 =?utf-8?B?NStTczhrT1pXSng4aU1LdG5Hbm1CZkw0WXlkaHBrMXdXWkk5Ymk0eTAxMCsv?=
 =?utf-8?B?eU14QldBODNwcC9sRENmcVdQTXoyWGZEL1grY0dLM3VYR05EWTFZR3BlejIz?=
 =?utf-8?B?MG9rQUtCTVdzS1RoQ1poeG5QL2pqd0UvWDhiMzBPVWlFMlQwdFd2NXRlcWFS?=
 =?utf-8?B?MFJjaTNCaUJZZHROaWZSN3RjaERBR294SmcrQkJqZmRtUFZBYmVQUUkvd1Va?=
 =?utf-8?B?RStocEJaWk80cWdXeGY0OXRvUSsvMWRBb2pJY2JkU2VmT21LaSttNUJiOTVM?=
 =?utf-8?B?UGRSSG1rYUYwZWdDVVdRbUdLaDBkMFp3N0J1M2VQcWpRc0R6ajhJVDdGcDZl?=
 =?utf-8?B?bVhRNWFXanZSYk1MOTNONERTSFJiYnNhdWxFTVE5TVJRNCt5cERKMlRiYUtX?=
 =?utf-8?B?ZytDVDc5U09Mb09meHZ5anBrUk9nWldFa2pwQmlQNm9BVEVzMUpYcW5PbzBY?=
 =?utf-8?B?UnI3eXVuZThFYjdOV2FvTDA5aDdESlZrRk9ETWo0aGU5OVUvUUJBR2ROTkI4?=
 =?utf-8?B?R014Y1JZWldGeDd3RnFqSWxXbExGTStiTjFWaWZhRHhPajUyTjZvYzFyYmtp?=
 =?utf-8?B?bXhyUi8xQklIRTM5d0l5TUZvR01vT1RzdkJuRW1zMWR6bnJoak9ndXp2cVc0?=
 =?utf-8?B?ME43SUtTTDFjVEpCS1BvalQyRnh2VXArWjhOKzFFK3lYUzdXbExpNUg2SjR3?=
 =?utf-8?B?VHJFMzJrN1IyQ1RNODdHY1VYcjQrR1phN01uOXZjMFlEUHR5RStLN052SmVI?=
 =?utf-8?B?V1dXeDk5Z0pqeDhPWm1pazNhZE1iMjlxbHVJa3lTaW1uWWM0dnVXMjZETnlX?=
 =?utf-8?B?YzFkbnFlTzRaT2FwVHFEN0N0MUYxK0VSUnFXKzhBL1dXQ2RzQTFsc2ZWRXg0?=
 =?utf-8?B?NWZLdFVlMFUyYm04QmVldUY3V2kzU044bFdCOUF1VmFKeW1DdEdlanZFeEha?=
 =?utf-8?B?bWM2dk1iRS9FKzlwY2lKKzAvR3J3STR1QUpoeXVoYTdmM3hJemMxVzFHRkc5?=
 =?utf-8?B?R1ZjdWJvMlRRMWNRa1hka2dQQ3JXRnRUa0pGSmFvYUJaeUVoUDVSdmEvV0gv?=
 =?utf-8?B?Rng2SGNnem1IeWJtWEZwWUNXV2pYc3Z4RzIvazFQTmtJRitRak0yd3J1a0J5?=
 =?utf-8?Q?4HsF3xRYbq1mP6auUid1cHt5L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca58bc6-1570-4cfc-bd5b-08dd62a84122
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 03:28:14.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stfe9AyzGVIX5Vk1Nlwsihw+wVWjz2/F2nvVKedSPeM34jFgJ62I5pqChjj+PmBneRQJtd8VtZZyzmBvtVMBHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692



On 14/3/25 06:09, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
>>
>>
>> On 13/3/25 12:51, Dan Williams wrote:
>>> Alexey Kardashevskiy wrote:
>>>> In order to add a PCI VF into a secure VM, the TSM module needs to
>>>> perform a "TDI bind" operation. The secure module ("PSP" for AMD)
>>>> reuqires a VM id to associate with a VM and KVM has it. Since
>>>> KVM cannot directly bind a TDI (as it does not have all necesessary
>>>> data such as host/guest PCI BDFn). QEMU and IOMMUFD do know the BDFns
>>>> but they do not have a VM id recognisable by the PSP.
>>>>
>>>> Add get_vmid() hook to KVM. Implement it for AMD SEV to return a sum
>>>> of GCTX (a private page describing secure VM context) and ASID
>>>> (required on unbind for IOMMU unfencing, when needed).
>>>>
>>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>>> ---
>>>>    arch/x86/include/asm/kvm-x86-ops.h |  1 +
>>>>    arch/x86/include/asm/kvm_host.h    |  2 ++
>>>>    include/linux/kvm_host.h           |  2 ++
>>>>    arch/x86/kvm/svm/svm.c             | 12 ++++++++++++
>>>>    virt/kvm/kvm_main.c                |  6 ++++++
>>>>    5 files changed, 23 insertions(+)
>>>>
>>>> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
>>>> index c35550581da0..63102a224cd7 100644
>>>> --- a/arch/x86/include/asm/kvm-x86-ops.h
>>>> +++ b/arch/x86/include/asm/kvm-x86-ops.h
>>>> @@ -144,6 +144,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>>>>    KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>>>>    KVM_X86_OP_OPTIONAL_RET0(private_max_mapping_level)
>>>>    KVM_X86_OP_OPTIONAL(gmem_invalidate)
>>>> +KVM_X86_OP_OPTIONAL(tsm_get_vmid)
>>>>    
>>>>    #undef KVM_X86_OP
>>>>    #undef KVM_X86_OP_OPTIONAL
>>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>>> index b15cde0a9b5c..9330e8d4d29d 100644
>>>> --- a/arch/x86/include/asm/kvm_host.h
>>>> +++ b/arch/x86/include/asm/kvm_host.h
>>>> @@ -1875,6 +1875,8 @@ struct kvm_x86_ops {
>>>>    	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>>>>    	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>>>>    	int (*private_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn);
>>>> +
>>>> +	u64 (*tsm_get_vmid)(struct kvm *kvm);
>>>>    };
>>>>    
>>>>    struct kvm_x86_nested_ops {
>>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>>> index f34f4cfaa513..6cd351edb956 100644
>>>> --- a/include/linux/kvm_host.h
>>>> +++ b/include/linux/kvm_host.h
>>>> @@ -2571,4 +2571,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>>>>    				    struct kvm_pre_fault_memory *range);
>>>>    #endif
>>>>    
>>>> +u64 kvm_arch_tsm_get_vmid(struct kvm *kvm);
>>>> +
>>>>    #endif
>>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>>> index 7640a84e554a..0276d60c61d6 100644
>>>> --- a/arch/x86/kvm/svm/svm.c
>>>> +++ b/arch/x86/kvm/svm/svm.c
>>>> @@ -4998,6 +4998,16 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
>>>>    	return page_address(page);
>>>>    }
>>>>    
>>>> +static u64 svm_tsm_get_vmid(struct kvm *kvm)
>>>> +{
>>>> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>>>> +
>>>> +	if (!sev->es_active)
>>>> +		return 0;
>>>> +
>>>> +	return ((u64) sev->snp_context) | sev->asid;
>>>> +}
>>>> +
>>>
>>> Curious why KVM needs to be bothered by a new kvm_arch_tsm_get_vmid()
>>> and a vendor specific cookie "vmid" concept. In other words KVM never
>>> calls kvm_arch_tsm_get_vmid(), like other kvm_arch_*() support calls.
>>>
>>> Is this due to a restriction that something like tsm_tdi_bind() is
>>> disallowed from doing to_kvm_svm() on an opaque @kvm pointer? Or
>>> otherwise asking an arch/x86/kvm/svm/svm.c to do the same?
>>
>> I saw someone already doing some sort of VMID thing
> 
> Reference?

Cannot find it now, RiscV and ARM have this concept but internally and 
it probably should stay this way.

>> and thought it is a good way of not spilling KVM details outside KVM.
> 
> ...but it is not a KVM detail. It is an arch specific TSM cookie derived
> from arch specific data that wraps 'struct kvm'. Now if the rationale is
> some least privelege concern about what code can have a container_of()
> relationship with an opaque 'struct kvm *' pointer, let's have that
> discussion.  As it stands nothing in KVM cares about
> kvm_arch_tsm_get_vmid(), and I expect 'vmid' does not cover all the ways
> in which modular TSM drivers may interact with arch/.../kvm/ code.
> 
> For example TDX Connect needs to share some data from 'struct kvm_tdx',
> and it does that with an export from arch/x86/kvm/vmx/tdx.c, not an
> indirection through virt/kvm/kvm_main.c.

a) KVM-AMD uses CCP's exports now, and if I add exports to KVM-AMD for 
CCP - it is cross-reference so I'll need what, KVM-AMD-TIO module, to 
untangle this?

b) I could include arch/x86/kvm/svm/svm.h in drivers/crypto/ccp/ which 
is... meh?

c) Or move parts of struct kvm_sev_info/kvm_svm from 
arch/x86/kvm/svm/svm.h to arch/x86/include/asm/svm.h and do some trick 
to get kvm_sev_info from struct kvm.

d) In my RFC v1, I simply called tsm_tdi_bind() from KVM-AMD with this 
cookie but that assumed KVM knowledge of PCI which I dropped in this RFC 
so the bind request travels via QEMU between the guest and the PSP.

All doable though.

>>> Effectively low level TSM drivers are extensions of arch code that
>>> routinely performs "container_of(kvm, struct kvm_$arch, kvm)".
>>
>> The arch code is CCP and so far it avoided touching KVM, KVM calls CCP
>> when it needs but not vice versa. Thanks,
> 
> Right, and the observation is that you don't need to touch
> virt/kvm/kvm_main.c at all to meet this data sharing requirement.

These are all valid points. I like neither of a)..d) in particular and I 
am AMD-centric (as you correctly noticed :) ) and for this exercise I 
only needed kvmfd->guest_context_page, hence this proposal. Thanks,


-- 
Alexey


