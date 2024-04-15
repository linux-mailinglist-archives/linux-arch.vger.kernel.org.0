Return-Path: <linux-arch+bounces-3687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EF98A52D3
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 16:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6C0282BCB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C0F74C0C;
	Mon, 15 Apr 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Jy+YBv+D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="oq9nWQN6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8074BE1
	for <linux-arch@vger.kernel.org>; Mon, 15 Apr 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190505; cv=fail; b=UnMT8AP+fPvaAossxxtJsn2ZqAJZxvM4sxliTENCl3nCPdu9fml4vNDWiUthhUPPfIwZ7p3n4NEmdNC3v7jOKiucuL+ay/IuN/G/0t8/nXVfPme0+dIW45HybUAtEjfVQRtW+aKdXC2Jxl24Nzr7yYOYdLaDlbKv3ENnFVukcWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190505; c=relaxed/simple;
	bh=gTcXzedapfumCfG1C5hGXn5BqA3Ug5Tu69vaTDFYcA8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fx0cuzNMwKlIs4z+U9pw01bGm0Dtb4xRFqIAG+r1wgA72Nb4uudR9T+XsMWuZJgwYTtZle4ia8igNEX64WDsbNp8ic/yH8EWix0jwtmArUHNbKZx/xTKo3zhLI7MgshVMpo8qrP7q9A3+T/JxoInWubEyZ+sDBsqNYhvza24yZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Jy+YBv+D; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=oq9nWQN6 reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 85388322C6D
	for <linux-arch@vger.kernel.org>; Mon, 15 Apr 2024 16:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1713190129;
	bh=gTcXzedapfumCfG1C5hGXn5BqA3Ug5Tu69vaTDFYcA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jy+YBv+D6tvzCtLBQ2o5cSzI+ChMMN5Cbz0jSi8eN0yT1ehe3TzlibDrBDc8/3kDg
	 l+uplB0mQYe3E3Zi+KFX4qkoStlsByPMX7xmoEOoQBoNTKcZAYwev2OiQypOL7RMj/
	 xPBTTg52s3BEU9jUSo76L13IdAqzbhYabXW9aCR8=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id C623332267E; Mon, 15 Apr
 2024 16:08:48 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp17010003.outbound.protection.outlook.com [40.93.69.3])
 by fx408.security-mail.net (Postfix) with ESMTPS id B78EE322447; Mon, 15 Apr
 2024 16:08:47 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PR0P264MB3722.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:163::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:08:46 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d918:21af:904a:ce0a]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d918:21af:904a:ce0a%4]) with mapi id 15.20.7452.049; Mon, 15 Apr
 2024 14:08:46 +0000
X-Virus-Scanned: E-securemail
Secumail-id: <cd23.661d34ef.b66b7.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlF3bZWwhLaTdEMNXAAqz+XTjUFeYjzHOgopsM/EwFY7xMgWLmxe7GBXms3k9zzt8DAgQpQWuEe566ITrzzp+3x6TUqkvyQGeGXExVUhSCMDyPMnhgBPhQ15cQdbAwzEmE+mp9dIeILFRtmHUlZHFAkHrZXkRnWRLYCLT4cKmi+yxKkz2IILnT0rPVTY7x9004b3Avd2ciVeg7maRCnShfRziZCc4JCPLVwaa7VTDqLL6yuGfoiq7UMmGmOnHLgbJYIbvps73z3yLtlOKhSzhZlNgeOlvhXepc4U9qtCi+f531rsSv1xgTO/tHJ8MfO1RUDaM+/qoX8SYdm08I95RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gimpJ5iCSXhhTGocLKIV8TYNW/mUEWR9BeOUbc3ag34=;
 b=GhpszUtIi72qX7rqLmCmHoV4q9f1KaukcvcPzNQOzZr9g++mstr8v9o/BrHtZGeTXlCmtgFbriU/HHMrUWGOE3h93r1cmrXCLvdy+J4Kcrzf7EzsJa4fxwBnlK6c3iTf8BGykwInrYFoVNGu6d7dhtrsfl+4TJtRxFgakVk5saIUMWT0KWVfERmjn1qeEOCS5mtTf8naQHPOgIv64qqZLGtWCMsHGWNDAH5t4B9SBv4HJtZU22w9Y09kbMTvYMzihwH9LqDBLa45OXWPXckoZOVaVJE7S8UXFttNaml0x6eF+nJmPvqIHrP8KRggstlMQnY9lrcZ5bcYq5lNKv/grw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gimpJ5iCSXhhTGocLKIV8TYNW/mUEWR9BeOUbc3ag34=;
 b=oq9nWQN6idNqV7+F5L5xN1Z6HNclGemYIQ4XKEJG79pwSjwKoM0A8DpgMOEZg+EFHCCkdXqyZq59qa2ZgaaxvXOtYIyLjRXhKQqxFxCxal3pyE5ewQZZ7wHkHeBm8pE03wPrB76AzqiRWOfYfnsNrWST7GbXMlrtMa1pLmVxpHTMq7IK8Lr01WZa8eFgVWPxQmTpG2vp13t3ySZ0pz4DJ7+8s2udL68g+nUjLccR9TSS9AIKEWCg3ui5rex9pG1TRLyD9+yQg4lLuXjt1hwzky5hCeiHkwhkFLxegYcX11qSYNb5PiYMfy98T2tMEOpRLIcGkpzlxGk/CNRSQwku1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <c20b433f-97ef-7faa-5122-9949af41f2fb@kalrayinc.com>
