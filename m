Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFE053C657
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbiFCHgA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 03:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242363AbiFCHf7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 03:35:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A35039168;
        Fri,  3 Jun 2022 00:35:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c196so6635139pfb.1;
        Fri, 03 Jun 2022 00:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JBM1UPx7MD7sDC5BTG0YFwzdffsIeuB3hTo7qutHsEw=;
        b=Kh1fuekm7amMaXiNuuuKYLkXsnDs1AZAnv6a9G2iS8mIRL89Xv35YJw3+OfGdhr3nc
         3LO4I1jTqOkv9l09zphQkJbKYBGZFNZbglub1ZhrpObe48ODQ29cmypuAXvQD2xeVAFN
         HtYGMZzOCxsPzV1IZ2m72L2AQvkJaty226htCO7ZTUd8Ax466HzoC4y7m64KEcXFyYoE
         Tohmt1Bwr+6+oHlq9+ardkJoL2K3EA8wXTj3u734bw9nWoRORCZ2MsTmhAr2djxKS3QI
         1ZNECEfWxbqNUOoJC+ALFFRAuwmAVYEVPECp50+YBv/LWW13cxaS7DfB3S9OAoBvPJ6X
         c5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JBM1UPx7MD7sDC5BTG0YFwzdffsIeuB3hTo7qutHsEw=;
        b=E1vfjse8sfyodHsdM4gFFJnTMiUvEzwk751sSMCgcD3AppzefgWoIDi7nUqQuAU5ov
         8sNNnQPI9RT9HUT7iu8kdZ/ILfG7+6bI30O2B3FphaDFarKxN0Lkd+J2QbzrkB+RcilC
         V2Wf3yEDTJM8fUIqz+SyI9ugv6xyL2EjpgH7q6huM5Do/qLpcAC/nS1+9RHcpGUOL3ei
         YdKowNY3TKluCOiJ1YLrI/HeV2b+o11+SbZVPelek7NaaYuwi7AMs8RR06l+lwVShfeS
         cjE8Y4aWfItRe9xpCVcYEGQPAPxFPYC7cAyJireENWmdoT+r9GkAiw46GQqyMW2L/hFJ
         j3OQ==
X-Gm-Message-State: AOAM531/s8G7tVtSurBsyCxrsOZ0GHKog2Pcq/uKMXe5BmMH+JiAC6Fl
        5om3yoZDCALTV7bvx9jHxogcUx0Pwg265w==
X-Google-Smtp-Source: ABdhPJw/Bbs4xGDQ57g/rIq0w4x0Mz626cdS1aczMG3Bjpxhu5Y43xXeCzWqp5byKVGRDXDjN6baXA==
X-Received: by 2002:a63:65c7:0:b0:3fc:85b5:30c0 with SMTP id z190-20020a6365c7000000b003fc85b530c0mr7888960pgb.165.1654241758619;
        Fri, 03 Jun 2022 00:35:58 -0700 (PDT)
Received: from [192.168.43.80] (subs10b-223-255-225-236.three.co.id. [223.255.225.236])
        by smtp.gmail.com with ESMTPSA id r16-20020a635150000000b003f65560a1a7sm4559488pgl.53.2022.06.03.00.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 00:35:57 -0700 (PDT)
Message-ID: <de31731a-5cb5-ece1-6b7f-895d9c04fa95@gmail.com>
Date:   Fri, 3 Jun 2022 14:35:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V14 03/24] Documentation: LoongArch: Add basic
 documentations
Content-Language: en-US
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-4-chenhuacai@loongson.cn>
 <YplnruNz++gABlU0@debian.me>
 <CAAhV-H5Hi_gYvrO6DAGGA=OVExunCubNpDBdkRBxFxiP1APAKw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAAhV-H5Hi_gYvrO6DAGGA=OVExunCubNpDBdkRBxFxiP1APAKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/3/22 12:27, Huacai Chen wrote:
> Thank you for your testing. In my environment (sphinx_2.4.4), with or
> without the border both have no warnings. :)
> And I think these are more pretty if we keep the border, especially
> when formatted into PDF. How do you think?
> 

I think what you mean is reST table border, right?

By comparison, in Documentation/arm/booting.rst, there is a diagram
in "Setup the kernel tagged list". The diagram is written just inside
the literal code block and works fine, albeit the code block
spans fully. The diagram is small, however.

Otherwise, I see unequal padding in rendered IRQ diagrams. If I
remember correctly, the bottom and left padding are larger than top
and right padding. IDK why.

So please apply my suggestion diff.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
