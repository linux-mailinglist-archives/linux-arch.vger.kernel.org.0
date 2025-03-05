Return-Path: <linux-arch+bounces-10525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37DCA4F52D
	for <lists+linux-arch@lfdr.de>; Wed,  5 Mar 2025 04:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7C93A4E0E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Mar 2025 03:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33180132111;
	Wed,  5 Mar 2025 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LkaCWuZB"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2C3FBB3;
	Wed,  5 Mar 2025 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741144168; cv=fail; b=E+EVuoqx0+/V1/WDwVr0sB2TG3r+07cr3HddPx6asBTp77sxJ76aaD/6kQWiWAJIfUKK28A2grIfX5+zWGazHDT2Yw/TVGO89iun3ARGDC9kr4bvzCIGELlphHBE/H2HCjmbV8gQtfZNvQou+e7JXJz+cJAFkaBD4N9A4u+PVY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741144168; c=relaxed/simple;
	bh=lW5Ri0kjJ5fOHf954fBxiSK8NMN/iFmhFDWjV5RmMII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PulPLKerW6ZxrPWfk1PpjCJT/t94pauFN8oPqrggKog9Wb8TCD6VHWNVMb5jayzcA1VW/cYKr5HZ+gMj6+X1Rky8rqDElBRxmyIC+LvhNGiEdxW2jWikq+PUJzQN4eUllHGnbgFXLEAHMecWvkYxgUdqIM+gkjomMdsZmrwmMz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LkaCWuZB; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie/dEGvShq/bEqKIUpWc7913RtoS4uqVIQz57LjeyB7OVV5Rqfpgsh9hEUoG8/iwsRSX/PTkGqMPv5SNrrWnM9jvAWGQ4zlbPqpUSL75LNsYkjFwuIrVCp8bZaEp6yRCmYqxDCGJ4Ru8Mxc7nc9HPbDbfAkUjjUpFR6p6g0PTl1pttNtEGk6FNsNHjGvUC8yOU+h+J2OsDnYrWMBSQ3LNniY6ra2TYVAiG7sYyOPIPjlzx1bjlcjcekqXCaAwmFBJ/V+3LvSMACmAjGr6CxSLN7h4rTqqAm/Uv3GGLmEy4S+4CvXdZ4faygLjeSnpifFHMY7I5+VFQSvAWbkBkzbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHJY49zrPRm909rZzLMgVcIljaFiTqmzozXbJpA4zkE=;
 b=TO/FrIir+lFOEKwAkngiasVV8BcZg5+kVWLBm8bofHgWK9Xen3iIwX3nj/iOp+62LN9tlRrBaJfEbt0BXoLzqCYbVovUUyCxo/dn/bNMRzRi7ulIKMo2iNoKkY7RwdN6KlOd4ITDERMISpphI2bhMyJzmMVWCl3gAx+BnsK1HKfSdMA1b0wPVdJPywjsHdGlFuGGNyMHjVwOwuhF8wJ9RgURSkNTN8wp/drkYbiirTNeHq4EzjCVSI7002cHYEJwbtlDDNJk9K84iObWODFTqe0FBAGN1N8yFdpxPtD89znIDQOpPkqNewfOPWA6V7jaINEBJAD/33XBKJJHJFxchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHJY49zrPRm909rZzLMgVcIljaFiTqmzozXbJpA4zkE=;
 b=LkaCWuZBA+2ksek+hbIN4GeAZ8LwWKvbQbHAqeeXJbZ6udKX7JVGXHobv7QjlkW2sKjdlmOHyeYOnE6/Sq8hmlX7ySnplpmo3vz6x2v4EvklQGNKv4oGdxdMm/3pAVqZF1In4rbSmA/o86xpDNQSmS0HcODQG/UzaCfRjPS+qKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 03:09:23 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 03:09:23 +0000
