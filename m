Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2143D29CA40
	for <lists+linux-arch@lfdr.de>; Tue, 27 Oct 2020 21:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441448AbgJ0UcP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Oct 2020 16:32:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42657 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441253AbgJ0UcO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Oct 2020 16:32:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id h12so2045234qtc.9;
        Tue, 27 Oct 2020 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=03p941z578kZgGjWkKdr5ZhhMq4DqEXigALvalpK2/k=;
        b=dVEua1JxEoh8/9lwoMLb6YQ/JFHjs081cyKKPDAU8caVhL6DyTYB0f3cuQg0mXKMUS
         CHQV6OzwyTvsyXzPwiqv9+CAl9IDSE+8ocQthJFVZ+6ohyrxiywsik6H0e8eBayJTDgL
         ZL+1kk0hdTsv0yjEqg5tB+nhF1k5M+hhfA7p+554a9XZP4Y1Svki/UjLdSX5IF/LWrtY
         IkmVBfqoyhecMwRxqO8Dv7+CIFkBcgp01iuxoVyfzMFUAlHnFExmIxiQHetIr3DwTcnx
         LuUb90tJflMX+YZelaG1OTDcY4QnrM1SHhttfWIPjX6sXZaYs6Hrr0tWzw9ABDPB8hOr
         lc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=03p941z578kZgGjWkKdr5ZhhMq4DqEXigALvalpK2/k=;
        b=UoiwqLLZgyc+LeTRsj3YH5kx3Gpd9YlcKXX//98SXBBLJDGPkrHcaYKOgFUH2xyAbw
         TOLbZVBOO+nFieQS4HE6DZJ3fqyRCuTduCaSzT2LdpKSxmqG8wE1VUj56p9AvToC1eYW
         EMAWadrMip7mACUprQvqU0nY4wDazSbcwoI/YDZzX1Dhyvz7g5U5+dwPo/4JzKCvwJWE
         j9WzWzsnSHS+IX6fCd5LLAxopXrT+znunYRjvK/bP6ecSqBOqhzI/+09kCQ6CqRfNEmM
         4unAsCO416hatb8R7jUPcsQ95za2vMjpNtNW3dUqV+KLXTjleygS/ai7FwB+8RVK1lY1
         Tdqg==
X-Gm-Message-State: AOAM5327AJy6LYBxt2gX0UoyWHDuXbAWdEKLa2UhcD0lch/ZK6MfD7ha
        yDZNWh1B/5N9ximFmBfzbAY=
X-Google-Smtp-Source: ABdhPJw+/KajJAZR4KhhkToF5vEu0AJijgp+l4FeyR7nCnD6maQSWhjUbbL/XOfwYDVVkwW8AguEEg==
X-Received: by 2002:aed:3905:: with SMTP id l5mr4181349qte.366.1603830732959;
        Tue, 27 Oct 2020 13:32:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f21sm1583470qtx.68.2020.10.27.13.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:32:12 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 27 Oct 2020 16:32:10 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v6 13/29] arm64/build: Assert for unwanted sections
Message-ID: <20201027203210.GB1833548@rani.riverdale.lan>
References: <CAMuHMdUg0WJHEcq6to0-eODpXPOywLot6UD2=GFHpzoj_hCoBQ@mail.gmail.com>
 <CAMuHMdUw9KwC=EVB60yjg7mA7Fg-efOiKE7577p+uEdGJVS2OQ@mail.gmail.com>
 <CAMuHMdUJFEt3LxWHk73AsLDGhjzBvJGAML76UAxeGzb4zOf96w@mail.gmail.com>
 <CAMj1kXHXk3BX6mz6X_03sj_pSLj9Ck-=1S57tV3__N9JQOcDEw@mail.gmail.com>
 <CAMuHMdV4jKccjKkoj38EFC-5yN99pBvthFyrX81EG4GpassZwA@mail.gmail.com>
 <CAKwvOdkq3ZwW+FEui1Wtj_dWBevi0Mrt4fHa4oiMZTUZKOMi3g@mail.gmail.com>
 <CAMuHMdUDOzJbzf=0jom9dnSzkC+dkMdkyY_BOBMAivbJfF+Gmg@mail.gmail.com>
 <CAKwvOdkE=ViGOhvoBRcV=9anjowC_vb4Vtefp9010+sC4c_+Sw@mail.gmail.com>
 <CAMj1kXEhcQ_ngNVWddV76NqEz6d0tDhfStYGd5diydefzVLvdQ@mail.gmail.com>
 <CAKwvOdm9kuKoVnQoVo7T91gRb9QiCTp2G_PnwbdPM=o710Lx5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm9kuKoVnQoVo7T91gRb9QiCTp2G_PnwbdPM=o710Lx5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 27, 2020 at 01:28:02PM -0700, Nick Desaulniers wrote:
> > commit 3193c0836f203a91bef96d88c64cccf0be090d9c
> > Author: Josh Poimboeuf <jpoimboe@redhat.com>
> > Date:   Wed Jul 17 20:36:45 2019 -0500
> >
> >     bpf: Disable GCC -fgcse optimization for ___bpf_prog_run()
> >
> > has
> >
> > Fixes: e55a73251da3 ("bpf: Fix ORC unwinding in non-JIT BPF code")
> >
> > and mentions objtool and CONFIG_RETPOLINE.
> 
> Thanks for the context.  It might be time to revisit the above commit.
> If I revert it (small conflict that's easy to fixup),
> kernel/bpf/core.o builds cleanly with defconfig+GCC-9.3, so maybe
> obtool did get smart enough to handle that case?  Probably regresses
> the performance of that main dispatch loop for BPF, but not sure what
> folks are expecting when retpolines are enabled.
> -- 
> Thanks,
> ~Nick Desaulniers

The objtool issue was with RETPOLINE disabled.
