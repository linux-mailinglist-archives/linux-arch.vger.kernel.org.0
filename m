Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD26D65D
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2019 23:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391341AbfGRVWu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Jul 2019 17:22:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43345 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfGRVWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jul 2019 17:22:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so7534749pld.10
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdDOZlpTn4tsEDqJOH4phmJ0zrEQEHyg4KDmlvGmNVA=;
        b=LTLdlUK3Md6ZrvFG+EulBWmQ3FwJnzXJvo54vza5RGr2dAoMRZx+7pfHorAfNIHatL
         GSryQO0MFwBKms7nrthEc1aJ8oTojJ8OIRHaLlcDGlXFYh1kA7wuJov3gV1Y6X7zhc54
         JkbB5ZhtAXvFJFhlAMEnGgNb9nl16egOJrn/JeH88b9g6VN1wOM5k9HYVJAHFXIPpT/2
         40/r7ITwQR4LYw0DrUscVBRArdymxkLCfvOCIInpjJRFYiur/r3HOnGalrYl7NaCG7Ka
         ftzkaXdFZ6HfwreVvS2HNSsNFyEsp9EZtnVTOQiu/4/0gWiZe6L46RaH8nZzan+BV0w1
         kNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdDOZlpTn4tsEDqJOH4phmJ0zrEQEHyg4KDmlvGmNVA=;
        b=jTxXjYAl6mC27BxzlukqPC5iMgmlOZtW8rryApylj2bJ9gCt8RCFsdCkCXu9bhaaA9
         t8DxkvhEdWOqKJK2LJe9h0bR2TIwTFq8mOs8e5hlb6Dv00w3RA53vVoV26o4st5gD6dq
         Ex8JqKSTaAJYZbnrxAFbZtIZ/EYaoV7FHnsVaeLRNQZ84lN3VOdykWpYrtAuYLiAkJ2Z
         +zhHztSeaqR9Bhf5dEtc5fUP+6/Eta0gnNhmZUH9QH90tkcK6i/YWPwvQ0LNfzjbLHeu
         0GiHznDYr8IxX6f8mfqlsqtlrXwU4dsf2vtg8Gvno08jkDj7GSHPdt5rG8jhgmfg0+Uk
         ftPA==
X-Gm-Message-State: APjAAAXW5isMMfYrCNL8a9zrn2Vzt+FJS/sDxqoUZGwCh/RyAc/6TF8V
        10Kg2PDJW9IINpvB7F0zsTUqD/w8HTjnpWvd9jXpJA==
X-Google-Smtp-Source: APXvYqz4/mrNtv3D/O8uy5y5EJlbbJzblE+CppPnjFgR0gR3LQFlKRNWWtKFH+3RZRUW3eIbWFu/KdTLkmmiip5eWD0=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr51485175pls.179.1563484968978;
 Thu, 18 Jul 2019 14:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <1562959401-19815-1-git-send-email-cai@lca.pw> <20190712.154606.493382088615011132.davem@davemloft.net>
 <EFD25845-097A-46B1-9C1A-02458883E4DA@lca.pw> <20190712.175038.755685144649934618.davem@davemloft.net>
 <D7E57421-A6F4-4453-878A-8F173A856296@lca.pw> <CAKwvOdkCfqfpJYYX+iu2nLCUUkeDorDdVP3e7koB9NYsRwgCNw@mail.gmail.com>
 <CAGG=3QWkgm+YhC=TWEWwt585Lbm8ZPG-uFre-kBRv+roPzZFbA@mail.gmail.com>
In-Reply-To: <CAGG=3QWkgm+YhC=TWEWwt585Lbm8ZPG-uFre-kBRv+roPzZFbA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 14:22:38 -0700
Message-ID: <CAKwvOd=B=Lj-hTtbe88bo89wLxJrDAsm3fJisSMD=hKkRHf6zw@mail.gmail.com>
Subject: Re: [PATCH] be2net: fix adapter->big_page_size miscaculation
To:     Bill Wendling <morbo@google.com>
Cc:     Qian Cai <cai@lca.pw>, James Y Knight <jyknight@google.com>,
        David Miller <davem@davemloft.net>, sathya.perla@broadcom.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, netdev@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 18, 2019 at 2:18 PM Bill Wendling <morbo@google.com> wrote:
>
> Top-of-tree clang says that it's const:
>
> $ gcc a.c -O2 && ./a.out
> a is a const.
>
> $ clang a.c -O2 && ./a.out
> a is a const.

Right, so I know you (Bill) did a lot of work to refactor
__builtin_constant_p handling in Clang and LLVM in the
pre-llvm-9-release timeframe.  I suspect Qian might not be using
clang-9 built from source (as clang-8 is the current release) and thus
observing differences.

>
> On Thu, Jul 18, 2019 at 2:10 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>>
>> On Thu, Jul 18, 2019 at 2:01 PM Qian Cai <cai@lca.pw> wrote:
>> >
>> >
>> >
>> > > On Jul 12, 2019, at 8:50 PM, David Miller <davem@davemloft.net> wrote:
>> > >
>> > > From: Qian Cai <cai@lca.pw>
>> > > Date: Fri, 12 Jul 2019 20:27:09 -0400
>> > >
>> > >> Actually, GCC would consider it a const with -O2 optimized level because it found that it was never modified and it does not understand it is a module parameter. Considering the following code.
>> > >>
>> > >> # cat const.c
>> > >> #include <stdio.h>
>> > >>
>> > >> static int a = 1;
>> > >>
>> > >> int main(void)
>> > >> {
>> > >>      if (__builtin_constant_p(a))
>> > >>              printf("a is a const.\n");
>> > >>
>> > >>      return 0;
>> > >> }
>> > >>
>> > >> # gcc -O2 const.c -o const
>> > >
>> > > That's not a complete test case, and with a proper test case that
>> > > shows the externalization of the address of &a done by the module
>> > > parameter macros, gcc should not make this optimization or we should
>> > > define the module parameter macros in a way that makes this properly
>> > > clear to the compiler.
>> > >
>> > > It makes no sense to hack around this locally in drivers and other
>> > > modules.
>> >
>> > If you see the warning in the original patch,
>> >
>> > https://lore.kernel.org/netdev/1562959401-19815-1-git-send-email-cai@lca.pw/
>> >
>> > GCC definitely optimize rx_frag_size  to be a constant while I just confirmed clang
>> > -O2 does not. The problem is that I have no clue about how to let GCC not to
>> > optimize a module parameter.
>> >
>> > Though, I have added a few people who might know more of compilers than myself.
>>
>> + Bill and James, who probably knows more than they'd like to about
>> __builtin_constant_p and more than other LLVM folks at this point.
>>
>> --
>> Thanks,
>> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
