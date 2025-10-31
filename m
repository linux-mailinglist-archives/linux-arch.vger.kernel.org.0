Return-Path: <linux-arch+bounces-14449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C58C26DB3
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 21:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53EF64F221F
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB3280A3B;
	Fri, 31 Oct 2025 20:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NkuuJL+k"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021113.outbound.protection.outlook.com [40.107.192.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA6323401;
	Fri, 31 Oct 2025 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941012; cv=fail; b=O6H/welXn17uJMwSwRbQKs9QiBMaU7e7xb7u6N9TgMGNS7SS2JLwOj0YXtlP8vOH2Vae7+pyNt7GZ6SaItf/giEjdvXfDfnsCOREbyijEjzxbv2ppZqUVL4xiJL/495GkX1gvr2SUYVGMhIR9MMajbEgjOT7gwyIeX+av/+qZEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941012; c=relaxed/simple;
	bh=Uom2gEFXD68t/6majaWMLmJvq/ykordIL62Ir6NxL7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YkSt48YgCx1vLnIHazs5YMF/PKENoI/qNPydNHUwSTLpRFlBMgg6LsEgoAbYZK1UucXZjsZ1s91o0khB/LuAT4jqm09yyzl3Hq4jEPcB4JusKZ1IVd/RZ4RVWpjs6Q7ryj7YMWkriH9vCfJ2urdaPRKOtzomXMJMQN9Muv0gezg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NkuuJL+k; arc=fail smtp.client-ip=40.107.192.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrTMBMkCu8U+cu0/p89+qiaXo3kI9FXpLEgLJKW7nO3ujk0P3rwZLJQ6XZRt8vRFkeMtyGmXCxn/8ssu8WaYGHoFBYbZl3LkWR7cG08/KSZPLzW7pXkVCh5Aje/qkLU/2OB7W2fd5HRrRuv0YoBeZa5qHCGccGEY/9I2ocPd9a1i6uqnFvbl7Uym6GLrclwSknWEnG8E40L2MJ0Pj+XuOOVccyfIYo3lfs2ZYSzp1y5c7DWSusm4KIGNLqCgFnNFgdHUerHUQRWCwKn8fA3cX6EapOuR44u9tHufyURMTjuldHp3fMC3xGab20gSr3fi6+w2eqGw7a2VFezxPVW+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uu2TNxtZ91VZqkzPVBYfqsuzYYdo1mvYv8obKGvvF4g=;
 b=cRwJiW7mU5JHOZZ3ujot14OzPMERvXk5IezKUPukt1AJ7EAAa9kcOODVcHoYlS9Nn4pd/ro4sENEgLCaFKLUdCKWWJtPmx87Ky6ZLFMu9X6aGUlMr+OUwq4MLJBLelcT/vRiFDuLVql8wEi2n502/qBdWSzL5hfs+47j0GEX71S5I8QXV0mDC6ZmimEqBk2qVP558CKkmOyAahTu6GpLCaQQRJ4q1Cm/66Fshg/YpmDL9R0Fif3XvzA+fHxyVppmGqVhnvFNELHNaagzIF1J3ym/5c505VnIFP73FiwOEWsiO9MMs4Fhq12K8lMeSJoZY6IA7QReT7JiofgEBtEO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uu2TNxtZ91VZqkzPVBYfqsuzYYdo1mvYv8obKGvvF4g=;
 b=NkuuJL+k1iRmNYk92YI/Gn8MiuL24a4CxeX6yqq12fEtQs/PSwATijZDT4mvBGYUFxtYNFyi0l8lOjpi02p6gOZB/QPthVfjLM9q+DxEDyKrogIX0vlNnUiTt+ml+3hGdQLP5IJsKDGnfkyEIwpdCppHfMlYWusARVlhniC+W6zpWa/nwG/4e2eQrj5qZCBcMiFYqSL8PKXQBAb1tfLHIzEBaecuJwVEs0+Zbaxl3xNEcoB7oR0CTwoJHY4HwQPiV4vovmltyVL4SukULVGEnlzBDyr27VLqV9ai6YhzozMTZ7/5CK+Sof76BkxpJF43lPDfkYl9wZ9EDiDKAsmWpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11589.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:155::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 20:03:28 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 20:03:28 +0000