Date: Mon, 15 Apr 2024 16:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v2 30/31] kvx: Add power controller driver
Content-Language: en-us
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
 Dobriyan <adobriyan@gmail.com>
Cc: Benjamin Mugnier <mugnier.benjamin@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-audit@redhat.com, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
References: <20230120141002.2442-1-ysionneau@kalray.eu>
 <20230120141002.2442-31-ysionneau@kalray.eu>
 <f69adaf2-6582-c134-5671-4d6fd100fcf1@linaro.org>
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <f69adaf2-6582-c134-5671-4d6fd100fcf1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0082.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::23) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PR0P264MB3722:EE_
X-MS-Office365-Filtering-Correlation-Id: 265d984c-25f1-4442-6436-08dc5d55906d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeLHO8rwWU20dJzkRgVoMZ1iZxskdt7Ph1yYZeG01H6INprEMwy4/RcJLcn+WKBFHGILW0UOhx+wUgcnrsIVqe0SMw0tOHm6w6sNKDuHXEnSjm8/Y01XJvskPzaVEuwozkis5CxZBVxVKtuV96zxY4nBpW4IQeGwY4z9JMkBzP9ju3VBI5bTgF3wexeT786067vrLkpTfR2hvklFh0RFgTALxiyYpikggwhwPEQOGbsd1y4vWALiouHHVbECgJBJYV79gXGJSAHtVzfxldE3xnH5nTS2wj0+dW166rim5bKA7fue/AtOwPgB6O9O1p53PXXkAWeSjdXg0fhIwzWAg8ExTZ6b1227ZRf7KpOogX0FWmN7GaWyrTfR4Yzvn/vt4Yi9RPvAI1Y072gwXWb4rSTISFut1WVdFqHfkTGTvEamAb21F4920EZPm2DHtPEZiedf4lBAgwQJRcs/XuMayDmntJA8/y60xx84eyYCq9l66tZ0r/cYU5gw7WwB0lTUfbgk31NBJnr6p/QOmqPJQhVQh4WZqd9rDdkRbRVWf0lEe02GuiAhn8rU265a4HtWZpmvUHKqn3GRR54tXCkndKY3zbIcWylpaM571jX8PsVqlHdb3oFI1F3+Xhyf3RS9cuUeckwL72xgQ2LOv/ZAfORr9bp7Wa4Rxj56B508kU3EDOm96g52Q0OKTdnLTMg95MFwbkqO5lY8mOz/hhWnUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e68+7lUOduU7bnAOj67E8vkEWqoi5qMU9yeL+gTSsqMIF6EKB1JGJkE5U+N+WYCWBIC500wlMa87jFQTg3vzAEPSuNHaH599q5DlIl2Eidszo1ybZ5111V07TcWaCV1cP3jASAB9a1cW6gm3hGerZ04Xl3c+qdKjYbaBldG1qbIKJag4qzWtPQXKn8KqSvy2hUM9h6O1xvCr7omGCChuTKmigynUosZvqGNNwdrHN45VnrWeD/wN1XmAt1+EKWo+CmZSliNweFGuRmCIkxWGihq5ASIZdbvKUvCerIvfVIlJZphN7UKr5FriXDF5G9JeqPwvJzeRI+BfQQ4Ne6rH4b/ddC6gtNC1F2PDCHPY1EktbOKZpGsKqxqeYtw8UlcsZjzvel5rrh/68/wNZJV7caeOgi22nhW7bqualMPC21aNpuZOVu8YCzIeFGJc87iBLHXiJEmNm3g8W8s94WHbVNC4EWrMumYEZCWb8zmoWiqphvShLhl9+wF+RwPyPhPZ6sPmJO8zqCJIaB1EAYKDpAzNQQquMqDSQmcB4kQ64m+jlyLMTUKMuuDShn0W3vRHDL3DEdZ5pUG+MxthnwpTVWFxhgKrdJLQBtuv7kwcF4+f3jSL+2R2Hdyb4RuJk/8kkP5eZGRcqUJxW/uAr6lX2v6rYTHcssCwMJpr0dYScz6kXDraumhkP1rN5UvqNsmtTGDPq6jzqf8105f2p9uZ4YEktvOStF1PDGeKY3VV8el83t8uzxjjwYEgGJ6fHd7DnfGSHk73bgagFXYL/1cG9ZDyWidXN3AjikJR6HDlJz0KbGtogxeEBEwCTRe+Rand2Andxhmsd+rrr4HcZpcrt3KOWB5wAkWSaw+trCiZeodfVtxnHg6m6m6CiQdO82d5Bc3ke3fvjIg5rZHpIK6BMKQydQzgcOHDTJ9mH1OAuMBSlbYK+7HMF6J1TH55Adgm
 C2pq2tMt5UnAIG5p3/ZwucBc6cKpUxXCunHipOqfNBa6XDEzElZD9G8MHpIdy90ZB8uAOJjyKuljAwdVaK7HFcqmZk9GUmJ5Fop7GqRMKkZHEF6hLOykcYzSAVAMstr7WvVTM2r/B9tvqSPMFV/qyOcV2rDzItnu3vsOwUeyymKRpLhwm+ya1jKMjs1i6o7sdQSL4iwfGUVH+iLBcwBf2Mx2oD0XsmP1QnPZbl13oM+IqqzDkOw8D5oOP2YlHqKtGJu4/OVkFeaMGdOnS6zQ66erxyNeD75cYZfCQCr4ZD3S0aO7wcpPTh03Go0w/0795ZDz0EA4FCQKNPC1e57u/auQqJP1GIak/kmUm3HcVch/KoQ9pH/F93QNx3nWBwzDCvbk3gsdbinq7FNRZeoHmRAkB2QFkRH09i2DwPzgJb4VelJpg27qDwzE039tYr73pVe7qziTIhB0ejsoIiL7zA1npsDkkDkV/PTWNJdHPz1F3ff8ub5AXRzIYtBobg4NBqgco0t8U56wJHy4u4PTWbvJe6DpKGMz7HaX4ZJZRj49DSJ/H+THJHeiGAs+jZN3PwAgKNqpaasJvbkFh0iZVwO7mGHDJGV+/KunRLsy9v5W3IHuFkpXJizTmxZxoFg/38CKqSnFo6RJCDhrZ5kKAA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265d984c-25f1-4442-6436-08dc5d55906d
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:08:45.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNyGqiDKv5kgsAA0JDcWbgoUGlhPezenqZLJt7PnGcaQmv/cq1ir5+VR8hccXeFhR1r8V7zG9Zjt4PFE09ZANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3722
X-ALTERMIMEV2_out: done