Message-ID: <4ae5eda3-824a-4bb5-b763-19083c085575@amd.com>
Date: Wed, 5 Mar 2025 14:09:09 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
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
 <zhiw@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050> <20250226131202.GH5011@ziepe.ca>
 <433217be-55e3-477b-bc10-cf81f02ab21e@amd.com>
 <20250301003200.GQ5011@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250301003200.GQ5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME2PR01CA0100.ausprd01.prod.outlook.com
 (2603:10c6:201:2c::16) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb4c789-5bdb-4ce3-4216-08dd5b932118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0FVNzZaUWNwYmlRYUIxWEJYaVFwZThJUnFIKzB3YmpicXpIZ0NES2Rnbmk0?=
 =?utf-8?B?MUN0ZzNYWmVZTk1oMWNSQStIdjVmWUtOdFkvWmhIaVlERFJ0NUxCVEJKeHNU?=
 =?utf-8?B?cm1uQlpVdVZESUdJdHRveS9YLzE3cjJqcnZBTzh0aHVaR1RndmJVSjJBZG13?=
 =?utf-8?B?UEFKRTZMOXlHQVBtSGFlOVVHRS9jeGV5WmJVWWt2NGpuSWphSlFGNVlJbXQx?=
 =?utf-8?B?WjNXR0Y1MXdvQnFSRElrd3FYU1E2ZHIwdzFiZkJSVXk1VXNaVHJEb3pzSVRC?=
 =?utf-8?B?bXNGTy82WDJ2WEZzSmExUEZQWU9tcGkvK1VEV1JzbExVMmdwcTMrY0F6dDYv?=
 =?utf-8?B?dUliSXozb2Rxc1QvVzVJVzJBQlBVNUNvdEFuakkwVGI5K2VmSEt5b0JXOVVx?=
 =?utf-8?B?M1FNRHlORENmR0ZOeDE4ckducmNnR1l1NmNEMjVPeGRXbTd4MmJHTTUwNnRu?=
 =?utf-8?B?Ymh6bENpRUlYS0Vaa21GcVRSb1NBS0dZdlF2S01KaVBLNGhOOGw4U0dnaVl5?=
 =?utf-8?B?dTRjdzQ2cVJFbWZhd2krMHRvYStoV2ZnNzZIYkZPVlZzVnRNR3F6VDZidUho?=
 =?utf-8?B?ZTVoQ1oyaWhaVTBNcmJVVUZkZlBpejJXZy8zZHUzei9kN1U3U0VoRC9xeFF5?=
 =?utf-8?B?cHFMK3RWQmNBRHZ2anBoNjltcHBrVk15WmxYdU9FT3V4T2F4OVY5dmpZaGNI?=
 =?utf-8?B?TnVkUjhidXN1NUQ2OHhWM1k2Z3FxUlprWXI5bnNHRXV3MDJUNk1VaGlvcVc5?=
 =?utf-8?B?UTg4bTdkZzlGRTFmSmh3MFkwMkZMRDJSb3FUMllOZ0dLZVM0RWRvMm1sM1BC?=
 =?utf-8?B?cTVyZjhHUEp3YUtDR3BISk9yU3B2U2xkcFJFMnFPODI1eFVWckV5RWxnSXhn?=
 =?utf-8?B?RllRSlZFSTJnOHUvVGpJclY2U3dzb2RjaXRsS2UrZXhaV1Z0MnZycmlObEl4?=
 =?utf-8?B?a2E1VkFBN216UGxDbUQ1cHhBK3Y4MDZpZTMySXpSY3NBaFpMUEMvK0VHWWxo?=
 =?utf-8?B?MU5ZQUdOcm8yOVF0MXhjQy9KaW5iV3B6TXArMzdnNlRGWTVuK3RsZzV6ZTln?=
 =?utf-8?B?bmtpT01DK0NLV0tmaEJWTlJFYVpJd2x1RXlJSVh3RDZCV0lRcVlSa3R6NjJX?=
 =?utf-8?B?aFhpaGNwaTNqTDZGQ2tJa1BERDJVVXpsN3Y4bng1cE55S0VTVURiU2tXZStv?=
 =?utf-8?B?K3pRWW52Qi95Y0VRRHJMU2p2U0I2c0xXZ0RZbzZjaHcrWE1jNVVxQ1BEMnJE?=
 =?utf-8?B?Q3pMS3dRNlpwNUhjR0JYRFV1Zms0eWNiR245UHVQMFNRUFp6eEYwZUdraUxw?=
 =?utf-8?B?N25ZTVZzWWMrKzVjNDBhd3YvcThiSFlYK1FMZzhSSTN3MXFHYnA5bW5XNnF3?=
 =?utf-8?B?V1lTRHdTbjRlU0ZiTEluRU41VU53Q0YxV1pNUE0vRGFCK2VwVGVIRXVKSEho?=
 =?utf-8?B?bEtBYnhGU3lOSzVWei9FZWF5V2VOYzZjczV6bUxLQTZ1VlhwdXR5eEV0anRx?=
 =?utf-8?B?ZG5RZGgxNmxLNzQ5Rnd6VVZhZU1FWS8wWUNKZjJOSEdhRitTU0dXNHp0dks0?=
 =?utf-8?B?djJPcEtPdFNlOEsrWmdVdFBGUGVnUnhOdGkyTzRIMHhZNERza1Izemx2OTgr?=
 =?utf-8?B?MVRSaEoyK1RVd251bzdZaTVsV2dXMGtVNEdjVTNYbjdialZBVWhUaU4zelBD?=
 =?utf-8?B?RXZ1R2VMdmFyYWpjckRIT1Y3Vjc0K3RXYlY3WWFHZ0FGQmJXWjBYWG1FWVMv?=
 =?utf-8?B?ckozdXU5VFZNOGZ2WVhMZ3V5Vk8reEEvaVJDaW1pZHlnSjFTQ2lveEdxQnBn?=
 =?utf-8?B?OSt1bmZwaHdER0xXSmpxMUM0NHduQkxod1FJUFFWc2tyNFJqSTdRVk4vZGxD?=
 =?utf-8?Q?y1K481HOkeMWG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJrd1VVTmtpTGFpcVBNcnNjeGRQbGRvaVpxM1FpNjFtRWhzcUNFb0lSYUlh?=
 =?utf-8?B?R2p3UTUwd3ZDanhpTVhkc3dxcXBobklRcWxuR3NFYWNMbHcvTmg1dlFCWVRV?=
 =?utf-8?B?RU1hRW51VDM4N3lKYXlHTCt1ajNuVnhWbEdoR29sTjZjcmZCclFVbkhQcEc0?=
 =?utf-8?B?eElRZVgramc4bllXVHBDWFd3czhYMnBPZW5mbHY3eXhmN1FTTDdTZzRZaUFt?=
 =?utf-8?B?VENyZ1VRdFg2Y2lLQ2RJR1M0b05sVFhNTXZnTHUwVjN5ZWNMeXFISHpQMXpQ?=
 =?utf-8?B?cmVvZVpET0V4UDhjVzBBSG04ZThwZjBsOEpEUFhFTTBHRkZOSms1ZUo5M0hh?=
 =?utf-8?B?My9RYVRBMHNuOUtsOHNFMTB0SEVaRmVaZWEzeUhNVXR4VWtMalcvZEtibHQv?=
 =?utf-8?B?enJDSyt5b0E0MTlQQVNVdE5zaGhMMkpsNkhUM0x2UE9VclBJbFBNNDB5bEw3?=
 =?utf-8?B?S0lOSGVvNWtOWGJwMExycVdJNTljVUtSR3BpSVlPL1A5RHRtWE1mb2dRcEhS?=
 =?utf-8?B?eUphMDNuZzNwckVOdTlzRnpHSjBnZlU1Z2dMNmNoMXczeldxbDlYQ09KKzJt?=
 =?utf-8?B?aWVTQnI2cmE2OHlERzZ2LzJ0cjUrOXlzWjBZUjR6cGd6cmZXQWRXc1lRVjdr?=
 =?utf-8?B?MzlhN1F6anJQWGV1TVFqUXZHTEZGMG8yMFRJd1hjaFNjUEVJYXMzV3M1dHd1?=
 =?utf-8?B?MjMvNVcvTTl3dW52MHdHQ3VPRisvUDBRdDBJNFJITnpWckJUczE3RFhLS0Zn?=
 =?utf-8?B?MmNSbDN6WWgyaU5UUjhJM1ZENE4rc2RqZGhqWmo2c1YrbUIyc2YraUpHUzJV?=
 =?utf-8?B?eHYyY0Y3WlEyYlpqWmVPUmVwWVNpOHpiaVFpQy85dnZLeGY5NWJjTTBhZnY0?=
 =?utf-8?B?bFlBcGFtZ293WEIwOUp5bE9vTjhteEhDaWh1YnNLZWtSUFkxd1BJSi9rN0t0?=
 =?utf-8?B?NVoyUjQrU3E0ZW9uZW4xTTNBNlFkQVJUb0E0dVhvUk8yYU5ZZEFETWdKVzZI?=
 =?utf-8?B?dktjZXh1SG5uMzcwUW15dy9pNVRMeTh2cm1OdDc2TFQ4b04rcHpTQ1NoaW02?=
 =?utf-8?B?T0xxRHRsVzdBUDMyeFFTMEtLZTk2OVRzS2VJNDVQbGgzMGRPQ2pGeVZNSCs1?=
 =?utf-8?B?bkwzVlVzZVhCd0UrNjRYakRnTzdrODFmQWVkWTUrQURtNjNHYk5yNkJJVGF6?=
 =?utf-8?B?UUZDSmV0TnloZVd5ZHYzU2o1UVNieFNMVWl1SUx2TEhHOGpnWGtYSUpwcEUy?=
 =?utf-8?B?TTZ5VkVvNnlKKzVpWDlmS3hIVWFYZGxYYWlySHRQRGttYWlmM2RoUGlwOGEy?=
 =?utf-8?B?bklZN2sxSTZvVDdQb3Z5U0tKVVhwQ2wxbzkrajlaVCtoSTkyWkN6aGRMOS9Y?=
 =?utf-8?B?N3QvSG5NT0ZZQURyMXIwbWNoUFdFWFliNDBYSS9XWHk5SE1KYWFhSEhabXpD?=
 =?utf-8?B?djVlZHFHdnRURUhYdThsOUUwVjVjQzdqbjNsZ24rWFFuM2RlQWg4dEZEdjlY?=
 =?utf-8?B?ZmhYV2d2QWhsQ3pld1ZCMTU4ODBuK2ZYbWRoN243MnU1dXM2RWIxK1M3Lzdz?=
 =?utf-8?B?R0YySUJPUVNYQ1ErWWNaVjNZSHBJNDJHcEhuaHNidUxNUTdFNWpLNGZqdVh1?=
 =?utf-8?B?NlZJOUZHQkFTQ3Urb05Pc21reVFaSWlGVjZCaEY4YVhPSzFKQWlYZ2Yya1Nl?=
 =?utf-8?B?dTR3a1J4NFVxS1kva3o4RWRrTVZNWmluSFlmTHVOUFA1TmV2UHRWTTJyUURE?=
 =?utf-8?B?VGJMYmlpSGcwR1h4a2dNTU9Na3VaZkw4M2xuTXdFZnUvYUZnR0ZFbGtZRUJ3?=
 =?utf-8?B?N1Q5cFZRYUhVR3lGUDlQWDNyTThZMlFBbTlIYVFKY09jZk44VUgyTVRMYnk5?=
 =?utf-8?B?MVlxR2RVRVhKVVlMSlBwQnRqUnAzV0ZncWJLOTlBUFE3Z0taWVJ6VlBvRU9M?=
 =?utf-8?B?WjlxRktUa2RpQmRMVDhkZWRtN25LNFAvK3VRYTkvZCtydWJFeitmQ0V1eXN1?=
 =?utf-8?B?T0t2RWs3RDVxTldtUThvZWpSRG5hSUVlNTRLSzRrRmpLWnI0c1ZHdm9mdFdj?=
 =?utf-8?B?Z3lyQkppV1VQWUpUT1JxeEFzTVRkbUQ5L2xRZEFUUEVqNXJIUlljK0lMelQw?=
 =?utf-8?Q?W4npUBtRleDXjkgX+aN+Vgf70?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb4c789-5bdb-4ce3-4216-08dd5b932118
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:09:23.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWIaE4L8TsxuLiFSGuxju17KAX7KIh/xk8xu9qufpz60YXwXx+nyS8BXTuSQ4DBPhYQS/mhwOoOShqXWmH1CpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165



