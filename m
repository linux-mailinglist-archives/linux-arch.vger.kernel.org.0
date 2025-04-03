Return-Path: <linux-arch+bounces-11242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4933A79E5B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC343B3FBF
	for <lists+linux-arch@lfdr.de>; Thu,  3 Apr 2025 08:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A61F0997;
	Thu,  3 Apr 2025 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cQWtXnim"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66732A8D0;
	Thu,  3 Apr 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669613; cv=fail; b=i1o+hJX6kOvPainJjOVmAa7dfmHxJWNjcPe6VSuVcqce9si8REWbRPrFXyIKF8d5mlFqC4NNoNPXL62lKEd7g9LKvLNUJBvlZ6KmtXo4l8Tg0+o1Zee1PMCm6TAHeZ7esuBKFwXEyKh4XTQzwMvGWOR706JZEBLhnh1ETVQTX2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669613; c=relaxed/simple;
	bh=i5djiIf3m4BvoO5LmDdoHN2pr06dj5+RrlGQzP28ojo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZArJUdmsuRsDN9SDA/77Kr3fvbg13EKFbqODstq62hwCe77V22GXCziGzmtEGtwRBZNXofpOzkpI6YFQ/DqKpuFgXEydKQ9EpkLYO9F5MW9ZqPOEwu4UnpHhEnHUSISPpNw6URpqw5Pi0RfleUi+xk5rJfFmrndu4SbXFBe1mBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cQWtXnim; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2Sda6Ili4roGIqAFd6xeNwTe0C1PpSxQXHKtVR0uMBegpkAwS0HJTtAMInHZMMGLCOPQ/40I+ulb7+apIPneTrjW5TkDSQiLBoyKgvbDiTjuORPem6RLKsZvbGsyp53zIR5QmZ7AH/lhHu+2JcDEvtKPjkVuT3wIWZ+yNqkkvY7QDl3dCe1lelHBSHPui3L6TjPe+3vRZ5AqlRo1n5yR7qLlcem1djlZoOVpiy9VfGbwWdOcGoVsROh9EDqQfBWLcaRmRp0hALsSgNd69/p90zuW5sVsCszeIxbk7Epy1uA1YCVCmCxY3TVKFuXhucQjRHqNwZXiwIywMbQHspzWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GisPSuw7nUXZfdY0yy7px5/wrzgbWFFXWkEsg43Xnz8=;
 b=MggHciyOCmla1cOyt07W4iBNn2XQQ9IH9dLn1nSLmliZpVacdj2toZ3g07b96v1ab8l0SGpe4PPqxIukvu06SETswiqqaXGxpWMdvuiS54keVP/7zMNQW/9zT3DbELKGVn1JVAYlivRLn6DySsasRBYS29IyypVMDxhjoDmtCFST1pl0u+XkOq/XTr2LLNJHnt3dUTtIfqhfVLmS/qyM3HUXsiFa8typEeFyCvNN8S566e0HRXuApGPPS5oGfiUra6WHiCO0++1evErwEcn5IWK3tW57MsYmVAgJ3Xabl33qvh4WZTiNmc9OQbzX4eujYXhdktiymLSJpAQQE6r2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GisPSuw7nUXZfdY0yy7px5/wrzgbWFFXWkEsg43Xnz8=;
 b=cQWtXnim3PHFWbaYqLdXOTDZlNSgkvFhV4F3DHGRrxHhbXBRy6nA6CNqeKG2PU6/OfSJf5QOwltxCGu6Kxkh+zh0/Q5ssR/cqbljOLLhhDYWKM9EJ0UMOtDEKj2ykwyMfB/cOXonqOLDZEQBI1NoAFfdbZL/gjQbGz4avfn2cR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 08:40:07 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8534.052; Thu, 3 Apr 2025
 08:40:07 +0000
