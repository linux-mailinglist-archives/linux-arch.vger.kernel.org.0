Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1BAB36C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2019 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfIFHnX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Sep 2019 03:43:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39908 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfIFHnX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Sep 2019 03:43:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id q12so5866296wmj.4;
        Fri, 06 Sep 2019 00:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZX+fJ6kKmFi7b0gcgOsbNpKUcKQe/PtH3be90uHqjyE=;
        b=DBy61pSG/1XAsVOzcU9tvMX/H7j1DqIdhM6+U7d5SY/qb5F1XSamjgmguFJTQ0kFwK
         9KQgI8wNVOynp1AqZhQHV6Oz3+7CsJ14jJjiP9U6o1jDfAMN2Z9K9TzyhaiW8MVXeA84
         //Ezj4d7wHT5UltLBoGdnkMyIkD7Tw/dkIe7nmOUMROpEna4dwUcq0VzShyB6fN6m0Vt
         xa66la6xpN7+B1QKEz53ShEP/+AT5WUl0hFgWnu/Sq1+6pcQjypzccUiScUlC7ZrRRxB
         U+1gGHTi/TVYUx/ucBrrhtnDwIrBpa6ntUqwBCxuRLWZx3nMn58L+4v4jBH/OSD6Aogo
         Ri5Q==
X-Gm-Message-State: APjAAAVxQlmrF4SpkakuUrugzfgFCJuxFAHZmHQZIcoltH+63j7pVqcK
        pJ2Egq320mCcyzb6yx3HS6Jd3J4r7I4=
X-Google-Smtp-Source: APXvYqzqbp+DOxBmh/9kc5bWxb4ZJbe7qWqVbnioyjb6kmRfH1ws0o+Fwcpu8EU7LpYaci6np+XSsg==
X-Received: by 2002:a1c:608b:: with SMTP id u133mr6097859wmb.27.1567755800254;
        Fri, 06 Sep 2019 00:43:20 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id k26sm4937914wmi.37.2019.09.06.00.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 00:43:19 -0700 (PDT)
Subject: Re: [PATCH v8 04/28] x86/asm/entry: annotate THUNKs
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-5-jslaby@suse.cz> <20190815124328.GG15313@zn.tnic>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b339dc02-390d-b896-5b80-ebe5f08525e8@suse.cz>
Date:   Fri, 6 Sep 2019 09:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815124328.GG15313@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 15. 08. 19, 14:43, Borislav Petkov wrote:
> On Thu, Aug 08, 2019 at 12:38:30PM +0200, Jiri Slaby wrote:
>> Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
>> Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
>> marked as aligned, use NOALIGN.
>>
>> The common tail .L_restore is put inside SYM_CODE_START_LOCAL_NOALIGN
>> and SYM_CODE_END too.
> 
> What is that needed for? It is a local label...
> 
>> The result:
>>  Value  Size Type    Bind   Vis      Ndx Name
>>   0000    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
>>   001c    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
>>   0038    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
>>   0050    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule
>>   0068    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
> 
> No difference except alignment:

Yeah, alignment is one and visual effect the other. One can immediately
see where it starts and where it ends -- readability. There is no other
functional meaning, so I don't mind not annotating it. It's your call. So?

before:

#if defined(CONFIG_TRACE_IRQFLAGS) \
 || defined(CONFIG_DEBUG_LOCK_ALLOC) \
 || defined(CONFIG_PREEMPTION)
.L_restore:
        popq %r11
        popq %r10
        popq %r9
        popq %r8
        popq %rax
        popq %rcx
        popq %rdx
        popq %rsi
        popq %rdi
        popq %rbp
        ret
        _ASM_NOKPROBE(.L_restore)
#endif

after:
#if defined(CONFIG_TRACE_IRQFLAGS) \
 || defined(CONFIG_DEBUG_LOCK_ALLOC) \
 || defined(CONFIG_PREEMPTION)
SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
        popq %r11
        popq %r10
        popq %r9
        popq %r8
        popq %rax
        popq %rcx
        popq %rdx
        popq %rsi
        popq %rdi
        popq %rbp
        ret
        _ASM_NOKPROBE(.L_restore)
SYM_CODE_END(.L_restore)
#endif


thanks,
-- 
js
suse labs
