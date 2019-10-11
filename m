Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20B7D3A4C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfJKHuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 03:50:01 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36760 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJKHuA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Oct 2019 03:50:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so7199318oto.3;
        Fri, 11 Oct 2019 00:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9x3/cDB6PwQR0s+Phj11ZK3bUY2nRE9yOnXorXSrffA=;
        b=Ll2lCJMdFu/joamcvFefwNkKU0iuaDD/PWg2CSIXA9BieBZC9RAmuBjl/xFcVVCBPV
         m73Ik23xKj/NFcQtwlTfmaLF4rpmsmXwkXkR3eHay5BoXSvSA6A9n8m8DU5O7O/4k3yJ
         fJmAz4H33ZjW/dxtjC+vZXXv9XwEZo1unNX+MnGcqhdNquhQBOWFQf+CJnbRFuLZu2h3
         UnJ0fsoAaq5cvem1g+Hod6xy3lkfce6r6CrV7fWvOE5BDhx1csvIT5rua0U9rKZdyaiD
         mNAih3eYqwvTp5ze58QXZy3Me+cgDi8VS9SNGsA6B8H2zM44/Xv1lzOo48+hTpYzulH/
         pkbA==
X-Gm-Message-State: APjAAAXpMmjKRDzcTb8xL3bLGxoIYUdyRvvw4YYVevm3dED93S02CPNq
        ELcLqss5xP3ewI8am4zfpQKYBk269uNxmKsp07Q=
X-Google-Smtp-Source: APXvYqzJCUSr68IdNnXRm+PcuWp7xfU4DRvosjpGQ70mELArtPXAo+zUfEKqQC0cweLEsachiHT5ajqOtTTMdIKhbv4=
X-Received: by 2002:a05:6830:1685:: with SMTP id k5mr11303222otr.250.1570780198260;
 Fri, 11 Oct 2019 00:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-13-keescook@chromium.org>
In-Reply-To: <20191011000609.29728-13-keescook@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Oct 2019 09:49:47 +0200
Message-ID: <CAMuHMdW24azYFyoYwsYZKG685KS+a1H6L3v96BVcG2uBJoqnLw@mail.gmail.com>
Subject: Re: [PATCH v2 12/29] vmlinux.lds.h: Replace RO_DATA_SECTION with RO_DATA
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 2:07 AM Kees Cook <keescook@chromium.org> wrote:
> Finish renaming RO_DATA_SECTION to RO_DATA. (Calling this a "section"
> is a lie, since it's multiple sections and section flags cannot be
> applied to the macro.)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

>  arch/m68k/kernel/vmlinux-nommu.lds  | 2 +-

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
