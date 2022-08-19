Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418D4599223
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 02:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbiHSA7f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 20:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344537AbiHSA7e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 20:59:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BA68DF643;
        Thu, 18 Aug 2022 17:59:32 -0700 (PDT)
Received: from [10.20.42.22] (unknown [10.20.42.22])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx5OFh4P5ia0AEAA--.22140S3;
        Fri, 19 Aug 2022 08:59:13 +0800 (CST)
Subject: Re: [PATCH V2 1/2] LoongArch: Add CPU HWMon platform driver
To:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-acpi@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220818042208.2896457-1-chenhuacai@loongson.cn>
 <98d716a4-04de-ff32-1bbc-cac576989a87@loongson.cn>
 <ce96bcc9bf0aa24d1be5a91d07e6e7515c4d0c33.camel@xry111.site>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <5d338fcd-d225-6fe1-1b94-0fce94a3fb0f@loongson.cn>
Date:   Fri, 19 Aug 2022 08:59:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ce96bcc9bf0aa24d1be5a91d07e6e7515c4d0c33.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx5OFh4P5ia0AEAA--.22140S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtry5AFy5tr1xWFWfuF48JFb_yoW3Zrg_u3
        4xWrn7uw40krWFgan7tFW8CwnrG3yqgF1UZF4Fya4avryrXanrCr1rGw1qvFW7trWkKr93
        Zry5Ar4fZw1avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbfxYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
        kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr
        1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
        Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
        IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
        6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07beAp5UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2022/8/18 下午6:08, Xi Ruoyao wrote:
> On Thu, 2022-08-18 at 15:08 +0800, Jianmin Lv wrote:
>> I don't think we need the driver any more, we have thermal zone based
>> acpi which implemented more functions include the function here.
>>
>> And, the driver will conflict with acpi thermal
>> driver(drivers/acpi/thermal.c), which leads to confusion with users.
> 
> Hmm... I reverted this in my local tree then the CPU temperature
> disappeared from /sys/class/hwmon.  I have CONFIG_ACPI_THERMAL=y.  Am I
> doing something wrong or we need to wait for a firmware update for the
> ACPI thermal zone device?
> 

Maybe your firmware does not config TZ, you can confirm that by checking
DSDT as following:

cp /sys/firmware/acpi/tables/DSDT ./
iasl DSDT

and in produced DSDT.asl, check if TZ is in it.


> 

