Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB87343FC0
	for <lists+linux-arch@lfdr.de>; Mon, 22 Mar 2021 12:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCVLaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Mar 2021 07:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCVL3q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Mar 2021 07:29:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECE3C061756
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:29:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id g8so13555093lfv.12
        for <linux-arch@vger.kernel.org>; Mon, 22 Mar 2021 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kH80zx8fgBcaAMtcI+DPy23ounK72NEc7TVGapB9YJA=;
        b=D1EdJvVcRscbq/GBf+ctMYaojj/rUvk/UoG1MbcT1Veo9iHGl3/4IUWRf9UZ50ESk4
         WgwalH0dIBKxCHx7Tun2HU6R7nIGTQM301lhUdEfv0RZNr+Qxf+yeqWQhaVjW1L3UxtF
         uYcEZnfr/oyiYVnwK8BF5chUByqmveLjEoe5Q5bhEaPR4/sp0UKaVnuOdk26zrcNYQQ0
         Oq3wktgVevjGROiZlJKopjTIus6ycwDfgni7oSXjDrifaxutyyBPMB5yv3npEZewyHVu
         7V87JQXMbvSEsDAq3DorNQJCQtPA0Dne1WAUnBuxUirrHZppYWr0oLauShiO8CE6Nrrz
         PkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kH80zx8fgBcaAMtcI+DPy23ounK72NEc7TVGapB9YJA=;
        b=Dw9Qe3qfrousP57CB+wtP7kd9/wEe2jellUCE+ziFm/G1RXxU5We6U/FsxccVZS2ku
         3zY9X0GxIj9k2Z8Os+TbAdsWwZ+P/yxGOgDq4X1IxwtsaofbTePYom3ur7E/rSPPbjKS
         xF1KkJphDxhGVGHPLfOAyU5o4D7haMllH40TFqAYoG1N18pxcRVr2O6759duWJcs/j5E
         jTwN1xdXjLdA+lykNA3NwlwHKz7Zbmqkta127GVPpIXji2Zwo4iBWGXd6sluk9+6K7Cz
         wSCqdSA03eXbwU2Oe7/u4QbNGA2gDQ8cWOdA76H+BQRghGk00Veaaux/nZlBBsNFO3qC
         YA/Q==
X-Gm-Message-State: AOAM532fw7jZJs6SB1jO0GC10EcmAuhrP8TeY3vPfEMGBEPJccr3Qkle
        jSsdoJXxlVgg7zrjHW7oWleDfw==
X-Google-Smtp-Source: ABdhPJwf/h7V1Zqs4EwvkaaGjE8LX8cCxjQF09dWEQ51VG/y8ij9n6cohALMgfxgCr6ZmBxfpCVtjQ==
X-Received: by 2002:a19:4101:: with SMTP id o1mr8797848lfa.16.1616412584897;
        Mon, 22 Mar 2021 04:29:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p22sm1545817lfh.113.2021.03.22.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:29:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A8A02101DEB; Mon, 22 Mar 2021 14:29:51 +0300 (+03)
Date:   Mon, 22 Mar 2021 14:29:51 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 09/28] x86/mm: Introduce _PAGE_COW
Message-ID: <20210322112951.6mqjgxmkafmiavpb@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-10-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-10-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:35AM -0700, Yu-cheng Yu wrote:
> There is essentially no room left in the x86 hardware PTEs on some OSes
> (not Linux).  That left the hardware architects looking for a way to
> represent a new memory type (shadow stack) within the existing bits.
> They chose to repurpose a lightly-used state: Write=0, Dirty=1.
> 
> The reason it's lightly used is that Dirty=1 is normally set by hardware
> and cannot normally be set by hardware on a Write=0 PTE.  Software must
> normally be involved to create one of these PTEs, so software can simply
> opt to not create them.
> 
> In places where Linux normally creates Write=0, Dirty=1, it can use the
> software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY.  In other
> words, whenever Linux needs to create Write=0, Dirty=1, it instead creates
> Write=0, Cow=1, except for shadow stack, which is Write=0, Dirty=1.  This
> clearly separates shadow stack from other data, and results in the
> following:
> 
> (a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)
> (b) A R/O page that has been COW'ed: (Write=0, Cow=1)
>     The user page is in a R/O VMA, and get_user_pages() needs a writable
>     copy.  The page fault handler creates a copy of the page and sets
>     the new copy's PTE as Write=0 and Cow=1.
> (c) A shadow stack PTE: (Write=0, Dirty=1)
> (d) A shared shadow stack PTE: (Write=0, Cow=1)
>     When a shadow stack page is being shared among processes (this happens
>     at fork()), its PTE is made Dirty=0, so the next shadow stack access
>     causes a fault, and the page is duplicated and Dirty=1 is set again.
>     This is the COW equivalent for shadow stack pages, even though it's
>     copy-on-access rather than copy-on-write.
> (e) A page where the processor observed a Write=1 PTE, started a write, set
>     Dirty=1, but then observed a Write=0 PTE.  That's possible today, but
>     will not happen on processors that support shadow stack.
> 
> Define _PAGE_COW and update pte_*() helpers and apply the same changes to
> pmd and pud.
> 
> After this, there are six free bits left in the 64-bit PTE, and no more
> free bits in the 32-bit PTE (except for PAE) and Shadow Stack is not
> implemented for the 32-bit kernel.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
