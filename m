Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A6207A5D
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405427AbgFXRfN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 13:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404908AbgFXRfN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 13:35:13 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C775EC061573;
        Wed, 24 Jun 2020 10:35:12 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so2354005qtf.6;
        Wed, 24 Jun 2020 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u71VLQWbO5DL23Y8K+qb6PrSXQwJENiQAs1O7511XBM=;
        b=GKxzqjwIPzBqXbWSXbHl7RH/IyLS+yYlLaFyGMcmoEkNl2geelNInX2hhzjL00Z7HG
         yGQV2zZSIRnXkEtNd8DyUVJiIkQ1jH+a5C8kmQ77/qsL7LLYtUg0m8nE/M0nCjfx8zho
         eawIgP2Jik4cO0z6IWfLm6aGp5C8ZiSRQDq+R9gxF7Xrg4Wu+L7o1Cjhcv0QTmZuI7Ny
         YiAI9Tvuzjf8kjOJYxFkof/jsj3qf2gamIyMO6Ak9Y22ItX4nzIm3fNmXAnazGsqZVp3
         5doNYOpwD8Mp4iQbMItGvcv5PPLdcfQNa4VOdw0HHpvow7TXhAoteneD/7r5ZRRjszzT
         R1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=u71VLQWbO5DL23Y8K+qb6PrSXQwJENiQAs1O7511XBM=;
        b=a6QOk1DWBKkbukjYDPUjFulyyNvSEjXyBZPJQ6FngNn4XPijvdedBHc4o5vvoMgCqs
         3TrNVsLhuObwn/3pOih4843C1mMtWJCMoW7ogBPSM9yvg4YlilAZqF8Zzu064nORCUNv
         1RbbAadINesdMs7sJ6SzismTgasVkRSh7rpj5SinT8FzxRaX8uyCG3Kql59aKzJtUI96
         PUy3ZO4k3TfFe+iJt7YZ7LI91Oo+IUFzcP0QnCYeacyOb4LRzumrL+9wq3nHkJobV6l7
         3DbjDv5Qk3joKdCG8RaIanCI03RWbdulm3kQ4Dr4EgCz5b4HCPmZJlRFQ9B5KMzsynmn
         /wNQ==
X-Gm-Message-State: AOAM5327p+zNshOLNiYTMze49Yu/p/gMrhVSI1eJFbAvKUPDJlZeuaaX
        PD9fQuGYrmuSaXjwmB049ng=
X-Google-Smtp-Source: ABdhPJwbxrJtgWRCE11IF50EeMFqChIYm2W1jo8Xv+ODfidD8yDrf4K4eJF8mxRsbCJyvFUCCDnWUg==
X-Received: by 2002:ac8:691:: with SMTP id f17mr7816140qth.60.1593020111983;
        Wed, 24 Jun 2020 10:35:11 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c191sm3620105qke.114.2020.06.24.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:35:11 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 24 Jun 2020 13:35:09 -0400
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
Message-ID: <20200624173509.GA1460341@rani.riverdale.lan>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-3-keescook@chromium.org>
 <20200624153930.GA1337895@rani.riverdale.lan>
 <20200624161643.73x6navnwryckuit@google.com>
 <20200624171121.GA1377921@rani.riverdale.lan>
 <20200624172620.654hhjetiyzpgoxw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624172620.654hhjetiyzpgoxw@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 10:26:20AM -0700, Fangrui Song wrote:
> 
> On 2020-06-24, Arvind Sankar wrote:
> >On Wed, Jun 24, 2020 at 09:16:43AM -0700, Fangrui Song wrote:
> >>
> >> On 2020-06-24, Arvind Sankar wrote:
> >> >On Tue, Jun 23, 2020 at 06:49:33PM -0700, Kees Cook wrote:
> >> >> When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
> >> >> and .shstrtab are listed as orphaned. Add them to the STABS_DEBUG section
> >> >> so there will be no warnings when --orphan-handling=warn is used more
> >> >> widely. (They are added above comment as it is the more common
> >> >
> >> >Nit 1: is "after .comment" better than "above comment"? It's above in the
> >> >sense of higher file offset, but it's below in readelf output.
> >>
> >> I mean this order:)
> >>
> >>    .comment
> >>    .symtab
> >>    .shstrtab
> >>    .strtab
> >>
> >> This is the case in the absence of a linker script if at least one object file has .comment (mostly for GCC/clang version information) or the linker is LLD which adds a .comment
> >>
> >> >Nit 2: These aren't actually debugging sections, no? Is it better to add
> >> >a new macro for it, and is there any plan to stop LLD from warning about
> >> >them?
> >>
> >> https://reviews.llvm.org/D75149 "[ELF] --orphan-handling=: don't warn/error for unused synthesized sections"
> >> described that .symtab .shstrtab .strtab are different in GNU ld.
> >> Since many other GNU ld synthesized sections (.rela.dyn .plt ...) can be renamed or dropped
> >> via output section descriptions, I don't understand why the 3 sections
> >> can't be customized.
> >
> >So IIUC, lld will now warn about .rela.dyn etc only if they're non-empty?
> 
> HEAD and future 11.0.0 will not warn about unused synthesized sections
> like .rela.dyn
> 
> For most synthesized sections, empty = unused.
> 
> >>
> >> I created a feature request: https://sourceware.org/bugzilla/show_bug.cgi?id=26168
> >> (If this is supported, it is a consistent behavior to warn for orphan
> >> .symtab/.strtab/.shstrtab
> >>
> >> There may be 50% chance that the maintainer decides that "LLD diverges"
> >> I would disagree: there is no fundamental problems with .symtab/.strtab/.shstrtab which make them special in output section descriptions or orphan handling.)
> >>
> >
> >.shstrtab is a little special in that it can't be discarded if the ELF
> >file contains any sections at all. But yeah, there's no reason they
> >can't be renamed or placed in a custom location in the file.
> 
> https://sourceware.org/pipermail/binutils/2020-March/000179.html
> proposes -z nosectionheader. With this option, I believe .shstrtab is
> not needed. /DISCARD/ : { *(.shstrtab) }  should achieve a similar effect.

oh wow.