Message-ID: <18282cb6-f343-4703-a022-dc40edd1c6f6@efficios.com>
Date: Fri, 31 Oct 2025 16:03:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 09/12] rseq: Reset slice extension when scheduled
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.988550967@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029130403.988550967@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11589:EE_
X-MS-Office365-Filtering-Correlation-Id: 0299e2be-4125-4f60-e54c-08de18b88e9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clF6V0ZTWUVDdCtjZU5ZZnozNUdKOFZwTTV1WDlOeTd3aXVlSXZaU2NHcmRn?=
 =?utf-8?B?ZUxoaWxlSmozU08vRFdVTWdZUWFRVlp3Nlp1Zi93Ukk2RWRpaUovbUJKbmdW?=
 =?utf-8?B?UXlRck1DSE04ZXgyejcxZ1YrRExtNXdod0o1enVNVTdaMS9MaFJKWUJ2VlZh?=
 =?utf-8?B?U2EybkQ3MHhybG9GellOTWtRcWxyUlpZTjJOanBSTVJZbk5OcTlSQ1pQT2tG?=
 =?utf-8?B?ZmNTSmJCNkNnMEtoL0lFL3NBaFRvd3g3dkpuYTZUV1ZIWUd1Y0c3ZEZKY1Nm?=
 =?utf-8?B?dVZLWlphY3J5UVd4VFVweXJPaW8wMWdHTmRoU3d2WmpKaHdnUUJGcUVZYWFC?=
 =?utf-8?B?blQxSFEzSTNvZlA3K2V2NTY3UWRrb3hVWk9KSFBENmNVNThNeVltNC84b29U?=
 =?utf-8?B?eXRTanNnbmZTUWVIaGRGZlZRYWhIckZwWTVibHkyVG1ab3RBTEpId0RiWmMx?=
 =?utf-8?B?UUZtZE5PMEZkVUNuVENBUnJSTTl0bmdFdEFoeWp0S25rOG5meEdZWTVTVFF0?=
 =?utf-8?B?Z2Jib2xyZVVOUjdNcGF4RHdYRlZwbXVlSmYxT2hYaXMwS3JrTGNmTXhHWVAr?=
 =?utf-8?B?cW0rTC81Smx3dzdsMHFzYkpobzRNNmNBSjcxMFJvQ2w0a1RzeUl2c29SazJK?=
 =?utf-8?B?SUNnYkh4Q2lXeko2dzg4SU8wWGFFYnFVNWYwZXBNcVNlQTJaZ3JCakRUTVU1?=
 =?utf-8?B?anIydGQwVlczRFBUanZNT2pwUEZicHdCbW5oMUtRcGY1TW1WYkFqOCtLdk5I?=
 =?utf-8?B?RUVxemFJTVB6NC8wNUZPT1YxNlVMclBqTVRYVm1GOWJQUXJMRDdjQ0w3dHVy?=
 =?utf-8?B?akFMS1FIaHFhblpRNWVrRHMzdHBXb3krMm5zS2dYOUtxNk40T0NXL2NEWDBJ?=
 =?utf-8?B?M29sN3pEZFFiNGNITWJvV2hjcjdGS0tlWlppaktEeEdiTmlzSGMyUXliMERq?=
 =?utf-8?B?V1VyeUxsYk9YNE1jdWluRWEyNUhjeVRMdE5ONjVYMVlaaUhIaTIzMU80elVr?=
 =?utf-8?B?WHpCRkY0L2REODVOUXlyMllrcllXbHoyam9TUnRubjBSbG1HUWdrdFZyVGM3?=
 =?utf-8?B?TWpWaGgrUnNhZ1RrMGxWOEpFYm9pU0h0ZDNycUFqWjBwTlNGUnJKVExYZ2hH?=
 =?utf-8?B?UkczRXMxMnJod3lJcG5uNFdPMzZZa0ZwTXQ4TEpjdVRvWEIvSDdnYzhRN2RY?=
 =?utf-8?B?dWJWbEZYb1FkZytyeHI4MUc3MElwK2JZU3FQYjAybVY4eUZXOVBsZTVBMTJJ?=
 =?utf-8?B?ZGJzQ0VLS3NYQnRVMDRJRjhUaTM5blEvR3J0bFZQb0hwbG5RRTU2L244QW1E?=
 =?utf-8?B?cXhwcXdhYjFFYnRneWVJTTlraVpNNk41bFp1enZXWFZPRzV1aENNYkozSDMr?=
 =?utf-8?B?bVR3WlJ4VWZ2TzllMTR3OER4R3IwTnNLYVRGQmdXS3dENkZtN004ZmRXbEZB?=
 =?utf-8?B?TzY3cFhqSmVGdDVRd1pOSTRaWHR5MEkrR0dYR2d6bmFDTjVjM0ZhSkFNdjVB?=
 =?utf-8?B?RkdaMyt2aFZndzlXM0haVWd0YkwvZEthbHBlYjVvMkdVYjBCYmtWdDNxaUxu?=
 =?utf-8?B?aDNNTWdyQTNTd0ZpNEkyV2tyc0pEbUZkOWxYWmFGL2dmYU1IM3ZKSHNYTmlW?=
 =?utf-8?B?b2Npa1lMQVB4NlJoUFFWRGoyMXczRTd0ekk3REthN2ZzUkhSTXE0STA0dXJU?=
 =?utf-8?B?K1JqY0NQbVJKYlNWSFFDRlB5dkxXeFgrem5OdHdLWG02L2RUNTRtVWdQT3Zv?=
 =?utf-8?B?alhLY3ViUncwKzdrdjYydzU2bXNBUlpXTy9OaVdGZzV5Y0dqbkU3MVNqcVZr?=
 =?utf-8?B?L1FmNnZsRTNtOHFMVTJ4WVFubm10ckF0TVNVTFFJSXo5VTNZeFlJazdTMkQx?=
 =?utf-8?B?cGJGdVhKUy9QUjRiK0wzdmxROG1HdllpSUFYZzVyT2J0MGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzRQemZsQjYxK2RMWEZzcVY5V1V3b0hDWncveHVJWkJnRVNrTzExdXk4ZWh6?=
 =?utf-8?B?dXpkUG84NGsxZ0ZxeXNYQXpLRHNPZDZIRyt0b3hNZ2JUWWRselFyVzhJOTNa?=
 =?utf-8?B?TGkrVUJSQnRtbFNQUWxOMUIzazZZdXFsQU9kaDZHSzlvS3M5T09KTzl3dWFC?=
 =?utf-8?B?OE02dFZIVFdVemlHVk85TEhpdCt3RVQvWjV3alYwMXJrVUNJejU2Zk5IU0t3?=
 =?utf-8?B?Y05FWHo5dGljNzdvazRQTWJLQXVnZWZSTWFNQnlld25peG5JeDA2empTdGdY?=
 =?utf-8?B?dTNGNDROZTlZenhqWFdDWEQxQ3dYZUJuaHRUQmtjVUp2SG5PcTJUQnF1UHpB?=
 =?utf-8?B?bnpkNTduNWthZVpXL3dBaFNvRWtVakIwYVdtK1N4QnJWc29DK0hteEdCRHZw?=
 =?utf-8?B?NlBteWEwTkFtTjZMYkNiNFQyTXA3V1F2K3RDNmxld1IrU0FTNW1qM2JBSllp?=
 =?utf-8?B?VEtSV1BHSDVCT3lNa2xOc0tIajhESGZoQWQwQUZ3eHg0VTBvWndOYlU4MW5Y?=
 =?utf-8?B?WUlTNVlBWExsWTdkRXRnVXcwSzdIeGRqMkRZMlRLVERmY0dsTTJzRFZsTEZj?=
 =?utf-8?B?TVFMR053ejAxazRPcEFUa3FDbWk0blcxQWhrWWh2TnFHcVBoK05nT3p6WG5t?=
 =?utf-8?B?dDZiMmY1Nytnc2Y1bDJ3ZG9mUXVMNkh1Mm81MGtuaEJkcTBKTm43VUZTR3Uv?=
 =?utf-8?B?Tmpxa1dxTVlhRVJFNTlwclR2Q0VMd24rTHQ3YmhTYUxEb25DRmx2WGNPMlMz?=
 =?utf-8?B?WGVNMmtnK0h5Q05GQWh0VzlyajUrTUpPWjVHME10SzhpQUxiOGp2aHFZaEto?=
 =?utf-8?B?K3ZTMDYvUkszdzJjeFBxR0RRZlFnRENySVNiM29oVERUT3pQUTJxdGl1NzB6?=
 =?utf-8?B?LzlqR3NUQjk4aTBEemxOcXhBZHNrSWl3K2VwVHpGamlwZE80a3h4UVFMcGM0?=
 =?utf-8?B?SFN2SUdOdGdvSTQwU2FucUo0MTF3SERvMUVueFFCN3NvcVdXMkVNekNIUGIx?=
 =?utf-8?B?QnlRcUZhZW4yWTA2ZEsrVHI4MERobzkwTTJ4K2Q1elZPQ2J2SlE4RWpHc0VI?=
 =?utf-8?B?b3l5QmtpbDN3OXIzQWkyemdqQ1RkREpJeDVDajZkZWRyZUVlaFBnM0lHbWRk?=
 =?utf-8?B?Z2JFU1pGTGlpVm9nOVlWTWhQMkJrRHBMcmRBdGhsSFE1VENSbEw4cnhMdm1H?=
 =?utf-8?B?Yk9BZGM4Z1IyY2wvZjFiNk1XY1lCVFVjUHY1K2d4RjFkb3ROczZaeHlLcVFZ?=
 =?utf-8?B?RS9xV0RTbkgyRy9yMUpGbVhiWTZPeWRRYUp0KzFRRUZ2bkhDYkhXdTVnTzQz?=
 =?utf-8?B?dWxFUGJMT05TQzJ2Mlc3a2FTRGp4U0VtdTQ4YU5RWkZaTTd5SzVXRzFLaXlP?=
 =?utf-8?B?TVdCYzBpc0VBeEg0d045R0I5QmxDMGFoZmZXdmZaQ2U0VFBJbjlVeU9sM0d6?=
 =?utf-8?B?ak8waVdwV05CMFY3STRWS0NxZmlRTGxNYy9BYnNrdnZCcG96T1lvbnBCTmlR?=
 =?utf-8?B?TWdyYUZKc0xkbkx3R2JmSHBPZjM5bHhyMUFBUUdRL0FuMFVvQXNQYTdNOGd1?=
 =?utf-8?B?TEFaVmpFcWhoNjNKZm1iR0R0cyttVzBtREZoT1NBenZVZzZBaVk4UFFLTWZs?=
 =?utf-8?B?ZTJ1bG5XaXN1MXlYc3RNY2J5NjUrd2VvcWNoV2pyVkpmTElLYTY4THJHUFpX?=
 =?utf-8?B?N1lFVTc5MWRHQzUyUk53enFMRkxrVy9Sb01CZ2ZKZjZaanBHS01La3NsT1B0?=
 =?utf-8?B?ZFltWi8wU21MOTVuN1JCa2dIMmxnbDBRZGY3RklmWDdscThZOWlzc0pOUWhP?=
 =?utf-8?B?MXpFS2Zlb0pNTWZkc0NEb2dXK2JhQUF6SjNKdHl4TUpicFBSUHBYb1JMdkF0?=
 =?utf-8?B?YmZuanhBcEZRcUtJOTJhUGt4bDVPb1E0SExyQzRHcldpWW9jM0pGSCtNQ09V?=
 =?utf-8?B?SVVRT2RhbjBuZnRmcUJUUDNlclpjWVA5eHRNd3pZaHR1a0hXcHZuNTN6RXIz?=
 =?utf-8?B?R0dYN3FQRlMzelBuNFNWSElXWVpNN1JTVEFZVzFway9oVkhuMkpWM0VrMG5p?=
 =?utf-8?B?aEJtYTE2Sko3aWs4Y3VTWDFWR0R3RitHRlkxaHlNczZ1M1UrbklDeGpqN1Zn?=
 =?utf-8?B?QWIxYjBrVGduVXRmdEdIVURzZzhGWjlNNTVQeVZ2OXBPa29xcW0za1lsc2ZL?=
 =?utf-8?Q?USxsaOFaghCIz88NQIDYWvw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0299e2be-4125-4f60-e54c-08de18b88e9e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 20:03:28.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk8JTMCdxgyNAMof2Lb9oTW1n8yExQecfTEMpf9Z02F9Q/SJMwz1NEF9H5CnjZzP9U0XU0m81do/tC3+Z64IdURl80qaxP5q+PL34YwLkkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11589

On 2025-10-29 09:22, Thomas Gleixner wrote:
> When a time slice extension was granted in the need_resched() check on exit
> to user space, the task can still be scheduled out in one of the other
> pending work items. When it gets scheduled back in, and need_resched() is
> not set, then the stale grant would be preserved, which is just wrong.
> 
> RSEQ already keeps track of that and sets TIF_RSEQ, which invokes the
> critical section and ID update mechanisms.
> 
> Utilize them and clear the user space slice control member of struct rseq
> unconditionally within the existing user access sections. That's just an
> unconditional store more in that path.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

