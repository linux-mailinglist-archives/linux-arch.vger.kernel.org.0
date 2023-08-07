Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8A6772DF9
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjHGShD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 14:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjHGShC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 14:37:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2257E171A;
        Mon,  7 Aug 2023 11:37:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe48a2801bso7957831e87.1;
        Mon, 07 Aug 2023 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691433419; x=1692038219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8Yj5qVDFXyAwTzwIhUHgilERDq5+y/zb0F33+hQJss=;
        b=aC7i6pch1TzHViEGULhCEXWGI4hxO2x6M7+ndIV80XDAQwJ0tZrwKMxEKKvR9QIF0Q
         SC/zpjyjOdvLv9V5BTdm46CpIOh6ipPKDr8laEK8Hb/0MzVMDH16eyQIOLE6X3XDxoQ6
         n47m0dGkG2Bzh0oZHRyqQDLDaTlnfdDFqMtwoCcLIUmnFb+NlFlDKzCW349+3H6fFwkh
         q10K2LDvEz6z+75odwoYtFyUq4xTxKJ9IoXDo30GFHgtZI7yw2czpabwz312NZj4ft2x
         830GPizrX0eb2VfTZyAw/n8whJ6RAiHKktl27kj74swBF53oBppcCIDHW4LU0FhoZTjI
         ZQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691433419; x=1692038219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8Yj5qVDFXyAwTzwIhUHgilERDq5+y/zb0F33+hQJss=;
        b=GzAy6un6K9ywsh04A8m2PAz9cbwfmP+dPQMNKHyxYA8Pkuw34Mzpq9AJ6qqZ1NJSHB
         Q6h5sgfRPbPX5Oh6RYrpVPhPbWBcGqk+QGZC+92dK5BL6xEnrSQS6/5TDh/rRXa2g2Rk
         Ib7aO6aRDpevnwtdG32EwDwS9uZPw6UVOVgVazQ6NJND+6UTB76S/DkIoFnufYmZ6LAC
         IFMEgwFPkMrA6XcT5AE8j+i47k7DLGwQ6i/qpkpZzHRIgpWbSdBw2xIPhWZc+c+QplNI
         Oid+oZmmVe0DXPodj94+UuOCc+dN+3OByj6khf5SjKflu4mTgIseIegywvsiJI+SRkv/
         82xQ==
X-Gm-Message-State: AOJu0YworlTvzPkYIjtZp7bgW8xaVIOuy83hL+xyQkq5hFPhT805WfYM
        2upNu3OOEutzCVBM3ERO2yE=
X-Google-Smtp-Source: AGHT+IH3qxFu9sZKMc/iwCfmahwlUDyDWE0sqNuD9k9uePaao6ObXkQBAJPG9IeQt4jjirXZzaPEcg==
X-Received: by 2002:ac2:5e23:0:b0:4fb:7675:1c16 with SMTP id o3-20020ac25e23000000b004fb76751c16mr6284536lfg.49.1691433418994;
        Mon, 07 Aug 2023 11:36:58 -0700 (PDT)
Received: from f (cst-prg-21-219.cust.vodafone.cz. [46.135.21.219])
        by smtp.gmail.com with ESMTPSA id a25-20020a50ff19000000b0050488d1d376sm5523914edu.0.2023.08.07.11.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:36:58 -0700 (PDT)
Date:   Mon, 7 Aug 2023 20:36:55 +0200
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     guoren@kernel.org
Cc:     David.Laight@ACULAB.COM, will@kernel.org, peterz@infradead.org,
        mingo@redhat.com, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] asm-generic: ticket-lock: Optimize
 arch_spin_value_unlocked
Message-ID: <20230807183655.kbnjtvbi4jfrcrce@f>
References: <20230731023308.3748432-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731023308.3748432-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 30, 2023 at 10:33:08PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> The arch_spin_value_unlocked would cause an unnecessary memory
> access to the contended value. Although it won't cause a significant
> performance gap in most architectures, the arch_spin_value_unlocked
> argument contains enough information. Thus, remove unnecessary
> atomic_read in arch_spin_value_unlocked().
> 
> The caller of arch_spin_value_unlocked() could benefit from this
> change. Currently, the only caller is lockref.
> 

Have you verified you are getting an extra memory access from this in
lockref? What architecture is it?

I have no opinion about the patch itself, I will note though that the
argument to the routine is *not* the actual memory-shared lockref,
instead it's something from the local copy obtained with READ_ONCE
from the real thing. So I would be surprised if the stock routine was
generating accesses to that sucker.

Nonetheless, if the patched routine adds nasty asm, that would be nice
to sort out.

FWIW on x86-64 qspinlock is used (i.e. not the stuff you are patching)
and I verified there are only 2 memory accesses -- the initial READ_ONCE
and later cmpxchg. I don't know which archs *don't* use qspinlock.

It also turns out generated asm is quite atrocious and cleaning it up
may yield a small win under more traffic. Maybe I'll see about it later
this week.

For example, disassembling lockref_put_return:
<+0>:     mov    (%rdi),%rax            <-- initial load, expected
<+3>:     mov    $0x64,%r8d
<+9>:     mov    %rax,%rdx
<+12>:    test   %eax,%eax              <-- retries loop back here
					<-- this is also the unlocked
					    check
<+14>:    jne    0xffffffff8157aba3 <lockref_put_return+67>
<+16>:    mov    %rdx,%rsi
<+19>:    mov    %edx,%edx
<+21>:    sar    $0x20,%rsi
<+25>:    lea    -0x1(%rsi),%ecx        <-- new.count--;
<+28>:    shl    $0x20,%rcx
<+32>:    or     %rcx,%rdx
<+35>:    test   %esi,%esi
<+37>:    jle    0xffffffff8157aba3 <lockref_put_return+67>
<+39>:    lock cmpxchg %rdx,(%rdi)      <-- the attempt to change
<+44>:    jne    0xffffffff8157ab9a <lockref_put_return+58>
<+46>:    shr    $0x20,%rdx
<+50>:    mov    %rdx,%rax
<+53>:    jmp    0xffffffff81af8540 <__x86_return_thunk>
<+58>:    mov    %rax,%rdx
<+61>:    sub    $0x1,%r8d              <-- retry count check
<+65>:    jne    0xffffffff8157ab6c <lockref_put_return+12> <-- go back
<+67>:    mov    $0xffffffff,%eax
<+72>:    jmp    0xffffffff81af8540 <__x86_return_thunk>

