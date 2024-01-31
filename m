Return-Path: <linux-arch+bounces-1897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6837843B81
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 10:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE6CFB247A0
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE7E69964;
	Wed, 31 Jan 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="C72om1JJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="fFUl5Gz6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout37.security-mail.net (smtpout37.security-mail.net [85.31.212.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BE69947
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694906; cv=fail; b=uuDVqqce42lp+2iPXxYttYdcB0Fox3sRPUETwkkezEj76S/nH7VZ40o14e/VqERqy/4m+JqcIQKzTGJXSLCD8VneScIi6i1bEIYUOydRw5XeqjkvLUPAbofRKcZhSVm+2XSX1n5XKWiIq8Lui1UZtWehgXrIuaqgOAf1rEZhqrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694906; c=relaxed/simple;
	bh=n3uXrrzzWaWWDlrViIwRreUQvbzXibng4An8pHcosoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gDhtbaFiU5bT7YolnOyAITzWeHQeuBLcNn0WIYrQ6DgZhW5/J3Vo+H/Q/5Ckd0I6fbCMnhAxE8M6xWl1mrZNiAbZqIdp2UFxK7Vd7I/aQxX82ol+9LBIwM3OhtvE+Vtk+tosWiNEaJEc7c5eE81enyN7Rzun3HL/wLVunJ/zHOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=C72om1JJ; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=fFUl5Gz6 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx301.security-mail.net (Postfix) with ESMTP id 0F1299ECE3C
	for <linux-arch@vger.kernel.org>; Wed, 31 Jan 2024 10:53:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1706694785;
	bh=n3uXrrzzWaWWDlrViIwRreUQvbzXibng4An8pHcosoE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C72om1JJ0NN5DvK7v0pUWOsunocLJmcc7UM8seT9u4GIoQWSzxO+MR8pjYsCwCROV
	 u97CVsfXLB7OECKEA8IxwAnidmViN7S/4XM7DbFN+rsAIYZavvwssqscQNYoo95U1/
	 C2RVy2fWYt/kCSjZMRQ4uTj5AtUjTcqWEDJqvf4k=
Received: from fx301 (localhost [127.0.0.1]) by fx301.security-mail.net
 (Postfix) with ESMTP id AA63C9ECF32; Wed, 31 Jan 2024 10:53:04 +0100 (CET)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on0100.outbound.protection.outlook.com [104.47.25.100]) by
 fx301.security-mail.net (Postfix) with ESMTPS id F29C99ECD8E; Wed, 31 Jan
 2024 10:53:03 +0100 (CET)
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:13::5)
 by MR1P264MB1908.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:12::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 09:53:02 +0000
Received: from MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a]) by MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1300:32a9:2172:a2a%7]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 09:53:02 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <13599.65ba187f.f1ba6.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U79dQDTEBjwqiCFZ78Vyc7MfRTY4cumqMgNo+TfllVxy4Tn9JENnZ6a17EWfHHIaaVQfQ1f22nQ+ORyf2i8yiD+Z8G8ES7O4zSt6tAP0yahA98PAnsRvS1isWRdBDnb2c/aiZtJBntuEhW4c2dM2miWZxr3uEzSzP0ci2wDj3dfxjConL6/dvy35vUG5ADDG+yy8OImcO3TQ9JmbtaCRpXodT2ylofnGbkaeaufWDL0CXjXLJR4OPLiOpWvLoJ4XfqvDJ/5f7H/dys/FNNEaA7DbFJUbJb+swJMpIjg6ZYQdsnWUEs2iAuiUPZ1uDx3Jt8eIo/4lRptpXqNLDv63JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qYdWYzfUcnoQWYfh/DWYXPiPJlj2xh/vdvzaU9qDf4=;
 b=GmYxeP44j6y7MnL9fxcFfU/o2Z3xHhB/013FQOrvTsbjPobzqWsbpZmsK3ijnnQxf0eI5qTO8HqBj5HljJQacmdVFaUDY41wbXC0yRxJQqd1AfGeI6jehNFmZ210A+m1S/GwypUV/FhVJyY1b8yYSWuZMWb+6N0HXZMOVeHFMiBjV4t5wOOcuyc4kBzuUzH8EShddyNZZ/0tAUl1SwwNlN7pPSu1O+r3I/XtdYwl8O7IFW4tMrn/lqE8p8aahFKpdK1keBrwZfCOltj/AdkizVu2d0vZ6q1T86kiIZdrgKcKxtRJWx6Rn2sm3Qrv1aw6zB/X8NErwYrnq63UbcCUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qYdWYzfUcnoQWYfh/DWYXPiPJlj2xh/vdvzaU9qDf4=;
 b=fFUl5Gz6NCqbTByjbL0OUFRPg8nxlADMd+5CjiILMQqJQNvWf57nZfkaW9YOUAuauigTpI6/XiXlPf3VFxQ3KoYuxl+ZA83EJxKCUcURiRE4+i140WWofOsZDqfus4AtNAtnZ8XustfnVaGEjgL0DBzCDZ/4qTpdjw8PnAvvl8luztV3XUQeCZMQYHHDsYrjMVwdzVy8i9GpmjXIoq8BffQy8zpns1HxfbN5VD9gycb5rTSeKa06jCOPXe+6SIFOAigzD2TQi8X2kYS3K3QwSbj82NGnh3t354g08ZwRMlKuIpcalyAAcX0PxqWNkiqe2fOtUOeOZXnDcsvelYVBMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <269edff0-d989-4ac8-b0c3-bce31283806b@kalrayinc.com>
