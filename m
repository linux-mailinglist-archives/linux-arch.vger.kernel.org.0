Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DCB65719A
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 02:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiL1BgK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Dec 2022 20:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1BgJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Dec 2022 20:36:09 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66389C777;
        Tue, 27 Dec 2022 17:36:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C8B725C00B5;
        Tue, 27 Dec 2022 20:36:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 27 Dec 2022 20:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672191366; x=
        1672277766; bh=rGmjN/Zp6wsSXxFVU1GiemrfxEb1GghLPn/O3CM4LCI=; b=0
        tHnb8enKTn6h2VSCBz/zkz/xBrtkRlHfBqDZlKqezt/pHVAw6SmabtQObnR3VJXW
        gaqflSfRHL0ufdy6I9VFokpELuuKFi8SwcxwBjV8zAeziXlk4nhsOj8NJP41rmwr
        1n2dShlQCozuJMyqZqO4pwulSuTwZEExg41tm/1aIrjlXhSUfrSXX3xN5vp/pcBP
        pqczAgF2CMOVuIO7F/+XAvKbJysoA7IUtlQxCq6/8/DxzPyNbQk640axo0lUrdP/
        SB3BWgCjV3cfDImBjqZ2xcbCOsaroZG+T8PDIxwePfk/MMz9VLQLPbUdYh3+R0oX
        Z65jiP13IyAzAL0IEaegA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672191366; x=
        1672277766; bh=rGmjN/Zp6wsSXxFVU1GiemrfxEb1GghLPn/O3CM4LCI=; b=d
        TebGABsW4bWxo7t02h2arQyHHhOI9iuK9g9G81XKVemWjMSbi9ctY+q+nudZxTmD
        fQHLFGavekstDooNg+R0X55Q9c81H6hjwNR7IXzGwhg23TMbEnkXrWrFVS1FXWKf
        NkB5Q4UPuvIMtozahLntRU857XbgVsl65vTBWBAybTQ5DL5m1p0QF0bJ31w5iVaa
        KXrlbSYP+LzES7ddJ82sP9y2zKjQK+A4QGMV52VbF0BKlZvZ6OWqzJ3NDNN8chuA
        KSahD/xj4wwS37wjgREJYTsBdMPb0G8ki1KiYwwev6y1kC0qy86/GbnBUfquP/N3
        48cbOyONtyDoBmWF/BjQA==
X-ME-Sender: <xms:hp2rYxHd80icm3eGLczM_hq1nfa-IVazMlZnjWOLVvwQrSKzrTB0pw>
    <xme:hp2rY2WCFPqDKyvuMblRgsO1szVDnuip-ASBFPpc5DtJAJbYnrt_gzUpYNr2ZjonU
    0wtU6HrVVhcKkGeJQ>
X-ME-Received: <xmr:hp2rYzKbXqrGkg8OaMqrxEkqHPHvdCawSIsUeqWVW2zXR1hujT_Y0x80CCQL6pekDzdCwHZZmDSCOGJxAhTd-XnFQVnKRO91K511ONFnF8n2TOIzutN9J9slCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedugdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeejleelfeeitdfhtdfgkeeghedufeduueegffdvhfdukeelleef
    tdetjeehuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:hp2rY3Fssjzf8ZeS7qFPL8SOiE-AxvG1IQe01nwxXX4DoIfLx0p_mQ>
    <xmx:hp2rY3V21Vfo1X6ryFOVJLpjcoKidxuBKi6lpCQ73Vbfh4lgfk86OQ>
    <xmx:hp2rYyMqE1nSIsI44o_ID0ucQ2D5LxtJYQvmBs_C6fO1VZkoIc9USw>
    <xmx:hp2rYwOQihVNCRrZkc842rELvmv163HV0ue4oymSC9GcXcCraG6w0Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Dec 2022 20:36:04 -0500 (EST)
Message-ID: <8f82ddb6-cd3a-c7f7-5a20-427403d8600c@sholland.org>
Date:   Tue, 27 Dec 2022 19:36:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3] riscv: Use PUD/P4D/PGD pages for the linear mapping
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
References: <20221213060204.27286-1-alexghiti@rivosinc.com>
 <Y6TmYjr07W9WJEPn@spud>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <Y6TmYjr07W9WJEPn@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/22/22 17:21, Conor Dooley wrote:
> On Tue, Dec 13, 2022 at 07:02:04AM +0100, Alexandre Ghiti wrote:
>> During the early page table creation, we used to set the mapping for
>> PAGE_OFFSET to the kernel load address: but the kernel load address is
>> always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
>> pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
>> PAGE_OFFSET is).
>>
>> But actually we don't have to establish this mapping (ie set va_pa_offset)
>> that early in the boot process because:
>>
>> - first, setup_vm installs a temporary kernel mapping and among other
>>   things, discovers the system memory,
>> - then, setup_vm_final creates the final kernel mapping and takes
>>   advantage of the discovered system memory to create the linear
>>   mapping.
>>
>> During the first phase, we don't know the start of the system memory and
>> then until the second phase is finished, we can't use the linear mapping at
>> all and phys_to_virt/virt_to_phys translations must not be used because it
>> would result in a different translation from the 'real' one once the final
>> mapping is installed.
>>
>> So here we simply delay the initialization of va_pa_offset to after the
>> system memory discovery. But to make sure noone uses the linear mapping
>> before, we add some guard in the DEBUG_VIRTUAL config.
>>
>> Finally we can use PUD/P4D/PGD hugepages when possible, which will result
>> in a better TLB utilization.
>>
>> Note that we rely on the firmware to protect itself using PMP.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>
>> v3:
>> - Change the comment about initrd_start VA conversion so that it fits
>>   ARM64 and RISCV64 (and others in the future if needed), as suggested
>>   by Rob
>>
>> v2:
>> - Add a comment on why RISCV64 does not need to set initrd_start/end that
>>   early in the boot process, as asked by Rob
>>
>> Note that this patch is rebased on top of:
>> [PATCH v1 1/1] riscv: mm: call best_map_size many times during linear-mapping
> 
> Hey Alex, unfortunately I could not get this to apply either (I tried a
> riscv/for-next & Linus' tree).
> The above patch should be in both, so idk:
> git am -3 v3_20221213_alexghiti_riscv_use_pud_p4d_pgd_pages_for_the_linear_mapping.mbx
> Applying: riscv: Use PUD/P4D/PGD pages for the linear mapping
> error: sha1 information is lacking or useless (arch/riscv/mm/init.c).
> error: could not build fake ancestor
> Patch failed at 0001 riscv: Use PUD/P4D/PGD pages for the linear mapping

That's because my CONFIG_DEBUG_VIRTUAL fix got applied first. This patch
applies cleanly after:

	git revert -m1 61b2f0bdaa3c7e6956fdac0a7c1e8284b9b81d1d

though you'll get one trivial conflict if you try to undo the revert.

Regards,
Samuel

