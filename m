Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07A368D949
	for <lists+linux-arch@lfdr.de>; Tue,  7 Feb 2023 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjBGN2q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Feb 2023 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjBGN2p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2023 08:28:45 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F081E21942;
        Tue,  7 Feb 2023 05:28:43 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.155])
        by gateway (Coremail) with SMTP id _____8Dxh+kKUuJjy4oPAA--.25697S3;
        Tue, 07 Feb 2023 21:28:42 +0800 (CST)
Received: from [10.20.42.155] (unknown [10.20.42.155])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxjb4JUuJjVXQrAA--.21977S3;
        Tue, 07 Feb 2023 21:28:41 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Make -mstrict-align be configurable
To:     Arnd Bergmann <arnd@arndb.de>, WANG Xuerui <kernel@xen0n.name>,
        David Laight <David.Laight@ACULAB.COM>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230202084238.2408516-1-chenhuacai@loongson.cn>
 <363cd09a5dcb4deab21f58c19025254f@AcuMS.aculab.com>
 <CAAhV-H7Mz1Z5Bo59tq5VRSUx-N39axeiG7xZs2Szn6nuOxgZfQ@mail.gmail.com>
 <9936da8f577842b8b5edafcdc69dc2d1@AcuMS.aculab.com>
 <560d73a8-2f2a-4844-44ff-afffad9c8694@loongson.cn>
 <379bcb55-f75d-02ce-a51b-467e21ade5a3@xen0n.name>
 <dcd17646-4b8d-447b-bd85-c66c4a7b2cf4@app.fastmail.com>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <924aa802-410d-a85c-b623-7ca30d15c637@loongson.cn>
Date:   Tue, 7 Feb 2023 21:28:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dcd17646-4b8d-447b-bd85-c66c4a7b2cf4@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxjb4JUuJjVXQrAA--.21977S3
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrtF15Xry8KF15uFWUtF4kCrg_yoW3WrX_ZF
        93G34fu34kAayxWwsFqa98CrySqr12k3yUAF48Xw4aq3W7JFZ3ursxXr4avryDKayIqrZ3
        AFW5Gr1xC3s2yjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        A7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU8X_-PUUUUU==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2023/2/7 下午6:32, Arnd Bergmann wrote:
> I agree the default should always be to have a kernel that works on
> every machine that has been produced, but this also depends on which
> models specifically lack the unaligned access. If it's just about
> pre-production silicon that is now all but scrapped, things are different
> from a situation where users may actually use them for normal workloads.
> 
> Is there an overview of the available loongarch CPU cores that have
> been produced so far, and which ones support unaligned access?

So far, produced CPUs based LoongArch include 3A5000, 3B5000, 3C5000L, 
3C5000, 2K2000, 2K1000LA and 2K0500, where 2K1000LA and 2K0500 are 
unaligned-access-unsupported, and others are unaligned-access-supported.

