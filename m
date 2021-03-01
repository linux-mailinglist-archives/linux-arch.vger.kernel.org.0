Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC9327980
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 09:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhCAInt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 03:43:49 -0500
Received: from mail.loongson.cn ([114.242.206.163]:41948 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233266AbhCAIns (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 03:43:48 -0500
Received: from [10.130.0.55] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxXewFqTxgvU0SAA--.6453S3;
        Mon, 01 Mar 2021 16:42:47 +0800 (CST)
Subject: Re: [PATCH] MIPS: loongson64: alloc pglist_data at run time
To:     Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
References: <20210227062957.269156-1-huangpei@loongson.cn>
Cc:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <a80f5a8f-972a-08f6-f8e3-032ca5ef321a@loongson.cn>
Date:   Mon, 1 Mar 2021 16:42:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20210227062957.269156-1-huangpei@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9BxXewFqTxgvU0SAA--.6453S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF48Ar15Wr15WFy3WFW3KFg_yoWrXry3pr
        yUGr1Fkr48Gr1xWayxArW3ur1xAwsYkF17JFW7Cr1UZayqgr17tr4UKF1Y9as8tr48XF12
        qF1kXr1j9w4DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI4
        8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
        wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
        v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
        Y4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe2NtDUUUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/27/2021 02:29 PM, Huang Pei wrote:

> It can make some metadata of MM, like pglist_data and zone
> NUMA-aware
>
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>   arch/mips/loongson64/numa.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> index cf9459f79f9b..5912b2e7b10c 100644
> --- a/arch/mips/loongson64/numa.c
> +++ b/arch/mips/loongson64/numa.c
> @@ -26,7 +26,6 @@
>   #include <asm/wbflush.h>
>   #include <boot_param.h>
>   
> -static struct pglist_data prealloc__node_data[MAX_NUMNODES];
>   unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
>   EXPORT_SYMBOL(__node_distances);
>   struct pglist_data *__node_data[MAX_NUMNODES];
> @@ -151,8 +150,12 @@ static void __init szmem(unsigned int node)
>   
>   static void __init node_mem_init(unsigned int node)
>   {
> +	struct pglist_data *nd;
>   	unsigned long node_addrspace_offset;
>   	unsigned long start_pfn, end_pfn;
> +	unsigned long nd_pa;
> +	int tnid;
> +	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
>   
>   	node_addrspace_offset = nid_to_addrbase(node);
>   	pr_info("Node%d's addrspace_offset is 0x%lx\n",
> @@ -162,8 +165,16 @@ static void __init node_mem_init(unsigned int node)
>   	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx\n",
>   		node, start_pfn, end_pfn);
>   
> -	__node_data[node] = prealloc__node_data + node;
> -
> +	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, node);
[...]

Hi, all,

Few related to this patch. About memblock, I have a question.

In my own understanding, 3 stages at previous part of arch_mem_init().

stage1: Add memory to memblock.memory at plat_mem_setup().
stage2: parse_early_param() parses parameter about memroy, such as "mem" 
"memmap".
         check_kernel_sections_mem() checks whether the current 
memblock.memory contains the kernel.
         At this stage, user can defined memblock.memory by themselves. 
Also it is the final stage of determining memblock.memory.
stage3: others. use memblock.memory and add them to memblock.reserve.

Calling to memblock_alloc*() should be after the reserve kernel(), see:
     memblock_set_current_limit(PFN_PHYS(max_low_pfn))

(
Here few about this patch: It works no problem, memblock_dump shows:
[    0.000000]  memory.cnt  = 0x2
[    0.000000]  memory[0x0] [0x0000000000200000-0x000000000effffff], 
0x000000000ee00000 bytes on node 0 flags: 0x0
[    0.000000]  memory[0x1] [0x0000000090200000-0x000000025fffffff], 
0x00000001cfe00000 bytes on node 0 flags: 0x0
[    0.000000]  reserved.cnt  = 0x3
[    0.000000]  reserved[0x0] [0x0000000000200000-0x0000000001ed7fff], 
0x0000000001cd8000 bytes flags: 0x0
[    0.000000]  reserved[0x1] [0x00000000fe000000-0x00000000ffffffff], 
0x0000000002000000 bytes flags: 0x0
--->>> [    0.000000]  reserved[0x2] 
[0x000000025fffd6c0-0x000000025fffffff], 0x0000000000002940 bytes flags: 
0x0  <<<---
memblock.bottom_up is not enabled here, and it is not destroy kernel, 
although looks strange.
)

Morever, about "mem" parameter.

When parsing the mem parameter for the first time, all memblock.memory 
is removed.
For NUMA, memblock.memory contain important node information. These 
information are
imported at plat_mem_setup(). Without these node information, the NUMA 
platform
may not be able to use memory correctly.

The mem parameter is rarely used, but it has meaning. For example, 
kdump. I have
done some fixes before, but it looks fool.

Huacai suggested me that use pa_to_nid().

memblock_add(start, size) -> memblock_add_node(start, size, 
pa_to_nid(start))

I think this is a good way. Does anyone have other suggestions?

At last, should the NUMA platform reserve the kernel area after parse 
"mem" rather than before it?

Thanks,
Jinyang

