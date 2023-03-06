Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A121E6ABF57
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 13:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCFMUq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 07:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCFMUp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 07:20:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1267A2886A;
        Mon,  6 Mar 2023 04:20:43 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8AxYcya2gVkt84IAA--.11074S3;
        Mon, 06 Mar 2023 20:20:42 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxg+WZ2gVkG5VMAA--.34350S3;
        Mon, 06 Mar 2023 20:20:41 +0800 (CST)
Message-ID: <05e692e4-8065-c962-ce5b-d3348fd8574f@loongson.cn>
Date:   Mon, 6 Mar 2023 20:20:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V3] LoongArch: Provide kernel fpu functions
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230306095934.609589-1-chenhuacai@loongson.cn>
 <029a5993-b993-ab73-0a14-0df9b0ddf3da@loongson.cn>
 <95273478173af301f3b63b9be2559213e4f29fb8.camel@xry111.site>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <95273478173af301f3b63b9be2559213e4f29fb8.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxg+WZ2gVkG5VMAA--.34350S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrKFWrXFW5Aw15KF4xXF43Wrg_yoWxAFX_ur
        yDurs3C347AryIq3yDAw4fZayfKayDJry0y340grW3Zw4UZFWDGFs5Xas3J3ZrXayrua9a
        93yjgrsakF4jkjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO
        87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
        67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
        AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



在 2023/3/6 20:09, Xi Ruoyao 写道:
> On Mon, 2023-03-06 at 20:03 +0800, maobibo wrote:
>> 在 2023/3/6 17:59, Huacai Chen 写道:
>>> Provide kernel_fpu_begin()/kernel_fpu_end() to allow the kernel itself
>>> to use fpu. They can be used by some other kernel components, e.g., the
>>> AMDGPU graphic driver for DCN.
>> Since kernel is compiled with -msoft-float, I guess hw fpu will not be
>> used in kernel by present:). However it is deserved to try.
> 
> See the draft AMD DCN support patch:
> https://github.com/loongson/linux/commit/0ee299095c963938a7626c3121a8feef32251301
Got it, thanks for pointing it out, good job:)

Regards
Bibo,Mao
> 

