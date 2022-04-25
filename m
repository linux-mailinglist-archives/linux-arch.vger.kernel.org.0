Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3D50D79A
	for <lists+linux-arch@lfdr.de>; Mon, 25 Apr 2022 05:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbiDYDiD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Apr 2022 23:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiDYDhn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Apr 2022 23:37:43 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FE12CCBD
        for <linux-arch@vger.kernel.org>; Sun, 24 Apr 2022 20:34:40 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id z2so15798399oic.6
        for <linux-arch@vger.kernel.org>; Sun, 24 Apr 2022 20:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B1QfoAi5AbmZrNfgKcOMoR0g+jeoWpDUXn39NnppiO8=;
        b=RP5YQMrqRBjFc1TPzDRF/VNHpK8/m7n4dXSd/cW6Z5KUCS1IKHMEhUBJ5NZBxPSlQe
         7w69F6X6ON+ARmCOQU0idD+EYWSxMlBPBMReqAsXwbNBrW3/87epvMb6ASjFylpL/qcT
         PlQP2jiXuw8pn/O8+w35QVbGxauzbtyJro3+/mru8XCY6zwaT9g3mN7ITl336PH9kTPK
         lV7kpe0CHmxr5jjvZV36lVm345wKpfd7SjO1S5pwz+Lqc12HAHCQ+CeXXfqmxvVDi/uu
         2JS8/XRGqAInv+agUB3X6u1ASYWsrcuw+QvXWEyK0vxNdPObwZHiGre7X9RvphN4xv+E
         e8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B1QfoAi5AbmZrNfgKcOMoR0g+jeoWpDUXn39NnppiO8=;
        b=s8oA1M72hleQP22eiLlEYrGK/IwngLTRJLYm3Zw7u9IvZhHak9v48jspqG/sV9Sdgc
         XbkoCZ3ryL9585Q+uaMFQvLl0e75+ACBIlcCKb6ktODnBTxUv8Yjg6Hze0tgr0xoVNMU
         afAEkbOQvOmJLN80bPVTLRag6G3vOan7+WfQOXWpb5/IZ7/090JyJXBqkzeVAbQNa3Dh
         o1DjO1mz+nzyK2Sm7NN6+OI9aggf9eOsjZVWMG5T24+ObdzdQh6rJ47qC74py7PkBkDd
         gEVS2dpo839LxVUJQe/UM4/TziqMT62PpKPfu5XjpgJgQIU/Sw/fUjBWdaX20zcJ1QhW
         9jdQ==
X-Gm-Message-State: AOAM530i8wBd9BM8aFlupkpsYghdAIsRUYX5gMJNkjIrWn7REUsZMmwv
        XJ4HYq+BTITd3mMJ2xsMaobvyQ==
X-Google-Smtp-Source: ABdhPJxo8MI+d6zaUs6uXLuDmIBbvncR0vS1nSWd1hInEUCXQb+VfGu0cvlm09UQJgV/8onv8BD9pw==
X-Received: by 2002:a05:6808:1690:b0:325:4159:2004 with SMTP id bb16-20020a056808169000b0032541592004mr214582oib.86.1650857680070;
        Sun, 24 Apr 2022 20:34:40 -0700 (PDT)
Received: from [192.168.208.243] ([172.56.88.231])
        by smtp.gmail.com with ESMTPSA id i26-20020a4a929a000000b0033a29c8d564sm3899603ooh.3.2022.04.24.20.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 20:34:39 -0700 (PDT)
Message-ID: <ab454879-5506-fe7d-cd59-812a6bc9d193@landley.net>
Date:   Sun, 24 Apr 2022 22:38:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] binfmt_flat: Remove shared library support
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Rich Felker <dalias@libc.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, ebiederm@xmission.com,
        damien.lemoal@opensource.wdc.com, Niklas.Cassel@wdc.com,
        viro@zeniv.linux.org.uk, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, vapier@gentoo.org, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org,
        gerg@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        linux-sh@vger.kernel.org, ysato@users.sourceforge.jp
References: <87levzzts4.fsf_-_@email.froward.int.ebiederm.org>
 <mhng-32cab6aa-87a3-4a5c-bf83-836c25432fdd@palmer-ri-x1c9>
 <20220420165935.GA12207@brightrain.aerifal.cx>
 <202204201044.ACFEB0C@keescook>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <202204201044.ACFEB0C@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/20/22 12:47, Kees Cook wrote:
>> For what it's worth, bimfmt_flat (with or without shared library
>> support) should be simple to implement as a binfmt_misc handler if
>> anyone needs the old shared library support (or if kernel wanted to
>> drop it entirely, which I would be in favor of). That's how I handled
>> old aout binaries I wanted to run after aout was removed: trivial
>> binfmt_misc loader.
> 
> Yeah, I was trying to understand why systems were using binfmt_flat and
> not binfmt_elf, given the mention of elf2flat -- is there really such a
> large kernel memory footprint savings to be had from removing
> binfmt_elf?

elf2flat is a terrible name: it doesn't take an executable as input, it takes a
.o file as input. (I mean it's an elf format .o file, but... misleading.)

> But regardless, yes, it seems like if you're doing anything remotely
> needing shared libraries with binfmt_flat, such a system could just use
> ELF instead.

A) The binfmt_elf.c loader won't run on nommu systems. The fdpic loader will,
and in theory can handle normal ELF binaries (it's ELF with _more_
capabilities), but sadly it's not supported on most architectures for reasons
that are unclear to me.

B) You can't run conventional ELF on nommu, because everything is offset from 0
so PID 1 eats that address range and you can't run exec program.

You can run PIE binaries on nommu (the symbols offset from a base pointer which
can point anywhere), but they're inefficient (can't share text or rodata
sections between instances because every symbol is offset from a single shared
base pointer), and highly vulnerable to fragmentation (because it needs a
contiguous blob of memory for text, rodata, bss, and data: see single base
pointer everything has an integer offset from).

All fdpic really does is give you 4 base pointers, one for each section. That
way you can share text and rodata, and put bss and data into smaller independent
fragments of memory. Various security guys use this as super-aslr even on mmu
systems, but tend not to advertise that they're doing so. :)

Rob
