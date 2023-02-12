Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496A2693927
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 18:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBLRio (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 12:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBLRin (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 12:38:43 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9E11655;
        Sun, 12 Feb 2023 09:38:42 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-142b72a728fso12820794fac.9;
        Sun, 12 Feb 2023 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gEc3d6k45zjDeEZHbol4IIwzjmxqM4mBWgDI31Sfc5o=;
        b=R330sse/EVLRGFL0igafPWieDgvfGLbUv1mxwjjJZAHpBvZcU2/Gg7Ye7o55WJDp/T
         d/MkHSIY+rV5WmpmEtSQ3EcpkVyHgH/g8WGwdicgdAr8s7fVYzB3M6AQYSXN1fWO7dsD
         adnG3ljI9LKreMS0IYacGj+zm2/uKWOjveyAMeTbeBXzAlA0+lDjE38oWr0kFL4x/3pl
         NtGAiadx3cotdBgXvBg6mFyqYNavUvZnDTVR9OSu3hxj7Glcs0NmbhgPuh+/V46P8f0N
         UAStFFymZhcq+751kC0Xe8LgThvdTeD+HxCq3F5UGXwSHXYBMgqQ0gCOk/Vyqx7W2YhY
         u2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gEc3d6k45zjDeEZHbol4IIwzjmxqM4mBWgDI31Sfc5o=;
        b=ygc+2RF4TvpiW/hPMWIZlZVXXSRhs+ldt2ZMQlnA6Nvcl4Qvk23AaIHeYN127sq/Ne
         3K6tXPeGYS+vNzqoLsbGCKAhvaxuzYG1r1xT5sC7MSjFnikwS91/vjV67CgZpeIMVWbw
         VBPUVK73gMMeJVeJ7peholiK4Wn3O+rxXBxh/ZADNLx3lTtHEa7qVihEm8mBQ4tPem71
         YX3TBTOp5Hjk/MfUOfAzdb8NORg3lO4Xb+0YtgA2iAt2z1Kbh7U2pIFwaUm6VqK8O9c/
         n++4uSb8H8JSrEWYli83aN0qJLW7VatOtq4XcG9F+psBOTm6pe7f1372BRvFMVgK3Q8V
         HqTQ==
X-Gm-Message-State: AO0yUKVU9aF+I7fryGfCKnlkAivd54Cp0/B3/haEj5uxf7qtEc5vg8bp
        9cEGyNwCUbPe4xE5ZGD/0ls=
X-Google-Smtp-Source: AK7set/4d6sAa3sFADK7k8Ny8wL2J6QT+VlS2G9nj4JhFjRiy2CF6KFV2p0y673SokHVHJOuHdHtkw==
X-Received: by 2002:a05:6870:2885:b0:16e:a65:3b8e with SMTP id gy5-20020a056870288500b0016e0a653b8emr473342oab.9.1676223521592;
        Sun, 12 Feb 2023 09:38:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n40-20020a056870822800b0013bc95650c8sm4012885oae.54.2023.02.12.09.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 09:38:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <64f2ba37-d869-0160-1a89-d7f15d243d05@roeck-us.net>
Date:   Sun, 12 Feb 2023 09:38:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/4] mm, arch: add generic implementation of
 pfn_valid() for FLATMEM
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-5-rppt@kernel.org>
 <20230212161320.GA3784076@roeck-us.net> <Y+kTHsaq8FAG72CX@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y+kTHsaq8FAG72CX@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2/12/23 08:26, Mike Rapoport wrote:
> Hi Guenter,
> 
> On Sun, Feb 12, 2023 at 08:13:20AM -0800, Guenter Roeck wrote:
>> On Sun, Jan 29, 2023 at 02:42:35PM +0200, Mike Rapoport wrote:
>>> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>>>
>>> Every architecture that supports FLATMEM memory model defines its own
>>> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>>>
>>> Use mips/powerpc version implemented as static inline as a generic
>>> implementation of pfn_valid() and drop its per-architecture definitions.
>>>
>>
>> With this patch in the tree, sh4 and sh4eb qemu emulations no longer boot.
>> Reverting this patch fixes the problem.
>   
> Can you please test with only partial revert for arch/sh?
> 

Sure, that works as well.

Guenter

