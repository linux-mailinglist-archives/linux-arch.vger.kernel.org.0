Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B78B620AA6
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 08:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiKHHqn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 02:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiKHHqg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 02:46:36 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACEFC10;
        Mon,  7 Nov 2022 23:46:35 -0800 (PST)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N60Xf0YP6zRp63;
        Tue,  8 Nov 2022 15:46:26 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 15:46:33 +0800
Message-ID: <b714ad78-4689-ad0b-9316-efcc1665f6bf@huawei.com>
Date:   Tue, 8 Nov 2022 15:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: vmlinux.lds.h: Bug report: unable to handle page fault when start
 the virtual machine with qemu
To:     Ard Biesheuvel <ardb@kernel.org>
References: <cbbd3548-880c-d2ca-1b67-5bb93b291d5f@huawei.com>
 <CAMj1kXESRP9RvhPC5Wgg38BqyCn5ANv7+X9Ezyx5MXNNvEZ1kA@mail.gmail.com>
From:   xiafukun <xiafukun@huawei.com>
CC:     <arnd@arndb.de>, <keescook@chromium.org>, <nathan@kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <zhaowenhui8@huawei.com>
In-Reply-To: <CAMj1kXESRP9RvhPC5Wgg38BqyCn5ANv7+X9Ezyx5MXNNvEZ1kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thank you for your reply.
We tested your changes to this patch and did fix the issue. Following the
solution you provided, we recompile the kernel and successfully start the
virtual machine.

在 2022/11/8 0:00, Ard Biesheuvel 写道:
> 
> That patch looks incorrect to me. Without CONFIG_SMP, the PERCPU
> sections are not instantiated, and the only copy of those variables is
> created in the ordinary .data/.bss sections
> 
> Does the change below fix the issue for you?
> 
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -347,6 +347,7 @@
>  #define DATA_DATA                                                      \
>         *(.xiptext)                                                     \
>         *(DATA_MAIN)                                                    \
> +       *(.data..decrypted)                                             \
>         *(.ref.data)                                                    \
>         *(.data..shared_aligned) /* percpu related */                   \
>         MEM_KEEP(init.data*)                                            \
> @@ -995,7 +996,6 @@
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  #define PERCPU_DECRYPTED_SECTION                                       \
>         . = ALIGN(PAGE_SIZE);                                           \
> -       *(.data..decrypted)                                             \
>         *(.data..percpu..decrypted)                                     \
>         . = ALIGN(PAGE_SIZE);
>  #else