On 1/3/25 11:32, Jason Gunthorpe wrote:
> On Thu, Feb 27, 2025 at 11:33:31AM +1100, Alexey Kardashevskiy wrote:
>>
>>
>> On 27/2/25 00:12, Jason Gunthorpe wrote:
>>> On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:
>>>
>>>> E.g. I don't think VFIO driver would expect its MMIO access suddenly
>>>> failed without knowing what happened.
>>>
>>> What do people expect to happen here anyhow? Do you still intend to
>>> mmap any of the MMIO into the hypervisor? No, right? It is all locked
>>> down?
>>
>> This patchset expects it to be mmap'able as this is how MMIO gets mapped in
>> the NPT and SEV-SNP still works with that (and updates the RMPs on top), the
>> host os is not expected to access these though. TDX will handle this somehow
>> different. Thanks,
> 
> I'm expecting you'll wrap that in a FD,

A KVM memslot from VFIO's fd similar to gmemfd's fd, and skip VMA? 
Doable but 1) creates a KVM->VFIO dependency to do gpa->hpa translation 
2) is not necessary in the AMD case (although host-mmap of 
guest-assigned private BAR is way too easy way of shooting yourself in 
the foot).

 > since iommufd will not be accessing MMIO through mmaps.

here I do not follow, why would iommufd care about MMIO? or it is about 
p2p DMA? Thanks,

> 
> Jason

-- 
Alexey


