Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF63400989
	for <lists+linux-arch@lfdr.de>; Sat,  4 Sep 2021 06:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhIDEKL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Sep 2021 00:10:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhIDEKK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Sep 2021 00:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630728549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JsroHwqSqpHGTdfNxA5PLdxrx3L9qSi9QYjP9ozR0Rg=;
        b=H+L7ySwqzf4OL9LQrWhnLkcSR7OFfR4ok+PmG2D54kSoW/BGoUIUuIDqPvo27SHDQsq+Ur
        MW7ZOfV83g0EJwDqllMo12Y0hehP/MpVYhnABFvu2EG++gC1MzNM+jpjuyONzBodusU4wy
        n1s64ySpgVRGEwjIJ42Q57z+leKqhV8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-2DO2HLvXOCSxF1oB5F1LNQ-1; Sat, 04 Sep 2021 00:09:08 -0400
X-MC-Unique: 2DO2HLvXOCSxF1oB5F1LNQ-1
Received: by mail-oo1-f69.google.com with SMTP id w20-20020a4a7654000000b002917fdff67fso585275ooe.2
        for <linux-arch@vger.kernel.org>; Fri, 03 Sep 2021 21:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JsroHwqSqpHGTdfNxA5PLdxrx3L9qSi9QYjP9ozR0Rg=;
        b=kXAUfXY19THd6JtLmdskOvOaX0wTQwfg97qRd2d41uKczcaPaJczLggYWuBVriiLQT
         PMkmQiC3pm61VdyjZgDJHtj1Zy1Udttg8WgveFq5nAFd1pfpEzDeFYntdkMmnl4PinCV
         Kvkh/0r8tI5rXbAyQtHyoO7trnlTBDAu3Ra+BkjH6rUxoXJCEHOegyIF9v5fG3X3nIFf
         H/IYV81ecWmxfAZmOU5zNqpWKdk8w5dm1WRjda71+qOfB2F2LuSMTBaxw+RpD7/zFtWG
         vFrRD/vGYZ6+TGeDkuk6bsvxuOk0snCNk+SG6xbwK+mfBaPBFXDAA59540PyS7WvJ25U
         HYNA==
X-Gm-Message-State: AOAM5325Ki49T3i/B0Hpulxan6uCfcP/8BcOItvqR9asj/Dafpyael+j
        hBTXfqxoThzwFSqRqTeKlS+5mJ5YkMGV0L7F59PmSSeQLYyE9rk5PgPsJEirHQiHp2CjrYZye25
        qaVw2SsBkir0KLL6ybrSnTw==
X-Received: by 2002:aca:2116:: with SMTP id 22mr1480704oiz.170.1630728547336;
        Fri, 03 Sep 2021 21:09:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKG2Bhyz5Pv4rdwpFAlJhDWYZhyA5CL4ylAm5niXx52VorWmQTsjlaYrGdEv5Ldte8e6NL+w==
X-Received: by 2002:aca:2116:: with SMTP id 22mr1480685oiz.170.1630728547110;
        Fri, 03 Sep 2021 21:09:07 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id b25sm293987ooq.6.2021.09.03.21.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 21:09:06 -0700 (PDT)
Date:   Fri, 3 Sep 2021 21:09:03 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 3/4] module: Use a list of strings for ro_after_init
 sections
Message-ID: <20210904040903.tgkkoo2x76zpuj62@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-4-keescook@chromium.org>
 <20210903064951.to4dhiu7zua7s6dn@treble>
 <202109030932.1358C4093@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202109030932.1358C4093@keescook>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 03, 2021 at 09:38:42AM -0700, Kees Cook wrote:
> On Thu, Sep 02, 2021 at 11:49:51PM -0700, Josh Poimboeuf wrote:
> > On Wed, Sep 01, 2021 at 04:37:56PM -0700, Kees Cook wrote:
> > > Instead of open-coding the section names, use a list for the sections that
> > > need to be marked read-only after init. Unfortunately, it seems we can't
> > > do normal section merging with scripts/module.lds.S as ld.bfd doesn't
> > > correctly update symbol tables. For more details, see commit 6a3193cdd5e5
> > > ("kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG
> > > is enabled").
> > 
> > I'm missing what this has to do with section merging.  Can you connect
> > the dots here, i.e. what sections would we want to merge and how would
> > that help here?
> 
> Right, sorry, if ld.bfd didn't have this issue, we could use section
> merging in the module.lds.S file the way we do in vmlinux.lds:
> 
> #ifndef RO_AFTER_INIT_DATA
> #define RO_AFTER_INIT_DATA                                              \
>         . = ALIGN(8);                                                   \
>         __start_ro_after_init = .;                                      \
>         *(.data..ro_after_init)                                         \
>         JUMP_TABLE_DATA                                                 \
>         STATIC_CALL_DATA                                                \
>         __end_ro_after_init = .;
> #endif
> ...
>         . = ALIGN((align));                                             \
>         .rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {           \
>                 __start_rodata = .;                                     \
>                 *(.rodata) *(.rodata.*)                                 \
>                 SCHED_DATA                                              \
>                 RO_AFTER_INIT_DATA      /* Read only after init */      \
>                 . = ALIGN(8);                                           \
>                 __start___tracepoints_ptrs = .;                         \
>                 KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>                 __stop___tracepoints_ptrs = .;                          \
>                 *(__tracepoints_strings)/* Tracepoints: strings */      \
>         }                                                               \
> 
> Then jump_table and static_call sections could be collected into a
> new section, as the module loader would only need to look for that
> single name.

Hm, that could be a really nice way to converge things for vmlinux and
module linking.

After some digging, 6a3193cdd5e5 isn't necessarily a linker bug.  It may
be some kind of undefined behavior when the section address isn't
specified.  If you just explicitly set the section address to zero then
the "bug" goes away.

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 04c5685c25cf..80b09b7d405c 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -30,23 +30,22 @@ SECTIONS {
 
 	__patchable_function_entries : { *(__patchable_function_entries) }
 
-#ifdef CONFIG_LTO_CLANG
 	/*
 	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
 	 * -ffunction-sections, which increases the size of the final module.
 	 * Merge the split sections in the final binary.
 	 */
-	.bss : {
+	.bss 0 : {
 		*(.bss .bss.[0-9a-zA-Z_]*)
 		*(.bss..L*)
 	}
 
-	.data : {
+	.data 0 : {
 		*(.data .data.[0-9a-zA-Z_]*)
 		*(.data..L*)
 	}
 
-	.rodata : {
+	.rodata 0 : {
 		*(.rodata .rodata.[0-9a-zA-Z_]*)
 		*(.rodata..L*)
 	}
@@ -55,11 +54,10 @@ SECTIONS {
 	 * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
 	 * of the .text section, and is aligned to PAGE_SIZE.
 	 */
-	.text : ALIGN_CFI {
+	.text 0 : ALIGN_CFI {
 		*(.text.__cfi_check)
 		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
 	}
-#endif
 }
 
 /* bring in arch-specific sections */

