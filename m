Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD2410D9D
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 00:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhISW3i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Sep 2021 18:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhISW3i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2021 18:29:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A696C061574
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 15:28:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b15so40781952lfe.7
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87U5jnBgAOzelfnajLutsoz1FTU192r3A1UDUcwhN3Q=;
        b=apm0564NHpe0Ij3lCmA/KCORSOLh9QyVZMLHRPO0Sbup7u2dBpAbk7QsK3AeucHqp7
         KGuZkJie2n74JJsQlL+mEGi6Sf6TXQEEPbD3Askdz5c/Rcu4nK8MGVKsznAVoNHfgx46
         rYQh9LFEx7oTAghRL7MJYcG0Y3a9nsS77+5i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87U5jnBgAOzelfnajLutsoz1FTU192r3A1UDUcwhN3Q=;
        b=jx3CGhNgShdrO/RCvFs7jluJlpeSQf0BZFzBsDrBIl/SMc0DkM+bXbGF8L2/rWz5Gt
         5ZkPN4G1hDvdEWpVuYKBwqR2SZRvOYg5+UwpGcEi9Tr2oUlbfqEXwEb/QX7wNDUtNIQ1
         EiZAUEk5yoqi6IpvSBP2zjC7COZVXxcupa+n7nUlTGz5ZmLc87LVTnsZ7xqKnlCCbbLR
         jvPkCmVmBYf9N5X+FmdmGpvOFFlmPpY29YEeaEdPBTuFgDh4hOd9CwIcv1mhG5xYqdZS
         zXFf1rbHmOX5xoBe096cLCbjzdjNdLoVbkIU2gorZjmnseqeu0a9+b04QyBBbxpsptYA
         p8kA==
X-Gm-Message-State: AOAM531CXpxmHsghjSXNlyIKLRfOyPTmGcnFJ3x6upZQtWp/Y5vCX8wY
        OZxRPaiYGbBZq7E9ya2r4HnVw/9jESIqn/rz
X-Google-Smtp-Source: ABdhPJx8WgjMY9u626lEKJzY7B2yjOwUczmMDyRs9Las/bN+7/4Sf6FclaTQ9J3owYuePBxFSRk8jw==
X-Received: by 2002:a05:6512:32c9:: with SMTP id f9mr16268388lfg.201.1632090489880;
        Sun, 19 Sep 2021 15:28:09 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a16sm299622lfr.186.2021.09.19.15.28.08
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 15:28:08 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x27so59207281lfu.5
        for <linux-arch@vger.kernel.org>; Sun, 19 Sep 2021 15:28:08 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr17169838lfg.150.1632090487855;
 Sun, 19 Sep 2021 15:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjRrh98pZoQ+AzfWmsTZacWxTJKXZ9eKU2X_0+jM=O8nw@mail.gmail.com>
 <YUdti08rLzfDZy8S@ls3530> <CAHk-=wgKc5TY-LiAjog5VKNUQ84CSZyPu+FQekMHDar=kdSW=Q@mail.gmail.com>
 <YUeriU9EIJ5hiFjL@archlinux-ax161>
In-Reply-To: <YUeriU9EIJ5hiFjL@archlinux-ax161>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Sep 2021 15:27:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNfaf03Dw78q1qLLZs6G=iJjfo5ZTcnyXgSk3w1tp0yg@mail.gmail.com>
Message-ID: <CAHk-=wgNfaf03Dw78q1qLLZs6G=iJjfo5ZTcnyXgSk3w1tp0yg@mail.gmail.com>
Subject: Re: Odd pci_iounmap() declaration rules..
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ulrich Teichert <krypton@ulrich-teichert.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 19, 2021 at 2:28 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Commit 9caea0007601 ("parisc: Declare pci_iounmap() parisc version only
> when CONFIG_PCI enabled") causes the following build error on arm64 with
> Fedora's config, which CKI initially reported:

Ok, so I spent a lot of time trying to figure out what the heck is going on.

And while this is really *REALLY* confusing code, and nobody should
use it, I think the fix is this oneliner:

  diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
  index e93375c710b9..692e964e56b4 100644
  --- a/include/asm-generic/io.h
  +++ b/include/asm-generic/io.h
  @@ -1047,7 +1047,7 @@ extern void ioport_unmap(void __iomem *p);
   #endif /* CONFIG_GENERIC_IOMAP */
   #endif /* CONFIG_HAS_IOPORT_MAP */

  -#ifndef CONFIG_GENERIC_IOMAP
  +#ifndef CONFIG_GENERIC_PCI_IOMAP
   struct pci_dev;
   extern void __iomem *pci_iomap(struct pci_dev *dev, int bar,
unsigned long max);

let me go test, I do have an arm64 build environment for this all, but
for that commit I had only done parisc, alpha and x86-64.

           Linus
