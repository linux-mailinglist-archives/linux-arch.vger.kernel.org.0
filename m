Return-Path: <linux-arch+bounces-4414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF448C63AE
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 11:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C57B228F2
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B28B59162;
	Wed, 15 May 2024 09:30:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCE85914D;
	Wed, 15 May 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765432; cv=none; b=fLBwk56va6Nxon+SsyaZQleqO6Lxs26MjFO1cCa53Z1K89kGi3T2A+XGBHPuf7844EU+T61uPBkFBPIf47S2i1K5/8i9JEpUJFHlPSCiGgIbIsWuyLAeX3dIktISGLx/SjESK3CIeUzj69KG9CNk3D7ua7woyh0INdH0q4fPtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765432; c=relaxed/simple;
	bh=U4sqkEy7jQH3kzXAo6QyI7bYMwu7KBPvs6VnC9+VuxY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TmGAuMyJYR+IEWXh6HIH4KEPfBO0LnV63o7ucFc1UPjACveKZdoDjiA3OR8xq0qyM5HearSO6uNQFPTZsWkja2Mj5o6GLC5x/01lJwCvjFR5gzYUupbYm7Btnorv4CbRdsIlEMiR7cYRM4ZNztcMDiL5unS35LSUmNJubOc+CsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8AxJ+mxgERmjgMNAA--.18817S3;
	Wed, 15 May 2024 17:30:25 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx3VStgERmmqYgAA--.20S3;
	Wed, 15 May 2024 17:30:23 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
To: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 Xuefeng Li <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
 stable@vger.kernel.org
References: <20240511100157.2334539-1-chenhuacai@loongson.cn>
 <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <3937d6b1-119b-195e-8b9b-314a0bfbeaeb@loongson.cn>
Date: Wed, 15 May 2024 17:30:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f92e23be-3f3f-4bc6-8711-3bcf6beb7fa2@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx3VStgERmmqYgAA--.20S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWUuF4UXFyftr4fJrW5urX_yoW8ZrW7pF
	WSya43uF4kGry7Aw17uw1jqrs5AF18GF43XF1SgryxCay3Jr4Iyr10qrWIgasFkFyxZF4j
	vF4jkFn8Za98Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUU
	UUU



On 2024/5/11 下午8:17, Arnd Bergmann wrote:
> On Sat, May 11, 2024, at 12:01, Huacai Chen wrote:
>> Chromium sandbox apparently wants to deny statx [1] so it could properly
>> inspect arguments after the sandboxed process later falls back to fstat.
>> Because there's currently not a "fd-only" version of statx, so that the
>> sandbox has no way to ensure the path argument is empty without being
>> able to peek into the sandboxed process's memory. For architectures able
>> to do newfstatat though, glibc falls back to newfstatat after getting
>> -ENOSYS for statx, then the respective SIGSYS handler [2] takes care of
>> inspecting the path argument, transforming allowed newfstatat's into
>> fstat instead which is allowed and has the same type of return value.
>>
>> But, as LoongArch is the first architecture to not have fstat nor
>> newfstatat, the LoongArch glibc does not attempt falling back at all
>> when it gets -ENOSYS for statx -- and you see the problem there!
> 
> My main objection here is that this is inconsistent with 32-bit
> architectures: we normally have newfstatat() on 64-bit
> architectures but fstatat64() on 32-bit ones. While loongarch64
> is the first 64-bit one that is missing newfstatat(), we have
> riscv32 already without fstatat64().
> 
> Importantly, we can't just add fstatat64() on riscv32 because
> there is no time64 version for it other than statx(), and I don't
> want the architectures to diverge more than necessary.
yes, I agree. Normally there is newfstatat() on 64-bit architectures but 
fstatat64() on 32-bit ones.

I do not understand why fstatat64() can be added for riscv32 still.
32bit timestamp seems works well for the present, it is valid until
(0x1UL << 32) / 365 / 24 / 3600 + 1970 == 2106 year. Year 2106 should
be enough for 32bit system.

Regards
Bibo Mao


> I would not mind adding a variant of statx() that works for
> both riscv32 and loongarch64 though, if it gets added to all
> architectures.
> 
>        Arnd
> 


