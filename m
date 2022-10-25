Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D860C06C
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 03:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJYBGb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 21:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiJYBF5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 21:05:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3DDA3ABD
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 17:11:33 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id h10so7561357qvq.7
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 17:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TkJXjWEEV4IPx8IB5aoBytjP/YQvDH4AuK2z6X+NI4g=;
        b=PDOoNQUxhYaFTlb6u47Ovelh94d5tKzEWMvkYLgZp3kE5bVAP+9wrE1k8muv0yLeCp
         ldNNLmOuZDtT+gtEWYBnwsZqbRcrxgeAd0Pt0omhk4686IiT7Bjdnw/yybYlDfN7gNwM
         6SM3AsIYRJklbOtAyNOMGoKsYSu1k6hLh2Q/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkJXjWEEV4IPx8IB5aoBytjP/YQvDH4AuK2z6X+NI4g=;
        b=Z1BWatpk1zPYBJ0mJudv3ArVHxzaGH0CTZa9lxNKaUI9qH/AgyIbtepR6YEHIZj4Vq
         IWdpNgyrDI0ytcfBIfKrVR3abomUbzUjSy2dWrDdvVkadig9wfw9+J2FfRTxVoTj6AG+
         +M/vhsnwShJkN7N6heZBPitkFJ52rpAl448Kl8j1y/U9e2c1/lt80phT+e58I+JJVLrH
         s3k/9g4ZlEgTsRYqIB/h0SU4eNELtxoWpM3pzLymh6RLRB2n7oyfFm3xOuzy+si8aq3M
         imr0fdBQbxM1Y2fOSibLt7cc1SYhnhJecBvOh2Fkz1puoP3FFLRTu0r1BWz/gk8yr4Bb
         8l1A==
X-Gm-Message-State: ACrzQf1tbSXK4OlfSfEHEjQdn1C4FgsEJHwx80KWUhGlTw1t/Av9tjTt
        58XoHAK2YQq5n00Ij+bwybLioj8Kf3w0IQ==
X-Google-Smtp-Source: AMsMyM4KjN/Y4/ge+72l7Qr0K8e+M+jNv7Qh2gnShOV17pfFq4IpE81w6NDbSSZTIBiddO7i3qai1Q==
X-Received: by 2002:ad4:5ca6:0:b0:4b7:58a9:e40e with SMTP id q6-20020ad45ca6000000b004b758a9e40emr23210337qvh.113.1666656692096;
        Mon, 24 Oct 2022 17:11:32 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a448e00b006ed30a8fb21sm984673qkp.76.2022.10.24.17.11.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:11:30 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-36d2188004bso38853487b3.4
        for <linux-arch@vger.kernel.org>; Mon, 24 Oct 2022 17:11:29 -0700 (PDT)
X-Received: by 2002:a81:11d0:0:b0:35b:dd9f:5358 with SMTP id
 199-20020a8111d0000000b0035bdd9f5358mr31581502ywr.401.1666656689597; Mon, 24
 Oct 2022 17:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221024190311.65b89ecb@gandalf.local.home>
In-Reply-To: <20221024190311.65b89ecb@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 17:11:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
Message-ID: <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
Subject: Re: [RFC PATCH] text_poke/ftrace/x86: Allow text_poke() to be called
 in early boot
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 4:03 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This required some updates to fork and the maple_tree code to allow it to
> be called with enabling interrupts in the time when interrupts must remain
> disabled.

Yeah, moving special cases from one place to another doesn't really
help. Particularly to something as core as dup_mm().

All of this comes from "poking_init()" being a steaming pile of bovine
excrement, doing random odd things, and having that special
"copy_init_mm()" helper that just makes things even worse. Nothing
else uses that, and it shouldn't have called "dup_mm()" in the first
place.

At this point, there is no actual user VM to even copy, so 99% of
everything that duip_mm() does is not just pointless, but actively
wrong, like the mmap_write_lock_nested() when we're in early boot.

I'm not even sure why "poking_mm" exists at all, and why it has
created a whole new copy of "init_mm", and why this code isn't just
using '&init_mm' like everything else that wants to just walk the
kernel page tables.

Yes, I see that commit 4fc19708b165 ("x86/alternatives: Initialize
temporary mm for patching"), and no, none of that makes any sense to
me. It seems just (mis-)designed to fail.

                 Linus
