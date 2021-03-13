Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21566339D3A
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 10:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhCMJ0p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Mar 2021 04:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhCMJ0N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Mar 2021 04:26:13 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7A4C061574;
        Sat, 13 Mar 2021 01:26:13 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 18so49194010lff.6;
        Sat, 13 Mar 2021 01:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VxsRaCYGnlKyw9cBJuU8/XC7Ex+0yUqWLoNjE+h24RE=;
        b=BcDwH5ufeQE6u2QTFQIJvhO3uJvuy3848WIfNn/G0h9ttbUKPub2+zAf+Et3IQJfs9
         OuViCnfXBhhNlmSuGNocjnuJ+QOQirhB+cjma79DQLrDM6fEh/sgLzSAdHdVf1CA7eEh
         BmnzW5T5PtbGTRu7MpOamh7q4pXHNm+Ka78+RUzATw1r8A4GqZJysjPZtB6dbRQq2iug
         6RLgyDKJa6LTPqTpW8tZlK5u2saHl4kkbQyi7eQE3fHLYI638jq8tuOqukFJ9q+9s2yT
         eCsjxfdXlPgWCV6MGwFZ7Qf56v2KD2gVCFKxHDtOyZru2lqIV7TsSytk+YlDM8EvL9Bb
         dyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VxsRaCYGnlKyw9cBJuU8/XC7Ex+0yUqWLoNjE+h24RE=;
        b=PP165ZgHzVGnDNa7hYrb+5VUlwE5a5yZv5wJHFxs7CvAGuMTZF0xTTAQpQcFIjM93K
         h3AnjDJjY4SC7K9sLiDHwf/WEXc1kTmKUgMZHnrRP0cQJSoHMV5eGhYcrK14qeyazdmQ
         o1nGZzHRCk5tZWrpHwDixoElzquCQ/ysii6F9cG76ClJC1Z9fxgIcFZC+l+K89CToAVk
         Gcvyb9TpTmK2Ai9Dy5YbvZNhJ3pkfLbxcbWTUHQFtMVYaADaxIG5W4UAg9p/nJs26cXu
         o++yu+jTXr/+RuYB91yPLhR63UiFcmGbq+8qmjCprdAbSeiRt09V6Hcb+QxflYNaaWpt
         lmvA==
X-Gm-Message-State: AOAM533MxeC0TZLa6RPS8Lu+7IlGtQUuHwyWir2vspfMc4xwKxFqr3ih
        9zu/YSYPQwgndm/+zRhSp9zHBK0zipzqeQ==
X-Google-Smtp-Source: ABdhPJzcSTSqsIdnI30O1V5AQzJi6oRKcOU1zsOM6LcAktO3sTlVUFywWYUi73G8t7ARLpfhFIv/+A==
X-Received: by 2002:a19:b03:: with SMTP id 3mr2186669lfl.236.1615627571657;
        Sat, 13 Mar 2021 01:26:11 -0800 (PST)
Received: from [192.168.1.101] ([31.173.82.251])
        by smtp.gmail.com with ESMTPSA id w5sm1976524lfu.179.2021.03.13.01.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Mar 2021 01:26:11 -0800 (PST)
Subject: Re: [PATCH 5/6] ftrace: introduce FTRACE_IP_EXTENSION
To:     Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com
Cc:     Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20210313064149.29276-1-huangpei@loongson.cn>
 <20210313064149.29276-6-huangpei@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <14999d3c-ebfd-ed20-b87a-77e536a4a606@gmail.com>
Date:   Sat, 13 Mar 2021 12:26:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313064149.29276-6-huangpei@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

On 3/13/21 9:41 AM, Huang Pei wrote:

> From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
> On some architectures, the DYNAMIC_FTRACE_WITH_REGS is implemented by
> gcc's -fpatchable-function-entry option. Take arm64 for example, arm64
> makes use of GCC -fpatchable-function-entry=2 option to insert two
> nops. When the function is traced, the first nop will be modified to
> the LR saver, then the second nop to "bl <ftrace-entry>". we need to
> update ftrace_location() to recognise these two instructions  as being
> part of ftrace. To do this, we introduce FTRACE_IP_EXTENSION to let
> ftrace_location search IP, IP + FTRACE_IP_EXTENSION range.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/ftrace.h | 4 ++++
>  kernel/trace/ftrace.c  | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 1bd3a0356ae4..c1e1fbde8a04 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -20,6 +20,10 @@
>  
>  #include <asm/ftrace.h>
>  
> +#ifndef FTRACE_IP_EXTENSION
> +#define  FTRACE_IP_EXTENSION 0

   Inconsistent spacing between #<directive> and the value?

[...]

MBR, Sergei
