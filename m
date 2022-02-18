Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADF94BB6B8
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 11:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiBRKSY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 05:18:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiBRKSX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 05:18:23 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C65A15C9F8;
        Fri, 18 Feb 2022 02:18:07 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id n24so3541326ljj.10;
        Fri, 18 Feb 2022 02:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ZwRbT+1qqEejXkPLNRT0P8U1UfOqBbbk2S+jBiDX7w=;
        b=HwIPNQm6bvP1qyt1DqVyrK6i1IxYBe3pF4kvKD1l9aL3skpcmD5TAiFiTR6vJgOz7B
         t0z9AUGb6zG6pfmU+9BHmWZjjYP8p3JYLtLTfoKdh3BnjyAxS8kyH7aEYnXi01jFZIzF
         573soHdCsmr3/P5ZM1x4mLpZvC48QquGUZEsW8SQQoM18/kWlPpgaxZHrqDS4b16t7Hk
         CPrKR07D3pDZ+6DpMa26njx9Ou6mX/WqALsfbj1Nd6drypXMoKGnpqS7eLYJp4gC/zQZ
         HSj8/Kstfvi7dLE4U0H5uDSTCcko9eMQl/aHEl20oLYR3YeK8yM1gI0YoPwa5+wSkB+m
         kvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ZwRbT+1qqEejXkPLNRT0P8U1UfOqBbbk2S+jBiDX7w=;
        b=Rrff1ppEKFr5n76ER/Jmq2+22XhwZvXYSYmBlwxXoG+yztqBwi8r9DeaOAYGdeBo6O
         SXdQoBsjvoEAWcyO2qRLdawDdUaGoJ736q6Dae+BUOWiPRx2BE7cz0HpeEstQV3fw8/H
         aH3KusAIpMcqxqSlYgJ0U2tGDT8O2UXUVHUrkL4jIB2mFc17/8n40CGiZC11R3NGlz49
         ehqQl5PPyVqvsdKx7zE5b/RB4ieSGiatmpvxvrvz8+u3TRf37TnRMdOR0R7X1EAg7QPn
         QPYpAG0K92Q9TajtIwLbTQS807LlHB+7hngoc0Q/W4tOya2FP5jKW9GTb5FrmPyrNYnQ
         RVuQ==
X-Gm-Message-State: AOAM53355PCix2gDEzs9ALsM6AFmDr8DPvWXfvz95Xqbhxmr5uXV9bVm
        5i1nZY2h1VKu8NlZP/8D4oI=
X-Google-Smtp-Source: ABdhPJzoG5dWVDHzQOQKtFLm+HFsVZSdj/YZ6lPLZtzc83WeDz9kMHzkcgdFaN0a4Fhn9IjcgX1EIQ==
X-Received: by 2002:a05:651c:1594:b0:244:d406:5224 with SMTP id h20-20020a05651c159400b00244d4065224mr5639426ljq.130.1645179485463;
        Fri, 18 Feb 2022 02:18:05 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id k18sm207268lfg.217.2022.02.18.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 02:18:04 -0800 (PST)
Date:   Fri, 18 Feb 2022 13:18:03 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v2 18/18] uaccess: drop maining CONFIG_SET_FS users
Message-ID: <Yg9yWxqD4RO7jI2g@curiosity>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <20220216131332.1489939-19-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216131332.1489939-19-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are no remaining callers of set_fs(), so CONFIG_SET_FS
> can be removed globally, along with the thread_info field and
> any references to it.
> 
> This turns access_ok() into a cheaper check against TASK_SIZE_MAX.
> 
> With CONFIG_SET_FS gone, so drop all remaining references to
> set_fs()/get_fs(), mm_segment_t and uaccess_kernel().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Sergey Matyukevich <sergey.matyukevich@synopsys.com> # for arc changes

Regards,
Sergey
