Return-Path: <linux-arch+bounces-13068-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA131B1B60E
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 16:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F6D1886FD3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD271C4A2D;
	Tue,  5 Aug 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bNMs2vsF"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0D208AD;
	Tue,  5 Aug 2025 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402947; cv=fail; b=LABEcyDGXrMsVQI5vCxLtM5BjIg6r9qvdUXurVyf7PDAnUkVgkkzHSbW0bi6/fPHCjWnOjvjTAXtTdiwClWUuZzrU/TilhEy0ZGFcjmUXpHAb+gjbrwrD9e3vDBe4bNuvvUZxInG3/rjnV18nGWTCI/u6VnXUN4GXB80zp+1Z/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402947; c=relaxed/simple;
	bh=bvz2CHFR42FfNyRinTLR40oyBYmNWptY+Hfs5mj+8SQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hYBD87rTDIuwxjQTdrfVXhKr2NNEqtlLAj0lOUMUfPuVeFudiV4otL1iuKcB6dAS96V1B+wHoDIWti+NmcfI6A5kDsZlDVt+Iu/glYssU1pYhMmiVPSSSWkxz7xh9fpDvVWnWp8PC5NbVHe8zi4/U+eCRwFd1JmeW1/cSoHi1qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bNMs2vsF; arc=fail smtp.client-ip=40.107.92.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdNmJIHzzTZrZjNpsW5uEtYxvdRL02VOyz1TwhGZ7+urJfuFkZBrrVfVeJ5nBlfiY18L8dvxgAgBgi9Vlb+jem0PZsG4DMhQs/zgtj5H72TeZt+UhHfBSYJMZl0Zog7gmvgC2o9Ml8zCqs3LaZRoNWkSq4I2NBCUjEBvDCCIx36qmW+DGaqysTjRtoHnKRfoji29XeesCe7PM3b+Tgi1OZCB8bJ1a3Ja8ca0rqu9L7fm0Sl7vRKmuMemMdyF7QuZXQ2PIqnf8rAtxVGrUTUdhEoThWpGFtQRoiraxnL1+q1Wqm15H6Fw5fDY6Ep3B5xn298ptczyqQcuf+0cxbciAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOqThIYNM8mfWBgny3lm7ucr5mDXVeLtJ/WFDkVS0r4=;
 b=qWAaJLoJZSGGOBa6DVowXye3yhj2QHjxxfDygTgxpMDJfY0WOFDMIogavVfM7hMJhh5RQ2c/BmP5t5Zr71RZzpPhCuCVPmTIvrJVVHq2nChr9T2nw5ygpSRaRFP+tG6E9I44/7YiRMcsfrybESgwE4eVTzzFYOnOrygHLasNcrq2RO0dINEeCRHCvOCoVciMiBxu0BR3OWgypzJ1q+LbRCSfJjrp3/2WyPUP+97bG312YtUVBNDr+WtAdlfhAic7QNiQDJwZP2da5BhbRbz0xFFv3uE+hYCm5VMBc0al7rwMPV6bckEgkUw/VdG4iOghr+ExH84g0inW3ZlVYN5yhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOqThIYNM8mfWBgny3lm7ucr5mDXVeLtJ/WFDkVS0r4=;
 b=bNMs2vsFDnEvZWsS1Du6xaWv25X++3XP8Ugm8xKubvsbWFDZD9tqdbpnnDXfm4rauRF1Sqco0Di9U3KxPZ7TXLcOR1nUUP9psWB4uaBkCvfRcChPnK0xMzfr6bvmUJCUeUlCVuE+25xZ+uhJHvpt9FA7U1N5sgfuukjrUbDftME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 14:09:03 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%5]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 14:09:03 +0000
Message-ID: <4f3018d8-debb-4f54-8ad6-23a9027ce2d3@amd.com>
Date: Tue, 5 Aug 2025 19:38:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V5 4/4] x86/hyperv: Allow Hyper-V to inject STIMER0
 interrupts
