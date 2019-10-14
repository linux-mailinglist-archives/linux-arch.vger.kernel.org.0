Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EACD5C93
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2019 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfJNHlS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Oct 2019 03:41:18 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45479 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfJNHlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 03:41:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id x65so5791654ywf.12;
        Mon, 14 Oct 2019 00:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEN7o3yuO56xvPDuUwKgUiAGNAgWvdh9IYFyMwir9eg=;
        b=ULg0x+kVwo2eT+iIl7xEqgOGbAzw68nEs+Tf1EX6WbkwD6JZiL1PJq9RZFvkDJEthU
         ocfdC+Pu3HU8yKboyYft824CwBNxjIEzx8zyCCvt9khKX2P3rnlv1B/RrEDuwgE/1mG/
         dO9bqvuIwHg7kYFJ6cR8Rxh98z5xxnACgBkXR6UU0aSIjsvAx7CLSTrvS1W1Yc6B2hbM
         xVKkvAsHm4h5LvwOcL7O3xZNwPSbX/1EH8Ha7BFbRmH59L7FLoc17rAHr/p/fi2/0aQd
         XhR8EuPvAa5rR0cGHGbuZEBAsY6jzipW6b/VsB7pAItTeOGbyHWLGnGRGwAir0skqH6K
         QqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEN7o3yuO56xvPDuUwKgUiAGNAgWvdh9IYFyMwir9eg=;
        b=DXvyBS28aRlaI4Nm2zm9PDsokcJzfyPcLEHlYJsVU0j0RHrmAa9qEDD5zxVlK28ji4
         ml1ztiNxDpla9MB/4Fi6/e67HLH03pYAZoxK24oqgyeM2ZEFSDP9bjQEkz+e2oKC6ADc
         H1F0xnYUr1xJg21vou4jZXSwuji2q3qZYxLxyqlQ+QvbZZPNmIGO3V4zQbNXCPNHIEp6
         5Ppbyox73jtqN1nu7Y5TwwH5bE0LXwUlymUgLQm08nUaahNkm+cmln4m1l6f8zusPJnG
         rcYMWa5pswj0kfIpeeAh6h8c4ymQr0kO4s/VjnbbjHsnrNGtONPuSscQJEv3P3MeVx0T
         eb9g==
X-Gm-Message-State: APjAAAXWByfGe4yxcOb2m9/B6/Skxx0BU/08NY6/RscdEt2lLW451RjK
        F+wNl0HAM+zeC8huxgzgneyV7yaAcPAcYwgMqSU=
X-Google-Smtp-Source: APXvYqw4VB+FAxVRs0lcX+ZIr7P8ykk483BJkOe9a1ta9sipUpx8Dmb1cwz7VKpxf94e6Vopzx6wAvxttFQCwsQ1L0I=
X-Received: by 2002:a81:254d:: with SMTP id l74mr12130385ywl.409.1571038877410;
 Mon, 14 Oct 2019 00:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191011000609.29728-1-keescook@chromium.org> <20191011000609.29728-26-keescook@chromium.org>
In-Reply-To: <20191011000609.29728-26-keescook@chromium.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 14 Oct 2019 00:41:06 -0700
Message-ID: <CAMo8BfKexMmMusB3XOeaMOZHdU4ccz+PMGA=Jy+KQhgD8H_8UQ@mail.gmail.com>
Subject: Re: [PATCH v2 25/29] xtensa: Move EXCEPTION_TABLE to RO_DATA segment
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
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 5:16 PM Kees Cook <keescook@chromium.org> wrote:
>
> Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/xtensa/kernel/vmlinux.lds.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
