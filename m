Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9604255014
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 22:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0Uec (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 16:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0Uec (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Aug 2020 16:34:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB54C061264;
        Thu, 27 Aug 2020 13:34:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i10so7279855iow.3;
        Thu, 27 Aug 2020 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQmZy5Fs8y3pKGibFRn4qfvS82sf5UsP9bVenOs9w8M=;
        b=TGluub3o0DcHHdpzdlkvAkCCrUrqPvYvrMKiUY7Oya5/GhcRW6Z8MtPqxBD6PQaENX
         N+tC5zt1jtp/bE8E8d4I7CsnYYGj1u1Ff/mWNGRyIaO9vFQ2WkWTcEZVkBwx7xGdCEQs
         MtyEAngQS9fnwluf2fSVj1KpNSod9p4SJw88kqHdQ0ji2ccFateEQYLoTPGeoH3TMpQs
         h8eK7kj6Yjb5dHrS7D9h6G525ntwLHMXx5WbVu/pEq4EuJKabCCXNwK4ru3qEpjNku0s
         9FjfVTc4K5pixSB2VO+ORtIpkCF0iZPoFkGEwI4XNAoz6jOtDDCpVxiGN56MokOZBCMp
         4/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQmZy5Fs8y3pKGibFRn4qfvS82sf5UsP9bVenOs9w8M=;
        b=Tj5oFmwzdtWFZheX8tmvIKIS2DLix11Fpf8c3EReKczHBYAht8cXmUMUkfcY5ECpJU
         YaK3H1tmlFa0F9HIDadRIHOR+p7hedDwmnzDoLv7CQVhUV/GtY0gh6VSJNkv3jrBvu4B
         uUXm68a8JbOyAppw3zlUaJwEFCgTWWZG9GLNTenFoX5krAk4fOlLPWk1rqm/Zw4dN34y
         TO5u2ev+biqm7f5G4F1FgglX/9avQl5tdpV9T9EX2i0dXmcRIWIUT/X1qmZfNLxd4ekd
         TRxe4JUYMfi+chvbh54UtfYXk5EOX8p0R5vri3bwF5KE11CFoy3wAdPffZVYzfclmlRt
         4TdQ==
X-Gm-Message-State: AOAM532SI9mFqgt/dEpoe2lUtYbVBCHIV9Z6eb7h78ks+iv2kzyNnYZa
        4gtK83Sw14HOBdMbdJZwT6opPUvFT1EbM7tGIoKTR54F+Mo=
X-Google-Smtp-Source: ABdhPJwio1s/8EqJEggK9yW52tIgV6weBWbp4FU34wVr0UPOM8b2uPn2IcThLM+sA4l+KLK8o42jIVY2RpTBaCnKptA=
X-Received: by 2002:a05:6638:130d:: with SMTP id r13mr20345874jad.89.1598560471002;
 Thu, 27 Aug 2020 13:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <0d2201efe3c7727f2acc718aefd7c5bb22c66c57.1588079622.git.christophe.leroy@c-s.fr>
 <87wo34tbas.fsf@mpe.ellerman.id.au> <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
 <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu> <87imd5h5kb.fsf@mpe.ellerman.id.au>
In-Reply-To: <87imd5h5kb.fsf@mpe.ellerman.id.au>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Thu, 27 Aug 2020 21:34:19 +0100
Message-ID: <CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com>
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and
 simplify __get_datapage()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello,

On Wed, 26 Aug 2020 at 15:39, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
[..]
> > arch_remap() gets replaced by vdso_remap()
> >
> > For arch_unmap(), I'm wondering how/what other architectures do, because
> > powerpc seems to be the only one to erase the vdso context pointer when
> > unmapping the vdso.
>
> Yeah. The original unmap/remap stuff was added for CRIU, which I thought
> people tested on other architectures (more than powerpc even).
>
> Possibly no one really cares about vdso unmap though, vs just moving the
> vdso.
>
> We added a test for vdso unmap recently because it happened to trigger a
> KAUP failure, and someone actually hit it & reported it.

You right, CRIU cares much more about moving vDSO.
It's done for each restoree and as on most setups vDSO is premapped and
used by the application - it's actively tested.
Speaking about vDSO unmap - that's concerning only for heterogeneous C/R,
i.e when an application is migrated from a system that uses vDSO to the one
which doesn't - it's much rare scenario.
(for arm it's !CONFIG_VDSO, for x86 it's `vdso=0` boot parameter)

Looking at the code, it seems quite easy to provide/maintain .close() for
vm_special_mapping. A bit harder to add a test from CRIU side
(as glibc won't know on restore that it can't use vdso anymore),
but totally not impossible.

> Running that test on arm64 segfaults:
>
>   # ./sigreturn_vdso
>   VDSO is at 0xffff8191f000-0xffff8191ffff (4096 bytes)
>   Signal delivered OK with VDSO mapped
>   VDSO moved to 0xffff8191a000-0xffff8191afff (4096 bytes)
>   Signal delivered OK with VDSO moved
>   Unmapped VDSO
>   Remapped the stack executable
>   [   48.556191] potentially unexpected fatal signal 11.
>   [   48.556752] CPU: 0 PID: 140 Comm: sigreturn_vdso Not tainted 5.9.0-rc2-00057-g2ac69819ba9e #190
>   [   48.556990] Hardware name: linux,dummy-virt (DT)
>   [   48.557336] pstate: 60001000 (nZCv daif -PAN -UAO BTYPE=--)
>   [   48.557475] pc : 0000ffff8191a7bc
>   [   48.557603] lr : 0000ffff8191a7bc
>   [   48.557697] sp : 0000ffffc13c9e90
>   [   48.557873] x29: 0000ffffc13cb0e0 x28: 0000000000000000
>   [   48.558201] x27: 0000000000000000 x26: 0000000000000000
>   [   48.558337] x25: 0000000000000000 x24: 0000000000000000
>   [   48.558754] x23: 0000000000000000 x22: 0000000000000000
>   [   48.558893] x21: 00000000004009b0 x20: 0000000000000000
>   [   48.559046] x19: 0000000000400ff0 x18: 0000000000000000
>   [   48.559180] x17: 0000ffff817da300 x16: 0000000000412010
>   [   48.559312] x15: 0000000000000000 x14: 000000000000001c
>   [   48.559443] x13: 656c626174756365 x12: 7865206b63617473
>   [   48.559625] x11: 0000000000000003 x10: 0101010101010101
>   [   48.559828] x9 : 0000ffff818afda8 x8 : 0000000000000081
>   [   48.559973] x7 : 6174732065687420 x6 : 64657070616d6552
>   [   48.560115] x5 : 000000000e0388bd x4 : 000000000040135d
>   [   48.560270] x3 : 0000000000000000 x2 : 0000000000000001
>   [   48.560412] x1 : 0000000000000003 x0 : 00000000004120b8
>   Segmentation fault
>   #
>
> So I think we need to keep the unmap hook. Maybe it should be handled by
> the special_mapping stuff generically.

I'll cook a patch for vm_special_mapping if you don't mind :-)

Thanks,
             Dmitry
