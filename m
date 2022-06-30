Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25EC561523
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiF3Ia2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiF3Ia1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 04:30:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93C415FF7;
        Thu, 30 Jun 2022 01:30:26 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b19so9376363ljf.6;
        Thu, 30 Jun 2022 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=exmVtkdf8iqgf+gOqcF+l5gdtLPh1ijzYFebTBvenf8=;
        b=iIfgXcbDYzBCNemnPd7OR/J0GCHgV9UhPZas7D867L/xdrSGxbTwdGB/OUmDtgc5wI
         cdV9GdHKvjjEVA6/BbIGYnZdxtBBwAKhxbaNNiFuNGmTs/W3wDbOcu1sFECLZlXxMbfE
         sqq7Sr4zEQ2C3rMgvj278IOaNI3ByI5HMKqqtqm/KaOZ9VO6/XNMd4IzRTw+mKgYioDI
         OSb+YdXDV9KVToVhKhC06CoswXafYzXt5zzP1Rqt8rlJnmzAo74a9t30tErQO+QCyZsV
         hoIsMKsphgtNOL32sBbDsqMD6s7Zc4074dE8dItBbxuSwXLrKQj2aBbHpJxEMCDG58oo
         JGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=exmVtkdf8iqgf+gOqcF+l5gdtLPh1ijzYFebTBvenf8=;
        b=Lt3Gvsq3XY+xCFmapXafjy4ao2hFAZPxDu1R4D2W2z/WKvcGmSHbtlpsPJe31ZWZnf
         Qm/4L2ZPfIOaqg9NE0f0NXUY2N/bMV6oZ8MHl962QmG69zhRXpVFY3eMn84MjuHpryvv
         5qp8UkyZolZBq2r9WIOtBUy5qvUs2M0m4tfyA3ea8ch1fCppovyUt+KnWkxcjBe9OweC
         S2WOek+t6Ei5HiUR8ZDFBHbe4d7ic5EDUrGA5fDdcnKzSt4I01ZmNrworeLTYGaRUzWU
         JO6d3+aQRlCUXf6KCmxBFb4wga3jGsTffarz8UXlrAfMchzlzpQ7y6rd9VBVVAmz5k7h
         /DJw==
X-Gm-Message-State: AJIora/1iTo2ecaHtKJsm8iVZVMh93H487lEIA92eMwaL94NmKB3AxFZ
        z7jKLnbSHbV3A0t7N0P0CSxfcer/myKHBQ==
X-Google-Smtp-Source: AGRyM1vJL4x2WNhVF1KGjsBh44FWHPxqfSk7oVIEYhpdoi2ad8mJHiF7l2JKr1zIoHq+hus83xoErg==
X-Received: by 2002:a2e:9dc3:0:b0:25a:76e0:ce18 with SMTP id x3-20020a2e9dc3000000b0025a76e0ce18mr4393880ljj.451.1656577824153;
        Thu, 30 Jun 2022 01:30:24 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.87.62])
        by smtp.gmail.com with ESMTPSA id 13-20020a2eb94d000000b0025a69b43f49sm2484886ljs.21.2022.06.30.01.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 01:30:23 -0700 (PDT)
Subject: Re: [PATCH V2 0/4] mm/sparse-vmemmap: Generalise helpers and enable
 for
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
References: <20220630043237.2059576-1-chenhuacai@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <35094088-d5da-cd36-66e2-5117304c5712@gmail.com>
Date:   Thu, 30 Jun 2022 11:30:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220630043237.2059576-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

   Your subject looks unfinished...

MBR, Sergey
