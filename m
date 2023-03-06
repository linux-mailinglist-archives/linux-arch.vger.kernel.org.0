Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393746AB4FD
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 04:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjCFDPu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 22:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFDPt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 22:15:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB5E11670;
        Sun,  5 Mar 2023 19:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=z90/4JGdbEKqrGeZRYhIg9Sanb/fEMmQopDvi9/WFeo=; b=ztwVpACRtiWxy3GWpmfjTbVFaP
        SOVIudq0nIen+nAbYIuwUdO1AO5EazFCKO/IIbYG3gKFJbG7eOdR4Cz5q7raeJZgQzW7vkzNS/Fba
        i60RFMLtc86g1pRL78NZjQ7iq3sksxabj7Hj3BWM6hcE1E/ZiAug2E5L4kcwP9wWf8OJEjtrxjerD
        23ssZB+0/oWS1j9PK39/W05H2vPsa9F1Y+4Qe0tRWd6FVg13z8aT7dxHqaqKLysbc7dwBVWR62uAm
        MZ0rD8H/kjM2nvLEMtmQlzpPheEGM/IDWVtOtNHWeunn8W+1QnZa2xG/vh6zHrhvGH2x2/UnTJbgl
        xNfyMzvg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZ1K7-00B6c0-PX; Mon, 06 Mar 2023 03:15:39 +0000
Message-ID: <984b486f-0613-6adc-4e87-5fc00560498f@infradead.org>
Date:   Sun, 5 Mar 2023 19:15:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2] LoongArch: Provide kernel fpu functions
Content-Language: en-US
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
References: <20230306031258.99230-1-chenhuacai@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230306031258.99230-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,


On 3/5/23 19:12, Huacai Chen wrote:
> +void kernel_fpu_begin(void)
> +{
> +	if(this_cpu_read(in_kernel_fpu))

	if (
> +		return;
> +
> +	preempt_disable();
> +	this_cpu_write(in_kernel_fpu, true);
> +
> +	if (!is_fpu_owner())
> +		enable_fpu();
> +	else
> +		_save_fp(&current->thread.fpu);
> +}
> +EXPORT_SYMBOL(kernel_fpu_begin);
> +
> +void kernel_fpu_end(void)
> +{
> +	if(!this_cpu_read(in_kernel_fpu))

	if (

i.e., add a space after "if".

> +		return;
> +
> +	if (!is_fpu_owner())
> +		disable_fpu();
> +	else
> +		_restore_fp(&current->thread.fpu);
> +
> +	this_cpu_write(in_kernel_fpu, false);
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(kernel_fpu_end);

-- 
~Randy
