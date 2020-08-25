Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A01250D9D
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHYAeH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbgHYAeA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:34:00 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549F022BF3
        for <linux-arch@vger.kernel.org>; Tue, 25 Aug 2020 00:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598315639;
        bh=FZVk5iiXJbmA3My8loC+sCM7p8RHhlYbxo2KYPIse/o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mggVYqUIgHbDQKb/yVaAMmhrthhgWbYYBwu714YhVe9OQ2/ALMq/Cy86XMLrV9SX/
         uHsQgq2f4G38hwoV06S/mM/5jXTexbRiA/MbDFdzed59wrq9ZCjjKcezLf2jFRFip5
         yOW67xQag00gSYB+iKbRbVfU9CrDRiNoY6/71ri0=
Received: by mail-wm1-f51.google.com with SMTP id z9so607211wmk.1
        for <linux-arch@vger.kernel.org>; Mon, 24 Aug 2020 17:33:59 -0700 (PDT)
X-Gm-Message-State: AOAM531omFxZjHKEwGm8ssN/Oba1hW2bfqKK+Lg2wFI7gvN/Dp8AfuQn
        O+2+E/YkgvaK98Zzi4BvaZEsV6SnaFrHY4XQg5tktA==
X-Google-Smtp-Source: ABdhPJxs5innMByMfHrDOfrJMbYWcoGG4lrxdYWHbQ0NbBl3UqboIJUvK4aNgCRUoVaifdvLV7DHlZhHzHiKtSmebvY=
X-Received: by 2002:a1c:ba08:: with SMTP id k8mr1702940wmf.49.1598315637952;
 Mon, 24 Aug 2020 17:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200825002645.3658-1-yu-cheng.yu@intel.com> <20200825002645.3658-9-yu-cheng.yu@intel.com>
In-Reply-To: <20200825002645.3658-9-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 24 Aug 2020 17:33:46 -0700
X-Gmail-Original-Message-ID: <CALCETrWo5kNeQd=cfU647_htcDNJpVPKv2d8JqdjeLRFCb1wXA@mail.gmail.com>
Message-ID: <CALCETrWo5kNeQd=cfU647_htcDNJpVPKv2d8JqdjeLRFCb1wXA@mail.gmail.com>
Subject: Re: [PATCH v11 8/9] x86/vdso: Insert endbr32/endbr64 to vDSO
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 24, 2020 at 5:30 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> From: "H.J. Lu" <hjl.tools@gmail.com>
>
> When Indirect Branch Tracking (IBT) is enabled, vDSO functions may be
> called indirectly, and must have ENDBR32 or ENDBR64 as the first
> instruction.  The compiler must support -fcf-protection=branch so that it
> can be used to compile vDSO.
>
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Acked-by: Andy Lutomirski <luto@kernel.org>

I revoke my Ack.  Please don't repeat the list of object files.  Maybe
add the option to CFL?

--Andy