To: Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 kvijayab@amd.com
Cc: Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <20250804180525.32658-1-ltykernel@gmail.com>
 <20250804180525.32658-5-ltykernel@gmail.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250804180525.32658-5-ltykernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2ac9e7-a956-41e9-920f-08ddd429a1c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDFMY09ZQkpxWFJ3a1kwQXRVZEgwNm1QNDRlZ09Ibks5SFByWVcwSVd3OG9s?=
 =?utf-8?B?cHdlMko3eFkvQWFlZTdNeHFhNXduaXM4OFJuY3BWZHgyTUFsR3ZJcEJyekJ4?=
 =?utf-8?B?Y2lFYlY2M1U5TW1mRGw0OFJjbzBlaWpVT2dJSWpOODJwWittYkNjWTVGbXYw?=
 =?utf-8?B?UmQ2bjFCNHFaeDBPTmxCanMxSm92QUwxd1k5Z2g2SlN2eE9rWHpxOXRjSXo0?=
 =?utf-8?B?VFl6eE1VWG5iZm95aTQrWnNiNjFrVjBmZHQ3TURHR2NEVDhJUDQ2TGlxaHly?=
 =?utf-8?B?NjdBb3NySmpJODBhSkhUYlNxYjV6bElPNHIzWVlyT0cyanVHOWd2R2Nqakk1?=
 =?utf-8?B?bHQ3VUx0RnpZOURtRjhHb2hQWXErUkcyTzBYdUR0OUUrRms5OS9TWi84WHJS?=
 =?utf-8?B?VVNRcUxUT00rZXVvay83SnpIeDVHa1pPby96Rkcvam1UdTVOVzk0WS9DaXl3?=
 =?utf-8?B?MWcrSkFJc2dUNTdtWW5TVkl4dGtmVlBTWm81cUZOdE5OeWFEb0VrSkE2ZExJ?=
 =?utf-8?B?bnJJNzlpQUNlMWlselNCOVVQS2VDQzFDRkxyOUdwRzg2MlBqZFo2c09oQmow?=
 =?utf-8?B?dloyaU55ZUhCb1ZXRUdtU3FMWmp3QlRmb1ljR1Mrd2NneWM4UXExRnVXY0FQ?=
 =?utf-8?B?YmcyTzc2UmNhVklRaUNTMEpoZjgvSnFFM2E3aVZYbWgrRkh6MzhSbURwWXh2?=
 =?utf-8?B?QjZlMmxUNmhZQWprSFRhbmIyUHZtV1Y0bGk5bFlNVzMrb1dUTjF1djQ2N096?=
 =?utf-8?B?d2JnVEtkQm1pTkFwMUFBK204ak9aVHkyanliOHVnZWdKZjBRRnR3RGJEQ3Mr?=
 =?utf-8?B?N2k4US82SG5yeVhobTBlTVVNSXNiZUtJNGFRV0M2UkgzNmNNUGtveGpnN041?=
 =?utf-8?B?bG5jeEl0Mjd3QVpMR2haNTFFOGxMSkM0VFVjWjZVMEpYTjhGWGtiZVkzOU05?=
 =?utf-8?B?NmpaaHl6R0NXOEhXTFdHZjdKbTVJcGhJVFlSbEtMZ1RHOUdLaEY0RThDNjVt?=
 =?utf-8?B?SFNXYTdNTWdCcEhBTUw3cFZvaThCWDFnWGNrb1ZJQlhIVTVPS0pUdERhZzZK?=
 =?utf-8?B?cCtXVVhxeEhxVFVGdllzYXFTMExYa1hpd2ljTVBSWVh6a0Q2YzZ2RnpIK21r?=
 =?utf-8?B?WDRjQkZuK0RQZVc3cGd3aGczRzBQaHhRSHNIYlFHQkxlNEhnQnZqWi9pSDdE?=
 =?utf-8?B?K0hGcFhORlp3M3RLbTFWbjZqcTFaWHV0NlF4RnlyTFBxUFk2WExlZzFLS2Fr?=
 =?utf-8?B?d3QrcEFuOTNIbDlHaUwyVGpBQTRSYzJWS0laNjkvRnlZeHp6cGVLMm9NVFJE?=
 =?utf-8?B?MkxPTGp2VUMxcGZ5WnVFWmVwOVROaWxNMUNLNE5xTmhQQ3NLY1ArelMyZTBn?=
 =?utf-8?B?bGhNZlk0L3lzc2p0RkVSZUVMck9xdUpYZE14Mzc1ZkNGa3ZXNWhhMVo1ZmFG?=
 =?utf-8?B?MmI3eVByN3ZORE9GaFdPZVppYzRycFZJcWQ1ais2YUlZaFJYR3dnM0JCcTBV?=
 =?utf-8?B?S1AweVhaOHMreGp4ZEhyY0hvTXlka0h0VXB5ckxVZDQxNFlOY0N6UzFxaWl3?=
 =?utf-8?B?NmxsMTQweEtDVHhZbDUvc0EvT29GelNRTnc0ZU9FSWNlaVFzRFZVcWhOZ243?=
 =?utf-8?B?T1hvOVVaYmVla204T0NMYTlHaTN1QzFyQk5FQ0RxOXJmTnhqdnRpdWhZYmNB?=
 =?utf-8?B?TTM5cCtmQXhnbGx5NGlacHQwQ3A0TkRlaklIU2NrbU1maVVGTXdwYjhLaGE5?=
 =?utf-8?B?T3Y2RFFIK05Wc0d6NkNkb2I1MWxzc292L1NWQkNOQjVLMkRyaGxsWlNDSDNu?=
 =?utf-8?B?SzZ5TWtBa3pFc3dOdFRIaFZXdXFhTWEzSnlxY0JzREpNaFBnREJMRDV2VHZF?=
 =?utf-8?B?bldFcG43MVQ5Mk5iamIxNXdEZ1BDQjAzRVNvVGg4R1dpSUpzSTdYdHlGaXRI?=
 =?utf-8?B?OEdtMDdZdlovVnFQdXlnaTdET2xZQTBnNjF6Z1RoNFZXUHRBUmc5czNsZ2R1?=
 =?utf-8?B?UjlTVjlBR3B3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVNXVXlpNFQ5V1Y1V1pVdElHcWFmcktaYVpoOHhUZjJib0hjMkhTRHlGczI2?=
 =?utf-8?B?THJESFNnSGhpS01XbEkrQ3JRYmorelFCZXlCS3kyZWhFdWR6QlNUbFZxMlpK?=
 =?utf-8?B?bWhuK0xGOWQ0Wkh1c0kybjI3Nzg3Z1Z0VDJYN3JOcTArZks1RFcwT0lQMzZt?=
 =?utf-8?B?S1FRczNhRGZBQXNqSnZFNUptRXNGSE1ONHFjU1VzSlFCUXJaMHJ0THEyajVO?=
 =?utf-8?B?RGF1bnhQSXpFbllpaG1kUloyamVsWHJ1dlZld2J4QW83a3J0OXl2TUlmU3lO?=
 =?utf-8?B?ZTk2VWE1OFo0RHRseWdvQWV4MGNxVEZ6OVQ3cVZMWU9PaTQxOEl6NDIza1pM?=
 =?utf-8?B?d1NXNVh1dkhPN3h0d3JPdTJFRHRrNTB6WTliL0VjNzVPaXRkUm4wWkl3TjQ2?=
 =?utf-8?B?T2lqYXJwYnhBWmRxSVNhaENmQkRtb2tzU2tXcUlScTRSMGF4Z1dFL1NZKytL?=
 =?utf-8?B?VytOSGdieEJueFhWenFUSnBmbFFSaUwxRVFtTUxGRHNEeXpDeU9BRnFUOG5R?=
 =?utf-8?B?bW5HQTNhMWFyNk9XeTRGVDJFWVFLZHozWFFjVSt0V2VTVmhDeWQzanZ6UTl5?=
 =?utf-8?B?VVc1b0FCYjBHZ1BKSE5IT3dsRGk5OCtmREx1Q2NRT3hXVzZReHdYME5BSlYx?=
 =?utf-8?B?bHJjQnF6QmFzVTVhb0hwQjdCc0ZoK1EydERsbExOa0N4SlpPcXpmaWpUTFJs?=
 =?utf-8?B?ZE95VzhmQUo1TldqckZCSjhtbVFSaW1nL2VtSnVHVGU3RzBFSWp4QVRGS0gy?=
 =?utf-8?B?Nm5qV1JRUGFlTnd0azdCM0xOVisxMFplR21Oc01JU2FlYnlNNFB2OEFJQTlQ?=
 =?utf-8?B?QWgxaFNQTkJLY0lNY2dMN05RSzdEbDgyc0VVOVd5N1hETEVIZWlzUllTSmtK?=
 =?utf-8?B?Y0tKTDJ4S3V1MkMxOWs0MjVnejZOYUs3YWNmTEtJWlZoMWNhQXpsa3lBU3Jt?=
 =?utf-8?B?VVc2dGMvZ01Ic2MzcUFzRGhBc0V1VkFZTVYreGxUdVhlUXp0bEpGUGRNMXJQ?=
 =?utf-8?B?bzM0L1gyblhMdWtPeDI2UzN5MzZTMlE1azJ1WEs5UDhFanJ3UCtNdTI1c2h4?=
 =?utf-8?B?ZVg2T2xGRzA1WER4dm4yQjNZbk1oQ29qcDJTenZtYU9BSE1ISmFXcXFodlo2?=
 =?utf-8?B?RTRVR1lZVGU0a1k4MnNsR1o5MEdnR3Iyc3liNm9xeWRqWGxkYVh1TGR5VnR0?=
 =?utf-8?B?OHlCbGhPMndyYmVxZmdNWi90ODBWdmwybjJvZDRzOE5YVm50OFd6VVN5MUhW?=
 =?utf-8?B?eWdUS0QyWGpLOXY2RFVmOTZ2YnBwSlR0b3JseldCZlVCekg0K0tCZklZeGRQ?=
 =?utf-8?B?TDVCRmdYbXh6cUF2eVdZdjY1b3EyY2dSZ1lDY1FsZXJVL0lrUm5vb043anFq?=
 =?utf-8?B?eVlya1BPbFdrZkUzeFR1Qms3YVBhTG0yenlVL1FLY1dsOHA5VnlMUU1CMnY4?=
 =?utf-8?B?ejR2Z2xCbnpaQ2hic0ZNNVJhRVdRTjBETFM3U0tGQlZqMmxRT1dTS3E1MUVH?=
 =?utf-8?B?WFh5M3RXTU9WVUxsVnhVQUhYcGJobjRid25idW9NeXBrNUNObVhxalhHOTFq?=
 =?utf-8?B?VlJEQ1hjbndNSlBoUXBTRnlhc3FtOFAxVWt1a3U5Wm1waVhDRkhwSW5nQ3BX?=
 =?utf-8?B?cEZxUkd4MksxWEc3VzhnMUVSMUw1RzZBN1FjaFJ6aWZPRTNscVQ1aUxnRTBB?=
 =?utf-8?B?YVJxS3pYSzhTZUorMDA4TmdRUVg1V1JoWTlqb2dvbTByRHJWY0RtT3RWamlh?=
 =?utf-8?B?dDQ2djZLRUtMK1lCVTRVNW16ci9pek5adXhobnZGeTZLVnp4K3BLWUJOcEw5?=
 =?utf-8?B?cUZsemlUYXQzSERGQWVJU3ZHWFN2c1dtRWNMaitVL2lWbzdldUhyazk4dGpF?=
 =?utf-8?B?Q0NFc2N1TWs4NnVNUTlIcnNrdkIvTWVNazV1QlROUktibVRoVk9IbUZoRTRF?=
 =?utf-8?B?N2VyRE1mVUtVbmVQSTM2ZkhLMitFRTFoYTRDSkdveHEvNGxjZzBEditlK0o4?=
 =?utf-8?B?TmE2NkdSNnRFRzI3eVJBSXF4WkRXRlY0TTNtdThqKzlKaE1nK1FRWTNvMjNZ?=
 =?utf-8?B?eUU5Q3dBL3RrQ00zMzhoSHpsd212N0JLV1BiMEFHQzRyemx5SE0zcFlQcWIw?=
 =?utf-8?Q?+0UkMvJ2rd/HeQPw07E4yLHas?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2ac9e7-a956-41e9-920f-08ddd429a1c8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 14:09:03.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i4WB8BIk+WFHlTS+0c1A4D4tV6zTk8OzRqP1Hwrh7hYT8fTviL9lhgecz/bW/VG5Eq6FSj6MzDGmQsnJM/i9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720



On 8/4/2025 11:35 PM, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> When Secure AVIC is enabled, call Secure AVIC
> function to allow Hyper-V to inject STIMER0 interrupt.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

