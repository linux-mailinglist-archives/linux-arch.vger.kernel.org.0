Return-Path: <linux-arch+bounces-9581-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A555CA01347
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 09:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7800116356F
	for <lists+linux-arch@lfdr.de>; Sat,  4 Jan 2025 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997721534FB;
	Sat,  4 Jan 2025 08:27:55 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C8113AD03;
	Sat,  4 Jan 2025 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735979275; cv=none; b=hp+1u5gLvgxMRC4lilG35by1Ep2v6Y/T/nCBjp+fKMkcTEF2TQyhGfn387bAzU1I3Q47IFxjkCKoqOAiyvplrCdlyS9doEdY9wjTUiJv0DZJuOLjHP95ai6j69vBbwrZiZWxQU98o1By3LwCZ1S2cwPIgrwNhc1Fu/oECoIpO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735979275; c=relaxed/simple;
	bh=wMoy6apQo5bZZiSMcB0HeLwxkmRBasscYmByAMRQg9I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TD5xEjpUMFENHSHJiHvf8lOTD36RMGuIGNIDwnsJZCIlmDJcg0uTkjVPEY29iijPnfPcaISNmkBEcGcebvyYAyvmmMxRHTJ09gZwAXJSt33+tWvEaEmFJPi1yQpBgWdKpt7jIcbmeD0laHkRjIoiNvgNNZLrWBK5x+1kep7Sfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.80.44.60])
	by gateway (Coremail) with SMTP id _____8CxPuMF8Xhn4+ddAA--.52538S3;
	Sat, 04 Jan 2025 16:27:49 +0800 (CST)
Received: from [10.80.44.60] (unknown [10.80.44.60])
	by front1 (Coremail) with SMTP id qMiowMAxz8cB8Xhn94wTAA--.11083S2;
	Sat, 04 Jan 2025 16:27:45 +0800 (CST)
Message-ID: <23c2a5b5-397e-4d90-b05a-143493063f00@loongson.cn>
Date: Sat, 4 Jan 2025 16:27:45 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jinyang Shen <shenjinyang@loongson.cn>
Subject: Re: [PATCH 0/3] LoongArch: initial 32-bit UAPI
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
Content-Language: en-US
In-Reply-To: <20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMAxz8cB8Xhn94wTAA--.11083S2
X-CM-SenderInfo: hvkh0yplq1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw4rCw43Cr1ruFykGFWrCrX_yoWrWr4kpa
	1kur93Gr4xGryxAr43tw4Fgrn8Jw4fG3W2qa1SkryUCFsrZFyUur4xKFWkXF17uw4furW0
	qF18u34UW3W8AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17
	MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
	AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0
	cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
	yTuYvjxUc0eHDUUUU



On 2025/1/3 02:34, Jiaxun Yang wrote:
> This series defines the UAPI for LoongArch32, marking my initial step
> towards upstreaming support for the architecture. Once the UAPI is
> ratified, we can proceed to scrutinise various kernel components to
> enable 32-bit support while simultaneously addressing user-space porting.
> 
> Why am I upstreaming LoongArch32?
> ================================
> Although 32-bit systems are experiencing declining adoption in general
> computing, LoongArch32 remains highly relevant within specific niches.
> Beyond embedded applications, several vendors are actively developing
> application-level LoongArch32 processors. Loongson, for example, has
> released two open-source reference hardware implementations: openLA500
> and openLA1000 [6].
> 
> The architecture also holds considerable educational value, having been
> integrated into China's national computer architecture curricula and
> embedded systems courses. Additionally, the National Student Computer
> System Capability Challenge (NSCSCC) [1] features LoongArch32 CPUs, where
> hundreds of students design Linux-capable hardware implementations and
> compete on performance. This initiative has resulted in several exciting
> high-performance LoongArch32 cores, including LainCore[2], Wired[3],
> NOP-Core[4], NagiCore[5]....
> 
>>From an upstream perspective, we will largely reuse the infrastructure
> already established for LoongArch64, ensuring that the maintenance burden
> remains minimal.
> 
> Porting Status
> ==============
> The LoongArch32 port has been available downstream for some time, with
> various system components hosted on Loongson's Gitee[6]. However, these
> components utilise an older downstream ABI and fall short of upstream
> quality.
> 
> On the upstream front, LLVM-19 now includes experimental support for
> LoongArch32 (ILP32 ABI) under the loongarch32* triple, and efforts are
> underway to enable GNU toolchain support. My upstream-ready kernel port
> and musl libc port can successfully boot into a minimal Buildroot
> environment and execute test cases on QEMU virt machine with clang
> toolchain.
> 
> Thank you for reading. I look forward to your comments and feedback.
> 
> [1]: https://www.tsinghua.edu.cn/en/info/1245/13802.htm
> [2]: https://github.com/LainChip/LainCore
> [3]: https://github.com/gmlayer0/wired
> [4]: https://github.com/NOP-Processor/NOP-Core
> [5]: https://github.com/MrAMS/NagiCore
> [6]: https://gitee.com/loongson-edu
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (3):
>        loongarch: Wire up 32 bit syscalls
>        loongarch: Introduce sys_loongarch_flush_icache syscall
>        loongarch: vdso: Introduce __vdso_flush_icache function
> 
>   arch/loongarch/include/asm/Kbuild          |  1 +
>   arch/loongarch/include/asm/cacheflush.h    |  6 ++++
>   arch/loongarch/include/asm/syscall.h       |  2 ++
>   arch/loongarch/include/asm/vdso/vdso.h     | 10 ++++++
>   arch/loongarch/include/asm/vdso/vsyscall.h |  1 +
>   arch/loongarch/include/uapi/asm/Kbuild     |  1 +
>   arch/loongarch/include/uapi/asm/unistd.h   |  6 ++++
>   arch/loongarch/kernel/Makefile.syscalls    |  3 +-
>   arch/loongarch/kernel/syscall.c            | 49 +++++++++++++++++++++++++++++
>   arch/loongarch/kernel/vdso.c               |  2 ++
>   arch/loongarch/mm/cache.c                  |  3 ++
>   arch/loongarch/vdso/Makefile               |  2 +-
>   arch/loongarch/vdso/flush_icache.c         | 50 ++++++++++++++++++++++++++++++
>   arch/loongarch/vdso/vdso.lds.S             |  5 +++
>   scripts/syscall.tbl                        |  2 ++
>   15 files changed, 140 insertions(+), 3 deletions(-)
> ---
> base-commit: 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2
> change-id: 20250102-la32-uapi-8395e83a4e88
> 
> Best regards,

Hi, Jiaxun,

Thank you for your hard work, I'm also working on LoongArch32 kernel 
side [1], I hope we can make it upstream together.

[1]: https://github.com/shenjinyang/la32r-Linux

Jinyang


