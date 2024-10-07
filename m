Return-Path: <linux-arch+bounces-7742-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE0992678
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39531F22800
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6AA18756A;
	Mon,  7 Oct 2024 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="iXUfyCCp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="giT0vT2h"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout43.security-mail.net (smtpout43.security-mail.net [85.31.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240517BEC7
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287705; cv=fail; b=I4EiQMFucUBN8cj3kX8CbbjBHVFxqwe6hHk5nvYiGQNQpstQNjS3vilcexoxt0FdZpEzt99pMv1KSjDs6loAOS5t9fp78pfvKRZHDJgxvtmcjgOt0FzAEa+YE2oYcs6TRMEiZNpeWAdA6SFvLhAc2n+Ix6ViM1zgqAQHjRfm1ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287705; c=relaxed/simple;
	bh=YYodBHEz3M7nyLTlKNrZeqaSl4CeiZ0wgaWBxJEDmOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HUqV7J14CXKWlAeqPDpzyOZBHgCRXVA0XFNz3sCPvxpvf1psNqmxBTNrurcp+b7Onk8/HisxbZjXwX5DCrpiAFoUXHqcQkMKUTR949MxcmckNx3CBHRVqTgJrdLCM+yXI47w3c1QaomsG+Im71KAkyQryBF2mpjnnsAESip1C9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=iXUfyCCp; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=giT0vT2h reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx303.security-mail.net [127.0.0.1])
	by fx303.security-mail.net (Postfix) with ESMTP id 64CFA30F26E
	for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 09:49:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1728287348;
	bh=YYodBHEz3M7nyLTlKNrZeqaSl4CeiZ0wgaWBxJEDmOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iXUfyCCpKBN79+G58XYj5+Xy9DM40w9yWsT7PHjzWr+tCO3Ce4GojginYNZ62Jhnk
	 C5MxChPfEOv4Yb2ZcUbucZ+YJta1/5YhucKrJXhQ7MYi0fshrmT+nLiuN2MTh7Ba2+
	 UK+qUOFP7WfNz8BbI7SIL6VhYpc/DngSiqF4LyLw=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id EFDE230F14C; Mon, 07 Oct
 2024 09:49:07 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012054.outbound.protection.outlook.com
 [40.93.76.54]) by fx303.security-mail.net (Postfix) with ESMTPS id
 0E20830F092; Mon, 07 Oct 2024 09:49:07 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by PAZP264MB2639.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 07:49:05 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 07:49:05 +0000
X-Secumail-id: <14.67039273.c4e1.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAoV2KFwIZWtSqSZ3PdlvyYLC9qRWqFDYj2gJuMtMRmZKx/OIY+/nZtla4+b90qs03L5JgMKsC8vaFqojESe21Fokr60T7CKLS7+Bk5/9A8VEzqUAXtiWYTifWeG2lL93ICGR8J/fUemdiuGkWl/r7PDvDboZ2Q4EGbMjyzOS1hz1NWBQEApZwxaaDhscFX/Y0Z5uHUkYVdBzCwxRWI6JOrOmqFlVk0eJfuRs+42LGIJN6ljYsGWNgo6fY7VsLA8nJG2qfyFUV9A3bGR3H7ECbuJMhQ4uOwyLAsng0m17jcfggcg8qRb0uUA83NbrclAuGTB0qEEK37uxEWVRwo9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzIcHzs5BYjbYfc0HgiwyzORcHmSt6bIT9aGPxNIk0M=;
 b=ZBO3gdLGPVbAe/MH90vkBBwK7s6o+qiMqDAPWBrP5aQowRB0ENRqaPODbgZLHNjgyCYl5/laZLGJMt5f+KN9W+sRn+s8gkLFnSsOwhv0nkFbXzyE63kye0ieQGxwDL+kTHPzdvBauPPZ99MEGnT2MlqN/mhXyrXQGdye8IKfKlOSafe3ciLi9zQHhAotWy9yzDudP0M9FqHEKusCECfB8iYPg7zzHLLtFcTHPrSzKrSWslmq4xEjmfWXUxIJbc/adaNi1w9n7KSn61KECG8/haI+NuX5oNCXECr/sp9i3NbcxSHShhOnBAfpL1LUr8PqggBUQeZs5qfFdrSmT4fPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzIcHzs5BYjbYfc0HgiwyzORcHmSt6bIT9aGPxNIk0M=;
 b=giT0vT2hR2PJqVwsqpzo8vnux9l+i4unMSuFL74qibcMVtHa5+z9HeC+XioeOBcs2NSxto4k6ZxZMRqpg4pP7hOaRuwBRGyOOATnfkQhkMIqmJir8Ec9yG4nVVtFquYXYDRZf3RDje1YzaoiRtHEJoSRY+tCwjjM+SdiGslIIzqhhC/oenjxF4O89R1gzmXvJF5z7nrHhapQx/xkN7sVC0Ga2Pw9EkpquYduL0CwzicxenbaZhrY87+mituCo2LjQSxcIofzXHFtcWuJwSlOVCdFYjmK84EWZuoFCPECg3UsTXSuNctUP+PzgA+4ItLyKT12RyFFaIpO2FADMMsFrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <54985915-be13-46ee-ad42-7dd5d9d245ac@kalrayinc.com>