Hello Krzysztof, Arnd, all,

On 1/22/23 12:54, Krzysztof Kozlowski wrote:
> On 20/01/2023 15:10, Yann Sionneau wrote:
>> From: Jules Maselbas <jmaselbas@kalray.eu>
>>
>> The Power Controller (pwr-ctrl) control cores reset and wake-up
>> procedure.
>> +
>> +int __init kvx_pwr_ctrl_probe(void)
>> +{
>> +	struct device_node *ctrl;
>> +
>> +	ctrl = get_pwr_ctrl_node();
>> +	if (!ctrl) {
>> +		pr_err("Failed to get power controller node\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!of_device_is_compatible(ctrl, "kalray,kvx-pwr-ctrl")) {
>> +		pr_err("Failed to get power controller node\n");
> No. Drivers go to drivers, not to arch directory. This should be a
> proper driver instead of some fake stub doing its own driver matching.
> You need to rework this.

I am working on a v3 patchset, therefore I am working on a solution for 
this "pwr-ctrl" driver that needs to go somewhere else than arch/kvx/.

The purpose of this "driver" is just to expose a void 
kvx_pwr_ctrl_cpu_poweron(unsigned int cpu) function, used by 
kernel/smpboot.c function __cpu_up() in order to start secondary CPUs in 
SMP config.

Doing this, on our SoC, requires writing 3 registers in a memory-mapped 
device named "power controller".

I made some researches in drivers/ but I am not sure yet what's a good 
place that fits what our device is doing (booting secondary CPUs).

* drivers/power/reset seems to be for resetting the entire SoC

* drivers/power/supply seems to be to control power supplies ICs/periph.

* drivers/reset seems to be for device reset

* drivers/pmdomain maybe ?

* drivers/soc ?

* drivers/platform ?

* drivers/misc ?

What do you think?

Thanks.

Regards,

-- 

Yann






