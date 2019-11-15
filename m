Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B1AFDE9A
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2019 14:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKONLK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Nov 2019 08:11:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34883 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKONLK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Nov 2019 08:11:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id q13so6665950pff.2
        for <linux-arch@vger.kernel.org>; Fri, 15 Nov 2019 05:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=VdF8MMu+bP4e0rsVfdQpCfgpPGQbFW5Ll/rpGu4Pq10=;
        b=Jn5lFI/f8wVcj9sHWruYQfb/Eeq9z4tdOzYGpmkvxX7Tae6JoQRWzJRhSsjsfng2Uo
         V2U+XvpdhwQ5jdNrVAvLN/n4yvCWp3p4KoX+/Lq6YtsVLwZJSdwC+n8BnlrRSvEMTxiP
         6RPMtKW8787++U21euvzijpFqHwM3CtkVoEhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VdF8MMu+bP4e0rsVfdQpCfgpPGQbFW5Ll/rpGu4Pq10=;
        b=e/Ev9kzZ9qvQXCifYRwYjDS5O1jsffz/pjuBp3tsn4xtO4soHh1BDb8DFkte2LyNky
         ad0e/C9AuqN57f0ZZYs61kW+O6fwPPiJmwhxSZxaw9tU5kPBIYv0vC2cTGK+kTBQfJLe
         lTsNvbiuBnX+lgXa2MTSRyOr9a8mvxloQYbVNT1HfaijuJnWzLngToAkn29P/W10D2Mg
         BgpN2G9eEVknrfJDgn+PGD927QRJhOMCjP6WiuKEjf1Bue7t1i3iUOZb/xvkYKN3/9OG
         jBg+fNILMcg8r36rPngu7u5W5Tj3NdlsFL3vzI3yFGJ5KG6lf03oW/ja5v84K1cRQWz/
         Ohrw==
X-Gm-Message-State: APjAAAUmVRPvtRiR+sU7gR8A8gzcD7xRiFp9ACAiq5qILE/cPFGf550b
        gRF+J6luu3/UOXq0bBMoXAR2nA==
X-Google-Smtp-Source: APXvYqwjS1Ph0MWCRDZcAnOkeAb5th9CJ6963WKqiajxypv1u6VDdP6icoztl/u3rGq4zV6UWWidjA==
X-Received: by 2002:a62:6044:: with SMTP id u65mr17331024pfb.227.1573823468977;
        Fri, 15 Nov 2019 05:11:08 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-f1d8-c2a6-5354-14d8.static.ipv6.internode.on.net. [2001:44b8:1113:6700:f1d8:c2a6:5354:14d8])
        by smtp.gmail.com with ESMTPSA id y16sm11164122pfo.62.2019.11.15.05.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:11:07 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Marco Elver <elver@google.com>
Cc:     christophe.leroy@c-s.fr, linux-s390@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with generic bitops
In-Reply-To: <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net> <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
Date:   Sat, 16 Nov 2019 00:11:03 +1100
Message-ID: <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> test_bit() is an atomic bitop. I assume it was meant to be in
> instrumented-atomic.h?

Hmm, interesting.

I was tricked by the generic version doing just a simple read, with only
a volatile attribute to ensure the read occurs more-or-less as written:

/**
 * test_bit - Determine whether a bit is set
 * @nr: bit number to test
 * @addr: Address to start counting from
 */
static inline int test_bit(int nr, const volatile unsigned long *addr)
{
        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
}

But the docs do seem to indicate that it's atomic (for whatever that
means for a single read operation?), so you are right, it should live in
instrumented-atomic.h.

Sadly, only x86 and s390 specify an arch_test_bit, which will make moving it
into instumented-atomic.h break powerpc :(

I'll have a crack at something next week, probably with a similar trick
to arch_clear_bit_unlock_is_negative_byte.

Regards,
Daniel


>
> Thanks,
> -- Marco
>
>> >> +
>> >> +#endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>> >> --
>> >> 2.20.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/878sp57z44.fsf%40dja-thinkpad.axtens.net.