Date: Mon, 7 Oct 2024 09:49:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/10] um: Add dummy implementation for IO
 memcpy/memset
To: Johannes Berg <johannes@sipsolutions.net>, Arnd Bergmann
 <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org, Yann Sionneau
 <ysionneau@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
 <20240930132321.2785718-10-jvetter@kalrayinc.com>
 <168acf1cc03e2a7f4a918210ab2a05ee845ce247.camel@sipsolutions.net>
Content-Language: en-us
From: Julian Vetter <jvetter@kalrayinc.com>
In-Reply-To: <168acf1cc03e2a7f4a918210ab2a05ee845ce247.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0120.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::25) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|PAZP264MB2639:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ead3b9-a2ea-4968-445f-08dce6a4845c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info: 05aeneE2a/+O4NoJiIiFVTBm+Jrk9fzZx11Np4iAFWYnXd08naxGlcCbQDCOGup5/uzydeJnAuLf30E9lk88eJT94ktORjF7KeivwJ5RiQ9ZpJMVAWuoFyhukcQKiz8FKsl1AUTB7S4wM3yRmw14+LHY0rQ0aaCo0hBL1Lr8Sq2qOhHEVnETWyMIlEaKAS9QazCktsjCtF0YEFhOuNuExRdr3UYZUZe3i6Bps837/sQ8HhbSVjNpv3cv7Ci3l1ZnQoHCb/X152gKthR5I54JIsnYYWVCovCbKvmVyiDbBpPYZSgvQUNIL7HXZ5fscDbwljplmHnv1wcq64DF1ETzKn89VSf1MDP2i/ln7MrFU82ggYjCLwUzpLqDCyPECJW5W5UWsdghmEgeLG9KGAdxGHtXcUZmwhvreI1Z9COjwQht0ZJZOPlfjEoCiiypvOGGdXVMjnxnS+U3BwN22qDYR26z7KIXeXae3mswmF62b+8KFrGVx7NJ+KuuwCyFrrG9YUrpMeqpcJAMaG83QKo6yDbBs8VNbWu0fq2qZ9M7mx1yOQW0JAhVydEuCrpB0FaA7hv6bOodr7r1AzDuOubHtWdN4Q0qAkNjgewjNRm7TL4M2XXdDKqSU+KQrbm6BRuvyFbjkRZnrW7mWxvlopLqMAufuLHteKhTucOeXndm6ZuPXMFV/Y5d5XzWsrcRInN5WPYUvia9JHpQ2moJ2fGOppYFxcH/R246EQSWo6F7k2SbsYNUViJzsSPPLGS5+XiPfH3UJOyIEV0ExA1qpsB+MArlW6i9q0pBQvPRgJ6U0712UlktxE0znb8FCg1WzjmuV93LUOayMQbwFaBDzwZxiw3hqaOB0V3JfNHvaFxqYrqbuDw7egjaOiejvqV9FYTQzPc9HP30x/svRF7wznMZvBITZdDQbMxaO0QVcLpOtE4bJgjTWv3rhYzWl988A2kkXW/
 w9KB7JDK4d1kdvKj9RjxPleOzhSuWBKZ6vE6YDRDG7oxEjHROdF09lytLwY6EKKdY1sY1oZc5428kswEwWBXrfi5nmoGsl7YioKy2M1KZdD24hhqNtF433cWR7x0mVj2LQcVJjlG+qb6OGqz6MfbYd/j4pdQs6nfsYq/SbxqqsqJlcMwyYPIGgtyKIIEKOOKtK8LtmUAZQJM7psHFXsV7aSQcJNNF1385p/ETSUhlELtLnylkLTYIcwX9zhUoUE/4xJggmARB4uDbsdEJH6n9fxyZy++ISiEnYQ25apzyUwUKqdfw2uUYcEGjHZ8t88Z48YIDUgJBQ4vXNdcdWgJxP1SeXW0Ugb50gMDPm7KHt1qvRPp+IhYBLx5oRtN/jXknvwNpZriBRdHv2mbwzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0zglHvik2/sNcb4Lv7zNwvJCoj77L5GPo6IbhSsYq+M6ro1G1r++rTXXWVN4vkto3jOnAO1aBfY5k8Wp5s4gDrrujM80Fj/mzmDJAKaQEr8gCrgVc9f3DqlVslVZqLqkTLnyq44oqnBPG8NhkMFwhyEOVazE9G+kR24xJ3rHEG4Uw/GYmZHgHA1tM/ACAdVa4pfB7dBlbhKu/3tcwHmfNkEcyypcz+KT5bxJNDpPJl+5hwsT1wVRM4z2hIwVKn8V7oKAOsvOxV7iaJ4KRLsw7NWOKWRdDSBZT0Ivs08b+tbYG6Ivp8vzHuqthbTMg+puRPX0ouSOvjVnhEegSN0/TetEWNIT3BYaKyVKw0bkhA79bgSSX1x6BSsepXARVz1jJS73IoB05I4emsU4C9FebT/FTw6Gt3PX7Cf5bqljOTndWXQ1sAPeMaUn+9xkgg1G62HTzz9OqbNScxA7RbrsfZ9IcP9U095T4RIDtK3QqqB3TIZL9V3HErG+RZmOYoRsr2i//7vqjO23VxfsRwyAazStybKeozQ5b3dqQcP5gNzz414f8GlmKC1AFFyEoPlpeIOH/TEe4Dngext/6hnqUV6t9bOSgL6pRxHPCJ5SEQ9xk4lykzS9IiXIeDc/ubBcrtw7FBKtNwapFpksIksS/PPdPvWAo/0t6e9Eqdg9Q1J/piN5aZ9sCLrfAMfuohi8xRfuHasA/zWJB5hU9Q8rd7+kCylJ4CWSAb7Xi7/Lky9lhQ4dXG/9+G1Awd0Il0LkbMsrnFfGkrWvs87fUWqkldzi2Tpp/VY/2lTul4zCnfGAB0Ll61Kd7e/x0Gf1hHxw03t7bn7KvfqSRQVamYPjLNeRMtyB74lh4EBCfQ0+d7u4BgxWXMHB0wdJ/mpgo2yiQ+UunQcpQnJKfP7aqKBhF+uOMAXghvLzw669vNZo+LGcJQgoG2tSNbu465KC+ucz
 F4YOWdOtFkFMaiN9dB3JnO++JJ/4Gza1WefUOjX9VfDU7wbYlqS+j95pwO8xRiQ1xdQz6L+yWIZOt36aY/L09sN0WftjMWioIInTKZ7fhur2CjXYikSp4fGrcmf/kHw1oXOX2GdDwkcaNpzxKiCISH2X3eWdeAKrU9Ydend3XkzVCQRL/475vfUf4NdtyHmBWZqLHWDBgiXHGx+PXwJPup7SbNVVmzW06KD+loaOciRTHN3GglVIvXwz+LHB1rqtcyNKziaoiJJD5uvOrD1/4yLiKLCa1Anlkqpb/kxLolz7Oo6im2Es9qOhYSBlsdSH5qT5I3JOSUPTyN93BX0ylvZnUf78nVpRPsswJePK1BZi3FdzG9Q5Y9A/GdFErVWpcHVq/nylZc/BnfJLdNWrBJKLf0SR8dehuqCpwcT8CSxUHBwunnL/ENMhDHTNn+b+V2eLErsGFzh9Gr0lKZY/7XdHuF29D2UMCvWbJUSnjTsH+I3++tfAMFuuSZdx04Wd1dASneezvzkAQmT1kYVLz7LUm0yLwlZa4MdyMOaI/eKfVzOGZ3Fngj31M65dindjb+MlKXnlsQGfuoY4Rd7VAgc5Kn4lZiF0njY96MF7dagvEgpaT9fhTixN0zTo/t/e
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ead3b9-a2ea-4968-445f-08dce6a4845c
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 07:49:05.0949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LWnLbA2gvHhqVE1Tc3ySx11W9CkpfoqlQN/OJKsNfsadGzhdNMMQZUwT+YVkbCqmad1Ct4FZBKJvZp6tlLpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2639
X-ALTERMIMEV2_out: done



