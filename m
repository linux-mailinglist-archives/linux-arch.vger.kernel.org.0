Return-Path: <linux-arch+bounces-277-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E47F0A24
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 01:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C78280C1D
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 00:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4F627;
	Mon, 20 Nov 2023 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C222A4;
	Sun, 19 Nov 2023 16:39:32 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SYT825Wf9zsRGy;
	Mon, 20 Nov 2023 08:36:02 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 Nov 2023 08:39:28 +0800
Message-ID: <c441db4c-1851-4b09-a344-377a1684e9b5@huawei.com>
Date: Mon, 20 Nov 2023 08:39:27 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] asm/io: remove unnecessary xlate_dev_mem_ptr() and
 unxlate_dev_mem_ptr()
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
	<linux-alpha@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-hexagon@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, Richard Henderson
	<richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <linux@armlinux.org.uk>, Brian Cain <bcain@quicinc.com>, "James
 E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
	"David S. Miller" <davem@davemloft.net>, Stanislav Kinsburskii
	<stanislav.kinsburskii@gmail.com>
References: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
 <CAMuHMdU+MMiogx6TcBwxFL7AODZYhiAZpVHiafEBfnRsDaXTog@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMuHMdU+MMiogx6TcBwxFL7AODZYhiAZpVHiafEBfnRsDaXTog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected



On 2023/11/20 3:34, Geert Uytterhoeven wrote:
> On Sat, Nov 18, 2023 at 11:09 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> The asm-generic/io.h already has default definition, remove unnecessary
>> arch's defination.
>>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Brian Cain <bcain@quicinc.com>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
>>   arch/m68k/include/asm/io_mm.h  | 6 ------
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
>>   arch/sh/include/asm/io.h       | 7 -------
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>


Thanks,
> 
>> --- a/arch/mips/include/asm/io.h
>> +++ b/arch/mips/include/asm/io.h
>> @@ -548,13 +548,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
>>   #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
>>   #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
>>
>> -/*
>> - * Convert a physical pointer to a virtual kernel pointer for /dev/mem
>> - * access
>> - */
>> -#define xlate_dev_mem_ptr(p)   __va(p)
>> -#define unxlate_dev_mem_ptr(p, v) do { } while (0)
>> -
>>   void __ioread64_copy(void *to, const void __iomem *from, size_t count);
> 
> Missing #include <asm-generic/io.h>, according to the build bot report.

Will check the bot report.

> 
>>   #endif /* _ASM_IO_H */
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

