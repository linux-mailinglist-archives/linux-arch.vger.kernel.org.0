Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ADC57724A
	for <lists+linux-arch@lfdr.de>; Sun, 17 Jul 2022 01:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiGPXXD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 16 Jul 2022 19:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiGPXWy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Jul 2022 19:22:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C35611826;
        Sat, 16 Jul 2022 16:21:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o15so8688919pjh.1;
        Sat, 16 Jul 2022 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Lujf1vjjpR4foXbN5bgN3Hs30sniIkF599g7wlKOBQ=;
        b=afJ5B8n3Efj0vZiNhW3XG5MYLzNKjqROPIDDKlOhtBJQzFemzmYA8ZxyKh/ydoPc2r
         VD4DkeYgmLoQIn7MzMrjhU9ysrp651Xdhdgo3hr5QfhRq8nN3ZDIzgAD7sU9e+ixBCku
         mqRNFPzOZHu/TENAPPVc3DrgFsdNxsGzxcVUXA8ZDS+IyxzJXI+AgHvY9U/8S4DhOMlI
         wdiWnFeAKtoZkRSAZ+JdbBPTAYxnqHq9/WXs86J5/SZy9G17wXVkAOnrsP2UQCLFNGsK
         4NAWACLUuoANVeMvWwZMn+JIDlWuxnEYyAS3JdAYKJdDXl4Gh3qG+hwG0AVvXPfdyPI0
         7b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Lujf1vjjpR4foXbN5bgN3Hs30sniIkF599g7wlKOBQ=;
        b=dNMe5YHqP93kKpxPCLfAtfxW+w2RpiIMyi0jZ8986H2R0mGV9/hSyzzHq5LCLMtfnd
         XDMSq3huuQV2Fh83dJiW3y1wc5ehVGkTbI4TXur5bhLUMF1M32Z0OQPdhZmH7cYhubkL
         bfzFQq4O8WO9uMF3PJRcRnj0NKv+B7HE6tYZ87LChRWauMT6k5XGdJhwRObyTPlOmLxP
         i1EZ8b1BFKL6sNvL6ZpYXoB1X95Nydn/EGgHVb7MdhEF1685Vksw6Y6y5vam3mGg7bIR
         ZqyG5MlVRMkXjnK5O3AexpfwSuMmGQNBdGST9F4Y0Aj6YLU4ORhnB0v6ZmiNSCy7R6Ta
         4J0A==
X-Gm-Message-State: AJIora+hSRb7wXKskEJtNuYs2Q+uXKFNS6MNQuKIwZc+Typ8hQpA1Jst
        h4OYGkFk3BwxmuSzdUoYayoWyBQypGE=
X-Google-Smtp-Source: AGRyM1vOzZdM3a33bUnAbTJcBI7b9OKriE+uVyKu8lm6JhHM285LWF+zuzFdz3DxaowA2HExgRCgzA==
X-Received: by 2002:a17:902:eb8e:b0:16c:5764:7dc0 with SMTP id q14-20020a170902eb8e00b0016c57647dc0mr21552372plg.63.1658013662622;
        Sat, 16 Jul 2022 16:21:02 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:22cf:30ff:fe38:5254? ([2600:8802:b00:4a48:22cf:30ff:fe38:5254])
        by smtp.googlemail.com with ESMTPSA id j6-20020a17090a318600b001ece32cbec9sm8182604pjb.24.2022.07.16.16.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 16:21:01 -0700 (PDT)
Message-ID: <846d3845-1536-3306-b68d-d0097a2ff8ff@gmail.com>
Date:   Sat, 16 Jul 2022 16:21:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] tools: Fixed MIPS builds due to struct flock
 re-definition
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, hch@lst.de,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Cc:     nathan@kernel.org, naresh.kamboju@linaro.org, heiko@sntech.de,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
References: <20220715185551.3951955-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220715185551.3951955-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 15/07/2022 à 11:55, Florian Fainelli a écrit :
> Building perf for MIPS failed after 9f79b8b72339 ("uapi: simplify
> __ARCH_FLOCK{,64}_PAD a little") with the following error:
> 
>    CC
> /home/fainelli/work/buildroot/output/bmips/build/linux-custom/tools/perf/trace/beauty/fcntl.o
> In file included from
> ../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:77,
>                   from ../include/uapi/linux/fcntl.h:5,
>                   from trace/beauty/fcntl.c:10:
> ../include/uapi/asm-generic/fcntl.h:188:8: error: redefinition of
> 'struct flock'
>   struct flock {
>          ^~~~~
> In file included from ../include/uapi/linux/fcntl.h:5,
>                   from trace/beauty/fcntl.c:10:
> ../../../../host/mipsel-buildroot-linux-gnu/sysroot/usr/include/asm/fcntl.h:63:8:
> note: originally defined here
>   struct flock {
>          ^~~~~
> 
> This is due to the local copy under
> tools/include/uapi/asm-generic/fcntl.h including the toolchain's kernel
> headers which already define 'struct flock' and define
> HAVE_ARCH_STRUCT_FLOCK to future inclusions make a decision as to
> whether re-defining 'struct flock' is appropriate or not.
> 
> Make sure what do not re-define 'struct flock'
> when HAVE_ARCH_STRUCT_FLOCK is already defined.
> 
> Fixes: 9f79b8b72339 ("uapi: simplify __ARCH_FLOCK{,64}_PAD a little")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Any chance to apply this patch prior to v5.19 being final? Thanks!
-- 
Florian