Message-ID: <8986eed9-5a40-472a-a211-9607666b2c49@amd.com>
Date: Thu, 3 Apr 2025 19:39:54 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Joao Martins
 <joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Steve Sistare <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev, Zhi Wang
 <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com> <20250401161259.GM186258@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250401161259.GM186258@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0088.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:f6::21) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b499bc-d99d-4845-be6e-08dd728b2335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlBseXFzVHczVzliUjYvZXpxUjZidlJNUVVHdWowamxCeVRMQjlrdFNRZm1M?=
 =?utf-8?B?UkJVbzA1clVkdUl1dDlYNmo0VlhuNEdxOFlBdUlmQmRLUEtuNXFReXFkY01n?=
 =?utf-8?B?NjAyNzNwempqVkdEaENVVkI5b3pPOGJoMGNDcU1pUEtSRXBpR2pOcWEvdGw0?=
 =?utf-8?B?S0RIRjU5Z0tkQmFDbU5IYUEyR0R0em9sajlwN3JpVXUwaXZhSXJNWUtrOUxv?=
 =?utf-8?B?WnRscnRMVkgxK2IzaGFLcFJ2cWxsQWhJNjlvbXhQWHdqdDZ5VkRqdlZNTCtj?=
 =?utf-8?B?S3l0QWhhU1Y3UmdkZWwwYVV5Si9rZU04VHNrSXo3QVBIL3NVbWJBS0VSa2tz?=
 =?utf-8?B?UjU4L2g4TS9DUnRlY3NVZDJGQVBGZExGd3BjbGpibE9oT0RZb2Z3cnh4aERD?=
 =?utf-8?B?YUlPZTVOWnRHa3ZuR3Y5dmpKZysyU3VUMnlLbnlKUDF6aEVJSzJSRlVob254?=
 =?utf-8?B?M2tXTGgxQzlieHBYZDl4ZGsyd0dpZGpUMThVMnN0TnNhbWM0VzhydVBEZmlS?=
 =?utf-8?B?dDM2SWJzWHJFR3FPanNsczdtMXJJR3U2aDJpNjdpdVNaVjdjYm5oWkc4cmxl?=
 =?utf-8?B?MVdHb1FZcituSWY3eXFvOXpseG5KVlYwMzRqem9jUnNlQ1ZoU2N6UGNHd2RG?=
 =?utf-8?B?ZGQ4TUJLTFNvOS9RVTBaTnVIKzZoTGdUc2pRTTdRTjVxVlFkbDI1cWo3MkxR?=
 =?utf-8?B?ZVdFSFVRUzI0TVpCcmxvQjlvZ0lxemFmWkVGL2d6NHhTUm5EUDlWY1Z6bjgz?=
 =?utf-8?B?ZUlndGZkb1JQem5URFk2TUhPbkMwR2xVVkw2S3pTRllObkRnSFE4Vk4yeno1?=
 =?utf-8?B?UUlXZEs0VzdUR3U5RHR0VG5lSDF4QkFJNExLd1NSZzZXM1dkRWJ6WDNYbC84?=
 =?utf-8?B?M0xYT2JPQWFTbUYvLzIwSmQvL1VzNHk4TGlSZXZmbjlYMEtjblRjamNuWHJK?=
 =?utf-8?B?OHU4T2FhNEgzT2JScjR6cUdWOFYzWldNYy9xSjZTMk9XWHlTZDBNUmt5Q0NO?=
 =?utf-8?B?bkVqZi8xZStZeG1YRm40Y0hLS2pFKzROUzJYV2hENk5TOVUvQUx0TkRCbzRU?=
 =?utf-8?B?NWs4SHdWbnU4V00rODlrVmJmaFR4R2tiaEhGclBKKzc3Um9PaUhlZlNsTkJp?=
 =?utf-8?B?TDNJMnRNNzc0QVB4UTV3aTRSdDF4cHN5a0lBbS93NURINkFaRDVoZ25IMndY?=
 =?utf-8?B?ZDNMREx5YTFEUEgxWjVteHFOUXZPQW83S2NUdS9oL1l5OE1PeWZjNmhVZ2N2?=
 =?utf-8?B?UWdJTW1jRG42eGNWdFJEeTkrQVRvb0U2bmZRZWdjVk40V0NEWXBSWE1GQ3A4?=
 =?utf-8?B?VzRFMThaM1o0Rmp5ZlhhTy9ISUNuQ2ZZaWMxMW5zMjhweUZ6NmZLb1NhcXBp?=
 =?utf-8?B?dkltU3dwbFlaMUh6MXRLZE51OXB1Z1JtSXpGNmpxZEQwOFY0UWtlSUtsUXFn?=
 =?utf-8?B?dDlOdU5ZSGZzY0d5L0FUcmU1aXZqVm1Vc0lNN0d0RU5TVFFBbUxLdzd5SnBO?=
 =?utf-8?B?ZldtVWEwQjh1Tm1VUEU5RmN0bDZLQzZqUEI3eTNoTkFhSEQ5Z3J0S3ZIdkM1?=
 =?utf-8?B?M3cyMDRQM0NYTGV2cStNSEdGNEMyTGlsWk1yckIzN1ducWc2a0xpT1JEQjVv?=
 =?utf-8?B?M21WNVZQT2l1YVU4S0lsTVh0V1dTeWZzSlU1K21CbXNkVEo0NmVCNk9DUzNy?=
 =?utf-8?B?Rzl6elc0WG1kRXVkaTh3UzA3Qzd6NVNWeWhDbHQ0aEtyL25WTXpHKyt4YzFz?=
 =?utf-8?B?MUVsVzd0M0l3NStpNWRRRk9mMXdnR04zRUE3cjJoYlZNVGdNSlZodWpEWE1Y?=
 =?utf-8?B?QVc1ZC94Y2UxQW1GNyt3Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjU0MUptSnNyZ2laVUhtRFQ0bC9pRC9kVjJKOTdCUzB2T3EyVkcySFBscGZw?=
 =?utf-8?B?OEtUV3hteVIxa2JKdTZDVmNROG0waHJ3aUJsWldoVE55UGcvZXpMMWxQSFpu?=
 =?utf-8?B?dEpucU5KTzZFM0VVUXpnbUdOa2dxUUhmbjVxOFd0S09BTDVFZ0lmRWZmcDFB?=
 =?utf-8?B?MmVVUjN4K0VFY1NaOXlhMTJXVERnUll4TkljaTgvQUlMczhGRnRyY2R1REc2?=
 =?utf-8?B?ZkkxVzdYMDdHMENnMXVmamtJZElrNDhMZUx3V1REeDZhT09QY3FwaFJqRmEy?=
 =?utf-8?B?MHZqQXBETU9iSGhZT0R3OXdSZzV3WTAwV2h1czdQK0JrNnUzcU5NaVorQm4v?=
 =?utf-8?B?REpJRXROSk5TcXloSTdlUDVMdnZreSs5anVzT2dSeU9RaVBQL1JjZ2lBM1dI?=
 =?utf-8?B?ZE4vMTBmZkEvazNhWTNrbnJ2QklSRGdlQlJQZFg0Y2xVQkk3c3A5c3NMNXl1?=
 =?utf-8?B?QzNkVE1JOVJiYjRwQ1Frcy9UK0VjNE1kcDU0WFNyUVcyd2ZoQllYSDY1NXNl?=
 =?utf-8?B?YTR2Vk1RVGo1bzZaMnY1M0Zjb3FpMnlyTHYvMEtoWTZ4QWZNbERUeEk0cmla?=
 =?utf-8?B?VUgyMjhPVWNyRDR2V0hIdzJRYjJrcXVueVp5aWpCYWozU0tNQWJsSk8vTW80?=
 =?utf-8?B?dkVOS240OTlDaFhZYkI4OEpHSmhUR3h2SnlMZ0hodnBCRitKbCswVldlcCt0?=
 =?utf-8?B?TU1CWjJ3cXo1Z3N0bVI1N0NRdW12empPSThlUzEvZ2NOVGgxQ3BkV0pIZ3hr?=
 =?utf-8?B?YnhMYjBZbExoR1NjREFyU3YvcXJQSkRtUW9sd2FNRkpjZVZJcTNIdVh4UW94?=
 =?utf-8?B?TnVab2pLUG1Qci82dzVoU3dZaE1FYlREZlh4TXZ1cm9VS0tCTmZFR3ZVWFhl?=
 =?utf-8?B?T0VrckVwWnZBL3BOTGdrb1QvSU54QlJuNzFQRjlVeXhsemdpY2tsQ29mTmhG?=
 =?utf-8?B?NWJpM1RzOWpsaSttSHJtVitBaEhCQjJvK1oxODUxSUNQamxxUGhYY2Ftc2dm?=
 =?utf-8?B?WXAxT09YV2ljcEs1YThyVDI5YjVHWTVVc2F1ak5tc21yelJvQ002Q2JBWTl6?=
 =?utf-8?B?bTR2STVldGgrY3R3dDJDZC8zMlc3dWRVc0lBTGZTNmgvRnJlU2hrQWJoWTBQ?=
 =?utf-8?B?bmhBOVM5Z3phcVhSb1NWR0dKcnR5N0NuNmg1V2pOcGFWMkh3UC9jZW9pUmZq?=
 =?utf-8?B?OGlJTjBxZzJKTi9QOWJ2clpjV2ExMlJmSnFyUWQ4Tk1yeEhjeHhaWFdrMkVy?=
 =?utf-8?B?eWNCV1JRZTc4RnFqY3JjdUdRTGNJRVltQW44aWRUL0pQVG5DbnRKdERJRkpT?=
 =?utf-8?B?SnhSdGJ2SDNpZ1lTcUdneEJYTGoyaSs1bjJxdlRWUXVtUlAzcjAxaGlUZjBk?=
 =?utf-8?B?WkFSUkNidXA1TXRPOVg1RjZaTFJOeGtGNy9UTUV6dEJKUEJLTk12WS8rcUEz?=
 =?utf-8?B?RktJaG5VM0tydjZTWmVlL2VDcHJXN3NSRUZXbUx1UWlEcDlreXBHWHdJMktM?=
 =?utf-8?B?aUJ5NXJvOVMyYVZoU0c0RmVrQ0tSM2tvaGlzQkVDR3V6U3FyRThJTnJONTJK?=
 =?utf-8?B?T2NVY3FuNTFTNkxlY1UzY2h6WXJ0RHdYbDZIWWd1UHF4UWx3OEZLaldzSlIw?=
 =?utf-8?B?cnFiTjhSV3NvbnpyMllYOFdkZEUza0FKeksxWE45SDh6T09ZVkdoS0licWVM?=
 =?utf-8?B?YTBmbnM0WFhSR0xCVjZTcFhkY2VqVWhnM1NpMXA1ZzRHR2FJd2JieVBqSlY3?=
 =?utf-8?B?WTdKTEdLYU9DWUk4dTVjSjRxTGdOTTJ5M2xwZE43YTVPVHdDalRmbkh4S3RI?=
 =?utf-8?B?WXd2Rnd6OHArOER4VlpmWjVod0FETnIwbmNFaC9HSWJrc2Y3bjlVTk9EaXlk?=
 =?utf-8?B?eFphSEo3VFQ1b0dnTUhnQ3REWHBaU05PaHVlTk5penE4bldMRmtXQXV3Vjlx?=
 =?utf-8?B?VHZHbzhGNCt2Nlo0TnhjeEVUbGVPbXg2WDFUYnNuZThzVVV5OTNQM2xFUGsv?=
 =?utf-8?B?VnNQNUtkUklsaExOSU0zaEZ1NEJZYnFjbGZIejJqaXBHVkNCbDVaU0N3Ymk2?=
 =?utf-8?B?U2JHME9KTzRsdXJFMDFyUGVTMlg0WC83SEV3N05zNHlrTVI4RnJQVDBJRTEy?=
 =?utf-8?Q?mNyqrQ98YxbpmM5DZSz50x1YC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b499bc-d99d-4845-be6e-08dd728b2335
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 08:40:07.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnJE9Sa1CFvy9YHWu4dWIihX5gad6TqRtXC1PXG+x4oU/VCRgafcg0FFoiwLDrFeicgghnx4qu9d+kNWdgbQqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736



