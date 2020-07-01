Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39962111FC
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jul 2020 19:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732742AbgGARcx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jul 2020 13:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbgGARcx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jul 2020 13:32:53 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2287C08C5C1
        for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2020 10:32:52 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d12so11394273qvn.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Jul 2020 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xuCr/BLFRQfPju0k5opNS+uQpQU/MMeebcyxccV+Kjs=;
        b=pO/d3N3Xg728f4WsB1qavsUXy+ZK7+q7tIJpZ2wzis1KZZD3n2gdYZmIdpvWKbRKZC
         yQ9LX2Z2PTexABsE16Unr/jZMCtppHaMvfSigdOUGY50DxoiD6uHTEr94W2R5VE1zPhA
         ws70+fx0zBPuGAtZsX+g4iByAOgveKwVEL0kJroWJEB8rjeSKnBHAdoURcjeY/v4saEB
         9ikoMAn7t+3cd9Gm5DaByasl06D/2Axa1jOVQuAk9LguSjFExqJ5euZZbAquA3S0S4Zv
         E0iZw4bK2S97VcZeQrrsXfcKlkli5N8pc/VFypcjz6TCLUdyOeupY6obkuNaagxVC6Uy
         iJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xuCr/BLFRQfPju0k5opNS+uQpQU/MMeebcyxccV+Kjs=;
        b=VWLC7HheJ7PaHFfDdP+l6fhXvCcU1LE8U0m7VUCisEMAhuZkfDXRTzPNNQBG0K0G20
         sm1b4yQzIMOGIJRgrHKd1/MB6iLIlduYzHoZ+fB54Vtm9Zwe20VoqUKyI4WRBLYd3mcd
         +XldrG2qlosSJxJAZ4TyQc8qLYDGLSr4V4+dZoGY9+KyIPAh33yTkIotZiLyZEPEz/a+
         2zuIjy2vGUE+CNIvA7Uv5FrIW0iBfROeWvuM4dT450WvwKooZbrVFpAxdYn+/As6EBQr
         Qc+naIlPbCAx9C08qElENnQ0HXlEW2S1/EUNOWtLEJp0GfHbD7DroBeMov6DMPTKjXnv
         95yw==
X-Gm-Message-State: AOAM530TJQkD/e0wrYykL/+Y74bUoyB2L7F8C4nGPvxvOG+IAJ0IP1Ys
        EHfvyLApSp7i0TE1IcM/d0MxvA==
X-Google-Smtp-Source: ABdhPJzVVqbDUHvpYLFYeLSni9YkmFljvxbDGK5K5pHm9NyYA/JF8Q5vRLzZ36Ihn+4uCU11q/5lyw==
X-Received: by 2002:a0c:b7ad:: with SMTP id l45mr22714066qve.132.1593624771735;
        Wed, 01 Jul 2020 10:32:51 -0700 (PDT)
Received: from ?IPv6:2804:7f0:8283:20c3:28c6:c7b3:e1d8:8a2f? ([2804:7f0:8283:20c3:28c6:c7b3:e1d8:8a2f])
        by smtp.gmail.com with ESMTPSA id t65sm3418141qkf.119.2020.07.01.10.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 10:32:50 -0700 (PDT)
Subject: Re: [PATCH v5 19/25] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Omair Javaid <omair.javaid@linaro.org>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-20-catalin.marinas@arm.com>
 <7fd536af-f9fa-aa10-a4c3-001e80dd7d7b@linaro.org>
 <20200701171549.GF5191@gaia>
From:   Luis Machado <luis.machado@linaro.org>
Message-ID: <8fa5c891-0f4a-c925-679e-94c41a546490@linaro.org>
Date:   Wed, 1 Jul 2020 14:32:43 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701171549.GF5191@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 7/1/20 2:16 PM, Catalin Marinas wrote:
> Hi Luis,
> 
> On Thu, Jun 25, 2020 at 02:10:10PM -0300, Luis Machado wrote:
>> I have one point below I wanted to clarify regarding
>> PEEKMTETAGS/POKEMTETAGS.
>>
>> But before that, I've pushed v2 of the MTE series for GDB here:
>>
>> https://sourceware.org/git/?p=binutils-gdb.git;a=shortlog;h=refs/heads/users/luisgpm/aarch64-mte-v2
>>
>> That series adds sctlr and gcr registers to the NT_ARM_MTE (still using a
>> dummy value of 0x407) register set. It would be nice if the Linux Kernel and
>> the debuggers were in sync in terms of supporting this new register set. GDB
>> assumes the register set exists if HWCAP2_MTE is there.
>>
>> So, if we want to adjust the register set, we should probably consider doing
>> that now. That prevents the situation where debuggers would need to do
>> another check to confirm NT_ARM_MTE is exported. I'd rather avoid that.
> 
> I'm happy to do this before merging, though we need to agree on the
> semantics.
> 
> Do you need both read and write access? Also wondering whether the

If I recall the previous discussion correctly, Kevin thought access to 
both of these would be interesting to the user. It sounded like having 
read-only access was enough. If so,...

> prctl() value would be a better option than the raw register bits (well,
> not entirely raw, masking out the irrelevant part).

... then exposing the most useful bits to the user would be better, and 
up to you to define.

I can tweak the GDB patches to turn the sctlr and gcr values into flag 
fields. Then GDB can just show those in a more meaningful way. I just 
need to know what the bits would look like.

I'd rather not make these values writable if we don't think there is a 
good use case for it. Better avoid giving developers more knobs than 
they need?
