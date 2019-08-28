Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3AA00EF
	for <lists+linux-arch@lfdr.de>; Wed, 28 Aug 2019 13:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfH1Lra (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Aug 2019 07:47:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfH1Lr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 07:47:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so2208204wrr.0;
        Wed, 28 Aug 2019 04:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=s5bb3kICAB9XvHBh7Ix2rUt9EKmbt9kaj+v0AQarEQQ=;
        b=uU095mRU8VFAMH28+OVRIs+6Hwjn/Ms7DrNk6KOHcoeh1cwTxYuwcmv+DuSoVoZLGH
         WXjn+WXnj844Bv1M9Dc5lihCp4NGsqQ8xqsok1su4UjD4qnk3tvYl8mwZbEpyBuMiqEr
         6CKeYlW9fo7nqD8cTy4HsKqrWFNffxOw8iKfe+QHMKzMmmCZ53vHow5TEhCZh3nSVsBv
         KyfbBDn4+nsFkSi0uqtXTiSp8+3DmLzUuDMz6yQbP3mtogiOKNB14UvZK0+0hfx6eIc2
         YX161YJyNT3L9SkIE3QHPCzU6qqs9pAy/QLQz+IuucclqsNISppKZC63JzhVPBbwGmod
         iykg==
X-Gm-Message-State: APjAAAULMYCwi88AtUrDTbivs4bAgyktMV5/CjHPXwWuk5RV0SomgFjB
        rkXCnisvQ/7hcc7zjim37hQzjPJD
X-Google-Smtp-Source: APXvYqwii3MFDP3V1NSf06L55W8yqhoLZDhmO3GZJmYmqs5MJOlY7DczI89v4h6b2KiPYHtHlhP0PA==
X-Received: by 2002:adf:fc87:: with SMTP id g7mr4069584wrr.319.1566992847143;
        Wed, 28 Aug 2019 04:47:27 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id z8sm2405822wmi.7.2019.08.28.04.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 04:47:25 -0700 (PDT)
Subject: Asm & local labels for functions [was: [PATCH v8 05/28] x86/asm:
 annotate local pseudo-functions]
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-6-jslaby@suse.cz> <20190815160719.GI15313@zn.tnic>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 mQINBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABtBtKaXJpIFNsYWJ5
 IDxqc2xhYnlAc3VzZS5jej6JAjgEEwECACIFAk6S6NgCGwMGCwkIBwMCBhUIAgkKCwQWAgMB
 Ah4BAheAAAoJEL0lsQQGtHBJgDsP/j9wh0vzWXsOPO3rDpHjeC3BT5DKwjVN/KtP7uZttlkB
 duReCYMTZGzSrmK27QhCflZ7Tw0Naq4FtmQSH8dkqVFugirhlCOGSnDYiZAAubjTrNLTqf7e
 5poQxE8mmniH/Asg4KufD9bpxSIi7gYIzaY3hqvYbVF1vYwaMTujojlixvesf0AFlE4x8WKs
 wpk43fmo0ZLcwObTnC3Hl1JBsPujCVY8t4E7zmLm7kOB+8EHaHiRZ4fFDWweuTzRDIJtVmrH
 LWvRDAYg+IH3SoxtdJe28xD9KoJw4jOX1URuzIU6dklQAnsKVqxz/rpp1+UVV6Ky6OBEFuoR
 613qxHCFuPbkRdpKmHyE0UzmniJgMif3v0zm/+1A/VIxpyN74cgwxjhxhj/XZWN/LnFuER1W
 zTHcwaQNjq/I62AiPec5KgxtDeV+VllpKmFOtJ194nm9QM9oDSRBMzrG/2AY/6GgOdZ0+qe+
 4BpXyt8TmqkWHIsVpE7I5zVDgKE/YTyhDuqYUaWMoI19bUlBBUQfdgdgSKRMJX4vE72dl8BZ
 +/ONKWECTQ0hYntShkmdczcUEsWjtIwZvFOqgGDbev46skyakWyod6vSbOJtEHmEq04NegUD
 al3W7Y/FKSO8NqcfrsRNFWHZ3bZ2Q5X0tR6fc6gnZkNEtOm5fcWLY+NVz4HLaKrJuQINBE6S
 54YBEADPnA1iy/lr3PXC4QNjl2f4DJruzW2Co37YdVMjrgXeXpiDvneEXxTNNlxUyLeDMcIQ
 K8obCkEHAOIkDZXZG8nr4mKzyloy040V0+XA9paVs6/ice5l+yJ1eSTs9UKvj/pyVmCAY1Co
 SNN7sfPaefAmIpduGacp9heXF+1Pop2PJSSAcCzwZ3PWdAJ/w1Z1Dg/tMCHGFZ2QCg4iFzg5
 Bqk4N34WcG24vigIbRzxTNnxsNlU1H+tiB81fngUp2pszzgXNV7CWCkaNxRzXi7kvH+MFHu2
 1m/TuujzxSv0ZHqjV+mpJBQX/VX62da0xCgMidrqn9RCNaJWJxDZOPtNCAWvgWrxkPFFvXRl
 t52z637jleVFL257EkMI+u6UnawUKopa+Tf+R/c+1Qg0NHYbiTbbw0pU39olBQaoJN7JpZ99
 T1GIlT6zD9FeI2tIvarTv0wdNa0308l00bas+d6juXRrGIpYiTuWlJofLMFaaLYCuP+e4d8x
 rGlzvTxoJ5wHanilSE2hUy2NSEoPj7W+CqJYojo6wTJkFEiVbZFFzKwjAnrjwxh6O9/V3O+Z
 XB5RrjN8hAf/4bSo8qa2y3i39cuMT8k3nhec4P9M7UWTSmYnIBJsclDQRx5wSh0Mc9Y/psx9
 B42WbV4xrtiiydfBtO6tH6c9mT5Ng+d1sN/VTSPyfQARAQABiQIfBBgBAgAJBQJOkueGAhsM
 AAoJEL0lsQQGtHBJN7UQAIDvgxaW8iGuEZZ36XFtewH56WYvVUefs6+Pep9ox/9ZXcETv0vk
 DUgPKnQAajG/ViOATWqADYHINAEuNvTKtLWmlipAI5JBgE+5g9UOT4i69OmP/is3a/dHlFZ3
 qjNk1EEGyvioeycJhla0RjakKw5PoETbypxsBTXk5EyrSdD/I2Hez9YGW/RcI/WC8Y4Z/7FS
 ITZhASwaCOzy/vX2yC6iTx4AMFt+a6Z6uH/xGE8pG5NbGtd02r+m7SfuEDoG3Hs1iMGecPyV
 XxCVvSV6dwRQFc0UOZ1a6ywwCWfGOYqFnJvfSbUiCMV8bfRSWhnNQYLIuSv/nckyi8CzCYIg
 c21cfBvnwiSfWLZTTj1oWyj5a0PPgGOdgGoIvVjYXul3yXYeYOqbYjiC5t99JpEeIFupxIGV
 ciMk6t3pDrq7n7Vi/faqT+c4vnjazJi0UMfYnnAzYBa9+NkfW0w5W9Uy7kW/v7SffH/2yFiK
 9HKkJqkN9xYEYaxtfl5pelF8idoxMZpTvCZY7jhnl2IemZCBMs6s338wS12Qro5WEAxV6cjD
 VSdmcD5l9plhKGLmgVNCTe8DPv81oDn9s0cIRLg9wNnDtj8aIiH8lBHwfUkpn32iv0uMV6Ae
 sLxhDWfOR4N+wu1gzXWgLel4drkCJcuYK5IL1qaZDcuGR8RPo3jbFO7Y
Message-ID: <c5e0f683-796c-f552-0c3b-8a1105446200@suse.cz>
Date:   Wed, 28 Aug 2019 13:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815160719.GI15313@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 15. 08. 19, 18:07, Borislav Petkov wrote:
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -283,7 +283,7 @@ ENTRY(early_idt_handler_array)
>  		UNWIND_HINT_IRET_REGS offset=8
>  	.endif
>  	pushq $i		# 72(%rsp) Vector number
> -	jmp early_idt_handler_common
> +	jmp .Learly_idt_handler_common
>  	UNWIND_HINT_IRET_REGS
>  	i = i + 1
>  	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
> @@ -291,7 +291,7 @@ ENTRY(early_idt_handler_array)
>  	UNWIND_HINT_IRET_REGS offset=16
>  END(early_idt_handler_array)
>  
> -SYM_CODE_START_LOCAL(early_idt_handler_common)
> +SYM_CODE_START_LOCAL(.Learly_idt_handler_common)
>  	/*
>  	 * The stack is the hardware frame, an error code or zero, and the
>  	 * vector number.
> @@ -333,7 +333,7 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
>  20:
>  	decl early_recursion_flag(%rip)
>  	jmp restore_regs_and_return_to_kernel
> -SYM_CODE_END(early_idt_handler_common)
> +SYM_CODE_END(.Learly_idt_handler_common)

...

> All except this one can be local labels and be removed from vmlinux'
> symtable:
> 
> $ readelf -a vmlinux | grep -E "(bad_(gs|(get|put)_user)|bogus_64_magic|early_idt_handler_common|verify_cpu)"
>     45: ffffffff810000e0   241 FUNC    LOCAL  DEFAULT    1 verify_cpu
> $

Thanks for all the review hints.

Let's start with this one: do you really want me to get rid of (local)
symbols like this? It would make backtraces completely misleading as the
unwinder would put a name of the previous function (or some garbage,
depending on unwinder) into the backtrace...

thanks,
-- 
js
suse labs