On 10/1/24 14:53, Johannes Berg wrote:
> On Mon, 2024-09-30 at 15:23 +0200, Julian Vetter wrote:
>> The um arch is the only architecture that sets the config 'NO_IOMEM',
>> yet drivers that use IO memory can be selected. In order to make these
>> drivers happy we add a dummy implementation for memcpy_{from,to}io and
>> memset_io functions.
> 
> Maybe I'm just not understanding this series, but how does this work
> with lib/logic_iomem.c?
> 
No, I think you're understanding the series correctly. It doesn't work. 
I will revert this.

> You're adding these inlines unconditionally, so if this included
> logic_io.h, you should get symbol conflicts?
> 
> Also not sure these functions should/need to do anything at all, there's
> no IO memory on ARCH=um in case of not having logic_io.h. Maybe even
> BUG_ON() or something? It can't be reachable (under correct drivers)
> since ioremap() always returns NULL (without logic_iomem).
> 
Thanks. You're right. I added this patch because there was a build robot 
on some mailinglist building a random config with 'ARCH=um' and with 
some MTD drivers that actually use memcpy_fromio or memcpy_toio. These 
drivers are not guarded by a 'depends on HAS_IOMEM'. I thought I could 
simply fix it by adding stub functions to the um arch. Because I saw 
there are A LOT of drivers that use IO functions without being guarded 
by 'depends on HAS_IOMEM'. Not sure though, how to handle this case.

> I think Arnd also said that other architectures might want to use
> logic_iomem, though I don't see any now.
> 
> johannes
> 
> 
> 
> 





