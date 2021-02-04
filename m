Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374A730FE2B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbhBDUYK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbhBDUXg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:23:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0AC061794
        for <linux-arch@vger.kernel.org>; Thu,  4 Feb 2021 12:22:56 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z21so2926208pgj.4
        for <linux-arch@vger.kernel.org>; Thu, 04 Feb 2021 12:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=388dygswvemg3Mj3TiR7mQNJ/V6JIsMVBitRKVSrLsY=;
        b=YBxlqh3o4VbdvCSD8fiFV07eUilq+0xn80cMGEG4eVl46Gc/k3lWSMs/5g7fP5iXe1
         MHCEVDlZsBWs6S/5TBVbdo/n3Twj70ulawIUmo04ahBphIU6j6i7QJqqkR6EQp9e/h2D
         vytPtTBr/gks7MTZzAPC5ap2f0bLl9MipDB0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=388dygswvemg3Mj3TiR7mQNJ/V6JIsMVBitRKVSrLsY=;
        b=DhoBZB15T2Owo1x/Hop4Rf02Ro0OApPlzksCEsSdoLJfDQLhWkohj040Px7a0K/Ja/
         zEhYvC1vtONxdXZ/kIF5Q6tzanhEKfg9DAKZn4TW+ysRF8eN2BycpA6LAeeo5u4j/p6v
         GedV1ShMjdMbVjlEYYeWF8zTaietJ5raV6zJ6wjJ9/sUwMDB0Nfcm74VGEjc4w6i33pu
         xx/Z++v9BURs7FaQF2ZGzq/DUqJw36TlOEfpf6OxDwpjepMzr0yDGKxp2+fQhmXP/zTe
         DnHn8M72nssz8744yLYBDyV2yuscCWPe+RVWef1yiFdvVC7yaWiVRKmXz44+ZsKLqXpL
         40/Q==
X-Gm-Message-State: AOAM532msWrhJjudBevlZxXD+sehb7HSplsuKboYRNJuLFYtDFg10H6p
        T46XqDaDFFGn4aVLS18RSBoFdQ==
X-Google-Smtp-Source: ABdhPJwWgksGDBlRqYjE9XMhgf8NQ8Q9/HDu4uVh6JKJ+AthAtLYo5N1j7SLRKfmihKDYNlkwLJYqQ==
X-Received: by 2002:a63:1865:: with SMTP id 37mr738085pgy.206.1612470176112;
        Thu, 04 Feb 2021 12:22:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r194sm6560531pfr.168.2021.02.04.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:22:54 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:22:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 15/25] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <202102041222.C53C9A462@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-16-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-16-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:37PM -0800, Yu-cheng Yu wrote:
> When serving a page fault, maybe_mkwrite() makes a PTE writable if it is in
> a writable vma.  A shadow stack vma is writable, but its PTEs need
> _PAGE_DIRTY to be set to become writable.  For this reason, maybe_mkwrite()
> has been updated.
> 
> There are a few places that call pte_mkwrite() directly, but effect the
> same result as from maybe_mkwrite().  These sites need to be updated for
> shadow stack as well.  Thus, change them to maybe_mkwrite():
> 
> - do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE directly
>   and call pte_mkwrite(), which is the same as maybe_mkwrite().  Change
>   them to maybe_mkwrite().
> 
> - In do_numa_page(), if the numa entry 'was-writable', then pte_mkwrite()
>   is called directly.  Fix it by doing maybe_mkwrite().
> 
> - In change_pte_range(), pte_mkwrite() is called directly.  Replace it with
>   maybe_mkwrite().
> 
>   A shadow stack vma is writable but has different vma
> flags, and handled accordingly in maybe_mkwrite().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