Date: Wed, 31 Jan 2024 10:52:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 31/31] kvx: Add IPI driver
Content-Language: en-us, fr
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Yann Sionneau
 <ysionneau@kalray.eu>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet
 <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier
 <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Mark
 Rutland <mark.rutland@arm.com>, Eric Biederman <ebiederm@xmission.com>, Kees
 Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar
 <mingo@redhat.com>, Waiman Long <longman@redhat.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Nick Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>, Eric
 Paris <eparis@redhat.com>, Christian Brauner <brauner@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Jules Maselbas <jmaselbas@kalray.eu>,
 Guillaume Thouvenin <gthouvenin@kalray.eu>, Clement Leger
 <clement@clement-leger.fr>, Vincent Chardon
 <vincent.chardon@elsys-design.com>, Marc =?utf-8?b?UG91bGhpw6hz?=
 <dkm@kataplop.net>, Julian Vetter <jvetter@kalray.eu>, Samuel Jones
 <sjones@kalray.eu>, Ashley Lesdalons <alesdalons@kalray.eu>, Thomas Costis
 <tcostis@kalray.eu>, Marius Gligor <mgligor@kalray.eu>, Jonathan Borne
 <jborne@kalray.eu>, Julien Villette <jvillette@kalray.eu>, Luc Michel
 <lmichel@kalray.eu>, Louis Morhet <lmorhet@kalray.eu>, Julien Hascoet
 <jhascoet@kalray.eu>, Jean-Christophe Pince <jcpince@gmail.com>, Guillaume
 Missonnier <gmissonnier@kalray.eu>, Alex Michon <amichon@kalray.eu>, Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <git@xen0n.name>, Shaokun Zhang
 <zhangshaokun@hisilicon.com>, John Garry <john.garry@huawei.com>, Guangbin
 Huang <huangguangbin2@huawei.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Bibo Mao <maobibo@loongson.cn>, Atish Patra <atishp@atishpatra.org>, "Jason
 A. Donenfeld" <Jason@zx2c4.com>, Qi Liu <liuqi115@huawei.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark
 Brown <broonie@kernel.org>, Janosch Frank <frankja@linux.ibm.com>, Alexey
 Dobriyan <adobriyan@gmail.com>, Julian Vetter <jvetter@kalrayinc.com>,
 jmaselbas@zdiv.net
Cc: Benjamin Mugnier <mugnier.benjamin@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-audit@redhat.com, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-32-ysionneau@kalray.eu>
 <995eb624-3efe-10fc-a6ed-883d52d591bb@linaro.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <995eb624-3efe-10fc-a6ed-883d52d591bb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0309.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::10) To MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:13::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1P264MB1890:EE_|MR1P264MB1908:EE_