On 2/4/25 03:12, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2025 at 10:10:01PM +1100, Alexey Kardashevskiy wrote:
>> When a TDISP-capable device is passed through, it is configured as
>> a shared device to begin with. Later on when a VM probes the device,
>> detects its TDISP capability (reported via the PCIe ExtCap bit
>> called "TEE-IO"), performs the device attestation and transitions it
>> to a secure state when the device can run encrypted DMA and respond
>> to encrypted MMIO accesses.
>>
>> Since KVM is out of the TCB, secure enablement is done in the secure
>> firmware. The API requires PCI host/guest BDFns, a KVM id hence such
>> calls are routed via IOMMUFD, primarily because allowing secure DMA
>> is the major performance bottleneck and it is a function of IOMMU.
>>
>> Add TDI bind to do the initial binding of a passed through PCI
>> function to a VM. Add a forwarder for TIO GUEST REQUEST. These two
>> call into the TSM which forwards the calls to the PSP.
> 
> Can you list here what the basic flow of iommufd calls is to create a
> CC VM, with no vIOMMU, and a CC capable vPCI device?

I do this in QEMU in additional to the usual VFIO setup:

iommufd_cdev_autodomains_get() [1]:

1. iommufd_backend_alloc_viommu
2. iommufd_backend_alloc_vdev


kvm_handle_vmgexit_tio_req() in KVM [2]:

1. (IOMMUFD) tio_bind(pdev, kvm_vmfd(kvm_state))
2. (KVM) kvm_set_memory_attributes_private(mmio region)
3. (SEV) sev_ioctl(/dev/sev, KVM_SEV_SNP_MMIO_RMP_UPDATE)
4. (IOMMUFD) tio_guest_request() /* enable DMA/MMIO in secure world */

> I'd like the other arches to review this list and see how their arches
> fit

Well, I have it all here: https://github.com/aik/qemu/tree/tsm
Raw stuff so I did not post it even as RFC but may be it'd help if I 
did? Thanks,

[1] 
https://github.com/aik/qemu/commit/da86ba11e71f10d48dd40a8d71a2ff595f04bb2d
[2] 
https://github.com/aik/qemu/commit/f804b65aff5b28f6f0430a5abca07cbac73f70bc

-- 
Alexey


