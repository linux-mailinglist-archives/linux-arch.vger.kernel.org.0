Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC332079F5
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405214AbgFXRL0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405156AbgFXRL0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 13:11:26 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8900C061573;
        Wed, 24 Jun 2020 10:11:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h18so1395515qvl.3;
        Wed, 24 Jun 2020 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9YWMqwXjT5S6VAJIIaXravD3PBhiNi6VxmnHUwPk58o=;
        b=T4re3FJYILiDhz9PkEeru3WH+A8mIoGMSUfmqoPylClN1ucQbubgZwRaYB//PJ1fJa
         euX9ascn/HJ4kkLOgNypOY0irZn+1ylEhqG7wpZQDUmMqD++X0xBN8IvMGiotsKaJUYA
         vtraez/F8i7l/59H6Hv4bxYueuGKEO5/sbMgRy4TG5SyWgthFeJLkMSX06lS7H43qTEB
         jNBYNPvnx3B0yKQliUd7xQI9Gm/1cYM9hE/Q6SpRUDqZDF+IEs7llywzUVDfkbw6XclN
         VWaeMysZoB4WNQXs5/R8rYxiII0emUxuktYCxwj7DnB6YfSvuYwteQvU2/6dfvkCxWV+
         7M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=9YWMqwXjT5S6VAJIIaXravD3PBhiNi6VxmnHUwPk58o=;
        b=feRHL4gUdvlRWDtg9jadNMtsYmGeto68fPkOf8/sl8J5uaRGzJlBeRvyBHtxUttuG+
         3xbQGjWl2zQaBDD/3uNbwmyhdD/i7EvlTNMmdPmkcOxg4VC2oqBZatWhaCaOc1Z2eBhU
         16VvZrcNX/W4UyxveBzcSmNGX2vXSg4e2rf083PKuIrtc1TYgOrz15v7cX8IEBYKhlqM
         Mr82R/echkMhXtiotyFBdkZKw2QMoPb/+Ox36+fBCoJAx/XE2/4LzI1GARKR+1XV/QLt
         lpAE97x1scJ4CsdNNHXdwMBzFqR6lIPA10VgBmY5IDLQHEB+7du90+ta+DgtFIAbxwew
         6iTw==
X-Gm-Message-State: AOAM5312y1pv1qZL4YmXSbuqB07AuUtooXfvGrAgRkzz8fhGovn/3K7/
        mxdcRaJOnvdg6HSexlrW/6E=
X-Google-Smtp-Source: ABdhPJzzcFnkfc+tA2tOjjPS8V3pkJ6470qOFNUn3CmU7YZPddDvdZojC2NjkoNgT0+kvlBrLxUj/A==
X-Received: by 2002:a0c:ed31:: with SMTP id u17mr30837447qvq.117.1593018683766;
        Wed, 24 Jun 2020 10:11:23 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c2sm3746366qkl.58.2020.06.24.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:11:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 24 Jun 2020 13:11:21 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] vmlinux.lds.h: Add .symtab, .strtab, and
 .shstrtab to STABS_DEBUG
Message-ID: <20200624171121.GA1377921@rani.riverdale.lan>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-3-keescook@chromium.org>
 <20200624153930.GA1337895@rani.riverdale.lan>
 <20200624161643.73x6navnwryckuit@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624161643.73x6navnwryckuit@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 09:16:43AM -0700, Fangrui Song wrote:
> 
> On 2020-06-24, Arvind Sankar wrote:
> >On Tue, Jun 23, 2020 at 06:49:33PM -0700, Kees Cook wrote:
> >> When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
> >> and .shstrtab are listed as orphaned. Add them to the STABS_DEBUG section
> >> so there will be no warnings when --orphan-handling=warn is used more
> >> widely. (They are added above comment as it is the more common
> >
> >Nit 1: is "after .comment" better than "above comment"? It's above in the
> >sense of higher file offset, but it's below in readelf output.
> 
> I mean this order:)
> 
>    .comment
>    .symtab
>    .shstrtab
>    .strtab
> 
> This is the case in the absence of a linker script if at least one object file has .comment (mostly for GCC/clang version information) or the linker is LLD which adds a .comment
> 
> >Nit 2: These aren't actually debugging sections, no? Is it better to add
> >a new macro for it, and is there any plan to stop LLD from warning about
> >them?
> 
> https://reviews.llvm.org/D75149 "[ELF] --orphan-handling=: don't warn/error for unused synthesized sections"
> described that .symtab .shstrtab .strtab are different in GNU ld.
> Since many other GNU ld synthesized sections (.rela.dyn .plt ...) can be renamed or dropped
> via output section descriptions, I don't understand why the 3 sections
> can't be customized.

So IIUC, lld will now warn about .rela.dyn etc only if they're non-empty?

> 
> I created a feature request: https://sourceware.org/bugzilla/show_bug.cgi?id=26168
> (If this is supported, it is a consistent behavior to warn for orphan
> .symtab/.strtab/.shstrtab
> 
> There may be 50% chance that the maintainer decides that "LLD diverges"
> I would disagree: there is no fundamental problems with .symtab/.strtab/.shstrtab which make them special in output section descriptions or orphan handling.)
> 

.shstrtab is a little special in that it can't be discarded if the ELF
file contains any sections at all. But yeah, there's no reason they
can't be renamed or placed in a custom location in the file.