X-MS-Office365-Filtering-Correlation-Id: e310339f-977f-4e5d-50dd-08dc22426a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zY3OBspCqhZ7BPk4QYArZqQWGq1NNy94C0x7+KA8xUJotEwy8iPZFmmTgy+K44yfZnfUhZJoImM0Vw6dMkKKZqYnxhF1QoSD7Ar819xSS7+6nOZPrBsmcbRha+o6bzxYeNYTHrmS4NP9/TEr/nL+pRGdd6zQbT1no8poVJMm/2TjuA5P0FQUt7/GopTuXvpjrrEzMHVe2MUd7fP+0WuQllXQo40mkBelxX4TCxPizSErnzf1vp3WSTdbt1nrE7oDPVecCeedB3YiW52tp/tgv9Q3XXRxdA6qFsc09nWi8iAMh6ILBum15fJGbjZgkMFozEtNvW3BqvNfwi5QwjIkRvHwUV3fT4LHkliBF8sbq+UA7j81JCxLt8+MeV+nlPPQdxcxx5ag18ihurvjD+9gUYx0TxW/HFXzPtimg74CYstI/GjO4NWASeyz3p7QF0TPdosIAZYTppirMoMJAZh7op96+nSvfHVpDyZArr9UcgEudEDGpirTtNggeDEpOT159S7IghNg0qjouSIp4VkND1aFsOagoLspd4bai9vljLgC+BsBuiDbEhm5W0fhmsPEYPJzJQ1vjrG+ECgD4rRdJfaKQLQo7fdAM6ivXKaBNgXNoCaQ3Fs5tgsXTG6b6uU0OYfUqUlgzo7WuB7eDhk5PJ6d0ATJ4njtD1TpxWGj7Kmy2CdaJwXUDymGbpZ3uj79
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(921011)(31686004)(2616005)(41300700001)(1191002)(966005)(316002)(66476007)(66556008)(36756003)(6512007)(478600001)(53546011)(6506007)(83380400001)(6486002)(6666004)(38100700002)(66946007)(31696002)(8936002)(5660300002)(7366002)(7406005)(7416002)(2906002)(110136005)(86362001)(4326008)(8676002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aPFlMx0h7/7NT0uP9FPvxJkJqKZTWGf2n8FZTBmMWdvmHPxy5lQwIYMLwNIa59JNDZabgLkcLIJ0EEOhocDk4nyF2NUCpqnlaCO/4sOXxyZRUpacuL0PL8xW5tbpXM9MSWHgbeQLe+ktpaL1mJAH9cmzrALd5bPBucagM2MXjSD9mbzXsMzRvCoSjqwDQAXWqydUCeUUhzOymSjMueo5aNqXZTvfDJiLqImF5ckxDTwQ9xrMznQ2XTTNgmQ/PhK+q6R8pT/+9ZtmHLqy5ffIVF1d6zvIAAaqKiSPWk834ihFHcLti+gmYY8VhXYlHOzsnfYeVivsjFRd8usmZ81jueL6Tm5fihc7whq8BdP+XtkUh7Xqk3QDvhgZlJUh/Yf2jiY34xyePrUnej/qTKYriz2hNLEiiYvxLcB3gBUj+EgHujcvBlK2HZF0g351pcEH2h/Pbe4mkb6ZTxlaGrrY+NgDu/F0h1jKoxCxGLt/ToCuF9QE0MXx4H/gRZReDqG6KobpTafoy6Kf37fumohI0KkLgqXc8RU7Sf5+FBxBoPuWRBHjy6cD0923dkpkv7TsTFw1gfFWek/WKI0OG+2j3LXvDMwSWEHa9wTIq5ZAaO14gF4DqqslgbAkDXSSDAp5avdZ8pOL4TBwr/9IOFG+pqxRpmjpviILylFY8jiOjIcUSVlEd664qBKmC1wRW4YD/TsTxlVJcY4Fqlozg9yJe0d+dUDXfWFgZle0OZSZAYC9gXJlmHXKL3B5nDx3CNFQHuflXd4hoDZvVNpJNCnBYxg2vAGXpE88cNEV2NhxBIUQl+dtakEYUjym7+eXSbTMl364AXnMUcy1jUFSHRz6JtDq+9wJ8gDyb0xMsai0ICXB0JoitDjBE7+RNw/ifKqmiIle6lw7YriVAM9a33wS4eNZHBDohPVy8FT1oOgIXLA6lG5LP1g57COeRmvvcopF
 c9DrDlSRGLr8B0/SbWvXyCj06yXj2KSucyXo7/ty+8AwREbNb1kQwF1n9Mxkin5BN9v7nWeqV78yQD5k6IL8y5AGMeQRzjDyXd1RlkBFcMwxl988h0dxWIl7iQbWdm7i+GnZ/44cacozvPD6yRt6D/o76k5dcpKefJYIWTkSq5/aSDR/MN4bS/TyVzuItYXjRmeotIiIQZuaZwXTDc97WojT869ftUCYfrJ7IT9R0xdYIemw5pAE4RN6eRA9GYaGU677L5F9RuDAn4kOIToq+gVzAUB11eaEMn2BOjHCmV3g9Le9UwfQiwVn1B4IyK7SvUwZUx7GOvVy+B5DBsAV00PPjUOssnoXD4dgTNpJlqzvbBXjNaPb82WIpGgOEpCFzGvOIhTHqumH+S2dvV9zbX1R/IJ7+7ns0h8JYOWOg+gNBwczmx6aIw9KvHNjTo37oWqMhSMETtL0hdJdZFlb5/he5rpa+UuqSmq59tPzqha/5iHKtwkUGNFG0AhB0gOpgx1BgQO5GMvcGUleS6jtpC/WOUF2S1NmLyf5j8G54l3uT1MPFsv7bUn/NzqPeHNppMvi6yuAGVtajuVZ2gXR4YzS6ZwDfXgkEIu2fdYUHklTwrY32dKetWwMjQ61zvGRkMeM2N7hzrHhR1KLhddCXyAm3A80T0gEmGGUwwMnTAJlkZNdGKSByVi3iX5SyZqa
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e310339f-977f-4e5d-50dd-08dc22426a1c
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB1890.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:53:02.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqkoUnkmcthhkHleNpTEnFGg/mK1DRUeyozhbzc6IDZz5aj47WtMkzx4Cn9cge6BEaQDBueQDfVJJJLXoyaiGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1908
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/01/2023 12:54, Krzysztof Kozlowski wrote:
> On 20/01/2023 15:10, Yann Sionneau wrote:
>> +
>> +int __init kvx_ipi_ctrl_probe(irqreturn_t (*ipi_irq_handler)(int, void *))
>> +{
>> +	struct device_node *np;
>> +	int ret;
>> +	unsigned int ipi_irq;
>> +	void __iomem *ipi_base;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "kalray,kvx-ipi-ctrl");
> Nope, big no.
>
> Drivers go to drivers, not to arch code. Use proper driver infrastructure.
Thank you for your review.

It raises questions on our side about how to handle this change.

First let me describe the hardware:

The coolidge ipi controller device handles IPI communication between cpus
inside a cluster.

Each cpu has 8 of its dedicated irq lines (24 to 31) hard-wired to the ipi.
The ipi controller has 8 sets of 2 registers:
- a 17-bit "interrupt" register
- a 17-bit "mask" register

Each couple of register is dedicated to 1 of the 8 irqlines.
Each of the 17 bits of interrupt/mask register
identifies a cpu (cores 0 to 15 + secure_core).
Writing bit i in interrupt register sends an irq to cpu i, according to the mask
in mask register.
Writing in interrupt/mask register couple N targets irq line N of the core.

- Ipi generates an interrupt to the cpu when message is ready.
- Messages are delivered via Axi.
- Ipi does not have any interrupt input lines.


  +---------------+   irq       axi_w
  |         |  i  |<--/--- ipi <------
  | CPU     |  n  |  x8
  |  core0  |  t  |
  |         |  c  |  irq          irq         msi
  |         |  t  |<--/--- apic <----- mbox <-------
  |         |  l  |  x4
  +---------------+
  with intctl = core-irq controller
    

We analyzed how other Linux ports are handling this situation (IPI) and here are several possible solutions:

1/ put everything in smp.c like what longarch is doing.
  * Except that IPI in longarch seems to involve writing to a special purpose CPU register and not doing a memory mapped write like kvx.

2/ write a device driver in drivers/xxx/ with the content from ipi.c
  * the probe would just ioremap the reg from DT and register the irq using request_percpu_irq()
  * it would export a function "kvx_ipi_send()" that would directly be called by smp.c
  * Question : where would this driver be placed in drivers/ ? drivers/irqchip/ ? Even if this is not per-se an interrupt-controller driver?

3/ write a "dummy" interrupt-controller driver in drivers/irqchip/:
  * it would create a dummy irq_domain, ioremap the reg, request per_cpu irq
  * declare a struct irq_chip with only ipi_send_mask() callback declared so that generic IPI code in kernel/irq/ipi.c (__ipi_send_single()) would work.
  * This would make use of the generic IPI code like what mips and risc-v are doing.

4/ consider our "ipi device" as a mailbox and write a mailbox driver in drivers/mailbox/

5/ consider it as an msi-controller since it transforms an AXI write into IRQ. The solution would look a bit like 3/

6/ consider the ipi as "part of the core_intc" and add the content of ipi.c in drivers/irqchip/irq-kvx-core-intc.c

7/ Do like OpenRISC and CSKY:
  * declare a function pointer in smp.c (see smp_cross_call() from OpenRISC https://elixir.bootlin.com/linux/latest/source/arch/openrisc/kernel/smp.c#L28)
  * declare a "setter" function in smp.c (see set_send_ipi() from OpenRISC https://elixir.bootlin.com/linux/latest/source/arch/openrisc/kernel/smp.c#L202)
  * write a driver in drivers/irqchip/ which ends up calling the setter function (see irq-ompic.c: https://elixir.bootlin.com/linux/latest/source/drivers/irqchip/irq-ompic.c#L191)


I would tend to exclude solution 1/ because it does not fit exactly our arch (core reg vs AXI write), or we would have to do an ioremap() from inside smp.c, is this acceptable?
I would exclude 3/ because it feels a bit dirty to hack a dummy interrupt-controller... our IPI is not an interrupt-controller, there are no input irqs. It's more like a device generating an IRQ.
4/ and 5/ feel a bit over-engineered.
6/ I guess this would work since irqchips are initialized early from init_IRQ(), but it does not reflect very much our hardware since each CPU has one core_intc but the IPI is global to each cluster and is accessed over AXI.

Having considered all of this, I would tend to end up with solution 7/ but it honestly does not feel much cleaner than our current proposition. The function pointer dance feels a bit hackish.

What would you prefer?

Regards,

-- 
Yann






